# Parecer de Exposition (Framework Edmans) — formal_model_v5.Rmd

**Data**: 2026-04-27
**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (screening-only architecture, BP removed from body)
**Avaliador**: Editor simulado, top journal CP (JoP/AJPS/IO)

---

## Score: 7.5/10

---

## Avaliacao por dimensao

### Clareza [Boa]

#### Qualidade da escrita

The manuscript is well-written at the sentence level. Grammar is clean, and I found no outright typos in the body text. The prose is professional and reads as polished work. A few minor issues:

1. **Repetition within paragraphs.** The paragraph after Proposition 1 (line 287) contains near-identical statements back-to-back: "Because the hegemon's vote is never needed, weak states never face a choice between offers that depend on inferring the hegemon's type. The hegemon's private information affects the value of the agreement but creates no strategic discontinuity." Then two sentences later: "Under majority, the hegemon's private information affects the value of the agreement but creates no strategic discontinuity and no screening rent." The second sentence adds only "and no screening rent" to what was already stated. This verbatim echo within a single short paragraph signals drafting that was not fully tightened.

2. **Long sentences in the introduction.** Paragraph 2 of the intro (line 57) is a single 117-word sentence. While grammatically correct, it forces the reader to hold too many clauses in working memory. Breaking it into 2-3 sentences would improve comprehension. Similarly, the second sentence of paragraph 3 (line 59) is 42 words, which is fine, but it follows a 39-word sentence, and together they form a block that could be more rhythmically varied.

3. **Comment artifact in source.** Line 181: `% (Signal design node removed -- no Bayesian persuasion in v5)` and line 843: `<!-- B.4 (Proof of Proposition 4) deleted: Proposition 4 removed in v5. -->`. These are invisible in compiled PDF but violate the "paper is a timeless document" principle and could confuse co-authors or reviewers who see the source.

4. **Notation table label.** The notation table in Appendix A (lines 699-735) has no `\label{}` and no caption, making it unreferenceable. This is a formatting gap, not a typo, but it signals incomplete polish.

#### Significancia substantiva

This is a theoretical paper, so the analog of "substantive significance" is whether the results are stated with memorable, concrete magnitudes. The paper does this well in several places:

- **Example 1 (line 378-380):** "27% more than majority on the aggressive branch and 41% more on the conservative branch" — these are concrete, memorable numbers that anchor the reader's understanding of the mechanism's magnitude.
- **Alpha-star examples (line 426):** "$\alpha^* \approx 0.47$ when $N = 5$ but falls to $\approx 0.03$ when $N = 164$" — excellent. This immediately tells the reader the scope condition in substantive terms.
- **Example 2 (line 477-480):** "at $p = 0.50$, the hegemon's payoff under unanimity exceeds majority by 25%" — again, concrete and memorable.
- **Remark 1 (line 433):** "increasing $\alpha$ from $0.05$ to $0.49$ (an 18-fold increase beyond $\alpha^*$) only lowers $\bar\mu$ from $0.87$ to $0.71$" — this is a strong way to communicate robustness.

The abstract, however, is weaker on this front. It contains no numbers at all. The main result is stated as "weaker states pay more than necessary to secure agreement" — how much more? Even one illustrative number (e.g., "up to 41% more than under majority rule in calibrated examples") would make the abstract substantially more memorable.

#### Precisao da linguagem

Generally precise. The paper defines its terms carefully and uses them consistently. A few areas of concern:

1. **"Informational power" is never formally defined.** The title uses it, the abstract uses it, the introduction uses it repeatedly, but there is no Definition or even a clear one-sentence statement of what "informational power" means in this model. The reader must infer it means "the payoff advantage arising from the screening problem created by private information under unanimity." A one-sentence definition early in the introduction would sharpen the contribution claim.

2. **"Institutional technology of power" (line 55).** This is a striking phrase but somewhat vague. Technology in what sense? The paper means that unanimity is an institutional arrangement that converts informational asymmetry into bargaining advantage, but "technology of power" could mean many things. The phrase works as a hook but should be followed immediately by a precise restatement, which it roughly is in the next sentence — but the connection could be tighter.

3. **"Promising enough" (line 59, abstract line 36).** The abstract says "once cooperation is promising enough for weaker states to participate under unanimity." This is imprecise — promising in what sense? The paper means "when the prior belief that $\theta=1$ exceeds the entry threshold $\tau(U)$." A more precise phrasing: "once the expected value of cooperation exceeds the threshold for participation under unanimity."

