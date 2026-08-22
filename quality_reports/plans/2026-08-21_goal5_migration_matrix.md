# Goal 5 — matriz de migração para `formal_model_v6.Rmd`

**Data:** 2026-08-21; revisão autoral incorporada em 2026-08-22
**Status:** `APPROVED — AUTOR, 2026-08-22`
**Hash da DRAFT aprovada:**
`6a8aabb60ad5148017297b1cf5360b7f138eed9cf8a373f4655e7e4bfa321360`
**Decisão autoral:**
`quality_reports/2026-08-22_aprovacao_matriz_goal5.md`.
**Efeito até a aprovação:** planejamento apenas; `formal_model_v6.Rmd` não
havia sido editado nem compilado. A aprovação autoriza a sequência da Seção 10
a partir do item 2.
**Snapshot de origem:**
`e0ff1aceb3d8b9ebeeea56feb65c019dafd32854`
**Tag de fronteira:** `pre-goal5-essential-input-2026-08-21`, anotada e
apontando, após peeling, para o snapshot de origem.
**Worktree:** `/private/tmp/PowerBayesianPersuasion-goal5-migration`
**Branch:** `codex/essential-input-goal5-migration-matrix`
**Figuras incorporadas:** merge local `76bb98a66dff1369215106333cf789774d49351e`
da branch `codex/essential-input-figures-narrative`, após o Round 4 cosmético.
**Autorização literal:**
`quality_reports/2026-08-21_autorizacao_goal5.md`.

## 1. Decisão editorial proposta

Manter `formal_model_v6.Rmd` significa preservar o alvo e seu histórico Git,
não preservar a arquitetura formal que hoje ocupa o arquivo. O v6 corrente
ainda resolve um jogo de opt-out imediato que foi expressamente descartado.
Por isso, a migração será uma substituição controlada da arquitetura
substantiva dentro do mesmo arquivo, preservando apenas a infraestrutura
editorial útil: YAML/bookdown, estilo tipográfico, organização com provas no
apêndice e a intuição geral que continue verdadeira sob o jogo congelado.

Há três ordens editoriais distintas:

1. **Abstract:** puzzle; abordagem; mecanismo; achado principal; escopo e
   implicação.
2. **Introdução:** hook OPEC/OMC; puzzle em três camadas; benchmark de
   informação completa imediatamente depois do puzzle; mecanismo e resultados;
   contribuição; roadmap.
3. **Resultados:** benchmark público; jogos privados; renda informacional por
   regra e diferença das diferenças; interpretação, limites e implicações.

O benchmark público, portanto, entra cedo na introdução e abre a seção de
resultados, mas não abre o abstract. O título corrente, **Informational Power
Through Pivotality: How Consensus Can Benefit a Hegemon**, será preservado. No
primeiro uso, uma nota de rodapé equipara *consensus* e *unanimity* para os fins
do modelo, sem abrir uma discussão terminológica.

O corpo usa `m>=3`, equivalente a `N>=4`, e somente PBE com estratégias puras
nos ballots. Um remark de escopo esclarecerá que a inexistência demonstrada não
é uma afirmação sobre equilíbrios mistos; o paper não os deriva, caracteriza,
compara nem os inclui em agenda futura.

## 2. Fontes congeladas e rastreabilidade

| Nó | Objeto migrado | Interface congelada SHA-256 |
|---|---|---|
| `N1` | R2 sob maioria | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| `N2` | R2 sob unanimidade; lido com a Emenda 1a/errata de suporte | `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` |
| `N3` | correspondência completa de R1 sob maioria | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| `N4` | correspondência de R1 sob unanimidade e célula sem PBE puro | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| `N6` | comparação dos dois jogos privados, inclusive vazios e multiplicidade | `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92` |
| `N7` | quatro jogos públicos, `RI_M`, `RI_U`, `DeltaRI`, envelopes e imagens ex ante | `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` |

As interfaces acima são somente leitura. Nenhuma fórmula do v6 corrente é
fonte para a nova matemática.

## 3. Decisões autorais ainda pendentes

As primitivas matemáticas abaixo já estão congeladas. O que permanece pendente
é a **interpretação e o lugar editorial** das passagens correspondentes.

