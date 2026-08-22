# N4 — R1 sob unanimidade: rederivação integral sob o conceito de solução de 2026-08-21

**Status do candidato:** `pending/unfrozen`; não integrado ao DAG.  
**Emenda autoral posterior aplicada:** posterior de denominador zero restrito
ao suporte do prior; `nu=0` fixa `0` e `nu=1` fixa `1` em toda a
árvore.  
**Dependência única consumida:** os dois registros da interface congelada de
`N2`, lidos conjuntamente com a Emenda 1a/errata normativa.  
**SHA-256 da interface N2 congelada:** `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.  
**SHA-256 da Emenda 1a/errata:** `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`.  
**Proveniência composta:** a errata supersede somente a classe de crenças
endpoint; estratégias, continuações, outcomes e payoffs de N2 são invariantes.  
**Data dos payoffs:** R1; N2 é terminal e recebe exatamente um fator `beta`
ao entrar em N4.  
**Escopo:** somente N4. N3, N6, N7, DAG, freeze e manuscrito não são consumidos.

## 1. Intuição

As três regras fixadas em 2026-08-21 mudam N4 de forma decisiva.

1. Um desvio fraco não pode inventar informação sobre o tipo de `H`.
2. Um fraco vota pela comparação que valeria se seu voto decidisse.
3. Na igualdade esperada, vota `sim`.

Isso fecha as fronteiras de acordo e abre as fronteiras de veto. Mais
importante: uma proposta que paga exatamente as continuações pode **forçar**
acordo. Como `beta<1`, esse acordo vale ao proponente exatamente `1-beta`
a mais que esperar.

O resultado não é, contudo, existência universal. Para
`0<nu<=nu_star`, uma proposta factível força todos os fracos a votar
`sim`, mas o jogo de voto de `H` não possui nenhuma estratégia pura
sequencialmente racional. Como o conceito exige estratégias puras em todo
ballot, a correspondência de PBE fica vazia nessa célula.

## 2. Interface N2 e valores transportados

Defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m.
```

Como `0<o_0<o_1<1`, temos

```text
0 < nu_star < 1,   0 < B < A,   0 < ell < h.
```

Se o posterior público na entrada de N2 é `eta`, o desempate de N2 seleciona
screening quando `eta<=nu_star` e pooling quando `eta>nu_star`.
Transportados para R1, os valores são:

| Continuação N2 | valor de um fraco | payoff de `H0` | payoff de `H1` |
|---|---:|---:|---:|
| screening | `(1-eta)A` | `ell` | `h` |
| pooling | `B` | `h` | `h` |

Em particular,

```text
(1-nu_star)A = B.
```

O valor fraco corrente é

```text
D = (1-nu)A,
C = D,  se nu<=nu_star;
    B,  se nu>nu_star.
```

`C` já integra tipo e loteria de reconhecimento. O vetor realizado no ramo
screening é `(A,0)`, nunca `(A,A)`.

## 3. Crenças e comparação pivotal

Depois de qualquer proposta, inclusive uma proposta desviante, a crença
permanece `nu`: o proponente fraco não observa `theta`. Votos fracos
prescritos ou desviantes também não mudam a crença.

Se `H` vota uma ação prescrita, o posterior segue Bayes usando a estratégia
de `H`, inclusive numa subárvore alcançada por desvio fraco. Se `H` toma
uma ação fora do perfil prescrito e `0<nu<1`, a crença posterior pode ser
qualquer valor em `[0,1]`. A decisão autoral posterior restringe eventos de
denominador zero ao suporte do prior: `nu=0` fixa posterior `0` em toda a
árvore e `nu=1` fixa posterior `1` em toda a árvore.

Considere um respondente fraco `j`. No evento em que seu voto é pivotal,
todos os demais votam `sim`, inclusive `H`. Seja `eta_Y` o posterior
induzido pelo voto `sim` de `H`. Então:

```text
j vota sim  se, e somente se,  x_j >= W(eta_Y),

W(eta) = (1-eta)A, se eta<=nu_star;
         B,        se eta>nu_star.
```

