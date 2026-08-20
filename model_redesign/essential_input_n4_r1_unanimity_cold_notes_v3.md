# N4 v3 — notas frias da rederivação de R1 sob unanimidade

**Nó:** `N4`
**Status:** notas frias seláveis; nenhum candidato publicado por este arquivo
**Fonte normativa:** contrato Gate 0, especialmente Seções 2, 4--6 e P3--P7
**Única dependência:** N2 congelado em
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
**Oracle independente:** `scripts/oracle_essential_input_n4_v3.R`

Estas notas foram derivadas sem abrir artefatos N4 v1/v2. Nenhuma fórmula de
security, família ou endpoint anterior foi usada como objetivo. Os três
assessments adversariais especificados na autorização autoral entram somente
como testes do oracle depois da construção do problema vetorial.

## 1. Estado, notação e contabilidade importada de N2

Há `m` weak states, dos quais um propõe e `m-1` votam. O ballot de R1 contém
`m` votos simultâneos e selados: primeiro o voto de H na representação do
oracle e depois um voto de cada weak responder. Sob unanimidade, a proposta
passa se e somente se todos esses `m` votos forem `yes`; o proponente já conta
como `yes`.

Defina, apenas como abreviações derivadas,

```text
nu_star = (o1-o0)/(1-o0),
ell     = beta*o0,
h       = beta*o1,
A       = beta*(1-o0)/m,
B       = beta*(1-o1)/m.
```

Tem-se `0<B<A`, `0<ell<h<beta<1` e `0<nu_star<1`. Uma história de falha em
R1 chama exatamente um dos dois registros de N2:

| registro N2 | posterior admissível | weak: valor subjetivo em R1 | weak: payoff realizado por tipo | H por tipo |
|---|---|---|---|---|
| low-type-only | `0<=eta<=nu_star` | `A*(1-eta)` | `(A,0)` | `(ell,h)` |
| pooling | `nu_star<eta<=1` | `B` | `(B,B)` | `(h,h)` |

Esta tabela separa três objetos. O valor subjetivo disciplina o voto de um
weak responder. O vetor realizado disciplina o desvio do proponente, que usa
o prior verdadeiro pré-proposta. O vetor de H disciplina sua melhor resposta
por tipo. Transportar `A*(1-eta)` como payoff realizado do tipo alto seria
contabilidade incorreta.

## 2. Oracle do ballot completo

Para cada proposta `s=(y,x,r)` e cada vetor de votos que falha, o assessment
publica um posterior `eta(v)` e, por consequência, um dos dois registros de
N2. O oracle exige todas as `2^m-1` continuações; não aceita somente os vetores
realizados.

### 2.1 Weak responder

Fixe um responder `j`. Para cada perfil completo dos outros votos, inclusive o
voto de H, o oracle compara:

```text
se j=yes e todos votam yes: x_j;
se a proposta falha:        beta*C_j(v), isto é, o valor subjetivo da tabela;
se j=no:                    a continuação do vetor público com j=no.
```

Uma ação é eliminada quando a outra paga pelo menos o mesmo em todos os
`2^(m-1)` perfis dos demais e mais em algum. Depois, o oracle intersecta as
ações não dominadas com as melhores respostas sequenciais no perfil prescrito.
`T^Y` seleciona `yes` somente se `yes` e `no` ainda sobreviverem e forem
empatadas no information set. Uma ação `yes` já eliminada por dominância não é
reintroduzida por uma igualdade no perfil efetivo.

### 2.2 H

Stage-undominance não se aplica a H. Dado o vetor puro prescrito dos weak
responders, cada tipo compara seus dois votos. Se todos os weak responders
votam `yes`, H compara `y` com sua continuação após `no`. Se existe veto weak,
as duas ações levam a R2 e H compara os dois registros associados aos vetores
públicos. Igualdade genuína seleciona `yes`.

Duas consequências são imediatas:

1. H de tipo alto vota `yes` sempre que há veto weak, pois todos os registros
   de N2 lhe pagam `h` e `T^Y` resolve a igualdade.
