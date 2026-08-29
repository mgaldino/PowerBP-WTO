# `A_M` sob as cláusulas M/S/B — existência, membership e classes de assinatura

**Data:** 2026-08-29  
**Status:** `IMPLEMENTER CANDIDATE — MATHEMATICAL REVIEW PENDING`  
**Branch:** `agenda-extension-am-msb`  
**Base histórica da rederivação:** `b675a372d7c92703335e5c70a18077e9151f254d`  
**Commit normativo consumido:** `4bda7b71e1e6d4e836912b533fef8b28ee044c71`  
**Escopo:** somente `A_M`. `A_U`, `AC`, `AR`, N1–N7 e o manuscrito não são
consumidos nem alterados.

Este documento rederiva o estágio privado de agenda sob maioria depois da
emenda M/S/B. Não revisa os próprios resultados. O ledger correspondente é
`model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv`; as checagens
mecânicas estão em `scripts/verify_agenda_extension_A_M_msb.R`.

## 1. Fontes, precedência e interface consumida

A ordem normativa aplicada foi:

1. emenda M/S/B aprovada,
   `quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md`,
   SHA-256 `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`;
2. Gate 0 simplificado no que não foi emendado,
   `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md`,
   SHA-256 `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
3. certificado exploratório histórico,
   `model_redesign/agenda_extension_A_M_explicit_majority_results.md`,
   SHA-256 `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`;
4. memória do resultado negativo,
   `quality_reports/2026-08-29_memoria_resultado_extensao_agenda_maioria.md`,
   SHA-256 `4db9a6692e0cafeafcc5f9bc7ada8a255a3e98a424fa5c90119b2d6470a9a732`;
5. registro externo Sol 5.6,
   `quality_reports/2026-08-29_review_sol56_emenda_extensao_agenda.md`,
   SHA-256 `a1b89479a44d7cef148859d8219701ce370cbcedcfe994d5436bc565980bc25a`.

A única continuação substantiva consumida é a correspondência congelada
`C_M` em
`model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`,
SHA-256 `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`.
Ela permanece intacta. A emenda seleciona, para a extensão, representantes
anônimos que já pertencem literalmente a essa correspondência; não altera N3.

## 2. Estado suficiente, ordem e notação

Há um hegemon `H`, `m=N-1` Estados fracos, `N>=3`, quota total

```text
q=floor(N/2)+1,
k=q-1,
```

e `H` fornece automaticamente um voto favorável. O tipo privado é
`theta in {0,1}`, com prior `nu`, `0<o_0<o_1<1`,
`o_1<=y_bar<=1` e
`beta in (0,1)`. `y_bar` é a primitiva de domínio herdada de `C_M`; os
resultados abaixo são uniformes nela. Nas propostas relevantes de `C_M`, o
maior pagamento a `H` é `t1=beta*o_1<=o_1<=y_bar`, de modo que `y_bar` não
entra nas fronteiras nem nos payoffs, mas não é apagada do tipo da interface.
A proposta é `s=(z_H,x_1,...,x_m)` em

```text
Y={s: z_H>=0, x_j>=0, z_H+sum_j x_j<=1}.
```

Depois de rejeição entra uma continuação literal de `C_M`; seu payoff nativo
é multiplicado por `beta` exatamente uma vez ao ser transportado para `A_M`.
O estado markoviano é

```text
phi_M(h)=(M, estágio de entrada em C_M, posterior público mu(h)).
```

Logo a seleção admissível é `kappa_M(h)=kappa_hat_M(phi_M(h))`: ela não pode
depender da proposta rejeitada nem do vetor de votos. A ordem de dependência é

```text
C_M (congelado) -> representante anônimo de C_M -> ballot de A_M
                -> proposta ótima de cada tipo -> assinatura de A_M.
