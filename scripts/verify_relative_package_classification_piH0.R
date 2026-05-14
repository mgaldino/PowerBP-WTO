#!/usr/bin/env Rscript

# Verifies the complete institutional classification for the fixed-pie
# relative-package pi_H = 0 baseline.

compute_relative_package_classification_piH0 <- function(N, beta, d0, d1, b0, b1,
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

  weak_total_pooling <- rep(1 - a1, length(mu_grid))
  weak_total_low_only <- (1 - mu_grid) * (1 - a0_high_posterior) +
    mu_grid * beta * p2(1)
  weak_total_rejection <- beta * p2(mu_grid)
  weak_total_matrix <- cbind(weak_total_pooling, weak_total_low_only, weak_total_rejection)
  selected_weak_total_U <- weak_total_matrix[cbind(seq_len(nrow(weak_total_matrix)), selected_index)]
  W1_U_entry <- selected_weak_total_U / m

  W1_M_entry <- 1 / m
  c_M <- beta / m
  a0_M <- beta * d0 - b0
  a1_M <- beta * d1 - b1
  H1_M_noH <- (1 - mu_grid) * d0 + mu_grid * d1
  H_gap <- selected_H_U - H1_M_noH

  quota_bound <- q * c_M <= 1 + tol
  majority_threshold_domain <- a0_M >= -tol && a0_M < a1_M &&
    a1_M <= ybar + tol
  no_cheap_H <- a0_M + tol >= c_M

  if (is.null(entry_cost_grid)) {
    entry_cost_grid <- sort(unique(c(
      0,
      min(W1_U_entry),
      max(W1_U_entry),
      (max(W1_U_entry) + W1_M_entry) / 2,
      W1_M_entry,
      W1_M_entry + max(1e-4, 0.1 * W1_M_entry)
    )))
  }
  stopifnot(all(entry_cost_grid >= 0))

  classify_one_cost <- function(entry_cost) {
    F_M <- rep(W1_M_entry + tol >= entry_cost, length(mu_grid))
    F_U <- W1_U_entry + tol >= entry_cost
    category <- ifelse(
      !F_M,
      "no_rule_forms",
      ifelse(
        !F_U,
        "only_majority_forms",
        ifelse(
          H_gap > tol,
          "both_form_H_prefers_unanimity",
          ifelse(
            H_gap < -tol,
            "both_form_H_prefers_majority",
            "both_form_H_indifferent"
          )
        )
      )
    )

    data.frame(
      entry_cost = entry_cost,
      mu = mu_grid,
      F_U = F_U,
      F_M = F_M,
      H_gap_U_minus_M = H_gap,
      category = category,
      stringsAsFactors = FALSE
    )
  }

  classification <- do.call(
    rbind,
    lapply(entry_cost_grid, classify_one_cost)
  )

  no_rule_def <- !classification$F_M
  only_majority_def <- classification$F_M & !classification$F_U
  both_def <- classification$F_M & classification$F_U
  H_pref_U_def <- both_def & classification$H_gap_U_minus_M > tol
  H_pref_M_def <- both_def & classification$H_gap_U_minus_M < -tol
  H_indiff_def <- both_def & abs(classification$H_gap_U_minus_M) <= tol

  definition_category <- ifelse(
    no_rule_def,
    "no_rule_forms",
    ifelse(
      only_majority_def,
      "only_majority_forms",
      ifelse(
        H_pref_U_def,
        "both_form_H_prefers_unanimity",
        ifelse(
          H_pref_M_def,
          "both_form_H_prefers_majority",
          "both_form_H_indifferent"
        )
      )
    )
  )

  by_cost <- split(classification, classification$entry_cost)
  F_M_formula_by_cost <- vapply(
    by_cost,
    function(dat) {
      entry_cost <- dat$entry_cost[1]
      all(dat$F_M == (entry_cost <= W1_M_entry + tol))
    },
    logical(1)
  )
  no_rule_formula_by_cost <- vapply(
    by_cost,
    function(dat) {
      entry_cost <- dat$entry_cost[1]
      if (entry_cost > W1_M_entry + tol) {
        all(dat$category == "no_rule_forms")
      } else {
        !any(dat$category == "no_rule_forms")
      }
    },
    logical(1)
  )

  weak_entry_ties_included <- vapply(
    entry_cost_grid,
    function(entry_cost) {
      tied <- abs(W1_U_entry - entry_cost) <= tol
      if (!any(tied)) {
        TRUE
      } else {
        dat <- classification[abs(classification$entry_cost - entry_cost) <= tol, ]
        all(dat$F_U[tied])
      }
    },
    logical(1)
  )

  majority_entry_ties_included <- vapply(
    entry_cost_grid,
    function(entry_cost) {
      if (abs(entry_cost - W1_M_entry) > tol) {
        TRUE
      } else {
        dat <- classification[abs(classification$entry_cost - entry_cost) <= tol, ]
        all(dat$F_M)
      }
    },
    logical(1)
  )

  selected_argmax_error <- max(abs(
    selected_prop_value -
      pmax(pooling_prop_value, low_only_prop_value, rejection_prop_value)
  ))
  weak_dominance_error <- max(W1_U_entry - W1_M_entry)

  base_values <- data.frame(
    mu = mu_grid,
    selected_candidate = selected_candidate,
    W1_U_entry = W1_U_entry,
    W1_M_entry = W1_M_entry,
    H1_U_selected = selected_H_U,
    H1_M_noH = H1_M_noH,
    H_gap_U_minus_M = H_gap,
    stringsAsFactors = FALSE
  )

  checks <- list(
    threshold_domain = threshold_domain,
    mu2_star_in_unit_interval = mu2_star > -tol && mu2_star <= 1 + tol,
    R1_high_threshold_domain = a1 >= -tol && a1 <= ybar + tol,
    R1_threshold_order_domain = R1_threshold_order_domain,
    selected_candidate_argmax = selected_argmax_error <= tol,
    selected_values_finite = all(is.finite(selected_prop_value)),
    majority_quota_valid = q >= 2 && q <= N,
    weak_majority_exists_without_H = k <= m - 1,
    majority_threshold_domain = majority_threshold_domain,
    quota_bound = quota_bound,
    no_cheap_H_condition = no_cheap_H,
    weak_payoff_M_weakly_dominates_U_grid = weak_dominance_error <= tol,
    F_U_subset_F_M_all_entry_costs_grid = all(!classification$F_U | classification$F_M),
    classification_matches_definitions = identical(classification$category, definition_category),
    F_M_formula_all_entry_costs = all(F_M_formula_by_cost),
    no_rule_formula_all_entry_costs = all(no_rule_formula_by_cost),
    weak_entry_ties_included = all(weak_entry_ties_included),
    majority_entry_ties_included = all(majority_entry_ties_included),
    H_indifference_ties_separated = all(
      classification$category[H_indiff_def] == "both_form_H_indifferent"
    )
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
    c_M = c_M,
    a1 = a1,
    a0_high_posterior = a0_high_posterior,
    a0_M = a0_M,
    a1_M = a1_M,
    W1_M_entry = W1_M_entry,
    min_W1_U_entry = min(W1_U_entry),
    max_W1_U_entry = max(W1_U_entry),
    min_weak_entry_gap = min(W1_M_entry - W1_U_entry),
    min_H_gap = min(H_gap),
    max_H_gap = max(H_gap),
    selected_argmax_error = selected_argmax_error,
    weak_dominance_error = weak_dominance_error,
    entry_cost_grid = entry_cost_grid,
    base_values = base_values,
    classification = classification,
    checks = checks
  )
}

