#!/usr/bin/env Rscript

# Verificações mecânicas para a derivação exploratória explícita de A_M.
# Este script não prova existência ou completude de PBE. Ele confere apenas
# identidades algébricas, construções de incidência e exemplos numéricos.

tol <- 1e-10
n_pass <- 0L
n_fail <- 0L

check <- function(condition, label) {
  if (isTRUE(condition)) {
    n_pass <<- n_pass + 1L
    message("PASS | ", label)
  } else {
    n_fail <<- n_fail + 1L
    message("FAIL | ", label)
  }
}

close_enough <- function(x, y, tolerance = tol) {
  length(x) == length(y) && all(is.finite(x)) &&
    all(is.finite(y)) && max(abs(x - y)) <= tolerance
}

majority_parameters <- function(N, beta, o_0, o_1) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  k <- q - 1L
  w <- beta / m
  list(
    N = N,
    m = m,
    q = q,
    k = k,
    beta = beta,
    o_0 = o_0,
    o_1 = o_1,
    w = w,
    t_0 = beta * o_0,
    t_1 = beta * o_1,
    E = 1 - k * w,
    L = 1 - (k - 1L) * w - beta * o_0,
    P = 1 - (k - 1L) * w - beta * o_1
  )
}

degree_lower_bound <- function(m, k, r) {
  max(0, m * r - (m - k) * (m - 1L))
}

degree_lower_bound_closed <- function(m, k, r) {
  c_size <- m - k
  k * max(0, r - c_size) +
    c_size * max(0, r - (c_size - 1L))
}

regular_incidence <- function(m, r) {
  p <- matrix(r / (m - 1), nrow = m, ncol = m)
  diag(p) <- 0
  p
}

# Constrói uma matriz de probabilidades de inclusão que atinge o menor valor
# possível da soma dos k menores graus de coluna para r=k ou r=k-1.
# Cada linha é implementável por uma loteria sobre subconjuntos de tamanho r.
minimum_incidence <- function(m, k, r) {
  p <- matrix(0, nrow = m, ncol = m)

  if (m %% 2L == 0L) {
    # N ímpar: m=2h e k=h.
    h <- m / 2L
    stopifnot(k == h, r %in% c(k, k - 1L))
    popular <- seq_len(h)
    other <- (h + 1L):m

    if (r == k) {
      for (i in other) p[i, popular] <- 1
      for (i in popular) {
        p[i, setdiff(popular, i)] <- 1
        p[i, h + i] <- 1
      }
    } else if (h > 1L) {
      for (i in popular) p[i, setdiff(popular, i)] <- 1
      for (position in seq_along(other)) {
        i <- other[position]
        omitted <- popular[((position - 1L) %% h) + 1L]
        p[i, setdiff(popular, omitted)] <- 1
      }
    }
  } else {
    # N par: m=2h-1 e k=h.
    h <- (m + 1L) / 2L
    stopifnot(k == h, r %in% c(k, k - 1L))
    popular <- seq_len(h - 1L)
    other <- h:m

    if (r == k) {
      for (position in seq_along(other)) {
        i <- other[position]
        p[i, popular] <- 1
        target <- other[(position %% h) + 1L]
        p[i, target] <- 1
      }
      for (position in seq_along(popular)) {
        i <- popular[position]
        p[i, setdiff(popular, i)] <- 1
        targets <- other[c(((position - 1L) %% h) + 1L,
                           (position %% h) + 1L)]
        p[i, targets] <- 1
      }
    } else {
      for (i in other) p[i, popular] <- 1
      for (position in seq_along(popular)) {
        i <- popular[position]
        p[i, setdiff(popular, i)] <- 1
        p[i, other[position]] <- 1
      }
    }
  }

  p
}

continuation_values <- function(parameters, branch, posterior, incidence) {
  p <- parameters
  d <- colSums(incidence)

  if (branch == "E") {
    C_0 <- (p$E + p$w * d) / p$m
    C_1 <- C_0
    C_I <- C_0
    C_H <- c(p$o_0, p$o_1)
  } else if (branch == "P") {
    C_0 <- (p$P + p$w * d) / p$m
    C_1 <- C_0
    C_I <- C_0
    C_H <- rep(p$beta * p$o_1, 2L)
  } else if (branch == "S") {
    C_0 <- (p$L + p$w * d) / p$m
    C_1 <- rep(p$w, p$m)
    C_I <- (1 - posterior) * C_0 + posterior * C_1
    C_H <- p$beta * c(p$o_0, p$o_1)
  } else {
    stop("Unknown branch")
  }

  reservations <- p$beta * C_I
  agreement_cost <- sum(sort(reservations)[seq_len(p$k)])

  list(
    degrees = d,
    C_0 = C_0,
    C_1 = C_1,
    C_I = C_I,
    C_H = C_H,
    reservations = reservations,
    agreement_cost = agreement_cost,
    Z = 1 - agreement_cost,
    D = p$beta * C_H
  )
}

