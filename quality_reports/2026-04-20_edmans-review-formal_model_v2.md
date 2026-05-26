# Edmans Review — formal_model_v2.Rmd (2026-04-20)

Manuscrito avaliado: `formal_model_v2.Rmd` (950 linhas, pre-edits)

---

# Carta Editorial — Framework Edmans (Contribution, Execution, Exposition)

## Decisao: **Reject-and-Resubmit**

## Scores consolidados

| Dimensao     | Score | Rating              |
|-------------|-------|---------------------|
| Contribution | 6/10  | Promissora mas incompleta |
| Execution    | 6.5/10| Mecanismo claro, teorema principal insuficiente |
| Exposition   | 7/10  | Boa escrita, empacotamento a melhorar |
| **Global**   | **6.5/10** | **Abaixo do limiar para R&R** |

## Sintese editorial

O manuscrito apresenta um insight genuinamente novo e bem articulado: unanimidade pode ser uma *tecnologia de poder informacional*, nao uma concessao. O mecanismo — inclusao pivotal gera screening, screening gera nao-convexidade, BP explora a nao-convexidade — e elegante e claramente formalizado nos building blocks (Propositions 1-4). A escrita e competente, a notacao e consistente, e a introducao identifica o gap com precisao.

**Principal forca**: A combinacao de Bayesian Persuasion com barganha legislativa e design institucional de OIs e original. Nenhum paper existente conecta voting rules a poder informacional via screening dessa forma. O puzzle e importante e a resposta e nao-obvia.

**Principal fraqueza**: O Theorem 1 nao fecha a questao. Ele decompoe a comparacao institucional em dois canais (payoff condicional vs. entrada) mas nao os resolve conjuntamente. A condicao suficiente S_U > S_M e verificada apenas numericamente. Para um paper cuja contribuicao e precisamente o mecanismo formal, a incapacidade de entregar uma comparacao analitica sharp e uma lacuna seria. O paper promete explicar por que o hegemon escolhe unanimidade, mas a resposta formal e "depende dos parametros" — sustentada por um grid search, nao por um teorema.

## Hierarquia Edmans aplicada

A hierarquia contribution > execution > exposition aplica-se aqui de forma clara: o bottleneck e a **execucao**, nao a contribuicao nem a exposicao.

A contribuicao e adequada — o puzzle e importante, o insight e novo, e o mecanismo e nao-trivial. Se a execucao entregasse um teorema de comparacao sharp, o paper seria competitivo para IO, AJPS ou BJPS. A exposicao e boa (prosa clara, estrutura logica) com problemas corrigiveis (citacao quebrada, repeticao de motivacao empirica, secoes perifericas infladas).

O problema central e que a execucao fica a 80% do caminho: os building blocks estao solidos, mas o resultado principal (a comparacao institucional) nao e provado analiticamente. Alem disso, a robustez do mecanismo ao tipo binario ({0,1}) nao e discutida — o leitor sofisticado perguntara imediatamente se a nao-convexidade discreta sobrevive com tipos continuos.

Investir em melhorar execucao e justificado porque a contribuicao e forte o suficiente para sustentar o paper *se* os resultados formais forem completados.

## Prioridades para revisao

1. **Fechar o Theorem 1 analiticamente.** Derivar condicoes parametricas explicitas (em termos de r, alpha, beta, N, c, p) sob as quais cav v(p,U) > cav v(p,M), resolvendo ambos os canais simultaneamente. Uma condicao suficiente analitica — mesmo que nao necessaria — seria substancialmente mais forte que a decomposicao atual + numerica.

2. **Discutir robustez a tipos continuos.** O mecanismo inteiro depende de um jump discreto que e produto natural de screening binario. Com tipos continuos, a schedule de ofertas pode ser smooth e a nao-convexidade desaparecer. Explicar por que o mecanismo sobrevive (ex: com K tipos, K-1 cutoffs -> mais nao-convexidades) ou reconhecer a limitacao.

3. **Corrigir a citacao quebrada e verificar cross-references.** @schnakenberg2015 nao existe no .bib. Os labels de figuras usam underscores (bp_illustration) mas o texto referencia hyphens (fig:bp-illustration). Corrigir antes de submeter.

4. **Consolidar Secoes 9, 10 e 11 em uma secao "Discussion".** A extensao e um sketch, a ilustracao GATT/WTO e qualitativa, e as scope conditions incluem uma mini-review deslocada. Combinar economizaria 2-3 paginas e melhoraria o flow.

5. **Adicionar um exemplo numerico worked-out no texto.** Apos Proposition 4, um paragrafo mostrando magnitudes concretas tornaria o mecanismo tangivel.

