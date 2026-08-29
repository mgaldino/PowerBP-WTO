---
title: "A_M: anonimidade, operador de Reynolds e assinatura downstream"
subtitle: "Pacote autocontido para leituras consultivas externas não formais — Fable e ChatGPT Web"
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

# Mandato aos leitores externos

Você é um leitor técnico externo de uma extensão de um modelo formal de
barganha política. Empregue rigor de teoria dos jogos, teoria da medida e ação
de grupos, mas **não assuma o papel institucional de parecerista formal do
projeto**.

Este documento será enviado separadamente ao Fable e ao ChatGPT Web. As duas
respostas serão **leituras consultivas externas não formais**. Elas:

- não são pareceres formais independentes;
- não reabrem nem fecham um gate;
- não concedem `PASS`, aprovação ou congelamento;
- não substituem os dois pareceres formais já realizados;
- não autorizam implementação, tag, merge ou consumo downstream;
- servem apenas como insumo técnico para uma decisão autoral posterior.

O Fable permanece inelegível como parecerista formal desta cadeia. A resposta
do ChatGPT Web também não integra o protocolo formal. Não use contagens de
`critical/important/minor` nem dê um veredito `PASS/FAIL`. Em vez disso,
compare as alternativas, prove as afirmações relevantes e formule uma
**recomendação consultiva**.

Produza um arquivo Markdown UTF-8. Identifique no título qual leitor produziu
a resposta e chame o produto de **consulta técnica externa não formal**. Se a
interface não puder criar arquivo baixável, devolva o Markdown completo, sem
texto introdutório fora do documento.

# Pergunta central em uma frase

Quando os Estados fracos são ex ante idênticos, **quais diferenças entre os
planos contingentes dos dois tipos de `H` devem permanecer na assinatura formal
exata de um equilíbrio e quais devem ser apagadas como mera rotulagem?**

Essa é uma decisão sobre o objeto usado para identificar e transportar
equilíbrios. Não é uma decisão sobre a existência do PBE, os incentivos dos
tipos ou os payoffs já derivados.

# Resumo intuitivo

## Dois trabalhos foram atribuídos ao mesmo objeto

A assinatura anônima tentou cumprir simultaneamente duas funções:

1. **registro matemático exato:** preservar no mesmo objeto estratégias,
   crenças, continuação e outcomes, sem recombinar coordenadas de equilíbrios
   diferentes;
2. **resumo econômico:** apagar diferenças produzidas somente pelos nomes dos
   Estados fracos.

O operador de Reynolds foi usado para gerar um representante simétrico. As duas
revisões formais mostraram que ele é uma média invariante e um possível
candidato a resumo, mas não é uma impressão digital completa das órbitas do
perfil inteiro. Sua suficiência como resumo ainda precisa ser provada para cada
uso downstream.

## Exemplo com quatro Estados fracos

Chame os Estados fracos de `A`, `B`, `C` e `D`. Considere os seguintes planos
contingentes, dos quais apenas um será realizado porque `H` tem um único tipo:

| Perfil | Se `H` for baixo | Se `H` for alto |
|---|---|---|
| `P` | paga `{A,B}` | paga `{C,D}` |
| `Q` | paga `{A,B}` | paga `{A,C}` |

Em `P`, as coalizões contrafactuais são disjuntas. Em `Q`, elas têm um Estado
em comum. Nenhuma única troca dos nomes `A,B,C,D` transforma `P` em `Q`, pois
uma permutação preserva o tamanho da interseção.

Entretanto, se simetrizarmos separadamente o plano de cada tipo, cada um passa
a parecer uma loteria uniforme sobre todas as coalizões de tamanho dois. A
média resultante é igual nos dois perfis. Ela apagou não apenas os nomes, mas
também a relação entre os planos dos tipos.

## A pergunta econômica por trás do exemplo

Apenas um tipo existe numa realização do jogo. Portanto nunca observamos
simultaneamente as duas coalizões contrafactuais. É preciso decidir:

- a diferença entre “coalizões disjuntas” e “coalizões sobrepostas” é conteúdo
  do equilíbrio que o objeto exato deve preservar; ou
- ela é uma relação contrafactual sem conteúdo político, desde que se preservem
  os payoffs, a informação revelada e os outcomes anônimos?

Uma segunda pergunta acompanha a primeira: uma estratégia pura que sempre paga
uma coalizão e uma estratégia que sorteia entre coalizões ex ante idênticas são
o mesmo equilíbrio formal ou apenas têm o mesmo resumo substantivo?

# Três dúvidas anteriores que precisam permanecer resolvidas

