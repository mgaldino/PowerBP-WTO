#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

review_bundle_path <- "model_redesign/pivotal_response_interfaces/pivotal_response_full_chain_review_v1.json"
release_path <- "model_redesign/pivotal_response_interfaces/pivotal_response_full_chain_release_v1.json"
master_verifier_path <- "scripts/verify_pivotal_response_full_chain.R"
master_checks_path <- "tables/pivotal_response_full_chain_checks_v1.csv"
candidate_status_path <- "quality_reports/2026-08-12_pivotal_response_full_chain_candidate_status.md"
visual_audit_path <- "quality_reports/2026-08-12_pivotal_response_full_chain_visual_audit.md"
review_report_path <- "quality_reports/2026-08-12_pivotal_response_full_chain_independent_review.md"
freeze_status_path <- "quality_reports/2026-08-12_pivotal_response_full_chain_freeze_status.md"
protected_path <- "quality_reports/2026-08-11_pivotal_response_protected_hash_manifest.tsv"
dag_path <- "model_redesign/pivotal_response_game_dag.json"
ledger_path <- "quality_reports/2026-08-11_pivotal_response_proof_ledger.tsv"
freeze_checks_path <- "tables/pivotal_response_full_chain_freeze_checks_v1.csv"
skill_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"

required <- c(
  review_bundle_path, release_path, master_verifier_path, master_checks_path,
  candidate_status_path, visual_audit_path, review_report_path, freeze_status_path,
  protected_path, dag_path, ledger_path, skill_checker
)
missing <- required[!file.exists(required)]
if (length(missing)) stop("Missing full-chain freeze artifacts: ", paste(missing, collapse = ", "))

