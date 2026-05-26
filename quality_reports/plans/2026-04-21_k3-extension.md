# K=3 Extension (Appendix D) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Write Appendix D demonstrating that K=3 types produce 2 screening cutoffs, richer non-convexity, and the comparative institutional result survives.

**Architecture:** Three R scripts (value functions, verification, concavification) plus appendix text in the Rmd. The K=3 value functions follow the same structure as the existing K=2 code in `formal_model_v2.Rmd` (lines 335-403), extending from 2 strategies to 3. Concavification on the 2-simplex uses LP (lpSolve). Figures use base R ternary coordinates.

**Tech Stack:** R (base, lpSolve, geometry). No ggtern — manual barycentric coordinates for portability.

**Spec:** `docs/superpowers/specs/2026-04-21-k3-extension-design.md`

---

### Task 1: K=3 value functions under unanimity

**Files:**
- Create: `scripts/k3_screening.R`

This is the core task. All R2 and R1 value functions for K=3 under unanimity.

- [ ] **Step 1: Write R2 screening functions**

```r
# scripts/k3_screening.R
# K=3 extension: value functions for 3 types under unanimity and majority
# Types: V(0) = 1, V(1) = r1, V(2) = r2, with 1 < r1 < r2

# ---- R2 screening (terminal round) ----

#' Determine R2 screening region for K=3
#' @param mu numeric(3): beliefs (mu0, mu1, mu2) on the 2-simplex
#' @return integer: 1 (low/aggressive), 2 (medium), 3 (high/conservative)
screening_region_R2_k3 <- function(mu, r1, r2, alpha) {
  # W's payoff from each offer (as proposer in R2)
  pi_low  <- mu[1] * (1 - alpha)
  pi_med  <- mu[1] * (1 - alpha * r1) + mu[2] * r1 * (1 - alpha)
  pi_high <- mu[1] * (1 - alpha * r2) + mu[2] * (r1 - alpha * r2) + mu[3] * r2 * (1 - alpha)
  which.max(c(pi_low, pi_med, pi_high))
}

#' H's R2 payoff for each type under unanimity K=3
#' @return numeric(3): V_H^R2 for theta=0,1,2
VH_R2_k3 <- function(mu, r1, r2, alpha, N) {
  region <- screening_region_R2_k3(mu, r1, r2, alpha)
  # H proposes (1/N): keeps V(theta). W proposes ((N-1)/N): H gets the offer.
  if (region == 1) {
    # Low offer: alpha. theta=0 accepts (alpha), theta=1,2 get disagreement.
    c((1 + (N-1) * alpha) / N,
      r1 * (1 + (N-1) * alpha) / N,
      r2 * (1 + (N-1) * alpha) / N)
  } else if (region == 2) {
    # Medium offer: alpha*r1. theta=0 gets alpha*r1 (overpaid), theta=1 indifferent, theta=2 disagreement.
    c((1 + (N-1) * alpha * r1) / N,
      r1 * (1 + (N-1) * alpha) / N,
      r2 * (1 + (N-1) * alpha) / N)
  } else {
    # High offer: alpha*r2. theta=0,1 overpaid, theta=2 indifferent.
    c((1 + (N-1) * alpha * r2) / N,
      (r1 + (N-1) * alpha * r2) / N,
      r2 * (1 + (N-1) * alpha) / N)
  }
}

#' W's R2 payoff under unanimity K=3 (expected over proposer identity)
VW_R2_k3 <- function(mu, r1, r2, alpha, N) {
  region <- screening_region_R2_k3(mu, r1, r2, alpha)
  if (region == 1) {
    proposer_payoff <- mu[1] * (1 - alpha)
  } else if (region == 2) {
    proposer_payoff <- mu[1] * (1 - alpha * r1) + mu[2] * r1 * (1 - alpha)
  } else {
    proposer_payoff <- mu[1] * (1 - alpha * r2) + mu[2] * (r1 - alpha * r2) + mu[3] * r2 * (1 - alpha)
  }
  proposer_payoff / N
}
```

- [ ] **Step 2: Write R1 screening functions**

