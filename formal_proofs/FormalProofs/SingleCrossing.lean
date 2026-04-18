/-
  Single-Crossing Lemma — General N

  Proves that the normalized screening difference G(μ) = Δ(μ)/(1-μ) is
  strictly decreasing on (0,1) for general N ≥ 3. This is the key
  ingredient for uniqueness of the screening cutoff in Proposition 1.

  Source: formal_model.Rmd, Appendix B (Lemma: Single-crossing in Round 1).
-/

import FormalProofs.ContinuationValues

noncomputable section

-- ===========================================================================
-- Part 1: Interval lemmas
-- ===========================================================================

/-- The branch point m_N = 1/(N-2) is positive. -/
theorem m_N_pos (p : GameParams) : m_N p > 0 := by
  unfold m_N
  exact div_pos one_pos p.n_minus_two_pos

/-- The branch point m_N = 1/(N-2) is at most 1. -/
theorem m_N_le_one (p : GameParams) : m_N p ≤ 1 := by
  unfold m_N
  rw [div_le_one p.n_minus_two_pos]
  linarith [p.n_cast_ge_three]

-- ===========================================================================
-- Part 2: Q_a(μ) < 0 on [0, m_N]
-- ===========================================================================

/-- The inner quadratic g_a(μ) = 2μ² + (N-4)μ - 2(N-1) is negative
    on [0, 1] for all N ≥ 3.

    Proof: g_a(μ) = 2μ² + (N-4)μ - 2(N-1). On [0,1], the positive terms
    are bounded: 2μ² ≤ 2 and (N-4)μ ≤ N-4 (when N≥4) or (N-4)μ ≥ -1 (when N=3).
    In all cases, g_a(μ) ≤ 2 + (N-4) - 2(N-1) = -N < 0. -/