for (N in 3:20) {
  m <- N - 1L
  k <- floor(N / 2)
  for (r in unique(c(k, k - 1L))) {
    p_min <- minimum_incidence(m, k, r)
    p_reg <- regular_incidence(m, r)
    d_min <- sort(colSums(p_min))
    d_reg <- sort(colSums(p_reg))

    check(close_enough(rowSums(p_min), rep(r, m)),
          sprintf("minimum incidence row sums N=%d r=%d", N, r))
    check(close_enough(diag(p_min), rep(0, m)),
          sprintf("minimum incidence zero diagonal N=%d r=%d", N, r))
    check(min(p_min) >= -tol && max(p_min) <= 1 + tol,
          sprintf("minimum incidence probabilities N=%d r=%d", N, r))
    check(close_enough(sum(d_min[seq_len(k)]),
                       degree_lower_bound(m, k, r)),
          sprintf("degree lower bound attained N=%d r=%d", N, r))
    check(close_enough(degree_lower_bound(m, k, r),
                       degree_lower_bound_closed(m, k, r)),
          sprintf("degree lower bound formulas agree N=%d r=%d", N, r))
    check(close_enough(rowSums(p_reg), rep(r, m)) &&
            close_enough(d_reg, rep(r, m)),
          sprintf("regular incidence upper bound attained N=%d r=%d", N, r))
  }
}

# A fronteira T cobre todo o domínio e fica estritamente acima de 1/m.
for (N in 3:20) {
  m <- N - 1L
  k <- floor(N / 2)
  for (beta in c(0.10, 0.50, 0.90, 0.999)) {
    T_value <- 1 / beta - k / m
    check(T_value > 1 / m,
          sprintf("T strictly above 1/m N=%d beta=%.3f", N, beta))

    o_grid <- seq(0.01, 0.99, length.out = 15)
    coverage_checks <- logical(0)
    for (o_0 in o_grid[-length(o_grid)]) {
      for (o_1 in o_grid[o_grid > o_0]) {
        coverage_checks <- c(coverage_checks,
          (o_1 <= T_value) ||
          (o_0 <= T_value && T_value <= o_1) ||
          (T_value <= o_0))
      }
    }
    check(all(coverage_checks),
          sprintf("T regions cover grid N=%d beta=%.3f", N, beta))

    C_bar <- (1 + beta * (m - k) / m) / m
    A_guarantee <- 1 - k * beta * C_bar
    check(A_guarantee > 0,
          sprintf("uniform agreement guarantee positive N=%d beta=%.3f",
                  N, beta))
    check(A_guarantee + tol >= (1 - k / m)^2,
          sprintf("uniform agreement guarantee analytic bound N=%d beta=%.3f",
                  N, beta))
  }
}

# Identidades de soma dos payoffs fracos em cada ramo.
set.seed(20260828)
for (N in 3:12) {
  par <- majority_parameters(N, 0.83, 0.08, 0.31)

  inc_E <- regular_incidence(par$m, par$k)
  val_E <- continuation_values(par, "E", 0.4, inc_E)
  check(close_enough(sum(val_E$C_I), 1),
        sprintf("weak budget identity E N=%d", N))

  inc_P <- regular_incidence(par$m, par$k - 1L)
  val_P <- continuation_values(par, "P", 0.4, inc_P)
  check(close_enough(sum(val_P$C_I), 1 - par$t_1),
        sprintf("weak budget identity P N=%d", N))

  val_S <- continuation_values(par, "S", 0.4, inc_P)
  expected_total <- 0.6 * (1 - par$t_0) + 0.4 * par$beta
  check(close_enough(sum(val_S$C_I), expected_total),
        sprintf("weak budget identity S N=%d", N))
  check(close_enough(val_S$D, par$beta^2 * c(par$o_0, par$o_1)),
        sprintf("single outer beta after S N=%d", N))
}

# Exemplo 1: pooling com acordo imediato (N=5, parâmetros do exemplo do paper).
pool <- majority_parameters(5, 0.9, 0.10, 0.35)
pool_on <- continuation_values(
  pool, "E", 0.5, minimum_incidence(pool$m, pool$k, pool$k)
)
pool_off <- continuation_values(
  pool, "E", 1, regular_incidence(pool$m, pool$k)
)
check(close_enough(pool_on$Z, 0.65125),
      "pooling example on-path payoff")
