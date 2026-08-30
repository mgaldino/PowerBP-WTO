# Correspondência de `A_U` sob M/S/B — arquitetura em duas camadas

**Data:** 2026-08-30
**Status:** reimplementação autorizada concluída pelo implementador;
`pending/unfrozen`; dois novos pareceres independentes e aprovação autoral
terminal ainda necessários
**Dependência única:** `C_U`, SHA-256
`f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`  
**Proveniência:** a correspondência estratégica foi reconstruída cegamente em
2026-08-29 e preservada nesta reimplementação. A decisão autoral específica de
2026-08-30 altera somente a arquitetura de identidade e consumo downstream.

As skills `solve-dynamic-games` e `formal-game-theory-polisci` governaram o
contrato, o DAG, a ordem reversa, a racionalidade sequencial e os gates. O R
associado testa identidades e testemunhas; não prova completude de PBE.

## 1. Notação e interface reduzida provada a partir de `C_U`

Para `m=N-1>=2`, `0<o_0<o_1<1` e `beta in (0,1)`, escreva

```text
nu_star = (o_1-o_0)/(1-o_0)
ell     = beta o_0
h       = beta o_1
d_0     = beta ell = beta^2 o_0
d       = beta h   = beta^2 o_1
a       = beta(1-ell)/m
b       = beta(1-h)/m
z_L     = 1-ma = 1-beta+d_0
z_H     = 1-mb = 1-beta+d
Delta   = z_L-d = 1-beta-beta^2(o_1-o_0).
```

O fator externo `beta` que leva `ell,h,(1-ell)/m,(1-h)/m` da data nativa
de `C_U` à data `A` aparece uma única vez. O `beta` interno de `ell` e `h`
já pertence a `C_U` e não é reaplicado dentro da continuação.

O domínio consumível é

```text
D_C={0} union (nu_star,1].
```

Uma crença em `(0,nu_star]` exigiria a célula `none` de `C_U`; o assessment
inteiro é então inadmissível, sem payoff convencional.

Em `mu=0`, cada fraco aceita sse `x_j>=a`; em `mu>nu_star`, aceita sse
`x_j>=b`. A igualdade passa por `T^Y`. Logo

```text
y_L=(z_L,a,...,a) in Y,
y_bar=y_H=(z_H,b,...,b) in Y
```

são os únicos pacotes que dão a `H` a parcela máxima sob, respectivamente, o
preço baixo-posterior e o preço alto-posterior. Em particular, `y_bar` está no
domínio primitivo `Y`.

Ao rejeitar, o tipo 1 recebe sempre `d`; o tipo 0 recebe `d_0` em `mu=0` e
`d` em `mu>nu_star`. Valem

```text
0<b<a,  d_0<d,  z_L=d_0+1-beta,  z_H=d+1-beta,
z_L<z_H,  z_H>d.
```

## 2. Objetos conjuntos e condição de Bayes

Uma família é parametrizada por um binder atômico

```text
R=(sigma_0,sigma_1,mu,nu_off,hat{kappa}_U,v,Q,Gamma_0,Gamma_1),
```

em que:

- `sigma_theta` é a medida Borel de proposta do tipo `theta`;
- `mbar=(1-nu)sigma_0+nu sigma_1`;
- `mu` é o limite local de Bayes em todo ponto disciplinado e é `nu_off` em
  todo ponto não disciplinado;
- `nu_off` é único, pertence a `D_C` e respeita os endpoints do prior;
- `hat{kappa}_U(mu)` escolhe um membro literal completo, anônimo, de `C_U` no
  mesmo hash: `N4-SC-EQ-L-STAR` em zero e um membro literal
  `N4-SC-EQ-P-STAR` em posterior alto; toda multiplicidade interna fica no
  binder e a escolha depende somente de `(U,C,mu)`;
- `v` é o vetor das estratégias puras de voto definido no contrato;
- `Q_theta(y)` é a lei terminal literal: alocação imediata se passa, ou a lei
  do membro completo `hat{kappa}_U(mu(y))` se rejeita;
