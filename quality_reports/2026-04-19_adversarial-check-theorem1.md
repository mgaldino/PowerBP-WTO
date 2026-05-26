# Adversarial Proof Check: Theorem 1 (Main Theorem)

**Date**: 2026-04-19
**File**: `formal_model.Rmd`, lines 443--526
**Theorem**: Theorem \ref{thm:main} ("When informational power substitutes for agenda power")

---

## Part I: Is the Diagnosis Correct?

### Problem 1: Uniqueness of g-bar

**Diagnosis claim**: "Convexity plus divergence does not imply a unique crossing." A convex function can be positive for small g, negative on an intermediate interval, and positive again for large g. So convexity and divergence imply at most eventual positivity, not uniqueness.

**Verdict: The diagnosis is CORRECT but the severity is overstated.**

The mathematical claim is accurate. Let f(g) = S_C(g) - S_A(g). We know f is convex (supremum of affine functions minus an affine function) and f(g) -> +infinity. This does NOT imply a unique zero. A convex function that diverges to +infinity can have zero, one, or two zeros. Specifically:

- If f(0) > 0, then f could be everywhere positive (no crossing), or dip below zero and come back (two crossings).
- If f(0) = 0, there could be one or two crossings.
- If f(0) < 0, there is at least one crossing.

However, the diagnosis overstates the problem because **convexity actually gives us MORE than the diagnosis acknowledges**. A convex function f: R -> R that diverges to +infinity has a well-defined minimum. Let g_min = argmin f. Then:

- If f(g_min) > 0: f is always positive, so g-bar = 0 works.
- If f(g_min) = 0: f is non-negative everywhere, g-bar = g_min works.
- If f(g_min) < 0: f has exactly TWO zeros g_1 < g_2 and f(g) > 0 for g > g_2.

In ALL cases, the definition g-bar = inf{g_0 >= 0 : S_C(g) > S_A(g) for all g > g_0} is well-defined and finite. The key point is that **the EXISTENCE of a finite g-bar such that S_C(g) > S_A(g) for all g > g-bar is correct**. The only error is calling g-bar "unique" in the sense of a unique crossing; in fact there might be a region below g-bar where S_C > S_A as well. But this does not affect the theorem statement, which only claims existence of g-bar, not that it is the unique crossing.

Wait -- the proof text says: "there exists a **unique** g-bar >= 0 such that S_C(g) > S_A(g) for all g > g-bar." This sentence, properly parsed, defines g-bar as the boundary below which the condition fails. If we define g-bar = inf{g_0 : S_C(g) > S_A(g) for all g > g_0}, then g-bar is indeed unique by construction (infimum of a non-empty set). The issue is only if the author means "unique g such that f(g) = 0," which would be wrong. Reading the proof charitably, the statement is defining g-bar by the property "S_C(g) > S_A(g) for all g > g-bar," and such a g-bar is unique as long as the property holds eventually (which it does since f diverges).

**Severity: MINOR (2/10).** The claim in the proof is technically ambiguous. The word "unique" is sloppy if read as "unique crossing," but can be read as "unique threshold" (which is correct by infimum construction). The fix is purely cosmetic: replace "unique" with explicit infimum definition.

### Problem 2: The first display in Step 3

**Diagnosis claim**: The inequality

[g + E[V_H(C,mu)]]/mu >= [g + E[V_H(C,tau(C))]]/tau(C)

for ANY mu >= tau(C) is not established and need not hold.

**Verdict: The diagnosis is CORRECT. This is a genuine error in the proof text.**

Let me verify with a concrete example. Take mu > tau(C). The claimed inequality says:

(g + E[V_H(C,mu)])/mu >= (g + E[V_H(C,tau(C))])/tau(C)

This would require g(1/mu - 1/tau(C)) >= (E[V_H(C,tau(C))]/tau(C) - E[V_H(C,mu)]/mu), i.e.,

g/tau(C) - g/mu <= E[V_H(C,mu)]/mu - E[V_H(C,tau(C))]/tau(C).

Since mu > tau(C), the LHS is positive (for g > 0). The RHS depends on how fast E[V_H(C,mu)] grows relative to mu. There is NO reason this holds for all mu. For instance, if E[V_H(C,mu)] grows slowly (or has a jump down at mu_s), the ratio E[V_H(C,mu)]/mu could decrease as mu increases past tau(C).

**However, the proof does not actually NEED this inequality.** The proof immediately evaluates at mu = tau(C) in the next line, obtaining:

S_C(g) >= [g + E[V_H(C,tau(C))]]/tau(C)

This follows directly from the definition of S_C as a supremum: mu = tau(C) is in the feasible set, so the sup is at least the value at tau(C). The first display is a dead line -- it is written but never used. The argument goes:

1. S_C(g) >= sup of [g + E[V_H(C,mu)]]/mu over mu in [tau(C),1]
2. In particular, S_C(g) >= [g + E[V_H(C,tau(C))]]/tau(C) (feasibility bound)
3. Therefore S_C(g) - S_A(g) >= g(1/tau(C) - 1/tau(A)) + constant

Step 2 follows from step 1, and the false display is orphaned. The logical chain from sup-definition to the lower bound is correct even though the first display is wrong.

**Severity: MAJOR (4/10).** The mathematical claim as written is false. But it is not load-bearing: the conclusion follows from the feasibility bound (evaluating at mu = tau(C)), which the proof also states correctly on the very next line. Removing the false display leaves the proof intact.

### Problem 3: Extension to [tau(C), tau(A))

**Diagnosis claim**: The claim that slope comparison establishes dominance throughout [tau(C), tau(A)) requires a separate argument. The slope comparison only works for p in (0, tau(C)).

**Verdict: The diagnosis is PARTIALLY CORRECT but the gap is fillable.**

The proof claims: "For priors in [tau(C), tau(A)), Package C yields v(p,C) = g + E[V_H(C,p)] > 0 while cav v(p,A) = S_A(g)*p; for g > g-bar the same slope comparison implies cav v(p,C) >= v(p,C) > cav v(p,A)."

The first part is correct: for p in [tau(C), tau(A)), v(p,C) > 0 (institution forms under C but not under A without persuasion). And cav v(p,A) = S_A(g)*p (since p < tau(A), the concavification under A is the line from origin).

The question is whether v(p,C) > S_A(g)*p for p in [tau(C), tau(A)).

Let me analyze this. We have v(p,C) = g + E[V_H(C,p)] and cav v(p,A) = S_A(g)*p where S_A(g) = [g + V_e(tau(A))(6-beta)/6]/tau(A).

So the question is: g + E[V_H(C,p)] > p * [g + V_e(tau(A))(6-beta)/6]/tau(A)?

This is NOT a direct consequence of S_C(g) > S_A(g). The slope comparison says that the line from origin to the optimal tangent point on v(.,C) has higher slope than S_A. But this tells us about cav v(p,C), not about v(p,C) itself. And cav v(p,C) >= v(p,C) is the wrong direction -- we need v(p,C) >= something.

Wait, actually for p in [tau(C), tau(A)), cav v(p,C) >= v(p,C) always (concavification is at least the function). And the proof needs cav v(p,C) > cav v(p,A). The proof says "cav v(p,C) >= v(p,C) > cav v(p,A)." The last inequality "v(p,C) > cav v(p,A)" needs a separate argument.

For this to hold, we need: g + E[V_H(C,p)] > S_A(g)*p.

At p = tau(C): LHS = g + E[V_H(C,tau(C))], RHS = S_A(g)*tau(C) = tau(C)/tau(A) * [g + V_e(tau(A))(6-beta)/6]. Since tau(C)/tau(A) < 1, the RHS is strictly less than g + V_e(tau(A))(6-beta)/6. Meanwhile, the LHS has g (the same g) plus the continuation value at tau(C). So the comparison at tau(C) is:

g + E[V_H(C,tau(C))] vs. (tau(C)/tau(A))[g + V_e(tau(A))(6-beta)/6]

Rewriting: g(1 - tau(C)/tau(A)) + E[V_H(C,tau(C))] - tau(C)/tau(A) * V_e(tau(A))(6-beta)/6.

For large g, the term g(1 - tau(C)/tau(A)) dominates since tau(C) < tau(A), so the LHS wins for large g. This is essentially the SAME condition as S_C(g) > S_A(g) applied at the point tau(C).

At p = tau(A): LHS = g + E[V_H(C,tau(A))], RHS = S_A(g)*tau(A) = g + V_e(tau(A))(6-beta)/6. By Lemma 5 (pointwise dominance), E[V_H(C,tau(A))] < V_H(A,tau(A)) = V_e(tau(A))(6-beta)/6. So at p = tau(A), LHS < RHS. The comparison reverses!

