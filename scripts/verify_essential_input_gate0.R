#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) {
    stop(message, call. = FALSE)
  }
}

as_character <- function(x) {
  as.character(unlist(x, use.names = FALSE))
}

clone_object <- function(x) {
  unserialize(serialize(x, NULL))
}

sha256_file <- function(path) {
  output <- system2(
    "shasum",
    c("-a", "256", shQuote(path)),
    stdout = TRUE,
    env = c("LC_ALL=C", "LANG=C")
  )
  assert_true(length(output) == 1L, paste("Could not compute SHA-256 for", path))
  hash <- strsplit(output[[1L]], "[[:space:]]+")[[1L]][1L]
  assert_true(grepl("^[0-9a-f]{64}$", hash), paste("Malformed SHA-256 for", path))
  hash
}

all_field_names <- function(x) {
  if (!is.list(x)) {
    return(character())
  }
  unique(c(names(x), unlist(lapply(x, all_field_names), use.names = FALSE)))
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
manifest_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")
manifest_dir <- dirname(manifest_path)

manifest <- jsonlite::fromJSON(manifest_path, simplifyVector = FALSE)
nodes <- manifest$nodes
node_ids <- vapply(nodes, `[[`, character(1), "id")
names(nodes) <- node_ids

contract_path <- normalizePath(
  file.path(dirname(manifest_path), manifest$contract_path),
  mustWork = TRUE
)
contract_text <- paste(readLines(contract_path, encoding = "UTF-8", warn = FALSE), collapse = "\n")
assert_true(
  grepl("0 < o_0 < o_1 < 1 e o_1 <= y_bar <= 1", contract_text, fixed = TRUE),
  "The canonical contract must impose the author-approved strict restriction o_1 < 1."
)
assert_true(
  !grepl("0 < o_0 < o_1 <= y_bar <= 1", contract_text, fixed = TRUE),
  "The superseded weak disagreement-payoff bound must not remain in the canonical primitive block."
)
assert_true(
  grepl("reabre o Gate 0", contract_text, fixed = TRUE) &&
    grepl("`pending`, conforme a", contract_text, fixed = TRUE),
  "The contract header must record the Section 12 contract-change invalidation."
)

assert_true(
  identical(manifest$schema_version, "essential-input-gate0-v3"),
  "The manifest must use the terminal-benchmark Gate 0 schema version."
)

freeze_gate <- manifest$freeze_gate_schema
assert_true(
  identical(freeze_gate$canonical_source, "contract Section 11"),
  "The executable freeze gate must point to the sole canonical protocol source."
)
assert_true(
  identical(
    as_character(freeze_gate$required_node_fields),
    c("status", "frozen", "artifact_hash", "reviews")
  ) &&
    identical(freeze_gate$status_value, "pass") &&
    identical(freeze_gate$frozen_value, TRUE),
  "The executable freeze gate has the wrong required node facts."
)
assert_true(
  identical(as.integer(freeze_gate$review_count), 2L) &&
    identical(
      as_character(freeze_gate$review_record_fields),
      c("reviewer_role", "reviewer_id", "verdict", "artifact_hash", "finding_counts")
    ) &&
    identical(as_character(freeze_gate$reviewer_roles), c("formal_design", "game_theory")) &&
    identical(freeze_gate$reviewer_ids_must_be_distinct, TRUE) &&
    identical(freeze_gate$verdict_value, "PASS"),
  "The executable freeze gate has the wrong two-review schema."
)
assert_true(
  identical(
    as_character(freeze_gate$finding_count_fields),
    c("critical", "major", "minor")
  ) &&
    identical(as.integer(freeze_gate$finding_count_value), 0L) &&
    grepl("exactly matches", freeze_gate$review_hash_rule, fixed = TRUE),
  "The executable freeze gate must require same-hash PASS 0/0/0 reviews."
)
assert_true(
  grepl("never sufficient author authorization", freeze_gate$topological_readiness_scope, fixed = TRUE) &&
    grepl("Section 11", freeze_gate$topological_readiness_scope, fixed = TRUE),
  "Topological readiness must not be represented as author authorization."
)

shared_types <- manifest$shared_schema_types
assert_true(
  identical(names(shared_types), c("coverage_cell_v1", "public_payoff_vector_v1")),
  "The manifest has the wrong shared schema registry."
)

coverage_schema <- shared_types$coverage_cell_v1
assert_true(
  identical(
    as_character(coverage_schema$base_fields),
    c("cell_id", "domain_conditions", "existence_status", "nonexistence_certificate")
  ) &&
    identical(as_character(coverage_schema$existence_status_values), c("exists", "none")),
  "The coverage-cell base schema is incomplete."
)
assert_true(
  identical(
    as_character(coverage_schema$nonexistence_certificate_fields),
    c("ledger_claim_ids", "assumptions_used", "checks_performed")
  ) &&
    identical(coverage_schema$partition_required, TRUE) &&
    identical(coverage_schema$cell_ids_unique_within_collection, TRUE),
  "Coverage cells must partition the domain and carry unique ids and typed certificates."
)
assert_true(
  grepl("nonempty list", coverage_schema$exists_rule, fixed = TRUE) &&
    grepl("empty list", coverage_schema$none_rule, fixed = TRUE) &&
    grepl("nonempty ledger_claim_ids", coverage_schema$none_rule, fixed = TRUE) &&
    grepl("mutually exclusive and exhaustive", coverage_schema$domain_rule, fixed = TRUE),
  "The exists/none coverage-cell invariants are incomplete."
)

public_payoff_schema <- shared_types$public_payoff_vector_v1
assert_true(
  identical(
    as_character(public_payoff_schema$fields),
    c(
      "recognized_proposer_payoff",
      "weak_nonproposer_pre_recognition_expected_value",
      "hegemon_payoff"
    )
  ) &&
    grepl("Scalar", public_payoff_schema$hegemon_payoff_rule, fixed = TRUE) &&
    grepl("fixes theta", public_payoff_schema$hegemon_payoff_rule, fixed = TRUE),
  "The public payoff vector must be typed by roles with scalar H payoff."
)

expected_ids <- c("N1", "N2", "N3", "N4", "N6", "N7")
expected_names <- c(
  N1 = "r2_majority",
  N2 = "r2_unanimity",
  N3 = "r1_majority",
  N4 = "r1_unanimity",
  N6 = "private_information_comparison",
  N7 = "complete_information_benchmark"
)
expected_dependencies <- list(
  N1 = character(),
  N2 = character(),
  N3 = "N1",
  N4 = "N2",
  N6 = c("N3", "N4"),
  N7 = "N6"
)

assert_true(
  identical(node_ids, expected_ids),
  "The DAG must contain exactly N1, N2, N3, N4, N6, and N7 in order."
)
assert_true(length(unique(node_ids)) == 6L, "The six node ids must be unique.")
assert_true(!("N5" %in% node_ids), "N5 entry must remain absent from the baseline DAG.")

schemas <- manifest$interface_schemas
expected_schema_names <- c(
  "equilibrium_correspondence_v1",
  "private_information_comparison_v1",
  "complete_information_benchmark_v1"
)
assert_true(
  identical(names(schemas), expected_schema_names),
  "The manifest has the wrong interface schema registry."
)

equilibrium_schema <- schemas$equilibrium_correspondence_v1
assert_true(
  identical(as_character(equilibrium_schema$applies_to), c("N1", "N2", "N3", "N4")),
  "The equilibrium schema must apply exactly to N1-N4."
)
assert_true(
  identical(equilibrium_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(equilibrium_schema$cell_record_field, "equilibrium_records"),
  "The equilibrium schema must use typed coverage cells."
)
assert_true(
  identical(
    as_character(equilibrium_schema$record_fields),
    c(
      "equilibrium_id",
      "admissibility_conditions",
      "branch_classification",
      "strategy_profile",
      "belief_system",
      "source_continuation_record_ids",
      "source_interface_hashes",
      "existence_uniqueness_status",
      "selection_status",
      "assumptions_used",
      "checks_performed",
      "recognized_proposer_payoff",
      "weak_nonproposer_pre_recognition_expected_value",
      "hegemon_payoff_by_type",
      "outcome_distribution",
      "payoff_date"
    )
  ),
  "The equilibrium record schema does not preserve the required joint object."
)
assert_true(
  identical(as_character(equilibrium_schema$hegemon_payoff_by_type_fields), c("theta_0", "theta_1")),
  "The equilibrium record has the wrong H-type fields."
)
assert_true(
  identical(
    as_character(equilibrium_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ),
  "The equilibrium record has the wrong outcome fields."
)

comparison_schema <- schemas$private_information_comparison_v1
assert_true(
  identical(as_character(comparison_schema$applies_to), "N6"),
  "The private comparison schema must apply exactly to N6."
)
assert_true(
  identical(comparison_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(comparison_schema$private_rule_cell_record_field, "private_rule_records") &&
    identical(comparison_schema$cell_record_field, "comparison_records"),
  "The private comparison schema must use typed coverage cells."
)
assert_true(
  identical(
    as_character(comparison_schema$private_rule_record_fields),
    c(
      "private_rule_record_id",
      "institution",
      "admissibility_conditions",
      "source_equilibrium_cell_id",
      "source_equilibrium_id",
      "source_interface_hash",
      "private_payoff_vector",
      "private_outcome_distribution",
      "selection_status",
      "checks_performed"
    )
  ),
  "The private-rule passthrough record has the wrong fields."
)
assert_true(
  identical(
    as_character(comparison_schema$record_fields),
    c(
      "comparison_id",
      "admissibility_conditions",
      "source_equilibrium_ids",
      "source_interface_hashes",
      "private_payoff_vectors_by_rule",
      "private_outcome_distributions_by_rule",
      "private_rule_contrasts",
      "selection_status",
      "checks_performed"
    )
  ),
  "The private comparison record has the wrong fields."
)
assert_true(
  identical(as_character(comparison_schema$institution_fields), c("majority", "unanimity")),
  "The private comparison schema has the wrong institution fields."
)
assert_true(
  identical(
    comparison_schema$private_rule_source_node_map,
    list(majority = "N3", unanimity = "N4")
  ) &&
    identical(
      as_character(comparison_schema$private_rule_payoff_vector_fields),
      c("theta_0", "theta_1")
    ) &&
    identical(
      as_character(comparison_schema$private_rule_outcome_distribution_fields),
      c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
    ) &&
    identical(comparison_schema$unique_private_rule_id_field, "private_rule_record_id"),
  "The N6 private-rule passthrough maps or fields are incomplete."
)
assert_true(
  grepl("exactly once", comparison_schema$private_rule_passthrough_rule, fixed = TRUE) &&
    grepl("one rule may be nonempty", comparison_schema$private_rule_passthrough_rule, fixed = TRUE),
  "N6 must preserve each private rule independently under partial existence."
)
assert_true(
  identical(as_character(comparison_schema$source_node_fields), c("N3", "N4")),
  "The private comparison schema has the wrong source-node fields."
)
assert_true(
  identical(
    as_character(comparison_schema$source_equilibrium_id_fields),
    c("majority", "unanimity")
  ) &&
    identical(as_character(comparison_schema$source_interface_hash_fields), c("N3", "N4")),
  "The private comparison schema must type the exact source ids and hashes."
)
assert_true(
  identical(
    as_character(comparison_schema$private_payoff_vector_rule_fields),
    c("majority", "unanimity")
  ) &&
    identical(
      as_character(comparison_schema$private_outcome_distribution_rule_fields),
      c("majority", "unanimity")
    ),
  "The private comparison maps must contain exactly the two institutional rules."
)
assert_true(
  identical(as_character(comparison_schema$payoff_vector_type_fields), c("theta_0", "theta_1")),
  "Each private payoff vector must have exactly the two type coordinates."
)
assert_true(
  identical(
    as_character(comparison_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ) &&
    identical(comparison_schema$unique_comparison_id_field, "comparison_id"),
  "The private comparison schema has the wrong outcome fields."
)
assert_true(
  grepl("exactly one N3", comparison_schema$source_cardinality_rule, fixed = TRUE) &&
    grepl("exactly one N4", comparison_schema$source_cardinality_rule, fixed = TRUE) &&
    grepl("exactly once", comparison_schema$source_cardinality_rule, fixed = TRUE),
  "The private comparison schema must fix source cardinality and completeness."
)
assert_true(
  grepl("common refinement", comparison_schema$comparison_refinement_rule, fixed = TRUE) &&
    grepl("none wherever either", comparison_schema$comparison_refinement_rule, fixed = TRUE) &&
    grepl("without changing either", comparison_schema$comparison_refinement_rule, fixed = TRUE),
  "N6 comparison cells must not erase the surviving private-rule collection."
)

benchmark_schema <- schemas$complete_information_benchmark_v1
assert_true(
  identical(as_character(benchmark_schema$applies_to), "N7"),
  "The complete-information benchmark schema must apply exactly to N7."
)
assert_true(
  identical(benchmark_schema$cell_schema_ref, "coverage_cell_v1") &&
    identical(
      benchmark_schema$public_equilibrium_cell_record_field,
      "public_equilibrium_records"
    ) &&
    identical(
      benchmark_schema$informational_rent_cell_record_field,
      "informational_rent_records"
    ) &&
    identical(
      benchmark_schema$informational_rent_contrast_cell_record_field,
      "informational_rent_contrast_records"
    ),
  "The benchmark schema must type public, rent, and rent-contrast coverage cells."
)
assert_true(
  identical(
    as_character(benchmark_schema$public_equilibrium_record_fields),
    c(
      "public_equilibrium_id",
      "institution",
      "round",
      "theta",
      "admissibility_conditions",
      "branch_classification",
      "strategy_profile",
      "belief_system",
      "source_public_continuation_ids",
      "existence_uniqueness_status",
      "selection_status",
      "assumptions_used",
      "checks_performed",
      "payoff_vector",
      "outcome_distribution",
      "payoff_date"
    )
  ),
  "The public-equilibrium record has the wrong fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$informational_rent_record_fields),
    c(
      "rent_record_id",
      "institution",
      "admissibility_conditions",
      "private_source_rule_record_id",
      "public_source_equilibrium_ids",
      "source_N6_interface_hash",
      "RI",
      "ex_ante_images",
      "envelopes",
      "selection_status",
      "robustness_indicators"
    )
  ),
  "The informational-rent record has the wrong fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$informational_rent_contrast_record_fields),
    c(
      "contrast_record_id",
      "admissibility_conditions",
      "source_rent_record_ids",
      "DeltaRI",
      "ex_ante_images",
      "envelopes",
      "selection_status",
      "robustness_indicators"
    )
  ),
  "The informational-rent contrast record has the wrong fields."
)
assert_true(
  identical(as_character(benchmark_schema$institution_fields), c("majority", "unanimity")),
  "The benchmark schema has the wrong institution fields."
)
assert_true(
  identical(as_character(benchmark_schema$round_fields), c("R2", "R1")),
  "The benchmark schema must distinguish R2 from R1."
)
assert_true(
  identical(as_character(benchmark_schema$type_fields), c("theta_0", "theta_1")),
  "The benchmark schema has the wrong type fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$public_record_nesting),
    c("institution", "round", "type")
  ) &&
    identical(benchmark_schema$unique_public_id_field, "public_equilibrium_id") &&
    identical(benchmark_schema$public_payoff_vector_schema_ref, "public_payoff_vector_v1"),
  "Public equilibrium records must be nested by institution, round, and type."
)
assert_true(
  grepl("R2 source_public_continuation_ids is empty", benchmark_schema$public_continuation_rule, fixed = TRUE) &&
    grepl("same institution and type", benchmark_schema$public_continuation_rule, fixed = TRUE),
  "The public continuation-id target is not fully specified."
)
assert_true(
  identical(as_character(benchmark_schema$rent_cell_nesting), "institution") &&
  identical(
    as_character(benchmark_schema$rent_public_source_nesting),
    "type"
  ) &&
    identical(benchmark_schema$rent_private_source_id_field, "private_source_rule_record_id") &&
    identical(
      as_character(benchmark_schema$rent_public_source_id_fields),
      c("theta_0", "theta_1")
    ) &&
    identical(benchmark_schema$rent_source_interface_hash_field, "source_N6_interface_hash"),
  "Rent records must identify same-rule private and public sources by type."
)
assert_true(
  identical(as_character(benchmark_schema$rent_vector_fields), c("theta_0", "theta_1")) &&
    identical(benchmark_schema$unique_rent_id_field, "rent_record_id"),
  "Each informational-rent vector must have exactly the two type coordinates."
)
assert_true(
  grepl("Exactly one rent record", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("two R1 public equilibrium ids", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("frozen N6 interface hash", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("remain independent", benchmark_schema$rent_tuple_rule, fixed = TRUE) &&
    grepl("either may be nonempty", benchmark_schema$rent_independence_rule, fixed = TRUE),
  "The rent-record tuple and cardinality rule is incomplete."
)
assert_true(
  identical(
    as_character(benchmark_schema$contrast_source_rent_id_fields),
    c("majority", "unanimity")
  ) &&
    identical(as_character(benchmark_schema$contrast_vector_fields), c("theta_0", "theta_1")) &&
    identical(benchmark_schema$unique_contrast_id_field, "contrast_record_id") &&
    grepl("Exactly one contrast record", benchmark_schema$contrast_tuple_rule, fixed = TRUE) &&
    grepl("none wherever either", benchmark_schema$contrast_tuple_rule, fixed = TRUE) &&
    grepl("without changing either", benchmark_schema$contrast_tuple_rule, fixed = TRUE),
  "DeltaRI must use a separate contrast collection without erasing either RI_g."
)
assert_true(
  identical(
    as_character(benchmark_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ),
  "The benchmark schema has the wrong outcome fields."
)

is_valid_nonexistence_certificate <- function(certificate) {
  is.list(certificate) &&
    identical(
      names(certificate),
      as_character(coverage_schema$nonexistence_certificate_fields)
    ) &&
    length(as_character(certificate$ledger_claim_ids)) > 0L &&
    !any(!nzchar(as_character(certificate$ledger_claim_ids))) &&
    !is.null(certificate$assumptions_used) &&
    !is.null(certificate$checks_performed)
}

is_valid_coverage_cell <- function(cell, record_field) {
  expected_fields <- c(
    "cell_id",
    "domain_conditions",
    "existence_status",
    record_field,
    "nonexistence_certificate"
  )
  if (!is.list(cell) || !identical(names(cell), expected_fields)) {
    return(FALSE)
  }
  if (!is.character(cell$cell_id) || length(cell$cell_id) != 1L || !nzchar(cell$cell_id)) {
    return(FALSE)
  }
  if (is.null(cell$domain_conditions) || length(cell$domain_conditions) == 0L) {
    return(FALSE)
  }
  if (
    !is.character(cell$existence_status) ||
      length(cell$existence_status) != 1L ||
      !(cell$existence_status %in% as_character(coverage_schema$existence_status_values))
  ) {
    return(FALSE)
  }

  records <- cell[[record_field]]
  if (!is.list(records)) {
    return(FALSE)
  }
  if (identical(cell$existence_status, "exists")) {
    return(length(records) > 0L && is.null(cell$nonexistence_certificate))
  }
  length(records) == 0L && is_valid_nonexistence_certificate(cell$nonexistence_certificate)
}

is_valid_coverage_cells <- function(cells, record_field) {
  if (!is.list(cells) || length(cells) == 0L) {
    return(FALSE)
  }
  if (!all(vapply(cells, is_valid_coverage_cell, logical(1), record_field = record_field))) {
    return(FALSE)
  }
  cell_ids <- vapply(cells, `[[`, character(1), "cell_id")
  length(unique(cell_ids)) == length(cell_ids)
}

is_valid_public_payoff_vector <- function(payoff_vector) {
  is.list(payoff_vector) &&
    identical(names(payoff_vector), as_character(public_payoff_schema$fields)) &&
    !any(vapply(payoff_vector, is.null, logical(1)))
}

is_valid_pending_interface <- function(node_id, node) {
  interface <- node$interface
  forbidden_formation_fields <- c("formation", "formation_decision", "entry_decision", "entry_cost")
  if (any(forbidden_formation_fields %in% all_field_names(interface))) {
    return(FALSE)
  }

  if (node_id %in% c("N1", "N2", "N3", "N4")) {
    return(
      identical(names(interface), c("schema_ref", "function_of", "correspondence_cells")) &&
        identical(interface$schema_ref, "equilibrium_correspondence_v1") &&
        identical(interface$function_of$name, "entry_belief") &&
        identical(interface$function_of$domain, "[0,1]") &&
        is.null(interface$correspondence_cells) &&
        !("complete_information_benchmark" %in% all_field_names(interface)) &&
        !("private_rule_cells" %in% all_field_names(interface)) &&
        !("public_equilibrium_cells" %in% all_field_names(interface)) &&
        !("informational_rent_cells" %in% all_field_names(interface)) &&
        !("informational_rent_contrast_cells" %in% all_field_names(interface))
    )
  }

  if (identical(node_id, "N6")) {
    private_rule_cells <- interface$private_rule_cells
    valid_private_rule_shape <-
      identical(names(private_rule_cells), c("majority", "unanimity")) &&
      all(vapply(private_rule_cells, is.null, logical(1)))
    return(
      identical(
        names(interface),
        c("schema_ref", "function_of", "private_rule_cells", "comparison_cells")
      ) &&
        identical(interface$schema_ref, "private_information_comparison_v1") &&
        identical(interface$function_of$name, "entry_belief") &&
        identical(interface$function_of$domain, "[0,1]") &&
        valid_private_rule_shape &&
        is.null(interface$comparison_cells) &&
        !("complete_information_benchmark" %in% all_field_names(interface)) &&
        !("public_equilibrium_cells" %in% all_field_names(interface)) &&
        !("informational_rent_cells" %in% all_field_names(interface)) &&
        !("informational_rent_contrast_cells" %in% all_field_names(interface))
    )
  }

  if (identical(node_id, "N7")) {
    public_cells <- interface$public_equilibrium_cells
    rent_cells <- interface$informational_rent_cells
    valid_public_shape <-
      identical(names(public_cells), c("majority", "unanimity")) &&
      all(vapply(public_cells, function(rule_cells) {
        identical(names(rule_cells), c("R2", "R1")) &&
          all(vapply(rule_cells, function(round_cells) {
            identical(names(round_cells), c("theta_0", "theta_1")) &&
              all(vapply(round_cells, is.null, logical(1)))
          }, logical(1)))
      }, logical(1)))
    valid_rent_shape <-
      identical(names(rent_cells), c("majority", "unanimity")) &&
      all(vapply(rent_cells, is.null, logical(1)))

    return(
      identical(
        names(interface),
        c(
          "schema_ref",
          "function_of",
          "public_equilibrium_cells",
          "informational_rent_cells",
          "informational_rent_contrast_cells"
        )
      ) &&
        identical(interface$schema_ref, "complete_information_benchmark_v1") &&
        identical(interface$function_of$name, "prior_mu") &&
        identical(interface$function_of$domain, "[0,1]") &&
        valid_public_shape &&
        valid_rent_shape &&
        is.null(interface$informational_rent_contrast_cells) &&
        !("correspondence_cells" %in% all_field_names(interface)) &&
        !("private_rule_cells" %in% all_field_names(interface)) &&
        !("comparison_cells" %in% all_field_names(interface))
    )
  }

  FALSE
}

for (node_id in expected_ids) {
  node <- nodes[[node_id]]
  assert_true(
    identical(node$name, unname(expected_names[[node_id]])),
    paste(node_id, "has the wrong name.")
  )
  dependencies <- as_character(node$depends_on)
  assert_true(
    identical(dependencies, expected_dependencies[[node_id]]),
    paste(node_id, "has the wrong dependencies.")
  )
}

pending_node_ids <- c("N4", "N6", "N7")
for (node_id in pending_node_ids) {
  node <- nodes[[node_id]]
  assert_true(identical(node$status, "pending"), paste(node_id, "must remain pending."))
  forbidden_fields <- c(
    "result", "artifact_path", "artifact_hash", "dependency_hashes",
    "started_order", "passed_order", "frozen", "review", "reviews"
  )
  assert_true(
    !any(forbidden_fields %in% names(node)),
    paste(node_id, "contains a result or execution field.")
  )
  assert_true(
    is_valid_pending_interface(node_id, node),
    paste(node_id, "has the wrong pending interface schema or a filled coverage-cell collection.")
  )
}

# Synthetic all-pending state retained only for negative lifecycle/readiness tests.
pending_fixture_nodes <- clone_object(nodes)
for (node_id in c("N1", "N2", "N3")) {
  pending_fixture_nodes[[node_id]]$status <- "pending"
  pending_fixture_nodes[[node_id]]$interface["correspondence_cells"] <- list(NULL)
  pending_fixture_nodes[[node_id]][c(
    "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
    "passed_order", "frozen", "reviews"
  )] <- NULL
  assert_true(
    is_valid_pending_interface(node_id, pending_fixture_nodes[[node_id]]),
    paste("Synthetic pending fixture is invalid for", node_id)
  )
}

# Coverage-cell and public-payoff schema regression tests.
valid_exists_cell <- list(
  cell_id = "cell-exists",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "exists",
  equilibrium_records = list(list(equilibrium_id = "eq-1")),
  nonexistence_certificate = NULL
)
valid_none_cell <- list(
  cell_id = "cell-none",
  domain_conditions = list(expression = "mu in empty-region"),
  existence_status = "none",
  equilibrium_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-equilibrium"),
    assumptions_used = list(),
    checks_performed = list("exhaustive-deviation-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(valid_exists_cell, valid_none_cell), "equilibrium_records"),
  "A typed partition with existing and nonexistent regions must validate."
)

none_with_sentinel <- valid_none_cell
none_with_sentinel$equilibrium_records <- list(list(equilibrium_id = "forbidden-sentinel"))
assert_true(
  !is_valid_coverage_cells(list(none_with_sentinel), "equilibrium_records"),
  "A nonexistent region must not contain a sentinel equilibrium record."
)

none_without_certificate <- valid_none_cell
none_without_certificate$nonexistence_certificate <- NULL
assert_true(
  !is_valid_coverage_cells(list(none_without_certificate), "equilibrium_records"),
  "A nonexistent region without a certificate must fail validation."
)

exists_without_record <- valid_exists_cell
exists_without_record$equilibrium_records <- list()
assert_true(
  !is_valid_coverage_cells(list(exists_without_record), "equilibrium_records"),
  "An existing region without an equilibrium record must fail validation."
)

duplicate_cell_id <- valid_none_cell
duplicate_cell_id$cell_id <- valid_exists_cell$cell_id
assert_true(
  !is_valid_coverage_cells(
    list(valid_exists_cell, duplicate_cell_id),
    "equilibrium_records"
  ),
  "Coverage-cell ids must be unique within a collection."
)

valid_public_payoff <- list(
  recognized_proposer_payoff = "symbolic-proposer-payoff",
  weak_nonproposer_pre_recognition_expected_value = "symbolic-weak-value",
  hegemon_payoff = "symbolic-H-payoff"
)
assert_true(
  is_valid_public_payoff_vector(valid_public_payoff),
  "A public payoff vector typed by the three roles must validate."
)
untyped_public_payoff <- list(payoff = "ambiguous")
assert_true(
  !is_valid_public_payoff_vector(untyped_public_payoff),
  "An untyped public payoff vector must fail validation."
)
missing_h_public_payoff <- valid_public_payoff
missing_h_public_payoff$hegemon_payoff <- NULL
assert_true(
  !is_valid_public_payoff_vector(missing_h_public_payoff),
  "A public payoff vector without H's scalar payoff must fail validation."
)

# Partial-existence regression: one rule's RI survives while the joint
# comparison and DeltaRI remain empty.
majority_private_exists <- list(
  cell_id = "majority-private-exists",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "exists",
  private_rule_records = list(list(private_rule_record_id = "private-M-1")),
  nonexistence_certificate = NULL
)
unanimity_private_none <- list(
  cell_id = "unanimity-private-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  private_rule_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-private-U"),
    assumptions_used = list(),
    checks_performed = list("source-cell-propagation")
  )
)
comparison_none <- list(
  cell_id = "comparison-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  comparison_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-joint-comparison"),
    assumptions_used = list(),
    checks_performed = list("common-refinement-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(majority_private_exists), "private_rule_records") &&
    is_valid_coverage_cells(list(unanimity_private_none), "private_rule_records") &&
    is_valid_coverage_cells(list(comparison_none), "comparison_records"),
  "N6 must represent one surviving private rule without fabricating a joint comparison."
)

majority_rent_exists <- list(
  cell_id = "majority-rent-exists",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "exists",
  informational_rent_records = list(list(rent_record_id = "RI-M-1")),
  nonexistence_certificate = NULL
)
unanimity_rent_none <- list(
  cell_id = "unanimity-rent-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  informational_rent_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-RI-U"),
    assumptions_used = list(),
    checks_performed = list("same-rule-source-check")
  )
)
contrast_none <- list(
  cell_id = "contrast-none",
  domain_conditions = list(expression = "mu in region-A"),
  existence_status = "none",
  informational_rent_contrast_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-DeltaRI"),
    assumptions_used = list(),
    checks_performed = list("rent-refinement-check")
  )
)
assert_true(
  is_valid_coverage_cells(list(majority_rent_exists), "informational_rent_records") &&
    is_valid_coverage_cells(list(unanimity_rent_none), "informational_rent_records") &&
    is_valid_coverage_cells(
      list(contrast_none),
      "informational_rent_contrast_records"
    ),
  "N7 must preserve RI_M when RI_U and DeltaRI are empty."
)

# Negative Gate 0 tests: pending interfaces must reject filled, old, marginal,
# or cross-family fields.
filled_private <- pending_fixture_nodes$N1
filled_private$interface$correspondence_cells <- list(valid_exists_cell)
assert_true(
  !is_valid_pending_interface("N1", filled_private),
  "A pending private node with filled correspondence cells must fail validation."
)

old_private_shape <- pending_fixture_nodes$N1
old_private_shape$interface["joint_records"] <- list(NULL)
assert_true(
  !is_valid_pending_interface("N1", old_private_shape),
  "The superseded joint-record interface must fail validation."
)

marginal_private <- pending_fixture_nodes$N1
marginal_private$interface$hegemon_payoff_by_type <- list(theta_0 = NULL, theta_1 = NULL)
assert_true(
  !is_valid_pending_interface("N1", marginal_private),
  "A private node with a marginal payoff field must fail validation."
)

benchmark_in_private <- pending_fixture_nodes$N1
benchmark_in_private$interface$complete_information_benchmark <- list()
assert_true(
  !is_valid_pending_interface("N1", benchmark_in_private),
  "A benchmark field in a private interface must fail validation."
)

filled_n6 <- nodes$N6
filled_n6$interface$comparison_cells <- list(list(
  cell_id = "comparison-cell",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "exists",
  comparison_records = list(list(comparison_id = "forbidden-at-gate0")),
  nonexistence_certificate = NULL
))
assert_true(
  !is_valid_pending_interface("N6", filled_n6),
  "A pending N6 with filled comparison cells must fail validation."
)

filled_n6_private_rule <- nodes$N6
filled_n6_private_rule$interface$private_rule_cells$majority <- list(majority_private_exists)
assert_true(
  !is_valid_pending_interface("N6", filled_n6_private_rule),
  "A pending N6 with a filled private-rule collection must fail validation."
)

benchmark_in_n6 <- nodes$N6
benchmark_in_n6$interface$public_equilibrium_cells <- list()
assert_true(
  !is_valid_pending_interface("N6", benchmark_in_n6),
  "A public-benchmark field in N6 must fail validation."
)

wrong_n7_schema <- nodes$N7
wrong_n7_schema$interface$schema_ref <- "equilibrium_correspondence_v1"
assert_true(
  !is_valid_pending_interface("N7", wrong_n7_schema),
  "N7 must reject the private equilibrium schema."
)

filled_n7 <- nodes$N7
filled_n7$interface$public_equilibrium_cells$majority$R2$theta_0 <- list(list(
  cell_id = "public-cell",
  domain_conditions = list(expression = "mu in [0,1]"),
  existence_status = "none",
  public_equilibrium_records = list(),
  nonexistence_certificate = list(
    ledger_claim_ids = list("claim-no-public-equilibrium"),
    assumptions_used = list(),
    checks_performed = list("equilibrium-existence-check")
  )
))
assert_true(
  !is_valid_pending_interface("N7", filled_n7),
  "A pending N7 with filled public-equilibrium cells must fail validation."
)

filled_n7_rent <- nodes$N7
filled_n7_rent$interface$informational_rent_cells$majority <- list(majority_rent_exists)
assert_true(
  !is_valid_pending_interface("N7", filled_n7_rent),
  "A pending N7 with filled informational-rent cells must fail validation."
)

filled_n7_contrast <- nodes$N7
filled_n7_contrast$interface$informational_rent_contrast_cells <- list(contrast_none)
assert_true(
  !is_valid_pending_interface("N7", filled_n7_contrast),
  "A pending N7 with filled DeltaRI contrast cells must fail validation."
)

assert_true(identical(manifest$interface_hashing$algorithm, "sha256"), "Interface hashing must use SHA-256.")
assert_true(
  grepl("empty correspondence", manifest$interface_hashing$artifact_rule, fixed = TRUE) &&
    grepl("nonexistence certificate", manifest$interface_hashing$artifact_rule, fixed = TRUE) &&
    grepl("null coverage-cell collections", manifest$interface_hashing$pending_rule, fixed = TRUE),
  "Hashing and pending-state rules must preserve certified empty correspondences."
)
assert_true(
  grepl("transitive descendant", manifest$invalidation_rule$interface_change, fixed = TRUE),
  "The invalidation rule must cover all transitive descendants."
)
assert_true(
  grepl("pending", manifest$invalidation_rule$descendant_reset, fixed = TRUE),
  "Invalidated descendants must return to pending."
)
assert_true(
  grepl("N7 has no derivation descendants", manifest$invalidation_rule$terminal_benchmark, fixed = TRUE),
  "The invalidation rule must isolate the terminal benchmark."
)

is_valid_finding_counts <- function(finding_counts) {
  is.list(finding_counts) &&
    identical(names(finding_counts), as_character(freeze_gate$finding_count_fields)) &&
    all(vapply(finding_counts, function(value) {
      is.numeric(value) && length(value) == 1L && !is.na(value) &&
        value == freeze_gate$finding_count_value
    }, logical(1)))
}

is_valid_review <- function(review, node_hash) {
  is.list(review) &&
    identical(names(review), as_character(freeze_gate$review_record_fields)) &&
    is.character(review$reviewer_role) && length(review$reviewer_role) == 1L &&
    review$reviewer_role %in% as_character(freeze_gate$reviewer_roles) &&
    is.character(review$reviewer_id) && length(review$reviewer_id) == 1L &&
    nzchar(review$reviewer_id) &&
    identical(review$verdict, freeze_gate$verdict_value) &&
    identical(review$artifact_hash, node_hash) &&
    is_valid_finding_counts(review$finding_counts)
}

is_frozen <- function(node) {
  valid_hash <-
    is.character(node$artifact_hash) &&
    length(node$artifact_hash) == 1L &&
    grepl("^sha256:[0-9a-f]{64}$", node$artifact_hash)
  reviews <- node$reviews
  valid_reviews <-
    is.list(reviews) &&
    length(reviews) == as.integer(freeze_gate$review_count) &&
    valid_hash &&
    all(vapply(reviews, is_valid_review, logical(1), node_hash = node$artifact_hash))

  if (isTRUE(valid_reviews)) {
    reviewer_roles <- vapply(reviews, `[[`, character(1), "reviewer_role")
    reviewer_ids <- vapply(reviews, `[[`, character(1), "reviewer_id")
    valid_reviews <-
      identical(sort(reviewer_roles), sort(as_character(freeze_gate$reviewer_roles))) &&
      length(unique(reviewer_ids)) == as.integer(freeze_gate$review_count)
  }

  identical(node$status, freeze_gate$status_value) &&
    identical(node$frozen, freeze_gate$frozen_value) &&
    isTRUE(valid_hash) &&
    isTRUE(valid_reviews)
}

is_valid_filled_equilibrium_interface <- function(interface) {
  cells <- interface$correspondence_cells
  valid_records <- is.list(cells) && length(cells) > 0L && all(vapply(cells, function(cell) {
    records <- cell$equilibrium_records
    is.list(records) && length(records) > 0L && all(vapply(records, function(record) {
      is.list(record) &&
        identical(names(record), as_character(equilibrium_schema$record_fields)) &&
        identical(
          names(record$hegemon_payoff_by_type),
          as_character(equilibrium_schema$hegemon_payoff_by_type_fields)
        ) &&
        identical(
          names(record$outcome_distribution),
          as_character(equilibrium_schema$outcome_distribution_fields)
        )
    }, logical(1)))
  }, logical(1)))

  is.list(interface) &&
    identical(names(interface), c("schema_ref", "function_of", "correspondence_cells")) &&
    identical(interface$schema_ref, "equilibrium_correspondence_v1") &&
    identical(names(interface$function_of), c("name", "domain")) &&
    identical(interface$function_of$name, "entry_belief") &&
    identical(interface$function_of$domain, "[0,1]") &&
    is_valid_coverage_cells(cells, "equilibrium_records") &&
    isTRUE(valid_records)
}

expected_frozen_node_fields <- c(
  "id", "name", "round", "institution", "depends_on", "status", "interface",
  "artifact_path", "artifact_hash", "dependency_hashes", "started_order",
  "passed_order", "frozen", "reviews"
)
formal_reviewer_id <- "review-n1-n2-o1-formal-2026-08-18-r3"
game_reviewer_id <- "review-n1-n2-o1-game-2026-08-18-r3"
n3_formal_reviewer_id <- "review-n3-o1-formal-2026-08-18-r2"
n3_game_reviewer_id <- "review-n3-o1-game-2026-08-18-r2"

leaf_specs <- list(
  N1 = list(
    artifact_path = "essential_input_interfaces/n1_r2_majority_candidate_v1.json",
    artifact_hash = "sha256:af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd",
    dependency_hashes = list(),
    formal_reviewer_id = formal_reviewer_id,
    game_reviewer_id = game_reviewer_id,
    started_order = 1L,
    passed_order = 3L
  ),
  N2 = list(
    artifact_path = "essential_input_n2_r2_unanimity_interface.json",
    artifact_hash = "sha256:32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed",
    dependency_hashes = list(),
    formal_reviewer_id = formal_reviewer_id,
    game_reviewer_id = game_reviewer_id,
    started_order = 2L,
    passed_order = 4L
  ),
  N3 = list(
    artifact_path = "essential_input_interfaces/n3_r1_majority_candidate_v1.json",
    artifact_hash = "sha256:561026969956396dbcc8ee9015eb01eb839976385b3503332d9c6744b2fd951b",
    dependency_hashes = list(
      N1 = "sha256:af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd"
    ),
    formal_reviewer_id = n3_formal_reviewer_id,
    game_reviewer_id = n3_game_reviewer_id,
    started_order = 5L,
    passed_order = 6L
  )
)

for (node_id in names(leaf_specs)) {
  spec <- leaf_specs[[node_id]]
  spec$artifact_full_path <- normalizePath(
    file.path(manifest_dir, spec$artifact_path),
    mustWork = TRUE
  )
  spec$artifact_object <- jsonlite::fromJSON(spec$artifact_full_path, simplifyVector = FALSE)
  spec$computed_hash <- paste0("sha256:", sha256_file(spec$artifact_full_path))
  spec$artifact_text <- paste(
    readLines(spec$artifact_full_path, encoding = "UTF-8", warn = FALSE),
    collapse = "\n"
  )
  leaf_specs[[node_id]] <- spec
}

expected_reviews <- function(spec) {
  list(
    list(
      reviewer_role = "formal_design",
      reviewer_id = spec$formal_reviewer_id,
      verdict = "PASS",
      artifact_hash = spec$artifact_hash,
      finding_counts = list(critical = 0L, major = 0L, minor = 0L)
    ),
    list(
      reviewer_role = "game_theory",
      reviewer_id = spec$game_reviewer_id,
      verdict = "PASS",
      artifact_hash = spec$artifact_hash,
      finding_counts = list(critical = 0L, major = 0L, minor = 0L)
    )
  )
}

is_valid_current_leaf <- function(node, node_id, spec) {
  valid_dependency_hashes <- if (length(spec$dependency_hashes) == 0L) {
    is.list(node$dependency_hashes) && length(node$dependency_hashes) == 0L
  } else {
    identical(node$dependency_hashes, spec$dependency_hashes)
  }
  identical(names(node), expected_frozen_node_fields) &&
    identical(node$id, node_id) &&
    identical(node$status, "pass") &&
    identical(node$artifact_path, spec$artifact_path) &&
    identical(node$artifact_hash, spec$artifact_hash) &&
    identical(node$artifact_hash, spec$computed_hash) &&
    isTRUE(valid_dependency_hashes) &&
    identical(as.integer(node$started_order), spec$started_order) &&
    identical(as.integer(node$passed_order), spec$passed_order) &&
    node$started_order < node$passed_order &&
    identical(node$interface, spec$artifact_object) &&
    is_valid_filled_equilibrium_interface(node$interface) &&
    identical(node$reviews, expected_reviews(spec)) &&
    is_frozen(node) &&
    grepl("0 < o_0 < o_1 < 1", spec$artifact_text, fixed = TRUE) &&
    !grepl("0 < o_0 < o_1 <= y_bar", spec$artifact_text, fixed = TRUE)
}

for (node_id in names(leaf_specs)) {
  assert_true(
    is_valid_current_leaf(nodes[[node_id]], node_id, leaf_specs[[node_id]]),
    paste(
      node_id,
      "must match its exact reviewed artifact, dependency hashes, lifecycle, and PASS 0/0/0 reviews."
    )
  )
}
assert_true(
  identical(
    c(
      as.integer(nodes$N1$started_order),
      as.integer(nodes$N2$started_order),
      as.integer(nodes$N1$passed_order),
      as.integer(nodes$N2$passed_order),
      as.integer(nodes$N3$started_order),
      as.integer(nodes$N3$passed_order)
    ),
    1:6
  ) &&
    nodes$N2$started_order < nodes$N1$passed_order &&
    nodes$N3$started_order > nodes$N1$passed_order &&
    nodes$N3$started_order > nodes$N2$passed_order,
  paste0(
    "The parallel first frontier must record starts 1/2 and passes 3/4, followed by ",
    "N3 start/pass 5/6 in monotonic dependency-safe order."
  )
)

review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n1_n2_o1_formal_design_review_round3.md"
    ),
    expected_hash = "0b4e9d45ce7c721b15f90c26fe972af6f5d45300ff2a53ac3c8be3a560107cb1",
    reviewer_id = formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n1_n2_o1_game_theory_review_round3.md"
    ),
    expected_hash = "5b7cd25bce9566caa356ef8533b26f6b7d8157f4690c074b5a3719a0233b9970",
    reviewer_id = game_reviewer_id
  )
)

