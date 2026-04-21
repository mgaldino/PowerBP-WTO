# Esqueleto do paper para RIO

Data: 2026-04-20

Base formal: `notes/2026-04-19_formalizacao_v2.Rmd`

Notas complementares incorporadas:

- `notes/2026-04-20_cutoff_R1_definitivo.md`
- `notes/2026-04-20_extension_proposal_bias.md`

Destino preferencial: *Review of International Organizations* (RIO)

## Q&A / Assunções

**Pergunta de pesquisa.** Por que um hegemon escolheria consenso/unanimidade em uma organização internacional quando maioria parece preservar mais poder distributivo?

**Contribuição pretendida.** Mostrar que consenso pode ser uma tecnologia institucional de poder informacional: unanimidade torna o hegemon pivotal para os fracos, força screening sob incerteza e cria uma não-convexidade explorável por Bayesian Persuasion.

**Journal-alvo.** RIO. Isso muda o enquadramento em três direções: mais ênfase em desenho institucional de organizações internacionais, maior tolerância a caracterização formal/numérica em apêndice, e uma seção substantiva GATT/WTO um pouco mais desenvolvida do que seria ideal para IO.

**Classe do modelo.** Jogo extensivo com escolha institucional, informação privada, entrada, Bayesian Persuasion e barganha legislativa em dois rounds.

**Mecanismo central.** Sob maioria, `W` pode contornar `H`; sob unanimidade, `W` precisa incluir `H` e escolher uma oferta sem observar seu tipo, criando um cutoff de screening que aumenta discretamente o payoff esperado de `H`.

**Tipo de evidência.** Paper teórico com ilustração curta GATT/WTO. A ilustração deve mostrar plausibilidade institucional, não testar o modelo.

**Resultado principal esperado.** Uma condição suficiente analítica, complementada por caracterização numérica das regiões paramétricas em que `cav v(p,U) > cav v(p,M)`.

## Diagnóstico editorial para RIO

RIO é o alvo certo se a estratégia é maximizar probabilidade e velocidade sem abrir mão de ambição teórica. O paper deve parecer menos uma intervenção abstrata em teoria de poder e mais uma contribuição direta para desenho institucional em organizações internacionais.

Em relação a uma versão para *International Organization*, a versão RIO deve:

- Dar mais espaço à comparação institucional concreta entre maioria e consenso.
- Explicar com mais cuidado por que proposal rights simétricos são o benchmark correto.
- Aceitar uma seção GATT/WTO de 5 páginas, desde que ela não vire estudo de caso histórico.
- Usar caracterização numérica no corpo como evidência de escopo, com detalhes completos no apêndice.
- Ser explícita sobre condições paramétricas, inclusive casos em que o resultado falha.

Steinberg pode aparecer, mas não deve organizar a seção empírica. A seção GATT/WTO deve dialogar mais amplamente com regras de consenso, capacidade técnica desigual, comitês, negociação baseada em expertise e assimetria de informação em regimes comerciais. A extensão de proposal bias fornece a ponte mais moderna: consenso e influência informal de agenda não são substitutos; eles interagem.

## Estrutura recomendada

### 1. Introduction

**Função.** Apresentar o puzzle, a tese e a contribuição.

**Conteúdo.**

- O consenso é comum em organizações internacionais mesmo quando grandes potências têm papel central na criação e sustentação dessas instituições.
- Isso parece paradoxal se regras institucionais deveriam refletir assimetrias de poder material.
- A resposta do paper: consenso pode ser escolhido porque torna o poder informacional mais valioso.
- A distinção central é entre poder de agenda e poder informacional.
- Sob maioria, fracos podem formar coalizões sem tornar `H` pivotal.
- Sob unanimidade, fracos precisam barganhar com `H` sob incerteza sobre o valor da cooperação.
- Esse screening cria uma descontinuidade no valor de `H`; Bayesian Persuasion explora essa não-convexidade.
- Preview dos resultados e da ilustração GATT/WTO.

