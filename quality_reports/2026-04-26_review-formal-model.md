# Carta Editorial — Revisao de Modelo Formal

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (University of Sao Paulo)
**Versao avaliada**: formal_model_v3.Rmd
**Data**: 2026-04-26
**Referencias**: Thomson (1999), Board & Meyer-ter-Vehn (2018), Dixit (2015), Varian (1997/2016)

## Decisao: R&R minor

## Scores consolidados

| Dimensao              | Score | Rating        |
|-----------------------|-------|---------------|
| Design do modelo      | 8/10  | Strong        |
| Apresentacao tecnica  | 7.5/10| Above average |
| Exposicao             | 7.5/10| Above average |
| **Global**            | **7.7/10** | **R&R minor** |

## Sintese editorial

This is a well-designed and analytically rigorous paper that isolates a genuine and novel mechanism for an important puzzle in international political economy. The core contribution---that unanimity makes the hegemon pivotal, creating a screening problem whose non-convexity Bayesian persuasion exploits---is precisely identified and compellingly formalized. The mechanism isolation (the four-link causal chain from voting rule to pivotal inclusion to screening to non-convexity to BP gains, plus the additive decomposition in B.5a) is the paper's greatest strength across all three dimensions.

The principal weakness is a recurring gap between the clarity of the results and the clarity of their presentation. The model design is strong (score 8), but the technical presentation and exposition (both 7.5) do not fully exploit the design's quality. Specifically: (i) key concepts (v(mu,R), alpha*, screening cutoff) lack formal definition environments, increasing cognitive load for readers who need to locate precise definitions; (ii) the appendix proofs, while correct, have a natural-language ratio below Thomson's benchmark, making verification harder than necessary; (iii) the introduction is 30-40% too long with redundant literature characterizations; and (iv) the Discussion section tries to accomplish too many goals simultaneously. None of these are fatal---they are presentation issues, not analytical ones---and all are correctable with targeted revisions.

The three reviewers converge on several points: the motivating example (Section 2) is the paper's exposition highlight; the TikZ figures are pedagogically effective; the result sequence (Props 1-4 --> Lemma 1 --> Thms 1-2) is logically impeccable; and the scope discussion is mature. Where the reviewers diverge is on emphasis: the Design reviewer flags the two-round Baron-Ferejohn structure as potentially non-minimal, while the Technical reviewer focuses on definitions and proof prose, and the Exposition reviewer on the introduction length and Discussion organization. These are complementary, not conflicting.

## Hierarquia aplicada: Design > Apresentacao > Exposicao

The design is the strongest dimension and clearly sufficient to justify the paper's contribution. The mechanism is genuinely new (not a formalization of existing verbal arguments), the biconditional alpha* result is sharp, and the single-crossing property is a clean structural result. The design fully justifies investing in improving presentation and exposition.

The main design tension---whether two rounds of bargaining are necessary---does not undermine the contribution. The core mechanism operates in one round (as the motivating example demonstrates), and the two-round structure adds genuine analytical value (alpha-independence of the cutoff, richer non-convexity). But the paper would benefit from explicitly stating what the second round buys. This is a framing issue, not a design flaw.

The presentation and exposition scores (both 7.5) reflect correctable issues. Giving formal definition environments to v(mu,R) and alpha*, adding informal preambles to the denser appendix proofs, compressing the introduction, and reorganizing the Discussion would each take modest effort and would lift both scores to 8.5+.

## Prioridades para revisao

1. **Compress introduction (30-40%)**: Merge redundant literature-gap paragraphs (paras 2-3); make the roadmap paragraph convey the logical arc, not just list sections. High impact, low effort.

2. **Formal definitions for key concepts**: Create Definition 2 for v(mu,R) before Proposition 4; define alpha* in a separate paragraph before Lemma 1 following Board's "Define p. Define q. Theorem: Every p is q" recipe. Give typographic emphasis to "screening cutoff", "entry threshold", "net gain function" at first occurrence. High impact, low effort.

3. **Increase natural-language ratio in appendix proofs (B.5, B.5a)**: Add 1-2 informal sentences before each algebraic step to reach ~55% natural language (Thomson benchmark). Focus on B.5a Steps 1-3 and B.5 Step 2. Do not add more algebra---add more explanation of existing algebra. High impact, medium effort.

4. **Reorganize and compress Discussion (Section 8)**: Separate into clear subsections: (a) GATT/WTO illustration, (b) Observable implications, (c) Scope and limitations, (d) Alternative explanations. Cut the "broader implications" paragraph (belongs in conclusion or footnote). Move heatmap figure to scope subsection. Cut ~30% total. Medium impact, medium effort.

5. **Explicitly justify the two-round structure**: State in Section 3 what the second round adds beyond the one-round motivating example: alpha-independence of the cutoff when alpha < alpha_bar, richer non-convexity with two cutoffs, off-path continuation game that pins down beliefs. Alternatively, note that the main results hold qualitatively in one round and that two rounds are the analytically richer version. Medium impact, low effort.

## Recomendacao estrategica ao autor

The paper is ready for submission to JoP with the revisions above. The design is strong enough to clear the desk-reject threshold at any top political science journal. The targeted presentation and exposition improvements (items 1-4 above) are the kind of revisions that lift a paper from "technically correct and interesting" to "a pleasure to read"---and that make referees more generous with close calls. Item 5 (justifying two rounds) is a preemptive defense against the most likely referee objection.

The commitment assumption (Bayesian persuasion) is the paper's most vulnerable point substantively. The current defense (reputation, institutional transparency, upper-bound interpretation) is adequate but somewhat defensive. Emphasizing that Lemma 1 (conditional dominance) is entirely commitment-free---and is the paper's primary contribution---while positioning BP as a natural extension that amplifies the result, would strengthen the paper's robustness against reviewers skeptical of commitment.

Fix the typo in paragraph 1 of the introduction ("relative do" --> "relative to") before submission.

---

## Parecer completo --- Design do Modelo

# Parecer de Design do Modelo (Dixit / Varian / Board)

**Paper**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Autor**: Manoel Galdino (USP)
**Data do parecer**: 2026-04-26
**Versao avaliada**: formal_model_v3.Rmd

## Score: 8/10

## O modelo em uma frase

A two-round Baron-Ferejohn bargaining game with binary private information and voluntary entry, comparing unanimity and majority rule, where unanimity forces weak states to screen the hegemon's type, creating a discrete payoff jump that Bayesian persuasion exploits.

## Tipo de contribuicao (Board & Meyer-ter-Vehn)

**New lens on an existing question + isolation of a new political force.**

The question---why a hegemon would choose consensus---is old (Steinberg 2002, Koremenos et al. 2001, Ikenberry 2001). The contribution is a new lens: combining legislative bargaining, asymmetric information, and Bayesian persuasion to isolate a specific force (informational power through screening) that has not been articulated in this institutional-choice setting. This is not a pure "new question" paper; it is a "new mechanism for an old puzzle" paper. The Board & Meyer-ter-Vehn taxonomy would classify it as "new model" (a novel combination of existing building blocks that generates a previously unidentified force) with elements of "policy force" (the comparative institutional prediction is new).

The paper is honest about this: the introduction carefully distinguishes its mechanism from prior accounts (informal agenda power, self-binding, legitimacy). The mechanism---that unanimity makes the hegemon pivotal, creating a screening problem whose non-convexity Bayesian persuasion exploits---is genuinely new in the formal institutional design literature on IOs. This is an appropriate contribution for a top field journal (JoP, AJPS).

## Avaliacao por dimensao

### MD1. Qualidade da pergunta [Excelente]

The puzzle is first-rate: why would a powerful state voluntarily adopt a rule that gives every other participant a veto? This is a genuine empirical puzzle (WTO consensus, GATT history, broader IO design). It is comprehensible to non-specialists---any political scientist can grasp the tension between power and self-constraint. The paper passes Varian's "interest test": a game theorist, an IR theorist, and an empirical IO scholar would each find something to engage with.

The paper does a good job of sharpening the puzzle into three layers (why not monopoly agenda? why not majority? why unanimity?) in the introduction. This tripartite decomposition is effective pedagogy and immediately communicates that the answer is non-trivial.

**Insight novelty vs. formalization**: The intuition that consensus might benefit powerful states is not entirely new---Steinberg (2002) argues that major trading powers benefit from consensus through informal agenda power, and the rational-design literature (Koremenos et al. 2001) has noted that voting rules serve distributional functions. However, the specific mechanism here---that unanimity creates a screening problem whose non-convexity makes information strategically productive---is new. The paper is not merely formalizing an existing verbal argument; it is identifying a qualitatively different channel (informational power through screening) that prior work has not articulated. The distinction between "informal influence persists under consensus" (Steinberg) and "consensus creates the strategic environment in which informational advantage becomes most valuable" (this paper) is substantive, not merely semantic.

