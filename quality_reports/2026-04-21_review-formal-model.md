# Carta Editorial — Revisao de Modelo Formal

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (University of Sao Paulo)
**Data**: 2026-04-21
**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decisao: R&R minor

## Scores consolidados

| Dimensao              | Score | Rating         |
|-----------------------|-------|----------------|
| Design do modelo      | 8/10  | Strong         |
| Apresentacao tecnica  | 7/10  | Adequate       |
| Exposicao             | 7/10  | Adequate       |
| **Global**            | **7.5/10** | **Good — publishable with revision** |

## Sintese editorial

This paper offers a clean, well-identified mechanism — screening via pivotal inclusion under unanimity, exploited by Bayesian persuasion — to answer a genuine political puzzle (why would a hegemon prefer consensus?). The design is the paper's main strength: the mechanism is isolated with precision, the model is parsimonious, and the single-crossing result (Theorem 1) is a sharp, tractable characterization of the institutional comparison. The worked example, the GATT/WTO illustration, and the intuition paragraphs after formal results demonstrate mature modeling craft.

The principal weaknesses are in presentation and exposition, not in the underlying model. All three reviewers converge on the same diagnosis: the paper is too long for what it delivers, with the main result arriving too late (~p.18-20 vs. Board's p.15 benchmark). Section 2 is redundant with the introduction; the Lemma 1 proof appears in full in both the body and the appendix; Appendix D (K=3 extension) is an ambitious mini-paper that does not reach a general conclusion and competes with the main result for attention. The introduction has excess length (laundry list of results, overly detailed roadmap, explicit "three contributions" paragraph). The notation proliferates: 25+ symbols, a $\phi$ conflict between the main text and Appendix C, and one-letter auxiliary variables ($P$, $Q$, $A$, $B$) that are not mnemonic.

A positive tension exists between reviewers: the Design reviewer rates the model 8/10 and notes that the mechanism is "exemplary in the sense of Dixit," while the Writing and Exposition reviewers rate 7/10 each, noting that the strong mechanism is somewhat obscured by the presentation. This suggests that targeted revision — trimming, restructuring Theorem 1, adding visual aids — would significantly raise the overall quality without touching the model itself.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

The design is strong enough to justify the paper's publication at a top political science journal (AJPS, JoP). The bottleneck is not the model but its packaging. The mechanism is clean, the result is sharp, and the application is compelling. The fact that both the Writing and Exposition reviewers independently suggest the same interventions (cut Section 2, shorten the intro, add a game tree, restructure Theorem 1, trim Appendix D) indicates that these are genuine obstacles to the paper's reception, not matters of taste.

The investment required is modest: these are cuts and reorganizations, not reconceptualizations. The model does not need revision. What needs revision is how the model is presented to the reader.

## Prioridades para revisao

1. **Cut Section 2 and replace with a motivating example.** Section 2 ("Consensus and Informational Power") repeats the introduction without formal content. Replace it with a concrete 3-player example (1 hegemon, 2 weak states) that shows intuitively why unanimity creates screening and majority does not. This simultaneously shortens the paper, adds pedagogical value, and follows Dixit/Varian's "example before formalization" principle.

2. **Restructure Theorem 1.** The 4-case structure is comprehensive but hard to parse. Restructure as: (i) a Theorem stating the single-crossing property and the closed-form $p^*$ for the generic case; (ii) a Corollary handling degenerate cases. Move the pre-theorem notation block ($\lambda_M$, $\kappa_M$, $S_U$, $S_M$) into the proof. Add a worked example immediately after computing $p^*$ for specific parameters.

3. **Add two figures: a game tree and a screening schematic.** The timing and information structure are described verbally but never shown visually. A TikZ game tree (3 stages, information sets marked) and a schematic of the aggressive/conservative offers with the jump at $\mu_s^{R1}$ would make the mechanism immediately visible. These are the paper's "elevator pitch" in visual form.

4. **Trim the paper by ~5 pages.** Specific cuts: (a) shorten the introduction to 8-10 paragraphs (cut laundry list, roadmap, explicit contributions paragraph); (b) move the full Lemma 1 proof to Appendix B.5 and keep only a 3-sentence sketch in the body; (c) reduce Appendix D to a one-page robustness note (keep Proposition D.1 on general K screening boundaries, drop the numerical analysis, tables, and simplex figures); (d) eliminate the redundancy between body and appendix proofs.

5. **Fix notation issues.** (a) Resolve the $\phi$ conflict between the main text (line 247) and Appendix C (line 908); (b) add a notation summary table in Appendix A; (c) use mnemonic names for proof auxiliaries ($C_{\text{buy}}$ instead of $P$, etc.); (d) avoid reusing $p_H$ for recognition probability when $p$ already denotes the prior.

## Recomendacao estrategica ao autor

The paper is ready for submission to AJPS or JoP with one round of tightening. The model is sound, the mechanism is clean, and the result is sharp. The revision is purely about presentation: trim, restructure, visualize. None of the suggested changes require modifying the model or re-deriving results.

The AJPS target is appropriate. The paper's combination of a political puzzle, a formal mechanism, and testable implications fits AJPS's appetite for theory with empirical relevance. JoP is a strong fallback. RIO would also be receptive but the paper's generality (the mechanism applies beyond trade) makes a general-interest venue more impactful.

One strategic consideration: if the author wishes to strengthen the paper further before submission, the single highest-value addition would be a calibrated numerical example for the GATT/WTO (rough values of $r$, $\alpha$, $N$ for early GATT rounds), which would bridge the gap between the formal model and the empirical application. This is not required but would be distinctive.

---

## Parecer completo — Design do Modelo

# Parecer de Design do Modelo (Dixit / Varian / Board)

## Score: 8/10

## O modelo em uma frase

Um hegemon com informacao privada sobre o valor da cooperacao escolhe entre unanimidade e maioria; unanimidade forca weak states a screening sob incerteza, gerando nao-convexidade que Bayesian Persuasion explora, enquanto maioria elimina screening ao permitir coalizoes que excluem o hegemon.

## Tipo de contribuicao (Board & Meyer-ter-Vehn)

**Forca politica isolada** + **Pergunta nova (parcialmente)**. O paper isola um mecanismo especifico -- informational power via screening sob unanimidade -- que explica por que um hegemon preferiria consenso. Nao e um modelo novo no sentido de framework geral, nem uma contribuicao tecnica pura. E a identificacao de uma forca politica (informational rent via pivotal inclusion) que opera diferentemente sob duas regras institucionais. A pergunta e genuina, mas parcialmente precedida na literatura: a ideia de que consenso pode beneficiar atores poderosos ja foi articulada informalmente (Steinberg 2002, a propria nocao de "shadow of the law"). O que e novo e o mecanismo formal preciso -- screening + BP -- e a demonstracao de que a comparacao tem single-crossing property.

## Avaliacao por dimensao

### MD1. Qualidade da pergunta [Excelente]

O puzzle e genuino e politicamente importante: por que EUA aceitaram consenso no GATT/WTO quando maioria lhes daria exclusion power? A pergunta vem do mundo real (Dixit: "big puzzles"), nao de uma lacuna tecnica na literatura. O paper articula claramente por que o leitor deveria se importar -- a resposta reorganiza como pensamos sobre design institucional em IOs, movendo o frame de "poder vs. restricao" para "qual tipo de poder a instituicao ativa". O teste de interesse de Varian passa: qualquer estudante de RI entende a questao.

Uma ressalva: o paper poderia ser mais explicito sobre o grau de novidade da intuicao. Steinberg (2002) ja argumenta que EUA exercem poder "in the shadow of the law" sob consenso. O que e genuinamente novo e o mecanismo via screening e BP, nao a observacao de que consenso pode servir ao hegemon. O paper reconhece isto parcialmente (linhas 50-51: "existing accounts either see consensus as constraining powerful states or as a concealment for conventional power"), mas a distincao poderia ser mais afiada.

### MD2. Simplicidade e KISS [Adequado]

O modelo e enxuto em varios aspectos: estado binario, two-round Baron-Ferejohn, outside option linear, N generico, d_W=0 (normalizacao WLOG). Cada premissa stark clarifica: o binario theta gera screening discreto; dois rounds dao continuation values em closed form; d_H = alpha*V(theta) captura bilateral alternatives proporcionais; random proposer isola voting rule.

O teste Schelling-Spence passa: se removermos a unanimidade (pivotal inclusion), screening desaparece; se removermos a assimetria informacional (H observa theta), nao ha BP; se removermos o custo de entrada, nao ha entry channel. Cada componente e necessario.

Entretanto, ha pontos de tensao com KISS:

1. **A convencao WLOG de inclusao sob maioria** requer um paragrafo de justificativa e uma nota sobre quando quebraria. A indiferenca de W entre incluir e excluir H sob maioria depende de outside option deterministica e sem friccao, o que e uma premissa substantiva disfarada de convencao.

2. **O Appendix D (K=3)** adiciona 120 linhas de extensao que nao trazem insight qualitativamente novo alem de "o mecanismo generaliza". Board: "One paper, one model."

3. **A formula do cutoff R1** envolve uma quadratica com raiz menor, dependente de phi, que por sua vez depende de r, N, beta. O caso beta=1 (cutoff = 1/(N-2)) e cristalino e deveria aparecer primeiro como motivacao, antes da formula geral.

### MD3. Isolamento do mecanismo [Excelente]

Este e o ponto forte do paper. O mecanismo e limpo e isolado com precisao:

- **Unanimidade** -> H e pivotal -> W screening (agressivo vs. conservador) -> jump no payoff de H -> nao-convexidade -> BP explora.
- **Maioria** -> H nao e pivotal -> sem screening -> payoff linear -> BP so opera via entry channel.

A diferenca entre as duas regras e *exatamente* se H e pivotal ou nao. Tudo o mais e identico. Isto e design de modelo exemplar no sentido de Dixit: isola o mecanismo com a estrutura minima necessaria. A decomposicao do Lemma 1 (D_base + delta_R2 + delta_R1) e elegante e revela exatamente de onde vem a dominancia.

### MD4. Riqueza de insights [Rica]

O modelo gera insights alem da pergunta original:

1. **Single-crossing**: a comparacao institucional nao oscila. Existe no maximo um prior threshold.
2. **Alpha-independence do cutoff R1**: no regime principal, o cutoff nao depende de alpha. O screening depende de r, beta, N, nao da forca da outside option.
3. **Non-monotonic agenda influence** (Proposicao 6): o jump e hump-shaped em p_H. Symmetric proposal rights nao sao residuais -- sao otimos localmente.
4. **Transferibilidade**: o mecanismo poderia aplicar-se a qualquer comite com veto player informado.
5. **Observable implication**: a vantagem do hegemon deveria ser maior em areas de alta assimetria informacional.

Limitacao: a estatica comparativa em N e discutida qualitativamente mas nao explorada em profundidade.

### MD5. Tipo de contribuicao [Forca politica isolada -- forte]

A contribuicao principal e isolar uma forca politica: informational power via screening sob unanimidade. A combinacao de Baron-Ferejohn + Kamenica-Gentzkow + voting rules e que produz o insight. Nao ha contribuicao tecnica significativa, o que e *positivo*: o paper usa ferramentas conhecidas para gerar insight novo.

### MD6. Processo de construcao [Maduro]

O paper mostra sinais claros de iteracao e refinamento: Worked Example com magnitudes concretas, baseline + extensoes, casos especiais informativos (beta=1), dois paineis na Figura 1 ("strong" vs. "weak" mechanism), discussion honesta com scope conditions explicitas.

## Veredicto geral sobre design

O design do modelo e forte e bem executado. O puzzle e genuino, o mecanismo e limpo e isolado, as premissas sao stark no sentido produtivo, e o modelo gera insights alem da pergunta original. O paper esta no nivel de um top general-interest journal em CP. O score reflete que o design e solido mas nao excepcional -- falta o elemento de surpresa radical que distingue os melhores modelos. O que eleva o paper e a *combinacao* e a *aplicacao*, nao um unico resultado que muda como pensamos sobre um problema.

## Sugestoes construtivas

1. **Explicitar a novidade da intuicao vs. formalizacao.** Citar mais diretamente Steinberg (2002), Gould (2022) e dizer: "These accounts describe the pattern; the present paper provides the mechanism."

2. **Reduzir drasticamente o Appendix D.** Manter statements das proposicoes, eliminar analise numerica e figuras no simplex.

3. **Enderecar a convencao de inclusao sob maioria mais frontalmente.** Modelar exclusao explicitamente eliminaria o paragrafo defensivo.

4. **Apresentar beta=1 como caso base antes do caso geral.** Cutoff 1/(N-2) e memoravel e transparente.

5. **Adicionar estatica comparativa formal em N.** Um resultado formal sobre como alpha* decresce com N daria ao leitor uma formula para escalabilidade.

6. **Considerar renomear "informational power" para algo mais preciso.** "Screening leverage" ou "informational rent from pivotal inclusion" diferenciariam o paper na literatura.

---

## Parecer completo — Apresentacao Tecnica

# Parecer de Apresentacao Tecnica (Thomson / Board)

## Score: 7/10

## Estrutura do modelo

The game has $N \geq 3$ players (1 hegemon $H$, $N-1$ weak states). Nature draws $\theta \in \{0,1\}$ with prior $p$; $H$ observes $\theta$, $W$'s do not. $V(\theta) \in \{1, r\}$ is the cooperation surplus. Disagreement payoffs: $d_W = 0$, $d_H = \alpha V(\theta)$. Timing: Stage 0 (institutional choice $R \in \{M, U\}$), Stage 1 (signal design + entry), Stage 2 (two-round Baron-Ferejohn bargaining under rule $R$). Solution concept: PBE with tie-breaking convention (accept at reservation). The institutional comparison rests on the single-crossing property: unanimity dominates above a threshold prior $p^*$, majority can dominate below it.

## Scorecard

| Dimensao | Veredicto | Comentario |
|----------|-----------|------------|
| D2. Apresentacao | Adequado | Canonical order mostly respected; model section is ~3 pages but the full model exposition stretches across Sections 3-7 (~11 pages). |
| D3. Notacao | Precisa melhorar | Several guessable symbols, but proliferation of auxiliary quantities ($\phi$, $\omega$, $x$, $P$, $Q$, $\lambda_M$, $\kappa_M$, $S_U$, $S_M$, $D_{\text{base}}$, $\delta_{R2}$, $\delta_{R1}$) strains the reader; $\phi$ reused in Appendix C with different meaning. |
| D4. Definicoes | Adequado | Two formal Definitions with typographic distinction; but several key quantities introduced inline without formal definition environment. |
| D5. Enunciado dos resultados | Precisa melhorar | Propositions 1-5 build well, but Theorem 1's 4-case structure is hard to parse; headline (single-crossing) appears as afterthought. |
| D6. Provas | Precisa melhorar | Proofs in the body sometimes too compressed; Lemma 1 proof is heavily symbolic with minimal verbal scaffolding; forward reference to appendix within proof. |
| D7. Figuras | Adequado | Two multi-panel figures present; labels and legends complete; no game tree or screening schematic. |
| D8. Assumptions | Adequado | Key assumptions introduced at the right moments; plausibility discussed; parameter restriction relationships could be clearer. |
| D9. Exemplos | Precisa melhorar | One worked example with concrete numbers; no geometric illustration of screening; GATT/WTO is verbal, not numerical. |

## Analise detalhada

### D3. Notacao

**Diagnostico.** The paper introduces at least 25 distinct symbols. Some are guessable ($V(\theta)$, $p$, $\mu$, $\alpha$). Others are not: $\phi$ is defined as $[rN - \beta(N-1+r)]/[\beta(r-1)]$ in the main text but redefined as $p_H + (1-p_H)\alpha$ in Appendix C. The auxiliary terms $P$, $Q$, $D_{\text{base}}$, $\delta_{R2}$, $\delta_{R1}$ appear only in the Lemma 1 proof. $S_U$, $S_M$, $\lambda_M$, $\kappa_M$ are introduced immediately before Theorem 1.

**Impacto.** Thomson: "the best notation is notation that can be guessed." The $\phi$ conflict will confuse referees reading the appendix after the main text.

**Sugestao.** (1) Eliminate $\phi$ from the main text or rename one usage. (2) Replace $P$ and $Q$ with mnemonic names. (3) Provide a notation table in Appendix A. (4) Avoid reusing $p_H$ for recognition probability when $p$ denotes the prior.

### D5. Enunciado dos resultados

**Diagnostico.** Theorem 1 has a 4-case structure with nested conditions. The single-crossing property — the headline result — appears as the last sentence ("In particular..."). The closed-form $p^*$ appears inside two of four cases.

**Impacto.** A referee will remember "single-crossing" but not the exact conditions for each case. The theorem is doing too much work.

**Sugestao.** Restructure as: (i) a Theorem stating the single-crossing property and $p^*$ for the generic case; (ii) a Corollary for degenerate cases. Add a worked example immediately after.

### D6. Provas

**Diagnostico.** The Lemma 1 proof is the most important and the most compressed. The decomposition into $D_{\text{base}} + \delta_{R2} + \delta_{R1}$ is presented as a fait accompli without motivation. The phrase "one shows (Appendix B.5)" is a forward reference within a proof, which Thomson warns against.

**Impacto.** A referee checking Lemma 1 must reconstruct the decomposition from scratch.

**Sugestao.** Add a 3-sentence proof sketch before the formal proof. Move the full proof to Appendix B.5 and keep only the sketch in the body.

### D9. Exemplos

**Diagnostico.** Only one worked example for the entire main model. Missing: a worked example for Theorem 1 (computing $p^*$), a geometric illustration of the screening mechanism, and numerical calibration for the GATT/WTO.

**Sugestao.** Add Example 2 after Theorem 1 computing $p^*$ for specific parameters. Add a rough GATT/WTO calibration in a footnote.

## Inventario de notacao

| Simbolo | Significado | Introduzido em | Problema? |
|---------|-------------|-----------------|-----------|
| $N$ | Number of players | Def. 2 | No |
| $H$, $W_j$ | Hegemon, weak states | Def. 2 | No |
| $\theta$ | State of the world | Def. 2 | No |
| $p$ | Prior $\Pr(\theta=1)$ | Def. 2 | No |
| $V(\theta)$ | Value of cooperation | Def. 2 | No |
| $r$ | $V(1)$, high-type value | Def. 2 | No |
| $\alpha$ | Outside option share | Def. 2 | No |
| $\beta$ | Discount factor | Def. 2 | No |
| $c$ | Entry cost | Def. 2 | No |
| $V_e(\mu)$ | Expected cooperation value | Line 131 | No |
| $x$ | $(N-1)\alpha r$ shorthand | Line 131 | Low value |
| $\mu$ | Posterior belief | Sections 4-8 | No |
| $q$ | Majority quota | Line 157 | Introduced implicitly |
| $R$ | Voting rule $\in \{M, U\}$ | Def. 1 | No |
| $\mu_s^{R2}$ | R2 screening cutoff | Eq. (2) | No |
| $\mu_s^{R1}$ | R1 screening cutoff | Eq. (3) | No |
| $\phi$ | R1 cutoff auxiliary | Eq. (3) | **Reused in App C** |
| $\omega(\mu)$ | $(N-2)\beta V_W^{R2}(\mu)$ | App A.3 | Not in main text |
| $\tau(R)$ | Entry threshold | Line 296 | No |
| $v(\mu, R)$ | H's value function | Lines 306-309 | No |
| $\lambda_M$ | Majority payoff coefficient | Line 548 | Not guessable |
| $\kappa_M$ | Entry coefficient | Line 552 | Not guessable |
| $S_U$, $S_M$ | Max slope of value function | Lines 556-558 | Definition via optimization |
| $P$, $Q$ | Proof auxiliaries | Lemma 1 proof | Not mnemonic |
| $D_{\text{base}}$, $\delta_{R2}$, $\delta_{R1}$ | Decomposition terms | Lemma 1 proof | OK |
| $\alpha^*$ | Conditional dominance threshold | Lemma 1 | No |
| $p^*$ | Threshold prior | Thm 1 | No |
| $p_H$, $p_W$ | Recognition probs (extension) | App C | $p_H$ conflicts with prior $p$ |
| $\phi$ (App C) | $p_H + (1-p_H)\alpha$ | App C.1 | **Conflicts with main text** |

## Analise resultado-a-resultado

### Proposition 1 (Majority produces no screening)
- **Statement**: Clear. "Affine in posterior beliefs, no screening cutoff."
- **Proof**: Short, self-contained, correct.
- **Intuition**: Good paragraph.
- **Assessment**: Solid.

### Proposition 2 (Overpayment under unanimity)
- **Statement**: Clear inequality.
- **Proof**: Trivial comparison.
- **Assessment**: More of a remark than a proposition.

### Proposition 3 (R1 screening cutoff)
- **Statement**: Complex — conditional on Case 2.
- **Proof**: Existence/uniqueness sketch; uniqueness claim asserted not shown.
- **Assessment**: Consider stating general result first, closed form as corollary.

### Proposition 4 (Jump)
- **Statement**: Clear closed-form magnitude.
- **Intuition**: Excellent comparative statics paragraph.
- **Assessment**: Very good.

### Proposition 5 (Additional non-convexity)
- **Statement**: Qualitative where it could be semi-quantitative.
- **Assessment**: Consider adding a bound on the concavification gain.

### Lemma 1 (Conditional payoff dominance)
- **Statement**: Clear conditional.
- **Proof**: Long, symbolic, forward reference to appendix.
- **Assessment**: Proof needs verbal scaffolding; move full proof to appendix.

### Theorem 1 (Threshold prior)
- **Statement**: 4-case structure, headline buried.
- **Assessment**: Restructure as theorem + corollary.

### Proposition 6 (Non-monotonic agenda influence)
- **Statement**: Hump-shaped relationship.
- **Assessment**: Well-presented for an extension.

## Sugestoes construtivas

1. **Add a game-tree figure** showing all three stages with information sets.
2. **Restructure Theorem 1** as main theorem (single-crossing + $p^*$) plus corollary (degenerate cases).
3. **Add a worked example after Theorem 1** computing $p^*$ for specific parameters.
4. **Resolve the $\phi$ conflict** between main text and Appendix C.
5. **Add a proof sketch before Lemma 1's proof** and move full proof to appendix.
6. **Add a notation summary table** in Appendix A.
7. **Merge Definition 1 into Definition 2** to present "one model" in one place.
8. **Add a screening schematic figure** showing aggressive/conservative offers and the jump.
9. **Consider demoting Proposition 2 to a Remark.**
10. **Avoid reusing $p_H$** when $p$ denotes the prior; use $\rho_H$ instead.

---

## Parecer completo — Exposicao

# Parecer de Exposicao do Modelo (Varian / Thomson / Board)

## Score: 7/10

## Avaliacao por dimensao

### ME1. Estrutura do paper [Adequada]

O paper segue uma estrutura logica clara: Introducao -> Teoria substantiva (Sec. 2) -> Comparacao institucional (Sec. 3) -> Modelo (Sec. 4) -> Maioria (Sec. 5) -> Unanimidade (Sec. 6) -> Entry e BP (Sec. 7) -> Resultado principal (Sec. 8) -> Discussao (Sec. 9) -> Conclusao (Sec. 10). O baseline e resolvido antes da extensao.

Problemas: (1) O resultado principal chega tarde (~p.18-20). Board recomenda antes da p.15. (2) A Secao 2 e uma secao teorica substantiva que repete a introducao sem avancar formalmente — adiciona ~2 paginas entre a introducao e o modelo sem resultado novo. (3) O Apendice D (K>2) e quase um mini-paper (~120 linhas com proposicoes, tabelas e figuras proprias).

### ME2. Introducao [Precisa melhorar]

A introducao e clara sobre o puzzle e a contribuicao, com gancho na primeira pagina. Problemas:

(1) **Excesso de comprimento.** ~20 paragrafos; deveria ter 8-10. O quarto paragrafo repete a Secao 2.

(2) **Laundry list de resultados.** "The analysis yields three main results" enumera tres resultados tecnicos. Board adverte contra isso. Substituir por uma frase de intuicao.

(3) **Roadmap excessiva.** Lista 10 secoes uma a uma. Uma frase basta.

(4) **Paragrafo de contribuicoes explicito.** "This paper contributes in three ways" — formulacao que top journals desaconselham.

(5) **Contexto motivacional redundante.** Paragrafos 2 e 3 poderiam ser condensados.

### ME3. Escrita e estilo [Adequado]

**Pontos fortes:** Linguagem clara; frases curtas e diretas; consistencia de voz; footnotes com parcimonia; provas mecanicas no apendice.

**Problemas:** (1) Frase iniciando com simbolo (line 131: "$V_e(\mu) \equiv ...$"). (2) Paragrafos excessivamente longos (WLOG convention, ~10 linhas). (3) Prova do Lemma 1 duplicada entre corpo e apendice — Varian: "Put the tedious stuff in the appendix." (4) ~250 linhas de codigo R no .Rmd que deveriam estar em scripts/ separado. (5) Tie-breaking convention com destaque excessivo; footnote bastaria.

### ME4. Extensao e quando parar [Longo]

O paper e longo para teoria formal de CP (~30 paginas + 4 apendices). Varian: "People only remember about 10 pages."

(1) Secao 2 deveria ser cortada ou fundida com a introducao.
(2) Apendice D e extensao excessiva para um resultado de robustez.
(3) Apendice C (partial agenda influence) e bem calibrado.
(4) Resultado principal deveria aparecer mais cedo.

### ME5. Uso de exemplos e intuicao [Adequado]

**Pontos fortes:** Example 1 e excelente (parametros concretos, magnitudes, comparacao). Ilustracao GATT/WTO ancora o modelo. Figuras 1 e 2 informativas. Paragrafos de intuicao apos cada proposicao.

**Problemas:** (1) Falta exemplo motivador *antes* do modelo — um exemplo simples de 3 jogadores daria intuicao imediata. (2) Falta exemplo geometrico (game tree, screening cutoff como funcao de parametros). (3) Observavel implication enterrada na Secao 9.2 — deveria estar na introducao.

## Veredicto geral sobre exposicao

O paper tem estrutura logica solida, contribuicao clara e escrita de qualidade. O mecanismo e explicado com competencia. O principal problema e que o paper e longo demais para o que entrega: Secao 2 redundante, prova do Lemma 1 duplicada, Apendice D ambicioso demais. Com enxugamento da introducao, eliminacao da Secao 2 e encurtamento do corpo, o paper ficaria mais proximo do padrao de ~25 paginas que AJPS e JoP esperam.

## Top 5 sugestoes de melhoria

1. **Eliminar a Secao 2 e substituir por um exemplo motivador simples antes do modelo.** A Secao 2 repete a introducao sem resultado formal. Um exemplo concreto de 3 jogadores daria intuicao imediata e economizaria ~2 paginas.

2. **Encurtar a introducao para 8-10 paragrafos.** Fundir paragrafos 2 e 3; eliminar laundry list de resultados tecnicos; cortar roadmap detalhada; remover paragrafo explicito de "three contributions."

3. **Mover a prova do Lemma 1 inteiramente para o apendice.** No corpo, manter apenas um sketch de 3 frases.

4. **Reduzir o Apendice D a uma nota de robustez.** Manter Proposicao D.1 e um paragrafo de verificacao numerica. Remover tabela, figuras e proposicoes adicionais.

5. **Trazer a observavel implication para a introducao.** "The hegemon's advantage should be largest in negotiations where informational asymmetry is substantial" — isso e testavel e deve estar na introducao.