**Formal load.** Nenhuma notação. Apenas a intuição do mecanismo.

**Tamanho sugerido.** 4-5 páginas.

### 2. Consensus and Informational Power in International Organizations

**Função.** Construir a teoria substantiva antes do modelo.

**Conteúdo.**

- Consenso é usualmente tratado como restrição sobre os poderosos.
- O paper propõe outra leitura: consenso pode selecionar o tipo de poder que importa.
- Poder de agenda: capacidade de controlar propostas e coalizões.
- Poder informacional: capacidade de moldar crenças sobre valor, riscos e distribuição de ganhos de cooperação.
- Estados poderosos costumam ter maior capacidade técnica, jurídica, diplomática e informacional.
- Estados fracos entram em negociações sob incerteza sobre o valor real de acordos e sobre alternativas disponíveis.
- A regra de votação determina se essa assimetria informacional se torna payoff-relevant.

**Formal load.** No máximo símbolos mínimos: `H`, `W`, maioria, unanimidade.

**Tamanho sugerido.** 4-6 páginas.

### 3. Institutional Comparison

**Função.** Fixar o benchmark institucional correto.

**Conteúdo.**

- Dois pacotes institucionais:
  - `M`: majority rule.
  - `U`: unanimity/consensus.
- Proposal rights são simétricos nos dois pacotes.
- A diferença entre os pacotes é somente a voting rule.
- Proposal rights simétricos são o baseline para isolar o efeito da regra de votação. A extensão de partial agenda influence relaxa essa hipótese depois do resultado principal.
- Por que não comparar consenso com hegemonic agenda control:
  - agenda control puro reduz o payoff esperado dos fracos;
  - se há custo de entrada, poder de agenda pode impedir a formação da instituição;
  - o puzzle relevante é por que `H` escolheria uma regra que torna sua aprovação necessária quando maioria permitiria contorná-lo.
- Normalização `d_W = 0`.
- Outside option de `H`: `alpha V(theta)`.

**Resultado no corpo.**

- **Definition 1. Institutional Packages.**

**Tamanho sugerido.** 3-4 páginas.

### 4. The Model

**Função.** Apresentar primitives, timing, informação e solução.

**Conteúdo.**

- `N >= 3` jogadores: um hegemon `H` e `N-1` weak states.
- Natureza escolhe `theta in {0,1}`.
- `V(0)=1`, `V(1)=r>1`.
- `H` observa `theta`; `W` não observa.
- `H` escolhe regra institucional e uma estrutura pública de informação.
- `W` observa o sinal, atualiza para posterior `mu` e decide entrada pagando `c`.
- Se a instituição forma, os membros jogam uma barganha Baron-Ferejohn em dois rounds.
- Solução: PBE no subgame de barganha; valor de persuasão por concavificação.

**Figura obrigatória no corpo.**

- **Figure 1. The institutional design game.**
- A árvore do jogo deve ficar no corpo do texto, mas otimizada para caber em uma página.

**Como otimizar a árvore para uma página.**

- Usar uma figura em landscape.
- Dividir em dois painéis dentro da mesma figura:
  - Painel A: escolha institucional, natureza, sinal, entrada.
  - Painel B: módulo de barganha de dois rounds condicional à entrada.
- Não colocar todos os payoffs terminais nos nós. Usar labels compactos como `B_R(theta,mu)` e remeter às equações no texto.
- Mostrar a diferença crucial visualmente:
  - sob `M`, `W` can pass without `H`;
  - sob `U`, `H` is pivotal.
- Representar information sets de `W` com linhas tracejadas apenas onde são essenciais: após `theta` e antes da escolha de oferta.
- Colocar a árvore completa com todos os payoffs no apêndice apenas se a versão de uma página ficar ilegível. O corpo deve manter a figura principal.
- Não redesenhar a árvore principal para incorporar proposal bias. A árvore do corpo representa o modelo base, com recognition simétrica.
- Instrução de legenda: "In the baseline model, each player is recognized with probability `1/N`. Section 9 relaxes this assumption and allows `H` to be recognized with probability `p_H > 1/N`."

