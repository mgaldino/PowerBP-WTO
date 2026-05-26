# Theorem 1 — Proof Strategies for Sharper Institutional Comparison

**Date**: 2026-04-21
**Status**: OPEN — needs work

## Context

Edmans review (2026-04-20) flagged that Theorem 1 is a decomposition, not a dominance result. It says "unanimity dominates conditional on entry, majority may dominate via entry" but doesn't resolve the comparison. The reviewer wants explicit parametric conditions.

Two agents proposed proofs. Both have issues. Three additional strategies were identified but not yet explored.

---

## Proposal 1: Global Sufficient Conditions (Agent A)

### Idea
Three closed-form conditions in primitives that imply cav v(p,U) > cav v(p,M) for ALL p:

1. c > kappa_M (majority entry threshold is interior)
2. c <= C_U (unanimity entry threshold <= screening cutoff)  
3. S_U > S_M (unanimity slope dominates majority slope)

Where:
- kappa_M = (1-alpha)(N(N-1) + beta(q-1)) / (N^2(N-1))
- lambda_M = (N(1+(N-1)alpha) - beta(q-1)(1-alpha)) / N^2
- C_U = (N(1 + mu_s(r-1) - alpha*beta*r) - beta(r-1)(1-mu_s)) / N^2
- H_U = Ve(mu_s) - (N-1)*C_U  (budget identity on conservative branch)
- S_U = H_U / mu_s
- S_M = lambda_M * (r-1) * c / (c - kappa_M)

### Verification
- **Algebra: CORRECT.** lambda_M, kappa_M verified against paper's R code (exact match). C_U correct on conservative branch. Budget identity holds.
- **Proof logic: VALID.** Three regions (p < tau_M, tau_M <= p <= mu_s, p >= mu_s) partition correctly. Each inequality follows.

### Problem: Conditions are RESTRICTIVE
- Require alpha very small (~0.01) and r large
- Minimum r for feasibility:
  - N=3, beta=0.99: r >= 1.8
  - N=5, beta=0.90: r >= 3.6
  - N=5, beta=0.95: r >= 3.0
  - N=9, beta=0.90: r >= 6.9
- For paper's baseline (r=1.5, alpha=0.3): **INFEASIBLE** (kappa_M > C_U, band is empty)
- The binding constraint is kappa_M < C_U, which requires alpha small enough that W's unanimity payoff at mu_s exceeds W's per-unit majority payoff

### Verdict
Mathematically correct but too restrictive for the paper's main parameters. Could serve as a proposition for the "high informational asymmetry" case.

---

## Proposal 2: Local Comparative Theorem (Agent B)

### Idea
Under two conditions:
1. Lemma 1 holds (alpha < alpha*)
2. tau(U) < mu_s^R1

There exists epsilon > 0 such that cav v(p,U) > cav v(p,M) for all p in (mu_s - epsilon, mu_s + epsilon).

### Verification
- **Algebra: CORRECT.**
- **Proof logic: VALID.**

### Problem: SUBSTANTIVELY EMPTY
The proof does NOT use the screening jump. It only uses Lemma 1 at two endpoints (mu-, mu+) where entry occurs under both rules. The same argument works for ANY interval [a,b] subset of (tau(U), 1). The screening cutoff mu_s is decorative — centering on it gives the illusion of exploiting the mechanism, but the proof is just "Lemma 1 + affine majority = trivial concavification comparison."

The HARD part — low priors where BP genuinely exploits the screening jump to overcome the entry disadvantage — is not addressed.

### Verdict
Correct but trivial. Does not advance beyond Lemma 1. Should NOT be included as a theorem.

---

## Strategy A: beta = 1 Special Case (NOT YET EXPLORED)

### Idea
With beta = 1:
- mu_s^R1 = 1/(N-2) — clean, independent of r and alpha
- No surplus destruction (budget identity holds on ALL branches)
- Entry thresholds should have cleaner closed forms
- Might yield necessary and sufficient condition

### Why promising
- Removes the main analytical complication (discounting creates surplus destruction on aggressive branch)
- The cutoff 1/(N-2) is universal — doesn't depend on parameters
- Could give the sharpest possible result as "leading case"
- General beta < 1 handled as perturbation or numerically

