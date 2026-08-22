# N3 — R1 sob maioria: rederivação sob o conceito de solução de 2026-08-21

**Status do candidato:** `pending/unfrozen`; não integrado ao DAG.  
**Emenda autoral posterior aplicada:** posterior de denominador zero restrito
ao suporte do prior; somente a classe de assessments de N3 é afetada.  
**Dependência única consumida:** `N1-EQ-01`.  
**SHA-256 da interface consumida:** `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`.  
**Data dos payoffs:** R1; valores de R2 recebem exatamente um fator `beta`.  
**Escopo:** somente N3. N4, N6, N7, DAG, freeze e manuscrito não são consumidos.

## 1. Intuição

Sob maioria, os Estados fracos conseguem substituir `H`. A continuação N1 é
independente da crença: em R2 cada fraco vale `1/m` antes do reconhecimento e
`H(theta)` vale `o_theta`. Portanto, em R1:

- um voto fraco custa `beta/m`;
- se os fracos já formam a quota, `H` vota `não` e fica fora;
- se falta exatamente um voto, `H` é pivotal e compara `y` com
  `beta*o_theta`;
- rejeição deliberada perde estritamente para exclusão porque `beta<1`.

A decisão de 2026-08-21 corrige as crenças fora do caminho, mas não altera esses
incentivos: propostas e votos de agentes fracos não movem a crença, e toda
crença induz a mesma continuação N1.

## 2. Contrato local e notação

Há `m=N-1` Estados fracos e quota
`q=floor(N/2)+1`, com `N>=3`. Logo `q<=m`. O proponente fraco `i`
conta como `sim`; os `m-1` respondentes fracos e `H` votam
simultaneamente.

Uma proposta factível é

```text
s = (y, (x_j)_{j in W sem i}, r_i),
y + sum_j x_j + r_i <= 1.
```

Importando N1 uma única vez, defina

```text
w       = beta/m,
t_theta = beta*o_theta,
t_0 < t_1.
```

`w` e `t_theta` já estão em unidades de R1.

## 3. Ballot após toda proposta factível

### Lema N3-1 — voto fraco como se pivotal

Condicionalmente a seu voto decidir o resultado, o respondente `j` compara
`x_j` com a continuação `w`. Logo

```text
j vota sim  se, e somente se,  x_j >= w.
```

A desigualdade estrita determina a preferência; em `x_j=w`, `T^Y`
determina `sim`. Se `j` não for pivotal, os dois vetores públicos podem ser
distintos, mas N1 entrega `w` depois de ambos.

Defina `K(s)={j:x_j>=w}` e `k(s)=|K(s)|`.

### Lema N3-2 — melhor resposta de `H`

1. Se `k>=q-1`, os votos fracos aprovam sem `H`. `Sim` paga `y`;
   `não` paga `y+o_theta`. Como `o_theta>0`, ambos os tipos votam
   `não` estritamente.
2. Se `k=q-2`, `H` é pivotal. `Sim` paga `y`; `não` conduz a N1 e
   paga `t_theta`. Assim, o tipo `theta` vota `sim` se, e somente se,
   `y>=t_theta`; a igualdade é aceita por `T^Y`.
3. Se `k<=q-3`, a proposta falha com qualquer voto de `H`. N1 dá
   `t_theta` depois de ambos os vetores; `T^Y` determina `sim`.

O timing de `o_theta` é, portanto, explícito: numa aprovação sem `H` em R1,
`o_theta` é corrente porque o jogo termina em R1; numa falha de R1, o payoff
terminal de R2 entra como `beta*o_theta`.

### Lema N3-3 — payoff do proponente

Para toda proposta factível,

```text
v_i(s;nu) =
  r_i,                                                     se k>=q-1;
  (1-nu)*[r_i se y>=t_0, senão w]
    + nu*[r_i se y>=t_1, senão w],                         se k=q-2;
  w,                                                       se k<=q-3.
```

Essa expressão é anterior aos rótulos exclusão, screening e pooling.

## 4. Redução exaustiva e factibilidade

Defina

```text
E       = 1-(q-1)w,
L       = 1-(q-2)w-t_0,
S(nu)   = (1-nu)L+nu*w,
P       = 1-(q-2)w-t_1,
R       = w,
d       = E-R = 1-beta*q/m > 0.
```

Para cada identidade de proponente `i`, os únicos candidatos não dominados
dentro de sua classe são:

- **Exclusão `E_i(K)`:** `|K|=q-1`, `y=0`, `x_j=w` em `K`,
  zero fora de `K`, `r_i=E`.
- **Screening `S_i(K)`:** `|K|=q-2`, `y=t_0`, `x_j=w` em `K`,
  zero fora de `K`, `r_i=L`; o tipo baixo aprova e o alto atrasa.
- **Pooling `P_i(K)`:** `|K|=q-2`, `y=t_1`, `x_j=w` em `K`,
  zero fora de `K`, `r_i=P`.
- **Rejeição:** qualquer proposta que falha para todo tipo de probabilidade
  positiva; paga `R=w`.

Não há classe aceita apenas pelo tipo alto porque `t_0<t_1`.

### Factibilidade que faltava na prova anterior

`E_i` é sempre factível, pois `q-1<=m-1` e
`(q-1)beta/m<1`. Screening e pooling entram no conjunto factível apenas se,
respectivamente, `L>=0` e `P>=0`.

É seguro escrever o valor como `max{E,S,P}` porque um candidato infactível
nunca vence `E`:

- `S>=E` implica `o_0<=1/m` (estritamente se `nu>0`), o que implica
  `t_0+(q-2)w <= beta(q-1)/m < 1`;
- `P>=E` equivale a `o_1<=1/m`, o que implica
  `t_1+(q-2)w <= beta(q-1)/m < 1`.

### Uso integral da pie e hedge

Toda proposta selecionada usa a pie inteira: aumentar `r_i` preserva votos e
eleva o payoff em todo estado de aprovação. Rejeição deliberada não é
selecionada porque `E-R=d>0`.

Além disso, toda proposta aprovada sem `H` com `y>0` é estritamente
dominada pela proposta que mantém os mesmos `x_j`, fixa `y=0` e acrescenta
`y` a `r_i`. Logo nenhuma aprovação on-path sem `H` tem `y>0`.

## 5. Fronteiras e domínio correto de `nu_SP`

As diferenças relevantes são

```text
P-E = beta*(1/m-o_1),

S-E = (1-nu)*beta*(1/m-o_0)
      -nu*(1-beta*q/m).
```

Quando `o_0<1/m`, defina

```text
nu_SE =
  beta*(1/m-o_0)
  / [beta*(1/m-o_0)+1-beta*q/m].
```

Então `nu_SE` pertence a `(0,1)`, screening vence exclusão para
`nu<nu_SE`, e exclusão vence para `nu>nu_SE`. Na igualdade, screening é
selecionado porque dá a `H` o payoff esperado `beta` vezes o da exclusão.

A fronteira screening-pooling é usada somente quando pooling pode vencer
exclusão, isto é, `o_1<=1/m`. Para `o_1<1/m`,

```text
nu_SP =
  beta*(o_1-o_0)
  / [1-beta*o_0-beta*(q-1)/m]
  = beta*(o_1-o_0)/(L-w).
```

Nesse domínio, o denominador é estritamente positivo e maior que o numerador;
portanto `nu_SP in (0,1)`. Screening é selecionado para
`nu<=nu_SP` e pooling para `nu>nu_SP`. Na igualdade, screening dá a
`H` payoff esperado estritamente menor.

A partição completa é:

1. `o_1<1/m`: screening até `nu_SP`, inclusive; pooling acima.
2. `o_0<1/m<o_1`: screening até `nu_SE`, inclusive; exclusão acima.
3. `1/m<o_0<o_1`: exclusão para todo `nu`.
4. `o_0=1/m<o_1`: screening somente em `nu=0`; exclusão em `nu>0`.
5. `o_0<o_1=1/m`: screening até `nu_SE`, inclusive. Acima,
   `E=P`; o desempate compara
   `h_E=(1-nu)o_0+nu o_1` com `h_P=beta o_1`. O menor é selecionado;
   se eles também empatam nessa região acima de screening, exclusão, pooling
   e suas misturas por proposta permanecem.

Em qualquer empate que envolva screening, seu payoff de `H`,
`h_S=beta[(1-nu)o_0+nu o_1]`, é estritamente menor que o da alternativa
empatada relevante. Em particular, no empate triplo `S=E=P`, vale
`h_S<h_E` porque `beta<1` e `h_S<h_P` porque `nu<1` e
`o_0<o_1`; portanto somente screening sobrevive ao desempate triplo.

