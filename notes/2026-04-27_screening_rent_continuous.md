# Screening Rent Under Continuous Types

## Setting

Consider an extension of the institutional design game to continuous types. Replace the binary state $\theta \in \{0,1\}$ with a continuous type $\theta$ distributed according to a CDF $F$ with full support on $[1, r]$, where $r > 1$. The value of cooperation equals the type: $V(\theta) = \theta$. All other primitives are inherited from the discrete model: $N \geq 3$ players (one hegemon $H$, $N-1$ weak states $W$), disagreement payoffs $d_W = 0$ and $d_H = \alpha\theta$ with $\alpha \in (0, 1/r)$, two-round Baron-Ferejohn bargaining with discount factor $\beta \in (0,1)$, random proposer (probability $1/N$ each), and voting rule $R \in \{M, U\}$.

We denote $f = F'$ the density of $F$ (assumed to exist and be positive on $(1,r)$), and write $E[\theta] = \int_1^r \theta \, dF(\theta)$ for the prior mean. The support convention is that $F(1) = 0$ and $F(r) = 1$.

## Proposition (Screening rent under continuous types)

Under unanimity with continuous types $\theta \sim F$ on $[1, r]$ ($F$ has full support, continuous CDF with density $f > 0$ on $(1,r)$):

**(a)** In Round 2 (the terminal round), when $W$ proposes, $W$ optimally chooses a cutoff $\theta_2^* \in (1, r]$ such that types $\theta \leq \theta_2^*$ accept the offer $y_H = \alpha\theta_2^*$ and types $\theta > \theta_2^*$ reject (with $\theta > \theta_2^*$ vacuous when $\theta_2^* = r$). The screening rent for $H$ from $W$'s R2 proposal is:
$$\text{Rent}_{R2} = \int_1^{\theta_2^*} \alpha(\theta_2^* - \theta) \, dF(\theta) > 0.$$

**(b)** In Round 1, when $W$ proposes, the R1 screening problem has the same cutoff structure, with $\beta V_H^{R2}(\theta, U)$ replacing $\alpha\theta$ as the type-dependent reservation value. The R1 screening rent is:
$$\text{Rent}_{R1} = \int_1^{\theta_1^*} \left[\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)\right] dF(\theta) > 0.$$

**(c)** Under majority rule, $W$'s proposals generate zero screening rent in both rounds, because $H$'s vote is not pivotal and each type receives exactly its outside option.

**(d)** Therefore, the screening rent from $W$'s proposals under unanimity is strictly positive in both bargaining rounds, for any continuous $F$ with full support on $[1, r]$. Under majority, $W$'s proposals generate zero screening rent. The qualitative mechanism---unanimity creates screening, majority does not---extends to arbitrary continuous type distributions.

**Scope.** This proposition establishes that the screening mechanism is robust to continuous types. It does *not* claim that total payoffs satisfy $V_H(U) > V_H(M)$ for continuous types, because the $H$-proposes components differ across rules in R1 (under majority $H$ needs only a majority coalition, while under unanimity $H$ needs all votes) and their comparison requires separate analysis. The paper's main theorem (Theorem 1) establishes the full dominance result for $K = 2$ types; the continuous extension here confirms that the qualitative mechanism---unanimity creates screening rent, majority does not---is not an artifact of having only two types.

## Proof

### Step 1: R2 screening under unanimity (W proposes)

**R2 payoff structure.** Round 2 is the terminal round. If bargaining fails (H rejects in R2), each player receives their disagreement payoff: $H$ gets $\alpha\theta$, each $W$ gets $0$. When $H$ proposes in R2, $H$ offers $0$ to each $W$ (their disagreement payoff), all $W$'s accept (tie-breaking: accept when indifferent), and $H$ keeps $\theta$. When a weak state $W$ proposes in R2, $W$ offers $H$ a share $y_H \geq 0$ and keeps $\theta - y_H$ (distributing the surplus among weak states as needed).

