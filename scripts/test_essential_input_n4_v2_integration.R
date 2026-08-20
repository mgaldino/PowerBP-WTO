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

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the integration-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

interface_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v2.json"
)
ledger_path <- file.path(
  repository_root, "model_redesign", "essential_input_n4_claim_ledger_v2.json"
)
n2_path <- file.path(
  repository_root, "model_redesign", "essential_input_n2_r2_unanimity_interface.json"
)
dag_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
build_path <- file.path(repository_root, "scripts", "build_essential_input_n4_v2.R")

n2_hash_bare <- "c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2"
n2_hash <- paste0("sha256:", n2_hash_bare)

sha256_file <- function(path) {
  output <- system2(
    "shasum", c("-a", "256", path), stdout = TRUE, stderr = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  lines <- grep("^[0-9a-f]{64}[[:space:]]", output, value = TRUE)
  assert_true(length(lines) == 1L, paste("Could not hash", path))
  strsplit(lines[[1L]], "[[:space:]]+")[[1L]][1L]
}

read_utf8 <- function(path, label) {
  assert_true(file.exists(path), paste("Missing", label, "at", path))
  bytes <- readBin(path, what = "raw", n = file.info(path)$size)
  text <- rawToChar(bytes)
  assert_true(validUTF8(text), paste(label, "must be valid UTF-8."))
  invisible(text)
}

for (item in list(
  c(interface_path, "N4 v2 interface"),
  c(ledger_path, "N4 v2 ledger"),
  c(n2_path, "frozen N2 interface"),
  c(dag_path, "game DAG"),
  c(build_path, "N4 v2 build script")
)) {
  read_utf8(item[[1L]], item[[2L]])
}

assert_true(identical(sha256_file(n2_path), n2_hash_bare), "Frozen N2 bytes changed.")

candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
ledger <- jsonlite::fromJSON(ledger_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
n2 <- jsonlite::fromJSON(n2_path, simplifyVector = FALSE)

# Schema and lifecycle remain exactly those declared by Gate 0.
assert_true(
  identical(names(candidate), c("schema_ref", "function_of", "correspondence_cells")),
  "N4 v2 changed the top-level equilibrium-correspondence schema."
)
assert_true(identical(candidate$schema_ref, "equilibrium_correspondence_v1"),
            "N4 v2 uses the wrong schema_ref.")
assert_true(
  identical(candidate$function_of, list(name = "entry_belief", domain = "[0,1]")),
  "N4 v2 changed the function_of topology."
)

node_ids <- vapply(dag$nodes, `[[`, character(1), "id")
nodes <- dag$nodes
names(nodes) <- node_ids
assert_true(
  identical(names(nodes$N4), c("id", "name", "round", "institution", "depends_on", "status", "interface")),
  "N4 lifecycle fields were added or removed."
)
assert_true(
  identical(nodes$N4$status, "pending") &&
    identical(as_character(nodes$N4$depends_on), "N2") &&
    identical(nodes$N4$interface$schema_ref, "equilibrium_correspondence_v1") &&
    is.null(nodes$N4$interface$correspondence_cells),
  "Candidate implementation mutated N4 lifecycle or the shared DAG interface."
)
assert_true(
  identical(nodes$N2$status, "pass") && identical(nodes$N2$frozen, TRUE) &&
    identical(nodes$N2$artifact_hash, n2_hash) && identical(nodes$N2$interface, n2),
  "N4 v2 is not linked to exact pass/frozen N2."
)

record_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$record_fields)
h_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$hegemon_payoff_by_type_fields)
outcome_fields <- as_character(dag$interface_schemas$equilibrium_correspondence_v1$outcome_distribution_fields)

expected_cells <- c(
  "N4V2-CELL-M2-NU0",
  "N4V2-CELL-M2-LOW",
  "N4V2-CELL-M2-HIGH",
  "N4V2-CELL-MGE3-NU0",
  "N4V2-CELL-MGE3-LOW",
  "N4V2-CELL-MGE3-HIGH"
)
expected_equilibria <- sub("CELL", "EQ", expected_cells, fixed = TRUE)
actual_cells <- vapply(candidate$correspondence_cells, `[[`, character(1), "cell_id")
assert_true(identical(actual_cells, expected_cells), "N4 v2 cell partition changed.")
assert_true(length(unique(actual_cells)) == 6L, "N4 v2 cell IDs are not unique.")

