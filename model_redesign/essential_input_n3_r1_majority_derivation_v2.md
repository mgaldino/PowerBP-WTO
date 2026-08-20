# N3 v2 — R1 sob maioria

**Nó:** `N3`

**Schema:** `equilibrium_correspondence_v1`

**Dependência única:** `N1-EQ-01`

**Hash consumido:** `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`

**Data nativa dos payoffs:** R1

**Status:** `pending_independent_review`

**Artefato candidato:** `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v2.json`

Esta derivação foi feita friamente a partir das primitivas do contrato vigente e
da interface congelada de N1. A interface e a derivação antigas de N3 só foram
abertas depois de fechar os mapas de votos, desvios, candidatos e fronteiras.
A comparação de provenance está na Seção 9.

O objetivo adicional do v2 é de transporte. Cada célula contém fórmulas fechadas
em primitivas para as condições de admissibilidade, a seleção, o payoff de H por
tipo e os outcomes. N6 não precisa importar a derivação, a interface v1 ou uma
definição externa para interpretar esses campos.

## 1. Continuação congelada e relógio

N1 exporta, para todo posterior de entrada em R2:

```text
payoff do proponente reconhecido em R2 = 1
payoff pré-reconhecimento de cada weak state em R2 = 1/m
payoff de H do tipo theta em R2 = o_theta
resultado em R2 = aprovação sem H com probabilidade 1
```

Defina, apenas como abreviações desta derivação:

```text
c       = beta/m
a_0     = beta*o_0
a_1     = beta*o_1
```

`c` e `a_theta` estão em unidades de R1. O fator `beta` aparece uma única vez,
quando N1 entra numa comparação de R1. Nenhuma fórmula do artefato transportável
depende dessas abreviações: o JSON escreve `beta/m` e `beta*o_theta` diretamente.

<a id="claim-n3v2-c01"></a>
### Claim N3V2-C01 — importação de N1 e desconto único

Depois de qualquer falha em R1, todo weak state avalia a continuação em `c` e H
do tipo `theta` a avalia em `a_theta`. Esses valores são invariantes ao posterior
publicado pela história de votos, porque N1 contém um único registro para todo
posterior em `[0,1]`.

## 2. Ballot de R1 depois de toda proposta factível

Fixe o weak proposer reconhecido `i` e uma proposta factível

```text
s = (y, (x_j)_{j em W sem i}, r_i).
```

O proponente conta como `sim`. Para cada weak nonproposer `j`, mantendo fixo o
perfil dos demais votos:

| Situação | `j=sim` | `j=não` |
|---|---:|---:|
| `j` é pivotal | `x_j` | `c` |
| a quota passa sem `j` | `x_j` | `x_j` |
| a quota falha mesmo com `j` | `c` | `c` |

Na última linha, as histórias públicas diferem, mas N1 atribui o mesmo payoff
de continuação a ambas.

<a id="claim-n3v2-c02"></a>
### Claim N3V2-C02 — cutoff completo dos weak nonproposers

Se `x_j>c`, `sim` domina fracamente `não`; se `x_j<c`, `não` domina fracamente
`sim`. Em `x_j=c`, as ações são idênticas contra todo perfil dos demais votos e
`T^Y` seleciona `sim`. Logo:

```text
j vota sim  se e somente se  x_j >= beta/m.
```

Defina `K_i(s)={j em W sem i: x_j>=beta/m}` e `k_i(s)=|K_i(s)|`.

<a id="claim-n3v2-c03"></a>
### Claim N3V2-C03 — mapa completo da melhor resposta de H

O mapa deve preservar a realização integral de `y` e o ramo não pivotal:

1. Se `k_i(s)>=q-1`, os weak states aprovam sem H. `sim` paga `y`; `não` paga
   `y+o_theta`. Como `o_theta>0`, ambos os tipos votam `não` estritamente.