**H's acceptance condition.** Type $\theta$ of $H$ accepts offer $y_H$ if and only if $y_H \geq \alpha\theta$ (the hegemon accepts when the offer weakly exceeds its disagreement payoff; indifference is resolved by acceptance per the tie-breaking convention).

**W's screening problem.** Since $W$ does not observe $\theta$, the offer $y_H$ determines which types accept. Setting $y_H = \alpha\theta^*$ for some target cutoff $\theta^* \in [1, r]$, the set of accepting types is $\{\theta : \alpha\theta \leq \alpha\theta^*\} = \{\theta : \theta \leq \theta^*\}$. Types $\theta > \theta^*$ reject.

$W$'s expected payoff from cutoff $\theta^*$ is:
$$\pi_W(\theta^*) = \int_1^{\theta^*} (\theta - \alpha\theta^*) \, dF(\theta).$$

The integrand $\theta - \alpha\theta^*$ is the surplus $W$ keeps when type $\theta$ accepts: $V(\theta) - y_H = \theta - \alpha\theta^*$. When $H$ rejects (types $\theta > \theta^*$), bargaining fails and $W$ gets $0$.

**H's payoff from W's proposal.** Given cutoff $\theta^*$, the hegemon's expected payoff from $W$'s R2 proposal is:
$$E[V_H \mid W \text{ proposes, } \theta^*] = \int_1^{\theta^*} \alpha\theta^* \, dF(\theta) + \int_{\theta^*}^{r} \alpha\theta \, dF(\theta),$$
where the first integral covers accepting types (each receives $\alpha\theta^*$) and the second covers rejecting types (each receives the disagreement payoff $\alpha\theta$).

### Step 2: The optimal cutoff satisfies $\theta_2^* > 1$

We show that $W$'s optimal cutoff $\theta_2^*$ is strictly above the lower bound of the support.

**Existence of a global maximizer.** The function $\pi_W$ is continuous on the compact set $[1, r]$ (it is an integral with continuously varying limits and integrand). By the Weierstrass extreme value theorem, a global maximum exists. Denote any global maximizer by $\theta_2^*$.

**$\theta^* = 1$ is suboptimal.** We use a direct argument that does not require $f(1) > 0$. Note that $\pi_W(1) = 0$ (the integral over the empty interval $[1,1]$ is zero). For any $\epsilon \in (0, r - 1)$, consider:
$$\pi_W(1 + \epsilon) = \int_1^{1+\epsilon} \bigl(\theta - \alpha(1+\epsilon)\bigr) \, dF(\theta).$$

On the interval $[1, 1 + \epsilon]$, the integrand satisfies $\theta - \alpha(1+\epsilon) \geq 1 - \alpha(1+\epsilon)$. Since $\alpha < 1/r < 1$, for $\epsilon$ sufficiently small we have $\alpha(1 + \epsilon) < 1$, so $1 - \alpha(1 + \epsilon) > 0$. In particular, the integrand is strictly positive on $[1, 1+\epsilon]$ for small $\epsilon$. Moreover, $F$ has full support on $[1,r]$, so $F(1 + \epsilon) - F(1) = F(1+\epsilon) > 0$ for every $\epsilon > 0$. Therefore:
$$\pi_W(1 + \epsilon) \geq \bigl(1 - \alpha(1+\epsilon)\bigr) \cdot F(1+\epsilon) > 0$$
for all $\epsilon > 0$ sufficiently small. Since $\pi_W(1) = 0 < \pi_W(1 + \epsilon)$, the point $\theta^* = 1$ cannot be a global maximum. Every global maximizer satisfies $\theta_2^* > 1$.

**On whether $\theta_2^*$ is interior or at $r$.** The location of $\theta_2^*$ depends on $F$ and $\alpha$. Both cases can arise:

- **Any distribution with $f(r)$ sufficiently small** (e.g., $f(r) < \alpha/[(1-\alpha)r]$, which requires $f$ to be positive on the open interval but allows it to vanish at $r$): if $\pi_W$ is differentiable at an interior critical point, the FOC $\pi_W'(\theta^*) = (1-\alpha)\theta^* f(\theta^*) - \alpha F(\theta^*) = 0$ admits a solution in $(1,r)$, and $\pi_W'(r) < 0$ confirms the global maximum is interior.
- **Uniform distribution on $[1, r]$** with $\alpha < 1/r$: $f(\theta) = 1/(r-1)$, $F(\theta) = (\theta - 1)/(r-1)$. Then $\pi_W'(\theta^*) = [(1-\alpha)\theta^* - \alpha(\theta^* - 1)]/(r-1) = [\theta^*(1 - 2\alpha) + \alpha]/(r-1)$. For the uniform distribution on $[1, r]$ with $\alpha < 1/r$, the optimal cutoff is $\theta_2^* = r$ regardless of $r$. To see this, note that the FOC root $\theta^* = \alpha/(2\alpha - 1)$ satisfies $\theta^* > r$ whenever $\alpha < 1/r$ (since $\alpha/(2\alpha - 1) \leq r$ requires $(r-1)^2 \leq 0$, which is impossible for $r > 1$). Hence $\pi_W$ is increasing on all of $[1, r]$, and the global maximum is at the boundary $\theta_2^* = r$ (pool all types). Under the conservative offer, the screening rent is $\alpha(r-1)/2 > 0$.

**This distinction does not affect the screening rent**, as we show in Step 3: the rent is strictly positive for any $\theta_2^* \in (1, r]$. $\square$

### Step 3: Screening rent is positive

**Definition of screening rent.** The screening rent is the difference between what $H$ actually receives from $W$'s proposal under unanimity and what $H$ would receive under perfect price discrimination (i.e., if $W$ could offer each type exactly its outside option $\alpha\theta$):

$$\text{Rent}(\theta^*) = E[V_H \mid W \text{ proposes, } \theta^*] - E[\alpha\theta].$$

Computing:
\begin{align}
\text{Rent}(\theta^*) &= \left[\int_1^{\theta^*} \alpha\theta^* \, dF(\theta) + \int_{\theta^*}^r \alpha\theta \, dF(\theta)\right] - \int_1^r \alpha\theta \, dF(\theta) \\
&= \int_1^{\theta^*} \alpha\theta^* \, dF(\theta) - \int_1^{\theta^*} \alpha\theta \, dF(\theta) \\
&= \int_1^{\theta^*} \alpha(\theta^* - \theta) \, dF(\theta).
\end{align}

The second equality follows by splitting $\int_1^r \alpha\theta \, dF(\theta) = \int_1^{\theta^*} \alpha\theta \, dF(\theta) + \int_{\theta^*}^r \alpha\theta \, dF(\theta)$ and canceling the $\int_{\theta^*}^r$ terms.

**Positivity.** For any $\theta^* > 1$:
1. The integrand $\alpha(\theta^* - \theta)$ is strictly positive for all $\theta \in [1, \theta^*)$, since $\theta < \theta^*$ and $\alpha > 0$.
2. The measure $dF(\theta)$ assigns strictly positive mass to $[1, \theta^*)$: since $F$ has full support on $[1,r]$ and $\theta^* > 1$, we have $F(\theta^*) - F(1) = F(\theta^*) > 0$ for any $\theta^* > 1$.

Therefore:
$$\text{Rent}(\theta^*) = \int_1^{\theta^*} \alpha(\theta^* - \theta) \, dF(\theta) > 0 \quad \text{for all } \theta^* \in (1, r].$$

Since the optimal cutoff satisfies $\theta_2^* > 1$ (Step 2), the screening rent at the R2 equilibrium is strictly positive:
$$\text{Rent}_{R2} = \int_1^{\theta_2^*} \alpha(\theta_2^* - \theta) \, dF(\theta) > 0. \quad \square$$

