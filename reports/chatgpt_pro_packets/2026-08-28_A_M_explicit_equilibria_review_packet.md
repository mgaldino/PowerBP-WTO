---
title: "Equilíbrios explícitos sob maioria"
subtitle: "Pacote autocontido para auditoria matemática externa do estágio de maioria"
date: "28 de agosto de 2026"
lang: pt-BR
geometry: margin=2.3cm
fontsize: 10pt
toc: true
numbersections: true
colorlinks: true
linkcolor: blue
urlcolor: blue
header-includes:
  - \usepackage{amsmath,amssymb}
  - \usepackage{booktabs,longtable,array}
  - \sloppy
---

# Mandato ao ChatGPT Pro

Você atuará como auditor matemático independente de uma derivação de teoria
dos jogos. Este não é um parecer genérico de journal, uma avaliação da
contribuição do artigo ou uma oportunidade para redesenhar o modelo. Sua única
tarefa é verificar os resultados novos sobre o estágio em que o hegemon propõe
sob maioria, denotado por \(A_M\).

**Estado deste pacote:** `EXPLORATORY CANDIDATE - LOCAL REPAIRS IMPLEMENTED -
AMX-014--016 BLOCKED BY CURRENT PRIMITIVES - REVIEW PENDING`. O parecer externo original está preservado em
`quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md`,
SHA-256 `d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c`.
O PDF efetivamente auditado está preservado com SHA-256
`a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394`.
O PASS interno anterior permanece como registro histórico e foi superado
somente nos pontos delimitados pela adjudicação round 2; este pacote não
concede aprovação ou congelamento à maioria.

## Barreira axiomática obrigatória

Os resultados `AX-N1` e `AX-CM-1` a `AX-CM-4`, reunidos na Seção 3, foram
demonstrados e revisados anteriormente. **Assuma-os como verdadeiros, completos
e internamente consistentes.**

1. Não rederive nem audite os equilíbrios de \(N1\) ou a correspondência
   \(C_M\).
2. Não questione as fórmulas, a partição de ramos, os payoffs ou as condições
   de existência declaradas nesses axiomas.
3. Não penalize a ausência das provas antigas.
4. Se um axioma parecer surpreendente, registre apenas `AXIOMA ACEITO`.
5. Sua auditoria substantiva começa no Lema `AM-L1`.

Você deve verificar somente se a nova derivação:

- invoca cada ramo de \(C_M\) onde ele realmente existe;
- transporta conjuntamente todas as coordenadas do mesmo membro literal;
- aplica \(\beta\) exatamente uma vez na passagem de \(C_M\) para \(A_M\);
- não recombina payoffs, coalizões, crenças ou outcomes de membros diferentes;
- usa corretamente os axiomas nos endpoints, fronteiras e empates.

Isto é uma auditoria da **aplicação** dos axiomas, não da validade das provas
anteriores. Não examine \(A_U\), \(AC\), \(AR\), o manuscrito, o benchmark
público ou qualquer outro estágio.

## Regras metodológicas

- Tente refutar cada resultado antes de aceitá-lo.
- Não trate verificação numérica como prova.
- Não introduza tremble, refinamento, média sobre vetores pivotais, simetria,
  exaustão do bolo ou seleção canônica de continuação.
- Uma construção pode escolher um membro literal específico de \(C_M\) como
  coordenada de um assessment. Isso não autoriza apresentá-lo como a única
  continuação possível.
- Se uma correção exigir hipótese econômica nova ou escolha do autor,
  classifique o resultado como `UNRESOLVED` e identifique a decisão necessária.
- Não transforme lacunas expressamente declaradas em defeitos de teoremas de
  existência mais estreitos.

# Definição fixa do estágio \(A_M\)

Há \(N\ge3\) Estados. Um é o hegemon \(H\); os outros \(m=N-1\) são fracos. A
quota de maioria é

\[
q=\lfloor N/2\rfloor+1,
\qquad
k=q-1=\lfloor N/2\rfloor.
\]

O tipo de \(H\) é \(\theta\in\{0,1\}\), com prior
\(\Pr(\theta=1)=\nu\). As primitivas satisfazem

\[
0<\beta<1,\qquad
0<o_0<o_1<1,\qquad
o_1\le\bar y\le1.
\]

\(H\) observa \(\theta\) e é obrigado a propor. Não existe ação primitiva de
passar. Sua proposta é

\[
s=(z_H,x_1,\ldots,x_m)\in Y,
\]

onde

\[
z_H\ge0,\qquad x_j\ge0,\qquad
z_H+\sum_{j=1}^m x_j\le1.
\]

\(\bar y\) indexa a mesma economia de continuação e não limita \(z_H\). A
proposta de \(H\) já conta como seu voto favorável. Portanto, ela passa se ao
menos \(k=q-1\) fracos votarem `sim`. \(H\) não vota novamente.

Se a proposta passa, \(H\) recebe \(z_H\) e o fraco \(j\) recebe \(x_j\). Se
falha, o jogo consome uma continuação literal completa de \(C_M\) e aplica
\(\beta\) exatamente uma vez ao valor nativo dessa continuação.

## Crenças

Se \(\sigma_0,\sigma_1\) são as medidas Borelianas de proposta, defina a medida
pública

\[
Q_\nu=(1-\nu)\sigma_0+\nu\sigma_1.
\]

A crença em \(s\) obedece à regra local de Bayes por vizinhanças relativas:

\[
\mu(s)=
\lim_{\delta\downarrow0}
\frac{\nu\sigma_1(B_\delta^Y(s))}
{(1-\nu)\sigma_0(B_\delta^Y(s))+\nu\sigma_1(B_\delta^Y(s))},
\]

quando toda vizinhança tem massa pública positiva. Se alguma vizinhança tem
massa zero, a crença é livre dentro do suporte do prior. Em \(\nu=0\), toda
crença é zero; em \(\nu=1\), toda crença é um. Votos fracos não movem a crença.

## Regra pivotal ponto a ponto

Para o fraco \(j\), seja

\[
\mathcal P_j
=\left\{a_{-j}\in\{0,1\}^{m-1}:
\sum_{\ell\ne j}a_\ell=q-2=k-1\right\}.
\]

Quando \(j\) é pivotal no vetor \(a_{-j}\), sua reserva é

\[
r_{j,a}(s)
=\beta C^I_{M,j}
\left(\kappa_M(s,(0,a_{-j}),\mu(s))\right),
\]

onde \(\kappa_M\) devolve um único membro literal completo de \(C_M\). A mesma
ação pura de \(j\) deve ser ótima em todos os vetores que ele não observa:

\[
v_j(s)=\text{sim}
\Longrightarrow
x_j\ge\max_{a_{-j}\in\mathcal P_j}r_{j,a}(s),
\]

\[
v_j(s)=\text{não}
\Longrightarrow
x_j<\min_{a_{-j}\in\mathcal P_j}r_{j,a}(s).
\]

Na igualdade, o voto é `sim`. A faixa entre o mínimo e o máximo é
incompatível com voto puro. Não há média, kernel ou tremble sobre vetores
pivotais.

## Assessment completo

Um assessment de \(A_M\) contém conjuntamente

\[
b=(\sigma_0,\sigma_1,\mu,v,\kappa_M).
\]

\(\sigma_\theta\) é uma medida Borel em \(Y\); \(\mu\) obedece a Bayes local e
ao suporte do prior; \(v\) é uma estratégia pura de votos em todo \(Y\); e
\(\kappa_M\) é uma função Borel, pública, comum aos tipos e total em toda
história rejeitada. Cada \(\kappa_M(h)\) é um membro literal completo de
\(C_M(\mu(s))\). As construções abaixo usam partições finitas de \(Y\) e
seletores constantes em cada célula, portanto são Borel.

# Resultados importados: assuma como verdadeiros

## AX-N1: folha terminal sob maioria

Assuma como provado:

1. em R2, um fraco reconhecido propõe sua própria parcela igual a um e todas as
   demais parcelas iguais a zero;
