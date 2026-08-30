# `A_T` — efeito total do poder de agenda

**Data:** 2026-08-30  
**Status:** `IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Efeito de agenda:** `com agenda - sem agenda`  
**Contraste institucional:** `U-M`

## 1. Resultado central

O efeito causal estrutural da agenda sob informação privada é

```text
T_g^theta=V_g^{A,theta}-beta*V_g^{N,R1,theta}.
```

Ele compara o jogo com agenda e informação privada ao jogo com **informação
apenas**, isto é, informação privada sem a oportunidade anterior de agenda.

Para cada regra,

```text
T_g^theta=D_g^theta+I_g^theta,
```

onde `D_g` é o efeito direto sob informação completa e `I_g` é a interação
agenda × informação já congelada em `A_R`. A antiga interação, isoladamente,
não era o efeito total.

## 2. Tabela fatorial

Todos os valores abaixo estão na data `A`:

| braço | informação completa | informação privada |
|---|---|---|
| sem agenda | `beta*h_g^{N,R1}(o_theta)` | `beta*V_g^{N,R1,theta}` |
| com agenda | `h_g^A(o_theta)` | `V_g^{A,theta}` |

As quatro diferenças relevantes são:

```text
agenda sob CI:        D_g=h_g^A-beta*h_g^N,
agenda sob PI:        T_g=V_g^A-beta*V_g^N,
informação sem agenda: beta*RI_g^N,
informação com agenda: RI_g^A.
```

A diferença de diferenças é

```text
I_g=T_g-D_g=RI_g^A-beta*RI_g^N.
```

**Teorema AT-MSB-T1 — identidade fatorial.** Para todo registro completo no
qual os dois braços existem, `T_g=D_g+I_g`, por tipo e ex ante.

**Prova.** Substitua `V=h+RI` nos dois braços, transporte o braço sem agenda
por `beta` uma única vez e reagrupe. A versão ex ante aplica o mesmo mapa afim
ao vetor ligado. QED.

## 3. Efeito direto sob informação completa

Use

```text
m=N-1,
k=q-1,
c=m-k,
Z_E=1-k*beta/m,
tau_M=Z_E/beta.
```

### 3.1 Unanimidade

As fontes congeladas dão

```text
h_U^A(o)=1-beta+beta^2*o,
h_U^{N,R1}(o)=beta*o.
```

Logo

```text
D_U(o)=h_U^A(o)-beta*h_U^{N,R1}(o)=1-beta>0.
```

**Teorema AT-MSB-T2 — efeito público sob unanimidade.** Dar a `H` a etapa
anterior de agenda aumenta seu payoff sob informação completa exatamente em
`1-beta`, para todo tipo e toda `o in (0,1)`.

### 3.2 Maioria

Se `o<=1/m`, o benchmark sem agenda inclui `H` e o jogo de agenda aprova
imediatamente. Portanto

```text
D_M(o)
 =1-k*beta*(1-beta*o)/m-beta^2*o
 =Z_E-(c/m)*beta^2*o.
```

Além disso,

```text
D_M(o)-(1-beta)=beta*(c/m)*(1-beta*o)>0.
```

Se `o>1/m`, o benchmark sem agenda dá `o` em `R1`, enquanto agenda dá
`max{Z_E,beta*o}` em `A`. Logo

```text
D_M(o)=max{Z_E-beta*o,0}.
```

Equivalentemente,

```text
D_M(o)=
  Z_E-(c/m)*beta^2*o,  se o<=1/m;
  Z_E-beta*o,          se 1/m<o<tau_M;
  0,                   se o>=tau_M.