```r
# ---- R1 screening (first round) under unanimity ----

#' W's R2 payoff in the 2-type subgame on {theta=1, theta=2}
#' Called after LOW R1 offer rejection
#' @param mu numeric(3): original beliefs (only mu[2], mu[3] matter)
VW_R2_2type_sub <- function(mu, r1, r2, alpha, N) {
  if (mu[2] + mu[3] < 1e-15) return(0)
  p1 <- mu[2] / (mu[2] + mu[3])
  p2 <- mu[3] / (mu[2] + mu[3])
  # 2-type screening: offer alpha*r1 (targets theta=1) vs alpha*r2 (targets both)
  pi_sub_low  <- p1 * r1 * (1 - alpha)
  pi_sub_high <- p1 * (r1 - alpha * r2) + p2 * r2 * (1 - alpha)
  max(pi_sub_low, pi_sub_high) / N
}

#' Determine screening region of the 2-type R2 subgame on {theta=1, theta=2}
#' @return integer: 1 (sub-low: W offers alpha*r1) or 2 (sub-high: W offers alpha*r2)
screening_region_R2_2type <- function(mu, r1, r2, alpha) {
  if (mu[2] + mu[3] < 1e-15) return(1)
  p1 <- mu[2] / (mu[2] + mu[3])
  p2 <- mu[3] / (mu[2] + mu[3])
  pi_sub_low  <- p1 * r1 * (1 - alpha)
  pi_sub_high <- p1 * (r1 - alpha * r2) + p2 * r2 * (1 - alpha)
  if (pi_sub_high >= pi_sub_low) 2L else 1L
}

#' H's R2 payoff for each type in the 2-type subgame {theta=1, theta=2}
#' @return numeric(3): V_H^R2 for theta=0,1,2 (theta=0 is off-path but gets overpaid)
VH_R2_2type_sub <- function(mu, r1, r2, alpha, N) {
  sub_region <- screening_region_R2_2type(mu, r1, r2, alpha)
  if (sub_region == 1) {
    # Sub-low: W offers alpha*r1. theta=1 accepts, theta=2 rejects (disagreement).
    c((1 + (N-1) * alpha * r1) / N,      # theta=0 off-path: accepts alpha*r1
      r1 * (1 + (N-1) * alpha) / N,       # theta=1 indifferent at alpha*r1
      r2 * (1 + (N-1) * alpha) / N)       # theta=2 disagreement
  } else {
    # Sub-high: W offers alpha*r2. Both accept.
    c((1 + (N-1) * alpha * r2) / N,       # theta=0 off-path: accepts alpha*r2
      (r1 + (N-1) * alpha * r2) / N,      # theta=1 accepts alpha*r2 (overpaid)
      r2 * (1 + (N-1) * alpha) / N)       # theta=2 indifferent
  }
}

#' H's expected R1 payoff under unanimity K=3
#' @param mu numeric(3): beliefs (mu0, mu1, mu2)
#' @return scalar: E_theta[V_H^{R1}(theta, mu, U)]
VH_R1_k3_unanimity <- function(mu, r1, r2, alpha, beta, N) {
  mu0 <- mu[1]; mu1 <- mu[2]; mu2 <- mu[3]
  Ve <- mu0 + mu1 * r1 + mu2 * r2

  # R2 continuation at current beliefs
  VW_R2 <- VW_R2_k3(mu, r1, r2, alpha, N)
  omega  <- (N - 2) * beta * VW_R2

  # ---- R1 offer levels ----
  # HIGH: y_H makes theta=2 indifferent. All accept.
  y_high <- beta * r2 * (1 + (N-1) * alpha) / N

  # MEDIUM: y_H makes theta=1 indifferent given R2 with theta=2 certain.
  # theta=1's R2 payoff at belief (0,0,1): H proposes gets r1; W offers alpha*r2, theta=1 accepts.
  y_med <- beta * (r1 + (N-1) * alpha * r2) / N

  # LOW: y_H makes theta=0 indifferent given post-rejection R2 subgame.
  VH_R2_post <- VH_R2_2type_sub(mu, r1, r2, alpha, N)
  y_low <- beta * VH_R2_post[1]  # theta=0's continuation

  # ---- W's proposer payoff from each strategy ----
  # HIGH: all accept
  F_high <- Ve - y_high - omega

  # MEDIUM: theta={0,1} accept, theta=2 rejects -> R2 with theta=2 certain
  VW_R2_t2 <- r2 * (1 - alpha) / N
  F_med <- mu0 * (1 - y_med - omega) + mu1 * (r1 - y_med - omega) + mu2 * beta * VW_R2_t2

  # LOW: theta=0 accepts, theta={1,2} reject -> R2 with 2-type subgame
  VW_R2_sub <- VW_R2_2type_sub(mu, r1, r2, alpha, N)
  F_low <- mu0 * (1 - y_low - omega) + (mu1 + mu2) * beta * VW_R2_sub

  # ---- Determine strategy ----
  strategies <- c(F_low, F_med, F_high)
  strat <- which.max(strategies)

  # ---- H proposes (prob 1/N) ----
  H_prop <- c(1, r1, r2) / N - (N-1) * beta * VW_R2 / N  # V(theta_k)/N - (N-1)*beta*VW_R2/N

  # ---- W proposes ((N-1)/N): H's payoff depends on strategy ----
  if (strat == 3) {
    # HIGH: all accept. H gets y_high from every W proposer.
    W_prop <- rep((N-1) * y_high / N, 3)
  } else if (strat == 2) {
    # MEDIUM: theta={0,1} accept (get y_med), theta=2 rejects (R2 with theta=2 certain)
    VH_R2_t2_certain <- r2 * (1 + (N-1) * alpha) / N
    W_prop <- c((N-1) * y_med / N,
                (N-1) * y_med / N,
                (N-1) * beta * VH_R2_t2_certain / N)
  } else {
    # LOW: theta=0 accepts (gets y_low), theta={1,2} reject (R2 2-type subgame)
    VH_R2_post <- VH_R2_2type_sub(mu, r1, r2, alpha, N)
    W_prop <- c((N-1) * y_low / N,
                (N-1) * beta * VH_R2_post[2] / N,
                (N-1) * beta * VH_R2_post[3] / N)
  }

  VH <- H_prop + W_prop  # VH for each type (vector of 3)
  EVH <- sum(mu * VH)
  return(EVH)
}
```

- [ ] **Step 3: Write W's R1 payoff under unanimity K=3**