check(close_enough(pool_off$Z, 0.55),
      "pooling example off-path agreement bound")
check(pool_on$Z + tol >= max(pool_off$Z, pool_off$D[2]),
      "pooling example global H1 deviation check")

# Exemplo 2: separação com acordo do tipo baixo e atraso do tipo alto.
sep <- majority_parameters(5, 0.9, 0.10, 0.70)
sep_low <- continuation_values(
  sep, "S", 0, minimum_incidence(sep$m, sep$k, sep$k - 1L)
)
sep_high <- continuation_values(
  sep, "E", 1, regular_incidence(sep$m, sep$k)
)
z_sep <- 0.59
M0_sep <- max(sep_high$Z, sep_high$D[1])
M1_sep <- max(sep_high$Z, sep_high$D[2])
check(z_sep <= sep_low$Z + tol,
      "separating example low agreement feasible")
check(z_sep + tol >= max(sep_high$D[1], M0_sep),
      "separating example low type deviations")
check(sep_high$D[2] + tol >= max(z_sep, M1_sep),
      "separating example high type deviations")
check(close_enough(sep_high$D, c(0.09, 0.63)),
      "separating example rejected continuation payoffs")

# Exemplo 3: semipooling; H1 mistura entre acordo e atraso.
lambda_high_pool <- 0.25
prior <- 0.5
mu_common <- prior * lambda_high_pool /
  ((1 - prior) + prior * lambda_high_pool)
semi_common <- continuation_values(
  sep, "S", mu_common,
  minimum_incidence(sep$m, sep$k, sep$k - 1L)
)
z_semi <- sep$beta * sep$o_1
check(close_enough(mu_common, 0.2),
      "semipooling Bayes posterior")
check(z_semi <= semi_common$Z + tol,
      "semipooling common agreement feasible")
check(close_enough(z_semi, sep_high$D[2]),
      "semipooling H1 indifference")
check(z_semi + tol >= max(sep_high$D[1], M0_sep),
      "semipooling H0 deviations")

# Exemplo 4: pooling com atraso quando ambos os outside options são altos.
delay <- majority_parameters(5, 0.9, 0.70, 0.80)
delay_E <- continuation_values(
  delay, "E", 0.5, regular_incidence(delay$m, delay$k)
)
check(delay_E$D[1] + tol >= delay_E$Z,
      "pooling delay low type prefers continuation")
check(delay_E$D[2] + tol >= delay_E$Z,
      "pooling delay high type prefers continuation")

# A família flat E cobre o intervalo entre o membro regular e o mínimo.
flat_E_cyclic <- continuation_values(
  pool, "E", 0.5, regular_incidence(pool$m, pool$k)
)
flat_E_max <- continuation_values(
  pool, "E", 0.5, minimum_incidence(pool$m, pool$k, pool$k)
)
check(flat_E_cyclic$Z <= flat_E_max$Z + tol,
      "flat E payoff interval ordered")
check(close_enough(c(flat_E_cyclic$Z, flat_E_max$Z),
                   c(0.55, 0.65125)),
      "flat E payoff interval endpoints")

# Contraexemplo mecânico de AM-L2: um seletor que reordena os graus conforme
# os pagamentos da própria proposta. O teste é deliberadamente separado dos
# exemplos de equilíbrio; ele detecta o retorno indevido da afirmação
# "17/25 é atingível".
ce <- majority_parameters(5, 4 / 5, 3 / 10, 2 / 5)
rank_degrees <- function(x) {
  order_desc <- order(-x, seq_along(x))
  degrees <- rep(1, length(x))
  degrees[order_desc[seq_len(ce$k)]] <- 3
  degrees
}
counterexample_prices <- function(x) {
  d <- rank_degrees(x)
  ce$beta * (ce$E + ce$w * d) / ce$m
}
counterexample_passes <- function(x) {
  prices <- counterexample_prices(x)
  sum(x + tol >= prices) >= ce$k
}

check(ce$o_0 > 1 / ce$m &&
        close_enough(c(ce$E, ce$w), c(3 / 5, 1 / 5)),
      "counterexample only-E branch and constants")
x_reference <- c(4 / 10, 3 / 10, 2 / 10, 1 / 10)
prices_reference <- counterexample_prices(x_reference)
check(close_enough(prices_reference, c(6 / 25, 6 / 25, 4 / 25, 4 / 25)),
      "counterexample ranked prices")
