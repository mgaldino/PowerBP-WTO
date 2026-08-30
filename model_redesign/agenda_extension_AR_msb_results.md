# `A_R` sob M/S/B — resultados públicos, rendas informacionais e interação

**Data:** 2026-08-30  
**Status:** `IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Orientação:** `U-M`

## 1. Visão geral

Quando o tipo de `H` é público, a agenda não produz sinalização. Ainda assim, ela muda o jogo porque `H` pode oferecer acordo agora ou aceitar a continuação descontada.

O resultado central tem três partes:

1. sob unanimidade, `H` sempre compra todos os fracos e há acordo imediato;
2. sob maioria, `H` compra uma coalizão mínima quando isso vale mais que a continuação, mas um tipo com `o_theta` alto pode preferir deliberadamente o atraso;
3. a renda informacional com agenda é a diferença, tipo a tipo, entre a correspondência privada congelada e esse benchmark público. Nenhum equilíbrio privado é selecionado por `A_R`.

## 2. Continuações públicas transportadas para `A`

Use

```text
m=N-1>=3,
k=floor(N/2),
c=m-k,
Z_E=1-k*beta/m.
```

Para `o=o_theta`, o benchmark público congelado `N7` dá:

```text
p_M(o)=beta*o,  se o<=1/m,
p_M(o)=o,       se o>1/m,
p_U(o)=beta*o.
```

Esses são payoffs de `H` na data nativa de `R1`. Com a seleção anônima M/S, o payoff nativo de cada fraco é

```text
w_M(o)=(1-beta*o)/m, se o<=1/m,
w_M(o)=1/m,          se o>1/m,
w_U(o)=(1-beta*o)/m.
```

No ramo de exclusão majoritária, `o` é externo à unidade institucional; por isso os fracos continuam dividindo a unidade inteira. Na data `A`, o preço de um voto fraco e o payoff de atraso de `H` são

```text
r_g(o)=beta*w_g(o),
D_g(o)=beta*p_g(o).
```

## 3. Jogo público de agenda sob maioria

`H` já conta como um voto favorável e precisa de `k=q-1` votos fracos.

### 3.1 Continuação que inclui `H`: `o<=1/m`

Cada fraco vota sim se e somente se

```text
x_j>=r_M(o)=beta*(1-beta*o)/m.
```

Defina

```text
P_I(o)=1-k*beta*(1-beta*o)/m.
```

O conjunto de propostas ótimas que passam é

```text
P_M^I(o)
 ={(z,x): existe K subset W, |K|=k,
           x_j=r_M(o) se j in K,
           x_j=0 se j notin K,
           z=P_I(o)}.
```

Toda probabilidade sobre `P_M^I(o)` é preservada. Isso inclui qualquer loteria sobre as identidades de `K`; não se exige uma loteria uniforme para a proposta corrente.

O atraso renderia `D_M(o)=beta^2*o`. A diferença é

```text
P_I(o)-D_M(o)
 =1-beta*k/m-beta^2*o*c/m
 >1-beta>0.
