# Contrato extensivo de `A_U` sob M/S/B — reconstrução cega

**Data:** 2026-08-30
**Nó:** `A_U`  
**Status:** candidato reimplementado após decisão autoral; `pending/unfrozen`;
nova revisão independente requerida
**Método:** `solve-dynamic-games` e `formal-game-theory-polisci` governaram este
contrato, o DAG, a ordem reversa e os gates.  
**Declaração cega:** esta solução foi fechada sem acesso ao candidato antigo.

## 1. Fontes normativas e dependência congelada

| Objeto | Papel | SHA-256 |
|---|---|---|
| Gate 0 simplificado | contrato-base | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| Emenda M/S/B v2 | seleção markoviana, anonimidade da continuação, crença off-path constante | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação de anonimato | simetria só na continuação; estratégia corrente não é forçada a ser simétrica | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| Decisão em duas camadas de `A_U` | identidade formal exata e resumo econômico anônimo | `5f2e3e99c9d14a88097fca3f249ce4212564a31b1cd80902bdb4b11cca2d73ae` |
| `C_U` congelado | única continuação consumida | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |

O manifesto e os dois pareceres finais de N4 citam exatamente o mesmo hash de
`C_U`. `A_U` não rederiva, completa ou seleciona uma célula `none` de `C_U`.

## 2. Contrato da forma extensiva (Gate 0)

| Campo | Especificação | Natureza | Status/fonte |
|---|---|---|---|
| Jogadores e tipos | Um hegemon `H` e `m=N-1>=2` Estados fracos `W={1,...,m}`; `theta in {0,1}` é o tipo de `H` | primitivo | contrato-base |
| Natureza/prior | Natureza escolhe `theta`; `Pr(theta=1)=nu in [0,1]`; só `H` observa `theta` | primitivo | contrato-base |
| Horizonte | Um estágio novo `A`; aprovação termina o jogo; rejeição entra no jogo finito congelado `C_U` | primitivo | contrato-base |
| Proposta | `H` deve escolher `y=(z,(x_j)_{j in W}) in Y`; não há ação nula, renúncia ou passagem | primitivo | contrato-base |
| Espaço | `Y={z>=0,x_j>=0:z+sum_j x_j<=1}`, compacto Borel com topologia relativa | primitivo | contrato-base |
| Voto de `H` | A proposta conta como voto `sim`; `H` não vota novamente | primitivo | contrato-base |
| Ballot fraco | Todos os fracos votam `sim/não` simultaneamente e em segredo; vetor e resultado só se tornam públicos ao fechar | primitivo | contrato-base |
| Quota | Unanimidade: aprovação sse todos os `m` votos fracos são `sim` | primitivo | contrato-base |
| Informação | Fracos observam a proposta pública, não `theta` nem votos alheios; `H` conhece `theta` ao propor | primitivo | contrato-base |
| Aprovação | Na data `A`, payoffs `(z,x_1,...,x_m)`, sem desconto e independentemente do voto individual | primitivo | contrato-base |
| Rejeição | Zero pagamento em `A`; a história entra em exatamente um membro literal completo de `C_U` | primitivo | contrato-base |
| História rejeitada | Instituição `U`, estágio de entrada, proposta, proponente, vetor de votos, resultado e posterior | primitivo | contrato-base |
| Payoff dates | `A` é data 0; `C_U` está em unidades nativas de sua R1 | primitivo | contrato-base |
| Desconto | Importar payoff nativo de `C_U` para `A` aplica `beta` exatamente uma vez | primitivo | contrato-base |
| Solução | Correspondência completa de PBE; propostas de `H` são medidas Borel (puras ou mistas); votos fracos são puros | primitivo | contrato-base |
| Voto | Fraco compara `sim/não` como se fosse pivotal; `T^Y` manda `sim` na igualdade de valor esperado | primitivo | contrato-base |
| Crença disciplinada | Limite local de Bayes nas vizinhanças relativas de `Y`; o limite deve existir em todo ponto disciplinado | primitivo | contrato-base |
| Crença não disciplinada | Um único `nu_off`, constante em todos os pontos não disciplinados; respeita o suporte do prior | primitivo | cláusula B |
| Continuação | `kappa_U(h)=hat{kappa}_U(U,C,mu(h))`, Borel, pública e comum aos tipos; não depende de proposta nem vetor | primitivo | cláusula M |
| Anonimidade | `hat{kappa}_U` escolhe membro literal da classe anônima de payoffs de `C_U`; nenhuma simetria é imposta à proposta corrente | primitivo | cláusula S e clarificação |
| Seleção/refinamentos | Nenhum seletor adicional, D1, Critério Intuitivo, tremble, ação sentinela ou payoff fictício | ausente/proibido | contrato-base |