So v(p,C) > S_A(g)*p is NOT guaranteed for all p in [tau(C), tau(A)). The inequality holds at p = tau(C) for large g but fails at p = tau(A). By continuity, there exists some crossover point in (tau(C), tau(A)) where v(p,C) = S_A(g)*p.

However, the KEY INSIGHT the diagnosis misses is that we do not need v(p,C) > S_A(g)*p on the entire interval. We need cav v(p,C) > S_A(g)*p. And cav v(p,C) may exceed v(p,C) on parts of this interval. The concavification of v(.,C) uses the line from origin to the optimal tangent point, and for p values before the tangent point, cav v(p,C) = S_C(g)*p > S_A(g)*p (when g > g-bar). But the tangent point mu* might be in [tau(C), tau(A)), in which case for p > mu*, cav v(p,C) equals v(p,C) on the concave part (if the function is concave there) or follows the concave envelope.

Actually, let me reconsider. For p in (0, tau(C)), cav v(p,C) >= S_C(g)*p (by definition of S_C and concavification). And cav v(p,A) = S_A(g)*p. So dominance on (0, tau(C)) follows directly from S_C > S_A. Good.

For p in [tau(C), tau(A)), the situation is more complex. The concavification cav v(p,C) might equal v(p,C) if the function is locally concave, or it might interpolate between values. The proof's claim that dominance extends is not immediately justified.

But here is the critical observation: **the theorem statement says "For p < p*, the hegemon strictly prefers Package C" with p* in (0, tau(A))**. It does NOT claim dominance on the entire interval (0, tau(A)). The crossover p* might well lie in (tau(C), tau(A)). So the proof only needs:

1. Delta(p) > 0 for SOME p in (0, tau(A)) -- established for p in (0, tau(C)) by the slope argument.
2. Delta(p) < 0 for p > tau(A) -- established in Step 4.
3. Continuity of Delta -- established.
4. IVT gives crossover p*.

The extension to [tau(C), tau(A)) is NOT needed for the theorem as stated. It would only be needed if the theorem claimed "Package C dominates for ALL p < p*" where p* > tau(C) -- but the theorem does not require p* > tau(C), only p* in (0, tau(A)).

**However**, there IS a subtle issue. Theorem part (1) says "For p < p*, the hegemon strictly prefers Package C." This is a universal statement: for ALL p < p*, Package C dominates. If p* > tau(C), then we need dominance on (0, p*) including possibly [tau(C), p*). The IVT argument only gives the existence of a FIRST crossing, but Delta could oscillate. We need Delta(p) > 0 on (0, p*) for the theorem statement to hold as written.

Actually, the theorem says there EXISTS p* such that for p < p*, C dominates. If we define p* as the infimum of {p : Delta(p) < 0}, then for p < p*, Delta(p) >= 0 by construction. Combined with the fact that Delta is continuous and Delta(p) > 0 for small positive p, we get Delta > 0 on (0, p*).

Wait -- Delta could be 0 at some points before p*. Let p* = inf{p > 0 : Delta(p) <= 0}. Then for p in (0, p*), Delta(p) > 0 (by the infimum property and continuity). This works if p* > 0, which is guaranteed because Delta(p) > 0 for p in (0, tau(C)) when g > g-bar.

So the extension to [tau(C), tau(A)) is not needed. p* could be anywhere in (0, tau(A)], and the proof works by defining p* as the first zero of Delta.

**Severity: MINOR-to-MAJOR (3/10).** The proof text makes a claim about extension to [tau(C), tau(A)) that is not properly justified. However, the claim is not needed for the theorem. The fix is to simply delete the extension claim and let p* be defined as the first zero of Delta, which could be in (0, tau(C)] or in (tau(C), tau(A)).

---

## Part II: Is the Proposed Correction Valid?

### Correction 1: Replace "unique g-bar" with "there exists a finite g-bar"

**Assessment: VALID but arguably unnecessary.** As discussed above, g-bar defined as inf{g_0 >= 0 : S_C(g) > S_A(g) for all g > g_0} is unique by construction. The fix clarifies the text without changing the mathematics. It is a good editorial improvement.

**New gaps introduced**: None.

**Over-correction**: Slightly. The original could be saved by clarifying the definition. But the proposed fix is cleaner.

### Correction 2: Fix Step 3 to use only the feasibility bound

**Assessment: VALID and CORRECT.** The weaker statement S_C(g) >= [g + E[V_H(C,tau(C))]]/tau(C) is all that is needed. The false inequality about general mu should be deleted.