| Marcador | Passagem que dependerá da decisão | Tratamento enquanto pendente |
|---|---|---|
| `[AUTHOR: P1]` | Interpretação do timing de `o_theta`: é payoff de desacordo terminal; um voto `não` não o dispara. Se a proposta falha em R1, ninguém recebe `o_theta` naquela data e o jogo continua. A fórmula geral `y+o_theta` aplica-se somente à história — em geral fora do caminho — na qual foi proposto `y>0`, `H` votou `não` e a maioria aprovou apesar disso. Nos equilíbrios de exclusão congelados, o proponente escolhe `y=0`; portanto, `H` recebe apenas `o_theta`. | No texto de resultados, reportar somente o payoff de equilíbrio `o_theta`. Manter a fórmula geral na definição completa de payoffs e, quando necessária, na prova de incentivos fora do caminho. Marcar apenas a frase substantiva que explica por que esse relógio representa negociações internacionais. Explicitar que `beta` converte em R1 apenas payoffs realizados em R2. |
| `[AUTHOR: P2]` | Interpretação de `b_theta=0`: o payoff de acordo de `H` é `y+b_theta`; no baseline, portanto, um `H` incluído recebe somente `y`. O tipo altera o payoff de desacordo `o_theta`, não o valor intrínseco do acordo. | Declarar a normalização; marcar a justificativa de que ela isola concessões informacionais e poder de pivotalidade, sem sugerir que acordos reais não tenham benefícios intrínsecos. |
| `[AUTHOR: P3]` | Janela ex ante: imagem pelo prior dos vetores de renda e de `DeltaRI`. | Planejar como `remark` e faceta de F1, nunca proposição. A redação e a figura não entram no manuscrito até a decisão. |

## 4. Mapa de seções do v6 corrente

As ações possíveis são exatamente: **permanece**, **reescrito**, **removido** e
**substituído**. “Substituído” significa que outro objeto ocupa a função
editorial do bloco; “reescrito” significa que a função permanece, mas todo
conteúdo é reconciliado com as fontes congeladas.

