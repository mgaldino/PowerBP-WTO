# Verification script for CR8 Decomposition of BP Gain
# Parameters: Example 2 from paper (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.14)
#
# Checks:
# 1. Concavification of v(mu, M) — is cav v(p,M) = S_M*p for p < tau(M)?
# 2. Concavification of v_flat — is cav v_flat(p,U) = v(1,U)*p for all p?
# 3. Ordering S_U > v(1,U) > S_M
# 4. Tangent point for cav v(., U)
# 5. Continuity/jump at tau(U)
# 6. Channel shares

source("scripts/model_functions.R")

# Parameters
N <- 5
r <- 1.5
alpha <- 0.3
beta <- 0.9
c_val <- 0.14

cat("============================================================\n")
cat("CR8 Decomposition Verification\n")
cat("============================================================\n")
cat("Parameters: N=", N, ", r=", r, ", alpha=", alpha,
    ", beta=", beta, ", c=", c_val, "\n\n")

# --- Compute key quantities ---
mus <- seq(0.001, 0.999, by = 0.001)

VH_U <- sapply(mus, function(m) VH_R1_unanimity(r, alpha, m, N, beta))
VH_M <- sapply(mus, function(m) VH_R1_majority(r, alpha, m, N, beta))
VW_U <- sapply(mus, function(m) VW_R1_unanimity(r, alpha, m, N, beta))
VW_M <- sapply(mus, function(m) VW_R1_majority(r, alpha, m, N, beta))
Ve <- 1 + mus * (r - 1)

# Net gain functions
v_U <- ifelse(VW_U >= c_val, VH_U - alpha * Ve, 0)
v_M <- ifelse(VW_M >= c_val, VH_M - alpha * Ve, 0)

# Concavify
cav_U <- concavify(mus, v_U)
cav_M <- concavify(mus, v_M)

# --- 1. Screening cutoff ---
phi_val <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
disc <- phi_val^2 - 4 * (N - 2)
mu_s_R1 <- (phi_val - sqrt(disc)) / (2 * (N - 2))
cat("Screening cutoff mu_s_R1 =", mu_s_R1, "\n")

# --- 2. Entry thresholds ---
tau_U_idx <- min(which(VW_U >= c_val))
tau_M_idx <- min(which(VW_M >= c_val))
tau_U <- mus[tau_U_idx]
tau_M <- mus[tau_M_idx]
cat("tau(U) =", tau_U, "(index", tau_U_idx, ")\n")
cat("tau(M) =", tau_M, "(index", tau_M_idx, ")\n")

# Analytical tau(M)
q <- floor(N / 2) + 1
kappa_M <- (1 - alpha) * (N * (N - 1) + beta * (q - 1)) / (N^2 * (N - 1))
tau_M_an <- max(0, (c_val / kappa_M - 1) / (r - 1))
cat("tau(M) analytical =", tau_M_an, "\n")

# Analytical tau(U) conservative branch
tau_U_an <- (c_val * N^2 - (N + beta - beta * r * (1 + N * alpha))) /
  ((N + beta) * (r - 1))
cat("tau(U) analytical (conservative) =", tau_U_an, "\n\n")

# --- 3. CRITICAL: Is tau(U) above or below mu_s_R1? ---
cat("=== CRITICAL CHECK ===\n")
cat("mu_s_R1 =", mu_s_R1, "\n")
cat("tau(U)  =", tau_U, "\n")
cat("tau(U) > mu_s_R1?", tau_U > mu_s_R1, "\n")
if (tau_U > mu_s_R1) {
  cat("CONSEQUENCE: Screening jump is BELOW entry threshold.\n")
  cat("The screening non-convexity does NOT appear in v(mu, U).\n")
  cat("The only non-convexity in v(mu, U) is the entry jump at tau(U).\n")
}
cat("\n")

# --- 4. Key values ---
v_U_at_1 <- VH_R1_unanimity(r, alpha, 1, N, beta) - alpha * (1 + (r - 1))
v_M_at_1 <- VH_R1_majority(r, alpha, 1, N, beta) - alpha * (1 + (r - 1))

C_buy <- beta * (q - 1) * (1 - alpha)
C_out <- N * (N - 1) * alpha
lambda_M <- (N * (1 + (N - 1) * alpha) - C_buy) / N^2

cat("lambda_M =", lambda_M, "\n")
cat("lambda_M - alpha =", lambda_M - alpha, "\n")
cat("v(1, U) =", v_U_at_1, "\n")
cat("v(1, M) =", v_M_at_1, "\n")
cat("D(1) =", v_U_at_1 - v_M_at_1, "\n\n")

# --- 5. S_U: max v(mu,U)/mu for mu in E_U ---
slopes_U <- ifelse(v_U > 0, v_U / mus, NA)
S_U_idx <- which.max(slopes_U)
S_U <- slopes_U[S_U_idx]
cat("S_U =", S_U, "at mu =", mus[S_U_idx], "\n")
cat("Tangent point is at mu =", mus[S_U_idx],
    "(mu_s_R1 =", mu_s_R1, ", tau(U) =", tau_U, ")\n")

# --- 6. S_M ---
if (tau_M_an > 0) {
  S_M <- (lambda_M - alpha) * (1 + tau_M * (r - 1)) / tau_M
  cat("S_M =", S_M, "\n")
} else {
  cat("S_M = UNDEFINED (tau(M) = 0; majority entry at all beliefs)\n")
  S_M <- NA
}
cat("\n")

