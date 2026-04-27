# CR8: Decomposition of Unanimity Advantage — v2

**Date**: 2026-04-26
**Status**: DRAFT v2 — corrects all errors from v1

## Key insight from v1 review

The v1 decomposition (entry channel vs. screening channel) failed because:
1. τ(M) = 0 for Example 2, making S_M undefined
2. μ_s^R1 < τ(U) for Example 2, so the screening jump is invisible in v(μ, U)
3. The counterfactual v_flat conflated the entry jump with screening

## Better decomposition: screening + BP amplification

The paper's "dual exploitation" is screening + BP. The natural decomposition follows this structure.

### Setup

For any prior p, the total advantage of unanimity is:

$$\Pi^*_H(U,p) - \Pi^*_H(M,p) = \operatorname{cav} v(p, U) - \operatorname{cav} v(p, M)$$

Under majority, v(μ, M) = (λ_M - α) V_e(μ) is affine on E_M. BP cannot improve an affine function:

$$\operatorname{cav} v(p, M) = \begin{cases} v(p, M) & \text{if } p \in E_M \\ S_M \cdot p & \text{if } p < \tau(M) \text{ and } \tau(M) > 0 \end{cases}$$

When τ(M) = 0 (as in Example 2), cav v(p, M) = v(p, M) for all p. BP is useless under majority.

### Decomposition for p ∈ E_U (entry under both rules)

Since E_U ⊆ E_M (Theorem 1 proof), entry occurs under both rules. Write:

$$\operatorname{cav} v(p, U) - v(p, M) = \underbrace{[v(p, U) - v(p, M)]}_{\text{screening advantage } D(p)} + \underbrace{[\operatorname{cav} v(p, U) - v(p, U)]}_{\text{BP amplification}}$$

**Screening advantage** D(p): The conditional payoff difference from Lemma 1. Positive for all μ ∈ (0,1] when α < α*. This advantage exists even without BP — it is the direct gain from the screening structure under unanimity. Closed form: D(μ) = D_base(μ) + corrections (Appendix B.5).

**BP amplification**: The additional gain from optimal information design. Non-negative by definition of concavification. Equals zero whenever v(·, U) is concave at p. Strictly positive only when BP can exploit a non-convexity in v(·, U) within E_U.

### When is BP amplification zero on E_U?

When the screening jump at μ_s^R1 lies below τ(U) — i.e., when μ_s^R1 < τ(U) — the function v(μ, U) is affine on the entry set E_U (it's entirely on the conservative branch). In this case, v(·, U) is already concave on E_U, and:

$$\operatorname{cav} v(p, U) = v(p, U) \quad \text{for } p \in E_U$$

The BP amplification is exactly zero. The ENTIRE advantage on E_U is the screening advantage D(p).

This is precisely the case in Example 2: μ_s^R1 ≈ 0.197 < τ(U) ≈ 0.33.

### When is BP amplification positive on E_U?

When μ_s^R1 ∈ (τ(U), 1) — i.e., when the screening jump is visible in the entry set — v(μ, U) has a non-convexity at μ_s^R1 that BP can exploit. The concavification creates a pooling region around the jump, and the BP amplification is strictly positive for priors in the pooling region.

### Decomposition for p < τ(U) (entry requires BP)

Here v(p, U) = 0 and the entire unanimity payoff comes from BP:

$$\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M) = \operatorname{cav} v(p, U) - \operatorname{cav} v(p, M)$$

