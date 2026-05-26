# Carta Editorial -- Framework Edmans (Contribution, Execution, Exposition)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Data**: 2026-04-27
**Framework**: Edmans (2025), "Learnings From 1,000 Rejections", adaptado para CP
**Editor**: Claude Opus 4.6 (simulacao editorial)

---

## Decisao: R&R minor

## Scores consolidados

| Dimensao     | Score | Rating               |
|-------------|-------|-----------------------|
| Contribution | 7.0/10 | R&R -- mecanismo novo, importancia quantitativa limitada para N grande |
| Execution    | 8.0/10 | Forte -- bicondicional limpo, parcimonia exemplar |
| Exposition   | 7.5/10 | Boa -- Discussion longa, abstract sem numeros |
| **Global**   | **7.5/10** | **R&R minor** |

---

## Sintese editorial

O paper apresenta um mecanismo genuinamente novo para explicar por que um hegemon pode preferir consenso a maioria em organizacoes internacionais: unanimidade forca estados fracos a incluir o hegemon sob incerteza, gerando screening que produz uma renda informacional; maioria elimina essa renda ao permitir coalizoes sem o hegemon. O resultado principal (Theorem 1) e um bicondicional elegante -- alpha < alpha* iff unanimidade domina condicionalmente em todo o espaco de beliefs -- e a decomposicao aditiva (B.5a) oferece transparencia rara. A parcimonia e exemplar: um unico mecanismo faz todo o trabalho.

A principal forca e a novidade: ninguem na literatura identificou este canal, e o resultado produz um Bayesian update genuino no leitor. A principal fraqueza e quantitativa: alpha* diminui rapidamente com N (0.47 para N=5, 0.03 para N=164), restringindo a dominancia global a organizacoes pequenas ou a hegemons com outside options modestas. Para a aplicacao motivadora (WTO), o mecanismo opera num corredor parametrico estreito. O Remark 1 (mu_bar estavel) atenua parcialmente, mas nao elimina a preocupacao.

As tres dimensoes se reforcam: a execucao e forte o suficiente para sustentar a contribuicao, e a exposicao e boa o suficiente para comunicar ambas. O bottleneck e a contribuicao -- nao por falta de novidade, mas por relevancia quantitativa para organizacoes grandes, diferenciacao insuficiente com a literatura mais proxima (Bardhi & Guo, Kim-Kim-Van Weelden), e ausencia de numeros memoraveis no abstract.

---

## Hierarquia Edmans aplicada

A hierarquia contribution > execution > exposition opera de forma clara neste manuscrito. A execucao (8.0) e forte e nao e o bottleneck -- o modelo e bem construido, parcimonioso, e o bicondicional e um resultado tecnico solido. A exposicao (7.5) tem problemas corrigiveis (Discussion longa, abstract sem numeros) que nao obscurecem a contribuicao.

O bottleneck e a contribuicao (7.0). A novidade e genuina (o ativo principal), mas a importancia pratica e limitada pelo corredor parametrico de alpha* para organizacoes grandes. A questao editorial e: **a contribuicao e forte o suficiente para justificar investir em melhorar execucao/exposicao?** Sim -- o mecanismo e novo, a formalizacao e limpa, e as limitacoes sao honestas. Mas o autor deve confrontar mais diretamente a tensao entre a elegancia do resultado teorico e sua aplicabilidade quantitativa.

---

## Prioridades para revisao

1. **Confrontar alpha* para N grande com mapeamento concreto** (Contribution). Adicionar um paragrafo que mapeie alpha* para tipos concretos de organizacoes: pequenas (N=5-10, Quad, G7: alpha* generoso), medias (N=20-30, G20, Conselho de Seguranca: alpha* moderado), grandes (N=164, WTO: alpha* ~ 0.03). Mostrar que o mecanismo opera numa faixa substantiva de beliefs mesmo quando alpha > alpha* (via mu_bar). Resolver a tensao "most favorable case" vs. "most conservative case" entre corpo e conclusao.

2. **Adicionar numero concreto ao abstract** (Exposition). A frase "weaker states pay more than necessary" e generica. Adicionar: "In calibrated examples, the screening mechanism gives the hegemon 27--41% higher payoffs than under majority rule." Maior impacto para primeira impressao.

3. **Comprimir Discussion/GATT de ~2.5 para ~1.5 paginas** (Exposition). Reduzir capacity asymmetry a 2 frases; separar mega-paragrafo de previsao discriminante; eliminar redundancias internas e com a intro.

4. **Expandir diferenciacao com Bardhi & Guo e Kim-Kim-Van Weelden** (Contribution). Dedicar 2-3 paragrafos (nao 1 frase) explicando: o que cada um faz, o que nao faz, e por que a combinacao aqui nao e trivial.

5. **Discutir robustez a T > 2 rounds** (Execution). Ao menos um paragrafo no Scope sobre por que o screening cutoff provavelmente sobrevive com mais rounds, ou um resultado parcial para T=3. A dependencia da estrutura off-path de 2 rounds e a principal fragilidade tecnica.

