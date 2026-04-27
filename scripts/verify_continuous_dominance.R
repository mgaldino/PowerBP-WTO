# Verify the analytical results for continuous types (Uniform[1,r])
# against numerical integration

library(stats)

# --- Analytical formulas ---

# R2 continuation values under unanimity (Uniform, theta2* = r)
VH_R2_U <- function(theta, N, alpha, r) {
  (theta + (N-1)*alpha*r) / N
}

VW_R2_U <- function(theta, N, alpha, r) {
  (theta - alpha*r) / N
}

# R2 continuation values under majority
VH_R2_M <- function(theta, N, alpha) {
  theta * (1 + (N-1)*alpha) / N
}

VW_R2_M <- function(theta, N, alpha) {
  (1-alpha)*theta / N
}

# R1 screening cutoff under unanimity (Uniform)
theta1_star <- function(N, beta, r) {
  threshold_beta <- N*r / ((N+1)*r - 1)
  if (beta <= threshold_beta) {
    return(r)
  } else {
    s <- beta / ((N+1)*beta - N)
    return(min(s, r))
  }
}

# H's expected payoff from W's R1 proposal under unanimity
# (analytical formula)
EH_W_prop_U_analytical <- function(N, alpha, beta, r, s) {
  x <- (N-1)*alpha*r
  beta/N * ((s-1)^2 / (2*(r-1)) + (1+r)/2 + x)
}

# H's combined R1 payoff under unanimity (analytical)
EVH_R1_U_analytical <- function(N, alpha, beta, r) {
  s <- theta1_star(N, beta, r)
  BU <- (N-1)*beta*(1+r-2*alpha*r) / (2*N)
  H_prop <- (1+r)/2 - BU
  W_prop <- EH_W_prop_U_analytical(N, alpha, beta, r, s)
  (1/N)*H_prop + ((N-1)/N)*W_prop
}

# H's combined R1 payoff under majority (analytical)
EVH_R1_M_analytical <- function(N, alpha, beta, r) {
  q <- floor(N/2) + 1
  Etheta <- (1+r)/2
  lambda_M <- (N + N*(N-1)*alpha - beta*(q-1)*(1-alpha)) / N^2
  lambda_M * Etheta
}

# D = EVH_R1_U - EVH_R1_M (analytical)
D_analytical <- function(N, alpha, beta, r) {
  EVH_R1_U_analytical(N, alpha, beta, r) - EVH_R1_M_analytical(N, alpha, beta, r)
}

# alpha* continuous (analytical)
alpha_star_cont <- function(N, beta, r) {
  q <- floor(N/2) + 1
  s <- theta1_star(N, beta, r)
  screening_term <- (N-1)*beta*(s-1)^2 / (r-1)
  num <- screening_term + (1+r)*beta*(q-1)
  den <- (1+r)*beta*(q-1) + N*(N-1)*(1+r-2*beta*r)
  if (abs(den) < 1e-12) return(Inf)
  num / den
}

# alpha* discrete (K=2)
alpha_star_K2 <- function(N, beta) {
  q <- floor(N/2) + 1
  beta*(q-1) / (N*(N-1)*(1-beta) + beta*(q-1))
}


# --- Numerical verification via Monte Carlo integration ---

EVH_R1_U_numerical <- function(N, alpha, beta, r, n_mc = 1000000) {
  set.seed(42)
  thetas <- runif(n_mc, 1, r)
  s <- theta1_star(N, beta, r)
  x <- (N-1)*alpha*r

  # When H proposes in R1:
  # H offers beta * E[VW_R2] to each of N-1 W's
  E_VW_R2 <- mean(VW_R2_U(thetas, N, alpha, r))  # = (E[theta] - alpha*r)/N
  H_prop_payoff <- thetas - (N-1)*beta*E_VW_R2  # theta-specific

  # When W proposes in R1:
  # Types theta <= s accept: H gets beta*VH_R2(s, U) = beta*(s + x)/N
  # Types theta > s reject: H gets beta*VH_R2(theta, U) = beta*(theta + x)/N
  W_prop_payoff <- ifelse(thetas <= s,
                          beta*(s + x)/N,
                          beta*(thetas + x)/N)

  EVH <- mean((1/N)*H_prop_payoff + ((N-1)/N)*W_prop_payoff)
  return(EVH)
}

EVH_R1_M_numerical <- function(N, alpha, beta, r, n_mc = 1000000) {
  set.seed(42)
  thetas <- runif(n_mc, 1, r)
  q <- floor(N/2) + 1

  # When H proposes in R1:
  E_VW_R2_M <- mean(VW_R2_M(thetas, N, alpha))  # = (1-alpha)*E[theta]/N
  H_prop_payoff <- thetas - (q-1)*beta*E_VW_R2_M

  # When W proposes in R1: H gets alpha*theta immediately
  W_prop_payoff <- alpha*thetas

  EVH <- mean((1/N)*H_prop_payoff + ((N-1)/N)*W_prop_payoff)
  return(EVH)
}


# --- Tests ---

