# Parecer de Exposicao (Varian / Thomson / Board)

**Paper**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Version**: v4 (`formal_model_v4.Rmd`)
**Reviewer framework**: Varian 1997 / Thomson 1999 / Board & Meyer-ter-Vehn 2018
**Date**: 2026-04-26
**Special focus**: Would the exposition improve if BP were removed from the body?

---

## Score: 7.5 / 10

A well-organized paper with a genuinely novel mechanism and clean formal results. The main liability is narrative overload: two co-equal mechanisms (screening + BP) compete for the reader's attention when one (screening) does the heavy lifting, and the other (BP) introduces costly assumptions without proportionate payoff in the paper's own examples. The writing is generally strong at the sentence level, with some lapses in economy and a few passages that could be more direct.

---

## Avaliacao por dimensao

### ME1. Estrutura do paper: Adequada

**Strengths.** The paper follows a logical progression: motivating example (Sec 2) -> model (Sec 3) -> majority (Sec 4) -> unanimity (Sec 5) -> entry and BP (Sec 6) -> main result (Sec 7) -> discussion (Sec 8) -> conclusion (Sec 9). The main result (Theorem 1, Theorem 2) appears in Section 7 around pp. 13-14, which is acceptable for a paper of this length. The separation of bargaining derivations (Appendix A) from proofs (Appendix B) is clean. The notation table in Appendix A is helpful.

**Weaknesses.**

1. **The main result arrives late relative to its importance.** Sections 4 and 5 are necessary but feel extended. The reader traverses ~5 pages of bargaining mechanics before reaching the institutional comparison. A more aggressive structure would state the Lemma 1 result (conditional dominance) *before* deriving the screening cutoff in full, so the reader knows where the algebra is going.

2. **Section 6 (Entry and BP) is structurally awkward.** It serves three functions: (a) defining the net gain function, (b) introducing the entry threshold, and (c) explaining the Bayesian persuasion logic. These are conceptually distinct. The BP material---concavification, the formula Pi_H* = alpha*V_e(p) + cav v(p,R)---arrives just before the main result but is never quantitatively deployed in the paper's own examples (BP amplification = 0 in Example 2, as the decision note reveals). This creates a structural promise the paper does not fulfill.

3. **The Discussion section (Sec 8) bundles GATT/WTO, scope conditions, and parameter robustness.** These are three different audiences. The GATT/WTO material (8.1) is substantive IR; the scope conditions (8.2) are defensive technical commentary; the heatmap (Fig. 4 in 8.2) is a numerical exercise. A tighter structure would separate the GATT application from the technical scope discussion.

4. **Appendix B.5a (Derivation of the payoff decomposition) is remarkably long (~100 lines) for a derivation appendix.** It is well written and pedagogically valuable, but its five-step structure with narrative connectors reads more like a body section than an appendix. This is either the paper's most important proof (in which case it should be highlighted) or an intermediate derivation (in which case it should be compressed). Currently it sits in limbo.

**Rating: Adequada.** The structure works, but the late arrival of the main result and the structural mismatch between the BP narrative and its quantitative role are noticeable.

---

### ME2. Introducao: Adequada (approaching Excelente)

**Strengths.**

1. **The puzzle is stated cleanly in the first paragraph** (ll. 49-51): "Why would a powerful state ever prefer consensus over majority rule?" This is exactly the right opening for JoP.

2. **The literature positioning is efficient** (ll. 52-54): existing answers are sorted into two camps (informal agenda power vs. self-binding), and both are shown to be incomplete. The gap---"neither explains when and why a hegemon would prefer unanimity to a rule that allows exclusion"---is precise.

3. **The mechanism preview (ll. 56-58) is well-calibrated**: screening under unanimity, linearity under majority, entry threshold as the boundary.

4. **The substantive implication paragraph (ll. 59-60) is the strongest in the intro**: "consensus is most valuable to a hegemon when the prospects of multilateral cooperation are promising enough." This is a sentence a political scientist can remember.

