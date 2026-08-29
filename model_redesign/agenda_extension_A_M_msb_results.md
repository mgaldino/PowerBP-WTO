# `A_M` sob as cláusulas M/S/B — existência, membership e classes de assinatura

**Data:** 2026-08-29  
**Status:** `POST-EXTERNAL-REVIEW REPAIR CANDIDATE — FRESH FORMAL REVIEWS PENDING`
**Branch:** `agenda-extension-am-msb`  
**Base histórica da rederivação:** `b675a372d7c92703335e5c70a18077e9151f254d`  
**Commit normativo consumido:** `4bda7b71e1e6d4e836912b533fef8b28ee044c71`  
**Snapshot substantivo pré-reparo:** `6fa852c52cd3a277735697b78a42d5f1774c6320`
**HEAD operacional de abertura:** `bfd149898cdf1915b453f95d7d4401c4d2de5682`
**Escopo:** somente `A_M`. `A_U`, `AC`, `AR`, N1–N7 e o manuscrito não são
consumidos nem alterados.

Este documento rederiva o estágio privado de agenda sob maioria depois da
emenda M/S/B. Não revisa os próprios resultados. O ledger correspondente é
`model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv`; as checagens
mecânicas estão em `scripts/verify_agenda_extension_A_M_msb.R`.

## 1. Fontes, precedência e interface consumida

A ordem normativa aplicada neste passe é:

1. emenda M/S/B aprovada,
   `quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md`,
   SHA-256 `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`;
2. clarificação aprovada sobre anonimato e kernel uniforme,
   `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md`,
   SHA-256 `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3`;
3. decisões pós-parecer aprovadas,
   `quality_reports/plans/2026-08-29_decisoes_pos_parecer_chatgpt_A_M.md`,
   SHA-256 `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471`;
4. consulta técnica externa não formal, usada como checklist de reparos e não
   como gate,
   `quality_reports/external_reviews/2026-08-29_consulta_tecnica_chatgpt_web_A_M_msb.md`,
   SHA-256 `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c`;
5. Gate 0 simplificado no que não foi emendado,
   `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md`,
   SHA-256 `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
6. certificado exploratório histórico,
   `model_redesign/agenda_extension_A_M_explicit_majority_results.md`,
   SHA-256 `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`;
7. memória do resultado negativo,
   `quality_reports/2026-08-29_memoria_resultado_extensao_agenda_maioria.md`,
   SHA-256 `4db9a6692e0cafeafcc5f9bc7ada8a255a3e98a424fa5c90119b2d6470a9a732`;
8. registro externo Sol 5.6,
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

### 2.1 Cláusula B pointwise e coordenada `rho`

Equipe `Y`, subconjunto compacto de `R^(m+1)`, com a métrica euclidiana
relativa `d` e defina

```text
B_Y(y,r)={y' in Y: d(y,y')<r}.
```

Para estratégias de proposta `sigma_0,sigma_1 in P(Y)`, ponha

```text
lambda=(1-nu)*sigma_0+nu*sigma_1,
S=supp(lambda).
```

Em todo `y in S`, a crença é a restrição pointwise

```text
pi(y)=lim_{r->0} nu*sigma_1(B_Y(y,r))/lambda(B_Y(y,r)).
```

Como `y` pertence ao suporte, o denominador é positivo para todo `r>0`. Se o
limite falhar em algum ponto de `S`, o assessment é **B-inadmissível**. Em
todo `y` fora de `S`, vale o mesmo escalar `nu_off`, independentemente da
mensagem. Essa disciplina pointwise em todo o suporte e a constância fora dele
são restrições adicionais ao PBE usual; não decorrem de PBE, sequential
equilibrium, trembles, Critério Intuitivo ou D1.

Como `Y` é finito-dimensional e as medidas são Radon, o teorema de
diferenciação de Besicovitch identifica, `lambda`-quase certamente,

```text
pi=d(nu*sigma_1)/d lambda.
```

Para uma sequência racional `r_n` decrescente a zero, as razões acima são
funções Borel de `y`; onde o limite pointwise existe, `pi` é Borel em `S` e,
por ser constante no complemento Borel de `S`, é Borel em `Y`.

No prior interior, reparametrize a crença não disciplinada por uma coordenada
do assessment

```text
rho in [0,infinity],
nu_off=b_rho(nu)=nu*rho/(1-nu+nu*rho).
```

Equivalentemente,

```text
odds(nu_off)=rho*odds(nu).
```

As convenções são `b_0(nu)=0`, `b_infinity(nu)=1` para `0<nu<1`,
`b_rho(0)=0` e `b_rho(1)=1` para todo `rho`. O mapa é contínuo e estritamente
crescente no prior interior, `b_1(nu)=nu`, e sua inversa é

```text
rho=p*(1-nu)/(nu*(1-p)),
```

com os limites usuais em `p=0,1`. Portanto manter `rho` livre por assessment
é uma reparametrização bijetiva da cláusula B aprovada, não uma restrição nova.

Uma racionalização no nível dos sinais usa lapses

```text
sigma_theta^n=(1-epsilon_theta_n)*sigma_theta+epsilon_theta_n*tau,
```

onde `tau` tem suporte pleno e é comum aos tipos e
`epsilon_1n/epsilon_0n -> rho`. A crença limite fora do suporte é
`b_rho(nu)`. Essa construção racionaliza somente as crenças sobre sinais: ela
**não prova consistência sequencial do assessment completo**, que exigiria
perturbações também dos votos e das continuações de `C_M`.

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
`alpha`; os payoffs e o kernel terminal são, portanto, Borel. Não há outros
membros payoff-anônimos ocultos no codomínio corrente: a continuação
efetivamente selecionada e registrada na assinatura é sempre o representante
literal uniforme, ou a mistura comum dos representantes uniformes `E/P` no
empate residual.

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
a rederivação usa o representante uniforme literalmente. O ciclo serve
somente para calcular e conferir payoffs interinos; não é kernel terminal
admissível, seleção alternativa de `C_M` nem membro adicional da assinatura.

## 4. Colapso exato do ballot

Para uma seleção anônima `chi(mu)` de `C_M`, ponha, agora em unidades de
`A_M`,

```text
r_chi(mu)       = beta*c_chi(mu),
D_chi_theta(mu) = beta*h_chi_theta(mu),
A_chi(mu)       = 1-k*r_chi(mu).
```

**Lema de factibilidade.** Para todo posterior e todo rótulo admissível,

```text
0<r_chi(mu)<=beta/m,
k*r_chi(mu)<1.
```

Com efeito, `c_E=1/m`; em `P`, `c_P=(1-beta*o_1)/m` está estritamente entre
zero e `1/m`; e o numerador de `c_S` é uma combinação convexa de
`1-beta*o_0` e `beta`, ambos em `(0,1)`. A mistura residual `E/P` preserva os
limites por convexidade. Finalmente, `k<m` para `N>=3` e `beta<1`, logo
`k*r_chi(mu)<=k*beta/m<1`.

Pela Cláusula M, todos os vetores pivotais depois de uma proposta com
posterior `mu` usam o mesmo membro literal. Logo, para todo fraco `j`,

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
D_0(0)=beta^2*o_0=.081,
D_1(0)=beta^2*o_1=.729,
O_0=max{A(0),D_0(0)}=.5905,
O_1=max{A(0),D_1(0)}=.729;
tipo 0: .5905 > .09 e .5905=O_0;
tipo 1: .81 > .5905 e .81>O_1.
```

