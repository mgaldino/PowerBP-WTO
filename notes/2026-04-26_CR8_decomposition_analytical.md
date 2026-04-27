# CR8: Analytical Decomposition of BP Gain into Entry and Screening Channels

**Date**: 2026-04-26
**Status**: DRAFT — awaiting verification

## Setup

The hegemon's net gain from institution under rule $R$ is:

$$v(\mu, R) = \begin{cases} E[V_H^{R1}(\mu, R)] - \alpha V_e(\mu) & \text{if } \mu \in E_R \\ 0 & \text{otherwise} \end{cases}$$

where $E_R$ is the entry set under rule $R$. Under majority, $E_M = [\tau(M), 1]$ and $v(\mu, M) = (\lambda_M - \alpha) V_e(\mu)$ is affine on $E_M$. Under unanimity, $E_U$ has lower threshold $\tau(U) < \tau(M)$, and $v(\mu, U)$ has an upward jump at the screening cutoff $\mu_s^{R1}$.

The total BP advantage of unanimity is:

$$\Delta^{BP}(p) \equiv \text{cav}\, v(p, U) - \text{cav}\, v(p, M).$$

## Counterfactual: unanimity without screening

Define $v_{\text{flat}}(\mu, U)$ as the counterfactual value function that preserves unanimity's lower entry threshold but removes the screening jump: $v_{\text{flat}}$ is affine on $E_U$, connecting $(\tau(U), 0)$ to $(1, v(1, U))$. Formally:

$$v_{\text{flat}}(\mu, U) = \begin{cases} v(1, U) \cdot \frac{\mu - \tau(U)}{1 - \tau(U)} & \text{if } \mu \geq \tau(U) \\ 0 & \text{otherwise} \end{cases}$$

Note: $v_{\text{flat}}(\tau(U), U) = 0$ (continuous at entry), unlike the actual $v(\mu, U)$ which may jump at $\tau(U)$.

## Decomposition

$$\Delta^{BP}(p) = \underbrace{[\text{cav}\, v_{\text{flat}}(p, U) - \text{cav}\, v(p, M)]}_{\text{entry channel}} + \underbrace{[\text{cav}\, v(p, U) - \text{cav}\, v_{\text{flat}}(p, U)]}_{\text{screening channel}}$$

The entry channel captures the gain from unanimity's lower entry threshold alone (as if v were affine). The screening channel captures the additional gain from the non-convexity at $\mu_s^{R1}$.

## Concavifications in closed form

### Majority

$v(\mu, M)$ is zero on $[0, \tau(M))$ and affine on $[\tau(M), 1]$ with $v(\tau(M), M) = (\lambda_M - \alpha) V_e(\tau(M)) > 0$ (discontinuous jump at entry). The concavification is:

$$\text{cav}\, v(p, M) = \begin{cases} S_M \cdot p & \text{if } p < \tau(M) \\ (\lambda_M - \alpha) V_e(p) & \text{if } p \geq \tau(M) \end{cases}$$

where $S_M = (\lambda_M - \alpha) V_e(\tau(M)) / \tau(M)$ is the slope of the line from origin tangent to $v$ at the entry jump.

### Unanimity (flat counterfactual)

$v_{\text{flat}}$ is zero on $[0, \tau(U))$ and affine on $[\tau(U), 1]$ with $v_{\text{flat}}(\tau(U)) = 0$ (continuous). Standard concavification of a function that is zero then linearly increasing:

$$\text{cav}\, v_{\text{flat}}(p, U) = v(1, U) \cdot p \quad \text{for all } p \in [0, 1].$$

**Derivation**: For $p < \tau(U)$, the optimal Bayes-plausible split sends mass to $\mu = 0$ (yielding 0) and $\mu^* = 1$ (yielding $v(1, U)$). For $p \geq \tau(U)$, the line $v(1,U) \cdot p$ weakly exceeds $v_{\text{flat}}(p)$ because $v(1,U) \cdot p - v(1,U)(p - \tau(U))/(1 - \tau(U)) = v(1,U) \cdot \tau(U)(1-p)/(1-\tau(U)) \geq 0$, with equality at $p = 1$.

### Unanimity (actual)

$v(\mu, U)$ is zero on $[0, \tau(U))$, then piecewise affine on $E_U$ with an upward jump at $\mu_s^{R1}$. The concavification is:

$$\text{cav}\, v(p, U) = S_U \cdot p \quad \text{for } p \leq p_{\text{tangent}}$$