## 3. Histórias e conjuntos de informação

| História/nó | Estágio | Mover(es) | Observado | Conjunto de informação | Ações | Sucessor |
|---|---:|---|---|---|---|---|
| `a0(theta)` | `A.1` | `H` | `theta`, prior e parâmetros | singleton para cada tipo | qualquer `y in Y` | proposta pública `y` |
| `a1(j,y)` | `A.2` | todos `j in W` simultaneamente | `y`, instituição e sistema de crenças | une os dois tipos compatíveis com `y`; não distingue votos alheios | `sim/não` | vetor selado `v in {S,N}^m` |
| `a2(y,v)` | fechamento | regra mecânica | proposta e vetor completo | sem decisão | quota | terminal `A-pass` ou `C-entry` |
| `C-entry(y,v,mu)` | continuação | conforme membro congelado | estado público `phi_U=(U,C,mu)` | conforme `C_U` literal | conforme `C_U` | terminal do membro literal |

Desvios de voto fraco não sinalizam `theta`, logo o posterior de entrada em
`C_U` é o mesmo posterior associado à proposta. Um assessment só é admissível
se a continuação existe mesmo depois de qualquer vetor de votos que rejeite;
aprovação prescrita no caminho não autoriza ignorar essa história de desvio.

## 4. Interface importada e datas (Gate 4)

Defina

```text
nu_star = (o_1-o_0)/(1-o_0)
ell     = beta*o_0
h       = beta*o_1
```

O domínio existente de `C_U` é

```text
D_C = {0} union (nu_star,1].
```

Não existe membro consumível em `0<mu<=nu_star`. Para `mu=0`, o registro
literal é `N4-SC-EQ-L-STAR`; para `mu>nu_star`, é
`N4-SC-EQ-P-STAR`, com toda multiplicidade interna de assessment preservada
pelo binder do membro literal.

### Ledger de transporte

| Valor importado | Data nativa | Data corrente | Transformação | aplicações de `beta` |
|---|---:|---:|---|---:|
| payoff de `H0` em `C_U(0)`: `ell` | R1 de `C_U` | `A` | `d_0=beta*ell` | 1 |
| payoff de `H1` em `C_U(0)`: `h` | R1 de `C_U` | `A` | `d=beta*h` | 1 |
| payoff de qualquer tipo em `C_U(mu>nu_star)`: `h` | R1 de `C_U` | `A` | `d=beta*h` | 1 |
| payoff esperado de cada fraco em `C_U(0)` | R1 de `C_U` | `A` | `a=beta*(1-ell)/m` para `theta=0`; `0` para o contrafactual `theta=1` | 1 |
| payoff de cada fraco em `C_U(mu>nu_star)` | R1 de `C_U` | `A` | `b=beta*(1-h)/m` | 1 |

Assim,

```text
d_0 = beta^2 o_0
d   = beta^2 o_1
a   = beta(1-beta o_0)/m
b   = beta(1-beta o_1)/m
z_L = 1-ma = 1-beta+d_0
z_H = 1-mb = 1-beta+d
Delta = z_L-d = 1-beta-beta^2(o_1-o_0).
```

Valem `0<b<a`, `d_0<d<z_H` e `z_L<z_H`. Os dois pacotes extremos

```text
y_L=(z_L,a,...,a),
y_bar=y_H=(z_H,b,...,b)
```

pertencem a `Y` e esgotam a pie. Portanto `y_bar` está explicitamente no
domínio; não é ação sentinela nem ponto acrescentado ao espaço.

## 5. Estados suficientes e compressão (Gate 1)

| Estado | Chave | Por que suficiente | Risco evitado |
|---|---|---|---|
| `AU-PROPOSE` | `(theta,nu,N,beta,o_0,o_1)` | contém informação privada e todos os parâmetros da escolha | não fundir tipos |
| `AU-VOTE(y)` | `(y,mu(y),nu_off-status)` | proposta e posterior determinam payoff imediato, preço de voto e continuação | não condicionar voto em voto alheio |
| `AU-REJECT(mu)` | `(U,C,mu)` | cláusula M declara esta a chave da continuação | não punir por identidade da proposta/vetor |
| `CU-L` | `mu=0` | membro literal low-type-only | não usar média ex ante no lugar de payoff por tipo |
| `CU-H` | `mu in (nu_star,1]` | membro literal pooling | preservar binder completo apesar de payoff constante |
| `CU-NONE` | `mu in (0,nu_star]` | célula `none`, não estado consumível | impedir payoff fictício |

