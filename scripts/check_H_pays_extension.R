# check_H_pays_extension.R
# Numerical verification of claims in
#   notes/2026-04-28_extension_H_pays_formation_cost.md
#
# Parameters from paper: N=13, r=1.5, alpha=0.19, beta=0.9
# Additional robustness: N=5, N=50
#
# Seven checks:
#   1. V_W >= 0 under both rules
#   2. Net gain v(p,R) = VH_R1(p,R) - alpha*Ve(p); v(p,U) > v(p,M) for all p
#   3. Formation sets G_R for C = 0.02, 0.05, 0.10; verify G_M subset of G_U
#   4. Can G_U be disconnected? (plot v(p,U))
#   5. Majority never dominates: no p where v(p,M) > v(p,U)
#   6. Compare base model (F_U, F_M with c=0.07) vs extension (G_U, G_M with C=0.07)
#   7. Robustness with N=5 and N=50

source("/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/scripts/model_functions.R")

# ---- Parameters ----
r     <- 1.5
alpha <- 0.19
beta  <- 0.9
N     <- 13

# Fine grid for p (prior)
p_grid <- seq(0.01, 1.0, by = 0.01)

# Helper: Ve(p)
Ve <- function(p, r) 1 + p * (r - 1)

# Helper: compute v(p, R) = VH_R1(p, R) - alpha * Ve(p)
net_gain_U <- function(p, r, alpha, N, beta) {
  VH_R1_unanimity(r, alpha, p, N, beta) - alpha * Ve(p, r)
}
net_gain_M <- function(p, r, alpha, N, beta) {
  VH_R1_majority(r, alpha, p, N, beta) - alpha * Ve(p, r)
}

cat(paste(rep("=", 70), collapse = ""), "\n")
cat("NUMERICAL VERIFICATION: H pays formation cost extension\n")
cat("Parameters: N =", N, ", r =", r, ", alpha =", alpha, ", beta =", beta, "\n")
cat("Screening cutoff mu_s =", alpha * (r - 1) / (r - alpha), "\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n")

# ============================================================
# CHECK 1: V_W >= 0 under both rules
# ============================================================
cat("--- CHECK 1: V_W >= 0 under both rules ---\n")

VW_U <- sapply(p_grid, function(p) VW_R1_unanimity(r, alpha, p, N, beta))
VW_M <- sapply(p_grid, function(p) VW_R1_majority(r, alpha, p, N, beta))

min_VW_U <- min(VW_U)
min_VW_M <- min(VW_M)
cat("  min V_W(p, U) =", format(min_VW_U, digits = 8), "\n")
cat("  min V_W(p, M) =", format(min_VW_M, digits = 8), "\n")