cat("=" , rep("=", 60), "\n", sep="")
cat("VERIFICATION OF CONTINUOUS-TYPE DOMINANCE RESULTS\n")
cat("=", rep("=", 60), "\n\n", sep="")

test_cases <- list(
  list(N=5, alpha=0.3, beta=0.9, r=1.5),
  list(N=5, alpha=0.3, beta=0.9, r=2.0),
  list(N=5, alpha=0.1, beta=0.5, r=1.5),
  list(N=3, alpha=0.2, beta=0.9, r=2.0),
  list(N=3, alpha=0.2, beta=0.9, r=5.0),
  list(N=164, alpha=0.003, beta=0.5, r=1.5),
  list(N=10, alpha=0.05, beta=0.8, r=2.0)
)

for (tc in test_cases) {
  N <- tc$N; alpha <- tc$alpha; beta <- tc$beta; r <- tc$r
  q <- floor(N/2) + 1
  s <- theta1_star(N, beta, r)

  cat(sprintf("--- N=%d, alpha=%.3f, beta=%.2f, r=%.1f ---\n", N, alpha, beta, r))
  cat(sprintf("  q = %d, theta1* = %.4f\n", q, s))

  # Analytical
  EVH_U_a <- EVH_R1_U_analytical(N, alpha, beta, r)
  EVH_M_a <- EVH_R1_M_analytical(N, alpha, beta, r)
  D_a <- D_analytical(N, alpha, beta, r)

  # Numerical
  EVH_U_n <- EVH_R1_U_numerical(N, alpha, beta, r)
  EVH_M_n <- EVH_R1_M_numerical(N, alpha, beta, r)
  D_n <- EVH_U_n - EVH_M_n

  cat(sprintf("  EVH_U: analytical=%.6f, numerical=%.6f, diff=%.2e\n",
              EVH_U_a, EVH_U_n, abs(EVH_U_a - EVH_U_n)))
  cat(sprintf("  EVH_M: analytical=%.6f, numerical=%.6f, diff=%.2e\n",
              EVH_M_a, EVH_M_n, abs(EVH_M_a - EVH_M_n)))
  cat(sprintf("  D:     analytical=%.6f, numerical=%.6f, diff=%.2e\n",
              D_a, D_n, abs(D_a - D_n)))
  cat(sprintf("  D > 0? %s\n", ifelse(D_a > 0, "YES", "NO")))

  # Thresholds
  a_star_K2 <- alpha_star_K2(N, beta)
  a_star_cont <- alpha_star_cont(N, beta, r)
  cat(sprintf("  alpha*_K2 = %.6f, alpha*_cont = %.6f\n", a_star_K2, a_star_cont))
  cat(sprintf("  alpha*_cont > alpha*_K2? %s (ratio=%.3f)\n",
              ifelse(a_star_cont > a_star_K2, "YES", "N/A"),
              a_star_cont / a_star_K2))
  cat("\n")
}

# Additional test: verify that D changes sign at alpha*_cont
cat("\n--- Verification: D changes sign at alpha*_cont ---\n\n")
N <- 164; beta <- 0.5; r <- 1.5
a_star <- alpha_star_cont(N, beta, r)
cat(sprintf("N=%d, beta=%.2f, r=%.1f, alpha*_cont=%.6f, 1/r=%.6f\n", N, beta, r, a_star, 1/r))

if (a_star > 0 && a_star < 1/r) {
  D_below <- D_analytical(N, a_star * 0.99, beta, r)
  D_at <- D_analytical(N, a_star, beta, r)
  D_above <- D_analytical(N, min(a_star * 1.01, 1/r - 0.001), beta, r)
  cat(sprintf("  D(0.99*alpha*) = %.2e\n", D_below))
  cat(sprintf("  D(alpha*)      = %.2e\n", D_at))
  cat(sprintf("  D(1.01*alpha*) = %.2e\n", D_above))
} else {
  cat(sprintf("  alpha*_cont = %.4f: D > 0 for all alpha in (0, 1/r)\n", a_star))
  D_max_alpha <- D_analytical(N, 1/r - 0.001, beta, r)
  cat(sprintf("  D(1/r - 0.001) = %.2e\n", D_max_alpha))
}

# Test for unconditional dominance case
cat("\n--- Unconditional dominance test (beta > (1+r)/(2r)) ---\n\n")
N <- 5; beta <- 0.9; r <- 1.5
cat(sprintf("N=%d, beta=%.2f, r=%.1f\n", N, beta, r))
cat(sprintf("(1+r)/(2r) = %.4f, beta > threshold? %s\n", (1+r)/(2*r), ifelse(beta > (1+r)/(2*r), "YES", "NO")))
# Check D at several alpha values
for (a in c(0.01, 0.1, 0.3, 0.5, 1/r - 0.01)) {
  if (a < 1/r) {
    cat(sprintf("  alpha=%.3f: D=%.6f (>0? %s)\n", a, D_analytical(N, a, beta, r), ifelse(D_analytical(N, a, beta, r) > 0, "YES", "NO")))
  }
}