```

A última desigualdade usa `o<1` e `beta<1`. Logo toda PBE pública nessa célula passa imediatamente e dá a `H`

```text
h_M(o)=P_I(o).
```

### 3.2 Continuação que exclui `H`: `o>1/m`

Agora cada voto custa

```text
r_M(o)=beta/m.
```

Uma proposta mínima que passa paga `beta/m` a exatamente `k` fracos e dá a `H`

```text
P_E=Z_E=1-k*beta/m.
```

Rejeição dá

```text
D_M(o)=beta*o.
```

Defina o limiar

```text
tau_M=Z_E/beta=1/beta-k/m.
```

Como `q=k+1<=m` e `beta<1`, `tau_M>1/m`. A correspondência completa é:

```text
1/m<o<tau_M: acordo imediato em qualquer loteria sobre coalizões mínimas;
o=tau_M:    qualquer mistura entre propostas mínimas que passam e propostas que recebem menos de k votos;
o>tau_M:    qualquer proposta que recebe menos de k votos e induz atraso.
```

Se `tau_M>=1`, o terceiro caso é vazio no domínio `o<1`. Em todas as células, o payoff público de `H` é singleton:

```text
h_M(o)=max{Z_E,beta*o},  se o>1/m.
```

A probabilidade de acordo é `1`, `[0,1]` ou `0` conforme `beta*o` seja menor, igual ou maior que `Z_E`. No empate, a mesma mistura liga proposta, resultado e probabilidade; não se formam coordenadas independentes.

### 3.3 Completude

**Teorema AR-MSB-T1 — PBE pública de maioria.** As classes das Seções 3.1–3.2 são necessárias e suficientes.

**Prova.** Pela comparação as-if-pivotal e `T^Y`, o voto de `j` é sim exatamente acima do respectivo valor de continuação transportado. Para passar, `H` precisa comprar ao menos `k` votos. Como cada preço é estritamente positivo, qualquer proposta que paga mais de `k` fracos ou paga estritamente acima do limiar reduz o payoff de `H`; as únicas melhores propostas que passam são as coalizões mínimas descritas. Toda proposta com menos de `k` votos rejeita e entrega `D_M(o)`. No ramo de inclusão, `P_I>D_M`; no de exclusão, a comparação é exatamente `Z_E` contra `beta*o`. Portanto, passagem, rejeição ou mistura só podem ocorrer nas células declaradas. As estratégias de voto são sequencialmente ótimas após toda proposta, a crença pública é degenerada e a continuação M/S é uma PBE congelada. Reciprocamente, cada binder descrito satisfaz essas condições. QED.

## 4. Jogo público de agenda sob unanimidade

Todos os `m` fracos são necessários. Cada um vota sim se e somente se

```text
x_j>=r_U(o)=beta*(1-beta*o)/m.
```

A única proposta ótima que passa é uniforme:

```text
x_j=r_U(o) para todo j,
h_U(o)=1-m*r_U(o)=1-beta+beta^2*o.
```

Rejeição dá `D_U(o)=beta^2*o`, de modo que

```text
h_U(o)-D_U(o)=1-beta>0.
```

**Teorema AR-MSB-T2 — PBE pública de unanimidade.** Para cada tipo público, a proposta, os votos no caminho, o resultado e o payoff são únicos: acordo imediato na alocação acima. Fora do caminho, cada fraco segue seu limiar e a continuação literal é a selecionada por M/S.

**Prova.** Comprar menos de todos falha; pagar acima do limiar reduz estritamente o residual; pagar exatamente todos os limiares passa por `T^Y`. Essa proposta domina estritamente qualquer rejeição pela margem `1-beta`. QED.

## 5. Benchmark institucional público

Defina

```text
G(o)=h_M(o)-h_U(o).
```

Então

```text
G(o)=beta*(c/m)*(1-beta*o),
       se o<=1/m;

G(o)=beta*(c/m-beta*o),
       se o>1/m e beta*o<=Z_E;

G(o)=(1-beta)*(beta*o-1),
       se o>1/m e beta*o>=Z_E.
```

As duas últimas expressões coincidem quando `beta*o=Z_E`. O primeiro ramo é estritamente positivo. No ramo `o>1/m`, o sinal global simplifica para

```text
sign G(o)=sign(c/m-beta*o).
```

Isso é consistente com o ramo de atraso porque `Z_E>c/m`: se `beta*o>=Z_E`, então `G(o)<0`. Logo, com informação pública, maioria favorece `H` para tipos com custo externo suficientemente baixo, mas unanimidade pode favorecê-lo quando a continuação majoritária torna o atraso atraente ou quase atraente.

O vetor público e sua imagem ex ante são

```text
H_g^pub=(h_g(o_0),h_g(o_1)),
H_g^{pub,E}=(1-nu)h_g(o_0)+nu*h_g(o_1),
G_E=(1-nu)G(o_0)+nu*G(o_1).
```

Embora o payoff de maioria seja singleton por tipo, a lei pública de acordo é set-valued no empate `beta*o_theta=Z_E`.

## 6. Rendas informacionais com agenda

Para cada binder privado de `A_g`, defina

```text
RI_g^{A,theta}=V_g^theta-h_g(o_theta),
RI_g^{A,E}=(1-nu)RI_g^{A,0}+nu*RI_g^{A,1}.
```

**Teorema AR-MSB-T3 — tradução exata.** Na fibra `eta`, o conjunto de rendas de agenda é a translação do conjunto vetorial privado completo:

```text
RI_g^{A,01}(d,eta)
 =V_g^{01}(d,eta)-(h_g(o_0),h_g(o_1)).
