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

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the verifier path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
manifest_path <- file.path(repository_root, "model_redesign", "essential_input_game_dag.json")

manifest <- jsonlite::fromJSON(manifest_path, simplifyVector = FALSE)
nodes <- manifest$nodes
node_ids <- vapply(nodes, `[[`, character(1), "id")
names(nodes) <- node_ids

assert_true(identical(manifest$schema_version, "essential-input-gate0-v2"), "The manifest must use the post-decisions Gate 0 schema version.")

expected_ids <- c("N1", "N2", "N3", "N4", "N6")
expected_names <- c(
  N1 = "r2_majority",
  N2 = "r2_unanimity",
  N3 = "r1_majority",
  N4 = "r1_unanimity",
  N6 = "comparison"
)
expected_dependencies <- list(
  N1 = character(),
  N2 = character(),
  N3 = "N1",
  N4 = "N2",
  N6 = c("N3", "N4")
)

assert_true(identical(node_ids, expected_ids), "The DAG must contain exactly N1, N2, N3, N4, and N6 in order.")
assert_true(length(unique(node_ids)) == 5L, "The five node ids must be unique.")
assert_true(!("N5" %in% node_ids), "N5 entry must be absent from the baseline DAG.")

for (node_id in expected_ids) {
  node <- nodes[[node_id]]
  assert_true(identical(node$name, unname(expected_names[[node_id]])), paste(node_id, "has the wrong name."))
  dependencies <- as.character(unlist(node$depends_on, use.names = FALSE))
  assert_true(identical(dependencies, expected_dependencies[[node_id]]), paste(node_id, "has the wrong dependencies."))
  assert_true(identical(node$status, "pending"), paste(node_id, "must remain pending at Gate 0."))

  forbidden_fields <- c(
    "result", "artifact_path", "artifact_hash", "dependency_hashes",
    "started_order", "passed_order", "review", "reviews"
  )
  assert_true(!any(forbidden_fields %in% names(node)), paste(node_id, "contains a result or execution field."))

  interface <- node$interface
  assert_true(identical(interface$function_of$name, "entry_belief"), paste(node_id, "must be a function of entry_belief."))
  assert_true(identical(interface$function_of$domain, "[0,1]"), paste(node_id, "has the wrong belief domain."))

  required_interface_fields <- c(
    "function_of",
    "recognized_proposer_payoff",
    "weak_nonproposer_pre_recognition_expected_value",
    "hegemon_payoff_by_type",
    "outcome_distribution",
    "complete_information_benchmark"
  )
  assert_true(identical(names(interface), required_interface_fields), paste(node_id, "has the wrong interface schema."))
  assert_true(is.null(interface$recognized_proposer_payoff), paste(node_id, "has a filled proposer payoff."))
  assert_true(is.null(interface$weak_nonproposer_pre_recognition_expected_value), paste(node_id, "has a filled weak-state value."))
  assert_true(identical(names(interface$hegemon_payoff_by_type), c("theta_0", "theta_1")), paste(node_id, "has the wrong H-type schema."))
  assert_true(all(vapply(interface$hegemon_payoff_by_type, is.null, logical(1))), paste(node_id, "has a filled H payoff."))

  required_outcomes <- c("pass_with_hegemon", "pass_without_hegemon", "failure", "delay")
  assert_true(identical(names(interface$outcome_distribution), required_outcomes), paste(node_id, "has the wrong outcome schema."))
  assert_true(all(vapply(interface$outcome_distribution, is.null, logical(1))), paste(node_id, "has a filled outcome distribution."))
  if (identical(node$round, "R1")) {
    assert_true("delay" %in% names(interface$outcome_distribution), paste(node_id, "must export delay."))
  }

  benchmark <- interface$complete_information_benchmark
  assert_true(identical(names(benchmark), "hegemon_payoff_by_type"), paste(node_id, "has the wrong complete-information benchmark schema."))
  assert_true(identical(names(benchmark$hegemon_payoff_by_type), c("theta_0", "theta_1")), paste(node_id, "has the wrong complete-information H-type schema."))
  assert_true(all(vapply(benchmark$hegemon_payoff_by_type, is.null, logical(1))), paste(node_id, "has a filled complete-information benchmark."))

  forbidden_formation_fields <- c("formation", "formation_decision", "entry_decision", "entry_cost")
  assert_true(!any(forbidden_formation_fields %in% names(interface)), paste(node_id, "contains a formation coordinate."))
}

