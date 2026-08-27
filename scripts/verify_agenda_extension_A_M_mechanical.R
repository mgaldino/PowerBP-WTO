#!/usr/bin/env Rscript

# Mechanical checks only. This script does not prove PBE existence,
# completeness, measurability, necessity/sufficiency, or global optimality.

source("scripts/agenda_extension_goal1_verifier_lib.R")

artifact_path <- "model_redesign/agenda_extension_A_M_candidate_simplified.json"
proof_path <- "model_redesign/agenda_extension_A_M_derivation_simplified.md"
ledger_path <- "model_redesign/agenda_extension_A_M_claim_ledger_simplified.tsv"
dag_path <- "model_redesign/agenda_extension_game_dag_simplified.json"
c_m_path <- "model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json"

expected_c_m_hash <- "ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d"
expected_untouched_ledger_hash <- "3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580"

pass_count <- 0L
fail_count <- 0L

record_check <- function(condition, label) {
  if (isTRUE(condition)) {
    pass_count <<- pass_count + 1L
    cat("PASS |", label, "\n")
  } else {
    fail_count <<- fail_count + 1L
    cat("FAIL |", label, "\n")
  }
}

record_check(file.exists(artifact_path), "A_M artifact exists")
record_check(file.exists(proof_path), "A_M mathematical derivation exists")
record_check(file.exists(ledger_path), "A_M simplified claim ledger exists")
record_check(
  identical(agenda_sha256_file(c_m_path), expected_c_m_hash),
  "C_M hash matches the pinned dependency"
)

artifact <- agenda_read_json(artifact_path)
record_check(!is.null(artifact), "A_M artifact is valid JSON")

required_collection_fields <- c(
  "collection_id", "node_id", "institution", "domain", "status",
  "family_record_ids", "source_complete_view_id", "cells", "proof_paths"
)
record_check(
  !length(agenda_missing_fields(artifact, required_collection_fields)),
  "collection schema contains every required field"
)
record_check(identical(artifact$node_id, "A_M"), "artifact node is A_M")
record_check(identical(artifact$institution, "M"), "artifact institution is majority")

complete_view_required <- c(
  "complete_view_id", "source_node_id", "source_artifact_path",
  "source_artifact_hash", "domain", "source_cells_and_family_schemas",
  "payoff_and_outcome_coordinates", "native_dates", "status", "proof_path"
)
complete_view <- artifact$source_complete_view_reference
record_check(
  !length(agenda_missing_fields(complete_view, complete_view_required)),
  "source complete-view schema is complete"
)
record_check(
  identical(complete_view$source_artifact_hash, expected_c_m_hash),
  "source complete view cites the pinned C_M hash"
)
record_check(
  identical(complete_view$source_artifact_path, c_m_path),
  "source complete view cites the authorized C_M path"
)

families <- artifact$equilibrium_family_collection
record_check(is.list(families) && length(families) == 1L, "one symbolic all-PBE family record is present")
family <- families[[1L]]
record_check(
  !length(agenda_missing_fields(family, agenda_required_family_fields)),
  "family record contains every minimum contract field"
)
record_check(
  identical(family$family_record_id, artifact$family_record_ids[[1L]]),
  "collection and family IDs agree"
)
record_check(
  identical(family$atomic_binder$coordinate_splicing, "forbidden"),
  "atomic binder forbids coordinate splicing"
)

image_record <- artifact$ex_ante_image
record_check(
  !length(agenda_missing_fields(image_record, agenda_required_image_fields)),
  "ex-ante image contains every minimum contract field"
)
record_check(
  identical(image_record$source_family_record_id, family$family_record_id),
  "ex-ante image cites the same family record"
)
record_check(
  grepl("identical b", image_record$source_atomic_binder, fixed = TRUE),
  "ex-ante image explicitly preserves the same binder"
)

cells <- artifact$cells
cell_statuses <- vapply(cells, function(cell) cell$status, character(1))
record_check(identical(cell_statuses, c("exists", "none")), "exists and none cells are both explicit")
record_check(
  length(cells[[2L]]$family_record_ids) == 0L &&
    is.character(cells[[2L]]$none_reason) && nzchar(cells[[2L]]$none_reason),
  "none cell has no member and has an explicit reason"
)
record_check(!agenda_has_payoff_sentinel(artifact), "artifact contains no payoff sentinel")

