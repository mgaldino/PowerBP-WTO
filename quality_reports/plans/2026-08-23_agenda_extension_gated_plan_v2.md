# Plano v2 — extensão de agenda informal com contrato, DAG e gates

**Status:** DRAFT PARA REVISÃO DO FABLE — não autoriza execução

**Data:** 2026-08-23

**Substitui operacionalmente:** o fluxo simplificado do rascunho
`2026-08-23_agenda_extension_todo.md`, sem apagar nem alterar aquele registro

**Objeto:** planejar a derivação, verificação, comparação e eventual migração
da extensão em que `H` propõe antes do jogo `essential-input` já congelado

**Fronteira protegida:** os nós congelados `N1`–`N4`, `N6` e `N7`, o contrato
`essential-input` e o snapshot revisado do Goal 5 permanecem byte a byte fora
do escopo deste plano

Este documento organiza uma extensão separada. Ele não altera o jogo atual,
não acrescenta `N8` ao DAG `essential-input`, não autoriza scripts, derivação,
revisão, edição do manuscrito, commit, tag, push ou qualquer mudança em
artefato congelado. Depois do feedback do Fable e dos ajustes do autor, um
Gate 0 próprio deverá transformar este plano em contrato executável.

---

## 0. Objetivo substantivo e estatuto das intuições

O jogo atual pergunta o que a informação privada de `H` vale quando apenas
Estados fracos propõem. A extensão acrescenta uma etapa anterior na qual `H`,
já informado de seu tipo, formula a primeira proposta. Se ela falha, começa
integralmente o jogo atual, sem modificação de suas primitivas, estratégias,
correspondências ou resultados.

A extensão investiga se duas fontes de poder coexistem e interagem:

1. **poder informacional:** a regra torna o voto informado substituível ou
   essencial na continuação;
2. **poder de agenda informal:** `H` usa a reserva dos votantes, determinada
   por essa continuação, ao formular a proposta inicial.

As contas de guardanapo do rascunho são **intuições disciplinadoras e
conjecturas falsificáveis**, não resultados presumidos. Elas orientam testes e
ajudam a identificar resultados surpreendentes. A matemática deve mostrar se
são verdadeiras, em quais células, com quais fronteiras e sob qual seleção. Um
resultado contrário será preservado, não reparado para recuperar a intuição.

Intuições candidatas a testar, sem estatuto de teorema:

- na célula de pooling da continuação sob unanimidade, a essencialidade futura
  de `H` reduz a reserva dos votantes fracos no estágio de agenda;
- em certas células de maioria, a ameaça de recusa dos fracos é mais forte
  porque a continuação pode excluir `H`;
- pode existir uma região na qual os dois tipos de `H` prefiram unanimidade
  quando `H` controla a proposta inicial;
- a renda informacional do tipo baixo pode ser a renda do jogo atual
  transportada mais uma rodada para trás;
- separação pode ser impossível em algumas células de unanimidade, mas pode
  surgir por falha em células de maioria;
- o payoff por quórum pode apresentar um vale, mas essa afirmação exige uma
  extensão própria para quóruns intermediários.

---

## 1. Arquitetura temporal e orientação das setas

### 1.1 Sequência do jogo

Usaremos `A` para a **jogada de agenda** de `H` e `C` para o **jogo de
continuação** já resolvido. A orientação cronológica é:

```text
A_M  ->  C_M
A_U  ->  C_U
```

- `A_M`: `H` propõe sob maioria; se a proposta falha, entra `C_M`.
- `A_U`: `H` propõe sob unanimidade; se a proposta falha, entra `C_U`.
- `C_M`: continuação privada sob maioria, consumida da interface congelada de
  `N3`.
- `C_U`: continuação privada sob unanimidade, consumida da interface congelada
  de `N4`, incluindo a disciplina vigente de suporte nos endpoints.

Essa é a ordem dos acontecimentos, não a ordem de solução.

### 1.2 Dependência da indução retroativa

Para resolver de trás para frente:

```text
C_M pass/frozen  =>  A_M pode ser resolvido
C_U pass/frozen  =>  A_U pode ser resolvido
A_M e A_U pass/frozen  =>  AC pode comparar as regras
AC pass/frozen + continuações públicas de N7  =>  AR pode calcular benchmarks e rendas
```

No manifesto JSON, portanto:

```text
A_M depends_on C_M
A_U depends_on C_U
AC  depends_on A_M, A_U
AR  depends_on AC e nas continuações públicas congeladas de N7
```

As duas representações devem aparecer juntas em todo handoff: `A -> C` para a
cronologia; `A depends_on C` para a ordem de derivação. Nenhuma seta pode ser
interpretada sem seu rótulo.

### 1.3 Extensão separada, não novo nó do DAG antigo

O DAG `essential-input` permanece fechado. A extensão terá namespace,
contrato, schemas, ledger, verifier e regra de invalidação próprios. `C_M`,
`C_U` e as continuações públicas de `N7` serão dependências externas fixadas
por caminho, ID de registro e SHA-256. Prontidão topológica não constitui
autorização para iniciar nenhum Goal.

---

## 2. Gate 0 — decisões que devem estar fechadas antes de qualquer script

O contrato da extensão deve conter uma tabela completa de forma extensiva,
conjuntos de informação, ações, transições, payoffs e datas. As decisões abaixo
precisam estar marcadas como `APPROVED` ou `pending protocol decision`; nenhuma
pode ser preenchida dentro de uma prova.

### 2.1 Primitivas herdadas sem alteração

- jogadores, tipos, prior e domínio de parâmetros do contrato atual;
- pie fixa em 1 e opção externa de `H` externa à pie;
- `b_theta = 0` no baseline;
- propostas implementadas integralmente quando aprovadas;
- falha na etapa de agenda não paga nada naquela data e leva ao jogo atual;
- ballots simultâneos e publicamente revelados somente após seu fechamento;
- `beta in (0,1)` e aplicação de desconto uma única vez entre etapas adjacentes;
- estratégias puras no ballot;
- inexistência de side payments externos ao pacote;
- jogo de formação da organização fora do escopo.

### 2.2 Pacote de solução e crenças já aprovado

O contrato da extensão deve transportar integralmente, sem voltar à formulação
superada de mera admissibilidade, o seguinte pacote:

1. **Votação as-if-pivotal dos Estados fracos:** cada respondente fraco compara
   `sim` e `não` condicionalmente ao evento em que seu voto é decisivo.
2. **`T^Y`:** na indiferença genuína em valor esperado na comparação relevante,
   o votante escolhe `sim`.
3. **No signaling what you do not know:** propostas ou votos desviantes de
   jogadores fracos, que não observam `theta`, não alteram a crença sobre o
   tipo de `H`.
4. **Consistência estrutural:** dentro de uma subárvore alcançada por desvio de
   jogador fraco, uma ação de `H` prescrita pelo perfil continua atualizando a
   crença por Bayes quando o perfil permite essa atualização. A subárvore ser
   off-path não torna livre uma crença que o comportamento prescrito de `H`
   identifica.
5. **Desvios genuínos de `H`:** depois de uma ação de `H` que nenhum tipo
   executa no perfil, a crença permanece livre no suporte permitido, salvo nova
   decisão autoral.
6. **Preservação de suporte nos endpoints:** em `nu=0`, todo posterior permanece
   zero; em `nu=1`, todo posterior permanece um; no interior, os dois tipos
   continuam disponíveis para crenças off-path admissíveis.

A proposta inicial é uma ação do jogador informado. Logo, propostas on-path de
`H` atualizam por Bayes. Propostas desviantes de `H` permanecem sob a cláusula
5. **Nenhum critério D1, Intuitive Criterion ou outro refinamento adicional é
presumido neste plano.** Se a liberdade de crenças impedir uma conclusão ou
gerar multiplicidade substantiva, o nó para e escala as alternativas ao autor.

### 2.3 Definições ainda necessárias

