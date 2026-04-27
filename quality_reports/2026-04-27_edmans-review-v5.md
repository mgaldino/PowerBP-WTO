# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

**Data**: 2026-04-27
**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)

---

## Decisao: Reject-and-Resubmit

## Scores consolidados
| Dimensao     | Score | Rating              |
|-------------|-------|---------------------|
| Contribution | 6.5/10  | Adequada / Fraca |
| Execution    | 7.5/10  | Solida            |
| Exposition   | 7.5/10  | Boa               |
| **Global**   | **7.0/10** | **Reject-and-Resubmit** |

## Sintese editorial

O manuscrito apresenta um mecanismo genuinamente novo — screening sob unanimidade gera rent informacional que maioria elimina — formalizado com rigor técnico admirável. A decomposição aditiva (B.5a), a bicondicionalidade de α*, e a redução da comparação institucional a {F_U, F_M \ F_U, complemento} são contribuições técnicas reais. A prosa é limpa, os exemplos numéricos são memoráveis, e o modelo é parcimonioso.

O bottleneck é a contribuição. O mecanismo é original, mas sua relevância empírica é restrita por condições paramétricas exigentes: α* ≈ 0.03 para N = 164 (WTO), tipos binários reconhecidamente o "caso mais favorável", e implicações observáveis que não discriminam agudamente contra explicações alternativas. A execução é sólida dentro das premissas escolhidas, mas o caminho causal para aplicações reais (endogeneidade da informação de W, de c, de α, de N) recebe tratamento insuficiente. A exposição é quase pronta para submissão — abstract sem números, "informational power" nunca definido formalmente, e repetição pós-Proposition 1 são os pontos mais salientes.

## Hierarquia Edmans aplicada

A hierarquia contribution > execution > exposition opera com clareza neste manuscrito. A execução é o ponto forte (mecanismo limpo, formas fechadas, bicondicionalidade), e a exposição é competente. Mas a contribuição é o gargalo: um mecanismo cuja relevância empírica depende de α estar abaixo de um threshold que é minúsculo para organizações grandes, e que opera no caso K=2 reconhecidamente mais favorável, não atinge o patamar de "avanço substancial do conhecimento" exigido por top journals generalistas. A execução perfeita não salva uma contribuição que o leitor recebe com "interessante mas quão relevante?".

A boa notícia é que o gargalo não é fatal. Se o autor puder: (a) demonstrar computacionalmente que α*_K permanece não-trivial para K=3,4,5; ou (b) calibrar α para hegêmonas reais e mostrar que cai no domínio do mecanismo; ou (c) derivar uma predição empírica que discrimine unicamente esta teoria — qualquer uma dessas intervenções elevaria a contribuição a um nível publicável.

## Prioridades para revisao

1. **Demonstrar relevância empírica de α < α* para organizações reais.** Calibrar α para EUA no GATT/WTO (ou UE em outras OIs). Sem isso, o mecanismo é um curiosum teórico para N grande.

2. **Endereçar o caso K > 2 computacionalmente.** Calcular α*_K para K = 3, 4, 5 com parâmetros realistas. Se α*_K → 0, reconhecer abertamente e reposicionar o paper; se não, esse é o argumento mais forte para publicação.

3. **Tratar endogeneidades no caminho causal.** Discutir qualitativamente (3-5 ¶ na Discussion): (i) W pode investir em informação sob unanimidade; (ii) c pode diferir entre regras; (iii) α é endógeno (PTAs); (iv) H poderia escolher N. Não precisa formalizar, mas sinalizar consciência e direção do efeito.

4. **Diferenciar de Bardhi-Guo (2018) e Kim-Kim-Van Weelden (2025).** 2-3 ¶ explicando por que os resultados deste paper não podem ser derivados daqueles frameworks.

5. **Polimentos de exposição.** (a) Número concreto no abstract; (b) definir "informational power" em 1 frase na intro; (c) eliminar repetição pós-Proposition 1; (d) mover Remark 2 para Discussion; (e) limpar .bib (orphans).

## Recomendacao estrategica ao autor

