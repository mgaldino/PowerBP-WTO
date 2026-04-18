# ==============================================================================
# Simulação: Consenso como Compromisso Crível + Bayesian Persuasion
# ==============================================================================
# Compara Maioria + Agenda Power vs Consenso para N = 2, 3, 5
#
# Modelo (3 estágios):
#   Estágio 0: H escolhe regra R ∈ {M, C}
#   Estágio 1: θ ∈ {0,1}, H observa θ, manda sinal s via BP, fracos decidem entrar
#   Estágio 2: Redistribuição single-round, H propõe, passa por maioria ou unanimidade
#
# Stage 2 derivado (não pressuposto):
#   Maioria: H inclui q-1 fracos (oferece 1/N), exclui o resto → V_H(M) = 1-(q-1)/N
#   Consenso: todos têm veto → V_H(C) = V_W(C) = 1/N
#
# Complementaridade: g(k) = λ × k^α, α ∈ (0,1) (retornos crescentes subquadráticos)
#   Parametrizado em λ (intensidade); g(n) escala com N.
#
# Resultado central: informational power (BP) pode substituir agenda power,
# fazendo H preferir consenso quando λ é alto e p é baixo.
# ==============================================================================

library(tidyverse)

set.seed(42)

# --- 0. Parâmetros de complementaridade ---

alpha <- 1.5  # convexo subquadrático: 1 < α < 2 (retornos crescentes, mais lento que k²)

g_fun <- function(k, lambda) {
  lambda * k^alpha
}

# --- 1. Stage 2: Payoffs de Continuação ---

compute_stage2 <- function(N) {
  n <- N - 1
  q_maj <- ceiling((N + 1) / 2)

  # Maioria + agenda power (H sempre propõe)
  V_H_M <- 1 - (q_maj - 1) / N
  V_W_M <- (q_maj - 1) / (N * (N - 1))

  # Consenso (veto neutraliza agenda)
  V_H_C <- 1 / N
  V_W_C <- 1 / N

  tibble(
    N = N, n = n, q_maj = q_maj,
    V_H_M = V_H_M, V_W_M = V_W_M,
    V_H_C = V_H_C, V_W_C = V_W_C
  )
}

stage2 <- bind_rows(lapply(c(2, 3, 5), compute_stage2))

cat("=== Stage 2: Continuation Values (Derivados) ===\n\n")
stage2 |>
  mutate(across(where(is.numeric) & !c(N, n, q_maj), \(x) round(x, 4))) |>
  print()

cat(sprintf("\n=== Complementaridade: g(k) = λ × k^%.1f ===\n\n", alpha))
for (N_val in c(2, 3, 5)) {
  n_val <- N_val - 1
  cat(sprintf("  N = %d (n = %d): g(n) = λ × %.2f^%.1f = %.3f × λ\n",
              N_val, n_val, n_val, alpha, n_val^alpha))
}

# --- 2. Funções do Modelo ---

# g agora é g(n, λ) = λ × n^α
compute_UH <- function(lambda, n, V_H, V_W, c, p) {
  g <- g_fun(n, lambda)
  A <- g + V_H
  tau <- c - V_W
  case_when(
    tau <= 0 ~ A,
    p >= tau ~ A,
    TRUE ~ A * p / tau
  )
}

compute_UH_no_bp <- function(lambda, n, V_H, V_W, c, p) {
  g <- g_fun(n, lambda)
  A <- g + V_H
  tau <- c - V_W
  case_when(
    tau <= 0 ~ A,
    p >= tau ~ A,
    TRUE ~ 0
  )
}

# --- 3. Efeito de Exclusão no BF (Motivação) ---

cat("\n=== Efeito de Exclusão: BF com Reconhecimento Aleatório (N=3) ===\n")
cat("(Motiva por que maioria precisa de agenda power)\n\n")

bf_exclusion <- function(p_H, delta) {
  v_W <- (1 - p_H) / (2 - p_H * delta)
  v_H <- p_H * (1 - delta * v_W)
  exclusion <- v_H > v_W

  tibble(p_H = p_H, delta = delta,
         v_H_maj = v_H, v_W_maj = v_W,
         v_H_unan = p_H, v_W_unan = (1 - p_H) / 2,
         H_excluded = exclusion,
         H_prefers_unan = v_H < p_H)
}

