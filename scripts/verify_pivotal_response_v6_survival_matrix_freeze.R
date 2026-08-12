#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

review_bundle_path <- "model_redesign/pivotal_response_interfaces/v6_survival_matrix_review_v1.json"
candidate_path <- "model_redesign/pivotal_response_interfaces/v6_survival_matrix_v1.json"
matrix_path <- "tables/pivotal_response_v6_survival_matrix_v1.csv"
candidate_note_path <- "model_redesign/pivotal_response_nodes/v6_survival_matrix_v1.md"
candidate_verifier_path <- "scripts/verify_pivotal_response_v6_survival_matrix.R"
candidate_checks_path <- "tables/pivotal_response_v6_survival_matrix_checks_v1.csv"
candidate_status_path <- "quality_reports/2026-08-12_pivotal_response_v6_survival_matrix_status.md"
review_report_path <- "quality_reports/2026-08-12_pivotal_response_v6_survival_matrix_independent_review.md"
freeze_status_path <- "quality_reports/2026-08-12_pivotal_response_v6_survival_matrix_freeze_status.md"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
derivation_rmd_path <- "model_redesign/pivotal_response_rederivation.Rmd"
freeze_checks_path <- "tables/pivotal_response_v6_survival_matrix_freeze_checks_v1.csv"
skill_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"

required <- c(
  review_bundle_path, candidate_path, matrix_path, candidate_note_path,
  candidate_verifier_path, candidate_checks_path, candidate_status_path,
  review_report_path, freeze_status_path, protected_path, dag_path, ledger_path,
  derivation_rmd_path, skill_checker
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing survival-freeze artifacts: ", paste(missing, collapse = ", "))

expected <- c(
  review_bundle = "80c912ba35fc46bdb1859edeb91402dcb63f52079cd3ca8c4aeeb4b98b0077a7",
  candidate = "5278b14d442d49d799b93323516fc081c9e7ed57a7ad2f794bfac3e7a5a27801",
  matrix = "f634c46a764f9bacef13474be1c5f31371db8c42592f9699197191b94c0e0bd8",
  candidate_note = "518a752388679dd51951299a8d9b13250945da53b21b80d122d47aacff23760b",
  candidate_verifier = "751c0d94c021a2bcd45e6aaaa081a52c95fc632041442b4e9fee6e4ebb080ed2",
  candidate_checks = "6ec075d25f8c4cf121426a201e0a48a03e2f2026cf4594bdc7ab034bd1945370",
  candidate_status = "5ac452c2262051248a55ce396fad967050b180eeec5e0082aeb2219703354b27",
  comparison = "cab69c5ddda3616f51c697c189c86316df5546501a183eb6cc9e437dc813f3af",
  comparison_review = "0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c",
  protected_manifest = "e6c2dcaea628acf84ea77853448b185b189e24d7b809e540e442fd820b0d6d6c",
  review_report = "cca7c2427184dfa1a1360733e8388530c618289ac76d0a912f5df8343762395c",
  freeze_status = "29bcb2bcbf59152c413ac63fff86189b6eb5a6912c841fa4510008dfc6f34991",
  dag = "4b7aa1b9647791b7e2b3a62fd21c1b782982eca40d44414c8e23f88140b166c0",
  ledger = "23d0566aa55aeac74b43819d907c9022ed02e065210694d26dda7b13283c1750",
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

resolve_components <- function(parent_path, components) {
  parent_dir <- dirname(normalizePath(parent_path, mustWork = TRUE))
  vapply(components, function(x) normalizePath(file.path(parent_dir, x$path), mustWork = TRUE), character(1))
}

component_hashes_match <- function(parent_path, components) {
  paths <- resolve_components(parent_path, components)
  declared <- vapply(components, function(x) x$sha256, character(1))
  actual <- unname(vapply(paths, sha256_file, character(1)))
  identical(actual, declared)
}

run_command <- function(command, args) {
  out <- suppressWarnings(system2(command, args, stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = paste(out, collapse = "\n"))
}

zero_review <- function(x, order) {
  identical(x$verdict, "pass") && identical(as.integer(x$order), as.integer(order)) &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L) &&
    identical(x$official_verifier, "43/43 PASS") &&
    identical(x$protected_hashes, "27/27 PASS") &&
    identical(x$review_mode, "independent and read-only")
}

node_map <- function(dag) stats::setNames(dag$nodes, vapply(dag$nodes, function(x) x$id, character(1)))

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
    if (!identical(node$status, "pass") || !length(node$depends_on)) return(TRUE)
    if (is.null(node$dependency_hashes)) return(FALSE)
    all(vapply(node$depends_on, function(dep) {
      is_frozen(nodes[[dep]]) && identical(node$dependency_hashes[[dep]], nodes[[dep]]$artifact_hash)
    }, logical(1)))
  }, logical(1)))
}

