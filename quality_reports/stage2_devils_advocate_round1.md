# Stage 2: Devil's Advocate -- formal_model_v5.Rmd (Round 1)
Date: 2026-04-27

## Summary

The paper presents a clean formal model in which unanimity creates a screening mechanism that gives a hegemon higher conditional payoffs than majority rule, while majority's only advantage is wider institutional viability (easier entry). The v5 rewrite has removed Bayesian Persuasion from the main argument, making screening the sole mechanism. The model is well-constructed, the proofs are logically complete, and the institutional comparison is sharp. However, the paper faces vulnerabilities in three areas: (1) the degree to which the binary-type assumption drives the discreteness of the screening advantage, (2) whether the model's stripped-down institutional environment captures enough of the relevant IO landscape to speak credibly to the GATT/WTO, and (3) several scope limitations that are acknowledged but not fully internalized in the paper's framing claims.

## Score Calculation

Starting score: 100

- **V1.** Binary types are doing heavy lifting for the discrete jump (Major: assumptions driving result): -5 | Action: REESCREVER
- **V2.** All-or-nothing entry is a strong assumption that suppresses interesting dynamics (Major: assumptions driving result): -5 | Action: REESCREVER
- **V3.** Alternative explanations insufficiently differentiated (Major: alternative explanations): -10 | Action: ADICIONAR
- **V4.** GATT/WTO application rests on informational asymmetry claim that is asserted rather than demonstrated (Major: generalization beyond scope): -5 | Action: REESCREVER
- **V5.** The Remark on information design (Remark 3) is a vestige of the BP architecture and sits awkwardly in the current paper (Major: section without new contribution): -5 | Action: CORTAR or REESCREVER
- **V6.** Repeated interaction and learning dismissed in two sentences in the Conclusion (Minor: insufficient hedging): -2 | Action: ADICIONAR
- **V7.** Worked example parameters not empirically motivated (Minor: insufficient hedging): -2 | Action: REESCREVER
- **V8.** The Corollary's welfare implication for W is buried in prose rather than stated as a formal result (Minor: weak transitions): -1 | Action: REESCREVER
- **V9.** Appendix C (K>2) is honest but the paper does not fully confront what "most favorable case" means for the paper's claims (Minor: insufficient hedging): -2 | Action: REESCREVER
- **V10.** Transition from Section 5 (Consensus) to Section 6 (Entry) is abrupt (Minor: weak transitions): -1 | Action: REESCREVER

**Score final: 62/100 (raw deductions)**

Recalibrated for a formal theory manuscript targeting JoP (where presentation issues are less penalizing and the key question is whether the mechanism is sound and novel):

| # | Adjusted severity | Adjusted deduction |
|---|-------------------|--------------------|
| V1 | Major (structural concern, partially addressed by Appendix C) | -5 |
| V2 | Major (acknowledged, defensible) | -3 |
| V3 | Major (genuine gap for JoP audience) | -8 |
| V4 | Major (application stretch) | -5 |
| V5 | Major (structural: orphaned content) | -3 |
| V6 | Minor | -2 |
| V7 | Minor | -1 |
| V8 | Minor | -1 |
| V9 | Minor | -2 |
| V10 | Minor | -1 |
| | **Total adjusted** | **-31** |

## Adjusted score: 69/100 -- REPROVADO (below 80 threshold for circulation)

**However**: The "REPROVADO" here reflects the Devil's Advocate posture, not an assessment that the paper is fatally flawed. The mechanism is sound, the proofs are correct, and the contribution is real. The issues are addressable in a revision round. The paper is perhaps 2-3 days of focused work from being ready to circulate (80+) and 1-2 weeks from submission-ready (90+). The binding constraint is V3 (alternative explanations) and V4 (empirical grounding of the WTO application).

---

## Detailed Vulnerabilities

### Major

#### V1. Binary types are doing heavy lifting for the discrete jump

**The concern:** The entire conditional payoff advantage of unanimity hinges on a *discrete* jump at the screening cutoff. This jump exists because the weak proposer faces a binary choice (aggressive vs. conservative offer) that corresponds to the binary type space. With continuous types, the screening problem becomes a continuous optimization, and the jump collapses into a smooth kink. The paper acknowledges this in the Conclusion ("The mechanism depends on a discrete type space") and Appendix C admits that with K types, the "binary model is the most favorable case for the mechanism."

**Why it matters for a JoP referee:** A reviewer will ask: "Is the result about unanimity creating informational rents, or about unanimity creating *discrete* informational rents that happen to be large enough to dominate in this specific parametric structure?" The honest answer is: both. Unanimity creates screening that majority does not, regardless of the type space. But whether the screening advantage is large enough for conditional dominance depends on the discreteness of types. The paper's Theorem 1 (conditional dominance everywhere) is a K=2 result. Appendix C is candid that the analogous threshold may shrink to zero as K grows.