---

## Recomendacao estrategica ao autor

O paper esta no territorio de R&R minor para JoP ou AJPS. A contribuicao e genuina e o mecanismo e original -- isso o coloca acima da maioria dos papers de formal theory em CP/RI. As revisoes necessarias sao substancialmente editoriais (abstract, Discussion, diferenciacao com literatura) e nao requerem nova modelagem.

O principal risco estrategico e que um referee focado em importancia quantitativa argumente que alpha* ~ 0.03 para WTO torna o resultado irrelevante para a aplicacao motivadora. A defesa esta no Remark 1 (mu_bar estavel) e na extensao continua (alpha*_cont >= alpha*), mas precisa ser articulada de forma mais agressiva. Considerar adicionar uma frase explicita: "The mechanism is most powerful in small-to-medium organizations (N=5-30), which are empirically the most common setting for institutional design choices in international relations."

A submissao ao JoP e razoavel. IO seria uma alternativa se o autor quiser enfatizar a aplicacao WTO. AJPS seria viavel se o framing fosse mais "political economy of institutions" e menos "IR design."

**Veredicto: vale a pena revisar para este journal. As mudancas necessarias sao editoriais, nao estruturais.**

---

## Parecer completo -- Contribution

# Parecer de Contribution (Framework Edmans)

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Versao**: v5 (formal_model_v5.Rmd)
**Data**: 2026-04-27
**Framework**: Edmans (2025), "Learnings From 1,000 Rejections", adaptado para CP
**Avaliador**: Editor simulado de top journal CP (JoP/AJPS/IO)

---

## Score: 7.0/10

**Veredicto editorial**: Revise & Resubmit. A contribuicao e genuina e o mecanismo e original, mas enfrenta limitacoes quantitativas que precisam ser mais honestamente confrontadas, e a diferenciacao com a literatura mais proxima permanece insuficiente.

---

## Resumo da contribuicao alegada

O paper propoe que um hegemon pode preferir consenso (unanimidade) a maioria em organizacoes internacionais porque unanimidade forca estados fracos a incluir o hegemon em toda proposta sob incerteza sobre o valor da cooperacao. Isso cria um screening problem que gera uma renda informacional para o hegemon --- um jump discreto no payoff esperado. A comparacao institucional reduz-se a: unanimidade domina condicionalmente a entrada; maioria so domina via viabilidade institucional mais ampla.

---

## Avaliacao por dimensao

### Novidade [Forte]

Este e o ponto mais forte do paper. O mecanismo e genuinamente novo: ninguem na literatura de institutional design de OIs identificou que unanimidade pode ser preferida por um ator poderoso *porque* cria um screening problem que maioria elimina. A insight e counterintuitive --- a literatura convencional (Keohane, Ikenberry) trata unanimidade como self-binding, e a literatura de informal power (Steinberg, Stone) trata-a como irrelevante diante de poder assimetrico. O paper encontra um terceiro caminho: unanimidade como *tecnologia de poder informacional*.

A combinacao de Baron-Ferejohn com screening endogeno pela voting rule e original. Nao e uma combinacao convexa de resultados conhecidos. Bardhi & Guo (2018) estudam BP em votacao, mas nao com barganha legislativa e screening endogeno. Kim, Kim & Van Weelden estudam informacao em votacao, mas sem o mecanismo de institutional choice. O paper cria algo novo ao mostrar que a *voting rule* determina se screening ocorre ou nao.

O leitor atualiza significativamente suas crencas apos ler o resultado central? Sim: a proposicao de que unanimidade pode ser *preferida pelo ator mais poderoso* por razoes distributivas (nao normativas) e um update substantivo sobre como pensar sobre institutional design em OIs. A decomposicao limpa --- unanimidade domina condicionalmente, maioria domina por viabilidade --- e elegante e memoravel.

**Evidencia**: Theorem 1 (condicional dominance bicondicional), Proposition 4 (classificacao completa), e a identificacao precisa de alpha* como threshold necessario e suficiente.

### Importancia [Adequada, tendendo a Fraca]

Este e o ponto onde o paper enfrenta maior pressao editorial. Varias preocupacoes:

1. **Relevancia quantitativa para OIs reais**: alpha* diminui rapidamente com N. Para N=164 (WTO), alpha* ~ 0.03. O paper reconhece isso (p. 10, Sec. 7), mas a implicacao e severa: o resultado de dominancia condicional *global* so vale para hegemons com outside options muito modestas em organizacoes grandes. O Remark 1 (mu_bar) atenua parcialmente --- a fronteira e "remarkably stable" --- mas a regiao vermelha (maioria domina) perto de mu=1 existe e cresce com N. Para a aplicacao motivadora (WTO), o mecanismo opera num corredor parametrico estreito.

