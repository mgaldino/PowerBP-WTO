/-
  Formal Proofs — The Hegemon's Choice of Consensus

  Model parameters and basic definitions for the institutional design game.
  All definitions are for general N ≥ 3.
-/

import Mathlib

-- ===========================================================================
-- Section 1: Model Parameters
-- ===========================================================================

/-- Parameters for the institutional design game Γ(N, p, g, c, r, β). -/
structure GameParams where
  /-- Number of players (hegemon + weak states). -/
  N : ℕ
  /-- Pie ratio: V(1) = r > 1. -/
  r : ℝ
  /-- Discount factor. -/
  β : ℝ
  /-- Entry cost for weak states. -/
  c : ℝ
  /-- Participation value for hegemon. -/
  g : ℝ
  /-- Constraints -/
  hN : N ≥ 3
  hr : r > 1
  hβ0 : 0 < β
  hβ1 : β < 1
  hc : c > 0
  hg : g > 0

-- ===========================================================================
-- Section 2: Derived Quantities
-- ===========================================================================

noncomputable section

/-- Expected pie at posterior belief μ: V_e(μ) = 1 + μ(r - 1). -/
def V_e (p : GameParams) (μ : ℝ) : ℝ := 1 + μ * (p.r - 1)

/-- Pie at state θ ∈ {0, 1}: V(0) = 1, V(1) = r. -/
def V_theta (p : GameParams) (θ : ℝ) : ℝ := 1 + θ * (p.r - 1)

-- ===========================================================================
-- Section 3: Casting helpers for N
-- ===========================================================================

/-- N cast to ℝ is at least 3. -/
theorem GameParams.n_cast_ge_three (p : GameParams) : (p.N : ℝ) ≥ 3 := by
  exact_mod_cast p.hN

/-- N cast to ℝ is positive. -/
theorem GameParams.n_cast_pos (p : GameParams) : (p.N : ℝ) > 0 := by
  linarith [p.n_cast_ge_three]

/-- N - 2 cast to ℝ is positive. -/
theorem GameParams.n_minus_two_pos (p : GameParams) : (p.N : ℝ) - 2 > 0 := by
  linarith [p.n_cast_ge_three]

/-- N² cast to ℝ is positive. -/
theorem GameParams.n_sq_pos (p : GameParams) : (p.N : ℝ) ^ 2 > 0 := by
  have := p.n_cast_pos
  nlinarith [sq_nonneg (p.N : ℝ)]

/-- r - 1 > 0. -/
theorem GameParams.r_minus_one_pos (p : GameParams) : p.r - 1 > 0 := by
  linarith [p.hr]

/-- 1 - β > 0. -/
theorem GameParams.one_minus_beta_pos (p : GameParams) : 1 - p.β > 0 := by
  linarith [p.hβ1]

-- ===========================================================================
-- Section 4: Setup verification
-- ===========================================================================

theorem setup_test : 1 + 1 = 2 := by norm_num

end