**New gaps introduced**: None. The logical chain is preserved.

**Could a stronger result be recovered?** Yes: S_C(g) is actually the sup over all mu >= tau(C), so it could exceed the tau(C)-evaluation significantly. But the lower bound at tau(C) suffices for the divergence argument.

### Correction 3: Drop extension to [tau(C), tau(A))

**Assessment: VALID and in fact the RIGHT call.** As argued in Part I, the extension is not needed for the theorem. The proof is cleaner without it.

**New gaps introduced**: None. The IVT argument (Correction 4) works without it.

**Over-correction**: Very slightly. A more ambitious correction could establish that cav v(p,C) > S_A(g)*p on [tau(C), tau(A)) directly (using the concavification, not v itself). But this would require detailed analysis of the shape of cav v(.,C) on that interval, which is unnecessarily complex.

### Correction 4: IVT adjustment

**Assessment: VALID.** The IVT argument requires:
- Delta(p) > 0 for SOME p small.
- Delta(p) < 0 for SOME p large.
- Delta continuous.

The correction establishes Delta > 0 on (0, tau(C)) (from the slope argument) and Delta < 0 for p > tau(A) (from Step 4). Since tau(C) < tau(A), there exist points where Delta > 0 and points where Delta < 0. IVT gives a zero.

**New gaps**: None.

### Correction 5: Define g-bar as infimum

**Assessment: VALID and mathematically clean.** The definition g-bar = inf{g_0 >= 0 : S_C(g) > S_A(g) for all g > g_0} is well-defined because:
- The set is non-empty (S_C - S_A diverges, so eventually positive).
- The set is bounded below (by 0).
- The infimum exists by completeness of R.

And g-bar is finite because S_C - S_A diverges, so the set contains arbitrarily large elements, but we need the infimum to be finite. Actually, the set IS non-empty (take g_0 large enough), and g-bar = inf of a non-empty subset of [0, infinity). If S_C(0) > S_A(0), then g-bar = 0. Otherwise, g-bar > 0 and finite.

**No new gaps.**

### Correction 6: Conforming edits

**Assessment: Needs careful checking.** The theorem statement as currently written says:

"For N=3, there exists a threshold g-bar(r,beta,c) >= 0 such that, for g > g-bar, there is a crossover prior p* in (0, tau(A)) with:
1. For p < p*, the hegemon strictly prefers Package C.
2. For p > tau(A), the hegemon strictly prefers Package A.
3. The crossover depends on (r,beta,c,g)."

Does this need to change? The theorem statement is actually fine as written. The corrections affect the PROOF, not the statement. The proof now establishes:
- Delta(p) > 0 on (0, tau(C)) [from corrected Step 3]
- Delta(p) < 0 for p > tau(A) [from Step 4]
- IVT gives p* [from Step 5]
- For p < p* = inf{p : Delta(p) <= 0}, Delta(p) > 0 [by continuity and infimum]

The theorem statement survives intact.

---

## Part III: Collateral Damage Check

### 1. Does Step 4 survive intact?

**YES.** Step 4 is logically independent of Steps 1-3. It uses Lemma 5 (pointwise dominance) and the concavification upper bound argument. The corrections to Step 3 do not affect Step 4.

However, I note a subtle issue in Step 4 that the diagnosis did NOT catch:

The proof defines h(mu) = g + V_H(A,mu) for mu >= tau(C), then claims "v(mu,C) <= h(mu) for all mu in [0,1]." But v(mu,C) = 0 for mu < tau(C) and h(mu) = 0 for mu < tau(C), so at mu < tau(C), v(mu,C) = h(mu) = 0 (equality, not strict inequality). For mu in [tau(C),1], v(mu,C) = g + E[V_H(C,mu)] and h(mu) = g + V_H(A,mu). By Lemma 5, V_H(A,mu) > V_H(C,mu) for all mu. But V_H(C,mu) is the continuation value under C, while E[V_H(C,mu)] is... what exactly? Let me check.

Looking at the definition: v(mu,R) = 1{mu >= tau(R)} [g + E[V_H(R,mu)]]. The notation E[V_H(R,mu)] means the expected value of V_H over theta, given posterior mu. So E[V_H(C,mu)] = mu * V_H(C,theta=1,mu) + (1-mu) * V_H(C,theta=0,mu). And V_H(A,mu) in Lemma 5 is... also the expected value? Let me check Lemma 1: V_H(A,mu) = V_e(mu)(6-beta)/6. This is already an expected value (since V_e(mu) = 1 + mu(r-1)). So E[V_H(A,mu)] = V_H(A,mu) because the function is already expressed in terms of the expected pie.

