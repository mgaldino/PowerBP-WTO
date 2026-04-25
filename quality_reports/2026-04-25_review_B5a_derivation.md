# Review: Appendix B.5a — Derivation of the Payoff Decomposition

**Date**: 2026-04-25  
**Reviewer**: Claude (Senior Code Reviewer)  
**File**: `formal_model_v3.Rmd`, lines 958--1035  
**Grade**: **A-**

---

## Summary

Appendix B.5a derives the decomposition $D(\mu) = D_{\text{base}} + \mathbf{1}\{\mu < \mu_s^{R2}\}\cdot\delta_{R2} + \mathbf{1}\{\mu > \mu_s^{R1}\}\cdot\delta_{R1}$ from primitive payoff formulas. The derivation is well-structured, clearly written, and algebraically correct in all steps. The additivity argument is rigorous and well-justified. I found one MAJOR issue (an undefined variable) and three MINOR issues.

---

## 1. Algebraic Correctness

### Step 0: Primitive payoff components

**H proposes (eq. \eqref{eq:H_prop_component}):**
$$\Pi_H^{\text{prop}}(\mu) = \frac{V_e(\mu) - (N-1)\beta V_W^{R2}(\mu)}{N}$$

Verification: H keeps the entire expected pie minus what it pays to $(N-1)$ weak states. Each weak state receives $\beta V_W^{R2}(\mu)$ (discounted R2 continuation). The factor $1/N$ accounts for H being proposer with probability $1/N$. **CORRECT.**

**W proposes (eq. \eqref{eq:W_prop_component}):**