Como `W(eta)` varia no intervalo fechado `[B,A]`, uma oferta
`x_j=A` força `sim` para toda crença admissível. Na igualdade,
`T^Y` força `sim`.

## 4. Classes puras de resultado

Sob unanimidade, uma aprovação exige todos os fracos e `H` em `sim`.
Logo, as classes puras possíveis são:

- `P`: aprovação pelos dois tipos;
- `L`: aprovação apenas pelo tipo baixo;
- `D`: falha em R1 e continuação para N2.

Aceitação apenas pelo tipo alto é impossível: exigiria que o baixo rejeitasse
uma oferta que o alto aceita, embora `ell<h` e a continuação do alto nunca
seja menor.

### Lema N4-1 — acordo pooling

Num ballot pooling, `H0` e `H1` votam `sim`. O posterior após `sim`
continua `nu`, e um desvio fraco para `não` também preserva `nu`.
Portanto:

```text
Y >= h,
x_j >= C para todo respondente fraco j.
```

As fronteiras são fechadas. Em `Y=h`, `H1` aceita por `T^Y`; em
`x_j=C`, o fraco aceita por `T^Y`.

### Lema N4-2 — acordo apenas com o tipo baixo

Se `0<nu<1` e `H0` vota `sim` enquanto `H1` vota `não`, o
`não` revela o tipo alto. `H0` pode imitar esse voto e obter a continuação
pooling `h`. Assim, a aceitação de `H0` exigiria `Y>=h`, enquanto o
`não` de `H1` exige `Y<h` porque a igualdade leva a `sim`.
Contradição.

A classe `L` existe apenas no endpoint `nu=0`. Nesse endpoint, a
restrição de suporte fixa posterior zero também depois da ação de probabilidade
total zero, de modo que a continuação é necessariamente screening. Suas
condições locais são

```text
ell <= Y < h,
x_j >= A (=C em nu=0) para todo j.
```

### Lema N4-3 — atraso por veto fraco e múltiplos vetos

Suponha que ao menos um fraco vote `não`. A proposta falha qualquer que seja
o voto de `H`.

- `H1` recebe `h` em toda continuação N2 e, por `T^Y`, vota `sim`.
- Se `0<nu<1` e `H0` votasse `não` enquanto `H1` vota `sim`,
  o `não` revelaria o tipo baixo e pagaria `ell`; imitar o `sim` do
  alto levaria a pooling e pagaria `h>ell`.
- Nos endpoints, ambos os votos preservam o posterior fixado pelo suporte e
  dão a mesma continuação a cada tipo; `T^Y` novamente determina `sim`.

Assim, com veto fraco, o único perfil de `H` é pooling em `sim`, o
posterior permanece `nu` e cada fraco enfrenta a continuação `C`.
Consequentemente:

```text
fraco j vota sim  iff x_j >= C;
fraco j vota não  iff x_j < C.
```

Essa é necessidade e suficiência. A região de veto é aberta: `x_j=C`
produz `sim`. Para `m>=3`, vale separadamente para cada identidade em
qualquer conjunto de múltiplos vetos. Para `m=2`, é o mesmo cutoff aberto
para o único respondente; não existe fórmula especial em `A`.

### Lema N4-4 — atraso por veto de `H`

Se todos os fracos votam `sim`, o perfil pooling em `não` pode ser
sequencialmente racional exatamente quando

```text
nu=0:               u>=A e Y<ell;
0<nu<=nu_star:      u>=B e Y<ell;
nu_star<nu<=1:      u>=B e Y<h,
```

onde `u=min_j x_j`. As desigualdades em `Y` são estritas porque `T^Y`
determina `sim` na igualdade. No interior, o voto `sim` fora do perfil
pode receber crença pooling, tornando `B` o menor cutoff possível. Em
`nu=0`, porém, o posterior continua zero e o cutoff é `A`; em `nu=1`,
o posterior continua um e o cutoff é `B`.

Todo atraso admissível — por `H` ou por fraco — preserva o posterior
corrente no vetor realizado e dá ao proponente o valor `C`.

