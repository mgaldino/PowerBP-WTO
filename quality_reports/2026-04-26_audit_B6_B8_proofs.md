# Audit: B.6 (Proof of Theorem 1) and B.8 (Proof of Theorem 2)

**Date**: 2026-04-26
**Auditor**: Game theory audit (senior game theorist, adversarial mode)
**File**: `formal_model_v4.Rmd`, lines 1117--1165
**Scope**: Line-by-line verification of net-gain consistency, logical completeness, and vulnerability to hostile referee challenges.

---

## B.6 Audit (Proof of Theorem 1 -- Dominance of unanimity)

### Status: PASS

### Line-by-line analysis

**Line 1119 (E_U subset E_M derivation):**
The argument proceeds in three steps: (1) majority budget identity holds exactly: E[V_H(mu,M)] + (N-1)V_W(mu,M) = V_e(mu); (2) unanimity has surplus destruction on the aggressive branch: E[V_H(mu,U)] + (N-1)V_W(mu,U) <= V_e(mu); (3) Lemma 1 gives E[V_H(mu,U)] > E[V_H(mu,M)], so V_W(mu,U) < V_W(mu,M).

- Step (1): Verified against A.6. The majority budget is exact because exclusion of H means all surplus is distributed without delay. CORRECT.
- Step (2): Verified against A.6. On the aggressive branch, theta=1 rejection in R1 causes discounting, destroying surplus. CORRECT.
- Step (3): From (1) and (2): V_e >= E[V_H(mu,U)] + (N-1)V_W(mu,U) > E[V_H(mu,M)] + (N-1)V_W(mu,U), so V_e - E[V_H(mu,M)] > (N-1)V_W(mu,U), i.e., (N-1)V_W(mu,M) > (N-1)V_W(mu,U). CORRECT.
- Conclusion: V_W(p,M) > V_W(p,U) >= c implies p in E_M. CORRECT.

**Line 1121 (Conditional dominance in net gains):**
"By Lemma 1, v(p,U) > v(p,M)." Since p is in both E_U and E_M (just proved), both net gains are well-defined: v(p,U) = E[V_H(p,U)] - alpha*V_e(p) and v(p,M) = E[V_H(p,M)] - alpha*V_e(p). The difference is D(p) = E[V_H(p,U)] - E[V_H(p,M)] > 0 (Lemma 1). The alpha*V_e terms cancel. CORRECT. Net-gain definition used correctly.

**Line 1121 (Majority net gain formula):**
"v(mu,M) = (lambda_M - alpha)[1 + (r-1)mu]." Under majority: E[V_H(mu,M)] = lambda_M * V_e(mu), so v(mu,M) = lambda_M * V_e(mu) - alpha * V_e(mu) = (lambda_M - alpha) * V_e(mu). Since V_e(mu) = 1 + (r-1)mu, this matches. CORRECT.

**Line 1121 (Majority entry is monotone):**
"E_M = [tau(M), 1]." Under majority, V_W(mu,M) = kappa_M * V_e(mu) (A.7), which is affine and increasing in mu. So the entry set {mu : V_W >= c} is an interval [tau(M), 1]. CORRECT.

**Lines 1123--1127 (Concavification argument):**
The proof shows cav v(p,M) = v(p,M) for p in E_M by bounding the value of any Bayes-plausible experiment. Key steps:
- Decomposition into signals where entry occurs (set A) and not. CORRECT.
- Bound: sum_{s in A} pi_s <= 1 and sum_{s in A} pi_s * mu_s <= p. Both CORRECT (partial sums).
- Since (lambda_M - alpha) > 0 (verified: equals (1-alpha)(N - beta(q-1))/N^2 > 0), replacing partial sums with upper bounds increases the expression. CORRECT.
- The upper bound equals v(p,M) when p in E_M. CORRECT.
- Combined with cav v(p,M) >= v(p,M) (definition), we get equality. CORRECT.

**Line 1129 (Final chain):**
"cav v(p,U) >= v(p,U) > v(p,M) = cav v(p,M)."
- First: definition of concave envelope. CORRECT.
- Second: conditional dominance (line 1121). CORRECT.
- Third: concavification equals the function at p in E_M (lines 1123-1127). CORRECT.

Since Pi_H*(R,p) = alpha*V_e(p) + cav v(p,R) and alpha*V_e(p) is common, Pi_H*(U,p) > Pi_H*(M,p). CORRECT.

### Completeness
- Covers the case p in E_U, which is the domain of Theorem 1. COMPLETE.
- Does not claim anything about p outside E_U (appropriate, since Theorem 2 handles the full comparison). COMPLETE.
- Handles the sub-case where the experiment sends some posteriors below tau(M) (the set A^c). COMPLETE.

### Net-gain consistency
- v(mu,R) is consistently defined as E[V_H] - alpha*V_e throughout. CONSISTENT.
- The formula v(mu,M) = (lambda_M - alpha)*V_e(mu) correctly subtracts the outside option. CONSISTENT.
- The concavification operates on v, not on raw V_H. CONSISTENT.

### Potential referee challenges
None identified. The proof is clean and self-contained.

