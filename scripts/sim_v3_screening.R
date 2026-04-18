# ==============================================================================
# V3 Simplified: 2-Round BF with Screening Channel (N=3)
# ==============================================================================
#
# Reference: quality_reports/plans/2026-04-18_v3-simplified-screening-plan.md
#
# Model:
#   - N = 3 players: H (hegemon, informed) + W_1, W_2 (weak, uninformed)
#   - theta in {0,1}, Pr(theta=1) = p (prior)
#   - Pie: V(0) = 1, V(1) = v > 1. Expected pie: V_e(mu) = 1 + mu*(v-1)
#   - Discount factor: beta in (0,1)
#   - Disagreement payoff: d_i(theta) = V(theta)/N
#   - 2 rounds. Round 2 is terminal.
#
# Packages:
#   - Package A: majority + agenda (H always proposes)
#   - Package C: consensus + random recognition (1/3 each), unanimity
#
# Key mechanism: Screening by W when W proposes under Package C.
#   W's offer to H can be aggressive (beta/3, accepted only by theta=0)
#   or conservative (beta*Psi(mu), accepted by both).
#   Screening threshold mu_s: root of a cubic in mu.
#   H's value function has an UPWARD JUMP at mu_s.
#
# ==============================================================================

library(tidyverse)

# No stochastic operations in this script — no set.seed needed

# --- 0. Output directories ---
# Use here::here() if available, otherwise detect from working directory
project_root <- tryCatch(
  here::here(),
  error = function(e) {
    # Fallback: if running from scripts/, go up one level
    wd <- getwd()
    if (basename(wd) == "scripts") dirname(wd) else wd
  }
)
fig_dir <- file.path(project_root, "figures")
if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)
cat("Project root:", project_root, "\n")
cat("Figures dir:", fig_dir, "\n\n")

# --- 1. Core Functions (N=3) ---

# Expected pie
V_e <- function(mu, v) 1 + mu * (v - 1)

# Omega(mu) = V_W^{R2}(C, mu) -- W's Round 2 expected payoff under Package C
# Plan Appendix A: [3 + (v-1)(mu^2 + 2mu)] / 9
Omega <- function(mu, v) (3 + (v - 1) * (mu^2 + 2 * mu)) / 9

# Psi(mu) = V_H^{R2}(C, theta=1, mu) -- H's Round 2 payoff when theta=1
# Plan Appendix A: [5v - 2 - 2mu(v-1)] / 9
Psi <- function(mu, v) (5 * v - 2 - 2 * mu * (v - 1)) / 9

# --- 2. Package A (majority + agenda, H always proposes) ---

# V_W(A, mu) = beta * V_e(mu) / 12  (Plan Section 4)
V_W_A <- function(mu, v, beta) beta * V_e(mu, v) / 12

# E[V_H(A, mu)] = V_e(mu) * (6 - beta) / 6  (Plan Section 4)
V_H_A <- function(mu, v, beta) V_e(mu, v) * (6 - beta) / 6

# Entry threshold for Package A (Plan Section 7.1)
# mu + V_W(A, mu) = c  =>  mu + beta * V_e(mu) / 12 = c
# mu + beta * (1 + mu*(v-1)) / 12 = c
# mu * (1 + beta*(v-1)/12) + beta/12 = c
# mu = (c - beta/12) / (1 + beta*(v-1)/12) = (12c - beta) / (12 + beta*(v-1))
tau_A <- function(v, beta, cost) {
  num <- 12 * cost - beta
  den <- 12 + beta * (v - 1)
  num / den
}

# --- 3. Screening Threshold mu_s (cubic root) ---

# 9*Delta_1(mu) = -9*mu*v + beta*[5(v-1) + mu*(8+v) + (v-1)*(2*mu^2 + mu^3)]
# Plan Section 5.3 / Appendix B
Delta_1_times_9 <- function(mu, v, beta) {
  -9 * mu * v + beta * (5 * (v - 1) + mu * (8 + v) + (v - 1) * (2 * mu^2 + mu^3))
}