One area for improvement: the paper could state more explicitly in the introduction that the novelty lies in the mechanism, not the broad claim that consensus can benefit powerful states. The current framing occasionally reads as if no one has previously suggested that hegemons benefit from consensus.

### MD2. Simplicidade e KISS [Adequado]

The model is well-disciplined but not minimal. Let me apply the Schelling-Spence test systematically:

**Essential components (removing kills the phenomenon):**
- Binary types (theta in {0,1}): Essential. Creates the discrete screening cutoff. Continuous types would generically smooth the jump.
- Unanimity vs. majority comparison: Essential. The entire paper is an institutional comparison.
- Private information for H: Essential. Without it, no screening, no BP gains.
- Voluntary entry with cost c: Essential for the entry-margin channel that creates the single-crossing result (Theorem 2). Without entry, Theorem 1 (conditional dominance) still holds, but the institutional comparison becomes trivial (unanimity always dominates when alpha < alpha*).
- Bayesian persuasion: Essential. Without it, unanimity dominates only when the institution would form under both rules. BP extends the dominance to priors below the entry threshold.

**Potentially non-essential components:**
- Two rounds of bargaining (Baron-Ferejohn): This is the component I would scrutinize most. The R1 screening cutoff, the R1 jump, and the conditional dominance result all depend on the two-round structure. But the motivating example (Section 2) achieves the same qualitative phenomenon with a single take-it-or-leave-it offer. The second round provides richer non-convexity (two screening cutoffs instead of one) and makes the cutoff independent of alpha when alpha < alpha_bar, which is analytically convenient. But the core mechanism---screening under unanimity, no screening under majority---is already present in the one-round version. The two-round structure adds analytical richness but also significant complexity (R2 branches, case selection, two cutoffs, the alpha_bar regime threshold). A referee might ask: could you get Theorems 1 and 2 with a single round?

- N players (general N): Appropriate. The paper uses N=3 only in the motivating example, and the general-N results reveal the comparative statics with respect to organization size (alpha* decreasing in N, the (N-1)/N^2 term in the jump magnitude). This is a case where generality adds insight.

- Random proposer under both rules: Good KISS discipline. By fixing proposal rights to be symmetric, the paper isolates the voting-rule comparison. The paper explicitly discusses why monopoly agenda control is self-defeating (Section 8, Scope). This is a well-motivated simplification.

- Discount factor beta: Necessary for the two-round structure to have bite. In a one-round model, beta would be irrelevant.

**Assessment**: The model is enunciable in about 3 pages (Sections 3-3.2), passing the Board test. The main tension is the two-round bargaining structure: it is not the simplest model that generates the screening mechanism, but it is arguably the simplest model that generates the full set of results (including the alpha-independence of the cutoff and the richer non-convexity). The tradeoff is reasonable but not optimal. The paper would be slightly stronger if it either (a) derived the main results in a single-round model and presented the two-round version as a robustness extension, or (b) more explicitly justified why two rounds are needed for the main results (not just for analytical convenience).

### MD3. Isolamento do mecanismo [Excelente]

This is the paper's greatest strength. The mechanism is precisely isolated: unanimity makes H pivotal, which forces W to screen H's type, which creates a discrete jump in H's payoff at the screening cutoff, which creates a non-convexity that Bayesian persuasion exploits. The causal chain has four links, each cleanly identified:

1. Voting rule --> pivotal inclusion (unanimity) vs. exclusion (majority)
2. Pivotal inclusion + private information --> screening cutoff
3. Screening cutoff --> discrete payoff jump (non-convexity)
4. Non-convexity --> gains from Bayesian persuasion

The decomposition in Appendix B.5a (D = D_base + delta_R2 + delta_R1) is an excellent piece of mechanism isolation: it shows that the R1 and R2 corrections are independent and affect disjoint components of the payoff. This is exactly the kind of clean separation that Dixit emphasizes.

The institutional comparison is also cleanly isolated. Under majority, the hegemon's payoff is linear in beliefs---no screening, no jump, no non-convexity. Under unanimity, the payoff is piecewise linear with a discrete upward jump. The entire paper is about this structural difference.

The one area where isolation could be sharper is the entry channel. The paper argues that majority can dominate only through easier entry, never through higher conditional payoffs (when alpha < alpha*). This is clean. But the interaction between the entry channel and the screening channel under Bayesian persuasion is somewhat opaque: how exactly does concavification operate when E_U is disconnected? The paper acknowledges this possibility (footnote on disconnected E_U in A.7, Theorem 2 proof in B.8) but the interaction is technically handled rather than intuitively explained.

### MD4. Riqueza de insights [Rica]

The model generates several insights beyond the core institutional comparison:

1. **Alpha* is if and only if** (Lemma 1): The biconditional character---alpha < alpha* is both necessary and sufficient for conditional dominance---is a sharp result that maps directly to the empirical prediction about bilateral alternatives.

2. **Single-crossing** (Theorem 2): The institutional ranking never oscillates. This is a strong structural result that is not obvious ex ante---one might expect the comparison to oscillate as the screening and entry channels interact at different priors.

3. **The screening cutoff is independent of alpha** (when alpha < alpha_bar): This is a substantively important comparative static. The hegemon's bilateral alternative strength does not affect how aggressively weak states screen---only the uncertainty about the value of cooperation, the discount factor, and the number of players matter.

4. **Remark on mu_bar**: The belief threshold above which majority dominates (when alpha > alpha*) is remarkably stable across alpha. This robustness result extends the mechanism's relevance beyond the alpha < alpha* domain.

5. **PTA/Bhagwati prediction**: The proliferation of bilateral alternatives (increasing alpha) shifts the hegemon's preference away from consensus. This is a testable cross-time prediction.

6. **K > 2 types** (Appendix C): Unanimity generates K-1 screening boundaries while majority remains linear. The mechanism gets richer, not weaker, with more types.

7. **Entry set disconnectedness**: The possibility that E_U is disconnected is a non-trivial structural feature that emerges naturally from the model.

**Counter-intuitive results**: The core result is moderately counter-intuitive: a powerful state prefers the rule that constrains it most. The paper argues persuasively that this is counter-intuitive from the perspective of coalition-arithmetic models (Baron-Ferejohn), where veto power for all players is bad for the most powerful player. The paper could push this counter-intuition further by noting that even in the model's own terms, unanimity is strictly worse for H absent private information (at mu = 1, the conditional advantage is smallest). The mechanism only works because uncertainty is present.

**Transferability**: The mechanism is potentially transferable to other settings where a powerful actor has private information and faces a choice between inclusive and exclusive institutional rules: corporate governance (shareholder unanimity vs. majority), EU Council voting, security alliances. The paper mentions some of these in the conclusion and discussion but does not develop them extensively---this is appropriate for a focused paper.

### MD5. Tipo de contribuicao [New mechanism for an old puzzle --- strong]

This is primarily a "new model" contribution in Board & Meyer-ter-Vehn's taxonomy: a novel combination of known building blocks (Baron-Ferejohn, binary screening, Bayesian persuasion) that isolates a previously unidentified political force (informational power through pivotal inclusion). Secondarily, it generates new empirical predictions (cross-issue variation in the value of consensus, effect of bilateral alternatives on institutional preferences).

The contribution is well-positioned. It does not claim to explain all consensus institutions or to supersede existing accounts. It claims to identify a specific mechanism---informational power through screening---that is absent from prior formal models of IO design. This positioning is appropriate and defensible.

The paper does not make a significant technical contribution in the Bayesian persuasion literature; the concavification technique is standard. The contribution is entirely in the application and the institutional comparison, which is appropriate for a political science audience.

### MD6. Processo de construcao [Maduro]

The paper shows clear signs of iterative refinement:

1. **Example before generality**: The motivating example (Section 2) presents the full mechanism in a three-player, one-round setting before the general model. This follows Varian's "work an example" principle exactly. The example is effective: it builds intuition for screening, the jump, overpayment, and BP gains in a setting where all quantities are computed by hand.

2. **Baseline + extensions**: The paper builds systematically: majority first (linear, no screening), then unanimity (screening, jump), then entry and BP (non-convexity, concavification), then the institutional comparison. Each section adds one building block. This is excellent expository discipline.

