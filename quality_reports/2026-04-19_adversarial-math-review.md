# Adversarial Mathematical Review: Formal Proofs

**Date**: 2026-04-19
**Reviewer**: Adversarial mathematician (automated)
**Scope**: All formal proofs in `formal_model.Rmd` -- algebra, logic, and rigor only.
**File reviewed**: `formal_model.Rmd` (803 lines)

---

## Summary

I verified every algebraic claim in the paper against independent derivations using symbolic computation (SymPy). The proofs are internally consistent given the paper's primitive objects (Omega, Psi, F^agg, F^con). However, I identify one potentially critical issue with the micro-foundation of the terminal-round aggressive payoff, one major gap in the main theorem, and several minor issues.

| # | Location | Classification | Description |
|---|----------|---------------|-------------|
| 1 | Eq. (3): F^agg(mu) | **CRITICAL** | Non-proposer W's acceptance condition under aggressive offer may be incorrect |
| 2 | Thm 1 (Step 5) | **MAJOR** | Uniqueness of crossover p* not established; Theorem statement presumes it |
| 3 | Lem lem:entry, con. branch | **MINOR** | Arithmetic error in bound: (54+33beta)/972 should be (54+99beta)/972 |
| 4 | Lem lem:entry, agg. branch | **MINOR** | Root product argument imprecisely stated |
| 5 | Thm 1 (Step 3) | **MINOR** | Passage from (0, tau(C)) to [tau(C), tau(A)) needs tighter justification |
| 6 | Prop packageD | **MINOR** | "V_H(D) = V_H(C) = V(theta)/N" is misleading or incorrect as stated |
| 7 | Prop packageB | **MINOR** | V_W(C) > V_W(B) asserted without explicit computation |
| 8 | Rem g_bound | **MINOR** | tau(A) > mu_s not proved in general (only shown numerically) |

---

## Issue 1 [CRITICAL]: Terminal-round aggressive payoff F^agg(mu)

**Location**: Equation (3), Appendix A.2

**Paper claims**:
$$F^{agg}(\mu) = \frac{1 + \mu^2(r-1)}{3}$$

**Problem**: This formula arises from the assumption that the weak proposer (W_j) must pay the non-proposer weak state (W_i) an amount x_{W_i} = V_e(\mu)/3 (the unconditional expected disagreement payoff). However, under the standard game-theoretic analysis:

Under unanimity with simultaneous acceptance, W_i's expected payoff from voting "accept" is:
$$\Pr(\theta=0) \cdot x_{W_i} + \Pr(\theta=1) \cdot r/3 = (1-\mu) x_{W_i} + \mu r/3$$

W_i's expected payoff from voting "reject" is:
$$E[V(\theta)/3 \,|\, \mu] = (1-\mu)/3 + \mu r/3$$

Setting these equal: $(1-\mu) x_{W_i} = (1-\mu)/3$, giving $x_{W_i} = 1/3$.

The key insight is that the $\mu r/3$ terms cancel. Under the aggressive offer, H only accepts when $\theta=0$, so when W_i's vote is pivotal, the disagreement payoff is V(0)/3 = 1/3, not V_e(\mu)/3. This holds whether one uses pivotal voting, simultaneous acceptance, or expected utility analysis.

**With x_{W_i} = 1/3** (instead of V_e(mu)/3):
$$F^{agg}_{corrected}(\mu) = (1-\mu)(1 - 1/3 - 1/3) + \mu \cdot r/3 = V_e(\mu)/3$$

This is **linear in mu**, not quadratic. The paper's formula has $\mu^2$ where it should have $\mu$.

**Consequences if this correction holds**:
- Omega(mu) = V_e(mu)/3 (linear, not quadratic)
- The nonlinearity in beliefs that drives the screening cutoff in R1 is reduced
- The cubic equation for mu_s would change
- Psi(mu) is unaffected (H's payoff under aggressive doesn't depend on x_{W_i})
- The jump at mu_s would change in magnitude
- The mechanism (screening-induced nonlinearity) may survive if the R1 screening problem still generates nonlinearity, but the specific formulas would all need to be re-derived

**Caveat**: The paper may be using a non-standard acceptance protocol where W_i's reservation is set to V_e(mu)/3 without conditioning on H's behavior. If so, this protocol should be explicitly stated, as it departs from standard BF bargaining under asymmetric information. Under any standard simultaneous or sequential acceptance protocol, x_{W_i} = 1/3.

**Verification**: Confirmed via SymPy that the paper's formula matches the assumption x_{W_i} = V_e(mu)/3, and the correct formula (with x_{W_i} = 1/3) gives F^agg = V_e(mu)/3.

---

## Issue 2 [MAJOR]: Uniqueness of crossover p* in Theorem 1

**Location**: Theorem thm:main, Step 5

