---
title: "A_C: comparação exata entre maioria e unanimidade"
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
barganha política. Empregue rigor de teoria dos jogos, teoria da medida e
análise de correspondências, mas **não assuma o papel institucional de
parecerista formal do projeto**.

Sua resposta será uma **consulta técnica externa não formal**. Ela:

- não é parecer formal independente;
- não reabre nem fecha um gate;
- não concede PASS, aprovação autoral ou congelamento;
- não substitui as revisões formais independentes já realizadas;
- não autoriza implementação, migração ao manuscrito, tag, merge, push ou o
  início de outro nó;
- serve como insumo suplementar para uma decisão autoral posterior.

Não use a concordância das revisões anteriores como prova. Tente refutar os
resultados diretamente a partir das definições e provas reproduzidas aqui. Ao
mesmo tempo, não rederive partes congeladas do jogo que este pacote declara
como inputs. Se discordar de uma escolha de comparação, separe claramente
MODELING CHOICE de MATHEMATICAL DEFECT.

Produza um arquivo Markdown UTF-8 chamado
2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AC_msb.md. Se a
interface não puder criar um arquivo baixável, devolva o Markdown completo, sem
texto introdutório fora do documento. No título e na primeira seção da resposta,
repita que o produto é uma **consulta técnica externa não formal**.

# Perguntas centrais

Avalie quatro questões:

1. O objeto exato de comparação emparelha corretamente os equilíbrios de
   maioria e unanimidade que pertencem à mesma economia e à mesma fibra de
   crenças fora do caminho?
2. A passagem posterior para resumos econômicos preserva exatamente as
   operações declaradas, sem recombinar componentes de equilíbrios distintos?
3. As classificações por tipo, ex ante, por sinais e por envelopes seguem das
   correspondências exatas, inclusive em células vazias e nos endpoints do
   prior?
4. A condição

   \[
   \beta o_1<\frac{c}{m}
   \]

   realmente garante, sem selecionar equilíbrio, que o payoff do hegemon é
   estritamente maior sob maioria do que sob unanimidade para ambos os tipos e
   ex ante?

# Resumo intuitivo

## O que está sendo comparado

O paper estuda barganha institucional entre um hegemon \(H\), que conhece
privadamente seu próprio tipo, e \(m=N-1\) Estados fracos. Sob maioria, uma
coalizão pode aprovar uma proposta sem incluir todos. Sob unanimidade, o acordo
exige todos os votos, inclusive o de \(H\).

A extensão de agenda pergunta o que acontece quando o próprio hegemon recebe a
oportunidade de propor. Esse estágio já foi resolvido separadamente sob maioria
\(A_M\) e unanimidade \(A_U\). Cada regra pode admitir mais de um equilíbrio.

\(A_C\) não é um terceiro jogo. Ninguém se move em \(A_C\), nenhuma nova crença
é formada e nenhum payoff é descontado novamente. \(A_C\) é apenas a operação
que compara as duas correspondências de equilíbrio.

## Por que a comparação não é simplesmente uma subtração

Se cada instituição tivesse um único equilíbrio, bastaria calcular

\[
V_U-V_M.
\]

Com multiplicidade, porém, \(V_U\) e \(V_M\) são conjuntos de valores ligados a
assessments completos: estratégias dos dois tipos, crenças, continuações,
outcomes e leis aleatórias. Escolher silenciosamente um elemento de cada lado
transformaria a comparação numa conclusão sobre uma seleção não declarada.

Por isso, o objeto primário de \(A_C\) é o conjunto de todos os pares
compatíveis de equilíbrios completos. As diferenças de payoff, acordo e atraso
são calculadas somente depois desse emparelhamento.

## O que significa “comparar na mesma fibra”

Uma proposta fora do caminho pode induzir uma crença
\(\nu_{\mathrm{off}}\) sobre o tipo alto. Nos priors interiores, essa crença é
parametrizada por um likelihood ratio \(\rho\). A comparação principal exige
que os dois contrafactuais institucionais usem a mesma economia, o mesmo prior e
a mesma convenção \((\rho,\nu_{\mathrm{off}})\).

Isso é uma regra de “maçãs com maçãs”: não se atribui à maioria uma crença
off-path conveniente e à unanimidade outra crença diferente. Essa diagonal é
uma escolha autoral de comparação institucional. A consulta deve avaliar sua
coerência e implementação, mas não tratá-la automaticamente como teorema imposto
pelo conceito de PBE.

## Por que não se exige o mesmo sorteio nas duas instituições

Maioria e unanimidade são mundos contrafactuais. O game form não contém um
sorteio conjunto que determine simultaneamente qual coalizão seria paga em cada
regra. Portanto os equilíbrios emparelhados não precisam usar a mesma proposta,
a mesma coalizão nomeada ou a mesma realização aleatória.

O que precisa permanecer íntegro é cada equilíbrio dentro de sua própria regra.
Não se pode retirar o payoff do tipo baixo de um equilíbrio, o payoff do tipo
alto de outro e a lei de outcomes de um terceiro.

## O resultado substantivo mais simples

Sob maioria, \(H\) precisa comprar apenas os \(k=q-1\) votos fracos que completam
uma coalizão mínima. Dos \(m\) Estados fracos, pode deixar de fora

\[
c=m-k.
\]

O pacote congelado de maioria garante ao hegemon, para ambos os tipos, pelo
menos

\[
Z_E=1-\frac{k\beta}{m}.
\]

O pacote congelado de unanimidade implica que o hegemon nunca recebe mais que

