# Resultados explícitos exploratórios para `A_M`

**Data:** 2026-08-28  
**Status:** `EXPLORATORY CANDIDATE - LOCAL REPAIRS IMPLEMENTED - AMX-014--016 BLOCKED BY CURRENT PRIMITIVES - REVIEW PENDING`  
**Base Git:** `b427671efee954831901e75762988043a2df7205`  
**Escopo:** somente o estágio de agenda sob maioria. Este arquivo não altera
`A_U`, `AC`, `AR`, o manuscrito, `C_M` ou qualquer artefato congelado.

Os bytes consumidos e seus hashes estão registrados em
`quality_reports/2026-08-28_A_M_exploratory_blocked_preflight.md`. A
referência privada reparada foi usada apenas como definição do candidato
implícito: ela não foi tratada como aval substantivo de `A_M`.

O parecer externo original foi preservado integralmente em
`quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md`
(SHA-256 `d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c`).
O PDF que ele auditou foi preservado separadamente com SHA-256
`a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394`.
Os reparos autorizados e a supersessão histórica do PASS parcial anterior
estão em `quality_reports/adjudication/agenda_extension_A_M_explicit/19881e9aa680/`.

## 1. Resultado em linguagem direta

É possível substituir uma parte importante da resposta implícita por
equilíbrios inteiramente descritos. Defina

```text
m = N-1,
q = floor(N/2)+1,
k = q-1,
Z_E = 1-k*beta/m,
T = Z_E/beta = 1/beta-k/m.
```

`H` já fornece um voto favorável, de modo que precisa comprar exatamente `k`
votos fracos. Vale `T>1/m`. Para todo prior interior, três regiões que se
sobrepõem nas fronteiras cobrem todo o domínio:

| Região suficiente | Equilíbrio explícito | Payoff de `H`, tipos `(0,1)` |
|---|---|---|
| `o_1 <= T` | pooling com acordo; também separating com acordo dos dois tipos | diagonal, especificada abaixo |
| `o_0 <= T <= o_1` | separating: tipo baixo faz acordo, tipo alto provoca rejeição | `(Z_E, beta*o_1)` |
| `T <= o_0` | pooling com rejeição; também separating com rejeição dos dois tipos | `(beta*o_0, beta*o_1)` |

As construções cíclicas abaixo fornecem pelo menos um PBE explícito para cada
primitiva admissível, quando se escolhe essa continuação literal específica.
Isto não significa que todo seletor Borel admissível tenha melhor resposta ou
que a correspondência inteira exista para cada seletor. Em particular, a
afirmação de que a célula abstrata de possível não existência do gerador
implícito fica vazia vale somente para a testemunha cíclica construída aqui:

```text
D_M^0 = vazio  (para a testemunha cíclica fixada).
```

Isto é um teorema candidato de **existência**, não uma caracterização completa
de todos os PBEs. A multiplicidade de continuações literais de `C_M` continua
existindo e gera outros preços, propostas e payoffs.

## 2. Continuação literal usada como testemunha

### 2.1 Ramos congelados de `C_M`

Use a notação congelada

```text
w  = beta/m,
t0 = beta*o_0,
t1 = beta*o_1,
E  = 1-k*w,
L  = 1-(k-1)*w-t0,
P  = 1-(k-1)*w-t1.
```

Os únicos ramos consumidos são os ramos efetivamente disponíveis em `C_M`:

- se `o_1<1/m`, `S` até `nu_SP`, inclusive, e `P` acima;
- se `o_0<1/m<o_1`, `S` até `nu_SE`, inclusive, e `E` acima;
- se `1/m<o_0<o_1`, `E` em todo posterior;
- se `o_0=1/m<o_1`, `S` somente em `mu=0` e `E` para `mu>0`;
- se `o_0<o_1=1/m`, `S` até `nu_SE`; acima, somente o ramo `E` ou `P`
  realmente permitido pelo desempate congelado.

Nos endpoints,

```text
B(0) = S se o_0<=1/m; E se o_0>1/m,
B(1) = P se o_1<=1/m; E se o_1>1/m.
```

Não se usa `E` onde `E` não pertence à correspondência congelada.

### 2.2 Membro cíclico balanceado

Rotule os `m` Estados fracos em um ciclo. Quando o fraco `i` é reconhecido em
`C_M`, faça-o comprar os próximos `r` nomes do ciclo, onde

```text
r=k     no ramo E,
r=k-1   nos ramos S e P.
```

Isto especifica uma proposta e uma coalizão para cada identidade reconhecida.
Cada fraco aparece em exatamente `r` coalizões. Junto com as crenças, votos,
resultados e payoffs já definidos em `C_M`, essa regra produz **um membro
literal completo** da correspondência congelada. Ela é uma testemunha de PBE,
não uma hipótese de simetria imposta ao modelo e não uma seleção normativa da
correspondência inteira. Entre os membros que ficam planos no vetor de votos,
ela maximiza a soma dos `k` menores payoffs fracos e, portanto, **minimiza** a
parcela de acordo de `H`; não foi escolhida para fabricar um payoff alto.

Nesse membro, o payoff interino nativo de cada fraco e o payoff nativo de `H`
são:

| Ramo | payoff fraco comum `c_B(mu)` | `(h_B(0),h_B(1))` |
|---|---:|---:|
| `E` | `1/m` | `(o_0,o_1)` |
| `S` | `[(1-mu)(1-beta*o_0)+mu*beta]/m` | `(beta*o_0,beta*o_1)` |
| `P` | `(1-beta*o_1)/m` | `(beta*o_1,beta*o_1)` |

Ao voltar de `C_M` para `A_M`, aplica-se `beta` uma única vez:

```text
r_B(mu)    = beta*c_B(mu)          # preço de um voto fraco em A_M
D_B(theta) = beta*h_B(theta)       # payoff de H se a proposta falhar
Z_B(mu)    = 1-k*r_B(mu).          # maior parcela de H se houver acordo
```

Portanto,

```text
Z_E     = 1-(k*beta/m),
Z_S(mu) = 1-(k*beta/m)*[(1-mu)(1-beta*o_0)+mu*beta],
Z_P     = 1-(k*beta/m)*(1-beta*o_1).
```

Como `c_S(mu)<1/m` e `c_P<1/m`, vale `Z_S(mu)>Z_E` e `Z_P>Z_E`.

### 2.3 Votos em todo o espaço de propostas

Para cada proposta `s`, escolha o mesmo membro literal acima em todos os
vetores de votos rejeitados que seguem `s`. Então, para todo fraco `j` e todo
vetor em que `j` é pivotal,

```text
r_lower_j(s)=r_upper_j(s)=r_B(mu(s)).
```

Especifique a estratégia pura

```text
j vota sim  se x_j >= r_B(mu(s)),
j vota nao  se x_j <  r_B(mu(s)).
```

A igualdade gera `sim`, como exige `T^Y`. Não há média sobre vetores de voto,
kernel auxiliar, tremble ou crença movida por voto fraco. Uma proposta aprovada
precisa pagar ao menos `r_B` a `k` fracos, logo dá a `H` no máximo `Z_B`; uma
proposta rejeitada dá exatamente `D_B(theta)`. A comparação cobre todo `Y`,
portanto elimina também desvios mistos.

### 2.4 Lema AM-L2 reparado: teto pontual e condição de atingibilidade

Para um seletor arbitrário, que pode depender da própria proposta, defina,
para cada proposta fixa `s`,

```text
u_j^kappa(s)=max_{a_-j pivotal} C^I_{M,j}(kappa_M(s,(0,a_-j),mu(s))),
K_kappa(s)=beta * soma dos k menores u_j^kappa(s),
Z_point^kappa(s)=1-K_kappa(s).
```

Esses preços são calculados **na proposta `s`**. A regra pivotal implica que
`Z_point^kappa(s)` é um teto pontual para a parcela de `H` em um acordo
avaliado nessa mesma proposta: qualquer conjunto de `k` votantes aceitos tem
de cobrir as reservas correspondentes, de modo que `z_H` não pode exceder o
restante indicado por `K_kappa(s)`. O enunciado é apenas pontual. Se
`kappa_M` muda quando os pagamentos `x_j` mudam, não se pode calcular
`K_kappa(s)`, alterar `s` para pagar esses preços e conservar o mesmo
`K_kappa`.

Atingibilidade exige um ponto fixo coordenado. Mais precisamente, fixe uma
família/incidência `F` e um conjunto `Q` de `k` fracos. Uma proposta
`s^F` atinge o teto associado a `F` somente se, simultaneamente,

```text
kappa_M(s^F,(0,a_-j),mu(s^F)) = F(mu(s^F))  para todo pivotal a_-j,
x_j = beta*C^I_{M,j}(F(mu(s^F)))       para j em Q,
x_j = 0                                para j fora de Q,
z_H = 1 - soma_{j em Q} x_j.
```

Então `Q` vota sim, a proposta passa e o restante é atingido. A primeira
linha é a autoconsistência entre proposta, conjunto de votantes e preços que a
própria proposta induz. Ela é automática numa subfamília globalmente constante
e pode falhar para um seletor dependente de `s`; não é uma afirmação geral de
atingibilidade para seletores arbitrários.

Para qualquer membro/família admissível enquanto o ramo puro `B` está
fixado, há espaço para essa construção. De fato, cada payoff nativo de um
fraco é no máximo

```text
C_bar=(1+beta*(m-k)/m)/m,
A_g=1-k*beta*C_bar.
```

Logo `K_kappa(s)<=k*beta*C_bar=1-A_g<1`. A última desigualdade é explícita:
como `beta<1` e `k/m<=2/3`,

```text
A_g >= 1-(k/m)*(1+(m-k)/m)=(1-k/m)^2 >= 1/9 > 0.
```

O limite usa um ramo puro `B` fixado e a correspondência literal vigente; não
introduz média sobre vetores, tremble, simetria nova ou seleção fora do
assessment.

## 3. Equilíbrios puros explícitos

### 3.1 Pooling com acordo imediato

Suponha `o_1<=T`. No posterior de entrada `nu`, use o ramo real `B(nu)` de
`C_M`. Fixe, em todo `Y`,

```text
mu(s)=nu,
kappa_M(s,vetor rejeitado)=membro cíclico de B(nu).
```

Na proposta pooling, Bayes produz `nu`; cada outro ponto possui uma vizinhança
relativa de massa pública zero. Nos endpoints, a crença constante respeita o
suporte degenerado.

Escolha `Q` com `|Q|=k`. Ambos os tipos propõem

```text
x_j=r_B(nu) se j pertence a Q; x_j=0 caso contrário;
z_H=Z_B(nu).
```

Os `k` membros de `Q` votam `sim`, os demais votam `não`, e a proposta passa
com o voto automático de `H`. Nenhum desvio aprovado rende mais que `Z_B`.
Nenhum desvio rejeitado é lucrativo porque, ramo a ramo,

```text
E: D_E(1)=beta*o_1 <= beta*T=Z_E;
S: D_S(1)=beta^2*o_1 < Z_E < Z_S;
P: D_P(1)=beta^2*o_1 < Z_E < Z_P.
```

