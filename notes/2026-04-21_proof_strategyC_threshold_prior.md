# Strategy C: Threshold Prior p* for Institutional Choice

**Date**: 2026-04-21
**Status**: VERIFIED — numerically confirmed (10/10 test cases match)
**Use**: MAIN RESULT for the paper. Replaces current Theorem 1 decomposition.

---

## Theorem (Threshold Prior for Institutional Choice)

### Setup

Let q = floor(N/2) + 1 and define:

$$\lambda_M = \frac{N[1+(N-1)\alpha] - \beta(q-1)(1-\alpha)}{N^2}$$

$$\kappa_M = \frac{(1-\alpha)[N(N-1)+\beta(q-1)]}{N^2(N-1)}$$

$$\tau(M) = \max\left\{0, \frac{c/\kappa_M - 1}{r-1}\right\}$$

$$S_M = \frac{\lambda_M V_e(\tau(M))}{\tau(M)} \quad \text{when } \tau(M) > 0$$

Let tau(U) be the entry threshold under unanimity, and define:

$$S_U = \max_{\mu \geq \tau(U)} \frac{v(\mu, U)}{\mu}$$

where v(mu, U) = E_theta[V_H^R1(theta, mu, U)] when entry occurs.

### Statement

The comparison cav v(p, U) vs cav v(p, M) has the following structure:

**(a)** If tau(U) = 0 (entry free under unanimity), then **unanimity strictly dominates for all p in (0,1)**, and p* = 0.

**(b)** If tau(M) = 0 < tau(U) (entry free under majority but not unanimity), there exists a **unique threshold**

$$p^* = \frac{\lambda_M}{S_U - \lambda_M(r-1)} \in (0, \tau(U))$$

**(c)** If 0 < tau(M) < tau(U) and S_U > S_M, then **unanimity strictly dominates for all p in (0,1)**, and p* = 0.

**(d)** If 0 < tau(M) < tau(U) and S_U <= S_M, there exists a **unique threshold**

$$p^* = \frac{\lambda_M}{S_U - \lambda_M(r-1)} \in [\tau(M), \tau(U)]$$

In all cases:
- **p > p***: unanimity strictly dominates (cav v(p,U) > cav v(p,M))
- **p < p***: majority weakly dominates
- The comparison is **monotone**: at most one crossing

---

### Proof

**Step 1 (High priors, p >= tau(U)).** Entry occurs under both rules. Since v(mu, M) is affine above tau(M), cav v(p,M) = v(p,M). By Lemma 1, v(p,U) > v(p,M) for p in (0,1). Hence cav v(p,U) >= v(p,U) > v(p,M) = cav v(p,M).

**Step 2 (Case (a): tau(U) = 0).** Step 1 covers all p in (0,1). QED.

**Step 3 (Structure of concavifications for p < tau(U)).** When tau(U) > 0:

Under unanimity: v(mu,U) = 0 for mu < tau(U). The concavification for p <= mu* (the tangent point achieving max v(mu,U)/mu) is cav v(p,U) = S_U * p. This is EXACT (not just a bound) because:
1. v(mu,U)/mu <= S_U for all mu (by definition of S_U as supremum)
2. Hence v(mu,U) <= S_U * mu for all mu
3. The line S_U * p majorizes v on [0, mu*]
4. It touches v at mu*, so it's the tightest such line
5. Therefore cav v(p,U) = S_U * p for p in [0, mu*]

Under majority:
- If tau(M) = 0: cav v(p,M) = v(p,M) = lambda_M * V_e(p) = lambda_M + lambda_M(r-1)*p
- If tau(M) > 0: cav v(p,M) = S_M * p for p < tau(M), and v(p,M) for p >= tau(M)

**Step 4 (Case (b): tau(M) = 0, tau(U) > 0).** For p in (0, tau(U)):
- cav v(p,U) = S_U * p (line through origin)
- cav v(p,M) = lambda_M + lambda_M(r-1)*p (affine with positive intercept)

At p = 0: S_U * 0 = 0 < lambda_M (majority wins).
At p = tau(U): S_U * tau(U) >= v(tau(U), U) > v(tau(U), M) = lambda_M * V_e(tau(U)) (unanimity wins, by Lemma 1).

Since both are linear in p, they cross exactly once at:
$$p^* = \frac{\lambda_M}{S_U - \lambda_M(r-1)}$$

Denominator is positive: from the inequality at tau(U), S_U > lambda_M * V_e(tau(U))/tau(U) = lambda_M/tau(U) + lambda_M(r-1) > lambda_M(r-1).

**Step 5 (Case (c): tau(M) > 0, S_U > S_M).** 
- For p < tau(M): cav v(p,U) = S_U * p > S_M * p = cav v(p,M). ✓
- For p in [tau(M), tau(U)): cav v(p,U) = S_U * p and cav v(p,M) = lambda_M * V_e(p).
  - At tau(M): S_U * tau(M) > S_M * tau(M) = lambda_M * V_e(tau(M)). ✓
  - At tau(U): unanimity wins by Lemma 1. ✓
  - Both are linear in p, positive at both endpoints => positive throughout. ✓
