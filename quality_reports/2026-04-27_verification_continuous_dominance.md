# Mathematical Verification: Uniform Continuous Dominance

**Date**: 2026-04-27  
**File reviewed**: `notes/2026-04-27_uniform_continuous_dominance.md`  
**Reviewer**: Claude Opus 4.6 (1M context), merciless mathematical audit  

## Grade: A

The derivation is mathematically correct in all essential steps. The key result -- that $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ for all parameters -- admits a clean algebraic proof (not just numerical evidence), which the note understates. Two minor issues found (one cosmetic, one missing argument). No errors that affect the results.

---

## Part-by-part verification

### Part 1 (R2 Equilibrium): PASS

**R2 pooling claim** ($\theta_2^* = r$): Verified. The FOC root $\theta^* = \alpha/(2\alpha-1)$ lies outside $[1,r]$ for all $\alpha \in (0, 1/r)$:
- For $\alpha < 1/2$: denominator $2\alpha - 1 < 0$, so $\theta^* < 0 < 1$.
- For $\alpha \in [1/2, 1/r)$: the condition $\theta^* > r$ reduces to $(r-1)^2 > 0$, which holds strictly for $r > 1$.

The $(r-1)^2 \leq 0$ argument in the note is correct. Numerically verified for all parameter combinations.

**Continuation values**: Structurally correct.
- $V_H^{R2}(\theta, U) = (\theta + x)/N$: H proposes (prob $1/N$, keeps $\theta$) + W proposes (prob $(N-1)/N$, H gets $\alpha r$). The average is $\theta/N + (N-1)\alpha r/N = (\theta + x)/N$. Correct.
- $V_H^{R2}(\theta, M) = \theta(1+(N-1)\alpha)/N$: Same structure but W excludes H, who gets $\alpha\theta$. Correct.
- Expected values: mechanical integration over Uniform$[1,r]$. Verified.

**Critical subtlety verified**: After R1 rejection under unanimity, the posterior is Uniform$[\theta_1^*, r]$. The R2 pooling result $\theta_2^* = r$ still holds because the FOC root $\alpha/(2\alpha - 1)$ is independent of the support of the Uniform. So $V_H^{R2}$ is the same expression $(\theta + x)/N$ on the posterior.

### Part 2 (R1 Under Unanimity): PASS

**H proposes**: Correct. H offers $\beta \cdot E[V_W^{R2}(\theta, U)]$ to each W. The key observation is that H's offer is type-independent (because $V_W^{R2} = (\theta - \alpha r)/N$ and the expectation is over the prior, not the realized $\theta$). W's beliefs are unchanged after rejection -- confirmed by the type-independence of the offer.

Verified: $E[V_W^{R2}] = [(1+r)/2 - \alpha r]/N = (1+r-2\alpha r)/(2N)$. Matches the note.

**W proposes -- offer to H**: $y_H = \beta(\theta_1^* + x)/N$. Correct: H's reservation value $\beta V_H^{R2}(\theta, U) = \beta(\theta + x)/N$ is increasing in $\theta$; to get all types $\theta \leq \theta_1^*$ to accept, offer must match the cutoff type's value.

**W proposes -- offer to non-proposing W's**: The derivation in the Appendix is verified algebraically. The key step -- subtracting the acceptance and rejection payoffs and simplifying to $(s-1)(s+1-2\alpha r)/2$ -- is correct. Verified numerically that the acceptance condition holds with equality at the formula value. One note: at $s=1$ the constraint is vacuous (the acceptance condition reduces to $\beta E[V_W^{R2}] \geq \beta E[V_W^{R2}]$), so $y_{W_i}(1)$ is not pinned. This is harmless since $s=1$ is a boundary of the optimization domain.

