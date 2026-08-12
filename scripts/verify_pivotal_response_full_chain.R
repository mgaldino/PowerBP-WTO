#!/usr/bin/env Rscript

options(stringsAsFactors = FALSE, warn = 1)

git_root <- system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE, stderr = TRUE)
git_status <- attr(git_root, "status")
if (is.null(git_status)) git_status <- 0L
if (!length(git_root) || git_status != 0L) stop("Could not resolve Git root.")
repo_root <- normalizePath(git_root[[1L]], mustWork = TRUE)
setwd(repo_root)
if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Package jsonlite is required.")

release_path <- "model_redesign/pivotal_response_interfaces/pivotal_response_full_chain_release_v1.json"
checks_path <- "tables/pivotal_response_full_chain_checks_v1.csv"
skill_checker <- "/Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py"
expected_release_sha256 <- "d06fe49b9ae90b9f6def399b45b27aec264342a3a460722cbb38d633d373e917"

required_tools <- c("shasum", "pdfinfo", "pdftotext", "pdftoppm", "xelatex", "python3")
missing_tools <- required_tools[!nzchar(Sys.which(required_tools))]
if (length(missing_tools)) stop("Missing required command-line tools: ", paste(missing_tools, collapse = ", "))
if (!file.exists(release_path)) stop("Missing full-chain release candidate: ", release_path)
if (!file.exists(skill_checker)) stop("Missing solve-dynamic-games DAG checker: ", skill_checker)

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

run_command <- function(command, args) {
  out <- suppressWarnings(system2(command, args, stdout = TRUE, stderr = TRUE))
  status <- attr(out, "status")
  if (is.null(status)) status <- 0L
  list(status = as.integer(status), output = paste(out, collapse = "\n"))
}

resolve_from_release <- function(relative_path) {
  normalizePath(file.path(dirname(normalizePath(release_path, mustWork = TRUE)), relative_path), mustWork = TRUE)
}

records_exact <- function(records) {
  all(vapply(records, function(x) {
    path <- tryCatch(resolve_from_release(x$path), error = function(e) NA_character_)
    !is.na(path) && identical(sha256_file(path), x$sha256)
  }, logical(1)))
}

normalized_text <- function(path) {
  x <- paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  gsub("[[:space:]]+", " ", x)
}

all_markers_present <- function(text, markers) {
  all(vapply(markers, function(marker) grepl(marker, text, fixed = TRUE), logical(1)))
}

no_markers_present <- function(text, markers) {
  !any(vapply(markers, function(marker) grepl(marker, text, fixed = TRUE), logical(1)))
}

release <- jsonlite::fromJSON(release_path, simplifyVector = FALSE)

add_check(
  "provenance_git_root",
  identical(repo_root, "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion"),
  paste("Git root:", repo_root),
  paste("Unexpected Git root:", repo_root)
)

add_check(
  "release_identity_status_and_scope",
  identical(release$schema_version, "1.0.0") &&
    identical(release$artifact_id, "pivotal-response-full-chain-release-v1") &&
    identical(release$status, "candidate_pending_final_read_only_reviews") &&
    grepl("presentation layer only", release$scope, fixed = TRUE) &&
    identical(release$migration_authority,
              "none; this release does not authorize edits to formal_model_v5.Rmd, formal_model_v6.Rmd, or their outputs"),
  "Release is an immutable, nonmigrating presentation-layer candidate pending two read-only reviews.",
  "Release identity, status, scope, or nonmigration authority differs."
)

add_check(
  "release_exact_hash",
  identical(sha256_file(release_path), expected_release_sha256),
  paste("Release candidate exact SHA-256:", expected_release_sha256),
  "Release-candidate bytes differ from the locked digest."
)