Logo a construção é um PBE separating sob M/S/B. Entretanto, propostas
off-path que aumentam um pagamento de `Q_1` em `epsilon_n>0` e reduzem
`z_H` na mesma quantia são aceitas sob `nu_off=0` e convergem para o sinal
on-path rejeitado do tipo alto. O conjunto global de aceitação não é fechado.

### 5.2 Lema de existência corrigido

**Lema AM-MSB-E.** Para toda primitiva admissível e todo prior existe pelo
menos um PBE de `A_M` sob M/S/B quando `rho` permanece coordenada livre do
assessment. Isso não afirma existência para cada `rho` fixado. Nos endpoints,
`nu_off=nu` é obrigatório e `rho` é irrelevante. No interior, uma testemunha
pode ser escolhida por região:

| região | `rho` | `nu_off` | outcome |
|---|---:|---:|---|
| `o_1<=T` | `1` | `nu` | pooling com acordo |
| `o_0<=T<=o_1` | `infinity` | `1` | baixo acorda, alto atrasa |
| `T<=o_0` | qualquer | `b_rho(nu)` | ambos atrasam |

onde

```text
Z_E=1-k*beta/m,
T=Z_E/beta=1/beta-k/m,
T>1/m.
```

Para priors interiores, as fronteiras paramétricas podem usar as testemunhas
adjacentes e as misturas escritas na Seção 10. Endpoints são tratados
diretamente pela Seção 6.4, nunca pela frase “testemunha adjacente”. A prova é
construtiva e aparece na Seção 7. Ela compara propostas canônicas que atingem
o melhor acordo e a rejeição dentro dos posteriores efetivamente usados. Não
depende de semicontinuidade superior nem de fechamento global.

## 6. Classificação completa dos PBEs puros

Antes da classificação, a forma fechada do desvio off-path precisa de um
argumento que é especial a suportes finitos.

**Lema do supremo off-path em suporte finito.** Se
`S=supp(lambda)` é finito, então

```text
sup_{y in Y\S} u_theta^off(y)
  =max{A_chi(nu_off),D_chi_theta(nu_off)}.
```

De fato, `Y` não tem pontos isolados e retirar um conjunto finito deixa
`Y\S` denso. Nenhum acordo pode dar a `H` mais que
`A_chi(nu_off)`. Se a proposta canônica que atinge esse valor estiver em
`S`, reduza sua parcela em `epsilon>0` sem alterar os `k` pagamentos de
corte e escolha `epsilon_n downarrow 0` evitando os finitíssimos pontos de
`S`; obtém-se uma sequência em `Y\S` com payoff convergindo a
`A_chi(nu_off)`. Toda proposta rejeitada dá
`D_chi_theta(nu_off)`, e há um contínuo de propostas rejeitadas, de modo que
alguma está fora de `S`. Isso prova as duas desigualdades do lema sem afirmar
que o supremo do melhor acordo seja sempre atingido no complemento.

Fixe agora `0<nu<1`, `rho in [0,infinity]` e uma seleção markoviana anônima
`chi`. Ponha

```text
p_rho=b_rho(nu),
A_p=A_chi(p),
D_theta_p=D_chi_theta(p),
O_theta(rho)=max{A_p_rho,D_theta_p_rho}.
```

O lema anterior justifica exatamente essa última igualdade para todos os
perfis puros, cujos suportes têm no máximo dois pontos. Como
`D_1_p>=D_0_p`, vale `O_1(rho)>=O_0(rho)`.

Todo perfil puro é pooling ou separating. As condições abaixo são necessárias
e suficientes; em cada linha escolhem-se propostas factíveis distintas quando
necessário.

### 6.1 Pooling

1. **Acordo pooling.** Existe se e somente se

   ```text
   O_1(rho)<=A_nu.
   ```

   Todo `z in [O_1(rho),A_nu]` pode ser implementado por um pacote aceito. Os dois
   tipos recebem `z`.

