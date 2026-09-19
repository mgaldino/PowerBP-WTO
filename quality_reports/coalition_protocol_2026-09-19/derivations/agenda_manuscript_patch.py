#!/usr/bin/env python3
"""Prepare the agenda migration; migrate_agenda(text) has no I/O or side effects.

This is an unapplied patch proposal. The CLI only writes agenda_* previews in
this script's directory, never the manuscript. Mathematical review precedes
application. Baseline and general notation edits belong to the coordinator.
"""
from __future__ import annotations

import argparse
import difflib
import hashlib
from pathlib import Path

ORIGINAL_SHA256 = "6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411"
DERIVATION_SHA256 = "3b98454cb275f34a89c6f5a10037eaa34e30e4fbf81e4fb4f01a65e2f8ba9f6f"


def _once(text: str, old: str, new: str) -> str:
    count = text.count(old)
    if count != 1:
        raise ValueError(f"Expected one occurrence, found {count}: {old[:100]!r}")
    return text.replace(old, new, 1)


def _section(text: str, start: str, end: str, transform) -> str:
    if text.count(start) != 1 or text.count(end) != 1:
        raise ValueError(f"Section boundaries must be unique: {start!r}, {end!r}")
    lo, hi = text.index(start), text.index(end)
    if hi <= lo:
        raise ValueError("Section boundaries are not ordered")
    return text[:lo] + transform(text[lo:hi]) + text[hi:]


def _migrate_body(block: str) -> str:
    block = _once(block, r"""hegemon must propose a feasible division of the unit pie. If that proposal
fails, the game enters Round 1 of the baseline.""", r"""hegemon must propose a feasible coalition contract \(y=(C,x)\), with
\(H\in C\), allocations restricted to its members, and consent required
from every invited weak state. Write \(\mathcal Y_g=\mathcal Y_g^H\) for
its signal space under rule \(g\). Both \(C\) and \(x\) are public before
the simultaneous ballot. If any invited state refuses, the package fails
and the game enters Round 1 of the baseline.""")
    block = _once(block, r"""Under majority, \(k\) is the number of weak votes that \(H\) must buy and
\(e\) is the number of weak states that a minimal winning coalition can leave
outside.""", r"""Under majority, a feasible coalition invites at least \(k\) weak states;
\(e\) is the number left outside a minimal coalition. Under each type's
equilibrium law, approved proposals invite exactly \(k\) weak states almost
surely, as Appendix B.7 shows. Rejected proposals may invite more, and the coalition itself can
convey information about \(H\)'s type.""")
    return block


def _migrate_reversal_note(block: str) -> str:
    return _once(block, r"""\footnotesize\emph{Note:} The table uses one admissible equilibrium assessment
with \(m=4\), \(\beta=.90\), \(\ell=.10\), \(h=.90\), and \(p=.95\). The
higher value \(h=.90\), rather than the running illustration's \(h=.35\),
creates the region \(\beta h>e/m\) in which an informational reversal is
possible. The unanimity value is the lower endpoint of its admissible pooling
interval. The numbers are a theoretical illustration of the decomposition.""", r"""\footnotesize\emph{Note:} The table uses a pair of complete assessments with
\(m=4\), \(\beta=.90\), \(\ell=.10\), \(h=.90\), \(p=.95\), and
\(\mu^{\mathrm{off}}=0\) under both rules. The higher value \(h=.90\),
rather than the running illustration's \(h=.35\), creates the region
\(\beta h>e/m\) in which an informational reversal is possible. Under
majority the low type agrees and the high type delays; under unanimity both
types pool at the lower endpoint of the admissible payoff interval.
Appendix E.2 gives the corresponding proposals. The numbers are a
theoretical illustration of the decomposition.""")


