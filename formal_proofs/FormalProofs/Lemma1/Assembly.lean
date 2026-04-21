/-
  Lemma 1 — Assembly (Conditional Payoff Dominance)

  Combines D_base > 0 (backbone positivity) with correction properties
  to prove D(μ) > 0 for every μ ∈ (0,1] across all three regions.

  Original statement (formal_model_v2.Rmd, lines 494-503):
  "For α < α*(N, β) and every μ ∈ (0,1],
   E_θ[V_H^{R1}(θ, μ, U)] > E_θ[V_H^{R1}(θ, μ, M)]."

  Source: notes/2026-04-21_lemma1_complete_proof.md, Step 3
-/

import FormalProofs.Lemma1.DbasePositive
import FormalProofs.Lemma1.Corrections

noncomputable section

-- ===========================================================================
-- Region I: D_I(μ) = D_base(μ) + δ_R2(μ) > 0 for μ ∈ [0, μ_s^R2]
-- ===========================================================================

/-- Region I: D_I(μ) > 0 for μ ∈ [0, 1].
    D_I is affine. D_I(0) > 0 (from DbasePositive). D_I(1) = D_base(1) + δ_R2(1).
    We use the convex combination: D_I(μ) = (1-μ)·D_I(0) + μ·D_I(1). -/
theorem D_I_pos_interval (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_I p μ > 0 := by
  -- D_I(μ) = (1-μ)·D_I(0) + μ·D_I(1) (affine)
  rw [D_I_convex p μ]
  have h0 := D_I_zero_pos p hα
  -- D_I(1) = D_base(1) + δ_R2(1). We show D_I(1) ≥ D_base(1) or compute directly.
  -- Actually, D_I(1) = D_base(1) + δ_R2(1).
  -- δ_R2(1) = (N-1)β[(r-α) - α(r-1)]/N² = (N-1)β(r - αr)/N² = (N-1)βr(1-α)/N²
  -- This is positive, so D_I(1) > D_base(1) > 0.
  have h1 : D_I p 1 > 0 := by
    unfold D_I
    have hdb := D_base_one_pos p hα
    have : delta_R2 p 1 ≥ 0 := by
      unfold delta_R2
      apply div_nonneg _ (le_of_lt p.n_sq_pos)
      -- (N-1) * β * (1*(r-α) - α*(r-1)) = (N-1) * β * (r - αr) = (N-1)*β*r*(1-α)
      nlinarith [p.n_minus_one_pos, p.hβ0, p.r_pos, p.one_minus_alpha_pos,
                 mul_pos p.n_minus_one_pos p.hβ0,
                 mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_pos]
    linarith
  have h1μ : 1 - μ ≥ 0 := by linarith
  nlinarith [mul_nonneg h1μ (le_of_lt h0), mul_nonneg hμ0 (le_of_lt h1)]

-- ===========================================================================
-- Region II: D(μ) = D_base(μ) > 0
-- ===========================================================================

-- This is directly D_base_pos from DbasePositive.lean.
-- No additional theorem needed.

-- ===========================================================================
-- Region III: D(μ) = D_base(μ) + δ_R1(μ) > 0
-- ===========================================================================

/-- Region III: D_base(μ) + δ_R1(μ) > 0 for μ ∈ [0, 1].
    D_base(μ) > 0 and δ_R1(μ) >= 0, so their sum is positive. -/
theorem D_base_plus_delta_R1_pos (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_base p μ + delta_R1 p μ > 0 := by
  have hdb := D_base_pos p hα μ hμ0 hμ1
  have hdr := delta_R1_nonneg p μ hμ1
  linarith

-- ===========================================================================
-- Main theorem: D(μ) > 0 across all regions
-- ===========================================================================

/-- Lemma 1, Part A (Backbone dominance):
    D_base(μ) > 0 for all μ ∈ [0, 1] under α < α*.

    This alone establishes that the "conservative R2 + aggressive R1"
    regime (Region II) has unanimity dominating majority. -/
theorem lemma1_backbone (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 :=
  D_base_pos p hα μ hμ0 hμ1

/-- Lemma 1, Part B (Region I — aggressive R2):
    D_I(μ) = D_base(μ) + δ_R2(μ) > 0 for μ ∈ [0, 1].

    Even though δ_R2 can be negative (it corrects for aggressive R2 screening),
    D_I remains positive because it is affine with D_I(0) > 0 and D_I(1) > 0. -/
theorem lemma1_region_I (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_I p μ > 0 :=
  D_I_pos_interval p hα μ hμ0 hμ1

/-- Lemma 1, Part C (Region III — conservative R1):
    D_base(μ) + δ_R1(μ) > 0 for μ ∈ [0, 1].

    δ_R1 ≥ 0 everywhere, so this only strengthens the backbone. -/
theorem lemma1_region_III (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_base p μ + delta_R1 p μ > 0 :=
  D_base_plus_delta_R1_pos p hα μ hμ0 hμ1

/-- **Lemma 1 (Conditional Payoff Dominance of Unanimity)**

    For α < α*(N, β) and every μ ∈ (0, 1]:
    E_θ[V_H^{R1}(θ, μ, U)] > E_θ[V_H^{R1}(θ, μ, M)].

    The difference D(μ) decomposes piecewise across three regions.
    In every region, D(μ) > 0:
    - Region I  (μ < μ_s^R2):         D = D_base + δ_R2 > 0
    - Region II (μ_s^R2 < μ < μ_s^R1): D = D_base > 0
    - Region III (μ > μ_s^R1):         D = D_base + δ_R1 > 0

    Since D_base > 0 on [0,1], D_I > 0 on [0,1], and D_base + δ_R1 > 0 on [0,1],
    the full difference is positive regardless of which region μ falls in.

    This theorem establishes the result by noting that for any μ ∈ (0,1],
    the minimum possible D(μ) across all three regional formulas is bounded
    below by min(D_I(μ), D_base(μ), D_base(μ) + δ_R1(μ)), all of which
    are positive. -/
theorem lemma1_conditional_payoff_dominance (p : GameParams)
    (hα : p.α < alpha_star p) (μ : ℝ) (hμ0 : 0 < μ) (hμ1 : μ ≤ 1) :
    -- In whichever region μ falls, D(μ) > 0.
    -- We express this as: D_base(μ) > 0 ∧ D_I(μ) > 0 ∧ D_base(μ) + δ_R1(μ) > 0.
    D_base p μ > 0 ∧ D_I p μ > 0 ∧ (D_base p μ + delta_R1 p μ > 0) := by
  have hμ0' : 0 ≤ μ := le_of_lt hμ0
  exact ⟨D_base_pos p hα μ hμ0' hμ1,
         D_I_pos_interval p hα μ hμ0' hμ1,
         D_base_plus_delta_R1_pos p hα μ hμ0' hμ1⟩

end
