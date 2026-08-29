---
title: "A_M sob a emenda M/S/B"
subtitle: "Pacote autocontido para consulta técnica externa no ChatGPT web"
date: "29 de agosto de 2026"
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

# Mandato ao ChatGPT web

Você atuará como leitor técnico externo de uma extensão de um modelo formal de
barganha política. Empregue o rigor matemático que se esperaria de um referee
de teoria formal, mas **não assuma o papel institucional de parecerista do
projeto**.

Esta é uma consulta técnica suplementar e não um parecer formal. Ela não
reabre um gate, não substitui as duas revisões formais independentes já
concluídas, não concede nem retira aprovação e não congela novos bytes. Um
eventual problema encontrado será evidência para adjudicação posterior contra
as fontes exatas; não altera, por si só, o estado canônico do projeto.

Também não se pede um parecer genérico de journal, uma avaliação da contribuição
do artigo ou uma oportunidade para redesenhar o modelo. O objeto exclusivo da
leitura é o estágio em que o hegemon propõe sob maioria, denotado por \(A_M\),
depois da emenda autoral M/S/B.

A leitura deve testar validade matemática, completude, fidelidade ao protocolo,
interpretação econômica e segurança para consumo downstream. Tente refutar os
resultados antes de aceitá-los. Não trate verificação numérica como prova.

**Estado do pacote:** `AUTHOR APPROVED — INFORMAL SUPPLEMENTARY TECHNICAL
CONSULTATION`. O autor aprovou, em 29 de agosto de 2026, o pacote exato
identificado na seção **Proveniência, validação e bytes exatos**. A aprovação
autoral não deve influenciar sua avaliação técnica. Duas revisões formais
independentes anteriores também deram
`PASS 0/0/0`, mas elas não são axiomas matemáticos: faça uma leitura nova a
partir do conteúdo deste documento.

Produza um arquivo Markdown UTF-8 chamado
`2026-08-29_consulta_tecnica_chatgpt_web_A_M_msb.md`. Se a interface não puder
criar um arquivo baixável, devolva o Markdown completo, sem texto introdutório
fora do documento. No próprio relatório, identifique-o como **consulta técnica
externa não formal**, nunca como aprovação, gate ou parecer independente do
projeto.

## Escopo estrito

Audite:

1. a compatibilidade literal da seleção uniforme com a continuação congelada
   \(C_M\);
2. a redução do ballot a um preço comum de voto;
3. o finding de que fechamento global é falso;
4. a prova construtiva de existência por regiões;
5. a classificação necessária e suficiente dos PBEs puros;
6. a caracterização necessária e suficiente dos PBEs mistos;
7. o tratamento dos endpoints do prior;
8. a assinatura conjunta downstream e o teorema de não finitude;
9. os limites de payoff, impossibilidades e testemunhas revalidadas;
10. o escopo preservado do certificado negativo do contrato anterior.

Não audite nem tente rederivar:

- o jogo-base do paper;
- os nós congelados N1--N7;
- a correspondência de continuação \(C_M\) em si;
- \(A_U\), \(AC\), \(AR\) ou o manuscrito;
- a escolha autoral de adotar M/S/B, salvo para avaliar sua coerência interna e
  se a nova derivação realmente a implementa.

# Resumo não técnico e intuição econômica

## O problema

Há um hegemon \(H\) com informação privada sobre seu payoff de desacordo. Na
extensão \(A_M\), ele recebe o direito de propor sob maioria. Sua própria
proposta já conta como um voto favorável; por isso precisa comprar mais \(k\)
votos de Estados fracos. Um fraco aceita quando o pagamento corrente cobre o
valor que obteria se a proposta fosse rejeitada.

O jogo que começa depois da rejeição já foi resolvido no paper e pode ter mais
de um equilíbrio. O contrato anterior permitia que a regra \(\kappa_M\), que
seleciona a continuação, variasse com a proposta rejeitada e com o vetor de
votos. Crenças fora do caminho também podiam variar ponto a ponto. Assim,
propostas quase idênticas podiam acionar continuações diferentes, mudando
descontinuamente o preço dos votos que elas próprias precisavam comprar.

O resultado negativo histórico tornou o problema concreto. Para uma instância
com cinco jogadores, uma regra Borel admissível selecionava votos baratos apenas
na sequência

\[
s_n=\left(\frac{51}{100}-\frac{1}{100n},\frac{6}{25},
          \frac{6}{25},0,0\right).
\]

O payoff de \(H\) se aproximava de \(51/100\), mas nunca o atingia. Fora da
sequência, votos mais caros impediam alcançar esse valor. Toda proposta pura
podia ser melhorada; qualquer loteria também tinha média estritamente inferior
ao supremo. Portanto não havia melhor resposta pura nem mista para aquele
seletor permitido, e nenhum PBE podia usá-lo.

Isso não provava que o jogo sob maioria nunca tem equilíbrio. Provava que o
contrato permitia códigos de punição sem conteúdo econômico suficientes para
destruir existência uniforme e qualquer classificação informativa.

## A correção autoral

A emenda M/S/B retirou precisamente esses códigos:

- **M — seleção markoviana:** depois de uma rejeição, a continuação depende
  apenas da instituição, do estágio e do posterior público. Não depende da
  identidade da proposta rejeitada nem do vetor de votos.
- **S — anonimidade:** a continuação usa uma classe anônima de payoffs para os
  Estados fracos. O representante literal é uma loteria uniforme sobre
  coalizões ótimas. Um ciclo pode ser usado apenas como implementação
  computacional depois de provada sua equivalência de payoffs.
- **B — crença off-path constante:** Bayes local continua governando cada ponto
  disciplinado. Em todo ponto genuinamente não disciplinado, a crença é um
  único escalar \(\nu_{\mathrm{off}}\) por assessment. Nos endpoints do prior,
  \(\nu_{\mathrm{off}}=\nu\).

A intuição é que histórias com o mesmo jogo futuro e a mesma informação pública
devem induzir a mesma continuação; jogadores ex ante idênticos não devem ter
preços sistematicamente diferentes por causa de seus nomes; e uma proposta de
probabilidade zero não deve funcionar como rótulo arbitrário de punição.

## O resultado em uma frase