2. Se `k_i(s)=q-2`, H é pivotal. `sim` implementa `y`; `não` conduz a N1 e
   vale `beta*o_theta`. Portanto o tipo `theta` vota `sim` se e somente se
   `y>=beta*o_theta`; `T^Y` seleciona `sim` na igualdade.
3. Se `k_i(s)<=q-3`, a quota falha com qualquer voto de H. Os dois votos levam
   ao mesmo registro de N1, ainda que publiquem histórias diferentes. Há
   indiferença genuína e `T^Y` seleciona `sim` para ambos os tipos.

Esse é um mapa depois de **toda** proposta factível, não apenas das propostas
selecionadas.

## 3. Payoff do proponente e redução exaustiva

<a id="claim-n3v2-c04"></a>
### Claim N3V2-C04 — payoff depois de toda proposta

Sob o prior verdadeiro `nu`, o payoff do proponente é:

```text
v_i(s;nu) = r_i,                                                se k_i>=q-1;

              beta/m,                                          se k_i=q-2 e y<beta*o_0;

              (1-nu)*r_i + nu*beta/m,                           se k_i=q-2 e
                                                                 beta*o_0<=y<beta*o_1;

              r_i,                                              se k_i=q-2 e y>=beta*o_1;

              beta/m,                                          se k_i<=q-3.
```

A crença de ballot depois de uma proposta fora do caminho não aparece nesse
mapa. O proponente não observa `theta` e avalia seu desvio pelo prior verdadeiro;
os votos derivados são invariantes à crença off-path.

<a id="claim-n3v2-c05"></a>
### Claim N3V2-C05 — três candidatos e a família de falha

Dentro de cada classe de outcome, reduzir uma parcela que não altera votos ou
aceitação e transferi-la para `r_i` aumenta fracamente, e quando a proposta
passa com probabilidade positiva aumenta estritamente, o payoff do proponente.
Restam:

```text
E = 1-beta*(q-1)/m
    exclusão: y=0; q-1 weak voters recebem beta/m; os demais recebem 0.

L = 1-beta*o_0-beta*(q-2)/m
S(nu) = (1-nu)*L + nu*beta/m
    low-type-only: y=beta*o_0; q-2 weak voters recebem beta/m.

P = 1-beta*o_1-beta*(q-2)/m
    pooling: y=beta*o_1; q-2 weak voters recebem beta/m.

R = beta/m
    qualquer proposta que falha para todo tipo no suporte do prior.
```

Em `nu=1`, a família de falha inclui propostas que o tipo baixo, de probabilidade
zero, aceitaria. Em `nu=0`, uma proposta pivotal com `y<beta*o_0` é rejeitada
pelos dois tipos. Esses endpoints integram o conjunto de desvios, mesmo que a
família de falha nunca seja selecionada.

## 4. P0, P1, atraso e factibilidade

<a id="claim-n3v2-c06"></a>
### Claim N3V2-C06 — P0: uso integral da pie

Exclusão e pooling passam com probabilidade um. Low-type-only, quando
selecionada, tem `nu<1` e passa com probabilidade positiva. Se qualquer uma
tivesse folga, aumentar `r_i` preservaria crenças, votos e outcome e elevaria
estritamente o payoff do proponente. Toda proposta selecionada usa a pie inteira.

<a id="claim-n3v2-c07"></a>
### Claim N3V2-C07 — P1 e P1a: hedge estrito

Considere uma proposta com `y>0` e pelo menos `q-1` weak nonproposers pagos o
suficiente para votar `sim`. Ela passa sem H e H vota `não`. A proposta

```text
s' = (0, x, r_i+y)
```

é factível, preserva todos os votos e aumenta estritamente o payoff do
proponente em `y`. A conclusão é independente das crenças atribuídas a `s` ou
`s'`. Logo nenhuma aprovação on-path sem H tem `y>0`; a exclusão com `y=0`
permanece.

<a id="claim-n3v2-c08"></a>
### Claim N3V2-C08 — custo estrito da falha deliberada

