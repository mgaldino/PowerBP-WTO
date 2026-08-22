# Parecer independente — Round 3 final

`reviewer_role=formal_design`  
`reviewer_id=review-n1-n2-o1-formal-2026-08-18-r3`  
Modo: read-only; nenhum arquivo editado pelo revisor.

## Veredito

| Nó | Hash candidato auditado | Critical | Major | Minor | Veredito |
|---|---|---:|---:|---:|---|
| N1 | `af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd` | 0 | 0 | 0 | **PASS** |
| N2 | `32a2989f806af20b2557fa8f495dfbe661ac951be59ee68e583fd50735e486ed` | 0 | 0 | 0 | **PASS** |

Os dois candidatos permanecem byte a byte inalterados. Não encontrei bypass
semântico, inconsistência matemática, falha de atomicidade ou problema de
lifecycle.

## Hashes e execução ao vivo

- Branch: `codex/essential-input-o1-interior`
- Contrato: `7b52f332aff353bf54a36992b0944ab3ff016a1c90e56a05e4853d26d92dab82`
- DAG: `9e7c73a5444711cfaae2b2f9868b244500bd173f5214533fd897dad280c4cb76`
- Verificador N1: `f9e5bd11b739f2ea49891d9309b059835f0609a9989357f1e64dc482cb3776f9`
- Verificador N2: `2eb997943ad68075ed021c246b80a33da5cc9a01e669480e534d2c68550c2cfe`
- Derivação N1: `18d94e73c7b3f20285847c7c422dbbb410e6f0a3dde887e7f557a470fb4684cf`
- Ledger N1: `b438312588ed8af113b6a4313bf78df625aa954abfcbf3e4b4ed795630d2b990`
- Derivação N2: `4e5e839c3d6a8186c334dde3a6484c8a29d84bfb85e72cf3b4a01bce7dc8c6fa`
- Ledger N2: `e13702a1e3f94fb2a7ea682b15cdf91befc6558497ce363b951959f71ee02049`

Execuções:

- Gate 0: PASS.
- Verificador N1: PASS, incluindo P0/P5/P6, domínio estrito, testes negativos e
  canonical-object.
- Verificador N2: PASS, incluindo fórmulas, lifecycle, fronteiras e mutações
  recursivas.
- Checker DAG: `VALID`; batches `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`;
  `Ready: N1,N2`.

Os avisos de locale do R/Perl não afetaram parsing, hashes ou exit codes.

## N1 — R2 sob maioria

### Matemática e forma extensiva

Cada weak nonproposer vota `sim`:

- se `x_j>0`, `não` é fracamente dominado;
- se `x_j=0`, as ações são payoff-idênticas em todo o information set e `T^Y`
  seleciona `sim`.

O proponente mais os demais weak states fornecem `m=N-1` votos. Para `N>=3`,
`m>=floor(N/2)+1`, de modo que `H` é não pivotal após toda proposta factível.

A comparação de `H` é corretamente:

```text
sim: y
não: y+o_theta.
```

Como `o_theta>0`, ambos os tipos votam estritamente `não`. O pacote é executado
integralmente: o voto de `H` não destrói nem devolve `y`, e `o_theta` é acionado
porque a proposta aprovada exclui `H`.

O proponente maximiza `r_i`. A solução única é:

```text
y=0, x_j=0 para todo j, r_i=1.
```

Payoffs e outcome:

- proponente reconhecido: `1`;
- weak nonproposers: `0`;
- weak state pré-reconhecimento: `1/m`;
- `H`: `(o_0,o_1)`;
- aprovação sem `H`: probabilidade 1;
- falha e delay: zero.

Não há `beta` interno. O resultado cobre `nu=0`, `nu=1` e todo o intervalo.

### Beliefs, correspondência e ledger

Bayes mantém `nu` após a proposta on-path. Após qualquer proposta de
probabilidade zero, inclusive pontos de massa zero dentro de suporte atomless,
`kappa(s)∈[0,1]` permanece arbitrária.

A correspondência possui:

- uma célula exaustiva;
- um registro conjunto e atômico;
- estratégia, outcome e payoff únicos;
- multiplicidade apenas em beliefs off-path payoff-irrelevantes;
- nenhum tie-break de proposta ativo, pois o argmax é singleton.

N1-C10 está correto: restringir `o_1` a `o_1<1` remove primitivas, mas não altera
a solução de N1, que usa apenas `o_theta>0`.

O ledger contém exatamente dez claims `proved`, todos ligados a `N1-EQ-01`,
com ramo, data R2 e evidência correspondentes.

### Mutações e resistência a bypass

O verificador ancora antes do uso:

- hash exato do candidato;
- hash exato do ledger;
- objeto canônico integral após parsing.

Cobertura executada:

- fixtures substantivas de Round 1 e Round 2: todas rejeitadas;
- substituição de todos os 3 campos superiores, 5 campos de célula, 16 campos
  de registro e 7 colunas do ledger: rejeitada;
- auditoria recursiva independente: `74/74` caminhos da interface rejeitados;
- auditoria célula a célula do TSV: `70/70` células rejeitadas.

Corrupções coordenadas também foram rejeitadas:

1. proposta, payoff, payoff de `H`, check e claim do ledger alterados em
   conjunto;
