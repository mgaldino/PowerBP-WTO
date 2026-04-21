# Stage 1: Code Review -- formal_model_v2.Rmd (Round 5 -- Final Verification)

**Date**: 2026-04-21  
**Reviewer**: Claude Opus 4.6 (automated)  
**File reviewed**: `formal_model_v2.Rmd`  
**Bib file**: `references.bib`  
**Starting score**: 100  
**Purpose**: Verify ALL fixes from Rounds 2-4 are consistent with each other.

---

## Verification Checklist

### 1. Lemma 1 Statement: alpha < alpha*(N, beta) with formula -- PASS

Lines 481-490. Lemma now reads:

> Define the threshold alpha*(N, beta) = beta*(q-1) / [N(N-1) - beta*(N^2 - N - q + 1)], q = floor(N/2) + 1.  
> For alpha < alpha*(N, beta) and every mu in (0,1), E[V_H(U)] > E[V_H(M)].

Formula verified numerically: at N=5, beta=0.9, alpha* = 0.4737. Consistent with the R code `alpha_star()` function (lines 606-609).

### 2. Theorem 1 Statement: "Suppose alpha < alpha*" -- PASS

Line 526: `Suppose $\alpha < \alpha^*(N, \beta)$`. Condition is stated at the very beginning of the theorem. Step 2 references Lemma 1 (which carries the condition). Correctly qualified.

### 3. Lemma 1 Proof -- Main Text (lines 492-508) -- PASS

- **F-channel**: Correctly uses `q-1 = floor(N/2)` for majority and `N-1` for unanimity (lines 497, 499-501).
- **G-channel**: Correctly uses `G(mu, M) = (N-1)/N * alpha * V_e(mu)` for majority (lines 497, 505). No longer uses the wrong unanimity formula.
- **Combining**: References alpha*(N, beta) condition. Mentions numerical verification. Notes that for alpha >= alpha*, F-channel disadvantage can dominate near mu=1.

All formulas match the R code.

### 4. Lemma 1 Proof -- Appendix B.5 (lines 792-802) -- PASS

Mirror of the main text proof with same correct formulas:
- F-channel: `q-1` for majority, `N-1` for unanimity.
- G-channel: `alpha * V_e(mu)` for majority, `beta*(Ve+x)/N^2` and `beta*(r+x)/N^2` for unanimity.
- Combining: References alpha*(N, beta) condition.

Consistent with main text proof.

### 5. Figure 2: Alpha range restricted to below alpha* -- PASS

- Line 613: `alphas <- seq(0.05, min(0.45, a_star_val - 0.025), by = 0.025)` -- ensures alpha stays below alpha*.
- Line 620: `if (alphas[j] < 1/rs[i] & alphas[j] < a_star_val)` -- double guard in the inner loop.
- Line 635: `abline(h = a_star_val, ...)` -- alpha* line drawn on the plot.
- Line 636-639: Legend includes alpha* entry.
- Figure caption (line 561) states: "restricted to alpha < alpha*(N, beta) (the domain where Lemma 1 applies)".

All consistent.

### 6. Scope Conditions: alpha* threshold mentioned -- PASS

Line 690: "By Lemma 1, for alpha < alpha*(N, beta), majority can never dominate through a higher conditional-on-entry payoff." Also explains what happens for alpha >= alpha*: "majority can also dominate through conditional bargaining payoffs near mu = 1."

### 7. Budget Identity -- Appendix A.6 (line 771) and Section 8.2 (line 514) -- PASS

**A.6**: Correctly distinguishes majority (exact) from unanimity (exact on conservative, inequality on aggressive). States the surplus destruction formula: `E[VH] + (N-1)VW = Ve - (N-1)*mu*r*(1-beta)/N`.

**Section 8.2**: "Under unanimity, the budget identity holds exactly on the conservative R1 branch and with inequality E[VH] + (N-1)VW <= Ve(mu) on the aggressive branch (due to surplus destruction from discounting when theta=1 rejects)."

Numerical verification at alpha=0.3, r=1.5, N=5, beta=0.9:

| mu   | Branch       | Surplus loss (actual) | Surplus loss (formula) | Match  |
|------|--------------|-----------------------|------------------------|--------|
| 0.05 | Aggressive   | 0.006000              | 0.006000               | TRUE   |
| 0.10 | Aggressive   | 0.012000              | 0.012000               | TRUE   |
| 0.15 | Aggressive   | 0.018000              | 0.018000               | TRUE   |
| 0.30 | Conservative | 0.000000              | (exact)                | TRUE   |
| 0.50 | Conservative | 0.000000              | (exact)                | TRUE   |
| 0.90 | Conservative | 0.000000              | (exact)                | TRUE   |

### 8. All R Code Functions -- PASS

**VH_R1_majority** (lines 385-395):
- Uses `q <- floor(N/2) + 1` correctly.
- H proposes: `(Ve - (q-1)*beta*VW_R2_M)/N` -- buys q-1 votes. Correct.
- W proposes: `(N-1)/N * alpha * Ve` -- H not pivotal, gets alpha*V(theta). Correct.
- Budget balances exactly for all mu tested (gap = 0.000000).