# Normalized cubic: mu^3 + 2*mu^2 - k*mu + 5 = 0
# where k = [9v - beta*(8+v)] / [beta*(v-1)]
# Plan Appendix B
find_mu_s <- function(v, beta, tol = 1e-10) {
  if (v <= 1) return(NA_real_)  # no uncertainty

  # Use Delta_1 directly for root-finding
  f <- function(mu) Delta_1_times_9(mu, v, beta)

  # Check signs at boundaries (Plan Section 5.4)
  f0 <- f(0)   # Should be > 0 (aggressive preferred at mu=0)
  f1 <- f(1)   # Should be < 0 (conservative preferred at mu=1)

  if (f0 <= 0 || f1 >= 0) {
    warning(sprintf("Boundary conditions violated: f(0)=%.4f, f(1)=%.4f for v=%.2f, beta=%.2f",
                    f0, f1, v, beta))
    return(NA_real_)
  }

  # Bisection + Brent's method via uniroot
  result <- uniroot(f, interval = c(0, 1), tol = tol)
  result$root
}

# Jump magnitude at mu_s (Plan Section 6.3)
# Jump = 10 * beta * (v-1) * (1 - mu_s) / 27
jump_at_mu_s <- function(mu_s, v, beta) {
  10 * beta * (v - 1) * (1 - mu_s) / 27
}

# --- 4. Round 1 Payoffs for W when W proposes (Package C) ---

# F_1^{agg}(mu): W's expected payoff from aggressive offer in Round 1
# Plan Section 5.2:
# (1-mu)*[1 - beta*Omega(mu) - beta/3] + mu*beta*v/3
F1_agg <- function(mu, v, beta) {
  (1 - mu) * (1 - beta * Omega(mu, v) - beta / 3) + mu * beta * v / 3
}

# F_1^{con}(mu): W's expected payoff from conservative offer in Round 1
# Plan Section 5.2:
# V_e(mu) - beta*[Omega(mu) + Psi(mu)]
# Omega + Psi = [1 + 5v + (v-1)*mu^2] / 9  (Plan Section 5.3)
F1_con <- function(mu, v, beta) {
  V_e(mu, v) - beta * (1 + 5 * v + (v - 1) * mu^2) / 9
}

# --- 5. Continuation Values under Package C ---

# E[V_H(C, mu)] -- H's expected payoff (Plan Section 6.2)
#
# For mu < mu_s (aggressive):
#   E[V_H] = V_e(mu)*(3 + 2*beta)/9 - 2*beta*Omega(mu)/3
#
# For mu > mu_s (conservative):
#   E[V_H] = V_e(mu)/3 - 2*beta*Omega(mu)/3 + 2*beta*Psi(mu)/3

V_H_C <- function(mu, v, beta, mu_s) {
  # Vectorized: aggressive below mu_s, conservative above
  ifelse(mu < mu_s,
    V_e(mu, v) * (3 + 2 * beta) / 9 - 2 * beta * Omega(mu, v) / 3,  # aggressive
    V_e(mu, v) / 3 - 2 * beta * Omega(mu, v) / 3 + 2 * beta * Psi(mu, v) / 3  # conservative
  )
}

# V_W(C, mu) -- W's expected payoff (Plan Section 6.5)
#
# For mu < mu_s (aggressive):
#   (1/3)*beta*Omega(mu) + (1/3)*F1_agg(mu) + (1/3)*[(1-mu)*beta*Omega(mu) + mu*beta*v/3]
#
# For mu > mu_s (conservative):
#   (2/3)*beta*Omega(mu) + (1/3)*F1_con(mu)

V_W_C <- function(mu, v, beta, mu_s) {
  # Vectorized: aggressive below mu_s, conservative above
  agg <- (1/3) * beta * Omega(mu, v) +
    (1/3) * F1_agg(mu, v, beta) +
    (1/3) * ((1 - mu) * beta * Omega(mu, v) + mu * beta * v / 3)
  con <- (2/3) * beta * Omega(mu, v) + (1/3) * F1_con(mu, v, beta)
  ifelse(mu < mu_s, agg, con)
}

# --- 6. Entry Threshold for Package C ---