Como `N>=3`, temos `q=floor(N/2)+1<=m`. Portanto:

```text
E-R = 1-beta*q/m > 0,
```

pois `0<beta<1`. Toda falha deliberada, com ou sem folga, é estritamente pior
que exclusão. Não há delay deliberado. Há, porém, delay informativo: em uma
proposta low-type-only selecionada, o tipo alto rejeita e segue para N1 com
probabilidade `nu`.

<a id="claim-n3v2-c09"></a>
### Claim N3V2-C09 — factibilidade dos candidatos selecionados

Exclusão custa `beta*(q-1)/m<1`. Low-type-only só é selecionada em células com
`o_0<=1/m`, então:

```text
beta*[o_0+(q-2)/m] <= beta*(q-1)/m < 1.
```

Pooling só é selecionada com `o_1<=1/m` e satisfaz a mesma desigualdade. Assim,
todo candidato que aparece em uma célula do v2 é estritamente factível e deixa
residual positivo ao proponente. A prova não impõe igualdade orçamentária como
primitiva; ela a deriva para os ótimos. A coordenada de H também respeita o
intervalo do pacote: `0<beta*o_theta<o_theta<=o_1<=y_bar`; exclusão usa `y=0`.

## 5. Fronteiras e partição da correspondência

As diferenças fundamentais são:

```text
P-E = beta*(1/m-o_1)

S(nu)-E = (1-nu)*beta*(1/m-o_0)
          - nu*(1-beta*q/m).
```

Defina as fronteiras fechadas, agora diretamente em primitivas:

```text
nu_SP = beta*(o_1-o_0) /
        [1-beta*o_0-beta*(q-1)/m]

nu_SE = beta*(1/m-o_0) /
        [beta*(1/m-o_0)+1-beta*q/m].
```

Nos domínios em que são usadas, ambas pertencem estritamente a `(0,1)`.

<a id="claim-n3v2-c10"></a>
### Claim N3V2-C10 — onze células mutuamente exclusivas e exaustivas