transport_records <- artifact$source_value_transport_records
record_check(length(transport_records) == 2L, "source transport ledger has continuation and immediate rows")
for (transport in transport_records) {
  record_check(
    !length(agenda_missing_fields(transport, agenda_required_transport_fields)),
    paste("transport record is schema-complete:", transport$source_record_id)
  )
}
record_check(
  identical(transport_records[[1L]]$transport_factor_to_A, "beta") &&
    identical(transport_records[[1L]]$beta_application_count, 1L),
  "C_M continuation applies beta exactly once"
)
record_check(
  identical(transport_records[[2L]]$transport_factor_to_A, "1") &&
    identical(transport_records[[2L]]$beta_application_count, 0L),
  "immediate A_M agreement is undiscounted"
)

ledger <- read.delim(
  ledger_path,
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = FALSE,
  quote = "",
  comment.char = ""
)
record_check(identical(names(ledger), agenda_required_ledger_columns), "A_M ledger header matches the approved schema")
record_check(nrow(ledger) >= 10L, "A_M ledger contains substantive claims")
record_check(all(ledger$node_id == "A_M"), "every populated ledger row belongs only to A_M")
record_check(
  all(ledger$status %in% c("proved", "checked numerically", "conjecture", "pending", "rejected")),
  "every ledger status is allowed"
)
record_check(
  all(nzchar(ledger$proof_path)) && all(file.exists(sub("#.*$", "", ledger$proof_path))),
  "every ledger claim cites an existing proof file"
)

untouched_ledgers <- c(
  "model_redesign/agenda_extension_A_U_claim_ledger_simplified.tsv",
  "model_redesign/agenda_extension_AC_claim_ledger_simplified.tsv",
  "model_redesign/agenda_extension_AR_claim_ledger_simplified.tsv"
)
record_check(
  all(vapply(untouched_ledgers, agenda_sha256_file, character(1)) == expected_untouched_ledger_hash),
  "all out-of-scope simplified ledgers remain byte-identical"
)

dag <- agenda_read_json(dag_path)
a_m_nodes <- Filter(function(node) identical(node$node_id, "A_M"), dag$nodes)
record_check(length(a_m_nodes) == 1L, "simplified DAG contains exactly one A_M node")
a_m_node <- a_m_nodes[[1L]]
record_check(identical(a_m_node$status, "pending"), "A_M remains pending in the DAG")
record_check(
  !any(c("artifact_path", "artifact_hash", "dependency_hashes", "review_paths") %in% names(a_m_node)),
  "no final pass fields were written to the A_M DAG node"
)

for (n_players in 3:12) {
  m_weak <- n_players - 1L
  quota <- floor(n_players / 2) + 1L
  other_yes <- quota - 2L
  pivotal_count <- choose(m_weak - 1L, other_yes)
  record_check(
    other_yes >= 0L && other_yes <= m_weak - 1L && pivotal_count >= 1,
    paste("pivotal-profile set is finite and nonempty for N=", n_players, sep = "")
  )
  record_check(
    1L + other_yes < quota && 1L + other_yes + 1L >= quota,
    paste("pointwise no rejects and yes passes for N=", n_players, sep = "")
  )
}

classify_pointwise_action <- function(own_offer, continuation_values) {
  lower <- min(continuation_values)
  upper <- max(continuation_values)
  if (own_offer >= upper) return("yes")
  if (own_offer < lower) return("no")
  "conflict"
}

synthetic_values <- c(0.20, 0.30, 0.40)
record_check(
  identical(classify_pointwise_action(0.10, synthetic_values), "no"),
  "pointwise band gives no strictly below every reservation"
)
record_check(
  identical(classify_pointwise_action(0.40, synthetic_values), "yes"),
  "pointwise band gives yes at the maximum reservation equality"
)
record_check(
  identical(classify_pointwise_action(0.25, synthetic_values), "conflict"),
  "pointwise band rejects opposite requirements without averaging"
)
record_check(
  identical(classify_pointwise_action(0.30, rep(0.30, 3L)), "yes"),
  "invariant continuation special case collapses to yes at equality"
)

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", pass_count, fail_count))
cat("LIMIT | Mechanical structure and finite falsification only; not a mathematical proof.\n")

if (fail_count > 0L) {
  quit(status = 1L)
}
