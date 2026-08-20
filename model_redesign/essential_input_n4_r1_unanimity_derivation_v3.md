# N4 v3 — R1 sob unanimidade

**Nó:** `N4`
**Status:** `pending/unfrozen`; candidato de implementação ainda não revisado
**Contrato:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`
**Dependência única:** N2 congelado,
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
**Nota fria selada:**
`model_redesign/essential_input_n4_r1_unanimity_cold_notes_v3.md`,
`sha256:5c4065fa5ff7baa4abae80e28d0d0643714f425ac3c62e560c2b309a7b7ba2f3`
**Oracle independente:** `scripts/oracle_essential_input_n4_v3.R`

Esta derivação foi fechada desde as primitivas, P3--P7 e os bytes congelados
de N2. A nota fria foi selada antes de abrir N4 v1/v2. Os artefatos anteriores
entram na Seção 11 apenas como proveniência e contraprova; nenhuma de suas
fórmulas foi usada como alvo.

## 1. Importação fechada de N2

Há `m=N-1>=2` weak states. Um deles propõe e os `m-1` restantes votam ao lado
de H. Defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m.
```

Depois de uma falha em R1, os únicos registros possíveis são:

| N2 | posterior `eta` | valor subjetivo weak | payoff weak realizado `(theta=0,theta=1)` | payoff H |
|---|---:|---:|---:|---:|
| low-type-only | `0<=eta<=nu_star` | `A*(1-eta)` | `(A,0)` | `(ell,h)` |
| pooling | `nu_star<eta<=1` | `B` | `(B,B)` | `(h,h)` |

O valor subjetivo decide o voto weak. O vetor realizado decide o payoff de um
proponente que chega a R2, sempre integrado no prior verdadeiro pré-proposta.
O vetor de H decide sua melhor resposta por tipo. Cada objeto já está em
unidades de R1, depois de exatamente um fator `beta`.

Para uma falha on-path que não revela o tipo,

```text
D(nu) = (1-nu)A,
C(nu) = D(nu), se nu<=nu_star;
        B,     se nu>nu_star.
```

## 2. Oracle vetorial do ballot

O ballot tem `m` votos simultâneos: H e `m-1` weak responders. O oracle exige
uma continuação para cada um dos `2^m-1` vetores de falha. Para cada weak `j`,
ele compara `yes` e `no` contra todos os `2^(m-1)` vetores dos demais. Primeiro
elimina ações fracamente dominadas, depois intersecta o conjunto sobrevivente
com as melhores respostas sequenciais e somente então aplica `T^Y` a uma
indiferença genuína. H satisfaz PBE e `T^Y`, sem stage-undominance.

Nas propostas on-path, a crença de ballot é `nu`; cada falha de probabilidade
positiva obedece a Bayes. Propostas e vetores de probabilidade zero preservam
as crenças livres permitidas pelo contrato. Em qualquer desvio, o proponente
continua usando `nu`, não a crença arbitrária do ballot.

O oracle é independente do candidato: não importa fórmulas de security nem lê
o JSON de N4. Seus testes dirigidos reproduzem as duas contraprovas válidas da
v2 e rejeitam o `H_veto` de prior alto com `x<B`.

## 3. Classes on-path exaustivas

As únicas classes puras são:

- `P`: passagem pooling, para todo `nu`, com H0=H1=`yes`;
- `L`: passagem low-type-only, somente em `nu=0`, com H0=`yes`, H1=`no`;
- `D`: atraso, por veto de H ou por pelo menos um veto weak.

Passagem high-type-only nunca existe. Para `nu>0`, low-type-only também não
existe: a falha de H1 revela o tipo alto e leva a pooling em N2; H0 pode imitar
esse voto e receber `h`, de modo que H0=`yes` requer `Y>=h`, incompatível com
H1=`no`. Com veto weak, H1 sempre usa `yes` por `T^Y`; qualquer separação de H
é incompatível com Bayes e com a comparação type-conditioned. Assim, todo
delay por veto weak tem H0=H1=`yes`.

## 4. Respostas weak exatas

Em `P` e `L`, os vetores de falha que disciplinam um responder podem receber
pooling. O piso exato de existência é

```text
x_j>=B para todo j.
```

No `H_veto`, todos os weak responders votam `yes`. Os limites são:

```text
m=2, nu<nu_star:  x>=0;
m=2, nu>=nu_star: x>=B;
m>=3:              todo vetor x factível.
```

Para um veto weak único `k`, a condição exata é `x_k<=C(nu)`. Em igualdade,
uma linha contrafactual estrita pode eliminar `yes`, de modo que `T^Y` não
ressuscita essa ação. Com pelo menos dois vetos weak e `m>=3`, qualquer pacote
factível é sustentável: cada troca unilateral ainda deixa falha e as
continuações dos vetores zero-probabilidade podem tornar `no` estritamente
melhor sem violar Bayes.

## 5. Security para `m>=3`