ex <- bf_exclusion(0.6, 0.9)
cat(sprintf("p_H = 0.6, δ = 0.9:\n"))
cat(sprintf("  Maioria (BF):    v_H = %.3f, v_W = %.3f\n", ex$v_H_maj, ex$v_W_maj))
cat(sprintf("  Unanimidade (BF): v_H = %.3f, v_W = %.3f\n", ex$v_H_unan, ex$v_W_unan))
cat(sprintf("  H excluído sob maioria? %s\n", ex$H_excluded))
cat(sprintf("  H prefere unanimidade? %s\n\n", ex$H_prefers_unan))

exclusion_data <- map_dfr(seq(0.35, 0.9, by = 0.01), \(ph) bf_exclusion(ph, 0.9))

fig_exclusion <- ggplot(exclusion_data) +
  geom_line(aes(x = p_H, y = v_H_maj, color = "Maioria (BF)"),
            linewidth = 0.9) +
  geom_line(aes(x = p_H, y = v_H_unan, color = "Unanimidade (BF)"),
            linewidth = 0.9) +
  geom_line(aes(x = p_H, y = p_H, color = "v = p_H (referência)"),
            linewidth = 0.5, linetype = "dashed") +
  labs(
    title = "Efeito de Exclusão: BF sem Agenda Power (N=3, δ=0.9)",
    subtitle = "Sob maioria, H forte é excluído das coalizões → v_H(maj) < v_H(unan)",
    x = expression(p[H] ~ "(probabilidade de reconhecimento do hegemon)"),
    y = expression(v[H] ~ "(continuation value)"),
    color = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c(
    "Maioria (BF)" = "#D55E00",
    "Unanimidade (BF)" = "#0072B2",
    "v = p_H (referência)" = "grey50"
  ))

ggsave("figures/fig_exclusion_bf.png", fig_exclusion, width = 8, height = 5, dpi = 150)

# --- 4. Análise Principal: Maioria+Agenda vs Consenso ---

p_seq <- seq(0, 1, by = 0.005)
lambda_default <- 1.0
c_default <- 0.45

# 4a. U_H vs p para cada N (mesmo λ, g(n) escala com N)
payoff_data <- expand_grid(N = c(2, 3, 5), p = p_seq) |>
  left_join(stage2, by = "N") |>
  mutate(
    g_n = g_fun(n, lambda_default),
    U_M = compute_UH(lambda_default, n, V_H_M, V_W_M, c_default, p),
    U_C = compute_UH(lambda_default, n, V_H_C, V_W_C, c_default, p),
    U_M_no_bp = compute_UH_no_bp(lambda_default, n, V_H_M, V_W_M, c_default, p),
    U_C_no_bp = compute_UH_no_bp(lambda_default, n, V_H_C, V_W_C, c_default, p),
    BP_gain_M = U_M - U_M_no_bp,
    BP_gain_C = U_C - U_C_no_bp,
    N_label = factor(
      sprintf("N=%d  g(n)=%.2f", N, g_n),
      levels = sprintf("N=%d  g(n)=%.2f", c(2, 3, 5),
                        g_fun(c(1, 2, 4), lambda_default))
    )
  )

# Plot: Payoffs
payoff_long <- payoff_data |>
  select(N, N_label, p, U_M, U_C) |>
  pivot_longer(cols = c(U_M, U_C), names_to = "rule", values_to = "payoff") |>
  mutate(rule = recode(rule, U_M = "Maioria + Agenda", U_C = "Consenso"))

