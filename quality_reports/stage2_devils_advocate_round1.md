# Devil's Advocate Report: formal_model_v2.Rmd

**Date**: 2026-04-20
**Reviewer**: Devil's Advocate (automated, senior IR/Political Economy)
**Manuscript**: "Informational Power and Institutional Design: Why a Hegemon May Choose Consensus"
**File reviewed**: `formal_model_v2.Rmd` (775 lines)

---

## Overall Assessment

The paper presents an original and well-structured argument: unanimity creates a screening problem that majority rule eliminates, and Bayesian Persuasion exploits the resulting non-convexity. The framing is sharp, the writing is above-average for a formal theory paper in IR, and the central mechanism is genuinely novel. The introduction is strong --- the puzzle is well-motivated, the contribution is clearly stated, and the three-layer logic (why not monopoly, why not majority, why unanimity) is persuasive.

However, the paper has significant vulnerabilities. The proof of the main theorem (Theorem 1) contains logical gaps that a careful referee will catch. The comparison between M and U is cleaner than it should be, relying on modeling choices that may rig the result. Several alternative explanations for consensus are not addressed. The GATT/WTO section is more illustrative than probative. And the paper overclaims in places where the formal results do not fully support the verbal argument.

The paper is promising but not yet at the level of a top-5 submission. The issues below are ordered by severity.

---

## Vulnerabilities (by severity)

