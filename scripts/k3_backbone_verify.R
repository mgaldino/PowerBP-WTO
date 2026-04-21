# k3_backbone_verify.R
# Verify the analytical D_base_K3 backbone formula and characterize alpha_3*.
#
# Key result: D_base_K3(mu) = (A - lambda_M) * Ve(mu) + B where
#   A = (N - (N-1)*beta) / N^2
#   B = (N-1)*beta*r2*(1+N*alpha) / N^2
# This is affine in mu on Delta^2, with minimum at a vertex.

source("scripts/k3_screening.R", local = TRUE)

# ===========================================================================
# ANALYTICAL BACKBONE FORMULA
# ===========================================================================

#' Analytical D_base_K3 (backbone = HIGH R1 + HIGH R2 regime)
#' D_base(mu) = (A - lambda_M) * Ve(mu) + B
D_base_K3 <- function(mu, r1, r2, alpha, beta, N) {
  q <- floor(N/2) + 1
  Ve <- mu[1] + mu[2] * r1 + mu[3] * r2

  A <- (N - (N-1)*beta) / N^2
  B <- (N-1)*beta*r2*(1 + N*alpha) / N^2
  lambda_M <- (N*(1 + (N-1)*alpha) - beta*(q-1)*(1-alpha)) / N^2

  (A - lambda_M) * Ve + B
}

#' Full D(mu) = VH_U - VH_M (from the simulation code)
D_full_K3 <- function(mu, r1, r2, alpha, beta, N) {
  VH_U <- VH_R1_k3_unanimity(mu, r1, r2, alpha, beta, N)
  VH_M <- VH_R1_k3_majority(mu, r1, r2, alpha, beta, N)
  VH_U - VH_M
}

#' Correction = D_full - D_base (captures R2 + R1 screening adjustments)
D_correction_K3 <- function(mu, r1, r2, alpha, beta, N) {
  D_full_K3(mu, r1, r2, alpha, beta, N) - D_base_K3(mu, r1, r2, alpha, beta, N)
}

# ===========================================================================
# VERIFICATION 1: D_base matches VH_U in the HIGH regime
# ===========================================================================

cat("=== VERIFICATION 1: D_base formula vs simulation in HIGH regime ===\n\n")

# In the HIGH regime (all types accept in both R1 and R2), D_full should equal D_base.
# HIGH regime is near vertex (0,0,1) where W always plays high offer.
N <- 5; alpha <- 0.1; beta <- 0.9; r1 <- 1.5; r2 <- 2.5

# Points deep in the HIGH R2 region (high mu2)
test_points_high <- list(
  c(0.05, 0.05, 0.90),
  c(0.02, 0.08, 0.90),
  c(0.01, 0.01, 0.98),
  c(0.10, 0.10, 0.80)
)

max_err <- 0
for (mu in test_points_high) {
  # Check what R2 region we're in
  reg_R2 <- screening_region_R2_k3(mu, r1, r2, alpha)
  db <- D_base_K3(mu, r1, r2, alpha, beta, N)
  df <- D_full_K3(mu, r1, r2, alpha, beta, N)
  corr <- df - db
  cat(sprintf("  mu=(%.2f,%.2f,%.2f) R2_reg=%d | D_base=%.6f D_full=%.6f corr=%.6f\n",
    mu[1], mu[2], mu[3], reg_R2, db, df, corr))
  if (reg_R2 == 3) max_err <- max(max_err, abs(corr))  # only check HIGH regime
}
cat(sprintf("\n  Max error in HIGH R2 regime: %.2e\n\n", max_err))

# ===========================================================================
# VERIFICATION 2: Vertex analysis
# ===========================================================================

cat("=== VERIFICATION 2: D_base at vertices (affine → min at vertex) ===\n\n")