O payoff conjunto atingido é

```text
(V_H^0,V_H^1)=(Z_B(nu),Z_B(nu)).
```

Dentro desta subfamília com continuação cíclica constante, a condição exata é:

| Continuação real | pooling com acordo | pooling com rejeição |
|---|---|---|
| `E` | sse `o_1<=T` | sse `o_0>=T` |
| `S` | sse `beta^2*o_1<=Z_S(nu)` | impossível |
| `P` | sempre | impossível |

Esses “se e somente se” não são promovidos a necessidade para seletores
história-dependentes arbitrários.

### 3.2 Separating com acordo dos dois tipos

Em qualquer PBE puro separating no qual ambas as propostas passam, a imitação
bilateral exige

```text
z_0>=z_1 e z_1>=z_0; portanto z_0=z_1.
```

Há uma construção sempre que `o_1<=T`.

**Caso `o_1<=1/m`.** No sinal `s_0`, use posterior zero e `S`; no sinal
`s_1`, posterior um e `P`; fora do caminho, posterior zero e `S`. Defina

```text
c_0=(1-beta*o_0)/m,
c_1=(1-beta*o_1)/m,
Z_0=1-beta*k*c_0 < 1-beta*k*c_1=Z_1.
```

Em `s_0`, pague `beta*c_0` a `k` fracos. Em `s_1`, pague `beta*c_1` a `k`
fracos. Nos dois sinais, dê a `H` a mesma parcela `z=Z_0`; em `s_1` sobra
folga factível. As ofertas ou as coalizões podem ser distintas. Imitar o outro
sinal rende o mesmo `z`, e qualquer desvio fora do caminho rende no máximo
`max{Z_0,beta^2*o_1}=Z_0`.

**Caso `1/m<o_1<=T`.** No sinal `s_1` e fora do caminho, use posterior um e
`E`. No sinal `s_0`, use o ramo real `B(0)`, isto é, `S` se `o_0<=1/m` e `E`
se `o_0>1/m`. Como `c_{B(0)}<=1/m`, ambos os sinais podem passar dando

```text
z_0=z_1=Z_E.
```

Se os dois endpoints usam `E`, coalizões compradas distintas tornam as
propostas diferentes. Fora do caminho, acordo rende no máximo `Z_E` e rejeição
rende no máximo `beta*o_1<=Z_E`.

Esta separação revela o tipo, mas não cria diferença de payoff: seu conteúdo é
informacional, não distributivo.

### 3.3 Separating: acordo do tipo baixo e atraso do alto

Suponha

```text
0<nu<1,
o_0<=T<=o_1.
```

Esta construção é exclusivamente interior. Nos endpoints do prior, qualquer
acordo ou mistura deve ser tratado exclusivamente por AMX-005; não se
transporta esta separação para `nu in {0,1}`.

Como `T>1/m`, o posterior um admite o ramo `E`. Fixe

```text
mu(s_0)=0;
mu(s)=1 para todo s diferente de s_0;
kappa em s_0 = membro cíclico do ramo real B(0);
kappa fora de s_0 = membro cíclico E.
```

O tipo baixo propõe `s_0`, paga `beta*c_{B(0)}` a `k` fracos e retém `Z_E`.
Se `B(0)=S`, sua capacidade de acordo é maior que `Z_E` e há folga; não se
impõe exaustão. O tipo alto propõe, por exemplo,

```text
s_1=(z_H=1,x_1=...=x_m=0).
```

Todos os fracos rejeitam `s_1`; `H` foi obrigado a propor e o atraso é, assim,
um resultado endógeno, não uma ação primitiva de “passar”. Os payoffs são

```text
(V_H^0,V_H^1)=(Z_E,beta*o_1).
```

Para o tipo baixo, qualquer acordo fora de `s_0` rende no máximo `Z_E` e toda
rejeição rende `beta*o_0<=Z_E`. Para o tipo alto, qualquer acordo - inclusive
imitar `s_0` - rende no máximo `Z_E<=beta*o_1`, e toda rejeição fora do caminho
reproduz `beta*o_1`. A continuação é o membro completo `E`: um fraco é
reconhecido, a proposta terminal correspondente é votada, o acordo ocorre sem
`H`, e `A_M` aplica exatamente um `beta` ao payoff nativo `o_theta`.

### 3.4 Pooling e separating com atraso dos dois tipos

Suponha `T<=o_0`. Como `T>1/m`, `C_M(mu)` usa `E` para todo posterior.

No pooling, ambos propõem `(1,0,...,0)`, que é rejeitada, com crença `nu` e
continuação cíclica `E` em todo `Y`. No separating, escolha dois pacotes
rejeitados distintos, por exemplo `(0,0,...,0)` e `(1,0,...,0)`, e aplique
Bayes nos dois átomos. Como `E` é válido em todo posterior, imitar o outro sinal
não muda a continuação. Em ambos os casos,

```text
(V_H^0,V_H^1)=(beta*o_0,beta*o_1).
```

Nenhum acordo pode render mais que `Z_E=beta*T<=beta*o_0`; toda rejeição
reproduz o payoff do respectivo tipo.

### 3.5 Endpoints do prior

Se `nu` é zero ou um, fixe `mu(s)=nu` para todo `s`, como exige o suporte do
prior, e use o ramo real `B(nu)` em toda rejeição. Para cada estratégia
contingente, inclusive a do tipo de probabilidade zero, compare

```text
Z=Z_B(nu) com D_theta=D_B(theta).
```

Prescreva uma proposta aprovada se `Z>=D_theta`, uma proposta rejeitada se
`D_theta>=Z`, e qualquer mistura entre elas na igualdade. Estas são melhores
respostas globais porque toda aprovação rende no máximo `Z` e toda rejeição
rende `D_theta`. Nenhuma crença atribui massa ao tipo impossível.

