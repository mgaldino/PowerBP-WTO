# Parecer independente de desenho formal — N7, novo ciclo

**Data:** 2026-08-21  
**Papel:** `formal_design`  
**Reviewer ID:** `codex-formal-design-n7-final-20260821`  
**Veredito:** `PASS`  
**Contagens:** critical `0` / major `0` / minor `0`

## 1. Objeto revisado

- Interface N7: `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json`
- SHA-256 da interface: `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`
- Manifesto do ciclo: `quality_reports/2026-08-21_n7_candidate_review_manifest.sha256`
- SHA-256 do manifesto: `a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09`
- Dependência N6 congelada: `model_redesign/essential_input_n6_private_comparison_candidate.json`
- SHA-256 da dependência N6: `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`
- Verificador N7: `scripts/verify_essential_input_n7.R`
- SHA-256 do verificador: `d5124b7c9f4643e31e535bf25dc92d30110e4b823f2a70ab615a1bc5f8258a6c`

Este parecer incide exclusivamente sobre o hash N7 acima e consome N6 somente
pela interface congelada de hash
`a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`.

## 2. Fronteira operacional

A revisão ocorreu exclusivamente em:

```text
/private/tmp/PowerBayesianPersuasion-essential-input-n7-fresh
branch: codex/essential-input-goal4-n7-fresh
HEAD: 8813303ac37be6d5ac9f3da822c0855d34e9e349
```

A raiz, branch e `HEAD` coincidem com a fronteira autorizada. O status mostrou
somente os seis artefatos candidatos de N7 ainda não rastreados; nenhum arquivo
rastreado estava modificado.

Não acessei worktrees ou branches N7 antigas, support-harness, calculadora de
renda ou outputs paralelos. Não deleguei trabalho e não usei subagentes.

## 3. Método independente

Refiz a revisão substantiva completa, não apenas a inspeção do reparo. O
procedimento foi:

1. reconstrução fria dos jogos públicos R2, por regra e tipo;
2. resolução de R1 consumindo apenas o R2 público da mesma regra e tipo;
3. derivação independente de estratégias, payoffs, outcomes, existência e
   multiplicidade;
4. equivalência com os endpoints privados sob restrição de suporte;
5. construção de `V_M^pub` e `V_U^pub`;
6. transporte de todos os conjuntos privados da interface N6 congelada no hash
   `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`;
7. recálculo de `RI_M`, `RI_U`, `DeltaRI`, imagens ex ante e sinais;
8. auditoria de schema, cobertura, fontes, atomicidade e isolamento terminal;
9. execução de verificadores dirigidos e de cinco negativos representativos,
   sem mutação exaustiva.

## 4. Reconstrução dos jogos públicos

Fixando o tipo público e escrevendo `o=o_theta`:

### Maioria, R2

Todo weak responder vota sim porque, quando pivotal, compara `x_j>=0` com zero;
`T^Y` seleciona sim na igualdade. Os votos fracos já atingem a quota. `H` é
não pivotal e prefere estritamente votar não, recebendo `y+o` em vez de `y`.

A proposta única é:

```text
y=0, x_j=0 para todo j, r_i=1.
```

O acordo passa sem `H`. Os payoffs são `1` para o proponente reconhecido,
`1/m` por weak state antes do reconhecimento e `o` para `H`.

### Unanimidade, R2

Os weak responders votam sim. `H` é pivotal e vota sim se e somente se
`y>=o`, com `T^Y` em `y=o`. Como `1-o>0`, a proposta única é:

```text
y=o, x_j=0 para todo j, r_i=1-o.
```

O acordo passa com `H`, que recebe `o`.

### Maioria, R1

A continuação pública de R2 produz:

```text
w=beta/m
t(o)=beta*o.
```

A estratégia completa de `H` depois de qualquer proposta é:

- com pelo menos `q-1` weak nonproposers votando sim, a proposta passa sem seu
  voto e `H` vota não;
- com exatamente `q-2`, `H` é pivotal e vota sim se e somente se
  `y>=beta*o`;