The screening advantage D(p) is not directly applicable (entry doesn't occur at p without BP). But BP under unanimity works by creating a Bayes-plausible split: mass at μ = 0 (no entry) and mass at some μ* ∈ E_U (entry, where D(μ*) > 0). The hegemon's gain from this split:

$$\operatorname{cav} v(p, U) = \frac{p}{\mu^*} \cdot v(\mu^*, U)$$

where μ* is the tangent point (optimally chosen). The gain exists because v(μ*, U) > 0 and the ratio v(μ*)/μ* is large — driven by the entry jump at τ(U) and, when visible, the screening jump at μ_s^R1.

Under majority (if τ(M) = 0): cav v(p, M) = v(p, M) = (λ_M - α) V_e(p) > 0. Majority doesn't need BP because entry always occurs.

So the advantage at low priors is:

$$\Delta(p) = \frac{p}{\mu^*} v(\mu^*, U) - (\lambda_M - \alpha) V_e(p)$$

The first term reflects the "BP under unanimity" payoff; the second is the "majority without BP" payoff.

## Numerical illustration: Example 2

Parameters: N=5, r=1.5, α=0.3, β=0.9, c=0.14.

Key values (from verification report):
- μ_s^R1 ≈ 0.197, μ_s^R2 ≈ 0.125
- τ(U) ≈ 0.33, τ(M) = 0
- v(τ(U), U) ≈ 0.256
- v(1, U) ≈ 0.174, v(1, M) ≈ 0.134
- D(1) ≈ 0.040
- S_U = v(τ(U))/τ(U) ≈ 0.774
- λ_M - α ≈ 0.090

**For p ∈ E_U** (p ≥ 0.33):
- BP amplification = 0 (μ_s^R1 < τ(U), so v is affine on E_U)
- Total advantage = D(p) (pure screening)
- At p = 0.50: D(0.50) = v(0.50, U) - v(0.50, M) [to be computed numerically]
- At p = 1: D(1) ≈ 0.040

**For p < τ(U)** (p < 0.33):
- cav v(p, U) = S_U · p ≈ 0.774p
- cav v(p, M) = v(p, M) = 0.090(1 + 0.5p) = 0.090 + 0.045p
- Δ(p) = 0.774p - 0.090 - 0.045p = 0.729p - 0.090
- Δ(p) > 0 iff p > 0.090/0.729 ≈ 0.123
- NOTE: paper claims p* ≈ 0.24. Discrepancy needs numerical verification with R code.

**Interpretation**: For Example 2, the advantage on E_U is 100% screening (D(p)). For low priors, BP under unanimity exploits the entry jump at τ(U), creating value by inducing entry at beliefs where the screening advantage kicks in. The screening structure is the ultimate source of the gain; BP is the delivery mechanism.

## Proposed Remark for the paper

\begin{remark}[Decomposition of the unanimity advantage]\label{rem:decomposition_quant}
For $p \in E_U$, the advantage of unanimity decomposes as
$$\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M) = D(p) + [\operatorname{cav} v(p, U) - v(p, U)],$$
where $D(p) > 0$ is the screening advantage from Lemma \ref{lem:conditional} and the second term is the BP amplification. Under majority, $v(\cdot, M)$ is affine and persuasion cannot improve it; under unanimity, the screening structure can create non-convexities that persuasion exploits.

The relative weight of the two components depends on whether the screening cutoff $\mu_s^{R1}$ lies inside or outside the entry set. When $\mu_s^{R1} < \tau(U)$, the net-gain function $v(\cdot, U)$ is affine on $E_U$: BP amplification is zero and the entire advantage is the screening payoff difference $D(p)$. When $\mu_s^{R1} \in (\tau(U), 1)$, the screening jump creates an additional non-convexity that persuasion exploits, making BP amplification strictly positive.

For priors below $\tau(U)$, entry does not occur without persuasion. The hegemon uses BP to induce entry at posteriors where the screening advantage is active. In this region, the screening structure is the source of the gain; Bayesian persuasion is the delivery mechanism.
\end{remark}

## Items to verify

1. Compute D(p) numerically for Example 2 at p = 0.4, 0.5, 0.7, 1.0 to include in the Remark
2. Verify p* ≈ 0.24 vs. analytical p* ≈ 0.123 — resolve discrepancy
3. Find parameters where μ_s^R1 > τ(U) to illustrate the BP amplification > 0 case
4. Confirm that D(p) from Lemma 1 matches v(p,U) - v(p,M) computed from model_functions.R