2. todos os fracos não proponentes votam `sim` e \(H\) vota `não`;
3. a proposta passa sem \(H\);
4. antes do reconhecimento, cada fraco recebe \(1/m\);
5. \(H(\theta)\) recebe \(o_\theta\);
6. esses valores estão em unidades correntes de R2 e não contêm \(\beta\);
7. estratégias, outcome e payoffs são únicos; crenças fora do caminho são
   irrelevantes.

## AX-CM-1: notação e ramos

No jogo anterior,

\[
w=\frac{\beta}{m},\qquad t_\theta=\beta o_\theta,
\]

\[
E=1-kw,\qquad
L=1-(k-1)w-t_0,\qquad
P=1-(k-1)w-t_1,
\]

\[
S(\mu)=(1-\mu)L+\mu w.
\]

Os únicos ramos de equilíbrio de \(C_M\) são \(E\) (exclusão de \(H\)), \(S\)
(o tipo baixo aceita e o alto atrasa) e \(P\) (ambos aceitam). Rejeição
deliberada não é ótima em \(C_M\).

## AX-CM-2: partição completa

1. Se \(o_1<1/m\), \(S\) é selecionado para

   \[
   \mu\le\nu_{SP}
   =\frac{\beta(o_1-o_0)}
   {1-\beta o_0-\beta k/m},
   \]

   inclusive, e \(P\) acima.

2. Se \(o_0<1/m<o_1\), \(S\) é selecionado para

   \[
   \mu\le\nu_{SE}
   =\frac{\beta(1/m-o_0)}
   {\beta(1/m-o_0)+1-\beta q/m},
   \]

   inclusive, e \(E\) acima.

3. Se \(1/m<o_0<o_1\), somente \(E\) existe.

4. Se \(o_0=1/m<o_1\), \(S\) existe somente em \(\mu=0\) e \(E\) para
   \(\mu>0\).

5. Se \(o_0<o_1=1/m\), \(S\) existe até \(\nu_{SE}\), inclusive. Acima,
   \(E\) e \(P\) empatam para o proponente; o desempate compara

   \[
   h_E=(1-\mu)o_0+\mu/m,\qquad h_P=\beta/m.
   \]

   O menor é selecionado; os dois e suas misturas permanecem se também houver
   igualdade nesse desempate.

Consequentemente,

\[
B(0)=
\begin{cases}
S,&o_0\le1/m,\\
E,&o_0>1/m,
\end{cases}
\qquad
B(1)=
\begin{cases}
P,&o_1\le1/m,\\
E,&o_1>1/m.
\end{cases}
\]

## AX-CM-3: correspondência literal

Para cada identidade proponente \(i\), qualquer distribuição \(F_i\) apoiada
nas coalizões ótimas do ramo selecionado pertence à correspondência. Não se
impõe \(F_i=F_j\). Estratégias, crenças, propostas, coalizões, payoffs e
outcomes devem vir da mesma família atômica \(F=(F_i)_i\). É proibido combinar
coordenadas de membros distintos. No empate residual \(E/P\), o mesmo peso
conjunto governa os dois tipos.

## AX-CM-4: coordenadas de payoff

Para uma matriz de incidência \(\mathsf A=(a_{ij})\), com \(a_{ii}=0\), linhas
somando \(r\) e graus de coluna \(d_j=\sum_i a_{ij}\), os payoffs interinos
fracos em unidades nativas de \(C_M\) são

\[
C_j^E=\frac{E+wd_j}{m},\qquad r=k,
\]

\[
C_j^P=\frac{P+wd_j}{m},\qquad r=k-1,
\]

\[
C_j^S(\mu)
=(1-\mu)\frac{L+wd_j}{m}+\mu w,\qquad r=k-1.
\]

Os payoffs nativos de \(H\) são

\[
E:(o_0,o_1),\qquad
S:(\beta o_0,\beta o_1),\qquad
P:(\beta o_1,\beta o_1).
\]

Quando uma proposta de \(A_M\) falha, esses valores recebem exatamente mais
um fator \(\beta\). No empate residual \(E/P\), se \(\bar\lambda\) é o peso
conjunto em \(P\),

\[
C_H^0=(1-\bar\lambda)o_0+\bar\lambda w,\qquad
C_H^1=(1-\bar\lambda)o_1+\bar\lambda w.
\]

# Ferramentas novas

## Lema AM-L1: membro cíclico

Rotule os \(m\) fracos em um ciclo. Quando \(i\) é reconhecido em \(C_M\),
faça-o comprar os próximos \(r\) nomes, com \(r=k\) no ramo \(E\) e \(r=k-1\)
nos ramos \(S/P\). Cada linha e cada coluna da matriz de incidência soma \(r\).
Por `AX-CM-3`, essa regra define um membro literal completo, não uma hipótese
nova de simetria.

Substituindo \(d_j=r\) em `AX-CM-4`,

\[
c_E=\frac1m,
\]

\[
c_S(\mu)
=\frac{(1-\mu)(1-\beta o_0)+\mu\beta}{m},
\]

\[
c_P=\frac{1-\beta o_1}{m}.
\]

Na passagem para \(A_M\), defina

\[
r_B(\mu)=\beta c_B(\mu),\qquad
D_B(\theta)=\beta h_B(\theta),\qquad
Z_B(\mu)=1-kr_B(\mu).
\]

Assim,

\[
Z_E=1-\frac{k\beta}{m},
\]

\[
Z_S(\mu)
=1-\frac{k\beta}{m}
\left[(1-\mu)(1-\beta o_0)+\mu\beta\right],
\]

\[
Z_P=1-\frac{k\beta}{m}(1-\beta o_1).
\]

Como \(c_S(\mu)<1/m\) e \(c_P<1/m\),

\[
Z_S(\mu)>Z_E,\qquad Z_P>Z_E.
\]

## Lema AM-L2 reparado: redução da votação a preços e ponto fixo

Fixe, após cada proposta \(s\), o mesmo membro literal em todos os vetores
rejeitados. Então todas as reservas pivotais de \(j\) coincidem em
\(\rho_j(s)=\beta C^I_{M,j}\), e

\[
v_j(s)=
\begin{cases}
\text{sim},&x_j\ge\rho_j(s),\\
\text{não},&x_j<\rho_j(s).
\end{cases}
\]

Ordene \(\rho_{(1)}\le\cdots\le\rho_{(m)}\) e defina

\[
K(s)=\sum_{\ell=1}^k\rho_{(\ell)},\qquad Z(s)=1-K(s).
\]

Para esse \(s\) fixo, toda proposta aprovada dá a \(H\) no máximo \(Z(s)\). Isso é um teto
pontual: se o seletor muda quando os pagamentos mudam, não se pode pagar os
preços calculados em \(s\) e continuar usando o mesmo \(Z(s)\). Uma afirmação de
atingibilidade exige autoconsistência entre a proposta, os votantes e o membro
que a própria proposta induz.

Fixe uma família/incidência \(F\), um conjunto \(Q\) de \(k\) fracos e uma proposta \(s^F\) que
satisfaça

\[
\kappa_M(s^F,(0,a_{-j}),\mu(s^F))=F(\mu(s^F))
\quad\text{para todo }a_{-j}\in\mathcal P_j,
\]

\[
x_j=\beta C^I_{M,j}(F(\mu(s^F)))\ (j\in Q),\qquad
x_j=0\ (j\in Q^c),\qquad
z_H=1-\sum_{j\in Q}x_j.
\]

Então \(Q\) vota sim e o teto é atingido. Para um seletor arbitrário dependente da
proposta, essa condição pode falhar; AM-L2 não afirma atingibilidade geral.
Toda proposta rejeitada dá \(D_\theta(s)=\beta h_\theta(s)\), e um limite ponto a
ponto para desvios puros elimina também desvios mistos por linearidade.

Finalmente, \(K(s)<1\) é explícito. Todo payoff nativo fraco é no máximo
\[
\bar C=\frac{1+\beta(m-k)/m}{m},\qquad
A_g=1-k\beta\bar C.
\]
Logo \(K(s)\le k\beta\bar C=1-A_g<1\), pois
\[
A_g\ge\left(1-\frac{k}{m}\right)^2\ge\frac19>0
\]
quando \(\beta<1\) e \(k/m\le2/3\).