2. **"Just another" determinante?**: A literatura de institutional design de OIs ja tem multiplas explicacoes para consensus: legitimacy (Franck), self-binding (Ikenberry), informal power (Steinberg), transaction costs (Koremenos et al.). O paper adiciona "informational power" a esta lista. A questao Edmans e: um survey paper dedicaria um paragrafo ou uma subsecao a este resultado? Provavelmente uma subsecao, dado o mecanismo novo --- mas nao e claro que mudaria a narrativa dominante da area.

3. **Um policymaker mudaria decisoes?** Improvavel. O resultado e mais uma *explicacao* (por que consenso existe) do que uma *prescricao* (adote/evite consenso). A predicao empirica discriminante --- correlacao negativa entre consensus e stakes distributivos transparentes --- e interessante mas nao testada.

4. **Binary types como "most conservative case"**: O paper argumenta (via extensao continua, App. C.4) que o caso binario e o mais conservador. Isso e persuasivo para a existencia do screening rent, mas a afirmacao de que alpha*_cont >= alpha* (verificada numericamente para Uniform) nao e um resultado analitico geral. Para outras distribuicoes, nao se sabe.

### Adequacao ao escopo [Adequada]

A bibliografia e predominantemente de CP/RI: Baron & Ferejohn, Kalandrakis, Eraslan & Evdokimov (legislative bargaining); Koremenos et al., Steinberg, Keohane, Ikenberry (institutional design); Gould (consensus rules); Fearon (rationalist IR). A teoria de Bayesian Persuasion (Kamenica & Gentzkow) vem de Economics, mas e bem integrada como ferramenta tecnica.

O paper seria de interesse para a audiencia de JoP? Sim: o puzzle e central a RI (por que hegemons aceitam consensus?), o modelo usa ferramentas standard de formal political theory (Baron-Ferejohn), e o resultado fala a debates ativos na disciplina (Gould 2022 e recente). O paper estaria confortavel no JoP, AJPS ou IO.

Uma preocupacao menor: a literartura de trade negotiations (Jawara & Kwa, Jones et al., Blackhurst et al.) e invocada para motivar a assimetria informacional, mas esses trabalhos nao sao de teoria formal. A conexao empirica permanece ilustrativa, nao sistematica.

### Generalizabilidade [Adequada]

O mecanismo e formalmente geral: qualquer ambiente com (i) ator privadamente informado, (ii) veto power, (iii) screening problem existe. O paper nao depende de WTO-specific features.

Porem, a generalizabilidade quantitativa e limitada:
- O caso binario (K=2) tem alpha* em closed form; K>2 e qualitativo mas sem threshold geral.
- A extensao continua (C.4) e apenas para Uniform; outras distribuicoes sao "open".
- A estrutura de 2 rounds BF e especifica; T>2 nao e explorado.
- Entry all-or-nothing e uma simplificacao forte que suprime dinamicas importantes (free-riding, sequential accession).

O paper faz um bom trabalho na secao de Scope discutindo estas limitacoes. A honestidade sobre "most favorable case for the result" (K=2) no corpo vs. "most conservative case" (na conclusao, baseado em C.4) cria uma leve tensao que precisa ser resolvida.

### Trade-offs [Parcial]

O paper documenta claramente que unanimidade redistribui de fracos para o hegemon (Remark 3: "never Pareto-improving conditional on entry"). O paragrado sobre "why would weak states participate" e bem argumentado: weak states participam porque a alternativa e nenhuma instituicao, nao maioria.

O que esta menos desenvolvido:

1. **Welfare**: O paper e puramente distributivo (quem ganha mais). Nao ha analise de welfare agregado. Unanimidade pode causar surplus destruction (discounting quando theta=1 rejeita em R1), que e mencionado no budget check (A.6) mas nao discutido substantivamente. Quanto surplus se perde? Quando a destruicao de surplus supera o ganho distributivo?

2. **Custo de unanimidade para o sistema**: Se unanimidade beneficia o hegemon mas prejudica fracos e pode destruir surplus, ha um custo social que nao e quantificado. Um editor poderia perguntar: "unanimidade e eficiente?" A resposta parece ser "nao necessariamente", mas o paper nao engaja com isso.

3. **Alternativas ao binario M vs. U**: O paper compara apenas maioria simples vs. unanimidade. Regras intermediarias (supermaioria, quorum qualificado) nao sao discutidas. Um editor poderia perguntar se o mecanismo e monotono na supermaioria ou se ha um interior optimum.

### Hipoteses [Claras e direcionais]

O paper tem hipoteses claras, direcionais e derivadas do modelo:

1. **H prefere U condicionalmente a entrada** (Theorem 1): condicao necessaria e suficiente (alpha < alpha*).
2. **M domina apenas via entry** (Proposition 4): triparticao limpa do espaco de priors.
3. **Screening cutoff independente de alpha** (Proposition 2): resultado preciso e testavel.
4. **Predicao empirica discriminante**: correlacao negativa entre consensus e transparencia distributiva.

As hipoteses sao "fortes" no sentido de Edmans: derivadas de teoria, direcionais, com condicoes de contorno explicitas. Nao ha kitchen-sink.

---

## Veredicto geral sobre contribution

