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

manifest <- jsonlite::fromJSON(manifest_path, simplifyVector = FALSE)
nodes <- manifest$nodes
node_ids <- vapply(nodes, `[[`, character(1), "id")
names(nodes) <- node_ids

assert_true(
  identical(manifest$schema_version, "essential-input-gate0-v3"),
  "The manifest must use the terminal-benchmark Gate 0 schema version."
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
  identical(as_character(comparison_schema$source_node_fields), c("N3", "N4")),
  "The private comparison schema has the wrong source-node fields."
)

benchmark_schema <- schemas$complete_information_benchmark_v1
assert_true(
  identical(as_character(benchmark_schema$applies_to), "N7"),
  "The complete-information benchmark schema must apply exactly to N7."
)
assert_true(
  identical(
    as_character(benchmark_schema$public_equilibrium_record_fields),
    c(
      "public_equilibrium_id",
      "institution",
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
      "admissibility_conditions",
      "private_source_record_ids",
      "public_source_record_ids",
      "source_interface_hash",
      "RI_U",
      "RI_M",
      "DeltaRI",
      "ex_ante_images",
      "envelopes",
      "selection_status",
      "robustness_indicators"
    )
  ),
  "The informational-rent record has the wrong fields."
)
assert_true(
  identical(as_character(benchmark_schema$institution_fields), c("majority", "unanimity")),
  "The benchmark schema has the wrong institution fields."
)
assert_true(
  identical(as_character(benchmark_schema$type_fields), c("theta_0", "theta_1")),
  "The benchmark schema has the wrong type fields."
)
assert_true(
  identical(
    as_character(benchmark_schema$outcome_distribution_fields),
    c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  ),
  "The benchmark schema has the wrong outcome fields."
)

