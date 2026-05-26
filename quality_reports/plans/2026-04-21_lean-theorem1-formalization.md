# Plan: Formalize Theorem 1 (Threshold Prior) in Lean 4

**Status**: COMPLETED
**Date**: 2026-04-21

## Objective

Formalize the 4-case structure of Theorem 1 (single-crossing property of institutional comparison) using a modular approach: assume concavification properties as hypotheses, prove the logical spine.

## Approach

**Modular**: Concave envelopes are deep real analysis. We assume their properties (what cav equals in each region) and prove the 4-case logical structure. This verifies there are no gaps in the case analysis.

## Files

```
FormalProofs/Theorem1/
├── Hypotheses.lean     ← Theorem1Hyps structure, D_low, λ_M > 0, basic lemmas
└── Proof.lean          ← Step 1 + Cases (a)-(d) + single-crossing + final theorem
```

## Verification

`cd formal_proofs && lake build 2>&1` — zero sorry, zero custom axioms.
