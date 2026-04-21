/-
  Theorem 1 — Hypotheses and Definitions

  Modular formalization: we assume concavification properties as hypotheses
  and prove the 4-case logical structure of the institutional comparison.

  Original statement (formal_model_v2.Rmd, lines 555-572):
  "Suppose α < α*(N, β). The comparison between cav v(p, U) and cav v(p, M)
   has [4 cases with single-crossing property]."

  Source: notes/2026-04-21_revised_theorem1_threshold_prior.md
-/

import FormalProofs.Lemma1.Assembly

noncomputable section

-- ===========================================================================
-- Section 1: lambda_M positivity
-- ===========================================================================

/-- lambda_M > 0 under the model's parameter constraints.
    numerator = N + N(N-1)alpha - beta(q-1)(1-alpha) > N - (N-1) = 1 > 0. -/
theorem lambda_M_pos (p : GameParams) : lambda_M p > 0 := by
  unfold lambda_M
  apply div_pos _ p.n_sq_pos
  unfold GameParams.P
  have hN := p.n_cast_ge_three
  have hN1 := p.n_minus_one_pos
  have hα := p.hα0
  have hαr := p.one_minus_alpha_pos
  have hβ := p.hβ0
  have hβ1 := p.hβ1
  have hq := p.q_cast_minus_one_pos
  have hq_lt_N : (p.q : ℝ) - 1 < (p.N : ℝ) - 1 := by
    linarith [p.n_minus_q_cast_ge_one]
  -- beta * (q-1) < q-1 < N-1
  have hbq : p.β * ((p.q : ℝ) - 1) < (p.N : ℝ) - 1 := by
    calc p.β * ((p.q : ℝ) - 1) < 1 * ((p.q : ℝ) - 1) := by nlinarith
      _ = (p.q : ℝ) - 1 := by ring
      _ < (p.N : ℝ) - 1 := hq_lt_N
  -- beta * (q-1) * (1-alpha) < N-1 since (1-alpha) ≤ 1
  have hP : p.β * ((p.q : ℝ) - 1) * (1 - p.α) < (p.N : ℝ) - 1 := by nlinarith
  -- numerator = N + N(N-1)alpha - P > N - (N-1) = 1 > 0
  nlinarith [mul_nonneg (le_of_lt p.n_cast_pos) (mul_nonneg (le_of_lt hN1) (le_of_lt hα))]

-- ===========================================================================
-- Section 2: Theorem 1 hypotheses (modular approach)
-- ===========================================================================

/-- Bundled hypotheses for Theorem 1.
    These encode the concavification properties and entry thresholds
    without formalizing the concave envelope itself. -/
structure Theorem1Hyps (p : GameParams) where
  tau_U : ℝ
  tau_M : ℝ
  S_U : ℝ
  h_tau_U_nonneg : 0 ≤ tau_U
  h_tau_U_lt_one : tau_U < 1
  h_tau_M_nonneg : 0 ≤ tau_M
  h_tau_le : tau_M ≤ tau_U
  h_S_U_pos : S_U > 0
  /-- Step 1 link: S_U * tau_U > lambda_M * V_e(tau_U) when tau_U > 0.
      From cav_U(tau_U) >= v_U(tau_U) > v_M(tau_U) = lambda_M * V_e(tau_U). -/
  h_step1 : tau_U > 0 → S_U * tau_U > lambda_M p * V_e p tau_U

-- ===========================================================================
-- Section 3: D_low and S_M
-- ===========================================================================

/-- D_low(mu) = S_U * mu - lambda_M * V_e(mu). -/
def D_low (p : GameParams) (h : Theorem1Hyps p) (μ : ℝ) : ℝ :=
  h.S_U * μ - lambda_M p * V_e p μ

/-- S_M = lambda_M * V_e(tau_M) / tau_M. -/
def S_M (p : GameParams) (h : Theorem1Hyps p) : ℝ :=
  lambda_M p * V_e p h.tau_M / h.tau_M

-- ===========================================================================
-- Section 4: D_low is affine
-- ===========================================================================