# Entry condition (Plan Section 7.1): W enters iff mu + V_W(R, mu) >= c
# The mu term captures W's direct benefit from E[theta|s] = mu.
# tau(R) is the threshold posterior where W is indifferent about entry.
#
# Package A: mu + beta*V_e(mu)/12 = c  =>  tau(A) closed-form (see above)
# Package C: mu + V_W(C, mu) = c  =>  solve numerically (piecewise function)

find_tau_C <- function(v, beta, cost, mu_s) {
  f <- function(mu) mu + V_W_C(mu, v, beta, mu_s) - cost

  # Check if entry is feasible at mu = 1
  if (f(1) < 0) return(NA_real_)  # cost too high, no entry even at mu=1

  # Check if entry at mu = 0
  if (f(0) >= 0) return(0)  # entry even at mu=0

  # V_W_C has a discontinuity at mu_s, so search in each regime separately
  # and take the smallest root found
  roots <- c()

  # Search in aggressive regime [0, mu_s)
  if (f(0) < 0 && f(pmin(mu_s - 1e-10, 1)) > 0) {
    r <- tryCatch(
      uniroot(f, interval = c(0, pmin(mu_s - 1e-10, 1)), tol = 1e-10),
      error = function(e) NULL
    )
    if (!is.null(r)) roots <- c(roots, r$root)
  }

  # Search in conservative regime [mu_s, 1]
  f_at_ms <- f(mu_s)
  if (f_at_ms < 0 && f(1) > 0) {
    r <- tryCatch(
      uniroot(f, interval = c(mu_s, 1), tol = 1e-10),
      error = function(e) NULL
    )
    if (!is.null(r)) roots <- c(roots, r$root)
  } else if (f_at_ms >= 0 && length(roots) == 0) {
    roots <- c(roots, mu_s)
  }

  if (length(roots) == 0) return(NA_real_)
  min(roots)
}

# --- 7. BP Value Functions and Concavification ---

# v(mu, R) = 1{mu >= tau(R)} * [g + E[V_H(R, mu)]]

# Value function for Package A (linear above threshold)
v_func_A <- function(mu, v, beta, cost, g) {
  threshold <- tau_A(v, beta, cost)
  ifelse(mu >= threshold, g + V_H_A(mu, v, beta), 0)
}

# Value function for Package C (piecewise with jump at mu_s)
v_func_C <- function(mu, v, beta, cost, g, mu_s) {
  threshold <- find_tau_C(v, beta, cost, mu_s)
  if (is.na(threshold)) return(rep(0, length(mu)))
  ifelse(mu >= threshold, g + V_H_C(mu, v, beta, mu_s), 0)
}

# Concavification: upper concave envelope via gift-wrapping (O(n))
# This implements the standard "upper concave envelope" algorithm.
concavify_fast <- function(mu_grid, f_vals) {
  n <- length(mu_grid)
  if (n <= 2) return(f_vals)

  # Build upper concave envelope using the "gift wrapping" approach
  # Start from the left, always pick the steepest line to a point to the right
  cav_vals <- numeric(n)

  # Stack of points on the concave envelope (indices)
  hull <- integer(0)

  for (i in seq_len(n)) {
    # Remove points from the hull that would create a non-concave shape
    while (length(hull) >= 2) {
      j <- hull[length(hull)]
      k <- hull[length(hull) - 1]
      # Check if j is below the line from k to i
      slope_ki <- (f_vals[i] - f_vals[k]) / (mu_grid[i] - mu_grid[k])
      slope_kj <- (f_vals[j] - f_vals[k]) / (mu_grid[j] - mu_grid[k])
      if (slope_kj <= slope_ki) {
        hull <- hull[-length(hull)]
      } else {
        break
      }
    }
    hull <- c(hull, i)
  }

  # Interpolate between hull points
  for (seg in seq_len(length(hull) - 1)) {
    i1 <- hull[seg]
    i2 <- hull[seg + 1]
    for (i in i1:i2) {
      if (mu_grid[i2] == mu_grid[i1]) {
        cav_vals[i] <- max(f_vals[i1], f_vals[i2])
      } else {
        t <- (mu_grid[i] - mu_grid[i1]) / (mu_grid[i2] - mu_grid[i1])
        cav_vals[i] <- (1 - t) * f_vals[i1] + t * f_vals[i2]
      }
    }
  }

  cav_vals
}

