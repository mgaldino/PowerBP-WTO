#!/usr/bin/env Rscript

# Selection-free bounds for an initial-recognition pi_H > 0 stress test. Only
# the initial R1 recognition probability changes; continuation values are held
# at the pi_H = 0 baseline. The H-proposer branch is intentionally bounded, not
# solved, so the pi_H = 0 theorem architecture remains the exact main result.

options(scipen = 999)

if (requireNamespace("here", quietly = TRUE)) {
  repo_root <- here::here()
} else {
  repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}

project_sentinels <- file.path(
  repo_root,
  c("formal_model_v5.Rmd", "model_redesign/power_architecture_derivations.Rmd")
)
if (!all(file.exists(project_sentinels))) {
  stop("Run from the PowerBayesianPersuasion repository root or a here::here()-recognized subdirectory.")
}

tables_dir <- file.path(repo_root, "tables")
dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)

compute_piH_bounds <- function(N = 13, beta = 0.9, d0 = 0.19, d1 = 0.285,
                               b0 = 0, b1 = 0,
                               pi_grid = c(0, 0.05, 0.1, 0.25, 0.5, 1),
                               tol = 1e-10) {
  stopifnot(
    N >= 3,
    beta > 0, beta <= 1,
    d0 >= 0, d0 < d1,
    is.finite(b0), is.finite(b1),
    all(pi_grid >= 0), all(pi_grid <= 1)
  )

  m <- N - 1
  tau0 <- d0 - b0
  tau1 <- d1 - b1
  a1 <- beta * d1 - b1

  # Working pi_H=0 illustration: R1 unanimity selects pooling.
  V_H_U_Wprop_0 <- a1 + b0
  V_H_U_Wprop_1 <- a1 + b1
  V_W_U_Wprop <- (1 - a1) / m

  V_H_M_Wprop_0 <- d0
  V_H_M_Wprop_1 <- d1
  V_W_M_Wprop <- 1 / m

  # Selection-free H-proposer bounds. H can always force rejection and obtain at
  # least discounted terminal disagreement; any accepted package has y <= 1.
  Hprop_lower_0 <- beta * d0
  Hprop_lower_1 <- beta * d1
  Hprop_upper_0 <- 1 + b0
  Hprop_upper_1 <- 1 + b1

  # Weak states' representative payoff is bounded by the normalized fixed pie.
  Wprop_lower <- 0
  Wprop_upper <- 1 / m

  rows <- do.call(
    rbind,
    lapply(pi_grid, function(pi_H) {
      data.frame(
        pi_H = pi_H,
        V_H_U_0_lower = (1 - pi_H) * V_H_U_Wprop_0 + pi_H * Hprop_lower_0,
        V_H_U_0_upper = (1 - pi_H) * V_H_U_Wprop_0 + pi_H * Hprop_upper_0,
        V_H_U_1_lower = (1 - pi_H) * V_H_U_Wprop_1 + pi_H * Hprop_lower_1,
        V_H_U_1_upper = (1 - pi_H) * V_H_U_Wprop_1 + pi_H * Hprop_upper_1,
        V_H_M_0_lower = (1 - pi_H) * V_H_M_Wprop_0 + pi_H * Hprop_lower_0,
        V_H_M_0_upper = (1 - pi_H) * V_H_M_Wprop_0 + pi_H * Hprop_upper_0,
        V_H_M_1_lower = (1 - pi_H) * V_H_M_Wprop_1 + pi_H * Hprop_lower_1,
        V_H_M_1_upper = (1 - pi_H) * V_H_M_Wprop_1 + pi_H * Hprop_upper_1,
        V_W_U_lower = (1 - pi_H) * V_W_U_Wprop + pi_H * Wprop_lower,
        V_W_U_upper = (1 - pi_H) * V_W_U_Wprop + pi_H * Wprop_upper,
        V_W_M_lower = (1 - pi_H) * V_W_M_Wprop + pi_H * Wprop_lower,
        V_W_M_upper = (1 - pi_H) * V_W_M_Wprop + pi_H * Wprop_upper
      )
    })
  )

  pi0 <- rows[which.min(abs(rows$pi_H)), ]
  checks <- list(
    threshold_domain = tau0 >= -tol && tau0 < tau1,
    H_bounds_ordered = all(rows$V_H_U_0_lower <= rows$V_H_U_0_upper + tol) &&
      all(rows$V_H_U_1_lower <= rows$V_H_U_1_upper + tol) &&
      all(rows$V_H_M_0_lower <= rows$V_H_M_0_upper + tol) &&
      all(rows$V_H_M_1_lower <= rows$V_H_M_1_upper + tol),
    W_bounds_ordered = all(rows$V_W_U_lower <= rows$V_W_U_upper + tol) &&
      all(rows$V_W_M_lower <= rows$V_W_M_upper + tol),
    pi0_recovers_baseline = abs(pi0$V_H_U_0_lower - V_H_U_Wprop_0) <= tol &&
      abs(pi0$V_H_U_0_upper - V_H_U_Wprop_0) <= tol &&
      abs(pi0$V_H_U_1_lower - V_H_U_Wprop_1) <= tol &&
      abs(pi0$V_H_U_1_upper - V_H_U_Wprop_1) <= tol &&
      abs(pi0$V_H_M_0_lower - V_H_M_Wprop_0) <= tol &&
      abs(pi0$V_H_M_0_upper - V_H_M_Wprop_0) <= tol &&
      abs(pi0$V_H_M_1_lower - V_H_M_Wprop_1) <= tol &&
      abs(pi0$V_H_M_1_upper - V_H_M_Wprop_1) <= tol &&
      abs(pi0$V_W_U_lower - V_W_U_Wprop) <= tol &&
      abs(pi0$V_W_U_upper - V_W_U_Wprop) <= tol &&
      abs(pi0$V_W_M_lower - V_W_M_Wprop) <= tol &&
      abs(pi0$V_W_M_upper - V_W_M_Wprop) <= tol,
    W_bounds_in_unit_range = min(rows$V_W_U_lower, rows$V_W_M_lower) >= -tol &&
      max(rows$V_W_U_upper, rows$V_W_M_upper) <= 1 / m + tol
  )

  list(
    N = N,
    m = m,
    beta = beta,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    tau0 = tau0,
    tau1 = tau1,
    a1 = a1,
    V_H_U_Wprop_0 = V_H_U_Wprop_0,
    V_H_U_Wprop_1 = V_H_U_Wprop_1,
    V_W_U_Wprop = V_W_U_Wprop,
    V_H_M_Wprop_0 = V_H_M_Wprop_0,
    V_H_M_Wprop_1 = V_H_M_Wprop_1,
    V_W_M_Wprop = V_W_M_Wprop,
    checks = checks,
    rows = rows
  )
}

objects <- compute_piH_bounds()

failed <- names(objects$checks)[!unlist(objects$checks)]
if (length(failed) > 0) {
  stop(sprintf("pi_H bounds check failed: %s", paste(failed, collapse = ", ")))
}

out_path <- file.path(tables_dir, "relative_package_piH_bounds.csv")
write.csv(objects$rows, out_path, row.names = FALSE)

cat("Selection-free initial-recognition pi_H bounds for relative-package architecture\n")
cat(sprintf(
  "N=%d, m=%d, beta=%.6f, d0=%.6f, d1=%.6f, b0=%.6f, b1=%.6f\n",
  objects$N, objects$m, objects$beta, objects$d0, objects$d1,
  objects$b0, objects$b1
))
cat("Checks:\n")
print(objects$checks)
cat("\nBounds table:\n")
print(objects$rows, row.names = FALSE, digits = 10)
cat("\nWrote:\n")
cat(out_path, "\n")
cat("\nAll selection-free pi_H bound checks passed.\n")
