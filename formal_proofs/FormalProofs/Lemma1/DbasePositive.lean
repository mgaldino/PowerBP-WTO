/-
  Lemma 1 — D_base positivity

  The heart of the proof: D_base(μ) > 0 for all μ ∈ [0,1] under α < α*.

  Strategy:
  1. D_base(1) > 0: from P - Q(1-β) > 0 ↔ α < α*
  2. D_base(0) > 0: via threshold nesting (d_0 < d_star → ᾱ₀ > α*)
  3. Affine with positive endpoints → positive everywhere

  Source: notes/2026-04-21_lemma1_complete_proof.md, Step 2
-/

import FormalProofs.Lemma1.Definitions

noncomputable section

-- ===========================================================================
-- Part 1: D_base(1) > 0 under α < α*
-- ===========================================================================

/-- α < α* implies P - Q(1-β) > 0.
    Proof: α < β(q-1)/d_star means α·d_star < β(q-1) (since d_star > 0).
    By the identity P - Q(1-β) = β(q-1) - α·d_star, we get P - Q(1-β) > 0. -/
theorem P_minus_Q_pos (p : GameParams) (hα : p.α < alpha_star p) :
    p.P - p.Q * (1 - p.β) > 0 := by
  rw [P_minus_Q_one_minus_beta]
  have hd := d_star_pos p
  have h := hα
  unfold alpha_star at h
  rw [lt_div_iff₀ hd] at h
  linarith

/-- D_base(1) > 0 under α < α*. -/
theorem D_base_one_pos (p : GameParams) (hα : p.α < alpha_star p) :
    D_base p 1 > 0 := by
  rw [D_base_at_one]
  apply div_pos
  · exact mul_pos p.r_pos (P_minus_Q_pos p hα)
  · exact p.n_sq_pos

-- ===========================================================================
-- Part 2: D_base(0) > 0 under α < α*
-- ===========================================================================

/-- d_star - d_0 > 0: the gap between the two denominators.
    This is β(N-1)²(r-1) > 0. -/
theorem d_star_minus_d_0_pos (p : GameParams) : d_star p - d_0 p > 0 := by
  rw [d_star_minus_d_0]
  have hN1 := p.n_minus_one_pos
  nlinarith [p.hβ0, p.r_minus_one_pos, sq_nonneg ((p.N : ℝ) - 1),
             mul_pos p.hβ0 (mul_pos (by positivity : ((p.N : ℝ) - 1) ^ 2 > 0) p.r_minus_one_pos)]

/-- d_0 < d_star. -/
theorem d_0_lt_d_star (p : GameParams) : d_0 p < d_star p := by
  linarith [d_star_minus_d_0_pos p]

/-- D_I(0) > 0 under α < α*.
    Case 1: d_0 ≤ 0 → β(q-1) - α·d_0 ≥ β(q-1) > 0.
    Case 2: d_0 > 0 → α < α* < ᾱ₀ → α·d_0 < β(q-1) → D_I(0) > 0. -/
theorem D_I_zero_pos (p : GameParams) (hα : p.α < alpha_star p) :
    D_I p 0 > 0 := by
  rw [D_I_at_zero]
  apply div_pos _ p.n_sq_pos
  -- Need: β(q-1) - α · d_0 > 0
  by_cases hd0 : d_0 p ≤ 0
  · -- Case 1: d_0 ≤ 0. Then -α·d_0 ≥ 0, so β(q-1) - α·d_0 ≥ β(q-1) > 0.
    have hβq := mul_pos p.hβ0 p.q_cast_minus_one_pos
    nlinarith [p.hα0]
  · -- Case 2: d_0 > 0.
    push Not at hd0
    have hd_lt := d_0_lt_d_star p
    have hd_star := d_star_pos p
    have hβq : p.β * ((p.q : ℝ) - 1) > 0 := mul_pos p.hβ0 p.q_cast_minus_one_pos
    -- α* < β(q-1)/d_0 because d_0 < d_star and both positive
    have h_astar_lt : alpha_star p < p.β * ((p.q : ℝ) - 1) / d_0 p := by
      unfold alpha_star
      exact div_lt_div_of_pos_left hβq hd0 hd_lt
    -- α < β(q-1)/d_0
    have h_α_lt : p.α < p.β * ((p.q : ℝ) - 1) / d_0 p := lt_trans hα h_astar_lt
    rw [lt_div_iff₀ hd0] at h_α_lt
    linarith

/-- D_base(0) > 0 under α < α*.
    D_base(0) = D_I(0) + (N-1)βα(r-1)/N² > D_I(0) > 0. -/
theorem D_base_zero_pos (p : GameParams) (hα : p.α < alpha_star p) :
    D_base p 0 > 0 := by
  rw [D_base_zero_eq_DI_plus]
  have hDI := D_I_zero_pos p hα
  have hcorr : ((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1) / (p.N : ℝ) ^ 2 > 0 := by
    apply div_pos _ p.n_sq_pos
    nlinarith [p.n_minus_one_pos, p.hβ0, p.hα0, p.r_minus_one_pos,
               mul_pos p.n_minus_one_pos p.hβ0,
               mul_pos (mul_pos p.n_minus_one_pos p.hβ0) p.hα0]
  linarith

-- ===========================================================================
-- Part 3: D_base(μ) > 0 on [0, 1]
-- ===========================================================================

/-- D_base(μ) > 0 for all μ ∈ [0, 1] under α < α*.
    Proof: D_base is affine (convex combination of endpoints), both endpoints
    are positive, and a convex combination of positives with non-negative
    weights summing to 1 is positive. -/
theorem D_base_pos (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 := by
  rw [D_base_convex p μ]
  have h0 := D_base_zero_pos p hα
  have h1 := D_base_one_pos p hα
  have h1μ : 1 - μ ≥ 0 := by linarith
  nlinarith [mul_nonneg h1μ (le_of_lt h0), mul_nonneg hμ0 (le_of_lt h1)]

end
