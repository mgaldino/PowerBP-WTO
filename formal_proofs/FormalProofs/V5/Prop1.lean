/-
  Proposition 1 (v5) — Majority rule produces no screening

  Statement (formal_model_v5.Rmd, line 287):
  "Under majority rule with symmetric proposal rights, the hegemon's expected
   continuation value E_θ[V_H^{R1}(θ, μ, M)] is affine in posterior beliefs μ.
   There is no screening cutoff."

  Plus: λ_M > α (Step 6 of B.1, needed for Proposition 4).

  Source: formal_model_v5.Rmd, Appendix B.1 (lines 860-903)
-/

import FormalProofs.Lemma1.Definitions

noncomputable section

-- ===========================================================================
-- Part A: Majority payoff is affine (identical to v2)
-- ===========================================================================

/-- Proposition 1: The majority payoff λ_M · V_e(μ) is affine in μ. -/
theorem v5_prop1_majority_affine (p : GameParams) :
    ∃ a b : ℝ, ∀ μ : ℝ, lambda_M p * V_e p μ = a * μ + b :=
  ⟨lambda_M p * (p.r - 1), lambda_M p,
   fun μ => by unfold lambda_M V_e; ring⟩

-- ===========================================================================
-- Part B: λ_M > α (Step 6 of Appendix B.1)
-- ===========================================================================

/-- λ_M > α: the hegemon captures strictly more than its outside option
    under majority rule. This is the structural property needed for
    Proposition 4, Case (ii).
    Proof: λ_M - α = (1-α)(N - β(q-1)) / N² > 0. -/
theorem v5_lambda_M_gt_alpha (p : GameParams) : lambda_M p > p.α := by
  unfold lambda_M GameParams.P
  -- Goal: (N*(1+(N-1)*α) - β*(q-1)*(1-α)) / N² > α
  rw [gt_iff_lt, lt_div_iff₀ p.n_sq_pos]
  -- Goal: α * N² < N*(1+(N-1)*α) - β*(q-1)*(1-α)
  -- Equivalent to: 0 < (1-α)*(N - β*(q-1))
  -- Since 1-α > 0 and N - β*(q-1) > 0 (β < 1, q-1 < N)
  have hq_lt : p.β * ((p.q : ℝ) - 1) < (p.N : ℝ) := by
    have hq1 := p.q_cast_minus_one_pos
    have hqN := p.n_minus_q_cast_ge_one
    nlinarith [p.hβ1]
  nlinarith [p.one_minus_alpha_pos, p.hβ0]

end
