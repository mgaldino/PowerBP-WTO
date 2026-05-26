/-
  Lemma 1 (Iterative) — Conditional Payoff Dominance of Unanimity

  Re-formalização usando approach iterativo (tactic loop) para comparação
  com a versão batch original.

  Enunciado (formal_model_v2.Rmd, Appendix B.5):
  "For α < α*(N, β) and every μ ∈ (0,1],
   E_θ[V_H^{R1}(θ, μ, U)] > E_θ[V_H^{R1}(θ, μ, M)]."

  Importa definições de Definitions.lean, re-prova todos os resultados
  de suficiência iterativamente.
-/

import FormalProofs.Lemma1.Definitions

noncomputable section

-- ===========================================================================
-- 1. P - Q(1-β) > 0 under α < α*
-- ===========================================================================

theorem P_minus_Q_pos_iter (p : GameParams) (hα : p.α < alpha_star p) :
    p.P - p.Q * (1 - p.β) > 0 := by
  rw [P_minus_Q_one_minus_beta]
  have hd := d_star_pos p
  unfold alpha_star at hα
  rw [lt_div_iff₀ hd] at hα
  linarith

-- ===========================================================================
-- 2. D_base(1) > 0
-- ===========================================================================

theorem D_base_one_pos_iter (p : GameParams) (hα : p.α < alpha_star p) :
    D_base p 1 > 0 := by
  rw [D_base_at_one]
  exact div_pos (mul_pos p.r_pos (P_minus_Q_pos_iter p hα)) p.n_sq_pos

-- ===========================================================================
-- 3. d_star - d_0 > 0 (threshold nesting)
-- ===========================================================================

theorem d_star_minus_d_0_pos_iter (p : GameParams) :
    d_star p - d_0 p > 0 := by
  rw [d_star_minus_d_0]
  have hN1 := p.n_minus_one_pos
  exact mul_pos (mul_pos p.hβ0 (sq_pos_of_pos hN1)) p.r_minus_one_pos

-- ===========================================================================
-- 4. D_I(0) > 0 (the hard case split)
-- ===========================================================================

theorem D_I_zero_pos_iter (p : GameParams) (hα : p.α < alpha_star p) :
    D_I p 0 > 0 := by
  rw [D_I_at_zero]
  apply div_pos _ p.n_sq_pos
  -- Case split: d_0 ≤ 0 ou d_0 > 0
  by_cases hd0 : d_0 p ≤ 0
  · -- Case 1: d_0 ≤ 0 → -α·d_0 ≥ 0 → β(q-1) - α·d_0 ≥ β(q-1) > 0
    nlinarith [mul_pos p.hβ0 p.q_cast_minus_one_pos, p.hα0]
  · -- Case 2: d_0 > 0 → use d_0 < d_star and α < α*
    push Not at hd0
    have hd_lt : d_0 p < d_star p := by linarith [d_star_minus_d_0_pos_iter p]
    have hβq : p.β * ((p.q : ℝ) - 1) > 0 := mul_pos p.hβ0 p.q_cast_minus_one_pos
    -- α* = β(q-1)/d_star < β(q-1)/d_0 (since d_0 < d_star, both positive)
    have h_astar_lt : alpha_star p < p.β * ((p.q : ℝ) - 1) / d_0 p := by
      unfold alpha_star
      exact div_lt_div_of_pos_left hβq hd0 hd_lt
    -- α < β(q-1)/d_0 → α · d_0 < β(q-1)
    have h_α_lt : p.α < p.β * ((p.q : ℝ) - 1) / d_0 p := lt_trans hα h_astar_lt
    rw [lt_div_iff₀ hd0] at h_α_lt
    linarith

-- ===========================================================================
-- 5. D_base(0) > 0
-- ===========================================================================

