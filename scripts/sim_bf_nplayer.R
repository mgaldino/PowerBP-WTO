# ==============================================================================
# Simulação: Baron-Ferejohn N-Player com Outside Option + BP (v3)
# ==============================================================================
#
# Modelo (2 períodos, backward induction):
#   - N jogadores (N ímpar, ≥ 3), 1 Sender (S), N-1 Receivers (R)
#   - S tem info privada: b ∈ {b_L, b_H}, outside option sempre exercível
#   - Pie de tamanho 1, discount δ
#   - Reconhecimento aleatório (prob 1/N)
#   - Período 2 é terminal (falha → todos recebem 0, S recebe b)
#
# Info revelation:
#   - Se proposer faz screening e S rejeita → b = b_H revelado
#   - Período 2 jogado com info completa nesse caso
#
# ==============================================================================

library(tidyverse)

# --- 1. Período 2 (terminal) ---

# Caso A: info completa, b conhecido.
# Sob unanimidade: proposer oferece b a S, 0 a R's. Fica com 1-b.
# Sob maioria: proposer exclui S. Oferece 0 a q R's. Fica com 1. S recebe b.

# E[payoff R | período 2, b conhecido, unanimidade]:
#   R propõe (1/N): fica com 1-b
#   Outro jogador propõe ((N-1)/N): R recebe 0
cont_R_known_unan <- function(N, b) (1 / N) * (1 - b)

# E[payoff S | período 2, b conhecido, unanimidade]:
#   S propõe (1/N): fica com 1
#   R propõe ((N-1)/N): S recebe b
cont_S_known_unan <- function(N, b) 1 / N + (N - 1) * b / N

# Caso B: info incompleta, prior μ, período 2 terminal.
# Proposer R escolhe entre screening e pooling.
# Screen: oferece b_L. Aceito se b=b_L (prob 1-μ). Se b=b_H, falha → S recebe b_H, R recebe 0.
# Pool: oferece b_H. Sempre aceito. R fica com 1-b_H.
#
# Payoff de R como proposer no período 2 terminal:
#   Screen: (1-μ)(1-b_L)
#   Pool: 1-b_H
# R escolhe max.

# Threshold no período 2: μ₂* onde (1-μ₂*)(1-b_L) = 1-b_H
# → μ₂* = (b_H-b_L)/(1-b_L)  (= threshold do TITL)
mu_star_terminal <- function(b_L, b_H) (b_H - b_L) / (1 - b_L)

# Payoff de S com b_L no período 2 terminal com info incompleta (prior μ₂):
# S propõe (1/N): 1
# R propõe ((N-1)/N):
#   Se μ₂ < μ₂* (R faz screening): S com b_L aceita, recebe b_L
#   Se μ₂ ≥ μ₂* (R faz pooling): S aceita, recebe b_H
cont_S_L_incomplete <- function(N, b_L, b_H, mu2) {
  ms <- mu_star_terminal(b_L, b_H)
  s_from_r <- if (mu2 < ms) b_L else b_H
  1 / N + (N - 1) / N * s_from_r
}

# Payoff de S com b_H no período 2 terminal com info incompleta (prior μ₂):
# S propõe (1/N): 1
# R propõe ((N-1)/N):
#   Se μ₂ < μ₂* (screening): S com b_H rejeita, proposta falha, S recebe b_H
#   Se μ₂ ≥ μ₂* (pooling): S aceita, recebe b_H
# Em ambos os casos S recebe b_H quando R propõe.
cont_S_H_incomplete <- function(N, b_H) {
  1 / N + (N - 1) / N * b_H
}

# Payoff de R como proposer no período 2 terminal com info incompleta:
cont_R_proposer_incomplete <- function(b_L, b_H, mu2) {
  ms <- mu_star_terminal(b_L, b_H)
  screen_payoff <- (1 - mu2) * (1 - b_L)
  pool_payoff <- 1 - b_H
  max(screen_payoff, pool_payoff)
}