- For p >= tau(U): Step 1. ✓

**Step 6 (Case (d): tau(M) > 0, S_U <= S_M).** 
- For p < tau(M): S_U * p <= S_M * p. Majority dominates.
- For p in [tau(M), tau(U)): The difference D(p) = S_U * p - lambda_M * V_e(p) = [S_U - lambda_M(r-1)]*p - lambda_M.
  - D(tau(M)) = S_U * tau(M) - S_M * tau(M) <= 0 (since S_U <= S_M).
  - D(tau(U)^-) > 0 (by Lemma 1, as in Step 4).
  - D is linear, crosses zero exactly once at p* = lambda_M / [S_U - lambda_M(r-1)].
  - p* in [tau(M), tau(U)]. ✓

QED.

---

### Unified Formula

In cases (b) and (d):

$$\boxed{p^* = \frac{\lambda_M}{S_U - \lambda_M(r-1)}}$$

In cases (a) and (c): p* = 0 (unanimity dominates everywhere).

---

## Numerical Verification

Tested against paper's R code with full concavification (10 parameter sets):

| Case | r | alpha | N | beta | c | p*_formula | p*_actual | Match |
|------|---|-------|---|------|---|------------|-----------|-------|
| (a) | 1.5 | 0.30 | 5 | 0.90 | 0.10 | 0 | 0 | ✓ |
| (d) | 1.5 | 0.30 | 5 | 0.90 | 0.20 | 0.717 | 0.716 | ✓ |
| (a) | 3.0 | 0.10 | 5 | 0.90 | 0.10 | 0 | 0 | ✓ |
| (d) | 3.0 | 0.10 | 5 | 0.90 | 0.20 | 0.083 | 0.083 | ✓ |
| (a) | 5.0 | 0.05 | 7 | 0.95 | 0.10 | 0 | 0 | ✓ |
| (c) | 5.0 | 0.05 | 7 | 0.95 | 0.20 | 0 | 0.001 | ✓ |
| (a) | 2.0 | 0.20 | 3 | 0.80 | 0.10 | 0 | 0 | ✓ |
| (a) | 2.0 | 0.20 | 3 | 0.95 | 0.15 | 0 | 0 | ✓ |
| (a) | 1.5 | 0.10 | 5 | 0.99 | 0.10 | 0 | 0 | ✓ |
| (b) | 10.0 | 0.05 | 5 | 0.90 | 0.15 | 0.007 | 0.007 | ✓ |

All 10/10 match within grid precision (0.001).

---

## Comparative Statics

p* **decreases** (unanimity favored for broader range) when:
- r increases (larger informational asymmetry)
- beta increases (more patient bargaining)
- c decreases (lower entry costs)
- alpha decreases (weaker bilateral alternatives)

p* **increases** (majority favored) when:
- c increases (entry harder)
- alpha increases (stronger bilateral alternatives)
- N increases with r fixed (more players dilute the screening jump)

---

## Substantive Interpretation

$$p^* = \frac{\lambda_M}{S_U - \lambda_M(r-1)}$$

- **Numerator lambda_M**: H's share of expected pie under majority. The "baseline" majority payoff.
- **Denominator S_U - lambda_M(r-1)**: excess slope of unanimity's concavification over majority's marginal gain. The net marginal advantage of unanimity per unit of prior.

The hegemon chooses unanimity when **the prior is above the break-even belief** at which the informational power advantage (screening + BP) compensates for majority's entry advantage.

---

## Building Blocks Used

From Proposal 3 (jump-based):
- v(mu,U)|_con = A*Ve(mu) + B (affine on conservative branch)
- v(mu,U)/mu strictly decreasing on post-jump branch
- S_U attained at inf Gamma_U

From paper:
- Lemma 1 (conditional payoff dominance)
- v(mu,M) affine above tau(M) with v(mu,M)/mu decreasing

---

## Caveats

1. **S_U is semi-closed-form**: It requires knowing tau(U) and whether the tangent point is at tau(U) or mu_s. When tau(U) is on the conservative branch, closed forms exist. When on aggressive branch, numerical computation needed.

2. **The tau(U) closed form** (from Proposal 3) applies only when tau(U) > mu_s (conservative branch). For low c, tau(U) may be on the aggressive branch and the formula doesn't apply.

3. **The proof uses cav v(p,U) = S_U * p for p <= mu***. This equality (not just inequality) relies on v(mu,U)/mu having a global maximum at mu*, which follows from the strictly decreasing ratio on the conservative branch. But if there's a local maximum on the aggressive branch that exceeds the conservative-branch maximum, the equality could break. Numerical evidence suggests the conservative branch always dominates, but this should be verified analytically.
