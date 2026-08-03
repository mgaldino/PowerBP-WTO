# Goal 1: Clean Immediate-Opt-Out Baseline

**Project:** Informational Power Through Pivotality
**Date:** 2026-08-03
**Working document:** `model_redesign/power_architecture_derivations.Rmd`
**Future manuscript target, outside this goal:** `formal_model_v6.Rmd`

## Opção curta

Use este launcher no Codex:

```text
/goal Leia integralmente quality_reports/plans/2026-08-03-clean-baseline-goal.md e execute a Especificação operacional. Considere o objetivo concluído somente quando o Gate 0 estiver formalmente fechado, o baseline limpo pi_H=0 e b_theta=0 com opt-out imediato o_theta estiver rederivado no model_redesign, todos os verificadores passarem, o documento autônomo compilar e os revisores independentes emitirem PASS sem ressalvas substantivas. Não edite formal_model_v6.Rmd.
```

## Especificação operacional

### Objetivo

Rederivar, verificar e obter aprovação independente para o baseline limpo de
informational power through pivotality. O baseline deve separar poder de
outside option, poder de veto/pivotalidade e poder de agenda, sem importar
fórmulas ou resultados da arquitetura anterior.

O resultado final deste Goal é um laboratório formal estável e auditado, não
uma nova versão do manuscrito. Não transportar resultados para
`formal_model_v6.Rmd` durante este Goal.

### Fontes obrigatórias

Antes de editar, leia integralmente:

1. `AGENTS.md`;
2. `CLAUDE.md`;
3. `model_redesign/README.md`;
4. `quality_reports/2026-05-25_clean_baseline_priority.md`;
5. `quality_reports/2026-05-11_common_voting_protocol_unanimity_majority.md`;
6. `quality_reports/2026-05-15_ajps_revision_scope_after_discussion.md`;
7. `model_redesign/power_architecture_derivations.Rmd`;
8. `formal_model_v6.Rmd` e `formal_model_v5.Rmd` apenas como referências de
   claims, apresentação e história, não como fontes de fórmulas válidas para o
   novo baseline.

O aviso de reset no topo de
`model_redesign/power_architecture_derivations.Rmd` prevalece sobre os status e
ledgers antigos existentes no corpo do arquivo.

## Gate -1: provenance e snapshot

Antes de qualquer edição substantiva:

1. verifique o Git root e execute `git status --short --branch`;
2. confirme que o snapshot pré-reset foi commitado e recebeu uma tag anotada
   aprovada pelo usuário;
3. se houver mudanças não relacionadas, não faça reset, checkout, stash,
   sobrescrita ou inclusão automática dessas mudanças;
4. se o snapshot/tag ainda não existir, pare e solicite autorização antes de
   criar a tag;
5. registre no relatório do Goal o commit e a tag usados como baseline de
   proveniência;
6. registre o hash inicial de `formal_model_v6.Rmd` para demonstrar ao final
   que o manuscrito permaneceu intocado.

## Gate 0: contrato completo do jogo

Não comece as provas enquanto este Gate não estiver fechado. Produza no início
do documento de derivações uma especificação autônoma do jogo e uma tabela de
históricos de votação.

### 0.1 Primitivos obrigatórios

- Há `N>=3` Estados: um hegemon `H` e `m=N-1` weak states.
- Natureza escolhe `theta in {0,1}`. Somente `H` observa `theta`; os fracos
  compartilham prior `mu=Pr(theta=1) in [0,1]`. Faça a derivação bayesiana
  principal para `mu in (0,1)` e trate `mu=0,1` separadamente como casos
  degenerados ou limites.
- O surplus institucional disponível à coalizão fraca é fixo, conhecido e
  normalizado em 1. O tipo de `H` não altera esse pie.
- Uma proposta de weak proposer `i` contém um pacote de participação
  `y in [0,ybar]` para `H` e ofertas não negativas `x_j` a cada weak state
  `j!=i`. O proposer retém o residual definido em 0.1B.
