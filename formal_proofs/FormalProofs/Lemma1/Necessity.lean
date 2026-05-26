/-
  Lemma 1 — Necessity direction

  Proves: α ≥ α*(N, β) ⟹ ∃ μ ∈ (0,1] such that D(μ) ≤ 0.

  Specifically, at μ = 1 (Region III):
  - δ_R1(1) = 0          (already in Corrections.lean)
  - D(1) = D_base(1)
  - D_base(1) = r·[P - Q(1-β)] / N²
  - α ≥ α* ⟹ P - Q(1-β) ≤ 0 ⟹ D_base(1) ≤ 0

  Source: notes/2026-04-22_alpha_star_iff.md
-/

import FormalProofs.Lemma1.Definitions
import FormalProofs.Lemma1.Corrections

noncomputable section

-- ===========================================================================
-- Part 1: α ≥ α* implies P - Q(1-β) ≤ 0
-- ===========================================================================

/-- α ≥ α* implies P - Q(1-β) ≤ 0.
    Proof: α ≥ β(q-1)/d_star means α·d_star ≥ β(q-1) (since d_star > 0).
    By the identity P - Q(1-β) = β(q-1) - α·d_star, we get P - Q(1-β) ≤ 0. -/
theorem P_minus_Q_nonpos (p : GameParams) (hα : p.α ≥ alpha_star p) :
    p.P - p.Q * (1 - p.β) ≤ 0 := by
  rw [P_minus_Q_one_minus_beta]
  have hd := d_star_pos p
  -- Convert ≥ to ≤ explicitly so rewrite can find the pattern
  have h : alpha_star p ≤ p.α := hα
  unfold alpha_star at h
  -- h : p.β * (↑p.q - 1) / d_star p ≤ p.α
  rw [div_le_iff₀ hd] at h
  -- h : p.β * (↑p.q - 1) ≤ p.α * d_star p
  linarith

-- ===========================================================================
-- Part 2: D_base(1) ≤ 0 when α ≥ α*
-- ===========================================================================

/-- D_base(1) ≤ 0 under α ≥ α*. -/
theorem D_base_one_nonpos (p : GameParams) (hα : p.α ≥ alpha_star p) :
    D_base p 1 ≤ 0 := by
  rw [D_base_at_one]
  apply div_nonpos_of_nonpos_of_nonneg
  · exact mul_nonpos_of_nonneg_of_nonpos (le_of_lt p.r_pos) (P_minus_Q_nonpos p hα)
  · exact le_of_lt p.n_sq_pos

-- ===========================================================================
-- Part 3: Region III value at μ = 1 is ≤ 0
-- ===========================================================================

/-- In Region III at μ = 1: D_base(1) + δ_R1(1) ≤ 0.
    Since δ_R1(1) = 0, this reduces to D_base(1) ≤ 0. -/
theorem D_region_III_at_one_nonpos (p : GameParams) (hα : p.α ≥ alpha_star p) :
    D_base p 1 + delta_R1 p 1 ≤ 0 := by
  rw [delta_R1_at_one]
  simp only [add_zero]
  exact D_base_one_nonpos p hα

-- ===========================================================================
-- Part 4: Necessity — ∃ μ ∈ (0,1] where conditional dominance fails
-- ===========================================================================

/-- **Necessity for Lemma 1**: If α ≥ α*(N, β), then there exists μ ∈ (0,1]
    such that the Region III payoff difference D_base(μ) + δ_R1(μ) ≤ 0.

    The witness is μ = 1, where δ_R1(1) = 0 and D_base(1) ≤ 0.
    This means unanimity does NOT strictly dominate majority at μ = 1. -/
theorem lemma1_necessity (p : GameParams) (hα : p.α ≥ alpha_star p) :
    ∃ μ : ℝ, 0 < μ ∧ μ ≤ 1 ∧ D_base p μ + delta_R1 p μ ≤ 0 :=
  ⟨1, one_pos, le_refl 1, D_region_III_at_one_nonpos p hα⟩

end
