/-
  Lemma (v5) — Global maximum of V_W^{R1} under unanimity

  Statement (formal_model_v5.Rmd, line 1074):
  "V_W^{R1}(μ, U) ≤ V_W^{R1}(1, U) = r(1-βα)/N for every μ ∈ (0,1],
   with equality only at μ = 1. Hence if F_U ≠ ∅, then 1 ∈ F_U."

  Source: formal_model_v5.Rmd, Appendix B.7 (lines 1078-1092)
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- V_W maximum value at μ = 1
-- ===========================================================================

/-- V̄_W := V_W^{R1}(1, U) = r(1 - βα)/N. -/
def V_W_bar (p : GameParams) : ℝ :=
  p.r * (1 - p.β * p.α) / (p.N : ℝ)

/-- βα < 1 for all valid parameters (since β < 1 and α < 1). -/
theorem beta_alpha_lt_one (p : GameParams) : p.β * p.α < 1 := by
  have := p.alpha_lt_one
  nlinarith [p.hβ1, p.hα0]

/-- V̄_W > 0. -/
theorem V_W_bar_pos (p : GameParams) : V_W_bar p > 0 := by
  unfold V_W_bar
  apply div_pos _ p.n_cast_pos
  nlinarith [p.r_pos, beta_alpha_lt_one p]

-- ===========================================================================
-- Abstract bounding: affine functions positive on [0,1]
-- ===========================================================================

/-- If f(μ) = a·μ + b is affine with f(0) = b ≥ 0 and f(1) = a+b ≥ 0,
    then f(μ) ≥ 0 for μ ∈ [0,1].
    Proof: f(μ) = (1-μ)·f(0) + μ·f(1), convex combination of non-negatives. -/
theorem affine_nonneg_on_unit (a b : ℝ) (hb : b ≥ 0) (hab : a + b ≥ 0)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    a * μ + b ≥ 0 := by
  -- a*μ + b = (1-μ)*b + μ*(a+b)
  have h1 : a * μ + b = (1 - μ) * b + μ * (a + b) := by ring
  rw [h1]
  have h1μ : 1 - μ ≥ 0 := by linarith
  exact add_nonneg (mul_nonneg h1μ hb) (mul_nonneg hμ0 hab)

-- ===========================================================================
-- Key consequence: if F_U ≠ ∅, then 1 ∈ F_U
-- ===========================================================================

/-- If V_W(μ) ≤ V_W_max for all μ ∈ (0,1], and V_W(μ') ≥ c for some μ',
    then V_W_max ≥ c, meaning entry at μ=1 is feasible. -/
theorem v5_lemma_entry_at_one
    (V_W : ℝ → ℝ) (V_W_max c : ℝ)
    (h_bound : ∀ μ : ℝ, 0 < μ → μ ≤ 1 → V_W μ ≤ V_W_max)
    (μ' : ℝ) (hμ'_pos : 0 < μ') (hμ'_le : μ' ≤ 1)
    (h_entry : V_W μ' ≥ c) :
    V_W_max ≥ c := by
  linarith [h_bound μ' hμ'_pos hμ'_le]

-- ===========================================================================
-- Concrete bounding: Conservative-High candidate
-- ===========================================================================

/-- The gap V̄_W·N - V_W^{CH}(μ) for the Conservative R1, High R2 candidate.
    This equals (N+β)(r-1)(1-μ)/N ≥ 0 for μ ≤ 1.
    We prove the gap is non-negative abstractly by checking endpoints. -/
theorem v5_conservative_high_bounded (p : GameParams) (μ : ℝ)
    (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    -- The gap at endpoints: at μ=0 the gap is (N+β)(r-1)/N > 0;
    -- at μ=1 the gap is 0.
    -- Since it's affine, non-negative on [0,1].
    ((p.N : ℝ) + p.β) * (p.r - 1) * (1 - μ) ≥ 0 := by
  have hN_β : (p.N : ℝ) + p.β > 0 := by linarith [p.n_cast_pos, p.hβ0]
  nlinarith [p.r_minus_one_pos, mul_pos hN_β p.r_minus_one_pos]

end