| Bloco atual do v6 | Ação | Destino no manuscrito migrado | Fonte congelada / observação |
|---|---|---|---|
| YAML, bookdown, tipografia e metadados | **permanece** | Manter `bookdown::pdf_document2`, XeLaTeX, estrutura de referências e o título corrente. Acrescentar às keywords *unanimity rule*, *legislative bargaining* e *private information*. | Infraestrutura editorial, sem claim formal. |
| Abstract | **reescrito** | Ordem obrigatória: puzzle; abordagem; mecanismo; achado principal; escopo e implicação. O benchmark público disciplina o achado, mas não abre o abstract. A inexistência em estratégias puras aparece como delimitação de escopo, nunca como resultado de abertura ou como “instabilidade” já estabelecida. | `N6`, `N7`; hashes acima; arquitetura autoral de 2026-08-22. |
| Chunk `setup` e leitura de `clean_optout_gate0_histories_piH0.tsv` | **substituído** | Remover a dependência da tabela de opt-out; carregar apenas scripts/dados permanentes das figuras e tabelas essential-input. | Contrato; gerador de figuras; nenhum resultado novo. |
| `Introduction` | **reescrito** | Preservar o hook OPEC/OMC, o puzzle em três camadas e o roadmap. Inserir o benchmark de informação completa imediatamente depois do puzzle; então apresentar o mecanismo de insumo essencial versus substitutos não informados, os resultados qualificados por tipo e região, a literatura vizinha com crédito integral e a contribuição estreita. No primeiro uso no texto, uma nota equipara *consensus* e *unanimity* para os fins da análise. | `N6`, `N7`, honest assessment v2/adendo; `[AUTHOR: P1]`, `[AUTHOR: P2]` apenas nas interpretações. |
| `Consensus, Information, and Institutional Design` | **reescrito** | Creditar integralmente Piazolo–Vanberg e Glynia–Thum–Xefteris; posicionar Miller et al. como benchmark; distinguir Feddersen–Pesendorfer; apresentar a novidade estreita do paper. | Honest assessment; bibliografia auditada na Seção 9 desta matriz. |
| `A Motivating Terminal Example` com três jogadores | **substituído** | Exemplo motivador com `N=5` (`m=4`), usando o cutoff terminal de N2 e as primitivas correntes. Linguagem de “working numerical illustration”, não calibração. | `N2`; `c6a65d...a85a2`. |
| `The Model` | **reescrito** | Modelo em cerca de uma página: dois rounds, só fracos propõem, ballots simultâneos, nenhuma saída, pie fixa, `0<o_0<o_1<1`, `beta in (0,1)`, `m>=3`, `b_theta=0`, `pi_H=0`. | Contrato Seções 2, 4 e 6; `[AUTHOR: P1]`, `[AUTHOR: P2]`. |
| Definição `Clean immediate-opt-out game` | **substituído** | Definição do jogo essential-input; excluir todo opt-out, weak-only state, entry e `beta=1`. | Contrato; interfaces `N1`–`N4`. |
| Figura atual de timing com ramo de opt-out | **substituído** | Figura de sequência do jogo; omitir a árvore trivial de Natureza/formação e mostrar apenas proposta, ballot simultâneo, publicação, aprovação ou continuação a R2. | Contrato Seção 4; sem classes internas de nós. |
| Definição `Weak-vote-passive assessment` | **substituído** | Seção concisa do conceito: no-signaling + consistência estrutural; as-if-pivotal; `T^Y` em valor esperado; tie-break anti-`H`; suporte inicial nos endpoints. | Decisão de 2026-08-21 + Emenda 1a. |
| IC de R1 construída contra opt-out imediato | **substituído** | IC por ramos do jogo sem saída, incluindo passagem não pivotal sem `H`, continuação e aplicação única de `beta`. | `N3`, `N4`; hashes acima. |
| Domínio “regular” que admite `beta=1`, `N=3` e fronteiras separadas | **substituído** | Um único domínio declarado: `m>=3`, `beta in (0,1)`, `0<o_0<o_1<1`; prior em `[0,1]` com suporte preservado nos endpoints. | Contrato + Emenda 1a. |
| Tabela `Scope of the clean baseline results` | **substituído** | Tabela curta de escopo dos resultados congelados: público, privado, inexistência, renda e multiplicidade. | `N1`–`N7`. |
| `Backward Induction` | **reescrito** | Substituir por `Results`: benchmark público primeiro; depois indução retroativa dos jogos privados — terminais, R1 maioria e R1 unanimidade —; por fim rendas. Intuição sempre antes do enunciado formal. | `N1`–`N4`, `N7`. |
| `Terminal Round` | **reescrito** | Maioria primeiro como benchmark belief-free; unanimidade com low-only/pooling e cutoff `nu_star`; exemplo `N=5`. | `N1`, `N2`. |
| `Round 1 Under Unanimity` atual | **substituído** | Correspondência de três células: acordo low-only em `nu=0`; nenhum PBE puro em `0<nu<=nu_star`; pooling em `nu>nu_star`. O remark sobre mistos vem imediatamente depois da proposition de inexistência. | `N4`; `f1c823...6408b`. |
| `Round 1 Under Majority` atual | **substituído** | Correspondência completa com exclusão, screening com atraso do tipo alto e pooling; domínio `m>=3`; quociente apenas por permutações de fracos. | `N3`; `ff0537...330d`. |
| `Entry and Conditional Institutional Comparison` | **removido** | Entry/formation não integra o jogo corrente nem o estimando. Sua função comparativa passa a N6/N7. | Contrato Seções 1, 2 e 10. |
| `Discussion` | **reescrito** | Interpretar substituição/essencialidade, região sem PBE puro, descontinuidade em `nu=0+`, escopo e implicações de policy. Instabilidade sob declínio contestado: qualitativa, análoga a ciclos de Edgeworth, nunca teorema. | `N4`, `N6`, `N7`; guardrail autoral. |
| `OPEC and pivotal participation` | **reescrito** | Manter OPEC apenas como aplicação motivadora; substituir “opt-out” por payoff de desacordo terminal; toda quantificação será “working numerical illustration”. | Primitivas correntes; `[AUTHOR: P1]`, `[AUTHOR: P2]`. |
| `Observable implications and neighboring mechanisms` | **reescrito** | Resultados observáveis derivados dos objetos congelados; reconhecer mistura/refinamentos de Piazolo–Vanberg apenas como comparação de conceito, sem analisar equilíbrios mistos do nosso jogo. | `N3`–`N7`; literatura. |
| `Scope` | **reescrito** | Fixar `pi_H=0`, `b_theta=0`, pie unitária, tipos binários, `m>=3`, ballots simultâneos, regras exógenas, puro PBE e suporte nos endpoints. | Contrato + decisão de conceito. |
| `Conclusion` | **reescrito** | Responder à pergunta com a decomposição poder/informação; registrar onde a comparação é vazia; acrescentar implicações de policy sem transformar a instabilidade qualitativa em teorema. | `N6`, `N7`; `[AUTHOR: P3]` se usar a imagem ex ante. |
| `Appendix A: Protocol and Histories` | **substituído** | Protocolo essential-input, sistema de crenças e tabela única de transições/payoffs. Remover todas as histórias weak-only/opt-out. | Contrato Seções 4–6; decisão de conceito. |
| `Appendix B: Proofs of Regular Results` | **substituído** | Provas congeladas de N1–N4, com correspondência completa e certificado de inexistência; ordem indicada na Seção 6 desta matriz. | `N1`–`N4`. |
| `Appendix C: Boundaries and Endpoint Limits` | **substituído** | Endpoints exatos, descontinuidade em `nu=0+`, regiões de renda, envelopes e ilustração numérica corrente. Remover limites laterais da arquitetura antiga. | Emenda 1a, `N4`, `N7`. |
| `Appendix D: Notation` | **reescrito** | Dicionário apenas da arquitetura essential-input; remover símbolos de opt-out, entry e resultados antigos. | Contrato + `N1`–`N7`. |
| `References` | **permanece** | Manter seção; acrescentar apenas as entradas necessárias já identificadas e usar citações com a disciplina da autorização. | Ver Seção 9. |

