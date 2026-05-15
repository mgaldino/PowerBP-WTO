#!/usr/bin/env Rscript

# Verifies Round-1 unanimity under the fixed-pie relative-package pi_H = 0
# baseline with simultaneous public voting.

compute_relative_package_R1_piH0 <- function(N, beta, d0, d1, b0, b1,
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
  tau0 <- d0 - b0
  tau1 <- d1 - b1

  threshold_domain <- tau0 >= -tol && tau0 + tol < tau1 &&
    tau1 <= ybar + tol && ybar <= 1 + tol
  if (!threshold_domain) {
    stop("Terminal threshold domain fails: need 0 <= tau0 < tau1 <= ybar <= 1.")
  }

  mu2_star <- (tau1 - tau0) / (1 - tau0)
  high_posterior_pooling <- mu2_star < 1 - tol

  low_r2_selected <- function(mu) mu <= mu2_star + tol
  p2_low <- function(mu) (1 - mu) * (1 - tau0)
  p2_pool <- function(mu) rep(1 - tau1, length(mu))
  p2 <- function(mu) ifelse(low_r2_selected(mu), p2_low(mu), p2_pool(mu))
  W2 <- function(mu) p2(mu) / m
  cW <- function(mu) beta * W2(mu)
  D0 <- function(mu) ifelse(low_r2_selected(mu), d0, d0 + tau1 - tau0)
  D1 <- function(mu) rep(d1, length(mu))

  c_mu <- cW(mu_grid)
  c0 <- cW(0)
  c1 <- cW(1)

  a1 <- beta * d1 - b1
  a0_high_posterior <- beta * D0(1) - b0

  pooling_domain <- a1 >= -tol && a1 <= ybar + tol &&
    a1 + tol >= a0_high_posterior
  pooling_feasible <- pooling_domain & (a1 + (m - 1) * c_mu <= 1 + tol)

  low_only_feasible <- a0_high_posterior >= -tol &&
    a0_high_posterior <= ybar + tol &&
    a0_high_posterior + (m - 1) * c0 <= 1 + tol &&
    a0_high_posterior + tol < a1

  rejection_feasible <- rep(TRUE, length(mu_grid))

  pooling_raw <- 1 - a1 - (m - 1) * c_mu
  low_only_raw <- (1 - mu_grid) *
    (1 - a0_high_posterior - (m - 1) * c0) + mu_grid * c1
  rejection_raw <- c_mu

  pooling_value <- ifelse(pooling_feasible, pooling_raw, -Inf)
  low_only_value <- if (low_only_feasible) low_only_raw else rep(-Inf, length(mu_grid))
  rejection_value <- ifelse(rejection_feasible, rejection_raw, -Inf)

  H_pooling <- (1 - mu_grid) * (a1 + b0) + mu_grid * (a1 + b1)
  H_low_only <- (1 - mu_grid) * (a0_high_posterior + b0) + mu_grid * beta * d1
  H_rejection <- (1 - mu_grid) * beta * D0(mu_grid) + mu_grid * beta * d1

  best_value <- pmax(pooling_value, low_only_value, rejection_value)
  select_candidate <- function(values, H_values) {
    best <- max(values)
    argmax <- which(values >= best - tol)
    argmax[which.min(H_values[argmax])]
  }

  candidate_names <- c("pooling", "low_only", "rejection")
  value_matrix <- cbind(pooling_value, low_only_value, rejection_value)
  H_matrix <- cbind(H_pooling, H_low_only, H_rejection)
  selected_index <- vapply(
    seq_len(nrow(value_matrix)),
    function(i) select_candidate(value_matrix[i, ], H_matrix[i, ]),
    integer(1)
  )
  selected <- candidate_names[selected_index]
  selected_H_payoff <- H_matrix[cbind(seq_len(nrow(H_matrix)), selected_index)]

  r2_identity_error <- max(abs(p2(mu_grid) - pmax(p2_low(mu_grid), p2_pool(mu_grid))))
  selected_identity_error <- max(abs(best_value - pmax(pooling_value, low_only_value, rejection_value)))

  pooling_H_high_error <- abs((a1 + b1) - beta * D1(1))
  pooling_H_low_slack <- (a1 + b0) - beta * D0(1)
  low_H_low_error <- abs((a0_high_posterior + b0) - beta * D0(1))
  low_H_high_reject_slack <- beta * D1(1) - (a0_high_posterior + b1)

  pooling_weak_ic_error <- max(abs(c_mu - cW(mu_grid)))
  low_weak_yes <- (1 - mu_grid) * c0 + mu_grid * c1
  low_weak_no <- (1 - mu_grid) * cW(0) + mu_grid * cW(1)
  low_weak_ic_error <- max(abs(low_weak_yes - low_weak_no))
  rejection_identity_error <- max(abs(rejection_raw - c_mu))
  informative_rejection_gain <- (1 - mu_grid) * c0 + mu_grid * c1 - c_mu

  selected_value <- value_matrix[cbind(seq_len(nrow(value_matrix)), selected_index)]
  selected_argmax_error <- max(abs(selected_value - best_value))
  tie_break_errors <- vapply(
    seq_len(nrow(value_matrix)),
    function(i) {
      argmax <- which(value_matrix[i, ] >= best_value[i] - tol)
      selected_H_payoff[i] - min(H_matrix[i, argmax])
    },
    numeric(1)
  )
  max_tie_break_error <- max(tie_break_errors)

  values <- data.frame(
    mu = mu_grid,
    c_mu = c_mu,
    pooling_raw = pooling_raw,
    low_only_raw = low_only_raw,
    rejection_raw = rejection_raw,
    pooling_value = pooling_value,
    low_only_value = low_only_value,
    rejection_value = rejection_value,
    best_value = best_value,
    W1_unanimity = best_value / m,
    H_pooling = H_pooling,
    H_low_only = H_low_only,
    H_rejection = H_rejection,
    selected_H_payoff = selected_H_payoff,
    informative_rejection_gain = informative_rejection_gain,
    selected_candidate = selected
  )

  checks <- list(
    threshold_domain = threshold_domain,
    mu2_star_in_unit_interval = mu2_star > -tol && mu2_star <= 1 + tol,
    high_posterior_pooling = high_posterior_pooling,
    R1_high_threshold_domain = a1 >= -tol && a1 <= ybar + tol,
    R1_strict_low_only_available = low_only_feasible,
    pooling_available_somewhere = any(pooling_feasible),
    rejection_available_somewhere = any(rejection_feasible),
    R2_value_identity = r2_identity_error <= tol,
    selected_value_identity = selected_identity_error <= tol,
    selected_candidate_argmax = selected_argmax_error <= tol,
    tie_break_minimizes_H_payoff = max_tie_break_error <= tol,
    pooling_H_high_constraint = pooling_H_high_error <= tol,
    pooling_H_low_constraint = pooling_H_low_slack >= -tol,
    low_only_H_low_constraint = low_H_low_error <= tol,
    low_only_H_high_rejection = if (low_only_feasible) low_H_high_reject_slack > tol else TRUE,
    pooling_weak_voter_constraint = pooling_weak_ic_error <= tol,
    low_only_weak_voter_constraint = low_weak_ic_error <= tol,
    rejection_payoff_identity = rejection_identity_error <= tol,
    informative_rejection_no_strict_gain_when_IC = all(
      informative_rejection_gain <= tol | abs(D0(1) - D0(0)) > tol
    ),
    finite_selected_values = all(is.finite(best_value))
  )

  list(
    N = N,
    m = m,
    beta = beta,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    ybar = ybar,
    tau0 = tau0,
    tau1 = tau1,
    mu2_star = mu2_star,
    c0 = c0,
    c1 = c1,
    a1 = a1,
    a0_high_posterior = a0_high_posterior,
    pooling_feasible_grid = pooling_feasible,
    low_only_feasible = low_only_feasible,
    rejection_feasible = rejection_feasible,
    pooling_H_low_slack = pooling_H_low_slack,
    low_H_high_reject_slack = low_H_high_reject_slack,
    max_informative_rejection_gain = max(informative_rejection_gain),
    r2_identity_error = r2_identity_error,
    selected_identity_error = selected_identity_error,
    selected_argmax_error = selected_argmax_error,
    max_tie_break_error = max_tie_break_error,
    low_weak_ic_error = low_weak_ic_error,
    checks = checks,
    values = values
  )
}