- `Gamma_theta` é o pushforward de `sigma_theta` pelo registro realizado
  completo `(y,mu(y),v(y),pass/reject,hat{kappa}_U,Q_theta,payoffs na data A)`.

Para todos os pontos disciplinados, e não apenas quase certamente, o limite
local deve existir e cair em `D_C`. Além disso, nenhum ponto disciplinado pode
oferecer desvio lucrativo; essa condição pointwise inclui pontos-limite com
massa pontual zero. Nos pontos não disciplinados vale o mesmo teste usando o
único `nu_off`.

O binder completo continua indivisível: estratégias, crenças, votos,
continuações e leis terminais não podem ser recombinados entre assessments.
Por decisão autoral específica de 2026-08-30, sua imagem realizada admite duas
camadas. `Sig_ex_U` codifica exatamente a órbita diagonal do par
`(Gamma_0,Gamma_1)`; `Sum_econ_U` apaga nomes registro a registro e preserva
somente estatísticas econômicas anônimas. Nenhuma delas impõe simetria à
estratégia corrente de `H`, e operações sensíveis a funções off-path continuam
a consumir o binder subjacente.

## 3. Lemas de redução

### Lema 1 — domínio de crenças

Em todo PBE admissível,

```text
mu(y) in D_C em todo ponto disciplinado,
nu_off in D_C.
```

**Prova.** Depois de qualquer proposta, um único voto `não` rejeita sob
unanimidade. `No signaling what you do not know` mantém o posterior associado
à proposta. Racionalidade sequencial exige uma continuação literal após esse
desvio. `C_U` não contém continuação em `(0,nu_star]`. QED.

### Lema 2 — votos e fronteiras fechadas

Fixada uma crença admissível, `j` vota `sim` sse `x_j>=a` em zero e sse
`x_j>=b` em posterior alto. Os conjuntos de aprovação são fechados, porque a
igualdade é aceita. Seus máximos para `H` são atingidos em `y_L` e `y_H`.

### Lema 3 — imitação e payoff comum no interior

Para `0<nu<1`, os dois tipos têm o mesmo payoff interino `V` em qualquer PBE.

**Prova.** Todo sinal usado pelo tipo 1 tem posterior alto. Se esse sinal
passa, o tipo 0 pode imitá-lo e obter a mesma parcela; se rejeita, ambos obtêm
`d`. Um sinal de posterior zero usado pelo tipo 0, quando existe com massa
positiva, não pode rejeitar em equilíbrio: o tipo 1 obteria `d` ao imitá-lo,
e o tipo 0 poderia imitar um melhor sinal do tipo 1. Logo ele passa; o tipo 1
pode imitá-lo e receber a mesma parcela. Nos perfis sem massa de posterior
zero, todos os sinais usados são altos e o mesmo argumento bilateral aplica.
Mistura requer indiferença em cada suporte. QED.

### Lema 4 — dicotomia da massa de posterior zero

Defina

```text
lambda_0 = integral 1{mu(y)=0} dmbar(y).
```

Se `lambda_0>0`, então necessariamente

```text
nu_off=0, Delta>=0, V=z_L,
sigma_0({y_L})>0, sigma_1({y_L})=0,
```

e `y_L` é o único sinal de posterior zero usado com massa positiva. Se
`lambda_0=0`, Bayes plausibility e `mu>nu_star` quase certamente implicam
`nu>nu_star`.

**Prova.** Um tipo 0 que usa posterior zero pode obter no máximo `z_L`, e só
`y_L` atinge esse máximo. O tipo 1 garante `d` por uma proposta rejeitada. A
imitação do Lema 3 exige `V>=d`; uma proposta off-path aceita garante `z_L`
quando `nu_off=0`, enquanto `nu_off` alto daria o desvio `y_H` com `z_H`.
Logo `V=z_L>=d`, `nu_off=0`, e factibilidade torna `y_L` único. Se não há
massa em zero, a média Bayesiana de posteriores estritamente maiores que
`nu_star` é também estritamente maior que `nu_star`. QED.

## 4. Teorema de classificação completa