report_section <- function(lines, start_pattern, end_pattern) {
  start <- grep(start_pattern, lines)
  if (length(start) != 1L) {
    return(character())
  }
  later_end <- grep(end_pattern, lines)
  later_end <- later_end[later_end > start]
  end <- if (length(later_end) == 0L) length(lines) else later_end[[1L]] - 1L
  lines[start:end]
}

is_valid_review_report <- function(lines, role, spec) {
  if (!identical(lines, spec$canonical_lines)) {
    return(FALSE)
  }
  n1_section <- report_section(lines, "^## N1", "^## N2")
  n2_section <- report_section(lines, "^## N2", "^## Conclus")
  sections <- list(N1 = n1_section, N2 = n2_section)
  expected_hashes <- c(
    N1 = sub("^sha256:", "", leaf_specs$N1$artifact_hash),
    N2 = sub("^sha256:", "", leaf_specs$N2$artifact_hash)
  )
  valid_sections <- all(vapply(names(sections), function(node_id) {
    section <- sections[[node_id]]
    length(section) > 0L &&
      any(grepl("PASS", section, fixed = TRUE)) &&
      any(grepl("critical[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("major[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      any(grepl("minor[^0-9]*0", section, ignore.case = TRUE, perl = TRUE)) &&
      !any(grepl("FAIL", section, fixed = TRUE))
  }, logical(1)))

  length(lines) > 40L &&
    any(grepl(paste0("reviewer_role=", role), lines, fixed = TRUE)) &&
    any(grepl(paste0("reviewer_id=", spec$reviewer_id), lines, fixed = TRUE)) &&
    all(vapply(expected_hashes, function(hash) {
      any(grepl(hash, lines, fixed = TRUE))
    }, logical(1))) &&
    isTRUE(valid_sections)
}

for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved review report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved r3 review report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  review_report_specs[[role]] <- spec
  assert_true(
    is_valid_review_report(spec$canonical_lines, role, spec),
    paste("The saved r3 report lacks complete same-hash PASS 0/0/0 evidence for", role)
  )
}

n3_review_report_specs <- list(
  formal_design = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n3_o1_formal_design_review_round2.md"
    ),
    expected_hash = "f40976cb8a9664a0b51e10a14fa2ae4938ec44cc50e2718f1fd24d3ad70205f9",
    reviewer_id = n3_formal_reviewer_id
  ),
  game_theory = list(
    path = file.path(
      repository_root,
      "quality_reports",
      "2026-08-18_essential_input_goal1_n3_o1_game_theory_review_round2.md"
    ),
    expected_hash = "58f07c59bc845d82ecc6eba6b8ae864c65cf4f19104c303ca91203d23f5c3e5b",
    reviewer_id = n3_game_reviewer_id
  )
)

