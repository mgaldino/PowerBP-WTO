# Stage 1: Code Review -- formal_model_v2.Rmd (Round 3)

**Date**: 2026-04-20  
**Reviewer**: Claude Opus 4.6 (automated)  
**File reviewed**: `formal_model_v2.Rmd`  
**Bib file**: `references.bib`  
**Starting score**: 100

---

## Verification of Round 2 Fixes

### Fix 1: VH_R1_majority() -- coalition size (VERIFIED)

Round 2 found that H-proposes channel used `(N-1)` instead of `(q-1)` for coalition size. The current code (line 381-382) correctly uses:

```r
H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
```

With `q <- floor(N/2) + 1`, this gives `q-1 = 2` for N=5. **PASS**.

### Fix 2: VH_R1_majority() -- W-proposes channel (VERIFIED)

Round 2 found the code gave H `beta*VH_R2(theta)` instead of `alpha*V(theta)` when W proposes. The current code (line 384) correctly uses:

```r
W_prop_H <- (N - 1) / N * alpha * Ve
```

This gives H the expected bilateral alternative `alpha * Ve`, without beta discounting. **PASS**.

### Fix 3: VW_R1_majority() -- budget identity approach (VERIFIED)

Round 2 found `(N-2)` used for coalition partners. The current code (lines 344-350) now uses the budget identity:

```r
VW_R1_M <- (Ve - EVH) / (N - 1)
```

This is correct by construction: total surplus = Ve under majority (no rejection path), so VW = (Ve - EVH)/(N-1). **PASS**.

Budget balance verified numerically at mu=0.5, r=1.5, alpha=0.3, N=5, beta=0.9:
- EVH_M = 0.487
- VW_M = 0.19075
- EVH_M + 4*VW_M = 1.250 = Ve. **PASS**.

### Fix 4: concavify() function (VERIFIED)

Round 2 found `chull()` traced the lower hull boundary. The current code (lines 408-436) uses a left-to-right gift-wrapping algorithm that correctly computes the upper concave envelope.

Test case: `v=0 for mu<0.4, v=2*mu for mu>=0.4`:
- cav(0.2) = 0.4 (correct, previously was 0)
- cav(0.3) = 0.6 (correct, previously was 0)
- cav(0.5) = 1.0 (correct)

Test case: `v=0 for mu<0.3, v=mu for 0.3<=mu<0.6, v=mu+0.5 for mu>=0.6`:
- cav(0.1) = 0.1833 (correct: line from origin to jump at 0.6)
- Concavity verified: all second differences <= 0.

Additional tests with actual paper data:
- `cav >= v` everywhere: **PASS**
- Concavity (non-increasing slopes): **PASS**
- v_M affine above entry (max residual from linear fit = 2.16e-15): **PASS**

**PASS**.

### Fix 5: Line 172 text (VERIFIED)

Round 2 found text stated H receives `beta*alpha*V(theta)`. Current text (line 172):

> "H receives alpha*V(theta) from the outside option (or equivalently from a matching offer if included by convention)."

No beta discounting. Correctly matches the code and model. **PASS**.

---

## New Issues Found in Round 3

### Issue 1 (Major -- Domain bug): VW_R1_unanimity() non-proposer payoff under aggressive R1

**Description**: The function `VW_R1_unanimity()` computes the non-proposer W's payoff as `(N-1)*beta*VW_R2(mu)/N`. This is correct when deals always pass (conservative R1, or any R2 scenario). However, on the **aggressive R1 branch**, when another W proposes and theta=1 rejects, the game proceeds to R2 with updated belief mu=1 (not the original mu). The non-proposing W should receive `beta*VW_R2(1)` in that scenario, not `beta*VW_R2(mu)`.

**Correct formula for non-proposer expected payoff**:
```
1/N * beta*VW_R2(mu)                                         [H proposes]
+ (N-2)/N * [(1-mu)*beta*VW_R2(mu) + mu*beta*VW_R2(1)]       [another W proposes, aggressive]
```

vs code which uses `(N-1)/N * beta*VW_R2(mu)` for all non-proposer scenarios.