2. **Atraso pooling.** Existe se e somente se

   ```text
   D_0_nu>=O_0(rho)  e  D_1_nu>=O_1(rho).
   ```

   Uma proposta claramente rejeitada implementa os payoffs
   `(D_0_nu,D_1_nu)`.

### 6.2 Separating

1. **Acordo dos dois tipos.** Imitar a proposta do outro tipo implica
   `z_0=z_1=z`. Existe se e somente se

   ```text
   O_1(rho)<=min{A_0,A_1}.
   ```

   Todo `z in [O_1(rho),min{A_0,A_1}]` é admissível. As mensagens podem ser
   distintas mesmo com a mesma parcela: isso é separação de mensagens em um
   ponto de indiferença, não separação de payoffs. Sob o quociente anônimo da
   Seção 9, trocar apenas os nomes dos fracos não cria nova assinatura; para
   permanecer distinta, a mensagem precisa mudar alguma coordenada não
   eliminada pelo quociente, como a distribuição revelada de pacotes.

2. **Acordo do tipo baixo e atraso do alto.** Existe se e somente se

   ```text
   D_1_1>=O_1(rho)
   e
   max{D_0_1,O_0(rho)}<=min{A_0,D_1_1}.
   ```

   Todo

   ```text
   z in [max{D_0_1,O_0(rho)}, min{A_0,D_1_1}]
   ```

   implementa `(V_H^0,V_H^1)=(z,D_1_1)`.

3. **Atraso do baixo e acordo do alto.** É impossível: as restrições de
   imitação exigiriam `D_0_0>=z>=D_1_0`, mas `D_1_0>D_0_0`.

4. **Atraso dos dois tipos.** Existe se e somente se

   ```text
   D_0_0>=D_0_1,
   D_1_1>=D_1_0,
   D_0_0>=O_0(rho),
   D_1_1>=O_1(rho).
   ```

   Os payoffs são `(D_0_0,D_1_1)`. Cada tipo pode imitar a continuação do
   outro; as duas primeiras desigualdades acima são precisamente essas
   restrições de imitação. Assim, “preferir sua própria continuação” quer
   dizer preferi-la também à continuação induzida pela mensagem do outro, não
   que a imitação seja impossível.

**Prova de completude.** Em perfil puro interior, propostas iguais geram o
posterior `nu` e o mesmo resultado de ballot. Propostas distintas geram
posteriores `0` e `1`. Cada tipo pode imitar literalmente o sinal do outro;
todo outro pacote é não disciplinado e enfrenta `nu_off`. As quatro combinações
de acordo/atraso acima esgotam os resultados. As desigualdades listadas são
exatamente factibilidade, imitação bilateral e ausência de desvio off-path.

### 6.3 Sensibilidade exata a `rho`

Nesta subseção `chi` permanece fixo; variar `rho` não autoriza trocar a
seleção de continuação.

Escreva

```text
F_theta(p)=max{A_chi(p),D_chi_theta(p)}.
```

Para cada classe, o conjunto exato de valores admissíveis de `rho` é obtido
substituindo `O_theta(rho)=F_theta(b_rho(nu))` nas desigualdades das Seções
6.1–6.2. Mais explicitamente, para caps `(L_0,L_1)`, defina

```text
P(L_0,L_1)={p in [0,1]:F_0(p)<=L_0 e F_1(p)<=L_1},
R(L_0,L_1)={rho:b_rho(nu) in P(L_0,L_1)}.
```

Os caps são:

| classe | condições independentes de `rho` | `(L_0,L_1)` |
|---|---|---|
| pooling–acordo | nenhuma | `(infinity,A_nu)` |
| pooling–atraso | nenhuma | `(D_0_nu,D_1_nu)` |
| separating acordo–acordo | nenhuma | `(infinity,min{A_0,A_1})` |
| baixo acorda, alto atrasa | `D_0_1<=U`, `U=min{A_0,D_1_1}` | `(U,D_1_1)` |
| ambos atrasam | `D_0_0>=D_0_1` e `D_1_1>=D_1_0` | `(D_0_0,D_1_1)` |

A classe baixo-atraso/alto-acordo é vazia para todo `rho`. Essa tabela é uma
caracterização por substituição, não uma afirmação de monotonicidade. Embora
`b_rho(nu)` cresça em `rho`, `C_M` troca de ramo e `A_chi` pode saltar; por
isso `R(L_0,L_1)` pode ser união desconexa de intervalos e singletons.

O cálculo dentro de cada ramo usa

```text
A_S(p)=1-(k*beta/m)*[(1-p)*(1-beta*o_0)+p*beta],
D_S_theta=beta^2*o_theta,

A_E=Z_E,                 D_E_theta=beta*o_theta,
A_P=1-(k*beta/m)*(1-beta*o_1),
D_P_theta=beta^2*o_1.
```

Logo o teste em `S` é uma desigualdade afim em `p` — cujo sentido depende do
sinal da inclinação — e os blocos `E/P` são constantes. No singleton `EP`,
`A` e `D_theta` são as combinações convexas com o mesmo peso de `chi`.

Os cutoffs de `C_M` na coordenada nova são, quando pertencem ao respectivo
domínio,

```text
rho_SP=(1-nu)/nu * beta*(o_1-o_0)
       /(1-beta*o_1-beta*k/m),
rho_SE=(1-nu)/nu * beta*(1/m-o_0)
       /(1-beta*q/m),
rho_EP=(1-nu)/nu * (beta*o_1-o_0)/((1-beta)*o_1).
```

As igualdades `SP/SE` pertencem ao ramo `S`. `rho_EP` só é operativo no caso
residual `o_1=1/m` e quando o cutoff posterior correspondente fica acima de
`nu_SE`; o peso `EP` permanece o escolhido por `chi` e não pode ser
reotimizado ao variar `rho`.

