# N3 v3 — R1 sob maioria

**Nó:** N3

**Schema:** equilibrium_correspondence_v1

**Dependência única:** N1-EQ-01

**Hash consumido:** sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5

**Data nativa dos payoffs:** R1

**Status:** pending_independent_review

**Artefato candidato:** model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v3.json

Esta versão preserva integralmente o candidato v2 como proveniência. A
rederivação foi conferida novamente contra as primitivas do contrato e a
interface congelada de N1; nenhum resultado histórico foi usado como premissa.
As fórmulas, as onze células, os payoffs e a multiplicidade reproduzem a
álgebra v2. O reparo v3 tem duas fronteiras:

1. fechar, em cada assessment, o posterior de toda história
   proposta-vetor-de-votos de probabilidade zero, inclusive quando nu>0;
2. tornar a certificação executável por comparação estrutural integral,
   oracle algébrico independente e mutações negativas dirigidas.

Não há mudança de jogo, schema, topologia, primitiva, payoff, seleção ou
conceito de solução.

## 1. Continuação congelada e desconto

N1 exporta, para todo posterior de entrada em R2:

    payoff do proponente reconhecido em R2 = 1
    payoff pré-reconhecimento de cada weak state em R2 = 1/m
    payoff de H do tipo theta em R2 = o_theta
    resultado em R2 = aprovação sem H com probabilidade 1

Em unidades de R1, c=beta/m e a_theta=beta*o_theta. Essas abreviações não são
exportadas.

<a id="claim-n3v3-c01"></a>
### Claim N3V3-C01 — importação de N1 e desconto único

Depois de qualquer falha em R1, cada weak state avalia a continuação em
beta/m, e H do tipo theta a avalia em beta*o_theta. O fator beta entra
exatamente uma vez. Como N1 contém o mesmo registro para todo posterior em
[0,1], esses valores são invariantes ao posterior publicado pela história.

## 2. Respostas no ballot depois de qualquer proposta

Fixe um weak proposer i e uma proposta factível
s=(y,(x_j)_{j em W sem i},r_i). Para um weak nonproposer j:

| Situação | j=sim | j=não |
|---|---:|---:|
| j é pivotal | x_j | beta/m |
| a quota passa sem j | x_j | x_j |
| a quota falha mesmo com j | beta/m | beta/m |

As duas histórias da última linha podem carregar posteriores distintos, mas
ambas consomem o mesmo payoff de N1.

<a id="claim-n3v3-c02"></a>
### Claim N3V3-C02 — cutoff dos weak nonproposers

Se x_j>beta/m, sim domina fracamente não; se x_j<beta/m, a relação se
inverte. Em igualdade, as ações são payoff-idênticas em todas as linhas e
T^Y seleciona sim. Portanto j vota sim se e somente se x_j>=beta/m.

Defina K_i(s)={j em W sem i: x_j>=beta/m} e k_i(s)=|K_i(s)|.

<a id="claim-n3v3-c03"></a>
### Claim N3V3-C03 — melhor resposta completa de H

1. Se k_i>=q-1, a proposta passa sem H. Sim paga y; não paga
   y+o_theta. Ambos os tipos votam não estritamente.
2. Se k_i=q-2, H é pivotal. Sim implementa y; não conduz a N1 e vale
   beta*o_theta. O tipo theta vota sim se e somente se
   y>=beta*o_theta, com T^Y na igualdade.
3. Se k_i<=q-3, a quota falha com qualquer voto de H. As duas ações levam ao
   mesmo registro de N1 e T^Y seleciona sim.

Esse mapa cobre toda proposta factível e preserva o payoff y+o_theta do ramo
não pivotal.

## 3. Desvios do proponente e candidatos

<a id="claim-n3v3-c04"></a>
### Claim N3V3-C04 — payoff depois de toda proposta

