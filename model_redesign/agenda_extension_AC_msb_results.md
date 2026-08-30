# `A_C` sob M/S/B — comparação privada exata entre maioria e unanimidade

**Data:** 2026-08-30  
**Status:** `IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Orientação:** `U-M`  
**Dependências:** `A_M` e `A_U` nos respectivos manifestos finais congelados

Este documento não resolve novamente nenhum jogo. Ele integra as duas correspondências congeladas na mesma economia e na mesma convenção de crença fora do caminho. O objeto primário é um conjunto de pares de binders completos; payoffs, probabilidades e resumos são imagens posteriores desse conjunto.

## 1. Domínio, fibra e fontes

Fixe

```text
d=(N,m,q,k,beta,o_0,o_1,y_bar,Y,nu),
m=N-1,
q=floor(N/2)+1,
k=q-1,
c=m-k,
N>=3,
0<beta<1,
0<o_0<o_1<1,
o_1<=y_bar<=1,
nu in [0,1].
```

No prior interior, a fibra institucional comum é

```text
eta=(rho,p),
p=nu_off=b_rho(nu)=nu*rho/(1-nu+nu*rho).
```

Nos endpoints, `eta=(*,nu)`. A comparação principal nunca emparelha `p_M` com `p_U` diferente.

Denote por `B_M(d,eta)` e `B_U(d,eta)` os conjuntos de binders completos produzidos pelos pacotes congelados. Os hashes governantes são:

| Objeto | SHA-256 |
|---|---|
| resultados `A_M` | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` |
| manifesto final `A_M` | `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e` |
| contrato `A_U` | `348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26` |
| resultados `A_U` | `e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11` |
| interface `A_U` | `2ee931d21e3858db6702f78a4636d1f3c4b445910c8160120921c3bfc3b4b317` |
| manifesto final `A_U` | `b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180` |

## 2. Produto fibrado exato

Defina

```text
J_AC^bind(d,eta)
 =B_M(d,eta) times_(d,eta) B_U(d,eta).
```

O símbolo `times_(d,eta)` significa que os dois binders:

1. usam as mesmas primitivas `d`;
2. usam a mesma fibra `eta`;
3. pertencem integralmente às próprias correspondências congeladas;
4. preservam seus respectivos binders atômicos e hashes.

Não se exige que os jogos contrafactuais usem a mesma proposta, o mesmo suporte, a mesma seleção de continuação ou a mesma realização aleatória. O modelo não possui um dispositivo de correlação cross-world.

**Teorema AC-MSB-T1 — compatibilidade necessária e suficiente.**

`J_AC^bind(d,eta)` é exatamente o conjunto de comparações privadas admissíveis na fibra.

**Prova.** Necessidade: uma comparação institucional mantém fixa a economia e a convenção off-path; cada coordenada deve ser um PBE completo de sua regra, e a atomicidade proíbe splicing. Suficiência: qualquer par que satisfaça essas condições já é racional, Bayes-consistente e completo dentro da própria regra. Parear dois jogos contrafactuais não altera incentivos de nenhum deles. Não existe restrição cruzada adicional no game form. QED.

A imagem formal é

```text
J_AC^ex(d,eta)
 ={(Sig_ex_M(R_M),Sig_ex_U(R_U)):(R_M,R_U) in J_AC^bind(d,eta)}.
```

Operações sensíveis a funções off-path recebem também `(R_M,R_U)`; a palavra “exata” nas assinaturas refere-se à lei realizada enriquecida, conforme as decisões autorais.

## 3. Comparação econômica na data `A`

Para `g in {M,U}`, extraia do mesmo binder:

```text
V_g^theta       = payoff de H por tipo,
A_g^theta       = probabilidade de acordo imediato,
D_g^theta       = 1-A_g^theta,
Gamma_bar_g^theta = lei anônima do registro realizado,
theta in {0,1}.
```

Defina primeiro a coordenada ex ante derivada do vetor ligado do mesmo binder:

```text
V_g^E(R_g)=(1-nu)*V_g^0(R_g)+nu*V_g^1(R_g),
g in {M,U}.
```

Então,

```text
delta_theta=V_U^theta-V_M^theta,
delta_E=V_U^E-V_M^E=(1-nu)*delta_0+nu*delta_1,
Delta_A^theta=A_U^theta-A_M^theta,
Delta_D^theta=-Delta_A^theta.
```

O conjunto primário é

```text
K_AC^bind(d,eta)
 ={(R_M,R_U,
    V_M^0,V_M^1,V_U^0,V_U^1,
    delta_0,delta_1,delta_E,
    A_M^0,A_M^1,A_U^0,A_U^1,
    Delta_A^0,Delta_A^1,
    Gamma_bar_M^0,Gamma_bar_M^1,
    Gamma_bar_U^0,Gamma_bar_U^1):
    (R_M,R_U) in J_AC^bind(d,eta),
    todas as coordenadas são geradas pelo binder indicado}.
```

**Teorema AC-MSB-T2 — tipo antes do prior e zero desconto adicional.**

Para todo elemento de `K_AC^bind`,

```text
delta_E
=[(1-nu)V_U^0+nu V_U^1]-[(1-nu)V_M^0+nu V_M^1]
=(1-nu)delta_0+nu delta_1.
```

Todos os valores chegam na data `A`; `A_C` aplica fator 1 e zero fatores novos de `beta`.

**Prova.** A identidade é distributividade depois de importar os quatro valores por tipo. As fontes já efetuaram exatamente uma transformação `C_g -> A_g`; repeti-la mudaria a data do payoff. QED.

## 4. Prova de suficiência do resumo econômico

Para cada regra, o pacote congelado prova que existem extratores Borel das leis anônimas realizadas:

```text
H_g_theta(Sum_econ_g)=V_g^theta,
P_g_theta(Sum_econ_g)=A_g^theta,
L_g_theta(Sum_econ_g)=Gamma_bar_g^theta.
```

Esses extratores são integrais ou projeções de coordenadas Borel invariantes à permutação dos fracos. Forme

```text
C_bar_econ(s_M,s_U)
```

aplicando os extratores acima, subtrações e a combinação afim com pesos `(1-nu,nu)`.

**Teorema AC-MSB-T3 — fatorização mensurável por operação.**

Na mesma fibra `eta`,

```text
C_econ(R_M,R_U)
 =C_bar_econ(Sum_econ_M(R_M),Sum_econ_U(R_U)).
```

`C_bar_econ` é Borel. Consequentemente, se cada resumo-fonte é mantido fixo, todos os payoffs de `H`, contrastes, probabilidades de acordo/atraso e leis anônimas declaradas por `A_C` permanecem fixos.

**Prova.** Cada coordenada-fonte fatora mensuravelmente pelo respectivo `Sum_econ`, por AMX-016b e AUX-MSB-024. Produtos finitos, projeções, soma e subtração de aplicações Borel continuam Borel. Substituir cada coordenada por seu extrator produz a fórmula exibida. A prova não se estende a suportes nomeados, mapas `pi`, coincidência de mensagens ou funções off-path, que não pertencem ao operador declarado. QED.

Defina as imagens de resumos na fibra:

```text
S_M^econ(d,eta)={Sum_econ_M(R_M):R_M in B_M(d,eta)},
S_U^econ(d,eta)={Sum_econ_U(R_U):R_U in B_U(d,eta)}.
```

**Corolário AC-MSB-C1 — fatorização setwise sem recombinação.**

A imagem econômica exata é

```text
K_AC^econ(d,eta)
 ={(s_M,s_U,C_bar_econ(s_M,s_U)):
    s_M in S_M^econ(d,eta),
    s_U in S_U^econ(d,eta)}.
```

**Prova.** A inclusão da esquerda para a direita segue de T3. Reciprocamente, cada `s_g` possui por definição ao menos um binder completo como pré-imagem. Como a única condição cruzada é a fibra comum, qualquer par dessas pré-imagens pertence a `J_AC^bind`. O levantamento emparelha resumos inteiros; não escolhe `V^0`, `V^1`, posterior ou outcome de pré-imagens diferentes. QED.