/-- D_low(mu) = (S_U - lambda_M * (r-1)) * mu - lambda_M. -/
theorem D_low_linear (p : GameParams) (h : Theorem1Hyps p) (μ : ℝ) :
    D_low p h μ = (h.S_U - lambda_M p * (p.r - 1)) * μ - lambda_M p := by
  unfold D_low lambda_M V_e; ring

theorem D_low_at_zero (p : GameParams) (h : Theorem1Hyps p) :
    D_low p h 0 = -lambda_M p := by
  unfold D_low V_e; ring

theorem D_low_at_zero_neg (p : GameParams) (h : Theorem1Hyps p) :
    D_low p h 0 < 0 := by
  rw [D_low_at_zero]; linarith [lambda_M_pos p]

theorem D_low_at_tau_U_pos (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) : D_low p h h.tau_U > 0 := by
  unfold D_low; linarith [h.h_step1 htau]

-- ===========================================================================
-- Section 5: D_low slope
-- ===========================================================================

def D_low_slope (p : GameParams) (h : Theorem1Hyps p) : ℝ :=
  h.S_U - lambda_M p * (p.r - 1)

theorem D_low_slope_pos (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) : D_low_slope p h > 0 := by
  by_contra h_le
  have hle : D_low_slope p h ≤ 0 := le_of_not_gt h_le
  unfold D_low_slope at hle
  have hτ := D_low_at_tau_U_pos p h htau
  rw [D_low_linear] at hτ
  nlinarith [lambda_M_pos p]

-- ===========================================================================
-- Section 6: p* and crossing
-- ===========================================================================

def p_star (p : GameParams) (h : Theorem1Hyps p) : ℝ :=
  lambda_M p / D_low_slope p h

theorem p_star_pos (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) : p_star p h > 0 :=
  div_pos (lambda_M_pos p) (D_low_slope_pos p h htau)

theorem D_low_at_p_star (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) : D_low p h (p_star p h) = 0 := by
  unfold p_star D_low_slope
  rw [D_low_linear]
  have hsl := D_low_slope_pos p h htau
  unfold D_low_slope at hsl
  have hne : h.S_U - lambda_M p * (p.r - 1) ≠ 0 := ne_of_gt hsl
  field_simp; ring

theorem p_star_lt_tau_U (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) : p_star p h < h.tau_U := by
  have hsl := D_low_slope_pos p h htau
  have hτ := D_low_at_tau_U_pos p h htau
  have hp := D_low_at_p_star p h htau
  -- If p* >= tau_U, then D_low(p*) >= D_low(tau_U) > 0 (slope positive).
  -- But D_low(p*) = 0. Contradiction.
  by_contra h_ge
  push Not at h_ge
  have : D_low p h (p_star p h) ≥ D_low p h h.tau_U := by
    rw [D_low_linear, D_low_linear]
    unfold D_low_slope at hsl
    nlinarith
  linarith

/-- D_low(mu) < 0 for mu < p*. -/
theorem D_low_neg_below (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) (μ : ℝ) (hμ : μ < p_star p h) :
    D_low p h μ < 0 := by
  have hp := D_low_at_p_star p h htau
  have hsl := D_low_slope_pos p h htau
  rw [D_low_linear] at hp ⊢
  unfold D_low_slope at hsl
  nlinarith

/-- D_low(mu) > 0 for mu > p*. -/
theorem D_low_pos_above (p : GameParams) (h : Theorem1Hyps p)
    (htau : h.tau_U > 0) (μ : ℝ) (hμ : μ > p_star p h) :
    D_low p h μ > 0 := by
  have hp := D_low_at_p_star p h htau
  have hsl := D_low_slope_pos p h htau
  rw [D_low_linear] at hp ⊢
  unfold D_low_slope at hsl
  nlinarith

-- ===========================================================================
-- Section 7: D_low at tau_M
-- ===========================================================================

/-- D_low(tau_M) = (S_U - S_M) * tau_M when tau_M > 0. -/
theorem D_low_at_tau_M (p : GameParams) (h : Theorem1Hyps p)
    (htau_M : h.tau_M > 0) :
    D_low p h h.tau_M = (h.S_U - S_M p h) * h.tau_M := by
  unfold D_low S_M
  field_simp

end
