#!/usr/bin/env Rscript

# Exemplos numéricos para o relatório sobre benefícios dos Estados fracos.
# Toda a computação fica neste script; o RMarkdown apenas lê e apresenta
# os resultados versionados em CSV e PNG.

options(stringsAsFactors = FALSE)

dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

tol <- 1e-12

add_expected <- function(rows) {
  rows$contribuicao <- rows$probabilidade * rows$payoff_condicional
  rows
}

summarise_roles <- function(rows) {
  keys <- unique(rows[c("exemplo", "regra", "tipo")])
  out <- vector("list", nrow(keys))
  for (i in seq_len(nrow(keys))) {
    keep <- rows$exemplo == keys$exemplo[i] &
      rows$regra == keys$regra[i] &
      rows$tipo == keys$tipo[i]
    out[[i]] <- data.frame(
      exemplo = keys$exemplo[i],
      regra = keys$regra[i],
      tipo = keys$tipo[i],
      payoff_esperado = sum(rows$contribuicao[keep]),
      soma_probabilidades = sum(rows$probabilidade[keep]),
      stringsAsFactors = FALSE
    )
  }
  do.call(rbind, out)
}

baseline_public_roles <- function(m, beta, o, label) {
  k <- floor((m + 1) / 2)
  w <- beta / m

  if (o <= 1 / m) {
    majority <- data.frame(
      exemplo = label,
      regra = "Maioria",
      tipo = sprintf("o = %.2f", o),
      papel = c("Proponente", "Incluído", "Excluído"),
      probabilidade = c(1 / m, (k - 1) / m, (m - k) / m),
      payoff_condicional = c(1 - beta * o - (k - 1) * w, w, 0),
      observacao = c(
        "Maioria inclui H",
        "Parceiro fraco na coalizão",
        "Fora da coalizão vencedora"
      )
    )
  } else {
    majority <- data.frame(
      exemplo = label,
      regra = "Maioria",
      tipo = sprintf("o = %.2f", o),
      papel = c("Proponente", "Incluído", "Excluído"),
      probabilidade = c(1 / m, k / m, (m - k - 1) / m),
      payoff_condicional = c(1 - k * w, w, 0),
      observacao = c(
        "Maioria exclui H",
        "Parceiro fraco na coalizão",
        "Fora da coalizão vencedora"
      )
    )
  }

  w_u <- beta * (1 - o) / m
  unanimity <- data.frame(
    exemplo = label,
    regra = "Unanimidade",
    tipo = sprintf("o = %.2f", o),
    papel = c("Proponente", "Incluído", "Excluído"),
    probabilidade = c(1 / m, (m - 1) / m, 0),
    payoff_condicional = c(1 - beta * o - (m - 1) * w_u, w_u, 0),
    observacao = c(
      "Proponente fraco compra H e todos os fracos",
      "Todo não proponente é incluído",
      "Não existe sob unanimidade"
    )
  )

  add_expected(rbind(majority, unanimity))
}

baseline_private_screening_roles <- function(m, beta, ell, h, p) {
  k <- floor((m + 1) / 2)
  w <- beta / m
  w_u <- beta * (1 - h) / m
  label <- sprintf("Privado: p = %.3f", p)

  majority_low <- data.frame(
    exemplo = label,
    regra = "Maioria - screening",
    tipo = "H baixo",
    papel = c("Proponente", "Incluído", "Excluído"),
    probabilidade = c(1 / m, (k - 1) / m, (m - k) / m),
    payoff_condicional = c(1 - (k - 1) * w - beta * ell, w, 0),
    observacao = c("Acordo imediato", "Parceiro pago", "Fora da coalizão")
  )

  majority_high <- data.frame(
    exemplo = label,
    regra = "Maioria - screening",
    tipo = "H alto",
    papel = "Continuação",
    probabilidade = 1,
    payoff_condicional = w,
    observacao = "A proposta falha; novo reconhecimento uniforme no Round 2"
  )

  unanimity_low <- data.frame(
    exemplo = label,
    regra = "Unanimidade - pooling",
    tipo = "H baixo",
    papel = c("Proponente", "Incluído", "Excluído"),
    probabilidade = c(1 / m, (m - 1) / m, 0),
    payoff_condicional = c(1 - beta + w_u, w_u, 0),
    observacao = c("Paga o limiar alto", "Todo não proponente é incluído", "Não existe")
  )

  unanimity_high <- unanimity_low
  unanimity_high$tipo <- "H alto"

  add_expected(rbind(majority_low, majority_high, unanimity_low, unanimity_high))
}

