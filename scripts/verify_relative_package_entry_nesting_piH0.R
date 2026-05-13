#!/usr/bin/env Rscript

# Verifies weak-state entry/nesting and conditional institutional comparison
# under the fixed-pie relative-package pi_H = 0 baseline.

compute_relative_package_entry_nesting_piH0 <- function(N, beta, d0, d1, b0, b1,
                                                        ybar = 1,
                                                        mu_grid = seq(0, 1, length.out = 5001),
                                                        entry_cost_grid = NULL,
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

  tau0 <- d0 - b0
  tau1 <- d1 - b1

  threshold_domain <- tau0 >= -tol && tau0 + tol < tau1 &&
    tau1 <= ybar + tol && ybar <= 1 + tol
  if (!threshold_domain) {
    stop("Terminal threshold domain fails: need 0 <= tau0 < tau1 <= ybar <= 1.")
  }

  mu2_star <- (tau1 - tau0) / (1 - tau0)

  low_r2_selected <- function(mu) mu <= mu2_star + tol
  p2_low <- function(mu) (1 - mu) * (1 - tau0)
  p2_pool <- function(mu) rep(1 - tau1, length(mu))
  p2 <- function(mu) ifelse(low_r2_selected(mu), p2_low(mu), p2_pool(mu))
  W2_U <- function(mu) p2(mu) / m
  cU <- function(mu) beta * W2_U(mu)
  D0 <- function(mu) ifelse(low_r2_selected(mu), d0, d0 + tau1 - tau0)
  D1 <- function(mu) rep(d1, length(mu))

  c_mu <- cU(mu_grid)
  c0 <- cU(0)
  c1 <- cU(1)

  a1 <- beta * d1 - b1
  a0_high_posterior <- beta * D0(1) - b0
  R1_threshold_order_domain <- a0_high_posterior >= -tol &&
    a0_high_posterior <= a1 + tol &&
    a1 <= ybar + tol

  pooling_domain <- a1 >= -tol && a1 <= ybar + tol &&
    a1 + tol >= a0_high_posterior
  pooling_feasible <- pooling_domain & (a1 + (m - 1) * c_mu <= 1 + tol)

  low_only_feasible <- a0_high_posterior >= -tol &&
    a0_high_posterior <= ybar + tol &&
    a0_high_posterior + (m - 1) * c0 <= 1 + tol &&
    a0_high_posterior + tol < a1

  rejection_feasible <- (a1 >= -tol && a1 <= ybar + tol) & (c_mu > tol)

  pooling_prop_raw <- 1 - a1 - (m - 1) * c_mu
  low_only_prop_raw <- (1 - mu_grid) *
    (1 - a0_high_posterior - (m - 1) * c0) + mu_grid * c1
  rejection_prop_raw <- c_mu

  pooling_prop_value <- ifelse(pooling_feasible, pooling_prop_raw, -Inf)
  low_only_prop_value <- if (low_only_feasible) {
    low_only_prop_raw
  } else {
    rep(-Inf, length(mu_grid))
  }
  rejection_prop_value <- ifelse(rejection_feasible, rejection_prop_raw, -Inf)

  H_pooling <- (1 - mu_grid) * (a1 + b0) + mu_grid * (a1 + b1)
  H_low_only <- (1 - mu_grid) * (a0_high_posterior + b0) + mu_grid * beta * d1
  H_rejection <- (1 - mu_grid) * beta * D0(mu_grid) + mu_grid * beta * d1

  prop_value_matrix <- cbind(pooling_prop_value, low_only_prop_value, rejection_prop_value)
  H_matrix <- cbind(H_pooling, H_low_only, H_rejection)
  candidate_names <- c("pooling", "low_only", "rejection")
  best_prop_value <- pmax(pooling_prop_value, low_only_prop_value, rejection_prop_value)

  select_candidate <- function(values, H_values) {
    best <- max(values)
    argmax <- which(values >= best - tol)
    argmax[which.min(H_values[argmax])]
  }

  selected_index <- vapply(
    seq_len(nrow(prop_value_matrix)),
    function(i) select_candidate(prop_value_matrix[i, ], H_matrix[i, ]),
    integer(1)
  )
  selected_candidate <- candidate_names[selected_index]
  selected_prop_value <- prop_value_matrix[cbind(seq_len(nrow(prop_value_matrix)), selected_index)]
  selected_H_U <- H_matrix[cbind(seq_len(nrow(H_matrix)), selected_index)]

  # Entry is collective, so the relevant weak payoff includes proposer residuals
  # and non-proposing weak voters' equilibrium payments.
  weak_total_pooling <- rep(1 - a1, length(mu_grid))
  weak_total_low_only <- (1 - mu_grid) * (1 - a0_high_posterior) +
    mu_grid * beta * p2(1)
  weak_total_rejection <- beta * p2(mu_grid)
  weak_total_matrix <- cbind(weak_total_pooling, weak_total_low_only, weak_total_rejection)
  selected_weak_total_U <- weak_total_matrix[cbind(seq_len(nrow(weak_total_matrix)), selected_index)]

  W1_U_entry <- selected_weak_total_U / m
  W1_U_proposer_component <- selected_prop_value / m

  W2_M <- 1 / m
  c_M <- beta * W2_M
  a0_M <- beta * d0 - b0
  a1_M <- beta * d1 - b1
  no_H_majority_prop_value <- 1 - k * c_M
  W1_M_entry <- 1 / m
  H1_M_noH <- (1 - mu_grid) * d0 + mu_grid * d1

  pooling_H_value_M <- 1 - a1_M - (k - 1) * c_M
  low_only_H_value_M <- (1 - mu_grid) * (1 - a0_M - (k - 1) * c_M) +
    mu_grid * c_M
  no_cheap_H <- a0_M + tol >= c_M
  quota_bound <- (k + 1) * c_M <= 1 + tol
  majority_threshold_domain <- a0_M >= -tol && a0_M < a1_M &&
    a1_M <= ybar + tol

  if (is.null(entry_cost_grid)) {
    entry_cost_grid <- seq(0, 1.25 * max(W1_M_entry, max(W1_U_entry)), length.out = 501)
  }
  stopifnot(all(entry_cost_grid >= 0))

  entry_nesting_by_cost <- vapply(
    entry_cost_grid,
    function(entry_cost) {
      F_U <- W1_U_entry + tol >= entry_cost
      F_M <- W1_M_entry + tol >= entry_cost
      all(!F_U | F_M)
    },
    logical(1)
  )

  majority_set_formula_by_cost <- vapply(
    entry_cost_grid,
    function(entry_cost) {
      F_M <- W1_M_entry + tol >= entry_cost
      all(F_M) == (entry_cost <= W1_M_entry + tol)
    },
    logical(1)
  )

  weak_candidate_upper_bound_error <- max(weak_total_matrix - 1)
  weak_candidate_lower_bound_error <- min(weak_total_matrix)
  selected_argmax_error <- max(abs(selected_prop_value - best_prop_value))
  weak_dominance_error <- max(W1_U_entry - W1_M_entry)
  proposer_component_le_entry_error <- max(W1_U_proposer_component - W1_U_entry)
  H_gap <- selected_H_U - H1_M_noH

  values <- data.frame(
    mu = mu_grid,
    selected_candidate = selected_candidate,
    proposer_value_U = selected_prop_value,
    W1_U_proposer_component = W1_U_proposer_component,
    weak_total_U = selected_weak_total_U,
    W1_U_entry = W1_U_entry,
    W1_M_entry = W1_M_entry,
    weak_entry_gap_M_minus_U = W1_M_entry - W1_U_entry,
    H1_U_selected = selected_H_U,
    H1_M_noH = H1_M_noH,
    H_gap_U_minus_M = H_gap,
    weak_total_pooling = weak_total_pooling,
    weak_total_low_only = weak_total_low_only,
    weak_total_rejection = weak_total_rejection
  )

  checks <- list(
    threshold_domain = threshold_domain,
    mu2_star_in_unit_interval = mu2_star > -tol && mu2_star <= 1 + tol,
    R1_high_threshold_domain = a1 >= -tol && a1 <= ybar + tol,
    R1_threshold_order_domain = R1_threshold_order_domain,
    selected_candidate_argmax = selected_argmax_error <= tol,
    selected_values_finite = all(is.finite(selected_prop_value)),
    weak_candidate_totals_nonnegative = weak_candidate_lower_bound_error >= -tol,
    weak_candidate_totals_bounded_by_one = weak_candidate_upper_bound_error <= tol,
    proposer_component_not_above_entry_payoff = proposer_component_le_entry_error <= tol,
    majority_quota_valid = q >= 2 && q <= N,
    weak_majority_exists_without_H = k <= m - 1,
    majority_threshold_domain = majority_threshold_domain,
    quota_bound = quota_bound,
    no_cheap_H_condition = no_cheap_H,
    no_H_majority_weak_value = abs(W1_M_entry - 1 / m) <= tol,
    weak_payoff_M_weakly_dominates_U_grid = weak_dominance_error <= tol,
    majority_entry_set_formula_grid = all(majority_set_formula_by_cost),
    F_U_subset_F_M_all_entry_costs_grid = all(entry_nesting_by_cost)
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
    tau0 = tau0,
    tau1 = tau1,
    mu2_star = mu2_star,
    c0 = c0,
    c1 = c1,
    a1 = a1,
    a0_high_posterior = a0_high_posterior,
    c_M = c_M,
    a0_M = a0_M,
    a1_M = a1_M,
    no_H_majority_prop_value = no_H_majority_prop_value,
    pooling_H_value_M = pooling_H_value_M,
    max_low_only_H_value_M = max(low_only_H_value_M),
    W1_M_entry = W1_M_entry,
    max_W1_U_entry = max(W1_U_entry),
    min_weak_entry_gap = min(W1_M_entry - W1_U_entry),
    min_H_gap = min(H_gap),
    max_H_gap = max(H_gap),
    selected_argmax_error = selected_argmax_error,
    weak_candidate_upper_bound_error = weak_candidate_upper_bound_error,
    weak_candidate_lower_bound_error = weak_candidate_lower_bound_error,
    weak_dominance_error = weak_dominance_error,
    proposer_component_le_entry_error = proposer_component_le_entry_error,
    entry_cost_grid = entry_cost_grid,
    entry_nesting_by_cost = entry_nesting_by_cost,
    majority_set_formula_by_cost = majority_set_formula_by_cost,
    checks = checks,
    values = values
  )
}

