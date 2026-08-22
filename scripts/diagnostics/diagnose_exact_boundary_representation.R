#!/usr/bin/env Rscript

source("scripts/essential_input_formulas.R")
source("scripts/essential_input_numeric_helpers.R")

grid <- ei_parameter_grid()
for (index in c(28L, 76L, 241L)) {
  p <- grid[index, , drop = FALSE]
  z <- essential_input_constants(p$N, p$o_0, p$o_1, p$beta, p$nu)
  cat(sprintf("row=%d\n", index))
  print(p, digits = 17)
  cat(sprintf("nu_star=%.17g; nu-nu_star=%.17g\n", z$nu_star, p$nu - z$nu_star))
  cat(sprintf(
    "nu_SE=%.17g; nu_SP=%.17g; nu_EP=%.17g\n",
    z$nu_SE, z$nu_SP, z$nu_EP
  ))
  cat("N2 solver:\n")
  print(ei_n2_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu), digits = 17)
  cat("N3 solver:\n")
  print(ei_n3_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu), digits = 17)
  cat(sprintf(
    "N3 closed cell=%s, classes=%s\n",
    n3_closed_form_cell(p$N, p$o_0, p$o_1, p$beta, p$nu),
    paste(n3_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)$selected_classes, collapse = "+")
  ))
}
