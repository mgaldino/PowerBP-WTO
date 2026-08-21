#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) {
  stop("Could not resolve the numerical boundary verifier path.", call. = FALSE)
}
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)

source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

verify_essential_input_formula_sources(repository_root)
ei_run_boundary_regression_checks()
cat("ESSENTIAL_INPUT_NUMERIC_BOUNDARIES: PASS — strict endpoints, cutoffs, and Bayes support.\n")
