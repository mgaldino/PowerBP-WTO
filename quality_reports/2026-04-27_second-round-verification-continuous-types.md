# Second-Round Verification: Screening Rent Under Continuous Types

**Reviewer**: Rigorous mathematical second-round verifier
**Date**: 2026-04-27
**File reviewed**: `notes/2026-04-27_screening_rent_continuous.md`

## Grade: A-

The proof is substantially improved from B+ and is now nearly publication-ready. All four claimed fixes were implemented and three are fully correct. Fix 4 (uniform example) contains a mathematical error in the discussion of the $r < 2$ case -- the claim that an interior optimum "may" arise under the uniform distribution is false -- but this error is non-critical (it occurs in an illustrative remark, not in the main proof line, and the proof's conclusions do not depend on it). One subtle conceptual issue regarding R2 beliefs in the R1 proof deserves a brief remark but is not an error. The grade of A- (rather than A+) reflects the erroneous uniform-distribution claim and one conceptual gap worth flagging.

---

## Fix 1 (boundary density): VERIFIED

The previous version required $f(1) > 0$, which fails for many distributions (e.g., Beta distributions with shape parameter > 1). The revised proof uses a direct argument:

1. $\pi_W(1) = 0$ (integral over empty interval). Correct.
2. For $\epsilon > 0$ small, the integrand on $[1, 1+\epsilon]$ satisfies $\theta - \alpha(1+\epsilon) \geq 1 - \alpha(1+\epsilon)$. Correct (since $\theta \geq 1$).
3. Since $\alpha < 1/r < 1$, for $\epsilon$ small enough $\alpha(1+\epsilon) < 1$, so $1 - \alpha(1+\epsilon) > 0$. Correct.
4. Full support implies $F(1+\epsilon) > 0$ for every $\epsilon > 0$. Correct.
5. Therefore $\pi_W(1+\epsilon) \geq (1-\alpha(1+\epsilon)) \cdot F(1+\epsilon) > 0$. Correct.

The bound $\pi_W(1+\epsilon) \geq (1-\alpha(1+\epsilon)) \cdot F(1+\epsilon)$ is tight: it replaces the integrand by its minimum on $[1, 1+\epsilon]$ and notes the resulting integral equals the minimum times the measure. This is rigorous and requires only full support, not $f(1) > 0$.

Weierstrass existence argument is clean and correct.

**Verdict**: Fix is correct and complete. The argument is stronger than the original.

---

## Fix 2 (R1 proof): VERIFIED (with one conceptual remark)

The R1 proof is now fully fleshed out. Key verification points:

### R2 continuation value formula (line 121)
$$V_H^{R2}(\theta, U) = \frac{1}{N}\theta + \frac{N-1}{N}\begin{cases}\alpha\theta_2^* & \theta \leq \theta_2^* \\ \alpha\theta & \theta > \theta_2^*\end{cases}$$

Correct: $H$ keeps $\theta$ when proposing (prob $1/N$), gets $\alpha\theta_2^*$ or $\alpha\theta$ when $W$ proposes (prob $(N-1)/N$).

### Piecewise-linear form of $\beta V_H^{R2}(\theta, U)$

- Low piece ($\theta \leq \theta_2^*$): slope $\beta/N$, intercept $\beta(N-1)\alpha\theta_2^*/N$. Verified.
- High piece ($\theta > \theta_2^*$): slope $\beta[1+(N-1)\alpha]/N$. Verified.
- Continuity at $\theta_2^*$: both pieces give $\beta\theta_2^*[1+(N-1)\alpha]/N$. Verified.
- Strict monotonicity: slopes are positive in both pieces. Verified.

### The inequality $\theta_1^* > 1$

The proof shows the integrand at $\theta = 1$ is $1 - \beta[1+(N-1)\alpha\theta_2^*]/N$, and bounds this:
$$\frac{\beta[1 + (N-1)\alpha\theta_2^*]}{N} \leq \frac{\beta[1 + (N-1)\alpha r]}{N} < \frac{1 + (N-1)}{N} = 1$$

I verified this chain: the first $\leq$ uses $\theta_2^* \leq r$. The strict $<$ uses $\alpha r < 1$ (giving $(N-1)\alpha r < N-1$) and $\beta < 1$. Both conditions contribute. The bound is correct.

### Rent computation (lines 169-173)

The algebra of splitting $\int_1^r$ and canceling $\int_{\theta_1^*}^r$ terms is standard and correct. The final integrand $\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)$ is strictly positive for $\theta < \theta_1^*$ by strict monotonicity.