O produto de resumos aparece somente depois do produto exato e da prova de fatorização. Ele não transforma baricentros de Reynolds em assessments.

## 5. Estrutura exata dos valores de `A_U`

Use

```text
nu_star=(o_1-o_0)/(1-o_0),
z_L=1-beta+beta^2*o_0,
d_H=beta^2*o_1,
z_H=1-beta+beta^2*o_1,
Delta_U=z_L-d_H,
u_min=max{z_L,d_H}.
```

As fibras de payoff de unanimidade são:

### 5.1 Endpoint `nu=0`

```text
eta=(*,0),
(V_U^0,V_U^1)=(z_L,max{z_L,d_H}),
V_U^E=z_L.
```

O tipo de probabilidade zero permanece no binder e no conjunto por tipo.

### 5.2 Prior baixo interior

Se

```text
0<nu<=nu_star,
Delta_U>=0,
p=nu_off=0  (rho=0),
```

então

```text
(V_U^0,V_U^1)=(z_L,z_L).
```

Se `Delta_U<0` ou `p>0`, `B_U(d,eta)` é vazia nessa região.

### 5.3 Prior alto interior e crença off-path baixa

Se

```text
nu_star<nu<1,
p=0  (rho=0),
```

então

```text
(V_U^0,V_U^1)=(u,u),
u in [u_min,z_H].
```

Quando `Delta_U>=0`, a família `L` pode acrescentar laws/outcomes no ponto `u=z_L`; isso não expande o intervalo de payoffs, mas permanece no conjunto de binders e resumos.

### 5.4 Prior alto interior e crença off-path alta

Se

```text
nu_star<nu<1,
p in (nu_star,1],
```

então

```text
(V_U^0,V_U^1)=(z_H,z_H).
```

Se `p in (0,nu_star]`, `B_U(d,eta)` é vazia.

### 5.5 Endpoint `nu=1`

```text
eta=(*,1),
(V_U^0,V_U^1)=(z_H,z_H).
```

Essa partição preserva todos os endpoints e a diagonal de crenças. Ela substitui a antiga divisão que ignorava `rho`.

## 6. Células de existência de `A_C`

**Teorema AC-MSB-T4 — existência fibra a fibra.**

```text
J_AC^bind(d,eta) não vazio
sse
B_M(d,eta) não vazio e B_U(d,eta) não vazio.
```

Assim:

1. nos endpoints, ambas as fontes são não vazias e `A_C` existe;
2. no prior baixo interior, `A_C` só pode existir em `rho=0`, com `Delta_U>=0`, e ainda requer `B_M(d,(0,0))` não vazia;
3. no prior alto interior e `rho=0`, requer a fibra correspondente de `A_M`;
4. no prior alto interior com `p>nu_star`, requer a fibra correspondente de `A_M`;
5. em toda fibra na qual `A_U` é `none`, `A_C` é `none`, mesmo que `A_M` exista;
6. se `A_M` é `none` numa fibra em que `A_U` existe, `A_C` é `none` e `A_U` sobrevive separadamente.

**Prova.** É a condição de não vacuidade de um produto fibrado. As existências de endpoint vêm dos pacotes congelados. Nenhuma célula vazia recebe payoff-sentinela. QED.

O teorema de existência de `A_M` garante algum `rho` para cada primitiva, não todo `rho`. Portanto `A_C` não substitui a condição `B_M(d,eta) != empty` por uma presunção global.

## 7. Conjuntos exatos de contraste

Defina as imagens vetoriais preservando a ligação entre tipos:

```text
V_g^01(d,eta)
 ={(V_g^0(R_g),V_g^1(R_g)):R_g in B_g(d,eta)}.
```

O conjunto exato dos contrastes por tipo é a diferença de Minkowski dos vetores completos:

```text
D_01(d,eta)
 =V_U^01(d,eta)-V_M^01(d,eta)
 ={u-m:u in V_U^01(d,eta), m in V_M^01(d,eta)}.
```

Essa igualdade é consequência do produto fibrado, não um produto de marginais por tipo. Em particular, não se forma `proj_0(V_g^01) times proj_1(V_g^01)`.

A imagem ex ante é aplicada ao vetor ligado inteiro:

```text
D_E(d,eta)
 ={(1-nu)*x_0+nu*x_1:(x_0,x_1) in D_01(d,eta)}.
```

Em geral, essa imagem não coincide com a soma de Minkowski construída a partir
de escolhas independentes nas projeções marginais,
`(1-nu)D_0+nu D_1`. Essa última operação pode recombinar contrastes de binders
distintos e criar valores inexistentes.

Para `r in {0,1,E}`, defina

```text
D_r(d,eta)={delta_r(R_M,R_U):(R_M,R_U) in J_AC^bind(d,eta)},
S_r(d,eta)={sign(x):x in D_r(d,eta)}.
```

Quando `J_AC` é não vazio:

- unanimidade domina estritamente na coordenada `r` sse `S_r={+1}`;
- maioria domina estritamente sse `S_r={-1}`;
- todos os pares empatam sse `S_r={0}`;
- unanimidade é fracamente superior sse `S_r subseteq {0,+1}`;
- maioria é fracamente superior sse `S_r subseteq {-1,0}`;
- o sinal depende da seleção sse `S_r` contém sinais positivos e negativos, ou um deles juntamente com zero quando a pergunta for dominância estrita.

Se `J_AC` é vazio, não há sinal institucional: a classificação é `none`.

## 8. Valores fixos, multiplicidade e dependência de seleção

Nas células `nu=0`, prior baixo existente, prior alto com `p>nu_star` e `nu=1`, os payoffs de `H` sob unanimidade são fixos pela fibra. O contraste em payoff varia apenas com o binder de `A_M`, embora outcomes de `A_U` possam continuar múltiplos.

Na célula alta com `p=0`,

```text
z_H>z_L,
z_H>d_H,
```

pois `o_1>o_0` e `beta<1`. Logo `z_H>u_min`: o intervalo de payoffs de `A_U` é não degenerado. Fixado qualquer binder comparável de `A_M`, escolher os extremos de `A_U` produz valores distintos de `delta_0`, `delta_1` e `delta_E`. O valor é necessariamente dependente da seleção; o sinal ainda pode ser robusto se o conjunto inteiro permanecer de um lado de zero.

Em todas as células, outcomes e leis de acordo podem variar mesmo quando o payoff de `H` é fixo. `A_C` não usa igualdade de payoff como seleção de outcome.

## 9. Envelopes derivados

Para `r in {0,1,E}`, usando a definição de `V_g^E` da Seção 3, ponha

```text
M_r={V_M^r(R_M):R_M in B_M(d,eta)},
U_r={V_U^r(R_U):R_U in B_U(d,eta)}.
```

Como a compatibilidade cruzada é somente a fibra comum,

```text
inf D_r=inf U_r-sup M_r,
sup D_r=sup U_r-inf M_r.
```

Essas igualdades valem para ínfimos e supremos de conjuntos limitados; não afirmam que os extremos ou pontos intermediários sejam atingidos. O intervalo

```text
[inf D_r,sup D_r]
```

é apenas o casco intervalar de `D_r`.

Nas fibras de unanimidade singleton `U_r={t_r}`:

```text
inf D_r=t_r-sup M_r,
sup D_r=t_r-inf M_r.
```

Na célula alta com `p=0`, para `r in {0,1,E}`:

```text
inf D_r=u_min-sup M_r,
sup D_r=z_H-inf M_r.
```

Nenhum envelope substitui o conjunto vetorial `D_01`.

## 10. Certificado selection-free de vantagem da maioria

O pacote congelado de `A_M` prova, para todo binder e tipo,

```text
V_M^theta>=max{Z_E,beta^2*o_theta},
Z_E=1-k*beta/m.
```