params_list <- list(
  list(r1=1.5, r2=2.5, alpha=0.3, beta=0.9, N=5),
  list(r1=1.2, r2=3.0, alpha=0.3, beta=0.9, N=5),
  list(r1=2.0, r2=4.0, alpha=0.2, beta=0.9, N=5),
  list(r1=1.5, r2=2.5, alpha=0.2, beta=0.7, N=5)
)

for (p in params_list) {
  q <- floor(p$N/2) + 1
  A <- (p$N - (p$N-1)*p$beta) / p$N^2
  lM <- (p$N*(1 + (p$N-1)*p$alpha) - p$beta*(q-1)*(1-p$alpha)) / p$N^2
  slope <- A - lM
  B <- (p$N-1)*p$beta*p$r2*(1 + p$N*p$alpha) / p$N^2

  d1 <- slope * 1 + B       # vertex (1,0,0)
  d2 <- slope * p$r1 + B    # vertex (0,1,0)
  d3 <- slope * p$r2 + B    # vertex (0,0,1)

  cat(sprintf("  r1=%.1f r2=%.1f alpha=%.1f beta=%.1f N=%d | slope=%.4f\n",
    p$r1, p$r2, p$alpha, p$beta, p$N, slope))
  cat(sprintf("    D_base(1,0,0)=%.4f  D_base(0,1,0)=%.4f  D_base(0,0,1)=%.4f  min=%.4f at %s\n",
    d1, d2, d3, min(d1,d2,d3),
    c("(1,0,0)", "(0,1,0)", "(0,0,1)")[which.min(c(d1,d2,d3))]))

  # Verify D_base(0,0,1) = r2 * [P - Q(1-beta)] / N^2 (K=2 formula)
  P_val <- p$beta * (q-1) * (1 - p$alpha)
  Q_val <- p$N * (p$N - 1) * p$alpha
  d3_k2 <- p$r2 * (P_val - Q_val*(1-p$beta)) / p$N^2
  cat(sprintf("    D_base(0,0,1) via K=2 formula: %.4f (match: %s)\n\n",
    d3_k2, ifelse(abs(d3 - d3_k2) < 1e-10, "YES", "NO")))
}

# ===========================================================================
# VERIFICATION 3: Find alpha_3* and characterize binding correction
# ===========================================================================

cat("=== VERIFICATION 3: alpha_3* via bisection + binding analysis ===\n\n")

alpha_star_k2 <- function(N, beta) {
  q <- floor(N/2) + 1
  beta * (q - 1) / (N*(N-1) - beta*(N^2 - N - q + 1))
}

find_alpha3_detailed <- function(r1, r2, beta, N, grid_n = 60, tol = 1e-5) {
  min_D_info <- function(alpha) {
    min_D <- Inf; min_mu <- c(1/3,1/3,1/3); min_corr <- 0; min_dbase <- 0
    for (i in 1:(grid_n-1)) {
      for (j in 1:(grid_n-1-i)) {
        k <- grid_n - i - j
        mu <- c(i, j, k) / grid_n
        df <- D_full_K3(mu, r1, r2, alpha, beta, N)
        if (df < min_D) {
          min_D <- df
          min_mu <- mu
          min_dbase <- D_base_K3(mu, r1, r2, alpha, beta, N)
          min_corr <- df - min_dbase
        }
      }
    }
    list(min_D=min_D, mu=min_mu, dbase=min_dbase, corr=min_corr)
  }

  lo <- 0.001; hi <- min(1/r2 - 0.01, alpha_star_k2(N, beta) + 0.05)
  if (min_D_info(lo)$min_D <= 0) return(NULL)

  # Find hi where D < 0
  while (hi < 1/r2 - 0.01) {
    if (min_D_info(hi)$min_D <= 0) break
    hi <- hi + 0.02
  }
  if (min_D_info(hi)$min_D > 0) {
    return(list(alpha3 = hi, note = "all positive up to 1/r2"))
  }

  for (iter in 1:50) {
    mid <- (lo + hi) / 2
    if (min_D_info(mid)$min_D > 0) lo <- mid else hi <- mid
    if (hi - lo < tol) break
  }

  res <- min_D_info((lo+hi)/2)
  list(alpha3=(lo+hi)/2, mu=res$mu, dbase=res$dbase, corr=res$corr, min_D=res$min_D)
}

