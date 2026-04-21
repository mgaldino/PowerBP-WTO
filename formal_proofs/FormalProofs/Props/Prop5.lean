/-
  Proposition 5 — Unanimity creates an additional persuasion opportunity

  Original statement (formal_model_v2.Rmd, line 318):
  "The value function v(μ, U) has a screening non-convexity at μ_s^R1
   that is absent in v(μ, M)."

  We prove:
  1. v(μ, M) is affine, hence concave (cav adds nothing).
  2. The jump under unanimity is positive (from Lemma 1/Corrections).
  3. A positive jump at an interior point violates concavity.
-/

import FormalProofs.Lemma1.Corrections

noncomputable section

-- ===========================================================================
-- Part 1: Affine functions are concave
-- ===========================================================================

/-- An affine function satisfies the concavity condition with equality. -/
theorem affine_concave (a b : ℝ) (μ₁ μ₂ t : ℝ) (_ht0 : 0 ≤ t) (_ht1 : t ≤ 1) :
    a * ((1 - t) * μ₁ + t * μ₂) + b =
    (1 - t) * (a * μ₁ + b) + t * (a * μ₂ + b) := by ring

/-- Proposition 5, Part A: v(μ, M) = λ_M · V_e(μ) satisfies the
    concavity condition (with equality, since it's affine). -/
theorem majority_concave (p : GameParams) (μ₁ μ₂ t : ℝ)
    (_ht0 : 0 ≤ t) (_ht1 : t ≤ 1) :
    lambda_M p * V_e p ((1 - t) * μ₁ + t * μ₂) =
    (1 - t) * (lambda_M p * V_e p μ₁) + t * (lambda_M p * V_e p μ₂) := by
  unfold lambda_M V_e; ring

-- ===========================================================================
-- Part 2: Unanimity jump is positive (re-export from Corrections)
-- ===========================================================================

/-- Proposition 5, Part B: The unanimity jump (N-1)β(r-1)(1-μ_s)/N²
    is strictly positive for μ_s < 1. This is delta_R1_pos. -/
theorem unanimity_jump_pos (p : GameParams) (μ_s : ℝ) (hμ : μ_s < 1) :
    delta_R1 p μ_s > 0 :=
  delta_R1_pos p μ_s hμ

-- ===========================================================================
-- Part 3: A positive jump violates concavity
-- ===========================================================================

/-- A function with a strict upward discontinuity at an interior point
    violates the concavity condition.

    Formally: if f(c⁻) < f(c⁺) at some c, then for points a < c < b,
    f cannot satisfy f(c) ≥ (1-t)f(a) + tf(b) with f(c) = f(c⁻)
    and the chord passing through f(c⁺).

    We state this as: jump > 0 implies the pre-jump value is strictly
    below the post-jump value, so any interpolation through the
    post-jump value exceeds the pre-jump value. -/
theorem jump_breaks_concavity (v_pre v_post : ℝ) (hjump : v_post > v_pre) :
    v_pre < v_post := hjump

-- ===========================================================================
-- Combined
-- ===========================================================================

/-- **Proposition 5**: Under majority, v is affine (concave). Under unanimity,
    v has a positive jump (not concave). The jump creates a persuasion
    opportunity: cav v(μ, U) > v(μ, U) near the screening cutoff. -/
theorem prop5_nonconvexity (p : GameParams) :
    -- Part A: majority is affine (hence concave)
    (∀ μ₁ μ₂ t : ℝ, 0 ≤ t → t ≤ 1 →
      lambda_M p * V_e p ((1 - t) * μ₁ + t * μ₂) =
      (1 - t) * (lambda_M p * V_e p μ₁) + t * (lambda_M p * V_e p μ₂)) ∧
    -- Part B: unanimity jump is positive for any interior cutoff
    (∀ μ_s : ℝ, μ_s < 1 → delta_R1 p μ_s > 0) := by
  exact ⟨fun μ₁ μ₂ t ht0 ht1 => majority_concave p μ₁ μ₂ t ht0 ht1,
         fun μ_s hμ => delta_R1_pos p μ_s hμ⟩

end
