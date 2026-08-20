#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

as_character <- function(x) as.character(unlist(x, use.names = FALSE))
clone_object <- function(x) unserialize(serialize(x, NULL))

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

paths <- list(
  interface = file.path(
    repository_root, "model_redesign", "essential_input_interfaces",
    "n4_r1_unanimity_candidate_v2.json"
  ),
  ledger = file.path(
    repository_root, "model_redesign", "essential_input_n4_claim_ledger_v2.json"
  ),
  cold_note = file.path(
    repository_root, "model_redesign",
    "essential_input_n4_r1_unanimity_cold_notes_v2.md"
  ),
  derivation = file.path(
    repository_root, "model_redesign",
    "essential_input_n4_r1_unanimity_derivation_v2.md"
  ),
  build = file.path(repository_root, "scripts", "build_essential_input_n4_v2.R"),
  boundary = file.path(
    repository_root, "scripts", "test_essential_input_n4_v2_boundaries.R"
  ),
  integration = file.path(
    repository_root, "scripts", "test_essential_input_n4_v2_integration.R"
  ),
  negative = file.path(
    repository_root, "scripts", "test_essential_input_n4_v2_negative.R"
  ),
  n2 = file.path(
    repository_root, "model_redesign", "essential_input_n2_r2_unanimity_interface.json"
  ),
  dag = file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
)

expected_hashes <- c(
  interface = "67dc008a42db6d6c7f7c12eb3abf9fd7eb4a273a73ca0ec6f4a1ece180320c0b",
  ledger = "c8152c8bf333540a7e7312c9d839b210c50c985f837c237d218ee70c6a314c53",
  cold_note = "057dee6cb50aa5f4ceba5432b82b7f84672522ea79b53bb6b72929d4768dc102",
  derivation = "7869db1aac1c04a9b06a147c02e0195d95b4d912be15bc72eba145fa472f1fe9",
  build = "4b1c09874ff193678f5e3b8572b106acd66bf49c4c505faef97cd64ae3180aa1",
  boundary = "266efb0c68f332cdb105bdc5dd668b74463e45d991f301c96d275ac93ed07ed4",
  integration = "1240da6899dba7a95a0ba43de2c9e6790dc2afa63d428c137d23439d535b0dfc",
  negative = "2f0b0312510f070d94860f1df9bf5c9f34be5a22ce931af7d7970bd2d9d34e83",
  n2 = "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
)
n2_hash <- paste0("sha256:", expected_hashes[["n2"]])