- O baseline fixa `b_0=b_1=0`. Se o acordo inclui `H`, seu payoff corrente é
  `y`.
- O outside payoff `o_theta` é primitivo. Não impor no teorema limpo
  `o_theta=alpha V(theta)`; essa parametrização pertence a aplicação,
  ilustração ou microfundamento.
- Domínio inicial: `0<=o_0<o_1<=ybar<=1` e `beta in (0,1]`.
- Weak-state outside payoffs são normalizados em zero.
- O baseline fixa `pi_H=0` em todas as rodadas. `H` nunca é proposer.
- Primitivos, parâmetros, distribuições, regras de reconhecimento, contract
  space, protocolo de votação, quotas e tie-breaks são conhecimento comum.
- Conceito de solução: PBE, com o escopo exato declarado em cada resultado.

### 0.1A Horizonte, reconhecimento e unidades temporais

- O baseline tem exatamente duas rodadas, R1 e R2. Não há R3. Natureza sorteia
  `theta` antes de R1, o tipo persiste e somente `H` o observa.
- Em cada rodada alcançada, um novo reconhecimento é sorteado publicamente.
  Cada um dos `m` weak states é reconhecido com probabilidade `1/m`,
  independentemente do reconhecimento anterior, de `theta` e da história,
  condicional ao fato de a rodada ser alcançada. `H` tem probabilidade zero.
- R1 define a unidade de payoff. Todo fluxo realizado em R2 é multiplicado por
  `beta` quando expresso em unidades de R1. Um opt-out de `H` em R1 paga
  `o_theta` imediatamente e, portanto, sem `beta`.
- R2 é terminal. Se `H` ainda está ativo e o ballot de R2 falha, `H` recebe
  `o_theta` na data de R2, qualquer que tenha sido seu voto; em unidades de R1,
  isso vale `beta*o_theta`. Os weak states recebem zero. Se `H` vota não em R2,
  esse pagamento é seu opt-out terminal, não um pagamento adicional.
- Se `H` já exerceu opt-out em R1, recebe `o_theta` uma única vez e não recebe
  qualquer fluxo de R2. Uma falha terminal weak-only dá zero aos weak states.
- Se `H` permanece, o eleitorado continua sendo os `N` Estados. Depois do
  opt-out, somente os `m` weak states permanecem ativos, mas a quota
  institucional de maioria continua sendo a quota original
  `q=floor(N/2)+1`; ela não é recalculada sobre `m`. Como a unanimidade exige
  `N` votos, opt-out de `H` torna qualquer acordo unanimista futuro impossível
  e esse ramo termina.

### 0.1B Espaço de propostas, orçamento e implementação

- O mesmo espaço de propostas vale em R1 e R2 e sob ambas as regras, salvo a
  restrição explícita `y=0` depois do opt-out de `H`.
- Enquanto `H` está ativo, toda proposta contém a oferta condicional `y`; não
  há indicador oculto adicional de inclusão. `H` é incluído se e somente se
  vota sim e o acordo passa. Um acordo passa sem `H` quando `H` vota não e a
  quota majoritária é atingida pelos weak states.
- O outside payoff `o_theta` é externo ao pie institucional: nunca é subtraído
  do surplus fraco e nunca pode ser somado a `y` para `H` no mesmo histórico.
- Se `H` participa, a identidade orçamentária é
  `y + sum_{j!=i} x_j + x_i = 1`, onde
  `x_i = 1-y-sum_{j!=i}x_j >= 0` é o residual do weak proposer.
- As ofertas `x_j` são implementadas para os weak states nomeados sempre que o
  acordo passa, independentemente do voto individual de cada recebedor. O
  proposer escolhe quem recebe oferta e pode fixar zero para os demais.
- `y` é condicional à participação de `H`. Se `H` vota sim e a quota é
  atingida, `H` participa e recebe `y`; o residual do proposer é `x_i`.