```

**Teorema AT-MSB-T3 — efeito público sob maioria.** O efeito direto da agenda
é estritamente positivo para `o<tau_M`, com a fórmula de inclusão própria em
`o<=1/m`, e é zero para `o>=tau_M`. Nunca é negativo.

**Intuição.** Com outside option baixa ou moderada, `H` usa a oportunidade
anterior para obter acordo antes da continuação. Com outside option alta, sua
melhor proposta induz atraso e entrega exatamente `beta*o`, o mesmo valor do
controle sem agenda transportado para `A`; a oportunidade de propor não tem
valor direto.

### 3.3 Qual regra converte melhor agenda em payoff?

Defina `DeltaD(o)=D_U(o)-D_M(o)`. Então

```text
DeltaD(o)=
 -beta*(c/m)*(1-beta*o), se o<=1/m;
 beta*(o-c/m),           se 1/m<o<=tau_M;
 1-beta,                 se o>=tau_M.
```

As expressões dos dois últimos ramos coincidem em `o=tau_M`. Assim:

- em `o<=1/m`, agenda produz ganho direto maior sob maioria;
- em `1/m<o<tau_M`, o corte é `o=c/m`;
- depois do limiar de atraso majoritário, somente unanimidade conserva o ganho
  direto `1-beta`.

Quando `c/m=1/m`, a igualdade `o=c/m` pertence ao primeiro ramo pela seleção
congelada de `N7`; não se substitui essa fronteira pela fórmula aberta do
segundo ramo.

## 4. Efeito total sob informação privada: unanimidade

Use

```text
nu_star=(o_1-o_0)/(1-o_0),
z_L=1-beta+beta^2*o_0,
d_H=beta^2*o_1,
z_H=1-beta+beta^2*o_1,
Delta_U=z_L-d_H,
u_min=max{z_L,d_H}.
```

Como `D_U=(1-beta,1-beta)`, transladar as células de interação de `A_R`
produz as células exatas do efeito total.

### 4.1 Endpoint `nu=0`

```text
T_U^{01}=(1-beta,max{Delta_U,0}),
T_U^E=1-beta.
```

A segunda coordenada é contrafactual para um tipo de probabilidade zero.

### 4.2 Prior baixo positivo

Para `0<nu<=nu_star`, o jogo sem agenda sob unanimidade tem `none` sob votos
puros. Logo

```text
T_U=none.
```

Isso não apaga uma célula de agenda existente; apenas impede formar o efeito
causal porque o braço de controle não possui PBE no conceito mantido.

### 4.3 Prior alto, crença off-path baixa

Se `nu_star<nu<1` e `rho=0`, o payoff de agenda é comum aos tipos,

```text
u in [u_min,z_H],
```

e o controle sem agenda transportado dá `d_H` a ambos. Portanto

```text
T_U^{01}={(u-d_H,u-d_H):u in [u_min,z_H]},
T_U^theta in [max{Delta_U,0},1-beta].
```

O efeito é fracamente positivo para ambos. Ele é zero apenas no membro
`u=d_H` quando `d_H>=z_L`; é estritamente positivo nos demais membros.

### 4.4 Prior alto, crença off-path alta, e `nu=1`

```text
T_U^{01}=(1-beta,1-beta).
```

**Teorema AT-MSB-T4 — agenda versus informação apenas sob unanimidade.** Em
toda célula em que os dois braços possuem PBE, introduzir a etapa de agenda sob
informação privada beneficia fracamente cada tipo de `H`. O ganho máximo é
`1-beta`; zero é possível somente na célula alta `rho=0` descrita acima. Em
prior baixo positivo, o efeito é `none`, não zero.

## 5. Efeito total sob informação privada: maioria

Para cada tipo, forme o vetor fixo

```text
D_M^{01}=(D_M(o_0),D_M(o_1)).
```

`A_R` preserva o conjunto exato

```text
I_M^{01}=RI_M^{A,01}-beta*RI_M^{N,R1,01}
```

sobre produtos de registros completos. Portanto o efeito causal
selection-free é exatamente

```text
T_M^{01}=D_M^{01}+I_M^{01}.
```

**Teorema AT-MSB-T5 — agenda versus informação apenas sob maioria.** O
conjunto total é a translação de `I_M` pelo vetor público fixo `D_M`. Ele
existe exatamente onde a fonte de agenda e o registro aplicável de renda de
`N7` existem. Nenhuma seleção adicional é introduzida.

Para cada coordenada `theta`:

```text
T_M^theta>0  sse I_M^theta>-D_M(o_theta),
T_M^theta=0  sse I_M^theta=-D_M(o_theta),
T_M^theta<0  sse I_M^theta<-D_M(o_theta).
```

Quando `o_theta>=tau_M`, `D_M(o_theta)=0`: todo o efeito total da agenda sob
informação privada vem da interação informacional `I_M^theta`. Nas demais
células, o ganho público positivo pode ser reforçado ou revertido pela
interação.

Como `I_M` é set-valued nas fontes congeladas, não há sinal geral autorizado
para `T_M`. Um sinal é robusto somente se a imagem exata inteira permanece do
mesmo lado de `-D_M`.

## 6. Diferença institucional dos efeitos causais

Defina

```text
DeltaT^theta=T_U^theta-T_M^theta,
DeltaD^theta=D_U^theta-D_M^theta,
DeltaI^theta=I_U^theta-I_M^theta.
```

**Teorema AT-MSB-T6 — diferença de diferenças.** Em todo produto completo no
qual as fontes existem,

```text
DeltaT^theta=DeltaD^theta+DeltaI^theta.
```

Logo agenda beneficia mais `H` sob unanimidade se e somente se

```text
DeltaI^theta>-DeltaD^theta.
```

Interpretação:

- quando `DeltaD<0`, maioria converte diretamente a agenda em mais payoff; a
  interação precisa ser suficientemente favorável à unanimidade para inverter;
- quando `DeltaD>0`, unanimidade tem vantagem direta, mas a interação pode
  reduzi-la ou revertê-la;
- quando `DeltaD=0`, a interação decide sozinha.

`DeltaT` permanece set-valued sempre que `DeltaI` ou qualquer efeito de regra
o for. As coordenadas só podem ser subtraídas dentro de tuplas completas.

## 7. Agenda apenas versus informação apenas

O contraste diagonal é

```text
Q_g^theta=h_g^A(o_theta)-beta*V_g^{N,R1,theta}
         =D_g^theta-beta*RI_g^{N,R1,theta}.