### Step 4: Majority eliminates screening

Under majority rule, a proposal passes with $q = \lfloor N/2 \rfloor + 1$ votes. Since $N \geq 3$, a weak proposer can assemble a winning coalition from the other weak states alone: the proposer plus $N-2$ other weak states gives $N-1$ votes, and $N - 1 \geq q$ for all $N \geq 3$. The hegemon's vote is not needed.

When $W$ proposes under majority, $W$ excludes $H$ from the winning coalition. $H$ receives its disagreement payoff $\alpha\theta$ regardless of $W$'s offer. Since $W$'s payoff does not depend on $H$'s acceptance decision, there is no screening problem: $W$ has no reason to vary its offer to $H$, and $H$'s private information creates no strategic leverage.

The hegemon's expected R2 payoff from $W$'s proposal under majority is:
$$E[V_H \mid W \text{ proposes, majority}] = \int_1^r \alpha\theta \, dF(\theta) = \alpha E[\theta].$$

This is exactly the "perfectly discriminating" benchmark. The screening rent is:
$$\text{Rent}_{M} = \alpha E[\theta] - \alpha E[\theta] = 0. \quad \square$$

### Step 5: R2 combined payoff comparison (W-proposes component only)

We now combine across proposer identities in R2 for the $W$-proposes component to show that unanimity generates strictly positive screening rent.

**When $H$ proposes in R2.** Under both rules, $H$ proposes an allocation that passes and $H$ keeps $\theta$:
- Under unanimity: $H$ offers $0$ to each $W$ (their R2 disagreement payoff), all accept, $H$ keeps $\theta$.
- Under majority: $H$ offers $0$ to $q-1$ weak states (buying a majority), keeps $\theta$.

In both cases, $V_H^{R2}(\theta, H \text{ proposes}) = \theta$, so this component contributes equally under both rules and generates zero screening rent under either rule.

**When $W$ proposes in R2.** Under majority, $H$ gets $\alpha\theta$. Under unanimity, $H$ gets $\alpha\theta_2^*$ if $\theta \leq \theta_2^*$ and $\alpha\theta$ if $\theta > \theta_2^*$.

The screening rent from $W$'s proposals, aggregated across proposer identities (weighting by the probability $(N-1)/N$ that a weak state proposes), is:
$$\frac{N-1}{N} \cdot \text{Rent}_{R2} = \frac{N-1}{N} \int_1^{\theta_2^*} \alpha(\theta_2^* - \theta) \, dF(\theta) > 0. \quad \square$$

### Step 6: R1 screening under unanimity (W proposes)

Round 1 has the same qualitative structure as Round 2, with the R2 continuation value replacing the disagreement payoff as the outside option. We prove the R1 screening rent is strictly positive by explicitly computing the relevant objects.

**R2 continuation value.** The R2 expected payoff for type $\theta$ under unanimity, taken over the random proposer draw, is:
$$V_H^{R2}(\theta, U) = \frac{1}{N} \cdot \theta + \frac{N-1}{N} \cdot \begin{cases} \alpha\theta_2^* & \text{if } \theta \leq \theta_2^*, \\ \alpha\theta & \text{if } \theta > \theta_2^*. \end{cases}$$

The first term is the $H$-proposes component ($H$ keeps $\theta$, probability $1/N$). The second is the $W$-proposes component (probability $(N-1)/N$), which is the screening allocation from Step 1.

**Explicit formula for $\beta V_H^{R2}(\theta, U)$.** The R1 reservation value is $\beta V_H^{R2}(\theta, U)$, which is piecewise linear:

- For $\theta \leq \theta_2^*$:
$$\beta V_H^{R2}(\theta, U) = \beta\left[\frac{\theta}{N} + \frac{(N-1)\alpha\theta_2^*}{N}\right] = \frac{\beta}{N}\theta + \frac{\beta(N-1)\alpha\theta_2^*}{N}.$$
This is linear in $\theta$ with slope $\beta/N > 0$ and a positive intercept $\beta(N-1)\alpha\theta_2^*/N > 0$.

- For $\theta > \theta_2^*$:
$$\beta V_H^{R2}(\theta, U) = \beta \cdot \frac{\theta[1 + (N-1)\alpha]}{N} = \frac{\beta[1 + (N-1)\alpha]}{N}\theta.$$
This is linear in $\theta$ with slope $\beta[1 + (N-1)\alpha]/N > \beta/N$ (steeper than the first piece).

**Properties of $\beta V_H^{R2}(\theta, U)$.** The function is:
1. *Piecewise linear* with a kink at $\theta_2^*$.
2. *Continuous* at $\theta_2^*$: substituting $\theta = \theta_2^*$ in both pieces gives $\beta[\theta_2^* + (N-1)\alpha\theta_2^*]/N = \beta\theta_2^*[1+(N-1)\alpha]/N$.
3. *Strictly increasing*: slope $\beta/N > 0$ on $[1, \theta_2^*]$ and slope $\beta[1+(N-1)\alpha]/N > 0$ on $[\theta_2^*, r]$.

In a PBE, R2 beliefs after R1 rejection are the prior $F$ truncated to $(\theta_1^*, r]$. The structural properties used here---strict monotonicity of $V_H^{R2}(\theta, U)$ and interiority of the R2 cutoff---hold for any truncation of $F$, since truncation preserves full support on the restricted interval.

**R1 acceptance condition.** When $W$ proposes in R1, $W$ offers $y_H$ to $H$. Type $\theta$ accepts if and only if $y_H \geq \beta V_H^{R2}(\theta, U)$ (the offer weakly exceeds the discounted continuation value from proceeding to R2).

**Cutoff structure.** Since $\beta V_H^{R2}(\theta, U)$ is strictly increasing in $\theta$, the set of accepting types for any offer $y_H$ is an interval $\{\theta : \theta \leq \theta_1^*\}$, where $\theta_1^*$ is determined by $y_H = \beta V_H^{R2}(\theta_1^*, U)$. Equivalently, $W$ chooses a cutoff $\theta_1^* \in [1, r]$ and sets the offer $y_H^{R1} = \beta V_H^{R2}(\theta_1^*, U)$.

**W's R1 payoff.** The proposing $W$'s expected payoff from cutoff $\theta_1^*$ in R1 is:
$$\pi_W^{R1}(\theta_1^*) = \int_1^{\theta_1^*} \bigl(\theta - \beta V_H^{R2}(\theta_1^*, U)\bigr) \, dF(\theta).$$

When $H$ accepts ($\theta \leq \theta_1^*$), $W$ captures the surplus $\theta - y_H = \theta - \beta V_H^{R2}(\theta_1^*, U)$. When $H$ rejects ($\theta > \theta_1^*$), bargaining proceeds to R2, and $W$'s R1 payoff from these types is zero (the R2 payoff is a continuation, not an R1 surplus).

**Existence.** $\pi_W^{R1}$ is continuous on $[1, r]$, so a global maximizer $\theta_1^*$ exists by Weierstrass.

**$\theta_1^* > 1$.** We verify $\pi_W^{R1}(1) = 0$ and $\pi_W^{R1}(1 + \epsilon) > 0$ for small $\epsilon > 0$, using the same direct argument as Step 2. Note that $\pi_W^{R1}(1) = 0$ (integral over $[1,1]$). For $\epsilon > 0$ small:
$$\pi_W^{R1}(1 + \epsilon) = \int_1^{1+\epsilon} \bigl(\theta - \beta V_H^{R2}(1 + \epsilon, U)\bigr) \, dF(\theta).$$

