# ==============================================================================
# Simulação: TITL 2-Player com Outside Option como Info Privada + BP
# ==============================================================================
# Modelo:
#   - P1 (Proposer) oferece x a P2 (Sender, conhece b)
#   - P2: Aceita → (1-x, x) | Rejeita → (0, b)
#   - b ∈ {b_L, b_H}, prior p = Pr(b = b_H)
#   - P2 comete-se a sinal π(s|b) antes de b ser realizado (BP)
#
# Mecanismo:
#   - P1 enfrenta screening: oferecer b_H (safe) ou b_L (risky)
#   - Limiar: μ* = (b_H - b_L) / (1 - b_L)
#   - Se μ < μ*: P1 oferece b_L (screening)
#   - Se μ ≥ μ*: P1 oferece b_H (pooling)
# ==============================================================================

library(tidyverse)

# --- 1. Funções do modelo TITL ---

# Limiar de screening do proposer
compute_mu_star <- function(b_L, b_H) {
  (b_H - b_L) / (1 - b_L)
}

# Payoff do Sender v(μ) dado posterior μ do proposer
sender_value <- function(mu, b_L, b_H) {
  mu_star <- compute_mu_star(b_L, b_H)
  ifelse(mu < mu_star,
         (1 - mu) * b_L + mu * b_H,  # screening: E[b|μ]
         b_H)                          # pooling: b_H always
}

# Concavificação de v(μ)
sender_value_cav <- function(mu, b_L, b_H) {
  mu_star <- compute_mu_star(b_L, b_H)
  ifelse(mu <= mu_star,
         b_L + mu * (b_H - b_L) / mu_star,  # linha de (0, b_L) a (μ*, b_H)
         b_H)
}

# Payoff do Sender sem BP (at prior p)
sender_no_bp <- function(p, b_L, b_H) {
  sender_value(p, b_L, b_H)
}

# Payoff do Sender com BP ótimo (= concavificação at prior p)
sender_with_bp <- function(p, b_L, b_H) {
  sender_value_cav(p, b_L, b_H)
}

# BP gain
bp_gain <- function(p, b_L, b_H) {
  sender_with_bp(p, b_L, b_H) - sender_no_bp(p, b_L, b_H)
}

# Fórmula analítica do BP gain (para p < μ*)
bp_gain_formula <- function(p, b_L, b_H) {
  mu_star <- compute_mu_star(b_L, b_H)
  ifelse(p < mu_star, p * (1 - b_H), 0)
}

# --- 2. Verificação numérica do exemplo do documento ---

cat("=== Exemplo do documento: b_L=0.2, b_H=0.6, p=0.3 ===\n\n")

b_L <- 0.2; b_H <- 0.6; p <- 0.3
mu_star <- compute_mu_star(b_L, b_H)

cat(sprintf("μ* = %.3f\n", mu_star))
cat(sprintf("p = %.3f < μ* → proposer faz screening\n\n", p))

# Sem BP
v_no_bp <- sender_no_bp(p, b_L, b_H)
cat(sprintf("Sem BP: E[payoff S] = %.3f\n", v_no_bp))
cat(sprintf("  Check manual: (1-p)*b_L + p*b_H = %.1f*%.1f + %.1f*%.1f = %.3f\n",
            1 - p, b_L, p, b_H, (1 - p) * b_L + p * b_H))

# Com BP
v_bp <- sender_with_bp(p, b_L, b_H)
cat(sprintf("Com BP: E[payoff S] = %.3f\n", v_bp))

# Gain
gain <- bp_gain(p, b_L, b_H)
gain_formula <- bp_gain_formula(p, b_L, b_H)
cat(sprintf("BP gain (numérico): %.3f\n", gain))
cat(sprintf("BP gain (fórmula p*(1-b_H)): %.3f\n", gain_formula))
cat(sprintf("Match: %s\n\n", all.equal(gain, gain_formula)))

# Verificação via sinal ótimo explícito
cat("--- Verificação via sinal ótimo explícito ---\n")
# Sinal: split prior em μ₁=0 (peso λ) e μ₂=μ* (peso 1-λ)
lambda <- 1 - p / mu_star
cat(sprintf("λ (peso em μ=0) = %.4f\n", lambda))
cat(sprintf("1-λ (peso em μ=μ*) = %.4f\n", 1 - lambda))

# Bayes plausibility check
mean_posterior <- lambda * 0 + (1 - lambda) * mu_star
cat(sprintf("E[μ] = %.3f (deve = p = %.3f): %s\n",
            mean_posterior, p, all.equal(mean_posterior, p)))

# Payoff por sinal
v_at_0 <- sender_value(0, b_L, b_H)         # μ=0: proposer oferece b_L
v_at_mustar <- sender_value(mu_star, b_L, b_H)  # μ=μ*: proposer oferece b_H
expected_bp <- lambda * v_at_0 + (1 - lambda) * v_at_mustar

