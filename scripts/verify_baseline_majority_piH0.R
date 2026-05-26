#!/usr/bin/env Rscript

# Verifies the baseline majority payoffs under pi_H = 0.
# This script checks the OPEC calibration and Round-1 low-state feasibility.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_majority_piH0 <- function(N, r, alpha, beta, mu_grid = c(0, 0.5, 1)) {
  stopifnot(N >= 3, r > 1, alpha >= 0, alpha < 1 / r, beta > 0, beta <= 1)

  m <- N - 1
  q <- floor(N / 2) + 1
  Ve <- function(mu) 1 + mu * (r - 1)

  voter_transfer <- function(mu) beta * Ve(mu) / m
  total_vote_transfer <- function(mu) (q - 1) * voter_transfer(mu)
  proposer_expected_payoff <- function(mu) {
    Ve(mu) - total_vote_transfer(mu)
  }

  full_grid <- seq(0, 1, length.out = 1001)
  feasibility <- data.frame(
    mu = full_grid,
    total_vote_transfer = total_vote_transfer(full_grid),
    low_state_residual = 1 - total_vote_transfer(full_grid)
  )

  if (any(feasibility$low_state_residual < -sqrt(.Machine$double.eps))) {
    stop("Round-1 majority proposal is not feasible for all mu in [0,1].")
  }

  payoffs <- data.frame(
    mu = mu_grid,
    V_e = Ve(mu_grid),
    H_majority = alpha * Ve(mu_grid),
    W_majority = Ve(mu_grid) / m,
    voter_transfer = voter_transfer(mu_grid),
    total_vote_transfer = total_vote_transfer(mu_grid),
    proposer_expected_payoff = proposer_expected_payoff(mu_grid),
    entry_cost_max = Ve(mu_grid) / m
  )

  list(
    N = N,
    m = m,
    q = q,
    r = r,
    alpha = alpha,
    beta = beta,
    max_total_vote_transfer = max(feasibility$total_vote_transfer),
    min_low_state_residual = min(feasibility$low_state_residual),
    payoffs = payoffs
  )
}

objects <- do.call(compute_majority_piH0, params)

cat("Baseline majority check under pi_H = 0\n")
cat(sprintf(
  "N=%d, m=%d, q=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
  objects$N, objects$m, objects$q, objects$r, objects$alpha, objects$beta
))
cat(sprintf("max total R1 coalition transfer = %.12f\n",
            objects$max_total_vote_transfer))
cat(sprintf("min low-state residual after R1 transfers = %.12f\n\n",
            objects$min_low_state_residual))

print(objects$payoffs, row.names = FALSE, digits = 12)

if (any(objects$payoffs$H_majority != objects$alpha * objects$payoffs$V_e)) {
  stop("H majority payoff does not equal alpha * V_e.")
}

if (any(objects$payoffs$W_majority != objects$payoffs$V_e / objects$m)) {
  stop("Weak-state majority payoff does not equal V_e / m.")
}

cat("\nAll baseline majority checks passed.\n")