## Recomendacao estrategica ao autor

O paper tem um insight forte em um estagio de execucao incompleto. A contribuicao *nao* e o bottleneck — o puzzle e importante e a resposta e original. O bottleneck e a distancia entre os building blocks (que estao solidos) e o resultado de comparacao institucional (que e parcial).

Recomendo **nao submeter na forma atual**. Com o Theorem 1 fechado analiticamente e a discussao de robustez a tipos continuos, o paper seria competitivo para **IO** (International Organization) ou **BJPS**. Para APSR ou AJPS, o paper precisaria adicionalmente de predicoes testaveis ou uma calibracao empirica.

A boa noticia: as revisoes necessarias sao *tecnicas*, nao *conceituais*. O design do modelo e a intuicao estao corretos. O que falta e completar a matematica do resultado principal e enderecar objecoes previsiveis de referees (tipos continuos, horizonte finito, convencao de inclusao sob maioria).

---

## Acoes tomadas apos a review

1. **Consolidacao de secoes aceita e implementada**: Secoes 9 (Extension), 10 (GATT/WTO) e 11 (Scope) consolidadas em uma unica secao "Discussion" com 3 subsecoes: Partial Agenda Influence, Illustration: GATT/WTO, Scope. Economia de ~60 linhas (~2 paginas). Mini-review de alternative explanations comprimida de 3+1 paragrafos para 1 paragrafo de contraste rapido.

2. **Limitacao de tipos continuos reconhecida na Conclusion**: Paragrafo adicionado explicando que K tipos finitos geram K-1 cutoffs (mecanismo mais rico), mas tipos continuos eliminam os jumps discretos. Defesa substantiva: tipos discretos sao naturais (regimes qualitativos como rodadas ambiciosas vs. modestas).

3. **Roadmap atualizado**: De 12 secoes para 10 secoes.

---

# Parecer completo — Contribution

## Score: 6/10

## Resumo da contribuicao alegada

O paper argumenta que unanimidade pode ser uma tecnologia de poder hegemonico, nao uma concessao. Via modelo Baron-Ferejohn com informacao assimetrica e BP, unanimidade forca screening que gera nao-convexidade exploravel via persuasao. Maioria elimina esse mecanismo porque o voto do hegemon nao e pivotal.

## Avaliacao por dimensao

### Novidade [Adequada / Forte em potencial]

O insight de que unanimidade transforma informacao privada em poder estrategico via screening e genuinamente novo. A literatura sobre design institucional de OIs (Koremenos et al. 2001, Maggi & Morelli 2006) nao conecta voting rules a Bayesian Persuasion, e a literatura de BP (Kamenica & Gentzkow 2011, Alonso & Camara 2016) nao examina barganha legislativa com entrada endogena. A combinacao e original e nao trivial: o resultado de que unanimidade gera uma nao-convexidade *ausente* sob maioria e um insight que atualiza crencas significativamente.

Porem, a novidade e parcialmente atenuada pelo fato de que o resultado principal (Theorem 1) e essencialmente uma comparacao condicional (unanimidade domina *condicional a entrada*) com a ressalva de que maioria pode dominar via entrada. Isso deixa o resultado institucional principal como uma comparacao incompleta.

### Importancia [Adequada]

O puzzle e genuinamente importante e bem motivado. "Por que o hegemon aceita unanimidade?" e uma questao central em RI. Contudo, a importancia pratica e limitada por tres fatores: (1) commitment a estrutura de sinais e hipotese forte em RI; (2) modelo estilizado demais para predicoes testaveis; (3) Secao GATT/WTO e narrativa sem calibracao.

### Adequacao ao escopo [Adequada]

Referencias predominantemente de CP/RI. Adequado para IO, AJPS, BJPS. Bibliografia curta (13 refs) com ausencias notaveis: Fey & Ramsay, Morrow, Bagwell & Staiger, Dreher & Voigt.

### Generalizabilidade [Limitada]

Pie binario, 2 rounds, fracos simetricos, outside option proporcional. Nao discute tipos continuos, supermaioria, ou heterogeneidade entre fracos.

### Trade-offs [Parcial]

Documenta trade-off entry vs. screening, mas nao discute custo de commitment, hold-up por fracos, supermaioria como alternativa, ou welfare comparison.

### Hipoteses [Claras e direcionais]

Cadeia causal precisa: unanimidade -> inclusao pivotal -> screening -> jump -> BP. Comparative statics direcionais. Porem, a hipotese central nao e demonstrada como resultado geral.

## Veredicto geral sobre contribution

