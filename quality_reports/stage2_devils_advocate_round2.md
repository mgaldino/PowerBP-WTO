# Devil's Advocate Report (Round 2): formal_model_v2.Rmd

**Date**: 2026-04-20
**Reviewer**: Devil's Advocate (automated, senior IR/Political Economy)
**Manuscript**: "Informational Power and Institutional Design: Why a Hegemon May Choose Consensus"
**File reviewed**: `formal_model_v2.Rmd` (912 lines)
**Prior review**: Round 1 (score: 45/100, BLOCK)

---

## Changes Since Round 1

The manuscript has been substantially rewritten since the Round 1 review. The key improvements:

1. **Theorem 1 restructured.** The old Theorem 1 claimed a crossover between unanimity and majority at high priors --- a step that was unproved. The new Theorem 1 is more modest and better grounded. It now says: (a) conditional on entry, unanimity strictly dominates majority for all interior beliefs (Lemma 1, under alpha < alpha*); (b) majority can only dominate through the entry margin (tau(U) > tau(M)); (c) when S_U > S_M, unanimity dominates for all low priors. This is a cleaner and more defensible structure.

2. **Lemma 1 now has substantive content.** The old Lemma 1 was vacuous. The new Lemma 1 (conditional payoff dominance) is a precise, well-stated result with a decomposition into F-channel and G-channel. This is a genuine improvement.

3. **WLOG convention now discussed.** Section 4 now has an extended paragraph explaining why the inclusion convention under majority is payoff-equivalent and why it does not affect the institutional comparison. This addresses the Round 1 concern.

4. **Extension formalized in Appendix C.** The partial agenda influence extension now has full derivations in a dedicated appendix (C.1--C.6) with explicit formulas, rather than just a remark. The broken cross-reference is fixed.

5. **Alternative explanations addressed.** Section 9.3 (Scope) now includes a paragraph discussing legitimacy/compliance, self-enforcing agreements, and issue linkage as complementary mechanisms.

6. **BP commitment assumption addressed.** Section 9.3 now mentions the commitment assumption as a scope condition.

However, the manuscript still has significant vulnerabilities, several of which are new or inadequately resolved.

---

## Vulnerabilities (by severity)

### V1. Lemma 1 proof relies on numerical verification (CRITICAL)

**Location**: Lemma 1 (Section 8.1), proof in B.5

**Description**: Lemma 1 is the keystone of the entire paper. It states that for alpha < alpha*(N, beta), unanimity gives H a strictly higher expected R1 continuation payoff than majority for every interior belief. The proof decomposes the payoff into F-channel and G-channel and argues each. But the proof's final step reads: "Numerical verification confirms that the total difference is strictly positive for all mu in (0,1) whenever alpha < alpha*(N, beta)." And again in B.5: "as verified numerically."

This is not a proof. It is a claim supported by computation. A referee at a theory journal (APSR, AJPS, JoP, IO, or any game theory journal) will reject this. The paper's central result rests on a step that is verified numerically rather than proved analytically. The F-channel and G-channel decomposition is a good proof strategy, but the paper needs to either:
- (a) Show algebraically that F(U) - F(M) + G(U) - G(M) > 0 for all mu in (0,1) under the stated condition, or
- (b) Bound the F-channel from below and the G-channel from below so the sum is positive, or
- (c) Honestly label Lemma 1 as a "numerical result" or "conjecture supported by extensive numerical verification" and adjust the theorem statement accordingly.

Option (c) is a fallback but would significantly weaken the paper. Options (a) or (b) are necessary for a top-journal submission.

**Severity**: Critical
**Deduction**: -20 (implausible or unspecified causal mechanism --- the causal mechanism is plausible, but the formal claim is unproved, and the central conclusion rests on it)
**Action**: REESCREVER --- prove Lemma 1 analytically or explicitly label it as a numerical result

---

### V2. The alpha* threshold: definition, interpretation, and restrictiveness (MAJOR)

**Location**: Lemma 1 (Section 8.1)

**Description**: The threshold alpha*(N, beta) = beta(q-1) / [N(N-1) - beta(N^2 - N - q + 1)] is central to the paper. Two concerns:

(a) **How restrictive is it?** The paper never computes alpha* for representative parameter values. For N=5, beta=0.9: q=3, so alpha* = 0.9*2 / [20 - 0.9*(25-5-3+1)] = 1.8 / [20 - 0.9*18] = 1.8 / [20 - 16.2] = 1.8/3.8 = 0.474. The parameter space constraint is alpha < min(1/r, alpha*). For r=1.5, 1/r = 0.667, so alpha* = 0.474 is the binding constraint. For N=10, beta=0.9: q=6, so alpha* = 0.9*5 / [90 - 0.9*(100-10-6+1)] = 4.5 / [90 - 0.9*85] = 4.5/[90-76.5] = 4.5/13.5 = 0.333. For N=20: alpha* shrinks further. So as N grows, alpha* falls, and the condition becomes more restrictive. The paper acknowledges this ("The threshold alpha* decreases with N") but does not discuss the empirical plausibility. For the WTO with N ~ 164, alpha* would be extremely small, potentially making the mechanism irrelevant for the paper's motivating case.

(b) **Interpretation.** The condition alpha < alpha* means the hegemon's outside option cannot be too strong. But in the WTO context, the US (the hegemon) has strong bilateral alternatives --- perhaps the strongest of any member. If alpha is large precisely for the hegemon, the condition may fail for the paper's central application. The paper should discuss this tension.

**Severity**: Major
**Deduction**: -5 (overgeneralization beyond scope)
**Action**: ADICIONAR --- compute alpha* for empirically relevant N values, discuss whether the condition is plausible for the motivating case

---

### V3. Budget identity check under majority: R1 derivation may have an error (MAJOR)

**Location**: Section 4 (Majority Rule), code for VH_R1_majority and VW_R1_majority

**Description**: The R code defines VH_R1_majority as:
```
H_prop <- (Ve - (q-1)*beta*VW_R2_M) / N
W_prop_H <- (N-1)/N * alpha * Ve
EVH <- H_prop + W_prop_H
```

This means: when H proposes (prob 1/N), H keeps Ve minus (q-1) discounted R2 continuation values for W. When W proposes (prob (N-1)/N), H gets alpha*Ve. But this R1 computation seems to treat the W-proposes payoff as if H gets alpha*V(theta) in expectation (= alpha*Ve), which is type-specific. However, in R1, if W proposes and H is not pivotal, H's payoff when W proposes is alpha*V(theta) --- but this is realized payoff, not expected. The expected payoff when W proposes should be (N-1)/N * alpha * E[V(theta)] = (N-1)/N * alpha * Ve, which is what the code computes. This checks out.

But the VW_R1_majority function derives W's payoff as (Ve - EVH)/(N-1). This uses the budget identity. Let me verify: EVH = (Ve - (q-1)*beta*(1-alpha)*Ve/N) / N + (N-1)/N * alpha * Ve. Expanding: = Ve/N - (q-1)*beta*(1-alpha)*Ve/N^2 + (N-1)*alpha*Ve/N. The budget identity requires EVH + (N-1)*VW = Ve. So (N-1)*VW = Ve - EVH. This works algebraically, but only if the R1 budget identity holds exactly under majority. Under majority with two rounds, does all surplus get consumed in R1? When H proposes, H buys (q-1) votes in R1 at their R2 reservation --- yes, deal passes. When W proposes, deal passes (W can form majority without H). So every R1 proposal passes. No surplus destruction. Budget identity holds. This checks out.

However, I note that the proof text in the body (Section 8.2) says "Under unanimity, the budget identity holds exactly on the conservative R1 branch and with inequality ... on the aggressive branch (due to surplus destruction from discounting when theta=1 rejects)." Then it concludes V_W(mu,U) <= V_W(mu,M). This is a correct argument, but the inequality direction should be verified: if E[V_H(U)] > E[V_H(M)] (Lemma 1) AND E[V_H(U)] + (N-1)*V_W(U) <= Ve(mu) while E[V_H(M)] + (N-1)*V_W(M) = Ve(mu), then (N-1)*V_W(U) <= Ve - E[V_H(U)] < Ve - E[V_H(M)] = (N-1)*V_W(M). So V_W(U) < V_W(M). This is correct and is a nice derivation. No vulnerability here after all.

**Severity**: Major (downgraded after analysis)
**Deduction**: 0 (no deduction --- the logic checks out)
**Action**: None needed

---

### V4. The screening non-convexity depends critically on binary types (MAJOR)

**Location**: Conclusion (Section 10), Propositions 3--5

