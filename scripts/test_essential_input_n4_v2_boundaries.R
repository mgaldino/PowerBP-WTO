#!/usr/bin/env Rscript

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

assert_close <- function(actual, expected, message, tolerance = 1e-12) {
  if (!isTRUE(abs(actual - expected) <= tolerance)) {
    stop(
      paste0(message, ": actual=", format(actual, digits = 17L),
             ", expected=", format(expected, digits = 17L)),
      call. = FALSE
    )
  }
}

quantities <- function(m, beta, o0, o1, nu) {
  ell <- beta * o0
  h <- beta * o1
  a <- beta * (1 - o0) / m
  b <- beta * (1 - o1) / m
  nu_star <- (o1 - o0) / (1 - o0)
  D <- (1 - nu) * a
  C <- max(D, b)
  P <- 1 - h - (m - 1) * b
  output <- list(
    m = m, beta = beta, o0 = o0, o1 = o1, nu = nu,
    ell = ell, h = h, a = a, b = b, nu_star = nu_star,
    D = D, C = C, P = P
  )
  if (m == 2) {
    output$F <- 1 - h - a
    output$R_L <- 1 - ell - a
    output$K <- min(b, (1 - nu) * output$R_L)
    output$M <- min(P, D)
    output$S <- max(output$F, output$K, output$M)
  } else {
    output$S <- min(P, D)
  }
  output$U_P <- h + P - output$S
  output
}

pool_Y_projection <- function(q, y_bar) {
  if (abs(q$S - q$P) <= 1e-12) {
    return(list(lower = q$h, upper = q$h, upper_attained = TRUE, unique = TRUE))
  }
  assert_true(q$S < q$P, "Security cannot exceed P in the admissible test domain.")
  if (y_bar < q$U_P) {
    return(list(lower = q$h, upper = y_bar, upper_attained = TRUE, unique = FALSE))
  }
  list(lower = q$h, upper = q$U_P, upper_attained = FALSE, unique = FALSE)
}

# Primitive identities and the exactly-once N2 frontier.
for (m in c(2L, 3L, 7L)) {
  for (beta in c(0.2, 0.61, 0.93)) {
    for (o0 in c(0.05, 0.31, 0.7)) {
      for (o1 in c((o0 + 1) / 2, 0.99)) {
        if (o1 <= o0 || o1 >= 1) next
        q0 <- quantities(m, beta, o0, o1, 0)
        qs <- quantities(m, beta, o0, o1, q0$nu_star)
        q1 <- quantities(m, beta, o0, o1, 1)
        assert_true(q0$ell > 0 && q0$ell < q0$h, "ell<h failed.")
        assert_true(q0$b > 0 && q0$b < q0$a, "b<a failed.")
        assert_true(q0$nu_star > 0 && q0$nu_star < 1, "nu_star interior failed.")
        assert_close(q0$P - q0$b, 1 - beta, "P-b identity failed.")
        assert_close(qs$D, qs$b, "D=b at nu_star failed.")
        assert_close(q1$D, 0, "D=0 at nu=1 failed.")
        assert_close(q0$C, q0$a, "C=a at nu=0 failed.")
        assert_close(qs$C, qs$b, "C=b at nu_star failed.")
        assert_close(q1$C, q1$b, "C=b above the frontier failed.")
        assert_true(q0$S >= -1e-12 && q0$S <= q0$P + 1e-12, "Security bounds failed.")
      }
    }
  }
}

# Each m=2 security component binds uniquely in its mandatory fixture.
fixture_F <- quantities(2, 0.5, 0.2, 0.6, 0.5)
assert_true(fixture_F$F > fixture_F$K && fixture_F$F > fixture_F$M,
            "Mandatory unique-F fixture does not bind F.")
assert_close(fixture_F$S, fixture_F$F, "F fixture security mismatch.")

