/-
  Proposition 3 (v5) — Screening creates an informational rent

  Statement (formal_model_v5.Rmd, line 322):
  "Under unanimity, the hegemon's expected continuation payoff in R1
   has an upward jump at μ_s^{R1}. The magnitude of the jump is:
   Jump = (1 - μ_s^{R1}) · (N-1)β(r-1) / N² > 0."

  (Same result as v2 Proposition 4.)

  Source: formal_model_v5.Rmd, Appendix B.3 (lines 912-914)
-/

import FormalProofs.Lemma1.Corrections

noncomputable section

/-- The R1 screening jump at cutoff μ_s. -/
def v5_screening_jump (p : GameParams) (μ_s : ℝ) : ℝ :=
  (1 - μ_s) * ((p.N : ℝ) - 1) * p.β * (p.r - 1) / (p.N : ℝ) ^ 2

/-- The jump equals δ_R1 from the Theorem 1 decomposition. -/
theorem v5_jump_eq_delta_R1 (p : GameParams) (μ_s : ℝ) :
    v5_screening_jump p μ_s = delta_R1 p μ_s := by
  unfold v5_screening_jump delta_R1; ring

/-- Proposition 3: The screening jump is strictly positive for μ_s < 1. -/
theorem v5_prop3_jump_positive (p : GameParams) (μ_s : ℝ) (hμ : μ_s < 1) :
    v5_screening_jump p μ_s > 0 := by
  rw [v5_jump_eq_delta_R1]
  exact delta_R1_pos p μ_s hμ

/-- The jump is zero at μ = 1 (certainty about θ=1). -/
theorem v5_jump_at_one (p : GameParams) : v5_screening_jump p 1 = 0 := by
  unfold v5_screening_jump; ring

end