is_valid_pending_interface <- function(node_id, node) {
  interface <- node$interface
  forbidden_formation_fields <- c("formation", "formation_decision", "entry_decision", "entry_cost")
  if (any(forbidden_formation_fields %in% all_field_names(interface))) {
    return(FALSE)
  }

  if (node_id %in% c("N1", "N2", "N3", "N4")) {
    return(
      identical(names(interface), c("schema_ref", "function_of", "joint_records")) &&
        identical(interface$schema_ref, "equilibrium_correspondence_v1") &&
        identical(interface$function_of$name, "entry_belief") &&
        identical(interface$function_of$domain, "[0,1]") &&
        is.null(interface$joint_records) &&
        !("complete_information_benchmark" %in% all_field_names(interface)) &&
        !("public_equilibrium_records" %in% all_field_names(interface)) &&
        !("informational_rent_records" %in% all_field_names(interface))
    )
  }

  if (identical(node_id, "N6")) {
    return(
      identical(names(interface), c("schema_ref", "function_of", "comparison_records")) &&
        identical(interface$schema_ref, "private_information_comparison_v1") &&
        identical(interface$function_of$name, "entry_belief") &&
        identical(interface$function_of$domain, "[0,1]") &&
        is.null(interface$comparison_records) &&
        !("complete_information_benchmark" %in% all_field_names(interface)) &&
        !("public_equilibrium_records" %in% all_field_names(interface)) &&
        !("informational_rent_records" %in% all_field_names(interface))
    )
  }

  if (identical(node_id, "N7")) {
    public_records <- interface$public_equilibrium_records
    valid_public_shape <-
      identical(names(public_records), c("majority", "unanimity")) &&
      all(vapply(public_records, function(rule_records) {
        identical(names(rule_records), c("theta_0", "theta_1")) &&
          all(vapply(rule_records, is.null, logical(1)))
      }, logical(1)))

    return(
      identical(
        names(interface),
        c(
          "schema_ref",
          "function_of",
          "public_equilibrium_records",
          "informational_rent_records"
        )
      ) &&
        identical(interface$schema_ref, "complete_information_benchmark_v1") &&
        identical(interface$function_of$name, "prior_mu") &&
        identical(interface$function_of$domain, "[0,1]") &&
        valid_public_shape &&
        is.null(interface$informational_rent_records) &&
        !("joint_records" %in% all_field_names(interface)) &&
        !("comparison_records" %in% all_field_names(interface))
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
  assert_true(identical(node$status, "pending"), paste(node_id, "must remain pending at Gate 0."))

  forbidden_fields <- c(
    "result", "artifact_path", "artifact_hash", "dependency_hashes",
    "started_order", "passed_order", "review", "reviews"
  )
  assert_true(
    !any(forbidden_fields %in% names(node)),
    paste(node_id, "contains a result or execution field.")
  )
  assert_true(
    is_valid_pending_interface(node_id, node),
    paste(node_id, "has the wrong pending interface schema or a filled record collection.")
  )
}

# Negative schema tests: Gate 0 must reject filled, marginal, or cross-family interfaces.
filled_private <- nodes$N1
filled_private$interface$joint_records <- list(list(equilibrium_id = "forbidden-at-gate0"))
assert_true(
  !is_valid_pending_interface("N1", filled_private),
  "A pending private node with filled joint records must fail validation."
)

marginal_private <- nodes$N1
marginal_private$interface$hegemon_payoff_by_type <- list(theta_0 = NULL, theta_1 = NULL)
assert_true(
  !is_valid_pending_interface("N1", marginal_private),
  "A private node with a marginal payoff field must fail validation."
)

benchmark_in_private <- nodes$N1
benchmark_in_private$interface$complete_information_benchmark <- list()
assert_true(
  !is_valid_pending_interface("N1", benchmark_in_private),
  "A benchmark field in a private interface must fail validation."
)

wrong_n7_schema <- nodes$N7
wrong_n7_schema$interface$schema_ref <- "equilibrium_correspondence_v1"
assert_true(
  !is_valid_pending_interface("N7", wrong_n7_schema),
  "N7 must reject the private equilibrium schema."
)

filled_n7 <- nodes$N7
filled_n7$interface$public_equilibrium_records$majority$theta_0 <- list(list())
assert_true(
  !is_valid_pending_interface("N7", filled_n7),
  "A pending N7 with filled public-equilibrium records must fail validation."
)

assert_true(identical(manifest$interface_hashing$algorithm, "sha256"), "Interface hashing must use SHA-256.")
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

is_frozen <- function(node) {
  identical(node$status, "pass") &&
    is.character(node$artifact_hash) &&
    length(node$artifact_hash) == 1L &&
    grepl("^sha256:[0-9a-f]{64}$", node$artifact_hash)
}

ready_nodes <- function(candidate_nodes) {
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
freeze_node <- function(candidate_nodes, node_id, include_hash = TRUE, status = "pass") {
  candidate_nodes[[node_id]]$status <- status
  if (isTRUE(include_hash)) {
    candidate_nodes[[node_id]]$artifact_hash <- frozen_hash
  }
  candidate_nodes
}

assert_true(
  identical(sort(ready_nodes(nodes)), c("N1", "N2")),
  "N1 and N2 must be the only initially ready antichain."
)

# A PASS label alone is not a frozen interface and cannot release a consumer.
n1_unhashed <- freeze_node(nodes, "N1", include_hash = FALSE)
assert_true(!("N3" %in% ready_nodes(n1_unhashed)), "N1 without a frozen hash must not release N3.")
n2_unhashed <- freeze_node(nodes, "N2", include_hash = FALSE)
assert_true(!("N4" %in% ready_nodes(n2_unhashed)), "N2 without a frozen hash must not release N4.")

# Frozen leaves release only their direct private-model consumers.
n1_frozen <- freeze_node(nodes, "N1")
assert_true("N3" %in% ready_nodes(n1_frozen), "Frozen N1 must release N3.")
n2_frozen <- freeze_node(nodes, "N2")
assert_true("N4" %in% ready_nodes(n2_frozen), "Frozen N2 must release N4.")
assert_true(!("N7" %in% ready_nodes(n1_frozen)), "A frozen N1 must not release N7.")
assert_true(!("N7" %in% ready_nodes(n2_frozen)), "A frozen N2 must not release N7.")

# N6 requires both R1 interfaces; either one alone is insufficient.
both_leaves_frozen <- freeze_node(freeze_node(nodes, "N1"), "N2")
n3_only <- freeze_node(both_leaves_frozen, "N3")
assert_true(!("N6" %in% ready_nodes(n3_only)), "N3 alone must not release N6.")
n4_only <- freeze_node(both_leaves_frozen, "N4")
assert_true(!("N6" %in% ready_nodes(n4_only)), "N4 alone must not release N6.")

n3_unhashed_with_n4 <- freeze_node(n4_only, "N3", include_hash = FALSE)
assert_true(
  !("N6" %in% ready_nodes(n3_unhashed_with_n4)),
  "N3 without a frozen hash must not release N6 even when N4 is frozen."
)
n4_unhashed_with_n3 <- freeze_node(n3_only, "N4", include_hash = FALSE)
assert_true(
  !("N6" %in% ready_nodes(n4_unhashed_with_n3)),
  "N4 without a frozen hash must not release N6 even when N3 is frozen."
)

both_r1_frozen <- freeze_node(n3_only, "N4")
assert_true("N6" %in% ready_nodes(both_r1_frozen), "Frozen N3 and N4 must release N6.")
assert_true(!("N7" %in% ready_nodes(both_r1_frozen)), "Frozen N3 and N4 must not bypass N6 to release N7.")

# N7 is terminal and requires N6 itself to be frozen.
n6_unhashed <- freeze_node(both_r1_frozen, "N6", include_hash = FALSE)
assert_true(!("N7" %in% ready_nodes(n6_unhashed)), "N6 without a frozen hash must not release N7.")
n6_hash_without_pass <- freeze_node(both_r1_frozen, "N6", include_hash = TRUE, status = "pending")
assert_true(!("N7" %in% ready_nodes(n6_hash_without_pass)), "An N6 hash without PASS must not release N7.")
n6_frozen <- freeze_node(both_r1_frozen, "N6")
assert_true("N7" %in% ready_nodes(n6_frozen), "Only frozen N6 must release N7.")

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
    "PASS: six-node essential-input Gate 0 DAG, joint private-equilibrium records, ",
    "terminal complete-information benchmark, readiness gates, negative schema tests, ",
    "and invalidation rules verified.\n"
  )
)