Além dos endpoints da Seção 5, todo PBE interior pertence exatamente a uma
das famílias abaixo. As condições sobre limites locais são parte substantiva
da família e não são delegadas ao verificador.

### Família `AU-MSB-L` — há massa em posterior zero

**Domínio necessário e suficiente:**

```text
0<nu<1,
Delta>=0,
nu_off=0.
```

**Member generator.** Escolha medidas Borel `sigma_0,sigma_1` tais que:

1. `sigma_0({y_L})=alpha>0` e `sigma_1({y_L})=0`;
2. o limite local de Bayes existe em todo ponto disciplinado e pertence a
   `D_C`;
3. fora de `y_L`, o posterior é alto `mbar`-quase certamente;
4. todo sinal usado fora de `y_L`:
   - passa e tem `z=z_L`; ou
   - somente se `Delta=0`, pode rejeitar (então entrega `d=z_L`);
5. todo ponto disciplinado, inclusive ponto-limite de massa zero, dá a cada
   tipo payoff de desvio no máximo `z_L`;
6. nos pontos não disciplinados a crença zero também dá payoff de desvio no
   máximo `z_L`.

Os sinais altos que passam pertencem a

```text
K_L={y in Y: z=z_L, min_j x_j>=b}.
```

O conjunto não é reduzido a uma coalizão ou a uma mistura simétrica: alocações
assimétricas e medidas atomless são permitidas. O caso puro sempre existe sob
`Delta>=0`: tipo 0 escolhe `y_L`; tipo 1 escolhe

```text
y_S=(z_L,b,...,b),
```

que é distinto de `y_L`, tem posterior 1, passa e deixa folga. O tipo 0 não
imita estritamente, e o tipo 1 não ganha ao imitar `y_L`. Em `Delta=0`, o
sinal do tipo 1 pode ser qualquer proposta alta rejeitada, gerando a família
de atraso no knife-edge.

**Payoffs e outcomes.** `V_0=V_1=z_L`. Se `Delta>0`, todo sinal usado passa e
a probabilidade de acordo é 1 para os dois tipos. Se `Delta=0`, sinais altos
rejeitados podem receber massa; `Gamma_theta` registra separadamente a
probabilidade de acordo, atraso, posterior e lei terminal por tipo. Payoffs
fracos por identidade são

```text
x_j                 se a proposta passa;
a                    se rejeita em mu=0 e theta=0;
0                    se rejeita em mu=0 e theta=1;
b                    se rejeita em mu>nu_star (qualquer theta),
```

sempre vinculados ao mesmo membro literal de continuação.

### Família `AU-MSB-H` — posterior alto quase certamente

**Domínio necessário:** `nu_star<nu<1`.

#### Subfamília `H0`: `nu_off=0`

Escolha

```text
V in [max{z_L,d}, z_H].
```

As medidas Borel podem ser puras, discretas, semi-pooling ou atomless, desde
que:

1. `mu>nu_star` `mbar`-quase certamente e o limite local admissível exista em
   todo ponto disciplinado;
2. todo sinal usado que passa pertence a
   `K_H(V)={y in Y:z=V,min_j x_j>=b}`;
3. sinais usados que rejeitam são permitidos somente se `V=d`;
4. todo ponto disciplinado dá payoff de desvio no máximo `V`;
5. todo ponto não disciplinado usa crença zero e dá payoff de desvio no máximo
   `V`.

O payoff comum é `V`. Se `V>d`, acordo ocorre com probabilidade 1 por tipo. Se
`V=d`, cada tipo pode misturar sinais aceitos com `z=d` e sinais altos
rejeitados; `Gamma_theta` preserva as probabilidades e leis correspondentes.

Uma testemunha pura pooling para cada `V` é

```text
y(V)=(V,(1-V)/m,...,(1-V)/m),
sigma_0=sigma_1=delta_{y(V)},
mu(y(V))=nu,
```

pois `V<=z_H` implica `(1-V)/m>=b` e `V>=max{z_L,d}` elimina os desvios com
crença off-path zero.

