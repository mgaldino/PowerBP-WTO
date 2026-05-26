# Package B — Detailed Proof for Future Lean Formalization

**Date**: 2026-04-19
**Purpose**: Reference for Lean 4 formalization. Not for the paper itself.
**Source**: Agent-generated proof, verified for consistency with paper's discounting convention.

---

## Proposition

Under Package B (unanimity with exclusive hegemonic proposal control), the weak-state continuation value is

$$V_W(B,\mu) = \beta \frac{V_e(\mu)}{N}.$$

Hence Package B generates no weak-proposer screening problem and no jump in the hegemon's continuation value. The weak-state entry threshold solves

$$\mu + \beta \frac{V_e(\mu)}{N} \ge c.$$

For $N=3$,

$$\tau(B) = \frac{3c - \beta}{3 + \beta(r-1)}.$$

For the baseline parameterization ($N=3$, $r=1.5$, $\beta=0.7$),

$$V_W(C,\mu) > V_W(B,\mu) \quad \text{for all } \mu \in [0,1],$$

so $\tau(C) < \tau(B)$.

## Proof

Because Package B gives proposal control to $H$ in both rounds, weak states never propose. This removes the screening problem that arises under Package C.

**Round 2 (terminal).** If a weak state rejects, bargaining ends and that weak state receives the contemporaneous disagreement payoff $V(\theta)/N$. Therefore, type $\theta$ can secure acceptance by offering each weak state exactly $V(\theta)/N$. It follows that

$$V_W^{R2}(B,\theta) = \frac{V(\theta)}{N}, \qquad V_W^{R2}(B,\mu) = \frac{V_e(\mu)}{N}.$$

**Round 1.** Rejection leads to Round 2 with beliefs unchanged. So each weak state's reservation value is

$$\beta \frac{V_e(\mu)}{N}.$$

Under Assumption (P), this pooling offer is feasible for both hegemon types. Hence

$$V_W(B,\mu) = \beta \frac{V_e(\mu)}{N}.$$

Since $H$ is always the proposer, continuation values under Package B are affine in posterior beliefs. In particular, there is no branch-switching object analogous to the aggressive-versus-conservative choice under Package C, and therefore no jump in the hegemon's continuation payoff.

**Entry threshold for $N=3$.** The entry condition becomes

$$\mu + \beta \frac{1 + \mu(r-1)}{3} \ge c,$$

which rearranges to

$$\tau(B) = \frac{3c - \beta}{3 + \beta(r-1)}.$$

**Dominance by Package C (baseline parameterization).** For $r=1.5$ and $\beta=0.7$, direct substitution into the $N=3$ formulas gives:

*Aggressive branch* ($\mu \le \mu_s$):

$$V_W(C,\mu) - V_W(B,\mu) = \frac{(1-\mu)\big[9(1-\beta) - \beta\mu(r-1)\big]}{27} > 0$$

*Conservative branch* ($\mu \ge \mu_s$):

$$V_W(C,\mu) - V_W(B,\mu) = \frac{9(1-\beta)V_e(\mu) + \beta(r-1)(\mu^2 + 4\mu - 5)}{27} > 0$$

Hence $V_W(C,\mu) > V_W(B,\mu)$ for all $\mu \in [0,1]$, which implies $\tau(C) < \tau(B)$.

## Notes for Lean formalization

- The dominance claim is parameter-dependent. For general parameters, the aggressive-branch difference requires $9(1-\beta) > \beta\mu(r-1)$, which may fail for $\beta$ close to 1 and large $r$ within Assumption P.
- The entry threshold $\tau(B)$ has a clean closed form suitable for Lean.
- Key objects to formalize: $V_W^{R2}(B)$, $V_W(B)$, $\tau(B)$, and the branch-by-branch comparison.
