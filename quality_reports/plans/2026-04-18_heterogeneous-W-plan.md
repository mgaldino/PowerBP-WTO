# Plan: Heterogeneous Weak States Extension

**Status**: DRAFT  
**Date**: 2026-04-18

---

## 0. Motivation

The current model (V2, `formal_model.Rmd`) has identical weak states with a common entry cost $c$. Under a public signal, all weak states form the same posterior and make the same entry decision (Proposition 3, "All-or-None"). The value function $v(\mu, R)$ is a step function (zero below $\tau(R)$, affine above), and its concavification is a single line from the origin to the step, then the affine segment. The dominance condition $U_H^*(C) > U_H^*(A)$ reduces to comparing $v(\tau(C), C)/\tau(C)$ versus $v(\tau(A), A)/\tau(A)$ — a ratio of known constants. The key parameters ($\delta$, $g$, $c$, $N$) enter only through these ratios, and $\delta$ partially cancels. The model is "arithmetic": the institutional comparison is governed by a single inequality among constants, with no genuine interaction between the shape of the value function and the persuasion problem.

**This extension introduces two types of weak states with different entry costs.** The immediate consequence is that the value function acquires two steps (partial vs. full participation), and the concavification of a two-step function is structurally richer than that of a one-step function. The optimal BP may involve pooling at the lower step, the higher step, or mixing across both — creating a genuine optimization problem whose solution depends on the full shape of $v(\mu)$, not just a ratio.

---

## 1. Full Model Specification

### 1.1. Players

- One hegemon $H$.
- One "low-cost" weak state $W_L$ with entry cost $c_L > 0$.
- One "high-cost" weak state $W_H$ with entry cost $c_H > c_L$.
- Total: $N = 3$.

**Interpretation.** $W_L$ is an informed/sophisticated weak state that can evaluate deals cheaply (e.g., a state with strong bureaucratic capacity — Brazil, India). $W_H$ is an uninformed/skeptical weak state for which participation is costly (e.g., a small developing country with limited analytical capacity). The gap $c_H - c_L$ parameterizes heterogeneity.

### 1.2. State and Pie

- $\theta \in \{0, 1\}$ with prior $\Pr(\theta = 1) = p \in (0,1)$.
- Pie size: $V(\theta) = 1 + \theta\delta$, with $\delta > 0$.
  - $V(0) = 1$ (baseline surplus).
  - $V(1) = 1 + \delta$ (high surplus).
- $H$ observes $\theta$; weak states do not.
- After entry, $\theta$ is revealed to all members.

### 1.3. Complementarity

If $k \in \{0, 1, 2\}$ weak states enter, $H$ receives complementarity value $g(k)$:

- $g(0) = 0$ (no institution).
- $g(1) \geq 0$ (partial institution — one member).
- $g(2) > g(1)$ (full institution — both members).

The ratio $\rho \equiv g(2)/g(1)$ measures the **degree of complementarity**. When $\rho$ is large (supermodular complementarities), full participation is much more valuable than partial. When $\rho \approx 1$, partial participation suffices.

**Convention.** For parametric analysis, we can set $g(k) = \lambda k^\alpha$ with $\alpha > 1$ (as in the current simulation). This gives $g(1) = \lambda$, $g(2) = \lambda \cdot 2^\alpha$, and $\rho = 2^\alpha$. But the analysis below works for arbitrary $g(1), g(2)$ satisfying $g(2) > g(1) \geq 0$.

### 1.4. Institutional Packages

$R \in \{A, C\}$ as in the current model:

**Package A (Majority + Agenda):** $q = 2$ (need $q - 1 = 1$ of the 2 weak states). $H$ is the exclusive proposer. The institution forms if at least one $W$ enters.

**Package C (Consensus + No Agenda):** $q = 3$ (unanimity). Recognition symmetric ($1/3$ each). The institution forms only if both $W$ enter.

### 1.5. Stage 2: Continuation Values

The single-round redistribution game with pie $V(\theta)$ and status quo $V(\theta)/N$ proceeds as before.

**Under Package A** (majority, $q = 2$, $N = 3$):
$$s_H(A) = 1 - \frac{q-1}{N} = 1 - \frac{1}{3} = \frac{2}{3}, \qquad s_W(A) = \frac{q-1}{N(N-1)} = \frac{1}{3 \cdot 2} = \frac{1}{6}.$$

**Under Package C** (consensus, $N = 3$):
$$s_H(C) = s_W(C) = \frac{1}{N} = \frac{1}{3}.$$

Both types of $W$ receive the same share $s_W(R)$ — they differ only in entry cost, not in bargaining position.

### 1.6. Entry Thresholds

$W_i$ (with cost $c_i$) enters iff:
$$\mathbb{E}[V(\theta) \cdot s_W(R) \mid s] \geq c_i \iff s_W(R)(1 + \mu\delta) \geq c_i \iff \mu \geq \tau_i(R),$$
where:
$$\tau_i(R) \equiv \frac{c_i / s_W(R) - 1}{\delta}.$$

Since $c_L < c_H$:
$$\tau_L(R) < \tau_H(R) \quad \text{for each } R.$$

Since $s_W(A) = 1/6 < 1/3 = s_W(C)$:
$$\tau_i(A) > \tau_i(C) \quad \text{for each } i \in \{L, H\}.$$

**Four thresholds (in increasing order, under typical parameters):**
$$\tau_L(C) < \tau_H(C) < \tau_L(A) < \tau_H(A).$$

The exact ordering of the middle two ($\tau_H(C)$ vs. $\tau_L(A)$) depends on parameters. Define:
$$\tau_H(C) \lessgtr \tau_L(A) \iff \frac{c_H/s_W(C) - 1}{\delta} \lessgtr \frac{c_L/s_W(A) - 1}{\delta} \iff c_H \cdot s_W(A) \lessgtr c_L \cdot s_W(C).$$

For $N = 3$: $\tau_H(C) < \tau_L(A) \iff c_H / 6 < c_L / 3 \iff c_H < 2c_L$. So when $c_H < 2c_L$ (moderate heterogeneity), the ordering is $\tau_L(C) < \tau_H(C) < \tau_L(A) < \tau_H(A)$.

### 1.7. Timing

As in the current model, with one modification at Stage 1: entry decisions are asymmetric.

1. **Stage 0.** $H$ chooses $R \in \{A, C\}$.
2. **Stage 1.** Nature draws $\theta$. $H$ observes $\theta$, chooses signal $\pi: \{0,1\} \to \Delta(S)$, generates public signal $s$. $W_L$ and $W_H$ each observe $s$, form posterior $\mu(s)$, and independently decide whether to enter. Let $k = a_L + a_H$ denote the number of entrants.
3. **Stage 2.** If the institution forms (conditions depend on $R$), $\theta$ is revealed, members play the redistribution game.

**Key difference from the current model:** Under a public signal, $W_L$ and $W_H$ form the same posterior $\mu$ but have different thresholds. As $\mu$ rises, $W_L$ enters first (at $\tau_L$), then $W_H$ enters (at $\tau_H$). Entry is no longer all-or-none — there is an intermediate regime of partial participation.

---

## 2. Value Functions

### 2.1. Package A: Majority (need $k \geq 1$)

Under Package A, the institution forms with $k \geq 1$ W members. H's payoff depends on $k$:

**Region I: $\mu < \tau_L(A)$.** Neither $W$ enters. $k = 0$.
$$v_A(\mu) = 0.$$

**Region II: $\tau_L(A) \leq \mu < \tau_H(A)$.** Only $W_L$ enters. $k = 1$. The institution forms (majority needs only 1 of 2).
$$v_A(\mu) = g(1) + (1 + \mu\delta) \cdot s_H(A).$$

**Region III: $\mu \geq \tau_H(A)$.** Both enter. $k = 2$.
$$v_A(\mu) = g(2) + (1 + \mu\delta) \cdot s_H(A).$$

Written explicitly for $N = 3$ ($s_H(A) = 2/3$):

