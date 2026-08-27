#!/usr/bin/env Rscript

# Mechanical falsification checks for A_U.
# This script does not prove PBE existence, completeness, optimality,
# measurability, local Bayes limits, or absence of deviations over continuous Y.

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required.", call. = FALSE)
}

source("scripts/agenda_extension_goal1_verifier_lib.R", local = TRUE)

artifact_path <- "model_redesign/agenda_extension_A_U_candidate_simplified.json"
ledger_path <- "model_redesign/agenda_extension_A_U_claim_ledger_simplified.tsv"
proof_path <- "model_redesign/agenda_extension_A_U_derivation_simplified.md"
source_path <- "model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json"
expected_source_hash <- "f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b"

results <- data.frame(
  check_id = character(),
  status = character(),
  detail = character(),
  stringsAsFactors = FALSE
)

add_check <- function(check_id, condition, detail) {
  results <<- rbind(
    results,
    data.frame(
      check_id = check_id,
      status = if (isTRUE(condition)) "PASS" else "FAIL",
      detail = detail,
      stringsAsFactors = FALSE
    )
  )
}

artifact <- jsonlite::fromJSON(artifact_path, simplifyVector = FALSE)
required_top <- c(
  "schema_version", "artifact_id", "node_id", "institution",
  "source_complete_view_reference", "equilibrium_family_collection",
  "ex_ante_image", "proof_paths"
)
add_check(
  "artifact_top_level_schema",
  !length(setdiff(required_top, names(artifact))),
  "A_U artifact has every required top-level object."
)
add_check(
  "source_C_U_hash_unchanged",
  identical(agenda_sha256_file(source_path), expected_source_hash),
  "C_U matches the pinned Goal 1 hash."
)
add_check(
  "source_reference_hash",
  identical(
    artifact$source_complete_view_reference$source_artifact_hash,
    expected_source_hash
  ),
  "The A_U source-complete-view reference cites the pinned C_U hash."
)

collection <- artifact$equilibrium_family_collection
required_collection <- c(
  "collection_id", "node_id", "institution", "domain", "status",
  "family_record_ids", "source_complete_view_id", "cells", "proof_paths"
)
add_check(
  "collection_schema",
  !length(setdiff(required_collection, names(collection))),
  "The equilibrium family collection has the simplified contract fields."
)

families <- collection$family_records
family_issues <- unlist(lapply(families, agenda_validate_family_record), use.names = FALSE)
add_check(
  "family_record_schemas",
  !length(family_issues),
  if (!length(family_issues)) {
    "Every symbolic family record passes the Goal 1 minimal family schema."
  } else {
    paste(family_issues, collapse = "; ")
  }
)

family_ids <- vapply(families, function(record) record$family_record_id, character(1))
family_index <- stats::setNames(families, family_ids)
add_check(
  "family_ids_unique_and_complete",
  !anyDuplicated(family_ids) && setequal(family_ids, unlist(collection$family_record_ids)),
  "Family IDs are unique and equal the collection inventory."
)

cells <- collection$cells
cell_statuses <- vapply(cells, function(cell) cell$status, character(1))
none_cells <- cells[cell_statuses == "none"]
exists_cells <- cells[cell_statuses == "exists"]
none_ok <- length(none_cells) == 1L && all(vapply(none_cells, function(cell) {
  !length(cell$family_record_ids) && !is.null(cell$none_reason)
}, logical(1)))
exists_ok <- length(exists_cells) == 4L && all(vapply(exists_cells, function(cell) {
  length(cell$family_record_ids) >= 1L && is.null(cell$none_reason)
}, logical(1)))
add_check(
  "coverage_cell_structure",
  none_ok && exists_ok,
  "Five coverage cells contain four exists cells and one certified none cell."
)

image_cells <- artifact$ex_ante_image$cells
image_records <- unlist(
  lapply(image_cells, function(cell) {
    if (identical(cell$status, "exists")) cell$image_records else list()
  }),
  recursive = FALSE
)
image_issues <- unlist(
  lapply(image_records, agenda_validate_image_record, family_index = family_index),
  use.names = FALSE
)
add_check(
  "image_record_schemas_and_binders",
  !length(image_issues),
  if (!length(image_issues)) {
    "Every existing ex ante image record cites the matching family binder."
  } else {
    paste(image_issues, collapse = "; ")
  }
)