Prescreva, após uma proposta de probabilidade zero, todos os weak responders
em `no`, H0 em `no` e H1 em `yes`. O vetor de H0 recebe pooling e o vetor de H1
recebe low-type-only. Nos vetores com H=`yes`, faça o valor weak crescer
estritamente com o número de vetos, de `B` a `A`; nos vetores com H=`no`, use
pooling. Com crença de ballot um, cada veto é sequencialmente racional e não
dominado. H0 prefere `no`; H1 usa `T^Y=yes`.

O payoff realizado do proponente é `(B,0)`, portanto

```text
S_3(nu)=(1-nu)B.
```

A proposta `Y=0` garante esse valor: toda falha paga ao proponente pelo menos
`B` no tipo baixo e pelo menos zero no tipo alto. Logo `S_3` é exato e
atingido. Como `m-1>=2`, nenhuma proposta força passagem contra toda punição
admissível.

## 6. Security para `m=2`

Com um único weak responder, separe as faixas `x<A`, `x=A` e `x>A`.

- Em `x<A`, a punição separating paga `(B,0)`, ou `(1-nu)B` ex ante.
- Em `x=A`, a mesma punição transforma o stage game em igualdade e `T^Y`
  seleciona `yes`. Falha comum low-type-only ou pooling produz
  `R_0=min{D,B}`.
- Em `x>A`, W é forçado a `yes`. Para `Y<ell`, o pior retorno é
  `min{D,B}`; para `ell<=Y<h`, é `min{(1-nu)r,B}`; para `Y>=h`, é `r`.

Defina

```text
Q_L       = 1-ell-A > 0,
Q_P       = 1-h-A,
R_0(nu)   = min{D(nu),B},
R_L(nu)   = min{(1-nu)Q_L,B},
R_P       = max{0,Q_P},
S_2(nu)   = max{R_0(nu),R_L(nu),R_P}.
```

`S_2` é um supremo. `R_0` é sempre atingido. `R_P>0` nunca é atingido, porque
exige `x>A`. Para `nu<1`, `R_L` é atingido exatamente quando
`(1-nu)Q_L>B`; na igualdade ou abaixo, é apenas supremo. Em `nu=1`, seu valor
zero é atingido trivialmente.

Para o tie-break entre propostas que dão `S_2` ao proponente, escreva

```text
H_L(nu)=(1-nu)ell+nu*h.
```

O menor payoff esperado de H entre witnesses atingidos é

```text
H_tie(nu) = H_L(nu), se S_2=R_0=D<B;
            h,       se algum componente atingido iguala S_2 e o caso anterior falha;
            +infty,  se somente componentes não atingidos alcançam S_2.
```

O infinito é uma convenção de comparação: nenhum desvio empata `S_2`, portanto
um pacote on-path que dê exatamente `S_2` não enfrenta restrição adicional do
tie-break.

## 7. Famílias puras e endpoints

### 7.1 Pooling

Use `S=S_3` para `m>=3` e `S=S_2` para `m=2`. A família completa satisfaz

```text
h<=Y<=y_bar,
x_j>=B,
r>=S,
Y+sum_j x_j+r<=1.
```

Folga é preservada. Em `m>=3`, se `r=S_3`, o tie-break exige `Y=h`. Em `m=2`,
se `r=S_2`, exige `Y<=H_tie`: não há tal pooling quando `H_tie<h`; somente
`Y=h` quando `H_tie=h`; e não há restrição adicional quando
`H_tie=+infty`. Se `r>S`, todo `Y` factível sobrevive.

Defina `U_P=1-(m-1)B-S`. Sempre `U_P>h`. Se `m=2` e `H_tie=+infty`, o cap
`U_P` é atingido; nos demais casos ele é apenas supremo. Um cap primitivo
`y_bar<U_P` é atingido escolhendo `r>S`. Assim, `h` é sempre mínimo atingido;
o máximo é `min{y_bar,U_P}` quando `y_bar<U_P`, e também quando
`m=2,H_tie=+infty,y_bar>=U_P`; fora desses casos o limite superior `U_P` não é
atingido.

### 7.2 Low-type-only

Somente em `nu=0`:

```text
ell<=Y<h,
x_j>=B,
r>=S,
Y+sum_j x_j+r<=1.
```

O mínimo `ell` é atingido e `h` é supremo não atingido. No endpoint `r=S`, o
payoff esperado de H é menor que o witness pooling relevante; o tie-break não
o elimina. O vetor de H é `(Y,h)`.

### 7.3 Delay

O proponente recebe `C(nu)`. H recebe `(ell,h)` se `nu<=nu_star` e `(h,h)` se
`nu>nu_star`. Para `m>=3`, `C>S_3`, portanto delay existe em todo prior. Para
`m=2`, existe se e somente se

```text
C(nu)>=S_2(nu).
```

Na região baixa, isso equivale a `D>=R_P`; na alta, a `R_P<=B`. A igualdade é
retida pelo tie-break. As implementações puras são:

1. H-veto, com `Y<ell` na região baixa ou `Y<h` na região alta e os limites de
   `x` da Seção 4;