**Missing correction term**: `(N-2)/N * mu * beta * [VW_R2(1) - VW_R2(mu)]`

**Budget balance failure**: At mu=0.1, r=1.5, alpha=0.3, N=5, beta=0.9:
- Code: EVH + 4*VW = 1.0199 vs Ve = 1.050. Gap = -0.0301.
- Correct: EVH + 4*VW = 1.038 = Ve - (N-1)/N * mu * (1-beta) * r.

The correct budget identity on the aggressive branch is NOT `EVH + (N-1)*VW = Ve` but rather `EVH + (N-1)*VW = Ve - surplus_destroyed`, where `surplus_destroyed = (N-1)/N * mu * (1-beta) * r` (the expected value lost to discounting when theta=1 rejects in R1).

**Important**: `VH_R1_unanimity()` is NOT affected by this bug. The EVH formula correctly tracks type-specific payoffs (VH_0 gets y_H when accepted, VH_1 gets beta*VH_R2(1) when rejected). The error is only in VW.

**Impact on qualitative conclusions**: The bug **understates** VW(U) on the aggressive branch (mu < mu_s_R1). This makes entry look harder under unanimity than it actually is. Since the paper's main result is that unanimity dominates majority conditional on entry (Lemma 1, which uses EVH only), and majority's advantage operates only through the entry margin, correcting this bug would **strengthen** the main result by making unanimity's entry disadvantage slightly smaller.

**Magnitude**: At mu=0.19 (near the screening cutoff), the correction is ~6.5% of VW. At mu=0.01, it is ~0.5% of VW. The error is proportional to mu, so it is smallest where entry matters most (low mu).

### Issue 2 (Major -- Typo in equation / text): Appendix A.6 and Section 8.2 budget identity claim

**Description**: Line 804 states:
> "Under unanimity, the budget identity E[V_H] + (N-1)V_W = V_e(mu) holds on each branch."

Line 499 repeats:
> "the budget identity E[V_H] + (N-1)V_W = V_e(mu) (which holds on each branch)"

This is incorrect on the aggressive R1 branch. The correct identity on the aggressive branch is:
```
E[V_H] + (N-1)*V_W = Ve - (N-1)/N * mu * (1-beta) * r
```

The surplus destruction term arises because theta=1 rejects the R1 offer with probability mu when W proposes (prob (N-1)/N), and the R2 game extracts only beta*V(1) instead of V(1).

**Impact on proof logic**: The text uses the budget identity to argue that VW_M > VW_U (since EVH_U > EVH_M by Lemma 1). The conclusion is still correct because the correct identity gives `EVH_U + (N-1)*VW_U = Ve - destruction(U) <= Ve = EVH_M + (N-1)*VW_M`. Since EVH_U > EVH_M, VW_U must be even smaller than what the simple budget identity implies. So VW_M > VW_U holds a fortiori. The qualitative argument is valid; only the stated reason needs correction.

### Issue 3 (Minor): Figure 1 (bp_illustration) not cross-referenced in text

The first figure (`bp_illustration`) has a caption but is never referenced with `\@ref(fig:bp-illustration)` in the text body. The figure appears between Sections 7 and 8 without any textual reference. By contrast, Figure 2 (`parameter_regions`) is properly referenced.

### Issue 4 (Minor): Insufficient inline comments in R code

R code chunks have minimal comments. The `VH_R1_unanimity` function is ~25 lines with only a header comment "Functions from the technical note". No inline comments explaining which branch corresponds to which model case, what the F1_agg vs F1_con comparison represents, or what the H_prop_0/H_prop_1 terms capture.

### Issue 5 (Minor): Duplicated VW_R2/omega computation

The VW_R2 and omega computation is duplicated identically across `VW_R1_unanimity` and `VH_R1_unanimity`. Could be extracted to a helper function to reduce code duplication and maintenance risk.

---

## RMarkdown and Citation Checks

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

### Cross-References: PASS (with caveat)