summarise_regions <- function(values, column) {
  runs <- rle(values[[column]])
  ends <- cumsum(runs$lengths)
  starts <- c(1, head(ends, -1) + 1)
  data.frame(
    value = runs$values,
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
  cat("Fixed-pie relative-package entry/nesting check under pi_H = 0\n")
  cat(sprintf(
    "N=%d, m=%d, q=%d, k=%d, beta=%.12f\n",
    objects$N, objects$m, objects$q, objects$k, objects$beta
  ))
  cat(sprintf(
    "tau0=%.12f, tau1=%.12f, mu2_star=%.12f\n",
    objects$tau0, objects$tau1, objects$mu2_star
  ))
  cat(sprintf(
    "a0_high_posterior=%.12f, a1=%.12f, c_M=%.12f, a0_M=%.12f\n",
    objects$a0_high_posterior, objects$a1, objects$c_M, objects$a0_M
  ))
  cat(sprintf(
    "W1_M_entry=%.12f, max W1_U_entry=%.12f, min M-U gap=%.12f\n",
    objects$W1_M_entry, objects$max_W1_U_entry, objects$min_weak_entry_gap
  ))
  cat(sprintf(
    "H gap range U-M: [%.12f, %.12f]\n",
    objects$min_H_gap, objects$max_H_gap
  ))
  cat("Domain, nesting, and comparison checks:\n")
  print(objects$checks)
  cat(sprintf(
    "selected argmax error=%.3e, weak dominance error=%.3e, candidate upper-bound error=%.3e\n",
    objects$selected_argmax_error,
    objects$weak_dominance_error,
    objects$weak_candidate_upper_bound_error
  ))
  cat("\nSelected unanimity candidate regions:\n")
  print(summarise_regions(objects$values, "selected_candidate"), row.names = FALSE, digits = 12)
  cat("\nH prefers unanimity on grid:\n")
  h_pref <- objects$values
  h_pref$H_prefers_U <- h_pref$H_gap_U_minus_M >= -1e-10
  print(summarise_regions(h_pref, "H_prefers_U"), row.names = FALSE, digits = 12)
  cat("\nBoundary rows:\n")
  print(objects$values[boundary_rows(objects), ], row.names = FALSE, digits = 12)
}

assert_check <- function(objects, require_no_cheap_H = TRUE, tol = 1e-9) {
  required <- c(
    "threshold_domain",
    "mu2_star_in_unit_interval",
    "R1_high_threshold_domain",
    "R1_threshold_order_domain",
    "selected_candidate_argmax",
    "selected_values_finite",
    "weak_candidate_totals_nonnegative",
    "weak_candidate_totals_bounded_by_one",
    "proposer_component_not_above_entry_payoff",
    "majority_quota_valid",
    "weak_majority_exists_without_H",
    "majority_threshold_domain",
    "quota_bound",
    "no_H_majority_weak_value",
    "weak_payoff_M_weakly_dominates_U_grid",
    "majority_entry_set_formula_grid",
    "F_U_subset_F_M_all_entry_costs_grid"
  )

  if (require_no_cheap_H) {
    required <- c(required, "no_cheap_H_condition")
  }

  failed <- required[!unlist(objects$checks[required])]
  if (length(failed) > 0) {
    stop(sprintf("Entry/nesting verification failed: %s", paste(failed, collapse = ", ")))
  }

  if (objects$weak_dominance_error > tol) {
    stop("A selected unanimity weak entry payoff exceeds majority.")
  }

  invisible(TRUE)
}

run_case <- function(label, params, require_no_cheap_H = TRUE) {
  tau0 <- params$d0 - params$b0
  tau1 <- params$d1 - params$b1
  mu2_star <- (tau1 - tau0) / (1 - tau0)
  mu_grid <- sort(unique(c(seq(0, 1, length.out = 5001), mu2_star, 0, 0.5, 1)))
  entry_cost_grid <- sort(unique(c(
    seq(0, 0.15, length.out = 501),
    1 / (params$N - 1),
    0
  )))

  objects <- do.call(
    compute_relative_package_entry_nesting_piH0,
    c(params, list(mu_grid = mu_grid, entry_cost_grid = entry_cost_grid))
  )

  print_check(label, objects)
  assert_check(objects, require_no_cheap_H = require_no_cheap_H)
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
  no_cheap_H_boundary = list(
    N = 13,
    beta = 0.9,
    d0 = 1 / 12,
    d1 = 0.25,
    b0 = 0,
    b1 = 0,
    ybar = 1
  ),
  tau1_equals_ybar_boundary = list(
    N = 5,
    beta = 0.8,
    d0 = 0.3,
    d1 = 1,
    b0 = 0,
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

cat("\nAll fixed-pie relative-package entry/nesting checks passed.\n")