## Como pode haver separating se os dois tipos recebem a mesma parcela?

`Separating` descreve as **mensagens observáveis**, não a desigualdade dos
payoffs. Se os dois tipos fazem propostas distintas e ambas passam, cada tipo
pode imitar literalmente a proposta do outro. As duas restrições de imitação
forçam, portanto, a mesma parcela para `H`, `z_0=z_1`. Ainda assim, propostas
distintas podem revelar o tipo — por exemplo, quando especificam coalizões ou
distribuições de pacotes diferentes — e recebem posteriores `0` e `1` nos dois
sinais alcançados. Isso é separação de mensagens num ponto de indiferença, não
separação de payoffs.

O que a anonimidade deve fazer com essas mensagens é justamente parte da
decisão atual. Uma troca comum dos nomes dos fracos é rotulagem pura. Já
`pooling` — ambos enviarem a mesma mensagem — não pode ser identificado com
`separating` — cada tipo enviar uma mensagem distinta — por um objeto que
prometa preservar a revelação.

## Como ambos podem atrasar em propostas distintas se um tipo pode imitar o outro?

Ele pode imitar. Um perfil separating em que ambos atrasam só é equilíbrio
quando essa imitação não é lucrativa. Com posterior `0` no sinal do tipo baixo
e posterior `1` no sinal do tipo alto, as restrições relevantes são

\[
D_0(0)\geq D_0(1),
\qquad
D_1(1)\geq D_1(0),
\]

além da ausência de desvio lucrativo fora do caminho. Portanto “cada tipo
prefere sua própria continuação” quer dizer **prefere fracamente** a continuação
induzida por sua mensagem à continuação que obteria imitando o outro. Não quer
dizer que a imitação seja impossível. No contraexemplo usado abaixo, o ramo
`E` é único e `D_\theta(p)=\beta o_\theta` não depende de `p`; as duas
desigualdades valem com igualdade. Cada tipo é indiferente entre as mensagens
rejeitadas, e propostas distintas podem ser sustentadas como melhores respostas.

## A simetria markoviana não deveria eliminar coalizões nomeadas?

Não no nível da estratégia individual de `H`. A restrição M/S/B torna a
**continuação** markoviana e anônima: Estados fracos ex ante idênticos enfrentam
o mesmo preço pivotal e o kernel de continuação os trata simetricamente. A
decisão autoral rejeitou impor que a própria proposta de `H` fosse uma loteria
uniforme. Assim, um PBE pode pagar uma coalizão nomeada; ao permutar os nomes,
obtemos outro PBE com o mesmo conteúdo econômico básico.

O quociente deve identificar esses relabelings puros. A dificuldade nova é que
dois perfis podem não estar ligados por **uma única permutação aplicada aos
planos dos dois tipos**, embora cada plano, isoladamente, seja apenas uma
coalizão do mesmo tamanho. O exemplo `P/Q` abaixo separa exatamente esses dois
casos.

# Escopo da consulta

## Audite

1. a formulação exata do contraexemplo ao Reynolds componentwise;
2. a relação entre invariância e completude para a ação diagonal;
3. a compatibilidade entre os quatro desiderata autorais:
   - anonimidade dos rótulos ex ante idênticos;
   - quociente exato pela mesma permutação no perfil inteiro;
   - preservação da revelação tipo--sinal;
   - colapso de misturas sobre identidades da mesma órbita;
4. as alternativas de definição da assinatura anônima;
5. a arquitetura recomendada em duas camadas — assinatura exata e resumo
   econômico;
6. as condições para que `AC` e `AR` possam consumir uma camada resumida sem
   perda ou recombinação indevida;
7. o reparo local das afirmações pointwise da Seção 8.3.

## Não audite nem rederive

- o jogo-base ou os nós congelados N1--N7;
- a correspondência de continuação `C_M`;
- a existência e a classificação geral dos PBEs de `A_M` fora de qualquer
  interação lógica indispensável com o quociente;
- a arquitetura de crenças, a coordenada `rho` ou o benchmark IC/D1;
- `A_U`, `AC`, `AR` ou o manuscrito;
- a contribuição substantiva geral do paper;
- alternativas longas de modelagem sem relação direta com a pergunta central.

Se enxergar uma objeção a uma escolha autoral, rotule-a como
`MODELING CHOICE`. Não a apresente como erro de prova. Não desenvolva
uma nova arquitetura de crenças ou um novo jogo.

# Fatos formais que podem ser tomados como dados

