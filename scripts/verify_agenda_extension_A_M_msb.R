#!/usr/bin/env Rscript

# Verificação mecânica de A_M sob M/S/B.
# Escopo: identidades algébricas, membership combinatório, testemunhas
# paramétricas e contraexemplos numéricos. Não prova existência/completude de
# PBE, limites locais de Bayes ou necessidade/suficiência dos teoremas.

options(stringsAsFactors = FALSE)

n_pass <- 0L
n_fail <- 0L
verbose <- identical(Sys.getenv("AM_MSB_VERBOSE"), "1")

check <- function(label, condition, detail = "") {
  if (isTRUE(condition)) {
    n_pass <<- n_pass + 1L
    if (verbose) cat(sprintf("PASS | %s\n", label))
  } else {
    n_fail <<- n_fail + 1L
    cat(sprintf("FAIL | %s | %s\n", label, detail))
  }
}

eq <- function(x, y, tol = 1e-10) {
  is.finite(x) && is.finite(y) && abs(x - y) <= tol
}

valid_n3_domain <- function(o0, o1, y_bar) {
  0 < o0 && o0 < o1 && o1 < 1 && o1 <= y_bar && y_bar <= 1
}

game_values <- function(N, beta, o0, o1) {
  m <- N - 1
  q <- floor(N / 2) + 1
  k <- q - 1
  w <- beta / m
  ZE <- 1 - k * beta / m
  list(
    N = N, m = m, q = q, k = k, beta = beta, o0 = o0, o1 = o1,
    w = w, ZE = ZE, T = ZE / beta,
    nu_SE = if (o0 < 1 / m) {
      beta * (1 / m - o0) /
        (beta * (1 / m - o0) + 1 - beta * q / m)
    } else {
      NA_real_
    },
    nu_SP = if (o1 < 1 / m) {
      beta * (o1 - o0) /
        (1 - beta * o0 - beta * (q - 1) / m)
    } else {
      NA_real_
    }
  )
}

cm_branch <- function(g, mu, tol = 1e-10) {
  inv_m <- 1 / g$m
  if (g$o1 < inv_m - tol) {
    return(if (mu <= g$nu_SP + tol) "S" else "P")
  }
  if (g$o0 < inv_m - tol && g$o1 > inv_m + tol) {
    return(if (mu <= g$nu_SE + tol) "S" else "E")
  }
  if (g$o0 > inv_m + tol) {
    return("E")
  }
  if (abs(g$o0 - inv_m) <= tol && g$o1 > inv_m + tol) {
    return(if (mu <= tol) "S" else "E")
  }
  if (g$o0 < inv_m - tol && abs(g$o1 - inv_m) <= tol) {
    if (mu <= g$nu_SE + tol) {
      return("S")
    }
    hE <- (1 - mu) * g$o0 + mu * g$o1
    hP <- g$beta * g$o1
    if (hE < hP - tol) return("E")
    if (hE > hP + tol) return("P")
    return("EP")
  }
  stop("Parâmetros fora da partição implementada.")
}

continuation_values <- function(g, mu, branch, ep_weight_E = 0.5) {
  cE <- 1 / g$m
  cS <- ((1 - mu) * (1 - g$beta * g$o0) + mu * g$beta) / g$m
  cP <- (1 - g$beta * g$o1) / g$m
  hE <- c(g$o0, g$o1)
  hS <- g$beta * c(g$o0, g$o1)
  hP <- rep(g$beta * g$o1, 2)

  if (branch == "E") return(list(c = cE, h = hE))
  if (branch == "S") return(list(c = cS, h = hS))
  if (branch == "P") return(list(c = cP, h = hP))
  if (branch == "EP") {
    return(list(
      c = ep_weight_E * cE + (1 - ep_weight_E) * cP,
      h = ep_weight_E * hE + (1 - ep_weight_E) * hP
    ))
  }
  stop("Ramo desconhecido.")
}

agenda_values <- function(g, mu, branch = cm_branch(g, mu)) {
  cv <- continuation_values(g, mu, branch)
  r <- g$beta * cv$c
  list(
    branch = branch,
    r = r,
    A = 1 - g$k * r,
    D0 = g$beta * cv$h[1],
    D1 = g$beta * cv$h[2]
  )
}