O benchmark `rho=1` reproduz `nu_off=nu`: crença passiva apenas nos sinais
não disciplinados, não ausência de atualização no suporte. Os limites
`rho=0` e `rho=infinity` dão, respectivamente, `nu_off=0` e `nu_off=1`.
Uma classe é robusta a todo `rho` exatamente quando suas condições acima
valem após substituir cada cap off-path por
`sup_{p in [0,1]}F_theta(p)`. Esse supremo é calculável nos extremos dos
trechos afins, nos dois lados dos saltos e no eventual singleton `EP`.

Na região transparente `o_0>1/m`, `E` é único para todo posterior e todas as
condições ficam independentes de `rho`: pooling com acordo e separating
acordo–acordo valem para todo `rho` quando `o_1<=T`;
baixo-acorda/alto-atrasa vale quando `o_0<=T<=o_1`; e pooling com atraso e
separating atraso–atraso valem quando `o_0>=T`. As igualdades permitem
coexistência das classes adjacentes.

Para mostrar por que não se deve relatar um único cutoff de equilíbrio, tome

```text
N=3, beta=.9, o_0=.04, o_1=.73, nu=.05.
```

Então `p_SE=207/257` e `rho_SE=78.66`. A classe baixo-acorda/alto-atrasa
existe exatamente em

```text
{rho=0} uniao (78.66,infinity].
```

Ela falha em `rho=1` e em `rho=rho_SE`, pois `S` vigora inclusivamente no
cutoff; as outras quatro classes puras também são vazias nessa instância.
Esse é um resultado sobre classes puras: falha de todas elas em algum `rho`
fixo não prova inexistência de PBE misto.

### 6.4 Endpoints do prior

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
assinaturas endpoint completas são formalizadas na Seção 9.2.

## 7. Prova construtiva da existência por região

### 7.1 `o_1<=T`: pooling com acordo

Escolha `rho=1`, portanto `nu_off=nu`, e o mesmo representante uniforme
`B(nu)` on e off path.
Ambos os tipos fazem a proposta canônica que deixa `A_nu` para `H`.

- no ramo `E`, `D_1=beta*o_1<=beta*T=Z_E=A_E`;
- no ramo `S`, `D_1=beta^2*o_1<Z_E<A_S`;
- no ramo `P`, `D_1=beta^2*o_1<Z_E<A_P`.

No singleton residual `EP`, `A` e `D_1` são misturados com o mesmo peso entre
os valores `E/P`; a desigualdade é preservada por convexidade. Logo
`O_1(1)<=A_nu`, satisfazendo a condição pooling da Seção 6.1.

### 7.2 `o_0<=T<=o_1`: baixo acorda e alto atrasa

Escolha `rho=infinity`, portanto `nu_off=1`. Como `T>1/m`, em `mu=1` o ramo
é `E`:

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
atraso satisfaz a Seção 6 para qualquer `rho` e seu
`nu_off=b_rho(nu)`.

## 8. Classificação dos PBEs mistos pelas assinaturas on-path

A Cláusula B elimina a liberdade ponto a ponto fora do caminho, mas não elimina
a variação de Bayes dentro do suporte. A classificação completa precisa reter
essa variação.

### 8.1 Objeto reduzido

Fixe `0<nu<1`, `rho in [0,infinity]`,
`nu_off=b_rho(nu)` e uma seleção

```text
chi:[0,1] -> X_M
```

Borel, markoviana e pertencente ponto a ponto ao ramo permitido por
`C_M`. Denote por `P(Y)` o espaço de probabilidades Borel sobre `Y`. Um
objeto reduzido admissível é a tupla bem tipada

```text
R=(rho,nu_off,sigma_0,sigma_1,lambda,pi,chi,a,u_0,u_1),
```

na qual

```text
sigma_0,sigma_1,lambda in P(Y),
pi:Y->[0,1] Borel,
a:Y->{0,1} Borel,
u_0,u_1:Y->R Borel,
lambda=(1-nu)*sigma_0+nu*sigma_1,
S=supp(lambda).
```

As coordenadas obedecem:

1. `pi(y)` é o limite local de Bayes da Seção 2.1 em **todo**
   `y in S`; se algum limite falhar, a tupla é inadmissível;
2. `pi(y)=nu_off` em `Y\S`;
3. `chi(pi(y))` seleciona o representante literal uniforme, ou a mistura
   comum uniforme `E/P`, e determina seu kernel Borel
   `K^D_{theta,chi(pi(y))}` para cada tipo;
4. a regra de ballot é

   ```text
   a(y)=1{sum_j 1{x_j(y)>=r_chi(pi(y))}>=k};
   ```

5. os payoffs de desvio são

   ```text
   u_theta(y)=a(y)*z_H(y)
              +(1-a(y))*D_chi_theta(pi(y)).
   ```

A Borelidade não é apenas postulada. A Seção 2.1 prova que `pi` é Borel;
`chi` e os mapas de payoff/kernel de `X_M` são Borel pela Seção 3.2.
Consequentemente `r_chi(pi(y))` é Borel. Cada indicador
`1{x_j(y)>=r_chi(pi(y))}` é Borel, sua soma é finita, e portanto `a` é
Borel. Como `z_H` é contínua e `D_chi_theta o pi` é Borel, `u_0,u_1`
também são Borel.

Nos pontos `lambda`-quase todos, Bayes também implica

```text
d sigma_1/d lambda = pi/nu,
d sigma_0/d lambda = (1-pi)/(1-nu),
integral pi d lambda = nu,
```

mas essas igualdades quase em toda parte não substituem o limite local exigido
em cada ponto disciplinado.

