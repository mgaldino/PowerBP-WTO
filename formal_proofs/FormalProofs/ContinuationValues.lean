/-
  Continuation Values — General-N definitions from Appendix B

  All algebraic objects needed for the single-crossing proof.
  Source: formal_model.Rmd, Appendix B (lines 518-609).
-/

import FormalProofs.Basic

noncomputable section

-- ===========================================================================
-- Section 1: Terminal-round continuation values (general N)
-- ===========================================================================

/-- Weak player's terminal continuation value, aggressive branch (Appendix B.1):
    Ω^a(μ) = [N + (r-1)μ(μ + N - 1)] / N². -/
def Omega_a (p : GameParams) (μ : ℝ) : ℝ :=
  ((p.N : ℝ) + (p.r - 1) * μ * (μ + (p.N : ℝ) - 1)) / (p.N : ℝ) ^ 2

/-- Weak player's terminal continuation value, conservative branch (Appendix B.1):
    Ω^c(μ) = [N + 1 - r + (r-1)(μ² + Nμ)] / N². -/
def Omega_c (p : GameParams) (μ : ℝ) : ℝ :=
  ((p.N : ℝ) + 1 - p.r + (p.r - 1) * (μ ^ 2 + (p.N : ℝ) * μ)) / (p.N : ℝ) ^ 2

-- ===========================================================================
-- Section 2: Low-type hegemon continuation (general N)
-- ===========================================================================

/-- Low-type hegemon's continuation, aggressive branch: φ^a = 1/N. -/
def phi_a (p : GameParams) : ℝ := 1 / (p.N : ℝ)

/-- Low-type hegemon's continuation, conservative branch:
    φ^c = [1 + (N-1)r] / N². -/
def phi_c (p : GameParams) : ℝ :=
  (1 + ((p.N : ℝ) - 1) * p.r) / (p.N : ℝ) ^ 2

-- ===========================================================================
-- Section 3: Branch point
-- ===========================================================================

/-- Branch point where the terminal-round weak proposer switches
    from aggressive to conservative: m_N = 1/(N-2). -/
def m_N (p : GameParams) : ℝ := 1 / ((p.N : ℝ) - 2)

-- ===========================================================================
-- Section 4: Monotonicity polynomials (Appendix B.2)
-- ===========================================================================

/-- Monotonicity polynomial on aggressive branch (Appendix B.2):
    Q_a(μ) = -2N - 2(N-2)(N-1)μ + (N-2)(N-4)μ² + 2(N-2)μ³. -/
def Q_a (p : GameParams) (μ : ℝ) : ℝ :=
  -2 * (p.N : ℝ) - 2 * ((p.N : ℝ) - 2) * ((p.N : ℝ) - 1) * μ +
  ((p.N : ℝ) - 2) * ((p.N : ℝ) - 4) * μ ^ 2 + 2 * ((p.N : ℝ) - 2) * μ ^ 3

/-- Monotonicity polynomial on conservative branch (Appendix B.2):
    Q_c(μ) = -(N+2) - 2N(N-2)μ + (N-2)(N-3)μ² + 2(N-2)μ³. -/
def Q_c (p : GameParams) (μ : ℝ) : ℝ :=
  -((p.N : ℝ) + 2) - 2 * (p.N : ℝ) * ((p.N : ℝ) - 2) * μ +
  ((p.N : ℝ) - 2) * ((p.N : ℝ) - 3) * μ ^ 2 + 2 * ((p.N : ℝ) - 2) * μ ^ 3

-- ===========================================================================
-- Section 5: Numerator of G' (for proving G is strictly decreasing)
-- ===========================================================================

/-- Numerator of G'(μ) on the aggressive branch (Appendix B.2):
    num_a(μ) = (1-β)(-N² + (r-1)Q_a(μ)) - (r-1)(N-2)(N+2μ)(1-μ)². -/
def G_deriv_num_a (p : GameParams) (μ : ℝ) : ℝ :=
  (1 - p.β) * (-(p.N : ℝ) ^ 2 + (p.r - 1) * Q_a p μ) -
  (p.r - 1) * ((p.N : ℝ) - 2) * ((p.N : ℝ) + 2 * μ) * (1 - μ) ^ 2

/-- Numerator of G'(μ) on the conservative branch (Appendix B.2):
    num_c(μ) = (1-β)(-N² + (r-1)Q_c(μ)) - (r-1)(N-2)(N+2μ+1)(1-μ)². -/
def G_deriv_num_c (p : GameParams) (μ : ℝ) : ℝ :=
  (1 - p.β) * (-(p.N : ℝ) ^ 2 + (p.r - 1) * Q_c p μ) -
  (p.r - 1) * ((p.N : ℝ) - 2) * ((p.N : ℝ) + 2 * μ + 1) * (1 - μ) ^ 2

-- ===========================================================================
-- Section 6: Boundary values of the screening difference (Appendix B.3)
-- ===========================================================================

/-- Boundary value at μ = 0: Δ(0) = β(r-1)(2N-1) / N². -/
def boundary_at_zero (p : GameParams) : ℝ :=
  p.β * (p.r - 1) * (2 * (p.N : ℝ) - 1) / (p.N : ℝ) ^ 2

/-- Boundary value at μ = 1: Δ(1) = r(β - 1). -/
def boundary_at_one (p : GameParams) : ℝ :=
  p.r * (p.β - 1)

end