## 4. Semipooling e mistura: famílias efetivamente construídas

### 4.1 O tipo alto mistura entre acordo comum e atraso próprio

Considere `0<nu<1`, `o_1>1/m` e `lambda in (0,1)`. O tipo baixo sempre envia
`s_A`; o alto envia `s_A` com probabilidade `lambda` e um sinal rejeitado
`s_D` com probabilidade `1-lambda`. Bayes exige

```text
mu_A = nu*lambda / [(1-nu)+nu*lambda],
mu(s_D)=1.
```

Equivalentemente,

```text
lambda=mu_A*(1-nu)/[nu*(1-mu_A)].
```

Em `s_D` e fora do caminho, use o membro cíclico `E`. No sinal comum, escolha
um membro literal plano de `B(mu_A)` e denote por `K_B(mu_A)` o custo dos `k`
votos mais baratos já multiplicado pelo `beta` externo. Se

```text
beta*o_1 >= Z_E
e
1-K_B(mu_A) >= beta*o_1,
```

faça `s_A` passar dando `z_A=beta*o_1` a `H`, e faça `s_D` falhar. O tipo alto
fica indiferente entre o acordo e a continuação `E`; o tipo baixo prefere o
acordo, pois

```text
beta*o_1 >= Z_E e beta*o_1 > beta*o_0.
```

Todo desvio fora do caminho enfrenta `E`, de modo que as duas desigualdades
acima verificam todos os desvios. Esta é uma família semipooling genuína, não
uma conjectura. A Seção 5 fornece o menor `K_B` atingível e, portanto, uma
condição fechada para sua existência.

Escolhendo o membro mínimo da Seção 5, a condição se torna diretamente

```text
Zbar_B(mu_A)=1-beta*M_B(mu_A) >= beta*o_1.
```

Ela é uma desigualdade: folga no pacote é permitida. Igualá-la para pinçar um
único `lambda` imporia exaustão integral do bolo, hipótese que não pertence ao
contrato e não é usada aqui. Portanto, em geral, as taxas admissíveis de
mistura formam um intervalo.

Exemplo verificado: `N=5`, `beta=.9`, `o_0=.1`, `o_1=.7`, `nu=.5` e
`lambda=.25`. Então `mu_A=.2`. Um membro mínimo do ramo `S` dá
`K_S=.3276`, capacidade de acordo `.6724`, maior que `beta*o_1=.63`.
Assim o tipo baixo sempre acorda por `.63`; o alto acorda por `.63` com
probabilidade `.25` e atrasa para `.63` com probabilidade `.75`.

### 4.2 Mistura nas fronteiras puras

As construções gerais desta seção também são exclusivamente interiores:
`0<nu<1`. Nos endpoints do prior, remeta exclusivamente a AMX-005.

- Se `o_1=T`, o tipo alto está indiferente entre o acordo por `Z_E` e a
  rejeição com continuação `E`. A construção anterior gera semipooling para
  qualquer `lambda` cuja proposta comum satisfaça a capacidade de acordo.
- Se `o_0=T<o_1`, então `o_0>1/m` e `E` vale em todo posterior. O tipo baixo
  pode misturar entre um acordo por `Z_E` e o sinal de rejeição usado pelo tipo
  alto; o alto rejeita. Bayes no sinal compartilhado é calculado diretamente
  das probabilidades da mistura.

Nos endpoints, AMX-005 permite mistura entre a proposta aprovada canônica e a
proposta rejeitada canônica somente quando
`Z_{B(nu)}(nu)=D_{B(nu)}(theta)` para o tipo contingente. Não foi provada uma
classificação completa de todas as medidas Borelianas
mistas ou semipooling com seletores diferentes em cada vetor pivotal. Fazer
essa alegação exigiria resolver o problema funcional já preservado pelo
gerador implícito, não apenas enumerar suportes finitos.

## 5. Geometria exata dos preços de votos

Esta seção mostra quanto a multiplicidade de `C_M` pode mover o payoff de
acordo sem recombinar coordenadas de equilíbrios distintos.

### 5.1 Um membro plano qualquer

Seja `A=(a_ij)` a matriz de probabilidades com que o proponente fraco `i`
inclui `j`: `a_ii=0` e cada linha soma `r`. Ponha `d_j=sum_i a_ij`. Para o
mesmo membro literal em todos os vetores rejeitados após um sinal,

```text
E: C_j=(E+w*d_j)/m,                    r=k;
P: C_j=(P+w*d_j)/m,                    r=k-1;
S: C_j(mu)=(1-mu)*(L+w*d_j)/m+mu*w,   r=k-1.
```

`H` compra os `k` menores desses payoffs a preço externo `beta`.

Defina `c=m-k` e, para `r` em `{k,k-1}`,

```text
A_min(r)=k*max{0,r-c}+c*max{0,r-(c-1)}.
```

Esse é o mínimo atingível da soma dos `k` menores graus de coluna. Logo o
menor custo nativo dos `k` votos é

```text
M_E       =[k*E+w*A_min(k)]/m,
M_P       =[k*P+w*A_min(k-1)]/m,
M_S(mu)   =(1-mu)*[k*L+w*A_min(k-1)]/m + mu*k*w.
```

Uma matriz explícita que atinge cada mínimo está implementada e verificada em
`scripts/verify_agenda_extension_A_M_explicit.R`. Portanto os maiores payoffs
de acordo atingíveis, com o posterior e o ramo fixados, são

```text
Zbar_B(mu)=1-beta*M_B(mu).
```