\[
z_H=1-\beta+\beta^2o_1.
\]

A diferença entre essa garantia de maioria e o teto de unanimidade é

\[
Z_E-z_H
=\beta\left(\frac{c}{m}-\beta o_1\right).
\]

Logo, se \(\beta o_1<c/m\), até o melhor payoff de unanimidade fica abaixo da
garantia de maioria. Essa conclusão não depende da seleção de equilíbrio.

É uma condição suficiente, não necessária. Se ela falha, os bounds deixam de
ordenar as instituições; isso não prova que unanimidade domina.

# Escopo da consulta

## Audite

1. a definição do produto fibrado de binders completos;
2. a necessidade e a suficiência das condições de compatibilidade;
3. a ausência de splicing entre assessments;
4. a orientação dos contrastes, sempre unanimidade menos maioria;
5. o cálculo por tipo antes da média pelo prior;
6. a contagem de desconto — zero novos fatores de \(\beta\);
7. a fatorização Borel da operação econômica pelos dois resumos-fonte;
8. o lifting setwise de resumos inteiros, sem seletor mensurável indevido;
9. a partição das fibras de payoff de \(A_U\);
10. as células de existência e o tratamento none;
11. os conjuntos exatos de contraste e a classificação por sinais;
12. a diferença entre o conjunto exato e seu casco intervalar;
13. o certificado selection-free de vantagem da maioria;
14. a ausência de uma distribuição conjunta entre mundos contrafactuais;
15. os limites substantivos declarados.

## Não audite nem rederive

- os nós congelados do jogo-base já incorporados ao paper;
- as correspondências completas de \(A_M\) ou \(A_U\);
- a escolha autoral da arquitetura M/S/B, salvo para verificar que \(A_C\) a
  implementa de modo coerente;
- a validade interna das assinaturas exatas de \(A_M\) e \(A_U\), já objeto de
  decisões e revisões próprias;
- o benchmark público \(A_R\), que não foi autorizado;
- o manuscrito ou a contribuição geral do paper;
- uma nova função de bem-estar para os Estados fracos;
- um acoplamento probabilístico cross-world ausente do jogo.

Se detectar uma contradição lógica direta entre um input congelado e uma prova
de \(A_C\), descreva-a. Não use, porém, a consulta como oportunidade para
resolver novamente os dois jogos-fonte.

# Barreira axiomática I — fatos já provados e incorporados ao paper

Os fatos desta seção pertencem ao jogo-base. Eles já foram demonstrados,
revisados e incorporados ao manuscrito. **Assuma-os como verdadeiros, completos
e internamente consistentes para esta consulta.**

## AX-PAPER-1: jogadores e primitivas

Há \(N\ge3\) Estados. Um é o hegemon \(H\); os demais são \(m=N-1\) Estados
fracos. A quota de maioria é

\[
q=\lfloor N/2\rfloor+1,
\qquad
k=q-1=\lfloor N/2\rfloor.
\]

O tipo de \(H\) é \(\theta\in\{0,1\}\), com
\(\Pr(\theta=1)=\nu\in[0,1]\). As primitivas satisfazem

\[
0<\beta<1,
\qquad
0<o_0<o_1<1,
\qquad
o_1\le\bar y\le1.
\]

\(o_\theta\) é o payoff terminal de desacordo. O pie institucional é fixo e
normalizado a um.

## AX-PAPER-2: propostas, votação e desacordo

As propostas são públicas e os votos são simultâneos. Todos votam sim ou não;
o não de \(H\) não é opt-out. Se nenhuma proposta for aprovada até o fim, o
desacordo \(o_\theta\) é realizado na data terminal pertinente.

Os votos fracos são as-if-pivotal: cada Estado compara sua alocação corrente
com o valor esperado da continuação no evento em que seu voto é pivotal. Em
igualdade, \(T^Y\) prescreve sim. Votos de Estados fracos não mudam a crença
sobre \(\theta\).

O conceito de solução é PBE com essas regras de votação e desempate.

## AX-PAPER-3: informação e crenças fora do caminho

Desvios de Estados fracos não sinalizam informação que eles não possuem. As
ações de \(H\) podem mover crenças por Bayes quando disciplinadas pela
estratégia. Nos endpoints do prior, nenhum posterior atribui massa positiva ao
tipo de probabilidade zero. A forma constante da crença genuinamente
off-support usada na extensão aparece separadamente em AX-EXT-1.

## AX-PAPER-4: data econômica

O fator \(\beta\) desconta uma rodada exatamente uma vez. Valores só podem ser
subtraídos diretamente quando estão expressos na mesma data econômica. A
sincronização específica dos valores de \(A_M\) e \(A_U\) é um input da
extensão registrado em AX-EXT-3.

# Barreira axiomática II — inputs congelados da extensão de agenda

Os fatos desta seção ainda não são resultados do manuscrito. São resultados
separados da extensão de agenda, já derivados, revisados, aprovados e congelados
em \(A_M\) e \(A_U\). Para auditar \(A_C\), trate-os como inputs condicionais.
Não os reprove; verifique se \(A_C\) os transporta fielmente.

## AX-EXT-1: protocolo M/S/B

Nos jogos-fonte:

- **M — Markov:** a continuação após rejeição depende da instituição, do
  estágio e do posterior público, não do nome da proposta rejeitada ou do vetor
  de votos;
- **S — anonimidade:** Estados fracos ex ante idênticos são tratados
  simetricamente nas leis econômicas de continuação;
- **B — crença constante:** num ponto genuinamente não disciplinado, cada
  assessment usa um único \(\nu_{\mathrm{off}}\).

