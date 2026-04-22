# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: formal_model_v3.Rmd
**Data**: 2026-04-22

## Decisao: R&R minor

## Scores consolidados

| Dimensao     | Score | Rating   |
|-------------|-------|----------|
| Contribution | 7/10  | Strong but narrow |
| Execution    | 7.5/10 | Solid |
| Exposition   | 7.5/10 | Good |
| **Global**   | **7.3/10** | **Publishable with targeted revision** |

## Sintese editorial

The paper isolates a genuinely novel mechanism — unanimity as a technology of hegemonic informational power via screening — and delivers a clean single-crossing characterization (Theorem 1). The design is the paper's strength: the question is real, the mechanism is sharp, and the model is parsimonious. All three reviewers converge on this assessment.

The principal tension is between the mechanism's formal elegance and its empirical domain. The contribution reviewer notes that the mechanism depends on discrete types (which generate the jump that BP exploits) and on a restrictive parametric condition (alpha < alpha*, which shrinks rapidly with organization size). The execution reviewer flags the same alpha* issue for the GATT/WTO application. The exposition reviewer identifies the GATT/WTO discussion as extending beyond what the model formally delivers. This is a coherent diagnosis: the formal apparatus is tight, but the paper's substantive ambitions (explaining WTO consensus) strain against the model's domain of validity.

A secondary finding across all three reviews: the v3 exposition is substantially improved over what a dense formal theory paper typically looks like. Proofs in the appendix, substantive intuition after each result, motivating example before formalization — this follows the JoP playbook effectively. The remaining exposition issues are fixable: a mis-citation (Crawford & Sobel for verifiable disclosure), cross-reference numbering errors in the appendix, and a slightly long Discussion section.

## Hierarquia Edmans aplicada

The contribution is strong enough to justify the paper's publication at AJPS or JoP. The mechanism is novel, the result is sharp, and the application is compelling. The bottleneck is not contribution per se but the *scope* of the contribution: the mechanism operates in a specific parametric regime (alpha < alpha*, discrete types, full commitment), and the paper's most interesting substantive claims (GATT-to-WTO transition, consensus as regime-dependent) go beyond what the formal apparatus delivers. Execution is solid — the model does what it claims. Exposition is good and close to submission-ready.

The revision should focus on (1) tightening the boundary between what is proven and what is conjectured, (2) fixing mechanical errors, and (3) sharpening observable implications.

## Prioridades para revisao

1. **Fix Crawford & Sobel mis-citation (line 681).** CS is cheap talk, not verifiable disclosure. Replace with Milgrom (1981) or Grossman (1981). A referee will catch this immediately.

2. **Tighten the alpha* discussion for large N.** For N > 50, alpha* is near zero. Either (a) compute alpha* for GATT founding (N=23) to show the condition was plausible, (b) argue the "effective N" for WTO negotiations is smaller than full membership (Green Room), or (c) restrict the GATT/WTO claims to the early GATT era.

3. **Shorten Discussion section 9.2 by ~30%.** The GATT-to-WTO transition and "new regimes" paragraphs are interesting but speculative. Condense to two tight paragraphs: one on informational asymmetry's plausibility in trade, one on the distinctive observable implication (vs. legitimacy, vs. self-enforcement). Move the GATT transition to a brief remark.

4. **Address the continuous-type limitation more constructively.** Currently the conclusion says this is "an open question." Either (a) argue why discrete types are substantively appropriate for IOs (qualitatively different agreement types), or (b) sketch what happens with continuous types (smooth offer schedule, no jump, but possible kinks from entry margin).

5. **Strengthen observable implications.** The prediction that consensus matters most in complex regulatory areas (services, IP) vs. transparent areas (tariff cuts) is testable. Elevate this to the introduction.

## Recomendacao estrategica ao autor

The paper is ready for submission to AJPS or JoP with one round of targeted revision. The model is sound, the mechanism is clean, and the v3 exposition is significantly lighter than v2. JoP may be the best fit: it values clean formal theory with substantive motivation, and the paper's combination of a political puzzle, a formal mechanism, and the WTO application fits well. AJPS is also appropriate but more competitive. IO would want more empirical engagement than the model provides.

The revision is modest: fix the citation, tighten the Discussion, address alpha* for large N, and clean up cross-references. None of this requires modifying the model.

---

## Parecer completo — Contribution

Score: 7/10