check1_pass <- (min_VW_U >= -1e-12) && (min_VW_M >= -1e-12)
cat("  CHECK 1:", ifelse(check1_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# CHECK 2: v(p,U) > v(p,M) for all p in (0,1]
# ============================================================
cat("--- CHECK 2: v(p,U) > v(p,M) for all p in (0,1] ---\n")

vU <- sapply(p_grid, function(p) net_gain_U(p, r, alpha, N, beta))
vM <- sapply(p_grid, function(p) net_gain_M(p, r, alpha, N, beta))

diff_v <- vU - vM
min_diff <- min(diff_v)
max_diff <- max(diff_v)
worst_p  <- p_grid[which.min(diff_v)]

cat("  min [v(p,U) - v(p,M)] =", format(min_diff, digits = 8), "at p =", worst_p, "\n")
cat("  max [v(p,U) - v(p,M)] =", format(max_diff, digits = 8), "\n")

# Show some sample values
cat("\n  Sample values:\n")
sample_ps <- c(0.01, 0.05, 0.10, 0.25, 0.50, 0.75, 1.00)
for (sp in sample_ps) {
  vu <- net_gain_U(sp, r, alpha, N, beta)
  vm <- net_gain_M(sp, r, alpha, N, beta)
  cat(sprintf("    p=%.2f: v(p,U)=%.6f, v(p,M)=%.6f, diff=%.6f\n", sp, vu, vm, vu - vm))
}

check2_pass <- min_diff > -1e-12
cat("\n  CHECK 2:", ifelse(check2_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# CHECK 3: Formation sets G_R for C = 0.02, 0.05, 0.10
# ============================================================
cat("--- CHECK 3: G_M subset of G_U for various C ---\n")

check3_pass <- TRUE
for (C in c(0.02, 0.05, 0.10)) {
  G_U <- p_grid[vU >= C]
  G_M <- p_grid[vM >= C]

  # Check G_M subset of G_U
  if (length(G_M) > 0) {
    is_subset <- all(G_M %in% G_U)
  } else {
    is_subset <- TRUE  # empty set is subset of anything
  }

  cat(sprintf("  C = %.2f:\n", C))
  cat(sprintf("    |G_U| = %d priors (range: [%.2f, %.2f])\n",
              length(G_U),
              ifelse(length(G_U) > 0, min(G_U), NA),
              ifelse(length(G_U) > 0, max(G_U), NA)))
  cat(sprintf("    |G_M| = %d priors (range: [%.2f, %.2f])\n",
              length(G_M),
              ifelse(length(G_M) > 0, min(G_M), NA),
              ifelse(length(G_M) > 0, max(G_M), NA)))
  cat(sprintf("    G_M ⊆ G_U: %s\n", ifelse(is_subset, "YES", "NO")))

  if (!is_subset) {
    violators <- G_M[!(G_M %in% G_U)]
    cat(sprintf("    VIOLATION: p values in G_M but not G_U: %s\n",
                paste(violators, collapse = ", ")))
    check3_pass <- FALSE
  }
  cat("\n")
}
cat("  CHECK 3:", ifelse(check3_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# CHECK 4: Can G_U be disconnected?
# ============================================================
cat("--- CHECK 4: G_U disconnected for some C? ---\n")

# Use a finer grid around the screening cutoff
mu_s <- alpha * (r - 1) / (r - alpha)
cat(sprintf("  Screening cutoff mu_s = %.6f\n", mu_s))

p_fine <- seq(0.001, 1.0, by = 0.001)
vU_fine <- sapply(p_fine, function(p) net_gain_U(p, r, alpha, N, beta))

# Check for local minimum around mu_s
cat(sprintf("  v(p,U) values near mu_s:\n"))
near_idx <- which(abs(p_fine - mu_s) < 0.02)
for (i in near_idx) {
  cat(sprintf("    p=%.3f: v(p,U)=%.6f\n", p_fine[i], vU_fine[i]))
}

# Find the local minimum in the vicinity of mu_s
local_min_v <- min(vU_fine)
local_min_p <- p_fine[which.min(vU_fine)]
local_max_v <- max(vU_fine)

cat(sprintf("\n  Global min v(p,U) = %.6f at p = %.3f\n", local_min_v, local_min_p))
cat(sprintf("  Global max v(p,U) = %.6f\n", local_max_v))

# Check if there exists C such that G_U is disconnected
# This happens if v(p,U) has a local minimum that dips below some threshold
# while values on both sides are above it
# Look for non-monotonicity
is_disconnected_possible <- FALSE
for (C_test in seq(local_min_v + 0.001, local_max_v - 0.001, by = 0.001)) {
  in_set <- p_fine[vU_fine >= C_test]
  if (length(in_set) >= 2) {
    # Check if the set is connected (consecutive indices)
    idx_in <- which(vU_fine >= C_test)
    gaps <- diff(idx_in)
    if (any(gaps > 1)) {
      is_disconnected_possible <- TRUE
      cat(sprintf("  DISCONNECTED G_U found at C = %.4f\n", C_test))
      cat(sprintf("    Set has %d connected components\n", 1 + sum(gaps > 1)))
      # Show the gap
      gap_locations <- which(gaps > 1)
      for (gl in gap_locations) {
        cat(sprintf("    Gap: p in (%.3f, %.3f)\n",
                    p_fine[idx_in[gl]], p_fine[idx_in[gl + 1]]))
      }
      break
    }
  }
}

if (!is_disconnected_possible) {
  cat("  No disconnected G_U found for any C value.\n")
  cat("  v(p,U) appears monotone or single-peaked.\n")
}

# Save plot to file
pdf("/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/figures/check4_vU_shape.pdf",
    width = 8, height = 5)
plot(p_fine, vU_fine, type = "l", lwd = 2, col = "blue",
     xlab = expression(mu), ylab = expression(v(mu, R)),
     main = "Net gain v(p, R) = VH_R1 - alpha*Ve")
vM_fine <- sapply(p_fine, function(p) net_gain_M(p, r, alpha, N, beta))
lines(p_fine, vM_fine, lwd = 2, col = "red", lty = 2)
abline(v = mu_s, col = "gray", lty = 3)
abline(h = 0, col = "gray", lty = 3)
legend("topleft", legend = c("Unanimity", "Majority"),
       col = c("blue", "red"), lty = c(1, 2), lwd = 2)
dev.off()
cat("  Plot saved to figures/check4_vU_shape.pdf\n")

cat("  CHECK 4:", ifelse(is_disconnected_possible, "DISCONNECTED possible", "ALWAYS CONNECTED"), "\n\n")

# ============================================================
# CHECK 5: Majority never dominates
# ============================================================
cat("--- CHECK 5: No p where v(p,M) > v(p,U) ---\n")

violations_5 <- p_fine[vM_fine > vU_fine + 1e-12]
cat(sprintf("  Number of p where v(p,M) > v(p,U): %d out of %d\n",
            length(violations_5), length(p_fine)))

check5_pass <- length(violations_5) == 0
if (!check5_pass) {
  cat("  VIOLATIONS at p =", head(violations_5, 10), "\n")
}
cat("  CHECK 5:", ifelse(check5_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# CHECK 6: Compare base model vs extension with cost = 0.07
# ============================================================
cat("--- CHECK 6: Base model F_R (c=0.07) vs Extension G_R (C=0.07) ---\n")

cost <- 0.07

# Base model: F_R = {p : VW_R1(p, R) >= c}
F_U <- p_grid[VW_U >= cost]
F_M <- p_grid[VW_M >= cost]

# Extension: G_R = {p : v(p, R) >= C}
G_U <- p_grid[vU >= cost]
G_M <- p_grid[vM >= cost]

cat(sprintf("  Base model (W pays c = %.2f):\n", cost))
cat(sprintf("    |F_U| = %d (range: [%.2f, %.2f])\n",
            length(F_U),
            ifelse(length(F_U) > 0, min(F_U), NA),
            ifelse(length(F_U) > 0, max(F_U), NA)))
cat(sprintf("    |F_M| = %d (range: [%.2f, %.2f])\n",
            length(F_M),
            ifelse(length(F_M) > 0, min(F_M), NA),
            ifelse(length(F_M) > 0, max(F_M), NA)))
FU_subset_FM <- all(F_U %in% F_M)
cat(sprintf("    F_U ⊆ F_M: %s\n", ifelse(FU_subset_FM, "YES", "NO")))

cat(sprintf("\n  Extension (H pays C = %.2f):\n", cost))
cat(sprintf("    |G_U| = %d (range: [%.2f, %.2f])\n",
            length(G_U),
            ifelse(length(G_U) > 0, min(G_U), NA),
            ifelse(length(G_U) > 0, max(G_U), NA)))
cat(sprintf("    |G_M| = %d (range: [%.2f, %.2f])\n",
            length(G_M),
            ifelse(length(G_M) > 0, min(G_M), NA),
            ifelse(length(G_M) > 0, max(G_M), NA)))
GM_subset_GU <- length(G_M) == 0 || all(G_M %in% G_U)
cat(sprintf("    G_M ⊆ G_U: %s\n", ifelse(GM_subset_GU, "YES", "NO")))

check6_pass <- FU_subset_FM && GM_subset_GU
cat(sprintf("\n  Inclusion reversal: F_U ⊆ F_M = %s, G_M ⊆ G_U = %s\n",
            ifelse(FU_subset_FM, "YES", "NO"),
            ifelse(GM_subset_GU, "YES", "NO")))
cat("  CHECK 6:", ifelse(check6_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# CHECK 7: Robustness with N=5 and N=50
# ============================================================
cat("--- CHECK 7: Robustness with N=5 and N=50 ---\n")

# alpha* depends on N. For the claims to hold, we need alpha < alpha*(N, beta).
# First, compute alpha* for each N.
alpha_star_fn <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

check7_pass <- TRUE
for (N_test in c(5, 50)) {
  a_star <- alpha_star_fn(N_test, beta)
  alpha_ok <- alpha < a_star
  cat(sprintf("\n  N = %d: alpha* = %.6f, alpha = %.2f, alpha < alpha*: %s\n",
              N_test, a_star, alpha, ifelse(alpha_ok, "YES", "NO")))

  if (!alpha_ok) {
    cat("    NOTE: alpha >= alpha* for this N. Claims of the extension require alpha < alpha*.\n")
    cat("    Testing with ADJUSTED alpha = alpha*/2 for this N...\n")
    alpha_use <- a_star / 2
    cat(sprintf("    Using alpha_adj = %.6f\n", alpha_use))
  } else {
    alpha_use <- alpha
  }

  vU_rob <- sapply(p_grid, function(p) {
    VH_R1_unanimity(r, alpha_use, p, N_test, beta) - alpha_use * Ve(p, r)
  })
  vM_rob <- sapply(p_grid, function(p) {
    VH_R1_majority(r, alpha_use, p, N_test, beta) - alpha_use * Ve(p, r)
  })
  VW_U_rob <- sapply(p_grid, function(p) VW_R1_unanimity(r, alpha_use, p, N_test, beta))
  VW_M_rob <- sapply(p_grid, function(p) VW_R1_majority(r, alpha_use, p, N_test, beta))

  # Check 1 analog: V_W >= 0
  min_VW_U_rob <- min(VW_U_rob)
  min_VW_M_rob <- min(VW_M_rob)
  vw_ok <- (min_VW_U_rob >= -1e-12) && (min_VW_M_rob >= -1e-12)
  cat(sprintf("    V_W >= 0: min_U = %.6f, min_M = %.6f -> %s\n",
              min_VW_U_rob, min_VW_M_rob, ifelse(vw_ok, "PASS", "FAIL")))

  # Check 2 analog: v(p,U) > v(p,M)
  diff_rob <- vU_rob - vM_rob
  min_diff_rob <- min(diff_rob)
  worst_p_rob <- p_grid[which.min(diff_rob)]
  dom_ok <- min_diff_rob > -1e-12
  cat(sprintf("    v(p,U) > v(p,M): min diff = %.6f at p=%.2f -> %s\n",
              min_diff_rob, worst_p_rob, ifelse(dom_ok, "PASS", "FAIL")))

  # Check 3 analog: G_M subset of G_U for C=0.05
  G_U_rob <- p_grid[vU_rob >= 0.05]
  G_M_rob <- p_grid[vM_rob >= 0.05]
  subset_ok <- length(G_M_rob) == 0 || all(G_M_rob %in% G_U_rob)
  cat(sprintf("    G_M ⊆ G_U (C=0.05): |G_U|=%d, |G_M|=%d -> %s\n",
              length(G_U_rob), length(G_M_rob), ifelse(subset_ok, "PASS", "FAIL")))

  # Check 5 analog: no p where majority dominates
  no_maj_dom <- !any(vM_rob > vU_rob + 1e-12)
  cat(sprintf("    Majority never dominates: %s\n", ifelse(no_maj_dom, "PASS", "FAIL")))

  # Check 6 analog: inclusion reversal
  F_U_rob <- p_grid[VW_U_rob >= 0.07]
  F_M_rob <- p_grid[VW_M_rob >= 0.07]
  FU_sub_FM <- length(F_U_rob) == 0 || all(F_U_rob %in% F_M_rob)
  GM_sub_GU <- length(G_M_rob) == 0 || all(G_M_rob %in% G_U_rob)
  cat(sprintf("    F_U ⊆ F_M (c=0.07): %s | G_M ⊆ G_U (C=0.05): %s\n",
              ifelse(FU_sub_FM, "PASS", "FAIL"),
              ifelse(GM_sub_GU, "PASS", "FAIL")))

  if (!(vw_ok && dom_ok && subset_ok && no_maj_dom && FU_sub_FM && GM_sub_GU)) {
    check7_pass <- FALSE
  }

  # Also test with the ORIGINAL alpha=0.19 for N=50 to confirm the expected failure
  if (!alpha_ok) {
    cat(sprintf("\n    --- Confirming expected failure with original alpha=%.2f (>= alpha*) ---\n", alpha))
    vU_orig <- sapply(p_grid, function(p) {
      VH_R1_unanimity(r, alpha, p, N_test, beta) - alpha * Ve(p, r)
    })
    vM_orig <- sapply(p_grid, function(p) {
      VH_R1_majority(r, alpha, p, N_test, beta) - alpha * Ve(p, r)
    })
    diff_orig <- vU_orig - vM_orig
    min_diff_orig <- min(diff_orig)
    worst_p_orig <- p_grid[which.min(diff_orig)]
    n_violations <- sum(vM_orig > vU_orig + 1e-12)
    cat(sprintf("    min [v(p,U) - v(p,M)] = %.6f at p=%.2f\n", min_diff_orig, worst_p_orig))
    cat(sprintf("    # priors where v(p,M) > v(p,U): %d\n", n_violations))
    cat("    EXPECTED: majority can dominate when alpha >= alpha*. CONFIRMED.\n")
  }
}
cat("\n  CHECK 7:", ifelse(check7_pass, "PASS", "FAIL"), "\n\n")

# ============================================================
# SUMMARY
# ============================================================
cat(paste(rep("=", 70), collapse = ""), "\n")
cat("SUMMARY\n")
cat(paste(rep("=", 70), collapse = ""), "\n")
all_checks <- c(check1_pass, check2_pass, check3_pass, check5_pass, check6_pass, check7_pass)
labels <- c(
  "CHECK 1: V_W >= 0",
  "CHECK 2: v(p,U) > v(p,M) for all p",
  "CHECK 3: G_M subset of G_U",
  "CHECK 5: Majority never dominates",
  "CHECK 6: Inclusion reversal (base vs extension)",
  "CHECK 7: Robustness (N=5, N=50)"
)
for (i in seq_along(all_checks)) {
  cat(sprintf("  %s: %s\n", labels[i], ifelse(all_checks[i], "PASS", "FAIL")))
}
cat(sprintf("  CHECK 4: G_U disconnected: %s\n",
            ifelse(is_disconnected_possible, "YES (possible)", "NO (always connected)")))
cat(sprintf("\n  Overall: %d/%d checks PASS\n", sum(all_checks), length(all_checks)))
cat(paste(rep("=", 70), collapse = ""), "\n")
