# Verification script for CR8 Decomposition v2
# Date: 2026-04-26
# Purpose: Numerically verify the decomposition proposal and resolve the p* discrepancy

# ============================================================
# 0. Source model functions
# ============================================================
source("scripts/model_functions.R")

# ============================================================
# 1. Parameters (Example 2)
# ============================================================
N     <- 5
r     <- 1.5
alpha <- 0.3
beta  <- 0.9
c_val <- 0.14

q <- floor(N/2) + 1  # majority threshold

cat("=== EXAMPLE 2 PARAMETERS ===\n")
cat(sprintf("N=%d, r=%.1f, alpha=%.1f, beta=%.1f, c=%.2f, q=%d\n\n", N, r, alpha, beta, c_val, q))

# ============================================================
# 2. Screening cutoffs
# ============================================================
mu_s_R2 <- alpha * (r - 1) / (r - alpha)
cat(sprintf("mu_s_R2 = %.6f\n", mu_s_R2))

# R1 cutoff: from Proposition 2, closed form when alpha < alpha_bar
# phi = [rN - beta*(N-1+r)] / [beta*(r-1)]
phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
cat(sprintf("phi = %.6f\n", phi))

# mu_s_R1 = phi / (phi + N - 2)  [from the paper's formula]
# Actually let me find the cutoff numerically by checking where aggressive = conservative
mus_fine <- seq(0.001, 0.999, by = 0.0001)

# Find mu_s_R1 by looking for where F1_agg = F1_con
find_mu_s_R1 <- function(r, alpha, N, beta) {
  x <- (N - 1) * alpha * r
  test <- sapply(seq(0.001, 0.999, by = 0.0001), function(mu) {
    mu_s_R2 <- alpha * (r - 1) / (r - alpha)
    Ve <- 1 + mu * (r - 1)
    if (mu < mu_s_R2) {
      VW_R2 <- (1 - mu) * (1 - alpha) / N
    } else {
      VW_R2 <- (Ve - alpha * r) / N
    }
    omega <- (N - 2) * beta * VW_R2
    F1_con <- Ve - beta * (r + x) / N - omega
    F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
    F1_agg - F1_con
  })
  mus <- seq(0.001, 0.999, by = 0.0001)
  # Find sign change (agg - con goes from positive to negative)
  for (i in 1:(length(test)-1)) {
    if (test[i] > 0 && test[i+1] <= 0) {
      # Linear interpolation
      return(mus[i] + (0 - test[i]) / (test[i+1] - test[i]) * 0.0001)
    }
  }
  return(NA)
}

mu_s_R1 <- find_mu_s_R1(r, alpha, N, beta)
cat(sprintf("mu_s_R1 = %.6f\n\n", mu_s_R1))

# ============================================================
# 3. Alpha* check
# ============================================================
alpha_star <- beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
cat(sprintf("alpha* = %.6f\n", alpha_star))
cat(sprintf("alpha < alpha*? %s\n\n", alpha < alpha_star))

# ============================================================
# 4. Lambda_M (majority payoff coefficient)
# ============================================================
C_buy <- beta * (q - 1) * (1 - alpha)
C_out <- N * (N - 1) * alpha
lambda_M <- (N * (1 + (N-1) * alpha) - C_buy) / N^2
cat(sprintf("C_buy = %.6f\n", C_buy))
cat(sprintf("C_out = %.6f\n", C_out))
cat(sprintf("lambda_M = %.6f\n", lambda_M))
cat(sprintf("lambda_M - alpha = %.6f\n\n", lambda_M - alpha))

# ============================================================
# 5. Entry thresholds
# ============================================================
# Majority entry threshold
kappa_M <- (1 - alpha) * (N * (N-1) + beta * (q - 1)) / (N^2 * (N - 1))
tau_M <- max(0, (c_val / kappa_M - 1) / (r - 1))
cat(sprintf("kappa_M = %.6f\n", kappa_M))
cat(sprintf("tau(M) = %.6f\n", tau_M))

