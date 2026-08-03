---
title: "Superseded Baseline Packet: pi_H = 0"
subtitle: "Informational Power Through Pivotality"
date: "2026-05-10"
geometry: margin=1in
fontsize: 11pt
---

# Purpose

**Superseded status note (2026-05-10).** This packet should not be used as a
verified result packet. A later protocol audit found that the R1
no-information-delay branch was not yet derived from a stated primitive of the
extensive-form game. The majority pass branch and unanimity R2 derivation remain
useful, but R1 unanimity, entry/nesting, conditional dominance, and institutional
classification must be treated as pending rederivation.

This packet originally summarized the baseline architecture for the redesigned
model. It is now retained as an audit artifact, not as a verified result packet.

At the time of this packet, `formal_model_v5.Rmd` was the active manuscript.
The current target is `formal_model_v6.Rmd`, but neither manuscript is the
source of truth for the pending clean-baseline reset. That reset must first be
rederived and reviewed in `model_redesign/power_architecture_derivations.Rmd`.

The baseline stacks the agenda against the hegemon:

```text
pi_H = 0 in Round 1 and Round 2.
```

Weak states therefore control the agenda in both rounds. Any payoff advantage
for the hegemon comes from veto/pivotality under unanimity and from its
type-dependent outside option, not from proposal power.

# Primitives

There are \(N \geq 3\) states. One state is the hegemon \(H\); the remaining
\(m=N-1\) are weak states. Under majority, the required coalition size is

\[
q=\lfloor N/2 \rfloor+1.
\]

The state is \(\theta \in \{0,1\}\). The institutional surplus is

\[
V(0)=1,\qquad V(1)=r>1,
\]

and the prior probability of the high state is \(\mu\). The expected surplus is

\[
V_e(\mu)=1+\mu(r-1).
\]

H's outside option is external to the institutional pie and equals

\[
d_H(\theta)=\alpha V(\theta).
\]

Weak states have normalized outside option zero. The common discount factor is
\(\beta \in (0,1)\).

The bargaining stages are sequential and public across rounds; this does not
mean sequential roll-call voting within a ballot. Under the later adopted
common ballot protocol, all non-proposers vote simultaneously and the
individual vote record is revealed after the ballot closes. Proposals must be
feasible in the realized state in which they pass. The maintained tie-breaking
rule is acceptance in indifference. See
`quality_reports/2026-05-11_common_voting_protocol_unanimity_majority.md`.

# Result 1: Majority Pass Branch

Under majority and weak-state agenda, weak proposers can exclude \(H\). On the
pass-feasible branch

\[
\mathcal{P}_M^F
=
\left\{
\mu:
\frac{\beta(q-1)V_e(\mu)}{m}\leq 1
\right\},
\]

the verified payoffs are

\[
V_H^M(\mu)=\alpha V_e(\mu),
\qquad
V_W^M(\mu)=\frac{V_e(\mu)}{m}.
\]

The majority formation set on this verified branch is

\[
F_M^{pass}
=
\mathcal{P}_M^F
\cap
\left\{\mu: \frac{V_e(\mu)}{m}\geq c\right\}.
\]

This is a pass-branch result. The majority delay/rejection branch outside
\(\mathcal{P}_M^F\) has not yet been derived.

# Result 2: Unanimity Round 2

Under unanimity in Round 2, a weak proposer must buy H's approval. The weak
representative continuation value is

\[
W_2^U(\mu)
=
\frac{1}{m}
\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\}.
\]

The R2 cutoff is

\[
\mu_2^*
=
\frac{\alpha(r-1)}{r-\alpha}.
\]

Below the cutoff, the low type binds. Above the cutoff, the high type binds.

# Result 3: Unanimity Round 1

Status: pending R1 protocol rederivation.

With \(\pi_H=0\) also in Round 2, the strict low-accepted/high-rejected R1 branch
collapses into a tie under the maintained tie-breaking rule. At the candidate
strict aggressive offer, the high type is indifferent rather than strictly
rejecting; acceptance in indifference turns the branch into pooling.

Define

\[
g(\mu)=\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\}.
\]

