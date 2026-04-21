# Stage 1: Code Review -- formal_model_v2.Rmd (Round 2)

**Date**: 2026-04-20  
**Reviewer**: Claude Opus 4.6 (automated)  
**File reviewed**: `formal_model_v2.Rmd`  
**Bib file**: `references.bib`  
**Starting score**: 100

---

## Score Calculation

| # | Severity | Issue | Deduction |
|---|----------|-------|-----------|
| 1 | Critico (Domain bug) | `VH_R1_majority()`: H-proposes channel uses `(N-1)` instead of `(q-1)` for coalition size under majority. H offers `beta*VW_R2` to all N-1 weak states instead of only q-1. Budget does not balance: E[VH]+4*VW = 1.346 vs Ve = 1.25 at baseline parameters. | -30 |
| 2 | Critico (Domain bug) | `VH_R1_majority()`: W-proposes channel gives H `beta*VH_R2(theta)` instead of `alpha*V(theta)`. Under majority, H's vote is not pivotal; W excludes H and H captures bilateral outside option `alpha*V(theta)` immediately (no discounting). The code uses the R2 continuation value, which is conceptually wrong. | -30 |
| 3 | Critico (Domain bug) | `VW_R1_majority()`: `omega_M = (N-2)*beta*VW_R2_M` uses `(N-2)` but under majority W only needs `(q-2)` coalition partners from other weak states. Inflates cost of coalition formation. | -30 |
| 4 | Major (Domain bug) | `concavify()` function uses `chull()` which returns the FULL convex hull (upper + lower boundary). For functions with a zero region followed by positive values, the interpolation follows the lower boundary instead of computing the upper concave envelope. Test case: `v=0` for `mu<0.4`, `v=2*mu` for `mu>=0.4` -- true concavification is `2*mu` everywhere but function returns 0 for `mu<0.4`. The `pmax(cav_vals, vals)` patch does not fix this. However, with baseline parameters (c=0.1), entry occurs at mu=0.001, so the zero region is negligible and the bug has no visible effect on Figure 1. | -15 |
| 5 | Critico (Typo in equation / text inconsistency) | Line 172: text states "H receives beta * alpha * V(theta)" when W proposes in R1 under majority. This is wrong on two counts: (a) if the deal passes in R1, there is no beta discounting; (b) the correct amount is alpha*V(theta), not beta*alpha*V(theta). The code uses yet another formula (beta*VH_R2). Text, code, and model are three-way inconsistent. | -10 |
| 6 | Minor (Insufficient comments) | R code chunks have minimal comments. The `VH_R1_unanimity` function is ~25 lines with only a header comment "Functions from the technical note". No inline comments explaining which branch corresponds to which model case. | -1 |
| 7 | Minor (Duplicated code) | `VW_R2` and `omega` computation is duplicated across `VW_R1_unanimity` and `VH_R1_unanimity`. Could be extracted to a helper function. | -1 |

**Total deductions**: -117 (capped at minimum meaningful score)

---

## Detailed Findings

### CRITICO: Majority R1 Implementation is Wrong (Issues 1--3)

The functions `VH_R1_majority()` and `VW_R1_majority()` implement the unanimity coalition logic instead of the majority coalition logic. Under majority rule with N=5, q=3:

- **H proposes**: H needs only q-1=2 votes, but the code pays (N-1)=4 weak states.
- **W proposes**: W needs only q-2=1 other weak state in coalition, but the code pays (N-2)=3.
- **H's payoff when W proposes**: The code gives H `beta*VH_R2` (the discounted R2 continuation), but under majority H's vote is not pivotal. H is excluded and captures `alpha*V(theta)` from the bilateral alternative immediately (no discounting).

**Budget verification** at r=1.5, alpha=0.3, N=5, beta=0.9, mu=0.5:
- Code: E[VH] + 4*VW = 1.346  
- Correct: E[VH] + 4*VW = 1.25 = Ve  
- Surplus: 0.096 (7.7% inflation)

**Impact on qualitative conclusions**: The bug inflates VH under majority, making majority look MORE favorable to H than it actually is. Since the paper's main result is that unanimity dominates majority for H, the corrected values would make the unanimity advantage LARGER. Lemma 1 (conditional payoff dominance) still holds with corrected values (verified numerically: minimum difference 0.041 at mu=0.99). Figure 2 (parameter regions) is conservative -- the unanimity-dominance region would be even larger with correct majority values. The qualitative conclusions survive, but the numerical values in both figures are incorrect.

**Corrected formulas**:
```r
# H proposes (1/N): keeps V(theta) - (q-1)*beta*VW_R2_M
# W proposes ((N-1)/N): H gets alpha*V(theta)
VH_R1_correct <- (Ve - (q-1)*beta*VW_R2_M)/N + (N-1)/N * alpha * Ve
```

### CRITICO: concavify() Function Bug (Issue 4)

The `concavify()` function uses R's `chull()` to find the convex hull of the points (mu, v(mu)). The convex hull includes BOTH the upper and lower boundaries. When sorting by x and interpolating, the function traces the lower boundary through the zero region instead of the upper concave envelope.