## Lema AM-L3: fronteira \(T\)

Defina

\[
T=\frac{Z_E}{\beta}
=\frac1\beta-\frac{k}{m}.
\]

Como \(q=k+1\le m\),

\[
T-\frac1m=\frac1\beta-\frac qm>0.
\]

\(T\) pode exceder um; nenhum argumento supõe \(T\in(0,1)\).

# Equilíbrios puros explícitos

## AMX-002a: pooling com acordo

Suponha \(o_1\le T\). No posterior de entrada \(\nu\), escolha um ramo puro
real \(B(\nu)\) permitido por `AX-CM-2` e seu membro cíclico. Em empate que
preserva mais de um membro, fixe explicitamente um deles como coordenada deste
assessment. Fixe, em todo \(Y\),

\[
\mu(s)=\nu
\]

e use esse mesmo membro após toda rejeição. Na proposta pooling, Bayes produz
\(\nu\); todo outro ponto tem uma vizinhança de massa pública zero. Nos
endpoints, a crença constante respeita o suporte.

Escolha \(Q\subseteq\{1,\ldots,m\}\), \(|Q|=k\). Ambos os tipos propõem

\[
x_j=
\begin{cases}
\beta c_{B(\nu)},&j\in Q,\\
0,&j\notin Q,
\end{cases}
\qquad
z_H=Z_{B(\nu)}.
\]

Exatamente os membros de \(Q\) votam `sim` e a proposta passa. Todo desvio
aprovado rende no máximo \(Z_B\). Todo desvio rejeitado rende no máximo:

\[
\begin{array}{ll}
B=E:&D_E(1)=\beta o_1\le\beta T=Z_E,\\
B=S:&D_S(1)=\beta^2o_1<\beta o_1\le Z_E<Z_S,\\
B=P:&D_P(1)=\beta^2o_1<\beta o_1\le Z_E<Z_P.
\end{array}
\]

Logo,

\[
(V_H^0,V_H^1)=(Z_{B(\nu)},Z_{B(\nu)}).
\]

Na subfamília cíclica constante:

| Ramo | pooling com acordo | pooling com rejeição |
|---|---|---|
| \(E\) | sse \(o_1\le T\) | sse \(o_0\ge T\) |
| \(S\) | sse \(\beta^2o_1\le Z_S(\nu)\) | impossível |
| \(P\) | sempre | impossível |

Os “se e somente se” são apenas internos a essa subfamília.

## AMX-002b: separating com dois acordos

Assuma \(0<\nu<1\). Em qualquer separating puro no qual os dois sinais passam,
imitação bilateral exige \(z_0=z_1\).

### Caso A: \(o_1\le1/m\)

Em \(s_0\), use posterior zero e \(S\). Em \(s_1\), posterior um e \(P\). Fora
do caminho, use posterior zero e \(S\). Defina

\[
c_0=\frac{1-\beta o_0}{m},\quad
c_1=\frac{1-\beta o_1}{m},\quad
Z_0=1-k\beta c_0,\quad
Z_1=1-k\beta c_1.
\]

Como \(o_1>o_0\), \(c_0>c_1\) e \(Z_0<Z_1\). Para um conjunto fixo \(Q\) de
tamanho \(k\), os tipos propõem

\[
s_0:\quad z_H=Z_0,\quad x_j=\beta c_0\,\mathbf1\{j\in Q\},
\]

\[
s_1:\quad z_H=Z_0,\quad x_j=\beta c_1\,\mathbf1\{j\in Q\}.
\]

\(s_1\) deixa folga \(Z_1-Z_0>0\). Ambos passam e pagam \(Z_0\). Imitar o
outro sinal rende o mesmo. Todo outro desvio enfrenta \(S\) em posterior zero:
aprovação rende no máximo \(Z_0\), e rejeição rende no máximo
\(\beta^2o_1\). Além disso,

\[
Z_0>Z_E>\frac{\beta^2}{m}\ge\beta^2o_1,
\]

pois

\[
m-k\beta-\beta^2
=(m-k-1)+k(1-\beta)+(1-\beta^2)>0.
\]

### Caso B: \(1/m<o_1\le T\)

Em \(s_0\), use posterior zero e o ramo real \(B(0)\). Em \(s_1\) e fora do
caminho, use posterior um e \(E\). Como \(c_{B(0)}\le1/m\), a capacidade do
sinal baixo é ao menos \(Z_E\). Faça ambos passarem com

\[
z_0=z_1=Z_E.
\]

Se os dois endpoints usam \(E\), use conjuntos comprados distintos
\(Q_0\ne Q_1\) para tornar os sinais diferentes. Todo desvio fora do caminho
que passa rende no máximo \(Z_E\), e toda rejeição rende no máximo
\(\beta o_1\le Z_E\). Imitar o outro sinal rende \(Z_E\).

O separating é diagonal entre tipos, mas não é necessariamente equivalente ao
pooling em nível de payoff.

## AMX-003: baixo acorda, alto atrasa

Suponha

\[
0<\nu<1,\qquad o_0\le T\le o_1.
\]

Como \(T>1/m\), \(C_M(1)\) usa \(E\). Fixe

\[
\mu(s_0)=0,\qquad \mu(s)=1\quad\forall s\ne s_0.
\]

Em \(s_0\), use o membro cíclico do ramo real \(B(0)\); fora de \(s_0\), use o
membro cíclico \(E\). O tipo baixo paga \(\beta c_{B(0)}\) a \(k\) fracos e
retém \(Z_E\). Se \(B(0)=S\), há folga.

O tipo alto propõe

\[
s_1=(1,0,\ldots,0).
\]

Todos os fracos rejeitam \(s_1\). Os payoffs são

\[
(V_H^0,V_H^1)=(Z_E,\beta o_1).
\]

Para o baixo, qualquer acordo fora de \(s_0\) rende no máximo \(Z_E\), e
rejeição rende \(\beta o_0\le Z_E\). Para o alto, acordo rende no máximo
\(Z_E\le\beta o_1\), e rejeição reproduz \(\beta o_1\). O atraso é produzido
por uma proposta admissível rejeitada, não por uma ação de passar.

## AMX-004: pooling e separating com atraso

Suponha \(T\le o_0\). Como \(T>1/m\), \(E\) é o único ramo em todo posterior.

No pooling, válido para qualquer prior, ambos propõem
\(s_D=(1,0,\ldots,0)\). Use crença \(\nu\) e o
membro cíclico \(E\) em todo \(Y\). A proposta falha e paga

\[
(V_H^0,V_H^1)=(\beta o_0,\beta o_1).
\]

Para \(0<\nu<1\), há também um separating. Escolha

\[
s_0^D=(0,0,\ldots,0),\qquad s_1^D=(1,0,\ldots,0).
\]

Bayes fixa posteriores zero e um nos átomos. Fora do caminho, fixe
\(\mu(s)=\nu\). Use o membro \(E\) em toda rejeição. Ambos os sinais falham.
Imitar o outro sinal não muda o payoff. Todo acordo rende no máximo
\(Z_E=\beta T\le\beta o_0\), e toda rejeição rende \(\beta o_\theta\).

## AMX-005: endpoints do prior

Se \(\nu\in\{0,1\}\), fixe \(\mu(s)=\nu\) em todo \(Y\), use o ramo real
\(B(\nu)\) e seu membro cíclico após toda rejeição. Defina

\[
Z=Z_{B(\nu)},\qquad D_\theta=D_{B(\nu)}(\theta).
\]

A proposta aprovada canônica paga \(\beta c_{B(\nu)}\) a um conjunto \(Q\) de
\(k\) fracos e retém \(Z\). A proposta rejeitada canônica é
\((1,0,\ldots,0)\). Para cada tipo contingente, inclusive o de probabilidade
zero, prescreva a primeira se \(Z>D_\theta\), a segunda se
\(D_\theta>Z\), e qualquer mistura entre elas na igualdade. Toda aprovação
rende no máximo \(Z\), toda rejeição rende \(D_\theta\), e o suporte do prior
é respeitado.