Essa arquitetura admite uma camada formal exata e uma camada de resumo
econômico. Operações sensíveis a funções off-path recebem o binder completo;
operações provadamente recuperáveis das leis econômicas podem usar o resumo.

## AX-EXT-2: domínio e fibra comuns

Fixe

\[
d=(N,m,q,k,\beta,o_0,o_1,\bar y,Y,\nu),
\qquad c=m-k.
\]

Para \(0<\nu<1\), fixe

\[
\eta=(\rho,p),
\qquad
p=\nu_{\mathrm{off}}
=b_\rho(\nu)
=\frac{\nu\rho}{1-\nu+\nu\rho},
\qquad \rho\in[0,\infty].
\]

Use a convenção \(b_\infty(\nu)=1\). Nos endpoints,

\[
\eta=(*,\nu),
\]

e \(\rho\) é quocientado.

## AX-EXT-3: data comum dos valores

Os pacotes congelados de \(A_M\) e \(A_U\) entregam
\(V_M^\theta\) e \(V_U^\theta\) na mesma data A. Cada fonte já efetuou
internamente a única transformação temporal de sua continuação para essa data.
\(A_C\) deve aplicar fator um e zero novos fatores de \(\beta\).

## AX-AM-1: correspondência completa de maioria

Para cada \((d,\eta)\), \(B_M(d,\eta)\) é o conjunto de binders completos de
\(A_M\). Um binder preserva conjuntamente estratégias, crenças, seleção de
continuação, ballot, outcomes, leis realizadas e payoffs por tipo.

O resultado de existência de \(A_M\) garante, para cada primitiva, existência
em **alguma** fibra \(\rho\); não garante
\(B_M(d,\eta)\ne\varnothing\) em toda fibra fixa.

## AX-AM-2: bound uniforme de maioria

Para todo \(R_M\in B_M(d,\eta)\) e \(\theta\in\{0,1\}\),

\[
V_M^\theta(R_M)
\ge
\max\left\{Z_E,\beta^2o_\theta\right\},
\qquad
Z_E=1-\frac{k\beta}{m}.
\]

## AX-AU-1: correspondência completa de unanimidade

Para cada \((d,\eta)\), \(B_U(d,\eta)\) é o conjunto de binders completos de
\(A_U\), com as mesmas garantias de atomicidade. Defina

\[
\nu^\star=\frac{o_1-o_0}{1-o_0},
\]

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

## AX-AU-2: partição exata dos payoffs de unanimidade

As fibras de payoff de \(A_U\) são:

| Região | Condições | Estado e vetor de payoff \((V_U^0,V_U^1)\) |
|---|---|---|
| Endpoint baixo | \(\nu=0,\eta=(*,0)\) | existe; \((z_L,\max\{z_L,d_H\})\) |
| Prior baixo, fibra zero | \(0<\nu\le\nu^\star,\Delta_U\ge0,p=0\) | existe; \((z_L,z_L)\) |
| Prior baixo, demais casos | \(0<\nu\le\nu^\star\) e \(\Delta_U<0\) ou \(p>0\) | none |
| Prior alto, fibra zero | \(\nu^\star<\nu<1,p=0\) | existe; \((u,u)\), \(u\in[u_{\min},z_H]\) |
| Prior alto, crença intermediária | \(\nu^\star<\nu<1,p\in(0,\nu^\star]\) | none |
| Prior alto, crença alta | \(\nu^\star<\nu<1,p\in(\nu^\star,1]\) | existe; \((z_H,z_H)\) |
| Endpoint alto | \(\nu=1,\eta=(*,1)\) | existe; \((z_H,z_H)\) |

Esses vetores preservam também o payoff contrafactual do tipo de probabilidade
zero nos endpoints.

## AX-SUM-1: assinaturas e resumos das fontes

Para \(g\in\{M,U\}\), cada binder \(R_g\) possui:

- uma assinatura exata \(\operatorname{Sig}^{ex}_g(R_g)\), que preserva a lei
  realizada enriquecida e a fibra;
- um resumo econômico \(\operatorname{Sum}^{econ}_g(R_g)\), que preserva a
  fibra e as leis anônimas realizadas condicionais ao tipo.

Os pacotes-fonte provam a existência de extratores Borel

\[
H_{g\theta}(\operatorname{Sum}^{econ}_g)=V_g^\theta,
\]

\[
P_{g\theta}(\operatorname{Sum}^{econ}_g)=A_g^\theta,
\]

\[
L_{g\theta}(\operatorname{Sum}^{econ}_g)=\bar\Gamma_g^\theta,
\]

onde \(A_g^\theta\) é a probabilidade de acordo imediato e
\(\bar\Gamma_g^\theta\) é a lei anônima do registro realizado. Não assuma que o
resumo recupera suportes nomeados, mapas públicos ponto a ponto ou funções
off-path.

# Objeto exato de comparação

## Definição

O produto fibrado de binders completos é

\[
J_{AC}^{bind}(d,\eta)
=B_M(d,\eta)\times_{(d,\eta)}B_U(d,\eta).
\]

Explicitamente,

\[
J_{AC}^{bind}(d,\eta)
=\{(R_M,R_U):
R_M\in B_M(d,\eta),
R_U\in B_U(d,\eta),
\text{ambos permanecem atômicos}\}.
\]

Atômico significa que toda coordenada de uma instituição vem do mesmo binder
completo. É proibido combinar estratégia, payoff, posterior ou outcome de
membros distintos da correspondência-fonte.