# Optimal BP payoff: cav[v_R](p)
U_H_star <- function(p, mu_grid, cav_vals) {
  # Interpolate cav at p
  approx(mu_grid, cav_vals, xout = p, rule = 2)$y
}

# ==============================================================================
# --- 8. Verification Checks ---
# ==============================================================================

cat("\n========================================\n")
cat("VERIFICATION CHECKS\n")
cat("========================================\n\n")

# Check 1: v = 1 (no uncertainty about pie type, but theta still varies)
# When v=1, V(0) = V(1) = 1, so there is no informational asymmetry.
# mu_s should not be well-defined (or degenerate).
cat("--- Check 1: v = 1 (homogeneous pie) ---\n")
cat("V_H(A, mu=0.5, v=1, beta=0.5):", V_H_A(0.5, 1, 0.5), "\n")
cat("V_W(A, mu=0.5, v=1, beta=0.5):", V_W_A(0.5, 1, 0.5), "\n")
cat("Expected: V_H = (6-0.5)/6 =", (6-0.5)/6, "V_W = 0.5/12 =", 0.5/12, "\n")
cat("Omega(0.5, v=1):", Omega(0.5, 1), "= 1/3 (correct since V_W^R2 = V_e/3 = 1/3)\n")
cat("Psi(0.5, v=1):", Psi(0.5, 1), "= 1/3 (correct since V_H^R2 = (5-2)/9 = 1/3)\n\n")

# Check 2: Boundary conditions for Omega and Psi
cat("--- Check 2: Boundary conditions (Plan Section 3.4) ---\n")
v_test <- 1.5
cat(sprintf("Omega(0, v=%.1f) = %.4f (should be 1/3 = %.4f)\n", v_test, Omega(0, v_test), 1/3))
cat(sprintf("Omega(1, v=%.1f) = %.4f (should be v/3 = %.4f)\n", v_test, Omega(1, v_test), v_test/3))
cat(sprintf("Psi(0, v=%.1f) = %.4f (should be (5v-2)/9 = %.4f)\n", v_test, Psi(0, v_test), (5*v_test-2)/9))
cat(sprintf("Psi(1, v=%.1f) = %.4f (should be v/3 = %.4f)\n", v_test, Psi(1, v_test), v_test/3))
cat("\n")

# Check 3: Delta_1 boundary signs (Plan Section 5.4)
cat("--- Check 3: Delta_1 boundary signs ---\n")
for (v_test in c(1.2, 1.5, 2.0)) {
  for (beta_test in c(0.3, 0.5, 0.9)) {
    d0 <- Delta_1_times_9(0, v_test, beta_test)
    d1 <- Delta_1_times_9(1, v_test, beta_test)
    ok <- d0 > 0 && d1 < 0
    cat(sprintf("  v=%.1f, beta=%.1f: Delta(0)=%+.3f, Delta(1)=%+.3f  %s\n",
                v_test, beta_test, d0, d1, ifelse(ok, "OK", "FAIL")))
  }
}
cat("\n")

# Check 4: mu_s numerical examples (Plan Section 5.5)
cat("--- Check 4: mu_s numerical examples ---\n")
mu_s_test1 <- find_mu_s(1.5, 0.5)
cat(sprintf("  v=1.5, beta=0.5: mu_s = %.4f (plan says ~0.144)\n", mu_s_test1))
mu_s_test2 <- find_mu_s(1.5, 0.9)
cat(sprintf("  v=1.5, beta=0.9: mu_s = %.4f (plan says ~0.51)\n", mu_s_test2))
cat("\n")

# Check 5: Jump is positive (Plan Section 6.3)
cat("--- Check 5: Jump at mu_s ---\n")
for (v_test in c(1.2, 1.5, 2.0)) {
  for (beta_test in c(0.5, 0.9)) {
    ms <- find_mu_s(v_test, beta_test)
    if (!is.na(ms)) {
      jmp <- jump_at_mu_s(ms, v_test, beta_test)
      cat(sprintf("  v=%.1f, beta=%.1f: mu_s=%.4f, jump=%.6f (>0: %s)\n",
                  v_test, beta_test, ms, jmp, ifelse(jmp > 0, "OK", "FAIL")))
    }
  }
}
cat("\n")