summarise_runs <- function(dat, value_column) {
  runs <- rle(dat[[value_column]])
  ends <- cumsum(runs$lengths)
  starts <- c(1, head(ends, -1) + 1)
  data.frame(
    value = runs$values,
    mu_min = dat$mu[starts],
    mu_max = dat$mu[ends],
    rows = runs$lengths,
    stringsAsFactors = FALSE
  )
}

summarise_classification <- function(objects) {
  do.call(
    rbind,
    lapply(
      split(objects$classification, objects$classification$entry_cost),
      function(dat) {
        counts <- as.data.frame(table(dat$category), stringsAsFactors = FALSE)
        names(counts) <- c("category", "rows")
        counts$entry_cost <- dat$entry_cost[1]
        counts[, c("entry_cost", "category", "rows")]
      }
    )
  )
}

print_check <- function(label, objects) {
  cat("\n============================================================\n")
  cat(sprintf("Case: %s\n", label))
  cat("Fixed-pie relative-package institutional classification under pi_H = 0\n")
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
    "W1_M_entry=%.12f, W1_U_entry range=[%.12f, %.12f], min M-U gap=%.12f\n",
    objects$W1_M_entry, objects$min_W1_U_entry, objects$max_W1_U_entry,
    objects$min_weak_entry_gap
  ))
  cat(sprintf(
    "H gap range U-M=[%.12f, %.12f]\n",
    objects$min_H_gap, objects$max_H_gap
  ))
  cat("Checks:\n")
  print(objects$checks)
  cat(sprintf(
    "selected argmax error=%.3e, weak dominance error=%.3e\n",
    objects$selected_argmax_error, objects$weak_dominance_error
  ))
  cat("\nSelected unanimity candidate regions:\n")
  print(summarise_runs(objects$base_values, "selected_candidate"), row.names = FALSE, digits = 12)
  cat("\nClassification counts by entry cost:\n")
  print(summarise_classification(objects), row.names = FALSE, digits = 12)
}