Não se exige que os dois mundos contrafactuais tenham a mesma proposta, o mesmo
suporte, a mesma coalizão nomeada, a mesma continuação selecionada ou a mesma
realização aleatória.

A imagem formal é

\[
J_{AC}^{ex}(d,\eta)
=\{(\operatorname{Sig}^{ex}_M(R_M),
     \operatorname{Sig}^{ex}_U(R_U)):
  (R_M,R_U)\in J_{AC}^{bind}(d,\eta)\}.
\]

## Teorema T1 — compatibilidade necessária e suficiente

\(J_{AC}^{bind}(d,\eta)\) é exatamente o conjunto de comparações privadas
admissíveis na fibra.

### Prova fornecida

**Necessidade.** Uma comparação institucional mantém fixa a economia e a
convenção off-path. Cada coordenada deve ser um PBE completo de sua própria
regra. A atomicidade impede splicing.

**Suficiência.** Cada binder já é internamente racional, Bayes-consistente e
completo em sua instituição. Emparelhar dois jogos contrafactuais não altera os
incentivos de nenhum deles. Como o game form não contém restrição ou sorteio
cross-world, não existe condição cruzada adicional além de \(d\) e \(\eta\)
comuns. \(\square\)

### Ponto a auditar

Verifique se a suficiência realmente segue da ausência de estrutura
cross-world. Se considerar necessária alguma condição adicional, identifique a
primitiva ou o claim que a impõe; não acrescente por preferência uma correlação
que o jogo não contém.

# Operação econômica e datas

Para \(g\in\{M,U\}\) e \(\theta\in\{0,1\}\), extraia do mesmo binder:

\[
V_g^\theta=\text{payoff de }H\text{ na data A},
\]

\[
A_g^\theta=\Pr(\text{acordo imediato}\mid\theta),
\qquad
D_g^\theta=1-A_g^\theta,
\]

e a lei anônima \(\bar\Gamma_g^\theta\).

A orientação é sempre unanimidade menos maioria:

\[
\delta_\theta=V_U^\theta-V_M^\theta,
\]

\[
\delta_E=(1-\nu)\delta_0+\nu\delta_1,
\]

\[
\Delta_A^\theta=A_U^\theta-A_M^\theta,
\qquad
\Delta_D^\theta=-\Delta_A^\theta.
\]

O objeto econômico preserva conjuntamente os quatro payoffs, seus contrastes,
as probabilidades de acordo e as quatro leis anônimas realizadas.

## Teorema T2 — tipo antes do prior e zero desconto adicional

Para todo \((R_M,R_U)\in J_{AC}^{bind}\),

\[
\begin{aligned}
\delta_E
&=[(1-\nu)V_U^0+\nu V_U^1]
 -[(1-\nu)V_M^0+\nu V_M^1]\\
&=(1-\nu)\delta_0+\nu\delta_1.
\end{aligned}
\]

Todos os valores chegam na data A; \(A_C\) aplica fator um e zero novos fatores
de \(\beta\).

### Prova fornecida

A identidade é distributividade depois da importação dos quatro valores por
tipo. As duas fontes já efetuaram sua transformação temporal para a data A.
Descontar novamente mudaria a data econômica do payoff. \(\square\)

### Ponto a auditar

Verifique especialmente os endpoints \(\nu=0,1\): o tipo de massa zero deve
continuar no vetor \((V^0,V^1)\), embora não afete \(\delta_E\).

# Fatorização pelo resumo econômico

## Teorema T3 — fatorização mensurável por operação

Defina \(C_{econ}(R_M,R_U)\) como a tupla da seção anterior. O claim é que
existe uma aplicação Borel \(\bar C_{econ}\) tal que, na mesma fibra,

\[
C_{econ}(R_M,R_U)
=\bar C_{econ}
\left(\operatorname{Sum}^{econ}_M(R_M),
      \operatorname{Sum}^{econ}_U(R_U)\right).
\]

### Prova fornecida

Por AX-SUM-1, payoffs, probabilidades de acordo e leis anônimas são projeções ou
integrais Borel recuperáveis de cada resumo-fonte. Produtos finitos,
projeções, somas, subtrações e combinações afins de aplicações Borel continuam
Borel. Substituir cada coordenada por seu extrator constrói
\(\bar C_{econ}\).

A conclusão cobre somente as operações declaradas. Não cobre igualdade de
mensagens, suportes nomeados, mapas de posterior ponto a ponto, relações entre
planos contrafactuais dos tipos ou funções off-path. \(\square\)

## Corolário C1 — lifting setwise sem recombinação

Defina

\[
\mathcal S_g^{econ}(d,\eta)
=\{\operatorname{Sum}^{econ}_g(R_g):R_g\in B_g(d,\eta)\}.
\]

A imagem econômica exata é

\[
K_{AC}^{econ}(d,\eta)
=\{(s_M,s_U,\bar C_{econ}(s_M,s_U)):
s_M\in\mathcal S_M^{econ}(d,\eta),
s_U\in\mathcal S_U^{econ}(d,\eta)\}.
\]

### Prova fornecida

A inclusão da esquerda para a direita segue de T3. Reciprocamente, cada
\(s_g\) possui, por definição de imagem, pelo menos um binder completo como
pré-imagem. Como a única condição cruzada é a fibra comum, qualquer par dessas
pré-imagens pertence a \(J_{AC}^{bind}\). O levantamento emparelha resumos
inteiros; não escolhe \(V^0\), \(V^1\), posterior ou outcome de pré-imagens
diferentes. \(\square\)

### Pontos a auditar

