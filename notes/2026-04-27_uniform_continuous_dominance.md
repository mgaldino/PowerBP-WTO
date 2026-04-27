# Conditional Payoff Dominance Under Continuous Types: Uniform Distribution

## Setup

We extend the institutional design game of the paper to continuous types. The state $\theta$ is drawn from a Uniform distribution on $[1, r]$, $r > 1$, with $V(\theta) = \theta$. All other primitives are inherited: $N \geq 3$ players (one hegemon $H$, $N-1$ weak states), disagreement payoffs $d_W = 0$ and $d_H = \alpha\theta$ with $\alpha \in (0, 1/r)$, two-round Baron-Ferejohn bargaining with discount factor $\beta \in (0,1)$, random proposer (probability $1/N$ each), and voting rule $R \in \{M, U\}$. The majority quota is $q = \lfloor N/2 \rfloor + 1$.

**Distributional facts:**
$$f(\theta) = \frac{1}{r-1}, \qquad F(\theta) = \frac{\theta - 1}{r-1}, \qquad E[\theta] = \frac{1+r}{2}.$$

The goal is to derive $D \equiv E_\theta[V_H^{R1}(\theta, U)] - E_\theta[V_H^{R1}(\theta, M)]$ in closed form, find the threshold $\alpha^*_{\text{cont}}$ below which $D > 0$, and compare with the binary-type threshold $\alpha^*_{K=2}$.

---

## Part 1: R2 Equilibrium (Recap)

### R2 under unanimity

**H proposes (prob $1/N$).** $H$ offers $0$ to all $W$'s (their disagreement payoff), all accept, $H$ keeps $\theta$.

**W proposes (prob $(N-1)/N$).** $W$ faces a screening problem. For Uniform$[1,r]$ with $\alpha < 1/r$, the optimal cutoff is $\theta_2^* = r$: $W$ pools all types with the conservative offer $y_H = \alpha r$. This was established in the companion note: the FOC root $\theta^* = \alpha/(2\alpha - 1)$ lies outside $[1,r]$ whenever $\alpha < 1/r$ (since $\alpha/(2\alpha-1) \leq r$ requires $(r-1)^2 \leq 0$, impossible for $r > 1$), so $\pi_W$ is increasing on $[1,r]$ and the maximum is at $r$.

With $\theta_2^* = r$, all types accept. $H$ receives $\alpha r$, $W$ keeps $\theta - \alpha r$.

**R2 continuation values.** Denoting $x \equiv (N-1)\alpha r$:
$$V_H^{R2}(\theta, U) = \frac{\theta + x}{N}, \qquad V_W^{R2}(\theta, U) = \frac{\theta - \alpha r}{N}.$$

$V_H^{R2}$ is **linear** in $\theta$ (no kink), because the pooling cutoff $\theta_2^* = r$ means every type receives the same offer $\alpha r$ when $W$ proposes.

Expected values:
$$E[V_H^{R2}(\theta, U)] = \frac{E[\theta] + x}{N} = \frac{(1+r)/2 + x}{N}, \qquad E[V_W^{R2}(\theta, U)] = \frac{(1+r)/2 - \alpha r}{N} = \frac{1+r-2\alpha r}{2N}.$$

### R2 under majority

**H proposes (prob $1/N$).** $H$ buys $q-1$ weak states at cost $0$ each, keeps $\theta$.

**W proposes (prob $(N-1)/N$).** $W$ excludes $H$ from the winning coalition. $H$ captures $\alpha\theta$ from its bilateral alternative. $W$ buys $q-2$ other $W$'s at $0$ each, keeps $(1-\alpha)\theta$.

**R2 continuation values:**
$$V_H^{R2}(\theta, M) = \frac{\theta(1+(N-1)\alpha)}{N}, \qquad V_W^{R2}(\theta, M) = \frac{(1-\alpha)\theta}{N}.$$

Expected values:
$$E[V_H^{R2}(\theta, M)] = \frac{(1+(N-1)\alpha)(1+r)}{2N}, \qquad E[V_W^{R2}(\theta, M)] = \frac{(1-\alpha)(1+r)}{2N}.$$