```r
#' W's expected R1 payoff under unanimity K=3
VW_R1_k3_unanimity <- function(mu, r1, r2, alpha, beta, N) {
  mu0 <- mu[1]; mu1 <- mu[2]; mu2 <- mu[3]
  Ve <- mu0 + mu1 * r1 + mu2 * r2

  VW_R2 <- VW_R2_k3(mu, r1, r2, alpha, N)
  omega  <- (N - 2) * beta * VW_R2

  y_high <- beta * r2 * (1 + (N-1) * alpha) / N
  y_med  <- beta * (r1 + (N-1) * alpha * r2) / N
  VH_R2_post <- VH_R2_2type_sub(mu, r1, r2, alpha, N)
  y_low  <- beta * VH_R2_post[1]

  # W's proposer payoffs
  VW_R2_t2  <- r2 * (1 - alpha) / N
  VW_R2_sub <- VW_R2_2type_sub(mu, r1, r2, alpha, N)

  F_high <- Ve - y_high - omega
  F_med  <- mu0 * (1 - y_med - omega) + mu1 * (r1 - y_med - omega) + mu2 * beta * VW_R2_t2
  F_low  <- mu0 * (1 - y_low - omega) + (mu1 + mu2) * beta * VW_R2_sub
  F_proposer <- max(F_low, F_med, F_high)
  strat <- which.max(c(F_low, F_med, F_high))

  # Non-proposer payoff: when H proposes + when another W proposes
  if (strat == 3) {
    # HIGH: all deals pass. Non-proposer W always gets beta*VW_R2.
    nonprop <- (N - 1) / N * beta * VW_R2
  } else if (strat == 2) {
    # MEDIUM: theta={0,1} pass (W gets beta*VW_R2), theta=2 rejects (R2 with theta=2 certain)
    VW_R2_t2_full <- r2 * (1 - alpha) / N  # VW_R2 at (0,0,1)
    nonprop <- beta * VW_R2 / N +  # H proposes (1/N): always passes
      (N - 2) / N * ((mu0 + mu1) * beta * VW_R2 + mu2 * beta * VW_R2_t2_full)
  } else {
    # LOW: theta=0 pass (W gets beta*VW_R2), theta={1,2} reject (R2 2-type subgame)
    VW_R2_sub_full <- VW_R2_2type_sub(mu, r1, r2, alpha, N)
    nonprop <- beta * VW_R2 / N +  # H proposes (1/N): always passes
      (N - 2) / N * (mu0 * beta * VW_R2 + (mu1 + mu2) * beta * VW_R2_sub_full)
  }

  VW_R1 <- F_proposer / N + nonprop
  return(VW_R1)
}
```

- [ ] **Step 4: Run R2 corner-case checks**

```r
# ---- Verification block (run interactively) ----
cat("=== R2 Corner Checks ===\n")
N <- 5; alpha <- 0.3; r1 <- 1.5; r2 <- 2.5

# Corner (1,0,0): theta=0 certain. W offers alpha (low).
vh <- VH_R2_k3(c(1,0,0), r1, r2, alpha, N)
stopifnot(abs(vh[1] - (1 + (N-1)*alpha)/N) < 1e-10)
cat("R2 corner (1,0,0): PASS\n")

# Corner (0,1,0): theta=1 certain. W offers alpha*r1 (medium).
vh <- VH_R2_k3(c(0,1,0), r1, r2, alpha, N)
stopifnot(abs(vh[2] - r1*(1+(N-1)*alpha)/N) < 1e-10)
cat("R2 corner (0,1,0): PASS\n")

# Corner (0,0,1): theta=2 certain. W offers alpha*r2 (high).
vh <- VH_R2_k3(c(0,0,1), r1, r2, alpha, N)
stopifnot(abs(vh[3] - r2*(1+(N-1)*alpha)/N) < 1e-10)
cat("R2 corner (0,0,1): PASS\n")

# K=2 reduction: set r1 = r2 = r. Region should match existing K=2.
r_k2 <- 1.5
mu_k2 <- c(0.6, 0.4, 0)  # project onto K=2 by setting mu2=0
vh_k3 <- VH_R2_k3(mu_k2, r_k2, r_k2, alpha, N)
# K=2 R2 with V in {1, r_k2}: mu = 0.4
mu_s_R2 <- alpha * (r_k2 - 1) / (r_k2 - alpha)
if (0.4 < mu_s_R2) {
  vh_k2_0 <- (1 + (N-1)*alpha) / N
} else {
  vh_k2_0 <- (1 + (N-1)*alpha*r_k2) / N
}
vh_k2_1 <- r_k2 * (1 + (N-1)*alpha) / N
stopifnot(abs(vh_k3[1] - vh_k2_0) < 1e-10)
stopifnot(abs(vh_k3[2] - vh_k2_1) < 1e-10)
cat("R2 K=2 reduction: PASS\n")
```

- [ ] **Step 5: Run R1 corner-case checks and K=2 reduction**

The K=2 functions (`VH_R1_unanimity`, `VW_R1_unanimity`, `VH_R1_majority`) are needed for the reduction test. Copy them from `formal_model_v2.Rmd` lines 335-403 into this verification block, or source from `k3_verification.R` (Task 3) where they are also defined.