1. Confirme que a prova é setwise e não requer um seletor Borel global.
2. Verifique que a Borelidade de \(\bar C_{econ}\) vem dos extratores-fonte, não
   da escolha arbitrária de pré-imagens.
3. Tente construir dois resumos com pré-imagens incompatíveis apesar da fibra
   comum. Se conseguir, identifique qual condição de T1 foi omitida.
4. Confirme que o produto de resumos aparece somente depois do produto exato.

# Existência fibra a fibra

## Teorema T4

\[
J_{AC}^{bind}(d,\eta)\ne\varnothing
\quad\Longleftrightarrow\quad
B_M(d,\eta)\ne\varnothing
\text{ e }
B_U(d,\eta)\ne\varnothing.
\]

### Prova fornecida

Essa é a condição de não vacuidade do produto fibrado. Se uma fonte é vazia,
o produto é vazio. Se ambas têm membros na mesma fibra, qualquer par de membros
completos satisfaz T1. \(\square\)

## Consequências por célula

1. Nos endpoints, as duas fontes são não vazias e \(A_C\) existe.
2. No prior baixo interior, \(A_C\) só pode existir em \(\rho=0\), com
   \(\Delta_U\ge0\), e ainda requer
   \(B_M(d,(0,0))\ne\varnothing\).
3. No prior alto interior e \(\rho=0\), ainda é necessária a fibra
   correspondente de \(A_M\).
4. No prior alto interior com \(p>\nu^\star\), ainda é necessária a fibra
   correspondente de \(A_M\).
5. Onde \(A_U\) é none, \(A_C\) é none, mesmo que \(A_M\) exista.
6. Onde \(A_M\) é none, \(A_C\) é none, mesmo que \(A_U\) exista.

Uma célula vazia recebe o status none, nunca payoff zero, NA, infinito ou outro
sentinela numérico. A existência de \(A_M\) para algum \(\rho\) não é promovida
a existência para todo \(\rho\).

# Conjuntos exatos de contraste

## Vetores ligados por assessment

Defina

\[
\mathcal V_g^{01}(d,\eta)
=\{(V_g^0(R_g),V_g^1(R_g)):R_g\in B_g(d,\eta)\}.
\]

O conjunto exato de contrastes por tipo é a diferença de Minkowski dos vetores
completos:

\[
\mathcal D_{01}(d,\eta)
=\mathcal V_U^{01}(d,\eta)-\mathcal V_M^{01}(d,\eta)
=\{u-m:u\in\mathcal V_U^{01},m\in\mathcal V_M^{01}\}.
\]

Não se substitui \(\mathcal V_g^{01}\) pelo produto de suas duas projeções
marginais. Essa substituição permitiria combinar o payoff do tipo baixo de um
assessment com o payoff do tipo alto de outro.

Para \(r\in\{0,1,E\}\), defina

\[
\mathcal D_r(d,\eta)
=\{\delta_r(R_M,R_U):(R_M,R_U)\in J_{AC}^{bind}(d,\eta)\},
\]

\[
\mathcal S_r(d,\eta)
=\{\operatorname{sign}(x):x\in\mathcal D_r(d,\eta)\}.
\]

Quando o produto não é vazio:

- unanimidade domina estritamente em \(r\) se e somente se
  \(\mathcal S_r=\{+1\}\);
- maioria domina estritamente se e somente se
  \(\mathcal S_r=\{-1\}\);
- todos os pares empatam se e somente se \(\mathcal S_r=\{0\}\);
- unanimidade é fracamente superior em todos os pares se e somente se
  \(\mathcal S_r\subseteq\{0,+1\}\);
- maioria é fracamente superior em todos os pares se e somente se
  \(\mathcal S_r\subseteq\{-1,0\}\).

Se a pergunta for estrita, \(\{0,+1\}\) ou \(\{-1,0\}\) indica que a estriteza
depende da seleção. Se o conjunto contém \(+1\) e \(-1\), até a direção do
ranking depende da seleção. Em uma célula none, não existe sinal institucional.

## Multiplicidade de \(A_U\)

Na célula de prior alto com \(p=0\),

\[
(V_U^0,V_U^1)=(u,u),
\qquad
u\in[u_{\min},z_H].
\]

Como \(o_1>o_0\) e \(\beta<1\),

\[
z_H>z_L,
\qquad
z_H>d_H,
\]

logo \(z_H>u_{\min}\): o intervalo é não degenerado. Para um binder fixo de
maioria, os extremos de unanimidade geram contrastes distintos. O valor depende
necessariamente da seleção; o sinal pode continuar robusto se todo o intervalo
ficar do mesmo lado de zero.

# Envelopes derivados

Para uma coordenada escalar \(r\), defina

\[
M_r=\{V_M^r(R_M):R_M\in B_M(d,\eta)\},
\qquad
U_r=\{V_U^r(R_U):R_U\in B_U(d,\eta)\}.
\]

Em uma fibra comparável, como a única compatibilidade cruzada é a fibra comum,

\[
\inf\mathcal D_r=\inf U_r-\sup M_r,
\]

\[
\sup\mathcal D_r=\sup U_r-\inf M_r.
\]

### Prova fornecida

Para quaisquer conjuntos escalares não vazios e limitados \(U,M\),

\[
\inf\{u-m:u\in U,m\in M\}=\inf U-\sup M,
\]

e analogamente para o supremo. A estrutura de produto na mesma fibra permite
todo par \((u,m)\) produzido por binders completos. \(\square\)

O intervalo

\[
[\inf\mathcal D_r,\sup\mathcal D_r]
\]