## AMX-001: existência global

As regiões

\[
o_1\le T,\qquad
o_0\le T\le o_1,\qquad
T\le o_0
\]

cobrem todo o domínio, com sobreposição nas igualdades. `AMX-002`,
`AMX-003` e `AMX-004` fornecem uma testemunha de PBE puro em cada região, com
a continuação literal explicitada em cada construção; `AMX-005` cobre os
endpoints. Portanto, para o jogo (permitindo escolher uma continuação que faça
parte do assessment),

\[
\mathcal E_M(d)\ne\varnothing
\quad\text{para toda primitiva admissível},
\qquad
D_M^0=\varnothing.
\]

Isto não afirma existência uniforme para cada seletor Borel admissível: o
certificado diagonal da seção própria mostra que alguns seletores não têm
melhor resposta. Aqui

\[
D_M^0:=\{d:\mathcal E_M(d)=\varnothing\}
\]

é o conjunto de primitivas admissíveis sem PBE em \(A_M\).

Este é um teorema de existência. As três regiões fornecem equilíbrios
suficientes; não constituem uma partição exaustiva de todos os PBEs.

# Semipooling e mistura

Há três objetos probabilísticos distintos, que não devem ser confundidos:

1. mistura de \(H\) entre propostas em \(A_M\);
2. loteria interna de um único membro literal de \(C_M\) sobre coalizões;
3. mistura residual conjunta entre os ramos \(E/P\), quando AX-CM-2 a
   permite.

Somente o primeiro objeto constitui mistura da estratégia de proposta de
\(H\).

## AMX-006: o tipo alto mistura

Suponha

\[
0<\nu<1,\qquad o_1>\frac1m,\qquad 0<\lambda<1.
\]

O tipo baixo sempre envia \(s_A\). O tipo alto envia \(s_A\) com probabilidade
\(\lambda\) e \(s_D=(1,0,\ldots,0)\) com probabilidade \(1-\lambda\):

\[
\sigma_0=\delta_{s_A},\qquad
\sigma_1=\lambda\delta_{s_A}+(1-\lambda)\delta_{s_D}.
\]

Bayes exige

\[
\mu_A:=\mu(s_A)
=\frac{\nu\lambda}{(1-\nu)+\nu\lambda},
\qquad
\mu(s_D)=1.
\]

A transformação inversa é

\[
\lambda
=\frac{\mu_A(1-\nu)}{\nu(1-\mu_A)}.
\]

Fixe \(\mu(s)=1\) fora dos dois átomos. Em \(s_D\) e fora do caminho, use o
membro cíclico \(E\). Em todo vetor rejeitado após \(s_A\), use o mesmo membro
do ramo real \(B(\mu_A)\), com uma matriz de incidência que minimize o custo
dos \(k\) votos, conforme AMX-008.
Denote esse custo nativo por \(M_{B(\mu_A)}(\mu_A)\) e a capacidade por

\[
\bar Z_{B(\mu_A)}(\mu_A)
=1-\beta M_{B(\mu_A)}(\mu_A).
\]

Se

\[
\beta o_1\ge Z_E
\qquad\text{e}\qquad
\bar Z_{B(\mu_A)}(\mu_A)\ge\beta o_1,
\tag{SP}
\]

construa \(s_A\) pagando a cada membro do conjunto dos \(k\) preços mais
baixos exatamente sua reserva externa e dando

\[
z_H=\beta o_1
\]

a \(H\). Qualquer sobra fica não alocada. A proposta passa. Todos os fracos
recebem votos definidos por AM-L2 em todo \(Y\).

Verificação:

- Bayes produz \(\mu_A\) e \(1\) nos dois átomos; as crenças fora do caminho
  estão no suporte do prior.
- A segunda desigualdade em (SP) garante a factibilidade de \(s_A\).
- O tipo alto recebe \(\beta o_1\) tanto em \(s_A\) quanto na rejeição de
  \(s_D\) seguida por \(E\).
- O tipo baixo prefere estritamente \(s_A\) à rejeição de \(s_D\), pois
  \(\beta o_1>\beta o_0\).
- Fora do caminho, qualquer acordo rende no máximo \(Z_E\), enquanto qualquer
  rejeição rende \(\beta o_\theta\). A primeira desigualdade em (SP), junto
  com \(o_1>o_0\), elimina todos esses desvios para ambos os tipos.

Logo há um PBE semipooling genuíno. Seus payoffs são

\[
(V_H^0,V_H^1)=(\beta o_1,\beta o_1).
\]

A condição de capacidade é uma desigualdade. Não se iguala o orçamento para
selecionar artificialmente um único \(\lambda\). Dentro de um único ramo, o
conjunto de taxas admissíveis é um intervalo; quando \(B(\mu_A)\) muda de
\(S\) para \(E\), ele pode ser uma união desconexa de até dois intervalos.

## AMX-007: misturas de fronteira

As construções gerais desta seção são exclusivamente interiores:
`0<\nu<1`. Nos endpoints do prior, remeta exclusivamente a AMX-005.

### Fronteira \(o_1=T\)

Para \(0<\nu<1\), como \(T>1/m\), AMX-006 se aplica com

\[
\beta o_1=\beta T=Z_E.
\]

Para \(0<\nu<1\) e todo \(\lambda\in(0,1)\), o ramo real \(B(\mu_A)\) possui capacidade de
acordo ao menos \(Z_E\). Portanto o tipo alto pode misturar entre o acordo
comum por \(Z_E\) e a rejeição seguida por \(E\). Os limites
\(\lambda=0\) e \(\lambda=1\) reproduzem, respectivamente, o separating
baixo-acordo/alto-atraso e o pooling com acordo.

### Fronteira \(o_0=T<o_1\)

Agora \(o_0>1/m\), de modo que \(E\) é o único ramo em todo posterior. Fixe
\(0<\nu<1\), \(\alpha\in(0,1)\) e

\[
\sigma_0=\alpha\delta_{s_A}+(1-\alpha)\delta_{s_D},
\qquad
\sigma_1=\delta_{s_D}.
\]

Em \(s_A\), use o acordo cíclico \(E\), com \(z_H=Z_E=\beta o_0\). Use
\(s_D=(1,0,\ldots,0)\) para a rejeição compartilhada. Bayes fornece

\[
\mu(s_A)=0,
\qquad
\mu(s_D)
=\frac{\nu}{\nu+(1-\nu)(1-\alpha)}.
\]

Fixe qualquer crença no suporte fora do caminho e use o mesmo membro cíclico
\(E\) em todo vetor rejeitado. O tipo baixo é indiferente entre acordo e
rejeição; o tipo alto prefere estritamente a rejeição, pois
\(\beta o_1>\beta o_0\). Todo acordo alternativo rende no máximo \(Z_E\) e
toda rejeição alternativa reproduz \(\beta o_\theta\). A construção é,
portanto, um PBE.

### Endpoints

Nos endpoints do prior, remeta exclusivamente a AMX-005: a mistura entre a
proposta aprovada canônica e a proposta rejeitada canônica existe somente
quando \(Z_{B(\nu)}(\nu)=D_{B(\nu)}(\theta)\) para o tipo contingente. A crença
permanece identicamente igual ao endpoint, inclusive fora do caminho.

# Geometria dos preços de votos

## AMX-008: limites exatos por ramo

Considere primeiro um único membro literal usado em todos os vetores
rejeitados após um sinal. Seja
\(\mathsf A=(a_{ij})\) sua matriz de probabilidades de inclusão:

\[
a_{ii}=0,\qquad
0\le a_{ij}\le1,\qquad
\sum_j a_{ij}=r,\qquad
d_j=\sum_i a_{ij}.
\]

Aqui \(r=k\) em \(E\) e \(r=k-1\) em \(P/S\). As fórmulas de AX-CM-4
continuam válidas para matrizes probabilísticas, pois são lineares.

