# Motivating Example reescrito: Informational Power and Institutional Design

**Arquivo original**: formal_model_v4.Rmd, Section 2
**Data**: 2026-04-26

---

# A Motivating Example {#example}

Throughout the paper, I model consensus as unanimity over a binary accept/reject decision. This abstracts from agenda-setting conventions and silence procedures, but captures the central strategic feature: any member can block agreement.

Before turning to the general model, consider a three-player, one-round version of the game. There is one hegemon $H$ and two weak states $W_1, W_2$. Cooperation is worth $V(0) = 1$ in the low state and $V(1) = 2$ in the high state. The hegemon observes the state $\theta$; the weak states do not. Each weak state's outside option is $0$; the hegemon's is $\alpha V(\theta)$ with $\alpha = 0.2$. A proposer is selected uniformly at random. To isolate the screening mechanism, I focus on the branch where a weak state proposes and makes a take-it-or-leave-it offer specifying the hegemon's share $y_H$. If the hegemon rejects, each player receives their disagreement payoff. The general model (Section \@ref(model)) extends this setting to $N$ players, two rounds of Baron-Ferejohn bargaining, and entry costs.

Under majority rule, $W_1$ and $W_2$ can pass a proposal without the hegemon's vote. The proposing weak state excludes $H$ from the coalition, and the hegemon captures $0.2 V(\theta)$ from its bilateral alternative regardless of what weak states believe. The hegemon's expected payoff is $0.2 + 0.2\mu$, where $\mu = \Pr(\theta = 1)$. The payoff is linear in beliefs, with no strategic discontinuity. Because the hegemon's vote is never needed, its private information creates no leverage.

Under unanimity, the hegemon's vote is required, and the proposing weak state faces a dilemma. It must decide how much to offer without knowing $\theta$:

- An aggressive offer ($y_H = 0.2$) pays the hegemon its low-state outside option. Type $\theta = 0$ is indifferent and accepts; type $\theta = 1$ rejects, since it wants $0.4$. The weak proposer gets $0.8$ if $\theta = 0$ and $0$ if $\theta = 1$.
- A conservative offer ($y_H = 0.4$) pays the hegemon its high-state outside option. Both types accept. The weak proposer gets $0.6$ if $\theta = 0$ and $1.6$ if $\theta = 1$.

The weak state prefers the aggressive offer when $0.8(1-\mu) > 0.6(1-\mu) + 1.6\mu$, which simplifies to $\mu < 1/9$. This defines a screening cutoff: the belief at which the weak proposer switches from aggressive to conservative treatment of the hegemon.

The switch in behavior creates a discrete jump in the hegemon's expected payoff. Below the cutoff, the hegemon earns $0.2 + 0.2\mu$, the same as under majority. Above it, the expected payoff jumps to $0.4$, constant and independent of $\mu$. The source of the jump is overpayment: on the conservative branch, type $\theta = 0$ receives $0.4$ but would accept $0.2$. Weak states cannot avoid this cost because they must secure the hegemon's vote without knowing the type. At the cutoff $\mu^* = 1/9$, the jump is $8/45 \approx 0.18$, about 16\% of expected surplus.

The jump creates a non-convexity in the hegemon's payoff that Bayesian persuasion can exploit. Suppose the prior is $p < 1/9$. Without persuasion, the hegemon's payoff under both rules is $0.2 + 0.2p$. Under unanimity, the hegemon can design a public signal that pushes the weak states' posterior to $1/9$ with probability $9p$ (inducing conservative behavior and payoff $0.4$) and to $0$ with probability $1 - 9p$ (payoff $0.2$). The resulting expected payoff is $0.2 + 1.8p$, which strictly exceeds the majority payoff of $0.2 + 0.2p$ for every $p > 0$. Under majority, the payoff is already linear, so concavification adds nothing. Unanimity creates a non-convexity that makes the hegemon's private information strategically productive; majority does not.

The general model enriches this logic in several respects. With $N$ players and two-round Baron-Ferejohn bargaining with discounting ($\beta < 1$), the richer environment produces two screening cutoffs (one per round) and an entry threshold that creates a second channel through which the voting rule matters. Theorem \ref{thm:dominance} shows that the pattern identified here generalizes: unanimity dominates whenever the institution is viable. Theorem \ref{thm:crossing} establishes that there exists a prior threshold $p^*$ such that the hegemon strictly prefers unanimity for all $p > p^*$; below it, majority can dominate, but only because it makes entry easier.