For $\epsilon$ small enough that $1 + \epsilon \leq \theta_2^*$ (which holds for small $\epsilon$ since $\theta_2^* > 1$), the reservation value at $1 + \epsilon$ is:
$$\beta V_H^{R2}(1+\epsilon, U) = \frac{\beta(1+\epsilon)}{N} + \frac{\beta(N-1)\alpha\theta_2^*}{N}.$$

At $\theta = 1$ (the lower limit of integration), the integrand is:
$$1 - \frac{\beta(1+\epsilon)}{N} - \frac{\beta(N-1)\alpha\theta_2^*}{N}.$$

As $\epsilon \to 0$, this approaches $1 - \beta[1 + (N-1)\alpha\theta_2^*]/N$. Since $\beta < 1$, $\alpha < 1/r < 1$, and $\theta_2^* \leq r$, we have:
$$\frac{\beta[1 + (N-1)\alpha\theta_2^*]}{N} \leq \frac{\beta[1 + (N-1)\alpha r]}{N} < \frac{1 + (N-1)}{N} = 1,$$
where the last inequality uses $\beta < 1$ and $\alpha r < 1$. Therefore the integrand at $\theta = 1$ is strictly positive for small $\epsilon$. Since $f > 0$ on $(1, r)$ implies $F(1+\epsilon) > 0$, we conclude $\pi_W^{R1}(1+\epsilon) > 0$ for small $\epsilon$. Since $\pi_W^{R1}(1) = 0$, the point $\theta_1^* = 1$ is suboptimal, and every global maximizer satisfies $\theta_1^* > 1$.

**R1 screening rent.** H's expected payoff from W's R1 proposal under cutoff $\theta_1^*$ is:
$$E[V_H^{R1} \mid W \text{ proposes}] = \int_1^{\theta_1^*} \beta V_H^{R2}(\theta_1^*, U) \, dF(\theta) + \int_{\theta_1^*}^r \beta V_H^{R2}(\theta, U) \, dF(\theta).$$

The first integral covers accepting types (each receives $\beta V_H^{R2}(\theta_1^*, U)$); the second covers rejecting types (each proceeds to R2 and gets $\beta V_H^{R2}(\theta, U)$). The screening rent is the difference between H's actual payoff and what H would receive under perfect price discrimination (where each type gets exactly $\beta V_H^{R2}(\theta, U)$):

\begin{align}
\text{Rent}_{R1} &= E[V_H^{R1} \mid W \text{ proposes}] - \int_1^r \beta V_H^{R2}(\theta, U) \, dF(\theta) \\
&= \int_1^{\theta_1^*} \beta V_H^{R2}(\theta_1^*, U) \, dF(\theta) - \int_1^{\theta_1^*} \beta V_H^{R2}(\theta, U) \, dF(\theta) \\
&= \int_1^{\theta_1^*} \left[\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)\right] dF(\theta).
\end{align}

The second equality follows by splitting the $\int_1^r$ integral and canceling the $\int_{\theta_1^*}^r$ terms (exactly as in Step 3).

**Positivity.** For $\theta_1^* > 1$:
1. The integrand $\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)$ is strictly positive for all $\theta \in [1, \theta_1^*)$, because $V_H^{R2}(\cdot, U)$ is strictly increasing (established above) and $\theta < \theta_1^*$.
2. The measure $dF(\theta)$ assigns positive mass to $[1, \theta_1^*)$: $F(\theta_1^*) - F(1) = F(\theta_1^*) > 0$ since $\theta_1^* > 1$ and $F$ has full support.

Therefore:
$$\text{Rent}_{R1} = \int_1^{\theta_1^*} \left[\beta V_H^{R2}(\theta_1^*, U) - \beta V_H^{R2}(\theta, U)\right] dF(\theta) > 0.$$