---

## B.8 Audit (Proof of Theorem 2 -- Single-crossing)

### Status: PASS WITH CONCERNS

### Line-by-line analysis

**Line 1155 (Empty entry set):**
"If E_U = emptyset, then v(mu,U) = 0 for all mu, so u = 0 <= m." CORRECT. The dominance set is empty, which is trivially an upper interval (specifically, the empty set). CORRECT.

**Line 1157 (Structure of m(p) -- Preliminary):**
- "E_M = [tau(M), 1]": CORRECT (majority entry is monotone, verified in A.7).
- "v(mu,M) = (lambda_M - alpha)*V_e(mu) is affine on E_M": CORRECT (net-gain formula verified).
- "m(p) = S_M * p for p <= tau(M)": The concave envelope from origin (where v=0) to the affine part. Since v(mu,M)/mu = (lambda_M - alpha)[1/mu + (r-1)] is decreasing in mu for mu >= tau(M), the steepest ray from the origin hits at tau(M). So the concave envelope is linear from 0 to tau(M) with slope S_M = v(tau(M), M)/tau(M). CORRECT.
- "S_M = (lambda_M - alpha)*V_e(tau(M))/tau(M)": CORRECT.
- "(lambda_M - alpha) > 0 because (1-alpha)[N - beta(q-1)] > 0": Verified algebraically: lambda_M - alpha = (1-alpha)(N - beta(q-1))/N^2, alpha < 1/r < 1 and N > beta*floor(N/2) since beta < 1. CORRECT.
- "m(p)/p is weakly decreasing": constant S_M on (0, tau(M)], then (lambda_M - alpha)[1/p + (r-1)] which is decreasing, with continuity at tau(M). CORRECT.

**CONCERN (minor):** The formula S_M = v(tau(M),M)/tau(M) is undefined when tau(M) = 0 (i.e., entry occurs at all beliefs under majority). In that case, the linear segment [0, tau(M)] has zero length and m(p) = (lambda_M - alpha)*V_e(p) everywhere. The ratio m(p)/p is still decreasing. The proof's claims hold in this edge case but the description is slightly imprecise. **Severity: COSMETIC.** A hostile referee could note this but it does not affect correctness. The formula is just inapplicable when tau(M) = 0; the substantive claim (m(p)/p weakly decreasing) holds regardless.

**Line 1159 (Part 1: p >= a, p in E_U):**
"u(p) >= v(p,U) > v(p,M) = m(p)"
- First: cav v >= v by definition. CORRECT.
- Second: Lemma 1. Since p in E_U subset E_M, both net gains are well-defined. v(p,U) - v(p,M) = D(p) > 0. CORRECT.
- Third: "last equality holds because p >= tau(M) and the concave envelope of an affine function equals the function itself." Since p >= a >= tau(M), p in E_M, and m(p) = v(p,M) on E_M (proved in B.6 and verified in Preliminary). CORRECT.

**Line 1159 (Part 1: p not in E_U, p >= a):**
- "p lies in a gap (b,d) of E_U with b, d in E_U": Since E_U is a finite union of closed intervals (V_W^R1 is piecewise affine with finitely many pieces), any gap is bounded and the boundary points belong to E_U. The gap is bounded above because 1 in E_U (Lemma B.7). CORRECT.
- "u(b) > m(b) and u(d) > m(d)": Since b, d in E_U, by the previous argument. CORRECT.
- "u is concave, so u(p) lies weakly above the chord": Standard property of concave functions. CORRECT.
- "m is affine on [b,d] subset [tau(M), 1]": Since b >= a >= tau(M) and d <= 1, [b,d] subset E_M where m = v(.,M) is affine. CORRECT.
- "the chord is strictly above m at both endpoints, chord is strictly above m throughout (b,d)": The chord is affine, m is affine, their difference is affine, positive at both endpoints => positive throughout. CORRECT.
- Conclusion: u(p) >= chord(p) > m(p). CORRECT.

**Line 1161 (Part 2: p < a):**
- "On [0,a), v(p,U) = 0": Since a = inf E_U, no belief in [0,a) has entry under unanimity. CORRECT.
- "u(p) = S_U * p on [0,x] for some x >= a": Standard concave envelope theory. Since u(0) = 0 and v = 0 on [0,a), the concave envelope from the origin is linear until it first touches the function. The footnote explains this correctly. CORRECT.

**CONCERN (minor to moderate):** The claim "u(p) = S_U * p on [0,a]" implicitly assumes S_U >= 0. If v(p,U) = 0 for all p (E_U = emptyset), then u = 0 everywhere, but this case was handled at the top of the proof. When E_U != emptyset, v(p,U) > 0 for some p, so cav v(p,U) >= 0 for all p and the slope S_U from the origin is indeed >= 0. CORRECT but the positivity of S_U could be stated more explicitly. **Severity: COSMETIC.**

**Line 1163 (Part 2: sign analysis):**
- "Delta(p) = u(p) - m(p) = p[S_U - m(p)/p]": Since u(p) = S_U*p and m(p) = S_M*p (or possibly (lambda_M - alpha)*V_e(p) if p >= tau(M), but if p < a and a >= tau(M), then we need p < a, which could be >= or < tau(M)).