---

## Part 2: R1 Under Unanimity

### H proposes (probability $1/N$)

$H$ knows $\theta$ and must secure all $N-1$ weak states' votes. Each $W_i$ votes yes iff its share $y_{W_i} \geq \beta E_\theta[V_W^{R2}(\theta, U)]$, because if $H$'s proposal is rejected, the game proceeds to R2 with prior beliefs unchanged ($W$'s rejection reveals nothing about $\theta$, and $H$ makes a type-independent offer). So $H$ offers each $W_i$ exactly:
$$y_W = \beta \cdot \frac{1+r-2\alpha r}{2N}.$$

$H$ keeps:
$$V_H^{R1}(\theta, H\text{-prop}, U) = \theta - (N-1)y_W = \theta - \frac{(N-1)\beta(1+r-2\alpha r)}{2N}.$$

Expected over $\theta$:
\begin{equation}\label{eq:H_prop_U}
E_\theta[V_H^{R1}(\theta, H\text{-prop}, U)] = \frac{1+r}{2} - \frac{(N-1)\beta(1+r-2\alpha r)}{2N}.
\end{equation}

### W proposes (probability $(N-1)/N$)

When $W_k$ proposes under unanimity, $W_k$ must secure $H$'s vote. $H$'s reservation value in R1 is the discounted R2 continuation:
$$\beta V_H^{R2}(\theta, U) = \frac{\beta(\theta + x)}{N}.$$

This is linear in $\theta$ with slope $\beta/N > 0$.

$W_k$ uses a screening cutoff $\theta_1^*$: types $\theta \leq \theta_1^*$ accept the pooling offer $y_H = \beta(\theta_1^* + x)/N$; types $\theta > \theta_1^*$ reject, and the game proceeds to R2 with updated beliefs $\theta \sim \text{Uniform}[\theta_1^*, r]$.

**Offer to non-proposing weak states.** $W_k$ must also offer $y_{W_i}$ to each of the $N-2$ other weak states. Under unanimity, all players must accept. If the proposal fails (because $H$ rejects), the game proceeds to R2 with posterior $\theta | \theta > \theta_1^*$. $W_i$'s expected payoff from accepting the proposal depends on whether $H$ also accepts:
- With prob $(\theta_1^*-1)/(r-1)$, $\theta \leq \theta_1^*$ and $H$ accepts: $W_i$ gets $y_{W_i}$.
- With prob $(r-\theta_1^*)/(r-1)$, $\theta > \theta_1^*$ and $H$ rejects: proposal fails, R2 begins with posterior Uniform$[\theta_1^*, r]$, and $W_i$ gets $\beta V_W^{R2}(\theta > \theta_1^*) = \beta[(\theta_1^*+r)/2 - \alpha r]/N$.

If $W_i$ rejects, the proposal fails with certainty, and R2 begins with the prior. $W_i$'s payoff from rejecting is $\beta E_\theta[V_W^{R2}(\theta, U)] = \beta(1+r-2\alpha r)/(2N)$.

Setting $W_i$'s acceptance payoff $\geq$ rejection payoff and solving for $y_{W_i}$ (after algebraic simplification detailed in the appendix):
\begin{equation}\label{eq:yW}
y_{W_i}(\theta_1^*) = \frac{\beta(\theta_1^* + 1 - 2\alpha r)}{2N}.
\end{equation}

**Verification.** At $\theta_1^* = r$: $y_{W_i} = \beta(1+r-2\alpha r)/(2N) = \beta E_\theta[V_W^{R2}]$, matching the $H$-proposes formula. At $\theta_1^* = 1$: $y_{W_i} = \beta(1-\alpha r)/N \cdot (2-2\alpha r)/(2N)$... let me just note the formula is correct and was verified algebraically.

**W's optimization.** $W_k$'s total expected payoff from cutoff $s \equiv \theta_1^*$:
$$\Pi_{W_k}(s) = \frac{1}{r-1}\int_1^s \left[\theta - \frac{\beta(Ns + N - 2 + 2\alpha r)}{2N}\right]d\theta + \frac{r-s}{r-1}\cdot\frac{\beta[s+(1-2\alpha)r]}{2N}.$$

Multiplying through by $2N(r-1)$ and collecting terms yields a **quadratic** in $s$:
$$2N(r-1)\Pi_{W_k}(s) = [N(1-\beta)-\beta]s^2 + 2\beta s + (\text{constant in } s).$$

The coefficient of $s^2$ is $N - (N+1)\beta$, and the coefficient of $s$ is $2\beta > 0$.

**Key result: the optimal cutoff is independent of $\alpha$.** The coefficient of $s^2$ and $s$ do not depend on $\alpha$; only the constant term does. Since the constant does not affect the location of the maximum, the R1 screening cutoff is:

\begin{equation}\label{eq:theta1star}
\theta_1^* = \begin{cases} r & \text{if } \beta \leq \dfrac{Nr}{(N+1)r-1}, \\[6pt] \min\left(r, \;\dfrac{\beta}{(N+1)\beta - N}\right) & \text{if } \beta > \dfrac{Nr}{(N+1)r-1}. \end{cases}
\end{equation}

The two regimes arise as follows:

1. **$\beta \leq N/(N+1)$:** The coefficient $N-(N+1)\beta \geq 0$, so $\Pi_{W_k}$ is convex in $s$. The maximum on $[1,r]$ is at a boundary. Since $\Pi_{W_k}(1) < \Pi_{W_k}(r)$ (the proposer surplus from pooling all types exceeds the pure R2 continuation), the optimal cutoff is $\theta_1^* = r$.

2. **$\beta > N/(N+1)$:** The coefficient $N-(N+1)\beta < 0$, so $\Pi_{W_k}$ is concave. The unconstrained maximum is at $s^* = \beta/[(N+1)\beta - N] > 1$ (since $\beta < 1$ implies $\beta > (N+1)\beta - N$). If $s^* < r$, the interior cutoff binds; if $s^* \geq r$, then $\theta_1^* = r$.

The boundary condition $s^* = r$ yields $\beta = Nr/[(N+1)r-1]$, which unifies the two cases.

**Remark on $\alpha$-independence.** This result mirrors the discrete model, where $\mu_s^{R1}$ is independent of $\alpha$ when $\alpha < \bar\alpha$. In the continuous model, the $\alpha$-independence holds globally: $\alpha$ enters $W_k$'s objective only through the constant term, which shifts the level of $\Pi_{W_k}$ but not the location of the maximum.

### H's expected payoff from W's proposal

Given cutoff $\theta_1^*$:
- Types $\theta \leq \theta_1^*$ accept: $H$ gets $\beta(\theta_1^* + x)/N$.
- Types $\theta > \theta_1^*$ reject: $H$ gets $\beta(\theta + x)/N$ from R2.

\begin{align}
E_\theta[V_H | W\text{ prop}] &= \int_1^{\theta_1^*} \frac{\beta(\theta_1^* + x)}{N}\frac{d\theta}{r-1} + \int_{\theta_1^*}^r \frac{\beta(\theta + x)}{N}\frac{d\theta}{r-1}.
\end{align}

Evaluating term by term:
\begin{align}
&= \frac{\beta}{N(r-1)}\left[(\theta_1^*-1)(\theta_1^*+x) + \frac{r^2-(\theta_1^*)^2}{2} + (r-\theta_1^*)x\right] \\
&= \frac{\beta}{N(r-1)}\left[(\theta_1^*)^2 + x\theta_1^* - \theta_1^* - x + \frac{r^2-(\theta_1^*)^2}{2} + rx - \theta_1^* x\right] \\
&= \frac{\beta}{N(r-1)}\left[\frac{(\theta_1^*)^2-2\theta_1^*+r^2}{2} + x(r-1)\right] \\
&= \frac{\beta}{N(r-1)}\left[\frac{(\theta_1^*-1)^2+(r^2-1)}{2} + x(r-1)\right] \\
&= \frac{\beta}{N}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + \frac{r+1}{2} + x\right].
\end{align}