### Conceptual remark on R2 beliefs

The proof computes $V_H^{R2}(\theta, U)$ using the R2 cutoff $\theta_2^*$ derived from the prior $F$. In a Perfect Bayesian Equilibrium, if types $\theta \leq \theta_1^*$ accept in R1 and types $\theta > \theta_1^*$ reject, then R2 beliefs should be $F$ truncated to $(\theta_1^*, r]$. This would change the R2 cutoff.

However, this does not invalidate the proof because:
1. The structural properties needed (strict monotonicity of the R2 continuation value, R2 cutoff above the lower bound of the support) hold for any truncated distribution with full support.
2. The proof establishes screening rent > 0 for any R2 continuation that is strictly increasing -- a property that is invariant to the specific R2 beliefs.

Recommendation: add one sentence noting that the R1 analysis holds for any belief-consistent R2 continuation, since the key property (strict monotonicity of $V_H^{R2}$) is preserved under truncation.

**Verdict**: Fix is correct and complete. The R1 proof is now rigorous, not a sketch.

---

## Fix 3 (scope): VERIFIED

The Scope paragraph (line 22) correctly states:
1. The proposition establishes robustness of the screening mechanism. True.
2. It does NOT claim $V_H(U) > V_H(M)$ in total. True.
3. The reason: $H$-proposes components differ (majority coalition vs. unanimity). True.
4. Theorem 1 handles full dominance for $K = 2$. True.

The Proposition itself is restructured into parts (a)-(d):
- (a) R2 screening under unanimity: cutoff + positive rent. Matches proof.
- (b) R1 screening under unanimity: same structure, positive rent. Matches proof.
- (c) Majority: zero rent. Matches proof.
- (d) Summary statement about qualitative mechanism. Matches proof.

Part (d) says "the qualitative mechanism extends to arbitrary continuous type distributions" -- this is precisely calibrated. It claims the MECHANISM extends, not the full dominance result.

**Verdict**: Fix is correct and well-calibrated. The scope is honest about what is and isn't proven.

---

## Fix 4 (uniform example): PARTIALLY VERIFIED -- CONTAINS AN ERROR

The proof distinguishes $r \geq 2$ and $r < 2$ for the uniform distribution. The $r \geq 2$ case is correct: $\alpha < 1/r \leq 1/2$ implies $1-2\alpha \geq 0$, so $\pi_W' > 0$ on $[1,r]$ and $\theta_2^* = r$.

**The $r < 2$ case is mathematically wrong.** The proof claims (line 60):

> When $1 < r < 2$, $\alpha$ can exceed $1/2$ while satisfying $\alpha < 1/r$ [...] in which case $1-2\alpha < 0$ and the numerator $\theta^*(1-2\alpha) + \alpha$ may change sign, yielding an interior optimum $\theta_2^* < r$.

The numerator $\theta^*(1-2\alpha) + \alpha$ vanishes at $\theta^* = \alpha/(2\alpha-1)$. For an interior zero on $[1, r]$, we need $\alpha/(2\alpha-1) \leq r$, i.e., $\alpha \geq r/(2r-1)$. Combined with $\alpha < 1/r$, this requires $r/(2r-1) < 1/r$, i.e., $r^2 < 2r - 1$, i.e., $(r-1)^2 < 0$. This is impossible.

