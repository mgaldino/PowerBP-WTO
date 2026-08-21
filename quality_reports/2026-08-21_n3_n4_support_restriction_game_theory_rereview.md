# Parecer independente `game_theory` — única rerevisão dirigida pós-reparo

**Modo:** estritamente read-only. Nenhum arquivo foi alterado, criado, removido, formatado, staged ou commitado.  
**Worktree:** `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`.

## 1. Integridade dos bytes

O manifesto apresentou, antes e depois da auditoria, o SHA-256 esperado:

```text
d0a5a98ee7fdb9f28e778b71de5ea98657af81c849fb942dba7bce5fa548eec4
```

`shasum -a 256 -c` passou nas duas verificações para os nove candidatos:

| Artefato | SHA-256 |
|---|---|
| N3 Markdown | `75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3` |
| N3 JSON | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| N3 ledger | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` |
| N4 Markdown | `0aa31123f1bb2b785e8fbb25001b70275d91f1984c913022f0aef085b02f7b34` |
| N4 JSON | `a99b6c44463e7e347703c70c5d831f4e7b6e08eeb1cab40b00ef3e7e3def5c82` |
| N4 ledger | `13964b436efa5983dcc39fe8dee09d298a1e1421cc7ee383a7b37fbda100067b` |
| Matriz de sobrevivência | `90e2a467d38453a9cad5942da90d95e3cba9e064761b85adf44d0a3759c0577c` |
| Relatório consolidado | `ffeac731021db83906da0b9b2bedc08e694c4a581a6b30ce6ce5d5ae51bcd207` |
| Script R | `90c30f217e9c87251905ddd213a2d6ddb5207dd591692ac745c5563e4dce590c` |

## 2. Reconstrução matemática dos endpoints

Defina

```text
u   = min_j x_j,
ell = beta*o_0,
h   = beta*o_1,
A   = beta*(1-o_0)/m,
B   = beta*(1-o_1)/m.
```

### `nu=0`

A restrição de suporte impõe `eta_Y=eta_N=0` em toda história. Logo:

- o cutoff fraco é sempre `W(0)=A`;
- a continuação de `H0` é `ell`;
- a continuação de `H1` é `h`.

Cada fraco vota `sim` se e somente se `x_j>=A`.

- Se `u<A`, há veto fraco. A proposta falha sob ambos os votos de `H`; cada tipo fica indiferente e `T^Y` exige `sim`.
- Se `u>=A`, todos os fracos votam `sim`. `H0` compara `Y` com `ell`, e `H1` compara `Y` com `h`.

Portanto:

| Perfil de `H=(H0,H1)` | Condição necessária e suficiente |
|---|---|
| `(sim,sim)` | `u<A`, ou `u>=A` e `Y>=h` |
| `(não,não)` | `u>=A` e `Y<ell` |
| `(sim,não)` | `u>=A` e `ell<=Y<h` |
| `(não,sim)` | nunca |

As regiões são mutuamente exclusivas e exaustivas. Em particular,

```text
B<=u<A, Y<ell
```

contém somente `(sim,sim)` com veto fraco. O antigo `(não,não)` exigia `eta_Y>0`, agora proibido.

### `nu=1`

A restrição de suporte impõe `eta_Y=eta_N=1`. Logo:

- o cutoff fraco é sempre `W(1)=B`;
- ambos os tipos registrados de `H` têm continuação `h`.

Cada fraco vota `sim` se e somente se `x_j>=B`.

- Se `u<B`, há veto fraco; ambos os tipos de `H` ficam indiferentes e `T^Y` exige `sim`.
- Se `u>=B`, ambos comparam `Y` com `h`.

Portanto:

| Perfil de `H=(H0,H1)` | Condição necessária e suficiente |
|---|---|
| `(sim,sim)` | `u<B`, ou `u>=B` e `Y>=h` |
| `(não,não)` | `u>=B` e `Y<h` |
| `(sim,não)` | nunca |
| `(não,sim)` | nunca |

Não há crença livre nem multiplicidade de estratégia no endpoint alto.

### Fronteiras e `T^Y`

As quatro fronteiras foram tratadas corretamente:

- `x_j=A` em `nu=0` implica `sim`;
- `x_j=B` em `nu=1` implica `sim`;
- `Y=ell` leva `H0` a `sim`;
- `Y=h` leva `H1`, e em `nu=1` ambos os tipos, a `sim`.

Assim, fronteiras de acordo são fechadas e fronteiras de veto permanecem estritas.

## 3. Equilíbrios on-path

### `L_star`

Em `nu=0`:

```text
Y=ell,
x_j=A,
Q_L=A+1-beta.
```

O único perfil é `(sim,não)`. Qualquer acordo com o tipo baixo precisa pagar ao menos `ell` e `A` a cada respondente; atraso paga `A`, enquanto

```text
Q_L-A=1-beta>0.
```

Logo `L_star`, seus payoffs, accounting por tipo e unicidade on-path sobrevivem.

### `P_star`

Em `nu=1`:

```text
Y=h,
x_j=B,
Q_P=B+1-beta.
```

Todos os fracos e ambos os tipos de `H` votam `sim`. Nos perfis separadores hipotéticos, a restrição de suporte mantém o cutoff em `B`, e `T^Y` elimina o voto `não`. Qualquer pooling precisa pagar ao menos `h` e `B`; atraso paga `B`, e

```text
Q_P-B=1-beta>0.
```

Logo `P_star` e sua unicidade on-path sobrevivem.

## 4. Célula intermediária

Para `0<nu<=nu_star`, o prior tem suporte completo. A emenda endpoint não modifica crenças de denominador zero nessa célula.

Na proposta factível `s_dagger=(ell,A,...,A,Q_L)`, todos os fracos votam `sim` sob qualquer perfil de `H`. A enumeração permanece:

- `(sim,sim)` é destruído pelo desvio de `H1`;
- `(não,não)` é destruído por `H0` e `T^Y`;
- `(sim,não)` é destruído pela imitação de `H0`;
- `(não,sim)` é destruído pela imitação de `H1`.

Logo a inexistência de PBE com ballots puros em `0<nu<=nu_star` permanece provada.

## 5. Invariância econômica de N3

A restrição posterior altera somente os assessments admissíveis:

```text
nu=0 => posterior 0;
nu=1 => posterior 1;
0<nu<1 => liberdade [0,1] apenas após ação de H fora do perfil.
```

N1 é posterior-invariante. Portanto continuam inalterados:

- cutoff fraco `beta/m`;
- comparação pivotal de `H`;
- classes exclusão, screening e pooling;
- factibilidade;
- `nu_SE` e o domínio de `nu_SP`;
- desempates;
- timing de `o_theta`;
- payoffs, outcomes e multiplicidade de coalizão/proposta.

O Markdown e o JSON de N3 registram corretamente essa distinção; o ledger `N3-SC-C10` continua válido.

## 6. Auditoria das representações

| Objeto | Resultado |
|---|---|
| N3 Markdown | Regra de suporte explícita; matemática econômica preservada. |
| N3 JSON | Crenças endpoint singleton; liberdade apenas no interior; accounting atômico em `F`. |
| N3 ledger | Claims permanecem coerentes e sem expansão substantiva. |
| N4 Markdown | Três tabelas separadas — `nu=0`, interior alto e `nu=1` — são completas e corretas. |
| N4 JSON | Remove `u>=B` para `(não,não)` em `nu=0`, elimina a sobreposição e fixa `eta=0/1` nos endpoints. |
| N4 ledger | `N4-C14` e `N4-C15` refletem corretamente unicidade endpoint e suporte fixo. |
| Matriz | `SM21` e `SM23` registram remoção da sobreposição e da multiplicidade endpoint. |
| Relatório | Prova, accounting, correspondência e síntese são consistentes com os artefatos separados. |
| Script R | Implementa suporte antes de Bayes livre, elimina o antigo overlap e testa representantes de todas as regiões endpoint. |

O script passou com:

```text
MODEL_PROOF_DIRECTED: PASS
ALGEBRA_IDENTITIES: PASS
FINITE_ENUMERATION: PASS
```

Os dois JSON e o CSV passaram parsing; `git diff --check` passou. Esses testes foram usados como apoio, não como autoridade substantiva.

## 7. Escopo

A branch e o `HEAD` permanecem:

```text
codex/essential-input-solution-concept-rederive
a6fd6bd543e9cefd4166581b80565916509e95a6
```

Não há alterações tracked posteriores ao commit administrativo. O status contém apenas os candidatos e pareceres esperados. Não há arquivos de N6, N7, DAG, comparação institucional, figuras, PDF ou manuscrito no conjunto modificado. N3 e N4 continuam `pending/unfrozen`.

## 8. Findings

| ID | Severidade | Localização | Finding |
|---|---|---|---|
| — | — | — | Nenhum finding remanescente ou novo. |

Contagem:

```text
critical: 0
major:    0
minor:    0
```

# Veredito

**PASS 0/0/0**

O veredito vale exclusivamente para os nove candidatos vinculados ao manifesto SHA-256 `d0a5a98ee7fdb9f28e778b71de5ea98657af81c849fb942dba7bce5fa548eec4`. Não congela N3/N4, não integra o DAG e não autoriza nenhuma etapa posterior.
