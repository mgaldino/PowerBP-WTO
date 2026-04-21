/-
  Lemma 1 — Correction properties

  Properties of δ_R2 and δ_R1:
  - δ_R2(μ_s^R2) = 0 (continuity at R2 cutoff)
  - δ_R1(μ) ≥ 0 for μ ≤ 1 (R1 correction only adds positivity)
  - δ_R1(1) = 0

  Source: notes/2026-04-21_lemma1_complete_proof.md, Step 1 properties
-/

import FormalProofs.Lemma1.Definitions

noncomputable section

-- ===========================================================================
-- Part 1: δ_R2(μ_s^R2) = 0
-- ===========================================================================

/-- δ_R2 vanishes at the R2 screening cutoff:
    δ_R2(μ_s^R2) = 0.
    This ensures continuity of D at μ_s^R2. -/
theorem delta_R2_at_cutoff (p : GameParams) :
    delta_R2 p (mu_s_R2 p) = 0 := by
  unfold delta_R2 mu_s_R2
  have hr_α := p.r_minus_alpha_pos
  field_simp
  ring

-- ===========================================================================
-- Part 2: δ_R1(μ) ≥ 0 for μ ≤ 1
-- ===========================================================================

/-- δ_R1(μ) ≥ 0 for μ ≤ 1.
    All factors are non-negative: (N-1) > 0, β > 0, (r-1) > 0, (1-μ) ≥ 0. -/
theorem delta_R1_nonneg (p : GameParams) (μ : ℝ) (hμ : μ ≤ 1) :
    delta_R1 p μ ≥ 0 := by
  unfold delta_R1
  apply div_nonneg _ (le_of_lt p.n_sq_pos)
  nlinarith [p.n_minus_one_pos, p.hβ0, p.r_minus_one_pos,
             mul_pos p.n_minus_one_pos p.hβ0,
             mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_minus_one_pos]

/-- δ_R1(μ) > 0 for μ < 1. -/
theorem delta_R1_pos (p : GameParams) (μ : ℝ) (hμ : μ < 1) :
    delta_R1 p μ > 0 := by
  unfold delta_R1
  apply div_pos _ p.n_sq_pos
  have h1μ : 1 - μ > 0 := by linarith
  nlinarith [p.n_minus_one_pos, p.hβ0, p.r_minus_one_pos,
             mul_pos p.n_minus_one_pos p.hβ0,
             mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_minus_one_pos]

-- ===========================================================================
-- Part 3: δ_R1(1) = 0
-- ===========================================================================

/-- δ_R1(1) = 0: the R1 correction vanishes at μ = 1. -/
theorem delta_R1_at_one (p : GameParams) : delta_R1 p 1 = 0 := by
  unfold delta_R1; ring

-- ===========================================================================
-- Part 4: D_I(0) > 0 (re-exported from DbasePositive for convenience)
-- ===========================================================================

-- D_I_zero_pos is in DbasePositive.lean

-- ===========================================================================
-- Part 5: δ_R2 is affine (for Region I interpolation)
-- ===========================================================================

/-- δ_R2 is affine in μ. -/
theorem delta_R2_affine (p : GameParams) :
    ∀ μ : ℝ, ∃ a b : ℝ, delta_R2 p μ = a * μ + b := by
  intro μ
  use ((p.N : ℝ) - 1) * p.β * (p.r - p.α) / (p.N : ℝ) ^ 2,
      -((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1) / (p.N : ℝ) ^ 2
  unfold delta_R2; ring

/-- δ_R2(0) = -(N-1)βα(r-1)/N² < 0. -/
theorem delta_R2_at_zero (p : GameParams) :
    delta_R2 p 0 = -((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1) / (p.N : ℝ) ^ 2 := by
  unfold delta_R2; ring

end
