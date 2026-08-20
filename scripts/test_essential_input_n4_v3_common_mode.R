#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the common-mode-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "lib_essential_input_n4_v3_semantic_validator.R"))

candidate_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v3.json"
)
ledger_path <- file.path(
  repository_root, "model_redesign", "essential_input_n4_claim_ledger_v3.json"
)
builder_path <- file.path(repository_root, "scripts", "build_essential_input_n4_v3.R")

candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
builder_text <- paste(readLines(builder_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

baseline_errors <- n4v3_validate_candidate_semantics(candidate, ledger, builder_text)
assert_true(length(baseline_errors) == 0L,
            paste("Baseline semantic validator failed:", paste(baseline_errors, collapse = " | ")))

replace_recursive <- function(object, from, to) {
  if (is.list(object)) return(lapply(object, replace_recursive, from = from, to = to))
  if (is.character(object)) return(gsub(from, to, object, fixed = TRUE))
  object
}

manifest_lines <- function(object, artifact) {
  coverage <- n4v3_audit_path_coverage(object, artifact)
  assert_true(coverage$valid, paste0("Mutation created an uncovered ", artifact, " path."))
  paste(coverage$leaves$category, coverage$leaves$path, coverage$leaves$value, sep = "\t")
}

baseline_candidate_manifest <- manifest_lines(candidate, "candidate")
baseline_ledger_manifest <- manifest_lines(ledger, "ledger")

run_string_mutation <- function(label, from, to) {
  assert_true(grepl(from, paste(n4v3_character_values(candidate), collapse = "\n"), fixed = TRUE),
              paste0("Candidate fixture not found for ", label, "."))
  assert_true(grepl(from, builder_text, fixed = TRUE),
              paste0("Builder fixture not found for ", label, "."))
  mutated_candidate <- replace_recursive(candidate, from, to)
  mutated_ledger <- replace_recursive(ledger, from, to)
  mutated_builder <- gsub(from, to, builder_text, fixed = TRUE)

  # Recomputing these manifests simulates a coordinated update of the
  # candidate, builder, and structural expected object. Structural equality
  # alone would therefore pass; the independent semantic layer must reject.
  expected_candidate_after_mutation <- manifest_lines(mutated_candidate, "candidate")
  expected_ledger_after_mutation <- manifest_lines(mutated_ledger, "ledger")
  assert_true(!identical(expected_candidate_after_mutation, baseline_candidate_manifest),
              paste0("Mutation did not alter the candidate manifest: ", label))
  if (!identical(mutated_ledger, ledger)) {
    assert_true(!identical(expected_ledger_after_mutation, baseline_ledger_manifest),
                paste0("Mutation did not alter the ledger manifest: ", label))
  }

  errors <- n4v3_validate_candidate_semantics(
    mutated_candidate, mutated_ledger, mutated_builder
  )
  assert_true(length(errors) > 0L,
              paste0("Common-mode mutation escaped semantic validation: ", label))
  invisible(errors)
}

# Domain/frontier.
run_string_mutation(
  "nu_star denominator",
  "nu_star=(o_1-o_0)/(1-o_0); ell=beta*o_0; h=beta*o_1; A=beta*(1-o_0)/m; B=beta*(1-o_1)/m",
  "nu_star=(o_1-o_0)/(1-o_1); ell=beta*o_0; h=beta*o_1; A=beta*(1-o_0)/m; B=beta*(1-o_1)/m"
)

# Ballot-map order.
run_string_mutation(
  "T^Y before stage-undominance",
  "eliminate weakly dominated actions before sequential best response and T^Y",
  "apply T^Y before stage-undominance and sequential best response"
)

# Guarantees and attainment.
run_string_mutation(
  "m>=3 security",
  "S_3(nu)=(1-nu)*B",
  "S_3(nu)=min{1-h-(m-1)*B,(1-nu)*A}"
)
run_string_mutation(
  "m>=3 attainment",
  "attained maximum guarantee",
  "nonattained supremum"
)
run_string_mutation(
  "m=2 R_L endpoint",
  "at equality or below only a supremum",
  "at equality it is attained and below it is a supremum"
)

# Families and exact delay boundary.
run_string_mutation(
  "m=2 delay boundary",
  "exists iff C>=S_2; none iff C<S_2",
  "exists for every admissible parameter vector"
)

# Beliefs.
run_string_mutation(
  "Bayes at positive-probability failures",
  "every positive-probability failure vector uses Bayes",
  "every positive-probability failure vector may use an arbitrary posterior"
)

# H payoffs.
run_string_mutation(
  "low-region H0 delay payoff",
  "rho_P*bar_Y_P+rho_D*ell",
  "rho_P*bar_Y_P+rho_D*h"
)

# Multiplicity.
run_string_mutation(
  "identity Cartesian product",
  "The full Cartesian product across identities is retained.",
  "A single symmetric identity assignment is retained."
)

# Outcome leaves require a targeted object mutation because the scalar "0"
# appears in many legitimate fields. The builder and simulated expected object
# are changed in the same direction.
mutated_outcome <- candidate
for (cell_index in seq_along(mutated_outcome$correspondence_cells)) {
  mutated_outcome$correspondence_cells[[cell_index]]$equilibrium_records[[1L]]$
    outcome_distribution$failure <- "1"
}
mutated_builder_outcome <- gsub(
  'failure = "0", delay = "rho_D"',
  'failure = "1", delay = "rho_D"',
  builder_text,
  fixed = TRUE
)
assert_true(!identical(manifest_lines(mutated_outcome, "candidate"), baseline_candidate_manifest),
            "Outcome mutation did not alter the simulated expected manifest.")
outcome_errors <- n4v3_validate_candidate_semantics(
  mutated_outcome, ledger, mutated_builder_outcome
)
assert_true(length(outcome_errors) > 0L,
            "Common-mode outcome mutation escaped semantic validation.")

cat("PASS: N4 v3 path coverage and common-mode semantic mutations\n")