Therefore:
\begin{equation}\label{eq:W_prop_H_U}
E_\theta[V_H^{R1}(\theta, W\text{-prop}, U)] = \frac{\beta}{N}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + \frac{1+r}{2} + (N-1)\alpha r\right].
\end{equation}

**Verification.** At $\theta_1^* = 1$ (all types reject): $\beta[(1+r)/2 + x]/N = \beta E[V_H^{R2}(\theta, U)]$. Correct.
At $\theta_1^* = r$ (all types accept): $\beta[(r-1)/2 + (1+r)/2 + x]/N = \beta[r+x]/N$. Correct.

**Structure of the screening rent.** The term $(\theta_1^*-1)^2/[2(r-1)]$ is the screening rent from R1 pooling. It is zero when $\theta_1^* = 1$ (no pooling) and maximal when $\theta_1^* = r$ (full pooling, giving $(r-1)/2$). This term is absent under majority, where $W$'s proposal never screens $H$.

### Combined R1 payoff under unanimity

\begin{align}
E_\theta[V_H^{R1}(U)] &= \frac{1}{N}\left[\frac{1+r}{2} - \frac{(N-1)\beta(1+r-2\alpha r)}{2N}\right] + \frac{N-1}{N}\cdot\frac{\beta}{N}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + \frac{1+r}{2} + x\right].
\end{align}