---

# Verification Report (2026-04-26)

**Reviewer**: Claude Opus 4.6 (rigorous mathematical verification)
**Script**: `scripts/verify_decomposition_v2.R` (saved; needs Bash permission to run)
**Method**: Hand computation tracing model_functions.R exactly, supplemented by analytical derivation of closed-form expressions for v(μ, R) on each branch.

## 1. Derived quantities (Example 2: N=5, r=1.5, α=0.3, β=0.9, c=0.14)

| Quantity | Value | Source |
|----------|-------|--------|
| q (majority threshold) | 3 | floor(5/2)+1 |
| x = (N-1)αr | 1.8 | |
| μ_s^R2 | 0.125 | α(r-1)/(r-α) |
| φ | 5.6667 | [rN - β(N-1+r)] / [β(r-1)] |
| μ_s^R1 | **0.1970** | (φ - sqrt(φ²-12))/6 |
| α* | 0.4737 | β(q-1)/[N(N-1)-β(N²-N-q+1)] |
| α < α*? | YES | 0.3 < 0.4737 |
| C_buy | 1.26 | β(q-1)(1-α) |
| C_out | 6.0 | N(N-1)α |
| λ_M | 0.3896 | [N(1+(N-1)α)-C_buy]/N² |
| λ_M - α | **0.0896** | |
| κ_M | 0.1526 | (1-α)[N(N-1)+β(q-1)]/(N²(N-1)) |
| τ(M) | **0** | max(0, (c/κ_M - 1)/(r-1)) = max(0, -0.165) |
| τ(U) | **0.3305** | from conservative branch formula: [cN² - (N+β-βr(1+Nα))] / [(N+β)(r-1)] |
| μ_s^R1 < τ(U)? | **YES** | 0.197 < 0.331 |

## 2. Analytical closed forms for v(μ, R) on E_U

Since μ_s^R1 = 0.197 < τ(U) = 0.331, the entry set E_U lies entirely on the conservative R1 branch (and above μ_s^R2). On this branch:

**v(μ, U) = 0.296 − 0.122μ** (affine, decreasing)

Derivation (conservative branch, μ > μ_s^R2 so VW_R2 = (Ve − αr)/N):

EVH_con = Ve/N − (N−1)β(Ve − αr)/N² + (N−1)β(r+x)/N²
= Ve/N + (N−1)β[αr + r + x − Ve]/N²
= 0.2·Ve + 0.144·[3.75 − Ve]
= 0.056·Ve + 0.54

v_con(μ) = EVH_con − α·Ve = −0.244·Ve + 0.54 = −0.244·(1 + 0.5μ) + 0.54 = **0.296 − 0.122μ**

Check: v(1) = 0.174. ✓  Check: v(0.3305) = 0.2557. ✓

**v(μ, M) = (λ_M − α)·Ve(μ) = 0.0896·(1 + 0.5μ)**

Check: v(1, M) = 0.1344. D(1) = 0.174 − 0.1344 = 0.0396. ✓

## 3. Payoffs at selected beliefs

| μ | v(μ,U) | v(μ,M) | D(μ) | VH_U | VH_M |
|---|--------|--------|------|------|------|
| 0.33 | 0.256 | 0.104 | 0.152 | 0.605 | 0.454 |
| 0.40 | 0.247 | 0.108 | 0.139 | 0.607 | 0.468 |
| 0.50 | 0.235 | 0.112 | 0.123 | 0.610 | 0.487 |
| 0.70 | 0.211 | 0.121 | 0.090 | 0.616 | 0.526 |
| 1.00 | 0.174 | 0.134 | 0.040 | 0.624 | 0.584 |

Note: D(μ) **decreases** with μ on E_U. This is expected: at higher beliefs, screening rents are smaller (less asymmetric information). D(μ) = (0.296 − 0.0896) − (0.122 + 0.0448)μ = 0.2064 − 0.1668μ.

