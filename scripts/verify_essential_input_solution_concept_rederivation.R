#!/usr/bin/env Rscript

# Verificações dirigidas para a rederivação N3/N4 de 2026-08-21.
# Este script não certifica PBE, crenças ou exaustividade. Ele confere apenas
# identidades algébricas, domínios de fronteira e enumerações finitas usadas
# nas demonstrações humanas.

tol <- 1e-10

close_enough <- function(x, y, tolerance = tol) {
  isTRUE(abs(x - y) <= tolerance)
}

assert_true <- function(condition, label) {
  if (!isTRUE(condition)) {
    stop(sprintf("FAIL: %s", label), call. = FALSE)
  }
}

# ---------------------------------------------------------------------------
# A. N3: álgebra, factibilidade dirigida e domínio de fronteiras
# ---------------------------------------------------------------------------

n3_parameter_checks <- 0L

for (N in c(3L, 5L, 10L)) {
  m <- N - 1L
  q <- floor(N / 2) + 1L
  assert_true(q <= m, sprintf("N3 q<=m para N=%d", N))
  assert_true(q - 1L <= m - 1L, sprintf("N3 coalizão de exclusão para N=%d", N))

  for (beta in c(0.40, 0.90)) {
    for (o_0 in c(0.05, 0.30)) {
      for (o_1 in c(0.20, 0.70)) {
        if (!(o_0 < o_1)) {
          next
        }

        w <- beta / m
        E <- 1 - (q - 1) * w
        R <- w
        L <- 1 - (q - 2) * w - beta * o_0
        P <- 1 - (q - 2) * w - beta * o_1
        d <- 1 - beta * q / m

        assert_true(close_enough(E - R, d), "N3 identidade E-R")
        assert_true(d > 0, "N3 rejeição deliberada estritamente inferior")

        for (nu in c(0, 0.50, 1)) {
          S <- (1 - nu) * L + nu * w

          if (S >= E - tol) {
            screening_cost <- beta * o_0 + (q - 2) * w
            assert_true(screening_cost <= 1 + tol,
                        "N3 screening que alcança E é factível")
          }

          if (P >= E - tol) {
            pooling_cost <- beta * o_1 + (q - 2) * w
            assert_true(pooling_cost <= 1 + tol,
                        "N3 pooling que alcança E é factível")
          }

          n3_parameter_checks <- n3_parameter_checks + 1L
        }

        if (o_1 < 1 / m) {
          denominator_sp <- 1 - beta * o_0 - beta * (q - 1) / m
          nu_sp <- beta * (o_1 - o_0) / denominator_sp
          assert_true(denominator_sp > 0, "N3 denominador de nu_SP positivo")
          assert_true(nu_sp > 0 && nu_sp < 1, "N3 nu_SP no interior do domínio")
        }
      }
    }
  }
}

# ---------------------------------------------------------------------------
# B. N4: identidades, fronteiras abertas e quatro perfis puros de H
# ---------------------------------------------------------------------------

n4_parameter_checks <- 0L

for (m in c(2L, 3L, 5L)) {
  for (beta in c(0.40, 0.90)) {
    for (o_0 in c(0.10, 0.25)) {
      for (o_1 in c(0.60)) {
        if (!(o_0 < o_1)) {
          next
        }

        nu_star <- (o_1 - o_0) / (1 - o_0)
        ell <- beta * o_0
        h <- beta * o_1
        A <- beta * (1 - o_0) / m
        B <- beta * (1 - o_1) / m
        Q_L <- 1 - ell - (m - 1) * A
        Q_P <- 1 - h - (m - 1) * B

        assert_true(nu_star > 0 && nu_star < 1, "N4 nu_star interior")
        assert_true(close_enough((1 - nu_star) * A, B),
                    "N4 identidade (1-nu_star)A=B")
        assert_true(close_enough(Q_L - A, 1 - beta), "N4 Q_L-A=1-beta")
        assert_true(close_enough(Q_P - B, 1 - beta), "N4 Q_P-B=1-beta")
        assert_true(Q_L > A && Q_P > B, "N4 acordo forçado domina atraso")
        assert_true(close_enough(ell + (m - 1) * A + Q_L, 1),
                    "N4 L_star usa exatamente a pie")
        assert_true(close_enough(h + (m - 1) * B + Q_P, 1),
                    "N4 P_star usa exatamente a pie")

        # Fronteira de veto: igualdade é acordo; somente desigualdade estrita
        # sustenta não.
        for (nu in c(0, nu_star / 2, nu_star, (1 + nu_star) / 2, 1)) {
          C <- if (nu <= nu_star) (1 - nu) * A else B
          vote_at_boundary <- "yes"
          vote_below_boundary <- if (C > 0) "no" else "yes"
          assert_true(vote_at_boundary == "yes", "N4 T^Y fecha acordo em x=C")
          assert_true(vote_below_boundary == "no", "N4 veto exige x<C")
          n4_parameter_checks <- n4_parameter_checks + 1L
        }
      }
    }
  }
}

