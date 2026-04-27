# Comprehensive numerical verification of continuous-type dominance results
# Tasks:
#   1. Monte Carlo simulation (1M draws) of the 2-round BF game, comparing
#      E[V_H^R1(U)] and E[V_H^R1(M)] with closed-form formulas
#   2. Verify D > 0 when alpha < alpha*_cont and D < 0 when alpha > alpha*_cont
#   3. Verify alpha*_cont >= alpha*_{K=2} across the full parameter grid
#   4. Report PASS/FAIL for each test
#
# Parameter grid: N in {3,5,10,30}, beta in {0.5,0.8,0.9,0.95,0.99},
#                 r in {1.1,1.5,2,3,5}

set.seed(2026)

# ============================================================================
# Analytical formulas (from the derivation)
# ============================================================================

theta1_star <- function(N, beta, r) {
  threshold_beta <- N * r / ((N + 1) * r - 1)
  if (beta <= threshold_beta) {
    return(r)
  } else {
    s <- beta / ((N + 1) * beta - N)
    return(min(s, r))
  }
}

# H's expected R1 payoff under unanimity (closed-form, eq. EVH_U)
EVH_R1_U_analytical <- function(N, alpha, beta, r) {
  s <- theta1_star(N, beta, r)
  x <- (N - 1) * alpha * r
  Etheta <- (1 + r) / 2
  # H proposes: theta - (N-1)*beta*E[VW_R2(U)]
  # E[VW_R2(U)] = (Etheta - alpha*r)/N
  BU <- (N - 1) * beta * (Etheta - alpha * r) / N
  H_prop <- Etheta - BU
  # W proposes: beta/N * [(s-1)^2/(2(r-1)) + (1+r)/2 + x]
  W_prop <- (beta / N) * ((s - 1)^2 / (2 * (r - 1)) + (1 + r) / 2 + x)
  (1 / N) * H_prop + ((N - 1) / N) * W_prop
}

# H's expected R1 payoff under majority (closed-form, eq. EVH_M)
EVH_R1_M_analytical <- function(N, alpha, beta, r) {
  q <- floor(N / 2) + 1
  Etheta <- (1 + r) / 2
  lambda_M <- (N + N * (N - 1) * alpha - beta * (q - 1) * (1 - alpha)) / N^2
  lambda_M * Etheta
}

D_analytical <- function(N, alpha, beta, r) {
  EVH_R1_U_analytical(N, alpha, beta, r) - EVH_R1_M_analytical(N, alpha, beta, r)
}

alpha_star_cont <- function(N, beta, r) {
  q <- floor(N / 2) + 1
  s <- theta1_star(N, beta, r)
  screening <- (N - 1) * beta * (s - 1)^2 / (r - 1)
  num <- screening + (1 + r) * beta * (q - 1)
  den <- (1 + r) * beta * (q - 1) + N * (N - 1) * (1 + r - 2 * beta * r)
  if (abs(den) < 1e-15) return(Inf)
  num / den
}

alpha_star_K2 <- function(N, beta) {
  q <- floor(N / 2) + 1
  beta * (q - 1) / (N * (N - 1) * (1 - beta) + beta * (q - 1))
}

# ============================================================================
# Monte Carlo simulation of the 2-round BF game (direct simulation)
# ============================================================================