#### Subfamília `HB`: `nu_off in (nu_star,1]`

O desvio off-path `y_H` força `V>=z_H`; o limite de factibilidade força
`V=z_H`. A única proposta aceita com essa parcela é `y_H`. Portanto

```text
sigma_0=sigma_1=delta_{y_H},
mu(y_H)=nu,
V_0=V_1=z_H.
```

Há multiplicidade apenas em `nu_off` admissível e no binder literal interno
de `hat{kappa}_U`; não há multiplicidade de proposta, payoff ou outcome
corrente.

### Exaustão e não existência interior

Se `0<nu<=nu_star`, Bayes plausibility obriga `lambda_0>0`; portanto existe
PBE sse `Delta>=0`, e todos pertencem a `AU-MSB-L`.

Se `nu_star<nu<1`, existem sempre os PBEs high-only. Quando `Delta>=0`, a
família adicional `AU-MSB-L` também existe. Quando `Delta<0`, ela não existe.
Não há terceira família: `lambda_0` é positivo ou zero, e os lemas fixam a
estrutura de cada caso.

## 5. Endpoints

### `nu=0`

Suporte do prior fixa `mu(y)=nu_off=0` para toda proposta. O tipo 0 escolhe
unicamente `y_L` e recebe `z_L`. A estratégia contrafactual do tipo 1 é:

```text
Delta>0:  unicamente y_L, com payoff z_L>d;
Delta=0:  qualquer medida Borel suportada em {y_L} union R_L;
Delta<0:  qualquer medida Borel suportada em R_L,
R_L={y in Y:min_j x_j<a}.
```

Em `R_L`, a proposta rejeita e o tipo 1 recebe `d`. A medida do tipo de prior
zero não altera a crença pública, mas permanece no binder e na assinatura por
tipo. O tipo 0 tem acordo imediato com probabilidade 1.

### `nu=1`

Suporte do prior fixa `mu(y)=nu_off=1` para toda proposta. Ambos os tipos têm
`y_H` como única melhor resposta, pois `z_H=d+1-beta>d`. O resultado corrente
é pooling, acordo imediato e payoff `z_H` para cada tipo. A estratégia do tipo
zero também é preservada, apesar de contrafactual.

## 6. Estratégias puras, misturas, imitação e multiplicidade

- **Puras em prior baixo:** somente separating; sob `Delta>=0`, `H0` usa
  `y_L` e `H1` usa sinal distinto com posterior 1, aceito com parcela `z_L`,
  ou rejeitado no knife-edge `Delta=0`.
- **Puras em prior alto:** pooling em qualquer `y(V)` da família `H0`; pooling
  eficiente `y_H` para qualquer `nu_off` admissível; e separating da família
  `L` quando `Delta>=0`.
- **Misturas:** toda medida Borel que satisfaz o member generator, inclusive
  atomless. A regra local de Bayes precisa existir em todo ponto disciplinado,
  não só quase certamente.
- **Imitação:** aceitação dá a ambos a mesma parcela. Isso iguala payoffs no
  interior e impede separação por níveis distintos de `z`. Separação por
  vetores `x` distintos sobrevive porque a crença altera o preço de voto.
- **Atraso:** só entra no suporte quando o payoff comum é exatamente `d`.
  Na família com massa zero isso requer `Delta=0`; na família high-only requer
  `V=d`, possível sse `d>=z_L`.
- **Identidades:** não se impõe simetria à proposta corrente. Relabelings pela
  mesma permutação comum formam uma órbita exata. Misturas com pesos diferentes
  sobre relabelings podem ter assinaturas exatas distintas e, quando não mudam
  Bayes nem outcomes anônimos, o mesmo resumo econômico.
- **Continuação:** multiplicidade interna de crenças/estratégias do membro
  literal de `C_U` é preservada por `hat{kappa}_U`; ela não altera os preços
  `a,b`, mas não pode ser desmontada em coordenadas independentes.

## 7. Ex ante e arquitetura de assinatura em duas camadas