é apenas o casco intervalar. Ele não afirma que os extremos são atingidos nem
que todo ponto intermediário pertence ao conjunto exato.

### Ponto a auditar

Verifique se as fórmulas continuam corretas quando os conjuntos não são
fechados, e se o texto evita transformar ínfimo/supremo em mínimo/máximo.

# Certificado selection-free de vantagem da maioria

## Lema de teto de unanimidade

Em toda fibra existente e para ambos os tipos,

\[
V_U^\theta\le z_H.
\]

### Prova fornecida

Pela partição AX-AU-2:

- \(z_L<z_H\), pois \(o_0<o_1\);
- \(d_H<z_H\), pois \(z_H-d_H=1-\beta>0\);
- no endpoint baixo, \(\max\{z_L,d_H\}<z_H\);
- na célula baixa existente, o payoff é \(z_L\);
- na célula alta com \(p=0\), \(u\le z_H\);
- nas células alta com \(p>\nu^\star\) e no endpoint alto, o payoff é \(z_H\).

As células none não contêm pares comparáveis. \(\square\)

## Teorema T5 — condição suficiente uniforme

Se

\[
\beta o_1<\frac{c}{m},
\qquad c=m-k,
\]

então, para todo \((R_M,R_U)\in J_{AC}^{bind}(d,\eta)\) e ambos os tipos,

\[
V_M^\theta>V_U^\theta,
\qquad
\delta_\theta<0,
\qquad
\delta_E<0.
\]

Se \(\beta o_1=c/m\), maioria é fracamente superior para ambos os tipos e ex
ante.

### Prova fornecida

De AX-AM-2,

\[
V_M^\theta\ge Z_E=1-\frac{k\beta}{m}.
\]

Do lema anterior,

\[
V_U^\theta\le z_H=1-\beta+\beta^2o_1.
\]

Como \(c=m-k\),

\[
\begin{aligned}
Z_E-z_H
&=1-\frac{k\beta}{m}-\left(1-\beta+\beta^2o_1\right)\\
&=\beta\left(1-\frac{k}{m}-\beta o_1\right)\\
&=\beta\left(\frac{c}{m}-\beta o_1\right).
\end{aligned}
\]

Sob desigualdade estrita,

\[
V_M^\theta\ge Z_E>z_H\ge V_U^\theta.
\]

Na igualdade, substitua \(>\) por \(\ge\). A média ex ante preserva a ordem.
\(\square\)

## Escopo lógico

T5 é suficiente, não necessário. Quando

\[
\beta o_1>\frac{c}{m},
\]

o lower bound de maioria fica abaixo do upper bound de unanimidade. Bounds que
se cruzam não ordenam as correspondências; não se pode concluir que unanimidade
domina.

T5 afirma vantagem do hegemon em payoff. Não afirma que maioria é socialmente
superior, que os Estados fracos preferem maioria ou que a probabilidade de
acordo é maior.

# Acordo, atraso e leis de outcomes

Para cada tipo,

\[
\Delta_A^\theta=A_U^\theta-A_M^\theta,
\qquad
\Delta_D^\theta=-\Delta_A^\theta.
\]

O objeto de outcomes é o par ordenado

\[
\mathcal O_{AC}(d,\eta)
=\left\{
\left(
(\bar\Gamma_M^0,\bar\Gamma_M^1),
(\bar\Gamma_U^0,\bar\Gamma_U^1)
\right):
(R_M,R_U)\in J_{AC}^{bind}(d,\eta)
\right\}.
\]

Não existe probabilidade conjunta entre regras. As leis são preservadas como
um par ordenado, não como uma distribuição sobre pares de realizações. Sem uma
função de bem-estar ou uma ordem autorizada sobre distribuições, \(A_C\) não
produz ranking adicional dos Estados fracos.

# Exemplos adversariais mínimos

Use estes exemplos apenas para testar as fórmulas. Eles não substituem provas.

## Exemplo 1 — região estrita de T5

Tome

\[
N=5,\quad m=4,\quad q=3,\quad k=2,\quad c=2,
\quad \beta=0.9,\quad o_0=0.2,\quad o_1=0.4,\quad \bar y=0.8.
\]

Então

\[
\frac{c}{m}=0.5,
\qquad
\beta o_1=0.36<0.5,
\]

\[
Z_E=1-\frac{2(0.9)}{4}=0.55,
\]

\[
z_H=1-0.9+0.9^2(0.4)=0.424.
\]

O gap certificado é \(0.126\). Verifique que todo par comparável obedece
\(V_M^\theta>V_U^\theta\).

## Exemplo 2 — fronteira fraca

Mantenha \(N=5\), \(m=4\), \(k=2\), \(\beta=0.9\) e escolha

\[
o_1=\frac{c}{m\beta}=\frac{5}{9}.
\]

Mantenha, por exemplo, \(o_0=0.2\) e \(\bar y=0.8\), de modo que o domínio
primitivo continue satisfeito.

Então

\[
Z_E=z_H=0.55.
\]

Os bounds garantem somente dominância fraca de maioria. Não afirmam que todo
par empata.

## Exemplo 3 — fora da região suficiente

Tome \(o_0=0.2\), \(o_1=0.7\) e \(\bar y=0.8\). Então

\[
\beta o_1=0.63>0.5.
\]

T5 fica silencioso. Tente mostrar por que a simples inversão dos bounds não é
uma prova de vantagem da unanimidade.

## Exemplo 4 — multiplicidade na célula alta de \(A_U\)