O limite não é apenas para seletores planos. Para qualquer seletor
história-dependente admissível **cuja imagem permaneça no ramo puro `B` fixado**,
defina, em cada proposta fixa,

```text
u_j^kappa(s)=max_{a_-j pivotal}
  C^I_{M,j}(kappa(s,(0,a_-j),mu(s))),
K_kappa(s)=beta * soma dos k menores u_j^kappa(s).
```

Uma única história pivotal pode tornar simultaneamente pivotais todos os
membros de qualquer conjunto-alvo de tamanho `k`. Isso implica, ponto a ponto,
`K_kappa(s)>=beta*M_B(mu(s))`. Portanto `1-K_kappa(s)` é apenas um teto
superior calculado na proposta `s`; em geral não é atingível, porque alterar
os pagamentos pode alterar `kappa` e os próprios `u_j^kappa`.

A igualdade é atingível somente quando a proposta e o membro são
autoconsistentes: fixa-se uma família/incidência `F`, escolhe-se o conjunto
`Q` dos `k` preços mínimos e exige-se que `kappa` devolva
`F(mu(s^F))` em todo vetor pivotal da proposta `s^F`, que paga exatamente
esses preços a `Q` e zero aos demais. Essa é a construção de membro/família
fixa usada nos equilíbrios; ela não é uma propriedade de um seletor arbitrário
dependente da proposta.

### 5.2 Subfamília de continuação globalmente constante (AMX-009)

Defina

```text
U_E=[E+w*(m-1)]/m.
```

Para `N>=4`, defina ainda

```text
U_P=[P+w*(m-1)]/m,
U_S(mu)=(1-mu)*[L+w*(m-1)]/m+mu*w.
```

Para `N=3`, use `U_P=P/m` e
`U_S(mu)=(1-mu)*L/m+mu*w`, pois `r=k-1=0`. Então

```text
beta*M_B <= K_kappa <= beta*k*U_B.
```

Os dois extremos são atingíveis. No extremo superior, histórias pivotais
distintas selecionam membros literais que favorecem a identidade relevante;
não se misturam payoffs marginais numa mesma história. Esta largura explica
por que uma única função de payoff não pode ser deduzida sem uma seleção
adicional.

No caso particularmente transparente `o_0>1/m`, somente `E` existe em todo
posterior. Defina a subfamília **globalmente constante** por uma família de
incidência fixa `F` tal que, para toda proposta `s`, todo vetor rejeitado
`a` e todo posterior relevante,

```text
kappa_M(s,a,mu(s))=E_F(mu(s)).
```

O mesmo `F` é usado entre propostas; `E_F(mu)` é o membro compatível com o
posterior `mu`, não necessariamente o mesmo vetor numérico de payoffs quando
`mu` muda. Esta é apenas a subfamília de continuação globalmente constante de
AMX-009; ela não restringe o modelo geral, no qual `kappa_M` pode variar com a
proposta e com o vetor pivotal.

Entre os membros `E_F` planos, a parcela de acordo percorre o
intervalo compacto

```text
A in [Z_E,Zbar_E].
```

O extremo esquerdo é o membro cíclico; o direito é o membro mínimo da Seção
5.1; toda parcela intermediária é atingida por uma loteria interna da mesma
família `F` entre suas regras de coalizão. Para cada `A`, um PBE explícito escolhe
acordo ou rejeição tipo a tipo e gera exatamente

```text
(V_H^0,V_H^1)=(max{A,beta*o_0},max{A,beta*o_1}).
```

Assim esta fórmula caracteriza exatamente a subfamília globalmente constante
`E_F`, embora não a correspondência inteira com seletores dependentes da
proposta ou do vetor pivotal.

No desempate residual entre `E` e `P`, o par de payoffs de `H` deve permanecer
no mesmo segmento conjunto,

```text
C_H^0=(1-lambda_bar)*o_0+lambda_bar*w,
C_H^1=(1-lambda_bar)*o_1+lambda_bar*w,
```

com o mesmo `lambda_bar`. É proibido combinar uma coordenada de cada extremo.

### 5.3 Contraexemplo mecânico: preços que mudam com a proposta

Considere

```text
N=5, m=4, k=2, beta=4/5, o_0=3/10, o_1=2/5.
```

Como `o_0>1/m`, somente o ramo `E` existe. Então `E=3/5`,
`w=1/5` e um fraco de grau `d` tem reserva externa

```text
rho(d)=beta*(E+w*d)/m=(3+d)/25.
```

Agora deixe o seletor depender da proposta: ordene os quatro pagamentos fracos
do maior para o menor, com desempate lexicográfico, atribua grau `3` aos dois
maiores e grau `1` aos dois menores, e use o membro correspondente em todos
os vetores rejeitados após aquela proposta. Ele permanece no ramo puro `E`,
mas não é globalmente constante entre propostas.

Calculado em uma proposta com ranking fixado, os dois preços menores são
`4/25`, de modo que o cálculo pontual ingênuo produz

```text
K_point=4/25+4/25=8/25,
Z_point=1-K_point=17/25.
```

Pagar esses dois preços, porém, torna esses destinatários os dois maiores
pagamentos da nova proposta; o seletor lhes atribui grau `3`, e o preço que
eles enfrentam passa a ser `6/25`. Logo a proposta ingênua não passa.

O máximo autoconsistente pode ser certificado sem busca numérica. Se os dois
maiores pagamentos votam sim, a soma transferida é pelo menos
`2*(6/25)=12/25`. Se algum dos dois menores vota sim, a ordenação força os
pagamentos acima dele a serem pelo menos `4/25`; qualquer combinação com menos
de dois maiores votantes custa pelo menos `14/25` (um maior e um menor) ou
`16/25` (dois menores). Assim toda proposta aprovada custa ao menos
`12/25`. Essa cota é atingida por

