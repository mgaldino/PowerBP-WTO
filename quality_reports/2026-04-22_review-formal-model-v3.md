# Carta Editorial — Revisao de Modelo Formal

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: formal_model_v3.Rmd
**Data**: 2026-04-22
**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decisao: R&R minor

## Scores consolidados

| Dimensao              | Score | Rating         |
|-----------------------|-------|----------------|
| Design do modelo      | 8/10  | Strong         |
| Apresentacao tecnica  | 7/10  | Adequate       |
| Exposicao             | 8/10  | Strong         |
| **Global**            | **7.7/10** | **Good — publishable with revision** |

## Sintese editorial

The v3 exposition represents a significant improvement over the dense mathematical style of v2. Proofs are entirely in the appendix, intuition paragraphs use substantive language (Hirsch style), the motivating example precedes formalization, and the main result arrives well before page 15 (Board's benchmark). The Design reviewer rates the model 8/10, noting the mechanism is "exemplary in the sense of Dixit" with the motivating example following Varian's advice "perfectly." The Exposition reviewer gives 8/10, calling the structure "textbook."

The bottleneck is the Writing (Apresentacao Tecnica) dimension at 7/10, driven by mechanical errors rather than conceptual problems. The notation table has 8+ wrong cross-references ("Def. 2" should be "Def. 1"), the appendix proof headings have systematic numbering errors (B.2 says "Proposition 3" but should be Proposition 2), the introduction's roadmap references 10 sections when there are 9, and Proposition 5 (agenda influence extension) lacks any proof. These are fixable in a single editing pass but would embarrass the paper before referees.

A positive tension exists between the Design and Exposition reviewers: both independently rate the paper highly, while the Writing reviewer identifies mechanical issues that could be mistaken for carelessness. This confirms the v2-to-v3 strategy was correct (lighter math, proofs in appendix, substantive intuition), but the migration introduced numbering artifacts that need cleanup.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

The design is strong enough to justify publication at AJPS or JoP. The mechanism is clean, the result is sharp, and the application is compelling. The Writing issues are entirely mechanical — wrong cross-references, missing proof for one proposition, "principal regime" undefined. These do not require rethinking the model. The Exposition is already strong. The revision is a formatting/cleanup pass, not a reconceptualization.

## Prioridades para revisao

1. **Fix all cross-reference errors.** Use `\ref{}` and `\eqref{}` throughout the notation table and appendix headings instead of hardcoded numbers. Specific fixes: (a) 8x "Def. 2" → "Def. 1" in notation table; (b) "Eq. (2)" → "App. A.2" for mu_s^R2; (c) "Eq. (3)" → "Eq. (1)" for mu_s^R1; (d) "Prop. 3" → "Prop. 2" for phi; (e) B.2 heading → "Proposition 2"; (f) B.3 → "Proposition 3"; (g) B.4 → "Proposition 4".

2. **Fix introduction roadmap.** Claims 10 sections but there are 9. Every reference from "Section 3" onward is off by one.

3. **Add formal definitions for screening cutoff and entry threshold.** These are load-bearing concepts used in multiple propositions but never formally defined. A Definition 2 (screening cutoff) and Definition 3 (entry threshold + value function) would make the results self-contained.

4. **Define "principal regime" explicitly** in or near Proposition 2. Currently defined only deep in Appendix A.5.

5. **Add a proof sketch for Proposition 5** (agenda influence). Currently the only result without any proof reference.

## Recomendacao estrategica ao autor

The paper is close to submission-ready. The v3 restructuring successfully addressed the main exposition weakness (too much math in the body). What remains is a cleanup pass to fix mechanical errors introduced during the restructuring. The model design is strong (8/10) and does not need revision. The exposition style is effective (8/10). The Writing issues (7/10) are all fixable in one session.

Target: JoP (best fit for clean formal theory with substantive motivation) or AJPS (more competitive but appropriate). Submit after the cleanup pass.

---

## Parecer completo — Design do Modelo

Score: 8/10

**MD1. Qualidade da pergunta [Excelente].** Genuine political puzzle (why consensus?), well-documented empirically, passes Varian's interest test. Paper correctly formulates as "when and why" (conditional), not "always."

**MD2. Simplicidade e KISS [Excelente].** Binary types, d_W=0, random proposals, two rounds — each is the minimum needed. Passes Schelling-Spence test: removing any component eliminates the phenomenon.

**MD3. Isolamento do mecanismo [Excelente].** Mechanism is linear and each link is verifiable: unanimity → inclusion → screening → jump → non-convexity → BP exploitation. Majority provides the "control experiment."

**MD4. Riqueza de insights [Rica].** Single-crossing, alpha-independence of cutoff, non-monotonic agenda influence, N-comparative statics, GATT/WTO narrative. The alpha-independence result is the type that makes a reader stop and think.

**MD5. Tipo de contribuicao [Forca politica isolada — Forte].** New force (informational power via screening under unanimity) + important application (IO design). Not a new framework or technical contribution. Appropriate for AJPS/JoP.

**MD6. Processo de construcao [Maduro].** Motivating example first, worked example with magnitudes, baseline + extensions, special cases (beta=1), honest scope section. Shows iterative refinement.

Sugestoes: (1) Explicitar novidade do mecanismo vs. intuicoes previas (Steinberg). (2) Comprimir GATT/WTO discussion. (3) Discutir commitment assumption mais frontalmente. (4) Considerar "Proposition 0" sem BP como baseline. (5) Comprimir Appendix D.

---

## Parecer completo — Apresentacao Tecnica

Score: 7/10

**D2. Apresentacao [Adequado].** Canonical order respected; model in ~4 pages; motivating example precedes general model.

**D3. Notacao [Precisa melhorar].** 8+ wrong cross-references in notation table ("Def. 2" throughout should be "Def. 1"); shorthand x ≡ (N-1)αr defined in main text but used only in appendix; R overloaded (voting rule and bargaining round).

**D4. Definicoes [Precisa melhorar].** Only one formal Definition environment. Screening cutoff, aggressive/conservative offer, entry threshold, overpayment — all introduced in running prose without formal definitions.

**D5. Enunciado dos resultados [Adequado].** Clear context-statement-proof-intuition sequence. Takeaway messages are substantive.

**D6. Provas [Precisa melhorar].** Proofs appropriately in appendix. But: (a) appendix proof headings have wrong proposition numbers (B.2 says "Prop 3", should be Prop 2, etc.); (b) Proposition 5 has no proof; (c) "principal regime" undefined.

**D7. Figuras [Excelente].** Two game trees, screening schematic (TikZ), computed value functions, parameter regions, alpha* plot. Labels complete. Fig. 3 (screening schematic) is particularly effective.

**D8. Assumptions [Adequado].** Key assumptions introduced when needed. Scope conditions discussed in Section 9.3. WLOG normalization footnoted.

**D9. Exemplos [Excelente].** N=3 motivating example, Example 1 with concrete magnitudes, GATT/WTO illustration. Gap: no worked example after Theorem 1.

Sugestoes: (1) Fix all cross-reference errors with \ref{} and \eqref{}. (2) Fix roadmap (10 → 9 sections). (3) Add formal definitions for cutoff and entry threshold. (4) Define "principal regime." (5) Add proof sketch for Prop 5. (6) Move x definition to appendix. (7) Give mu_s^R2 a numbered equation. (8) Clarify whether p* is truly "closed-form."

---

## Parecer completo — Exposicao

Score: 8/10

**ME1. Estrutura [Excelente].** Textbook flow: puzzle → example → model → building blocks → main result → extensions → conclusion. Main result before page 15. Preview paragraph (Section 3.2) tells reader where they're going. Baseline before extensions.

**ME2. Introducao [Adequada].** Contribution clear in first paragraphs. No laundry list. Issues: (a) paragraph 4 too long and does too much (defines two power types + positions against 4 literatures); (b) paragraph 7 repeats earlier content; (c) roadmap paragraph is mechanical.

**ME3. Escrita e estilo [Adequado].** Clear, professional, consistent present tense, first person singular. Few footnotes (good discipline). Issues: (a) "screening rent" and "informational rent" used interchangeably — choose one; (b) one long sentence in Section 9.3.

**ME4. Extensao [Adequado].** Core result before p.15. Extensions justified. Issues: (a) GATT/WTO discussion (Section 9.2) is the longest subsection, includes speculation beyond the model; (b) Appendix D (K>2) is ~4 pages — could be tighter.

**ME5. Exemplos e intuicao [Excelente].** The paper's strongest dimension. Motivating example is model work (Varian: "always, always, always work an example"). Example 1 anchors with magnitudes. Fig. 3 communicates the mechanism visually. Every result explained in plain English after the formal statement. Gap: no worked example after Theorem 1 computing p* for specific parameters.

Top 5 sugestoes: (1) Add worked example after Theorem 1. (2) Cut or compress intro paragraph 7. (3) Shorten GATT/WTO speculation. (4) Harmonize "screening rent" / "informational rent." (5) Make roadmap substantive or remove.