```r
cat("\n=== R1 Checks ===\n")
beta <- 0.9

# K=2 reduction: r1 = r2 = r, mu2 = 0
r_test <- 1.5
for (mu_val in c(0.1, 0.3, 0.5, 0.7, 0.9)) {
  mu_k3 <- c(1 - mu_val, mu_val, 0)
  evh_k3 <- VH_R1_k3_unanimity(mu_k3, r_test, r_test, alpha, beta, N)
  # Existing K=2 function (from formal_model_v2.Rmd)
  evh_k2 <- VH_R1_unanimity(r_test, alpha, mu_val, N, beta)
  err <- abs(evh_k3 - evh_k2)
  cat(sprintf("  mu=%.1f: K3=%.6f, K2=%.6f, err=%.2e %s\n",
              mu_val, evh_k3, evh_k2, err, ifelse(err < 1e-8, "PASS", "FAIL")))
}

# Same for VW
for (mu_val in c(0.1, 0.3, 0.5, 0.7, 0.9)) {
  mu_k3 <- c(1 - mu_val, mu_val, 0)
  vw_k3 <- VW_R1_k3_unanimity(mu_k3, r_test, r_test, alpha, beta, N)
  vw_k2 <- VW_R1_unanimity(r_test, alpha, mu_val, N, beta)
  err <- abs(vw_k3 - vw_k2)
  cat(sprintf("  VW mu=%.1f: K3=%.6f, K2=%.6f, err=%.2e %s\n",
              mu_val, vw_k3, vw_k2, err, ifelse(err < 1e-8, "PASS", "FAIL")))
}
```

- [ ] **Step 6: Commit**

```bash
git add scripts/k3_screening.R
git commit -m "feat: K=3 value functions under unanimity (R2 + R1 screening)"
```

---

### Task 2: K=3 majority functions

**Files:**
- Modify: `scripts/k3_screening.R`

- [ ] **Step 1: Write majority value functions**

Append to `scripts/k3_screening.R`:

```r
# ---- Majority rule (no screening, any K) ----

#' H's expected R1 payoff under majority K=3
#' Key property: affine in V_e(mu) = mu0 + mu1*r1 + mu2*r2
VH_R1_k3_majority <- function(mu, r1, r2, alpha, beta, N) {
  q <- floor(N/2) + 1
  Ve <- mu[1] + mu[2] * r1 + mu[3] * r2
  VW_R2_M <- (1 - alpha) * Ve / N
  H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
  W_prop_H <- (N - 1) / N * alpha * Ve
  H_prop + W_prop_H
}

#' W's expected R1 payoff under majority K=3
VW_R1_k3_majority <- function(mu, r1, r2, alpha, beta, N) {
  Ve <- mu[1] + mu[2] * r1 + mu[3] * r2
  EVH <- VH_R1_k3_majority(mu, r1, r2, alpha, beta, N)
  (Ve - EVH) / (N - 1)
}
```

- [ ] **Step 2: Verify affinity and K=2 reduction**

```r
cat("\n=== Majority Checks ===\n")
# Affinity check: lambda_M * Ve must hold
q <- floor(N/2) + 1
lambda_M <- (N * (1 + (N-1)*alpha) - beta * (q-1) * (1-alpha)) / N^2

for (i in 1:5) {
  mu_test <- runif(3); mu_test <- mu_test / sum(mu_test)
  Ve <- mu_test[1] + mu_test[2] * r1 + mu_test[3] * r2
  evh <- VH_R1_k3_majority(mu_test, r1, r2, alpha, beta, N)
  expected <- lambda_M * Ve
  err <- abs(evh - expected)
  cat(sprintf("  Affinity test %d: err=%.2e %s\n", i, err, ifelse(err < 1e-10, "PASS", "FAIL")))
}

# K=2 reduction
for (mu_val in c(0.2, 0.5, 0.8)) {
  mu_k3 <- c(1 - mu_val, mu_val, 0)
  evh_k3 <- VH_R1_k3_majority(mu_k3, r_test, r_test, alpha, beta, N)
  evh_k2 <- VH_R1_majority(r_test, alpha, mu_val, N, beta)
  err <- abs(evh_k3 - evh_k2)
  cat(sprintf("  K2 reduction mu=%.1f: err=%.2e %s\n", mu_val, err, ifelse(err < 1e-10, "PASS", "FAIL")))
}
```

- [ ] **Step 3: Commit**

```bash
git add scripts/k3_screening.R
git commit -m "feat: K=3 majority functions (affine in Ve, no screening)"
```

---

### Task 3: Simplex grid and Lemma 1 numerical verification

**Files:**
- Create: `scripts/k3_verification.R`

- [ ] **Step 1: Write simplex grid generator and D(mu) computation**