3. **Special cases informing the general result**: The paper uses beta = 1 (cutoff simplifies to 1/(N-2)), the alpha < alpha_bar regime (alpha-independent cutoff), and the E_U = (0,1] case (global dominance corollary) as special cases that illuminate the general result.

4. **Numerical examples**: Example 1 (magnitudes), Example 2 (computing p*), and the parameter-region figures provide concrete quantitative grounding. The use of multiple parameter configurations in the figures (strong mechanism vs. weak mechanism) shows a model that has been explored computationally.

5. **Case selection handled explicitly**: The paper identifies the alpha_bar regime threshold and treats both cases (alpha < alpha_bar and alpha >= alpha_bar) in the proofs. This suggests the model has been pushed to its corners.

6. **Mature scope discussion**: The scope section addresses symmetric proposal rights, monopoly agenda control, commitment, and the alpha* boundary with specificity. The alternative-explanations paragraph is well-calibrated. These are signs of a model that has been scrutinized and defended.

One sign of maturity that is particularly notable: the paper explicitly identifies where the mechanism fails (alpha > alpha*, near mu = 1, continuous types) and characterizes these failure modes precisely. This is the hallmark of a well-understood model.

## Veredicto geral sobre design

This is a well-designed model that isolates a genuine and novel mechanism for an important puzzle in international political economy. The question is excellent (why would a hegemon choose consensus?), the mechanism is precisely identified (screening through pivotal inclusion creates non-convexity that Bayesian persuasion exploits), and the institutional comparison is sharp (single-crossing, biconditional threshold). The model passes the Schelling-Spence test on all essential components: removing any of the five key ingredients (binary types, unanimity-majority comparison, private information, voluntary entry, Bayesian persuasion) eliminates or qualitatively changes the result.

The main tension in the design is the two-round Baron-Ferejohn structure, which adds analytical richness at the cost of complexity. The core mechanism is already present in the one-round motivating example, and a referee might reasonably ask whether two rounds are necessary for the main theorems or merely convenient. The paper would benefit from a clearer statement of what the second round buys beyond the first.

The model generates a rich set of insights: the biconditional alpha* threshold, the single-crossing result, the alpha-independence of the screening cutoff, the robustness of mu_bar, the disconnected entry set, and testable predictions about bilateral alternatives and cross-issue variation. The mechanism is transferable to other institutional-choice settings. The paper is iteratively refined, with concrete examples preceding general results, explicit treatment of edge cases, and a mature scope discussion.

The score of 8 reflects a model that is strong on all dimensions except simplicity, where the two-round structure creates a non-trivial gap between the minimal model that generates the mechanism and the model actually presented. This gap is not fatal---the two-round model generates richer results---but it creates an expository burden that the paper does not fully justify.

## Sugestoes construtivas

1. **Justify the two-round structure explicitly.** The motivating example uses one round and generates the same qualitative mechanism. State clearly in Section 3 (or in a remark after Definition 1) what the second round adds: (a) alpha-independence of the screening cutoff when alpha < alpha_bar, (b) a richer non-convexity structure with two cutoffs, (c) the off-path continuation game that pins down beliefs after rejection. If the main theorems hold with one round (as I suspect they do), acknowledge this and position the two-round model as the richer version. If they do not hold with one round, explain why.

2. **Sharpen the novelty claim in the introduction.** The introduction could more clearly distinguish between the broad claim (consensus can benefit powerful states---not new) and the specific mechanism (screening through pivotal inclusion under uncertainty creates non-convexity that makes information strategically productive---new). A sentence such as "Prior work has argued that powerful states benefit from consensus through informal influence [Steinberg] or legitimacy [Ikenberry]. This paper identifies a distinct channel: consensus creates the strategic environment in which private information becomes a source of distributional advantage" would help.

3. **Clarify the entry-BP interaction intuitively.** The proof of Theorem 2 handles the disconnected entry set technically (B.8), but the paper would benefit from a short intuitive explanation of why the single-crossing result survives disconnectedness. The key insight---that the unanimity concave envelope starts from the origin and must eventually dominate the majority line because v(mu, U) > v(mu, M) at every entry point---could be stated in plain English before the theorem.

4. **Consider a one-round benchmark in an appendix.** Derive the screening jump, conditional dominance, and single-crossing result in a one-round model. This would (a) show that the mechanism is robust to the bargaining structure, (b) provide a simpler entry point for readers who find the two-round derivations heavy, and (c) clarify exactly what the second round adds.

5. **Push the counter-intuition harder.** The paper could note more forcefully that even within the model, unanimity is worst for H when there is no uncertainty (mu = 1): the screening rent is zero, and the cost of buying all votes is highest. The mechanism works precisely because uncertainty is present, and unanimity makes uncertainty valuable. This sharpens the insight: consensus is not generically good for powerful states; it is good precisely when information is asymmetric and the prospects of cooperation are uncertain.

6. **Consider discussing what "information" means in practice.** The model assumes H observes theta (the value of cooperation). In the WTO application, this corresponds to knowing the distributive consequences of proposed agreements. The paper could be more specific about what kind of information the hegemon has: is it about the aggregate gains from a tariff schedule, about the distribution of gains across members, or about the long-term implications of rule changes? Different interpretations have different empirical implications and different degrees of plausibility.

7. **Address the commitment assumption more directly.** The Bayesian persuasion results rest on the hegemon's ability to commit to an information structure before observing theta. The scope section discusses this (reputation, institutional transparency rules, upper-bound interpretation), but the discussion is somewhat defensive. A more direct approach: state that Theorems 1 and 2 are about the conditional comparison (which does not require BP commitment at all), and that BP amplifies the result by extending it below the entry threshold. The conditional dominance result (Lemma 1) is entirely commitment-free, and this should be emphasized as the paper's primary contribution, with BP as a natural extension.

---

## Parecer completo --- Apresentacao Tecnica

# Parecer de Apresentacao Tecnica (Thomson / Board)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: formal_model_v3.Rmd
**Data**: 2026-04-26
**Avaliador**: Senior theorist, Thomson (1999) / Board & Meyer-ter-Vehn (2018) framework
**Dimensoes**: D2--D9 (apresentacao tecnica de modelo formal)

---

## Score: 7.5 / 10

O manuscrito esta acima da media de submissoes a journals de CP/RI em termos de apresentacao tecnica, com uma estrutura clara de "body narra, appendix prova" que segue o estilo JoP. A notacao e parcimoniosa e quase sempre mnemoica. A principal fraqueza e uma carga de simbolos auxiliares no appendix que nao sao absorvidos intuitivamente, e um desbalanceio entre o corpo (muito limpo) e o appendix (denso, com ratio linguagem natural / matematica abaixo do recomendado por Thomson). Algumas definicoes formais e o inventario de resultados poderiam ser mais cuidadosos em formato.

---

## Estrutura do modelo

**Jogadores**: 1 hegemon H + N-1 weak states W_i, N >= 3. **Acoes**: H escolhe R in {M, U} e signal pi; W's decidem entry; bargaining (propose/accept/reject) em 2 rounds Baron-Ferejohn. **Informacao**: H observa theta in {0,1}, W's observam signal realization s (public). **Preferencias**: H recebe share do pie V(theta) in {1,r}; outside option alpha V(theta); W's have outside option 0, entry cost c. **Timing**: Stage 0 (institutional choice) -> Stage 1 (BP + entry) -> Stage 2 (bargaining, 2 rounds, random proposer, discount beta). **Equilibrio**: PBE com tie-breaking H aceita quando indiferente.

---

## Scorecard

| Dimensao | Veredicto | Comentario |
|----------|-----------|------------|
| D2. Apresentacao do modelo | Adequado | Ordem canonica respeitada; parsimonia boa; um modelo, nao dois; mas "Preview of main result" entre model e results cria secao hibrida |
| D3. Notacao (Thomson S.3) | Adequado | Mnemonicas boas (V, alpha, mu, R); mas phi, omega, lambda_M, kappa_M sao opacos; x = (N-1)alpha r definido mas pouco usado no corpo |
| D4. Definicoes (Thomson S.4) | Precisa melhorar | Definition 1 e bem feita mas e a unica definicao formal; "net gain" v(mu,R) e "screening cutoff" nao recebem destaque tipografico; faltam exemplos ilustrativos para definicoes |
| D5. Enunciados (Board) | Adequado | Sequencia contexto->enunciado->prova->intuicao e consistente; takeaway messages boas; mas Lemma 1 statement mistura condicao e resultado de forma densa |
| D6. Provas (Thomson S.5) | Precisa melhorar | No corpo: adequadas (1-frase proof sketches). No appendix: ratio linguagem natural baixo (~30-40% vs 52-63.5% recomendado); steps sao numerados mas faltam explicacoes informais antes de passos chave |
| D7. Figuras e diagramas | Excelente | Game trees TikZ, screening schematic TikZ, plots R com caption completo; labels completos; figuras pedagogicamente eficazes |
| D8. Assumptions e estrutura logica | Adequado | Assumptions embutidas na Definition 1 (alpha < 1/r, beta in (0,1)); plausibilidade discutida na Scope; mas alpha < alpha* aparece tarde e nao e formalmente uma Assumption |
| D9. Exemplos e aplicacoes | Adequado | Motivating example (Sec 2) e eficaz; Example 1 (magnitudes) bom; Example 2 (p*) bom; mas faltam naming memoravel dos agentes e exemplo geometrico para a concavificacao |