analytic_roles <- vapply(release$analytic_roots, function(x) x$role, character(1))
expected_analytic_roles <- c(
  "gate0_bundle", "r2_batch_review", "r1_batch_frozen", "entry_batch_review",
  "institutional_comparison_review", "v6_survival_matrix_review"
)
add_check(
  "analytic_root_inventory_and_hashes",
  identical(analytic_roles, expected_analytic_roles) && records_exact(release$analytic_roots),
  "Six dependency-complete analytic roots retain their frozen bytes.",
  paste("Analytic root inventory or hash mismatch:", paste(analytic_roles, collapse = ", "))
)

governance_roles <- vapply(release$governance_artifacts, function(x) x$role, character(1))
add_check(
  "governance_inventory_and_hashes",
  identical(governance_roles, c("final_game_dag", "proof_ledger", "protected_hash_manifest")) &&
    records_exact(release$governance_artifacts),
  "Final DAG, proof ledger, and protected manifest retain exact bytes.",
  "Governance inventory or hash differs."
)

presentation_roles <- vapply(release$presentation_artifacts, function(x) x$role, character(1))
presentation_paths <- vapply(release$presentation_artifacts, function(x) resolve_from_release(x$path), character(1))
presentation_sizes <- unname(file.info(presentation_paths)$size)
declared_sizes <- unname(vapply(release$presentation_artifacts, function(x) as.numeric(x$bytes), numeric(1)))
add_check(
  "presentation_inventory_hashes_and_sizes",
  identical(presentation_roles, c("integrated_source", "primary_pdf", "companion_html", "kept_latex_source")) &&
    records_exact(release$presentation_artifacts) && identical(presentation_sizes, declared_sizes),
  "Rmd, PDF, HTML, and kept TeX match all declared hashes and byte sizes.",
  "Presentation role, hash, or byte size differs."
)

add_check(
  "render_contract",
  identical(release$render$formats, list("bookdown::html_document2", "bookdown::pdf_document2")) &&
    identical(release$render$latex_engine, "xelatex") &&
    grepl("output_format = \"all\"", release$render$command, fixed = TRUE) &&
    grepl("frozen CSVs", release$render$source_of_truth, fixed = TRUE),
  "Render contract uses both bookdown formats, XeLaTeX, and frozen sources.",
  "Render formats, engine, command, or source-of-truth declaration differs."
)

check_tables <- list(
  gate0 = c("tables/pivotal_response_gate0_checks.csv", 69L),
  r2_batch = c("tables/pivotal_response_r2_batch_checks.csv", 30L),
  r1_batch = c("tables/pivotal_response_r1_batch_checks_v1.csv", 24L),
  entry_batch = c("tables/pivotal_response_entry_batch_checks_v1.csv", 27L),
  institutional_comparison = c("tables/pivotal_response_institutional_comparison_checks_v1.csv", 42L),
  institutional_comparison_freeze = c("tables/pivotal_response_institutional_comparison_freeze_checks_v1.csv", 26L),
  survival_matrix = c("tables/pivotal_response_v6_survival_matrix_checks_v1.csv", 43L),
  survival_matrix_freeze = c("tables/pivotal_response_v6_survival_matrix_freeze_checks_v1.csv", 24L)
)
expected_counts <- unlist(release$validation_contract$required_frozen_check_counts, use.names = TRUE)
expected_stage_sensitive_failures <- list(
  gate0 = c(
    "dag_r2_authorized_not_started", "skill_dag_execution_order",
    "skill_r2_candidate_antichain", "no_r2_interface_or_result",
    "proof_ledger_status_vocabulary", "proof_ledger_no_downstream_results"
  ),
  r1_batch = c("negative_barrier_before_freeze", "ready_after_freeze_exact")
)
table_results <- vapply(names(check_tables), function(id) {
  path <- check_tables[[id]][[1L]]
  expected <- as.integer(check_tables[[id]][[2L]])
  if (!file.exists(path)) return(FALSE)
  tab <- utils::read.csv(path, check.names = FALSE, na.strings = character())
  actual_failures <- sort(tab$check_id[tab$status == "FAIL"])
  permitted_failures <- expected_stage_sensitive_failures[[id]]
  if (is.null(permitted_failures)) permitted_failures <- character()
  permitted_failures <- sort(permitted_failures)
  identical(expected, as.integer(expected_counts[[id]])) && nrow(tab) == expected &&
    "status" %in% names(tab) && all(tab$status %in% c("PASS", "FAIL")) &&
    identical(actual_failures, permitted_failures)
}, logical(1))
add_check(
  "eight_recorded_check_tables",
  all(table_results),
  paste("Eight check tables have their declared row counts; only the exact Gate-0/R1 stage-sensitive guards are now false after authorized descendants closed:",
        paste(names(check_tables), unlist(lapply(check_tables, `[[`, 2L)), sep = "=", collapse = "; ")),
  paste("Check-table row count or expected stage-sensitive status mismatch:", paste(names(table_results)[!table_results], collapse = ", "))
)