expected <- c(
  review_bundle = "c198391dc24980eef150f58b6756e46d22b5b6aee168d67fdc687757c7304f80",
  release = "d06fe49b9ae90b9f6def399b45b27aec264342a3a460722cbb38d633d373e917",
  rmd = "de956ec7f84c37991494e87962317369d382674783d7af4de648c56be1cd0b66",
  pdf = "6ff930e1a3d3ba11a0b9630149a42a23bdb1ef204b71ece7e17f5ece62594126",
  html = "0867d1cde8bceebcf57bc414a8e9ddb600f1a4d3e847c2bb3b6f7a423472ad44",
  tex = "9a5b27196d956bc95d99e5645956559bd2e1e6877ada03291819f2e19604c6bd",
  master_verifier = "3d4537dd9042d3237f7a315473cb1a3cef154dae8901a9978f9ed640e0a16864",
  master_checks = "1b947c5049b3262f0802ef635be38f7ce6a95689207349edec8ad79e6a366da1",
  candidate_status = "05be9fbcc3ed0d12f53a142e282113d495a781b4c76c11faf2b874fcede98c3d",
  visual_audit = "f448d595e55986aea21eb00345dd55105c145476c68816f9f3d740f45afb0e5c",
  review_report = "eaedf4d0782cc9e2df7c2bb3e848ece46bb2275a9c8fe2f2761c914e40abd8d9",
  freeze_status = "955be0581ac176d1e49b8b1d16b9583818fd15be68186590f1540812ef6be451",
  protected_manifest = "e6c2dcaea628acf84ea77853448b185b189e24d7b809e540e442fd820b0d6d6c",
  dag = "4b7aa1b9647791b7e2b3a62fd21c1b782982eca40d44414c8e23f88140b166c0",
  ledger = "23d0566aa55aeac74b43819d907c9022ed02e065210694d26dda7b13283c1750",
  rejected_release = "a930d5114c4ee8e38e2585cb4ccd49b630822bac78a651cb81731ce5aae4b215",
  rejected_pdf = "43e0023e93734797dea8cc451fca311cac77e8ebbbb9fb82f92054545a2e4499"
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

run_command <- function(command, args) {
  out <- suppressWarnings(system2(command, args, stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = paste(out, collapse = "\n"))
}

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

zero_review <- function(x, reviewer_id) {
  identical(x$reviewer_id, reviewer_id) &&
    identical(x$mode, "independent and read-only") &&
    identical(x$reviewed_release_sha256, expected[["release"]]) &&
    identical(x$verdict, "pass") &&
    identical(as.integer(x$critical_findings), 0L) &&
    identical(as.integer(x$major_findings), 0L) &&
    identical(as.integer(x$minor_findings), 0L)
}

review_contract_valid <- function(review) {
  formal <- review$required_final_reviews$formal_model_and_integration
  adversarial <- review$required_final_reviews$adversarial_game_theory_reproducibility_and_visual
  visual <- review$supplemental_visual_rereview
  rejected <- review$rejected_release_history[[1L]]
  identical(review$artifact_id, "pivotal-response-full-chain-review-v1") &&
    identical(review$state_id, "pivotal_response_full_chain_release_review") &&
    identical(review$status, "pass") &&
    identical(review$migration_authority,
              "none; this bundle does not authorize edits to formal_model_v5.Rmd, formal_model_v6.Rmd, their outputs, or any frozen analytic interface") &&
    identical(review$reviewed_release$sha256, expected[["release"]]) &&
    identical(review$reviewed_release$immutable_status, "candidate_pending_final_read_only_reviews") &&
    identical(review$reviewed_release$consumer_status_after_this_review, "pass") &&
    identical(as.integer(review$required_final_reviews$count), 2L) &&
    zero_review(formal, "gate0_reviewer") &&
    zero_review(adversarial, "full_chain_adversarial") &&
    identical(visual$mode, "independent, read-only presentation rereview") &&
    identical(visual$reviewed_release_sha256, expected[["release"]]) &&
    identical(visual$reviewed_pdf_sha256, expected[["pdf"]]) &&
    identical(as.integer(visual$pages_inspected), 60L) &&
    identical(as.integer(visual$pages_total), 60L) &&
    identical(visual$page_57_repair_confirmed, TRUE) &&
    identical(visual$verdict, "pass") &&
    all(vapply(c("critical_findings", "major_findings", "minor_findings", "rendered_stale_markers",
                 "rendered_forbidden_markers", "missing_glyph_markers"),
               function(field) identical(as.integer(visual[[field]]), 0L), logical(1))) &&
    identical(rejected$release_sha256, expected[["rejected_release"]]) &&
    identical(rejected$pdf_sha256, expected[["rejected_pdf"]]) &&
    identical(rejected$verdict, "repair") &&
    identical(as.integer(rejected$critical_findings), 0L) &&
    identical(as.integer(rejected$major_findings), 1L) &&
    identical(as.integer(rejected$minor_findings), 0L) &&
    grepl("page 57", tolower(rejected$finding), fixed = TRUE) &&
    identical(rejected$repaired_by_release_sha256, expected[["release"]]) &&
    identical(review$mechanical_close$master_verifier_result, "25/25 PASS") &&
    identical(review$mechanical_close$master_check_snapshot, "25/25 PASS") &&
    identical(review$mechanical_close$protected_artifacts, "27/27 PASS") &&
    identical(review$mechanical_close$game_dag_checker, "VALID") &&
    identical(review$mechanical_close$game_dag_ready, list())
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

dag_valid <- function(dag) {
  nodes <- node_map(dag)
  length(nodes) == 12L && all(vapply(nodes, function(x) identical(x$status, "pass"), logical(1))) &&
    identical(ready_nodes(dag), character()) && dependency_links_valid(dag) &&
    max(vapply(nodes, function(x) as.integer(x$passed_order), integer(1)), na.rm = TRUE) == 67L
}

protected_valid <- function(tab) {
  identical(names(tab), c("path", "sha256", "category", "frozen_at_head")) &&
    nrow(tab) == 27L && all(file.exists(tab$path)) &&
    all(vapply(tab$path, sha256_file, character(1)) == tab$sha256)
}

review <- jsonlite::fromJSON(review_bundle_path, simplifyVector = FALSE)
release <- jsonlite::fromJSON(release_path, simplifyVector = FALSE)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
master_checks <- utils::read.csv(master_checks_path, check.names = FALSE, na.strings = character())
review_text <- paste(readLines(review_report_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
freeze_text <- paste(readLines(freeze_status_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")

add_check(
  "review_bundle_identity_and_hash",
  review_contract_valid(review) && identical(sha256_file(review_bundle_path), expected[["review_bundle"]]),
  paste("Final review bundle is PASS at exact SHA-256", expected[["review_bundle"]]),
  "Review-bundle identity, exact hash, verdicts, visual close, rejected history, or nonmigration rule differs."
)

add_check(
  "reviewed_release_exact_and_immutable",
  identical(sha256_file(release_path), expected[["release"]]) &&
    identical(release$status, "candidate_pending_final_read_only_reviews") &&
    identical(review$reviewed_release$sha256, expected[["release"]]),
  "The exact repaired candidate release remains immutable and is accepted by the separate review bundle.",
  "The candidate release bytes, immutable status, or reviewed digest differs."
)

roles <- vapply(review$components, function(x) x$role, character(1))
add_check(
  "dependency_complete_component_inventory",
  length(review$components) == 17L && length(unique(roles)) == 17L &&
    all(c("gate0_bundle", "r2_batch_review", "r1_batch_frozen", "entry_batch_review",
          "institutional_comparison_review", "v6_survival_matrix_review", "final_game_dag",
          "proof_ledger", "protected_hash_manifest", "integrated_rmd", "primary_pdf",
          "companion_html", "kept_tex", "master_verifier", "master_check_table",
          "candidate_status_snapshot", "candidate_visual_audit") %in% roles),
  "The bundle inventories all 17 direct analytic, governance, presentation, validation, status, and visual components.",
  paste("Unexpected component inventory:", paste(roles, collapse = ", "))
)

add_check(
  "all_component_hashes_exact",
  component_hashes_match(review_bundle_path, review$components),
  "All 17 direct component hashes match their exact bytes.",
  "At least one bundled component differs from its declared hash."
)

presentation_expected <- expected[c("rmd", "pdf", "html", "tex")]
presentation_paths <- c(
  rmd = "model_redesign/pivotal_response_rederivation.Rmd",
  pdf = "model_redesign/pivotal_response_rederivation.pdf",
  html = "model_redesign/pivotal_response_rederivation.html",
  tex = "model_redesign/pivotal_response_rederivation.tex"
)
add_check(
  "exact_presentation_bytes",
  identical(unname(vapply(presentation_paths, sha256_file, character(1))), unname(presentation_expected)),
  "Rmd, PDF, HTML, and TeX retain the exact repaired presentation bytes.",
  "At least one repaired presentation artifact changed."
)

add_check(
  "two_independent_zero_finding_reviews",
  zero_review(review$required_final_reviews$formal_model_and_integration, "gate0_reviewer") &&
    zero_review(review$required_final_reviews$adversarial_game_theory_reproducibility_and_visual,
                "full_chain_adversarial"),
  "Both required independent read-only reviews accepted the exact release with 0/0/0 findings.",
  "A required reviewer, exact hash, verdict, mode, or finding count differs."
)

visual <- review$supplemental_visual_rereview
add_check(
  "supplemental_visual_60_of_60",
  identical(visual$verdict, "pass") && identical(as.integer(visual$pages_inspected), 60L) &&
    identical(as.integer(visual$pages_total), 60L) && identical(visual$page_57_repair_confirmed, TRUE) &&
    identical(as.integer(visual$critical_findings), 0L) &&
    identical(as.integer(visual$major_findings), 0L) && identical(as.integer(visual$minor_findings), 0L),
  "Supplemental read-only visual rereview inspected 60/60 pages, confirmed page 57, and found 0/0/0 issues.",
  "The visual rereview verdict, page count, page-57 repair, or finding count differs."
)

rejected <- review$rejected_release_history[[1L]]
add_check(
  "rejected_release_history_and_repair_link",
  identical(rejected$release_sha256, expected[["rejected_release"]]) &&
    identical(rejected$pdf_sha256, expected[["rejected_pdf"]]) &&
    identical(rejected$verdict, "repair") && identical(as.integer(rejected$major_findings), 1L) &&
    grepl("18.1 and 18.1.1", rejected$finding, fixed = TRUE) &&
    identical(rejected$repaired_by_release_sha256, expected[["release"]]),
  "The rejected a930d511/43e0023e page-57 defect is preserved and linked to the repaired d06fe49b release.",
  "Rejected-release provenance, finding, counts, or repair link differs."
)

add_check(
  "master_verifier_and_accepted_exact_output",
  identical(sha256_file(master_verifier_path), expected[["master_verifier"]]) &&
    identical(sha256_file(master_checks_path), expected[["master_checks"]]) &&
    nrow(master_checks) == 25L && all(master_checks$status == "PASS"),
  "The immutable master verifier and accepted exact output snapshot establish 25/25 PASS without rewriting candidate bytes.",
  "The master verifier changed or its accepted exact output is not 25/25 PASS."
)

add_check(
  "master_check_snapshot_exact",
  identical(sha256_file(master_checks_path), expected[["master_checks"]]) &&
    nrow(master_checks) == 25L && all(master_checks$status == "PASS"),
  "The immutable master check snapshot remains 25/25 PASS.",
  "The master check table hash, row count, or status differs."
)

add_check(
  "candidate_status_and_visual_audit_exact",
  identical(sha256_file(candidate_status_path), expected[["candidate_status"]]) &&
    identical(sha256_file(visual_audit_path), expected[["visual_audit"]]),
  "Candidate status and visual-audit snapshots retain exact bytes.",
  "Candidate status or visual-audit snapshot changed."
)

add_check(
  "protected_manifest_and_27_artifacts",
  identical(sha256_file(protected_path), expected[["protected_manifest"]]) && protected_valid(protected),
  "The protected manifest and all 27 protected artifacts retain exact hashes.",
  "The protected manifest or at least one protected artifact changed."
)

add_check(
  "dag_exact_all_pass_ready_none",
  identical(sha256_file(dag_path), expected[["dag"]]) && dag_valid(dag),
  "The exact DAG retains all 12 game nodes PASS through order 67 with Ready: none.",
  "The DAG hash, node statuses, dependency links, execution order, or frontier differs."
)

dag_run <- run_command("python3", c(skill_checker, dag_path, "--require-execution-order"))
add_check(
  "solve_dynamic_games_dag_checker",
  dag_run$status == 0L && grepl("VALID", dag_run$output, fixed = TRUE) &&
    grepl("Ready: none", dag_run$output, fixed = TRUE),
  "solve-dynamic-games reports VALID and Ready: none under execution-order audit.",
  paste("DAG checker failed:", dag_run$output)
)

add_check(
  "proof_ledger_exact_and_unchanged",
  identical(sha256_file(ledger_path), expected[["ledger"]]),
  "The analytic proof ledger retains its exact order-67 close bytes.",
  "The proof ledger changed during the post-DAG presentation freeze."
)

add_check(
  "independent_review_report_exact",
  identical(sha256_file(review_report_path), expected[["review_report"]]) &&
    grepl("Overall verdict:** **PASS", review_text, fixed = TRUE) &&
    grepl("0` critical, `0` major, `0` minor", review_text, fixed = TRUE) &&
    grepl("60/60", review_text, fixed = TRUE) && grepl("Ready: none", review_text, fixed = TRUE),
  "Independent-review report records exact-hash PASS, 0/0/0 findings, 60/60 pages, and an empty frontier.",
  "The review-report hash or closure language differs."
)

add_check(
  "freeze_status_exact_and_nonmigrating",
  identical(sha256_file(freeze_status_path), expected[["freeze_status"]]) &&
    grepl("Overall status:** **PASS", freeze_text, fixed = TRUE) &&
    grepl("Master verifier: 25/25 PASS", freeze_text, fixed = TRUE) &&
    grepl("Protected artifacts: 27/27 PASS", freeze_text, fixed = TRUE) &&
    grepl("Ready: none", freeze_text, fixed = TRUE) &&
    grepl("does not\nauthorize manuscript migration", freeze_text, fixed = TRUE),
  "Final status records PASS, mechanical closure, Ready none, and the nonmigration boundary.",
  "The final-status hash, checks, DAG state, or migration boundary differs."
)

add_check(
  "release_nonmigration_consumer_contract",
  grepl("nonmigrating", review$consumer_contract$migration_boundary, fixed = TRUE) &&
    grepl("may not rederive", review$consumer_contract$analytic_boundary, fixed = TRUE) &&
    grepl("not a mutation", review$consumer_contract$authority, fixed = TRUE) &&
    identical(review$migration_authority,
              "none; this bundle does not authorize edits to formal_model_v5.Rmd, formal_model_v6.Rmd, their outputs, or any frozen analytic interface"),
  "The final consumer contract is exact-hash, analytic-preserving, and nonmigrating.",
  "The consumer authority, analytic boundary, or nonmigration rule differs."
)

mut_review_hash <- clone_record(review)
mut_review_hash$reviewed_release$sha256 <- paste(rep("0", 64L), collapse = "")
add_check(
  "negative_mutation_reviewed_release_hash",
  !review_contract_valid(mut_review_hash),
  "Negative mutation: changing the reviewed release hash invalidates final acceptance.",
  "A changed reviewed-release hash was not rejected."
)

mut_review_verdict <- clone_record(review)
mut_review_verdict$required_final_reviews$adversarial_game_theory_reproducibility_and_visual$verdict <- "repair"
add_check(
  "negative_mutation_reviewer_verdict",
  !review_contract_valid(mut_review_verdict),
  "Negative mutation: a non-PASS required review invalidates final acceptance.",
  "A non-PASS required review was not rejected."
)

mut_review_findings <- clone_record(review)
mut_review_findings$required_final_reviews$formal_model_and_integration$major_findings <- 1L
add_check(
  "negative_mutation_reviewer_findings",
  !review_contract_valid(mut_review_findings),
  "Negative mutation: a nonzero required-review finding count invalidates final acceptance.",
  "A nonzero required-review finding count was not rejected."
)

mut_component <- clone_record(review)
mut_component$components[[11L]]$sha256 <- paste(rep("f", 64L), collapse = "")
add_check(
  "negative_mutation_component_hash",
  !component_hashes_match(review_bundle_path, mut_component$components),
  "Negative mutation: changing the repaired PDF component hash breaks dependency closure.",
  "A changed component hash was not rejected."
)

mut_rejected <- clone_record(review)
mut_rejected$reviewed_release$sha256 <- expected[["rejected_release"]]
add_check(
  "negative_mutation_rejected_release_substitution",
  !review_contract_valid(mut_rejected),
  "Negative mutation: substituting the rejected a930d511 release invalidates the close.",
  "The rejected release was accepted as the repaired release."
)

mut_visual <- clone_record(review)
mut_visual$supplemental_visual_rereview$page_57_repair_confirmed <- FALSE
add_check(
  "negative_mutation_visual_repair",
  !review_contract_valid(mut_visual),
  "Negative mutation: losing page-57 repair confirmation invalidates the visual close.",
  "Missing page-57 repair confirmation was not rejected."
)

mut_dag <- clone_record(dag)
mut_nodes <- node_map(mut_dag)
mut_nodes[["v6_survival_matrix"]]$status <- "pending"
mut_dag$nodes <- unname(mut_nodes)
add_check(
  "negative_mutation_dag_reopen",
  !dag_valid(mut_dag),
  "Negative mutation: reopening a game-DAG node invalidates final release closure.",
  "A reopened game-DAG node was not rejected."
)

mut_protected <- clone_record(protected)
mut_protected$sha256[[1L]] <- paste(rep("b", 64L), collapse = "")
add_check(
  "negative_mutation_protected_hash",
  !protected_valid(mut_protected),
  "Negative mutation: changing a protected hash invalidates final release closure.",
  "A changed protected hash was not rejected."
)

mut_migration <- clone_record(review)
mut_migration$migration_authority <- "authorized"
add_check(
  "negative_mutation_migration_authority",
  !review_contract_valid(mut_migration),
  "Negative mutation: granting manuscript migration authority invalidates this nonmigrating close.",
  "Unauthorized migration authority was not rejected."
)

utils::write.csv(checks, freeze_checks_path, row.names = FALSE, na = "")
n_fail <- sum(checks$status != "PASS")
cat(sprintf("Full-chain freeze verification: %d/%d PASS\n", nrow(checks) - n_fail, nrow(checks)))
cat("Master verifier: 25/25 PASS.\n")
cat("Protected artifacts: 27/27 PASS.\n")
cat("Game DAG: VALID; all nodes PASS; Ready: none.\n")
if (n_fail) {
  print(checks[checks$status != "PASS", , drop = FALSE])
  quit(status = 1L)
}