# Check 6: Budget balance -- V_H + 2*V_W = V_e(mu) (approximately, given discounting)
cat("--- Check 6: Budget balance check ---\n")
v_test <- 1.5; beta_test <- 0.7
ms <- find_mu_s(v_test, beta_test)
for (mu_test in c(0.1, 0.3, 0.5, 0.8)) {
  vh <- V_H_C(mu_test, v_test, beta_test, ms)
  vw <- V_W_C(mu_test, v_test, beta_test, ms)
  total <- vh + 2 * vw
  ve <- V_e(mu_test, v_test)
  # Under discounting, total <= V_e(mu) due to delay costs
  cat(sprintf("  mu=%.1f: V_H=%.4f, 2*V_W=%.4f, total=%.4f, V_e=%.4f (total<=V_e: %s)\n",
              mu_test, vh, 2*vw, total, ve, ifelse(total <= ve + 1e-8, "OK", "FAIL")))
}

# Package A budget balance: exact
cat("\n  Package A budget balance:\n")
for (mu_test in c(0.1, 0.3, 0.5, 0.8)) {
  vh <- V_H_A(mu_test, v_test, beta_test)
  vw <- V_W_A(mu_test, v_test, beta_test)
  total <- vh + 2 * vw
  ve <- V_e(mu_test, v_test)
  cat(sprintf("  mu=%.1f: V_H=%.4f, 2*V_W=%.4f, total=%.4f, V_e=%.4f\n",
              mu_test, vh, 2*vw, total, ve))
}
cat("\n")

# Check 7: Assumption P
cat("--- Check 7: Assumption P (pooling condition) ---\n")
cat("v < 3/(2*beta). For beta=0.5: v <", 3/(2*0.5), "\n")
cat("For beta=0.9: v <", 3/(2*0.9), "\n\n")

# Check 8: beta = 0 (single-round game)
cat("--- Check 8: beta = 0 ---\n")
cat("V_H(A, mu=0.5, v=1.5, beta=0) =", V_H_A(0.5, 1.5, 0), "(should be V_e = 1.25)\n")
cat("V_W(A, mu=0.5, v=1.5, beta=0) =", V_W_A(0.5, 1.5, 0), "(should be 0)\n")
cat("H captures entire pie when beta=0 (single round, take-it-or-leave-it).\n\n")


# ==============================================================================
# --- 9. Simulation and Plots ---
# ==============================================================================

cat("\n========================================\n")
cat("SIMULATION AND PLOTS\n")
cat("========================================\n\n")

# Fine grid for mu
mu_grid <- seq(0, 1, length.out = 1001)

# --- Figure 1: mu_s as function of v for several beta values ---
cat("Generating fig_v3_screening_threshold.png...\n")

v_range <- seq(1.05, 2.5, by = 0.01)
beta_vals <- c(0.3, 0.5, 0.7, 0.9)

threshold_data <- expand_grid(v = v_range, beta = beta_vals) %>%
  mutate(
    # Check Assumption P: v < 3/(2*beta)
    assumption_p = v < 3 / (2 * beta)
  ) %>%
  filter(assumption_p) %>%
  rowwise() %>%
  mutate(mu_s = find_mu_s(v, beta)) %>%
  ungroup() %>%
  filter(!is.na(mu_s))

p1 <- ggplot(threshold_data, aes(x = v, y = mu_s, color = factor(beta))) +
  geom_line(linewidth = 0.8) +
  labs(
    title = expression("Screening Threshold " * mu[s] * " as Function of Pie Ratio " * italic(v)),
    subtitle = "N = 3, 2-round BF with screening channel",
    x = expression(italic(v) == V[H] / V[L]),
    y = expression(mu[s]),
    color = expression(beta)
  ) +
  scale_color_brewer(palette = "Set1") +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

ggsave(file.path(fig_dir, "fig_v3_screening_threshold.png"), p1,
       width = 8, height = 5, dpi = 300)
cat("  Saved.\n")

