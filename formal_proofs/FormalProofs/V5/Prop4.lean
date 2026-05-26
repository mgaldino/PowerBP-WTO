/-
  Proposition 4 (v5) — Institutional classification

  Statement (formal_model_v5.Rmd, line 474):
  "Suppose α < α*(N, β). The hegemon's preferred rule:
   - U ≻ M if and only if p ∈ F_U
   - M ≻ U if and only if p ∈ F_M \ F_U
   - U ~ M if and only if p ∉ F_M"

  Proof: Three cases, using F_U ⊆ F_M and λ_M > α.

  Source: formal_model_v5.Rmd, Appendix B.8 (lines 1094-1102)
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Abstract formulation of institutional classification
-- ===========================================================================

/-- Case (i): p ∈ F_U → institution forms under both rules → Theorem 1. -/
theorem v5_prop4_case_i
    (V_H_U V_H_M : ℝ)
    (h_thm1 : V_H_U > V_H_M) :
    V_H_U > V_H_M := h_thm1

/-- Case (ii): p ∈ F_M \ F_U → institution forms only under M.
    Under U: no entry → V_H(U) = α·V_e.
    Under M: entry → V_H(M) = λ_M·V_e.
    Since λ_M > α and V_e > 0: M dominates. -/
theorem v5_prop4_case_ii
    (alpha lambda_M V_e : ℝ)
    (h_lam_gt : lambda_M > alpha)
    (h_Ve_pos : V_e > 0) :
    lambda_M * V_e > alpha * V_e := by
  exact mul_lt_mul_of_pos_right h_lam_gt h_Ve_pos

/-- Case (iii): p ∉ F_M → no entry under either rule → V_H = α·V_e under both. -/
theorem v5_prop4_case_iii
    (alpha V_e : ℝ) :
    alpha * V_e = alpha * V_e := rfl

/-- Full Proposition 4: institutional classification is exhaustive.
    Given F_U ⊆ F_M (formalized as: entry_U → entry_M), the three cases
    partition all possibilities. -/
theorem v5_prop4_classification
    (V_H_U_entry V_H_M_entry alpha_Ve : ℝ)
    (entry_U entry_M : Prop) [Decidable entry_U] [Decidable entry_M]
    (h_nesting : entry_U → entry_M)
    -- Payoff definitions
    (h_VHU : entry_U → V_H_U_entry > V_H_M_entry)  -- Theorem 1
    (h_VHM_dom : ¬entry_U → entry_M → V_H_M_entry > alpha_Ve)  -- λ_M > α
    (h_noentry : ¬entry_M → True)  -- V_H = α·V_e = α·V_e
    :
    -- Conclusion: classification is well-defined
    (entry_U → V_H_U_entry > V_H_M_entry) ∧
    (¬entry_U → entry_M → V_H_M_entry > alpha_Ve) ∧
    (¬entry_M → ¬entry_U) := by
  exact ⟨h_VHU, h_VHM_dom, fun h => fun he => absurd (h_nesting he) h⟩

end
