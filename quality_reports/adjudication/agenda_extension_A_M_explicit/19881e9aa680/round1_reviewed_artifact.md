# Resultados explícitos exploratórios para `A_M`

**Data:** 2026-08-28  
**Status:** `CANDIDATE / EXPLORATORY — MAJORITY NOT APPROVED OR FROZEN`  
**Base Git:** `b427671efee954831901e75762988043a2df7205`  
**Escopo:** somente o estágio de agenda sob maioria. Este arquivo não altera
`A_U`, `AC`, `AR`, o manuscrito, `C_M` ou qualquer artefato congelado.

Os bytes consumidos e seus hashes estão registrados em
`quality_reports/2026-08-28_agenda_extension_A_M_explicit_preflight.md`. A
referência privada reparada foi usada apenas como definição do candidato
implícito: ela não foi tratada como aval substantivo de `A_M`.

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

Logo, existe pelo menos um PBE explícito para toda primitiva admissível. Em
particular, a célula abstrata de possível não existência do gerador implícito
fica vazia:

```text
D_M^0 = vazio.
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
o_0<=T<=o_1.
```

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
rejeição rende `beta*o_0<=Z_E`. Para o tipo alto, qualquer acordo — inclusive
imitar `s_0` — rende no máximo `Z_E<=beta*o_1`, e toda rejeição fora do caminho
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

- Se `o_1=T`, o tipo alto está indiferente entre o acordo por `Z_E` e a
  rejeição com continuação `E`. A construção anterior gera semipooling para
  qualquer `lambda` cuja proposta comum satisfaça a capacidade de acordo.
- Se `o_0=T<o_1`, então `o_0>1/m` e `E` vale em todo posterior. O tipo baixo
  pode misturar entre um acordo por `Z_E` e o sinal de rejeição usado pelo tipo
  alto; o alto rejeita. Bayes no sinal compartilhado é calculado diretamente
  das probabilidades da mistura.

Não foi provada uma classificação completa de todas as medidas Borelianas
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
história-dependente admissível, defina

```text
u_j^kappa(s)=max_{a_-j pivotal} C^I_{M,j}(kappa(s,a_-j)),
K_kappa(s)=beta * soma dos k menores u_j^kappa(s).
```

Uma única história pivotal pode tornar simultaneamente pivotais todos os
membros de qualquer conjunto-alvo de tamanho `k`. Isso implica
`K_kappa(s)>=beta*M_B(mu(s))`; a construção plana mínima atinge a igualdade.
Assim `Zbar_B` é um teto rigoroso e atingível para a parcela imediata de `H`
naquele ramo.

### 5.2 Outro extremo e efeito da seleção literal

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
posterior. Entre todos os membros `E` planos, a parcela de acordo percorre o
intervalo compacto

```text
A in [Z_E,Zbar_E].
```

O extremo esquerdo é o membro cíclico; o direito é o membro mínimo da Seção
5.1; toda parcela intermediária é atingida por uma loteria interna do mesmo
binder entre suas regras de coalizão. Para cada `A`, um PBE explícito escolhe
acordo ou rejeição tipo a tipo e gera exatamente

```text
(V_H^0,V_H^1)=(max{A,beta*o_0},max{A,beta*o_1}).
```

Assim esta fórmula caracteriza exatamente a família `E` plana, embora não a
correspondência inteira com seletores dependentes do vetor pivotal.

No desempate residual entre `E` e `P`, o par de payoffs de `H` deve permanecer
no mesmo segmento conjunto,

```text
C_H^0=(1-lambda_bar)*o_0+lambda_bar*w,
C_H^1=(1-lambda_bar)*o_1+lambda_bar*w,
```

com o mesmo `lambda_bar`. É proibido combinar uma coordenada de cada extremo.

### 5.3 Limites globais para os payoffs de `H`

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

**Resolvido como derivação candidata:**

- existência de PBE explícito em todo o domínio;
- pooling e separating com acordo, separating baixo-acordo/alto-atraso,
  pooling e separating com atraso;
- uma família semipooling não degenerada e misturas nas fronteiras;
- quatro impossibilidades globais;
- preços mínimos e máximos atingíveis dos votos, a família plana `E` exata e
  limites globais de payoff.

**Ainda aberto:**

- enumeração completa de todo PBE puro quando `kappa_M` varia entre vetores
  pivotais;
- classificação completa de toda estratégia Borel mista ou semipooling;
- o conjunto exato completo de payoffs de `H`, inclusive seu envelope em todos
  os seletores história-dependentes.

Não é necessária uma nova hipótese econômica para afirmar os equilíbrios de
existência: cada um especifica uma única continuação literal completa, como
todo assessment de PBE deve fazer. Seria necessária uma **decisão do autor**
para privilegiar o membro cíclico, impor invariância entre histórias ou
transformar os pontos atingíveis acima numa previsão única. Este arquivo não
faz nenhuma dessas três coisas.

## 9. Ledger de prova

| Claim | Status | Evidência |
|---|---|---|
| cobertura das três regiões por `T` | prova algébrica candidata | Seções 1 e 3 |
| existência global; `D_M^0` vazio | prova construtiva candidata | Seções 2 e 3 |
| pooling e separating imediatos | prova construtiva candidata | 3.1–3.2 |
| baixo acorda, alto atrasa | prova construtiva candidata | 3.3 |
| pooling/separating com atraso | prova construtiva candidata | 3.4 |
| endpoints | prova construtiva candidata | 3.5 |
| semipooling alto mistura | prova construtiva candidata | 4.1 |
| limites exatos de custo por ramo | prova combinatória candidata + teste R | 5.1–5.2 |
| limites globais de payoff | prova candidata | 5.3 |
| impossibilidades | prova por imitação candidata | Seção 6 |
| exemplos e identidades | verificação mecânica | script R |
| completude de toda a correspondência | **não provada** | permanece aberta |

## 10. Regra de invalidação

Qualquer mudança no contrato, na decisão autoral/técnica de 28/08, em `C_M` ou
nestes bytes invalida a revisão descendente. Este artefato não deve ser chamado
de `pass`, aprovado ou congelado sem revisão matemática independente sobre os
mesmos hashes e, depois dela, decisão explícita do autor.