**VW_R1_majority** (lines 352-358):
- Derives VW from budget identity: `(Ve - EVH) / (N-1)`. Correct.

**VH_R1_unanimity** (lines 360-383):
- Aggressive branch: VH_0 uses (1+x)/N, VH_1 uses (r+x)/N. Both verified from first principles.
- Conservative branch: Both types use (r+x)/N. Correct (theta=1 indifferent, theta=0 overpaid).
- H_prop_0 and H_prop_1 correctly use `(N-1)*beta*VW_R2` for vote-buying cost.

**VW_R1_unanimity** (lines 327-350):
- Aggressive non-proposer: correctly splits into theta=0 (deal passes, gets beta*VW_R2) and theta=1 (rejection, R2 with mu=1, gets beta*VW_R2_1). Verified from first principles.
- Conservative non-proposer: `(N-1)/N * beta * VW_R2` -- all deals pass. Correct.

**concavify** (lines 416-444):
- Gift-wrapping algorithm. Tested on 3 known cases (concave parabola, V-shape, step function). All pass with zero error.

**Lemma 1 numerical verification** at alpha=0.3, N=5, beta=0.9:
- EVH(U) > EVH(M) for ALL mu in {0.05, 0.15, ..., 0.95}. Minimum difference = 0.0479 at mu=0.95. PASS.

### 9. Citations -- PASS

All 12 citation keys in the Rmd file have matching entries in references.bib:
- `@baron1989bargaining`, `@blake2015balancing`, `@crawford1982strategic`, `@eraslan2019legislative`, `@fearon1995rationalist`, `@kalandrakis2006proposal`, `@kamenica2011bayesian`, `@kamenica2019bayesian`, `@keohane1984after`, `@koremenos2001rational`, `@maggi2006selfenforcing`, `@steinberg2002shadow`.

One bib entry (`schnakenberg2017informational`) is unused in the paper. This is harmless.

### 10. Cross-References -- PASS

**Bookdown `\@ref()`**:
- `\@ref(fig:bp-illustration)` -> chunk `bp_illustration` (line 324). Correct (bookdown auto-converts underscore to hyphen).
- `\@ref(fig:parameter-regions)` -> chunk `parameter_regions` (line 561). Correct.
- `\@ref(comparison)` -> `{#comparison}` (line 473). Correct.
- `\@ref(extension)` -> `{#extension}` (line 666). Correct.

**LaTeX `\ref{}`**:
- `\ref{prop:majority}` -> `\label{prop:majority}` (line 176). OK.
- `\ref{prop:jump}` -> `\label{prop:jump}` (line 255). OK.
- `\ref{lem:conditional}` -> `\label{lem:conditional}` (line 481). OK (referenced 5 times).

All 20 labels defined, all references resolve. No orphan references.

---

## Remaining Minor Issues (Carried from Round 4)

### Issue 1 (Minor): Insufficient inline comments in VH_R1_unanimity

Lines 360-383. No branch comments. VW_R1_unanimity has comments at lines 341 ("Aggressive: theta=1 rejects, R2 with mu=1") and 345 ("Conservative: all deals pass"), but VH_R1_unanimity has none.

**Deduction**: -1

### Issue 2 (Minor): Duplicated VW_R2/omega computation

Lines 328-338 (VW_R1_unanimity) and 361-371 (VH_R1_unanimity) contain identical code. Could be extracted to a helper function.

**Deduction**: -1

### Observation (No deduction): Abstract/intro omit alpha* condition

The abstract (line 35) says "unanimity gives the hegemon a strictly higher conditional-on-entry payoff than majority for all interior beliefs" and the introduction (line 56) similarly. Neither mentions alpha < alpha*. However, this is standard practice for abstracts (parametric conditions are not typically stated there), and the formal statements (Lemma 1, Theorem 1) are correctly qualified. No deduction.

---

## Score Calculation

| # | Severity | Issue | Deduction |
|---|----------|-------|-----------|
| 1 | Minor | Insufficient inline comments in VH_R1_unanimity (carried from R4) | -1 |
| 2 | Minor | Duplicated VW_R2/omega computation (carried from R4) | -1 |

---

## Final Score

**Starting**: 100  
**Deductions**: -1 (comments) -1 (duplication) = -2  
**Final**: **98/100**

---

## Verdict: APROVADO

All critical fixes from Rounds 2-4 are verified and mutually consistent:

1. The alpha* condition flows correctly from Lemma 1 (definition) -> Theorem 1 (assumption) -> Scope (discussion) -> Figure 2 (restriction).
2. The majority formulas (q-1 votes, alpha*Ve outside option) are correct everywhere: code, main text proof, appendix proof.
3. Budget identities balance exactly (majority, unanimity conservative) and with the correct surplus destruction formula (unanimity aggressive).
4. All four R functions produce numerically consistent results.
5. The concavify function passes all test cases.
6. All citations resolve. All cross-references are valid.

The remaining issues are cosmetic (inline comments, code duplication) and do not affect correctness or reproducibility.
