#!/usr/bin/env Rscript

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(script_argument) == 1L) {
  normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
} else {
  normalizePath("scripts/verify_essential_input_n4_numeric.R", mustWork = TRUE)
}
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
source(file.path(repository_root, "scripts", "essential_input_formulas.R"), local = FALSE)
source(file.path(repository_root, "scripts", "essential_input_numeric_helpers.R"), local = FALSE)

run_n4_numeric_verification <- function(grid = ei_parameter_grid()) {
  verify_essential_input_formula_sources(repository_root)
  rows <- vector("list", nrow(grid))
  for (index in seq_len(nrow(grid))) {
    p <- grid[index, , drop = FALSE]
    z <- essential_input_constants(p$N, p$o_0, p$o_1, p$beta, p$nu)
    closed <- n4_closed_form(p$N, p$o_0, p$o_1, p$beta, p$nu)
    label <- sprintf("N4 row %d", index)
    if (identical(closed$existence_status, "none")) {
      profiles <- ei_n4_ballot_profiles(
        p$N, p$o_0, p$o_1, p$beta, p$nu,
        y = z$ell, x = rep(z$A, z$m - 1L)
      )
      ei_assert_true(
        nrow(profiles) == 0L,
        paste(label, "s_dagger must have no sequentially rational pure H profile.")
      )
    } else if (identical(closed$class, "L")) {
      profiles <- ei_n4_ballot_profiles(
        p$N, p$o_0, p$o_1, p$beta, p$nu,
        y = closed$proposal[["y"]], x = rep(closed$proposal[["x"]], z$m - 1L)
      )
      ei_assert_set_equal(profiles$profile, "yn", paste(label, "endpoint L ballot profile"))
      ei_assert_close(closed$proposal[["r"]] - z$A, 1 - p$beta, paste(label, "Q_L-A"))
      ei_assert_close(
        closed$hegemon_payoff,
        c(theta_0 = z$ell, theta_1 = z$h),
        paste(label, "L H payoff")
      )
    } else {
      profiles <- ei_n4_ballot_profiles(
        p$N, p$o_0, p$o_1, p$beta, p$nu,
        y = closed$proposal[["y"]], x = rep(closed$proposal[["x"]], z$m - 1L)
      )
      ei_assert_set_equal(profiles$profile, "yy", paste(label, "high-prior P ballot profile"))
      ei_assert_close(closed$proposal[["r"]] - z$B, 1 - p$beta, paste(label, "Q_P-B"))
      ei_assert_close(
        closed$hegemon_payoff,
        c(theta_0 = z$h, theta_1 = z$h),
        paste(label, "P H payoff")
      )
    }
    rows[[index]] <- data.frame(
      node = "N4", status = "PASS", N = p$N, pair_id = p$pair_id,
      o_0 = p$o_0, o_1 = p$o_1, beta = p$beta, nu = p$nu,
      cell_id = closed$cell_id,
      selected_class = if (is.na(closed$class)) "NONE" else closed$class,
      proposer_payoff = closed$recognized_proposer_payoff,
      H_theta_0 = closed$hegemon_payoff[[1L]], H_theta_1 = closed$hegemon_payoff[[2L]],
      stringsAsFactors = FALSE
    )
  }
  result <- do.call(rbind, rows)
  ei_assert_set_equal(
    result$cell_id,
    c("N4-NU-ZERO", "N4-NO-PURE-PBE", "N4-HIGH-PRIOR"),
    "N4 three-cell coverage"
  )
  result
}

if (ei_is_direct_script("verify_essential_input_n4_numeric.R")) {
  result <- run_n4_numeric_verification()
  cat(sprintf("N4_NUMERIC: PASS — %d rows; endpoint/high families and exhaustive four-profile nonexistence certificates verified.\n", nrow(result)))
}
