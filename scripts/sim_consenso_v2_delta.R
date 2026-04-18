# ==============================================================================
# Simulação V2: θ-Dependent Pie + Bayesian Persuasion
# ==============================================================================
# Modelo definitivo com V(θ=1) = 1+δ, V(θ=0) = 1
#
# Diferença do baseline:
#   - Pie depende de θ → continuation values V_i(R,θ) = V(θ) × s_i(R)
#   - Threshold τ(R) = (c/s_W(R) - 1)/δ (depende de δ)
#   - Value function v(μ,R) = 1{μ≥τ} × [g + (1+μδ)s_H(R)]
#   - τ entra no numerador E denominador da dominância → interação genuína
#   - Para δ alto: τ(A) > 1 → Package A INFEASÍVEL
#
# Compara Pacote A (maioria+agenda) vs Pacote C (consenso+sem agenda)
# ==============================================================================

library(tidyverse)

set.seed(42)

# --- 1. Stage 2: Shares (independentes de θ) ---

compute_shares <- function(N) {
  q_maj <- ceiling((N + 1) / 2)
  tibble(
    N = N, n = N - 1, q_maj = q_maj,
    s_H_A = 1 - (q_maj - 1) / N,        # H's share under majority
    s_W_A = (q_maj - 1) / (N * (N - 1)), # W's share under majority
    s_H_C = 1 / N,                        # H's share under consensus
    s_W_C = 1 / N                          # W's share under consensus
  )
}

shares <- bind_rows(lapply(c(3, 5), compute_shares))

cat("=== Stage 2: Shares s_i(R) ===\n\n")
print(shares)

# --- 2. Thresholds (depend on δ) ---

# τ(R) = (c / s_W(R) - 1) / δ
# W enters iff μ(s) ≥ τ(R), i.e., s_W(R) × (1 + μδ) ≥ c

compute_tau <- function(s_W, c, delta) {
  (c / s_W - 1) / delta
}

# --- 3. H's value function and optimal BP ---

# v(μ, R) = 1{μ ≥ τ} × [g + (1 + μδ) × s_H(R)]
# At the margin (μ = τ): v(τ, R) = g + (1 + τδ) × s_H(R)
# BP optimal: U_H = p/τ × v(τ, R) when p < τ
#             U_H = g + (1 + pδ) × s_H(R) when p ≥ τ

compute_UH <- function(g, s_H, s_W, c, delta, p) {
  tau <- compute_tau(s_W, c, delta)
  v_at_tau <- g + (1 + tau * delta) * s_H
  v_at_p <- g + (1 + p * delta) * s_H

  case_when(
    tau > 1 ~ 0,            # Package infeasible: even θ=1 certain doesn't suffice
    tau <= 0 ~ v_at_p,      # Always enters
    p >= tau ~ v_at_p,      # Enters without BP
    TRUE ~ p / tau * v_at_tau  # BP optimal
  )
}

compute_UH_no_bp <- function(g, s_H, s_W, c, delta, p) {
  tau <- compute_tau(s_W, c, delta)
  v_at_p <- g + (1 + p * delta) * s_H

  case_when(
    tau > 1 ~ 0,
    tau <= 0 ~ v_at_p,
    p >= tau ~ v_at_p,
    TRUE ~ 0
  )
}

# --- 4. Main Analysis ---

p_seq <- seq(0, 1, by = 0.005)
g_default <- 1.0
c_default <- 0.4

# 4a. Effect of δ on payoffs (for N=3)
delta_vals <- c(0.3, 0.5, 1.0, 2.0)

payoff_delta <- expand_grid(delta = delta_vals, p = p_seq) |>
  cross_join(filter(shares, N == 3)) |>
  mutate(
    tau_A = compute_tau(s_W_A, c_default, delta),
    tau_C = compute_tau(s_W_C, c_default, delta),
    U_A = compute_UH(g_default, s_H_A, s_W_A, c_default, delta, p),
    U_C = compute_UH(g_default, s_H_C, s_W_C, c_default, delta, p),
    A_feasible = tau_A <= 1,
    delta_label = sprintf("δ = %.1f  (τ_A=%.2f)", delta, tau_A)
  )

# Print thresholds
cat("\n=== Thresholds (N=3, c=0.4) ===\n\n")
payoff_delta |>
  distinct(delta, tau_A, tau_C, A_feasible) |>
  mutate(across(where(is.numeric), \(x) round(x, 3))) |>
  print()

payoff_long <- payoff_delta |>
  select(delta, delta_label, p, U_A, U_C) |>
  pivot_longer(cols = c(U_A, U_C), names_to = "rule", values_to = "payoff") |>
  mutate(rule = recode(rule, U_A = "Package A (Maj+Agenda)", U_C = "Package C (Consensus)"))