protected_valid <- function(tab) {
  identical(names(tab), c("path", "sha256", "category", "frozen_at_head")) &&
    nrow(tab) == 27L && all(file.exists(tab$path)) &&
    all(vapply(tab$path, sha256_file, character(1)) == tab$sha256)
}

review_contract_valid <- function(review) {
  identical(review$state_id, "v6_survival_matrix_review") && identical(review$status, "pass") &&
    identical(review$candidate_review$approved_interface_sha256, expected[["candidate"]]) &&
    identical(review$candidate_review$approved_matrix_sha256, expected[["matrix"]]) &&
    identical(as.integer(review$candidate_review$implementation_started_order), 61L) &&
    identical(as.integer(review$candidate_review$implementation_completed_order), 62L) &&
    zero_review(review$candidate_review$formal_cold_review, 63L) &&
    zero_review(review$candidate_review$adversarial_game_theory_review, 64L) &&
    identical(review$rejected_history, list()) &&
    identical(as.integer(review$survival_close$started_order), 65L) &&
    identical(as.integer(review$survival_close$verification_order), 66L) &&
    identical(as.integer(review$survival_close$passed_order), 67L) &&
    identical(review$survival_close$status, "pass") &&
    identical(as.integer(review$survival_close$claim_count), 53L) &&
    identical(review$survival_close$ready_after_close, list()) &&
    identical(review$survival_close$started_descendants, list())
}

dag_close_valid <- function(dag) {
  nodes <- node_map(dag)
  if (!"v6_survival_matrix" %in% names(nodes)) return(FALSE)
  node <- nodes[["v6_survival_matrix"]]
  all(vapply(nodes, function(x) identical(x$status, "pass"), logical(1))) &&
    identical(ready_nodes(dag), character()) && dependency_links_valid(dag) &&
    identical(node$artifact_hash, paste0("sha256:", expected[["candidate"]])) &&
    identical(node$review_bundle_hash, paste0("sha256:", expected[["review_bundle"]])) &&
    identical(as.integer(node$started_order), 61L) &&
    identical(as.integer(node$implementation_completed_order), 62L) &&
    identical(unlist(node$review_orders), c(63L, 64L)) &&
    identical(unlist(node$review_verdicts), c("formal_cold_pass", "adversarial_game_theory_pass")) &&
    identical(as.integer(node$freeze_started_order), 65L) &&
    identical(as.integer(node$verification_order), 66L) &&
    identical(as.integer(node$passed_order), 67L)
}

ledger_close_valid <- function(ledger) {
  candidate <- ledger[ledger$object == "v6 survival-matrix candidate", , drop = FALSE]
  freeze <- ledger[ledger$object == "v6 survival-matrix independent review and freeze", , drop = FALSE]
  nrow(candidate) == 1L && nrow(freeze) == 1L &&
    identical(candidate$status, "checked numerically") &&
    identical(as.integer(candidate$started_order), 61L) && identical(as.integer(candidate$passed_order), 62L) &&
    identical(freeze$status, "proved") &&
    identical(as.integer(freeze$started_order), 63L) && identical(as.integer(freeze$passed_order), 67L) &&
    grepl(expected[["review_bundle"]], freeze$evidence, fixed = TRUE)
}