simulate_BF_game <- function(N, alpha, beta, r, n_mc = 1000000) {
  # Draw theta ~ Uniform[1, r]
  thetas <- runif(n_mc, 1, r)
  q <- floor(N / 2) + 1
  s <- theta1_star(N, beta, r)
  x <- (N - 1) * alpha * r

  # ---- R2 payoffs (needed for R1 computations) ----

  # R2 under unanimity:
  #   H proposes (1/N): H gets theta
  #   W proposes ((N-1)/N): pooling at theta2*=r, H gets alpha*r
  VH_R2_U <- (1 / N) * thetas + ((N - 1) / N) * alpha * r
  # Check: VH_R2_U should equal (theta + x)/N
  # (1/N)*theta + ((N-1)/N)*alpha*r = (theta + (N-1)*alpha*r)/N = (theta+x)/N. Correct.

  # R2 under majority:
  #   H proposes (1/N): H gets theta (buys q-1 W's at 0 continuation)
  #   W proposes ((N-1)/N): W excludes H, H gets alpha*theta
  VH_R2_M <- (1 / N) * thetas + ((N - 1) / N) * alpha * thetas
  # = theta*(1 + (N-1)*alpha)/N. Correct.

  # ---- R1 under unanimity ----

  # E[VW_R2(U)] = E[(theta - alpha*r)/N] = (Etheta - alpha*r)/N
  E_VW_R2_U <- mean((thetas - alpha * r) / N)

  # H proposes (1/N): offers beta*E[VW_R2(U)] to each W, keeps theta - (N-1)*payment
  VH_R1_Hprop_U <- thetas - (N - 1) * beta * E_VW_R2_U

  # W proposes ((N-1)/N): screening cutoff s
  #   theta <= s: H accepts pooling offer beta*(s+x)/N
  #   theta > s:  H rejects, game goes to R2, H gets beta*VH_R2(theta,U) = beta*(theta+x)/N
  VH_R1_Wprop_U <- ifelse(thetas <= s,
                           beta * (s + x) / N,
                           beta * (thetas + x) / N)

  EVH_R1_U <- mean((1 / N) * VH_R1_Hprop_U + ((N - 1) / N) * VH_R1_Wprop_U)

  # ---- R1 under majority ----

  # E[VW_R2(M)] = E[(1-alpha)*theta/N] = (1-alpha)*Etheta/N
  E_VW_R2_M <- mean((1 - alpha) * thetas / N)

  # H proposes (1/N): buys q-1 W's at beta*E[VW_R2(M)]
  VH_R1_Hprop_M <- thetas - (q - 1) * beta * E_VW_R2_M

  # W proposes ((N-1)/N): W excludes H, passes in R1, H gets alpha*theta
  VH_R1_Wprop_M <- alpha * thetas

  EVH_R1_M <- mean((1 / N) * VH_R1_Hprop_M + ((N - 1) / N) * VH_R1_Wprop_M)

  return(list(EVH_U = EVH_R1_U, EVH_M = EVH_R1_M, D = EVH_R1_U - EVH_R1_M))
}

# ============================================================================
# TEST 1: Monte Carlo vs. closed-form formulas
# ============================================================================

cat("", rep("=", 70), "\n", sep = "")
cat("TEST 1: Monte Carlo (1M draws) vs. Closed-Form Formulas\n")
cat(rep("=", 70), "\n\n", sep = "")

# Use a representative subset for the MC test (1M draws per case is expensive)
mc_cases <- list(
  list(N = 3,  alpha = 0.15, beta = 0.9,  r = 2.0),
  list(N = 5,  alpha = 0.10, beta = 0.5,  r = 1.5),
  list(N = 5,  alpha = 0.30, beta = 0.9,  r = 1.5),
  list(N = 5,  alpha = 0.05, beta = 0.95, r = 3.0),
  list(N = 10, alpha = 0.05, beta = 0.8,  r = 2.0),
  list(N = 10, alpha = 0.02, beta = 0.99, r = 5.0),
  list(N = 30, alpha = 0.01, beta = 0.5,  r = 1.1),
  list(N = 30, alpha = 0.005, beta = 0.9, r = 3.0)
)

mc_tolerance <- 5e-4  # Relative tolerance for MC agreement
mc_all_pass <- TRUE