### Lema N4-5 — completamento sequencial nos dois domínios de existência

Para demonstrar existência de PBE não basta resolver a proposta on-path: é
preciso preservar **toda** resposta pura admissível depois de cada proposta
factível. Escreva `u=min_j x_j` e ordene a estratégia de `H` como
`(ação de H0, ação de H1)`. Quando `0<nu<1` e uma ação `sim` de
`H` tem probabilidade total zero, uma crença livre `eta_Y` mantém todos
os fracos em `sim` se, e somente se,

```text
W(eta_Y) <= u.
```

Para `B<=u<A`, isso equivale a `eta_Y>=1-u/A`; para `u>=A`, vale para
toda crença. Nos endpoints não existe essa escolha: `eta_Y=0` em `nu=0`
e `eta_Y=1` em `nu=1`.

#### Correspondência completa quando `nu=0`

| Perfil de `H` | Condição necessária e suficiente | Votos fracos e crenças admissíveis |
|---|---|---|
| `(sim,sim)` | `u<A`, ou `u>=A` e `Y>=h` | O posterior é zero após ambos os votos. Se `u<A`, `j` vota `sim` iff `x_j>=A`; se `u>=A,Y>=h`, todos votam `sim`. |
| `(não,não)` | `u>=A` e `Y<ell` | O posterior é zero; todos os fracos votam `sim` e ambos os tipos preferem estritamente `não`. |
| `(sim,não)` | `u>=A` e `ell<=Y<h` | O posterior é zero após ambos os votos; todos os fracos votam `sim`, `H0` aceita e `H1` rejeita. |
| `(não,sim)` | nunca | A comparação de `H` viola preferência estrita ou `T^Y`. |

As quatro linhas são mutuamente exclusivas e exaustivas. Em particular, se
`B<=u<A` e `Y<ell`, o posterior zero fixa o cutoff em `A`, algum fraco
veta e somente `(sim,sim)` sobrevive. A antiga construção `(não,não)`
exigia `eta_Y>0` e é removida pela restrição de suporte.

#### Correspondência completa quando `nu_star<nu<1`

| Perfil de `H` | Condição necessária e suficiente | Votos fracos e crenças admissíveis |
|---|---|---|
| `(sim,sim)` | `u<B`, ou `u>=B` e `Y>=h` | Bayes dá `eta_Y=nu` e `j` vota `sim` iff `x_j>=B`; a crença após `não` fora do perfil é livre. |
| `(não,não)` | `u>=B` e `Y<h` | Todos votam `sim`; Bayes dá `eta_N=nu`; a crença após `sim` deve satisfazer `W(eta_Y)<=u`. |
| `(sim,não)` ou `(não,sim)` | nunca | Separação viola uma IC por imitação do voto do outro tipo. |

Logo o perfil puro local é único após cada proposta no interior alto, embora
as crenças livres que satisfazem as desigualdades possam ser múltiplas.

#### Correspondência completa quando `nu=1`

| Perfil de `H` | Condição necessária e suficiente | Votos fracos e crenças admissíveis |
|---|---|---|
| `(sim,sim)` | `u<B`, ou `u>=B` e `Y>=h` | O posterior é um após ambos os votos. Se `u<B`, há veto fraco; se `u>=B,Y>=h`, todos votam `sim`. |
| `(não,não)` | `u>=B` e `Y<h` | O posterior é um; todos os fracos votam `sim` e ambos os tipos preferem estritamente `não`. |
| `(sim,não)` ou `(não,sim)` | nunca | Com posterior um, ambos os tipos comparam `Y` com `h`; preferência estrita ou `T^Y` impede separação. |

O perfil puro também é único proposta a proposta no endpoint alto, e não há
multiplicidade de crenças. Desvios de proposta ou voto fraco jamais alteram
`nu`. As três tabelas são obtidas enumerando os quatro perfis de `H`, sem
selecionar uma continuação entre perfis admissíveis.

## 5. Certificado de inexistência para `0<nu<=nu_star`

Considere a proposta factível