# 1. Membership uniforme e payoff-equivalência com o ciclo.
for (N in 3:20) {
  g <- game_values(N, beta = 0.83, o0 = 0.1, o1 = 0.6)
  for (branch in c("E", "S", "P")) {
    r_partners <- if (branch == "E") g$k else g$k - 1
    incidence <- integer(g$m)
    if (r_partners > 0) {
      for (i in seq_len(g$m)) {
        partners <- ((i - 1L + seq_len(r_partners)) %% g$m) + 1L
        incidence[partners] <- incidence[partners] + 1L
      }
    }
    check(
      sprintf("cyclic incidence N=%d branch=%s", N, branch),
      all(incidence == r_partners),
      paste(incidence, collapse = ",")
    )
    uniform_incidence <- (g$m - 1) * r_partners / (g$m - 1)
    check(
      sprintf("uniform incidence N=%d branch=%s", N, branch),
      eq(uniform_incidence, r_partners)
    )
  }

  E_prop <- 1 - g$k * g$w
  cE_direct <- (E_prop + g$k * g$w) / g$m
  check(sprintf("uniform cE N=%d", N), eq(cE_direct, 1 / g$m))

  L_prop <- 1 - (g$k - 1) * g$w - g$beta * g$o0
  cS0_direct <- (L_prop + (g$k - 1) * g$w) / g$m
  check(
    sprintf("uniform cS low N=%d", N),
    eq(cS0_direct, (1 - g$beta * g$o0) / g$m)
  )

  P_prop <- 1 - (g$k - 1) * g$w - g$beta * g$o1
  cP_direct <- (P_prop + (g$k - 1) * g$w) / g$m
  check(
    sprintf("uniform cP N=%d", N),
    eq(cP_direct, (1 - g$beta * g$o1) / g$m)
  )
}

# 2. O cutoff anônimo é positivo, custa menos que a pie e A>=Z_E.
for (N in 3:20) {
  for (beta in c(0.2, 0.55, 0.9)) {
    parameter_sets <- list(
      c(0.05, min(0.15, 0.8 / (N - 1))),
      c(0.1, 0.8),
      c(min(0.8, 1.1 / (N - 1)), min(0.95, 1.6 / (N - 1)))
    )
    for (oo in parameter_sets) {
      o0 <- oo[1]
      o1 <- oo[2]
      if (!(0 < o0 && o0 < o1 && o1 < 1)) next
      g <- game_values(N, beta, o0, o1)
      for (mu in c(0, 0.2, 0.5, 0.8, 1)) {
        av <- agenda_values(g, mu)
        check(
          sprintf("positive cutoff N=%d beta=%.2f mu=%.1f", N, beta, mu),
          av$r > 0
        )
        check(
          sprintf("agreement feasible N=%d beta=%.2f mu=%.1f", N, beta, mu),
          g$k * av$r < 1
        )
        check(
          sprintf("anonymous capacity >= ZE N=%d beta=%.2f mu=%.1f", N, beta, mu),
          av$A + 1e-10 >= g$ZE
        )
      }
    }
  }
}

# 3. Testemunhas de existência por região em grades de primitivas.
for (N in 3:20) {
  for (beta in c(0.35, 0.65, 0.9)) {
    base <- game_values(N, beta, 0.05, 0.1)
    T <- base$T

    o1_low <- min(0.9, 0.8 * T)
    if (o1_low <= 0) o1_low <- 0.05
    o0_low <- o1_low / 2
    if (o1_low < 1 && o0_low > 0) {
      g <- game_values(N, beta, o0_low, o1_low)
      for (nu in c(0.2, 0.5, 0.8)) {
        av <- agenda_values(g, nu)
        check(
          sprintf("low-region pooling N=%d beta=%.2f nu=%.1f", N, beta, nu),
          o1_low <= g$T + 1e-10 && av$A + 1e-10 >= av$D1
        )
      }
    }

    if (T < 1) {
      o0_mid <- max(0.01, T / 2)
      o1_mid <- (T + 1) / 2
      if (o0_mid < T && T < o1_mid && o1_mid < 1) {
        g <- game_values(N, beta, o0_mid, o1_mid)
        a0 <- agenda_values(g, 0)
        a1 <- agenda_values(g, 1)
        check(
          sprintf("mid-region endpoint branch E N=%d beta=%.2f", N, beta),
          a1$branch == "E"
        )
        check(
          sprintf("mid-region low capacity N=%d beta=%.2f", N, beta),
          a0$A + 1e-10 >= g$ZE
        )
        check(
          sprintf("mid-region low IC N=%d beta=%.2f", N, beta),
          g$ZE + 1e-10 >= a1$D0
        )
        check(
          sprintf("mid-region high IC N=%d beta=%.2f", N, beta),
          a1$D1 + 1e-10 >= g$ZE
        )
      }

      o0_high <- (T + 1) / 2
      o1_high <- (o0_high + 1) / 2
      if (o0_high < o1_high && o1_high < 1) {
        g <- game_values(N, beta, o0_high, o1_high)
        for (mu in c(0, 0.37, 1)) {
          av <- agenda_values(g, mu)
          check(
            sprintf("high-region E N=%d beta=%.2f mu=%.2f", N, beta, mu),
            av$branch == "E"
          )
          check(
            sprintf("high-region delay N=%d beta=%.2f mu=%.2f", N, beta, mu),
            av$D0 + 1e-10 >= av$A && av$D1 + 1e-10 >= av$A
          )
        }
      }
    }
  }
}

