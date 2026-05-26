#!/usr/bin/env Rscript

# Numerical checks for the R1 unanimity pooling-or-delay characterization
# under pi_H = 0 in both rounds.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_unanimity_R1_piH0 <- function(N, r, alpha, beta,
                                      mu_grid = c(0, 0.07251908397,
                                                  0.37242424242, 0.7, 1)) {
  stopifnot(N >= 3, r > 1, alpha >= 0, alpha < 1 / r, beta > 0, beta <= 1)

  m <- N - 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A <- function(mu) (1 - mu) * (1 - alpha)
  G_C <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A(mu), G_C(mu))
  W2 <- function(mu) g(mu) / m
  p2 <- alpha * (r - 1) / (r - alpha)

  h_pool <- beta * alpha * r
  y_pool <- function(mu) beta * W2(mu)
  pool_cost_low <- function(mu) h_pool + (m - 1) * y_pool(mu)
  proposer_pool <- function(mu) Ve(mu) - pool_cost_low(mu)
  proposer_delay <- function(mu) beta * W2(mu)
  pool_minus_delay <- function(mu) proposer_pool(mu) - proposer_delay(mu)
  weak_pool <- function(mu) (Ve(mu) - h_pool) / m
  H_pool <- function(mu) h_pool + 0 * mu
  H_outside <- function(mu) alpha * Ve(mu)
  H_pool_rent <- function(mu) H_pool(mu) - H_outside(mu)

  grid <- seq(0, 1, length.out = 10001)
  feasible <- pool_cost_low(grid) <= 1 + 1e-12

  if (any(pool_minus_delay(grid) < -1e-10)) {
    stop("Pooling does not weakly dominate delay on the full grid.")
  }

  if (!any(feasible)) {
    stop("Pooling is nowhere feasible on the grid.")
  }

  feasibility_boundary <- if (all(feasible)) {
    1
  } else {
    stats::uniroot(function(mu) pool_cost_low(mu) - 1,
                   c(p2, 1))$root
  }

  rent_boundary <- if (beta * r > 1) {
    (beta * r - 1) / (r - 1)
  } else {
    NA_real_
  }

  values <- data.frame(
    mu = mu_grid,
    V_e = Ve(mu_grid),
    g = g(mu_grid),
    pool_cost_low = pool_cost_low(mu_grid),
    proposer_pool = proposer_pool(mu_grid),
    proposer_delay = proposer_delay(mu_grid),
    pool_minus_delay = pool_minus_delay(mu_grid),
    weak_pool = weak_pool(mu_grid),
    H_pool = H_pool(mu_grid),
    H_outside = H_outside(mu_grid),
    H_pool_rent = H_pool_rent(mu_grid)
  )

  list(
    N = N,
    m = m,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    h_pool = h_pool,
    feasibility_boundary = feasibility_boundary,
    rent_boundary = rent_boundary,
    min_pool_minus_delay = min(pool_minus_delay(grid)),
    max_pool_cost_low = max(pool_cost_low(grid)),
    values = values
  )
}

objects <- do.call(compute_unanimity_R1_piH0, params)

cat("Baseline unanimity R1 pooling-or-delay check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$r, objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("h_pool=%.12f\n", objects$h_pool))
cat(sprintf("feasibility boundary=%.12f\n", objects$feasibility_boundary))
cat(sprintf("rent boundary=%.12f\n", objects$rent_boundary))
cat(sprintf("min pool-minus-delay=%.12f\n", objects$min_pool_minus_delay))
cat(sprintf("max low-state pooling cost=%.12f\n\n", objects$max_pool_cost_low))

print(objects$values, row.names = FALSE, digits = 12)

if (objects$feasibility_boundary >= objects$rent_boundary) {
  stop("Pooling feasibility region is not contained in the positive-rent region.")
}

cat("\nAll baseline unanimity R1 checks passed for the OPEC calibration.\n")
