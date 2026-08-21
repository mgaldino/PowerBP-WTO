#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(script_argument) == 1L) {
  normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
} else {
  normalizePath("scripts/verify_essential_input_n1_numeric.R", mustWork = TRUE)
}
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

run_n1_numeric_verification <- function(grid = ei_parameter_grid()) {
  verify_essential_input_formula_sources(repository_root)
  rows <- vector("list", nrow(grid))
  for (index in seq_len(nrow(grid))) {
    p <- grid[index, , drop = FALSE]
    closed <- n1_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)
    solved <- ei_n1_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu)
    label <- sprintf("N1 row %d", index)
    ei_assert_set_equal(solved$class, closed$class, paste(label, "class"))
    ei_assert_close(solved$y, closed$y, paste(label, "offer"))
    ei_assert_close(
      solved$recognized_proposer_payoff,
      closed$recognized_proposer_payoff,
      paste(label, "recognized proposer payoff")
    )
    ei_assert_close(
      solved$weak_pre_recognition_value,
      closed$weak_pre_recognition_value,
      paste(label, "weak pre-recognition value")
    )
    ei_assert_close(solved$hegemon_payoff, closed$hegemon_payoff, paste(label, "H payoff"))
    ei_assert_close(solved$outcome, closed$outcome, paste(label, "outcome"))
    rows[[index]] <- data.frame(
      node = "N1", status = "PASS", N = p$N, pair_id = p$pair_id,
      o_0 = p$o_0, o_1 = p$o_1, beta = p$beta, nu = p$nu,
      cell_id = closed$cell_id, selected_class = closed$class,
      proposer_payoff = closed$recognized_proposer_payoff,
      H_theta_0 = closed$hegemon_payoff[[1L]], H_theta_1 = closed$hegemon_payoff[[2L]],
      stringsAsFactors = FALSE
    )
  }
  do.call(rbind, rows)
}

if (ei_is_direct_script("verify_essential_input_n1_numeric.R")) {
  result <- run_n1_numeric_verification()
  cat(sprintf("N1_NUMERIC: PASS — %d parameter-grid rows; unique terminal outcome verified.\n", nrow(result)))
}
