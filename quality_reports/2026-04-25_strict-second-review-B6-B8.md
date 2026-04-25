# Strict Second Review: Proofs of Theorem 1 (B.6) and Theorem 2 (B.8)

**Date**: 2026-04-25
**Reviewer**: Independent second reviewer (Claude Opus 4.6)
**File**: `formal_model_v3.Rmd`
**Context**: A previous auditor verified 15 checks and found all PASS. This review independently re-derives every step.

---

## GRADE: A

---

## Detailed Assessment

### Correctness (60% of grade): 57/60

Both proofs are algebraically correct. Every step was independently verified:

**B.6 (Theorem 1):**
1. E_U subset E_M via budget identity + Lemma 1: CORRECT. The majority budget identity is exact; unanimity has weak inequality from surplus destruction. Combined with E[V_H(mu,U)] > E[V_H(mu,M)], the inequality V_W(mu,U) < V_W(mu,M) follows.
2. v(p,U) > v(p,M) from Lemma 1: CORRECT. The alpha*V_e(p) terms cancel identically.
3. v(mu,M) = (lambda_M - alpha)[1 + (r-1)mu]: CORRECT. Verified algebraically: lambda_M - alpha = (1-alpha)[N - beta(q-1)]/N^2 > 0.
4. Concavification bound: CORRECT. Since (lambda_M - alpha) > 0 and (r-1) > 0, the upper bound sum_A pi_s <= 1 and sum_A pi_s mu_s <= p give the right direction.
5. cav v(p,M) = v(p,M) for p in E_M: CORRECT. No experiment can improve upon the affine function at points already in the entry set.
6. Final chain cav v(p,U) >= v(p,U) > v(p,M) = cav v(p,M): CORRECT.

**B.8 (Theorem 2):**
1. Structure of m(p): CORRECT. The concavification of a function that is 0 below tau(M) and affine above tau(M) is a ray from the origin to (tau(M), v(tau(M),M)), then follows the affine function. Verified that the slope decreases at tau(M) (S_M > (lambda_M-alpha)(r-1)), confirming concavity.
2. m(p)/p weakly decreasing: CORRECT. Constant on (0, tau(M)], strictly decreasing on (tau(M), 1] (positive intercept divided by p).
3. Part 1 chord argument: CORRECT. The chord connecting (b, u(b)) to (d, u(d)) with u(b) > m(b) and u(d) > m(d), combined with m affine on [b,d], gives chord - m affine with positive endpoints, hence positive throughout.
4. Part 2 linearity from origin: CORRECT. v=0 on [0,a) and u(0)=0 (verified: the only experiment with mean 0 puts all mass at 0 where v=0) forces u linear on [0, x] for some x >= a.
5. Single-crossing via Delta(p) = p[S_U - m(p)/p]: CORRECT. m(p)/p weakly decreasing implies S_U - m(p)/p weakly increasing, so sign change is at most once.
6. Combining Parts 1 and 2: CORRECT. Delta > 0 on [a,1] (Part 1) and {p < a: Delta > 0} is an upper interval (Part 2) combine to an upper interval on (0,1].

