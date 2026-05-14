#!/usr/bin/env Rscript

# Verifies majority payoffs under the fixed-pie relative-package pi_H = 0
# baseline with simultaneous public voting and ex post vote records.

compute_relative_package_majority_piH0 <- function(N, beta, d0, d1, b0, b1,
                                                   ybar = 1,
                                                   mu_grid = seq(0, 1, length.out = 1001),
                                                   tol = 1e-10) {
  stopifnot(
    N >= 3,
    beta > 0, beta <= 1,
    is.finite(d0), is.finite(d1),
    is.finite(b0), is.finite(b1),
    is.finite(ybar),
    all(mu_grid >= 0), all(mu_grid <= 1)
  )

  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1

  W2_M <- 1 / m
  c_M <- beta * W2_M

  a0_M <- beta * d0 - b0
  a1_M <- beta * d1 - b1

  no_H_value <- 1 - k * c_M
  pooling_H_value <- 1 - a1_M - (k - 1) * c_M
  low_only_H_value <- (1 - mu_grid) * (1 - a0_M - (k - 1) * c_M) + mu_grid * c_M
  pooling_gap <- pooling_H_value - no_H_value
  low_only_gap <- low_only_H_value - no_H_value
  low_only_gap_formula <- c_M - a0_M + mu_grid * (a0_M + k * c_M - 1)
  low_only_gap_identity_error <- max(abs(low_only_gap - low_only_gap_formula))
  quota_bound <- (k + 1) * c_M <= 1 + tol
  no_cheap_H <- a0_M + tol >= c_M
  no_H_uniformly_optimal_theorem <- no_cheap_H
  majority_H_screening_cutoff <- if (a0_M < c_M - tol) {
    (c_M - a0_M) / (1 - a0_M - k * c_M)
  } else {
    NA_real_
  }

  values <- data.frame(
    mu = mu_grid,
    no_H_value = no_H_value,
    pooling_H_value = pooling_H_value,
    low_only_H_value = low_only_H_value,
    best_H_including_value = pmax(pooling_H_value, low_only_H_value),
    selected_package = ifelse(
      no_H_value + tol >= pmax(pooling_H_value, low_only_H_value),
      "no_H",
      "H_including"
    )
  )

  max_H_including_advantage <- max(values$best_H_including_value - values$no_H_value)
  no_H_uniformly_optimal_grid <- all(values$selected_package == "no_H")

  checks <- list(
    majority_quota_valid = q >= 2 && q <= N,
    weak_majority_exists_without_H = k <= m - 1,
    terminal_majority_no_H_value = abs(W2_M - 1 / m) <= tol,
    R1_threshold_domain = a0_M >= -tol && a0_M < a1_M && a1_M <= ybar + tol,
    quota_bound = quota_bound,
    low_only_gap_identity = low_only_gap_identity_error <= tol,
    no_cheap_H_condition = no_cheap_H,
    no_H_uniform_iff_no_cheap_H = identical(
      no_H_uniformly_optimal_grid,
      no_H_uniformly_optimal_theorem
    ),
    pooling_H_not_cheaper = pooling_gap <= tol,
    low_only_H_not_profitable = max(low_only_H_value - no_H_value) <= tol,
    no_H_selected_all_mu = no_H_uniformly_optimal_grid
  )

  list(
    N = N,
    m = m,
    q = q,
    k = k,
    beta = beta,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    ybar = ybar,
    W2_M = W2_M,
    c_M = c_M,
    a0_M = a0_M,
    a1_M = a1_M,
    no_H_value = no_H_value,
    pooling_H_value = pooling_H_value,
    pooling_gap = pooling_gap,
    low_only_gap_identity_error = low_only_gap_identity_error,
    majority_H_screening_cutoff = majority_H_screening_cutoff,
    max_H_including_advantage = max_H_including_advantage,
    W1_M = 1 / m,
    checks = checks,
    values = values
  )
}

print_check <- function(objects, rows) {
  cat("Fixed-pie relative-package majority check under pi_H = 0\n")
  cat(sprintf(
    "N=%d, m=%d, q=%d, k=%d, beta=%.12f\n",
    objects$N, objects$m, objects$q, objects$k, objects$beta
  ))
  cat(sprintf(
    "W2_M=%.12f, c_M=%.12f, a0_M=%.12f, a1_M=%.12f\n",
    objects$W2_M, objects$c_M, objects$a0_M, objects$a1_M
  ))
  cat(sprintf(
    "R1 proposer no-H value=%.12f, W1_M=%.12f\n",
    objects$no_H_value, objects$W1_M
  ))
  cat(sprintf(
    "pooling H gap=%.12f, low-only gap identity error=%.3e\n",
    objects$pooling_gap, objects$low_only_gap_identity_error
  ))
  if (is.na(objects$majority_H_screening_cutoff)) {
    cat("majority H-screening cutoff: none because a0_M >= c_M\n")
  } else {
    cat(sprintf(
      "majority H-screening cutoff if a0_M < c_M: %.12f\n",
      objects$majority_H_screening_cutoff
    ))
  }
  cat("Domain, protocol, and no-screening checks:\n")
  print(objects$checks)
  cat(sprintf(
    "max H-including advantage over no-H = %.3e\n\n",
    objects$max_H_including_advantage
  ))
  print(objects$values[rows, ], row.names = FALSE, digits = 12)
}

assert_check <- function(objects, tol = 1e-9) {
  required <- c(
    "majority_quota_valid",
    "weak_majority_exists_without_H",
    "terminal_majority_no_H_value",
    "R1_threshold_domain",
    "quota_bound",
    "low_only_gap_identity",
    "no_cheap_H_condition",
    "no_H_uniform_iff_no_cheap_H",
    "pooling_H_not_cheaper",
    "low_only_H_not_profitable",
    "no_H_selected_all_mu"
  )

  failed <- required[!unlist(objects$checks[required])]
  if (length(failed) > 0) {
    stop(sprintf("Majority verification failed: %s", paste(failed, collapse = ", ")))
  }

  if (objects$max_H_including_advantage > tol) {
    stop("An H-including majority package beats the no-H package.")
  }

  invisible(TRUE)
}

params <- list(
  N = 13,
  beta = 0.9,
  d0 = 0.19,
  d1 = 0.285,
  b0 = 0,
  b1 = 0,
  ybar = 1
)

mu_grid <- sort(unique(c(seq(0, 1, length.out = 1001), 0, 0.5, 1)))

objects <- do.call(
  compute_relative_package_majority_piH0,
  c(params, list(mu_grid = mu_grid))
)

rows <- c(
  1,
  which.min(abs(objects$values$mu - 0.5)),
  nrow(objects$values)
)

print_check(objects, rows)
assert_check(objects)

cat("\nAll fixed-pie relative-package majority checks passed.\n")