**What a referee would demand:** A clearer statement in the body (not just Appendix C) that the *qualitative* result (unanimity creates screening, majority does not) is general, but the *quantitative* result (unanimity conditionally dominates at every belief) is specific to low K. The current Conclusion paragraph on this is adequate but appears only at the very end.

**Action: REESCREVER** -- Add 2-3 sentences after Theorem 1 or in the Scope section (Section 8.2) explicitly stating: "The conditional dominance result is strongest with binary types. With richer type spaces, unanimity continues to create screening that majority eliminates, but the parametric region of global conditional dominance may narrow. The binary model captures the mechanism most transparently; Appendix C discusses generalization."

---

#### V2. All-or-nothing entry suppresses interesting dynamics

**The concern:** The entry technology assumes all N-1 weak states enter simultaneously or not at all. This eliminates partial membership, coalition formation at the entry stage, and heterogeneous participation decisions. In practice, IOs form through sequential accession (GATT Article XXXIII), and not all states join simultaneously. The paper's footnote 4 defends this as "appropriate when the institution requires broad membership to function," but the WTO's history of staggered accession (original contracting parties 1947, vs. China 2001, Russia 2012) suggests the assumption is at tension with the application.

**Why it matters:** The all-or-nothing assumption is what makes the formation set a simple threshold condition. With heterogeneous entry, the comparison between voting rules would depend on which states enter under each rule, creating richer but more complex dynamics. A referee will ask whether the result survives when entry is sequential or when some weak states can free-ride by not entering.

**What saves the paper:** The assumption is clearly stated, reasonably defended, and the footnote correctly notes that N should be read as the size of the proposed institution. This is a modeling choice, not a logical error. But it should be flagged more prominently in Scope.

**Action: REESCREVER** -- Strengthen the Scope section (Section 8.2) with 1-2 sentences: "The all-or-nothing entry simplification is most natural for negotiations where participation below a critical mass renders the institution non-functional. Sequential accession, where states join at different times with different information, would generate a richer entry game but is beyond the scope of this model."

---

#### V3. Alternative explanations insufficiently differentiated

**The concern:** The Discussion (Section 8.1) engages with GATT/WTO but the Scope section (8.2) does not systematically engage with competing theoretical explanations for why hegemons choose consensus. The Introduction mentions three classes of accounts: (a) informal agenda power (Steinberg 2002, Stone 2011), (b) self-binding/credible commitment (Keohane 1984, Ikenberry 2001), and (c) concealment of power (Steinberg, Gruber). But the paper never systematically shows how its mechanism *differs* from these in terms of observable implications.

The final paragraph of Section 8.1 makes a start: it notes that legitimacy accounts predict uniform consensus effects across issues, while this model predicts cross-issue variation based on informational complexity. This is good. But the differentiation from other rationalist accounts is weaker:

- **Maggi & Morelli (2006)**: Self-enforcing voting. Their account predicts consensus when enforcement is weak. This paper's account predicts consensus when informational asymmetry is large. These are different conditions, but the paper does not explicitly contrast them. It says "self-enforcement accounts... do not generate this dependence on informational asymmetry or bargaining patience" -- good, but this is one sentence in a dense paragraph.

- **Veto as insurance**: The hegemon might prefer unanimity simply because it provides a veto against bad outcomes, not because of informational power. The model rules this out by making the hegemon's bilateral alternative always available (H gets alpha*V(theta) regardless), so the veto is redundant as insurance. But this should be stated explicitly as a scope limitation: the model assumes H's outside option is independent of what the institution does, which rules out the insurance motive.

- **Renegotiation-proofness**: Unanimity makes agreements harder to renegotiate, which benefits whoever prefers the status quo. If the hegemon benefits from the existing arrangement, unanimity locks in gains. This is orthogonal to the informational mechanism but could explain the same stylized fact. Not mentioned.

**Why it matters for JoP:** The Journal of Politics publishes formal models that illuminate real institutions. A referee will expect the paper to demonstrate that its mechanism generates *different* predictions from the leading alternatives. The current engagement is partial.

**Action: ADICIONAR** -- Add a structured paragraph (or table) in Section 8.2 (Scope) that explicitly contrasts the model's observable implications with those of: (1) Maggi & Morelli (self-enforcement), (2) veto-as-insurance, (3) renegotiation-proofness, (4) legitimacy accounts. For each, state what the alternative predicts and how this model differs. This is the single highest-priority revision.

---

#### V4. GATT/WTO application rests on asserted informational asymmetry