**Weaknesses.**

1. **The BP sentence in the intro is doing too much work for too little return** (ll. 55-56): "Using Bayesian persuasion [@kamenica2019bayesian], I show that consensus can make informational power more politically productive than the coalition arithmetic of majority rule." This sentence makes BP the *method* by which the claim is established, but the claim is actually established by Lemma 1 (conditional dominance) which requires no BP at all. BP's role is to extend the conditional result to priors below the entry threshold---a secondary contribution. Leading with "Using Bayesian persuasion" front-loads the costliest assumption and the most complex machinery.

2. **The citation cluster in ll. 55 is dense but shallow**: Bardhi & Guo (2018) and Kim et al. (2025) are mentioned in a single sentence. The coarse review (CR5) already flagged this. For JoP, at least 2-3 sentences distinguishing the paper from these two closely related BP-in-bargaining models would strengthen the positioning.

3. **The roadmap paragraph (ll. 61-62) is conventional but could be cut entirely** without loss. It does not carry information beyond what the section headings provide.

**Rating: Adequada (approaching Excelente).** The first four paragraphs are strong. The fifth (roadmap) is filler. The biggest issue is the BP framing in the mechanism description.

---

### ME3. Escrita e estilo: Adequado

**Strengths.**

1. **Sentences are generally short and clear.** The paper avoids the multi-clause constructions that plague formal theory writing.
2. **No sentence starts with a symbol** (verified across the full text).
3. **Consistent voice throughout.** The paper uses first person singular ("I show") in appropriate places and impersonal constructions elsewhere.
4. **Appendix B.5a is a model of proof exposition.** Each step opens with a narrative sentence explaining what the step does and why before presenting the algebra. This is exactly what Thomson (1999) recommends.

**Weaknesses.**

1. **Repetition of the "majority is linear" point.** Despite earlier editing to reduce restatements, the paper still says this in: Proposition 1 statement (l. 278), Proposition 1 interpretation (l. 286), Definition 2 context (l. 411), Proposition 4 (l. 414), the proof of Theorem 1 (l. 538), and the Conclusion (l. 795). This is a central result and deserves emphasis, but six restatements risk numbing the reader. Three would suffice: at first appearance, when contrasted with unanimity's non-convexity, and in the conclusion.

2. **The following passage is too dense** (ll. 420-421):

   > "By the standard Bayesian persuasion result [@kamenica2011bayesian], the hegemon's optimal payoff under rule R is Pi_H*(R,p) = alpha*V_e(p) + cav v(p,R): the outside option plus the concavified net gain from the institution."

   This is technically correct but assumes the reader knows what "concavified" means. For JoP, a one-sentence intuitive explanation of concavification should precede or follow this formula. Something like: "The concave envelope of a function gives the highest payoff achievable by publicly mixing over posteriors---in this context, by designing a signal that induces weak states to sometimes believe cooperation is more valuable than the prior suggests."

3. **The Discussion section (8.1, GATT/WTO) has some hedging that weakens the prose** (l. 685): "The model does not claim that the GATT/WTO was designed for this reason, or that all aspects of WTO politics reduce to this mechanism." This kind of defensive qualification is appropriate in a referee response but reads as underconfident in a published paper. The model speaks for itself; the reader can assess its scope.

4. **Footnote density.** The paper has substantial footnotes in Sections 3 and 6 (e.g., the all-or-nothing entry footnote in l. 106, the c-scaling footnote in l. 400, the E_U disconnected footnote in l. 932). Several of these are effectively micro-appendices. Consider moving them to the appendix or integrating the essential point into the text.

5. **"Informational rent" vs. "screening rent" vs. "overpayment."** These three terms are used somewhat interchangeably to refer to the same phenomenon (the jump at mu_s^R1). "Screening rent" appears in the TikZ figure (l. 365), "informational rent" in Proposition 3's title (l. 313), and "overpayment" in the motivating example (l. 76) and the jump interpretation (l. 324). Picking one term and using it consistently would sharpen the exposition.