## 4. Concavification and S_U

Since v(μ, U) is affine-decreasing on E_U = [τ(U), 1], and v = 0 below τ(U):
- The concavification from μ = 0 is a line from (0, 0) to the steepest tangent point.
- For an affine-decreasing function v(μ) = a + bμ (b < 0) on [τ, 1] with v = 0 below τ:
  - v(μ)/μ = a/μ + b is strictly decreasing, so the max is at μ = τ.

**S_U = v(τ(U)) / τ(U) = 0.2557 / 0.3305 = 0.7737**

For μ < τ(U): cav v(μ, U) = S_U · μ ≈ 0.7737μ
For μ ≥ τ(U): cav v(μ, U) = v(μ, U) (since v is concave = affine on E_U)

## 5. BP amplification on E_U (Example 2)

For p ∈ E_U = [0.331, 1]:
- cav v(p, U) = v(p, U) (affine, already concave)
- BP amplification = cav v(p, U) − v(p, U) = **0** for all p ∈ E_U

The proposal's claim is **CORRECT**: when μ_s^R1 < τ(U), BP amplification is zero on E_U and the entire advantage is D(p).

## 6. Decomposition identity check

For p ∈ E_U:
cav v(p, U) − cav v(p, M) = [v(p, U) − v(p, M)] + [cav v(p, U) − v(p, U)]
                            = D(p) + 0 = D(p)

| p | LHS = D(p)+BP | D(p) | BP amp | Identity holds? |
|---|---------------|------|--------|-----------------|
| 0.40 | 0.139 | 0.139 | 0 | ✓ |
| 0.50 | 0.123 | 0.123 | 0 | ✓ |
| 0.70 | 0.090 | 0.090 | 0 | ✓ |
| 1.00 | 0.040 | 0.040 | 0 | ✓ |

## 7. Resolution of the p* discrepancy — CRITICAL FINDING

**The paper claims p* ≈ 0.24. The correct value is p* ≈ 0.123.**

### Derivation

For p < τ(U):
- cav v(p, U) = S_U · p = 0.7737 · p
- cav v(p, M) = v(p, M) = (λ_M − α) · Ve(p) = 0.0896 · (1 + 0.5p)

(Note: τ(M) = 0, so cav v(p, M) = v(p, M) for all p.)

Setting cav v(p, U) = cav v(p, M):
0.7737p = 0.0896 + 0.0448p
0.7289p = 0.0896
**p* = 0.0896 / 0.7289 = 0.1229**

### Why the paper says 0.24

The value 0.24 in Example 2 (formal_model_v4.Rmd, line 563) appears to be a numerical error. Possible sources:
1. An older model specification (with participation benefit g, or different VH formula).
2. A coding bug in a prior computation session that was not caught.
3. Confusion between p* and τ(U) (τ(U) ≈ 0.33 is not 0.24 either, so this is unlikely).

The analytical derivation is unambiguous: with the current model functions and Example 2 parameters, p* = 0.123 ± 0.001.

### Implications

The paper text at line 563 should be corrected:
- "The threshold is $p^* \approx 0.24$" → "The threshold is $p^* \approx 0.12$"
- "Below it, majority dominates" → logic unchanged, just different threshold
- "at $p = 0.30$, the hegemon's payoff under unanimity exceeds majority by $22\%$" — need to recompute
- "at $p = 0.50$, by $25\%$" — this is still approximately correct since p=0.50 ∈ E_U

Let me verify the percentage claims:
- At p = 0.30: p > p* but p < τ(U). cav v(U) = 0.7737·0.30 = 0.2321. v(M) = 0.0896·1.15 = 0.1030. Π_H*(U) = αVe + 0.2321 = 0.345 + 0.2321 = 0.577. Π_H*(M) = αVe + 0.1030 = 0.345 + 0.1030 = 0.448. Advantage: 0.577/0.448 − 1 = 28.8%.
- At p = 0.50: v(U) = 0.235, v(M) = 0.112. Π_H*(U) = 0.375 + 0.235 = 0.610. Π_H*(M) = 0.375 + 0.112 = 0.487. Advantage: 0.610/0.487 − 1 = 25.3%. ✓ (paper says 25%)

