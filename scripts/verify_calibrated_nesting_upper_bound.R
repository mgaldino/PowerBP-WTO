#!/usr/bin/env Rscript

# Verifies calibrated formation-set nesting with a selection-free upper bound
# on weak-state payoffs under unanimity.

params <- list(
  N = 13,
  r = 1.5,
  alpha = 0.19,
  beta = 0.9,
  p_AC = 0.0311882732,
  p_C_feas = 0.3017171717
)

compute_gaps <- function(N, r, alpha, beta, p_AC, p_C_feas) {
  m <- N - 1
  q <- floor(N / 2) + 1
  A0 <- 1 + m * alpha
  A1 <- 1 + m * alpha * r
  p2 <- alpha * (r - 1) / (r - alpha)
  kappa_M <- (N * m + beta * (q - 1)) / (N^2 * m)

  Ve <- function(p) 1 + p * (r - 1)
  W2 <- function(p) pmax((1 - p) * (1 - alpha), Ve(p) - alpha * r) / N
  L_H <- function(p) {
    (1 - p) * beta * A0 / N +
      p * (r - m * beta * r * (1 - alpha) / N)
  }

  h_A <- beta * A1 / N
  h_C <- beta * r * A0 / N

  omega_A <- function(p) (1 - p) * (1 - h_A) + p * m * beta * W2(1)
  omega_C <- function(p) Ve(p) - h_C
  omega_R <- function(p) m * beta * W2(p)

  upper_U <- function(p, omega) {
    (Ve(p) - L_H(p)) / (N * m) + omega(p) / N
  }
  gap <- function(p, omega) kappa_M * Ve(p) - upper_U(p, omega)

  endpoint_gaps <- data.frame(
    point = c("0", "p_AC", "p2", "p_C_feas", "1"),
    p = c(0, p_AC, p2, p_C_feas, 1),
    gap_A = gap(c(0, p_AC, p2, p_C_feas, 1), omega_A),
    gap_C = gap(c(0, p_AC, p2, p_C_feas, 1), omega_C),
    gap_R = gap(c(0, p_AC, p2, p_C_feas, 1), omega_R)
  )

  relevant_gaps <- data.frame(
    branch = c("A on [0,p_AC]", "C on [p_AC,p_C_feas]",
               "A on [p_C_feas,1]", "R tie/check"),
    min_gap = c(
      min(gap(c(0, p_AC), omega_A)),
      min(gap(c(p_AC, p_C_feas), omega_C)),
      min(gap(c(p_C_feas, 1), omega_A)),
      min(gap(c(0, p2, 1), omega_R))
    )
  )

  list(
    N = N,
    r = r,
    alpha = alpha,
    beta = beta,
    q = q,
    p2 = p2,
    kappa_M = kappa_M,
    endpoint_gaps = endpoint_gaps,
    relevant_gaps = relevant_gaps,
    all_relevant_positive = all(relevant_gaps$min_gap > 0)
  )
}

objects <- do.call(compute_gaps, params)

cat("Calibrated formation-set nesting upper-bound check\n")
cat(sprintf("N=%d, r=%.6f, alpha=%.6f, beta=%.6f, q=%d\n",
            objects$N, objects$r, objects$alpha, objects$beta, objects$q))
cat(sprintf("p2=%.12f\n", objects$p2))
cat(sprintf("kappa_M=%.12f\n\n", objects$kappa_M))

cat("Endpoint gaps: V_W(M) - upper_bound[V_W(U; branch)]\n")
print(objects$endpoint_gaps, row.names = FALSE, digits = 12)

cat("\nRelevant branch minima\n")
print(objects$relevant_gaps, row.names = FALSE, digits = 12)

if (!objects$all_relevant_positive) {
  stop("At least one relevant nesting endpoint is non-positive.")
}

cat("\nAll relevant calibrated nesting gaps are strictly positive.\n")
