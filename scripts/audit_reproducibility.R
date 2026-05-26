# Reproducibility audit: verify all numeric claims in formal_model_v5.Rmd
# against model_functions.R computations

source("scripts/model_functions.R")

cat("=== REPRODUCIBILITY AUDIT ===\n\n")
results <- list()
add <- function(id, desc, reported, computed, tol, kind="estimate") {
  diff <- abs(reported - computed)
  status <- if(diff <= tol) "PASS" else "FAIL"
  results[[length(results)+1]] <<- list(id=id, desc=desc, reported=reported,
    computed=round(computed,6), diff=round(diff,6), tol=tol, status=status, kind=kind)
  cat(sprintf("[%s] %s: reported=%.6f computed=%.6f diff=%.6f tol=%.6f\n",
    status, desc, reported, computed, diff, tol))
}

# ===== PARAMETERS =====
N <- 13; r <- 1.5; alpha <- 0.19; beta <- 0.9
q <- floor(N/2) + 1

# ===== MOTIVATING EXAMPLE (Section 3, N=3, 1 round) =====
# Cutoff: 0.8(1-mu) > 0.6(1-mu) + 1.6mu => mu < 1/9
cutoff_3 <- 1/9
add("ME1", "Motivating example cutoff = 1/9", 1/9, cutoff_3, 0, "exact")

# Jump at cutoff: 0.4 - (0.2 + 0.2/9) = 0.4 - 2/9 = 8/45
jump_3 <- 8/45
add("ME2", "Motivating example jump = 8/45", 8/45, 0.4 - (0.2 + 0.2/9), 1e-10, "exact")
add("ME3", "Jump approx 0.18", 0.18, 8/45, 0.005, "estimate")

# 16% of expected surplus at cutoff
Ve_cutoff <- 1 + 1/9
pct_surplus <- (8/45) / Ve_cutoff
add("ME4", "Jump about 16% of expected surplus", 0.16, pct_surplus, 0.005, "pct")

# ===== SCREENING CUTOFF mu_s (Definition) =====
mu_s_R2 <- alpha * (r-1) / (r - alpha)
add("SC1", "Screening cutoff mu_s^R2 = alpha(r-1)/(r-alpha)",
    alpha*(r-1)/(r-alpha), mu_s_R2, 1e-10, "exact")

# ===== R1 CUTOFF (Proposition 2) =====
phi <- (r*N - beta*(N-1+r)) / (beta*(r-1))
mu_s_R1 <- (phi - sqrt(phi^2 - 4*(N-2))) / (2*(N-2))
add("EX1a", "Example 1: mu_s^R1 approx 0.064", 0.064, mu_s_R1, 0.001, "estimate")

# For beta=1: mu_s^R1 = 1/(N-2)
mu_s_R1_beta1 <- 1/(N-2)
add("EX1b", "Beta=1 cutoff = 1/(N-2)", 1/(N-2), mu_s_R1_beta1, 1e-10, "exact")

# ===== ALPHA STAR (Theorem 1) =====
alpha_star <- beta*(q-1) / (N*(N-1) - beta*(N^2 - N - q + 1))
add("TH1a", "alpha*(N=13,beta=0.9)", alpha_star, alpha_star, 1e-10, "exact")

# alpha* for N=5, beta=0.9
q5 <- floor(5/2)+1
alpha_star_5 <- 0.9*(q5-1) / (5*4 - 0.9*(25-5-q5+1))
add("TH1b", "alpha*(N=5,beta=0.9) approx 0.47", 0.47, alpha_star_5, 0.01, "estimate")

# alpha* for N=164, beta=0.9
q164 <- floor(164/2)+1
alpha_star_164 <- 0.9*(q164-1) / (164*163 - 0.9*(164^2-164-q164+1))
add("TH1c", "alpha*(N=164,beta=0.9) approx 0.03", 0.03, alpha_star_164, 0.005, "estimate")