# Unanimity entry threshold: find numerically
find_tau_U <- function(r, alpha, N, beta, c_val) {
  mus <- seq(0.001, 0.999, by = 0.0001)
  vws <- sapply(mus, function(m) VW_R1_unanimity(r, alpha, m, N, beta))
  # Find lowest mu where VW >= c
  above_c <- which(vws >= c_val)
  if (length(above_c) == 0) return(1.0)  # never enters
  return(mus[min(above_c)])
}

tau_U <- find_tau_U(r, alpha, N, beta, c_val)
cat(sprintf("tau(U) = %.6f\n", tau_U))
cat(sprintf("mu_s_R1 < tau(U)? %s (%.4f < %.4f)\n\n", mu_s_R1 < tau_U, mu_s_R1, tau_U))

# ============================================================
# 6. Compute VH_R1, v(mu, R), and D(mu) at several beliefs
# ============================================================
test_mus <- c(0.33, 0.40, 0.50, 0.70, 1.00)

cat("=== PAYOFFS AT SELECTED BELIEFS ===\n")
cat(sprintf("%-8s %-12s %-12s %-12s %-12s %-12s %-12s %-12s\n",
            "mu", "VH_U", "VH_M", "Ve", "v(mu,U)", "v(mu,M)", "D(mu)", "VW_U"))

for (mu in test_mus) {
  Ve <- 1 + mu * (r - 1)
  VH_U <- VH_R1_unanimity(r, alpha, mu, N, beta)
  VH_M <- VH_R1_majority(r, alpha, mu, N, beta)
  VW_U <- VW_R1_unanimity(r, alpha, mu, N, beta)
  VW_M <- VW_R1_majority(r, alpha, mu, N, beta)

  # Net gain: v(mu, R) = VH_R1 - alpha * Ve IF entry, else 0
  v_U <- if (VW_U >= c_val) VH_U - alpha * Ve else 0
  v_M <- if (VW_M >= c_val) VH_M - alpha * Ve else 0

  D_mu <- v_U - v_M  # Only valid if both enter

  cat(sprintf("%-8.2f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f\n",
              mu, VH_U, VH_M, Ve, v_U, v_M, D_mu, VW_U))
}

cat("\n")

# ============================================================
# 7. Also check: does Lemma 1 hold? D(mu) > 0 for mu in (0,1]?
# ============================================================
cat("=== D(mu) = VH_U - VH_M (absolute, not net) across range ===\n")
mus_check <- seq(0.01, 1.0, by = 0.01)
D_vals <- sapply(mus_check, function(mu) {
  VH_R1_unanimity(r, alpha, mu, N, beta) - VH_R1_majority(r, alpha, mu, N, beta)
})
cat(sprintf("min(D) = %.8f at mu = %.2f\n", min(D_vals), mus_check[which.min(D_vals)]))
cat(sprintf("max(D) = %.8f at mu = %.2f\n", max(D_vals), mus_check[which.max(D_vals)]))
cat(sprintf("D > 0 for all mu in (0,1]? %s\n\n", all(D_vals > 0)))

# ============================================================
# 8. Build full v(mu, R) functions and concavify
# ============================================================
mus_grid <- seq(0.001, 0.999, by = 0.001)

v_U_grid <- sapply(mus_grid, function(m) {
  VW <- VW_R1_unanimity(r, alpha, m, N, beta)
  Ve <- 1 + m * (r - 1)
  if (VW >= c_val) VH_R1_unanimity(r, alpha, m, N, beta) - alpha * Ve else 0
})

v_M_grid <- sapply(mus_grid, function(m) {
  VW <- VW_R1_majority(r, alpha, m, N, beta)
  Ve <- 1 + m * (r - 1)
  if (VW >= c_val) VH_R1_majority(r, alpha, m, N, beta) - alpha * Ve else 0
})

cav_U <- concavify(mus_grid, v_U_grid)
cav_M <- concavify(mus_grid, v_M_grid)

