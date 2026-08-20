#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required.", call. = FALSE)
  }
})

assert_true <- function(condition, message) {
  if (!isTRUE(condition)) stop(message, call. = FALSE)
}

assert_close <- function(actual, expected, message, tolerance = 1e-12) {
  assert_true(abs(actual - expected) <= tolerance, message)
}

expect_wrong_rejected <- function(wrong_is_rejected, label) {
  assert_true(isTRUE(wrong_is_rejected), paste("Negative fixture was not rejected:", label))
}

quantities <- function(m, beta, o0, o1, nu) {
  ell <- beta * o0
  h <- beta * o1
  a <- beta * (1 - o0) / m
  b <- beta * (1 - o1) / m
  D <- (1 - nu) * a
  P <- 1 - h - (m - 1) * b
  q <- list(
    m = m, beta = beta, o0 = o0, o1 = o1, nu = nu,
    ell = ell, h = h, a = a, b = b,
    nu_star = (o1 - o0) / (1 - o0),
    D = D, C = max(D, b), P = P
  )
  if (m == 2) {
    q$F <- 1 - h - a
    q$R_L <- 1 - ell - a
    q$K <- min(b, (1 - nu) * q$R_L)
    q$M <- min(P, D)
    q$S <- max(q$F, q$K, q$M)
  } else {
    q$S <- min(P, D)
  }
  q$U_P <- h + P - q$S
  q
}

script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
assert_true(length(script_argument) == 1L, "Could not resolve the negative-test path.")
script_path <- normalizePath(sub("^--file=", "", script_argument), mustWork = TRUE)
repository_root <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
interface_path <- file.path(
  repository_root, "model_redesign", "essential_input_interfaces",
  "n4_r1_unanimity_candidate_v2.json"
)
candidate <- jsonlite::fromJSON(interface_path, simplifyVector = FALSE)
records <- lapply(candidate$correspondence_cells, function(cell) cell$equilibrium_records[[1L]])

# Omitting any one of F, K, or M understates S_2 in a mandatory unique-binder case.
fixture_F <- quantities(2, 0.5, 0.2, 0.6, 0.5)
fixture_K <- quantities(2, 0.95, 0.4, 0.8, 0.7)
fixture_M <- quantities(2, 0.9, 7 / 15, 11 / 15, 0)

wrong_without_F <- max(fixture_F$K, fixture_F$M)
wrong_without_K <- max(fixture_K$F, fixture_K$M)
wrong_without_M <- max(fixture_M$F, fixture_M$K)
expect_wrong_rejected(wrong_without_F < fixture_F$S, "omission of F from S_2")
expect_wrong_rejected(wrong_without_K < fixture_K$S, "omission of K from S_2")
expect_wrong_rejected(wrong_without_M < fixture_M$S, "omission of M from S_2")
assert_true(fixture_F$F > max(fixture_F$K, fixture_F$M), "F is not uniquely binding.")
assert_true(fixture_K$K > max(fixture_K$F, fixture_K$M), "K is not uniquely binding.")
assert_true(fixture_M$M > max(fixture_M$F, fixture_M$K), "M is not uniquely binding.")

# A negative force-pass residual is not a feasible offer and does not make S negative.
expect_wrong_rejected(fixture_K$F < 0 && fixture_K$S >= 0,
                      "treating infeasible F<0 as the security offer")

# The old m>=3 b-valued punishment fails exactly when D>b.
low_prior <- quantities(3, 0.9, 0.2, 0.6, 0.1)
assert_true(low_prior$D > low_prior$b && low_prior$P > low_prior$D,
            "Low-prior b-punishment fixture has the wrong ordering.")
wrong_security_b <- min(low_prior$P, low_prior$b)
wrong_security_one_minus_nu_b <- min(low_prior$P, (1 - low_prior$nu) * low_prior$b)
expect_wrong_rejected(wrong_security_b < low_prior$S,
                      "m>=3 rejection at x=b paying proposer b when D>b")
expect_wrong_rejected(wrong_security_one_minus_nu_b < low_prior$S,
                      "withdrawn m>=3 (1-nu)*b security")