```

A imagem ex ante é aplicada depois ao mesmo vetor ligado. A translação não seleciona proposta, continuação, law ou payoff privado e aplica zero novos fatores de `beta`.

**Prova.** O benchmark público por tipo tem payoff de `H` único. Subtrair um vetor fixo de cada vetor privado preserva exatamente a atomicidade, a multiplicidade e a ligação entre tipos da fonte. QED.

Para maioria, essa expressão set-valued é o resultado fechado: cada binder de `A_M` congelado gera uma e somente uma renda por subtração. `A_R` não substitui a correspondência por seus envelopes.

## 7. Forma fechada das rendas sob unanimidade

Use

```text
z_L=1-beta+beta^2*o_0=h_U(o_0),
z_H=1-beta+beta^2*o_1=h_U(o_1),
d_H=beta^2*o_1,
D_2=z_H-z_L=beta^2*(o_1-o_0)>0,
u_min=max{z_L,d_H},
z_E(nu)=(1-nu)z_L+nu*z_H.
```

Importando exatamente as fibras congeladas de `A_U`:

| Fibra | Renda por tipo `RI_U^{A,01}` | Renda ex ante |
|---|---|---|
| `nu=0` | `(0, max{z_L,d_H}-z_H)` | `0` |
| `0<nu<=nu_star`, `Delta_U>=0`, `rho=0` | `(0,-D_2)` | `-nu*D_2` |
| prior baixo, demais fibras | `none` | `none` |
| `nu_star<nu<1`, `rho=0` | `{(u-z_L,u-z_H):u in [u_min,z_H]}` | `[u_min-z_E(nu), z_H-z_E(nu)]` |
| `nu_star<nu<1`, `nu_off in (nu_star,1]` | `(D_2,0)` | `(1-nu)D_2` |
| prior alto, `nu_off in (0,nu_star]` | `none` | `none` |
| `nu=1` | `(D_2,0)` | `0` |

No endpoint `nu=0`, a coordenada do tipo de probabilidade zero permanece no vetor e é estritamente negativa; ela apenas recebe peso zero ex ante.

**Corolário AR-MSB-C1 — incidência da informação sob unanimidade.** Em toda fibra existente, a renda de agenda do tipo baixo é não negativa, a do tipo alto é não positiva, e ao menos uma desigualdade é estrita.

**Prova.** Nos pontos discretos, a afirmação é imediata. Na família alta com `rho=0`, `u>=u_min>=z_L` e `u<=z_H`; como `z_H>z_L`, ambas as coordenadas não podem ser zero ao mesmo tempo. QED.

A renda ex ante nessa família pode ser negativa, zero ou positiva. Isso não contradiz o corolário: o prior decide qual dos dois efeitos de sinalização recebe mais peso.

## 8. Diferença institucional das rendas

Seja

```text
delta_theta=V_U^theta-V_M^theta
```

o contraste privado congelado em `A_C`. Como o contraste público é

```text
h_U(o_theta)-h_M(o_theta)=-G(o_theta),
```

temos a identidade fundamental:

```text
DeltaRI_A^theta
 =RI_U^{A,theta}-RI_M^{A,theta}
 =delta_theta+G(o_theta),

DeltaRI_A^E=delta_E+G_E.
```

**Teorema AR-MSB-T4 — decomposição institucional.** Cada diferença privada `U-M` é exatamente a soma do contraste público `U-M` e da diferença de rendas:

```text
delta_theta=-G(o_theta)+DeltaRI_A^theta.
```

Assim, `H` prefere unanimidade no jogo privado para o tipo `theta` se e somente se

```text
DeltaRI_A^theta>G(o_theta),
```

com igualdade no empate. O limiar pode ser positivo ou negativo porque a agenda pública não favorece sempre a mesma regra.

**Prova.** Expanda as duas definições e cancele `V_U,V_M,h_U,h_M`. A versão ex ante segue pela combinação afim do vetor ligado. QED.

Sob a condição suficiente `T5` de `A_C`, `beta*o_1<c/m`, vale

```text
delta_theta<=-g_T5,
g_T5=beta*(c/m-beta*o_1)>0,
```

e portanto

```text
DeltaRI_A^theta<=G(o_theta)-g_T5.
```

Esse corolário não afirma que a diferença de rendas seja negativa; afirma que ela fica ao menos `g_T5` abaixo do necessário para reverter a vantagem privada garantida da maioria.

## 9. Interação com o benchmark sem agenda

Seja `RI_g^{N,R1,01}` a correspondência de renda sem agenda de `N7`, em
unidades nativas de `R1`. Para comparar na data `A`, defina

```text
RI_g^{N,A,01}=beta*RI_g^{N,R1,01},
I_g^{01}=RI_g^{A,01}-RI_g^{N,A,01}.
```

O fator `beta` transporta a renda sem agenda exatamente uma vez de `R1` para
`A`. A diferença de Minkowski usa vetores completos e produtos de binders nas
mesmas primitivas. Isso mede como a introdução da agenda muda a renda
informacional. Não mede uma diferença realização a realização e não presume um
sorteio comum.

Para maioria:

```text
I_M^{01}(d,eta)
 =RI_M^{A,01}(d,eta)-beta*RI_M^{N,R1,01}(d),