```text
x=(6/25,6/25,0,0),  z_H=13/25,
```

com desempate lexicográfico nos dois maiores. Portanto a parcela máxima
realmente atingível é `13/25`, e não `17/25`, embora o teto pontual
calculado na proposta original seja `17/25`. Esse é precisamente o ponto
fixo que AM-L2 precisa exigir.

### 5.4 Limites globais para os payoffs de `H`

Em todo PBE, inclusive fora das famílias construídas,

```text
max{A_g,beta^2*o_theta} <= V_H^theta <= 1,
0 <= V_H^1-V_H^0 <= beta*(o_1-o_0),
```

onde o limite uniforme construtivo é

```text
C_bar = [1+beta*(m-k)/m]/m,
A_g   = 1-k*beta*C_bar > 0.
```

Todo payoff próprio fraco em todo membro literal de `C_M` é no máximo
`C_bar`. Logo `H` garante aprovação oferecendo `beta*C_bar` a quaisquer `k`
fracos; a regra ponto a ponto força os `k` votos em todas as histórias
pivotais. Além disso, `k/m<=2/3` implica
`A_g>=(1-k/m)^2>=1/9` no limite fraco das desigualdades.

Para o outro componente do limite inferior, `H` pode propor `(1,0,...,0)`. Todo payoff interino
fraco em `C_M` é estritamente positivo, logo a proposta é rejeitada; toda
continuação literal dá a `H(theta)` pelo menos `beta*o_theta` na data de `C_M`,
e o transporte para `A_M` aplica mais um `beta`. Para cada proposta, a diferença
entre as utilidades dos tipos está entre zero e `beta*(o_1-o_0)`: é zero se a
proposta passa, `beta*(o_1-o_0)` no ramo `E`,
`beta^2*(o_1-o_0)` no ramo `S` e zero no ramo `P`; no empate residual, usa-se
o mesmo peso conjunto. Maximizar proposta a proposta preserva os dois limites.
Se `o_1<1/m`, `E` não existe e o limite superior da diferença melhora para
`beta^2*(o_1-o_0)`.

Há ainda uma implicação observável: se alguma proposta aprovada pertence ao
suporte do tipo alto, então `V_H^0=V_H^1`. O tipo baixo pode imitar essa mesma
proposta e receber a mesma parcela, enquanto a monotonicidade acima dá a
desigualdade reversa. Portanto `V_H^1>V_H^0` exige que toda proposta no suporte
do tipo alto seja rejeitada.

Além desses limites, os seguintes pontos conjuntos são rigorosamente
atingíveis, sem recombinação marginal:

```text
o_1<=T:          (Z_B(nu),Z_B(nu)) e (Z_sep,Z_sep);
o_0<=T<=o_1:     (Z_E,beta*o_1);
T<=o_0:          (beta*o_0,beta*o_1);
semipooling:     (beta*o_1,beta*o_1), sob as condições da Seção 4.1.
```

Este é um subconjunto informativo do conjunto de payoffs, não seu envelope
completo.

## 6. Certificados de impossibilidade

Os quatro primeiros resultados independem do membro cíclico.

1. **Pooling não pode produzir acordo para um tipo e atraso para o outro.** A
   proposta e os votos são os mesmos para ambos; `H` não vota novamente.
2. **Separating com acordo dos dois tipos exige `z_0=z_1`.** Cada tipo pode
   imitar literalmente a proposta do outro.
3. **Separating com atraso do tipo baixo e acordo do alto é impossível.** No
   sinal baixo, Bayes fixa `mu=0`. A rejeição dá
   `(beta^2*o_0,beta^2*o_1)` em `S` ou `(beta*o_0,beta*o_1)` em `E`, sempre com
   `D_1>D_0`. As restrições de imitação exigiriam
   `D_0>=z_1>=D_1`, uma contradição.
4. **Separating com atraso dos dois tipos exige `o_0>1/m`.** Se
   `o_0<=1/m`, o sinal baixo usa `S`. Se `o_1<=1/m`, imitar o sinal alto `P`
   eleva o payoff baixo de `beta^2*o_0` para `beta^2*o_1`; se `o_1>1/m`, imitar
   o sinal alto `E` o eleva para `beta*o_0`. As desigualdades são estritas
   porque o domínio fixa `0<o_0<o_1` e `0<beta<1`.
5. **Na família cíclica constante**, pooling com rejeição é impossível nos
   ramos `S` e `P`, pois o melhor acordo excede estritamente a continuação do
   tipo baixo.

O item 5 não é promovido a impossibilidade global contra seletores
história-dependentes.

### 6.1 Certificado negativo para AMX-014--016 sob o contrato atual

Os três exploradores independentes chegaram à mesma conclusão: a dificuldade
restante não é uma lacuna de álgebra nos equilíbrios testemunhados, mas um
obstáculo de existência e de correspondência causado pela liberdade já dada a
`kappa_M`. Esta subseção registra um resultado negativo, não uma hipótese nova
e não uma aprovação da classificação completa.

Fixe uma proposta `s`, um posterior `mu(s)` e um fraco `j`. Para cada vetor
`a_-j` no qual exatamente `k-1` dos demais fracos votam sim, ponha

```text
r_{j,a}(s) = beta*C^I_{M,j}(kappa_M(s,(v_j=0,a_-j),mu(s)));
ell_j(s)   = min_a r_{j,a}(s);
u_j(s)     = max_a r_{j,a}(s).
```