Sob M/S/B, o preço de cada voto fraco fica determinado pelo posterior e por uma
continuação anônima literal de \(C_M\). Isso permite provar existência de PBE
para toda primitiva e prior, classificar completamente os PBEs puros e dar uma
caracterização necessária e suficiente dos PBEs mistos. A família mista não se
reduz, em geral, a um número finito de assinaturas; essa impossibilidade é um
teorema, não uma lacuna deixada aberta.

# Barreira axiomática: fatos do jogo-base já provados e incorporados ao paper

Os resultados desta seção foram demonstrados, revisados, congelados e
transportados ao manuscrito. **Assuma-os como verdadeiros, completos e
internamente consistentes.** Sua auditoria começa na Seção 6.

Não rederive N1 ou \(C_M\), não penalize a ausência de suas provas e não
substitua sua correspondência por outra solução. Se algum axioma parecer
surpreendente, registre apenas `AXIOMA ACEITO` e verifique se a nova derivação o
usa corretamente.

## AX-PAPER-1: jogadores, timing, informação e ballot

Há \(N\ge3\) Estados. Um é o hegemon \(H\); os outros \(m=N-1\) são fracos. A
quota de maioria é

\[
q=\lfloor N/2\rfloor+1,
\qquad
k=q-1=\lfloor N/2\rfloor.
\]

O tipo privado de \(H\) é \(\theta\in\{0,1\}\), com
\(\Pr(\theta=1)=\nu\in[0,1]\). As primitivas satisfazem

\[
0<\beta<1,
\qquad
0<o_0<o_1<1,
\qquad
o_1\le\bar y\le1.
\]

\(o_\theta\) é o payoff terminal de desacordo do tipo \(\theta\). A proposta é
pública; os votos são simultâneos; o proponente é contado como voto `sim`. A
regra para fracos é as-if-pivotal: cada fraco compara sua alocação corrente com
o valor esperado da continuação no evento em que seu voto é pivotal. Em
igualdade, \(T^Y\) prescreve `sim`. Votos de fracos não mudam a crença sobre
\(\theta\).

## AX-N1: folha terminal sob maioria

Assuma como provado:

1. na rodada terminal de maioria, um fraco reconhecido propõe sua própria
   parcela igual a um e as demais parcelas iguais a zero;
2. todos os fracos não proponentes votam `sim` e \(H\) vota `não`;
3. a proposta passa sem \(H\);
4. antes do reconhecimento, cada fraco recebe \(1/m\);
5. \(H(\theta)\) recebe \(o_\theta\);
6. esses valores estão em unidades da rodada terminal e não contêm \(\beta\);
7. estratégias, outcome e payoffs são únicos; crenças fora do caminho são
   irrelevantes.

## AX-CM-1: notação e ramos da continuação de maioria

No jogo anterior do paper, defina

\[
w=\frac{\beta}{m},
\qquad
t_\theta=\beta o_\theta,
\]

\[
E=1-kw,
\qquad
L=1-(k-1)w-t_0,
\qquad
P=1-(k-1)w-t_1,
\]

\[
S(\mu)=(1-\mu)L+\mu w.
\]

Os únicos ramos de equilíbrio de \(C_M\) são:

- \(E\): exclusão de \(H\);
- \(S\): o tipo baixo aceita e o alto atrasa;
- \(P\): ambos os tipos aceitam.

Rejeição deliberada não é ótima em \(C_M\).

## AX-CM-2: partição completa dos ramos

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

4. Se \(o_0=1/m<o_1\), \(S\) existe apenas em \(\mu=0\) e \(E\) para
   \(\mu>0\).

5. Se \(o_0<o_1=1/m\), \(S\) existe até \(\nu_{SE}\), inclusive. Acima,
   \(E\) e \(P\) empatam para o proponente; o desempate compara

   \[
   h_E=(1-\mu)o_0+\mu/m,
   \qquad
   h_P=\beta/m.
   \]

   O menor é selecionado; ambos e suas misturas permanecem apenas quando
   também há igualdade nesse desempate.

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

Para cada identidade proponente \(i\), qualquer distribuição apoiada nas
coalizões ótimas do ramo selecionado pertence à correspondência \(C_M\). Não se
impõe que proponentes distintos usem a mesma distribuição. Estratégias,
crenças, propostas, coalizões, payoffs e outcomes precisam vir do mesmo membro
literal completo. É proibido recombinar coordenadas de membros distintos. No
empate residual \(E/P\), o mesmo peso conjunto governa todas as coordenadas.

## AX-CM-4: coordenadas de payoff

Para uma matriz de incidência \(\mathsf A=(a_{ij})\), com \(a_{ii}=0\), linhas
somando \(r\) e graus de coluna \(d_j=\sum_i a_{ij}\), os payoffs interinos
fracos, em unidades nativas de \(C_M\), são

\[
C_j^E=\frac{E+wd_j}{m},
\qquad r=k,
\]

\[
C_j^P=\frac{P+wd_j}{m},
\qquad r=k-1,
\]

\[
C_j^S(\mu)
=(1-\mu)\frac{L+wd_j}{m}+\mu w,
\qquad r=k-1.
\]

Os payoffs nativos de \(H\) são

\[
E:(o_0,o_1),
\qquad
S:(\beta o_0,\beta o_1),
\qquad
P:(\beta o_1,\beta o_1).
\]

Quando uma proposta de \(A_M\) falha, esses valores recebem exatamente mais um
fator \(\beta\). No empate residual \(E/P\), um único peso comum mistura todas
as coordenadas.

# Protocolo autoral fixo da extensão: M/S/B

M/S/B são escolhas de modelagem aprovadas pelo autor, não teoremas derivados do
jogo-base. Você pode avaliar sua transparência, coerência interna e alcance,
mas não deve substituir essas escolhas por D1, Critério Intuitivo, trembles,
continuidade, grade finita, seleção assimétrica ou \(\epsilon\)-equilíbrio.

## M — seleção markoviana de continuação

O estado suficiente depois de uma rejeição é

\[
\phi_M(h)=(M,\text{estágio de entrada em }C_M,
              \text{posterior público }\mu(h)).
\]

A seleção precisa fatorar como

\[
\kappa_M(h)=\widehat\kappa_M(\phi_M(h)),
\]