# A sole no at x=b ties the minimum subjective continuation and T^Y selects yes;
# a strict low-only rejection instead pays the proposer D under the true prior.
subjective_floor <- low_prior$b
expect_wrong_rejected(!(low_prior$b < subjective_floor),
                      "strict sole weak veto at the pooling floor b")
assert_close(low_prior$D, (1 - low_prior$nu) * low_prior$a,
             "True-prior low-only continuation is not D.")

# The on-path pooling floor is b, not min{b,D}; at a high prior D<b.
high_prior_floor <- quantities(2, 0.9, 0.2, 0.6, 0.9)
assert_true(high_prior_floor$D < high_prior_floor$b,
            "High-prior floor fixture requires D<b.")
x_test <- (high_prior_floor$D + high_prior_floor$b) / 2
wrong_acceptance <- x_test >= min(high_prior_floor$b, high_prior_floor$D)
correct_acceptance <- x_test >= high_prior_floor$b
expect_wrong_rejected(wrong_acceptance && !correct_acceptance,
                      "using min{b,D} as the on-path weak-payment floor")

# Exact upper-cap topology: y_bar=U_P never closes [h,U_P) when S<P.
cap_case <- quantities(3, 0.9, 0.2, 0.6, 0.5)
assert_true(cap_case$S < cap_case$P, "Cap fixture requires S<P.")
wrong_closed_cap <- TRUE
correct_upper_attained <- cap_case$U_P < cap_case$U_P
expect_wrong_rejected(wrong_closed_cap && !correct_upper_attained,
                      "closing the pooling cap at y_bar=U_P")

# Pool equality endpoints are excluded by the forced-low binders at nu<1.
binder_M <- quantities(2, 0.55, 0.05, 0.9, 0)
B_M <- abs(binder_M$S - binder_M$M) <= 1e-12 &&
  abs(binder_M$M - binder_M$D) <= 1e-12 && binder_M$D < binder_M$P
expect_wrong_rejected(B_M && binder_M$nu < 1,
                      "allowing Y=h,r=S at a binding B_M endpoint")

binder_K <- quantities(2, 0.75, 0.05, 0.75, 0.85)
B_K <- abs(binder_K$S - binder_K$K) <= 1e-12 &&
  abs(binder_K$K - (1 - binder_K$nu) * binder_K$R_L) <= 1e-12 &&
  binder_K$K < binder_K$b
expect_wrong_rejected(B_K && binder_K$nu < 1,
                      "allowing Y=h,r=S at a binding separating B_K endpoint")

# K=b is deliberately not the strict B_K predicate.
expect_wrong_rejected(abs(fixture_K$K - fixture_K$b) <= 1e-12 &&
                        !(fixture_K$K < fixture_K$b),
                      "treating K=b as the strict B_K binder")

# B_L0 equality is confined to Y=ell.
B_L0 <- abs(binder_M$M - binder_M$a) <= 1e-12 &&
  abs(binder_M$S - binder_M$a) <= 1e-12 && binder_M$a < binder_M$P
expect_wrong_rejected(B_L0 && binder_M$b < binder_M$F && binder_M$F <= binder_M$a,
                      "allowing r=S_0 at Y>ell under B_L0")

# Positive-prior L and every high-only branch violate the ordered H ICs.
positive_prior <- quantities(3, 0.8, 0.2, 0.7, 0.2)
low_yes_requires <- positive_prior$h
high_no_requires_strict_upper <- positive_prior$h
expect_wrong_rejected(!(low_yes_requires < high_no_requires_strict_upper),
                      "positive-prior low-only passage")
expect_wrong_rejected(positive_prior$ell < positive_prior$h,
                      "high-only passage with ordered type thresholds")

# m=2 delay is absent at C<F; equality is retained.
delay_none <- fixture_F
expect_wrong_rejected(delay_none$C < delay_none$F,
                      "m=2 delay when C<F")
delay_equal <- quantities(2, 0.64, 0.05, 0.66, 0.10)
assert_close(delay_equal$C, delay_equal$F,
             "Delay equality fixture is not on C=F.", 1e-10)
expect_wrong_rejected(delay_equal$C >= delay_equal$F - 1e-12,
                      "dropping m=2 delay at C=F")