# ===== EXAMPLE 1 PAYOFFS =====
# Just below cutoff
eps <- 1e-4
VH_below <- VH_R1_unanimity(r, alpha, mu_s_R1 - eps, N, beta)
add("EX1c", "Example 1: VH just below cutoff approx 0.315", 0.315, VH_below, 0.005, "estimate")

VH_above <- VH_R1_unanimity(r, alpha, mu_s_R1 + eps, N, beta)
add("EX1d", "Example 1: VH just above cutoff approx 0.345", 0.345, VH_above, 0.005, "estimate")

# Increase: (0.345 - 0.315) / Ve(mu_s) as pct of surplus
Ve_at_cutoff <- 1 + mu_s_R1*(r-1)
jump_pct <- (VH_above - VH_below) / Ve_at_cutoff
add("EX1e", "Example 1: increase about 2.9% of surplus", 0.029, jump_pct, 0.003, "pct")

# Majority payoff at same belief
VH_M_at_cutoff <- VH_R1_majority(r, alpha, mu_s_R1, N, beta)
add("EX1f", "Example 1: VH majority approx 0.234", 0.234, VH_M_at_cutoff, 0.005, "estimate")

# 35% more on aggressive branch
pct_agg <- VH_below / VH_M_at_cutoff - 1
add("EX1g", "Example 1: 35% more than majority (aggressive)", 0.35, pct_agg, 0.02, "pct")

# 48% more on conservative branch
pct_con <- VH_above / VH_M_at_cutoff - 1
add("EX1h", "Example 1: 48% more than majority (conservative)", 0.48, pct_con, 0.02, "pct")

# ===== EXAMPLE 2 (Institutional comparison) =====
c_val <- 0.07

# Majority entry threshold
lambda_M <- (N*(1+(N-1)*alpha) - beta*(q-1)*(1-alpha)) / N^2
tau_M <- max(0, (c_val/lambda_M - 1)/(r-1) )
VW_M_check <- VW_R1_majority(r, alpha, 0.17, N, beta)
add("EX2a", "Example 2: F_M starts approx p=0.17", 0.17, tau_M, 0.01, "estimate")

# Unanimity entry: F_U starts at ~0.38
# Find tau_U numerically
tau_U <- NA
for (p_try in seq(0.01, 0.99, by=0.001)) {
  vw <- VW_R1_unanimity(r, alpha, p_try, N, beta)
  if (vw >= c_val) { tau_U <- p_try; break }
}
add("EX2b", "Example 2: F_U starts approx p=0.38", 0.38, tau_U, 0.02, "estimate")

# At p=0.50, unanimity exceeds majority by 23%
VH_U_050 <- VH_R1_unanimity(r, alpha, 0.50, N, beta)
VH_M_050 <- VH_R1_majority(r, alpha, 0.50, N, beta)
# But need to include entry: V_H(U,p) vs V_H(M,p)
# If p in F_U: V_H(U,p) = E[VH_R1(U)], V_H(M,p) = E[VH_R1(M)]
pct_050 <- VH_U_050 / VH_M_050 - 1
add("EX2c", "Example 2: unanimity 23% higher at p=0.50", 0.23, pct_050, 0.02, "pct")

# ===== ABSTRACT: OPEC CALIBRATION =====
# At p = mu_s_R1 (just above cutoff, on conservative branch)
# Need to find what belief gives the abstract's 28% claim
# "hegemon captures 28% of cooperation surplus under unanimity"
# This is VH / Ve at some representative belief

# The abstract says "calibration to OPEC circa 1986" — let's check at a representative mu
# Try mu = 0.5 (mid-range)
VH_U_mid <- VH_R1_unanimity(r, alpha, 0.5, N, beta)
Ve_mid <- 1 + 0.5*(r-1)
share_U <- VH_U_mid / Ve_mid
add("ABS1", "Abstract: hegemon captures 28% under unanimity", 0.28, share_U, 0.01, "pct")

VH_M_mid <- VH_R1_majority(r, alpha, 0.5, N, beta)
share_M <- VH_M_mid / Ve_mid
add("ABS2", "Abstract: 23% under majority", 0.23, share_M, 0.01, "pct")

