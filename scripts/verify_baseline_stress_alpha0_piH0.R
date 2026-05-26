#!/usr/bin/env Rscript

# Verifies the alpha = 0 stress test under pi_H = 0 in both rounds.

params <- list(
  N = 13,
  r = 1.5,
  beta = 0.9,
  alpha = 0
)

compute_alpha0_stress <- function(N, r, beta, alpha,
                                  mu_grid = c(0, 0.5, 1)) {
  stopifnot(N >= 3, r > 1, beta > 0, beta <= 1, alpha == 0)

  m <- N - 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A <- function(mu) 1 - mu
  G_C <- function(mu) Ve(mu)
  W2 <- function(mu) pmax(G_A(mu), G_C(mu)) / m
  h_pool <- beta * alpha * r
  y_pool <- function(mu) beta * W2(mu)
  pool_cost_low <- function(mu) h_pool + (m - 1) * y_pool(mu)
  H_payoff <- function(mu) 0 * mu
  H_outside <- function(mu) alpha * Ve(mu)
  rent <- function(mu) H_payoff(mu) - H_outside(mu)

  grid <- seq(0, 1, length.out = 1001)

  if (any(G_C(grid) + sqrt(.Machine$double.eps) < G_A(grid))) {
    stop("Conservative zero offer does not weakly dominate aggressive offer.")
  }

  values <- data.frame(
    mu = mu_grid,
    V_e = Ve(mu_grid),
    G_A = G_A(mu_grid),
    G_C = G_C(mu_grid),
    W2_unanimity = W2(mu_grid),
    h_pool = h_pool,
    y_pool = y_pool(mu_grid),
    pool_cost_low = pool_cost_low(mu_grid),
    H_payoff = H_payoff(mu_grid),
    H_outside = H_outside(mu_grid),
    H_rent = rent(mu_grid)
  )

  list(
    N = N,
    m = m,
    r = r,
    beta = beta,
    alpha = alpha,
    max_abs_rent = max(abs(rent(grid))),
    max_pool_cost_low = max(pool_cost_low(grid)),
    values = values
  )
}

objects <- do.call(compute_alpha0_stress, params)

cat("Alpha=0 stress test under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, r=%.6f, beta=%.6f, alpha=%.6f\n",
            objects$N, objects$m, objects$r, objects$beta, objects$alpha))
cat(sprintf("max abs H rent = %.12f\n", objects$max_abs_rent))
cat(sprintf("max low-state pooling cost = %.12f\n\n",
            objects$max_pool_cost_low))

print(objects$values, row.names = FALSE, digits = 12)

if (objects$max_abs_rent > sqrt(.Machine$double.eps)) {
  stop("H rent is not identically zero.")
}

cat("\nAlpha=0 stress test passed.\n")
