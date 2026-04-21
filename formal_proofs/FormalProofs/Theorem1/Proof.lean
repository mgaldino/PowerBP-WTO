/-
  Theorem 1 — Proof (Threshold Prior for Institutional Choice)

  Four cases with single-crossing property.
  Uses the modular hypotheses from Hypotheses.lean.

  Original statement (formal_model_v2.Rmd, lines 555-572):
  "Suppose alpha < alpha*(N, beta). The comparison between cav v(p, U)
   and cav v(p, M) has the following structure:
   (a) tau_U = 0: unanimity dominates for all p in (0,1).
   (b) tau_M = 0 < tau_U: unique crossing at p* in (0, tau_U).
   (c) 0 < tau_M <= tau_U, S_U > S_M: unanimity dominates.
   (d) 0 < tau_M <= tau_U, S_U <= S_M: unique crossing at p* in [tau_M, tau_U]."

  Source: notes/2026-04-21_revised_theorem1_threshold_prior.md
-/

import FormalProofs.Theorem1.Hypotheses

noncomputable section

-- ===========================================================================
-- Case (a): tau_U = 0 implies unanimity dominates everywhere
-- ===========================================================================

/-- Case (a): When tau_U = 0, entry always occurs under both rules.
    By Lemma 1 (D_base_pos), v(mu, U) > v(mu, M) for all mu in (0, 1].
    Since both cav values equal the actual values (no entry barrier),
    cav_U(p) > cav_M(p) for all p in (0, 1].

    In this formalization: tau_U = 0 implies tau_M = 0 (from tau_M <= tau_U).
    The comparison reduces to Lemma 1 directly.

    We state this as: D_base(mu) > 0 for all mu in (0, 1], which we
    already proved in Lemma 1. -/
theorem case_a (p : GameParams) (hα : p.α < alpha_star p)
    (h : Theorem1Hyps p) (_htau_zero : h.tau_U = 0)
    (μ : ℝ) (hμ0 : 0 < μ) (hμ1 : μ ≤ 1) :
    D_base p μ > 0 :=
  D_base_pos p hα μ (le_of_lt hμ0) hμ1

-- ===========================================================================
-- Case (b): tau_M = 0 < tau_U implies unique crossing
-- ===========================================================================

/-- Case (b): When tau_M = 0 < tau_U, there exists a unique threshold
    p* = lambda_M / (S_U - lambda_M(r-1)) in (0, tau_U) such that:
    - D_low(p) < 0 for p < p* (majority dominates)
    - D_low(p) > 0 for p > p* (unanimity dominates)
    - For p >= tau_U, unanimity dominates by Step 1 (Lemma 1). -/
theorem case_b (p : GameParams) (h : Theorem1Hyps p)
    (_htau_M_zero : h.tau_M = 0) (htau_U_pos : h.tau_U > 0) :
    -- p* exists in (0, tau_U)
    0 < p_star p h ∧ p_star p h < h.tau_U ∧
    -- D_low(p*) = 0 (exact crossing)
    D_low p h (p_star p h) = 0 ∧
    -- Below p*: majority dominates
    (∀ μ, μ < p_star p h → D_low p h μ < 0) ∧
    -- Above p*: unanimity dominates
    (∀ μ, μ > p_star p h → D_low p h μ > 0) := by
  exact ⟨p_star_pos p h htau_U_pos,
         p_star_lt_tau_U p h htau_U_pos,
         D_low_at_p_star p h htau_U_pos,
         fun μ hμ => D_low_neg_below p h htau_U_pos μ hμ,
         fun μ hμ => D_low_pos_above p h htau_U_pos μ hμ⟩

-- ===========================================================================
-- Case (c): 0 < tau_M <= tau_U, S_U > S_M implies unanimity dominates
-- ===========================================================================

/-- Case (c): When 0 < tau_M <= tau_U and S_U > S_M, unanimity strictly
    dominates for all p in (0, 1).
    - For p < tau_M: S_U * p > S_M * p (since S_U > S_M).
    - For tau_M <= p < tau_U: D_low(tau_M) = (S_U - S_M) * tau_M > 0
      and D_low(tau_U) > 0, so D_low > 0 (positive slope, positive at tau_M).
    - For p >= tau_U: Step 1 (Lemma 1). -/
theorem case_c (p : GameParams) (h : Theorem1Hyps p)
    (htau_M_pos : h.tau_M > 0) (htau_U_pos : h.tau_U > 0)
    (hS : h.S_U > S_M p h) :
    -- Below tau_M: S_U * p > S_M * p
    (∀ μ, 0 < μ → μ < h.tau_M → h.S_U * μ > S_M p h * μ) ∧
    -- Between tau_M and tau_U: D_low > 0
    (∀ μ, h.tau_M ≤ μ → D_low p h μ > 0) := by
  constructor
  · -- Below tau_M: S_U > S_M and mu > 0 → S_U * mu > S_M * mu
    intro μ hμ0 _
    nlinarith
  · -- Between tau_M and tau_U: D_low is linear with D_low(tau_M) > 0
    -- and positive slope, so D_low(mu) >= D_low(tau_M) > 0 for mu >= tau_M.
    intro μ hμ_ge
    have hsl := D_low_slope_pos p h htau_U_pos
    have hge : D_low p h μ ≥ D_low p h h.tau_M := by
      unfold D_low V_e; unfold D_low_slope at hsl; nlinarith
    have hD_tau_M : D_low p h h.tau_M > 0 := by
      rw [D_low_at_tau_M p h htau_M_pos]; nlinarith
    linarith