```text
s_dagger:
  Y   = ell,
  x_j = A para cada um dos m-1 respondentes,
  r_i = Q_L = 1-ell-(m-1)A.
```

Ela usa exatamente a pie e é estritamente factível em componentes não
negativos porque

```text
Q_L-A = 1-ell-mA = 1-beta > 0.
```

Como `A` é o maior valor possível de `W(eta_Y)`, todos os fracos votam
`sim` sob qualquer uma das quatro estratégias puras de `H`. Resta
enumerá-las:

| Estratégia `(H0,H1)` | Desvio que a destrói |
|---|---|
| `(sim,sim)` | `H1` troca para `não` e obtém `h>ell` |
| `(não,não)` | a continuação corrente é screening; `H0` empata em `ell` e `T^Y` determina `sim` |
| `(sim,não)` | `H0` imita o `não` de `H1`, revela posterior 1 e obtém `h>ell` |
| `(não,sim)` | `H1` imita o `não` de `H0` e obtém `h>ell` |

Não existe quinta estratégia pura. Portanto o ballot após `s_dagger` não
possui equilíbrio puro. PBE exige racionalidade sequencial também depois de
propostas de probabilidade zero. Logo:

```text
para 0<nu<=nu_star, a correspondência de PBE com ballots puros é vazia.
```

Esse é um certificado de inexistência do jogo completo, não apenas a
eliminação de uma proposta on-path.

## 6. Equilíbrios nos endpoints e na região alta

### Proposição N4-A — `nu=0`

A proposta

```text
L_star:
  Y   = ell,
  x_j = A para todo j,
  r_i = Q_L = 1-ell-(m-1)A = A+1-beta
```

força todos os fracos em `sim`, `H0` em `sim` e `H1` em
`não`. Ela é o único ótimo on-path:

- qualquer `L` paga ao menos `ell` e `A` a cada fraco, logo
  `r_i<=Q_L`;
- pooling custa adicionalmente `h-ell>0`;
- atraso paga `C=A`, e `Q_L-A=1-beta>0`.

O vetor de payoff de `H` é `(ell,h)`. No tipo de probabilidade positiva,
a proposta passa imediatamente; não há atraso on-path.

Condicionalmente ao tipo baixo, o proponente recebe `Q_L` e cada respondente
recebe `A`. Condicionalmente ao tipo alto, a proposta falha, N2 screening é
alcançado e todos os fracos recebem zero; esse tipo tem probabilidade zero
nesta célula, mas seu vetor é mantido no registro. Antes do reconhecimento de
R1, o valor de um fraco representativo é
`[Q_L+(m-1)A]/m=(1-ell)/m` no tipo baixo e zero no tipo alto.

O Lema N4-5 completa o assessment depois de toda proposta fora do caminho.

### Proposição N4-B — `nu_star<nu<=1`

A proposta

```text
P_star:
  Y   = h,
  x_j = B para todo j,
  r_i = Q_P = 1-h-(m-1)B = B+1-beta
```

força pooling. Para ver que não há resposta alternativa:

- em `(sim,sim)`, o posterior após `sim` é `nu>nu_star`, os fracos
  aceitam `B` e ambos os tipos de `H` aceitam `h`;
- se `nu<1`, em `(sim,não)` o `sim` revela o tipo baixo, os fracos
  exigem `A>B` e vetam; `H0` imita o `não` do alto para obter
  `h>ell`. Em `(não,sim)`, os fracos aceitam e `H0` desvia para
  `sim` para receber `h>ell`;
- se `nu=1`, a restrição de suporte fixa posterior um também depois da
  ação prescrita apenas para `H0`. Em `P_star`, o cutoff fraco é
  necessariamente `B`, logo todos os fracos votam `sim`. Em
  `(sim,não)`, `H1` recebe `h` com ambos os votos e `T^Y` exige
  `sim`; em `(não,sim)`, `H0` também recebe `h` com ambos os votos e
  `T^Y` exige `sim`;
- em `(não,não)`, `H1` é indiferente entre continuações de valor `h`
  e `T^Y` determina `sim`.