O snapshot examinado pelos dois pareceres formais é definido pelo manifesto de
SHA-256
`7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6`,
no `HEAD` revisado
`6b94f2f57aaf8615972e27479435be1db7d44d7f`. O `HEAD` posterior
`a3f7f7f59b7508e8039f57ab6172d59b88c23dc4` acrescenta somente os dois
pareceres, a adjudicação e o manifesto do gate; ele não foi o candidato
substantivo revisado.

Para esta consulta, tome os fatos abaixo como inputs já estabelecidos. Não os
rederive, salvo se detectar contradição lógica direta com a solução proposta
para anonimidade.

1. `H` tem tipo privado `theta in {0,1}` e escolhe uma proposta pública
   `y=(z_H,x_1,...,x_m)` num simplex compacto.
2. Sob maioria, `H` precisa comprar `k` votos fracos; o voto fraco é
   as-if-pivotal, e igualdade implica `sim` por `T^Y`.
3. Sob M/S/B, a continuação selecionada depende somente do posterior, o preço
   pivotal é comum aos fracos e a crença genuinamente off-support é constante
   dentro do assessment.
4. Para cada primitiva existe algum `rho` e algum PBE; não se afirma existência
   para todo `rho`.
5. A classificação dos PBEs puros, seus endpoints e suas fronteiras passaram
   nas duas revisões.
6. O teorema misto T4/`AMX-015` passou. Ele exige, para cada tipo,

   \[
   u_\theta(y)\le V_\theta
   \quad\text{para todo }y\in\operatorname{supp}(\lambda),
   \]

   \[
   u_\theta(y)=V_\theta
   \quad\sigma_\theta\text{-quase certamente},
   \]

   além da ausência de desvio lucrativo fora do suporte.
7. A lei conjunta `Gamma_theta`, definida abaixo, é bem formada antes do
   quociente.
8. O conjunto de PBEs é fechado sob uma permutação comum dos Estados fracos.
9. `AMX-011` e o teorema cardinal `AM-MSB-T6`/`AMX-MSB-009` sobreviveram.
10. A simetria comportamental da estratégia de proposta de `H` foi
    explicitamente rejeitada: um equilíbrio individual pode escolher
    coalizões nomeadas assimetricamente.
11. A comparação futura com unanimidade deve ocorrer na mesma fibra `rho`.
12. O verificador `3944 PASS / 0 FAIL` é somente evidência mecânica e não prova
    nenhum dos fatos measure-theoretic acima.

Os pareceres formais deram, cada um, `FAIL` com
`0 critical / 1 important / 1 minor`. A adjudicação confirmou os quatro
source findings e os normalizou em dois defeitos independentes:

- **importante:** a anonimização atual não é um quociente diagonal exato;
- **menor:** três observações auxiliares confundem propriedades
  quase-certamente com afirmações ponto a ponto.

Esses vereditos são dados históricos desta consulta. Não produza uma terceira
contagem ou tente convertê-la em novo gate.

## Mapa resumido dos resultados formais

| Bloco | Estado após a adjudicação | Consequência |
|---|---|---|
| Existência para algum `rho`, classificação pura, endpoints e fronteiras | sobrevive | não rederivar nesta consulta |
| T4/`AMX-015` — membership misto | sobrevive | o `iff` e o controle de desvios permanecem válidos |
| Lei conjunta `Gamma_theta` antes do quociente | sobrevive | continua sendo o binder atômico de estratégias, crenças, continuação e outcomes |
| Fechamento do conjunto de PBEs por permutação comum | sobrevive | permite formar órbitas, mas não prova convexidade nem valida o Reynolds como quociente exato |
| Teorema cardinal `AM-MSB-T6`/`AMX-MSB-009` | sobrevive | ainda há um contínuo de assinaturas sob um quociente diagonal correto |
| Reynolds componentwise como assinatura exata | não sobrevive | `AMX-016` e a segunda metade de `AMX-MSB-010` ficam bloqueados |
| Frases pointwise da Seção 8.3 | reparo local necessário | substituir por versões atômica, setwise e quase-certamente; T4 não muda |
| Consumo por `AC` | bloqueado | requer decisão autoral, novos bytes e duas novas revisões formais sobre o mesmo hash |

# Objeto formal antes da anonimização

Seja

\[
\mathcal Z
=Y\times[0,1]\times\{0,1\}\times X_M\times\Omega_T,
\]

onde as coordenadas registram proposta, posterior, acordo, seleção da
continuação e outcome terminal. Para cada assessment reduzido `R` e tipo
`theta`, a lei conjunta é

\[
\Gamma_\theta^R
=\mathcal L_\theta^R
\left(y,\pi(y),a(y),\chi(\pi(y)),\omega_T\right)
\in\mathcal P(\mathcal Z).
\]