fixture_K <- quantities(2, 0.95, 0.4, 0.8, 0.7)
assert_true(fixture_K$K > fixture_K$F && fixture_K$K > fixture_K$M,
            "Mandatory unique-K fixture does not bind K.")
assert_close(fixture_K$S, fixture_K$K, "K fixture security mismatch.")

fixture_M <- quantities(2, 0.9, 7 / 15, 11 / 15, 0)
assert_close(fixture_M$a, 0.24, "Mandatory M fixture a mismatch.")
assert_close(fixture_M$b, 0.12, "Mandatory M fixture b mismatch.")
assert_close(fixture_M$h, 0.66, "Mandatory M fixture h mismatch.")
assert_close(fixture_M$P, 0.22, "Mandatory M fixture P mismatch.")
assert_close(fixture_M$F, 0.10, "Mandatory M fixture F mismatch.")
assert_close(fixture_M$K, 0.12, "Mandatory M fixture K mismatch.")
assert_close(fixture_M$M, 0.22, "Mandatory M fixture M mismatch.")
assert_true(fixture_M$M > fixture_M$F && fixture_M$M > fixture_M$K,
            "Mandatory unique-M fixture does not bind M.")

# A negative F is retained algebraically but cannot create a negative guarantee.
assert_true(fixture_K$F < 0, "Negative-F fixture did not make F infeasible.")
assert_true(fixture_K$K >= 0 && fixture_K$M >= 0 && fixture_K$S >= 0,
            "K/M did not protect the security level from infeasible F.")

# Pool Y-cap and attainment cases, including equality y_bar=U_P.
pool_case <- quantities(3, 0.9, 0.2, 0.6, 0.5)
assert_true(pool_case$S < pool_case$P, "Pool-cap fixture requires S<P.")
assert_true(0.6 < pool_case$U_P && pool_case$U_P < 1,
            "Pool-cap fixture does not allow all three y_bar cases.")
below_cap <- pool_Y_projection(pool_case, (0.6 + pool_case$U_P) / 2)
at_cap <- pool_Y_projection(pool_case, pool_case$U_P)
above_cap <- pool_Y_projection(pool_case, (1 + pool_case$U_P) / 2)
assert_true(below_cap$upper_attained, "y_bar<U_P must attain y_bar.")
assert_true(!at_cap$upper_attained, "y_bar=U_P must leave U_P open.")
assert_true(!above_cap$upper_attained, "y_bar>U_P must leave U_P open.")
assert_close(at_cap$upper, pool_case$U_P, "At-cap supremum mismatch.")

unique_pool <- quantities(3, 0.9, 0.1, 0.8, 0)
assert_true(unique_pool$D >= unique_pool$P, "Unique-pool fixture requires D>=P.")
unique_projection <- pool_Y_projection(unique_pool, 0.9)
assert_true(unique_projection$unique && unique_projection$upper_attained,
            "S=P must produce the unique attained Y=h point.")

# Exact m=2 pooling and low-only binder predicates.
# The mandatory unique-M example binds M=P; B_M is specifically the forced-low
# continuation subcase M=D<P and therefore needs a separate fixture.
binder_M <- quantities(2, 0.55, 0.05, 0.9, 0)
B_M <- abs(binder_M$S - binder_M$M) <= 1e-12 &&
  abs(binder_M$M - binder_M$D) <= 1e-12 && binder_M$D < binder_M$P
assert_true(B_M, "B_M fixture failed.")

binder_K <- quantities(2, 0.75, 0.05, 0.75, 0.85)
B_K <- abs(binder_K$S - binder_K$K) <= 1e-12 &&
  abs(binder_K$K - (1 - binder_K$nu) * binder_K$R_L) <= 1e-12 &&
  binder_K$K < binder_K$b
assert_true(B_K, "B_K fixture failed.")

binder_L0 <- binder_M
B_L0 <- abs(binder_L0$M - binder_L0$a) <= 1e-12 &&
  abs(binder_L0$S - binder_L0$a) <= 1e-12 && binder_L0$a < binder_L0$P