**Deductions (-3):**
- MINOR: The v(mu,U) > 0 when entry occurs (needed for Part 1) is not explicitly justified in B.8. It follows from Lemma 1 (v(mu,U) > v(mu,M) > 0 since lambda_M > alpha), but the reader must reconstruct this. (-1)
- MINOR: B.8 Part 1 claims "v(p,M) = m(p)" for p in E_U without explicitly stating why (it's because E_U subset E_M and p >= tau(M), and m equals v on [tau(M),1]). The logic is correct but requires the reader to recall the B.6 result. (-1)
- MINOR: The proof does not explicitly address the edge case E_U = emptyset. The result holds vacuously (the dominance set is empty, which is an upper interval), but a one-sentence remark would improve rigor. (-1)

### Completeness (20% of grade): 18/20

**B.6:**
- Handles the key case (p in E_U) completely.
- The "concavification cannot improve majority" argument is self-contained and fully justified.
- No logical gaps.

**B.8:**
- Part 1 correctly handles gaps in E_U (disconnected entry set) via the chord argument.
- Part 2 correctly handles p < a via the linearity-from-origin argument.
- The combining step correctly merges the two parts.
- Edge cases a=0 (E_U covers all of (0,1]): Part 2 is vacuous, Part 1 covers everything. CORRECT.
- Edge case mu=1 boundary: handled via Lemma B.7 (1 in E_U whenever E_U nonempty). CORRECT.
- Edge case E_U = emptyset: not explicitly addressed but correct (vacuously true). MINOR GAP.

**Deductions (-2):**
- The E_U = emptyset case deserves a sentence. (-1)
- The proof does not explicitly state what happens at p = p* (the crossing point): is it weak or strict? The theorem says "majority weakly dominates for p < p*" which allows equality at p*. The proof establishes this correctly but doesn't discuss it explicitly. (-1)

### Exposition (20% of grade): 17/20

**Strengths:**
- The proof structure (Preliminary -> Part 1 -> Part 2 -> Combining) is clean and easy to follow.
- The use of m(p) and u(p) as shorthand keeps the notation manageable.
- The footnote explaining u(0) = 0 is well-placed and addresses the most subtle point.
- Cross-references to Lemma 1, Lemma B.7, and Appendix B.6 are all correct.

**Issues:**

1. MINOR (line 1127): lambda_M is used without a local reminder of its definition. A parenthetical "(as in Appendix B.5)" would help.
2. MINOR (line 1129): "piecewise affine (continuous on each branch)" is slightly misleading since V_W has a jump discontinuity at mu_s^{R1}. More precise: "piecewise affine with a possible jump discontinuity at mu_s^{R1}". The conclusion (E_U is a finite union of closed intervals) is correct regardless.
3. MINOR (line 1131): "exposed kink" is nonstandard terminology. "Breakpoint of the concave envelope" would be clearer. For JoP this is fine; for a math journal it would not be.

**Deductions (-3):**
- Missing local reminder for lambda_M definition in B.8. (-1)
- "Piecewise affine (continuous on each branch)" slightly misleading about jump. (-1)
- "Exposed kink" nonstandard but meaning is clear from context. (-1)

---

## Issues Summary

| # | Severity | Location | Issue | Recommendation |
|---|----------|----------|-------|---------------|
| 1 | MINOR | B.8, line 1127 | lambda_M used without local definition reminder | Add "(where lambda_M is as in Appendix B.5)" |
| 2 | MINOR | B.8, line 1129 | "piecewise affine (continuous on each branch)" is slightly misleading -- V_W has a jump discontinuity | Change to "piecewise affine with a possible downward jump at mu_s^{R1}" |
| 3 | MINOR | B.8, line 1131 | "exposed kink" is nonstandard | Consider "breakpoint" or "vertex of the concave envelope" |
| 4 | MINOR | B.8, after line 1125 | E_U = emptyset edge case not addressed | Add: "If E_U = emptyset, then v(mu,U) = 0 everywhere, u = 0, and the dominance set is empty (trivially an upper interval). Henceforth assume E_U nonempty." |
| 5 | MINOR | B.8, Part 1, line 1129 | v(p,M) = m(p) for p in E_U stated without explicit justification | Add: "since p >= a >= tau(M), m(p) = v(p,M) (the concave envelope equals the affine function above tau(M))" |
| 6 | MINOR | B.6, line 1091 | v(p,U) > v(p,M) stated "by Lemma 1" but the bridge from absolute payoffs to net gains is implicit | The alpha*V_e cancellation is obvious; no change needed. Flagging for completeness only. |

---

## Comparison with First Audit

The first audit (15 checks, all PASS) was thorough and correct in its analysis. I independently re-derived every algebraic step and confirm all 15 checks. The first auditor correctly identified the structural importance of the normalization (u(0) = 0 depends on v(0) = 0 under the net-gain definition).

The six MINOR issues I identified are all expositional, not mathematical. The first auditor did not flag these because their scope was narrower (consistency of the normalization change), not general proof quality.

---

## What Must Change to Reach A+

1. Add one sentence handling E_U = emptyset at the start of B.8 (Issue #4).
2. Add "(where lambda_M is as in Appendix B.5)" to line 1127 (Issue #1).
3. Clarify "piecewise affine" language at line 1129 (Issue #2).
4. Add explicit justification for v(p,M) = m(p) in Part 1 (Issue #5).

All four are one-line fixes. None affect mathematical correctness.

---

## Score Breakdown

| Dimension | Weight | Score | Weighted |
|-----------|--------|-------|----------|
| Correctness | 60% | 57/60 | 57 |
| Completeness | 20% | 18/20 | 18 |
| Exposition | 20% | 17/20 | 17 |
| **Total** | | | **92/100** |

**Grade: A** (92/100)

The proofs are mathematically correct, logically complete, and well-structured. The net-gain normalization is consistently applied throughout. All issues are minor and expositional. A JoP referee would find these proofs convincing.
