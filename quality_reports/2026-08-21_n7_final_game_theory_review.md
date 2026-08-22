# Parecer independente — N7, auditoria de teoria dos jogos

**Data:** 2026-08-21  
**Papel:** `game_theory`  
**Reviewer ID:** `codex-game-theory-n7-final-20260821`  
**Modo:** independente e read-only  
**Interface revisada:** `sha256:4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`  
**Manifesto revisado:** `sha256:a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09`

## Veredito

**PASS — 0 critical / 0 major / 0 minor**

O novo hash contém uma caracterização completa e correta dos jogos públicos,
inclusive as ações de `H` depois de toda proposta factível nos ramos de
exclusão sob maioria. Não encontrei erro matemático, estratégico, de
transporte, atomicidade, schema ou escopo.

## 1. Fronteira operacional e integridade

A revisão ocorreu exclusivamente em:

```text
/private/tmp/PowerBayesianPersuasion-essential-input-n7-fresh
```

Foram confirmados:

```text
branch = codex/essential-input-goal4-n7-fresh
HEAD   = 8813303ac37be6d5ac9f3da822c0855d34e9e349
```

O índice Git não continha modificações rastreadas. Os seis arquivos não
rastreados eram exatamente os artefatos candidatos de N7.

Todos os arquivos do manifesto passaram na verificação SHA-256. Permanecem
congelados nos hashes exigidos:

```text
N1 = 1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5
N2 = c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2
N3 = ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d
N4 = f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b
N6 = a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
```

O `verify_essential_input_n3.R` foi novamente confirmado como histórico: ele
aponta para a antiga interface `n3_r1_majority_candidate_v1.json`. O N3
corrente é certificado pelos manifestos finais e pelo verificador conjunto
`verify_essential_input_solution_concept_rederivation.R`. O script histórico
não foi editado nem usado como evidência corrente.

Não consultei a worktree de suporte, calculadora de renda, branches ou
worktrees antigas de N7, nem outputs paralelos.

## 2. Reconstrução fria dos jogos públicos

Usei:

```text
m=N-1>=3
q=floor(N/2)+1
c=1/m
w=beta/m
t_theta=beta*o_theta
C_theta=beta*(1-o_theta)/m
```

Como o tipo é público, o posterior permanece degenerado no tipo verdadeiro
depois de toda história.

### 2.1 Maioria, R2

Sendo pivotal, cada weak responder compara `x_j>=0` com zero; vota `sim`,
inclusive em `x_j=0` por `T^Y`. Os `m` votos fracos satisfazem `q<=m`, tornando
`H` não pivotal. `H` vota `não`, pois recebe `y+o_theta>y`.

A proposta única é:

```text
y=0
x_j=0 para todo j
r_i=1
```

Payoffs:

```text
proponente reconhecido = 1
cada weak antes do reconhecimento = 1/m
H = o_theta
outcome = aprovação sem H
```

Não há multiplicidade.

### 2.2 Unanimidade, R2

Cada weak responder vota `sim`. `H` vota `sim` se e somente se `y>=o_theta`,
com aceitação na igualdade. Como `1-o_theta>0`, aprovação domina estritamente
a falha.

A proposta única é:

```text
y=o_theta
x_j=0 para todo j
r_i=1-o_theta
```

Payoffs:

```text
proponente reconhecido = 1-o_theta
cada weak antes do reconhecimento = (1-o_theta)/m
H = o_theta
outcome = aprovação com H
```

### 2.3 Maioria, R1

A continuação pública de R2 gera as reservas:

```text
weak responder = w=beta/m
H = t_theta=beta*o_theta
```

Cada weak responder vota `sim` se e somente se `x_j>=w`. Se `z` denota o
número de weak nonproposers que votam `sim`, a estratégia completa de `H`,
agora corretamente presente em todos os registros, é:

```text
z>=q-1: H vota não; a proposta passa sem H
z=q-2 : H vota sim se e somente se y>=beta*o_theta
z<=q-3: H vota sim por T^Y; a proposta falha com qualquer ação sua
```

Os candidatos relevantes são:

```text
Inclusão:
J_theta=1-(q-2)beta/m-beta*o_theta.

Exclusão:
E=1-(q-1)beta/m.
```

Rejeição deliberada paga `w`, enquanto:

```text
E-w=1-beta*q/m>0.
```

E:

```text
J_theta-E=beta*(1/m-o_theta).
```