# E[payoff R | período 2, info incompleta, unanimidade]:
#   R propõe (1/N): max{(1-μ₂)(1-b_L), 1-b_H}
#   Outro jogador propõe ((N-1)/N): R recebe 0
cont_R_incomplete_unan <- function(N, b_L, b_H, mu2) {
  (1 / N) * cont_R_proposer_incomplete(b_L, b_H, mu2)
}

# --- 2. Período 1: backward induction ---

solve_bf <- function(N, b_L, b_H, p, delta, rule) {
  stopifnot(b_L < b_H, b_L >= 0, b_H < 1, N >= 3, N %% 2 == 1)

  q <- if (rule == "unanimity") N - 1 else (N - 1) / 2

  # Reserva de R no período 1:
  # Se proposta período 1 falha sem revelar b (e.g., proposta com pooling rejeitada
  # por outro motivo, ou S aceita mas outro vota contra — mas sob unanimidade/maioria
  # com TITL, a aceitação é da coalizão inteira).
  # Baseline: período 2 com info incompleta, prior p.
  r_R <- delta * cont_R_incomplete_unan(N, b_L, b_H, p)

  # Reserva de S no período 1 (S conhece b):
  # S compara oferta com max{b, δ × cont_S_period2(b, info)}.
  # Info no período 2 depende do que aconteceu no período 1.
  # On-path com screening: S com b_L aceita (info não muda),
  #   S com b_H rejeita (b_H revelado).
  # Reserva de S = max{b, δ × cont no melhor cenário de rejeição}.
  #
  # Para S com b_L: alternativa a aceitar é rejeitar e ir para período 2
  #   com info incompleta (rejeição de b_L é off-path, beliefs arbitrários).
  #   On-path, S com b_L aceita. Reserva = max{b_L, δ × cont_S_L_period2}.
  # Para S com b_H: rejeita screening, b_H revelado, período 2 completo.
  #   Reserva = max{b_H, δ × cont_S_known_unan(N, b_H)}.

  cont_s_l <- cont_S_L_incomplete(N, b_L, b_H, p)
  cont_s_h <- cont_S_known_unan(N, b_H)  # b_H revelado após rejeição
  r_S_L <- max(b_L, delta * cont_s_l)
  r_S_H <- max(b_H, delta * cont_s_h)

  # Quando S propõe (prob 1/N): oferece r_R a cada parceiro
  s_as_proposer <- 1 - q * r_R

  # Quando R propõe (prob (N-1)/N):
  if (rule == "unanimity") {
    # Proposer DEVE incluir S (N-1 parceiros = N-2 R's + S)
    cost_R_partners <- (N - 2) * r_R

    # Pooling: oferecer r_S_H a S → sempre aceito
    payoff_pool <- 1 - cost_R_partners - r_S_H

    # Screening: oferecer r_S_L a S → aceito se b=b_L
    payoff_screen_accept <- 1 - cost_R_partners - r_S_L

    # Screening rejeitado (b=b_H revelado): período 2 info completa
    payoff_screen_reject <- delta * cont_R_known_unan(N, b_H)

    # Threshold μ* (proposer indifferent entre screen e pool)
    if (payoff_pool < 0) {
      mu_star <- Inf  # pooling infeasível
    } else if (payoff_screen_accept <= payoff_pool) {
      mu_star <- 0    # pooling always better (impossível se b_H > b_L)
    } else if (payoff_screen_reject >= payoff_pool) {
      mu_star <- Inf  # screening always better (even reject beats pool)
    } else {
      mu_star <- (payoff_screen_accept - payoff_pool) /
                 (payoff_screen_accept - payoff_screen_reject)
    }

    screening <- is.finite(mu_star) && p < mu_star || !is.finite(mu_star)

    # Payoff de S quando R propõe:
    # Screening: v_S(μ) = (1-μ)*r_S_L + μ*r_S_H
    # Pooling: v_S = r_S_H
    if (screening) {
      s_r_proposes_no_bp <- (1 - p) * r_S_L + p * r_S_H
    } else {
      s_r_proposes_no_bp <- r_S_H
    }

    # BP (concavificação): cav(v)(p) = r_S_L + p*(r_S_H-r_S_L)/μ*
    if (is.finite(mu_star) && mu_star > 0 && p < mu_star) {
      s_r_proposes_bp <- r_S_L + p * (r_S_H - r_S_L) / mu_star
    } else {
      s_r_proposes_bp <- s_r_proposes_no_bp
    }

    # R como proposer
    if (screening) {
      r_proposer_no_bp <- (1 - p) * payoff_screen_accept + p * payoff_screen_reject
    } else {
      r_proposer_no_bp <- payoff_pool
    }

    if (is.finite(mu_star) && mu_star > 0 && p < mu_star) {
      lambda <- 1 - p / mu_star
      r_proposer_bp <- lambda * payoff_screen_accept + (1 - lambda) * payoff_pool
    } else {
      r_proposer_bp <- r_proposer_no_bp
    }

  } else {
    # MAIORIA: proposer pode excluir S (q ≤ N-2 para N≥3)
    payoff_pool <- NA_real_
    payoff_screen_accept <- NA_real_
    payoff_screen_reject <- NA_real_
    mu_star <- NA_real_

    payoff_exclude <- 1 - q * r_R

    # S excluído recebe outside option b (S conhece b)
    s_r_proposes_no_bp <- (1 - p) * b_L + p * b_H
    s_r_proposes_bp <- s_r_proposes_no_bp

    r_proposer_no_bp <- payoff_exclude
    r_proposer_bp <- payoff_exclude
  }

  # Payoffs totais
  s_no_bp <- (1 / N) * s_as_proposer + ((N - 1) / N) * s_r_proposes_no_bp
  s_bp <- (1 / N) * s_as_proposer + ((N - 1) / N) * s_r_proposes_bp
  bp_gain <- s_bp - s_no_bp

  tibble(
    N = N, b_L = b_L, b_H = b_H, p = p, delta = delta, rule = rule,
    q = q, r_R = r_R, r_S_L = r_S_L, r_S_H = r_S_H,
    mu_star = mu_star,
    pool_feasible = if (is.na(payoff_pool)) NA else payoff_pool > 0,
    payoff_pool = payoff_pool,
    payoff_screen = payoff_screen_accept,
    payoff_reject = payoff_screen_reject,
    s_as_proposer = s_as_proposer,
    s_no_bp = s_no_bp, s_bp = s_bp, bp_gain = bp_gain,
    r_proposer_no_bp = r_proposer_no_bp, r_proposer_bp = r_proposer_bp
  )
}