all_records <- list()
for (cell_index in seq_along(candidate$correspondence_cells)) {
  cell <- candidate$correspondence_cells[[cell_index]]
  assert_true(
    identical(names(cell), c(
      "cell_id", "domain_conditions", "existence_status",
      "equilibrium_records", "nonexistence_certificate"
    )),
    paste("Wrong coverage-cell schema in", cell$cell_id)
  )
  assert_true(identical(cell$existence_status, "exists"),
              paste("Pooling should make", cell$cell_id, "nonempty."))
  assert_true(length(cell$equilibrium_records) == 1L && is.null(cell$nonexistence_certificate),
              paste("Wrong top-level existence envelope in", cell$cell_id))
  record <- cell$equilibrium_records[[1L]]
  all_records[[length(all_records) + 1L]] <- record
  assert_true(identical(names(record), record_fields),
              paste("Wrong atomic record schema in", record$equilibrium_id))
  assert_true(identical(record$equilibrium_id, expected_equilibria[[cell_index]]),
              paste("Wrong equilibrium ID in", cell$cell_id))
  assert_true(identical(names(record$hegemon_payoff_by_type), h_fields),
              paste("Wrong H payoff keys in", record$equilibrium_id))
  assert_true(identical(names(record$outcome_distribution), outcome_fields),
              paste("Wrong outcome keys in", record$equilibrium_id))
  assert_true(
    identical(record$source_continuation_record_ids,
              list("N2-EQ-LOW-TYPE-ONLY", "N2-EQ-POOLING")) &&
      identical(record$source_interface_hashes, list(N2 = n2_hash)),
    paste("Wrong continuation provenance in", record$equilibrium_id)
  )
  assert_true(
    identical(record$outcome_distribution$pass_without_hegemon, "0") &&
      identical(record$outcome_distribution$failure, "0"),
    paste("N4 R1-event outcome semantics changed in", record$equilibrium_id)
  )
  assert_true(
    grepl("exactly once", record$payoff_date, fixed = TRUE),
    paste("Missing exactly-once discount date in", record$equilibrium_id)
  )
  assumptions_text <- paste(as_character(record$assumptions_used), collapse = " ")
  assert_true(
    grepl("derived by P4", assumptions_text, fixed = TRUE) &&
      grepl("not imposed as an assessment restriction", assumptions_text, fixed = TRUE) &&
      !grepl("weak-vote-passive assessment:", assumptions_text, fixed = TRUE),
    paste("P4 was imposed instead of derived in", record$equilibrium_id)
  )
  strategy <- record$strategy_profile
  assert_true(
    identical(names(strategy), c(
      "frozen_continuation", "derived_quantities", "exact_proposer_security",
      "ballot_response_map_after_every_feasible_proposal",
      "branch_candidate_coverage", "pooling_family", "low_type_only_family",
      "delay_family", "proposal_mixing", "proposer_identity_completion",
      "nu0_reporting", "downstream_transport"
    )),
    paste("Incomplete strategy-profile closure in", record$equilibrium_id)
  )
  assert_true(
    identical(
      strategy$frozen_continuation$weak_realized_payoff_by_theta_after_one_discount$low_type_only,
      list(theta_0 = "a", theta_1 = "0")
    ),
    paste("Corrected N2 low-only vector missing in", record$equilibrium_id)
  )
  assert_true(
    grepl("global minimum is the constant b", strategy$frozen_continuation$weak_voter_subjective_value, fixed = TRUE) &&
      grepl("This subjective floor is not D", strategy$frozen_continuation$weak_voter_subjective_value, fixed = TRUE),
    paste("Subjective-versus-realized distinction missing in", record$equilibrium_id)
  )
  assert_true(
    grepl("two published failure vectors", strategy$ballot_response_map_after_every_feasible_proposal$weak_nonproposer_j, fixed = TRUE) &&
      grepl("may induce different successor beliefs", strategy$ballot_response_map_after_every_feasible_proposal$hegemon_type_theta, fixed = TRUE) &&
      !grepl("nonpivotal, both actions are payoff-identical", strategy$ballot_response_map_after_every_feasible_proposal$weak_nonproposer_j, fixed = TRUE),
    paste("Public-vector continuation comparison missing in", record$equilibrium_id)
  )
  assert_true(
    identical(strategy$pooling_family$support_conditions[[2L]], "x_ij>=b for every j!=i") &&
      grepl("y_bar=U_P", strategy$pooling_family$Y_projection$exact_cap_rule, fixed = TRUE),
    paste("Pooling floor or open-cap rule changed in", record$equilibrium_id)
  )
  assert_true(
    identical(strategy$low_type_only_family$Y_projection$interval, "[ell,h)") &&
      identical(strategy$delay_family$Y_projection$interval, "[0,y_bar]"),
    paste("Low-only or delay Y interval changed in", record$equilibrium_id)
  )
  assert_true(
    grepl("reverse H separation is inadmissible", strategy$delay_family$forbidden_response, fixed = TRUE),
    paste("Forbidden reverse H separation missing in", record$equilibrium_id)
  )
  assert_true(
    grepl("full Cartesian product", strategy$proposer_identity_completion$labeled_completion, fixed = TRUE) &&
      grepl("source", strategy$proposer_identity_completion$quotient_rule, fixed = TRUE) &&
      grepl("hash", strategy$proposer_identity_completion$quotient_rule, fixed = TRUE),
    paste("Identity multiplicity or quotient guard missing in", record$equilibrium_id)
  )
  coverage <- strategy$branch_candidate_coverage
  assert_true(identical(coverage$pooling$status_rule, "exists") && is.null(coverage$pooling$none_certificate),
              paste("Pooling coverage wrong in", record$equilibrium_id))
  assert_true(identical(coverage$high_type_only$status_rule, "none"),
              paste("High-only none cell missing in", record$equilibrium_id))
  for (branch_name in c("high_type_only", "reverse_H_separation_inside_delay")) {
    certificate <- coverage[[branch_name]]$none_certificate
    assert_true(
      length(certificate$ledger_claim_ids) > 0L &&
        length(certificate$assumptions_used) > 0L &&
        length(certificate$checks_performed) > 0L,
      paste("Incomplete typed none certificate for", branch_name, "in", record$equilibrium_id)
    )
  }
}

