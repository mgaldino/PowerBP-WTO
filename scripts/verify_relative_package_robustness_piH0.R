#!/usr/bin/env Rscript

# Generates robustness windows and diagnostic examples for the fixed-pie
# relative-package pi_H = 0 baseline. The script writes CSV files under
# tables/ and prints compact summaries for audit.

options(scipen = 999)

if (requireNamespace("here", quietly = TRUE)) {
  repo_root <- here::here()
} else {
  repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}

project_sentinels <- file.path(
  repo_root,
  c("formal_model_v5.Rmd", "scripts/verify_relative_package_R1_piH0.R")
)
if (!all(file.exists(project_sentinels))) {
  stop("Run from the PowerBayesianPersuasion repository root or a here::here()-recognized subdirectory.")
}

tables_dir <- file.path(repo_root, "tables")
dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)

tol <- 1e-10

round6 <- function(x) round(x, 6)

p2_value <- function(mu, t0, t1) {
  mu2 <- (t1 - t0) / (1 - t0)
  ifelse(mu <= mu2 + tol, (1 - mu) * (1 - t0), 1 - t1)
}

candidate_runs <- function(selected, mu_grid) {
  runs <- rle(selected)
  ends <- cumsum(runs$lengths)
  starts <- c(1, head(ends, -1) + 1)
  data.frame(
    candidate = runs$values,
    mu_min = mu_grid[starts],
    mu_max = mu_grid[ends],
    rows = runs$lengths,
    stringsAsFactors = FALSE
  )
}

compute_case <- function(N = 13, beta = 0.9, t0 = 0.19, t1 = 0.285,
                         o0 = t0, o1 = t1, ybar = 1,
                         mu_grid = seq(0, 1, length.out = 5001)) {
  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1

  valid_threshold <- is.finite(t0) && is.finite(t1) && is.finite(o0) &&
    is.finite(o1) && is.finite(beta) && is.finite(ybar) &&
    N >= 3 && beta > 0 && beta <= 1 &&
    t0 >= -tol && t0 + tol < t1 && t1 <= ybar + tol && ybar <= 1 + tol
  if (!valid_threshold) {
    return(list(valid = FALSE))
  }

  mu2 <- (t1 - t0) / (1 - t0)
  high_posterior_pooling <- mu2 < 1 - tol
  if (!high_posterior_pooling) {
    return(list(valid = FALSE))
  }

  p2 <- function(mu) p2_value(mu, t0, t1)
  c_u <- function(mu) beta * p2(mu) / m
  C0 <- function(mu) ifelse(mu <= mu2 + tol, o0, o0 + t1 - t0)
  C1 <- function(mu) rep(o1, length(mu))

  c_mu <- c_u(mu_grid)
  c0 <- c_u(0)
  c1 <- c_u(1)
  a1 <- t1 - (1 - beta) * o1
  a0_1 <- t0 - o0 + beta * (o0 + t1 - t0)
  a0_M <- t0 - (1 - beta) * o0
  a1_M <- t1 - (1 - beta) * o1

  r1_order <- a0_1 >= -tol && a0_1 <= a1 + tol && a1 <= ybar + tol
  majority_order <- a0_M >= -tol && a0_M < a1_M + tol && a1_M <= ybar + tol
  no_cheap_H <- a0_M + tol >= beta / m

  pooling_feasible <- r1_order && (a1 + (m - 1) * max(c_mu) <= 1 + tol)
  low_feasible <- a0_1 >= -tol && a0_1 <= ybar + tol &&
    a0_1 + (m - 1) * c0 <= 1 + tol && a0_1 + tol < a1

  pi_P <- if (pooling_feasible) 1 - a1 - (m - 1) * c_mu else rep(-Inf, length(mu_grid))
  pi_L <- if (low_feasible) {
    (1 - mu_grid) * (1 - a0_1 - (m - 1) * c0) + mu_grid * c1
  } else {
    rep(-Inf, length(mu_grid))
  }
  pi_R <- c_mu

  H_P <- (1 - mu_grid) * (o0 + a1 - t0) + mu_grid * (o1 + a1 - t1)
  H_L <- (1 - mu_grid) * (o0 + a0_1 - t0) + mu_grid * beta * C1(1)
  H_R <- (1 - mu_grid) * beta * C0(mu_grid) + mu_grid * beta * C1(mu_grid)

  value_matrix <- cbind(pi_P, pi_L, pi_R)
  H_matrix <- cbind(H_P, H_L, H_R)
  names <- c("pooling", "low_only", "rejection")
  selected_index <- vapply(
    seq_len(nrow(value_matrix)),
    function(i) {
      best <- max(value_matrix[i, ])
      argmax <- which(value_matrix[i, ] >= best - tol)
      argmax[which.min(H_matrix[i, argmax])]
    },
    integer(1)
  )
  selected <- names[selected_index]
  selected_H <- H_matrix[cbind(seq_len(nrow(H_matrix)), selected_index)]

  S_P <- rep(1 - a1, length(mu_grid))
  S_L <- (1 - mu_grid) * (1 - a0_1) + mu_grid * beta * p2(1)
  S_R <- beta * p2(mu_grid)
  S_matrix <- cbind(S_P, S_L, S_R)
  selected_weak_total <- S_matrix[cbind(seq_len(nrow(S_matrix)), selected_index)]
  W_U <- selected_weak_total / m
  W_M <- 1 / m
  H_M <- (1 - mu_grid) * o0 + mu_grid * o1
  Delta_H <- selected_H - H_M

  root_mu <- NA_real_
  if (min(Delta_H) <= tol && max(Delta_H) >= -tol) {
    sign_change <- which(diff(sign(Delta_H)) != 0)
    if (length(sign_change) > 0) {
      j <- sign_change[1]
      root_mu <- approx(Delta_H[c(j, j + 1)], mu_grid[c(j, j + 1)], xout = 0)$y
    } else if (any(abs(Delta_H) <= tol)) {
      root_mu <- mu_grid[which.min(abs(Delta_H))]
    }
  }

  core_conditions <- valid_threshold && high_posterior_pooling && r1_order &&
    majority_order && no_cheap_H && max(W_U - W_M) <= tol &&
    min(Delta_H) < -tol && max(Delta_H) > tol

  list(
    valid = TRUE,
    N = N, m = m, q = q, k = k, beta = beta, t0 = t0, t1 = t1,
    o0 = o0, o1 = o1, ybar = ybar, mu2 = mu2,
    a0_1 = a0_1, a1 = a1, a0_M = a0_M, a1_M = a1_M,
    c0 = c0, c1 = c1, W_U_min = min(W_U), W_U_max = max(W_U),
    W_M = W_M, min_entry_gap = min(W_M - W_U),
    Delta_min = min(Delta_H), Delta_max = max(Delta_H),
    mu_H = root_mu,
    r1_order = r1_order,
    majority_order = majority_order,
    no_cheap_H = no_cheap_H,
    core_conditions = core_conditions,
    pooling_all_mu = all(selected == "pooling"),
    low_only_some_mu = any(selected == "low_only"),
    rejection_some_mu = any(selected == "rejection"),
    selected = selected,
    mu_grid = mu_grid,
    values = data.frame(
      mu = mu_grid,
      pi_P = pi_P,
      pi_L = pi_L,
      pi_R = pi_R,
      selected = selected,
      W_U = W_U,
      W_M = W_M,
      Delta_H = Delta_H,
      stringsAsFactors = FALSE
    )
  )
}

