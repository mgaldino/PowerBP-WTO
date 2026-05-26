# Parecer de Execution (Framework Edmans) -- formal_model_v5.Rmd

**Data**: 2026-04-27
**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Reviewer**: Claude Opus 4.6 (execution assessment, Edmans 2025 framework)

---

## Score: 8.0 / 10
## Tipo de paper: TEORICO

---

## Resumo da estrategia de execucao

O paper propoe um modelo de barganha legislativa (Baron-Ferejohn com 2 rounds) em que um hegemon com informacao privada sobre o valor da cooperacao escolhe entre unanimidade e maioria como regra de votacao em uma organizacao internacional. A execucao se estrutura em: (i) derivar payoffs em closed form sob cada regra; (ii) identificar o mecanismo de screening (cutoff onde fracos mudam de oferta agressiva para conservadora) que aparece sob unanimidade mas nao sob maioria; (iii) estabelecer dominancia condicional de unanimidade (Theorem 1, bicondicional); (iv) classificar priors pela interacao entre dominancia condicional e margem de entrada (Corollary + Proposition). A estrategia e parcimoniosa e bem executada: um unico mecanismo (screening sob pivotalidade) gera o resultado central, e o paper explora suas implicacoes sem adicionar camadas desnecessarias.

---

## Principio "Dados vs. Evidencia" (adaptado para papers teoricos)

Em papers teoricos, o analogo do principio "dados nao sao evidencia" e: *premissas nao sao conclusoes*. O paper conclui que um hegemon pode preferir unanimidade porque screening gera uma rent informacional. A pergunta critica e: essa conclusao emerge genuinamente das premissas, ou as premissas ja contem o resultado de forma disfaracada?

**Avaliacao**: A execucao e convincente neste quesito. O resultado NAO esta embutido trivialmente nas premissas. As premissas sao: (a) informacao privada sobre V(theta); (b) regra de votacao determina se H e pivotal; (c) Baron-Ferejohn com proposals simetricas. Nenhuma dessas premissas, isoladamente, implica que unanimidade domina. O resultado emerge da *interacao* entre pivotalidade e incerteza: sob maioria, H e excluido da coalizao e sua informacao nao gera leverage; sob unanimidade, W precisa comprar o voto de H sem saber theta, gerando overpayment. A distancia premissas-conclusoes e genuina.

Ha uma ressalva: a premissa de entry cost c > 0 com entry all-or-nothing e que gera a "unica vantagem da maioria" (via margem de entrada). Sem entry costs, unanimidade dominaria trivialmente em todo o espaco parametrico. O paper e honesto sobre isso, mas o entry cost e algo ad hoc -- nao emerge do modelo, e imposto para criar a comparacao institucional completa. Isso nao invalida o resultado, mas reduz um pouco a distancia premissas-conclusoes no componente de classificacao institucional.

---

## Avaliacao por dimensao

### T.1 Distancia premissas-conclusoes: 8.5 / 10

**O que funciona bem:**
- O mecanismo central (screening sob pivotalidade) emerge de premissas que nao o contem trivialmente. Nenhuma premissa isolada implica a dominancia de unanimidade.
- O resultado bicondicional (Theorem 1: alpha < alpha* iff D(mu) > 0 para todo mu) e particularmente forte porque mostra que a condicao e *necessaria e suficiente* -- nao ha folga parametrica escondida.
- A decomposicao D = D_base + delta_R2 + delta_R1 (Appendix B.5a) oferece transparencia sobre como cada componente contribui para o resultado. Cada correcao e aditiva e afeta um canal independente do payoff de H (proposta de H vs. proposta de W), o que e um sinal de boa arquitetura do modelo.
- O resultado de que alpha* decresce com N e genuinamente derivado, nao imposto, e tem implicacoes substantivas claras (mecanismo mais restritivo para organizacoes grandes).