sha256_file <- function(path) {
  shasum <- Sys.which("shasum")
  assert_true(nzchar(shasum), "The 'shasum' executable is required.")
  output <- system2(
    shasum, c("-a", "256", path), stdout = TRUE, stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(lines) == 1L, paste("Could not hash", path))
  hash <- strsplit(lines[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

read_utf8 <- function(path, label) {
  assert_true(file.exists(path), paste("Missing", label, "at", path))
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  text <- rawToChar(bytes)
  assert_true(validUTF8(text), paste(label, "must be valid UTF-8."))
  text
}

for (name in names(paths)) {
  read_utf8(paths[[name]], name)
}
for (name in names(expected_hashes)) {
  assert_true(
    identical(sha256_file(paths[[name]]), expected_hashes[[name]]),
    paste("N4 v2 frozen candidate component changed:", name)
  )
}

interface_text <- read_utf8(paths$interface, "N4 v2 interface")
ledger_text <- read_utf8(paths$ledger, "N4 v2 ledger")
cold_text <- read_utf8(paths$cold_note, "N4 v2 cold note")
derivation_text <- read_utf8(paths$derivation, "N4 v2 derivation")
build_text <- read_utf8(paths$build, "N4 v2 build script")

canonical_interface <- jsonlite::fromJSON(paths$interface, simplifyVector = FALSE)
canonical_ledger <- jsonlite::fromJSON(paths$ledger, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(paths$dag, simplifyVector = FALSE)
n2 <- jsonlite::fromJSON(paths$n2, simplifyVector = FALSE)

validate_interface <- function(candidate) {
  assert_true(identical(candidate, canonical_interface),
              "Interface differs from the canonical validated correspondence.")
  invisible(TRUE)
}

validate_ledger <- function(candidate) {
  assert_true(identical(candidate, canonical_ledger),
              "Ledger differs from the canonical validated claim set.")
  invisible(TRUE)
}

validate_text <- function(candidate, canonical, label) {
  assert_true(identical(candidate, canonical), paste(label, "text changed."))
  invisible(TRUE)
}

expect_error <- function(expression, label) {
  failed <- FALSE
  tryCatch(
    force(expression),
    error = function(e) failed <<- TRUE
  )
  assert_true(failed, paste("Negative mutation was not rejected:", label))
}

collect_leaf_paths <- function(x, path = list(), label = "root") {
  if (!is.list(x) || length(x) == 0L) {
    return(setNames(list(path), label))
  }
  output <- list()
  object_names <- names(x)
  for (index in seq_along(x)) {
    named <- !is.null(object_names) && nzchar(object_names[[index]])
    key <- if (named) object_names[[index]] else index
    child_label <- if (named) paste0(label, ".", key) else paste0(label, "[[", index, "]]" )
    output <- c(output, collect_leaf_paths(x[[index]], c(path, list(key)), child_label))
  }
  output
}

get_path_value <- function(x, path) {
  value <- x
  for (key in path) value <- value[[key]]
  value
}

set_path_value <- function(x, path, value) {
  key <- path[[1L]]
  if (length(path) == 1L) {
    x[[key]] <- value
    return(x)
  }
  x[[key]] <- set_path_value(x[[key]], path[-1L], value)
  x
}

mutated_value <- function(value) {
  if (is.null(value)) return("__MUTATED_NULL__")
  if (is.character(value)) return(paste0(value, " [MUTATED]"))
  if (is.logical(value)) return(!value)
  if (is.numeric(value)) return(value + 1)
  if (is.list(value) && length(value) == 0L) return(list("__MUTATED_EMPTY__"))
  stop("Unsupported mutation leaf type.", call. = FALSE)
}

mutate_token <- function(text, token) {
  assert_true(grepl(token, text, fixed = TRUE), paste("Missing mutation token:", token))
  sub(token, paste0(token, "__MUTATED__"), text, fixed = TRUE)
}

# Independent structural checks against the live Gate-0 schema and lifecycle.
assert_true(
  identical(names(canonical_interface), c("schema_ref", "function_of", "correspondence_cells")) &&
    identical(canonical_interface$schema_ref, "equilibrium_correspondence_v1") &&
    identical(canonical_interface$function_of, list(name = "entry_belief", domain = "[0,1]")),
  "Wrong N4 v2 envelope."
)

node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids
assert_true(
  identical(nodes$N2$status, "pass") && identical(nodes$N2$frozen, TRUE) &&
    identical(nodes$N2$artifact_hash, n2_hash) && identical(nodes$N2$interface, n2),
  "Exact pass/frozen N2 is not live."
)
assert_true(
  identical(names(nodes$N4), c("id", "name", "round", "institution", "depends_on", "status", "interface")) &&
    identical(nodes$N4$status, "pending") &&
    identical(as_character(nodes$N4$depends_on), "N2") &&
    is.null(nodes$N4$interface$correspondence_cells),
  "N4 shared-DAG lifecycle changed."
)

record_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$record_fields)
h_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$hegemon_payoff_by_type_fields)
outcome_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$outcome_distribution_fields)
expected_cells <- c(
  "N4V2-CELL-M2-NU0", "N4V2-CELL-M2-LOW", "N4V2-CELL-M2-HIGH",
  "N4V2-CELL-MGE3-NU0", "N4V2-CELL-MGE3-LOW", "N4V2-CELL-MGE3-HIGH"
)
expected_equilibria <- sub("CELL", "EQ", expected_cells, fixed = TRUE)
cells <- canonical_interface$correspondence_cells
assert_true(
  identical(vapply(cells, `[[`, character(1), "cell_id"), expected_cells) &&
    length(unique(expected_cells)) == 6L,
  "Six-cell partition is incomplete."
)

for (index in seq_along(cells)) {
  cell <- cells[[index]]
  assert_true(
    identical(names(cell), c(
      "cell_id", "domain_conditions", "existence_status",
      "equilibrium_records", "nonexistence_certificate"
    )) &&
      identical(cell$existence_status, "exists") &&
      length(cell$equilibrium_records) == 1L && is.null(cell$nonexistence_certificate),
    paste("Bad coverage cell", cell$cell_id)
  )
  record <- cell$equilibrium_records[[1L]]
  assert_true(
    identical(names(record), record_fields) &&
      identical(record$equilibrium_id, expected_equilibria[[index]]) &&
      identical(names(record$hegemon_payoff_by_type), h_fields) &&
      identical(names(record$outcome_distribution), outcome_fields),
    paste("Bad atomic record", record$equilibrium_id)
  )
  assert_true(
    identical(record$source_continuation_record_ids,
              list("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")) &&
      identical(record$source_interface_hashes, list(N2 = n2_hash)),
    paste("Bad continuation provenance", record$equilibrium_id)
  )
  strategy <- record$strategy_profile
  expected_security <- if (index <= 3L) "S_2=max{F,K,M}" else "S_m=min{P,D}"
  assert_true(identical(strategy$exact_proposer_security$formula, expected_security),
              paste("Bad security formula", record$equilibrium_id))
  assert_true(
    identical(
      strategy$frozen_continuation$weak_realized_payoff_by_theta_after_one_discount$low_type_only,
      list(theta_0 = "a", theta_1 = "0")
    ) &&
      identical(strategy$pooling_family$support_conditions[[2L]], "x_ij>=b for every j!=i") &&
      identical(strategy$low_type_only_family$Y_projection$interval, "[ell,h)") &&
      identical(strategy$delay_family$Y_projection$interval, "[0,y_bar]"),
    paste("Bad accounting or support map", record$equilibrium_id)
  )
  assert_true(
    identical(record$outcome_distribution$pass_without_hegemon, "0") &&
      identical(record$outcome_distribution$failure, "0"),
    paste("Bad R1-event outcome semantics", record$equilibrium_id)
  )
  reporting <- strategy$nu0_reporting
  assert_true(
    identical(reporting$empty_category_value,
              list(status = "not_applicable", reason = "category_empty")) &&
      grepl("omitted", reporting$empty_category_evaluation, fixed = TRUE) &&
      grepl("zero", reporting$empty_category_evaluation, fixed = TRUE),
    paste("Bad empty-category reporting", record$equilibrium_id)
  )
  for (branch_name in c("high_type_only", "reverse_H_separation_inside_delay")) {
    certificate <- strategy$branch_candidate_coverage[[branch_name]]$none_certificate
    assert_true(
      length(certificate$ledger_claim_ids) > 0L &&
        length(certificate$assumptions_used) > 0L &&
        length(certificate$checks_performed) > 0L,
      paste("Incomplete none certificate", branch_name, record$equilibrium_id)
    )
  }
}

assert_true(
  identical(names(canonical_ledger), c(
    "ledger_schema", "node_id", "artifact_path", "artifact_hash",
    "node_status", "claims"
  )) &&
    identical(canonical_ledger$ledger_schema, "essential_input_claim_ledger_v1") &&
    identical(canonical_ledger$node_id, "N4") &&
    identical(canonical_ledger$artifact_hash, paste0("sha256:", expected_hashes[["interface"]])) &&
    identical(canonical_ledger$node_status, "pending_independent_review"),
  "Bad N4 v2 ledger envelope."
)
claim_ids <- vapply(canonical_ledger$claims, `[[`, character(1), "claim_id")
assert_true(
  identical(claim_ids, sprintf("N4V2-CLM-%03d", 1:18)) &&
    length(unique(claim_ids)) == 18L,
  "Bad N4 v2 claim ledger enumeration."
)
for (claim in canonical_ledger$claims) {
  assert_true(identical(claim$status, "proved"), paste("Unproved claim", claim$claim_id))
  linked_ids <- as_character(claim$equilibrium_ids)
  assert_true(length(linked_ids) > 0L && all(linked_ids %in% expected_equilibria),
              paste("Bad equilibrium links", claim$claim_id))
}

# Required formula families must be present in both the sealed derivation and
# the executable source, and obsolete security formulas must not enter the
# candidate interface.
derivation_tokens <- c(
  "S_m=min{P,D}",
  "S_2 = max{F,K,M}",
  "F   = 1-h-a",
  "K   = min{b,(1-nu)*R_L}",
  "M   = min{P,D}",
  "Y in [h,U_P)",
  "B_M = [S=M=D<P]",
  "B_K = [S=K=(1-nu)*R_L<b]",
  "Y in [ell,h)",
  "it exists iff `C>=F`",
  "L/D at nu=0",
  "P/D at nu>nu_star",
  "reason:\"category_empty\"",
  "failure=0"
)
build_tokens <- c(
  "formula = \"S_m=min{P,D}\"",
  "formula = \"S_2=max{F,K,M}\"",
  "F = \"1-h-a\"",
  "K = \"min{b,(1-nu)*R_L}\"",
  "M = \"min{P,D}\"",
  "constant_on_path_weak_floor",
  "B_M = \"S=M=D<P\"",
  "B_K = \"S=K=(1-nu)*R_L<b\"",
  "interval = \"[ell,h)\"",
  "exists iff C>=F; none iff C<F",
  "category_empty",
  "full Cartesian product"
)
for (token in derivation_tokens) {
  assert_true(grepl(token, derivation_text, fixed = TRUE),
              paste("Derivation formula family missing:", token))
}
for (token in build_tokens) {
  assert_true(grepl(token, build_text, fixed = TRUE),
              paste("Build formula family missing:", token))
}
assert_true(
  !grepl("old m>=3 support: (1-nu)*b", interface_text, fixed = TRUE) &&
    !grepl("old m=2 support", interface_text, fixed = TRUE),
  "Obsolete N4 security entered the canonical interface."
)

# Every leaf mutation of either canonical JSON artifact must fail exact
# validation. This complements the semantic fixtures with byte-level coverage.
interface_paths <- collect_leaf_paths(canonical_interface)
for (label in names(interface_paths)) {
  path <- interface_paths[[label]]
  fixture <- clone_object(canonical_interface)
  fixture <- set_path_value(fixture, path, mutated_value(get_path_value(fixture, path)))
  expect_error(validate_interface(fixture), paste("interface", label))
}

ledger_paths <- collect_leaf_paths(canonical_ledger)
for (label in names(ledger_paths)) {
  path <- ledger_paths[[label]]
  fixture <- clone_object(canonical_ledger)
  fixture <- set_path_value(fixture, path, mutated_value(get_path_value(fixture, path)))
  expect_error(validate_ledger(fixture), paste("ledger", label))
}

# Directed formula mutations cover the derivation, cold record, and build
# source independently of the generated JSON mutation sweep.
formula_mutations <- 0L
for (token in derivation_tokens) {
  fixture <- mutate_token(derivation_text, token)
  expect_error(validate_text(fixture, derivation_text, "derivation"),
               paste("derivation token", token))
  formula_mutations <- formula_mutations + 1L
}
for (token in build_tokens) {
  fixture <- mutate_token(build_text, token)
  expect_error(validate_text(fixture, build_text, "build"),
               paste("build token", token))
  formula_mutations <- formula_mutations + 1L
}
cold_tokens <- c(
  "COLD_DERIVATION_SEALED",
  "S_m=min{P,D}",
  "S_2=max{F,K,M}",
  "value is at least `b`",
  "{status: \"not_applicable\", reason: \"category_empty\"}"
)
for (token in cold_tokens) {
  fixture <- mutate_token(cold_text, token)
  expect_error(validate_text(fixture, cold_text, "cold note"),
               paste("cold token", token))
  formula_mutations <- formula_mutations + 1L
}

run_R_script <- function(path, extra_args = character()) {
  output <- system2(
    "Rscript", c("--vanilla", path, extra_args),
    stdout = TRUE, stderr = TRUE
  )
  status <- attr(output, "status")
  if (is.null(status)) status <- 0L
  assert_true(
    identical(as.integer(status), 0L),
    paste("Subcheck failed:", path, paste(output, collapse = "\n"))
  )
  assert_true(any(grepl("PASS:", output, fixed = TRUE)),
              paste("Subcheck did not emit PASS:", path))
  invisible(output)
}

run_R_script(paths$build, "--check")
run_R_script(paths$boundary)
run_R_script(paths$integration)
run_R_script(paths$negative)

cat("PASS: N4 v2 candidate verification\n")
cat("interface_sha256=", expected_hashes[["interface"]], "\n", sep = "")
cat("ledger_sha256=", expected_hashes[["ledger"]], "\n", sep = "")
cat("cold_note_sha256=", expected_hashes[["cold_note"]], "\n", sep = "")
cat("derivation_sha256=", expected_hashes[["derivation"]], "\n", sep = "")
cat("interface_leaf_mutations=", length(interface_paths), "\n", sep = "")
cat("ledger_leaf_mutations=", length(ledger_paths), "\n", sep = "")
cat("formula_mutations=", formula_mutations, "\n", sep = "")