**W's optimization -- quadratic in $s$**: This is the critical step. I verified numerically that $2N(r-1)\Pi_{W_k}(s)$ is indeed quadratic in $s$ with:
- Coefficient of $s^2$: $N - (N+1)\beta$ (independent of $\alpha$) -- **verified to machine precision for 5 parameter combinations**.
- Coefficient of $s$: $2\beta$ (independent of $\alpha$) -- **verified to machine precision**.
- Constant term: depends on $\alpha$ but not on $s$.

**Alpha-independence of $\theta_1^*$**: This is a strong result. It holds because $\alpha$ enters W's objective only through (i) the offer to H ($y_H$, which is $\alpha r \cdot (N-1)/N$ plus terms independent of $\alpha$), (ii) the R2 continuation, and (iii) the offer to other W's. But all three $\alpha$-dependent terms contribute only to the constant in $s$, not to the $s^2$ or $s$ coefficients. Verified numerically: the optimal cutoff at $\alpha = 0.01$ and $\alpha = 1/r - 0.01$ coincide for all 8 test cases. This mirrors the $K=2$ result and has the same structural origin: $\alpha$ scales all payoffs uniformly when the screening cutoff lies in the "high branch."

**Cutoff formula**: The two-regime structure (boundary $\theta_1^* = r$ vs. interior cutoff) is correct. The threshold $\beta = Nr/[(N+1)r - 1]$ unifies the cases: verified that $s^* = r$ at this threshold value. The FOC root $\beta/[(N+1)\beta - N]$ is verified against numerical optimization.

**H's expected payoff from W's proposal**: The integral
$$\int_1^{\theta_1^*} \frac{\beta(\theta_1^*+x)}{N} \frac{d\theta}{r-1} + \int_{\theta_1^*}^r \frac{\beta(\theta+x)}{N} \frac{d\theta}{r-1}$$
is evaluated correctly. I traced each algebraic step:
1. $(\theta_1^*-1)(\theta_1^*+x) + (r^2 - (\theta_1^*)^2)/2 + (r-\theta_1^*)x$ -- correct.
2. Expanding and collecting: $(\theta_1^*)^2/2 + r^2/2 - \theta_1^* + (r-1)x$ -- correct.
3. Rewriting as $((\theta_1^*-1)^2 + r^2 - 1)/2 + (r-1)x$ -- correct (since $\theta_1^*{}^2 - 2\theta_1^* + 1 = (\theta_1^*-1)^2$ and $r^2 - 1 = (r-1)(r+1)$).
4. Dividing by $(r-1)$: $(\theta_1^*-1)^2/(2(r-1)) + (r+1)/2 + x$ -- correct.

Boundary checks pass: at $\theta_1^* = 1$ recovers $\beta E[V_H^{R2}]$; at $\theta_1^* = r$ recovers $\beta(r+x)/N$.

**Combined R1 payoff**: The algebra from the two-component formula to the boxed expression is verified. The key cancellation $(1+r)/2 - (1+r-2\alpha r)/2 = \alpha r$, and then $\alpha r + x = N\alpha r$. Verified numerically.

### Part 3 (R1 Under Majority): PASS

**H proposes**: Correct. Under majority, H buys $q-1$ votes at $\beta E[V_W^{R2}(M)] = \beta(1-\alpha)E[\theta]/N$ each.

**W proposes**: Correct. W excludes H, forms coalition of $q$ weak states. H captures $\alpha\theta$ from bilateral alternative. No discounting (deal passes in R1).

**Combined formula**: $E[V_H^{R1}(M)] = \lambda_M \cdot (1+r)/2$ where $\lambda_M = (N + C_{\text{out}} - C_{\text{buy}})/N^2$. Verified that this matches the paper's formula exactly. Numerically confirmed.

### Part 4 (D formula): PASS

The derivation of $D$ is correct:

$$D = \frac{1}{2N^2}\left[\frac{(N-1)\beta(\theta_1^*-1)^2}{r-1} + (1+r)C_{\text{buy}} - C_{\text{out}}(1+r-2\beta r)\right]$$