para alguma função Borel. Parâmetros fixos do jogo são constantes globais. A
seleção não varia com a identidade da proposta rejeitada nem com o vetor de
votos.

## S — anonimidade na continuação

Para cada estado \(\phi_M\), a seleção recai sobre a classe anônima de payoffs
de \(C_M\). O representante literal é a loteria uniforme: quando um fraco é
reconhecido, seus parceiros são sorteados uniformemente entre todas as
coalizões ótimas do tamanho requerido. Uma construção cíclica é apenas uma
implementação permitida quando for provada payoff-equivalente ao representante
uniforme. Distribuições terminais distintas não são identificadas.

## B — crença constante nos pontos não disciplinados

Se toda vizinhança relativa de uma proposta \(y\) tem massa pública positiva,
vale o limite local de Bayes. Se esse limite não existir, o ramo é inválido e
deve ser escalado.

Se alguma vizinhança relativa de \(y\) tem massa pública zero, então

\[
\mu(y)=\nu_{\mathrm{off}},
\]

onde \(\nu_{\mathrm{off}}\in[0,1]\) é um único escalar por assessment. Em
\(\nu=0\), \(\nu_{\mathrm{off}}=0\); em \(\nu=1\),
\(\nu_{\mathrm{off}}=1\). Massa pontual zero, por si só, não torna o ponto não
disciplinado: uma proposta em suporte contínuo continua sujeita a Bayes local.

Na futura comparação \(AC\), maioria e unanimidade usarão o mesmo
\(\nu_{\mathrm{off}}\). Isso não é objeto da presente consulta.

# Definição do novo estágio \(A_M\)

\(H\) observa \(\theta\) e é obrigado a propor. Não existe ação primitiva de
passar. Sua proposta é

\[
s=(z_H,x_1,\ldots,x_m)\in Y,
\]

onde

\[
Y=\left\{s:z_H\ge0,\ x_j\ge0,\
               z_H+\sum_{j=1}^m x_j\le1\right\}.
\]

A proposta de \(H\) já conta como voto favorável e passa se ao menos \(k\)
fracos votarem `sim`. Se passa, \(H\) recebe \(z_H\) e o fraco \(j\) recebe
\(x_j\). Se falha, entra um membro literal de \(C_M\) e seu valor nativo recebe
um único fator adicional \(\beta\).

\(\bar y\) permanece no domínio herdado, mas não limita \(z_H\). Nas propostas
relevantes de \(C_M\), o maior pagamento a \(H\) é
\(t_1=\beta o_1\le o_1\le\bar y\). Portanto os resultados são uniformes em
\(\bar y\), sem apagar essa primitiva da interface.

# Lema 1 — representante uniforme literal de \(C_M\)

Fixe um fraco reconhecido \(i\). Nos ramos \(S\) e \(P\), sorteie
uniformemente um conjunto \(Q\subseteq W\setminus\{i\}\) com \(|Q|=k-1\). No
ramo \(E\), sorteie uniformemente \(Q\) com \(|Q|=k\). Para cada realização,
use a proposta canônica do ramo congelado.

Cada proposta da loteria está no argmax lexicográfico do proponente em \(C_M\).
Pelo AX-CM-3, uma distribuição apoiada nesse argmax é um membro literal da
correspondência. Fazer isso para cada identidade reconhecida e transportar
conjuntamente propostas, votos, crenças, payoffs e outcomes produz um membro
literal completo.

Para cada \(j\ne i\),

\[
\Pr(j\in Q\mid i\text{ reconhecido})
=\frac{r_B}{m-1},
\qquad
r_E=k,
\quad r_S=r_P=k-1.
\]

Os payoffs interinos comuns de cada fraco e os payoffs nativos de \(H\) são:

| ramo | payoff de cada fraco \(c_B(\mu)\) | payoff nativo de \(H\) |
|---|---:|---:|
| \(E\) | \(1/m\) | \((o_0,o_1)\) |
| \(S\) | \(\{(1-\mu)(1-\beta o_0)+\mu\beta\}/m\) | \((\beta o_0,\beta o_1)\) |
| \(P\) | \((1-\beta o_1)/m\) | \((\beta o_1,\beta o_1)\) |

No empate residual \(E/P\), todas as coordenadas usam o mesmo peso.

## Prova da equivalência de payoffs com o ciclo

Na construção cíclica histórica, cada fraco \(j\) aparece como parceiro em
exatamente \(r_B\) das \(m-1\) propostas feitas por outros fracos. Na loteria
uniforme, sua incidência agregada esperada é

\[
(m-1)\frac{r_B}{m-1}=r_B.
\]

O payoff do proponente, os pagamentos quando parceiro, a probabilidade de
reconhecimento e os payoffs de \(H\) coincidem. Logo os vetores de payoffs
interinos são idênticos, identidade por identidade.

Isso não identifica distribuições terminais de coalizões rotuladas. A nova
derivação usa literalmente a loteria uniforme em sua assinatura; o ciclo é
apenas uma implementação computacional de payoffs.

## Codomínio e mensurabilidade

O codomínio canônico é a união disjunta

\[
X_M=\{E,S,P\}\cup(\{EP\}\times[0,1]),
\]

com a sigma-álgebra Borel. \((EP,\alpha)\) mistura os representantes uniformes
\(E\) e \(P\) somente no ponto de empate residual. Uma seleção

\[
\chi:[0,1]\to X_M
\]

é Borel e escolhe apenas rótulos permitidos por \(C_M(\mu)\). Os payoffs dos
rótulos \(E/P\) são constantes em \(\mu\), \(c_S(\mu)\) é afim em \(\mu\), e
os payoffs e kernels de \((EP,\alpha)\) são afins em \(\alpha\). Portanto os
mapas de payoff e o kernel terminal canônico são Borel.

# Lema 2 — colapso do ballot e atingimento condicional

Em unidades de \(A_M\), defina

\[
r_\chi(\mu)=\beta c_\chi(\mu),
\qquad
D_{\chi\theta}(\mu)=\beta h_{\chi\theta}(\mu),
\qquad
A_\chi(\mu)=1-k r_\chi(\mu).
\]

Pela cláusula M, todos os vetores pivotais depois de uma proposta com posterior
\(\mu\) usam o mesmo membro literal. Pela regra as-if-pivotal e por \(T^Y\),

