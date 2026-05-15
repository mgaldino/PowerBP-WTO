#!/usr/bin/env Rscript

# Reproduces the calibration margin tables reported in formal_model_v5.Rmd
# for the fixed-pie relative-package pi_H = 0 baseline.

compute_margins <- function(N = 13, beta = 0.9, t0 = 0.19, t1 = 0.285,
                            o0 = t0, o1 = t1, ybar = 1, tol = 1e-10) {
  stopifnot(N >= 3, beta > 0, beta <= 1)
  stopifnot(0 <= t0, t0 < t1, t1 <= ybar, ybar <= 1)

  m <- N - 1
  mu2_star <- (t1 - t0) / (1 - t0)
  p2 <- function(mu) pmax((1 - mu) * (1 - t0), 1 - t1)
  c_u <- function(mu) beta * p2(mu) / m

  a0_M <- t0 - (1 - beta) * o0
  a1_M <- t1 - (1 - beta) * o1
  a1 <- t1 - (1 - beta) * o1
  a0_1 <- t0 - o0 + beta * (o0 + t1 - t0)

  pi_P <- function(mu) 1 - a1 - (m - 1) * c_u(mu)
  pi_R <- function(mu) c_u(mu)
  delta_H <- function(mu) a1 - ((1 - mu) * o0 + mu * o1)

  no_cheap_H <- data.frame(
    condition = "No-Cheap-H",
    value = a0_M,
    boundary = beta / m,
    margin = a0_M - beta / m
  )

  threshold_domain <- data.frame(
    condition = c("t0 >= 0", "t1 >= t0", "ybar >= t1", "1 >= ybar"),
    value = c(t0, t1, ybar, 1),
    boundary = c(0, t0, t1, ybar),
    margin = c(t0, t1 - t0, ybar - t1, 1 - ybar)
  )

  r1_points <- c(0, mu2_star, 0.5, 1)
  r1_margins <- data.frame(
    mu = r1_points,
    pooling = pi_P(r1_points),
    rejection = pi_R(r1_points),
    pooling_minus_rejection = pi_P(r1_points) - pi_R(r1_points)
  )

  max_c <- c_u(0)
  r1_feasibility <- data.frame(
    condition = c("P feasibility at max c(mu)", "R feasibility"),
    value = c(a1 + (m - 1) * max_c, 0),
    boundary = c(1, 1),
    margin = c(1 - (a1 + (m - 1) * max_c), 1)
  )

  entry <- data.frame(
    object = c("V_W^M", "V_W^U", "V_W^M - V_W^U"),
    value = c(1 / m, (1 - a1) / m, 1 / m - (1 - a1) / m)
  )

  h_gap <- data.frame(
    mu = c(0, 0.5, 0.7, 1),
    Delta_H = delta_H(c(0, 0.5, 0.7, 1))
  )

  checks <- list(
    no_cheap_H_margin = abs(no_cheap_H$margin - 0.096) <= tol,
    dynamic_threshold_boundary = abs(a1 - a0_1) <= tol,
    high_posterior_pooling = mu2_star < 1 - tol,
    r1_candidate_feasibility = all(r1_feasibility$margin >= -tol),
    pooling_beats_rejection_all_reported = all(r1_margins$pooling_minus_rejection >= -tol),
    entry_gap = abs(entry$value[3] - 0.021375) <= tol,
    h_gap_formula = max(abs(h_gap$Delta_H - (0.0665 - 0.095 * h_gap$mu))) <= tol
  )

  list(
    N = N,
    m = m,
    beta = beta,
    t0 = t0,
    t1 = t1,
    o0 = o0,
    o1 = o1,
    ybar = ybar,
    mu2_star = mu2_star,
    a0_M = a0_M,
    a1_M = a1_M,
    a0_1 = a0_1,
    a1 = a1,
    no_cheap_H = no_cheap_H,
    threshold_domain = threshold_domain,
    r1_margins = r1_margins,
    r1_feasibility = r1_feasibility,
    entry = entry,
    h_gap = h_gap,
    checks = checks
  )
}

print_margins <- function(x) {
  cat("Relative-package pi_H = 0 calibration margins\n")
  cat(sprintf(
    "N=%d, m=%d, beta=%.6f, t0=%.6f, t1=%.6f, ybar=%.6f\n",
    x$N, x$m, x$beta, x$t0, x$t1, x$ybar
  ))
  cat(sprintf(
    "mu2_star=%.12f, a0_M=%.6f, a1_M=%.6f, a0_1=%.6f, a1=%.6f\n\n",
    x$mu2_star, x$a0_M, x$a1_M, x$a0_1, x$a1
  ))

  cat("No-Cheap-H margin:\n")
  print(x$no_cheap_H, row.names = FALSE, digits = 12)
  cat("\nThreshold-domain margins:\n")
  print(x$threshold_domain, row.names = FALSE, digits = 12)
  cat("\nR1 pooling-minus-rejection margins:\n")
  print(x$r1_margins, row.names = FALSE, digits = 12)
  cat("\nR1 candidate-feasibility margins:\n")
  print(x$r1_feasibility, row.names = FALSE, digits = 12)
  cat("\nEntry margins:\n")
  print(x$entry, row.names = FALSE, digits = 12)
  cat("\nH payoff-gap margins:\n")
  print(x$h_gap, row.names = FALSE, digits = 12)
  cat("\nChecks:\n")
  print(x$checks)
}

assert_margins <- function(x) {
  failed <- names(x$checks)[!unlist(x$checks)]
  if (length(failed) > 0) {
    stop(sprintf("Margin verification failed: %s", paste(failed, collapse = ", ")))
  }
  invisible(TRUE)
}

objects <- compute_margins()
print_margins(objects)
assert_margins(objects)

cat("\nAll relative-package pi_H = 0 margin checks passed.\n")