---

## Analise detalhada

### D4. Definicoes -- Precisa melhorar

**Diagnostico**: O manuscrito tem apenas uma definicao formal (Definition 1, o jogo). Conceitos centrais ao argumento -- "net gain function" v(mu,R), "screening cutoff" mu_s^{R1}, "entry threshold" tau(R), "conditional payoff dominance" -- sao introduzidos em prosa corrida sem destaque tipografico. Thomson (1999, Sec. 4) e enfatico: "Be unambiguous when you define a new term. Set the term you define in italics or boldface." Board & Meyer-ter-Vehn (2018) recomendam que definicoes centrais recebam tratamento formal (Definition environment) ou pelo menos italico + tipo do objeto.

**Impacto**: O leitor que busca a definicao precisa de v(mu,R) precisa encontrar a equacao no meio de um paragrafo na Secao 6 (l.416-418). A definicao de alpha* esta embutida no statement do Lemma 1, nao como definicao independente. Isso aumenta a carga cognitiva quando o leitor quer localizar definicoes.

**Sugestao concreta**:
1. Criar uma Definition 2 para v(mu,R) logo antes da Proposition 4, com tipo do objeto explicito ("the function v: (0,1] x {M,U} -> R defined by...").
2. Dar destaque tipografico (italico ou boldface) na primeira ocorrencia de "screening cutoff", "entry threshold", "net gain function".
3. Definir alpha* em definicao propria antes do Lemma 1, ou pelo menos como "Define alpha* = ..." em paragrafo separado antes do enunciado, seguindo a receita Board de "Define p. Define q. Theorem: every p is q."

**Referencia**: Thomson (1999), Sec. 4: "If you need a new term, introduce it formally. [...] The minimal requirement is that the term be set in italics the first time it appears, and that a formal definition be given."

### D6. Provas -- Precisa melhorar

**Diagnostico**: No corpo, a abordagem "See Appendix B.k" e correta para o estilo JoP light-math. O problema esta no appendix. A prova do Lemma 1 (B.5, ~50 linhas) e a derivacao B.5a (~80 linhas) sao densas em algebra com ratio de linguagem natural estimado em 30-40%. Thomson (1999, Sec. 5) documenta que provas de papers publicados em top journals tem 52-63.5% de linguagem natural. Especificamente:

- B.5a Steps 1-3 apresentam algebra sem explicar *antes* o que cada step faz. A frase de abertura de cada step e "Step k: [titulo]", mas falta uma explicacao informal do tipo "The idea is to show that switching from aggressive to conservative R1 changes only the W-proposes component, because..."
- B.5 Steps 2-3 fazem verificacao de endpoint sem antecipar por que endpoints sao suficientes (a afirmacao "affine, so it suffices to check endpoints" aparece, mas sem explicar *por que* D e affine em cada branch -- isso requer que o leitor ja tenha absorvido B.5a).
- A prova de B.8 (Theorem 2) e a mais bem escrita: Parts 1-2 tem boa proporcao de linguagem natural.

**Impacto**: Um referee que tenta verificar Lemma 1 no appendix pode perder o fio condutor. A densidade algebrica aumenta o risco de rejeicao por "hard to follow" mesmo quando a prova esta correta.

**Sugestao concreta**:
1. Antes de cada Step em B.5a, adicionar 1-2 frases informais que expliquem a estrategia ("We now compute the change in H's payoff when W switches from aggressive to conservative R1 offers. Because this switch affects only the W-proposes component, the correction is independent of the R2 regime.").
2. Em B.5 Step 2, antes de "At mu = 1:", adicionar: "Since D_base is affine in mu (it depends on mu only through V_e(mu) = 1 + mu(r-1)), it suffices to verify positivity at the two endpoints mu = 0 and mu = 1."
3. Marcar o QED mais visivelmente em B.5 (o square esta la mas e facil perder no meio do texto).

**Referencia**: Thomson (1999), Sec. 5: "Explain in words what you are doing, and why. A good ratio is 55-60% words, 40-45% math."

### D3. Notacao -- Comentarios adicionais

**Diagnostico parcial**: A notacao do corpo e boa. Os problemas estao nos simbolos auxiliares do appendix:

- phi (Prop 2, eq. 5): definido como [rN - beta(N-1+r)] / [beta(r-1)]. Este simbolo nao e mnemonico e nao carrega intuicao. Thomson: "the best notation is notation that can be guessed."
- omega(mu) (App A.3): definido como (N-2) beta V_W^{R2}(mu). Usado apenas no appendix, mas sem mnemonico. "omega" sugere frequencia ou probabilidade para a maioria dos leitores.
- lambda_M (App B.5/B.8): definido como [N(1+(N-1)alpha) - C_buy] / N^2. Central ao argumento mas opaco.
- kappa_M (App A.7): definido como (1-alpha)[N(N-1)+beta(q-1)] / (N^2(N-1)). Usado uma vez.
- x = (N-1)alpha r (Sec 4, l.102): definido no corpo mas raramente usado la; aparece mais no appendix.

**Impacto**: Moderado. O corpo esta limpo. Mas um referee que verifica provas pode tropecar em phi, omega, lambda_M sem saber a que se referem.

**Sugestao concreta**:
1. Na tabela de notacao (App A), incluir phi, omega, lambda_M, kappa_M com definicoes e locais de uso.
2. Alternativamente, eliminar omega substituindo diretamente (N-2) beta V_W^{R2}(mu) nas expressoes -- e usado poucas vezes.
3. Para phi, considerar renomear para algo mais descritivo ou simplesmente expandir inline, ja que aparece apenas na formula do cutoff.

**Referencia**: Thomson (1999), Sec. 3: "The best notation is notation that can be guessed."

### D8. Assumptions -- Comentario

**Diagnostico**: A condicao alpha < alpha*(N, beta) e central a Lemma 1, Theorem 1 e Theorem 2. No entanto, ela nao e apresentada como uma Assumption formal (environment). Aparece pela primeira vez *dentro* do enunciado do Lemma 1 (l.499-502). Em Board & Meyer-ter-Vehn (2018), condicoes parametricas que restringem o dominio dos resultados devem ser introduzidas como Assumptions nomeadas antes dos resultados que delas dependem, seguindo a regra de plausibilidade decrescente.

**Impacto**: Baixo-moderado. O leitor entende que alpha < alpha* e a condicao relevante. Mas formalmente, a hierarquia logica ficaria mais clara se alpha < alpha* fosse uma Assumption 1 (ou pelo menos um "Maintained condition") definido antes do Lemma.

**Sugestao**: Considerar inserir um "Maintained Condition" ou "Standing Assumption" para alpha < alpha* entre as Secoes 5 e 6, com a interpretacao de que "bilateral alternatives are moderate relative to multilateral cooperation."

---

## Inventario de notacao