### 4.1 Arquitetura do abstract

O abstract será escrito nesta sequência:

1. **Puzzle:** por que hegemons constroem e aceitam instituições por consenso,
   se a regra iguala formalmente os votos e não lhes concede agenda?
2. **Abordagem:** barganha em dois rounds; somente Estados fracos propõem; o
   hegemon conhece privadamente sua opção externa; maioria e unanimidade usam
   as mesmas primitivas.
3. **Mecanismo:** sob maioria, votos de fracos não informados substituem o voto
   do hegemon e limitam o preço pago a ele; sob unanimidade, o hegemon é insumo
   essencial e a proposta precisa satisfazer um limiar privado.
4. **Achado:** decompor a diferença entre regras em poder de veto sob
   informação completa e efeito adicional da informação privada. Reportar o
   resultado exato: quando a maioria privada faz screening, a unanimidade
   acrescenta renda ao tipo baixo e também ao tipo alto se a maioria pública o
   excluiria; quando a maioria já faz pooling, o acréscimo é zero; sob exclusão
   privada, o sinal depende da região e de `beta*o_1-o_0`; na região sem PBE
   puro de unanimidade, a comparação é vazia.
5. **Escopo e implicação:** delimitar explicitamente a análise a PBE em
   estratégias puras. A interpretação da célula vazia como “instabilidade” ou
   “tensão da hegemonia contestada” só entrará se for promovida por decisão
   autoral posterior.

A formulação “o componente informacional existe somente sob unanimidade” não
será usada literalmente: `N7` mostra que `RI_M` também pode ser não nula. O
claim correto é comparativo e condicional à classe de equilíbrio de maioria.
O abstract evitará tanto as interpretações pendentes P1--P3 quanto a construção
retórica “não é X, é Y”.

### 4.2 Arquitetura da introdução

Sobrevivem o hook OPEC/OMC, a Arábia Saudita como ator pivotal informado, os
Estados Unidos aceitando consenso, o puzzle em três camadas e o roadmap. As
mudanças obrigatórias são:

1. o benchmark de informação completa entra logo depois do puzzle para separar
   poder de veto conhecido de renda gerada por informação privada;
2. *screening* deixa de nomear o mecanismo central; o mecanismo passa a ser
   insumo essencial versus substitutos não informados, e a renda de unanimidade
   é de pooling;
3. todo preview de resultados é qualificado por tipo, classe de equilíbrio e
   região de parâmetros; o qualificador de tipo, sozinho, não autoriza um claim
   global de que “unanimidade beneficia o hegemon”;
4. Piazolo--Vanberg e Glynia--Thum--Xefteris recebem crédito integral antes da
   declaração da contribuição;
5. o roadmap segue a ordem da matriz: benchmark público, correspondências
   privadas, rendas e Discussion.