- Se `H` vota não e a quota de maioria é atingida apenas com votos fracos, `H`
  sai, recebe `o_theta` externamente e `y` não é implementado. As ofertas
  `x_j` permanecem e o weak proposer reabsorve a parcela condicional, recebendo
  `1-sum_{j!=i}x_j = x_i+y`. Não queime `y` nem pague `y+o_theta` a `H`.
- Depois de opt-out anterior de `H`, qualquer proposta weak-only fixa `y=0` e
  satisfaz `sum_{j!=i}x_j+x_i=1`.
- Se o ballot falha, nenhuma oferta corrente `x_j` e nenhum `y` são
  implementados. Aplicam-se apenas os payoffs de opt-out, continuação ou
  término definidos para aquele histórico.

Essas regras tornam o pacote contingente somente à participação observável de
`H`, não ao tipo privado. O Gate 0 deve verificar se esse contract space é
coerente com todos os desvios. Se uma inconsistência exigir outra regra de
implementação, marque `pending protocol decision` e peça decisão do usuário;
não escolha entre cancelamento, queima ou reatribuição de `y` dentro da prova.

### 0.1C Entry coletivo

- A regra institucional `R in {U,M}` é fixada exogenamente para cada comparação;
  não há escolha endógena de regra neste Goal.
- Depois de Natureza sortear `theta`, mas antes do reconhecimento de R1, a
  coalizão dos `m` weak states toma uma única decisão coletiva e all-or-nothing
  de formar a instituição. Os fracos não observam `theta` e decidem usando
  `mu`; `H` observa o tipo, mas não toma ação na etapa de formação. Este é um
  primitivo coletivo, não um jogo simultâneo de entrada individual.
- Se formar, cada weak state incorre em custo externo e afundado `chi>=0`, que
  não reduz o pie de valor 1. A barganha então começa.
- Se não formar, cada weak state recebe zero e `H` recebe `o_theta`. `H` não
  vota sobre formação.
- Como a decisão de formação é coletiva, defina o payoff bruto relevante como
  a média per capita dos payoffs fracos:
  `V_W^R(mu)=(1/m) E[sum_{j=1}^m u_j^R | formation]`, integrando tipo,
  reconhecimento e eventual seleção de parceiros de coalizão. A instituição
  se forma se `V_W^R(mu)-chi>=0`; em empate, forma. Não interprete essa regra
  coletiva como prova de que todo weak state individualmente prefere entrar
  sem antes fornecer uma seleção simétrica entre coalizões. Não derive nesting
  ou classificação antes de verificar esse objeto a partir dos payoffs do jogo.

### 0.2 Protocolo de votação obrigatório

- A barganha é sequencial e pública entre rodadas: proposta, ballot,
  publicação do vetor completo de votos e do resultado, seguida de eventual
  continuação.
- Dentro de cada ballot, todos observam a proposta e a história pública; `H`
  também conhece `theta`. O proposer conta como voto favorável e todos os
  demais jogadores ativos votam simultaneamente.
- Os votos individuais são revelados somente depois que todos votaram.
- Unanimidade e maioria usam o mesmo ballot; apenas a quota muda.
- Unanimidade exige `N` votos favoráveis.
- Maioria exige `q=floor(N/2)+1` votos favoráveis.
- Não reinterpretar este protocolo como roll-call sequencial.

### 0.3 Opt-out e classes de históricos

Use as seguintes regras como contrato inicial. Se alguma delas gerar
inconsistência, não a altere silenciosamente: marque `pending protocol decision`,
explique a consequência substantiva e solicite decisão do usuário.

1. **Acordo corrente que inclui H e passa.** Se `H` vota sim e a quota é
   atingida, o acordo é implementado. `H` recebe `y`; os weak states recebem
   `x_j` e o proposer retém o residual. Em R2, todos esses fluxos valem `beta`
   em unidades de R1.

2. **H vota não.** O voto não de tipo `theta` exerce um opt-out imediato e
   irreversível: nenhum acordo presente ou futuro pode incluir `H`, e `H`
   recebe `o_theta` na data do voto, sem opção adicional `beta C_theta`. Em R1,
   isso vale `o_theta` sem desconto; em R2, vale `beta*o_theta` quando expresso
   em unidades de R1.

