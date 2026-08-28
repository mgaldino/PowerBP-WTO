#!/usr/bin/env Rscript

# Mechanical falsification checks for AC.
# This script does not prove equilibrium existence or completeness, evaluate
# E_M(d), establish measurability, select equilibria, or prove family-wide
# institutional rankings.

if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required.", call. = FALSE)
}

source("scripts/agenda_extension_goal1_verifier_lib.R", local = TRUE)

ac_path <- "model_redesign/agenda_extension_AC_candidate_simplified.json"
proof_path <- "model_redesign/agenda_extension_AC_derivation_simplified.md"
ledger_path <- "model_redesign/agenda_extension_AC_claim_ledger_simplified.tsv"
dag_path <- "model_redesign/agenda_extension_game_dag_simplified.json"

source_paths <- list(
  A_M_candidate = "model_redesign/agenda_extension_A_M_candidate_simplified.json",
  A_M_derivation = "model_redesign/agenda_extension_A_M_derivation_simplified.md",
  A_M_ledger = "model_redesign/agenda_extension_A_M_claim_ledger_simplified.tsv",
  A_M_checker = "scripts/verify_agenda_extension_A_M_mechanical.R",
  A_U_candidate = "model_redesign/agenda_extension_A_U_candidate_simplified.json",
  A_U_derivation = "model_redesign/agenda_extension_A_U_derivation_simplified.md",
  A_U_ledger = "model_redesign/agenda_extension_A_U_claim_ledger_simplified.tsv",
  A_U_checker = "scripts/verify_agenda_extension_A_U_mechanical.R"
)

expected_hashes <- c(
  AC_candidate = "b53f43418c79e83d01e58f5754d36cbb556546b2b5df6e9bd545434af61aaa96",
  AC_derivation = "35cd38c2936709b1a1bc9bb53b493d59357480c65619f73f6d0bceee6da1ad21",
  AC_ledger = "949232b4735d4459cdc186f336aece05b52e2a8c6eaf795e9296874919d91430",
  A_M_candidate = "c45b4420b0c1a4fe7dac2187ee90e79da5d47365eb32ebe2759aaa746ebcb976",
  A_M_derivation = "e4bade93df0e4c42037e1e85ac69f9163a0917370d18e12c674d3a54c1d46f72",
  A_M_ledger = "9934db4a5b677bf6ac95683f495f94dee0fbd390a5574892d5c8c907294c923b",
  A_M_checker = "1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747",
  A_U_candidate = "d4bedcc1d579a38ca2a095ab2f1ce0256d1b4ce0af039076c2a954eeee3e47a7",
  A_U_derivation = "4100baa6b3fa00ccbc5ef1c9b8d656e14d844fdc6a36026fe61eb855b378e8e5",
  A_U_ledger = "fb8447d5aff10efdc600ad4753066636f86e994985d802684b19ddde2139d3dc",
  A_U_checker = "c5032f7baf8748a0bff2638c1a62d8ab609a8a964503975661dcf9c5d1270e60"
)

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

ac_hashes_ok <- all(c(
  identical(agenda_sha256_file(ac_path), expected_hashes[["AC_candidate"]]),
  identical(agenda_sha256_file(proof_path), expected_hashes[["AC_derivation"]]),
  identical(agenda_sha256_file(ledger_path), expected_hashes[["AC_ledger"]])
))
add_check(
  "AC_artifact_hashes",
  ac_hashes_ok,
  "The AC candidate, proof and ledger match their pinned pre-checker hashes."
)

source_hashes_observed <- vapply(source_paths, agenda_sha256_file, character(1))
add_check(
  "imported_source_hashes",
  identical(unname(source_hashes_observed), unname(expected_hashes[names(source_paths)])),
  "All eight imported A_M and A_U source blobs remain byte-identical."
)