2. domínio `o_1<=1`, C10 e claim correspondente alterados conjuntamente;
3. `beta`, data de payoff e ledger alterados conjuntamente.

Também continuam rejeitados atomless restriction, Bayes contraditório,
proposer mixing, contradições em uniqueness/selection, slack, votos errados,
payoff externo descartado, continuação importada, outcome errado, freeze
prematuro e bypass por `assumptions_used`.

### Lifecycle N1

N1 continua corretamente:

```text
status=pending
interface.correspondence_cells=null
sem frozen, artifact_hash, dependency_hashes ou reviews no DAG.
```

O PASS deste parecer não congela o nó sozinho. O consumo por N3 exige os dois
pareceres independentes sobre o mesmo hash e posterior atualização do DAG.

**Findings N1:** nenhum texto a transcrever.  
**Contagem:** critical 0; major 0; minor 0.  
**Veredito estrito:** **PASS**.

## N2 — R2 sob unanimidade

### Matemática e forma extensiva

Todos os weak nonproposers votam `sim` pelas mesmas razões de
stage-undominance e `T^Y`. `H` é pivotal e aceita exatamente quando:

```text
y>=o_theta.
```

O objetivo do proponente é:

```text
y<o_0:          0
o_0<=y<o_1:    (1-nu)(1-y)
y>=o_1:         1-y.
```

Os únicos candidatos são:

```text
S(nu)=(1-nu)(1-o_0), em y=o_0
P=1-o_1, em y=o_1
nu_star=(o_1-o_0)/(1-o_0).
```

Como `0<o_0<o_1<1`, `nu_star∈(0,1)`. No cutoff, ambos maximizam antes do
tie-break, mas a oferta `y=o_0` dá payoff esperado estritamente menor a `H` que
`y=o_1`; portanto o tie-break de proposta seleciona corretamente o ramo
low-type-only.

As células são:

- `0<=nu<=nu_star`: `(y,x,r)=(o_0,0,1-o_0)`, payoff do proponente
  `(1-nu)(1-o_0)`, payoff de `H` `(o_0,o_1)`, passagem com `H` `1-nu` e falha
  `nu`;
- `nu_star<nu<=1`: `(o_1,0,1-o_1)`, payoff do proponente `1-o_1`, payoff de
  `H` `(o_1,o_1)` e passagem com `H` com probabilidade 1.

O endpoint `nu=1` é regular: `1-o_1>0`, logo pooling é estritamente superior à
rejeição. O antigo corner `o_1=1,nu=1`, com mixing ou slack degenerado, está
fora do domínio e não sobrevive.

Toda proposta ótima usa a pie integralmente. Não há passagem sem `H`, delay,
continuação importada ou `beta` interno.

### Beliefs, correspondência e ledger

As duas células são não vazias, mutuamente exclusivas e exaustivas. Cada uma
contém um registro conjunto e atômico, com proposta, ballot, payoff e outcome
únicos. A única multiplicidade admissível está nas crenças off-path irrestritas
e payoff-irrelevantes.

P0, P5 e P6 estão corretamente representados. Tipos com probabilidade zero
conservam estratégias e payoffs condicionais bem definidos. O ledger contém
exatamente doze claims atômicos, inclusive a exclusão do antigo corner.

### Mutações e resistência a bypass

O verificador ancora por hashes exatos da interface, ledger e derivação. A
interface é então comparada ao objeto canônico integral; o ledger é comparado ao
ledger esperado integral.

Cobertura executada:

- `101/101` caminhos recursivos da interface rejeitados quando alterados;
- `125/125` caminhos recursivos do ledger rejeitados;
- todas as fixtures dos Rounds 1 e 2 rejeitadas.

Corrupções coordenadas rejeitadas:

1. proposta, payoff, payoff de `H`, outcome e claim do ledger alterados em
   conjunto;
2. corner `o_1=1`, branch, assumptions, checks, uniqueness, selection e ledger
   alterados conjuntamente;
3. `beta`, payoff date e todas as datas do ledger alterados conjuntamente;
4. beliefs off-path, selection e claim do ledger alterados conjuntamente;
5. `artifact_hash` do ledger substituído por outro SHA-256 sintaticamente
   válido.

Também foram rejeitados domínio errado, payoff alto errado, passagem sem `H`,
outcome errado, continuação espúria, estratégias weak/H incompatíveis, Bayes
incorreto, restrição off-path, fronteira sem igualdade, célula degenerada extra,
mixed/slack em `nu=1`, claim antigo de corner, link para equilíbrio excluído e
freeze prematuro.

### Lifecycle N2

N2 permanece corretamente dependency-free, `pending`, com interface vazia no
DAG e sem campos de congelamento ou reviews. O ledger registra
`pending_independent_review`, enquanto os claims substantivos estão `proved`;
não há contradição entre o estado de revisão do nó e o estado epistemológico dos
claims.

**Findings N2:** nenhum texto a transcrever.  
**Contagem:** critical 0; major 0; minor 0.  
**Veredito estrito:** **PASS**.

A metodologia de design formal concentrou a revisão na necessidade e no papel
analítico das primitivas; a auditoria dinâmica verificou terminalidade, unidades
nativas, ausência de desconto interno, completude da correspondência e
disciplina do lifecycle.