Actually, in the proof of Step 4, h(mu) = g + V_H(A,mu) where V_H(A,mu) is the expected continuation value under A (already computed as V_e(mu)(6-beta)/6). And v(mu,C) = g + E[V_H(C,mu)]. So the comparison is E[V_H(C,mu)] vs V_H(A,mu), where both are expected continuation values at posterior mu.

Lemma 5 states V_H(A,mu) > V_H(C,mu) "for all mu in [0,1]." But here V_H(R,mu) must be the expected continuation value (already averaged over theta given mu), since V_H(A,mu) = V_e(mu)(6-beta)/6 is manifestly an expected value. The proof of Lemma 5 works with expected values. So Step 4 is correct.

One more check: the proof claims "F must place positive mass on (tau(C), 1]" for any distribution with mean p > tau(C). This is correct because if F only places mass on [0, tau(C)], the mean cannot exceed tau(C) (since the support is bounded by tau(C) and F is a probability distribution -- actually, it could place mass on exactly tau(C) and get mean = tau(C), but we need p > tau(C) strictly, so mass must be placed above tau(C)).

Actually wait: the proof says "for any distribution of posteriors F with mean p > tau(C), F must place positive mass on (tau(C), 1]." But the theorem says p > tau(A) > tau(C). So for p > tau(A), we need the mean to be achievable. Since tau(A) < 1, this is feasible. The claim that F places mass on (tau(C), 1] is correct but what we really need is mass on (tau(C), 1] where v(mu,C) < h(mu) strictly. And v(mu,C) < h(mu) for mu in (tau(C), 1] by Lemma 5. This is fine.

**Verdict: Step 4 survives intact.**

### 2. Does the IVT argument in Step 5 remain valid?

**YES.** With the weakened Step 3:
- Delta > 0 on (0, tau(C)) for g > g-bar.
- Delta < 0 for p > tau(A) (Step 4).
- Both cav v(p,C) and cav v(p,A) are continuous (as concavifications of piecewise continuous functions with compact domains). Actually, cav v(p,C) is continuous because the concavification of any bounded function on [0,1] is continuous. More precisely, the concave envelope of a bounded upper-semicontinuous function is continuous. Here v(mu,C) has an upward jump at mu_s, so it is lower-semicontinuous at mu_s, not upper-semicontinuous. This matters!

