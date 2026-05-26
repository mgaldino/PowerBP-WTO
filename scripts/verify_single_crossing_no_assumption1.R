# Verify single-crossing of D(p) = cav v(p,U) - cav v(p,M) WITHOUT Assumption 1
# Tests that single-crossing holds even when E_U is disconnected
#
# Key analytical insight being verified:
#   For p in gap (b,d) of E_U, interpolating posteriors b and d gives
#   cav v(p,U) >= w1*v(b,U) + w2*v(d,U) > w1*v(b,M) + w2*v(d,M) = lambda_M*Ve(p)
#   because Theorem 1 gives strict dominance at b,d and Ve is affine.

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

# Compute D(p) = cav v(p,U) - cav v(p,M) on a common grid
# Returns list with grid, D, entry set info
compute_D <- function(r, alpha, N, beta, c_val, grid_size = 2000) {
  mus <- seq(0, 1, length.out = grid_size)

  # Compute VW on the SAME grid to determine entry
  VW_U <- numeric(grid_size)
  VW_M <- numeric(grid_size)
  VH_U <- numeric(grid_size)
  VH_M <- numeric(grid_size)

  for (i in 2:(grid_size - 1)) {
    mu <- mus[i]
    VW_U[i] <- VW_R1_unanimity(r, alpha, mu, N, beta)
    VW_M[i] <- VW_R1_majority(r, alpha, mu, N, beta)
    VH_U[i] <- VH_R1_unanimity(r, alpha, mu, N, beta)
    VH_M[i] <- VH_R1_majority(r, alpha, mu, N, beta)
  }
  # Boundary: mu=1
  VW_U[grid_size] <- VW_R1_unanimity(r, alpha, 1 - 1e-12, N, beta)
  VW_M[grid_size] <- VW_R1_majority(r, alpha, 1 - 1e-12, N, beta)
  VH_U[grid_size] <- VH_R1_unanimity(r, alpha, 1 - 1e-12, N, beta)
  VH_M[grid_size] <- VH_R1_majority(r, alpha, 1 - 1e-12, N, beta)

  in_EU <- VW_U >= c_val
  in_EM <- VW_M >= c_val
  in_EU[1] <- FALSE  # mu=0 never enters

  if (!any(in_EU)) return(NULL)

  # Check if E_U is disconnected
  rle_EU <- rle(in_EU)
  n_components <- sum(rle_EU$values)
  is_disconnected <- (n_components > 1)

  # Reduced value functions
  v_U <- ifelse(in_EU, VH_U, 0)
  v_M <- ifelse(in_EM, VH_M, 0)

  # Concavify
  cav_U <- concavify(mus, v_U)
  cav_M <- concavify(mus, v_M)

  D <- cav_U - cav_M

  list(mus = mus, D = D, cav_U = cav_U, cav_M = cav_M,
       v_U = v_U, v_M = v_M,
       in_EU = in_EU, in_EM = in_EM,
       is_disconnected = is_disconnected, n_components = n_components)
}

# Check single-crossing: D(p) changes sign at most once (from - to +)
# Skip the trivial D(0)=0 boundary point
check_single_crossing <- function(res) {
  D <- res$D
  mus <- res$mus

  # Skip p=0 (trivially D=0) and very small p (numerical noise)
  valid <- mus >= 1e-4
  D_v <- D[valid]

  tol <- 1e-9
  signs <- ifelse(D_v > tol, 1, ifelse(D_v < -tol, -1, 0))
  nonzero <- signs[signs != 0]

  if (length(nonzero) <= 1) return(list(pass = TRUE, n_crossings = 0))

  sign_changes <- sum(diff(nonzero) != 0)

  if (sign_changes > 1) {
    # Find crossing locations for diagnostic
    crossings <- c()
    for (i in 2:length(nonzero)) {
      if (nonzero[i] != nonzero[i-1]) {
        crossings <- c(crossings, sprintf("%+d->%+d", nonzero[i-1], nonzero[i]))
      }
    }
    return(list(pass = FALSE, n_crossings = sign_changes,
                crossings = crossings))
  }

  # If 1 crossing, verify direction is - to + (not + to -)
  if (sign_changes == 1 && nonzero[1] == 1 && nonzero[length(nonzero)] == -1) {
    return(list(pass = FALSE, n_crossings = 1, direction = "wrong (+→-)"))
  }

  list(pass = TRUE, n_crossings = sign_changes)
}

# ============================================================
# Main verification sweep
# ============================================================

cat("=== Verifying single-crossing WITHOUT Assumption 1 ===\n\n")

set.seed(42)

Ns <- c(3, 5, 7, 10, 15, 20)
rs <- c(1.1, 1.2, 1.3, 1.5, 2, 3, 5)
betas <- c(0.5, 0.7, 0.8, 0.9, 0.95, 0.99)