Para todo binder `R`, a imagem ex ante de `H` é calculada somente depois dos
payoffs por tipo:

```text
V_H^A(R;nu)=(1-nu)V_0(R)+nu V_1(R).
```

No interior `V_0=V_1=V`, então a média é `V`; nos endpoints, as coordenadas
contrafactuais continuam registradas antes da média.

### 7.1 Lei conjunta realizada e ação dos nomes

Seja `Y` a simplex compacta de propostas. Tome `X_U={L,P}` com topologia
discreta: `L` identifica o membro literal `N4-SC-EQ-L-STAR` e `P`, o membro
literal `N4-SC-EQ-P-STAR`. Seja `Omega_D^U` o espaço compacto dos registros
terminais gerados por esses dois membros — identidade do fraco reconhecido,
alocação, vetor de votos, resultado e vetor de payoffs — e defina a união
disjunta

```text
Omega_T^U=({A} x Y) union_disjunta ({D} x Omega_D^U),
Z_U=Y x [0,1] x {0,1} x X_U x Omega_T^U.
```

Os fatores são compactos poloneses; logo `Z_U` é compacto polonês. Para cada
binder completo `R`, cada tipo `theta` induz

```text
Gamma_theta^{U,R}
 =Law_theta(y,mu(y),pass/reject,xi_U,omega_T) in P(Z_U).
```

O registro conserva conjuntamente proposta, posterior, timing, célula literal
e outcome terminal. Ele não desmonta `hat{kappa}_U`: toda multiplicidade de
funções e crenças off-path continua no binder que gera `Gamma_theta^{U,R}`.

Seja `G=S_m`. Para `g in G`, `T_g:Z_U->Z_U` aplica a mesma permutação às
coordenadas fracas da proposta, aos votos, à identidade reconhecida, à alocação
terminal e aos payoffs, e fixa `mu`, `pass/reject` e `xi_U`. Cada `T_g` é um
homeomorfismo. Se `R` é PBE sob M/S/B, então `g.R` também é: relabeling comuta
com o limite local de Bayes, o kernel literal é equivariante, o preço de voto é
comum e propostas, votos e desvios são levados bijetivamente a objetos com o
mesmo payoff.

Com

```text
X_U^law=P(Z_U)^2,
x_U(R)=(Gamma_0^{U,R},Gamma_1^{U,R}),
g.(Gamma_0,Gamma_1)=((T_g)#Gamma_0,(T_g)#Gamma_1),
```

`X_U^law` é polonês e a ação diagonal finita é Borel (na verdade, contínua).

### 7.2 Camada formal exata

Para `x in X_U^law`, defina

```text
Lambda_x=|G|^{-1} sum_(g in G) delta_(g.x) in P(X_U^law).
```

**Proposição AU-MSB-T5 (Borelidade, invariância e completude).** O mapa
`x -> Lambda_x` é Borel, `Lambda_(h.x)=Lambda_x` para todo `h in G`, e

```text
Lambda_x=Lambda_x'  sse  x' in G.x.
```

**Prova.** Para todo Borel `B subseteq X_U^law`,

```text
Lambda_x(B)=|G|^{-1} sum_g 1_B(g.x),
```

que é Borel em `x`. A translação `g -> gh` reordena a soma e prova
invariância. Se `x'=h.x`, as leis de órbita coincidem. Reciprocamente,
`{x'}` é Borel e

```text
Lambda_x'({x'})=|Stab_G(x')|/|G|>0.
```

Igualdade das medidas implica `Lambda_x({x'})>0`; portanto `g.x=x'` para
algum `g`. QED.

Para `0<nu<1`, reparametrize a crença off-path por

```text
nu_off=b_rho(nu)=nu rho/(1-nu+nu rho),  rho in [0,infinity],
```

com as extensões usuais `b_0(nu)=0` e `b_infinity(nu)=1`. Isso é apenas um
homeomorfismo da coordenada já existente `nu_off`, não uma crença adicional.
A assinatura formal exata é

```text
Sig_ex_U(R)=(rho(R),nu_off(R),Lambda_(x_U(R))).
```

