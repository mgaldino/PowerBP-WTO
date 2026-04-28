# Mathematical Review: Proof Reformulations for RIO Submission

**Date**: 2026-04-27  
**Reviewer**: Fresh mathematical audit  
**File reviewed**: `quality_reports/2026-04-27_proof-reformulations-RIO.md`  
**Source paper**: `formal_model_v5.Rmd`

---

## Proof 1: Proposition 1 (Majority Rule — Complete PBE Derivation)

### Step 1: R2 Continuation Values

**Case A (H proposes in R2): PASS**

- H needs q-1 votes from weak states. Each W accepts if offered >= 0 (disagreement payoff). Cheapest coalition: q-1 W's at 0 each. H keeps V(theta). Correct.

**Case B (W_j proposes in R2): PASS**

- Option (a): q-1 other W's at cost 0 each. Total cost: 0.
- Option (b): H at cost alpha*V(theta) + (q-2) W's at cost 0. Total cost: alpha*V(theta) > 0.
- Conclusion that (a) is strictly cheaper: correct, since alpha > 0 and V(theta) >= 1.
- W_j keeps V(theta) - alpha*V(theta) = (1-alpha)*V(theta): correct. The alpha*V(theta) goes to H as its bilateral alternative regardless.

**R2 continuation value for H (eq. R2-H): PASS**

$$V_H^{R2}(\theta, M) = \frac{1}{N} V(\theta) + \frac{N-1}{N} \alpha V(\theta) = \frac{V(\theta)[1 + (N-1)\alpha]}{N}$$

Verified: (1/N)V(theta) + ((N-1)/N)*alpha*V(theta) = V(theta)[1/N + (N-1)alpha/N] = V(theta)[1 + (N-1)alpha]/N. Correct.

**R2 continuation value for W (eq. R2-W): PASS with minor note**

$$V_W^{R2}(\mu, M) = \frac{1}{N}(1-\alpha)V_e(\mu) + \frac{N-2}{N} \cdot 0 + \frac{1}{N} \cdot 0 = \frac{(1-\alpha)V_e(\mu)}{N}$$

The three-term decomposition is correct:
1. W_i proposes (prob 1/N): gets (1-alpha)V_e(mu) in expectation over theta. Correct.
2. Another W_j proposes (prob (N-2)/N): W_i gets 0 whether in or out of the coalition (offered 0 or gets disagreement 0). Correct.
3. H proposes (prob 1/N): W_i gets 0 (offered 0 in the minimal coalition, or excluded and gets 0). Correct.

Note: This is correct because coalition members receive 0 and non-coalition members also receive 0. The decomposition is valid.

**Consistency check with paper**: The formulas match Appendix A.1 (lines 751-753 of v5.Rmd) exactly. PASS.

### Step 2: R1 Optimal Offers

**Case A (H proposes in R1): PASS**

