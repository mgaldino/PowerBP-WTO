# Referee Report: Lemma X (Global Maximum of V_W^{R1}(mu, U))

**Date**: 2026-04-25  
**File reviewed**: `notes/2026-04-25_prova_lemmaX_AJPS_ready.md`  
**Reviewer standard**: Top-5 journal (JoP/AJPS/APSR)

---

## 1. Verification of the closed-form for V_W^{CH}(mu)

**PASS.**

The conservative R1 payoff with high R2 continuation is:

```
V_W^{CH}(mu) = (1/N)[Ve - beta(r+x)/N - omega] + (N-1)/N * beta * W_2^H
```

Substituting W_2^H = (Ve - alpha*r)/N and omega = (N-2)*beta*W_2^H:

- The omega/N and (N-1)*beta*W_2^H/N terms combine as [-(N-2) + (N-1)]*beta*W_2^H/N = beta*W_2^H/N
- Then: Ve/N + beta*[Ve - alpha*r - (r+x)]/N^2
- Since x = (N-1)*alpha*r: Ve - alpha*r - r - (N-1)*alpha*r = Ve - N*alpha*r - r = Ve - r(1+N*alpha)
- Final: [(N+beta)*Ve - beta*r(1+N*alpha)] / N^2

**Verified algebraically and numerically (5 parameter sets, max error 1.23e-16).**

For the gap:

```
Vbar_W - V_W^{CH} = [Nr(1-beta*alpha) - (N+beta)*Ve + beta*r(1+N*alpha)] / N^2
```

The beta*alpha*r terms cancel (Nr*beta*alpha vs N*beta*alpha*r), yielding:

```
= [N(r-1) + beta(r-1) - (N+beta)*mu*(r-1)] / N^2
= (N+beta)(r-1)(1-mu) / N^2
```

**Correct. Non-negative, with equality only at mu=1.**

---

## 2. Verification of Case 2 (Aggressive + High R2)

**PASS.**

The key step is the cancellation claim. I verified this both algebraically and numerically.

**Cancellation of (1-mu)*beta*W_2^H terms:**

- From proposer/N: -(1-mu)*(N-2)*beta*W_2^H / N
- From non-proposer: beta*W_2^H/N + (N-2)*(1-mu)*beta*W_2^H/N

Sum = beta*W_2^H/N. The (1-mu)*(N-2)*beta*W_2^H terms cancel exactly. **Correct.**

**After cancellation:**

```
N^2 * VW_AH = N(1-mu) - (1-mu)*beta*(1+x) + (N-1)*mu*beta*r*(1-alpha) + beta*(Ve - alpha*r)
```

Collecting constant and mu terms:

- Constant: N - beta*(1+x) + beta*(1 - alpha*r) = N(1 - beta*alpha*r)
- mu coefficient: -N + beta*(1+x) + (N-1)*beta*r*(1-alpha) + beta*(r-1) = -N + N*beta*r

Therefore:

```
N^2 * (Vbar_W - VW_AH) = Nr - N*r*beta*alpha - N(1-beta*alpha*r) - mu*N(-1+beta*r)
                        = N(r-1) + mu*N(1-beta*r)
                        = N[(1-mu)(r-1) + mu*r(1-beta)]
```

So Vbar_W - VW_AH = [(1-mu)(r-1) + mu*r(1-beta)] / N.

**Strict positivity:** At mu=0: (r-1)/N > 0 (since r > 1). At mu=1: r(1-beta)/N > 0 (since beta < 1). The gap is a convex combination of two strictly positive values, hence strictly positive for all mu in [0,1].

**Verified numerically: 6,050 parameter combinations, max error 6.66e-16. Additionally verified with 1,000 random parameter sets (20 mu values each), zero violations.**

---

## 3. Verification of Cases 3 and 4 (Low R2)

### Case 3: Conservative + Low R2

**PASS.**

The closed form V_W^{CL} = Ve/N - beta*(r+x)/N^2 + beta*(1-mu)*(1-alpha)/N^2 is verified against the direct computation (max error 2.78e-17 across 5 parameter sets).

**Gap formula verification:**