Igualdade de `Sig_ex_U` exige a mesma fibra `(rho,nu_off)` e uma única
permutação comum aplicada ao par inteiro de leis. Quando a exposição precisar
de representante, fixe um isomorfismo Borel
`iota:X_U^law->B subseteq [0,1]` e escolha o elemento de `G.x` que minimiza
`iota`. O mínimo de uma órbita finita é Borel, pertence realmente à órbita e,
pelo fechamento acima, vem de um PBE relabelado. Não se seleciona no espaço
bruto de funções off-path e não se usa média de Reynolds como representante.

### 7.3 Camada de resumo econômico

Fixe um isomorfismo Borel `iota_U:Z_U->B_U subseteq [0,1]`. O mínimo de cada
órbita finita define uma transversal Borel `Z_U/G` e o quociente Borel
`q_U:Z_U->Z_U/G`, que satisfaz

```text
q_U compose T_g=q_U.
```

Defina

```text
Gamma_bar_theta^{U,R}=(q_U)#Gamma_theta^{U,R},
Sum_econ_U(R)
 =(rho(R),nu_off(R),Gamma_bar_0^{U,R},Gamma_bar_1^{U,R}).
```

O resumo é muitos-para-um. Não é assessment, não prova Bayes ou melhor resposta
e não substitui o binder.

**Lema de fatorização anônima.** Para todo espaço Borel-padrão `E` e toda
`f:Z_U->E` Borel e `G`-invariante, existe uma única Borel
`f_bar:Z_U/G->E` com `f=f_bar compose q_U`. Se `f` é real e integrável,

```text
integral f dGamma_theta
 =integral f_bar dGamma_bar_theta.
```

**Prova.** Defina `f_bar` na transversal pelo valor de `f` no representante
mínimo. Borelidade segue da transversal finita; invariância garante que a
definição independe do representante, e sobrejetividade de `q_U` dá unicidade.
A identidade de integrais é a definição de pushforward. QED.

Consequentemente, `Sum_econ_U` recupera, por tipo: payoff de `H`;
probabilidades de acordo e atraso; lei do posterior; célula `L/P`; lei da
proposta e do outcome terminal no quociente anônimo; multiconjunto ordenado dos
payoffs fracos; e a lei do payoff de uma identidade fraca sorteada
uniformemente. Proposta nomeada, payoff de um `W_j` específico, suporte
estratégico nomeado, mapa público `mu:Y->[0,1]`, coincidência de mensagens e
relação entre os planos contrafactuais permanecem fora do resumo.

Para pesos probabilísticos quaisquer `(q_g)`,

```text
(q_U)# [sum_g q_g (T_g)#Gamma_theta]
 =(q_U)#Gamma_theta.
```

Assim, alterar apenas os pesos sobre relabelings pode deixar `Sum_econ_U`
inalterado, embora a órbita exata mude.

### 7.4 Misturas, revelação e o certificado `P/Q`

O finding `R2-I-1` é resolvido pelas duas camadas. Considere

```text
N=3, beta=.9, o_0=.2, o_1=.5, nu=.6,
nu_star=.375, a=.369, b=.2475, d=.405,
z_L=.262, z_H=.505, Delta=-.143.
```

Na família `AU-MSB-H0`, com `nu_off=0` e `V=.45`, as propostas

```text
P=(.45,.3025,.2475),
Q=(.45,.2475,.3025)
```

passam, dão o mesmo payoff e são relabelings. Pooling puro em `P`, pooling puro
em `Q` e toda mistura comum
`p delta_P+(1-p)delta_Q` por ambos os tipos são PBEs e mantêm posterior `.6`.
A órbita diagonal identifica `p` somente com `1-p`; por exemplo, pesos
`(.9,.1)` e `(.5,.5)` dão `Sig_ex_U` distintos. Como `q_U(P)=q_U(Q)`, dão o
mesmo `Sum_econ_U`. O que a clarificação chamava de mesma classe econômica
fica no resumo sem apagar a diferença formal entre experimentos.