```

Ele é substantivamente útil, mas muda simultaneamente poder de agenda e regime
informacional. Portanto não é um efeito causal puro de agenda nem de
informação.

Sob unanimidade:

```text
nu=0:              Q_U^{01}=(1-beta,1-beta);
0<nu<=nu_star:     Q_U=none;
nu_star<nu<=1:     Q_U^{01}=(Delta_U,1-beta).
```

Na região alta, o tipo baixo pode preferir "informação apenas" quando
`Delta_U<0`, enquanto o tipo alto prefere estritamente "agenda apenas". A
imagem ex ante é

```text
Q_U^E=1-beta-(1-nu)*beta^2*(o_1-o_0).
```

Sob maioria, `Q_M` é a imagem exata

```text
Q_M^{01}=D_M^{01}-beta*RI_M^{N,R1,01}
```

dos registros aplicáveis de `N7` e permanece set-valued onde a renda sem
agenda o é.

## 8. O que está provado e o que permanece aberto

O candidato prova por tradução de fontes congeladas:

- o desenho fatorial e as identidades `T=D+I` e `DeltaT=DeltaD+DeltaI`;
- os efeitos diretos fechados sob `U` e `M`;
- a comparação direta `DeltaD` por ramos;
- a classificação completa de `T_U`;
- a representação exata selection-free de `T_M` e `DeltaT`;
- o contraste diagonal `Q_U` e a representação de `Q_M`;
- as regras de existência e `none`.

Permanecem deliberadamente set-valued: `T_M`, `DeltaT` e `Q_M`. Não há
afirmação empírica, seleção cross-world ou claim de que uma checagem mecânica
substitui revisão matemática.
