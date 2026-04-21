# k3_verification.R
# Numerical verification of Proposition D.3 (K=3 analog of Lemma 1):
# D(mu) = VH(U) - VH(M) > 0 for all interior beliefs in the 2-simplex.
#
# This is the most important numerical result for the referee response.
# The referee wants evidence that conditional payoff dominance (Lemma 1
# from the K=2 model) extends to K=3.

# Source the K=3 functions, skipping the built-in verification block.
k3_screening_skip_verify <- TRUE
# Resolve path to k3_screening.R relative to this script's location.
# Works both when run via Rscript and when sourced interactively.
.script_dir <- tryCatch(
  dirname(normalizePath(sys.frame(1)$ofile)),
  error = function(e) {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("--file=", args, value = TRUE)
    if (length(file_arg) > 0) {
      dirname(normalizePath(sub("--file=", "", file_arg[1])))
    } else {
      getwd()
    }
  }
)
source(file.path(.script_dir, "k3_screening.R"))


# =============================================================================
# SIMPLEX GRID GENERATOR
# =============================================================================

#' Generate a grid of points on the 2-simplex (3-type case).
#'
#' @param n_per_side  Number of steps per side of the simplex.
#' @param interior_only  If TRUE, exclude boundary points (any mu < 1e-6).
#' @return Matrix with 3 columns (mu0, mu1, mu2), one row per grid point.
simplex_grid <- function(n_per_side, interior_only = TRUE) {
  pts <- list()
  for (i in 0:n_per_side) {
    for (j in 0:(n_per_side - i)) {
      k <- n_per_side - i - j
      mu <- c(i, j, k) / n_per_side
      if (interior_only && any(mu < 1e-6)) next
      pts[[length(pts) + 1]] <- mu
    }
  }
  do.call(rbind, pts)
}


# =============================================================================
# D(mu) COMPUTATION ON GRID
# =============================================================================

#' Compute D(mu) = VH_unanimity - VH_majority on a simplex grid.
#'
#' @param r1,r2      Type values (1 < r1 < r2).
#' @param alpha      Outside-option share.
#' @param beta       Discount factor.
#' @param N          Number of players (1 H + N-1 Ws).
#' @param n_per_side Grid resolution.
#' @return List with grid, D values, summary statistics.
compute_D_grid <- function(r1, r2, alpha, beta, N, n_per_side = 50) {
  grid <- simplex_grid(n_per_side)
  n <- nrow(grid)
  D_vals <- numeric(n)
  for (i in 1:n) {
    mu <- grid[i, ]
    vh_u <- VH_R1_k3_unanimity(mu, r1, r2, alpha, beta, N)
    vh_m <- VH_R1_k3_majority(mu, r1, r2, alpha, beta, N)
    D_vals[i] <- vh_u - vh_m
  }
  list(grid = grid, D = D_vals, n = n,
       min_D = min(D_vals), mean_D = mean(D_vals),
       all_positive = all(D_vals > 0))
}


# =============================================================================
# R1 STRATEGY LABELLER (for baseline region analysis)
# =============================================================================

#' Identify which R1 strategy W uses at a given belief, under unanimity.
#'
#' Returns 1 (LOW), 2 (MED), or 3 (HIGH).
r1_strategy_k3 <- function(mu, r1, r2, alpha, beta, N) {
  mu0 <- mu[1]; mu1 <- mu[2]; mu2 <- mu[3]

  VW_R2   <- VW_R2_k3(mu, r1, r2, alpha, N)
  VH_2sub <- VH_R2_2type_sub(mu, r1, r2, alpha, N)
  VW_2sub <- VW_R2_2type_sub(mu, r1, r2, alpha, N)

  omega  <- (N - 2) * beta * VW_R2
  y_high <- beta * r2 * (1 + (N - 1) * alpha) / N
  y_med  <- beta * (r1 + (N - 1) * alpha * r2) / N
  y_low  <- beta * VH_2sub[1]

  Ve <- mu0 * 1 + mu1 * r1 + mu2 * r2

  F_high <- Ve - y_high - omega
  F_med  <- (mu0 * (1 - y_med - omega) +
             mu1 * (r1 - y_med - omega) +
             mu2 * beta * r2 * (1 - alpha) / N)
  F_low  <- (mu0 * (1 - y_low - omega) +
             (mu1 + mu2) * beta * VW_2sub)

  which.max(c(F_low, F_med, F_high))
}


