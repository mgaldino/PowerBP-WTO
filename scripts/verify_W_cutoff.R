# Verify W's optimal R1 cutoff under unanimity for Uniform[1,r]
# Compare analytical theta1* with numerical optimization

theta1_star_analytical <- function(N, beta, r) {
  threshold_beta <- N*r / ((N+1)*r - 1)
  if (beta <= threshold_beta) {
    return(r)
  } else {
    s <- beta / ((N+1)*beta - N)
    return(min(s, r))
  }
}

# W_k's total expected payoff from cutoff s
# (including R2 continuation for rejected types)
Pi_Wk <- function(s, N, alpha, beta, r) {
  x <- (N-1)*alpha*r

  # Offer to H
  yH <- beta*(s + x) / N

  # Offer to each non-proposing W
  yW <- beta*(s + 1 - 2*alpha*r) / (2*N)

  # W's R2 continuation if rejection (posterior Uniform[s, r])
  VW_R2_reject <- ((s+r)/2 - alpha*r) / N

  # Integral of surplus from accepted types
  cost_per_type <- yH + (N-2)*yW
  integral_surplus <- ((s^2-1)/2 - (s-1)*cost_per_type) / (r-1)

  # R2 continuation from rejected types
  r2_cont <- (r-s)/(r-1) * beta * VW_R2_reject

  integral_surplus + r2_cont
}

cat("=" , rep("=", 60), "\n", sep="")
cat("VERIFICATION OF W's OPTIMAL R1 CUTOFF\n")
cat("=", rep("=", 60), "\n\n", sep="")

test_cases <- list(
  list(N=5, alpha=0.3, beta=0.9, r=1.5),
  list(N=5, alpha=0.1, beta=0.9, r=2.0),
  list(N=3, alpha=0.2, beta=0.9, r=2.0),
  list(N=3, alpha=0.2, beta=0.9, r=5.0),
  list(N=10, alpha=0.05, beta=0.95, r=3.0),
  list(N=5, alpha=0.1, beta=0.5, r=1.5),
  list(N=5, alpha=0.4, beta=0.9, r=1.5),
  list(N=3, alpha=0.1, beta=0.95, r=1.3)
)

for (tc in test_cases) {
  N <- tc$N; alpha <- tc$alpha; beta <- tc$beta; r <- tc$r

  s_analytical <- theta1_star_analytical(N, beta, r)

  # Numerical optimization
  opt <- optimize(function(s) Pi_Wk(s, N, alpha, beta, r),
                  interval=c(1, r), maximum=TRUE)
  s_numerical <- opt$maximum

  cat(sprintf("N=%d, alpha=%.2f, beta=%.2f, r=%.1f: ", N, alpha, beta, r))
  cat(sprintf("analytical=%.4f, numerical=%.4f, diff=%.2e",
              s_analytical, s_numerical, abs(s_analytical - s_numerical)))

  # Also check that the analytical theta1* does NOT depend on alpha
  # by trying different alpha values
  s_low <- theta1_star_analytical(N, beta, r)  # doesn't use alpha
  opt_low <- optimize(function(s) Pi_Wk(s, N, 0.01, beta, r),
                      interval=c(1, r), maximum=TRUE)
  opt_high <- optimize(function(s) Pi_Wk(s, N, 1/r - 0.01, beta, r),
                       interval=c(1, r), maximum=TRUE)

  if (abs(opt_low$maximum - opt_high$maximum) < 0.01) {
    cat(" [alpha-indep CONFIRMED]")
  } else {
    cat(sprintf(" [WARNING: alpha-dep! low=%.4f high=%.4f]",
                opt_low$maximum, opt_high$maximum))
  }
  cat("\n")
}

# Extra: plot W's objective for a case with interior cutoff
cat("\n--- Detailed plot data for N=3, beta=0.9, r=5.0, alpha=0.1 ---\n")
N <- 3; alpha <- 0.1; beta <- 0.9; r <- 5.0
ss <- seq(1.01, r-0.01, length.out=100)
pis <- sapply(ss, function(s) Pi_Wk(s, N, alpha, beta, r))
idx_max <- which.max(pis)
cat(sprintf("Max at s=%.4f, Pi=%.6f\n", ss[idx_max], pis[idx_max]))
cat(sprintf("Analytical: s*=%.4f\n", theta1_star_analytical(N, beta, r)))
