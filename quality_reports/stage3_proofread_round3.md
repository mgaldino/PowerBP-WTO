# Stage 3: Proofread Report (Round 3)

**File**: `formal_model_v2.Rmd`  
**Date**: 2026-04-20  
**Reviewer**: Proofreading agent  
**Starting score**: 100

---

## Findings

| # | Line | Current text | Proposed correction | Category | Deduction |
|---|------|-------------|---------------------|----------|-----------|
| 1 | 276 | `Section \ref{R1consensus}` | `Section \@ref(R1consensus)` | Broken cross-reference (bookdown section label requires `\@ref()`, not `\ref{}`) | -5 |
| 2 | 883 | `Section \ref{comparison}` | `Section \@ref(comparison)` | Broken cross-reference (bookdown section label requires `\@ref()`, not `\ref{}`) | -5 |
| 3 | 99 | `if the hegemon were the exclusive proposer and weak states have no outside option` | `if the hegemon were the exclusive proposer and weak states had no outside option` | Grammar error: mixed tense in counterfactual (subjunctive "were" requires "had", not "have") | -3 |
| 4 | 707 | `the jump magnitude becomes $(1-\mu_s)(1-p_H)\alpha(r-1)$` | `the jump magnitude becomes $(1-\mu_s^{R2})(1-p_H)\alpha(r-1)$` | Notation inconsistency: bare `\mu_s` should be `\mu_s^{R2}` (context is R2 jump) | -3 |
| 5 | 839 | `$\lim_{\mu \uparrow \mu_s} v(\mu, U) < \lim_{\mu \downarrow \mu_s} v(\mu, U)$` | `$\lim_{\mu \uparrow \mu_s^{R1}} v(\mu, U) < \lim_{\mu \downarrow \mu_s^{R1}} v(\mu, U)$` | Notation inconsistency: bare `\mu_s` should be `\mu_s^{R1}` (context is R1 proof) | -3 |
| 6 | 900 | `V_H^{R2}(\theta=0, \mu < \mu_s, U)` | `V_H^{R2}(\theta=0, \mu < \mu_s^{R2}, U)` | Notation inconsistency: bare `\mu_s` should be `\mu_s^{R2}` in Appendix C.1 | -3 |
| 7 | 901 | `V_H^{R2}(\theta=0, \mu > \mu_s, U)` | `V_H^{R2}(\theta=0, \mu > \mu_s^{R2}, U)` | Notation inconsistency: same as above | -0 (grouped with #6) |
| 8 | 907 | `V_W^{R2}(\mu < \mu_s, U)` | `V_W^{R2}(\mu < \mu_s^{R2}, U)` | Notation inconsistency: same as above | -0 (grouped with #6) |
| 9 | 908 | `V_W^{R2}(\mu > \mu_s, U)` | `V_W^{R2}(\mu > \mu_s^{R2}, U)` | Notation inconsistency: same as above | -0 (grouped with #6) |
| 10 | 913 | `$(1-\mu_s)(1-p_H)\alpha(r-1)$` | `$(1-\mu_s^{R2})(1-p_H)\alpha(r-1)$` | Notation inconsistency: bare `\mu_s` should be `\mu_s^{R2}` in Appendix C.1 | -0 (grouped with #6) |
| 11 | 492 | `we establish a result` | `I establish a result` | Inconsistent formatting: paper uses first person singular throughout ("I argue", "I show", "I develop") but switches to "we" here | -1 |

---

## Items verified as correct (no deduction)

1. **All citations present in .bib**: Every `@key` in the manuscript has a matching entry in `references.bib`. 15 citation keys used, all verified.
2. **All `\eqref{}` references resolve**: `eq:VH1_R2_U`, `eq:VH0_R2_con`, `eq:cutoff_R1`, `eq:jump_R1` all have matching `\label{}` definitions.
3. **All `\ref{}` to `\label{}` environments resolve**: `prop:majority`, `prop:jump`, `lem:conditional`, `thm:main` all verified.
4. **Figure cross-references**: `fig:bp-illustration` maps to chunk `bp_illustration`, `fig:parameter-regions` maps to chunk `parameter_regions` (bookdown auto-converts underscores to hyphens). Both correct.
5. **Section `\@ref(extension)` resolves**: Section label `{#extension}` exists at line 703.
6. **Numerical claims in Example 1 (line 276)**: All values verified computationally (`mu_s^R1 = 0.197`, jump = 0.058, ratios 27%/41%).
7. **`alpha*` values (line 737)**: Verified for N=3,5,7,9 with beta=0.9.
8. **Proposition/Lemma/Theorem numbering**: Sequential and internally consistent (Definitions 1-2, Propositions 1-6, Example 1, Lemma 1, Theorem 1, Remarks 1-2).
9. **Roadmap (line 60)**: Section numbers 2-10 match actual section ordering.
10. **Equation labels**: No duplicates found. All labels are unique.
11. **Dash usage**: Em-dashes (`---`) for parenthetical insertions, en-dashes (`--`) for number ranges. Consistent.
12. **Hyphenation**: "payoff" (not "pay-off"), "non-convexity" (consistent except in LaTeX label which cannot have hyphens), "single-crossing", "type-specific". All consistent.
13. **R code**: `VH_R1_majority`, `VH_R1_unanimity`, `VW_R1_majority`, `VW_R1_unanimity` functions verified against paper formulas.
14. **Budget identity checks** (Appendix A.6): Verified algebraically.
15. **Beta=1 simplification** (line 253): `mu_s^{R1} = 1/(N-2)` verified algebraically.
16. **"Hegemon" capitalization**: Lowercase throughout except in the title (correct).
17. **"consensus" vs "unanimity"**: Used deliberately (consensus for broader institutional concept, unanimity for formal model concept). Established in Definition 1.

---

## Minor observations (no deduction, for author consideration)

- **Label naming**: `\label{cor:substitution}` on line 592 uses prefix "cor" but the environment is `\begin{remark}`. Consider renaming to `rem:substitution` for clarity (no compilation impact).
- **"We" in proofs**: Lines 752 and 865 use "we" in mathematical proof/conjecture context. This is standard mathematical convention even in single-authored papers. Only line 492 is in descriptive prose, flagged above.
- **Appendix C bare `\mu_s`**: All six instances of bare `\mu_s` in Appendix C are within the R2 subsection where the context is unambiguous. The superscript would improve consistency with the main text but is not strictly necessary within a clearly scoped subsection.

---

## Score computation

| Category | Issue | Deduction |
|----------|-------|-----------|
| Major | Broken cross-reference: `\ref{R1consensus}` (line 276) | -5 |
| Major | Broken cross-reference: `\ref{comparison}` (line 883) | -5 |
| Major | Grammar error: subjunctive tense mismatch (line 99) | -3 |
| Major | Notation inconsistency: bare `\mu_s` in body text (line 707) | -3 |
| Major | Notation inconsistency: bare `\mu_s` in Appendix B.4 proof (line 839) | -3 |
| Major | Notation inconsistency: bare `\mu_s` in Appendix C.1 (lines 900-913, grouped) | -3 |
| Minor | Inconsistent person ("we" in descriptive prose, line 492) | -1 |
| **Total** | | **-23** |

---

## Final score: **77/100**

## Verdict: **REPROVADO [77]**

### Blocking issues (must fix before score >= 90)

1. **Fix broken cross-references** (lines 276, 883): Change `\ref{R1consensus}` to `\@ref(R1consensus)` and `\ref{comparison}` to `\@ref(comparison)`. These will render as "??" in the compiled PDF.
2. **Fix notation inconsistency** (lines 707, 839, 900-913): Add `^{R2}` or `^{R1}` superscript to all bare `\mu_s` occurrences. Six instances total.
3. **Fix grammar** (line 99): Change "have" to "had" in the subjunctive clause.
4. **Fix person inconsistency** (line 492): Change "we establish" to "I establish".