baseline <- list(N = 13, beta = 0.9, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.285, ybar = 1)
base_case <- do.call(compute_case, baseline)
stopifnot(base_case$valid, base_case$core_conditions, base_case$pooling_all_mu)

one_way_window <- function(parameter, values) {
  rows <- lapply(values, function(v) {
    pars <- baseline
    if (parameter == "gap") {
      pars$t1 <- pars$t0 + v
    } else {
      pars[[parameter]] <- v
    }
    obj <- do.call(compute_case, pars)
    data.frame(
      parameter = parameter,
      value = v,
      core_conditions = isTRUE(obj$core_conditions),
      pooling_all_mu = isTRUE(obj$pooling_all_mu),
      low_only_some_mu = isTRUE(obj$low_only_some_mu),
      rejection_some_mu = isTRUE(obj$rejection_some_mu),
      mu_H = if (isTRUE(obj$valid)) obj$mu_H else NA_real_,
      min_entry_gap = if (isTRUE(obj$valid)) obj$min_entry_gap else NA_real_,
      stringsAsFactors = FALSE
    )
  })
  sweep <- do.call(rbind, rows)
  summarise <- function(flag) {
    ok <- sweep$value[sweep[[flag]]]
    if (length(ok) == 0) {
      c(NA_real_, NA_real_)
    } else {
      range(ok)
    }
  }
  core_range <- summarise("core_conditions")
  pooling_range <- summarise("pooling_all_mu")
  data.frame(
    parameter = parameter,
    baseline = if (parameter == "gap") baseline$t1 - baseline$t0 else baseline[[parameter]],
    core_min = core_range[1],
    core_max = core_range[2],
    pooling_all_min = pooling_range[1],
    pooling_all_max = pooling_range[2],
    stringsAsFactors = FALSE
  )
}