```

## 3. Membership literal do representante uniforme

### 3.1 Ramos de `C_M`

Defina, em unidades nativas de `C_M`,

```text
w  = beta/m,
t0 = beta*o_0,
t1 = beta*o_1,
E  = 1-k*w,
L  = 1-(k-1)*w-t0,
P  = 1-(k-1)*w-t1.
```

Os ramos selecionados pela correspondência congelada são os mesmos do
artefato N3:

1. se `o_1<1/m`, `S` até `nu_SP`, inclusive, e `P` acima;
2. se `o_0<1/m<o_1`, `S` até `nu_SE`, inclusive, e `E` acima;
3. se `1/m<o_0<o_1`, `E` em todo posterior;
4. se `o_0=1/m<o_1`, `S` somente em `mu=0` e `E` em `mu>0`;
5. se `o_0<o_1=1/m`, `S` até `nu_SE`; acima, vale o desempate residual
   congelado entre `E` e `P`, com mistura apenas na igualdade também do
   payoff esperado de `H`.

Nos endpoints, `B(0)=S` se `o_0<=1/m` e `E` caso contrário; `B(1)=P` se
`o_1<=1/m` e `E` caso contrário.

### 3.2 Construção uniforme

Fixe um proponente fraco `i`. No ramo `E`, sorteie uniformemente uma coalizão
`Q` entre todos os subconjuntos de `W\{i}` com `|Q|=k`. Nos ramos `S` e `P`,
sorteie uniformemente `Q` com `|Q|=k-1`. Para cada realização, use a proposta
canônica correspondente do registro `N3-SC-EQ-COMPLETE`.

Cada proposta na loteria está no argmax lexicográfico congelado do proponente:
a identidade da coalizão não altera seu payoff nem o payoff esperado de `H`.
Uma distribuição suportada nesse argmax é expressamente permitida pelo campo
`strategy_profile.selection` de `C_M`. Fazer isso para todo `i`, junto com os
votos, crenças e resultados do mesmo registro N3, produz um membro literal
completo de `C_M`. No empate residual `E/P`, uma mistura anônima usa o mesmo
peso para cada identidade reconhecida e permanece suportada no mesmo argmax.

Para cada fraco `j!=i`, a probabilidade condicional de inclusão é

```text
Pr(j in Q | i reconhecido)=r_B/(m-1),
r_E=k,   r_S=r_P=k-1.
```

Daí o payoff interino comum de cada fraco e o payoff nativo de `H` são

| ramo `B` | `c_B(mu)` de cada fraco | `h_B(0),h_B(1)` de `H` |
|---|---:|---:|
| `E` | `1/m` | `(o_0,o_1)` |
| `S` | `[(1-mu)(1-beta*o_0)+mu*beta]/m` | `(beta*o_0,beta*o_1)` |
| `P` | `(1-beta*o_1)/m` | `(beta*o_1,beta*o_1)` |

No empate residual, essas coordenadas são misturadas com um único peso comum;
nenhuma coordenada de membros diferentes é recombinada.

Formalmente, equipe o codomínio canônico da continuação com a união disjunta

```text
X_M={E,S,P} uniao ({EP} x [0,1]),
```

dotada da σ-álgebra Borel da união finita. `E`, `S` e `P` significam os
representantes uniformes literais acima. `(EP,alpha)` mistura, com peso
`alpha`, os representantes uniformes `E` e `P` somente no ponto em que ambos
permanecem no argmax depois do desempate congelado. Uma seleção admissível

```text
chi:[0,1] -> X_M
```

é Borel e precisa escolher o rótulo permitido por `C_M(mu)`. Considerados
conjuntamente em `(mu,chi)`, `c_S(mu)` é afim em `mu`, os mapas dos rótulos
`E/P` são constantes no posterior e os mapas de `(EP,alpha)` são afins em
`alpha`; os payoffs e o kernel terminal são, portanto, Borel. Não há outros membros
payoff-anônimos ocultos no codomínio corrente: a assinatura usa literalmente
o representante uniforme e seu kernel de coalizões.

### 3.3 Equivalência de payoffs com a implementação cíclica

Na construção cíclica histórica, cada `j` aparece como parceiro em exatamente
`r_B` das `m-1` propostas feitas por outros fracos. Na loteria uniforme, sua
incidência esperada agregada é

```text
(m-1)*r_B/(m-1)=r_B.
```

O payoff do proponente, os pagamentos quando parceiro, a probabilidade de
reconhecimento e os payoffs de `H` são iguais. Portanto os dois membros têm o
mesmo vetor de payoffs interinos, identidade por identidade. Isso prova a
payoff-equivalência exigida pela Cláusula S.

Essa equivalência não identifica as distribuições literais de coalizões
rotuladas: o ciclo e a loteria uniforme podem gerar distribuições terminais
diferentes. Como a assinatura downstream contém a distribuição de outcomes,
a rederivação usa o representante uniforme literalmente; o ciclo fica apenas
como implementação mecânica de payoffs.

## 4. Colapso exato do ballot

Para uma seleção anônima `chi(mu)` de `C_M`, ponha, agora em unidades de
`A_M`,

```text
r_chi(mu)       = beta*c_chi(mu),
D_chi_theta(mu) = beta*h_chi_theta(mu),
A_chi(mu)       = 1-k*r_chi(mu).
```

`r_chi(mu)>0` e `k*r_chi(mu)<1`. Pela Cláusula M, todos os vetores pivotais
depois de uma proposta com posterior `mu` usam o mesmo membro literal. Logo,
para todo fraco `j`,

```text
j vota sim  sse  x_j>=r_chi(mu).
```

A igualdade produz `sim` por `T^Y`. A proposta passa se e somente se pelo
menos `k` fracos recebem ao menos `r_chi(mu)`.

Para `mu` e `chi(mu)` fixados, o conjunto

```text
Acc(mu,chi)=uniao_{Q:|Q|=k} interseção_{j in Q}{x_j>=r_chi(mu)}
```

é uma união finita de subconjuntos fechados de `Y`; portanto é compacto. O
melhor acordo é atingido pela proposta canônica que paga `r_chi(mu)` a algum
`Q`, zero aos demais e deixa `A_chi(mu)` para `H`. A proposta
`(z_H=1,x=0)` é claramente rejeitada e atinge `D_chi_theta(mu)`. Assim, no
problema condicional a um posterior fixo, a melhor utilidade do tipo `theta` é

```text
max{A_chi(mu),D_chi_theta(mu)},
```

e ambos os termos são atingidos.

## 5. Finding de existência: fechamento condicional, não global

A frase “o conjunto de propostas aceitas é fechado” é correta dentro de cada
posterior fixo, mas é falsa para o conjunto global produzido pela colagem entre
Bayes on-path e `nu_off`. Esse ponto não exige protocolo novo; exige apenas não
usar a rota global falsa.

### 5.1 Contraexemplo dentro de um PBE M/S/B

Tome

```text
N=5, m=4, k=2, beta=.9, o_0=.1, o_1=.9,
0<nu<1, nu_off=0.
```

Em `mu=0`, o ramo é `S` e

```text
r(0)=.9*(1-.9*.1)/4=.20475,
A(0)=1-2*r(0)=.5905.
```

Em `mu=1`, o ramo é `E`, `r(1)=.225`,
`D_0(1)=.09` e `D_1(1)=.81`. O tipo baixo faz um acordo por `.5905`,
pagando `.20475` aos membros de uma coalizão `Q_0`. O tipo alto envia uma
proposta distinta com a mesma parcela e os mesmos pagamentos para outra
coalizão `Q_1`. Esse segundo sinal é rejeitado em `mu=1`, porque
`.20475<.225`.

Os incentivos são:

```text
tipo 0: .5905 > .09 e .5905 = melhor acordo off-path;
tipo 1: .81 > .5905 e .81 > max{.5905,.729} off-path.
```

Logo a construção é um PBE separating sob M/S/B. Entretanto, propostas
off-path que aumentam um pagamento de `Q_1` em `epsilon_n>0` e reduzem
`z_H` na mesma quantia são aceitas sob `nu_off=0` e convergem para o sinal
on-path rejeitado do tipo alto. O conjunto global de aceitação não é fechado.

### 5.2 Lema de existência corrigido

**Lema AM-MSB-E.** Para toda primitiva admissível e todo prior existe pelo
menos um PBE de `A_M` sob M/S/B. Nos endpoints, `nu_off=nu` é obrigatório.
No interior, uma testemunha pode ser escolhida por região:

| região | `nu_off` da testemunha | outcome |
|---|---:|---|
| `o_1<=T` | `nu` | pooling com acordo |
| `o_0<=T<=o_1` | `1` | baixo acorda, alto atrasa |
| `T<=o_0` | qualquer valor | ambos atrasam |

onde

```text
Z_E=1-k*beta/m,
T=Z_E/beta=1/beta-k/m,
T>1/m.
```

As fronteiras podem usar qualquer testemunha adjacente. A prova é
construtiva e aparece na Seção 7. Ela compara propostas canônicas que atingem
o melhor acordo e a rejeição dentro dos posteriores efetivamente usados. Não
depende de semicontinuidade superior nem de fechamento global.

## 6. Classificação completa dos PBEs puros

Fixe `0<nu<1`, `nu_off` e uma seleção markoviana anônima `chi`. Abrevie

```text
A_p=A_chi(p),
D_theta_p=D_chi_theta(p),
O_theta=max{A_off,D_theta_off},
```

com `off=nu_off`. Como `D_1_p>=D_0_p`, vale `O_1>=O_0`.

Todo perfil puro é pooling ou separating. As condições abaixo são necessárias
e suficientes; em cada linha escolhem-se propostas factíveis distintas quando
necessário.

### 6.1 Pooling

1. **Acordo pooling.** Existe se e somente se

   ```text
   O_1<=A_nu.
   ```

   Todo `z in [O_1,A_nu]` pode ser implementado por um pacote aceito. Os dois
   tipos recebem `z`.

2. **Atraso pooling.** Existe se e somente se

   ```text
   D_0_nu>=O_0  e  D_1_nu>=O_1.
   ```

   Uma proposta claramente rejeitada implementa os payoffs
   `(D_0_nu,D_1_nu)`.

### 6.2 Separating

1. **Acordo dos dois tipos.** Imitar a proposta do outro tipo implica
   `z_0=z_1=z`. Existe se e somente se

   ```text
   O_1<=min{A_0,A_1}.
   ```

   Todo `z in [O_1,min{A_0,A_1}]` é admissível.

2. **Acordo do tipo baixo e atraso do alto.** Existe se e somente se

   ```text
   D_1_1>=O_1
   e
   max{D_0_1,O_0}<=min{A_0,D_1_1}.
   ```

   Todo

   ```text
   z in [max{D_0_1,O_0}, min{A_0,D_1_1}]
   ```

   implementa `(V_H^0,V_H^1)=(z,D_1_1)`.

3. **Atraso do baixo e acordo do alto.** É impossível: as restrições de
   imitação exigiriam `D_0_0>=z>=D_1_0`, mas `D_1_0>D_0_0`.

4. **Atraso dos dois tipos.** Existe se e somente se

   ```text
   D_0_0>=D_0_1,
   D_1_1>=D_1_0,
   D_0_0>=O_0,
   D_1_1>=O_1.
   ```

   Os payoffs são `(D_0_0,D_1_1)`.

**Prova de completude.** Em perfil puro interior, propostas iguais geram o
posterior `nu` e o mesmo resultado de ballot. Propostas distintas geram
posteriores `0` e `1`. Cada tipo pode imitar literalmente o sinal do outro;
todo outro pacote é não disciplinado e enfrenta `nu_off`. As quatro combinações
de acordo/atraso acima esgotam os resultados. As desigualdades listadas são
exatamente factibilidade, imitação bilateral e ausência de desvio off-path.

### 6.3 Endpoints do prior

Se `nu in {0,1}`, o suporte do prior força `mu(s)=nu_off=nu` em todo `Y`.
Cada tipo, inclusive o de probabilidade zero, escolhe globalmente entre
`A_nu` e `D_theta_nu`:

```text
A_nu>D_theta_nu  -> acordo;
A_nu<D_theta_nu  -> atraso;
A_nu=D_theta_nu  -> qualquer mistura entre propostas canônicas.
```

As escolhas dos dois tipos podem coincidir ou separar sem alterar a crença.
Isso é a classificação endpoint completa em outcomes puros; as medidas e
assinaturas endpoint completas são formalizadas na Seção 9.1.

## 7. Prova construtiva da existência por região

### 7.1 `o_1<=T`: pooling com acordo

Escolha `nu_off=nu` e o mesmo representante uniforme `B(nu)` on e off path.
Ambos os tipos fazem a proposta canônica que deixa `A_nu` para `H`.

- no ramo `E`, `D_1=beta*o_1<=beta*T=Z_E=A_E`;
- no ramo `S`, `D_1=beta^2*o_1<Z_E<A_S`;
- no ramo `P`, `D_1=beta^2*o_1<Z_E<A_P`.

Logo `O_1<=A_nu`, satisfazendo a condição pooling da Seção 6.1.

### 7.2 `o_0<=T<=o_1`: baixo acorda e alto atrasa

Escolha `nu_off=1`. Como `T>1/m`, em `mu=1` o ramo é `E`:

```text
A_1=Z_E=beta*T,
D_0_1=beta*o_0<=Z_E,
D_1_1=beta*o_1>=Z_E.
```

Em `mu=0`, o ramo é `S` se `o_0<=1/m` e `E` caso contrário, de modo que
`A_0>=Z_E`. Escolher `z=Z_E` satisfaz todas as desigualdades da Seção 6.2.2.

### 7.3 `T<=o_0`: atraso dos dois tipos

Aqui `o_0>=T>1/m`; portanto `E` é o único ramo em todo posterior. Assim

```text
A_p=Z_E,
D_theta_p=beta*o_theta>=Z_E
```

para todo `p`, com igualdade possível na fronteira. Pooling ou separating com
atraso satisfaz a Seção 6 para qualquer `nu_off`.

## 8. Classificação dos PBEs mistos pelas assinaturas on-path

A Cláusula B elimina a liberdade ponto a ponto fora do caminho, mas não elimina
a variação de Bayes dentro do suporte. A classificação completa precisa reter
essa variação.

### 8.1 Objeto reduzido

Para `0<nu<1`, sejam `sigma_0,sigma_1` medidas Borel de propostas e

```text
lambda=(1-nu)*sigma_0+nu*sigma_1,
S=supp(lambda).
```

Um objeto reduzido admissível é a tupla

```text
R=(sigma_0,sigma_1,lambda,pi,chi,a,u_0,u_1),
```

com:

1. `pi(y)` igual ao limite local de Bayes em todo `y in S`; se algum limite
   não existe, a tupla é inadmissível;
2. `pi(y)=nu_off` em `Y\S`;
3. `chi(pi)` Borel, markoviana e pertencente ao codomínio canônico `X_M` da
   Seção 3.2, com o ramo permitido por `C_M(pi)`;
4. `a(y)=1` se e somente se ao menos `k` pagamentos cobrem `r_chi(pi(y))`;
5. o kernel terminal é o kernel Borel do representante uniforme do mesmo
   rótulo `chi(pi)`;
6. payoffs de desvio

   ```text
   u_theta(y)=z_H(y)                         se a(y)=1,
              D_chi_theta(pi(y))             se a(y)=0.
   ```

Nos pontos `lambda`-quase todos, Bayes também implica

```text
d sigma_1/d lambda = pi/nu,
d sigma_0/d lambda = (1-pi)/(1-nu),
integral pi d lambda = nu,
```

mas essas igualdades quase em toda parte não substituem o limite local exigido
em cada ponto disciplinado.

### 8.2 Teorema de membership necessário e suficiente

Para suporte público `S`, defina o valor exato dos desvios não disciplinados

```text
O_theta(S)=sup_{y in Y\S} u_theta^off(y),
```

onde `u_theta^off` usa `nu_off` e `chi(nu_off)`; o supremo do conjunto vazio é
`-infinito`. Em suportes finitos, o complemento é denso e
`O_theta(S)=max{A_off,D_theta_off}`. Em suportes gerais, não se substitui esse
supremo por um pacote canônico que por acaso pertença ao próprio suporte.

Defina `V_theta` como a utilidade comum das propostas usadas pelo tipo
`theta`. A tupla `R` gera um PBE sob M/S/B se e somente se:

```text
u_theta(y)<=V_theta para todo y in S,
u_theta(y)=V_theta para sigma_theta-quase todo y,
V_theta>=O_theta(S),
```

para `theta=0,1`, além das condições 1–6 da Seção 8.1.

**Necessidade.** Cada tipo pode escolher qualquer sinal alcançado pelo outro e
qualquer pacote não disciplinado. A última classe tem supremo exatamente
`O_theta(S)` por definição.

**Suficiência.** Prescreva os votos de corte da Seção 4 e a continuação
`chi(pi(y))`. Bayes e B valem por construção. Em sinais alcançados, nenhuma
ação supera `V_theta`; fora do suporte, nenhuma ação supera `O_theta(S)`; e cada
tipo mistura apenas entre melhores respostas. Todas as coordenadas usam a
mesma tupla, sem recombinação marginal.

Esse teorema reduz o problema funcional original a posteriores on-path,
outcome de ballot e duas condições de melhor resposta. Ele não transforma
uma família contínua de sinais em uma lista finita.

### 8.3 Restrições locais úteis

- Se `0<pi(y)<1` e `y` passa, ambos os tipos usam o sinal e
  `V_0=V_1=z_H(y)`.
- Se `0<pi(y)<1` e `y` é rejeitado, ambos os tipos usam o sinal e
  `V_theta=D_theta(pi(y))`.
- Se `pi(y)=0` ou `1`, somente o tipo correspondente pode usar o sinal, mas o
  outro tipo ainda precisa preferir seu próprio valor a imitá-lo.
- Se o tipo alto usa uma proposta aprovada com probabilidade positiva, então
  `V_0=V_1`.

## 9. Assinatura downstream e impossibilidade de redução finita

Para cada objeto reduzido, a assinatura mínima é:

```text
Sig(R)=(V_H^0,V_H^1,(W_j)_{j in W},p_A^0,p_A^1,p_D^0,p_D^1,
        Q_0,Q_1,G_pi),