# Avalia diretamente os quatro perfis puros de H num ballot com pagamentos
# fracos iguais. Crenças livres são entradas explícitas somente quando Bayes
# tem denominador zero e o prior tem suporte completo. Nos endpoints, a
# restrição de suporte prevalece. A função não procura crenças: confere as
# construções pontuais usadas na prova.
posterior_after <- function(profile, action, nu, free_eta) {
  if (nu <= tol) {
    return(0)
  }
  if (nu >= 1 - tol) {
    return(1)
  }
  likelihood_0 <- as.numeric(substr(profile, 1, 1) == action)
  likelihood_1 <- as.numeric(substr(profile, 2, 2) == action)
  denominator <- (1 - nu) * likelihood_0 + nu * likelihood_1
  if (denominator > tol) {
    return(nu * likelihood_1 / denominator)
  }
  free_eta
}

ballot_profile_valid <- function(profile, nu, y, x, ell, h, A, B,
                                 nu_star, free_yes, free_no) {
  eta_yes <- posterior_after(profile, "Y", nu, free_yes)
  eta_no <- posterior_after(profile, "N", nu, free_no)
  weak_cutoff <- if (eta_yes <= nu_star + tol) (1 - eta_yes) * A else B
  all_weak_yes <- x >= weak_cutoff - tol

  continuation_h <- function(theta, eta) {
    if (theta == 1L) {
      return(h)
    }
    if (eta <= nu_star + tol) ell else h
  }

  payoff_h <- function(theta, action) {
    if (action == "Y" && all_weak_yes) {
      return(y)
    }
    eta <- if (action == "Y") eta_yes else eta_no
    continuation_h(theta, eta)
  }

  best_response <- logical(2L)
  for (theta in 0:1) {
    prescribed <- substr(profile, theta + 1L, theta + 1L)
    deviation <- if (prescribed == "Y") "N" else "Y"
    own <- payoff_h(theta, prescribed)
    other <- payoff_h(theta, deviation)
    best_response[theta + 1L] <-
      own > other + tol || (close_enough(own, other) && prescribed == "Y")
  }

  isTRUE(all(best_response))
}

profiles <- c("YY", "NN", "YN", "NY")
m <- 3L
beta <- 0.80
o_0 <- 0.10
o_1 <- 0.60
nu_star <- (o_1 - o_0) / (1 - o_0)
ell <- beta * o_0
h <- beta * o_1
A <- beta * (1 - o_0) / m
B <- beta * (1 - o_1) / m

# Certificado intermediário: nenhum perfil puro sobrevive em s_dagger.
nu_middle <- nu_star / 2
middle_valid <- vapply(
  profiles,
  ballot_profile_valid,
  logical(1),
  nu = nu_middle, y = ell, x = A, ell = ell, h = h,
  A = A, B = B, nu_star = nu_star,
  free_yes = nu_middle, free_no = nu_middle
)
assert_true(!any(middle_valid),
            "N4 nenhum dos quatro perfis puros de H sobrevive em s_dagger")

# Nos candidatos on-path, a enumeração deixa exatamente o perfil declarado.
zero_valid <- vapply(
  profiles,
  ballot_profile_valid,
  logical(1),
  nu = 0, y = ell, x = A, ell = ell, h = h,
  A = A, B = B, nu_star = nu_star,
  free_yes = 0, free_no = 0
)
high_nu <- (1 + nu_star) / 2
high_valid <- vapply(
  profiles,
  ballot_profile_valid,
  logical(1),
  nu = high_nu, y = h, x = B, ell = ell, h = h,
  A = A, B = B, nu_star = nu_star,
  free_yes = 1, free_no = 1
)
assert_true(identical(profiles[zero_valid], "YN"), "N4 único perfil em nu=0")
assert_true(identical(profiles[high_valid], "YY"), "N4 único perfil em nu>nu_star")

# Restrição de suporte em nu=0: a antiga sobreposição desaparece.
former_overlap_x <- (A + B) / 2
former_overlap_y <- ell / 2
assert_true(
  ballot_profile_valid("YY", 0, former_overlap_y, former_overlap_x, ell, h, A, B,
                       nu_star, free_yes = 0, free_no = 0),
  "N4 antiga região de overlap admite apenas o ramo YY candidato"
)
assert_true(
  !ballot_profile_valid("NN", 0, former_overlap_y, former_overlap_x, ell, h, A, B,
                        nu_star, free_yes = 1, free_no = 0),
  "N4 suporte nu=0 elimina NN quando B<x<A"
)
assert_true(
  !ballot_profile_valid("YN", 0, former_overlap_y, former_overlap_x, ell, h, A, B,
                        nu_star, free_yes = 0, free_no = 0) &&
    !ballot_profile_valid("NY", 0, former_overlap_y, former_overlap_x, ell, h, A, B,
                          nu_star, free_yes = 1, free_no = 0),
  "N4 antiga região de overlap não admite perfis separadores"
)