### To do
- Derive V_W^R1(mu, U) and V_H^R1(mu, U) in closed form for beta=1
- Compute entry thresholds tau(M) and tau(U) in closed form
- Compare slopes S_U and S_M analytically
- Check if conditions simplify enough for N-S condition

---

## Strategy B / Proposal 3: Jump-Based Low-Prior Comparison (Agent C — 2026-04-21)

### Idea (formalized by agent)
Define S_U+ = sup_{mu in Gamma_U} v(mu,U)/mu where Gamma_U = [max(tau(U), mu_s), 1] (post-jump feasible set). Define S_M = v(tau(M), M)/tau(M) (majority slope from origin to entry threshold). Proposition: if S_U+ > S_M, then cav v(p,U) > cav v(p,M) for all p < tau(M).

Proof: constructive. Two-point signal {0, mu_hat} under unanimity gives payoff (p/mu_hat)*v(mu_hat, U) >= S_U+ * p > S_M * p = cav v(p,M).

### Verification: CORRECT AND SUBSTANTIVE
- Proof logic is valid ✓
- Genuinely uses the screening jump (S_U+ is evaluated on post-jump branch) ✓
- Single condition (S_U+ > S_M), not three simultaneous ✓
- Combined with Lemma 1 for p >= tau(U): unanimity dominates at BOTH extremes, majority only in gap [tau(M), tau(U))

### Problem: SAME FUNDAMENTAL OBSTACLE
Numerically checked (2026-04-21):
- **Baseline (r=1.5, alpha=0.3, c=0.1): FAILS.** S_M ~ 390 because tau(M) ~ 0.001 (entry nearly free under majority). No unanimity slope can compete.
- **7% of parameter grid satisfies S_U+ > S_M**, concentrated at N=7, r>=3, alpha<=0.10, c=0.20.
- Closest misses at r=1.5-2.0 have ratio S_U+/S_M ~ 0.999.

**Root cause**: When c is small relative to kappa_M, tau(M) -> 0 and S_M -> infinity. The origin-chord comparison is inherently unfavorable to unanimity in the low-entry-cost regime because majority's low entry barrier creates enormous slope from origin.

### Assessment
Best proposal of the three. Should be included in the paper as a proposition (not the main theorem). It's honest, substantive, and covers the hard case. But it doesn't resolve the full comparison for general parameters.

### Implication for proof strategy
The origin-chord comparison approach (comparing S_U vs S_M) has a structural limitation: it pits unanimity's informational advantage against majority's entry advantage IN THE SAME METRIC (slope from origin). When entry is easy under majority, the entry advantage dominates mechanically.

A fundamentally different approach is needed for the low-entry-cost regime. Possibilities:
- **Strategy A (beta=1)**: might yield different structure
- **Strategy C (threshold prior)**: accept that majority wins at very low priors and characterize the crossover
- **Strategy D (NEW)**: compare concavifications NOT via slopes but via the integral/area, or find a direct argument that the entry gap [tau(M), tau(U)) is "small" relative to the conditional advantage

---

## Strategy C: Threshold Prior p* (NOT YET EXPLORED)

### Idea
Abandon global dominance. Characterize the threshold prior p* such that:
- For p > p*: cav v(p,U) > cav v(p,M) (unanimity dominates)
- For p < p*: cav v(p,M) >= cav v(p,U) (majority dominates or tied)

### Why promising
- More realistic and informative than global dominance
- Tells the hegemon WHEN each rule is better
- p* is a single number in terms of primitives
- Might have clean comparative statics (p* decreases with r, beta, etc.)

### Concern
- p* might not be unique (non-monotonic comparison possible)
- Might be hard to express in closed form

---

## Key Insight for All Strategies

The fundamental comparison at low priors reduces to:

**max_{mu >= tau(U)} [v(mu, U) / mu]  vs  max_{mu >= tau(M)} [v(mu, M) / mu]**

The LHS benefits from the screening jump (high v at mu_s+). The RHS benefits from lower entry threshold (smaller mu at tau_M). The question is whether the jump magnitude outweighs the entry disadvantage.

This is a SINGLE INEQUALITY between two well-defined quantities. The challenge is expressing both sides in closed form.