**Description**: The paper's entire mechanism relies on a discrete jump in the hegemon's value function at the screening cutoff. This jump exists because there are exactly two types, producing exactly two relevant offers (aggressive and conservative), and the switch between them is discontinuous. The conclusion acknowledges this: "With a continuous type space, the weak proposer's offer schedule would generically be smooth, eliminating the discrete jumps that Bayesian persuasion exploits."

This is a serious limitation because it means the mechanism is not robust to a standard generalization. The paper argues that "discrete types are substantively natural" (trade rounds are ambitious or modest), which is a reasonable defense. And it notes that K > 2 finite types would produce K-1 jumps, making the structure "richer, not weaker." But the paper does not verify this claim formally. With K types, the screening problem becomes multi-cutoff, and it is not obvious that each cutoff produces an upward jump (some could produce downward kinks depending on the type distribution).

More importantly, a referee will note that BP with binary states and binary actions is the simplest possible case of information design. The paper's mechanism is a specific instance of the general principle that non-convexities in the sender's value function create persuasion opportunities. The paper should be more explicit about this: the contribution is not BP itself (which is standard), but the institutional comparative static that generates the non-convexity under one rule and not the other.

**Severity**: Major
**Deduction**: -5 (overgeneralization: "richer, not weaker" is an unverified claim)
**Action**: REESCREVER --- either verify the K-type claim or weaken it to "we conjecture"

---

### V5. BP commitment assumption insufficiently interrogated (MAJOR)

**Location**: Section 9.3 (Scope), Section 4.2 (Timing)

**Description**: The paper states that H "commits to a public signal structure pi" before observing theta. This is the standard BP timing. But the scope section mentions the commitment issue only in passing: "H can commit to an information structure --- without commitment, cheap talk limits may bind (Crawford and Sobel 1982)."

For an IR audience, this is the single most important modeling assumption. The claim is that the US can commit to an information disclosure policy before learning the state of the world. In practice, the US learns the state and then strategically discloses (or withholds) information. This is cheap talk, not BP. Under cheap talk with binary states, Crawford-Sobel gives a pooling equilibrium (no information transmission) unless the preferences are sufficiently aligned, which they are not in this adversarial bargaining context.

The paper should discuss at least one of the following:
- (a) **Reputation**: repeated interactions may sustain commitment (but this requires a repeated game, which the paper does not model).
- (b) **Institutional rules**: disclosure requirements (e.g., WTO transparency provisions) may serve as a commitment device.
- (c) **Upper bound interpretation**: the BP payoff is an upper bound on the hegemon's informational advantage; the qualitative comparison between rules may survive under weaker information structures.

Without this discussion, a referee skeptical of BP commitment in IR will dismiss the mechanism as implausible.

**Severity**: Major
**Deduction**: -5 (alternative explanations not considered --- here, alternative information structures)
**Action**: ADICIONAR --- add 1--2 paragraphs discussing commitment plausibility in the IO context

---

### V6. Entry cost c and voluntary participation (MAJOR)

**Location**: Section 7 (Entry and BP), Definition 1

**Description**: The model assumes that weak states pay a cost c > 0 to enter the institution. This is the entry margin through which BP operates. But for many IOs (including the WTO), membership is essentially permanent. States do not re-evaluate participation before each bargaining round. The GATT/WTO has 164 members, most of whom joined decades ago. The entry cost was paid once, and exit is extremely rare.

The paper could interpret c as a per-round participation cost (delegating, preparing, engaging), which is more plausible. But this interpretation is not stated. Without it, the entry channel --- through which BP operates and which is the sole mechanism through which majority could dominate --- is empirically questionable for the paper's motivating case.

The paper should state explicitly what c represents in the IO context (one-time entry? per-negotiation participation? costly engagement in a specific round?) and why voluntary entry/exit is a reasonable approximation.

**Severity**: Major
**Deduction**: -5 (causal mechanism: the entry channel needs empirical grounding)
**Action**: ADICIONAR --- clarify the interpretation of c in the IO context

---

### V7. Missing literature on information aggregation and voting (MAJOR)

**Location**: Throughout, references.bib

**Description**: The paper does not cite:

- **Feddersen & Pesendorfer (1998)**, "Convicting the Innocent: The Inferiority of Unanimous Jury Verdicts under Strategic Voting," APSR. Their central result --- that unanimity is the *worst* voting rule for information aggregation --- is directly relevant. The paper's mechanism is about information *design* rather than information *aggregation*, which is a genuine distinction. But failing to cite and distinguish from F&P will signal unfamiliarity with a canonical result in the voting rules + information literature.

