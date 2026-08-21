#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(script_argument) == 1L) {
  normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
} else {
  normalizePath("scripts/verify_essential_input_n2_numeric.R", mustWork = TRUE)
}
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

run_n2_numeric_verification <- function(grid = ei_parameter_grid()) {
  verify_essential_input_formula_sources(repository_root)
  rows <- vector("list", nrow(grid))
  for (index in seq_len(nrow(grid))) {
    p <- grid[index, , drop = FALSE]
    closed <- n2_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)
    solved <- ei_n2_primitive_solver(p$N, p$o_0, p$o_1, p$beta, p$nu)
    label <- sprintf("N2 row %d", index)
    ei_assert_true(nrow(solved) == 1L, paste(label, "must have one proposal after the H-payoff tie-break."))
    ei_assert_set_equal(solved$class, closed$class, paste(label, "class"))
    ei_assert_close(solved$y, closed$y, paste(label, "offer"))
    ei_assert_close(
      solved$proposer_payoff,
      closed$recognized_proposer_payoff,
      paste(label, "recognized proposer payoff")
    )
    ei_assert_close(
      c(solved$H_theta_0, solved$H_theta_1),
      closed$hegemon_payoff,
      paste(label, "H payoff")
    )
    ei_assert_close(
      c(pass_with_H = solved$pass_with_H, pass_without_H = 0,
        failure = solved$failure, delay = 0),
      closed$outcome,
      paste(label, "outcome")
    )

    endpoint_profile <- c("yes", "no")
    endpoint_posteriors <- ei_support_restricted_posterior_candidates(
      "no", endpoint_profile, p$nu, closed$nu_star
    )
    if (p$nu == 0) {
      ei_assert_close(endpoint_posteriors, 0, paste(label, "nu=0 support restriction"))
    }
    if (p$nu == 1) {
      ei_assert_close(endpoint_posteriors, 1, paste(label, "nu=1 support restriction"))
    }

    rows[[index]] <- data.frame(
      node = "N2", status = "PASS", N = p$N, pair_id = p$pair_id,
      o_0 = p$o_0, o_1 = p$o_1, beta = p$beta, nu = p$nu,
      cell_id = closed$cell_id, selected_class = closed$class,
      proposer_payoff = closed$recognized_proposer_payoff,
      H_theta_0 = closed$hegemon_payoff[[1L]], H_theta_1 = closed$hegemon_payoff[[2L]],
      stringsAsFactors = FALSE
    )
  }
  do.call(rbind, rows)
}

if (ei_is_direct_script("verify_essential_input_n2_numeric.R")) {
  result <- run_n2_numeric_verification()
  cat(sprintf("N2_NUMERIC: PASS — %d rows; nu_star, offers, payoffs, outcomes, and endpoint support verified.\n", nrow(result)))
}