- H buys q-1 W's at beta*V_W^{R2}(mu, M) each.
- Payoff conditional on theta: V(theta) - (q-1)*beta*(1-alpha)*V_e(mu)/N. Correct.
- Note that the offer depends on mu (W's belief) because W evaluates the offer against its R2 continuation value. This is correct: H knows theta but must offer enough to match W's belief-based reservation value.

**Case B (W_j proposes in R1) — Exclusion argument: PASS**

The proof gives multiple arguments for exclusion, which is thorough. The cleanest is the final one (line 79):
- There are N-2 other weak states available (excluding W_j and H).
- The proposer needs q-1 votes.
- N-2 >= q-1 holds for N >= 3 because q-1 = floor(N/2) <= N-2. Let me verify: for N=3, q=2, q-1=1, N-2=1. Yes, 1 >= 1. For N=4, q=3, q-1=2, N-2=2. Yes. For N=5, q=3, q-1=2, N-2=3. Yes. In general, floor(N/2) <= N-2 for N >= 3 because N/2 <= N-2 iff 2 <= N/2 iff N >= 4, and the floor makes it work for N=3 too. PASS.
- Each W's reservation is beta*V_W^{R2} >= 0, while H's is beta*V_H^{R2} > 0 (strictly). Since W is weakly cheaper (and strictly cheaper for typical parameters), the optimal coalition excludes H. PASS.

**One subtlety to note** (not an error, but worth flagging): When W_j proposes in R1, the proof says H receives alpha*V(theta). This is the disagreement payoff. But it is important that H indeed cannot do better by some deviation. Since H is excluded from the coalition, H's vote is irrelevant (the proposal passes without H), and H simply falls back to its bilateral alternative. This is correct under majority rule where q < N.

**R1 payoff when W proposes (line 82-83)**: W_j pays alpha*V(theta) to H and (q-1)*beta*V_W^{R2}(mu,M) to other W's. This is correct for the proposer's surplus. H gets alpha*V(theta). PASS.

### Step 3: Hegemon's Expected R1 Payoff

**Aggregation over proposer identity (line 91):**

$$E_\theta[V_H^{R1}(\theta, \mu, M)] = \frac{1}{N} E_\theta[\Pi_H^{\text{prop}}(\theta, \mu, M)] + \frac{N-1}{N} E_\theta[\alpha V(\theta)]$$

This correctly separates the two events: H proposes (prob 1/N) and some W proposes (prob (N-1)/N).

**When H proposes (lines 94-99):**

$$E_\theta[\Pi_H^{\text{prop}}] = E_\theta[V(\theta)] - (q-1)\beta(1-\alpha)V_e(\mu)/N = V_e(\mu) - (q-1)\beta(1-\alpha)V_e(\mu)/N$$

Wait — this uses E_theta[V(theta)] = V_e(mu). The note on line 101 says "beliefs are correct in equilibrium (the expectation is over the true distribution with parameter mu = p)." This is a subtle point. The expectation E_theta is over the true distribution of theta, and at the entry stage mu = p (the prior). In equilibrium, beliefs are correct, so E_theta[V(theta)] = V_e(p) = V_e(mu). This is valid. PASS.

The algebra:
V_e(mu)[1 - (q-1)beta(1-alpha)/N] = V_e(mu)[N - (q-1)beta(1-alpha)]/N. PASS.

**When W proposes (line 104):**
E_theta[alpha*V(theta)] = alpha*V_e(mu). PASS.

**Combining (lines 107-111):**

$$E_\theta[V_H^{R1}] = \frac{V_e(\mu)[N - (q-1)\beta(1-\alpha)]}{N^2} + \frac{(N-1)\alpha V_e(\mu)}{N}$$

Let me verify the first term: (1/N) * V_e(mu) * [N - (q-1)beta(1-alpha)]/N = V_e(mu)[N - (q-1)beta(1-alpha)]/N^2. Correct.

Second term: ((N-1)/N)*alpha*V_e(mu) = (N-1)*alpha*V_e(mu)/N. Correct.

Now combining:
$$= \frac{V_e(\mu)}{N^2}[N - (q-1)\beta(1-\alpha) + N(N-1)\alpha]$$

The second term needs to be expressed with denominator N^2: (N-1)*alpha*V_e(mu)/N = N(N-1)*alpha*V_e(mu)/N^2. PASS.

$$= \frac{V_e(\mu)}{N^2}[N + N(N-1)\alpha - \beta(q-1)(1-\alpha)]$$

Rearranging: N - (q-1)beta(1-alpha) + N(N-1)alpha = N + N(N-1)alpha - beta(q-1)(1-alpha). PASS.

**Definition of C_buy and C_out (line 113):**
- C_buy = beta(q-1)(1-alpha). PASS.
- C_out = N(N-1)alpha. PASS.

**Formula for lambda_M (line 117):**

$$\lambda_M = \frac{N(1 + (N-1)\alpha) - \beta(q-1)(1-\alpha)}{N^2}$$

Let me verify: N + C_out - C_buy = N + N(N-1)alpha - beta(q-1)(1-alpha). And N + N(N-1)alpha = N[1 + (N-1)alpha]. So the numerator is N[1 + (N-1)alpha] - beta(q-1)(1-alpha). PASS.

**Consistency check with paper**: The paper (line 931 of v5.Rmd) writes lambda_M = [N(1+(N-1)alpha) - C_buy]/N^2 with C_buy = beta(q-1)(1-alpha). This matches exactly. PASS.

### Step 4: Affinity in mu — PASS

V_e(mu) = 1 + mu(r-1) is affine in mu. lambda_M is a constant (independent of mu). Their product is affine. No screening cutoff because there is no belief at which any structural feature of the equilibrium changes. PASS.

### Step 5: No screening — PASS

This is a verbal summary of why no screening arises. The three arguments are correct:
1. Coalition composition is belief-independent (W always excludes H). PASS.
2. Offer structure is continuous and affine in mu. PASS.
3. No jump in H's payoff. PASS.

### Step 6: lambda_M > alpha — DETAILED VERIFICATION

**Claim**: lambda_M > alpha.

**Algebraic verification (lines 137-144):**

$$\lambda_M > \alpha \iff \frac{N(1+(N-1)\alpha) - \beta(q-1)(1-\alpha)}{N^2} > \alpha$$

Multiply both sides by N^2 (positive):

$$N(1+(N-1)\alpha) - \beta(q-1)(1-\alpha) > N^2\alpha$$

Expand N(1+(N-1)alpha) = N + N(N-1)alpha:

$$N + N(N-1)\alpha - \beta(q-1)(1-\alpha) > N^2\alpha$$

Rearrange:

$$N - N^2\alpha + N(N-1)\alpha - \beta(q-1)(1-\alpha) > 0$$
$$N - N\alpha[N - (N-1)] - \beta(q-1)(1-\alpha) > 0$$
$$N - N\alpha - \beta(q-1)(1-\alpha) > 0$$

Factor out (1-alpha) from the first two terms? Let me check: N - N*alpha = N(1-alpha). So:

$$N(1-\alpha) - \beta(q-1)(1-\alpha) > 0$$
$$(1-\alpha)[N - \beta(q-1)] > 0$$

This matches the factorization on line 142. Let me verify the intermediate step from line 139 to 140 more carefully:

Line 139: N + N(N-1)alpha - beta(q-1)(1-alpha) > N^2*alpha
Line 140: N - N*alpha - beta(q-1)(1-alpha) > 0

The transition: move N^2*alpha to the left side: N + N(N-1)alpha - N^2*alpha - beta(q-1)(1-alpha) > 0.

N(N-1)alpha - N^2*alpha = N*alpha[(N-1) - N] = N*alpha*(-1) = -N*alpha.

So: N - N*alpha - beta(q-1)(1-alpha) > 0. **PASS.**

Now the two factors:
1. 1 - alpha > 0 because alpha < 1/r < 1. PASS.
2. N - beta(q-1) > 0. Since beta < 1 and q-1 = floor(N/2) < N, we have beta(q-1) < N. More precisely, beta(q-1) < q-1 < N. PASS.

**VERDICT for Step 6: PASS.** The factorization is correct and each factor is verified to be strictly positive.

### Overall Assessment of Proof 1: **PASS**

The proof is complete, rigorous, and correctly derives the PBE under majority rule. Every algebraic step checks out. The exclusion argument is thorough (multiple angles provided). The formula for lambda_M matches the paper. The structural property lambda_M > alpha is correctly established.

**Minor observations** (not errors):
1. Line 77 contains a somewhat convoluted parenthetical verification that could be streamlined, but the conclusion is correct.
2. The proof correctly notes on line 65 that the offer to W depends on mu (W's belief), not on theta directly. This is an important and correct observation.
3. The proof correctly handles the fact that H knows theta when proposing but W's reservation value depends on mu.

---

## Proof 2: Proposition 4 Case (ii) — Corrected Inference

### Diagnosis of the error: PASS

The diagnosis (lines 166-175) correctly identifies the logical flaw in the current text: the fact that entry is individually rational for weak states (V_W >= c > 0) does not imply that H's institutional payoff exceeds alpha*V_e(p). These are statements about different players' payoffs, and no connection is established.

### Corrected proof: DETAILED VERIFICATION

**Setup (lines 178-184):**

- p in F_M \ F_U: institution forms under majority, not under unanimity.
- Under unanimity (no formation): V_H(U, p) = alpha*V_e(p). Correct (H gets bilateral alternative when institution does not form).
- Under majority (formation): V_H(M, p) = lambda_M*V_e(p) by Proposition 1 (equation (star)). Correct.

**The key inequality (lines 186-188):**

$$V_H(M, p) = \lambda_M V_e(p) > \alpha V_e(p) = V_H(U, p)$$

This uses:
1. lambda_M > alpha (established in Proof 1, Step 6). PASS.
2. V_e(p) > 0 for all p in (0,1]. Since V_e(p) = 1 + p(r-1) >= 1 > 0 for p >= 0. PASS.
3. The product of a positive constant (lambda_M - alpha) with a positive quantity V_e(p) is positive. PASS.

**Conclusion**: M strictly dominates U for this case. PASS.

### Why the corrected argument works (lines 192-199): PASS

The intuitive explanation is correct:
1. When H proposes (prob 1/N), H captures V(theta) - (q-1)beta*V_W^{R2} > alpha*V(theta). The inequality V(theta) - (q-1)beta*(1-alpha)*V_e(mu)/N > alpha*V(theta) is not explicitly verified here, but it doesn't need to be: the aggregate lambda_M > alpha has already been established. This narrative is for intuition only. PASS.
2. When W proposes (prob (N-1)/N), H gets exactly alpha*V(theta). PASS.
3. The mixture gives lambda_M > alpha. PASS.

### Overall Assessment of Proof 2: **PASS**

The corrected inference is valid. It replaces an invalid argument (inferring H's payoff from W's rationality) with a direct structural argument (lambda_M > alpha, which is an algebraic property of majority-rule bargaining independent of entry conditions). The fix is clean and self-contained.

---

## Appendix: Verification that lambda_M - alpha is bounded away from zero

**Formula (line 207):**

$$\lambda_M - \alpha = \frac{(1-\alpha)[N - \beta(q-1)]}{N^2}$$

This was derived in Step 6 above. Let me verify it directly:

lambda_M - alpha = [N(1+(N-1)alpha) - beta(q-1)(1-alpha)]/N^2 - alpha
= [N + N(N-1)alpha - beta(q-1)(1-alpha) - N^2*alpha]/N^2
= [N - N*alpha - beta(q-1)(1-alpha)]/N^2
= [(1-alpha)(N - beta(q-1))]/N^2

PASS. Matches the claimed formula.

**Lower bound (lines 209-211):**

Since 1 - alpha > 1 - 1/r = (r-1)/r (because alpha < 1/r), and N - beta(q-1) > N - (q-1) >= N - (N-1) = 1 (since beta < 1):

$$\lambda_M - \alpha > \frac{(r-1)/r \cdot 1}{N^2} = \frac{r-1}{rN^2}$$

Let me verify the bound N - beta(q-1) > 1: N - beta(q-1) > N - (q-1) = N - floor(N/2). For N=3: 3 - 1 = 2 > 1. For N=4: 4 - 2 = 2 > 1. For N >= 3: N - floor(N/2) >= ceil(N/2) >= 2 > 1. So actually N - beta(q-1) > N - (q-1) >= 2 > 1. The bound of 1 used in the proof is correct (and conservative). PASS.

**VERDICT: PASS.**

---

## Cross-Consistency Checks

### 1. lambda_M formula vs. paper's B.5

Paper (line 949 of v5.Rmd): lambda_M = [N(1+(N-1)alpha) - C_buy]/N^2 with C_buy = beta(q-1)(1-alpha).

Proof reformulation (line 117): lambda_M = [N(1+(N-1)alpha) - beta(q-1)(1-alpha)]/N^2.

These are identical. **PASS.**

### 2. R2-H formula vs. paper's A.1

Paper (line 752): V_H^{R2}(theta, M) = V(theta)[1+(N-1)alpha]/N.

Proof reformulation (line 44, eq. R2-H): same formula. **PASS.**

### 3. R2-W formula vs. paper's A.1

Paper (line 753): V_W^{R2}(mu, M) = (1-alpha)*V_e(mu)/N.

Proof reformulation (line 50, eq. R2-W): same formula. **PASS.**

### 4. Exclusion argument: coverage check

The proof must establish that W excludes H in ALL cases:
- R2, W proposes: explicitly proved (Step 1, Case B). **PASS.**
- R1, W proposes: explicitly proved (Step 2, Case B). **PASS.**
- R2, H proposes: H proposes and keeps everything; no exclusion issue. **PASS.**
- R1, H proposes: H proposes and buys W's; no exclusion issue. **PASS.**

All four cases are covered. **PASS.**

### 5. Proposition 4 case (ii): does the corrected proof match the paper's statement?

Paper (line 461-468, Proposition 4): "M succ U if and only if p in F_M \ F_U."

Corrected proof establishes: p in F_M \ F_U implies V_H(M,p) = lambda_M*V_e(p) > alpha*V_e(p) = V_H(U,p), hence M succ U. This is the correct direction for the case (ii) "if" direction. The "only if" direction is implicit from the exhaustive partition: cases (i), (ii), (iii) are mutually exclusive and exhaustive, so case (ii) is an iff by elimination. **PASS.**

---

## Summary Table

| Proof Component | Verdict | Issues |
|:---|:---|:---|
| **Prop 1, Step 1: R2 values** | PASS | None |
| **Prop 1, Step 2: R1 offers** | PASS | None |
| **Prop 1, Step 2: Exclusion (R1)** | PASS | None |
| **Prop 1, Step 2: Exclusion (R2)** | PASS | None |
| **Prop 1, Step 3: Expected R1 payoff** | PASS | None |
| **Prop 1, Step 4: Affinity** | PASS | None |
| **Prop 1, Step 5: No screening** | PASS | None |
| **Prop 1, Step 6: lambda_M > alpha** | PASS | Factorization verified line-by-line |
| **Prop 4 case (ii): Diagnosis** | PASS | Correctly identifies logical flaw |
| **Prop 4 case (ii): Corrected proof** | PASS | Uses structural property, no indirect inference |
| **Appendix: Lower bound** | PASS | Conservative but correct |
| **Cross-consistency: lambda_M** | PASS | Matches paper's B.5 |
| **Cross-consistency: R2 formulas** | PASS | Matches paper's A.1 |
| **Cross-consistency: exclusion coverage** | PASS | All 4 cases covered |

---

## Overall Assessment

**PASS.** Both proofs are mathematically correct. Every algebraic step has been verified. The logical structure is sound. The exclusion argument under majority is proved for all relevant cases (R1 and R2, H-proposes and W-proposes). The corrected inference in Proposition 4 case (ii) replaces an invalid argument with a valid one based on the structural property lambda_M > alpha.

**Strengths of the proofs:**
1. The backward-induction structure is clean and complete.
2. The exclusion argument is given from multiple angles (cost comparison, feasibility, optimality), making it robust.
3. The lambda_M > alpha factorization is elegant and makes the structural nature of the result transparent.
4. The diagnosis of the error in the original Proposition 4 case (ii) is precise and the fix is minimal.

**No errors found.** No hidden assumptions, no missing cases, no sign errors, no boundary conditions missed.