-- ===========================================================================
-- Case (d): 0 < tau_M <= tau_U, S_U <= S_M implies unique crossing
-- ===========================================================================

/-- Case (d): When 0 < tau_M <= tau_U and S_U <= S_M, there is a unique
    crossing point p* in [tau_M, tau_U].
    - For p < tau_M: S_U * p <= S_M * p (majority weakly dominates).
    - D_low(tau_M) = (S_U - S_M) * tau_M <= 0 and D_low(tau_U) > 0,
      so D_low crosses zero once in [tau_M, tau_U].
    - For p >= tau_U: unanimity dominates (Step 1). -/
theorem case_d (p : GameParams) (h : Theorem1Hyps p)
    (htau_M_pos : h.tau_M > 0) (htau_U_pos : h.tau_U > 0)
    (hS : h.S_U ≤ S_M p h) :
    -- Below tau_M: majority weakly dominates
    (∀ μ, 0 < μ → h.S_U * μ ≤ S_M p h * μ) ∧
    -- D_low(tau_M) <= 0
    D_low p h h.tau_M ≤ 0 ∧
    -- Unique crossing in [tau_M, tau_U]
    (h.tau_M ≤ p_star p h ∧ p_star p h < h.tau_U) ∧
    -- Below p*: D_low <= 0
    (∀ μ, μ < p_star p h → D_low p h μ < 0) ∧
    -- Above p*: D_low > 0
    (∀ μ, μ > p_star p h → D_low p h μ > 0) := by
  have hD_tau_M_le : D_low p h h.tau_M ≤ 0 := by
    rw [D_low_at_tau_M p h htau_M_pos]; nlinarith
  have hp_pos := p_star_pos p h htau_U_pos
  have hp_lt := p_star_lt_tau_U p h htau_U_pos
  have hp_zero := D_low_at_p_star p h htau_U_pos
  -- p* >= tau_M: since D_low(tau_M) <= 0 = D_low(p*) and slope > 0, tau_M <= p*
  have hp_ge_tau_M : h.tau_M ≤ p_star p h := by
    by_contra h_lt
    push Not at h_lt
    -- tau_M > p*, so D_low(tau_M) > D_low(p*) = 0 (slope positive)
    have := D_low_pos_above p h htau_U_pos h.tau_M h_lt
    linarith
  exact ⟨fun μ hμ0 => by nlinarith,
         hD_tau_M_le,
         ⟨hp_ge_tau_M, hp_lt⟩,
         fun μ hμ => D_low_neg_below p h htau_U_pos μ hμ,
         fun μ hμ => D_low_pos_above p h htau_U_pos μ hμ⟩

-- ===========================================================================
-- Main Theorem: Single-crossing property
-- ===========================================================================

/-- **Theorem 1 (Threshold Prior for Institutional Choice)**

    Suppose alpha < alpha*(N, beta). The institutional comparison has the
    single-crossing property: there exists at most one prior p* at which
    the ranking changes from majority to unanimity.

    This is the conjunction of:
    - Case (a): tau_U = 0 implies no crossing (unanimity dominates everywhere)
    - Case (b): tau_M = 0 < tau_U implies exactly one crossing
    - Case (c): S_U > S_M implies no crossing (unanimity dominates everywhere)
    - Case (d): S_U <= S_M implies exactly one crossing

    The crossing point, when it exists, is p* = lambda_M / (S_U - lambda_M(r-1)).

    Formally, we express the single-crossing property as:
    D_low has at most one zero on (0, tau_U), and is positive above tau_U. -/
theorem theorem1_single_crossing (p : GameParams) (_hα : p.α < alpha_star p)
    (h : Theorem1Hyps p) (htau_U_pos : h.tau_U > 0) :
    -- p* is the unique zero of D_low
    D_low p h (p_star p h) = 0 ∧
    0 < p_star p h ∧
    p_star p h < h.tau_U ∧
    -- Single-crossing: negative below, positive above
    (∀ μ, 0 < μ → μ < p_star p h → D_low p h μ < 0) ∧
    (∀ μ, μ > p_star p h → D_low p h μ > 0) :=
  ⟨D_low_at_p_star p h htau_U_pos,
   p_star_pos p h htau_U_pos,
   p_star_lt_tau_U p h htau_U_pos,
   fun μ _ hμ => D_low_neg_below p h htau_U_pos μ hμ,
   fun μ hμ => D_low_pos_above p h htau_U_pos μ hμ⟩

end
