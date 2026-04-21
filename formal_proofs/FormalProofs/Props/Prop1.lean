/-
  Proposition 1 — Majority rule produces no screening

  Original statement (formal_model_v2.Rmd, line 183):
  "Under majority rule with symmetric proposal rights, the hegemon's expected
   continuation value E_θ[V_H^{R1}(θ, μ, M)] is affine in posterior beliefs μ.
   There is no screening cutoff."

  Proof: Under majority, W's proposal passes without H's vote. H receives
  αV(θ) regardless. E[V_H] = λ_M · V_e(μ), which is affine since V_e is affine.
-/

import FormalProofs.Lemma1.Definitions

noncomputable section

/-- Proposition 1: The majority payoff λ_M · V_e(μ) is affine in μ.
    That is, there exist constants a, b such that λ_M · V_e(μ) = a · μ + b.
    This means there is no screening cutoff (no belief at which behavior
    changes discretely). -/
theorem prop1_majority_affine (p : GameParams) :
    ∃ a b : ℝ, ∀ μ : ℝ, lambda_M p * V_e p μ = a * μ + b := by
  exact ⟨lambda_M p * (p.r - 1), lambda_M p,
         fun μ => by unfold lambda_M V_e; ring⟩

/-- The majority payoff is affine: it has the form λ_M(r-1)·μ + λ_M. -/
theorem majority_payoff_linear (p : GameParams) (μ : ℝ) :
    lambda_M p * V_e p μ = lambda_M p * (p.r - 1) * μ + lambda_M p := by
  unfold lambda_M V_e; ring

end