O Gate 0 deve decidir expressamente:

1. **Espaço de proposta de `H`:** coordenadas do pacote, factibilidade, destino
   do residual e payoff de `H` quando sua proposta é aprovada.
2. **Voto do proponente:** se `H` conta automaticamente como `sim`, como ocorre
   com o proponente fraco no jogo atual.
3. **Implementação para votantes fracos:** se o pacote inteiro é implementado
   para todos os fracos independentemente do voto individual, como no baseline.
4. **História pública:** proposta de `H`, vetor completo de votos fracos,
   resultado e posterior que entra em `C_M` ou `C_U`.
5. **Espaço de estratégias de proposta:** se propostas de `H` podem ser
   misturadas ou se a extensão restringe também o estágio de proposta a puras.
   A restrição a votos puros, sozinha, não decide isso.
6. **Seleção entre propostas ótimas de `H`:** o tie-break atual que minimiza o
   payoff de `H` é inócuo quando o próprio `H` propõe; multiplicidade não pode
   ser apagada sem nova decisão.
7. **Domínio de quórum:** o núcleo compara maioria simples com unanimidade. A
   família de quóruns intermediários permanece fora do núcleo até Goal próprio.
8. **Estimandos:** payoffs privados por tipo, contraste entre regras, benchmark
   público da extensão, renda informacional com agenda e eventual medida de
   interação entre agenda e informação.
9. **Narrativa por tipo ou ex ante:** decisão de trabalho recomendada — resultado
   principal tipo a tipo; imagem ex ante como corolário/figura secundária. A
   redação do paper aguarda ratificação final do autor.

---

## 3. Interfaces externas `C_M` e `C_U`

Antes de derivar `A_M` ou `A_U`, um Goal de consumibilidade deve verificar, sem
editar nem rederivar N3/N4, que suas interfaces congeladas permitem avaliar
todos os ramos do estágio de agenda.

Cada visão de continuação deve preservar, para cada célula e registro atômico:

- instituição e crença de entrada;
- domínio e status de existência;
- estratégia e sistema de crenças da continuação;
- payoff de `H` condicionado ao tipo realizado;
- payoff do proponente fraco e valor do fraco não proponente;
- quando necessário, payoffs dos fracos condicionados ao tipo realizado, antes
  de qualquer expectativa;
- distribuição de passagem com `H`, passagem sem `H`, falha e atraso;
- seleção ou multiplicidade admissível;
- data nativa de cada payoff;
- IDs, caminhos e hashes exatos das fontes congeladas.

Se os campos existentes forem suficientes, o Goal publica apenas uma visão de
consumo hashada e revisada. Se forem insuficientes, o trabalho para e registra
qual dimensão falta, quais cálculos ela afeta e as alternativas: reabrir a
interface produtora com autorização, ou reduzir o escopo da extensão. O nó
predecessor nunca completa localmente a continuação que deveria consumir.

### Regra contábil obrigatória

Toda condição de incentivo deve ser projeção da mesma árvore:

```text
tipo realizado + estado público + proposta + votos
-> posterior admissível
-> registro de continuação
-> outcome realizado
-> vetor de payoff de todos os jogadores
-> expectativa calculada por último
```

Um valor esperado sobre tipos nunca pode ser transportado para um ramo em que
o tipo já está fixado. A notação deve carregar instituição, tipo/estado,
outcome, papel do jogador e data sempre que essas dimensões mudarem o valor.

---

## 4. Nós novos e entregáveis

### `A_M` — agenda privada sob maioria

Consome somente `C_M` congelado. Deve caracterizar a correspondência completa
do estágio em que `H` propõe sob maioria, incluindo todas as células de
parâmetros e todas as classes de estratégia admissíveis pelo Gate 0.

### `A_U` — agenda privada sob unanimidade

Consome somente `C_U` congelado. É o nó central da extensão e recebe ciclo de
revisão exclusivo, incluindo reconstrução cega a partir do contrato e da
interface `C_U`, sem acesso prévio às fórmulas candidatas sempre que possível.