**Tamanho sugerido.** 5-6 páginas, incluindo a figura.

### 5. Majority Rule: Linear Bargaining Without Screening

**Função.** Estabelecer o baseline.

**Conteúdo.**

- Sob maioria, `W` pode formar coalizão sem tornar `H` decisivo.
- Mesmo quando `W` inclui `H` por convenção WLOG, o voto de `H` não é pivotal.
- Como a aprovação de `H` não determina se a proposta passa, `W` não precisa resolver um problema de screening.
- O payoff de `H` é tipo-específico e linear em crenças.
- O valor de `H` sob maioria é affine em `mu`.

**Resultado no corpo.**

- **Proposition 1. Majority rule produces no screening.**

**Intuição após o resultado.**

- Maioria transforma a barganha em aritmética de coalizão.
- A informação privada de `H` afeta o valor esperado do acordo, mas não cria uma descontinuidade estratégica.
- Por isso Bayesian Persuasion sob maioria opera apenas via entrada.

**Mover ao apêndice.**

- Derivação completa de R2 e R1 sob maioria.
- Convenção de inclusão/exclusão de `H` por `W`.
- Checks de budget.

**Tamanho sugerido.** 4-5 páginas.

### 6. Consensus: Screening Through Pivotal Inclusion

**Função.** Apresentar o mecanismo formal central.

**Conteúdo.**

- Sob unanimidade, toda proposta precisa da aprovação de `H`.
- Quando `W` propõe, precisa escolher quanto oferecer a `H` sem observar `theta`.
- Oferta agressiva: satisfaz o tipo baixo, mas o tipo alto rejeita.
- Oferta conservadora: satisfaz ambos os tipos, mas paga demais ao tipo baixo.
- Essa escolha gera um cutoff de screening.
- O screening relevante para o paper vive em R1; R2 é threat/continuation value.
- O cutoff de R1 tem solução analítica fechada por casos e é único. Essa é a forma principal do resultado no paper.
- No regime relevante em que `mu_s^{R1} > mu_s^{R2}`, o cutoff de R1 independe de `alpha`: a margem estratégica deixa de depender do nível da outside option de `H` e passa a depender do gap entre tipos, de `beta` e de `N`.

**Resultados no corpo.**

- **Proposition 2. R1 screening cutoff under consensus.**
- **Proposition 3. Conservative offers generate an informational rent for the low type.**

**Intuição após os resultados.**

- Consenso não ajuda `H` porque lhe dá controle formal da agenda.
- Consenso ajuda `H` porque obriga `W` a internalizar a possibilidade de que `H` seja o tipo alto.
- Quando `W` se torna conservador, paga `alpha r` também ao tipo baixo.
- Esse overpayment cria o jump no payoff esperado de `H`.
- O fato de o cutoff poder independer de `alpha` no Caso 2 é substantivamente útil: o mecanismo não exige que `H` tenha uma outside option muito alta. O que importa, nesse regime, é a diferença informacional entre tipos e o valor estratégico de esperar pelo R2.

**Mover ao apêndice.**

- Normal form de R2.
- Cutoff de R2.
- Álgebra piecewise de R1.
- Prova de existência e unicidade do cutoff.
- Fronteira `alpha_bar(r,beta,N)` entre os casos.
- Prova da continuidade de `V_W`.
- Tie-breaking quando `H` está indiferente.

**Tamanho sugerido.** 6-8 páginas.

### 7. Entry and Bayesian Persuasion

**Função.** Conectar barganha, entrada e persuasão.

**Conteúdo.**

- `W` entra se `V_W(mu,R) >= c`.
- Sob maioria, o valor de `H` tem uma não-convexidade simples associada ao threshold de entrada.
- Sob unanimidade, o valor de `H` tem duas fontes de não-convexidade:
  - threshold de entrada;
  - jump de screening.
