# Devil's Advocate Report — Definição operacional de "structural consistency" (baseline)

**Data**: 2026-09-01
**Objeto atacado**: a definição operacional em três cláusulas proposta na sessão de 2026-09-01 para "structural consistency" no baseline de `formal_model_v6.Rmd` (quociente sobre coordenadas fracas; Bayes estrutural em subárvores off-path; coordenada livre local ao ballot), incluindo a linguagem candidata para o Apêndice A.2.
**Fontes confrontadas**: `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` (Decisões 1, 1a, 2, 3 + errata N2); `formal_model_v6.Rmd` (Solution concept, ~linhas 405–425; A.2, ~linhas 1350–1362; E.1, ~linhas 1682–1728); `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json` (campos `belief_system` e `complete_off_path_ballot_correspondence`); `model_redesign/essential_input_n2_r2_unanimity_interface.json` (campo `off_path_ballot`, linhas 28 e 88); `model_redesign/essential_input_game_dag.json` (espelhos, linhas 476/536).
**Regra do skill**: nenhum arquivo do projeto foi editado; este relatório é o único output.

---

## Vulnerabilidade principal

A definição proposta tem um **buraco de cobertura** exatamente na classe de histórias mais delicada: um voto de H que está *dentro* do perfil prescrito (prescrito ao tipo alto) mas ocorre num ballot cuja crença de entrada atribui posterior zero a esse tipo (por exemplo, R2 alcançada após votos separadores de H em R1). Nesse caso o gatilho da cláusula (ii) ("probabilidade positiva sob a crença de entrada") falha E o gatilho da cláusula (iii) como redigido ("probabilidade zero sob os dois valores da outside option") também falha — o voto tem probabilidade positiva sob a lei do tipo alto. Nenhuma cláusula se aplica. A Decisão 1a já resolve a substância (gatilho correto: **denominador bayesiano zero**, liberdade dentro do suporte do **prior**), mas a codificação proposta — e a frase correspondente do próprio manuscrito na seção Solution concept — usam a formulação ambígua "zero probability under both outside-option values", que não coincide com "denominador zero" nesse caso.

## Ataques por dimensão

### 1. Lógica interna (completude e exclusividade das cláusulas)

1. **Gatilhos não exaustivos (o buraco descrito acima).**
   - **Detalhe**: as três cláusulas devem particionar todos os pares (história, voto de H). O caso "ação prescrita a um tipo com posterior corrente zero mas prior positivo" cai fora das cláusulas (ii) e (iii) como redigidas. A Decisão 1a usa o gatilho correto ("Crenças em histórias com denominador bayesiano zero são livres dentro do suporte do prior") e sua cláusula interior é explícita: "crenças após desvios de H continuam livres em [0,1], mesmo que algum posterior tenha atingido zero no caminho". A codificação proposta não reproduziu esse gatilho; reproduziu a frase do manuscrito (linhas ~418–420), que carrega a mesma ambiguidade.
   - **Mitigação factual**: no jogo de duas rodadas, o caso só surge em ballots de R2, que são terminais — crenças após votos terminais são payoff-irrelevantes. Nenhum payoff congelado depende disso. Mas uma definição de conceito de solução não pode ter classe de histórias sem regra, ainda que inócua nos resultados atuais; a extensão de agenda adiciona um estágio anterior e herda o baseline como continuação, então o custo de um gatilho ambíguo cresce.
   - **Severidade**: **Alta** (defeito de completude na codificação e na frase do manuscrito; substância já decidida em 1a).
   - **Como o autor pode responder**: unificar o gatilho em "denominador bayesiano zero sob a crença de entrada", com liberdade dentro do suporte do prior (interior ⇒ [0,1]; degenerado ⇒ massa pontual). Isso é literalmente a Decisão 1a; a correção é de redação, não de conceito.