**Rating: Adequado.** Clean sentence-level writing, some unnecessary repetition, and a few passages that need a JoP reader's perspective rather than a theory workshop perspective.

---

### ME4. Extensao e quando parar: Adequado

**Strengths.**

1. The body is compact: approximately 14-15 pages of text before appendices. For a formal theory paper at JoP, this is well-calibrated.
2. The appendix structure (A: derivations, B: proofs, C: extension) is organized and navigable.

**Weaknesses.**

1. **Appendix B.5a (Derivation of the payoff decomposition) is ~100 lines of detailed algebra with narrative.** It is excellent as a standalone proof document, but for a paper appendix it may be too expansive. Consider compressing Steps 0-1 (the setup and benchmark) and preserving the full treatment only for Steps 2-5 (the corrections and assembly).

2. **Appendix C (K>2 extension) is in an awkward position.** It is labeled a "Proposition" but the paper itself says the result is not fully established for K >= 3 (l. 1193). The coarse review (CR2) flagged this as raising "more concerns than it resolves." Either promote it to a rigorous extension (with a proved result) or demote it to a brief discussion paragraph. In its current form, it occupies ~1.5 pages without delivering a crisp conclusion.

3. **The conclusion is economical (good) but does not sufficiently highlight the screening-only contribution.** The first paragraph of the conclusion (l. 795) mentions both screening and BP as co-equal mechanisms. If the author decides to subordinate BP, the conclusion should reflect this hierarchy.

**Rating: Adequado.** The paper knows approximately when to stop in the body but could tighten the appendices.

---

### ME5. Uso de exemplos e intuicao: Excelente

**Strengths.**

1. **The motivating example (Section 2) is the paper's strongest expository asset.** It previews the full mechanism (screening cutoff, jump, BP exploitation) in a concrete N=3 setting with specific numbers. The aggressive/conservative comparison is vivid. The arithmetic is simple enough that a reader can check it mentally.

2. **Example 1 (l. 393) provides concrete magnitudes** for the screening jump---5.3% of expected surplus, 27% and 41% more than majority on the two branches. These numbers make the mechanism tangible.

3. **Example 2 (l. 560) walks through the full institutional comparison** with p* = 0.12, the entry gap, and the transition from majority-preferred to unanimity-preferred. This is exactly what the coarse review (CR7) requested.

4. **The schematic TikZ figure (Fig. 3, l. 326)** is well-designed: it shows both the majority line and the unanimity piecewise function with the jump and BP shading, all on the same axes. A reader who understands only this figure understands the core mechanism.

5. **Remark 1 (l. 512)** translates the alpha >= alpha* case into substantive language: the mechanism "fails only near certainty about the magnitude of the gains from cooperation---precisely where private information has least value." This is excellent intuition.

**Weaknesses.**

1. **The motivating example includes BP but the general model's own Example 2 has BP amplification = 0.** This creates a subtle incoherence: the simplified example showcases a mechanism (BP exploitation of the jump) that turns out to be quantitatively absent in the paper's primary worked example. A reader who notices this---and a careful referee will---may question whether the BP narrative is doing real work or is primarily a framing device.

2. **No example illustrates when BP amplification is strictly positive in the general model.** The paper could strengthen the BP case by including a parameterization (perhaps in a footnote) where the screening jump falls inside E_U and BP amplification is nonzero.

**Rating: Excelente.** The examples are the paper's crown jewel. The motivating example alone would make the paper accessible to a JoP audience. The only significant gap is the absence of an example where BP does quantitative work in the full model.

---

## Would exposition improve WITHOUT BP?

This is the central question the author is weighing (see `notes/2026-04-26_bp_vs_screening_decisao.md`). My assessment follows.

### What BP currently does for the paper's exposition