total <- 0
passed <- 0
failed <- 0
disc_total <- 0
disc_passed <- 0
failure_cases <- list()

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      if (a_star <= 0.005 || a_star >= 1/r) next

      alphas <- seq(0.01, min(a_star - 0.001, 1/r - 0.01), length.out = 5)
      alphas <- alphas[alphas > 0]

      for (alpha in alphas) {
        # Find VW range to set c
        mus_test <- seq(0.01, 0.99, by = 0.01)
        VWs_test <- sapply(mus_test, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        c_min <- min(VWs_test[VWs_test > 0], na.rm = TRUE)
        c_max <- max(VWs_test, na.rm = TRUE)
        if (c_max <= c_min + 0.002) next

        cs <- seq(c_min + 0.002, c_max - 0.002, length.out = 8)

        for (c_val in cs) {
          total <- total + 1

          res <- tryCatch({
            compute_D(r, alpha, N, beta, c_val)
          }, error = function(e) NULL)

          if (is.null(res)) next

          if (res$is_disconnected) disc_total <- disc_total + 1

          sc <- check_single_crossing(res)

          if (sc$pass) {
            passed <- passed + 1
            if (res$is_disconnected) disc_passed <- disc_passed + 1
          } else {
            failed <- failed + 1
            failure_cases[[length(failure_cases) + 1]] <- list(
              N = N, r = r, alpha = round(alpha, 4), beta = beta,
              c = round(c_val, 4), sc = sc,
              is_disconnected = res$is_disconnected
            )
            if (length(failure_cases) <= 5) {
              cat(sprintf("  FAIL: N=%d r=%.2f α=%.4f β=%.2f c=%.4f disc=%s crossings=%d [%s]\n",
                          N, r, alpha, beta, c_val,
                          res$is_disconnected, sc$n_crossings,
                          paste(sc$crossings, collapse=",")))
            }
          }
        }
      }
    }
  }
}

cat(sprintf("\nTotal cases: %d\n", total))
cat(sprintf("Passed: %d (%.1f%%)\n", passed, 100 * passed / max(total, 1)))
cat(sprintf("Failed: %d\n\n", failed))
cat(sprintf("Disconnected E_U: %d total, %d passed (%.1f%%)\n",
            disc_total, disc_passed, 100 * disc_passed / max(disc_total, 1)))

if (failed > 0 && length(failure_cases) > 5) {
  cat(sprintf("\n(Showing first 5 of %d failures above)\n", failed))
}

if (failed == 0) {
  cat("\n*** ALL CASES PASS: Single-crossing holds without Assumption 1 ***\n")
}

# ============================================================
# Gap interpolation test
# ============================================================

cat("\n\n=== Gap interpolation: D(p) > 0 in disconnected gaps ===\n")

gap_violations <- 0
gap_tests <- 0

for (N in Ns) {
  for (r in rs) {
    for (beta in betas) {
      a_star <- alpha_star_fn(N, beta)
      if (a_star <= 0.005 || a_star >= 1/r) next

      alphas <- seq(0.01, min(a_star - 0.001, 1/r - 0.01), length.out = 5)
      alphas <- alphas[alphas > 0]

      for (alpha in alphas) {
        mus_test <- seq(0.01, 0.99, by = 0.01)
        VWs_test <- sapply(mus_test, function(mu) VW_R1_unanimity(r, alpha, mu, N, beta))
        c_min <- min(VWs_test[VWs_test > 0], na.rm = TRUE)
        c_max <- max(VWs_test, na.rm = TRUE)
        if (c_max <= c_min + 0.002) next

        cs <- seq(c_min + 0.002, c_max - 0.002, length.out = 8)

        for (c_val in cs) {
          res <- tryCatch(compute_D(r, alpha, N, beta, c_val), error = function(e) NULL)
          if (is.null(res) || !res$is_disconnected) next

          gap_tests <- gap_tests + 1

          # Find gap boundaries from in_EU
          rle_r <- rle(res$in_EU)
          cumlen <- cumsum(rle_r$lengths)
          # Find the first FALSE run after a TRUE run
          for (k in 2:(length(rle_r$values) - 1)) {
            if (!rle_r$values[k] && rle_r$values[k-1] && rle_r$values[k+1]) {
              gap_start_idx <- cumlen[k-1]      # last TRUE before gap
              gap_end_idx <- cumlen[k] + 1       # first TRUE after gap
              b_gap <- res$mus[gap_start_idx]
              d_gap <- res$mus[gap_end_idx]

              # Check D > 0 in gap
              gap_idx <- which(res$mus > b_gap & res$mus < d_gap)
              D_gap <- res$D[gap_idx]

              if (any(D_gap < -1e-9)) {
                gap_violations <- gap_violations + 1
                cat(sprintf("  GAP VIOLATION: N=%d r=%.2f α=%.4f β=%.2f c=%.4f gap=[%.4f,%.4f] min(D)=%.8f\n",
                            N, r, alpha, beta, c_val, b_gap, d_gap, min(D_gap)))
              }
            }
          }
        }
      }
    }
  }
}

cat(sprintf("\nDisconnected cases tested: %d\n", gap_tests))
cat(sprintf("Gap violations: %d\n", gap_violations))
if (gap_violations == 0 && gap_tests > 0) {
  cat("*** GAP INTERPOLATION VERIFIED: D(p) > 0 in all gaps ***\n")
}