### `AC` — comparação privada com agenda

Consome `A_M` e `A_U` congelados. Preserva primeiro cada regra separadamente e
só depois forma o refinamento comum. Onde uma regra não possui equilíbrio sob o
conceito vigente, a comparação é vazia, mas a regra sobrevivente não é apagada.

### `AR` — benchmark público, rendas e interação

Consome `AC` e as continuações públicas congeladas de `N7`. Resolve o novo
estágio de agenda com `theta` público antes de calcular:

- renda informacional sob maioria com agenda;
- renda informacional sob unanimidade com agenda;
- diferença institucional das rendas;
- imagem ex ante dos vetores por tipo;
- qualquer decomposição ou interação entre agenda e informação que tenha sido
  definida no Gate 0.

O benchmark público é consumidor terminal: não pode ser usado para selecionar
ou orientar os equilíbrios privados de `A_M` e `A_U`.

### Schema mínimo dos registros de `A_M` e `A_U`

Cada registro deve conter conjuntamente:

```text
equilibrium_id
institution
admissibility_conditions
proposal_strategy_by_type
weak_voting_strategy
belief_system_on_path
belief_system_off_path
source_continuation_record_ids
source_continuation_hashes
hegemon_payoff_by_type
weak_payoffs_by_role_and_realized_type
outcome_distribution
existence_uniqueness_status
selection_status
assumptions_used
checks_performed
payoff_date
```

Payoffs, crenças, estratégias e outcomes do mesmo equilíbrio permanecem no
mesmo registro atômico. Não se combinam envelopes marginais para fabricar um
equilíbrio inexistente.

---

## 5. Obrigações de prova — conjecturas a provar ou refutar

### P0 — Suficiência das continuações

Demonstrar que `C_M` e `C_U`, com a crença de entrada e os registros atômicos,
são suficientes para todas as decisões do novo estágio. Histórias comprimidas
só podem compartilhar estado se induzirem o mesmo problema de continuação.

### P1 — Forma extensiva e payoff comum

Construir uma única função de transição e payoff para todos os jogadores.
Provar uso integral ou caracterizar propostas ótimas com folga; não impor
exaustão da pie por conveniência.

### P2 — Votos fracos no estágio de agenda

Derivar, sob as-if-pivotal e `T^Y`, o preço de cada voto fraco para cada regra,
posterior e continuação admissível. Não impor coalizão mínima antes da prova.

### P3 — Atualização após a proposta de `H`

Aplicar Bayes a propostas on-path; aplicar integralmente no restante da árvore
no-signaling-what-you-do-not-know, consistência estrutural e preservação de
suporte. Caracterizar explicitamente crenças livres após desvios genuínos de
`H`, sem introduzir D1 ou seleção não autorizada.

### P4 — Exaustividade das estratégias de proposta

Construir e testar pooling, separating, semi-pooling, mistura de propostas se
admitida, acordo imediato, proposta deliberadamente derrotada e espera. Rótulos
somente podem ser aplicados depois de derivadas as estratégias e respostas.

### P5 — Fechamento contra continuação

Comparar, tipo a tipo e regra a regra, o payoff de fechar no estágio `A` com o
payoff de entrar em `C`, convertido exatamente uma vez para a data de `A`.

### P6 — Existência, multiplicidade e seleção

Caracterizar a correspondência completa, seus endpoints, fronteiras abertas ou
fechadas, empates e possíveis segmentos. Se a regra de crenças permitir várias
avaliações com payoffs distintos, preservar o conjunto e escalar qualquer
seleção adicional.

### P7 — Lemas de não-separação

Testar separadamente por instituição e célula. Não transportar um lema de
unanimidade para maioria. Em particular, confrontar a conjectura de imitação
gratuita sob unanimidade com a possibilidade de separação por falha sob
maioria.

### P8 — Comparação institucional

Comparar as duas regras no mesmo ponto de parâmetros e apenas onde os objetos
necessários existem. Determinar por tipo, e depois ex ante, o sinal e o domínio
de qualquer preferência por unanimidade.