4. **Remark 2 label (line 472).** The remark is labeled "Information design" but its content is about Bayesian persuasion. In the v5 architecture where BP has been demoted, calling it "information design" is appropriate, but the remark still name-drops "Kamenica and Gentzkow 2011" without a formal citation key — it says `Kamenica and Gentzkow 2011` in plain text rather than `@kamenica2011bayesian`. This will not generate a proper citation in the compiled PDF.

---

### Extensao [Adequado, tendendo a Longo]

#### Introducao

The introduction spans lines 47-61, approximately 1.5 pages. This is well within the 6-page ceiling and is appropriate for the complexity of the argument. The structure is clean: paragraph 1 poses the puzzle, paragraph 2 establishes why existing answers fall short, paragraph 3 states the contribution, paragraph 4 describes the model and results, paragraph 5 gives substantive implications, paragraph 6 provides a roadmap.

**Strengths:**
- No wasted space on truisms ("international cooperation matters," "institutions shape behavior").
- Literature is handled in paragraph 2, separated from the contribution claim in paragraphs 3-4. This follows the Edmans recommended structure.
- The contribution is clearly stated before the method.

**Weaknesses:**
- The roadmap paragraph (line 61) is mechanical and could be compressed to 2 sentences or moved to a footnote. At a top CP journal, referees know how papers are structured; "Section 2 presents... Section 3 presents... Sections 4 and 5 derive... Section 6 connects... Section 7 establishes... Section 8 discusses... Section 9 concludes" is eight section references in one sentence. This burns valuable real estate.
- The intro does not mention the parametric scope condition $\alpha < \alpha^*$ or give the reader any sense of when the result fails. The strongest version of the intro would include: "The result holds when the hegemon's bilateral alternatives are moderate relative to multilateral cooperation ($\alpha < \alpha^*$, a condition easily satisfied in small organizations but demanding in large ones)."

#### Notas de rodape

8 footnotes across the body text (lines 1-691), which is approximately 20 pages of body text. That is roughly 0.4 footnotes per page — well below the 1/page threshold. The footnotes are substantive and well-placed:

- Footnotes 1-2 (line 93): WLOG justification and outside-option form — appropriate for a formal model.
- Footnote 3 (line 96): Consensus vs. unanimity equivalence — important clarification.
- Footnote 4 (line 114): Tie-breaking convention — standard.
- Footnote 5 (line 108): All-or-nothing entry — important modeling choice that deserves a footnote.
- Footnote 6 (line 305): High-alpha regime — technical completeness.
- Footnote 7 (line 385): Entry cost interpretation and scaling — important for large-N applications.
- Footnote 8 (line 578): K>2 types cross-reference — appropriate scope marker.

No footnote is extraneous. This dimension is a clear strength of the manuscript.

#### Extensoes desnecessarias

- **Appendix C (K>2 types, lines 1033-1068):** This extension is appropriate and well-calibrated. It shows the majority-linearity result generalizes fully and is honest about limitations. The "Limitations" paragraph is unusually candid and strengthens credibility. Not excessive.

- **Remark 2 (Information design, lines 472-474):** This is a vestige of the earlier BP-centric architecture. It is short (one paragraph) and makes a relevant point, but its placement — between the Corollary and the institutional classification Proposition — interrupts the flow of the main argument. It would sit more naturally in the Discussion section or as a brief footnote.

- **The two-round BF justification paragraph (lines 102-103):** At 140 words, this is a long paragraph defending a modeling choice. It is important, but its placement between the model definition and the stage descriptions breaks the flow. Consider moving to a footnote or to the Scope section.

- **The paragraph on weak-state preferences (lines 452, starting "The corollary also implies..."):** This 150-word paragraph about why weak states participate under unanimity despite preferring majority is interesting but expands the paper's scope beyond the core question (hegemon's preference). It could be shortened to 2-3 sentences without loss.

---

### Citacoes [Precisas]

#### Problemas especificos

The bibliography is lean (19 entries) and well-targeted. Every citation serves a clear purpose. Specific assessment:

1. **No padding.** The paper does not cite papers merely for using standard methods (Baron-Ferejohn, PBE) or for well-known facts. The citations to Baron & Ferejohn (1989), Kalandrakis (2006), and Eraslan & Evdokimov (2019) in the intro are all substantively relevant — they establish the literature on exclusion in legislative bargaining that the paper builds upon.

2. **No strategic citations.** The paper does not inflate its relevance by connecting to unrelated literatures. The Fearon (1995) cite at line 580 is appropriate — it anchors the rationalist framework.

