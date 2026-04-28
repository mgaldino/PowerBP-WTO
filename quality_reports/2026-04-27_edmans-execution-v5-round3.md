# Parecer de Execution (Framework Edmans 2025) -- v5 Round 3

**Manuscrito**: "Informational Power Through Pivotality: When a Hegemon May Choose Consensus"  
**Arquivo**: `formal_model_v5.Rmd`  
**Data**: 2026-04-27  
**Avaliador**: Simulacao de editor de top journal de CP (APSR/AJPS/JOP/IO/BJPS)

---

## Score: 8.0 / 10
## Tipo de paper: Teorico

---

## Resumo da estrategia

O paper desenvolve um modelo formal de barganha legislativa (Baron-Ferejohn, 2 rounds) com assimetria informacional para comparar unanimidade versus maioria como regra de votacao. A estrategia de execucao e puramente dedutiva: definir primitivos do jogo, derivar equilibrios por inducao retroativa sob cada regra, e comparar payoffs do hegemon via decomposicao aditiva do diferencial D(mu). A ilustracao empirica (OPEC) e usada como motivacao e calibracao, nao como teste.

---

## Principio "Dados vs. Evidencia" (adaptado para papers teoricos)

Em papers teoricos, o analogo do principio "dados vs. evidencia" de Edmans e: *premissas nao sao conclusoes*. Dados (premissas) podem ter multiplas implicacoes; evidencia (resultados) requer que as conclusoes nao estejam embutidas nas hipoteses.

Neste paper, a pergunta e: o resultado de que unanimidade domina maioria esta *deduzido* das premissas ou *assumido* por elas? Avaliacao por dimensao abaixo.

---

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes: 7.5/10

**Pergunta central**: O resultado esta assumido pelas premissas, ou emerge como consequencia nao-trivial?

**Pontos fortes:**

1. *O resultado nao e trivial*. A premissa central -- assimetria informacional sob um pie binario -- nao implica automaticamente que unanimidade domine maioria. A maioria tambem poderia, em principio, gerar screening se a estrutura de coalizoes fosse diferente. O resultado emerge da interacao entre (a) a possibilidade de exclusao do hegemon sob maioria e (b) a pivotalidade necessaria sob unanimidade. A cadeia logica tem multiplos elos: exclusao -> nenhum screening -> payoff linear vs. inclusao -> screening -> jump -> payoff superior.

2. *O Theorem 1 e bicondicional*. A condicao alpha < alpha*(N, beta) e necessaria E suficiente para dominancia condicional. Isso e mais do que "existe parametros onde unanimidade domina" -- e uma caracterizacao completa do esapco parametrico. A necessidade (Step 4 do proof) mostra que em mu = 1 a dominancia falha se alpha >= alpha*, o que significa que o resultado tem limites internos claros.