windows <- do.call(
  rbind,
  list(
    one_way_window("beta", seq(0.50, 0.995, by = 0.001)),
    one_way_window("t0", seq(0.05, 0.284, by = 0.001)),
    one_way_window("t1", seq(0.191, 0.50, by = 0.001)),
    one_way_window("o0", seq(0.00, 0.45, by = 0.001)),
    one_way_window("o1", seq(0.10, 0.45, by = 0.001)),
    one_way_window("gap", seq(0.010, 0.250, by = 0.001))
  )
)

window_path <- file.path(tables_dir, "relative_package_robustness_windows_piH0.csv")
write.csv(windows, window_path, row.names = FALSE)

sweep_cases <- list(
  list(label = "baseline", beta = 0.9, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.285),
  list(label = "lower_beta", beta = 0.8, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.285),
  list(label = "higher_beta", beta = 0.98, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.285),
  list(label = "higher_t1", beta = 0.9, t0 = 0.19, t1 = 0.305, o0 = 0.19, o1 = 0.285),
  list(label = "lower_o1", beta = 0.9, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.265)
)

classification_sweeps <- do.call(
  rbind,
  lapply(sweep_cases, function(p) {
    obj <- compute_case(N = 13, beta = p$beta, t0 = p$t0, t1 = p$t1, o0 = p$o0, o1 = p$o1)
    stopifnot(obj$valid, obj$core_conditions)
    data.frame(
      case = p$label,
      beta = p$beta,
      t0 = p$t0,
      t1 = p$t1,
      o0 = p$o0,
      o1 = p$o1,
      a0_1 = obj$a0_1,
      a1 = obj$a1,
      W_U_max = obj$W_U_max,
      W_M = obj$W_M,
      min_entry_gap = obj$min_entry_gap,
      mu_H = obj$mu_H,
      selected_candidates = paste(unique(obj$selected), collapse = ";"),
      stringsAsFactors = FALSE
    )
  })
)

sweeps_path <- file.path(tables_dir, "relative_package_classification_sweeps_piH0.csv")
write.csv(classification_sweeps, sweeps_path, row.names = FALSE)

example_params <- list(
  calibration = list(N = 13, beta = 0.9, t0 = 0.19, t1 = 0.285, o0 = 0.19, o1 = 0.285),
  low_only_example = list(N = 13, beta = 0.6, t0 = 0.02, t1 = 0.27, o0 = 0.25, o1 = 0.27),
  delay_example = list(N = 13, beta = 0.9, t0 = 0.10, t1 = 0.50, o0 = 0.10, o1 = 0.50)
)

example_rows <- do.call(
  rbind,
  lapply(names(example_params), function(label) {
    obj <- do.call(compute_case, example_params[[label]])
    stopifnot(obj$valid)
    runs <- candidate_runs(obj$selected, obj$mu_grid)
    data.frame(
      example = label,
      beta = obj$beta,
      t0 = obj$t0,
      t1 = obj$t1,
      o0 = obj$o0,
      o1 = obj$o1,
      a0_1 = obj$a0_1,
      a1 = obj$a1,
      candidate = runs$candidate,
      mu_min = runs$mu_min,
      mu_max = runs$mu_max,
      rows = runs$rows,
      stringsAsFactors = FALSE
    )
  })
)

examples_path <- file.path(tables_dir, "relative_package_r1_examples_piH0.csv")
write.csv(example_rows, examples_path, row.names = FALSE)

delay_case <- compute_case(N = 13, beta = 0.9, t0 = 0.10, t1 = 0.50, o0 = 0.10, o1 = 0.50)
delay_row_mu <- delay_case$values[which.min(abs(delay_case$values$mu - 0.01)), ]
delay_details <- data.frame(
  mu = delay_row_mu$mu,
  beta = delay_case$beta,
  t0 = delay_case$t0,
  t1 = delay_case$t1,
  o0 = delay_case$o0,
  o1 = delay_case$o1,
  a0_1 = delay_case$a0_1,
  a1 = delay_case$a1,
  Pi_P = delay_row_mu$pi_P,
  Pi_L = delay_row_mu$pi_L,
  Pi_R = delay_row_mu$pi_R,
  selected = delay_row_mu$selected,
  stringsAsFactors = FALSE
)

delay_path <- file.path(tables_dir, "relative_package_delay_example_piH0.csv")
write.csv(delay_details, delay_path, row.names = FALSE)

cat("Robustness windows:\n")
print(windows, row.names = FALSE, digits = 8)
cat("\nClassification sweeps:\n")
print(classification_sweeps, row.names = FALSE, digits = 8)
cat("\nR1 examples:\n")
print(example_rows, row.names = FALSE, digits = 8)
cat("\nDelay details at mu=0.01:\n")
print(delay_details, row.names = FALSE, digits = 8)
cat("\nWrote:\n")
cat(window_path, "\n", sweeps_path, "\n", examples_path, "\n", delay_path, "\n", sep = "")