O paper tem um mecanismo genuinamente interessante e uma execução técnica que o posiciona bem. Porém, para o JoP — que valoriza papers formais com "bite" substantivo — a distância entre o mecanismo e a relevância empírica é o principal obstáculo. As prioridades 1-2 (calibração de α e K>2 computacional) são as mais impactantes: se α plausível para os EUA cai abaixo de α* mesmo em N moderado, e se K=3,4 não destroem o resultado, o paper se torna muito mais publicável.

Se essas extensões revelarem que o mecanismo é frágil (α*_K → 0 rápido, ou α empírico > α* para organizações relevantes), o autor deveria considerar reposicionar: (a) target journal mais especializado (JTP, Journal of Economic Theory, Games and Economic Behavior) onde a contribuição técnica é avaliada em seus próprios termos; ou (b) reframing como "o caso K=2 identifica um novo canal; extensões são paper futuro", o que é honesto mas menos ambicioso.

A exposição está quase pronta para submissão e requer apenas ajustes pontuais (priority 5). Não gaste tempo excessivo aqui antes de resolver a questão de contribuição.

---

---

## Parecer completo — Contribution

# Parecer de Contribution (Framework Edmans)

## Score: 6.5/10

## Resumo da contribuicao alegada

The paper claims that a hegemon may rationally prefer consensus (unanimity) over majority rule in international organizations because unanimity creates a screening problem that amplifies the hegemon's informational advantage. The central mechanism is that unanimity forces weak states to include the hegemon in every proposal without knowing its type, generating overpayment (a "screening rent") that makes the hegemon strictly better off than under majority, conditional on institutional entry. The paper presents this as a distributive-informational explanation for consensus rules in organizations such as the WTO.

## Avaliacao por dimensao

### Novidade [Adequada]

The paper offers a genuinely novel mechanism linking voting rules to information exploitation. The insight that unanimity creates a screening problem while majority eliminates it---because weak states can bypass the hegemon under majority---is original and non-obvious. This is not a convex combination of existing results: Baron-Ferejohn bargaining has been extensively studied, and Bayesian persuasion has been applied to voting, but the specific connection between unanimity as an institution that activates screening rents from private information is new.

However, several factors temper the novelty assessment. First, the idea that unanimity gives veto players leverage is well-established in the institutional design literature (Tsebelis 2002 on veto players, Maggi and Morelli 2006 on self-enforcing voting). The paper's contribution is to formalize a specific *informational* channel through which this leverage operates, which is more incremental than paradigm-shifting. Second, the screening mechanism itself---that an uninformed party offering to an informed party faces a lemons-like problem---is a textbook adverse selection result (Rothschild-Stiglitz 1976, in insurance; analogous structures appear throughout mechanism design). The contribution is in embedding this in an institutional-choice context, not in the screening logic per se. Third, the paper originally had Bayesian persuasion as a co-protagonist (earlier versions) and has now demoted it to a remark (Remark 4), which narrows the novelty footprint. The remaining result---screening under unanimity generates higher payoffs for H---is clean but narrower than the original dual-channel contribution.

A reader already familiar with legislative bargaining under incomplete information would update beliefs moderately upon reading this paper. The Bayesian update is real but bounded: the *direction* of the result (unanimity can benefit the informed party) is intuitive once stated, even if the precise conditions and the cleanness of the comparison are not.

### Importancia [Adequada / Fraca]

The paper addresses a genuine puzzle: why powerful states accept consensus. This is a question of first-order importance in the study of international institutions. However, several aspects limit the importance of the contribution as delivered.

First, the practical relevance is uncertain. The model shows that H *may* prefer unanimity under specific parametric conditions (α < α*), and the paper acknowledges that α* becomes very small for large organizations (α* ≈ 0.03 for N = 164). For a WTO-sized institution, the condition requires that bilateral alternatives capture only a tiny fraction of multilateral surplus. This is a strong requirement, and the paper does not establish empirically that it holds. A policymaker reading this paper would learn that there *exists* a theoretical channel through which consensus benefits a hegemon, but the conditions under which it operates at scale are demanding and unverified.