B7_OPENING = r"""Fix the primitives. Let
\[
\mathfrak C_M
=\{\mathsf E,\mathsf S,\mathsf P\}
 \sqcup(\{\mathsf{EP}\}\times[0,1])
\]
be the compact space of admissible majority-continuation states and fix an
anonymous Borel Markov selection
\(\chi:[0,1]\to\mathfrak C_M\). Its literal baseline representative
recognizes a weak proposer uniformly and chooses its weak partners
uniformly: \(k\) partners in exclusion and \(k-1\) in screening or pooling.
After every failed Round-1 proposal, Round 2 uses a minimal coalition of
\(k+1\) weak states, with the proposer recognized uniformly and its
\(k\) partners chosen uniformly. The complete assessment retains its
off-path ballots and beliefs. An exclusion--pooling mixture uses the same
weight for every recognized proposer, payoff coordinate, and outcome law.

For posterior \(\mu\), let \(c_\chi(\mu)\) be a weak state's continuation
payoff and \(h_{\chi,o}(\mu)\) the continuation payoff of type \(o\), both
in native Round-1 units. Transporting the continuation to date \(A\) gives
\[
r_\chi(\mu)=\beta c_\chi(\mu),\qquad
d_{\chi,o}(\mu)=\beta h_{\chi,o}(\mu).
\]
Every baseline branch gives \(0<c_\chi(\mu)\leq1/m\). Hence
\[
0<r_\chi(\mu)\leq\frac{\beta}{m},\qquad kr_\chi(\mu)<1.
\]
At \(y=(C,x)\), each invited weak state votes yes exactly when
\(x_j\geq r_\chi(\mu)\); equality passes. Noninvitees do not vote.
The proposal passes if and only if every invited weak state accepts.
Thus every passing proposal satisfies
\[
C=\{H\}\cup\{j\in W:x_j>0\}.
\]
This recovers the coalition from the allocation only on the passing branch;
zero-payment invitees remain feasible in proposals that are rejected.
At a fixed posterior, the best passing proposal invites exactly \(k\)
weak states, pays each its threshold, and leaves
\[
a_\chi^{\mathrm{pass}}(\mu)=1-kr_\chi(\mu).
\]
Any smaller nonnegative share can be implemented by leaving part of the
budget unallocated. A proposal assigning one to \(H\) and zero to all
invited weak states is rejected in any admissible coalition and attains
\(d_{\chi,o}(\mu)\). Both terms in
\[
\max\{a_\chi^{\mathrm{pass}}(\mu),d_{\chi,o}(\mu)\}
\]
are therefore attainable at every fixed posterior. This comparison holds
the posterior fixed; a change in the public pair \((C,x)\) may itself
change beliefs in the private game.

"""


B7_MIXED = r"""For arbitrary Borel proposal laws
\(\sigma_\ell,\sigma_h\in\mathcal P(\mathcal Y_M)\), set
\[
\bar\sigma=(1-p)\sigma_\ell+p\sigma_h,\qquad
\mathsf S_M=\operatorname{supp}(\bar\sigma).
\]
Let \(\widehat\mu:\mathcal Y_M\to[0,1]\) be the Borel posterior map.
The effective weak-ballot vector takes values in
\(\{\mathsf Y,\mathsf N,\bot\}^m\), where \(\bot\) means not invited;
it is not a no vote. Its passage indicator is
\[
b_M(y)=\prod_{j\in C\setminus\{H\}}
  1\{x_j\geq r_\chi(\widehat\mu(y))\},\qquad y=(C,x).
\]
Define
\[
u_o(y)=b_M(y)x_H+\{1-b_M(y)\}d_{\chi,o}(\widehat\mu(y)),\qquad
V_o=\int_{\mathcal Y_M}u_o(y)\,\sigma_o(dy).
\]
Let \(u_o^{\mathrm{off}}\) evaluate an unsupported pair \((C,x)\) at
\(\mu^{\mathrm{off}}\), and put
\[
\mathfrak O_o(\mathsf S_M)
=\sup_{y\notin\mathsf S_M}u_o^{\mathrm{off}}(y),
\]
with the supremum of the empty set equal to \(-\infty\). In addition to
Bayes, the ballot rule, and the complete continuation selection, the laws
generate a PBE if and only if
\[
\begin{aligned}
u_o(y)&\leq V_o &&\text{for every }y\in\mathsf S_M,\\
u_o(y)&=V_o &&\text{for }\sigma_o\text{-almost every }y,\\
V_o&\geq\mathfrak O_o(\mathsf S_M),&&o\in\{\ell,h\}.
\end{aligned}
\]
Each type can copy the other type's entire coalition contract or choose any
unsupported contract, including one that invites an additional state whose
refusal causes delay. The first and third conditions exclude these
deviations; the second places each type's law on best responses almost
surely. The prescribed ballots and complete baseline assessments supply
sequential rationality after every proposal and rejection.

The local Bayes limit in Appendix E.1 is evaluated within each coalition
component of \(\mathcal Y_M\). It is a pointwise limit of Borel ratios on
the closed support and is constant off it. The acceptance sets are Borel
preimages of \([0,\infty)\) under the maps
\(y\mapsto x_j-r_\chi(\widehat\mu(y))\). Hence the effective ballot,
passage, and payoff maps are Borel. These arguments establish the mixed
membership criterion without identifying signals that share \(x\) but
have different \(C\).

"""


