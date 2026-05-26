/-
  Corollary (v5) — Unanimity dominance on the formation set

  Statement (formal_model_v5.Rmd, line 452):
  "Suppose α < α*(N, β). For every prior p ∈ F_U,
   V_H(U, p) > V_H(M, p)."

  Also: F_U ⊆ F_M (unanimity formation set is subset of majority).

  Proof sketch:
  1. Budget identity: V_H + (N-1)V_W = V_e (majority, exact)
  2. Budget inequality: V_H + (N-1)V_W ≤ V_e (unanimity, surplus destruction)
  3. Theorem 1: V_H(U) > V_H(M) ⟹ V_W(U) < V_W(M)
  4. Hence F_U ⊆ F_M

  This proof is formalized at an ABSTRACT level: we take the budget identities
  and Theorem 1 as hypotheses, and derive the corollary logically.

  Source: formal_model_v5.Rmd, Appendix B.6 (lines 1066-1070)
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Abstract formulation (does not depend on concrete payoff algebra)
-- ===========================================================================

/-- If V_H(U) > V_H(M) and V_H(R) + (N-1)V_W(R) = V_e for majority
    while V_H(U) + (N-1)V_W(U) ≤ V_e for unanimity,
    then V_W(M) > V_W(U). -/
theorem v5_weak_state_prefers_majority
    (V_H_U V_H_M V_W_U V_W_M V_e : ℝ) (N : ℝ) (hN : N > 1)
    (h_budget_M : V_H_M + (N - 1) * V_W_M = V_e)
    (h_budget_U : V_H_U + (N - 1) * V_W_U ≤ V_e)
    (h_dom : V_H_U > V_H_M) :
    V_W_M > V_W_U := by
  have hN1 : N - 1 > 0 := by linarith
  -- Contraposição: V_W_M ≤ V_W_U → contradição com V_H_U > V_H_M
  by_contra h_not
  push Not at h_not
  -- V_W_M ≤ V_W_U com N-1 > 0 → (N-1)V_W_M ≤ (N-1)V_W_U
  -- Cadeia: V_H_M = V_e - (N-1)V_W_M ≥ V_e - (N-1)V_W_U ≥ V_H_U
  -- Contradição com V_H_U > V_H_M
  linarith [mul_le_mul_of_nonneg_left h_not (le_of_lt hN1)]

/-- If V_W(M) > V_W(U) for all beliefs, and V_W(p,U) ≥ c (entry under U),
    then V_W(p,M) > c (entry under M). Hence F_U ⊆ F_M. -/
theorem v5_formation_set_nesting
    (V_W_U V_W_M : ℝ) (c : ℝ)
    (h_VW : V_W_M > V_W_U)
    (h_entry_U : V_W_U ≥ c) :
    V_W_M > c := by linarith

/-- Corollary: On the formation set F_U, unanimity dominates majority.
    If entry occurs under unanimity (V_W(p,U) ≥ c), then:
    1. Entry also occurs under majority (V_W(p,M) > c)
    2. V_H(U,p) > V_H(M,p) (by Theorem 1) -/
theorem v5_corollary_unanimity_dominates_on_FU
    (V_H_U V_H_M V_W_U V_W_M V_e : ℝ) (N : ℝ) (c : ℝ)
    (hN : N > 1)
    (h_budget_M : V_H_M + (N - 1) * V_W_M = V_e)
    (h_budget_U : V_H_U + (N - 1) * V_W_U ≤ V_e)
    (h_thm1 : V_H_U > V_H_M)
    (h_entry_U : V_W_U ≥ c) :
    V_H_U > V_H_M ∧ V_W_M > c := by
  constructor
  · exact h_thm1
  · exact v5_formation_set_nesting V_W_U V_W_M c
      (v5_weak_state_prefers_majority V_H_U V_H_M V_W_U V_W_M V_e N hN
        h_budget_M h_budget_U h_thm1) h_entry_U

end