| # | Severity | Location | Vulnerability | Action | Deduction |
|---|----------|----------|---------------|--------|-----------|
| 1 | CRITICAL | Theorem 1, proof Step 2 | The claim that "majority dominates at high priors" is asserted but not proved. The parenthetical justification ("Proposition 2 works in reverse for E[V_H] overall") is hand-waving and actually contradicts the stated Proposition 2, which says theta=0 gains under U. What is needed is a formal comparison of E_theta[V_H^R1] across rules at high mu, not a vague appeal to a proposition about a different object. The proof does not establish that cav v(p,M) > cav v(p,U) for large p. | REESCREVER | -25 |
| 2 | MAJOR | Theorem 1, proof Step 3 | The "crossover" argument appeals to continuity of concavified value functions. But concavified value functions are not necessarily continuous at the same points, and the existence of a crossover requires more than continuity --- it requires that the two functions actually cross, not merely that one dominates at low p and the other "should" dominate at high p. The proof of Step 2 being incomplete propagates here: without Step 2, Step 3 is vacuous. | REESCREVER | -10 |
| 3 | MAJOR | Section 4 (Majority), Proposition 1 | The WLOG inclusion convention under majority is doing more work than acknowledged. The paper says W "is indifferent between excluding H and including H at reservation value alpha V(theta)." But this relies on H receiving alpha V(theta) bilaterally *regardless* --- i.e., H captures its outside option whether or not included in the deal. This is only true if the outside option is literally a bilateral deal that H can execute unilaterally. If the outside option depends on the institutional context (e.g., if being excluded from the majority coalition affects H's bilateral alternatives), the indifference breaks. The paper treats this as innocuous but it is a substantive assumption that shapes the entire comparison. Under an alternative where exclusion costs H something (e.g., reputation, signaling), the majority payoff to H would be lower, making the unanimity comparison easier. Under an alternative where exclusion benefits H (e.g., hold-up on implementation), majority payoff to H would be higher, making the result harder. The WLOG claim deserves explicit discussion. | REESCREVER | -10 |
| 4 | MAJOR | Section 3 (Institutional Comparison) | The model compares two stylized packages and claims to "isolate the effect of the voting rule." But the packages differ in more than just the voting rule. Under majority, W does not need H's vote, so the *strategic role* of H changes: H goes from pivotal to non-pivotal. This is not merely a feature of the voting rule but a consequence of the specific N and q chosen. For N=3 and q=2, one W plus H is also a winning coalition under majority, so H could still be pivotal under majority. The paper uses general N >= 3 but never discusses this. For the mechanism to work as described, W must be able to form a majority *without* H. This requires q <= N-1, which is true for simple majority and N >= 3, but the paper should state this explicitly. More importantly, a referee could argue that the comparison is "rigged" because it compares a rule where H is always pivotal (U) with one where H is never pivotal (M), and the result is a mechanical consequence of pivotality, not of voting rule *per se*. | REESCREVER | -5 |
| 5 | MAJOR | Missing literature | The paper does not cite Feddersen & Pesendorfer (1998, "Convicting the Innocent") or their broader work on information aggregation under different voting rules. Their central result --- that unanimity is the worst voting rule for aggregating information --- is directly relevant and potentially contradictory. The paper also misses Austen-Smith & Banks (1996) on strategic information transmission in committees, Coughlan (2000) on unanimous jury decisions, and Duggan & Martinelli (2001) on Bayesian persuasion in committees. In the IO literature, the paper should cite Downs, Rocke & Barsoom (1998) on the number and size of IOs, and possibly Thompson (2015) on veto power in IOs. The Bayesian Persuasion applied to voting literature (Alonso & Camara 2016 is cited but Bardhi & Guo 2018, Arieli & Babichenko 2019 on multi-receiver BP are missing). | ADICIONAR | -5 |
| 6 | MAJOR | Section 7 (Entry and BP) | Lemma 1 ("Entry is weakly easier under consensus") is poorly stated. It says V_W(mu,U) >= V_W(mu,M) "need not hold for all mu" and then says "the screening channel under unanimity creates an additional persuasion opportunity regardless of the relative ordering of entry thresholds." This is not a lemma --- it is an admission that the entry comparison is ambiguous. A lemma should state a precise claim. As written, it provides no formal content and could be deleted without loss. The paragraph following it asserts that unanimity has "two sources of non-convexity" (entry + screening) while majority has one (entry only). This is the real claim and it does not require the pseudo-lemma. | CORTAR | -5 |
| 7 | MAJOR | Section 10 (GATT/WTO) | The empirical illustration is superficial. It asserts that informational asymmetries exist in trade negotiations (plausible but documented only by assertion, not by citation of specific evidence), that consensus persists (true), and that the model's mechanism "explains" this. But the section does not engage with the most obvious counter: the GATT/WTO has informal agenda control by major powers (Green Room), which the model specifically excludes from the baseline. The paper acknowledges this and points to the extension, but the extension itself is only sketched (Section 9 is one page with a remark and no formal result). A referee will view the GATT/WTO section as window-dressing for a theory paper that cannot actually speak to this case without the extension being worked out. | REESCREVER | -5 |
| 8 | MAJOR | Alternative explanations not considered | The paper does not discuss at least three prominent alternative explanations for consensus in IOs: (i) *Legitimacy and compliance*: consensus enhances compliance because states that consent are more likely to implement (Franck 1990, Chayes & Chayes 1995). The hegemon may prefer consensus because it produces more durable agreements. (ii) *Issue linkage*: consensus may be optimal when the IO covers multiple issue areas and states have heterogeneous preferences across issues, enabling package deals that majority cannot sustain (Davis 2004). (iii) *Repeated game dynamics*: in a repeated setting, majority rule creates losers who may exit or retaliate, while consensus avoids this (Maggi & Morelli 2006 is cited but their repeated-game logic is not discussed). The paper needs at least a paragraph acknowledging these alternatives and explaining why the informational mechanism is distinct from and potentially complementary to them. | ADICIONAR | -10 |
| 9 | MODERATE | Proposition 3 (R1 cutoff) | The closed-form expression for mu_s^R1 is given only for the "principal case" where mu_s^R1 > mu_s^R2 (alpha < alpha_bar). The paper says this holds "throughout the empirically relevant parameter range" but does not define alpha_bar explicitly or prove this claim. What happens in the other case? Is there still a screening cutoff? If so, does it depend on alpha? The incompleteness here means the proposition is conditional on an unverified condition. | REESCREVER | -2 |
| 10 | MODERATE | Proposition 4 (Non-convexity) | The proof says "the concave envelope must therefore lie strictly above v(mu, U) in a neighborhood of mu_s^R1." This is correct *if* the jump is upward (which Proposition 4 establishes) and the function is not already concave from some other source. But the proof does not verify that v(mu, U) is concave on each side of the jump. If v is convex on the left of the jump, the concave envelope might not exploit the jump in the way claimed. The proof needs a sentence establishing that v is concave (or at least non-decreasing) on each branch. | REESCREVER | -2 |
| 11 | MODERATE | Section 9 (Extension) | The extension on partial agenda influence contains no formal result --- only a remark. The claim about "non-monotonic interaction" is stated without proof, without conditions, and without a figure. The reference to "Appendix E" is broken: there is no Appendix E in the paper. This section creates an expectation it does not fulfill. Either formalize it or flag it honestly as a conjecture. | REESCREVER | -5 |
| 12 | MODERATE | Model, Section 4 | The Bayesian Persuasion commitment assumption is acknowledged in scope conditions (Section 11) but never seriously interrogated. The commitment assumption is strong in the IO context: it requires the hegemon to commit to a signal structure *before* observing theta. In practice, the hegemon observes theta and then decides what to say. This is cheap talk, not BP. The paper should discuss why commitment is a reasonable approximation (e.g., reputation, institutional rules requiring disclosure) or at least note that the results provide an upper bound on informational power. Without this, the mechanism may appear implausible to an IR audience. | ADICIONAR | -2 |
| 13 | MINOR | Numerical figure (Figure 1) | The concavification algorithm uses the convex hull, which is a rough approximation. More importantly, the figure uses a single parameter vector (N=5, r=1.5, alpha=0.3, beta=0.9, c=0.1) without sensitivity analysis in the figure itself. The parameter region plots (Figure 2) help, but Figure 1 would benefit from showing how the mechanism degrades as parameters approach the boundary of the unanimity-preferred region. | REESCREVER | -1 |
| 14 | MINOR | Abstract and Introduction | The paper claims the model "shows conditions under which the hegemon strictly prefers unanimity despite extracting less conditional on agreement." The phrase "despite extracting less" is hedging-as-framing: it makes the result sound more surprising than it is. The hegemon extracts less *per agreement* but the persuasion channel creates *more agreements* (or better-positioned agreements). This is just standard trade-off logic. Overstating the paradox weakens credibility. | REESCREVER | -2 |
| 15 | MINOR | Corollary 2 | "Consensus is most valuable when informational power substitutes for agenda power" is a restatement of the paper's thesis, not a formal result. The corollary says $S_U > S_M$ is "more likely to hold" when r is large, beta is large, and N is moderate. "More likely" is imprecise for a formal paper. Either prove comparative statics on the condition or label this a remark. | REESCREVER | -2 |
| 16 | MINOR | Scope conditions, Section 11 | The paper lists five conditions for the mechanism but does not discuss one that is crucial: the model assumes *symmetric* weak states. If weak states are heterogeneous (e.g., some are medium powers with positive outside options), the screening problem under unanimity changes qualitatively --- the proposer faces a multi-dimensional screening problem, and the clean cutoff may not survive. This is acknowledged as a "future paper" but should be flagged as a scope limitation here. | ADICIONAR | -2 |
| 17 | MINOR | Throughout | The paper oscillates between "consensus" and "unanimity" without always being precise. In practice, consensus in the WTO is not formal unanimity (any member can call a vote). The paper should note once, early, that it models *formal unanimity* as a proxy for consensus and that the gap between the two is itself interesting but outside the model's scope. | REESCREVER | -1 |
| 18 | MINOR | Appendix B, Proof B.5 | The proof of Theorem 1 in the appendix says "See the proof in Section 8." This is not a proof --- it is a cross-reference. If the appendix exists to collect proofs, the proof should be here, not deferred back to the body. | REESCREVER | -1 |

---

## Detailed Discussion of Key Vulnerabilities

### Is the M vs U comparison fair? (#3, #4)

The comparison is designed to be clean --- same proposal rights, same players, only the voting rule differs. But "clean" and "fair" are not the same. Three features of the design stack the deck:

1. **The WLOG inclusion convention** (V3 above). Under majority, W includes H "by convention." This means H always gets alpha V(theta) --- its type-specific outside option. But this is a modeling *choice*, not a deduction. If W excludes H, H captures alpha V(theta) bilaterally. If W includes H, W offers alpha V(theta) and H gets the same. The convention is payoff-equivalent *only* because the outside option is a certainty for H. If there were any friction in executing the bilateral alternative (delay, uncertainty, transaction costs), the inclusion convention would matter. The paper should acknowledge this.

2. **No screening under majority is a consequence of non-pivotality** (V4). The mechanism works because H is pivotal under U and not under M. But a referee could argue this is *definitional*: unanimity = everyone pivotal, majority = not everyone pivotal. The paper needs to explain why this is a non-trivial observation rather than a restatement of the definition.

3. **The two-type, two-offer structure** makes screening binary (aggressive vs conservative). With more types or a continuous type space, the screening problem under unanimity would be richer but the clean "jump" in the value function might disappear (replaced by a kink or smooth non-convexity). The binary structure is not wrong but it is the most favorable case for the mechanism.

### Is the screening mechanism novel? (#4, #5)

The screening-under-unanimity mechanism is genuinely novel in the IO/institutional design literature. But a theorist familiar with mechanism design will recognize it as a standard take-it-or-leave-it offer under incomplete information, which is the textbook screening problem (Mas-Colell, Whinston & Green Ch. 13). The paper's contribution is not the screening problem itself but the *institutional comparative static*: the same bargaining game generates screening under one rule and not the other. This distinction should be stated more forcefully. Currently, the paper sometimes implies that screening under unanimity is itself the novelty, when the real novelty is the link between voting rules and the *existence* of screening.

### Is the proof of Theorem 1 rigorous? (#1, #2)

No. Step 2 is the weakest point. The paper needs to show that for sufficiently high priors, the hegemon's payoff under majority exceeds that under unanimity. The current "proof" says this follows from Proposition 2, but Proposition 2 is about overpayment of theta=0 under unanimity --- which *helps* H, not hurts it. The verbal logic ("per-round extraction is lower") is plausible but not formalized. To fix this, the paper needs to:

(a) Derive E_theta[V_H^R1(theta, mu, U)] and E_theta[V_H^R1(theta, mu, M)] in closed form for mu above the screening cutoff.
(b) Show that the majority expression exceeds the unanimity expression for mu near 1.
(c) Then invoke continuity for the crossover.

Without (a)-(b), the theorem is a conjecture supported by numerics, not a proved result.

### Alternative explanations for consensus (#8)

The paper positions itself against a single straw man: "consensus is a constraint on power." But the literature offers several alternative *rationalist* explanations for why a hegemon might prefer consensus:

- **Self-enforcing agreements** (Maggi & Morelli 2006): consensus is preferred when enforcement is weak because it ensures broader buy-in.
- **Legitimacy** (Steinberg 2002, Voeten 2005): consensus provides a legitimacy premium that makes agreements more durable.
- **Risk aversion and uncertainty** (Koremenos et al. 2001): under uncertainty about future power shifts, consensus protects the hegemon against future adverse coalitions.
- **Complexity and issue linkage** (Davis 2004): in complex negotiations, consensus allows for package deals that majority voting fragments.

The paper does not need to model each of these, but it should acknowledge them and explain how the informational mechanism is distinct. Currently, the introduction mentions only the "informal agenda power" response and dismisses it. This is cherry-picking the weakest alternative.

---

## Score

Starting at 100:

| # | Deduction | Running total |
|---|-----------|---------------|
| 1 | -25 (Conclusion not supported: Theorem 1 Step 2 unproved) | 75 |
| 2 | -10 (Crossover argument depends on unproved step) | 65 |
| 3 | -10 (WLOG convention doing substantive work, not discussed) | 55 |
| 4 | -5 (Generalization: "isolating the voting rule" overclaimed) | 50 |
| 5 | -5 (Literature: information aggregation under voting rules) | 45 |
| 6 | -5 (Lemma 1 is empty; section without contribution) | 40 |
| 7 | -5 (GATT/WTO section superficial) | 35 |
| 8 | -10 (Alternative explanations not considered) | 25 |
| 9 | -2 (Proposition 3 conditioned on unverified alpha_bar) | 23 |
| 10 | -2 (Proposition 4 proof gap on concavity of branches) | 21 |
| 11 | -5 (Extension section: no formal result, broken cross-ref) | 16 |
| 12 | -2 (BP commitment assumption not interrogated) | 14 |
| 13 | -1 (Figure sensitivity) | 13 |
| 14 | -2 (Overstating the paradox in framing) | 11 |
| 15 | -2 (Corollary 2 imprecise, not a formal result) | 9 |
| 16 | -2 (Symmetric weak states scope limitation unstated) | 7 |
| 17 | -1 (Consensus vs unanimity imprecision) | 6 |
| 18 | -1 (Appendix B.5 is a cross-reference, not a proof) | 5 |

**Raw score: 5/100**

### Adjusted score

The raw rubric mechanically accumulates deductions and produces a score that is too harsh for a paper whose core mechanism is sound and genuinely novel. The score of 5 reflects applying the rubric literally, where the critical Theorem 1 gap (-25) and the cascading effects of that gap (-10 from V2, -10 from V3) account for most of the damage. Several of the other deductions penalize incompleteness rather than error.

A fairer assessment: the *mechanism* (screening under unanimity, no screening under majority, BP exploits the resulting non-convexity) is correct, well-motivated, and appears robust in numerics. The *formal apparatus* around the mechanism (Theorem 1 proof, Lemma 1, extension) needs substantial work. The *contextualization* (alternative explanations, literature, GATT/WTO) needs a serious pass.

**Adjusted score: 45/100** -- Not ready for circulation. The mechanism is publishable but the formal results and contextualization need significant revision.

---

## Verdict

**BLOCK.** The paper cannot be circulated in its current state. The main theorem's proof has a gap that undermines the central claim. The following must be addressed before the next stage:

### Blocking issues (must fix)
1. **Prove Theorem 1 Step 2 formally.** Derive closed-form expressions for E[V_H] under both rules at high mu and show majority dominates. This is the paper's central result and it must be airtight.
2. **Fix or remove Lemma 1.** Either state a precise claim about entry thresholds or delete the lemma and make the non-convexity argument directly.
3. **Fix the extension section.** Either formalize the partial agenda influence result (at least a proposition with a proof sketch) or remove the section and flag it as future work in the conclusion. Fix the broken Appendix E reference.

### High-priority improvements (should fix before submission)
4. **Add a paragraph on alternative explanations** for consensus (legitimacy, self-enforcement, issue linkage, risk aversion). Explain how the informational mechanism is distinct.
5. **Cite the information aggregation literature** (Feddersen & Pesendorfer 1998, Austen-Smith & Banks 1996). Explain why information aggregation (voters learning from each other) is different from information design (one player shaping others' beliefs).
6. **Discuss the WLOG inclusion convention** explicitly. Acknowledge it is a modeling choice and explain why it does not drive the result.
7. **Discuss the BP commitment assumption** in the model section, not only in scope conditions.

### Desirable improvements (can wait for R&R)
8. Explicit alpha_bar for Proposition 3.
9. Concavity verification for Proposition 4.
10. Sensitivity analysis in Figure 1.
11. Precise consensus vs unanimity distinction.
12. Symmetric weak states as scope condition.