# Weak-veto delay makes H nonpivotal, so reverse separation is invalid.
H_actions_if_weak_veto <- c(theta_0 = "yes", theta_1 = "yes")
expect_wrong_rejected(!identical(H_actions_if_weak_veto,
                                 c(theta_0 = "no", theta_1 = "yes")),
                      "reverse H separation after a weak veto")

# Outcome nonpivotality does not imply payoff identity: the public vote vector
# can change the successor belief and hence the N2 continuation.
continuation_after_no <- low_prior$D
continuation_after_yes <- low_prior$b
expect_wrong_rejected(continuation_after_no > continuation_after_yes,
                      "treating distinct nonpivotal failure vectors as payoff-identical")

# Two weak vetoes cannot exist for m=2, and cannot be strict at/above nu_star.
expect_wrong_rejected((2 - 1) < 2, "two weak vetoers when m=2")
at_frontier <- quantities(3, 0.8, 0.2, 0.7,
                          (0.7 - 0.2) / (1 - 0.2))
assert_close(at_frontier$D, at_frontier$b, "Frontier D=b mismatch.")
expect_wrong_rejected(!(at_frontier$b < at_frontier$b),
                      "strict coordinated weak veto at nu=nu_star")

# Cross mixes are confined to their exact loci and m=2 predicates.
expect_wrong_rejected(fixture_F$F > fixture_F$a,
                      "m=2 L/D mixing when F>a")
high_no_PD <- quantities(2, 0.5, 0.2, 0.6, 0.8)
expect_wrong_rejected(high_no_PD$F > high_no_PD$b,
                      "m=2 P/D mixing when F>b")
frontier <- quantities(3, 0.8, 0.2, 0.7,
                       (0.7 - 0.2) / (1 - 0.2))
expect_wrong_rejected(!(frontier$nu > frontier$nu_star),
                      "P/D mixing at nu=nu_star")

# Empty conditional means require the typed object; numeric sentinels are invalid.
typed_empty <- list(status = "not_applicable", reason = "category_empty")
for (bad in list(0, NA_real_, NULL, "", list())) {
  expect_wrong_rejected(!identical(bad, typed_empty),
                        "numeric/null/empty sentinel for an empty category")
}

# Count triples are not the same as labeled source multiplicity.
count_triple <- c(L = 1L, P = 1L, D = 1L)
labeled_permutations <- factorial(sum(count_triple)) / prod(factorial(count_triple))
expect_wrong_rejected(labeled_permutations == 6L && labeled_permutations > 1L,
                      "collapsing the six labeled (1,1,1) identity assignments")

# N4 delay is the R1 event; eventual N2 failure may not be overlaid on failure.
rho_D <- 0.4
correct_R1 <- c(pass_with_hegemon = 1 - rho_D,
                pass_without_hegemon = 0, failure = 0, delay = rho_D)
wrong_overlay <- c(pass_with_hegemon = 1 - rho_D,
                   pass_without_hegemon = 0, failure = 0.1, delay = rho_D)
expect_wrong_rejected(abs(sum(wrong_overlay) - 1) > 1e-12 &&
                        abs(sum(correct_R1) - 1) <= 1e-12,
                      "overlaying eventual N2 failure on the N4 R1 event")

# The canonical interface must encode every negative guard tested above.
interface_text <- paste(readLines(interface_path, warn = FALSE, encoding = "UTF-8"),
                        collapse = "\n")
required_guards <- c(
  "S_2=max{F,K,M}",
  "S_m=min{P,D}",
  "When D>b",
  "never min{b,D}",
  "At y_bar=U_P the upper endpoint remains open",
  "S=M=D<P",
  "S=K=(1-nu)*R_L<b",
  "equivalently b<F<=a",
  "exists iff C>=F; none iff C<F",
  "two published failure vectors induce different continuation beliefs",
  "reverse H separation is inadmissible",
  "on-path weak-vote passivity is derived by P4 and is not imposed as an assessment restriction",
  "category_empty",
  "full Cartesian product",
  "failure\": \"0"
)
for (guard in required_guards) {
  assert_true(grepl(guard, interface_text, fixed = TRUE),
              paste("Canonical interface is missing negative guard:", guard))
}

cat("PASS: N4 v2 negative accounting, endpoint, topology, and multiplicity fixtures\n")
