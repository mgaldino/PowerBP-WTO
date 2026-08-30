---
title: "A_T: efeito causal estrutural da etapa obrigatória de agenda"
subtitle: "Pacote autocontido para consulta técnica externa não formal — ChatGPT Web"
date: "30 de agosto de 2026"
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

# Mandato ao ChatGPT Web

Você é um leitor técnico externo de uma extensão de um modelo formal de
barganha política. Empregue rigor de teoria dos jogos, análise de
correspondências e desenho fatorial, mas **não assuma o papel institucional de
parecerista formal do projeto**.

Sua resposta será uma **consulta técnica externa não formal**. Ela:

- não é parecer formal independente;
- não reabre nem fecha um gate;
- não concede PASS, aprovação autoral ou congelamento;
- não substitui as revisões formais independentes já realizadas;
- não autoriza implementação, migração ao manuscrito, tag, merge ou push;
- serve como insumo suplementar para uma decisão autoral posterior.

Não use as revisões internas anteriores como prova. Tente refutar os resultados
diretamente a partir das definições e provas reproduzidas neste pacote. Ao mesmo
tempo, não rederive os resultados congelados do jogo-base ou dos nós anteriores
que este documento declara como inputs. Se discordar de uma escolha de
comparação, separe claramente **MODELING CHOICE** de **MATHEMATICAL DEFECT**.

Produza um arquivo Markdown UTF-8 chamado
`2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AT_msb.md`. Se a
interface não puder criar um arquivo baixável, devolva o Markdown completo, sem
texto introdutório fora do documento. No título e na primeira seção da resposta,
repita que o produto é uma **consulta técnica externa não formal**.

# Pergunta substantiva

O paper já comparava maioria e unanimidade sem poder de agenda do hegemon. A
extensão introduziu uma data anterior $A$, na qual o hegemon $H$ é obrigado
a fazer uma proposta. Os resultados anteriores derivaram:

1. o jogo de agenda sob maioria e unanimidade;
2. os payoffs sob informação completa;
3. as rendas informacionais dentro de cada regra;
4. a interação entre agenda e informação.

Faltava responder diretamente:

> **Mantendo o tipo de $H$ privado, qual é o efeito causal estrutural de
> inserir a etapa obrigatória de agenda, em comparação com o mesmo jogo de
> informação privada sem agenda?**

E, adicionalmente:

> **Esse efeito é maior sob unanimidade ou sob maioria, e de que componentes
> depende a resposta?**

# Perguntas específicas à consulta

Audite prioritariamente:

1. O desenho $2\times2$ cruza corretamente agenda e regime informacional?
2. O estimando
   
   \[
   T_g^\theta=V_g^{A,\theta}-\beta V_g^{N,R1,\theta}
   \]
   
   é a comparação correta entre “agenda sob informação privada” e “informação
   privada apenas”, na data econômica comum $A$?
3. A identidade
   
   \[
   T_g^\theta=D_g^\theta+I_g^\theta
   \]
   
   segue sem dupla contagem ou desconto duplicado?
4. As fórmulas por ramos de $D_M(o)$ e
   $\Delta D(o)=D_U(o)-D_M(o)$ estão corretas, inclusive em
   $o=1/m$ e $o=\tau_M$?
5. A classificação de $T_U$ está completa, inclusive:
   - os dois lugares em que zero pode aparecer;
   - as duas famílias em que o efeito é `none`;
   - a distinção entre efeito por tipo e efeito ex ante nos endpoints?
6. A representação
   
   \[
   T_M^{01}=D_M^{01}+I_M^{01}
   \]
   
   preserva corretamente a multiplicidade e justifica a ausência de sinal
   geral sob maioria?
7. A comparação institucional
   
   \[
   \Delta T^\theta=\Delta D^\theta+\Delta I^\theta
   \]
   
   está corretamente interpretada?
8. O contraste diagonal $Q_g$ está corretamente separado do efeito causal de
   agenda?
9. A linguagem causal deixa claro que o tratamento é uma **etapa anterior e
   obrigatória de proposta**, e não o valor de uma opção facultativa?
10. Existem corolários, condições suficientes ou resultados mais fortes que
    seguem logicamente do material reproduzido, sem selecionar equilíbrios ou
    acrescentar hipóteses?

# Resumo intuitivo para o leitor

## O que muda quando se introduz agenda

Sem agenda, o jogo começa em (R1). Com agenda, existe uma data anterior (A)
na qual (H) precisa propor. Não há ação “não propor”, renunciar ou passar.
Se sua proposta é rejeitada, o jogo segue para a continuação em (R1).

Portanto o tratamento possui dois elementos inseparáveis dentro do game form:

1. (H) move-se uma data antes;
2. sob informação privada, sua proposta pode revelar informação e modificar
   crenças e continuações.

O efeito não deve ser justificado genericamente como “valor de uma opção”,
porque a proposta é obrigatória. Qualquer não negatividade precisa seguir da
correspondência de equilíbrio derivada, não de um argumento abstrato segundo o
qual (H) poderia ignorar a oportunidade.

## A decomposição central

O efeito total da agenda sob informação privada pode ser separado em:

1. o efeito da agenda quando o tipo é conhecido;
2. a mudança provocada pela agenda no valor da informação privada.

Formalmente,

\[
\underbrace{T_g^\theta}_{
\substack{\text{efeito total da agenda}\\
\text{sob informação privada}}}
=
\underbrace{D_g^\theta}_{
\substack{\text{efeito da agenda no benchmark}\\
\text{de informação completa}}}
+
\underbrace{I_g^\theta}_{
\substack{\text{interação entre}\\
\text{agenda e informação}}}.
\]

O termo $D_g$ às vezes foi chamado de componente “público”. Aqui evitamos
essa abreviação: “público” significava apenas que o tipo de (H) era de
conhecimento público. $D_g$ não é um bem público nem um efeito institucional
puro; ele é o efeito da etapa de agenda no benchmark de informação completa.

## Intuição sob unanimidade

Sob unanimidade, qualquer acordo precisa comprar todos os Estados fracos. No
benchmark de informação completa, a proposta mínima de (H) é aprovada
imediatamente e gera um ganho de antecipação exatamente igual a $1-\beta$.

Sob informação privada, a proposta obrigatória pode reduzir a renda
informacional de (H). Ainda assim, nas células em que os dois braços do
contrafactual possuem PBE puro, essa perda nunca ultrapassa o ganho de
informação completa. O efeito total é, portanto, fracamente positivo.

Isso é um resultado específico das correspondências congeladas. Não é uma
propriedade universal da agenda em jogos de sinalização.

## Intuição sob maioria

Sob maioria, $H$ precisa comprar apenas os $k=q-1$ votos fracos que
completam uma coalizão mínima. Quando sua outside option é baixa ou moderada, a
etapa anterior permite acordo e gera ganho direto. Quando a outside option é
alta, (H) pode preferir deliberadamente uma proposta rejeitada e receber a
continuação. Nesse caso o efeito da agenda no benchmark de informação completa
é zero.

Sob informação privada, a interação informacional pode reforçar ou contrariar
esse ganho. Como a correspondência de maioria permanece set-valued, não há um
sinal geral sem escolher equilíbrios adicionais.

## Quando a agenda beneficia mais sob unanimidade

A diferença institucional dos efeitos é

\[
\Delta T^\theta
=T_U^\theta-T_M^\theta
=\Delta D^\theta+\Delta I^\theta.
\]

Logo a agenda beneficia mais (H) sob unanimidade se e somente se

\[
\Delta I^\theta>-\Delta D^\theta.
\]

Em palavras: o ranking depende de quanto a interação informacional favorece
unanimidade, relativamente à vantagem que maioria ou unanimidade já possui no
benchmark de informação completa.

# Escopo da consulta

## Audite

1. definição do tratamento e datas econômicas;
2. desenho fatorial e identidade $T=D+I$;
3. álgebra e fronteiras de $D_U,D_M,\Delta D$;
4. transporte das células fechadas de unanimidade;
5. propagação de `none` sem sentinela numérico;
6. preservação de vetores ligados por tipo;
7. operações set-valued em maioria e na comparação institucional;
8. distinção entre efeito total, interação e contraste diagonal;
9. interpretação causal estrutural e seus limites;
10. existência de resultados mais fortes logicamente forçados.

## Não audite nem rederive

- os resultados do jogo-base já incorporados ao paper;
- as soluções integrais de $A_M,A_U,A_C$ ou $A_R$;
- a escolha autoral da arquitetura M/S/B;
- a completude das correspondências privadas congeladas;
- o manuscrito ou a contribuição geral do paper;
- uma seleção cross-world de equilíbrio;
- uma distribuição conjunta entre realizações contrafactuais;
- uma nova função de bem-estar dos Estados fracos.

Se encontrar contradição direta entre um input congelado e uma derivação de
$A_T$, registre-a. Mas não transforme a consulta numa nova solução dos jogos
anteriores.

# Barreira axiomática I — fatos do jogo-base já provados no paper

Os fatos desta seção já foram demonstrados, revisados e incorporados ao paper.
**Assuma-os como verdadeiros, completos e internamente consistentes para esta
consulta.**

## AX-PAPER-1: jogadores e primitivas

Há $N\ge4$ Estados. Um é o hegemon $H$; os demais são
$m=N-1\ge3$ Estados fracos. A quota de maioria é

\[
q=\lfloor N/2\rfloor+1,
\qquad
k=q-1=\lfloor N/2\rfloor,
\qquad
c=m-k.
\]

O tipo de $H$ é $\theta\in\{0,1\}$, com

\[
\Pr(\theta=1)=\nu\in[0,1].
\]

As primitivas satisfazem

\[
0<\beta<1,
\qquad
0<o_0<o_1<1.
\]

$o_\theta$ é o payoff terminal de desacordo. O pie institucional é fixo e
normalizado a um.

## AX-PAPER-2: propostas, votos e desacordo

As propostas são públicas e os votos são simultâneos. Todos votam sim ou não;
o não de (H) não é opt-out. Se nenhuma proposta for aprovada até o fim, o
desacordo $o_\theta$ é realizado na data terminal pertinente.