Para um seletor fixado, a regra pivotal ponto a ponto dá precisamente:

```text
v_j(s)=sim  se x_j >= u_j(s),
v_j(s)=nao  se x_j < ell_j(s).
```

Se `ell_j(s)<=x_j<u_j(s)`, não há voto puro admissível para `j` naquele
ponto. Quando existe uma seleção pura `v(s)`, o valor da ação de `H` é

```text
g_theta(s) = z_H(s)                                  se s passa;
             beta*C^theta_{M,H}(kappa_M(s,v(s),mu(s))) se s falha.
```

Uma medida de propostas `sigma_theta` é melhor resposta somente se estiver
concentrada no conjunto de máximos de `g_theta`. Essa redução é necessária e
suficiente para um seletor e uma seleção já fixados, mas é uma correspondência
funcional indexada por `kappa_M`; não é a enumeração informativa exigida para
AMX-014--016.

#### Contraexemplo de não atingimento e não existência

Considere

```text
N=5, m=4, k=2, beta=0.9, o_0=0.30, o_1=0.40.
```

Como `o_0>1/m`, somente o ramo `E` de `C_M` está disponível. Sejam
`A^ell` e `A^h_b` dois membros literais dessa correspondência, construídos
pelas loterias de coalizões válidas de `C_M`; eles não são uma hipótese de
simetria. Denote por `F^ell` e `F_b^h` as matrizes de incidência desses dois
membros literais. Para qualquer conjunto Borel `A` de propostas, defina `kappa_M`
usando `A^ell` em `A` e `A^h_b` fora de `A`, completando os vetores não
pivotais com membros literais quaisquer. Assim se obtém um seletor Borel
admissível em todo o espaço de propostas.

Para o conjunto Borel enumerável
`A_seq={s_n:n>=1}`, use a sequência explícita da construção diagonal

```text
s_n=(51/100 - 1/(100*n), 6/25, 6/25, 0, 0).
```

O seletor usa `A^ell` em `A_seq` e `A^h_b` fora dela. O payoff aprovado de `H`
então satisfaz

```text
g_theta(s) <= 193/400       fora de A_seq,
g_theta(s_n) < 51/100       para todo n,
g_theta(s_n) -> 51/100      em A_seq.
```

Em qualquer rejeição pelo ramo `E`, os payoffs de `H` são `27/100` para o
tipo baixo e `36/100` para o tipo alto. Portanto `g_theta` é Borel, mas não é
semicontínua superiormente e não atinge seu supremo `51/100` para nenhum dos
tipos. Para toda probabilidade Borel `sigma`,

```text
integral g_theta(s) d sigma(s) < 51/100.
```

Com efeito, `51/100-g_theta` é estritamente positiva em todo ponto e, sendo
mensurável, tem integral estritamente positiva; como `51/100` é o supremo,
algum `s_n` produz payoff maior que a média de qualquer `sigma`. Logo não há
melhor resposta pura **nem mista** para esse `kappa_M` admissível e, portanto,
não há PBE que use esse seletor. O certificado não afirma que o jogo inteiro
não possui PBE: outro seletor, como a testemunha cíclica, pode possuir. Ele
afirma que a existência não pode ser uniforme em todos os seletores permitidos
pelo contrato.

O contraexemplo mecânico da Seção 5.3 é uma instância distinta e complementar:
ali o teto pontual `17/25` muda de ranking e a melhor proposta
autoconsistente atinge apenas `13/25`. Juntos, os dois exemplos mostram que
nem o teto pontual nem a compactação de `Y` fornecem, sozinhos, uma
classificação ou uma garantia de máximo.

#### Por que misturas não se deixam enumerar por poucos casos

Para `0<nu<1`, qualquer par de medidas de proposta pode ser escrito com uma
medida pública `lambda` e uma função Borel `pi` em `[0,1]`:

```text
lambda = (1-nu)*sigma_0 + nu*sigma_1,
integral pi d lambda = nu,
sigma_1(ds) = [pi(s)/nu] d lambda(s),
sigma_0(ds) = [(1-pi(s))/(1-nu)] d lambda(s).
```

Nos átomos, a regra local de Bayes é
`pi(y)=nu*p_1(y)/[(1-nu)*p_0(y)+nu*p_1(y)]`; nas partes não atômicas e
singulares, ela exige a razão por vizinhanças relativas em cada ponto
disciplinado. A restrição integral, sozinha, não basta: uma função Borel que
oscila em torno de um ponto pode satisfazer a média e falhar no limite local.
Nos endpoints, o suporte do prior força `pi` identicamente `0` ou `1`.

Há inclusive uma família atomless explícita. Tome

```text
N=5, m=4, k=2, beta=0.9, o_0=0.7, o_1=0.8, nu=0.5.
```

Somente `E` existe. Use um membro cíclico de `E` em toda rejeição; cada fraco
tem continuação `1/m=0.25`, de modo que a reserva em `A_M` é `0.225` e um
acordo aprovado dá a `H` no máximo `0.55`. Rejeitar, porém, dá `0.63` ao tipo
baixo e `0.72` ao alto. Assim qualquer proposta rejeitada é ótima. Na linha
`s(t)=(z_H=t,x_1=x_2=x_3=x_4=0)`, `0<=t<=1`, escolha `lambda` uniforme e

```text
pi(t)=0.25+0.5*t,
sigma_1(dt)=(0.5+t)dt,
sigma_0(dt)=(1.5-t)dt.
```