\[
j\text{ vota sim}\quad\Longleftrightarrow\quad
x_j\ge r_\chi(\mu).
\]

A proposta passa se e somente se ao menos \(k\) pagamentos cobrem esse preço.

Para \(\mu\) e \(\chi(\mu)\) fixados,

\[
\operatorname{Acc}(\mu,\chi)
=\bigcup_{Q:|Q|=k}\bigcap_{j\in Q}
  \{x_j\ge r_\chi(\mu)\}
\]

é união finita de subconjuntos fechados do compacto \(Y\), logo é compacto. O
melhor acordo paga \(r_\chi(\mu)\) a algum conjunto \(Q\) de tamanho \(k\),
zero aos demais e deixa \(A_\chi(\mu)\) para \(H\). A proposta
\((z_H=1,x=0)\) é claramente rejeitada e atinge
\(D_{\chi\theta}(\mu)\). Assim, condicionalmente a um posterior fixo, o valor
ótimo do tipo \(\theta\) é

\[
\max\{A_\chi(\mu),D_{\chi\theta}(\mu)\},
\]

e ambos os candidatos são atingidos.

# Finding 1 — fechamento condicional, não global

A alegação de que o conjunto global de propostas aceitas é fechado é falsa,
mesmo sob M/S/B.

Tome

\[
N=5,\quad m=4,\quad k=2,\quad
\beta=0{,}9,\quad o_0=0{,}1,\quad o_1=0{,}9,
\quad 0<\nu<1,\quad \nu_{\mathrm{off}}=0.
\]

Em \(\mu=0\), o ramo é \(S\) e

\[
r(0)=0{,}9\frac{1-0{,}9\cdot0{,}1}{4}=0{,}20475,
\qquad
A(0)=1-2r(0)=0{,}5905.
\]

Em \(\mu=1\), o ramo é \(E\),

\[
r(1)=0{,}225,
\qquad
D_0(1)=0{,}09,
\qquad
D_1(1)=0{,}81.
\]

O tipo baixo oferece \(0{,}20475\) a dois membros de uma coalizão \(Q_0\),
retém \(0{,}5905\) e faz acordo. O tipo alto envia uma proposta distinta com a
mesma parcela e pagamentos para outra coalizão \(Q_1\); essa proposta é
rejeitada em \(\mu=1\), pois \(0{,}20475<0{,}225\).

Os incentivos são

\[
\theta=0: 0{,}5905>0{,}09,
\qquad
\theta=1: 0{,}81>0{,}5905
\quad\text{e}\quad
0{,}81>0{,}729.
\]

Logo há um PBE separating. Entretanto, propostas off-path que elevam em
\(\varepsilon_n>0\) um pagamento de \(Q_1\) e reduzem \(z_H\) na mesma
quantia são aceitas sob \(\nu_{\mathrm{off}}=0\) e convergem para o sinal
on-path rejeitado do tipo alto. O conjunto global de aceitação não é fechado.

O resultado de existência abaixo não usa fechamento global nem
semicontinuidade superior global.

# Teorema 1 — existência de PBE em todo o domínio

Defina

\[
Z_E=1-\frac{k\beta}{m},
\qquad
T=\frac{Z_E}{\beta}
=\frac1\beta-\frac{k}{m}.
\]

Como \(q=k+1\le m\) e \(\beta<1\), vale \(T>1/m\).

**Teorema AM-MSB-E.** Para toda primitiva admissível e todo prior existe ao
menos um PBE de \(A_M\) sob M/S/B. Nos endpoints,
\(\nu_{\mathrm{off}}=\nu\). No interior, as seguintes testemunhas cobrem todo
o domínio:

| região | \(\nu_{\mathrm{off}}\) da testemunha | outcome |
|---|---:|---|
| \(o_1\le T\) | \(\nu\) | pooling com acordo |
| \(o_0\le T\le o_1\) | \(1\) | baixo acorda, alto atrasa |
| \(T\le o_0\) | qualquer | ambos atrasam |

As fronteiras podem usar qualquer testemunha adjacente.

## Prova: região \(o_1\le T\)

Escolha \(\nu_{\mathrm{off}}=\nu\) e o mesmo representante uniforme
\(B(\nu)\) on e off path. Ambos os tipos fazem o melhor acordo canônico e
recebem \(A_\nu\).

No ramo \(E\),

\[
D_1=\beta o_1\le\beta T=Z_E=A_E.
\]

No ramo \(S\),

\[
D_1=\beta^2o_1<Z_E<A_S.
\]

No ramo \(P\),

\[
D_1=\beta^2o_1<Z_E<A_P.
\]

Logo nem o tipo alto prefere qualquer rejeição ou desvio off-path ao acordo.
Como \(D_1\ge D_0\), o mesmo vale para o tipo baixo.

## Prova: região \(o_0\le T\le o_1\)

Escolha \(\nu_{\mathrm{off}}=1\). Como \(T>1/m\), em \(\mu=1\) o ramo é
\(E\), e

\[
A_1=Z_E=\beta T,
\qquad
D_{0,1}=\beta o_0\le Z_E,
\qquad
D_{1,1}=\beta o_1\ge Z_E.
\]

Em \(\mu=0\), o ramo é \(S\) se \(o_0\le1/m\) e \(E\) caso contrário; em
ambos os casos \(A_0\ge Z_E\). Faça o tipo baixo obter o acordo
\(z=Z_E\) e o tipo alto provocar rejeição em \(\mu=1\). O baixo não prefere
rejeitar nem imitar; o alto não prefere o acordo do baixo nem qualquer desvio
off-path.

## Prova: região \(T\le o_0\)

Aqui \(o_0\ge T>1/m\); portanto \(E\) é o único ramo em todo posterior. Para
cada tipo e posterior,

\[
A_p=Z_E,
\qquad
D_{\theta p}=\beta o_\theta\ge Z_E.
\]

Pooling ou separating com atraso satisfaz as melhores respostas para qualquer
\(\nu_{\mathrm{off}}\). As três regiões cobrem todo
\(0<o_0<o_1<1\), completando a prova.

# Teorema 2 — classificação completa dos PBEs puros

Fixe \(0<\nu<1\), \(\nu_{\mathrm{off}}\) e uma seleção markoviana anônima
\(\chi\). Abrevie

