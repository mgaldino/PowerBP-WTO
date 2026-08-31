#!/usr/bin/env Rscript

# Seminar figures: informational pivotality and hegemonic agenda power.
# All parameterized panels are theoretical illustrations, not empirical calibrations.

invisible(Sys.setlocale("LC_ALL", "pt_BR.UTF-8"))

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tibble)
})

out_dir <- "presentations/2026-08-30_agenda_information_seminar/figures"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

navy <- "#143B5D"
blue <- "#2C7FB8"
orange <- "#E76F51"
teal <- "#2A9D8F"
gold <- "#E9C46A"
ink <- "#17212B"
muted <- "#66727E"
light <- "#EEF3F6"

theme_seminar <- function(base_size = 17) {
  theme_minimal(base_size = base_size) +
    theme(
      plot.background = element_rect(fill = "white", colour = NA),
      panel.background = element_rect(fill = "white", colour = NA),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "#DDE5EA", linewidth = 0.35),
      axis.title = element_text(colour = ink, face = "bold"),
      axis.text = element_text(colour = ink),
      plot.title = element_text(colour = navy, face = "bold", size = rel(1.32)),
      plot.subtitle = element_text(colour = muted, size = rel(0.95)),
      plot.caption = element_text(colour = muted, hjust = 0, size = rel(0.72), margin = margin(t = 10)),
      legend.position = "top",
      legend.title = element_blank(),
      legend.text = element_text(colour = ink)
    )
}

save_figure <- function(plot, stem, width = 12, height = 6.75) {
  ggsave(file.path(out_dir, paste0(stem, ".png")), plot, width = width, height = height,
         dpi = 220, bg = "white")
  ggsave(file.path(out_dir, paste0(stem, ".pdf")), plot, width = width, height = height,
         device = grDevices::pdf, bg = "white")
}

# Figure 1: the institutional mechanism, held at N = 5 and q = 3.
nodes <- tribble(
  ~rule, ~actor, ~x, ~y, ~included, ~informed,
  "Maioria: há substituto", "H", 0.5, 1.7, FALSE, TRUE,
  "Maioria: há substituto", "W1", 1.6, 2.4, TRUE, FALSE,
  "Maioria: há substituto", "W2", 2.8, 2.4, TRUE, FALSE,
  "Maioria: há substituto", "W3", 2.2, 1.3, TRUE, FALSE,
  "Maioria: há substituto", "W4", 3.5, 1.4, FALSE, FALSE,
  "Unanimidade: H é essencial", "H", 0.9, 1.8, TRUE, TRUE,
  "Unanimidade: H é essencial", "W1", 2.0, 2.5, TRUE, FALSE,
  "Unanimidade: H é essencial", "W2", 3.1, 2.5, TRUE, FALSE,
  "Unanimidade: H é essencial", "W3", 2.0, 1.1, TRUE, FALSE,
  "Unanimidade: H é essencial", "W4", 3.1, 1.1, TRUE, FALSE
) %>%
  mutate(status = case_when(
    informed & included ~ "Informado e essencial",
    informed & !included ~ "Informado, contornado",
    included ~ "Coalizão vencedora",
    TRUE ~ "Fora da coalizão"
  ))

edges <- tribble(
  ~rule, ~x, ~y, ~xend, ~yend,
  "Maioria: há substituto", 1.6, 2.4, 2.8, 2.4,
  "Maioria: há substituto", 1.6, 2.4, 2.2, 1.3,
  "Maioria: há substituto", 2.8, 2.4, 2.2, 1.3,
  "Unanimidade: H é essencial", 0.9, 1.8, 2.0, 2.5,
  "Unanimidade: H é essencial", 0.9, 1.8, 3.1, 2.5,
  "Unanimidade: H é essencial", 0.9, 1.8, 2.0, 1.1,
  "Unanimidade: H é essencial", 0.9, 1.8, 3.1, 1.1,
  "Unanimidade: H é essencial", 2.0, 2.5, 3.1, 2.5,
  "Unanimidade: H é essencial", 2.0, 1.1, 3.1, 1.1
)

p1 <- ggplot() +
  geom_segment(
    data = edges,
    aes(x = x, y = y, xend = xend, yend = yend),
    linewidth = 1.1, colour = "#AAB7C2"
  ) +
  geom_point(
    data = nodes,
    aes(x = x, y = y, fill = status),
    shape = 21, size = 12, colour = "white", stroke = 1.2
  ) +
  geom_text(data = nodes, aes(x = x, y = y, label = actor), colour = "white", fontface = "bold", size = 5) +
  geom_label(
    data = tibble(
      rule = c("Maioria: há substituto", "Unanimidade: H é essencial"),
      x = c(0.55, 2.05), y = c(0.55, 0.55),
      label = c("A coalizão compra outro voto\n→ a exigência privada de H pode ser contornada",
                "Todos precisam de H\n→ sua reserva privada vira restrição")
    ),
    aes(x = x, y = y, label = label),
    hjust = c(0, 0.5), vjust = 0.5, size = 4.2, linewidth = 0,
    fill = "#F7F9FA", colour = ink
  ) +
  facet_wrap(~rule, nrow = 1) +
  scale_fill_manual(values = c(
    "Informado e essencial" = orange,
    "Informado, contornado" = muted,
    "Coalizão vencedora" = blue,
    "Fora da coalizão" = "#C9D2D9"
  )) +
  coord_cartesian(xlim = c(0, 4), ylim = c(0.25, 3.0), clip = "off") +
  labs(
    title = "A regra muda se o voto informado pode ser contornado",
    subtitle = "Mesmo número de votos formais; diferente essencialidade informacional",
    caption = "Figura 1. Mecanismo estilizado para N = 5 e quota de maioria q = 3. H é o único ator que conhece seu tipo."
  ) +
  theme_seminar() +
  theme(
    axis.text = element_blank(), axis.title = element_blank(),
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", colour = navy, size = 16),
    legend.position = "none"
  )