# --- Figure 2: Value functions v_A(mu) and v_C(mu) showing the jump ---
cat("Generating fig_v3_value_functions.png...\n")

# Specific parameters
v_plot <- 1.5
beta_plot <- 0.7
g_plot <- 0.5
c_plot <- 0.5

# Verify Assumption P for plot parameters
stopifnot(v_plot < 3 / (2 * beta_plot))  # Assumption P: pooling feasible

ms_plot <- find_mu_s(v_plot, beta_plot)
tau_a_plot <- tau_A(v_plot, beta_plot, c_plot)
tau_c_plot <- find_tau_C(v_plot, beta_plot, c_plot, ms_plot)

cat(sprintf("  Parameters: v=%.1f, beta=%.1f, g=%.1f, c=%.1f\n", v_plot, beta_plot, g_plot, c_plot))
cat(sprintf("  mu_s = %.4f, tau_A = %.4f, tau_C = %.4f\n", ms_plot, tau_a_plot,
            ifelse(is.na(tau_c_plot), NA, tau_c_plot)))
cat(sprintf("  Jump at mu_s = %.6f\n", jump_at_mu_s(ms_plot, v_plot, beta_plot)))

vf_A <- v_func_A(mu_grid, v_plot, beta_plot, c_plot, g_plot)
vf_C <- v_func_C(mu_grid, v_plot, beta_plot, c_plot, g_plot, ms_plot)

vf_data <- tibble(
  mu = rep(mu_grid, 2),
  value = c(vf_A, vf_C),
  package = rep(c("A (majority + agenda)", "C (consensus)"), each = length(mu_grid))
)

p2 <- ggplot(vf_data, aes(x = mu, y = value, color = package)) +
  geom_line(linewidth = 0.8) +
  geom_vline(xintercept = ms_plot, linetype = "dashed", color = "grey40", linewidth = 0.5) +
  annotate("text", x = ms_plot + 0.02, y = max(vf_C, na.rm = TRUE) * 0.15,
           label = paste0("mu_s = ", round(ms_plot, 3)),
           hjust = 0, size = 3.5, color = "grey30") +
  geom_vline(xintercept = tau_a_plot, linetype = "dotted", color = "#E41A1C", linewidth = 0.5) +
  {if (!is.na(tau_c_plot))
    geom_vline(xintercept = tau_c_plot, linetype = "dotted", color = "#377EB8", linewidth = 0.5)
  } +
  labs(
    title = "H's Value Functions under BP",
    subtitle = sprintf("v = %.1f, beta = %.1f, g = %.1f, c = %.1f", v_plot, beta_plot, g_plot, c_plot),
    x = expression(mu ~ "(posterior belief)"),
    y = expression(v(mu, R)),
    color = "Package"
  ) +
  scale_color_manual(values = c("A (majority + agenda)" = "#E41A1C",
                                "C (consensus)" = "#377EB8")) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

ggsave(file.path(fig_dir, "fig_v3_value_functions.png"), p2,
       width = 9, height = 5.5, dpi = 300)
cat("  Saved.\n")

# --- Figure 3: v_C(mu) with concave closure overlaid ---
cat("Generating fig_v3_concavification.png...\n")

cav_C <- concavify_fast(mu_grid, vf_C)

cav_data <- tibble(
  mu = rep(mu_grid, 2),
  value = c(vf_C, cav_C),
  curve = rep(c("v_C(mu)", "cav[v_C](mu)"), each = length(mu_grid))
)