O pacote de `A_U` implica, em toda fibra existente,

```text
V_U^theta<=z_H=1-beta+beta^2*o_1.
```

**Teorema AC-MSB-T5 — condição suficiente uniforme.**

Suponha

```text
J_AC^bind(d,eta) != empty.
```

Defina a margem garantida

```text
g_T5=beta*(c/m-beta*o_1).
```

Se

```text
beta*o_1 < c/m,
c=m-k,
```

então `g_T5>0` e, em todo par comparável e para os dois tipos,

```text
V_M^theta-V_U^theta>=g_T5>0,
delta_theta<=-g_T5<0,
delta_E<=-g_T5<0.
```

Se `beta*o_1=c/m`, então `g_T5=0` e maioria é fracamente superior para os dois tipos e ex ante.

**Prova.**

```text
Z_E-z_H
=1-k*beta/m-[1-beta+beta^2*o_1]
=beta*(1-k/m-beta*o_1)
=beta*(c/m-beta*o_1).
```

Sob desigualdade estrita, `V_M^theta>=Z_E>z_H>=V_U^theta`. Na igualdade, substitua `>` por `>=`. A média ex ante preserva a ordem. QED.

Intuição: maioria permite excluir `c` Estados fracos e comprar apenas uma coalizão mínima; quando o maior custo de continuação de unanimidade, `beta*o_1`, é menor que a fração excluível `c/m`, até o melhor payoff possível sob unanimidade fica abaixo da proposta segura disponível sob maioria.

T5 é suficiente, não necessário. Fora dessa região, o ranking exato permanece o operador de sinais da Seção 7. Os bounds congelados, sozinhos, não autorizam selecionar um equilíbrio de maioria nem afirmar vantagem universal da unanimidade.

### 10.1 Corolário de célula baixa

**Corolário AC-MSB-C2 — certificado local com `o_0`.**

Suponha `J_AC^bind(d,eta) != empty` e defina

```text
g_0=beta*(c/m-beta*o_0).
```

Em qualquer célula baixa interior existente,

```text
0<nu<=nu_star,
nu_off=0,
Delta_U>=0,
```

vale `V_U^0=V_U^1=z_L`. Se `beta*o_0<c/m`, então, para os dois tipos e ex ante,

```text
V_M^theta-V_U^theta>=g_0>0,
delta_theta<=-g_0<0,
delta_E<=-g_0<0.
```

No endpoint `nu=0`, a mesma condição garante a vantagem ex ante

```text
V_M^E-V_U^E>=g_0>0,
delta_E<=-g_0<0.
```

Ela não afirma dominância do tipo alto contrafactual no endpoint sem usar o
vetor específico dessa célula.

**Prova.** Na célula baixa interior existente, a partição da Seção 5 dá
`V_U^theta=z_L` para ambos os tipos. Como `V_M^theta>=Z_E`,

```text
V_M^theta-V_U^theta
 >=Z_E-z_L
 =1-k*beta/m-[1-beta+beta^2*o_0]
 =beta*(c/m-beta*o_0)
 =g_0.
```

A média ex ante preserva a mesma margem. Em `nu=0`, `V_U^E=z_L` e
`V_M^E=V_M^0>=Z_E`, produzindo a desigualdade ex ante. QED.

Como `o_0<o_1`, o certificado local é estritamente menos exigente que T5. Ele
explicita por que a condição global de T5 não é necessária.

### 10.2 Contraexemplo à necessidade de T5

**Exemplo AC-MSB-E1.** Tome

```text
N=5, m=4, k=2, c=2,
beta=0.9, o_0=0.5, o_1=0.6, y_bar=0.8,
nu=0.
```

As primitivas são admissíveis e `c/m=0.5`, enquanto
`beta*o_1=0.54>0.5`; portanto T5 não se aplica. Contudo,

```text
Z_E=0.55,
z_L=1-0.9+0.9^2*0.5=0.505,
d_H=0.9^2*0.6=0.486.
```

No endpoint baixo,

