# Entry, Dominance, and Classification Under C-or-R

Date: 2026-05-10

Supersession note: this report is now conditional only. It uses the C-or-R R1
characterization and therefore excludes the high-state-only feasibility branch.
The current baseline result is the C-B-R characterization in
`quality_reports/2026-05-10_unanimity_R1_C_B_R_piH0_derivation.md`.

Status: PASS without reservations.

## Inputs

This report uses the verified R1 unanimity characterization under \(\pi_H=0\)
and \(\alpha>0\): the weak proposer chooses between accepted pooling \(C\) and
type-independent rejection \(R\). Strict low-accepted/high-rejected separation
does not exist under the maintained tie-breaking convention.

Let

\[
g(\mu)=\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\}.
\]

The weak-state payoff under unanimity is

\[
V_W^U(\mu)=
\frac{1}{m}
\max\{V_e(\mu)-\beta\alpha r\text{ if pooling is feasible},\beta g(\mu)\}.
\]

The majority pass-branch payoff is

\[
V_W^M(\mu)=\frac{V_e(\mu)}{m}.
\]

## Entry And Nesting

On the pooling branch,

\[
V_W^M(\mu)-V_W^{U,C}(\mu)=\frac{\beta\alpha r}{m}\geq0.
\]

On the rejection branch,

\[
V_W^M(\mu)-V_W^{U,R}(\mu)
=
\frac{V_e(\mu)-\beta g(\mu)}{m}\geq0,
\]

because \(g(\mu)\leq V_e(\mu)\) and \(\beta\leq1\).

Therefore, on the majority pass-feasible branch,

\[
F_U\cap\mathcal P_M^F\subseteq F_M^{pass}.
\]

For the OPEC calibration, majority pass feasibility holds globally, so
\(F_U\subseteq F_M^{pass}\) for every entry cost \(c\). The minimum calibrated
gap is \(0.021375\).

## Conditional Dominance

Under accepted pooling, H receives

\[
V_H^{U,C}(\mu)=\beta\alpha r.
\]

Under rejection without information, H receives the discounted R2 value:

\[
V_H^{U,R}(\mu)=
\begin{cases}
\beta\alpha V_e(\mu), & \mu<\mu_2^*,\\
\beta\alpha r, & \mu>\mu_2^*.
\end{cases}
\]

On any branch where H receives \(\beta\alpha r\), the comparison with majority
\(V_H^M(\mu)=\alpha V_e(\mu)\) is

\[
D_H(\mu)=\alpha\{\beta r-1-\mu(r-1)\}.
\]

Thus, for \(\alpha>0\) and \(\beta r>1\), H prefers unanimity on this branch
iff

\[
\mu<\mu_H^*=\frac{\beta r-1}{r-1}.
\]

For the OPEC calibration, R1 pooling is chosen whenever feasible and rejection
otherwise leads to the conservative R2 region. Hence \(V_H^U(\mu)=0.2565\) for
all \(\mu\in[0,1]\), and H strictly prefers unanimity iff \(\mu<0.7\).

## Institutional Classification

For the OPEC calibration, because majority pass feasibility is global:

- if \(\mu\in F_U\) and \(\mu<0.7\), H strictly chooses unanimity;
- if \(\mu\in F_U\) and \(\mu>0.7\), H strictly chooses majority;
- if \(\mu\in F_U\) and \(\mu=0.7\), H is indifferent;
- if \(\mu\in F_M^{pass}\setminus F_U\), H is payoff indifferent absent a
  formation tie-break.

## Reproducibility

Scripts:

- `scripts/verify_entry_nesting_C_or_R_piH0.R`;
- `scripts/verify_conditional_dominance_C_or_R_piH0.R`;
- `scripts/verify_institutional_classification_C_or_R_piH0.R`.

## Independent Verification

An independent analytical verifier returned PASS without reservations on
2026-05-10. The
verifier confirmed:

- \(F_U\cap\mathcal P_M^F\subseteq F_M^{pass}\) follows from
  \(V_W^U(\mu)\leq V_W^M(\mu)\);
- for OPEC, majority pass feasibility is global, so
  \(F_U\subseteq F_M^{pass}\);
- H's dominance comparison is correctly conditioned on the C/R branches and on
  \(\mu_H^*=(\beta r-1)/(r-1)\);
- the OPEC institutional classification is scoped to the majority-pass domain
  and does not overclaim global unanimity dominance;
- the scripts reproduce \(\mu_2^*=0.072519083969\), pooling feasibility
  boundary \(0.372424242424\), minimum nesting gap \(0.021375\),
  \(V_H^U=0.2565\), and \(\mu_H=0.7\).

The derivation document and script references have been updated to match this
verified C-or-R architecture.