3. **H-no em R1 sob unanimidade.** O ballot falha. Como o opt-out impede a
   reinclusão de `H` e unanimidade mantém quota `N`, o ramo institucional
   termina imediatamente; os weak states recebem zero.

4. **H-no sob maioria, quota atingida pelos fracos.** O acordo weak-only passa
   sem `H`. `H` recebe `o_theta` externamente; a coalizão fraca recebe o payoff
   do acordo conforme as ofertas `x_j`, e o proposer reabsorve o `y`
   condicional conforme 0.1B. Se isso ocorre em R2, todos os fluxos da data de
   R2 são multiplicados por `beta` quando expressos em unidades de R1.

5. **H-no em R1 sob maioria, quota não atingida.** `H` sai e recebe `o_theta`
   imediatamente. O jogo segue obrigatoriamente para R2 weak-only, usa
   `pi_H=0`, mantém a quota original `q` e não pode reincluir `H`. Os valores
   dos fracos nessa continuação devem ser derivados, não impostos.

6. **H-yes em R1 com falha causada apenas por weak votes.** `H` não exerceu
   opt-out. O jogo segue obrigatoriamente para R2 sob a mesma regra
   institucional, com `pi_H=0` e `H` ainda presente. Os payoffs de R2 são
   descontados por `beta`. Esse ramo permite testar, sem presumir, se o
   candidato de rejection/continuation e o rejected-history reduction lemma
   sobrevivem.

7. **Rejeição conjunta em R1 de H e weak voters.** O opt-out de `H` é
   definitivo. Sob unanimidade, o ramo termina e os weak states recebem zero.
   Sob maioria, se a quota não foi atingida, R2 é weak-only, mantém `q`, e não
   pode reincluir nem remunerar `H`.

8. **Vetor que já alcança a quota.** Não classificar como falha apenas porque
   `H` votou não. Sob maioria, o resultado depende da quota, não da inclusão de
   `H`.

9. **Falha em R2 com H ainda presente.** R2 é terminal. Nenhuma alocação
   corrente é implementada; `H` recebe `o_theta` na data de R2 e os weak states
   recebem zero. Isso também cobre `H`-yes seguido de falha causada por votos
   fracos; `H` não recebe `y` porque não houve acordo.

10. **Acordo em R2 weak-only.** Se os votos dos jogadores ativos alcançam a
    quota original `q`, o acordo passa com `y=0`. Os weak states recebem as
    ofertas `x_j`, o proposer retém o residual, e esses payoffs são
    multiplicados por `beta` em unidades de R1. `H`, já remunerado pelo opt-out
    de R1, não recebe nada adicional.

11. **Falha em R2 weak-only.** Se os votos ativos não alcançam `q`, o jogo
    termina, os weak states recebem zero e `H`, já remunerado pelo opt-out de
    R1, não recebe nada adicional.

O cutoff direto `y_theta^*=o_theta` deve ser derivado somente em um ballot no
qual, sob as estratégias dos weak voters, o voto sim de `H` leva com
probabilidade 1 à implementação corrente de um acordo que o inclui e o voto
não leva ao opt-out imediato. Ele não é uma regra global de votação. Como os
votos são simultâneos, `H` não pode condicionar seu voto aos votos fracos ainda
não observados. Em qualquer information set no qual falha causada pelos fracos
tenha probabilidade positiva, derive a IC esperada de `H` comparando os payoffs
de implementação, opt-out e continuação induzidos por cada voto. Não atribua a
`H` uma nova decisão depois de observar o vetor já realizado.

### 0.4 Crenças, ICs e tie-breaks

- Crenças on-path seguem Bayes após a publicação do vetor completo de votos.
- Use a expressão **weak-vote-passive assessment**. Ela é uma avaliação
  mantida do protocolo, não refinement, D1, Intuitive Criterion, sequential
  equilibrium restriction ou caracterização de todos os PBEs.