```r
# scripts/k3_verification.R
# Numerical verification of Proposition D.3 (Lemma 1 analog for K=3)

source("scripts/k3_screening.R")

# Load K=2 functions from the paper (needed for reduction tests)
# These are defined in formal_model_v2.Rmd; paste here for standalone use:
VH_R1_unanimity <- function(r, alpha, mu, N, beta) {
  x <- (N - 1) * alpha * r
  mu_s_R2 <- alpha * (r - 1) / (r - alpha)
  Ve <- 1 + mu * (r - 1)
  if (mu < mu_s_R2) { VW_R2 <- (1 - mu) * (1 - alpha) / N
  } else { VW_R2 <- (Ve - alpha * r) / N }
  omega <- (N - 2) * beta * VW_R2
  F1_con <- Ve - beta * (r + x) / N - omega
  F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
  H_prop_0 <- (1 - (N - 1) * beta * VW_R2) / N
  H_prop_1 <- (r - (N - 1) * beta * VW_R2) / N
  if (F1_agg > F1_con) {
    VH_0 <- H_prop_0 + (N - 1) * beta * (1 + x) / (N^2)
    VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
  } else {
    VH_0 <- H_prop_0 + (N - 1) * beta * (r + x) / (N^2)
    VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
  }
  mu * VH_1 + (1 - mu) * VH_0
}

VH_R1_majority <- function(r, alpha, mu, N, beta) {
  q <- floor(N/2) + 1; Ve <- 1 + mu * (r - 1)
  VW_R2_M <- (1 - alpha) * Ve / N
  H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
  W_prop_H <- (N - 1) / N * alpha * Ve
  H_prop + W_prop_H
}

VW_R1_unanimity <- function(r, alpha, mu, N, beta) {
  x <- (N - 1) * alpha * r
  mu_s_R2 <- alpha * (r - 1) / (r - alpha)
  Ve <- 1 + mu * (r - 1)
  if (mu < mu_s_R2) { VW_R2 <- (1 - mu) * (1 - alpha) / N
  } else { VW_R2 <- (Ve - alpha * r) / N }
  omega <- (N - 2) * beta * VW_R2
  F1_con <- Ve - beta * (r + x) / N - omega
  F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
  F_proposer <- max(F1_agg, F1_con)
  if (F1_agg > F1_con) {
    VW_R2_1 <- r * (1 - alpha) / N
    nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)
  } else {
    nonprop <- (N - 1) / N * beta * VW_R2
  }
  F_proposer / N + nonprop
}

#' Generate barycentric grid on the 2-simplex
#' @param n_per_side number of divisions per side
#' @return matrix with 3 columns (mu0, mu1, mu2), one row per interior point
simplex_grid <- function(n_per_side, interior_only = TRUE) {
  pts <- list()
  for (i in 0:n_per_side) {
    for (j in 0:(n_per_side - i)) {
      k <- n_per_side - i - j
      mu <- c(i, j, k) / n_per_side
      if (interior_only && any(mu < 1e-6)) next
      pts[[length(pts) + 1]] <- mu
    }
  }
  do.call(rbind, pts)
}

#' Compute D(mu) = VH(U) - VH(M) on a simplex grid
compute_D_grid <- function(r1, r2, alpha, beta, N, n_per_side = 50) {
  grid <- simplex_grid(n_per_side)
  n <- nrow(grid)
  D_vals <- numeric(n)
  strat_vals <- integer(n)

  for (i in 1:n) {
    mu <- grid[i, ]
    vh_u <- VH_R1_k3_unanimity(mu, r1, r2, alpha, beta, N)
    vh_m <- VH_R1_k3_majority(mu, r1, r2, alpha, beta, N)
    D_vals[i] <- vh_u - vh_m
  }

  list(grid = grid, D = D_vals, n = n,
       min_D = min(D_vals), mean_D = mean(D_vals), sd_D = sd(D_vals),
       all_positive = all(D_vals > 0))
}
```

- [ ] **Step 2: Run baseline verification**

```r
cat("=== Proposition D.3 Verification ===\n\n")

# Baseline parameters
result <- compute_D_grid(r1 = 1.5, r2 = 2.5, alpha = 0.3, beta = 0.9, N = 5, n_per_side = 80)
cat(sprintf("Baseline (r1=1.5, r2=2.5, alpha=0.3, beta=0.9, N=5):\n"))
cat(sprintf("  Grid points: %d\n", result$n))
cat(sprintf("  min D(mu):   %.6e\n", result$min_D))
cat(sprintf("  mean D(mu):  %.6f\n", result$mean_D))
cat(sprintf("  All D > 0:   %s\n\n", result$all_positive))
```

- [ ] **Step 3: Run robustness checks across parameterizations**

```r
# Robustness: multiple parameterizations
params <- list(
  list(r1=1.3, r2=1.8, alpha=0.2, beta=0.9, N=5),
  list(r1=2.0, r2=3.0, alpha=0.2, beta=0.9, N=5),
  list(r1=1.5, r2=2.5, alpha=0.1, beta=0.9, N=5),
  list(r1=1.5, r2=2.5, alpha=0.3, beta=0.7, N=5),
  list(r1=1.5, r2=2.5, alpha=0.3, beta=0.9, N=3),
  list(r1=1.5, r2=2.5, alpha=0.3, beta=0.9, N=7),
  list(r1=1.2, r2=1.5, alpha=0.3, beta=0.8, N=5),
  list(r1=1.5, r2=2.5, alpha=0.35, beta=0.9, N=5)
)

cat("Robustness checks (n_per_side=50):\n")
cat(sprintf("%-40s %12s %12s %s\n", "Parameters", "min D", "mean D", "All>0"))
cat(paste(rep("-", 75), collapse=""), "\n")

for (p in params) {
  res <- compute_D_grid(p$r1, p$r2, p$alpha, p$beta, p$N, n_per_side = 50)
  label <- sprintf("r1=%.1f r2=%.1f a=%.2f b=%.1f N=%d", p$r1, p$r2, p$alpha, p$beta, p$N)
  cat(sprintf("%-40s %12.4e %12.6f %s\n", label, res$min_D, res$mean_D,
              ifelse(res$all_positive, "YES", "NO")))
}
```