artifact <- jsonlite::fromJSON(ac_path, simplifyVector = FALSE)
required_top <- c(
  "schema_version", "collection_id", "node_id", "institution_comparison",
  "contrast_orientation", "status", "common_domain", "source_snapshots",
  "family_record_ids", "cells", "comparison_family_records",
  "exact_joint_relation", "comparison_invariance_and_selection",
  "derived_projection_rules", "proof_paths", "scope_and_invalidation"
)
add_check(
  "top_level_schema",
  !length(setdiff(required_top, names(artifact))) &&
    identical(artifact$node_id, "AC") &&
    identical(artifact$contrast_orientation, "unanimity_minus_majority"),
  "AC has the required comparison schema and explicit U-minus-M orientation."
)

snapshot_m <- artifact$source_snapshots$A_M
snapshot_u <- artifact$source_snapshots$A_U
add_check(
  "source_snapshot_references",
  identical(snapshot_m$candidate_sha256, expected_hashes[["A_M_candidate"]]) &&
    identical(snapshot_u$candidate_sha256, expected_hashes[["A_U_candidate"]]) &&
    identical(snapshot_m$atomic_binder, "A_M_BINDER(d;b_M)") &&
    setequal(
      unlist(snapshot_u$family_record_ids),
      c(
        "A-U-FAM-NU-ZERO", "A-U-FAM-LOW-PRIOR",
        "A-U-FAM-HIGH-PRIOR-INTERIOR", "A-U-FAM-NU-ONE"
      )
    ),
  "Source snapshots cite the exact candidate hashes, family IDs and binders."
)

source_m <- jsonlite::fromJSON(source_paths$A_M_candidate, simplifyVector = FALSE)
source_u <- jsonlite::fromJSON(source_paths$A_U_candidate, simplifyVector = FALSE)
source_m_ids <- vapply(
  source_m$equilibrium_family_collection,
  function(record) record$family_record_id,
  character(1)
)
source_u_ids <- vapply(
  source_u$equilibrium_family_collection$family_records,
  function(record) record$family_record_id,
  character(1)
)
add_check(
  "source_family_ids_resolve",
  identical(source_m_ids, "AGENDA-EXT-A-M-FAMILY-ALL-PBE-V1") &&
    setequal(source_u_ids, unlist(snapshot_u$family_record_ids)),
  "Every family ID cited by AC resolves in the corresponding imported source."
)

cells <- artifact$cells
cell_status <- vapply(cells, function(cell) cell$status, character(1))
exists_cells <- cells[cell_status == "exists"]
none_cells <- cells[cell_status == "none"]
exists_ok <- length(exists_cells) == 4L && all(vapply(exists_cells, function(cell) {
  length(cell$family_record_ids) == 1L && is.null(cell$none_reason)
}, logical(1)))
none_ok <- length(none_cells) == 3L && all(vapply(none_cells, function(cell) {
  !length(cell$family_record_ids) &&
    is.character(cell$none_reason) && nzchar(cell$none_reason)
}, logical(1)))
add_check(
  "cell_partition_schema",
  length(cells) == 7L && exists_ok && none_ok,
  "Seven cells contain four exact-comparison families and three certified none cases."
)

family_ids <- vapply(
  artifact$comparison_family_records,
  function(record) record$comparison_id,
  character(1)
)
add_check(
  "family_inventory",
  !anyDuplicated(family_ids) &&
    setequal(family_ids, unlist(artifact$family_record_ids)) &&
    setequal(
      unlist(lapply(exists_cells, function(cell) cell$family_record_ids)),
      family_ids
    ),
  "Comparison family IDs are unique and agree with the collection and exists cells."
)

required_comparison_fields <- c(
  "comparison_id", "common_domain", "source_A_M_ids_and_hashes",
  "source_A_U_ids_and_hashes", "source_member_domains_and_binders",
  "necessary_and_sufficient_compatibility_rule",
  "source_value_transport_records", "exact_joint_value_and_outcome_set_at_A",
  "derived_envelopes", "selection_status", "proof_path"
)
comparison_schema_ok <- all(vapply(
  artifact$comparison_family_records,
  function(record) !length(setdiff(required_comparison_fields, names(record))),
  logical(1)
))
add_check(
  "comparison_record_schemas",
  comparison_schema_ok,
  "Every comparison record has IDs, hashes, domains, binders, compatibility, transport, exact joint set, envelopes and proof path."
)