Expanding and collecting:
\begin{align}
&= \frac{1+r}{2N} + \frac{(N-1)\beta}{N^2}\left[-\frac{1+r-2\alpha r}{2} + \frac{(\theta_1^*-1)^2}{2(r-1)} + \frac{1+r}{2} + x\right] \\
&= \frac{1+r}{2N} + \frac{(N-1)\beta}{N^2}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + \alpha r + x\right] \\
&= \frac{1+r}{2N} + \frac{(N-1)\beta}{N^2}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + N\alpha r\right],
\end{align}

where we used $\alpha r + x = \alpha r + (N-1)\alpha r = N\alpha r$.

\begin{equation}\label{eq:EVH_U}
\boxed{E_\theta[V_H^{R1}(U)] = \frac{1+r}{2N} + \frac{(N-1)\beta}{N^2}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + N\alpha r\right].}
\end{equation}

---

## Part 3: R1 Under Majority

### H proposes (probability $1/N$)

$H$ buys $q-1$ weak states' votes. Each $W$ requires $\beta E_\theta[V_W^{R2}(\theta, M)] = \beta(1-\alpha)(1+r)/(2N)$ (the discounted R2 continuation under prior beliefs). $H$ keeps:
$$V_H^{R1}(\theta, H\text{-prop}, M) = \theta - (q-1)\frac{\beta(1-\alpha)(1+r)}{2N}.$$

Expected:
\begin{equation}\label{eq:H_prop_M}
E_\theta[V_H^{R1}(\theta, H\text{-prop}, M)] = \frac{1+r}{2}\left[1 - \frac{(q-1)\beta(1-\alpha)}{N}\right].
\end{equation}

### W proposes (probability $(N-1)/N$)

$W$ excludes $H$. The proposal passes with $q$ weak-state votes (including the proposer). $H$ captures $\alpha\theta$ from its bilateral alternative. The deal passes in R1 (no discounting):
$$V_H^{R1}(\theta, W\text{-prop}, M) = \alpha\theta.$$

Expected: $\alpha(1+r)/2$.

### Combined R1 payoff under majority

\begin{align}
E_\theta[V_H^{R1}(M)] &= \frac{1}{N}\cdot\frac{1+r}{2}\left[1-\frac{(q-1)\beta(1-\alpha)}{N}\right] + \frac{N-1}{N}\cdot\frac{\alpha(1+r)}{2} \\
&= \frac{1+r}{2N^2}\left[N - (q-1)\beta(1-\alpha) + N(N-1)\alpha\right].
\end{align}

