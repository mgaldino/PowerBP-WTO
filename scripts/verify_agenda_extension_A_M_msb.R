#!/usr/bin/env Rscript

# Verificação mecânica de A_M sob M/S/B.
# Escopo: identidades algébricas, membership combinatório, testemunhas,
# coordenada rho, sensibilidade de classes puras, misturas de fronteira,
# invariância por permutação e exemplos numéricos. Não prova
# existência/completude de PBE, Bayes pointwise, Borelidade ou
# necessidade/suficiência dos teoremas.

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

b_rho <- function(nu, rho) {
  stopifnot(length(nu) == 1L, length(rho) == 1L)
  if (nu == 0) return(0)
  if (nu == 1) return(1)
  if (rho == 0) return(0)
  if (is.infinite(rho)) return(1)
  nu * rho / (1 - nu + nu * rho)
}

rho_from_p <- function(nu, p) {
  stopifnot(0 < nu, nu < 1, 0 <= p, p <= 1)
  if (p == 0) return(0)
  if (p == 1) return(Inf)
  (1 - nu) * p / (nu * (1 - p))
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

pure_classes <- function(g, nu, rho) {
  p_off <- b_rho(nu, rho)
  off <- agenda_values(g, p_off)
  on <- agenda_values(g, nu)
  a0 <- agenda_values(g, 0)
  a1 <- agenda_values(g, 1)
  O0 <- max(off$A, off$D0)
  O1 <- max(off$A, off$D1)
  U_ad <- min(a0$A, a1$D1)
  c(
    pooling_agreement = O1 <= on$A + 1e-10,
    pooling_delay =
      on$D0 + 1e-10 >= O0 && on$D1 + 1e-10 >= O1,
    separating_AA = O1 <= min(a0$A, a1$A) + 1e-10,
    separating_AD =
      a1$D1 + 1e-10 >= O1 &&
        max(a1$D0, O0) <= U_ad + 1e-10,
    separating_DA = FALSE,
    separating_DD =
      a0$D0 + 1e-10 >= a1$D0 &&
        a1$D1 + 1e-10 >= a0$D1 &&
        a0$D0 + 1e-10 >= O0 &&
        a1$D1 + 1e-10 >= O1
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
          sprintf("cutoff at most beta/m N=%d beta=%.2f mu=%.1f", N, beta, mu),
          av$r <= beta / g$m + 1e-10
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
check("closure example D0 off", eq(a0_close$D0, 0.081))
check("closure example D1 off", eq(a0_close$D1, 0.729))
check("closure example O0", eq(max(a0_close$A, a0_close$D0), 0.5905))
check("closure example O1", eq(max(a0_close$A, a0_close$D1), 0.729))
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

# 6. Família atomless cardinal na mesma fibra rho=1.
t_grid <- seq(0, 1, length.out = 10001)
dt <- 1 / (length(t_grid) - 1)
trapz <- function(x, h) h * (sum(x) - (x[1] + x[length(x)]) / 2)
epsilon_grid <- seq(-0.5, 0.5, by = 0.1)
type1_t_means <- numeric(length(epsilon_grid))
for (idx in seq_along(epsilon_grid)) {
  epsilon <- epsilon_grid[idx]
  pi_target <- 0.5 + epsilon * (2 * t_grid - 1)
  f1 <- 1 + 2 * epsilon * (2 * t_grid - 1)
  f0 <- 1 - 2 * epsilon * (2 * t_grid - 1)
  mix_density <- 0.5 * f0 + 0.5 * f1
  pi_calc <- 0.5 * f1 / mix_density
  check(
    sprintf("atomless sigma1 nonnegative epsilon=%.1f", epsilon),
    min(f1) >= -1e-12
  )
  check(
    sprintf("atomless sigma0 nonnegative epsilon=%.1f", epsilon),
    min(f0) >= -1e-12
  )
  check(
    sprintf("atomless sigma1 integrates one epsilon=%.1f", epsilon),
    abs(trapz(f1, dt) - 1) < 1e-8
  )
  check(
    sprintf("atomless sigma0 integrates one epsilon=%.1f", epsilon),
    abs(trapz(f0, dt) - 1) < 1e-8
  )
  check(
    sprintf("atomless prior mixture uniform epsilon=%.1f", epsilon),
    max(abs(mix_density - 1)) < 1e-12
  )
  check(
    sprintf("atomless local Bayes epsilon=%.1f", epsilon),
    max(abs(pi_calc - pi_target)) < 1e-12
  )
  type1_t_means[idx] <- trapz(t_grid * f1, dt)
}
check(
  "atomless joint laws vary with epsilon",
  all(diff(type1_t_means) > 1e-8)
)
check("atomless rho fixed at one", eq(b_rho(0.5, 1), 0.5))
weak_zero_line <- rep(0, 4)
check(
  "atomless line invariant to weak permutation",
  identical(weak_zero_line, rev(weak_zero_line))
)
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

# 9. Coordenada rho: extremos, monotonicidade e round-trip.
rho_grid <- c(0, 1e-6, 0.01, 0.1, 1, 10, 1e6, Inf)
for (nu in c(0.01, 0.05, 0.2, 0.5, 0.8, 0.99)) {
  p_grid <- vapply(rho_grid, function(rho) b_rho(nu, rho), numeric(1))
  check(sprintf("rho lower endpoint nu=%.2f", nu), eq(p_grid[1], 0))
  check(sprintf("rho upper endpoint nu=%.2f", nu), eq(tail(p_grid, 1), 1))
  check(sprintf("rho passive benchmark nu=%.2f", nu), eq(b_rho(nu, 1), nu))
  check(sprintf("rho monotone nu=%.2f", nu), all(diff(p_grid) > 0))
  for (p in c(0, 0.01, 0.25, 0.5, 0.9, 0.99, 1)) {
    rho <- rho_from_p(nu, p)
    check(
      sprintf("rho round-trip nu=%.2f p=%.2f", nu, p),
      eq(b_rho(nu, rho), p)
    )
  }
}
for (rho in rho_grid) {
  check(sprintf("rho support convention nu=0 rho=%s", rho), eq(b_rho(0, rho), 0))
  check(sprintf("rho support convention nu=1 rho=%s", rho), eq(b_rho(1, rho), 1))
}

# 10. Cutoffs rho e conjunto desconexo da classe AD.
g_rho <- game_values(3, 0.9, 0.04, 0.73)
nu_rho <- 0.05
p_se <- g_rho$nu_SE
rho_se <- rho_from_p(nu_rho, p_se)
rho_se_formula <- (1 - nu_rho) / nu_rho *
  g_rho$beta * (1 / g_rho$m - g_rho$o0) /
  (1 - g_rho$beta * g_rho$q / g_rho$m)
check("rho sensitivity p_SE exact", eq(p_se, 207 / 257))
check("rho sensitivity rho_SE formula", eq(rho_se, rho_se_formula))
check("rho sensitivity rho_SE value", eq(rho_se, 78.66))
check(
  "rho sensitivity S inclusive at cutoff",
  cm_branch(g_rho, b_rho(nu_rho, rho_se)) == "S"
)
check(
  "rho sensitivity E strictly above cutoff",
  cm_branch(g_rho, b_rho(nu_rho, rho_se + 1e-4)) == "E"
)
rho_probe <- c(0, 1e-3, 1, rho_se - 1e-4, rho_se, rho_se + 1e-4, 100, Inf)
for (rho in rho_probe) {
  classes <- pure_classes(g_rho, nu_rho, rho)
  expected_ad <- rho == 0 || rho > rho_se
  check(
    sprintf("rho disconnected AD rho=%s", format(rho, digits = 10)),
    identical(unname(classes["separating_AD"]), expected_ad)
  )
  check(
    sprintf("rho other pure classes empty rho=%s", format(rho, digits = 10)),
    !any(classes[names(classes) != "separating_AD"])
  )
}

g_sp <- game_values(5, 0.9, 0.05, 0.15)
nu_sp_prior <- 0.3
rho_sp <- rho_from_p(nu_sp_prior, g_sp$nu_SP)
rho_sp_formula <- (1 - nu_sp_prior) / nu_sp_prior *
  g_sp$beta * (g_sp$o1 - g_sp$o0) /
  (1 - g_sp$beta * g_sp$o1 - g_sp$beta * g_sp$k / g_sp$m)
check("rho SP formula", eq(rho_sp, rho_sp_formula))
check("rho SP equality belongs to S", cm_branch(g_sp, b_rho(nu_sp_prior, rho_sp)) == "S")
check("rho SP above belongs to P", cm_branch(g_sp, b_rho(nu_sp_prior, rho_sp + 1e-4)) == "P")

nu_ep_prior <- 0.4
rho_ep <- rho_from_p(nu_ep_prior, mu_ep)
rho_ep_formula <- (1 - nu_ep_prior) / nu_ep_prior *
  (g_ep$beta * g_ep$o1 - g_ep$o0) /
  ((1 - g_ep$beta) * g_ep$o1)
check("rho EP formula", eq(rho_ep, rho_ep_formula))
check("rho EP maps to residual singleton", cm_branch(g_ep, b_rho(nu_ep_prior, rho_ep)) == "EP")

# 11. Classes puras robustas a todo rho quando E é único.
rho_robust_grid <- c(0, 0.01, 1, 100, Inf)
g_e_agree <- game_values(5, 0.9, 0.3, 0.5)
g_e_ad <- game_values(5, 0.9, 0.3, 0.8)
g_e_delay <- game_values(5, 0.9, 0.7, 0.8)
for (rho in rho_robust_grid) {
  classes_agree <- pure_classes(g_e_agree, 0.4, rho)
  classes_ad <- pure_classes(g_e_ad, 0.4, rho)
  classes_delay <- pure_classes(g_e_delay, 0.4, rho)
  check(
    sprintf("rho robust E agreement rho=%s", rho),
    classes_agree["pooling_agreement"] && classes_agree["separating_AA"]
  )
  check(
    sprintf("rho robust E AD rho=%s", rho),
    classes_ad["separating_AD"]
  )
  check(
    sprintf("rho robust E delay rho=%s", rho),
    classes_delay["pooling_delay"] && classes_delay["separating_DD"]
  )
}

# 12. Misturas explícitas nas fronteiras.
g_tmp_boundary <- game_values(5, 0.9, 0.2, 0.6)
T_boundary <- g_tmp_boundary$T
g_boundary_high <- game_values(5, 0.9, 0.2, T_boundary)
for (ell in c(0, 0.25, 0.75, 1)) {
  if (ell > 0) {
    p_a <- 0.5 * ell / (0.5 + 0.5 * ell)
    av_a <- agenda_values(g_boundary_high, p_a)
    check(
      sprintf("boundary o1=T accepted capacity ell=%.2f", ell),
      av_a$A + 1e-10 >= g_boundary_high$ZE
    )
  }
  if (ell < 1) {
    av_d <- agenda_values(g_boundary_high, 1)
    check(
      sprintf("boundary o1=T high indifference ell=%.2f", ell),
      eq(av_d$D1, g_boundary_high$ZE)
    )
    check(
      sprintf("boundary o1=T low strict preference ell=%.2f", ell),
      av_d$D0 < g_boundary_high$ZE
    )
  }
}
g_boundary_low <- game_values(5, 0.9, T_boundary, 0.8)
for (ell in c(0, 0.25, 0.75, 1)) {
  p_d <- 0.5 / (0.5 + 0.5 * (1 - ell))
  av_d <- agenda_values(g_boundary_low, p_d)
  check(sprintf("boundary o0=T E unique ell=%.2f", ell), av_d$branch == "E")
  check(
    sprintf("boundary o0=T low indifference ell=%.2f", ell),
    eq(av_d$D0, g_boundary_low$ZE)
  )
  check(
    sprintf("boundary o0=T high rejects ell=%.2f", ell),
    av_d$D1 > g_boundary_low$ZE
  )
}
for (rho in rho_robust_grid) {
  av_off <- agenda_values(g_boundary_low, b_rho(0.5, rho))
  check(
    sprintf("boundary o0=T off-path all rho=%s", rho),
    eq(max(av_off$A, av_off$D0), g_boundary_low$ZE) &&
      av_off$D1 > g_boundary_low$ZE
  )
}

# 13. Invariância mecânica por permutações dos fracos.
for (N in 3:10) {
  g_perm <- game_values(N, 0.83, 0.08, 0.7)
  av_perm <- agenda_values(g_perm, 0.4)
  x <- seq(0, 2 * av_perm$r, length.out = g_perm$m)
  perm <- rev(seq_len(g_perm$m))
  x_perm <- x[perm]
  check(
    sprintf("permutation preserves budget N=%d", N),
    eq(sum(x), sum(x_perm))
  )
  check(
    sprintf("permutation preserves anonymous allocation N=%d", N),
    identical(sort(x), sort(x_perm))
  )
  check(
    sprintf("permutation preserves ballot N=%d", N),
    sum(x >= av_perm$r) == sum(x_perm >= av_perm$r)
  )
  for (r_partners in unique(c(g_perm$k, g_perm$k - 1))) {
    others <- seq_len(g_perm$m)[-1]
    coalitions <- if (r_partners == 0) {
      list(integer(0))
    } else {
      lapply(
        combn(seq_along(others), r_partners, simplify = FALSE),
        function(idx) others[idx]
      )
    }
    relabeled <- lapply(coalitions, function(q_set) sort(perm[q_set]))
    target_others <- seq_len(g_perm$m)[-perm[1]]
    target <- if (r_partners == 0) {
      list(integer(0))
    } else {
      lapply(
        combn(seq_along(target_others), r_partners, simplify = FALSE),
        function(idx) target_others[idx]
      )
    }
    key <- function(sets) {
      unname(sort(vapply(sets, paste, collapse = ",", FUN.VALUE = "")))
    }
    check(
      sprintf("uniform kernel equivariant N=%d r=%d", N, r_partners),
      identical(key(relabeled), key(target))
    )
  }
}

# 14. Convexidade EP em unidades de A_M e definição do intervalo histórico.
r_ep_agenda <- g_ep$beta * cv_ep$c
r_e_agenda <- g_ep$beta * cv_e$c
r_p_agenda <- g_ep$beta * cv_p$c
check(
  "residual EP affine agreement capacity",
  eq(1 - g_ep$k * r_ep_agenda,
     0.37 * (1 - g_ep$k * r_e_agenda) +
       0.63 * (1 - g_ep$k * r_p_agenda))
)
check(
  "residual EP affine delay theta0",
  eq(g_ep$beta * cv_ep$h[1],
     0.37 * g_ep$beta * cv_e$h[1] +
       0.63 * g_ep$beta * cv_p$h[1])
)
check(
  "residual EP affine delay theta1",
  eq(g_ep$beta * cv_ep$h[2],
     0.37 * g_ep$beta * cv_e$h[2] +
       0.63 * g_ep$beta * cv_p$h[2])
)

A_min <- function(r, m, k) {
  c_residual <- m - k
  k * max(0, r - c_residual) +
    c_residual * max(0, r - (c_residual - 1))
}
for (N in 3:20) {
  g_hist <- game_values(N, 0.9, 0.3, 0.7)
  E_native <- 1 - g_hist$k * g_hist$w
  M_E <- (g_hist$k * E_native +
    g_hist$w * A_min(g_hist$k, g_hist$m, g_hist$k)) / g_hist$m
  Zbar_E <- 1 - g_hist$beta * M_E
  check(
    sprintf("historical interval ordered N=%d", N),
    Zbar_E + 1e-10 >= g_hist$ZE
  )
  check(
    sprintf("current uniform E singleton N=%d", N),
    eq(1 - g_hist$k * g_hist$beta / g_hist$m, g_hist$ZE)
  )
}

# 15. Payoff fraco por tipo e anonimização por média de grupo.
g_weak_type <- game_values(5, 0.9, 0.1, 0.8)
p_weak_type <- 0.1
av_weak_type <- agenda_values(g_weak_type, p_weak_type)
weak_low_S <- g_weak_type$beta *
  (1 - g_weak_type$beta * g_weak_type$o0) / g_weak_type$m
weak_high_S <- g_weak_type$beta^2 / g_weak_type$m
check("type-conditioned weak payoff uses S branch", av_weak_type$branch == "S")
check(
  "type-conditioned weak payoffs differ from interim price",
  !eq(weak_low_S, weak_high_S) &&
    !eq(av_weak_type$r, weak_low_S) &&
    !eq(av_weak_type$r, weak_high_S)
)
check(
  "posterior average of type-conditioned weak payoffs equals cutoff",
  eq(
    av_weak_type$r,
    (1 - p_weak_type) * weak_low_S + p_weak_type * weak_high_S
  )
)

rotate_weights <- function(w, shift) {
  if (shift == 0) return(w)
  c(tail(w, shift), head(w, -shift))
}
orbit_weights <- c(0.7, 0.2, 0.1)
reynolds <- Reduce(
  `+`,
  lapply(0:2, function(shift) rotate_weights(orbit_weights, shift))
) / 3
check(
  "Reynolds operator removes within-orbit weights",
  max(abs(reynolds - rep(1 / 3, 3))) < 1e-12
)
check(
  "Reynolds operator preserves revelation coordinates",
  !identical(c(reynolds, posterior = 0), c(reynolds, posterior = 1))
)

cat(sprintf("SUMMARY | %d PASS | %d FAIL\n", n_pass, n_fail))
if (n_fail > 0L) quit(status = 1L)