- Desvios unilaterais dos weak states não são tratados como sinais diretos de
  `theta`, pois eles não observam o tipo de `H`.
- Após qualquer vetor com desvio de weak voter, o posterior sobre `theta` deve
  ser o implicado pela proposta pública e pela estratégia/voto simultâneo de
  `H`, não pelo desvio de um jogador sem informação privada.
- Um voto separador de `H` pode atualizar crenças quando o ramo continua e a
  crença ainda é payoff-relevant.
- Em qualquer continuação de probabilidade zero na qual `H` permaneça ativo,
  declare a crença off-path necessária e mostre quais resultados dependem dela.
  Não escolha crença ad hoc para eliminar um ramo e não apresente um resultado
  condicionado a essa crença como caracterização de todos os PBEs.
- Depois que `H` exerce opt-out, `theta` deixa de ser payoff-relevant para a
  continuação weak-only. Registre o payoff já realizado de `H`, mas não invente
  posterior para resolver uma continuação que não depende do tipo.
- Verifique approval ICs, participation ICs e racionalidade sequencial em cada
  classe de histórico. Não use uma crença ou payoff de continuação antes de
  defini-lo.
- Formule a estratégia de voto de cada jogador no information set anterior ao
  fechamento do ballot. Históricos ex post servem para definir payoffs,
  posteriores e continuações, não para permitir condicionamento a votos
  simultâneos ainda não observados.
- Jogadores votam sim quando indiferentes.
- Entre propostas que maximizam o payoff do weak proposer, o tie-break
  minimiza o payoff esperado de `H`.
- Não introduza outro tie-break para fechar uma prova. Se necessário, marque
  `pending protocol decision` e peça decisão.

### 0.5 Entrega e teste do Gate 0

Inclua uma tabela exaustiva com, no mínimo, estas colunas:

```text
round | regra | jogadores ativos | quota | quota atingida? | voto de H
oferta de participação a H? | causa da falha | H incluído? | H permanece?
y implementado? | destino de y
payoff de H | payoff dos fracos | fator de desconto | posterior relevante
terminal ou continuação | próximo subgame
```

O Gate 0 somente recebe `PASS` se:

- todas as classes acima tiverem payoffs e continuação definidos;
- não houver dupla remuneração de `H`;
- nenhum acordo posterior reincluir `H` depois do opt-out;
- nenhuma fórmula `beta C_theta` ou `beta D_theta` for usada como payoff do
  próprio voto não/opt-out de `H`, e `t_theta=d_theta-b_theta` ou
  `y+b_theta` não forem rotulados como baseline. É legítimo que `H`-yes seguido
  de falha fraca produza `beta` vezes um valor de R2; não confunda essa
  continuação com o payoff de opt-out;
- o mesmo protocolo de ballot for usado sob unanimidade e maioria;
- a quota e o eleitorado depois do opt-out estiverem definidos;
- todas as identidades orçamentárias fecharem em ramos H-including e weak-only;
- a IC de `H` for definida em cada information set de votação e integrar os
  possíveis vetores simultâneos, sem aplicar `y_theta^*=o_theta` globalmente;
- crenças estiverem definidas em toda continuação na qual `theta` permaneça
  payoff-relevant, com dependências off-path declaradas;
- nenhum resultado de equilíbrio tiver sido presumido como primitivo.

Registre o resultado em
`quality_reports/2026-08-03_clean_baseline_goal1_status.md`. Se o Gate 0 não
passar, não prossiga para as provas.

### 0.6 Auditoria independente do Gate 0

O implementador pode preparar o contrato e os testes, mas não pode atribuir o
`PASS` final ao próprio Gate 0. Antes da Fase 1:

1. fixe a especificação e a tabela de históricos em um commit candidato;
2. designe um revisor read-only que não tenha editado os arquivos;
3. peça uma auditoria do extensive form, cobrindo timing, ações, informação,
   reconhecimento, quotas, implementação, orçamento, payoffs terminais,
   unidades temporais, crenças e definição das ICs;