# --- 3. Diagnóstico: feasibility ---

cat("=== Diagnóstico: espaço de parâmetros ===\n\n")

diag <- expand_grid(
  N = c(3, 5, 7, 9),
  delta = c(0.3, 0.5, 0.8),
  b_H = seq(0.2, 0.8, by = 0.05),
  b_L = 0.1, p = 0.3
) |>
  filter(b_L < b_H) |>
  pmap_dfr(function(N, delta, b_H, b_L, p) {
    tryCatch(
      solve_bf(N, b_L, b_H, p, delta, "unanimity"),
      error = function(e) tibble(N = N, delta = delta, b_H = b_H, bp_gain = NA_real_)
    )
  })

# --- 4. Cenários com BP gain positivo ---

cat("=== Cenários com BP gain > 0 sob unanimidade ===\n\n")

positive <- diag |>
  filter(!is.na(bp_gain), bp_gain > 1e-6)

if (nrow(positive) > 0) {
  positive |>
    select(N, delta, b_H, r_S_L, r_S_H, mu_star, pool_feasible,
           s_no_bp, s_bp, bp_gain) |>
    mutate(across(where(is.numeric), \(x) round(x, 4))) |>
    print(n = 60)
} else {
  cat("NENHUM cenário com BP gain > 0.\n")
  cat("Top 10 cenários com μ* finito:\n")
  diag |>
    filter(!is.na(mu_star), is.finite(mu_star)) |>
    arrange(desc(bp_gain)) |>
    select(N, delta, b_H, mu_star, pool_feasible, payoff_pool, payoff_screen,
           payoff_reject, bp_gain) |>
    mutate(across(where(is.numeric), \(x) round(x, 4))) |>
    head(10) |>
    print()
}

# --- 5. Gráfico: BP gain por (N, δ, b_H) ---