B7_OVERSIZED = r"""Under either type's equilibrium law, approved coalitions contain exactly
\(k\) weak invitees almost surely. To prove this without holding beliefs
fixed, put \(w=\beta/m\). Every selected continuation obeys
\[
\frac{1-w}{m}\leq c_\chi(\mu)\leq\frac1m.
\]
The lower bound is immediate in exclusion. In pooling, selection requires
\(h\leq1/m\), so \(1-\beta h\geq1-w\). In screening, the baseline
proposer's comparison with exclusion gives \(\Pi_S\geq\Pi_E\), and
\[
mc_S(\mu)-(1-w)
=(\Pi_S-\Pi_E)+\mu(\beta-kw)\geq0.
\]
The residual mixture preserves the bound. Thus every invited weak state
in an approved package must receive at least \(w(1-w)\). With at least
\(k+1\) such invitees, feasibility implies
\[
x_H\leq1-(k+1)w(1-w)<1-kw=v_M^{\mathrm{safe}},
\]
because \((k+1)w<1\). The safe proposal is available at any induced belief,
so this is a strict loss relative to a feasible deviation. The set of such
approved contracts has probability zero under either type's equilibrium
law. Rejected coalitions of any admissible size remain in the signal space
and in the deviation conditions. \(\square\)

"""


def _migrate_b7(block: str) -> str:
    lo = block.index("Fix the primitives.")
    hi = block.index("For a pure interior profile,")
    block = block[:lo] + B7_OPENING + block[hi:]
    block = _once(block, r"""For a pure interior profile, the public support contains at most two
proposals. Its complement is dense in the proposal simplex. If the canonical
best passing proposal at \(\mu^{\mathrm{off}}\) is itself on the support,
reduce \(H\)'s share by \(\varepsilon>0\), keep the \(k\) threshold
payments fixed, and choose a sequence \(\varepsilon\downarrow0\) that avoids
the finitely many supported proposals.""", r"""For a pure interior profile, the public support contains at most two pairs
\((C,x)\). Its complement is dense in every coalition component. If a
canonical best passing contract at \(\mu^{\mathrm{off}}\) is supported,
keep its coalition and the \(k\) threshold payments fixed, reduce
\(H\)'s share by \(\varepsilon>0\), and choose a sequence
\(\varepsilon\downarrow0\) that avoids the finitely many supported pairs.""")
    block = _once(block, "copy the other's proposal and receive the same share.",
                  r"copy the other's entire pair \((C,x)\) and receive the same share.")
    block = _once(block, r"""enumeration is exhaustive. Canonical passing proposals and clearly rejected
proposals attain every listed payoff, proving sufficiency as well as
necessity.""", r"""enumeration is exhaustive. Minimal-coalition passing contracts and
clearly rejected contracts attain every listed payoff. When distinct
passing messages are required, they can use different minimal coalitions;
\(k<m\) guarantees that more than one is available. The table therefore
characterizes the existence and payoff of every pure form while retaining
all contracts that implement it.""")
    lo = block.index("For completeness with arbitrary Borel proposal laws")
    hi = block.index(r"At \(p\in\{0,1\}\)", lo)
    block = block[:lo] + B7_MIXED + block[hi:]
    block = _once(block, "set of probability measures supported on its argmax between passage and",
                  r"""set of probability measures on \(\mathcal Y_M\) assigning probability one
to its argmax between passage and""")
    block = _once(block, r"""Moreover, at any posterior \(H\) can pay \(\beta/m\) to any \(k\) weak
states and retain \(v_M^{\mathrm{safe}}\).""", r"""Moreover, at any posterior \(H\) can invite any \(k\) weak states,
pay each \(\beta/m\), and retain \(v_M^{\mathrm{safe}}\).""")
    block = _once(block, r"""which establishes the lower bound used by Proposition
\ref{prop:agenda-majority}. \(\square\)

""", r"""which establishes the lower bound used by Proposition
\ref{prop:agenda-majority}.

""" + B7_OVERSIZED)
    return block


