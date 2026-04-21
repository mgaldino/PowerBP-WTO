/-
  Proposition 6 — Non-monotonic effect of agenda influence

  Original statement (formal_model_v2.Rmd, line 714):
  "J(p_H) = (1 - μ_s^R1(p_H)) · (1 - p_H) · p_H · β · (r-1).
   Holding μ_s^R1 fixed, J is maximized at p_H = 1/2."
-/

import FormalProofs.Basic

noncomputable section

/-- The jump function with bias: J(p_H) = (1-μ_s)·(1-p_H)·p_H·β·(r-1). -/
def J_bias (p : GameParams) (μ_s p_H : ℝ) : ℝ :=
  (1 - μ_s) * (1 - p_H) * p_H * p.β * (p.r - 1)

/-- J(p_H) > 0 for p_H ∈ (0, 1) and μ_s < 1. -/
theorem J_bias_pos (p : GameParams) (μ_s p_H : ℝ)
    (hμ : μ_s < 1) (hp0 : 0 < p_H) (hp1 : p_H < 1) :
    J_bias p μ_s p_H > 0 := by
  unfold J_bias
  have h1 : 1 - μ_s > 0 := by linarith
  have h2 : 1 - p_H > 0 := by linarith
  have h3 : (1 - μ_s) * (1 - p_H) > 0 := mul_pos h1 h2
  have h4 : (1 - μ_s) * (1 - p_H) * p_H > 0 := mul_pos h3 hp0
  have h5 : (1 - μ_s) * (1 - p_H) * p_H * p.β > 0 := mul_pos h4 p.hβ0
  exact mul_pos h5 p.r_minus_one_pos

/-- J(0) = 0. -/
theorem J_bias_at_zero (p : GameParams) (μ_s : ℝ) :
    J_bias p μ_s 0 = 0 := by unfold J_bias; ring

/-- J(1) = 0. -/
theorem J_bias_at_one (p : GameParams) (μ_s : ℝ) :
    J_bias p μ_s 1 = 0 := by unfold J_bias; ring

/-- Key algebraic fact: p_H(1-p_H) ≤ 1/4 for all p_H ∈ [0,1].
    Proof: 1/4 - p_H(1-p_H) = (p_H - 1/2)² ≥ 0. -/
theorem product_le_quarter (p_H : ℝ) (_hp0 : 0 ≤ p_H) (_hp1 : p_H ≤ 1) :
    p_H * (1 - p_H) ≤ 1 / 4 := by
  nlinarith [sq_nonneg (p_H - 1/2)]

/-- Proposition 6: J(1/2) ≥ J(p_H) for all p_H ∈ [0,1] (holding μ_s fixed).
    The quadratic p_H(1-p_H) is maximized at 1/2. -/
theorem prop6_maximized_at_half (p : GameParams) (μ_s p_H : ℝ)
    (hμ : μ_s < 1) (_hp0 : 0 ≤ p_H) (_hp1 : p_H ≤ 1) :
    J_bias p μ_s p_H ≤ J_bias p μ_s (1 / 2) := by
  unfold J_bias
  -- Factor out C = (1-μ_s)·β·(r-1) > 0
  -- J(p_H) = C · p_H · (1-p_H), J(1/2) = C/4
  -- Need: C · p_H · (1-p_H) ≤ C/4, i.e., p_H(1-p_H) ≤ 1/4
  have hC1 : 1 - μ_s > 0 := by linarith
  have hC : (1 - μ_s) * p.β * (p.r - 1) > 0 :=
    mul_pos (mul_pos hC1 p.hβ0) p.r_minus_one_pos
  nlinarith [sq_nonneg (p_H - 1/2), product_le_quarter p_H _hp0 _hp1]

/-- 1/N < 1/2 for N ≥ 3: symmetric proposals don't maximize the jump. -/
theorem symmetric_below_half (p : GameParams) :
    1 / (p.N : ℝ) < 1 / 2 := by
  have hN_pos := p.n_cast_pos
  have h2N : (2 : ℝ) < (p.N : ℝ) := by linarith [p.n_cast_ge_three]
  -- 1/N < 1/2 ↔ 2 < N. Clear denominators manually:
  -- 1/N < 1/2 iff 1*2 < 1*N iff 2 < N
  have key : 2 * (1 / (p.N : ℝ)) < 1 := by
    rw [mul_one_div, div_lt_one hN_pos]; linarith
  linarith

end