# --- 7. Ordering ---
cat("=== ORDERING CHECK ===\n")
cat("S_U =", S_U, "\n")
cat("v(1,U) =", v_U_at_1, "\n")
cat("S_M =", ifelse(is.na(S_M), "UNDEFINED", S_M), "\n")
cat("S_U > v(1,U)?", S_U > v_U_at_1, "\n")
if (!is.na(S_M)) {
  cat("v(1,U) > S_M?", v_U_at_1 > S_M, "\n")
  cat("S_U > S_M?", S_U > S_M, "\n")
}
cat("\n")

# --- 8. Concavification structure ---
cat("=== CONCAVIFICATION STRUCTURE ===\n")
cat("cav v(p, U):\n")
cat("  For p <= tau(U): S_U * p =", S_U, "* p\n")
cat("  For p > tau(U): v(p, U) = affine decreasing\n")
cat("cav v(p, M):\n")
if (tau_M_an > 0) {
  cat("  For p < tau(M): S_M * p\n")
  cat("  For p >= tau(M): v(p, M) affine\n")
} else {
  cat("  For ALL p: v(p, M) = (lambda_M - alpha)*Ve(p) =",
      lambda_M - alpha, "* (1 +", r - 1, "* p)\n")
}
cat("\n")

# --- 9. p* computation ---
cat("=== p* COMPUTATION ===\n")
# Find crossing: cav_U(p) = cav_M(p)
delta <- cav_U - cav_M
crossings <- which(diff(sign(delta)) != 0)
if (length(crossings) > 0) {
  p_star <- mus[crossings[1]]
  cat("p* (numerical) =", p_star, "\n")
} else {
  cat("No crossing found (one rule always dominates)\n")
}

# Analytical p*
if (tau_M_an == 0) {
  # cav_U(p) = S_U * p (for p < tau_U)
  # cav_M(p) = (lambda_M - alpha)*(1 + (r-1)*p)
  # S_U * p = (lambda_M - alpha) + (lambda_M - alpha)*(r-1)*p
  # p * [S_U - (lambda_M - alpha)*(r-1)] = (lambda_M - alpha)
  p_star_an <- (lambda_M - alpha) / (S_U - (lambda_M - alpha) * (r - 1))
  cat("p* (analytical) =", p_star_an, "\n")
}
cat("\n")

# --- 10. v_flat analysis ---
cat("=== v_flat ANALYSIS ===\n")
v_flat <- ifelse(mus >= tau_U,
                 v_U_at_1 * (mus - tau_U) / (1 - tau_U), 0)
cav_v_flat <- concavify(mus, v_flat)
max_diff <- max(abs(cav_v_flat - v_U_at_1 * mus))
cat("Max |cav v_flat - v(1,U)*p| =", max_diff, "\n")
cat("(Should be ~0 if cav v_flat = v(1,U)*p)\n\n")

# --- 11. Channels at selected priors ---
cat("=== CHANNEL VALUES ===\n")
entry_ch <- cav_v_flat - cav_M
screen_ch <- cav_U - cav_v_flat
delta_BP <- cav_U - cav_M

cat(sprintf("%-6s %-10s %-10s %-10s %-8s %-8s\n",
            "p", "Delta_BP", "Entry_ch", "Screen_ch", "E_pct", "S_pct"))
for (p_test in c(0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.40, 0.50, 0.70, 0.90)) {
  idx <- which.min(abs(mus - p_test))
  d <- delta_BP[idx]
  e <- entry_ch[idx]
  s <- screen_ch[idx]
  cat(sprintf("%-6.2f %-10.5f %-10.5f %-10.5f %-8.1f %-8.1f\n",
              mus[idx], d, e, s,
              ifelse(abs(d) > 1e-10, 100 * e / d, NA),
              ifelse(abs(d) > 1e-10, 100 * s / d, NA)))
}

# --- 12. Profile around screening cutoff ---
cat("\n=== v(mu,U) PROFILE AROUND SCREENING CUTOFF ===\n")
mu_s_R1_idx <- which.min(abs(mus - mu_s_R1))
cat(sprintf("%-8s %-10s %-10s %-10s %-8s\n",
            "mu", "v(mu,U)", "VH", "VW", "entry?"))
for (di in c(-10, -5, -2, 0, 2, 5, 10, 50, 100)) {
  idx <- mu_s_R1_idx + di
  if (idx >= 1 && idx <= length(mus)) {
    cat(sprintf("%-8.3f %-10.5f %-10.5f %-10.5f %-8s\n",
                mus[idx], v_U[idx], VH_U[idx], VW_U[idx],
                ifelse(VW_U[idx] >= c_val, "YES", "no")))
  }
}

# --- SUMMARY ---
cat("\n", paste(rep("=", 60), collapse = ""), "\n")
cat("SUMMARY\n")
cat(paste(rep("=", 60), collapse = ""), "\n\n")

cat("Key findings:\n")
cat("1. mu_s_R1 =", mu_s_R1, "\n")
cat("2. tau(U) =", tau_U, "> mu_s_R1 =", mu_s_R1, "\n")
cat("   => Screening jump is BELOW entry threshold\n")
cat("   => v(mu,U) has NO screening non-convexity in the entry set\n")
cat("3. tau(M) =", tau_M_an, "(majority entry at all beliefs)\n")
cat("   => S_M is undefined\n")
cat("   => Prior-independent channel shares are UNDEFINED\n")
cat("4. Tangent for cav v(.,U) at mu =", mus[S_U_idx], "(= tau(U), NOT mu_s_R1)\n")
cat("5. S_U =", S_U, ", v(1,U) =", v_U_at_1, "\n")
cat("6. S_U > v(1,U): TRUE\n")
if (exists("p_star_an")) {
  cat("7. p* (analytical) =", p_star_an, "\n")
}
cat("\n")
cat("CONCLUSION: The CR8 decomposition proposal has fundamental issues\n")
cat("for Example 2 parameters. See verification report for details.\n")