where $S_U$ is the slope of the line from origin tangent to $v(\cdot, U)$ on the post-jump segment. If the tangent point is at $\mu_s^{R1}$ (just above the jump):

$$S_U = v(\mu_s^{R1,+}, U) / \mu_s^{R1}$$

where $v(\mu_s^{R1,+}, U)$ is the right-limit of $v$ at the screening cutoff (conservative branch). For $p$ above the tangent point, $\text{cav}\, v(p, U) = v(p, U)$ (the function is concave there).

## Three regimes

### Regime 1: $p < \tau(U)$ (low priors — both need persuasion)

All concavifications are linear from origin:

$$\Delta^{BP}(p) = (S_U - S_M) \cdot p$$

Decomposition into shares (independent of $p$):

$$\text{Entry share} = \frac{v(1, U) - S_M}{S_U - S_M}, \qquad \text{Screening share} = \frac{S_U - v(1, U)}{S_U - S_M}$$

**Intuition**: $S_U > v(1, U) > S_M$ iff screening contributes positively. $S_U > v(1, U)$ because the tangent to the jump yields a steeper line than the line to the endpoint. $v(1, U) > S_M$ because unanimity's lower entry threshold means the line to $(1, v(1,U))$ is steeper than majority's tangent at $\tau(M)$.

### Regime 2: $\tau(U) \leq p < \tau(M)$ (intermediate — entry under U only)

Under unanimity, entry occurs directly: $v(p, U) > 0$.
Under majority, still needs persuasion: $\text{cav}\, v(p, M) = S_M \cdot p$.

The entry channel dominates: majority cannot achieve entry at these priors without persuasion, while unanimity can. The screening channel is present (via the shape of $v(p, U)$ relative to $v_{\text{flat}}(p, U)$) but secondary.

Formally: entry channel $= v(1,U) \cdot p - S_M \cdot p = (v(1,U) - S_M) \cdot p$, and screening channel $= \text{cav}\, v(p, U) - v(1,U) \cdot p$.

### Regime 3: $p \geq \tau(M)$ (high priors — both have entry)

Entry occurs under both rules. No persuasion under majority ($\text{cav}\, v(p, M) = v(p, M)$, affine). No counterfactual entry advantage.

$$\text{Entry channel} = v_{\text{flat}}(p, U) - v(p, M)$$

This may be positive, zero, or negative (since $v_{\text{flat}}$ passes through different points than $v(p, M)$). But the **screening channel** provides the dominant contribution:

$$\text{Screening channel} = v(p, U) - v_{\text{flat}}(p, U) \geq 0$$

with equality only where $v(\mu, U)$ coincides with the flat counterfactual (i.e., away from the screening cutoff).

**At $p = 1$**: $v_{\text{flat}}(1, U) = v(1, U)$ by construction, so screening channel = 0 and entry channel = $v(1, U) - v(1, M) = D(1) > 0$. The entire advantage at $\mu = 1$ is the **conditional payoff difference**, which reflects the screening structure even though no screening jump is active at $\mu = 1$.

**Correction**: At $p = 1$, the decomposition via $v_{\text{flat}}$ attributes the advantage to the "entry channel" because $v_{\text{flat}}(1) = v(1, U)$. But substantively, $D(1) > 0$ is entirely due to the screening structure (Lemma 1). This is a limitation of the counterfactual decomposition: at the boundary $\mu = 1$, the flat counterfactual and the actual function coincide, so the screening channel mechanically vanishes. The decomposition is most informative for low and intermediate priors, where the two channels are cleanly separated.

## Proposed text for the paper

### Remark (Decomposition of the unanimity advantage)

The advantage of unanimity over majority under optimal persuasion decomposes into two channels. Define $v_{\text{flat}}(\mu, U)$ as the counterfactual net gain that preserves unanimity's entry threshold but removes the screening jump (affine interpolation from $(\tau(U), 0)$ to $(1, v(1, U))$). The entry channel is $\text{cav}\, v_{\text{flat}}(p, U) - \text{cav}\, v(p, M)$; the screening channel is $\text{cav}\, v(p, U) - \text{cav}\, v_{\text{flat}}(p, U)$.

For low priors ($p < \tau(U)$), both concavifications are linear from the origin, and the channel shares are prior-independent:

$$\text{Entry share} = \frac{v(1, U) - S_M}{S_U - S_M}, \qquad \text{Screening share} = \frac{S_U - v(1, U)}{S_U - S_M},$$