def _migrate_b9(block: str) -> str:
    block = _once(block, r"""the rule-specific realized-outcome space whose coordinates are the named
proposal, realized posterior, passage indicator, continuation state, and
terminal outcome tuple.""", r"""the rule-specific realized-outcome space whose coordinates are the named
coalition contract, realized posterior, passage indicator, continuation
state, and terminal outcome tuple. Under unanimity the constant coalition
\(C=N\) is suppressed through the identification \((N,x)\leftrightarrow x\).""")
    block = _once(block, r"""acts on \(Z_g\) by a homeomorphism \(T_\tau\). Relabeling a PBE by
\(T_\tau\) preserves feasibility and payoffs, transports relative balls and
supports, commutes with the local Bayes limit, and maps ballots, continuation
kernels, and deviations bijectively to payoff-equivalent objects.""", r"""acts on \(Z_g\) by a homeomorphism \(T_\tau\). It sends each
coalition to its relabeled coalition and permutes the corresponding
allocations and effective votes, preserving \(\bot\) as nonparticipation
in that ballot. The uniform continuation kernels are equivariant; the
complete continuation assessments, including their off-path functions,
are relabeled by the same permutation. Relabeling a PBE therefore
preserves feasibility and payoffs, carries relative balls
within one coalition component to relative balls within its image,
commutes with the local Bayes limit, and maps every feasible coalition
contract and deviation to its relabeled counterpart.""")
    block = _once(block, "Payoffs, passage and delay, the posterior law, anonymous terminal outcomes,",
                  "Payoffs, passage and delay, coalition size, the posterior law, anonymous terminal outcomes,")
    return block


E1 = r"""## E.1 Agenda-stage contract {-}

Fix
\[
\begin{gathered}
\mathbf d=(m,k,e,\beta,\ell,h,\mathcal X,p),\\
m\geq3,\quad k=\lfloor(m+1)/2\rfloor,\quad e=m-k,\\
0<\beta<1,\quad 0<\ell<h<1,\quad p\in[0,1].
\end{gathered}
\]
At date \(A\), after observing its type, \(H\) proposes
\(y=(C,x)\in\mathcal Y_g:=\mathcal Y_g^H\). In terms of the allocation
simplex \(\mathcal X\),
\[
\mathcal X_C=\{x\in\mathcal X:x_j=0\text{ for }j\notin C\},\qquad
\mathcal Y_g=
\bigsqcup_{\substack{H\in C\subseteq N\\|C|\geq \nu_g}}
  \bigl(\{C\}\times\mathcal X_C\bigr),
\]
where \(\nu_M=k+1\) and \(\nu_U=m+1\). The coalition and allocation are
public. The proposal counts as \(H\)'s affirmative vote; each invited
weak state then votes simultaneously in a pure strategy. Noninvitees do
not vote. Every invited state must consent for passage, including in a
coalition larger than the quota. Passage automatically implements the
package at date \(A\). Any refusal rejects the entire package and enters
the specified Round-1 continuation, whose native payoff is multiplied by
\(\beta\) exactly once.

Each \(\mathcal X_C\) has its relative Euclidean topology; different
coalitions are distinct components. Thus \(\mathcal Y_g\) is a finite
disjoint union of compact simplexes. Relative balls sufficiently near
\(y=(C,x)\) remain in its coalition component. Under unanimity,
\(C=N\) is forced, so \(\mathcal Y_U\) is identified with
\(\mathcal X\) through \((N,x)\leftrightarrow x\). We use this
identification in the unanimity formulas below.

A rejected public history retains the rule, coalition contract, proposer,
effective vote vector, outcome, and posterior. Its continuation selector
is total on the histories of an admissible assessment, public, Borel, and
common to types compatible with the history. The maintained Markov
restriction makes its choice depend only on the institution, entry stage,
and posterior. It returns a complete anonymous Round-1 assessment,
including strategies, beliefs, recognition lotteries, coalitions, ballots,
payoffs, and outcome laws. The continuation is a full assessment, not a
scalar payoff. Its internal beliefs follow the baseline rule.

For an interior prior, let the Borel proposal laws be
\(\sigma_\ell,\sigma_h\in\mathcal P(\mathcal Y_g)\), put
\(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), and let
\(\mathsf S_g=\operatorname{supp}(\bar\sigma)\). A proposal is
disciplined when it belongs to this support. The posterior at every such
point is the local Bayes limit
\[
\mu(y)=\lim_{\varepsilon\downarrow0}
 \frac{p\,\sigma_h(B_{\mathcal Y_g}(y,\varepsilon))}
      {\bar\sigma(B_{\mathcal Y_g}(y,\varepsilon))}.
\]
This limit must exist at every support point, including points of zero
mass. The balls use the coalition components just specified; proposals
with the same allocation and different coalitions are not identified.
At undisciplined proposals, the common off-path restriction fixes
\[
\mu^{\mathrm{off}}=b_\rho(p)=\frac{p\rho}{1-p+p\rho},
\qquad \rho\in[0,\infty].
\]
The extended-real boundary conventions are
\[
b_0(p)=0,\qquad b_\infty(p)=1
\]
for an interior prior. At prior endpoints, every posterior equals \(p\),
the comparison index is \((*,p)\), and \(\rho\) is irrelevant. Invited
weak voters use the baseline's as-if-pivotal comparison and
indifference-to-yes convention.

The single coordinate \(\rho\) is common to every undisciplined coalition
contract. This restriction applies to signals at the agenda stage. It is
stronger than the ballot-by-ballot free values of Appendix A.2 and does not
replace that discipline inside the selected baseline assessment.

"""