fig_payoff <- ggplot(payoff_long, aes(x = p, y = payoff, color = rule, linetype = rule)) +
  geom_line(linewidth = 0.9) +
  facet_wrap(~ N_label, scales = "free_y") +
  labs(
    title = "Payoff do Hegemon: Maioria + Agenda vs Consenso (com BP ótimo)",
    subtitle = sprintf("λ = %.1f, α = %.1f, c = %.2f  |  g(n) = λn^α (retornos crescentes subquadráticos)",
                        lambda_default, alpha, c_default),
    x = "Prior p = Pr(θ = 1)",
    y = expression(U[H]^"*"),
    color = "Regra", linetype = "Regra"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("Maioria + Agenda" = "#D55E00", "Consenso" = "#0072B2"))

ggsave("figures/fig_payoff_by_N.png", fig_payoff, width = 13, height = 5, dpi = 150)

# Plot: BP Gain por regra
bp_long <- payoff_data |>
  filter(N > 2) |>
  select(N, N_label, p, BP_gain_M, BP_gain_C) |>
  pivot_longer(cols = c(BP_gain_M, BP_gain_C), names_to = "rule", values_to = "gain") |>
  mutate(rule = recode(rule,
    BP_gain_M = "Maioria + Agenda",
    BP_gain_C = "Consenso"
  ))

fig_bp <- ggplot(bp_long, aes(x = p, y = gain, color = rule)) +
  geom_line(linewidth = 0.9) +
  facet_wrap(~ N_label, scales = "free_y") +
  labs(
    title = "Ganho de Bayesian Persuasion por Regra",
    subtitle = sprintf("λ = %.1f, α = %.1f, c = %.2f", lambda_default, alpha, c_default),
    x = "Prior p",
    y = "BP Gain",
    color = "Regra"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("Maioria + Agenda" = "#D55E00", "Consenso" = "#0072B2"))

ggsave("figures/fig_bp_gain_by_N.png", fig_bp, width = 10, height = 5, dpi = 150)

# 4b. Região (λ, c) onde consenso domina (para N = 3, 5)
lambda_grid <- seq(0, 5, by = 0.05)
c_grid <- seq(0.01, 1.5, by = 0.02)
p_fixed <- 0.25

compute_UH_scalar <- function(lambda, N_val, rule, c_val, p_val) {
  s2 <- compute_stage2(N_val)
  n_val <- N_val - 1
  g <- g_fun(n_val, lambda)
  if (rule == "M") {
    A <- g + s2$V_H_M; tau <- c_val - s2$V_W_M
  } else {
    A <- g + s2$V_H_C; tau <- c_val - s2$V_W_C
  }
  if (tau <= 0 || p_val >= tau) return(A)
  return(A * p_val / tau)
}

region_data <- expand_grid(N = c(3, 5), lambda = lambda_grid, c = c_grid) |>
  rowwise() |>
  mutate(
    U_M = compute_UH_scalar(lambda, N, "M", c, p_fixed),
    U_C = compute_UH_scalar(lambda, N, "C", c, p_fixed),
    advantage = U_C - U_M
  ) |>
  ungroup() |>
  mutate(N_label = paste0("N = ", N))

fig_region <- ggplot(region_data, aes(x = lambda, y = c, fill = advantage)) +
  geom_tile() +
  scale_fill_gradient2(
    low = "#D55E00", mid = "white", high = "#0072B2", midpoint = 0,
    name = expression(U[H](C) - U[H](M))
  ) +
  geom_contour(aes(z = advantage), breaks = 0, color = "black", linewidth = 0.8) +
  facet_wrap(~ N_label) +
  labs(
    title = "Quando H prefere Consenso?",
    subtitle = sprintf("p = %.2f, α = %.1f  |  g(n) = λn^α  |  Azul = Consenso domina",
                        p_fixed, alpha),
    x = expression(lambda ~ "(intensidade da complementaridade)"),
    y = "c (custo de entrada para fracos)"
  ) +
  theme_minimal(base_size = 12)

ggsave("figures/fig_regiao_by_N.png", fig_region, width = 11, height = 5, dpi = 150)

# 4c. Crossover prior p* (abaixo do qual H prefere consenso)
compute_crossover <- function(N_val, lambda_val, c_val) {
  s2 <- compute_stage2(N_val)
  n_val <- N_val - 1
  g <- g_fun(n_val, lambda_val)
  tau_M <- c_val - s2$V_W_M
  tau_C <- c_val - s2$V_W_C
  A_M <- g + s2$V_H_M
  A_C <- g + s2$V_H_C

  if (abs(tau_M - tau_C) < 1e-10) return(NA_real_)
  if (tau_M <= 0) return(0)

  p_star <- A_C * tau_M / A_M
  min(max(p_star, 0), tau_M)
}

