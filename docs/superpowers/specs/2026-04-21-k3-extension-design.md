# Spec: Appendix D — Robustness to K > 2 Types (K=3)

**Status**: APPROVED
**Date**: 2026-04-21
**Context**: Referee's single most important revision request. Demonstrate that the screening mechanism and comparative institutional result survive with K > 2 types. Focused on K=3 with analytical scaffold and numerical verification. Appendix only.

## Objective

Write Appendix D for `formal_model_v2.Rmd` showing that:
1. K=3 types produce 2 screening cutoffs (K-1 in general)
2. The non-convexity structure is richer (2 jumps instead of 1)
3. The conditional payoff dominance (Lemma 1 analog) holds
4. The comparative institutional result (Theorem 1 pattern) survives under BP on the 2-simplex

## Model specification (K=3)

Identical to the main model except the type space:
- Types: theta in {0, 1, 2} with V(0) = 1, V(1) = r1, V(2) = r2, where 1 < r1 < r2
- Prior: p = (p0, p1, p2) in Delta^2 (the 2-simplex)
- H observes theta; W's do not
- Disagreement: H gets alpha * V(theta), W gets 0
- Constraint: alpha in (0, 1/r2) — ensures bilateral alternatives are dominated by multilateral cooperation for all types
- N players, discount beta, 2-round Baron-Ferejohn, random proposer 1/N
- Majority threshold q = floor(N/2) + 1

Numerical baseline: r1 = 1.5, r2 = 2.5, N = 5, alpha = 0.3, beta = 0.9, c = 0.1.

## Appendix structure

### D.1 Setup (~0.5 page)

State the K=3 model. Notation: mu = (mu0, mu1, mu2) for posteriors, p for prior. Define V_e(mu) = sum_k mu_k V(theta_k). Note that K=2 is a special case.

No new conceptual content — just the extension of notation.

### D.2 R2 screening under unanimity (~1 page, analytical)

**Content:**
- W faces 3 relevant offers: y_H in {alpha, alpha*r1, alpha*r2}
- Offer k (targeting type theta_k): accepted by types j <= k, rejected by j > k
- W's expected payoff from offer k: sum_{j<=k} mu_j [V(theta_j) - alpha*V(theta_k)]

**Proposition D.1** (General K): For K ordered types with values v1 < ... < vK, the R2 screening boundary between offer k and offer k+1 is characterized by:

    mu_{k+1} / sum_{j<=k} mu_j = alpha * (v_{k+1} - v_k) / [v_{k+1} * (1 - alpha)]

This defines K-1 hyperplanes partitioning Delta^{K-1} into K regions.

**Proof:** Direct algebra from equating payoffs of adjacent offers. Verify that for K=2 this reduces to mu_s^{R2} = alpha(r-1)/(r-alpha) from the main model.

**R2 continuation values:** Closed-form expressions for V_H^{R2}(theta_k, mu) and V_W^{R2}(mu) in each of the 3 regions. Structure:
- H proposes (prob 1/N): offers 0 to all W, keeps V(theta). Same under all regions.
- W proposes (prob (N-1)/N): payoff depends on which offer W makes (determined by region).

For each type theta_k and each screening region:
- V_H^{R2}(theta_k, region) has closed form involving alpha, r1, r2, N
- The overpayment pattern generalizes: type theta_0 gets more than alpha*V(0) when W plays medium or high offer

### D.3 R1 screening under unanimity (~1.5 pages, analytical structure + numerical cutoffs)

**Content:**
W faces 3 R1 strategies:
- **High offer**: y_H = beta * V_H^{R2}(theta=2, mu). All types accept. Game ends.
- **Medium offer**: y_H = beta * V_H^{R2}(theta=1, mu_post). Types 0,1 accept; type 2 rejects -> R2 with theta=2 certain (deterministic continuation).
- **Low offer**: y_H = beta * V_H^{R2}(theta=0, mu_post). Only type 0 accepts; types 1,2 reject -> R2 with updated beliefs on {1,2}.