**Paper claims**: "For p < p*, the hegemon strictly prefers Package C." This implicitly assumes p* is unique (or at least that Delta(p) > 0 for all p below the first crossing).

**Problem**: The proof establishes:
- Delta(p) > 0 for p near 0 (when g > g_bar)
- Delta(p) < 0 for p > tau(A)
- Delta is continuous, so a crossing exists by IVT

This proves *existence* of a p* but not uniqueness. If Delta crosses zero multiple times, the statement "for p < p*" is ambiguous. The theorem would need to specify "p* is the smallest crossing" or prove that the crossing is unique.

To establish uniqueness, one would need to show that Delta is monotonically decreasing on (0, tau(A)), or at least single-crossing. The paper does not address this. If Delta is not monotone, there could be intervals where A dominates interspersed with intervals where C dominates, making the clean partition into "C-preferred" and "A-preferred" regions invalid.

**Fix**: Either (a) prove Delta is single-crossing, or (b) weaken the statement to: "there exists a prior p_0 such that H prefers C at p = p_0, and H prefers A for all p > tau(A)."

---

## Issue 3 [MINOR]: Arithmetic error in Lemma lem:entry (conservative branch bound)

**Location**: Proof of Lemma lem:entry, conservative branch, bound at mu=0

**Paper claims**: Under Assumption P,
$$V_W(C,0) - V_W(A,0) > \frac{54 + 33\beta}{972} > 0$$

**Correct value**:
$$V_W(C,0) - V_W(A,0) > \frac{12-3\beta}{36} - \frac{5(3-2\beta)}{54} = \frac{6 + 11\beta}{108} = \frac{54 + 99\beta}{972}$$

The paper has 33beta where it should be 99beta. The constant term (54/972 = 1/18) is correct. The bound is still strictly positive for all beta > 0, so the conclusion is unaffected.

**Verification**: Confirmed numerically at beta = 0.7: correct bound = 0.1269, paper's bound = 0.0793. Both positive.

---

## Issue 4 [MINOR]: Imprecise statement in Lemma lem:entry (aggressive branch)

**Location**: Proof of Lemma lem:entry, aggressive branch

**Paper claims**: "Since both roots have product exceeding 1, neither root lies in [0,1]."

**Problem**: Product > 1 alone does not imply no root in [0,1]. For example, roots 0.5 and 3 have product 1.5 > 1 but one root is in [0,1].

**Correct argument**: Product > 1 implies the two roots cannot BOTH lie in [0,1] (since the product of two numbers in [0,1] is at most 1). Combined with Q(0) > 0 and Q(1) > 0 (both verified), no root can lie in [0,1]. (If one root were in (0,1), the parabola, which opens upward, would be negative inside the root interval. Since Q(0) > 0 and Q(1) > 0, both endpoints would need to be outside the root interval. With only one root in (0,1), the other root would also need to be in (0,1) to make Q negative in (0,1). But that contradicts product > 1.)

The underlying logic is valid. The statement should be: "Since Q(0) > 0, Q(1) > 0, and the product of roots exceeds 1, no root lies in [0,1]."

---

## Issue 5 [MINOR]: Step 3 of Theorem 1 — passage to [tau(C), tau(A))

**Location**: Theorem thm:main, Step 3, second paragraph

**Paper claims**: "For priors in [tau(C), tau(A)), Package C yields v(p,C) = g + E[V_H(C,p)] > 0 while cav v(p,A) = S_A * p; for g > g_bar the same slope comparison implies cav v(p,C) >= v(p,C) > cav v(p,A)."

**Problem**: The "slope comparison" argument is imprecise. For p in [tau(C), tau(A)):
- v(p,C) = g + E[V_H(C,p)] (no persuasion needed; institution forms under C)
- cav v(p,A) = S_A * p (persuasion needed under A; p is below tau(A))

The claim v(p,C) > cav v(p,A) reduces to:
$$g + E[V_H(C,p)] > S_A \cdot p = \frac{g + V_e(\tau(A))(6-\beta)/6}{\tau(A)} \cdot p$$

Since p < tau(A), the coefficient of g on the RHS is p/tau(A) < 1, while the coefficient of g on the LHS is 1. So for sufficiently large g, the inequality holds. But this requires g to be large enough to overcome the bargaining-value terms, and the paper does not verify this separately (it relies on "the same slope comparison," which was derived for p < tau(C)).

The fix is straightforward: note that for g > g_bar, v(p,C) = g(1 - p/tau(A)) + [E[V_H(C,p)] - V_e(tau(A))(6-beta)p/(6*tau(A))] and the first term dominates for large g.

---

## Issue 6 [MINOR]: Proposition packageD — misleading equality

**Location**: Proposition prop:packageD

**Paper states**: "all players receive V_i(D) = V(theta)/N by symmetry. Therefore V_H(D) = V_H(C) = V(theta)/N"