1. **Extends the result from E_U to (p*, 1]**: BP allows the hegemon to induce entry at priors below tau(U). Without BP, the result is: "conditional on entry, H prefers unanimity" (Lemma 1). With BP: "H prefers unanimity for all p > p*" (Theorem 2). The extension is real but incremental---it widens the prior range but does not change the institutional logic.

2. **Provides the beautiful asymmetry**: majority's linearity means cav v(p, M) = v(p, M) on E_M, so BP is useless under majority for the conditional payoff. This is a clean structural contrast. But it is a contrast about *information design*, not about *institutional design*---and the paper's audience cares about institutions.

3. **Connects to the Kamenica-Gentzkow literature**: BP signals that the paper lives at the intersection of information design and political economy, which positions it for AJPS/JET. For JoP, this signaling may be counterproductive---it signals formalism over substance.

### What BP currently costs the paper's exposition

1. **The commitment assumption** (Section 8.2, ll. 699): The three defenses (reputation, WTO rules, upper bound) are thin, as the coarse review (CR3) noted. This is a permanent vulnerability in the paper's argumentation. Screening requires *no* assumption about the hegemon's ability to commit to an information structure.

2. **The concavification machinery** (Section 6, ll. 413-421): For a JoP reader, the passage explaining concavification is the most technically demanding in the body. It requires familiarity with the Kamenica-Gentzkow framework. Removing BP would eliminate this barrier entirely.

3. **The narrative is split**: The paper tries to tell two stories simultaneously---"screening creates a conditional advantage" and "BP amplifies that advantage and extends it beyond the entry set." This dual narrative means the reader must track two distinct mechanisms, their interaction, and which mechanism dominates when. The decision note reveals that BP amplification = 0 in the paper's own Example 2. The narrative weight given to BP is therefore disproportionate to its quantitative contribution.

4. **Sections that would simplify without BP**:
   - **Section 2 (Motivating example)**: The BP paragraph (ll. 78-80) could be removed. The example would end at the screening jump---a cleaner stopping point.
   - **Section 3 (Model)**: Stage 1 currently includes "the hegemon commits to a public signal structure pi" (l. 106). Without BP, Stage 1 becomes: Nature draws theta, H observes it, W's observe nothing, entry decisions. The game tree (Fig. 1) simplifies.
   - **Section 6 (Entry and BP)**: Would become "Section 6: Entry and Institutional Choice." The net-gain definition and entry thresholds remain. The concavification paragraph and Fig. 4 (net-gain functions with concavifications) would move to an appendix extension or be removed.
   - **Section 7 (Institutional Choice)**: Theorem 1 would simplify to: "For all p in E_U, H strictly prefers unanimity." Theorem 2 would simplify to: "The set of priors favoring unanimity contains E_U and the ranking has a single-crossing structure driven by entry." The formula Pi_H* = alpha*V_e(p) + cav v(p,R) would be replaced by the direct comparison of V_H values.
   - **Section 8 (Scope)**: The commitment defense paragraph (ll. 699) would be unnecessary.
   - **Conclusion**: The reference to "Bayesian persuasion extends this advantage" (l. 796) would be replaced by a discussion of entry as the only channel favoring majority.

5. **Title**: "Informational Power and Institutional Design" is accurate with or without BP. No title change needed.

### Assessment

**Option B (BP subordinate to screening) is the strongest exposition choice.** Here is why.

- **Option A (remove BP entirely)** sacrifices the real insight that majority's linearity makes information design useless under majority. This structural contrast is genuinely interesting and should remain in the paper---but as a *corollary* or *remark*, not as a co-protagonist.

- **Option C (keep as is)** leaves the narrative overloaded. The current paper asks the reader to absorb screening, entry, BP, concavification, and the interaction of all three. For a JoP audience, this is too much.