theorem g_a_neg (p : GameParams) (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    2 * μ ^ 2 + ((p.N : ℝ) - 4) * μ - 2 * ((p.N : ℝ) - 1) < 0 := by
  have hN := p.n_cast_ge_three
  -- 2μ² ≤ 2μ (since μ ≤ 1 implies μ² ≤ μ)
  have hμ_sq : μ ^ 2 ≤ μ := by nlinarith [sq_nonneg (1 - μ)]
  -- (N-4)μ ≤ (N-4) · 1 = N-4 (when N ≥ 4, μ ≤ 1)
  -- (N-4)μ ≥ -μ ≥ -1 (when N = 3)
  -- In both cases: 2μ² + (N-4)μ ≤ 2 + (N-4) = N-2
  -- And 2(N-1) = 2N-2 > N-2 for N ≥ 3
  nlinarith

/-- Q_a(μ) < 0 for all μ ∈ [0, m_N] and N ≥ 3.

    Proof: Q_a(μ) = -2N + (N-2)·μ·g_a(μ) where g_a is the inner quadratic.
    Since μ ≥ 0, g_a < 0, and (N-2) > 0, the product (N-2)·μ·g_a ≤ 0.
    Therefore Q_a ≤ -2N < 0. -/
theorem Q_a_neg (p : GameParams) (μ : ℝ)
    (hμ0 : 0 ≤ μ) (hμ_le : μ ≤ m_N p) :
    Q_a p μ < 0 := by
  -- μ ≤ m_N ≤ 1
  have hμ1 : μ ≤ 1 := le_trans hμ_le (m_N_le_one p)
  -- g_a(μ) < 0
  have hg := g_a_neg p μ hμ0 hμ1
  -- Factor: Q_a = -2N + (N-2) · μ · g_a(μ)
  -- The second term ≤ 0 since μ ≥ 0, (N-2) > 0, g_a < 0
  have hn2 := p.n_minus_two_pos
  have hN := p.n_cast_ge_three
  -- Show Q_a = -2N + (N-2) * [- 2(N-1)μ + (N-4)μ² + 2μ³]
  -- = -2N + (N-2) * μ * [2μ² + (N-4)μ - 2(N-1)]
  -- The product (N-2) * μ * g_a is ≤ 0
  suffices h : Q_a p μ ≤ -2 * (p.N : ℝ) by linarith
  unfold Q_a
  -- Q_a = -2N + (N-2) * μ * [2μ² + (N-4)μ - 2(N-1)]
  -- Need: (N-2) * μ * [2μ² + (N-4)μ - 2(N-1)] ≤ 0
  have hprod : ((p.N : ℝ) - 2) * μ *
      (2 * μ ^ 2 + ((p.N : ℝ) - 4) * μ - 2 * ((p.N : ℝ) - 1)) ≤ 0 := by
    apply mul_nonpos_of_nonneg_of_nonpos
    · exact mul_nonneg (le_of_lt hn2) hμ0
    · linarith
  nlinarith

-- ===========================================================================
-- Part 3: Q_c(μ) < 0 on [m_N, 1)
-- ===========================================================================

/-- The inner quadratic g_c(μ) = 2μ² + (N-3)μ - 2N is negative
    on [0, 1] for all N ≥ 3.

    Proof: g_c(0) = -2N < 0. g_c(1) = 2 + N - 3 - 2N = -(N+1) < 0.
    g_c is convex (leading coefficient 2 > 0) and negative at both
    endpoints of [0,1], hence negative throughout. -/
theorem g_c_neg (p : GameParams) (μ : ℝ) (hμ0 : 0 ≤ μ) (hμ1 : μ ≤ 1) :
    2 * μ ^ 2 + ((p.N : ℝ) - 3) * μ - 2 * (p.N : ℝ) < 0 := by
  have hN := p.n_cast_ge_three
  have hμ_sq : μ ^ 2 ≤ μ := by nlinarith [sq_nonneg (1 - μ)]
  -- 2μ² + (N-3)μ ≤ 2μ + (N-3)μ = (N-1)μ ≤ N-1 < 2N
  nlinarith

/-- Q_c(μ) < 0 for all μ ∈ [m_N, 1) and N ≥ 3.

    Proof: Q_c(μ) = -(N+2) + (N-2)·μ·g_c(μ) where g_c is the inner quadratic.
    Since μ ≥ m_N > 0, g_c < 0, and (N-2) > 0, the product is < 0.
    Therefore Q_c < -(N+2) < 0. -/
theorem Q_c_neg (p : GameParams) (μ : ℝ)
    (hμ_ge : μ ≥ m_N p) (hμ_lt : μ < 1) :
    Q_c p μ < 0 := by
  have hμ0 : 0 ≤ μ := le_trans (le_of_lt (m_N_pos p)) hμ_ge
  have hμ1 : μ ≤ 1 := le_of_lt hμ_lt
  have hg := g_c_neg p μ hμ0 hμ1
  have hn2 := p.n_minus_two_pos
  have hN := p.n_cast_ge_three
  suffices h : Q_c p μ ≤ -((p.N : ℝ) + 2) by linarith
  unfold Q_c
  have hprod : ((p.N : ℝ) - 2) * μ * (2 * μ ^ 2 + ((p.N : ℝ) - 3) * μ - 2 * (p.N : ℝ)) ≤ 0 := by
    apply mul_nonpos_of_nonneg_of_nonpos
    · exact mul_nonneg (le_of_lt hn2) hμ0
    · linarith
  nlinarith

-- ===========================================================================
-- Part 4: Numerator of G' < 0
-- ===========================================================================

/-- The numerator of G'(μ) is negative on the aggressive branch.
    This follows because:
    - (1-β) > 0, -N² + (r-1)Q_a < -N² < 0 (since Q_a < 0 and r-1 > 0)
    - (r-1)(N-2)(N+2μ)(1-μ)² > 0 (all factors positive)
    - Negative minus positive is negative. -/
theorem G_deriv_num_a_neg (p : GameParams) (μ : ℝ)
    (hμ0 : 0 ≤ μ) (hμ_le : μ ≤ m_N p) (hμ_lt1 : μ < 1) :
    G_deriv_num_a p μ < 0 := by
  unfold G_deriv_num_a
  have hQ := Q_a_neg p μ hμ0 hμ_le
  have hr1 := p.r_minus_one_pos
  have h1β := p.one_minus_beta_pos
  have hn2 := p.n_minus_two_pos
  have hN := p.n_cast_ge_three
  have h1μ : 1 - μ > 0 := by linarith
  -- First term: (1-β)(-N² + (r-1)Q_a) < 0
  have hterm1 : (1 - p.β) * (-(p.N : ℝ) ^ 2 + (p.r - 1) * Q_a p μ) < 0 := by
    apply mul_neg_of_pos_of_neg h1β
    have : (p.r - 1) * Q_a p μ < 0 := mul_neg_of_pos_of_neg hr1 hQ
    linarith [p.n_sq_pos]
  -- Second term: -(r-1)(N-2)(N+2μ)(1-μ)² ≤ 0
  have hterm2 : (p.r - 1) * ((p.N : ℝ) - 2) * ((p.N : ℝ) + 2 * μ) * (1 - μ) ^ 2 ≥ 0 := by
    apply mul_nonneg
    · apply mul_nonneg
      · apply mul_nonneg
        · exact le_of_lt hr1
        · exact le_of_lt hn2
      · linarith
    · exact sq_nonneg _
  linarith

/-- The numerator of G'(μ) is negative on the conservative branch.
    Same structure as the aggressive branch, using Q_c < 0. -/
theorem G_deriv_num_c_neg (p : GameParams) (μ : ℝ)
    (hμ_ge : μ ≥ m_N p) (hμ_lt : μ < 1) :
    G_deriv_num_c p μ < 0 := by
  unfold G_deriv_num_c
  have hQ := Q_c_neg p μ hμ_ge hμ_lt
  have hr1 := p.r_minus_one_pos
  have h1β := p.one_minus_beta_pos
  have hn2 := p.n_minus_two_pos
  have hN := p.n_cast_ge_three
  have h1μ : 1 - μ > 0 := by linarith
  have hμ0 : μ ≥ 0 := le_trans (le_of_lt (m_N_pos p)) hμ_ge
  have hterm1 : (1 - p.β) * (-(p.N : ℝ) ^ 2 + (p.r - 1) * Q_c p μ) < 0 := by
    apply mul_neg_of_pos_of_neg h1β
    have : (p.r - 1) * Q_c p μ < 0 := mul_neg_of_pos_of_neg hr1 hQ
    linarith [p.n_sq_pos]
  have hterm2 : (p.r - 1) * ((p.N : ℝ) - 2) * ((p.N : ℝ) + 2 * μ + 1) * (1 - μ) ^ 2 ≥ 0 := by
    apply mul_nonneg
    · apply mul_nonneg
      · apply mul_nonneg
        · exact le_of_lt hr1
        · exact le_of_lt hn2
      · linarith
    · exact sq_nonneg _
  linarith

-- ===========================================================================
-- Part 5: Boundary conditions (proved from explicit formulas)
-- ===========================================================================

/-- Δ(0) = β(r-1)(2N-1)/N² > 0 for any N ≥ 3, r > 1, β > 0. -/
theorem boundary_at_zero_pos (p : GameParams) : boundary_at_zero p > 0 := by
  unfold boundary_at_zero
  apply div_pos
  · have hr1 := p.r_minus_one_pos
    have hN := p.n_cast_ge_three
    nlinarith [p.hβ0, mul_pos p.hβ0 hr1]
  · exact p.n_sq_pos

/-- Δ(1) = r(β-1) < 0 for any r > 1, β < 1. -/
theorem boundary_at_one_neg (p : GameParams) : boundary_at_one p < 0 := by
  unfold boundary_at_one
  nlinarith [p.hr, p.hβ1]

-- ===========================================================================
-- Part 6: Jump at branch point (Appendix B.3)
-- ===========================================================================

/-- The jump in the normalized difference at the branch point is
    β(r-1)/N > 0. This is positive since β > 0, r > 1, N > 0. -/
theorem G_jump_pos (p : GameParams) :
    p.β * (p.r - 1) / (p.N : ℝ) > 0 := by
  apply div_pos
  · exact mul_pos p.hβ0 p.r_minus_one_pos
  · exact p.n_cast_pos

end