dag_path <- resolve_from_release(release$governance_artifacts[[1L]]$path)
dag <- jsonlite::fromJSON(dag_path, simplifyVector = FALSE)
node_statuses <- vapply(dag$nodes, function(x) x$status, character(1))
node_orders <- vapply(dag$nodes, function(x) as.integer(x$passed_order), integer(1))
add_check(
  "dag_all_nodes_pass",
  length(dag$nodes) == 12L && all(node_statuses == "pass") &&
    all(!is.na(node_orders)) && max(node_orders) == 67L,
  "All 12 DAG nodes are PASS through order 67.",
  paste("Unexpected DAG states:", paste(vapply(dag$nodes, function(x) paste0(x$id, "=", x$status), character(1)), collapse = ", "))
)

dag_run <- run_command("python3", c(skill_checker, dag_path, "--require-execution-order"))
add_check(
  "skill_dag_checker",
  dag_run$status == 0L && grepl("VALID", dag_run$output, fixed = TRUE) &&
    grepl("Ready: none", dag_run$output, fixed = TRUE),
  "solve-dynamic-games checker reports VALID and Ready: none.",
  paste("DAG checker failed:", dag_run$output)
)

ledger_path <- resolve_from_release(release$governance_artifacts[[2L]]$path)
ledger <- utils::read.delim(ledger_path, check.names = FALSE, quote = "", comment.char = "")
final_ledger <- ledger[ledger$object == "v6 survival-matrix independent review and freeze", , drop = FALSE]
add_check(
  "proof_ledger_final_close",
  nrow(final_ledger) == 1L && identical(final_ledger$status, "proved") &&
    identical(as.integer(final_ledger$passed_order), 67L) &&
    grepl("80c912ba35fc46bdb1859edeb91402dcb63f52079cd3ca8c4aeeb4b98b0077a7",
          final_ledger$evidence, fixed = TRUE),
  "Proof ledger closes the survival freeze as proved at order 67.",
  "Proof-ledger close row, status, order, or evidence differs."
)

protected_path <- resolve_from_release(release$governance_artifacts[[3L]]$path)
protected <- utils::read.delim(protected_path, check.names = FALSE, quote = "", comment.char = "")
protected_ok <- nrow(protected) == 27L &&
  identical(names(protected), c("path", "sha256", "category", "frozen_at_head")) &&
  all(file.exists(protected$path)) &&
  all(vapply(protected$path, sha256_file, character(1)) == protected$sha256)
add_check(
  "protected_artifacts_exact",
  protected_ok,
  "All 27 protected artifacts remain byte-identical.",
  "Protected manifest shape or at least one protected hash differs."
)

v6_row <- protected[protected$path == "formal_model_v6.Rmd", , drop = FALSE]
add_check(
  "target_manuscript_untouched",
  nrow(v6_row) == 1L && identical(v6_row$sha256, "131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d") &&
    identical(sha256_file("formal_model_v6.Rmd"), v6_row$sha256),
  "formal_model_v6.Rmd remains untouched at its protected SHA-256.",
  "formal_model_v6.Rmd differs from its protected bytes."
)