**Novidade [Forte].** The central insight — unanimity amplifies informational power via screening + BP, while majority eliminates it — is genuinely novel. The single-crossing result provides a sharp characterization beyond generic "it depends" claims. The mechanism is not a convex combination of known results. Caveat: the *conclusion* (hegemons can benefit from consensus) is less surprising than the *mechanism*, given Steinberg (2002).

**Importancia [Adequada].** The puzzle is genuine and the mechanism is clean. A survey would mention this result. However, practical policy relevance is constrained by the model's stylization, and the binary type assumption is a significant qualification.

**Adequacao ao escopo [Adequada].** Bibliography draws from the right literatures (Baron-Ferejohn, Kamenica-Gentzkow, IO design). Natural fit for AJPS/JoP. Could engage more with Tsebelis (veto players).

**Generalizabilidade [Adequada].** Mechanism stated for general N, K=3 extension demonstrates robustness. Limited by: (a) requires H to know the *value of cooperation* specifically, (b) commitment assumption, (c) alpha* shrinks with N.

**Trade-offs [Completo].** Explicit trade-off between screening rents and entry costs. Theorem 1 characterizes exactly when each side dominates. Discussion of when majority dominates is honest.

**Hipoteses [Claras e direcionais].** Sharp predictions: single-crossing, comparative statics in r, beta, alpha, N. Observable implication distinguishing from legitimacy and self-enforcement accounts.

Sugestoes: (1) Weaken commitment assumption or discuss robustness under cheap talk. (2) Strengthen continuous-type discussion. (3) Expand observable implications. (4) Engage with Tsebelis. (5) Address alpha* for large N more directly.

---

## Parecer completo — Execution

Score: 7.5/10. Type: Teorico.

**T.1 Distancia premissas-conclusoes [7/10].** The screening non-convexity is a genuine emergent property, not hardwired. The single-crossing result is analytically derived. However: (a) binary types are load-bearing — continuous types would eliminate the jump; (b) the exclusion convention under majority makes "no screening" almost definitional; (c) commitment does heavy lifting; (d) the comparison is between two specific packages, but the claim "consensus is a technology of power" is broader.

**T.2 Parcimonia [9/10].** Clean and parsimonious. Each moving part has a clearly assigned role. Motivating example strips to minimal 3-player form. Minor concern: two-round BF adds complexity; single-round ultimatum might produce the same qualitative result.

**T.3 Caminho causal [6.5/10].** Weakest dimension. (a) Entry is endogenous and somewhat opaque — tau(U) never gets a closed-form expression. (b) Institutional choice is ex ante (before observing theta) — this timing is crucial but under-discussed. (c) GATT/WTO discussion mixes comparative statics with dynamic claims where parameters are jointly endogenous. (d) alpha < alpha* is restrictive for large N.

Sugestoes: (1) Address the continuum explicitly. (2) Tighten alpha* for GATT/WTO. (3) Give entry channel equal analytical attention. (4) Discuss timing of institutional choice. (5) Compare more directly with Bardhi & Guo and Kim/Kim/Van Weelden.

---

## Parecer completo — Exposition

Score: 7.5/10.

**Clareza [Boa].** Writing is clear and professional. Notation is consistent. Notation table in Appendix A is good practice. Issues: (a) abstract lacks memorable magnitudes — could include the 16% surplus number from the motivating example; (b) "consistent with" used 3x in Discussion creates impression of empirical evidence that doesn't exist; (c) Crawford & Sobel mis-citation (cheap talk, not verifiable disclosure).

**Extensao [Adequado, com ressalvas].** Introduction is ~5 pages, within limits. Structure follows the recommended pattern. Issues: (a) paragraphs 3-4 of intro intercalate contribution with literature — should separate; (b) paragraph 7 repeats earlier content; (c) paragraph 8 (contributions) is redundant; (d) Discussion 9.2 (GATT/WTO) is ~70 lines, longest subsection, with speculation beyond the model; (e) endnote on K>2 and Single Undertaking is too long for a footnote.

**Citacoes [Precisas].** 17 works cited in text. Parsimonious and well-targeted. One mis-citation (Crawford & Sobel). 12 unused entries in .bib — clean before submission.

Top 5 sugestoes: (1) Fix Crawford & Sobel citation. (2) Add magnitudes to abstract. (3) Restructure intro paragraphs 3-4 to separate contribution from literature. (4) Condense Discussion 9.2. (5) Eliminate contributions paragraph or integrate.