cat("=== CONCAVIFIED VALUES AT SELECTED BELIEFS ===\n")
cat(sprintf("%-8s %-12s %-12s %-12s %-12s %-12s %-12s\n",
            "mu", "v(mu,U)", "v(mu,M)", "cav_v(U)", "cav_v(M)", "cav_U-cav_M", "cav_U-v_U"))

for (mu_target in c(0.05, 0.10, 0.15, 0.20, 0.24, 0.30, 0.33, 0.40, 0.50, 0.70, 1.00)) {
  idx <- which.min(abs(mus_grid - mu_target))
  cat(sprintf("%-8.3f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f %-12.6f\n",
              mus_grid[idx],
              v_U_grid[idx], v_M_grid[idx],
              cav_U[idx], cav_M[idx],
              cav_U[idx] - cav_M[idx],
              cav_U[idx] - v_U_grid[idx]))
}

cat("\n")

# ============================================================
# 9. Find p* numerically: where cav_v(p,U) = cav_v(p,M)
# ============================================================
diff_grid <- cav_U - cav_M

# Find the crossing point
p_star <- NA
for (i in 2:length(diff_grid)) {
  if (diff_grid[i-1] <= 0 && diff_grid[i] > 0) {
    # Linear interpolation
    p_star <- mus_grid[i-1] + (0 - diff_grid[i-1]) / (diff_grid[i] - diff_grid[i-1]) * (mus_grid[i] - mus_grid[i-1])
    break
  }
}

cat(sprintf("=== p* (NUMERICAL) = %.6f ===\n\n", p_star))

# ============================================================
# 10. Check the analytical p* from the proposal
# ============================================================
# The proposal computes S_U = v(tau(U), U) / tau(U)
# and says cav v(p, M) = (lambda_M - alpha) * Ve(p) for all p (since tau(M) ≈ 0)

# S_U: slope of the concavification line from origin to the entry point
# Actually, S_U should be max v(mu, U) / mu for mu in E_U
idx_tau_U <- which.min(abs(mus_grid - tau_U))
slopes_U <- sapply(which(v_U_grid > 0), function(i) v_U_grid[i] / mus_grid[i])
S_U_actual <- max(slopes_U)
idx_max_slope <- which(v_U_grid > 0)[which.max(slopes_U)]
mu_tangent <- mus_grid[idx_max_slope]

cat(sprintf("S_U (max slope) = %.6f at mu = %.4f\n", S_U_actual, mu_tangent))
cat(sprintf("v(tau(U), U) = %.6f\n", v_U_grid[idx_tau_U]))
cat(sprintf("v(tau(U), U) / tau(U) = %.6f\n", v_U_grid[idx_tau_U] / mus_grid[idx_tau_U]))

# Check if S_U = v(tau(U))/tau(U) or if there's a better tangent point
cat(sprintf("\nTangent point for concavification of v(mu, U):\n"))
cat(sprintf("  mu_tangent = %.4f, v/mu = %.6f\n", mu_tangent, S_U_actual))

# Under majority: cav v(p, M) at low p
# If tau(M) = 0, then v(mu, M) = (lambda_M - alpha) * Ve(mu) for all mu > 0
# So cav v(p, M) = v(p, M) = (lambda_M - alpha) * Ve(p)
cat(sprintf("\nAnalytical check: cav v(p, M) = (lambda_M - alpha) * Ve(p) when tau(M) ≈ 0\n"))
cat(sprintf("lambda_M - alpha = %.6f\n", lambda_M - alpha))
# Verify at a few points
for (mu_test in c(0.1, 0.5, 0.9)) {
  idx <- which.min(abs(mus_grid - mu_test))
  Ve <- 1 + mu_test * (r - 1)
  analytical <- (lambda_M - alpha) * Ve
  cat(sprintf("  mu=%.1f: analytical=%.6f, numerical cav_M=%.6f, diff=%.2e\n",
              mu_test, analytical, cav_M[idx], abs(analytical - cav_M[idx])))
}