\[
A_p=A_\chi(p),
\qquad
D_{\theta p}=D_{\chi\theta}(p),
\qquad
O_\theta=\max\{A_{\mathrm{off}},D_{\theta,\mathrm{off}}\}.
\]

Como \(D_{1p}\ge D_{0p}\), \(O_1\ge O_0\).

## Pooling

### Acordo pooling

Existe se e somente se

\[
O_1\le A_\nu.
\]

Todo \(z\in[O_1,A_\nu]\) pode ser implementado por um pacote aceito e dá o
mesmo payoff aos dois tipos.

### Atraso pooling

Existe se e somente se

\[
D_{0\nu}\ge O_0,
\qquad
D_{1\nu}\ge O_1.
\]

Uma proposta claramente rejeitada implementa
\((D_{0\nu},D_{1\nu})\).

## Separating

### Acordo dos dois tipos

Cada tipo pode imitar literalmente a proposta do outro; logo as parcelas de
\(H\) precisam coincidir. A classe existe se e somente se

\[
O_1\le\min\{A_0,A_1\}.
\]

Todo

\[
z\in[O_1,\min\{A_0,A_1\}]
\]

é implementável.

### Tipo baixo acorda e tipo alto atrasa

Existe se e somente se

\[
D_{1,1}\ge O_1
\]

e

\[
\max\{D_{0,1},O_0\}
\le
\min\{A_0,D_{1,1}\}.
\]

Todo

\[
z\in
[\max\{D_{0,1},O_0\},\min\{A_0,D_{1,1}\}]
\]

implementa
\((V_H^0,V_H^1)=(z,D_{1,1})\).

### Tipo baixo atrasa e tipo alto acorda

É impossível. Imitação bilateral exigiria

\[
D_{0,0}\ge z\ge D_{1,0},
\]

mas \(D_{1,0}>D_{0,0}\).

### Ambos atrasam

Existe se e somente se

\[
D_{0,0}\ge D_{0,1},
\qquad
D_{1,1}\ge D_{1,0},
\]

\[
D_{0,0}\ge O_0,
\qquad
D_{1,1}\ge O_1.
\]

Os payoffs são \((D_{0,0},D_{1,1})\).

## Prova de completude

Em perfil puro interior, propostas iguais geram posterior \(\nu\) e o mesmo
resultado de ballot. Propostas distintas geram posteriores \(0\) e \(1\).
Cada tipo pode imitar o sinal do outro; qualquer outro pacote é não
disciplinado e enfrenta \(\nu_{\mathrm{off}}\). Pooling ou separating e as
quatro combinações acordo/atraso esgotam logicamente os outcomes. A combinação
atraso-baixo/acordo-alto é contraditória. As desigualdades acima são exatamente
factibilidade, imitação bilateral e ausência de desvio off-path. Portanto são
necessárias e suficientes.

# Teorema 3 — endpoints do prior

Se \(\nu\in\{0,1\}\), o suporte do prior força
\(\mu(s)=\nu_{\mathrm{off}}=\nu\) em todo \(Y\). Para cada tipo, inclusive o
tipo de probabilidade zero, defina

\[
M_\theta=\max\{A_\nu,D_{\theta\nu}\}.
\]

O tipo usa apenas propostas que atingem \(M_\theta\): acordo se
\(A_\nu>D_{\theta\nu}\), atraso se a desigualdade é inversa e qualquer mistura
Borel entre melhores acordos e rejeições em igualdade. Estratégias dos dois
tipos podem coincidir ou separar sem alterar a crença.

Não se divide por \(\nu\) nem por \(1-\nu\). A estratégia contrafactual do
tipo de probabilidade zero continua registrada, mas apenas o tipo com massa
positiva entra no payoff interino anterior ao sinal.

# Teorema 4 — classificação necessária e suficiente dos PBEs mistos

Fixe \(0<\nu<1\). Sejam \(\sigma_0,\sigma_1\) medidas Borel de propostas e

\[
\lambda=(1-\nu)\sigma_0+\nu\sigma_1,
\qquad
S=\operatorname{supp}(\lambda).
\]

Considere o objeto reduzido

\[
R=(\sigma_0,\sigma_1,\lambda,\pi,\chi,a,u_0,u_1),
\]

com as seguintes coordenadas conjuntas:

1. \(\pi(y)\) é o limite local de Bayes em todo \(y\in S\); se o limite não
   existe em algum ponto disciplinado, o objeto é inadmissível;
2. \(\pi(y)=\nu_{\mathrm{off}}\) em \(Y\setminus S\);
3. \(\chi(\pi)\) é Borel, markoviana e escolhe no codomínio canônico \(X_M\)
   apenas o ramo permitido por \(C_M(\pi)\);
4. \(a(y)=1\) se e somente se ao menos \(k\) pagamentos cobrem
   \(r_\chi(\pi(y))\);
5. o kernel terminal é o kernel Borel do mesmo representante uniforme
   \(\chi(\pi(y))\);
6. o payoff de desvio é

   \[
   u_\theta(y)=
   \begin{cases}
   z_H(y),&a(y)=1,\\
   D_{\chi\theta}(\pi(y)),&a(y)=0.
   \end{cases}
   \]

Em \(\lambda\)-quase todo ponto, Bayes também implica

\[
\frac{d\sigma_1}{d\lambda}=\frac{\pi}{\nu},
\qquad
\frac{d\sigma_0}{d\lambda}=\frac{1-\pi}{1-\nu},
\qquad
\int\pi\,d\lambda=\nu.
\]

Essas identidades quase em toda parte não substituem o limite local exigido em
cada ponto disciplinado.

Para o suporte público \(S\), defina o valor exato dos desvios não
disciplinados:

\[
O_\theta(S)=\sup_{y\in Y\setminus S}u_\theta^{\mathrm{off}}(y),
\]

com supremo do conjunto vazio igual a \(-\infty\). Em suportes finitos, o
complemento é denso e

\[
O_\theta(S)=\max\{A_{\mathrm{off}},D_{\theta,\mathrm{off}}\}.
\]

Em suportes gerais, não se pode substituir o supremo pelo payoff de um pacote
canônico que talvez pertença ao próprio suporte.

**Teorema AM-MSB-MIX.** O objeto \(R\) gera um PBE sob M/S/B se e somente se,
para \(\theta=0,1\), existe um valor \(V_\theta\) tal que