E2_MIXED = r"""For mixed strategies, a complete equilibrium assessment retains
\[
\begin{aligned}
R_M=\bigl(&\rho,\mu^{\mathrm{off}},\sigma_\ell,\sigma_h,\bar\sigma,
\widehat\mu,\widehat\kappa_M,\chi,\\
&\mathbf b_M,b_M,u_\ell,u_h\bigr).
\end{aligned}
\]
Here \(\sigma_\ell,\sigma_h,\bar\sigma\in\mathcal P(\mathcal Y_M)\),
\(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), and
\(\widehat\mu:\mathcal Y_M\to[0,1]\) is the Borel posterior map. The
selector \(\widehat\kappa_M\) returns the complete literal baseline
assessment; \(\chi\) records its continuation state. The effective ballot
map \(\mathbf b_M:\mathcal Y_M\to\{\mathsf Y,\mathsf N,\bot\}^m\)
records yes or no for invitees and \(\bot\) for noninvitees. The scalar
passage indicator is
\[
b_M(y)=\prod_{j\in C\setminus\{H\}}
  1\{x_j\geq r_\chi(\widehat\mu(y))\},\qquad y=(C,x).
\]
The same assessment generates its continuation kernels and realized laws.
Let
\[
\begin{gathered}
\mathsf S_M=\operatorname{supp}(\bar\sigma),\qquad
u_o(y)=b_M(y)x_H+\{1-b_M(y)\}d_{\chi,o}(\widehat\mu(y)),\\
V_o=\int_{\mathcal Y_M}u_o(y)\,\sigma_o(dy),\qquad
\mathfrak O_o(\mathsf S_M)
=\sup_{y\notin\mathsf S_M}u_o^{\mathrm{off}}(y),
\end{gathered}
\]
where \(u_o^{\mathrm{off}}\) evaluates an unsupported contract at
\(\mu^{\mathrm{off}}\), and the supremum of the empty set is
\(-\infty\). In addition to pointwise Bayes updating on the disciplined
support, the invited voters' ballot rule at every contract, and the
complete continuation selection, the necessary-and-sufficient proposal
conditions are
\[
\begin{aligned}
u_o(y)&\leq V_o &&\text{for every }y\in\mathsf S_M,\\
u_o(y)&=V_o &&\text{for }\sigma_o\text{-almost every }y,\\
V_o&\geq\mathfrak O_o(\mathsf S_M),&&o\in\{\ell,h\}.
\end{aligned}
\]
Thus arbitrary Borel mixtures and atomless supports in
\(\mathcal Y_M\) are included. These conditions retain rejected
coalitions of every admissible size and do not impose agreement or a
particular signal on either type.

"""