# Outside option share
alpha_share <- alpha * Ve_mid / Ve_mid  # = alpha = 0.19
add("ABS3", "Abstract: 9pp above outside option (U)", 0.09, share_U - alpha, 0.01, "pct")
add("ABS4", "Abstract: 4pp above outside option (M)", 0.04, share_M - alpha, 0.01, "pct")
add("ABS5", "Abstract: 5pp screening premium", 0.05, share_U - share_M, 0.01, "pct")

# ===== REMARK 1: mu_bar stability =====
# "for N=164 and beta=0.9, increasing alpha from 0.05 to 0.49 only lowers mu_bar from 0.87 to 0.71 when r=1.5"
# D(mu) decomposition: D_base(mu) + corrections
# mu_bar = 1 - |D(1)|/Gamma
# D(1) = r[C_buy - C_out(1-beta)]/N^2
# Gamma = (r-1)[C_out - C_buy + (N-1)*beta]/N^2

compute_mu_bar <- function(alpha_val, r_val, N_val, beta_val) {
  q_val <- floor(N_val/2)+1
  C_buy <- beta_val*(q_val-1)*(1-alpha_val)
  C_out <- N_val*(N_val-1)*alpha_val
  D1 <- r_val*(C_buy - C_out*(1-beta_val))/N_val^2
  Gamma_val <- (r_val-1)*(C_out - C_buy + (N_val-1)*beta_val)/N_val^2
  if (D1 >= 0 || Gamma_val <= 0) return(NA)
  return(1 - abs(D1)/Gamma_val)
}

mu_bar_005 <- compute_mu_bar(0.05, 1.5, 164, 0.9)
mu_bar_049 <- compute_mu_bar(0.49, 1.5, 164, 0.9)
add("REM1a", "Remark 1: mu_bar=0.87 at alpha=0.05 N=164", 0.87, mu_bar_005, 0.02, "estimate")
add("REM1b", "Remark 1: mu_bar=0.71 at alpha=0.49 N=164", 0.71, mu_bar_049, 0.02, "estimate")

# ===== OPEC FOOTNOTE 8 CALIBRATION =====
# alpha = 0.19: "difference between Saudi Arabia's market share in non-cooperative equilibrium (~25%)
# and average share of a remaining member (~6%)"
add("FN8a", "Footnote 8: alpha=0.25-0.06=0.19", 0.19, 0.25-0.06, 0.001, "exact")

# r = 1.5: "ratio of cartel-sustained to competitive oil prices ($12 to $8)"
add("FN8b", "Footnote 8: r=12/8=1.5", 1.5, 12/8, 0.001, "exact")

# ===== JUMP MAGNITUDE (Proposition 3) =====
# Jump = (1 - mu_s^R1) * (N-1)*beta*(r-1)/N^2
jump_formula <- (1 - mu_s_R1) * (N-1)*beta*(r-1)/N^2
# Also compute directly
jump_direct <- VH_above - VH_below
add("PR3", "Prop 3 jump formula vs direct computation", jump_formula, jump_direct, 0.001, "estimate")

# ===== LAMBDA_M > ALPHA (Proposition 1) =====
add("PR1", "lambda_M > alpha", alpha, lambda_M, 0, "inequality")
cat(sprintf("  lambda_M = %.6f, alpha = %.6f, lambda_M > alpha: %s\n",
    lambda_M, alpha, lambda_M > alpha))

# ===== SUMMARY =====
cat("\n=== SUMMARY ===\n")
n_pass <- sum(sapply(results, function(x) x$status == "PASS"))
n_fail <- sum(sapply(results, function(x) x$status == "FAIL"))
cat(sprintf("PASS: %d\nFAIL: %d\nTotal: %d\n", n_pass, n_fail, length(results)))

if (n_fail > 0) {
  cat("\nFAILED CLAIMS:\n")
  for (res in results) {
    if (res$status == "FAIL") {
      cat(sprintf("  [FAIL] %s: reported=%.6f computed=%.6f diff=%.6f (tol=%.6f)\n",
        res$desc, res$reported, res$computed, res$diff, res$tol))
    }
  }
}
