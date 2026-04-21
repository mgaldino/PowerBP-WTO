# Stage 1: Code Review -- formal_model_v2.Rmd (Round 4)

**Date**: 2026-04-21  
**Reviewer**: Claude Opus 4.6 (automated)  
**File reviewed**: `formal_model_v2.Rmd`  
**Bib file**: `references.bib`  
**Starting score**: 100

---

## Verification of Round 3 Fixes

### Fix 1: VW_R1_unanimity() non-proposer payoff on aggressive R1 branch (VERIFIED)

Round 3 found that the non-proposer payoff used `(N-1)/N * beta * VW_R2(mu)` for all non-proposer scenarios, ignoring that when another W proposes aggressively and theta=1 rejects, the game moves to R2 with mu=1 (not the original mu). The corrected code (lines 340-343) now correctly handles this:

```r
if (F1_agg > F1_con) {
    # Aggressive: theta=1 rejects, R2 with mu=1
    VW_R2_1 <- r * (1 - alpha) / N
    nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)
}
```

Decomposition verified at mu=0.1:
- H proposes (1/N): nonprop gets `beta*VW_R2(mu) = 0.1134`, weighted by 1/N: 0.02268
- Other W proposes ((N-2)/N): mix of `(1-mu)*beta*VW_R2(mu)` and `mu*beta*VW_R2(1)`, weighted by (N-2)/N: 0.072576
- Total nonprop: 0.095256 (old buggy value was 0.09072, difference = +0.004536)

On the conservative branch (line 346), the formula `(N-1)/N * beta * VW_R2` is correct because all deals pass (no rejection path). Verified by decomposition: 1/N + (N-2)/N = (N-1)/N when all paths yield beta*VW_R2.

**PASS**.

### Fix 2: Budget balance at mu=0.1 (aggressive branch) (VERIFIED)

At mu=0.1, r=1.5, alpha=0.3, N=5, beta=0.9:
- Ve = 1.050
- EVH_U = 0.52968
- VW_U = 0.12708
- EVH + 4*VW = 1.038
- Expected: Ve - (N-1)*mu*r*(1-beta)/N = 1.050 - 0.012 = 1.038
- Gap: 2.2e-16 (machine epsilon). **PASS**.

### Fix 3: Budget balance at mu=0.5 (conservative branch) (VERIFIED)

At mu=0.5, r=1.5, alpha=0.3, N=5, beta=0.9:
- Ve = 1.250
- EVH_U = 0.610
- VW_U = 0.160
- EVH + 4*VW = 1.250 = Ve exactly. **PASS**.

### Fix 4: Majority budget at mu=0.5 (VERIFIED)

- EVH_M = 0.487
- VW_M = 0.19075
- EVH_M + 4*VW_M = 1.250 = Ve exactly. **PASS**.

### Fix 5: Text fixes -- budget identity in Appendix A.6 (VERIFIED)

Line 812 now correctly states:

> "On the aggressive R1 branch, surplus destruction from discounting when theta=1 rejects in R1 and the game proceeds to R2 yields E[V_H] + (N-1)V_W = V_e(mu) - (N-1)*mu*r*(1-beta)/N, so the identity holds with inequality: E[V_H] + (N-1)V_W <= V_e(mu)."

**PASS**.

### Fix 6: Text fixes -- budget identity in Section 8.2 (VERIFIED)

Line 507 now correctly states:

> "Under unanimity, the budget identity holds exactly on the conservative R1 branch and with inequality E[V_H] + (N-1)V_W <= V_e(mu) on the aggressive branch (due to surplus destruction from discounting when theta=1 rejects)."

**PASS**.

### Fix 7: Figure cross-reference (VERIFIED)

Line 322 now contains `Figure \@ref(fig:bp-illustration)`:

> "Figure \@ref(fig:bp-illustration) illustrates the value functions and their concavifications under both rules."

**PASS**.

---

## New Issues Found in Round 4

### Issue 1 (Critical -- Proof error): Lemma 1 proof uses wrong formulas for majority

**Description**: The proof of Lemma 1 (lines 489-501, repeated in B.5 at lines 833-841) decomposes EVH into F-channel (H proposes) and G-channel (W proposes) and compares across rules. Both channel formulas for majority are structurally wrong:

**F-channel error**: The proof defines `F(mu, R) = [V_e(mu) - (N-1)*beta*V_W^R2(mu, R)]/N` for both rules. Under unanimity, H buys N-1 votes -- correct. Under majority, H buys only q-1 votes. The correct F(mu, M) = `[V_e(mu) - (q-1)*beta*V_W^R2(mu, M)]/N`. The R code correctly uses `(q-1)` (line 390).

**G-channel error**: The proof says `E_theta[H from W] = beta*V_e(mu)*[1+(N-1)*alpha]/N` under majority. This is the unanimity formula (what H gets as discounted R2 continuation when pivotal). Under majority, H is NOT pivotal and gets `alpha*V(theta)` directly in R1 without discounting. The correct formula is `E_theta[H from W] = alpha*V_e(mu)`. The R code correctly uses `alpha * Ve` (line 392).