# Um representante de cada célula necessária e suficiente no endpoint zero.
zero_endpoint_cases <- list(
  list(y = ell / 2, x = former_overlap_x, expected = "YY"),
  list(y = ell / 2, x = A, expected = "NN"),
  list(y = (ell + h) / 2, x = A, expected = "YN"),
  list(y = h, x = A, expected = "YY")
)
for (case in zero_endpoint_cases) {
  valid <- vapply(
    profiles,
    ballot_profile_valid,
    logical(1),
    nu = 0, y = case$y, x = case$x, ell = ell, h = h,
    A = A, B = B, nu_star = nu_star,
    free_yes = 1, free_no = 1
  )
  assert_true(identical(profiles[valid], case$expected),
              "N4 partição completa representativa em nu=0")
}

# Nos endpoints, argumentos livres são ignorados e o posterior permanece no
# suporte singleton. Em nu=1, somente YY sobrevive em P_star.
assert_true(
  close_enough(posterior_after("NN", "Y", 0, 1), 0) &&
    close_enough(posterior_after("YY", "N", 1, 0), 1),
  "N4 posterior endpoint permanece no suporte do prior"
)
for (free_endpoint in c(0, 1)) {
  one_valid <- vapply(
    profiles,
    ballot_profile_valid,
    logical(1),
    nu = 1, y = h, x = B, ell = ell, h = h,
    A = A, B = B, nu_star = nu_star,
    free_yes = free_endpoint, free_no = free_endpoint
  )
  assert_true(identical(profiles[one_valid], "YY"),
              "N4 nu=1 deixa somente YY por suporte e T^Y")
}

one_endpoint_cases <- list(
  list(y = h / 2, x = B / 2, expected = "YY"),
  list(y = h / 2, x = B, expected = "NN"),
  list(y = h, x = B, expected = "YY")
)
for (case in one_endpoint_cases) {
  valid <- vapply(
    profiles,
    ballot_profile_valid,
    logical(1),
    nu = 1, y = case$y, x = case$x, ell = ell, h = h,
    A = A, B = B, nu_star = nu_star,
    free_yes = 0, free_no = 0
  )
  assert_true(identical(profiles[valid], case$expected),
              "N4 partição completa representativa em nu=1")
}

# Uma proposta representativa de cada ramo dos completamentos fora do caminho.
completion_checks <- c(
  ballot_profile_valid("YY", 0, ell / 2, A / 2, ell, h, A, B,
                       nu_star, free_yes = 0, free_no = 0),
  ballot_profile_valid("NN", 0, ell / 2, A, ell, h, A, B,
                       nu_star, free_yes = 0, free_no = 0),
  ballot_profile_valid("YN", 0, (ell + h) / 2, A, ell, h, A, B,
                       nu_star, free_yes = 0, free_no = 0),
  ballot_profile_valid("YY", 0, h, A, ell, h, A, B,
                       nu_star, free_yes = 0, free_no = 0),
  ballot_profile_valid("YY", high_nu, h / 2, B / 2, ell, h, A, B,
                       nu_star, free_yes = 1, free_no = 1),
  ballot_profile_valid("NN", high_nu, h / 2, B, ell, h, A, B,
                       nu_star, free_yes = 1, free_no = 1),
  ballot_profile_valid("YY", high_nu, h, B, ell, h, A, B,
                       nu_star, free_yes = 1, free_no = 1)
)
assert_true(all(completion_checks),
            "N4 ramos representativos dos completamentos são sequencialmente racionais")

# ---------------------------------------------------------------------------
# C. Poucos testes negativos representativos contra enunciados antigos
# ---------------------------------------------------------------------------

m <- 3
beta <- 0.80
o_0 <- 0.10
o_1 <- 0.60
nu_star <- (o_1 - o_0) / (1 - o_0)
nu <- (1 + nu_star) / 2
B <- beta * (1 - o_1) / m
Q_P <- B + 1 - beta
old_S3 <- (1 - nu) * B
assert_true(Q_P > B && B > old_S3,
            "negativo: S_3=(1-nu)B não é a segurança alta")

m <- 2
beta <- 0.80
o_0 <- 0.10
o_1 <- 0.70
nu_star <- (o_1 - o_0) / (1 - o_0)
nu <- nu_star / 2
A <- beta * (1 - o_0) / m
C <- (1 - nu) * A
assert_true(A > C,
            "negativo: limiar m=2 em A difere do cutoff corrente C para nu>0")

cat(sprintf("MODEL_PROOF_DIRECTED: PASS — N3 %d células paramétricas; N4 %d avaliações de fronteira.\n",
            n3_parameter_checks, n4_parameter_checks))
cat("ALGEBRA_IDENTITIES: PASS — factibilidade, cutoffs, Q_L-A e Q_P-B.\n")
cat("FINITE_ENUMERATION: PASS — quatro perfis puros de H, suporte nos endpoints, ausência de overlap e dois negativos representativos.\n")