I verified this in two ways:
1. Direct subtraction of boxed formulas (equations 6 and 8).
2. Independent numerical computation for 7 parameter combinations (Monte Carlo with $10^6$ draws). All discrepancies $O(10^{-5})$, consistent with sampling error.

The three-term decomposition (screening rent, vote-buying advantage, outside-option cost) is structurally correct.

### Part 5 (alpha* threshold): PASS

$D$ is confirmed affine in $\alpha$. The threshold $\alpha^*_{\text{cont}} = A/\Lambda$ where:
- $A = (N-1)\beta(\theta_1^*-1)^2/(r-1) + (1+r)\beta(q-1)$ (positive, $\alpha$-independent)
- $\Lambda = (1+r)\beta(q-1) + N(N-1)(1+r-2\beta r)$

Verified: $D(\alpha^*_{\text{cont}}) = 0$ to machine precision for all tested parameter combinations.

The sign analysis of $\Lambda$ is correct:
- When $\beta > (1+r)/(2r)$, the term $N(N-1)(1+r-2\beta r) < 0$, which can make $\Lambda < 0$ (unconditional dominance).
- The worked examples ($N=5, r=1.5, \beta=0.9$: $\Lambda = 0.5 > 0$; $N=5, r=2, \beta=0.9$: $\Lambda = -6.6 < 0$) are verified.

The $r \to 1$ limit is verified: $\alpha^*_{\text{cont}} \to \alpha^*_{K=2}$ as $r \to 1^+$. Numerically confirmed with $r \in \{1.01, 1.001, 1.0001\}$.

### Part 6 (Comparison $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$): PASS with upgrade

The note states this is based on "numerical comparison across a wide range of parameters." However, a **clean algebraic proof exists** and the note undervalues its own result.

**Algebraic proof** (verified independently):

Let $B = \beta(q-1)$ and $C = N(N-1)$, and $S = (N-1)\beta(\theta_1^*-1)^2/(r-1) \geq 0$. Then:

$$\alpha^*_{\text{cont}} = \frac{S + (1+r)B}{(1+r)B + C(1+r - 2\beta r)}, \qquad \alpha^*_{K=2} = \frac{B}{B + C(1-\beta)}.$$

**Case 1**: $\Lambda \leq 0$. Then $D > 0$ for all $\alpha \in (0, 1/r)$: unconditional dominance. Trivially $\geq \alpha^*_{K=2}$.

**Case 2**: $\Lambda > 0$. Even setting $S = 0$ (worst case for the comparison):

$$\alpha^*_{\text{cont}}\big|_{S=0} = \frac{(1+r)B}{(1+r)B + C(1+r-2\beta r)}.$$

The inequality $\alpha^*_{\text{cont}}|_{S=0} \geq \alpha^*_{K=2}$ reduces (after cross-multiplication) to:

$$(1+r) \cdot C(1-\beta) \geq C(1+r - 2\beta r),$$

which simplifies to $\beta(r-1) \geq 0$. This holds strictly for $\beta > 0, r > 1$.

Since $S \geq 0$ only increases the numerator of $\alpha^*_{\text{cont}}$ while $\Lambda$ is unchanged, the full inequality $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ follows. Equality holds iff $S = 0$ and $r = 1$ (degenerate type space).

This is a **rigorous proof, not just numerical evidence**. The note should be strengthened accordingly.

---

## Issues found

1. **[MINOR, cosmetic]** In the Appendix derivation of $y_{W_i}(\theta_1^*)$, the verification at $\theta_1^* = 1$ (line 81) is garbled: "beta(1-alpha r)/N * (2-2*alpha r)/(2N)..." appears to be an incomplete edit. The formula is correct but the textual verification is unclear. At $s = 1$, the constraint is vacuous (LHS = RHS = $\beta E[V_W^{R2}]$) so the formula value doesn't matter for the optimization. **Impact: none.**