Os votos fracos são as-if-pivotal. Em igualdade de payoff esperado, $T^Y$
prescreve sim. Votos dos Estados fracos não mudam a crença sobre $\theta$.
O conceito de solução é PBE com essas regras de votação e desempate.

## AX-PAPER-3: crenças

Desvios de Estados fracos não sinalizam informação que eles não possuem. Ações
de (H) podem mover crenças por Bayes quando disciplinadas pela estratégia.
Nos endpoints do prior, nenhum posterior atribui massa positiva ao tipo de
probabilidade zero.

## AX-PAPER-4: desconto

O fator $\beta$ desconta uma rodada exatamente uma vez. Valores só podem ser
subtraídos diretamente quando estão expressos na mesma data econômica.

## AX-PAPER-5: benchmark sem agenda sob informação completa

Na data nativa de (R1), o payoff do hegemon de tipo público é

\[
h_U^{N,R1}(o)=\beta o,
\]

e

\[
h_M^{N,R1}(o)=
\begin{cases}
\beta o,&o\le1/m,\\
o,&o>1/m.
\end{cases}
\]

A igualdade $o=1/m$ pertence ao ramo de inclusão de $H$.

## AX-PAPER-6: benchmark sem agenda sob informação privada e unanimidade

Defina

\[
\nu^\star=\frac{o_1-o_0}{1-o_0},
\qquad
d=\beta(o_1-o_0).
\]

Os vetores de renda informacional na data nativa de (R1) são:

\[
RI_U^{N,R1,01}=
\begin{cases}
(0,0),&\nu=0,\\
\texttt{none},&0<\nu\le\nu^\star,\\
(d,0),&\nu^\star<\nu\le1.
\end{cases}
\]

Consequentemente, o vetor privado sem agenda é:

\[
V_U^{N,R1,01}=
\begin{cases}
(\beta o_0,\beta o_1),&\nu=0,\\
\texttt{none},&0<\nu\le\nu^\star,\\
(\beta o_1,\beta o_1),&\nu^\star<\nu\le1.
\end{cases}
\]

O tipo de probabilidade zero permanece no vetor nos endpoints, embora receba
peso zero na média ex ante.

# Barreira axiomática II — inputs congelados da extensão de agenda

Os fatos desta seção são resultados separados da extensão, já derivados,
revisados, aprovados e congelados. Para auditar $A_T$, trate-os como inputs
condicionais. Não os reprove; verifique se $A_T$ os transporta fielmente.

## AX-EXT-1: arquitetura M/S/B

Nos jogos de agenda:

- **M — Markov:** a continuação depende da regra, estágio e posterior público,
  não do nome da proposta rejeitada;
- **S — anonimidade:** Estados fracos ex ante idênticos são tratados
  simetricamente nas leis econômicas de continuação;
- **B — crença constante:** num ponto genuinamente não disciplinado, cada
  assessment usa uma única crença off-path.

As operações econômicas preservam registros completos. É proibido montar um
vetor usando o payoff baixo de um equilíbrio e o payoff alto de outro.

## AX-EXT-2: etapa obrigatória de agenda

O estágio (A) é a data 0. (H) precisa fazer uma proposta; não existe ação
nula, renúncia ou passagem. O jogo sem agenda começa diretamente em (R1), uma
data depois.

O tratamento estrutural é:

\[
\text{inserir etapa anterior e obrigatória de proposta}
-
\text{iniciar diretamente em }R1.
\]

## AX-EXT-3: benchmark de agenda sob informação completa

Use

\[
Z_E=1-\frac{k\beta}{m},
\qquad
\tau_M=\frac{Z_E}{\beta}.
\]

Sob unanimidade,

\[
h_U^A(o)=1-\beta+\beta^2o.
\]

Sob maioria,

\[
h_M^A(o)=
\begin{cases}
1-\dfrac{k\beta(1-\beta o)}{m},&o\le1/m,\\[6pt]
\max\{Z_E,\beta o\},&o>1/m.
\end{cases}
\]

Em $o<\tau_M$, a solução aprova imediatamente; em $o>\tau_M$, $H$
induz atraso; em $o=\tau_M$, a lei de acordo pode misturar, mas o payoff de
$H$ continua singleton.

## AX-EXT-4: correspondência privada de agenda sob unanimidade

Defina

\[
z_L=1-\beta+\beta^2o_0,
\qquad
d_H=\beta^2o_1,
\qquad
z_H=1-\beta+\beta^2o_1,
\]

\[
\Delta_U=z_L-d_H,
\qquad
u_{\min}=\max\{z_L,d_H\}.
\]

As fibras privadas de payoff com agenda sob unanimidade são:

| Região | Condições | Vetor $(V_U^{A,0},V_U^{A,1})$ |
|---|---|---|
| Endpoint baixo | $\nu=0$ | $(z_L,\max\{z_L,d_H\})$ |
| Prior baixo, fibra existente | $0<\nu\le\nu^\star,\Delta_U\ge0,\rho=0$ | $(z_L,z_L)$ |
| Prior baixo, demais fibras | $0<\nu\le\nu^\star$ e $\Delta_U<0$ ou crença off-path positiva | `none` |
| Prior alto, crença zero | $\nu^\star<\nu<1,\rho=0$ | $(u,u)$, $u\in[u_{\min},z_H]$ |
| Prior alto, crença baixa positiva | $\nu^\star<\nu<1,\nu_{off}\in(0,\nu^\star]$ | `none` |
| Prior alto, crença alta | $\nu^\star<\nu<1,\nu_{off}\in(\nu^\star,1]$ | $(z_H,z_H)$ |
| Endpoint alto | $\nu=1$ | $(z_H,z_H)$ |