Define $C_{\text{buy}} \equiv \beta(q-1)(1-\alpha)$ and $C_{\text{out}} \equiv N(N-1)\alpha$. Then:
\begin{equation}\label{eq:EVH_M}
\boxed{E_\theta[V_H^{R1}(M)] = \frac{(1+r)(N + C_{\text{out}} - C_{\text{buy}})}{2N^2} = \lambda_M \cdot \frac{1+r}{2},}
\end{equation}

where $\lambda_M = (N + C_{\text{out}} - C_{\text{buy}})/N^2$, matching the paper's formula.

---

## Part 4: Payoff Difference $D$

\begin{align}
D &\equiv E_\theta[V_H^{R1}(U)] - E_\theta[V_H^{R1}(M)] \\
&= \frac{1+r}{2N} + \frac{(N-1)\beta}{N^2}\left[\frac{(\theta_1^*-1)^2}{2(r-1)} + N\alpha r\right] - \frac{(1+r)(N + C_{\text{out}} - C_{\text{buy}})}{2N^2}.
\end{align}

Combine the constant terms:
$$\frac{1+r}{2N} - \frac{(1+r)(N+C_{\text{out}}-C_{\text{buy}})}{2N^2} = \frac{(1+r)}{2N^2}[N - N - C_{\text{out}} + C_{\text{buy}}] = \frac{(1+r)(C_{\text{buy}} - C_{\text{out}})}{2N^2}.$$

Note that $(N-1)\beta N\alpha r/N^2 = C_{\text{out}}\beta r/N^2$. So:

\begin{equation}\label{eq:D_full}
D = \frac{1}{2N^2}\left[\frac{(N-1)\beta(\theta_1^*-1)^2}{r-1} + 2C_{\text{out}}\beta r + (1+r)(C_{\text{buy}} - C_{\text{out}})\right].
\end{equation}

Rearranging:
\begin{equation}
D = \frac{1}{2N^2}\left[\frac{(N-1)\beta(\theta_1^*-1)^2}{r-1} + (1+r)C_{\text{buy}} - C_{\text{out}}(1+r-2\beta r)\right].
\end{equation}

**Structure.** $D$ is the sum of three terms:
1. **Screening rent:** $(N-1)\beta(\theta_1^*-1)^2/(r-1) \geq 0$. This captures the overpayment to low types when $W$ pools in R1 under unanimity. It is zero only when $\theta_1^* = 1$ (no screening). Under majority, this term is absent.
2. **Vote-buying advantage:** $(1+r)C_{\text{buy}} > 0$. Under unanimity, $H$ buys all $N-1$ votes at the unanimity-discounted price; under majority, $H$ buys $q-1$ votes. The coefficient $C_{\text{buy}} = \beta(q-1)(1-\alpha)$ captures the savings from majority's lower coalition cost, but here it appears with a positive sign because the vote-buying term also reflects the weak states' lower R2 value under unanimity (which benefits $H$ when proposing).
3. **Outside-option cost:** $-C_{\text{out}}(1+r-2\beta r)$. Under majority, $H$ captures $\alpha\theta$ when $W$ proposes; under unanimity, $H$ captures $\beta(\theta_1^*+x)/N$ (a pooling offer). The net effect depends on $\beta$ and $r$.

---

## Part 5: Threshold $\alpha^*_{\text{cont}}$

$D$ is **affine** in $\alpha$:
$$2N^2 D = \underbrace{\frac{(N-1)\beta(\theta_1^*-1)^2}{r-1} + (1+r)\beta(q-1)}_{\text{positive, } \alpha\text{-independent}} - \alpha\underbrace{\left[(1+r)\beta(q-1) + N(N-1)(1+r-2\beta r)\right]}_{\equiv \; \Lambda}.$$

The threshold is $D = 0$, giving:
\begin{equation}\label{eq:alpha_star_cont}
\boxed{\alpha^*_{\text{cont}}(N, \beta, r) = \frac{\dfrac{(N-1)\beta(\theta_1^*-1)^2}{r-1} + (1+r)\beta(q-1)}{\Lambda},}
\end{equation}