# =============================================================================
# MAIN VERIFICATION
# =============================================================================

cat("=== Proposition D.3 Verification ===\n\n")

# ------------------------------------------------------------------
# Baseline
# ------------------------------------------------------------------
r1_base <- 1.5; r2_base <- 2.5
alpha_base <- 0.3; beta_base <- 0.9; N_base <- 5

cat(sprintf("Baseline (r1=%.1f, r2=%.1f, alpha=%.1f, beta=%.1f, N=%d):\n",
            r1_base, r2_base, alpha_base, beta_base, N_base))

res_base <- compute_D_grid(r1_base, r2_base, alpha_base, beta_base, N_base,
                            n_per_side = 80)

cat(sprintf("  Grid points: %d\n", res_base$n))
cat(sprintf("  min D(mu):   %.6e\n", res_base$min_D))
cat(sprintf("  mean D(mu):  %.6f\n", res_base$mean_D))
cat(sprintf("  All D > 0:   %s\n\n", ifelse(res_base$all_positive, "YES", "NO")))

# ------------------------------------------------------------------
# R1 strategy distribution in baseline
# ------------------------------------------------------------------
cat("R1 strategy distribution:\n")
strategies <- apply(res_base$grid, 1, function(mu) {
  r1_strategy_k3(mu, r1_base, r2_base, alpha_base, beta_base, N_base)
})
n_total <- length(strategies)
n_low  <- sum(strategies == 1)
n_med  <- sum(strategies == 2)
n_high <- sum(strategies == 3)
cat(sprintf("  LOW:    %5.1f%%\n", 100 * n_low  / n_total))
cat(sprintf("  MEDIUM: %5.1f%%\n", 100 * n_med  / n_total))
cat(sprintf("  HIGH:   %5.1f%%\n\n", 100 * n_high / n_total))

# ------------------------------------------------------------------
# Robustness checks
# ------------------------------------------------------------------
cat("Robustness checks (n_per_side=50):\n")
cat(sprintf("%-45s  %12s  %10s  %s\n",
            "Parameters", "min D", "mean D", "All>0"))
cat(paste0(rep("-", 77), collapse = ""), "\n")

param_sets <- list(
  list(r1 = 1.3, r2 = 1.8, alpha = 0.2, beta = 0.9, N = 5),
  list(r1 = 2.0, r2 = 3.0, alpha = 0.2, beta = 0.9, N = 5),
  list(r1 = 1.5, r2 = 2.5, alpha = 0.1, beta = 0.9, N = 5),
  list(r1 = 1.5, r2 = 2.5, alpha = 0.3, beta = 0.7, N = 5),
  list(r1 = 1.5, r2 = 2.5, alpha = 0.3, beta = 0.9, N = 3),
  list(r1 = 1.5, r2 = 2.5, alpha = 0.3, beta = 0.9, N = 7),
  list(r1 = 1.2, r2 = 1.5, alpha = 0.3, beta = 0.8, N = 5),
  list(r1 = 1.5, r2 = 2.5, alpha = 0.35, beta = 0.9, N = 5)
)

any_failure <- FALSE
for (p in param_sets) {
  label <- sprintf("r1=%.1f r2=%.1f a=%.2f b=%.1f N=%d",
                   p$r1, p$r2, p$alpha, p$beta, p$N)
  res <- compute_D_grid(p$r1, p$r2, p$alpha, p$beta, p$N, n_per_side = 50)
  status <- ifelse(res$all_positive, "YES", "NO")
  if (!res$all_positive) any_failure <- TRUE
  cat(sprintf("%-45s  %12.4e  %10.6f  %s\n",
              label, res$min_D, res$mean_D, status))
}

cat("\n")

# ------------------------------------------------------------------
# Summary verdict
# ------------------------------------------------------------------
if (!res_base$all_positive || any_failure) {
  cat("*** WARNING: D(mu) <= 0 found for one or more parameterizations.\n")
  cat("    Proposition D.3 is NOT confirmed by this numerical check.\n")
} else {
  cat("Verdict: D(mu) > 0 at all interior grid points across all parameterizations.\n")
  cat("Proposition D.3 is supported numerically.\n")
}
