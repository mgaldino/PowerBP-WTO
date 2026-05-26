#!/usr/bin/env Rscript

# Verifies the institutional classification under the pi_H = 0 baseline.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9,
  costs = c(0.06, 0.07, 0.08, 0.10)
)

compute_classification <- function(N, r, alpha, beta, costs) {
  stopifnot(N >= 3, r > 1, alpha >= 0, alpha < 1 / r, beta > 0, beta <= 1)

  m <- N - 1
  q <- floor(N / 2) + 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A <- function(mu) (1 - mu) * (1 - alpha)
  G_C <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A(mu), G_C(mu))
  p2 <- alpha * (r - 1) / (r - alpha)
  mu_H <- (beta * r - 1) / (r - 1)

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

  H_M <- function(mu) alpha * Ve(mu)
  H_U_delay <- function(mu) ifelse(mu < p2, beta * alpha * Ve(mu),
                                  beta * alpha * r)
  H_U <- function(mu) {
    ifelse(pool_feasible(mu) & pool_preferred(mu),
           beta * alpha * r,
           H_U_delay(mu))
  }
  D_H <- function(mu) H_U(mu) - H_M(mu)

  grid <- seq(0, 1, length.out = 10001)
  if (!all(majority_feasible(grid))) {
    stop("Majority pass branch is not globally feasible.")
  }
  if (any(V_W_U(grid) - V_W_M(grid) > 1e-10)) {
    stop("F_U subset F_M implication fails.")
  }
  if (any(D_H(grid[grid < mu_H - 1e-8]) <= 0)) {
    stop("Dominance gap is not positive below mu_H.")
  }
  if (any(D_H(grid[grid > mu_H + 1e-8]) >= 0)) {
    stop("Dominance gap is not negative above mu_H.")
  }

  summarize_cost <- function(c) {
    F_U <- V_W_U(grid) >= c
    F_M <- V_W_M(grid) >= c
    data.frame(
      c = c,
      F_U_share = mean(F_U),
      F_M_share = mean(F_M),
      strict_U_share = mean(F_U & grid < mu_H),
      strict_M_share = mean(F_U & grid > mu_H),
      indifferent_formation_share = mean(F_M & !F_U)
    )
  }

  list(
    N = N,
    m = m,
    q = q,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    mu_H = mu_H,
    summaries = do.call(rbind, lapply(costs, summarize_cost))
  )
}

objects <- do.call(compute_classification, params)

cat("Baseline institutional classification check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, q=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$q, objects$r,
            objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("mu_H=%.12f\n\n", objects$mu_H))

print(objects$summaries, row.names = FALSE, digits = 12)

cat("\nInstitutional classification check passed for the OPEC calibration.\n")
