#!/usr/bin/env Rscript

options(warn = 1)

started_at <- Sys.time()
script_name <- "scripts/verify_clean_optout_goal2_migration.R"
rmd_path <- "formal_model_v6.Rmd"
pdf_path <- "formal_model_v6.pdf"
bib_path <- "references.bib"
history_path <- "tables/clean_optout_gate0_histories_piH0.tsv"
output_path <- "tables/clean_optout_goal2_migration_checks.csv"
log_path <- "quality_reports/logs/verify_clean_optout_goal2_migration.log"

required_files <- c(rmd_path, pdf_path, bib_path, history_path)
if (!all(file.exists(required_files))) {
  stop(
    "Run this script from the repository root after compiling formal_model_v6.Rmd.",
    call. = FALSE
  )
}

checks <- data.frame(
  check_id = character(),
  passed = logical(),
  detail = character(),
  stringsAsFactors = FALSE
)

add_check <- function(check_id, passed, detail) {
  checks <<- rbind(
    checks,
    data.frame(
      check_id = check_id,
      passed = isTRUE(passed),
      detail = as.character(detail),
      stringsAsFactors = FALSE
    )
  )
}

rmd_lines <- readLines(rmd_path, warn = FALSE, encoding = "UTF-8")
rmd_text <- paste(rmd_lines, collapse = "\n")
bib_lines <- readLines(bib_path, warn = FALSE, encoding = "UTF-8")
bib_text <- paste(bib_lines, collapse = "\n")

contains_fixed <- function(pattern) {
  grepl(pattern, rmd_text, fixed = TRUE)
}

absent_fixed <- function(pattern) {
  !contains_fixed(pattern)
}

required_source_patterns <- c(
  "\\pi_H=0",
  "b_0=b_1=0",
  "immediate and irreversible",
  "weak-vote-passive assessment",
  "\\beta o_1\\geq o_0",
  "G_P>G_L",
  "F_M=\\max\\{E,B_M,P\\}",
  "\\mathcal F_U\\subseteq\\mathcal F_M",
  "\\bar o\\leq E[u_H^M]\\leq o_1=E[u_H^U]",
  "common PBE domain"
)
required_present <- vapply(
  required_source_patterns,
  contains_fixed,
  logical(1)
)
add_check(
  "required_clean_architecture_present",
  all(required_present),
  paste(
    required_source_patterns,
    ifelse(required_present, "present", "MISSING"),
    collapse = " | "
  )
)

forbidden_source_patterns <- c(
  "t_0",
  "t_1",
  "t_\\theta",
  "a_0(1)",
  "a_0^M",
  "a_1^M",
  "\\Delta_H",
  "lem:weak-caused-nonpivotal",
  "lem:rejected-histories",
  "relative_package_no_cheap_H_region_piH0.pdf",
  "relative_package_R1_candidate_regions_piH0.pdf",
  "relative_package_phase_diagram_piH0.pdf",
  "relative_package_region_sweep_summary_piH0.csv",
  "relative_package_complete_info_benchmark_piH0.csv",
  "0.315",
  "0.943"
)
forbidden_absent <- vapply(
  forbidden_source_patterns,
  absent_fixed,
  logical(1)
)
add_check(
  "legacy_architecture_not_promoted",
  all(forbidden_absent),
  paste(
    forbidden_source_patterns,
    ifelse(forbidden_absent, "absent", "FOUND"),
    collapse = " | "
  )
)

scope_only_patterns <- c(
  "\\beta C_\\theta",
  "\\max\\{o_\\theta,\\beta C_\\theta\\}",
  "C-B-R"
)
scope_lines <- grep(
  "Scope|beta C_|C-B-R|hybrid",
  rmd_lines,
  fixed = FALSE
)
scope_window <- unique(unlist(lapply(scope_lines, function(x) {
  seq(max(1L, x - 2L), min(length(rmd_lines), x + 2L))
})))
outside_scope_text <- paste(rmd_lines[-scope_window], collapse = "\n")
scope_only_ok <- vapply(
  scope_only_patterns,
  function(pattern) !grepl(pattern, outside_scope_text, fixed = TRUE),
  logical(1)
)
add_check(
  "excluded_extensions_only_in_scope_language",
  all(scope_only_ok),
  paste(
    scope_only_patterns,
    ifelse(scope_only_ok, "scope-only", "promoted elsewhere"),
    collapse = " | "
  )
)