O weak proposer não observa theta. Sob o prior verdadeiro nu, seu payoff é:

    v_i(s;nu) = r_i,                            se k_i>=q-1;
                beta/m,                        se k_i=q-2 e y<beta*o_0;
                (1-nu)*r_i+nu*beta/m,          se k_i=q-2 e
                                                 beta*o_0<=y<beta*o_1;
                r_i,                           se k_i=q-2 e y>=beta*o_1;
                beta/m,                        se k_i<=q-3.

A crença de ballot atribuída a uma proposta fora do caminho não altera esse
mapa: os cutoffs foram obtidos de payoffs de N1 invariantes ao posterior. O
proponente desviante usa o prior verdadeiro.

<a id="claim-n3v3-c05"></a>
### Claim N3V3-C05 — redução exaustiva

Dentro de cada classe de outcome, toda parcela que não altera a resposta pode
ser transferida ao residual do proponente. Os valores relevantes são:

    E = 1-beta*(q-1)/m
        exclusão: y=0; q-1 weak voters recebem beta/m.

    L = 1-beta*o_0-beta*(q-2)/m
    S(nu) = (1-nu)*L+nu*beta/m
        low-type-only: y=beta*o_0; q-2 weak voters recebem beta/m.

    P = 1-beta*o_1-beta*(q-2)/m
        pooling: y=beta*o_1; q-2 weak voters recebem beta/m.

    R = beta/m
        falha para todo tipo no suporte do prior.

Os endpoints de prior zero permanecem no espaço de desvios e ambos os tipos
mantêm estratégias especificadas.

## 4. P0, P1, atraso e factibilidade

<a id="claim-n3v3-c06"></a>
### Claim N3V3-C06 — P0: uso integral da pie

Exclusão e pooling passam com probabilidade um. Low-type-only, quando
selecionada, tem nu<1 e passa com probabilidade positiva. Se uma proposta
selecionada tivesse folga, elevar apenas r_i produziria uma nova proposta
pública, à qual o assessment poderia atribuir outra crença. Isso não altera a
conclusão: o mapa de respostas e outcomes induzido por N1 é
invariante à crença de ballot, e os pagamentos que governam os cutoffs não
mudam. Logo o desvio eleva estritamente o payoff do proponente sempre que a
proposta passa. Toda proposta selecionada usa a pie inteira.

Esta prova não afirma que duas propostas públicas distintas preservam
literalmente a mesma crença.

<a id="claim-n3v3-c07"></a>
### Claim N3V3-C07 — P1 e P1a: hedge estrito

Considere uma proposta com y>0 e pelo menos q-1 weak nonproposers pagos acima
do cutoff. Ela passa sem H. A proposta s'=(0,x,r_i+y) é factível, preserva os
pagamentos que governam todos os votos e aumenta o payoff do proponente em y.
Pela invariância das respostas a crenças sob N1, nenhuma crença off-path
resgata a proposta original. Assim, toda exclusão selecionada tem y=0.

<a id="claim-n3v3-c08"></a>
### Claim N3V3-C08 — falha deliberada e delay informativo

Como N>=3, q=floor(N/2)+1<=m. Portanto:

    E-R = 1-beta*q/m > 0

para 0<beta<1. Falha deliberada nunca é selecionada. Nas células
low-type-only, contudo, o tipo alto rejeita e segue para N1 com probabilidade
nu; esse é delay informativo, não falha terminal.

<a id="claim-n3v3-c09"></a>
### Claim N3V3-C09 — factibilidade

Exclusão custa beta*(q-1)/m<1. Low-type-only só é selecionada quando
o_0<=1/m, e pooling somente quando o_1<=1/m; em ambos:

    beta*[o_theta+(q-2)/m] <= beta*(q-1)/m < 1.

As propostas são estritamente factíveis, deixam residual positivo e satisfazem
0<=y<=y_bar.

## 5. Fronteiras e onze células

As comparações são:

    P-E = beta*(1/m-o_1)

    S(nu)-E = (1-nu)*beta*(1/m-o_0)
              -nu*(1-beta*q/m).

As fronteiras fechadas são:

    nu_SP = beta*(o_1-o_0) /
            [1-beta*o_0-beta*(q-1)/m]

    nu_SE = beta*(1/m-o_0) /
            [beta*(1/m-o_0)+1-beta*q/m].