- **Option B** would:
  1. Make the body about screening (Lemma 1, Theorem 1 restricted to E_U).
  2. Add a brief section (1-2 paragraphs) noting that BP can extend the result beyond E_U, with the formula and the majority-linearity contrast.
  3. Move the full BP analysis (concavification, Theorem 2 in its current form, Fig. 4) to an appendix.
  4. Eliminate the commitment defense from the scope conditions.

The body would then have a single, clean narrative: "unanimity creates screening; screening gives H a conditional advantage; the only reason H might prefer majority is if unanimity prevents entry." This is a complete story. BP is the cherry on top, available in the appendix for the technically interested reader.

### Specific passage-level suggestions for Option B

- **Abstract**: Replace "can further exploit this asymmetry by shaping what weaker states learn" with: "This conditional advantage implies that, once cooperation is promising enough for weaker states to participate, the hegemon strictly prefers unanimity."
- **Intro, l. 55**: Replace "Using Bayesian persuasion, I show that..." with: "I show that unanimity amplifies the hegemon's informational advantage through a screening mechanism."
- **Section 6**: Rename to "Entry and Institutional Choice." Define the net gain function, state that tau(U) >= tau(M), and proceed to the institutional comparison. Add a Remark: "If the hegemon can also design a public signal (Bayesian persuasion), the unanimity advantage extends to priors below tau(U), because the screening jump creates a non-convexity exploitable by information design. Under majority, the conditional payoff is linear, so information design adds nothing on the entry set. The full analysis appears in Appendix D."
- **Section 7**: State Theorem 1 (dominance on E_U) as the main result. State the single-crossing result as a corollary or second theorem, noting that BP widens the domain but does not change the ranking.

---

## Veredicto geral sobre exposicao

The paper is well written at the sentence and paragraph level, with a genuinely innovative mechanism and strong use of worked examples. Its main expository liability is the dual narrative of screening + BP, which distributes the reader's attention across two mechanisms when one does the substantive work and the other introduces costly assumptions. The structure is sound but could be tightened: the main result arrives somewhat late, the Discussion bundles heterogeneous material, and some appendices are overly expansive.

For a JoP submission, the paper would benefit most from subordinating BP to screening in the body, strengthening the engagement with Bardhi & Guo and Kim et al., and compressing the Discussion. These changes would sharpen the narrative from "screening + BP create dual exploitation" to "screening under unanimity is the institutional technology of informational power; BP is one way to extend it." The first story is simpler, more robust, and more memorable.

---

## Top 5 sugestoes de melhoria

### 1. Subordinate BP to screening in the body narrative (Option B)

**Impact**: High. This is the single most consequential editorial choice.

**Current problem**: The paper treats screening and BP as co-equal mechanisms, but the paper's own Example 2 has BP amplification = 0. The commitment assumption draws fire (coarse review CR3). The concavification machinery (Section 6, ll. 413-421) is the most technically demanding passage for JoP readers.

**Concrete suggestion**: Restructure Section 6. The body tells the screening story (Lemma 1 as the anchor). A new Remark in Section 6 or 7 notes: "If the hegemon can also commit to a public signal, the unanimity advantage extends beyond E_U via concavification of the net-gain function. Because majority's conditional payoff is affine, information design adds nothing on the entry set. See Appendix D." Move the full BP analysis, Figure 4, and Theorem 2 (in its current extended form) to an appendix. Remove the commitment defense from Section 8.2.

### 2. Add an example where BP amplification is strictly positive

**Impact**: High (if BP is kept as co-protagonist) or Medium (if BP is subordinated).

**Current problem**: The motivating example (Section 2) shows BP exploitation in a simplified model, but Example 2 in the general model has zero BP amplification. No parameterization in the paper demonstrates nonzero BP amplification in the full model. This undermines the paper's claim that BP does material work.

**Concrete suggestion**: If the author retains any BP content in the body, include a footnote or brief example with parameters from the decision note's Table (e.g., r=1.5, c=0.12, beta=0.9, N=5, alpha=0.3) where the screening jump falls inside E_U and BP amplification is nonzero. Report the magnitude and compare with the screening-only advantage.

