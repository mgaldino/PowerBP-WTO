/-
  Formal Proofs — Informational Power: Bayesian Persuasion,
  Legislative Bargaining, and Institutional Design

  Model v2 parameters and basic definitions.
  All definitions are for general N >= 3.
-/

import Mathlib

-- ===========================================================================
-- Section 1: Model Parameters (v2)
-- ===========================================================================

/-- Parameters for the institutional design game (model v2).
    N players (1 hegemon + N-1 weak states), pie V(theta) in {1, r},
    outside option d_H = alpha * V(theta), random proposer (1/N). -/
structure GameParams where
  /-- Number of players (hegemon + weak states). -/
  N : ℕ
  /-- Pie ratio: V(1) = r > 1. -/
  r : ℝ
  /-- Discount factor. -/
  β : ℝ
  /-- Outside option parameter: d_H = α·V(θ). -/
  α : ℝ
  /-- Constraints -/
  hN : N ≥ 3
  hr : r > 1
  hβ0 : 0 < β
  hβ1 : β < 1
  hα0 : 0 < α
  hαr : α * r < 1

-- ===========================================================================
-- Section 2: Basic derived quantities
-- ===========================================================================

noncomputable section

/-- Expected pie at posterior belief μ: V_e(μ) = 1 + μ(r - 1). -/
def V_e (p : GameParams) (μ : ℝ) : ℝ := 1 + μ * (p.r - 1)

/-- Pie at state θ ∈ {0, 1}: V(0) = 1, V(1) = r. -/
def V_theta (p : GameParams) (θ : ℝ) : ℝ := 1 + θ * (p.r - 1)

/-- Majority threshold: q = ⌊N/2⌋ + 1. -/
def GameParams.q (p : GameParams) : ℕ := p.N / 2 + 1

-- ===========================================================================
-- Section 3: Casting helpers for N
-- ===========================================================================

/-- N cast to ℝ is at least 3. -/
theorem GameParams.n_cast_ge_three (p : GameParams) : (p.N : ℝ) ≥ 3 := by
  exact_mod_cast p.hN

/-- N cast to ℝ is positive. -/
theorem GameParams.n_cast_pos (p : GameParams) : (p.N : ℝ) > 0 := by
  linarith [p.n_cast_ge_three]

/-- N - 1 cast to ℝ is positive. -/
theorem GameParams.n_minus_one_pos (p : GameParams) : (p.N : ℝ) - 1 > 0 := by
  linarith [p.n_cast_ge_three]

/-- N - 2 cast to ℝ is positive. -/
theorem GameParams.n_minus_two_pos (p : GameParams) : (p.N : ℝ) - 2 > 0 := by
  linarith [p.n_cast_ge_three]

/-- N² cast to ℝ is positive. -/
theorem GameParams.n_sq_pos (p : GameParams) : (p.N : ℝ) ^ 2 > 0 := by
  have := p.n_cast_pos
  positivity

/-- r - 1 > 0. -/
theorem GameParams.r_minus_one_pos (p : GameParams) : p.r - 1 > 0 := by
  linarith [p.hr]

/-- r > 0. -/
theorem GameParams.r_pos (p : GameParams) : p.r > 0 := by
  linarith [p.hr]

/-- 1 - β > 0. -/
theorem GameParams.one_minus_beta_pos (p : GameParams) : 1 - p.β > 0 := by
  linarith [p.hβ1]

/-- α < 1 (from α·r < 1 and r > 1). -/
theorem GameParams.alpha_lt_one (p : GameParams) : p.α < 1 := by
  have hr := p.hr
  have hαr := p.hαr
  nlinarith

/-- 1 - α > 0. -/
theorem GameParams.one_minus_alpha_pos (p : GameParams) : 1 - p.α > 0 := by
  linarith [p.alpha_lt_one]

/-- r - α > 0 (from r > 1 > α). -/
theorem GameParams.r_minus_alpha_pos (p : GameParams) : p.r - p.α > 0 := by
  linarith [p.hr, p.alpha_lt_one]

-- ===========================================================================
-- Section 4: Majority threshold helpers
-- ===========================================================================

/-- q ≥ 2 for N ≥ 3. -/
theorem GameParams.q_ge_two (p : GameParams) : p.q ≥ 2 := by
  unfold GameParams.q; have := p.hN; omega

/-- q ≤ N - 1 for N ≥ 3. -/
theorem GameParams.q_le_N_minus_one (p : GameParams) : p.q ≤ p.N - 1 := by
  unfold GameParams.q; have := p.hN; omega

/-- q ≤ N for N ≥ 3. -/
theorem GameParams.q_le_N (p : GameParams) : p.q ≤ p.N := by
  have := p.q_le_N_minus_one; omega

