#!/usr/bin/env Rscript

# Verifies lower-bound sufficient conditions for conditional dominance.
# The computation uses corrected majority accounting and strict BF feasibility.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9
)

compute_objects <- function(N, r, alpha, beta) {
  m <- N - 1
  q <- floor(N / 2) + 1
  A0 <- 1 + m * alpha
  A1 <- 1 + m * alpha * r
  p2 <- alpha * (r - 1) / (r - alpha)
  lambda_M <- (N * A0 - beta * (q - 1)) / N^2

  Ve <- function(p) 1 + p * (r - 1)
  W2 <- function(p) pmax((1 - p) * (1 - alpha), Ve(p) - alpha * r) / N
  L_H <- function(p) {
    (1 - p) * beta * A0 / N +
      p * (r - m * beta * r * (1 - alpha) / N)
  }

  h_A <- beta * A1 / N
  h_C <- beta * r * A0 / N
  y_A <- beta * (1 - alpha) / N
  H_A <- function(p) (1 - p) * h_A + p * h_C
  H_R <- function(p) {
    H2_low <- ifelse(p <= p2, A0 / N, A1 / N)
    beta * ((1 - p) * H2_low + p * r * A0 / N)
  }

  D_A <- function(p) L_H(p) / N + m * H_A(p) / N - lambda_M * Ve(p)
  D_R <- function(p) L_H(p) / N + m * H_R(p) / N - lambda_M * Ve(p)

  beta_lower_0 <- N * A0 / (A0 + m * A1 + q - 1)
  beta_lower_1 <- N * m * alpha / (q - 1 + N * m * alpha)
  beta_upper_A <- N / (N + m * alpha * (r - 1))

  endpoint_gaps <- data.frame(
    condition = c("D_A(0)", "D_A(1)", "D_R(0)", "D_R(p2)", "D_R(1)"),
    p = c(0, 1, 0, p2, 1),
    gap = c(D_A(0), D_A(1), D_R(0), D_R(p2), D_R(1))
  )

  list(
    N = N,
    r = r,
    alpha = alpha,
    beta = beta,
    q = q,
    m = m,
    A0 = A0,
    A1 = A1,
    p2 = p2,
    lambda_M = lambda_M,
    beta_lower_0 = beta_lower_0,
    beta_lower_1 = beta_lower_1,
    beta_upper_A = beta_upper_A,
    theorem_condition = max(beta_lower_0, beta_lower_1) < beta &&
      beta < beta_upper_A,
    endpoint_gaps = endpoint_gaps,
    all_positive = all(endpoint_gaps$gap > 0)
  )
}

objects <- do.call(compute_objects, params)

cat("Lower-bound sufficient-condition check\n")
cat(sprintf("N=%d, r=%.6f, alpha=%.6f, beta=%.6f, q=%d\n",
            objects$N, objects$r, objects$alpha, objects$beta, objects$q))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("lambda_M=%.12f\n\n", objects$lambda_M))
cat(sprintf("beta lower endpoint 0 = %.12f\n", objects$beta_lower_0))
cat(sprintf("beta lower endpoint 1 = %.12f\n", objects$beta_lower_1))
cat(sprintf("beta upper A feasible/dominates R = %.12f\n", objects$beta_upper_A))
cat(sprintf("theorem condition holds = %s\n\n", objects$theorem_condition))

print(objects$endpoint_gaps, row.names = FALSE, digits = 12)

if (!objects$all_positive) {
  stop("At least one sufficient-condition endpoint is non-positive.")
}

cat("\nAll sufficient-condition endpoints are strictly positive.\n")