cat(sprintf("v(0) = %.3f, v(μ*) = %.3f\n", v_at_0, v_at_mustar))
cat(sprintf("E[v] via sinal = λ*v(0) + (1-λ)*v(μ*) = %.3f\n", expected_bp))
cat(sprintf("Match com cav(v)(p): %s\n\n", all.equal(expected_bp, v_bp)))

# Estrutura do sinal
alpha <- 1 - p * (1 - mu_star) / (mu_star * (1 - p))
cat(sprintf("π(s_L | b_L) = α = %.4f\n", alpha))
cat(sprintf("π(s_H | b_L) = 1-α = %.4f\n", 1 - alpha))
cat(sprintf("π(s_L | b_H) = 0\n"))
cat(sprintf("π(s_H | b_H) = 1\n\n"))

# Probabilidades dos sinais
pr_sL <- (1 - p) * alpha
pr_sH <- (1 - p) * (1 - alpha) + p
cat(sprintf("Pr(s_L) = %.4f, Pr(s_H) = %.4f\n", pr_sL, pr_sH))

# Posterior check
mu_sH <- p / (p + (1 - p) * (1 - alpha))
cat(sprintf("μ(s_H) = %.4f (deve = μ* = %.4f): %s\n\n",
            mu_sH, mu_star, all.equal(mu_sH, mu_star)))

# --- 3. Monte Carlo: confirmar BP gain via simulação ---

cat("=== Monte Carlo: 100.000 realizações ===\n\n")
set.seed(42)
n_sim <- 100000

# Sortear estado
b_realized <- ifelse(runif(n_sim) < p, b_H, b_L)

# Sem BP: proposer tem prior p < μ*, faz screening (oferece b_L)
# S aceita se b = b_L (oferta = b_L ≥ b_L), rejeita se b = b_H (oferta = b_L < b_H)
payoff_no_bp <- ifelse(b_realized == b_L, b_L, b_H)
# Quando b=b_L: aceita oferta b_L, recebe b_L
# Quando b=b_H: rejeita, exerce outside option, recebe b_H

cat(sprintf("Sem BP (MC): E[payoff S] = %.4f (analítico: %.4f)\n",
            mean(payoff_no_bp), v_no_bp))

# Com BP ótimo: sinal gera s_L ou s_H (vetorizado)
signal <- ifelse(b_realized == b_L & runif(n_sim) < alpha, "s_L", "s_H")

# Payoff com BP
# s_L → μ=0, proposer oferece b_L. b=b_L com certeza → S recebe b_L
# s_H → μ=μ*, proposer oferece b_H. S recebe b_H (aceita sempre)
payoff_bp <- ifelse(signal == "s_L", b_L, b_H)

cat(sprintf("Com BP (MC): E[payoff S] = %.4f (analítico: %.4f)\n",
            mean(payoff_bp), v_bp))
cat(sprintf("BP gain (MC): %.4f (analítico: %.4f)\n\n",
            mean(payoff_bp) - mean(payoff_no_bp), gain))

# --- 4. Gráfico: v(μ) e concavificação ---

cat("=== Gerando gráficos ===\n\n")

mu_seq <- seq(0, 1, length.out = 500)
df_value <- tibble(
  mu = mu_seq,
  `v(μ) sem BP` = sender_value(mu_seq, b_L, b_H),
  `cav v(μ) com BP` = sender_value_cav(mu_seq, b_L, b_H)
) |>
  pivot_longer(-mu, names_to = "Curva", values_to = "Payoff")

p1 <- ggplot(df_value, aes(x = mu, y = Payoff, color = Curva, linetype = Curva)) +
  geom_line(linewidth = 1) +
  geom_vline(xintercept = mu_star, linetype = "dotted", color = "gray50") +
  geom_vline(xintercept = p, linetype = "dotted", color = "darkgreen") +
  annotate("text", x = mu_star + 0.02, y = b_L - 0.02,
           label = paste0("μ* = ", round(mu_star, 2)), color = "gray40", size = 3.5) +
  annotate("text", x = p + 0.02, y = b_L - 0.04,
           label = paste0("p = ", p), color = "darkgreen", size = 3.5) +
  annotate("segment", x = p, xend = p,
           y = sender_value(p, b_L, b_H),
           yend = sender_value_cav(p, b_L, b_H),
           color = "firebrick", linewidth = 0.8,
           arrow = arrow(length = unit(0.15, "cm"), ends = "both")) +
  annotate("text", x = p + 0.04,
           y = (sender_value(p, b_L, b_H) + sender_value_cav(p, b_L, b_H)) / 2,
           label = sprintf("BP gain = %.2f", gain), color = "firebrick", size = 3.5) +
  scale_color_manual(values = c("steelblue", "firebrick")) +
  scale_linetype_manual(values = c("solid", "dashed")) +
  labs(x = expression(mu ~ "(posterior do proposer)"),
       y = "Payoff do Sender",
       title = "TITL 2-Player: v(μ) e concavificação",
       subtitle = sprintf("b_L=%.1f, b_H=%.1f, p=%.1f, μ*=%.2f", b_L, b_H, p, mu_star)) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("fig_titl_value_function.png", p1, width = 7, height = 5, dpi = 150)