Portanto:

```text
o_theta<=1/m -> inclusão
o_theta>1/m  -> exclusão
```

Na igualdade, o desempate anti-`H` seleciona inclusão, pois
`beta*o_theta<o_theta`.

As identidades dos `q-2` ou `q-1` weak responders comprados geram
multiplicidade de estratégias. O payoff individual de um weak state pode
variar com a família de coalizões `F`, mas o payoff de `H`, o payoff do
proponente reconhecido, a média entre os weak states e o outcome são únicos
dentro da classe selecionada.

### 2.4 Unanimidade, R1

As reservas são:

```text
C_theta=beta*(1-o_theta)/m
t_theta=beta*o_theta
```

Cada weak responder aprova se e somente se `x_j>=C_theta`. Quando todos os
weak states aprovam, `H` aprova se e somente se `y>=t_theta`; se um veto fraco
torna a falha inevitável, `H` vota `sim` por `T^Y`.

A proposta única é:

```text
y=t_theta
x_j=C_theta para todo weak responder
r_i=Q_theta=C_theta+1-beta
```

Como:

```text
Q_theta-C_theta=1-beta>0,
```

aprovação imediata domina estritamente o atraso.

Payoffs:

```text
proponente reconhecido = Q_theta
cada weak responder = C_theta
cada weak antes do reconhecimento = (1-beta*o_theta)/m
H = beta*o_theta
outcome = aprovação imediata com H
```

## 3. Equivalência com os endpoints privados

Outcome e payoffs de todos os papéis coincidem com:

| Jogo público | Endpoint privado congelado |
|---|---|
| maioria R2, tipo baixo | N1 em `nu=0` |
| maioria R2, tipo alto | N1 em `nu=1` |
| unanimidade R2, tipo baixo | N2 low-type-only em `nu=0` |
| unanimidade R2, tipo alto | N2 pooling em `nu=1` |
| maioria R1, tipo baixo | N3 em `nu=0`: `S` se `o_0<=1/m`, `E` caso contrário |
| maioria R1, tipo alto | N3 em `nu=1`: `P` se `o_1<=1/m`, `E` caso contrário |
| unanimidade R1, tipo baixo | N4 `L-STAR` em `nu=0` |
| unanimidade R1, tipo alto | N4 `P-STAR` em `nu=1` |

A Emenda 1a foi respeitada: nenhum tipo fora do suporte recebe posterior
positivo. Não há discrepância de fonte compartilhada.

## 4. Transporte de N6 e rendas

Defina:

```text
a_0=(1-beta)o_0
a_1=(1-beta)o_1
d=beta(o_1-o_0)>0
k=beta*o_1-o_0
```

Os conjuntos públicos são:

```text
p_M(o)=beta*o se o<=1/m; p_M(o)=o se o>1/m

V_M_pub={(p_M(o_0),p_M(o_1))}
V_U_pub={(beta*o_0,beta*o_1)}
```

A correspondência privada de N6 foi transportada sem seleção:

```text
M-S  = (beta*o_0,beta*o_1)
M-P  = (beta*o_1,beta*o_1)
M-E  = (o_0,o_1)
M-EP = lambda*M-E+(1-lambda)*M-P

U, nu=0              = (beta*o_0,beta*o_1)
U, 0<nu<=nu_star     = vazio
U, nu_star<nu<=1     = (beta*o_1,beta*o_1)
```

As classes de maioria mantêm exatamente os cutoffs e o desempate congelados
de N6. Na fronteira residual `EP`, a mesma `lambda` liga as duas coordenadas.

### 4.1 Renda sob maioria

| Região pública | Classe privada | `RI_M` |
|---|---|---|
| `o_1<=1/m` | `S` | `(0,0)` |
| `o_1<=1/m` | `P` | `(d,0)` |
| `o_1<=1/m` | `E` | `(a_0,a_1)` |
| `o_1<=1/m` | `EP` | `lambda(a_0,a_1)+(1-lambda)(d,0)` |
| `o_0<=1/m<o_1` | `S` | `(0,-a_1)` |
| `o_0<=1/m<o_1` | `E` | `(a_0,0)` |
| `1/m<o_0` | `E` | `(0,0)` |

Os envelopes do segmento `EP` são apenas projeções coordenadas da linha exata;
não há recombinação cartesiana.

### 4.2 Renda sob unanimidade