## AX-EXT-5: interação agenda × informação

Para $g\in\{M,U\}$, a interação congelada é

\[
I_g^{01}
=RI_g^{A,01}-\beta RI_g^{N,R1,01}.
\]

O fator $\beta$ transporta a renda sem agenda de $R1$ para $A$ exatamente
uma vez. Produtos são formados sobre registros completos nas mesmas primitivas.
Não há seleção ou sorteio comum cross-world.

Para maioria, a forma exata é a correspondência set-valued

\[
I_M^{01}
=RI_M^{A,01}-\beta RI_M^{N,R1,01}.
\]

Não há sinal geral congelado para $I_M$.

Para unanimidade:

\[
I_U^{01}=
\begin{cases}
(0,\max\{z_L,d_H\}-z_H),&\nu=0,\\
\texttt{none},&0<\nu\le\nu^\star,\\
\{(u-z_H,u-z_H):u\in[u_{\min},z_H]\},
  &\nu^\star<\nu<1,\rho=0,\\
\texttt{none},&\nu^\star<\nu<1,
  \nu_{off}\in(0,\nu^\star],\\
(0,0),&\nu^\star<\nu<1,
  \nu_{off}\in(\nu^\star,1],\\
(0,0),&\nu=1.
\end{cases}
\]

## AX-EXT-6: interação institucional

Defina

\[
\Delta I^{01}=I_U^{01}-I_M^{01}.
\]

Sua imagem exata é formada a partir de tuplas institucionais completas já
ligadas. Se qualquer fonte necessária é `none`, $\Delta I$ é `none`.

# Objeto causal e desenho fatorial

## As quatro células

Para cada regra $g\in\{M,U\}$ e tipo $\theta$, todos os valores são
expressos na data (A):

| | Informação completa | Informação privada |
|---|---:|---:|
| Sem agenda | $\beta h_g^{N,R1}(o_\theta)$ | $\beta V_g^{N,R1,\theta}$ |
| Com agenda | $h_g^A(o_\theta)$ | $V_g^{A,\theta}$ |

As quatro diferenças relevantes são:

\[
D_g^\theta
=h_g^A(o_\theta)-\beta h_g^{N,R1}(o_\theta),
\]

\[
T_g^\theta
=V_g^{A,\theta}-\beta V_g^{N,R1,\theta},
\]

\[
\beta RI_g^{N,R1,\theta}
=\beta V_g^{N,R1,\theta}-\beta h_g^{N,R1}(o_\theta),
\]

\[
RI_g^{A,\theta}
=V_g^{A,\theta}-h_g^A(o_\theta).
\]

$D_g$ é o efeito da etapa de agenda no benchmark de informação completa.
$T_g$ é o efeito total da etapa de agenda mantendo informação privada nos
dois braços. $I_g$ é a diferença de diferenças.

## Teorema T1 — identidade fatorial

Para todo registro completo em que os dois braços existem,

\[
T_g^\theta=D_g^\theta+I_g^\theta.
\]

A mesma identidade vale para o vetor ligado por tipos e para sua imagem ex
ante.

### Prova fornecida

Use

\[
V_g^{A,\theta}
=h_g^A(o_\theta)+RI_g^{A,\theta}
\]

e

\[
V_g^{N,R1,\theta}
=h_g^{N,R1}(o_\theta)+RI_g^{N,R1,\theta}.
\]

Então

\[
\begin{aligned}
T_g^\theta
&=V_g^{A,\theta}-\beta V_g^{N,R1,\theta}\\
&=h_g^A(o_\theta)+RI_g^{A,\theta}
  -\beta h_g^{N,R1}(o_\theta)
  -\beta RI_g^{N,R1,\theta}\\
&=\underbrace{
  \left[h_g^A(o_\theta)-\beta h_g^{N,R1}(o_\theta)\right]
  }_{D_g^\theta}
 +\underbrace{
  \left[RI_g^{A,\theta}-\beta RI_g^{N,R1,\theta}\right]
  }_{I_g^\theta}.
\end{aligned}
\]

O mesmo mapa afim é aplicado ao vetor completo antes da média pelo prior.
Nenhuma coordenada é selecionada separadamente. \(\square\)

# Efeito da agenda sob informação completa

## Teorema T2 — unanimidade

Para todo $o\in(0,1)$,

\[
D_U(o)=1-\beta>0.
\]

### Prova fornecida

Pelos inputs,

\[
h_U^A(o)=1-\beta+\beta^2o,
\qquad
h_U^{N,R1}(o)=\beta o.
\]

Logo

\[
\begin{aligned}
D_U(o)
&=h_U^A(o)-\beta h_U^{N,R1}(o)\\
&=1-\beta+\beta^2o-\beta^2o\\
&=1-\beta>0.
\end{aligned}
\]