cat("Salvo: fig_titl_value_function.png\n")

# --- 5. Estática comparativa ---

# 5a. BP gain como função de p (fixando b_L, b_H)
p_seq <- seq(0, 1, length.out = 200)
df_gain_p <- tibble(
  p = p_seq,
  bp_gain = bp_gain(p_seq, b_L, b_H),
  bp_gain_formula = bp_gain_formula(p_seq, b_L, b_H)
)

p2 <- ggplot(df_gain_p, aes(x = p)) +
  geom_line(aes(y = bp_gain), color = "steelblue", linewidth = 1) +
  geom_line(aes(y = bp_gain_formula), color = "firebrick",
            linewidth = 0.8, linetype = "dashed") +
  geom_vline(xintercept = mu_star, linetype = "dotted", color = "gray50") +
  annotate("text", x = mu_star + 0.02, y = max(df_gain_p$bp_gain) * 0.9,
           label = "μ*", color = "gray40", size = 4) +
  labs(x = "Prior p = Pr(b = b_H)",
       y = "BP gain",
       title = "BP gain como função do prior p",
       subtitle = sprintf("b_L=%.1f, b_H=%.1f. Gain = p(1-b_H) para p < μ*",
                           b_L, b_H)) +
  theme_minimal()

ggsave("fig_titl_bp_gain_vs_p.png", p2, width = 7, height = 4, dpi = 150)
cat("Salvo: fig_titl_bp_gain_vs_p.png\n")

# 5b. BP gain como função de b_H (fixando b_L, p)
bH_seq <- seq(b_L + 0.01, 0.99, length.out = 200)
df_gain_bH <- tibble(
  b_H = bH_seq,
  mu_star = compute_mu_star(b_L, bH_seq),
  bp_gain = map_dbl(bH_seq, ~ bp_gain(p, b_L, .x)),
  regime = ifelse(p < mu_star, "p < μ* (screening)", "p ≥ μ* (pooling)")
)

p3 <- ggplot(df_gain_bH, aes(x = b_H, y = bp_gain, color = regime)) +
  geom_line(linewidth = 1) +
  labs(x = expression(b[H]),
       y = "BP gain",
       title = "BP gain como função de b_H",
       subtitle = sprintf("b_L=%.1f, p=%.1f", b_L, p)) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("fig_titl_bp_gain_vs_bH.png", p3, width = 7, height = 4, dpi = 150)
cat("Salvo: fig_titl_bp_gain_vs_bH.png\n")

# --- 6. Grid de parâmetros: verificar fórmula em múltiplos cenários ---

cat("\n=== Verificação em grid de parâmetros ===\n\n")

param_grid <- expand_grid(
  b_L = c(0.1, 0.2, 0.3),
  b_H = c(0.4, 0.6, 0.8),
  p = c(0.1, 0.3, 0.5, 0.7)
) |>
  filter(b_L < b_H) |>
  mutate(
    mu_star = compute_mu_star(b_L, b_H),
    regime = ifelse(p < mu_star, "screening", "pooling"),
    v_no_bp = pmap_dbl(list(p, b_L, b_H), sender_no_bp),
    v_bp = pmap_dbl(list(p, b_L, b_H), sender_with_bp),
    gain_numeric = v_bp - v_no_bp,
    gain_formula = pmap_dbl(list(p, b_L, b_H), bp_gain_formula),
    match = abs(gain_numeric - gain_formula) < 1e-10
  )

cat("Todos os cenários batem com a fórmula analítica: ",
    all(param_grid$match), "\n\n")

# Mostrar tabela resumo
param_grid |>
  select(b_L, b_H, p, mu_star, regime, v_no_bp, v_bp, gain_numeric) |>
  mutate(across(where(is.numeric), ~ round(.x, 4))) |>
  print(n = Inf)

# --- 7. Payoff do PROPOSER (para verificar que o jogo é de soma < 1) ---

cat("\n=== Payoff do Proposer (P1) ===\n\n")

proposer_no_bp <- function(p, b_L, b_H) {
  mu_star <- compute_mu_star(b_L, b_H)
  if (p < mu_star) {
    # Screening: oferece b_L, aceito com prob (1-p)
    (1 - p) * (1 - b_L)
  } else {
    # Pooling: oferece b_H, sempre aceito
    1 - b_H
  }
}