Under aggressive R1, H's expected payoff from W's proposal:
- $\theta=0$ (prob $1-\mu$): accepts, gets $\beta V_H^{R2}(\theta{=}0, \mu'{=}1) = \beta(1+x)/N$
- $\theta=1$ (prob $\mu$): rejects, gets $\beta V_H^{R2}(\theta{=}1, \mu'{=}1) = \beta(r+x)/N$

Cross-check with A.2:
- $V_H^{R2}(\theta=0, \mu>\mu_s^{R2}) = (1+(N-1)\alpha r)/N = (1+x)/N$. At $\mu'=1 > \mu_s^{R2}$, this is in the conservative regime. **CORRECT.**
- $V_H^{R2}(\theta=1, \mu) = r[1+(N-1)\alpha]/N = (r+x)/N$ (using $(N-1)\alpha r = x$ implies $(N-1)\alpha = x/r$, so $r[1+(N-1)\alpha]/N = r[1+x/r]/N = (r+x)/N$). **CORRECT.**

Under conservative R1, both types get $\beta(r+x)/N$. Weighted by $(N-1)/N$. **CORRECT.**

### Step 1: Benchmark (aggressive R1, conservative R2)

$V_W^{R2,\text{con}}(\mu) = [V_e(\mu) - \alpha r]/N$ (from A.2, line 876). **CORRECT.**

$\Pi_H^{\text{prop}}|_{\text{con-}R2}$:
$$\frac{V_e(\mu) - (N-1)\beta[V_e(\mu)-\alpha r]/N}{N} = \frac{NV_e(\mu) - (N-1)\beta[V_e(\mu)-\alpha r]}{N^2}$$
**CORRECT** (multiply numerator and denominator by $N$).

$\Pi_H^{W}|_{\text{agg-}R1}$: Under aggressive R1, H's expected payoff is:
$$\frac{N-1}{N}\left[\mu\frac{\beta(r+x)}{N} + (1-\mu)\frac{\beta(1+x)}{N}\right] = \frac{(N-1)\beta}{N^2}[\mu(r+x)+(1-\mu)(1+x)]$$
$$= \frac{(N-1)\beta}{N^2}[\mu r + \mu x + 1 + x - \mu - \mu x] = \frac{(N-1)\beta}{N^2}[1+\mu(r-1)+x] = \frac{(N-1)\beta[V_e(\mu)+x]}{N^2}$$
**CORRECT.**

Summing for $E_{\text{bench}}$:
$$\frac{NV_e - (N-1)\beta V_e + (N-1)\beta\alpha r + (N-1)\beta V_e + (N-1)\beta x}{N^2}$$
The $-(N-1)\beta V_e$ and $+(N-1)\beta V_e$ cancel:
$$= \frac{NV_e + (N-1)\beta(\alpha r + x)}{N^2}$$
Using $\alpha r + x = \alpha r + (N-1)\alpha r = N\alpha r$:
$$= \frac{NV_e + (N-1)\beta N\alpha r}{N^2}$$
**CORRECT.**

### Step 2: $\delta_{R1}$

$\Pi_H^W|_{\text{con}} = \frac{(N-1)\beta(r+x)}{N^2}$.

$\Pi_H^W|_{\text{agg}} = \frac{(N-1)\beta[V_e(\mu)+x]}{N^2}$.

$$\delta_{R1} = \frac{(N-1)\beta}{N^2}[(r+x) - (V_e(\mu)+x)] = \frac{(N-1)\beta}{N^2}[r - V_e(\mu)]$$
$$= \frac{(N-1)\beta}{N^2}[r - 1 - \mu(r-1)] = \frac{(N-1)\beta(r-1)(1-\mu)}{N^2}$$
**CORRECT.** Non-negative for $\mu \leq 1$, zero at $\mu=1$.

### Step 3: $\delta_{R2}$

$V_W^{R2,\text{agg}}(\mu) = (1-\mu)(1-\alpha)/N$ (from A.2, line 875). **CORRECT.**

$$\delta_{R2} = \Pi_H^{\text{prop}}|_{\text{agg-}R2} - \Pi_H^{\text{prop}}|_{\text{con-}R2}$$
$$= \frac{V_e - (N-1)\beta(1-\mu)(1-\alpha)/N}{N} - \frac{V_e - (N-1)\beta[V_e-\alpha r]/N}{N}$$
$$= \frac{-(N-1)\beta}{N^2}[(1-\mu)(1-\alpha) - (V_e(\mu) - \alpha r)]$$
$$= \frac{(N-1)\beta}{N^2}[V_e(\mu) - \alpha r - (1-\mu)(1-\alpha)]$$

Expanding the bracket:
$$V_e(\mu) - \alpha r - (1-\mu)(1-\alpha) = 1+\mu(r-1) - \alpha r - 1 + \mu + \alpha - \mu\alpha$$
$$= \mu(r-1) - \alpha r + \mu + \alpha - \mu\alpha = \mu r - \mu - \alpha r + \mu + \alpha - \mu\alpha$$
$$= \mu r - \alpha r + \alpha - \mu\alpha = \mu(r-\alpha) - \alpha(r-1)$$
**CORRECT.**

At $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$:
$$\mu_s^{R2}(r-\alpha) - \alpha(r-1) = \alpha(r-1) - \alpha(r-1) = 0$$
**CORRECT.** Continuity confirmed.

Cross-check with B.5 (line 1047): $\delta_{R2}(\mu) = \frac{(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]}{N^2}$. **MATCHES.**

### Step 5: $D_{\text{base}}$

$\lambda_M = [N(1+(N-1)\alpha) - C_{\text{buy}}]/N^2$ with $C_{\text{buy}} = \beta(q-1)(1-\alpha)$.

$$D_{\text{base}} = E_{\text{bench}} - \lambda_M V_e(\mu)$$
$$= \frac{NV_e + (N-1)\beta N\alpha r}{N^2} - \frac{N(1+(N-1)\alpha) - C_{\text{buy}}}{N^2}V_e$$
$$= \frac{V_e[N - N(1+(N-1)\alpha) + C_{\text{buy}}] + (N-1)\beta N\alpha r}{N^2}$$
$$= \frac{V_e[N - N - N(N-1)\alpha + C_{\text{buy}}] + C_{\text{out}}\beta r}{N^2}$$

Here $C_{\text{out}} = N(N-1)\alpha$, so $(N-1)\beta N\alpha r = C_{\text{out}}\beta r$. **CORRECT.**

And $N - N - N(N-1)\alpha = -C_{\text{out}}$, so:
$$= \frac{(C_{\text{buy}} - C_{\text{out}})V_e + C_{\text{out}}\beta r}{N^2}$$
**CORRECT.** Matches B.5 (line 1046).

---

## 2. Consistency with B.5

All three formulas derived in B.5a match exactly what B.5 states in Step 1 (lines 1046--1048):
- $D_{\text{base}}(\mu) = \frac{(C_{\text{buy}}-C_{\text{out}})V_e(\mu) + C_{\text{out}}\beta r}{N^2}$ -- **MATCHES** eq. \eqref{eq:Dbase_derived}
- $\delta_{R2}(\mu) = \frac{(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]}{N^2}$ -- **MATCHES**
- $\delta_{R1}(\mu) = \frac{(N-1)\beta(r-1)(1-\mu)}{N^2}$ -- **MATCHES**

---

## 3. Consistency with Appendix A

- **A.1** (Majority): $V_H^{R2}(\theta, M) = V(\theta)[1+(N-1)\alpha]/N$. This is used in the majority payoff $E[V_H^{R1}(\mu, M)] = \lambda_M V_e(\mu)$. The derivation in B.5a does not explicitly derive $\lambda_M$ from scratch (it takes it as given from B.5), but the formula is consistent. **OK.**
- **A.2** (Unanimity R2): Conservative and aggressive R2 values are correctly used throughout. **OK.**
- **A.3** (Unanimity R1): The screening cutoff definition is consistent. The R1 offer structure matches. **OK.**

---

## 4. Notation Consistency

- $x \equiv (N-1)\alpha r$: Used correctly throughout (lines 971-972, 987, 994, 997, 999).
- $V_e(\mu) = 1 + \mu(r-1)$: Used correctly.
- $\lambda_M$, $C_{\text{buy}}$, $C_{\text{out}}$: Defined and used consistently with B.5.

---

## 5. Additivity Argument (Step 4)

The claim is that $\delta_{R2}$ and $\delta_{R1}$ are independent corrections, so the total payoff can be written additively.

**Analysis:** The argument rests on two observations stated in the "Two features" paragraph (line 982):

1. $\Pi_H^{\text{prop}}$ depends on $V_W^{R2}(\mu)$ but NOT on the R1 regime.
2. $\Pi_H^W$ depends on the R1 regime but NOT on $V_W^{R2}(\mu)$.

For (1): The H-proposes payoff formula (eq. \eqref{eq:H_prop_component}) is $[V_e(\mu) - (N-1)\beta V_W^{R2}(\mu)]/N$. This depends on $V_W^{R2}(\mu)$ (which changes at $\mu_s^{R2}$) but not on whether R1 is aggressive or conservative. **CORRECT** -- the R1 regime determines what W offers H, not what H offers W.

For (2): The W-proposes payoff (eq. \eqref{eq:W_prop_component}) depends on $\beta V_H^{R2}(\theta, \mu'=1)$, where $\mu'=1$ is the off-path posterior after rejection. Since $\mu'=1 > \mu_s^{R2}$ always, these R2 values are always in the conservative regime, regardless of the on-path $V_W^{R2}(\mu)$.

**Key question: Does the R1 offer level depend on $V_W^{R2}(\mu)$?**

The R1 conservative offer to H is $\beta V_H^{R2}(\theta=1, \mu'=1) = \beta(r+x)/N$. This is the R2 value at $\mu'=1$, NOT at $\mu$. So it does NOT depend on $V_W^{R2}(\mu)$.

The R1 aggressive offer to H is $\beta V_H^{R2}(\theta=0, \mu'=1) = \beta(1+x)/N$. Same logic.

**But wait -- does the W proposer's *choice* of aggressive vs. conservative in R1 depend on $V_W^{R2}(\mu)$?** Yes, the screening cutoff $\mu_s^{R1}$ can depend on $V_W^{R2}(\mu)$ through the $\omega(\mu) = (N-2)\beta V_W^{R2}(\mu)$ term in A.3. However, the decomposition is *conditional* on the regime -- it uses indicator functions $\mathbf{1}\{\mu > \mu_s^{R1}\}$ and $\mathbf{1}\{\mu < \mu_s^{R2}\}$. The claim is not that the regimes are independent, but that *conditional on which regime obtains*, the two corrections affect disjoint payoff components. This is a correct and rigorous argument.

**Verdict: The additivity argument is RIGOROUS and well-justified.** The key insight is clean: H's payoff decomposes into two components ($\Pi_H^{\text{prop}}$ and $\Pi_H^W$) that are affected by different regime switches.

---

## 6. Completeness

The benchmark (aggressive R1, conservative R2) is derived correctly. The corrections for each regime switch are derived correctly. The subtraction of majority payoff to obtain $D_{\text{base}}$ is algebraically verified. The final assembly (line 1033-1034) collects all terms. **COMPLETE.**

---

## 7. Issues Found

### MAJOR

**Issue M1: Undefined variable $q$ in Step 5 (line 1024)**

Line 1024 uses $C_{\text{buy}} = \beta(q-1)(1-\alpha)$ where $q = \lfloor N/2 \rfloor + 1$ (the majority quota). While $q$ is defined earlier in the paper (line 98, line 501) and in B.5 (line 1042), it is NOT defined within B.5a itself. B.5a is a self-contained appendix subsection. The variable $q$ appears for the first time in B.5a at line 1024 without any definition or forward/backward reference. A reader arriving at B.5a directly would not know what $q$ is.

**Fix**: Add "$q = \lfloor N/2 \rfloor + 1$" after the first mention of $C_{\text{buy}}$ in Step 5, e.g.: "$C_{\text{buy}} = \beta(q-1)(1-\alpha)$ with $q = \lfloor N/2 \rfloor + 1$".

### MINOR

**Issue m1: Inconsistent regime naming convention (line 984 vs. rest)**

The benchmark in Step 1 is described as "aggressive R1, conservative R2." The corrections are then:
- $\delta_{R1}$: switches R1 from aggressive to conservative (Step 2)
- $\delta_{R2}$: switches R2 from conservative to aggressive (Step 3)

The choice of benchmark (aggressive R1, conservative R2) is fine -- it corresponds to the "middle" region $\mu_s^{R2} \leq \mu \leq \mu_s^{R1}$ in the standard case. However, this means the benchmark does NOT correspond to a single belief region in the alternative case ($\mu_s^{R1} < \mu_s^{R2}$), which could cause momentary confusion. The paper does handle this correctly via the indicator functions, but a one-sentence remark clarifying that the benchmark is a reference configuration (not a belief region) might help.

**Fix**: Optional. Could add: "The benchmark is a reference configuration used for algebraic convenience; it coincides with the payoff in the middle belief region when $\mu_s^{R2} \leq \mu_s^{R1}$."

**Issue m2: Slightly incomplete justification of $\Pi_H^W|_{\text{agg}}$ formula (line 987/997)**

In the benchmark computation (line 987), $\Pi_H^W|_{\text{agg-}R1}$ is written as:
$$\frac{(N-1)\beta}{N}\cdot\frac{V_e(\mu) + x}{N}$$

This simplification from the case formula (line 976) uses:
$$\mu(r+x) + (1-\mu)(1+x) = \mu r + x + 1 - \mu = V_e(\mu) + x$$

The intermediate step is shown in Step 2 (line 997) but not in Step 1 (line 987). This is a very minor gap -- the same identity is used and verified in Step 2.

**Fix**: No action needed; the identity is shown 10 lines later.

**Issue m3: Step numbering jumps from 0 to 1 then skips to 5**

The steps are: 0, 1, 2, 3, 4, 5. This is fine and logical, but Step 5 ("Subtracting majority") is really the culmination. The numbering is clear but nonstandard -- steps 0-4 build the unanimity payoff, step 5 subtracts majority. This structure is appropriate but could be slightly clearer with a subheading like "From unanimity payoff to payoff difference" before Step 5.

**Fix**: Optional cosmetic improvement.

---

## 8. Writing Quality

The exposition is clear, well-paced, and appropriate for JoP. Specific strengths:

- **Step 0 is excellent**: The decomposition into $\Pi_H^{\text{prop}}$ and $\Pi_H^W$ is clearly motivated, and the "Two features" paragraph (line 982) provides the economic intuition for additivity before the algebra confirms it.
- **Cross-references are precise**: Each step cites the relevant appendix equations.
- **Continuity check** ($\delta_{R2}(\mu_s^{R2}) = 0$, line 1014): Good practice, builds reader confidence.
- **The derivation bridges correctly** from the primitive formulas (A.1--A.3) to the compact decomposition used in B.5. This is exactly what a reader who wants to verify the proof would need.

---

## 9. Final Assessment

| Criterion | Rating |
|---|---|
| Algebraic correctness | All steps verified correct |
| Consistency with B.5 | All three formulas match exactly |
| Consistency with A.1--A.3 | Primitives used correctly |
| Notation consistency | Correct throughout |
| Additivity argument | Rigorous and well-justified |
| Completeness | Full derivation from primitives to D(mu) |
| Writing quality | Clear, well-paced, JoP-appropriate |

**Grade: A-**

The derivation is algebraically correct, complete, and well-written. The only non-cosmetic issue is the undefined $q$ in Step 5 (Issue M1), which is a MAJOR issue because a reader coming to B.5a directly would encounter an undefined symbol. Fixing this is a one-line edit. All other issues are minor or cosmetic.
