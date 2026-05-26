/-
  Proposition 2 (v5) — R1 screening cutoff under consensus

  Statement (formal_model_v5.Rmd, line 304):
  "Under unanimity, there exists a unique screening cutoff μ_s^{R1} ∈ (0,1)
   such that the weak proposer prefers the aggressive offer for μ < μ_s^{R1}
   and the conservative offer for μ > μ_s^{R1}."

  Proof: Existence via IVT; uniqueness via single-crossing.
  (Same result as v2 Proposition 3.)

  Source: formal_model_v5.Rmd, Appendix B.2 (lines 904-910)
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Boundary values of the R1 screening difference
-- ===========================================================================

/-- Δ₁(0) = β(r-1)/N > 0. -/
def v5_Delta1_at_zero (p : GameParams) : ℝ := p.β * (p.r - 1) / (p.N : ℝ)

/-- Δ₁(1) = r(β-1) < 0. -/
def v5_Delta1_at_one (p : GameParams) : ℝ := p.r * (p.β - 1)

theorem v5_Delta1_at_zero_pos (p : GameParams) : v5_Delta1_at_zero p > 0 := by
  unfold v5_Delta1_at_zero
  exact div_pos (mul_pos p.hβ0 p.r_minus_one_pos) p.n_cast_pos

theorem v5_Delta1_at_one_neg (p : GameParams) : v5_Delta1_at_one p < 0 := by
  unfold v5_Delta1_at_one
  nlinarith [p.hr, p.hβ1]

-- ===========================================================================
-- Existence via IVT
-- ===========================================================================

/-- Proposition 2, Part A: Existence of R1 screening cutoff. -/
theorem v5_R1_cutoff_exists (p : GameParams)
    (Δ : ℝ → ℝ) (hΔ_cont : Continuous Δ)
    (hΔ0 : Δ 0 = v5_Delta1_at_zero p) (hΔ1 : Δ 1 = v5_Delta1_at_one p) :
    ∃ μ_s : ℝ, 0 < μ_s ∧ μ_s < 1 ∧ Δ μ_s = 0 := by
  have h0_pos : Δ 0 > 0 := by rw [hΔ0]; exact v5_Delta1_at_zero_pos p
  have h1_neg : Δ 1 < 0 := by rw [hΔ1]; exact v5_Delta1_at_one_neg p
  have hab : (0 : ℝ) ≤ 1 := by norm_num
  obtain ⟨c, hc_mem, hc_val⟩ := isPreconnected_Icc.intermediate_value₂
    (Set.left_mem_Icc.mpr hab) (Set.right_mem_Icc.mpr hab)
    continuousOn_const hΔ_cont.continuousOn
    (le_of_lt h0_pos) (le_of_lt h1_neg)
  refine ⟨c, ?_, ?_, hc_val.symm⟩
  · by_contra hle
    push Not at hle
    have hge := (Set.mem_Icc.mp hc_mem).1
    have : c = 0 := le_antisymm hle hge
    rw [this] at hc_val; linarith
  · by_contra hge
    push Not at hge
    have hle := (Set.mem_Icc.mp hc_mem).2
    have : c = 1 := le_antisymm hle hge
    rw [this] at hc_val; linarith

-- ===========================================================================
-- Uniqueness via single-crossing
-- ===========================================================================

/-- Proposition 2, Part B: Uniqueness of R1 screening cutoff. -/
theorem v5_R1_cutoff_unique
    (Δ : ℝ → ℝ)
    (h_sc : ∀ μ₁ μ₂ : ℝ, 0 < μ₁ → μ₁ < μ₂ → μ₂ < 1 →
      Δ μ₂ / (1 - μ₂) < Δ μ₁ / (1 - μ₁)) :
    ∀ μ₁ μ₂ : ℝ, 0 < μ₁ → μ₁ < 1 → 0 < μ₂ → μ₂ < 1 →
    Δ μ₁ = 0 → Δ μ₂ = 0 → μ₁ = μ₂ := by
  intro μ₁ μ₂ h1a h1b h2a h2b hd1 hd2
  by_contra hne
  rcases lt_or_gt_of_ne hne with h12 | h21
  · have := h_sc μ₁ μ₂ h1a h12 h2b
    rw [hd1, hd2] at this; simp at this
  · have := h_sc μ₂ μ₁ h2a h21 h1b
    rw [hd1, hd2] at this; simp at this

end