**Key structural observation:** The low-offer rejection leads to a 2-type R2 subgame on {theta_1, theta_2}, which is exactly the K=2 screening problem already solved in the main model. This gives recursive tractability.

**Analytical derivation:**
- Express W's expected payoff from each R1 strategy as a function of mu
- The payoff expressions involve V_W^{R2}(mu) from D.2 and the post-rejection continuation values
- Post-rejection beliefs:
  - After medium rejection: mu_post = (0, 0, 1) — deterministic
  - After low rejection: mu_post = (0, mu1/(mu1+mu2), mu2/(mu1+mu2)) — 2-type subgame

**Indifference boundaries:**
- Between low and medium: a surface in Delta^2
- Between medium and high: another surface in Delta^2

These are characterized analytically (the payoff expressions are explicit), but the exact cutoff surfaces are found **numerically** because the expressions involve piecewise R2 continuation values that make closed-form solutions intractable.

**Result:** The simplex is partitioned into 3 R1 regions. At each boundary, V_H jumps upward:
- Jump 1 (low -> medium): type theta_0 gets overpaid (offered medium reservation instead of low)
- Jump 2 (medium -> high): types theta_0 and theta_1 get overpaid

The jump magnitudes generalize the formula from Proposition 5 of the main model.

### D.4 Majority: no screening (~0.5 page, analytical)

**Proposition D.2:** Under majority rule with K types, H's expected continuation payoff is affine in E_mu[V(theta)]. No screening cutoff exists for any K.

**Proof:** H is never pivotal under majority. W assembles a coalition from other W's. H receives alpha*V(theta) regardless of beliefs. All continuation values are affine in V_e(mu) = sum mu_k v_k. Identical logic to Proposition 1 of the main model; extends to any K without modification.

**Explicit expression:** V_H^{R1}(mu, M) = lambda_M * V_e(mu), where lambda_M is the same coefficient as in the main model (depends only on N, alpha, beta, q — not on the type distribution).

### D.5 Conditional payoff dominance (~0.5 page, numerical verification)

**Proposition D.3** (Lemma 1 analog): There exists a threshold alpha_3*(N, beta, r1, r2) > 0 (found numerically) such that for alpha < alpha_3*, for all mu in the interior of Delta^2:

    E_theta[V_H^{R1}(theta, mu, U)] > E_theta[V_H^{R1}(theta, mu, M)]

**Verification protocol:**
1. Dense barycentric grid over Delta^2 (~10,000 interior points)
2. At each point, compute V_H(mu, U) and V_H(mu, M)
3. Compute D(mu) = V_H(mu, U) - V_H(mu, M)
4. Report: min D(mu) over grid, mean D(mu), std D(mu)
5. Test multiple parameterizations:
   - Baseline: r1=1.5, r2=2.5, N=5, alpha=0.3, beta=0.9
   - Varying r1, r2 (e.g., r1=1.3, r2=1.8; r1=2.0, r2=3.0)
   - Varying N (3, 5, 7)
   - Varying alpha (0.1, 0.2, 0.3)
   - Varying beta (0.7, 0.8, 0.9)

**Expected result:** D(mu) > 0 everywhere for alpha below a threshold (analogous to alpha* from Lemma 1).

### D.6 Bayesian persuasion on the 2-simplex (~1.5 pages, numerical)

**Value function:** 
v(mu, R) = V_H^{R1}(mu, R) if V_W^{R1}(mu, R) >= c, else 0.

This adds the entry threshold. Under majority, the entry region is a half-space in the simplex (since V_W is affine). Under unanimity, the entry region boundary is piecewise (reflecting the screening regions).

**Concavification algorithm:**
For each grid point p in Delta^2, solve the LP:

    max sum_i w_i * v(mu_i, R)
    s.t. sum_i w_i * mu_i = p  (Bayes plausibility, 3 constraints)
         sum_i w_i = 1
         w_i >= 0

