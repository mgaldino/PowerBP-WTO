#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

batch_path <- "model_redesign/pivotal_response_interfaces/entry_batch_review_v1.json"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
r1_batch_path <- "model_redesign/pivotal_response_interfaces/r1_batch_frozen_v1.json"
r2_batch_path <- "model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json"
u_path <- "model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json"
m_path <- "model_redesign/pivotal_response_interfaces/entry_majority_v1.json"
u_checks_path <- "tables/pivotal_response_entry_unanimity_checks.csv"
m_checks_path <- "tables/pivotal_response_entry_majority_checks_v1.csv"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
review_path <- "quality_reports/2026-08-12_pivotal_response_entry_batch_independent_review.md"
status_path <- "quality_reports/2026-08-12_pivotal_response_entry_batch_status.md"
checks_path <- "tables/pivotal_response_entry_batch_checks_v1.csv"
skill_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"

required <- c(
  batch_path, dag_path, gate0_path, r1_batch_path, r2_batch_path, u_path, m_path,
  u_checks_path, m_checks_path, protected_path, ledger_path, review_path,
  status_path, skill_checker
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing entry-batch artifacts: ", paste(missing, collapse = ", "))

checks <- data.frame(check_id = character(), status = character(), detail = character())
add_check <- function(id, condition, pass_detail, fail_detail = pass_detail) {
  ok <- isTRUE(condition)
  checks <<- rbind(
    checks,
    data.frame(
      check_id = id,
      status = if (ok) "PASS" else "FAIL",
      detail = if (ok) pass_detail else fail_detail
    )
  )
  invisible(ok)
}
sha256_file <- function(path) {
  out <- suppressWarnings(system2("shasum", c("-a", "256", path), stdout = TRUE, stderr = FALSE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  if (!length(out) || status != 0L) return(NA_character_)
  strsplit(trimws(out[[1L]]), "[[:space:]]+")[[1L]][[1L]]
}
clone_record <- function(x) unserialize(serialize(x, NULL))
node_map <- function(dag) {
  stats::setNames(dag$nodes, vapply(dag$nodes, function(x) x$id, character(1)))
}
is_frozen <- function(node) {
  identical(node$status, "pass") && is.character(node$artifact_hash) && nzchar(node$artifact_hash)
}
ready_nodes <- function(dag) {
  nodes <- node_map(dag)
  ready <- vapply(nodes, function(x) {
    identical(x$status, "pending") &&
      all(vapply(x$depends_on, function(dep) is_frozen(nodes[[dep]]), logical(1)))
  }, logical(1))
  sort(names(ready)[ready])
}
dependency_links_valid <- function(dag) {
  nodes <- node_map(dag)
  all(vapply(nodes, function(node) {
    if (!node$status %in% c("in_progress", "pass")) return(TRUE)
    if (!length(node$depends_on)) return(TRUE)
    frozen <- node$dependency_hashes
    if (is.null(frozen)) return(FALSE)
    all(vapply(node$depends_on, function(dep) {
      is_frozen(nodes[[dep]]) && identical(frozen[[dep]], nodes[[dep]]$artifact_hash)
    }, logical(1)))
  }, logical(1)))
}
has_path <- function(nodes, start, target) {
  queue <- nodes[[start]]$depends_on
  seen <- character()
  while (length(queue)) {
    current <- queue[[1L]]
    queue <- queue[-1L]
    if (identical(current, target)) return(TRUE)
    if (current %in% seen) next
    seen <- c(seen, current)
    queue <- c(queue, nodes[[current]]$depends_on)
  }
  FALSE
}
resolve_components <- function(parent_path, components) {
  parent_dir <- dirname(normalizePath(parent_path, mustWork = TRUE))
  vapply(components, function(x) {
    normalizePath(file.path(parent_dir, x$path), mustWork = TRUE)
  }, character(1))
}
component_hashes_match <- function(parent_path, components) {
  paths <- resolve_components(parent_path, components)
  declared <- vapply(components, function(x) x$sha256, character(1))
  actual <- unname(vapply(paths, sha256_file, character(1)))
  identical(actual, declared)
}
run_node_verifier <- function(path) {
  out <- suppressWarnings(system2("Rscript", c("--vanilla", path), stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = paste(out, collapse = "\n"))
}

batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
gate0 <- jsonlite::fromJSON(gate0_path, simplifyVector = FALSE)
r1_batch <- jsonlite::fromJSON(r1_batch_path, simplifyVector = FALSE)
r2_batch <- jsonlite::fromJSON(r2_batch_path, simplifyVector = FALSE)
u <- jsonlite::fromJSON(u_path, simplifyVector = FALSE)
m <- jsonlite::fromJSON(m_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
review_text <- paste(readLines(review_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
status_text <- paste(readLines(status_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

expected <- c(
  gate0 = "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1",
  r2_batch = "00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a",
  r1_batch = "f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a",
  entry_unanimity = "05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6",
  entry_majority = "4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21",
  batch = "8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433"
)
rejected_u <- "efa5933adba180bff9d1c8ffd6ff6c53b7dc5345de72b14f088a7dd2542553e8"

add_check(
  "batch_identity_and_hash",
  identical(batch$state_id, "entry_batch_review") && identical(batch$status, "pass") &&
    identical(batch$batch_close$validated_common_existence_domain, "N>=3") &&
    identical(sha256_file(batch_path), expected[["batch"]]),
  paste("Entry batch PASS interface:", expected[["batch"]]),
  "Batch identity, common domain, status, or exact hash differs."
)
add_check(
  "reviewed_upstream_exact",
  identical(sha256_file(gate0_path), expected[["gate0"]]) &&
    identical(sha256_file(r2_batch_path), expected[["r2_batch"]]) &&
    identical(sha256_file(r1_batch_path), expected[["r1_batch"]]) &&
    identical(batch$reviewed_upstream[[1L]]$sha256, expected[["gate0"]]) &&
    identical(batch$reviewed_upstream[[2L]]$sha256, expected[["r1_batch"]]),
  "Gate 0, R2 batch, and R1 batch retain their exact frozen hashes.",
  "An upstream freeze changed or is declared incorrectly."
)

roles <- vapply(batch$components, function(x) x$role, character(1))
nodes <- vapply(batch$components, function(x) x$node, character(1))
add_check(
  "component_inventory",
  length(batch$components) == 19L &&
    sum(roles == "entry_interface") == 2L && sum(roles == "derivation_note") == 2L &&
    sum(roles == "candidate_status_snapshot") == 2L && sum(roles == "node_verifier") == 2L &&
    sum(roles == "node_check_table") == 2L && sum(roles == "assessment_fixture_table") == 2L &&
    sum(roles == "type_identity_fixture_table") == 2L && sum(roles == "endpoint_logic_table") == 2L &&
    all(c("gate0_contract", "r1_batch_frozen", "entry_unanimity", "entry_majority") %in% unique(nodes)),
  "Batch inventories 19 upstream, interface, note, status, verifier, and table components.",
  paste("Unexpected roles:", paste(roles, collapse = ", "))
)
add_check(
  "component_hashes_exact",
  component_hashes_match(batch_path, batch$components),
  "All 19 entry-batch component hashes match exact bytes.",
  "At least one entry-batch component hash differs."
)
add_check(
  "transitive_component_hashes_exact",
  length(gate0$components) == 5L && component_hashes_match(gate0_path, gate0$components) &&
    length(r2_batch$components) == 19L && component_hashes_match(r2_batch_path, r2_batch$components) &&
    length(r1_batch$components) == 17L && component_hashes_match(r1_batch_path, r1_batch$components),
  "All 5 Gate 0, 19 R2-batch, and 17 R1-batch transitive components match.",
  "A transitive frozen component changed."
)

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) & protected_actual == protected$sha256
add_check(
  "protected_manifest_and_hashes",
  identical(names(protected), manifest_columns) && nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

u_run <- run_node_verifier("scripts/verify_pivotal_response_entry_unanimity.R")
m_run <- run_node_verifier("scripts/verify_pivotal_response_entry_majority.R")
u_checks <- utils::read.csv(u_checks_path, check.names = FALSE, na.strings = character())
m_checks <- utils::read.csv(m_checks_path, check.names = FALSE, na.strings = character())
add_check(
  "node_verifiers_rerun",
  u_run$status == 0L && m_run$status == 0L &&
    grepl("37/37 PASS", u_run$output, fixed = TRUE) && grepl("24/24 PASS", m_run$output, fixed = TRUE),
  "Both exact entry verifiers rerun successfully: U 37/37 and M 24/24 PASS.",
  paste("U status", u_run$status, "M status", m_run$status)
)
add_check(
  "node_check_snapshots",
  nrow(u_checks) == 37L && all(u_checks$status == "PASS") &&
    nrow(m_checks) == 24L && all(m_checks$status == "PASS") &&
    identical(sha256_file(u_checks_path), "8e87dc91c21e1a3aa29a508b80640527fa57fe09cd071acba7100cf458495552") &&
    identical(sha256_file(m_checks_path), "c145e6b192e882927ceeac8983118d1445d61e0257b55d06f4ada8dba18181cf"),
  "Node check snapshots remain U 37/37 and M 24/24 with exact hashes.",
  "A node check snapshot has a failure, unexpected row count, or changed hash."
)

u_components <- batch$components[nodes == "entry_unanimity"]
m_components <- batch$components[nodes == "entry_majority"]
u_interface <- u_components[vapply(u_components, function(x) x$role == "entry_interface", logical(1))][[1L]]
m_interface <- m_components[vapply(m_components, function(x) x$role == "entry_interface", logical(1))][[1L]]
add_check(
  "approved_interface_hashes",
  identical(sha256_file(u_path), expected[["entry_unanimity"]]) &&
    identical(sha256_file(m_path), expected[["entry_majority"]]) &&
    identical(u_interface$sha256, expected[["entry_unanimity"]]) &&
    identical(m_interface$sha256, expected[["entry_majority"]]),
  "Both exact independently approved entry hashes are frozen.",
  "An approved entry hash differs."
)
add_check(
  "entry_dependency_provenance",
  identical(u$provenance$frozen_gate0_bundle_sha256, expected[["gate0"]]) &&
    identical(u$provenance$frozen_r1_batch_sha256, expected[["r1_batch"]]) &&
    identical(u$provenance$frozen_c1_unanimity_sha256,
              "37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5") &&
    any(vapply(m$dependencies, function(x) {
      identical(x$role, "frozen_R1_batch") && identical(x$sha256, expected[["r1_batch"]])
    }, logical(1))) &&
    any(vapply(m$dependencies, function(x) {
      identical(x$role, "C1_majority") &&
        identical(x$sha256, "21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9")
    }, logical(1))),
  "Both entry nodes point to the exact R1 freeze and local C1 interface.",
  "An entry provenance pointer is stale or missing."
)
add_check(
  "exact_entry_formulas_and_fields",
  grepl("G_U(alpha,mu)=((1-mu)T_W_alpha(0)+mu T_W_alpha(1))/m", u$integration_operator$step_4, fixed = TRUE) &&
    grepl("1{G_U(alpha,mu)>=chi}", u$assessment_level_output$formation_indicator, fixed = TRUE) &&
    grepl("u_entry_H(theta;alpha)=o_theta", u$realized_payoff_and_outcome_map$if_no_form_hegemon, fixed = TRUE) &&
    grepl("V_W^M(alpha,mu)=[(1-mu)T_W^M(alpha,0)+mu T_W^M(alpha,1)]/m", m$collective_value_operator$equivalent_type_total_formula, fixed = TRUE) &&
    grepl(">=chi; equality forms", m$assessment_level_entry_rule$decision, fixed = TRUE) &&
    grepl("E_M,H(theta)=o_theta", m$assessment_level_entry_rule$nonformed_H_type_payoff, fixed = TRUE),
  "Exact U/M gross-value, equality-formation, and nonformation-H fields are present.",
  "An exact entry formula or payoff field is absent."
)
add_check(
  "full_assessment_and_no_rediscount",
  isTRUE(u$dependency_discipline$no_scalar_selection) &&
    identical(as.integer(u$dependency_discipline$downstream_discount_application_count), 0L) &&
    grepl("complete identity-indexed", m$upstream_consumption$unit, fixed = TRUE) &&
    grepl("retained whole", m$upstream_consumption$preservation, fixed = TRUE) &&
    grepl("no additional beta", m$upstream_consumption$discount, fixed = TRUE) &&
    grepl("full assessment-indexed", batch$consumer_contract$object, fixed = TRUE),
  "Both rules retain whole assessments and apply no downstream rediscount.",
  "An assessment-preservation or discount clause is missing."
)
add_check(
  "common_domain_and_pending_limits",
  grepl("N>=3", u$validated_domain_gate$validated_common_existence_domain, fixed = TRUE) &&
    grepl("N=m+1>=3", m$domain$population, fixed = TRUE) &&
    identical(u$claim_status$general_N3_endpoint_values_and_attainment, "pending") &&
    grepl("does not identify", m$selection_free_bounds$N_equals_3_endpoint_status, fixed = TRUE) &&
    grepl("N>=3", batch$consumer_contract$common_domain, fixed = TRUE),
  "The shared domain is N>=3 and unidentified endpoint claims remain pending.",
  "The common domain or an explicit pending limit differs."
)

reviews <- stats::setNames(batch$node_reviews, vapply(batch$node_reviews, function(x) x$node, character(1)))
zero_pass <- function(x, order) {
  identical(x$verdict, "pass") && identical(as.integer(x$order), as.integer(order)) &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) && identical(as.integer(x$minor_findings), 0L)
}
add_check(
  "majority_two_independent_passes",
  identical(reviews$entry_majority$approved_sha256, expected[["entry_majority"]]) &&
    zero_pass(reviews$entry_majority$formal_cold_review, 45L) &&
    zero_pass(reviews$entry_majority$adversarial_review, 46L),
  "Entry-M exact hash has formal-cold and adversarial zero-finding PASS reviews.",
  "An Entry-M review order, verdict, count, or approved hash differs."
)
add_check(
  "unanimity_repair_and_two_rereviews",
  identical(reviews$entry_unanimity$approved_sha256, expected[["entry_unanimity"]]) &&
    identical(reviews$entry_unanimity$initial_candidate_review$candidate_sha256, rejected_u) &&
    identical(reviews$entry_unanimity$initial_candidate_review$verdict, "repair") &&
    identical(as.integer(reviews$entry_unanimity$initial_candidate_review$minor_findings), 2L) &&
    identical(as.integer(reviews$entry_unanimity$repair_started_order), 47L) &&
    identical(as.integer(reviews$entry_unanimity$repair_completed_order), 48L) &&
    zero_pass(reviews$entry_unanimity$formal_rereview, 49L) &&
    zero_pass(reviews$entry_unanimity$adversarial_rereview, 50L),
  "Entry-U repair history and both zero-finding PASS rereviews are exact.",
  "An Entry-U repair or rereview field differs."
)
add_check(
  "review_and_status_reports_match",
  all(vapply(c(expected[["entry_unanimity"]], expected[["entry_majority"]], expected[["batch"]], rejected_u),
             function(x) grepl(x, review_text, fixed = TRUE), logical(1))) &&
    grepl("37/37 PASS", review_text, fixed = TRUE) && grepl("24/24 PASS", review_text, fixed = TRUE) &&
    grepl("Overall status:** **PASS**", status_text, fixed = TRUE) &&
    grepl("passed_order=53", status_text, fixed = TRUE) &&
    grepl("Ready: institutional_comparison", status_text, fixed = TRUE),
  "Consolidated review and status reports record exact approvals, quarantine, checks, and frontier.",
  "The consolidated review or status report is incomplete."
)

rejected_declared <- batch$rejected_history[[1L]]
dag_nodes <- node_map(dag)
consumable_hashes <- c(
  vapply(batch$components, function(x) x$sha256, character(1)),
  vapply(dag$nodes, function(x) if (is.null(x$artifact_hash)) "" else sub("^sha256:", "", x$artifact_hash), character(1)),
  unlist(lapply(dag$nodes, function(x) {
    if (is.null(x$dependency_hashes)) character() else sub("^sha256:", "", unlist(x$dependency_hashes))
  }), use.names = FALSE),
  sub("^sha256:", "", dag_nodes$institutional_comparison$dependency_bundle_hash)
)
add_check(
  "rejected_u_nonconsumable",
  identical(rejected_declared$sha256, rejected_u) &&
    identical(rejected_declared$status, "rejected_historical_nonconsumable") &&
    identical(u$repair_of_rejected_candidate_sha256, rejected_u) &&
    !rejected_u %in% consumable_hashes,
  "Rejected efa593 is recorded as history and absent from every consumable hash field.",
  "Rejected efa593 is missing from quarantine or appears as a consumable hash."
)

event_orders <- vapply(batch$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(batch$execution_events, function(x) x$event, character(1))
expected_events <- c(
  "entry_majority_implementation_complete",
  "entry_unanimity_initial_implementation_complete",
  "entry_formal_cold_reviews_complete",
  "entry_adversarial_reviews_complete",
  "entry_unanimity_repair_start",
  "entry_unanimity_repair_complete",
  "entry_unanimity_formal_rereview_pass",
  "entry_unanimity_adversarial_rereview_pass",
  "entry_batch_close_start",
  "entry_batch_mechanical_verification_pass",
  "entry_batch_close_pass"
)
add_check(
  "execution_events_exact",
  identical(event_orders, 43:53) && identical(event_names, expected_events),
  "Entry implementation, review, repair, and close events are exactly ordered 43 through 53.",
  "Entry event chronology differs."
)

add_check(
  "dag_entry_status_hashes_and_orders",
  identical(dag_nodes$entry_majority$status, "pass") &&
    identical(dag_nodes$entry_majority$artifact_hash, paste0("sha256:", expected[["entry_majority"]])) &&
    identical(as.integer(dag_nodes$entry_majority$started_order), 42L) &&
    identical(as.integer(dag_nodes$entry_majority$implementation_completed_order), 43L) &&
    identical(as.integer(dag_nodes$entry_majority$passed_order), 46L) &&
    identical(dag_nodes$entry_unanimity$status, "pass") &&
    identical(dag_nodes$entry_unanimity$artifact_hash, paste0("sha256:", expected[["entry_unanimity"]])) &&
    identical(as.integer(dag_nodes$entry_unanimity$started_order), 41L) &&
    identical(as.integer(dag_nodes$entry_unanimity$implementation_completed_order), 48L) &&
    identical(as.integer(dag_nodes$entry_unanimity$repair_started_order), 47L) &&
    identical(as.integer(dag_nodes$entry_unanimity$passed_order), 50L),
  "DAG records exact Entry-M and repaired Entry-U hashes and orders.",
  "A DAG entry status, hash, or order differs."
)
add_check(
  "dag_dependency_hashes_and_bundle",
  dependency_links_valid(dag) &&
    identical(dag_nodes$institutional_comparison$dependency_hashes$entry_unanimity,
              paste0("sha256:", expected[["entry_unanimity"]])) &&
    identical(dag_nodes$institutional_comparison$dependency_hashes$entry_majority,
              paste0("sha256:", expected[["entry_majority"]])) &&
    identical(dag_nodes$institutional_comparison$dependency_bundle_path,
              "pivotal_response_interfaces/entry_batch_review_v1.json") &&
    identical(dag_nodes$institutional_comparison$dependency_bundle_hash,
              paste0("sha256:", expected[["batch"]])),
  "DAG freezes exact direct entry hashes and the reviewed entry-batch provenance bundle.",
  "A DAG dependency hash or bundle pointer is stale."
)

pre_pass <- clone_record(dag)
pre_nodes <- node_map(pre_pass)
for (id in c("entry_unanimity", "entry_majority")) {
  pre_nodes[[id]]$status <- "in_progress"
  pre_nodes[[id]]$artifact_path <- NULL
  pre_nodes[[id]]$artifact_hash <- NULL
  pre_nodes[[id]]$implementation_completed_order <- NULL
  pre_nodes[[id]]$passed_order <- NULL
}
pre_nodes$institutional_comparison$authorized <- FALSE
pre_nodes$institutional_comparison$dependency_hashes <- NULL
pre_nodes$institutional_comparison$dependency_bundle_path <- NULL
pre_nodes$institutional_comparison$dependency_bundle_hash <- NULL
pre_pass$nodes <- unname(pre_nodes)
pre_ready <- ready_nodes(pre_pass)
add_check(
  "negative_barrier_before_entry_pass",
  !"institutional_comparison" %in% pre_ready && !"v6_survival_matrix" %in% pre_ready &&
    identical(pre_nodes$institutional_comparison$status, "pending") &&
    identical(pre_nodes$institutional_comparison$authorized, FALSE) &&
    is.null(pre_nodes$institutional_comparison$started_order),
  "Copied pre-PASS DAG keeps comparison and survival blocked and unstarted.",
  paste("Premature pre-PASS ready set:", paste(pre_ready, collapse = ", "))
)

post_ready <- ready_nodes(dag)
add_check(
  "ready_after_pass_exact",
  identical(post_ready, "institutional_comparison") &&
    identical(dag_nodes$institutional_comparison$status, "pending") &&
    identical(dag_nodes$institutional_comparison$authorized, TRUE) &&
    is.null(dag_nodes$institutional_comparison$started_order) &&
    !any(c("entry_majority", "entry_unanimity", "v6_survival_matrix") %in% post_ready),
  "After entry PASS exactly institutional_comparison is ready, authorized, pending, and unstarted.",
  paste("Unexpected post-PASS ready set:", paste(post_ready, collapse = ", "))
)
add_check(
  "comparison_and_survival_artifacts_absent",
  !file.exists("model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json") &&
    !file.exists("model_redesign/pivotal_response_interfaces/v6_survival_matrix_v1.json") &&
    identical(dag_nodes$v6_survival_matrix$status, "pending") &&
    identical(dag_nodes$v6_survival_matrix$authorized, FALSE) &&
    is.null(dag_nodes$v6_survival_matrix$started_order),
  "No comparison or survival artifact exists; v6 survival remains blocked and unauthorized.",
  "A comparison/survival artifact or premature survival authorization exists."
)

comparison_inputs_valid <- function(x, actual_bundle_hash = expected[["batch"]]) {
  n <- node_map(x)
  identical(n$institutional_comparison$dependency_hashes$entry_unanimity,
            n$entry_unanimity$artifact_hash) &&
    identical(n$institutional_comparison$dependency_hashes$entry_majority,
              n$entry_majority$artifact_hash) &&
    identical(n$institutional_comparison$dependency_bundle_hash,
              paste0("sha256:", actual_bundle_hash))
}
mutate_artifact_hash <- function(x, id) {
  out <- clone_record(x)
  n <- node_map(out)
  n[[id]]$artifact_hash <- paste0("sha256:mutated-", id)
  out$nodes <- unname(n)
  out
}
u_mutant <- mutate_artifact_hash(dag, "entry_unanimity")
m_mutant <- mutate_artifact_hash(dag, "entry_majority")
r1_mutant <- mutate_artifact_hash(dag, "r1_batch_frozen")
batch_mutant_valid <- comparison_inputs_valid(dag, actual_bundle_hash = paste0("mutated-", expected[["batch"]]))
add_check(
  "four_mutation_guards",
  !comparison_inputs_valid(u_mutant) && !comparison_inputs_valid(m_mutant) &&
    !dependency_links_valid(r1_mutant) && !batch_mutant_valid &&
    has_path(node_map(dag), "institutional_comparison", "entry_unanimity") &&
    has_path(node_map(dag), "institutional_comparison", "entry_majority") &&
    has_path(node_map(dag), "v6_survival_matrix", "institutional_comparison"),
  "U, M, R1-freeze, and entry-batch hash mutations invalidate the required consumers.",
  "At least one upstream mutation failed to invalidate its consumer."
)

checker_out <- suppressWarnings(system2(
  "python3",
  c(skill_checker, dag_path, "--candidate", "institutional_comparison", "--require-execution-order"),
  stdout = TRUE,
  stderr = TRUE
))
checker_status <- attr(checker_out, "status")
if (is.null(checker_status)) checker_status <- 0L
checker_text <- paste(checker_out, collapse = "\n")
add_check(
  "skill_dag_checker_candidate",
  checker_status == 0L && grepl("VALID", checker_text, fixed = TRUE) &&
    grepl("Ready: institutional_comparison", checker_text, fixed = TRUE),
  "Solve-dynamic-games checker reports VALID and candidate institutional_comparison ready.",
  paste("DAG checker status", checker_status, checker_text)
)

ledger_rows <- ledger[ledger$state_id %in% c("entry_unanimity", "entry_majority", "entry_batch_review"), , drop = FALSE]
add_check(
  "proof_ledger_closed",
  any(ledger_rows$object == "Entry under unanimity, initial candidate" & ledger_rows$status == "rejected") &&
    any(ledger_rows$object == "Entry under unanimity, repaired candidate" & ledger_rows$status == "proved" & ledger_rows$passed_order == "50") &&
    any(ledger_rows$object == "Entry under majority" & ledger_rows$status == "proved" & ledger_rows$passed_order == "46") &&
    any(ledger_rows$object == "Entry batch independent review and freeze" & ledger_rows$status == "proved" &
          ledger_rows$started_order == "51" & ledger_rows$passed_order == "53"),
  "Proof ledger closes M, repaired U, and the batch while retaining rejected U history.",
  "An entry proof-ledger closure row is absent or stale."
)
add_check(
  "no_institutional_ranking_added",
  grepl("contains no institutional ranking", batch$consumer_contract$comparison_boundary, fixed = TRUE) &&
    !any(names(batch) %in% c("institutional_ranking", "dominance_result", "formation_set_nesting")) &&
    grepl("does not rank the institutions", review_text, fixed = TRUE) &&
    !file.exists("model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json"),
  "Batch closure adds no ranking, dominance, nesting, or comparison interface.",
  "The batch may contain a premature institutional result."
)

utils::write.csv(checks, checks_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")
failed <- checks$check_id[checks$status != "PASS"]
cat(sprintf("Entry batch verifier: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Batch interface SHA-256: %s\n", sha256_file(batch_path)))
cat(sprintf("Ready: %s\n", paste(post_ready, collapse = ", ")))
cat("Candidate checker: institutional_comparison VALID\n")
if (length(failed)) {
  cat("Failed checks:\n")
  cat(paste0("- ", failed, collapse = "\n"), "\n")
  quit(save = "no", status = 1L)
}