- `\@ref(fig:parameter-regions)` -- chunk `parameter_regions` -- bookdown auto-converts underscore to hyphen. OK.
- `\@ref(extension)` -- matches `{#extension}`. OK.
- `\@ref(comparison)` -- matches `{#comparison}`. OK.
- `\@ref(R1consensus)` -- not used in text but section exists. OK.
- All `\ref{}` LaTeX labels (`prop:majority`, `prop:jump`, `lem:conditional`, etc.) have matching `\label{}` definitions. OK.
- All `\eqref{}` equation references have matching labels. OK.
- **Caveat**: `bp_illustration` figure is not cross-referenced (see Issue 3).

### Notation Consistency: PASS

- `V_e(\mu)` used consistently throughout.
- `x = (N-1)\alpha r` defined once and used consistently.
- `\mu_s^{R1}` and `\mu_s^{R2}` notation consistent.
- `V(\theta)`, `V(0)=1`, `V(1)=r` consistent.
- `d_H = \alpha V(\theta)` consistent.
- `q = \lfloor N/2 \rfloor + 1` consistent with code.

### Equation Cross-Checks: PASS

Verified that R code matches mathematical expressions:
- R2 majority values (eqs 1-2): match code in `VH_R1_majority()`. Budget: VH_R2 + (N-1)*VW_R2 = V(theta) for both types. **PASS**.
- R2 unanimity screening cutoff (eq 4): `mu_s_R2 = alpha*(r-1)/(r-alpha)`. Code matches. VW_R2 continuous at cutoff. **PASS**.
- R1 screening cutoff formula (eq 7): Code computes phi and mu_s_R1 matching the formula. At beta=1, simplifies to 1/(N-2). **PASS**.
- Jump magnitude (eq 8): Formula matches numerical computation (0.0578 vs 0.0579 with eps=0.001). **PASS**.
- v_M is affine above entry threshold: max residual from linear regression = 2.16e-15. **PASS**.

### Additional Structural Checks

- No hardcoded absolute paths. **PASS**.
- Packages loaded at top (`library(tidyverse); library(knitr)`). **PASS**.
- No randomization present (no missing `set.seed`). **PASS**.
- No pipe operators used. **PASS**.
- Parameter constraint `alpha < 1/r` enforced in Figure 2 loop (`if (alphas[j] < 1/rs[i])`). **PASS**.

---

## Score Calculation

| # | Severity | Issue | Deduction |
|---|----------|-------|-----------|
| 1 | Major (Domain bug) | `VW_R1_unanimity()` non-proposer payoff incorrect on aggressive R1 branch: uses `beta*VW_R2(mu)` when should mix with `beta*VW_R2(1)` for theta=1 rejection path. Budget fails on aggressive branch (gap = -0.03 at mu=0.1). `VH_R1_unanimity()` is correct. Bug understates VW(U), making unanimity look worse on entry margin; correcting would strengthen main result. | -15 |
| 2 | Major (Typo in text) | Lines 499 and 804 claim budget identity `E[V_H] + (N-1)V_W = V_e(mu)` holds on "each branch" under unanimity. Incorrect on aggressive R1 branch due to surplus destruction from discounting. Qualitative conclusions are valid a fortiori; only the stated justification needs correction. | -5 |
| 3 | Minor | Figure 1 (`bp_illustration`) not cross-referenced in text body. Appears between Sections 7 and 8 without any `\@ref(fig:bp-illustration)` reference. | -1 |
| 4 | Minor | Insufficient inline comments in R code functions. | -1 |
| 5 | Minor | Duplicated VW_R2/omega computation across `VW_R1_unanimity` and `VH_R1_unanimity`. | -1 |

**Total deductions**: -23

---

## Detailed Root Cause for Issue 1

Under aggressive R1, when W_j proposes:
- **theta=0** (prob 1-mu): Deal accepted. Non-proposing W_i gets `beta*VW_R2(mu)` as offered. **Correct in code.**
- **theta=1** (prob mu): Deal rejected by H. Game proceeds to R2 with known theta=1 (belief mu=1). Non-proposing W_i gets `beta*VW_R2(1) = beta*r*(1-alpha)/N`, NOT `beta*VW_R2(mu)`.

