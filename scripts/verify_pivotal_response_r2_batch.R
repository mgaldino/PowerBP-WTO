#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

batch_path <- "model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
status_path <- "quality_reports/2026-08-11_pivotal_response_r2_batch_status.md"
review_report_path <- "quality_reports/2026-08-11_pivotal_response_r2_batch_independent_review.md"
required <- c(
  batch_path, dag_path, gate0_path, protected_path, ledger_path,
  status_path, review_report_path,
  "model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json",
  "model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json",
  "model_redesign/pivotal_response_interfaces/r2_majority_weak_only_v1.json"
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing R2 batch artifacts: ", paste(missing, collapse = ", "))

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
  strsplit(trimws(out[[1]]), "[[:space:]]+")[[1]][[1]]
}
read_csv <- function(path) {
  utils::read.csv(path, check.names = FALSE, na.strings = character(), quote = "\"")
}

batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
gate0 <- jsonlite::fromJSON(gate0_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
status_text <- paste(readLines(status_path, warn = FALSE), collapse = "\n")
review_text <- paste(readLines(review_report_path, warn = FALSE), collapse = "\n")
batch_text <- paste(readLines(batch_path, warn = FALSE), collapse = "\n")

approved <- c(
  r2_unanimity_active_h = "f3ca4ebf28827d7e18d9f3a2d07d41ffd6fe57532c9af09300f20a8ab5cecf10",
  r2_majority_active_h = "a4ae73e9bb4114490bbc517732eca0ff7f5368186aee1a02388a8f85f52568b2",
  r2_majority_weak_only = "e0ec6cd35e145f04d1a2897fc1f78157f2b0d45de478046ac5451b2df0a74b5d"
)
old_rejected <- "93fee7f50a0b2d07f584ec60f6d39339ed238cd3d1b018751bb24cdc3efb79aa"
gate0_hash <- "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1"
batch_hash <- sha256_file(batch_path)

add_check(
  "batch_identity",
  identical(batch$state_id, "r2_batch_review") &&
    identical(batch$status, "pass") &&
    identical(batch$native_payoff_date, "Round 2"),
  paste("Batch PASS interface:", batch_hash),
  "Batch identity, status, or payoff date differs."
)
add_check(
  "gate0_exact_hash",
  identical(sha256_file(gate0_path), gate0_hash) &&
    identical(batch$reviewed_gate0$sha256, gate0_hash),
  paste("Gate 0 exact hash:", gate0_hash),
  "Gate 0 bundle changed or batch points to another hash."
)

batch_roles <- vapply(batch$components, function(x) x$role, character(1))
batch_nodes <- vapply(batch$components, function(x) x$node, character(1))
batch_dir <- dirname(normalizePath(batch_path, mustWork = TRUE))
component_paths <- vapply(batch$components, function(x) {
  normalizePath(file.path(batch_dir, x$path), mustWork = TRUE)
}, character(1))
declared_hashes <- vapply(batch$components, function(x) x$sha256, character(1))
actual_hashes <- unname(vapply(component_paths, sha256_file, character(1)))
add_check(
  "batch_component_inventory",
  length(batch$components) == 19L &&
    sum(batch_roles == "continuation_interface") == 3L &&
    sum(batch_roles == "derivation_note") == 3L &&
    sum(batch_roles == "node_status") == 3L &&
    sum(batch_roles == "node_verifier") == 3L &&
    sum(batch_roles == "node_check_table") == 3L &&
    sum(batch_roles == "node_case_table") == 1L &&
    all(c("gate0_contract", names(approved)) %in% unique(batch_nodes)),
  "Batch inventories 19 Gate 0, C2, and auxiliary components.",
  paste("Component roles:", paste(batch_roles, collapse = ", "))
)
add_check(
  "batch_component_hashes",
  identical(actual_hashes, declared_hashes),
  "All 19 batch component hashes match exact bytes.",
  paste("Hash mismatch:", paste(component_paths[actual_hashes != declared_hashes], collapse = ", "))
)

gate0_dir <- dirname(normalizePath(gate0_path, mustWork = TRUE))
gate0_component_paths <- vapply(gate0$components, function(x) {
  normalizePath(file.path(gate0_dir, x$path), mustWork = TRUE)
}, character(1))
gate0_declared <- vapply(gate0$components, function(x) x$sha256, character(1))
gate0_actual <- unname(vapply(gate0_component_paths, sha256_file, character(1)))
add_check(
  "gate0_components_unchanged",
  length(gate0$components) == 5L && identical(gate0_actual, gate0_declared),
  "Gate 0 contract and four registries remain byte-identical.",
  "A Gate 0 component hash differs."
)

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) &
  !is.na(protected_actual) & protected_actual == protected$sha256
