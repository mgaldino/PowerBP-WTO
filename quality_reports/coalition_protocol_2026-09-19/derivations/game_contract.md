# Coalition protocol: extensive form and dependency contract

Author decision: `../author_decision.md`, 19 September 2026. Implementer: `/root`.
This is the adopted candidate, not an assertion that the former quota ballot is
the same game. Mathematical closure below is distinct from independent review.

## Primitives, histories, and information sets

There are players N={H}∪W, |W|=m≥3. Nature chooses o∈{ℓ,h},
0<ℓ<h<1, with probability p of h. Only H observes o. The common discount
factor is 0<β<1. Every baseline round begins with independent uniform
recognition of one weak state i. The two institutions share the same protocol:
q_M=k+1, k=floor((m+1)/2), and q_U=m+1. The proposer selects y=(C,x), where
i∈C⊆N, |C|≥q, x∈R_+^{m+1}, sum x≤1, and x_j=0 for j∉C. All invitees
other than i vote simultaneously, with i counted yes. Noninvitees do not vote.
The proposal and coalition are public before voting; the entire invited vote
vector is public only after the ballot. H's type is never directly observed.

| History | Mover and observed information | Action / transition |
|---|---|---|
| Before R1/R2 recognition | Nature; all observe round and full public past | i uniform in W |
| Proposal in round t | i observes the public past, own recognition, current belief; not o | choose feasible (C,x) |
| Ballot in round t | invitees observe (C,x) and public past; H additionally knows o | simultaneous Y/N; pass iff every invitee consents |
| Pass | no further decision | implement x automatically; terminate |
| Failure R1 | all observe the invited vote vector | no current payoff; enter R2 |
| Failure R2 | no further decision | terminal disagreement |

On passage each weak state receives x_j, including zero for excluded states.
H receives x_H if H∈C and o if H∉C. On terminal disagreement H receives o
and all weak states receive zero. R2 outcomes are measured in R2 units; R1
failure imports them with exactly one factor β. A no vote alone triggers no
outside-option payment or irreversible exit. In particular, excluding H in
an R1 agreement pays o at R1, whereas an R1 failure pays only the discounted
continuation. The unit pie is fixed and does not depend on C or o. The outside
option is outside that pie and independent of the agreement among weak states.
There is no additional individual action to implement or obtain an allocation.

## Beliefs and solution concept

Maintain PBE with pure ballots, as-if-pivotal weak voting, acceptance at exact
expected-value indifference (T^Y), and a proposer tie-break minimizing H's
expected payoff among its own payoff-maximizing proposals. Proposal mixtures
survive only where both comparisons tie; the same weights determine all
payoffs and outcome laws. Weak actions, including both components (C,x), carry
no information about o. If H∉C the entire weak ballot preserves the entering
belief. If H∈C, after any invited vote vector the posterior is determined by
the entering belief, the profile's type-contingent H vote law at that ballot,
and H's realized vote. Bayes applies when the denominator is positive,
including ballots reached by a weak deviation. Otherwise one free value is
attached to that ballot-and-H-vote pair within the support of the original
prior. All vectors in that ballot with the same H vote share that value.
Distinct ballots, including different C, may have different free values.
This is the August/September declared discipline, adapted only to H's absence
from ballots of coalitions that exclude it. It is not sequential-equilibrium
consistency, nor unrestricted belief choice after weak deviations.

The as-if-pivotal comparison applies to invited weak voters after every
proposal. Their no changes passage to failure in the pivotal comparison.
When the profile makes H's affirmative action a zero-probability event, the
approved local belief attached to that action supplies its continuation
comparison, as in the existing unanimity correspondence. This does not add a
new belief restriction. H best responds to the prescribed weak votes; if a
weak veto makes passage impossible, it compares the two belief-dependent
continuations and uses T^Y at equality.

## Payoff completeness and nonaccumulation

Every feasible proposal and every vote vector has exactly one transition in
the table. If H∈C and votes no, passage is impossible, including in oversized
coalitions. If H∉C and the contract passes, x_H=0 by feasibility. If H∈C and
the contract passes, it consented and receives its proposed share. Thus no
history pays H a positive share of an implemented contract and its outside
option. This uses the author-adopted contract and support restrictions, not
optimality, removal of an inconvenient history, cancellation after passage,
or a repayment to the proposer. The conclusion covers arbitrary proposal and
vote deviations, not merely optimal proposals. Feasible oversized coalitions
and zero-payment invitees remain in the action space.

## Sufficient states and dependencies

For baseline payoff formulas retain (round,institution,current belief,
original support,recognized proposer). Complete assessments retain the full
public history so that allowed local free beliefs and identity-dependent
selections are not erased. R2 majority values are belief-free; R2 unanimity
values are functions of the posterior. The unanimity coalition is always N.
Only the explicitly specified anonymous representatives used by the agenda
extension compress baseline outcome kernels to the posterior and the selected
branch. This is a declared continuation restriction, not a theorem about all
history-dependent baseline assessments.

The acyclic dependency order is R2_M→R1_M and R2_U→R1_U, then public/private
comparisons and agenda A. Here the arrow means 'is consumed by'. Terminal
interfaces are closed and hashed before R1 is derived. R1 interfaces are closed
and hashed before the agenda implementer closes its parameterized work. The
execution manifest is `game_dag.json`. 'pass' there means a mathematically
specified, stable implementation interface; independent review status is
recorded separately, without promotion of historical reviews to this candidate.

Changing any interface invalidates its descendants and their associated review
claims until they are rederived/rechecked against the new hash. Under U,
adding/removing the constant label C=N is an extensive-form isomorphism with
the previous U game. Under M, neither all strategies nor all deviations are
claimed to be equivalent to the previous game.
