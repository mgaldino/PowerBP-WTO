# Proof Reformulations for RIO Submission

**Date**: 2026-04-27  
**Purpose**: Rigorous proofs to replace informal arguments in appendix  
**Scope**: (1) Full PBE derivation under majority (Proposition 1), (2) Corrected inference in Proposition 4 case (ii)

---

## 1. Proposition 1: Majority Rule (Complete PBE Derivation)

**Statement.** *Under majority rule with symmetric proposal rights, the hegemon's expected continuation value $E_\theta[V_H^{R1}(\theta, \mu, M)]$ is affine in posterior beliefs $\mu$. There is no screening cutoff.*

**Proof.** We construct the unique PBE of the two-round Baron-Ferejohn bargaining game under majority rule, proceeding by backward induction from Round 2.

**Primitives and notation.** There are $N \geq 3$ players: one hegemon $H$ and $N-1$ weak states $W_1, \dots, W_{N-1}$. The state is $\theta \in \{0,1\}$ with $V(0) = 1$, $V(1) = r > 1$. Disagreement payoffs are $d_W = 0$ and $d_H = \alpha V(\theta)$, with $\alpha \in (0, 1/r)$. The majority quota is $q = \lfloor N/2 \rfloor + 1$. A proposer is selected uniformly (probability $1/N$). The discount factor is $\beta \in (0,1)$. Let $V_e(\mu) \equiv 1 + \mu(r-1)$ denote the expected cooperation value at belief $\mu$.

Throughout, "beliefs" refers to weak states' common posterior $\mu = \Pr(\theta = 1)$. The hegemon knows $\theta$ at every node.

### Step 1: Round 2 continuation values

Round 2 is the terminal bargaining round. If no agreement is reached, each player receives their disagreement payoff: $H$ receives $\alpha V(\theta)$; each $W_i$ receives $0$.

**Case A: $H$ proposes in R2.** The hegemon knows $\theta$ and makes a take-it-or-leave-it offer. To pass the proposal under majority, $H$ needs $q - 1$ votes from weak states (since $H$ votes for its own proposal). Each weak state $W_i$ accepts if and only if the offered share $x_{W_i} \geq 0$ (its disagreement payoff). The cheapest coalition consists of $q - 1$ weak states, each offered $x_{W_i} = 0$. The remaining $N - q$ weak states are excluded from the coalition (offered $0$ as well; they vote against but are not needed). Each excluded weak state receives $0$ (its disagreement payoff).

The hegemon keeps the entire pie:
$$V_H^{R2}(\theta, M \mid H \text{ proposes}) = V(\theta).$$

Each weak state's payoff when $H$ proposes is $0$, regardless of whether it is in the coalition or not (coalition members receive $0$ in the offer; excluded members receive $0$ from disagreement).

**Case B: $W_j$ proposes in R2.** The proposing weak state $W_j$ needs $q - 1$ additional votes. It can seek these votes from:

(a) $q - 1$ other weak states, each at cost $x_{W_i} = 0$ (their disagreement payoff), or
(b) $H$ plus $q - 2$ other weak states, at cost $\alpha V(\theta) + 0 \cdot (q-2)= \alpha V(\theta)$ for $H$'s vote.

We now show that option (a) is strictly cheaper. Under option (a), the total payment to coalition partners is $(q-1) \cdot 0 = 0$. Under option (b), the total payment is $\alpha V(\theta) > 0$ (since $\alpha > 0$ and $V(\theta) \geq 1$). Therefore $W_j$ strictly prefers to exclude $H$ from the winning coalition.

Under option (a), $W_j$ offers $0$ to $q - 1$ other weak states, who accept (indifferent, broken by the tie-breaking convention in favor of acceptance). The proposal passes with $q$ votes ($W_j$ plus $q-1$ coalition partners). The excluded players are $H$ and $N - q$ other weak states. The hegemon receives its disagreement payoff $\alpha V(\theta)$; excluded weak states receive $0$.

The proposing weak state keeps the surplus:
$$V_{W_j}^{R2}(\theta, M \mid W_j \text{ proposes}) = V(\theta) - \alpha V(\theta) = (1 - \alpha) V(\theta).$$

**R2 continuation values (ex ante over proposer identity).** Each player is recognized with probability $1/N$. The hegemon's R2 continuation value, conditional on $\theta$, is:

$$V_H^{R2}(\theta, M) = \frac{1}{N} \cdot V(\theta) + \frac{N-1}{N} \cdot \alpha V(\theta) = \frac{V(\theta)[1 + (N-1)\alpha]}{N}. \tag{R2-H}$$

The first term is the hegemon's payoff when it proposes (keeps everything); the second is the payoff when any of the $N-1$ weak states proposes (the hegemon is excluded and receives $\alpha V(\theta)$).

Each weak state's R2 continuation value, taking the expectation over $\theta$ using belief $\mu$, is:

$$V_W^{R2}(\mu, M) = \frac{1}{N} \cdot (1-\alpha) V_e(\mu) + \frac{N-2}{N} \cdot 0 + \frac{1}{N} \cdot 0 = \frac{(1-\alpha) V_e(\mu)}{N}. \tag{R2-W}$$

Here the three terms correspond to: (i) $W_i$ is the proposer and keeps $(1-\alpha)V(\theta)$ (taking expectation over $\theta$); (ii) another weak state $W_j$ proposes---$W_i$ is in the coalition with probability $(q-1)/(N-2)$ but receives $0$ either way (coalition payment or disagreement); (iii) $H$ proposes---$W_i$ receives $0$.

Note that $V_W^{R2}(\mu, M)$ depends on $\mu$ only through $V_e(\mu)$, which is affine in $\mu$.

### Step 2: Round 1 optimal offers

In Round 1, the proposer makes an offer; if rejected, the game proceeds to Round 2 with payoffs discounted by $\beta$.

**Case A: $H$ proposes in R1.** The hegemon needs $q - 1$ votes from weak states. Each weak state $W_i$ accepts if and only if its offered share $x_{W_i} \geq \beta V_W^{R2}(\mu, M)$ (the discounted R2 continuation value). The cheapest coalition is $q - 1$ weak states, each offered exactly $\beta V_W^{R2}(\mu, M)$. The remaining $N - q$ weak states are excluded.

The hegemon's R1 payoff when it proposes, conditional on $\theta$, is:
$$V(\theta) - (q-1) \beta V_W^{R2}(\mu, M).$$

Taking the expectation over $\theta$ using the true type (known to $H$) and over weak states' belief $\mu$:
$$\Pi_H^{\text{prop}}(\theta, \mu, M) = V(\theta) - (q-1) \beta \cdot \frac{(1-\alpha) V_e(\mu)}{N}. \tag{R1-H-prop}$$