for (tc in mc_cases) {
  N <- tc$N; alpha <- tc$alpha; beta <- tc$beta; r <- tc$r

  # Analytical
  EVH_U_a <- EVH_R1_U_analytical(N, alpha, beta, r)
  EVH_M_a <- EVH_R1_M_analytical(N, alpha, beta, r)
  D_a <- D_analytical(N, alpha, beta, r)

  # Numerical (MC)
  mc <- simulate_BF_game(N, alpha, beta, r, n_mc = 1000000)

  rel_err_U <- abs(EVH_U_a - mc$EVH_U) / max(abs(EVH_U_a), 1e-10)
  rel_err_M <- abs(EVH_M_a - mc$EVH_M) / max(abs(EVH_M_a), 1e-10)
  rel_err_D <- abs(D_a - mc$D) / max(abs(D_a), 1e-10)

  pass_U <- rel_err_U < mc_tolerance
  pass_M <- rel_err_M < mc_tolerance
  pass_D <- rel_err_D < mc_tolerance || abs(D_a - mc$D) < 1e-5  # Absolute fallback for small D
  all_pass <- pass_U && pass_M && pass_D

  status <- if (all_pass) "PASS" else "FAIL"
  if (!all_pass) mc_all_pass <- FALSE

  cat(sprintf("  [%s] N=%2d, alpha=%.3f, beta=%.2f, r=%.1f\n", status, N, alpha, beta, r))
  cat(sprintf("         EVH_U: anal=%.6f, MC=%.6f, rel_err=%.2e %s\n",
              EVH_U_a, mc$EVH_U, rel_err_U, ifelse(pass_U, "", "<-- FAIL")))
  cat(sprintf("         EVH_M: anal=%.6f, MC=%.6f, rel_err=%.2e %s\n",
              EVH_M_a, mc$EVH_M, rel_err_M, ifelse(pass_M, "", "<-- FAIL")))
  cat(sprintf("         D:     anal=%.6f, MC=%.6f, rel_err=%.2e %s\n",
              D_a, mc$D, rel_err_D, ifelse(pass_D, "", "<-- FAIL")))
}

cat(sprintf("\nTEST 1 OVERALL: %s\n\n", ifelse(mc_all_pass, "PASS", "FAIL")))

# ============================================================================
# TEST 2: D > 0 when alpha < alpha*_cont, D < 0 when alpha > alpha*_cont
# ============================================================================

cat(rep("=", 70), "\n", sep = "")
cat("TEST 2: Sign of D Around alpha*_cont\n")
cat(rep("=", 70), "\n\n", sep = "")

Ns    <- c(3, 5, 10, 30)
betas <- c(0.5, 0.8, 0.9, 0.95, 0.99)
rs    <- c(1.1, 1.5, 2, 3, 5)

sign_violations <- 0
sign_total <- 0
sign_details <- list()

for (N in Ns) {
  for (beta in betas) {
    for (r in rs) {
      a_star <- alpha_star_cont(N, beta, r)

      # Case 1: alpha*_cont is finite and in (0, 1/r) -- test sign change
      if (is.finite(a_star) && a_star > 0 && a_star < 1 / r) {
        sign_total <- sign_total + 1

        # Test below
        a_below <- a_star * 0.95
        D_below <- D_analytical(N, a_below, beta, r)
        # Test above
        a_above <- min(a_star * 1.05, 1 / r - 1e-6)
        D_above <- D_analytical(N, a_above, beta, r)

        pass <- (D_below > -1e-12) && (D_above < 1e-12)
        if (!pass) {
          sign_violations <- sign_violations + 1
          sign_details[[length(sign_details) + 1]] <- sprintf(
            "  VIOLATION: N=%d, beta=%.2f, r=%.1f: a*=%.6f, D(0.95a*)=%.2e, D(1.05a*)=%.2e",
            N, beta, r, a_star, D_below, D_above)
        }
      }

      # Case 2: Unconditional dominance (a_star negative, Inf, or >= 1/r)
      # D should be > 0 for all alpha in (0, 1/r)
      if (!is.finite(a_star) || a_star <= 0 || a_star >= 1 / r) {
        sign_total <- sign_total + 1
        # Test at several alpha values
        test_alphas <- c(0.001, 0.5 / r, 0.9 / r)
        all_pos <- TRUE
        for (a in test_alphas) {
          if (a > 0 && a < 1 / r) {
            D_val <- D_analytical(N, a, beta, r)
            if (D_val < -1e-12) {
              all_pos <- FALSE
              sign_violations <- sign_violations + 1
              sign_details[[length(sign_details) + 1]] <- sprintf(
                "  VIOLATION (uncond): N=%d, beta=%.2f, r=%.1f, alpha=%.4f: D=%.2e < 0",
                N, beta, r, a, D_val)
            }
          }
        }
      }
    }
  }
}

if (length(sign_details) > 0) {
  for (d in sign_details) cat(d, "\n")
}
cat(sprintf("\nTEST 2 OVERALL: %s (%d violations in %d tests)\n\n",
            ifelse(sign_violations == 0, "PASS", "FAIL"), sign_violations, sign_total))

