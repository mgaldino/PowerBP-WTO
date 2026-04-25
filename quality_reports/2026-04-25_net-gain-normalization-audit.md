# Audit: Net-Gain Normalization in Theorems 1 & 2

**Date**: 2026-04-25  
**Auditor**: Fresh reviewer (Claude)  
**File**: `formal_model_v3.Rmd`  
**Scope**: Verify that ALL steps in B.6 (Theorem 1) and B.8 (Theorem 2) are consistent with the net-gain definition v(mu, R) = E[V_H^R1] - alpha * V_e(mu).

---

## Summary

**VERIFIED** -- All checks pass. The normalization change is consistently applied throughout Theorems 1 and 2 and their proofs.

---

## B.6 Proof of Theorem 1 (Dominance of unanimity)

### Check 1: First paragraph (E_U subset of E_M via budget identity)

**PASS.**

The first paragraph (line 1089) operates entirely on ABSOLUTE payoffs: "E[V_H(mu, M)] + (N-1)V_W(mu, M) = V_e(mu)" and "E[V_H(mu, U)] > E[V_H(mu, M)]" (from Lemma 1). The conclusion V_W(mu, U) < V_W(mu, M) and hence E_U subset of E_M is derived from absolute payoffs. No reference to v (net gain) is needed or made in this step. Correct.

### Check 2: "v(p, U) > v(p, M)" justified by Lemma 1

**PASS.**

Lemma 1 (line 498-506) establishes:
  E[V_H^R1(theta, mu, U)] > E[V_H^R1(theta, mu, M)]  for all mu in (0,1].

The net gains are:
  v(mu, U) = E[V_H^R1(mu, U)] - alpha * V_e(mu)
  v(mu, M) = E[V_H^R1(mu, M)] - alpha * V_e(mu) = (lambda_M - alpha) * V_e(mu)

Subtracting: v(mu, U) - v(mu, M) = E[V_H^R1(mu, U)] - E[V_H^R1(mu, M)] = D(mu) > 0.

The alpha * V_e(mu) terms cancel identically, so Lemma 1 on absolute payoffs directly implies the net-gain comparison. Correct.

### Check 3: v(mu, M) = (lambda_M - alpha)[1 + (r-1)mu]

**PASS.**

Under majority, E[V_H^R1(mu, M)] = lambda_M * V_e(mu) where lambda_M = [N(1+(N-1)alpha) - C_buy] / N^2.

So: v(mu, M) = lambda_M * V_e(mu) - alpha * V_e(mu) = (lambda_M - alpha) * V_e(mu)
            = (lambda_M - alpha) * [1 + (r-1)mu].

This matches line 1091. Correct.

**Verification that (lambda_M - alpha) > 0:**

lambda_M - alpha = [N(1+(N-1)alpha) - C_buy - alpha*N^2] / N^2
                 = [N + N(N-1)alpha - alpha*N^2 - beta(q-1)(1-alpha)] / N^2
                 = [N(1-alpha) - beta(q-1)(1-alpha)] / N^2
                 = (1-alpha)[N - beta(q-1)] / N^2

Since alpha in (0, 1/r) with r > 1 implies alpha < 1, and N >= 3 with q = floor(N/2)+1 implies q-1 <= N-1 and beta < 1, so beta(q-1) < N-1 < N. Hence (lambda_M - alpha) > 0.

The proof (line 1127) states: "(lambda_M - alpha) > 0 because (1-alpha)[N - beta(q-1)] > 0". This matches exactly. Correct.

### Check 4: Bound sum pi_s v(mu_s, M) <= v(p, M)

**PASS.**

Line 1094:
  sum pi_s v(mu_s, M) = sum_{s in A} pi_s (lambda_M - alpha)[1 + (r-1)mu_s]
                      = (lambda_M - alpha) [sum_{A} pi_s + (r-1) sum_{A} pi_s mu_s]
                      <= (lambda_M - alpha) [1 + (r-1)p] = v(p, M).

The key step uses (lambda_M - alpha) > 0 (verified above) to ensure the inequality direction is correct when bounding sum_{A} pi_s <= 1 and sum_{A} pi_s mu_s <= p. With the old lambda_M coefficient, the same logic applied; replacing lambda_M by (lambda_M - alpha) changes nothing structurally since both are positive. Correct.

### Check 5: cav v(p, M) = v(p, M) for p in E_M

**PASS.**