Second, the result is conditional on a specific modeling architecture: two types, two rounds of Baron-Ferejohn bargaining, all-or-nothing entry, and symmetric proposal rights. The paper is transparent about these choices, but the robustness to relaxing them is largely unaddressed. The K > 2 extension (Appendix C) honestly acknowledges that the parametric region may shrink---potentially to zero---as K increases. This is a significant qualification for a paper whose substantive claim involves real-world institutions where uncertainty is high-dimensional.

Third, would a survey paper on institutional design in international organizations cite this result? Likely yes, as one mechanism among several, but it would not be the centerpiece. The paper does not overturn existing explanations (self-binding, legitimacy, informal power); it adds one more channel. The Discussion section (Section 8) explicitly positions the mechanism as complementary to existing accounts, which is intellectually honest but diminishes the perceived importance.

Fourth, the mechanism has limited *actionable* implications. A legislator or trade negotiator would not change behavior based on this result, because the model's conditions are hard to verify in practice and the mechanism operates through equilibrium forces that actors cannot easily manipulate. The observable implications (Section 8.1) are suggestive but not sharp enough to discriminate empirically against alternatives.

### Adequacao ao escopo [Adequada]

The bibliography is appropriate for a political science audience: Baron-Ferejohn, Kalandrakis, Eraslan-Evdokimov (legislative bargaining), Koremenos-Lipson-Snidal, Steinberg, Stone (international institutions), Fearon (rationalist explanations), Maggi-Morelli (self-enforcing voting), Kamenica-Gentzkow (Bayesian persuasion). The paper sits at the intersection of formal political theory and international political economy, which is a natural fit for JoP or AJPS.

The paper is of interest to the formal theory community and the IO/IPE community, though perhaps not to the broader political science audience. A comparativist or Americanist would find limited direct applicability. The paper reads as a theory paper in the tradition of Hirsch (2023, JoP) or Schnakenberg (2017)---technically sophisticated, substantively motivated, but narrowly targeted.

### Generalizabilidade [Limitada]

The model is built around a specific institutional context (international organizations with a hegemon) and specific structural features (binary types, Baron-Ferejohn bargaining, all-or-nothing entry). Several of these choices limit generalizability:

1. **Binary types.** The paper's results are sharpest for K = 2 and may not extend to richer type spaces. The paper is honest about this (Appendix C, Conclusion), but it means the mechanism is demonstrated in the case most favorable to it.

2. **Two rounds of bargaining.** The paper argues this is sufficient for robustness beyond the one-shot case, but the relationship between the number of rounds and the screening advantage is not characterized. With T rounds, the strategic dynamics become more complex, and it is unclear whether the screening advantage grows, shrinks, or is non-monotone in T.

3. **All-or-nothing entry.** The assumption that all N-1 weak states must enter simultaneously is strong. In practice, coalition formation at the entry stage is itself strategic. The paper justifies this as appropriate for broad-membership institutions, but it precludes analysis of partial entry, which is relevant for understanding actual institution formation.

4. **Symmetric weak states.** All weak states are identical. Heterogeneity in outside options or information would substantially enrich (and potentially undermine) the results. The paper mentions this as a future extension.

5. **Application specificity.** The GATT/WTO application is suggestive but illustrative. The mechanism could in principle apply to any setting with a veto player who has private information, but the paper does not develop applications beyond international trade.

### Trade-offs [Parcial]

The paper recognizes the key trade-off: unanimity gives H a higher conditional payoff but makes entry harder for weak states. This is clearly articulated in the formation-set analysis (Section 7.2) and the institutional classification (Proposition 4). The paper also notes that weak states always prefer majority (Corollary discussion), which is an important cost of unanimity from the perspective of institutional welfare.

However, several trade-offs are underexplored:

1. **Efficiency.** The paper notes that unanimity destroys surplus through discounting on the aggressive branch (Appendix A.6), but does not systematically compare total welfare across rules. Is unanimity Pareto-dominated? When? The paper's focus on H's payoff leaves the welfare comparison incomplete.

2. **Dynamic costs.** The Conclusion mentions endogenous erosion of informational power and learning, but these are deferred to future work. If the screening advantage erodes over time, the long-run case for unanimity weakens, potentially reversing the short-run advantage. This is noted but not analyzed.

