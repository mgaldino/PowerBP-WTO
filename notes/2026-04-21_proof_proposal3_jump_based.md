# Proposal 3: Jump-Based Low-Prior Comparison

**Date**: 2026-04-21
**Status**: VERIFIED — algebra correct, numerically confirmed
**Use**: Subsumed by Strategy C (threshold prior), but structural results (A, B constants; decreasing ratio) are used there.

---

## Key Structural Result

On the conservative R1 branch (mu > mu_s), H's expected payoff under unanimity is **affine in mu**:

$$v(\mu, U)\big|_{\text{con}} = A \cdot V_e(\mu) + B$$

where:
$$A = \frac{N - (N-1)\beta}{N^2}, \qquad B = \frac{(N-1)\beta r(1+N\alpha)}{N^2}$$

**Verification**: Matches paper's R code for all tested parameter sets (r in {1.5, 2, 3, 5}, alpha in {0.05, 0.1, 0.2, 0.3}, N in {3, 5, 7}, beta in {0.8, 0.9, 0.95}).

### Consequence: v(mu,U)/mu is strictly decreasing on Gamma_U

Since v|_con = (A+B) + A(r-1)mu has positive intercept A+B > 0 and positive slope A(r-1) > 0:

$$\frac{v(\mu, U)}{\mu}\bigg|_{\text{con}} = \frac{A+B}{\mu} + A(r-1)$$

This is strictly decreasing (1/mu term). Therefore:

$$S_U^+ = \frac{v(\mu^*, U)}{\mu^*}, \qquad \mu^* = \inf \Gamma_U = \max\{\tau(U), \mu_s\}$$

The supremum is always attained at the left endpoint.

---

## Closed-Form S_U+ (Case 1: tau(U) <= mu_s)

$$S_U^+ = \frac{A + B}{\mu_s} + A(r-1) = \frac{N + (N-1)\beta(r-1+Nr\alpha)}{N^2 \mu_s} + \frac{(N-(N-1)\beta)(r-1)}{N^2}$$

## Closed-Form S_M

$$S_M = \frac{\lambda_M c(r-1)}{c - \kappa_M}$$

where lambda_M = (N(1+(N-1)alpha) - beta(q-1)(1-alpha))/N^2 and kappa_M = (1-alpha)(N(N-1)+beta(q-1))/(N^2(N-1)).

---

## Closed-Form tau(U) on Conservative Branch

$$\tau(U) = \frac{N^2 c - N + \beta(r-1+Nr\alpha)}{(N+\beta)(r-1)}$$

**Caveat**: This formula is valid ONLY when tau(U) falls on the conservative R1 branch (tau(U) > mu_s). When tau(U) is on the aggressive branch (low c), the formula does not apply.

**Verification**: Matches code within 0.0002 for the 2 applicable test cases (r=1.5, alpha=0.3, N=5, beta=0.9 with c=0.15 and c=0.20). Fails for cases where tau(U) is on aggressive branch.

---

## Proposition (Low-Prior Dominance)

If S_U+ > S_M, then for every p in (0, tau(M)): cav v(p,U) > cav v(p,M).

**Proof**: Constructive. The signal {0, mu_hat} under unanimity gives payoff (p/mu_hat)*v(mu_hat, U) = S_U+ * p > S_M * p = cav v(p,M).

---

## Entry Gap Analysis

As r -> infinity:
- tau(M) -> 0
- tau(U) -> beta(1+N*alpha)/(N+beta) (positive constant)
- S_U+/S_M -> infinity (jump contribution dominates)

The gap persists but becomes strategically irrelevant because the screening advantage grows without bound.

---

## Assessment

This proposition is **subsumed by the Strategy C theorem** (threshold prior p*), which covers ALL priors and gives a complete 4-case characterization. The structural results derived here (affine v on conservative branch, decreasing ratio, closed-form tau(U)) are building blocks used in that theorem.