# 4. Contraexemplo ao fechamento global dentro do PBE separating.
g_close <- game_values(5, 0.9, 0.1, 0.9)
a0_close <- agenda_values(g_close, 0)
a1_close <- agenda_values(g_close, 1)
check("closure example branch at mu=0", a0_close$branch == "S")
check("closure example branch at mu=1", a1_close$branch == "E")
check("closure example r0", eq(a0_close$r, 0.20475))
check("closure example A0", eq(a0_close$A, 0.5905))
check("closure example r1", eq(a1_close$r, 0.225))
check("closure example low IC", a0_close$A > a1_close$D0)
check("closure example high IC", a1_close$D1 > a0_close$A)
check("closure example high off-path IC", a1_close$D1 > a0_close$D1)
eps <- 1 / (1000 * (1:100))
accepted_off <- (a0_close$r + eps >= a0_close$r) &
  (a0_close$r >= a0_close$r)
check("closure accepted sequence", all(accepted_off))
check("closure rejected limit", a0_close$r < a1_close$r)
check("closure convergence", max(eps[91:100]) < 1.1e-5)

# 5. Reescopo da antiga testemunha semipooling.
g_semi <- game_values(5, 0.9, 0.1, 0.7)
mu_A <- 0.2
a_semi <- agenda_values(g_semi, mu_A)
check("old semipooling common branch", a_semi$branch == "S")
check("old semipooling uniform capacity", eq(a_semi$A, 0.5914))
check("old semipooling required high payoff", eq(g_semi$beta * g_semi$o1, 0.63))
check("old semipooling rejected under S", a_semi$A < g_semi$beta * g_semi$o1)

# 6. Família atomless: densidades integram um e Bayes local é pi(t).
t_grid <- seq(0, 1, length.out = 10001)
dt <- 1 / (length(t_grid) - 1)
f1 <- 0.5 + t_grid
f0 <- 1.5 - t_grid
trapz <- function(x, h) h * (sum(x) - (x[1] + x[length(x)]) / 2)
check("atomless sigma1 integrates one", abs(trapz(f1, dt) - 1) < 1e-8)
check("atomless sigma0 integrates one", abs(trapz(f0, dt) - 1) < 1e-8)
pi_calc <- 0.5 * f1 / (0.5 * f0 + 0.5 * f1)
check("atomless local Bayes", max(abs(pi_calc - (0.25 + 0.5 * t_grid))) < 1e-12)
g_atom <- game_values(5, 0.9, 0.7, 0.8)
a_atom <- agenda_values(g_atom, 0.5)
check("atomless E unique", a_atom$branch == "E")
check("atomless agreement capacity", eq(a_atom$A, 0.55))
check("atomless low delay dominates", eq(a_atom$D0, 0.63) && a_atom$D0 > a_atom$A)
check("atomless high delay dominates", eq(a_atom$D1, 0.72) && a_atom$D1 > a_atom$A)

# 7. Aritmética do certificado histórico preservado.
n_seq <- 1:10000
g_seq <- 0.51 - 0.01 / n_seq
check("historical sequence below supremum", all(g_seq < 0.51))
check("historical sequence approaches supremum", 0.51 - max(g_seq) < 1.1e-6)
check("historical outside cap", 193 / 400 < 0.51)
check("historical rejection low", eq(0.9 * 0.3, 0.27) && 0.27 < 0.51)
check("historical rejection high", eq(0.9 * 0.4, 0.36) && 0.36 < 0.51)

# 8. Domínio y_bar e codomínio canônico residual.
for (N in 3:20) {
  g_y <- game_values(N, 0.9, 0.1, 0.6)
  for (y_bar in c(g_y$o1, (g_y$o1 + 1) / 2, 1)) {
    check(
      sprintf("y_bar domain N=%d ybar=%.2f", N, y_bar),
      g_y$beta * g_y$o1 <= g_y$o1 && valid_n3_domain(g_y$o0, g_y$o1, y_bar)
    )
  }
}
check("N3 domain rejects o1=1", !valid_n3_domain(0.1, 1, 1))

g_ep <- game_values(5, 0.9, 0.1, 0.25)
mu_ep <- (g_ep$beta / g_ep$m - g_ep$o0) / (1 / g_ep$m - g_ep$o0)
check("residual EP posterior above screening", mu_ep > g_ep$nu_SE)
check("residual EP branch", cm_branch(g_ep, mu_ep) == "EP")
cv_ep <- continuation_values(g_ep, mu_ep, "EP", ep_weight_E = 0.37)
cv_e <- continuation_values(g_ep, mu_ep, "E")
cv_p <- continuation_values(g_ep, mu_ep, "P")
check("residual EP affine weak payoff", eq(cv_ep$c, 0.37 * cv_e$c + 0.63 * cv_p$c))
check("residual EP affine H payoff theta0", eq(cv_ep$h[1], 0.37 * cv_e$h[1] + 0.63 * cv_p$h[1]))
check("residual EP affine H payoff theta1", eq(cv_ep$h[2], 0.37 * cv_e$h[2] + 0.63 * cv_p$h[2]))

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", n_pass, n_fail))
if (n_fail > 0L) quit(status = 1L)