where $S_M = (\lambda_M - \alpha)V_e(\tau(M))/\tau(M)$ and $S_U = v(\mu_s^{R1,+}, U)/\mu_s^{R1}$ are the concavification slopes under majority and unanimity. For high priors ($p \geq \tau(M)$), entry occurs under both rules and the entire advantage is the conditional payoff difference $D(p)$ from Lemma 1.

---

# VERIFICATION REPORT

**Reviewer**: Mathematical reviewer (Claude)
**Date**: 2026-04-26
**Grade**: **C — Major conceptual and numerical errors; requires fundamental redesign**

## Executive summary

The decomposition has a correct high-level idea (separate entry and screening channels) but fails on the specific parameterization it targets. For Example 2 parameters (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.14), the screening jump at $\mu_s^{R1}$ is **entirely below the entry threshold** $\tau(U)$, so it does not appear in the net-gain function $v(\mu, U)$ at all. The tangent point for $\operatorname{cav} v(\cdot, U)$ is at $\tau(U)$, not at $\mu_s^{R1}$. The majority entry threshold $\tau(M) = 0$, making $S_M$ undefined as a slope from origin. Several claims in the proposal are wrong or inapplicable.

---

## Verification item 1: Concavification of majority

### Claim: $\operatorname{cav} v(p, M) = S_M \cdot p$ for $p < \tau(M)$

**WRONG for Example 2.** The majority entry threshold is $\tau(M) = 0$:

$$\kappa_M = \frac{(1-\alpha)[N(N-1)+\beta(q-1)]}{N^2(N-1)} = \frac{0.7 \times 21.8}{100} = 0.1526$$

$$\tau(M) = \max\left\{0,\; \frac{c/\kappa_M - 1}{r - 1}\right\} = \max\{0,\; -0.165\} = 0$$

Since $\tau(M) = 0$, entry occurs at ALL beliefs under majority. The function $v(\mu, M) = (\lambda_M - \alpha) V_e(\mu) = 0.0896(1 + 0.5\mu)$ is affine and positive on the entire domain $[0, 1]$. It is already concave (indeed linear), so:

$$\operatorname{cav} v(p, M) = v(p, M) = 0.0896(1 + 0.5p) \quad \text{for all } p \in [0,1]$$

There is **no linear-from-origin regime** for majority. $S_M$ as defined in the proposal ($= (\lambda_M - \alpha)V_e(\tau(M))/\tau(M)$) involves division by zero and is undefined.

**Consequence**: The regime decomposition into three regimes collapses. "Regime 1" ($p < \tau(U)$) does not have both concavifications linear from origin; majority's is affine with positive intercept. The channel shares $\frac{v(1,U) - S_M}{S_U - S_M}$ and $\frac{S_U - v(1,U)}{S_U - S_M}$ are undefined.

### When IS the claim correct?

When $\tau(M) > 0$ (i.e., $c > \kappa_M$), the proposal's formula for $\operatorname{cav} v(p, M)$ is correct on $[0, \tau(M))$. But for Example 2 with $c = 0.14 < \kappa_M = 0.1526$, it fails.

---

## Verification item 2: Concavification of $v_{\text{flat}}$

### Claim: $\operatorname{cav} v_{\text{flat}}(p, U) = v(1,U) \cdot p$ for all $p$

**CORRECT analytically.** The function $v_{\text{flat}}(\mu)/\mu = v(1,U) \cdot \frac{\mu - \tau(U)}{\mu(1 - \tau(U))}$ is increasing in $\mu$ on $[\tau(U), 1]$ (derivative is $v(1,U)\tau(U)/[\mu^2(1-\tau(U))] > 0$). The maximum is at $\mu = 1$, giving $v(1,U)$. So the optimal split from any $p$ sends mass to $\mu = 0$ and $\mu = 1$, yielding $\operatorname{cav} v_{\text{flat}}(p) = v(1,U) \cdot p$.

**However**, this result is not very useful in the decomposition because $\operatorname{cav} v(p, M)$ is NOT equal to $S_M \cdot p$ (since $\tau(M) = 0$).

---

## Verification item 3: Ordering $S_U > v(1,U) > S_M$

**PARTIALLY UNDEFINED.** $S_M$ is undefined for Example 2 ($\tau(M) = 0$).

Computed values:
- $S_U = v(\tau(U), U) / \tau(U) = 0.2557 / 0.3305 = 0.7736$
- $v(1, U) = 0.174$
- $v(1, M) = 0.1344$
- $D(1) = v(1,U) - v(1,M) = 0.0396$

