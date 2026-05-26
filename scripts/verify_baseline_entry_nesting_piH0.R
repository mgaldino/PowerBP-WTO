#!/usr/bin/env Rscript

# Verifies weak-state entry/nesting under the pi_H = 0 baseline.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_entry_nesting <- function(N, r, alpha, beta) {
  stopifnot(N >= 3, r > 1, alpha >= 0, alpha < 1 / r, beta > 0, beta <= 1)

  m <- N - 1
  q <- floor(N / 2) + 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A <- function(mu) (1 - mu) * (1 - alpha)
  G_C <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A(mu), G_C(mu))
  p2 <- alpha * (r - 1) / (r - alpha)

  majority_feasible <- function(mu) beta * (q - 1) * Ve(mu) / m <= 1 + 1e-12
  pool_feasible <- function(mu) {
    beta * alpha * r + (m - 1) * beta * g(mu) / m <= 1 + 1e-12
  }
  pool_preferred <- function(mu) Ve(mu) - beta * alpha * r >= beta * g(mu) - 1e-12

  V_W_M <- function(mu) Ve(mu) / m
  V_W_pool <- function(mu) (Ve(mu) - beta * alpha * r) / m
  V_W_delay <- function(mu) beta * g(mu) / m
  V_W_U <- function(mu) {
    ifelse(pool_feasible(mu) & pool_preferred(mu), V_W_pool(mu), V_W_delay(mu))
  }

  grid <- seq(0, 1, length.out = 10001)
  majority_global <- all(majority_feasible(grid))
  gap <- V_W_M(grid) - V_W_U(grid)

  if (any(gap < -1e-10)) {
    stop("Unanimity weak-state payoff exceeds majority on the grid.")
  }

  mu_F <- if (all(pool_feasible(grid))) {
    1
  } else if (!any(pool_feasible(grid))) {
    NA_real_
  } else {
    stats::uniroot(function(mu) {
      beta * alpha * r + (m - 1) * beta * g(mu) / m - 1
    }, c(p2, 1))$root
  }

  points <- unique(c(0, p2, mu_F, 1))
  points <- points[!is.na(points)]
  point_values <- data.frame(
    mu = points,
    branch = ifelse(pool_feasible(points) & pool_preferred(points),
                    "pool", "delay"),
    V_W_M = V_W_M(points),
    V_W_U = V_W_U(points),
    gap = V_W_M(points) - V_W_U(points),
    majority_feasible = majority_feasible(points)
  )

  list(
    N = N,
    m = m,
    q = q,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    mu_F = mu_F,
    majority_global = majority_global,
    min_gap = min(gap),
    min_gap_mu = grid[which.min(gap)],
    point_values = point_values
  )
}

objects <- do.call(compute_entry_nesting, params)

cat("Baseline entry/nesting check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, q=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$q, objects$r,
            objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("pooling feasibility boundary=%.12f\n", objects$mu_F))
cat(sprintf("majority pass feasible globally = %s\n", objects$majority_global))
cat(sprintf("min V_W(M)-V_W(U) gap = %.12f at mu=%.12f\n\n",
            objects$min_gap, objects$min_gap_mu))

print(objects$point_values, row.names = FALSE, digits = 12)

if (!objects$majority_global) {
  stop("Majority pass branch is not globally feasible in this calibration.")
}

if (objects$min_gap < -1e-10) {
  stop("Nesting check failed.")
}

cat("\nEntry/nesting check passed for the OPEC calibration.\n")