E2_LAWS = r"""The realized-law layer retains each named coalition. For fixed primitives,
let \(\Omega_D^M\) be the finite discrete set of terminal continuation
records generated by the selected uniform majority kernels. Each record
retains the recognized proposer, target coalition, allocation, effective
votes, and outcome in every realized baseline round. In Round 2 the
representative selects \(k\) weak partners uniformly for the recognized
weak proposer, who keeps the pie. This is one literal continuation;
other optimal nominal memberships remain possible in the baseline.
Belief functions and unused continuation plans remain in
\(\widehat\kappa_M\).

Define the compact Polish spaces
\[
\Omega_T^M
=\bigl(\{\mathsf A\}\times\mathcal Y_M\bigr)
 \sqcup\bigl(\{\mathsf D\}\times\Omega_D^M\bigr),
\qquad
Z_M=\mathcal Y_M\times[0,1]\times\{0,1\}
       \times\mathfrak C_M\times\Omega_T^M.
\]
For \(\xi\in\mathfrak C_M\), let
\(K^D_{o,\xi}\in\mathcal P(\Omega_D^M)\) be the selected literal
continuation kernel and let \(\widetilde K^D_{o,\xi}\) be its pushforward
to \(\{\mathsf D\}\times\Omega_D^M\). The finite uniform lotteries
and the common exclusion--pooling mixture make this kernel Borel in its
state. Conditional on \(y=(C,x)\), set
\[
L_o^{R_M}(d\omega_T\mid y)
=b_M(y)\delta_{(\mathsf A,y)}(d\omega_T)
 +\{1-b_M(y)\}
  \widetilde K^D_{o,\chi(\widehat\mu(y))}(d\omega_T).
\]
For a Borel set \(B\subseteq Z_M\), the type-specific joint law is
\[
\Gamma_o^{M,R_M}(B)
=\int_{\mathcal Y_M}\int_{\Omega_T^M}
  1_B\!\left(y,\widehat\mu(y),b_M(y),\chi(\widehat\mu(y)),\omega_T\right)
  L_o^{R_M}(d\omega_T\mid y)\,\sigma_o(dy).
\]
Thus \(\Gamma_o^{M,R_M}\in\mathcal P(Z_M)\).
This law jointly determines the named coalition contract, posterior,
passage, literal continuation selection, and terminal outcome. Contracts
that share \(x\) but differ in \(C\) remain distinct records.

"""


E2_WITNESS = r"""For the comparison in Table \ref{tab:agendareversal}, take
\(\mu^{\mathrm{off}}=0\) under both rules. Under majority the low type
proposes \(C=\{H,1,2\}\) with
\(x=(.5905,.20475,.20475,0,0)\); the high type uses that coalition with
\(x=(1,0,0,0,0)\), which is rejected. The two posteriors are zero and
one, and the type payoffs are \((.5905,.81)\). Under unanimity both types
propose \(C=N\) and
\(x=(.729,.06775,.06775,.06775,.06775)\), yielding the pooling payoff
\((.729,.729)\). The majority conditions in the table and the unanimity
interval in Appendix E.3 verify this pair at the stated common off-path
specification.

"""


def _migrate_e2(block: str) -> str:
    block = _once(block, r"""These forms preserve proposals and messages even when their payoffs
coincide.""", r"""These forms preserve public coalition contracts \(y=(C,x)\) even when
their payoffs coincide.""")
    lo = block.index("For mixed strategies, a complete equilibrium assessment is")
    hi = block.index(r"At \(p\in\{0,1\}\)", lo)
    block = block[:lo] + E2_WITNESS + E2_MIXED + block[hi:]
    block = _once(block, "each type's Borel proposal law may be any probability measure supported on\nits argmax.",
                  r"""each type's Borel proposal law on \(\mathcal Y_M\) may be any
probability measure assigning probability one to its argmax.""")
    lo = block.index("The realized-law layer is constructed as follows.")
    hi = block.index(r"Let \(G=S_m\) act", lo)
    block = block[:lo] + E2_LAWS + block[hi:]
    block = _once(block, r"""Let \(G=S_m\) act on \(Z_M\) by applying the same permutation to all named
weak-state coordinates while fixing the posterior, passage indicator, and
continuation label.""", r"""Let \(G=S_m\) act on \(Z_M\) by applying the same permutation to every
weak-state name in the target coalitions, allocations, recognitions, and
effective ballots, while fixing \(H\), the posterior, passage indicator,
and continuation label.""")
    return block


