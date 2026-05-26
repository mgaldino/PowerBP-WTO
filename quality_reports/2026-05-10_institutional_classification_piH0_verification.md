# Independent Verification: Institutional Classification Under `pi_H = 0`

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`, Result I1  
**Verifier status:** PASS sem ressalvas after one scope correction

## Scope Correction

The first verification noted that the general classification must be restricted
to the verified majority-pass domain:

\[
F_M^{pass}=\mathcal P_M^F\cap\{\mu:c\leq V_e(\mu)/m\}.
\]

Outside \(\mathcal P_M^F\), the majority delay branch has not yet been derived.
The document was corrected accordingly.

## Result Verified

On \(F_U\cap F_M^{pass}\), classification follows the sign of

\[
D_H(\mu)=V_H^U(\mu)-V_H^M(\mu).
\]

If \(D_H>0\), \(H\) strictly prefers unanimity. If \(D_H<0\), \(H\) strictly
prefers majority. If \(D_H=0\), \(H\) is indifferent.

On \(F_M^{pass}\setminus F_U\), majority forms and unanimity does not. Under the
baseline payoff accounting,

\[
V_H^M(\mu)=\alpha V_e(\mu),
\]

which equals \(H\)'s no-formation outside option under unanimity. Hence this is
payoff indifference absent an explicit tie-break favoring institutional
formation.

## OPEC Classification

For the OPEC calibration, (M-F) holds globally, so the classification is global
on \([0,1]\). Since

\[
D_H(\mu)=0.0665-0.095\mu,
\]

\(H\) strictly chooses unanimity on \(F_U\cap\{\mu<0.7\}\), strictly chooses
majority on \(F_U\cap\{\mu>0.7\}\), is indifferent at \(\mu=0.7\), and is
payoff-indifferent on \(F_M^{pass}\setminus F_U\) absent a formation tie-break.