# ============================================================================
# TEST 3: alpha*_cont >= alpha*_{K=2} across the full grid
# ============================================================================

cat(rep("=", 70), "\n", sep = "")
cat("TEST 3: alpha*_cont >= alpha*_{K=2} Across Parameter Grid\n")
cat(rep("=", 70), "\n\n", sep = "")

comparison_violations <- 0
comparison_total <- 0
comparison_details <- list()

n_uncond <- 0
n_interior <- 0

for (N in Ns) {
  for (beta in betas) {
    a_K2 <- alpha_star_K2(N, beta)
    for (r in rs) {
      comparison_total <- comparison_total + 1
      a_cont <- alpha_star_cont(N, beta, r)

      # Classify
      if (!is.finite(a_cont) || a_cont <= 0 || a_cont >= 1 / r) {
        n_uncond <- n_uncond + 1
        # Unconditional dominance: strictly better than K=2, no violation possible
      } else {
        n_interior <- n_interior + 1
        if (a_cont < a_K2 - 1e-10) {
          comparison_violations <- comparison_violations + 1
          comparison_details[[length(comparison_details) + 1]] <- sprintf(
            "  VIOLATION: N=%d, beta=%.2f, r=%.1f: a_K2=%.6f, a_cont=%.6f, diff=%.2e",
            N, beta, r, a_K2, a_cont, a_cont - a_K2)
        }
      }
    }
  }
}

cat(sprintf("  Total parameter combinations: %d\n", comparison_total))
cat(sprintf("  Unconditional dominance (D>0 for all alpha): %d (%.1f%%)\n",
            n_uncond, 100 * n_uncond / comparison_total))
cat(sprintf("  Interior threshold: %d (%.1f%%)\n",
            n_interior, 100 * n_interior / comparison_total))

if (length(comparison_details) > 0) {
  cat("\n")
  for (d in comparison_details) cat(d, "\n")
}
cat(sprintf("\nTEST 3 OVERALL: %s (%d violations)\n\n",
            ifelse(comparison_violations == 0, "PASS", "FAIL"), comparison_violations))

# ============================================================================
# TEST 4: Detailed grid report
# ============================================================================

cat(rep("=", 70), "\n", sep = "")
cat("TEST 4: Detailed Grid Report (selected rows)\n")
cat(rep("=", 70), "\n\n", sep = "")

cat(sprintf("%-4s %-5s %-4s | %-10s %-12s %-8s | %-7s\n",
            "N", "beta", "r", "a*_K2", "a*_cont", "ratio", "regime"))
cat(rep("-", 70), "\n", sep = "")

for (N in Ns) {
  for (beta in betas) {
    a_K2 <- alpha_star_K2(N, beta)
    for (r in rs) {
      a_cont <- alpha_star_cont(N, beta, r)

      if (!is.finite(a_cont) || a_cont <= 0 || a_cont >= 1 / r) {
        regime <- "UNCOND"
        ratio_str <- "Inf"
      } else {
        regime <- "INTER"
        ratio_str <- sprintf("%.3f", a_cont / a_K2)
      }

      cat(sprintf("%-4d %-5.2f %-4.1f | %-10.6f %-12.6f %-8s | %-7s\n",
                  N, beta, r, a_K2, a_cont, ratio_str, regime))
    }
  }
}

# ============================================================================
# FINAL SUMMARY
# ============================================================================

cat("\n", rep("=", 70), "\n", sep = "")
cat("FINAL SUMMARY\n")
cat(rep("=", 70), "\n\n", sep = "")

test1_status <- ifelse(mc_all_pass, "PASS", "FAIL")
test2_status <- ifelse(sign_violations == 0, "PASS", "FAIL")
test3_status <- ifelse(comparison_violations == 0, "PASS", "FAIL")

cat(sprintf("  TEST 1 (MC vs. closed-form):        %s\n", test1_status))
cat(sprintf("  TEST 2 (sign of D at alpha*):        %s\n", test2_status))
cat(sprintf("  TEST 3 (alpha*_cont >= alpha*_K2):   %s\n", test3_status))

all_pass_final <- mc_all_pass && (sign_violations == 0) && (comparison_violations == 0)
cat(sprintf("\n  OVERALL: %s\n", ifelse(all_pass_final, "ALL PASS", "FAILURES DETECTED")))