Ponha \(c=m-k\). Para \(r\in\{k,k-1\}\), defina

\[
A_{\min}(r)
=k\max\{0,r-c\}
+c\max\{0,r-(c-1)\}.
\tag{1}
\]

Então \(A_{\min}(r)\) é exatamente o menor valor possível da soma dos
\(k\) menores graus.

### Prova do limite inferior

Se \(J\) contém os \(k\) menores graus, seu complemento tem \(c\) colunas.
Como cada coluna tem grau no máximo \(m-1\),

\[
\sum_{j\in J}d_j
=mr-\sum_{j\notin J}d_j
\ge \max\{0,mr-c(m-1)\}.
\tag{2}
\]

Para os dois valores admissíveis de \(r\) e para as duas paridades de \(m\),
o lado direito de (2) é idêntico à expressão (1).

### Construções que atingem o limite

As seguintes matrizes são binárias e, portanto, não dependem de uma
decomposição abstrata em loterias.

- Se \(m=2h\), então \(k=c=h\). Separe os nomes em \(P\) e \(O\), ambos de
  tamanho \(h\).
  - Para \(r=k\), cada linha de \(O\) inclui todo \(P\); cada linha
    \(i\in P\) inclui \(P\setminus\{i\}\) e seu par em \(O\).
  - Para \(r=k-1\), cada linha \(i\in P\) inclui
    \(P\setminus\{i\}\); cada linha de \(O\) inclui \(P\) menos um nome,
    omitido ciclicamente.
- Se \(m=2h-1\), então \(k=h\) e \(c=h-1\). Tome
  \(|P|=h-1\) e \(|O|=h\).
  - Para \(r=k\), cada linha de \(O\) inclui todo \(P\) e o próximo nome de
    \(O\) no ciclo; cada linha \(i\in P\) inclui
    \(P\setminus\{i\}\) e dois nomes consecutivos de \(O\).
  - Para \(r=k-1\), cada linha de \(O\) inclui todo \(P\); cada linha
    \(i\in P\) inclui \(P\setminus\{i\}\) e um nome distinto de \(O\).

Cada linha tem exatamente \(r\) entradas iguais a um, a diagonal é zero e a
soma dos \(k\) menores graus é (1). Isso prova atingibilidade.

Substituindo em AX-CM-4, o menor custo nativo dos \(k\) votos é

\[
M_E=\frac{kE+wA_{\min}(k)}m,
\]

\[
M_P=\frac{kP+wA_{\min}(k-1)}m,
\]

\[
M_S(\mu)
=(1-\mu)\frac{kL+wA_{\min}(k-1)}m+\mu kw.
\]

Portanto os maiores payoffs de acordo atingíveis, com posterior e ramo
fixados, são

\[
\bar Z_B(\mu)=1-\beta M_B(\mu).
\tag{3}
\]

### Seletores arbitrários dentro de um ramo puro \(B\) fixado

Para um seletor arbitrário \(\kappa_M\), defina

\[
u_j^\kappa(s)
=\max_{a_{-j}\in\mathcal P_j}
C^I_{M,j}\bigl(\kappa_M(s,(0,a_{-j}),\mu(s))\bigr),
\]

\[
K_\kappa(s)
=\beta\sum_{\ell=1}^k u_{(\ell)}^\kappa(s),
\]

onde \(u_{(1)}^\kappa\le\cdots\le u_{(m)}^\kappa\). Se \(J\) reúne os
\(k\) menores \(u_j^\kappa\), existe um vetor rejeitado com \(k-1\) votos
sim todos fora de \(J\), pois \(m-k\ge k-1\). Nesse vetor, todos os membros
de \(J\) são simultaneamente pivotais. Assim,

\[
\sum_{j\in J}u_j^\kappa
\ge\sum_{j\in J} C^I_{M,j}(\kappa_M)
\ge M_B.
\]

Logo

\[
K_\kappa(s)\ge\beta M_B(\mu(s)).
\]

Este é um limite pontual para cada proposta \(s\), não uma afirmação de que
\(1-K_\kappa(s)\) é atingível quando \(\kappa_M\) também depende dos
pagamentos da proposta. A construção mínima atinge a igualdade apenas como
um assessment coordenado de membro/família fixa: a proposta que paga os
preços deve continuar induzindo o mesmo membro. Uma seletora que reordena ou
altera a incidência depois da mudança de proposta pode quebrar essa
autoconsistência.

Para o outro extremo, defina

\[
U_E=\frac{E+w(m-1)}m.
\]

Se \(N\ge4\), defina também

\[
U_P=\frac{P+w(m-1)}m,
\]

\[
U_S(\mu)
=(1-\mu)\frac{L+w(m-1)}m+\mu w.
\]

Se \(N=3\), use

\[
U_P=\frac Pm,\qquad
U_S(\mu)=(1-\mu)\frac Lm+\mu w,
\]

pois \(r=k-1=0\). Em todos os casos,

\[
\beta M_B(\mu)
\le K_\kappa(s)
\le\beta kU_B(\mu).
\tag{4}
\]

O extremo superior também é atingível. Para \(m\ge3\), associe a cada
identidade \(j\) o vetor rejeitado cujos \(k-1\) votos sim pertencem aos
próximos \(k-1\) nomes do ciclo. Esses vetores são distintos e \(j\) é
pivotal no vetor que lhe foi associado. Escolha nesse vetor um membro literal
com \(d_j=m-1\). Para \(N=3\), o único vetor
relevante já maximiza simultaneamente os dois payoffs no ramo \(E\), enquanto
\(r=0\) nos ramos \(P/S\). Em nenhuma história se combinam coordenadas de
membros diferentes.

## AMX-009: família exata na subfamília globalmente constante \(E_F\)

Suponha \(o_0>1/m\). Então somente \(E\) existe em todo posterior. AMX-009
considera **somente** a subfamília globalmente constante: existe uma família
de incidência fixa \(F\) tal que

\[
\kappa_M(s,a,\mu(s))=E_F(\mu(s))
\]

para toda proposta \(s\), todo vetor rejeitado \(a\) e todo posterior
relevante. O mesmo \(F\) é usado entre propostas, mas \(E_F(\mu)\) é o membro
compatível com o posterior \(\mu\); não se afirma que o vetor numérico de
payoffs seja idêntico quando \(\mu\) muda. Essa é uma subfamília analítica,
não uma restrição do modelo geral, que continua permitindo seletores
dependentes da proposta ou do vetor pivotal.

Misturas internas entre a matriz cíclica e uma matriz mínima fazem a capacidade
de acordo percorrer todo o intervalo

\[
a\in[Z_E,\bar Z_E].
\]

Este é também o intervalo inteiro possível entre membros planos. De fato, o
grau médio é \(r=k\), de modo que a soma dos \(k\) menores graus não pode
exceder \(kr\). O membro cíclico atinge essa cota e, portanto, gera a menor
capacidade \(Z_E\); AMX-008 prova que a matriz mínima gera a maior capacidade
\(\bar Z_E\). A combinação convexa das duas regras mantém um único binder
literal e percorre todos os valores intermediários.

Fixado \(a\), use a mesma família \(F\) em toda rejeição. Cada tipo
compara a melhor proposta aprovada, que rende \(a\), com a rejeição, que rende
\(\beta o_\theta\). Assim a família de payoffs é exatamente

\[
\left(\max\{a,\beta o_0\},
\max\{a,\beta o_1\}\right),
\qquad
a\in[Z_E,\bar Z_E].
\tag{5}
\]

Para tornar a construção explícita:

- se \(a\ge\beta o_1\), ambos os tipos fazem o mesmo acordo ótimo;
- se \(\beta o_0\le a\le\beta o_1\), o baixo faz o acordo e o alto envia uma
  proposta rejeitada distinta;
- se \(a\le\beta o_0\), ambos enviam proposta rejeitada, em pooling ou com
  sinais distintos;
- em cada igualdade, qualquer mistura entre as duas melhores respostas é
  admissível.