| Condição em outside options | Condição em `nu` | Branch selecionado |
|---|---|---|
| `o_1<1/m` | `0<=nu<=nu_SP` | low-type-only |
| `o_1<1/m` | `nu_SP<nu<=1` | pooling |
| `o_0<1/m<o_1` | `0<=nu<=nu_SE` | low-type-only |
| `o_0<1/m<o_1` | `nu_SE<nu<=1` | exclusão |
| `1/m<o_0<o_1` | todo `nu` | exclusão |
| `o_0=1/m<o_1` | `nu=0` | low-type-only |
| `o_0=1/m<o_1` | `0<nu<=1` | exclusão |
| `o_0<o_1=1/m` | `0<=nu<=nu_SE` | low-type-only |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_E<h_P` | exclusão |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_P<h_E` | pooling |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_E=h_P` | exclusão, pooling e todas as misturas |

Nas três últimas linhas:

```text
h_E = (1-nu)*o_0 + nu/m
h_P = beta/m.
```

As igualdades de payoff do proponente pertencem à célula low-type-only porque
seu payoff esperado para H é estritamente menor. Em `o_0=1/m,nu=0`, por
exemplo, low-type-only e exclusão pagam o mesmo ao proponente, mas dão a H
`beta*o_0` e `o_0`, respectivamente.

<a id="claim-n3v2-c11"></a>
### Claim N3V2-C11 — knife-edge `o_1=1/m`

Quando `o_1=1/m`, `E=P` para todo `nu`. Até `nu_SE`, low-type-only vence; na
igualdade, ela também vence pelo tie-break, pois `h_S=beta*h_E<h_E` e, como
`nu_SE<1`, `h_S<beta/m=h_P`. Acima de `nu_SE`, o tie-break compara diretamente
`h_E` e `h_P`.

Se `h_E=h_P`, nenhuma das duas famílias é eliminada. Todo perfil puro que
atribui a cada identidade de proponente exclusão ou pooling é admissível, assim
como toda mistura comportamental do proponente entre essas famílias e entre
identidades de coalizão. Esta é a única região em que o vetor de payoff de H e
o outcome podem variar dentro da célula.

## 6. Estratégias do proponente, payoffs e outcomes

<a id="claim-n3v2-c12"></a>
### Claim N3V2-C12 — multiplicidade por identidade e misturas

Para um branch único e proponente `i`, o v2 usa pesos
`omega_{i,K}>=0`, cuja soma é um, sobre todas as coalizões admissíveis:

```text
|K|=q-2 em low-type-only e pooling;
|K|=q-1 em exclusão.
```

Um vetor degenerado é uma proposta pura; qualquer vetor não degenerado é uma
mistura do proponente. Os vetores podem diferir entre identidades `i`; nenhuma
simetria é imposta.

Na célula mista, `e_{i,K}` pesa coalizões de exclusão com `|K|=q-1` e
`p_{i,T}` pesa coalizões de pooling com `|T|=q-2`, com

```text
sum_K e_{i,K} + sum_T p_{i,T} = 1
```

para cada `i`. Essa parametrização contém todas as escolhas puras por identidade
e todas as misturas do proponente.

Os payoffs do proponente reconhecido são:

```text
low-type-only: (1-nu)*[1-beta*o_0-beta*(q-2)/m] + nu*beta/m
pooling:       1-beta*o_1-beta*(q-2)/m
exclusão:      1-beta*(q-1)/m
célula mista:  1-beta*(q-1)/m
```

<a id="claim-n3v2-c15"></a>
### Claim N3V2-C15 — mapa weak por identidade

Para cada weak state `l`, o payoff pré-reconhecimento inclui a probabilidade
`1/m` de ele próprio propor e a probabilidade `1/m` de cada outro `i` propor.
Por exemplo, em low-type-only:

```text
C_l = (1/m)*S(nu)
      +(1/m)*sum_{i != l}{
          (1-nu)*(beta/m)*Pr_{omega_i}(l em K)
          +nu*beta/m
        }.
```

Pooling e exclusão removem o termo de continuação e usam as respectivas
probabilidades de `l` integrar a coalizão. A célula mista soma as probabilidades
induzidas por `e_{i,K}` e `p_{i,T}`. O JSON escreve cada mapa integralmente em
primitivas, sem depender de `S`, `E`, `P` ou desta derivação.

<a id="claim-n3v2-c16"></a>
### Claim N3V2-C16 — vetores de H e outcomes fechados

Cada coordenada de H é calculada para a mesma realização primitiva, condicionada
ao tipo — nunca se recombinam marginais de equilíbrios distintos:

| Branch | `U_H(theta=0)` | `U_H(theta=1)` | `(pass with H, pass without H, failure, delay)` |
|---|---:|---:|---|
| low-type-only | `beta*o_0` | `beta*o_1` | `(1-nu,0,0,nu)` |
| pooling | `beta*o_1` | `beta*o_1` | `(1,0,0,0)` |
| exclusão | `o_0` | `o_1` | `(0,1,0,0)` |

Na célula mista, defina somente dentro da própria fórmula os pesos cuja soma é
um para cada `i`. Então:

```text
U_H(0) = (1/m)*sum_i[
           o_0*sum_K e_{i,K} + (beta/m)*sum_T p_{i,T}
         ]

U_H(1) = (1/m)*sum_i[
           (1/m)*sum_K e_{i,K} + (beta/m)*sum_T p_{i,T}
         ]