Todo pooling paga ao menos `h` e `B` a cada fraco, logo
`r_i<=Q_P`. Atraso paga `C=B`, e

```text
Q_P-B = 1-h-mB = 1-beta > 0.
```

Separação é impossível para prior positivo. Portanto `P_star` é o único
ótimo on-path. O vetor de payoff de `H` é `(h,h)`, e a proposta passa
imediatamente para ambos os tipos.

Condicionalmente a qualquer tipo, o proponente recebe `Q_P`, cada respondente
recebe `B` e, antes do reconhecimento de R1, um fraco representativo recebe
`[Q_P+(m-1)B]/m=(1-h)/m`.

O Lema N4-5 completa o assessment depois de toda proposta fora do caminho.

## 7. Segurança, `m=2`, fronteiras e misturas

O valor antigo `S_3=(1-nu)B` é removido:

- em `nu=0`, a garantia relevante é `Q_L=A+1-beta>A>B`;
- em `nu>nu_star`, a garantia é `Q_P=B+1-beta>B`;
- em `0<nu<=nu_star`, não há valor escalar de segurança de um PBE puro,
  porque o ballot de `s_dagger` não tem equilíbrio puro.

O caso `m=2` obedece às mesmas três células. O antigo objeto `S_2` e seus
limiares em `A` não sobrevivem; o respondente único usa o cutoff corrente
`C`, com veto apenas para `x<C`.

Não há mistura on-path entre pooling e atraso nem entre `L` e atraso:
`1-beta>0` torna o acordo forçado estritamente melhor. Em `Y=h` e
`x=C`, `T^Y` determina acordo; uma mistura sustentada por veto na
igualdade desaparece. A multiplicidade restante de crenças off-path existe
somente quando `0<nu<1` e permanece restrita pelas ICs. Nos endpoints, o
suporte fixa uma única crença e uma única estratégia pura após cada proposta.
A identidade ex ante do proponente reconhecido também permanece explícita.

## 8. Correspondência candidata

| Célula de `nu` | Existência | Proposta on-path | Outcome | Payoff do proponente | Payoff de `H` |
|---|---|---|---|---:|---|
| `nu=0` | existe | `L_star` | acordo com tipo baixo | `A+1-beta` | `(ell,h)` |
| `0<nu<=nu_star` | não existe PBE puro | — | — | — | — |
| `nu_star<nu<=1` | existe | `P_star` | pooling imediato | `B+1-beta` | `(h,h)` |

No registro `nu=0`, o vetor fraco condicionado ao tipo é
`((Q_L,A,...,A),(0,0,...,0))`; no registro alto, é
`((Q_P,B,...,B),(Q_P,B,...,B))`. Não há atraso com probabilidade positiva,
falha terminal com probabilidade positiva nem aprovação sem `H` on-path.

## 9. Certificados e estatuto

| Objeto | Estatuto | Certificado |
|---|---|---|
| vetor fraco screening `(A,A)` | removido | N2 realiza `(A,0)` |
| piso uniforme `B` em acordo | corrigido | piso é o valor corrente `C` |
| veto em `x=C` | removido | igualdade esperada implica `sim` |
| múltiplos vetos sem limite abaixo de `nu_star` | removido | todo vetante requer `x<C=D` |
| separating com `nu>0` | inexistente | imitação do voto do outro tipo |
| `S_3=(1-nu)B` exato | removido | acordo forçado rende `C+1-beta>C` onde há PBE |
| fórmula especial `S_2` | removida | o mesmo cutoff `C` vale para `m=2` |
| mistura acordo–atraso | removida | diferença estrita `1-beta` |
| PBE puro em `0<nu<=nu_star` | inexistente | enumeração completa após `s_dagger` |

**Conclusão candidata:** o novo conceito não apenas ajusta pisos. Ele elimina
todo atraso on-path nas células em que um PBE puro existe e cria uma célula
não vazia de inexistência. N4 permanece `pending/unfrozen`; qualquer mudança
para permitir mistura no ballot seria mudança de conceito de solução e exigiria
decisão autoral separada.