source_citations_ok <- all(vapply(
  artifact$comparison_family_records,
  function(record) {
    identical(
      record$source_A_M_ids_and_hashes$candidate_sha256,
      expected_hashes[["A_M_candidate"]]
    ) &&
      identical(
        record$source_A_U_ids_and_hashes$candidate_sha256,
        expected_hashes[["A_U_candidate"]]
      ) &&
      record$source_A_M_ids_and_hashes$family_record_id %in% source_m_ids &&
      record$source_A_U_ids_and_hashes$family_record_id %in% source_u_ids
  },
  logical(1)
))
add_check(
  "comparison_source_citations",
  source_citations_ok,
  "Every comparison record cites resolving source family IDs and exact candidate hashes."
)

transport_records <- unlist(
  lapply(
    artifact$comparison_family_records,
    function(record) record$source_value_transport_records
  ),
  recursive = FALSE
)
transport_required <- c(
  "transport_record_id", "source_record_id",
  "source_artifact_hash_if_external", "native_value", "native_date",
  "transport_factor_to_A", "beta_application_count", "transported_value_at_A"
)
transport_ok <- length(transport_records) == 8L && all(vapply(
  transport_records,
  function(record) {
    !length(setdiff(transport_required, names(record))) &&
      identical(record$native_date, "A") &&
      identical(record$transport_factor_to_A, 1L) &&
      identical(record$beta_application_count, 0L) &&
      record$source_artifact_hash_if_external %in%
        expected_hashes[c("A_M_candidate", "A_U_candidate")]
  },
  logical(1)
))
add_check(
  "no_additional_beta",
  transport_ok,
  "All eight AC source rows import date-A values with factor one and zero additional beta applications."
)

joint_text_ok <- all(vapply(
  artifact$comparison_family_records,
  function(record) {
    text <- record$exact_joint_value_and_outcome_set_at_A
    all(vapply(
      c("b_M", "b_U", "M_0", "M_1", "Omega_M", "Omega_U"),
      grepl,
      logical(1),
      x = text,
      fixed = TRUE
    ))
  },
  logical(1)
))
compatibility_text_ok <- all(vapply(
  artifact$comparison_family_records,
  function(record) {
    text <- record$necessary_and_sufficient_compatibility_rule
    all(vapply(
      c("Same primitive tuple", "binders remain atomic", "no further cross-rule selection"),
      grepl,
      logical(1),
      x = text,
      fixed = TRUE
    ))
  },
  logical(1)
))
add_check(
  "joint_member_and_compatibility_text",
  joint_text_ok && compatibility_text_ok,
  "Every exact set retains both binders, type values, outcomes and the necessary-and-sufficient compatibility rule."
)

add_check(
  "joint_before_projection",
  isTRUE(artifact$exact_joint_relation$marginal_image_product_forbidden) &&
    identical(artifact$exact_joint_relation$coordinate_splicing, "forbidden") &&
    grepl("derive only after", artifact$derived_projection_rules$order, fixed = TRUE),
  "The exact member relation is primary; marginal products and coordinate splicing are forbidden."
)