\[
u_\theta(y)\le V_\theta
\quad\text{para todo }y\in S,
\]

\[
u_\theta(y)=V_\theta
\quad\text{para }\sigma_\theta\text{-quase todo }y,
\]

\[
V_\theta\ge O_\theta(S),
\]

além das condições 1--6 acima.

## Prova de necessidade

Cada tipo pode escolher qualquer sinal público alcançado, inclusive um sinal
usado apenas pelo outro tipo, e pode escolher qualquer pacote fora do suporte.
Logo nenhum ponto de \(S\) pode render mais que \(V_\theta\); toda proposta
usada pelo tipo precisa render exatamente \(V_\theta\); e o valor precisa
dominar o supremo exato dos desvios em \(Y\setminus S\). Bayes local, M, S, B e
o ballot são condições do assessment e também são necessários.

## Prova de suficiência

Prescreva os votos de corte do Lema 2 e a continuação literal
\(\chi(\pi(y))\). Bayes e B valem por construção. Em sinais alcançados,
nenhuma ação supera \(V_\theta\); fora do suporte, nenhuma ação supera
\(O_\theta(S)\); e cada \(\sigma_\theta\) se apoia em melhores respostas. Como
todas as coordenadas pertencem à mesma tupla, não há recombinação marginal.
Portanto estratégias, crenças, votos e continuações formam um PBE.

# Teorema 5 — assinatura downstream completa

Para cada objeto reduzido, defina

\[
\operatorname{Sig}(R)=
(V_H^0,V_H^1,(W_j)_{j\in W},
 p_A^0,p_A^1,p_D^0,p_D^1,Q_0,Q_1,G_\pi),
\]

onde

\[
W_j=\int\left[a(y)x_j(y)
 +(1-a(y))r_\chi(\pi(y))\right]\,\lambda(dy),
\]

\[
p_A^\theta=\int a(y)\,\sigma_\theta(dy),
\qquad
p_D^\theta=1-p_A^\theta.
\]

\(Q_\theta\) é a distribuição terminal por tipo. Em acordo, é o pushforward
do pacote implementado; em atraso, mistura os kernels terminais literais do
mesmo representante \(\chi(\pi(y))\). \(G_\pi\) é a distribuição conjunta de
sinais alcançados e posteriores, o pushforward de \(\lambda\) por
\(y\mapsto(y,\pi(y))\).

Nos endpoints, a assinatura é construída com medidas \(\sigma_0,\sigma_1\)
apoiadas nos argmax de cada tipo, posterior constante e sem fórmulas de
Radon--Nikodym que dividam por probabilidade zero.

A correspondência conjunta completa é

\[
\{\operatorname{Sig}(R):0<\nu<1,\ R\text{ satisfaz o Teorema 4}\}
\]

unida a

\[
\{\operatorname{Sig}_{\partial}(R_{\partial}):
  \nu\in\{0,1\},\ R_{\partial}\text{ satisfaz o Teorema 3}\}.
\]

Não se forma produto cartesiano de marginais nem se combinam payoffs,
probabilidades, outcomes e crenças provenientes de equilíbrios distintos.

# Teorema 6 — não existe redução finita geral das assinaturas

Mesmo para \((\nu,\nu_{\mathrm{off}})\) fixado, pode haver incontavelmente
muitas assinaturas.

## Variação por coalizões

No PBE do Finding 1, o tipo baixo pode misturar com qualquer peso
\(p\in[0,1]\) entre duas coalizões aceitas diferentes em \(\mu=0\). Os
payoffs de \(H\) e seus incentivos permanecem iguais, mas os payoffs interinos
por identidade e a distribuição terminal de alocações variam continuamente
com \(p\).

## Variação atomless de Bayes

Tome

\[
N=5,\quad \beta=0{,}9,\quad o_0=0{,}7,\quad o_1=0{,}8,
\quad \nu=\nu_{\mathrm{off}}=0{,}5.
\]

O ramo \(E\) é único para todo posterior. O melhor acordo dá \(0{,}55\),
enquanto rejeição dá \(0{,}63\) ao tipo baixo e \(0{,}72\) ao alto. Na linha
de propostas rejeitadas \(s(t)=(t,0,0,0,0)\), \(t\in[0,1]\), tome
\(\lambda\) uniforme e

\[
\pi(t)=0{,}25+0{,}5t,
\]

\[
\sigma_1(dt)=(0{,}5+t)dt,
\qquad
\sigma_0(dt)=(1{,}5-t)dt.
\]

Bayes local vale em todo ponto disciplinado; M seleciona sempre o mesmo
representante uniforme \(E\); B fixa \(0{,}5\) fora do suporte. Todo sinal
usado é uma melhor resposta rejeitada. Variações contínuas admissíveis de
\(\pi\) geram valores distintos de \(G_\pi\). Portanto os objetos on-path não
podem ser eliminados em favor de uma lista finita.

# Semipooling e famílias históricas

Considere uma família em que o tipo baixo sempre envia um sinal aceito
\(s_A\), enquanto o alto envia \(s_A\) com probabilidade
\(\lambda\in(0,1)\) e um sinal rejeitado \(s_D\) no restante. Então

\[
\mu_A=
\frac{\nu\lambda}{(1-\nu)+\nu\lambda}\in(0,\nu),
\qquad
\mu(s_D)=1,
\qquad
\nu_{\mathrm{off}}=1.
\]

O acordo comum dá \(z=\beta o_1\). O alto fica indiferente entre o acordo e a
rejeição \(E\) em \(\mu=1\); o baixo prefere o acordo. A família sobrevive se
e somente se, dentro dessa construção,

\[
\beta o_1\ge Z_E
\qquad\text{e}\qquad
A_\chi(\mu_A)\ge\beta o_1.
\]

O exemplo histórico

\[
N=5,\quad\beta=0{,}9,\quad o_0=0{,}1,\quad o_1=0{,}7,
\quad\nu=0{,}5,\quad\lambda=0{,}25
\]

é rejeitado sob S: a capacidade de acordo uniforme é \(0{,}5914\), abaixo de
\(\beta o_1=0{,}63\). A construção antiga comprava votos assimetricamente
baratos e não pertence à classe anônima atual.