**Preocupacoes:**
- O modelo impoe que H e o unico jogador com informacao privada. Essa assimetria informacional unilateral e a premissa mais forte. Se fracos tambem tivessem informacao privada (mesmo que menos precisa), o screening operaria em ambas as direcoes e o resultado poderia ser atenuado. O paper menciona isso na Conclusao ("erosao endogena"), mas nao discute o quanto o resultado e fragil a essa extensao.
- A escolha de dois rounds e motivada como "robustez" em relacao a um round, mas os 2 rounds tambem criam estrutura off-path (posterior = 1 apos rejeicao em R1) que e *essencial* para o mecanismo. Nao e claro que o resultado sobrevive com T > 2 rounds, onde a estrutura off-path seria mais complexa. O paper reconhece isso no Scope ("T > 2 rounds -- pos-submissao"), mas a execucao atual nao estabelece robustez aqui.

### T.2 Parcimonia: 9.0 / 10

**O que funciona bem:**
- O modelo e notavelmente parcimonioso para um paper de design institucional. Um unico mecanismo (screening sob pivotalidade) faz todo o trabalho pesado. Nao ha multiplos mecanismos competindo pela atencao do leitor.
- A comparacao institucional se reduz a uma unica distincao: unanimidade cria screening, maioria nao. Tudo o mais (entry, classificacao, comparative statics) decorre dessa distincao.
- A remocao do Bayesian Persuasion do corpo (decisao v5) fortaleceu significativamente a parcimonia. Na v4, BP era co-protagonista; na v5, screening e o mecanismo central e BP aparece apenas como Remark (rem:info_design). Isso eliminou uma camada que distraia do resultado principal.
- O resultado numerico central (alpha* ~ 0.47 para N=5, ~ 0.03 para N=164) emerge diretamente da formula fechada, sem necessidade de simulacao.

**Preocupacoes menores:**
- A presenca do entry cost c como parametro separado adiciona uma dimensao ao espaco parametrico que poderia ser dispensavel. O resultado central (Theorem 1) nao depende de c; a classificacao institucional (Proposition 4) depende. Se o paper focasse exclusivamente no Theorem 1, seria mais parcimonioso. Mas a classificacao e necessaria para a aplicacao substantiva (GATT/WTO), entao o trade-off e razoavel.

### T.3 Caminho causal (variaveis endogenas no path estao livres?): 7.5 / 10

**O que funciona bem:**
- No nucleo do modelo, o caminho causal e limpo: regra de votacao -> pivotalidade de H -> screening sob incerteza -> rent informacional -> preferencia por unanimidade. Nenhuma variavel endogena contamina esse path.
- O modelo resolve corretamente a endogeneidade da escolha institucional: H escolhe R em Stage 0 *antes* de Nature jogar, entao a regra e exogena condicional ao equilibrio. A comparacao e feita sobre objetos bem definidos (payoffs de equilibrio sob cada R).

**Preocupacoes:**
- **Entry como variavel endogena no path**: A entrada de fracos e endogena (depende de V_W^{R1} >= c), e o resultado de classificacao institucional (Proposition 4) depende crucialmente de onde a entrada ocorre. Isso nao e um problema logico (o modelo resolve corretamente por backward induction), mas e um problema de interpretacao: o paper conclui que "majority's only advantage is wider institutional viability", mas essa conclusao depende da tecnologia de entry (all-or-nothing, simultanea, sem free-riding). Se a entrada fosse sequencial, com learning ou free-riding, a margem de entrada poderia operar de forma diferente, e a classificacao poderia mudar. O paper reconhece isso no Scope ("sequential entry -- left open"), mas a execucao atual apresenta a classificacao como definitiva quando ela depende de uma simplificacao especifica.
- **Proposals simetricas como variavel de controle**: O modelo assume proposals simetricas (1/N) sob ambas as regras. Isso e necessario para a comparacao justa, mas tambem elimina um canal pelo qual maioria poderia dominar: sob maioria, agenda setters poderiam explorar a capacidade de excluir H de formas que proposals simetricas nao capturam. O paper justifica isso corretamente (monopolio de agenda mata entrada), mas o resultado e condicional a essa escolha.
- **Ausencia de theta para W**: W nao recebe nenhum beneficio direto de theta. Se W tivesse preferencias tipo-dependentes (por exemplo, diferentes setores se beneficiam diferentemente de theta), o screening problem mudaria. Essa simplificacao e razoavel (WLOG por simetria dos fracos), mas limita a aplicabilidade a situacoes onde fracos sao homogeneos.