4. se o veredito for `REPAIR`, o implementador corrige e o mesmo estado
   corrigido é rerevisado;
5. prossiga para provas somente após `PASS` sem ressalva substantiva e registre
   parecer, commit e respostas no relatório do Goal.

## Fase 1: rederivação analítica

Depois do Gate 0, rederive na seguinte ordem:

1. feasibility, budget identities e payoffs terminais;
2. Round 2 sob unanimidade para os ramos em que `H` permanece;
3. Round 2 weak-only sob maioria após opt-out, se esse ramo for alcançável;
4. participation e approval ICs de Round 1;
5. conjunto completo de accepted e rejected outcomes relevantes sob
   unanimidade;
6. pooling, low-only e rejection/continuation apenas se forem admissíveis no
   novo jogo;
7. exaustão de desvios e papel residual da weak-vote-passive assessment;
8. majority/no-screening e a condição No-Cheap-H rederivada sob `o_theta`
   primitivo;
9. entry/nesting;
10. payoff de `H`, comparação institucional e classificação, somente se os
    resultados anteriores estiverem provados.

Não preserve automaticamente `P`, `L`, `R`, No-Cheap-H, nesting ou a
classificação anterior. Produza uma matriz de sobrevivência:

```text
resultado antigo | sobrevive | muda | desaparece | vira extensão | evidência
```

Cada resultado deve apresentar:

- domínio e quantificadores;
- hipóteses usadas, nominalmente;
- conclusão exata e escopo de equilíbrio;
- intuição informal antes da prova;
- prova em passos ou claims numerados;
- casos de fronteira e empates;
- status: `proved`, `checked numerically`, `conjecture`, `pending` ou
  `rejected`.

## Fase 2: verificações reproduzíveis

Mantenha computação em scripts R separados. Não sobrescreva silenciosamente os
verificadores da arquitetura de continuação descontada. Prefira nomes como:

```text
scripts/verify_clean_optout_protocol_piH0.R
scripts/verify_clean_optout_R2_piH0.R
scripts/verify_clean_optout_R1_piH0.R
scripts/verify_clean_optout_majority_piH0.R
scripts/verify_clean_optout_entry_nesting_piH0.R
scripts/verify_clean_optout_classification_piH0.R
scripts/verify_clean_optout_margins_piH0.R
scripts/verify_clean_optout_robustness_piH0.R
```

Nos scripts:

- usar `dplyr::select` ao selecionar colunas;
- testar endpoints, ties, feasibility, threshold order e denominadores;
- separar prova analítica de grid checks;
- usar exemplos internos e não boundary;
- registrar inputs, outputs, data e status;
- falhar com exit não zero quando uma condição obrigatória falhar;
- não tratar uma checagem numérica como prova universal.

Lean pode verificar álgebra, inequalities e thresholds internamente, mas não
deve ser citado no paper nem usado para alegar uma caracterização de PBE que não
foi formalizada.

## Fase 3: compilação do laboratório

Compile o documento autônomo pela configuração YAML:

```r
rmarkdown::render(
  "model_redesign/power_architecture_derivations.Rmd",
  output_format = "all"
)
```

Valide pelo menos:

- execução bem-sucedida de todos os novos scripts com `Rscript --vanilla`;
- `git diff --check`;
- existência e page count do PDF;
- extração de texto com `pdftotext`;
- referências cruzadas e equações sem warnings materiais;
- inspeção visual das páginas alteradas.

## Fase 4: revisão independente e repair loop

Quem implementa não revisa. Quem revisa não edita.

Depois de a implementação estar fixada em um commit, execute em paralelo:

1. **Formal-model reviewer**, usando `review-formal-model` ou workflow
   equivalente, com foco em primitivas, baseline/extensões, claim discipline e
   exposição técnica.
2. **Adversarial game-theory reviewer**, usando `game-theory-audit`, com foco em
   PBE, crenças, ICs, pivotalidade, outside option, opt-out, desvios e
   multiplicidade.
3. **R reviewer**, usando `review-r`, para todos os scripts novos ou alterados.