```

onde as fontes sem agenda são exatamente `N7-RI-M-II`, `N7-RI-M-IX` ou `N7-RI-M-XX`. Essa forma set-valued é mantida: não há sinal geral sem selecionar as correspondências das duas arquiteturas.

Para unanimidade, `N7` permite forma fechada.

### 9.1 Endpoint `nu=0`

Como `RI_U^{N,R1,01}=(0,0)`,

```text
I_U^{01}=(0,max{z_L,d_H}-z_H).
```

A coordenada alta é estritamente negativa; a imagem ex ante é zero.

### 9.2 Prior baixo positivo

Para `0<nu<=nu_star`, `N7` tem `RI_U^N=none` sob votos puros. Logo `I_U=none`, mesmo quando a fibra de agenda `A_U` existe. A renda de agenda existente não é apagada.

### 9.3 Prior alto, `rho=0`

Escreva

```text
d=beta*(o_1-o_0).
```

Como `RI_U^{N,R1,01}=(d,0)`, sua imagem na data `A` é
`(beta*d,0)=(D_2,0)`. Portanto,

```text
I_U^{01}
 ={(u-z_L-D_2,u-z_H):u in [u_min,z_H]}
 ={(u-z_H,u-z_H):u in [u_min,z_H]}.
```

Para todo membro,

```text
u-z_H<=0
```

nas duas coordenadas. A interação é estritamente negativa para ambos os tipos
quando `u<z_H` e é `(0,0)` no membro eficiente `u=z_H`. Sua imagem ex ante é o
mesmo escalar `u-z_H`, no intervalo `[u_min-z_H,0]`.

### 9.4 Prior alto, crença off-path alta, e `nu=1`

```text
I_U^{01}=(0,0).
```

As rendas com e sem agenda coincidem depois de expressas na mesma data.

**Teorema AR-MSB-T5 — sinal da interação sob unanimidade.** Em toda fibra
alta na qual a interação existe, agenda reduz fracamente a renda informacional
dos dois tipos. A redução é estrita para ambos exatamente nos membros `rho=0`
com `u<z_H`; ela é zero no membro `u=z_H`, na família de crença off-path alta
e em `nu=1`. Em `nu=0`, reduz estritamente apenas a coordenada contrafactual
alta; em prior baixo positivo, a interação é `none` porque a renda sem agenda
é `none`.

Esse resultado não diz que agenda reduz o payoff de `H`: compara a vantagem da informação privada em dois jogos diferentes.

## 10. Interação institucional

Quando `A_C` e o contraste sem agenda de `N7` existem, defina

```text
DeltaI^{01}
 =DeltaRI_A^{01}-beta*DeltaRI_N^{R1,01}.
```

É a mudança causada pela agenda na diferença `U-M` das rendas informacionais. A imagem exata vem de um par formado por um binder completo de `A_C` e um registro completo de contraste de `N7`; não se combinam coordenadas de registros distintos. Se qualquer fonte é `none`, `DeltaI` é `none`.

Essa definição é formalmente identificada sem uma nova seleção. Um ranking de `DeltaI` continua set-valued sempre que qualquer fonte o for.

## 11. Fatorização e multiplicidade econômica

Na maioria pública, diferentes loterias correntes sobre coalizões mínimas são assessments distintos na camada exata. Todas têm o mesmo multiconjunto anônimo de pagamentos, o mesmo payoff de `H` e a mesma probabilidade de acordo, salvo a mistura passagem-atraso no limiar `beta*o=Z_E`.

Por isso, os operadores de payoff e renda fatoram pelo resumo econômico público e pelos resumos econômicos privados já aprovados. A fatorização não identifica propostas nomeadas, não iguala loterias de coalizão e não transforma o baricentro de Reynolds em PBE.

## 12. Existência, `none` e escopo

- Os quatro jogos públicos por regra e tipo sempre possuem PBE.
- `RI_g^A` existe exatamente onde a fonte privada `A_g` existe.
- `DeltaRI_A` existe exatamente onde `A_C` existe.
- `I_g` existe exatamente onde as rendas com agenda e sem agenda na data
  `R1` existem; a segunda é então transportada para `A`.
- `DeltaI` existe exatamente onde `DeltaRI_A` e `DeltaRI_N^{R1}` existem.
- Nenhuma ausência recebe `0`, `NA`, infinito ou payoff fictício.

## 13. O que está e não está provado

Estão provados no candidato: as correspondências públicas; os payoffs públicos; a possibilidade de atraso majoritário; a fórmula e o sinal do gap público; as traduções exatas de renda; a decomposição `delta=-G+DeltaRI_A`; as fibras fechadas de renda e interação sob unanimidade; e as regras de existência.

Permanecem deliberadamente set-valued: a renda de maioria, a diferença institucional herdada de `A_C`, a interação de maioria e a interação institucional. Não se reivindica um sinal geral onde as fontes não o identificam.

O verificador mecânico é evidência de falsificação finita, não parecer matemático. O candidato permanece `unreviewed/unfrozen`; manuscrito, tag, merge e push não estão autorizados.