3. **Costs of the modeling choices themselves.** The all-or-nothing entry, symmetric weak states, and binary types all simplify in ways that may favor the mechanism. The paper does not discuss what would happen if these assumptions were relaxed in ways that work against the result.

### Hipoteses [Claras e direcionais]

The paper has a clear theoretical mechanism: unanimity makes H pivotal, creating a screening problem that generates rents for H. The hypothesis is directional: H prefers unanimity when α < α* and entry is feasible. The model generates precise comparative statics: the screening advantage increases with r and β, decreases with N and α, and the entry advantage of majority increases with c.

The theoretical mechanism is grounded in well-understood economics (adverse selection under incomplete information) applied to a well-specified institutional choice. This is a strength. The hypotheses are not vague or kitchen-sink; they derive from a single mechanism with clear predictions.

The one qualification is that the observable implications (Section 8.1) are somewhat generic. The prediction that the mechanism matters more in complex negotiations and less in transparent ones is consistent with many information-based theories and does not uniquely identify this particular mechanism.

## Veredicto geral sobre contribution

The paper presents a technically competent model that identifies a novel mechanism linking voting rules to informational advantage in international organizations. The core insight---that unanimity creates screening rents while majority eliminates them---is clean, well-formalized, and substantively interesting. The paper is honest about its limitations, particularly the sensitivity to binary types and the demanding parametric conditions for large organizations.

As a contribution to the field, the paper falls in the "adequate but not compelling" range for a top-5 political science journal. The mechanism is original and the formalization is rigorous, but the result adds one more channel to an already crowded literature on institutional design without overturning existing explanations. The practical relevance is limited by demanding parametric conditions (α* small for large N), the restriction to binary types, and the lack of empirical discrimination against alternatives. The paper would be a solid contribution to a specialized formal theory journal or a field journal in international political economy, but for JoP or AJPS, the contribution needs to be more clearly differentiated from the existing literature and the mechanism's relevance needs to be established more convincingly for realistic institutional environments.

The score of 6.5 reflects a paper with genuine novelty and technical quality that nonetheless falls short of the contribution threshold for a top general-interest political science journal. The mechanism is interesting but narrow; the conditions for it to operate at scale are restrictive; and the observable implications, while suggestive, do not clearly separate this explanation from alternatives. A stronger empirical or computational exercise demonstrating the mechanism's relevance under realistic parameterizations---or a sharper theoretical result that does not depend on binary types---would substantially strengthen the case.

## Sugestoes construtivas

1. **Establish empirical plausibility of the parametric conditions.** The most damaging weakness is that α* becomes very small for large N. The paper should provide evidence (or at least a calibration exercise) showing that plausible values of α for real-world hegemons fall within the mechanism's domain. What is α for the US in the WTO? For the EU in other institutions? Without this, the mechanism risks being a theoretical curiosum.

2. **Sharpen the empirical predictions.** The observable implications (Section 8.1) are suggestive but not unique to this theory. Identify at least one prediction that distinguishes the informational-screening mechanism from (a) legitimacy accounts, (b) self-enforcing accounts, and (c) informal-power accounts. Ideally, point to a case or dataset where this prediction could be tested.

3. **Address the K > 2 limitation more aggressively.** The honest acknowledgment that the binary model is "the most favorable case" is commendable, but it raises the question of whether the mechanism survives in realistic settings. A computational exercise showing that α*_K remains non-trivial for K = 3, 4, 5 would be highly valuable. If α*_K → 0 rapidly, the paper should address this directly rather than leaving it as an "open question."

4. **Develop the welfare comparison.** The paper focuses on H's payoff but the institutional design question involves all players. Under what conditions is unanimity Pareto-dominated? When H chooses unanimity, how much total surplus is destroyed? This would add depth to the normative implications and connect to the institutional design literature (Koremenos et al. 2001) more substantively.

5. **Consider relaxing symmetric proposal rights.** The assumption of equal recognition probabilities is clean but unrealistic. If the hegemon has even moderate agenda-setting advantage under both rules, does the mechanism survive? A brief analysis (even as an appendix) showing robustness to asymmetric recognition would significantly strengthen the result.