2. Com veto weak, H de tipo baixo só pode votar `no` se `H=yes` levar a
   low-type-only e `H=no` levar a pooling. Em todos os demais pares, vota
   `yes`.

### 2.3 Bayes e payoff do proponente

Numa proposta on-path, o weak proposer não observa o tipo e a crença de ballot
é `nu`. Todo vetor de falha com probabilidade positiva recebe o posterior de
Bayes. Vetores zero-probabilidade permanecem livres. Numa proposta
zero-probabilidade, todos os vetores subsequentes também são zero-probabilidade
e seus posteriores podem ser escolhidos separadamente em `[0,1]`.

O proponente não usa a crença arbitrária do ballot para avaliar um desvio. Se o
tipo `theta` gera falha no vetor `v`, seu payoff é a coordenada realizada da
tabela de N2. O oracle aplica o prior verdadeiro `nu` a essas duas coordenadas.

## 3. Classificação dos perfis on-path

Weak actions não podem depender de `theta`. Se todos os weak responders votam
`yes`, há quatro perfis candidatos de H:

- **pooling passage:** ambos dizem `yes`; requer `y>=h`;
- **low-type-only passage:** H0 diz `yes` e H1 diz `no`;
- **high-type-only passage:** H0 diz `no` e H1 diz `yes`;
- **H-veto delay:** ambos dizem `no`.

Para `0<nu<1`, low-type-only não é sequencialmente racional. A falha de H1
tem posterior um e chama pooling em N2. Se H0 imitasse esse `no`, obteria `h`;
portanto H0 só aceitaria com `y>=h`, incompatível com o `no` de H1. Em `nu=0`,
a história de H1 é zero-probabilidade e pode chamar low-type-only; então
low-type-only existe exatamente para

```text
nu=0 e ell<=y<h.
```

High-type-only exigiria simultaneamente `y<ell` para H0 rejeitar e `y>=h`
para H1 aceitar. Nunca existe.

H-veto delay existe com todos os weak responders em `yes` quando

```text
0<=nu<=nu_star: y<ell,
nu_star<nu<=1:  y<h.
```

Se ao menos um weak responder veta, a proposta falha qualquer que seja H. H1
usa `T^Y=yes`. Um perfil separating de H violaria Bayes: para prior interior,
o vetor de H0 chamaria low-type-only e o vetor de H1 chamaria pooling, fazendo
H0 preferir imitar `yes`. Nos endpoints do prior, o tipo positivo também fixa
uma continuação que impede `no` estrito de H0. Logo todo delay por veto weak
tem H0=H1=`yes`.

Assim, as únicas classes on-path são:

```text
P: pooling passage, para todo nu;
L: low-type-only passage, somente nu=0;
D: delay, implementado por H-veto ou por um ou mais vetos weak.
```

## 4. Condições exatas dos weak responders on-path

### 4.1 Pooling e low-type-only

Nos dois ramos de passagem, escolha pooling em todo vetor de falha usado para
disciplinar um weak responder. O piso sustentável é

```text
x_j>=B para todo weak responder j.
```

Em `x_j=B`, os payoffs podem ser idênticos em todos os perfis e `T^Y` seleciona
`yes`. A desigualdade estrita `x_j>A` aparece somente no problema de garantia
contra toda punição off-path; ela não é necessária para a existência de uma
avaliação de passagem.

### 4.2 H-veto delay

Quando todos os weak responders votam `yes`, o valor on-path do weak state é

```text
C(nu) = D(nu)=(1-nu)*A, se nu<=nu_star;
        B,                  se nu>nu_star.
```

Para `m=2`, não há outro perfil weak que crie uma linha cruzada. Portanto:

```text
m=2 e nu<nu_star:  x>=0;
m=2 e nu>=nu_star: x>=B.
```

Na primeira região, `C(nu)>B` permite tornar `yes` estritamente melhor contra
`H=no`. Na fronteira e acima dela, `C(nu)=B` é o piso global; se `x<B`, `no`
domina fracamente `yes` pela linha `H=yes`.

Para `m>=3`, um perfil contrafactual com outro veto weak permite cruzar as
comparações de continuação. H-veto delay pode ser sustentado para todo vetor
factível `x>=0`.