Salvar os pareceres completos em `quality_reports/`, com commit revisado,
veredito e achados classificados como críticos, maiores, menores ou
editoriais.

Se qualquer revisor emitir `REPAIR` ou encontrar problema substantivo:

1. o implementador corrige;
2. registra uma matriz `finding | resposta | arquivo/linha | teste`;
3. cria novo commit de candidato;
4. os revisores, sem editar, fazem rerevisão do novo estado;
5. repetir até os revisores emitirem `PASS` sem ressalvas substantivas.

Comentários de revisor não são automaticamente verdadeiros nem
automaticamente adotados: devem ser avaliados contra as primitivas e respondidos
explicitamente.

## Non-goals

- Não editar `formal_model_v6.Rmd` ou `formal_model_v6.pdf`.
- Não editar `formal_model_v5.Rmd`; ele é referência histórica.
- Não reintroduzir feasibility/C-B-R, A/C/R nem o reconhecimento antigo que
  dava probabilidade positiva a `H` (por exemplo, `1/N`) como baseline. O
  sorteio uniforme `1/m` apenas entre weak proposers é parte obrigatória do
  baseline `pi_H=0`, não o random-recognition branch arquivado.
- Não usar `b_theta`, delayed continuation, o híbrido
  `max{o_theta,beta C_theta}` ou `t_theta=d_theta-b_theta` como payoff do voto
  não/opt-out no baseline. Uma continuação legítima após `H` votar sim e uma
  falha fraca pode conter `beta` vezes o valor de R2.
- Neste Goal, apenas segregue e rotule essas extensões ou a história
  diagnóstica; não tente rederivá-las.
- Não resolver `pi_H>0` neste Goal.
- Não criar rule-choice endógeno ou signaling da escolha da regra.
- Não chamar weak-vote-passive assessment de refinement.
- Não alegar unicidade, all-PBE characterization ou global dominance sem prova.
- Não usar working numerical illustration como empirical calibration.
- Não remover um ramo por hipótese ad hoc. Prove que não é equilíbrio,
  mantenha-o ou marque-o como pendente.
- Não otimizar a apresentação do manuscrito antes de estabilizar as provas.

## Definition of done

O Goal 1 somente está concluído quando todos os itens abaixo forem verdadeiros:

1. Gate -1 registra commit e tag de proveniência aprovados.
2. Gate 0 recebeu `PASS` de revisor independente e contém tabela exaustiva de
   históricos, payoffs, crenças e continuações.
3. O baseline usa globalmente `pi_H=0`, `b_theta=0`, payoff de acordo `y` e
   opt-out imediato `o_theta`. O threshold `y_theta^*=o_theta` foi derivado
   apenas no information set em que, dadas as estratégias fracas, `H`-yes
   implementa com certeza o acordo corrente; as demais ICs simultâneas foram
   derivadas a partir dos payoffs esperados efetivos.
4. Delayed continuation e outras arquiteturas aparecem apenas como extensões
   claramente separadas ou história diagnóstica.
5. Todos os resultados promovidos estão provados analiticamente e têm status
   fiel; checagens numéricas estão rotuladas como checagens.
6. A matriz de sobrevivência dos resultados antigos está completa.
7. Todos os scripts novos passam e receberam revisão R independente.
8. O documento autônomo compila em HTML e PDF e passa nas verificações textual
   e visual.
9. Os dois revisores formais emitiram `PASS` sem ressalvas substantivas sobre o
   mesmo estado final.
10. O relatório
    `quality_reports/2026-08-03_clean_baseline_goal1_status.md` registra
    comandos, outputs, commits, reviewers, findings, respostas, limitações e
    resultados ainda pendentes.
11. Os hashes inicial e final confirmam que `formal_model_v6.Rmd` permaneceu
    sem alterações durante o Goal.

Não marcar o Goal como completo se houver `pending protocol decision` que afete
um teorema do baseline, teste obrigatório falhando, revisor em `REPAIR`, status
de prova superestimado ou migração prematura para o manuscrito.
