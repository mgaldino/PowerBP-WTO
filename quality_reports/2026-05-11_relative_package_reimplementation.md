# Relative-Package Reimplementation Decision

Date: 2026-05-11

Status: architecture decision adopted for reimplementation; derivations pending.

## Bottom Line

The next version should abandon the high-state-only feasibility branch as the
main source of separation. Proposals should be modeled as relative institutional
packages: quotas, production shares, cut obligations, enforcement provisions,
exceptions, and flexibility rules. These packages are feasible in every state.
Screening should come from \(H\)'s type-dependent participation constraint, not
from a proposal that physically fits one realized pie but not another.

## Why the Feasibility Branch Should Be Retired

The attempted \(B\) branch used the fact that an absolute promised total
\(1<T\leq r\) fits the high-state pie but not the low-state pie. Independent
verification showed that this branch is protocol-dependent:

1. if feasibility is checked after a voter rejects, no-consent can reveal the
   state and the weak-voter IC changes;
2. if consent is checked before implementation and \(H\) is a required voter,
   low-type \(H\) has a consent IC that generally fails in the calibrated
   high-\(\mu\) \(B\) region;
3. avoiding these problems requires a specialized timing protocol.

That protocol dependence is not worth carrying in the main model.

## New Primitive Object

Let the proposal be an institutional package

\[
x\in X.
\]

For tractability, the first reimplementation can use a scalar concession index

\[
y\in[0,\bar y],
\]

where higher \(y\) means a package more favorable to \(H\): a larger production
share, weaker cut obligation, more flexibility, stronger enforcement against
other members, or more favorable treatment under changing market conditions.

If the package is a share vector,

\[
s=(s_H,s_{W_1},\ldots,s_{W_k}),\qquad \sum_i s_i\leq1,
\]

then the allocation is feasible in all states. The state affects payoffs, not
physical feasibility.

## Minimal Payoff Representation

Use

\[
U_H(y,\theta)=y+b_H(\theta).
\]

Here \(y\) is the concession that weak states grant to \(H\) through the
institutional package. It is not a fixed transfer. It can represent a more
favorable quota, more flexibility, a weaker cut obligation, or better
enforcement against other members.

The term \(b_H(\theta)\) is the direct benefit \(H\) receives from the agreement
itself: cartel coordination, price stability, predictability, reputation, or
the value of constraining other members. It is a payoff consequence of being
inside the agreement, not the concession chosen by the weak proposer.

Let \(o_H(\theta)\) be \(H\)'s outside option. In the one-shot participation
version, \(H\) accepts iff

\[
y+b_H(\theta)\geq o_H(\theta).
\]

The type-specific threshold is therefore

\[
y_\theta^*=o_H(\theta)-b_H(\theta).
\]

In the dynamic version,

\[
y+b_H(\theta)\geq \beta C_H(\theta,\mu'),
\]

so

\[
y_\theta^*(\mu')=\beta C_H(\theta,\mu')-b_H(\theta).
\]

The screening condition is

\[
y_1^*(\mu')>y_0^*(\mu').
\]

Equivalently, in one-shot notation:

\[
o_H(1)-b_H(1)>o_H(0)-b_H(0).
\]

The high type requires a larger concession because its outside option net of
the direct benefit of agreement is higher.

The special case \(b_H(\theta)=\lambda V(\theta)\) is admissible, but it should
not be imposed by default. If \(o_H(\theta)\) and \(b_H(\theta)\) move
proportionally, the threshold may not differ by type and screening can
disappear. The general \(b_H(\theta)\) formulation is safer.

## New Screening Condition

Let

\[
U_H(y,\theta)
\]

be \(H\)'s payoff from accepting package \(y\), and let

\[
C_H(\theta,\mu')
\]

be its continuation value after rejection. The participation constraint is

\[
U_H(y,\theta)\geq \beta C_H(\theta,\mu').
\]

Define the type-specific threshold

\[
y_\theta^*
=
\inf\{y:U_H(y,\theta)\geq \beta C_H(\theta,\mu')\}.
\]

The intended screening primitive is

\[
y_1^*>y_0^*.
\]

This says that high-state \(H\) requires a more favorable relative package than
low-state \(H\). Weak states know the package they propose, but they do not know
which participation threshold they face.

## OPEC Interpretation

This fits OPEC better than fixed monetary transfers. Members bargain over
quotas, cuts, shares, monitoring, exceptions, and flexibility. They do not know
the future oil price, Saudi spare capacity, or Saudi Arabia's true outside
option, but they can observe the proposed quota package.

Saudi Arabia's private state affects the relative cost of accepting a given
package. If Saudi Arabia has a stronger outside option, greater spare capacity,
or higher opportunity cost from binding quotas, it requires a more favorable
package to enter the agreement. The model should therefore make Saudi Arabia's
relative participation threshold type-dependent.

## Reimplementation Checklist

1. Replace the old fixed-transfer object \(T=h+k\tilde y\) with a package
   \(y\in[0,\bar y]\) or share vector \(s\).
2. Specify \(U_H(y,\theta)=y+b_H(\theta)\), weak-state payoffs, and continuation
   values.
3. Either prove \(y_1^*>y_0^*\) from primitives or state it as an explicit
   reduced-form screening primitive.
4. Recompute R2 unanimity under the relative-package protocol.
5. Recompute R1 unanimity as:
   - pooling/high-threshold package;
   - low-only package;
   - no-agreement/continuation.
6. Recompute majority under \(\pi_H=0\), keeping \(H\)'s outside option external
   to the institutional pie.
7. Rebuild entry/nesting and conditional institutional comparison.
8. Write new verification scripts under new filenames. Do not mutate the old
   C-B-R scripts in place.
9. Run independent verification before any theorem is promoted.

## Current Ledger Implication

The C-B-R algebra remains useful as diagnostic history, but all downstream
results depending on the high-state-only feasibility branch are superseded for
the next paper version. This includes the old conditional comparison, entry
nesting, and institutional classification.