assert_check <- function(objects, tol = 1e-9) {
  required <- c(
    "threshold_domain",
    "mu2_star_in_unit_interval",
    "R1_high_threshold_domain",
    "R1_threshold_order_domain",
    "selected_candidate_argmax",
    "selected_values_finite",
    "majority_quota_valid",
    "weak_majority_exists_without_H",
    "majority_threshold_domain",
    "quota_bound",
    "no_cheap_H_condition",
    "weak_payoff_M_weakly_dominates_U_grid",
    "F_U_subset_F_M_all_entry_costs_grid",
    "classification_matches_definitions",
    "F_M_formula_all_entry_costs",
    "no_rule_formula_all_entry_costs",
    "weak_entry_ties_included",
    "majority_entry_ties_included",
    "H_indifference_ties_separated"
  )

  failed <- required[!unlist(objects$checks[required])]
  if (length(failed) > 0) {
    stop(sprintf("Classification verification failed: %s", paste(failed, collapse = ", ")))
  }

  if (objects$weak_dominance_error > tol) {
    stop("A unanimity entry payoff exceeds the majority entry payoff.")
  }

  invisible(TRUE)
}

assert_calibration_closed_form <- function(objects, tol = 1e-9) {
  expected_W_U <- (1 - 0.2565) / 12
  expected_W_M <- 1 / 12
  expected_gap <- 0.0665 - 0.095 * objects$base_values$mu
  if (max(abs(objects$base_values$W1_U_entry - expected_W_U)) > tol) {
    stop("Calibration W_U entry payoff does not match closed-form value.")
  }
  if (abs(objects$W1_M_entry - expected_W_M) > tol) {
    stop("Calibration W_M entry payoff does not match 1/m.")
  }
  if (max(abs(objects$base_values$H_gap_U_minus_M - expected_gap)) > tol) {
    stop("Calibration H gap does not match 0.0665 - 0.095 mu.")
  }

  mu_tie <- 0.7
  row <- which(abs(objects$classification$mu - mu_tie) <= tol &
                 abs(objects$classification$entry_cost) <= tol)
  if (length(row) < 1 ||
      !all(objects$classification$category[row] == "both_form_H_indifferent")) {
    stop("Calibration H tie at mu = 0.7 was not classified as indifference.")
  }

  entry_mid <- (expected_W_U + expected_W_M) / 2
  mid_rows <- abs(objects$classification$entry_cost - entry_mid) <= tol
  if (!all(objects$classification$category[mid_rows] == "only_majority_forms")) {
    stop("Calibration middle entry-cost region should classify as only majority forms.")
  }

  high_rows <- objects$classification$entry_cost > expected_W_M + tol
  if (!all(objects$classification$category[high_rows] == "no_rule_forms")) {
    stop("Calibration entry costs above 1/m should classify as no rule forms.")
  }

  invisible(TRUE)
}

run_case <- function(label, params, calibration_closed_form = FALSE) {
  tau0 <- params$d0 - params$b0
  tau1 <- params$d1 - params$b1
  mu2_star <- (tau1 - tau0) / (1 - tau0)
  m <- params$N - 1
  beta <- params$beta
  d0 <- params$d0
  d1 <- params$d1
  b0 <- params$b0
  b1 <- params$b1
  ybar <- params$ybar

  base_grid <- seq(0, 1, length.out = 5001)

  # Include analytically important roots and boundaries when available.
  mu_grid <- sort(unique(round(c(base_grid, mu2_star, 0, 0.5, 0.7, 1), 12)))

  provisional <- compute_relative_package_classification_piH0(
    N = params$N,
    beta = beta,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    ybar = ybar,
    mu_grid = mu_grid
  )

  entry_cost_grid <- sort(unique(c(
    0,
    provisional$min_W1_U_entry,
    provisional$max_W1_U_entry,
    (provisional$max_W1_U_entry + 1 / m) / 2,
    1 / m,
    1 / m + max(1e-4, 0.1 / m)
  )))

  objects <- compute_relative_package_classification_piH0(
    N = params$N,
    beta = beta,
    d0 = d0,
    d1 = d1,
    b0 = b0,
    b1 = b1,
    ybar = ybar,
    mu_grid = mu_grid,
    entry_cost_grid = entry_cost_grid
  )

  print_check(label, objects)
  assert_check(objects)
  if (calibration_closed_form) {
    assert_calibration_closed_form(objects)
  }
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

invisible(run_case(
  "calibration_equal_threshold",
  cases$calibration_equal_threshold,
  calibration_closed_form = TRUE
))
invisible(run_case("strict_low_only_available", cases$strict_low_only_available))
invisible(run_case("no_cheap_H_boundary", cases$no_cheap_H_boundary))
invisible(run_case("tau1_equals_ybar_boundary", cases$tau1_equals_ybar_boundary))
invisible(run_case("beta_one_boundary", cases$beta_one_boundary))

cat("\nAll fixed-pie relative-package institutional classification checks passed.\n")