Se, ao contrário, os tipos atribuem pesos diferentes a mensagens comuns, as
razões de verossimilhança e os posteriores locais mudam. A lei do posterior
em `Gamma_bar_theta` também muda; nesse caso tanto `Sig_ex_U` quanto
`Sum_econ_U` distinguem o novo experimento.

O operador componentwise de Reynolds,

```text
Rey_cw(x)
 =(|G|^{-1} sum_g (T_g)#Gamma_0,
   |G|^{-1} sum_g (T_g)#Gamma_1),
```

é apenas estatística marginal. Ele não é invariante completo da órbita
diagonal, pode apagar a relação entre planos dos tipos, pode não pertencer à
imagem de nenhum assessment e sua igualdade implica apenas igualdade do
resumo marginal. Para ver a terceira limitação dentro de `A_U`, mantenha os
parâmetros e as propostas `P/Q` acima, mude o prior para `nu=.9` e use

```text
sigma_0=(.9 em P,.1 em Q),
sigma_1=(.1 em P,.9 em Q).
```

Bayes dá `mu(P)=.5` e `mu(Q)=81/82`, ambos acima de `nu_star=.375`; portanto o
binder pertence à mesma família high-only e as duas propostas passam com
payoff `.45`. A simetrização componentwise leva para a mesma proposta física
registros com os dois rótulos posteriores `.5` e `81/82`, porque `T_g` permuta
nomes, mas fixa o posterior. Isso não pode ser gerado por um único mapa público
`mu(y)`. Portanto Reynolds jamais é chamado de representante de PBE;
`Lambda_x` é um código explícito no metaespaço, não um assessment médio.

### 7.5 Endpoints e regra downstream

Nos endpoints, `nu_off=nu` em todo `Y` e todos os valores formais de `rho`
induzem a mesma crença. Defina, sem dividir por `nu` ou `1-nu`,

```text
Sig_ex_U(R)=(*,nu,Lambda_(x_U(R))),
Sum_econ_U(R)=(*,nu,(q_U)#Gamma_0^{U,R},(q_U)#Gamma_1^{U,R}).
```

A estratégia contrafactual do tipo de prior zero continua na lei por tipo.
Nenhum envelope marginal vira produto cartesiano.

Uma comparação futura deve primeiro formar, na mesma fibra de prior e
`(rho,nu_off)`, o produto das camadas exatas de `A_M` e `A_U`. Uma operação
`C` só pode substituir `Sig_ex` por `Sum_econ` depois de provar, na própria
fibra,

```text
Sum_econ(R)=Sum_econ(R')  =>  C(R)=C(R')
```

e uma fatorização mensurável `C=C_bar compose Sum_econ`. Para
correspondências, a prova deve ser setwise e preservar a regularidade usada;
ela não pode combinar coordenadas de assessments diferentes. Identidade
formal, Bayes, suportes, mensagens, mapa público, relação entre planos e toda
operação sensível a off-path usam `Sig_ex` e, quando necessário, o binder
completo. Esta seção fixa a interface de `A_U`; não inicia nem autoriza `AC`.

## 8. Prova de existência e limites

Cada família tem testemunha construtiva. Os conjuntos de aprovação contêm a
fronteira de indiferença por `T^Y`, de modo que `y_L`, `y_H` e `y(V)` atingem
os máximos declarados. Não se invoca semicontinuidade superior global do payoff.

O resultado não afirma que o verificador R provou ausência de todo desvio,
existência do limite local para toda medida ou completude das famílias. Essas
são as provas textuais acima e os pontos prioritários dos dois novos pareceres
independentes. A classificação permanece `pending/unfrozen` até esses pareceres
sobre os mesmos hashes, adjudicação e aprovação autoral terminal.

## 9. Invalidação

Mudança em `C_U`, no domínio `D_C`, no transporte temporal, em M/S/B, no voto
as-if-pivotal, em `T^Y`, na clarificação de anonimato ou na decisão autoral de
duas camadas de 2026-08-30 invalida todos os claims deste arquivo, o ledger, o
verificador e qualquer consumidor `AC/AR`.
