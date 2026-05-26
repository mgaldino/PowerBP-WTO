# Unanimity R1 Under pi_H = 0: Pooling Or Rejection

Date: 2026-05-10

Supersession note: this report is now conditional only. It excludes the
high-state-only feasibility branch identified later on 2026-05-10. The current
R1 characterization is C-B-R in
`quality_reports/2026-05-10_unanimity_R1_C_B_R_piH0_derivation.md`.

Status: verified by independent analytical agent, PASS without reservations for
\(\alpha>0\).

## Protocol

This derivation uses the protocol represented by the manuscript game tree:

1. a weak state is recognized in R1;
2. it makes an offer;
3. players vote accept/reject;
4. a rejected R1 proposal leads to R2;
5. public responses update weak-state beliefs.

The rejected-proposal branch is not a new delay action. It is implemented by a
proposal that fails for a type-independent reason, so the history carries no
information about H's type.

## R2 Continuation

Let \(m=N-1\) and

\[
V_e(\mu)=1+\mu(r-1).
\]

With weak proposers only in R2,

\[
g(\mu)=\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\},
\qquad
W_2^U(\mu)=\frac{g(\mu)}{m}.
\]

The R2 cutoff is

\[
\mu_2^*=\frac{\alpha(r-1)}{r-\alpha}.
\]

At posterior one, R2 is conservative and both types of H receive \(\alpha r\).

## No Strict Separating Accepted Agreement

Suppose a weak proposer tries to implement an accepted separating agreement in
which the low type accepts and the high type rejects. If the high type rejects
on path, Bayes' rule gives posterior one in R2. Since posterior-one R2 pays
\(\alpha r\) to any H type, the low type's deviation payoff from rejecting is
\(\beta\alpha r\).

The R1 transfer \(h_A\) must satisfy

\[
\text{low accepts:}\quad h_A\geq\beta\alpha r,
\]

and

\[
\text{high rejects strictly:}\quad h_A<\beta\alpha r.
\]

The interval is empty. At \(h_A=\beta\alpha r\), both types are indifferent and
the maintained tie-breaking convention makes both types accept. Thus the
separating branch collapses into pooling.

## Accepted Pooling

The accepted pooling transfer to H is

\[
h_C=\beta\alpha r.
\]

Each non-proposing weak state receives

\[
y_C(\mu)=\beta W_2^U(\mu)=\frac{\beta g(\mu)}{m}.
\]

Pooling is feasible in the low state iff

\[
\beta\alpha r+\frac{(m-1)\beta g(\mu)}{m}\leq 1.
\]

The weak proposer payoff from accepted pooling is

\[
C(\mu)=V_e(\mu)-\beta\alpha r-\frac{(m-1)\beta g(\mu)}{m}.
\]

## Rejected Proposal Without Information

For the main case \(\alpha>0\), the weak proposer can induce a rejected proposal
for a type-independent reason: offer \(h_R=0\) to H. Both H types strictly
reject, the proposal fails, and H's observed response is the same in both
states. The posterior remains \(\mu\).

The proposer then receives

\[
R(\mu)=\beta W_2^U(\mu)=\frac{\beta g(\mu)}{m}.
\]

The boundary case \(\alpha=0\) cannot use strict H rejection under nonnegative
transfers and acceptance in indifference. It should be handled separately as a
limit or with an explicitly specified weak-voter rejection selection.

## Pure-Strategy R1 Payoff

Under the maintained H-acceptance tie-breaking convention, the pure-strategy
payoff-relevant choice is

\[
W_{1,prop}^{U}(\mu)=
\max\{C(\mu)\text{ if feasible},R(\mu)\}.
\]

Accepted pooling is chosen iff pooling is feasible and

\[
V_e(\mu)-\beta\alpha r\geq \beta g(\mu).
\]

Otherwise the proposer induces type-independent rejection and continues to R2
with posterior \(\mu\).

## OPEC Calibration

For \(N=13\), \(r=1.5\), \(\alpha=0.19\), and \(\beta=0.9\):

- \(\mu_2^*=0.072519\);
- the strict separating interval is empty;
- the pooling feasibility boundary is \(\mu=0.372424\);
- the conditional payoff premium cutoff is \(\mu=0.7\);
- \(C(\mu)-R(\mu)>0\) for every \(\mu\in[0,1]\).

The numerical check is `scripts/verify_unanimity_R1_C_or_R_piH0.R`.

## Independent Verification

An independent analytical verifier returned PASS without reservations for the
domain \(\alpha>0\). The verifier checked:

- correctness of \(C(\mu)\), \(R(\mu)\), \(h_C=\beta\alpha r\),
  \(y_C=\beta g(\mu)/m\), and low-state feasibility;
- validity of the no-strict-separation proof under the manuscript tree and
  acceptance-at-indifference tie-breaking;
- the endogenous microfoundation of \(R(\mu)\) via \(h_R=0\), strictly rejected
  by both H types when \(\alpha>0\);
- absence of mixed/semi-separating or off-path-belief counterexamples under the
  maintained tie-break;
- the OPEC calibration values.

The verifier also confirmed that \(\alpha=0\) is a boundary case: under
acceptance at indifference, H accepts zero, so strict rejection by both types
does not implement \(R\) without a separate selection/protocol.