The code's `VW_R1 = F_proposer/N + (N-1)*beta*VW_R2(mu)/N` treats ALL non-proposer scenarios uniformly with `VW_R2(mu)`. This is correct only when deals always pass (conservative branch, H-proposes).

**Fix**: Replace the non-proposer term in `VW_R1_unanimity()`. When on the aggressive R1 branch, the non-proposer payoff should be:
```r
if (F1_agg > F1_con) {
  VW_R2_rej <- r * (1 - alpha) / N  # VW_R2 at mu=1 (after rejection)
  nonprop <- (1/N) * beta * VW_R2 + (N-2)/N * ((1-mu)*beta*VW_R2 + mu*beta*VW_R2_rej)
} else {
  nonprop <- (N-1)/N * beta * VW_R2
}
VW_R1 <- F_proposer / N + nonprop
```

The magnitude of the correction at `mu = mu_s_R1 = 0.197` is about 6.5% of VW, which is non-trivial near the screening cutoff but small at low mu where entry decisions are made. The error is proportional to mu and vanishes at mu=0.

---

## Summary of Severity Levels

**Major (2 issues)**:
1. `VW_R1_unanimity()` non-proposer payoff incorrect on aggressive R1 branch. Budget fails.
2. Text claims budget identity holds on "each branch" under unanimity; incorrect on aggressive branch.

**Minor (3 issues)**:
3. Figure 1 not cross-referenced in text.
4. Insufficient inline comments.
5. Duplicated code across unanimity functions.

---

## Comparison with Round 2

| Issue | Round 2 Status | Round 3 Status |
|-------|---------------|----------------|
| VH_R1_majority: N-1 vs q-1 | CRITICAL | FIXED, VERIFIED |
| VH_R1_majority: beta*VH_R2 vs alpha*Ve | CRITICAL | FIXED, VERIFIED |
| VW_R1_majority: N-2 vs q-2 | CRITICAL | FIXED (budget identity), VERIFIED |
| concavify: lower hull | MAJOR | FIXED (gift-wrap algorithm), VERIFIED |
| Line 172 text: beta discounting | CRITICAL | FIXED, VERIFIED |
| VW_R1_unanimity: non-proposer under aggressive | -- | NEW, MAJOR |
| Budget identity text claim | -- | NEW, MAJOR (text) |
| Figure 1 not referenced | Noted (no deduction) | Minor (-1) |
| Insufficient comments | Minor | Carried over (-1) |
| Duplicated code | Minor | Carried over (-1) |

---

## Final Score

**Score: 77** (100 - 15 - 5 - 1 - 1 - 1 = 77)

## Verdict: REPROVADO (77/100)

The three critical bugs from Round 2 have been properly fixed and verified. The `concavify()` function now correctly computes the upper concave envelope. The majority rule functions are correct and budget-balanced. However, a new Major domain bug was discovered in `VW_R1_unanimity()`: the non-proposer W payoff on the aggressive R1 branch does not account for the belief update when theta=1 rejects and the game proceeds to R2. This causes the unanimity budget to fail on the aggressive branch (gap up to -5.6% of Ve near the screening cutoff). Additionally, the text incorrectly claims the simple budget identity holds "on each branch."

**Importantly**: The bug *understates* VW(U) and therefore makes unanimity's entry disadvantage appear larger than it actually is. `VH_R1_unanimity()` (the hegemon's value function) is correct. Correcting the bug would strengthen, not weaken, the paper's main results. All qualitative conclusions (Lemma 1, Theorem 1, Propositions 1-5) survive. The concavification and parameter region plots are affected only through VW, which determines entry thresholds -- the unanimity entry threshold may shift slightly lower after correction.

**Blocking issues (must fix before commit)**:
1. Fix `VW_R1_unanimity()` to correctly handle non-proposer payoff on aggressive R1 branch (account for beta*VW_R2(1) when theta=1 rejects).
2. Correct text in lines 499 and 804: the budget identity `E[V_H] + (N-1)V_W = V_e(mu)` does NOT hold on the aggressive R1 branch under unanimity due to surplus destruction from discounting. The correct identity includes a destruction term.
3. Add cross-reference for Figure 1 in the text body.
