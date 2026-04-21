/-
  Lemma 1 — Definitions

  Algebraic objects for the decomposition D(μ) = D_base(μ) + corrections.

  Source: formal_model_v2.Rmd, Appendix B.5 (lines 841-879)
  Proof: notes/2026-04-21_lemma1_complete_proof.md

  Original statement:
  "For α < α*(N, β) and every μ ∈ (0,1],
   E_θ[V_H^{R1}(θ, μ, U)] > E_θ[V_H^{R1}(θ, μ, M)]."
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Section 1: Majority payoff coefficient
-- ===========================================================================

/-- λ_M = [N(1+(N-1)α) - P] / N²: the hegemon's payoff coefficient
    under majority rule. E[V_H(μ, M)] = λ_M · V_e(μ). -/
def lambda_M (p : GameParams) : ℝ :=
  ((p.N : ℝ) * (1 + ((p.N : ℝ) - 1) * p.α) - p.P) / (p.N : ℝ) ^ 2

-- ===========================================================================
-- Section 2: Backbone and corrections
-- ===========================================================================

/-- D_base(μ) = ((P - Q) · V_e(μ) + Q · β · r) / N²:
    the "backbone" of the payoff difference (Region II value). -/
def D_base (p : GameParams) (μ : ℝ) : ℝ :=
  ((p.P - p.Q) * V_e p μ + p.Q * p.β * p.r) / (p.N : ℝ) ^ 2

/-- δ_R2(μ) = (N-1)·β·[μ(r-α) - α(r-1)] / N²:
    correction for aggressive R2 screening (active when μ < μ_s^R2). -/
def delta_R2 (p : GameParams) (μ : ℝ) : ℝ :=
  ((p.N : ℝ) - 1) * p.β * (μ * (p.r - p.α) - p.α * (p.r - 1)) / (p.N : ℝ) ^ 2

/-- δ_R1(μ) = (N-1)·β·(r-1)·(1-μ) / N²:
    correction for conservative R1 screening (active when μ > μ_s^R1). -/
def delta_R1 (p : GameParams) (μ : ℝ) : ℝ :=
  ((p.N : ℝ) - 1) * p.β * (p.r - 1) * (1 - μ) / (p.N : ℝ) ^ 2

-- ===========================================================================
-- Section 3: Screening cutoffs
-- ===========================================================================

/-- μ_s^R2 = α(r-1)/(r-α): the R2 screening cutoff. -/
def mu_s_R2 (p : GameParams) : ℝ :=
  p.α * (p.r - 1) / (p.r - p.α)

-- ===========================================================================
-- Section 4: Region I full difference at μ = 0
-- ===========================================================================

/-- D_I(μ) = D_base(μ) + δ_R2(μ): the full difference in Region I. -/
def D_I (p : GameParams) (μ : ℝ) : ℝ := D_base p μ + delta_R2 p μ

/-- d_0 = N(N-1) - β((N-1)²r + N - q): denominator threshold for D_I(0).
    When d_0 > 0, the threshold ᾱ₀ = β(q-1)/d_0 governs D_I(0) > 0. -/
def d_0 (p : GameParams) : ℝ :=
  (p.N : ℝ) * ((p.N : ℝ) - 1) - p.β * (((p.N : ℝ) - 1) ^ 2 * p.r + (p.N : ℝ) - (p.q : ℝ))

-- ===========================================================================
-- Section 5: Evaluation at endpoints
-- ===========================================================================

/-- D_base(1) = r · [P - Q(1-β)] / N². -/
theorem D_base_at_one (p : GameParams) :
    D_base p 1 = p.r * (p.P - p.Q * (1 - p.β)) / (p.N : ℝ) ^ 2 := by
  unfold D_base V_e GameParams.P GameParams.Q; ring

/-- D_base(0) = (P - Q + Qβr) / N² = (P + Q(βr - 1)) / N². -/
theorem D_base_at_zero (p : GameParams) :
    D_base p 0 = (p.P + p.Q * (p.β * p.r - 1)) / (p.N : ℝ) ^ 2 := by
  unfold D_base V_e GameParams.P GameParams.Q; ring

