#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(script_argument) == 1L) {
  normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
} else {
  normalizePath("scripts/verify_essential_input_n3_numeric.R", mustWork = TRUE)
}
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

run_n3_numeric_verification <- function(grid = ei_parameter_grid()) {
  verify_essential_input_formula_sources(repository_root)
  rows <- vector("list", nrow(grid))
  for (index in seq_len(nrow(grid))) {
    p <- grid[index, , drop = FALSE]
    closed <- n3_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)
    solved <- ei_n3_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu)
    label <- sprintf("N3 row %d", index)
    ei_assert_set_equal(solved$class, closed$selected_classes, paste(label, "selected classes"))
    ei_assert_close(
      solved$proposer_payoff,
      rep(closed$proposer_payoff, nrow(solved)),
      paste(label, "recognized proposer payoff")
    )
    for (selected_class in closed$selected_classes) {
      primitive_row <- solved[solved$class == selected_class, , drop = FALSE]
      formula_row <- closed$selected_table[
        closed$selected_table$class == selected_class, , drop = FALSE
      ]
      ei_assert_true(nrow(primitive_row) == 1L, paste(label, selected_class, "primitive row count"))
      ei_assert_true(nrow(formula_row) == 1L, paste(label, selected_class, "formula row count"))
      ei_assert_close(
        c(primitive_row$H_theta_0, primitive_row$H_theta_1),
        c(formula_row$H_theta_0, formula_row$H_theta_1),
        paste(label, selected_class, "H payoff")
      )
      ei_assert_close(
        c(primitive_row$pass_with_H, primitive_row$pass_without_H,
          primitive_row$failure, primitive_row$delay),
        c(formula_row$pass_with_H, formula_row$pass_without_H,
          formula_row$failure, formula_row$delay),
        paste(label, selected_class, "outcome")
      )
    }
    ei_assert_true(
      closed$strict_exclusion_gain_over_rejection > 0,
      paste(label, "must have E>R under beta<1.")
    )
    rows[[index]] <- data.frame(
      node = "N3", status = "PASS", N = p$N, pair_id = p$pair_id,
      o_0 = p$o_0, o_1 = p$o_1, beta = p$beta, nu = p$nu,
      cell_id = closed$cell_id,
      selected_class = paste(closed$selected_classes, collapse = "+"),
      proposer_payoff = closed$proposer_payoff,
      H_theta_0 = if (length(closed$selected_classes) == 1L) closed$selected_table$H_theta_0 else NA_real_,
      H_theta_1 = if (length(closed$selected_classes) == 1L) closed$selected_table$H_theta_1 else NA_real_,
      stringsAsFactors = FALSE
    )
  }
  result <- do.call(rbind, rows)
  expected_cells <- sprintf("N3-C%02d", 1:11)
  observed_prefixes <- substr(result$cell_id, 1, 6)
  ei_assert_set_equal(observed_prefixes, expected_cells, "N3 eleven-cell coverage")
  result
}

if (ei_is_direct_script("verify_essential_input_n3_numeric.R")) {
  result <- run_n3_numeric_verification()
  cat(sprintf("N3_NUMERIC: PASS — %d rows; all eleven cells, nu_SE, nu_SP, E/S/P payoffs, and knife-edge tie-breaks verified.\n", nrow(result)))
}