assert_true(identical(manifest$interface_hashing$algorithm, "sha256"), "Interface hashing must use SHA-256.")
assert_true(grepl("transitive descendant", manifest$invalidation_rule$interface_change, fixed = TRUE), "The invalidation rule must cover all transitive descendants.")
assert_true(grepl("pending", manifest$invalidation_rule$descendant_reset, fixed = TRUE), "Invalidated descendants must return to pending.")

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
      all(vapply(unlist(node$depends_on, use.names = FALSE), function(dependency_id) {
        is_frozen(candidate_nodes[[dependency_id]])
      }, logical(1)))
  }, logical(1))]
}

frozen_hash <- paste0("sha256:", paste(rep("a", 64L), collapse = ""))
freeze_node <- function(candidate_nodes, node_id, include_hash = TRUE) {
  candidate_nodes[[node_id]]$status <- "pass"
  if (isTRUE(include_hash)) {
    candidate_nodes[[node_id]]$artifact_hash <- frozen_hash
  }
  candidate_nodes
}

assert_true(identical(sort(ready_nodes(nodes)), c("N1", "N2")), "N1 and N2 must be the only initially ready antichain.")

# A PASS label alone is not a frozen interface and cannot release a consumer.
n1_unhashed <- freeze_node(nodes, "N1", include_hash = FALSE)
assert_true(!("N3" %in% ready_nodes(n1_unhashed)), "N1 without a frozen hash must not release N3.")
n2_unhashed <- freeze_node(nodes, "N2", include_hash = FALSE)
assert_true(!("N4" %in% ready_nodes(n2_unhashed)), "N2 without a frozen hash must not release N4.")

# A frozen leaf does release its sole direct consumer.
n1_frozen <- freeze_node(nodes, "N1")
assert_true("N3" %in% ready_nodes(n1_frozen), "Frozen N1 must release N3.")
n2_frozen <- freeze_node(nodes, "N2")
assert_true("N4" %in% ready_nodes(n2_frozen), "Frozen N2 must release N4.")

# N6 requires both R1 interfaces; either one alone is insufficient.
n3_only <- freeze_node(freeze_node(freeze_node(nodes, "N1"), "N2"), "N3")
assert_true(!("N6" %in% ready_nodes(n3_only)), "N3 alone must not release N6.")
n4_only <- freeze_node(freeze_node(freeze_node(nodes, "N1"), "N2"), "N4")
assert_true(!("N6" %in% ready_nodes(n4_only)), "N4 alone must not release N6.")

n3_unhashed_with_n4 <- freeze_node(n4_only, "N3", include_hash = FALSE)
assert_true(!("N6" %in% ready_nodes(n3_unhashed_with_n4)), "N3 without a frozen hash must not release N6 even when N4 is frozen.")
n4_unhashed_with_n3 <- freeze_node(n3_only, "N4", include_hash = FALSE)
assert_true(!("N6" %in% ready_nodes(n4_unhashed_with_n3)), "N4 without a frozen hash must not release N6 even when N3 is frozen.")

both_r1_frozen <- freeze_node(n3_only, "N4")
assert_true("N6" %in% ready_nodes(both_r1_frozen), "Frozen N3 and N4 must release N6.")

direct_dependents <- function(candidate_nodes, node_id) {
  names(candidate_nodes)[vapply(candidate_nodes, function(node) {
    node_id %in% unlist(node$depends_on, use.names = FALSE)
  }, logical(1))]
}

descendants <- function(candidate_nodes, changed_id) {
  found <- character()
  frontier <- changed_id
  while (length(frontier) > 0L) {
    children <- unique(unlist(lapply(frontier, function(node_id) direct_dependents(candidate_nodes, node_id)), use.names = FALSE))
    children <- setdiff(children, found)
    found <- c(found, children)
    frontier <- children
  }
  sort(found)
}

expected_invalidations <- list(
  N1 = c("N3", "N6"),
  N2 = c("N4", "N6"),
  N3 = "N6",
  N4 = "N6",
  N6 = character()
)
for (node_id in expected_ids) {
  assert_true(identical(descendants(nodes, node_id), expected_invalidations[[node_id]]), paste(node_id, "has the wrong invalidation descendants."))
}

cat("PASS: five-node essential-input Gate 0 DAG, empty interface schema, complete-information benchmark, readiness gates, and invalidation rules verified.\n")