save_figure(p1, "figura_1_substituto_informacional")

# Shared theoretical illustration for Figures 2--5.
m <- 4
N <- m + 1
q <- floor(N / 2) + 1
k <- q - 1
c_votes <- m - k
beta <- 0.90
Z_E <- 1 - k * beta / m
tau_M <- Z_E / beta
o_grid <- seq(0, 1, length.out = 1001)

gap_df <- tibble(o = o_grid) %>%
  mutate(
    region = case_when(
      o <= 1 / m ~ "o <= 1/m",
      beta * o <= Z_E ~ "1/m < o <= tau_M",
      TRUE ~ "o > tau_M"
    ),
    G = case_when(
      o <= 1 / m ~ beta * (c_votes / m) * (1 - beta * o),
      beta * o <= Z_E ~ beta * (c_votes / m - beta * o),
      TRUE ~ (1 - beta) * (beta * o - 1)
    )
  )

p2 <- ggplot(gap_df, aes(o, G, group = region)) +
  annotate("rect", xmin = 0, xmax = 1, ymin = -Inf, ymax = 0, fill = orange, alpha = 0.08) +
  annotate("rect", xmin = 0, xmax = 1, ymin = 0, ymax = Inf, fill = blue, alpha = 0.08) +
  geom_hline(yintercept = 0, linewidth = 0.7, colour = ink) +
  geom_line(linewidth = 1.7, colour = navy) +
  geom_vline(xintercept = c(1 / m, tau_M), linetype = "dashed", colour = muted, linewidth = 0.7) +
  annotate("label", x = 0.10, y = 0.28, label = "Maioria paga mais\ncom tipo conhecido", fill = "white", linewidth = 0, colour = blue, size = 4.3) +
  annotate("label", x = 0.79, y = -0.035, label = "Unanimidade paga mais\npara tipos fortes", fill = "white", linewidth = 0, colour = orange, size = 4.3) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.25), expand = expansion(mult = c(0, 0.01))) +
  scale_y_continuous(expand = expansion(mult = c(0.16, 0.12))) +
  labs(
    title = "Com baixa exigência conhecida, maioria pode pagar mais a H",
    subtitle = expression(G(o) == h[M](o) - h[U](o)~"separa poder público de renda informacional"),
    x = expression("exigência observável de H para aceitar, "~o),
    y = expression("vantagem pública da maioria, "~G(o)),
    caption = "Figura 2. Ilustração teórica: m = 4, beta = 0,90, q = 3. Saltos refletem mudanças de regime; não é calibração da OMC."
  ) +
  theme_seminar()
save_figure(p2, "figura_2_gap_publico")

# Figure 3: an admissible memberwise example of the low-type reversal.
bridge <- tribble(
  ~step, ~label, ~value, ~start, ~end, ~kind,
  1, "Desvantagem pública\n-G(o0)", -0.4095, 0, -0.4095, "Poder público",
  2, "Prêmio informacional\nDelta RI0", 0.5480, -0.4095, 0.1385, "Informação",
  3, "Vantagem privada\ndelta0", 0.1385, 0, 0.1385, "Total"
) %>%
  mutate(xmin = step - 0.31, xmax = step + 0.31,
         ymin = pmin(start, end), ymax = pmax(start, end))

p3 <- ggplot(bridge) +
  geom_hline(yintercept = 0, colour = ink, linewidth = 0.7) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = kind), colour = "white", linewidth = 0.7) +
  geom_segment(data = bridge %>% filter(step < 3), aes(x = xmax, xend = xmax + 0.38, y = end, yend = end), linetype = "dashed", colour = muted) +
  geom_text(aes(x = step, y = if_else(value >= 0, ymax + 0.045, ymin - 0.045), label = sprintf("%+.3f", value)),
            colour = ink, fontface = "bold", size = 5) +
  scale_fill_manual(values = c("Poder público" = blue, "Informação" = orange, "Total" = teal)) +
  scale_x_continuous(breaks = bridge$step, labels = bridge$label) +
  scale_y_continuous(limits = c(-0.52, 0.38), breaks = seq(-0.4, 0.3, 0.1)) +
  labs(
    title = "Até no piso do pooling, a informação carrega a reversão",
    subtitle = expression(delta[0] == -G(o[0]) + Delta*RI[0]),
    x = NULL, y = "diferença de payoff: unanimidade − maioria",
    caption = "Figura 3. Contra o equilíbrio M exibido, usa-se o piso V = 0,729 da faixa U = [0,729; 0,829]. Valores teóricos, não calibração."
  ) +
  theme_seminar() +
  theme(panel.grid.major.x = element_blank())