Wait -- this is a potential issue. The concavification of v(mu,C) requires v to be upper-semicontinuous for the standard result. If v has an upward jump (v is lower-semicontinuous at mu_s), the concavification is still well-defined (it's the pointwise infimum of all affine functions that dominate v), but the standard continuity results need checking.

Actually, for Bayesian Persuasion, the standard result (Kamenica-Gentzkow 2011) applies to any measurable, bounded sender payoff function. The concavified value function cav v(p) is always continuous in p (it is concave on [0,1], and a concave function on an interval is continuous on the interior). So Delta is continuous on (0,1).

**Verdict: Step 5 survives intact.**

### 3. Are Lemmas 1-5 affected?

**NO.** The corrections only affect the proof of Theorem 1. Lemmas 1-5 are upstream results about bargaining payoffs, entry thresholds, and pointwise dominance. None of them reference the concavification or the g-bar threshold.

### 4. Does the theorem statement need to change?

**NO.** The theorem as stated is:
- There exists g-bar >= 0 (correct, now properly justified)
- For g > g-bar, there exists p* in (0, tau(A)) (correct, via IVT)
- For p < p*, C dominates (correct, by definition of p* as first zero)
- For p > tau(A), A dominates (correct, Step 4 is untouched)

The theorem statement needs NO changes. Only the proof needs corrections.

### 5. Does Example 1 still hold?

**YES.** Example 1 (r=1.5, beta=0.7, g=0.5, c=0.5) provides numerical values of mu_s, tau(A), tau(C). The corrections do not affect the numerical computations. The example confirms the existence of a crossover, which is what the corrected theorem states.

The example says "there exists a crossover prior p* such that H prefers C for p < p* and A for p > tau(A)." This is exactly the theorem statement.

### 6. Does Remark 3 (explicit bound for g-bar) need revision?

**PARTIALLY.** The remark provides a formula for g-bar assuming the tangent point is mu* = mu_s. The formula itself is an explicit computation and does not depend on the uniqueness claim. However, the remark should clarify that this provides a SUFFICIENT condition (i.e., an upper bound on g-bar), not necessarily the exact g-bar. The current text already says "g-bar provides a conservative bound," so this is already properly hedged.

The numerical verification (g = 0.5 > g-bar ~ 0.47) is correct and unaffected.

---

## Part IV: Missed Issues

### 1. Step 1: Is the concavification under Package A correct?

**YES.** I verified this independently:
- v(mu,A) = 0 for mu < tau(A)
- v(mu,A) = g + V_e(mu)(6-beta)/6 for mu >= tau(A) (affine in mu)
- The concave envelope on [0, tau(A)] is the line from origin to (tau(A), v(tau(A),A)) with slope S_A(g) = v(tau(A),A)/tau(A).
- For mu > tau(A), cav v(mu,A) = v(mu,A) because the function is affine (hence concave) and lies above the line S_A*mu (verified: the slope of v(mu,A) in mu is (r-1)(6-beta)/6, while S_A(g) = g/tau(A) + V_e(tau(A))(6-beta)/(6*tau(A)) > (r-1)(6-beta)/6 for g > 0).

**No issues.**

### 2. Is S_C really convex in g?

**YES.** S_C(g) = sup_{mu in [tau(C),1]} [g + E[V_H(C,mu)]]/mu = sup_{mu} [g/mu + E[V_H(C,mu)]/mu]. For each fixed mu, the function g -> g/mu + constant is affine in g. The supremum of a family of affine functions is convex. This is correct.

**No issues.**

### 3. Step 4: Is Lemma 5's proof valid?

**YES, with one caveat.** The proof checks both branches (aggressive and conservative) of V_H(C,mu) and shows V_H(A,mu) - V_H(C,mu) > 0 on each. The approach is: show positivity at mu=0 and show the difference is increasing. This is valid.

The caveat: the proof uses Assumption (eq:assump_P) to bound r-1 < (3-2beta)/(2beta). I verified: for the aggressive branch, the bound at mu=0 requires V_H(A,0) - V_H(C,0) = (4-beta)/6 - 10beta(r-1)/27 > 0. Under the assumption, 10beta(r-1)/27 < 10beta(3-2beta)/(27*2beta) = 5(3-2beta)/27 = (15-10beta)/27. So the bound becomes (4-beta)/6 - (15-10beta)/27 = [18(4-beta) - 6(15-10beta)]/(162) = [72-18beta-90+60beta]/162 = [-18+42beta]/162 = (42beta-18)/162. For beta > 18/42 = 3/7 ~ 0.429, this is positive. For beta < 3/7, the bound is negative!

**THIS IS A POTENTIAL ISSUE THE DIAGNOSIS MISSED.** The proof claims V_H(A,0) - V_H(C,0) > (18 + 33beta)/162 > 0. Let me recheck the algebra in the proof.

The proof states: "Substituting and simplifying yields V_H(A,0) - V_H(C,0) > (18 + 33beta)/162 > 0."

Let me redo: V_H(A,0) = V_e(0)(6-beta)/6 = (6-beta)/6. And V_H(C,0) on the conservative branch: I need to compute E[V_H(C,mu=0)].

Wait -- the proof of Lemma 5 works on two branches. On the conservative branch (mu >= mu_s), at mu = 0 (which is NOT on the conservative branch since mu_s > 0), the proof is establishing a lower bound by evaluating at mu=0 and showing it is increasing. But the conservative branch only applies for mu >= mu_s. So the evaluation at mu=0 is for the purpose of bounding the function on [mu_s, 1] by showing it is increasing and positive at the left endpoint.

Hmm, but mu_s > 0, so evaluating at mu = 0 gives a bound below the actual minimum at mu = mu_s. If the difference is positive at mu = 0 and increasing, it is positive at mu_s and beyond. Let me just recheck the algebra.

V_H(A,mu) - V_H(C,mu) on conservative branch:
= V_e(mu)(4-beta)/6 - 2beta(r-1)(5-4mu-mu^2)/27

At mu = 0: = (4-beta)/6 - 10beta(r-1)/27.

Under Assumption (eq:assump_P): r < N/((N-1)beta) = 3/(2beta), so r-1 < (3-2beta)/(2beta).

10beta(r-1)/27 < 10beta * (3-2beta)/(2beta) / 27 = 10(3-2beta)/(2*27) = 5(3-2beta)/27.

So V_H(A,0) - V_H(C,0) > (4-beta)/6 - 5(3-2beta)/27.

= [27(4-beta) - 30(3-2beta)] / 162

= [108 - 27beta - 90 + 60beta] / 162

= [18 + 33beta] / 162

Since beta > 0, this is indeed > 0. The proof's algebra checks out.

**No issues with Lemma 5.**

### 4. Continuity of Delta(p)

**Addressed in Part III item 2.** Delta is continuous because both concavifications are concave functions on (0,1) and concave functions on an open interval are continuous.

### 5. Boundary behavior at p = 0

The theorem says "For p < p*, the hegemon strictly prefers Package C." At p = 0, both concavified values are 0 (no information, no persuasion, no entry under either package). So Delta(0) = 0. The theorem should say "For p in (0, p*)" or "For 0 < p < p*", not "For p < p*" (which would include p = 0 where the functions are equal).

Checking the theorem statement: "For p < p*, the hegemon strictly prefers Package C." Since p is assumed to be the prior in (0,1) (from the model setup), and the proof establishes Delta(p) > 0 for p in (0, tau(C)), this implicitly assumes p > 0. But the statement should be explicit.

**THIS IS A MINOR ISSUE THE DIAGNOSIS MISSED.** At p = 0, both values are zero. The strict preference claim fails at p = 0. The fix: change "For p < p*" to "For 0 < p < p*" or "For p in (0, p*)."

**Severity: MINOR (1/10).** Trivial boundary fix.

### 6. An additional issue: the concavification cav v(p,C) = S_C(g)*p may not hold with equality

The proof of Step 3 uses cav v(p,C) >= S_C(g)*p. This is a lower bound. But the actual concavification could be strictly greater than S_C(g)*p for some priors if the optimal signal structure differs from the "0 and mu*" binary signal. In standard BP, the concavification on [0, tau(C)] IS exactly S_C(g)*p (the line from origin to the optimal tangent point). But S_C(g) as defined is the slope of this tangent line, so cav v(p,C) = S_C(g)*p on [0, mu*] where mu* is the tangent point.

Actually wait. S_C is defined as sup_{mu >= tau(C)} v(mu,C)/mu. The concavification of v(mu,C) on [0,1] for p < tau(C) involves the line from origin to the point (mu*, v(mu*,C)) where mu* maximizes v(mu,C)/mu. This gives cav v(p,C) = (v(mu*,C)/mu*) * p = S_C(g) * p for p in [0, mu*]. If v is concave on [mu*, 1], then cav v(p,C) = v(p,C) for p >= mu*. But v has a jump at mu_s, so it may not be concave everywhere above tau(C). The tangent line from the origin could "skip" over non-concave parts.

The key claim is that cav v(p,C) >= S_C(g)*p for p in [0, tau(C)]. Since p < tau(C) < mu* (the tangent point is at mu* >= tau(C)), we have cav v(p,C) = S_C(g)*p on this interval. Actually, the tangent point mu* could be tau(C) itself, or some point above. In any case, the concavification on [0, mu*] is indeed the line from origin with slope v(mu*,C)/mu* = S_C(g).

But wait: is cav v(p,C) exactly S_C(g)*p for p in [0, mu*], or could there be a better concavification that uses multiple tangent points? In standard BP, the concavification is the smallest concave function that dominates v. For v that is zero on [0, tau(C)] and positive on [tau(C), 1], the concavification on [0, some point] is a line from origin. The slope of this line is exactly max_{mu >= tau(C)} v(mu,C)/mu = S_C(g). So cav v(p,C) = S_C(g)*p for p in [0, mu*] where mu* achieves the maximum. For p > mu*, the concavification follows the concave envelope of v(.,C).

So the inequality cav v(p,C) >= S_C(g)*p is correct, and is actually an equality for p in [0, tau(C)] (since tau(C) <= mu*).

**No new issues.**

### 7. Is V_H(C,mu) actually well-defined for the concavification?

The hegemon's value function v(mu,C) has a jump at mu_s. This means v is not continuous. The concavification of a discontinuous function is still well-defined (pointwise infimum of affine functions dominating v). But I should check: does the jump create any problems for the slope comparison?

The jump at mu_s is UPWARD (Lemma 3). So v(mu_s^+, C) > v(mu_s^-, C). This means v is lower-semicontinuous at mu_s. For concavification, this is fine -- the concave envelope will "see" the higher value at mu_s^+.

For the S_C(g) computation, we take sup of v(mu,C)/mu. Since v has an upward jump, the right-limit value at mu_s is higher. S_C uses the sup, so it will pick up the higher value. The sup is well-defined on the compact domain [tau(C), 1] because v(mu,C)/mu is bounded and piecewise continuous.

**No issues.**

---

## Part V: Overall Assessment

### 1. Severity Score: 3/10

The issues are real but not structurally threatening:
- Problem 1 (uniqueness of g-bar): MINOR. Cosmetic fix. (1/10)
- Problem 2 (false display): MAJOR in presentation but not in logic. The false inequality is a dead line that doesn't feed into the argument. (4/10)
- Problem 3 (extension to [tau(C), tau(A))): MINOR-to-MAJOR. The extension claim is not justified, but it is not needed. (3/10)

No single issue breaks the proof. The logical chain from Step 1 through Step 5 survives with the corrections.

### 2. Does the main result survive?

**YES.** The theorem statement is correct as written. The corrections are to the proof, not the result. After the corrections:
- S_C(g) > S_A(g) for g > g-bar (lower bound argument, corrected)
- cav v(p,C) > cav v(p,A) for p in (0, tau(C)) when g > g-bar (from slope comparison)
- cav v(p,A) > cav v(p,C) for p > tau(A) (Step 4, untouched)
- IVT gives crossover p*

### 3. Strongest correct version of the theorem

The theorem as stated IS the strongest correct version, assuming we add "0 < p < p*" in part (1). Specifically:

**Theorem (corrected).** For N=3, there exists a finite threshold g-bar(r,beta,c) >= 0 such that, for g > g-bar, there is a crossover prior p* in (0, tau(A)) with the following properties:

1. For 0 < p < p*, the hegemon strictly prefers Package C.
2. For p > tau(A), the hegemon strictly prefers Package A.
3. The crossover depends on (r,beta,c,g) through both the entry threshold and the screening cutoff mu_s.

This is unchanged from the current statement (with the trivial boundary fix).

Could we recover uniqueness of p*? Possibly, if Delta is shown to be monotonically decreasing on (0, tau(A)). This would require that the concavification advantage of C shrinks monotonically as p increases. This is plausible (higher p means less need for persuasion, reducing C's advantage) but would need a separate argument.

Could we recover an explicit formula for g-bar? The remark already provides one under the assumption that the tangent point is mu_s.

### 4. Recommendations for the Author

1. **Delete the false display in Step 3** (the inequality claimed for "any mu >= tau(C)"). Replace with the direct feasibility bound at mu = tau(C).

2. **Replace "unique g-bar" with the infimum definition**: g-bar = inf{g_0 >= 0 : S_C(g) > S_A(g) for all g > g_0}. This is cleaner and avoids the ambiguity about uniqueness.

3. **Delete the extension to [tau(C), tau(A))** in Step 3. The theorem does not need it. The proof is cleaner without it.

4. **Fix the boundary**: Change "For p < p*" to "For 0 < p < p*" in the theorem statement (or equivalently, add "for p in (0, p*)" which the proof already implies).

5. **Define p* explicitly**: Let p* = inf{p > 0 : Delta(p) <= 0}. This ensures p* is the first crossing and that Delta > 0 on (0, p*).

6. **Keep Remark 3 as is.** It already says "conservative bound."

7. **Do not weaken the theorem statement.** The corrections are entirely to the proof's presentation, not to the result.

---

## Summary Table

| Issue | Diagnosis Correct? | Severity | Correction Valid? | Comment |
|-------|-------------------|----------|------------------|---------|
| Uniqueness of g-bar | Yes (partially) | MINOR | Yes | Cosmetic fix |
| False display in Step 3 | Yes | MAJOR (presentation) | Yes | Dead line, delete it |
| Extension to [tau(C), tau(A)) | Partially | MINOR-MAJOR | Yes (but unnecessary) | Not needed for theorem |
| IVT adjustment | N/A | N/A | Yes | Works fine |
| Infimum definition | N/A | N/A | Yes | Clean mathematical improvement |
| Boundary at p=0 | NOT CAUGHT | MINOR | N/A | Add "0 < p" |

**Bottom line**: The diagnosis correctly identifies presentation problems in the proof but overstates their severity. The proof's logical structure is sound -- the false display is never used, the uniqueness claim admits a natural repair, and the extension to [tau(C), tau(A)) is surplus. The proposed corrections are all valid, introduce no new gaps, and do not weaken the result. The main theorem survives intact.