Bayes é aplicado aos sinais efetivamente usados; como \(E_F\) é válido em todo
posterior, essas crenças alteram o membro compatível apenas através de \(\mu\).
A expressão (5) é exata para a subfamília globalmente constante \(E_F\), não
para todos os seletores dependentes da proposta ou do vetor pivotal.

# Contraexemplo obrigatório para a atingibilidade de AM-L2

Use

\[
N=5,\quad m=4,\quad k=2,\quad
\beta=\frac45,\quad o_0=\frac3{10},\quad o_1=\frac25.
\]

Somente \(E\) existe, com \(E=3/5\) e \(w=1/5\). Se o seletor ordena os
pagamentos fracos do maior para o menor, atribui grau \(3\) aos dois maiores
e grau \(1\) aos dois menores, e aplica a matriz correspondente em todos os
vetores rejeitados após a proposta, então

\[
\rho(3)=\frac6{25},\qquad \rho(1)=\frac4{25}.
\]

O cálculo pontual ingênuo escolhe os dois preços \(4/25\), obtém
\(K_{\mathrm{point}}=8/25\) e declara \(Z_{\mathrm{point}}=17/25\). Mas pagar
esses dois preços torna os destinatários os dois maiores pagamentos, fazendo
o seletor atribuir-lhes grau \(3\); a proposta então falha.

O certificado correto é: dois maiores votantes custam pelo menos \(12/25\);
uma combinação com um maior e um menor custa pelo menos \(14/25\); dois
menores custam pelo menos \(16/25\). Logo toda proposta aprovada custa pelo
menos \(12/25\). A proposta

\[
x=(6/25,6/25,0,0),\qquad z_H=13/25
\]

é autoconsistente e passa. O máximo verdadeiro é, portanto, \(13/25\), não
\(17/25\). O script anexado deve falhar se a conclusão ingênua voltar a ser
declarada atingível.

# Limites globais e implicações

## AMX-010: limites rigorosos para o payoff de \(H\)

Defina

\[
\bar C
=\frac{1+\beta(m-k)/m}{m},
\qquad
A_g=1-k\beta\bar C.
\tag{6}
\]

Todo payoff próprio de um fraco, em qualquer membro literal de \(C_M\), é no
máximo \(\bar C\):

- em \(E\), use \(d_j\le m-1\);
- em \(P\), descarte o termo negativo \(-\beta o_1\) de \(P\) e use
  \(d_j\le m-1\);
- em \(S\), o payoff é uma combinação convexa de um termo com o mesmo limite
  e de \(w=\beta/m\le\bar C\);
- no empate residual \(E/P\), o mesmo peso conjunto preserva o limite.

Logo \(H\) garante aprovação oferecendo \(\beta\bar C\) a quaisquer \(k\)
fracos e retendo \(A_g\). Essa proposta é factível. Com \(x=k/m\),

\[
A_g
=1-x\beta[1+\beta(1-x)]
>(1-x)^2\ge\frac19,
\tag{7}
\]

pois \(0<\beta<1\) e \(x\le2/3\).

Além disso, \(H\) pode propor \((1,0,\ldots,0)\). Todos os payoffs de
continuação dos fracos são positivos, então a proposta falha. Em qualquer
ramo literal, o payoff resultante de \(H(\theta)\) é ao menos
\(\beta^2o_\theta\).

Portanto, em todo PBE,

\[
\max\{A_g,\beta^2o_\theta\}
\le V_H^\theta\le1.
\tag{8}
\]

Para cada proposta fixa, a diferença entre os payoffs dos tipos é:

\[
0\quad\text{se passa},\qquad
\beta(o_1-o_0)\quad\text{em }E,
\]

\[
\beta^2(o_1-o_0)\quad\text{em }S,\qquad
0\quad\text{em }P.
\]

No empate residual, o mesmo peso conjunto mantém a diferença dentro desse
intervalo. Como os dois tipos maximizam sobre o mesmo espaço de propostas,

\[
0\le V_H^1-V_H^0\le\beta(o_1-o_0).
\tag{9}
\]

Se \(o_1<1/m\), o ramo \(E\) não existe e o limite superior em (9) melhora
para \(\beta^2(o_1-o_0)\).

## AMX-011: acordo do tipo alto força payoff diagonal

Suponha que a estratégia do tipo alto atribua probabilidade positiva ao
conjunto de propostas aprovadas. Quase toda proposta aprovada usada por ele é
uma melhor resposta e paga a mesma parcela \(V_H^1\). O tipo baixo pode imitar
uma dessas propostas e obter a mesma parcela, logo \(V_H^0\ge V_H^1\).
AMX-010 fornece a desigualdade inversa. Portanto,

\[
V_H^0=V_H^1.
\]

Consequentemente, \(V_H^1>V_H^0\) exige que toda proposta usada pelo tipo alto
seja rejeitada, salvo conjuntos de probabilidade zero.

# Certificados de não existência

## AMX-012

Os quatro primeiros certificados independem do membro cíclico.
As afirmações sobre separating pressupõem \(0<\nu<1\), para que ambos os tipos
estejam no suporte e Bayes fixe os dois sinais.

1. **Pooling não separa acordo e atraso por tipo.** A mesma distribuição de
   propostas enfrenta as mesmas crenças, votos e função de outcome. Portanto
   não pode passar para um tipo e falhar para o outro.

2. **Separating puro com dois acordos exige \(z_0=z_1\).** O tipo zero pode
   imitar literalmente \(s_1\), de modo que \(z_0\ge z_1\); o tipo um pode
   imitar \(s_0\), de modo que \(z_1\ge z_0\).

3. **Baixo atrasa e alto acorda é impossível.** No sinal baixo, Bayes fixa
   posterior zero. A rejeição produz

   \[
   (D_0,D_1)
   =
   \begin{cases}
   (\beta^2o_0,\beta^2o_1),&B(0)=S,\\
   (\beta o_0,\beta o_1),&B(0)=E.
   \end{cases}
   \]

   Em ambos os casos \(D_1>D_0\). Se o sinal alto aprovado paga \(z_1\), as
   duas restrições de imitação exigem

   \[
   D_0\ge z_1\ge D_1,
   \]

   uma contradição.

4. **Separating puro com atraso dos dois tipos exige \(o_0>1/m\).** Se
   \(o_0\le1/m\), o sinal baixo usa \(S\) e rende \(\beta^2o_0\) ao tipo
   baixo. Se \(o_1\le1/m\), imitar o sinal alto seguido por \(P\) rende
   \(\beta^2o_1>\beta^2o_0\). Se \(o_1>1/m\), imitar o sinal alto seguido
   por \(E\) rende \(\beta o_0>\beta^2o_0\).

5. **Na subfamília cíclica constante**, pooling com rejeição é impossível nos
   ramos \(S\) e \(P\): o tipo baixo pode desviar para o acordo ótimo, cujo
   payoff excede estritamente sua continuação. Esta quinta afirmação não é uma
   impossibilidade global contra seletores que variam com a história.

# Certificado negativo para AMX-014--016

Os três exploradores independentes convergiram num obstáculo de existência e
de completude que deve ser auditado, sem ser tratado como hipótese econômica.
Para proposta `s`, fraco `j` e vetor pivotal `a_-j`, defina

\[
r_{j,a}(s)=\beta C^I_{M,j}\!\left(\kappa_M(s,(v_j=0,a_{-j}),\mu(s))\right),
\quad
\ell_j(s)=\min_a r_{j,a}(s),\quad
u_j(s)=\max_a r_{j,a}(s).
\]

A votação pura admissível é `sim` se `x_j>=u_j(s)` e `não` se
`x_j<ell_j(s)`; no intervalo intermediário não há voto puro admissível. Dada
uma seleção `v(s)`, o valor do hegemon é

\[
g_\theta(s)=\begin{cases}z_H(s),&\text{se a proposta passa},\\
\beta C^\theta_{M,H}(\kappa_M(s,v(s),\mu(s))),&\text{se falha}.
\end{cases}
\]