The bound in Check 4 shows that NO Bayes-plausible experiment can improve on v(p, M) when p in E_M. Since the trivial experiment (no information) achieves v(p, M), we get cav v(p, M) = v(p, M). This follows from the linearity of v(mu, M) = (lambda_M - alpha) V_e(mu) on E_M = [tau(M), 1] combined with v(mu, M) = 0 below tau(M). The only possible gain from persuasion would be to avoid the zero-payoff region, but since p is already in E_M, all mass is above tau(M). The argument is correct with (lambda_M - alpha).

### Check 6: Final comparison line

**PASS.**

Line 1099: "Pi_H*(U, p) > Pi_H*(M, p) iff cav v(p, U) > cav v(p, M). We have cav v(p, U) >= v(p, U) > v(p, M) = cav v(p, M)."

Chain of reasoning:
1. Pi_H*(R, p) = alpha * V_e(p) + cav v(p, R) -- by definition (line 428, 527)
2. alpha * V_e(p) is common => comparison reduces to cav v
3. cav v(p, U) >= v(p, U) -- by definition of concave envelope
4. v(p, U) > v(p, M) -- by Check 2 (Lemma 1)
5. v(p, M) = cav v(p, M) -- by Check 5 (p in E_M since E_U subset E_M)

Every step is valid. Correct.

---

## B.8 Proof of Theorem 2 (Single-crossing)

### Check 1: m(p) = (lambda_M - alpha) V_e(p) and S_M formula

**PASS.**

Line 1127 defines m(p) = cav v(p, M). Since v(mu, M) = (lambda_M - alpha) V_e(mu) for mu in E_M = [tau(M), 1] and v(mu, M) = 0 below tau(M), the concave envelope is:
- m(p) = S_M * p for p <= tau(M), where S_M = (lambda_M - alpha) V_e(tau(M)) / tau(M)
- m(p) = (lambda_M - alpha) V_e(p) for p >= tau(M)

This is the standard concavification of a function that is zero below a threshold and affine above: the envelope connects the origin to the point (tau(M), v(tau(M), M)) by a ray, then follows the affine function. Correct.

### Check 2: m(p)/p is weakly decreasing

**PASS.**

On (0, tau(M)]: m(p)/p = S_M (constant).
On [tau(M), 1]: m(p)/p = (lambda_M - alpha) V_e(p)/p = (lambda_M - alpha)(1 + (r-1)p)/p = (lambda_M - alpha)[1/p + (r-1)].

Since (lambda_M - alpha) > 0 and 1/p is strictly decreasing, m(p)/p is strictly decreasing on (tau(M), 1]. At p = tau(M), continuity gives m(tau(M))/tau(M) = S_M, so the ratio transitions smoothly. Overall, m(p)/p is weakly decreasing (constant then strictly decreasing). Correct.

### Check 3: Part 1 (p >= a) -- m is affine on [b,d]

**PASS.**

Line 1129 uses the fact that m is affine on [b,d] subset [tau(M), 1] (since a >= tau(M) because E_U subset E_M). On this interval, m(p) = (lambda_M - alpha) V_e(p) = (lambda_M - alpha)[1 + (r-1)p], which is indeed affine in p. The argument then uses concavity of u and the fact that u > m at the endpoints b, d of any gap to conclude u > m throughout the gap. This is a standard convex-combination argument and is unaffected by the normalization -- only the fact that m is affine matters, not the specific coefficient. Correct.

### Check 4: Part 2 (p < a) -- v(p, U) = 0

**PASS.**

Line 1131: "On [0, a), v(p, U) = 0."

Since a = inf E_U and E_U is closed, p < a means p is not in E_U, i.e., no entry occurs under unanimity at belief p. By the net-gain definition, v(p, U) = 0 when no entry. Correct.

### Check 5: Footnote about u(0) = 0

**PASS.**

The footnote (line 1131) states: "Since u(0) = 0 and v = 0 on [0,a)..."

Verification: u(0) = cav v(0, U). At mu = 0, no entry occurs (the entry set E_U does not include 0 for any non-degenerate model since V_W(0) is bounded), so v(0, U) = 0. The concave envelope of a function that equals 0 at 0 and is nonneg everywhere cannot be negative at 0, and since v(0) = 0, we have u(0) >= v(0) = 0. But u(0) also cannot exceed 0 if v = 0 on [0, a): the hull from the origin connects linearly to the first point where v > 0, so u(0) = 0. Correct.

Note: This step is CRITICAL and depends on the net-gain normalization. Under the old absolute-payoff definition, v(0, R) = alpha * V_e(0) = alpha > 0 when no entry occurs (the hegemon still gets the outside option). That would make u(0) > 0, breaking the single-crossing argument. Under the net-gain definition, v(0, R) = 0 when no entry, which is essential for the proof. The normalization change was therefore not cosmetic but structurally necessary for this proof.