O paper tem uma contribuicao genuina e original: identificar que unanimidade pode ser uma tecnologia de poder informacional, nao uma concessao. O mecanismo (screening via pivotal inclusion) e novo, a formalizacao e limpa, e o resultado principal (Theorem 1 como bicondicional) e elegante. Isso o coloca acima da maioria dos papers de formal theory em CP/RI.

A principal fragilidade e quantitativa: o resultado de dominancia global (alpha < alpha*) e exigente para organizacoes grandes (alpha* -> 0 com N). O paper atenua isso com o Remark 1 (mu_bar estavel) e a extensao continua (alpha*_cont >= alpha*), mas a questao permanece: para a aplicacao motivadora (WTO, N=164), o mecanismo opera num corredor parametrico estreito. Isso nao invalida a contribuicao --- o mecanismo e teoricamente claro --- mas limita a importancia pratica.

Um segundo ponto e a diferenciacao insuficiente com Bardhi & Guo e Kim, Kim & Van Weelden. O paper menciona esses trabalhos na introducao mas dedica apenas uma frase a cada. Um editor de JoP ou AJPS pediria 2-3 paragrafos explicando por que este paper nao e uma extensao ou recombinacao desses resultados.

O score de 7.0 reflete: Novidade forte (o ativo principal), Hipoteses claras, Adequacao ao escopo, mas Importancia apenas adequada (corredor parametrico estreito para N grande, predicoes nao testadas) e Trade-offs parciais (sem welfare, sem supermaioria).

---

## Sugestoes construtivas

1. **Confrontar o problema de N grande mais diretamente**. O paper ja reconhece que alpha* diminui com N, mas poderia fortalecer a contribuicao mostrando que: (a) para organizacoes de tamanho moderado (N=5 a 30, tipo Quad, G7, G20, Conselho de Seguranca), alpha* e generoso; (b) para WTO-size, o mecanismo ainda opera numa faixa substantiva de beliefs (via mu_bar). Um paragrafo que mapeie alpha* para tipos concretos de organizacoes (pequenas, medias, grandes) tornaria o resultado mais tangivel.

2. **Expandir a diferenciacao com Bardhi & Guo e Kim-Kim-Van Weelden**. Esses sao os papers mais proximos. Dedique 2-3 paragrafos (nao 1 frase) explicando: (a) o que cada um faz, (b) o que *nao* faz que este paper faz, (c) por que a combinacao aqui nao e trivial. Isso e essencial para um referee que conheca essa literatura.

3. **Discutir welfare brevemente**. Adicione um paragrafo na Discussion ou Scope sobre eficiencia: unanimidade pode destruir surplus (via discounting em R1), entao o ganho distributivo do hegemon vem parcialmente a custa de eficiencia. Quantifique o surplus destruction para os parametros do Example 2. Isso mostra consciencia dos trade-offs e previne criticas de "one-sided analysis".

4. **Considerar supermaioria**. Ao menos um paragrafo discutindo se o mecanismo e monotono na supermaioria (i.e., se aumentar q de maioria simples ate unanimidade monotonicamente aumenta o screening rent). Se sim, isso fortalece a contribuicao; se nao, e informativo. Nao precisa ser formal --- uma conjectura fundamentada basta.

5. **Fortalecer a predicao empirica**. A predicao "correlacao negativa entre consensus e transparencia distributiva" e discriminante mas vaga. Operacionalize: que proxy para "transparencia distributiva"? Como distinguir esta predicao da de Koremenos et al. (que predizem unanimidade onde enforcement e fragil)? Uma tabela com 5-6 OIs, suas voting rules, e uma classificacao rough de transparencia das stakes fortaleceria muito.

6. **Resolver a tensao "most favorable" vs. "most conservative"**. O corpo (Scope) diz que K=2 e o "most favorable case for the result"; a conclusao diz que e o "most conservative case for the mechanism" (baseado em C.4). Ambos podem ser verdadeiros sob interpretacoes diferentes, mas um leitor desatento vera contradicao. Clarifique: K=2 e o caso mais conservador para a *existencia* do screening rent (que sempre existe), mas pode ser o mais favoravel para a *dominancia global* (alpha* pode ser menor com K>2 fora de Uniform). Essa distincao precisa ser explicita.

7. **Nota sobre mecanismo de escolha da voting rule**. O paper assume que H escolhe R unilateralmente. Na pratica, a escolha de voting rule e ela mesma negociada. Um paragrafo reconhecendo que a preferencia revelada de H por unanimidade pode nao se traduzir em unanimidade realizada (porque W prefere maioria) fortaleceria a honestidade do argumento. O paper ja toca nisso (Remark 3), mas poderia ser mais explicito.

---

## Parecer completo -- Execution

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

---

## Parecer completo -- Exposition

# Parecer de Exposition (Framework Edmans) -- v5 Round 2

**Manuscrito**: "Informational Power and Institutional Design: When a Hegemon May Choose Consensus"
**Arquivo**: `formal_model_v5.Rmd`
**Data**: 2026-04-27
**Framework**: Edmans (2025), "Learnings From 1,000 Rejections" -- dimensao Exposition, adaptado para CP
**Avaliador**: Editor simulado, top journal CP (JoP/AJPS/IO/BJPS)