Note: $H$ knows $\theta$ but the offer to weak states depends on $\mu$ (weak states' belief), since weak states evaluate the offer against their expected R2 continuation $V_W^{R2}(\mu, M)$.

**Case B: $W_j$ proposes in R1.** By the same coalition-cost argument as in R2, $W_j$ excludes $H$ from the winning coalition. The cost of including $H$ would be $\beta V_H^{R2}(\theta, M) = \beta V(\theta)[1+(N-1)\alpha]/N$, which depends on the unknown $\theta$. But this comparison is not even needed: the cost of $q-1$ other weak states is $(q-1) \cdot \beta V_W^{R2}(\mu, M) = (q-1) \beta (1-\alpha) V_e(\mu) / N$, which is strictly less than the cost of any coalition including $H$, because replacing one weak state (cost $0$ at disagreement payoff, or $\beta V_W^{R2}$ at the continuation value) with $H$ (cost $\beta V_H^{R2}(\theta, M) > 0$) is strictly more expensive.

More precisely, compare the two coalition strategies available to $W_j$:

- **Exclude $H$**: buy $q-1$ other $W$'s at $\beta V_W^{R2}(\mu, M)$ each. Total cost: $(q-1) \beta (1-\alpha) V_e(\mu) / N$.
- **Include $H$**: buy $H$ at $\beta V_H^{R2}(\theta, M)$ plus $q-2$ other $W$'s at $\beta V_W^{R2}(\mu, M)$ each. But $W_j$ does not observe $\theta$, so it must offer $H$ at least $\beta V_H^{R2}(\theta=1, M) = \beta r[1+(N-1)\alpha]/N$ to guarantee acceptance regardless of type (or face rejection risk). This exceeds the cost of one additional $W$: $\beta V_W^{R2}(\mu, M) = \beta(1-\alpha)V_e(\mu)/N$.

Since $V_H^{R2}(\theta, M) > V_W^{R2}(\mu, M)$ for all $\theta$ and $\mu$ (because $[1+(N-1)\alpha] > (1-\alpha)$ for $\alpha > 0$ and $V(\theta) \geq V_e(\mu)$ need not hold, but we can verify directly: $V(\theta)[1+(N-1)\alpha]/N$ vs $(1-\alpha)V_e(\mu)/N$ --- when $\theta = 0$, $H$'s R2 value is $[1+(N-1)\alpha]/N$ while $W$'s is $(1-\alpha)V_e(\mu)/N \leq (1-\alpha)r/N$, and $1+(N-1)\alpha > 1-\alpha + N\alpha = 1 + (N-1)\alpha > (1-\alpha)$ for $\alpha > 0$), the proposing $W_j$ always excludes $H$.

The key point is simpler and does not require these comparisons: $W_j$ can form a winning coalition entirely from other weak states. With $N - 1$ weak states total (excluding $W_j$) and a quota of $q = \lfloor N/2 \rfloor + 1$, the proposer needs $q - 1$ votes. Since $N - 2 \geq q - 1$ (which holds for $N \geq 3$ because $q - 1 = \lfloor N/2 \rfloor \leq N - 2$), there are enough other weak states to form a majority without $H$. Each weak state's reservation value is $\beta V_W^{R2}(\mu, M) \geq 0$, while $H$'s reservation value is $\beta V_H^{R2}(\theta, M) > 0$. Since weak states are cheaper coalition partners than $H$, the optimal coalition excludes $H$.

When $W_j$ proposes and excludes $H$:
- $H$ receives its bilateral alternative: $\alpha V(\theta)$.
- $W_j$ keeps: $V(\theta) - \alpha V(\theta) - (q-1) \beta V_W^{R2}(\mu, M) = (1-\alpha)V(\theta) - (q-1)\beta(1-\alpha)V_e(\mu)/N$.

Since $H$ is excluded from the coalition, the proposer pays $H$ its disagreement payoff $\alpha V(\theta)$ (the bilateral alternative that $H$ captures regardless of the vote outcome) and buys $q-1$ other weak states at their continuation values.

### Step 3: Hegemon's expected R1 payoff

The hegemon's expected R1 payoff aggregates over proposer identity and state $\theta$:

$$E_\theta[V_H^{R1}(\theta, \mu, M)] = \frac{1}{N} \cdot E_\theta[\Pi_H^{\text{prop}}(\theta, \mu, M)] + \frac{N-1}{N} \cdot E_\theta[\alpha V(\theta)].$$

**When $H$ proposes** (probability $1/N$):
\begin{align}
E_\theta[\Pi_H^{\text{prop}}(\theta, \mu, M)] &= E_\theta\left[V(\theta) - (q-1)\beta \frac{(1-\alpha)V_e(\mu)}{N}\right] \\
&= V_e(\mu) - \frac{(q-1)\beta(1-\alpha)V_e(\mu)}{N} \\
&= V_e(\mu) \left[1 - \frac{(q-1)\beta(1-\alpha)}{N}\right] \\
&= V_e(\mu) \cdot \frac{N - (q-1)\beta(1-\alpha)}{N}.
\end{align}

Note: $E_\theta[V(\theta)] = V_e(\mu)$ because beliefs are correct in equilibrium (the expectation is over the true distribution with parameter $\mu = p$).

**When $W_j$ proposes** (probability $(N-1)/N$, aggregated over all $N-1$ weak states):
$$E_\theta[\alpha V(\theta)] = \alpha V_e(\mu).$$

Combining:
\begin{align}
E_\theta[V_H^{R1}(\theta, \mu, M)] &= \frac{V_e(\mu)[N - (q-1)\beta(1-\alpha)]}{N^2} + \frac{(N-1)\alpha V_e(\mu)}{N} \\
&= \frac{V_e(\mu)}{N^2}\left[N - (q-1)\beta(1-\alpha) + N(N-1)\alpha\right] \\
&= \frac{V_e(\mu)}{N^2}\left[N + N(N-1)\alpha - \beta(q-1)(1-\alpha)\right].
\end{align}

Define $C_{\text{buy}} \equiv \beta(q-1)(1-\alpha)$ and $C_{\text{out}} \equiv N(N-1)\alpha$. Then:
$$E_\theta[V_H^{R1}(\theta, \mu, M)] = \frac{N + C_{\text{out}} - C_{\text{buy}}}{N^2} \cdot V_e(\mu) = \lambda_M \cdot V_e(\mu), \tag{$\star$}$$

where
$$\lambda_M \equiv \frac{N(1 + (N-1)\alpha) - \beta(q-1)(1-\alpha)}{N^2}. \tag{$\lambda_M$}$$

### Step 4: Affinity in $\mu$

Since $V_e(\mu) = 1 + \mu(r-1)$ is affine in $\mu$, and $\lambda_M$ is a positive constant (depending only on parameters $N, \alpha, \beta, q$ but not on $\mu$), the product $\lambda_M V_e(\mu)$ is affine in $\mu$. There is no screening cutoff---no belief $\mu$ at which the coalition structure, offer levels, or proposer behavior changes discretely.

### Step 5: No screening

We now verify formally that the hegemon's private information creates no strategic discontinuity under majority.

**Coalition composition is belief-independent.** In both R1 and R2, when a weak state proposes, it forms a majority coalition from other weak states alone. This coalition choice does not depend on the proposing weak state's belief $\mu$ about $\theta$: the relative cost of $H$ versus $W$ coalition partners is $\beta V_H^{R2}(\theta, M) - \beta V_W^{R2}(\mu, M) > 0$ for all $(\theta, \mu)$, so exclusion of $H$ is optimal regardless of beliefs.

**Offer structure is belief-independent.** When $W_j$ proposes, the offer to coalition partners is $\beta V_W^{R2}(\mu, M)$ per weak state. Although this depends on $\mu$, the dependence is continuous and affine---there is no threshold belief at which the offer structure changes discretely. In particular, there is no "aggressive" vs. "conservative" choice: $W_j$ never needs to secure $H$'s vote, so $W_j$ never faces a screening problem.

**Hegemon's payoff has no jump.** Because coalition composition and offer structure are both continuous in $\mu$, $E_\theta[V_H^{R1}(\theta, \mu, M)] = \lambda_M V_e(\mu)$ is continuous (indeed affine) in $\mu$ on all of $(0,1]$. There is no upward or downward jump at any belief. The screening mechanism that operates under unanimity---where the weak proposer must choose between aggressive and conservative offers to $H$, creating a discrete switch---is entirely absent.

### Step 6: Structural property $\lambda_M > \alpha$

We verify that $\lambda_M > \alpha$, which will be needed in the proof of Proposition 4 case (ii).

\begin{align}
\lambda_M > \alpha &\iff N(1 + (N-1)\alpha) - \beta(q-1)(1-\alpha) > N^2 \alpha \\
&\iff N + N(N-1)\alpha - \beta(q-1)(1-\alpha) > N^2\alpha \\
&\iff N - N\alpha - \beta(q-1)(1-\alpha) > 0 \\
&\iff (1-\alpha)\left[N - \beta(q-1)\right] > 0.
\end{align}

The first factor satisfies $1 - \alpha > 0$ since $\alpha < 1/r < 1$. The second factor satisfies $N - \beta(q-1) > 0$ since $\beta < 1$ and $q - 1 = \lfloor N/2 \rfloor < N$. Hence $\lambda_M > \alpha$. $\square$

### Summary of majority PBE

| Component | Formula |
|:---|:---|
| R2: $H$ proposes | Keeps $V(\theta)$; offers $0$ to $q-1$ weak states |
| R2: $W$ proposes | Excludes $H$; $H$ gets $\alpha V(\theta)$; proposer keeps $(1-\alpha)V(\theta)$ |
| R2: $V_H^{R2}(\theta, M)$ | $V(\theta)[1+(N-1)\alpha]/N$ |
| R2: $V_W^{R2}(\mu, M)$ | $(1-\alpha)V_e(\mu)/N$ |
| R1: $H$ proposes | Buys $q-1$ weak states at $\beta V_W^{R2}$; keeps remainder |
| R1: $W$ proposes | Excludes $H$; $H$ gets $\alpha V(\theta)$ |
| $E_\theta[V_H^{R1}(\theta, \mu, M)]$ | $\lambda_M V_e(\mu)$, affine in $\mu$ |
| $\lambda_M$ | $[N(1+(N-1)\alpha) - \beta(q-1)(1-\alpha)]/N^2$ |
| Structural property | $\lambda_M > \alpha$ (always) |

---

## 2. Proposition 4 Case (ii): Corrected Inference

**Statement (Proposition 4, case (ii)).** *Suppose $\alpha < \alpha^*(N, \beta)$. If $p \in \mathcal{F}_M \setminus \mathcal{F}_U$, then $M \succ U$.*

### Diagnosis of the error in the current proof

The current text (lines 1036--1037) argues:

> "Under majority, the hegemon's payoff from the institution exceeds the outside option: $V_H(M, p) = E_\theta[V_H^{R1}(\theta, p, M)] > \alpha V_e(p)$, since entry is individually rational for weak states (which requires positive surplus above outside options)."

This inference is logically invalid. The fact that entry is individually rational for weak states (i.e., $V_W^{R1}(p, M) \geq c > 0$) implies that weak states earn positive surplus, but it does not directly imply that $H$'s institutional payoff exceeds $\alpha V_e(p)$. The two claims concern different players' payoffs, and the connection between them is not established by the stated argument.

The correct argument is structural: it follows directly from the majority payoff formula derived in Proposition 1.

### Corrected proof of case (ii)

**Case (ii): $p \in \mathcal{F}_M \setminus \mathcal{F}_U$.** The institution forms under majority but not under unanimity. Under unanimity, since $p \notin \mathcal{F}_U$, the institution does not form and the hegemon receives its bilateral outside option:
$$V_H(U, p) = \alpha V_e(p).$$

Under majority, since $p \in \mathcal{F}_M$, the institution forms and the hegemon receives its expected bargaining payoff. By Proposition 1 (equation ($\star$)):
$$V_H(M, p) = \lambda_M V_e(p),$$

where $\lambda_M = [N(1+(N-1)\alpha) - \beta(q-1)(1-\alpha)]/N^2$.

By the structural property established in Proposition 1 (Step 6), $\lambda_M > \alpha$ holds unconditionally on model parameters ($\alpha \in (0, 1/r)$, $\beta \in (0,1)$, $N \geq 3$). Since $V_e(p) > 0$ for all $p \in (0,1]$:
$$V_H(M, p) = \lambda_M V_e(p) > \alpha V_e(p) = V_H(U, p).$$

Hence $M \succ U$. $\square$

### Why the corrected argument works

The key insight is that $\lambda_M > \alpha$ is a structural property of majority-rule bargaining, not a consequence of weak states' entry incentives. It holds because:

1. When $H$ proposes (probability $1/N$), $H$ captures the entire surplus minus the cost of buying a majority coalition. This alone gives $H$ more than $\alpha V(\theta)$ per type, because $H$ keeps $V(\theta) - (q-1)\beta(1-\alpha)V_e(\mu)/N > \alpha V(\theta)$ (the pie exceeds the sum of outside options).

2. When $W$ proposes (probability $(N-1)/N$), $H$ receives exactly $\alpha V(\theta)$---its bilateral alternative.

The proposer advantage in event (1) ensures $\lambda_M > \alpha$ regardless of entry conditions, prior beliefs, or weak states' payoffs. The corrected proof cites this structural property rather than making an indirect (and invalid) inference through weak states' rationality.

---

## Appendix: Verification that $\lambda_M > \alpha$ is tight

For completeness, we verify that $\lambda_M - \alpha$ is bounded away from zero for all admissible parameters.

$$\lambda_M - \alpha = \frac{(1-\alpha)[N - \beta(q-1)]}{N^2}.$$

Since $1 - \alpha > 1 - 1/r > 0$ and $N - \beta(q-1) > N - (N-1) = 1 > 0$:

$$\lambda_M - \alpha > \frac{(1 - 1/r) \cdot 1}{N^2} = \frac{r - 1}{r N^2} > 0.$$

This lower bound decreases with $N$ (as $1/N^2$) and with $r$ approaching $1$, but remains strictly positive for all finite $N$ and $r > 1$. The inequality $\lambda_M > \alpha$ is never marginal.
