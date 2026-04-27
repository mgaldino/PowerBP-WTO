# Verification of numerical claims in Example 1 (ex:magnitudes)
# formal_model_v4.Rmd, lines 393-395
# Parameters: N=5, r=1.5, alpha=0.3, beta=0.9

source("scripts/model_functions.R")

N <- 5
r <- 1.5
alpha <- 0.3
beta <- 0.9

# --- Claim 1: R1 screening cutoff mu_s^R1 ≈ 0.197 ---
phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
disc <- phi^2 - 4 * (N - 2)
mu_s_R1 <- (phi - sqrt(disc)) / (2 * (N - 2))
cat(sprintf("Claim 1: mu_s_R1 ≈ 0.197\n  Computed: %.6f\n  Match: %s\n\n",
            mu_s_R1, ifelse(abs(mu_s_R1 - 0.197) < 0.001, "CORRECT", "INCORRECT")))

# --- Claim 2: At beliefs just below cutoff, E[V_H^R1] ≈ 0.544 ---
# Use a belief just below the cutoff
mu_below <- mu_s_R1 - 1e-8
VH_below <- VH_R1_unanimity(r, alpha, mu_below, N, beta)
cat(sprintf("Claim 2: E[V_H^R1] just below cutoff ≈ 0.544\n  Computed: %.6f\n  Match: %s\n\n",
            VH_below, ifelse(abs(VH_below - 0.544) < 0.001, "CORRECT", "INCORRECT")))

# --- Claim 3: Just above cutoff, payoff jumps to ≈ 0.602 ---
mu_above <- mu_s_R1 + 1e-8
VH_above <- VH_R1_unanimity(r, alpha, mu_above, N, beta)
cat(sprintf("Claim 3: E[V_H^R1] just above cutoff ≈ 0.602\n  Computed: %.6f\n  Match: %s\n\n",
            VH_above, ifelse(abs(VH_above - 0.602) < 0.001, "CORRECT", "INCORRECT")))

# --- Claim 4: Jump is about 5.3% of expected surplus ---
# "expected surplus" at the cutoff is Ve(mu_s_R1)
Ve_at_cutoff <- 1 + mu_s_R1 * (r - 1)
jump_abs <- VH_above - VH_below
jump_pct <- jump_abs / Ve_at_cutoff * 100
cat(sprintf("Claim 4: Jump ≈ 5.3%% of expected surplus\n  Jump (abs): %.6f\n  Ve(mu_s_R1): %.6f\n  Jump %%: %.3f%%\n  Match: %s\n\n",
            jump_abs, Ve_at_cutoff, jump_pct,
            ifelse(abs(jump_pct - 5.3) < 0.1, "CORRECT", "INCORRECT")))

# Also check against the formula: Jump = (1 - mu_s_R1) * (N-1)*beta*(r-1) / N^2
jump_formula <- (1 - mu_s_R1) * (N - 1) * beta * (r - 1) / N^2
cat(sprintf("  Jump (formula): %.6f\n  Jump %% (formula): %.3f%%\n\n",
            jump_formula, jump_formula / Ve_at_cutoff * 100))

# --- Claim 5: Under majority at same belief, E[V_H^R1] ≈ 0.428 ---
VH_maj <- VH_R1_majority(r, alpha, mu_s_R1, N, beta)
cat(sprintf("Claim 5: E[V_H^R1] under majority at mu_s_R1 ≈ 0.428\n  Computed: %.6f\n  Match: %s\n\n",
            VH_maj, ifelse(abs(VH_maj - 0.428) < 0.001, "CORRECT", "INCORRECT")))

# --- Claim 6: 27% more on aggressive branch and 41% more on conservative branch ---
pct_agg <- (VH_below / VH_maj - 1) * 100
pct_con <- (VH_above / VH_maj - 1) * 100
cat(sprintf("Claim 6a: Aggressive branch gives 27%% more than majority\n  Computed: %.1f%%\n  Match: %s\n\n",
            pct_agg, ifelse(abs(pct_agg - 27) < 1, "CORRECT", "INCORRECT")))
cat(sprintf("Claim 6b: Conservative branch gives 41%% more than majority\n  Computed: %.1f%%\n  Match: %s\n\n",
            pct_con, ifelse(abs(pct_con - 41) < 1, "CORRECT", "INCORRECT")))

# --- Summary ---
cat("=== SUMMARY ===\n")
cat(sprintf("mu_s_R1       = %.6f  (claimed ≈ 0.197)\n", mu_s_R1))
cat(sprintf("VH below      = %.6f  (claimed ≈ 0.544)\n", VH_below))
cat(sprintf("VH above      = %.6f  (claimed ≈ 0.602)\n", VH_above))
cat(sprintf("Jump %%        = %.3f%%  (claimed ≈ 5.3%%)\n", jump_pct))
cat(sprintf("VH majority   = %.6f  (claimed ≈ 0.428)\n", VH_maj))
cat(sprintf("Agg premium   = %.1f%%  (claimed 27%%)\n", pct_agg))
cat(sprintf("Con premium   = %.1f%%  (claimed 41%%)\n", pct_con))