The percentage at p=0.30 should be updated to ~29%, and the overall narrative that "above p*, unanimity dominates" still holds — just with a lower threshold.

## 8. Parameters where BP amplification > 0

**Found: N=5, r=1.5, α=0.3, β=0.9, c=0.05**

Key values:
- μ_s^R1 = 0.197 (unchanged — independent of c)
- τ(U) ≈ 0 (conservative branch: formula gives negative threshold)
- τ(M) = 0

Since τ(U) < μ_s^R1, the jump is visible inside E_U.

### v(μ, U) structure with c = 0.05

v(μ, U) has three segments:

| Branch | μ range | Formula | Slope |
|--------|---------|---------|-------|
| Aggressive, low R2 | (0, 0.125) | 0.2024 + 0.1228μ | +0.123 |
| Aggressive, high R2 | (0.125, 0.197) | 0.224 − 0.050μ | −0.050 |
| Conservative | (0.197, 1) | 0.296 − 0.122μ | −0.122 |

The upward jump at μ_s^R1: v_con(0.197) − v_agg(0.197) = 0.272 − 0.214 = **0.058**.

### Concavification with c = 0.05

From (0.001, 0.2025), the concavify algorithm finds the steepest slope is toward the start of the conservative branch at μ ≈ 0.198:
- slope ≈ (0.272 − 0.2025)/0.197 = 0.354

The concave envelope:
- For μ ∈ [0.001, 0.198]: cav v = 0.2025 + 0.354·(μ − 0.001) (line to conservative branch)
- For μ ∈ [0.198, 1.0]: cav v = v_con(μ) = 0.296 − 0.122μ

### BP amplification

At μ = 0.10:
- v(0.10) = 0.2024 + 0.1228·0.10 = 0.215
- cav v(0.10) = 0.2025 + 0.354·0.099 = 0.237
- **BP amplification = 0.022**

At μ = 0.15 (just above μ_s^R2, on the declining part of aggressive branch):
- v(0.15) = 0.224 − 0.05·0.15 = 0.2165
- cav v(0.15) = 0.2025 + 0.354·0.149 = 0.255
- **BP amplification = 0.039**

At μ = 0.197 (just below jump):
- v_agg(0.197) = 0.214
- cav v(0.197) = 0.2025 + 0.354·0.196 = 0.272
- **BP amplification = 0.058** (= full jump magnitude)

On E_U with c = 0.05, BP amplification is positive in the range [0, μ_s^R1] where the concave envelope lies above the aggressive branch.

## 9. Check of the Remark text

The proposed Remark (lines 103–111 of the proposal) is **mathematically correct** with one important qualification:

1. **Identity**: "cav v(p,U) − cav v(p,M) = D(p) + [cav v(p,U) − v(p,U)]" — CORRECT. This is a tautology (add and subtract v(p,U)).

2. **D(p) > 0 from Lemma 1**: CORRECT. D(p) = v(p,U) − v(p,M) > 0 for all p ∈ E_U when α < α*.

3. **BP amplification ≥ 0**: CORRECT. By definition of concavification.

4. **"When μ_s^R1 < τ(U), v(·,U) is affine on E_U"**: **CORRECT with qualification**. It is affine because E_U lies entirely on the conservative branch. However, the Remark says "affine on the entry set E_U" — this is precisely correct only if E_U is connected (an interval). With the jump in VW, E_U could theoretically be disconnected. But when μ_s^R1 < τ(U), the entry set starts above the jump, so E_U ⊆ [τ(U), 1] is a single interval on the conservative branch. Correct.

5. **"When μ_s^R1 ∈ (τ(U), 1), the screening jump creates an additional non-convexity"**: CORRECT. Verified with c = 0.05 above.