---

## Score: 7.5 / 10

---

## Avaliacao por dimensao

### Clareza [Boa]

#### Qualidade da escrita

A escrita e limpa e profissional ao nivel da frase. Nao identifiquei typos ou erros gramaticais no corpo do texto. A prosa flui bem e as transicoes entre secoes sao suaves. O uso de em-dashes e eficaz para inserir qualificacoes sem quebrar o fluxo. As equacoes sao numeradas sistematicamente e as cross-references (Theorem, Proposition, Remark) sao consistentes internamente.

**Problemas especificos**:

1. **Repeticao no paragrafo pos-Proposition 1** (l.285-287). O paragrafo contem duas formulacoes quase identicas em sequencia: "Because the hegemon's vote is never needed, weak states never face a choice between offers that depend on inferring the hegemon's type" e, duas frases depois, "The hegemon's private information affects the value of the agreement but creates no strategic discontinuity and no screening rent." A segunda frase adiciona apenas "and no screening rent" ao que ja foi dito. Dentro de um paragrafo de 5 linhas, essa repeticao sinaliza uma revisao que nao foi totalmente polida.

2. **Frase longa na intro** (l.57). O segundo paragrafo de contribuicao contem uma frase de ~117 palavras que comeca "The central difference is that the two rules reward this informational advantage differently" e termina com "majority's only advantage is wider institutional viability." Embora gramaticalmente correta, a frase forca o leitor a manter muitas clausulas na memoria de trabalho. Quebrar em 2-3 frases melhoraria a legibilidade.

3. **Paragrafo de justificativa do BF 2-round** (l.101). Este paragrafo de ~140 palavras defende a escolha de modelagem de 2 rounds. Sua localizacao -- entre a Definition 1 e a descricao dos Stages -- interrompe o fluxo do modelo. Deveria ser uma nota de rodape ou estar no Scope (Secao 8.2).

4. **"Screening rent" vs. "screening jump"**. O texto usa ambos os termos como quase-sinonimos, mas eles se referem a conceitos distintos: "jump" e a descontinuidade na funcao de payoff; "rent" e o excedente capturado. A Figure 3 usa "Screening rent" como label da seta de anotacao, o que e preciso, mas o corpo as vezes os intercala sem distinguir (e.g., l.323: "screening rent" como sinonimo do jump).

#### Significancia substantiva

**Pontos fortes**: O paper fornece numeros concretos e memoraveis em varios momentos criticos:
- Example 2 (l.377): "27% more than majority on the aggressive branch and 41% more on the conservative branch" -- excelente ancora quantitativa.
- Alpha-star (l.426): "$\alpha^* \approx 0.47$ when $N = 5$ but falls to $\approx 0.03$ when $N = 164$" -- comunica o scope condition de forma imediata e memoravel.
- Example 3 (l.483): "at $p = 0.50$, the hegemon's payoff under unanimity exceeds majority by 25%" -- concreto.
- Remark 1 (l.433): "increasing $\alpha$ from $0.05$ to $0.49$ (an 18-fold increase beyond $\alpha^*$) only lowers $\bar\mu$ from $0.87$ to $0.71$" -- forma forte de comunicar robustez.

**Problema principal**: O abstract NAO contem nenhum numero. A frase chave -- "weaker states pay more than necessary to secure agreement" -- e precisa mas generica. Todo paper sobre screening ou informacao assimetrica em barganha diz algo equivalente. O que torna este paper distinto e que o *voting rule* e que ativa ou desativa o screening, e o *quanto* importa. Para um reviewer que le 20 abstracts por semana, um numero concreto faria diferenca substancial. Sugestao: adicionar "In calibrated examples, the screening mechanism gives the hegemon 27--41% higher payoffs than majority rule."

#### Precisao da linguagem

**Pontos fortes**:
- A linguagem e geralmente precisa. Afirmacoes como "unanimity dominates wherever it can sustain entry" sao claras e nao ambiguas.
- O autor distingue cuidadosamente entre dominancia condicional e dominancia total, o que e critico para o argumento.
- A qualificacao "The model does not claim that the GATT/WTO was designed for this reason" (l.580) e exatamente o tipo de hedging preciso que editores valorizam.

**Problemas**:

1. **"Informational power" nao e formalmente definido.** O titulo do paper usa o conceito, a intro usa repetidamente, mas nao ha uma definicao explicita em uma frase. A frase mais proxima de uma definicao e "By informational power I mean the bargaining advantage that a privately informed actor derives from being pivotal" (l.55), mas esta enterrada no meio de um paragrafo denso. Merece destaque -- italico, frase separada, ou tratamento formal.

2. **"Institutional technology of power"** (l.55). Frase memoravel mas vaga. O que e uma "technology of power"? O autor define indiretamente na frase seguinte, mas a frase de efeito precede a substancia, o que pode gerar ceticismo antes que o leitor entenda o mecanismo.