## 5. Mapa de lemas, proposições e teoremas atuais

| Objeto formal atual | Ação | Objeto de destino | Fonte congelada |
|---|---|---|---|
| Definition `Clean immediate-opt-out game` | **substituído** | Definition `Essential-input bargaining game` | Contrato; não é resultado de nó. |
| Definition `Weak-vote-passive assessment` | **substituído** | Definition `Solution concept and endpoint support` | Decisão de conceito + Emenda 1a. |
| Lemma `Terminal unanimity` | **reescrito** | Lemma terminal: low-only para `nu<=nu_star`, pooling para `nu>nu_star`; igualdade seleciona low-only | `N2`, `c6a65d...a85a2`. |
| Proposition `Terminal majority` | **reescrito** | Proposition terminal belief-free: aprovação sem `H`, pie integral do proponente, payoff externo de `H` | `N1`, `1a1717...981b5`. |
| Lemma `Off-path completion and guarantees` | **substituído** | Lemma de completamento por célula e certificado do ciclo sem perfil puro | `N4`, `f1c823...6408b`. |
| Theorem `Regular unanimity existence and payoff` | **substituído** | Proposition `Pure-PBE correspondence under unanimity` com as três células e descontinuidade em `nu=0+` | `N4`, `f1c823...6408b`. |
| Proposition `Regular majority correspondence` | **substituído** | Proposition `Pure-PBE correspondence under majority for m>=3` | `N3`, `ff0537...330d`. |
| Proposition `Entry nesting` | **removido** | Nenhum substituto: formação/entry está fora do escopo | Contrato Seção 1. |
| Proposition `Hegemon payoff bounds` | **substituído** | Proposition de comparação privada e proposition/lemma de rendas por regra e `DeltaRI` | `N6`, `a9cfd5...a5a92`; `N7`, `4e0169...9c45`. |
| Proposition `Unanimity when o_0=0` | **removido** | Domínio corrente impõe `o_0>0` | Contrato Seção 2. |
| Proposition `Unanimity when o_1=1` | **removido** | Domínio corrente impõe `o_1<1` | Contrato Seção 2. |
| Proposition `Unanimity when beta=1` | **removido** | Domínio corrente impõe `beta<1`; eventual extensão não é aberta no Goal 5 | Contrato Seção 2. |
| Resultado informal `Majority boundary bounds` | **removido** | A correspondência N3 no domínio autorizado substitui os bounds antigos | `N3`, `ff0537...330d`. |
| Resultado `Degenerate priors as one-sided limits` | **substituído** | Endpoints literais sob restrição de suporte e equivalência com os jogos públicos | Emenda 1a; `N4`, `N7`. |
| `One-shot bridge` | **reescrito** | Remark ligando N2 ao exemplo `N=5`, sem apresentá-lo como benchmark público | `N2`, `c6a65d...a85a2`. |

### Novos objetos formais necessários no corpo

1. **Proposition — complete-information benchmark.** Os quatro jogos públicos,
   incluindo a fronteira `o_theta=1/m`. Fonte: `N7`.
2. **Proposition — private majority correspondence.** Conjunto exato, com
   multiplicidade por identidade remetida ao apêndice. Fonte: `N3`.
3. **Proposition — private unanimity correspondence and nonexistence.** As três
   células, incluindo o certificado e a intuição do ciclo. Fonte: `N4`.
4. **Proposition — informational rents by rule.** `RI_M` e `RI_U` mantidos
   separados, inclusive quando uma das correspondências é vazia. Fonte: `N7`.
5. **Proposition — institutional informational-rent contrast.** `DeltaRI` por
   tipo, sinais, vazios e segmentos exatos; nenhuma seleção ad hoc. Fonte: `N7`.
6. **Remark — ex ante image.** Somente se P3 for aprovado; nunca proposição.
7. **Remark — pure-strategy scope.** A célula vazia demonstra inexistência
   apenas no espaço de estratégias puras adotado pelo paper. Ela não demonstra
   inexistência de todo PBE, e o paper não deriva, seleciona ou compara mistos.

## 6. Mapa das provas atuais

