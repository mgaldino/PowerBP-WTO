# Lean Verification Dashboard

**Project**: The Hegemon's Choice of Consensus
**Last updated**: 2026-04-18
**Paper file**: formal_model.Rmd
**Build status**: PASSING (zero sorry, zero custom axioms)

## Summary

| Status | Count |
|--------|-------|
| Verified (components) | 17 |
| Has sorry | 0 |
| Partially formalized | 1 (Prop 1 — single-crossing monotonicity pending) |
| Not formalized | 11 |
| **Total results in paper** | **12** |

## Detailed Status

| # | Result | Paper Line | Lean File | Status | Notes |
|---|--------|-----------|-----------|--------|-------|
| L1 | Lemma 1 (Linearity, Package A) | 163 | Prop1.lean | VERIFIED | `affine_of_proportional_to_Ve` (general N) |
| L2 | Lemma 2 (Screening cutoff) | 238 | Prop1.lean + SingleCrossing.lean | PARTIAL | Existence via IVT verified; uniqueness needs monotonicity assembly |
| L3 | Lemma 3 (Jump discontinuity) | 254 | Prop1.lean | VERIFIED | `jump_positive_general` (general N) |
| P1 | Proposition 1 (General-N screening) | 271 | Prop1.lean | PARTIAL | Affinity + existence + jump verified; uniqueness conditional on single-crossing hypothesis |
| P2 | Proposition 2 (All-or-none entry) | 285 | — | NOT FORMALIZED | |
| L4 | Lemma 4 (Entry easier under consensus) | 313 | — | NOT FORMALIZED | |
| P3 | Proposition 3 (Optimal persuasion) | 350 | — | NOT FORMALIZED | |
| R1 | Remark 1 (Geometric characterization) | 364 | — | NOT FORMALIZED | Qualitative, may not need formalization |
| P4 | Proposition 4 (Dominance condition) | 374 | — | NOT FORMALIZED | |
| T1 | Theorem 1 (Main result) | 387 | — | NOT FORMALIZED | Depends on P1-P4 |
| R2 | Remark 2 (Decomposition) | 411 | — | NOT FORMALIZED | Qualitative |
| B1 | Lemma B.1 (Single-crossing, general N) | 525 | SingleCrossing.lean | PARTIAL | Q_a < 0, Q_c < 0, G' numerator < 0 all verified; monotonicity assembly + piecewise Δ pending |

## Verified Components (SingleCrossing.lean)

| Component | Theorem | Status |
|-----------|---------|--------|
| Branch point m_N > 0 | `m_N_pos` | VERIFIED |
| Branch point m_N ≤ 1 | `m_N_le_one` | VERIFIED |
| g_a quadratic < 0 on [0,1] | `g_a_neg` | VERIFIED |
| Q_a polynomial < 0 on [0, m_N] | `Q_a_neg` | VERIFIED |
| g_c quadratic < 0 on [0,1] | `g_c_neg` | VERIFIED |
| Q_c polynomial < 0 on [m_N, 1) | `Q_c_neg` | VERIFIED |
| G' numerator < 0 (aggressive) | `G_deriv_num_a_neg` | VERIFIED |
| G' numerator < 0 (conservative) | `G_deriv_num_c_neg` | VERIFIED |
| Δ(0) > 0 (boundary) | `boundary_at_zero_pos` | VERIFIED |
| Δ(1) < 0 (boundary) | `boundary_at_one_neg` | VERIFIED |
| Jump β(r-1)/N > 0 | `G_jump_pos` | VERIFIED |

## Next Steps

1. **Connect G' < 0 to strict monotonicity** — use `strictAntiOn_of_deriv_neg` or direct proof
2. **Assemble piecewise single-crossing** — combine aggressive branch + jump + conservative branch
3. **Define concrete Δ and prove continuity** — instantiate the abstract IVT result
4. **Close `prop1_complete`** — final theorem with no hypotheses beyond GameParams

## Architecture

```
Basic.lean          → GameParams, V_e, casting helpers
ContinuationValues.lean → Ω^a, Ω^c, φ^a, φ^c, m_N, Q_a, Q_c, G' numerators, boundaries
SingleCrossing.lean → Q_a < 0, Q_c < 0, G' < 0, boundary conditions, jump > 0
Prop1.lean          → Affinity, IVT existence, conditional uniqueness, jump > 0, combined Prop 1
```
