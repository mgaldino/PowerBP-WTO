# Unanimity R1 Under pi_H = 0: C-B-R Characterization

Date: 2026-05-10

Status: verified by independent analytical agent, PASS without reservations
after one correction round.

## Q&A

Q: Does the old C-or-R characterization survive realized-state BF feasibility?

A: No. If weak proposers may make offers that are feasible only in the realized
state in which they pass, then an offer can fit the high-state pie but not the
low-state pie. This creates a high-state-only branch \(B\).

Q: Is this the old low-accepted/high-rejected aggressive branch?

A: No. The old branch separated through H's acceptance incentives and collapses
to a tie when \(\pi_H=0\) in R2. The new branch separates mechanically through
feasibility: the agreement can execute only when the pie is high.

## Setup

Let \(m=N-1\) be the number of weak states and \(k=m-1\) the number of
non-proposing weak voters. Let

\[
V_e(\mu)=1+\mu(r-1),
\qquad
g(\mu)=\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\}.
\]

Under \(\pi_H=0\) in R2,

\[
W_2^U(\mu)=\frac{g(\mu)}{m},
\qquad
W_2^U(0)=\frac{1-\alpha}{m},
\qquad
W_2^U(1)=\frac{r(1-\alpha)}{m}.
\]

## Pooling Branch P

Accepted pooling gives H its discounted high-state outside-option value:

\[
h_P=\beta\alpha r.
\]

Each non-proposing weak voter receives

\[
y_P(\mu)=\frac{\beta g(\mu)}{m}.
\]

Pooling is low-state feasible iff

\[
\beta\alpha r+\frac{(m-1)\beta g(\mu)}{m}\leq1.
\]

The proposer payoff is

\[
P(\mu)=V_e(\mu)-\beta\alpha r-\frac{(m-1)\beta g(\mu)}{m}.
\]

## No Strict Low-Accepted/High-Rejected Branch

If the high type rejects on path, R2 starts with posterior one. Under
\(\pi_H=0\), posterior-one R2 pays \(\alpha r\) to H. Hence low acceptance
requires

\[
h_A\geq\beta\alpha r,
\]

while strict high rejection requires

\[
h_A<\beta\alpha r.
\]

The interval is empty. At equality, the maintained tie-breaking convention makes
both H types accept, so the branch collapses into pooling.

## High-State-Only Branch B

Let

\[
T=h+ky
\]

be the total promised to non-proponents. A proposal satisfying

\[
1<T\leq r
\]

is infeasible in the low state and feasible in the high state.

The high type of H accepts if

\[
h_B=\beta\alpha r.
\]

A non-proposing weak voter is uninformed. If he accepts, he receives \(y\) in
the high state and gets the low-state feasibility-failure continuation in the
low state. If he rejects, his rejection does not reveal \(\theta\), so the
continuation is R2 at current belief \(\mu\). Thus, for \(\mu>0\),

\[
\mu y+(1-\mu)\beta W_2^U(0)\geq \beta W_2^U(\mu),
\]

and the minimum transfer is

\[
y_B(\mu)
=
\frac{\beta\{g(\mu)-(1-\mu)(1-\alpha)\}}{m\mu}.
\]

The minimum total transfer is

\[
T_B(\mu)=h_B+ky_B(\mu)
=
\beta\alpha r
+
(m-1)\frac{\beta\{g(\mu)-(1-\mu)(1-\alpha)\}}{m\mu}.
\]

If \(1<T_B(\mu)\leq r\), the high-state-only branch has an exact minimum and
the proposer payoff is

\[
B(\mu)=
\mu\{r-T_B(\mu)\}
+
(1-\mu)\frac{\beta(1-\alpha)}{m}.
\]

If \(T_B(\mu)\leq1\), the branch has only a supremum under strict low-state
infeasibility, because the proposer wants \(T\downarrow1\). That case requires
an explicit existence convention. In the OPEC calibration, \(B\) is chosen only
where \(T_B(\mu)>1\).

Protocol note: this report treats low-state infeasibility as a mechanical
failure of the proposal, so no type-dependent H-rejection history is generated
in the low state. If the final extensive form instead lets H cast an
individually observed vote on an infeasible proposal before the feasibility
failure, the off-path belief after unexpected H rejection must be specified.

On branch \(B\),

\[
V_H^{U,B}(\mu)=\beta\alpha V_e(\mu),
\]

and

\[
V_W^{U,B}(\mu)=
\frac{(1-\mu)\beta(1-\alpha)+\mu(r-\beta\alpha r)}{m}.
\]

## Rejection Branch R

For \(\alpha>0\), the weak proposer can offer \(h_R=0\) to H. Both H types
strictly reject, so rejection is type-independent and posterior remains \(\mu\).
The proposer payoff is

\[
R(\mu)=\frac{\beta g(\mu)}{m}.
\]

The boundary case \(\alpha=0\) still requires separate treatment because H is
not made to reject strictly by a nonnegative offer under the maintained
acceptance tie-break.

## R1 Choice

The weak proposer solves

\[
W_{1,prop}^U(\mu)=
\max\{P(\mu)\text{ if low-state feasible},\,
B(\mu)\text{ if high-state-only feasible},\,
R(\mu)\}.
\]

Thus C-or-R is incomplete unless the model adds a robust-feasibility primitive
requiring proposals under uncertainty to fit every state still possible to weak
states.

## OPEC Calibration

For \(N=13\), \(r=1.5\), \(\alpha=0.19\), and \(\beta=0.9\), the exact-B
boundary is

\[
\mu_B=0.232404.
\]

The pooling feasibility boundary is

\[
\mu_F=0.372424.
\]

Numerically:

- \(P\) strictly dominates \(B\) and \(R\) for \(\mu\leq0.372424\);
- \(B\) strictly dominates \(R\) for \(\mu>0.372424\);
- \(B\) has an exact minimum wherever it is chosen;
- the OPEC R1 regimes are \(P\) then \(B\);
- \(H\) strictly prefers unanimity on \(P\);
- \(H\) strictly prefers majority on \(B\);
- weak-state nesting \(V_W^U(\mu)\leq V_W^M(\mu)\) still holds.

The reproducible check is
`scripts/verify_unanimity_R1_C_B_R_piH0.R`.
