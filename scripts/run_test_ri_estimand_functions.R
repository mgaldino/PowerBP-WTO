#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) stop("Could not resolve RI test runner path.", call. = FALSE)
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

if (!requireNamespace("testthat", quietly = TRUE)) {
  stop("Package 'testthat' is required for the RI unit tests.", call. = FALSE)
}
source(file.path(repository_root, "scripts", "ri_estimand_functions.R"), local = FALSE)
test_file <- file.path(repository_root, "tests", "testthat", "test-ri-estimand-functions.R")
result <- testthat::test_file(test_file, reporter = "summary", stop_on_failure = TRUE)

arguments <- commandArgs(trailingOnly = TRUE)
write_session <- !"--no-write-session" %in% arguments
if (write_session) {
  session_path <- file.path(
    repository_root,
    "quality_reports",
    "2026-08-21_ri_estimand_synthetic_tests_session_info.txt"
  )
  writeLines(capture.output(sessionInfo()), session_path, useBytes = TRUE)
}
cat("RI_ESTIMAND_SYNTHETIC_TESTS: PASS\n")
if (write_session) {
  cat(sprintf("Session info: %s\n", session_path))
} else {
  cat("Session info write skipped by --no-write-session.\n")
}