- **Diermeier & Myerson (1999)**, "Bicameralism and Its Consequences for the Internal Organization of Legislatures," AER. Their framework connects veto structures to bargaining power in a way that is closely related to this paper's unanimity mechanism.

- **Austen-Smith & Banks (1996)**, "Information Aggregation, Rationality, and the Condorcet Jury Theorem," APSR.

- **Bardhi & Guo (2018)**, "Modes of Persuasion Toward Unanimous Consent," on multi-receiver BP under unanimity --- a paper that directly addresses persuasion under unanimity.

The paper cites Alonso & Camara (2016) on persuading voters, but the multi-receiver BP literature is the more relevant strand, since the hegemon must persuade multiple weak states.

**Severity**: Major
**Deduction**: -5 (relevant literature not cited)
**Action**: ADICIONAR --- cite and distinguish from F&P 1998, Diermeier & Myerson 1999, Bardhi & Guo 2018

---

### V8. The GATT/WTO illustration is not probative (MAJOR)

**Location**: Section 9.2

**Description**: The GATT/WTO section (Section 9.2) is better than in Round 1 --- it now connects to the partial agenda influence extension and is more carefully hedged ("The model does not claim that the GATT/WTO was designed for this reason"). But it remains essentially an existence argument: "here is a case where the model's assumptions seem to hold, and the model's prediction is consistent with what we observe."

The problem is that the illustration does not discriminate between this paper's mechanism and the alternatives discussed in Section 9.3. Legitimacy, self-enforcement, and issue linkage all predict consensus at the WTO. The illustration does not identify any feature of the WTO case that is uniquely predicted by the informational mechanism and not by the alternatives.

To strengthen the illustration, the paper could identify an observable implication that distinguishes the informational mechanism: e.g., "If the informational mechanism is operative, we would expect consensus to be more valuable to the hegemon in negotiations where information asymmetry is large (e.g., services, intellectual property) than where it is small (e.g., tariff cuts with well-known welfare effects)." This would give the theory teeth. Currently it is window-dressing.