- O payoff ótimo de `H` sob cada regra é `cav v(p,R)`.
- BP sob unanimidade é mais poderoso porque pode induzir posteriors que cruzam o cutoff de screening.

**Resultado no corpo.**

- **Proposition 4. The unanimity value function has a screening non-convexity absent under majority.**

**Figura no corpo.**

- **Figure 2. Value functions and concavification.**
- Mostrar `v(mu,U)`, `cav v(mu,U)`, `v(mu,M)` e `cav v(mu,M)` para uma parametrização principal.

**Tamanho sugerido.** 5-6 páginas.

### 8. Institutional Choice

**Função.** Entregar o resultado principal.

**Conteúdo.**

- Comparação sem BP:
  - se entrada ocorre apenas sob maioria, maioria domina;
  - se entrada ocorre sob ambas, `H` pode preferir unanimidade enquanto `W` prefere maioria;
  - sem BP, unanimidade não é Pareto superior.
- Comparação com BP:
  - unanimidade pode vencer porque BP explora entry + screening;
  - maioria oferece apenas entry threshold.
- O resultado principal deve ser uma condição suficiente, não uma caracterização exaustiva.
- Usar o cutoff analítico consolidado de R1 para reduzir a dependência da caracterização numérica. A figura de regiões paramétricas deve ilustrar o escopo do teorema, não substituir a lógica formal.

**Resultado no corpo.**

- **Theorem 1. Hegemonic preference for consensus.**
- Formulação sugerida:
  - se o retorno por unidade de crença no jump de screening sob unanimidade excede o retorno correspondente no threshold de entrada sob maioria, então existe um conjunto não vazio de priors para os quais `H` prefere unanimidade.

**Caracterização numérica no corpo.**

- **Figure 3. Parameter regions where consensus dominates majority.**
- Mostrar regiões em `alpha`, `r`, `beta`, `c` ou pares selecionados.
- Para RIO, é aceitável ter essa figura no corpo, desde que:
  - a condição analítica venha antes;
  - a figura seja interpretada como escopo do resultado;
  - o algoritmo e grids estejam no apêndice.

**Tamanho sugerido.** 6-8 páginas.

### 9. Extension: Partial Agenda Influence

**Função.** Responder à objeção de que proposal rights perfeitamente simétricos são estilizados demais para organizações internacionais reais.

**Status.** Remark/extension result no corpo, derivação completa no apêndice. Não transformar em segundo modelo central.

**Conteúdo.**

- Relaxar o baseline `p_H = 1/N` para permitir recognition assimétrica: `p_H > 1/N`.
- Interpretar `p_H` como influência parcial de agenda: presidência informal, maior capacidade de pautar discussões, mais rodadas de fala, controle técnico de drafts ou maior saliência diplomática.
- Sob maioria, o valor continua linear em crenças e não há screening.
- Sob unanimidade, o jump de R1 é proporcional a `p_H(1-p_H)`, abstraindo do deslocamento do cutoff.
- Bias moderado pode amplificar o screening channel porque aumenta o gap entre oferta agressiva e conservadora.
- Bias alto reduz a frequência com que `W` propõe e piora a condição de entrada dos fracos.
- Resultado substantivo: poder informal de agenda e consenso não são substitutos; eles interagem. Algum viés pró-`H` pode deslocar e ampliar o canal informacional, mas excesso de viés destrói a participação que torna consenso valioso.

**Resultado no corpo.**

- **Extension Result. Partial agenda influence has non-monotonic effects.**
- Formulação curta: when `H` is recognized with probability `p_H > 1/N`, moderate recognition bias can increase the R1 screening jump, but higher bias tightens weak states' entry constraint. Therefore, symmetric proposal rights can be understood as participation-preserving restraint rather than as absence of hegemonic influence.

**Mover ao apêndice.**