### 8.2 Teorema de membership necessário e suficiente

**Teorema AM-MSB-T4 (membership misto).**

Fixados `(nu,rho,chi)` como na Seção 8.1, seja `R` uma tupla admissível
daquele espaço. Para cada tipo, defina o valor derivado

```text
V_theta=integral_Y u_theta(y) sigma_theta(dy).
```

Para suporte público `S`, defina o valor exato dos desvios não disciplinados

```text
O_theta(S)=sup_{y in Y\S} u_theta^off(y),
```

onde `u_theta^off` usa `nu_off` e `chi(nu_off)`; o supremo do conjunto vazio é
`-infinito`. Em suportes finitos, o complemento é denso e
`O_theta(S)=max{A_off,D_theta_off}`. Em suportes gerais, não se substitui esse
supremo por um pacote canônico que por acaso pertença ao próprio suporte.

A tupla `R` gera um PBE sob M/S/B se e somente se:

```text
u_theta(y)<=V_theta para todo y in S,
u_theta(y)=V_theta para sigma_theta-quase todo y,
V_theta>=O_theta(S),
```

para `theta=0,1`, além das condições 1–5 da Seção 8.1.

**Necessidade.** Cada tipo pode escolher qualquer sinal alcançado pelo outro e
qualquer pacote não disciplinado. A última classe tem supremo exatamente
`O_theta(S)` por definição.

**Suficiência.** Prescreva os votos de corte da Seção 4 e a continuação
`chi(pi(y))`. Bayes e B valem por construção. Em sinais alcançados, nenhuma
ação supera `V_theta`; fora do suporte, nenhuma ação supera `O_theta(S)`; e cada
tipo mistura apenas entre melhores respostas. Todas as coordenadas usam a
mesma tupla, sem recombinação marginal. No empate `E/P`, payoff e kernel são
a mesma combinação convexa registrada por `chi`, o que preserva as
desigualdades e a mensurabilidade.

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

## 9. Lei conjunta downstream e cardinalidade da correspondência

Seja `Omega_D` o espaço Borel dos outcomes literais de `C_M` e forme o espaço
terminal disjunto

```text
Omega_T=({A} x Y) uniao_disjunta ({D} x Omega_D).
```

Para `x in X_M`, denote por `K^D_{theta,x}` o kernel Borel do representante
uniforme literal sobre `Omega_D` e por `tilde K_{theta,x}` seu pushforward
para o componente `{D} x Omega_D`. Condicionalmente ao sinal `y`, o kernel
terminal de `R` é

```text
L_theta^R(d omega_T | y)
 =a(y)*delta_(A,y)(d omega_T)
  +(1-a(y))*tilde K_{theta,chi(pi(y))}(d omega_T).
```

No espaço conjunto

```text
Z=Y x [0,1] x {0,1} x X_M x Omega_T,
```

defina a lei conjunta por tipo

```text
Gamma_theta^R(C)
 =integral_Y integral_Omega_T
    1_C(y,pi(y),a(y),chi(pi(y)),omega_T)
    L_theta^R(d omega_T | y) sigma_theta(dy).
```

Assim,

```text
Gamma_theta^R
 =Law_theta^R(y,pi(y),a(y),chi(pi(y)),omega_T).
```

Essa lei mantém, no mesmo objeto, sinal, posterior, timing, seleção literal e
outcome terminal. A assinatura atômica de `A_M` é

```text
Sig_M(R)=(rho,nu_off,[(Gamma_0^R,Gamma_1^R)]_anon),
```

onde o quociente anônimo é definido abaixo. No prior interior,
`nu_off=b_rho(nu)`; as duas coordenadas são mantidas juntas apenas para tornar
a interface e sua auditoria explícitas.

Escreva `zeta=(y,p,a,x,omega_T) in Z`. Se `h_theta(omega_T)` e
`w_j(omega_T)` denotam os payoffs de `A_M` realizados no outcome terminal,
todos os resumos antes listados são marginais ou integrais **da mesma dupla**
`(Gamma_0^R,Gamma_1^R)`:

```text
V_H^theta = integral_Z h_theta(omega_T) Gamma_theta^R(dzeta)
            =integral_Y u_theta(y) sigma_theta(dy),
p_A^theta = Gamma_theta^R{a=1},
p_D^theta = 1-p_A^theta,

Q_theta(B)
 =integral_Y [
    a(y)*delta_(A,y)(B)
    +(1-a(y))*tilde K_{theta,chi(pi(y))}(B)
   ] sigma_theta(dy),

W_j^theta
 =integral_Z w_j(omega_T) Gamma_theta^R(dzeta)
 =integral_Y [
    a(y)*x_j(y)
    +(1-a(y))*bar_w_j_theta(pi(y),chi(pi(y)))
   ] sigma_theta(dy),
W_j=(1-nu)*W_j^0+nu*W_j^1,

G_pi
 =proj_(Y,[0,1])#
   [(1-nu)*Gamma_0^R+nu*Gamma_1^R].
```

Aqui

```text
bar_w_j_theta(p,x)
 =integral_Omega_D w_j(D,omega_D) K^D_{theta,x}(d omega_D)
```

é o payoff fraco realizado condicional ao tipo. Em geral ele **não** é o
preço interino `r_chi(p)`: no ramo `S`, por exemplo, os dois valores
condicionais transportados são `beta*(1-beta*o_0)/m` e `beta^2/m`.
Bayes implica somente a identidade agregada

```text
W_j
 =integral_Y [
    a(y)*x_j(y)+(1-a(y))*r_chi(pi(y))
   ] lambda(dy).
```