3. *A decomposicao aditiva e informativa*. A separacao de D(mu) em D_base + delta_R1 + delta_R2 nao e cosmetica: cada componente captura um mecanismo distinto (custo de votos, screening R1, screening R2), e a independencia entre componentes e demonstrada pela estrutura do jogo (R1 offers dependem de mu'=1, nao de V_W^R2(mu)).

**Preocupacoes:**

1. *A exclusao sob maioria e mecanica, nao estrategica*. A premissa crucial e que, sob maioria, weak states SEMPRE excluem o hegemon. Isso decorre de d_W = 0 (outside option dos fracos e zero), que garante que comprar um fraco e sempre mais barato que comprar H. Se d_W > 0 (heterogeneo), a exclusao nao seria automatica -- o proposer W compararia o custo de incluir H vs. comprar outro W. O paper reconhece isso no Remark 5 (weighted voting), mas nao explora formalmente. A normalizacao d_W = 0 e WLOG apenas se as outside options dos fracos forem simetricas E menores que as de H -- condicao razoavel mas nao trivial. A nota de rodape na Definicao 1 reconhece isso.

2. *O modelo binario e conservador por construcao*. O Appendix C mostra que alpha*_cont >= alpha* para distribuicao uniforme, e que o resultado de screening rent > 0 e distribution-free. Porem, a dominancia global (para todo mu) so e demonstrada para o caso binario e verificada numericamente para o uniforme. Para distribuicoes arbitrarias, alpha*_cont nao esta caracterizado. Isso nao invalida o resultado, mas limita o alcance da bicondicional.

3. *A estrutura de 2 rounds e ad hoc?* O paper justifica bem por que 1 round seria insuficiente (ultimato trivial) e argumenta que 2 rounds confirmam que o mecanismo sobrevive no ambiente Baron-Ferejohn. Mas nao fica claro se o resultado se mantem com T rounds arbitrario. A independencia do cutoff R1 de alpha (quando alpha < alpha_bar) depende da estrutura especifica de 2 rounds. Com T > 2 rounds, a cascata de cutoffs e continuacoes poderia alterar a dominancia. O paper seria mais forte com uma discussao explicita de por que 2 rounds e suficiente para o argumento, ou com um resultado de robustez para T generico.

**Rating: 7.5/10** -- A distancia e substancial e a cadeia dedutiva e genuinamente nao-trivial, mas a dependencia critica da exclusao mecanica sob maioria (via d_W = 0) e uma premissa que faz parte do trabalho pesado.

---

### T.2 Parcimonia: 9.0/10

**Pergunta central**: O modelo isola mecanismos claros sem maquinaria excessiva?

**Pontos fortes:**

1. *Minimal moving parts*. O modelo tem exatamente os ingredientes necessarios: N jogadores (1 hegemon + N-1 fracos), pie binario, assimetria informacional, regra de votacao. Nao ha mecanismos concorrentes (reputacao, aprendizado, cheap talk) misturados.

2. *A comparacao institucional e limpa*. Proposal rights simetricas sob ambas as regras isolam o efeito da voting rule. A Secao Scope explica por que symmetric proposals sao necessarias (agenda control monopolista mata entry).

3. *Um unico parametro governa*. O threshold alpha* resume a comparacao condicional em um unico numero que depende de (N, beta). Proposition 4 classifica o espaco de priors em tres regioes exaustivas.

4. *A ilustracao OPEC nao sobrecarrega o modelo*. O paper usa OPEC para calibrar parametros e mostrar que o mecanismo e empiricamente plausivel, sem tentar testar o modelo. As limitacoes sao reconhecidas explicitamente (repeated game, heterogeneidade, founding moment).

**Preocupacoes menores:**

1. O entry cost c, embora necessario para a comparacao institucional completa (Proposition 4), adiciona um grau de liberdade que nao e disciplinado empiricamente. A nota sobre c = c_tilde/N e pertinente mas nao resolve a questao de como calibrar c.

2. O Remark sobre Bayesian Persuasion (Remark 6) e o Remark sobre weighted voting (Remark 5) sao informativos mas nao estritamente necessarios para o argumento principal. O paper os mantem como remarks, o que e apropriado.

**Rating: 9.0/10** -- Modelo exemplarmente parcimonioso. Cada ingrediente carrega peso.

---

### T.3 Caminho causal: 8.0/10

**Pergunta central**: As variaveis endogenas no caminho logico estao livres de contaminacao?

Em um paper teorico, o "caminho causal" e a cadeia dedutiva: premissas -> resultados intermediarios -> resultado principal. A pergunta e se ha circularidades, variaveis endogenas nao controladas, ou passos logicos que dependem de restricoes nao declaradas.

**Pontos fortes:**

1. *A cadeia e linear e bem ordenada*. A logica vai de: (a) R2 equilibrium -> (b) R1 equilibrium por backward induction -> (c) comparacao condicional (Thm 1) -> (d) entry comparison (Corollary) -> (e) classificacao (Prop 4). Cada passo depende apenas dos anteriores.

2. *O proof roadmap e transparente*. A explicacao pos-Theorem 1 de como a prova funciona (decomposicao aditiva, checagem de endpoints, necessidade via mu=1) e um modelo de exposicao.

3. *Budget balance como disciplina*. O paper usa budget balance (E[V_H] + (N-1)V_W = V_e(mu) ou <=) como check interno, nao como premissa. Isso disciplina a derivacao.

4. *A necessidade do bicondicional previne over-claiming*. O paper nao diz "unanimidade sempre domina"; diz "unanimidade domina condicional em entry sse alpha < alpha*". A condicao e sharp.

**Preocupacoes:**

1. *Commitment problem na escolha institucional*. No Stage 0, H escolhe R. No Stage 1, W's entram. No Stage 2, bargaining. Mas o modelo assume que H se compromete com R antes de observar theta. Se H observa theta primeiro e depois escolhe R, o resultado pode mudar: H poderia usar a escolha de R como sinal de theta. O timing {choose R} -> {Nature draws theta} -> {H observes theta} -> {W's enter} e crucial. O paper especifica isso corretamente (Stage 0 antes de Stage 1), mas a justificativa substantiva (institutional choice happens at founding moments, before specific cooperation opportunities arise) merece mais enfase. A Secao Scope toca nisso ao mencionar "founding moments", mas a questao de commitment sobre a regra e logicamente anterior a tudo mais.

2. *Equilibrium selection*. O paper foca em symmetric entry equilibrium (todos entram ou ninguem entra). Com N-1 fracos decidindo simultaneamente, ha tambem equilibrios assimetricos (alguns entram, outros nao) e possivelmente equilibrios mistos. O paper justifica a restricao a equilibrios simetricos (weak states sao ex ante identicos), mas nao discute se equilibrios assimetricos existem e, se existem, se a comparacao institucional se mantem. Se existem equilibrios assimetricos onde entry e parcial, a all-or-nothing entry assumption faz mais trabalho do que parece.

3. *Off-path beliefs*. O paper especifica que beliefs sao atualizadas por Bayes on-path e "off-path beliefs satisfy sequential rationality". Mas em jogos de screening com 2 rounds, a especificacao dos off-path beliefs pode importar. Quando theta=1 rejeita o aggressive offer em R1, W's atualizam para mu'=1 -- isso e on-path. Mas o que acontece se H aceita um offer que no equilibrio apenas theta=0 aceitaria? O paper nao explicita beliefs off-path nesses casos. Para um jogo com payoff-relevant types e PBE, a convencao tie-breaking (H aceita quando indiferente) resolve o caso borderline, mas beliefs apos desvios nao sao formalmente especificados.

