# Plan: Formalize Lemma 1 (Conditional Payoff Dominance) in Lean 4

**Status**: COMPLETED
**Date**: 2026-04-21

## Objective

Formalize the complete proof of Lemma 1 (Conditional Payoff Dominance) in Lean 4 with zero sorry and zero custom axioms. This is the paper's core result: under α < α*(N,β), unanimity gives H strictly higher continuation payoffs than majority for all μ ∈ (0,1].

## Source references

- Proof: `notes/2026-04-21_lemma1_complete_proof.md`
- Paper body: `formal_model_v2.Rmd` lines 494-524
- Paper appendix B.5: `formal_model_v2.Rmd` lines 841-879

## Approach: 5 steps, sequential builds

### Step 0: Handle old files
- Remove imports of `ContinuationValues`, `SingleCrossing`, `Prop1` from `FormalProofs.lean`
- Keep files on disk (they're for the old model)

### Step 1: Update `Basic.lean` for model v2
- Replace `g`, `c` with `α` (with constraints `0 < α`, `α*r < 1`)
- Add `q` (majority threshold), `P`, `Q`, `d_star`, `alpha_star`
- Keep `V_e`, `V_theta`, casting helpers
- Prove `d_star > 0` from parameter constraints
- **Build checkpoint**

### Step 2: `Lemma1/Definitions.lean`
- Define `lambda_M`, `D_base`, `delta_R2`, `delta_R1`, `mu_s_R2`
- Define `d_0`, `alpha_bar_0`
- Basic evaluation lemmas (D_base at 0 and 1)
- **Build checkpoint**

### Step 3: `Lemma1/DbasePositive.lean` (hardest step)
- Prove `D_base(1) > 0` under `α < α*`
- Prove `d_star - d_0 = β*(N-1)²*(r-1) > 0`
- Prove `D_I(0) > 0` via threshold nesting (case split on sign of d_0)
- Prove `D_base(0) > D_I(0) > 0`
- Prove `D_base(μ) > 0` for all μ ∈ [0,1] via affine interpolation
- **Build checkpoint**

### Step 4: `Lemma1/Corrections.lean`
- Prove `delta_R2(mu_s_R2) = 0`
- Prove `delta_R1(μ) ≥ 0` for μ ≤ 1
- Prove `delta_R1(1) = 0`
- **Build checkpoint**

### Step 5: `Lemma1/Assembly.lean`
- Region I: D_I affine with positive endpoints → positive
- Region II: D = D_base > 0
- Region III: D = D_base + δ_R1 ≥ D_base > 0
- Final theorem: `D(μ) > 0` for all μ ∈ (0,1]
- **Build checkpoint**

## File structure

```
formal_proofs/FormalProofs/
├── Basic.lean              ← UPDATE
├── Lemma1/
│   ├── Definitions.lean    ← NEW
│   ├── DbasePositive.lean  ← NEW (hardest)
│   ├── Corrections.lean    ← NEW
│   └── Assembly.lean       ← NEW
├── ContinuationValues.lean ← keep on disk, remove from build
├── SingleCrossing.lean     ← keep on disk, remove from build
└── Prop1.lean              ← keep on disk, remove from build
```

## Key risks

1. **α < α* ↔ P - Q(1-β) > 0**: requires clearing denominator of α* fraction. Strategy: `field_simp` + `nlinarith`.
2. **D_base(0) > 0**: threshold nesting argument with case split. Strategy: careful algebraic steps.
3. **Nat/Real casting for q**: `q = N/2 + 1` involves floor division. Need casting lemmas.

## Constraints

- Zero sorry, zero custom axioms
- If any step gets stuck, stop and report (don't use sorry)
- Lean 4 v4.29.1 + Mathlib v4.29.1

## Verification

After each step: `cd formal_proofs && lake build 2>&1`
Final check: grep for `sorry` and `axiom` in all .lean files.