# p* from S_U: cav v(p, U) = S_U * p = (lambda_M - alpha) * Ve(p) = cav v(p, M)
# S_U * p = (lambda_M - alpha) * (1 + (r-1) * p)
# S_U * p = (lambda_M - alpha) + (lambda_M - alpha)(r-1) * p
# p * [S_U - (lambda_M - alpha)(r-1)] = (lambda_M - alpha)
# p* = (lambda_M - alpha) / [S_U - (lambda_M - alpha)(r-1)]
lm_minus_a <- lambda_M - alpha
p_star_analytical <- lm_minus_a / (S_U_actual - lm_minus_a * (r - 1))
cat(sprintf("\nAnalytical p*: %.6f\n", p_star_analytical))
cat(sprintf("Numerical p*:  %.6f\n", p_star))
cat(sprintf("Discrepancy: %.6f\n\n", abs(p_star_analytical - p_star)))

# ============================================================
# 11. Decomposition identity check for p in E_U
# ============================================================
cat("=== DECOMPOSITION IDENTITY CHECK (p in E_U) ===\n")
cat("cav v(p,U) - cav v(p,M) = D(p) + [cav v(p,U) - v(p,U)]\n")
cat("(where D(p) = v(p,U) - v(p,M))\n\n")

for (p in c(0.40, 0.50, 0.70, 1.00)) {
  idx <- which.min(abs(mus_grid - p))
  LHS <- cav_U[idx] - cav_M[idx]
  D_p <- v_U_grid[idx] - v_M_grid[idx]
  BP_amp <- cav_U[idx] - v_U_grid[idx]
  RHS <- D_p + BP_amp
  cat(sprintf("p=%.2f: LHS=%.6f, D(p)=%.6f, BP_amp=%.6f, RHS=%.6f, match=%s\n",
              p, LHS, D_p, BP_amp, RHS, abs(LHS - RHS) < 1e-10))
}

cat("\n")

# ============================================================
# 12. SEARCH: Parameters where BP amplification > 0 on E_U
# ============================================================
cat("=== SEARCH FOR BP AMPLIFICATION > 0 ON E_U ===\n")
cat("Need: mu_s_R1 > tau(U), i.e., screening jump visible in entry set.\n\n")

# Strategy: lower c to bring tau(U) below mu_s_R1
# mu_s_R1 is about 0.197. We need tau(U) < 0.197.
# Lower c => lower tau(U).

search_params <- list(
  list(N=5, r=1.5, alpha=0.3, beta=0.9, c=0.05),
  list(N=5, r=1.5, alpha=0.3, beta=0.9, c=0.03),
  list(N=5, r=1.5, alpha=0.3, beta=0.9, c=0.01),
  list(N=5, r=2.0, alpha=0.2, beta=0.9, c=0.05),
  list(N=5, r=2.0, alpha=0.2, beta=0.9, c=0.02),
  list(N=5, r=1.5, alpha=0.1, beta=0.9, c=0.05),
  list(N=5, r=1.5, alpha=0.1, beta=0.9, c=0.03),
  list(N=10, r=1.5, alpha=0.1, beta=0.9, c=0.01),
  list(N=5, r=1.5, alpha=0.2, beta=0.9, c=0.05),
  list(N=5, r=1.5, alpha=0.2, beta=0.9, c=0.03)
)