### P9 — Benchmark público e renda

Resolver o estágio de agenda com cada tipo público usando as mesmas primitivas,
datas, votação e tie-breaks. Só então calcular as rendas por contrafactual.

### P10 — Célula sem PBE puro herdada

Onde `C_U` é vazio sob o conceito vigente, `A_U` não pode importar um payoff ou
interpolar a lacuna. Qualquer alegação de que a etapa anterior evita alcançar a
continuação vazia precisa ser provada como parte da estratégia completa e ainda
fornecer respostas sequencialmente racionais depois de toda proposta factível.

### P11 — Quóruns intermediários

Nenhum vale no quórum será enunciado como resultado do núcleo. Se o autor o
mantiver como contribuição, um Goal `Q` separado deve rederivar a família de
continuações e estágios de agenda para `q=2,...,N`, com interfaces e revisões
próprias. A álgebra do caso de maioria simples é somente conjectura/regression
test para essa extensão.

---

## 6. Harness computacional em R

O script vem **depois** do Gate 0 aprovado e antes da formalização dos nós
novos. Ele serve para falsificação, invariantes e auditoria contábil, não para
substituir prova de equilíbrio.

### Arquivos candidatos

- `scripts/agenda_extension_transition_payoffs.R`: função comum de estados,
  transições, posterior, outcome e vetor de payoffs;
- `scripts/verify_agenda_extension_napkin.R`: varredura de candidatos,
  fronteiras e contraexemplos;
- `scripts/verify_agenda_extension_gate0.R`: contrato, DAG, schemas, hashes,
  prontidão e invalidação;
- `tests/testthat/test-agenda-extension-*.R`: invariantes permanentes.

### Invariantes mínimos

- mesma história terminal gera um único vetor de payoff para todos os
  jogadores;
- expectativa é recomposta a partir de payoffs condicionados ao tipo;
- ações fracas não alteram crença sobre `theta`;
- ações prescritas de `H` dentro de subárvore off-path obedecem à consistência
  estrutural;
- posterior respeita o suporte do prior nos endpoints;
- `beta` é aplicado uma única vez de `C` para `A`;
- pertencimento a endpoints e cutoffs usa comparação exata; tolerância só entra
  em igualdade numérica;
- cells `none` permanecem sem payoff-sentinela;
- cada registro cita IDs e hashes existentes na continuação congelada;
- fórmulas candidatas falham ruidosamente fora de seu domínio declarado.

O implementador salva o script antes de rodá-lo. Uma revisão `review-r`
independente é obrigatória, mas não substitui os dois pareceres matemáticos de
cada interface.

---

## 7. Goals, gates autorais e ordem de execução

### Preflight — somente leitura

- verificar raiz Git, branch, `HEAD`, worktree e arquivos não rastreados;
- registrar o snapshot revisado do manuscrito e os hashes vivos das interfaces
  externas;
- executar os verifiers canônicos apenas se autorizado para o Goal que será
  aberto;
- não criar tag, commit, branch, worktree ou arquivo derivado sem autorização
  correspondente.

### Goal 0 — contrato e infraestrutura da extensão

**Entregas:** contrato completo, tabela de informação, decisões do §2,
schemas, DAG próprio, ledger vazio, verifier e regra de invalidação. Todos os
nós novos permanecem `pending`.

**Gate:** dois pareceres independentes read-only `PASS 0/0/0` no mesmo hash do
contrato — desenho formal e teoria dos jogos — seguidos de GO explícito do
autor para o Goal 1.

### Goal 1 — consumibilidade de `C_M` e `C_U` + harness

**Entregas:** visões de consumo hashadas, ledger de datas/desconto, função
comum de transição/payoff, testes e relatório de contraexemplos às contas de
guardanapo. Nenhuma proposição recebe status `proved` apenas pelo script.

**Gate:** revisão R independente; revisão formal da suficiência das interfaces;
GO explícito do autor. Se faltar campo substantivo, parar e escalar.

