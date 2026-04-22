# Math Review: τ(U) Closed-Form Derivation

**Reviewer**: Independent agent  
**Date**: 2026-04-22  
**Verdict**: PASS WITH CORRECTIONS

---

## Step-by-step verification

### 1. Setup (lines 13--31)

**V_W^{R2} expressions (line 15)**: Correct. Matches paper Appendix A.2 (lines 900--903 of `formal_model_v3.Rmd`). The screening cutoff $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$ and both branches are correctly stated.

**F_1^{con} and F_1^{agg} (lines 23--24)**: Correct. Matches paper Appendix A.3 (lines 911--913). The shorthand $x = (N-1)\alpha r$ and $\omega(\mu) = (N-2)\beta V_W^{R2}(\mu)$ are standard from the paper.

**Offer interpretation**: Verified that:
- Aggressive R1 offer to H: $\beta(1+x)/N = \beta[1+(N-1)\alpha r]/N = \beta V_H^{R2}(\theta=0, \mu=1)$, because after rejection in aggressive R1 the R2 belief is $\mu_{R2}=1$ (only $\theta=1$ rejects), and at $\mu=1 > \mu_s^{R2}$ the conservative R2 branch applies, giving $V_H^{R2}(\theta=0) = [1+(N-1)\alpha r]/N$.
- Conservative R1 offer to H: $\beta(r+x)/N = \beta r[1+(N-1)\alpha]/N = \beta V_H^{R2}(\theta=1)$.

Both are consistent with the model.

### 2. Two regimes in R1 (lines 33--48)

**Conservative regime (line 40)**: The expression 
$$V_W^{R1}(\mu, \text{con}) = \frac{F_1^{con}(\mu)}{N} + \frac{(N-1)\beta V_W^{R2}(\mu)}{N}$$
is correct. In the conservative regime, all deals pass in R1 regardless of the proposer. When W is not the proposer (prob $(N-1)/N$), W receives $\beta V_W^{R2}(\mu)$ as the acceptance offer. This matches the code (line 23: `nonprop <- (N - 1) / N * beta * VW_R2`).

**Aggressive regime (line 48)**: The non-proposer payoff decomposition is:
- H proposes (prob $1/N$): W gets $\beta V_W^{R2}(\mu)$ (H proposal always passes).
- Other W proposes (prob $(N-2)/N$): if $\theta=0$ (prob $1-\mu$), deal passes, W gets $\beta V_W^{R2}(\mu)$; if $\theta=1$ (prob $\mu$), deal rejected, R2 at $\mu=1$, W gets $\beta V_W^{R2}(1) = \beta r(1-\alpha)/N$.

This matches the code (line 20: `nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)`). **Correct.**

### 3. Conservative-branch algebra (lines 50--84)

**Step 1 (line 59)**: Substituting $\omega(\mu) = (N-2)\beta[V_e(\mu) - \alpha r]/N$ into $F_1^{con}$:

$$F_1^{con} = V_e - \frac{\beta(r+x)}{N} - \frac{(N-2)\beta[V_e - \alpha r]}{N}$$

Collecting the constant term inside the brackets:
$$r + x - (N-2)\alpha r = r + (N-1)\alpha r - (N-2)\alpha r = r + \alpha r = r(1+\alpha)$$

This is correct. The simplification $x - (N-2)\alpha r = (N-1)\alpha r - (N-2)\alpha r = \alpha r$ is verified.

**Result (line 65)**:
$$F_1^{con} = V_e \cdot \frac{N - (N-2)\beta}{N} - \frac{\beta r(1+\alpha)}{N}$$
**Correct.**

**Step 2 (lines 68--76)**: Combining with the non-proposer term:

Coefficient of $V_e$:
$$\frac{N - (N-2)\beta}{N^2} + \frac{(N-1)\beta}{N^2} = \frac{N - (N-2)\beta + (N-1)\beta}{N^2}$$

Expanding: $-(N-2)\beta + (N-1)\beta = -N\beta + 2\beta + N\beta - \beta = \beta$

So the coefficient is $(N + \beta)/N^2$. **Correct.**

Constant term:
$$\frac{-\beta r(1+\alpha)}{N^2} + \frac{-(N-1)\beta\alpha r}{N^2} = \frac{-\beta r[1 + \alpha + (N-1)\alpha]}{N^2} = \frac{-\beta r(1 + N\alpha)}{N^2}$$

The key step: $1 + \alpha + (N-1)\alpha = 1 + \alpha \cdot [1 + (N-1)] = 1 + N\alpha$. **Correct.**