### 3. Expand the differentiation from Bardhi & Guo (2018) and Kim et al. (2025)

**Impact**: High for referee management.

**Current problem**: Both papers are dispatched in a single sentence (l. 55). A JoP referee working on BP in political settings will want to know exactly what structural feature of this model produces the screening jump that is absent in theirs.

**Concrete suggestion**: Add 2-3 sentences after the current citation: "Bardhi and Guo (2018) study optimal information design under unanimity but with a fixed set of receivers---there is no entry stage, no legislative bargaining, and no outside option that scales with the state. Kim, Kim, and Van Weelden (2025) analyze Bayesian persuasion in bilateral veto bargaining, but the bilateral structure eliminates the possibility of exclusion, which is what makes majority a genuine alternative. The present model's contribution is the *institutional comparison* between two voting rules, where the screening mechanism under unanimity and the exclusion mechanism under majority interact with entry to produce a single-crossing structure."

### 4. Unify terminology: pick one term for the hegemon's advantage at the screening cutoff

**Impact**: Medium. Reduces cognitive load.

**Current problem**: The paper uses "informational rent" (Proposition 3 title), "screening rent" (TikZ figure annotation), and "overpayment" (motivating example, Section 5 discussion) to describe the same phenomenon.

**Concrete suggestion**: Use "screening rent" throughout the body. Reserve "overpayment" for the specific mechanism by which it arises (the low type receiving more than its reservation value). Drop "informational rent" from Proposition 3's title; rename it "Screening creates a discrete rent."

### 5. Compress the Discussion section (Sec 8) and separate GATT/WTO from technical scope

**Impact**: Medium. Improves readability and pacing.

**Current problem**: Section 8 bundles the GATT/WTO application (8.1), technical scope conditions (8.2), and a large heatmap figure. These serve different audiences. The GATT discussion (ll. 677-689) includes both the application and observable implications, but also a lengthy footnote on Appendix C and a paragraph on PTAs/Bhagwati that could be tightened. The scope conditions section includes the commitment defense (which would disappear under Option B), the alpha* discussion, and the heatmap.

**Concrete suggestion**: Split into three shorter subsections:
- **8.1 Application: GATT/WTO** (compress by ~20%, remove the defensive "does not claim" sentence at l. 685).
- **8.2 Scope conditions** (when does the mechanism require alpha < alpha*? when does majority dominate? What about large N?). Keep the heatmap here.
- **8.3 Observable implications** (cross-issue variation, PTAs/Bhagwati, bargaining patience). This could also be moved to follow 8.1 for narrative flow.

---

## Additional minor suggestions

- **l. 100 (Baron-Ferejohn justification)**: This paragraph is 10 lines long and interrupts the model presentation. Move to a footnote or to the Scope section.
- **l. 106 (all-or-nothing entry footnote)**: This footnote is 7 lines. The essential point ("N should be read as the size of the institution the hegemon proposes to create") should be in the text; the rest should be in the appendix.
- **l. 411**: "Under majority, v(mu, M) is affine above the entry threshold---a single non-convexity." This is slightly misleading: an affine function that starts at zero creates a *kink*, not a "non-convexity" in the usual sense. The non-convexity is at the entry threshold (the transition from 0 to positive). Consider: "Under majority, the transition from non-participation to the affine payoff region creates a single kink at the entry threshold."
- **Fig. 3 (screening schematic)**: The TikZ figure is well-designed but the "BP gains" label and shaded region assume the reader already understands concavification. If BP is subordinated, remove the BP shading and label; the figure is stronger showing only the jump.
- **Notation table (Appendix A)**: Missing entries for phi (auxiliary variable), omega(mu), lambda_M, and kappa_M, as noted in the pending fix list (F9). These should be added before submission.