3. **"Promising enough"** (abstract, l.36; intro l.59). Vago. Comparar com a precisao de "at every level of uncertainty" na mesma frase do abstract. Poderia dizer "once the expected value of cooperation exceeds the unanimity entry threshold."

4. **Remark 4 (Information design), l.477**: Referencia a Kamenica & Gentzkow (2011) usando `[@kamenica2011bayesian]` dentro de um ambiente LaTeX. Precisa verificar se pandoc/bookdown resolve a citacao corretamente dentro de `\begin{remark}...\end{remark}`. Potencial citacao quebrada.

---

### Extensao [Adequado, com uma secao excessiva]

#### Introducao

A introducao tem ~4 paragrafos (l.49-59), estimada em ~1.5 paginas. Bem dentro do limite de 6 paginas.

**Estrutura**:
1. Puzzle (l.49) -- 1 paragrafo
2. Posicionamento na literatura (l.51) -- 1 paragrafo
3. Critica das respostas existentes (l.53) -- 1 paragrafo
4. Contribuicao e mecanismo (l.55-57) -- 2 paragrafos
5. Implicacao substantiva (l.59) -- 1 paragrafo

**Pontos fortes**:
- Nao ha paragrafo desperdicado dizendo "international institutions matter" ou "the design of IOs has been debated for decades." O autor assume que o leitor sabe por que isso importa e ataca o puzzle diretamente.
- A literatura e tratada antes da contribuicao, seguindo a estrutura recomendada por Edmans.
- O puzzle e formulado de forma incisiva: "Why would a powerful state ever prefer consensus over majority rule?"

**Problemas**:
1. **Dois paragrafos de literature gap (l.51 e l.53) onde um bastaria.** O l.51 apresenta a tensao (bargaining theory vs. IOs); o l.53 critica respostas existentes (self-binding vs. informal power). Ambos fazem o mesmo trabalho -- posicionar o paper contra a literatura. Fundindo-os em um unico paragrafo de 6-8 linhas, a intro ganha meia pagina e o leitor chega a contribuicao mais rapido.

2. **Ausencia de road map.** A intro nao menciona os resultados formais por nome (Theorem 1, Proposition) nem antecipa a estrutura do paper. Isso e aceitavel em CP (diferente de economia), mas um "road map" de uma frase no fim da intro ajudaria o leitor. O Motivating Example (Secao 2) termina com um paragrafo de preview (l.81), mas a intro nao tem equivalente.

3. **Ausencia do scope condition na intro.** O resultado principal tem uma condicao parametrica critica ($\alpha < \alpha^*$) que nao e mencionada na intro. Um reviewer atento perguntara imediatamente "em que condicoes?" A versao mais forte da intro incluiria: "The result holds when the hegemon's bilateral alternatives are moderate relative to multilateral cooperation -- a condition easily satisfied in small organizations but demanding in large ones."

#### Motivating Example (Secao 2)

**Ponto forte**: O exemplo e pedagogicamente eficaz. Usa N=3, um round, e numeros simples (alpha=0.2, r=2, cutoff 1/9). O leitor entende o mecanismo antes de ver notacao pesada. A transicao para o modelo geral (l.81) e bem feita.

**Problema menor**: O paragrafo final do exemplo (l.81) e um preview do modelo geral que lista resultados formais (Theorem, Proposition). Isso e ligeiramente redundante com a intro e com o inicio das secoes subsequentes. Poderia ser encurtado para 2 frases.

#### Discussion/GATT (Secao 8.1)

**Problema principal de extensao**. A secao de GATT/WTO (l.572-584) e a secao mais longa do corpo do paper, ocupando estimadamente 2-2.5 paginas em 4 paragrafos longos. Para um paper teorico, isso e desproporcional -- a Discussion nao deveria ser mais longa que a secao de resultados.

Problemas especificos:

1. **Mega-paragrafo de previsao discriminante** (l.582). Um unico paragrafo de ~300 palavras que tenta fazer 5 coisas: (a) gerar a previsao (negative association consensus/transparent stakes); (b) dar exemplos (financial institutions vs. regulatory bodies); (c) distinguir de alternativas (legitimacy, self-binding, informal power); (d) apontar dados existentes (Gould 2022); (e) sugerir testes futuros. Isso deveria ser 2-3 paragrafos mais curtos.

2. **Redundancia entre l.582 e l.584.** O paragrafo l.584 distingue o mecanismo informacional de alternativas -- tarefa identica a que l.582 ja faz parcialmente. A frase "Legitimacy accounts predict consensus where binding obligations require broad-based assent" aparece como pensamento original em l.584, mas o ponto ja foi implicado em l.582.

3. **Paragrafo de capacity asymmetry** (l.576). Informativo mas nao essencial. Poderia ser reduzido a 2 frases: "The model's information asymmetry assumption finds support in the WTO context, where major powers maintain large delegations with deep sectoral expertise while many developing country delegations operate with far smaller teams (Jawara & Kwa 2003; Jones et al. 2010; Blackhurst et al. 2000)."