## 6. Crenças sob a decisão de 2026-08-21

- Toda proposta, inclusive um desvio do proponente fraco, preserva a crença
  pública `nu`.
- Votos fracos prescritos ou desviantes não alteram essa crença.
- Depois do voto prescrito de `H`, o posterior segue Bayes usando apenas a
  estratégia de `H` sempre que o denominador é positivo. Com denominador
  zero, a crença permanece no suporte do prior: é `0` em toda a árvore se
  `nu=0`, `1` em toda a árvore se `nu=1`, e pode ser livre em
  `[0,1]` somente se `0<nu<1` e a ação de `H` está fora do perfil.
- Qualquer desses posteriores consome o mesmo registro N1. Portanto, crenças
  mudam o conjunto de assessments admissíveis, mas não estratégias, fronteiras,
  payoffs ou outcomes de N3.

## 7. Correspondência e multiplicidade

Para cada proponente reconhecido `i`, seja `A_i^*(nu)` o conjunto dos
candidatos factíveis que maximizam primeiro seu payoff e, entre os empatados,
minimizam o payoff esperado de `H`. A estratégia de proposta pode ser
qualquer distribuição `F_i` suportada em `A_i^*(nu)`; não se impõe
`F_i=F_j`.

Todos os payoffs e outcomes abaixo são vinculados à **mesma** família
`F=(F_i)_{i in W}`. Para uma proposta `s` e um tipo `theta`, defina

```text
I_H(s,theta) = 1 se s passa com H,       0 caso contrário;
I_X(s,theta) = 1 se s passa sem H,       0 caso contrário;
I_D(s,theta) = 1 se s falha e chega a N1, 0 caso contrário.
```

Os três indicadores são mutuamente exclusivos e somam um. Seja
`V_star=max{E,S(nu),P}` após factibilidade e desempate. O proponente
reconhecido `i` recebe

```text
E_{s~F_i,theta~nu}[
  r_i(s){I_H(s,theta)+I_X(s,theta)} + w I_D(s,theta)
] = V_star.
```

Antes do reconhecimento de R1, o valor do fraco identificado `l` é

```text
C_l(F) = V_star/m
 + (1/m) sum_{i!=l} E_{s~F_i,theta~nu}[
     x_l(s){I_H(s,theta)+I_X(s,theta)} + w I_D(s,theta)
   ].
```

Para cada tipo de `H`, o payoff é

```text
C_H(theta;F) = (1/m) sum_i E_{s~F_i}[
  y(s) I_H(s,theta)
  + {y(s)+o_theta} I_X(s,theta)
  + t_theta I_D(s,theta)
].
```

As probabilidades de passar com `H`, passar sem `H` e atrasar substituem,
respectivamente, o termo dentro da última esperança por `I_H`, `I_X` e
`I_D`, integrando também `theta~nu`. A probabilidade de falha terminal em R1
é zero. Essa vinculação atômica impede combinar uma estratégia de proposta
com o payoff ou outcome marginal de outra.

Assim, sobrevivem:

- multiplicidade pela identidade da coalizão comprada;
- mistura entre exclusão e pooling no empate residual de `o_1=1/m` quando
  também empata o payoff esperado de `H`;
- atraso somente no estado alto quando screening selecionado e `nu>0`.

Não sobrevivem rejeição deliberada, folga on-path nem exclusão com `y>0`.

Como casos degenerados dessas fórmulas, os vetores de payoff de `H` são:

```text
exclusão:  (o_0, o_1),
screening: (t_0, t_1),
pooling:   (t_1, t_1).
```

## 8. Certificados de inexistência e estatuto

| Objeto excluído | Certificado |
|---|---|
| aceitação apenas pelo tipo alto | exigiria simultaneamente `y<t_0` e `y>=t_1` |
| rejeição deliberada on-path | `E-R=1-beta*q/m>0` |
| candidato screening infactível selecionado | `S>=E` implica sua factibilidade |
| candidato pooling infactível selecionado | `P>=E` implica sua factibilidade |
| aprovação sem `H` com `y>0` | hedge `y=0` aumenta `r_i` estritamente |

**Conclusão candidata:** a correspondência substantiva anterior de N3
sobrevive. Foram corrigidos o sistema de crenças, a prova de factibilidade, o
domínio de `nu_SP`, o timing de `o_theta` e os desempates. O artefato
permanece `pending/unfrozen` até autorização separada para freeze/DAG.