<a id="claim-n3v3-c10"></a>
### Claim N3V3-C10 — partição exclusiva e exaustiva

| Outside options | Prior | Branch |
|---|---|---|
| o_1<1/m | 0<=nu<=nu_SP | low-type-only |
| o_1<1/m | nu_SP<nu<=1 | pooling |
| o_0<1/m<o_1 | 0<=nu<=nu_SE | low-type-only |
| o_0<1/m<o_1 | nu_SE<nu<=1 | exclusão |
| 1/m<o_0<o_1 | todo nu | exclusão |
| o_0=1/m<o_1 | nu=0 | low-type-only |
| o_0=1/m<o_1 | 0<nu<=1 | exclusão |
| o_0<o_1=1/m | 0<=nu<=nu_SE | low-type-only |
| o_0<o_1=1/m | nu>nu_SE e h_E<h_P | exclusão |
| o_0<o_1=1/m | nu>nu_SE e h_P<h_E | pooling |
| o_0<o_1=1/m | nu>nu_SE e h_E=h_P | ambas e todas as misturas |

Nas três últimas linhas, h_E=(1-nu)*o_0+nu/m e h_P=beta/m.
As igualdades S=P ou S=E pertencem a low-type-only pelo tie-break que
minimiza o payoff esperado de H.

<a id="claim-n3v3-c11"></a>
### Claim N3V3-C11 — knife-edge o_1=1/m

Quando o_1=1/m, E=P. Até nu_SE, low-type-only vence, inclusive na igualdade.
Acima dela, o tie-break compara h_E e h_P. Em h_E=h_P, nenhum dos dois
branches pode ser eliminado: preservam-se todas as atribuições puras por
identidade e todas as misturas admissíveis entre exclusão e pooling.

## 6. Identidades, payoffs e outcomes

<a id="claim-n3v3-c12"></a>
### Claim N3V3-C12 — multiplicidade completa

Em low-type-only e pooling, omega_{i,K} pesa coalizões com |K|=q-2; em
exclusão, com |K|=q-1. Para cada i, os pesos são não negativos e somam um,
podendo variar entre identidades. Vetor degenerado é proposta pura; vetor não
degenerado é mistura do proponente.

Na célula residual mista, e_{i,K} pesa exclusão e p_{i,T} pesa pooling, com
sum_K e_{i,K}+sum_T p_{i,T}=1 para cada identidade i. Não há simetria imposta.

<a id="claim-n3v3-c15"></a>
### Claim N3V3-C15 — payoff weak por identidade

Para cada weak state l, o valor pré-reconhecimento soma a chance 1/m de l
propor e a chance 1/m de cada outro i propor. Em low-type-only:

    C_l = (1/m)*S(nu)
          +(1/m)*sum_{i != l}{
              (1-nu)*(beta/m)*Pr_{omega_i}(l em K)
              +nu*beta/m
            }.

Pooling e exclusão usam as probabilidades correspondentes de l pertencer à
coalizão paga. A célula mista soma as probabilidades induzidas por e e p.
Cada fórmula é exportada diretamente em primitivas e permite valores
assimétricos entre identidades.

<a id="claim-n3v3-c16"></a>
### Claim N3V3-C16 — payoff de H e outcomes

| Branch | U_H(0) | U_H(1) | pass H / pass sem H / failure / delay |
|---|---:|---:|---|
| low-type-only | beta*o_0 | beta*o_1 | 1-nu / 0 / 0 / nu |
| pooling | beta*o_1 | beta*o_1 | 1 / 0 / 0 / 0 |
| exclusão | o_0 | o_1 | 0 / 1 / 0 / 0 |