$S_U > v(1,U)$: TRUE ($0.7736 > 0.174$). This holds because $v$ is decreasing on the conservative branch, so $v(\tau(U))/\tau(U)$ is much larger than $v(1)/1$.

The "entry advantage" at low priors: $\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M) = 0.7736p - 0.0896(1+0.5p) = 0.7288p - 0.0896$. This crosses zero at $p^* = 0.0896/0.7288 \approx 0.123$.

**Note**: The paper claims $p^* \approx 0.24$. My analytical computation gives $p^* \approx 0.123$. This is a discrepancy that should be investigated by running the R code numerically. It is possible the paper's value was computed with an older model version or different code path.

---

## Verification item 4: Regime 3 issue at $p = 1$

The proposal correctly identifies that $v_{\text{flat}}(1) = v(1, U)$ mechanically zeroes the screening channel at $p = 1$. But for Example 2, the issue is moot because the entire v function on $E_U$ is on the conservative branch (no screening jump in the active region). The "screening channel" as defined is literally zero everywhere for these parameters because $v(\mu, U)$ is affine on $E_U$.

---

## Verification item 5: Jump at $\tau(U)$

**$v(\mu, U)$ jumps discontinuously at $\tau(U)$ from 0 to $v(\tau(U)) \approx 0.256$.** This is an entry jump (VW crosses $c$), not a screening jump. Just below $\tau(U)$, VW < c so $v = 0$. Just above, $v = \text{EVH} - \alpha V_e > 0$.

The entry jump IS the source of non-convexity for $v(\mu, U)$ in Example 2. The screening non-convexity at $\mu_s^{R1} \approx 0.197$ is masked because $\tau(U) \approx 0.33 > \mu_s^{R1}$.

---

## Verification item 6: Tangent point for $\operatorname{cav} v(\cdot, U)$

### Claim: The tangent point is at $\mu_s^{R1}$

**WRONG for Example 2.** The tangent point is at $\tau(U) \approx 0.33$, not at $\mu_s^{R1} \approx 0.197$.

**Reasoning**: The function $v(\mu, U)$ is zero for $\mu < \tau(U) \approx 0.33$. The screening cutoff $\mu_s^{R1} \approx 0.197 < \tau(U)$, so $v(\mu_s^{R1}, U) = 0$. The ratio $v(\mu)/\mu$ is maximized at the entry jump point $\tau(U)$, where $v$ jumps from 0 to $\approx 0.256$.

The concavification is:
$$\operatorname{cav} v(p, U) = \begin{cases} S_U \cdot p = 0.7736p & \text{for } p \leq \tau(U) \\ v(p, U) = 0.296 - 0.122p & \text{for } p \geq \tau(U) \end{cases}$$

where the two pieces meet at $p = \tau(U)$ since $0.7736 \times 0.3305 = 0.2557 = 0.296 - 0.122 \times 0.3305$.

For $p > \tau(U)$: $v(p,U)$ is affine and decreasing, and the slope $-0.122 < S_U = 0.7736$, so the concave envelope just follows $v$ itself (the slope decreased, consistent with concavity). So $\operatorname{cav} v(p,U) = v(p,U)$ for $p \geq \tau(U)$.