add_check(
  "protected_manifest_and_hashes",
  identical(names(protected), manifest_columns) &&
    nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

interface_components <- batch$components[batch_roles == "continuation_interface"]
declared_interfaces <- stats::setNames(
  vapply(interface_components, function(x) x$sha256, character(1)),
  vapply(interface_components, function(x) x$node, character(1))
)
add_check(
  "approved_c2_hashes",
  identical(declared_interfaces[names(approved)], approved),
  "Batch declares all three exact independently approved C2 hashes.",
  paste("Declared:", paste(names(declared_interfaces), declared_interfaces, collapse = "; "))
)

c2_paths <- c(
  r2_unanimity_active_h = "model_redesign/pivotal_response_interfaces/r2_unanimity_active_h_v1.json",
  r2_majority_active_h = "model_redesign/pivotal_response_interfaces/r2_majority_active_h_v1.json",
  r2_majority_weak_only = "model_redesign/pivotal_response_interfaces/r2_majority_weak_only_v1.json"
)
c2 <- lapply(c2_paths, jsonlite::fromJSON, simplifyVector = FALSE)
add_check(
  "c2_pbe_solution_concept",
  all(vapply(c2, function(x) grepl("perfect Bayesian equilibrium", x$solution_concept, ignore.case = TRUE), logical(1))),
  "Every C2 retains Perfect Bayesian equilibrium.",
  "A C2 solution concept differs from PBE."
)
add_check(
  "c2_native_r2_no_beta",
  all(vapply(c2, function(x) identical(x$native_payoff_date, "Round 2"), logical(1))) &&
    identical(c2$r2_unanimity_active_h$internal_discounting, "none") &&
    identical(as.integer(c2$r2_majority_active_h$discount_application_count), 0L) &&
    identical(as.integer(c2$r2_majority_weak_only$discount_application_count), 0L) &&
    grepl("native Round-2 units", batch$internal_discounting, fixed = TRUE),
  "All C2 values are native Round-2 objects with zero internal beta.",
  "A C2 applies an internal discount or lacks native payoff dating."
)
add_check(
  "batch_preserves_correspondences",
  grepl("full assessment-level correspondence", batch_text, fixed = TRUE) &&
    grepl("no batch scalarization", batch_text, fixed = TRUE) &&
    grepl("applies beta exactly once", batch_text, fixed = TRUE),
  "Batch preserves full correspondences and delegates one beta transport to R1.",
  "Batch may scalarize a C2 or transport beta internally."
)

u_checks <- read_csv("tables/pivotal_response_r2_unanimity_active_h_checks.csv")
ma_checks <- read_csv("tables/pivotal_response_r2_majority_active_h_checks.csv")
wo_checks <- read_csv("tables/pivotal_response_r2_majority_weak_only_checks_v1.csv")
add_check(
  "node_check_tables_pass",
  nrow(u_checks) == 18L && all(u_checks$status == "PASS") &&
    nrow(ma_checks) == 17L && all(ma_checks$status == "PASS") &&
    nrow(wo_checks) == 13L && all(as.logical(wo_checks$pass)),
  "Node tables retain U 18/18, M-active 17/17, and M-WO 13/13 PASS.",
  "A node check table has a failure or unexpected row count."
)

reviews <- stats::setNames(
  batch$node_reviews,
  vapply(batch$node_reviews, function(x) x$node, character(1))
)
zero_pass <- function(x) {
  identical(x$verdict, "pass") &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L)
}
add_check(
  "u_two_independent_passes",
  identical(reviews$r2_unanimity_active_h$approved_sha256, approved[["r2_unanimity_active_h"]]) &&
    zero_pass(reviews$r2_unanimity_active_h$initial_formal_review) &&
    zero_pass(reviews$r2_unanimity_active_h$initial_adversarial_review) &&
    identical(as.integer(reviews$r2_unanimity_active_h$initial_formal_review$order), 17L) &&
    identical(as.integer(reviews$r2_unanimity_active_h$initial_adversarial_review$order), 18L),
  "R2-U has two zero-finding independent PASS reviews at events 17--18.",
  "R2-U review record differs."
)
add_check(
  "wo_two_independent_passes",
  identical(reviews$r2_majority_weak_only$approved_sha256, approved[["r2_majority_weak_only"]]) &&
    zero_pass(reviews$r2_majority_weak_only$initial_formal_review) &&
    zero_pass(reviews$r2_majority_weak_only$initial_adversarial_review) &&
    identical(as.integer(reviews$r2_majority_weak_only$initial_formal_review$order), 17L) &&
    identical(as.integer(reviews$r2_majority_weak_only$initial_adversarial_review$order), 18L),
  "R2-M-WO has two zero-finding independent PASS reviews at events 17--18.",
  "R2-M-WO review record differs."
)
add_check(
  "ma_repair_and_two_rereview_passes",
  identical(reviews$r2_majority_active_h$rejected_sha256, old_rejected) &&
    identical(reviews$r2_majority_active_h$initial_formal_review$verdict, "repair") &&
    identical(reviews$r2_majority_active_h$initial_adversarial_review$verdict, "repair") &&
    identical(as.integer(reviews$r2_majority_active_h$repair_started_order), 19L) &&
    identical(as.integer(reviews$r2_majority_active_h$repair_completed_order), 20L) &&
    identical(reviews$r2_majority_active_h$approved_sha256, approved[["r2_majority_active_h"]]) &&
    zero_pass(reviews$r2_majority_active_h$formal_rereview) &&
    zero_pass(reviews$r2_majority_active_h$adversarial_rereview) &&
    identical(as.integer(reviews$r2_majority_active_h$formal_rereview$order), 21L) &&
    identical(as.integer(reviews$r2_majority_active_h$adversarial_rereview$order), 22L),
  "R2-M-active records REPAIR at 17--18, repair at 19--20, and two PASS rereviews at 21--22.",
  "R2-M-active repair or rereview history differs."
)

