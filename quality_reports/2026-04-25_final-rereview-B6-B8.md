# Final Re-Review: B.6 and B.8 Proofs After 4 MINOR Fixes

**Date**: 2026-04-25
**Reviewer**: Independent re-reviewer (Claude Opus 4.6)
**File**: `formal_model_v3.Rmd`, lines 1087--1135
**Previous grade**: A (92/100)
**Previous issues**: 6 MINOR (4 targeted for fix, 2 deferred)

---

## GRADE: A+ (97/100)

---

## Fix Verification

### Fix 1 (Issue #1): lambda_M cross-reference -- CONFIRMED
Line 1127 now reads: `...is affine on $E_M$ (where $\lambda_M$ is as defined in Appendix B.5)...`
Cross-reference is correct: lambda_M is defined at line 1042 in B.5.

### Fix 2 (Issue #2): piecewise affine language -- CONFIRMED
Line 1129 now reads: `...is piecewise affine with a possible downward jump at $\mu_s^{R1}$...`
This is precise and correct. The jump is downward because at mu_s^{R1}, the R1 regime switches from aggressive (lower W payoff) to conservative (higher W payoff) as mu increases, so V_W drops when crossing the cutoff from above. The conclusion (E_U is a finite union of closed intervals) follows correctly from the piecewise-affine-with-jump structure.

### Fix 3 (Issue #4): E_U = emptyset edge case -- CONFIRMED
Line 1125 now opens B.8 with: `If $E_U = \emptyset$, then $v(\mu, U) = 0$ for all $\mu$, so $u = 0 \leq m$ and the dominance set is empty---trivially an upper interval.`
This is correct and well-placed. It handles the vacuous case before the main proof begins, and the transition sentence ("For the remainder of the proof, assume $E_U \neq \emptyset$.") cleanly scopes the rest of the argument.

### Fix 4 (Issue #5): explicit justification for v(p,M) = m(p) -- CONFIRMED
Line 1129 now includes: `...where the last equality holds because $p \geq \tau(M)$ and the concave envelope of an affine function equals the function itself.`
This is correct. For p >= tau(M), v(mu,M) = (lambda_M - alpha)V_e(mu) is affine on [tau(M), 1], and the concave envelope of an affine function on an interval equals the function itself. The justification is concise and precisely targeted.

---

## Assessment of Remaining Issues (Not Fixed)

### Issue #3: "exposed kink" terminology (line 1131, footnote)
The footnote reads: "no point in $(0, a)$ can be an exposed kink of the upper hull."
"Exposed kink" is nonstandard in convex analysis. The standard terms would be "vertex of the concave envelope" or "breakpoint of the upper concave envelope." However:
- The meaning is immediately clear from context (the footnote explains itself: "The first kink occurs at some $x \geq a$, and $u$ is affine on $[0, x]$ with $u(0) = 0$").
- This appears in a footnote, not in the main proof text.
- For a JoP audience, clarity of meaning matters more than terminological precision.
**Verdict**: Does not warrant downgrade. The term is informal but unambiguous.

### Issue #6: Implicit bridge from Lemma 1 (absolute payoffs) to v comparison (net gains)
Line 1091 (B.6) states: "By Lemma \ref{lem:conditional}, $v(p, U) > v(p, M)$."
Lemma 1 establishes E[V_H(mu, U)] > E[V_H(mu, M)] (absolute payoffs). The net gain v(mu, R) = E[V_H(mu, R)] - alpha*V_e(mu), where alpha*V_e(mu) is identical under both rules. The cancellation is immediate.
**Verdict**: Does not warrant downgrade. Any reader who has followed the proof to this point will see that the alpha*V_e(mu) term is rule-independent and cancels. Spelling this out would add clutter without adding insight.

---

## Fresh Pass: Checking for Issues Introduced by Fixes

1. **Fix 3 integration with subsequent text**: The edge-case sentence at line 1125 is followed by "Let $m(p) = \operatorname{cav} v(p, M)$ and $u(p) = \operatorname{cav} v(p, U)$. Define $a = \inf E_U$." This is correct: under E_U nonempty (now assumed), a = inf E_U is well-defined. No issue.

2. **Fix 4 sentence placement**: The justification clause is attached to the chain `u(p) >= v(p,U) > v(p,M) = m(p)` after the Lemma reference. The "last equality" unambiguously refers to `v(p,M) = m(p)`. No ambiguity introduced.

3. **Fix 1 parenthetical flow**: The parenthetical "(where $\lambda_M$ is as defined in Appendix B.5)" sits naturally within the Preliminary paragraph. It does not break the sentence structure or obscure the main point (affinity of v on E_M).

4. **Fix 2 precision**: "piecewise affine with a possible downward jump" is more informative than the original "piecewise affine (continuous on each branch)" and is technically correct. No issue.

5. **No new typos, broken references, or logical gaps detected in B.6 or B.8.**

---

## Score Breakdown

| Dimension | Weight | Previous | Current | Notes |
|-----------|--------|----------|---------|-------|
| Correctness | 60% | 57/60 | 59/60 | Fix 4 closes the v=m justification gap. Remaining -1: Issue #6 (implicit bridge, trivial). |
| Completeness | 20% | 18/20 | 20/20 | Fix 3 closes the E_U=emptyset gap. The p=p* boundary behavior is implicit but correct (weak inequality holds by continuity). |
| Exposition | 20% | 17/20 | 18/20 | Fixes 1 and 2 resolve the two substantive expositional issues. Remaining -2: "exposed kink" nonstandard (-1), and one could still argue the footnote is slightly dense (-1). |
| **Total** | | **92/100** | **97/100** | |

---

## Final Assessment

**Grade: A+ (97/100)**

All four fixes were correctly applied. None introduced new issues. The two remaining MINOR items (Issue #3: "exposed kink" in a footnote, Issue #6: implicit alpha*V_e cancellation) are genuinely cosmetic and do not affect correctness, completeness, or readability for the target audience (JoP).

The proofs of Theorem 1 (B.6) and Theorem 2 (B.8) are mathematically correct, logically complete, well-structured, and now properly annotated. A JoP referee would find these proofs convincing and self-contained.

**No further changes recommended.**