- com no máximo `q-3`, a proposta falha com qualquer voto de `H` e `T^Y`
  seleciona sim.

Os candidatos ótimos são:

```text
inclusão: J(o)=1-(q-2)beta/m-beta*o;
exclusão: E=1-(q-1)beta/m.
```

A exclusão domina estritamente a rejeição deliberada porque:

```text
E-beta/m = 1-beta*q/m > 0.
```

Além disso:

```text
J(o)-E = beta*(1/m-o).
```

Logo, `H` é incluído se `o<=1/m` e excluído se `o>1/m`. Na igualdade, o
desempate anti-`H` seleciona inclusão porque `beta*o<o`.

A multiplicidade restante é somente de identidades das coalizões fracas e de
distribuições sobre coalizões empatadas. O candidato preserva a família
atômica `F=(F_i)_i`; ela pode alterar payoffs individuais dos weak states, mas
não o payoff de `H`, o payoff do proponente reconhecido, a média fraca ou o
outcome.

### Unanimidade, R1

A continuação pública produz:

```text
C(o)=beta*(1-o)/m
t(o)=beta*o
Q(o)=C(o)+1-beta.
```

Como `Q(o)-C(o)=1-beta>0`, aprovação imediata domina estritamente o atraso. A
proposta única paga `beta*o` a `H`, `C(o)` a cada weak responder e deixa `Q(o)`
ao proponente. O acordo passa imediatamente com `H`.

Todos esses resultados coincidem com a interface candidata.

## 5. Auditoria específica do reparo

Os dois registros públicos de exclusão em R1-maioria agora contêm a estratégia
completa de `H`:

```text
theta_0:
no if at least q-1 weak nonproposers vote yes;
yes iff y>=beta*o_0 when exactly q-2 do;
yes by T^Y when at most q-3 do.

theta_1:
no if at least q-1 weak nonproposers vote yes;
yes iff y>=beta*o_1 when exactly q-2 do;
yes by T^Y when at most q-3 do.
```

Essas prescrições:

- cobrem todos os perfis possíveis do número de votos fracos;
- são mutuamente exclusivas e exaustivas;
- distinguem corretamente aprovação sem `H`, pivotalidade exata e falha
  inevitável;
- coincidem com a racionalidade sequencial usada nos registros de inclusão;
- não transformam a ação on-path de exclusão em descrição incompleta da
  estratégia.

O verificador exige as duas prescrições completas. Um dos cinco negativos
substitui a estratégia por uma frase truncada restrita ao caminho de exclusão,
e a mutação é rejeitada. Permanecem exatamente cinco negativos representativos;
não foi introduzida mutação exaustiva.

## 6. Equivalência com os endpoints

Confirmei outcome e payoffs por papel em todos os pares relevantes:

- maioria R2 pública com N1 em `nu=0` e `nu=1`;
- unanimidade R2 pública com os dois endpoints de N2, lidos com a Emenda 1a;
- maioria R1 pública com N3 em `nu=0` e `nu=1`, inclusive `o_theta=1/m`;
- unanimidade R1 pública com `N4-SC-EQ-L-STAR` em `nu=0` e
  `N4-SC-EQ-P-STAR` em `nu=1`.

A restrição de suporte é respeitada. Não há discrepância de fonte compartilhada
e, portanto, nenhum motivo para reabrir N1–N6.

## 7. Estimando e rendas

Os conjuntos públicos estão corretamente separados do modelo privado:

```text
V_M^pub = {(p_M(o_0),p_M(o_1))},

p_M(o)=beta*o se o<=1/m,
p_M(o)=o      se o>1/m;

V_U^pub = {(beta*o_0,beta*o_1)}.
```

A interface N6 congelada no hash
`a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92` é o
único input privado usado para as rendas.

Com:

```text
a_0=(1-beta)o_0
a_1=(1-beta)o_1
d=beta(o_1-o_0)
k=beta*o_1-o_0
```

as rendas de maioria conferem:

| Região pública | Classe privada | `RI_M(theta_0,theta_1)` |
|---|---|---|
| `o_1<=1/m` | `S` | `(0,0)` |
| `o_1<=1/m` | `P` | `(d,0)` |
| `o_1<=1/m` | `E` | `(a_0,a_1)` |
| `o_0<=1/m<o_1` | `S` | `(0,-a_1)` |
| `o_0<=1/m<o_1` | `E` | `(a_0,0)` |
| `1/m<o_0` | `E` | `(0,0)` |

Sob unanimidade:

```text
nu=0:                 RI_U={(0,0)};
0<nu<=nu_star:        RI_U=empty;
nu_star<nu<=1:        RI_U={(d,0)}.
```

Na célula intermediária, `RI_M` permanece preenchida, enquanto `RI_U` e
`DeltaRI` são vazios. Não há payoff sentinela nem ordenação robusta.

Na região alta:

| Região | Classe M | `DeltaRI` |
|---|---|---|
| `II` | `S` | `(d,0)` |
| `II` | `P` | `(0,0)` |
| `II` | `E` | `(k,-a_1)` |
| `IX` | `S` | `(d,a_1)` |
| `IX` | `E` | `(k,0)` |
| `XX` | `E` | `(d,0)` |

O segmento residual permanece exatamente:

```text
{lambda*(k,-a_1): lambda in [0,1]}.
```

A mesma `lambda` vincula as duas coordenadas. Os envelopes são apenas
projeções do conjunto exato e não autorizam produto cartesiano ou recombinação
marginal.

## 8. Schema, cobertura e fontes

A interface cumpre `complete_information_benchmark_v1`:

- dez registros públicos com IDs únicos;
- R2 sem continuação;
- cada R1 cita apenas e exatamente o R2 da mesma regra e tipo;
- cinco registros de renda;
- nove células de contraste, seis `exists` e três `none`;
- cobertura mutuamente exclusiva e exaustiva;
- certificados `none` completos;
- payoffs tipados por papel;
- multiplicidade das coalizões preservada atomicamente;
- `RI_M`, `RI_U` e `DeltaRI` em coleções separadas;
- imagens ex ante calculadas com `mu=nu`;
- todos os registros de renda citam exatamente o hash N6
  `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`;
- IDs e hashes de N1–N6 corretos;
- N7 como consumidor terminal, sem feedback para N1–N6.

## 9. Verificações executadas

- Manifesto N7: todos os hashes `OK`.
- Verificador N7: PASS em 27 casos públicos, 16 casos de endpoint, 18 casos de
  renda e 5/5 negativos.
- Verificador N6: PASS para a interface
  `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`,
  incluindo schema, 60 identidades, certificado `none`, atomicidade e 5/5
  negativos.
- Verificador conjunto N3/N4: PASS em reconstrução, identidades e enumeração
  finita.
- Gate 0: PASS; N1–N4 e N6 permaneciam `pass/frozen`, N7 permanecia `pending`.
- DAG com ordem de execução: `VALID`.
- `git diff --check`: sem erro.
- Hash final da interface N7 reconfirmado como
  `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`.

## 10. Findings

| Severidade | Quantidade |
|---|---:|
| Critical | 0 |
| Major | 0 |
| Minor | 0 |

Não há finding a reparar ou escalar.

## 11. Veredito

**PASS — 0 critical / 0 major / 0 minor.**

O veredito incide exatamente sobre:

```text
interface N7:
4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45

manifesto N7:
a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09

dependência N6:
a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
```

Este é somente um dos dois pareceres independentes exigidos. N7 deve
permanecer `pending/unfrozen` até o segundo parecer `PASS 0/0/0` no mesmo hash
e a integração administrativa posterior. Mesmo depois do freeze, o Goal 4 não
fecha sem aval explícito do autor. Este parecer não autoriza Goal 5, manuscrito,
push, merge ou tag.

Confirmo que trabalhei integralmente em modo read-only: não editei, criei,
removi, movi ou registrei arquivos e não fiz commit, push, merge ou tag.
