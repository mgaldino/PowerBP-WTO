#!/usr/bin/env Rscript

# Conditional numerical checks for the R1 unanimity pooling-or-rejection
# characterization under pi_H = 0 in both rounds. This script excludes the
# high-state-only feasibility branch; use verify_unanimity_R1_C_B_R_piH0.R for
# the current characterization.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_unanimity_R1_C_or_R_piH0 <- function(N, r, alpha, beta,
                                             mu_grid = c(0, 0.07251908397,
                                                         0.37242424242,
                                                         0.7, 1)) {
  stopifnot(N >= 3, r > 1, alpha > 0, alpha < 1 / r,
            beta > 0, beta <= 1)

  m <- N - 1
  k <- m - 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A2 <- function(mu) (1 - mu) * (1 - alpha)
  G_C2 <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A2(mu), G_C2(mu))
  W2 <- function(mu) g(mu) / m
  p2 <- alpha * (r - 1) / (r - alpha)

  h_C <- beta * alpha * r
  y_C <- function(mu) beta * W2(mu)
  C_cost_low <- function(mu) h_C + k * y_C(mu)
  C_payoff <- function(mu) Ve(mu) - C_cost_low(mu)
  R_payoff <- function(mu) beta * W2(mu)
  C_minus_R <- function(mu) C_payoff(mu) - R_payoff(mu)
  weak_pool <- function(mu) (Ve(mu) - h_C) / m
  H_pool <- function(mu) h_C + 0 * mu
  H_outside <- function(mu) alpha * Ve(mu)
  H_pool_premium <- function(mu) H_pool(mu) - H_outside(mu)

  # Strict separating A would require h >= beta alpha r for the low type to
  # accept after a high-posterior rejection history and h < beta alpha r for the
  # high type to reject strictly. The interval is empty.
  separating_lower_bound <- beta * alpha * r
  separating_upper_bound <- beta * alpha * r
  strict_separating_exists <- separating_lower_bound < separating_upper_bound
  if (strict_separating_exists) {
    stop("Strict separating interval should be empty.")
  }

  grid <- seq(0, 1, length.out = 10001)
  feasible <- C_cost_low(grid) <= 1 + 1e-12

  if (any(C_minus_R(grid) < -1e-10)) {
    stop("Pooling does not weakly dominate rejection on the full grid.")
  }

  if (!any(feasible)) {
    stop("Pooling is nowhere feasible on the grid.")
  }

  feasibility_boundary <- if (all(feasible)) {
    1
  } else {
    stats::uniroot(function(mu) C_cost_low(mu) - 1,
                   c(p2, 1))$root
  }

  rent_boundary <- if (beta * r > 1) {
    (beta * r - 1) / (r - 1)
  } else {
    NA_real_
  }

  # A type-independent rejected proposal can be induced by offering h_R = 0 to
  # H. For alpha > 0, both types strictly reject. The low type's smallest
  # discounted rejection value is beta * alpha.
  H_rejection_gap <- beta * alpha

  values <- data.frame(
    mu = mu_grid,
    V_e = Ve(mu_grid),
    g = g(mu_grid),
    C_cost_low = C_cost_low(mu_grid),
    C_payoff = C_payoff(mu_grid),
    R_payoff = R_payoff(mu_grid),
    C_minus_R = C_minus_R(mu_grid),
    weak_pool = weak_pool(mu_grid),
    H_pool = H_pool(mu_grid),
    H_outside = H_outside(mu_grid),
    H_pool_premium = H_pool_premium(mu_grid),
    H_rejection_gap = H_rejection_gap + 0 * mu_grid
  )

  list(
    N = N,
    m = m,
    k = k,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    h_C = h_C,
    separating_lower_bound = separating_lower_bound,
    separating_upper_bound = separating_upper_bound,
    strict_separating_exists = strict_separating_exists,
    feasibility_boundary = feasibility_boundary,
    rent_boundary = rent_boundary,
    min_C_minus_R = min(C_minus_R(grid)),
    max_C_cost_low = max(C_cost_low(grid)),
    H_rejection_gap = H_rejection_gap,
    values = values
  )
}

objects <- do.call(compute_unanimity_R1_C_or_R_piH0, params)

cat("Baseline unanimity R1 C-or-R check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, k=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$k,
            objects$r, objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("h_C=%.12f\n", objects$h_C))
cat(sprintf("strict separating interval empty: %s\n",
            !objects$strict_separating_exists))
cat(sprintf("separating lower bound=%.12f, upper bound=%.12f\n",
            objects$separating_lower_bound,
            objects$separating_upper_bound))
cat(sprintf("pooling feasibility boundary=%.12f\n",
            objects$feasibility_boundary))
cat(sprintf("rent boundary=%.12f\n", objects$rent_boundary))
cat(sprintf("min C-minus-R=%.12f\n", objects$min_C_minus_R))
cat(sprintf("max low-state C cost=%.12f\n", objects$max_C_cost_low))
cat(sprintf("H-rejection implementation gap at h_R=0=%.12f\n\n",
            objects$H_rejection_gap))

print(objects$values, row.names = FALSE, digits = 12)

if (objects$feasibility_boundary >= objects$rent_boundary) {
  stop("Pooling feasibility region is not contained in the positive-premium region.")
}

if (objects$H_rejection_gap <= 0) {
  stop("Rejected-proposal implementation is not strict for H.")
}

cat("\nAll baseline unanimity R1 C-or-R checks passed for the OPEC calibration.\n")