O paper apresenta um insight genuinamente novo e potencialmente importante. O mecanismo e elegante e a intuicao e clara. Para publicacao em top journal, o paper apresenta tres fraquezas: (1) Theorem 1 nao fecha a questao; (2) generalizabilidade limitada pela estrutura binaria; (3) conexao empirica puramente narrativa.

## Sugestoes construtivas

1. Fechar o Theorem 1 com condicao parametrica explicita
2. Discutir tipos continuos
3. Considerar supermaioria
4. Ampliar bibliografia
5. Calibracao estilizada
6. Welfare analysis
7. Mapear commitment a praticas observaveis

---

# Parecer completo — Execution

## Score: 6.5/10
## Tipo: Teorico

## Resumo da estrategia

Modelo Baron-Ferejohn 2 rounds com informacao assimetrica + BP para comparar payoff do hegemon sob maioria vs. unanimidade. Mostra que unanimidade cria screening cutoff (nao-convexidade) ausente sob maioria.

## Principio "Dados vs. Evidencia"

Os resultados constituem evidencia parcial. Propositions 1-4 sao limpas e claramente estabelecidas. Porem, a headline claim — que o hegemon *prefere* unanimidade — nao e provada como resultado geral. Theorem 1 e uma decomposicao, nao um resultado de dominancia.

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes [5/10 — Preocupacao significativa]

1. **Convencao WLOG de inclusao sob maioria** faz mais trabalho do que reconhecido. A indiferenca e fragil — depende de outside option perfeitamente frictionless.

2. **Tipo binario** faz trabalho pesado. Com tipos continuos, o screening pode ser smooth e a nao-convexidade discreta desaparecer.

3. **Dois rounds** e especial. No horizonte infinito, o screening pode se suavizar.

4. A conclusao esta proxima das premissas de modo preocupante.

### T.2 Parcimonia [8/10 — Boa]

Modelo parcimonioso com cadeia causal clara. Tensao entre parcimonia e 6 parametros a rastrear. Case 1 handwaved.

### T.3 Caminho causal [6/10 — Preocupacao notavel]

1. Entry endogena: resultado mais forte (Lemma 1) e condicional a entrada.
2. Beliefs pos-sinal endogenas ao design de BP: comparacao de concavificacoes e numerica.
3. Off-path beliefs: nao discute refinamentos (D1, intuitive criterion).
4. alpha-bar nunca derivado explicitamente.

## Veredicto geral sobre execution

Os building blocks estao solidos. O problema e que a execucao nao fecha o loop. O main theorem e uma decomposicao, nao um resultado de dominancia. Para um paper cuja contribuicao e precisamente o mecanismo formal, a incapacidade de entregar uma comparacao analitica sharp e uma lacuna significativa.

## Sugestoes construtivas

1. Provar comparacao analitica sharp ou explicitar por que e intratavel
2. Abordar restricao de tipo binario
3. Clarificar convencao de inclusao sob maioria
4. Verificar unicidade de equilibrio no subgame de screening
5. Discutir horizonte finito
6. Derivar alpha-bar em closed form
7. Adicionar referencias faltantes (Baranski & Reuben 2023, Schnakenberg 2015)

---

# Parecer completo — Exposition

## Score: 7/10

## Avaliacao por dimensao

### Clareza [Boa]

Prosa profissional, notacao consistente. Problemas: (a) Cross-references possivelmente quebradas (underscores vs. hyphens nos labels). (b) Citacao @schnakenberg2015 ausente do .bib. (c) Linguagem vaga em comparative statics ("more likely", "some", "should decline"). (d) Falta exemplo numerico worked-out.

### Extensao [Adequado, tendendo a Longo]

Intro bem estruturada (~2.5 paginas). Problemas: (a) Motivacao empirica repetida 3 vezes. (b) Secao 9 e sketch sem proposicao. (c) Secao 10 qualitativa e defensiva. (d) Secao 11 contem mini-review deslocada. (e) 12 secoes e excessivo.

### Citacoes [Precisas]

Bibliografia enxuta (11 refs), bem direcionada. Uma citacao quebrada (@schnakenberg2015). Algumas refs perifericas poderiam ser cortadas.

## Veredicto geral sobre exposition

O manuscrito e claramente escrito e bem organizado. Principais fraquezas: repeticao empirica, secoes perifericas infladas, ausencia de exemplo numerico, uma citacao quebrada.

## Top 5 sugestoes

1. Fix citacao quebrada e cross-references
2. Adicionar exemplo numerico worked-out
3. Eliminar repeticao tripla da motivacao empirica
4. Consolidar Secoes 9-11 em "Discussion"
5. Substituir hedging vago por afirmacoes precisas
