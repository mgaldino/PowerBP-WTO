#!/usr/bin/env Rscript

# Stress-tests the majority-without-H benchmark when excluding H reduces the
# weak coalition surplus from 1 to rho <= 1. This is an OPEC interpretation
# check, not an empirical calibration.

options(scipen = 999)

if (requireNamespace("here", quietly = TRUE)) {
  repo_root <- here::here()
} else {
  repo_root <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}

project_sentinels <- file.path(
  repo_root,
  c("formal_model_v5.Rmd", "model_redesign/power_architecture_derivations.Rmd")
)
if (!all(file.exists(project_sentinels))) {
  stop("Run from the PowerBayesianPersuasion repository root or a here::here()-recognized subdirectory.")
}

tables_dir <- file.path(repo_root, "tables")
dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)

compute_rho_majority_stress <- function(N, beta, d0, d1, b0, b1, rho,
                                        ybar = 1, W_U_reference = NULL,
                                        tol = 1e-10) {
  stopifnot(
    N >= 3,
    beta > 0, beta <= 1,
    rho > 0, rho <= 1,
    is.finite(d0), is.finite(d1),
    is.finite(b0), is.finite(b1),
    is.finite(ybar)
  )

  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1

  tau0 <- d0 - b0
  tau1 <- d1 - b1
  a0_M <- beta * d0 - b0
  a1_M <- beta * d1 - b1
  c_M_rho <- beta * rho / m

  threshold_domain <- tau0 >= -tol && tau0 + tol < tau1 &&
    tau1 <= ybar + tol && ybar <= 1 + tol &&
    a0_M >= -tol && a0_M + tol < a1_M && a1_M <= ybar + tol

  # Terminal no-H majority remains the selected continuation only if the
  # reduced weak-only surplus beats buying H at the low threshold.
  rho_terminal_min <- 1 - tau0
  terminal_no_H_dominates <- rho + tol >= rho_terminal_min

  # In R1, no-H majority beats H-including low-only for all beliefs iff
  # a0_M >= 1 - rho + beta*rho/m.
  no_H_threshold_cost <- 1 - rho + c_M_rho
  r1_no_H_dominates <- a0_M + tol >= no_H_threshold_cost
  rho_r1_min <- (1 - a0_M) / (1 - beta / m)

  rho_clean_no_H_min <- max(rho_terminal_min, rho_r1_min)
  clean_no_H_majority <- threshold_domain && terminal_no_H_dominates && r1_no_H_dominates

  no_H_value <- rho - k * c_M_rho
  rejection_value <- c_M_rho
  pooling_H_value <- 1 - a1_M - (k - 1) * c_M_rho
  low_only_gap_mu0 <- 1 - rho + c_M_rho - a0_M
  low_only_gap_mu1 <- q * c_M_rho - rho
  pooling_gap <- pooling_H_value - no_H_value
  no_H_beats_rejection <- no_H_value + tol >= rejection_value
  quota_bound <- q * c_M_rho <= rho + tol

  majority_screening_cutoff <- if (terminal_no_H_dominates && low_only_gap_mu0 > tol) {
    denominator <- 1 - a0_M - k * c_M_rho
    low_only_gap_mu0 / denominator
  } else {
    NA_real_
  }

  if (is.null(W_U_reference)) {
    W_U_reference <- NA_real_
  }
  W_M_rho <- rho / m
  entry_nesting_holds_reference <- if (is.finite(W_U_reference)) {
    W_M_rho + tol >= W_U_reference
  } else {
    NA
  }

  checks <- list(
    threshold_domain = threshold_domain,
    rho_bounds = rho > 0 && rho <= 1,
    quota_bound = quota_bound,
    terminal_no_H_iff = identical(terminal_no_H_dominates, rho + tol >= rho_terminal_min),
    r1_no_H_iff = identical(r1_no_H_dominates, a0_M + tol >= no_H_threshold_cost),
    clean_no_H_iff = identical(clean_no_H_majority, rho + tol >= rho_clean_no_H_min),
    no_H_beats_rejection_if_clean = !clean_no_H_majority || no_H_beats_rejection,
    pooling_not_profitable_if_clean = !clean_no_H_majority || pooling_gap <= tol,
    low_only_not_profitable_if_clean = !clean_no_H_majority || low_only_gap_mu0 <= tol,
    screening_cutoff_valid_if_needed = if (terminal_no_H_dominates && low_only_gap_mu0 > tol) {
      is.finite(majority_screening_cutoff) &&
        majority_screening_cutoff > 0 &&
        majority_screening_cutoff <= 1 + tol
    } else {
      is.na(majority_screening_cutoff)
    }
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
    rho = rho,
    tau0 = tau0,
    tau1 = tau1,
    a0_M = a0_M,
    a1_M = a1_M,
    c_M_rho = c_M_rho,
    rho_terminal_min = rho_terminal_min,
    rho_r1_min = rho_r1_min,
    rho_clean_no_H_min = rho_clean_no_H_min,
    terminal_no_H_dominates = terminal_no_H_dominates,
    r1_no_H_dominates = r1_no_H_dominates,
    clean_no_H_majority = clean_no_H_majority,
    no_H_threshold_cost = no_H_threshold_cost,
    no_H_value = no_H_value,
    rejection_value = rejection_value,
    pooling_gap = pooling_gap,
    low_only_gap_mu0 = low_only_gap_mu0,
    low_only_gap_mu1 = low_only_gap_mu1,
    majority_screening_cutoff = majority_screening_cutoff,
    W_M_rho = W_M_rho,
    W_U_reference = W_U_reference,
    entry_nesting_holds_reference = entry_nesting_holds_reference,
    checks = checks
  )
}