**The concern:** The model's key assumption -- that H has private information about V(theta) while W does not -- is mapped to the WTO context via the claim that "major trading powers maintain large permanent delegations with deep sectoral expertise; many developing country delegations operate with far smaller teams" (Section 8.1, para 2). This is plausible but empirically thin. The paper provides no citation for the claim about delegation size asymmetries. More importantly, the nature of the informational asymmetry in the model (knowledge of the *value* of cooperation) may not map cleanly to the WTO context, where informational advantages are about specific tariff effects, legal interpretations, or negotiating positions -- not about whether the overall round is "high value" or "low value."

**Why it matters:** A referee specializing in trade will ask: "What exactly does H know that W doesn't? Is it the aggregate value of a trade round (the model's V(theta)), or something more granular?" If the asymmetry is about specific line items rather than overall value, the binary-type abstraction is harder to defend.

**What saves the paper:** The paper is careful to frame the WTO discussion as "illustrative" and notes that "the model does not claim that the GATT/WTO was designed for this reason." The observable implications paragraph provides testable predictions. This is not overclaiming; it is under-grounding.

**Action: REESCREVER** -- Add 1-2 sentences citing empirical work on capacity asymmetries in the WTO. Possibilities: Busch & Reinhardt (2003, "Developing Countries and GATT/WTO Dispute Settlement") on legal capacity gaps; Jones (2010, "WTO Dispute Settlement") on delegation staffing; or Shaffer (2003, "Defending Interests") on how developing countries lack analytical infrastructure for trade policy modeling. Even one specific citation would ground the asymmetry claim.

---

#### V5. Remark 3 (Information Design) is an orphaned vestige of the BP architecture

**The concern:** Remark 3 (after the Proposition, Section 7) explains why "information design would matter differently under the two voting rules." It argues that unanimity creates non-concavities that BP could exploit, while majority's linearity eliminates BP gains. This is correct and insightful -- but it is a remark about a mechanism (Bayesian Persuasion) that is *not part of the model*. The v5 architecture has removed BP from the formal analysis. The Remark reads as a residual justification for why BP was in previous versions, rather than as a substantive contribution to the current paper.

**Why it matters:** A referee will read this remark and think: "If information design matters so much, why isn't it in the model? And if it's not in the model, why is this remark here?" The remark creates an expectation it does not fulfill. It also makes the paper appear to be hedging -- keeping a foot in the BP door "just in case" a referee asks about it.

**Two defensible positions:**
1. **Keep it as a brief pointer** (2-3 sentences max) in the Discussion/Scope, framed as a "direction for future work" or "complementary channel."
2. **Remove it entirely** and let the screening mechanism stand on its own.

The current placement (as a formal Remark in the main results section) gives it too much prominence for content that is not developed formally.

**Action: CORTAR** (preferred) or **REESCREVER** as 2 sentences in Section 8.2 (Scope). Remove the formal Remark environment. If retained, frame explicitly as: "The non-concavity created by screening is precisely the structure that Bayesian persuasion (Kamenica and Gentzkow 2011) could exploit. This suggests that consensus institutions are more hospitable to information design than majority institutions, a direction for future work."

---

### Minor

#### V6. Repeated interaction and learning dismissed too quickly

The Conclusion mentions "repeated play within an established consensus institution could generate learning that narrows the informational gap" as a future extension. But it does not acknowledge that the static model's predictions are most credible for *new* negotiations (where historical data is uninformative) and least credible for mature institutional relationships where asymmetries have eroded. A JoP referee may ask: "If the WTO has been operating since 1995 (GATT since 1947), hasn't learning already eroded the informational asymmetry?" One sentence in the Scope section would preempt this.

**Action: ADICIONAR** -- Add to Scope: "The mechanism is most relevant for negotiations over new issues or in new institutional settings, where the hegemon's informational advantage has not yet been eroded by repeated interaction and outcome observation."

---

#### V7. Worked example parameters not empirically motivated

Example 1 (Section 5) uses N=5, r=1.5, alpha=0.3, beta=0.9. These are never motivated. For a JoP audience, a brief parenthetical would help: e.g., "r=1.5 implies the high-value state is 50% more valuable than the low-value state, consistent with estimates of welfare gains from ambitious versus modest trade liberalization rounds (e.g., Anderson and van Wincoop 2004 estimate trade cost reductions from liberalization of 30-60%)." Even a single sentence would anchor the illustration.

**Action: REESCREVER** -- Add 1 sentence motivating at least r and alpha.

---

#### V8. The welfare implication for W deserves more prominence

The paper shows (after Corollary 1) that "weak states always prefer majority: V_W(mu, M) > V_W(mu, U) for every mu in (0,1]." This is a significant result -- it means unanimity is never Pareto-improving. The hegemon gains at the expense of weak states. But this is stated in prose within the Corollary discussion, not as a separate formal result or a clearly delineated remark. A reader scanning the paper could miss it.

**Action: REESCREVER** -- Consider elevating this to a separate Remark: "Under the conditions of Theorem 1, weak states strictly prefer majority at every belief. Unanimity redistributes from weak states to the hegemon; it is never Pareto-improving conditional on entry."