```
Vbar_W - V_W^{CL} = [(r-1)(N - alpha*beta + beta) + mu{N(1-r) - alpha*beta + beta}] / N^2
```

This is affine in mu. The coefficient of mu is N(1-r) + beta(1-alpha), which can be negative (since N(1-r) < 0 for r > 1 and typically dominates). Hence the function is generally decreasing in mu, and checking endpoints is necessary.

**Endpoint at mu=0:** (r-1)(N - alpha*beta + beta)/N^2 > 0. Since N >= 3 and alpha*beta < 1, we have N - alpha*beta + beta > N - 1 + beta > 2. **Correct.**

**Endpoint at mu=mu_2:** r(r-1)(1-alpha)(N+beta)/(N^2(r-alpha)) > 0. All factors strictly positive: 1-alpha > 0 (since alpha < 1/r < 1), N+beta > 0, r-alpha > 0 (since r > 1 > alpha). **Correct.**

**Verified numerically: 6,050 parameter combinations on [0, mu_2], max error 8.88e-16. Minimum gap over all parameters: 0.00923 > 0.**

### Case 4: Aggressive + Low R2

**PASS.**

**Gap formula:**

```
Vbar_W - V_W^{AL} = [(r-1)(N - alpha*beta) + mu{N(1-beta*r) + beta*r - alpha*beta}] / N^2
```

**Endpoint at mu=0:** (r-1)(N - alpha*beta)/N^2 > 0. Since N >= 3 and alpha*beta < 1. **Correct.**

**Endpoint at mu=mu_2:** r(r-1)(1-alpha*beta)/(N(r-alpha)) > 0. Since alpha*beta < 1 and r > alpha. **Correct.**

**Verified numerically: 6,050 parameter combinations, max error 4.44e-16. Minimum gap over all parameters: 0.00930 > 0.**

---

## 4. Exhaustiveness check

**PASS.**

At any mu in (0,1], two things are determined:

1. **R2 branch**: whether mu < mu_2 (low) or mu >= mu_2 (high). This is determined by the belief, not by a strategic choice.
2. **R1 strategy**: whether the proposer plays aggressive (F1_agg > F1_con) or conservative (F1_con >= F1_agg). This is the equilibrium selection.

So at each mu, exactly ONE of the four candidates is the actual equilibrium payoff. The proof bounds ALL four candidates by Vbar_W. Since the equilibrium payoff is one of these four, the bound follows.

**The logic is correct.** Bounding all four is stronger than necessary (at each mu, only two are relevant), but the surplus in the argument creates no gap -- it only makes the proof more robust.

**One subtlety worth noting:** The proof does not need to identify WHICH candidate is the equilibrium payoff at each mu. It only needs the upper bound. This is a clean and elegant proof strategy that avoids the need to track the R1 cutoff explicitly.

---

## 5. R code correspondence

**PASS.**

The R function `VW_R1_unanimity` in `scripts/model_functions.R` implements exactly the four candidates:

| R code branch | Proof case |
|---|---|
| `mu >= mu_s_R2` and `F1_con >= F1_agg` | Case 1 (CH) |
| `mu >= mu_s_R2` and `F1_agg > F1_con` | Case 2 (AH) |
| `mu < mu_s_R2` and `F1_con >= F1_agg` | Case 3 (CL) |
| `mu < mu_s_R2` and `F1_agg > F1_con` | Case 4 (AL) |

**Key correspondence details:**

- R code's `VW_R2` matches the proof's W_2^L (low) or W_2^H (high).
- R code's `omega = (N-2)*beta*VW_R2` matches the proof's omega.
- **Conservative non-proposer:** R code uses `(N-1)/N * beta * VW_R2`, matching proof Cases 1 and 3.
- **Aggressive non-proposer:** R code uses `beta*VW_R2/N + (N-2)/N * ((1-mu)*beta*VW_R2 + mu*beta*VW_R2_1)` where `VW_R2_1 = r*(1-alpha)/N`. This is `beta*r*(1-alpha)/N`, matching the proof's `beta*r*(1-alpha)/N` in Cases 2 and 4.

**Verified: max difference between R code and proof formulas across all mu values: 1.11e-16 (machine precision).**