\(\square\)

## Teorema T3 — maioria

Defina

\[
Z_E=1-\frac{k\beta}{m},
\qquad
\tau_M=\frac{Z_E}{\beta},
\qquad
c=m-k.
\]

Então

\[
D_M(o)=
\begin{cases}
Z_E-\dfrac{c}{m}\beta^2o,
  &o\le1/m,\\[6pt]
Z_E-\beta o,
  &1/m<o<\tau_M,\\[4pt]
0,
  &o\ge\tau_M.
\end{cases}
\]

Em particular,

\[
D_M(o)>0\quad\Longleftrightarrow\quad o<\tau_M,
\]

e $D_M(o)=0$ em $o\ge\tau_M$.

### Prova fornecida: ramo de inclusão

Se $o\le1/m$,

\[
h_M^A(o)=1-\frac{k\beta(1-\beta o)}{m},
\qquad
h_M^{N,R1}(o)=\beta o.
\]

Portanto

\[
\begin{aligned}
D_M(o)
&=1-\frac{k\beta(1-\beta o)}{m}-\beta^2o\\
&=1-\frac{k\beta}{m}
  +\frac{k\beta^2o}{m}-\beta^2o\\
&=Z_E-\frac{m-k}{m}\beta^2o\\
&=Z_E-\frac{c}{m}\beta^2o.
\end{aligned}
\]

Além disso,

\[
\begin{aligned}
D_M(o)-(1-\beta)
&=\beta\frac{c}{m}(1-\beta o)>0,
\end{aligned}
\]

pois $c>0$, $0<\beta<1$ e $o<1$.

### Prova fornecida: ramo de exclusão

Se (o>1/m),

\[
h_M^A(o)=\max\{Z_E,\beta o\},
\qquad
h_M^{N,R1}(o)=o.
\]

Logo

\[
D_M(o)
=\max\{Z_E,\beta o\}-\beta o
=\max\{Z_E-\beta o,0\}.
\]

Como $\tau_M=Z_E/\beta$, a forma por ramos segue. No limiar, passagem e
atraso dão o mesmo payoff e $D_M=0$. \(\square\)

## Corolário C1 — qual regra produz o maior efeito de agenda sob informação completa

Defina

\[
\Delta D(o)=D_U(o)-D_M(o).
\]

Então

\[
\Delta D(o)=
\begin{cases}
-\beta\dfrac{c}{m}(1-\beta o),
  &o\le1/m,\\[6pt]
\beta\left(o-\dfrac{c}{m}\right),
  &1/m<o\le\tau_M,\\[6pt]
1-\beta,
  &o\ge\tau_M.
\end{cases}
\]

### Prova fornecida

Subtraia cada ramo de $D_M$ de $1-\beta$.

No primeiro ramo,

\[
\Delta D
=-(D_M-(1-\beta))
=-\beta\frac{c}{m}(1-\beta o)<0.
\]

No segundo,

\[
\begin{aligned}
\Delta D
&=1-\beta-(Z_E-\beta o)\\
&=1-\beta-1+\frac{k\beta}{m}+\beta o\\
&=\beta\left(o-1+\frac{k}{m}\right)\\
&=\beta\left(o-\frac{c}{m}\right).
\end{aligned}
\]

No terceiro, $D_M=0$, portanto $\Delta D=1-\beta$.

Em $o=\tau_M$,

\[
\beta\left(\tau_M-\frac{c}{m}\right)
=Z_E-\beta\frac{c}{m}
=1-\beta,
\]

pois $k+c=m$. As expressões coincidem.

Se $c=1$, o ponto $o=c/m=1/m$ pertence ao primeiro ramo pela seleção
congelada do benchmark; não é uma raiz da expressão aberta do segundo ramo.
\(\square\)

# Efeito total sob informação privada: unanimidade

Como

\[
D_U^{01}=(1-\beta,1-\beta),
\]

o conjunto de efeitos totais é a translação das células de $I_U$ por esse
vetor fixo.

## Teorema T4 — classificação completa de $T_U$

### Endpoint $\nu=0$

\[
T_U^{01}=(1-\beta,\max\{\Delta_U,0\}),
\qquad
T_U^E=1-\beta.
\]

### Prior baixo positivo

Para

\[
0<\nu\le\nu^\star,
\]

o braço sem agenda sob informação privada é `none`. Logo

\[
T_U=\texttt{none}.
\]

Isso permanece verdadeiro mesmo quando o braço com agenda existe. O efeito não
é zero: ele é indefinido porque falta o controle no conceito mantido.

### Prior alto, crença off-path degenerada em zero

Se

\[
\nu^\star<\nu<1,
\qquad
\rho=0,
\]

então

\[
T_U^{01}
=\{(u-d_H,u-d_H):u\in[u_{\min},z_H]\}.
\]

Cada coordenada pertence a

\[
[\max\{\Delta_U,0\},1-\beta].
\]

### Prior alto, crença off-path baixa positiva

Se

\[
\nu^\star<\nu<1,
\qquad
\nu_{off}\in(0,\nu^\star],
\]