assert_rho_check <- function(x) {
  failed <- names(x$checks)[!unlist(x$checks)]
  if (length(failed) > 0) {
    stop(sprintf(
      "rho majority stress check failed for rho=%.12f: %s",
      x$rho,
      paste(failed, collapse = ", ")
    ))
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

m <- params$N - 1
a1_baseline <- params$beta * params$d1 - params$b1
W_U_reference <- (1 - a1_baseline) / m

base_thresholds <- do.call(
  compute_rho_majority_stress,
  c(params, list(rho = 1, W_U_reference = W_U_reference))
)

rho_values <- sort(unique(c(
  1,
  base_thresholds$rho_clean_no_H_min,
  base_thresholds$rho_r1_min,
  base_thresholds$rho_terminal_min,
  m * W_U_reference,
  0.85,
  0.75
)), decreasing = TRUE)

objects <- lapply(
  rho_values,
  function(rho) {
    obj <- do.call(
      compute_rho_majority_stress,
      c(params, list(rho = rho, W_U_reference = W_U_reference))
    )
    assert_rho_check(obj)
    obj
  }
)

summary_table <- do.call(
  rbind,
  lapply(objects, function(x) {
    data.frame(
      rho = x$rho,
      rho_terminal_min = x$rho_terminal_min,
      rho_r1_min = x$rho_r1_min,
      rho_clean_no_H_min = x$rho_clean_no_H_min,
      terminal_no_H_dominates = x$terminal_no_H_dominates,
      r1_no_H_dominates = x$r1_no_H_dominates,
      clean_no_H_majority = x$clean_no_H_majority,
      W_M_rho = x$W_M_rho,
      W_U_reference = x$W_U_reference,
      entry_nesting_holds_reference = x$entry_nesting_holds_reference,
      no_H_value = x$no_H_value,
      no_H_threshold_cost = x$no_H_threshold_cost,
      low_only_gap_mu0 = x$low_only_gap_mu0,
      majority_screening_cutoff = x$majority_screening_cutoff,
      r1_cutoff_in_clean_terminal_domain = x$terminal_no_H_dominates &&
        is.finite(x$majority_screening_cutoff),
      stringsAsFactors = FALSE
    )
  })
)

out_path <- file.path(tables_dir, "relative_package_rho_majority_piH0.csv")
write.csv(summary_table, out_path, row.names = FALSE)

cat("Relative-package majority rho stress test under pi_H = 0\n")
cat(sprintf(
  "N=%d, m=%d, beta=%.6f, d0=%.6f, d1=%.6f, b0=%.6f, b1=%.6f\n",
  params$N, m, params$beta, params$d0, params$d1, params$b0, params$b1
))
cat(sprintf(
  "rho_terminal_min=%.12f, rho_r1_min=%.12f, rho_clean_no_H_min=%.12f\n",
  base_thresholds$rho_terminal_min,
  base_thresholds$rho_r1_min,
  base_thresholds$rho_clean_no_H_min
))
cat(sprintf(
  "reference unanimity weak entry payoff=%.12f, entry-nesting rho min=%.12f\n\n",
  W_U_reference,
  m * W_U_reference
))
print(summary_table, row.names = FALSE, digits = 12)
cat("\nWrote:\n")
cat(out_path, "\n")
cat("\nAll relative-package majority rho stress checks passed.\n")