for (params in search_params) {
  N_s <- params$N; r_s <- params$r; alpha_s <- params$alpha; beta_s <- params$beta; c_s <- params$c

  mu_s_R1_s <- find_mu_s_R1(r_s, alpha_s, N_s, beta_s)
  tau_U_s <- find_tau_U(r_s, alpha_s, N_s, beta_s, c_s)

  q_s <- floor(N_s/2) + 1
  alpha_star_s <- beta_s * (q_s - 1) / (N_s * (N_s - 1) - beta_s * (N_s^2 - N_s - q_s + 1))

  if (is.na(mu_s_R1_s)) next
  if (alpha_s >= alpha_star_s) next  # need alpha < alpha*

  hit <- mu_s_R1_s > tau_U_s

  if (hit) {
    cat(sprintf("FOUND: N=%d, r=%.1f, alpha=%.1f, beta=%.1f, c=%.2f => mu_s_R1=%.4f, tau(U)=%.4f\n",
                N_s, r_s, alpha_s, beta_s, c_s, mu_s_R1_s, tau_U_s))

    # Compute decomposition at beliefs in E_U near the jump
    mus_s <- seq(0.001, 0.999, by = 0.001)
    v_U_s <- sapply(mus_s, function(m) {
      VW <- VW_R1_unanimity(r_s, alpha_s, m, N_s, beta_s)
      Ve <- 1 + m * (r_s - 1)
      if (VW >= c_s) VH_R1_unanimity(r_s, alpha_s, m, N_s, beta_s) - alpha_s * Ve else 0
    })
    v_M_s <- sapply(mus_s, function(m) {
      VW <- VW_R1_majority(r_s, alpha_s, m, N_s, beta_s)
      Ve <- 1 + m * (r_s - 1)
      if (VW >= c_s) VH_R1_majority(r_s, alpha_s, m, N_s, beta_s) - alpha_s * Ve else 0
    })
    cav_U_s <- concavify(mus_s, v_U_s)

    # Check BP amplification at beliefs around mu_s_R1
    for (p_test in c(tau_U_s + 0.01, mu_s_R1_s - 0.02, mu_s_R1_s, mu_s_R1_s + 0.02, 0.5, 1.0)) {
      if (p_test < 0.001 || p_test > 0.999) next
      idx <- which.min(abs(mus_s - p_test))
      D_p <- v_U_s[idx] - v_M_s[idx]
      BP_amp <- cav_U_s[idx] - v_U_s[idx]
      cat(sprintf("  p=%.3f: v(U)=%.6f, v(M)=%.6f, D=%.6f, cav_U=%.6f, BP_amp=%.6f\n",
                  mus_s[idx], v_U_s[idx], v_M_s[idx], D_p, cav_U_s[idx], BP_amp))
    }
    cat("\n")
  } else {
    cat(sprintf("  N=%d, r=%.1f, alpha=%.1f, beta=%.1f, c=%.2f => mu_s_R1=%.4f, tau(U)=%.4f (NO)\n",
                N_s, r_s, alpha_s, beta_s, c_s, mu_s_R1_s, tau_U_s))
  }
}

# ============================================================
# 13. Verify the v1 analytical p* = 0.123
# ============================================================
cat("\n=== CHECKING v1 ANALYTICAL p* ===\n")
cat("v1 computed: S_U = v(tau(U))/tau(U) ≈ 0.774\n")
cat("  and p* = (lambda_M - alpha) / [S_U - (lambda_M - alpha)(r-1)] ≈ 0.123\n")
# But this assumed cav v(p, U) = S_U * p for p < tau(U)
# The concavification might NOT use tau(U) as tangent point.
# The max-slope point could be different.

# Let's trace what concavify actually does
cat(sprintf("\nActual concavification of v(mu, U):\n"))
cat(sprintf("  v(mu, U) is 0 for mu < tau(U) ≈ %.4f\n", tau_U))
cat(sprintf("  v(mu, U) is positive and affine for mu in [tau(U), 1]\n"))
cat(sprintf("  (since mu_s_R1 ≈ %.4f < tau(U) ≈ %.4f, the jump is not visible)\n\n", mu_s_R1, tau_U))

# The concavification from mu = 0 draws a line from (0, 0) to the steepest tangent point
# Since v is affine on [tau(U), 1], the steepest tangent from origin hits tau(U).
# WAIT: v jumps from 0 to v(tau(U)) at tau(U). The slope from 0 to (tau(U), v(tau(U)))
# might be steeper or shallower than the slope from 0 to (1, v(1)).