proposer_with_bp <- function(p, b_L, b_H) {
  mu_star <- compute_mu_star(b_L, b_H)
  if (p >= mu_star) return(1 - b_H)  # BP não muda nada

  lambda <- 1 - p / mu_star
  # Pr(s_L) = λ, Pr(s_H) = 1-λ
  # s_L → μ=0, P1 offers b_L, gets 1-b_L
  # s_H → μ=μ*, P1 offers b_H, gets 1-b_H
  lambda * (1 - b_L) + (1 - lambda) * (1 - b_H)
}

cat(sprintf("b_L=%.1f, b_H=%.1f, p=%.1f:\n", b_L, b_H, p))
p1_no <- proposer_no_bp(p, b_L, b_H)
p1_bp <- proposer_with_bp(p, b_L, b_H)
cat(sprintf("  P1 sem BP: %.4f\n", p1_no))
cat(sprintf("  P1 com BP: %.4f\n", p1_bp))
cat(sprintf("  P1 perde: %.4f\n", p1_no - p1_bp))
cat(sprintf("  S ganha: %.4f\n", gain))
cat(sprintf("  Soma (sem BP): P1 + P2 = %.4f (< 1 pois rejeição com prob p)\n",
            p1_no + v_no_bp))
cat(sprintf("  Soma (com BP): P1 + P2 = %.4f\n", p1_bp + v_bp))

# --- 8. Resultado-chave: P1 é indiferente ao BP (resultado geral) ---

cat("\n=== Verificação: P1 indiferente ao BP (resultado geral?) ===\n\n")

# Analiticamente:
# P1 sem BP (p < μ*): (1-p)(1-b_L)
# P1 com BP: λ(1-b_L) + (1-λ)(1-b_H), λ = 1-p/μ*
# = (1-p/μ*)(1-b_L) + (p/μ*)(1-b_H)
# Substituindo μ* = (b_H-b_L)/(1-b_L):
# p/μ* = p(1-b_L)/(b_H-b_L)
# = (1-b_L) - p(1-b_L)/(b_H-b_L) * (b_H-b_L) + p(1-b_L)/(b_H-b_L)*(1-b_H)
# ... simplificando = (1-p)(1-b_L). QED.

# Razão: V_P1(μ) = max{(1-μ)(1-b_L), 1-b_H} é CÔNCAVA e contínua em μ*
# (os dois segmentos se encontram em μ*).
# O sinal ótimo de S coloca massa em 0 e μ*, e V_P1 é linear nesse intervalo.
# Logo E[V_P1(μ)] = V_P1(p). P1 é exatamente indiferente.

# Verificar para todo o grid de parâmetros:
proposer_check <- param_grid |>
  filter(regime == "screening") |>
  mutate(
    p1_no_bp = (1 - p) * (1 - b_L),
    p1_bp = pmap_dbl(list(p, b_L, b_H), function(p, bL, bH) {
      ms <- compute_mu_star(bL, bH)
      lam <- 1 - p / ms
      lam * (1 - bL) + (1 - lam) * (1 - bH)
    }),
    diff = abs(p1_no_bp - p1_bp),
    p1_invariant = diff < 1e-10,
    surplus_no_bp = p1_no_bp + v_no_bp,
    surplus_bp = p1_bp + v_bp,
    surplus_gain = surplus_bp - surplus_no_bp
  )

cat("P1 invariante ao BP em TODOS os cenários de screening: ",
    all(proposer_check$p1_invariant), "\n\n")

cat("Surplus gain = BP gain em todos os cenários: ",
    all(abs(proposer_check$surplus_gain - proposer_check$gain_numeric) < 1e-10), "\n\n")

proposer_check |>
  select(b_L, b_H, p, p1_no_bp, p1_bp, surplus_no_bp, surplus_bp, surplus_gain, gain_numeric) |>
  mutate(across(where(is.numeric), ~ round(.x, 4))) |>
  print(n = Inf)

cat("\n=== CONCLUSÃO ===\n")
cat("BP no TITL 2-player é PARETO-IMPROVING:\n")
cat("  - S ganha (BP gain = p(1-b_H))\n")
cat("  - P1 é indiferente (payoff invariante)\n")
cat("  - Surplus total sobe de (1-p) + p*b_H para 1\n")
cat("  - O gain de S = eliminação de rejeições ineficientes\n")
cat("  - Implicação: sob unanimidade, ninguém se opõe a BP.\n")
cat("    Sob maioria (N≥3), P1 pode EXCLUIR S para evitar pagar b_H,\n")
cat("    mesmo que isso reduza eficiência → tensão institucional.\n")