Todos os payoffs, probabilidades de acordo, outcomes terminais e distribuições
de posteriores são marginais ou integrais da mesma `Gamma_theta`. Portanto a
dupla

\[
x=(\Gamma_0,\Gamma_1)
\in\mathcal P(\mathcal Z)^2
\]

é uma unidade atômica. Não se pode escolher uma marginal de uma dupla e outra
marginal de outra dupla.

A assinatura candidata era

\[
\operatorname{Sig}_M(R)
=\left(\rho,\nu_{\mathrm{off}},[x]_{\mathrm{anon}}\right).
\]

O problema está apenas na definição de `[x]_anon`.

# Ação das permutações

Seja `G=S_m`, o grupo finito das permutações dos Estados fracos. Para `g in G`,
a mesma permutação atua nas identidades fracas da proposta, dos votos, dos
payoffs e do outcome terminal. Ela não altera `rho`, `nu_off`, o valor do
posterior nem o rótulo anônimo da continuação.

A ação diagonal sobre a dupla é

\[
g\cdot x
=\left(g_\#\Gamma_0,g_\#\Gamma_1\right).
\]

O lema de fechamento já estabelecido afirma:

\[
R\text{ gera PBE}
\quad\Longrightarrow\quad
g\cdot R\text{ gera PBE para todo }g\in G.
\]

O lema não afirma que a média das estratégias seja PBE nem que o conjunto de
PBEs seja convexo.

# O operador de Reynolds e seu limite

Para uma ação linear de um grupo finito, o operador de Reynolds é a média das
imagens do objeto:

\[
\mathcal R(x)=\frac1{|G|}\sum_{g\in G}g\cdot x.
\]

Ele projeta objetos numa região invariante: depois da operação, trocar os nomes
dos Estados não altera o resultado. Invariância, porém, não implica que a média
seja um invariante completo da órbita. Objetos em órbitas diferentes podem ter
a mesma média.

No pacote, a definição foi

\[
\mathcal R_{\mathrm{cw}}(x)
=\frac1{|G|}\sum_{g\in G}
\left(g_\#\Gamma_0,g_\#\Gamma_1\right).
\]

Como a soma de pares é componentwise,

\[
\mathcal R_{\mathrm{cw}}(x)
=\left(
\frac1{|G|}\sum_g g_\#\Gamma_0,
\frac1{|G|}\sum_g g_\#\Gamma_1
\right).
\]

O índice comum `g` não permanece no objeto final. O operador guarda duas
médias marginais, mas não guarda a relação entre elas.

# Contraexemplo mínimo já adjudicado

Use `N=5`, de modo que `m=4` e `k=2`, com

\[
\beta=.9,\qquad o_0=.7,\qquad o_1=.8,
\qquad\nu=.5,\qquad\rho=1.
\]

O ramo de continuação `E` é único e produz

\[
r=.225,\qquad A=.55,
\qquad D_0=.63,\qquad D_1=.72.
\]

Para uma coalizão `C` de dois Estados fracos, defina a proposta

\[
y_C=(.8,.1\mathbf 1_C).
\]

Ela é factível e rejeitada porque cada pagamento `.1` é inferior ao preço
`.225`. Os dois tipos preferem o atraso ao melhor acordo. Sejam `R^P` e `R^Q`
assessments completos separating com atraso dos dois tipos e com os seguintes
pares de marginais de proposta:

\[
P_Y=
\left(
(\operatorname{pr}_Y)_\#\Gamma_0^{R^P},
(\operatorname{pr}_Y)_\#\Gamma_1^{R^P}
\right)
=(\delta_{y_{\{1,2\}}},\delta_{y_{\{3,4\}}}),
\]

\[
Q_Y=
\left(
(\operatorname{pr}_Y)_\#\Gamma_0^{R^Q},
(\operatorname{pr}_Y)_\#\Gamma_1^{R^Q}
\right)
=(\delta_{y_{\{1,2\}}},\delta_{y_{\{1,3\}}}).
\]

Ponha

\[
x^P=(\Gamma_0^{R^P},\Gamma_1^{R^P}),
\qquad
x^Q=(\Gamma_0^{R^Q},\Gamma_1^{R^Q})
\in\mathcal P(\mathcal Z)^2.
\]

No perfil `P_Y`, a interseção das coalizões tem cardinalidade zero. Em `Q_Y`, tem
cardinalidade um. Esse número é preservado por qualquer permutação comum;
portanto `x^P` e `x^Q` pertencem a órbitas diagonais distintas.

Contudo, para cada tipo separadamente, a média sobre `S_4` é uniforme sobre as
seis coalizões de tamanho dois. As demais coordenadas de `Gamma_theta` —
posterior `theta`, atraso, continuação `E` e kernel terminal — coincidem por tipo
nos dois assessments e são equivariantes. Logo, agora no domínio correto,

\[
\mathcal R_{\mathrm{cw}}(x^P)
=\mathcal R_{\mathrm{cw}}(x^Q).
\]

Este contraexemplo foi reproduzido pelos dois pareceres com regiões de payoff
diferentes e confirmado na adjudicação. Considere o diagnóstico estabelecido.
O objeto da consulta é a solução conceitual e formal.

# O conflito entre as decisões anteriores

A clarificação aprovada exige simultaneamente:

1. **anonimidade:** rótulos dos Estados fracos ex ante idênticos não devem
   multiplicar classes sem conteúdo;
2. **quociente diagonal exato:** a mesma permutação deve atuar no perfil
   inteiro, e a igualdade da assinatura formal exata deve identificar
   precisamente uma órbita dessa ação, não uma união não declarada de órbitas;
3. **preservação da revelação:** pooling e separating não podem ser confundidos,
   inclusive quando os tipos retêm a mesma parcela de `H` e diferem apenas pela
   coalizão observável;
4. **colapso de misturas:** misturas sobre identidades da mesma órbita deveriam
   pertencer à mesma classe substantiva. Os bytes aprovados não especificam
   qual das três noções de mistura definidas abaixo pretendem colapsar.

O problema não é que qualquer par desses objetivos seja obviamente incoerente.
O problema é que a dupla de marginais `(Gamma_0,Gamma_1)` não fornece uma
solução canônica que cumpra os quatro:

- a órbita diagonal ordinária cumpre 1--3, mas distingue uma estratégia pura de
  seus baricentros mistos não degenerados;
- o Reynolds componentwise é invariante sob a ação diagonal, mas não é um
  invariante completo das órbitas; ele cumpre algumas leituras fortes de 1 e 4
  ao custo de identificar órbitas distintas e pode apagar relações relevantes
  para 3;
- acrescentar um acoplamento entre as randomizações contrafactuais pode tentar
  preservar tudo, mas esse acoplamento não é determinado pelo PBE.

## Três significados possíveis de “mistura sobre a órbita”

Seja

\[
\mathcal X=\mathcal P(\mathcal Z)^2,
\qquad q\in\Delta(G).
\]

Há pelo menos três objetos matemáticos distintos que a expressão anterior pode
designar:

1. **loteria de órbita retendo o sorteio comum:**

   \[
   L_q(x)=\sum_{g\in G}q_g\,\delta_{g\cdot x}
   \in\mathcal P(\mathcal X).
   \]

   Aqui o índice comum `g` permanece como variável latente no metaespaço; o
   domínio deixou de ser \(\mathcal X\) e passou a ser
   \(\mathcal P(\mathcal X)\).

2. **baricentro comum no espaço de pares:**

   \[
   B_q^{\mathrm{com}}(x)
   =\sum_{g\in G}q_g(g\cdot x)
   =\left(
   \sum_gq_g g_\#\Gamma_0,
   \sum_gq_g g_\#\Gamma_1
   \right)
   \in\mathcal X.
   \]

   Os pesos são os mesmos por tipo, mas o sorteio comum já não é uma coordenada
   observável do objeto.

3. **baricentro componentwise com pesos próprios por tipo:** para
   `q^0,q^1 in Delta(G)`,

   \[
   B_{q^0,q^1}^{\mathrm{cw}}(x)
   =\left(
   \sum_gq_g^0 g_\#\Gamma_0,
   \sum_gq_g^1 g_\#\Gamma_1
   \right)
   \in\mathcal X.
   \]

   Essa é a leitura mais ampla de “cada tipo pode misturar entre identidades”.

Denote por `Mix_G^com(x)` e `Mix_G^cw(x)` os conjuntos de todos os baricentros
dos itens 2 e 3, respectivamente. Nenhum deles deve ser presumido como imagem
de um único assessment: a compatibilidade com um mapa público comum `pi(y)` é
uma das questões da consulta. Avalie separadamente as três leituras; não escolha
silenciosamente uma delas como se já tivesse sido decidida pelo autor.

# Alternativas para decisão autoral

## Alternativa A — órbita diagonal exata

Defina

\[
[x]_G=\{g\cdot x:g\in G\}.
\]

Uma codificação canônica possível é a lei uniforme da órbita no espaço de
pares:

\[
\Lambda_x
=\frac1{|G|}\sum_{g\in G}\delta_{g\cdot x}
\in\mathcal P\!\left(\mathcal P(\mathcal Z)^2\right).
\]

Para uma ação de grupo finito, verifique se

\[
\Lambda_x=\Lambda_{x'}
\quad\Longleftrightarrow\quad
x'\in G\cdot x.
\]

**Vantagens:** preserva a mesma permutação, é um invariante completo da órbita
ordinária e não exige acoplamento contrafactual adicional.

**Custo:** estratégias mistas com pesos diferentes continuam formalmente
distintas quando não são relacionadas por uma permutação. A decisão anterior
sobre misturas teria de ser restringida ou reinterpretada.

## Alternativa B — equivalência marginal mais grossa

Trate a relação entre as coalizões contrafactuais dos dois tipos como sem
conteúdo econômico. Use marginais anônimas que preservem apenas payoffs,
posteriores, acordo, continuação e outcomes anônimos relevantes.

**Vantagens:** elimina grande multiplicidade por identidade e aproxima a
assinatura do que `AC/AR` parecem consumir substantivamente.

**Custos:** abandona a alegação de que a equivalência é exatamente a órbita de
uma permutação comum. É necessário definir o mapa anônimo no nível do
experimento de sinalização inteiro, provar que pooling e separating permanecem
distintos e mostrar que o resumo é suficiente para cada operação downstream.
Não basta conservar o Reynolds atual e mudar seu nome.

## Alternativa C — assinatura enriquecida por acoplamento

Acrescente uma lei conjunta contrafactual `Xi` cujas marginais sejam
`Gamma_0,Gamma_1`, ou um binder de semente comum para as randomizações dos
tipos, e aplique a ação diagonal a esse objeto enriquecido.

**Vantagem:** pode registrar simultaneamente a relação entre os planos e as
loterias dentro das órbitas.

**Custos:** o PBE determina as marginais por tipo, não um acoplamento entre
mundos contrafactuais. Produto independente, semente comum ou outra correlação
são escolhas adicionais e podem criar conteúdo sem interpretação estratégica.

## Alternativa D — arquitetura em duas camadas

Separe as duas funções que foram atribuídas ao Reynolds:

1. **camada formal exata:** mantenha a dupla completa `x` a menos da órbita
   diagonal `[x]_G`, ou sua lei de órbita `Lambda_x`. Essa é a fonte de verdade
   que `AC/AR` poderão consumir se e quando forem autorizados;
2. **camada de relato econômico:** derive de `x` um resumo anônimo
   muitos-para-um com payoffs, posterior, probabilidades de acordo e outcomes
   anônimos. O Reynolds pode aparecer aqui somente como resumo, nunca como
   quociente exato ou representante necessariamente implementável por um PBE.

Sob essa arquitetura, duas estratégias podem ter o mesmo resumo econômico e
continuar sendo elementos diferentes da correspondência exata.

**Recomendação provisória deste pacote para teste:** Alternativa D. Ela preserva
informação na interface exata e permite descartá-la depois, quando um teorema de
invariância ou suficiência justificar o descarte. Para adotá-la, a frase
“misturas sobre identidades pertencem à mesma classe” passaria a significar
“recebem o mesmo resumo substantivo”, não “são o mesmo elemento da
correspondência formal exata”.

Não aceite essa recomendação por deferência. Tente refutá-la e diga se A, B ou
C é superior.

# Questões técnicas obrigatórias

Responda, na ordem:

1. Para cada uma das três leituras `L_q`, `Mix_G^com` e `Mix_G^cw`, os quatro
   desiderata da seção **O conflito entre as decisões anteriores** são
   simultaneamente realizáveis? Declare primeiro se a relação vive em
   \(\mathcal X\) ou exige ampliar o domínio para
   \(\mathcal P(\mathcal X)\); depois prove ou dê um contraexemplo mínimo.
2. `Lambda_x` é um invariante completo da órbita diagonal para o grupo finito
   `S_m`? Dê uma prova curta e declare os espaços mensuráveis necessários.
3. Existe uma relação de equivalência sobre \(\mathcal X\) que identifique `x`
   com todos os elementos de `Mix_G^com(x)` sem também identificar `x^P` e
   `x^Q`? E se `Mix_G^com` for substituído por `Mix_G^cw`? Responda aos dois
   casos separadamente, sem introduzir variável latente ou acoplamento. Se a
   resposta for positiva, defina a relação e prove reflexividade, simetria e
   transitividade. Diga também se manter `L_q(x)` no metaespaço satisfaz o
   desiderato ou apenas registra a randomização sem identificar os objetos.
4. O par componentwise simetrizado pode deixar de ser a imagem de um único
   assessment com um mapa público comum `pi(y)`? Se sim, isso impede seu uso
   como assinatura exata ou somente como representante implementável?
5. Compare A--D quanto a:
   - completude da equivalência;
   - preservação da revelação;
   - mensurabilidade;
   - compatibilidade com estratégias mistas;
   - ausência de recombinação;
   - suficiência para `AC/AR`.
6. A arquitetura em duas camadas é formalmente segura? Especifique exatamente
   qual camada cada consumidor downstream pode usar e qual teorema de
   suficiência seria necessário para usar apenas o resumo.
7. Se recomendar acoplamento, explique sua interpretação estratégica e por que
   a escolha não seria arbitrária.
8. Proponha redação substitutiva precisa para:
   - a decisão autoral de anonimidade;
   - a definição de assinatura de `A_M`;
   - `AMX-016`;
   - a parte afetada de `AMX-MSB-010`.
9. Diga explicitamente se o problema é ortogonal à arquitetura de crenças e à
   coordenada `rho`. Não reabra essa arquitetura sem uma implicação lógica
   demonstrada.
10. Confirme ou refute que o finding menor da Seção 8.3 tem reparo puramente
    local, conforme a seção seguinte.

# Finding menor: ponto do suporte não significa uso positivo

T4 distingue corretamente duas condições:

\[
u_\theta(y)\le V_\theta
\quad\text{em todo ponto do suporte},
\]

\[
u_\theta(y)=V_\theta
\quad\sigma_\theta\text{-quase certamente}.
\]

As três primeiras observações auxiliares da Seção 8.3 falam, porém, como se
todo ponto do suporte fosse usado com probabilidade positiva. Isso é falso em
leis atomless.

A correção proposta é:

1. se `lambda({y})>0` e `0<pi(y)<1`, ambos os tipos dão massa positiva ao átomo
   e as igualdades de melhor resposta podem ser afirmadas naquele ponto;
2. fora dos átomos, as igualdades relevantes valem quase certamente nos
   conjuntos correspondentes;
3. para prior interior, as afirmações de posterior extremo são setwise:

   \[
   \sigma_1(\{y:\pi(y)=0\})=0,
   \qquad
   \sigma_0(\{y:\pi(y)=1\})=0;
   \]
4. a desigualdade de imitação continua válida ponto a ponto no suporte por T4;
5. T4/`AMX-015` e `AMX-011` não são alterados.

Verifique essa redação, mas não use o finding menor para reabrir T4.

# Testes adversariais mínimos

Além do contraexemplo formal `x^P/x^Q` — abreviado intuitivamente como `P/Q` —,
teste:

1. **relabeling puro:** dois perfis ligados por uma única permutação devem ser
   equivalentes;
2. **interseção diferente:** perfis com interseções contrafactuais diferentes
   não devem ser colapsados se a equivalência escolhida promete ser diagonal;
3. **pura versus uniforme:** determine se devem ser formalmente iguais ou apenas
   compartilhar um resumo;
4. **separating com mesma parcela de `H`:** a diferença de posterior nos sinais
   alcançados deve sobreviver;
5. **pooling versus separating:** nunca podem ser confundidos por uma
   anonimização que pretenda preservar revelação;
6. **misturas não uniformes:** teste pesos `(.9,.1)` e `(.5,.5)` dentro da mesma
   órbita;
7. **posterior comum:** cheque se o representante proposto é compatível com um
   único mapa público `pi`;
8. **atomless:** cheque mensurabilidade e se a equivalência proposta continua
   definida para leis Borel gerais;
9. **fibra:** confirme que `rho` permanece uma coordenada invariável e comum no
   futuro produto fibrado;
10. **não recombinação:** nenhum resumo pode combinar coordenadas provenientes
    de assessments diferentes.

# Formato obrigatório da resposta

Use as seguintes seções:

1. `Natureza e limite da consulta` — repita que não é parecer formal nem gate.
2. `Resposta curta ao autor` — em até cinco parágrafos, explique o que deve ser
   decidido em linguagem natural.
3. `Reconstrução formal do problema` — defina ação, Reynolds, órbita e
   contraexemplo.
4. `Os quatro desiderata` — diga quais são compatíveis e sob qual objeto.
5. `Avaliação das alternativas A--D` — tabela comparativa e recomendação.
6. `Provas ou contraexemplos` — nenhuma conclusão material sem demonstração.
7. `Definição recomendada` — dê o objeto matemático completo, domínio,
   codomínio e relação de equivalência.
8. `Redação substitutiva` — texto pronto para a clarificação e para os claims
   afetados.
9. `Finding menor da Seção 8.3` — confirme ou corrija o reparo local.
10. `Implicações downstream` — o que `AC/AR` podem consumir e o que permanece
    bloqueado.
11. `Recomendação consultiva final` — escolha A, B, C, D ou outra alternativa
    precisamente definida; não use `PASS/FAIL`.

Para cada conclusão relevante, marque uma das seguintes categorias:

- `PROVED` — acompanhado de prova;
- `COUNTEREXAMPLE` — acompanhado de construção verificável;
- `MODELING CHOICE` — escolha substantiva, não erro lógico;
- `MECHANICAL EVIDENCE ONLY` — cálculo que não substitui prova;
- `UNRESOLVED` — definição ou argumento ainda insuficiente.

Não produza uma arquitetura alternativa longa. Se uma quinta alternativa for
indispensável, descreva-a em no máximo uma seção e explique exatamente qual
defeito das alternativas A--D ela resolve.

# Referências internas e proveniência

Os caminhos abaixo são referências de proveniência no repositório. Este pacote
é autocontido; a ausência de acesso local a um caminho não autoriza inferir que
uma definição formal aqui reproduzida está faltando.

| Artefato | Caminho | SHA-256 |
|---|---|---|
| Emenda M/S/B aprovada | `quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md` | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação de anonimidade e kernel | `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md` | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| Decisões pós-consulta anterior | `quality_reports/plans/2026-08-29_decisoes_pos_parecer_chatgpt_A_M.md` | `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471` |
| Resultados reparados | `model_redesign/agenda_extension_A_M_msb_results.md` | `020ffbb1d67daaabf9a330be1f0f3ea91d42b55e3b7047787a8c8eb06f6912ed` |
| Claim ledger | `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv` | `56073462c367277a1863d2a4eeb817e49c57845b4cd0f04c404ff57bfc4b38e1` |
| Manifesto do candidato revisado | `quality_reports/2026-08-29_A_M_msb_post_review_repair_manifest.sha256` | `7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6` |
| Parecer formal 1 | `quality_reports/2026-08-29_A_M_msb_formal_review_1.md` | `29e2db70cffc0931f2c5838f48113cf5d21cfcd60b1a3a361c38c1967fb49187` |
| Parecer formal 2 | `quality_reports/2026-08-29_A_M_msb_formal_review_2.md` | `a072d86ecbdecbda26b9197a4523e49c35bec14f0d1faf34dfdd4da8ea5bc1ce` |
| Adjudicação Markdown | `quality_reports/adjudication/a_m_msb_formal_reviews/7905d48837f6/adjudication_round1.md` | `976b1df0d172480e5ff20bbcb46cc2bffd80d52b5e02f8184c7a20a006e797f8` |
| Adjudicação JSON | `quality_reports/adjudication/a_m_msb_formal_reviews/7905d48837f6/adjudication_round1.json` | `33000f835021a580a3f7b6f2808c02ff2d0a9360c595a9bd6785c8a0f39e07b0` |
| Manifesto do gate | `quality_reports/2026-08-29_A_M_msb_formal_review_gate_manifest.sha256` | `aa2f5296b3c9d294a1973f15699e905f91c8a50f1cf604c161e1d5f146f53538` |

## Localizadores principais

- decisão autoral de anonimidade: clarificação, linhas 38--97;
- classificação separating e restrições de imitação: resultados, linhas
  467--522;
- T4 e distinção pointwise/quase-certamente: resultados, linhas 755--812;
- lei conjunta `Gamma_theta`: resultados, linhas 814--918;
- ação das permutações e Reynolds atual: resultados, linhas 920--977;
- assinatura/fibra downstream: resultados, linhas 979--1056;
- teorema cardinal: resultados, linhas 1058--1091;
- contraexemplos e opções: adjudicação, Seções 4 e 6;
- vereditos formais: parecer 1, Seções 5--12; parecer 2, Seções 10--13.

# Limite institucional final

Mesmo que Fable e ChatGPT Web concordem integralmente numa recomendação, essa
concordância não altera o estado `BLOCKED`. A sequência posterior é:

1. decisão autoral explícita sobre a equivalência;
2. implementação em novos bytes por implementador separado;
3. novo manifesto e hash;
4. duas novas revisões formais independentes sobre exatamente os mesmos bytes;
5. aprovação autoral terminal à luz desses pareceres;
6. somente então eventual liberação de `A_M` para consumo por `AC`.