### 4.3 Delay por veto weak

Se há exatamente um veto weak `k`, ele é pivotal contra `H=yes`. Sua condição
exata é

```text
x_k<=C(nu).
```

Em igualdade, `yes` pode ser eliminado por uma linha estrita contra `H=no`, e
`no` sobrevive. Todos os demais weak responders podem ser mantidos em `yes`.

Se existem pelo menos dois vetos weak, a troca unilateral de qualquer veto
ainda deixa a proposta rejeitada. Continuações zero-probabilidade podem tornar
`no` estritamente melhor no perfil prescrito e impedir dominância por `yes`,
independentemente do tamanho de `x_k`. Portanto, para `m>=3`, qualquer conjunto
de vetos com cardinalidade ao menos dois é sustentável para toda proposta
factível. Identidades não podem ser apagadas do assessment fonte.

## 5. Security do proponente para `m>=3`

Considere uma proposta zero-probabilidade. Prescreva todos os `m-1>=2` weak
responders em `no`, H0 em `no` e H1 em `yes`. Use pooling no vetor realizado
por H0 e low-type-only no vetor realizado por H1. H0 prefere estritamente
`no`; H1 usa `T^Y=yes`.

Para demonstrar simultaneamente os votos weak, faça o valor de continuação nos
vetores com `H=yes` crescer estritamente com o número de vetos, de `B` até `A`.
Uma troca unilateral no perfil de todos os vetos reduz esse valor. Nos vetores
com `H=no`, pooling mantém valor `B`. Com crença de ballot off-path igual a um,
cada `no` é uma melhor resposta e permanece não dominado, mesmo quando `x_j` é
grande. O payoff realizado do proponente é

```text
theta=0: B;
theta=1: 0;
ex ante: S_3(nu)=(1-nu)*B.
```

Este castigo vale para qualquer proposta. Reciprocamente, a proposta `y=0`
garante pelo menos `(1-nu)B`: com todos os weak em `yes`, ambos os tipos de H
rejeitam; com veto weak, a proposta também falha. Em toda falha, a coordenada
realizada de um weak state é pelo menos `B` no tipo baixo e pelo menos zero no
tipo alto. Logo

```text
m>=3: S_3(nu)=(1-nu)*B,
```

e o valor é atingido. Nenhuma proposta força passagem quando há dois ou mais
weak responders, pois vetos coordenados sobrevivem ao refinamento dinâmico.

## 6. Security do proponente para `m=2`

Agora há um único weak responder. Escreva seu pagamento como `x`.

### 6.1 Três regiões de `x`

**Se `x<A`:** é possível prescrever W=`no`, H0=`no`, H1=`yes`, com
low-type-only no vetor `H=yes,W=no` e pooling em `H=no,W=no` e
`H=no,W=yes`. `No` domina fracamente `yes` para W. O proponente recebe
`(B,0)` e, portanto, `(1-nu)B`.

**Se `x=A`:** a punição separating anterior transforma todas as linhas de W
em igualdade e `T^Y` seleciona `yes`; ela deixa de ser admissível. Ainda se
pode obter falha comum low-type-only, com payoff
`D(nu)=(1-nu)A`, ou falha comum pooling, com payoff `B`. A garantia exata neste
ponto é

```text
R_0(nu)=min{D(nu),B}.
```

**Se `x>A`:** W=`no` não é sequencialmente racional em nenhum dos perfis
possíveis de H. W é forçado a `yes`. Restam três faixas de `y`:

```text
y<ell:       ambos os tipos rejeitam; pior payoff min{D,B};
ell<=y<h:    low-type-only paga (1-nu)*r, ou rejeição pooling paga B;
y>=h:        pooling passa e paga r.
```

Defina

```text
Q_L = 1-ell-A > 0,
Q_P = 1-h-A,
R_L(nu) = min{(1-nu)*Q_L,B},
R_P     = max{0,Q_P}.
```

`Q_L>0` segue de
`1-beta*(1+o0)/2 > (1-o0)/2 > 0`. Como `x>A` é estrito, `R_P>0` é sempre
supremo não atingido. Para `nu<1`, `R_L` é atingido exatamente quando
`(1-nu)Q_L>B`; se a capacidade é menor ou igual a `B`, é apenas supremo. Em
`nu=1`, seu valor zero é atingido trivialmente.