**Consequence on boundary claim**: The proof concludes "At mu=1, both differences collapse to zero." This is false. At mu=1 with the correct formulas:
- F(U) - F(M) = -0.0756 (unanimity pays MORE because it buys N-1=4 votes vs q-1=2)
- G(U) - G(M) = +0.1152 (unanimity overpays H more when W proposes)
- Net: EVH_U - EVH_M = +0.0396 (at alpha=0.3, r=1.5, N=5, beta=0.9)

So EVH_U > EVH_M even at mu=1 -- the claim that they coincide is wrong. The result is actually STRONGER than stated at the paper's parameters.

### Issue 2 (Critical -- Overstated Lemma): Lemma 1 statement needs parametric qualification

**Description**: Lemma 1 claims "For every mu in (0,1), E[V_H(U)] > E[V_H(M)]." Numerical verification shows this is TRUE at alpha=0.3 but FALSE for alpha >= ~0.474 (at N=5, beta=0.9).

At alpha=0.6, r=1.5, N=5, beta=0.9: min(EVH_U - EVH_M) = -0.0288 at mu=1. The F-channel disadvantage of unanimity (buying 4 vs 2 votes) dominates the G-channel advantage when alpha is large.

Analytical threshold at mu=1 (for N=5, beta=0.9): alpha* = 2*beta / (20 - 18*beta) = 0.4737.

General formula: alpha* = beta*(q-1) / [N*(N-1) - beta*(N^2-N-q+1)].

For different N (beta=0.9):
- N=3: alpha* = 0.600
- N=5: alpha* = 0.474
- N=7: alpha* = 0.391
- N=9: alpha* = 0.333
- N=11: alpha* = 0.290

**Impact on paper**:
- At the paper's parameters (alpha=0.3, N=5): Lemma 1 holds. All numerical results correct.
- In Figure 2, alpha ranges up to 0.6: some combinations violate Lemma 1.
- Theorem 1 Step 2 ("majority can only dominate via entry") relies on Lemma 1 and is overstated.
- The main qualitative insight (screening jump creates BP opportunity at low priors) is unaffected.
- The Lemma statement needs to add condition `alpha < alpha*(N, beta)` or be restricted to the relevant parameter range.

### Issue 3 (Minor -- carried from Round 3): Insufficient inline comments in VH_R1_unanimity

`VH_R1_unanimity` (lines 360-383) has no inline comments explaining what the aggressive vs conservative branch payoffs represent. `VW_R1_unanimity` has branch comments (lines 341, 345) but `VH_R1_unanimity` does not.

### Issue 4 (Minor -- carried from Round 3): Duplicated VW_R2/omega computation

The computation of `VW_R2`, `omega`, `F1_con`, `F1_agg` is duplicated identically in both `VW_R1_unanimity` (lines 328-338) and `VH_R1_unanimity` (lines 361-371). Could be extracted to a helper.

---

## Standard Checks

### Citations: ALL PASS

Every `@citation` in the Rmd has a matching entry in `references.bib`:
- `@baron1989bargaining` -- OK
- `@kalandrakis2006proposal` -- OK
- `@eraslan2019legislative` -- OK
- `@keohane1984after` -- OK
- `@steinberg2002shadow` -- OK
- `@koremenos2001rational` -- OK
- `@kamenica2019bayesian` -- OK
- `@kamenica2011bayesian` -- OK
- `@maggi2006selfenforcing` -- OK
- `@blake2015balancing` -- OK
- `@crawford1982strategic` -- OK
- `@fearon1995rationalist` -- OK

### Cross-References: ALL PASS

- `\@ref(fig:bp-illustration)` -- chunk `bp_illustration` -- bookdown auto-converts underscore to hyphen. OK.
- `\@ref(fig:parameter-regions)` -- chunk `parameter_regions` -- OK.
- `\@ref(extension)` -- matches `{#extension}`. OK.
- `\@ref(comparison)` -- matches `{#comparison}`. OK.
- All `\ref{}` LaTeX labels have matching `\label{}` definitions. OK.
- All `\eqref{}` equation references have matching labels. OK.

### Notation Consistency: PASS

- `V_e(\mu)` used consistently throughout.
- `x = (N-1)\alpha r` defined once and used consistently.
- `\mu_s^{R1}` and `\mu_s^{R2}` notation consistent.
- `V(\theta)`, `V(0)=1`, `V(1)=r` consistent.
- `d_H = \alpha V(\theta)` consistent.
- `q = \lfloor N/2 \rfloor + 1` consistent with code.

### Equation-Code Cross-Checks