B_L0_equivalent <- binder_L0$b < binder_L0$F && binder_L0$F <= binder_L0$a
assert_true(B_L0 && B_L0_equivalent, "B_L0 and b<F<=a equivalence fixture failed.")

# Delay existence includes equality for m=2 and is universal for m>=3.
delay_none <- fixture_F
assert_true(delay_none$C < delay_none$F, "No-delay fixture requires C<F.")
delay_equality <- quantities(2, 0.64, 0.05, 0.66, 0.10)
assert_close(delay_equality$C, delay_equality$F, "Delay equality fixture failed.", 1e-10)
assert_true(delay_equality$C >= delay_equality$F - 1e-12,
            "C=F must retain delay.")
for (nu in c(0, 0.2, 0.7, 1)) {
  q <- quantities(5, 0.73, 0.17, 0.81, nu)
  assert_true(q$C >= 0, "m>=3 universal delay continuation must be feasible.")
}

# Mixed-locus equalities and strict prior endpoints.
mix_LD <- quantities(3, 0.8, 0.2, 0.7, 0)
assert_close(mix_LD$C, mix_LD$a, "L/D components must both pay a at nu=0.")
mix_PD <- quantities(3, 0.8, 0.2, 0.7, 0.9)
assert_true(mix_PD$nu > mix_PD$nu_star, "P/D fixture must lie strictly above nu_star.")
assert_close(mix_PD$C, mix_PD$b, "P/D components must both pay b above nu_star.")
mix_frontier <- quantities(3, 0.8, 0.2, 0.7, mix_LD$nu_star)
assert_close(mix_frontier$C, mix_frontier$b, "Frontier C=b identity failed.")
assert_true(!(mix_frontier$nu > mix_frontier$nu_star),
            "P/D mixing must not include nu=nu_star.")

# Pure nu=0 reporting combinations and category-empty typing.
triples_m3 <- list()
for (k_L in 0:3) {
  for (k_P in 0:(3 - k_L)) {
    k_D <- 3 - k_L - k_P
    triples_m3[[length(triples_m3) + 1L]] <- c(k_L, k_P, k_D)
  }
}
assert_true(length(triples_m3) == choose(5, 2), "m=3 pure triple enumeration failed.")
for (triple in triples_m3) {
  assert_close(sum(triple / 3), 1, "rho triple does not sum to one.")
}
m2_without_D <- list(c(2, 0, 0), c(1, 1, 0), c(0, 2, 0))
assert_true(all(vapply(m2_without_D, function(z) z[[3L]] == 0, logical(1))),
            "m=2,F>a pure assignments must have k_D=0.")
typed_empty <- list(status = "not_applicable", reason = "category_empty")
assert_true(
  identical(names(typed_empty), c("status", "reason")) &&
    identical(typed_empty$status, "not_applicable") &&
    identical(typed_empty$reason, "category_empty"),
  "Typed category-empty representation failed."
)

# The nu=0 H map and the R1-event outcome map are exact affine identities.
rho <- c(L = 0.25, P = 0.5, D = 0.25)
bar_L <- 0.3
bar_P <- 0.7
ell <- 0.2
h <- 0.6
H0 <- rho[["L"]] * bar_L + rho[["P"]] * bar_P + rho[["D"]] * ell
H1 <- (rho[["L"]] + rho[["D"]]) * h + rho[["P"]] * bar_P
assert_close(H0, 0.475, "nu=0 H0 report map failed.")
assert_close(H1, 0.65, "nu=0 H1 report map failed.")
outcomes <- c(pass_with_hegemon = rho[["L"]] + rho[["P"]],
              pass_without_hegemon = 0, failure = 0, delay = rho[["D"]])
assert_close(sum(outcomes), 1, "R1-event outcome map does not partition one.")

cat("PASS: N4 v2 boundary and endpoint tests\n")