| Prova atual | Ação | Prova de destino | Fonte congelada |
|---|---|---|---|
| Proof of Terminal unanimity | **reescrito** | Votos fracos, cutoffs de `H`, comparação low-only/pooling e tie-break | Derivação `N2`; hash da interface `c6a65d...a85a2`. |
| Proof of Terminal majority | **reescrito** | Votos fracos, `H` não pivotal, execução integral de `y` e pie do proponente | Derivação `N1`; `1a1717...981b5`. |
| Proof of Off-path completion | **substituído** | Completamentos de N4 nas células existentes e enumeração dos quatro perfis puros no certificado de inexistência | Derivação `N4`; `f1c823...6408b`. |
| Proof of Regular unanimity theorem | **substituído** | Provas de `L_star`, célula `none`, `P_star` e descontinuidade no endpoint | Derivação `N4`; `f1c823...6408b`. |
| Proof of Regular majority correspondence | **substituído** | Candidatos exclusão/screening/pooling, factibilidade, fronteiras, tie-break, atomicidade de `F_i` e exclusão de rejeição/folga | Derivação `N3`; `ff0537...330d`. |
| Proof of Entry nesting | **removido** | Nenhuma prova substituta | Entry fora do escopo. |
| Proof of Hegemon payoff bounds | **substituído** | Subtração do benchmark público, conjuntos de renda, envelopes e `DeltaRI` | Derivações `N6` e `N7`. |
| Proofs de `o_0=0`, `o_1=1` e `beta=1` | **removido** | Nenhuma prova no baseline | Parâmetros excluídos. |
| Derivação dos limites laterais dos priors | **substituído** | Prova da restrição de suporte, endpoints literais e equivalência público–privado | Emenda 1a; `N4`, `N7`. |

Ordem planejada no apêndice: conceito e ICs; N1; N2; N3; N4 existente;
certificado N4 `none`; N6; N7 público; rendas e envelopes. Essa ordem respeita
as dependências e evita usar o benchmark público como premissa do jogo privado.

## 7. Mapa de figuras e tabelas

### Figuras

| Figura | Ação | Destino e regra de conteúdo | Colocação | Fonte |
|---|---|---|---|---|
| Timing atual do v6 | **substituído** | Figura de sequência essential-input, sem estágios triviais e sem opt-out | Junto da descrição do timing no modelo | Contrato Seção 4. |
| `F1` mapa institucional | **reescrito** | Versão permanente recolorida pelo sinal real de `DeltaRI`; manter faceta por tipo e preparar faceta ex ante sob `[AUTHOR: P3]` | Junto da proposition de comparação privada (`N6`) | `N6`, `N7`; `a9cfd5...`, `4e0169...`. |
| `F2` preços e anatomia da coalizão | **reescrito** | Preservar narrativa Round 4; confirmar todos os rótulos com N1--N4/N7 e caption integral em inglês | Junto do mecanismo e dos preços derivados em `N3`--`N4` | `N1`--`N4`, `N7`. |
| `F3` poder versus informação | **substituído** | Remover placeholder e gerar com payoffs públicos e rendas reais de N7; versão normalizada no corpo e raw apenas se necessária no apêndice | Junto da proposition de rendas (`N7`) | `N7`, `4e0169...9c45`. |
| `F4` declínio hegemônico | **reescrito** | Manter estática; região sem PBE puro hachurada; leitura de instabilidade somente se aprovada, nunca como resultado formal | Somente na `Discussion` | `N4`, `N7`; guardrail autoral. |
| `C1` plano de opções externas | **removido** | Não integra o conjunto de figuras permanentes. Pode ser regenerado depois apenas como *working numerical illustration* de apêndice se a matriz for emendada e aprovada | Fora do corpo nesta rodada | Não migrar nesta rodada. |

Os manifestos atualmente contêm caminhos absolutos da worktree de figuras.
Durante a implementação aprovada, o gerador deverá ser executado na worktree do
Goal 5 para gravar caminhos reproduzíveis da árvore corrente; isso é reparo de
empacotamento, não alteração matemática. Cada figura ficará ao lado da frase ou
proposition cujo takeaway deve tornar visualmente imediato.

A pendência RIO “figuras conectadas à realidade” permanece aberta e não
bloqueia o Goal 5. Na `Discussion`, episódios históricos podem ser anotados em
F4 somente como ilustrações explícitas, não como teste empírico ou calibração.

### Tabelas atuais e planejadas