actual_equilibria <- vapply(all_records, `[[`, character(1), "equilibrium_id")
assert_true(identical(actual_equilibria, expected_equilibria),
            "Equilibrium ID enumeration is incomplete or reordered.")

# m=2 and m>=3 security, delay, binder, and veto regimes stay separate.
for (idx in 1:3) {
  strategy <- all_records[[idx]]$strategy_profile
  assert_true(identical(strategy$exact_proposer_security$formula, "S_2=max{F,K,M}"),
              "An m=2 cell lost the F-K-M security formula.")
  assert_true(identical(strategy$branch_candidate_coverage$delay$status_rule, "conditional") &&
                identical(strategy$branch_candidate_coverage$delay$exists_when, "C>=F") &&
                identical(strategy$branch_candidate_coverage$delay$none_when, "C<F"),
              "An m=2 cell lost the exact delay condition.")
  assert_true(identical(strategy$branch_candidate_coverage$at_least_two_weak_vetoes$status_rule, "none"),
              "An m=2 cell invented two weak vetoers.")
  assert_true(
    identical(strategy$pooling_family$proposer_residual_rule$binder_predicates$B_M, "S=M=D<P") &&
      identical(strategy$pooling_family$proposer_residual_rule$binder_predicates$B_K, "S=K=(1-nu)*R_L<b"),
    "An m=2 pooling binder predicate changed."
  )
}
for (idx in 4:6) {
  strategy <- all_records[[idx]]$strategy_profile
  assert_true(identical(strategy$exact_proposer_security$formula, "S_m=min{P,D}"),
              "An m>=3 cell lost the min{P,D} security formula.")
  assert_true(identical(strategy$branch_candidate_coverage$delay$status_rule, "exists"),
              "An m>=3 cell lost universal delay.")
  assert_true(
    grepl("When D>b", strategy$exact_proposer_security$forbidden_b_punishment, fixed = TRUE),
    "The low-prior invalid-b-punishment guard is missing."
  )
}