- [ ] **Step 4: Commit**

```bash
git add scripts/k3_verification.R
git commit -m "feat: K=3 Lemma 1 numerical verification on simplex grid"
```

---

### Task 4: Concavification on the 2-simplex

**Files:**
- Create: `scripts/k3_concavification.R`

- [ ] **Step 1: Write LP-based concavification**

```r
# scripts/k3_concavification.R
# Concavification of value functions on the 2-simplex via LP

source("scripts/k3_screening.R")

if (!requireNamespace("lpSolve", quietly = TRUE)) install.packages("lpSolve")
library(lpSolve)

#' Compute value function on simplex grid (with entry threshold)
#' @return data.frame with columns mu0, mu1, mu2, v_U, v_M, vw_U, vw_M
compute_values_on_grid <- function(grid, r1, r2, alpha, beta, N, c_entry) {
  n <- nrow(grid)
  v_U <- v_M <- vw_U <- vw_M <- numeric(n)
  for (i in 1:n) {
    mu <- grid[i, ]
    vw_U[i] <- VW_R1_k3_unanimity(mu, r1, r2, alpha, beta, N)
    vw_M[i] <- VW_R1_k3_majority(mu, r1, r2, alpha, beta, N)
    v_U[i] <- if (vw_U[i] >= c_entry) VH_R1_k3_unanimity(mu, r1, r2, alpha, beta, N) else 0
    v_M[i] <- if (vw_M[i] >= c_entry) VH_R1_k3_majority(mu, r1, r2, alpha, beta, N) else 0
  }
  data.frame(mu0 = grid[,1], mu1 = grid[,2], mu2 = grid[,3],
             v_U = v_U, v_M = v_M, vw_U = vw_U, vw_M = vw_M)
}

#' Concavify a function on the simplex via LP
#' For each query point p, solve: max w'f s.t. A w = b, w >= 0
#' where A = rbind(mu0_grid, mu1_grid, ones), b = c(p0, p1, 1)
#' @param grid matrix n x 3 (support points)
#' @param f_vals numeric(n) (function values at support)
#' @param query matrix m x 3 (points to evaluate concavification)
#' @return numeric(m) concavified values
concavify_simplex <- function(grid, f_vals, query = grid) {
  n <- nrow(grid)
  m <- nrow(query)
  # Constraint matrix: 3 rows (mu0 constraint, mu1 constraint, sum=1)
  A <- rbind(grid[, 1], grid[, 2], rep(1, n))
  cav_vals <- numeric(m)

  for (i in 1:m) {
    p <- query[i, ]
    b <- c(p[1], p[2], 1)
    result <- lp("max", f_vals, A, rep("=", 3), b)
    if (result$status == 0) {
      cav_vals[i] <- result$objval
    } else {
      cav_vals[i] <- NA
    }
  }
  cav_vals
}
```

- [ ] **Step 2: Write verification of concavification**

```r
#' Verify concavification properties
verify_concavification <- function(grid, f_vals, cav_vals) {
  # 1. cav v >= v pointwise
  above <- all(cav_vals >= f_vals - 1e-8, na.rm = TRUE)
  cat(sprintf("  cav >= v pointwise: %s\n", ifelse(above, "PASS", "FAIL")))

  # 2. Concavity: for random triples, check Jensen's inequality
  n <- nrow(grid)
  n_tests <- 500
  concave_pass <- 0
  for (t in 1:n_tests) {
    idx <- sample(n, 3)
    lambda <- runif(3); lambda <- lambda / sum(lambda)
    p_mix <- colSums(lambda * grid[idx, ])
    val_mix <- sum(lambda * cav_vals[idx])
    # Find nearest grid point to p_mix
    dists <- rowSums((grid - matrix(p_mix, n, 3, byrow = TRUE))^2)
    nearest <- which.min(dists)
    # Jensen: cav(mix) >= mix of cav (approximately, up to grid resolution)
    if (cav_vals[nearest] >= val_mix - 0.01) concave_pass <- concave_pass + 1
  }
  cat(sprintf("  Concavity (Jensen, %d tests): %d/%d pass\n", n_tests, concave_pass, n_tests))
}
```

- [ ] **Step 3: Run concavification on baseline parameters**

```r
cat("=== Concavification ===\n")
set.seed(42)

N <- 5; alpha <- 0.3; beta <- 0.9; r1 <- 1.5; r2 <- 2.5; c_entry <- 0.1
grid <- simplex_grid(60, interior_only = FALSE)  # include boundary
# Add boundary points with small epsilon to avoid division by zero
grid[grid < 1e-6] <- 1e-6
grid <- grid / rowSums(grid)

cat(sprintf("Grid: %d points\n", nrow(grid)))

vals <- compute_values_on_grid(grid, r1, r2, alpha, beta, N, c_entry)

cat("Computing cav v(U)...\n")
cav_U <- concavify_simplex(grid, vals$v_U)
cat("Computing cav v(M)...\n")
cav_M <- concavify_simplex(grid, vals$v_M)

cat("\nUnanimity concavification:\n")
verify_concavification(grid, vals$v_U, cav_U)
cat("Majority concavification:\n")
verify_concavification(grid, vals$v_M, cav_M)

# Institutional comparison
diff <- cav_U - cav_M
cat(sprintf("\ncav v(U) - cav v(M):\n"))
cat(sprintf("  min:  %.6f\n", min(diff, na.rm = TRUE)))
cat(sprintf("  max:  %.6f\n", max(diff, na.rm = TRUE)))
cat(sprintf("  U dominates: %.1f%% of grid\n", 100 * mean(diff > 0, na.rm = TRUE)))
cat(sprintf("  M dominates: %.1f%% of grid\n", 100 * mean(diff < 0, na.rm = TRUE)))
```