```

onde

```text
W_j = integral [a(y)*x_j(y)+(1-a(y))*r_chi(pi(y))] lambda(dy),
p_A^theta = integral a(y) sigma_theta(dy),
p_D^theta = 1-p_A^theta,
```

`Q_theta` é a distribuição terminal por tipo: em acordo, o pushforward do
pacote implementado; em atraso, a mistura dos kernels terminais literais de
`chi(pi(y))`. `G_pi` é a distribuição conjunta dos sinais alcançados e de
seus posteriores, isto é, o pushforward de `lambda` por `y -> (y,pi(y))`.

### 9.1 Objetos e assinaturas nos endpoints

Para `nu in {0,1}`, defina o objeto reduzido endpoint

```text
R_boundary=(sigma_0,sigma_1,nu,chi_nu,a_nu,u_0,u_1),
```

onde `sigma_0` e `sigma_1` são medidas Borel de propostas, `pi(y)=nu_off=nu`
em todo `Y`, `chi_nu` é o representante canônico admissível de `C_M(nu)`, e
`a_nu,u_0,u_1` seguem as fórmulas da Seção 8 com posterior constante. Ponha

```text
M_theta=max{A_nu,D_theta_nu}.
```

O objeto gera um PBE endpoint se e somente se

```text
sigma_theta({y:u_theta(y)=M_theta})=1, theta=0,1.
```

Essa condição inclui qualquer mistura Borel sobre propostas aprovadas
canônicas, propostas rejeitadas ou ambas na igualdade, inclusive a estratégia
contrafactual do tipo de probabilidade zero. A assinatura usa as mesmas
coordenadas da Seção 9, com

```text
lambda=sigma_0 se nu=0; lambda=sigma_1 se nu=1,
V_H^theta=M_theta,
G_pi=(y,nu)_# lambda,
```

e calcula `p_A^theta,p_D^theta,Q_theta` separadamente sob cada `sigma_theta`.
O payoff interino fraco `W_j` usa `lambda`, pois só o tipo de probabilidade
positiva entra na expectativa anterior ao sinal. Assim, sinais distintos que
produzem a mesma rejeição continuam distintos em `G_pi` e em `Q_theta` quando
apropriado.

A correspondência conjunta completa de assinaturas é, portanto,

```text
{Sig(R): 0<nu<1 e R satisfaz a Seção 8}
uniao
{Sig_boundary(R_boundary): nu in {0,1} e R_boundary satisfaz esta seção}.
```

Nenhuma identidade de Radon–Nikodym com divisão por `nu` ou `1-nu` é usada
nos endpoints.

### 9.2 Teorema negativo de finitude

Não existe, em geral, redução a um número finito de classes de assinatura para
`(nu,nu_off)` fixado.

Primeiro, no PBE da Seção 5, o tipo baixo pode misturar com qualquer peso
`p in [0,1]` entre duas coalizões aceitas distintas em `mu=0`; os payoffs de
`H` e todos os incentivos permanecem iguais, mas os payoffs interinos por
identidade e a distribuição de alocações variam com `p`.

Segundo, tome `N=5`, `beta=.9`, `o_0=.7`, `o_1=.8`, `nu=.5` e
`nu_off=.5`. O ramo `E` é único em todo posterior, `A=.55`, enquanto rejeição
dá `.63` ao tipo baixo e `.72` ao alto. Na linha de propostas rejeitadas
`s(t)=(t,0,0,0,0)`, `t in [0,1]`, escolha `lambda` uniforme e

```text
pi(t)=.25+.5*t,
sigma_1(dt)=(.5+t)dt,
sigma_0(dt)=(1.5-t)dt.
```

O limite local de Bayes vale em todo ponto disciplinado, M usa sempre o mesmo
representante uniforme `E`, e B fixa `.5` fora do suporte. Todo sinal usado é
uma melhor resposta rejeitada. Variações contínuas admissíveis de `pi` geram
assinaturas distintas pela coordenada `G_pi`. Portanto os objetos on-path da
Seção 8 são matematicamente indispensáveis, não um expediente administrativo.

## 10. Revalidação das testemunhas exploratórias

Nada nesta tabela é herdado. Cada linha foi rechecada com `kappa_M` markoviana,
`nu_off` único e representante uniforme literal.

Para a família semipooling do tipo alto, deixe o baixo enviar sempre o sinal
aceito `s_A`; o alto envia `s_A` com probabilidade `lambda in (0,1)` e um
sinal rejeitado `s_D` com a probabilidade restante. Então

```text
mu_A=nu*lambda/[(1-nu)+nu*lambda] in (0,nu),
mu(s_D)=1 por Bayes,
nu_off=1 nos pontos não disciplinados.
```

O acordo comum dá `z=beta*o_1`. O alto fica indiferente entre esse acordo e
a rejeição `E` em `mu=1`; o baixo prefere o acordo. Todos os desvios ficam
cobertos se e somente se, dentro dessa construção,

```text
beta*o_1>=Z_E
e
A_chi(mu_A)>=beta*o_1.
```

Na fronteira `o_0=T<o_1`, uma família distinta faz o baixo misturar entre um
acordo por `Z_E` e o sinal rejeitado compartilhado com o alto. O alto sempre
usa o sinal rejeitado. Como `E` é único em todo posterior, o baixo recebe
`beta*o_0=Z_E` nos dois sinais e o alto recebe `beta*o_1>Z_E`; qualquer
`nu_off` preserva esses incentivos.

| fonte histórica | estatuto sob M/S/B | escopo revalidado |
|---|---|---|
| §3.1 pooling com acordo | `PROVED CANDIDATE` | válido para `o_1<=T` com `nu_off=nu`; mais geralmente sse `O_1<=A_nu` |
| §3.2 separating, ambos acordam, `o_1<=1/m` | `PROVED CANDIDATE` | válido com `nu_off=0`, `S` em `0`, `P` em `1` e parcela comum `A_0` |
| §3.2 separating, ambos acordam, `1/m<o_1<=T` | `PROVED CANDIDATE` | válido com `nu_off=1`, parcela comum `Z_E` |
| §3.3 baixo acorda, alto atrasa | `PROVED CANDIDATE` | válido no interior para `o_0<=T<=o_1`, `nu_off=1` |
| §3.4 pooling/separating com atraso | `PROVED CANDIDATE` | válido para `T<=o_0`, qualquer `nu_off` |
| §3.5 endpoints | `PROVED CANDIDATE` | válido com `nu_off=nu`, escolhas tipo a tipo entre `A_nu` e `D_theta_nu` |
| §4.1 semipooling alto | `PARTIAL / RE-SCOPED` | válido com `nu_off=1` somente se `beta*o_1>=Z_E` e `A_chi(mu_A)>=beta*o_1`; o antigo `Zbar_B` assimétrico não é admissível sob S |
| exemplo §4.1 `(.1,.7,nu=.5,lambda=.25)` | `REJECTED UNDER S` | capacidade uniforme em `mu_A=.2` é `.5914<.63`; a testemunha usava votos assimetricamente baratos |
| §4.2, `o_1=T` | `PROVED CANDIDATE` | semipooling sobrevive porque `beta*o_1=Z_E<=A_chi(mu_A)`, com `nu_off=1` |
| §4.2, `o_0=T<o_1` | `PROVED CANDIDATE` | o baixo pode misturar entre acordo e atraso; `E` é único e qualquer `nu_off` serve |
| família atomless da §6.1 | `PROVED CANDIDATE` | sobrevive com representante uniforme `E` e `nu_off` constante; mostra complexidade on-path |

A implementação cíclica foi substituída pelo representante uniforme. A
equivalência de payoffs prova que essa substituição preserva as desigualdades
das testemunhas que usavam preços comuns. Ela não preserva a família que
explorava graus de incidência desiguais.

## 11. Limites e impossibilidades sob o contrato emendado

Em todo PBE M/S/B,

```text
max{Z_E,beta^2*o_theta}<=V_H^theta<=1,
0<=V_H^1-V_H^0<=beta*(o_1-o_0).
```

O primeiro limite é robusto à crença induzida. `H` pode pagar `beta/m` a
quaisquer `k` fracos e reter `Z_E`; como `r_chi(mu)<=beta/m` em todo ramo e
posterior, essa proposta passa qualquer que seja a crença. A proposta
`(1,0,...,0)` é rejeitada em todo posterior e dá pelo menos
`beta^2 o_theta`. O segundo limite segue ponto a ponto:
um acordo dá a mesma parcela aos tipos; a diferença numa rejeição é
`beta(o_1-o_0)` em `E`, `beta^2(o_1-o_0)` em `S` e zero em `P`.
Maximizar preserva essas desigualdades.

Continuam válidos:

1. pooling não pode gerar acordo para um tipo e atraso para outro;
2. separating com acordo dos dois tipos exige a mesma parcela de `H`;
3. separating com atraso do baixo e acordo do alto é impossível;
4. separating com atraso dos dois tipos exige `o_0>1/m`.

Sob S, a antiga geometria de preços por graus de incidência não é uma dimensão
da continuação admissível: em cada ramo selecionado todos os fracos têm o mesmo
payoff interino. A largura `[Z_E,Zbar_E]` de membros assimétricos não é uma
família corrente de `A_M`.

## 12. Certificado negativo preservado

O certificado da exploração anterior permanece verdadeiro e não foi
enfraquecido. Sob o contrato original, o seletor podia alternar entre membros
de `C_M` conforme a proposta e o vetor de votos. Na instância

```text
N=5, m=4, k=2, beta=.9, o_0=.30, o_1=.40,
```

uma sequência Borel de propostas produzia `sup g=51/100` sem máximo; nenhuma
medida mista era melhor resposta. Portanto existência uniforme e classificação
informativa falhavam no domínio antigo.

Esse seletor literal é inadmissível agora porque M proíbe que `kappa_M` varie
entre propostas com o mesmo estado. Separadamente, B impede reconstruir o
mesmo interruptor recodificando a proposta por crenças em pontos não
disciplinados. O certificado é resultado
histórico permanente e motivação das cláusulas; não é um resultado de
não-existência sob M/S/B.

## 13. Estatuto de AMX-014–016

- **AMX-014:** reaberto e classificado para estratégias puras pelas condições
  necessárias e suficientes da Seção 6, indexadas por `(nu,nu_off,chi)`.
- **AMX-015:** reaberto e classificado pelo objeto reduzido e pelo teste
  necessário e suficiente da Seção 8. Não admite redução finita geral; os
  objetos on-path são parte indispensável do teorema.
- **AMX-016:** a correspondência conjunta exata é a união da imagem de
  `Sig(R)` no interior com a imagem de `Sig_boundary(R_boundary)` nos
  endpoints. Nenhum envelope cartesiano ou recombinação de marginais é usado.
  Uma fórmula finita fechada é rejeitada pelo teorema da Seção 9.2.

Esses três claims são candidatos do implementador e exigem revisão matemática
independente sobre os mesmos bytes antes de qualquer consumo downstream.

## 14. Invalidação

Qualquer mudança em M, S, B, no limite local de Bayes, nos desempates, na
interface congelada `C_M` ou na assinatura downstream invalida toda esta
rederivação. Alterar apenas `A_U` não muda estes claims, mas `AC` não pode
consumi-los antes das revisões independentes e da decisão autoral aplicável.