**Rating: 8.0/10** -- A cadeia dedutiva e solida e bem construida. As preocupacoes sobre commitment timing e off-path beliefs sao reais mas nao fatais -- sao standard issues em modelos de institutional choice e screening que, se abordados, fortaleceriam o paper mas cuja ausencia nao invalida os resultados.

---

## Veredicto geral sobre execution

O paper apresenta uma execucao rigorosa de um modelo teorico com resultado nao-trivial. A cadeia dedutiva e limpa: premissas -> equilibrio por backward induction -> comparacao via decomposicao aditiva -> classificacao exaustiva. O modelo e parcimonioso (cada ingrediente carrega peso) e o resultado principal (bicondicional de Theorem 1) e sharp. A principal forca da execucao e que o resultado nao esta assumido pelas premissas: a dominancia de unanimidade emerge da interacao entre exclusao sob maioria (que elimina screening) e pivotalidade sob unanimidade (que gera screening), nao de uma premissa direta sobre qual regra e melhor. A principal limitacao e que a exclusao automatica do hegemon sob maioria depende da normalizacao d_W = 0, que e WLOG apenas sob simetria dos fracos -- uma condicao razoavel mas substantiva. A estrutura de 2 rounds e justificada mas nao generalizada para T rounds. O commitment sobre a regra institucional (H escolhe R antes de observar theta) e crucial e merece mais destaque. A extensao para tipos continuos (Appendix C) e valiosa e demonstra que o resultado binario e conservador, embora a bicondicional completa nao esteja disponivel para distribuicoes gerais. No conjunto, a execucao esta no nivel de um R&R forte em top journal de CP -- solida mas com espaco para fortalecimento em pontos especificos.

---

## Sugestoes construtivas

1. **Explicitar o commitment timing e sua justificativa**. Adicionar uma frase na Secao Scope ou na definicao do jogo que diga: "The hegemon commits to the voting rule before observing theta. This timing reflects founding moments in which institutional rules are set before specific cooperation opportunities arise. If the hegemon could choose the rule after observing theta, the rule choice would be informative, and the analysis would require a signaling model---a distinct question." Isso previne a objecao de que a escolha institucional e endogena ao tipo.

2. **Discutir robustez a T > 2 rounds**. Mesmo sem um resultado formal, uma discussao de por que o mecanismo de screening sobrevive com mais rounds (a logica de backward induction se repete, cada round gera seu proprio cutoff, a cascata nao elimina a dominancia porque cada correcao e non-negative) seria valiosa. Alternativamente, admitir que a generalizacao para T infinito (Baron-Ferejohn standard) e uma extensao aberta.

3. **Fortalecer a justificativa da exclusao sob maioria**. O argumento atualmente e: "incluir H custa alpha*V(theta) > 0, incluir um W extra custa 0, logo exclusao e otima". Isso depende criticamente de d_W = 0. Adicionar uma frase como: "The exclusion result holds as long as the hegemon's outside option exceeds any weak state's outside option, which is ensured by alpha > 0 and d_W = 0. With heterogeneous outside options, weak proposers would sometimes include the hegemon under majority, partially activating the screening mechanism (Remark 5)."

4. **Equilibrio assimetrico de entrada**. Adicionar uma nota de rodape que diga: "With symmetric weak states and all-or-nothing entry, the only equilibria in pure strategies are all-enter and all-stay-out. Mixed-strategy equilibria exist but yield lower expected payoffs for both the hegemon and weak states. The institutional comparison is therefore robust to equilibrium selection within the symmetric game."

5. **Off-path beliefs**. Adicionar uma frase na definicao do PBE ou em nota de rodape: "Off-path beliefs after unexpected acceptances (e.g., H accepts an offer that only theta=0 would accept in equilibrium) are unrestricted. Since such deviations terminate the game (the offer is accepted and payoffs are realized), off-path beliefs do not affect continuation play."

6. **Bicondicional para tipos continuos**. O paper honestamente admite que alpha*_cont nao esta caracterizado para distribuicoes gerais. Para fortalecer, considerar demonstrar a bicondicional para a uniforme (nao apenas o grid search) ou identificar condicoes suficientes sobre F para que alpha*_cont >= alpha*.

---

## Score breakdown

| Dimensao | Score | Peso | Contribuicao |
|----------|-------|------|---------------|
| T.1 Distancia premissas-conclusoes | 7.5 | 40% | 3.00 |
| T.2 Parcimonia | 9.0 | 25% | 2.25 |
| T.3 Caminho causal | 8.0 | 35% | 2.80 |
| **Total ponderado** | | | **8.05** |

**Score final arredondado: 8.0/10**

---

*Parecer gerado em sessao Claude Code, 2026-04-27. Framework: Edmans (2025), "Learnings From 1,000 Rejections", adaptado para CP teorica.*