- [ ] **Step 4: Commit**

```bash
git add scripts/k3_concavification.R
git commit -m "feat: LP-based concavification on 2-simplex for K=3"
```

---

### Task 5: Ternary heatmap figures

**Files:**
- Modify: `scripts/k3_concavification.R`

- [ ] **Step 1: Write ternary plotting utilities**

Append to `scripts/k3_concavification.R`:

```r
# ---- Ternary plot utilities (base R, no external packages) ----

#' Convert barycentric (mu0, mu1, mu2) to Cartesian (x, y) for equilateral triangle
#' Convention: mu0 at bottom-left, mu1 at bottom-right, mu2 at top
bary_to_cart <- function(mu0, mu1, mu2) {
  x <- mu1 + mu2 / 2
  y <- mu2 * sqrt(3) / 2
  cbind(x, y)
}

#' Draw empty ternary axes
ternary_axes <- function(labels = c(expression(p[0]), expression(p[1]), expression(p[2]))) {
  plot(NULL, xlim = c(-0.08, 1.08), ylim = c(-0.08, sqrt(3)/2 + 0.08),
       asp = 1, axes = FALSE, xlab = "", ylab = "")
  # Triangle
  polygon(c(0, 1, 0.5), c(0, 0, sqrt(3)/2), border = "black", lwd = 1.5)
  # Labels
  text(-0.06, -0.04, labels[1], cex = 1.1)
  text(1.06, -0.04, labels[2], cex = 1.1)
  text(0.5, sqrt(3)/2 + 0.06, labels[3], cex = 1.1)
}

#' Ternary heatmap via colored points
ternary_heatmap <- function(grid, values, main = "", col_palette = NULL, ...) {
  xy <- bary_to_cart(grid[,1], grid[,2], grid[,3])
  if (is.null(col_palette)) {
    # Blue-white-red diverging palette
    n_cols <- 256
    blues <- colorRampPalette(c("steelblue4", "steelblue2", "white"))(n_cols / 2)
    reds  <- colorRampPalette(c("white", "firebrick2", "firebrick4"))(n_cols / 2)
    col_palette <- c(blues, reds)
  }
  n_cols <- length(col_palette)
  vmin <- min(values, na.rm = TRUE)
  vmax <- max(values, na.rm = TRUE)
  # Center at zero for diverging palette
  vlim <- max(abs(vmin), abs(vmax))
  if (vlim < 1e-12) vlim <- 1
  idx <- round((values + vlim) / (2 * vlim) * (n_cols - 1)) + 1
  idx <- pmax(1, pmin(n_cols, idx))
  cols <- col_palette[idx]

  ternary_axes()
  points(xy[,1], xy[,2], pch = 15, cex = 0.6, col = cols)
  title(main = main, cex.main = 1)

  # Legend
  legend_x <- 1.0; legend_y <- sqrt(3)/2 * 0.8
  legend("right", legend = c(sprintf("U > M (max=%.3f)", vmax),
                              "U = M",
                              sprintf("M > U (min=%.3f)", vmin)),
         fill = c("steelblue3", "white", "firebrick3"),
         cex = 0.7, bg = "white", inset = c(-0.02, 0))
}
```

- [ ] **Step 2: Generate main heatmap (Figure D.1)**

Depends on Task 4 Step 3 having been run (variables `grid`, `vals`, `cav_U`, `cav_M`, `diff` in environment). In the final script, these steps run sequentially.

```r
# ---- Figure D.1: Institutional comparison heatmap ----
pdf("figures/k3_heatmap_institutional.pdf", width = 7, height = 6)
ternary_heatmap(grid, diff, main = "cav v(p, U) - cav v(p, M) on the 2-simplex\n(K=3: r1=1.5, r2=2.5, N=5, alpha=0.3, beta=0.9, c=0.1)")
dev.off()
cat("Saved: figures/k3_heatmap_institutional.pdf\n")
```

- [ ] **Step 3: Generate value function surface (Figure D.2)**