interface_dir_files <- list.files(
  "model_redesign/pivotal_response_interfaces",
  full.names = TRUE, recursive = FALSE
)
interface_dir_hashes <- vapply(interface_dir_files, sha256_file, character(1))
dag_hashes <- vapply(dag$nodes, function(x) if (is.null(x$artifact_hash)) "" else x$artifact_hash, character(1))
add_check(
  "old_ma_hash_rejected_not_consumed",
  !old_rejected %in% declared_hashes &&
    !old_rejected %in% interface_dir_hashes &&
    !paste0("sha256:", old_rejected) %in% dag_hashes &&
    identical(reviews$r2_majority_active_h$rejected_sha256, old_rejected),
  "Old 93fee M-active hash is rejected history and absent from consumable dependencies.",
  "Old rejected M-active hash is present as a consumable artifact."
)

event_orders <- vapply(batch$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(batch$execution_events, function(x) x$event, character(1))
expected_events <- c(
  "r2_unanimity_active_h_start",
  "r2_majority_active_h_initial_start",
  "r2_majority_weak_only_start",
  "r2_majority_active_h_initial_complete",
  "r2_majority_weak_only_complete",
  "r2_unanimity_active_h_complete",
  "initial_formal_reviews",
  "initial_adversarial_reviews",
  "r2_majority_active_h_repair_start",
  "r2_majority_active_h_repair_complete",
  "r2_majority_active_h_formal_rereview_pass",
  "r2_majority_active_h_adversarial_rereview_pass",
  "r2_batch_close_start",
  "r2_batch_mechanical_verification_pass",
  "r2_batch_close_pass"
)
add_check(
  "r2_execution_events",
  identical(event_orders, 11:25) && identical(event_names, expected_events),
  "R2 implementation, review, repair, rereview, and batch-close events are ordered 11--25.",
  "R2 execution chronology differs."
)

node_ids <- vapply(dag$nodes, function(x) x$id, character(1))
node_by_id <- stats::setNames(dag$nodes, node_ids)
r2_ids <- names(approved)
add_check(
  "dag_r2_nodes_pass",
  all(vapply(r2_ids, function(id) {
    node <- node_by_id[[id]]
    identical(node$status, "pass") &&
      identical(node$artifact_hash, paste0("sha256:", approved[[id]])) &&
      identical(node$dependency_hashes$gate0_contract, paste0("sha256:", gate0_hash))
  }, logical(1))) &&
    identical(as.integer(node_by_id$r2_unanimity_active_h$passed_order), 18L) &&
    identical(as.integer(node_by_id$r2_majority_weak_only$passed_order), 18L) &&
    identical(as.integer(node_by_id$r2_majority_active_h$passed_order), 22L),
  "All three R2 DAG nodes are PASS with exact artifacts, dependencies, and review order.",
  "An R2 DAG node is not correctly frozen."
)
batch_node <- node_by_id$r2_batch_review
add_check(
  "dag_batch_node_pass",
  identical(batch_node$status, "pass") &&
    identical(batch_node$artifact_hash, paste0("sha256:", batch_hash)) &&
    identical(as.integer(batch_node$started_order), 23L) &&
    identical(as.integer(batch_node$verification_order), 24L) &&
    identical(as.integer(batch_node$passed_order), 25L) &&
    all(vapply(r2_ids, function(id) {
      identical(batch_node$dependency_hashes[[id]], paste0("sha256:", approved[[id]]))
    }, logical(1))),
  "R2 batch DAG node freezes all three C2 hashes and passes at event 25.",
  "R2 batch DAG node or dependency hashes differ."
)
r1_ids <- c("r1_unanimity", "r1_majority")
r1_nodes <- node_by_id[r1_ids]
expected_r1_hashes <- list(
  r1_unanimity = list(
    r2_batch_review = paste0("sha256:", batch_hash),
    r2_unanimity_active_h = paste0("sha256:", approved[["r2_unanimity_active_h"]])
  ),
  r1_majority = list(
    r2_batch_review = paste0("sha256:", batch_hash),
    r2_majority_active_h = paste0("sha256:", approved[["r2_majority_active_h"]]),
    r2_majority_weak_only = paste0("sha256:", approved[["r2_majority_weak_only"]])
  )
)
add_check(
  "dag_r1_authorized_pending",
  all(vapply(r1_nodes, function(x) {
    identical(x$status, "pending") && identical(x$authorized, TRUE) &&
      is.null(x$started_order) && is.null(x$passed_order) && is.null(x$artifact_hash)
  }, logical(1))) &&
    all(vapply(r1_ids, function(id) {
      identical(node_by_id[[id]]$dependency_hashes, expected_r1_hashes[[id]])
    }, logical(1))),
  "Exactly the two R1 nodes are authorized, pending, unstarted, and hash-frozen.",
  "R1 readiness or literal dependency hashes differ."
)
pending_authorized <- vapply(dag$nodes, function(x) {
  identical(x$status, "pending") && identical(x$authorized, TRUE)
}, logical(1))
add_check(
  "dag_exact_authorized_frontier",
  setequal(node_ids[pending_authorized], r1_ids),
  "The only authorized pending frontier is r1_majority and r1_unanimity.",
  paste("Authorized pending:", paste(node_ids[pending_authorized], collapse = ", "))
)

dag_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"
run_checker <- function(args) {
  out <- suppressWarnings(system2("python3", c(dag_checker, args), stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = out)
}
order_run <- run_checker(c(dag_path, "--require-execution-order"))
ready_marker <- "Ready: r1_majority, r1_unanimity"
add_check(
  "skill_dag_order_and_readiness",
  order_run$status == 0L && any(order_run$output == "VALID") &&
    any(grepl(ready_marker, order_run$output, fixed = TRUE)),
  "Skill checker validates execution order and reports exactly both R1 nodes ready.",
  paste(order_run$output, collapse = " | ")
)
candidate_run <- run_checker(c(dag_path, "--candidate", "r1_unanimity", "r1_majority"))
add_check(
  "skill_r1_candidate_antichain",
  candidate_run$status == 0L && any(candidate_run$output == "VALID") &&
    any(grepl(ready_marker, candidate_run$output, fixed = TRUE)),
  "Skill checker accepts the two R1 nodes as a ready antichain.",
  paste(candidate_run$output, collapse = " | ")
)

r1_interface_paths <- c(
  "model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json",
  "model_redesign/pivotal_response_interfaces/r1_majority_v1.json"
)
add_check(
  "no_r1_interface_or_start",
  !any(file.exists(r1_interface_paths)) &&
    all(vapply(r1_nodes, function(x) is.null(x$started_order), logical(1))),
  "No R1 interface, result, or start event exists.",
  "An R1 artifact or start event exists prematurely."
)

candidate_hash_safe <- function(manifest) {
  ids <- vapply(manifest$nodes, function(x) x$id, character(1))
  nodes <- stats::setNames(manifest$nodes, ids)
  batch_local <- nodes$r2_batch_review
  r2_frozen <- all(vapply(r2_ids, function(id) {
    dep <- nodes[[id]]
    identical(dep$status, "pass") &&
      nzchar(dep$artifact_hash) &&
      identical(batch_local$dependency_hashes[[id]], dep$artifact_hash)
  }, logical(1)))
  r1_frozen <- all(vapply(r1_ids, function(id) {
    node <- nodes[[id]]
    identical(node$status, "pending") && identical(node$authorized, TRUE) &&
      all(vapply(unlist(node$depends_on), function(dep_id) {
        dep <- nodes[[dep_id]]
        identical(dep$status, "pass") && nzchar(dep$artifact_hash) &&
          identical(node$dependency_hashes[[dep_id]], dep$artifact_hash)
      }, logical(1)))
  }, logical(1)))
  r2_frozen && r1_frozen
}
add_check(
  "baseline_r1_hash_guard",
  candidate_hash_safe(dag),
  "Both baseline R1 candidates pass the literal transitive hash guard.",
  "Baseline R1 candidates fail their dependency hash guard."
)
deep_copy <- function(x) unserialize(serialize(x, NULL))
mutation_invalidates <- function(node_id) {
  mutated <- deep_copy(dag)
  index <- which(vapply(mutated$nodes, function(x) x$id, character(1)) == node_id)
  mutated$nodes[[index]]$artifact_hash <- paste0("sha256:mutated-", node_id)
  !candidate_hash_safe(mutated)
}
for (id in c(r2_ids, "r2_batch_review")) {
  add_check(
    paste0("mutation_", id, "_invalidates_r1"),
    mutation_invalidates(id),
    paste("Changing", id, "hash invalidates both R1 candidates."),
    paste("Changing", id, "hash did not invalidate the R1 candidates.")
  )
}

old_row <- grepl("initial candidate", ledger$object, ignore.case = TRUE) &
  ledger$state_id == "r2_majority_active_h"
approved_rows <- ledger$state_id %in% r2_ids & ledger$status == "proved"
batch_row <- ledger$state_id == "r2_batch_review"
add_check(
  "proof_ledger_r2_close",
  sum(old_row) == 1L && ledger$status[old_row] == "rejected" &&
    grepl("93fee7", ledger$evidence[old_row], fixed = TRUE) &&
    sum(approved_rows) == 3L &&
    sum(batch_row) == 1L && ledger$status[batch_row] == "proved" &&
    ledger$started_order[batch_row] == 23L && ledger$passed_order[batch_row] == 25L,
  "Proof ledger preserves rejected 93fee and closes three R2 nodes plus the batch.",
  "Proof ledger R2 governance differs."
)

add_check(
  "batch_reports",
  grepl(paste0("sha256:", batch_hash), status_text, fixed = TRUE) &&
    grepl(paste0("sha256:", batch_hash), review_text, fixed = TRUE) &&
    grepl(old_rejected, status_text, fixed = TRUE) &&
    grepl("Ready: r1_majority, r1_unanimity", status_text, fixed = TRUE) &&
    grepl("zero findings", review_text, ignore.case = TRUE) &&
    grepl("before R1", status_text, ignore.case = TRUE),
  "Batch status and independent-review report record exact hashes, history, and stop boundary.",
  "Batch status or review report is incomplete."
)

output_path <- "tables/pivotal_response_r2_batch_checks.csv"
log_path <- "quality_reports/logs/verify_pivotal_response_r2_batch.log"
utils::write.csv(checks, output_path, row.names = FALSE, fileEncoding = "UTF-8")
pass_count <- sum(checks$status == "PASS")
fail_count <- sum(checks$status == "FAIL")
overall <- if (fail_count == 0L) "PASS" else "FAIL"
log_lines <- c(
  "PIVOTAL RESPONSE R2 BATCH VERIFICATION",
  paste("timestamp:", format(Sys.time(), tz = "America/Sao_Paulo", usetz = TRUE)),
  paste("git_root:", repo_root),
  paste("gate0_hash:", paste0("sha256:", gate0_hash)),
  paste("batch_hash:", paste0("sha256:", batch_hash)),
  paste("checks:", nrow(checks)),
  paste("pass:", pass_count),
  paste("fail:", fail_count),
  paste("status:", overall),
  "scope: R2 batch governance and dependency validation only; no R1 derivation",
  "dag_require_execution_order_output:",
  paste(order_run$output, collapse = "\n"),
  "r1_candidate_output:",
  paste(candidate_run$output, collapse = "\n"),
  "sessionInfo:",
  paste(capture.output(sessionInfo()), collapse = "\n")
)
writeLines(log_lines, log_path, useBytes = TRUE)
cat(sprintf(
  "%s: %d/%d checks passed.\nOutputs: %s; %s\n",
  overall, pass_count, nrow(checks), output_path, log_path
))
if (fail_count > 0L) {
  print(checks[checks$status == "FAIL", , drop = FALSE], row.names = FALSE)
  quit(status = 1L)
}