Accepted pooling in R1 pays H

\[
h_P=\beta\alpha r
\]

and each weak voter

\[
y_P=\frac{\beta g(\mu)}{m}.
\]

Pooling is feasible when

\[
\tag{U1-F}
\beta\alpha r+\frac{(m-1)\beta g(\mu)}{m}\leq 1.
\]

The weak proposer payoff from pooling is

\[
P(\mu)
=
V_e(\mu)-\beta\alpha r-\frac{(m-1)\beta g(\mu)}{m}.
\]

Conditional on an admissible no-information delay history, the continuation
payoff would be

\[
R(\mu)=\frac{\beta g(\mu)}{m}.
\]

This is not yet a verified option of the proposer under the original BF
protocol. The following weak-proposer problem is a conditional calculation, not
a theorem:

\[
W_{1,prop}^{U}(\mu)
=
\max\{P(\mu)\text{ if (U1-F) holds},R(\mu)\}.
\]

Pooling is chosen when it is feasible and

\[
V_e(\mu)-\beta\alpha r\geq \beta g(\mu).
\]

# Result 4: Hegemonic Rent

Status: conditional calculation, pending R1 protocol rederivation.

When accepted pooling occurs under unanimity, H receives

\[
V_H^{U,P}(\mu)=\beta\alpha r.
\]

Relative to H's expected outside option \(\alpha V_e(\mu)\), the ex ante payoff
premium is

\[
\Delta_H^P(\mu)
=
\alpha\{\beta r-1-\mu(r-1)\}.
\]

For \(\alpha>0\) and \(\beta r>1\), this premium is positive exactly when

\[
\mu<\frac{\beta r-1}{r-1}.
\]

This is an ex ante premium relative to the expected outside option. It does not
mean that the high type receives more than its undiscounted outside option when
\(\beta \leq 1\).

# Result 5: Alpha = 0 Stress Test

When \(\alpha=0\), H's outside option is no stronger than the weak states'
normalized outside option. In this stress test,

\[
d_H(0)=d_H(1)=0.
\]

The verified rent is zero:

\[
\Delta_H(\theta,\mu)=0.
\]

Thus pivotality and private information alone do not generate positive rent in
this baseline. The positive rent requires the type-dependent outside option.

# Result 6: Entry And Nesting

Status: pending R1 protocol rederivation.

Let

\[
F_U=\{\mu:V_W^U(\mu)\geq c\}.
\]

On the verified majority-pass branch,

\[
V_W^U(\mu)\leq V_W^M(\mu).
\]

Therefore

\[
F_U\cap\mathcal{P}_M^F\subseteq F_M^{pass}.
\]

For the OPEC calibration, majority pass feasibility holds globally, so

\[
F_U\subseteq F_M^{pass}
\]

for every entry cost \(c\). The minimum calibrated gap
\(V_W^M(\mu)-V_W^U(\mu)\) is \(0.021375\).

# Result 7: Conditional Institutional Preference

Status: pending R1 protocol rederivation.

Conditional on both institutions forming and on the verified majority-pass
branch, H's institutional comparison is

\[
D_H(\mu)=V_H^U(\mu)-V_H^M(\mu).
\]

For the OPEC calibration

\[
N=13,\qquad r=1.5,\qquad \alpha=0.19,\qquad \beta=0.9,
\]

the verified unanimity payoff is

\[
V_H^U(\mu)=0.2565
\qquad
\text{for every }\mu\in[0,1],
\]

while the majority payoff on the pass branch is

\[
V_H^M(\mu)=0.19(1+0.5\mu).
\]

Therefore

\[
D_H(\mu)>0 \iff \mu<0.7.
\]

In the OPEC calibration, conditional on both institutions forming, H strictly
prefers unanimity for \(\mu<0.7\), is indifferent at \(\mu=0.7\), and strictly
prefers majority for \(\mu>0.7\).

# Result 8: Institutional Classification

Status: pending R1 protocol rederivation.

The verified general classification applies on the majority-pass domain. For
the OPEC calibration, because pass feasibility holds globally, it applies on
the full unit interval:

\[
\begin{array}{ll}
\mu\in F_U,\ \mu<0.7
&\Rightarrow \text{H strictly chooses unanimity},\\[4pt]
\mu\in F_U,\ \mu>0.7
&\Rightarrow \text{H strictly chooses majority},\\[4pt]
\mu\in F_U,\ \mu=0.7
&\Rightarrow \text{H is indifferent},\\[4pt]
\mu\in F_M^{pass}\setminus F_U
&\Rightarrow \text{H is payoff indifferent absent a formation tie-break}.
\end{array}
\]

This classification is narrower than the old manuscript claim. It does not say
that unanimity dominates majority everywhere. It says that, in the most
unfavorable agenda baseline for H, unanimity can still generate a positive
payoff premium in the region where the pooling payment exceeds H's expected
outside option.

# OPEC Calibration Numbers

The verification scripts reproduce:

\[
\mu_2^*=0.072519,
\]

R1 pooling feasibility through

\[
\mu=0.372424,
\]

conditional dominance cutoff

\[
\mu=0.7,
\]

constant unanimity payoff

\[
V_H^U=0.2565,
\]

and minimum nesting gap

\[
0.021375.
\]

# Verification Record

Each proof or derivation in this packet was followed by independent analytical
verification. The final architecture-wide audit returned PASS without
reservations.

Reproducibility scripts:

- `scripts/verify_baseline_majority_piH0.R`;
- `scripts/verify_baseline_unanimity_R2_piH0.R`;
- `scripts/verify_baseline_unanimity_R1_piH0.R`;
- `scripts/verify_baseline_stress_alpha0_piH0.R`;
- `scripts/verify_baseline_entry_nesting_piH0.R`;
- `scripts/verify_baseline_conditional_dominance_piH0.R`;
- `scripts/verify_baseline_institutional_classification_piH0.R`.

Independent verification reports:

- `quality_reports/2026-05-10_baseline_piH0_independent_verification.md`;
- `quality_reports/2026-05-10_unanimity_R1_piH0_pooling_delay_verification.md`;
- `quality_reports/2026-05-10_alpha0_piH0_stress_verification.md`;
- `quality_reports/2026-05-10_entry_nesting_piH0_verification.md`;
- `quality_reports/2026-05-10_conditional_dominance_piH0_verification.md`;
- `quality_reports/2026-05-10_institutional_classification_piH0_verification.md`;
- `quality_reports/2026-05-10_final_architecture_audit_piH0.md`.

# Caveats To Preserve

1. Majority remains a pass-branch result. Outside \(\mathcal{P}_M^F\), the
   majority delay/rejection branch has not been derived. The global OPEC
   conclusion is valid because pass feasibility holds for all \(\mu\in[0,1]\).

2. The unanimity R1 characterization uses acceptance in indifference. Without
   it, the aggressive low-accepted/high-rejected branch can reappear as a
   knife-edge selection, but not as a robust payoff-distinct branch.

3. The OPEC classification must preserve the distinction between
   \(F_U\) and \(F_M^{pass}\setminus F_U\). In the latter region, H is payoff
   indifferent absent an institutional formation tie-break.

4. The positive rent is ex ante and relative to H's expected outside option.

5. The alpha = 0 stress test shows that the mechanism requires H's outside
   option to be type dependent.

# Questions For External Review

1. Is the no-information delay construction a PBE under the adopted
   simultaneous-ballot protocol with ex post public vote records? In
   particular, what beliefs are required if a proposal fails by weak-voter
   rejection and H's action is or is not observed?

2. Is the exclusion of the low-accepted/high-rejected R1 branch robust to all
   PBE-consistent off-path beliefs under acceptance in indifference?

3. Does the nesting result use the correct weak-state payoff concept under
   collective all-or-nothing entry, or would individual participation constraints
   require a different formation set?

4. Should the majority delay branch outside \(\mathcal{P}_M^F\) be derived, or
   should the paper preserve the pass-branch domain restriction?

5. In the paper prose, should \(\beta\alpha r-\alpha V_e(\mu)\) be called an
   informational rent, or should it be described more narrowly as an ex ante
   payoff premium from pooling relative to the expected outside option?