is_valid_n3_review_report <- function(lines, role, spec) {
  identical(lines, spec$canonical_lines) &&
    length(lines) > 40L &&
    any(grepl(paste0("reviewer_role=", role), lines, fixed = TRUE)) &&
    any(grepl(paste0("reviewer_id=", spec$reviewer_id), lines, fixed = TRUE)) &&
    any(grepl(sub("^sha256:", "", leaf_specs$N3$artifact_hash), lines, fixed = TRUE)) &&
    any(grepl("PASS", lines, fixed = TRUE)) &&
    any(grepl("critical[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("major[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    any(grepl("minor[^0-9]*0", lines, ignore.case = TRUE, perl = TRUE)) &&
    !any(grepl("FAIL", lines, fixed = TRUE))
}

for (role in names(n3_review_report_specs)) {
  spec <- n3_review_report_specs[[role]]
  assert_true(file.exists(spec$path), paste("Missing saved N3 round2 report for", role))
  assert_true(
    identical(sha256_file(spec$path), spec$expected_hash),
    paste("The complete saved N3 round2 review report changed for", role)
  )
  spec$canonical_lines <- readLines(spec$path, encoding = "UTF-8", warn = FALSE)
  n3_review_report_specs[[role]] <- spec
  assert_true(
    is_valid_n3_review_report(spec$canonical_lines, role, spec),
    paste("The saved N3 round2 report lacks same-hash PASS 0/0/0 evidence for", role)
  )
}

# Current-record mutations: any altered hash, object, lifecycle, dependency,
# reviewer, review hash, finding count, cardinality, or report evidence must fail.
for (node_id in names(leaf_specs)) {
  spec <- leaf_specs[[node_id]]
  mutate_and_reject <- function(label, mutate_node) {
    altered <- mutate_node(clone_object(nodes[[node_id]]))
    assert_true(
      !is_valid_current_leaf(altered, node_id, spec),
      paste("Negative current-leaf mutation passed:", node_id, label)
    )
  }
  mutate_and_reject("wrong artifact hash", function(x) {
    x$artifact_hash <- paste0("sha256:", paste(rep("0", 64L), collapse = "")); x
  })
  mutate_and_reject("wrong interface object", function(x) {
    x$interface$correspondence_cells[[1L]]$cell_id <- "CORRUPTED"; x
  })
  mutate_and_reject("wrong artifact path", function(x) {
    x$artifact_path <- "wrong.json"; x
  })
  mutate_and_reject("spurious dependency", function(x) {
    x$dependency_hashes$N0 <- spec$artifact_hash; x
  })
  if (length(spec$dependency_hashes) > 0L) {
    mutate_and_reject("missing required dependency", function(x) {
      x$dependency_hashes <- list(); x
    })
    mutate_and_reject("wrong required dependency hash", function(x) {
      dependency_id <- names(spec$dependency_hashes)[[1L]]
      x$dependency_hashes[[dependency_id]] <- paste0(
        "sha256:", paste(rep("d", 64L), collapse = "")
      )
      x
    })
  }
  mutate_and_reject("wrong execution order", function(x) {
    x$passed_order <- x$started_order; x
  })
  mutate_and_reject("wrong reviewer id", function(x) {
    x$reviews[[2L]]$reviewer_id <- "wrong-reviewer"; x
  })
  mutate_and_reject("wrong review hash", function(x) {
    x$reviews[[2L]]$artifact_hash <- paste0("sha256:", paste(rep("f", 64L), collapse = "")); x
  })
  mutate_and_reject("nonzero finding", function(x) {
    x$reviews[[1L]]$finding_counts$minor <- 1L; x
  })
  mutate_and_reject("extra review", function(x) {
    x$reviews[[3L]] <- x$reviews[[2L]]; x$reviews[[3L]]$reviewer_id <- "extra-reviewer"; x
  })
}

for (role in names(review_report_specs)) {
  spec <- review_report_specs[[role]]
  altered <- c(spec$canonical_lines, "FAIL")
  assert_true(
    !is_valid_review_report(altered, role, spec),
    paste("A mutated or truncated review report must fail for", role)
  )
}
for (role in names(n3_review_report_specs)) {
  spec <- n3_review_report_specs[[role]]
  altered <- c(spec$canonical_lines, "FAIL")
  assert_true(
    !is_valid_n3_review_report(altered, role, spec),
    paste("A mutated or appended N3 round2 report must fail for", role)
  )
}

topologically_ready_nodes <- function(candidate_nodes) {
  candidate_ids <- names(candidate_nodes)
  candidate_ids[vapply(candidate_ids, function(node_id) {
    node <- candidate_nodes[[node_id]]
    identical(node$status, "pending") &&
      all(vapply(as_character(node$depends_on), function(dependency_id) {
        is_frozen(candidate_nodes[[dependency_id]])
      }, logical(1)))
  }, logical(1))]
}

frozen_hash <- paste0("sha256:", paste(rep("a", 64L), collapse = ""))
make_review <- function(reviewer_role, reviewer_id, artifact_hash = frozen_hash) {
  list(
    reviewer_role = reviewer_role,
    reviewer_id = reviewer_id,
    verdict = "PASS",
    artifact_hash = artifact_hash,
    finding_counts = list(critical = 0L, major = 0L, minor = 0L)
  )
}

freeze_node <- function(
    candidate_nodes,
    node_id,
    include_hash = TRUE,
    status = "pass",
    include_frozen = TRUE,
    include_reviews = TRUE) {
  candidate_nodes[[node_id]]$status <- status
  if (isTRUE(include_hash)) {
    candidate_nodes[[node_id]]$artifact_hash <- frozen_hash
  }
  if (isTRUE(include_frozen)) {
    candidate_nodes[[node_id]]$frozen <- TRUE
  }
  if (isTRUE(include_reviews)) {
    candidate_nodes[[node_id]]$reviews <- list(
      make_review("formal_design", "reviewer-formal-design"),
      make_review("game_theory", "reviewer-game-theory")
    )
  }
  candidate_nodes
}

assert_true(
  identical(topologically_ready_nodes(nodes), "N4"),
  paste0(
    "After N3 freezes, only N4 may be topologically ready, and N4 remains explicitly ",
    "unauthorized. Topological readiness is not author authorization."
  )
)
assert_true(
  identical(sort(topologically_ready_nodes(pending_fixture_nodes)), c("N1", "N2")),
  "The synthetic all-pending lifecycle must retain N1 and N2 as the initial ready antichain."
)

# Missing any freeze fact prevents consumption.
n1_unhashed <- freeze_node(pending_fixture_nodes, "N1", include_hash = FALSE)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_unhashed)),
  "N1 without a frozen hash must not release N3."
)
n2_unhashed <- freeze_node(pending_fixture_nodes, "N2", include_hash = FALSE)
assert_true(
  !("N4" %in% topologically_ready_nodes(n2_unhashed)),
  "N2 without a frozen hash must not release N4."
)