review <- jsonlite::fromJSON(review_bundle_path, simplifyVector = FALSE)
candidate <- jsonlite::fromJSON(candidate_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
candidate_checks <- utils::read.csv(candidate_checks_path, check.names = FALSE, na.strings = character())
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
review_text <- paste(readLines(review_report_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
freeze_text <- paste(readLines(freeze_status_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

add_check(
  "review_bundle_identity_and_hash",
  review_contract_valid(review) && identical(sha256_file(review_bundle_path), expected[["review_bundle"]]),
  paste("Survival review bundle is PASS at exact hash", expected[["review_bundle"]]),
  "Review-bundle identity, orders, verdicts, close fields, or exact hash differs."
)

add_check(
  "reviewed_candidate_exact_hashes",
  identical(sha256_file(candidate_path), expected[["candidate"]]) &&
    identical(sha256_file(matrix_path), expected[["matrix"]]) &&
    identical(candidate$status, "candidate_pending_independent_review") &&
    identical(review$candidate_review$approved_interface_sha256, expected[["candidate"]]) &&
    identical(review$candidate_review$approved_matrix_sha256, expected[["matrix"]]),
  "The immutable JSON and CSV are the exact independently approved candidate bytes.",
  "A candidate byte stream, immutable status, or approved digest differs."
)

add_check(
  "six_candidate_artifacts_exact",
  identical(unname(vapply(c(candidate_path, matrix_path, candidate_note_path, candidate_verifier_path,
                            candidate_checks_path, candidate_status_path), sha256_file, character(1))),
            unname(expected[c("candidate", "matrix", "candidate_note", "candidate_verifier",
                              "candidate_checks", "candidate_status")])),
  "All six reviewed survival-candidate artifacts retain exact bytes.",
  "At least one reviewed survival-candidate artifact changed."
)

roles <- vapply(review$components, function(x) x$role, character(1))
add_check(
  "dependency_complete_component_inventory",
  length(review$components) == 26L && sum(roles == "historical_inventory_source") == 3L &&
    sum(roles == "governance_inventory_source") == 1L && sum(roles == "r2_interface") == 3L &&
    sum(roles == "r1_interface") == 2L && sum(roles == "entry_interface") == 2L &&
    sum(grepl("survival", roles, fixed = TRUE)) == 6L,
  "The review bundle inventories 26 exact dependencies, candidate artifacts, evidence interfaces, and source snapshots.",
  paste("Unexpected component inventory:", paste(roles, collapse = ", "))
)

add_check(
  "all_component_hashes_exact",
  component_hashes_match(review_bundle_path, review$components),
  "All 26 review-bundle component hashes match exact bytes.",
  "At least one review-bundle component hash differs."
)

upstream_roles <- vapply(review$reviewed_upstream, function(x) x$node, character(1))
upstream_hashes <- vapply(review$reviewed_upstream, function(x) x$sha256, character(1))
add_check(
  "approved_comparison_dependencies_exact",
  identical(upstream_roles, c("institutional_comparison", "institutional_comparison_review")) &&
    identical(upstream_hashes, unname(expected[c("comparison", "comparison_review")])),
  "The exact comparison interface and its consumer-contract review are locked.",
  "An upstream comparison role or digest differs."
)

add_check(
  "two_independent_zero_finding_reviews",
  zero_review(review$candidate_review$formal_cold_review, 63L) &&
    zero_review(review$candidate_review$adversarial_game_theory_review, 64L),
  "Formal/cold and adversarial game-theory reviews are independent read-only PASS with 0/0/0 findings.",
  "A reviewer order, mode, verdict, finding count, verifier result, or protection result differs."
)

event_orders <- vapply(review$execution_events, function(x) as.integer(x$order), integer(1))
event_names <- vapply(review$execution_events, function(x) x$event, character(1))
add_check(
  "execution_events_contiguous",
  identical(event_orders, 62:67) && identical(event_names, c(
    "v6_survival_matrix_implementation_complete",
    "v6_survival_matrix_formal_cold_review_pass",
    "v6_survival_matrix_adversarial_game_theory_review_pass",
    "v6_survival_matrix_freeze_start",
    "v6_survival_matrix_mechanical_verification_pass",
    "v6_survival_matrix_close_pass"
  )),
  "Implementation, two reviews, freeze, verification, and close occupy exact orders 62 through 67.",
  "Execution events or orders are missing, duplicated, or reordered."
)

candidate_run <- run_command("Rscript", c("--vanilla", candidate_verifier_path))
add_check(
  "candidate_verifier_rerun",
  candidate_run$status == 0L && grepl("43/43 PASS", candidate_run$output, fixed = TRUE),
  "The exact candidate verifier reruns successfully: 43/43 PASS.",
  paste("Candidate verifier status", candidate_run$status, candidate_run$output)
)

add_check(
  "candidate_check_snapshot",
  nrow(candidate_checks) == 43L && all(candidate_checks$status == "PASS") &&
    identical(sha256_file(candidate_checks_path), expected[["candidate_checks"]]),
  "The immutable candidate check snapshot remains 43/43 PASS.",
  "The candidate check count, status, or exact hash differs."
)

add_check(
  "protected_manifest_and_27_artifacts",
  identical(sha256_file(protected_path), expected[["protected_manifest"]]) && protected_valid(protected),
  "The protected manifest and all 27 protected artifacts retain exact hashes.",
  "The protected manifest or at least one protected artifact changed."
)

add_check(
  "dag_exact_closed_state",
  identical(sha256_file(dag_path), expected[["dag"]]) && dag_close_valid(dag),
  "Every game-DAG node is PASS, v6_survival_matrix closes at order 67, and Ready is empty.",
  "The DAG hash, close metadata, dependency links, PASS set, or frontier differs."
)

dag_run <- run_command("python3", c(skill_checker, dag_path, "--require-execution-order"))
add_check(
  "solve_dynamic_games_dag_checker",
  dag_run$status == 0L && grepl("VALID", dag_run$output, fixed = TRUE) &&
    grepl("Ready: none", dag_run$output, fixed = TRUE),
  "solve-dynamic-games checker reports VALID with Ready: none under execution-order audit.",
  paste("DAG checker status", dag_run$status, dag_run$output)
)

add_check(
  "proof_ledger_exact_close",
  identical(sha256_file(ledger_path), expected[["ledger"]]) && ledger_close_valid(ledger),
  "The proof ledger records implementation 61-62 and independent freeze 63-67.",
  "The proof-ledger hash, evidence, status, or close orders differ."
)

add_check(
  "independent_review_report_exact",
  identical(sha256_file(review_report_path), expected[["review_report"]]) &&
    grepl("Overall verdict:** **PASS", review_text, fixed = TRUE) &&
    grepl("0` critical", review_text, fixed = TRUE) &&
    grepl("43/43 PASS", review_text, fixed = TRUE),
  "The independent-review report records exact-hash PASS and zero findings.",
  "The independent-review report hash or verdict language differs."
)

add_check(
  "freeze_status_exact_and_nonmigrating",
  identical(sha256_file(freeze_status_path), expected[["freeze_status"]]) &&
    grepl("Overall status:** **PASS", freeze_text, fixed = TRUE) &&
    grepl("Ready: none", freeze_text, fixed = TRUE) &&
    grepl("does not authorize manuscript", freeze_text, fixed = TRUE),
  "The freeze status records PASS, an empty frontier, and the non-migration boundary.",
  "The freeze-status hash, close result, or migration boundary differs."
)

add_check(
  "shared_derivation_rmd_untouched",
  identical(sha256_file(derivation_rmd_path), expected[["derivation_rmd"]]),
  "The shared derivation Rmd remains byte-identical during survival closure.",
  "The shared derivation Rmd changed during survival closure."
)

mut_review_hash <- clone_record(review)
mut_review_hash$candidate_review$approved_interface_sha256 <- paste(rep("0", 64L), collapse = "")
add_check(
  "negative_mutation_reviewed_hash",
  !review_contract_valid(mut_review_hash),
  "Negative mutation: changing the approved candidate hash invalidates review closure.",
  "A changed approved candidate hash was not rejected."
)

mut_review_verdict <- clone_record(review)
mut_review_verdict$candidate_review$adversarial_game_theory_review$verdict <- "repair"
add_check(
  "negative_mutation_review_verdict",
  !review_contract_valid(mut_review_verdict),
  "Negative mutation: changing a reviewer verdict invalidates review closure.",
  "A non-PASS reviewer verdict was not rejected."
)

mut_component <- clone_record(review)
mut_component$components[[17L]]$sha256 <- paste(rep("f", 64L), collapse = "")
add_check(
  "negative_mutation_component_hash",
  !component_hashes_match(review_bundle_path, mut_component$components),
  "Negative mutation: changing a bundled candidate hash breaks dependency closure.",
  "A changed bundle component hash was not rejected."
)

mut_dag <- clone_record(dag)
mut_nodes <- node_map(mut_dag)
mut_nodes[["v6_survival_matrix"]]$artifact_hash <- paste0("sha256:", paste(rep("a", 64L), collapse = ""))
mut_dag$nodes <- unname(mut_nodes)
add_check(
  "negative_mutation_dag_artifact",
  !dag_close_valid(mut_dag),
  "Negative mutation: changing the frozen DAG artifact hash invalidates close.",
  "A changed frozen DAG artifact hash was not rejected."
)

mut_dag_status <- clone_record(dag)
mut_nodes <- node_map(mut_dag_status)
mut_nodes[["v6_survival_matrix"]]$status <- "pending"
mut_dag_status$nodes <- unname(mut_nodes)
add_check(
  "negative_mutation_dag_status",
  !dag_close_valid(mut_dag_status),
  "Negative mutation: reopening the terminal node invalidates all-PASS closure.",
  "A reopened terminal node was not rejected."
)

mut_ledger <- clone_record(ledger)
mut_ledger$passed_order[mut_ledger$object == "v6 survival-matrix independent review and freeze"] <- 66L
add_check(
  "negative_mutation_ledger_order",
  !ledger_close_valid(mut_ledger),
  "Negative mutation: changing the ledger close order invalidates provenance.",
  "A changed ledger close order was not rejected."
)

mut_protected <- clone_record(protected)
mut_protected$sha256[[1L]] <- paste(rep("b", 64L), collapse = "")
add_check(
  "negative_mutation_protected_hash",
  !protected_valid(mut_protected),
  "Negative mutation: changing a protected hash invalidates closure.",
  "A changed protected hash was not rejected."
)

utils::write.csv(checks, freeze_checks_path, row.names = FALSE, na = "")
n_fail <- sum(checks$status != "PASS")
cat(sprintf("Survival-matrix freeze verification: %d/%d PASS\n", nrow(checks) - n_fail, nrow(checks)))
cat("Game DAG: all nodes PASS; Ready: none.\n")
cat("Protected artifacts: 27/27 PASS.\n")
if (n_fail) {
  print(checks[checks$status != "PASS", , drop = FALSE])
  quit(status = 1L)
}