naive_target <- order(prices_reference)[seq_len(ce$k)]
x_naive <- rep(0, ce$m)
x_naive[naive_target] <- prices_reference[naive_target]
naive_K <- sum(sort(prices_reference)[seq_len(ce$k)])
naive_share <- 1 - naive_K
check(close_enough(c(naive_K, naive_share), c(8 / 25, 17 / 25)),
      "counterexample naive pointwise calculation")
check(!counterexample_passes(x_naive),
      "counterexample pointwise-cheapest proposal is rejected after reranking")

x_actual <- c(6 / 25, 6 / 25, 0, 0)
actual_prices <- counterexample_prices(x_actual)
actual_transfer <- sum(x_actual)
actual_share <- 1 - actual_transfer
check(counterexample_passes(x_actual) &&
        close_enough(actual_prices, c(6 / 25, 6 / 25, 4 / 25, 4 / 25)),
      "counterexample self-consistent proposal passes")
check(close_enough(c(actual_transfer, actual_share),
                   c(12 / 25, 13 / 25)),
      "counterexample attained transfer and H share")

# Rank-case certificate: if both top offers pass, cost >=12/25; if exactly
# one top offer passes, order forces cost >=14/25; if no top offer passes,
# two bottom yes votes force cost >=16/25.
rank_case_lower_bound <- function(x) {
  x_sorted <- sort(x, decreasing = TRUE)
  top_yes <- sum(x_sorted[seq_len(ce$k)] + tol >= 6 / 25)
  if (top_yes == ce$k) {
    12 / 25
  } else if (top_yes == 1) {
    14 / 25
  } else {
    16 / 25
  }
}
grid_values <- c(0, 4 / 25, 6 / 25)
grid <- expand.grid(x1 = grid_values, x2 = grid_values,
                    x3 = grid_values, x4 = grid_values)
grid_pass <- apply(grid, 1, counterexample_passes)
grid_lower_bound <- apply(grid, 1, rank_case_lower_bound)
grid_transfers <- rowSums(grid)
check(all(!grid_pass | grid_transfers + tol >= 12 / 25) &&
        all(!grid_pass | grid_transfers + tol >= grid_lower_bound),
      "counterexample rank-case lower bound")
check(close_enough(c(actual_share, naive_share),
                   c(13 / 25, 17 / 25)) &&
        actual_share + tol < naive_share,
      "regression guard rejects 17/25 as attainable")

# Contraexemplos de endpoint registrados pela revisão guiada. Eles só testam
# as desigualdades numéricas que excluem transportar AMX-003/AMX-007 para
# nu=0; não constituem prova do teorema nem substituem a remissão a AMX-005.
endpoint_003 <- majority_parameters(5, 0.9, 0.1, 0.7)
endpoint_003_S <- continuation_values(
  endpoint_003, "S", 0,
  regular_incidence(endpoint_003$m, endpoint_003$k - 1L)
)
endpoint_003_T <- 1 / endpoint_003$beta - endpoint_003$k / endpoint_003$m
check(close_enough(c(endpoint_003_T, endpoint_003$E), c(0.611111111111111, 0.55)),
      "AMX-003 endpoint counterexample constants")
check(close_enough(endpoint_003_S$D[2], endpoint_003$beta^2 * endpoint_003$o_1) &&
        close_enough(endpoint_003_S$Z, 0.5905) &&
        endpoint_003_S$Z > endpoint_003_S$D[2],
      "AMX-003 endpoint: high type prefers agreement")

endpoint_007 <- majority_parameters(5, 0.8, 0.1, 0.75)
endpoint_007_S <- continuation_values(
  endpoint_007, "S", 0,
  minimum_incidence(endpoint_007$m, endpoint_007$k, endpoint_007$k - 1L)
)
endpoint_007_ZE <- 1 - endpoint_007$beta * endpoint_007$k / endpoint_007$m
endpoint_007_T <- 1 / endpoint_007$beta - endpoint_007$k / endpoint_007$m
check(close_enough(c(endpoint_007_T, endpoint_007_ZE), c(0.75, 0.6)),
      "AMX-007 endpoint counterexample constants")
check(close_enough(endpoint_007_S$D[2], 0.48) &&
        close_enough(endpoint_007_ZE, endpoint_007$beta * endpoint_007$o_1) &&
        endpoint_007_ZE > endpoint_007_S$D[2],
      "AMX-007 endpoint: high type is not indifferent")

message(sprintf("SUMMARY | %d PASS | %d FAIL", n_pass, n_fail))
if (n_fail > 0L) quit(status = 1L)