n1_pass_hash_only <- freeze_node(
  pending_fixture_nodes,
  "N1",
  include_frozen = FALSE,
  include_reviews = FALSE
)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_pass_hash_only)),
  "PASS plus a hash without frozen and reviews must not release N3."
)

n1_without_reviews <- freeze_node(pending_fixture_nodes, "N1", include_reviews = FALSE)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_without_reviews)),
  "A frozen flag and hash without reviews must not release N3."
)

n1_one_review <- freeze_node(pending_fixture_nodes, "N1")
n1_one_review$N1$reviews <- n1_one_review$N1$reviews[1]
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_one_review)),
  "Exactly one review must not release N3."
)

n1_wrong_review_hash <- freeze_node(pending_fixture_nodes, "N1")
n1_wrong_review_hash$N1$reviews[[2]]$artifact_hash <- paste0(
  "sha256:", paste(rep("b", 64L), collapse = "")
)
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_wrong_review_hash)),
  "A review of a different hash must not release N3."
)

n1_nonzero_finding <- freeze_node(pending_fixture_nodes, "N1")
n1_nonzero_finding$N1$reviews[[1]]$finding_counts$minor <- 1L
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_nonzero_finding)),
  "A review with any nonzero finding count must not release N3."
)

n1_duplicate_reviewer <- freeze_node(pending_fixture_nodes, "N1")
n1_duplicate_reviewer$N1$reviews[[2]]$reviewer_id <-
  n1_duplicate_reviewer$N1$reviews[[1]]$reviewer_id