Therefore, **for the uniform distribution on $[1,r]$ with $\alpha < 1/r$, the optimum is always $\theta_2^* = r$, regardless of $r$.** The interior-optimum case cannot arise under the uniform.

Concrete verification with the cited example ($r = 1.5$, $\alpha = 0.6$): the numerator $\theta^*(1-1.2) + 0.6 = -0.2\theta^* + 0.6$ vanishes at $\theta^* = 3 > r = 1.5$. On $[1, 1.5]$, the numerator ranges from $0.4$ to $0.3$, always positive. So $\pi_W' > 0$ and $\theta_2^* = 1.5 = r$.

**Impact**: LOW. This error is in an illustrative remark about the location of the optimum, not in the main proof. The proof's conclusions (screening rent > 0) hold for any $\theta_2^* \in (1, r]$, including $\theta_2^* = r$. The first bullet (non-uniform distributions with small $f(r)$) correctly identifies cases with interior optima.

**Recommended fix**: Replace the $r < 2$ discussion with: "For the uniform distribution on $[1,r]$ with $\alpha < 1/r$, one can verify that $\pi_W' > 0$ on $[1,r]$ for all admissible $\alpha$, so $\theta_2^* = r$ always (pool all types). Interior optima arise for distributions with sufficiently light right tails, as shown in the first bullet above."

**Verdict**: Partially verified. The $r \geq 2$ case is correct; the $r < 2$ case contains a false claim. Non-critical.

---

## New issues found

### Issue N1 (minor): R2 beliefs after R1 rejection

As noted in Fix 2, the R1 analysis uses $V_H^{R2}(\theta, U)$ computed under the prior. In a PBE, R2 beliefs after R1 rejection should be the posterior $F|\theta > \theta_1^*$. The proof's conclusions survive this issue (the required structural properties -- monotonicity, cutoff above the support's lower bound -- hold for truncated distributions), but a sentence acknowledging this would strengthen the argument.

**Severity**: LOW (conceptual hygiene, not a logical gap).

### Issue N2 (cosmetic): Step numbering gap

The proof has Steps 1, 2, 3, 4, 5, 6, 7 but no Step numbering for the transition. Step 5 covers "R2 combined payoff comparison" and Step 6 jumps to "R1 screening." This is fine structurally but the description of Step 5 as "W-proposes component only" is slightly redundant with Step 3.

**Severity**: COSMETIC.

### Issue N3 (cosmetic): Proposition part (b) notation

Part (b) of the Proposition uses $\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)$ in the integrand, which is correct but the Proposition statement doesn't define $V_H^{R2}(\theta, U)$ -- the reader must look to the proof for the formula. A brief inline definition or forward reference would help.

**Severity**: COSMETIC.

---

## Overall assessment

The revised proof represents a substantial improvement over the B+ version. The three main structural issues (boundary density, R1 sketch, and scope) have been correctly and thoroughly addressed. The boundary density argument is now elegant and requires only the minimal assumption of full support. The R1 proof is fully explicit, computing $\beta V_H^{R2}(\theta, U)$ piece by piece and verifying all required properties. The scope paragraph is honest and precisely calibrated.

The uniform-distribution claim in Fix 4 is mathematically incorrect: the proof asserts that an interior optimum can arise under the uniform when $r < 2$, but algebraic verification shows this is impossible for any $\alpha < 1/r$. This is a genuine mathematical error, but it is confined to an illustrative remark and does not affect any result in the main proof line. The screening rent positivity holds for $\theta_2^* = r$ (pooling) just as well as for interior cutoffs.

The conceptual issue of R2 beliefs (Issue N1) is worth acknowledging in a sentence, but does not constitute a logical gap since the structural properties of the R2 continuation survive truncation of the support.

Grade rationale: The proof merits A- rather than A+ because of the erroneous uniform-example claim (a mathematical mistake, even if non-critical) and the R2-beliefs subtlety that deserves acknowledgment. Correcting these two items would bring it to A+.
