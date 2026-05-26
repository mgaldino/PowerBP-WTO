#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = FALSE)
file_arg <- sub("^--file=", "", args[grep("^--file=", args)])
script_dir <- if (length(file_arg) > 0) {
  dirname(normalizePath(file_arg[1], winslash = "/", mustWork = TRUE))
} else {
  file.path(getwd(), "scripts")
}

source(file.path(script_dir, "verify_relative_package_margins_piH0.R"))
source(file.path(script_dir, "verify_relative_package_robustness_piH0.R"))
source(file.path(script_dir, "verify_relative_package_rho_majority_piH0.R"))