6. **Differentiate more sharply from Bardhi-Guo (2018) and Kim-Kim-Van Weelden (2025).** These papers study persuasion in voting and veto bargaining settings. The current paper cites them but does not clearly articulate what is different about the institutional-choice question versus the information-design question. Two to three paragraphs explaining why this paper's results cannot be derived from or subsumed by these existing frameworks would strengthen the contribution claim.

7. **Reconsider the target journal.** The paper's strengths---technical rigor, clean formalization, tight results---are well-suited to formal theory venues. JoP accepts formal theory but favors papers with broader substantive engagement. AJPS values methodological innovation with empirical bite. The paper might receive a more sympathetic reception at a journal like *Games and Economic Behavior*, *Journal of Theoretical Politics*, or *Journal of Economic Theory*, where the technical contribution would be evaluated on its own terms.

---

## Parecer completo — Execution

# Parecer de Execution (Framework Edmans) -- formal_model_v5.Rmd

**Data**: 2026-04-27
**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Avaliador**: Edmans Execution Framework, adaptado para CP

---

## Score: 7.5 / 10
## Tipo de paper: Teorico

---

## Resumo da estrategia

O paper desenvolve um modelo formal de escolha institucional em que um hegemon com informacao privada sobre o valor da cooperacao multilateral escolhe entre unanimidade e maioria como regra de votacao. A estrategia de execucao e puramente dedutiva: premissas sobre a estrutura de barganha (Baron-Ferejohn, 2 rounds, proposta aleatoria, tipo binario) levam, por backward induction, a resultados sobre screening sob unanimidade, linearidade sob maioria, e um teorema de dominancia condicional. A comparacao institucional e reduzida a duas forcas: vantagem de screening (favorece unanimidade) versus viabilidade de entrada (favorece maioria).

---

## Principio "Dados vs. Evidencia"

Em papers teoricos, o analogo do principio "dados nao sao evidencia" e: **premissas nao sao resultados**. Premissas que garantem o resultado por construcao nao constituem demonstracao de um mecanismo -- elas apenas o descrevem. A questao central e se as conclusoes do modelo sao logicamente distantes das premissas, ou se as premissas ja carregam o resultado.

No presente caso, o paper produz resultados nao-triviais a partir das premissas. O screening cutoff, sua independencia de alpha (quando alpha < alpha_bar), a forma fechada do jump, a decomposicao aditiva D_base + delta_R1 + delta_R2, e a bicondicionalidade de alpha* sao derivacoes genuinas que nao sao obvias a partir da especificacao do modelo. A passagem premissas-conclusoes e substantiva.

Entretanto, ha um aspecto em que as premissas fazem trabalho pesado: a escolha de tipos binarios (K=2) e central para que o screening gere um unico cutoff limpo e que a dominancia condicional seja global. O proprio paper reconhece isso (Appendix C, Conclusion), mas a tensao merece destaque: o resultado principal (Theorem 1) e um resultado do caso K=2, e o paper nao pode afirmar que o mecanismo escala para ambientes mais ricos sem qualificacao substantiva. Esse reconhecimento honesto e um ponto a favor da execucao.

---

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes (nao esta assumindo o resultado?)

**Rating: 7.5/10**

A questao critica e: as premissas do modelo ja determinam que unanimidade domina, ou o resultado emerge de interacoes nao-obvias?

**Pontos fortes:**
- A premissa central -- tipo binario + unanimidade torna H pivotal -- nao implica automaticamente que unanimidade domina. Sob unanimidade, H tambem paga mais para comprar votos (N-1 vs q-1). A dominancia condicional depende de que o screening rent supere esse custo adicional, e o threshold alpha* que separa os dois regimes e derivado, nao assumido.
- A decomposicao aditiva (B.5a) e um resultado tecnico genuino: a independencia entre as correcoes R1 e R2 nao e obvia a priori e depende de propriedades estruturais do Baron-Ferejohn (identidade do proposer separa os canais).
- A bicondicionalidade de alpha* (Step 4 da prova do Theorem 1) mostra que o resultado e afiado: a condicao e necessaria E suficiente, nao apenas suficiente.