summarise_regions <- function(values) {
  runs <- rle(values$selected_candidate)
  ends <- cumsum(runs$lengths)
  starts <- c(1, head(ends, -1) + 1)
  data.frame(
    selected_candidate = runs$values,
    mu_min = values$mu[starts],
    mu_max = values$mu[ends],
    rows = runs$lengths
  )
}

boundary_rows <- function(objects) {
  targets <- sort(unique(c(0, objects$mu2_star, 0.5, 1)))
  unique(vapply(
    targets,
    function(x) which.min(abs(objects$values$mu - x)),
    integer(1)
  ))
}

print_check <- function(label, objects) {
  cat("\n============================================================\n")
  cat(sprintf("Case: %s\n", label))
  cat("Fixed-pie relative-package R1 unanimity check under pi_H = 0\n")
  cat(sprintf(
    "N=%d, m=%d, beta=%.12f, tau0=%.12f, tau1=%.12f, mu2_star=%.12f\n",
    objects$N, objects$m, objects$beta, objects$tau0, objects$tau1,
    objects$mu2_star
  ))
  cat(sprintf(
    "c0=%.12f, c1=%.12f, a0_high_posterior=%.12f, a1=%.12f\n",
    objects$c0, objects$c1, objects$a0_high_posterior, objects$a1
  ))
  cat(sprintf(
    "pooling low-type slack=%.12f, low-only high-rejection slack=%.12f\n",
    objects$pooling_H_low_slack, objects$low_H_high_reject_slack
  ))
  cat(sprintf(
    "max informative-rejection continuation gain=%.12f\n",
    objects$max_informative_rejection_gain
  ))
  cat("Domain, IC, posterior-payoff, and value-identity checks:\n")
  print(objects$checks)
  cat(sprintf(
    "R2 identity error=%.3e, selected identity error=%.3e, selected argmax error=%.3e\n",
    objects$r2_identity_error, objects$selected_identity_error,
    objects$selected_argmax_error
  ))
  cat(sprintf(
    "tie-break error=%.3e, low weak IC error=%.3e\n",
    objects$max_tie_break_error, objects$low_weak_ic_error
  ))
  cat("\nSelected candidate regions on the grid:\n")
  print(summarise_regions(objects$values), row.names = FALSE, digits = 12)
  cat("\nBoundary rows:\n")
  print(objects$values[boundary_rows(objects), ], row.names = FALSE, digits = 12)
}