lambda_range <- seq(0.1, 5, by = 0.05)

crossover_data <- expand_grid(
  N = c(3, 5),
  lambda = lambda_range,
  c = c(0.35, 0.5, 0.7)
) |>
  rowwise() |>
  mutate(p_star = compute_crossover(N, lambda, c)) |>
  ungroup() |>
  mutate(
    N_label = paste0("N = ", N),
    c_label = paste0("c = ", c)
  )

fig_crossover <- ggplot(
  filter(crossover_data, !is.na(p_star)),
  aes(x = lambda, y = p_star, color = c_label, linetype = c_label)
) +
  geom_line(linewidth = 0.9) +
  facet_wrap(~ N_label) +
  labs(
    title = "Prior de crossover p*: abaixo, H prefere Consenso",
    subtitle = sprintf("α = %.1f  |  Consenso domina para p < p*(λ, c)", alpha),
    x = expression(lambda ~ "(intensidade da complementaridade)"),
    y = "p* (crossover prior)",
    color = "Custo de entrada",
    linetype = "Custo de entrada"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom") +
  coord_cartesian(ylim = c(0, 1))

ggsave("figures/fig_crossover_by_N.png", fig_crossover, width = 10, height = 5, dpi = 150)

# --- 5. Comparação: como g(n) escala com N para mesmo λ ---

cat("\n=== Scaling de g(n) com N (λ = 1, α = 0.5) ===\n\n")
for (N_val in c(2, 3, 5, 7, 11, 21)) {
  n_val <- N_val - 1
  g_val <- g_fun(n_val, 1.0)
  cat(sprintf("  N = %2d (n = %2d): g(n) = %.3f\n", N_val, n_val, g_val))
}

# --- 6. Papel Essencial do BP ---

cat(sprintf("\n=== Papel do BP (λ = %.1f, c = %.2f) ===\n\n", lambda_default, c_default))
for (N_val in c(3, 5)) {
  s2 <- compute_stage2(N_val)
  n_val <- N_val - 1
  g <- g_fun(n_val, lambda_default)
  tau_M <- c_default - s2$V_W_M
  tau_C <- c_default - s2$V_W_C
  A_M <- g + s2$V_H_M
  A_C <- g + s2$V_H_C

  cat(sprintf("N = %d (g(n) = %.3f):\n", N_val, g))
  cat(sprintf("  τ(M) = %.3f,  τ(C) = %.3f\n", tau_M, tau_C))
  cat(sprintf("  A(M) = %.3f,  A(C) = %.3f\n", A_M, A_C))

  p_star <- compute_crossover(N_val, lambda_default, c_default)
  if (!is.na(p_star)) {
    cat(sprintf("  Crossover: H prefere Consenso para p < %.3f\n", p_star))
  }
  cat("\n")
}

# --- 7. Resumo ---

cat("=== Resumo: Trade-off Agenda Power vs Informational Power ===\n\n")
cat(sprintf("Complementaridade: g(k) = λk^α, α = %.1f (retornos crescentes subquadráticos)\n\n", alpha))
cat("Sob Maioria + Agenda:\n")
cat("  - H extrai via coalizões (Stage 2)\n")
cat("  - Mas fracos antecipam exploração → threshold alto → BP menos eficaz\n\n")
cat("Sob Consenso:\n")
cat("  - H não extrai via agenda (veto neutraliza)\n")
cat("  - Mas fracos confiam mais → threshold baixo → BP mais eficaz\n")
cat("  - H extrai via persuasão na entrada\n\n")
cat("Consenso domina quando:\n")
cat("  - λ é alto (complementaridades fortes)\n")
cat("  - p é baixo (muita incerteza → BP essencial)\n")
cat("  - Retornos decrescentes moderam vantagem de N grande\n")