ledger <- utils::read.delim(
  ledger_path,
  sep = "\t",
  quote = "",
  comment.char = "",
  check.names = FALSE,
  stringsAsFactors = FALSE,
  na.strings = character()
)
ledger_columns_ok <- identical(names(ledger), agenda_required_ledger_columns)
claim_issues <- unlist(lapply(seq_len(nrow(ledger)), function(index) {
  agenda_validate_claim_row(as.list(ledger[index, , drop = FALSE]))
}), use.names = FALSE)
add_check(
  "ledger_schema_and_rows",
  ledger_columns_ok && nrow(ledger) == 16L && !length(claim_issues),
  if (ledger_columns_ok && nrow(ledger) == 16L && !length(claim_issues)) {
    "The A_U ledger has the approved header and 16 mechanically valid claim rows."
  } else {
    paste(c("ledger validation failed", claim_issues), collapse = "; ")
  }
)

proof_files <- unique(vapply(families, function(record) {
  strsplit(record$proof_path, "#", fixed = TRUE)[[1L]][1L]
}, character(1)))
add_check(
  "proof_paths_resolve",
  file.exists(proof_path) && all(file.exists(proof_files)),
  "The main proof and every family proof path resolve to existing files."
)
add_check(
  "no_payoff_sentinel",
  !agenda_has_payoff_sentinel(artifact),
  "The artifact contains no NA, NaN, Inf, -Inf, undefined, missing, or sentinel payoff."
)

parameter_grid <- expand.grid(
  m = c(2, 3, 5),
  beta = c(0.55, 0.75, 0.9),
  o_0 = c(0.05, 0.2),
  o_1 = c(0.35, 0.7),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
parameter_grid <- parameter_grid[parameter_grid$o_0 < parameter_grid$o_1, , drop = FALSE]

algebra_ok <- logical(nrow(parameter_grid))
low_witness_ok <- logical(nrow(parameter_grid))
high_witness_ok <- logical(nrow(parameter_grid))

for (index in seq_len(nrow(parameter_grid))) {
  m <- parameter_grid$m[index]
  beta <- parameter_grid$beta[index]
  o_0 <- parameter_grid$o_0[index]
  o_1 <- parameter_grid$o_1[index]
  nu_star <- (o_1 - o_0) / (1 - o_0)
  w_0 <- beta * (1 - beta * o_0) / m
  w_1 <- beta * (1 - beta * o_1) / m
  d_0 <- beta^2 * o_0
  d_1 <- beta^2 * o_1
  p_0 <- 1 - beta + beta^2 * o_0
  p_1 <- 1 - beta + beta^2 * o_1
  Delta <- p_0 - d_1
  u_min <- max(p_0, d_1)

  algebra_ok[index] <- all(c(
    nu_star > 0,
    nu_star < 1,
    w_1 > 0,
    w_1 < w_0,
    agenda_identity_holds(p_0, 1 - m * w_0),
    agenda_identity_holds(p_1, 1 - m * w_1),
    agenda_identity_holds(p_0 - d_0, 1 - beta),
    agenda_identity_holds(p_1 - d_1, 1 - beta),
    agenda_identity_holds(p_1 - p_0, beta^2 * (o_1 - o_0)),
    agenda_identity_holds(Delta, 1 - beta - beta^2 * (o_1 - o_0))
  ))

  q_0_total <- p_0 + m * w_0
  q_H_total <- p_0 + m * w_1
  low_witness_ok[index] <- if (Delta >= -1e-12) {
    agenda_identity_holds(q_0_total, 1) &&
      q_H_total <= 1 + 1e-12 &&
      d_1 <= p_0 + 1e-12
  } else {
    d_1 > p_0
  }

  witness_values <- c(u_min, (u_min + p_1) / 2, p_1)
  high_witness_ok[index] <- all(vapply(witness_values, function(u) {
    q_u_total <- u + m * w_1
    q_u_total <= 1 + 1e-12 && p_0 <= u + 1e-12 && d_1 <= u + 1e-12
  }, logical(1)))
}

add_check(
  "algebraic_identities_grid",
  all(algebra_ok),
  "All threshold, cap, gap, and single-beta identities hold on the finite parameter grid."
)
add_check(
  "low_prior_witness_grid",
  all(low_witness_ok),
  "The separating low-prior witness is feasible exactly on sampled Delta>=0 cases."
)
add_check(
  "high_prior_pooling_witness_grid",
  all(high_witness_ok),
  "Pooling witnesses at the lower endpoint, midpoint, and upper endpoint are feasible on the finite grid."
)

for (index in seq_len(nrow(results))) {
  cat(sprintf(
    "%-42s | %s | %s\n",
    results$check_id[index],
    results$status[index],
    results$detail[index]
  ))
}

failures <- sum(results$status == "FAIL")
cat(sprintf("\nSUMMARY | %d PASS | %d FAIL\n", nrow(results) - failures, failures))
cat(paste0(
  "Mechanical checks only: no PBE existence, completeness, continuous-space ",
  "optimality, local Bayes-limit, measurability, or family-coverage claim was proved.\n"
))

if (failures > 0L) quit(status = 1L)