```text
nu=0:              RI_U={(0,0)}
0<nu<=nu_star:     RI_U=vazio
nu_star<nu<=1:     RI_U={(d,0)}
```

A célula vazia preserva `RI_M` e não cria payoff sentinela.

### 4.3 Diferença das diferenças

Em `nu=0`:

```text
II -> (0,0)
IX -> (0,a_1)
XX -> (0,0)
```

Em `0<nu<=nu_star`, `DeltaRI` é vazio. Nenhuma ordenação institucional é
declarada.

Em `nu_star<nu<=1`:

| Região | Classe M | `DeltaRI` |
|---|---|---|
| II | S | `(d,0)` |
| II | P | `(0,0)` |
| II | E | `(k,-a_1)` |
| II | EP | `lambda(k,-a_1)` |
| IX | S | `(d,a_1)` |
| IX | E | `(k,0)` |
| XX | E | `(d,0)` |

Os sinais estão corretos:

- `d>0` e `a_1>0`;
- `k` é positivo, zero ou negativo conforme `beta*o_1` seja maior, igual ou
  menor que `o_0`;
- `lambda=0` preserva o ponto zero no segmento `EP`;
- em II, `E` e `EP` somente podem surgir na fronteira `o_1=1/m`; a seleção de
  `E` implica `k>0`;
- não há sinal robusto onde o conjunto é vazio.

## 5. Imagens ex ante

Com o mesmo prior `mu=nu`:

```text
Phi_mu(z)=(1-mu)z_0+mu z_1.
```

As imagens de `RI_M` são:

```text
II-S  -> 0
II-P  -> (1-mu)d
II-E  -> (1-mu)a_0+mu a_1
II-EP -> a linha entre as imagens de E e P

IX-S  -> -mu a_1
IX-E  -> (1-mu)a_0

XX-E  -> 0
```

Para `RI_U`:

```text
nu=0          -> 0
região vazia  -> vazio
região alta   -> (1-mu)d
```

Para `DeltaRI` na região alta:

```text
II-S  -> (1-mu)d
II-P  -> 0
II-E  -> (1-mu)k-mu a_1
II-EP -> lambda[(1-mu)k-mu a_1]
IX-S  -> (1-mu)d+mu a_1 > 0
IX-E  -> (1-mu)k
XX-E  -> (1-mu)d
```

No empate residual `EP`, a condição de empate torna a imagem ex ante
exatamente zero. Em `mu=1`, diferenças restritas à coordenada baixa também têm
imagem zero.

## 6. Schema, cobertura e atomicidade

A interface contém:

```text
10 registros públicos
5 registros de renda
9 células de DeltaRI, das quais 3 são none
```

Confirmei:

- partições públicas mutuamente exclusivas e exaustivas;
- regiões públicas `II`, `IX` e `XX` exaustivas;
- partição de unanimidade `nu=0`, `0<nu<=nu_star` e `nu_star<nu<=1`;
- refinamento comum de nove células para `DeltaRI`;
- IDs públicos de R1 ligados somente ao R2 da mesma regra e tipo;
- hash exato de N6 em todo registro de renda;
- nenhum registro parcial ou sentinela;
- mesma família `F` ligando coalizão e payoff individual fraco;
- mesma `lambda` ligando as duas coordenadas de `EP`;
- envelopes derivados apenas depois do conjunto exato;
- N7 permanece terminal e não altera N1–N6.

## 7. Verificações executadas

Retornaram PASS:

```text
verify_essential_input_gate0.R
verify_essential_input_solution_concept_rederivation.R
verify_essential_input_n6.R
verify_essential_input_n7.R
check_game_dag.py --require-execution-order
git diff --check
```

O verificador N7 reconstruiu 27 casos públicos dirigidos, 16 casos de
equivalência de endpoints, 18 casos de renda e sinais e rejeitou 5/5 negativos
representativos. Um deles agora rejeita diretamente a antiga estratégia
truncada de `H`. Não houve mutação exaustiva ou força bruta de schema.

## 8. Confirmação read-only e parada

Não editei, criei, removi, movi ou commitei arquivo algum. Não houve push,
merge ou tag. N7 continuava corretamente `pending/unfrozen` durante a revisão.
Este parecer não fecha Goal 4 e não autoriza Goal 5 ou qualquer alteração no
manuscrito.

**VEREDITO FINAL: PASS — 0 critical / 0 major / 0 minor.**