As duas medidas são probabilidades, e Bayes local vale em todo ponto porque
`0.5*(0.5+t)/[0.5*(1.5-t)+0.5*(0.5+t)] = pi(t)`. Isto produz um PBE
semipooling atomless com payoffs `(0.63,0.72)` por tipo. Variando `lambda`,
`pi`, conjuntos Borel e membros literais, obtêm-se famílias atômicas,
singulares e não atômicas infinitamente numerosas; não há uma lista finita de
casos que as cubra.

#### Estatuto matemático e decisão necessária

AMX-014--016 permanecem **BLOQUEADOS**. O objeto exato honesto é a união ou
correspondência indexada por `kappa_M`, pela seleção pivotal `v` e pelas
medidas `(lambda,pi)`, com Bayes local e um `argmax` efetivamente atingido.
Apresentá-lo como uma “caracterização completa” seria apenas reformular o PBE
em notação funcional, precisamente o resultado que o mandato não aceita.

Para obter uma enumeração ou um envelope fechado seria necessária uma decisão
autoral que o contrato atual não autoriza: restringir `kappa_M` a uma família
proposta-independente ou a um membro privilegiado; impor regularidade que
garanta semicontinuidade superior e atingimento; restringir medidas/suportes;
ou aceitar `epsilon`-equilíbrios. Nenhuma alternativa é escolhida aqui. Sem
essa decisão, permanecem válidos somente os equilíbrios explícitos, limites e
certificados parciais das Seções 1--6.

## 7. Exemplos numéricos auditáveis

Com `N=5`, `m=4`, `q=3` e `beta=.9`,

```text
Z_E=.55,
T=.611111.
```

| `o_0` | `o_1` | Resultado explícito | Payoff de `H` |
|---:|---:|---|---:|
| `.10` | `.35` | pooling com acordo (membro `E` mínimo no caminho; cíclico `E` fora) | `(.65125,.65125)` |
| `.10` | `.70` | baixo acorda, alto atrasa | `(.55,.63)` |
| `.10` | `.70` | semipooling, `nu=.5`, `lambda=.25` | `(.63,.63)` |
| `.70` | `.80` | pooling com atraso | `(.63,.72)` |

O script separado confere identidades de orçamento, matrizes de incidência,
aplicação única de `beta` e esses exemplos. O código é evidência mecânica, não
prova de PBE ou de completude.

## 8. O que foi resolvido e o que permanece aberto

**Demonstrado como construção ou limite candidato:**

- existência de uma testemunha de PBE explícito em todo o domínio, com a
  continuação cíclica fixada;
- pooling e separating com acordo, separating baixo-acordo/alto-atraso,
  pooling e separating com atraso;
- uma família semipooling não degenerada e misturas nas fronteiras;
- quatro impossibilidades globais;
- preços mínimos e máximos por ramo para membros/famílias fixados, a
  subfamília globalmente constante `E_F` e limites globais de payoff. Para
  seletores dependentes da proposta, `1-K_kappa(s)` é somente teto pontual;
  a atingibilidade requer o ponto fixo explicitado na Seção 2.4.

**Ainda aberto:**

- enumeração completa de todo PBE puro quando `kappa_M` varia entre vetores
  pivotais;
- classificação completa de toda estratégia Borel mista ou semipooling;
- o conjunto exato completo de payoffs de `H`, inclusive seu envelope em todos
  os seletores história-dependentes. A Seção 6.1 fornece, além disso, um
  certificado rigoroso de que alguns seletores Borel admissíveis não têm
  melhor resposta, impedindo uma classificação uniforme sob as primitivas
  atuais.

As construções gerais de AMX-003 e AMX-007 têm domínio explícito `0<nu<1`;
endpoints pertencem exclusivamente a AMX-005. AMX-014--016 ficam
**BLOQUEADOS**, e não “resolvidos”: a única descrição exata restante é a
correspondência funcional indexada por seletor, votos e medidas, que o mandato
classifica como insuficientemente informativa.

Não é necessária uma nova hipótese econômica para afirmar os equilíbrios de
existência: cada um especifica uma única continuação literal completa, como
todo assessment de PBE deve fazer. Continua sendo necessária uma **decisão do
autor** se ele quiser privilegiar o membro cíclico, impor invariância entre
histórias ou transformar os pontos atingíveis acima numa previsão única. Este
arquivo não faz nenhuma dessas três coisas; AMX-009 apenas nomeia sua
subfamília globalmente constante e não restringe o modelo geral.

## 9. Ledger de prova

| Claim | Status | Evidência |
|---|---|---|
| cobertura das três regiões por `T` | prova algébrica candidata | Seções 1 e 3 |
| existência global; `D_M^0` vazio | prova construtiva candidata | Seções 2 e 3 |
| pooling e separating imediatos | prova construtiva candidata | 3.1-3.2 |
| baixo acorda, alto atrasa | prova construtiva candidata | 3.3 |
| pooling/separating com atraso | prova construtiva candidata | 3.4 |
| endpoints | prova construtiva candidata | 3.5 |
| semipooling alto mistura | prova construtiva candidata | 4.1 |
| limites exatos de custo por ramo | prova combinatória candidata + teste R | 5.1-5.2 |
| limites globais de payoff | prova candidata | 5.4 |
| impossibilidades | prova por imitação candidata | Seção 6 |
| exemplos e identidades | verificação mecânica | script R |
| completude de toda a correspondência | **bloqueada por certificado negativo** | Seção 6.1; exige decisão autoral para qualquer restrição adicional |

## 10. Regra de invalidação

Qualquer mudança no contrato, na decisão autoral/técnica de 28/08, em `C_M` ou
nestes bytes invalida a revisão descendente. Este artefato não deve ser chamado
de `pass`, aprovado ou congelado sem revisão matemática independente sobre os
mesmos hashes e, depois dela, decisão explícita do autor.