Uma medida de proposta é melhor resposta somente se estiver concentrada no
`argmax` de `g_theta`; se o máximo não existe, não há melhor resposta mista.
Essa é uma redução necessária e suficiente condicional a `kappa_M`, `v` e às
medidas, mas não é a enumeração informativa pedida por AMX-014--016.

## Contraexemplo diagonal de existência

Use

\[
N=5,\quad m=4,\quad k=2,\quad \beta=.9,\quad o_0=.30,\quad o_1=.40.
\]

Somente `E` existe. `A^ell` e `A^h_b` são membros literais de `C_M`, gerados
por loterias de coalizões válidas, com as matrizes de incidência
`F^ell` e `F_b^h`. Para qualquer conjunto Borel `A` de propostas, um seletor
admissível pode usar `A^ell` em `A` e `A^h_b` fora de `A`, completando perfis
não pivotais arbitrariamente com membros literais. Para o conjunto enumerável
Borel `A_seq={s_n:n>=1}`, com
`s_n=(51/100-1/(100*n),6/25,6/25,0,0)`, a construção diagonal fornece

\[
g_\theta(s)\le 193/400\quad(s\notin A_{seq}),\qquad
g_\theta(s_n)<51/100,\qquad g_\theta(s_n)\longrightarrow51/100.
\]

Em qualquer rejeição pelo ramo `E`, o payoff é `27/100` para o tipo baixo e
`36/100` para o alto. Logo `g_theta` é Borel, mas não é USC e não atinge o
supremo `51/100`. Para toda probabilidade `sigma`,

\[
\int g_\theta(s)\,d\sigma(s)<51/100,
\]

pois `51/100-g_theta` é mensurável e estritamente positiva em todo ponto; um
dos `s_n` melhora a média. Não há melhor resposta pura nem mista para esse
seletor, e portanto nenhum PBE que o utilize. Isto não prova inexistência do
jogo inteiro: a testemunha cíclica pode existir. Prova, porém, que a existência
não é uniforme sobre todos os seletores permitidos.

## Misturas e Bayes local

Para `0<nu<1`, qualquer par de medidas pode ser parametrizado por

\[
\lambda=(1-\nu)\sigma_0+\nu\sigma_1,\qquad
\sigma_1(ds)=\frac{\pi(s)}{\nu}d\lambda(s),\qquad
\sigma_0(ds)=\frac{1-\pi(s)}{1-\nu}d\lambda(s),
\]

com \(\int\pi\,d\lambda=\nu\) e a razão de Bayes local em cada ponto
disciplinado. Isso inclui átomos, medidas singulares e partes não atômicas; a
restrição integral não substitui o limite local. Nos endpoints, o suporte do
prior força \(\pi\) identicamente `0` ou `1`.

Exemplo atomless: `N=5,m=4,k=2,beta=.9,o_0=.7,o_1=.8,nu=.5`, somente `E`,
continuação cíclica e a linha `s(t)=(t,0,0,0,0)`. Um acordo custa pelo menos
`.45` e dá no máximo `.55`, enquanto rejeitar dá `.63` ou `.72`. Com `lambda`
uniforme em `[0,1]`, \(\pi(t)=.25+.5t\),

\[
\sigma_1(dt)=(.5+t)dt,\qquad \sigma_0(dt)=(1.5-t)dt,
\]

Bayes local vale em todo ponto e produz um PBE semipooling atomless. Variar
`pi`, `lambda` e os membros literais gera famílias infinitas, portanto
AMX-015 não pode ser fechado por uma lista finita de pooling/separação.

## Estatuto

AMX-014, AMX-015 e AMX-016 permanecem **BLOQUEADOS**, não resolvidos. O objeto
exato restante é uma correspondência indexada por `kappa_M`, pela seleção de
votos e pelas medidas, com `argmax` atingido e Bayes local. Apresentá-la como
“caracterização completa” seria apenas uma reformulação tautológica do PBE.
Uma enumeração ou envelope fechado exigiria decisão do autor entre restringir
`kappa_M`/a família de continuação, impor regularidade que garanta máximo,
restringir suporte ou aceitar `epsilon`-equilíbrios. O pacote não escolhe
nenhuma dessas alternativas.

# Outcomes e payoffs ex ante

Nesta tabela, "acordo" significa acordo imediato em \(A_M\), e "atraso"
significa rejeição da proposta de \(H\) e consumo literal de \(C_M\).

| Família | Payoffs interinos \((V_H^0,V_H^1)\) | Payoff ex ante de \(H\) | Prob. acordo | Prob. atraso |
|---|---:|---:|---:|---:|
| pooling com acordo | \((Z_B,Z_B)\) | \(Z_B\) | \(1\) | \(0\) |
| separating, dois acordos | \((z,z)\) | \(z\) | \(1\) | \(0\) |
| baixo acorda, alto atrasa | \((Z_E,\beta o_1)\) | \((1-\nu)Z_E+\nu\beta o_1\) | \(1-\nu\) | \(\nu\) |
| ambos atrasam | \((\beta o_0,\beta o_1)\) | \(\beta[(1-\nu)o_0+\nu o_1]\) | \(0\) | \(1\) |
| alto mistura | \((\beta o_1,\beta o_1)\) | \(\beta o_1\) | \(1-\nu+\nu\lambda\) | \(\nu(1-\lambda)\) |
| baixo mistura em \(o_0=T\) | \((\beta o_0,\beta o_1)\) | \(\beta[(1-\nu)o_0+\nu o_1]\) | \((1-\nu)\alpha\) | \(1-(1-\nu)\alpha\) |

# Exemplos numéricos

Tome

\[
N=5,\quad m=4,\quad q=3,\quad k=2,\quad\beta=0.9.
\]

Então

\[
Z_E=0.55,\qquad T=0.611111\ldots
\]

1. **Pooling com acordo alto sem seleção canônica.** Para
   \(o_0=0.10\), \(o_1=0.35\) e \(\nu=0.5\), use no caminho um membro mínimo
   \(E\) e fora do caminho crença um com o membro cíclico \(E\). O payoff é
   \((0.65125,0.65125)\). Fora do caminho, o melhor acordo rende \(0.55\) e a
   melhor rejeição do tipo alto rende \(0.315\), logo nenhum desvio compensa.

2. **Baixo acorda, alto atrasa.** Para \(o_0=0.10\), \(o_1=0.70\),
   os payoffs são \((0.55,0.63)\).

3. **Semipooling.** Com as primitivas do item 2, \(\nu=0.5\) e
   \(\lambda=0.25\), Bayes dá \(\mu_A=0.2\). Um membro mínimo do ramo \(S\)
   custa \(0.3276\) em votos e admite parcela \(0.6724\), maior que
   \(\beta o_1=0.63\). Os payoffs são \((0.63,0.63)\).

4. **Atraso dos dois tipos.** Para \(o_0=0.70\), \(o_1=0.80\), os payoffs
   são \((0.63,0.72)\).

5. **Mesmas primitivas, payoffs distintos.** Para \(o_0=0.60\) e
   \(o_1=0.70\), somente \(E\) existe. O membro cíclico gera
   \((0.55,0.63)\). Um membro concentrado com graus
   \((3,3,2,0)\) gera \((0.65125,0.65125)\). A multiplicidade é econômica:
   não existe payoff canônico sem uma decisão adicional de seleção.

# Mapa dos claims

