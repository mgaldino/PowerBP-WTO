#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) != 1L) stop("Could not resolve diagnostic path.", call. = FALSE)
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), "..", ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

grid <- ei_parameter_grid()
p <- grid[105, , drop = FALSE]
closed <- n3_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)
solved <- ei_n3_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu)
print(p, digits = 17)
print(closed$selected_table, digits = 17)
print(solved, digits = 17)
cat("Differences from closed-form maximum:\n")
print(solved$proposer_payoff - closed$proposer_payoff, digits = 17)
cat(sprintf("Maximum absolute difference: %.17g\n", max(abs(solved$proposer_payoff - closed$proposer_payoff))))