p_sweep <- ggplot(diag |> filter(!is.na(bp_gain)),
                  aes(x = b_H, y = bp_gain, color = factor(delta))) +
  geom_line(linewidth = 1) +
  geom_point(size = 1) +
  facet_wrap(~paste0("N=", N), scales = "free_y") +
  labs(x = expression(b[H]), y = "BP gain (unanimidade)",
       title = "BP gain do Sender sob unanimidade",
       subtitle = "b_L=0.1, p=0.3",
       color = expression(delta)) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("fig_bf_sweep_bp_gain.png", p_sweep, width = 10, height = 7, dpi = 150)
cat("\nSalvo: fig_bf_sweep_bp_gain.png\n")

# --- 6. Comparação unanimidade vs maioria ---

if (nrow(positive) > 0) {
  cat("\n=== Comparação: melhor cenário ===\n\n")

  best <- positive |> arrange(desc(bp_gain)) |> slice(1)
  res_u <- solve_bf(best$N, 0.1, best$b_H, 0.3, best$delta, "unanimity")
  res_m <- solve_bf(best$N, 0.1, best$b_H, 0.3, best$delta, "majority")

  cat(sprintf("Melhor cenário: N=%d, δ=%.1f, b_H=%.2f\n\n",
              best$N, best$delta, best$b_H))

  cat(sprintf("%-14s  S sem BP   S com BP   BP gain   R proposer\n", "Regra"))
  cat(sprintf("%-14s  %.4f     %.4f     %.4f    %.4f\n", "Unanimidade",
              res_u$s_no_bp, res_u$s_bp, res_u$bp_gain, res_u$r_proposer_no_bp))
  cat(sprintf("%-14s  %.4f     %.4f     %.4f    %.4f\n", "Maioria",
              res_m$s_no_bp, res_m$s_bp, res_m$bp_gain, res_m$r_proposer_no_bp))

  cat(sprintf("\nS prefere unan com BP: %s (%.4f vs %.4f)\n",
              res_u$s_bp > res_m$s_bp, res_u$s_bp, res_m$s_bp))

  # Variação por p
  cat("\n=== Variação por prior p (melhor cenário) ===\n\n")

  df_p <- map_dfr(seq(0.05, 0.95, by = 0.05), function(pp) {
    bind_rows(
      solve_bf(best$N, 0.1, best$b_H, pp, best$delta, "unanimity"),
      solve_bf(best$N, 0.1, best$b_H, pp, best$delta, "majority")
    )
  })

  plot_p <- df_p |>
    select(p, rule, s_no_bp, s_bp) |>
    pivot_longer(c(s_no_bp, s_bp), names_to = "BP", values_to = "payoff") |>
    mutate(label = paste0(rule, ifelse(BP == "s_bp", " (BP)", " (no BP)")))

  p_by_p <- ggplot(plot_p, aes(x = p, y = payoff, color = label, linetype = label)) +
    geom_line(linewidth = 1) +
    labs(x = "Prior p = Pr(b_H)", y = "E[payoff S]",
         title = sprintf("Payoff de S por prior p (N=%d, δ=%.1f, b_H=%.2f)",
                         best$N, best$delta, best$b_H),
         color = NULL, linetype = NULL) +
    theme_minimal() +
    theme(legend.position = "bottom")

  ggsave("fig_bf_payoff_by_p.png", p_by_p, width = 8, height = 5, dpi = 150)
  cat("Salvo: fig_bf_payoff_by_p.png\n")
}

# --- 7. Resumo ---

cat("\n=== Resumo ===\n")
cat(sprintf("Total cenários testados: %d\n", nrow(diag)))
cat(sprintf("Cenários com BP gain > 0: %d\n", nrow(positive)))
if (nrow(positive) > 0) {
  cat(sprintf("BP gain máximo: %.4f (N=%d, δ=%.1f, b_H=%.2f)\n",
              max(positive$bp_gain), best$N, best$delta, best$b_H))
  cat("Padrão: BP gain maior com δ baixo, N grande, b_H moderado.\n")
  cat("Sob maioria: BP gain = 0 em todos os cenários (S excluído).\n")
}