save_figure(p3, "figura_3_ponte_reversao")

# Figure 4: incidence by type in the same admissible member.
incidence <- tribble(
  ~type, ~channel, ~value,
  "Baixa exigência", "Poder público", -0.4095,
  "Baixa exigência", "Efeito informacional", 0.5480,
  "Baixa exigência", "Efeito total privado", 0.1385,
  "Alta exigência", "Poder público", 0.0190,
  "Alta exigência", "Efeito informacional", -0.1000,
  "Alta exigência", "Efeito total privado", -0.0810
) %>%
  mutate(type = factor(type, levels = c("Baixa exigência", "Alta exigência")))

p4 <- ggplot(incidence, aes(channel, value, fill = channel)) +
  geom_hline(yintercept = 0, colour = ink, linewidth = 0.7) +
  geom_col(width = 0.68, colour = "white", linewidth = 0.6) +
  geom_text(aes(y = value + if_else(value >= 0, 0.035, -0.035), label = sprintf("%+.3f", value)),
            colour = ink, fontface = "bold", size = 4.6) +
  facet_wrap(~type, nrow = 1) +
  scale_fill_manual(values = c("Poder público" = blue, "Efeito informacional" = orange, "Efeito total privado" = teal)) +
  scale_y_continuous(limits = c(-0.55, 0.75), breaks = seq(-0.4, 0.6, 0.2)) +
  labs(
    title = "No piso do pooling, o prêmio favorece a baixa exigência",
    subtitle = "O hegemon que aceitaria menos é pago como se pudesse exigir mais; o tipo alto perde prêmio neste membro",
    x = NULL, y = "unanimidade − maioria",
    caption = "Figura 4. Mesmo par teórico da Figura 3. Comparação entre equilíbrios: não é um ranking universal da correspondência."
  ) +
  theme_seminar() +
  theme(axis.text.x = element_blank(), panel.grid.major.x = element_blank())
save_figure(p4, "figura_4_incidencia_por_tipo")

# Figure 5: direct agenda effect under each rule.
agenda_df <- tibble(o = o_grid) %>%
  mutate(
    segment = case_when(
      o <= 1 / m ~ "baixo",
      o < tau_M ~ "intermediário",
      TRUE ~ "alto"
    ),
    `Maioria` = case_when(
      o <= 1 / m ~ Z_E - (c_votes / m) * beta^2 * o,
      o < tau_M ~ Z_E - beta * o,
      TRUE ~ 0
    ),
    `Unanimidade` = 1 - beta
  )

agenda_long <- bind_rows(
  agenda_df %>% transmute(o, segment, regra = "Maioria", D = Maioria),
  agenda_df %>% transmute(o, segment = "único", regra = "Unanimidade", D = Unanimidade)
)

p5 <- ggplot(agenda_long, aes(o, D, colour = regra, group = interaction(regra, segment))) +
  geom_line(linewidth = 1.7) +
  geom_vline(xintercept = c(1 / m, tau_M), linetype = "dashed", colour = muted, linewidth = 0.7) +
  annotate("label", x = 0.14, y = 0.43, label = "Agenda vale mais sob maioria\npara reservas baixas", fill = "white", linewidth = 0, colour = blue, size = 4.2) +
  annotate("label", x = 0.80, y = 0.15, label = "Sob unanimidade:\nD_U = 1 − beta", fill = "white", linewidth = 0, colour = orange, size = 4.0) +
  annotate(
    "label", x = 0.76, y = 0.37,
    label = "Com informação privada:  T = D + I\nNos pares comparáveis sob U:  T ≥ 0\nPara o tipo alto:  I_U¹ ≤ 0",
    fill = "#F7F9FA", linewidth = 0.35, colour = teal, size = 3.8
  ) +
  scale_colour_manual(values = c("Maioria" = blue, "Unanimidade" = orange)) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.25), expand = expansion(mult = c(0, 0.01))) +
  scale_y_continuous(limits = c(0, 0.60), breaks = seq(0, 0.6, 0.1)) +
  labs(
    title = "Agenda pode elevar o payoff e comprimir a renda informacional",
    subtitle = expression(D[g] == h[g]^A - beta*h[g]^N~": efeito direto sob informação completa"),
    x = expression("exigência observável de H para aceitar, "~o),
    y = "efeito direto da agenda",
    caption = "Figura 5. Ilustração teórica: m = 4, beta = 0,90, q = 3. A_T revisado, ainda não congelado; maioria permanece set-valued no jogo privado."
  ) +
  theme_seminar()
save_figure(p5, "figura_5_efeito_direto_agenda")

message("Wrote five numbered figures to: ", normalizePath(out_dir))