assert_true(
  !("N3" %in% topologically_ready_nodes(n1_duplicate_reviewer)),
  "Two review roles carried by the same reviewer id must not release N3."
)

# Frozen leaves release only their direct private-model consumers.
n1_frozen <- freeze_node(pending_fixture_nodes, "N1")
assert_true(
  "N3" %in% topologically_ready_nodes(n1_frozen),
  "Frozen N1 must make N3 topologically ready."
)
n2_frozen <- freeze_node(pending_fixture_nodes, "N2")
assert_true(
  "N4" %in% topologically_ready_nodes(n2_frozen),
  "Frozen N2 must make N4 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(n1_frozen)),
  "A frozen N1 must not make N7 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(n2_frozen)),
  "A frozen N2 must not make N7 topologically ready."
)

# N6 requires both R1 interfaces; either one alone is insufficient.
both_leaves_frozen <- freeze_node(freeze_node(pending_fixture_nodes, "N1"), "N2")
n3_only <- freeze_node(both_leaves_frozen, "N3")
assert_true(
  !("N6" %in% topologically_ready_nodes(n3_only)),
  "N3 alone must not make N6 topologically ready."
)
n4_only <- freeze_node(both_leaves_frozen, "N4")
assert_true(
  !("N6" %in% topologically_ready_nodes(n4_only)),
  "N4 alone must not make N6 topologically ready."
)