Use lpSolve or Rglpk in R. Grid: ~5,000 points (the LP at each point uses the full grid as support for the distribution tau).

**Primary algorithm (convex hull):**
- Compute v(mu, R) on a dense grid (~10,000 points)
- The concavification is the upper envelope of the convex hull of {(mu0, mu1, v)} in R^3
- Compute convex hull using geometry::convhulln
- For each grid point, find the facet of the upper hull directly above it and interpolate
- This is O(n log n) for the hull + O(n) for evaluation — much faster than LP

**Fallback algorithm (LP):** If the convex hull approach has numerical issues, solve per-point LPs using lpSolve. O(n^2) but more robust.

**Figure:** Ternary heatmap of cav v(p, U) - cav v(p, M) over the simplex.
- Blue: unanimity dominates (cav v(p,U) > cav v(p,M))
- Red: majority dominates
- White: boundary
- Axes labeled: p0, p1, p2

**Expected result:** Blue region dominates for priors with sufficient mass on high types. Red region appears only at low priors (where entry is the binding constraint). The boundary is a curve in the simplex — the 2D analog of the threshold p* from Theorem 1.

**Second figure (include):** v(mu, U) as a 3D surface over the simplex, with the screening jumps visible as ridges. This makes the non-convexity visually apparent. v(mu, M) can be overlaid as a flat plane for comparison.

### D.7 Discussion (~0.5 page)

**General K pattern:**
- K types -> K-1 screening cutoffs in R2 (Proposition D.1 is stated for general K)
- Each cutoff creates a jump in H's value function
- Majority remains linear for any K (Proposition D.2 is stated for general K)
- The non-convexity structure is strictly richer with more types
- The conditional dominance result (D.3) is expected to hold for any K under the same type of parametric condition

**Complexity remark:**
- Full analytical treatment of R1 screening for K > 3 types requires tracking O(K^2) region combinations (K R1 regions x K R2 regions), making closed-form analysis intractable
- Concavification on Delta^{K-1} is a standard but computationally intensive convex optimization problem
- Applied BP papers almost universally use K=2 for this reason (cite KG 2011, Dworczak & Martini 2019)
- The K=3 analysis demonstrates that the mechanism's logic generalizes: more types create more screening opportunities, reinforcing rather than undermining the hegemon's preference for unanimity

## Implementation plan

### Files to create/modify
- [ ] `formal_model_v2.Rmd` — Add Appendix D (LaTeX + R chunks)
- [ ] `scripts/k3_screening.R` — Core functions for K=3 value computation
- [ ] `scripts/k3_concavification.R` — LP-based concavification on the simplex
- [ ] `scripts/k3_verification.R` — Numerical verification of Proposition D.3

### Implementation order
1. **scripts/k3_screening.R**: R2 and R1 value functions for K=3 under both rules
2. **scripts/k3_verification.R**: Grid over simplex, compute D(mu), verify D > 0
3. **scripts/k3_concavification.R**: LP or convex hull based concavification
4. **formal_model_v2.Rmd**: Write appendix text with embedded R chunks for figures
5. Compile and verify

### Dependencies
- R packages: ggtern (or manual ternary plots), lpSolve or Rglpk, geometry (for convhulln)
- Existing code: VH_R1_unanimity, VH_R1_majority from the main paper can be adapted

### Verification
- [ ] R2 cutoffs for K=3 reduce to K=2 cutoff when r1 = r2
- [ ] R1 value functions are continuous within regions, with jumps at boundaries
- [ ] Majority value is exactly affine (numerical check)
- [ ] D(mu) > 0 on dense grid for baseline parameters
- [ ] Concavification satisfies cav v >= v pointwise
- [ ] Concavification is concave (verify on random triples)
- [ ] Heatmap shows expected blue/red pattern
- [ ] Appendix compiles without errors