Na célula mista:

    U_H(0) = (1/m)*sum_i[
               o_0*sum_K e_{i,K}+(beta/m)*sum_T p_{i,T}
             ]

    U_H(1) = (1/m)*sum_i[
               (1/m)*sum_K e_{i,K}+(beta/m)*sum_T p_{i,T}
             ]

    pass with H    = (1/m)*sum_i sum_T p_{i,T}
    pass without H = (1/m)*sum_i sum_K e_{i,K}
    failure        = 0
    delay          = 0.

Como o_1=1/m nessa célula, todos os símbolos são localmente fechados.
Failure é falha terminal; delay é falha em R1 seguida por N1.

## 7. Crenças completas

<a id="claim-n3v3-c13"></a>
### Claim N3V3-C13 — Bayes e histórias de probabilidade zero

O proponente não observa theta; toda proposta individual com peso positivo
mantém posterior de ballot nu por Bayes. Toda proposta individual com peso
zero recebe kappa_i(s) em [0,1].

Em todo assessment e para todo nu in [0,1], cada par formado por proposta s e
vetor completo publicado de votos v que tenha probabilidade zero recebe
explicitamente eta_i(s,v) em [0,1]. Isso inclui vetores zero-probabilidade
quando nu>0, desvios de votantes depois de uma proposta de suporte e ambos os
endpoints do prior. A regra não restringe a crença; apenas completa localmente
o assessment exigido por PBE.

<a id="claim-n3v3-c14"></a>
### Claim N3V3-C14 — P7 e a falha positiva

Weak votes dependem dos pagamentos, nunca do tipo de H. Em uma história de
probabilidade positiva, somente o voto de H pode atualizar o posterior além da
proposta. No branch low-type-only, quando nu>0, a única falha positiva ocorre
porque o tipo alto vota não, enquanto o tipo baixo vota sim; Bayes fixa o
posterior em um. Em todos os outros vetores zero-probabilidade, aplica-se
eta_i(s,v) em [0,1].

N1 torna esses posteriores off-path payoff-irrelevantes, mas não autoriza
omiti-los da interface.

## 8. Existência e invalidação

<a id="claim-n3v3-c17"></a>
### Claim N3V3-C17 — existência e endpoints

Exclusão é sempre estritamente factível e supera falha deliberada. Existe ao
menos um equilíbrio em todo o domínio. As onze células cobrem nu=0, nu=1,
o_0=1/m, o_1=1/m, todas as regiões estritas e todas as igualdades de payoff e
tie-break. Não há célula none para N3 no domínio 0<beta<1.

Qualquer mudança no contrato, no schema, no hash de N1, no conceito de solução,
na implementação de y, no tie-break ou no desconto invalida este candidato.
O v3 não altera lifecycle, não congela N3 e não autoriza N6.

## 9. Certificação v3

O builder v3 gera um objeto canônico completo. O verificador reconstrói esse
objeto em caminhos temporários, compara recursivamente cada campo, célula,
registro e claim e exige igualdade byte a byte em duas builds independentes.
O hash da derivação fixa também seus bytes completos.

Separadamente, scripts/oracle_essential_input_n3_v3.R parte somente das
primitivas e do conteúdo congelado de N1. Ele reconstrói quota, cutoffs, todos
os vetores relevantes de votos simultâneos, ofertas, payoffs E/S/P/R,
fronteiras, regiões, endpoints, tie-break, payoffs weak por identidade,
payoffs de H, outcomes e a célula mista. O oracle não importa o objeto esperado
do builder.

O script negativo chama validadores e oracle sobre cópias mutadas em memória,
com o pin de hash fora do caminho. Ele rejeita C_l=999; proposta low-type-only
com y=0, weak voters não pagos e r_i=1; posterior zero na falha positiva;
ausência de eta_i(s,v) quando nu>0; ledger com desconto duplo; branch falso; e
redação que volte a alegar preservação literal da crença em C06.

## 10. Proveniência e invariância

A rederivação reproduziu a álgebra, as fronteiras, os endpoints, a
multiplicidade e os outcomes do v2. A divergência é apenas a correção unívoca
das crenças exportadas e o fortalecimento da evidência executável. Nenhum
resultado v2 foi apagado, reescrito ou promovido sem revalidação.
