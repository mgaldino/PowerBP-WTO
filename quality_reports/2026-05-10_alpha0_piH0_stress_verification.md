# Independent Verification: Alpha-Zero Stress Test

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`, Result S1  
**Verifier status:** PASS sem ressalvas after one correction

## Correction From First Verification

The first verification noted that when \(\alpha=0\), a zero offer is accepted by
both types under the tie-breaking convention. Therefore the would-be aggressive
branch \(G_A(\mu)=1-\mu\) is not a real pure-strategy branch; it is only a
counterfactual high-rejection payoff.

The document was corrected to state that the aggressive/separating branch
collapses into zero-offer pooling.

## Result Verified

With \(\alpha=0\),

\[
d_H(0)=d_H(1)=0.
\]

The terminal unanimity value is

\[
W_2^U(\mu)=\frac{V_e(\mu)}{m},\qquad H_2^U(\theta,\mu)=0.
\]

In Round 1, the accepted pooling transfer to \(H\) is \(h_P=0\), and weak voters
receive \(y_P(\mu)=\beta V_e(\mu)/m\). If pooling is infeasible, delay also
gives \(H\) zero. Hence

\[
\Delta_H(\theta,\mu)=V_H^U(\theta,\mu)-d_H(\theta)=0.
\]

The verified interpretation is that, in the `pi_H=0` baseline, pivotality and
private information alone do not generate positive rent for \(H\). Positive rent
requires a type-dependent outside option.