required_labels <- c(
  "def:game",
  "def:passive",
  "fig:timing",
  "tab:result-scope",
  "lem:r2-unanimity",
  "prop:r2-majority",
  "lem:completion",
  "thm:u-regular",
  "prop:majority",
  "prop:nesting",
  "prop:h-comparison",
  "tab:majority-endpoint-limits",
  "tab:notation"
)
labels_present <- vapply(
  required_labels,
  function(x) contains_fixed(paste0("\\label{", x, "}")),
  logical(1)
)
add_check(
  "required_labels_present",
  all(labels_present),
  paste(
    required_labels,
    ifelse(labels_present, "present", "MISSING"),
    collapse = " | "
  )
)

label_matches <- gregexpr(
  "\\\\label\\{[^}]+\\}",
  rmd_text,
  perl = TRUE
)
labels <- regmatches(rmd_text, label_matches)[[1]]
add_check(
  "source_labels_unique",
  length(labels) == length(unique(labels)),
  sprintf("%d labels; %d unique", length(labels), length(unique(labels)))
)

figure_count <- sum(grepl("\\\\begin\\{figure\\}", rmd_lines))
figure_caption_count <- sum(grepl("\\\\caption\\{", rmd_lines)) -
  sum(grepl("^\\\\caption\\{Notation", rmd_lines))
table_environment_count <- sum(grepl("\\\\begin\\{table\\}", rmd_lines))
table_caption_count <- sum(grepl("^\\\\caption\\{", rmd_lines)) -
  figure_count
kable_caption_count <- sum(grepl("caption = ", rmd_lines, fixed = TRUE))
add_check(
  "figures_have_captions",
  figure_count == 1L && contains_fixed("\\label{fig:timing}"),
  sprintf("%d figure environment; timing label present", figure_count)
)
add_check(
  "tables_have_captions",
  table_environment_count >= 2L &&
    table_caption_count >= table_environment_count &&
    kable_caption_count == 4L,
  sprintf(
    "%d table environments; %d LaTeX captions; %d generated captions",
    table_environment_count,
    table_caption_count,
    kable_caption_count
  )
)

citation_matches <- gregexpr(
  "(?<![A-Za-z0-9._%+-])@[A-Za-z0-9_:-]+",
  rmd_text,
  perl = TRUE
)
citations <- unique(sub("^@", "", regmatches(rmd_text, citation_matches)[[1]]))
bib_matches <- gregexpr(
  "@[A-Za-z]+\\{[^,]+,",
  bib_text,
  perl = TRUE
)
bib_entries <- regmatches(bib_text, bib_matches)[[1]]
bib_keys <- sub("^@[A-Za-z]+\\{", "", sub(",$", "", bib_entries))
missing_citations <- setdiff(citations, bib_keys)
add_check(
  "citation_keys_resolve",
  length(missing_citations) == 0L,
  if (length(missing_citations) == 0L) {
    sprintf("%d cited keys found in references.bib", length(citations))
  } else {
    paste("missing:", paste(missing_citations, collapse = ", "))
  }
)

history <- utils::read.delim(
  history_path,
  check.names = FALSE,
  quote = "",
  comment.char = "",
  stringsAsFactors = FALSE
)
add_check(
  "history_contract_has_21_classes",
  nrow(history) == 21L &&
    identical(history$history_id, sprintf("G%02d", 1:21)),
  sprintf("%d rows; IDs %s", nrow(history), paste(history$history_id, collapse = ","))
)