O security correto é o supremo

```text
S_2(nu)=max{R_0(nu),R_L(nu),R_P}.
```

O uso de supremo é substantivo: substituir `x>A` por `x=A` reabre o veto weak
e não força a aprovação.

### 6.2 Testemunhas de empate para o tie-break da proposta

`R_0` é sempre atingido. Se `D<B`, sua única forma de manter o payoff em `D`
usa falha comum low-type-only e dá a H

```text
H_L(nu)=(1-nu)*ell+nu*h < h, para nu<1.
```

Se `B<=D`, pode-se usar falha comum pooling e dar `h` a H. `R_L=B` atingido
pode ser implementado com rejeição pooling e também dá `h`. `R_P>0` nunca é
atingido. Portanto, entre desvios que atingem `S_2`, o menor payoff esperado
inevitável de H é

```text
H_tie(nu) =
  H_L(nu), se S_2=R_0=D<B;
  h,       se algum componente atingido igual a S_2 e o caso anterior falha;
  +infty,  se somente componentes não atingidos alcançam o supremo S_2.
```

Essa função decide somente o tie-break entre propostas; não seleciona uma
continuação ou um equilíbrio por fora do assessment.

## 7. Famílias puras completas

### 7.1 Pooling `P`

Para `m>=3`, use `S=S_3`; para `m=2`, use `S=S_2`. Uma avaliação pooling pura
é parametrizada por

```text
h<=Y<=y_bar,
x_j>=B para todo j,
r>=S,
Y+sum_j x_j+r<=1.
```

Folga é permitida. Aumentar apenas `r` cria outra proposta, cuja resposta
off-path pode mudar; P0 não autoriza substituir a desigualdade factível por
igualdade.

Se `m>=3` e `r=S_3`, o desvio que atinge security dá `h` a H. Logo o tie-break
permite o endpoint somente em `Y=h`. Para `m=2` e `r=S_2`, o endpoint exige
`Y<=H_tie`: é impossível quando `H_tie<h`, exige `Y=h` quando `H_tie=h` e não
impõe restrição adicional quando `H_tie=+infty`. Para `r>S`, todo `Y` factível
é permitido.

### 7.2 Low-type-only `L`

Existe somente em `nu=0` e é parametrizado por

```text
ell<=Y<h,
x_j>=B para todo j,
r>=S,
Y+sum_j x_j+r<=1.
```

O payoff de H por tipo é `(Y,h)`. No endpoint `r=S`, esse ramo dá a H menos que
o witness de security pooling; portanto o tie-break não o elimina.

### 7.3 Delay `D`

O payoff do proponente e o valor de cada weak state antes do novo sorteio são

```text
C(nu) = D(nu), se nu<=nu_star;
        B,     se nu>nu_star.
```

O payoff de H por tipo é `(ell,h)` na primeira região e `(h,h)` na segunda.
Para `m>=3`, `C(nu)>S_3(nu)` em toda a região admissível; delay existe para
todo prior. Para `m=2`, delay existe se e somente se

```text
C(nu)>=S_2(nu).
```

Em `nu<=nu_star`, isso equivale a `D(nu)>=R_P`, pois `D>=B` e os demais
componentes de security não excedem `B`. Em `nu>nu_star`, equivale a
`R_P<=B`.

As implementações puras são:

1. **H-veto:** todos os weak responders dizem `yes`; ambos os tipos de H dizem
   `no`; os limites de `y` estão na Seção 3 e os limites de `x` na Seção 4.2.
2. **Veto weak único:** H diz `yes` nos dois tipos; exatamente um weak `k` diz
   `no`; `x_k<=C(nu)`.
3. **Vários vetos weak:** somente para `m>=3`; H diz `yes` nos dois tipos;
   qualquer conjunto de ao menos dois weak responders diz `no`; não há limite
   adicional sobre seus pagamentos além da factibilidade.

Todos os pacotes factíveis que satisfazem essas condições são preservados.

## 8. Inexistência e exaustividade

