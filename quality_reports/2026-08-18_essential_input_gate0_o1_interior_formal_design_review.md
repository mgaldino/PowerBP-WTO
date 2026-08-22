# Parecer independente — Gate 0 após `o_1 < 1`

`reviewer_role=formal_design`  
`reviewer_id=review-gate0-o1-interior-formal-2026-08-18`

## Veredicto

**PASS — 0 critical / 0 major / 0 minor**

A decisão `o_1 < 1` está incorporada de forma coerente como restrição de escopo,
preserva os endpoints de crença, invalida corretamente todos os seis nós e não
autoriza `N4+`.

## Snapshot verificado ao vivo

- Branch: `codex/essential-input-o1-interior` — confirmada.
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82` — confirmado, **PASS 0/0/0**.
- DAG: `9e7c73a5444711cfaae2b2f9868b244500bd173f5214533fd897dad280c4cb76` — confirmado, **PASS 0/0/0**.
- Verifier: `c19d8d1c27261d0586ceba6aed389ebed9454f37fa6375e1210f689b00d281e1` — confirmado, **PASS 0/0/0**.
- Tag protegida, após peeling: `pre-essential-input-2026-08-12` → `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- Nenhuma modificação detectada nos artefatos protegidos examinados.

Execução:

- `Rscript --vanilla scripts/verify_essential_input_gate0.R` → `PASS`.
- Checker do DAG → `VALID`.
- Checker com `--require-execution-order` → `VALID`.
- Batches: `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`.
- Prontidão topológica atual: somente `N1`, `N2`.

Os avisos de locale do R não afetaram a execução.

## Reconstrução de `o_1 < 1` desde as primitivas

No R2 terminal sob unanimidade, quando o tipo alto é certo, a aprovação com `H`
exige, no ramo pivotal, `y >= o_1`; por `T^Y`, `y=o_1` é aceito. Como
`o_1 <= y_bar` e `o_1<1`, a proposta é factível e deixa residual estritamente
positivo:

`1-o_1 > 0`.

Logo, o proponente pode obter payoff estritamente positivo com `y=o_1`, enquanto
a falha terminal lhe paga zero. Na fronteira antiga `o_1=1`, proposta aceita e
falha rendiam zero ao proponente; propostas rejeitadas com folga podiam
sobreviver por indiferença. A nova condição remove exatamente essa degenerescência
de ganho residual nulo.

A hipótese não é necessária para definir o jogo nem para a lógica informacional
em abstrato. Ela é uma condição de escopo/regularidade necessária para garantir
ganho factível estrito mesmo no pior tipo. O contrato a apresenta dessa forma,
sem alegar que ela deriva do mecanismo.

A restrição não põe `o_1` dentro da pie: `o_theta` continua externo à
factibilidade. Tampouco altera execução integral de `y`, payoffs de exclusão sob
maioria ou timing do desacordo.

## Crenças e endpoints

A decisão correta foi restringir o payoff, não as crenças:

- `mu` permanece em `[0,1]`;
- todo posterior de entrada em `N1`–`N4` e `N6` permanece em `[0,1]`;
- `prior_mu` de `N7` permanece em `[0,1]`;
- `nu'=1` continua admissível após revelação bayesiana.

Assim, o contrato não evita o caso difícil suprimindo aprendizagem ou tipos de
probabilidade zero. Ele torna o endpoint `nu=1` economicamente não degenerado
por meio de `1-o_1>0`.

## P0–P8

- **P0:** permanece obrigação. `o_1<1` não autoriza substituir a desigualdade
  orçamentária por igualdade; apenas remove uma fonte específica de propostas
  ótimas com folga no corner excluído.
- **P1/P1a/P2:** nenhuma consequência de maioria é presumida. Hedge, aprovação
  sem `H` com `y>0` e a correspondência de `N3` continuam a exigir derivação
  desde as primitivas.
- **P3:** `N4` deve ser refeito/reavaliado no domínio interior, sem transportar
  a antiga célula `o_1=1`.
- **P4/P5:** informação, Bayes e suficiência do posterior permanecem
  inalterados; os endpoints continuam incluídos.
- **P6:** `T^Y` continua operando em `y=o_1`; a mudança não elimina
  indiferenças legítimas, apenas torna a aprovação estritamente melhor para o
  proponente no corner `nu=1`.
- **P7:** o voto de `H` e os posteriores off-path continuam integrais à análise
  de R1.
- **P8:** o benchmark público usa a mesma primitiva modificada; por isso `N7`
  também foi corretamente invalidado, embora seja terminal e permaneça fora da
  autorização corrente.

## Fonte normativa e ausência de duplicação

A fonte canônica da restrição é exclusivamente a Seção 2:

`0 < o_0 < o_1 < 1 e o_1 <= y_bar <= 1`.

O cabeçalho apenas registra a decisão e sua consequência de invalidação; a
Seção 3 explica a motivação e remete expressamente à Seção 2. Não encontrei
segunda definição, exceção ou hipótese concorrente.

`AGENTS.md` ainda contém resumos históricos de topologias anteriores, mas
declara explicitamente a prevalência integral do contrato. Portanto, isso não
cria ambiguidade normativa no snapshot auditado.

## Invalidação, DAG e autorização

A mudança é de primitiva compartilhada. A Seção 12 exige que todos os nós
retornem a `pending`; o DAG implementa isso para `N1`, `N2`, `N3`, `N4`, `N6`
e `N7`:

- todas as coleções de cobertura estão `null`;
- não há `artifact_hash`, `frozen` ou `reviews`;
- a regra `contract_change` declara invalidação dos seis nós;
- os schemas continuam atômicos e sem campos de formação;
- não há necessidade de duplicar `o_1<1` dentro dos schemas, pois o DAG aponta
  para a fonte normativa única.

A fronteira de autorização está clara:

1. após os dois novos PASS de Gate 0, `N1` e `N2` podem ser reavaliados;
2. `N3` só começa depois do novo congelamento de `N1`;
3. `N4` permanece proibido, mesmo que fique topologicamente pronto após `N2`;
4. `N6`, `N7`, Goal 2+ e migração permanecem proibidos.

O verifier distingue corretamente prontidão topológica de autorização autoral.

## Findings exatos

- Critical: nenhum.
- Major: nenhum.
- Minor: nenhum.

Nenhum arquivo foi editado pelo revisor.
