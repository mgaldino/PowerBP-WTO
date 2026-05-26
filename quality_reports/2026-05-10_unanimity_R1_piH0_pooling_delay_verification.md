# Independent Verification: Unanimity R1 `pi_H = 0`

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`, Result U1  
**Verifier status:** PASS sem ressalvas

## Result Verified

Under `pi_H = 0` in both rounds, the R1 weak proposer under unanimity has a
pooling-or-delay problem:

\[
W_{1,prop}^{U}(\mu)
=
\max\left\{
P(\mu)\text{ if (U1-F) holds},\,
R(\mu)
\right\}.
\]

The accepted pooling proposal uses

\[
h_P=\beta\alpha r,\qquad y_P(\mu)=\frac{\beta g(\mu)}{m},
\]

and is feasible iff

\[
\beta\alpha r+\frac{(m-1)\beta g(\mu)}{m}\leq 1.
\]

Accepted pooling is chosen iff

\[
V_e(\mu)-\beta\alpha r\geq \beta g(\mu).
\]

The verifier confirmed that no other pure payoff-relevant branch must be added
under the stated tie-breaking convention.

## Rent

When accepted pooling occurs,

\[
V_{H,1}^{U,P}(\mu)=\beta\alpha r,
\]

and the ex ante rent relative to expected outside option is

\[
\Delta_H^P(\mu)=\alpha\{\beta r-1-\mu(r-1)\}.
\]

For the OPEC calibration, accepted pooling is feasible for
\(\mu\leq0.372424\), the rent cutoff is \(0.700000\), and rent at the
feasibility boundary is approximately \(0.031120\).
