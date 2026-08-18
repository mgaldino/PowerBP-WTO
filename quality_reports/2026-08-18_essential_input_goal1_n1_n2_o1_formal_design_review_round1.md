# Parecer independente — Goal 1, primeira fronteira

`reviewer_role=formal_design`  
`reviewer_id=review-n1-n2-o1-formal-2026-08-18`

## Resultado executivo

- **N1 — hash `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`: FAIL — 0 critical / 1 major / 0 minor**
- **N2 — hash `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed`: PASS — 0 critical / 0 major / 0 minor**

O conteúdo matemático dos dois candidatos coincide com a reconstrução fria. O
FAIL de N1 decorre exclusivamente de uma mutação substantiva que escapa ao seu
verifier.

## Reconstrução independente

### N1 — R2 maioria

Stage-undominance e `T^Y` fazem todo weak nonproposer votar `sim` após qualquer
proposta. Com o voto do proponente, os `N-1` weak states satisfazem a quota de
maioria para todo `N>=3`; `H` é não pivotal.

Por execução integral:

- `H` votando `sim` recebe `y`;
- `H` votando `não` recebe `y+o_theta`.

Como `o_theta>0`, os dois tipos votam estritamente `não`. Toda proposta passa
sem `H`; o proponente maximiza `r_i`, obtendo o argmax único:

`y=0`, todos os `x_j=0`, `r_i=1`.

Logo:

- payoff do proponente reconhecido: `1`;
- valor fraco pré-reconhecimento: `1/m`;
- payoff de `H`: `(o_0,o_1)`;
- `pass_without_hegemon=1`;
- sem falha, delay ou `beta`.

Essa solução vale para `nu=0`, `nu=1` e todo interior.

### N2 — R2 unanimidade

Todos os weak nonproposers votam `sim`; `H` é pivotal e o tipo `theta` aceita
exatamente quando `y>=o_theta`, inclusive na igualdade por `T^Y`.

Os únicos candidatos ótimos são:

- low-type-only: `y=o_0`, payoff do proponente `(1-nu)(1-o_0)`;
- pooling: `y=o_1`, payoff `1-o_1`.

O cutoff é:

`nu_star=(o_1-o_0)/(1-o_0)`, com `0<nu_star<1`.

A proposta low-type-only vence para `nu<nu_star`; na igualdade, o tie-break de
proposta seleciona `y=o_0`, pois minimiza o payoff esperado de `H`. Pooling
vence para `nu>nu_star`.

Assim:

- low-type-only: `0<=nu<=nu_star`;
- pooling: `nu_star<nu<=1`.

Com `o_1<1`, em `nu=1` pooling rende `1-o_1>0` e domina estritamente toda
proposta rejeitada ou com folga. O antigo corner `o_1=1,nu=1` desaparece.

## Auditoria de N1

O candidato satisfaz:

- P0: proposta única e uso integral da pie;
- P5: posterior suficiente, sem restrição Markov;
- P6: weak `sim` após toda proposta, distinguindo dominância de `T^Y`;
- execução integral de `y`;
- payoff correto `y+o_theta` quando `H` não pivotal vota `não`;
- cobertura integral de `[0,1]`;
- ausência de `beta` interno;
- schema atômico e fontes de continuação vazias;
- ledger com dez claims `proved`;
- lifecycle `pending`, sem hash/reviews/frozen no DAG.

### Finding N1-M01 — major

> “O verifier de N1 aceita sistemas de crenças internamente contraditórios e
> pode certificar uma restrição não autorizada sobre propostas de probabilidade
> zero dentro de suporte atomless.”

Em `scripts/verify_essential_input_n1.R`, as crenças são validadas por
substrings:

- `grepl("=nu by Bayes", ...)`;
- `grepl("arbitrary kappa(s) in [0,1]", ...)`.

Duas mutações apenas em memória preservaram essas substrings, mas acrescentaram
afirmações incompatíveis:

1. restringir `kappa(s)` somente a propostas fora do suporte topológico e impor
   `nu` a pontos de massa zero dentro de suporte atomless;
2. afirmar Bayes `=nu` e em seguida mandar atualizar o posterior on-path para
   `1`.

Resultados:

- `ATOMLESS_RESTRICTION_REJECTED=FALSE`;
- `CONTRADICTORY_ONPATH_BAYES_REJECTED=FALSE`.

A interface atual contém a formulação correta e ampla —
`arbitrary kappa(s) in [0,1]` —, mas o gate aceita futuras mutações que alteram
a correspondência completa de assessments. Isso viola a liberdade off-path da
Seção 5 e a atomicidade/completude da Seção 7.2. Por ser uma corrupção
substantiva de beliefs que recebe falso PASS, classifico como **major**.

## Auditoria de N2

O candidato satisfaz:

- P0, inclusive o argumento de ganho estrito sob `o_1<1`;
- P5 e simetria por identidade;
- P6 e limiares de `H`;
- cutoff interior, igualdade e tie-break;
- endpoints `nu=0` e `nu=1`;
- exclusão completa do corner antigo;
- cobertura mutuamente exclusiva e exaustiva;
- payoffs e outcomes corretos por célula;
- passagem sem `H=0`, delay `=0`;
- ausência de `beta`;
- registros atômicos, fontes vazias e ledger integralmente `proved`;
- lifecycle `pending`.

O verifier rejeitou ao vivo mutações de domínio, retorno a `o_1<=1`, payoff
alto de `H`, passagem sem `H`, massa de falha, continuação espúria, `beta` em
R2, estratégias fraca e hegemônica, crenças on-path e off-path, fronteira
aberta no lado errado, reintrodução do corner, claim `pending` e congelamento
prematuro. A mutação atomless equivalente também foi rejeitada.

**Findings N2:** nenhum.

## Execução e lifecycle

- Gate 0 verifier: `PASS`.
- N1 verifier ordinário: `PASS`, hash confirmado.
- N2 verifier: `PASS`, hash confirmado.
- Checker `--candidate N1 N2`: `VALID`.
- Batches: `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`.
- DAG: N1 e N2 continuam `pending`, sem `frozen`, `artifact_hash` ou `reviews`,
  e com interface compartilhada ainda `null`.

Nenhum arquivo foi editado pelo revisor.