Wait -- this needs careful checking. p < a, and a >= tau(M). So p < a could mean p < tau(M) or tau(M) <= p < a. In both sub-cases:
  - If p < tau(M): m(p) = S_M * p, so m(p)/p = S_M. Then Delta(p) = p(S_U - S_M), constant sign. This is an upper interval vacuously (either all positive or all non-positive on (0, tau(M))).
  - If tau(M) <= p < a: m(p) = (lambda_M - alpha)*V_e(p), so m(p)/p = (lambda_M - alpha)[1/p + (r-1)], which is decreasing.

In either sub-case, m(p)/p is weakly decreasing (constant then decreasing), so S_U - m(p)/p is weakly increasing, and the level set {Delta > 0} is an upper interval. CORRECT.

- "S_U - m(p)/p is weakly increasing in p": Since m(p)/p is weakly decreasing (established in Preliminary). CORRECT.
- "Hence {p in (0,a) : Delta(p) > 0} is an upper interval in (0,a)": A weakly increasing function being positive defines an upper interval. CORRECT.

**Line 1165 (Combining):**
- "Delta(p) > 0 for all p >= a (Part 1) and {p in (0,a) : Delta(p) > 0} is an upper interval (Part 2), so {p in (0,1] : Delta(p) > 0} is an upper interval in (0,1]."

The combining logic: Part 1 gives [a, 1] subset {Delta > 0}. Part 2 gives {Delta > 0} intersect (0,a) is either empty or (p*, a) for some p*. The union is either [a,1] or (p*, 1], both upper intervals. CORRECT.

### Completeness
- E_U = emptyset case: handled at line 1155. COMPLETE.
- E_U != emptyset case: p >= a handled in Part 1 (both in E_U and in gaps). COMPLETE.
- p < a handled in Part 2. COMPLETE.
- Boundary p = a: a in E_U (E_U is closed), so Delta(a) > 0 by Part 1. The upper interval from Part 2 may or may not include points approaching a from below. In either case the full set is an upper interval. COMPLETE.
- p = 0: excluded from the domain (the theorem is about (0,1]). COMPLETE.

### Net-gain consistency
- u = cav v(.,U) and m = cav v(.,M) are both concavifications of net-gain functions. CONSISTENT.
- The formula v(mu,M) = (lambda_M - alpha)*V_e(mu) is the net gain (raw payoff minus alpha*V_e). CONSISTENT.
- The comparison Pi_H*(U,p) > Pi_H*(M,p) iff u(p) > m(p) uses the decomposition Pi_H* = alpha*V_e + cav v, with the common alpha*V_e canceling. CONSISTENT.

### Potential referee challenges

1. **tau(M) = 0 edge case** (COSMETIC): When majority entry occurs at all beliefs, the formula S_M = v(tau(M),M)/tau(M) is a 0/0 form. The proof's substantive claims (m(p)/p decreasing) hold regardless, but a pedantic referee might ask for clarification.

2. **S_U could be stated explicitly as > 0** (COSMETIC): The proof implies S_U >= 0 from context (E_U != emptyset implies v > 0 somewhere, so cav v > 0 somewhere, so the slope from origin is positive). Making this explicit would strengthen the argument marginally.

3. **The footnote on exposed points** (line 1161) is a correct but somewhat informal justification. A hostile referee versed in convex analysis could ask for a more rigorous statement. The claim is standard and correct, but the terminology ("exposed kink of the upper hull") is slightly non-standard. **Severity: COSMETIC.**

None of these rise to the level of logical gaps. All substantive steps are correct.

---

## Overall Verdict

Both proofs are **correct**. B.6 is airtight with no issues. B.8 is correct with three cosmetic concerns (tau(M)=0 edge case, explicit S_U > 0, footnote terminology) that do not affect logical validity. The net-gain definition v(mu,R) = E[V_H] - alpha*V_e is used consistently throughout both proofs; no legacy raw-payoff formulas appear. A hostile referee would find nothing substantive to challenge.

**B.6**: PASS
**B.8**: PASS WITH CONCERNS (all cosmetic)

---

## Detailed verification checklist

| Check | B.6 | B.8 |
|-------|-----|-----|
| E_U subset E_M correctly derived | YES | (uses B.6 result) |
| cav v(p,M) = v(p,M) for p in E_M | YES (explicit proof) | YES (references B.6/Preliminary) |
| Chain cav v(p,U) >= v(p,U) > v(p,M) = cav v(p,M) | YES | YES (Part 1) |
| v used as net gain throughout | YES | YES |
| m(p) structure (linear then affine) | N/A | YES |
| m(p)/p weakly decreasing | N/A | YES |
| Part 1 gap-filling argument | N/A | YES |
| Part 2 linear concave envelope | N/A | YES |
| Part 2 sign analysis via decreasing ratio | N/A | YES |
| Combining step | N/A | YES |
| All cases covered | YES | YES |
| (lambda_M - alpha) > 0 verified | YES (implicit) | YES (explicit) |