def _migrate_notation(block: str) -> str:
    block = _once(block, r"""\(\rho\) & Off-path likelihood-ratio coordinate in the agenda extension \\
""", r"""\(\rho\) & Off-path likelihood-ratio coordinate in the agenda extension \\
\(\mathcal Y_g=\mathcal Y_g^H\) & Agenda signal space of public coalition
contracts; under unanimity, \((N,x)\) is identified with \(x\) \\
\(\mathbf b_M(y)\), \(b_M(y)\) & Effective weak-ballot vector and passage
indicator; \(\bot\) marks a noninvited state, not a no vote \\
\(\widehat\kappa_M\), \(\chi\) & Complete baseline continuation selector
and its majority continuation-state label \\
""")
    block = _once(block, r"""\(\widehat\mu(\cdot)\) & Borel posterior map in mixed majority assessments \\
""", r"""\(\widehat\mu(\cdot)\) & Borel posterior map on \(\mathcal Y_M\) in
mixed majority assessments \\
""")
    block = _once(block, r"""\(\Gamma_o^{g,R_g}\) & Type-specific joint realized law induced by assessment
\(R_g\) \\
""", r"""\(\Gamma_o^{g,R_g}\) & Type-specific joint law of the coalition contract,
posterior, passage, continuation state, and terminal outcome induced by \(R_g\) \\
""")
    return block


def migrate_agenda(text: str) -> str:
    """Return only the agenda migration, without reading or writing any file.

    Inputs can already contain coordinated baseline edits. Every touched
    passage is anchored inside an agenda-specific section. Reapplication is
    deliberately rejected rather than silently duplicating definitions.
    """
    if not isinstance(text, str):
        raise TypeError("text must be str")
    text = _section(text, "# Agenda power and its informational shadow {#agendaextension}",
                    "## Public agenda power", _migrate_body)
    text = _section(text, r"\caption{A worked informational reversal for the low type}",
                    "## Private agenda power and institutional comparison", _migrate_reversal_note)
    text = _section(text, "## B.7 Proof of the private-majority agenda correspondence {-}",
                    "## B.8 Proof of the private-unanimity agenda correspondence {-}", _migrate_b7)
    text = _once(text, "## B.8 Proof of the private-unanimity agenda correspondence {-}\n\n",
                 "## B.8 Proof of the private-unanimity agenda correspondence {-}\n\n" +
                 r"""Unanimity forces \(C=N\) in the agenda stage and both baseline rounds.
The identification \((N,x)\leftrightarrow x\) preserves the entire
extensive form, including deviations, ballots, transitions, and payoffs.
We therefore state the unanimity correspondence in allocation notation.

""")
    text = _section(text, "## B.9 Proof of the exact and economic representations {-}",
                    "# Appendix C:", _migrate_b9)
    text = _section(text, "# Appendix D:", "# Appendix E:", _migrate_notation)
    text = _section(text, "## E.1 Agenda-stage contract {-}",
                    "## E.2 Complete private-majority correspondence {-}", lambda _: E1)
    text = _section(text, "## E.2 Complete private-majority correspondence {-}",
                    "## E.3 Complete private-unanimity correspondence {-}", _migrate_e2)
    text = _once(text, "## E.3 Complete private-unanimity correspondence {-}\n\n",
                 "## E.3 Complete private-unanimity correspondence {-}\n\n" +
                 r"""Here \(\mathcal Y_U=\{N\}\times\mathcal X\) is identified with
\(\mathcal X\). Every proposal and continuation record below carries the
constant coalition \(C=N\); suppressing that label preserves beliefs,
strategies, and realized laws.

""")
    return text


def _main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="Original manuscript to read, never modified")
    args = parser.parse_args()
    original_bytes = args.source.read_bytes()
    source_hash = hashlib.sha256(original_bytes).hexdigest()
    if source_hash != ORIGINAL_SHA256:
        raise SystemExit(f"Preview requires original source hash {ORIGINAL_SHA256}; got {source_hash}")
    original = original_bytes.decode("utf-8")
    migrated = migrate_agenda(original)
    directory = Path(__file__).resolve().parent
    preview = directory / "agenda_manuscript_preview.Rmd"
    diff = directory / "agenda_manuscript_preview.diff"
    if preview.resolve() == args.source.resolve() or diff.resolve() == args.source.resolve():
        raise SystemExit("Refusing to overwrite the input")
    preview.write_text(migrated, encoding="utf-8")
    diff.write_text("".join(difflib.unified_diff(original.splitlines(keepends=True),
                                              migrated.splitlines(keepends=True),
                                              fromfile="formal_model_v6.Rmd (original)",
                                              tofile=preview.name)), encoding="utf-8")
    print(f"Pure migration preview: {preview}")
    print(f"Review diff: {diff}")
    print(f"Source unchanged SHA-256: {source_hash}")
    print(f"Preview SHA-256: {hashlib.sha256(migrated.encode('utf-8')).hexdigest()}")


if __name__ == "__main__":
    _main()