| Simbolo | Significado | Introduzido em | Usado em | Problema? |
|---------|-------------|----------------|----------|-----------|
| N | Numero de jogadores | Def. 1 (l.91) | Todo o paper | Nao |
| H | Hegemon | Def. 1 (l.91) | Todo o paper | Nao |
| W, W_i | Weak state(s) | Def. 1 (l.91) | Todo o paper | Nao |
| theta | Estado do mundo {0,1} | Def. 1 (l.92) | Todo o paper | Nao |
| p | Prior Pr(theta=1) | Def. 1 (l.92) | Todo o paper | Nao |
| mu | Posterior Pr(theta=1 given s) | Sec. 3.2 (l.110) | Todo o paper | Nao |
| V(theta) | Valor da cooperacao | Def. 1 (l.93) | Todo o paper | Nao |
| r | V(1), high-type value | Def. 1 (l.93) | Todo o paper | Nao |
| alpha | Outside option share d_H = alpha V(theta) | Def. 1 (l.95) | Todo o paper | Nao |
| beta | Discount factor | Def. 1 (l.96) | Todo o paper | Nao |
| c | Entry cost | Def. 1 (l.97) | Secs 6-8, App | Nao |
| R | Voting rule {M, U} | Def. 1 (l.98) | Todo o paper | Nao |
| q | Majority quota floor(N/2)+1 | Def. 1 (l.98) | Secs 5-8, App | Nao |
| V_e(mu) | Expected coop value 1+mu(r-1) | Sec. 3.1 (l.102) | Todo o paper | Nao |
| x | Shorthand (N-1)alpha r | Sec. 3.1 (l.102) | App A.2-A.4 | Definido no corpo mas usado quase so no appendix |
| pi | Signal structure | Sec. 3.2 (l.110) | Secs 2, 6, Fig 1 | Nao |
| s | Signal realization | Sec. 3.2 (l.110) | Secs 3, 6 | Nao |
| y_H | H's share in offer | Sec. 2 (l.70) | Secs 2, 5 | Nao, informal |
| mu_s^{R1} | R1 screening cutoff | Prop. 2 (l.308) | Secs 5-8, App | Nao |
| mu_s^{R2} | R2 screening cutoff | App A.2 (l.867) | App A.2-B.5 | Nao |
| phi | Auxiliary for cutoff formula | Prop. 2 (l.310) | Prop. 2, App A.3 | Sim: opaco, nao mnemonico |
| alpha_bar | Regime threshold | Prop. 2 (l.313) | Secs 5, 8, App A.5 | Nao |
| alpha* | Iff threshold for Lemma 1 | Lemma 1 (l.501) | Secs 6-8, App | Parcial: definido dentro do enunciado, nao como definicao independente |
| v(mu, R) | Net gain function | Sec. 6 (l.416) | Secs 6-7, App B | Sim: nao recebe Definition environment |
| tau(R) | Entry threshold | Sec. 6 (l.412) | Secs 6-8, App A.7 | Parcial: nao formalmente definida |
| E_U | Entry set under unanimity | Sec. 7 (l.527) | Secs 7, App B | Nao |
| p* | Threshold prior | Thm 2 (l.554) | Secs 7-8 | Nao |
| D(mu) | Payoff difference V_H(U) - V_H(M) | App B.5 (l.1055) | App B.5-B.5a | Nao, appendix only |
| D_base | Baseline payoff diff | App B.5a (l.1030) | App B.5-B.5a | Nao, appendix only |
| delta_R1 | R1 correction | App B.5a (l.1006) | App B.5-B.5a | Nao, appendix only |
| delta_R2 | R2 correction | App B.5a (l.1014) | App B.5-B.5a | Nao, appendix only |
| omega(mu) | (N-2) beta V_W^{R2}(mu) | App A.3 (l.892) | App A.3-A.5 | Sim: opaco, nao mnemonico |
| C_buy | Vote-buying cost beta(q-1)(1-alpha) | App B.5 (l.844) | App B.5-B.8 | Nao, mnemonico |
| C_out | Outside option cost N(N-1)alpha | App B.5 (l.844) | App B.5-B.8 | Nao, mnemonico |
| lambda_M | Majority payoff coefficient | App B.5 (l.1046) | App B.5-B.8 | Parcial: nao na tabela de notacao |
| kappa_M | Majority weak-state coefficient | App A.7 (l.926) | App A.7 | Parcial: usado uma vez |
| S_U, S_M | Max slope of value function | Thm 2/App B.8 | App B.8, fig code | Nao |
| Gamma | Marginal value of uncertainty | Remark 1 (l.519) | Remark 1 | Nao |
| mu_bar | Belief threshold for Remark 1 | Remark 1 (l.520) | Remark 1, Sec 8 | Nao |
| F_1^{con}, F_1^{agg} | Proposer surpluses | App A.3 (l.889) | App A.3-A.5, B.7 | Nao, appendix only |
| Delta_1 | F_1^{agg} - F_1^{con} | App A.3 (l.894) | App A.3, B.2 | Nao, appendix only |
| Pi_H^{prop}, Pi_H^W | Payoff components | App B.5a (l.970, 980) | App B.5a | Nao, appendix only |
| E_bench | Benchmark payoff | App B.5a (l.996) | App B.5a | Nao, appendix only |
| V_W^{R1}, V_W^{R2} | Weak state continuation values | Various | Throughout | Nao |
| V_H^{R1}, V_H^{R2} | Hegemon continuation values | Various | Throughout | Nao |

**Contagem**: ~40 simbolos distintos. Para o corpo: ~22. Para o appendix: ~38 (adicionando auxiliares). Thomson recomenda parcimonia; o corpo esta dentro de limites razoaveis, mas o appendix esta no limite alto.

---

## Analise resultado-a-resultado

### Proposition 1 (Majority produces no screening)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | "Under majority rule..." paragrafo antes |
| Enunciado formal | Sim | Claro: V_H affine, no cutoff |
| Prova | Adequada | "See Appendix B.1" + 3 linhas no appendix |
| Intuicao apos | Sim | Paragrafo explicando exclusion mechanism |
| Implicacoes | Sim | "BP operates only through entry channel" |
| Formato paralelo | N/A | Resultado isolado |
| Takeaway | Claro | Exclusion kills screening |

**Takeaway message**: Majority transforms bargaining into coalition arithmetic where H's vote is irrelevant, so BP has no non-convexity to exploit.

### Proposition 2 (R1 screening cutoff)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Paragrafo sobre unanimity screening |
| Enunciado formal | Sim | Existencia, unicidade, closed form |
| Prova | Adequada | "See Appendix B.2" com derivacao completa |
| Intuicao apos | Sim | Paragrafo sobre independence from alpha |
| Implicacoes | Implicitas | Conectadas via Prop 3 |
| Formato paralelo | Parcial | Prop 2 define cutoff, Prop 3 define jump -- boa sequencia |
| Takeaway | Claro | Cutoff depends on r, beta, N but not alpha |

**Takeaway message**: The cutoff at which W switches behavior depends on the informativeness of theta, not on H's outside option strength.

**Nota**: O enunciado tem uma condicao (alpha < alpha_bar) e uma footnote longa sobre o caso alpha >= alpha_bar. Board recomendaria colocar a condicao no enunciado principal e o caso alternativo em remark separado, nao em footnote.

### Proposition 3 (Screening creates informational rent)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Implicito | Segue Prop 2 |
| Enunciado formal | Sim | Jump formula com closed form |
| Prova | Adequada | "See Appendix B.3" |
| Intuicao apos | Excelente | Paragrafo sobre r, beta, N interpretation |
| Implicacoes | Via Fig 3 | Screening schematic TikZ |
| Takeaway | Claro | Conservative offers overpay the low type |

**Takeaway message**: At the cutoff, W's switch to conservative behavior creates a discrete rent for H that grows with r, beta, and peaks at intermediate N.

### Example 1 (Magnitudes)

Bem escolhido. Parametros N=5, r=1.5, alpha=0.3, beta=0.9 sao intuitivos. Reporta magnitudes em percentuais (5.3%, 27%, 41%). Segue recomendacao de Board para "numbers that don't distract."

### Proposition 4 (Additional non-convexity)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Net gain function defined |
| Enunciado formal | Sim | Claro |
| Prova | Adequada | 4 linhas no appendix |
| Intuicao apos | Sim | Via BP discussion |
| Takeaway | Claro | Unanimity has extra non-convexity that majority lacks |

### Lemma 1 (Conditional payoff dominance)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | "conditional on institution forming" |
| Enunciado formal | Denso | alpha* definido inline no enunciado; "if and only if" mistura condicao e resultado |
| Prova | Longa | B.5 + B.5a = ~130 linhas. Correta mas densa |
| Intuicao apos | Sim | 2 paragrafos sobre endpoint argument |
| Implicacoes | Sim | Remark 1 (mu_bar), Corollary |
| Formato paralelo | Precisa melhorar | Definir alpha* antes, depois enunciar |
| Takeaway | Claro | When bilateral alternatives are moderate, unanimity gives H more at every belief |

**Takeaway message**: alpha < alpha* is necessary and sufficient for unanimity to give H a strictly higher payoff at every interior belief, conditional on entry.

**Sugestao Board**: Reescrever como:

> Define alpha*(N, beta) = [formula].
>
> Lemma 1. alpha < alpha*(N, beta) if and only if E[V_H(mu, U)] > E[V_H(mu, M)] for every mu in (0,1].