```text
(V_U^0,V_U^1)=(z_L,max{z_L,d_H})=(0.505,0.505).
```

A fibra de `A_M` existe no endpoint e todo binder de maioria satisfaz
`V_M^theta>=Z_E=0.55`. Logo maioria domina estritamente ambos os tipos e ex
ante, embora a condição de T5 falhe. Esse é um contraexemplo à necessidade, não
à suficiência, de T5.

### 10.3 Paridade da fração excluível

**Corolário AC-MSB-C3 — forma fechada de `c/m`.** Como
`m=N-1`, `k=floor(N/2)` e `c=m-k`,

```text
c/m = 1/2                         se N é ímpar,
c/m = (N-2)/(2*(N-1))             se N é par.
```

**Prova.** Se `N=2h+1`, então `m=2h`, `k=h` e `c=h`. Se
`N=2h`, então `m=2h-1`, `k=h` e `c=h-1`. Substituir em `c/m`
produz as duas expressões. QED.

Assim, com número ímpar de Estados, T5 reduz a `beta*o_1<1/2`. Com número par,
o limiar é estritamente inferior a `1/2`, mas converge a `1/2` quando `N`
cresce. A diferença vem da fração de Estados fracos que uma coalizão mínima de
maioria pode excluir.

## 11. Acordo, atraso e outcomes

Para cada tipo,

```text
Delta_A^theta=A_U^theta-A_M^theta,
Delta_D^theta=-Delta_A^theta.
```

Essas estatísticas e as leis anônimas completas fatoram por `Sum_econ`. O objeto de outcomes é o par ordenado

```text
O_AC(d,eta)
 ={((Gamma_bar_M^0,Gamma_bar_M^1),
    (Gamma_bar_U^0,Gamma_bar_U^1)):
    (R_M,R_U) in J_AC^bind(d,eta)}.
```

`O_AC` preserva um par ordenado de leis marginais. `A_C` não introduz variável
aleatória conjunta nem regra geral de acoplamento entre regras. Em geral, as
marginais não identificam um acoplamento único; impor um acrescentaria uma
convenção cross-world ausente das primitivas. Se uma marginal for degenerada,
o acoplamento compatível pode ser matematicamente único, mas esse caso-limite
não fornece uma primitiva que pareie realizações contrafactuais nem autoriza
operações conjuntas não declaradas. Sem função de bem-estar ou ordem sobre
distribuições autorizada, `A_C` tampouco converte `O_AC` em ranking adicional.

## 12. Limites e invalidação

O resultado prova:

- compatibilidade exata na diagonal de `(rho,nu_off)`;
- fatorização mensurável das operações econômicas declaradas;
- a partição correta de `A_U` por prior, `Delta_U` e `nu_off`;
- fórmulas de contraste por tipo e ex ante;
- classificação exata de dominância por conjuntos de sinais;
- envelopes posteriores ao conjunto exato;
- T5 como condição suficiente uniforme de vantagem de maioria, com margem
  quantitativa explícita;
- um certificado menos restritivo nas células baixas e no payoff ex ante do
  endpoint baixo;
- um contraexemplo construtivo à necessidade de T5; e
- a forma fechada da fração excluível `c/m` segundo a paridade de `N`.

Ele não prova:

- extremos fechados da correspondência geral de `A_M`;
- uma seleção normativa entre equilíbrios;
- uma ordem de bem-estar sobre os Estados fracos;
- uma variável aleatória conjunta, uma regra geral de acoplamento ou operações
  cross-world não declaradas entre realizações institucionais;
- suficiência de `Sum_econ` para operações off-path ou de identidade formal;
- qualquer benchmark público de `A_R`.

Qualquer alteração em `A_M`, `A_U`, M/S/B, `y_bar`, na fibra diagonal, na orientação `U-M` ou na lista de operações invalida `A_C`.

`A_C` permanece `pending/unfrozen` até revisão independente, adjudicação e aprovação autoral terminal. `A_R`, manuscrito, tag, merge e push continuam não autorizados.