| Tabela | Ação | Destino | Fonte |
|---|---|---|---|
| `Scope of the clean baseline results` | **substituído** | Escopo dos resultados essential-input | `N1`–`N7`. |
| Gate 0 panel A — timing/electorate/votes | **substituído** | Parte de uma única tabela de protocolo corrente | Contrato Seção 4. |
| Gate 0 panel B — implementation/participation | **substituído** | Tabela de implementação integral de `y`, sem estado weak-only | Contrato Seção 4; `[AUTHOR: P1]`. |
| Gate 0 panel C — payoffs/time units | **substituído** | Tabela corrente de payoffs e datas | Contrato Seções 4 e 6; `[AUTHOR: P1]`, `[AUTHOR: P2]`. |
| Gate 0 panel D — beliefs/continuations | **substituído** | Tabela do sistema de crenças e suporte | Decisão de conceito + Emenda 1a. |
| `One-sided majority equilibrium-outcome limits` | **substituído** | Tabela de endpoints literais e benchmark público | `N4`, `N7`. |
| `Notation for the clean immediate-opt-out baseline` | **reescrito** | Notação essential-input | Contrato + `N1`–`N7`. |
| Nova tabela de quatro jogos públicos | **substituído** | Resultados por regra, rodada e tipo | `N7`. |
| Nova tabela de correspondências privadas | **substituído** | Regiões de maioria/unanimidade, existência e outcomes | `N3`, `N4`, `N6`. |
| Nova tabela de `RI_M`, `RI_U`, `DeltaRI` | **substituído** | Vetores por tipo; `(1-beta)o_theta` em coluna própria como cunha de timing, separada de `d=beta(o_1-o_0)` e `k=beta o_1-o_0` | `N7`. |

## 8. Conteúdo matemático que entrará — e limites de linguagem

- A região `0<nu<=nu_star` será uma célula de inexistência de PBE puro, sem
  payoff imputado. A intuição do ciclo acompanha a proposition; a enumeração e
  o certificado completos ficam no apêndice.
- A descontinuidade entre `nu=0` e `nu->0+` será resultado explícito, não
  anomalia descartada por continuidade.
- Sob multiplicidade de N3, o texto reporta conjuntos e envelopes. Permutações
  de identidades fracas podem ser quocientadas na exposição, mas a massa entre
  classes economicamente distintas não.
- O segmento residual entre exclusão e pooling mantém a mesma massa em payoff e
  outcome; envelopes coordenados não formam um retângulo.
- A renda de unanimidade é vazia onde o jogo privado de unanimidade não tem PBE
  puro; `DeltaRI` também é vazio ali. A renda de maioria permanece definida.
- A imagem ex ante aplica o mesmo prior a cada vetor inteiro e não recombina
  marginais. Até P3, isso é apenas um remark/figura planejado.
- Os termos `a_theta=(1-beta)o_theta` serão chamados de **timing wedge**. Eles
  não serão confundidos com `d=beta(o_1-o_0)` nem com
  `k=beta o_1-o_0`.
- Equilíbrios mistos não são derivados nem comparados. Entra somente um remark
  de escopo: a célula `none` exclui PBE puro, mas não permite inferir
  inexistência de todo equilíbrio.
- Não entram: `beta=1`, `o_1=1`, `o_0=0`, entry, escolha endógena de regra,
  `pi_H>0`, calibração OPEC antiga, opt-out ou rótulos históricos A/C/R e
  C-B-R.

## 9. Literatura e bibliografia

O arquivo `quality_reports/2026-08-21_honest_assessment_contribuicao_vs_literatura.md`
no snapshot de origem identifica-se como v2 e não contém um bloco separado com
o título “adendo v3”. Isso não cria uma escolha substantiva: a autorização
literal do Goal 5 especifica diretamente o conteúdo que atribui ao adendo —
benchmark primeiro, crédito integral aos vizinhos e contribuição concentrada
nos substitutos não informados e em `DeltaRI`. Essas instruções literais serão
usadas sem reescrever retroativamente o honest assessment.

Entradas já presentes em `references.bib`: Fudenberg–Tirole; Kreps–Wilson;
Winter; Feddersen–Pesendorfer; McCarty; Tsai; Tsai–Yang; Chen–Eraslan (2013,
2014); Miller–Montero–Vanberg; Ma; Eraslan–Evdokimov; Piazolo–Vanberg;
Glynia–Thum–Xefteris.

