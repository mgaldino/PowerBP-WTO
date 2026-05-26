# Independent Verification: Conditional Dominance Under `pi_H = 0`

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`, Result C1  
**Verifier status:** PASS sem ressalvas

## Result Verified

The verified majority pass-branch payoff for \(H\) is

\[
V_H^M(\mu)=\alpha V_e(\mu).
\]

In unanimity, accepted pooling gives

\[
V_H^{U,P}(\mu)=\beta\alpha r.
\]

No-information delay gives

\[
V_H^{U,R}(\mu)=
\begin{cases}
\beta\alpha V_e(\mu), & \mu<\mu_2^*,\\
\beta\alpha r, & \mu>\mu_2^*.
\end{cases}
\]

On the high-pooling/conservative branch, the dominance gap is

\[
D_H(\mu)=\alpha\{\beta r-1-\mu(r-1)\}.
\]

Thus, for \(\alpha>0\) and \(\beta r>1\),

\[
D_H(\mu)>0
\iff
\mu<\frac{\beta r-1}{r-1}.
\]

## OPEC Check

For \(N=13\), \(r=1.5\), \(\alpha=0.19\), \(\beta=0.9\),

\[
V_H^U(\mu)=0.2565
\]

for all \(\mu\in[0,1]\). Majority gives

\[
V_H^M(\mu)=0.19(1+0.5\mu).
\]

Hence \(H\) strictly prefers unanimity for \(\mu<0.7\), is indifferent at
\(\mu=0.7\), and strictly prefers majority for \(\mu>0.7\), conditional on both
institutions forming and the verified majority pass branch being feasible.