slope_to_tauU <- v_U_grid[idx_tau_U] / mus_grid[idx_tau_U]
v1 <- v_U_grid[which.min(abs(mus_grid - 1.0))]
slope_to_1 <- v1 / 1.0
cat(sprintf("Slope from 0 to tau(U): v(%.4f)/%.4f = %.6f/%.4f = %.6f\n",
            mus_grid[idx_tau_U], mus_grid[idx_tau_U], v_U_grid[idx_tau_U], mus_grid[idx_tau_U], slope_to_tauU))
cat(sprintf("Slope from 0 to 1:      v(1)/1 = %.6f\n", slope_to_1))
cat(sprintf("v(tau(U), U) = %.6f\n", v_U_grid[idx_tau_U]))
cat(sprintf("v(1, U) = %.6f\n\n", v1))

# Since v is affine on [tau(U), 1], we need to check whether the line from origin to tau(U)
# lies above or below the v function.
# v(mu, U) on [tau(U), 1]:
# v(tau(U)) + (mu - tau(U)) * [v(1) - v(tau(U))] / (1 - tau(U))
# The line from origin to tau(U): slope_to_tauU * mu
# We need: slope_to_tauU * mu >= v(mu, U) for all mu in [tau(U), 1]
# At mu = 1: slope_to_tauU * 1 vs v(1)
cat(sprintf("At mu=1: concav line from tangent at tau(U) gives %.6f vs v(1)=%.6f\n",
            slope_to_tauU, v1))
cat(sprintf("Line from origin to tau(U) at mu=1: %.6f\n", slope_to_tauU * 1))
cat(sprintf("Is this >= v(1)? %s\n\n", slope_to_tauU >= v1))

# If slope_to_tauU > slope_to_1, then the concavification line from 0 has slope = slope_to_tauU
# and cav v(mu, U) = slope_to_tauU * mu for mu in [0, tau(U)]
# BUT then for mu in [tau(U), 1], the concavification = max(v(mu), slope_to_tauU * mu)
# If slope_to_tauU >= v(1), the line dominates everywhere, and cav = slope_to_tauU * mu for all mu.
# If slope_to_tauU < v(1), the concavification switches from the line to v(mu) at some point.

# Actually, the concave envelope from origin:
# From (0, 0), the steepest-slope line touches the v function. If v is affine on [tau, 1],
# then the maximum slope from origin to the affine segment is max of:
# - v(tau)/tau  (slope to the left endpoint of the affine piece)
# - v(1)/1      (slope to the right endpoint)
# Since v is affine, the max is at one endpoint.

# For the concave envelope, from (0,0), we look at all mu: max v(mu)/mu
# On [0, tau), v=0, so slope=0
# On [tau, 1], v(mu) = a + b*mu (affine), so v(mu)/mu = a/mu + b, decreasing in mu if a > 0
# So max slope from origin = v(tau)/tau = (a + b*tau)/tau

# HOWEVER: the concavify function works differently. It checks the entire grid.
# Let's look at what the concavification actually gives.

cat("=== TRACING CONCAVIFICATION ===\n")
cat("cav v(mu, U) at selected points:\n")
for (mu_test in seq(0.05, 0.40, by = 0.05)) {
  idx <- which.min(abs(mus_grid - mu_test))
  cat(sprintf("  mu=%.2f: v=%8.6f, cav_v=%8.6f, line=%8.6f\n",
              mus_grid[idx], v_U_grid[idx], cav_U[idx], slope_to_tauU * mus_grid[idx]))
}
cat("\n")

# Now check: is the concavification = slope * mu below tau(U)?
cat("Is cav v(mu, U) = S_U * mu for all mu < tau(U)?\n")
below_tau <- mus_grid < tau_U
max_cav_err <- max(abs(cav_U[below_tau] - S_U_actual * mus_grid[below_tau]))
cat(sprintf("Max absolute error: %.2e\n\n", max_cav_err))