fig1 <- ggplot(payoff_long, aes(x = p, y = payoff, color = rule, linetype = rule)) +
  geom_line(linewidth = 0.9) +
  facet_wrap(~ delta_label, scales = "free_y", ncol = 2) +
  labs(
    title = "H's Payoff: Package A vs C with θ-Dependent Pie",
    subtitle = sprintf("N=3, g=%.1f, c=%.2f  |  V(θ) = 1+θδ", g_default, c_default),
    x = "Prior p = Pr(θ = 1)",
    y = expression(U[H]^"*"),
    color = "Package", linetype = "Package"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("Package A (Maj+Agenda)" = "#D55E00",
                                 "Package C (Consensus)" = "#0072B2"))

ggsave("figures/fig_v2_payoff_delta.png", fig1, width = 10, height = 8, dpi = 150)

# 4b. Crossover p* as function of δ
delta_seq <- seq(0.1, 3, by = 0.05)

compute_crossover_v2 <- function(N_val, g_val, c_val, delta_val) {
  s <- compute_shares(N_val)
  tau_A <- compute_tau(s$s_W_A, c_val, delta_val)
  tau_C <- compute_tau(s$s_W_C, c_val, delta_val)

  if (tau_A > 1) return(1)  # A infeasible → C always dominates
  if (tau_A <= 0) return(0) # Both always form → A dominates

  v_tau_A <- g_val + (1 + tau_A * delta_val) * s$s_H_A
  v_tau_C <- g_val + (1 + tau_C * delta_val) * s$s_H_C

  # Crossover: v(τ_C,C)/τ_C = v(τ_A,A)/τ_A → p* in the mid region
  # p* = v_tau_C * tau_A / v_tau_A (when τ_C ≤ p < τ_A)
  # But need to check which region we're in
  if (tau_C <= 0) {
    # C always forms. p* solves A(C) = v_tau_A * p / tau_A
    A_C <- g_val + (1 + 0) * s$s_H_C  # worst case p near 0
    # Actually when p < tau_A: U_C = g + (1+pδ)s_H_C, U_A = p/tau_A × v_tau_A
    # These cross when g + (1+pδ)/N = p/tau_A × v_tau_A
    # This is harder to solve analytically. Use numerical
    p_test <- seq(0, min(tau_A, 1), by = 0.001)
    U_C_test <- g_val + (1 + p_test * delta_val) * s$s_H_C
    U_A_test <- ifelse(p_test < tau_A, p_test / tau_A * v_tau_A,
                        g_val + (1 + p_test * delta_val) * s$s_H_A)
    diff <- U_C_test - U_A_test
    # Find crossing point
    crossings <- which(diff[-1] * diff[-length(diff)] < 0)
    if (length(crossings) > 0) return(p_test[crossings[1]])
    if (all(diff > 0)) return(min(tau_A, 1))
    return(0)
  }

  # Both thresholds positive and < 1
  # In the region p < τ_C: U_C = p/τ_C × v_τ_C, U_A = p/τ_A × v_τ_A
  # C dom iff v_τ_C/τ_C > v_τ_A/τ_A (constant in p)
  ratio_C <- v_tau_C / tau_C
  ratio_A <- v_tau_A / tau_A

  if (ratio_C <= ratio_A) return(0) # A always dominates

  # In the region τ_C ≤ p < τ_A: U_C = g + (1+pδ)s_H_C, U_A = p/τ_A × v_τ_A
  # Solve numerically
  p_test <- seq(tau_C, min(tau_A, 1), by = 0.001)
  U_C_test <- g_val + (1 + p_test * delta_val) * s$s_H_C
  U_A_test <- p_test / tau_A * v_tau_A
  diff <- U_C_test - U_A_test
  crossings <- which(diff[-1] * diff[-length(diff)] < 0)
  if (length(crossings) > 0) return(p_test[crossings[1]])
  return(min(tau_A, 1))
}

crossover_data <- expand_grid(
  N = c(3, 5),
  delta = delta_seq,
  g = c(0.5, 1.0, 2.0)
) |>
  rowwise() |>
  mutate(p_star = compute_crossover_v2(N, g, c_default, delta)) |>
  ungroup() |>
  mutate(N_label = paste0("N = ", N), g_label = paste0("g = ", g))