# Prior-specific existence, mixtures, H maps, and outcome maps.
nu0_indices <- c(1L, 4L)
low_indices <- c(2L, 5L)
high_indices <- c(3L, 6L)
for (idx in nu0_indices) {
  strategy <- all_records[[idx]]$strategy_profile
  assert_true(identical(strategy$branch_candidate_coverage$low_type_only$status_rule, "exists"),
              "nu=0 must retain low-only passage.")
  assert_true(identical(strategy$nu0_reporting$applicability, "required"),
              "nu=0 reporting block is not required.")
  assert_true(
    identical(strategy$nu0_reporting$empty_category_value,
              list(status = "not_applicable", reason = "category_empty")),
    "nu=0 empty category lacks typed non-applicability."
  )
  assert_true(
    identical(all_records[[idx]]$hegemon_payoff_by_type, list(
      theta_0 = "rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell",
      theta_1 = "(rho_L+rho_D)*h+rho_P*bar_Y_P"
    )),
    "nu=0 H payoff map changed."
  )
  assert_true(
    identical(all_records[[idx]]$outcome_distribution$pass_with_hegemon, "rho_L+rho_P") &&
      identical(all_records[[idx]]$outcome_distribution$delay, "rho_D"),
    "nu=0 R1-event outcome map changed."
  )
}
for (idx in c(low_indices, high_indices)) {
  coverage <- all_records[[idx]]$strategy_profile$branch_candidate_coverage
  assert_true(identical(coverage$low_type_only$status_rule, "none") &&
                length(coverage$low_type_only$none_certificate$ledger_claim_ids) > 0L,
              "Positive-prior low-only none certificate is missing.")
  assert_true(
    identical(all_records[[idx]]$outcome_distribution$pass_with_hegemon, "rho_P") &&
      identical(all_records[[idx]]$outcome_distribution$delay, "rho_D"),
    "Positive-prior P/D outcome map changed."
  )
}
for (idx in low_indices) {
  assert_true(
    grepl("No cross-branch", all_records[[idx]]$strategy_profile$proposal_mixing$cross_branch, fixed = TRUE),
    "Low-prior cell invented a cross-branch mix."
  )
}
for (idx in high_indices) {
  assert_true(
    grepl("P/D mixing", all_records[[idx]]$strategy_profile$proposal_mixing$cross_branch, fixed = TRUE),
    "High-prior cell omitted P/D mixing."
  )
}

# Ledger closes every interface claim without changing lifecycle.
assert_true(
  identical(names(ledger), c(
    "ledger_schema", "node_id", "artifact_path", "artifact_hash",
    "node_status", "claims"
  )),
  "N4 v2 ledger schema changed."
)
assert_true(identical(ledger$ledger_schema, "essential_input_claim_ledger_v1") &&
              identical(ledger$node_id, "N4") &&
              identical(ledger$node_status, "pending_independent_review"),
            "N4 v2 ledger lifecycle is wrong.")
assert_true(
  identical(ledger$artifact_hash, paste0("sha256:", sha256_file(interface_path))),
  "Ledger artifact hash does not match the canonical interface."
)
claim_ids <- vapply(ledger$claims, `[[`, character(1), "claim_id")
assert_true(
  identical(claim_ids, sprintf("N4V2-CLM-%03d", 1:18)) &&
    length(unique(claim_ids)) == 18L,
  "N4 v2 ledger claim IDs are incomplete or duplicated."
)
for (claim in ledger$claims) {
  assert_true(identical(claim$status, "proved"),
              paste("Non-proved ledger claim", claim$claim_id))
  ids <- as_character(claim$equilibrium_ids)
  assert_true(length(ids) > 0L && all(ids %in% expected_equilibria),
              paste("Bad equilibrium linkage in", claim$claim_id))
}

# The canonical builder must reproduce both generated artifacts byte for byte.
build_result <- system2(
  "Rscript", c("--vanilla", build_path, "--check"),
  stdout = TRUE, stderr = TRUE
)
build_status <- attr(build_result, "status")
if (is.null(build_status)) build_status <- 0L
assert_true(identical(as.integer(build_status), 0L),
            paste("Build stability check failed:", paste(build_result, collapse = "\n")))
assert_true(any(grepl("PASS: N4 v2 build is byte-stable", build_result, fixed = TRUE)),
            "Build stability check did not emit PASS.")

cat("PASS: N4 v2 schema, provenance, lifecycle, and integration tests\n")