Isso separa definicao de resultado e segue o padrao "Define p. Define q. Theorem: Every p is q."

### Theorem 1 (Dominance of unanimity)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Secao 7.2 abre com contexto |
| Enunciado formal | Bom | Limpo: "For every p in E_U, Pi*(U,p) > Pi*(M,p)" |
| Prova | Adequada | B.6, ~25 linhas, boa proporcao NL/math |
| Intuicao apos | Sim | "regardless of connected/disconnected" |
| Implicacoes | Sim | Corollary (global dominance) |
| Takeaway | Excelente | "Whenever entry is feasible under unanimity, H strictly prefers it" |

### Corollary 1 (Global dominance)

Bem posicionado. Statement e claro. Segue naturalmente do Theorem 1.

### Theorem 2 (Single-crossing)

| Elemento Board | Status | Comentario |
|----------------|--------|------------|
| Contexto antes | Sim | Paragrafo sobre disconnected E_U |
| Enunciado formal | Bom | "upper interval", "p* such that..." |
| Prova | Boa | B.8, ~35 linhas, melhor proporcao NL/math do paper |
| Intuicao apos | Sim | "ranking never oscillates" |
| Implicacoes | Sim | Example 2 (p*) |
| Takeaway | Excelente | "Unanimity dominates above p*, majority below, transition at most once" |

### Example 2 (p*)

Eficaz. Computa p* = 0.24 com os mesmos parametros do Example 1, mostrando magnitudes (22%, 25%). Conecta com Theorem 2. Boa escolha de manter os mesmos parametros ao longo do paper (Board: "use a running example").

### Proposition 5 (K>2 types, App C)

Adequada como extensao. Provas curtas. A claim sobre K-1 screening boundaries e clara.

---

## Sugestoes construtivas (priorizadas por impacto)

### 1. Dar destaque formal a v(mu, R) e alpha*
**Impacto**: Alto. **Esforco**: Baixo.
Criar Definition 2 para v(mu, R) antes da Prop 4. Definir alpha* em paragrafo separado (ou mini-Definition) antes do Lemma 1. Seguir Board: "Define p. Define q. Theorem: Every p is q."
**Referencia**: Board & Meyer-ter-Vehn (2018), Sec. "Definitions and Conventions."

### 2. Aumentar ratio de linguagem natural nas provas do appendix (B.5, B.5a)
**Impacto**: Alto. **Esforco**: Medio.
Adicionar 1-2 frases informais antes de cada Step algebrico. Objetivo: passar de ~35% para ~55% de linguagem natural. Nao adicionar mais algebra -- adicionar mais *explicacao* da algebra existente.
**Referencia**: Thomson (1999), Sec. 5, Table 1 (52-63.5% NL in published proofs).

### 3. Completar a tabela de notacao no Appendix A
**Impacto**: Medio. **Esforco**: Baixo.
Adicionar phi, omega, lambda_M, kappa_M a tabela. Alternativamente, eliminar omega e kappa_M (usados poucas vezes) substituindo inline.
**Referencia**: Thomson (1999), Sec. 3: "Include a table of notation."

### 4. Mover a condicao sobre alpha < alpha_bar (footnote da Prop 2) para Remark
**Impacto**: Medio-baixo. **Esforco**: Baixo.
A footnote da Prop 2 (l.316) e longa e tecnica. Transformar em Remark separado ("When alpha >= alpha_bar, the R1 cutoff depends on alpha but the qualitative mechanism is unchanged").
**Referencia**: Board & Meyer-ter-Vehn (2018): "Don't bury important information in footnotes."

### 5. Considerar "Standing Assumption" para alpha < alpha*
**Impacto**: Medio-baixo. **Esforco**: Baixo.
Inserir entre Secoes 5 e 6: "Standing Assumption: alpha < alpha*(N, beta)." Isto clarifica que Lemma 1, Thm 1, Thm 2 operam sob a mesma condicao, e que a Scope (Sec 8) discute o que acontece fora dela.
**Referencia**: Board & Meyer-ter-Vehn (2018): "Assumptions should be introduced before the results that use them."

### 6. Adicionar um diagrama geometrico para a concavificacao
**Impacto**: Medio-baixo. **Esforco**: Medio.
O screening schematic TikZ (Fig. 3) ja mostra a concave envelope, mas um diagrama dedicado que compare v(mu, M) vs v(mu, U) com suas envelopes side by side -- como no Fig R (fig:bp-illustration) -- seria mais eficaz se fosse TikZ em vez de R plot, com labels mais legveis. O plot R atual e adequado mas as linhas sao finas em PDF.
**Referencia**: Thomson (1999), Sec. 6: "A good diagram replaces a paragraph of explanation."

### 7. Naming memoravel para os agentes no motivating example
**Impacto**: Baixo. **Esforco**: Baixo.
Em vez de "H" e "W_1, W_2", considerar nomes curtos no exemplo da Secao 2: "a hegemon (say, the US) and two smaller states" ou usar uma convencao como "Player H (hegemon) and players A, B (weak states)". Isto ajuda o leitor a lembrar quem e quem.
**Referencia**: Thomson (1999), Sec. 7: "Name your agents."

---

## Comentarios adicionais

### Pontos fortes

1. **Estrutura corpo/appendix**: A separacao e bem executada. O corpo conta a historia em prosa substantiva; as provas estao todas no appendix. Estilo consistente com JoP/AJPS.

2. **Figuras**: Os game trees TikZ (Figs 1-2) sao claros e informativos. O screening schematic (Fig 3) e pedagogicamente excelente -- mostra o jump, as branches, e a BP gain region. Os plots R (Figs 4-6) complementam bem.

3. **Running example**: Usar os mesmos parametros (N=5, r=1.5, alpha=0.3, beta=0.9) nos Examples 1 e 2 e uma boa pratica (Board: "use a running example").

4. **Sequencia de resultados**: A progressao Prop 1 (no screening under M) -> Prop 2 (cutoff under U) -> Prop 3 (jump) -> Prop 4 (non-convexity) -> Lemma 1 (conditional dominance) -> Thm 1 (dominance with BP) -> Thm 2 (single-crossing) e logicamente impecavel e segue a recomendacao Board de "build the results in order of increasing complexity."

5. **Motivating example**: Eficaz, com numeros simples (V(0)=1, V(1)=2, alpha=0.2, cutoff 1/9) que o leitor pode verificar mentalmente.

### Pontos de atencao menores