agenda_public_roles <- function(m, beta, o, label) {
  k <- floor((m + 1) / 2)
  e <- m - k
  cutoff <- 1 / beta - k / m
  r_u <- beta * (1 - beta * o) / m

  unanimity <- data.frame(
    exemplo = label,
    regra = "Unanimidade",
    tipo = sprintf("o = %.2f", o),
    papel = c("Incluído em A", "Excluído em A"),
    probabilidade = c(1, 0),
    payoff_condicional = c(r_u, 0),
    observacao = c("H compra todos os fracos", "Não existe sob unanimidade")
  )

  if (o <= 1 / m) {
    r_m <- beta * (1 - beta * o) / m
    majority <- data.frame(
      exemplo = label,
      regra = "Maioria",
      tipo = sprintf("o = %.2f", o),
      papel = c("Incluído em A", "Excluído em A"),
      probabilidade = c(k / m, e / m),
      payoff_condicional = c(r_m, 0),
      observacao = c("H compra k fracos", "Fora da coalizão de H")
    )
  } else if (o < cutoff) {
    r_m <- beta / m
    majority <- data.frame(
      exemplo = label,
      regra = "Maioria",
      tipo = sprintf("o = %.2f", o),
      papel = c("Incluído em A", "Excluído em A"),
      probabilidade = c(k / m, e / m),
      payoff_condicional = c(r_m, 0),
      observacao = c("H compra k fracos", "Fora da coalizão de H")
    )
  } else {
    w <- beta / m
    majority <- data.frame(
      exemplo = label,
      regra = "Maioria",
      tipo = sprintf("o = %.2f", o),
      papel = c("Proponente na continuação", "Incluído na continuação", "Fora na continuação"),
      probabilidade = c(1 / m, k / m, (m - k - 1) / m),
      payoff_condicional = beta * c(1 - k * w, w, 0),
      observacao = c(
        "H induz atraso; payoff trazido para a data A",
        "H induz atraso; payoff trazido para a data A",
        "H induz atraso; payoff zero"
      )
    )
  }

  add_expected(rbind(majority, unanimity))
}

agenda_private_canonical_roles <- function(m, beta, ell, h) {
  k <- floor((m + 1) / 2)
  a <- beta * (1 - beta * ell) / m
  b <- beta * (1 - beta * h) / m
  r_e <- beta / m
  r_p <- beta * (1 - beta * h) / m

  rows <- rbind(
    data.frame(
      exemplo = "Agenda privada: propostas canônicas",
      regra = "Maioria - continuação E",
      tipo = "Passagem",
      papel = c("Incluído", "Excluído"),
      probabilidade = c(k / m, (m - k) / m),
      payoff_condicional = c(r_e, 0),
      observacao = c("Preço r_chi = beta/m", "Fora da coalizão de H")
    ),
    data.frame(
      exemplo = "Agenda privada: propostas canônicas",
      regra = "Maioria - continuação P",
      tipo = "Passagem",
      papel = c("Incluído", "Excluído"),
      probabilidade = c(k / m, (m - k) / m),
      payoff_condicional = c(r_p, 0),
      observacao = c("Preço r_chi = beta(1-beta h)/m", "Fora da coalizão de H")
    ),
    data.frame(
      exemplo = "Agenda privada: propostas canônicas",
      regra = "Unanimidade - posterior zero",
      tipo = "Passagem",
      papel = "Incluído",
      probabilidade = 1,
      payoff_condicional = a,
      observacao = "Representante canônico simétrico"
    ),
    data.frame(
      exemplo = "Agenda privada: propostas canônicas",
      regra = "Unanimidade - posterior alto",
      tipo = "Passagem",
      papel = "Incluído",
      probabilidade = 1,
      payoff_condicional = b,
      observacao = "Representante canônico simétrico"
    )
  )

  add_expected(rows)
}

# Parâmetros e exemplos ------------------------------------------------------

m_main <- 4
beta_main <- 0.90
ell_main <- 0.10
h_main <- 0.35
k_main <- floor((m_main + 1) / 2)

public_low <- baseline_public_roles(m_main, beta_main, ell_main, "Benchmark público: H barato")
public_high <- baseline_public_roles(m_main, beta_main, h_main, "Benchmark público: H caro")

m_screen <- 4
beta_screen <- 0.75
ell_screen <- 0.05
h_screen <- 0.15
p_screen <- 0.115
p_star_screen <- (h_screen - ell_screen) / (1 - ell_screen)
p_sp_screen <- beta_screen * (h_screen - ell_screen) /
  (1 - beta_screen * ell_screen - beta_screen * floor((m_screen + 1) / 2) / m_screen)
stopifnot(p_screen > p_star_screen, p_screen < p_sp_screen)

private_screen <- baseline_private_screening_roles(
  m_screen, beta_screen, ell_screen, h_screen, p_screen
)

agenda_public <- do.call(
  rbind,
  list(
    agenda_public_roles(m_main, beta_main, 0.10, "Agenda pública: H barato"),
    agenda_public_roles(m_main, beta_main, 0.35, "Agenda pública: H intermediário"),
    agenda_public_roles(m_main, beta_main, 0.80, "Agenda pública: H caro e atraso")
  )
)