p3 <- ggplot(cav_data, aes(x = mu, y = value, color = curve, linetype = curve)) +
  geom_line(linewidth = 0.8) +
  geom_vline(xintercept = ms_plot, linetype = "dashed", color = "grey40", linewidth = 0.5) +
  annotate("text", x = ms_plot + 0.02, y = max(cav_C, na.rm = TRUE) * 0.15,
           label = paste0("mu_s = ", round(ms_plot, 3)),
           hjust = 0, size = 3.5, color = "grey30") +
  scale_color_manual(values = c("v_C(mu)" = "#377EB8", "cav[v_C](mu)" = "#FF7F00")) +
  scale_linetype_manual(values = c("v_C(mu)" = "solid", "cav[v_C](mu)" = "dashed")) +
  labs(
    title = "Concavification of H's Value Function under Package C",
    subtitle = sprintf("v = %.1f, beta = %.1f, g = %.1f, c = %.1f | Jump at mu_s captures BP value",
                       v_plot, beta_plot, g_plot, c_plot),
    x = expression(mu ~ "(posterior belief)"),
    y = "Value",
    color = NULL, linetype = NULL
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

ggsave(file.path(fig_dir, "fig_v3_concavification.png"), p3,
       width = 9, height = 5.5, dpi = 300)
cat("  Saved.\n")

# --- Figure 4: U_H*(A) vs U_H*(C) as functions of p ---
cat("Generating fig_v3_payoff_comparison.png...\n")

# Concavify both
cav_A <- concavify_fast(mu_grid, vf_A)

p_range <- seq(0, 1, length.out = 501)

# Interpolate cav values at each p
U_star_A <- approx(mu_grid, cav_A, xout = p_range, rule = 2)$y
U_star_C <- approx(mu_grid, cav_C, xout = p_range, rule = 2)$y

payoff_data <- tibble(
  p = rep(p_range, 2),
  U_star = c(U_star_A, U_star_C),
  package = rep(c("A (majority + agenda)", "C (consensus)"), each = length(p_range))
)

p4 <- ggplot(payoff_data, aes(x = p, y = U_star, color = package)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = expression("Optimal BP Payoff " * U[H]^"*" * "(R) by Prior " * italic(p)),
    subtitle = sprintf("v = %.1f, beta = %.1f, g = %.1f, c = %.1f", v_plot, beta_plot, g_plot, c_plot),
    x = expression(italic(p) ~ "= Pr(" * theta * " = 1)"),
    y = expression(U[H]^"*" ~ "(R)"),
    color = "Package"
  ) +
  scale_color_manual(values = c("A (majority + agenda)" = "#E41A1C",
                                "C (consensus)" = "#377EB8")) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

ggsave(file.path(fig_dir, "fig_v3_payoff_comparison.png"), p4,
       width = 9, height = 5.5, dpi = 300)
cat("  Saved.\n")

# --- Figure 5: Dominance region heatmap ---
cat("Generating fig_v3_dominance_region.png...\n")

# Sweep over (v, beta) for fixed (g, c, p)
p_fixed <- 0.15
g_fixed <- 0.5
c_fixed <- 0.5

v_sweep <- seq(1.05, 2.5, by = 0.05)
beta_sweep <- seq(0.1, 0.95, by = 0.05)

dominance_data <- expand_grid(v = v_sweep, beta = beta_sweep) %>%
  mutate(
    assumption_p = v < 3 / (2 * beta)
  ) %>%
  filter(assumption_p) %>%
  rowwise() %>%
  mutate(
    mu_s = find_mu_s(v, beta),
    tau_a = tau_A(v, beta, c_fixed),
    tau_c = find_tau_C(v, beta, c_fixed, mu_s)
  ) %>%
  ungroup() %>%
  filter(!is.na(mu_s))

# Compute U_H* for each (v, beta)
compute_U_star <- function(v_val, beta_val, mu_s_val, p_val, g_val, c_val) {
  mu_g <- seq(0, 1, length.out = 501)

  vf_a <- v_func_A(mu_g, v_val, beta_val, c_val, g_val)
  vf_c <- v_func_C(mu_g, v_val, beta_val, c_val, g_val, mu_s_val)

  cav_a <- concavify_fast(mu_g, vf_a)
  cav_c <- concavify_fast(mu_g, vf_c)

  u_a <- approx(mu_g, cav_a, xout = p_val, rule = 2)$y
  u_c <- approx(mu_g, cav_c, xout = p_val, rule = 2)$y

  tibble(U_A = u_a, U_C = u_c)
}

dominance_data <- dominance_data %>%
  rowwise() %>%
  mutate(
    result = list(compute_U_star(v, beta, mu_s, p_fixed, g_fixed, c_fixed))
  ) %>%
  unnest(result) %>%
  ungroup() %>%
  mutate(
    C_dominates = U_C > U_A,
    advantage = U_C - U_A
  )

p5 <- ggplot(dominance_data, aes(x = v, y = beta, fill = advantage)) +
  geom_tile() +
  scale_fill_gradient2(
    low = "#E41A1C", mid = "white", high = "#377EB8",
    midpoint = 0,
    name = expression(U[H]^"*"*(C) - U[H]^"*"*(A))
  ) +
  geom_contour(aes(z = advantage), breaks = 0, color = "black", linewidth = 0.8) +
  labs(
    title = "Dominance Region: Package C vs Package A",
    subtitle = sprintf("p = %.1f, g = %.1f, c = %.1f | Blue: C dominates, Red: A dominates",
                       p_fixed, g_fixed, c_fixed),
    x = expression(italic(v) == V[H] / V[L]),
    y = expression(beta)
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

ggsave(file.path(fig_dir, "fig_v3_dominance_region.png"), p5,
       width = 8, height = 6, dpi = 300)
cat("  Saved.\n")

# ==============================================================================
# --- 10. Summary Statistics ---
# ==============================================================================

cat("\n========================================\n")
cat("KEY NUMERICAL RESULTS\n")
cat("========================================\n\n")

cat(sprintf("Parameters for main plots: v=%.1f, beta=%.1f, g=%.1f, c=%.1f\n",
            v_plot, beta_plot, g_plot, c_plot))
cat(sprintf("Screening threshold: mu_s = %.4f\n", ms_plot))
cat(sprintf("Jump magnitude at mu_s: %.6f\n", jump_at_mu_s(ms_plot, v_plot, beta_plot)))
cat(sprintf("Assumption P satisfied: v=%.1f < %.2f = 3/(2*beta)\n\n",
            v_plot, 3/(2*beta_plot)))

cat(sprintf("Entry thresholds: tau(A) = %.4f, tau(C) = %.4f\n",
            tau_a_plot, ifelse(is.na(tau_c_plot), NA, tau_c_plot)))

# Compute optimal BP payoffs at p = 0.3
u_a_at_p <- approx(mu_grid, cav_A, xout = p_fixed, rule = 2)$y
u_c_at_p <- approx(mu_grid, cav_C, xout = p_fixed, rule = 2)$y
cat(sprintf("\nAt p = %.1f:\n", p_fixed))
cat(sprintf("  U_H*(A) = %.6f\n", u_a_at_p))
cat(sprintf("  U_H*(C) = %.6f\n", u_c_at_p))
cat(sprintf("  Advantage C - A = %.6f\n", u_c_at_p - u_a_at_p))
cat(sprintf("  C dominates: %s\n", ifelse(u_c_at_p > u_a_at_p, "YES", "NO")))

# Dominance region summary
n_total <- nrow(dominance_data)
n_c_dom <- sum(dominance_data$C_dominates)
cat(sprintf("\nDominance region (p=%.1f, g=%.1f, c=%.1f):\n", p_fixed, g_fixed, c_fixed))
cat(sprintf("  %d / %d parameter combinations with C dominance (%.1f%%)\n",
            n_c_dom, n_total, 100 * n_c_dom / n_total))

# Comparative statics for mu_s
cat("\nComparative statics for mu_s:\n")
cat("  Higher beta -> higher mu_s (more patience -> wider aggressive range)\n")
ms_low_beta <- find_mu_s(1.5, 0.3)
ms_high_beta <- find_mu_s(1.5, 0.9)
cat(sprintf("  v=1.5: mu_s(beta=0.3)=%.4f, mu_s(beta=0.9)=%.4f\n", ms_low_beta, ms_high_beta))

cat("  Higher v -> higher mu_s (higher stakes -> wider aggressive range)\n")
ms_low_v <- find_mu_s(1.2, 0.7)
ms_high_v <- find_mu_s(2.0, 0.7)
cat(sprintf("  beta=0.7: mu_s(v=1.2)=%.4f, mu_s(v=2.0)=%.4f\n", ms_low_v, ms_high_v))

cat("\n========================================\n")
cat("DONE. All figures saved to figures/\n")
cat("========================================\n")

cat("\n--- Session Info ---\n")
sessionInfo()