```r
# ---- Figure D.2: Value functions showing screening jumps ----
pdf("figures/k3_value_surfaces.pdf", width = 10, height = 5)
par(mfrow = c(1, 2), mar = c(1, 1, 3, 1))

# Panel (a): v(mu, U) — with screening jumps visible
xy <- bary_to_cart(grid[,1], grid[,2], grid[,3])
n_cols <- 256
pal_u <- colorRampPalette(c("gray95", "steelblue1", "steelblue4"))(n_cols)
v_u_pos <- pmax(vals$v_U, 0)
idx_u <- round(v_u_pos / max(v_u_pos + 1e-12) * (n_cols - 1)) + 1

ternary_axes()
points(xy[,1], xy[,2], pch = 15, cex = 0.6, col = pal_u[idx_u])
title(main = "(a) v(mu, U): value under unanimity")

# Panel (b): v(mu, M) — smooth, no jumps
pal_m <- colorRampPalette(c("gray95", "firebrick1", "firebrick4"))(n_cols)
v_m_pos <- pmax(vals$v_M, 0)
idx_m <- round(v_m_pos / max(v_m_pos + 1e-12) * (n_cols - 1)) + 1

ternary_axes()
points(xy[,1], xy[,2], pch = 15, cex = 0.6, col = pal_m[idx_m])
title(main = "(b) v(mu, M): value under majority")

dev.off()
cat("Saved: figures/k3_value_surfaces.pdf\n")
```

- [ ] **Step 4: Commit**

```bash
git add scripts/k3_concavification.R figures/k3_heatmap_institutional.pdf figures/k3_value_surfaces.pdf
git commit -m "feat: ternary heatmaps for K=3 institutional comparison"
```

---

### Task 6: Appendix D text in formal_model_v2.Rmd

**Files:**
- Modify: `formal_model_v2.Rmd` — append Appendix D after the existing appendices

- [ ] **Step 1: Identify insertion point**

Read the end of `formal_model_v2.Rmd` to find where to append. The appendix goes after the last existing section, before `\bibliography` or at the end.

Run: Search for "Appendix" or "\\section" near end of file.

- [ ] **Step 2: Write Appendix D LaTeX + R chunks**

Append to `formal_model_v2.Rmd`. The full appendix text must include:

1. **D.1 Setup**: K=3 model statement, notation
2. **D.2 R2 screening**: Proposition D.1 (general K cutoffs), closed-form R2 values, proof
3. **D.3 R1 screening**: 3 strategies, recursive structure (low → K=2 subgame), numerical cutoffs
4. **D.4 Majority**: Proposition D.2 (affine, no screening), proof
5. **D.5 Conditional payoff dominance**: Proposition D.3, numerical verification table
6. **D.6 BP on the 2-simplex**: Value functions, concavification, Figure D.1 (heatmap), Figure D.2 (surfaces)
7. **D.7 Discussion**: General K remark, complexity remark

The R chunks should `source("scripts/k3_screening.R")` and `source("scripts/k3_concavification.R")` and embed the figures inline.

Key LaTeX content for Propositions (to be written in the Rmd):

```latex
\begin{proposition}[K types produce K-1 screening cutoffs in R2]\label{prop:k_cutoffs}
For $K$ ordered types with values $v_1 < \cdots < v_K$, the R2 screening boundary
between offer $k$ and offer $k+1$ under unanimity is:
\[
\frac{\mu_{k+1}}{\sum_{j \leq k} \mu_j} = \frac{\alpha(v_{k+1} - v_k)}{v_{k+1}(1-\alpha)}.
\]
These define $K-1$ hyperplanes partitioning $\Delta^{K-1}$ into $K$ regions.
\end{proposition}

\begin{proposition}[Majority is linear for any K]\label{prop:majority_k}
Under majority rule with $K$ types, $E_\theta[V_H^{R1}(\theta, \mu, M)] = \lambda_M V_e(\mu)$
where $\lambda_M$ depends only on $(N, \alpha, \beta, q)$ and $V_e(\mu) = \sum_k \mu_k v_k$.
\end{proposition}

\begin{proposition}[Conditional payoff dominance, K=3]\label{prop:lemma1_k3}
For $K=3$ types and $\alpha$ sufficiently small, numerical verification confirms:
\[
E_\theta[V_H^{R1}(\theta, \mu, U)] > E_\theta[V_H^{R1}(\theta, \mu, M)]
\quad \text{for all } \mu \in \operatorname{int}(\Delta^2).
\]
\end{proposition}
```

- [ ] **Step 3: Source and embed figures in Rmd**

The R chunks in the appendix:

```r
```{r k3_setup, include=FALSE}
source("scripts/k3_screening.R")
```

```{r k3_verification_table, echo=FALSE, results='asis'}
source("scripts/k3_verification.R")
# Output the robustness table as LaTeX
```

```{r k3_heatmap, echo=FALSE, fig.width=7, fig.height=6, fig.cap="..."}
source("scripts/k3_concavification.R")
# Generate heatmap inline
```
```

- [ ] **Step 4: Compile and verify**

Run: `Rscript -e "rmarkdown::render('formal_model_v2.Rmd')"`

Check: PDF compiles without errors, figures appear, cross-references work.

- [ ] **Step 5: Commit**

```bash
git add formal_model_v2.Rmd
git commit -m "feat: Appendix D — K=3 extension with screening cutoffs and BP on 2-simplex"
```

---

## Verification checklist

- [ ] R2 cutoffs for K=3 reduce to K=2 when r1 = r2
- [ ] R1 value functions match K=2 when mu2 = 0 and r1 = r2
- [ ] Majority value is exactly affine in Ve (numerical check)
- [ ] D(mu) > 0 on dense grid for baseline parameters
- [ ] Concavification satisfies cav v >= v pointwise
- [ ] Concavification is approximately concave (Jensen test)
- [ ] Heatmap shows expected blue/red pattern
- [ ] Appendix compiles without errors