**Test case demonstrating the bug**:
```
v(mu) = 0      for mu < 0.4
v(mu) = 2*mu   for mu >= 0.4

True concavification: cav(mu) = 2*mu for all mu
Code output:          cav(0.2) = 0 (WRONG, should be 0.4)
                      cav(0.3) = 0 (WRONG, should be 0.6)
```

The `pmax(cav_vals, vals)` line patches the output to be at least as large as v, but this does not recover the true concave envelope.

**Practical impact**: With baseline parameters (c=0.1), entry occurs at mu=0.001, so the zero region is almost empty. The bug has negligible visual impact on Figure 1 for these specific parameters. However, for higher entry costs or different parameter configurations where the entry threshold is interior, this function would produce incorrect concavification.

A correct implementation would filter `chull` points to only the upper boundary, or use a proper concave-envelope algorithm (e.g., walking the upper hull from left to right).

### CRITICO: Text-Code-Model Three-Way Inconsistency (Issue 5)

Line 172 states:
> "H receives beta * alpha * V(theta) from the offer (or equivalently from the outside option if excluded)."

Three problems:
1. The `beta` factor implies discounting, but in R1 when the deal passes, there is no discounting. H should receive `alpha*V(theta)` directly.
2. The code uses `beta*VH_R2(theta) = beta*V(theta)*(1+(N-1)*alpha)/N`, which differs from both `alpha*V(theta)` and `beta*alpha*V(theta)`.
3. The correct value is `alpha*V(theta)` (H's bilateral alternative captured immediately when excluded from the majority deal in R1).

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

### Cross-References: ALL PASS

- `\@ref(fig:parameter-regions)` -- chunk `parameter_regions` -- bookdown auto-converts underscore to hyphen. OK.
- `\@ref(extension)` -- matches `{#extension}`. OK.
- `\@ref(comparison)` -- matches `{#comparison}`. OK.
- All `\ref{}` LaTeX labels (`prop:majority`, `prop:jump`, `lem:conditional`, etc.) have matching `\label{}` definitions.
- All `\eqref{}` equation references (`eq:VH1_R2_U`, `eq:VH0_R2_con`, `eq:cutoff_R1`, `eq:jump_R1`) have matching labels.

### Notation Consistency: PASS

- `V_e(\mu)` used consistently.
- `x = (N-1)*alpha*r` defined once and used consistently.
- `mu_s^{R1}` and `mu_s^{R2}` notation consistent throughout.

### Additional Observations (no deduction)

- Figure 1 (`bp_illustration`) is not cross-referenced in the text. It appears between Sections 7 and 8 but is never cited. This is a minor presentation issue.
- The unanimity code (`VH_R1_unanimity`, `VW_R1_unanimity`) appears correct: budget balances (1.25 = 1.25 at mu=0.5), screening jump is present at mu_s_R1, and Lemma 1 holds. These functions correctly use (N-1) since unanimity requires ALL members' approval.
- Parameter constraint alpha < 1/r is respected in the code (alpha=0.3 < 1/1.5=0.667) and enforced in Figure 2's loop.
- No hardcoded absolute paths.
- Packages loaded at top (tidyverse, knitr).
- No randomization present (no missing set.seed).
- No pipe operators used (neither `|>` nor `%>%`).

---

## Summary of Severity Levels

**Critico (3 issues)**:
1. `VH_R1_majority()` uses unanimity coalition logic (N-1) instead of majority (q-1) for H-proposes channel.
2. `VH_R1_majority()` gives H the discounted R2 continuation (`beta*VH_R2`) instead of the bilateral alternative (`alpha*V(theta)`) when W proposes.
3. `VW_R1_majority()` uses (N-2) instead of (q-2) for coalition partners.

**Major (1 issue)**:
4. `concavify()` traces lower hull boundary instead of upper concave envelope. Bug is latent for baseline parameters but would produce incorrect output for other parameter configurations.

**Critico -- Text (1 issue)**:
5. Line 172 text claims H receives `beta*alpha*V(theta)` in R1 under majority, inconsistent with both the code and the model.

**Minor (2 issues)**:
6. Insufficient inline comments in R code.
7. Duplicated VW_R2/omega computation across functions.

---

## Final Score

**Score: -17** (100 - 30 - 30 - 30 - 15 - 10 - 1 - 1 = -17, floored to 0)

## Verdict: REPROVADO (0/100)

The majority rule R1 implementation contains three critical domain bugs that cause the budget to not balance. The concavify function has a latent bug. The text contains a claim inconsistent with both the code and the model specification. While the unanimity code is correct and the paper's qualitative conclusions survive (correcting the bugs would strengthen, not weaken, the main results), the code as written produces numerically incorrect figures. Both R code chunks (`bp_illustration` and `parameter_regions`) use the buggy `VH_R1_majority` and `VW_R1_majority` functions, so both figures have inflated majority values.

**Blocking issues (must fix before commit)**:
1. Rewrite `VH_R1_majority()` with correct majority coalition logic: H buys q-1 Ws when proposing, and H captures alpha*V(theta) when W proposes.
2. Rewrite `VW_R1_majority()` with correct majority coalition logic: W buys q-2 other Ws.
3. Fix `concavify()` to compute the upper concave envelope only (filter chull to upper boundary).
4. Fix line 172 text: H receives alpha*V(theta) (no beta discounting when deal passes in R1).
5. Verify budget balance after corrections.