4. **Repeticao com a intro.** A frase "informational power becomes most valuable" (l.580) repete quase verbatim a implicacao substantiva da intro (l.59).

**Sugestao**: Cortar a Discussion/GATT de ~2.5 para ~1.5 paginas. Comprimir capacity asymmetry a 2 frases; separar o mega-paragrafo de previsao em dois; eliminar repeticao com l.584.

#### Scope (Secao 8.2)

**Ponto forte**: Bem estruturada com perguntas em bold seguidas de respostas concisas. Informativa sem ser excessiva.

**Problema menor**: Ha redundancia entre Scope e o corpo principal. O ponto sobre "When majority dominates" (l.598) repete informacao ja coberta na Proposition 4 e no Example 3 (l.480-484). Poderia ser encurtado. Igualmente, o ponto sobre "Why simultaneous entry?" (l.592) repete a justificativa da footnote no l.107.

#### Notas de rodape

Contagem: 9 footnotes no corpo (l.92 x2, l.95, l.107, l.113, l.303, l.377, l.385, l.582) + 1 no appendix (l.828). Para um paper de ~20 paginas de corpo, ~0.5/pagina -- bem dentro do aceitavel.

**Problema**: Varias footnotes sao excessivamente longas:

- **Footnote l.95** (consensus vs unanimity equivalence): ~5 linhas. Este e um ponto substantivo que ja aparece no corpo (l.66-67, "I model consensus as unanimity..."). A footnote repete e expande. Deveria ser absorvida no texto do corpo ou encurtada.

- **Footnote l.107** (all-or-nothing entry): ~5 linhas. Justifica uma escolha de modelagem que TAMBEM e discutida no Scope (l.592, "Why simultaneous entry?"). Redundante.

- **Footnote l.385** (entry cost interpretation e scaling com N): ~6 linhas. Trata de um ponto tecnico importante (scaling O(1/N)) que deveria estar no appendix ou no Scope, nao em uma footnote no corpo.

- **Footnote l.303** (alpha >= alpha_bar regime): ~5 linhas. Discute um caso tecnico alternativo e ja referencia o appendix. Deveria estar inteiramente no appendix.

**Regra pratica**: Se uma footnote tem mais de 3 linhas, provavelmente nao e footnote -- e ou texto do corpo ou material de appendix.

#### Extensoes

- **Appendix C (K>2 types)**: Extensao genuina que endereça preocupacao real (robustez a tipos binarios). Bem calibrada. O C.4 (continuous types) e particularmente valioso.

- **Remark 4 (Information design, l.476-478)**: Vestigio da arquitetura anterior onde BP era central. E curto (1 paragrafo) e faz um ponto relevante, mas sua colocacao -- entre o Corollary e a Proposition de classificacao -- interrompe o climax argumentativo do paper. Ficaria melhor na Discussion ou como footnote.

---

### Citacoes [Precisas]

A bibliografia tem 16 citacoes unicas no texto (de 19 entradas no .bib). Para um paper teorico de CP/RI, e enxuto e apropriado.

#### Analise das citacoes

**Citacoes bem colocadas**:
- Baron & Ferejohn (1989), Kalandrakis (2006), Eraslan & Evdokimov (2019): baseline de barganha legislativa. Essenciais para o modelo.
- Kamenica & Gentzkow (2011): referencia de BP no Remark 4. Precisa e minimal.
- Steinberg (2002), Koremenos et al. (2001), Keohane (1984), Ikenberry (2001): posicionamento na literatura de design institucional. Necessarias.
- Gould (2022): dado empirico sobre prevalencia de consensus. Sem este paper, a afirmacao empirica central nao teria fonte.
- Jawara & Kwa (2003), Jones et al. (2010), Blackhurst et al. (2000): evidencia de capacity asymmetry na WTO. Adequadas para substanciar o assumption de assimetria informacional.

**Possiveis problemas**:

1. **Fearon (1995)** (l.584): citado como "cf. @fearon1995rationalist" para invocar o "rationalist framework common to all of them." Fearon (1995) e sobre explicacoes racionalistas para *guerra*, nao para design institucional. O uso e para invocar um framework geral, o que e um stretch. O paper de Fearon nao contribui substancialmente para o argumento aqui. Nao e mis-citacao, mas e uso frouxo.

2. **Bhagwati (2008)** (l.584): citado sobre PTAs e outside options. A citacao e precisa mas a frase e uma observacao lateral. Poderia ser removida sem perda.

**Teste contrafactual**: Todas as 16 citacoes passam o teste "se o paper citado nao existisse, o manuscrito poderia fazer a mesma afirmacao?" com duas excecoes:
- Gould (2022): necessaria para a afirmacao empirica sobre prevalencia de consensus.
- Baron & Ferejohn (1989): necessaria como baseline do modelo.

As demais citacoes na intro sao de posicionamento -- removiveis individualmente, mas coletivamente necessarias para situar o paper.

