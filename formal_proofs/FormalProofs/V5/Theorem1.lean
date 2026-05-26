/-
  Theorem 1 (v5) — Conditional payoff dominance of unanimity

  Statement (formal_model_v5.Rmd, line 423):
  "The condition α < α*(N, β) holds if and only if, for every μ ∈ (0,1],
   E_θ[V_H^{R1}(θ, μ, U)] > E_θ[V_H^{R1}(θ, μ, M)]."

  This is the v5 central theorem. In v2 it was Lemma 1.
  The proof is identical — we re-export from the existing Lemma1 module.

  Source: formal_model_v5.Rmd, Appendix B.5 (lines 1009-1065)
-/

import FormalProofs.Lemma1.Assembly

noncomputable section

-- ===========================================================================
-- Theorem 1: Conditional Payoff Dominance (Biconditional)
-- ===========================================================================

/-- **Theorem 1 (v5)**: α < α*(N, β) if and only if unanimity
    strictly dominates majority in conditional bargaining payoffs
    for every μ ∈ (0, 1].

    The payoff difference D(μ) decomposes piecewise:
    - Region I  (μ < μ_s^R2):  D = D_base + δ_R2
    - Region II (μ_s^R2 < μ < μ_s^R1): D = D_base
    - Region III (μ > μ_s^R1): D = D_base + δ_R1

    Sufficiency: D_base > 0 everywhere, corrections preserve positivity.
    Necessity: D(1) = D_base(1) ≤ 0 when α ≥ α*. -/
theorem v5_theorem1_iff (p : GameParams) :
    p.α < alpha_star p ↔
    (∀ μ : ℝ, 0 < μ → μ ≤ 1 →
      D_base p μ > 0 ∧ D_I p μ > 0 ∧ (D_base p μ + delta_R1 p μ > 0)) :=
  lemma1_iff p

/-- Theorem 1, sufficiency direction only. -/
theorem v5_theorem1_sufficiency (p : GameParams) (hα : p.α < alpha_star p)
    (μ : ℝ) (hμ0 : 0 < μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 ∧ D_I p μ > 0 ∧ (D_base p μ + delta_R1 p μ > 0) :=
  lemma1_conditional_payoff_dominance p hα μ hμ0 hμ1

/-- Theorem 1, necessity direction: α ≥ α* implies ∃ μ where D ≤ 0. -/
theorem v5_theorem1_necessity (p : GameParams) (hα : p.α ≥ alpha_star p) :
    ∃ μ : ℝ, 0 < μ ∧ μ ≤ 1 ∧ D_base p μ + delta_R1 p μ ≤ 0 :=
  lemma1_necessity p hα

end