rmd_path <- presentation_paths[[which(presentation_roles == "integrated_source")]]
rmd_text <- normalized_text(rmd_path)
required_node_paths <- c(
  "pivotal_response_nodes/r2_unanimity_active_h_v1.md",
  "pivotal_response_nodes/r2_majority_active_h_v1.md",
  "pivotal_response_nodes/r2_majority_weak_only_v1.md",
  "pivotal_response_nodes/r1_unanimity_v1.md",
  "pivotal_response_nodes/r1_majority_v1.md",
  "pivotal_response_nodes/entry_unanimity_v1.md",
  "pivotal_response_nodes/entry_majority_v1.md",
  "pivotal_response_nodes/institutional_comparison_v1.md",
  "pivotal_response_nodes/v6_survival_matrix_v1.md"
)
add_check(
  "integrated_source_imports_all_frozen_notes",
  all_markers_present(rmd_text, required_node_paths) &&
    all_markers_present(rmd_text, release$validation_contract$required_pdf_sections) &&
    !grepl("STOP_BEFORE_R2", rmd_text, fixed = TRUE),
  "Integrated source imports all nine frozen node notes and all required sections.",
  "Integrated source omits a frozen note or required section, or retains the old stop boundary."
)

pdf_path <- presentation_paths[[which(presentation_roles == "primary_pdf")]]
pdf_info <- run_command("pdfinfo", pdf_path)
pdf_pages_match <- grepl(paste0("Pages:[[:space:]]+", release$presentation_artifacts[[2L]]$pages, "([[:space:]]|$)"), pdf_info$output)
add_check(
  "pdf_metadata_and_page_count",
  pdf_info$status == 0L && pdf_pages_match && grepl("PDF version:", pdf_info$output, fixed = TRUE),
  paste("Primary PDF opens and has", release$presentation_artifacts[[2L]]$pages, "pages."),
  paste("PDF metadata/page check failed:", pdf_info$output)
)

pdf_text_path <- tempfile(fileext = ".txt")
pdf_text_run <- run_command("pdftotext", c(pdf_path, pdf_text_path))
pdf_text <- if (pdf_text_run$status == 0L && file.exists(pdf_text_path)) normalized_text(pdf_text_path) else ""
add_check(
  "pdf_required_sections",
  pdf_text_run$status == 0L && all_markers_present(pdf_text, release$validation_contract$required_pdf_sections),
  "Extracted PDF text contains every required analytic section.",
  "PDF text extraction failed or at least one required analytic section is absent."
)

add_check(
  "pdf_forbidden_markers_absent",
  no_markers_present(pdf_text, release$validation_contract$forbidden_rendered_markers),
  "Extracted PDF text contains no stale status, prohibited refinement, or roll-call marker.",
  "Extracted PDF text contains a forbidden rendered marker."
)