**Problem**: The equality V_H(C) = V(theta)/N is incorrect as a general statement about Package C. Throughout the paper, V_H(C,mu) is a complex piecewise function with aggressive and conservative branches, a screening cutoff, and a jump discontinuity. It is NOT equal to V(theta)/N.

The proposition likely intends to compare the symmetric-recognition BF subgame outcomes. Under symmetric recognition with known theta, all players get V(theta)/N under both majority (D) and unanimity (C). But this comparison strips away the asymmetric information that generates the screening problem.

**Fix**: Rewrite as "V_H(D) = V(theta)/N, which equals the disagreement payoff and offers no surplus extraction. Package D thus provides H no advantage relative to C (where H can extract via screening) and is strictly dominated by A."

---

## Issue 7 [MINOR]: Proposition packageB — incomplete proof

**Location**: Proof of Proposition prop:packageB

**Paper claims**: "Under Package C with symmetric recognition, V_W(C) > V_W(B) because weak states sometimes propose and capture surplus."

**Problem**: This is a verbal argument, not a formal proof. While the intuition is correct (W's sometimes propose under C and capture proposer surplus, which they never do under B), a one-line computation of V_W(C) - V_W(B) would make the proof complete. Given that V_W(C) and V_W(B) are both derived earlier, this is easy to add.

---

## Issue 8 [MINOR]: Remark rem:g_bound — tau(A) > mu_s not proved

**Location**: Remark rem:g_bound

**Paper claims**: "the screening threshold lies below the majority entry threshold in the parameter range of interest" and provides numerical verification (mu_s approx 0.264, tau(A) approx 0.429).

**Problem**: This ordering is demonstrated numerically but not proved analytically. The formula for g_bar has denominator tau(A) - mu_s, which must be positive. While the ordering likely holds throughout the relevant parameter range, a brief argument (or at minimum an explicit statement that this is verified numerically) would strengthen the claim.

---

## Verified Claims (No Issues Found)

The following have been verified to be algebraically correct:

1. **Lemma lem:screening**: The cubic equation (Eq. 6) is the correct condition for Delta_1 = 0 (confirmed: Delta_1 = cubic/9). The Descartes sign analysis is correct: sign pattern (+,+,-,+), two sign changes, f(0) > 0, f(1) = 9r(beta-1) < 0, f -> +inf. Uniqueness argument via accounting for both positive roots is valid.

2. **Lemma lem:pointwise, aggressive branch**: V_H(A) - V_H(C) = V_e(12-7beta)/18 + 2beta[3+(r-1)(mu^2+2mu)]/27. Verified by SymPy. The bound (18+33beta)/162 at mu=0 is correct.

3. **Lemma lem:pointwise, conservative branch**: V_H(A) - V_H(C) = V_e(4-beta)/6 - 2beta(r-1)(5-4mu-mu^2)/27. Verified by SymPy. The derivative (r-1)[(4-beta)/6 + 2beta(4+2mu)/27] is correct and positive.

4. **Lemma lem:entry, conservative branch formula**: V_W(C) - V_W(A) = V_e(12-3beta)/36 + beta(r-1)(mu^2+4mu-5)/27. Verified by SymPy.

5. **Lemma lem:entry, aggressive branch formula**: The quadratic [4beta(r-1)mu^2 + (23beta*r+13beta-36)mu + (36-9beta)]/108. Verified by SymPy.

6. **Jump magnitude** (Appendix A.4): 10beta(r-1)(1-mu_s)/27. Verified by SymPy.

7. **Entry threshold tau(A)**: (12c-beta)/(12+beta(r-1)). Verified algebraically and numerically.

8. **Theorem 1, Steps 1-4**: Logic is sound (given the paper's primitive objects). Concavification arguments, asymptotic dominance, and pointwise bounding are correct.

---

## Overall Assessment

**Conditional on F^agg being correct** (Issue 1 resolved or the acceptance protocol justified): The proofs are sound with one major gap (uniqueness of crossover, Issue 2) and several minor issues. The algebra is remarkably clean and has been verified symbolically.

**If Issue 1 is a genuine error**: The entire mechanism may need to be re-derived. The quadratic nonlinearity in Omega(mu) -- which drives the screening cutoff and the jump discontinuity -- traces directly to the mu^2 term in F^agg. If the correct F^agg is linear (V_e(mu)/3), the R2 continuation becomes linear, and the R1 screening problem must be analyzed with different Omega. The mechanism may survive (R1 still has a screening choice), but the specific formulas, cutoff location, jump magnitude, and all downstream results would change.

**Recommendation**: Address Issue 1 by either (a) providing an explicit micro-foundation for x_{W_i} = V_e(mu)/3 under the aggressive offer (e.g., specifying a non-standard acceptance protocol and justifying it), or (b) re-deriving the model with x_{W_i} = 1/3 and checking whether the mechanism survives.