n3_unhashed_with_n4 <- freeze_node(n4_only, "N3", include_hash = FALSE)
assert_true(
  !("N6" %in% topologically_ready_nodes(n3_unhashed_with_n4)),
  "N3 without a frozen hash must not release N6 even when N4 is frozen."
)
n4_unhashed_with_n3 <- freeze_node(n3_only, "N4", include_hash = FALSE)
assert_true(
  !("N6" %in% topologically_ready_nodes(n4_unhashed_with_n3)),
  "N4 without a frozen hash must not release N6 even when N3 is frozen."
)

both_r1_frozen <- freeze_node(n3_only, "N4")
assert_true(
  "N6" %in% topologically_ready_nodes(both_r1_frozen),
  "Frozen N3 and N4 must make N6 topologically ready."
)
assert_true(
  !("N7" %in% topologically_ready_nodes(both_r1_frozen)),
  "Frozen N3 and N4 must not bypass N6 to make N7 topologically ready."
)

# N7 is terminal and requires N6 itself to be frozen.
n6_unhashed <- freeze_node(both_r1_frozen, "N6", include_hash = FALSE)
assert_true(
  !("N7" %in% topologically_ready_nodes(n6_unhashed)),
  "N6 without a frozen hash must not make N7 topologically ready."
)
n6_hash_without_pass <- freeze_node(both_r1_frozen, "N6", include_hash = TRUE, status = "pending")
assert_true(
  !("N7" %in% topologically_ready_nodes(n6_hash_without_pass)),
  "An N6 hash without PASS must not make N7 topologically ready."
)
n6_frozen <- freeze_node(both_r1_frozen, "N6")
assert_true(
  "N7" %in% topologically_ready_nodes(n6_frozen),
  "Only frozen N6 must make N7 topologically ready."
)

