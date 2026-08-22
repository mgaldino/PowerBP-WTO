# Carta Editorial — Revisão de Modelo Formal

**Manuscript:** `formal_model_v6.Rmd` — "Informational Power Through Pivotality: How Consensus Can Benefit a Hegemon" (Manoel Galdino)
**Date of review:** 2026-08-22
**Skill:** `review-formal-model` (three independent reviewers + editor's letter)
**Referências**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

**Scope of this review (provenance).** The reviewers read the text of `formal_model_v6.Rmd` in full (1,160 lines, including Appendices A–D) and inspected the five figures in the compiled `formal_model_v6.pdf` (pp. 6, 12, 14, 18, 20) and in the high-resolution PNGs under `figures/essential_input/`. The reviewed bytes are the **uncommitted working tree** on branch `codex/essential-input` (HEAD `fa803b2`): `formal_model_v6.Rmd` SHA-256 `34082366207b4f9571179cef324da593430121853dc314ea1c3933858ba0070b`, `formal_model_v6.pdf` SHA-256 `73eb70b03fd051edcc503115b4c41407abeeab9f16c8883c5747aabc57402e45`. The PDF was compiled at 12:29 today, after the last edit to the Rmd, so the two are in sync. These bytes differ from the independently reviewed Goal 5 snapshot at `b5fdefb` only in the abstract, which was rewritten by hand; the rewrite introduced the typos and the broken sentence noted below. This review therefore covers a new candidate, not the frozen snapshot. No file other than this report was written.

## Decisão: R&R major

## Scores consolidados

| Dimensão              | Score | Rating                                                      |
|-----------------------|-------|-------------------------------------------------------------|
| Design do modelo      | 6/10  | Sound core; one design iteration still owed                 |
| Apresentação técnica  | 6/10  | Mathematics coherent; numerous fixable presentation defects |
| Exposição             | 6/10  | Right skeleton; the reader is abandoned in the Results      |
| **Global**            | 6/10  | Major revision; no reformulation of the model required      |

## Síntese editorial

The three reviewers, working independently and from three different checklists, arrive at the same diagnosis. The paper's strength is its core: one privately informed vote that is an essential input under unanimity and a replaceable input under majority, compared across rules with every primitive held fixed except the quota, and differenced against a complete-information benchmark that strips out the value of a necessary vote. That is a well-designed isolation device, and the technical reviewer recomputed every formula, cutoff, payoff vector, worked value and in-figure number and found them mutually consistent. Nothing in the mathematics needs repair.

The weakness is that the paper presents the derivation log rather than the result. Every entry in Propositions 4.5–4.7 and in the 22-row Table 5 is a coefficient in {−1, 0, 1} on two named quantities — the pooling rent d = β(o₁ − o₀) and the timing wedge a_θ = (1 − β)o_θ, with k = d − a₀ — set by whether unanimity pools while majority does not and by whether a type's exclusion status changes. The paper never states this. Nor does it state its sharpest implication, which the design reviewer reads off Proposition 4.1 and Figure 3: under complete information unanimity weakly lowers the hegemon's payoff (p_U(o) = βo ≤ p_M(o)), and under private information the high type never strictly prefers unanimity in any cell where the comparison is defined. Consensus benefits a hegemon only when it is weaker than the other states fear. That is a more interesting and more defensible claim than the title's, and the reader has to assemble it from a proposition, a figure and a table.

The reviews reinforce each other on four points that are flagged independently by all three: (i) Section 2 illustrates the textbook terminal screening cutoff ν* and stops exactly where the contribution begins, while the example that carries the mechanism — majority buys two substitute votes at 0.225 each and leaves the hegemon outside; unanimity must pay 0.315 to either type; the low type gains 0.215 — is buried in Appendix C.3 and in Panel B of Figure 2; (ii) the measure-zero knife-edge o₁ = 1/m and its λ-segment occupy roughly a page of the body across four propositions, Table 5 and Appendix C.2; (iii) the exhibits are not integrated — only Figure 3 is cross-referenced, no table is, Figure 5 duplicates the right panel of Figure 2A, the Figure 2 note contradicts Proposition 4.6 (the span h − ℓ *is* the low-type component of RI_U), and Figure 4 carries the internal label "N7"; (iv) the abstract contains "hegemeon", "approvaed" and an ungrammatical second sentence, and the editorial markers "[AUTHOR: P1]" and "[AUTHOR: P2]" are printed in the model section of the PDF. The editor verified each of these against the compiled PDF.

The reviews diverge on one point, which the editor resolves below: what the empty middle-belief cell depends on.

## Hierarquia aplicada: Design > Apresentação > Exposição

The design is strong enough to justify investing in presentation and exposition; the model should not be rebuilt. But three design decisions must be taken *before* the rewrite, because they determine which propositions exist and what the abstract and the title can claim. Polishing the current tables first would polish objects that may not survive.

1. **Which object is the headline.** ΔRI = (V_U^priv − V_M^priv) − (V_U^pub − V_M^pub), and the second bracket is −a_θ·1{o_θ > 1/m} ≤ 0, so ΔRI weakly exceeds the payoff contrast by exactly the timing wedge. In region XX — large organizations, the WTO case — ΔRI = (d, 0) reads favorably while the payoff contrast is (k, −a₁) above ν* and (−a₀, −a₁) at ν = 0: a strong hegemon strictly prefers majority in every defined cell. The abstract, the conclusion and the WTO paragraph lead with ΔRI and never confront the payoff contrast. Likewise, the abstract's "can also be positive for the high type when public majority would exclude it" records that screening under private majority *delays* a high type that public majority would have excluded at once (RI_M(1) = −a₁); it is private information hurting the high type under majority, not unanimity helping it. The design reviewer's suggestion is the right one: present the payoff contrast first and ΔRI as its decomposition, and make Proposition 4.1's punchline explicit.

2. **What the timing wedge is.** a_θ arises because an excluded hegemon collects o_θ at the Round-1 date while an included one is priced at its discounted continuation. It is a consequence of the no-exit design, not of information, yet it sits inside objects labeled "informational rent" (the 0.010 bar in Figure 4B is a₀, pure timing), and the "reversal" advertised in the abstract requires k < 0, i.e. o₀ > βo₁, which Figure 3's slice o₀ = 0.5·o₁ cannot display (k = 0.4·o₁ > 0 there). Either give the wedge a substantive reading ("an essential player cannot walk away early") with a comparative static in β, or present β → 1 as the clean benchmark and relegate the wedge to an extension. It cannot stay unnamed inside the rent.

3. **What to do with the empty cell.** See the editor's note next.

**Editor's note on the empty cell (reconciling two reviewers).** The design reviewer attributes the emptiness of 0 < ν ≤ ν* to the "pure-strategy-plus-T^Y package," observing that in Appendix B.4 the (N,N) profile after s† fails only because T^Y forces yes at exact indifference. The technical reviewer proposes adding a sentence that nonexistence "uses T^Y at exact indifference" and that "with a strict-preference tie-break the middle cell's (N,N) profile would survive." The editor checked this. The observation is true of the specific proposal s† (y = ℓ exactly) but not of the cell. Take instead any y ∈ (ℓ, h) and x_j slightly above A; this is feasible for every parameter value because the proposer's residual at s† equals 1 − β + A > 0. Then every weak responder votes yes strictly under every admissible posterior (W(η) ≤ A < x_j); (Y,Y) fails because the high type's no yields continuation h > y whatever posterior follows it; (N,N) fails because the low type's deviation to yes passes the proposal and pays y > ℓ, strictly above its pooled-no continuation ℓ; (Y,N) and (N,Y) fail by the imitation arguments already in B.4. No tie-break is invoked anywhere. Three consequences. (a) Nonexistence rests on the pure-ballot restriction alone, which makes the result *stronger* than the current proof suggests; B.4 should be rewritten around such a proposal, or at least note it, so that the result does not appear to hinge on the tie-break. (b) The technical reviewer's proposed sentence should not be adopted as written. (c) The only genuine resolutions of the cell are the two the design reviewer lists: solve the mixed-ballot completion (the low type mixes so that the posterior after a no sits at ν*, and the terminal proposer mixes), or make the one-shot game of Proposition 4.2 the baseline — with an exogenous weak-state reservation value so that the substitute price stays positive — and present the two-round game as the extension that introduces bluff-by-delay. Keeping the cell empty is a defensible scope choice, but the paper currently spends an entire figure (Figure 5, "hegemonic decline") walking the reader into it, and the OPEC narrative lives precisely in that band of beliefs.

## Prioridades para revisão

1. **State the result as two forces, and put it first.** Replace Propositions 4.5–4.7 and Table 5 with one main result written in terms of d and a_θ (the exact case table goes to the appendix), followed by a corollary in words: unanimity pays the low type the pooling rent d whenever it pools and majority does not; a change in exclusion status moves any type by its timing wedge; the high type never strictly gains; the contrast is empty for 0 < ν ≤ ν*. Lead with the payoff contrast and present ΔRI as its decomposition. Make p_U ≤ p_M explicit after Proposition 4.1 and rewrite the "familiar answer" sentence (intro, lines 58–60), the abstract's high-type clause, and the WTO paragraph (lines 770–776) to agree with the payoff contrast in region XX. Move every appearance of the o₁ = 1/m segment (Prop. 4.3 item 5, the "unattained rectangle" paragraph, Prop. 4.5 item 4, the closing sentences of Props. 4.6–4.7, two rows of Table 5, Appendix C.2) to one appendix subsection and one body sentence.

2. **Take the two remaining design decisions** — timing wedge and empty cell — as described under the hierarchy above, and rewrite B.4 so that nonexistence is visibly tie-break-free. Give the empty cell one interpretive sentence for OPEC: when members believe Saudi Arabia is probably weak but cannot be sure, no stable pattern of acceptance and rejection exists in pure ballots, because any package the weak type would accept invites it to imitate the strong type's refusal.

3. **Make Section 2 carry the mechanism.** Move Appendix C.3 and Figure 2B to Section 2 and lead with the four numbers (0.225 × 2 substitutes under majority; 0.315 to either type under unanimity; low-type gain 0.215; high-type loss 0.035). Add ν = 0.285 as a second worked point: it lies in the window (ν*, ν_SE] = (0.2778, 0.2935] of region IX where majority screens and unanimity pools, so ΔRI = (d, a₁) = (0.225, 0.035) and both types gain — the only such cell, never exemplified. Add one parameter point with o₀ > βo₁ so that k < 0 appears somewhere in the paper. Introduce ν* only afterwards. Add Section 2 to the roadmap.

4. **Integrate or cut the exhibits.** Cite every figure and table at its point of use (only Figure 3 is cited today). Merge Figure 5 into Figure 2A (same parameters, same content) or write the "hegemonic decline" paragraph it is waiting for; delete its caption sentence about historical annotations that do not exist. Fix the Figure 2 note ("not the public-benchmark rent estimand" contradicts Prop. 4.6; drop "estimand"). Replace "N7" in Figure 4's note by "Propositions 4.5–4.7". In Figure 3, state the slice o₀ = 0.5·o₁ and m, β in the caption, define the vertical axis (m·o₁ = 1 is the inclusion threshold), add a slice or an o₀/o₁ axis where the low-type "prefers majority" region is visible, and remove the polygon seam in the high-type panel. Strip in-image titles, subtitles and footnotes from all four ggplot figures and carry that text in the LaTeX captions; typeset ν, ν_SE, ν*, β, ℓ, ΔRI instead of ASCII. Drop Figure 1 or replace it by the one non-trivial tree in the paper (the Round-1 unanimity ballot after the deviating proposal, with the four pure type-contingent profiles and why each fails). Change `[H]` to `[htbp]` on the nine floats: pp. 13, 17 and 19 are currently 40–60 % blank and push the main result past p. 15.

5. **Copy-edit and repair the notation.** Abstract: "hegemeon" → "hegemon", "approvaed" → "approved", "the hegemon private threshold" → "the hegemon's private threshold", and rewrite the second sentence ("To isolate the informational asymmetry between the hegemon and the weak states, we study a two-round bargaining game in which only weak states propose and the hegemon privately knows its outside option, comparing unanimity and majority rule under identical primitives."). Delete "[AUTHOR: P2]" (line 169) and "[AUTHOR: P1]" (line 196) and replace them with the substantive justifications of b_θ = 0 and of the asymmetric no-exit structure — the two assumptions a Dixit-style reader interrogates first. Notation: k is both βo₁ − o₀ and a vote count in B.3 (rename the count); W is a set, w a price and W(η) a function (rename the function); βo₀, βo₁ carry three names (t₀,t₁ / ℓ,h / written out) across rules, which hides the paper's central "same price when both include H" comparison — use one; rename o_θ "outside option" since it is also paid on exclusion from a passed agreement; declare in §3.3 that ballot strategies are pure and proposal strategies may be mixed, and replace "proposal segment" by "proposal mixture with exclusion weight λ"; name the assumptions (A1–A6) so that each proposition can cite the ones it uses; complete the notation table (ℓ, h, A, B, E, L, S, P, ν_SE, ν_SP, λ, p_g, II/IX/XX, η are missing) and spell out the II/IX/XX code. Remove the two "not X but Y" constructions (lines 739 and 774) in favor of direct statements, and reduce the four "not a calibration" disclaimers to one. Drop ȳ, which never binds; footnote b_θ.

## Recomendação estratégica ao autor

Revise for the target journal; do not reformulate. The mathematics holds, the isolating device is clean, and every defect the three reviewers found is either a presentation defect or a design decision that can be taken without new machinery (the one exception is the optional mixed-ballot completion of the middle cell). The gap between this draft and a publishable paper is that the draft has not yet said what it found. Sequence the revision in the order of the hierarchy: take the three design decisions first (headline object, timing wedge, empty cell) — this is a week of thinking and one rewritten proof, not new derivations; then restructure the Results around the two-force statement; then rewrite Section 2 and the introduction's results paragraph around the worked numbers; then fix the exhibits; and only then copy-edit. Doing the steps in the reverse order will produce a polished version of a table that the design decisions may remove. Two housekeeping points: the reviewed bytes are an uncommitted candidate whose manual abstract edit introduced regressions relative to the reviewed `b5fdefb` snapshot, so commit or revert before the next review cycle; and the in-figure text ("N7", "estimand", "worked example at nu = 0.35" versus ν = 0.80 elsewhere) should be regenerated from the figure scripts rather than patched in the captions.

---

## Parecer completo — Design do Modelo

# Parecer de Design do Modelo (Dixit / Varian / Board)

## Score: 6/10

## O modelo em uma frase
A two-round, weak-proposer legislative-bargaining game over a fixed unit pie in which one hegemon privately knows whether its terminal disagreement payoff is low or high; majority rule lets the proposer buy uninformed weak-state votes as substitutes for the hegemon's vote, unanimity makes that vote an essential input, and the paper compares the hegemon's type-contingent payoff across the two quotas against a complete-information benchmark to separate "veto power" from "informational rent."

## Tipo de contribuicao (Board & Meyer-ter-Vehn)
Primarily **isolating a political force**: the paper separates the informational component of pivotality from the veto-power component by differencing each private-information game against its own complete-information counterpart (lines 106-111, 577-600). Secondarily a **new lens** ("substitute versus essential input," lines 72-79, 726-731). It is not a new question: the intuition that consensus conceals and serves asymmetric power is already articulated by Steinberg (2002) and Stone (2011), both cited (lines 43-46, 111-113), and the pooling rent itself is the standard rent of one-sided private-information bargaining. The application (WTO/OPEC) is illustrative rather than load-bearing (lines 763-776 explicitly disclaim estimation). Empirical predictions are thin (lines 772-776 amount to "look for concessions that arise because partners cannot price the major state"). The nonexistence result is technical care rather than a technical contribution. The honest classification is therefore: a formalization of a known intuition that isolates one channel and, as shown below, sharpens it in a way the paper has not yet exploited.

## Avaliacao por dimensao

### MD1. Qualidade da pergunta [Adequada]
The puzzle is genuine and comes from the world, not the journals: why would the United States accept WTO consensus, and why does Saudi Arabia's spare capacity discipline OPEC agreements it cannot formally author (lines 41-56)? A non-specialist understands it immediately. Three problems keep the question from "Excelente."

First, the question the model answers is displaced from the puzzle it poses. The introduction asks a three-part rule-choice question (lines 47-52) and then, correctly, narrows to a fixed-rule payoff comparison (lines 52-56). But the paper then refuses every object a rule-choice reader would need: no interim or ex ante evaluation of the hegemon's preference over rules is ever computed, and Figures 3 and 4 announce this as a discipline ("No prior-weighted or ex ante image is displayed"; "without recombining types"). In singleton cells a prior-weighted payoff is a plain weighted average of the reported vector, so the refusal is a choice, not a constraint. As designed, the model cannot say whether a hegemon would want consensus even where it has a unique equilibrium.

Second, the model's own answer to the title question is sharper than the paper admits, and it is not stated anywhere. Proposition 1 (lines 308-327) gives \(p_U(o)=\beta o\le p_M(o)\) for every \(o\), strictly when \(o>1/m\): under complete information unanimity never raises the hegemon's payoff and strictly lowers it when the hegemon is expensive. The introduction's "familiar answer" that unanimity "adds veto power" (lines 58-60) therefore describes a power with zero or negative value in this model. Proposition 5 (lines 540-555) then shows that the high type's entry in \(V_U^{priv}-V_M^{priv}\) is \(0\), \(-a_1\), \(0\), \(0\), \(-a_1\), or \(-\lambda a_1\): a hegemon of actual strength never strictly prefers unanimity in any defined cell. Figure 3 (p. 14; `figure_f1_private_comparison.png`) shows this plainly: the high-type panel contains no "H prefers unanimity" region at all. The paper's result is thus "consensus benefits a hegemon only when it is weaker than the others fear," which is a more interesting and more defensible claim than the title's, but the reader must assemble it from Proposition 1, Proposition 5, and a figure.

Third, the headline object is the one most favorable to the thesis. \(\Delta RI\) equals \((V_U^{priv}-V_M^{priv})-(V_U^{pub}-V_M^{pub})\), and the second bracket is \(-a_\theta\cdot\mathbf{1}\{o_\theta>1/m\}\le0\). So \(\Delta RI\) weakly exceeds the payoff contrast by exactly the timing wedge. In region XX, the large-IO case relevant to the WTO, \(\Delta RI=(d,0)\) looks benign (line 647), while the payoff contrast is \((k,-a_1)\) above \(\nu^*\) and \((-a_0,-a_1)\) at \(\nu=0\): a strong United States strictly prefers majority in every cell in which the model speaks. The abstract (line 32) and conclusion (lines 813-818) lead with \(\Delta RI\); the WTO paragraph (lines 770-776) does not confront the payoff contrast. Likewise, the abstract's "can also be positive for the high type when public majority would exclude it" refers to the IX-screening entry \((d,a_1)\) of \(\Delta RI\) (line 644), where the high type's payoff is \(\beta o_1\) under both rules; the positive entry records that private information hurts the high type under majority (it is delayed by screening instead of excluded), not that unanimity helps it.

On new intuition versus formalization: the paper should say explicitly that "consensus favors the strong" is prior (Steinberg 2002; Stone 2011), that the pooling rent is the standard rent of one-sided private-information bargaining, and that what is new is (i) the substitute channel by which a voting rule switches that rent on or off and (ii) the restriction that only the overestimated type collects it. The legislative-bargaining-with-private-information literature that the paper cites (lines 100-104) should be complemented by the classic majoritarian-bargaining-with-incomplete-information results (the author should check Tsai and Yang, IER 2010, and the bilateral one-sided-information bargaining literature) so that the pooling rent is not presented as new.

### MD2. Simplicidade e KISS [Precisa simplificar]
The primitives are stark in the right way: binary type, unit pie, \(b_\theta=0\), weak disagreement value zero, only weak states propose, majority and unanimity differ only in the quota (lines 143-197). The model fits in three pages. The complexity hides elsewhere.

(a) **The solution concept carries six disciplines** (lines 251-268, 844-857): no-signaling by uninformed players, structural consistency, support preservation at endpoints, as-if-pivotal weak voting, \(T^Y\), and an anti-hegemon proposal tie-break. None of these is the point of the paper; all are scaffolding needed to pin down outcomes in a simultaneous public ballot with one informed voter. When an extensive form needs this much refinement to deliver outcomes, Varian's advice is to suspect the extensive form.

(b) **The empty middle cell is a product of that package, not of the political environment.** Appendix B.4's own enumeration (lines 991-1012) shows that three of the four pure profiles after \(s^\dagger\) fail for strict reasons, while \((N,N)\) fails only because \(T^Y\) forces yes at exact indifference (line 1003). For offers strictly between \(\ell\) and \(h\) no pure profile exists because the low type wants to imitate a revealing high-type no; this is the textbook case in which a signaling continuation requires the low type to mix so that the posterior after a no sits at \(\nu^*\) and the terminal proposer mixes. The paper instead restricts to pure ballot strategies and reports the cell as empty (Remark, lines 483-489; lines 746-751). The consequence is visible in Figure 5 (p. 20): the "hegemonic decline" narrative walks from pooling into a hatched region where the model says nothing for \(0<\nu\le\nu^*\) and then lands on an isolated endpoint. Intermediate uncertainty about hegemonic strength is precisely where the motivating story lives.

(c) **Schelling-Spence test on the second round.** Proposition 2 (lines 365-375) already contains the whole informational mechanism in one round: terminal unanimity pays the low type \(o_1\) when \(\nu>\nu^*\) and \(o_0\) otherwise, terminal majority excludes at zero price, and the one-shot contrast is \((o_1-o_0,0)\cdot\mathbf{1}\{\nu>\nu^*\}\) with no empty cell and no wedge. Proposition 4 (lines 465-481) confirms that the first round adds no rent: above \(\nu^*\) the hegemon receives \(h=\beta o_1\), the discounted terminal pooling price. What the second round adds is (i) a positive substitute price \(\beta/m\), which is what makes majority's inclusion-versus-exclusion comparison nontrivial and is a genuine reason to keep it; (ii) the timing wedge \(a_\theta\); and (iii) the bluff-by-delay incentive that empties the cell. The paper should say which of these three is phenomenon and which is noise. An exogenous weak-state reservation value in a one-shot game would deliver (i) without (ii) and (iii); that alternative is not among the eliminated designs recorded in the project's memory and deserves at least a "simplest version" paragraph.

(d) **Components carrying no weight.** \(\bar y\) (lines 157-161, 1144) never binds in any result. The \(y+o_\theta\) branch (lines 183-189, 838-842) could be replaced by \(o_\theta\) with identical equilibria; the paper itself says it never occurs. The knife-edge cases \(o_\theta=1/m\) occupy two of the five cases of Proposition 3 (lines 415-437), the \(\lambda\)-segment apparatus (lines 439-446, 550-555, 646-650, Appendix C.2), and several rows of the 22-row Table 5; they are measure-zero. The endpoint discipline (lines 260-268, 452-456, A.2, C.1, 819-827) exists so that a "literal endpoint" survives at \(\nu=0\) next to an empty interval; it is a patch for (b), not a feature.

### MD3. Isolamento do mecanismo [Parcial]
The isolating devices are well chosen: identical primitives across rules with only the quota changing (the Schelling discipline), and the public-type benchmark as the subtraction that removes "the value of a necessary vote" (lines 291-296, 577-600). Figure 2 Panel B (p. 12) is the mechanism in one picture: under majority the pie buys substitutes, under unanimity it buys the hegemon.

The isolation is nonetheless incomplete, for two reasons.

First, the results are presented as correspondence tables when they are, in every cell, the interaction of exactly two named forces. Writing \(k=d-a_0\) (verify: \(\beta(o_1-o_0)-(1-\beta)o_0=\beta o_1-o_0\)), Proposition 5 collapses to
\[
V_U^{priv}-V_M^{priv}=\big(d\cdot\mathbf{1}\{\nu>\nu^*\}\cdot\mathbf{1}\{\text{majority does not pool}\},\,0\big)-(a_0,a_1)\cdot\mathbf{1}\{\text{majority excludes}\},
\]
and Proposition 7 to
\[
\Delta RI=\big(d\cdot\mathbf{1}\{\nu>\nu^*\}\cdot\mathbf{1}\{\text{private majority does not pool}\},\,0\big)+(a_0,a_1)\odot\big(\mathbf{1}\{\text{public majority excludes }\theta\}-\mathbf{1}\{\text{private majority excludes }\theta\}\big),
\]
with the segment cases obtained by replacing the indicators with \(\lambda\). I checked every entry of Propositions 5-7 and Table 5 (lines 540-555, 602-634, 636-650, 654-697) against these two lines; they agree. The mechanism is therefore: unanimity pays the low type the pooling rent \(d\) whenever it pools and majority does not, and exclusion status moves payoffs by the timing wedge. The paper has the bookkeeping (lines 700-711 come close) but never the statement.

Second, the timing wedge confounds the informational reading. \(a_\theta=(1-\beta)o_\theta\) (lines 531-538) arises because an excluded hegemon collects its disagreement payoff at the Round-1 date while an included one is priced at its discounted continuation; it is a consequence of the no-exit design (lines 195-197), not of information. Yet it enters objects labeled "informational rent": \(RI_M=(a_0,0)\) in IX-exclusion (line 630), which is exactly the \(0.010\) bar in Figure 4 Panel B (p. 18; C.3, lines 1106-1113). And the "reversal" advertised in the abstract ("may reverse under private exclusion") requires \(k<0\), that is \(o_0>\beta o_1\): the two reservation values within a factor \(\beta\) of each other. Figure 3's slice \(o_0=0.5\,o_1\) cannot display it because \(k=o_1(\beta-0.5)>0\) there. The wedge deserves either a substantive reading (an essential player cannot walk away early, so pivotality has a cost) with a comparative static in \(\beta\), or removal to an extension with \(\beta\to1\) as the clean benchmark. The current text (lines 535-538) names it and moves on.

### MD4. Riqueza de insights [Adequada]
The model does generate insights beyond the question, but the paper leaves most of them unextracted:

1. A hegemon of known strength is weakly worse off under unanimity (Proposition 1); a hegemon of actual strength never strictly prefers it under private information (Proposition 5, Figure 3). "Informational power" here is the power to be overestimated.
2. Under majority, private information can hurt the strong type: in region IX screening delays it at \(\beta o_1\) where public exclusion would pay \(o_1\) now (\(RI_M=(0,-a_1)\), line 629). Uncertainty about strength is a cost to the strong under majority and a transfer to the weak under unanimity.
3. In large organizations (\(1/m<o_0\), region XX) majority always excludes and the hegemon's information becomes irrelevant, while unanimity pays exactly \(d\) (line 647). This is a clean size comparative static that maps to the WTO/OPEC contrast and is never stated as such.
4. A larger type gap raises the rent \(d=\beta(o_1-o_0)\) but also raises \(\nu^*=(o_1-o_0)/(1-o_0)\), shrinking the pooling region: a non-obvious trade-off the paper does not mention.
5. Comparative statics in \(\beta\) and \(m\) are absent from the text; the regions II/IX/XX (lines 602-608) are defined through \(1/m\) but \(m\) is never discussed as a variable.

The lens transfers readily to other pivotal-actor settings (UN Security Council permanent members with private valuations, EU unanimity domains, a pivotal legislator whose reservation value is uncertain); the paper mentions only OPEC and the WTO. Counterintuitive content exists (items 1-2) but is not headlined.

### MD5. Tipo de contribuicao [Isolating a force; secondarily a new lens]
As classified above. The isolation device is sound and the two-force structure is real, so the contribution is genuine. It is also modest as currently stated: the abstract's summary is a list of cells ("positive... vanishes... may reverse... undefined"), which is what a model produces before its forces have been named. Once restated as "pooling rent when unanimity pools and majority does not, minus timing wedge on exclusion; the strong type never gains," the contribution becomes crisp and defensible, and the conditionality becomes a feature rather than a hedge.

### MD6. Processo de construcao [Adequado]
The model has clearly been iterated: endpoint equivalence (C.1), correspondence-valued differences (lines 594-600), the explicit multiplicity segment, the pure-strategy scope remark. But the iteration has gone toward fortification against referees rather than toward Varian's simplify-then-generalize arc. Evidence:

- Section 2's "working numerical illustration" (lines 123-137) exhibits only \(\nu^*\). It does not show the substitute purchase under majority, the forced purchase of the hegemon under unanimity, or the low-type rent of \(0.215\); those appear only in Appendix C.3 (lines 1095-1115) and Figure 2B. The example does not exhibit the mechanism.
- There is a baseline but no extension: no mixed-strategy completion of the middle cell, no \(\beta\to1\) limit, no three-type or continuous-type check, no alternative dating of \(o_\theta\). The "Limits" list (lines 786-799) substitutes for robustness.
- Two of the most consequential assumptions carry editorial placeholders in the manuscript: "[AUTHOR: P2]" before the justification of \(b_\theta=0\) (line 169) and "[AUTHOR: P1]" before the justification of the no-exit, delayed-disagreement design (line 196). These are precisely the assumptions a Dixit-style reader interrogates (why does the hegemon contribute nothing to the agreement? why can weak states end the game without the hegemon while the hegemon cannot end it by itself?), and the manuscript currently flags them as pending.
- Figure 1 (p. 6) is a trivial flowchart; the informative picture is Figure 2B, which sits after the results rather than in the motivating example.

## Veredicto geral sobre design
The model has a clean, stark core (one informed essential vote against a pool of uninformed substitutes) and a well-chosen isolating device (the public-type benchmark), and the comparison across rules holds everything fixed except the quota. That is good design. But the design has not reached the Dixit endpoint at which results are stated as the interaction of named forces. Every entry in Propositions 5-7 is a combination of the pooling rent \(d\) and the timing wedges \(a_\theta\) with coefficients in \(\{-1,0,1\}\) set by whether unanimity pools while majority does not and by changes in exclusion status; the paper presents a 22-row table instead. The headline object \(\Delta RI\) nets out the component unfavorable to the thesis, so the abstract reads more favorably to consensus than the payoff comparison warrants, and the model's sharpest implication (a hegemon gains from consensus only when it is weaker than others fear; under complete information consensus weakly hurts it) is visible in Proposition 1 and Figure 3 but never stated as the answer. The middle-belief cell is empty because of the pure-strategy-plus-\(T^Y\) package in a signaling continuation, not because of anything political, and it swallows the region where the hegemonic-decline narrative needs the model. Several components (\(\bar y\), the \(y+o_\theta\) branch, the \(o_\theta=1/m\) knife-edges, the endpoint machinery) carry no weight. A 6 reflects a sound core with one more design iteration owed; the restatement in suggestion 1, the resolution of the empty cell, and the reconciliation of headline object with the title question would move it to 7-8.

## Sugestoes construtivas
1. **Restate the results as two forces.** Replace Propositions 5 and 7 (and Table 5) with the two one-line formulas in MD3, verified against every cell; keep the exact table in an appendix. State the mechanism in words: unanimity pays the low type the pooling rent whenever it pools and majority does not; exclusion moves any type by the timing wedge; the high type never gains.
2. **Lead with the object that answers the title question.** Present \(V_U^{priv}-V_M^{priv}\) first and \(\Delta RI\) as its decomposition, and make Proposition 1's punchline explicit: \(p_U\le p_M\), so under complete information consensus never benefits the hegemon. Rewrite the "familiar answer" sentence (lines 58-60), the abstract's high-type clause, and the WTO paragraph (lines 770-776) to be consistent with the payoff contrast in region XX.
3. **Resolve or redesign the empty cell.** Either (a) solve the mixed-ballot completion for \(0<\nu\le\nu^*\) (two types, binary action; the low type mixes to place the posterior after a no at \(\nu^*\), the terminal proposer mixes to make it indifferent) so the comparison is defined everywhere, or (b) make the one-shot game (Proposition 2, plus an exogenous weak-state reservation value to keep the substitute price positive) the baseline and present the two-round game as the extension that introduces bluff-by-delay. In either case, state which part of the phenomenon requires the second round: the substitute price, not the rent.
4. **Decide what the timing wedge is.** If it is a phenomenon ("an essential player cannot walk away early"), give it that reading in the text, a comparative static in \(\beta\), and a note that the advertised reversal requires \(o_0>\beta o_1\). If it is noise, date \(o_\theta\) uniformly or present \(\beta\to1\) as the clean benchmark and report the wedge as an extension. Do not let it sit inside objects labeled "informational rent" without comment (Figure 4B's \(0.010\)).
5. **Make Section 2 exhibit the mechanism.** Port Appendix C.3 and Figure 2B into Section 2: at the same parameters, show the majority proposer buying two weak votes at \(0.225\) and excluding the hegemon, the unanimity proposer forced to pay \(0.315\) to both types, and the low-type rent of \(0.215\). The reader should see substitutes versus essential input before any proposition.
6. **Prune.** Remove \(\bar y\); replace \(y+o_\theta\) by \(o_\theta\) (identical equilibria); move the \(o_\theta=1/m\) cases and the \(\lambda\)-segment to a footnote or appendix; compress the endpoint discipline to one remark; replace the "[AUTHOR: P1]" and "[AUTHOR: P2]" placeholders (lines 169, 196) with substantive justifications of \(b_\theta=0\) and of the asymmetric exit structure.
7. **Extract the surprising implications as stated results:** the strong type never prefers unanimity; private information hurts the strong type under majority screening; in large organizations majority makes the hegemon's information irrelevant while unanimity pays exactly \(d\); the type-gap trade-off between \(d\) and \(\nu^*\); comparative statics in \(m\) and \(\beta\).
8. **Position the contribution honestly.** State that "consensus favors the strong" is prior (Steinberg 2002; Stone 2011), that the pooling rent is the standard one-sided-private-information rent, and that the novelty is the substitute channel plus the restriction that only the overestimated type collects it. Add the majoritarian-bargaining-with-incomplete-information antecedents.
9. **Either answer the rule-choice question or stop posing it.** If the introduction keeps the three-part rule-choice framing (lines 47-52), add an interim or ex ante evaluation in the singleton cells (a weighted average of the reported vector is legitimate there, and the refusal to display it is a choice). Otherwise open with the fixed-rule payoff question the model actually answers.

---

## Parecer completo — Apresentação Técnica

# Parecer de Apresentação Técnica (Thomson / Board)

**Manuscript:** `formal_model_v6.Rmd` (1,160 lines, read in full), compiled PDF (31 pages), and the four high-resolution figure files. All formulas, cutoffs, payoff vectors, the worked values in Appendix C.3, and the numbers embedded in Figures 2–4 were recomputed by hand; all of them are mutually consistent. The problems reported below are problems of *presentation*: notation, naming, figure integration, assumption structure, and editorial leftovers. Line numbers refer to the `.Rmd`; proposition numbers follow the rendered PDF (4.1–4.7).

## Score: 6/10

The mathematics is internally coherent and the architecture is canonical (players → proposals → ballots/payoffs → solution concept → public benchmark → private games → decomposition). What keeps the score at 6 is a cluster of fixable but numerous defects: (i) only one of five figures, and none of the five tables, is cross-referenced anywhere in the body; (ii) editorial tags `[AUTHOR: P1]`, `[AUTHOR: P2]` and two abstract typos are rendered in the PDF; (iii) one symbol is used with two meanings (`k`) and another with three (`W`/`w`/`W(η)`); (iv) the same pair of numbers (βo₀, βo₁) carries three names; (v) a figure note contradicts Proposition 4.6 and another figure carries internal project jargon ("N7"); (vi) the notation table omits roughly half of the symbols used in the propositions and figures.

## Estrutura do modelo

One privately informed hegemon H and m ≥ 3 uninformed weak states (N = m+1) bargain over a unit pie in two rounds; in each round a weak state is recognized uniformly (H never proposes) and offers a package s = (y, (x_j), r_i) with y the concession to H. Nature draws θ ∈ {0,1} with Pr(θ=1) = ν, observed only by H; type θ's payoff outside any agreement is o_θ with 0 < o₀ < o₁ < 1, received at the end of the game if nothing passes, and also received on top of y if a majority passes a package over H's no vote. Ballots are simultaneous and become public ex post; the proposer counts as yes; majority needs q = ⌊N/2⌋+1 yes votes, unanimity needs all; a failed Round-1 ballot leads to a terminal Round 2 discounted by β ∈ (0,1). The solution concept is PBE in pure ballot strategies with four declared disciplines: uninformed actions do not move beliefs about θ (Bayes after H's actions, support-preserving at ν ∈ {0,1}); weak responders vote as if pivotal; exact indifference resolves to yes (T^Y); and among payoff-equivalent proposals the one minimizing H's expected payoff is selected. Results: a public-type benchmark (4.1), private terminal games (4.2), private Round-1 majority (4.3) and unanimity (4.4) correspondences, and a three-step decomposition — private contrast (4.5), informational rents RI_g = V_g^{priv} − V_g^{pub} (4.6), and ΔRI = RI_U − RI_M (4.7) — reported as type-contingent vectors, with an empty cell for 0 < ν ≤ ν* where unanimity has no pure-ballot PBE.

## Scorecard

| Dimensão | Veredicto | Comentário |
|---|---|---|
| D2. Model presentation | Adequado | Canonical order, one model, ~3 pages (PDF pp. 4–7); but three redundant devices (Table 1, Figure 1, Table 2), three unused primitives (ȳ, b_θ, C_H(h^a)), and two editorial tags left in the text. |
| D3. Notation | Precisa melhorar | `k` means both βo₁−o₀ and a vote count; `W` is a set, `w` a price, `W(η)` a function; (βo₀, βo₁) is written as (t₀,t₁), (ℓ,h) and (βo₀,βo₁); notation table omits ℓ, h, A, B, E, L, S, P, ν_SE, ν_SP, λ, p_g, II/IX/XX, η. |
| D4. Definitions | Precisa melhorar | o_θ is named "terminal disagreement payoff" but is also paid when H is excluded from a passed agreement; "proposal segment" vs "mixing weight" ambiguity; V_g^{priv} used before being defined; four labels for the empty cell. |
| D5. Statement of results | Adequado | Context → statement → (appendix) proof → intuition is followed; but 4.3, 4.6, 4.7 are exhaustive case lists with no headline corollary, and a measure-zero segment occupies four propositions and a table. |
| D6. Proofs | Adequado | Appendix placement, natural-language dominant, QED marks; no numbered steps, B.3 only sketches the five-case derivation, B.5 misuses "atomic", B.3/B.4 host the symbol collisions. |
| D7. Figures | Problema sério | Figures 1, 2, 4, 5 and Tables 1–5 are never referenced in the text; Figure 5 duplicates Figure 2A; "N7" jargon in Figure 4; Figure 2 note contradicts Prop. 4.6; "worked example" means ν = 0.35 in Figure 2B but ν = 0.80 in Figure 4 and C.3; Figure 3's slice hides the k < 0 case the text emphasizes. Numbers inside all figures are correct. |
| D8. Assumptions | Precisa melhorar | Assumptions are not named or numbered; m ≥ 3 is unmotivated; the y + o_θ exclusion payoff and the T^Y tie-break (load-bearing for the nonexistence result) receive one sentence each; mixed proposal strategies are used but never declared. |
| D9. Examples | Adequado | Parameters well chosen (ν* = 0.2778 < ν_SE = 0.2935 creates a genuine window); but the Section 2 example illustrates only the standard terminal cutoff, not the substitute-vs-essential-input mechanism, and no example shows k < 0 or the (ν*, ν_SE] window where both types gain. |

## Análise detalhada

### D3. Notation — Precisa melhorar

**Diagnóstico 1 (double use of `k`).** Line 531 defines k = βo₁ − o₀ (used in Props 4.5, 4.7, Table 5, B.5, B.6, C.2, Conclusion l. 815). Line 904 (proof B.3) writes "Let k be the number of such responders", followed by k ≥ q−1, k = q−2, k ≤ q−3. The appendix therefore uses k with two meanings 110 lines apart.
**Impacto.** A reader checking B.5/B.6 after B.3 must re-derive which k is meant; Thomson's first rule is that "notation that can be guessed" requires one symbol per object.
**Sugestão.** Rename the count to n_Y (number of weak yes votes) in B.3; keep k for the cross-date quantity.
**Referência.** Thomson §3 (unambiguous notation; no symbol reuse).

**Diagnóstico 2 (triple overload of W / w / W(η)).** W is the set of weak states (l. 144), w = β/m is the majority vote price (l. 385), and W(η) is the unanimity continuation function (l. 948, 954, 986). The three objects appear in the same proof environment (B.3–B.4).
**Sugestão.** Keep W for the set; rename the continuation function c_U(η) (or V_W(η)), and consider renaming w as π_M ("price under majority") so that the unanimity continuation floors A and B can become π_U(0), π_U(1) — which also fixes the non-mnemonic A, B (see next item).
**Referência.** Thomson §3 ("the same symbol should never designate two different objects").

**Diagnóstico 3 (three names for one pair).** βo₀ and βo₁ are called t₀, t₁ at l. 385 (majority), ℓ, h at l. 448 (unanimity), and written out as (βo₀, βo₁) in B.5 (l. 1021–1026). Table 4 shows (t₀,t₁) in the majority rows and (ℓ,h) in the unanimity rows for the identical numeric vector. Proposition 4.5 then subtracts (ℓ,h) − (t₀,t₁) and reports (0,0), which the reader can only verify by unpacking both names.
**Impacto.** The central comparison of the paper (same price under both rules when both include H) is hidden behind a naming change across rules.
**Sugestão.** Use a single name for the Round-1 thresholds, e.g. t₀, t₁, under both rules; drop ℓ and h (or keep ℓ, h only as text labels in figures with t₀, t₁ typeset).
**Referência.** Thomson §3 (parsimony of symbols; one concept, one name).

**Diagnóstico 4 (A and B are not mnemonic; II/IX/XX look like Roman numerals).** A = β(1−o₀)/m and B = β(1−o₁)/m (l. 448) are "weak-state floors" (Figure 2 calls them that) but the letters carry no cue and collide visually with "Appendix A/B". Region labels II, IX, XX (l. 590–592) are mnemonic (I = included, X = excluded) but IX reads as the numeral 9 in a paper that already numbers propositions and sections.
**Sugestão.** f₀, f₁ for the floors; replace IX by "IE" (included/excluded) or spell out "in–in / in–out / out–out".
**Referência.** Thomson §3 (mnemonic choices; avoid symbols with a competing conventional reading).

**Diagnóstico 5 (notation table incomplete; figures use ASCII names).** Appendix D (l. 1123–1158) omits ℓ, h, A, B, E, L, S(ν), P, ν_SE, ν_SP, λ, p_M(o), p_U(o), C_H(h^a), T^Y, b_θ, s, II/IX/XX, η, W(η), u, and the superscripts S/P/E of V_M^S, V_M^P, V_M^E (B.5, l. 1021). Its entry for k ("Cross-date quantity") is not a meaning. Figures print `nu_SE`, `nu*`, `ell`, `beta x o1`, `o_theta`, `RI_M`, `DeltaRI` while the body typesets ν_SE, ν*, ℓ, βo₁, o_θ, RI_M, ΔRI.
**Sugestão.** Complete the table, give k a verbal meaning ("discounted high threshold minus current low outside option"), and render figure labels with plotmath/LaTeX so that symbols match the body.
**Referência.** Thomson §3; Board & Meyer-ter-Vehn §4 (a notation table must be a complete index).

### D4. Definitions — Precisa melhorar

**Diagnóstico 1 (the name of o_θ does not match its use).** o_θ is defined as "terminal disagreement payoff" (l. 146–148, Table 2, notation table). But Table 1 (l. 207) and l. 184–189 pay H the amount y + o_θ when a *majority passes a proposal* over H's no vote — an agreement, not a disagreement. The proof B.1 relies on this: "H is nonpivotal and strictly votes no because no yields y+o rather than y" (l. 864–865).
**Impacto.** The reader who remembers "disagreement payoff" will misread the majority exclusion branch, which is the mechanism's other half (the substitute coalition).
**Sugestão.** Call o_θ the "outside option (non-participation payoff)", and state once that it is realized both under terminal disagreement and under exclusion from a passed agreement; mark the y+o_θ cell in Table 1 as "majority only", since under unanimity H's no cannot coexist with passage.
**Referência.** Thomson §4 ("be unambiguous when you define a new term"; name should reflect the object).

**Diagnóstico 2 ("proposal segment" vs "mixing weight").** Proposition 4.3, case 5 (l. 427–428) says "the entire proposal segment joining the two survives"; the paragraph at l. 438–441 says the segment's "mixing weight is a probability over pure proposals in the proposer's strategy"; C.2 (l. 1069–1071) says "exact indifference ... can leave a proposal segment. If λ is the exclusion weight...". A geometric segment of packages is not what survives (a convex combination of the exclusion and pooling packages would not pass); what survives is a mixed proposal strategy. Meanwhile §3.3 (l. 251) declares "pure ballot strategies" and never says whether proposal strategies may be mixed.
**Sugestão.** In §3.3, state: "Ballot strategies are pure; proposal strategies may be mixed (behavior strategies over packages)." Replace "proposal segment" with "proposal mixture with exclusion weight λ" throughout (Props 4.3, 4.5, 4.6, 4.7, Table 5, C.2).
**Referência.** Thomson §4 (state the type of the object being defined).

**Diagnóstico 3 (objects used before definition).** V_U^{priv}, V_M^{priv} first appear inside Proposition 4.5 (l. 541); V_g^{pub} first appears inside the definition of RI_g (l. 577); neither is defined in the body — only in the notation table. The superscripts S, P, E of V_M^S etc. (l. 1021) are never defined. RI_M(0), RI_M(1) as component notation appears only in C.2 (l. 1077).
**Sugestão.** Add one displayed definition at the start of §4.5: "For rule g and information structure ι ∈ {pub, priv}, let V_g^ι = (V_g^ι(0), V_g^ι(1)) denote the set of equilibrium Round-1 payoff vectors of H, ordered low/high type."
**Referência.** Thomson §4 (definition before use; logical sequencing).

**Diagnóstico 4 (outcome classes are defined only in prose).** "Exclusion", "screening", "pooling", "delay" are defined by three sentences at l. 396–400, not as a displayed definition, yet they index every later proposition and all of Table 5. "Outcome class" itself (l. 416) is undefined.
**Sugestão.** A typographically set Definition listing the four classes by (number of weak votes bought, y offered, acceptance set of H).
**Referência.** Thomson §4 (typographical emphasis of definitions; examples of each category).

**Diagnóstico 5 (four labels for the empty cell).** "no perfect Bayesian equilibrium in pure ballot strategies" (Prop 4.4, abstract), "no pure-strategy equilibrium" (l. 91, 547, 567, 816), "no pure-vote PBE" (Figures 2 and 3), "no pure-strategy PBE" (Figure 5). Since proposals may be mixed (l. 439), "no pure-strategy equilibrium" is literally a different, and not established, claim.
**Sugestão.** One phrase everywhere: "no PBE in pure ballot strategies"; update figure legends accordingly.
**Referência.** Thomson §4 (one name per concept).

Minor: "respondent" (l. 831) vs "responder" elsewhere; "three declared disciplines" (l. 251) followed by four rules; results stated inside the model section ("The fixed unit pie is exhausted on the equilibrium path", l. 165; "In every equilibrium exclusion derived below... y = 0", l. 187–189).

### D7. Figures — Problema sério

**Diagnóstico 1 (figures and tables are not integrated into the argument).** A grep of `\ref{fig:` and `\ref{tab:` finds a single reference in the whole body: Figure \ref{fig:privatecompare} at l. 559. Figure 1 (timing), Figure 2 (prices/coalitions), Figure 4 (power vs. information), Figure 5 (hegemonic decline), and Tables 1–5 are never cited. The "hegemonic decline" framing of Figure 5 does not occur in any sentence of §5.
**Impacto.** Under Board's rule that every exhibit must be called out and read for the reader, five of the paper's nine exhibits are orphans; a referee will ask why they are there.
**Sugestão.** Cite each exhibit where it is used (Table 1 at l. 191; Figure 1 at l. 174; Table 2 at l. 258; Table 3 after Prop 4.1; Table 4 after Prop 4.4; Figure 2 at the end of §4.4; Figure 4 after Prop 4.7; Table 5 after Prop 4.7), and either write the "decline" paragraph that Figure 5 is meant to illustrate or drop Figure 5.
**Referência.** Board & Meyer-ter-Vehn §5; Thomson §6 (every figure must be discussed in the text).

**Diagnóstico 2 (Figure 5 duplicates the right panel of Figure 2A).** Both use o₀ = 0.10, o₁ = 0.35, m = 4, β = 0.9; both show the hatched cell 0 < ν ≤ ν*, the endpoint circle at (0, 0.09), the line at h = 0.315 and the band "pooling rent h − ell". Figure 5 adds only an arrow "read from right to left".
**Sugestão.** Merge: add the arrow and the "read right-to-left" annotation to Figure 2A, delete Figure 5.
**Referência.** Thomson §6 (parsimony of exhibits).

**Diagnóstico 3 (Figure 2 note contradicts Proposition 4.6).** The embedded note says the yellow span "is the low type's pooling rent h − ell, not the public-benchmark rent estimand". But for ν > ν*, RI_U = (d, 0) with d = βo₁ − βo₀ = h − ℓ (Prop 4.6, l. 602–612). The span *is* exactly the low-type informational rent of unanimity. The disclaimer is false as written, and "estimand" is econometric vocabulary foreign to a theory paper.
**Sugestão.** Replace with "the yellow span is the low type's pooling rent h − ℓ, which equals the low-type component of RI_U in Proposition 4.6."
**Referência.** Board & Meyer-ter-Vehn §5 (captions and notes must agree with the stated results).

**Diagnóstico 4 (internal jargon in Figure 4).** The note ends: "working numerical illustration of the exact N7 formulas". "N7" is a label from the authors' derivation pipeline with no referent in the paper.
**Sugestão.** "...of the formulas in Propositions 4.5–4.7".

**Diagnóstico 5 ("worked example" is three different beliefs).** Figure 2B's subtitle and note say "at the worked example" and "at nu = 0.35"; Figure 4 and Appendix C.3 use ν = 0.80; Section 2 uses beliefs 0.20 and 0.35 for the terminal round. All three lie in the same cells (exclusion/pooling), so the numbers are right, but the label "the worked example" is not well defined.
**Sugestão.** Fix one belief (ν = 0.80, as in C.3 and Figure 4) for all exhibits, or label Figure 2B explicitly "at ν = 0.35 (terminal-round illustration of Section 2)".

**Diagnóstico 6 (Figure 3: the slice suppresses the case the text emphasizes, and the caption omits the slice).** The figure fixes o₀ = 0.5·o₁ (stated only in the in-figure subtitle, not in the caption at l. 563–568 nor in the body). Along that slice k = βo₁ − o₀ = 0.4·o₁ > 0 always, so the low-type panel can never display "H prefers majority" under exclusion — precisely the sign reversal the abstract, §4.6 (l. 710–712) and the Conclusion (l. 815) highlight. The y-axis "Relative hegemonic strength, m × o₁" is a composite never defined in the text. The seam at m·o₁ ≈ 1.3 in the high-type panel (where the ν* and ν_SE curves cross) is visible as a horizontal line across the red region — a polygon artifact.
**Sugestão.** State the slice and m, β in the caption; add a second slice (e.g., o₀ = 0.95·o₁, where k < 0 for β = 0.9) or re-parametrize the vertical axis as o₀/o₁ at fixed o₁, so the sign change of k appears; define "relative hegemonic strength" or relabel the axis "m·o₁ (high outside option relative to a weak-state vote)"; draw the colored region as one polygon. I verified that the ν = 0 edge strip (yellow up to m·o₁ = 2, red above) matches Proposition 4.5(1), so the regions themselves are correct.
**Referência.** Board & Meyer-ter-Vehn §5 (figures should display the interesting cases; captions self-contained).

**Diagnóstico 7 (Figure 1 is a flowchart, not a game tree).** It omits Nature's draw of θ, the recognition lottery, and any information set; it conveys nothing beyond the sentence at l. 151–152 and l. 191–193.
**Sugestão.** Either drop it, or replace it by the one non-trivial tree in the paper: the Round-1 unanimity ballot after s†, showing the four pure type-contingent profiles of H and why each fails (this is the proof of the headline nonexistence result and would earn its page).
**Referência.** Thomson §6; Hirsch standard in the project's own guidelines (non-trivial game trees only).

**Diagnóstico 8 (Figure 5 caption refers to content that is not in the figure).** "Historical annotations, if used, are illustrations rather than empirical tests or calibration" (l. 756–758) — there are no historical annotations.
**Sugestão.** Delete the sentence (or the figure, per item 2).

### D8. Assumptions and logical structure — Precisa melhorar

**Diagnóstico 1 (assumptions are not named, so results cannot cite them).** Primitives (l. 143–170), the exclusion payoff (l. 184–189), and the four equilibrium disciplines (l. 251–268) are prose; Table 2 summarizes "scope" but no proposition states which discipline it uses. Yet the nonexistence result in 4.4 is driven by exactly two of them: T^Y at exact indifference (B.4, item 2: "T^Y requires yes at equality") and the no-signaling/Bayes structure (items 3–4).
**Sugestão.** Assumptions A1 (primitives: 0 < o₀ < o₁ < 1, β ∈ (0,1), m ≥ 3), A2 (exclusion payoff y + o_θ), A3 (belief discipline and support preservation), A4 (as-if-pivotal voting), A5 (T^Y), A6 (proposal tie-break). Then write "Under A1–A5" in Prop 4.4 and say in the text after it that nonexistence uses A5 at equality.
**Referência.** Thomson §4–§5 (explicit hypotheses); Board & Meyer-ter-Vehn §3 (ordering by decreasing plausibility and stating which results need which assumptions).

**Diagnóstico 2 (motivation is not proportional to controversy).** The most consequential and least standard assumption — H collects y + o_θ when excluded, which makes H strictly vote no whenever non-pivotal (B.1) — gets one sentence (l. 185–187). T^Y, which decides the existence question, gets half a sentence (l. 256–257). In contrast, support preservation at ν ∈ {0,1}, which only matters at the endpoints, gets a full paragraph with three citations (l. 260–268).
**Sugestão.** Two short paragraphs: (a) why a passed package binds H's institutional term even when H votes no, and what changes if the excluded H receives only o_θ; (b) why T^Y is the natural tie-break here (it is what makes "as-if-pivotal" voting well defined at the continuation value) and a one-line statement that with a strict-preference tie-break the middle cell's (N,N) profile would survive.
**Referência.** Board & Meyer-ter-Vehn §3 ("justify assumptions in proportion to how much work they do").

**Diagnóstico 3 (m ≥ 3 is unmotivated).** Line 143 imposes it and the Limits section (l. 795) only says it "excludes the three-player case". The reader cannot tell whether m = 2 breaks a proof (e.g., q − 2 = 0 screening coalitions) or merely a interpretation.
**Sugestão.** One sentence stating what fails at m = 2, or drop the restriction if nothing fails.

**Diagnóstico 4 (an example satisfying all assumptions is implicit only).** C.3 gives (m, β, o₀, o₁) = (4, 0.9, 0.10, 0.35), which satisfies A1, but the text never says "this parameter point satisfies every assumption and lies in region IX".
**Sugestão.** One sentence in §2 or §3.1.

### D2, D5, D6, D9 — Adequado, with specific items

**D2.** Model is ~3 PDF pages (pp. 4–7), within Thomson's bound. Cuts available: ȳ (l. 161) is never used after its definition; b_θ (l. 167–170) is introduced only to be set to zero (make it a footnote); h^Y, h^N, C_H(h^a) (l. 209, 215–218) appear only in Table 1 and never again — the continuation values are computed directly later. Table 1, Figure 1, and Table 2 say the same thing three times; keep Table 1. Remove `[AUTHOR: P2]` (l. 169) and `[AUTHOR: P1]` (l. 196) — both are rendered in the PDF (pdftotext lines 146 and 171). The roadmap (l. 115–121) skips Section 2.

**D5.** Propositions 4.3, 4.6, 4.7 are exhaustive case enumerations; the "what must happen" statement exists only as prose at l. 706–716. Board's template ("Define p. Define q. Every p is q") is satisfied by 4.1, 4.2, 4.4, 4.5 but not by 4.3/4.6/4.7. The exclusion–pooling "segment" occurs only on the boundary o₁ = 1/m and, by the tie-break inequality in case 5, only at the single belief ν̂ = k/(o₁ − o₀) — a measure-zero event that nevertheless appears in Props 4.3, 4.5(4), 4.6, 4.7, two Table 5 rows, and all of C.2. Suggest a Corollary after 4.7 ("For ν > ν*: the low type's contrast is strictly positive whenever majority screens, and under exclusion it has the sign of k; it is zero under pooling. The high type's contrast is positive only when private majority screens a type public majority would exclude, negative only when private majority excludes a type public majority would include"), and one remark relegating the knife-edge mixture to C.2. Proposition 4.3's last three sentences (permutation multiplicity, l. 431–435) belong in a remark. Table 5 duplicates Props 4.6–4.7 verbatim; keep one.

**D6.** Proofs are in the appendix (correct per the project's Hirsch standard), natural-language dominant, each closed by □. Improvements: number steps in B.1 (three claims in one block), B.3 and B.4 ("Step 1: continuation values; Step 2: existence at ν = 0; Step 3: existence above ν*; Step 4: nonexistence via s†"); B.3 (l. 930–934) asserts that substituting the signs of o₀ − 1/m and o₁ − 1/m "produces the five cases" — spell out the two-line argument (P − E > 0 kills exclusion in case 1 so screening vs. pooling binds at ν_SP; P − E < 0 kills pooling in case 2 so screening vs. exclusion binds at ν_SE); "the payoff set and outcome set remain atomic" (l. 1031) is wrong vocabulary for a one-dimensional segment — write "remain a single segment indexed by λ". The "For completeness" enumeration in B.4 (l. 973–990) would read better as a small table of (profile, condition on u and y).

**D9.** Numbers are good: with (4, 0.9, 0.10, 0.35), ν* = 0.2778 and ν_SE = 0.2935 produce a real window (ν*, ν_SE] in region IX where majority screens and unanimity pools, i.e., ΔRI = (d, a₁) = (0.225, 0.035) — the only cell where both types gain, and it is never exemplified. The Section 2 example illustrates the terminal cutoff only, which is a textbook screening cutoff; the paper's own mechanism (majority buys two substitutes at β/m = 0.225 each, total 0.45, versus unanimity paying H 0.315 plus three floors of 0.146) is displayed only in Figure 2B. Rewrite §2 around that comparison, add ν = 0.285 as a second worked point, and add one example with o₀ > βo₁ (e.g., o₀ = 0.33, o₁ = 0.35) to show k < 0. Naming: "H" and "weak states" are adequate; the OPEC mapping (l. 763–770) could name the §2 players.

## Inventário de notação

| Símbolo | Significado | Introduzido em | Usado em | Problema? |
|---|---|---|---|---|
| H | hegemon | l. 143 | throughout | — |
| W, m | set / number of weak states, m ≥ 3 | l. 143–144 | l. 157; Prop 4.3 | W collides with W(η) (l. 948); m ≥ 3 unmotivated |
| N = m+1 | number of states | l. 144 | l. 178 only | used only inside q; fine |
| θ ∈ {0,1} | H's type | l. 145 | throughout | — |
| ν | prior Pr(θ = 1) | l. 146 | throughout | — |
| o_θ | "terminal disagreement payoff" | l. 146–148 | throughout | name does not match use at l. 185, Table 1 (paid on exclusion from a passed agreement) |
| o | generic public disagreement payoff | l. 309 | Prop 4.1, Table 3, B.1 | should say o ∈ {o₀,o₁}; not in notation table |
| s = (y,(x_j),r_i) | proposal | l. 156–159 | A.1, B.4 (s†) | not in notation table |
| y, x_j, r_i | concession to H; responder share; proposer residual | l. 156–164 | throughout | — |
| ȳ | cap on y, o₁ ≤ ȳ ≤ 1 | l. 161 | notation table only | never used: drop |
| b_θ | intrinsic agreement benefit | l. 167 | set to 0, never used | superfluous; footnote |
| q | majority quota ⌊N/2⌋+1 | l. 178 | throughout | — |
| β | discount factor | l. 193 | throughout | — |
| h^Y, h^N, C_H(h^a) | public histories; H's continuation | l. 209–216 | Table 1 only | never used again; drop; h^Y visually collides with h (l. 448) |
| T^Y | yes at exact indifference | l. 257 | A.2, B.1, B.4 | load-bearing, under-motivated; not in table |
| p_M(o), p_U(o) | public Round-1 payoff of H | l. 319–325 | B.6 | not in table |
| ν* | terminal unanimity cutoff | l. 358 | throughout | — |
| w = β/m | weak-state Round-1 continuation/price (majority) | l. 385 | Prop 4.3, B.3 | lowercase of set symbol W |
| t_θ = βo_θ | Round-1 threshold of type θ | l. 385 | Prop 4.3, Table 4 | same numbers as ℓ, h and (βo₀,βo₁): three names |
| E, L, S(ν), P | proposer payoffs: exclusion, low-offer-given-low-type, screening, pooling | l. 388–394 | Prop 4.3, B.3 | L is not an outcome class though l. 387 says "three classes" and lists four; not in table |
| ν_SE, ν_SP | screening–exclusion / screening–pooling cutoffs | l. 401–412 | Prop 4.3, Table 4, Figs 2–3 | not in table; ASCII "nu_SE" in figures |
| ℓ, h | βo₀, βo₁ | l. 448 | Prop 4.4, Table 4, B.4, Figs 2, 5 | duplicate of t₀, t₁; not in table |
| A, B | weak-state continuation floors β(1−o_θ)/m | l. 448 | Prop 4.4, B.4 | non-mnemonic; not in table |
| λ | exclusion weight on the mixture | l. 439, Prop 4.5(4) | Props 4.6–4.7, Table 5, C.2 | object type ambiguous ("segment" vs "mixing weight") |
| a_θ, d, k | timing wedge; discounted type gap; βo₁ − o₀ | l. 531–533 | Props 4.5–4.7, B.5–B.6, C | **k reused as a vote count at l. 904** |
| V_g^{priv}, V_g^{pub} | payoff correspondences of H | Prop 4.5 (l. 541), l. 577 | B.5, B.6, C | used before definition; superscripts S/P/E (l. 1021) undefined |
| RI_g, ΔRI | informational rent; contrast | l. 577–580 | Props 4.6–4.7, Table 5 | ASCII "RI_M", "DeltaRI" in Figure 4 |
| g ∈ {M, U} | rule index | l. 575 | — | — |
| II, IX, XX | public inclusion regions | l. 590–592 | Props 4.6–4.7, Table 5 | Roman-numeral look-alike; not in table |
| a_H, a_{−i} | ballot actions | l. 829 | A.1 only | not in table |
| η, η_Y | posterior | l. 947, 985 | B.4 | not in table |
| W(η) | weak-state continuation under unanimity | l. 948 | B.4 | collides with W |
| u = min_j x_j | minimum responder payment | l. 973 | B.4 | local; fine |
| s† | the deviation proposal | l. 994 | B.4 | fine |
| V_M^S, V_M^P, V_M^E | private majority vectors by class | l. 1021 | B.5 | superscripts undefined |
| RI_M(0), RI_M(1) | components by type | l. 1077 | C.2 | component notation used nowhere else |

## Análise resultado-a-resultado

| Result (PDF numbering) | Context before | Statement | Proof | Intuition after | Implications/exhibit | Takeaway message (as the reader should retain it) | Format issues |
|---|---|---|---|---|---|---|---|
| Prop 4.1 Public-type benchmark (l. 308–327) | Yes: price paragraph l. 299–306 | Clean; closed forms p_M, p_U | B.1 | Yes: tie at o = 1/m (l. 350–352) | Table 3 (never cited) | With a public type, unanimity always pays βo; majority pays βo only if H is cheap (o ≤ 1/m) and otherwise excludes H, who keeps o. | Mixed-case statement fine; uses generic o without saying o ∈ {o₀,o₁}. |
| Prop 4.2 Private terminal games (l. 365–375) | Yes: l. 356–363 | Clean | B.2 | Yes: l. 377–379 | Section 2 example | Terminal majority ignores H's type; terminal unanimity screens (offers o₀) below ν* and pools (offers o₁) above. | "unique equilibrium outcome" is stated only for majority; fine. |
| Prop 4.3 Private majority correspondence (l. 415–436) | Yes: classes and cutoffs l. 383–412 | Five cases + multiplicity sentences | B.3 (five-case derivation sketched) | Partly: segment paragraph l. 438–441 | Table 4 (never cited), Figure 2A | Majority never delays; it screens when the high type is unlikely and otherwise pools (if even the high type is cheaper than a weak vote) or excludes (if not). | Case 5 is a knife-edge that occupies 5 of 21 lines; multiplicity sentences belong in a remark; "three undominated classes" vs four expressions (l. 387). |
| Prop 4.4 Private unanimity correspondence (l. 465–481) | Yes: two good paragraphs l. 450–463 | Clean array | B.4 | Yes: Remark l. 483–489 | Table 4, Figures 2A, 5 | Unanimity pools at h above ν*; at ν = 0 it pays ℓ; for 0 < ν ≤ ν* no pure-ballot PBE exists because one feasible proposal leaves H's types without consistent pure votes. | Vector (ℓ,h) at ν = 0 silently includes an off-support type (explained only in Prop 4.7); terminology drift "pure-strategy". |
| Prop 4.5 Private institutional payoff contrast (l. 540–556) | Minimal: a_θ, d, k defined l. 530–538 | Four items | B.5 (four lines) | Yes: l. 557–560 | Figure 3 (the only cited figure) | Unanimity minus majority for H is (d,0) when majority screens, (0,0) when it pools, (k,−a₁) when it excludes, empty in the middle cell. | V^{priv} undefined before use; item 4's "restricted to the proposal weights that survive the tie-break" is either vacuous (all λ survive at exact equality) or contradictory (no segment otherwise). |
| Prop 4.6 Informational rents by rule (l. 602–631) | Yes: l. 596–600 | Case table | B.6 | None (goes directly to 4.7's lead-in) | Table 5, Figure 4 (neither cited) | Private information pays unanimity's low type d above ν*; under majority it pays only when the private class differs from the public inclusion decision. | Exhaustive list without a "must" sentence. |
| Prop 4.7 Institutional informational-rent contrast (l. 636–657) | Yes: l. 632–635 | Case table | B.6 | Yes: sign-pattern paragraph l. 706–716 | Table 5, Figure 4 | Low type: gains d under screening, k under exclusion (sign of βo₁ − o₀), nothing under pooling; high type: gains a₁ only in IX-screening, loses a₁ only in II-exclusion; empty for 0 < ν ≤ ν*. | The takeaway lives in prose; needs a Corollary; off-support component at ν = 0 explained inside the proposition instead of a remark. |

## Sugestões construtivas

1. **Editorial leftovers and abstract typos (one hour, highest visibility).** Delete `[AUTHOR: P2]` (l. 169) and `[AUTHOR: P1]` (l. 196) — both print in the PDF. In the abstract (l. 32): "hegemeon" → "hegemon", "approvaed" → "approved", "the hegemon private threshold" → "the hegemon's private threshold", "In order to isolate differential of information between hegemeon and weak states" → "To isolate the informational asymmetry between the hegemon and the weak states". Remove "N7" from Figure 4's note, "estimand" from Figure 2's note, and the "Historical annotations, if used" sentence from Figure 5's caption (l. 756–758).

2. **Integrate or cut exhibits (D7).** Cite every figure and table at the point of use; merge Figure 5 into Figure 2A (same parameters, same content); replace Figure 1 with the s† ballot tree or drop it; keep one of {Table 1, Figure 1, Table 2}; keep one of {Table 5, the displays in Props 4.6–4.7}. Fix Figure 2's note so it agrees with Prop 4.6 (h − ℓ = d = RI_U's low-type component). Unify "the worked example" to ν = 0.80.

3. **Repair the notation (D3).** Rename the vote count in B.3 (l. 904) to n_Y; rename W(η) (l. 948) to c_U(η); use t₀, t₁ for βo₀, βo₁ under both rules and retire ℓ, h (or vice versa); rename A, B to f₀, f₁ ("floors"); replace IX by IE; complete Appendix D with every symbol listed above and give k a verbal meaning; typeset figure labels (ν_SE, ν*, ℓ, ΔRI) instead of ASCII.

4. **Name the assumptions and declare the strategy space (D8, D4).** A1–A6 as listed above; state in §3.3 that proposal strategies may be mixed while ballots are pure; replace "proposal segment" by "proposal mixture with exclusion weight λ"; motivate m ≥ 3, the y + o_θ exclusion payoff, and T^Y in proportion to the work they do; say explicitly after Prop 4.4 that nonexistence uses T^Y at exact indifference.

5. **Rename o_θ (D4).** "Outside option" (or "non-participation payoff") rather than "terminal disagreement payoff", with the two events in which it is received stated once; mark the y + o_θ cell of Table 1 as majority-only.

6. **Give the decomposition a headline (D5).** Add a Corollary after Prop 4.7 with the sign statement; move the knife-edge mixture (boundary o₁ = 1/m, single belief ν̂ = k/(o₁ − o₀)) to one remark in C.2 and remove it from the statements of 4.3, 4.5, 4.6, 4.7; move the permutation-multiplicity sentences of 4.3 to a remark; define V_g^{ι} in a displayed definition at the start of §4.5.

7. **Make the examples carry the mechanism (D9, D7).** Rewrite §2 around the Figure 2B comparison (two substitute votes at 0.225 each versus H's 0.315 plus three floors of 0.146); add ν = 0.285 to C.3 to exhibit the (ν*, ν_SE] window where ΔRI = (0.225, 0.035) and both types gain; add one parameter point with o₀ > βo₁ so that k < 0 appears; in Figure 3 state the slice in the caption and add a slice (or an o₀/o₁ axis) where the low-type "H prefers majority" region is visible; define "relative hegemonic strength" or relabel the axis; remove the polygon seam at m·o₁ ≈ 1.3.

8. **Proof formatting (D6).** Numbered steps in B.1, B.3, B.4; spell out the two-sentence derivation of the five cases in B.3; replace "atomic" (l. 1031) with "a single segment indexed by λ"; tabulate the completeness conditions in B.4; "respondent" → "responder" (l. 831).

9. **Parsimony in the model section (D2).** Drop ȳ (l. 161), relegate b_θ (l. 167–170) to a footnote, delete h^Y, h^N, C_H(h^a) from Table 1 (replace the two cells with "continuation, see §4"), and move the two equilibrium statements at l. 165 and l. 187–189 out of the model description (A.1 already contains the second). Add Section 2 to the roadmap (l. 115–121).

---

## Parecer completo — Exposição

# Parecer de Exposicao do Modelo (Varian / Thomson / Board)

## Score: 6/10

The skeleton is right: a concrete hook, a numerical example before the model, a short model section, all proofs in the appendix, one footnote in the entire paper, an honest Limits section and a two-paragraph conclusion. The execution of the exposition is where the paper loses points. The headline result arrives last in a seven-proposition staircase, in the least retainable form (a table of vectors indexed by region codes), the abstract contains two typos and a broken sentence, editorial markers survive in the model section, a measure-zero knife-edge case (`o_1 = 1/m`) is given equal billing with the generic results throughout the body, four of five figures and all five tables are never referenced in the text, and the figures carry in-image titles and footnotes that are illegible at print size. None of these is hard to fix; together they make the paper read as a carefully audited derivation log rather than as a paper written for a reader.

## Avaliacao por dimensao

### ME1. Estrutura do paper [Precisa melhorar]

**What works.** The order Introduction → numerical illustration → Model → Results → Discussion → Conclusion → Appendix is the Varian/Board order. The baseline is the whole paper (no extensions), so "baseline before extensions" is satisfied trivially. Proofs are entirely in Appendix B. The Results section opens with a one-paragraph map of the backward-induction order (lines 291–295), which is good practice.

**Position of the main result.** The paper's question is "when can consensus advantage a hegemon over majority ... from private information rather than veto power alone" (lines 53–56). The object that answers it is `ΔRI` in Proposition 4.7, which lands on p. 16 of the compiled PDF, after Propositions 4.1–4.6 (pp. 8–15). Board's threshold is p. 15; the paper misses it narrowly, and the miss is aggravated by how the reader gets there: 4.1 (public) → 4.2 (terminal) → 4.3 (private majority, five cases) → 4.4 (private unanimity) → 4.5 (private contrast) → 4.6 (rents by rule) → 4.7 (difference of differences). Propositions 4.5 and 4.6 are pure stepping stones: each is "subtract two payoff tables componentwise" (Appendix B.5 and B.6 are six and nine lines long, respectively). Three propositions for one subtraction is the opposite of "make your paper look like your talk" (Varian). In a talk the author would show one slide with Figure 4B (the three bars 0.010 / 0.225 / 0.215) and one slide with Table 5; the paper makes the reader climb three propositions to get to that slide.

**Redundant apparatus.** Table 3 restates Proposition 4.1 line by line; Table 4 restates Propositions 4.3 and 4.4 line by line; Table 5 restates Propositions 4.6 and 4.7 line by line. Each pair says the same thing twice on facing pages. Keep the tables (they are easier to read) and shorten the propositions, or the reverse, but not both.

**Layout.** Because every float uses `[H]` (lines 199, 220, 270, 329, 490, 516, 562, 711, 751), LaTeX cannot move figures, and the compiled PDF has roughly 45% of p. 13 blank, 40% of p. 17 blank and more than half of p. 19 blank. The paper is therefore about 1.5 pages longer than its content, and the main result is pushed past p. 15 in part by white space.

**Roadmap.** The roadmap paragraph (lines 115–121) lists Sections 3, 4, 5 and the appendix. Section 2 (the numerical illustration) is never mentioned, there or anywhere else (`#example` has no `\ref`).

### ME2. Introducao [Adequada]

**Hook.** Paragraph 1 opens with Saudi Arabia/OPEC and the United States/WTO (lines 41–46). This is concrete, on the first page, and ends with a puzzle. Good.

**Model content.** Paragraph 3 (lines 65–70) gives agents, actions, information and timing in five sentences. Paragraph 4 (lines 72–79) states the mechanism in plain English ("the difference between a substitute and an essential input"). This is the best prose in the paper and passes Varian's test: the author can explain what the paper is about in a couple of paragraphs.

**Weaknesses.**

1. *The bait-and-switch in paragraph 1.* Lines 46–52 pose a "three-part institutional-design question" (no agenda control, stricter than majority, consensus) and then immediately retreat: "That broader question motivates the paper, but the model holds the institutional rule fixed. We address a narrower theoretical puzzle". Two of the three parts ("why accept a rule stricter than majority" and "why insist on consensus") are the same question. State the narrow puzzle directly and keep the three-part framing, if at all, for the Discussion.

2. *The results preview is a case list.* Paragraph 5 (lines 81–93) is the paragraph a reader should be able to repeat afterward, and it cannot be repeated: "it is positive for the low type when majority screens and also benefits the high type when public majority would exclude it, is zero when majority already pools, and can have either sign when private majority excludes." This is the laundry-list problem Board warns against, transposed from implications to cases. One retainable sentence would do: *when the high type is likely enough, unanimity pays the low type the high type's price; majority pays that price only when it has no cheaper coalition, and for intermediate beliefs the unanimity game has no pure-strategy equilibrium at all.* The case table belongs in Section 4.

3. *Imprecision.* Line 77: "The resulting rent is frequently attached to pooling rather than to separation." In the model it is always attached to pooling: the only interior unanimity equilibrium is pooling (Prop. 4.4). "Frequently" is a word for an empirical paper.

4. *A sentence that does not parse as paper prose.* Lines 103–104: "Their mechanisms and results receive full priority as the nearest points of comparison." This reads like a note to a referee about priority claims. Say what those papers do and what this paper does differently in one sentence each.

5. Structure puzzle → model and intuition → literature is followed; the literature paragraphs (95–113) are short and integrated. No excessive motivation of the topic's importance. Those are genuine strengths.

### ME3. Escrita e estilo [Precisa melhorar]

Checklist with examples:

- **Short sentences (Thomson):** Yes, almost uniformly. The problem is the opposite one: sentences are short but carry undefined abstractions. "Three declared disciplines" (line 251), "structural consistency" (line 255; Appendix A.2 only says "subject to structural consistency across histories that encode the same information", which does not define it), "the payoff set and outcome set remain atomic" (B.5; "atomic" is not a standard term here; "a single segment" is meant), "cross-date quantity" for `k` (line ~535), "the linked segment" (Table 4), "common proposal weight" (Prop. 4.3 last sentence). A reader outside bargaining theory will not recover these.

- **No sentence starting with a symbol:** Two violations, both in the appendix: Appendix B.1, first paragraph, "H is nonpivotal and strictly votes no because no yields y+o rather than y"; Appendix A.2, last paragraph, "H maximizes its type-contingent continuation payoff and votes yes at exact indifference." The body is clean.

- **Voice and tense:** Consistent ("we", present tense).

- **"Put the tedious stuff in the appendix" (Varian):** Not followed in three places. (i) Section 3.3, second paragraph (lines 260–268): never-dissuaded discipline, Osborne–Rubinstein, tremble consistency, Kreps–Wilson. One sentence in the body ("a type the prior rules out is never resurrected by an off-path action; Appendix A.2 states the condition") and the rest in A.2. (ii) The `o_1 = 1/m` knife-edge: Prop. 4.3 item 5, the paragraph at lines ~434–438 ("It is not a license to combine componentwise minima and maxima into an unattained rectangle"), Prop. 4.5 item 4, the last sentence of Prop. 4.6, the last sentence of Prop. 4.7, two rows of Table 5, the `λ` sentence after Table 5, and Appendix C.2. A measure-zero tie occupies roughly a page of the main text. (iii) Lines 183–189 (the `y + o_θ` branch and why equilibrium exclusion sets `y = 0`) are repeated nearly verbatim in Appendix A.1, second paragraph. Choose one location.

- **Reviewer-facing prose in the body.** Several sentences are written to pre-empt an objection rather than to inform a reader: "It is not a license to combine componentwise minima and maxima into an unattained rectangle" (line ~437); "It does not supply a payoff for institutional comparison and does not justify filling the gap by interpolation" (Discussion 5.1); "without recombining types or selecting among multiple equilibria" (Figure 4 caption); the Remark on pure-strategy scope, the Limits paragraph and the Figure 5 in-image note all repeat "we make no claim about mixed strategies". The disclaimer "not an empirical calibration / not an estimate / do not average over parameter values" appears four times (lines 135, 768, 1120, and the Figure 4 note). One statement per claim is enough.

- **Unused notation (Thomson):** `\bar y` is introduced at lines 158–161 and never binds or reappears outside the notation table. `b_θ` is introduced at line 167 only to be set to zero. Both can be footnoted or dropped.

- **Terminology:** "weak responder" (27 occurrences) versus "weak respondent" (Appendix A.1, once). The region codes II / IX / XX (lines ~590–597) are explained only as "The labels only record whether each public type is included by majority"; the reader must infer that the first letter is the low type, the second the high type, I = included, X = excluded. Say it.

- **Lines 387–394:** "the proposer's payoffs from the three undominated outcome classes" is followed by four displayed quantities (`E`, `L`, `S(ν)`, `P`). `L` is an auxiliary, not a class; say so.

- **"Not X but Y" constructions:** line 739 ("The answer is not simply that private information always benefits a hegemon") and line 774 ("The relevant observable contrast is not merely whether the hegemon is included, but whether majority would provide a cheaper coalition"). Both can be stated directly: "Private information benefits the hegemon only when ..."; "The observable implication is that concessions to the hegemon should be larger where no cheaper uninformed coalition exists."

- **Footnotes:** One in the whole paper. Exemplary.

- **Appendix narrative:** B.1–B.6 read as prose proofs, not symbol dumps; B.4 gives the enumeration of the four profiles clearly. C.1 and C.3 are narrative. C.2 is defensive (see above). Appendix D (notation table) is good practice.

- **Copy-editing (abstract and body):**
  - Abstract: "hegemeon" → "hegemon"; "approvaed" → "approved"; "In order to isolate differential of information between hegemeon and weak states, we model ..." is ungrammatical ("To isolate the informational asymmetry between the hegemon and the weak states, we model ..."); "the hegemon private threshold" → "the hegemon's private threshold".
  - Line 169: "[AUTHOR: P2]" and line 196: "[AUTHOR: P1]" are residual editorial markers in the model section.
  - Figure 4 in-image note: "working numerical illustration of the exact N7 formulas" — "N7" is an internal project node label with no meaning to a reader.
  - Figure 5 caption (lines 754–757): "Historical annotations, if used, are illustrations rather than empirical tests" — the figure contains no historical annotations; the caption was written for a version that does not exist.
  - Figures 2–5, in-image labels: "nu", "nu_SE", "nu*", "beta", "o0", "o1", "m x o1", "h - ell", "RI_M", "RI_U", "DeltaRI" in ASCII, while the text uses `ν`, `ν_{SE}`, `β`, `o_0`, `ℓ`, `RI_M`, `ΔRI`. Use `expression()` or `latex2exp` in the ggplot code.
  - Figure 4, Panel A legend: "Voting rule" keys are squares while the plotted marks are circles and triangles; the colour is what distinguishes the rule, so the legend should use the same glyphs.

### ME4. Extensao e quando parar [Longo]

The absolute length is moderate: 21 pages of body at 1.5 spacing and 12 pt corresponds to roughly 12–13 journal pages, plus 8 pages of appendix. The paper is long relative to its content rather than in pages. Approximately three pages can be removed without losing a single result:

- Table 3, Table 4 or the proposition text they duplicate (about 1 page).
- The `o_1 = 1/m` segment material in the body, moved to one appendix subsection (about 0.7 page).
- Figure 5, which is the right-hand panel of Figure 2A redrawn with a different title (about 0.5 page), and the duplicated `y + o_θ` paragraph.
- The white space created by `[H]` (about 1.5 pages).

The mechanism ("under majority the proposer can buy a substitute; under unanimity the hegemon's vote is an essential input") is stated in full three times: intro paragraph 4, Discussion 5.1 paragraph 1, Conclusion paragraph 1. Tell-say-tell is acceptable, but Discussion 5.1 adds no interpretation beyond Section 4's sign-pattern paragraph (lines ~693–703), which is already the clearest statement of the result in the paper. "Once you've made your point, stop" applies to 5.1.

Extensions: none, which is defensible for a baseline paper; the Limits section (5.3) lists the omissions honestly. Mechanical proofs are in the appendix: yes. "People remember about 10 pages": the ten pages a reader would remember here are pp. 2–3 (intro), 9–11 (the two private correspondences) and 16–17 (`ΔRI`); the paper's job is to make those pages contiguous and legible, which the suggestions below address.

### ME5. Uso de exemplos e intuicao [Adequado]

**Motivating example before the model (Varian):** present, Section 2, and the placement is correct. But it illustrates the least interesting piece of the model: only the terminal-round unanimity cutoff `ν^* = 0.2778` (a one-round screening-versus-pooling trade-off that any reader of this literature already knows), and it ends by admitting that "The full two-round game adds the option to buy weak-state votes and the continuation created by a failed first ballot" (lines 136–137), which is precisely the mechanism the paper is about. Meanwhile the example that does carry the mechanism is hidden in Appendix C.3: at `ν = 0.80`, majority buys two weak votes at `β/m = 0.225` each and leaves the hegemon with `o_0 = 0.10`; unanimity must pay `βo_1 = 0.315` to either type; a low type therefore gains `0.215` from consensus. Those four numbers are the paper. They should be in Section 2, together with Figure 2B, and the reader should meet `ν^*` only afterwards.

**Every result explained in simple English (Board):** Mostly. Prop. 4.1 (tie-break sentence, lines 350–352), Prop. 4.2 (line 377–379, "no discount factor appears inside this terminal comparison"), Prop. 4.4 (the paragraph at lines 452–456 explaining why no pure profile survives) and Prop. 4.7 (the sign-pattern paragraph) are each followed or preceded by a plain-language account. Prop. 4.3 is the exception: the cutoffs `ν_{SE}` and `ν_{SP}` are displayed as formulas with no verbal content, and the text before the proposition describes the three coalitions but never says *why* screening wins at low `ν` (the proposer risks delay only with probability `ν`, and delay costs it `1 − βq/m`) and exclusion or pooling at high `ν`. One sentence each would suffice.

**Substantive interpretation of the non-existence result is missing.** For `0 < ν ≤ ν^*` the paper says the contrast is "empty" and, in the Discussion, that the cell "records the failure of every pure voting pattern". A non-technical reader needs to know what this means for OPEC: when members think Saudi Arabia is probably weak but cannot be sure, no stable pattern of acceptance and rejection exists, because any package the weak type would accept invites it to imitate the strong type's refusal. That sentence exists in technical form in Section 4.4 and nowhere in interpretive form.

**Geometric over numerical (Thomson):** Figure 3 is a genuine region diagram in `(ν, m·o_1)` space and is the right kind of object. Two problems: the caption never explains the vertical axis (`m·o_1 = 1` is the point at which a known high type costs exactly as much as a substitute weak vote) or the slice `o_0 = 0.5·o_1`, which is a strong restriction mentioned only in the in-image subtitle; and the hatched "no comparison" region is the largest visual element, so the figure's first impression is that the model is silent over most of the parameter space. If that is the intended message, the text should say so; if not, shade the undefined region lightly and let the coloured regions carry the eye.

**Figures as intuition devices for a non-technical reader:**
- Figure 1 (timing flowchart): correct but trivial; it shows nothing a reader could not infer from lines 150–154. Harmless at its current size.
- Figure 2B (pie anatomy: "Under majority the pie buys substitutes; under unanimity it buys the hegemon") is the single best intuition device in the paper and is the panel a non-specialist would understand immediately. It is rendered as the lower half of a two-panel figure at p. 12 with labels that are unreadable at print size. Promote it to its own figure next to the Section 2 example.
- Figure 4 (decomposition at one point) is simple and effective; Panel B's three bars are the result in one glance.
- Figure 5 is an orphan: it is never referenced in the text, it repeats the unanimity panel of Figure 2A, the "Read hegemonic decline from right to left" framing appears nowhere in Sections 5.1–5.2, and its caption refers to annotations that do not exist. Either cut it or write the decline narrative it is waiting for (as beliefs about Saudi spare capacity fall, the pooling rent persists until `ν^*` and then the pure-strategy equilibrium structure breaks down).
- All figures: the in-image titles, subtitles and multi-line footnotes duplicate the LaTeX captions and become 5–6 pt text in the PDF (pp. 12, 14, 18, 20). Strip them from the images and put the content in the captions, which are typeset legibly.

**Special cases as examples:** the `ν = 0` endpoint is used well as a limiting case (Section 4.4 and C.1).

## Veredicto geral sobre exposicao

This is a carefully disciplined derivation presented as if the reader were an auditor. The introduction's hook and mechanism paragraphs show that the author can write for a reader; the Results section then abandons that reader for nine pages of correspondences, region codes and knife-edge caveats, and the headline (a low type paid the high type's price because no substitute coalition exists; zero when majority also pools; undefined in a middle band of beliefs) is never stated in one place in one sentence with one number. The fixes are editorial, not mathematical: move the worked example and the pie figure to the front, collapse the three subtraction propositions into one result with its table, banish the `o_1 = 1/m` segment to the appendix, cite every figure and table, make the figures legible, and clean the abstract. With those changes the same content would read as a paper whose result a referee can repeat after one pass.

## Top 5 sugestoes de melhoria

1. **Put the headline result where a reader can find it, and in a form a reader can retain.** (a) Replace intro paragraph 5 (lines 81–93) with one sentence stating the result and one sentence stating the empty band, and move the case enumeration to Section 4. (b) Collapse Propositions 4.5–4.7 into a single "Main result" proposition stated as Table 5 (currently pp. 16–17), placed at the start of Section 4.5, with Propositions 4.1–4.4 presented as the inputs that produce it; B.5 and B.6 can stay as they are. (c) Move every appearance of the `o_1 = 1/m` exclusion–pooling segment (Prop. 4.3 item 5; the "unattained rectangle" paragraph at lines ~434–438; Prop. 4.5 item 4; the last sentences of Props. 4.6 and 4.7; the two segment rows of Table 5 and the `λ` sentence after it; Appendix C.2) into one appendix subsection, leaving a single body sentence: "At the knife-edge `o_1 = 1/m`, exclusion and pooling tie and a segment of proposals survives; Appendix C.2 reports it."

2. **Fix the abstract and remove residual markers before anything else is read.** Rewrite sentence 2 as "To isolate the informational asymmetry between the hegemon and the weak states, we study a two-round bargaining game in which only weak states propose and the hegemon privately knows its outside option, comparing unanimity and majority rule under identical primitives." Correct "hegemeon", "approvaed" and "the hegemon private threshold". Replace the abstract's second-half case list with the one-sentence statement from suggestion 1. Delete "[AUTHOR: P2]" (line 169) and "[AUTHOR: P1]" (line 196), keeping the explanatory sentences that follow them. Delete "N7" from the Figure 4 note and the "Historical annotations, if used" sentence from the Figure 5 caption.

3. **Make Section 2 illustrate the mechanism, not the terminal cutoff.** Move Appendix C.3 to Section 2 and lead with the numbers: with four weak states, `β = 0.9`, `o_0 = 0.10`, `o_1 = 0.35` and `ν = 0.80`, a majority proposer buys two weak votes at `0.225` each and leaves the hegemon outside with `0.10` if weak and `0.35` if strong; a unanimity proposer must pay `0.315` to whichever type it faces, so a weak hegemon gains `0.215` from consensus while a strong one loses `0.035`. Put Figure 2B (the stacked pie bars) beside these numbers as its own figure. Introduce `ν^*` afterwards as the belief below which the unanimity proposer would rather gamble on the weak type, and note that in that band no pure-strategy equilibrium exists. The current Section 2 computes `ν^* = 0.2778` and stops exactly where the paper's contribution begins.

4. **Make every figure earn its place and be legible.** Reference Figures 1, 2, 4 and 5 and Tables 1–5 in the text (at present only Figure 3 is cited: line 559). Strip in-image titles, subtitles and footnotes from `figure_f1`–`figure_f4` and carry that content in the LaTeX captions; replace ASCII labels with typeset symbols (`ν`, `β`, `o_0`, `o_1`, `m·o_1`, `h − ℓ`, `RI_M`, `ΔRI`). Explain in Figure 3's caption that the vertical axis is the high type's outside option relative to the price of a substitute vote (`m·o_1 = 1` is the inclusion threshold) and that the panel is the slice `o_0 = 0.5·o_1`. Cut Figure 5 or anchor it with a "hegemonic decline" paragraph in Section 5.2. Change `[H]` to `[t]` or `[htbp]` on all nine floats to remove the blank half-pages at pp. 13, 17 and 19.

5. **Deduplicate and convert reviewer-facing sentences into reader-facing ones.** Drop Table 3 or shorten Proposition 4.1 to the `p_M`, `p_U` display; drop Table 4 or shorten Propositions 4.3–4.4 to a pointer to it. Delete lines 183–189 or Appendix A.1 paragraph 2 (they are the same paragraph). Reduce the four "not a calibration" disclaimers to the one in Section 2. Rewrite "Their mechanisms and results receive full priority as the nearest points of comparison" (lines 103–104) as a one-sentence contrast with Piazolo and Vanberg (2025) and Glynia et al. (2026). Define the II/IX/XX codes explicitly (first letter low type, second high type, I = included, X = excluded under complete information). Define "structural consistency" in A.2 or drop the term from the body. Add one interpretive sentence to Discussion 5.1 on what the empty cell means for OPEC (see ME5), and sharpen Section 5.2 into one observable comparative statement rather than the current "not merely ... but" formulation at line 774.