2. **A primeira frase da linguagem candidata admite leitura cross-ballot falsa.**
   - **Detalhe**: "the posterior after a vote vector depends only on the belief entering the ballot and on H's realized vote" — lida fora do escopo "at every ballot", a frase afirma que dois ballots com mesma crença de entrada e mesmo voto de H têm o mesmo posterior. Falso: a lei prescrita a H pode diferir entre ballots (pooling num, separadora noutro), e Bayes dá posteriores diferentes. A invariância verdadeira é *através da lei*: o posterior depende da história somente via (crença de entrada, lei tipo-contingente prescrita a H naquele ballot, voto realizado de H).
   - **Severidade**: **Média-alta**.
   - **Resposta**: reescrever a frase-mestra como dependência via o trio acima; a invariância a coordenadas fracas vira corolário (coordenadas fracas só entram se a lei prescrita condicionar nelas — e aí Bayes legitimamente separa, canal endossado pela Decisão 1).

3. **"Invariant to the proposer's identity" é overclaim pela mesma razão.**
   - **Detalhe**: a estratégia de H condiciona na história pública completa; se a lei prescrita condiciona na identidade do proponente, os posteriores diferem entre proponentes. A invariância à identidade do proponente vale *dada a lei*, não incondicionalmente.
   - **Severidade**: **Média** (mesma correção do item 2 resolve).

### 2. Fidelidade aos artefatos congelados e às decisões aprovadas

4. **Tensão documental com a interface congelada de N2 (e seus espelhos no game DAG).**
   - **Detalhe**: `essential_input_n2_r2_unanimity_interface.json` declara, nas duas células: "After a zero-probability proposal, any belief in [0,1] is admissible" — proposta de probabilidade zero é desvio de um Estado **fraco**, e a errata aceita em 2026-08-21 **reafirma** essa liberdade no interior ("em 0<ν<1, permanece válida a liberdade original em [0,1]"). Isso contradiz frontalmente o no-signaling da Decisão 1 ("desvios de fracos NÃO movem a crença") e o A.2 do manuscrito ("Uninformed weak-state proposals and votes preserve the current belief"). A definição proposta codifica Decisão 1 e portanto herda a contradição documental com a interface efetiva de N2.
   - **Mitigação factual**: a própria interface registra que estratégias terminais e payoff de desvio são invariantes à crença — em R2 (rodada terminal) a crença após a proposta não alimenta nenhuma continuação, então as duas convenções (crença preservada vs. livre) geram objetos idênticos. A contradição é de classe admissível, não de resultado.
   - **Severidade**: **Alta como inconsistência documental**, baixa como risco de resultado. Um auditor que leia N2 congelado ao lado do A.2 verá afirmações incompatíveis sem nota de reconciliação.
   - **Resposta**: o registro de codificação deve conter uma cláusula de reconciliação explícita: a interface efetiva de N2 usa uma classe de crenças mais permissiva cuja latitude extra é payoff-invariante (invariância declarada no próprio artefato); a norma corrente é Decisão 1; nenhum refreeze é necessário porque nenhum objeto de N2 muda. Sem essa cláusula, a codificação cria a aparência de que N2 precisa de errata adicional.

5. **A afirmação da sessão de que "uma coordenada global quebraria as construções de existência do baseline" não foi verificada.**
   - **Detalhe**: o argumento apresentado foi que as restrições de crença livre dependem da proposta desviante (por exemplo `eta_Y >= 1 - u/A quando B <= u < A` no candidato N4), logo um η global teria de satisfazer todas simultaneamente. Isso mostra que a *mesma classe de continuação* não serviria para todas as propostas — mas a `complete_off_path_ballot_correspondence` oferece várias classes admissíveis por proposta, e não foi verificado se, para todo η global fixado, cada proposta ainda possui ao menos uma classe admissível. A quebra é plausível, não demonstrada.
   - **Severidade**: **Média**.
   - **Resposta**: o argumento correto e suficiente para não impor coordenada global no baseline é o de proveniência: seria conceito novo, exigiria rederivação e re-revisão de material congelado, sem ganho para nenhum resultado atual. A alegação de quebra deve ser rebaixada a "não verificado; irrelevante dado o argumento de proveniência".