pass with H    = (1/m)*sum_i sum_T p_{i,T}
pass without H = (1/m)*sum_i sum_K e_{i,K}
failure        = 0
delay          = 0.
```

Aqui `o_1=1/m` pela própria célula. Nos quatro campos transportados por N6 —
`admissibility_conditions`, `selection_status`, `hegemon_payoff_by_type` e
`outcome_distribution` — todo peso e todo domínio é redefinido localmente. Não
há `F_i`, `A_i_star`, `I_H`, `I_X`, `I_D`, `t_theta`, `S`, `E` ou `P` livre.

`failure=0` significa ausência de falha terminal depois das duas rodadas. O
campo `delay` registra falha em R1 seguida por N1. Assim, as quatro coordenadas
formam uma partição do evento de R1.

## 7. Crenças e publicação do vetor de votos

<a id="claim-n3v2-c13"></a>
### Claim N3V2-C13 — Bayes on-path e crenças off-path

O weak proposer não observa `theta`. Toda proposta com peso positivo sob sua
estratégia mantém o posterior de ballot igual a `nu`. Cada proposta individual
com peso zero recebe uma crença explícita e irrestrita
`kappa_i(s) em [0,1]`.

Nos endpoints `nu=0` e `nu=1`, as estratégias e os payoffs condicionais dos
dois tipos continuam especificados. Bayes restringe apenas histórias de
probabilidade positiva; tipos de prior zero não são apagados do assessment.

<a id="claim-n3v2-c14"></a>
### Claim N3V2-C14 — P7 e posterior depois dos votos

Os votos fracos são funções determinísticas dos pagamentos e independem de
`theta`. Em todo vetor de probabilidade positiva, apenas a ação de H pode
acrescentar informação sobre o tipo. No branch low-type-only, uma falha de R1
com `nu>0` ocorre somente depois do `não` do tipo alto e induz posterior um.

Todo vetor de proposta e votos de probabilidade zero recebe posterior explícito
e irrestrito `eta_i(s,v) em [0,1]`. Qualquer que seja `eta_i(s,v)`, a
continuação é o mesmo `N1-EQ-01`; nenhuma crença off-path é escolhida para
sustentar os cutoffs ou as fronteiras.

## 8. Existência, endpoints e invalidação

<a id="claim-n3v2-c17"></a>
### Claim N3V2-C17 — existência e cobertura completa

Exclusão é sempre estritamente factível e paga mais que falha deliberada.
Portanto existe ao menos um equilíbrio em todo ponto do domínio. As onze células
cobrem `nu=0`, `nu=1`, `o_0=1/m`, `o_1=1/m`, todas as desigualdades estritas,
as igualdades de payoff do proponente e a igualdade residual do tie-break de H.
Não há célula de inexistência no baseline `0<beta<1`.

Qualquer mudança no contrato, no schema, no hash de N1, no conceito de solução,
na implementação de `y`, no tie-break ou no timing invalida este candidato. O
v2 não altera o DAG, não atualiza lifecycle, não congela N3 e não autoriza N6.

## 9. Comparação de provenance depois da derivação fria

A interface v1 e sua derivação registravam as mesmas relações algébricas:

```text
weak cutoff = beta/m
H pivotal cutoff = beta*o_theta
E = 1-beta*(q-1)/m
S(nu) = (1-nu)*[1-beta*o_0-beta*(q-2)/m]+nu*beta/m
P = 1-beta*o_1-beta*(q-2)/m
E-beta/m = 1-beta*q/m > 0
```

Também coincidiam a partição substantiva, o tratamento de `o_0=1/m`, o tie
residual `o_1=1/m`, a atualização pelo voto de H e a existência de delay apenas
no ramo alto de low-type-only. Portanto a comparação encontrou **invariância
matemática**, não divergência substantiva.

A divergência é de interface. O v1 guardava a correspondência em um registro
aberto com `F_i`, `A_i_star`, indicadores de outcome e abreviações que N6 não
transportava. O v2 substitui esse candidato obsoleto por onze registros
fechados, cada um com domínio, pesos, endpoints, seleção, payoff de H por tipo e
outcomes executáveis dentro do próprio registro. Nenhum resultado v1 foi usado
como premissa da rederivação.
