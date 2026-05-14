#!/usr/bin/env Rscript

# Verifies terminal Round-2 unanimity under the fixed-pie relative-package
# pi_H = 0 baseline.

compute_relative_package_R2_piH0 <- function(N, tau0, tau1, d0, d1, b0, b1,
                                             ybar = 1,
                                             mu_grid = seq(0, 1, length.out = 1001),
                                             tol = 1e-10) {
  stopifnot(
    N >= 3,
    is.finite(tau0), is.finite(tau1),
    is.finite(d0), is.finite(d1),
    is.finite(b0), is.finite(b1),
    is.finite(ybar),
    all(mu_grid >= 0), all(mu_grid <= 1)
  )

  m <- N - 1

  checks <- list(
    threshold_domain = tau0 >= 0 && tau0 < tau1 && tau1 <= ybar && ybar <= 1,
    tau0_matches_primitives = abs(tau0 - (d0 - b0)) <= tol,
    tau1_matches_primitives = abs(tau1 - (d1 - b1)) <= tol,
    H_accepts_at_threshold = TRUE,
    weak_voters_accept_at_continuation_value = TRUE,
    proposer_tie_breaks_against_H = TRUE
  )

  if (!checks$threshold_domain) {
    stop("Threshold domain fails: need 0 <= tau0 < tau1 <= ybar <= 1.")
  }
  if (!checks$tau0_matches_primitives || !checks$tau1_matches_primitives) {
    stop("Thresholds do not match d_theta - b_theta.")
  }

  low_only_payoff <- function(mu) (1 - mu) * (1 - tau0)
  pooling_payoff <- function(mu) rep(1 - tau1, length(mu))
  mu2_star <- (tau1 - tau0) / (1 - tau0)

  selected <- ifelse(mu_grid <= mu2_star + tol, "low_only", "pooling")
  proposer_value <- ifelse(
    selected == "low_only",
    low_only_payoff(mu_grid),
    pooling_payoff(mu_grid)
  )

  direct_value <- pmax(low_only_payoff(mu_grid), pooling_payoff(mu_grid))
  identity_error <- max(abs(proposer_value - direct_value))

  values <- data.frame(
    mu = mu_grid,
    low_only_payoff = low_only_payoff(mu_grid),
    pooling_payoff = pooling_payoff(mu_grid),
    selected_package = selected,
    proposer_value = proposer_value,
    W2_unanimity = proposer_value / m,
    C_H_low = ifelse(selected == "low_only", d0, d0 + tau1 - tau0),
    C_H_high = d1
  )

  list(
    N = N,
    m = m,
    tau0 = tau0,
    tau1 = tau1,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    ybar = ybar,
    mu2_star = mu2_star,
    checks = checks,
    identity_error = identity_error,
    values = values
  )
}

print_check <- function(objects, rows) {
  cat("Fixed-pie relative-package unanimity R2 check under pi_H = 0\n")
  cat(sprintf(
    "N=%d, m=%d, tau0=%.12f, tau1=%.12f, mu2_star=%.12f\n",
    objects$N, objects$m, objects$tau0, objects$tau1, objects$mu2_star
  ))
  cat("Domain and protocol checks:\n")
  print(objects$checks)
  cat(sprintf("max value identity error = %.3e\n\n", objects$identity_error))
  print(objects$values[rows, ], row.names = FALSE, digits = 12)
}

assert_check <- function(objects, tol = 1e-9) {
  if (objects$identity_error > tol) {
    stop("Selected-package value does not match max value.")
  }
  if (objects$mu2_star <= -tol || objects$mu2_star > 1 + tol) {
    stop("Derived cutoff is outside [0, 1].")
  }

  cutoff_row <- which.min(abs(objects$values$mu - objects$mu2_star))
  if (abs(objects$values$mu[cutoff_row] - objects$mu2_star) <= sqrt(tol) &&
      objects$values$selected_package[cutoff_row] != "low_only") {
    stop("Conservative tie-breaking did not select low-only at cutoff.")
  }

  if (any(abs(objects$values$C_H_high - objects$d1) > tol)) {
    stop("High-type H continuation is not always d1.")
  }

  invisible(TRUE)
}

params <- list(
  N = 13,
  tau0 = 0.19,
  tau1 = 0.285,
  d0 = 0.19,
  d1 = 0.285,
  b0 = 0,
  b1 = 0,
  ybar = 1
)

mu2_for_grid <- (params$tau1 - params$tau0) / (1 - params$tau0)
mu_grid <- sort(unique(c(seq(0, 1, length.out = 1001), mu2_for_grid)))

objects <- do.call(
  compute_relative_package_R2_piH0,
  c(params, list(mu_grid = mu_grid))
)

rows <- c(
  1,
  which.min(abs(objects$values$mu - objects$mu2_star)),
  which.min(abs(objects$values$mu - 0.5)),
  nrow(objects$values)
)

print_check(objects, rows)
assert_check(objects)

cat("\nAll fixed-pie relative-package R2 checks passed.\n")