6. **Compartilhamento entre rotas distintas para o "mesmo" ballot de R2 — imposto pela definição, não exigido pelos artefatos.**
   - **Detalhe**: a definição via "registro informacional" (sequência de pares lei-prescrita/voto-de-H) força que duas histórias de R2 com o mesmo registro de R1 mas vetores fracos diferentes compartilhem o mesmo valor livre no ballot de R2. Os artefatos congelados nunca precisaram dessa igualdade (crenças pós-voto em R2 são terminais). A definição é, nesse ponto, mais forte do que o uso congelado.
   - **Severidade**: **Baixa** (fortalecimento inócuo no jogo atual), mas deve ser **declarado como escolha**, não apresentado como codificação neutra — no espírito do próprio projeto, que distingue codificar de restringir.

### 3. Consistência com a extensão de agenda (M/S/B)

7. **Assimetria não declarada entre estágios: coordenada livre por-ballot no baseline vs. ρ global no estágio de agenda.**
   - **Detalhe**: em E.1, todas as propostas indisciplinadas de H na data A compartilham um único μ^off = b_ρ(p) por registro; no baseline, cada ballot carrega sua coordenada livre. São ações de H de naturezas diferentes (proposta vs. voto) e a restrição mais forte no estágio A é arquitetura declarada do M/S/B — mas o manuscrito não diz em lugar nenhum *que* as convenções diferem nem *por quê*. Um parecerista de teoria notará que o mesmo jogador, no mesmo jogo composto, tem desvios tratados com disciplinas de crença diferentes conforme o estágio.
   - **Severidade**: **Média** (expositional; nenhum resultado cruza as convenções porque a continuação entra como registro congelado encapsulado).
   - **Resposta**: uma frase em E.1 ou na Seção 6: a coordenada global é uma restrição adicional adotada no estágio de agenda para indexar correspondências; o baseline mantém a classe mais ampla sob a qual seus resultados foram provados; restringir a classe do baseline só enfraqueceria os resultados de inexistência de nada e não alteraria os de existência usados.

### 4. Escopo e generalização

8. **A definição fala em "voting record" mas o conceito precisa cobrir o jogo composto.**
   - **Detalhe**: no baseline H só vota, mas com a extensão integrada o jogo publicado tem H propondo na data A. "Measurable with respect to the hegemon's voting record" é estreito; ou a definição se declara explicitamente restrita ao baseline (com E.1 governando o estágio A), ou usa "H's action record".
   - **Severidade**: **Baixa-média**.

9. **Onde a classe de crenças é load-bearing, e onde não é.**
   - **Detalhe**: o resultado de inexistência (0<p≤p*) quantifica sobre *toda* a classe admissível — é o resultado mais sensível à definição: classe maior = inexistência mais forte; qualquer codificação que *alargue* a classe reabre a prova. As cláusulas propostas não alargam nada em relação ao uso congelado (itens 4 e 6 são, respectivamente, encolhimento reconciliável e fortalecimento inócuo), mas essa verificação direcional — "a codificação não admite nenhum assessment que os artefatos excluam" — deve constar como item de checagem do ciclo de revisão, não como suposição.
   - **Severidade**: **Média** (é a verificação que transforma "codificação" em afirmação auditável).

### 5. Contra-argumentos de literatura

10. **"Structural consistency" não é termo padronizado; o leitor pode ler Kreps–Wilson.**
    - **Detalhe**: o manuscrito já foi queimado uma vez por atribuição indevida (histórico de correção da Decisão 1a). "Structural consistency" evoca a "structural consistency" de Kreps–Wilson (1982) e literatura subsequente sobre consistência de assessments, que NÃO é o que o paper faz. O A.2 atual usa o termo sem defini-lo nem desambiguá-lo.
    - **Severidade**: **Média-alta** para o manuscrito.
    - **Resposta**: definir o termo no primeiro uso e acrescentar uma frase negativa de posicionamento (a condição é declarada e própria; não é a consistência de Kreps–Wilson nem NDOC integral — o texto da Decisão 1a já contém a formulação aprovada para isso).

### 6. Economia do texto

11. **Risco de sobre-formalização no A.2.** A linguagem candidata em prosa é adequada; a tentação de formalizar "registro informacional" com notação de sequências adicionaria meia página de maquinaria para um jogo de duas rodadas onde as classes de equivalência são enumeráveis à mão. A versão em prosa com o trio (crença de entrada, lei prescrita, voto realizado) é suficiente e mais barata. **Recomendação**: não introduzir notação nova no apêndice para isso.