cases <- list(
  list(r1=1.5, r2=2.5, beta=0.9, N=5),
  list(r1=1.2, r2=3.0, beta=0.9, N=5),
  list(r1=2.0, r2=2.5, beta=0.9, N=5),
  list(r1=1.5, r2=2.5, beta=0.9, N=7),
  list(r1=1.5, r2=2.5, beta=0.7, N=5),
  list(r1=1.5, r2=2.5, beta=0.9, N=3),
  list(r1=1.5, r2=2.0, beta=0.9, N=5),
  list(r1=1.1, r2=1.5, beta=0.9, N=5)
)

cat(sprintf("%-5s %-5s %-5s %-3s | %-7s %-7s %-6s | %-20s | %-8s %-8s\n",
  "r1", "r2", "beta", "N", "a*_K2", "a3*", "ratio", "min_mu", "D_base", "corr"))
cat(paste(rep("-", 90), collapse=""), "\n")

for (p in cases) {
  res <- find_alpha3_detailed(p$r1, p$r2, p$beta, p$N)
  astar <- alpha_star_k2(p$N, p$beta)
  if (!is.null(res) && !is.null(res$mu)) {
    cat(sprintf("%-5.1f %-5.1f %-5.1f %-3d | %-7.4f %-7.4f %-6.3f | (%.2f,%.2f,%.2f)  | %-8.4f %-8.4f\n",
      p$r1, p$r2, p$beta, p$N, astar, res$alpha3, res$alpha3/astar,
      res$mu[1], res$mu[2], res$mu[3], res$dbase, res$corr))
  } else {
    cat(sprintf("%-5.1f %-5.1f %-5.1f %-3d | %-7.4f  [all pass up to 1/r2]\n",
      p$r1, p$r2, p$beta, p$N, astar))
  }
}

# ===========================================================================
# VERIFICATION 4: Correction sign analysis
# ===========================================================================

cat("\n=== VERIFICATION 4: Correction sign by R1/R2 regime ===\n\n")

# At alpha = alpha_3*, analyze the correction across the simplex
p <- list(r1=1.5, r2=2.5, beta=0.9, N=5)
res <- find_alpha3_detailed(p$r1, p$r2, p$beta, p$N)
alpha_test <- res$alpha3 * 0.95  # slightly below threshold

cat(sprintf("At alpha=%.4f (95%% of alpha_3*=%.4f):\n", alpha_test, res$alpha3))
cat("Sampling corrections by R2 screening region:\n")

grid_n <- 40
for (R2_reg in 1:3) {
  corrs <- c()
  for (i in 1:(grid_n-1)) {
    for (j in 1:(grid_n-1-i)) {
      k <- grid_n - i - j
      mu <- c(i, j, k) / grid_n
      if (screening_region_R2_k3(mu, p$r1, p$r2, alpha_test) == R2_reg) {
        corrs <- c(corrs, D_correction_K3(mu, p$r1, p$r2, alpha_test, p$beta, p$N))
      }
    }
  }
  if (length(corrs) > 0) {
    cat(sprintf("  R2 region %d (%s): n=%d, min_corr=%.4f, max_corr=%.4f, %s\n",
      R2_reg, c("LOW","MED","HIGH")[R2_reg], length(corrs),
      min(corrs), max(corrs),
      ifelse(min(corrs) >= -1e-10, "ALL >= 0", sprintf("NEGATIVE (min=%.4f)", min(corrs)))))
  }
}

cat("\nKey insight: corrections in LOW/MED R2 regions can be negative (like delta_R2 in K=2).\n")
cat("The backbone D_base > 0 must absorb these negative corrections.\n")
cat("alpha_3* is where the absorption fails.\n")