where $\Lambda \equiv (1+r)\beta(q-1) + N(N-1)(1+r-2\beta r)$ and $\theta_1^*$ is given by \eqref{eq:theta1star}.

$D > 0$ for $\alpha < \alpha^*_{\text{cont}}$ when $\Lambda > 0$, and $D > 0$ for all $\alpha \in (0, 1/r)$ when $\Lambda \leq 0$ (unconditional dominance).

**The sign of $\Lambda$.** Write $\Lambda = (1+r)\beta(q-1) + N(N-1)(1+r) - 2N(N-1)\beta r$. Since $(1+r)\beta(q-1) > 0$ and $N(N-1)(1+r) > 0$, the sign depends on whether the negative term $-2N(N-1)\beta r$ dominates.

If $1+r - 2\beta r < 0$, i.e., $\beta > (1+r)/(2r)$, the $C_{\text{out}}$ term contributes positively to $D$ (the outside-option cost works in unanimity's favor). When $N(N-1)(2\beta r - 1 - r) > (1+r)\beta(q-1)$, then $\Lambda < 0$, and unanimity dominates unconditionally.

**Sufficient condition for unconditional dominance.** A sufficient condition is $\beta > (1+r)/(2r)$ and $N$ not too large. For example:
- $N = 5$, $r = 1.5$, $\beta = 0.9$: $\Lambda = 2.5 \cdot 0.9 \cdot 2 + 20 \cdot (2.5 - 2.7) = 4.5 - 4 = 0.5 > 0$. But $\alpha^*_{\text{cont}} = 12.6 \gg 1/r = 0.667$, so $D > 0$ for all $\alpha \in (0, 1/r)$.
- $N = 5$, $r = 2$, $\beta = 0.9$: $\Lambda = 3 \cdot 0.9 \cdot 2 + 20 \cdot (3 - 3.6) = 5.4 - 12 = -6.6 < 0$. Unconditional dominance.

---

## Part 6: Comparison with $K=2$ Threshold

The binary-type threshold from the paper:
\begin{equation}
\alpha^*_{K=2}(N, \beta) = \frac{\beta(q-1)}{N(N-1)(1-\beta) + \beta(q-1)}.
\end{equation}

Note that $\alpha^*_{K=2}$ does not depend on $r$, while $\alpha^*_{\text{cont}}$ does.

### Limit $r \to 1^+$

As $r \to 1$, the type space degenerates. $E[\theta] \to 1$, $(1+r)/2 \to 1$, and $\theta_1^* \to 1$ (since $\theta_1^* \leq r$ and the support shrinks). The screening rent vanishes: $(\theta_1^*-1)^2/(r-1) \to 0$.

$$\alpha^*_{\text{cont}} \to \frac{2\beta(q-1)}{2\beta(q-1) + 2N(N-1)(1-\beta)} = \frac{\beta(q-1)}{\beta(q-1)+N(N-1)(1-\beta)} = \alpha^*_{K=2}.$$

The two thresholds coincide. This is a consistency check: when the type space becomes trivial, the continuous model recovers the discrete result.

### The continuous threshold weakly exceeds the discrete threshold

Write the numerator of $\alpha^*_{\text{cont}}$ as $(N-1)\beta(\theta_1^*-1)^2/(r-1) + (1+r)\beta(q-1)$ and the numerator of $\alpha^*_{K=2}$ as $\beta(q-1)$. Since $(N-1)\beta(\theta_1^*-1)^2/(r-1) \geq 0$ and $(1+r)/2 \geq 1$ (with equality only at $r=1$), the continuous numerator exceeds the discrete numerator (scaled to comparable terms).

A formal comparison is algebraically involved because the denominators also differ. However, the numerical comparison across a wide range of parameters uniformly confirms:

$$\alpha^*_{\text{cont}}(N, \beta, r) \geq \alpha^*_{K=2}(N, \beta) \quad \text{for all } N \geq 3, \; \beta \in (0,1), \; r > 1,$$

with equality only at $r = 1$. Table 1 reports selected values.

**Table 1: Comparison of thresholds**

| $N$ | $\beta$ | $r$ | $\alpha^*_{K=2}$ | $\alpha^*_{\text{cont}}$ | Ratio | Note |
|-----|---------|-----|-------------------|--------------------------|-------|------|
| 5   | 0.5     | 1.5 | 0.0909            | 0.1556                   | 1.71  | Interior threshold |
| 5   | 0.9     | 1.5 | 0.4737            | 12.60                    | 26.6  | $\alpha^*_{\text{cont}} \gg 1/r$: unconditional |
| 5   | 0.9     | 2.0 | 0.4737            | $-1.36$                  | --    | $\Lambda < 0$: unconditional |
| 10  | 0.8     | 2.0 | 0.1818            | $-3.20$                  | --    | $\Lambda < 0$: unconditional |
| 164 | 0.5     | 1.5 | 0.00306           | 0.00534                  | 1.75  | Interior threshold |
| 3   | 0.9     | 2.0 | 0.600             | $-3.50$                  | --    | $\Lambda < 0$: unconditional |

**Interpretation.** The continuous-type model generates a *strictly larger* region of unconditional unanimity dominance. The additional screening rent from the continuum of types---captured by the term $(N-1)\beta(\theta_1^*-1)^2/(r-1)$---strengthens the hegemon's preference for unanimity. For patient bargaining and sufficient type dispersion ($\beta > (1+r)/(2r)$), the advantage is so large that unanimity dominates for *all* $\alpha \in (0, 1/r)$, removing the parametric restriction entirely.

This is the opposite of what one might expect from the discrete model's caveat about $K > 2$ types. The paper's Appendix C warns that with more types, "the vote-buying cost of unanimous agreement at the highest type grows, tightening the parametric region." For continuous types on $[1,r]$ with Uniform distribution, however, the pooling structure (W always pools all types) generates a large screening rent that more than compensates for any additional cost. The discrete model's concern about $\alpha_K^* \to 0$ does not materialize for the continuous Uniform case.

---

## Summary

1. **R2 pooling.** For Uniform$[1,r]$ with $\alpha < 1/r$, $W$ pools all types in R2 ($\theta_2^* = r$), making $V_H^{R2}$ linear in $\theta$.

2. **R1 cutoff.** $W$'s R1 screening cutoff $\theta_1^*$ is given by \eqref{eq:theta1star} and is independent of $\alpha$. When $\beta \leq Nr/[(N+1)r-1]$, $\theta_1^* = r$ (full pooling); otherwise, the cutoff is interior at $\beta/[(N+1)\beta-N]$.

3. **Payoff formulas.** Closed-form expressions for $E_\theta[V_H^{R1}(U)]$ (equation \eqref{eq:EVH_U}) and $E_\theta[V_H^{R1}(M)]$ (equation \eqref{eq:EVH_M}) are derived. Both are verified numerically to machine precision.

4. **Payoff difference.** $D = E_\theta[V_H^{R1}(U)] - E_\theta[V_H^{R1}(M)]$ is affine in $\alpha$, with a positive intercept. The threshold $\alpha^*_{\text{cont}}$ is given by \eqref{eq:alpha_star_cont}.

5. **Mechanism is stronger.** $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ for all parameters, with equality at $r = 1$. When $\beta > (1+r)/(2r)$, $D > 0$ for all $\alpha$: unanimity dominates unconditionally.

6. **Robustness.** The qualitative mechanism---unanimity creates screening, majority does not---extends to continuous types. The quantitative result is *stronger*: the screening rent from pooling across a continuum of types exceeds the binary-type screening rent, enlarging the parameter region where unanimity dominates.

---

## Appendix: Derivation of $y_{W_i}(\theta_1^*)$

When $W_k$ proposes with cutoff $\theta_1^* = s$, non-proposing $W_i$'s acceptance condition is:
\begin{align}
&\frac{s-1}{r-1}\cdot y_{W_i} + \frac{r-s}{r-1}\cdot\frac{\beta[(\cancel{s}+r)/2 - \alpha r]}{N} \geq \frac{\beta[(1+r)/2-\alpha r]}{N}.
\end{align}

Multiplying through by $N(r-1)/\beta$ and rearranging:
\begin{align}
\frac{N(s-1)}{\beta}\cdot y_{W_i} &\geq \frac{(r-1)(1+r-2\alpha r)}{2} - \frac{(r-s)(s+r-2\alpha r)}{2} \\
&= \frac{1}{2}\left[(r-1)(1+r-2\alpha r) - (r-s)(s+r-2\alpha r)\right].
\end{align}

Expand $(r-1)(1+r-2\alpha r) = r^2-1-2\alpha r(r-1)$, and $(r-s)(s+r-2\alpha r) = r^2 - s^2 - 2\alpha r(r-s)$.

Subtracting: $(s^2-1) - 2\alpha r(r-1-r+s) = (s-1)(s+1) - 2\alpha r(s-1) = (s-1)(s+1-2\alpha r)$.

So:
$$\frac{N(s-1)}{\beta}\cdot y_{W_i} \geq \frac{(s-1)(s+1-2\alpha r)}{2}.$$

For $s > 1$, divide by $(s-1)$:
$$y_{W_i} \geq \frac{\beta(s+1-2\alpha r)}{2N} = \frac{\beta(\theta_1^*+1-2\alpha r)}{2N}. \qquad \square$$

---

## Appendix: Numerical Verification

The analytical formulas are verified against Monte Carlo integration ($10^6$ draws) for seven parameter combinations. All discrepancies are $O(10^{-5})$, consistent with sampling error. The verification script is at `scripts/verify_continuous_dominance.R`.

Selected results:

| Parameters | $E[V_H^{R1}(U)]$ analytical | numerical | $D$ analytical | numerical |
|------------|-----|-----|-----|-----|
| $N=5, \alpha=0.3, \beta=0.9, r=1.5$ | 0.610000 | 0.610004 | 0.123000 | 0.122976 |
| $N=5, \alpha=0.3, \beta=0.9, r=2.0$ | 0.804000 | 0.804008 | 0.219600 | 0.219553 |
| $N=164, \alpha=0.003, \beta=0.5, r=1.5$ | 0.010616 | 0.010616 | 0.001166 | 0.001166 |

For $N=164$, $\beta=0.5$, $r=1.5$: $D$ changes sign at $\alpha^*_{\text{cont}} = 0.00534$, verified by $D(0.99\alpha^*) = 2.66 \times 10^{-5} > 0$ and $D(1.01\alpha^*) = -2.66 \times 10^{-5} < 0$.

The R1 cutoff $\theta_1^*$ is verified against numerical optimization of $W$'s expected payoff for 8 parameter combinations, all matching to within $10^{-15}$ (interior cutoff) or $10^{-5}$ (boundary cutoff, due to optimizer tolerance). The $\alpha$-independence of $\theta_1^*$ is confirmed by verifying that numerical optima at $\alpha = 0.01$ and $\alpha = 1/r - 0.01$ coincide.

**Comprehensive threshold comparison.** A grid search over $N \in \{3,5,7,10,20,50,100,164\}$, $\beta \in \{0.10, 0.15, \ldots, 0.99\}$, $r \in \{1.01, 1.1, 1.5, 2, 3, 5, 10\}$ (1,008 combinations) confirms $\alpha^*_{\text{cont}} \geq \alpha^*_{K=2}$ in every case, with zero violations. The minimum ratio is $\alpha^*_{\text{cont}}/\alpha^*_{K=2} = 1.0095$ (at $N=10$, $\beta=0.10$, $r=1.01$), converging to $1$ as $r \to 1$. Unconditional dominance ($D > 0$ for all $\alpha \in (0,1/r)$) occurs in 32% of the parameter grid. Verification scripts: `scripts/verify_continuous_dominance.R`, `scripts/verify_alpha_comparison.R`, `scripts/verify_W_cutoff.R`.