$$v_A(\mu) = \begin{cases}
0 & \text{if } \mu < \tau_L(A), \\[6pt]
g(1) + \frac{2}{3}(1 + \mu\delta) & \text{if } \tau_L(A) \leq \mu < \tau_H(A), \\[6pt]
g(2) + \frac{2}{3}(1 + \mu\delta) & \text{if } \mu \geq \tau_H(A).
\end{cases}$$

**Structure.** Two upward jumps (at $\tau_L(A)$ and $\tau_H(A)$), each followed by a linear segment with the same slope $\delta \cdot s_H(A) = 2\delta/3$. The jump sizes are:

- First jump (at $\tau_L(A)$): from $0$ to $g(1) + \frac{2}{3}(1 + \tau_L(A)\delta)$.
- Second jump (at $\tau_H(A)$): increase by $g(2) - g(1) > 0$.

The value function has a "staircase" shape: two steps connected by parallel linear segments, separated by a flat region at zero.

### 2.2. Package C: Consensus (need $k = 2$)

Under Package C, the institution forms only if both $W$ enter ($k = 2$). The binding constraint is the most skeptical type, $W_H$.

**Region I: $\mu < \tau_H(C)$.** $W_H$ does not enter. Institution does not form (regardless of $W_L$'s decision, since consensus requires both).
$$v_C(\mu) = 0.$$

**Region II: $\mu \geq \tau_H(C)$.** Both enter ($W_L$ enters a fortiori since $\tau_L(C) < \tau_H(C)$). $k = 2$.
$$v_C(\mu) = g(2) + (1 + \mu\delta) \cdot s_H(C).$$

Written explicitly for $N = 3$ ($s_H(C) = 1/3$):

$$v_C(\mu) = \begin{cases}
0 & \text{if } \mu < \tau_H(C), \\[6pt]
g(2) + \frac{1}{3}(1 + \mu\delta) & \text{if } \mu \geq \tau_H(C).
\end{cases}$$

**Structure.** One jump (at $\tau_H(C)$), then a linear segment with slope $\delta \cdot s_H(C) = \delta/3$. This is the standard step-function structure from the current model — consensus imposes an all-or-nothing constraint.

### 2.3. Comparison of Shapes

| Feature | $v_A(\mu)$ | $v_C(\mu)$ |
|---------|-----------|-----------|
| Number of steps | 2 | 1 |
| First threshold | $\tau_L(A)$ | $\tau_H(C)$ |
| Second threshold | $\tau_H(A)$ | — |
| Slope (positive region) | $2\delta/3$ | $\delta/3$ |
| Height at second step | $g(2) + \frac{2}{3}(1 + \tau_H(A)\delta)$ | — |
| Height at onset | $g(1) + \frac{2}{3}(1 + \tau_L(A)\delta)$ | $g(2) + \frac{1}{3}(1 + \tau_H(C)\delta)$ |

The structural asymmetry is clear: $v_A$ has a richer geometry (two-step staircase), while $v_C$ has the simpler one-step form. The concavification of $v_A$ is the source of new results.

---

## 3. Concavification

### 3.1. Review: Concavification of a One-Step Function

For $v_C(\mu)$: zero for $\mu < \tau_H(C)$, then affine. The concave closure is:

$$\operatorname{cav} v_C(\mu) = \begin{cases}
\frac{\mu}{\tau_H(C)} \cdot v_C(\tau_H(C)) & \text{if } \mu \leq \tau_H(C), \\[6pt]
v_C(\mu) & \text{if } \mu > \tau_H(C).
\end{cases}$$

This is the standard KG11 construction. The optimal signal sends $\mu = \tau_H(C)$ with probability $p/\tau_H(C)$ and $\mu = 0$ with the complementary probability. The payoff is $v_C(\tau_H(C)) \cdot p / \tau_H(C)$ when $p < \tau_H(C)$.

### 3.2. Concavification of the Two-Step Function $v_A(\mu)$

This is the key technical step. The function $v_A$ has three pieces:

- Piece 0: $v_A = 0$ on $[0, \tau_L(A))$.
- Piece 1: $v_A = g(1) + \frac{2}{3}(1+\mu\delta)$ on $[\tau_L(A), \tau_H(A))$.
- Piece 2: $v_A = g(2) + \frac{2}{3}(1+\mu\delta)$ on $[\tau_H(A), 1]$.

Note that Pieces 1 and 2 are parallel lines (same slope $2\delta/3$), with Piece 2 shifted up by $g(2) - g(1) > 0$.

Define the key values:

$$h_1 \equiv v_A(\tau_L(A)) = g(1) + \tfrac{2}{3}(1 + \tau_L(A)\delta), \qquad \text{(height at first step)}$$

$$h_2^{-} \equiv v_A(\tau_H(A)^-) = g(1) + \tfrac{2}{3}(1 + \tau_H(A)\delta), \qquad \text{(height just before second step)}$$

$$h_2 \equiv v_A(\tau_H(A)) = g(2) + \tfrac{2}{3}(1 + \tau_H(A)\delta), \qquad \text{(height at second step)}$$

$$h_{end} \equiv v_A(1) = g(2) + \tfrac{2}{3}(1 + \delta). \qquad \text{(height at } \mu = 1\text{)}$$

The concavification must "fill in" the two gaps (the zero region and the jump at $\tau_H(A)$). There are three qualitatively distinct cases, depending on which points the concave closure connects.

#### Case 1: "Direct to top" — The line from $(0, 0)$ to $(\tau_H(A), h_2)$ lies above Piece 1.

The concave closure ignores the first step entirely. It connects the origin directly to the onset of Piece 2, then follows Piece 2.

**Condition.** The line $\ell(\mu) = \frac{\mu}{\tau_H(A)} \cdot h_2$ satisfies $\ell(\mu) \geq v_A(\mu)$ for all $\mu \in [\tau_L(A), \tau_H(A))$.

Since $v_A(\mu) = g(1) + \frac{2}{3}(1+\mu\delta)$ on this interval and $\ell(\mu) = \mu \cdot h_2/\tau_H(A)$, the binding constraint is at $\mu = \tau_H(A)^{-}$:

$$\ell(\tau_H(A)^{-}) = h_2 \geq h_2^{-} = g(1) + \tfrac{2}{3}(1 + \tau_H(A)\delta).$$

This is always satisfied since $h_2 = g(2) + \frac{2}{3}(1 + \tau_H(A)\delta) > g(1) + \frac{2}{3}(1 + \tau_H(A)\delta) = h_2^{-}$.

But we also need the line to lie above $v_A$ at $\mu = \tau_L(A)$:

$$\ell(\tau_L(A)) = \frac{\tau_L(A)}{\tau_H(A)} \cdot h_2 \geq h_1 = g(1) + \tfrac{2}{3}(1 + \tau_L(A)\delta).$$

Substituting $h_2 = g(2) + \frac{2}{3}(1 + \tau_H(A)\delta)$:

$$\frac{\tau_L(A)}{\tau_H(A)} \left[g(2) + \tfrac{2}{3}(1 + \tau_H(A)\delta)\right] \geq g(1) + \tfrac{2}{3}(1 + \tau_L(A)\delta).$$

Expanding the left side:
$$\frac{\tau_L(A)}{\tau_H(A)} g(2) + \frac{2}{3}\frac{\tau_L(A)}{\tau_H(A)} + \frac{2\delta}{3} \tau_L(A) \geq g(1) + \frac{2}{3} + \frac{2\delta}{3}\tau_L(A).$$

The $\frac{2\delta}{3}\tau_L(A)$ terms cancel:

$$\frac{\tau_L(A)}{\tau_H(A)} g(2) + \frac{2}{3}\frac{\tau_L(A)}{\tau_H(A)} \geq g(1) + \frac{2}{3}.$$

$$\frac{\tau_L(A)}{\tau_H(A)} \left[g(2) + \frac{2}{3}\right] \geq g(1) + \frac{2}{3}.$$

$$\boxed{\frac{g(2) + \frac{2}{3}}{g(1) + \frac{2}{3}} \geq \frac{\tau_H(A)}{\tau_L(A)} = \frac{c_H}{c_L}.}$$

**Interpretation.** Case 1 holds when the complementarity jump $g(2) - g(1)$ is large relative to heterogeneity $c_H/c_L$. When the gain from full participation is large enough, H "skips" partial participation and persuades directly to the full-participation threshold.

In this case:

$$\operatorname{cav} v_A(\mu) = \begin{cases}
\frac{\mu}{\tau_H(A)} \cdot h_2 & \text{if } \mu \leq \tau_H(A), \\[6pt]
v_A(\mu) & \text{if } \mu > \tau_H(A).
\end{cases}$$

Optimal signal: $\mu^* = \tau_H(A)$ w.p. $p/\tau_H(A)$, else $\mu = 0$. Payoff: $U_H^*(A) = h_2 \cdot p / \tau_H(A)$.

**Note.** This has the same functional form as the homogeneous model — a single effective threshold. But $h_2$ and $\tau_H(A)$ now depend on $c_H$, not just $c$.

#### Case 2: "Stop at first step" — The line from $(0,0)$ through $(\tau_L(A), h_1)$ lies above the continuation.

The concave closure connects the origin to the onset of Piece 1, follows Piece 1 until it naturally dominates Piece 2 (but Piece 2 is always above Piece 1, so this doesn't happen exactly this way). More precisely:

The concave closure connects $(0,0)$ to $(\tau_L(A), h_1)$, then follows Piece 1 as long as Piece 1 lies on the concave closure. Since Piece 2 jumps above Piece 1 at $\tau_H(A)$, the concave closure must also "bridge" the jump at $\tau_H(A)$.

**Sub-case 2a: The line from Piece 1 just before $\tau_H(A)$ to $(\tau_H(A), h_2)$ (or beyond) is steeper than Piece 1.**

Actually, since Piece 1 and Piece 2 are parallel (both have slope $2\delta/3$), and Piece 2 lies strictly above Piece 1 by the constant $g(2) - g(1)$, the concave closure in the "bridge" region $[\tau_L(A), \tau_H(A)]$ must connect the Piece 1 onset to the Piece 2 onset by a line.

Wait — let me be more careful. The concavification is the smallest concave function $\geq v_A$ everywhere. Consider the "support line" construction.

**Systematic construction of $\operatorname{cav} v_A$.**

$v_A$ consists of three segments: zero (flat at 0), Piece 1 (affine, slope $2\delta/3$, starting at height $h_1$ at $\mu = \tau_L$), and Piece 2 (affine, same slope, starting at height $h_2$ at $\mu = \tau_H$). Pieces 1 and 2 are parallel, with Piece 2 above Piece 1 by $\Delta g = g(2) - g(1)$.

The concavification of a piecewise-linear function with jumps can be computed geometrically. We need the upper concave envelope.

**Step A:** For $\mu > \tau_H(A)$: $v_A$ is already affine (hence concave), so $\operatorname{cav} v_A = v_A$ on $[\tau_H(A), 1]$.

**Step B:** For $\mu \in [\tau_L(A), \tau_H(A))$: $v_A$ is affine on this interval at a lower level. The concave closure must weakly exceed $v_A$. Consider the line connecting $(\tau_L(A), h_1)$ to some point on Piece 2 (say $(\tau_H(A), h_2)$). This line has slope:

$$m_{bridge} = \frac{h_2 - h_1}{\tau_H(A) - \tau_L(A)} = \frac{[g(2) - g(1)] + \frac{2\delta}{3}(\tau_H(A) - \tau_L(A))}{\tau_H(A) - \tau_L(A)} = \frac{g(2) - g(1)}{\tau_H(A) - \tau_L(A)} + \frac{2\delta}{3}.$$

This slope is strictly greater than the slope of Pieces 1 and 2 (which is $2\delta/3$), because $g(2) > g(1)$. Therefore, the line from $(\tau_L(A), h_1)$ to $(\tau_H(A), h_2)$ has a **steeper** slope than the affine segments.

Now: since the line from $(\tau_L(A), h_1)$ to $(\tau_H(A), h_2)$ is steeper than Piece 1, it lies **above** Piece 1 on $(\tau_L(A), \tau_H(A))$. And since it ends at the start of Piece 2, and Piece 2 has a shallower slope, the line continues above Piece 2 for $\mu > \tau_H(A)$ — which means this line is NOT part of the concave closure (it would lie above $v_A$ for $\mu > \tau_H(A)$, but the concave closure must equal $v_A$ where $v_A$ is already concave).

**Correction.** The concave closure on $[\tau_L(A), 1]$ connects $(\tau_L(A), h_1)$ to $(1, h_{end})$ if this line lies above $v_A$ everywhere in between. The line from $(\tau_L(A), h_1)$ to $(1, h_{end})$:

$$\ell_{1\to end}(\mu) = h_1 + \frac{h_{end} - h_1}{1 - \tau_L(A)}(\mu - \tau_L(A)).$$

We need to check if $\ell_{1\to end}(\mu) \geq v_A(\mu)$ for all $\mu \in [\tau_H(A), 1]$.

At $\mu = \tau_H(A)$:
$$\ell_{1\to end}(\tau_H(A)) = h_1 + \frac{h_{end} - h_1}{1 - \tau_L(A)}(\tau_H(A) - \tau_L(A)).$$

We need $\ell_{1\to end}(\tau_H(A)) \geq h_2$, i.e.:

$$h_1 + \frac{h_{end} - h_1}{1 - \tau_L(A)}(\tau_H(A) - \tau_L(A)) \geq h_2.$$

Let $\Delta\tau = \tau_H(A) - \tau_L(A) = (c_H - c_L)/(s_W(A) \cdot \delta)$. Since $h_{end} - h_1 = [g(2) - g(1)] + \frac{2\delta}{3}(1 - \tau_L(A))$ and $h_2 - h_1 = [g(2) - g(1)] + \frac{2\delta}{3}\Delta\tau$, the condition becomes:

$$\frac{[g(2) - g(1)] + \frac{2\delta}{3}(1 - \tau_L(A))}{1 - \tau_L(A)} \cdot \Delta\tau \geq [g(2) - g(1)] + \frac{2\delta}{3}\Delta\tau.$$

$$\left[\frac{g(2) - g(1)}{1 - \tau_L(A)} + \frac{2\delta}{3}\right] \Delta\tau \geq [g(2) - g(1)] + \frac{2\delta}{3}\Delta\tau.$$

The $\frac{2\delta}{3}\Delta\tau$ cancels:

$$\frac{g(2) - g(1)}{1 - \tau_L(A)} \cdot \Delta\tau \geq g(2) - g(1).$$

$$\frac{\Delta\tau}{1 - \tau_L(A)} \geq 1 \iff \Delta\tau \geq 1 - \tau_L(A) \iff \tau_H(A) \geq 1.$$

But $\tau_H(A) < 1$ is required for the problem to be interesting (otherwise $W_H$ never enters under A). So $\ell_{1 \to end}(\tau_H(A)) < h_2$ whenever $\tau_H(A) < 1$. This means the line from $(\tau_L(A), h_1)$ to $(1, h_{end})$ dips below $v_A$ at $\tau_H(A)$.

**Conclusion.** The concavification on $[\tau_L(A), 1]$ cannot be a single line from Piece 1 to the end. The jump at $\tau_H(A)$ forces the concave closure to be piecewise: it follows Piece 1 up to some point, then jumps to Piece 2.

**The correct concavification of $v_A$:**

Since Pieces 1 and 2 are parallel and Piece 2 is above Piece 1, the concave closure on $[\tau_L(A), 1]$ **follows Piece 1 on $[\tau_L(A), \tau_H(A))$, then follows Piece 2 on $[\tau_H(A), 1]$** — but there is a gap at $\tau_H(A)$. The concavification must bridge this gap.

Actually, the correct statement is: the concave closure on $[\tau_L(A), 1]$ will consist of Piece 1 on $[\tau_L(A), \tau_H(A))$ and Piece 2 on $[\tau_H(A), 1]$, with the concavification "filling in" the jump discontinuity. Since the jump is upward and both pieces have the same slope, the concave closure must have a line segment from some point on Piece 1 to $(\tau_H(A), h_2)$ that lies above Piece 1.

But we showed that any such line from Piece 1 to $(\tau_H(A), h_2)$ is steeper than Piece 1 and hence lies above Piece 1 — which is fine for the concave closure, because it needs to be above $v_A$.

Wait: I need to think about this differently. The concavification at any point $\mu$ is:

$$\operatorname{cav} v_A(\mu) = \sup\left\{\alpha v_A(\mu_1) + (1-\alpha) v_A(\mu_2) : \alpha\mu_1 + (1-\alpha)\mu_2 = \mu, \; \alpha \in [0,1]\right\}.$$

For $\mu \in [0, \tau_L(A))$: the best we can do is put weight on $\mu = 0$ (value 0) and some $\mu' \geq \tau_L(A)$ (positive value). The question is whether it's better to target $\tau_L(A)$ (partial participation) or $\tau_H(A)$ (full participation).

For $\mu \in [\tau_L(A), \tau_H(A))$: $v_A$ is already positive (Piece 1). Can we do better by mixing? We could put weight on a posterior below $\tau_L(A)$ (value 0) and above $\tau_H(A)$ (Piece 2, higher value). This is beneficial if the weighted average exceeds $v_A(\mu)$.

**The full concavification has at most three pieces:**

1. A line from $(0, 0)$ to some target posterior $\mu^* \geq \tau_L(A)$.
2. Possibly a segment following Piece 1 (if $\mu^*$ is on Piece 1).
3. A connection to Piece 2, then following Piece 2.

The BP optimum for $p < \tau_L(A)$ involves choosing between:

**(a) Targeting the first step:** Induce $\mu^* = \tau_L(A)$ (partial participation). Payoff:
$$U_A^{partial}(p) = \frac{p}{\tau_L(A)} \cdot h_1 = \frac{p}{\tau_L(A)} \left[g(1) + \tfrac{2}{3}(1 + \tau_L(A)\delta)\right].$$

**(b) Targeting the second step:** Induce $\mu^* = \tau_H(A)$ (full participation). Payoff:
$$U_A^{full}(p) = \frac{p}{\tau_H(A)} \cdot h_2 = \frac{p}{\tau_H(A)} \left[g(2) + \tfrac{2}{3}(1 + \tau_H(A)\delta)\right].$$

**(c) Mixing:** Induce a distribution over $\mu_1 \in [\tau_L(A), \tau_H(A))$ (Piece 1) and $\mu_2 \geq \tau_H(A)$ (Piece 2). Since both pieces are affine with the same slope, the expected value from mixing is:
$$\alpha [g(1) + \tfrac{2}{3}(1+\mu_1\delta)] + (1-\alpha)[g(2) + \tfrac{2}{3}(1+\mu_2\delta)]$$
$$= \alpha g(1) + (1-\alpha)g(2) + \tfrac{2}{3}(1+(\alpha\mu_1 + (1-\alpha)\mu_2)\delta)$$
$$= \alpha g(1) + (1-\alpha)g(2) + \tfrac{2}{3}(1+\mu\delta)$$

where $\mu = \alpha\mu_1 + (1-\alpha)\mu_2$. The complementarity component is $\alpha g(1) + (1-\alpha)g(2)$, which is between $g(1)$ and $g(2)$. Compare this to options (a) and (b):

- Option (a) at $\mu$: $g(1) + \frac{2}{3}(1+\mu\delta)$ if $\mu \in [\tau_L, \tau_H)$.
- Mixing: $\alpha g(1) + (1-\alpha)g(2) + \frac{2}{3}(1+\mu\delta) > g(1) + \frac{2}{3}(1+\mu\delta)$ whenever $(1-\alpha) > 0$ and $g(2) > g(1)$.

So mixing always dominates staying on Piece 1 alone, because it captures some of the $g(2)$ complementarity.

But mixing requires sending some mass to $\mu \geq \tau_H(A)$, which is "expensive" (requires high posteriors). The question is whether the gain from $g(2) > g(1)$ justifies the cost.

**The BP optimum for the two-step function is therefore:**

$$U_H^*(A) = \max\left\{\frac{p}{\tau_L(A)} h_1, \; \frac{p}{\tau_H(A)} h_2\right\} \quad \text{when } p < \tau_L(A).$$

**Proof.** The concavification of $v_A$ at any $\mu < \tau_L(A)$ is:

$$\operatorname{cav} v_A(\mu) = \max\left\{\frac{\mu}{\tau_L(A)} h_1, \; \frac{\mu}{\tau_H(A)} h_2\right\}.$$

The first option corresponds to a signal that sends $\mu = \tau_L(A)$ (partial entry) or $\mu = 0$ (no entry). The second sends $\mu = \tau_H(A)$ (full entry) or $\mu = 0$ (no entry).

The first option dominates iff:
$$\frac{h_1}{\tau_L(A)} > \frac{h_2}{\tau_H(A)},$$
i.e., the "return per unit of threshold" is higher for partial participation.

**Why mixing between Piece 1 and Piece 2 is dominated.** Suppose we mix: send $\mu_1 = \tau_L(A)$ with weight $\alpha$ and $\mu_2 = \tau_H(A)$ with weight $1 - \alpha$, with $\alpha \tau_L + (1-\alpha)\tau_H = p$, i.e., $\alpha = (\tau_H - p)/(\tau_H - \tau_L)$. The expected payoff is:

$$\alpha h_1 + (1-\alpha) h_2.$$

Compare to the better of the two pure options. By the linearity of the payoff in $\alpha$, the mixture lies between the two pure options and hence cannot exceed the maximum. Formally, $\alpha h_1 + (1-\alpha) h_2 \leq \max(h_1, h_2)$, but the mixture achieves $p/\tau_L \cdot h_1$ only when $\alpha = p/\tau_L$, which occurs when $\mu_2 = 0$ (i.e., the second posterior is 0, not $\tau_H$).

Actually, let me reconsider more carefully. The binary signal that sends mass $p/\tau_L$ to $\tau_L$ and $1 - p/\tau_L$ to $0$ yields payoff $(p/\tau_L) h_1$. The binary signal that sends mass $p/\tau_H$ to $\tau_H$ and $1 - p/\tau_H$ to $0$ yields payoff $(p/\tau_H) h_2$.

A ternary signal could send mass to $0$, $\tau_L$, and $\tau_H$. The Bayes-plausibility constraint:
$$\alpha_0 \cdot 0 + \alpha_1 \cdot \tau_L + \alpha_2 \cdot \tau_H = p, \quad \alpha_0 + \alpha_1 + \alpha_2 = 1.$$

Payoff: $\alpha_1 h_1 + \alpha_2 h_2$. To maximize: set $\alpha_0$ as small as possible, subject to feasibility. This gives $\alpha_0 = 0$, $\alpha_1 \tau_L + \alpha_2 \tau_H = p$, $\alpha_1 + \alpha_2 = 1$, so $\alpha_1 = (\tau_H - p)/(\tau_H - \tau_L)$, $\alpha_2 = (p - \tau_L)/(\tau_H - \tau_L)$.

But wait — this requires $p \geq \tau_L$, which contradicts our assumption $p < \tau_L$. So the ternary signal with $\alpha_0 = 0$ is infeasible when $p < \tau_L$.

For $p < \tau_L$: any Bayes-plausible distribution must have $\alpha_0 > 0$ (some mass below $\tau_L$). The maximum payoff is indeed $\max\{(p/\tau_L) h_1, \; (p/\tau_H) h_2\}$.

**To see this rigorously:** If we assign mass $\alpha_1$ to $\tau_L$ and $\alpha_2$ to $\tau_H$:
$$\alpha_1 \tau_L + \alpha_2 \tau_H \leq p \quad (\text{since remaining mass goes to } 0).$$
$$\text{Payoff} = \alpha_1 h_1 + \alpha_2 h_2, \quad \text{maximize subject to } \alpha_1 \tau_L + \alpha_2 \tau_H = p.$$

This is a linear program. The extreme points are $(\alpha_1, \alpha_2) = (p/\tau_L, 0)$ and $(\alpha_1, \alpha_2) = (0, p/\tau_H)$. The optimum is one of these.

**Therefore:**

$$\operatorname{cav} v_A(\mu) = \max\left\{\frac{\mu}{\tau_L(A)} h_1, \; \frac{\mu}{\tau_H(A)} h_2\right\} \quad \text{for } \mu < \tau_L(A).$$

The critical condition is:

$$\frac{h_1}{\tau_L(A)} \gtrless \frac{h_2}{\tau_H(A)}.$$

Substituting:

$$\frac{g(1) + \frac{2}{3}(1 + \tau_L\delta)}{\tau_L(A)} \gtrless \frac{g(2) + \frac{2}{3}(1 + \tau_H\delta)}{\tau_H(A)}.$$

Cross-multiplying by $\tau_L \tau_H > 0$:

$$\tau_H \left[g(1) + \tfrac{2}{3}(1 + \tau_L\delta)\right] \gtrless \tau_L \left[g(2) + \tfrac{2}{3}(1 + \tau_H\delta)\right].$$

Expanding:
$$\tau_H g(1) + \tfrac{2}{3}\tau_H + \tfrac{2\delta}{3}\tau_L\tau_H \gtrless \tau_L g(2) + \tfrac{2}{3}\tau_L + \tfrac{2\delta}{3}\tau_L\tau_H.$$

The $\frac{2\delta}{3}\tau_L\tau_H$ terms cancel:

$$\tau_H g(1) + \tfrac{2}{3}\tau_H \gtrless \tau_L g(2) + \tfrac{2}{3}\tau_L.$$

$$\tau_H \left[g(1) + \tfrac{2}{3}\right] \gtrless \tau_L \left[g(2) + \tfrac{2}{3}\right].$$

$$\boxed{\frac{g(1) + \frac{2}{3}}{g(2) + \frac{2}{3}} \gtrless \frac{\tau_L(A)}{\tau_H(A)} = \frac{c_L}{c_H}.}$$

**Partial participation is optimal iff:**
$$\frac{g(1) + s_H(A)}{g(2) + s_H(A)} > \frac{c_L}{c_H},$$

where we used $s_H(A) = 2/3$. **Full participation is optimal iff the reverse inequality holds.**

**This is the central structural result.** The optimal BP strategy under Package A depends on a comparison between:
- The complementarity ratio $g(1)/g(2)$ (how much partial participation is worth relative to full), and
- The cost ratio $c_L/c_H$ (how much cheaper the low-cost type is).

When $g(2) \gg g(1)$ (strong complementarity) and $c_H \gg c_L$ (high heterogeneity), full participation is optimal: $H$ targets the skeptical type. When $g(1) \approx g(2)$ (weak complementarity) or $c_L \approx c_H$ (low heterogeneity), partial participation suffices.

### 3.3. Concavification for $p \in [\tau_L(A), \tau_H(A))$

When $p$ lies between the two thresholds, $W_L$ enters without persuasion. The question is whether $H$ should also try to persuade $W_H$.

$H$ can achieve:
- **No persuasion of $W_H$:** Payoff $= v_A(p) = g(1) + \frac{2}{3}(1+p\delta)$.
- **Persuade $W_H$:** Send a signal that pushes part of the posterior mass to $\tau_H(A)$. The concavification in this region mixes between $v_A(p)$ on Piece 1 and $v_A(\tau_H(A))$ on Piece 2.

Since Pieces 1 and 2 are parallel, and Piece 2 is shifted up by $\Delta g = g(2) - g(1)$, the concavification in $[\tau_L(A), \tau_H(A))$ involves a signal that sends mass to $\tau_H(A)$ (entering Piece 2) and mass to some low posterior (dropping to zero or staying on Piece 1). However, since $v_A$ is already positive in this region, the optimal strategy is either: stay on Piece 1 (no further persuasion) or push mass to $\tau_H$ and some mass to below $\tau_L$ (losing $W_L$ on the low realization).

The concavification is:

$$\operatorname{cav} v_A(\mu) = \max\{v_A(\mu), \; \text{line from } (0,0) \text{ through } (\tau_H(A), h_2)\} \quad \text{for } \mu \in [\tau_L(A), \tau_H(A)).$$

The line from origin through $(\tau_H(A), h_2)$ at $\mu$ is $(\mu/\tau_H(A)) \cdot h_2$. So:

$$\operatorname{cav} v_A(\mu) = \max\left\{g(1) + \tfrac{2}{3}(1+\mu\delta), \; \frac{\mu}{\tau_H(A)} h_2\right\}.$$

These intersect at some $\mu^{**}$. For $\mu < \mu^{**}$: the line dominates (mixing between $0$ and $\tau_H$). For $\mu > \mu^{**}$: Piece 1 dominates (stay with partial participation).

### 3.4. Summary: Full Concavification of $v_A$

For $p < \tau_L(A)$:

$$U_H^*(A) = p \cdot \max\left\{\frac{h_1}{\tau_L(A)}, \; \frac{h_2}{\tau_H(A)}\right\}.$$

For $\tau_L(A) \leq p < \tau_H(A)$:

$$U_H^*(A) = \max\left\{g(1) + \tfrac{2}{3}(1+p\delta), \; \frac{p}{\tau_H(A)} h_2\right\}.$$

For $p \geq \tau_H(A)$:

$$U_H^*(A) = g(2) + \tfrac{2}{3}(1+p\delta).$$

### 3.5. Summary: $U_H^*(C)$ (unchanged structure)

For $p < \tau_H(C)$:

$$U_H^*(C) = \frac{p}{\tau_H(C)} \left[g(2) + \tfrac{1}{3}(1+\tau_H(C)\delta)\right].$$

For $p \geq \tau_H(C)$:

$$U_H^*(C) = g(2) + \tfrac{1}{3}(1+p\delta).$$

---

## 4. Dominance Condition: When Does C Beat A?

### 4.1. Case: Both thresholds bind ($p < \tau_L(C) < \tau_H(C)$ and $p < \tau_L(A)$)

In this region:

$$U_H^*(C) = \frac{p}{\tau_H(C)} \left[g(2) + \tfrac{1}{3}(1+\tau_H(C)\delta)\right],$$

$$U_H^*(A) = p \cdot \max\left\{\frac{h_1}{\tau_L(A)}, \; \frac{h_2}{\tau_H(A)}\right\}.$$

$C$ dominates $A$ iff:

$$\frac{g(2) + \frac{1}{3}(1+\tau_H(C)\delta)}{\tau_H(C)} > \max\left\{\frac{h_1}{\tau_L(A)}, \; \frac{h_2}{\tau_H(A)}\right\}.$$

**Sub-case 4.1a: Partial participation is optimal under A** ($h_1/\tau_L > h_2/\tau_H$).

$$\frac{g(2) + \frac{1}{3}(1+\tau_H(C)\delta)}{\tau_H(C)} > \frac{g(1) + \frac{2}{3}(1+\tau_L(A)\delta)}{\tau_L(A)}.$$

This is a comparison of "return per threshold unit" between consensus (which always targets full participation) and majority with partial participation. The LHS benefits from $g(2) > g(1)$; the RHS benefits from $s_H(A) = 2/3 > 1/3 = s_H(C)$ and $\tau_L(A)$ being the relevant threshold.

**Sub-case 4.1b: Full participation is optimal under A** ($h_2/\tau_H > h_1/\tau_L$).

$$\frac{g(2) + \frac{1}{3}(1+\tau_H(C)\delta)}{\tau_H(C)} > \frac{g(2) + \frac{2}{3}(1+\tau_H(A)\delta)}{\tau_H(A)}.$$

Both sides target full participation ($g(2)$ on both). The comparison reduces to:

$$\frac{g(2) + \frac{1}{3}(1+\tau_H(C)\delta)}{\tau_H(C)} > \frac{g(2) + \frac{2}{3}(1+\tau_H(A)\delta)}{\tau_H(A)}.$$

Cross-multiplying:

$$\tau_H(A) \left[g(2) + \tfrac{1}{3}(1+\tau_H(C)\delta)\right] > \tau_H(C) \left[g(2) + \tfrac{2}{3}(1+\tau_H(A)\delta)\right].$$

This condition depends on $g(2)$, $\delta$, $\tau_H(A)$, $\tau_H(C)$, and hence on $c_H$, $s_W(A)$, $s_W(C)$. It does NOT simplify to a ratio of constants independent of $\delta$.

**This is the non-linearity.** In the homogeneous model (V1/V2), $\delta$ cancels from the dominance condition. Here it does not, because the thresholds $\tau_H(C)$ and $\tau_H(A)$ both depend on $\delta$, and they enter the condition asymmetrically through the different share terms ($1/3$ vs $2/3$).

### 4.2. Dependence on Parameters

The dominance condition $C > A$ depends non-trivially on:

- **$g(1)$, $g(2)$** (or equivalently $g(2)/g(1) = \rho$): Higher $\rho$ favors C (consensus captures full complementarity; under A, the BP may settle for partial).
- **$c_L$, $c_H$** (or equivalently $c_H/c_L$): The heterogeneity gap. Affects which option is optimal under A.
- **$\delta$**: Pie sensitivity. Does NOT cancel. Enters through both the threshold locations and the value-function heights.
- **$s_H(A)$, $s_W(A)$, $s_H(C)$, $s_W(C)$**: Structural parameters from the bargaining stage.

**This is a genuine improvement over V1/V2**, where the condition was $[g + 1/N]/(c - 1/N) > [g + s_H(A)]/(c - s_W(A))$ — a comparison of two constants with $\delta$ absent.

---

## 5. Crossover Analysis

### 5.1. Does $p^*$ Still Exist?

Yes. For $p$ sufficiently large ($p > \tau_H(A)$), both packages achieve full participation without BP. In this region, $A$ dominates because $s_H(A) > s_H(C)$ — the hegemon extracts more under majority.

For $p$ sufficiently small ($p \to 0$), the comparison depends on the return-per-threshold ratios, which are constant in $p$. If $C$ dominates in this region (which it does when $g(2)$ is large enough), then there exists a crossover $p^*$.

The crossover $p^*$ is defined by $U_H^*(C, p^*) = U_H^*(A, p^*)$.

### 5.2. Multiple Crossovers

**New feature**: With heterogeneous W, there may be **multiple crossovers**. The payoff functions have different numbers of regimes:
- $U_H^*(A)$ has three regimes (below $\tau_L(A)$, between $\tau_L(A)$ and $\tau_H(A)$, above $\tau_H(A)$), with a potential kink at the boundary where the BP strategy switches from partial to full participation.
- $U_H^*(C)$ has two regimes (below $\tau_H(C)$, above $\tau_H(C)$).

The difference $U_H^*(C) - U_H^*(A)$ is piecewise linear in $p$, and its sign may change at regime boundaries. There could be up to two crossovers (one in the sub-$\tau_L(A)$ region, one in the $[\tau_L(A), \tau_H(A))$ region), though typically there will be one.

### 5.3. Dependence of $p^*$ on Heterogeneity $c_H - c_L$

**Key new comparative static.** As $c_H - c_L$ increases (more heterogeneous W):

1. $\tau_H(A)$ increases (harder to get both W under A), making full participation under A more expensive to target.
2. $\tau_H(C)$ increases (consensus requires the skeptical W), making consensus harder too — but consensus threshold increases more slowly because $s_W(C) > s_W(A)$.
3. The partial-participation option under A (targeting $\tau_L(A)$ alone) becomes more attractive.

**Predicted non-monotonicity:** For very low heterogeneity ($c_H \approx c_L$), the model approaches the homogeneous case and the dominance condition is arithmetic. For very high heterogeneity ($c_H \gg c_L$), partial participation under A is very cheap (low $\tau_L$) while consensus remains bottlenecked by $\tau_H(C)$ — so A may dominate. For intermediate heterogeneity, the trade-off is richest.

This suggests:

$$p^* \text{ is non-monotone in } (c_H - c_L) \text{ for fixed } c_L.$$

---

## 6. Key New Results Expected

### Result 1: Non-Trivial Role of $\delta$

In V1/V2, $\delta$ cancels from the dominance condition. With heterogeneous W:

$$\text{The institutional comparison depends on } \delta \text{ through the thresholds } \tau_i(R) = \frac{c_i/s_W(R) - 1}{\delta}.$$

As $\delta$ increases, thresholds decrease (entry becomes easier), but asymmetrically: the gap $\tau_H - \tau_L = (c_H - c_L)/(s_W(R) \cdot \delta)$ shrinks, collapsing toward the homogeneous case. Conversely, as $\delta \to 0$, thresholds blow up and the model becomes degenerate. The non-trivial regime is intermediate $\delta$.

### Result 2: Complementarity Ratio $\rho = g(2)/g(1)$ as the Key Parameter

- For $\rho$ large (supermodular): Full participation is critical. H targets $\tau_H$ under both packages. Consensus has the lower $\tau_H$ (since $\tau_H(C) < \tau_H(A)$), so C dominates.
- For $\rho \approx 1$ (near-linear): Partial participation suffices. Under A, H targets the cheap $\tau_L(A)$, which may have a better return ratio than $\tau_H(C)$ under C.
- **Cutoff in $\rho$**: There exists $\rho^*$ such that for $\rho > \rho^*$, consensus dominates.

### Result 3: Non-Monotonicity in Heterogeneity

$$\exists \; (c_H - c_L)^* \text{ that maximizes the region where C dominates.}$$

At zero heterogeneity: model is arithmetic (V2). At extreme heterogeneity: partial participation under A is cheap. Intermediate heterogeneity creates the richest trade-off.

### Result 4: Possible Statement

**Proposition (Consensus under Supermodular Complementarities).** Suppose $g(2) > g(1) > 0$ and $c_H > c_L > s_W(C)$. Then $H$ prefers Package C over Package A for all $p$ below a threshold $p^*$ if and only if:

$$\frac{g(2) + s_H(C)}{\tau_H(C)} > \max\left\{\frac{g(1) + s_H(A)}{\tau_L(A)}, \; \frac{g(2) + s_H(A)}{\tau_H(A)}\right\}.$$

The first term in the max corresponds to partial participation (A exploits heterogeneity); the second to full participation (A targets both W).

When partial participation is optimal under A, this simplifies to:
$$\frac{g(2) + \frac{1}{3}}{c_H - \frac{1}{3}} > \frac{g(1) + \frac{2}{3}}{c_L - \frac{1}{6}},$$
using $\tau_i(R) = (c_i/s_W(R) - 1)/\delta$ and noting that $\delta$ enters symmetrically in the numerator (through the height at threshold). Actually, let me verify this claim about $\delta$ canceling or not.

The return ratio for C: $\frac{g(2) + \frac{1}{3}(1+\tau_H(C)\delta)}{\tau_H(C)}$. Substituting $\tau_H(C) = \frac{c_H/(1/3) - 1}{\delta} = \frac{3c_H - 1}{\delta}$:

$$= \frac{g(2) + \frac{1}{3}\left(1 + \frac{3c_H-1}{\delta}\cdot\delta\right)}{\frac{3c_H-1}{\delta}} = \frac{g(2) + \frac{1}{3}(1 + 3c_H - 1)}{\frac{3c_H-1}{\delta}} = \frac{g(2) + c_H}{\frac{3c_H-1}{\delta}} = \frac{(g(2) + c_H)\delta}{3c_H - 1}.$$

Similarly, the return ratio for A (partial): $\frac{g(1) + \frac{2}{3}(1+\tau_L(A)\delta)}{\tau_L(A)}$. With $\tau_L(A) = \frac{c_L/(1/6) - 1}{\delta} = \frac{6c_L - 1}{\delta}$:

$$= \frac{g(1) + \frac{2}{3}(1 + 6c_L - 1)}{\frac{6c_L-1}{\delta}} = \frac{g(1) + 4c_L}{\frac{6c_L-1}{\delta}} = \frac{(g(1) + 4c_L)\delta}{6c_L - 1}.$$

**So $\delta$ factors out of both sides!** The dominance condition becomes:

$$\frac{g(2) + c_H}{3c_H - 1} > \frac{g(1) + 4c_L}{6c_L - 1} \quad \text{(when partial participation is optimal under A)}.$$

And for the full-participation comparison:

$$\frac{g(2) + c_H}{3c_H - 1} > \frac{g(2) + 4c_H}{6c_H - 1} \quad \text{(when full participation is optimal under A)}.$$

**Wait — $\delta$ cancels again!** This is because $\tau(R)$ enters both the numerator (through $1 + \tau\delta$) and the denominator symmetrically. The $\delta$ in the threshold formula $\tau = (c/s_W - 1)/\delta$ cancels with the $\delta$ in the value-at-threshold $v(\tau) = g + s_H(1 + \tau\delta) = g + s_H \cdot c/s_W$.

**Revised assessment of $\delta$.** After careful algebra, $\delta$ cancels from the return ratios $v(\tau)/\tau$ for each package. This means $\delta$ does NOT break the arithmetic nature of the model.

However, $\delta$ still matters for the **regime boundaries**: whether $p$ falls below $\tau_L(A)$, between $\tau_L$ and $\tau_H$, or above $\tau_H$. The institutional comparison can change across regimes, and the regime boundaries themselves depend on $\delta$. So $\delta$ enters the crossover $p^*$ through the regime structure, even though it cancels from the within-regime comparison.

**Revised non-linearity claim:** The non-linearity comes from having **two regimes under A** (partial vs. full participation), each with a different return ratio. The overall comparison between C and A depends on which regime A is in, which depends on $p$ and $\delta$. This is genuinely richer than the homogeneous model, where there is only one regime.

---

## 7. Comparison with V1/V2

### 7.1. V1/V2 Model (Homogeneous W)

All W have the same cost $c$. Under a public signal, entry is all-or-none. The value function is a single step.

$$U_H^*(R) = \frac{p}{\tau(R)} \left[g + s_H(R)(1 + \tau(R)\delta)\right] = \frac{p}{\tau(R)} \left[g + \frac{c \cdot s_H(R)}{s_W(R)}\right].$$

The dominance condition is:

$$\frac{g + c \cdot s_H(C)/s_W(C)}{\tau(C)} > \frac{g + c \cdot s_H(A)/s_W(A)}{\tau(A)}.$$

Using $s_H(C)/s_W(C) = 1$ and substituting $\tau(R) = (c/s_W(R) - 1)/\delta$:

$$\frac{(g + c)\delta}{c/s_W(C) - 1} > \frac{(g + c \cdot s_H(A)/s_W(A))\delta}{c/s_W(A) - 1}.$$

$\delta$ cancels. The condition is:

$$\frac{g + c}{c \cdot N - 1} > \frac{g + c \cdot s_H(A)/s_W(A)}{c/s_W(A) - 1}.$$

This is a single inequality in $g$, $c$, and $N$ (through the shares). **No role for $\delta$, no role for heterogeneity, no regime switching.**

### 7.2. This Extension (Heterogeneous W)

The dominance condition has TWO sub-cases (depending on whether A targets partial or full participation). The condition that determines which sub-case applies is:

$$\frac{g(1) + s_H(A)}{g(2) + s_H(A)} \gtrless \frac{c_L}{c_H}.$$

**This is a genuine interaction** between complementarity structure ($g(1), g(2)$) and heterogeneity ($c_L, c_H$) that has no analogue in V1/V2.

### 7.3. What the Extension Adds

1. **Endogenous BP strategy under A**: The hegemon chooses between targeting partial or full participation — a genuine optimization absent in V1/V2.
2. **Complementarity ratio $\rho = g(2)/g(1)$**: A new parameter that governs the BP strategy and the institutional comparison.
3. **Cost ratio $c_H/c_L$**: A new parameter that interacts with $\rho$.
4. **Regime-dependent comparison**: The institutional comparison changes character depending on which BP strategy is optimal under A.
5. **Richer comparative statics**: Non-monotonicity in heterogeneity, interaction between $\rho$ and $c_H/c_L$.

What it does NOT add (after careful algebra): $\delta$ still cancels within each regime. The improvement is structural (multiple regimes with regime-switching) rather than parametric (new role for $\delta$).

---

## 8. Implementation Plan

### Phase 1: Analytical Derivation (this plan)

- [x] Model specification (Section 1)
- [x] Value functions (Section 2)
- [x] Concavification (Section 3)
- [x] Dominance condition (Section 4)
- [x] Crossover analysis (Section 5)
- [x] Comparison with V1/V2 (Section 7)

### Phase 2: R Simulation (`scripts/sim_heterogeneous_W.R`)

1. **Implement value functions** $v_A(\mu)$ and $v_C(\mu)$ for arbitrary $(g_1, g_2, c_L, c_H, \delta, N)$.
2. **Implement concavification**: compute $U_H^*(A)$ and $U_H^*(C)$ as functions of $p$.
3. **Verify analytical results**:
   - Check that $\delta$ cancels from return ratios (numerical verification).
   - Check the partial-vs-full threshold condition.
   - Check the crossover $p^*$.
4. **Plots**:
   - $v_A(\mu)$ and $v_C(\mu)$ for representative parameters (showing the two-step structure).
   - $U_H^*(A)$ and $U_H^*(C)$ vs $p$ (showing the crossover).
   - Heatmap: $(g_2/g_1, c_H/c_L)$ region where C dominates.
   - $p^*$ as a function of $c_H - c_L$ (showing non-monotonicity, if present).
   - $p^*$ as a function of $\rho = g(2)/g(1)$ (showing the cutoff).
5. **Comparative statics**:
   - Vary $\delta$: confirm regime effects but within-regime cancellation.
   - Vary $N$ (extend to $N = 5$): check that the structure generalizes (3 W types would give 3 steps under A, etc.).

### Phase 3: Formal Write-Up

- Add a new section to `formal_model.Rmd` (Section 6: "Extension: Heterogeneous Weak States") or create a separate `formal_model_v3.Rmd`.
- Definition: extended game with two W types.
- Lemma: entry thresholds and ordering.
- Proposition: optimal BP under A (partial vs. full participation condition).
- Proposition: dominance condition (two sub-cases).
- Proposition: comparative statics in $\rho$ and $c_H/c_L$.
- Theorem: extended institutional trade-off.

### Phase 4: Narrative Connection

- Explain why heterogeneity matters for the WTO puzzle: weak states are NOT homogeneous. Brazil and Chad face different entry costs.
- The complementarity ratio $\rho$ maps to a key empirical question: is broad membership supermodular (network effects, legitimacy) or approximately linear (additive contributions)?
- The partial-participation option under majority maps to the empirical observation that some IOs with majority rule operate with variable geometry (coalitions of the willing).

---

## 9. Open Questions

1. **Does the non-monotonicity in heterogeneity actually appear?** The argument is heuristic. The simulation will confirm or reject.

2. **What happens with more than two types?** With $K$ types, Package A has $K$ steps. The concavification involves choosing which step to target. The optimal strategy is always to target one of the $K$ steps (by the linear-programming argument). This generalizes cleanly.

3. **Private signals with heterogeneous W.** Under private signals, entry is no longer all-or-none even with homogeneous W. With heterogeneous W, the interaction between private signals and type-specific thresholds is much richer. This is a natural extension but substantially more complex.

4. **Is the $\delta$-cancellation exact or an artifact of the linear pie $V(\theta) = 1 + \theta\delta$?** With a nonlinear pie $V(\theta)$ (e.g., $V(\theta) = e^{\theta\delta}$), the cancellation would break. But the linear specification is standard and KISS-compliant.

5. **Endogenous complementarity.** If $g(k)$ depends on which types enter (not just how many), the analysis is richer. E.g., $g(\{L\}) \neq g(\{H\})$ — the value of having an informed member vs. a large market. This is an interesting extension but adds complexity.

---

## 10. Explicit Algebra: Worked Example ($N = 3$)

### Parameters

$N = 3$, $\delta = 1$, $c_L = 0.4$, $c_H = 0.6$, $g(1) = 0.5$, $g(2) = 2.0$.

### Shares

$s_H(A) = 2/3$, $s_W(A) = 1/6$, $s_H(C) = s_W(C) = 1/3$.

### Thresholds

$$\tau_L(A) = \frac{0.4/(1/6) - 1}{1} = \frac{2.4 - 1}{1} = 1.4.$$

This exceeds 1, so $W_L$ never enters under A without BP pushing $\mu$ above 1. This means A is infeasible for these parameters.

**Revised parameters**: $c_L = 0.2$, $c_H = 0.4$, $\delta = 1$.

$$\tau_L(A) = \frac{0.2/(1/6) - 1}{1} = 1.2 - 1 = 0.2.$$

$$\tau_H(A) = \frac{0.4/(1/6) - 1}{1} = 2.4 - 1 = 1.4.$$

$\tau_H(A) > 1$: $W_H$ never enters under A. So under A, at most partial participation ($k = 1$).

$$\tau_L(C) = \frac{0.2/(1/3) - 1}{1} = 0.6 - 1 = -0.4 < 0.$$

$W_L$ always enters under C (threshold negative).

$$\tau_H(C) = \frac{0.4/(1/3) - 1}{1} = 1.2 - 1 = 0.2.$$

**Ordering**: $\tau_L(C) < 0 < \tau_L(A) = 0.2 = \tau_H(C) < \tau_H(A) = 1.4 > 1$.

### Value Functions

**Package A**: Since $\tau_H(A) > 1$, $W_H$ never enters. The value function has only two pieces:

$$v_A(\mu) = \begin{cases} 0 & \mu < 0.2, \\ 0.5 + \frac{2}{3}(1 + \mu) & \mu \geq 0.2. \end{cases}$$

At $\mu = 0.2$: $v_A(0.2) = 0.5 + \frac{2}{3}(1.2) = 0.5 + 0.8 = 1.3$.

**Package C**: Since $\tau_L(C) < 0$, $W_L$ always enters. The binding threshold is $\tau_H(C) = 0.2$.

$$v_C(\mu) = \begin{cases} 0 & \mu < 0.2, \\ 2.0 + \frac{1}{3}(1 + \mu) & \mu \geq 0.2. \end{cases}$$

At $\mu = 0.2$: $v_C(0.2) = 2.0 + \frac{1}{3}(1.2) = 2.0 + 0.4 = 2.4$.

### BP Comparison

For $p < 0.2$ (both thresholds bind):

$$U_H^*(A) = \frac{p}{0.2} \cdot 1.3 = 6.5p.$$

$$U_H^*(C) = \frac{p}{0.2} \cdot 2.4 = 12p.$$

$C$ dominates ($12 > 6.5$). **Consensus is strongly preferred** because A cannot achieve full participation ($\tau_H(A) > 1$), so A is stuck with partial participation and low complementarity $g(1) = 0.5$, while C achieves full participation with high complementarity $g(2) = 2.0$.

**Revised example with feasible full participation under A**: $c_L = 0.18$, $c_H = 0.25$, $\delta = 2$, $g(1) = 0.5$, $g(2) = 1.5$.

$$\tau_L(A) = \frac{0.18/(1/6) - 1}{2} = \frac{0.08}{2} = 0.04.$$

$$\tau_H(A) = \frac{0.25/(1/6) - 1}{2} = \frac{0.5}{2} = 0.25.$$

$$\tau_H(C) = \frac{0.25/(1/3) - 1}{2} = \frac{-0.25}{2} < 0.$$

$\tau_H(C) < 0$: both W always enter under C. No BP needed. $U_H^*(C) = g(2) + \frac{1}{3}(1+p\delta) = 1.5 + \frac{1}{3}(1+2p) = \frac{11}{6} + \frac{2p}{3}$.

Under A, for $p < 0.04$:

$h_1 = 0.5 + \frac{2}{3}(1+0.04 \cdot 2) = 0.5 + \frac{2}{3}(1.08) = 0.5 + 0.72 = 1.22$.

$h_2 = 1.5 + \frac{2}{3}(1+0.25 \cdot 2) = 1.5 + \frac{2}{3}(1.5) = 1.5 + 1.0 = 2.5$.

$h_1/\tau_L = 1.22/0.04 = 30.5$.

$h_2/\tau_H = 2.5/0.25 = 10$.

Partial dominates ($30.5 > 10$).

$U_H^*(A) = 30.5p$.

$U_H^*(C) = 1.833 + 0.667p$.

$C > A$ iff $1.833 + 0.667p > 30.5p$ iff $p < 1.833/29.833 \approx 0.061$.

But the BP region under A is $p < 0.04$. For $p > 0.04$: $U_H^*(A) = g(1) + \frac{2}{3}(1+2p) = 0.5 + \frac{2}{3} + \frac{4p}{3} = \frac{7}{6} + \frac{4p}{3}$.

$C > A$ iff $\frac{11}{6} + \frac{2p}{3} > \frac{7}{6} + \frac{4p}{3}$ iff $\frac{4}{6} > \frac{2p}{3}$ iff $p < 1$.

So C dominates for all $p < 1$ in this parameter configuration — the complementarity advantage of consensus ($g(2) = 1.5$ vs $g(1) = 0.5$ under partial participation) overwhelms A's extraction advantage.

This example illustrates the mechanism clearly: with heterogeneous W, Package A may be stuck with partial participation, losing the complementarity gain that consensus captures.

---

## 11. Formulas Summary

### Thresholds (N = 3)

| Threshold | Formula | Simplified |
|-----------|---------|-----------|
| $\tau_L(A)$ | $(c_L/s_W(A) - 1)/\delta$ | $(6c_L - 1)/\delta$ |
| $\tau_H(A)$ | $(c_H/s_W(A) - 1)/\delta$ | $(6c_H - 1)/\delta$ |
| $\tau_L(C)$ | $(c_L/s_W(C) - 1)/\delta$ | $(3c_L - 1)/\delta$ |
| $\tau_H(C)$ | $(c_H/s_W(C) - 1)/\delta$ | $(3c_H - 1)/\delta$ |

### Return Ratios (after $\delta$ cancellation, $N = 3$)

| Package | Targeting | $v(\tau)/\tau$ simplified |
|---------|-----------|---------------------------|
| A, partial | $\tau_L(A)$ | $\delta(g(1) + 4c_L)/(6c_L - 1)$ |
| A, full | $\tau_H(A)$ | $\delta(g(2) + 4c_H)/(6c_H - 1)$ |
| C | $\tau_H(C)$ | $\delta(g(2) + c_H)/(3c_H - 1)$ |

(The $\delta$ factor is common to all and cancels in comparisons.)

### Partial-vs-Full Condition under A

$$\text{Partial optimal} \iff \frac{g(1) + 4c_L}{6c_L - 1} > \frac{g(2) + 4c_H}{6c_H - 1}.$$

### Dominance Condition (C > A, when partial is optimal under A)

$$\frac{g(2) + c_H}{3c_H - 1} > \frac{g(1) + 4c_L}{6c_L - 1}.$$

### Dominance Condition (C > A, when full is optimal under A)

$$\frac{g(2) + c_H}{3c_H - 1} > \frac{g(2) + 4c_H}{6c_H - 1}.$$

This last condition simplifies: cross-multiply and solve. It holds iff $(g(2) + c_H)(6c_H - 1) > (g(2) + 4c_H)(3c_H - 1)$.

Expanding: $6c_H g(2) - g(2) + 6c_H^2 - c_H > 3c_H g(2) - g(2) + 12c_H^2 - 4c_H$.

Simplifying: $3c_H g(2) - 6c_H^2 + 3c_H > 0$, i.e., $3c_H(g(2) - 2c_H + 1) > 0$, i.e.:

$$\boxed{g(2) > 2c_H - 1.}$$

When full participation is optimal under both A and C, **consensus dominates iff $g(2) > 2c_H - 1$**. For $c_H < 1/2$ (which is required for $\tau_H(C)$ to be positive when $\delta$ is not too small), this is $g(2) > 2c_H - 1 < 0$, which always holds. So when full participation is the target under both packages, consensus always dominates for the relevant parameter range.

**This means the interesting case is when A opts for partial participation.** The dominance condition then depends on $g(1)$, $g(2)$, $c_L$, $c_H$ — the full vector of heterogeneity and complementarity parameters.
