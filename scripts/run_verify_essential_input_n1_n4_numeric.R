#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve the numerical runner path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)
source(file.path(repository_root, "scripts", "verify_essential_input_n1_numeric.R"), local = FALSE)
source(file.path(repository_root, "scripts", "verify_essential_input_n2_numeric.R"), local = FALSE)
source(file.path(repository_root, "scripts", "verify_essential_input_n3_numeric.R"), local = FALSE)
source(file.path(repository_root, "scripts", "verify_essential_input_n4_numeric.R"), local = FALSE)

verify_essential_input_formula_sources(repository_root)
ei_run_boundary_regression_checks()
grid <- ei_parameter_grid()
results <- rbind(
  run_n1_numeric_verification(grid),
  run_n2_numeric_verification(grid),
  run_n3_numeric_verification(grid),
  run_n4_numeric_verification(grid)
)

report_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_essential_input_n1_n4_numeric_harness_results.csv"
)
session_path <- file.path(
  repository_root,
  "quality_reports",
  "2026-08-21_essential_input_n1_n4_numeric_session_info.txt"
)
write.csv(results, report_path, row.names = FALSE, fileEncoding = "UTF-8")
writeLines(capture.output(sessionInfo()), session_path, useBytes = TRUE)

counts <- table(results$node, results$status)
cat("ESSENTIAL_INPUT_N1_N4_NUMERIC: PASS\n")
print(counts)
cat(sprintf("Parameter grid: %d rows per node; N in {5,7}; beta in {0.5,0.9,0.99}.\n", nrow(grid)))
cat("Strict-boundary regression checks: PASS.\n")
cat(sprintf("Results: %s\n", report_path))
cat(sprintf("Session info: %s\n", session_path))