2. **[MINOR, missing argument]** The comparison in Part 6 is described as purely numerical ("the numerical comparison across a wide range of parameters uniformly confirms"). As shown above, a clean 3-step algebraic proof exists (and is only 4 lines). Presenting the result as numerical understates its strength. **Recommendation**: Add the algebraic proof and demote the numerical grid search to a verification role.

3. **[COSMETIC]** Table 1 includes negative values for $\alpha^*_{\text{cont}}$ (e.g., $-1.36$, $-3.20$). While the note correctly interprets these as "unconditional dominance," a reader encountering a negative threshold for the first time may be confused. A footnote explaining that $\alpha^*_{\text{cont}} < 0$ or $\alpha^*_{\text{cont}} > 1/r$ means $D > 0$ for all $\alpha \in (0, 1/r)$ would help.

4. **[COSMETIC]** The "Remark on alpha-independence" (lines 105--106) could note that this result is structurally identical to the $K=2$ case (where the independence holds for $\alpha < \bar{\alpha}$) but stronger: in the continuous model it holds globally because the FOC root's position relative to $[1,r]$ is independent of $\alpha$.

---

## Specific concerns addressed

1. **R1 cutoff $\theta_1^*$ -- is the FOC correctly computed?** Yes. The quadratic structure of $2N(r-1)\Pi_{W_k}(s)$ is verified to machine precision for 5 parameter combinations. The $s^2$ coefficient is $N - (N+1)\beta$ and the $s$ coefficient is $2\beta$, both independent of $\alpha$.

2. **Is the claim that $\theta_1^*$ is independent of $\alpha$ correct?** Yes. This is the strongest version of a result that appears in weaker form ($\alpha < \bar{\alpha}$) in the $K=2$ model. In the continuous model, the independence holds for all $\alpha \in (0, 1/r)$ because $\alpha$ enters $W$'s objective only through the constant term in $s$. Verified numerically (optimization at $\alpha = 0.01$ and $\alpha = 1/r - 0.01$ gives the same cutoff to within $10^{-15}$).

3. **$E[V_H^{R1}(U)]$ aggregation**: Correct. The three components (H proposes; W proposes, $\theta \leq \theta_1^*$ accepts; W proposes, $\theta > \theta_1^*$ rejects) are correctly weighted and the integral is correctly evaluated. The R2 continuation after rejection uses the correct posterior (Uniform$[\theta_1^*, r]$) with the correct R2 pooling result ($\theta_2^* = r$ still holds).

4. **$E[V_H^{R1}(M)]$ aggregation**: Correct. When W proposes, H gets $\alpha\theta$ (bilateral alternative, no discounting since the deal passes in R1). When H proposes, H buys $q-1$ votes at discounted R2 continuation values. The formula matches the paper's $\lambda_M$ expression.

5. **D formula**: Correct. Verified by direct subtraction and by Monte Carlo.

6. **$\alpha^*$ comparison**: The claim $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ is **rigorously proved**, not just numerically observed. The algebraic proof reduces to $\beta(r-1) \geq 0$. The grid search (1,008 combinations, 0 violations) serves as independent confirmation.

---

## Overall assessment

This is a carefully executed derivation. Every integral, every algebraic manipulation, and every boundary check I performed confirms the note's results. The closed-form expressions for the R1 cutoff, the expected payoffs, the payoff difference $D$, and the threshold $\alpha^*_{\text{cont}}$ are all correct. The numerical verification infrastructure (three independent R scripts with Monte Carlo and grid search) is solid.

The main result -- that the continuous Uniform model generates a strictly larger parametric region for unanimity dominance -- is correct and actually stronger than the note claims: it admits a clean algebraic proof, not just numerical evidence. This is a significant finding that directly addresses the $K > 2$ concern raised in the paper's Appendix C and in the coarse review.

The only weakness is expositional: the algebraic proof of $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ should be stated explicitly rather than relegated to numerical evidence. This would elevate Part 6 from "confirmed numerically" to "proved analytically with numerical verification."