Nas fronteiras \(o_1=T\) e \(o_0=T<o_1\), as famílias de mistura descritas
pelas igualdades adjacentes sobrevivem. Nos endpoints, mistura é permitida
somente entre melhores respostas do tipo.

# Limites de payoff e impossibilidades

Em todo PBE M/S/B,

\[
\max\{Z_E,\beta^2o_\theta\}
\le V_H^\theta\le1,
\]

\[
0\le V_H^1-V_H^0
\le\beta(o_1-o_0).
\]

## Prova do limite inferior

\(H\) pode pagar \(\beta/m\) a quaisquer \(k\) fracos e reter \(Z_E\).
Como \(r_\chi(\mu)\le\beta/m\) em todo ramo e posterior, essa proposta passa
para qualquer crença. Alternativamente, \((1,0,\ldots,0)\) é rejeitada para
todo posterior e dá pelo menos \(\beta^2o_\theta\). O payoff não pode exceder
o bolo unitário.

## Prova do limite entre tipos

Uma proposta aprovada dá a mesma parcela aos dois tipos. Numa rejeição, a
diferença entre tipos é \(\beta(o_1-o_0)\) no ramo \(E\),
\(\beta^2(o_1-o_0)\) no ramo \(S\) e zero no ramo \(P\). Maximização e mistura
preservam o intervalo.

Além disso:

1. pooling não pode produzir acordo para um tipo e atraso para outro;
2. separating com acordo dos dois tipos exige a mesma parcela de \(H\);
3. atraso do baixo e acordo do alto é impossível;
4. atraso dos dois tipos exige \(o_0>1/m\);
5. se o tipo alto usa uma proposta aprovada com probabilidade positiva, então
   \(V_H^0=V_H^1\), pois o baixo pode imitá-la e a monotonicidade entre tipos dá
   a desigualdade oposta.

# Certificado histórico do contrato anterior

O certificado negativo anterior permanece verdadeiro e deve ser preservado
com escopo histórico.

Na instância

\[
N=5,\quad m=4,\quad k=2,\quad
\beta=0{,}9,\quad o_0=0{,}30,\quad o_1=0{,}40,
\]

o contrato original permitia um seletor Borel dependente da proposta. Ele
usava uma continuação de votos baratos apenas na sequência

\[
s_n=\left(\frac{51}{100}-\frac{1}{100n},
          \frac{6}{25},\frac{6}{25},0,0\right)
\]

e uma continuação mais cara fora dela. Para todo \(n\),

\[
g_\theta(s_n)<\frac{51}{100},
\qquad
g_\theta(s_n)\longrightarrow\frac{51}{100}.
\]

Nenhuma proposta atinge o supremo. Para qualquer medida de propostas
\(\sigma\),

\[
\int g_\theta(s)d\sigma(s)<\frac{51}{100},
\]

porque \(51/100-g_\theta\) é estritamente positivo em todo ponto. Logo não há
melhor resposta pura nem mista para esse seletor admissível no contrato
anterior.

Sob M, o seletor é inadmissível porque varia entre propostas com o mesmo estado
futuro. Sob B, ele não pode ser reconstruído recodificando a proposta em
crenças não disciplinadas. O certificado não é um resultado de não existência
sob M/S/B.

# Mapa dos claims a auditar

Audite cada linha de forma independente.

| Claim | Conteúdo | Estatuto candidato |
|---|---|---|
| AMX-MSB-001 | representante uniforme é membro literal de \(C_M\) | PROVED |
| AMX-MSB-002 | preço comum e cutoff exato do ballot | PROVED |
| AMX-MSB-003 | atingimento condicional a posterior fixo | PROVED |
| AMX-MSB-004 | contraexemplo ao fechamento global | PROVED NEGATIVE |
| AMX-001 | existência de ao menos um PBE em todo o domínio | PROVED |
| AMX-002 | pooling com acordo | PROVED |
| AMX-MSB-005 | pooling com atraso | PROVED |
| AMX-MSB-006 | separating com acordo dos dois tipos | PROVED |
| AMX-003 | baixo acorda e alto atrasa | PROVED |
| AMX-MSB-007 | baixo atrasa e alto acorda é impossível | PROVED NEGATIVE |
| AMX-004 | separating com atraso dos dois tipos | PROVED |
| AMX-005 | endpoints do prior | PROVED |
| AMX-006 | família semipooling reescopada | PROVED CONDITIONAL |
| AMX-MSB-008 | antigo exemplo semipooling falha sob S | PROVED NEGATIVE |
| AMX-007 | mistura nas fronteiras | PROVED |
| AMX-008 | antiga geometria assimétrica não pertence ao protocolo atual | PROVED NEGATIVE |
| AMX-009 | antigo intervalo de payoffs assimétricos não é família atual | PROVED NEGATIVE |
| AMX-010 | limites globais de payoff | PROVED |
| AMX-011 | acordo do tipo alto força payoff diagonal | PROVED |
| AMX-012 | impossibilidades puras | PROVED |
| AMX-013 | 2891 verificações mecânicas | MECHANICAL EVIDENCE ONLY |
| AMX-014 | classificação completa dos PBEs puros | PROVED |
| AMX-015 | caracterização necessária e suficiente dos PBEs mistos | PROVED |
| AMX-MSB-009 | não existe redução finita geral das assinaturas | PROVED NEGATIVE |
| AMX-016 | correspondência conjunta exata de assinaturas | PROVED |
| AMX-NEG-001 | não atingimento no contrato original | PROVED HISTORICAL |

# Testes adversariais obrigatórios

Além de qualquer teste próprio, execute conceitualmente os seguintes:

1. confirme que a loteria uniforme está literalmente apoiada no argmax
   permitido por AX-CM-3, não apenas que produz payoffs plausíveis;
2. verifique que o ciclo e a loteria uniforme têm payoffs iguais, mas que suas
   distribuições terminais não foram identificadas;
3. confirme que todas as coordenadas de cada assessment vêm do mesmo membro
   literal e do mesmo peso residual \(E/P\);
4. confira que \(\beta\) é aplicado exatamente uma vez ao transportar \(C_M\)
   para \(A_M\);
5. tente refutar a fórmula de \(c_S(\mu)\) e sua mensurabilidade conjunta;
6. verifique o cutoff em todo ramo, nas igualdades e nas duas paridades de
   \(N\);
