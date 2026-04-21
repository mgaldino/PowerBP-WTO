# Lean Verification Dashboard

**Project**: Informational Power: Bayesian Persuasion, Legislative Bargaining, and Institutional Design
**Last updated**: 2026-04-21
**Paper file**: formal_model_v2.Rmd
**Model version**: v2 (alpha outside option, no g/c)
**Build status**: PASSING (8262 jobs, 0 errors, 0 warnings)
**Lean**: v4.29.1 + Mathlib v4.29.1

## Summary

| Status | Count |
|--------|-------|
| Verified (full proof) | 7 |
| Verified (modular) | 1 |
| **Total results in paper** | **8** |

**All 8 results verified. Zero sorry. Zero custom axioms.**

## Detailed Status

| # | Result | Paper Line | Lean Files | Status | Notes |
|---|--------|-----------|------------|--------|-------|
| 1 | **Proposition 1** (Majority: no screening) | 183 | Props/Prop1.lean | **VERIFIED** | Affine = concave |
| 2 | **Proposition 2** (Overpayment under unanimity) | 221 | Props/Prop2.lean | **VERIFIED** | alpha*r > alpha |
| 3 | **Proposition 3** (R1 screening cutoff) | 242 | Props/Prop3.lean | **VERIFIED** | IVT + single-crossing |
| 4 | **Proposition 4** (Screening creates informational rent) | 262 | Props/Prop4.lean | **VERIFIED** | = delta_R1_pos |
| 5 | **Proposition 5** (Additional persuasion opportunity) | 318 | Props/Prop5.lean | **VERIFIED** | Affine concave + jump |
| 6 | **Lemma 1** (Conditional payoff dominance) | 499 | Lemma1/*.lean | **VERIFIED** | Full proof, 14 theorems |
| 7 | **Theorem 1** (Threshold prior) | 560 | Theorem1/*.lean | **VERIFIED (modular)** | 4 cases, single-crossing |
| 8 | **Proposition 6** (Non-monotonic agenda influence) | 714 | Props/Prop6.lean | **VERIFIED** | AM-GM, 1/N < 1/2 |

## Verified Results Detail

### Lemma 1 (Conditional Payoff Dominance) — VERIFIED

**Statement**: For alpha < alpha*(N, beta) and every mu in (0,1], E[V_H(mu, U)] > E[V_H(mu, M)].

**Proof method**: Full algebraic proof from model parameters. No sorry, no custom axioms.

**Key theorems** (14 total):
- `d_star_pos`, `alpha_star_pos` — alpha* well-defined
- `P_minus_Q_pos` — key equivalence: alpha < alpha* iff P - Q(1-beta) > 0
- `D_base_one_pos`, `D_base_zero_pos` — endpoint positivity (threshold nesting for mu=0)
- `D_base_pos` — backbone positive on [0,1] via affine interpolation
- `D_I_zero_pos`, `D_I_pos_interval` — Region I (aggressive R2) positive
- `delta_R2_at_cutoff` — delta_R2 vanishes at mu_s_R2
- `delta_R1_nonneg`, `delta_R1_pos` — R1 correction non-negative
- `lemma1_conditional_payoff_dominance` — final assembly

**Files**: Basic.lean, Lemma1/{Definitions, DbasePositive, Corrections, Assembly}.lean

### Theorem 1 (Threshold Prior) — VERIFIED (modular)

**Statement**: 4-case characterization of cav v(p, U) vs cav v(p, M) with single-crossing property.

**Proof method**: Modular — concavification properties assumed via `Theorem1Hyps` structure. Logical spine of 4-case proof fully verified.

**What is assumed** (Theorem1Hyps):
- Entry thresholds tau_U, tau_M with 0 <= tau_M <= tau_U < 1
- Slope S_U > 0
- Step 1 link: S_U * tau_U > lambda_M * V_e(tau_U) when tau_U > 0

**What is proved** (12 theorems):
- `lambda_M_pos` — majority payoff coefficient positive
- `D_low_slope_pos` — comparison function has positive slope
- `p_star_pos`, `p_star_lt_tau_U`, `D_low_at_p_star` — crossing point properties
- `case_a` — tau_U = 0: unanimity dominates (via Lemma 1)
- `case_b` — tau_M = 0 < tau_U: unique crossing at p*
- `case_c` — S_U > S_M: unanimity dominates
- `case_d` — S_U <= S_M: unique crossing at p*
- `theorem1_single_crossing` — combined single-crossing property

**Files**: Theorem1/{Hypotheses, Proof}.lean

## File Structure

```
formal_proofs/FormalProofs/
├── Basic.lean              — Model v2 params (GameParams with alpha)
├── Lemma1/
│   ├── Definitions.lean    — D_base, delta_R2, delta_R1, algebraic identities
│   ├── DbasePositive.lean  — D_base > 0 on [0,1] (heart of Lemma 1)
│   ├── Corrections.lean    — delta_R2(mu_s_R2) = 0, delta_R1 >= 0
│   └── Assembly.lean       — All 3 regions -> D(mu) > 0
├── Theorem1/
│   ├── Hypotheses.lean     — Theorem1Hyps structure, D_low, p*
│   └── Proof.lean          — Cases (a)-(d), single-crossing
└── Props/
    ├── Prop1.lean          — Majority affine (no screening)
    ├── Prop2.lean          — Overpayment under unanimity
    ├── Prop3.lean          — R1 cutoff existence + uniqueness
    ├── Prop4.lean          — Jump positivity
    ├── Prop5.lean          — Non-convexity (affine + jump)
    └── Prop6.lean          — Agenda influence (AM-GM)
```