---

#### V9. Appendix C's honesty creates a tension with the paper's framing

Appendix C states: "The binary model is therefore the case most favorable to the mechanism." This is laudably honest. But the paper's introduction and conclusion do not fully internalize this limitation. The Introduction says the paper "develop[s] a formal model of institutional design" and establishes "conditions under which a hegemon prefers unanimity." A reader who takes this at face value and then reads Appendix C's caveat may feel misled. The Conclusion does acknowledge the K>2 issue, but the Introduction does not flag it.

**Action: REESCREVER** -- Add a brief qualifier in the Introduction's roadmap paragraph: "The model uses binary types to isolate the mechanism most transparently; Section 9 and Appendix C discuss the extent to which the results generalize."

---

#### V10. Transition from Section 5 to Section 6 is abrupt

Section 5 ends with Example 1 (screening magnitudes) and the screening schematic figure. Section 6 opens with "A weak state enters the institution if its expected bargaining payoff exceeds the entry cost c > 0." There is no bridging sentence connecting the screening result to the entry analysis. A single sentence would help: "Having established that unanimity generates a conditional payoff advantage for the hegemon (Propositions 2-3), I now turn to the entry margin -- the channel through which majority can nonetheless dominate."

**Action: REESCREVER** -- Add 1 bridging sentence at the start of Section 6.

---

## Strengths

1. **Clean mechanism isolation.** The paper does an excellent job of isolating the effect of the voting rule by holding everything else (proposal rights, number of players, discount factors) constant. The comparison is truly apples-to-apples.

2. **Sharp main result.** Theorem 1 is a biconditional (if and only if), which is rare and valuable in formal IR theory. It gives a necessary AND sufficient condition for conditional dominance, with a clean parametric threshold alpha*.

3. **Honest scope conditions.** The paper does not claim universality. The Scope section explicitly states when majority dominates. The alpha* threshold is presented as decreasing in N, with the implication that the mechanism is most powerful in smaller organizations. Appendix C is admirably honest about the "most favorable case" qualification.

4. **Institutional comparison is structurally complete.** The Proposition (classification) exhausts all cases: U dominates on F_U, M dominates on F_M \ F_U, indifference outside F_M. No case is left uncharacterized.

5. **Removal of BP was the right architectural decision.** The v5 paper is more focused and more defensible than v2/v4. The screening mechanism stands on its own without needing the commitment assumption that BP required. This eliminates what was the single biggest vulnerability in prior versions.

6. **The figures are informative.** The screening schematic (TikZ, Figure 1) and the institutional map (Figure 3, the (p,c) plane) are genuinely helpful for understanding the mechanism. The heatmap (Figure 4) maps the full (alpha, mu) space, giving readers a visual sense of robustness.

7. **Proof architecture is modular and clear.** The B.5a decomposition (D = D_base + delta_R2 + delta_R1) is elegant. The additivity argument (two corrections affect independent payoff components) is convincing. The assembly across branches is exhaustive. The necessity step (Step 4) is crisp.

---

## Overall Assessment

**Is this paper ready for submission to JoP?**

Not quite, but close. The mechanism is sound, novel, and well-executed. The paper's main weakness is not internal (the model works) but external: it needs to do more work connecting to the existing landscape of explanations for consensus in IOs (V3), and it needs to ground its informational asymmetry assumption with at least minimal empirical citation (V4). These are both addressable in a short revision.

**Biggest risks a JoP referee would flag:**

1. **"What about Maggi & Morelli?"** -- A referee working on IO institutional design will want to see a clear differentiation from the self-enforcement account, the legitimacy account, and the veto-as-insurance account. The current engagement is too cursory.

2. **"Binary types are doing too much work"** -- The conditional dominance result is a K=2 result. A referee will ask whether the paper claims more generality than it delivers. The answer is: the paper is honest in Appendix C, but the body text does not sufficiently flag this limitation until the Conclusion.

3. **"Is the WTO application serious?"** -- The paper frames itself as speaking to the GATT/WTO. A referee specializing in trade institutions will scrutinize whether the model's stark assumptions (binary types, symmetric proposals, all-or-nothing entry) capture enough of the WTO's complexity to make the application credible. The paper would benefit from either (a) a more grounded empirical paragraph, or (b) a more modest framing of the WTO discussion as purely illustrative.

4. **"Why is Remark 3 here?"** -- The information design remark creates an unfulfilled expectation. Either develop it or remove it.

**Bottom line:** The paper has a publishable idea executed with technical competence. With revisions to V3, V4, V5, and V9, it would be competitive at JoP. The current version would likely receive a "revise and resubmit" rather than a rejection, which is a strong position for a single-authored formal theory paper in IR.