## Ranking de vulnerabilidades

1. **Gatilho ambíguo/incompleto** ("zero under both types" vs. denominador zero) — afeta a codificação proposta E a frase existente do manuscrito; correção puramente redacional graças à Decisão 1a, mas obrigatória antes de qualquer inserção no Rmd.
2. **Tensão documental com a interface efetiva de N2** — sem cláusula de reconciliação, a codificação cria contradição auditável entre A.2 e artefato congelado + errata.
3. **Frase-mestra com leitura cross-ballot falsa / invariância a proponente overclaimed** — corrigir para dependência via (crença de entrada, lei prescrita, voto de H).
4. **Termo "structural consistency" sem desambiguação de Kreps–Wilson** — risco de referee report dado o histórico do projeto.
5. **Assimetria baseline/extensão não declarada** (por-ballot vs. ρ global).
6. **Alegação não verificada de quebra sob coordenada global** — rebaixar a proveniência.
7. **Fortalecimento inócuo entre rotas de R2** — declarar como escolha.

## Recomendações de corte

- Cortar da proposta a justificativa "coordenada global quebraria as construções de existência" (item 6) e substituí-la pelo argumento de proveniência, que é suficiente e verificável.
- Cortar "invariant to the proposer's identity" como cláusula independente; ela é corolário da formulação via lei prescrita e, como cláusula autônoma, é falsa no caso geral.

## O que sobrevive ao escrutínio

- **A cláusula (i) no seu conteúdo essencial** — dentro de um ballot, vetores com o mesmo voto de H compartilham o posterior (η_Y, η_N por ballot) — está exatamente como os registros congelados de N4 a praticam, inclusive para vetos fracos compostos (`H_yes_yes_with_weak_veto`). É a resposta correta à pergunta "quais histórias compartilham a crença off-path".
- **A cláusula (ii)** (Bayes estrutural dado o perfil dentro de subárvores off-path) é transcrição direta da Decisão 1 e do campo `structural Bayes for prescribed H actions` do candidato N4.
- **A localidade da coordenada livre** (por ballot, não global) é o uso congelado documentado — as restrições dependentes de u no candidato N4 provam que a liberdade por proposta foi de fato exercida.
- **A observação de que o quociente fecha os desvios compostos** (H e fraco desviando no mesmo vetor) — este era o caso que a alternativa descartada da Decisão 1 deixava indefinido, e a definição o resolve na direção decidida.
- **A decisão de codificar em vez de deixar vago**: com um resultado central de inexistência que quantifica sobre a classe de crenças, a definição exata da classe é load-bearing; a vagueza atual do A.2 é um passivo real, não pedantismo.

## Definição corrigida (incorporando os ataques 1–3)

> Fix a profile. At each ballot, let the entering belief be the current posterior (weak-state proposals and votes never change it), and let H's prescribed law be the type-contingent vote distribution the profile assigns at that ballot. The posterior after any vote vector depends on the history only through the entering belief, the prescribed law, and H's realized vote; it is therefore invariant across vote vectors of the same ballot that differ only in weak-state votes. If H's realized vote has positive probability under the prescribed law and the entering belief, the posterior is the Bayes update given that law, including at ballots reached by earlier weak-state deviations. If the Bayes denominator is zero, the posterior is a single free value attached to that ballot-and-vote pair, chosen within the support of the prior: any value in [0,1] for an interior prior, and the degenerate posterior at p=0 or p=1. Distinct ballots may carry distinct free values. This condition is a declared restriction of our equilibrium concept; it is not the consistency of Kreps and Wilson (1982), and it is narrower than the never-dissuaded discipline of Osborne and Rubinstein (1990).

Acompanhada de: (a) cláusula de reconciliação com N2 (classe mais permissiva, latitude payoff-invariante declarada no próprio artefato; norma corrente é esta definição; sem refreeze); (b) uma frase declarando a restrição mais forte (ρ global) do estágio de agenda como arquitetura própria do M/S/B; (c) item de checagem para o ciclo de revisão: a codificação não admite nenhum assessment que os artefatos congelados excluam, nem exclui nenhum que alguma construção de existência congelada use.