**Preocupacoes:**
- A assimetria informacional e perfeitamente unilateral: H sabe theta com certeza, W nao sabe nada. Em equacoes, isso e `H observa theta; W hold prior p`. Isso maximiza o screening rent por construcao. Nao ha nenhum grau de informacao parcial de W. A questao e: o que acontece se W tem um sinal ruidoso sobre theta? O paper nao aborda sinais intermediarios.
- A opcao exterior do hegemon e d_H = alpha * V(theta), proporcional ao valor da cooperacao. Isso e funcional para o modelo, mas tambem garante que a opcao exterior seja mais valiosa quando theta=1, maximizando a tensao no screening problem. Se d_H fosse constante (d_H = d), o screening desapareceria? Provavelmente nao inteiramente, mas a magnitude seria diferente. O paper nao discute a sensibilidade a essa forma funcional.
- A entrada e all-or-nothing e simultanea. Isso elimina hold-out e renegociacao, simplificando enormemente a analise. A footnote reconhece, mas nao aborda o que aconteceria com entrada sequencial ou parcial.

**Veredicto T.1**: O resultado nao e trivialmente embutido nas premissas. A distancia e real, especialmente na decomposicao e na bicondicionalidade. Mas a arquitetura do modelo (K=2, informacao perfeitamente unilateral, entrada all-or-nothing) e talhada para maximizar a nitidez do resultado. Dentro dessas premissas, a execucao e limpa.

---

### T.2 Parcimonia (mecanismos claros?)

**Rating: 8.5/10**

**Pontos fortes:**
- O mecanismo central e extraordinariamente limpo: unanimidade forca screening porque H e pivotal; maioria elimina screening porque H nao e pivotal. Essa assimetria e capturada em uma unica variavel: se H e necessario para a coalizao ou nao.
- O modelo isola o efeito da regra de votacao mantendo tudo mais constante (proposta aleatoria, mesmos payoffs, mesmo discount factor). A comparacao e justa.
- O paper define cuidadosamente o que o modelo NAO faz: nao modela agenda informal, nao modela repeticao, nao modela T>2 rounds. A parcimonia e consciente.
- A reducao da comparacao institucional a {F_U, F_M \ F_U, complemento de F_M} e elegante e transparente.

**Preocupacao menor:**
- A restricao alpha < 1/r e necessaria para garantir que d_H < V(theta) para todo theta, mas na pratica essa restricao e muito frouxa (para r=1.5, alpha < 0.67). A restricao que realmente morde e alpha < alpha*, que para N grande fica muito apertada. Isso levanta a questao de se o modelo e parcimonioso o suficiente para gerar previsoes empiricas com bite em organizacoes grandes. O paper aborda isso honestamente (Scope section), o que e bom.

**Veredicto T.2**: Mecanismo limpo, isolamento adequado, premissas justificadas. A parcimonia e um dos pontos fortes do paper.

---

### T.3 Caminho causal (variaveis endogenas no path estao livres?)

**Rating: 6.5/10**

Este e o ponto mais vulneravel da execucao.

**Preocupacoes substanciais:**

1. **Endogeneidade da regra de votacao ao nivel de informacao assimetrica.** O modelo trata a informacao privada de H como exogena e a regra de votacao como escolha otima dado esse ambiente informacional. Mas em equilibrio, a regra de votacao pode afetar os incentivos de W para adquirir informacao. Se W sabe que unanimidade sera escolhida, W tem incentivos para investir em inteligencia sobre theta -- precisamente porque o screening e custoso. O paper menciona isso como "paper futuro" (erosao endogena), mas nao aborda como esse canal retroativo afeta a validade do resultado presente. A questao nao e apenas "o que acontece no longo prazo", mas "o equilíbrio do modelo de um jogo e consistente com a premissa de que W nao sabe nada sobre theta?"

2. **Endogeneidade da entrada ao mecanismo.** O modelo assume que W entra se V_W >= c, onde c e exogeno. Mas o custo de entrada pode depender da regra de votacao (lobbying, preparacao de delegacoes sob unanimidade vs maioria pode ter custos diferentes). Se c_U > c_M, a vantagem de maioria no canal de entrada se amplifica. O paper trata c como uniforme entre regras.

