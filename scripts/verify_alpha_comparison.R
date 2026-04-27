# Comprehensive comparison: alpha*_cont vs alpha*_K2
# Sweep over (N, beta, r) to check alpha*_cont >= alpha*_K2 always

theta1_star <- function(N, beta, r) {
  threshold_beta <- N*r / ((N+1)*r - 1)
  if (beta <= threshold_beta) {
    return(r)
  } else {
    s <- beta / ((N+1)*beta - N)
    return(min(s, r))
  }
}

alpha_star_cont <- function(N, beta, r) {
  q <- floor(N/2) + 1
  s <- theta1_star(N, beta, r)
  screening <- (N-1)*beta*(s-1)^2 / (r-1)
  num <- screening + (1+r)*beta*(q-1)
  den <- (1+r)*beta*(q-1) + N*(N-1)*(1+r-2*beta*r)
  if (abs(den) < 1e-15) return(Inf)
  num / den
}

alpha_star_K2 <- function(N, beta) {
  q <- floor(N/2) + 1
  beta*(q-1) / (N*(N-1)*(1-beta) + beta*(q-1))
}

# Grid search
Ns <- c(3, 5, 7, 10, 20, 50, 100, 164)
betas <- seq(0.1, 0.99, by=0.05)
rs <- c(1.01, 1.1, 1.5, 2, 3, 5, 10)

violations <- 0
total <- 0

for (N in Ns) {
  for (beta in betas) {
    for (r in rs) {
      total <- total + 1
      a_K2 <- alpha_star_K2(N, beta)
      a_cont <- alpha_star_cont(N, beta, r)

      # Check: is a_cont >= a_K2?
      # If a_cont is negative or infinite, unanimity dominates unconditionally,
      # which is even stronger than K=2. Not a violation.
      if (is.finite(a_cont) && a_cont > 0 && a_cont < a_K2 - 1e-10) {
        violations <- violations + 1
        cat(sprintf("VIOLATION: N=%d, beta=%.2f, r=%.2f: a_K2=%.6f, a_cont=%.6f\n",
                    N, beta, r, a_K2, a_cont))
      }
    }
  }
}

cat(sprintf("\nTotal cases: %d, Violations: %d\n", total, violations))

if (violations == 0) {
  cat("CONFIRMED: alpha*_cont >= alpha*_K2 for all tested parameters.\n")

  # Report how often unconditional dominance occurs
  uncond <- 0
  finite_better <- 0
  for (N in Ns) {
    for (beta in betas) {
      for (r in rs) {
        a_cont <- alpha_star_cont(N, beta, r)
        if (!is.finite(a_cont) || a_cont <= 0 || a_cont >= 1/r) {
          uncond <- uncond + 1
        } else {
          finite_better <- finite_better + 1
        }
      }
    }
  }
  cat(sprintf("Unconditional dominance (D>0 for all alpha): %d/%d = %.1f%%\n",
              uncond, total, 100*uncond/total))
  cat(sprintf("Interior threshold (alpha*_cont in (0, 1/r)): %d/%d = %.1f%%\n",
              finite_better, total, 100*finite_better/total))
}

# Report min ratio alpha*_cont/alpha*_K2 for interior cases
cat("\nMinimum ratio alpha*_cont / alpha*_K2 (interior cases):\n")
min_ratio <- Inf
min_params <- NULL
for (N in Ns) {
  for (beta in betas) {
    for (r in rs) {
      a_K2 <- alpha_star_K2(N, beta)
      a_cont <- alpha_star_cont(N, beta, r)
      if (is.finite(a_cont) && a_cont > 0 && a_cont < 1/r && a_K2 > 0) {
        ratio <- a_cont / a_K2
        if (ratio < min_ratio) {
          min_ratio <- ratio
          min_params <- c(N=N, beta=beta, r=r, a_K2=a_K2, a_cont=a_cont)
        }
      }
    }
  }
}
cat(sprintf("Min ratio: %.4f at N=%d, beta=%.2f, r=%.2f (a_K2=%.6f, a_cont=%.6f)\n",
            min_ratio, min_params["N"], min_params["beta"], min_params["r"],
            min_params["a_K2"], min_params["a_cont"]))