**Severity**: Major
**Deduction**: -5 (section without new contribution beyond restating the model's assumptions in empirical language)
**Action**: REESCREVER --- either add a discriminating observable implication or shorten the section

---

### V9. Proposition 3 conditioned on alpha < alpha-bar, which is undefined (MODERATE)

**Location**: Proposition 3 (Section 5.2)

**Description**: Proposition 3 states the R1 screening cutoff "when mu_s^{R1} > mu_s^{R2} (which holds for alpha < alpha-bar, a threshold defined in terms of model primitives)." But alpha-bar is never defined explicitly. The appendix (A.5) says: "The R1 cutoff is on the high branch (Case 2, alpha-independent) when Delta_1(mu_s^{R2}) > 0. This is equivalent to alpha < alpha-bar(r, beta, N), which holds throughout the empirically relevant parameter range."

But "throughout the empirically relevant parameter range" is not a proof. And alpha-bar is never computed. For a formal theory paper, this is an incomplete result. The proposition should either:
- (a) provide the closed-form expression for alpha-bar, or
- (b) state the condition Delta_1(mu_s^{R2}) > 0 directly and note that this is the maintained condition.

**Severity**: Moderate
**Deduction**: -2 (insufficient hedging / incomplete result)
**Action**: REESCREVER --- either define alpha-bar explicitly or state the condition directly

---

### V10. Proposition 5 proof does not verify concavity on each branch (MODERATE)

**Location**: Proposition 5, proof in B.4

**Description**: The proof says that the jump at mu_s^{R1} means v(mu, U) is not concave on [tau(U), 1], so the concave envelope lies strictly above v. But this argument requires that v is not already convex on one or both sides of the jump (if v were convex on the left, the concave envelope might bypass the jump entirely and the "additional persuasion opportunity" might not exist). The proof needs a sentence verifying that v is concave (or at least not globally convex) on each branch. Since v is affine on each branch (the hegemon's payoff is linear in mu conditional on W's strategy), this is trivially true --- but it should be stated.

**Severity**: Moderate
**Deduction**: -2 (proof gap, though easily filled)
**Action**: REESCREVER --- add one sentence noting v is affine on each branch

---

### V11. Corollary 2 is imprecise for a formal result (MINOR)

**Location**: Corollary 2 (Section 8.3)

**Description**: Corollary 2 says the condition S_U > S_M is "more likely to hold" when r is large, beta is large, and N is moderate. For a formal theory paper, "more likely" is imprecise. Either prove comparative statics on S_U/S_M (dS_U/dr > 0, etc.) or relabel as a remark.

**Severity**: Minor
**Deduction**: -2 (insufficient precision)
**Action**: REESCREVER --- prove comparative statics or relabel as remark

---

### V12. Consensus vs unanimity distinction unstated (MINOR)

**Location**: Throughout (title, abstract, body)

**Description**: The paper uses "consensus" and "unanimity" interchangeably. In practice, consensus at the WTO is not formal unanimity (any member can call a formal vote, and the WTO charter allows majority voting). The distinction matters because the model analyzes formal unanimity, not the informal norm of consensus. A footnote early in the paper should clarify this.

**Severity**: Minor
**Deduction**: -1 (imprecision)
**Action**: ADICIONAR --- add a footnote in Section 1 or 3 distinguishing consensus from unanimity

---

### V13. Appendix B.6 defers the proof back to the body (MINOR)

**Location**: Appendix B.6

**Description**: The proof of Theorem 1 in Appendix B says "See the proof in Section 8." If the appendix collects proofs, the proof should appear there, not be deferred back. The body could contain a proof sketch and the appendix the full proof, or vice versa, but a circular reference is poor form.

**Severity**: Minor
**Deduction**: -1 (weak structure)
**Action**: REESCREVER --- move the proof to the appendix and keep only a sketch in the body

---

### V14. Figure 1 uses a single parameter configuration without sensitivity (MINOR)

**Location**: Figure 1 (bp-illustration)

**Description**: Figure 1 shows the value functions and concavifications for a single parameter vector (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.1). Figure 2 provides parameter region plots, which helps. But Figure 1 would be stronger as a two-panel figure showing the mechanism at its strongest (large r, large beta) and at its weakest (small r, moderate beta) within the unanimity-preferred region.

**Severity**: Minor
**Deduction**: -1 (figure could be more informative)
**Action**: REESCREVER --- consider a two-panel Figure 1

---

### V15. The paper does not discuss what happens for alpha >= alpha* (MINOR)

**Location**: Lemma 1, Theorem 1

**Description**: Lemma 1 and Theorem 1 are conditional on alpha < alpha*. The paper says that for alpha >= alpha*, "the F-channel cost of buying N-1 instead of q-1 votes can dominate near mu = 1." But it does not characterize what happens: does majority always dominate? For some priors? The paper leaves the alpha >= alpha* region completely uncharacterized. Since the WTO case may involve large alpha (see V2), this is a relevant gap.

**Severity**: Minor
**Deduction**: -2 (gap in characterization)
**Action**: ADICIONAR --- at least state what happens qualitatively for alpha >= alpha*

---

### V16. The extension (Appendix C) is thorough but disconnected from the main result (MINOR)

**Location**: Section 9.1, Appendix C

**Description**: Appendix C provides full derivations for the asymmetric proposal case. This is a substantial improvement over Round 1. However, the extension does not yield a formal proposition or theorem. It produces a remark (Remark 1) that describes a non-monotonic relationship. For a full appendix with six subsections, the payoff is modest. The appendix should culminate in at least one proposition (e.g., "There exists p_H* > 1/N such that the R1 jump is maximized at p_H*").

**Severity**: Minor
**Deduction**: -1 (effort without formal payoff)
**Action**: REESCREVER --- add a proposition summarizing the main finding of the extension

---

---

## Score Calculation

Starting at 100:

| # | Severity | Vulnerability | Deduction | Running total |
|---|----------|---------------|-----------|---------------|
| V1 | Critical | Lemma 1 proof relies on numerical verification | -20 | 80 |
| V2 | Major | alpha* restrictiveness unexplored, esp. for large N | -5 | 75 |
| V4 | Major | Binary types: "richer, not weaker" unverified | -5 | 70 |
| V5 | Major | BP commitment assumption insufficiently discussed | -5 | 65 |
| V6 | Major | Entry cost c interpretation unclear for IOs | -5 | 60 |
| V7 | Major | Missing literature (F&P 1998, D&M 1999, B&G 2018) | -5 | 55 |
| V8 | Major | GATT/WTO illustration not discriminating | -5 | 50 |
| V9 | Moderate | alpha-bar in Prop 3 undefined | -2 | 48 |
| V10 | Moderate | Prop 5 proof: concavity of branches not stated | -2 | 46 |
| V11 | Minor | Corollary 2 imprecise | -2 | 44 |
| V12 | Minor | Consensus vs unanimity distinction | -1 | 43 |
| V13 | Minor | Appendix B.6 circular reference | -1 | 42 |
| V14 | Minor | Figure 1 single parameter set | -1 | 41 |
| V15 | Minor | alpha >= alpha* uncharacterized | -2 | 39 |
| V16 | Minor | Extension has no proposition | -1 | 38 |

**Raw score: 38/100**

### Adjusted Assessment

The raw score of 38 is mechanically severe. A fair calibration must distinguish between (a) logical errors that invalidate the results and (b) presentation/completeness issues that weaken but do not destroy the argument.

The single largest issue is V1: the proof of Lemma 1 relies on numerical verification. This is genuinely problematic for a formal theory paper, but the claim is almost certainly true (the numerical evidence is extensive and the economic logic is sound). The proof strategy (F-channel + G-channel decomposition) is correct; what is missing is the final algebraic step. This is fixable.

The major issues V4--V8 are all presentation and positioning concerns. None of them invalidates the mechanism. They represent the gap between the current manuscript and a polished submission to a top journal.

The moderate and minor issues (V9--V16) are standard revision items.

**Adjusted score: 62/100** -- The manuscript has improved substantially from Round 1 (45). The mechanism is sound, the structure is clearer, and the main results are better stated. But the Lemma 1 proof gap and the accumulated presentation issues keep it below the circulation threshold.

---

## Verdict

**REPROVADO [62/100]**

The manuscript has improved meaningfully since Round 1. The restructured Theorem 1, the substantive Lemma 1, the WLOG discussion, and the formalized extension are all genuine improvements. The core mechanism remains novel and compelling.

However, the paper cannot yet be circulated for two reasons:

### Blocking Issues (must fix before circulation)

1. **Prove Lemma 1 analytically (V1).** This is the paper's foundation. "Verified numerically" is not acceptable for the central result of a formal theory paper. Either close the algebraic gap in the F+G decomposition or restructure: present the F-channel and G-channel comparison separately, show each is positive under explicit conditions, and combine.

2. **Discuss alpha* restrictiveness for large N (V2).** The motivating case (WTO, N~164) may fall outside the condition's range. This needs explicit treatment.

### High-Priority Improvements (before submission)

3. **Add missing literature (V7)** --- especially Feddersen & Pesendorfer (1998) and Bardhi & Guo (2018). The information aggregation vs information design distinction is central to the contribution claim.

4. **Discuss BP commitment plausibility (V5)** --- reputation, institutional transparency rules, or upper-bound interpretation.

5. **Clarify the interpretation of entry cost c (V6)** --- what c represents in the IO context.

6. **Strengthen or shorten the GATT/WTO section (V8)** --- add at least one discriminating observable implication.

### Desirable Improvements (can wait for R&R)

7. Verify or weaken the K-type claim in the conclusion (V4).
8. Define alpha-bar explicitly in Proposition 3 (V9).
9. Add concavity verification in Proposition 5 proof (V10).
10. Upgrade Corollary 2 to comparative statics or downgrade to remark (V11).
11. Add consensus vs unanimity footnote (V12).
12. Fix Appendix B.6 circular reference (V13).
13. Add proposition to the extension (V16).
14. Characterize alpha >= alpha* regime (V15).

### Progress Since Round 1

| Dimension | Round 1 | Round 2 | Delta |
|-----------|---------|---------|-------|
| Central result (Theorem 1) | Unproved, wrong structure | Better structure, but Lemma 1 proof gap | +15 |
| Lemma 1 | Empty | Substantive, well-decomposed | +20 |
| WLOG discussion | Absent | Present | +5 |
| Extension | Broken cross-ref, no derivation | Full appendix | +10 |
| Alternative explanations | Absent | Present (scope section) | +5 |
| Literature | Gaps | Still gaps (F&P, D&M, B&G) | 0 |
| BP commitment | Not discussed | Mentioned in passing | +3 |
| Overall score | 45 | 62 | +17 |

The manuscript is moving in the right direction. The analytical proof of Lemma 1 is the single most important task remaining.
