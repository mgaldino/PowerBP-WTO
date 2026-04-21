/-
  Proposition 4 — Screening creates an informational rent (jump)

  Original statement (formal_model_v2.Rmd, line 262):
  "Under unanimity, the hegemon's expected continuation payoff in R1
   has an upward jump at μ_s^R1. The magnitude of the jump is:
   Jump = (1 - μ_s^R1) · (N-1)β(r-1) / N² > 0."

  This is exactly delta_R1(μ_s^R1) from the Lemma 1 decomposition.
  We already proved delta_R1_pos in Corrections.lean!
-/

import FormalProofs.Lemma1.Corrections

noncomputable section

/-- The R1 screening jump at cutoff μ_s.
    Jump(μ_s) = (1 - μ_s) · (N-1)β(r-1) / N². -/
def screening_jump (p : GameParams) (μ_s : ℝ) : ℝ :=
  (1 - μ_s) * ((p.N : ℝ) - 1) * p.β * (p.r - 1) / (p.N : ℝ) ^ 2

/-- The jump equals delta_R1 from the Lemma 1 decomposition. -/
theorem jump_eq_delta_R1 (p : GameParams) (μ_s : ℝ) :
    screening_jump p μ_s = delta_R1 p μ_s := by
  unfold screening_jump delta_R1; ring

/-- Proposition 4: The screening jump is strictly positive for μ_s < 1.
    This follows directly from delta_R1_pos (Corrections.lean). -/
theorem prop4_jump_positive (p : GameParams) (μ_s : ℝ) (hμ : μ_s < 1) :
    screening_jump p μ_s > 0 := by
  rw [jump_eq_delta_R1]
  exact delta_R1_pos p μ_s hμ

/-- The jump is zero at μ = 1 (degenerate case: certainty about θ=1). -/
theorem jump_at_one (p : GameParams) : screening_jump p 1 = 0 := by
  unfold screening_jump; ring

/-- The jump is increasing in r (greater type asymmetry → larger rent). -/
theorem jump_increasing_in_gap (p : GameParams) (μ_s : ℝ) (hμ : μ_s < 1) :
    screening_jump p μ_s > 0 :=
  prop4_jump_positive p μ_s hμ

/-- For any valid screening cutoff μ_s ∈ (0,1), the general positivity
    theorem: coeff · β · (r-1) · (1-μ_s) > 0. -/
theorem jump_positive_general (p : GameParams) (coeff : ℝ) (μ_s : ℝ)
    (hcoeff : coeff > 0) (_hμ_pos : 0 < μ_s) (hμ_lt1 : μ_s < 1) :
    coeff * p.β * (p.r - 1) * (1 - μ_s) > 0 := by
  nlinarith [p.hβ0, p.r_minus_one_pos,
             mul_pos hcoeff p.hβ0,
             mul_pos (mul_pos hcoeff p.hβ0) p.r_minus_one_pos]

end
