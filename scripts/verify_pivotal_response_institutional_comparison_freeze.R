#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

review_bundle_path <- "model_redesign/pivotal_response_interfaces/institutional_comparison_review_v1.json"
comparison_path <- "model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json"
comparison_note_path <- "model_redesign/pivotal_response_nodes/institutional_comparison_v1.md"
entry_batch_path <- "model_redesign/pivotal_response_interfaces/entry_batch_review_v1.json"
entry_u_path <- "model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json"
entry_m_path <- "model_redesign/pivotal_response_interfaces/entry_majority_v1.json"
candidate_status_path <- "quality_reports/2026-08-12_pivotal_response_institutional_comparison_status.md"
review_report_path <- "quality_reports/2026-08-12_pivotal_response_institutional_comparison_independent_review.md"
freeze_status_path <- "quality_reports/2026-08-12_pivotal_response_institutional_comparison_freeze_status.md"
candidate_verifier_path <- "scripts/verify_pivotal_response_institutional_comparison.R"
candidate_checks_path <- "tables/pivotal_response_institutional_comparison_checks_v1.csv"
pair_table_path <- "tables/pivotal_response_institutional_comparison_pair_fixtures_v1.csv"
status_logic_path <- "tables/pivotal_response_institutional_comparison_status_logic_v1.csv"
boundary_path <- "tables/pivotal_response_institutional_comparison_boundaries_v1.csv"
freeze_checks_path <- "tables/pivotal_response_institutional_comparison_freeze_checks_v1.csv"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
derivation_rmd_path <- "model_redesign/pivotal_response_rederivation.Rmd"
survival_path <- "model_redesign/pivotal_response_interfaces/v6_survival_matrix_v1.json"
skill_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"