add_check(
  "none_cells_no_sentinel",
  !agenda_has_payoff_sentinel(artifact) &&
    all(vapply(none_cells, function(cell) {
      is.list(cell$source_rule_status) &&
        all(c("A_M", "A_U") %in% names(cell$source_rule_status))
    }, logical(1))),
  "None cells have reasons, preserve source status and contain no payoff sentinel."
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
claim_issues <- unlist(lapply(seq_len(nrow(ledger)), function(index) {
  agenda_validate_claim_row(as.list(ledger[index, , drop = FALSE]))
}), use.names = FALSE)
add_check(
  "ledger_schema_and_rows",
  identical(names(ledger), agenda_required_ledger_columns) &&
    nrow(ledger) == 15L &&
    all(ledger$node_id == "AC") &&
    !length(claim_issues),
  "The AC ledger has the approved schema and fifteen mechanically valid AC-only claims."
)

proof_files <- unique(c(
  sub("#.*$", "", ledger$proof_path),
  vapply(
    artifact$comparison_family_records,
    function(record) strsplit(record$proof_path, "#", fixed = TRUE)[[1L]][1L],
    character(1)
  )
))
add_check(
  "proof_paths_resolve",
  file.exists(proof_path) && all(file.exists(proof_files)),
  "The self-contained proof and every cited proof file resolve."
)

dag <- agenda_read_json(dag_path)
node_ids <- vapply(dag$nodes, function(node) node$node_id, character(1))
node_status <- vapply(dag$nodes, function(node) node$status, character(1))
ac_nodes <- Filter(function(node) identical(node$node_id, "AC"), dag$nodes)
add_check(
  "DAG_still_pending",
  setequal(node_ids, c("A_M", "A_U", "AC", "AR")) &&
    all(node_status == "pending") && length(ac_nodes) == 1L &&
    !any(c("artifact_path", "artifact_hash", "dependency_hashes", "review_paths") %in%
      names(ac_nodes[[1L]])),
  "The simplified DAG still has all four nodes pending and no AC pass fields."
)

parameter_grid <- expand.grid(
  beta = c(0.55, 0.75, 0.9),
  o_0 = c(0.05, 0.2),
  o_1 = c(0.35, 0.7),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)
parameter_grid <- parameter_grid[
  parameter_grid$o_0 < parameter_grid$o_1,
  ,
  drop = FALSE
]

boundary_ok <- logical()
expectation_ok <- logical()
for (index in seq_len(nrow(parameter_grid))) {
  beta <- parameter_grid$beta[index]
  o_0 <- parameter_grid$o_0[index]
  o_1 <- parameter_grid$o_1[index]
  nu_star <- (o_1 - o_0) / (1 - o_0)
  d_1 <- beta^2 * o_1
  p_0 <- 1 - beta + beta^2 * o_0
  p_1 <- 1 - beta + beta^2 * o_1
  Delta_U <- p_0 - d_1
  u_min <- max(p_0, d_1)

  nu_values <- c(0, nu_star / 2, nu_star, (nu_star + 1) / 2, 1)
  for (nu in nu_values) {
    cell_flags <- c(
      nu == 0,
      nu > 0 && nu <= nu_star && Delta_U < 0,
      nu > 0 && nu <= nu_star && Delta_U >= 0,
      nu > nu_star && nu < 1,
      nu == 1
    )
    boundary_ok <- c(
      boundary_ok,
      sum(cell_flags) == 1L &&
        nu_star > 0 && nu_star < 1 &&
        p_1 > u_min &&
        agenda_identity_holds(p_1 - d_1, 1 - beta)
    )

    m_0 <- 0.23
    m_1 <- 0.61
    u_0 <- p_0
    u_1 <- if (nu == 0) max(p_0, d_1) else if (nu == 1) p_1 else u_min
    delta_0 <- u_0 - m_0
    delta_1 <- u_1 - m_1
    delta_e_direct <- ((1 - nu) * u_0 + nu * u_1) -
      ((1 - nu) * m_0 + nu * m_1)
    expectation_ok <- c(
      expectation_ok,
      agenda_identity_holds(
        delta_e_direct,
        (1 - nu) * delta_0 + nu * delta_1
      )
    )
  }
}

add_check(
  "boundary_partition_grid",
  all(boundary_ok),
  "Representative endpoints, cutoff sides and Delta signs enter exactly one A_U source cell, with a nondegenerate high-payoff interval."
)
add_check(
  "type_first_expectation_grid",
  all(expectation_ok),
  "Representative type-first contrasts satisfy delta_E=(1-nu)delta_0+nu*delta_1."
)

for (index in seq_len(nrow(results))) {
  cat(sprintf(
    "%-40s | %s | %s\n",
    results$check_id[index],
    results$status[index],
    results$detail[index]
  ))
}

failures <- sum(results$status == "FAIL")
cat(sprintf("\nSUMMARY | %d PASS | %d FAIL\n", nrow(results) - failures, failures))
cat(paste0(
  "LIMIT | Mechanical identities, schemas, hashes and finite boundary cases only; ",
  "no PBE, completeness, measurability, family-wide invariance or ranking theorem is proved.\n"
))

if (failures > 0L) quit(status = 1L)