- R2 e R1 completos com `p_H`.
- Derivação de majority com bias.
- Fórmula do jump de R1.
- Tabelas numéricas.
- Concavificação sob bias.
- Entry thresholds para valores alternativos de `c`.

**Tamanho sugerido.** 2-3 páginas.

### 10. GATT/WTO Illustration

**Função.** Mostrar plausibilidade institucional do mecanismo.

**Status.** Ilustração, não teste.

**Conteúdo.**

- GATT/WTO como ambiente institucional em que consenso convive com assimetria material e técnica.
- Grandes atores possuem capacidade superior de:
  - avaliar efeitos distributivos de regras;
  - antecipar consequências jurídicas;
  - formular propostas tecnicamente complexas;
  - interpretar efeitos de longo prazo;
  - mobilizar expertise em comitês e negociações.
- Estados menores frequentemente enfrentam incerteza sobre valor e distribuição dos acordos.
- A regra de consenso impede simples exclusão, mas também torna os grandes atores pivotal em interações informacionais.
- O mecanismo do modelo ajuda a entender por que uma potência pode aceitar consenso sem abrir mão de poder.
- A extensão de proposal bias torna a ilustração mais realista: o baseline usa proposal rights simétricos para isolar a regra de votação, mas na prática grandes atores podem ter influência informal sobre agenda.
- A mensagem empírica não deve ser que WTO tem proposal rights simétricos perfeitos. A mensagem deve ser que consenso e informal agenda influence interagem: influência moderada pode deslocar o mecanismo informacional, mas influência excessiva pode matar entrada/participação dos fracos.

**Como tratar Steinberg.**

- Usar Steinberg como ponto de partida clássico sobre consenso e poder no WTO.
- Não fazer dele o centro da seção.
- O centro deve ser a lógica institucional: consenso, capacidade técnica desigual, incerteza distributiva, pivotalidade de grandes atores e interação entre consenso e influência informal de agenda.

**Estrutura interna sugerida.**

1. Consensus in GATT/WTO.
2. Informational asymmetries in trade negotiations.
3. Informal agenda influence without agenda monopoly.
4. Why consensus can amplify, not eliminate, asymmetric power.
5. Scope: what the model does and does not claim about WTO politics.

**Tamanho sugerido.** 5 páginas.

### 11. Scope Conditions and Implications

**Função.** Proteger a contribuição contra leituras exageradas.

**Conteúdo.**

- O modelo não diz que consenso sempre favorece hegemons.
- Consenso favorece `H` quando:
  - há assimetria informacional relevante;
  - `H` tem outside option valioso;
  - `W` precisa decidir entrada sob incerteza;
  - a barganha torna `H` pivotal;
  - BP consegue mover crenças de forma crível.
- Maioria deve dominar quando:
  - informação é pública;
  - `W` pode excluir `H` sem custo;
  - entrada não depende de crenças;
  - `H` não consegue comprometer-se a uma estrutura informacional;
  - o custo de compensar `H` sob consenso é alto demais.
- Partial agenda influence tem efeito ambíguo:
  - viés moderado pode ampliar o screening channel;
  - viés alto pode destruir a entrada;
  - monopoly agenda control continua sendo autodestrutivo quando fracos precisam pagar custo de entrada.
- Implicação principal: instituições não apenas refletem poder; elas selecionam qual forma de poder se torna politicamente produtiva.

**Tamanho sugerido.** 3-4 páginas.

### 12. Conclusion

**Função.** Fechar a contribuição.

**Conteúdo.**

- Retomar o puzzle.
- Reafirmar que consenso pode ser uma tecnologia de poder, não apenas uma restrição.
- Conectar o mecanismo a debates sobre desenho institucional, poder informal e informação em organizações internacionais.
- Indicar extensões sem abri-las:
  - erosão endógena do poder informacional;
  - heterogeneidade entre weak states;
  - potências médias;
  - repeated institutional learning.