### Check 6: Slope comparison Delta(p) = p[S_U - m(p)/p]

**PASS.**

Line 1133: "Delta(p) = u(p) - m(p) = p[S_U - m(p)/p]."

For p in (0, a): u(p) = S_U * p (linear from origin, as established in Part 2). So:
  Delta(p) = S_U * p - m(p) = p * [S_U - m(p)/p].

Since m(p)/p is weakly decreasing (Check 2), S_U - m(p)/p is weakly increasing. The sign of Delta changes at most once from negative to positive, establishing the single-crossing property. Correct.

---

## Additional Checks

### Residual uses of old definition

**PASS.**

Searched the entire file for:
- Any place where v is equated to E[V_H^R1] (without subtracting alpha V_e): Only the DEFINING equation at line 416 does this, and it correctly includes the subtraction.
- Any place where Pi_H* = cav v without the alpha V_e offset: All instances of Pi_H* include "alpha V_e(p) + cav v(p, R)" (lines 428, 527).
- The R code in model_functions.R correctly computes absolute payoffs and applies the net-gain transformation in the Rmd (lines 441, 447): `VH_R1_unanimity(...) - alpha_val * Ve_m`.

No residual old-definition references found.

### Lemma 1 proof (B.5) unaffected

**PASS.**

The Lemma 1 proof (B.5, lines 1038-1085) operates entirely on:
  D(mu) = E[V_H^R1(mu, U)] - lambda_M V_e(mu)

This is the difference of ABSOLUTE payoffs. It never references v (net gain). The proof's conclusion D(mu) > 0 is equivalent to the absolute-payoff dominance statement in Lemma 1. The net-gain normalization does not touch this proof. Correct.

### Notation table consistency

**PASS.**

Line 837: "$v(\mu, R)$ & Hegemon's net gain from institution: $E[V_H^{R1}] - \alpha V_e(\mu)$ if entry, $0$ otherwise & Sec. 6"

This correctly describes the net-gain definition. The section reference "Sec. 6" corresponds to "Entry and Bayesian Persuasion" where v is defined (line 414-417). Correct.

### B.4 Proof of Proposition 4 (Additional non-convexity)

**PASS.**

Line 956 discusses v(mu, M) and v(mu, U) as net-gain functions. Under majority, v(mu, M) = (lambda_M - alpha) V_e(mu) is affine for mu >= tau(M). Under unanimity, v has the jump at mu_s^R1. Both descriptions are correct under the net-gain definition.

### Motivating example (Section 2)

**NOTE (not a failure).**

Lines 76-78 discuss H's "payoff" as 0.2 + 0.2p, which is the ABSOLUTE payoff (not net gain). This is appropriate because the motivating example pre-dates the formal definition of v and operates in terms of total payoffs. There is no inconsistency: the example describes the total payoff Pi_H = alpha V_e(p) + v(p, R), and the concavification result 0.2 + 1.8p = alpha V_e(p) + cav v(p, U). No change needed.

---

## Overall Assessment

**VERIFIED.**

All six checks for B.6 and all six checks for B.8 pass. No residual uses of the old definition were found. The Lemma 1 proof is correctly insulated from the normalization. The notation table is consistent.

The net-gain normalization is structurally important (not cosmetic): it ensures u(0) = v(0) = 0 when no entry occurs, which is essential for the single-crossing proof in B.8. Under the old absolute-payoff definition, v(0) = alpha > 0, which would break the "linear from origin" argument in Part 2 of B.8.

| Check | Section | Status |
|-------|---------|--------|
| B.6.1: Budget identity paragraph | B.6 | PASS |
| B.6.2: v(p,U) > v(p,M) from Lemma 1 | B.6 | PASS |
| B.6.3: v(mu,M) = (lambda_M - alpha) V_e | B.6 | PASS |
| B.6.4: Concavification bound | B.6 | PASS |
| B.6.5: cav v(p,M) = v(p,M) on E_M | B.6 | PASS |
| B.6.6: Final comparison | B.6 | PASS |
| B.8.1: m(p) and S_M formula | B.8 | PASS |
| B.8.2: m(p)/p weakly decreasing | B.8 | PASS |
| B.8.3: m affine on [b,d] | B.8 | PASS |
| B.8.4: v(p,U) = 0 for p < a | B.8 | PASS |
| B.8.5: u(0) = 0 footnote | B.8 | PASS |
| B.8.6: Single-crossing via Delta(p) | B.8 | PASS |
| Residual old-definition uses | Whole paper | PASS |
| Lemma 1 proof unaffected | B.5 | PASS |
| Notation table | App. A | PASS |