Em particular, `Q_theta` é a marginal em `Omega_T`, e `G_pi` é a marginal
conjunta de sinal e posterior. Nenhum consumidor pode escolher `V` de um
objeto, `Q` de outro e `G_pi` de um terceiro.

### 9.1 Quociente por anonimato e fechamento por permutações

Seja `G=S_m` o grupo das permutações dos fracos. Para `g in G`,

```text
g.(z_H,x_1,...,x_m)
 =(z_H,x_{g^{-1}(1)},...,x_{g^{-1}(m)}),
```

e aplique a mesma permutação às identidades fracas nos votos e em
`omega_T`. A ação é trivial em `rho`, `nu_off`, posterior, indicador de
acordo e rótulo anônimo `chi`. Sobre um assessment,

```text
sigma_theta^g=g#sigma_theta,
lambda^g=g#lambda,
pi^g(y)=pi(g^{-1}.y),
a^g(y)=a(g^{-1}.y),
u_theta^g(y)=u_theta(g^{-1}.y).
```

**Lema de fechamento por permutação.** Se `R` gera PBE sob M/S/B, então
`g.R` também gera PBE para todo `g in G`.

**Prova.** A permutação é uma isometria Borel de `Y`, portanto transporta
suportes e bolas relativas e faz o limite local de Bayes comutar com a ação.
Os kernels uniformes são equivariantes, o preço de voto é comum e a
permutação estabelece uma bijeção payoff-preservante entre todas as propostas,
votos e desvios. Logo admissibilidade, Bayes e melhor resposta são
preservados.

Para colapsar também pesos diferentes sobre rotulações da mesma órbita, defina
o operador de Reynolds sobre a **dupla inteira**:

```text
Anon(Gamma_0,Gamma_1)
 =|G|^{-1} sum_{g in G} (g#Gamma_0,g#Gamma_1).
```

Em cada parcela da soma, o **mesmo** `g` atua nos dois tipos e
simultaneamente em proposta, votos e outcome terminal. Duas duplas pertencem
à mesma classe, denotada `[(Gamma_0,Gamma_1)]_anon`, se seus valores sob
`Anon` coincidem. A média de grupo torna uniforme qualquer redistribuição de
probabilidade dentro de uma única órbita, mas preserva os pesos entre órbitas
economicamente distintas; seu suporte registra a órbita relevante.

`Anon` é o representante simétrico da **assinatura**, não uma alegação de que
a média das estratégias seja PBE. O lema de fechamento não afirma convexidade
do conjunto de PBEs. A coordenada pública `(y,pi(y))` é permutada como um
bloco e `pi(y)` permanece na lei; por isso pooling na mesma mensagem e
separação por coalizões distintas com a mesma parcela `z_0=z_1` não se
confundem. No segundo caso, os posteriores `0` e `1` continuam distintos
depois da anonimização.

Downstream, `Q_theta` e os payoffs fracos são as projeções e integrais
anônimas de `Anon(Gamma_0,Gamma_1)`; vetores nomeados ficam apenas no
representante interno. `V_H^theta`, `p_A^theta` e a lei de posteriores são
invariantes à ação e coincidem antes e depois da anonimização.

### 9.2 Objetos e assinaturas nos endpoints

Para `nu in {0,1}`, defina o objeto reduzido endpoint

```text
R_boundary=(*,nu,sigma_0,sigma_1,lambda,pi_nu,
            chi_nu,a_nu,u_0,u_1),
```

onde `sigma_0,sigma_1 in P(Y)`, `pi_nu(y)=nu_off=nu` em todo `Y`,
`lambda=sigma_0` se `nu=0` e `lambda=sigma_1` se `nu=1`,
`chi_nu` é o representante canônico admissível de `C_M(nu)`, e
`a_nu,u_0,u_1` seguem as fórmulas da Seção 8 com posterior constante. O
símbolo `*` substitui `rho`: como todo `rho` induz a mesma crença no endpoint,
esses valores não são economicamente identificados e pertencem a uma única
fibra. Ponha

```text
M_theta=max{A_nu,D_theta_nu}.
```

O objeto gera um PBE endpoint se e somente se

```text
sigma_theta({y:u_theta(y)=M_theta})=1, theta=0,1.
```

Essa condição inclui qualquer mistura Borel sobre propostas aprovadas
canônicas, propostas rejeitadas ou ambas na igualdade, inclusive a estratégia
contrafactual do tipo de probabilidade zero. Defina
`Gamma_theta^boundary` pela mesma fórmula conjunta da Seção 9, agora com
posterior constante, e use

```text
Sig_boundary(R_boundary)
 =(*,nu,[(Gamma_0^boundary,Gamma_1^boundary)]_anon).
```

As marginais satisfazem `V_H^theta=M_theta` e
`G_pi=(y,nu)#lambda`, e `p_A^theta,p_D^theta,Q_theta` são calculados
separadamente sob cada `sigma_theta`.
O payoff interino fraco `W_j` usa `lambda`, pois só o tipo de probabilidade
positiva entra na expectativa anterior ao sinal. Assim, sinais distintos que
produzem a mesma rejeição continuam distintos em `G_pi` e em `Q_theta` quando
apropriado.

Nenhuma identidade de Radon–Nikodym com divisão por `nu` ou `1-nu` é usada
nos endpoints.

### 9.3 Correspondência conjunta e fibra institucional

Para prior interior, defina

```text
E_M(nu,rho)
 ={R:R satisfaz a Seção 8 e nu_off=b_rho(nu)},

S_M(nu,rho)
 ={Sig_M(R):R in E_M(nu,rho)}.
```

A correspondência interior completa é a união disjunta das fibras
`S_M(nu,rho)` em `rho in [0,infinity]`. Nos endpoints, ela é a imagem dos
`R_boundary` na fibra única `*`. Cada elemento é construído como a imagem
vinculada de alguma tupla reduzida completa; não se exige unicidade da
pré-imagem, mas não há envelope cartesiano nem recombinação de marginais.