**Tamanho sugerido.** 1-2 páginas.

## Plano de proposições

**Definition 1. Institutional Packages.** Define `M` e `U`, com proposal rights simétricos.

**Definition 2. Institutional Design Game.** Define jogadores, informação, payoffs, entrada, timing e solução.

**Proposition 1. Majority rule produces no screening.** Sob maioria, `H` não é pivotal para aprovação quando `W` propõe; portanto, não há cutoff de screening e o valor de `H` é affine em crenças.

**Proposition 2. R1 screening cutoff under consensus.** Sob unanimidade, `W` escolhe entre oferta agressiva e conservadora em R1; existe um único cutoff interior relevante. No caso em que `mu_s^{R1} > mu_s^{R2}`, o cutoff independe de `alpha`.

**Proposition 3. Screening creates an informational rent.** Acima do cutoff, o tipo baixo de `H` é pago como se pudesse ser o tipo alto, gerando jump positivo em `E[V_H]`.

**Proposition 4. Unanimity creates an additional persuasion opportunity.** A função `v(mu,U)` tem uma não-convexidade de screening ausente em `v(mu,M)`.

**Theorem 1. Hegemonic preference for consensus.** Sob condições suficientes, existe um conjunto não vazio de priors para os quais `cav v(p,U) > cav v(p,M)`.

**Corollary 1. Screening gains are largest near the cutoff.** O ganho de unanimidade é maior próximo ao ponto em que `W` passa de agressivo para conservador.

**Corollary 2. Consensus is most valuable when informational power substitutes for agenda power.** A vantagem de unanimidade aumenta quando o jump de screening é grande relativamente ao ganho linear de maioria.

**Extension Result. Partial agenda influence has non-monotonic effects.** Se `H` é reconhecido com probabilidade `p_H > 1/N`, viés moderado pode ampliar o jump de R1, mas viés alto dificulta entrada. Derivação completa no apêndice.

## Figuras no corpo

**Figure 1. The institutional design game.**

- Deve ficar no corpo.
- Deve caber em uma página.
- Preferência: landscape, dois painéis, labels compactos.
- Evitar payoffs terminais completos.
- Mostrar explicitamente a diferença entre `M` e `U`.
- Não incorporar `p_H > 1/N` na árvore principal.
- Legenda deve antecipar a extensão: "In the baseline model, each player is recognized with probability `1/N`. Section 9 relaxes this assumption and allows `H` to be recognized with probability `p_H > 1/N`."

**Figure 2. Screening under unanimity.**

- Eixo horizontal: posterior `mu`.
- Regiões agressiva e conservadora.
- Jump no payoff esperado de `H`.

**Figure 3. Value functions and concavification.**

- `v(mu,U)`, `cav v(mu,U)`, `v(mu,M)`, `cav v(mu,M)`.
- Uma parametrização principal.

**Figure 4. Parameter regions.**

- Região em que `H` prefere consenso.
- Idealmente uma figura simples com dois parâmetros por painel.
- Detalhes computacionais no apêndice.

**Figure 5. Partial agenda influence (opcional).**

- Só entra no corpo se houver espaço.
- Mostrar `p_H(1-p_H)` e/ou entry thresholds sob proposal bias.
- Se a seção ficar longa, mover a figura para o apêndice e manter apenas o Extension Result no corpo.

## Apêndice

### Appendix A. Bargaining Derivations

- A.1 Majority R2.
- A.2 Majority R1.
- A.3 Unanimity R2.
- A.4 Unanimity R1.
- A.5 Piecewise derivation of the R1 cutoff.
- A.6 Budget checks.
- A.7 Tie-breaking conventions.

### Appendix B. Proofs

- B.1 Proof of Proposition 1.
- B.2 Proof of Proposition 2.
- B.3 Proof of Proposition 3.
- B.4 Proof of Proposition 4.
- B.5 Proof of Theorem 1.
- B.6 Proofs of corollaries.
- B.7 Proof/derivation of the Extension Result, if stated formally.