Tome \(\beta=0.9\), \(o_0=0.2\), \(o_1=0.6\) e \(\bar y=0.8\). Então

\[
\nu^\star=\frac{0.4}{0.8}=0.5,
\]

\[
z_L=0.262,
\qquad
d_H=0.486,
\qquad
z_H=0.586,
\qquad
u_{\min}=0.486.
\]

Para \(\nu>0.5\) e \(p=0\), unanimidade permite

\[
(V_U^0,V_U^1)=(u,u),
\qquad
u\in[0.486,0.586].
\]

Fixe qualquer binder comparável de maioria e confirme que o valor do contraste
varia com \(u\), embora seu sinal possa permanecer constante.

# Testes adversariais obrigatórios

1. Tente formar um par com primitivas iguais, mas \(\rho_M\ne\rho_U\). Confirme
   que ele é excluído do objeto principal.
2. Tente formar um par na mesma fibra usando \(V_M^0\) e \(V_M^1\) de binders
   diferentes. Confirme que a atomicidade o exclui.
3. Tente construir uma lei conjunta entre regras a partir do par ordenado de
   leis. Identifique qual primitiva probabilística estaria faltando.
4. Teste \(\nu=0\) e \(\nu=1\) sem dividir por \(\nu\) ou \(1-\nu\).
5. Teste \(\rho=0\), \(\rho=\infty\), \(p=\nu^\star\) e
   \(p>\nu^\star\).
6. Verifique a fronteira \(\Delta_U=0\) e o desempate inclusivo.
7. Confirme que uma célula none não recebe sinal, payoff ou envelope.
8. Verifique que \(\mathcal D_{01}\) usa vetores completos e não um produto de
   projeções marginais.
9. Teste a classificação quando
   \(\mathcal S_r=\{+1\}\), \(\{0,+1\}\), \(\{-1,0\}\),
   \(\{-1,+1\}\) e \(\{-1,0,+1\}\).
10. Tente invalidar as fórmulas de ínfimo e supremo com conjuntos abertos.
11. Confira a prova \(V_U^\theta\le z_H\) célula por célula.
12. Refaça a identidade de T5 simbolicamente e nos quatro exemplos.
13. Verifique que a condição de T5 é rotulada como suficiente, não necessária.
14. Separe vantagem de payoff de \(H\), probabilidade de acordo e bem-estar dos
    fracos.
15. Confira que \(A_C\) aplica zero novos fatores de \(\beta\).
16. Avalie a diagonal de \(\rho\) como escolha de comparação; não a confunda
    com restrição endógena do PBE.

# Mapa dos claims a auditar

| ID | Claim |
|---|---|
| AC-T1 | O produto fibrado de binders completos é necessário e suficiente. |
| AC-T2 | Os contrastes são calculados por tipo antes do prior e sem novo desconto. |
| AC-T3 | A operação econômica declarada fatora por uma aplicação Borel dos dois resumos. |
| AC-C1 | A imagem setwise usa pares de resumos inteiros e não exige recombinação. |
| AC-AU-PART | A partição das fibras de payoff de unanimidade é transportada sem omissão. |
| AC-T4 | A comparação existe se e somente se ambas as fontes existem na mesma fibra. |
| AC-SIGN | Os conjuntos de sinais caracterizam dominância e dependência de seleção. |
| AC-ENV | Os envelopes são derivados do conjunto exato e não o substituem. |
| AC-U-BOUND | Todo payoff comparável de unanimidade é no máximo \(z_H\). |
| AC-T5 | \(\beta o_1<c/m\) implica vantagem estrita de maioria para os dois tipos e ex ante. |
| AC-OUTCOME | Outcomes são pares ordenados de leis; não há lei conjunta cross-world. |
| AC-SCOPE | T5 não ordena bem-estar, acordo ou o domínio fora da condição suficiente. |

# Formato obrigatório da resposta

Use estas seções, nesta ordem:

1. **Natureza e limite da consulta** — repita que não é parecer formal, gate ou
   aprovação.
2. **Resposta curta ao autor** — em até cinco parágrafos, diga se a arquitetura
   e os resultados parecem tecnicamente sólidos e qual é a principal ressalva.
3. **Reconstrução intuitiva** — explique por que multiplicidade exige comparar
   conjuntos de equilíbrios, não dois números selecionados.
4. **Matriz claim por claim** — uma linha para cada claim da seção anterior,
   com SUPPORTED, NOT SUPPORTED, UNRESOLVED ou MECHANICAL EVIDENCE ONLY e
   justificativa.
5. **Auditoria de T1 e T4** — compatibilidade, mesma fibra, atomicidade,
   suficiência e células none.
6. **Auditoria de T2, T3 e C1** — datas, fatorização Borel, setwise lifting e
   ausência de splicing.
7. **Contrastes, sinais e envelopes** — examine a ligação entre tipos e a
   distinção conjunto/casco intervalar.
8. **Auditoria de T5** — reproduza o bound de unanimidade, a identidade, as
   fronteiras e o escopo suficiente.
9. **Testes adversariais e contraexemplos** — reporte os casos efetivamente
   testados e qualquer construção que invalide um claim.
10. **Escolhas de modelagem versus defeitos** — trate separadamente a diagonal
    de \(\rho\), a ausência de acoplamento cross-world e a inexistência de uma
    ordem de bem-estar.
11. **Correções mínimas** — se necessárias, forneça definição, fórmula ou
    redação substitutiva exata; não redesenhe o jogo silenciosamente.