direct_dependents <- function(candidate_nodes, node_id) {
  names(candidate_nodes)[vapply(candidate_nodes, function(node) {
    node_id %in% as_character(node$depends_on)
  }, logical(1))]
}

descendants <- function(candidate_nodes, changed_id) {
  found <- character()
  frontier <- changed_id
  while (length(frontier) > 0L) {
    children <- unique(unlist(lapply(
      frontier,
      function(node_id) direct_dependents(candidate_nodes, node_id)
    ), use.names = FALSE))
    children <- setdiff(children, found)
    found <- c(found, children)
    frontier <- children
  }
  sort(found)
}

expected_invalidations <- list(
  N1 = c("N3", "N6", "N7"),
  N2 = c("N4", "N6", "N7"),
  N3 = c("N6", "N7"),
  N4 = c("N6", "N7"),
  N6 = "N7",
  N7 = character()
)
for (node_id in expected_ids) {
  assert_true(
    identical(descendants(nodes, node_id), expected_invalidations[[node_id]]),
    paste(node_id, "has the wrong invalidation descendants.")
  )
}

cat(
  paste0(
    "PASS: strict o_1 < 1 contract and six-node essential-input DAG with N1/N2 frozen on r3-reviewed artifacts and ",
    "N3 frozen on its round2-reviewed artifact; only N4 is topologically ready and it remains explicitly unauthorized. ",
    "Typed coverage cells for empty and ",
    "nonempty correspondences, independent RI_M and RI_U with a separate DeltaRI ",
    "contrast, role-typed public payoffs, terminal complete-information benchmark, ",
    "two-review freeze gates, topological readiness, negative schema tests, and ",
    "invalidation rules verified. Topological ",
    "readiness does not grant author authorization; Section 11 controls.\n"
  )
)