Entrada necessária ainda ausente: Osborne–Rubinstein (1990), para a analogia
mais forte com NDOC. Ela será adicionada somente na fase de implementação da
matriz aprovada. A redação observará:

- Fudenberg–Tirole: atualização bayesiana onde possível e disciplina de
  no-signaling;
- Kreps–Wilson: motivação por trembles, nunca autoridade para prior degenerado;
- Osborne–Rubinstein: NDOC como análogo mais forte, não como conceito adotado;
- nenhuma numeração de condições de Fudenberg–Tirole sem conferência direta.

## 10. Sequência de implementação após aprovação desta DRAFT

1. Registrar a matriz como `APPROVED` com a decisão literal do autor sobre a
   matriz e sobre P1–P3.
2. Criar um checkpoint local antes da primeira edição do Rmd.
3. Reescrever modelo e conceito; verificar ausência de opt-out e de unidades
   temporais incompatíveis.
4. Migrar resultados públicos e privados, sempre com intuição antes da
   proposition e prova no apêndice.
5. Construir tabelas de rendas diretamente da interface N7.
6. Regenerar F1–F4; F3 deixa de ser placeholder; criar a figura de sequência e
   verificar a colocação editorial fixada na Seção 7.
7. Fazer busca negativa por linguagem e rótulos proibidos.
8. Compilar somente com `rmarkdown::render("formal_model_v6.Rmd")`.
9. Renderizar o PDF para imagens e inspecionar texto, equações, tabelas,
   captions, quebras e escalas de cinza.
10. Submeter o mesmo snapshot a dois revisores independentes e read-only:
    fidelidade/desenho formal e exposição/qualidade visual.
11. Corrigir somente findings técnicos de reparo único; qualquer escolha nova
    volta ao autor. Todo snapshot alterado retorna aos dois revisores.
12. Após dois `PASS 0/0/0`, solicitar o aval autoral. Só então criar a tag final
    pelo workflow `paper-version`.

O readability audit não usará Pangram. Pangram continua proibido sem duas
autorizações explícitas separadas. Não haverá push.

## 11. Gates de aceitação da matriz — satisfeitos

Em 2026-08-22, o autor confirmou:

1. que aprova esta matriz e a substituição da arquitetura substantiva dentro do
   mesmo arquivo v6;
2. o tratamento editorial de P1, sem decidir sua interpretação substantiva;
3. o tratamento editorial de P2, sem decidir sua interpretação substantiva;
4. o tratamento de P3: imagem ex ante somente como remark e faceta planejada de
   F1, nunca proposition, e fora do manuscrito até decisão autoral.

O autor aprovou o **tratamento** de P1--P3, sem resolver as três interpretações
substantivas. P1, P2 e P3 permanecem pendentes; qualquer frase que as pressuponha
deve manter o marcador correspondente. Com esses gates satisfeitos, a edição
controlada do manuscrito está autorizada.

## 12. Validação da fronteira aprovada

- `formal_model_v6.Rmd` permanece com SHA-256
  `131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d`,
  idêntico ao blob de `e0ff1ac`.
- O DAG permanece com SHA-256
  `36155405a635bf6842c09dcde127907ec1f6fe61bb86ec06d932d7e472abf9ab`.
- Gate 0, N1, N2, o verificador dirigido de N3/N4, N6 e N7 terminaram em
  `PASS`. Os avisos isolados de locale não são findings substantivos.
- O Gate 0 congelado ainda imprime que o Goal 5 não estava autorizado porque
  seu snapshot antecede a autorização literal registrada neste branch. Esse
  texto não foi alterado: modificar o verificador congelado violaria a proteção
  dos artefatos. A autoridade corrente é a decisão autoral posterior, preservada
  em `quality_reports/2026-08-21_autorizacao_goal5.md`.
- `formal_model_v5.Rmd`, `formal_model_v6.Rmd`, `RIO submission files/`, o DAG,
  todas as interfaces congeladas e todos os verificadores permaneceram sem
  diff contra `e0ff1ac`.
- O manuscrito não foi compilado, conforme o gate desta DRAFT.
- O Round 4 das figuras contém validação mecânica/visual do implementador, mas
  não parecer independente final. Como F1 e F3 ainda serão materialmente
  regeneradas com N7, a auditoria visual independente incidirá sobre as figuras
  finais no mesmo snapshot do manuscrito, não sobre os placeholders atuais.