- high-type-only nunca existe;
- low-type-only não existe para `nu>0`;
- H separating com veto weak nunca existe on-path;
- para `m=2`, delay não existe quando `C(nu)<S_2(nu)`;
- pooling existe para todo prior e todo vetor admissível de primitivas;
- para `m>=3`, delay existe para todo prior.

Cada inexistência decorre de melhor resposta, Bayes ou desvio do proponente,
não de seleção ad hoc. Como pooling sempre existe, a correspondência total de
N4 nunca é vazia; as regiões sem uma família são certificadas no ledger, não
representadas como um equilíbrio-sentinela.

## 9. Identidades, convenções e misturas

As estratégias e crenças podem condicionar na identidade reconhecida. Para
cada proposer `i`, escolha qualquer família pura admissível e seu pacote. Não
há desvio que transforme `i` em outro proposer. Logo todas as combinações por
identidade são preservadas, sem impor simetria.

Se `R_i` é o payoff do proposer `i` quando reconhecido e `w_ik` é o payoff do
weak state `k` quando `i!=k` propõe, o valor pré-reconhecimento de cada weak
state é o vetor executável

```text
V_Wk = (R_k + sum_{i!=k} w_ik)/m,
```

onde `w_ik=x_ik` em P e em L (`nu=0`) e `w_ik=C(nu)` em D. O payoff de H e as
distribuições de outcome são a média uniforme sobre as identidades proponentes
dos respectivos vetores de cada ramo.

O ballot permanece puro. Mistura do proposer só pode ter suporte em propostas
que empatam em seu payoff e também minimizam o payoff esperado de H entre os
maximizadores. As únicas misturas cross-branch são:

```text
nu=0:       L com Y=ell e r=A misturada com D;
nu>nu_star: P com Y=h e r=B misturada com D.
```

As probabilidades são arbitrárias dentro do assessment; nenhuma distribuição
sobre equilíbrios é criada. Todo suporte das duas misturas dá exatamente o
mesmo vetor de payoff de H, `(ell,h)` ou `(h,h)`, respectivamente. Misturas
dentro de uma família exigem o mesmo payoff do proponente e o mesmo payoff
mínimo de H; diferenças apenas na identidade ou no pacote residual permanecem.

## 10. Payoffs transportáveis para N6/N7

Por proposer reconhecido:

| ramo | payoff do proposer | H por tipo | outcome ex ante |
|---|---|---|---|
| P | `r` | `(Y,Y)` | passagem com H = 1 |
| L (`nu=0`) | `r` | `(Y,h)` | passagem com H = 1 |
| D, `nu<=nu_star` | `(1-nu)A` | `(ell,h)` | delay = 1 |
| D, `nu>nu_star` | `B` | `(h,h)` | delay = 1 |

Convenções por identidade usam as médias da Seção 9 sem apagar os registros
fonte. Essas fórmulas não selecionam pacote, proposer ou equilíbrio.

## 11. Resultado dos três testes adversariais autorizados

Depois de construída a regra geral, o oracle foi aplicado aos três fixtures:

1. `m=3`, oferta `(h,B,B,1-h-2B)` e dois vetos weak: assessment válido; o
   proposer recebe `B`, refutando qualquer garantia maior baseada em `x=B`.
2. `m=2`, oferta `(h,A,1-h-A)` e veto weak: assessment válido; o proposer
   recebe `(1-nu)A`, e `x=A` não força passagem.
3. `m=2`, região `nu>=nu_star`, H-veto e `x<B`: assessment rejeitado porque
   `no` domina fracamente `yes` para o weak responder.

Os testes são consequências do oracle vetorial, não premissas da derivação.

## 12. Fronteira e parada

O schema `equilibrium_correspondence_v1` comporta a correspondência por meio de
registros paramétricos: os campos existentes podem transportar vetores
indexados por identidade e fórmulas fechadas sem campo novo. Não foi encontrada
ambiguidade de ação, informação, payoff, posterior, tie-break ou topologia.
Se a implementação exigir qualquer campo adicional ou revelar uma família não
coberta acima, N4 v3 para antes de publicar candidato e aciona a Seção 11.1.
