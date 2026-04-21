/-
  Proposition 2 — Overpayment under unanimity

  Original statement (formal_model_v2.Rmd, line 221):
  "Under unanimity on the conservative branch (μ > μ_s^R2), type θ=0
   receives strictly more than under majority:
   (1 + (N-1)αr) / N > (1 + (N-1)α) / N."

  Proof: αr > α since r > 1 and α > 0.
-/

import FormalProofs.Basic

noncomputable section

/-- The conservative R2 payoff for θ=0 under unanimity: (1 + (N-1)αr) / N. -/
def V_H0_R2_conservative (p : GameParams) : ℝ :=
  (1 + ((p.N : ℝ) - 1) * p.α * p.r) / (p.N : ℝ)

/-- The majority R2 payoff for θ=0: (1 + (N-1)α) / N.
    (Same as aggressive R2 under unanimity.) -/
def V_H0_R2_majority (p : GameParams) : ℝ :=
  (1 + ((p.N : ℝ) - 1) * p.α) / (p.N : ℝ)

/-- Proposition 2: On the conservative R2 branch, θ=0 is overpaid
    relative to majority. The gap is (N-1)α(r-1)/N > 0. -/
theorem prop2_overpayment (p : GameParams) :
    V_H0_R2_conservative p > V_H0_R2_majority p := by
  unfold V_H0_R2_conservative V_H0_R2_majority
  apply div_lt_div_of_pos_right _ p.n_cast_pos
  nlinarith [p.n_minus_one_pos, p.hα0, p.r_minus_one_pos,
             mul_pos p.n_minus_one_pos p.hα0]

/-- The overpayment gap: (N-1)α(r-1)/N > 0. -/
theorem overpayment_gap_pos (p : GameParams) :
    V_H0_R2_conservative p - V_H0_R2_majority p =
    ((p.N : ℝ) - 1) * p.α * (p.r - 1) / (p.N : ℝ) := by
  unfold V_H0_R2_conservative V_H0_R2_majority
  field_simp; ring

end