**Nao ha**:
- Citacoes por metodo padrao (nao aplicavel a paper teorico).
- Citacoes por fatos institucionais que eram conhecidos antes do paper citado.
- Citacoes estrategicas inflando relevancia conectando a literaturas nao relacionadas.
- Bibliografia excessiva (16 citacoes e parcimonioso).

**Nota sobre o .bib**: O .bib tem 19 entradas, mas o texto cita 16. As 3 entradas orfas devem ser identificadas e removidas antes da submissao.

---

## Veredicto geral sobre exposition

O manuscrito tem exposicao globalmente boa. A introducao e eficiente e bem estruturada; o motivating example e pedagogicamente forte e resolve o dilema de acessibilidade vs. rigor de forma elegante; os resultados formais sao apresentados em sequencia logica com prosa conectiva adequada; e as citacoes sao parcimoniosas e precisas. Os dois problemas principais sao: (1) a Discussion/GATT e desproporcionalmente longa para um paper teorico, com redundancias internas e repeticao de pontos ja feitos no corpo, e deveria ser cortada em ~40%; (2) o abstract e preciso mas carece de um numero memoravel -- o leitor termina o abstract sabendo *que* unanimidade pode dominar, mas nao *quanto*, o que reduz o impacto de primeira impressao em um journal de alta competicao. Problemas secundarios incluem footnotes longas na Definition 1 que deveriam ser absorvidas no texto ou movidas ao appendix; a falta de definicao formal do conceito titular "informational power"; e o Remark sobre information design que interrompe o climax argumentativo entre o Corollary e a Proposition de classificacao. Nenhum desses problemas obscurece a contribuicao ou impede a avaliacao da execucao tecnica. Sao problemas de polimento final que podem ser resolvidos em uma revisao editorial de um dia.

---

## Top 5 sugestoes de melhoria

1. **Adicionar um numero concreto ao abstract.** A frase "weaker states pay more than necessary" deveria ser acompanhada de uma magnitude. Sugestao de reescrita: "In calibrated examples, the screening mechanism gives the hegemon 27--41% higher payoffs than under majority rule." Isso torna o abstract memoravel e distingue o paper de claims genericas sobre informational advantage. E a mudanca de maior impacto para primeira impressao.

2. **Comprimir a Discussion/GATT de ~2.5 para ~1.5 paginas.** Acoes concretas: (a) reduzir o paragrafo de capacity asymmetry (l.576) a 2 frases; (b) separar o mega-paragrafo de discriminating prediction (l.582) em dois paragrafos mais curtos -- um para a previsao, outro para a distincao de mecanismos alternativos; (c) eliminar a redundancia entre l.582 e l.584, que repetem a distincao de legitimacy/self-binding/informal power; (d) cortar a repeticao com a intro ("informational power becomes most valuable").

3. **Definir "informational power" explicitamente na intro.** O conceito titular do paper deveria ter uma definicao clara e destacada. Sugestao: abrir o paragrafo de contribuicao (l.55) com "I define *informational power* as the bargaining advantage a privately informed actor derives from being pivotal under uncertainty: when other players must secure its approval without knowing its type, uncertainty itself becomes a source of rent." A frase ja existe quase verbatim no texto -- so precisa ser destacada com italico e posicionada como definicao explicita.

4. **Reduzir ou realocar as 4 footnotes longas no corpo.** (a) Absorver a footnote sobre consensus=unanimity (l.95) no paragrafo do corpo em l.66-67, onde o ponto ja e feito informalmente; (b) eliminar a footnote sobre all-or-nothing entry (l.107), que e redundante com o Scope (l.592); (c) mover as footnotes tecnicas sobre alpha_bar (l.303) e scaling com N (l.385) para o appendix. Regra: footnotes com mais de 3 linhas devem virar texto principal ou material de appendix.

5. **Mover o Remark 4 (Information design) para a Discussion ou para uma footnote.** Sua localizacao atual -- entre o Corollary (resultado principal) e a Proposition de classificacao (resultado de fechamento) -- interrompe o climax argumentativo do paper. O ponto e valioso mas nao e necessario para o argumento central; ficaria naturalmente na Discussion (Secao 8) como observacao sobre por que o mecanismo e relevante para a literatura de information design.

---

## Observacoes adicionais (menores)

- **Data no YAML**: `date: "\`r Sys.Date()\`"` gera data dinamica. Fixar para submissao.
- **Road map ausente na intro**: Adicionar uma frase final na intro com a estrutura do paper.
- **Scope condition ausente na intro**: O resultado principal tem a condicao $\alpha < \alpha^*$. Mencionar na intro para antecipar perguntas de scope.
- **Appendix C.2 "Claim" sem prova**: O Claim sobre screening boundaries para K geral (l.1052) nao tem prova formal. Rotular explicitamente como "Claim (proof omitted)" ou adicionar uma prova breve.
- **Paragrafo sobre preferencia de W** (l.456): Poderia ser encurtado para 3 frases.
- **3 entradas orfas no .bib**: Identificar e remover antes da submissao.