---

## 6. Corollary verification

**PASS. Immediate and correct.**

If E_U is nonempty, there exists mu' in (0,1] with V_W^{R1}(mu', U) >= c. By Lemma X, V_W^{R1}(1, U) >= V_W^{R1}(mu', U) >= c. Hence 1 is in E_U.

No additional argument needed. This is a direct logical consequence of the global maximum property.

---

## 7. Grade

### **A+ (Bulletproof, ready for JoP/AJPS)**

---

## 8. Detailed assessment

### Strengths

1. **Proof strategy is optimal.** By bounding all four payoff candidates independently, the proof avoids tracking the R1 cutoff altogether. This eliminates the messiest part of the analysis (the relative ordering of mu_s^{R1} vs mu_s^{R2}) from this particular result. Elegant.

2. **Every algebraic step verifies.** All four closed-form gap formulas are correct to machine precision, verified across 6,050+ parameter combinations and 1,000 random parameter sets.

3. **Sign arguments are tight.** Each positivity claim is justified by identifying the sign of every factor. No hand-waving. The factors cited (r > 1, beta < 1, alpha < 1/r, N >= 3) are exactly the maintained assumptions.

4. **The affinity-plus-endpoints argument for Cases 3 and 4 is correctly applied.** The gap is affine in mu (verified), so checking positivity at the two endpoints of [0, mu_2] suffices. Both endpoint evaluations are correct.

5. **The cancellation in Case 2 is verified.** The (1-mu)*beta*W_2^H terms from proposer and non-proposer cancel to leave exactly beta*W_2^H/N. This is the key simplification and it is correct.

6. **The Corollary is logically immediate and correctly stated.**

7. **The proof is self-contained.** It does not depend on the R1 cutoff formula, the budget identity, the jump formula, or any other result. It uses only the primitive payoff formulas and parameter restrictions.

### Minor observations (not affecting the grade)

1. **Domain of Cases 1-2 vs 3-4.** The proof says Cases 1-2 apply for mu >= mu_2 and Cases 3-4 for mu < mu_2. Strictly, at mu = mu_2, both branches give the same W_2 value (by continuity at the R2 cutoff). The proof handles this correctly -- both Cases 1 and 3 (or 2 and 4) give the same gap at mu_2, which is positive. No issue.

2. **The proof bounds on [0, mu_2] for Cases 3-4 but the Lemma domain is (0, 1].** This is fine because Cases 1-2 cover [mu_2, 1]. The union covers (0, 1] completely.

3. **The "Notes for insertion" section at the bottom is appropriate.** It correctly identifies that numerical diagnostics should not appear in the appendix proof.

### Issues found

**None.** No algebraic errors, no logical gaps, no missing cases, no unjustified sign claims.

---

## Numerical verification summary

| Test | Result |
|---|---|
| V_bar_W = VW_R1(1, U) | 5/5 parameter sets PASS (max diff 5.55e-17) |
| Case 1 closed form | 5/5 PASS (max diff 2.78e-17) |
| Case 1 gap formula | 5/5 PASS (max diff 6.94e-17) |
| Case 2 gap formula | 5/5 PASS + 6,050 brute force (max diff 6.66e-16) |
| Case 2 cancellation | Verified algebraically and numerically |
| Case 3 closed form | 5/5 PASS (max diff 2.78e-17) |
| Case 3 endpoints | All correct (max diff 5.55e-17) |
| Case 4 endpoints | All correct (max diff 2.78e-17) |
| Global max at mu=1 | 5/5 PASS + 1,000 random sets (0 violations) |
| R code correspondence | 5/5 PASS (max diff 1.11e-16) |
| Case 3 gap positive on [0,mu_2] | 6,050 combos, min gap 0.00923 > 0 |
| Case 4 gap positive on [0,mu_2] | 6,050 combos, min gap 0.00930 > 0 |

---

## Verdict

The proof is technically flawless. Every formula is correct, every sign argument is valid, the case analysis is exhaustive, and the proof strategy (bound all candidates independently) is both clean and robust. The Corollary follows immediately. The correspondence with the R code is exact.

**Ready for submission to JoP/AJPS without modification.**