**Wait -- this needs correction.** For $p > \tau(U)$, is $S_U \cdot p > v(p, U)$? At $p = 1$: $S_U = 0.7736 > 0.174 = v(1,U)$. So $S_U \cdot p$ is strictly above $v$ for all $p > \tau(U)$. Could the hegemon do better by splitting mass between 0 and $\tau(U)$ even when $p > \tau(U)$? No -- the concave envelope cannot go above $S_U \cdot p$ (that's the best you can do by mixing with 0), but it also must be concave. Since $v(\tau(U)) = S_U \cdot \tau(U)$ and $v$ is affine decreasing after $\tau(U)$, the piecewise function that follows $S_U \cdot p$ until $\tau(U)$ then follows $v(p)$ is concave (slope drops from $S_U$ to $-0.122$). And this function is weakly above $v$ everywhere. It's also the tightest such function (since $v$ itself is the floor above $\tau(U)$). So $\operatorname{cav} v(p,U) = v(p,U)$ for $p \geq \tau(U)$.

---

## Verification item 7: Numerical results for Example 2

All computed analytically from the paper's formulas (R script saved but not executed due to environment constraints):

| Quantity | Value |
|----------|-------|
| $\mu_s^{R1}$ | 0.197 |
| $\mu_s^{R2}$ | 0.125 |
| $\tau(U)$ | 0.3305 |
| $\tau(M)$ | 0 |
| $\lambda_M$ | 0.3896 |
| $\lambda_M - \alpha$ | 0.0896 |
| $v(\tau(U), U)$ | 0.2557 |
| $v(1, U)$ | 0.174 |
| $v(1, M)$ | 0.1344 |
| $D(1)$ | 0.0396 |
| $S_U$ | 0.7736 |
| $S_M$ | **undefined** ($\tau(M) = 0$) |
| $p^*$ (analytical) | 0.123 |
| $p^*$ (paper) | 0.24 (discrepancy) |

---

## Fundamental structural problem

For Example 2, the screening jump at $\mu_s^{R1}$ lies **below** the entry threshold $\tau(U)$. This means:

1. The net-gain function $v(\mu, U)$ has **no screening non-convexity** in the economically relevant region. Its only non-convexity is the entry jump at $\tau(U)$.

2. The "screening channel" in the proposed decomposition is **identically zero**: $v(\mu, U) = v_{\text{flat}}(\mu, U)$ on $E_U$ because $v$ is already affine (on the conservative branch) and $v_{\text{flat}}$ is constructed by affine interpolation between the same endpoints.

Actually, that's not quite right. $v_{\text{flat}}$ interpolates from $(\tau(U), 0)$ to $(1, v(1,U))$, while $v(\mu, U)$ jumps from 0 to $v(\tau(U)) > 0$ at $\tau(U)$. On $E_U$:
- $v_{\text{flat}}(\tau(U)) = 0$
- $v(\tau(U), U) = 0.2557$

So $v(\mu, U) > v_{\text{flat}}(\mu, U)$ for $\mu$ near $\tau(U)$. The difference shrinks to zero at $\mu = 1$. This difference is what the proposal calls the "screening channel," but it's actually the **entry jump** in $v(\mu, U)$ (the discontinuity from 0 to $v(\tau(U)) > 0$), not the screening jump at $\mu_s^{R1}$.

For $\mu \in [\tau(U), 1]$:
- $v(\mu, U) = 0.296 - 0.122\mu$
- $v_{\text{flat}}(\mu, U) = 0.174 \cdot \frac{\mu - 0.3305}{0.6695} = 0.2598(\mu - 0.3305)$

At $\mu = \tau(U) = 0.3305$: $v = 0.2557$, $v_{\text{flat}} = 0$. Diff = 0.2557.
At $\mu = 0.5$: $v = 0.235$, $v_{\text{flat}} = 0.2598 \times 0.1695 = 0.04404$. Diff = 0.191.
At $\mu = 1$: $v = 0.174$, $v_{\text{flat}} = 0.174$. Diff = 0.

So the "screening channel" $v - v_{\text{flat}}$ is large and dominated by the fact that $v_{\text{flat}}$ rises from 0 at $\tau(U)$ while $v$ jumps to 0.256. This is the **entry jump**, not screening. The counterfactual $v_{\text{flat}}$ removes the entry jump (by being continuous at $\tau(U)$), so what the decomposition calls "screening channel" is actually "entry jump channel."

This is a **naming/conceptual error**. The decomposition conflates the entry jump with screening because $v_{\text{flat}}$ is continuous at $\tau(U)$ while $v$ is discontinuous.

---

## Root causes of the problems

1. **The proposal assumes $\mu_s^{R1}$ is the primary source of non-convexity in $v(\mu, U)$.** For Example 2, it is not. The screening cutoff is below the entry threshold, so the relevant non-convexity is the entry jump at $\tau(U)$, not the screening jump at $\mu_s^{R1}$.

2. **The proposal assumes $\tau(M) > 0$.** For Example 2, $\tau(M) = 0$. This makes $S_M$ undefined and destroys the three-regime structure.

3. **$v_{\text{flat}}$ is continuous at $\tau(U)$ but $v$ is discontinuous there.** This means $\operatorname{cav} v - \operatorname{cav} v_{\text{flat}}$ captures the entry jump, not screening.

4. **The tangent point for $\operatorname{cav} v(\cdot, U)$ is at $\tau(U)$, not $\mu_s^{R1}$.** The proposal's formula $S_U = v(\mu_s^{R1,+}, U)/\mu_s^{R1}$ is wrong (gives $v(0.197) = 0$ since $0.197 < \tau(U)$).

---

## What would be needed for a correct decomposition

A correct decomposition for Example 2 would need to:

1. Recognize that $\tau(M) = 0$, so majority has no entry gap. The entire advantage of unanimity at low priors comes from the **combination** of (a) unanimity's entry jump and (b) the steeper concavification slope.

2. Define the counterfactual more carefully. One option: compare $\operatorname{cav} v(p, U)$ against the "unanimity-as-if-affine" counterfactual where $v(\mu, U)$ is extended as the affine function matching $v$ on $E_U$ (i.e., $v(\mu, U) = 0.296 - 0.122\mu$ for all $\mu$, including below $\tau(U)$ where it's positive). This would separate the entry effect from the bargaining advantage.

3. The decomposition might work correctly for parameters where $\tau(U) < \mu_s^{R1}$ (so the screening jump is visible in $v$) and $\tau(M) > 0$ (so both concavifications are linear from origin at low priors). Such parameters exist but are not Example 2.

---

## Specific errors and corrections

| # | Claim in proposal | Status | Correction |
|---|-------------------|--------|------------|
| 1 | $\operatorname{cav} v(p, M) = S_M \cdot p$ for $p < \tau(M)$ | **WRONG** (Ex 2: $\tau(M)=0$) | $\operatorname{cav} v(p, M) = v(p, M) = 0.0896(1+0.5p)$ for all $p$ |
| 2 | $\operatorname{cav} v_{\text{flat}}(p) = v(1,U) \cdot p$ | CORRECT | N/A |
| 3 | $S_U > v(1,U) > S_M$ | **PARTIALLY UNDEFINED** | $S_M$ undefined; $S_U > v(1,U)$ is true |
| 4 | Tangent for $\operatorname{cav} v(\cdot, U)$ at $\mu_s^{R1}$ | **WRONG** | Tangent at $\tau(U)$ (entry jump) |
| 5 | Prior-independent channel shares | **WRONG** (Ex 2) | Requires both $\tau(M) > 0$ and visible screening jump |
| 6 | "Screening channel" captures screening | **MISLEADING** | For Ex 2, captures entry jump, not screening |
| 7 | Three regimes | **COLLAPSED** | Only one regime structure when $\tau(M)=0$ |

---

## Salvageable elements

1. The **conceptual idea** of decomposing $\Delta^{BP}$ into entry and screening channels is sound and valuable for the paper.
2. The formula for $\operatorname{cav} v_{\text{flat}}$ is correct.
3. For parameters where $\tau(U) < \mu_s^{R1}$ AND $\tau(M) > 0$, the decomposition framework could work. This requires low $c$ (to push $\tau(U)$ below the screening cutoff) and high $c$ (to push $\tau(M) > 0$). For Example 2 parameters, these conditions are **simultaneously impossible**: $\tau(U) < \mu_s^{R1}$ requires $c \leq 0.132$ (the max VW_R1 near the screening cutoff), but $\tau(M) > 0$ requires $c > 0.1526 = \kappa_M$. Since $0.132 < 0.1526$, no $c$ works. Different base parameters (e.g., larger $r$, smaller $\alpha$, or smaller $N$) may open a feasible range.
4. A more robust approach: define the entry channel as the gain from unanimity's lower entry threshold holding the conditional payoff structure fixed, and the screening channel as the gain from the conditional payoff structure holding the entry threshold fixed.

---

## Recommended path forward

1. **Run the R code** to verify $p^* \approx 0.24$ vs my analytical $p^* \approx 0.123$. If the R code gives 0.24, there may be an error in the R model functions or in my hand computation.

2. **Check parameter sensitivity**: For which $(c, \alpha, N, r, \beta)$ does $\tau(U) < \mu_s^{R1}$? This is when the screening jump appears in the net-gain function.

3. **Redesign the counterfactual**: Instead of $v_{\text{flat}}$, consider:
   - "No-entry-advantage counterfactual": $\tilde{v}(\mu, U) = v(\mu, U)$ on $E_U$, but with $\tau(U)$ replaced by $\tau(M)$
   - "No-screening counterfactual": $\hat{v}(\mu, U)$ that smooths the screening jump but preserves the entry threshold

4. **Choose parameters where the decomposition works** if the goal is pedagogical. This means parameters with $\tau(M) > 0$ and $\tau(U) < \mu_s^{R1}$.

---

## Grade: C

The proposal has a good intuition but fails on the specific parameterization it targets. Multiple formulas are wrong or inapplicable. The "screening channel" captures the wrong thing. The three-regime structure collapses. Not ready for the paper.
