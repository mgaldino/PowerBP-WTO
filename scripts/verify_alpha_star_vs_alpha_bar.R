# verify_alpha_star_vs_alpha_bar.R
# Verifica se alpha* < alpha_bar sempre vale.
# Se NAO: existe gap onde Lemma 1 se aplica (alpha < alpha*)
# mas estamos fora do regime principal (alpha >= alpha_bar).
#
# Resultado: alpha* >= alpha_bar em 26.823 combinacoes.
# O gap NAO e raro — e comum para beta alto.

source("scripts/model_functions.R")

alpha_star_fn <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) - beta * (N^2 - N - q + 1))
}

alpha_bar_fn <- function(r, N, beta) {
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc <- phi^2 - 4 * (N - 2)
  if (disc < 0) return(NA)
  mu_s <- (phi - sqrt(disc)) / (2 * (N - 2))
  if (mu_s <= 0 || mu_s >= 1) return(NA)
  mu_s * r / (r - 1 + mu_s)
}

# --- Parte 1: contagem de violacoes ---

cat("=== alpha* vs alpha_bar: contagem de violacoes ===\n\n")

violations <- 0
total <- 0

for (r in seq(1.05, 5, by = 0.05)) {
  for (N in c(3, 4, 5, 7, 10, 15, 20, 30, 50, 100, 164)) {
    for (beta in seq(0.5, 0.99, by = 0.01)) {
      a_star <- alpha_star_fn(N, beta)
      a_bar <- alpha_bar_fn(r, N, beta)
      if (is.na(a_bar)) next
      total <- total + 1
      if (a_star >= a_bar - 1e-12) {
        violations <- violations + 1
      }
    }
  }
}

cat(sprintf("Total testado: %d\n", total))
cat(sprintf("Violacoes (alpha* >= alpha_bar): %d (%.1f%%)\n\n", violations, 100 * violations / total))

# --- Parte 2: perfil por parametros ---

cat("=== Perfil: quando o gap existe? ===\n\n")

for (r in c(1.1, 1.5, 2.0)) {
  cat(sprintf("r = %.1f:\n", r))
  for (N in c(5, 10, 30, 164)) {
    for (beta in c(0.7, 0.9, 0.95, 0.99)) {
      a_star <- alpha_star_fn(N, beta)
      a_bar <- alpha_bar_fn(r, N, beta)
      if (is.na(a_bar)) next
      if (a_star > a_bar) {
        cat(sprintf("  N=%3d beta=%.2f: alpha_bar=%.4f, alpha*=%.4f => GAP [%.4f, %.4f]\n",
                    N, beta, a_bar, a_star, a_bar, a_star))
      } else {
        cat(sprintf("  N=%3d beta=%.2f: alpha_bar=%.4f, alpha*=%.4f => no gap\n",
                    N, beta, a_bar, a_star))
      }
    }
  }
  cat("\n")
}

# --- Parte 3: Lemma 1 no gap ---

cat("=== Lemma 1 no gap (alpha_bar, alpha*): teste numerico ===\n\n")

fails <- 0
tested <- 0

for (r in c(1.05, 1.1, 1.15, 1.2, 1.5, 2.0)) {
  for (N in c(4, 5, 7, 10, 15, 20, 30)) {
    for (beta in c(0.9, 0.95, 0.97, 0.99)) {
      a_star <- alpha_star_fn(N, beta)
      a_bar <- alpha_bar_fn(r, N, beta)
      if (is.na(a_bar)) next
      if (a_star <= a_bar) next
      upper <- min(a_star, 1 / r - 0.01)
      if (upper <= a_bar) next

      for (alpha in c(a_bar + 0.001, (a_bar + upper) / 2, upper - 0.001)) {
        if (alpha <= a_bar || alpha >= upper) next

        mus <- seq(0.001, 1, by = 0.001)
        D <- sapply(mus, function(m) {
          tryCatch(
            VH_R1_unanimity(r, alpha, m, N, beta) -
              VH_R1_majority(r, alpha, m, N, beta),
            error = function(e) NA
          )
        })
        D <- D[!is.na(D)]
        min_D <- min(D)
        tested <- tested + 1

        if (min_D < -1e-10) {
          fails <- fails + 1
          cat(sprintf("FAIL: r=%.2f N=%d beta=%.2f alpha=%.4f: min_D=%.6f\n",
                      r, N, beta, alpha, min_D))
        }
      }
    }
  }
}

cat(sprintf("Testados no gap: %d, falhas: %d\n", tested, fails))
if (fails == 0) {
  cat("Lemma 1 vale numericamente no gap, mas prova B.5 nao cobre.\n")
}
