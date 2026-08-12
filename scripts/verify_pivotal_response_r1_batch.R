#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

batch_path <- "model_redesign/pivotal_response_interfaces/r1_batch_frozen_v1.json"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
gate0_path <- "model_redesign/pivotal_response_interfaces/gate0_bundle_v1.json"
r2_batch_path <- "model_redesign/pivotal_response_interfaces/r2_batch_review_v1.json"
u_path <- "model_redesign/pivotal_response_interfaces/r1_unanimity_v1.json"
m_path <- "model_redesign/pivotal_response_interfaces/r1_majority_v1.json"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
status_path <- "quality_reports/2026-08-12_pivotal_response_r1_batch_status.md"
review_path <- "quality_reports/2026-08-12_pivotal_response_r1_batch_independent_review.md"
checks_path <- "tables/pivotal_response_r1_batch_checks_v1.csv"

required <- c(
  batch_path, dag_path, gate0_path, r2_batch_path, u_path, m_path,
  protected_path, ledger_path, status_path, review_path
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing R1 batch artifacts: ", paste(missing, collapse = ", "))

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
clone_record <- function(x) unserialize(serialize(x, NULL))
read_csv <- function(path) {
  utils::read.csv(path, check.names = FALSE, na.strings = character(), quote = "\"")
}
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
has_path <- function(nodes, start, target) {
  queue <- nodes[[start]]$depends_on
  seen <- character()
  while (length(queue)) {
    current <- queue[[1]]
    queue <- queue[-1]
    if (identical(current, target)) return(TRUE)
    if (current %in% seen) next
    seen <- c(seen, current)
    queue <- c(queue, nodes[[current]]$depends_on)
  }
  FALSE
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

batch <- jsonlite::fromJSON(batch_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
gate0 <- jsonlite::fromJSON(gate0_path, simplifyVector = FALSE)
r2_batch <- jsonlite::fromJSON(r2_batch_path, simplifyVector = FALSE)
u <- jsonlite::fromJSON(u_path, simplifyVector = FALSE)
m <- jsonlite::fromJSON(m_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
status_text <- paste(readLines(status_path, warn = FALSE), collapse = "\n")
review_text <- paste(readLines(review_path, warn = FALSE), collapse = "\n")
batch_text <- paste(readLines(batch_path, warn = FALSE), collapse = "\n")

approved <- c(
  r1_unanimity = "37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5",
  r1_majority = "21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9"
)
gate0_hash <- "6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1"
r2_batch_hash <- "00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a"
rejected <- c(
  r1_unanimity = "da52b135198898948ae88f919a849c76189f27fc6fff4d3f7646c4218d0f30aa",
  r1_majority = "b09b54bb32aab50c770847768e75d02c2f1c0e2d19cad9420fb4d86b4b6cd03e"
)

add_check(
  "batch_identity",
  identical(batch$state_id, "r1_batch_frozen") && identical(batch$status, "pass") &&
    identical(batch$native_payoff_date, "Round 1") &&
    grepl("perfect Bayesian equilibrium", batch$solution_concept, ignore.case = TRUE),
  paste("R1 batch PASS interface:", sha256_file(batch_path)),
  "R1 batch identity, status, payoff date, or solution concept differs."
)
add_check(
  "upstream_exact_hashes",
  identical(sha256_file(gate0_path), gate0_hash) &&
    identical(sha256_file(r2_batch_path), r2_batch_hash) &&
    identical(batch$reviewed_upstream[[1]]$sha256, gate0_hash) &&
    identical(batch$reviewed_upstream[[2]]$sha256, r2_batch_hash),
  "Gate 0 and R2 batch exact hashes match the frozen inputs.",
  "Gate 0 or R2 batch changed or is declared incorrectly."
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
  "component_inventory",
  length(batch$components) == 17L &&
    sum(batch_roles == "c1_interface") == 2L &&
    sum(batch_roles == "derivation_note") == 2L &&
    sum(batch_roles == "candidate_status_snapshot") == 2L &&
    sum(batch_roles == "node_verifier") == 2L &&
    sum(batch_roles == "node_check_table") == 2L &&
    sum(batch_roles == "node_case_table") == 2L &&
    sum(batch_roles == "node_n3_table") == 2L &&
    all(c("gate0_contract", "r2_batch_review", names(approved)) %in% unique(batch_nodes)),
  "Batch inventories 17 Gate 0, R2, C1, note, status, verifier, and table components.",
  paste("Unexpected component roles:", paste(batch_roles, collapse = ", "))
)
add_check(
  "component_hashes",
  identical(actual_hashes, declared_hashes),
  "All 17 component hashes match exact bytes.",
  paste("Hash mismatch:", paste(component_paths[actual_hashes != declared_hashes], collapse = ", "))
)

gate0_dir <- dirname(normalizePath(gate0_path, mustWork = TRUE))
gate0_paths <- vapply(gate0$components, function(x) {
  normalizePath(file.path(gate0_dir, x$path), mustWork = TRUE)
}, character(1))
gate0_declared <- vapply(gate0$components, function(x) x$sha256, character(1))
gate0_actual <- unname(vapply(gate0_paths, sha256_file, character(1)))
r2_dir <- dirname(normalizePath(r2_batch_path, mustWork = TRUE))
r2_paths <- vapply(r2_batch$components, function(x) {
  normalizePath(file.path(r2_dir, x$path), mustWork = TRUE)
}, character(1))
r2_declared <- vapply(r2_batch$components, function(x) x$sha256, character(1))
r2_actual <- unname(vapply(r2_paths, sha256_file, character(1)))
add_check(
  "transitive_dependencies",
  length(gate0$components) == 5L && identical(gate0_actual, gate0_declared) &&
    length(r2_batch$components) == 19L && identical(r2_actual, r2_declared) &&
    identical(r2_batch$reviewed_gate0$sha256, gate0_hash),
  "All 5 Gate 0 and 19 R2-batch transitive component hashes match.",
  "A transitive Gate 0 or R2-batch component changed."
)

manifest_columns <- c("path", "sha256", "category", "frozen_at_head")
protected_actual <- vapply(protected$path, sha256_file, character(1))
protected_ok <- file.exists(protected$path) & !is.na(protected_actual) &
  protected_actual == protected$sha256
add_check(
  "protected_manifest_and_hashes",
  identical(names(protected), manifest_columns) && nrow(protected) == 27L && all(protected_ok),
  "All 27 protected artifacts remain byte-identical.",
  paste("Protected mismatch:", paste(protected$path[!protected_ok], collapse = ", "))
)

c1_components <- batch$components[batch_roles == "c1_interface"]
declared_c1 <- stats::setNames(
  vapply(c1_components, function(x) x$sha256, character(1)),
  vapply(c1_components, function(x) x$node, character(1))
)
add_check(
  "approved_c1_hashes",
  identical(declared_c1[names(approved)], approved) &&
    identical(sha256_file(u_path), approved[["r1_unanimity"]]) &&
    identical(sha256_file(m_path), approved[["r1_majority"]]),
  "Both exact independently approved C1 hashes are frozen.",
  "An approved C1 hash differs."
)
add_check(
  "c1_upstream_provenance",
  identical(u$provenance$frozen_gate0_bundle_sha256, gate0_hash) &&
    identical(u$provenance$frozen_r2_batch_sha256, r2_batch_hash) &&
    any(vapply(m$dependencies, function(x) {
      identical(x$role, "reviewed_R2_batch") && identical(x$sha256, r2_batch_hash)
    }, logical(1))) && identical(r2_batch$reviewed_gate0$sha256, gate0_hash),
  "Both C1 interfaces point to the exact Gate 0 and R2 batch hashes.",
  "A C1 provenance pointer is stale or missing."
)
add_check(
  "c1_export_domain_and_correspondence",
  identical(u$export_domain_gate$validated_exportable_domain, "N>=3") &&
    grepl("N>=3", m$existence_and_multiplicity$global_existence, fixed = TRUE) &&
    grepl("full", u$pre_recognition_C1_correspondence$selection_status, ignore.case = TRUE) &&
    grepl("every H or named weak identity", m$pre_recognition_interface$type_by_identity_correspondence, fixed = TRUE) &&
    grepl("full assessment-indexed", batch$consumer_contract$object, fixed = TRUE) &&
    grepl("forbidden", batch$consumer_contract$scalarization, fixed = TRUE),
  "Both C1 objects export full assessment-level correspondences on N>=3.",
  "A full-domain gate or correspondence-preservation clause is absent."
)

u_checks <- read_csv("tables/pivotal_response_r1_unanimity_checks.csv")
m_checks <- read_csv("tables/pivotal_response_r1_majority_checks_v1.csv")
add_check(
  "node_check_tables_pass",
  nrow(u_checks) == 37L && all(u_checks$status == "PASS") &&
    nrow(m_checks) == 23L && all(m_checks$status == "PASS"),
  "Node tables retain U 37/37 and M 23/23 PASS.",
  "A node check table has a failure or unexpected row count."
)

reviews <- stats::setNames(batch$node_reviews, vapply(batch$node_reviews, function(x) x$node, character(1)))
zero_pass <- function(x, order) {
  identical(x$verdict, "pass") && identical(as.integer(x$order), as.integer(order)) &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L)
}
add_check(
  "two_independent_passes_per_node",
  identical(reviews$r1_unanimity$approved_sha256, approved[["r1_unanimity"]]) &&
    identical(reviews$r1_majority$approved_sha256, approved[["r1_majority"]]) &&
    zero_pass(reviews$r1_unanimity$formal_rereview, 36L) &&
    zero_pass(reviews$r1_unanimity$adversarial_rereview, 37L) &&
    zero_pass(reviews$r1_majority$formal_rereview, 36L) &&
    zero_pass(reviews$r1_majority$adversarial_rereview, 37L),
  "Each exact repaired C1 has formal and adversarial zero-finding PASS rereviews.",
  "A review verdict, order, finding count, or approved hash differs."
)
add_check(
  "review_report_matches",
  all(vapply(c(approved, rejected), function(x) grepl(x, review_text, fixed = TRUE), logical(1))) &&
    grepl("37/37 PASS", review_text, fixed = TRUE) &&
    grepl("23/23 PASS", review_text, fixed = TRUE) &&
    grepl("500-cell", review_text, fixed = TRUE) &&
    grepl("932-assessment", review_text, fixed = TRUE),
  "Consolidated read-only review report records both approvals, probes, and quarantines.",
  "The consolidated review report is incomplete."
)

rejected_declared <- stats::setNames(
  vapply(batch$rejected_history, function(x) x$sha256, character(1)),
  vapply(batch$rejected_history, function(x) x$node, character(1))
)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
dag_nodes <- node_map(dag)
consumable_hashes <- c(
  declared_hashes,
  vapply(dag$nodes, function(x) if (is.null(x$artifact_hash)) "" else sub("^sha256:", "", x$artifact_hash), character(1)),
  unlist(lapply(dag$nodes, function(x) if (is.null(x$dependency_hashes)) character() else sub("^sha256:", "", unlist(x$dependency_hashes))), use.names = FALSE)
)
add_check(
  "rejected_history_quarantined",
  identical(rejected_declared[names(rejected)], rejected) &&
    all(vapply(batch$rejected_history, function(x) identical(x$status, "rejected_historical_nonconsumable"), logical(1))) &&
    !any(rejected %in% consumable_hashes),
  "Rejected da52 and b09 hashes are recorded only as nonconsumable history.",
  "A rejected R1 hash is missing from quarantine or appears as a consumable hash."
)

event_orders <- vapply(batch$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(batch$execution_events, function(x) x$event, character(1))
expected_events <- c(
  "r1_majority_repair_complete", "r1_unanimity_repair_complete",
  "r1_formal_rereview_pass", "r1_adversarial_rereview_pass",
  "r1_batch_close_start", "r1_batch_mechanical_verification_pass",
  "r1_batch_close_pass"
)
add_check(
  "execution_events_exact",
  identical(event_orders, 34:40) && identical(event_names, expected_events),
  "R1 close events are exactly ordered 34 through 40.",
  "R1 close event chronology differs."
)

batch_hash_prefixed <- paste0("sha256:", sha256_file(batch_path))
add_check(
  "dag_r1_status_and_orders",
  identical(dag_nodes$r1_majority$status, "pass") &&
    identical(dag_nodes$r1_majority$artifact_hash, paste0("sha256:", approved[["r1_majority"]])) &&
    identical(as.integer(dag_nodes$r1_majority$implementation_completed_order), 34L) &&
    identical(as.integer(dag_nodes$r1_majority$passed_order), 37L) &&
    identical(dag_nodes$r1_unanimity$status, "pass") &&
    identical(dag_nodes$r1_unanimity$artifact_hash, paste0("sha256:", approved[["r1_unanimity"]])) &&
    identical(as.integer(dag_nodes$r1_unanimity$implementation_completed_order), 35L) &&
    identical(as.integer(dag_nodes$r1_unanimity$passed_order), 37L) &&
    identical(dag_nodes$r1_batch_frozen$status, "pass") &&
    identical(dag_nodes$r1_batch_frozen$artifact_hash, batch_hash_prefixed) &&
    identical(as.integer(dag_nodes$r1_batch_frozen$started_order), 38L) &&
    identical(as.integer(dag_nodes$r1_batch_frozen$verification_order), 39L) &&
    identical(as.integer(dag_nodes$r1_batch_frozen$passed_order), 40L),
  "DAG records repaired completions, rereviews, and batch close at orders 34--40.",
  "A DAG R1 status, hash, or order differs."
)
add_check(
  "dag_dependency_hashes",
  dependency_links_valid(dag) &&
    identical(dag_nodes$r1_batch_frozen$dependency_hashes$r1_unanimity, paste0("sha256:", approved[["r1_unanimity"]])) &&
    identical(dag_nodes$r1_batch_frozen$dependency_hashes$r1_majority, paste0("sha256:", approved[["r1_majority"]])),
  "All started/pass DAG nodes freeze exact current dependency hashes.",
  "A started/pass DAG node has a stale dependency hash."
)

pre_freeze <- clone_record(dag)
pre_nodes <- node_map(pre_freeze)
pre_nodes$r1_batch_frozen$status <- "pending"
pre_nodes$r1_batch_frozen$authorized <- FALSE
pre_nodes$r1_batch_frozen$artifact_path <- NULL
pre_nodes$r1_batch_frozen$artifact_hash <- NULL
pre_nodes$r1_batch_frozen$started_order <- NULL
pre_nodes$r1_batch_frozen$verification_order <- NULL
pre_nodes$r1_batch_frozen$passed_order <- NULL
pre_nodes$r1_batch_frozen$dependency_hashes <- NULL
pre_freeze$nodes <- unname(pre_nodes)
pre_ready <- ready_nodes(pre_freeze)
pre_nodes <- node_map(pre_freeze)
add_check(
  "negative_barrier_before_freeze",
  identical(pre_ready, "r1_batch_frozen") &&
    !any(c("entry_unanimity", "entry_majority") %in% pre_ready) &&
    all(vapply(c("entry_unanimity", "entry_majority"), function(id) {
      identical(pre_nodes[[id]]$status, "pending") && is.null(pre_nodes[[id]]$started_order)
    }, logical(1))),
  "Before the batch freeze, no entry node is ready or started.",
  paste("Premature pre-freeze ready set:", paste(pre_ready, collapse = ", "))
)

post_ready <- ready_nodes(dag)
entry_pair <- c("entry_majority", "entry_unanimity")
entry_antichain <- !has_path(dag_nodes, entry_pair[[1]], entry_pair[[2]]) &&
  !has_path(dag_nodes, entry_pair[[2]], entry_pair[[1]])
add_check(
  "ready_after_freeze_exact",
  identical(post_ready, entry_pair) && entry_antichain &&
    all(vapply(entry_pair, function(id) {
      identical(dag_nodes[[id]]$status, "pending") &&
        identical(dag_nodes[[id]]$authorized, TRUE) &&
        is.null(dag_nodes[[id]]$started_order)
    }, logical(1))),
  "After freeze exactly entry_majority and entry_unanimity are ready, authorized, pending, and antichain-valid.",
  paste("Unexpected post-freeze ready set:", paste(post_ready, collapse = ", "))
)
add_check(
  "comparison_barrier_after_freeze",
  !"institutional_comparison" %in% post_ready &&
    identical(dag_nodes$institutional_comparison$status, "pending") &&
    identical(dag_nodes$institutional_comparison$authorized, FALSE) &&
    is.null(dag_nodes$institutional_comparison$started_order) &&
    !file.exists("model_redesign/pivotal_response_interfaces/institutional_comparison_v1.json"),
  "Institutional comparison remains blocked, unauthorized, unstarted, and absent.",
  "Institutional comparison is prematurely ready, started, authorized, or materialized."
)

mutate_hash <- function(dag, node_id) {
  out <- clone_record(dag)
  nodes <- node_map(out)
  nodes[[node_id]]$artifact_hash <- paste0("sha256:mutated-", node_id)
  out$nodes <- unname(nodes)
  out
}
mutation_expectations <- list(
  r1_unanimity = c("r1_batch_frozen"),
  r1_majority = c("r1_batch_frozen"),
  r2_batch_review = c("r1_unanimity", "r1_majority"),
  r1_batch_frozen = c("entry_unanimity", "entry_majority")
)
mutation_ok <- vapply(names(mutation_expectations), function(upstream) {
  mutant <- mutate_hash(dag, upstream)
  nodes <- node_map(mutant)
  children <- mutation_expectations[[upstream]]
  immediate_stale <- all(vapply(children, function(child) {
    frozen <- nodes[[child]]$dependency_hashes
    if (is.null(frozen)) return(nodes[[child]]$status == "pending")
    !identical(frozen[[upstream]], nodes[[upstream]]$artifact_hash)
  }, logical(1)))
  stale_consumers <- all(vapply(children, function(child) {
    if (!identical(nodes[[child]]$status, "pending")) return(TRUE)
    frozen <- nodes[[child]]$dependency_hashes
    is.null(frozen) || !identical(frozen[[upstream]], nodes[[upstream]]$artifact_hash)
  }, logical(1)))
  immediate_stale && stale_consumers &&
    (upstream == "r1_batch_frozen" || !dependency_links_valid(mutant))
}, logical(1))
add_check(
  "four_hash_mutation_guards",
  all(mutation_ok),
  "One-at-a-time U, M, R2-batch, and R1-batch hash mutations invalidate their immediate frozen consumers.",
  paste("Failed mutations:", paste(names(mutation_ok)[!mutation_ok], collapse = ", "))
)

ledger_rows <- ledger[ledger$state_id %in% c("r1_unanimity", "r1_majority", "r1_batch_frozen"), , drop = FALSE]
add_check(
  "proof_ledger_closed",
  nrow(ledger_rows) >= 5L &&
    any(ledger_rows$object == "Round 1 unanimity, repaired candidate" & ledger_rows$status == "proved" & ledger_rows$passed_order == "37") &&
    any(ledger_rows$object == "Round 1 majority, repaired candidate" & ledger_rows$status == "proved" & ledger_rows$passed_order == "37") &&
    any(ledger_rows$object == "R1 batch freeze" & ledger_rows$status == "proved" & ledger_rows$started_order == "38" & ledger_rows$passed_order == "40"),
  "Proof ledger closes both repaired R1 nodes and the batch at the exact orders.",
  "Proof ledger R1 closure rows are absent or stale."
)
add_check(
  "status_report_closed",
  grepl("Overall status:** **PASS**", status_text, fixed = TRUE) &&
    grepl("passed_order=40", status_text, fixed = TRUE) &&
    grepl(approved[["r1_unanimity"]], status_text, fixed = TRUE) &&
    grepl(approved[["r1_majority"]], status_text, fixed = TRUE) &&
    grepl("Ready: entry_majority, entry_unanimity", status_text, fixed = TRUE),
  "R1 batch status reports PASS, exact hashes, order 40, and the ready antichain.",
  "R1 batch status report is incomplete or stale."
)

add_check(
  "no_entry_artifacts_created",
  !file.exists("model_redesign/pivotal_response_interfaces/entry_unanimity_v1.json") &&
    !file.exists("model_redesign/pivotal_response_interfaces/entry_majority_v1.json"),
  "No entry interface was created by the R1 freeze.",
  "An entry interface exists prematurely."
)
add_check(
  "no_substantive_batch_claim",
  grepl("makes no formation or institutional-comparison claim", batch$consumer_contract$entry_rule, fixed = TRUE) &&
    !grepl("minimal coalition|zero-gift", batch_text, ignore.case = TRUE) &&
    grepl("adds no scalarization", review_text, fixed = TRUE),
  "Batch adds no formation, comparison, scalarization, or coalition result.",
  "The batch close may contain a new substantive claim."
)

utils::write.csv(checks, checks_path, row.names = FALSE, quote = TRUE, fileEncoding = "UTF-8")
failed <- checks$check_id[checks$status != "PASS"]
cat(sprintf("R1 batch verifier: %d/%d PASS\n", sum(checks$status == "PASS"), nrow(checks)))
cat(sprintf("Batch interface SHA-256: %s\n", sha256_file(batch_path)))
cat(sprintf("Ready: %s\n", paste(post_ready, collapse = ", ")))
cat(sprintf("Candidate antichain: %s\n", paste(entry_pair, collapse = ", ")))
if (length(failed)) {
  cat("Failed checks:\n")
  cat(paste0("- ", failed, collapse = "\n"), "\n")
  quit(save = "no", status = 1L)
}
