#!/usr/bin/env Rscript

# Conditional hegemon comparison check under the pi_H = 0 C-or-R baseline. This
# excludes the high-state-only feasibility branch; use
# verify_unanimity_R1_C_B_R_piH0.R for the current characterization.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_conditional_dominance_C_or_R <- function(N, r, alpha, beta) {
  stopifnot(N >= 3, r > 1, alpha > 0, alpha < 1 / r,
            beta > 0, beta <= 1)

  m <- N - 1
  q <- floor(N / 2) + 1
  Ve <- function(mu) 1 + mu * (r - 1)
  G_A2 <- function(mu) (1 - mu) * (1 - alpha)
  G_C2 <- function(mu) Ve(mu) - alpha * r
  g <- function(mu) pmax(G_A2(mu), G_C2(mu))
  p2 <- alpha * (r - 1) / (r - alpha)

  pool_feasible <- function(mu) {
    beta * alpha * r + (m - 1) * beta * g(mu) / m <= 1 + 1e-12
  }
  pool_preferred <- function(mu) Ve(mu) - beta * alpha * r >= beta * g(mu) - 1e-12

  H_M <- function(mu) alpha * Ve(mu)
  H_U_reject <- function(mu) ifelse(mu < p2, beta * alpha * Ve(mu),
                                   beta * alpha * r)
  H_U <- function(mu) {
    ifelse(pool_feasible(mu) & pool_preferred(mu),
           beta * alpha * r,
           H_U_reject(mu))
  }

  grid <- seq(0, 1, length.out = 10001)
  mu_H <- if (beta * r > 1) (beta * r - 1) / (r - 1) else NA_real_
  gap <- H_U(grid) - H_M(grid)

  values_mu <- c(0, p2, 0.372424242424, mu_H, 1)
  values <- data.frame(
    mu = values_mu,
    H_U = H_U(values_mu),
    H_M = H_M(values_mu),
    gap = H_U(values_mu) - H_M(values_mu),
    branch = ifelse(pool_feasible(values_mu) & pool_preferred(values_mu),
                    "pool", "reject")
  )

  list(
    N = N,
    m = m,
    q = q,
    r = r,
    alpha = alpha,
    beta = beta,
    p2 = p2,
    mu_H = mu_H,
    min_H_U = min(H_U(grid)),
    max_H_U = max(H_U(grid)),
    gap_at_zero = H_U(0) - H_M(0),
    gap_at_one = H_U(1) - H_M(1),
    values = values
  )
}

objects <- do.call(compute_conditional_dominance_C_or_R, params)

cat("C-or-R conditional dominance check under pi_H = 0\n")
cat(sprintf("N=%d, m=%d, q=%d, r=%.6f, alpha=%.6f, beta=%.6f\n",
            objects$N, objects$m, objects$q, objects$r,
            objects$alpha, objects$beta))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("dominance cutoff mu_H=%.12f\n", objects$mu_H))
cat(sprintf("min H_U=%.12f, max H_U=%.12f\n",
            objects$min_H_U, objects$max_H_U))
cat(sprintf("gap at mu=0 = %.12f\n", objects$gap_at_zero))
cat(sprintf("gap at mu=1 = %.12f\n\n", objects$gap_at_one))

print(objects$values, row.names = FALSE, digits = 12)

if (abs(objects$min_H_U - objects$max_H_U) > 1e-10) {
  stop("OPEC H_U is not constant on the grid.")
}

if (objects$gap_at_zero <= 0 || objects$gap_at_one >= 0) {
  stop("OPEC dominance signs are not as expected.")
}

cat("\nConditional dominance C-or-R check passed for the OPEC calibration.\n")