# ============================================================
# 14. Now check majority concavification at low priors
# ============================================================
cat("=== MAJORITY CONCAVIFICATION ===\n")
# With tau(M) ≈ 0, check if v(mu, M) > 0 for all mu > 0
idx_low <- which.min(abs(mus_grid - 0.001))
cat(sprintf("v(0.001, M) = %.8f\n", v_M_grid[idx_low]))
cat(sprintf("VW_R1_majority at mu=0.001: %.8f vs c=%.2f\n",
            VW_R1_majority(r, alpha, 0.001, N, beta), c_val))

# Check: is cav v(mu, M) = v(mu, M) everywhere?
max_cav_M_diff <- max(abs(cav_M - v_M_grid))
cat(sprintf("max|cav_M - v_M| = %.2e\n", max_cav_M_diff))
cat(sprintf("=> cav v(mu, M) = v(mu, M) for all mu? %s\n\n", max_cav_M_diff < 1e-8))

# ============================================================
# 15. Resolution of p* discrepancy
# ============================================================
cat("=== RESOLUTION OF p* DISCREPANCY ===\n")
cat(sprintf("Paper claims p* ≈ 0.24\n"))
cat(sprintf("v1 proposal computed p* ≈ 0.123 analytically\n"))
cat(sprintf("Numerical p* = %.4f\n\n", p_star))

# The discrepancy comes from the definition of Pi_H*(R, p):
# Pi_H*(R, p) = alpha * Ve(p) + cav v(p, R)
# Unanimity dominates when Pi_H*(U, p) > Pi_H*(M, p)
# i.e., cav v(p, U) > cav v(p, M)
# For p < tau(U): cav v(p, U) = S_U * p
# For p where tau(M) = 0: cav v(p, M) = v(p, M) = (lambda_M - alpha) * Ve(p)
# So p* solves: S_U * p = (lambda_M - alpha) * (1 + (r-1)*p)
# This is the SAME equation in both v1 and now.
# Let's check the numbers very carefully.

cat("Careful check of the crossing equation:\n")
cat(sprintf("S_U = %.10f\n", S_U_actual))
cat(sprintf("lambda_M - alpha = %.10f\n", lm_minus_a))
cat(sprintf("r - 1 = %.1f\n", r - 1))

cat(sprintf("\nEquation: S_U * p = (lambda_M - alpha)(1 + (r-1)*p)\n"))
cat(sprintf("%.10f * p = %.10f * (1 + %.1f * p)\n", S_U_actual, lm_minus_a, r - 1))
cat(sprintf("%.10f * p = %.10f + %.10f * p\n", S_U_actual, lm_minus_a, lm_minus_a * (r - 1)))
cat(sprintf("p * (%.10f - %.10f) = %.10f\n", S_U_actual, lm_minus_a * (r - 1), lm_minus_a))
cat(sprintf("p = %.10f / %.10f = %.10f\n", lm_minus_a, S_U_actual - lm_minus_a * (r - 1), p_star_analytical))

cat(sprintf("\n=== BUT: IS tau(M) REALLY ≈ 0? ===\n"))
# Let's check more carefully
cat(sprintf("kappa_M = %.10f\n", kappa_M))
cat(sprintf("c / kappa_M = %.10f\n", c_val / kappa_M))
cat(sprintf("(c/kappa_M - 1)/(r-1) = %.10f\n", (c_val / kappa_M - 1) / (r - 1)))
cat(sprintf("tau(M) = max(0, %.10f) = %.10f\n", (c_val / kappa_M - 1) / (r - 1), tau_M))

