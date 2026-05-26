# Independent Verification: Entry/Nesting Under `pi_H = 0`

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`, Result E1  
**Verifier status:** PASS sem ressalvas

## Result Verified

Under the verified pooling-or-delay characterization,

\[
V_W^U(\mu)
=
\frac{1}{m}
\max\left\{
V_e(\mu)-\beta\alpha r\text{ if (U1-F) holds},\,
\beta g(\mu)
\right\}.
\]

The unanimity formation set is

\[
F_U=\{\mu\in[0,1]:V_W^U(\mu)\geq c\}.
\]

On the verified majority pass branch,

\[
V_W^M(\mu)=\frac{V_e(\mu)}{m}.
\]

The verifier confirmed:

\[
V_W^U(\mu)\leq V_W^M(\mu)
\]

on the majority pass branch, so

\[
F_U\cap\mathcal P_M^F\subseteq F_M^{pass}.
\]

When (M-F) holds globally, as in the OPEC calibration,

\[
F_U\subseteq F_M^{pass}
\]

for every entry cost \(c\).

## OPEC Check

For \(N=13\), \(r=1.5\), \(\alpha=0.19\), \(\beta=0.9\):

- majority pass feasibility holds globally;
- pooling feasibility boundary is \(0.372424\);
- the minimum gap \(V_W^M(\mu)-V_W^U(\mu)\) is \(0.021375\), attained in the
  accepted-pooling region.