7. reproduza o contraexemplo ao fechamento global e confirme que ele próprio é
   um PBE M/S/B;
8. teste a cobertura das três regiões de existência, incluindo
   \(o_0=T\), \(o_1=T\), \(T>1\), \(o_0=1/m\) e \(o_1=1/m\);
9. para cada classe pura, derive necessidade e suficiência por imitação,
   factibilidade e desvio off-path;
10. tente construir a classe atraso-baixo/acordo-alto;
11. no teorema misto, confira a diferença entre condições em todo ponto
    disciplinado e identidades quase em toda parte;
12. verifique se \(O_\theta(S)\) usa corretamente o complemento do suporte e
    se não é substituído por um pacote que pertence a \(S\);
13. audite endpoints sem dividir por \(\nu\) ou \(1-\nu\), preservando a
    estratégia contrafactual do tipo de probabilidade zero;
14. tente reduzir as assinaturas a um conjunto finito e confronte as duas
    famílias contínuas apresentadas;
15. confira que o exemplo semipooling antigo realmente falha sob o
    representante uniforme;
16. rederive os limites de payoff sem usar crença ou continuação conveniente;
17. confirme que o certificado \(51/100\) permanece válido apenas no domínio
    anterior e que M/B eliminam os canais exatos que ele usa;
18. verifique que \(0<o_0<o_1<1\) e \(o_1\le\bar y\le1\) são preservados em
    todos os claims.

# Formato obrigatório da consulta

Produza o relatório nesta ordem:

1. **Conclusão técnica consultiva:** `PASS`, `FAIL` ou `UNRESOLVED` para o
   pacote exato. Esse rótulo serve apenas para resumir a consulta e não tem
   efeito de gate.
2. **Contagens:** número de achados `critical`, `important` e `minor`.
3. **Reconstrução caridosa:** explique em linguagem natural o problema antigo,
   o papel de M/S/B e a contribuição matemática da rederivação.
4. **Matriz claim por claim:** uma linha para cada claim da seção **Mapa dos
   claims a auditar**, com
   `PASS`, `FAIL`, `UNRESOLVED` ou `MECHANICAL EVIDENCE ONLY` e justificativa.
5. **Auditoria dos axiomas consumidos:** não os reprove; diga apenas se cada uso
   em \(A_M\) é literal e fiel.
6. **Resultados e lógica das provas:** membership, ballot, existência,
   classificação pura, classificação mista, endpoints, assinatura e limites.
7. **Fronteiras e contraexemplos:** reporte explicitamente todos os casos de
   borda testados e qualquer contraexemplo encontrado.
8. **Separação entre escolhas e teoremas:** distinga objeções a M/S/B de erros
   que fariam um resultado não seguir dessas cláusulas.
9. **Achados principais:** no máximo sete, ordenados por gravidade. Para cada
   FAIL ou UNRESOLVED, forneça prova, contraexemplo mínimo ou definição faltante
   e explique a consequência downstream.
10. **Correções mínimas:** proponha texto ou fórmula substituta exata; não
    redesenhe o jogo silenciosamente.
11. **Recomendação de consumo:** diga se os bytes podem ser integrados e
    posteriormente consumidos por \(AC\), condicionado a uma auditoria própria
    de \(A_U\).
12. **Resumo para o autor:** explique, sem jargão excessivo, por que o pacote é
    seguro ou não e qual decisão autoral ainda seria necessária.

Não dê PASS por deferência às revisões anteriores. Não dê FAIL apenas porque
M/S/B não é sua modelagem preferida. Um defeito de prova exige mostrar que o
claim não segue das primitivas fixadas. Uma objeção substantiva às primitivas
deve ser rotulada separadamente como `MODELING-CHOICE CONCERN`.

# Proveniência, validação e bytes exatos

## Snapshot

- base histórica: `b675a372d7c92703335e5c70a18077e9151f254d`;
- commit que importou a emenda aprovada: `4bda7b71e1e6d4e836912b533fef8b28ee044c71`;
- commit do pacote aprovado: `38a3939f1796e85459bddca1356bbc8bc1c61d6e`;
- branch: `agenda-extension-am-msb`;
- escopo: somente \(A_M\); nenhum arquivo N1--N7, \(A_U\), \(AC\), \(AR\),
  manuscrito ou tag foi alterado.

## Fontes normativas e congeladas

- emenda M/S/B aprovada:
  `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`;
- contrato-base remanescente:
  `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4`;
- interface congelada \(C_M\):
  `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- certificado exploratório histórico:
  `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f`.

## Manifesto revisado e aprovado

SHA-256 do manifesto de revisão:

`1f2cf9bebc4ab9ac82748df5a4a9aeac7bd5d05576100cdb58eb11eb18d8d773`.

Os quatro arquivos substantivos fixados por ele são:

| Arquivo | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_M_msb_results.md` | `eea6c603c1f43f23df7995d55912991624207d17624975ea40cccd12583c4cf0` |
| `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv` | `5d42bf5a113716687e95785bffc572cc5e874674c0bd61e6338f7f6832f7cc4e` |
| `scripts/verify_agenda_extension_A_M_msb.R` | `794fc08d5459b840237325e1f18f7c0431a52b82b2f8efa3b4ae011e1b0d250a` |
| `quality_reports/2026-08-29_A_M_msb_rederivation_report.md` | `cbbedfd5b38874becd0b16beb3f9f1e33ed22c3bcf31e50338f80d27c16df9c5` |

## Evidência mecânica e revisões anteriores

O verificador separado reportou

```text
SUMMARY | 2891 PASS | 0 FAIL
```

Ele testa identidades, exemplos, grades paramétricas, domínio, aritmética de
Bayes e regressões; não prova existência, completude, mensurabilidade simbólica
ou ausência de todos os desvios.

As rodadas 1 e 2 de revisão falharam e produziram reparos. A rodada 3 teve duas
revisões formais independentes somente leitura, ambas `PASS 0/0/0`, sobre o
manifesto acima. Esta consulta web é deliberadamente suplementar e não formal.

Qualquer mudança futura em M, S, B, Bayes local, desempates, \(C_M\), assinatura
downstream ou nos quatro arquivos substantivos invalida a cobertura dos hashes.