/-- (q : ℝ) - 1 ≥ 1, hence > 0. -/
theorem GameParams.q_minus_one_pos (p : GameParams) : (p.q : ℝ) - 1 ≥ 1 := by
  have h := p.q_ge_two
  have : (p.q : ℝ) ≥ 2 := by exact_mod_cast h
  linarith

/-- (q : ℝ) - 1 > 0. -/
theorem GameParams.q_cast_minus_one_pos (p : GameParams) : (p.q : ℝ) - 1 > 0 := by
  linarith [p.q_minus_one_pos]

/-- N - q ≥ 1 (hence N > q). From q = ⌊N/2⌋ + 1 ≤ N-1 for N ≥ 3. -/
theorem GameParams.N_minus_q_ge_one (p : GameParams) : p.N - p.q ≥ 1 := by
  have := p.q_le_N_minus_one; have := p.hN; omega

/-- (N : ℝ) - (q : ℝ) ≥ 1. -/
theorem GameParams.n_minus_q_cast_ge_one (p : GameParams) : (p.N : ℝ) - (p.q : ℝ) ≥ 1 := by
  have h : p.q + 1 ≤ p.N := by have := p.q_le_N_minus_one; have := p.hN; omega
  have h2 : (p.q : ℝ) + 1 ≤ (p.N : ℝ) := by exact_mod_cast h
  linarith

-- ===========================================================================
-- Section 5: Shorthand notation (P, Q, d_star, alpha_star)
-- ===========================================================================

/-- P ≡ β(q-1)(1-α): the "screening premium" coefficient. -/
def GameParams.P (p : GameParams) : ℝ := p.β * ((p.q : ℝ) - 1) * (1 - p.α)

/-- Q ≡ N(N-1)α: the "outside option cost" coefficient. -/
def GameParams.Q (p : GameParams) : ℝ := (p.N : ℝ) * ((p.N : ℝ) - 1) * p.α

/-- d_star ≡ N(N-1) - β(N²-N-q+1): denominator of α*. -/
def d_star (p : GameParams) : ℝ :=
  (p.N : ℝ) * ((p.N : ℝ) - 1) - p.β * ((p.N : ℝ) ^ 2 - (p.N : ℝ) - (p.q : ℝ) + 1)

/-- α*(N, β) ≡ β(q-1) / d_star: the threshold for Lemma 1. -/
def alpha_star (p : GameParams) : ℝ := p.β * ((p.q : ℝ) - 1) / d_star p

-- ===========================================================================
-- Section 6: d_star > 0
-- ===========================================================================

/-- N²-N-q+1 < N(N-1), which implies d_star > 0 since β < 1.
    Proof: N²-N-q+1 = N(N-1) - (q-1). Since q ≥ 2, q-1 ≥ 1, so
    N²-N-q+1 ≤ N(N-1) - 1 < N(N-1). -/
theorem d_star_pos (p : GameParams) : d_star p > 0 := by
  -- d_star = N(N-1)(1-β) + β(q-1), both terms positive
  have key : d_star p = (p.N : ℝ) * ((p.N : ℝ) - 1) * (1 - p.β) + p.β * ((p.q : ℝ) - 1) := by
    unfold d_star; ring
  rw [key]
  have hN1 := p.n_minus_one_pos
  nlinarith [mul_pos (mul_pos p.n_cast_pos hN1) p.one_minus_beta_pos,
             mul_pos p.hβ0 p.q_cast_minus_one_pos]

/-- alpha_star is positive. -/
theorem alpha_star_pos (p : GameParams) : alpha_star p > 0 := by
  unfold alpha_star
  exact div_pos (mul_pos p.hβ0 p.q_cast_minus_one_pos) (d_star_pos p)

-- ===========================================================================
-- Section 7: V_e properties
-- ===========================================================================

/-- V_e is affine: V_e(μ) = (r-1)·μ + 1. -/
theorem V_e_affine (p : GameParams) :
    ∀ μ : ℝ, V_e p μ = (p.r - 1) * μ + 1 := by
  intro μ; unfold V_e; ring

/-- V_e(0) = 1. -/
theorem V_e_zero (p : GameParams) : V_e p 0 = 1 := by
  unfold V_e; ring

/-- V_e(1) = r. -/
theorem V_e_one (p : GameParams) : V_e p 1 = p.r := by
  unfold V_e; ring

/-- V_e(μ) > 0 for μ ∈ [0, 1]. -/
theorem V_e_pos (p : GameParams) (μ : ℝ) (hμ0 : 0 ≤ μ) (_hμ1 : μ ≤ 1) :
    V_e p μ > 0 := by
  unfold V_e
  have := p.r_minus_one_pos
  nlinarith

/-- V_e is a convex combination: V_e(μ) = (1-μ)·1 + μ·r = (1-μ)·V_e(0) + μ·V_e(1). -/
theorem V_e_convex (p : GameParams) (μ : ℝ) :
    V_e p μ = (1 - μ) * 1 + μ * p.r := by
  unfold V_e; ring

end