o braço privado com agenda é `none`, enquanto o controle sem agenda existe.
Portanto

\[
T_U=\texttt{none}.
\]

Qualquer comparação institucional $\Delta T$ que exija esse braço também é
`none`.

### Prior alto, crença off-path alta, e endpoint $\nu=1$

Se

\[
\nu^\star<\nu<1,
\qquad
\nu_{off}\in(\nu^\star,1],
\]

ou se $\nu=1$,

\[
T_U^{01}=(1-\beta,1-\beta).
\]

### Prova fornecida

No endpoint baixo, o braço com agenda é

\[
(z_L,\max\{z_L,d_H\}),
\]

e o braço sem agenda, transportado para (A), é

\[
(\beta^2o_0,d_H).
\]

Como $z_L-\beta^2o_0=1-\beta$,

\[
\max\{z_L,d_H\}-d_H
=\max\{z_L-d_H,0\}
=\max\{\Delta_U,0\}.
\]

Em prior baixo positivo, o controle é `none`, e a regra de existência impede
formar a diferença.

Em prior alto, o controle sem agenda transportado é sempre

\[
(d_H,d_H).
\]

Na fibra $\rho=0$, subtrair esse vetor de $(u,u)$ produz a família ligada
declarada. Como

\[
u_{\min}=\max\{z_L,d_H\},
\]

o menor valor é

\[
u_{\min}-d_H
=\max\{z_L-d_H,0\}
=\max\{\Delta_U,0\},
\]

e o maior é

\[
z_H-d_H=1-\beta.
\]

Na célula de crença baixa positiva, o tratamento é `none`, logo o efeito é
`none`. Na célula alta e em $\nu=1$,

\[
(z_H,z_H)-(d_H,d_H)=(1-\beta,1-\beta).
\]

\(\square\)

## Corolário C2 — sinal e casos de igualdade sob unanimidade

Em toda célula em que os dois braços possuem PBE puro,

\[
T_U^\theta\ge0
\]

para cada tipo.

O ganho máximo é $1-\beta$. Zero pode ocorrer:

1. na coordenada contrafactual do tipo alto em $\nu=0$, quando
   $\Delta_U\le0$;
2. no membro $u=d_H$ da família alta $\rho=0$, possível quando
   $d_H\ge z_L$.

No endpoint $\nu=0$, o efeito ex ante continua estritamente positivo e igual
a $1-\beta$, porque a coordenada alta recebe probabilidade zero.

### Ponto a auditar

Verifique cuidadosamente se a afirmação “zero no membro $u=d_H$” requer
$d_H\in[u_{\min},z_H]$, e se isso é equivalente a $d_H\ge z_L$.

# Efeito total sob informação privada: maioria

Defina o vetor fixo

\[
D_M^{01}=(D_M(o_0),D_M(o_1)).
\]

O conjunto exato é

\[
T_M^{01}=D_M^{01}+I_M^{01},
\]

onde $I_M^{01}$ é a correspondência congelada sobre produtos de registros
completos.

## Teorema T5 — caracterização selection-free sob maioria

Para cada membro completo e cada tipo,

\[
T_M^\theta>0
\iff
I_M^\theta>-D_M(o_\theta),
\]

\[
T_M^\theta=0
\iff
I_M^\theta=-D_M(o_\theta),
\]

\[
T_M^\theta<0
\iff
I_M^\theta<-D_M(o_\theta).
\]

Quando

\[
o_\theta\ge\tau_M,
\]

temos $D_M(o_\theta)=0$, de modo que o efeito total coincide exatamente com
a interação informacional daquele membro:

\[
T_M^\theta=I_M^\theta.
\]

### Prova fornecida

A identidade fatorial T1 implica

\[
T_M^\theta=D_M(o_\theta)+I_M^\theta.
\]

Como $D_M(o_\theta)$ é um escalar fixo, as três equivalências seguem ao
subtrair esse termo. O conjunto total é apenas a translação da correspondência
exata de interação; nenhuma seleção nova é introduzida. \(\square\)

### Limite deliberado

Como $I_M$ é set-valued e não possui sinal geral nos inputs, não se reivindica
um sinal geral para $T_M$. Um sinal é robusto apenas se a imagem exata inteira
fica do mesmo lado de $-D_M(o_\theta)$.

### Ponto a auditar

Determine se algum sinal ou bound adicional realmente segue dos inputs
reproduzidos. Não escolha silenciosamente um equilíbrio de maioria para obter
uma conclusão mais forte.

# Diferença institucional dos efeitos

Defina

\[
\Delta T^\theta=T_U^\theta-T_M^\theta,
\]

\[
\Delta D^\theta=D_U^\theta-D_M^\theta,
\]

\[
\Delta I^\theta=I_U^\theta-I_M^\theta.
\]

## Teorema T6 — diferença de diferenças

Em todo produto de registros completos no qual as fontes existem,

\[
\Delta T^\theta
=\Delta D^\theta+\Delta I^\theta.
\]

Portanto, para cada membro completo,

\[
T_U^\theta>T_M^\theta
\iff
\Delta I^\theta>-\Delta D^\theta.
\]

### Prova fornecida

Por T1,