6. **"For priors below τ(U), [...] screening structure is the source of the gain; BP is the delivery mechanism"**: CORRECT. The concavification slope S_U = v(τ(U))/τ(U) is driven by the level of v at the entry point, which reflects the screening advantage. BP acts as a delivery mechanism by splitting the prior into posteriors at 0 (no entry) and μ* ∈ E_U (entry where screening operates).

**No incorrect claims found in the Remark.**

## 10. Additional findings

### Numerical values from the proposal (line 78–84)

| Claim | Proposal value | Verified value | Status |
|-------|---------------|----------------|--------|
| μ_s^R1 ≈ 0.197 | 0.197 | 0.1970 | ✓ |
| μ_s^R2 ≈ 0.125 | 0.125 | 0.125 | ✓ |
| τ(U) ≈ 0.33 | 0.33 | 0.3305 | ✓ |
| τ(M) = 0 | 0 | 0 | ✓ |
| v(τ(U), U) ≈ 0.256 | 0.256 | 0.2557 | ✓ |
| v(1, U) ≈ 0.174 | 0.174 | 0.174 | ✓ |
| v(1, M) ≈ 0.134 | 0.134 | 0.1344 | ✓ |
| D(1) ≈ 0.040 | 0.040 | 0.0396 | ✓ |
| S_U ≈ 0.774 | 0.774 | 0.7737 | ✓ |
| λ_M − α ≈ 0.090 | 0.090 | 0.0896 | ✓ |

### Proposal line 94–97 (crossing computation)

The proposal itself computes p* ≈ 0.123 (line 96) but then flags the discrepancy with the paper's p* ≈ 0.24 (line 97). The proposal's own p* = 0.123 is **correct**. The paper's p* = 0.24 is **wrong**.

## Summary and grade

### What is correct

1. The decomposition identity cav v(p,U) − cav v(p,M) = D(p) + BP_amp is correct.
2. When μ_s^R1 < τ(U) (Example 2), BP amplification = 0 on E_U and the full advantage is D(p). ✓
3. When μ_s^R1 > τ(U) (e.g., c = 0.05), BP amplification > 0 on a pooling region. ✓
4. The Remark text is mathematically correct. ✓
5. All numerical values in the proposal (except p*) are correct. ✓

### What needs fixing

1. **p* = 0.123, not 0.24.** The paper (formal_model_v4.Rmd, lines 561–565) must be corrected. This is a HIGH severity error since the Example anchors the reader's intuition for the main theorem.

2. **Percentages at p = 0.30 need rechecking.** With p* ≈ 0.12, p = 0.30 is well above the crossing, and the unanimity advantage at p=0.30 is ~29% (not 22% as the paper claims). The paper's 22% was presumably computed consistently with the wrong p* = 0.24 model version.

3. **The description at p < τ(U) in the proposal (lines 93–97) implicitly assumes cav v(p,M) = (λ_M − α)Ve(p) for all p.** This is correct when τ(M) = 0 (as in Example 2), but should be stated explicitly as a condition.

### Recommended actions

- Fix p* in Example 2 of the paper: p* ≈ 0.12 (or compute to greater precision via R code)
- Recompute the advantage percentages at p = 0.30 and p = 0.50
- Run the R verification script (`scripts/verify_decomposition_v2.R`) to machine precision — it has been written and saved but not executed due to Bash permission restriction
- The Remark text is ready to insert into the paper after fixing the numerical example

### Grade: **A-**

The decomposition logic and Remark text are correct (would be A+). The grade is reduced to A- because:
- The p* = 0.24 claim in the paper is incorrect and the proposal flagged this but did not resolve it (the resolution is now clear: p* = 0.123).
- The R script was written but could not be executed to machine precision. The hand computations above are precise to 3-4 significant figures, which is sufficient for verification but not publication-quality.

Once the R script is run and p* is confirmed computationally, and the paper text is corrected, the grade elevates to A+.