/-- D_I(0) = [β(q-1) - α · d_0] / N² (when expanded). -/
theorem D_I_at_zero (p : GameParams) :
    D_I p 0 = (p.β * ((p.q : ℝ) - 1) - p.α * d_0 p) / (p.N : ℝ) ^ 2 := by
  unfold D_I D_base delta_R2 V_e d_0 GameParams.P GameParams.Q; ring

/-- D_base(0) = D_I(0) + (N-1)βα(r-1)/N². -/
theorem D_base_zero_eq_DI_plus (p : GameParams) :
    D_base p 0 = D_I p 0 + ((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1) / (p.N : ℝ) ^ 2 := by
  unfold D_I D_base delta_R2 V_e GameParams.P GameParams.Q; ring

-- ===========================================================================
-- Section 6: D_base is affine
-- ===========================================================================

/-- D_base is affine in μ: D_base(μ) = slope · μ + intercept. -/
theorem D_base_affine (p : GameParams) :
    ∀ μ : ℝ, D_base p μ = ((p.P - p.Q) * (p.r - 1)) / (p.N : ℝ) ^ 2 * μ +
      (p.P - p.Q + p.Q * p.β * p.r) / (p.N : ℝ) ^ 2 := by
  intro μ; unfold D_base V_e GameParams.P GameParams.Q; ring

/-- D_base as convex combination of endpoints:
    D_base(μ) = (1-μ) · D_base(0) + μ · D_base(1) for all μ. -/
theorem D_base_convex (p : GameParams) (μ : ℝ) :
    D_base p μ = (1 - μ) * D_base p 0 + μ * D_base p 1 := by
  unfold D_base V_e GameParams.P GameParams.Q; ring

/-- D_I is affine in μ: D_I(μ) = D_base(μ) + δ_R2(μ), both affine. -/
theorem D_I_affine (p : GameParams) :
    ∀ μ : ℝ, ∃ a b : ℝ, D_I p μ = a * μ + b := by
  intro μ
  use ((p.P - p.Q) * (p.r - 1) + ((p.N : ℝ) - 1) * p.β * (p.r - p.α)) / (p.N : ℝ) ^ 2,
      (p.P - p.Q + p.Q * p.β * p.r - ((p.N : ℝ) - 1) * p.β * p.α * (p.r - 1)) / (p.N : ℝ) ^ 2
  unfold D_I D_base delta_R2 V_e GameParams.P GameParams.Q; ring

/-- D_I as convex combination: D_I(μ) = (1-μ)·D_I(0) + μ·D_I(μ_s_R2)
    when μ_s_R2 is the right endpoint (since D_I is affine).
    More generally: for any affine f, f(μ) = (1 - μ/t)·f(0) + (μ/t)·f(t). -/
theorem D_I_convex (p : GameParams) (μ : ℝ) :
    D_I p μ = (1 - μ) * D_I p 0 + μ * D_I p 1 := by
  unfold D_I D_base delta_R2 V_e GameParams.P GameParams.Q; ring

-- ===========================================================================
-- Section 7: Key algebraic identity linking α < α* to P - Q(1-β) > 0
-- ===========================================================================

/-- The key identity: P - Q(1-β) = β(q-1) - α · d_star.
    This means P - Q(1-β) > 0 iff α < β(q-1)/d_star = α*. -/
theorem P_minus_Q_one_minus_beta (p : GameParams) :
    p.P - p.Q * (1 - p.β) = p.β * ((p.q : ℝ) - 1) - p.α * d_star p := by
  unfold GameParams.P GameParams.Q d_star; ring

/-- d_star - d_0 = β(N-1)²(r-1) > 0: threshold nesting. -/
theorem d_star_minus_d_0 (p : GameParams) :
    d_star p - d_0 p = p.β * ((p.N : ℝ) - 1) ^ 2 * (p.r - 1) := by
  unfold d_star d_0; ring

end