| ID | Status apresentado | Objeto a auditar |
|---|---|---|
| AMX-001 | prova candidata | existência global e \(D_M^0=\varnothing\) |
| AMX-002 | prova candidata | pooling e separating com acordo |
| AMX-003 | prova candidata | baixo acorda, alto atrasa, somente \(0<\nu<1\) |
| AMX-004 | prova candidata | pooling e separating com atraso |
| AMX-005 | prova candidata | endpoints do prior |
| AMX-006 | prova candidata | semipooling com mistura do tipo alto |
| AMX-007 | prova candidata | misturas nas fronteiras, somente \(0<\nu<1\); endpoints em AMX-005 |
| AMX-008 | reparado; revisão pendente | geometria exata por ramo puro \(B\); seletor arbitrário apenas no teto pontual |
| AMX-009 | reparado; revisão pendente | família exata somente para continuação globalmente constante \(E_F\) |
| AMX-010 | prova candidata | limites globais de payoff |
| AMX-011 | prova candidata | acordo do alto implica payoff diagonal (prova na Section 5.4; AMX-010 fornece o bound) |
| AMX-012 | prova candidata | cinco certificados de não existência |
| AMX-013 | evidência mecânica; revisão pendente | 567 testes, exemplos, identidades e contraexemplo \(17/25\) versus \(13/25\); script anexado |
| AMX-014 | bloqueado por certificado negativo | seletor Borel admissível pode eliminar o `argmax` puro; não há classificação uniforme |
| AMX-015 | bloqueado por certificado negativo | medidas atômicas, singulares e atomless são indexadas por dados Borel; o mesmo seletor pode não ter melhor resposta mista |
| AMX-016 | bloqueado por certificado negativo | a correspondência de payoffs pode não ser fechada/atingida; envelope exato exige nova restrição |

AMX-013 não substitui prova: classifique-o como MECHANICAL EVIDENCE ONLY, sem
tentar inferir um PASS do código. O script separado inclui o contraexemplo
racional e deve rejeitar explicitamente a frase “17/25 é atingível”. AMX-014 a
AMX-016 são limites bloqueados pelo certificado da seção própria, não resultados
que se apresentam como resolvidos. O certificado não afirma que o jogo inteiro
não tem PBE; afirma que o contrato não permite uniformizar a existência e
fechar a correspondência para todo seletor Borel admissível.

# Testes adversariais obrigatórios

Para cada claim novo, faça ao menos os seguintes testes:

1. escreva o assessment coordenado completo
   \((\sigma_0,\sigma_1,\mu,v,\kappa_M)\);
2. confirme Bayes local em cada átomo e a restrição de suporte nos endpoints;
3. confirme que o ramo de \(C_M\) invocado existe no posterior declarado;
4. confirme que \(\kappa_M\) é total em todo vetor rejeitado relevante;
5. calcule cada reserva ponto a ponto, sem tirar média sobre vetores pivotais;
6. verifique os votos, a quota e o outcome;
7. aplique \(\beta\) uma única vez ao payoff nativo de \(C_M\);
8. verifique imitação entre sinais e todo desvio fora do caminho;
9. verifique factibilidade sem exigir exaustão do bolo;
10. teste \(N=3\), as duas paridades de \(N\), \(\nu=0,1\),
    \(o_0=1/m\), \(o_1=1/m\), \(o_0=T\), \(o_1=T\) e \(T>1\);
11. procure recombinação indevida de coordenadas entre membros literais;
12. se alegar necessidade, tente construir um contraexemplo com
    \(\kappa_M\) dependente do vetor pivotal.
13. execute o contraexemplo \(N=5,m=4,k=2,\beta=4/5,o_0=3/10,o_1=2/5\):
    o cálculo pontual dá \(K=8/25\) e \(17/25\), mas qualquer proposta
    autoconsistente custa pelo menos \(12/25\) e atinge no máximo \(13/25\).

# Formato obrigatório da resposta

Sua resposta deve ser autocontida e conter, nesta ordem:

1. **Veredito global:** PASS, FAIL ou UNRESOLVED.
2. **Contagens:** número de achados critical, important e minor.
3. **Matriz claim por claim:** uma linha para cada AMX-001 a AMX-016, com
   PASS, FAIL, UNRESOLVED, OPEN BY DESIGN ou BLOCKED BY CERTIFICATE, ou, apenas
   para AMX-013, MECHANICAL EVIDENCE ONLY, além de uma justificativa curta.
4. **Tabela de assessments coordenados:** para cada família efetivamente
   validada, reporte propostas de cada tipo, crenças, continuação literal,
   votos, outcome, payoffs e condições paramétricas. Não combine coordenadas
   entre linhas.
5. **Demonstrações ou contraexemplos:** dê a prova faltante ou um
   contraexemplo mínimo para todo FAIL ou UNRESOLVED.
6. **Auditoria das fronteiras e endpoints.**
7. **Correções mínimas:** texto ou fórmula substituta exata, sem redesenhar o
   jogo.
8. **Resumo não técnico para o autor:** quais equilíbrios são seguros, em
   quais regiões, o que permanece aberto e se alguma decisão autoral é
   necessária.

Não converta AMX-014 a AMX-016 em PASS: eles estão bloqueados pelo certificado
negativo acima, não simplesmente “abertos por desenho”. Depois de auditar os
claims fechados, audite a construção diagonal, a não existência do `argmax` e
a parametrização local de Bayes. Se não for possível fechar a correspondência
sem hipótese nova, explique precisamente qual objeto funcional impede o
fechamento e qual hipótese ou decisão do autor seria necessária. Não imponha
essa hipótese.

# Proveniência e estado

O pacote foi derivado sobre o commit
\texttt{b427671efee954831901e75762988043a2df7205}.

Bytes substantivos consumidos:

\begingroup
\footnotesize
\raggedright

- contrato simplificado:
  \texttt{fb2cd323a74b30432746dc37d622014c}\allowbreak\texttt{d7768e6d5442877ed3a8e043df546dc4};
- decisão autoral/técnica de 28/08:
  \texttt{e841b9d3e56864fec29742a79ebfd1b9}\allowbreak\texttt{63519ef65ddfa3882508a802fa94a935};
- interface \(N1\):
  \texttt{1a171791ebd329ac325410038d92dae71}\allowbreak\texttt{9fa9edc053aa068772bc6564ed981b5};
- derivação integral de \(N1\):
  \texttt{44ef92fcd8bb76af65b937b37ff509fc}\allowbreak\texttt{b9b179bc3fa3d06a3331c346e20a761a};
- interface \(C_M\):
  \texttt{ff053798db1e2d4c103f3162e2e6525d}\allowbreak\texttt{20b68fc5ff376416c2deb66dae47330d};
- prova integral de \(C_M\):
  \texttt{75931253fd04303420b2d17552f60d9e}\allowbreak\texttt{e6fc2bf108f8b7ff03ada2eeed9201d3};
- derivação nova de \(A_M\) (snapshot anterior, preservado para a supersessão):
  \texttt{19881e9aa680784c93251f8b1c09921f}\allowbreak\texttt{28152ed36941661a6d351697e9dc6885};
- ledger novo de \(A_M\) (snapshot anterior, preservado para a supersessão):
  \texttt{857bfcd609313cfd54475286377496c58}\allowbreak\texttt{d1fb588d0952d0255ba205e88e3dec8};
- script mecânico separado (snapshot anterior):
  \texttt{2679d8cf8f8c97b374a9bba2f5f4be}\allowbreak\texttt{053cf171f8f84fcc17606004fdca2a9879}.
- derivação exploratória com certificado negativo:
  \texttt{1e385fabd2e25a5b72344d22982d9648}\allowbreak\texttt{e28be92eb68665d484cd8116aaa7772f};
- ledger corrente (AMX-014--016 bloqueados):
  \texttt{d2d81d3b0cf65d59e4e5846f599a5f67}\allowbreak\texttt{677507c51c9c3677e39e75907a0e4274};
- script mecânico corrente:
  \texttt{e277d1ab845391b8ae01a61ce7fc9a642}\allowbreak\texttt{25dca1591783102b3916ccc07bf6177};
- parecer externo original preservado:
  \texttt{d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c};
- PDF efetivamente auditado, preservado:
  \texttt{a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394}.

\endgroup

Status: **EXPLORATORY CANDIDATE - LOCAL REPAIRS IMPLEMENTED - AMX-014--016
BLOCKED BY CURRENT PRIMITIVES - REVIEW PENDING**; maioria não está aprovada nem
congelada. O parecer interno histórico
foi superado somente para AM-L2, AMX-009 e pontos correlatos, conforme a
adjudicação round 2; não houve nova revisão independente nesta etapa. Faça a
auditoria fria dos bytes reparados sem usar parecer anterior como atalho, mas
trate \(N1\) e \(C_M\) como axiomas fora de revisão.
