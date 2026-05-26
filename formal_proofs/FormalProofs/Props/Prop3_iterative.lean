/-
  Proposition 3 (Iterative) — R1 screening cutoff existence and uniqueness

  Enunciado original (formal_model_v2.Rmd, line 242):
  "Under unanimity, there exists a unique μ_s^R1 ∈ (0,1) such that the
   weak proposer prefers the aggressive offer for μ < μ_s^R1 and the
   conservative offer for μ > μ_s^R1."

  Prova: Existência via IVT (Δ₁(0)>0, Δ₁(1)<0). Unicidade via single-crossing.

  TESTE: formalizado com approach iterativo (lean-tactic loop).
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Boundary values
-- ===========================================================================

/-- Δ₁(0) = β(r-1)/N: R1 screening difference at μ = 0. -/
def Delta1_zero_iter (p : GameParams) : ℝ :=
  p.β * (p.r - 1) / (p.N : ℝ)

/-- Δ₁(1) = r(β-1): R1 screening difference at μ = 1. -/
def Delta1_one_iter (p : GameParams) : ℝ :=
  p.r * (p.β - 1)

-- ===========================================================================
-- Part A: Boundary conditions
-- ===========================================================================

/-- Δ₁(0) > 0 for all valid parameters. -/
theorem delta1_zero_pos_iter (p : GameParams) : Delta1_zero_iter p > 0 := by
  unfold Delta1_zero_iter
  exact div_pos (mul_pos p.hβ0 p.r_minus_one_pos) p.n_cast_pos

/-- Δ₁(1) < 0 for all valid parameters. -/
theorem delta1_one_neg_iter (p : GameParams) : Delta1_one_iter p < 0 := by
  unfold Delta1_one_iter
  nlinarith [p.hr, p.hβ1]

-- ===========================================================================
-- Part B: Existence via IVT
-- ===========================================================================

/-- There exists μ_s ∈ (0,1) with Δ(μ_s) = 0. -/
theorem R1_cutoff_exists_iter (p : GameParams)
    (Δ : ℝ → ℝ) (hΔ_cont : Continuous Δ)
    (hΔ0 : Δ 0 = Delta1_zero_iter p) (hΔ1 : Δ 1 = Delta1_one_iter p) :
    ∃ μ_s : ℝ, 0 < μ_s ∧ μ_s < 1 ∧ Δ μ_s = 0 := by
  -- Primeiro: estabelecer fatos auxiliares
  have h0_pos : Δ 0 > 0 := by rw [hΔ0]; exact delta1_zero_pos_iter p
  have h1_neg : Δ 1 < 0 := by rw [hΔ1]; exact delta1_one_neg_iter p
  -- IVT: Δ contínua, Δ(0) > 0 > Δ(1) → ∃ c ∈ [0,1], Δ(c) = 0
  have hab : (0 : ℝ) ≤ 1 := by norm_num
  obtain ⟨c, hc_mem, hc_val⟩ := isPreconnected_Icc.intermediate_value₂
    (Set.left_mem_Icc.mpr hab) (Set.right_mem_Icc.mpr hab)
    continuousOn_const hΔ_cont.continuousOn
    (le_of_lt h0_pos) (le_of_lt h1_neg)
  -- Fornecer testemunha c, provar c ∈ (0,1) e Δ(c) = 0
  refine ⟨c, ?_, ?_, hc_val.symm⟩
  · -- Sub-goal 1: 0 < c (c ≠ 0, senão Δ(0) = 0, contradição com Δ(0) > 0)
    by_contra hle
    push Not at hle
    have hge := (Set.mem_Icc.mp hc_mem).1
    have : c = 0 := le_antisymm hle hge
    rw [this] at hc_val; linarith
  · -- Sub-goal 2: c < 1 (c ≠ 1, senão Δ(1) = 0, contradição com Δ(1) < 0)
    by_contra hge
    push Not at hge
    have hle := (Set.mem_Icc.mp hc_mem).2
    have : c = 1 := le_antisymm hle hge
    rw [this] at hc_val; linarith

-- ===========================================================================
-- Part C: Uniqueness via single-crossing
-- ===========================================================================

/-- If Δ(μ)/(1-μ) is strictly decreasing, then Δ has at most one zero in (0,1). -/
theorem R1_cutoff_unique_iter
    (Δ : ℝ → ℝ)
    (h_sc : ∀ μ₁ μ₂ : ℝ, 0 < μ₁ → μ₁ < μ₂ → μ₂ < 1 →
      Δ μ₂ / (1 - μ₂) < Δ μ₁ / (1 - μ₁)) :
    ∀ μ₁ μ₂ : ℝ, 0 < μ₁ → μ₁ < 1 → 0 < μ₂ → μ₂ < 1 →
    Δ μ₁ = 0 → Δ μ₂ = 0 → μ₁ = μ₂ := by
  -- Contraposição: se μ₁ ≠ μ₂, a single-crossing impede ambos serem zero
  intro μ₁ μ₂ h1a h1b h2a h2b hd1 hd2
  by_contra hne
  rcases lt_or_gt_of_ne hne with h12 | h21
  · -- Caso μ₁ < μ₂: single-crossing dá 0/(1-μ₂) < 0/(1-μ₁), i.e. 0 < 0
    have := h_sc μ₁ μ₂ h1a h12 h2b
    rw [hd1, hd2] at this; simp at this
  · -- Caso μ₂ < μ₁: simétrico
    have := h_sc μ₂ μ₁ h2a h21 h1b
    rw [hd1, hd2] at this; simp at this

end