3. **Alpha como exogeno.** A forca da opcao exterior bilateral (alpha) e tratada como parametro exogeno. Mas alpha e plausivelmente endogeno a acao de H: H pode investir em alternativas bilaterais (PTAs, por exemplo) para fortalecer sua posicao. Se H escolhe alpha antes de escolher R, o jogo muda substancialmente. O Scope menciona PTAs (Bhagwati), mas nao modela essa endogeneidade.

4. **N como exogeno.** O numero de membros e parametro do modelo. Mas H escolhe a regra de votacao -- por que nao escolhe tambem N? Se H pode escolher N (quantos estados convidar), o problema se torna bidimensional (N, R), e o tradeoff pode mudar. O paper menciona "N is the size of the institution the hegemon proposes to create" mas nao modela essa escolha.

**Pontos atenuantes:**
- Nenhuma dessas endogeneidades invalida o mecanismo dentro do modelo. A questao e de escopo, nao de erro logico.
- O paper e honesto sobre limitacoes (Scope, Conclusion, footnotes).
- Para um paper de teoria pura no JoP, tratar essas variaveis como exogenas e aceitavel se o autor sinaliza consciencia -- o que este paper faz.

**Veredicto T.3**: O caminho causal interno ao modelo e limpo (backward induction, sem circularidade). Mas variaveis tratadas como exogenas (informacao de W, custo de entrada, alpha, N) sao plausivelmente endogenas ao mecanismo, e a discussao dessas endogeneidades e superficial. Isso nao e um erro formal, mas limita a forca do argumento como teoria institucional.

---

## Veredicto geral sobre execution

A execucao tecnica do paper e solida. O mecanismo central -- screening sob unanimidade, ausencia de screening sob maioria -- e derivado rigorosamente a partir de premissas explicitas, com resultados de forma fechada, uma bicondicionalidade que afia o resultado principal, e uma decomposicao algébrica que isola os canais de forma transparente. O modelo e parcimonioso: mantem constante tudo exceto a regra de votacao e deixa o screening emergir da interacao entre assimetria informacional e pivotalidade. A distancia entre premissas e conclusoes e real, nao trivial.

As fragilidades concentram-se em duas areas. Primeiro, a arquitetura do modelo (tipos binarios, informacao perfeitamente unilateral, entrada all-or-nothing) e otimizada para produzir resultados limpos, e a generalizacao a ambientes mais ricos (K>2, sinais parciais, entrada parcial) e reconhecida mas nao resolvida. Segundo, e mais importante para a avaliacao de execution, varias variaveis no caminho causal (nivel de assimetria informacional, custo de entrada, forca da opcao exterior, tamanho da organizacao) sao plausivelmente endogenas ao mecanismo, e a discussao dessas retroalimentacoes e insuficiente para um paper que aspira a fazer afirmacoes sobre design institucional no mundo real. O mecanismo funciona perfeitamente dentro do modelo, mas a ponte entre o modelo e a aplicacao empirica (GATT/WTO) requer mais cuidado com a endogeneidade dos parametros tratados como exogenos.

O score de 7.5 reflete uma execucao tecnica forte (facilmente 8-8.5 no eixo puramente formal) penalizada por um caminho causal que, ao ser aplicado a fenomenos reais, deixa endogeneidades substantivas sem tratamento adequado.

---

## Sugestoes construtivas

1. **Sinal ruidoso de W sobre theta.** Adicionar um paragrafo na Discussion ou Scope sobre o que acontece se W recebe um sinal parcial sobre theta antes da entrada. Se W observa um sinal s com precisao q in (0.5, 1), o screening problem sobrevive mas o rent diminui. Discutir qualitativamente se o mecanismo e monotono na assimetria informacional ou se ha nao-monotonicidade. Isso nao requer formalizacao, mas a ausencia de qualquer discussao e uma lacuna.