html_path <- presentation_paths[[which(presentation_roles == "companion_html")]]
html_raw <- paste(readLines(html_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
html_text <- gsub("[[:space:]]+", " ", html_raw)
add_check(
  "html_structure_and_sections",
  grepl("<html", html_raw, fixed = TRUE) && grepl("</html>", html_raw, fixed = TRUE) &&
    grepl("Pivotal-Response Rederivation", html_text, fixed = TRUE) &&
    all_markers_present(html_text, release$validation_contract$required_pdf_sections),
  "Companion HTML is structurally complete and contains every required section.",
  "HTML structure, title, or required analytic section is absent."
)

add_check(
  "html_forbidden_markers_absent",
  no_markers_present(html_text, release$validation_contract$forbidden_rendered_markers),
  "Companion HTML contains no stale status, prohibited refinement, or roll-call marker.",
  "Companion HTML contains a forbidden rendered marker."
)

tex_path <- presentation_paths[[which(presentation_roles == "kept_latex_source")]]
tex_raw <- paste(readLines(tex_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
add_check(
  "kept_tex_structure",
  grepl("\\begin{document}", tex_raw, fixed = TRUE) && grepl("\\end{document}", tex_raw, fixed = TRUE) &&
    grepl("\\title{Pivotal-Response Rederivation}", tex_raw, fixed = TRUE),
  "Kept TeX is a complete XeLaTeX document with the expected title.",
  "Kept TeX lacks a document boundary or expected title."
)

texcheck_dir <- tempfile("pivotal_response_texcheck_")
dir.create(texcheck_dir, recursive = TRUE)
tex_args <- c("-interaction=nonstopmode", "-halt-on-error", paste0("-output-directory=", texcheck_dir), tex_path)
tex_run_1 <- run_command("xelatex", tex_args)
tex_run_2 <- run_command("xelatex", tex_args)
tex_log_path <- file.path(texcheck_dir, "pivotal_response_rederivation.log")
tex_log <- if (file.exists(tex_log_path)) paste(readLines(tex_log_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n") else ""
tex_pdf_path <- file.path(texcheck_dir, "pivotal_response_rederivation.pdf")
add_check(
  "clean_two_pass_xelatex",
  tex_run_1$status == 0L && tex_run_2$status == 0L && file.exists(tex_pdf_path) && file.info(tex_pdf_path)$size > 100000,
  "Kept TeX compiles cleanly twice in an isolated temporary directory.",
  paste("Isolated XeLaTeX failed:", tex_run_2$output)
)

tex_bad_markers <- c("Overfull \\hbox", "There were undefined references", "multiply defined", "Emergency stop", "Fatal error")
add_check(
  "latex_log_no_material_warning",
  nzchar(tex_log) && no_markers_present(tex_log, tex_bad_markers),
  "Final XeLaTeX log has no overfull hbox, undefined reference, duplicate-label, emergency-stop, or fatal marker.",
  "Final XeLaTeX log contains a material layout/reference/error marker."
)

raster_dir <- tempfile("pivotal_response_raster_")
dir.create(raster_dir, recursive = TRUE)
raster_prefix <- file.path(raster_dir, "page")
raster_run <- run_command("pdftoppm", c("-png", "-r", "72", pdf_path, raster_prefix))
raster_files <- list.files(raster_dir, pattern = "^page-[0-9]+\\.png$", full.names = TRUE)
raster_sizes <- if (length(raster_files)) file.info(raster_files)$size else numeric()
add_check(
  "all_pdf_pages_rasterize",
  raster_run$status == 0L && length(raster_files) == as.integer(release$presentation_artifacts[[2L]]$pages) &&
    all(raster_sizes > 1000),
  paste("All", length(raster_files), "PDF pages rasterize to nonempty PNG files."),
  paste("Rasterization failed or page count differed; files:", length(raster_files))
)

add_check(
  "review_contract_still_pending_exact_bytes",
  identical(as.integer(release$review_contract$required_reviews), 2L) &&
    identical(release$review_contract$formal_model_review, "pending") &&
    identical(release$review_contract$adversarial_game_theory_and_reproducibility_review, "pending") &&
    identical(release$review_contract$reviewers_must_be_read_only, TRUE) &&
    grepl("both reviews accept this exact JSON", release$review_contract$consumer_rule, fixed = TRUE),
  "Release correctly remains nonconsumable until two read-only reviews accept these exact bytes.",
  "Final-review count, pending state, read-only rule, or consumer rule differs."
)

add_check(
  "invalidation_rule_complete",
  all_markers_present(release$invalidation, c("analytic root", "governance artifact", "presentation artifact", "protected target", "release candidate")),
  "Release invalidates final review after any protected or declared byte change.",
  "Release invalidation rule is incomplete."
)

dir.create(dirname(checks_path), recursive = TRUE, showWarnings = FALSE)
utils::write.csv(checks, checks_path, row.names = FALSE, na = "")

n_pass <- sum(checks$status == "PASS")
n_total <- nrow(checks)
cat(sprintf("Full-chain release verification: %d/%d PASS\n", n_pass, n_total))
for (i in seq_len(n_total)) {
  cat(sprintf("[%s] %s: %s\n", checks$status[[i]], checks$check_id[[i]], checks$detail[[i]]))
}
if (n_pass != n_total) quit(save = "no", status = 1L)