12. **Recomendação consultiva final** — diga se os resultados podem ser
    aprovados como comparação condicional às fontes congeladas, se exigem
    reparo ou se algo permanece genuinamente não resolvido. Não use PASS/FAIL,
    contagens de severidade ou linguagem de gate.

Para cada conclusão material, use uma destas categorias:

- PROVED — acompanhada de prova;
- COUNTEREXAMPLE — acompanhada de construção verificável;
- MODELING CHOICE — escolha substantiva, não erro lógico;
- MECHANICAL EVIDENCE ONLY — cálculo finito que não substitui prova;
- UNRESOLVED — definição ou argumento insuficiente.

Não aceite T1–T5 por deferência às revisões anteriores. Não rejeite um teorema
apenas porque preferiria outra seleção de equilíbrio ou outro acoplamento entre
contrafactuais. Um defeito exige mostrar que o claim não segue dos inputs
fixados.

# Proveniência, validação e bytes exatos

## Estado institucional antes desta consulta

\(A_C\) foi autorizado, derivado, reparado e submetido a duas revisões formais
dirigidas finais, ambas PASS 0/0/0. A adjudicação independente da rodada final
deu NO_CONFIRMED_DEFECTS, com zero findings atuais confirmados, parciais ou não
resolvidos.

Esses fatos são histórico do protocolo, não axiomas matemáticos. \(A_C\)
permanece pending/unfrozen porque a aprovação autoral terminal ainda não foi
concedida. \(A_R\), migração ao manuscrito, tag, merge e push continuam não
autorizados.

## Snapshot

- branch: agenda-extension-am-msb;
- commit substantivo: efeee0264bfe4f80e042bcced3a10dc313a452fe;
- pacote matemático reparado: 7248c56cca098d86c0117a78f89c4555c0d934d3;
- reparo administrativo final: 76f4540cacc15a8db6f0175e7056a7692433bec5;
- commit dos pareceres finais: 128860d9f3fd903554b17ad8f343a6211d96cc7d;
- commit da adjudicação final: 39268e9d2579b1e072cfa8456a18d30ce89c54de;
- commit que preparou o gate terminal: 2671726.

## Artefatos matemáticos governados

| Artefato | SHA-256 |
|---|---|
| Contrato de \(A_C\) | d09958a447cc440586c000f92c10982ae1f786a94845c602d714c6ff284a8b14 |
| Resultados e provas | 479c0089a1ed6a08dc9ffd8061933d248505c9b753a036f812f5b163586d8e77 |
| Interface estruturada | 103b564bd15af69dbb45c6b57cd16a0228d3c60a24b758ad779f6b75e7fe2cdf |
| Claim ledger reparado | 280f8168cc632fd650e79cc9a4da411b42f24a5f2d845f5e98d337a99ec5ed5b |
| Verificador R | bf69fb434cc05cc53ecab97080989cf2526979c903f17cf0e33c768acb945e51 |
| Output do verificador | 7d039c00e8ab092b8a3402771062ff83c01d1669e75ab8230b5897b8f530965a |
| DAG consumidor | 830aedea4d89007353f0b1da9b7ae623b1680360626521f536abedd7fda42b9c |

O verificador matemático reportou 941 PASS / 0 FAIL. Isso é evidência
mecânica de identidades, fronteiras, domínio e exemplos; não prova T1, T3, C1,
completude das fontes ou ausência de toda objeção matemática.

## Revisões e adjudicação finais

| Artefato | Resultado histórico | SHA-256 |
|---|---|---|
| Parecer formal dirigido 1 | PASS 0/0/0 | 83e6a4a7249f666fb0760ed33b43c3fbff710f39476ef63791f4a9ae55b1c989 |
| Parecer formal dirigido 2 | PASS 0/0/0 | c515bfef9efd594d947bc76b660046f4784dd66de69b9929598a459ad86fdedf |
| Adjudicação final Markdown | NO_CONFIRMED_DEFECTS | e6647a28c5653a6af91f0fc66f81b6af258ef9b04aacb238a38e4da5a57918a3 |
| Adjudicação final JSON | schema 1.0 válido | 53b8803679c078b33ee6f44c8de46b78922e9574648ebcf668f744d6c15decec |

## Manifesto do candidato ao gate terminal

O manifesto
quality_reports/2026-08-30_AC_msb_terminal_gate_candidate_manifest.sha256 tem
SHA-256

~~~text
68eeefe86b8ade64266c1c8c9901ef070742aa2821e356371a5736dabfceaf64
~~~

e verifica 12/12 entradas. Este pacote de consulta foi criado depois dele e não
faz parte dos 12 bytes submetidos à decisão terminal.

## Nota sobre cabeçalhos históricos

Contrato, resultados e interface preservam em seus próprios bytes os rótulos de
status existentes quando foram candidatos. Eles não foram reescritos depois das
revisões porque isso alteraria o objeto revisado. O status corrente é:

~~~text
reviewed and adjudicated / pending / unfrozen /
awaiting terminal author approval
~~~

# Limite institucional final

Mesmo uma consulta externa inteiramente favorável não congela \(A_C\). Uma
objeção encontrada também não altera automaticamente seus bytes ou seu status.
Qualquer finding deve ser confrontado com as fontes exatas e adjudicado antes
de eventual reparo.

A sequência possível depois da consulta é:

1. leitura e decisão do autor sobre a consulta;
2. se houver finding plausível, adjudicação contra os bytes governados;
3. se não houver finding confirmado, aprovação autoral terminal ou rejeição do
   pacote;
4. somente após aprovação terminal, registro de congelamento de \(A_C\);
5. \(A_R\) continuará exigindo autorização separada.