### Goal 2 — `A_M`

**Entregas:** derivação, interface, claim ledger e verifier da agenda privada
sob maioria.

**Gate:** dois pareceres read-only `PASS 0/0/0` no mesmo hash; GO explícito do
autor para o Goal 3.

### Goal 3 — `A_U`

**Entregas:** derivação, interface, claim ledger e verifier da agenda privada
sob unanimidade.

**Tratamento especial:** ciclo exclusivo e ao menos uma reconstrução cega a
partir do contrato e de `C_U`; o revisor cego não recebe as fórmulas candidatas
antes de reconstruir o problema.

**Gate:** dois pareceres read-only `PASS 0/0/0` no mesmo hash; GO explícito do
autor para o Goal 4.

### Goal 4 — `AC`

**Entregas:** coleções privadas separadas por regra, refinamento comum,
contrastes por tipo e ex ante, multiplicidade atômica e células vazias.

**Gate:** dois pareceres read-only, incluindo auditoria de integração dos
hashes de `A_M` e `A_U`; GO explícito do autor.

### Goal 5 — `AR`

**Entregas:** jogos públicos do novo estágio, renda informacional por regra,
diferença institucional, imagem ex ante e decomposição agenda–informação apenas
se definida no Gate 0.

**Gate:** ciclo exclusivo com dois `PASS 0/0/0`; decisão autoral sobre quais
resultados entram no paper.

### Goal Q — quóruns intermediários, opcional

Só abre se o autor decidir que o vale no quórum é contribuição do paper. Deve
ser fechado antes da migração se qualquer figura ou afirmação sobre o vale for
incluída no manuscrito.

### Goal 6 — matriz de migração e manuscrito

**Entregas:** matriz literal de sobrevivência/migração, edição controlada de
`formal_model_v6.Rmd`, figuras autorizadas, PDF via YAML/bookdown, relatório de
integração e hashes exatos de Rmd/PDF.

**Gate:** revisão formal e revisão de exposição/visual por revisores que não
editaram o manuscrito. Todo reparo muda o hash e retorna às duas revisões. Sem
autorização adicional, não há commit, tag, push ou mudança de versão.

---

## 8. Revisão, findings, congelamento e invalidação

1. Implementador não revisa; revisor não edita.
2. Cada interface matemática congela apenas com dois `PASS 0/0/0` no mesmo
   SHA-256, um de desenho formal e outro de teoria dos jogos.
3. Parecer completo é salvo antes de qualquer resumo; findings não são
   truncados.
4. O default é escalar. Finding é técnico somente quando existe um único
   reparo forçado pelo texto. Ambiguidade, definição faltante, escolha de
   crença, ação, payoff, informação ou seleção é substantiva.
5. Reparo que muda bytes gera novo hash e retorna aos dois revisores do ciclo.
6. Mudança de `C_M` invalida `A_M`, `AC`, `AR` e consumidores editoriais;
   mudança de `C_U` invalida `A_U`, `AC`, `AR` e consumidores editoriais.
7. Mudança de `A_M` ou `A_U` invalida `AC`, `AR` e migração; mudança confinada
   a `AR` não reabre os jogos privados, salvo se revelar erro em fonte comum.
8. Mudança de contrato, conceito de solução, forma extensiva, schema ou
   protocolo de revisão reabre o Gate 0 da extensão.
9. Prontidão topológica é necessária, nunca autorização.
10. Validação matemática prioriza reconstrução independente, provas por ramo,
    identidades dirigidas e negativos representativos; mutação exaustiva de
    campos não substitui compreensão do jogo.

Cada claim recebe exatamente um status:
`proved`, `checked numerically`, `conjecture`, `pending` ou `rejected`.

---

## 9. Migração narrativa — somente depois dos resultados

A reorganização do paper permanece fora dos Goals de prova. Depois de `AR`
congelado e de decisão autoral:

- manter o resultado sem agenda como principal e tipo-contingente;
- apresentar a imagem ex ante apenas como objeto derivado, sem apagar os tipos;
- substituir “duas fontes que se compõem” por linguagem mais fraca se o Goal 5
  não definir e identificar uma interação formal;
- dizer exatamente em quais células a agenda altera a preferência institucional;
- não apresentar contas de guardanapo refutadas como motivação residual;
- incluir o vale no quórum somente se Goal Q fechar;
- usar Steinberg para motivar agenda informal e a assimetria informacional, sem
  transformar práticas documentadas em prova do mecanismo;
- distinguir de Stone: poder informal que contorna regras versus poder de
  agenda cujo valor é produzido pela regra formal;
- manter atemporal o texto final, sem linguagem de versões ou Goals.

---

## 10. Perguntas específicas para o Fable

O feedback solicitado ao Fable deve ser sobre este plano, não uma derivação
antecipada. Pedir que responda:

1. A forma extensiva da extensão ainda contém alguma ação, observação, payoff,
   data ou transição não decidida no §2?
2. O transporte do pacote de crenças está correto: no-signaling de ações fracas
   + consistência estrutural + liberdade após desvio genuíno de `H` + suporte
   nos endpoints?
3. O novo estágio de proposta de `H` exige um refinamento adicional de crenças
   para responder à pergunta, ou a correspondência PBE completa é suficiente?
   Se exigir, quais resultados dependem dele? Não inserir o refinamento no
   parecer; apenas escalar a necessidade.
4. `C_M` e `C_U` exportam informação suficiente para todas as ICs de `A_M` e
   `A_U`, especialmente payoffs por tipo realizado, papel e data?
5. As obrigações P0–P11 cobrem pooling, separating, semi-pooling, mistura,
   falha deliberada, espera, endpoints, off-path histories e multiplicidade?
6. A divisão `A_M`, `A_U`, `AC`, `AR` é mínima e dependency-safe? Algum nó deve
   ser dividido ou combinado?
7. O benchmark público está corretamente isolado como consumidor terminal?
8. O Goal Q deve continuar separado ou algum resultado central já exige a
   família de quóruns?
9. Que tentativa de contraexemplo faria primeiro contra cada conjectura do §0?
10. Há alguma primitiva incluída apenas para recuperar a conta de guardanapo,
    em vez de ser necessária ao mecanismo substantivo?

O parecer do Fable deve classificar findings como bloqueantes ou não
bloqueantes, transcrever o problema, apresentar leituras alternativas e
explicar a consequência de cada uma. Nenhuma sugestão do Fable altera o plano
até decisão do autor.

---

## 11. Arquivos previstos após aprovação — não autorizados agora

- `quality_reports/plans/2026-08-23_agenda_extension_gate0.md`
- `model_redesign/agenda_extension_game_dag.json`
- `model_redesign/agenda_extension_interfaces/*.json`
- `model_redesign/agenda_extension_*_derivation.md`
- `model_redesign/agenda_extension_*_claim_ledger.tsv`
- `scripts/agenda_extension_transition_payoffs.R`
- `scripts/verify_agenda_extension_gate0.R`
- `scripts/verify_agenda_extension_napkin.R`
- `tests/testthat/test-agenda-extension-*.R`
- `quality_reports/YYYY-MM-DD_agenda_extension_*_review*.md`
- `quality_reports/plans/YYYY-MM-DD_agenda_extension_migration_matrix.md`
- `formal_model_v6.Rmd`, apenas no Goal 6 autorizado
- figuras da extensão, apenas depois de resultado congelado

---

## 12. Condição de fechamento deste plano

Este DRAFT só pode ser promovido a contrato depois de:

1. feedback escrito do Fable;
2. triagem conjunta autor–Codex de cada finding;
3. decisão autoral das pendências do §2.3;
4. incorporação dos reparos autorizados;
5. dois pareceres independentes sobre o contrato final no mesmo hash;
6. GO explícito do autor para o Goal 1.

Até lá, nenhum script, nó ou texto do paper deve ser aberto como execução desta
extensão.