**Final expression (line 76)**:
$$V_W^{R1}(\mu, \text{con}) = \frac{V_e(\mu)(N+\beta) - \beta r(1+N\alpha)}{N^2}$$
**Correct.**

### 4. Definitions of $\kappa_U^{con}$ and $\gamma_U^{con}$ (lines 78--83)

$$\kappa_U^{con} = \frac{N+\beta}{N^2}, \qquad \gamma_U^{con} = \frac{\beta r(1+N\alpha)}{N^2}$$

$V_W^{R1} = \kappa \cdot V_e(\mu) - \gamma$ is affine in $\mu$. **Correct.**

### 5. Entry threshold inversion (lines 88--101)

Setting $V_W^{R1} = c$:
$$\kappa[1 + \mu(r-1)] = c + \gamma$$
$$\mu = \frac{c + \gamma - \kappa}{\kappa(r-1)}$$

Multiplying numerator and denominator by $N^2$:
$$\tau_U^{con} = \frac{cN^2 - [N + \beta - \beta r(1+N\alpha)]}{(N+\beta)(r-1)}$$

Verified: $\kappa - \gamma = [N + \beta - \beta r(1+N\alpha)]/N^2$, so $c + \gamma - \kappa = c - (\kappa - \gamma)$, and $cN^2 - N^2(\kappa - \gamma) = cN^2 - [N + \beta - \beta r(1+N\alpha)]$. **Correct.**

### 6. Numerical verification (lines 156--167)

For $N=5$, $r=1.5$, $\alpha=0.3$, $\beta=0.9$, $c=0.1$:
- $\kappa = 5.9/25 = 0.236$. **Correct.**
- $\gamma = 0.9 \times 1.5 \times 2.5/25 = 3.375/25 = 0.135$. **Correct.**
- $\tau = (0.1 + 0.135 - 0.236)/(0.236 \times 0.5) = -0.001/0.118 = -0.008475...$
- Note writes $-0.0085$; exact value is $-0.008475$. Acceptable rounding. **Correct.**
- $\max\{0, -0.008475\} = 0$. Entry at all beliefs. **Correct.**

### 7. Consistency with code

Tested the analytical formula $V_W^{R1} = \kappa V_e(\mu) - \gamma$ against `VW_R1_unanimity()` from `scripts/model_functions.R` at six $\mu$ values in the conservative regime ($\mu \in \{0.25, 0.3, 0.5, 0.7, 0.9, 0.99\}$) with $N=5$, $r=1.5$, $\alpha=0.3$, $\beta=0.9$. Maximum discrepancy: $2.78 \times 10^{-17}$ (machine epsilon). **Exact match.**

Also tested the entry threshold $\tau_U^{con}$ against numerical root-finding across 60+ parameter combinations ($N \in \{5, 10, 30, 50\}$, $r \in \{1.2, 1.5, 2.0\}$, $\alpha \in \{0.05, 0.10, 0.20\}$, $\beta \in \{0.5, 0.7, 0.9\}$). In all cases where the threshold falls in the conservative regime, the analytical formula matches numerical search to within the grid resolution ($\leq 0.0001$). **Confirmed.**

### 8. Aggressive-branch quadratic claim (lines 102--137)

Fitted quadratic polynomials to VW_R1 in both sub-cases (A: $\mu < \mu_s^{R2}$; B: $\mu_s^{R2} < \mu < \mu_s^{R1}$). Results:

| Sub-case | Max quadratic residual | Cubic coefficient |
|----------|----------------------|-------------------|
| A | $3.83 \times 10^{-17}$ | $2.18 \times 10^{-13}$ |
| B | $3.24 \times 10^{-17}$ | $7.21 \times 10^{-13}$ |
| Conservative | $1.22 \times 10^{-16}$ (linear fit) | $1.66 \times 10^{-16}$ (quad coeff) |

All residuals are at machine precision. The claim that VW is quadratic in the aggressive regimes and affine in the conservative regime is **confirmed numerically**.

The algebraic argument is also correct: in both aggressive sub-cases, the $(1-\mu)\omega(\mu)$ term is the product of two affine functions of $\mu$, producing a quadratic. Similarly, the non-proposer payoff contains $(1-\mu)^2$ terms (sub-case A) or $(1-\mu)V_e(\mu)$ terms (sub-case B), both quadratic.

### 9. Edge cases and regime classification (line 151)

The note claims: "the empirically relevant case is case 1 (conservative), because for $c$ not very small the entry threshold typically falls above $\mu_s^{R1}$."

This claim is **partially correct but incomplete**. Specifically:

**Issue discovered**: $V_W^{R1}(\mu)$ is **not monotone** under unanimity. In the aggressive regime, VW can start relatively high near $\mu=0$, decrease, and then the conservative branch is lower at $\mu_s^{R1}$ (VW has a **downward** jump at the screening cutoff, opposite to H's upward jump). This means:

1. For intermediate values of $c$, the entry set $\{\mu : V_W^{R1}(\mu) \geq c\}$ can be **disconnected**: e.g., $[0, \mu_1] \cup [\mu_2, 1]$ where $\mu_1 < \mu_s^{R1} < \mu_2$.

2. In this case, $\tau(U) = \inf\{\mu : V_W^{R1} \geq c\} = 0$ (entry occurs near $\mu=0$), but there is a **gap** near $\mu_s^{R1}$ where entry does not occur.

3. The conservative-branch formula $\tau_U^{con}$ gives the re-entry point $\mu_2$ in the conservative regime, not the inf.

**Numerical example**: With $N=5$, $r=1.5$, $\alpha=0.3$, $\beta=0.9$:
- $c = 0.126$: entry set is $[0.001, 0.197] \cup [0.212, 0.999]$ (disconnected)
- $c = 0.132$: entry set is $[0.001, 0.197] \cup [0.263, 0.999]$ (disconnected)
- $c = 0.134$: entry set is $[0.280, 0.999]$ (connected, conservative only)

The self-consistency condition for the conservative formula is:
1. $\tau_U^{con} > \mu_s^{R1}$, AND
2. $V_W^{R1}(\mu, \text{agg}) < c$ for all $\mu < \mu_s^{R1}$ (no entry in aggressive regime).

When condition (2) fails, the actual $\tau(U) = 0$ (or a value in the aggressive regime), and the conservative formula gives a different quantity.

---

## Issues found

### Issue 1 (Minor, notation): Non-proposer probability decomposition

Line 28 says "prob $1/N$ for H, $(N-2)/N$ for others W's", but the total non-proposer probability should be $(N-1)/N$ (since 1 of N players is the proposer). The decomposition into H ($1/N$) plus other W's ($(N-2)/N$) sums to $(N-1)/N$. Correct but could be stated more clearly.

### Issue 2 (Substantive): Disconnected entry set not addressed

The derivation defines $\tau(U) = \max\{0, \inf\{\mu : V_W^{R1}(\mu) \geq c\}\}$ (line 9). Under the conservative formula, the note implicitly assumes the entry set is connected (i.e., $V_W^{R1} \geq c$ for all $\mu \geq \tau$). But the downward jump in VW at $\mu_s^{R1}$ can create a disconnected entry set. The formula $\tau_U^{con}$ gives the entry threshold only for the conservative portion of the entry set.

**Correction needed**: Add a validity condition. State that $\tau_U^{con}$ is the correct entry threshold when $\max_{\mu \leq \mu_s^{R1}} V_W^{R1}(\mu, \text{agg}) < c$ (no entry in aggressive regime). Otherwise, $\tau(U) = 0$ or $\tau(U)$ solves a quadratic in the aggressive regime.

For the paper's purposes, the concavification code handles this correctly (it evaluates $v(\mu)$ pointwise), so this issue affects only the closed-form expression, not the results.

### Issue 3 (Minor): Rounding in numerical example

Line 163 shows $-0.001/0.118 = -0.0085$. The exact value is $-0.008474...$, so $-0.0085$ is a rounding. This is inconsequential but could be stated as $\approx -0.0085$.

---

## Recommendation

The derivation is **algebraically correct** in the conservative regime. The closed-form expression

$$V_W^{R1}(\mu, \text{con}) = \frac{V_e(\mu)(N+\beta) - \beta r(1+N\alpha)}{N^2}$$

and its inversion

$$\tau_U^{con} = \frac{cN^2 - [N + \beta - \beta r(1+N\alpha)]}{(N+\beta)(r-1)}$$

are verified both symbolically and numerically to machine precision.

**Ready for insertion into the paper** with one caveat: add a sentence stating the validity condition (entry must occur only in the conservative regime for the affine formula to apply). The aggressive-branch quadratic structure is correctly claimed but not fully derived -- this is acceptable since the note explicitly flags it as secondary.

The disconnected-entry-set issue (Issue 2) is a genuine subtlety of the model but does not affect any result in the paper, since the code evaluates payoffs pointwise and the concavification handles any shape. If the closed-form $\tau_U^{con}$ is to be inserted into the appendix, it should carry a footnote noting the self-consistency requirement.