agenda_private <- agenda_private_canonical_roles(
  m_main, beta_main, ell_main, h_main
)

role_rows <- rbind(public_low, public_high, private_screen, agenda_public, agenda_private)
summary_rows <- summarise_roles(role_rows)

# Checks analíticos e lógicos -----------------------------------------------

stopifnot(all(role_rows$probabilidade >= -tol))
stopifnot(all(role_rows$probabilidade <= 1 + tol))
stopifnot(all(role_rows$payoff_condicional >= -tol))
stopifnot(all(abs(summary_rows$soma_probabilidades - 1) < tol))

pub_low_sum <- subset(summary_rows, exemplo == "Benchmark público: H barato")
stopifnot(nrow(pub_low_sum) == 2)
stopifnot(abs(diff(pub_low_sum$payoff_esperado)) < tol)

pub_high_m <- subset(
  summary_rows,
  exemplo == "Benchmark público: H caro" & regra == "Maioria"
)$payoff_esperado
pub_high_u <- subset(
  summary_rows,
  exemplo == "Benchmark público: H caro" & regra == "Unanimidade"
)$payoff_esperado
stopifnot(abs(pub_high_m - 1 / m_main) < tol)
stopifnot(abs(pub_high_u - (1 - beta_main * h_main) / m_main) < tol)

screen_m_low <- subset(
  summary_rows,
  exemplo == sprintf("Privado: p = %.3f", p_screen) &
    regra == "Maioria - screening" & tipo == "H baixo"
)$payoff_esperado
screen_m_high <- subset(
  summary_rows,
  exemplo == sprintf("Privado: p = %.3f", p_screen) &
    regra == "Maioria - screening" & tipo == "H alto"
)$payoff_esperado
screen_u_low <- subset(
  summary_rows,
  exemplo == sprintf("Privado: p = %.3f", p_screen) &
    regra == "Unanimidade - pooling" & tipo == "H baixo"
)$payoff_esperado
screen_u_high <- subset(
  summary_rows,
  exemplo == sprintf("Privado: p = %.3f", p_screen) &
    regra == "Unanimidade - pooling" & tipo == "H alto"
)$payoff_esperado
stopifnot(abs((screen_u_low - screen_m_low) + beta_screen * (h_screen - ell_screen) / m_screen) < tol)
stopifnot(abs((screen_u_high - screen_m_high) -
  (1 - beta_screen * (1 + h_screen)) / m_screen) < tol)

write.csv(
  role_rows,
  "output/tables/beneficios_estados_fracos_papeis.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
write.csv(
  summary_rows,
  "output/tables/beneficios_estados_fracos_resumos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

parameters <- data.frame(
  conjunto = c("principal", "screening"),
  m = c(m_main, m_screen),
  k = c(k_main, floor((m_screen + 1) / 2)),
  beta = c(beta_main, beta_screen),
  ell = c(ell_main, ell_screen),
  h = c(h_main, h_screen),
  p = c(NA_real_, p_screen),
  p_star = c((h_main - ell_main) / (1 - ell_main), p_star_screen),
  p_screen_pool = c(NA_real_, p_sp_screen)
)
write.csv(
  parameters,
  "output/tables/beneficios_estados_fracos_parametros.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Figura: payoff esperado de um fraco na extensão pública ------------------

agenda_summary <- subset(
  summary_rows,
  grepl("^Agenda pública", exemplo)
)
agenda_summary$o <- rep(c(0.10, 0.35, 0.80), each = 2)
agenda_matrix <- tapply(
  agenda_summary$payoff_esperado,
  list(sprintf("o = %.2f", agenda_summary$o), agenda_summary$regra),
  identity
)

png(
  "output/figures/beneficios_estados_fracos_agenda_publica.png",
  width = 1800,
  height = 1050,
  res = 180
)
op <- par(
  mar = c(5.2, 5.2, 2.2, 1.2),
  mgp = c(3.2, 0.9, 0),
  las = 1,
  family = "sans"
)
barplot(
  t(agenda_matrix),
  beside = TRUE,
  col = c("#0072B2", "#E69F00"),
  border = NA,
  ylim = c(0, max(agenda_matrix) * 1.22),
  ylab = "Payoff esperado de um Estado fraco",
  xlab = "Payoff público de desacordo de H",
  legend.text = colnames(agenda_matrix),
  args.legend = list(x = "topright", bty = "n", inset = 0.01)
)
box(bty = "l")
par(op)
dev.off()

cat(sprintf(
  paste0(
    "CHECKS_OK rows=%d summaries=%d p_star=%.6f p_SP=%.6f ",
    "public_high_gap=%.6f private_high_screen_gap=%.6f\n"
  ),
  nrow(role_rows),
  nrow(summary_rows),
  p_star_screen,
  p_sp_screen,
  pub_high_u - pub_high_m,
  screen_u_high - screen_m_high
))