### Appendix C. Bayesian Persuasion

- C.1 Definition of `v(mu,R)`.
- C.2 Entry thresholds.
- C.3 Concavification.
- C.4 Sufficient conditions.
- C.5 Numerical implementation.

### Appendix D. Numerical Characterization

- D.1 Baseline parameterization.
- D.2 Grid over `alpha`, `r`, `beta`, `c`, `N`.
- D.3 Robustness to alternative tie-breaking.
- D.4 Cases where `V_W(U) < V_W(M)` fails.
- D.5 Cases where `H` does not prefer unanimity.

### Appendix E. Partial Agenda Influence

- E.1 R2 and R1 with `p_H > 1/N`.
- E.2 Majority with recognition bias.
- E.3 R1 jump under bias.
- E.4 Entry thresholds under bias.
- E.5 Concavification and numerical checks under bias.
- E.6 Low-cost and high-cost entry cases.

### Appendix F. Additional Institutional Background

- F.1 GATT/WTO consensus practice.
- F.2 Capacity asymmetries in trade negotiations.
- F.3 Additional examples beyond trade, if needed.

## Page budget para RIO

| Seção | Páginas | Função |
|---|---:|---|
| Introduction | 4-5 | Puzzle, tese, preview |
| Consensus and Informational Power | 4-6 | Teoria substantiva |
| Institutional Comparison | 3-4 | Benchmark institucional |
| Model | 5-6 | Primitives + árvore |
| Majority | 4-5 | Baseline linear |
| Consensus | 6-8 | Mecanismo central |
| Entry and BP | 5-6 | Persuasão |
| Institutional Choice | 6-8 | Resultado principal + regiões |
| Partial Agenda Influence | 2-3 | Extensão/robustez |
| GATT/WTO Illustration | 5 | Plausibilidade institucional |
| Scope Conditions | 3-4 | Implicações e limites |
| Conclusion | 1-2 | Fechamento |

Total esperado: 48-59 páginas antes do apêndice. Para submissão, mirar 45-50 páginas no corpo, mantendo a extensão de proposal bias enxuta e deslocando detalhes para o apêndice online.

## Prioridades de escrita

1. Reescrever o paper a partir do modelo v2, não da versão antiga de `formal_model.Rmd`.
2. Fazer a árvore de uma página antes de finalizar a seção de modelo, porque ela disciplinará a exposição.
3. Consolidar o cutoff de R1 e decidir qual forma exata aparece no corpo.
4. Derivar uma condição suficiente para o Teorema 1.
5. Escrever a extensão de partial agenda influence como remark/extension result, sem transformá-la em segundo modelo central.
6. Rodar caracterização numérica reproduzível para RIO.
7. Escrever a seção GATT/WTO como ilustração de plausibilidade, não como teste causal, usando a extensão de proposal bias para discutir informal agenda influence.

## Riscos editoriais

**Risco 1: árvore ilegível.** A solução é uma árvore modular de uma página, não a árvore completa com todos os payoffs.

**Risco 2: excesso de resultados formais.** O corpo deve ter poucas proposições hierarquizadas. Lemas algébricos vão para o apêndice.

**Risco 3: resultado principal depender demais de simulação.** Para RIO, caracterização numérica é aceitável, mas deve vir depois de uma condição suficiente analítica.

**Risco 4: GATT/WTO parecer anedótico.** A seção deve ser explicitamente uma ilustração do mecanismo e deve reconhecer escopo.

**Risco 5: versão antiga contaminar o argumento.** Remover completamente `N=3`, `g`, benefício direto de `theta` para `W` e majority-plus-agenda-control como comparação principal.

**Risco 6: extensão de proposal bias competir com o modelo principal.** Tratar como extension result curto. O corpo deve vender apenas a intuição: viés moderado amplia screening; viés alto mata entrada. A derivação completa fica no apêndice.