# If tau(M) > 0, then for p < tau(M), v(p, M) = 0 and cav v(p, M) ≠ v(p, M)
# Need to check the slope of the majority concavification line
if (tau_M > 0) {
  cat(sprintf("\ntau(M) > 0! tau(M) = %.6f\n", tau_M))
  # S_M = max v(mu, M)/mu for mu >= tau(M)
  slopes_M_all <- sapply(which(v_M_grid > 0), function(i) v_M_grid[i] / mus_grid[i])
  if (length(slopes_M_all) > 0) {
    S_M <- max(slopes_M_all)
    idx_M_tangent <- which(v_M_grid > 0)[which.max(slopes_M_all)]
    cat(sprintf("S_M = %.6f at mu = %.4f\n", S_M, mus_grid[idx_M_tangent]))
    cat(sprintf("For p < tau(M): cav v(p, M) = S_M * p = %.6f * p\n", S_M))
    cat(sprintf("For p < tau(U): cav v(p, U) = S_U * p = %.6f * p\n", S_U_actual))
    p_star_revised <- NA
    if (S_U_actual > S_M) {
      cat("S_U > S_M => unanimity ALWAYS better below min(tau(M), tau(U))\n")
      # But we need to check the full crossing
    } else {
      cat("S_U <= S_M => majority better at low priors\n")
    }

    # For p in (tau(M), tau(U)): cav_U = S_U*p, cav_M = v(p,M) = (lambda_M - alpha) * Ve(p)
    # Crossing: S_U * p = (lambda_M - alpha)(1 + (r-1)p) same as before, IF p is in this range
    cat(sprintf("\nCrossing in (tau(M), tau(U)) = (%.4f, %.4f):\n", tau_M, tau_U))
    cat(sprintf("p_star from equation = %.6f\n", p_star_analytical))
    if (p_star_analytical > tau_M && p_star_analytical < tau_U) {
      cat("=> This crossing is in the correct interval.\n")
    } else {
      cat("=> This crossing is NOT in the interval. Need to check other regions.\n")
    }

    # For p < tau(M): cav_U = S_U * p, cav_M = S_M * p
    # If S_U > S_M, unanimity dominates for all p < tau(M).
    # Then p* is in (tau(M), tau(U)) and = the equation solution.
    # If S_U < S_M, majority dominates for p < tau(M), and crossing might be different.
  }
}

# ============================================================
# 16. Double-check p* numerically at finer resolution
# ============================================================
cat("\n=== FINE-GRAINED p* SEARCH ===\n")
mus_fine2 <- seq(0.001, 0.400, by = 0.0001)

v_U_fine <- sapply(mus_fine2, function(m) {
  VW <- VW_R1_unanimity(r, alpha, m, N, beta)
  Ve <- 1 + m * (r - 1)
  if (VW >= c_val) VH_R1_unanimity(r, alpha, m, N, beta) - alpha * Ve else 0
})
v_M_fine <- sapply(mus_fine2, function(m) {
  VW <- VW_R1_majority(r, alpha, m, N, beta)
  Ve <- 1 + m * (r - 1)
  if (VW >= c_val) VH_R1_majority(r, alpha, m, N, beta) - alpha * Ve else 0
})
cav_U_fine <- concavify(mus_fine2, v_U_fine)
cav_M_fine <- concavify(mus_fine2, v_M_fine)

diff_fine <- cav_U_fine - cav_M_fine

# Find crossing
for (i in 2:length(diff_fine)) {
  if (diff_fine[i-1] <= 0 && diff_fine[i] > 0) {
    p_star_fine <- mus_fine2[i-1] + (0 - diff_fine[i-1]) / (diff_fine[i] - diff_fine[i-1]) * (mus_fine2[i] - mus_fine2[i-1])
    cat(sprintf("p* (fine grid) = %.6f\n", p_star_fine))
    break
  }
}

# Print values around the crossing
cat("\nValues around p*:\n")
for (p_test in seq(0.20, 0.30, by = 0.01)) {
  idx <- which.min(abs(mus_fine2 - p_test))
  cat(sprintf("  p=%.2f: cav_U=%.6f, cav_M=%.6f, diff=%.6f\n",
              mus_fine2[idx], cav_U_fine[idx], cav_M_fine[idx], diff_fine[idx]))
}

cat("\n=== END OF VERIFICATION ===\n")
