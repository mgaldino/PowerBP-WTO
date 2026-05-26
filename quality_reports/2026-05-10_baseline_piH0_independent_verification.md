# Independent Verification: Baseline `pi_H = 0`

**Date:** 2026-05-10  
**Object:** `model_redesign/power_architecture_derivations.Rmd`  
**Verifier status:** PASS sem ressalvas

## Results Verified

1. **M1 majority pass branch.** Under `pi_H = 0`, on
   \(\mathcal{P}_M^F=\{\mu:\beta(q-1)V_e(\mu)/m\leq 1\}\),
   \(V_H^M(\mu)=\alpha V_e(\mu)\), \(V_W^M(\mu)=V_e(\mu)/m\), and
   \(F_M^{pass}=\mathcal{P}_M^F\cap\{\mu:c\leq V_e(\mu)/m\}\).
2. **U2 unanimity R2.** Under `pi_H = 0`,
   \(W_2^U(\mu)=m^{-1}\max\{(1-\mu)(1-\alpha),V_e(\mu)-\alpha r\}\), with
   cutoff \(\mu_2^*=\alpha(r-1)/(r-\alpha)\).
3. **R1 architecture warning.** With `pi_H = 0` also in R2, a strict R1
   low-accepted/high-rejected aggressive branch collapses to a tie at
   \(h_A=\beta\alpha r\) for interior beliefs.

## Caveat Preserved

The majority result is a pass-branch result. The delayed branch outside
\(\mathcal{P}_M^F\) is not yet derived.
