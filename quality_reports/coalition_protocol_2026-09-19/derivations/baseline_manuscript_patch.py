"""Proposed manuscript replacements. Does not write the canonical manuscript.

Apply only after independent mathematical review of the coalition interfaces.
The input is the preserved pre-migration source, or that source with the
disjoint agenda patch applied. Review the resulting full source separately.
"""


def section(text, start, end, replacement):
    assert text.count(start) == 1, start
    assert text.count(end) == 1, end
    a, b = text.index(start), text.index(end)
    assert a < b
    return text[:a] + replacement.rstrip() + "\n\n" + text[b:]


def once(text, old, new):
    assert text.count(old) == 1, old
    return text.replace(old, new, 1)


def migrate_baseline(text):
    text = section(text, "## Players, information, and proposals", "## Solution concept", r"""
## Players, information, and proposals

There is one hegemon, \(H\), and \(m\geq3\) weak states,
\(W=\{1,\ldots,m\}\), with \(N=\{H\}\cup W\). Nature selects
\(H\)'s terminal disagreement payoff \(o\in\{\ell,h\}\), observed only by
\(H\), with \(\Pr(o=h)=p\in[0,1]\). The two possible values satisfy
\[
0<\ell<h<1.
\]

The game has two rounds. In each round, one weak state is recognized
uniformly to propose; \(H\) is never a proposer. The two recognition draws are
independent and made with replacement. Every weak state remains eligible in
Round 2, including the Round-1 proposer. Define the institutional quotas by
\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor,\qquad
\nu_M=k+1,\qquad \nu_U=m+1.
\]
A proposal by weak state \(i\) names a coalition \(C\) and an allocation \(x\).
The coalition must contain the proposer and at least \(\nu_g\) states under
rule \(g\in\{M,U\}\). Its members are the proposed parties to the agreement.
We use an explicit target-coalition protocol [@evdokimov2023equality] and
restrict allocations to the members of the proposed coalition. Write
\[
\begin{aligned}
\mathcal X&=\left\{x\in\mathbb R_+^{m+1}:\sum_{j\in N}x_j\leq1\right\},\\
\mathcal X_C&=\{x\in\mathcal X:x_j=0\text{ for }j\notin C\},\\
\mathcal Y_g^i&=\bigsqcup_{\substack{i\in C\subseteq N\\|C|\geq \nu_g}}
                 (\{C\}\times\mathcal X_C).
\end{aligned}
\]
Thus a feasible proposal is \(y=(C,x)\in\mathcal Y_g^i\). Payments cannot
be negative and side payments outside the package are unavailable. Here
\(x_H\) is the institutional concession assigned to \(H\), and \(x_j\) is
weak state \(j\)'s share, including the proposer when \(j=i\).
Coalitions larger than the quota and members assigned zero remain feasible.
The unit pie is fixed independently of coalition membership and is exhausted
by equilibrium baseline proposals. Agreement provides \(H\) no intrinsic
benefit beyond \(x_H\), isolating informational concessions and pivotality
from any direct value of agreement.

## Ballots, timing, and payoffs

The proposer is counted as voting yes. The other members of \(C\) vote
simultaneously; states outside \(C\) do not vote on that package. The coalition
and allocation are public before voting, while the invited vote vector and
outcome become public only after all votes have been cast. The proposal passes
if and only if every member of \(C\) consents. A refusal rejects the entire
package even when \(C\) is larger than the quota. The quota therefore governs
which coalitions may be proposed. Majority permits a coalition without \(H\);
unanimity requires \(C=N\). Both rules use the same consent protocol.

An approved package is implemented automatically. Each weak state receives
its proposed allocation, which is zero outside \(C\). If \(H\in C\), it
receives \(x_H\). If \(H\notin C\), it receives its disagreement payoff
\(o\), the value of its alternative forum, while the weak coalition implements
its own agreement. This outside option is external to the pie and independent
of the weak states' agreement. Because feasibility then requires \(x_H=0\),
no positive allocation to \(H\) accompanies that outside payoff. If \(H\)
is invited and refuses, the package fails; there is no approved allocation
to cancel or redistribute. No individual execution decision follows approval.

If nothing passes in Round 1, no payoff is realized then and the game proceeds
to Round 2. Round-2 payoffs are multiplied by
\(\beta\in(0,1)\) when evaluated in Round-1 units. If nothing passes in Round
2, each weak state receives zero and \(H\) receives \(o\) in Round-2
units. A no vote does not remove a player or trigger the outside payoff by
itself. The delayed terminal disagreement payoff represents the cost of
prolonging international negotiations.

\begin{table}[H]
\centering
\caption{Transitions and payoffs in the bargaining game}
\label{tab:protocol}
\begin{tabular}{p{0.36\linewidth}p{0.27\linewidth}p{0.25\linewidth}}
\toprule
Event & Weak-state payoffs & Hegemon's payoff \\
\midrule
All members of \(C\) consent; \(H\in C\) & Proposed \(x_j\); zero outside \(C\) & \(x_H\) \\
All members of \(C\) consent; \(H\notin C\) & Proposed \(x_j\); zero outside \(C\) & \(o\), with \(x_H=0\) by feasibility \\
An invited member refuses in Round 1 & No current payoff; proceed to Round 2 &
No current payoff; continuation \(\beta C_H(\mathfrak h)\) \\
An invited member refuses in Round 2 & Zero & \(o\) \\
\bottomrule
\end{tabular}
\end{table}

Here \(\mathfrak h\) includes the proposed coalition, allocation, and invited
votes, and \(C_H(\mathfrak h)\) is \(H\)'s Round-2 continuation value. If
\(H\) is invited, its public vote can change beliefs and hence continuation
values. If it is outside \(C\), it takes no ballot action and the weak
states' votes convey no information about its type.

\begin{figure}[H]
\centering
\begin{tikzpicture}[
  node distance=18mm and 9mm,
  box/.style={draw, rounded corners, align=center, inner sep=5pt,
              text width=35mm, minimum height=13mm, font=\small},
  arr/.style={-{Latex[length=2mm]}, thick}
]
\node[box] (p1) {Round 1: weak proposer\\chooses coalition\\and allocation};
\node[box, right=of p1] (b1) {Invited members\\vote simultaneously};
\node[box, right=of b1] (a1) {All consent:\\package implemented};
\node[box, below=of p1] (p2) {Round 2: weak proposer\\chooses coalition\\and allocation};
\node[box, right=of p2] (b2) {Invited members\\vote simultaneously};
\node[box, above right=0mm and 9mm of b2] (a2) {All consent:\\package implemented};
\node[box, below right=5mm and 9mm of b2] (d2) {Any refusal:\\terminal disagreement};
\draw[arr] (p1) -- (b1);
\draw[arr] (b1) -- (a1);
\coordinate (turn1) at ($(p1.south)+(0,-8mm)$);
\coordinate (bend1) at (b1.south |- turn1);
\draw[arr] (b1.south) -- (bend1) -- (turn1) -- (p2.north);
\node[above,font=\small] at ($(turn1)!0.5!(bend1)$) {Any refusal};
\draw[arr] (p2) -- (b2);
\draw[arr] (b2) -- (a2);
\draw[arr] (b2) -- (d2);
\end{tikzpicture}
\caption{Sequence of proposals and consent. Each proposed coalition must
meet the institutional quota, and all its invited members must consent.
Votes become public after each simultaneous ballot. A failed first-round
proposal continues to the terminal round.}
\label{fig:timing}
\end{figure}
""".lstrip())
    text = once(text, "Voting & Simultaneous public ballots; majority or unanimity",
                "Voting & Simultaneous consent of invited members; majority or unanimity quota for the coalition")
    text = section(text, "## A.1 Complete transition and payoff rules {-}",
                   "# Appendix B: Proofs {-}", r"""
## A.1 Complete transition and payoff rules {-}

A feasible proposal is \(y=(C,x)\in\mathcal Y_g^i\). The proposer counts as
yes; each invited responder chooses \(Y\) or \(N\) simultaneously. A state
outside \(C\) takes no action, denoted by \(\bot\) when storing a full vector
of participation and votes. This symbol is not a no vote. Passage requires
yes from every invited responder. Upon passage each weak state receives
\(x_j\); \(H\) receives \(x_H\) if included and \(o\) if excluded. Upon
failure in Round 1 the complete public history leads to Round 2, with
continuation payoffs multiplied by \(\beta\). Failure in Round 2 pays zero
to weak states and \(o\) to \(H\).

These rules cover every feasible proposal and vote deviation. If \(H\in C\)
and votes no, the entire proposal fails, including when \(C\) is oversized.
If \(H\notin C\) and the proposal passes, \(x_H=0\) by feasibility. If
\(H\in C\) and it passes, \(H\) consented and receives its share. Hence no
history pays \(H\) both a positive allocation from an implemented package
and its outside option. The conclusion follows from the specified contract
and allocation restrictions, without requiring optimal proposals or cancelling
an allocation after passage.

## A.2 Beliefs and ballot restrictions {-}

Uninformed weak-state proposals, including their choice of \(C\), and weak
votes preserve the current belief. When \(H\notin C\), the entire ballot
therefore preserves that belief. When \(H\in C\), structural consistency is
the following restriction. Fix a profile. At each ballot, the entering belief
is the current posterior, and \(H\)'s prescribed law is the type-contingent
vote distribution the profile assigns at that ballot. The posterior after any
invited vote vector depends on the entering belief, the prescribed law, and
\(H\)'s realized vote; it is invariant across vectors of that ballot that
differ only in weak votes. If the realized H vote has positive probability
under that law and entering belief, Bayes' rule applies, including after
earlier weak deviations. If the denominator is zero, a single free value is
attached to that ballot-and-H-vote pair within the support of the prior:
any value in \([0,1]\) for an interior prior, and the degenerate posterior at
\(p=0\) or \(p=1\). Distinct ballots, including different proposed coalitions,
may carry distinct free values. This declared restriction is not the
consistency notion of sequential equilibrium [@kreps1982sequential], and is
narrower than the never-dissuaded discipline of @osborneRubinstein1990.

An invited weak responder compares its allocation with the continuation that
would follow if its vote switched passage into failure. It votes yes at
equality. The hegemon maximizes its type-contingent continuation payoff and
votes yes at exact indifference. These restrictions apply after every feasible
proposal, including proposals outside the equilibrium path.
""".lstrip())
    text = section(text, "## B.1 Proof of Proposition \\ref{prop:public} {-}",
                   "## B.2 Proof of Proposition \\ref{prop:terminal} {-}", r"""
## B.1 Proof of Proposition \ref{prop:public} {-}

In terminal majority, every invited weak responder accepts any nonnegative
allocation, including zero under the indifference-to-yes convention. Since
\(\nu_M=k+1\leq m\), the weak proposer can name a winning coalition entirely
within \(W\), allocate the whole pie to itself, and obtain every invited
vote. This yields one, the largest feasible payoff. Inviting \(H\) with a
zero allocation causes rejection because \(o>0\); obtaining its consent
requires \(x_H\geq o\) and lowers the proposer's residual. Positive payments
to other weak states, slack, or positive failure probability also prevent a
payoff of one. Thus all optimal proposals allocate the pie to the proposer
and exclude \(H\), which receives \(o\). The economic outcome is unique,
although any winning all-weak coalition containing the proposer is optimal.

Under terminal unanimity, \(C=N\). Every weak responder accepts zero and
\(H\) accepts exactly when \(x_H\geq o\), so the proposer sets \(x_H=o\).

Move to Round 1. Terminal majority gives each weak state \(1/m\) before
recognition and gives \(H\) its outside payoff \(o\). Hence their
discounted continuation prices are \(w=\beta/m\) and \(\beta o\).
Any passing coalition larger than the quota can drop a weak responder and
transfer its positive continuation payment to the proposer, preserving all
remaining votes. Minimal inclusion costs \((k-1)w+\beta o\); minimal
exclusion costs \(kw\). Exclusion also beats deliberate delay because
\(1-kw-w=1-\beta(k+1)/m>0\). Inclusion is selected exactly when
\(o\leq1/m\); at equality it gives \(H\) the lower payoff \(\beta o<o\).

Under unanimity, each weak responder's terminal value is \((1-o)/m\).
Paying \(H\) exactly \(\beta o\) and each weak responder
\(\beta(1-o)/m\) implements agreement and leaves the proposer its own
discounted continuation plus \(1-\beta>0\). All votes are required, so
lowering any responder's payment causes failure. This gives the stated
public payoffs. \(\square\)
""".lstrip())
    text = section(text, "## B.3 Proof of Proposition \\ref{prop:majority} {-}",
                   "## B.4 Proof of Proposition \\ref{prop:unanimity} {-}", r"""
## B.3 Proof of Proposition \ref{prop:majority} {-}

At any feasible \((C,x)\), each invited weak responder votes yes exactly
when \(x_j\geq w=\beta/m\). This threshold is independent of the posterior
and H's vote because terminal majority gives each weak state \(1/m\).
If \(H\in C\) and all invited weak responders accept, a type with
disagreement payoff \(o\) accepts exactly when \(x_H\geq\beta o\).
If some invited weak responder refuses, both H votes lead to the same
terminal-majority value, so the indifference-to-yes convention selects yes.
An excluded H has no ballot action. These rules complete every proposal,
including oversized coalitions and proposals that cannot pass.

A certainly rejected proposal gives the proposer only \(w\). The feasible
exclusion proposal recruits \(k\) weak responders at \(w\), gives the
proposer \(\Pi_E=1-kw\), and satisfies
\[
\Pi_E-w=1-\frac{\beta(k+1)}m>0.
\]
Thus every optimal proposal passes with positive probability. Every invited
weak responder must then receive at least \(w>0\). If \(|C|>k+1\), remove
a weak responder and transfer its allocation to the proposer, retaining H if
present. The alternative still meets the quota, preserves remaining votes
and the set of H types accepting, and leaves the failure continuation
unchanged. Its expected gain is the removed payment times the positive
passage probability. Hence an optimal coalition is minimal.

Reduce the remaining weak payments to \(w\) and give any slack to the
proposer. If H is included, reduce its offer to the lowest threshold for the
desired nonempty acceptance set: \(\beta\ell\) for screening or
\(\beta h\) for pooling. An acceptance set with zero current probability
gives only delay and is already dominated. This leaves precisely exclusion,
screening and pooling, with proposer payoffs \(\Pi_E,\Pi_S(p),\Pi_P\).
A candidate that can beat exclusion is feasible: pooling must leave a
positive residual, and screening must leave a residual above \(w\) whenever
its accepting type has positive probability.

The decisive differences are
\[
\Pi_P-\Pi_E=\beta(1/m-h)
\]
and
\[
\Pi_S(p)-\Pi_E=(1-p)\beta(1/m-\ell)
            -p(1-\beta(k+1)/m).
\]
Where pooling can beat exclusion, comparing screening with pooling yields
\(p_{S=P}\); comparing screening with exclusion yields \(p_{S=E}\).
Substituting the signs of \(\ell-1/m\) and \(h-1/m\) gives the five cases
in Proposition \ref{prop:majority}.

At screening ties, its expected payoff to H is strictly smaller than that
of the tied alternative, so the proposal tie-break selects screening. When
\(h=1/m\), exclusion and pooling tie for the proposer. Their H payoffs
determine the stated secondary selection; equality leaves lotteries over
the two proposals. The common lottery weight links all payoffs and outcomes.
Permuting equally paid weak partners preserves every comparison. All selected
proposals exhaust the pie. \(\square\)
""".lstrip())
    text = once(text, "For completeness, write \\(x_{\\min}=\\min_j x_j\\) after an arbitrary proposal",
                "For completeness, write \\(x_{\\min}=\\min_{j\\in W\\setminus\\{i\\}}x_j\\) after an arbitrary proposal")
    text = once(text, "The baseline fixes the voting rule, keeps the institutional pie at one, gives",
                "The baseline fixes the coalition quota, keeps the institutional pie at one, gives")
    text = once(text, "agreement benefits. The restriction \\(m\\geq3\\) excludes the three-player",
                "agreement benefits. Coalitions name their participants; every invited member must consent,\nand allocations to outsiders are infeasible. This specifies a club agreement\nwithout benefits or obligations for excluded states. The restriction \\(m\\geq3\\) excludes the three-player")
    text = once(text, "Under majority, the unique equilibrium outcome assigns", 
                "Under majority, the unique equilibrium allocation assigns")
    text = once(text, r"\(k=\lfloor(m+1)/2\rfloor\) & Additional yes votes a proposer needs under majority \\",
                r"\(k=\lfloor(m+1)/2\rfloor\) & Additional yes votes a proposer needs under majority \\" + "\n" +
                r"\(\nu_M=k+1\), \(\nu_U=m+1\) & Minimum coalition size under each rule \\")
    text = once(text, "Additional yes votes a proposer needs under majority",
                "Additional members in a minimal majority coalition")
    text = once(text, r"\(x=(x_H,x_1,\ldots,x_m)\) & Feasible allocation vector \\",
                r"\(C\), \(y=(C,x)\) & Proposed coalition and its allocation package \\" + "\n" +
                r"\(\mathcal X_C\), \(\mathcal Y_g^i\) & Allocations restricted to \(C\), and feasible proposals by \(i\) under rule \(g\) \\" + "\n" +
                r"\(x=(x_H,x_1,\ldots,x_m)\) & Proposed nonnegative allocation vector \\")
    return text