\[
T_U^\theta=D_U^\theta+I_U^\theta
\]

e

\[
T_M^\theta=D_M^\theta+I_M^\theta.
\]

Subtraindo,

\[
\begin{aligned}
\Delta T^\theta
&=(D_U^\theta-D_M^\theta)
 +(I_U^\theta-I_M^\theta)\\
&=\Delta D^\theta+\Delta I^\theta.
\end{aligned}
\]

A equivalência de preferência segue ao mover $\Delta D^\theta$ para o lado
direito. A operação deve ser aplicada dentro das tuplas institucionais ligadas;
não se podem combinar marginais de membros distintos. \(\square\)

## Interpretação por regiões

- Se $\Delta D^\theta<0$, maioria oferece o maior ganho de agenda no
  benchmark de informação completa. A interação precisa favorecer unanimidade
  em magnitude superior a $-\Delta D^\theta$ para inverter o ranking.
- Se $\Delta D^\theta>0$, unanimidade possui vantagem no benchmark de
  informação completa, mas a interação pode reduzi-la ou revertê-la.
- Se $\Delta D^\theta=0$, a interação decide sozinha.

$\Delta T$ permanece set-valued quando qualquer fonte o for. Se um braço
necessário é `none`, $\Delta T$ também é `none`.

# Contraste diagonal: agenda apenas versus informação apenas

Uma expressão verbal potencialmente ambígua é “agenda apenas versus informação
apenas”. Há duas comparações distintas.

## Comparação causal de agenda sob informação privada

Esta é $T_g$:

\[
T_g^\theta
=V_g^{A,\theta}-\beta V_g^{N,R1,\theta}.
\]

O regime informacional permanece privado nos dois braços; muda apenas o game
form de agenda, com a diferença temporal que faz parte do tratamento.

## Comparação diagonal de pacotes

Defina

\[
Q_g^\theta
=h_g^A(o_\theta)-\beta V_g^{N,R1,\theta}
=D_g^\theta-\beta RI_g^{N,R1,\theta}.
\]

$Q_g$ compara $(\text{agenda},\text{informação completa})$ com
$(\text{sem agenda},\text{informação privada})$. Como agenda e regime
informacional mudam simultaneamente, ele não é o efeito causal isolado de um
único fator.

## Forma fechada de $Q_U$

\[
Q_U^{01}=
\begin{cases}
(1-\beta,1-\beta),&\nu=0,\\
\texttt{none},&0<\nu\le\nu^\star,\\
(\Delta_U,1-\beta),&\nu^\star<\nu\le1.
\end{cases}
\]

Na região alta,

\[
Q_U^E
=1-\beta-(1-\nu)\beta^2(o_1-o_0).
\]

Observe a diferença de existência: na célula alta com
$\nu_{off}\in(0,\nu^\star]$, $T_U$ é `none` porque o braço privado com
agenda não existe, mas $Q_U$ continua definido porque usa o benchmark de
agenda sob informação completa.

Sob maioria,

\[
Q_M^{01}
=D_M^{01}-\beta RI_M^{N,R1,01}
\]

é a imagem exata dos registros aplicáveis do benchmark sem agenda.

# Existência, multiplicidade e objetos `none`

As operações privadas seguem estas regras:

1. forme primeiro registros completos com as mesmas primitivas;
2. preserve conjuntamente as duas coordenadas de tipo;
3. aplique diferenças vetoriais somente depois;
4. não imponha realização aleatória comum ou seleção de equilíbrio cross-world;
5. não recombine payoff, posterior ou outcome de registros distintos;
6. se qualquer braço requerido é `none`, o efeito composto é `none`;
7. `none` não é zero, `NA`, infinito, conjunto singleton ou payoff fictício.

Para efeitos ex ante, aplique

\[
x_E=(1-\nu)x_0+\nu x_1
\]

somente ao vetor ligado $(x_0,x_1)$. Em geral, não é permitido escolher
independentemente uma coordenada baixa e uma alta antes da média.

# Testes numéricos ilustrativos

Os exemplos abaixo não substituem as provas. Servem para detectar erros de sinal
e interpretação.

## Exemplo 1 — efeito de agenda no benchmark de informação completa

Tome

\[
N=13,
\quad m=12,
\quad k=6,
\quad c=6,
\quad \beta=0.9.
\]

Então

\[
Z_E=0.55,
\qquad
\tau_M=0.611\overline{1},
\qquad
D_U=0.1.
\]

Como $c/m=0.5$:

- em $o=0.20$,
  
  \[
  D_M=0.55-0.9(0.20)=0.37,
  \qquad
  \Delta D=-0.27;
  \]
  
  maioria converte agenda em payoff muito melhor;
- em $o=0.55$,
  
  \[
  D_M=0.055,
  \qquad
  \Delta D=0.045;
  \]
  
  unanimidade já possui vantagem;
- em $o=0.70>\tau_M$,
  
  \[
  D_M=0,
  \qquad
  \Delta D=0.1.
  \]

O ponto de virada dentro do ramo intermediário é $o=c/m=0.5$, não
necessariamente (1/2) para todo (N).

## Exemplo 2 — zero contrafactual no endpoint baixo