- R2 majority values (eqs 1-2): match code. Budget: VH_R2 + (N-1)*VW_R2 = V(theta). **PASS**.
- R2 unanimity screening cutoff (eq 4): mu_s_R2 = alpha*(r-1)/(r-alpha). Code matches. VW_R2 continuous at cutoff. **PASS**.
- R1 screening cutoff (eq 7): Code computes phi and mu_s_R1 matching formula. At beta=1, simplifies to 1/(N-2). **PASS**.
- Jump magnitude (eq 8): Analytical = 0.0578, numerical (eps=0.001) = 0.0579. Ratio = 0.998. **PASS**.
- v_M affine above entry: max residual from linear regression = 2.16e-15. **PASS**.
- Concavify function: All tests pass (cav >= v, concavity, test cases). **PASS**.
- Lemma 1 (numerical): EVH_U > EVH_M for all mu in (0,1) at alpha=0.3. **PASS** (but see Issue 2 for alpha > 0.474).

### Additional Structural Checks

- No hardcoded absolute paths. **PASS**.
- Packages loaded at top (`library(tidyverse); library(knitr)`). **PASS**.
- No randomization present (no missing `set.seed`). **PASS**.
- No pipe operators used. **PASS**.
- Parameter constraint `alpha < 1/r` enforced in Figure 2 loop. **PASS**.

---

## Score Calculation

| # | Severity | Issue | Deduction |
|---|----------|-------|-----------|
| 1 | Critical | Lemma 1 proof uses wrong formulas for majority (F-channel: (N-1) instead of (q-1); G-channel: beta*VH_R2 instead of alpha*V(theta)). Proof text is structurally wrong. Code is CORRECT. The proof computes the majority payoff using unanimity's structure. | -30 |
| 2 | Critical | Lemma 1 statement overstated: claims EVH_U > EVH_M for all alpha < 1/r, but fails for alpha >= alpha*(N,beta). At N=5, beta=0.9: alpha* = 0.474. At paper's alpha=0.3: holds. At Figure 2's alpha range up to 0.6: violated. Theorem 1 Step 2 depends on Lemma 1 and is also overstated. | -30 |
| 3 | Minor | Insufficient inline comments in VH_R1_unanimity (carried from R3). | -1 |
| 4 | Minor | Duplicated VW_R2/omega computation across functions (carried from R3). | -1 |

Note: Issues 1 and 2 are conceptually related (same lemma) but distinct problems (wrong proof vs. wrong statement). Both are text/proof errors; the R code is correct. The deductions could be viewed as partially overlapping, but both independently qualify as critical issues under the rubric ("domain bug" -- incorrect mathematical result in the proof/statement of a key lemma that Theorem 1 depends on).

### Adjusted scoring

Because Issues 1 and 2 affect the same lemma and are discovered together, a reasonable case exists for capping the combined deduction. However, they represent genuinely distinct errors:
- Issue 1: The proof mechanism is wrong (would be wrong even if the statement were right)
- Issue 2: The statement is wrong (would be wrong even if the proof were correct for the stated scope)

I apply the full rubric deductions.

---

## Final Score

**Starting**: 100  
**Deductions**: -30 (proof error) -30 (overstated lemma) -1 (comments) -1 (duplication) = -62  
**Final**: **38/100**

---

## Verdict: BLOCKED

The R code is correct and all round 3 code fixes are verified. The budget balances on both branches. The concavify function works correctly. All citations and cross-references are valid.

However, the text of Lemma 1 and its proof contain critical errors that affect Theorem 1. The proof applies unanimity-specific formulas (N-1 coalition size, beta*VH_R2 for H-from-W) to the majority rule, producing incorrect intermediate results. The statement claims unconditional dominance of unanimity for all alpha < 1/r, but this fails for alpha above a threshold that depends on N and beta.

### Recommended fixes

1. **Lemma 1 statement**: Add parametric condition `alpha < alpha*(N, beta)` where `alpha* = beta*(q-1) / [N*(N-1) - beta*(N^2-N-q+1)]`. Remove the false boundary claim about mu=1.

2. **Lemma 1 proof**: Correct the F-channel formula for majority to use (q-1) instead of (N-1). Correct the G-channel formula for majority to use `alpha*V_e(mu)` instead of `beta*V_e(mu)*[1+(N-1)*alpha]/N`. Redo the algebra.

3. **Theorem 1**: Qualify Step 2 with the same parametric condition. Note that for alpha > alpha*, majority can dominate through both the entry margin AND conditional bargaining payoffs near mu=1, but unanimity may still dominate at low priors via the screening jump.

4. **Discussion**: Note that alpha* decreases with N. For large N, Lemma 1 requires small alpha. This has a substantive interpretation: the advantage of unanimity through conditional payoffs is limited to environments where the hegemon's bilateral alternative is not too strong relative to coalition arithmetic.

### Impact on main results at paper's parameters

At alpha=0.3, N=5, beta=0.9: all claims hold. Lemma 1 is true. Theorem 1 is true. The screening jump mechanism works. The main qualitative insight is unaffected. The issue is one of generality: the paper claims universality but the result requires parametric conditions.