A compressão de histórias rejeitadas para `(U,C,mu)` é primitiva autoral da
cláusula M. A única compressão adicional autorizada é a arquitetura em duas
camadas: `Sig_ex_U` codifica a órbita diagonal do par de leis realizadas e
`Sum_econ_U` quocienta cada registro por nomes dos fracos. O binder completo
continua subjacente; nenhuma operação pode recombinar estratégias, crenças,
continuações ou leis de outcomes de assessments distintos.

## 6. Crenças e votos completos

Se `sigma_0,sigma_1` são as medidas Borel de proposta e
`mbar=(1-nu)sigma_0+nu sigma_1`, em cada ponto disciplinado `y` vale o limite
local de Bayes do contrato. O candidato exige simultaneamente:

1. o limite existe em todo ponto disciplinado;
2. `mu(y) in D_C` em todo ponto disciplinado;
3. em ponto não disciplinado, `mu(y)=nu_off in D_C`;
4. `nu_off=0` se `nu=0` e `nu_off=1` se `nu=1`.

O item 2 não é seleção nova: decorre de ser inadmissível qualquer assessment
que exija uma célula `none` de `C_U`.

Para cada proposta factível e cada fraco `j`, a estratégia pura completa é

```text
v_j(y)=sim  sse  x_j >= r(mu(y)),
r(0)=a,
r(mu)=b para mu>nu_star.
```

Em igualdade, `T^Y` dá `sim`. Sob unanimidade, a proposta passa sse
`min_j x_j>=r(mu(y))`. O payoff de rejeição de `H` na data `A` é

```text
D_0(0)=d_0,     D_1(0)=d,
D_0(mu)=D_1(mu)=d  para mu>nu_star.
```

## 7. Contrato da assinatura em duas camadas

Para cada binder completo `R`, a lei realizada por tipo é construída no espaço

```text
Z_U=Y x [0,1] x {0,1} x X_U x Omega_T^U,
X_U={L,P},
Omega_T^U=({A} x Y) union_disjunta ({D} x Omega_D^U),
```

onde `Omega_D^U` contém os registros terminais literais alcançáveis nos dois
representantes de `C_U`. O rótulo `L/P` identifica a célula consumida; a
multiplicidade interna de funções off-path permanece no binder e não é
rebatizada como outcome realizado.

Com `G=S_m`, a mesma permutação age sobre todas as coordenadas fracas do
registro e sobre o par inteiro `(Gamma_0^U,Gamma_1^U)`. No prior interior,

```text
Sig_ex_U(R)=(rho(R),nu_off(R),Lambda_(Gamma_0^U,Gamma_1^U)),
Sum_econ_U(R)=(rho(R),nu_off(R),(q_U)#Gamma_0^U,(q_U)#Gamma_1^U).
```

Nos endpoints, `rho` é substituído por `*`. A primeira camada preserva a
identidade formal da assinatura realizada; a segunda preserva apenas
estatísticas anônimas fatoráveis. A decisão autoral não altera o membership de
PBE do binder `R`.

## 8. Estado do contrato

```text
GAME CLASS: finito, acíclico, Bayesiano e de informação imperfeita
SOLUTION CONCEPT: PBE + voto as-if-pivotal + T^Y + M/S/B
CONTRACT STATUS: PASS para reimplementação da assinatura em duas camadas autorizada em 2026-08-30
GRAPH STATUS: ACYCLIC
TERMINAL/CONTINUATION STATES CLOSED: C_U somente, no hash declarado
ILLEGAL OR PREMATURE WORK: nenhum
NATIVE-TIME AND DISCOUNT CHECK: exatamente uma aplicação de beta ao importar C_U
BELIEF/INFORMATION-SET CHECK: posterior local; nu_off único; célula none proibida
OVERALL STATUS: candidato reimplementado, pending/unfrozen até duas novas revisões e aprovação terminal
```

Se o hash de `C_U`, o contrato-base ou qualquer cláusula M/S/B mudar, toda a
derivação, o ledger, o verificador e os consumidores de `A_U` são invalidados.