3. **One minor issue — plain-text citation.** Remark 2 (line 473) references "Kamenica and Gentzkow 2011" in running text without using the `@kamenica2011bayesian` citation key. This will produce a plain-text mention rather than a hyperlinked, formatted citation. While the .bib file contains the entry, this is a formatting error.

4. **Bhagwati (2008) citation (line 580).** The citation is used to support the claim that "the proliferation of preferential trade agreements strengthens the hegemon's outside option." This is a reasonable use, though Bhagwati's argument is more general (PTAs undermine the multilateral system). The connection to "outside option strength" is the paper's interpretation, not Bhagwati's main point. This is a mild stretch but not a mis-citation.

5. **Potential missing citations.** The paper does not cite Bardhi & Guo (2018) or Kim, Kim & Van Weelden (2025) anywhere in the body, though both appear in the .bib file. These are closely related papers (persuasion under unanimity, persuasion in veto bargaining). For a top journal submission, not engaging with the two closest formal-theory papers is a notable omission. Even if the v5 architecture has demoted BP, the screening mechanism under unanimity is thematically adjacent to Bardhi & Guo's work, and a brief mention in the Discussion would be appropriate. Similarly, Feddersen & Pesendorfer (1998), Diermeier & Myerson (1999), Ali et al. (2019), and several others in the .bib are not cited in the text — these should either be cited or removed from the .bib to avoid orphan entries.

---

## Veredicto geral sobre exposition

This is a well-written manuscript with clean prose, tight footnoting, and a lean bibliography. The introduction follows the recommended structure (puzzle, gap, contribution, method, implication) and stays within appropriate length. The concrete numerical examples (Examples 1-2, alpha-star magnitudes) are a genuine strength that anchors the theoretical argument in memorable terms. The main expositional weaknesses are: (1) the abstract lacks any concrete magnitude, making it less memorable than the body text; (2) the term "informational power" — the paper's central concept and title — is never formally defined; (3) a few passages repeat themselves or could be tightened (post-Proposition 1 paragraph, two-round justification, weak-state preference discussion); (4) Remark 2 on information design interrupts the logical flow between the Corollary and the institutional classification; and (5) several .bib entries (including two of the most closely related papers) are not cited in the text. None of these issues would individually trigger a rejection, but collectively they create an impression of a manuscript that is 85% polished — close to submission-ready but not yet at the level of final craftsmanship that distinguishes top-journal publications.

---

## Top 5 sugestoes de melhoria

1. **Add a concrete number to the abstract.** The abstract currently describes the mechanism qualitatively. Adding one illustrative magnitude — e.g., "In calibrated examples, this screening advantage gives the hegemon up to 41% higher payoffs than majority rule" — would make the abstract substantially more memorable and signal substantive significance. This is the single highest-impact change for first impressions at a top journal.

2. **Define "informational power" explicitly.** The paper's title concept should have a clear, one-sentence definition in the introduction, ideally in the contribution paragraph (line 55). Suggestion: "I define *informational power* as the payoff advantage a privately informed actor derives from being pivotal under uncertainty — the screening rent created when other players must secure its approval without knowing its type."

3. **Eliminate the repeated sentence after Proposition 1.** The paragraph at lines 287-288 says "The hegemon's private information affects the value of the agreement but creates no strategic discontinuity" twice in three sentences. Delete the second instance (line 288, "Under majority, the hegemon's private information...no screening rent") and fold "no screening rent" into the first statement.

4. **Move Remark 2 (Information design) to the Discussion.** Its current placement between the Corollary and the institutional classification Proposition interrupts the paper's argumentative climax. Relocating it to Discussion Section 8 (perhaps after the scope conditions) would preserve the content without disrupting the main thread. Also fix the plain-text "Kamenica and Gentzkow 2011" to a proper citation key.

5. **Clean up the .bib: either cite or remove orphan entries.** The .bib contains entries for Bardhi & Guo (2018), Kim, Kim & Van Weelden (2025), Feddersen & Pesendorfer (1998), Diermeier & Myerson (1999), Ali et al. (2019), Dworczak & Martini (2019), Glazer & Rubinstein (2004), Milgrom (1981), Kamenica (2019), Maggi & Morelli (2006), and the Kamenica & Gentzkow (2011) entry that is referenced only in plain text. For a top journal, either engage these papers in the text (Bardhi & Guo and Kim et al. deserve at minimum a brief "related work" mention in the Discussion) or remove the entries. Orphan .bib entries risk signaling to editors that the paper was rushed or is a remnant of a different version.
