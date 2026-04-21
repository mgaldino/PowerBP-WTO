# Proofread Report Round 2: formal_model_v2.Rmd

**Date**: 2026-04-20

## Verification of Round 1 Corrections

| # | Issue | Status |
|---|-------|--------|
| 1 | Contradictory spacing: `\doublespacing` + `\setstretch{1.5}` | **FIXED** — `\doublespacing` removed; only `\setstretch{1.5}` remains (line 12) |
| 2 | "Bayesian Persuasion" capitalized (line ~50) | **FIXED** — now "Bayesian persuasion" (line 50) |
| 3 | Introduction references "Proposition 4" for non-convexity | **FIXED** — now references "Proposition 5" (line 56) |
| 4 | Grammar: "let x ... as a notational shorthand" | **FIXED** — now "define $x \equiv (N-1)\alpha r$ as a notational shorthand" (line 123) |
| 5 | Notation: `v_H(mu_s^{R1})` in Theorem 1 | **FIXED** — now `v(\mu_s^{R1}, U)` (line 500) |
| 6 | Unnecessary `min(tau(U), tau(M))` | **FIXED** — now just `\tau(M)` (line 502) |
| 7 | "Bayesian Persuasion" capitalized again (line ~313) | **FIXED** — now "Bayesian persuasion" (line 313) |
| 8 | "displace" should be "complement" | **FIXED** — now "complement and amplify" (line 642) |
| 9 | Appendix B.2 says "Proposition 2" | **FIXED** — now "Proposition 3" (line 794) |
| 10 | Appendix B.3 says "Proposition 3" | **FIXED** — now "Proposition 4" (line 798) |
| 11 | Appendix B.4 says "Proposition 4" | **FIXED** — now "Proposition 5" (line 802) |

**All 11 issues from Round 1 have been correctly fixed.**

## Check for New Issues Introduced by Edits

No new issues were introduced by the corrections. Specifically:

- All `\ref{}` and `\@ref()` cross-references resolve to valid labels
- All `\label{}` definitions are unique and correctly placed
- Proposition numbering is consistent: Props 1-5 in body, Appendix B references Props 1, 3, 4, 5 (skipping Prop 2 which is trivial)
- "Bayesian persuasion" capitalization is now consistent throughout body text (only capitalized in section title at line 272, which is appropriate)
- No orphaned or dangling references
- LaTeX environments remain balanced
- No new notation inconsistencies

## Residual Issues from Round 1 (not in the correction list)

The following minor issues from Round 1 were NOT part of the 11 corrections and remain unchanged:

| Line | Issue | Category | Deduction |
|------|-------|----------|-----------|
| 156 | "coalition of weak states divides" — imprecise (proposer captures, not coalition divides) | Imprecision | -1 |
| 170 | H's R1 payoff from W proposing conflates offer vs continuation value | Imprecision | -1 |
| 868 | $y_H^{agg}$ expression could benefit from clarifying note | Exposition clarity | -1 |

## Score

Starting: 100

| Issue | Deduction |
|-------|-----------|
| Imprecision: "coalition divides" vs "proposer captures" (line 156) | -1 |
| Imprecision: H's payoff conflation (line 170) | -1 |
| Exposition clarity: $y_H^{agg}$ in Appendix C.3 (line 868) | -1 |

**Score: 97/100**

**Status: PASS (>=90, ready to circulate/submit)**

## Summary

All 11 flagged issues from Round 1 have been correctly addressed. No new issues were introduced. The three residual minor items (imprecision in two expository passages and one appendix notation) are cosmetic and do not affect correctness or reader comprehension. The manuscript is in excellent shape for circulation.