**Majority in R1.** Under majority rule, the R1 structure inherits the same exclusion property. When $W$ proposes in R1 under majority, $W$ excludes $H$ from the winning coalition. $H$'s R1 payoff from $W$'s proposal is $\beta V_H^{R2}(\theta, M)$ type-by-type, where $V_H^{R2}(\theta, M) = \theta/N + (N-1)\alpha\theta/N = \theta[1 + (N-1)\alpha]/N$ (since under majority, $H$ gets $\theta$ when $H$ proposes and $\alpha\theta$ when $W$ proposes). Each type receives exactly its continuation value; there is no screening rent. $\text{Rent}_{R1}^M = 0$.

**Combined R1 screening rent across proposer identities:**
$$\text{Total R1 Rent} = \frac{N-1}{N} \cdot \text{Rent}_{R1} > 0. \quad \square$$

### Step 7: Connection to the discrete model

In the discrete model with $K=2$ types ($\theta \in \{0, 1\}$ mapping to $V \in \{1, r\}$), the distribution $F$ places mass $(1-\mu)$ on type $\theta=0$ (i.e., $V=1$) and $\mu$ on type $\theta=1$ (i.e., $V=r$). The screening problem reduces to a binary choice: offer $\alpha \cdot 1$ (aggressive, only low type accepts) or $\alpha \cdot r$ (conservative, both accept). The cutoff is the belief $\mu_s$ at which $W$ switches strategies.

With continuous types, the binary choice generalizes to a continuous cutoff $\theta^*$. The rent formula $\int_1^{\theta^*} \alpha(\theta^* - \theta) \, dF(\theta)$ nests the discrete case: setting $\theta^* = r$ in the discrete model with support $\{1, r\}$ and mass $(1-\mu)$ on $\theta = 1$, the integral becomes $\alpha(r-1)(1-\mu)$, which is the overpayment to type $\theta = 0$ under the conservative offer.

The substantive insight is preserved and generalized: unanimity forces $W$ to make a single offer to $H$ without knowing the type. Types below the cutoff are overpaid; this generates an information rent. Majority eliminates this by making $H$'s vote unnecessary. The continuous-type extension confirms that the mechanism is not an artifact of having only two types but a structural consequence of the veto power embedded in unanimity.

One qualitative difference with continuous types is worth noting. In the discrete model, $W$ faces a binary choice (aggressive vs. conservative), and the rent jumps discretely at the screening cutoff $\mu_s$. With continuous types, $W$ chooses a continuous cutoff, and the rent is a smooth function of the distribution $F$. The non-convexity in the hegemon's payoff that discrete screening creates (a jump at $\mu_s$) is replaced by a smoother informational advantage, but the sign of the advantage --- unanimity dominates majority in conditional payoffs from W's proposals --- is preserved.

## Summary

Under continuous types $\theta \sim F$ on $[1, r]$, unanimity generates a strictly positive screening rent for the hegemon whenever a weak state proposes, in both rounds of the Baron-Ferejohn game. The R2 rent is $\frac{N-1}{N}\int_1^{\theta_2^*}\alpha(\theta_2^* - \theta)\,dF(\theta) > 0$, arising because $W$ must set a single offer $y_H = \alpha\theta^*$ without observing $\theta$: all accepting types $\theta < \theta^*$ are overpaid by $\alpha(\theta^* - \theta)$. The R1 rent has the same structure with the piecewise-linear continuation value $\beta V_H^{R2}(\theta, U)$ replacing the disagreement payoff $\alpha\theta$. Under majority, $H$'s vote is not pivotal, so each type receives exactly its outside option, and the rent is zero in both rounds. The result holds for any CDF with full support on $[1,r]$ and any $\alpha \in (0, 1/r)$, confirming that the screening mechanism identified in the discrete model extends to arbitrary continuous type distributions. This proposition establishes the robustness of the qualitative mechanism (unanimity creates screening rent, majority does not) and is not a claim about total payoff dominance $V_H(U) > V_H(M)$, which requires comparing the $H$-proposes components and is established separately for $K = 2$ in Theorem 1.