Se `A_U` vier a ser rederivada com a mesma coordenada, a comparação `AC`
admissível será o produto fibrado

```text
S_M(nu) x_rho S_U(nu)
 ={(s_M,s_U):rho(s_M)=rho(s_U)},
```

e nunca o produto cartesiano das duas correspondências marginais. Nos
endpoints, ambas usam a fibra `*`. Esta linha apenas fixa a interface futura:
`A_U` e `AC` não são derivados nem consumidos aqui.

### 9.4 Teorema cardinal de incontabilidade

**Teorema AM-MSB-T6 (versão cardinal).**

Mesmo com `(nu,nu_off)` — equivalentemente `(nu,rho)` no interior — fixado,
a correspondência exata pode conter incontavelmente muitas assinaturas; por
isso nenhuma lista finita as representa em geral.

Tome `N=5`, `beta=.9`, `o_0=.7`, `o_1=.8`,
`nu=.5` e `rho=1`, logo `nu_off=.5`. O ramo `E` é único em todo posterior,
`A=.55`, enquanto rejeição dá `.63` ao tipo baixo e `.72` ao alto. Na linha
de propostas rejeitadas `s(t)=(t,0,0,0,0)`, `t in [0,1]`, para cada
`epsilon in [-1/2,1/2]` defina

```text
pi_epsilon(t)=1/2+epsilon*(2*t-1),
sigma_1_epsilon(dt)=[1+2*epsilon*(2*t-1)]dt,
sigma_0_epsilon(dt)=[1-2*epsilon*(2*t-1)]dt.
```

As densidades são não negativas, integram um e geram
`lambda(dt)=dt`. O limite local de Bayes vale em todo ponto da linha e é
exatamente `pi_epsilon(t)`. M usa o mesmo representante uniforme `E`, B fixa
`.5` fora do suporte, e todo sinal usado é uma melhor resposta rejeitada.
Para `epsilon` distintos, as leis `Gamma_theta` diferem na coordenada
`(y,pi(y))` em conjunto de medida positiva. Permutações dos fracos deixam a
linha `s(t)` fixa, de modo que o quociente anônimo não identifica essas leis.

Há, portanto, um contínuo de assinaturas exatas na mesma fibra. A primeira
fonte antes cogitada — variar apenas pesos sobre identidades de coalizão — é
apagada pelo quociente aprovado e não sustenta este teorema. O resultado é
somente cardinal: a própria subfamília acima é parametrizada pelo escalar
`epsilon`, logo nada aqui prova inexistência de parametrização finita ou de
algum resumo finito para outra finalidade.

## 10. Revalidação das testemunhas exploratórias

Nada nesta tabela é herdado. Cada linha foi rechecada com `kappa_M` markoviana,
`nu_off` único e representante uniforme literal.

Para a família semipooling do tipo alto, deixe o baixo enviar sempre o sinal
aceito `s_A`; o alto envia `s_A` com probabilidade `lambda in (0,1)` e um
sinal rejeitado `s_D` com a probabilidade restante. Então

```text
mu_A=nu*lambda/[(1-nu)+nu*lambda] in (0,nu),
mu(s_D)=1 por Bayes,
rho=infinity e nu_off=1 nos pontos não disciplinados.
```

O acordo comum dá `z=beta*o_1`. O alto fica indiferente entre esse acordo e
a rejeição `E` em `mu=1`; o baixo prefere o acordo. Todos os desvios ficam
cobertos se e somente se, dentro dessa construção,

```text
beta*o_1>=Z_E
e
A_chi(mu_A)>=beta*o_1.
```

As misturas de fronteira, sempre para `0<nu<1`, são explícitas:

1. se `o_1=T`, para todo `ell in [0,1]` tome

   ```text
   sigma_0=delta_sA,
   sigma_1=ell*delta_sA+(1-ell)*delta_sD,
   rho=infinity, nu_off=1.
   ```

   Quando os sinais têm massa positiva,
   `pi(s_A)=nu*ell/[(1-nu)+nu*ell]` e `pi(s_D)=1`. O acordo deixa
   `Z_E=beta*o_1` para `H`; o alto é indiferente à rejeição `E` e o baixo
   prefere o acordo. Em `ell=0` ambos os sinais estão on path e Bayes dá
   `pi(s_A)=0`, `pi(s_D)=1`. Em `ell=1` somente `s_D` sai do suporte e usa
   a regra off-path, sem divisão em evento de probabilidade zero.

2. se `o_0=T<o_1`, para todo `ell in [0,1]` tome

   ```text
   sigma_0=ell*delta_sA+(1-ell)*delta_sD,
   sigma_1=delta_sD,
   rho arbitrário, nu_off=b_rho(nu).
   ```

   Quando positivos, `pi(s_A)=0` e
   `pi(s_D)=nu/[nu+(1-nu)*(1-ell)]`. Como `E` é único em todo posterior, o
   baixo recebe `beta*o_0=Z_E` no acordo e na rejeição; o alto recebe
   `beta*o_1>Z_E` e rejeita. Qualquer `rho` preserva esses incentivos.

Aqui `s_A` é a proposta canônica aceita por `Z_E` e `s_D` uma proposta
claramente rejeitada distinta. Misturas em priors degenerados não são obtidas
por “continuidade” dessas fórmulas; obedecem diretamente à Seção 9.2.