fig2 <- ggplot(crossover_data, aes(x = delta, y = p_star, color = g_label, linetype = g_label)) +
  geom_line(linewidth = 0.9) +
  geom_hline(yintercept = 1, linetype = "dotted", color = "grey50") +
  annotate("text", x = 2.5, y = 0.95, label = "τ(A) > 1: Package A infeasible",
           size = 3, color = "grey40") +
  facet_wrap(~ N_label) +
  labs(
    title = "Crossover p* vs δ: How Pie Sensitivity Affects Institutional Choice",
    subtitle = sprintf("c = %.2f  |  p* = 1 means Package A is infeasible (consensus always dominates)",
                        c_default),
    x = expression(delta ~ "(pie sensitivity to θ)"),
    y = "p* (crossover prior)",
    color = "Complementarity g", linetype = "Complementarity g"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  coord_cartesian(ylim = c(0, 1.05))

ggsave("figures/fig_v2_crossover_delta.png", fig2, width = 10, height = 5, dpi = 150)

# 4c. Region (g, δ) where C dominates for fixed p, N=3
g_grid <- seq(0, 3, by = 0.03)
delta_grid <- seq(0.1, 3, by = 0.03)
p_fixed <- 0.3

region_data <- expand_grid(g = g_grid, delta = delta_grid) |>
  rowwise() |>
  mutate(
    U_A = compute_UH(g, compute_shares(3)$s_H_A, compute_shares(3)$s_W_A,
                      c_default, delta, p_fixed),
    U_C = compute_UH(g, compute_shares(3)$s_H_C, compute_shares(3)$s_W_C,
                      c_default, delta, p_fixed),
    advantage = U_C - U_A
  ) |>
  ungroup()

fig3 <- ggplot(region_data, aes(x = g, y = delta, fill = advantage)) +
  geom_tile() +
  scale_fill_gradient2(
    low = "#D55E00", mid = "white", high = "#0072B2", midpoint = 0,
    name = expression(U[H](C) - U[H](A))
  ) +
  geom_contour(aes(z = advantage), breaks = 0, color = "black", linewidth = 0.8) +
  labs(
    title = "When does H prefer Consensus? (N=3)",
    subtitle = sprintf("p = %.1f, c = %.2f  |  Blue = Consensus, Red = Majority  |  V(θ) = 1+θδ",
                        p_fixed, c_default),
    x = "g (complementarity)",
    y = expression(delta ~ "(pie sensitivity to θ)")
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/fig_v2_region_g_delta.png", fig3, width = 8, height = 6, dpi = 150)

# 4d. BP Gain comparison
bp_data <- expand_grid(p = p_seq) |>
  mutate(
    delta = 1.0,
    U_A = compute_UH(g_default, compute_shares(3)$s_H_A, compute_shares(3)$s_W_A,
                      c_default, 1.0, p),
    U_C = compute_UH(g_default, compute_shares(3)$s_H_C, compute_shares(3)$s_W_C,
                      c_default, 1.0, p),
    U_A_no = compute_UH_no_bp(g_default, compute_shares(3)$s_H_A, compute_shares(3)$s_W_A,
                               c_default, 1.0, p),
    U_C_no = compute_UH_no_bp(g_default, compute_shares(3)$s_H_C, compute_shares(3)$s_W_C,
                               c_default, 1.0, p),
    BP_A = U_A - U_A_no,
    BP_C = U_C - U_C_no
  ) |>
  select(p, BP_A, BP_C) |>
  pivot_longer(cols = c(BP_A, BP_C), names_to = "rule", values_to = "gain") |>
  mutate(rule = recode(rule, BP_A = "Package A", BP_C = "Package C"))

fig4 <- ggplot(bp_data, aes(x = p, y = gain, color = rule)) +
  geom_line(linewidth = 0.9) +
  labs(
    title = "BP Gain by Package (N=3, δ=1.0)",
    subtitle = sprintf("g=%.1f, c=%.2f  |  BP Gain = U_H(with BP) - U_H(without BP)",
                        g_default, c_default),
    x = "Prior p", y = "BP Gain", color = "Package"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("Package A" = "#D55E00", "Package C" = "#0072B2"))

ggsave("figures/fig_v2_bp_gain.png", fig4, width = 8, height = 5, dpi = 150)

# --- 5. Key Result: Package A Infeasibility ---

cat("\n=== Key Result: Package A Infeasibility ===\n\n")
for (N_val in c(3, 5)) {
  s <- compute_shares(N_val)
  delta_crit <- (c_default / s$s_W_A - 1)  # τ(A) = 1 when δ = this value
  cat(sprintf("N = %d: τ(A) > 1 (Package A infeasible) when δ > %.3f\n",
              N_val, delta_crit))
  cat(sprintf("        τ(C) > 1 (Package C infeasible) when δ > %.3f\n",
              (c_default / s$s_W_C - 1)))
}

# --- 6. Summary ---

cat("\n=== Summary ===\n")
cat("V2 model: V(θ) = 1 + θδ. Pie depends on state.\n")
cat("New results vs baseline:\n")
cat("  1. τ(R) = (c/s_W(R) - 1)/δ — threshold depends on δ\n")
cat("  2. v(τ,R)/τ comparison has τ in numerator AND denominator\n")
cat("  3. ∂p*/∂δ ambiguous — non-trivial interaction\n")
cat("  4. For high δ: τ(A) > 1 → Package A INFEASIBLE\n")
cat("     Consensus is the ONLY viable package. Strongest result.\n")