required <- c(
  review_bundle_path, comparison_path, comparison_note_path, entry_batch_path,
  entry_u_path, entry_m_path, candidate_status_path, review_report_path,
  freeze_status_path, candidate_verifier_path, candidate_checks_path,
  pair_table_path, status_logic_path, boundary_path, protected_path, dag_path,
  ledger_path, derivation_rmd_path, skill_checker
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing comparison-freeze artifacts: ", paste(missing, collapse = ", "))

expected <- c(
  review_bundle = "0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c",
  comparison = "cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af",
  comparison_note = "e3bcb530e7a99f6fec59c5f637ae6ec4a1204904adbb8cea73157bf0b568502b",
  entry_batch = "8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433",
  entry_unanimity = "05e39ad2b84ede134268ffae0898c8cafd8f3de01ef725ca2da6159156a83ed6",
  entry_majority = "4eb343ce6f6fb7c34782e708a0e787908437d2682d079e91f26103706c083f21",
  candidate_status = "a6087c2ac2fa70e16dfcffd6ced6ea878d2078f24ad547e4fba023c8b6b906e5",
  candidate_verifier = "cb662ca013c5c107f86ab4bbc8dc379cf8fbb193d386e2e19f0f3bb6c14e1e1c",
  candidate_checks = "f7bd52b924680117a7fa3f5b06590d1fe705eee2e14c7e98885e5a7c9cccdb15",
  pair_table = "8cf237c94bc42bb38058c9c0c0e7a8045d3cb4df772481fed4b8fb2a5730c46c",
  status_logic = "3d064c5a6670f45a414569023e516bef515297844f23d2698fd5b6ecef2b31dc",
  boundary = "9455f50ba69ee49dfd8c547c30865c536beac0b8ab74c15d51e46d2e4a13a647",
  protected_manifest = "e6c2dcaea628acf84ea77853448b185b189e24d7b809e540e442fd820b0d6d6c",
  derivation_rmd = "418470306c34c7cc952f7c189b8528149185cd4a4f8b0de3fa604d2b8e727fd2"
)

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

run_r_verifier <- function(path) {
  out <- suppressWarnings(system2("Rscript", c("--vanilla", path), stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = paste(out, collapse = "\n"))
}

review_bundle <- jsonlite::fromJSON(review_bundle_path, simplifyVector = FALSE)
comparison <- jsonlite::fromJSON(comparison_path, simplifyVector = FALSE)
entry_batch <- jsonlite::fromJSON(entry_batch_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
candidate_status_text <- paste(readLines(candidate_status_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
review_text <- paste(readLines(review_report_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
freeze_status_text <- paste(readLines(freeze_status_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

add_check(
  "review_bundle_identity_and_hash",
  identical(review_bundle$state_id, "institutional_comparison_review") &&
    identical(review_bundle$status, "pass") &&
    identical(sha256_file(review_bundle_path), expected[["review_bundle"]]),
  paste("Comparison review bundle PASS:", expected[["review_bundle"]]),
  "Review-bundle identity, status, or exact hash differs."
)

add_check(
  "approved_candidate_identity_and_hash",
  identical(comparison$state_id, "institutional_comparison") &&
    identical(comparison$status, "candidate_pending_independent_review") &&
    identical(sha256_file(comparison_path), expected[["comparison"]]) &&
    identical(review_bundle$candidate_review$approved_sha256, expected[["comparison"]]),
  "The immutable candidate snapshot is the exact independently approved hash.",
  "The candidate identity, immutable status, or approved hash differs."
)

upstream_roles <- vapply(review_bundle$reviewed_upstream, function(x) x$node, character(1))
upstream_hashes <- vapply(review_bundle$reviewed_upstream, function(x) x$sha256, character(1))
add_check(
  "reviewed_upstream_exact",
  identical(upstream_roles, c("entry_batch_review", "entry_unanimity", "entry_majority")) &&
    identical(upstream_hashes, unname(expected[c("entry_batch", "entry_unanimity", "entry_majority")])) &&
    identical(sha256_file(entry_batch_path), expected[["entry_batch"]]) &&
    identical(sha256_file(entry_u_path), expected[["entry_unanimity"]]) &&
    identical(sha256_file(entry_m_path), expected[["entry_majority"]]),
  "Entry batch, Entry-U, and Entry-M retain their exact approved bytes.",
  "An upstream role, declaration, or byte stream differs."
)

roles <- vapply(review_bundle$components, function(x) x$role, character(1))
nodes <- vapply(review_bundle$components, function(x) x$node, character(1))
add_check(
  "component_inventory_exact",
  length(review_bundle$components) == 12L &&
    sum(roles == "entry_batch_interface") == 1L && sum(roles == "entry_interface") == 2L &&
    sum(roles == "protected_hash_manifest") == 1L && sum(roles == "comparison_interface") == 1L &&
    sum(roles == "derivation_note") == 1L && sum(roles == "candidate_status_snapshot") == 1L &&
    sum(roles == "node_verifier") == 1L && sum(grepl("table$", roles)) == 4L &&
    all(c("entry_batch_review", "entry_unanimity", "entry_majority", "institutional_comparison") %in% unique(nodes)),
  "Bundle inventories 12 exact dependency, interface, note, status, verifier, table, and protection components.",
  paste("Unexpected component roles:", paste(roles, collapse = ", "))
)

add_check(
  "component_hashes_exact",
  component_hashes_match(review_bundle_path, review_bundle$components),
  "All 12 review-bundle component hashes match exact bytes.",
  "At least one review-bundle component hash differs."
)

add_check(
  "literal_candidate_auxiliary_hashes",
  identical(sha256_file(comparison_note_path), expected[["comparison_note"]]) &&
    identical(sha256_file(candidate_status_path), expected[["candidate_status"]]) &&
    identical(sha256_file(candidate_verifier_path), expected[["candidate_verifier"]]) &&
    identical(sha256_file(candidate_checks_path), expected[["candidate_checks"]]) &&
    identical(sha256_file(pair_table_path), expected[["pair_table"]]) &&
    identical(sha256_file(status_logic_path), expected[["status_logic"]]) &&
    identical(sha256_file(boundary_path), expected[["boundary"]]),
  "Candidate note, immutable status, verifier, and all four tables retain exact hashes.",
  "A candidate auxiliary changed."
)

add_check(
  "transitive_entry_batch_closure",
  identical(entry_batch$status, "pass") && length(entry_batch$components) == 19L &&
    component_hashes_match(entry_batch_path, entry_batch$components),
  "The frozen entry batch and all 19 transitive components remain exact.",
  "The entry batch status, inventory, or a transitive component changed."
)

candidate_run <- run_r_verifier(candidate_verifier_path)
candidate_checks <- utils::read.csv(candidate_checks_path, check.names = FALSE, na.strings = character())
add_check(
  "candidate_verifier_rerun",
  candidate_run$status == 0L && grepl("42/42 PASS", candidate_run$output, fixed = TRUE),
  "The exact comparison verifier reruns successfully: 42/42 PASS.",
  paste("Candidate verifier status", candidate_run$status, candidate_run$output)
)

add_check(
  "candidate_check_snapshot",
  nrow(candidate_checks) == 42L && all(candidate_checks$status == "PASS") &&
    identical(sha256_file(candidate_checks_path), expected[["candidate_checks"]]),
  "The candidate check snapshot remains 42/42 PASS with its exact hash.",
  "The candidate check snapshot count, status, or hash differs."
)

zero_pass <- function(x, order) {
  identical(x$verdict, "pass") && identical(as.integer(x$order), as.integer(order)) &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L) &&
    identical(x$review_mode, "independent and read-only")
}
add_check(
  "two_independent_zero_finding_reviews",
  zero_pass(review_bundle$candidate_review$formal_cold_review, 56L) &&
    zero_pass(review_bundle$candidate_review$adversarial_review, 57L) &&
    identical(review_bundle$candidate_review$formal_cold_review$official_verifier, "42/42 PASS") &&
    identical(review_bundle$candidate_review$adversarial_review$official_verifier, "42/42 PASS"),
  "Formal/cold and adversarial read-only reviews both PASS the exact hash with zero findings.",
  "A review order, verdict, independence declaration, finding count, or verifier result differs."
)

add_check(
  "rejected_history_empty",
  is.list(review_bundle$rejected_history) && length(review_bundle$rejected_history) == 0L &&
    grepl("no[[:space:]]+rejected comparison hash", review_text, ignore.case = TRUE),
  "No comparison candidate was rejected or made consumable as rejected history.",
  "Comparison rejected-history bookkeeping is not empty or consistent."
)

event_orders <- vapply(review_bundle$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(review_bundle$execution_events, function(x) x$event, character(1))
expected_events <- c(
  "institutional_comparison_implementation_complete",
  "institutional_comparison_formal_cold_review_pass",
  "institutional_comparison_adversarial_review_pass",
  "institutional_comparison_freeze_start",
  "institutional_comparison_mechanical_verification_pass",
  "institutional_comparison_close_pass"
)
add_check(
  "execution_events_exact",
  identical(event_orders, 55:60) && identical(event_names, expected_events),
  "Implementation, reviews, freeze, verification, and close are ordered exactly 55 through 60.",
  "Comparison execution-event chronology differs."
)

add_check(
  "close_contract_exact",
  identical(review_bundle$comparison_close$status, "pass") &&
    identical(as.integer(review_bundle$comparison_close$started_order), 58L) &&
    identical(as.integer(review_bundle$comparison_close$verification_order), 59L) &&
    identical(as.integer(review_bundle$comparison_close$passed_order), 60L) &&
    identical(review_bundle$comparison_close$validated_common_existence_domain, "N>=3") &&
    identical(unlist(review_bundle$comparison_close$ready_after_close), "v6_survival_matrix") &&
    length(review_bundle$comparison_close$started_descendants) == 0L,
  "Comparison closes PASS at 60 on N>=3 and authorizes only an unstarted survival node.",
  "The close orders, domain, frontier, or descendant-start record differs."
)

all_report_hashes <- unname(expected[c(
  "comparison", "review_bundle", "entry_batch", "entry_unanimity", "entry_majority"
)])
add_check(
  "consolidated_reports_match",
  all(vapply(all_report_hashes, function(x) grepl(x, review_text, fixed = TRUE), logical(1))) &&
    all(vapply(all_report_hashes, function(x) grepl(x, freeze_status_text, fixed = TRUE), logical(1))) &&
    grepl("Overall verdict:** **PASS**", review_text, fixed = TRUE) &&
    grepl("0` critical, `0` major, and `0` minor", review_text, fixed = TRUE) &&
    grepl("Overall status:** **PASS**", freeze_status_text, fixed = TRUE) &&
    grepl("passed_order=60", freeze_status_text, fixed = TRUE) &&
    grepl("Ready: v6_survival_matrix", freeze_status_text, fixed = TRUE),
  "Consolidated review and freeze-status reports record exact hashes, zero findings, orders, and frontier.",
  "A consolidated report is incomplete or stale."
)

add_check(
  "immutable_candidate_status_snapshot",
  grepl("CANDIDATE PENDING INDEPENDENT READ-ONLY REVIEW", candidate_status_text, fixed = TRUE) &&
    grepl(expected[["comparison"]], candidate_status_text, fixed = TRUE) &&
    grepl("42/42 PASS", candidate_status_text, fixed = TRUE) &&
    grepl("immutable candidate-status snapshot", freeze_status_text, ignore.case = TRUE),
  "The implementer handoff remains immutable and is explicitly superseded by hash-specific approval.",
  "The candidate-status snapshot or its lifecycle explanation differs."
)

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) & protected_actual == protected$sha256
add_check(
  "protected_manifest_and_hashes",
  identical(sha256_file(protected_path), expected[["protected_manifest"]]) &&
    identical(names(protected), manifest_columns) && nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

dag_nodes <- node_map(dag)
comparison_node <- dag_nodes$institutional_comparison
survival_node <- dag_nodes$v6_survival_matrix
add_check(
  "dag_comparison_pass_exact",
  identical(comparison_node$status, "pass") && identical(comparison_node$authorized, TRUE) &&
    identical(comparison_node$artifact_hash, paste0("sha256:", expected[["comparison"]])) &&
    identical(as.integer(comparison_node$started_order), 54L) &&
    identical(as.integer(comparison_node$implementation_completed_order), 55L) &&
    identical(unlist(comparison_node$review_orders), c(56L, 57L)) &&
    identical(unlist(comparison_node$review_verdicts), c("formal_cold_pass", "adversarial_pass")) &&
    identical(as.integer(comparison_node$freeze_started_order), 58L) &&
    identical(as.integer(comparison_node$verification_order), 59L) &&
    identical(as.integer(comparison_node$passed_order), 60L) &&
    identical(comparison_node$review_bundle_hash, paste0("sha256:", expected[["review_bundle"]])),
  "DAG records the exact comparison hash, review bundle, and orders 54 through 60.",
  "The DAG comparison lifecycle, hash, review bundle, or order differs."
)

add_check(
  "dag_dependency_hashes_exact",
  dependency_links_valid(dag) &&
    identical(comparison_node$dependency_hashes$entry_unanimity,
              paste0("sha256:", expected[["entry_unanimity"]])) &&
    identical(comparison_node$dependency_hashes$entry_majority,
              paste0("sha256:", expected[["entry_majority"]])) &&
    identical(comparison_node$dependency_bundle_hash,
              paste0("sha256:", expected[["entry_batch"]])) &&
    identical(comparison_node$review_bundle_path,
              "pivotal_response_interfaces/institutional_comparison_review_v1.json"),
  "DAG freezes the exact direct entry hashes, entry-batch provenance, and comparison-review bundle.",
  "A DAG dependency or bundle pointer is stale."
)

add_check(
  "survival_authorized_unstarted_exact",
  identical(survival_node$status, "pending") && identical(survival_node$authorized, TRUE) &&
    is.null(survival_node$started_order) && is.null(survival_node$artifact_hash) &&
    identical(survival_node$dependency_hashes$institutional_comparison,
              paste0("sha256:", expected[["comparison"]])) &&
    identical(survival_node$dependency_review_bundle_path,
              "pivotal_response_interfaces/institutional_comparison_review_v1.json") &&
    identical(survival_node$dependency_review_bundle_hash,
              paste0("sha256:", expected[["review_bundle"]])),
  "v6_survival_matrix is authorized, pending, unstarted, and locked to both exact comparison hashes.",
  "The survival node was started, lacks authorization, or has a stale dependency lock."
)

pre_pass <- clone_record(dag)
pre_nodes <- node_map(pre_pass)
pre_nodes$institutional_comparison$status <- "in_progress"
pre_nodes$institutional_comparison$artifact_path <- NULL
pre_nodes$institutional_comparison$artifact_hash <- NULL
pre_nodes$institutional_comparison$implementation_completed_order <- NULL
pre_nodes$institutional_comparison$review_orders <- NULL
pre_nodes$institutional_comparison$review_verdicts <- NULL
pre_nodes$institutional_comparison$freeze_started_order <- NULL
pre_nodes$institutional_comparison$verification_order <- NULL
pre_nodes$institutional_comparison$passed_order <- NULL
pre_nodes$institutional_comparison$review_bundle_path <- NULL
pre_nodes$institutional_comparison$review_bundle_hash <- NULL
pre_nodes$v6_survival_matrix$authorized <- FALSE
pre_nodes$v6_survival_matrix$dependency_hashes <- NULL
pre_nodes$v6_survival_matrix$dependency_review_bundle_path <- NULL
pre_nodes$v6_survival_matrix$dependency_review_bundle_hash <- NULL
pre_pass$nodes <- unname(pre_nodes)
pre_ready <- ready_nodes(pre_pass)
add_check(
  "negative_barrier_before_comparison_pass",
  !"v6_survival_matrix" %in% pre_ready &&
    identical(pre_nodes$v6_survival_matrix$status, "pending") &&
    identical(pre_nodes$v6_survival_matrix$authorized, FALSE) &&
    is.null(pre_nodes$v6_survival_matrix$started_order),
  "Copied pre-PASS DAG keeps the survival node blocked, unauthorized, and unstarted.",
  paste("Premature pre-PASS ready set:", paste(pre_ready, collapse = ", "))
)

post_ready <- ready_nodes(dag)
add_check(
  "ready_after_pass_exact",
  identical(post_ready, "v6_survival_matrix") &&
    !"institutional_comparison" %in% post_ready &&
    identical(survival_node$status, "pending") && identical(survival_node$authorized, TRUE) &&
    is.null(survival_node$started_order),
  "After comparison PASS exactly v6_survival_matrix is ready, authorized, pending, and unstarted.",
  paste("Unexpected post-PASS ready set:", paste(post_ready, collapse = ", "))
)

add_check(
  "no_survival_or_rmd_edit",
  !file.exists(survival_path) &&
    identical(sha256_file(derivation_rmd_path), expected[["derivation_rmd"]]),
  "No survival artifact exists and the standalone derivation Rmd was not edited during closure.",
  "A survival artifact exists or the standalone derivation Rmd changed."
)

comparison_inputs_valid <- function(x, actual_entry_batch_hash = expected[["entry_batch"]]) {
  n <- node_map(x)
  identical(n$institutional_comparison$dependency_hashes$entry_unanimity,
            n$entry_unanimity$artifact_hash) &&
    identical(n$institutional_comparison$dependency_hashes$entry_majority,
              n$entry_majority$artifact_hash) &&
    identical(n$institutional_comparison$dependency_bundle_hash,
              paste0("sha256:", actual_entry_batch_hash))
}

survival_inputs_valid <- function(x, actual_review_bundle_hash = expected[["review_bundle"]]) {
  n <- node_map(x)
  identical(n$v6_survival_matrix$dependency_hashes$institutional_comparison,
            n$institutional_comparison$artifact_hash) &&
    identical(n$v6_survival_matrix$dependency_review_bundle_hash,
              paste0("sha256:", actual_review_bundle_hash))
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
comparison_mutant <- mutate_artifact_hash(dag, "institutional_comparison")
entry_batch_mutant_ok <- comparison_inputs_valid(dag, paste0("mutated-", expected[["entry_batch"]]))
review_bundle_mutant_ok <- survival_inputs_valid(dag, paste0("mutated-", expected[["review_bundle"]]))
component_mutant <- clone_record(review_bundle)
component_mutant$components[[6L]]$sha256 <- paste0("mutated-", component_mutant$components[[6L]]$sha256)
add_check(
  "six_mutation_guards",
  !comparison_inputs_valid(u_mutant) && !comparison_inputs_valid(m_mutant) &&
    !entry_batch_mutant_ok && !survival_inputs_valid(comparison_mutant) &&
    !review_bundle_mutant_ok && !component_hashes_match(review_bundle_path, component_mutant$components) &&
    has_path(node_map(dag), "institutional_comparison", "entry_unanimity") &&
    has_path(node_map(dag), "institutional_comparison", "entry_majority") &&
    has_path(node_map(dag), "v6_survival_matrix", "institutional_comparison"),
  "Six entry, batch, comparison, review-bundle, and component mutations invalidate the required consumer.",
  "At least one upstream or component mutation failed to invalidate its consumer."
)

checker_out <- suppressWarnings(system2(
  "python3",
  c(skill_checker, dag_path, "--candidate", "v6_survival_matrix", "--require-execution-order"),
  stdout = TRUE,
  stderr = TRUE
))
checker_status <- attr(checker_out, "status")
if (is.null(checker_status)) checker_status <- 0L
checker_text <- paste(checker_out, collapse = "\n")
add_check(
  "skill_dag_checker_candidate",
  checker_status == 0L && grepl("VALID", checker_text, fixed = TRUE) &&
    grepl("Ready: v6_survival_matrix", checker_text, fixed = TRUE) &&
    !grepl("Ready: institutional_comparison", checker_text, fixed = TRUE),
  "Solve-dynamic-games checker reports candidate v6_survival_matrix VALID and uniquely ready.",
  paste("DAG checker status", checker_status, checker_text)
)

comparison_rows <- ledger[ledger$state_id == "institutional_comparison", , drop = FALSE]
survival_rows <- ledger[ledger$state_id == "v6_survival_matrix", , drop = FALSE]
add_check(
  "proof_ledger_closed_and_frontier",
  nrow(comparison_rows) == 1L && comparison_rows$status[[1L]] == "proved" &&
    identical(as.integer(comparison_rows$started_order[[1L]]), 54L) &&
    identical(as.integer(comparison_rows$passed_order[[1L]]), 60L) &&
    grepl(expected[["comparison"]], comparison_rows$evidence[[1L]], fixed = TRUE) &&
    grepl(expected[["review_bundle"]], comparison_rows$evidence[[1L]], fixed = TRUE) &&
    nrow(survival_rows) == 1L && survival_rows$status[[1L]] == "pending" &&
    is.na(survival_rows$started_order[[1L]]) && is.na(survival_rows$passed_order[[1L]]) &&
    grepl("authorized and unstarted", survival_rows$evidence[[1L]], fixed = TRUE),
  "Proof ledger closes comparison at 60 and leaves survival authorized, pending, and unstarted.",
  "The comparison closure or survival frontier row is absent or stale."
)

add_check(
  "accepted_scope_preserves_limits",
  grepl("full Cartesian product", comparison$counterfactual_comparison_protocol$comparison_index_set, fixed = TRUE) &&
    grepl("no endogenous rule-choice", comparison$counterfactual_comparison_protocol$fixed_rules, fixed = TRUE) &&
    grepl("general numeric ordering pending", comparison$claim_status$selection_free_global_nesting_iff, fixed = TRUE) &&
    grepl("pending and not claimed", comparison$claim_status$universal_institutional_dominance, fixed = TRUE) &&
    grepl("no cross-rule coupling", review_bundle$consumer_contract$selection_boundary, fixed = TRUE),
  "The frozen consumer contract preserves the Cartesian product and all explicit pending limits.",
  "A selection, rule-choice, endpoint-ordering, or dominance limit was lost."
)

utils::write.csv(checks, freeze_checks_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")
failed <- checks$check_id[checks$status != "PASS"]
cat(sprintf("Institutional comparison freeze verifier: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Comparison interface SHA-256: %s\n", sha256_file(comparison_path)))
cat(sprintf("Review bundle SHA-256: %s\n", sha256_file(review_bundle_path)))
cat(sprintf("Candidate node verifier: %s\n", if (candidate_run$status == 0L) "42/42 PASS" else "FAIL"))
cat(sprintf("Protected hashes: %d\n", sum(protected_ok)))
cat(sprintf("Mutation guards: %d\n", 6L))
cat(sprintf("Ready: %s\n", paste(post_ready, collapse = ", ")))
cat("Candidate checker: v6_survival_matrix VALID\n")
if (length(failed)) {
  cat("Failed checks:\n")
  cat(paste0("- ", failed, collapse = "\n"), "\n")
  quit(save = "no", status = 1L)
}