---

## Veredicto geral sobre execucao

A execucao deste paper e solida e acima da media para um paper teorico de design institucional em CP. O mecanismo central (screening sob pivotalidade) e derivado com rigor, e o resultado bicondicional (Theorem 1) e particularmente forte. A decomposicao aditiva dos payoffs (B.5a) oferece transparencia rara em modelos de barganha legislativa. A parcimonia e um ponto forte: um unico mecanismo faz todo o trabalho, sem camadas desnecessarias.

As limitacoes da execucao sao: (i) a robustez a T > 2 rounds nao e estabelecida, e o mecanismo depende da estrutura off-path de 2 rounds de forma nao-trivial; (ii) a classificacao institucional depende da tecnologia de entry all-or-nothing, que e uma simplificacao cuja robustez nao e explorada; (iii) a assimetria informacional unilateral e a premissa mais forte, e o paper nao discute formalmente o quanto o resultado e fragil a informacao privada dos fracos. Nenhuma dessas limitacoes e fatal -- sao direcoes naturais para trabalho futuro -- mas elas delimitam o escopo do que a execucao atual pode reivindicar.

O score de 8.0 reflete uma execucao que e forte o suficiente para publicacao em um bom journal (JoP, AJPS), com margem de melhoria nas dimensoes de robustez (T > 2, entry sequencial) que um referee rigoroso provavelmente solicitaria como extensao, nao como condicao bloqueante.

---

## Sugestoes construtivas

1. **Robustez a T > 2 rounds (prioridade alta para R&R)**: O mecanismo depende da estrutura off-path gerada por 2 rounds (posterior = 1 apos rejeicao em R1). Com T > 2, a rejeicao em R1 levaria a um continuation game com T-1 rounds, e a posterior se atualizaria de forma mais gradual. Um resultado que mostrasse que "o screening cutoff existe e e unico para todo T finito" fortaleceria significativamente a execucao. Mesmo um resultado parcial (e.g., "para T = 3, o cutoff R1 existe e o jump e positivo") seria valioso. Na ausencia disso, uma discussao mais detalhada no Scope sobre *por que* 2 rounds e suficiente para o argumento institucional (nao apenas "homologia com BF standard") seria util.

2. **Discutir formalmente informacao privada dos fracos**: Adicionar um paragrafo no Scope ou Discussion sobre o que aconteceria se fracos tivessem informacao privada (mesmo ruidosa) sobre theta. O argumento nao precisa ser formal: basta notar que, se fracos tambem tivessem informacao, o screening problem se tornaria bilateral (H precisa screenar W, W precisa screenar H), e o efeito liquido sobre a preferencia institucional dependeria de assimetrias na qualidade da informacao. Isso delimitaria melhor o escopo do resultado.

3. **Sensibilidade da classificacao a tecnologia de entry**: A classificacao (Proposition 4) depende de entry all-or-nothing. Adicionar uma nota (footnote ou paragrafo no Scope) sobre como a classificacao mudaria com entry parcial (e.g., instituicao forma se pelo menos N-k fracos entram). Mesmo uma conjectura informada seria util para o leitor avaliar a robustez.

4. **Tornar explicita a dependencia da estrutura off-path**: Na Proposicao 2 ou na discussao subsequente, enfatizar que o cutoff R1 e independente de alpha *porque* a rejeicao em R1 leva a R2 com posterior 1, onde os R2 payoffs sao avaliados no regime conservador independentemente de alpha. Isso ajuda o leitor a entender exatamente qual feature do modelo gera qual resultado, e tambem ajuda a avaliar robustez a extensoes.

5. **Extensao continua (C.4) -- fortalecer a execucao**: A afirmacao de que alpha*_cont >= alpha* para a distribuicao uniforme e verificada numericamente ("zero violations across 1,008 parameter combinations"), mas uma prova analitica fortaleceria a execucao. Se o resultado admite prova fechada para a uniforme, vale incluir. Se nao, uma conjectura formal com a evidencia numerica e suficiente, mas deve ser explicitamente rotulada como conjectura.