2. **Endogeneidade da informacao.** Na Discussion, adicionar 2-3 frases reconhecendo que a escolha de unanimidade pode afetar os incentivos de W para adquirir informacao sobre theta, e que isso cria um jogo de dois estagios (escolha de regra -> investimento em informacao -> barganha) cujo equilibrio pode diferir do modelo presente. Mesmo sem resolver, sinalizar consciencia desta retroalimentacao fortaleceria a credibilidade.

3. **Heterogeneidade em c.** Se c_U != c_M (unanimidade e mais custosa em termos de preparacao), a fronteira F_U encolhe mais rapido. Uma nota de robustez qualitativa sobre essa possibilidade fortaleceria T.3.

4. **Alpha endogeno como extensao.** Ja mencionado na Discussion via PTAs, mas merece uma frase explicita: "If the hegemon can invest in strengthening its bilateral alternatives before choosing the voting rule, the interaction between alpha and R becomes a two-dimensional design problem that may alter the tradeoff identified here."

5. **Fortalecer o argumento K>2.** O Appendix C e honesto sobre limitacoes, mas a Conclusion poderia ser mais incisiva: distinguir claramente entre (a) o que esta provado (K=2), (b) o que generaliza sem qualificacao (maioria e linear para todo K), e (c) o que e conjectura (unanimidade domina para K>2 com parametros empiricos). Atualmente, a distincao existe mas poderia ser mais afiada.

6. **Robustez a T>2 rounds.** O paper argumenta que 2 rounds e suficiente e robusto, mas nao aborda o limite T -> infinito (Baron-Ferejohn padrao). Uma nota indicando se o screening cutoff converge ou diverge com T seria informativa, mesmo se informal.

---

## Parecer completo — Exposition

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
- **Alpha-star examples (line 426):** "α* ≈ 0.47 when N = 5 but falls to ≈ 0.03 when N = 164" — excellent. This immediately tells the reader the scope condition in substantive terms.
- **Example 2 (line 477-480):** "at p = 0.50, the hegemon's payoff under unanimity exceeds majority by 25%" — again, concrete and memorable.
- **Remark 1 (line 433):** "increasing α from 0.05 to 0.49 (an 18-fold increase beyond α*) only lowers μ̄ from 0.87 to 0.71" — this is a strong way to communicate robustness.

The abstract, however, is weaker on this front. It contains no numbers at all. The main result is stated as "weaker states pay more than necessary to secure agreement" — how much more? Even one illustrative number (e.g., "up to 41% more than under majority rule in calibrated examples") would make the abstract substantially more memorable.

#### Precisao da linguagem

Generally precise. The paper defines its terms carefully and uses them consistently. A few areas of concern:

1. **"Informational power" is never formally defined.** The title uses it, the abstract uses it, the introduction uses it repeatedly, but there is no Definition or even a clear one-sentence statement of what "informational power" means in this model. The reader must infer it means "the payoff advantage arising from the screening problem created by private information under unanimity." A one-sentence definition early in the introduction would sharpen the contribution claim.

2. **"Institutional technology of power" (line 55).** This is a striking phrase but somewhat vague. Technology in what sense? The paper means that unanimity is an institutional arrangement that converts informational asymmetry into bargaining advantage, but "technology of power" could mean many things. The phrase works as a hook but should be followed immediately by a precise restatement, which it roughly is in the next sentence — but the connection could be tighter.

3. **"Promising enough" (line 59, abstract line 36).** The abstract says "once cooperation is promising enough for weaker states to participate under unanimity." This is imprecise — promising in what sense? The paper means "when the prior belief that θ=1 exceeds the entry threshold τ(U)." A more precise phrasing: "once the expected value of cooperation exceeds the threshold for participation under unanimity."

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
- The intro does not mention the parametric scope condition α < α* or give the reader any sense of when the result fails. The strongest version of the intro would include: "The result holds when the hegemon's bilateral alternatives are moderate relative to multilateral cooperation (α < α*, a condition easily satisfied in small organizations but demanding in large ones)."

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

3. **One minor issue — plain-text citation.** Remark 2 (line 473) references "Kamenica and Gentzkow 2011" in running text without using the @kamenica2011bayesian citation key. This will produce a plain-text mention rather than a hyperlinked, formatted citation. While the .bib file contains the entry, this is a formatting error.

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