assert_check <- function(objects, tol = 1e-9) {
  required <- c(
    "threshold_domain",
    "mu2_star_in_unit_interval",
    "high_posterior_pooling",
    "R1_high_threshold_domain",
    "rejection_available_somewhere",
    "R2_value_identity",
    "selected_value_identity",
    "selected_candidate_argmax",
    "tie_break_minimizes_H_payoff",
    "pooling_H_high_constraint",
    "pooling_H_low_constraint",
    "low_only_H_low_constraint",
    "low_only_H_high_rejection",
    "pooling_weak_voter_constraint",
    "low_only_weak_voter_constraint",
    "rejection_payoff_identity",
    "informative_rejection_no_strict_gain_when_IC",
    "finite_selected_values"
  )

  failed <- required[!unlist(objects$checks[required])]
  if (length(failed) > 0) {
    stop(sprintf("R1 verification failed: %s", paste(failed, collapse = ", ")))
  }

  if (objects$selected_identity_error > tol) {
    stop("Selected candidate value does not equal max candidate value.")
  }

  invisible(TRUE)
}

run_case <- function(label, params) {
  base_grid <- seq(0, 1, length.out = 1001)
  tau0 <- params$d0 - params$b0
  tau1 <- params$d1 - params$b1
  mu2_star <- (tau1 - tau0) / (1 - tau0)
  mu_grid <- sort(unique(c(base_grid, mu2_star, 0, 0.5, 1)))

  objects <- do.call(
    compute_relative_package_R1_piH0,
    c(params, list(mu_grid = mu_grid))
  )

  print_check(label, objects)
  assert_check(objects)
  invisible(objects)
}

cases <- list(
  calibration_equal_threshold = list(
    N = 13,
    beta = 0.9,
    d0 = 0.19,
    d1 = 0.285,
    b0 = 0,
    b1 = 0,
    ybar = 1
  ),
  strict_low_only_available = list(
    N = 13,
    beta = 0.9,
    d0 = 0.19,
    d1 = 0.285,
    b0 = 0.03,
    b1 = 0,
    ybar = 1
  ),
  beta_one_boundary = list(
    N = 5,
    beta = 1,
    d0 = 0.3,
    d1 = 0.5,
    b0 = 0,
    b1 = 0,
    ybar = 1
  )
)

invisible(Map(run_case, names(cases), cases))

cat("\nAll fixed-pie relative-package R1 unanimity checks passed.\n")