2. exatamente um veto weak `k`, com `x_k<=C`;
3. pelo menos dois vetos weak, somente em `m>=3`, sem limite adicional além da
   factibilidade.

## 8. Multiplicidade, misturas e payoffs

As estratégias podem depender da identidade reconhecida. Para cada proposer
`i`, preserve qualquer família, pacote, ballot, crença e continuação admissível.
Não se impõe simetria. Para o weak state `k`,

```text
V_Wk = [R_k + sum_{i!=k} w_ik]/m,
```

onde `w_ik=x_ik` em P/L e `w_ik=C` em D. H e os outcomes são a média uniforme
sobre as identidades reconhecidas.

Em qualquer prior, defina dentro de cada assessment
`rho_c=(1/m)*sum_i Pr_i(c)`, somando reconhecimento e o suporte comportamental
do próprio proposer sobre as classes localmente disponíveis. As parcelas somam
um. Para cada categoria de passagem não vazia, `bar_Y_c` é a média condicional
de `Y` com os mesmos pesos. Categoria vazia usa o objeto tipado de não
aplicabilidade. Essas quantidades são funções da estratégia do assessment, não
uma distribuição sobre equilíbrios; por isso também dão conteúdo fechado a
`rho_P`, `rho_D` e `bar_Y_P` nas células de prior positivo.

O ballot é sempre puro. As únicas misturas cross-branch de um mesmo proposer
são:

```text
nu=0:       L em (Y,r)=(ell,A) com D, quando D está disponível;
nu>nu_star: P em (Y,r)=(h,B)   com D, quando D está disponível.
```

As probabilidades comportamentais são livres dentro do assessment, não uma
distribuição sobre equilíbrios. Cada suporte produz o mesmo vetor de H:
`(ell,h)` no primeiro locus e `(h,h)` no segundo.

Em `nu=0`, as coordenadas aprovadas satisfazem
`rho_L+rho_P+rho_D=1`, e as médias condicionais são `bar_Y_L` e `bar_Y_P`.
Uma categoria vazia usa o objeto tipado
`{status:"not_applicable",reason:"category_empty"}`. Para convenções puras,
cada `rho` é `k/m`; misturas válidas acrescentam somente as fatias contínuas
geradas por suas probabilidades comportamentais. Os payoffs são

```text
H0 = rho_L*bar_Y_L + rho_P*bar_Y_P + rho_D*ell,
H1 = (rho_L+rho_D)*h + rho_P*bar_Y_P.
```

O outcome de R1 é passagem com H nas categorias L/P e delay em D. Aprovação
sem H e falha terminal têm massa zero.

## 9. P0 e P3--P7

- P0: uso integral da pie é refutado como proposição universal. Mudar folga
  muda a proposta e pode mudar respostas e crenças off-path.
- P3: P/L/D são exaustivos; high-only e low-only de prior positivo não existem.
- P4: propostas/votos weak on-path não dependem de `theta`; o voto público de H
  é a única fonte possível de atualização adicional.
- P5: N2 terminal e reconhecimento iid tornam o posterior suficiente.
- P6: a comparação usa todos os vetores; dominância antecede `T^Y`.
- P7: cada voto de H está dentro da história pública que indexa a continuação.

## 10. Cobertura e transporte

As seis células são mutuamente exclusivas e exaustivas:

```text
m=2:  nu=0; 0<nu<=nu_star; nu_star<nu<=1;
m>=3: nu=0; 0<nu<=nu_star; nu_star<nu<=1.
```

Pooling torna toda célula não vazia. Famílias ausentes recebem certificados,
nunca sentinelas. Cada registro preserva pacotes, crenças, identidades,
payoffs type-conditioned e outcomes conjuntamente. N4 permanece
`pending/unfrozen`; este artefato não congela o nó nem autoriza N6.

## 11. Comparação pós-selagem com N4 v2

A leitura da v2 ocorreu somente depois do hash da nota fria ter sido fixado.
Sobreviveram: a importação type-conditioned `(A,0)`/`(B,B)`, a distinção entre
valor subjetivo e realizado, as classes P/L/D, a impossibilidade de high-only,
a restrição de low-only a `nu=0`, a suficiência do posterior, a multiplicidade
por identidade e a preservação de folga.

Não sobreviveram:

- `S_m=min{P,D}`; o correto é `S_3=(1-nu)B`;
- `S_2=max{F,K,M}` e o componente `F`; o correto é o supremo da Seção 6;
- a alegação de que `(h,A,1-h-A)` força passagem em `m=2`;
- a proibição de múltiplos vetos fora da região baixa; eles existem para
  qualquer prior e pacote factível quando `m>=3`;
- pooling caps, residual rules, endpoints e condições de delay derivados das
  garantias invalidadas.

O bound localizado `x>=B` para `H_veto` em `m=2,nu>=nu_star` foi reproduzido
friamente. A divergência restante é única e fechada pela Opção A já autorizada;
nenhuma mudança de schema, topologia, jogo, protocolo ou primitiva foi usada.