theorem D_base_zero_pos_iter (p : GameParams) (hα : p.α < alpha_star p) :
    D_base p 0 > 0 := by
  -- D_base(0) = D_I(0) + (N-1)βα(r-1)/N² > D_I(0) > 0
  rw [D_base_zero_eq_DI_plus]
  have hDI := D_I_zero_pos_iter p hα
  have hcorr : ((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1) / (p.N : ℝ) ^ 2 > 0 :=
    div_pos (mul_pos (mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.hα0) p.r_minus_one_pos)
      p.n_sq_pos
  linarith

-- ===========================================================================
-- 6. D_base(μ) > 0 on [0,1] (affine interpolation)
-- ===========================================================================

theorem D_base_pos_iter (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 := by
  -- D_base affine: D_base(μ) = (1-μ)·D_base(0) + μ·D_base(1)
  rw [D_base_convex p μ]
  have h0 := D_base_zero_pos_iter p hα
  have h1 := D_base_one_pos_iter p hα
  nlinarith [mul_nonneg (by linarith : (1 : ℝ) - μ ≥ 0) (le_of_lt h0),
             mul_nonneg hμ0 (le_of_lt h1)]

-- ===========================================================================
-- 7. δ_R1(μ) > 0 for μ < 1
-- ===========================================================================

theorem delta_R1_pos_iter (p : GameParams) (μ : ℝ) (hμ : μ < 1) :
    delta_R1 p μ > 0 := by
  unfold delta_R1
  apply div_pos _ p.n_sq_pos
  -- (N-1) · β · (r-1) · (1-μ) > 0: all factors positive
  have h1μ : 1 - μ > 0 := by linarith
  exact mul_pos (mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_minus_one_pos) h1μ

-- ===========================================================================
-- 8. D_I(μ) > 0 on [0,1] (Region I)
-- ===========================================================================

theorem D_I_pos_iter (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_I p μ > 0 := by
  -- D_I affine: D_I(μ) = (1-μ)·D_I(0) + μ·D_I(1)
  rw [D_I_convex p μ]
  have h0 := D_I_zero_pos_iter p hα
  -- D_I(1) > 0: D_I(1) = D_base(1) + δ_R2(1), both terms ≥ 0
  have h1 : D_I p 1 > 0 := by
    unfold D_I
    have hdb := D_base_one_pos_iter p hα
    have hdr : delta_R2 p 1 ≥ 0 := by
      unfold delta_R2
      apply div_nonneg _ (le_of_lt p.n_sq_pos)
      -- (N-1)·β·(1·(r-α) - α·(r-1)) = (N-1)·β·r·(1-α) ≥ 0
      nlinarith [p.n_minus_one_pos, p.hβ0, p.r_pos, p.one_minus_alpha_pos,
                 mul_pos p.n_minus_one_pos p.hβ0,
                 mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_pos]
    linarith
  nlinarith [mul_nonneg (by linarith : (1 : ℝ) - μ ≥ 0) (le_of_lt h0),
             mul_nonneg hμ0 (le_of_lt h1)]

-- ===========================================================================
-- 9. Assembly: Lemma 1 (sufficiency)
-- ===========================================================================

theorem lemma1_iter (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 < μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 ∧ D_I p μ > 0 ∧ (D_base p μ + delta_R1 p μ > 0) := by
  have hμ0' : 0 ≤ μ := le_of_lt hμ0
  refine ⟨?_, ?_, ?_⟩
  · exact D_base_pos_iter p hα μ hμ0' hμ1
  · exact D_I_pos_iter p hα μ hμ0' hμ1
  · -- D_base + δ_R1 > 0: backbone + non-negative correction
    have hdb := D_base_pos_iter p hα μ hμ0' hμ1
    have hdr : delta_R1 p μ ≥ 0 := by
      unfold delta_R1
      apply div_nonneg _ (le_of_lt p.n_sq_pos)
      nlinarith [p.n_minus_one_pos, p.hβ0, p.r_minus_one_pos,
                 mul_pos p.n_minus_one_pos p.hβ0,
                 mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.r_minus_one_pos]
    linarith

end
