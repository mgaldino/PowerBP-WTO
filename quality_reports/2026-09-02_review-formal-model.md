# Carta Editorial — Revisao de Modelo Formal

**Manuscript:** `formal_model_v6.Rmd` (2,648 lines; compiled PDF 67 pages), "Power and Its Shadow: When Unanimity Serves the Hegemon"
**Date:** 2026-09-02
**Skill:** `review-formal-model` (three independent read-only reviewers + editor synthesis)
**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)
**Git state at review:** branch `main`, HEAD `a4e67d8`, clean worktree. No files were edited by any reviewer.

---

## Decisao: R&R major

As submitted, a top-journal editor would most likely return this manuscript without external review. The baseline model (Sections 4–5, Appendices A–D) is publishable-grade work; the manuscript wrapped around it is not yet a paper. The decision is R&R major rather than Reject-and-Resubmit because the required changes are overwhelmingly subtractive and editorial, and because the one substantive gap (proofs missing for Appendix E.2–E.3) has a clear repair path. It is R&R major rather than minor because the extension's unproved claims, the leaked verification vocabulary, and the unreadable abstract each independently disqualify the current bytes from submission.

## Scores consolidados

| Dimensao              | Score | Rating                                  |
|-----------------------|-------|-----------------------------------------|
| Design do modelo      | 6/10  | Sound core, conditional answer          |
| Apresentacao tecnica  | 5/10  | Baseline good; extension unproved, notation collides |
| Exposicao             | 5/10  | Strong hook; pipeline jargon; extension buries the result |
| **Global**            | **5.5/10** | **R&R major**                        |

## Sintese editorial

All three reviewers converge on the same diagnosis from three different angles, which is the strongest signal this review produces.

**Principal strength.** The baseline is a well-isolated model of a real, transferable force. Switching off recognition (the Kalandrakis channel), solving the public-type benchmark first, and then subtracting it type by type gives a clean within-model identification of what private information adds under each approval rule. The incidence result is the paper's best finding and is stated crisply in the text: consensus pays the informational rent to the type whose strength is *overstated*, while the genuinely strong type never gains from unanimity in the baseline and, under exclusion, strictly prefers to be replaceable. The introduction's WTO hook, the integrated literature section, zero footnotes, and Appendix B's prose-dominant proofs with a numbered nonexistence argument (B.4) are all above the field's median.

**Principal weakness.** Roughly 40 percent of the manuscript (Section 6 plus Appendices E–F) is written for the author's verification pipeline rather than for a reader, and it does not meet the paper's own standard. Concretely, and independently flagged by at least two of the three reviewers:

1. Appendix E asserts necessary-and-sufficient characterizations, existence claims, and "no third family" claims with no proof in the manuscript; F.3 states outright that those conclusions "come from the textual proofs fixed by the source manifests," i.e., outside the paper.
2. Section 6 contains zero numbered propositions, so the paper's second contribution cannot be cited.
3. Internal workflow vocabulary appears throughout: `[AUTHOR: P1]` (line 356), "M/S/B" (never expanded), "frozen", "fiber", "binder", "record", "Reynolds average", "N7", "source manifests", "later external consultation", "six later advisory corollaries", plus a dangling "than OPEC" (line ~1233) and "OMC" (line 78).
4. Notation collides across baseline and extension (`W`, `D`, `A`, `λ`, `u`, `v`, `g`, subscript `E`), and two symbol families name the price of a weak vote (`w` vs `r`).
5. The abstract is unreadable to the target audience and contains `T = D + I` with undefined symbols.

**Where the dimensions reinforce each other.** The design reviewer's concern that the extension breaks "one paper, one model" is the same fact the writing reviewer sees as unproved characterizations and the exposition reviewer sees as 25 pages that bury the contribution. Cutting the extension to its four signed results (public gap sign boundary at `βo = e/m`; `D_U = 1−β`; the selection-free majority-advantage region `βh < e/m`; unanimity incidence `IR_U^A(ℓ) ≥ 0 ≥ IR_U^A(h)`) resolves all three at once.

**Where they diverge.** The design reviewer treats the empty cell `0 < p ≤ p*` as a design flaw ("the model is silent exactly where the trade-off lives") and proposes diagnosing which maintained convention drives it. The writing and exposition reviewers treat it as a legitimate result that is simply under-motivated (the pure-ballot restriction and the tie-break against `H` receive no justification) and under-disclosed (absent from the introduction). The editor's view is below.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

The design is strong enough to justify investing in presentation and exposition. It is not the bottleneck. The bottleneck is that the manuscript currently exposes the scaffolding Dixit says the finished model should hide, and it does so in the abstract, the body, and the appendices alike. A referee will judge the paper by its worst pages, and its worst pages are Appendices E–F.

Two design-level points do require an authorial decision rather than an edit:

- **The empty cell.** Under the project's approved solution concept (decision of 2026-08-21, with the 2026-09-01 addendum), nonexistence on `0 < p ≤ p*` is a derived result, not a modeling choice the author can change without re-opening that decision. The design reviewer's suggestion to alter the tie-break, admit mixed ballots, or give weak states a positive reservation value would each revert an approved foundation (respectively the T^Y convention, the pure-ballot scope, and Fundamento 6's `o_W = 0`). Per the project's operating rule, such reversions must be proposed by name and signed individually. The editor's recommendation is the second branch the design reviewer offers: keep nonexistence as a substantive prediction, but then (a) disclose it in the introduction, (b) motivate the two conventions that drive it in Section 4.3, and (c) either convert Figure 4 into a stated result about instability of consensus under contested strength or cut it.
- **The motivating actor is the high type.** The hook is the US "at the height of American power," but in the baseline the high type never gains from unanimity. The design reviewer's proposed repair is cheap and does not touch any foundation: an ex ante corollary. In the exclusion region, unanimity is preferred before the type is drawn iff `βh > (1−p)ℓ + ph`, i.e., `p < (βh−ℓ)/(h−ℓ)`; combined with `p > p*` this gives a window that is nonempty at the paper's own worked parameters (`p* = 0.278`, upper bound `0.86` at `m=4, β=.9, ℓ=.10, h=.35`). This is one line of algebra and is the paper's answer to its own opening question. It is a comparison, not endogenous rule choice, so it does not conflict with the fixed-rule scope. The author should verify the algebra independently before adopting it.

## Prioridades para revisao

Ordered by impact on publishability.

1. **Bring the proofs of Appendix E.2–E.3 into the manuscript, or scope Section 6 down to what E.5–E.8 and E.11 prove self-containedly.** Delete the F.3 sentence deferring proofs to "source manifests." Either add B.7–B.9 in the B.4 style (enumerate profiles, show each deviation, `□`), or restrict every body claim in Section 6 to the four signed results and mark the full characterizations as "reported without proof; available in a supplementary appendix." The lower bound `V_M^A ≥ v_M^safe` (line ~2076) also needs an argument.

2. **Purge every trace of the verification pipeline from the manuscript.** `[AUTHOR: P1]`; "M/S/B"/"MSB"; "frozen"; "fiber", "binder", "record" (define "linked" once and keep at most "fiber" with a one-line definition in Appendix E); "Reynolds average"; "N7"; "source manifests"; "later external consultation"; "six later advisory corollaries"; "`none` in the source correspondences"; "than OPEC"; "OMC"; the conditional "if used" in the Figure 4 caption. Then rewrite the abstract at about 120 words with no symbols and no sentence about what the analysis "preserves."

3. **Cut Section 6 and Appendices E–F to the four signed results, and number them.** Proposition 8 (public agenda payoffs and the sign of `Δv^A`), Proposition 9 (selection-free majority advantage when `βh < e/m`, with the `m=4` counterexample to necessity in one sentence), Proposition 10 (unanimity rent incidence), Proposition 11 (`T = D + I` stated as a substitution identity, and `T_U ≥ 0` where both arms exist). Binders, signatures, pushforward laws, Minkowski differences, `Q_g`, and the two-layer representation go to a supplementary verification file. Target: Section 6 at 3–4 pages, Appendix E at 4–5 pages. Drop the "factorial design / treatment / control" framing.

4. **Resolve notation collisions and unify the price of a weak vote.** Rename `W(μ)`, the E.2 objects `A_μ`/`D_{o,μ}`/`𝒟_C`/`M_o`, the ballot map `v`, the permutation `g`, the proposal law `λ`, and the ex ante subscript `E`. Define `B` and `A` as arm superscripts in Section 4.4, before their first use in Proposition 1. Derive `w`, `w_ℓ^U`, `w_h^U` as special cases of one function `r_g(o)`.

5. **Make Section 3 show the mechanism, and disclose the empty cell in the introduction.** Promote Appendix C.3's worked values to Section 3 at `p = 0.80`: majority excludes (`IR_M = (0.01, 0)`), unanimity pools (`IR_U = (0.225, 0)`), `ΔIR = (0.215, 0)`. Add one sentence pointing to the empty region. In the introduction, rewrite the second-contribution paragraph without `β, h, e, m`, add the one-sentence intuition for why the *low* type earns the rent, flag the empty cell, and settle on one authorial voice ("I" at lines 109–110, "we" from line 413).

6. **Motivate the two selection conventions and reorder Section 4.3 by decreasing plausibility.** The proposal tie-break against `H` decides every boundary and deserves its lower-bound rationale (any rent found is a floor). The pure-ballot restriction produces the empty cell and deserves one sentence on why proposals may mix but votes may not.

7. **Remove one layer of repetition.** `tab:rents` reprints Propositions 6–7; `tab:privatecorrespondence` reprints Propositions 3–4; Appendix G is a 14-row expansion of Table 1. Keep one of each. Turn `fig:agendagap` Panel A into a real plot of `Δv^A(o)` and Panel B into a table; merge Figure 4 into Figure 2 or cut it.

8. **Consider the ex ante corollary (author's decision).** See the hierarchy section above. Also consider one paragraph of comparative statics in `m` (for `m > 1/ℓ` majority always excludes; `e/m → 1/2` governs the agenda ranking), which is the natural bridge to the cross-section of consensus rules and costs nothing.

## Recomendacao estrategica ao autor

Revise for this tier. Do not reformulate the model. The baseline design would survive a top-journal referee on its own merits; what would not survive is the current manuscript's packaging. Nearly every priority above is subtraction: delete vocabulary, delete redundancy, delete machinery no body claim uses. The one addition that is mandatory is proofs for whatever from E.2–E.3 the author chooses to keep in the paper. The one addition that is strongly advised is the ex ante corollary, because without it the introduction's hook (a confident hegemon choosing consensus) is contradicted by the paper's own Proposition 5.

A practical sequencing: (i) purge and abstract rewrite (one session, mechanical); (ii) decide the scope of Section 6 and cut E–F accordingly; (iii) write the missing proofs for what remains; (iv) renumber, renotate, and rerun the independent formal review on the new candidate bytes. Steps (i)–(ii) should precede any further formal work, because they change what needs proving.

Two cautions. First, several design-reviewer suggestions (mixed ballots, altered tie-break, positive weak-state reservation value, a one-round variant) would revert approved foundations of the project; they are reported here in full as reviewer input, but under the project's rules they can only be adopted by an explicit, named, individually signed reversion. Second, the numerical claims in this letter (the ex ante window bounds, the worked `ΔIR` values) were read from the manuscript and checked by hand once; they are not a substitute for the author's own verification.

---

## Parecer completo — Design do Modelo

# Parecer de Design do Modelo (Dixit / Varian / Board)

## Score: 6/10

## O modelo em uma frase
A two-round Baron–Ferejohn bargaining game in which only symmetric, uninformed weak states propose and a single hegemon privately knows whether its terminal disagreement payoff is low or high; the paper compares majority (where a proposer can replace the hegemon's vote with uninformed weak votes) against unanimity (where the hegemon's informed approval is an essential input), decomposes the hegemon's payoff into a public-type pivotality component and a type-specific informational rent, and then adds a mandatory hegemonic proposal stage to separate agenda power from its "informational shadow."

## Tipo de contribuicao (Board & Meyer-ter-Vehn)
Primarily **isolation of a political force**: the paper switches off recognition power (the Kalandrakis channel, lines 213-220) and asks what the approval rule alone does to the value of the only piece of private information in the game. Secondarily an **important application** (WTO consensus, Steinberg), and a modest **new question** relative to Piazolo–Vanberg and Glynia–Thum–Xefteris: those models keep an informed responder inside every winning coalition, whereas here majority can build a coalition entirely from uninformed voters (lines 95-103, 263-270). It is not a new model class (the protocol is BF with one private type), not a technical contribution (the correspondence bookkeeping in Appendices E-F is defensive rather than enabling), and its empirical predictions are qualitative (lines 1225-1236). The classification is coherent, and the paper states it honestly; the weakness is that the isolated force yields a conditional and, in the central belief region, empty answer.

## Avaliacao por dimensao

### MD1. Qualidade da pergunta [Adequada]

The hook is a genuine puzzle from the world, in Varian's sense: why would the United States build an organization that gives it no formal agenda power and a veto equal to everyone else's (lines 41-49). The Fearon analogy (line 79) tells a non-specialist why a rationalist account is needed. The paper also passes Board's "why care" test in the abstract and conclusion: formal equality can coexist with unequal bargaining power through three channels, and the paper shows that the third one does not require a proposal right (lines 1300-1306).

Three problems with the question as posed.

1. **The rationalist premise in the introduction contradicts the paper's own benchmark.** Lines 69-72 claim that under open rule, equal recognition and unanimity "there is no asymmetry of power and, as a result, no inequality of outcomes." But Proposition \ref{prop:public} gives \(v_U^B(o)=\beta o\): with heterogeneous known outside options, equal recognition already produces unequal payoffs, which is exactly the Miller–Montero–Vanberg point the paper cites at lines 225-231. The puzzle should be stated as "given that asymmetric outside options already generate inequality in BF, what does the approval rule add for an informed actor?" As written, the introduction invites the reader to attribute to the approval rule a result that outside-option heterogeneity alone delivers.

2. **The motivating actor and the beneficiary of the mechanism do not match.** The hook is the United States "at the height of American power" (line 41). In the baseline, the high type never gains from unanimity: \(IR_U^B(h)=0\) everywhere (Proposition \ref{prop:rents}), and under exclusion its payoff contrast is \(-(1-\beta)h<0\) (Proposition \ref{prop:privatecompare}, item 3). The rent goes to "the hegemon whose strength is overstated" (line 119). This is an interesting result, but it means the model, taken literally, predicts that a hegemon confident of its strength should prefer majority. The paper never confronts this tension; the Discussion (lines 1226-1233) retreats to "not ... why the United States created the WTO," which is honest but leaves the hook doing rhetorical work the model does not support. A design fix is available and cheap: evaluate the rule comparison ex ante, before the type is drawn. In the exclusion region, unanimity is preferred ex ante iff \(\beta h>(1-p)\ell+ph\), i.e. \(p<(\beta h-\ell)/(h-\ell)\), which combined with \(p>p^*\) gives a nonempty window under a stated condition. That window would be the paper's answer to its own question. The agenda extension computes \(\Delta V_E^A\) ex ante (line ~1055); the baseline does not.

3. **New intuition versus formalization is only partially demarcated.** The paper is exemplary in crediting neighbors for the mechanisms it does not own (lines 254-262: signaling value of rejection to Piazolo–Vanberg, insurance to Glynia et al.; lines 225-231: public-type essential input to Miller et al.). What is genuinely new is stated at lines 263-270 (the on-off switch and the type-specific decomposition). The paper should also acknowledge that the informal version of the "switch" intuition (majority lets proposers route around a costly veto player) is already articulated in the veto-players and legislative-bargaining literatures cited at line 223; the contribution is showing what that switch does to the value of private information, and the text at line 113 ("first contribution is to show that the voting rule determines whether the hegemon's private information has any bargaining value at all") is the right claim, but the introduction should say explicitly that the coalition-substitution idea is inherited and the informational consequence is the addition.

### MD2. Simplicidade e KISS [Precisa simplificar]

The **baseline** is stark and well chosen: two types, two rounds, fixed unit pie, \(o_W=0\), no intrinsic agreement benefit (lines 302-357). Table \ref{tab:scope} (lines 435-449) states the whole model in half a page, which passes Board's four-page test. The assumption that \(H\)'s exit costs the weak states nothing (fixed pie, line 324-327) is the Schelling-type simplification that makes the mechanism visible: the only thing that distinguishes the hegemon is a privately known outside option, so any payoff advantage is attributable to pivotality plus information.

Three design costs undercut the simplicity.

1. **The model is empty where the interesting trade-off lives.** For \(0<p\leq p^*\) private unanimity has no pure-ballot PBE (Proposition \ref{prop:unanimity}). This is precisely the screening region, the one where a proposer would trade off a cheap low offer against the risk of a strong-type veto. The paper elevates the emptiness to a scope statement ("equally important for scope," line 1205) and keeps it in every downstream object (\(IR_U^B\), \(\Delta IR^B\), \(T_U\), \(Q_U\), all \(\varnothing\) on the same interval). From a Dixit/Varian perspective, a model whose central comparative static is undefined on an open interval in the middle of the parameter space is not yet the simplest model that works; it is a model whose solution concept is one convention away from working. The nonexistence proof (B.4, items 1-4) turns on the indifference-to-yes convention (item 2) and on the low type's ability to imitate a no vote at \(s^\dagger\). The author should either (a) find the minimal modification that restores existence in that cell (mixed ballots, a proposal-space restriction, a different tie-break at exact indifference, or a positive weak-state disagreement value that removes the exact indifference), and report which one is load-bearing, or (b) argue on substantive grounds that nonexistence is itself the prediction (instability of consensus when strength is genuinely contested), in which case Figure \ref{fig:decline} should be a result and not a schematic.

2. **Is the second round load-bearing?** Removing Round 1 leaves the terminal game, where the on-off switch already appears in full: terminal majority sets \(x_H=0\) and pays \(H\) its outside option; terminal unanimity screens or pools at \(p^*\) (Proposition \ref{prop:terminal}). Round 1 adds two things: the \(1/m\) inclusion threshold under majority (because weak votes now have a continuation price \(\beta/m\)) and the timing wedge \((1-\beta)o\). The same inclusion threshold would arise in a one-round model with a positive weak-state reservation value \(c\), without the empty cell and without the structural-consistency apparatus of Appendix A.2. The paper's justification for two rounds is one sentence (lines 294-296). Under the Schelling–Spence test, the author should state what disappears in the static version. If the answer is "the timing wedge and the BF fidelity," that is a legitimate reason, but it has to be argued, because the second round is what generates the empty cell and most of the belief machinery.

3. **The agenda extension violates "one paper, one model."** Section \ref{agendaextension} plus Appendices E-F occupy roughly as many lines as the baseline and its proofs combined. They introduce a second off-path convention (\(\rho\), lines 1810-1818, explicitly "stronger than" A.2), binders \(R_M\) and \(R_U\) with ten coordinates each (lines ~1905, ~1985), a two-layer signature representation (lines ~2085-2105, F.1), Minkowski differences of correspondences (F.2), and a diagonal contrast \(Q_g\) whose stated purpose is that it "is not a causal effect" (E.14). The economic content that survives is small and crisp: \(D_U=1-\beta\); the public gap \(\Delta v^A\) changes sign at \(\beta o=e/m\); the selection-free majority-advantage region \(\beta h<e/m\); and the incidence result \(IR_U^A(\ell)\geq0\geq IR_U^A(h)\). Everything else is set-valued with "no general sign imposed" (lines 1127, 1150). Board's rule is that a second model belongs in a second paper unless it changes the reader's understanding of the first; here it mostly demonstrates that adding agenda power makes the answer even more conditional. The main text should keep the four crisp results and one figure; the correspondence machinery belongs in an online appendix or a separate methodological note.

4. **Process artifacts have leaked into the manuscript.** Line 356 contains "[AUTHOR: P1]". Line ~2285 reads "no stronger global classification from the later external consultation is promoted here"; F.4 reads "We do not promote the six later advisory corollaries to frozen theorems"; F.3 refers to "mechanical scripts check hashes, schemas" and "source manifests"; the word "frozen" appears throughout E and F as a term of art. A reader cannot know what a "frozen" continuation or an "advisory corollary" is. These are records of the author's verification workflow, not model content, and they signal a first-draft integration rather than a finished design.

### MD3. Isolamento do mecanismo [Adequado]

The isolation strategy is the paper's best design decision. Three moves do the work. First, \(\pi_H=0\) removes the Kalandrakis channel by construction (lines 213-220, 310-311). Second, the public-type benchmark is solved first, so the "power" component (pivotality with a known price) is netted out before information is added (lines 465-470, Proposition \ref{prop:public}). Third, the difference-of-differences \(\Delta IR^B=IR_U^B-IR_M^B\) (lines 738-745) attributes to the approval rule only what private information changes within each rule. This is a clean identification design inside the model, and Figure \ref{fig:rents} communicates it.

The isolation is partial for two reasons.

1. **Conventions do mechanism work at the boundaries and in the empty cell.** The proposal tie-break "minimizes \(H\)'s expected payoff" (lines 420-422), the indifference-to-yes rule, and as-if-pivotal voting jointly select inclusion at \(o=1/m\), the low offer at \(p=p^*\), screening at every screening tie, and, as noted, drive nonexistence for \(0<p\leq p^*\). Boundary selections are harmless. Nonexistence on an open interval is not: it means the maintained conventions, not the substitutability of the hegemon's vote, determine what the model says in the screening region. The author should state which of the three disciplines is necessary for the empty cell and whether the mechanism (rent through pooling for \(p>p^*\), zero rent under exclusion) survives its removal.

2. **The "hegemon" is a hegemon by outside option only.** By Fundamento 6/8 of the project, the pie is fixed and \(H\)'s exit costs the weak states nothing. This is the right stark assumption for isolating pivotality, and the Limits section says so (lines 1250-1253). But the Discussion and Conclusion should say explicitly that the market-size channel Steinberg emphasizes (Table \ref{tab:steinbergfull}, row "Market size") is deliberately shut, and announce the pie-dependence extension as future work; otherwise a reader will read "hegemon" as carrying more than a forum-shopping outside option and will over-attribute the results.

The minimal-structure question (Dixit on Diamond's two generations) is answered well for types (two) and states (\(m\geq3\), needed for \(k\leq m-1\), B.1) but not for rounds (see MD2).

### MD4. Riqueza de insights [Adequada]

The model does generate results beyond the headline.

- **The rent goes to contested strength, not to strength.** \(IR_U^B=(\beta(h-\ell),0)\) for \(p>p^*\): consensus pays the low type the high type's price. This is the paper's most transferable insight (any veto player whose reservation value is uncertain to those who must buy its vote: a median-court justice, a coalition-formateur's pivotal partner, a ratifying legislature) and it is stated crisply at lines 118-119 and 1197-1202.
- **The timing wedge reverses the ranking for the strong type.** Under exclusion, majority pays \(h\) now while unanimity pays \(\beta h\) later, so the high type strictly prefers to be replaceable (Proposition \ref{prop:privatecompare}, item 3). This is counterintuitive and underexploited: it says the strongest hegemons should be the ones least attached to consensus, a claim with observable content (US behavior in plurilateral versus consensus forums).
- **Observable signature.** Pooling yields smooth agreement with over-concession, whereas signaling models predict visible delay (lines 1225-1236, 1268-1270). This is a genuine discriminating prediction against Piazolo–Vanberg.
- **Agenda has an informational shadow.** \(D_U=1-\beta\) but \(I_U\leq0\) in high-prior fibers (F.2), and \(\beta h<e/m\) makes majority dominate both types (E.5). The "power buys a proposer rent but erodes information rent" insight is good and would survive a much shorter extension.

What is missing.

- **Comparative statics in \(m\).** The number of weak states is the natural institutional variable (GATT 23 members, WTO 160+). The inclusion threshold is \(1/m\), so as \(m\) grows majority always excludes and the contrast collapses to \((\beta h-\ell,-(1-\beta)h)\); the excluded fraction \(e/m\) governs the agenda ranking. The paper never states a single result in \(m\) in the main text. This is the cheapest source of additional insight and a direct bridge to Gould (2022) on the cross-section of consensus rules, whom the project cites but the manuscript does not use.
- **Comparative statics in \(\beta\).** Patience enters every wedge; the paper notes only that \(p^*\) is \(\beta\)-free (line 556).
- **Welfare of the weak states** appears only implicitly (proposer residuals in Table \ref{tab:publicgames}). Since the puzzle is why weak states would accept a rule that transfers rent to the hegemon, a one-line statement of what the weak side gains from consensus (insurance against \(H\)'s exit? nothing, given the fixed pie?) would sharpen the design or expose that the fixed pie makes weak states indifferent to \(H\)'s presence, which is the extension the project has already flagged.

### MD5. Tipo de contribuicao [Isolation of a political force; adequate but conditional]

Board and Meyer-ter-Vehn distinguish contributions by what the reader takes away. Here the takeaway is: "the approval rule is an on-off switch for the value of one actor's private information, and consensus pays informational rent to the type whose strength is overstated." That is a clean, transferable force. Its value is reduced by three things: the empty cell makes the switch undefined in the region where it would matter most; the ranking is type-conditional and region-conditional (five majority cases, three unanimity cells, Table \ref{tab:privatecorrespondence}) so no single proposition summarizes the force; and the agenda extension concludes that "neither has a universal institutional sign" (line 1309). A paper that isolates a force must show that the force has a sign under stated conditions. The baseline does this for the low type above \(p^*\) and for the zero-rent result under exclusion; those two should be the theorems, and everything set-valued should be demoted to remarks.

### MD6. Processo de construcao [Adequado]

Evidence of good process: public types before private types (lines 465-470); terminal round before Round 1; endpoints checked against complete-information games (C.1); worked values in C.3 that exhibit exactly the case the paper cares about (low type included, high type excluded, \(\Delta IR^B=(0.215,0)\)); numerical reversal in Figure \ref{fig:agendagap} Panel B. The model has clearly been iterated; the decision record behind \(\pi_H=0\), fixed pie, and no opt-out is visible in the assumptions.

Evidence of incomplete process:

- **Section \ref{example} does not work the mechanism.** It computes \(p^*\) for the terminal unanimity round (lines 284-296) and stops. It never shows majority excluding, never shows the rent, never shows the switch. Varian's "work an example" means the example should let the reader see the answer before the general model; C.3 does this and should be promoted to Section 3, with \(m=4\), \(\beta=0.9\), \(\ell=0.10\), \(h=0.35\), \(p=0.80\) carried through both rules.
- **Over-iteration in the appendix.** Appendices E-F read as an audit trail (binders, signatures, "frozen," "manifests," "advisory corollaries," "later external consultation"). This is the opposite of Dixit's advice that the final model should hide the scaffolding. The author knows the difference: the baseline appendices B-C are lean and readable.
- **The [AUTHOR: P1] placeholder** (line 356) and the parked introduction sentence noted in the project files indicate the manuscript is mid-integration.

## Veredicto geral sobre design

The baseline is a well-isolated, stark model of a real and transferable force: consensus removes substitutes for one informed actor's vote, and the value of that actor's private information turns on whether substitutes exist. The public-benchmark decomposition is the right identification design, and the incidence result (rent accrues to the type whose strength is overstated, while the genuinely strong type prefers to be replaceable) is a counterintuitive finding worth a paper. The design is held back by four things, in order of importance. First, the maintained solution concept produces no equilibrium on the screening interval \(0<p\leq p^*\), so the model is silent exactly where the trade-off it was built to study lives; the author treats this as scope, but under Varian's standard it is a signal that the model is not yet the simplest one that works. Second, the motivating hegemon (the US at its peak) is the high type, who never gains from consensus in the baseline; the paper needs either an ex ante rule comparison or a reframing of the hook. Third, the agenda extension roughly doubles the paper, breaks the one-model rule, and delivers mostly sign-free correspondences; four crisp results would carry its entire economic content. Fourth, verification-process residue has leaked into the text. Score 6: the core design is sound and the isolation is above the field's median, but the paper as designed does not yet deliver a signed answer to its own question.

## Sugestoes construtivas

1. **Restate the puzzle so it is not answered by outside-option heterogeneity alone.** Replace the claim at lines 69-72 with: BF with equal recognition and heterogeneous known outside options already yields unequal payoffs (Miller et al.); the open question is what the approval rule adds when the outside option is private. This aligns the hook with Proposition \ref{prop:public}.

2. **Add an ex ante rule-choice corollary to the baseline.** Before the type is drawn, in the exclusion region unanimity is preferred iff \(\beta h>(1-p)\ell+ph\). State the window \(p^*<p<(\beta h-\ell)/(h-\ell)\), the condition for it to be nonempty, and interpret it: a hegemon uncertain of its own future strength, but not too uncertain, accepts consensus. This is the paper's answer to "why would the US create the WTO," and it is one line of algebra away.

3. **Diagnose the empty cell rather than declaring it scope.** Identify the minimal change (mixed ballots; a strictly positive weak-state disagreement value that removes exact indifference; a different tie-break at \(s^\dagger\)) under which a PBE exists on \(0<p\leq p^*\), and report whether the sign of \(\Delta IR^B\) for \(p>p^*\) and the zero-rent exclusion result survive. If nonexistence is to be kept as a substantive prediction, convert Figure \ref{fig:decline} into a proposition about instability of consensus under contested strength.

4. **Run the Schelling–Spence test on the second round.** State in the model section what a one-round game with weak reservation value \(c\) would and would not reproduce (the \(1/m\) switch yes, the timing wedge no, the empty cell no), and justify two rounds by what is lost, not by protocol fidelity alone.

5. **Cut the agenda extension to its four signed results.** Keep \(D_U=1-\beta\); the sign boundary \(\beta o=e/m\) for \(\Delta v^A\); the sufficient region \(\beta h<e/m\) where majority strictly dominates both types; and the incidence \(IR_U^A(\ell)\geq0\geq IR_U^A(h)\). Move binders, signatures, Minkowski differences, \(Q_g\), and the two-layer representation to an online appendix or a separate note. Remove every occurrence of "frozen," "manifest," "hash," "advisory corollary," "later external consultation," and the [AUTHOR: P1] tag from the manuscript.

6. **Promote the worked values of C.3 to Section 3** and carry one parameter point through both rules, showing exclusion under majority, pooling under unanimity, and \(\Delta IR^B=(0.215,0)\), so the reader sees the switch before the general model.

7. **Develop comparative statics in \(m\) and \(\beta\).** State that for \(m>1/\ell\) majority always excludes and the contrast is \((\beta h-\ell,-(1-\beta)h)\); that \(e/m\to1/2\) governs the agenda ranking; and what patience does to each wedge. Connect the \(m\) result to the cross-section of consensus rules in large versus small organizations.

8. **State the weak-state side of the bargain.** Because the pie is fixed, weak states lose nothing from \(H\)'s exit and gain nothing from its membership; say this in the Limits and announce the pie-dependence extension as future work, so the reader does not read "hegemon" as carrying market power the model has switched off.

---

## Parecer completo — Apresentacao Tecnica

# Technical Presentation Review (Thomson / Board)

**Manuscript:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd` (2,648 lines, 67 compiled pages; body lines 37–1336, Appendices A–G lines 1338–2648). Read in full. No files were edited.

## Score: 5 / 10

The body of the paper (Sections 4–5, Appendices A–D) is a competent, mostly Thomson-compliant presentation: canonical ordering, prose-heavy proofs with clear QEDs, one running numerical example, region diagrams. It would score around 7 on its own. The score is pulled down by two structural problems. First, the agenda extension (Section 6 plus Appendices E–F, roughly 40 percent of the manuscript) states its results as displayed equations in running prose without a single numbered proposition, and Appendix E asserts necessary-and-sufficient characterizations, two-family generation results, and "no third family" claims with no proofs in the manuscript; Appendix F.3 says explicitly that those conclusions "come from the textual proofs fixed by the source manifests" (line 2542), that is, outside the paper. Second, the notation of the extension collides repeatedly with the notation of the baseline (`W`, `D`, `A`, `λ`, `u`, `v`, `g`, subscript `E`), and internal workflow vocabulary ("frozen", "M/S/B", "binder", "Reynolds average", "N7", "source manifests", "later external consultation") appears in the text without definition. A reader who does not have access to the project's provenance files cannot decode Appendices E–F.

## Model structure

**Players.** One hegemon `H` and `m ≥ 3` symmetric weak states `W = {1,…,m}` (line 300). **Information.** Nature draws `H`'s terminal disagreement payoff `o ∈ {ℓ,h}`, `0<ℓ<h<1`, privately observed by `H`; common prior `Pr(o=h)=p` (lines 302–307). Weak states hold no private information. **Actions.** In each of two rounds a weak state is recognized uniformly (with replacement) and proposes `x = (x_H,(x_j)_{j∈W}) ∈ 𝒳`, the unit simplex with free disposal (lines 313–320); all non-proposers vote yes/no simultaneously, the vote vector becomes public ex post (lines 331–333). `H` never proposes in the baseline. In the extension, `H` must propose at an earlier date `A` after learning its type (lines 455–464, 892–900). **Preferences.** Linear in own allocation; Round-2 payoffs discounted by `β ∈ (0,1)`; if nothing passes, weak states get zero and `H` gets `o`; if a majority passes without `H`, `H` gets `o` and `x_H` is paid to no one (lines 338–352). **Timing.** Propose → simultaneous ballot → implement or move to Round 2 → propose → ballot → implement or terminal disagreement (Figure `fig:timing`). **Equilibrium.** Perfect Bayesian equilibrium in pure ballot strategies with four declared disciplines: no-signaling by uninformed players plus "structural consistency" for `H`'s zero-probability actions (support-preserving at endpoints), as-if-pivotal weak voting, yes at exact indifference, and a proposal tie-break that minimizes `H`'s expected payoff (lines 414–435, Appendix A.2). The extension adds an off-path likelihood-ratio coordinate `ρ` with posterior `μ^off = pρ/(1−p+pρ)` common to all "undisciplined" proposals (lines 1752–1766).

## Scorecard

| Dimension | Verdict | Comment |
|---|---|---|
| D2. Model presentation | Needs improvement | Canonical order and a good scope table, but the "separate extension" grows a second, far heavier formal apparatus; an editorial marker `[AUTHOR: P1]` survives at line 356; the superscript `B` is used from Proposition 1 onward but defined only at line 1130. |
| D3. Notation | Serious problem | Symbol collisions across baseline and extension (`W` set vs `W(μ)` function; `D_g` effect vs `D_{o,μ}` delay payoff; `A` date/arm vs `A_μ` payoff; `λ` segment weight vs proposal law; `u`, `v`, `g`, subscript `E` each carry two or three meanings); `M/S/B` never expanded. |
| D4. Definitions | Needs improvement | Key terms (screening, pooling, exclusion, fiber, member, record, binder, disciplined proposal, frozen) are defined in passing or not at all; no `definition` environment; no illustrative examples of the set-valued objects. |
| D5. Statement of results | Needs improvement | Propositions 1–7 follow Board's sequence well; the agenda extension has zero numbered results, so the sufficient-condition theorem (E.5), the rent-incidence result (E.9), and the `T_U ≥ 0` result (E.13) are unfindable and unprovable-by-reference. |
| D6. Proofs | Serious problem | Appendix B proofs are prose-dominant with clear QEDs; Appendix E states necessary-and-sufficient characterizations and existence/exhaustiveness claims with no proof, and F.3 defers proofs to external "source manifests". |
| D7. Figures | Adequate | Four real figures are well labeled and geometric; `fig:agendagap` is a formula and a table dressed as a figure; `fig:decline` largely duplicates the right panel of `fig:prices`; no diagram maps the existence cells of the extension. |
| D8. Assumptions and logic | Needs improvement | Scope table is a strong device; the two most consequential disciplines (proposal tie-break against `H`; pure ballot strategies) receive no motivation although they drive selection at every tie and the empty cell. |
| D9. Examples | Needs improvement | Section 3 example previews only terminal unanimity, not the mechanism; three different parameter sets are used across the paper (`h=.35`, `h=.90`, `ℓ=.5,h=.6`). |

## Detailed analysis

### D2. Model presentation — Needs improvement

**Diagnosis.** Sections 4.1–4.4 (lines 298–453) follow Thomson's canonical order and fit in about five compiled pages including two tables and a timing figure. The scope table (`tab:scope`, line 436) is exactly the kind of summary Board recommends. Three problems remain.

1. The manuscript contains an unresolved editorial marker: "A no vote is only a ballot action; it does not remove a player or trigger disagreement by itself. [AUTHOR: P1] The delayed terminal disagreement payoff represents the cost of prolonging international negotiations" (line 355–357).
2. The arm superscript `B` first appears in Proposition 1 as `v_M^B(o)` (line 500) and in `IR_g^B` (line 745), but is defined only in the factorial figure at line 1130 ("Baseline without hegemonic agenda `B`") and in Appendix D. A reader of Section 5 meets an unexplained superscript on every payoff object.
3. Section 4.4 promises a "separate extension" that "gives `H` no option to skip the proposal" (lines 455–464). What arrives in Section 6 and Appendices E–F is a second formal architecture: Borel proposal laws, a common off-path coordinate `ρ`, ten-component "binders" `R_M` and `R_U`, two "layers" `Sig^ex` and `Sum^econ`, and a fiber product `𝒥_A^bind`. Thomson's rule is one model per paper; Board's is that an extension should reuse the baseline's machinery. The extension does neither. The body text of Section 6 (lines 892–1190) is longer than the body text of the baseline results (lines 466–890) and carries no numbered result.

**Impact.** A referee reading Section 5 stops at `v_M^B` to hunt for the definition of `B`. A referee reaching Section 6 cannot tell which claims are theorems and which are definitions.

**Suggestion.** (i) Delete the marker at line 356. (ii) Define `B` and `A` once in Section 4.4 ("we superscript baseline objects by `B` and agenda-stage objects by `A`") and use it from Proposition 1. (iii) Move everything in Section 6 that is definitional (`𝒥_A^bind`, `ΔV_E^A`, the `ρ`/`μ^off` convention) into a short "Extension setup" subsection with the same four headings as Section 4 (players, actions, information, equilibrium), and make the rest of Section 6 a sequence of numbered propositions. Board (2018, §3): the model section should let the reader "guess the results"; the extension section currently lets the reader guess nothing.

**Reference.** Thomson §2 (state the model once, in canonical order); Board & Meyer-ter-Vehn §3 ("one model, stated once").

### D3. Notation — Serious problem

**Diagnosis.** Thomson's test is that notation "can be guessed". The baseline notation passes: `v` versus `V` for public versus private, `IR` for informational rent, `Π_E`, `Π_S`, `Π_P` for exclusion/screening/pooling, `p^*`, `p_{S=E}`, `p_{S=P}`. The extension breaks the test through collisions. Concrete instances, with line numbers:

| Symbol | Meaning 1 | Meaning 2 | Meaning 3 |
|---|---|---|---|
| `W` | set of weak states (line 300) | `W(μ)` weak-state continuation function (line 1496) | — |
| `D` | `D_g(o)` direct agenda effect (lines 1145, 2288) | `D_{χ,o}(μ)`, `D_{o,μ}`, `D_{ℓ,p}` rejection payoffs in E.2 (lines 1779–1783) | `𝒟_C` set of admissible continuation posteriors (line 1874) |
| `A` | date `A` and agenda arm (lines 457, 1130) | `A_χ(μ)`, `A_μ`, `A_p` best passing payoff (lines 1778–1782) | `A_0`, `A_1` in Table `tab:ampure` |
| `λ` | exclusion weight on the residual segment (lines 721, 1625) | public proposal law inside `R_M` (line 1839) | — |
| `u` | `min_j x_j` (line 1520) | pooling payoff level `u ∈ [max{v_U^A(ℓ),β²h}, v_U^A(h)]` (line 1939) | generic element `u ∈ V_U^A` (line 2055) |
| `v` | public payoff `v_g^B`, `v_g^A` (throughout) | full pure ballot map inside `R_U` (line 1889) | generic element `v ∈ V_M^A` (line 2055) |
| `g` | rule index `g ∈ {M,U}` (line 743) | permutation of weak-state names (line 2025) | — |
| subscript `E` | exclusion (`Π_E`, `V_M^{B,E}`, lines 563, 1572) | ex ante (`ΔV_E^A`, `v_{U,E}^A`, `𝒞_E^A`, lines 1053, 2229, 2062) | — |
| `B` | baseline arm superscript | `𝓑_M`, `𝓑_U` correspondences (line 1045) | — |
| `M` | majority | `M_o = max{A_p, D_{o,p}}` (line 1850) | — |
| `π` | posterior map in `R_M` (line 1839) | near-collision with `Π` proposer payoffs (line 562) | — |
| `k` | majority quota (line 335) | `κ̂_U` continuation selector (line 1888), visually adjacent | — |

Beyond collisions, two families of symbols name the same object. The price of a weak vote is `w = β/m` and `w_ℓ^U, w_h^U` in the baseline (lines 560, 622) but `r_M(o)`, `r_U(o)` in the extension (lines 2125, 1861). The reader must verify that `r_U(o)` with `o` fixed and `w_o^U` are different objects (they are: `r_U(o)=β(1−βo)/m`, `w_o^U=β(1−o)/m`), which the text never says.

Undefined tokens: `M/S/B` (first use line 1038, "maintained pure-PBE M/S/B architecture"; used again at lines 1297, 1754, and in the family names `AU-MSB-L`, `AU-MSB-H`) is never expanded. "Reynolds average" (lines 2038, 2454) is never defined. "N7" appears in the note embedded in Figure `fig:rents` ("exact N7 formulas"). "Disciplined" and "undisciplined" proposals (lines 1752–1754) are used before any definition; the intended meaning (on the support of `σ̄` versus off it) must be inferred. "Fiber" (line 1050) and "member" (line 1017) are used in the body before Appendix E.4 gives them content. "Frozen" (lines 1105, 1741, 1833, 1871, 2185, 2322, 2338, 2557) is workflow vocabulary with no mathematical meaning in the paper.

**Impact.** The extension is unreadable to anyone without the project's internal files. A referee will not be able to tell whether `D_{h,1}` in Table `tab:ampure` is a direct effect or a delay payoff without reading E.2 and E.11 side by side.

**Suggestion.** (i) Rename the E.2 objects: `A_μ → π^{pass}(μ)` or `a(μ)`; `D_{o,μ} → d_o(μ)`; `𝒟_C → 𝓜_C` or `P_C`. (ii) Rename the ballot map in `R_U` from `v` to `a` (already used for the ballot map in `R_M`, line 1839, which is the consistent choice). (iii) Rename the permutation `g` to `π` or `σ` and the proposal law `λ` to `ζ` (or reuse `σ̄`, which is the same object by line 1886). (iv) Use `ex` or `\mathrm{ea}` instead of `E` for ex ante. (v) Replace `W(μ)` with `c_W(μ)`. (vi) Expand `M/S/B` on first use, or better, delete the acronym and say "the maintained solution concept". (vii) Delete "frozen", "Reynolds average", "N7", "source manifests", "later external consultation" (line 2338), "six later advisory corollaries" (line 2556); these reference documents the reader cannot see. (viii) Unify `w`/`r`: define one function `r_g(o)` for the price of a weak vote and derive the baseline `w`'s as special cases. Thomson §3: "notation should be parsimonious; the same symbol should never denote two different things."

### D4. Definitions — Needs improvement

**Diagnosis.** The paper has no `definition` environment. The four outcome classes that organize every result (exclusion, screening, pooling, deliberate delay) are defined in a run-on sentence: "Exclusion buys `k` weak responders at price `w` each and sets `x_H=0`. Screening buys `k−1` weak responders and offers `βℓ` … Pooling buys `k−1` weak responders and offers `βh`" (lines 567–572). Structural consistency is defined in A.2 prose (lines 1360–1376) with no typographic marker; the text in Section 4.3 says only "the restriction stated exactly in Appendix A.2" (line 418). The informational-rent correspondence is defined by display (line 745) but its domain is never stated (is `IR_g^B` a function of `(p, m, β, ℓ, h)`, or of the cell?). The set-valued objects of the extension (`R_M`, `R_U`, `Sig^ex`, `Sum^econ`, `𝒥_A^bind`) are described but never exemplified: Thomson's four categories of illustrative example (an object that satisfies the definition, one that fails it, a boundary case, a degenerate case) are absent. A single worked binder for the pure pooling witness `x(u)` at line 1957 would show the reader what the ten coordinates of `R_U` look like.

One name per concept is violated in the other direction as well: the same object is called "outcome class" (line 590), "equilibrium class" (line 1786), "family" (line 1904), "member" (line 1017), "record" (line 909), "binder" (line 1880), and "cell" (line 1035). "Outside option", "disagreement payoff", and "terminal disagreement payoff" are used interchangeably for `o` (lines 302, 345, 1686).

**Impact.** The reader cannot locate the definition of "screening" when Proposition 3 refers to it, and cannot verify that "member" in Section 6 and "binder" in Appendix E are the same thing.

**Suggestion.** Add `\begin{definition}` for: (D1) the four outcome classes, stated in terms of the proposal `x` (coalition size, `x_H` level, acceptance set); (D2) structural consistency, moved from A.2 into Section 4.3 in full, since it is three sentences; (D3) informational rent, with domain; (D4) a complete equilibrium record, once, with a one-line example. Fix one term for each of the seven synonyms above. Thomson §4: "be unambiguous when you define a new term; signal definitions typographically."

### D5. Statement of results — Needs improvement

**Diagnosis.** Section 5 is good Board practice: context paragraph, numbered proposition, proof in appendix, intuition paragraph, summary table. Two failures.

1. Section 6 contains no numbered results. The following are theorems stated as prose or displays: the public agenda payoffs `v_U^A`, `v_M^A` (lines 929–940); the sign characterization `sgn Δv^A(o) = sgn(βo − e/m)` (line 976); the selection-free majority-advantage region `βh < e/m ⇒ V_U^A − V_M^A ≤ −β(e/m − βh)` (lines 1058–1067); the rent-incidence result `IR_U^A(ℓ) ≥ 0, IR_U^A(h) ≤ 0` with one strict (lines 1092–1094); the identity `T = D + I` (line 1149); `T_U` weakly positive wherever both arms exist (line 1179). None can be cited by number, none has a stated hypothesis list, and the conditional "for every nonempty common fiber" (line 1057) is the kind of hypothesis Board says belongs in the proposition header, not in a subordinate clause.
2. Propositions 6 and 7 are lists of vectors keyed to cells named in words ("both types included, screening"). They are correct but they are lookup tables, not statements. The takeaway (line 873–885) arrives a page and a half later, after a `longtable` that reproduces both propositions verbatim (lines 823–870). Three representations of the same content on consecutive pages violates parsimony.

The abstract uses `T = D + I` with `T`, `D`, `I` undefined (line 33). Board advises no notation in abstracts.

**Impact.** Referees quote results by number. The paper's second contribution (the informational shadow of agenda power, line 118–125) has no citable statement.

**Suggestion.** Add at minimum: Proposition 8 (public agenda payoffs and `Δv^A`), Proposition 9 (selection-free majority advantage), Proposition 10 (unanimity rent incidence), Proposition 11 (`T = D + I` and `T_U ≥ 0`). Each with hypotheses in the header ("Fix `𝐝` and a fiber `(ρ, μ^off)` in which both `𝓑_M` and `𝓑_U` are nonempty"). Fold the `tab:rents` longtable into Propositions 6–7 or delete it. Replace `T = D + I` in the abstract with words.

### D6. Proofs — Serious problem

**Diagnosis.** Appendix B (lines 1384–1605) is in good shape: proofs are 70–85 percent natural language, above Thomson's 52–63 percent band but appropriately so for a model where the algebra is linear; each ends with `□`; B.4 numbers its four profile cases; the informal explanation precedes each computation. Two local gaps: B.3 says "Substituting the signs of `ℓ−1/m` and `h−1/m` produces the five cases" (line 1478) without deriving case 5's selection condition `(1−p)ℓ + ph < βh`; B.6 proves two propositions in eleven lines by "Subtracting these from each private vector gives the table" (line 1590). Both are verifiable, but Thomson would ask for the case-5 algebra to be shown.

Appendix E is the serious problem. It asserts, without proof:

- "The following conditions are necessary and sufficient for every interior pure equilibrium class" (line 1786) followed by Table `tab:ampure`, six classes.
- "This criterion is necessary and sufficient; arbitrary Borel mixtures and atomless supports are included" (line 1845).
- "For every admissible primitive and prior, at least one majority PBE exists for some `ρ`" (line 1854).
- "The full interior correspondence is generated by the following two families" (line 1904) and "There is no third interior family" (line 1968).
- "The only continuation posteriors admitted by the frozen unanimity continuation are `𝒟_C = {0} ∪ (p^*, 1]`" (line 1871–1875).
- E.13's `T_U` correspondence (lines 2343–2360) is obtained by subtraction, fine; but "every unanimity member weakly benefits both types" (line 2378) rests on the unproved E.3 image.

Appendix F.3 then states: "Mechanical scripts check hashes, schemas, finite identities, inequalities, and enumerated cells. They do not prove PBE completeness, abstract measurability, universal factorization, or the absence of unenumerated deviations; those conclusions come from the textual proofs fixed by the source manifests" (lines 2538–2543). In a journal submission, this sentence says the proofs are not in the paper.

**Impact.** A referee will treat every Section 6 claim that depends on E.2–E.3 as unproven. The selection-free result (E.5) survives because its proof is self-contained in six lines (it needs only the bounds `V_M^A ≥ v_M^safe` and `V_U^A ≤ v_U^A(h)`), but the bound `V_M^A ≥ v_M^safe` is itself asserted at line 2076 ("Every majority binder satisfies") without argument.

**Suggestion.** Either (a) bring the proofs of E.2, E.3, and the `v_M^safe` lower bound into the manuscript as B.7–B.9, following the B.4 template (enumerate the profile cases, show each deviation, close with `□`); or (b) demote E.2–E.3 to "characterizations reported without proof in this version; proofs available in a supplementary appendix" and restrict every body claim to what E.5–E.8 prove self-containedly. The sentence at lines 2538–2543 must go in either case. Thomson §5: "A proof is not a reference to a proof elsewhere."

### D7. Figures — Adequate

**Diagnosis.** Figures F1–F4 (`figures/essential_input/`) are competent region and dot plots with complete axis labels, legends, closed-form boundaries marked, and parameter values printed. F1 is the best: a genuine geometric example in `(p, m·h)` space that shows the type-specific sign pattern of Proposition 5 and the empty band. Weaknesses:

- `fig:agendagap` (lines 979–1012) is a `figure` environment containing a displayed formula (Panel A) and a three-row table (Panel B). Neither is a figure. Panel A should be a plot of `Δv^A(o)` against `o` with the boundaries `1/m`, `e/(mβ)`, `o_M^*` marked; that plot would do for the extension what F1 does for the baseline.
- `fig:decline` (F4) is the unanimity panel of F2 redrawn with an arrow. Its caption says "Historical annotations, if used, are illustrations" (lines 1224–1226); there are none, so the conditional dangles.
- The embedded note in F3 refers to "the exact N7 formulas" (internal label). The note in F2 says "not the public-benchmark rent estimand", jargon that the body never uses.
- No figure or diagram maps the existence structure of the extension. Appendix E.3 partitions `(p, μ^off)` into six fibers with different existence status (lines 1994–2007); E.13 and F.2 partition them again. A single two-panel cell map in `(p, μ^off)` space, one panel for `V_U^A` and one for `T_U`, hatched where empty, would replace two pages of case displays. Thomson recommends a Venn or region diagram precisely for "which conditions imply which".
- `fig:agendafactorial` (lines 1122–1140) is a 2×2 table in a `figure` environment; it should be a table.

**Suggestion.** Convert `fig:agendagap` Panel A into a real plot; move Panel B into a table; delete or merge F4 into F2; add the `(p, μ^off)` cell map; strip internal labels from figure notes; fix the dangling "if used".

### D8. Assumptions and logical structure — Needs improvement

**Diagnosis.** Primitives are grouped correctly: `m ≥ 3`, `0<ℓ<h<1`, `β∈(0,1)`, all in Section 4.1–4.2 and collected in `tab:scope`. The numerical example `(m,β,ℓ,h) = (4, .9, .10, .35)` satisfies all of them, as Thomson requires. The implication `m ≥ 3 ⇒ k ≤ m−1` (weak states alone can pass a majority) is the reason for `m ≥ 3` but appears only inside B.1 (line 1390); it belongs next to the assumption.

The behavioral disciplines are ordered in Section 4.3 as: no-signaling, as-if-pivotal, yes-at-indifference, proposal tie-break (lines 414–421). Board's rule is to order by decreasing plausibility and to motivate in proportion to controversy. The last two are the most consequential and receive the least motivation:

- The proposal tie-break "the selected proposal minimizes `H`'s expected payoff" (line 420–421) is one clause with no justification. It decides Proposition 1 at `o=1/m`, Proposition 2 at `p=p^*`, Proposition 3 at every screening tie and the whole `h=1/m` segment, and Proposition 4's `(N,N)` argument. The natural motivation (it selects the equilibrium least favorable to the hegemon, so any informational rent found is a lower bound) is never given.
- The restriction to pure ballot strategies produces the paper's most striking result, the empty cell `0<p≤p^*` (Proposition 4). The only motivation is the label "maintained" (Remark after Proposition 4, line 657–663). A reader will ask why a mixed ballot is excluded when the proposer's mixing over proposals is admitted (line 610–613, the residual segment).
- The extension's single common `ρ` is honestly flagged as "a stronger restriction than the ballot-by-ballot free values of Appendix A.2, adopted here to index the correspondences" (lines 1765–1767). Good practice; the baseline disciplines should be treated the same way.

**Suggestion.** Reorder Section 4.3 as: (A1) PBE; (A2) no-signaling and support preservation (least controversial, cited); (A3) as-if-pivotal and yes-at-indifference (conventional in voting games, cite Austen-Smith and Banks or Baron and Ferejohn's stage-undominated voting); (A4) pure ballot strategies (state that mixing over proposals is allowed, mixing over votes is not, and why); (A5) proposal tie-break against `H`, with the lower-bound motivation. Move "`m ≥ 3` so that `k ≤ m−1`" to line 300.

### D9. Examples and applications — Needs improvement

**Diagnosis.** Section 3 (lines 282–296) is a good idea executed thinly. It shows only the terminal unanimity cutoff `p^* = .2778` and two beliefs on either side. It does not show the mechanism the paper is about: that at the same parameters majority excludes `H` (`1/m = .25` lies strictly between `ℓ=.10` and `h=.35`, the "low included, high excluded" region) while unanimity pools, so the low type earns `β(h−ℓ) = .225`. Those numbers exist, but in Appendix C.3 (lines 1650–1676). Board's rule is that the example should let the reader guess the main result; this one lets the reader guess Proposition 2 only.

Three parameter sets are used: `(ℓ,h)=(.10,.35)` in Sections 3, 5, C.3, and Figures F2–F4; `(ℓ,h)=(.10,.90)`, `p=.95` in the agenda illustration (line 1008); `(ℓ,h)=(.5,.6)`, `p=0` in the E.5 counterexample (line 2098). The agenda illustration's `h=.90` is chosen so that `βh = .81 > e/m = .5`, which the text does not say; the reader must compute why the running `h=.35` would not produce a reversal (`βh=.315<.5`, so majority dominates by E.5). Naming is functional (`H`, weak states `1…m`) and does not need improvement for this genre.

**Suggestion.** Extend Section 3 by two sentences: at `p=.80` majority excludes and pays `H` its outside option, unanimity pools at `βh=.315`, so the low type gains `.225`; this previews Propositions 3, 4, and 7. State explicitly when the agenda illustration switches parameters and why (`βh` must exceed `e/m` for a reversal to be possible, by E.5). Consider using one parameter set with `h` chosen so that both the baseline and the agenda reversal can be shown (for `m=4`, `β=.9` this needs `h > 5/9`).

## Notation inventory

| Symbol | Meaning | Introduced | Used in | Problem? |
|---|---|---|---|---|
| `H`, `W`, `m` | hegemon, weak-state set, count | 300 | throughout | `W` collides with `W(μ)` at 1496 |
| `k = ⌊(m+1)/2⌋` | majority quota | 335 | throughout | none |
| `e = m−k` | excluded weak states | 903 | Sec 6, E | none |
| `o ∈ {ℓ,h}`, `p` | private type, prior | 302–304 | throughout | three synonyms for `o` |
| `β` | discount factor | 349 | throughout | none |
| `𝒳`, `x`, `x_H`, `x_j`, `x_i` | proposal space, allocations | 313–325 | throughout | none |
| `𝔥^Y`, `𝔥^N`, `C_H(𝔥^a)` | post-vote histories, continuation | 368–373 | Table 2 only | defined, then never used again |
| `p^* = (h−ℓ)/(1−ℓ)` | terminal unanimity cutoff | 534 | throughout | none |
| `w = β/m` | majority weak-vote price | 560 | Sec 5, B.3 | duplicated by `r_M(o)` at 2125 |
| `w_ℓ^U`, `w_h^U` | unanimity weak-vote prices | 622 | Sec 5, B.4 | duplicated by `r_U(o)` at 1861; distinct formula, never contrasted |
| `Π_E`, `Π_S(p)`, `Π_P` | proposer payoffs by class | 562–566 | Sec 5, B.3 | subscript `E` = exclusion collides with `E` = ex ante |
| `p_{S=E}`, `p_{S=P}` | majority cutoffs | 575–587 | Sec 5, C.3, F1 | none |
| `v_g^B(o)`, `V_g^B` | public/private baseline payoffs | 500, 709 | Sec 5–6 | `B` undefined until 1130 |
| `IR_g^B`, `ΔIR^B` | baseline rents and contrast | 745–750 | Sec 5–6, F.2 | domain not stated |
| `λ` | segment weight | 721 | Sec 5, C.2 | collides with proposal law in `R_M` (1839) |
| `W(μ)` | weak continuation under unanimity | 1496 | B.4 | collides with set `W` |
| `u` | `min_j x_j` | 1520 | B.4 | reused at 1939, 2055 with different meanings |
| `s^†` | deviation proposal | 1542 | B.4 | none |
| `ρ`, `μ^off = b_ρ(p)` | off-path likelihood ratio, posterior | 897, 1756 | Sec 6, E–F | none; `b_ρ` introduced late (1756) after `μ^off` formula at 899 |
| `v_M^safe`, `o_M^*` | safe majority payoff, delay cutoff | 903, 947 | Sec 6, E | none |
| `v_g^A(o)`, `V_g^A` | public/private agenda payoffs | 929, 1016 | Sec 6, E | none |
| `Δv^A`, `ΔV^A`, `ΔV_E^A` | public/private/ex ante gaps | 954, 1052 | Sec 6, E | case-only distinction; `E` collision |
| `𝒥_A^bind`, `𝓑_M`, `𝓑_U` | fiber product, correspondences | 1043–1047 | Sec 6, E.4 | `B`-script collides with arm label |
| `IR_g^A`, `ΔIR^A` | agenda rents | 1076–1078 | Sec 6, E.9–10 | none |
| `I_g`, `ΔI` | interaction | 1109 | Sec 6, F.2 | none |
| `D_g`, `T_g`, `Q_g`, `ΔD`, `ΔT` | direct, total, diagonal effects | 1145–1188 | Sec 6, E.11–14 | `D` collides with E.2 delay payoffs |
| `𝐝` | primitive vector | 1725 | E | none |
| `A_χ(μ)`, `A_μ`, `D_{χ,o}(μ)`, `D_{o,μ}`, `O_o(ρ)`, `M_o` | E.2 value functions | 1777–1850 | E.2 | `A`, `D`, `M` all overloaded |
| `χ`, `a`, `π`, `σ_ℓ`, `σ_h`, `σ̄`, `u_ℓ`, `u_h` | components of `R_M` | 1839 | E.2 | `π` near `Π`; `λ` collision |
| `R_M`, `R_U` | equilibrium records/binders | 1839, 1880 | E, F | five synonyms for the object |
| `r_U(o)`, `r_M(o)` | agenda weak-vote prices | 1861, 2125 | E | duplicate family with `w` |
| `x^ℓ`, `x^h`, `x^S`, `x(u)` | proposal primitives/witnesses | 1866, 1930, 1957 | E.3 | none |
| `𝒟_C` | admissible continuation posteriors | 1874 | E.3 | `D` overload |
| `κ̂_U`, `v`, `Ω_o`, `Γ_o`, `μ` | components of `R_U` | 1880–1892 | E.3, F.1 | `v` collides with public payoff; `μ` here is a map, elsewhere a scalar |
| `α_L` | atom on `x^ℓ` | 1913 | E.3 | none |
| `𝒦_L`, `𝒦_H(u)`, `𝓡_L` | proposal sets | 1926, 1947, 1984 | E.3 | none |
| `AU-MSB-L`, `AU-MSB-H` | family names | 1904, 1938 | E.3 | `MSB` never expanded |
| `Z_U`, `ζ_U`, `ω_term`, `𝒫(Z_U)` | record space | 2014–2022 | E.3 | defined, used once |
| `g`, `𝓡_g`, `Λ_γ`, `q_U`, `q_Z` | relabeling apparatus | 2025–2031, 2429 | E.3, F.1 | `g` collides with rule index |
| `Sig^ex`, `Sum^econ` | exact/economic signatures | 2028–2031, 2424–2431 | E.3, F.1 | never used in any result |
| `𝒞_{ℓh}^A`, `𝒞_E^A`, `𝒞_econ`, `𝒪_A` | contrast sets, outcome object | 2054–2066, 2449, 2470 | E.4, F.1 | `E` collision; none used in a stated result |
| `M/S/B` | solution-concept label | 1038 | 1297, 1754 | never defined |

## Result-by-result analysis

| Result | Context before | Statement | Proof | Intuition after | Implications | Board verdict |
|---|---|---|---|---|---|---|
| Prop 1 (public benchmark, 485) | Yes, prices explained (476–483) | Clear; cases displayed | B.1, prose, `□` | Yes (526–528, tie at `o=1/m`) | Table 3 | Good |
| Prop 2 (private terminal, 542) | Yes (531–540) | Clear | B.2, prose, `□` | Yes (553–555) | — | Good |
| Prop 3 (private majority, 589) | Payoff formulas only; no verbal preview of why screening at low `p` | Five cases, parallel | B.3; case 5 condition not derived | Only on multiplicity (610–616) | Table 4 | Needs an intuition sentence: screening is a cheap gamble when the high type is unlikely |
| Prop 4 (private unanimity, 639) | Excellent (620–637) | Clear array | B.4, numbered cases, `□` | Remark on scope | Table 4, F2 | Good; the empty cell needs the pure-strategy assumption motivated (D8) |
| Prop 5 (payoff contrast, 709) | Timing wedges (700–707) | Four cases | B.5, trivial subtraction | Yes (730–733) | F1 | Good |
| Prop 6 (rents by rule, 767) | Yes (757–765) | Lookup table | B.6, eleven lines for two props | Deferred to 873 | `tab:rents` duplicates | Merge with Table 5 |
| Prop 7 (rent contrast, 802) | Yes (795–800) | Lookup table | B.6 | 873–885 | F3 | Merge; state the sign rule (`βh` vs `ℓ`) in the proposition |
| Public agenda payoffs (929–940) | Yes | Displayed, unnumbered | E.6–E.7 (self-contained) | Yes (948–951) | `fig:agendagap` | Number it |
| Sign of `Δv^A` (954–976) | Yes | Displayed, unnumbered | E.8 | Yes | — | Number it |
| Selection-free majority region (1056–1067) | Yes | Displayed, unnumbered | E.5 (depends on unproved bound at 2076) | Yes | E.5 counterexample | Number it; prove the lower bound |
| `IR_U^A` incidence (1091–1094) | Yes | Prose, unnumbered | E.9 table; rests on unproved E.3 | Yes | — | Number it; proof needed |
| `T = D + I` (1149) | Factorial figure | Boxed identity | E.11 (algebraic, fine) | Yes | — | Number it |
| `T_U ≥ 0` where both arms exist (1179) | Minimal | Prose | E.13; rests on E.3 | None | — | Number it; proof needed |
| E.2 six classes "necessary and sufficient" (1786) | None | Table | None | None | — | Serious: unproved |
| E.3 two families, "no third" (1904, 1968) | None | Prose | None | None | — | Serious: unproved |

**Takeaway messages, as a reader would state them.** Prop 1: with a known type, unanimity always pays `βo`; majority pays `βo` only when `o ≤ 1/m` and otherwise excludes. Prop 2: majority ignores `H` in the last round; unanimity screens below `p^*` and pools above. Prop 3: under majority, screening at low beliefs, then pooling or exclusion depending on whether `h` is below or above `1/m`. Prop 4: under unanimity with pure ballots, equilibrium exists only at `p=0` and above `p^*`, and pools at `βh`. Props 5–7: above `p^*`, the low type's unanimity advantage is `β(h−ℓ)` when majority screens and `βh−ℓ` when majority excludes; the high type never gains from unanimity except in one boundary cell. Section 6: agenda pays `1−β` under unanimity, but majority dominates for both types when `βh < e/m`; private information under unanimity always favors the low type and never the high type. These takeaways are all present in the text but only the first five are attached to a numbered result.

## Constructive suggestions

1. **Put proofs of E.2 and E.3 in the manuscript, or scope the claims down.** Delete lines 2538–2543 ("those conclusions come from the textual proofs fixed by the source manifests"). Either add B.7–B.9 in the B.4 style or restrict Section 6 to what E.5–E.8 and E.11 prove self-containedly. (D6)
2. **Number the results of Section 6.** At least four propositions: public agenda payoffs and `Δv^A`; selection-free majority advantage; unanimity rent incidence; `T = D + I` with `T_U ≥ 0`. State the fiber-existence hypothesis in each header. (D5)
3. **Purge internal vocabulary.** Remove "frozen", "M/S/B", "MSB", "Reynolds average", "N7", "source manifests", "later external consultation", "six later advisory corollaries", "binder", and the marker `[AUTHOR: P1]` at line 356. Replace each with a term defined in the paper or with nothing. (D3, D2)
4. **Resolve notation collisions.** Rename `W(μ)`, the E.2 objects `A_μ`/`D_{o,μ}`/`𝒟_C`/`M_o`, the ballot map `v`, the permutation `g`, the proposal law `λ`, and the ex-ante subscript `E`. Unify `w`/`r` for weak-vote prices. Define `B` and `A` as arm superscripts in Section 4.4. (D3)
5. **Motivate the two selection assumptions.** Give the proposal tie-break its lower-bound rationale and explain why ballots are pure while proposals may mix. Reorder Section 4.3 by decreasing plausibility. (D8)
6. **Add typographic definitions** for the four outcome classes, structural consistency (moved into the body), informational rent with domain, and one worked equilibrium record. Fix one name each for "member/record/binder/class/family/cell" and for "outside option/disagreement payoff". (D4)
7. **Make Section 3 preview the mechanism.** Two sentences at `p=.80`: majority excludes, unanimity pools, the low type gains `.225`. State when and why the agenda illustration switches to `h=.90`. (D9)
8. **Replace `fig:agendagap` Panel A with a plot of `Δv^A(o)`**, move Panel B to a table, add a `(p, μ^off)` existence cell map for the extension, and merge F4 into F2. Remove "N7" and "if used" from figure text. (D7)
9. **Cut redundancy.** `tab:rents` reproduces Propositions 6–7; `tab:privatecorrespondence` reproduces Propositions 3–4; the "structural causal contrast, not an empirically identified estimand" sentence appears at lines 1152, 2545, and in the abstract. Keep one instance of each. (D2, D5)
10. **Minor.** "OMC" at line 84 should read "WTO". `C_H(𝔥^a)` (line 372) is defined for Table 2 and never used again; either use it in B.3–B.4 or drop the row. State "`m ≥ 3` so that `k ≤ m−1`" at line 300.

---

## Parecer completo — Exposicao

# Parecer de Exposicao do Modelo (Varian / Thomson / Board)

Manuscript reviewed: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd` (2,648 lines; compiled PDF 67 pages: body pp. 1-33, appendices pp. 34-66). Line numbers below refer to the `.Rmd`; page numbers to the compiled PDF. No files were edited.

## Score: 5/10

The skeleton is right (hook, integrated literature, proofs in the appendix, zero footnotes, a decomposition that organizes the results). The execution is undermined by three exposition failures that any AJPS/IO referee will notice on first read: (i) internal workflow vocabulary has leaked into the abstract, the body, and the conclusion; (ii) the agenda extension (Section 6 plus Appendices E-F, roughly 25 pages) is written for the author's verification pipeline, not for a reader, and contains no numbered proposition; (iii) the headline result arrives on p. 21 after five propositions and two tables that restate each other. The paper currently reads as a proof binder with an introduction attached.

## Avaliacao por dimensao

### ME1. Estrutura do paper [Precisa melhorar]

**Hook on page one.** Yes. Lines 41-49 open with the WTO puzzle in five sentences and end with a real question. This is the strongest passage in the paper.

**Get to the point.** Partially. Page map: Model starts p. 8, Results p. 12, Proposition 3 (majority correspondence) p. 14, Proposition 4 (unanimity, the empty cell) p. 15, Proposition 5 (institutional contrast) p. 17, Propositions 6-7 (informational rents, the paper's headline object) pp. 19-21. Board's "main result before p. 15" is missed. The reason is not the model section (5 pages, acceptable) but the 7 pages between the introduction and the model: a 5-page literature section with a full table (lines 141-280) and a 1-page numerical illustration that illustrates only the terminal-round cutoff (lines 282-296), not the mechanism.

**Logical flow.** Model, results, extension, discussion, conclusion: correct order, and the baseline is fully solved before the extension (Section 4.5, lines 458-468, announces the extension and defers it). Good.

**Redundancy that slows the flow.** Table `tab:rents` (lines 826-871) is a longtable that reprints, cell by cell, exactly the content of Propositions 6 and 7 stated immediately above it. Table `tab:privatecorrespondence` (lines 665-693) reprints Propositions 3 and 4. A reader meets each result three times (proposition, table, prose) before reaching the next one. Keep one table in the body (the correspondence table is the more useful one) and move `tab:rents` to Appendix C.

**Section 6 has no propositions.** Section 5 states seven numbered propositions. Section 6 (lines 902-1214) states the public agenda values, the sufficient majority-advantage region, the incidence result "IR_U^A(l) >= 0, IR_U^A(h) <= 0", the decomposition T = D + I, and the sign of D_M, all as displayed equations inside prose. Nothing is numbered, nothing is proved in a "Proof of Proposition k" subsection; the reader must reconstruct which claims are theorems and which are definitions. This breaks the paper's own convention and makes the extension impossible to cite. At minimum: Proposition 8 (public agenda gap and its sign), Proposition 9 (sufficient majority-advantage region), Proposition 10 (unanimity incidence and T = D + I), each with a proof pointer to Appendix E.

**Appendix G duplicates Table 1.** The crosswalk in Appendix G (lines 2565-2646) is a 14-row expansion of the 5-row Table `tab:steinbergmechanisms` (lines 167-193). Keep one. The short version in Section 2 does the work.

### ME2. Introducao [Precisa melhorar]

**Puzzle first.** Yes (lines 41-79). The Baron-Ferejohn/Kalandrakis paragraph (lines 66-79) is the right anchor: "either a hegemon like the US made a blunder, or there is a need to further explain."

**Contribution clear in a couple of paragraphs.** Lines 113-129 state two contributions. The first (lines 113-119) is clean and intuitive: majority lets proposers buy uninformed votes so the hegemon's information is worth zero; unanimity makes its vote an essential input and proposals pool at the strong type's threshold. The second (lines 121-129) is not readable by the target audience: "exactly 1-beta under unanimity", "when beta h < e/m majority strictly dominates for both types" use four symbols (beta, h, e, m) that are defined 20 pages later. Varian's test fails here: if the contribution needs `e/m` to be stated, it has not yet been understood in words. Replace with the verbal content: "when the hegemon's outside option is low relative to the share of states a majority coalition can leave out, majority is better for the hegemon even with agenda power."

**Agents, actions, information, intuition.** Lines 105-111 give agents and information in four sentences, which is the right length. What is missing is one sentence of *intuition for the headline result*: why does pooling under unanimity create rent for the *low* type? The answer (weak states cannot tell the types apart, so they pay the price that satisfies the strong type, and the weak type pockets the difference) never appears in the introduction. It appears first in the Discussion (lines 1235-1237: "Pooling under unanimity benefits the low type because weak states price it as high"). Move that sentence up.

**Under-disclosure of a central feature.** The abstract says the pure-strategy correspondence is empty in some belief regions; the introduction does not mention it at all. The empty cell for 0 < p <= p* is a first-order fact about the baseline (Proposition 4 and Figure 2's hatched band). A referee who discovers it on p. 15 without warning will read the introduction as overclaiming.

**Laundry lists.** None. Good.

**Local defects.** Line 52: "Coercion and Information institutions rule the negotiation process" is not an English sentence (possibly "coercion and informal institutions"?). Line 78: "OMC" is the Portuguese acronym; should be WTO. Line 105: "The current paper" is a Portuguese calque; "This paper". Lines 109-110 use "I first investigate ... I then reintroduce"; line 413 onward uses "We use perfect Bayesian equilibrium". Single-authored paper: pick one voice and keep it. Line 121: "Secondly" following "The paper's first contribution" (line 113) is not parallel; use "The second contribution".

**Order puzzle -> model -> literature.** Yes, but the literature discussion is split: lines 81-103 already discuss Glynia et al. and Piazolo-Vanberg in the introduction, and Section 2.3 (lines 233-280) discusses them again at length. The introduction version is the better one; Section 2.3 can shrink to the two "what is new relative to them" paragraphs (lines 254-270).

### ME3. Escrita e estilo [Problema serio]

Checklist, with manuscript examples.

**Abstract (lines 31-32, 223 words).** Not readable by an IO/APSR non-theorist. Specific sentences that will lose that reader: "the maintained pure-strategy correspondence is empty in some belief regions"; "the structural causal contrast of agenda is a correspondence and decomposes as T = D + I, where D is the complete-information agenda effect and I is its interaction with informational rent"; "The analysis preserves linked type vectors, empty cells, and equilibrium multiplicity." The last sentence describes the author's bookkeeping discipline, not a finding. An abstract for this journal should contain: the puzzle (one sentence), the model (one sentence), the two results in words (two sentences), the WTO reading (one sentence). Roughly 120 words. Symbols do not belong in it.

**Internal pipeline vocabulary in the body.** This is the most damaging problem in the manuscript. The following terms are workflow jargon from the author's verification process and are never defined for the reader:

- `[AUTHOR: P1]` marker left in the text, line 356.
- "essential-input game" in the caption of Table 2 (line 361), "the essential-input mechanism" in the roadmap (line 137), "Notation for the essential-input bargaining game" (Appendix D caption). The phrase is used as a proper name but is never introduced; the body only says "essential input" descriptively at line 118.
- "M/S/B architecture" (line 1065, body; also E.1 line 1721 "the M/S/B restriction"; Limits, line 1330). The acronym is never expanded anywhere in the manuscript.
- "frozen": "the frozen Round-1 correspondence" (line 1104), "the frozen continuation selection creates a downward jump" (line 1190), "frozen theorems" (F.4), "the frozen result" (E.12). To the reader "frozen" means nothing; the intended meaning is "the baseline equilibrium taken as given."
- "fiber", "common fiber", "existing fiber", "high-prior fiber" (lines 1082, 1094, 1105, 1110, and throughout E). Undefined in the body.
- "record", "complete equilibrium record", "linked record" (lines 924-926, 1179 and throughout E). Undefined in the body.
- "binder" (E.1, E.3, E.4, F.1: twelve occurrences). Undefined.
- "`none` in the source correspondences" (line 1063). The body refers to a coding convention of a file the reader will never see.
- "Reynolds average" (E.3, F.1). A term from the author's review discussion, never defined.
- "Mechanical scripts check hashes, schemas, finite identities ... those conclusions come from the textual proofs fixed by the source manifests" (F.3, lines 2521-2526). This is a description of the author's CI pipeline.
- "We do not promote the six later advisory corollaries to frozen theorems" (F.4, line 2542) and "no stronger global classification from the later external consultation is promoted here" (E.12, line 2409). These sentences refer to events in the author's revision history. Under the project's own rule that the paper is atemporal, they must go.
- "Historical annotations, if used, are illustrations" (Figure 4 caption, line 1256). A caption cannot be conditional on what the author later decides to draw.
- Line 1264: "a sharper institutional illustration than OPEC." OPEC is never mentioned anywhere else in v6. This is a dangling reference to a previous version.

**Defensive negations.** The body repeatedly negates positions no reader holds: "It is not a license to combine componentwise minima and maxima into an unattained rectangle" (line 615); "It is not replaced by a selected equilibrium or by componentwise envelopes" (line 1044); "It is not a zero effect or a claim about mixed equilibria outside that architecture" (line 1066); "not the Cartesian product of marginal envelopes" (B.6); "It is never encoded as zero, NA, infinity, or a fictional payoff" (F.3); "No Reynolds average is treated as an equilibrium representative" (E.3, F.1). Each of these answers an objection raised during the author's internal review. State the positive rule once, in the solution-concept section ("all set-valued objects below are indexed by a single proposal weight lambda; reported intervals are envelopes of a segment, not products"), and delete the repetitions.

**Causal-inference framing of an accounting identity.** Section 6.4 and E.11 present T = D + I with "factorial design", "treatment", "control", "structural causal contrast ... not an empirically identified estimand" (lines 1145-1170, 2367-2380). The identity follows in one line from V = v + IR in both arms (E.11 says so: "Substituting V = v + IR in both arms yields"). Dressing a substitution as a 2x2 factorial design invites the referee to ask what is being identified. Call it what it is: a decomposition of the agenda effect into its public-information component and its interaction with informational rent.

**Short sentences, symbol-initial sentences.** Body sentences are mostly short; no body sentence begins with a symbol. Appendix A.2 line 1406 ("\(H\) maximizes ...") and F.4 line 2530 ("\(T_g\) is a structural ...") do. Minor.

**Footnotes.** Zero. Correct per Thomson, and a real improvement.

**Terms used correctly.** "Correspondence" is used correctly but 41 times; "linked" is used as a technical adjective ("linked type vector", "linked payoff", "linked member") without ever being defined. One sentence at first use: "linked means that the two type payoffs are generated by the same equilibrium and may not be recombined across equilibria."

**Narrative appendix.** Appendices A-D are narrative and readable. Appendices E-F are not: E.3 alone defines R_U as a nine-tuple, two families with four bullet conditions each, a "two-layer representation" with pushforward laws, permutation orbits Lambda_gamma, and signatures Sig^ex and Sum^econ, none of which is used by any statement in the body. F.1 restates the signatures. A reader cannot tell which parts of E-F are needed for which body claim.

### ME4. Extensao e quando parar [Excessivo]

**Page budget.** 67 pages: 33 body, 32 appendix (of which E-F are 19 pages, pp. 44-63). The baseline result, which is the paper's contribution, occupies pp. 12-21. The agenda extension occupies pp. 23-29 in the body plus pp. 44-63 in the appendix: roughly 25 pages, or 37 percent of the manuscript, for a result whose body statement is that the majority effects "remain set-valued", "No general sign is imposed", and the sufficient condition "is sufficient, not necessary". Varian: people remember ten pages. The ten pages the author wants remembered are pp. 12-21; the extension currently buries them.

**Is the extension justified?** Yes, in principle. The introduction promises it (lines 110-111, 121-129), and the two economic messages are genuinely interesting: (a) agenda pays the proposer rent 1-beta under unanimity but shrinks the informational rent; (b) when beta h < e/m majority dominates for both types even with agenda, so the case for consensus runs through information (Panel B of Figure `fig:agendagap` is a good illustration). Those two messages need one proposition, one figure, one worked number, and a 4-page appendix.

**What should leave the manuscript.** E.1 (record/selector contract), the second half of E.2 (mixed reduced records R_M), the entire two-layer representation in E.3, E.4 (fiber products), F.1 (signatures), F.3 (existence rules and script disclaimers), F.4 (advisory corollaries). These serve the author's verification audit, not the argument. They belong in a replication/verification supplement, not in a submitted paper. The `Q_g` diagonal contrast (Section 6.4 last paragraph and E.14) is explicitly described as "not a one-factor causal effect" and "useful for comparison"; if it is not used, cut it.

**Average quality versus sum.** Appendix B (proofs of Props 1-7) is tight and readable; B.4's enumeration of the four pure profiles is a model of how to write the nonexistence argument. Appendices E-F pull the average down sharply.

**Mechanical proofs in the appendix.** Yes, correctly. The body carries no proof sketches, consistent with the Hirsch standard the project adopted.

### ME5. Uso de exemplos e intuicao [Insuficiente]

**Motivating example.** Section 3 (lines 282-296) computes p* = 0.2778 for the terminal round and stops. It does not show the paper's mechanism: it does not show majority excluding the hegemon, unanimity pooling, or the rent. The example the paper needs already exists in Appendix C.3 (lines 1650-1680): at p = 0.80 with the same parameters, majority excludes (IR_M = (0.01, 0)) and unanimity pools (IR_U = (0.225, 0)), so the low type gains 0.215 from consensus. That is the paper in one line. Put it in Section 3 and let Section 3 preview both the pivotality component (the public vectors v_M = (0.09, 0.35) versus v_U = (0.09, 0.315)) and the information component.

**Verbal intuition before each result.** Mixed. Good: the paragraph before Proposition 4 (lines 626-637) explains the empty cell in plain words before the formal statement; the "timing wedges" paragraph before Proposition 5 (lines 712-718). Weak: Proposition 3 is preceded only by payoff formulas (lines 566-601) with no sentence saying what the five cases mean economically (the reader has to infer that 1/m is the price of a substitute weak vote, which line 490 said twenty lines earlier under a different heading). Absent: Propositions 6-7 are preceded by definitions, and the prose intuition (lines 873-885) comes after the longtable. Section 6 contains no intuition for the incidence result "IR_U^A(h) <= 0" beyond one sentence (lines 1089-1092).

**Geometric over numerical.** Four external figures (F1-F4) are included; their captions suggest they map the sign classes over (p, o) space, which is the right geometric object. They are referenced but not integrated: Figure `fig:privatecompare` is introduced by one sentence ("Figure 2 maps these exact classes without averaging types") and never walked through. A paragraph that reads the figure for the reader ("moving right along the belief axis, the low type's contrast switches from ... to ...") would replace half of the prose in Section 5.5-5.6. Figure `fig:agendagap` is not a figure: Panel A is a display of two sign conditions and Panel B is a 3x3 table, both wrapped in a `figure` environment. Make Panel B a table in the text and Panel A a real plot of Delta v^A(o) against o.

**Special cases as examples.** Endpoints p = 0 and p = 1 are used well as complete-information limits (C.1). The m = 4 example in E.5 showing the sufficient condition is not necessary is a good micro-example that should be promoted to the body of Section 6.2 (one sentence).

**Plain-English explanation of every result (Board).** Proposition 7's table of six vectors is explained in lines 873-885, and that paragraph is clear. But the reader who wants the one-sentence version ("consensus creates rent for the *weaker* hegemon, and only when weak states cannot tell it from the stronger one") has to assemble it from the Discussion. Say it right after Proposition 7.

## Veredicto geral sobre exposicao

The paper has a strong opening, a well-integrated literature section, a clean baseline solved in the right order, no footnotes, and a proof appendix (B) that a referee can verify. It also carries, verbatim, the vocabulary and the defensive apparatus of the author's internal verification pipeline: an `[AUTHOR: P1]` marker, an undefined "M/S/B architecture", "frozen" correspondences, "fibers", "binders", "records", "Reynolds averages", "source manifests", "advisory corollaries", a dangling reference to OPEC, and a conditional figure caption. The abstract is written in that same register. The agenda extension is nearly 40 percent of the manuscript, states no proposition, and is dominated by machinery that no body claim uses. The consequence is that the paper's actual contribution, Propositions 1-7 on pp. 12-21, is hard to find and easy to underrate. The fix is mostly subtraction: strip the pipeline vocabulary, cut Appendices E-F to what Section 6 uses, number the extension's results, and move the worked example from C.3 to Section 3. With those changes this is a 7-8 on exposition; as it stands, a referee will judge the paper by its worst pages.

## Top 5 sugestoes de melhoria

1. **Purge internal vocabulary and provenance sentences from the manuscript.** Concretely: delete `[AUTHOR: P1]` (line 356); expand or replace "M/S/B" (lines 1065, 1330, 1721) with the concept it names; replace "frozen" by "baseline" or "taken as given" (lines 1104, 1190, E.12, F.4); define "linked" once and drop "fiber", "record", "binder" from the body, keeping at most "fiber" in Appendix E with a one-line definition; delete the sentences on scripts, hashes, manifests (F.3, lines 2521-2526), advisory corollaries (F.4, line 2542), and "later external consultation" (E.12, line 2409); delete "than OPEC" (line 1264); rewrite the Figure 4 caption without "if used" (line 1256). Then rewrite the abstract in about 120 words with no symbols and no sentence about what the analysis "preserves".

2. **Cut the agenda extension to what the reader needs, and number its results.** Section 6 becomes: (a) Proposition 8, the public agenda gap Delta v^A(o) and its sign boundary beta o = e/m; (b) Proposition 9, the sufficient region beta h < e/m for majority advantage under private information, with the m = 4 counterexample to necessity in one sentence; (c) Proposition 10, unanimity incidence (low type gains, high type loses relative to public benchmark) and the decomposition T = D + I stated as an identity, not a factorial design; (d) the Panel B numerical reversal as a table. Appendix E shrinks to the proofs of 8-10 plus the exact V_U^A display (lines 1046-1062). Everything about R_M, R_U nine-tuples, Sig^ex, Sum^econ, pushforward laws, Reynolds averages, and Q_g moves to a supplementary verification file or is deleted. Target: Section 6 at 3-4 pages, Appendix E at 4-5 pages.

3. **Replace Section 3 with the worked example from Appendix C.3.** Same parameters (m = 4, beta = 0.9, l = 0.10, h = 0.35), but evaluated at p = 0.80: show majority excluding (hegemon gets its outside option, information worth 0.01 to the low type), unanimity pooling at 0.315 (information worth 0.225 to the low type), difference 0.215. Two short paragraphs, then one sentence pointing to the empty region 0 < p <= 0.2778 so the reader is not surprised by Proposition 4. This puts the mechanism on p. 7 instead of p. 21.

4. **Remove one layer of repetition in Section 5.** Delete the longtable `tab:rents` (lines 826-871): it reprints Propositions 6 and 7 line by line. Keep `tab:privatecorrespondence` as the single summary table. Add, immediately after Proposition 7, the one-sentence plain-English reading that currently sits in the Discussion (line 1235): consensus creates rent for the weaker hegemon, and only because weak states cannot distinguish it from the stronger one. Walk the reader through Figure 2 in one paragraph instead of describing the six cells twice in prose.

5. **Fix the introduction's second contribution paragraph and the voice.** Lines 121-129: state the agenda result without beta, h, e, m ("even when the hegemon proposes first, majority can be better for it when its outside option is low relative to the share of states a winning coalition can exclude; the case for consensus then rests entirely on the informational rent"). Add one sentence flagging that the baseline has a belief region with no pure-strategy equilibrium, since the abstract already says so. Choose "I" or "we" and apply it throughout (currently "I" at lines 109-110, "we" from line 413). Correct "OMC" (line 78), "The current paper" (line 105), and the sentence at line 52.