| fonte histórica | estatuto sob M/S/B | escopo revalidado |
|---|---|---|
| §3.1 pooling com acordo | `PROVED CANDIDATE` | válido para `o_1<=T` com `rho=1`; mais geralmente sse `O_1(rho)<=A_nu` |
| §3.2 separating, ambos acordam, `o_1<=1/m` | `PROVED CANDIDATE` | válido com `rho=0`, `S` em `0`, `P` em `1` e parcela comum `A_0` |
| §3.2 separating, ambos acordam, `1/m<o_1<=T` | `PROVED CANDIDATE` | válido com `rho=infinity`, parcela comum `Z_E` |
| §3.3 baixo acorda, alto atrasa | `PROVED CANDIDATE` | válido no interior para `o_0<=T<=o_1`, `rho=infinity` |
| §3.4 pooling/separating com atraso | `PROVED CANDIDATE` | válido para `T<=o_0`, qualquer `rho` |
| §3.5 endpoints | `PROVED CANDIDATE` | válido com `nu_off=nu`, escolhas tipo a tipo entre `A_nu` e `D_theta_nu` |
| §4.1 semipooling alto | `PARTIAL / RE-SCOPED` | válido com `rho=infinity` somente se `beta*o_1>=Z_E` e `A_chi(mu_A)>=beta*o_1`; o antigo `Zbar_B` assimétrico não é admissível sob S |
| exemplo §4.1 `(.1,.7,nu=.5,lambda=.25)` | `REJECTED UNDER S` | capacidade uniforme em `mu_A=.2` é `.5914<.63`; a testemunha usava votos assimetricamente baratos |
| §4.2, `o_1=T` | `PROVED CANDIDATE` | semipooling explícito acima, com `rho=infinity` |
| §4.2, `o_0=T<o_1` | `PROVED CANDIDATE` | mistura explícita acima; `E` é único e qualquer `rho` serve |
| família atomless da §6.1 | `PROVED CANDIDATE` | reescrita na Seção 9.4; mostra cardinalidade incontável na mesma fibra |

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
payoff interino. Para tornar a comparação histórica exata, no antigo ramo
`E` defina

```text
c=m-k,
A_min(r)=k*max{0,r-c}+c*max{0,r-(c-1)},
M_E=[k*E+w*A_min(k)]/m,
Zbar_E=1-beta*M_E.
```

O antigo intervalo `[Z_E,Zbar_E]` era a imagem das parcelas de acordo geradas
por membros de incidência `E_F` na subfamília cujo seletor mantinha a mesma
família `F` globalmente constante entre propostas e vetores pivotais. O objeto
e sua prova estão em
`model_redesign/agenda_extension_A_M_explicit_majority_results.md`,
Seções 5.1–5.2, SHA-256
`1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`.
Sob S, a continuação selecionada é o representante uniforme literal:
`c_E=1/m` e a capacidade corrente de acordo é o singleton `Z_E`. Portanto a
largura histórica está definida, mas não é uma família corrente de `A_M`.

## 12. Lema histórico negativo importado

**AMX-NEG-001 é importado, não revalidado de forma autocontida neste pacote.**
O enunciado, `kappa_old`, a crença antiga e a função completa `g_theta` estão
no artefato histórico
`model_redesign/agenda_extension_A_M_explicit_majority_results.md`,
Seção 6.1, SHA-256
`1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`.
Sob aquele contrato, o seletor podia alternar entre membros de `C_M` conforme
a proposta e o vetor de votos. Na instância

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
não-existência sob M/S/B. O script corrente confere somente a aritmética
numérica exibida; não revalida `kappa_old`, as crenças ou a prova histórica.

## 13. Estatuto de AMX-014–016

- **AMX-014:** reaberto e classificado para estratégias puras pelas condições
  necessárias e suficientes da Seção 6, indexadas por
  `(nu,rho,chi)`, com `nu_off=b_rho(nu)`.
- **AMX-015:** reaberto e classificado pela tupla de probabilidades Borel
  `R=(rho,nu_off,sigma_0,sigma_1,lambda,pi,chi,a,u_0,u_1)` e pelo teste
  necessário e suficiente da Seção 8, incluindo Bayes pointwise e mapas
  Borel bem tipados.
- **AMX-016:** a correspondência conjunta exata é a imagem vinculada das leis
  `Gamma_theta` da Seção 9, quocientada anonimamente, em união disjunta por
  fibras `rho` no interior e pela fibra `*` nos endpoints. `AC` futuro só
  poderá usar o produto fibrado na mesma coordenada. Nenhum envelope
  cartesiano ou recombinação de marginais é permitido.

O Teorema 9.4 acrescenta apenas que uma fibra pode ser incontável e, por isso,
não admite enumeração por lista finita. Não afirma impossibilidade de
parametrização finita.

### 13.1 Entregável futuro não bloqueante

`IC/D1-BENCHMARK` permanece `PENDING / NONBLOCKING` e fora do baseline. Para
cada proposta inesperada, ele deverá definir a correspondência de tipos que
podem ganhar sob alguma resposta sequencialmente racional dos votantes e algum
membro permitido de `C_M`, e só então aplicar Critério Intuitivo/D1. Resta a
decisão protocolar sobre incluir `chi` entre as respostas dos receptores. Nada
desse benchmark é imposto silenciosamente à Cláusula B neste passe.

Esses três claims são candidatos do implementador e exigem revisão matemática
independente sobre os mesmos bytes antes de qualquer consumo downstream.

## 14. Invalidação

Qualquer mudança em M, S, B, na coordenada `rho`, no limite local de Bayes,
nos desempates, no kernel uniforme, no quociente anônimo, na interface
congelada `C_M` ou na lei conjunta `Gamma_theta` invalida toda esta
rederivação. Alterar apenas `A_U` não muda estes claims, mas `AC` não pode
consumi-los antes das revisões independentes e deverá manter a mesma fibra
`rho`.