- L.102: V_e(mu) e x sao definidos na mesma linha, sem paragrafo separado. Considerar separar para facilitar localizacao.
- L.412: "tau(U) >= tau(M)" e afirmado antes de ser demonstrado (vem do Lemma 1 + budget identity). Marcar como "as established below" ou mover.
- App B.7 (Lemma VW_max): A prova e longa (~30 linhas) e verifica 4 candidates. Considerar se o caso "Aggressive R1, high R2" poderia ser abreviado com "by the same argument as the previous case."
- A notacao para tipos no R2 (theta=0, theta=1 com posterior mu'=1) pode confundir o leitor que confunde "posterior mu" com "posterior after rejection mu'". Considerar adicionar uma nota: "After rejection in R1, the posterior updates to mu'=1 (W learns theta=1 with certainty)."

---

*Parecer gerado em 2026-04-26. Framework: Thomson (1999) "The Young Person's Guide to Writing Economic Theory" + Board & Meyer-ter-Vehn (2018) "Writing Economic Theory Papers".*

---

## Parecer completo --- Exposicao

# Parecer de Exposicao do Modelo (Varian / Thomson / Board)

**Manuscript**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Author**: Manoel Galdino
**Version reviewed**: `formal_model_v3.Rmd`
**Reviewer**: Senior theorist, exposition audit per Varian (1997/2016), Thomson (1999), Board & Meyer-ter-Vehn (2018)
**Date**: 2026-04-26

---

## Score: 7.5 / 10

The paper is well above the threshold for a competent submission and demonstrates strong command of the "light math" style (proofs in appendix, body narrates the mechanism). The main result arrives at a reasonable point and the motivating example is effective. The score reflects genuine remaining issues: the introduction is too long and somewhat repetitive, the Discussion section mixes scope conditions with empirical illustrations in a way that dilutes both, and there are opportunities to tighten prose throughout. With targeted revisions, this is an 8.5--9.

---

## Avaliacao por dimensao

### ME1. Estrutura do paper [Adequada]

**Gancho na primeira pagina?** Yes. The opening paragraph poses a clear puzzle: why would a powerful state prefer consensus over majority rule? The first sentence ("Most international organizations operate by consensus, even when powerful states drive their creation") is direct and substantively grounded. This is a good hook.

**Get to the point?** Mostly. The motivating example (Section 2) arrives on p.3 of content, which is reasonable. The model definition (Section 3) follows immediately. However, the introduction itself is 2.5 pages, which is long for a theory paper. A significant portion (paragraphs 2--3) reviews existing answers at a level of detail that could be compressed. The reader does not need three distinct characterizations of the literature gap before seeing the mechanism.

**Resultado principal antes da p.15?** The main result (Theorem 1, "Dominance of unanimity") appears in Section 7 ("Institutional Choice"). In the compiled PDF, this is likely around p.13--15. The buildup is logically structured: majority (Section 4) --> unanimity/screening (Section 5) --> entry/BP (Section 6) --> comparison (Section 7). This is appropriate --- each building block is necessary for the next.

However, Section 3.2 ("Preview of the main result") does substantial work summarizing the result on p.6. This is a good practice (Board recommends previewing the result early), but the preview paragraph is dense and somewhat redundant with what the introduction already says. It reads more like a second introduction than a roadmap.

**Fluxo logico?** The flow is sound: Motivating Example --> Model --> Majority --> Unanimity --> Entry/BP --> Institutional Comparison --> Discussion --> Conclusion. Each section depends on the previous one. The one structural issue is that the Discussion (Section 8) combines GATT/WTO illustration, scope conditions, alternative explanations, and broader implications in a single section. These serve different purposes and would benefit from clearer separation or sequencing.

**Baseline resolvido antes de extensoes?** Yes. The majority baseline (Section 4) is fully resolved before unanimity screening is introduced. The extension to K>2 types is properly relegated to Appendix C. There are no premature extensions.

### ME2. Introducao [Precisa melhorar]

**Contribuicao clara nos primeiros paragrafos?** The contribution is stated in paragraph 4: "This paper theorizes when and why a hegemon may prefer unanimity to majority rule in international organizations. The central claim is that consensus is an institutional technology of power." This is clear and arrives in the right place. However, paragraphs 2--3 spend too long characterizing the literature gap with overlapping formulations. For instance:

- Paragraph 2: "Consensus does the opposite. By giving every participant a veto, it forces powerful states to surrender the very tools they might value most."
- Paragraph 3: "Neither explains when and why a hegemon would prefer unanimity to a rule that allows exclusion."

These two observations are essentially the same point made twice. The literature review in the introduction could be compressed from two paragraphs to one.

**Sem laundry lists de implicacoes?** The introduction does not have a laundry list, which is good. The substantive implication paragraph (paragraph 6) is focused on the single main result.

**Conteudo essencial: agentes, acoes, informacao, intuicoes?** Paragraph 5 provides a good model summary: "a hegemon chooses between majority and unanimity. Proposal rights are symmetric under both rules... Before weaker states decide whether to enter, the hegemon privately observes the value of cooperation and can shape their beliefs about it." The key agents (hegemon, weak states), actions (voting rule choice, entry, bargaining), information structure (private observation of theta), and intuition (screening under unanimity, no screening under majority) are all present. This paragraph is the best part of the introduction.

**Sem contexto excessivo motivando importancia do tema?** The first paragraph is borderline. "The international arena is where material asymmetries should matter most relative to domestic politics" is a defensible claim but somewhat grandiose. The sentence "If institutional rules reflect power, powerful states might be expected to favor arrangements that let them turn that power into a distributive advantage, meaning an ability to secure a greater share of benefits" is over-explained --- the parenthetical gloss on "distributive advantage" is unnecessary for a JoP audience. The opening could be tightened by cutting 2--3 sentences.

**Estrutura: puzzle --> modelo e intuicao --> literatura?** The structure is puzzle (para 1) --> literature gap (paras 2--3) --> contribution (para 4) --> model and intuition (para 5) --> substantive implication (para 6) --> roadmap (para 7). This mostly follows the recommended pattern. The literature gap section is too prominent relative to the model intuition, however. Board recommends that the introduction should make the reader want to see the model, not want to read the literature. Moving some of the literature discussion to a later section or footnotes would help.

**Roadmap paragraph:** The final paragraph is a standard section-by-section roadmap. This is fine but uninspired. The best theory papers use the roadmap to convey the logical arc, not just list sections. Compare: "Section 2 presents a motivating example" vs. "Section 2 previews the mechanism through a three-player example in which the screening cutoff and the jump can be computed in closed form." The latter tells the reader what they will learn, not just where to find it.

### ME3. Escrita e estilo [Adequado]

**Frases curtas?** Mixed. The prose is generally clear, but some sentences are overloaded. Examples:

- (Section 5, after Prop 2): "The independence of the screening cutoff from the hegemon's outside option strength---which holds when alpha < alpha_bar---is substantively important." This is fine, but the next sentence is 45 words with a triple qualification ("not how valuable bilateral alternatives are, but how consequential the hegemon's private information is for the value of cooperation, how patient the bargainers are, and how many states must agree"). Breaking this into two sentences would improve readability.

- (Section 7, Lemma 1 discussion): "The intuition has two parts. When the hegemon proposes, unanimity depresses weak states' continuation values (because rejection leads to a game where the hegemon is pivotal), allowing the hegemon to buy agreement more cheaply. When a weak state proposes, unanimity forces the proposer to secure the hegemon's vote, generating the screening rent identified in Proposition 3." This is well-structured --- the "two parts" framing with parallel construction is effective.

**Sem frase comecando com simbolo?** I did not detect any sentence beginning with a mathematical symbol. This convention has been correctly followed.

**Consistencia de voz e tempo?** The paper consistently uses first person singular ("I develop," "I show") and present tense for results. This is consistent and appropriate.

**Sucinto?** The body text achieves the "light math" goal: proofs are in the appendix, and the body focuses on statements and interpretation. However, certain interpretive passages are repetitive. For example, the explanation of why majority produces no screening appears in: (1) the motivating example, (2) Section 4 (Proposition 1 + paragraph), (3) Section 6 (entry/BP), and (4) Section 7 (Theorem 1 discussion). Each repetition adds marginally, but the cumulative effect is that the reader hears the same point four times. A single, definitive statement in Section 4 with forward references would suffice.

**Termos tecnicos corretos?** Yes. "Screening cutoff," "Bayesian persuasion," "concavification," "Baron-Ferejohn," "Perfect Bayesian Equilibrium" are all used correctly. The paper correctly distinguishes between "screening" (the weak state's problem of choosing offer type) and "signaling" (which is not the mechanism here). The term "informational rent" (Proposition 3) is appropriate.

**Footnotes usados com parcimonia?** There are several footnotes in the model definition (Definition 1) that are substantive: the d_W normalization footnote, the alpha V(theta) proportionality footnote, and the consensus/unanimity equivalence footnote. These are appropriate for a JoP audience and help keep the definition clean. The entry cost footnote in Section 6 is long (6 lines) and includes the N-scaling discussion; this could be shortened or moved to the Scope section. Total footnote count appears moderate (around 6--8), which is fine.

**Apendice narrativo?** The appendix is well-organized: Appendix A contains bargaining derivations with clear subsections (A.1--A.7), and Appendix B contains proofs (B.1--B.8). The derivations in B.5a ("Derivation of the payoff decomposition") are particularly well-written, with a step-by-step structure that a reader can follow. The proofs are self-contained with cross-references to the relevant appendix derivations.

One issue: the notation table (Appendix A, beginning) is a good idea but could be placed earlier --- perhaps as a reference table in the model section or as a sidebar. Readers who need notation help during the body will not think to look in the appendix.

### ME4. Extensao e quando parar [Adequado]

**"Once you've made your point, stop"?** The paper mostly follows this principle. The main results (Theorems 1--2) are stated and interpreted, and the paper does not add unnecessary extensions in the body. The K>2 extension is properly in Appendix C.

However, the Discussion section (Section 8) is too long and tries to do too many things. It contains:
1. GATT/WTO illustration (3 paragraphs)
2. Observable implications (1 paragraph)
3. PTAs/outside option prediction (1 paragraph)
4. Scope conditions: symmetric proposals, no agenda control, when consensus works, commitment (4 sub-items)
5. When majority dominates (2 paragraphs)
6. alpha* and N discussion with heatmap figure (2 paragraphs + figure)
7. Alternative explanations (1 paragraph)
8. Broader implications (1 paragraph)

This is at least 12 paragraphs plus a figure. By Varian's standard, "people only remember about 10 pages," and the Discussion adds 3--4 pages after the main result has been established. The GATT/WTO illustration is the most important part and deserves prominence; the scope conditions could be shorter; the "broader implications" paragraph at the end is speculative and could be cut.

**Resultado principal antes da p.15?** Likely yes, depending on compilation. The body text through Theorem 1 is approximately 12--14 pages, which meets the Board threshold.

**Extensoes justificadas?** The K>2 extension in Appendix C is well-justified: it shows the mechanism generalizes and that the binary model is the minimal case. The worked examples (Examples 1--2) add concrete magnitudes and illustrate the full institutional comparison, which is valuable. The alpha* heatmap figure (Figure 4) is informative but might be better in the appendix or scope section rather than in the middle of the Discussion, where it interrupts the GATT/WTO narrative.

**Provas mecanicas no apendice?** All proofs are in the appendix. The body contains only proof references ("See Appendix B.X"). This is exactly what Board and Varian recommend.

### ME5. Uso de exemplos e intuicao [Excelente]

**Exemplos concretos?** The paper excels here. The motivating example (Section 2) with N=3, V(0)=1, V(1)=2, alpha=0.2 is simple enough to compute by hand yet rich enough to illustrate the full mechanism: majority exclusion, unanimity screening, the jump, and Bayesian persuasion. This is exactly what Dixit and Varian recommend.

Example 1 (Section 5) provides concrete magnitudes for the screening jump (5.3% of surplus, 27% more than majority on aggressive, 41% more on conservative). These numbers give the reader a sense of economic significance, which abstract formulas do not.

Example 2 (Section 7) computes p* = 0.24 and shows the full institutional comparison with percentages (22% advantage at p=0.30, 25% at p=0.50). This makes Theorem 2 concrete.

**"Every result should be explained in simple English"?** Each proposition and theorem is followed by an interpretive paragraph in plain language. For instance, after Proposition 3 (Jump): "At the screening cutoff, weak proposers switch from treating the hegemon as the low type to hedging against the possibility of the high type." This is clear and avoids jargon.

**Exemplos geometricos > numericos?** The paper has both. The TikZ schematic of the screening jump (Figure 3) is a geometric illustration showing the piecewise payoff function, the jump, and the concavification region. This is more informative than a table of numbers. The R-generated Figure 4 (net-gain functions with concavifications) provides a complementary computational view. The heatmap (Figure 5) is purely numerical/computational but serves a different purpose (parameter space exploration).

**Exemplo motivador no inicio?** Yes, Section 2 before the formal model is exactly where it should be. The example previews all key mechanisms and creates concrete expectations that the general model then formalizes.

**Casos especiais como exemplos?** The motivating example (N=3, one round, no entry cost) is a simplification of the general model (N players, two rounds, entry cost). The paper explicitly states what the general model adds: "The general model enriches this logic with N players, random proposer, two-round Baron-Ferejohn bargaining with discounting, and an explicit entry stage with cost c." This is good practice.

---

## Veredicto geral sobre exposicao

The paper achieves a strong implementation of the "light math for JoP" style. The body narrates the mechanism in substantive language, all proofs are in the appendix, and worked examples with concrete magnitudes appear at key junctures. The motivating example is the paper's exposition highlight: it previews every mechanism simply and effectively. The main weaknesses are: (i) an introduction that is 30--40% too long, with redundant characterizations of the literature gap; (ii) a Discussion section that tries to accomplish too many goals simultaneously and would benefit from compression and reorganization; and (iii) a pattern of restating the majority-has-no-screening point more times than necessary. None of these are fatal, but they dilute the paper's considerable strengths. The appendix is well-organized and narratively structured, which is important for a paper where the proofs carry significant analytical weight. With targeted trimming of the introduction and Discussion, this manuscript would meet the exposition standard of a top political science journal.

---

## Top 5 sugestoes de melhoria

1. **Compress the introduction from ~2.5 pages to ~1.5 pages.** The literature gap is stated in both paragraph 2 and paragraph 3 with overlapping content. Merge them into a single paragraph. Cut the parenthetical definition of "distributive advantage" in paragraph 1 (the JoP audience knows what this means). Cut or shorten the sentence about "informal agenda power" in paragraph 3 --- this point is better developed in the Discussion/Scope section. Specifically, the passage beginning "A common response claims that powerful states still influence outcomes..." through "...masks asymmetric influence" (about 5 lines) can be reduced to a single sentence: "Existing accounts either treat consensus as constraining hegemonic discretion or as a mask for conventional power, but neither explains when a hegemon would actively prefer unanimity to exclusion."

2. **Reorganize Section 8 (Discussion) into clearly demarcated subsections and cut ~30%.** Currently the section mixes empirical illustration (GATT/WTO), scope conditions, comparative statics, parameter exploration, alternative explanations, and speculation about dynamics. Suggested structure: (a) GATT/WTO illustration (keep, but cut the second paragraph about Green Room process --- it weakens the argument by conceding too much to the agenda-control view); (b) Observable implications (keep, this is strong); (c) Scope and limitations (merge the four scope sub-items into a tighter treatment); (d) drop or drastically shorten "Broader implications" (the erosion-of-power speculation belongs in the conclusion or a footnote, not a full paragraph). Move the heatmap figure to Scope or the appendix.

3. **Eliminate redundant restatements of the majority-is-linear point.** The fact that majority produces no screening is stated in: the motivating example (p.3), Section 4 (Proposition 1 + paragraph), Section 6 (middle of the entry/BP discussion), and Section 7 (Theorem 1 discussion). After the definitive statement in Section 4, subsequent sections should reference it rather than re-explain it. For instance, in Section 6, replace "Under majority, concavification operates only through the entry threshold: the hegemon can induce participation but cannot extract screening rents, because the conditional payoff is already linear" with a forward reference: "Under majority, the conditional payoff is linear (Proposition 1), so concavification operates only through the entry threshold."

4. **Make the roadmap paragraph in the introduction work harder.** Replace the mechanical section listing ("Section 2 presents..., Section 3 presents..., Section 4 derives...") with a paragraph that conveys the logical arc of the argument. For example: "A three-player example (Section 2) previews the full mechanism in closed form. The general model (Section 3) introduces N-player bargaining with entry costs. The first analytical result is that majority rule produces no screening (Section 4), establishing the baseline against which unanimity's screening advantage (Section 5) and its interaction with Bayesian persuasion (Section 6) are measured. The main result (Section 7) shows that the comparison reduces to a single threshold." This tells the reader what each section accomplishes, not just what it contains.

5. **Move the notation table from the appendix to the model section.** The notation summary (currently Appendix A, first page) is useful but buried. Readers who encounter unfamiliar symbols while reading the body (especially lambda_M, C_buy, C_out in Remark 1 and Lemma 1 discussion) will not know to look in the appendix. Consider placing a compact version after Definition 1 or at the end of Section 3. The appendix version can remain as a complete reference, but having key symbols visible in the body reduces cognitive load. At minimum, define C_buy and C_out in the body text of Remark 1 where they first appear (they are currently defined only in the proof context of Appendix B.5).

---

## Additional observations (not in top 5 but worth noting)

- **Abstract**: The abstract is well-written and self-contained. At 172 words, it is within typical JoP bounds. The final sentence ("offering a distributive explanation for consensus rules in organizations such as the WTO") is a strong close.

- **Game tree figures**: Figures 1--2 (TikZ game trees) are clear and well-labeled. The landscape orientation is appropriate given the tree width. The captions are detailed and informative --- perhaps slightly too detailed for figures that are meant to be read alongside the text. Consider shortening the Figure 2 caption by removing the R2 payoff derivation details ("exact R1 offer levels are beta V_H^R2(...)"), which belong in the appendix.

- **Typo/grammar check**: "The international arena is where material asymmetries should matter most relative do domestic politics" --- "do" should be "to" (paragraph 1 of the introduction). This is a minor typo but appears in the most prominent position of the paper.

- **Section 3.2 "Preview of the main result"**: This subsection is structurally unusual. It appears inside the Model section but is really a summary of Sections 4--7. Consider either (a) making it the last paragraph of the introduction (where previews conventionally live) or (b) renaming it "Roadmap" and placing it between the model and the analysis sections. Its current location --- after the game tree figures but before the majority section --- creates a brief pause in forward momentum.

- **Conclusion**: At 3 paragraphs, the conclusion is appropriately brief. The mention of continuous types as a limitation is honest and well-calibrated. The three future extensions are stated without over-selling.