Tome

\[
\beta=0.9,
\qquad
o_0=0.1,
\qquad
o_1=0.9.
\]

Então

\[
z_L=0.181,
\qquad
d_H=0.729,
\qquad
\Delta_U=-0.548.
\]

Em $\nu=0$,

\[
T_U^{01}=(0.1,0).
\]

O efeito do tipo alto é zero, mas esse tipo possui probabilidade zero. O efeito
ex ante é $0.1=1-\beta$.

## Exemplo 3 — multiplicidade ligada na fibra alta $\rho=0$

Com os mesmos valores,

\[
z_H=0.829,
\qquad
u_{\min}=0.729.
\]

Logo

\[
T_U^{01}
=\{(t,t):t\in[0,0.1]\}.
\]

As duas coordenadas se movem juntas. O conjunto não é o quadrado
$[0,0.1]^2$, pois isso permitiria recombinar tipos de membros distintos.

# Alegações que o parecer deve classificar

Classifique cada item como `PROVED`, `MATHEMATICAL DEFECT`, `MODELING CHOICE`,
`UNRESOLVED FROM GIVEN INPUTS` ou `EXPOSITION ISSUE`.

| ID | Alegação |
|---|---|
| C-1 | O estimando $T_g$ mantém informação privada nos dois braços e mede o efeito estrutural da etapa obrigatória de agenda. |
| C-2 | O braço sem agenda recebe exatamente um fator adicional $\beta$, e o braço com agenda nenhum. |
| C-3 | $T_g=D_g+I_g$ é uma identidade fatorial, não uma hipótese comportamental. |
| C-4 | $D_U=1-\beta>0$ para todo tipo. |
| C-5 | $D_M>0$ abaixo de $\tau_M$ e é zero a partir do limiar. |
| C-6 | $\Delta D$ pode ser negativo ou positivo; agenda não beneficia automaticamente mais $H$ sob unanimidade no benchmark de informação completa. |
| C-7 | Onde ambos os braços existem, $T_U^\theta\ge0$ para cada tipo. |
| C-8 | A classificação de zero de $T_U$ possui exatamente as duas famílias declaradas. |
| C-9 | $T_U$ possui duas famílias `none`, com braços ausentes diferentes. |
| C-10 | Não há sinal geral autorizado para $T_M$ a partir dos inputs fornecidos. |
| C-11 | $T_M^\theta>0$ se e somente se $I_M^\theta>-D_M(o_\theta)$, membro a membro. |
| C-12 | $\Delta T=\Delta D+\Delta I$ deve ser interpretado dentro de tuplas institucionais completas. |
| C-13 | $Q_g$ não é efeito causal de um único fator. |
| C-14 | A não negatividade de $T_U$ não pode ser justificada genericamente pelo valor de uma opção, porque a proposta é obrigatória. |
| C-15 | `none` representa ausência do efeito no conceito mantido, não efeito zero. |

# Formato solicitado da resposta

Produza uma **consulta técnica externa não formal** com estas seções:

1. `Natureza e limite da consulta`;
2. `Veredito executivo`;
3. `Reconstrução da pergunta causal`;
4. `Auditoria do desenho 2 x 2 e das datas`;
5. `Auditoria de T1: identidade fatorial`;
6. `Auditoria de T2–T3: efeitos sob informação completa`;
7. `Auditoria de T4: unanimidade sob informação privada`;
8. `Auditoria de T5: maioria sob informação privada`;
9. `Auditoria de T6: comparação institucional`;
10. `Auditoria do contraste diagonal Q`;
11. `Existência, multiplicidade e células none`;
12. `Tabela claim-by-claim C-1–C-15`;
13. `Testes adversariais e contraexemplos`;
14. `Resultados mais fortes que realmente seguem`;
15. `Correções mínimas recomendadas`;
16. `Recomendação consultiva final`.

Na seção 14, não sugira novos resultados apenas porque seriam interessantes.
Inclua somente resultados logicamente forçados pelos axiomas e provas deste
pacote. Para cada resultado adicional, forneça prova ou contraexemplo.

Na seção 15, diferencie:

- correção matemática necessária;
- melhoria de exposição;
- escolha de modelagem opcional;
- extensão que exigiria nova autorização e nova derivação.

# Identidade técnica do candidato auditado

- Worktree de derivação:
  `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-total-effect`
- Branch: `codex/agenda-total-effect`
- Commit dos bytes matemáticos auditados:
  `7033063a4b737cc0acc087ac71261e25805c689d`
- Manifesto do candidato:
  `quality_reports/2026-08-30_AT_msb_candidate_manifest.sha256`
- SHA-256 do manifesto:
  `ca3248fb8ef63a2dcc008b5e30ffda1a8e170806ea172969e069daef1e9629cd`
- Verificação mecânica: `50 PASS / 0 FAIL`
- Revisão matemática independente: `PASS 0/0/0`
- Revisão adversarial independente: `PASS 0/0/0`
- Estado interno: `reviewed/unfrozen`; aprovação autoral terminal ainda não
  concedida.

Essas revisões são informação de proveniência, não evidência a ser usada na
auditoria. Reconstrua os resultados reproduzidos acima.