pdftotext_bin <- Sys.which("pdftotext")
pdfinfo_bin <- Sys.which("pdfinfo")
add_check(
  "poppler_available",
  nzchar(pdftotext_bin) && nzchar(pdfinfo_bin),
  paste("pdftotext:", pdftotext_bin, "| pdfinfo:", pdfinfo_bin)
)

pdf_text <- if (nzchar(pdftotext_bin)) {
  paste(
    system2(pdftotext_bin, c(pdf_path, "-"), stdout = TRUE, stderr = FALSE),
    collapse = "\n"
  )
} else {
  ""
}

required_pdf_patterns <- c(
  "Clean immediate-opt-out game",
  "Regular unanimity existence and payoff",
  "Regular majority correspondence",
  "Entry nesting",
  "Hegemon payoff bounds",
  "Conditional Institutional Comparison"
)
required_pdf_present <- vapply(
  required_pdf_patterns,
  function(x) grepl(x, pdf_text, fixed = TRUE),
  logical(1)
)
add_check(
  "required_claims_render_in_pdf",
  all(required_pdf_present),
  paste(
    required_pdf_patterns,
    ifelse(required_pdf_present, "present", "MISSING"),
    collapse = " | "
  )
)

forbidden_pdf_patterns <- c(
  "0.315",
  "0.943",
  "Dynamic Acceptance",
  "Strict No-Cheap-H",
  "weak-caused-nonpivotal",
  "rejected-history reduction"
)
forbidden_pdf_absent <- vapply(
  forbidden_pdf_patterns,
  function(x) !grepl(x, pdf_text, fixed = TRUE),
  logical(1)
)
add_check(
  "legacy_claims_absent_from_pdf",
  all(forbidden_pdf_absent),
  paste(
    forbidden_pdf_patterns,
    ifelse(forbidden_pdf_absent, "absent", "FOUND"),
    collapse = " | "
  )
)

pdf_info <- if (nzchar(pdfinfo_bin)) {
  system2(pdfinfo_bin, pdf_path, stdout = TRUE, stderr = FALSE)
} else {
  character()
}
pages_line <- grep("^Pages:", pdf_info, value = TRUE)
page_size_line <- grep("^Page size:", pdf_info, value = TRUE)
pages <- suppressWarnings(as.integer(sub("^Pages:\\s*", "", pages_line)))
add_check(
  "pdf_metadata_valid",
  length(pages) == 1L && is.finite(pages) && pages > 0L &&
    length(page_size_line) == 1L,
  paste(pages_line, "|", page_size_line)
)

hash_output <- system2(
  "shasum",
  c("-a", "256", rmd_path, pdf_path),
  stdout = TRUE,
  stderr = FALSE
)
add_check(
  "sha256_recorded",
  length(hash_output) == 2L &&
    all(grepl("^[0-9a-f]{64}", hash_output)),
  paste(hash_output, collapse = " | ")
)

utils::write.csv(
  checks,
  output_path,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

passed_n <- sum(checks$passed)
total_n <- nrow(checks)
overall_pass <- passed_n == total_n
log_lines <- c(
  paste("script:", script_name),
  paste("started_at:", format(started_at, "%Y-%m-%dT%H:%M:%S%z")),
  paste("finished_at:", format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z")),
  paste("status:", if (overall_pass) "PASS" else "FAIL"),
  sprintf("checks: %d/%d PASS", passed_n, total_n),
  paste(checks$check_id, ifelse(checks$passed, "PASS", "FAIL"), checks$detail, sep = " | "),
  paste("sha256:", paste(hash_output, collapse = " | "))
)
writeLines(log_lines, log_path, useBytes = TRUE)

cat(sprintf(
  "%s: %d/%d PASS\n",
  script_name,
  passed_n,
  total_n
))

if (!overall_pass) {
  print(checks[!checks$passed, , drop = FALSE])
  quit(status = 1L)
}
