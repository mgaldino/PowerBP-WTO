# Consulta técnica externa não formal — ChatGPT Web

## Arquitetura de simetria, anonimidade e assinatura downstream em `A_M`

**Data:** 29 de agosto de 2026  
**Natureza:** leitura consultiva externa não formal  
**Objeto:** decisão autoral sobre o quociente de simetria dos Estados fracos ex ante idênticos

---

# 1. Natureza e limite da consulta

Esta é uma **consulta técnica externa não formal**. Ela não é parecer formal independente, não reabre nem encerra gate, não autoriza implementação, tag, merge ou consumo downstream e não altera o estado institucional descrito no pacote. A análise toma como dados os resultados que o documento declara já estabelecidos — em particular, a validade da lei conjunta `Gamma_theta` antes do quociente, o fechamento do conjunto de PBEs por uma permutação comum e o contraexemplo `x^P/x^Q` — e examina apenas a decisão sobre anonimidade, simetria e assinatura.

A questão central não é se `P` e `Q` geram os mesmos payoffs realizados ou se a interseção entre coalizões contrafactuais tem interpretação política substantiva. A questão é anterior: **que objeto será chamado de identidade formal exata de um equilíbrio e que informação será descartada apenas numa camada de resumo?**

A recomendação abaixo é, portanto, uma recomendação de arquitetura. Onde há uma implicação matemática, ela é marcada como `PROVED` ou `COUNTEREXAMPLE`. Onde a decisão depende do significado econômico que o autor quer atribuir ao objeto, ela é marcada como `MODELING CHOICE`.

---

# 2. Resposta curta ao autor

**PROVED.** Se a assinatura formal promete ser o quociente exato pela ação diagonal de `S_m`, então a relação entre os planos contingentes dos dois tipos — inclusive a cardinalidade da interseção entre coalizões contrafactuais — deve permanecer na assinatura exata. `P` e `Q` não pertencem à mesma órbita diagonal e, portanto, não podem receber a mesma assinatura exata sob essa promessa.

**MODELING CHOICE.** Isso não obriga o autor a atribuir conteúdo político substantivo à diferença entre “coalizões disjuntas” e “coalizões sobrepostas”. A diferença pode ser descartada num resumo econômico posterior. O ponto é apenas que não se deve descartá-la no mesmo objeto que se apresenta como impressão digital completa da órbita diagonal.

**PROVED.** A arquitetura mais segura é a Alternativa D, com uma precisão adicional: a camada exata deve ser a órbita diagonal `[x]_G`, codificada sem escolha de representante pela lei de órbita `Lambda_x`; a camada econômica deve ser um mapa muitos-para-um explicitamente declarado como resumo, de preferência o pushforward de cada `Gamma_theta` para o espaço de registros realizados anônimos `Z/G`. O Reynolds componentwise pode ser usado como estatística equivalente em certos consumos marginais, mas não deve ser chamado de quociente exato nem de PBE representativo.

**COUNTEREXAMPLE.** Não existe relação de equivalência em `X=P(Z)^2` que identifique cada `x` com **todos** os baricentros comuns de sua órbita e, simultaneamente, mantenha `x^P` e `x^Q` distintos. Ambos têm o mesmo baricentro uniforme. Para misturas componentwise, a impossibilidade é ainda mais forte: relabelings independentes por tipo já transformam diretamente a estrutura `P` na estrutura `Q`.

**MODELING CHOICE.** Assim, “misturas sobre identidades da mesma órbita pertencem à mesma classe” deve ser reescrito como: **elas recebem o mesmo resumo substantivo anônimo**, não como: **elas são o mesmo elemento da correspondência formal exata**. `AC` e `AR` só poderão consumir apenas o resumo depois de um teorema de suficiência/fatorização específico para cada operação downstream.

---

# 3. Reconstrução formal do problema

## 3.1 Espaços mensuráveis e ação do grupo

Assuma que

\[
(\mathcal Z,\mathscr Z)
\]

é um espaço Borel padrão. Isso é satisfeito, por exemplo, se `Y`, `X_M` e `Omega_T` forem espaços Borel padrão, com `Y` um subconjunto Borel de um espaço euclidiano, e se `Z` receber a sigma-álgebra produto. Escreva

\[
\mathcal X=\mathcal P(\mathcal Z)^2
\]

com a sigma-álgebra produto das sigma-álgebras de avaliação em `P(Z)`. Sob uma realização polonesa de `Z`, esta é também a sigma-álgebra de Borel associada à topologia fraca.

Para cada `g in G=S_m`, seja

\[
T_g:\mathcal Z\to\mathcal Z
\]

uma bijeção Borel que relabela, de modo coerente, todas as coordenadas nomeadas dos Estados fracos na proposta, nos votos, nos payoffs registrados e no outcome terminal. O grupo não altera `rho`, `nu_off`, o posterior numérico nem o rótulo anônimo da continuação. A ação induzida em `X` é

\[
g\cdot x
=
\bigl((T_g)_\#\Gamma_0,(T_g)_\#\Gamma_1\bigr),
\qquad
x=(\Gamma_0,\Gamma_1).
\]

A ação é diagonal porque **o mesmo** `g` atua nos dois planos de tipo.

## 3.2 Dois objetos que não devem ser confundidos

Há duas médias formalmente diferentes.

A primeira é a média baricêntrica no espaço convexo `X`:

\[
r(x)
=
\frac1{|G|}\sum_{g\in G} g\cdot x
=
\left(
\frac1{|G|}\sum_g (T_g)_\#\Gamma_0,
\frac1{|G|}\sum_g (T_g)_\#\Gamma_1
\right).
\]

Este é o Reynolds componentwise do pacote. Ele é um **primeiro momento** da órbita no espaço convexo de pares de medidas.

A segunda é a lei uniforme da órbita no metaespaço `P(X)`:

\[
\Lambda_x
=
\frac1{|G|}\sum_{g\in G}\delta_{g\cdot x}
\in\mathcal P(\mathcal X).
\]

Aqui cada átomo é o **par inteiro** `g·x`. O suporte de `Lambda_x` retém a órbita diagonal e, portanto, a relação entre as duas coordenadas. Em resumo:

- `r(x)` calcula a média dos pontos da órbita;
- `Lambda_x` registra a distribuição uniforme sobre os pontos da órbita.

A primeira operação pode fazer órbitas diferentes terem o mesmo resultado. A segunda é uma codificação completa da órbita para grupo finito.

## 3.3 O contraexemplo `P/Q`

No perfil `P`, os planos puros pagam coalizões de tamanho dois com interseção vazia entre os tipos. No perfil `Q`, a interseção tem cardinalidade um. Uma permutação comum preserva a cardinalidade da interseção. Logo,

\[
x^Q\notin G\cdot x^P.
\]

Contudo, para cada tipo isoladamente, a média sobre `S_4` distribui massa uniformemente sobre as seis coalizões de tamanho dois. As outras coordenadas são iguais por tipo e equivariantes. Portanto,

\[
r(x^P)=r(x^Q).
\]

**COUNTEREXAMPLE.** A igualdade acima prova que o Reynolds componentwise não é um invariante completo da órbita diagonal. O índice comum `g` usado durante a soma não permanece como coordenada no resultado; resta apenas um par de médias marginais.

## 3.4 Separação, pooling e a coordenada de posterior

A ação de `G` não altera o posterior numérico registrado em `Gamma_theta`. Para prior interior:

- num equilíbrio pooling, o posterior on-path é o prior nos sinais usados por ambos os tipos;
- num equilíbrio separating, os sinais alcançados pelos tipos carregam posteriores extremos `0` e `1`.

Assim, qualquer objeto que retenha a coordenada de posterior em cada lei de tipo distingue pooling de separating. Isso continua verdadeiro quando os tipos retêm a mesma parcela de `H`: a separação é de mensagens/informação, não de payoffs.

**PROVED.** Uma permutação dos Estados fracos não pode transformar um perfil pooling num perfil separating, pois a permutação não altera a coordenada de posterior nem a estrutura de coincidência on-path necessária à consistência bayesiana.

---

# 4. Os quatro desiderata

Considere os quatro requisitos:

1. **anonimidade:** relabelings comuns dos Estados fracos não multiplicam classes;
2. **exatidão diagonal:** duas assinaturas exatas são iguais se e somente se os pares pertencem à mesma órbita de uma única permutação comum;
3. **preservação da revelação:** pooling e separating permanecem distintos;
4. **colapso forte de misturas:** um objeto puro e todas as suas misturas sobre identidades da órbita pertencem à mesma classe formal.

## 4.1 Resultado geral

**COUNTEREXAMPLE.** Os quatro requisitos não podem ser satisfeitos por uma única relação de equivalência em `X` quando o requisito 4 inclui todos os baricentros comuns `Mix_G^com(x)`.

A razão é simples. O baricentro uniforme

\[
r(x)=\frac1{|G|}\sum_g g\cdot x
\]

pertence a `Mix_G^com(x)`. Se uma equivalência `~` satisfaz

\[
y\in\operatorname{Mix}_G^{\mathrm{com}}(x)
\quad\Longrightarrow\quad
x\sim y,
\]

então, usando `r(x^P)=r(x^Q)`, temos

\[
x^P\sim r(x^P)=r(x^Q)\sim x^Q.
\]

Por simetria e transitividade, `x^P~x^Q`, contrariando a exatidão diagonal.

Portanto, a decisão não é encontrar uma fórmula mais engenhosa para fazer uma única classe cumprir tudo. A decisão correta é **separar duas noções de igualdade**:

- igualdade formal exata, baseada em órbitas diagonais;
- igualdade de resumo econômico, baseada em um mapa anônimo mais grosso.

## 4.2 Leitura 1 — `L_q(x)` no metaespaço

A loteria

\[
L_q(x)=\sum_{g\in G}q_g\delta_{g\cdot x}
\]

vive em `P(X)`, não em `X`. Cada átomo continua sendo um par completo e, portanto, a relação entre os planos dos tipos é preservada dentro de cada átomo.

### O objeto cru

**PROVED.** Manter `L_q(x)` como objeto cru apenas **registra** a randomização; não identifica `x` com `L_q(x)`. O embedding natural de `x` no metaespaço é `delta_x`, e, salvo casos degenerados,

\[
\delta_x\ne L_q(x).
\]

Além disso, para `q` não uniforme, `L_q` não é invariável a relabeling sem também transformar os pesos. Para `h in G`,

\[
L_q(h\cdot x)
=
\sum_g q_g\delta_{gh\cdot x},
\]

que em geral reatribui os pesos aos pontos da órbita.

### Um quociente possível, mas redundante

Defina o subespaço de loterias concentradas numa única órbita:

\[
\mathfrak M_G
=
\{\mu\in\mathcal P(\mathcal X):
\exists x\in\mathcal X,\ \mu(G\cdot x)=1\}.
\]

Se `Q_X:X→X/G` é o mapa quociente, então, para `mu in M_G`, `Q_X#mu` é uma Dirac em uma única órbita. Defina

\[
\mu\approx_G\nu
\quad\Longleftrightarrow\quad
(Q_X)_\#\mu=(Q_X)_\#\nu.
\]

**PROVED.** `≈_G` é uma relação de equivalência, pois é o kernel de um mapa:

- reflexividade segue de igualdade consigo mesmo;
- simetria segue da simetria da igualdade;
- transitividade segue da transitividade da igualdade.

Além disso,

\[
\delta_x\approx_G L_q(x)
\]

para todo `q`, e

\[
\delta_x\approx_G\delta_{x'}
\quad\Longleftrightarrow\quad
x'\in G\cdot x.
\]

**MODELING CHOICE.** Esta construção realiza os quatro desiderata apenas num sentido qualificado: amplia o domínio para `P(X)` e depois descarta completamente `q`, retornando à órbita subjacente `[x]_G`. Ela é isomorfa à Alternativa A e não oferece uma nova noção estratégica de equilíbrio. Portanto, `L_q` é útil para representar uma randomização externa comum, mas não é necessário para definir a assinatura exata.

## 4.3 Leitura 2 — `Mix_G^com(x)` em `X`

O baricentro comum

\[
B_q^{\mathrm{com}}(x)
=
\sum_g q_g(g\cdot x)
\]

vive em `X`. Os mesmos pesos são aplicados às duas coordenadas, mas o sorteio comum não permanece observável no objeto final.

**COUNTEREXAMPLE.** Não há equivalência em `X` que identifique `x` com todos os elementos de `Mix_G^com(x)` e preserve a distinção diagonal entre `x^P` e `x^Q`. A prova é o argumento do baricentro uniforme acima.

**PROVED.** Usar os mesmos pesos por tipo não resolve o problema. A linearidade transforma a média de pares no par de médias. Sem uma variável latente ou uma medida em `P(X)`, a correlação “o mesmo `g` foi sorteado” desaparece.

## 4.4 Leitura 3 — `Mix_G^cw(x)` em `X`

O baricentro componentwise

\[
B_{q^0,q^1}^{\mathrm{cw}}(x)
=
\left(
\sum_gq_g^0(T_g)_\#\Gamma_0,
\sum_gq_g^1(T_g)_\#\Gamma_1
\right)
\]

vive em `X` e permite pesos distintos por tipo.

**COUNTEREXAMPLE.** A incompatibilidade com a órbita diagonal é ainda mais direta. Como pesos degenerados são admitidos, a regra identificaria

\[
(\Gamma_0,\Gamma_1)
\sim
((T_{g_0})_\#\Gamma_0,(T_{g_1})_\#\Gamma_1)
\]

para `g_0` e `g_1` potencialmente diferentes. Isso é, no mínimo, o quociente por uma ação `G×G`, não pela ação diagonal de `G`. No exemplo `P/Q`, pode-se manter o plano do tipo baixo e relabelar apenas o plano do tipo alto para mudar a interseção contrafactual. Logo, o requisito 2 é abandonado já nos pontos extremos de `Mix_G^cw`.

O argumento do baricentro uniforme também se aplica, porque

\[
r(x)\in\operatorname{Mix}_G^{\mathrm{cw}}(x).
\]

## 4.5 Resposta consolidada à primeira questão obrigatória

| Leitura | Domínio | Os quatro desiderata cabem no objeto cru? | Diagnóstico |
|---|---:|---:|---|
| `L_q(x)` | `P(X)` | Não | Retém o sorteio comum, mas apenas registra a loteria; para `q` não uniforme nem sequer é invariável sem quociente adicional. |
| `L_q(x)` modulo órbita de suporte | subespaço de `P(X)` | Sim, de modo qualificado | O quociente apaga `q` e reduz o objeto à órbita `[x]_G`; é uma recodificação da Alternativa A. |
| `Mix_G^com(x)` | `X` | Não | A equivalência gerada por todos os baricentros colapsa `P` e `Q` via o Reynolds uniforme comum. |
| `Mix_G^cw(x)` | `X` | Não | Além do colapso pelo baricentro uniforme, relabelings independentes por tipo substituem a ação diagonal por algo ao menos tão grosso quanto `G×G`. |

**PROVED.** A única forma de manter os quatro propósitos sem contradição é distribuí-los entre duas camadas: requisitos 1–3 na camada exata; requisito 4 na camada de resumo econômico.

---

# 5. Avaliação das alternativas A--D

| Alternativa | Completude da equivalência | Preservação da revelação | Mensurabilidade | Estratégias mistas | Não recombinação | Suficiência para `AC/AR` |
|---|---|---|---|---|---|---|
| **A — órbita diagonal exata** | **Completa para a ação diagonal.** `Lambda_x` coincide exatamente nas órbitas. | **Sim.** Retém o par completo, inclusive posterior, coincidência de sinais e relação entre tipos. | **Boa.** Grupo finito e ação Borel; `x↦Lambda_x` é Borel. | Mantém leis mistas exatamente como são. Pura e mistura não degenerada continuam distintas, salvo relabeling diagonal. | **Sim.** Cada átomo de `Lambda_x` é um par inteiro. | É a fonte segura para qualquer operação; o consumidor deve ser invariável a `G` ou operar diretamente no quociente. |
| **B — equivalência marginal mais grossa** | Completa apenas relativamente ao mapa-resumo escolhido, não relativamente à órbita diagonal. | Pode preservar posterior e distinção pooling/separating se o resumo retiver essas coordenadas; pode apagá-las se mal definido. | Administrável com pushforward para `Z/G`. | Pode colapsar pura e misturas de identidades por construção. | Sim, se o resumo for aplicado atomicamente ao mesmo `x`; não, se coordenadas forem montadas a partir de assessments diferentes. | Potencialmente suficiente, mas somente após prova de fatorização de cada consumidor. |
| **C — acoplamento `Xi`** | Completa para o objeto enriquecido, não para o PBE marginal original. | Sim, se o acoplamento e o mapa público forem coerentes. | O espaço de acoplamentos é mensurável sob hipóteses padrão, mas a seleção de um acoplamento canônico carece de justificativa estratégica. | Codifica correlação contrafactual ou semente comum. | Sim dentro de `Xi`, mas acrescenta informação não determinada pelo PBE. | Só é necessária se `AC/AR` consumirem correlação contrafactual genuína fornecida pelas primitivas. |
| **D — duas camadas** | Camada exata completa como A; camada econômica deliberadamente mais grossa como B. | A camada exata preserva tudo; o resumo preserva apenas o que for explicitamente incluído. | Boa nas duas camadas sob espaços Borel padrão e grupo finito. | A camada exata distingue as leis; o resumo pode colapsar misturas de identidade. | **Sim**, desde que ambos sejam funções do mesmo par `x`. | **Melhor arquitetura.** `AC/AR` usam a camada exata por padrão e o resumo apenas após teorema de suficiência. |

## 5.1 Alternativa A

**PROVED.** É a única alternativa entre A--C que satisfaz literalmente a promessa de “quociente diagonal exato” sem acrescentar primitivas. Seu custo — distinguir uma estratégia pura de uma estratégia mista sobre a mesma órbita — não é defeito lógico. É a consequência normal de tratar a distribuição estratégica como parte do equilíbrio formal.

## 5.2 Alternativa B

**MODELING CHOICE.** É legítima se o autor decidir que relações contrafactuais entre os planos de tipos não têm conteúdo nem mesmo para a identidade formal adotada. Nesse caso, porém, a linguagem de “órbita diagonal exata” deve ser abandonada. A relação correta passa a ser o kernel de um mapa-resumo específico.

A forma mais limpa de B não é “conservar o Reynolds e renomeá-lo”, mas construir o espaço de registros realizados anônimos `Z/G` e empurrar cada lei para esse quociente. Essa proposta é detalhada na Seção 7 como camada econômica de D.

## 5.3 Alternativa C

**MODELING CHOICE.** Não recomendo C nas primitivas atuais. O PBE determina `Gamma_0` e `Gamma_1`, mas não determina como a randomização do tipo `0` seria correlacionada com a randomização do tipo `1` num mundo em que apenas um tipo se realiza.

Um acoplamento teria interpretação estratégica apenas se o jogo contivesse, explicitamente, um dispositivo comum sorteado antes da realização ou revelação do tipo e um compromisso de `H` com um plano contingente dependente dessa semente. Isso mudaria a estrutura informacional/temporal do jogo. Sem essa primitiva, produto independente, comonotonicidade ou “mesma semente” são convenções arbitrárias entre acoplamentos realização-equivalentes.

## 5.4 Alternativa D

**PROVED.** D elimina a falsa necessidade de fazer um único objeto desempenhar dois papéis incompatíveis. A camada exata guarda informação e é reversível até relabeling; a camada econômica descarta informação apenas por um mapa declarado e testável.

**Recomendação:** adotar D, com A como camada exata e um pushforward para `Z/G` como resumo econômico padrão. O Reynolds componentwise pode permanecer, se útil, como uma representação calculável do resumo marginal, mas não como definição da equivalência exata.

---

# 6. Provas ou contraexemplos

## 6.1 `Lambda_x` é um invariante completo da órbita diagonal

### Proposição

Suponha que `Z` seja Borel padrão, que `G` seja finito e que cada `T_g` seja um automorfismo Borel de `Z`. Então o mapa

\[
\Lambda:\mathcal X\to\mathcal P(\mathcal X),
\qquad
x\mapsto\Lambda_x
=
\frac1{|G|}\sum_{g\in G}\delta_{g\cdot x}
\]

é Borel, é invariável sob `G` e satisfaz

\[
\Lambda_x=\Lambda_{x'}
\quad\Longleftrightarrow\quad
x'\in G\cdot x.
\]

### Prova

**Mensurabilidade.** Para todo Borel `B subset X`,

\[
\Lambda_x(B)
=
\frac1{|G|}\sum_{g\in G}\mathbf 1_B(g\cdot x).
\]

Cada termo é Borel em `x`, pois a ação é Borel. Como a sigma-álgebra em `P(X)` é gerada pelos mapas de avaliação `mu↦mu(B)`, `x↦Lambda_x` é Borel.

**Invariância.** Para `h in G`,

\[
\Lambda_{h\cdot x}
=
\frac1{|G|}\sum_{g\in G}\delta_{gh\cdot x}.
\]

A aplicação `g↦gh` é uma permutação de `G`; logo a soma é `Lambda_x`.

**Completude.** Se `x'=h·x`, a invariância já dá `Lambda_{x'}=Lambda_x`. Reciprocamente, suponha `Lambda_x=Lambda_{x'}`. Como `X` é Borel padrão, o singleton `{x'}` é Borel. Além disso,

\[
\Lambda_{x'}(\{x'\})
=
\frac{|\operatorname{Stab}(x')|}{|G|}>0.
\]

A igualdade das medidas implica `Lambda_x({x'})>0`. Portanto existe `g in G` tal que `g·x=x'`. QED.

**PROVED.** `Lambda_x` é a codificação canônica correta se o objetivo é uma impressão digital completa da órbita sem escolher um representante.

## 6.2 Impossibilidade para `Mix_G^com`

### Proposição

Não existe relação de equivalência `~` em `X` com as duas propriedades:

1. `x~y` para todo `y in Mix_G^com(x)`;
2. `x~x'` se e somente se `x' in G·x` nos pares `x^P,x^Q` do contraexemplo.

### Prova

O Reynolds uniforme `r(x)` pertence a `Mix_G^com(x)`. Logo `x^P~r(x^P)` e `x^Q~r(x^Q)`. Como `r(x^P)=r(x^Q)`, simetria e transitividade dão `x^P~x^Q`. Mas `x^Q` não pertence a `G·x^P`. Contradição. QED.

## 6.3 Impossibilidade para `Mix_G^cw`

A mesma prova vale porque `r(x)` também pertence a `Mix_G^cw(x)`. Há ainda uma obstrução mais elementar: pesos degenerados permitem escolher uma permutação para cada coordenada. Portanto, qualquer equivalência que identifique todos os elementos de `Mix_G^cw(x)` contém a órbita de `x` sob `G×G`, que é em geral estritamente maior que a órbita diagonal.

**COUNTEREXAMPLE.** Em `P/Q`, a diferença de interseção é precisamente uma diferença que pode ser criada relabelando um plano de tipo sem relabelar o outro. Logo, `Mix_G^cw` apaga diretamente a informação cuja preservação define o quociente diagonal.

## 6.4 O que `L_q` resolve e o que não resolve

`L_q` preserva a associação entre as coordenadas porque seus átomos são pares inteiros. Porém:

- sem quociente adicional, diferentes `q` são diferentes medidas;
- para `q` não uniforme, pesos podem reintroduzir nomes;
- uma medida sobre assessments não é, por si, um assessment do jogo;
- identificar todas as `L_q(x)` pela órbita de suporte reduz o objeto a `[x]_G`.

**PROVED.** `L_q` é uma representação válida de randomização externa sobre relabelings, mas não é uma solução autônoma para “pura igual a mistura” dentro da assinatura original.

## 6.5 O par simetrizado pode não vir de um único mapa público `pi`

Considere o grupo de duas permutações `G={e,s}` e duas propostas distintas `y_A` e `y_B=s·y_A`. Tome um assessment separating puro com

\[
\Gamma_0=\delta_{(y_A,0,a_0,\chi_0,\omega_0)},
\qquad
\Gamma_1=\delta_{(y_B,1,a_1,\chi_1,\omega_1)},
\]

suprimindo apenas coordenadas irrelevantes para o argumento e assumindo equivariância das demais. O baricentro uniforme produz

\[
\bar\Gamma_0
=
\tfrac12\delta_{(y_A,0,\ldots)}
+
\tfrac12\delta_{(y_B,0,\ldots)},
\]

\[
\bar\Gamma_1
=
\tfrac12\delta_{(y_B,1,\ldots)}
+
\tfrac12\delta_{(y_A,1,\ldots)}.
\]

No par simetrizado, ambos os tipos colocam massa positiva em `y_A`, mas a coordenada de posterior associada a `y_A` é `0` sob `bar Gamma_0` e `1` sob `bar Gamma_1`.

Se o par fosse a imagem de um único assessment com mapa público `pi:Y→[0,1]`, seria necessário simultaneamente

\[
\pi(y_A)=0
\qquad\text{e}\qquad
\pi(y_A)=1,
\]

uma contradição. Com prior interior, a consistência bayesiana também exigiria um posterior interior em `y_A` quando ambos os tipos usam esse átomo.

**COUNTEREXAMPLE.** O par componentwise simetrizado — inclusive com pesos comuns — pode não ser imagem de qualquer assessment com um único mapa público de posterior.

### Consequência correta

**PROVED.** A não implementabilidade não impede, sozinha, que um objeto seja usado como **código** ou **estatística**: `Lambda_x`, por exemplo, também vive fora do espaço de assessments. Ela impede chamar o baricentro de “assessment representativo” ou de “PBE simétrico”. O que impede seu uso como assinatura **exata** é uma falha adicional e decisiva: a não completude demonstrada por `P/Q`.

## 6.6 Preservação de pooling e separating no resumo proposto

Se o mapa quociente `q_Z:Z→Z/G` deixa o posterior numérico inalterado, então a lei anônima

\[
\bar\Gamma_\theta=(q_Z)_\#\Gamma_\theta
\]

retém a distribuição do posterior por tipo.

Para prior `nu in (0,1)`:

- pooling implica posterior `nu` nos sinais on-path compartilhados;
- separating implica posterior `0` sob o tipo baixo e `1` sob o tipo alto nos respectivos sinais on-path.

**PROVED.** O par `((q_Z)#Gamma_0,(q_Z)#Gamma_1)` não confunde pooling com separating, ainda que apague a identidade nominal da coalizão e a relação de interseção entre os planos contrafactuais.

A ressalva é importante: o par resumido não precisa ser interpretável como um novo experimento de sinalização com um mapa `pi` definido no espaço de sinais anônimos. Ele é uma estatística das leis realizadas, não um assessment reduzido.

## 6.7 Testes adversariais mínimos

1. **Relabeling puro.** `Lambda_{g·x}=Lambda_x`. A assinatura exata identifica corretamente.
2. **Interseção diferente.** `Lambda_{x^P}≠Lambda_{x^Q}`. O resumo econômico pode coincidir deliberadamente.
3. **Pura versus uniforme.** Em geral, são distintas na camada exata e iguais na camada econômica se toda a massa permanece na mesma órbita de registros realizados.
4. **Separating com mesma parcela de `H`.** A coordenada de posterior sobrevive nas duas camadas; igualdade de payoff não implica pooling.
5. **Pooling versus separating.** Distintos na camada exata e no resumo que retém posterior, para prior interior.
6. **Misturas não uniformes `(.9,.1)` e `(.5,.5)`.** Distintas na camada exata salvo simetria degenerada; iguais no resumo por `Z/G` quando diferem apenas pela identidade dentro da mesma órbita.
7. **Posterior comum.** Garantido no assessment original e, portanto, na camada exata. O resumo não deve ser usado como assessment nem para revalidar Bayes.
8. **Atomless.** Todas as definições usam medidas Borel gerais, pushforwards e leis de órbita; não dependem de atomicidade.
9. **Fibra.** `rho` permanece coordenada explícita e invariável; nenhuma média cruza fibras.
10. **Não recombinação.** `Lambda_x` e o resumo são calculados a partir do mesmo par `x`. É proibido montar um novo objeto com uma coordenada vinda de um assessment e outra de assessment diferente.

---

# 7. Definição recomendada

## 7.1 Camada formal exata

Defina

\[
\operatorname{OrbLaw}_G(\mathcal X)
=
\{\Lambda_x:x\in\mathcal X\}
\subseteq\mathcal P(\mathcal X).
\]

Se `R` é um assessment reduzido e

\[
x(R)=\bigl(\Gamma_0^R,\Gamma_1^R\bigr),
\]

proponho a assinatura exata

\[
\boxed{
\operatorname{Sig}^{\mathrm{ex}}_M(R)
=
\left(
\rho(R),
\nu_{\mathrm{off}}(R),
\Lambda_{x(R)}
\right).
}
\]

Seu codomínio é

\[
\mathsf R_\rho
\times
\mathsf N_{\mathrm{off}}
\times
\operatorname{OrbLaw}_G(\mathcal X),
\]

onde `R_rho` é o espaço mensurável da coordenada `rho` e `N_off` o espaço mensurável da crença off-support relevante.

Defina a equivalência exata entre assessments por

\[
R\equiv_{\mathrm{ex}}R'
\]

se e somente se

\[
\rho(R)=\rho(R'),
\qquad
\nu_{\mathrm{off}}(R)=\nu_{\mathrm{off}}(R'),
\qquad
x(R')\in G\cdot x(R).
\]

Equivalentemente,

\[
R\equiv_{\mathrm{ex}}R'
\quad\Longleftrightarrow\quad
\operatorname{Sig}^{\mathrm{ex}}_M(R)
=
\operatorname{Sig}^{\mathrm{ex}}_M(R').
\]

**PROVED.** Esta relação é reflexiva, simétrica e transitiva porque é a igualdade das duas primeiras coordenadas combinada à relação de órbita de uma ação de grupo. Pela Proposição da Seção 6.1, `Lambda_x` é uma codificação completa e mensurável.

## 7.2 Camada de resumo econômico

Seja

\[
q_Z:\mathcal Z\to\bar{\mathcal Z}=\mathcal Z/G
\]

o mapa para a órbita do **registro realizado inteiro** sob relabeling dos Estados fracos. Como `G` é finito e `Z` é Borel padrão, `Z/G` pode ser equipado com uma estrutura Borel padrão para a qual `q_Z` é Borel.

Defina

\[
\bar\Gamma_\theta^R
=(q_Z)_\#\Gamma_\theta^R
\in\mathcal P(\bar{\mathcal Z})
\]

e o resumo

\[
\boxed{
\operatorname{Sum}^{\mathrm{econ}}_M(R)
=
\left(
\rho(R),
\nu_{\mathrm{off}}(R),
\bar\Gamma_0^R,
\bar\Gamma_1^R
\right).
}
\]

Seu codomínio é

\[
\mathsf R_\rho
\times
\mathsf N_{\mathrm{off}}
\times
\mathcal P(\bar{\mathcal Z})^2.
\]

A equivalência de resumo é o kernel desse mapa:

\[
R\equiv_{\mathrm{econ}}R'
\quad\Longleftrightarrow\quad
\operatorname{Sum}^{\mathrm{econ}}_M(R)
=
\operatorname{Sum}^{\mathrm{econ}}_M(R').
\]

**PROVED.** `equiv_econ` é uma relação de equivalência. Ela é deliberadamente mais grossa que `equiv_ex`.

### Propriedades

Para qualquer `g in G`, `q_Z∘T_g=q_Z`. Logo,

\[
(q_Z)_\#(T_g)_\#\Gamma_\theta
=(q_Z)_\#\Gamma_\theta.
\]

Por linearidade, para quaisquer pesos `q`, `q^0`, `q^1`,

\[
(q_Z)_\#\left(\sum_gq_g(T_g)_\#\Gamma_\theta\right)
=(q_Z)_\#\Gamma_\theta.
\]

Portanto, estratégias puras e misturas arbitrárias sobre identidades da mesma órbita têm o mesmo resumo, inclusive com pesos `(.9,.1)` ou `(.5,.5)`.

Ao mesmo tempo, como o posterior, o indicador de acordo e a continuação anônima não são alterados por `G`, essas coordenadas sobrevivem no quociente `Z/G`.

### Payoffs e outras estatísticas invariantes

Se `f:Z→E` é uma função Borel `G`-invariante, então existe uma função Borel `bar f:Z/G→E` tal que

\[
f=\bar f\circ q_Z.
\]

Assim,

\[
\int f\,d\Gamma_\theta
=
\int \bar f\,d\bar\Gamma_\theta.
\]

**PROVED.** Payoffs esperados, probabilidades de acordo, distribuições de posterior e outcomes terminais anônimos podem ser calculados da camada econômica sempre que forem funções/integráveis `G`-invariantes do registro realizado.

### Limite interpretativo

**MODELING CHOICE.** `Sum_econ` não é um novo assessment, não fornece necessariamente um único mapa público `pi` no espaço anônimo e não deve ser usado para provar sequential rationality, Bayes consistency ou existência. É um resumo de leis já validadas na camada exata.

## 7.3 Por que esta camada econômica é preferível ao Reynolds como definição

O pushforward para `Z/G` diz diretamente o que foi esquecido: a identidade nominal dentro de cada registro realizado. Ele não sugere que se tomou uma combinação convexa de estratégias nem que o resultado seja implementável como PBE.

O Reynolds componentwise pode ser mantido como representação computacional de informação marginal anônima, mas o texto deve declarar explicitamente:

- ele não é um invariante completo da órbita diagonal;
- ele não retém a relação entre os planos dos tipos;
- ele pode não pertencer à imagem de nenhum assessment comum;
- sua igualdade significa apenas igualdade de certo resumo marginal.

## 7.4 Teorema de suficiência necessário para `AC/AR`

Seja `C` um consumidor downstream, função ou correspondência definida sobre a camada exata. Seja

\[
S(R)=\operatorname{Sum}^{\mathrm{econ}}_M(R).
\]

O consumidor pode operar somente sobre `S` se for provado um resultado da forma:

\[
S(R)=S(R')
\quad\Longrightarrow\quad
C(R)=C(R')
\]

para todos os assessments admissíveis na mesma fibra de `rho`, e se existir uma função/correspondência mensurável `bar C` tal que

\[
C=\bar C\circ S.
\]

Para uma correspondência, é necessário ainda que a fatorização preserve a propriedade de mensurabilidade/fechamento de gráfico e quaisquer seleções usadas pelo consumidor.

**PROVED.** A constância nas fibras de `S` é necessária. A existência de uma fatorização mensurável é a forma operacional suficiente. Não basta verificar que alguns payoffs num exemplo coincidem.

---

# 8. Redação substitutiva

## 8.1 Decisão autoral de anonimidade

> **Decisão autoral — anonimidade e identidade formal.** A anonimidade dos Estados fracos ex ante idênticos é imposta, na camada formal exata, pelo quociente da lei conjunta dos dois tipos sob a ação diagonal de `S_m`. A mesma permutação atua simultaneamente em todas as coordenadas nomeadas de `Gamma_0` e `Gamma_1`. Dois assessments são formalmente equivalentes se e somente se têm a mesma coordenada `rho`, a mesma crença `nu_off` e seus pares `(Gamma_0,Gamma_1)` diferem por uma única permutação comum. Relações contrafactuais entre os planos dos tipos, como a cardinalidade da interseção entre coalizões, permanecem na assinatura exata, embora possam ser descartadas num resumo econômico posterior. Estratégias puras e estratégias mistas sobre identidades da mesma órbita não são, por esse fato apenas, o mesmo elemento da correspondência formal; elas podem, contudo, receber o mesmo resumo substantivo anônimo.

## 8.2 Definição da assinatura de `A_M`

> **Definição — assinatura exata de `A_M`.** Seja `X=P(Z)^2`, seja `x(R)=(Gamma_0^R,Gamma_1^R)` e seja `G=S_m` atuando diagonalmente em `X`. Defina
> 
> \[
> \Lambda_{x(R)}
> =
> \frac1{|G|}\sum_{g\in G}\delta_{g\cdot x(R)}
> \in\mathcal P(\mathcal X).
> \]
> 
> A assinatura formal exata é
> 
> \[
> \operatorname{Sig}^{\mathrm{ex}}_M(R)
> =
> \bigl(\rho(R),\nu_{\mathrm{off}}(R),\Lambda_{x(R)}\bigr).
> \]
> 
> Sua igualdade identifica exatamente as órbitas diagonais. Separadamente, o resumo econômico anônimo é
> 
> \[
> \operatorname{Sum}^{\mathrm{econ}}_M(R)
> =
> \bigl(\rho(R),\nu_{\mathrm{off}}(R),(q_Z)_\#\Gamma_0^R,(q_Z)_\#\Gamma_1^R\bigr),
> \]
> 
> onde `q_Z:Z→Z/G` elimina os nomes dos Estados fracos em cada registro realizado. O resumo não é uma assinatura exata nem precisa ser a imagem de um assessment.

## 8.3 Substituição para `AMX-016`

> **`AMX-016` — codificação completa da órbita diagonal.** Suponha que `Z` seja Borel padrão, que `G=S_m` seja finito e que sua ação em `Z` seja por automorfismos Borel. Então o mapa
> 
> \[
> x\mapsto\Lambda_x
> =
> \frac1{|G|}\sum_{g\in G}\delta_{g\cdot x}
> \]
> 
> é Borel e `G`-invariante, e
> 
> \[
> \Lambda_x=\Lambda_{x'}
> \quad\Longleftrightarrow\quad
> x'\in G\cdot x.
> \]
> 
> O baricentro de Reynolds
> 
> \[
> r(x)=|G|^{-1}\sum_g g\cdot x
> \]
> 
> é apenas um resumo `G`-invariante. Em geral, ele não é completo para as órbitas e não se afirma que seja a imagem de um único assessment ou um PBE representativo.

## 8.4 Substituição para a parte afetada de `AMX-MSB-010`

> **`AMX-MSB-010` — relabeling, misturas de identidade e consumo downstream.** Se `R` é PBE, então todo relabeling comum `g·R` é PBE e possui a mesma assinatura formal exata. Uma mistura, comum ou componentwise, sobre identidades de Estados fracos não é, por esse fato apenas, formalmente equivalente a `R`; baricentros não são presumidos PBEs nem imagens de um mapa público comum de posterior. Todas essas misturas recebem o mesmo resumo econômico anônimo quando diferem de `R` apenas pela distribuição de massa dentro das órbitas de registros realizados. Um consumidor downstream pode substituir a assinatura exata por esse resumo somente após prova de que sua operação é constante nas fibras do resumo e admite fatorização mensurável por ele.

### Observação sobre o teorema cardinal

Esta substituição não exige alterar a conclusão cardinal tomada como dada no pacote. Ela muda o objeto usado para codificar a órbita, não o fato de que há um contínuo de classes sob o quociente diagonal correto.

---

# 9. Finding menor da Seção 8.3

## 9.1 Diagnóstico

T4 distingue corretamente:

\[
u_\theta(y)\le V_\theta
\quad\text{para todo }y\in\operatorname{supp}(\lambda),
\]

\[
u_\theta(y)=V_\theta
\quad\sigma_\theta\text{-quase certamente}.
\]

O erro auxiliar é inferir, de `y in supp(lambda)`, que `sigma_theta({y})>0`. Isso é falso para leis atomless e também para pontos não atômicos de uma lei com suporte amplo.

## 9.2 Redação corrigida

> **Observação corrigida sobre suporte, átomos e melhor resposta.** A desigualdade `u_theta(y)≤V_theta` vale em todo ponto de `supp(lambda)`. A igualdade `u_theta(y)=V_theta` vale `sigma_theta`-quase certamente e não deve ser promovida a uma afirmação ponto a ponto em pontos não atômicos. Se `lambda({y})>0`, o prior é interior e `0<pi(y)<1`, então a consistência de Bayes no átomo implica `sigma_0({y})>0` e `sigma_1({y})>0`; consequentemente, a igualdade de melhor resposta vale naquele átomo para ambos os tipos. Para conjuntos sem átomos, ou para pontos individuais de massa zero, a formulação correta permanece quase-certamente. Além disso,
> 
> \[
> \sigma_1(\{y:\pi(y)=0\})=0,
> \qquad
> \sigma_0(\{y:\pi(y)=1\})=0
> \]
> 
> para prior interior. Nenhuma dessas correções altera T4/`AMX-015` ou `AMX-011`.

## 9.3 Prova das afirmações atômica e setwise

Se `lambda=(1-nu)sigma_0+nu sigma_1` e `lambda({y})>0`, Bayes no átomo dá

\[
\pi(y)
=
\frac{\nu\sigma_1(\{y\})}
{(1-\nu)\sigma_0(\{y\})+\nu\sigma_1(\{y\})}.
\]

Com `nu in (0,1)` e `0<pi(y)<1`, numerador e parcela do denominador atribuída ao tipo `0` são estritamente positivos. Logo ambos os tipos têm massa positiva no átomo. Uma igualdade que vale `sigma_theta`-quase certamente não pode falhar num singleton de massa positiva.

Para a afirmação setwise, a consistência bayesiana implica, para todo conjunto mensurável `A`,

\[
\int_A \pi(y)\,\lambda(dy)
=
\nu\sigma_1(A).
\]

Tomando `A={pi=0}`, o lado esquerdo é zero; como `nu>0`, `sigma_1(A)=0`. Analogamente,

\[
\int_A(1-\pi(y))\,\lambda(dy)
=
(1-\nu)\sigma_0(A)
\]

com `A={pi=1}` produz `sigma_0(A)=0`.

**PROVED.** O finding tem reparo puramente local. A única precisão adicional que recomendo é substituir “fora dos átomos” por “nos pontos de massa zero não há conclusão pointwise; a igualdade permanece quase-certamente”, pois uma lei pode ter simultaneamente parte atômica e parte contínua.

---

# 10. Implicações downstream

## 10.1 O que deve consumir a camada exata

A camada exata é obrigatória para qualquer operação que use ou possa usar:

- identidade formal de um equilíbrio;
- transporte de equilíbrios entre modelos;
- comparação de suportes estratégicos;
- coincidência ou sobreposição de mensagens entre tipos;
- existência de um único mapa público `pi(y)`;
- consistência bayesiana e crenças off-path;
- correlação ou relação entre os dois planos contingentes;
- contagem/cardinalidade de classes formais;
- seleção de um assessment representativo;
- composição que possa recombinar coordenadas.

**PROVED.** Nesses usos, substituir `[x]_G` por um resumo componentwise pode identificar órbitas distintas ou apresentar como “representante” um par que não vem de assessment algum.

## 10.2 O que pode consumir a camada econômica

Após prova de fatorização, a camada econômica pode bastar para:

- payoff esperado de cada tipo;
- probabilidade de acordo/atraso;
- distribuição de posteriores;
- continuação anônima;
- distribuição de outcomes terminais anônimos;
- estatísticas que dependam apenas de funções `G`-invariantes do registro realizado;
- tabelas e gráficos substantivos que deliberadamente ignorem identidades nominais.

## 10.3 Regra operacional para `AC` e `AR`

Para cada consumidor `C in {AC,AR}`, deve existir um claim explícito:

> Para assessments `R,R'` admissíveis na mesma fibra `rho`, se `Sum_econ(R)=Sum_econ(R')`, então `C(R)=C(R')`; ademais, existe uma fatorização mensurável `bar C` com `C=bar C∘Sum_econ`.

Sem esse claim e sua prova, `C` deve receber `Sig_ex`, não apenas `Sum_econ`.

Se `C` opera sobre conjuntos de equilíbrios, a prova deve ser setwise: a imagem/correspondência resultante deve depender apenas do resumo de cada elemento sem emparelhar coordenadas de elementos diferentes. Não basta que um valor escalar isolado seja invariável.

## 10.4 Ortogonalidade a crenças e `rho`

**PROVED.** O defeito analisado é ortogonal à arquitetura de crenças e à coordenada `rho`. Ele nasce depois que `Gamma_0` e `Gamma_1` já estão bem formadas, na escolha do quociente sobre as identidades fracas.

A ação de `G` não altera `rho`, `nu_off` nem o valor numérico do posterior. `rho` deve permanecer uma coordenada explícita e fixa, inclusive na futura comparação com unanimidade na mesma fibra.

Há apenas uma implicação de interface: como um baricentro componentwise pode não corresponder a um único mapa `pi`, ele não pode substituir o assessment em argumentos que usem Bayes ou crenças. Isso não reabre a arquitetura de crenças; apenas limita o que a camada resumida pode fazer.

## 10.5 Estado institucional

Esta consulta não autoriza consumo por `AC` ou `AR`. A adoção da arquitetura exige decisão autoral, novos bytes e o procedimento formal posterior descrito no pacote.

---

# 11. Recomendação consultiva final

## Escolha recomendada: Alternativa D, precisada como `A + resumo por Z/G`

**PROVED.** A camada formal exata deve manter

\[
(\rho,\nu_{\mathrm{off}},[x]_G),
\]

preferencialmente codificada por

\[
(\rho,\nu_{\mathrm{off}},\Lambda_x).
\]

Nessa camada, `P` e `Q` são distintos; uma estratégia pura e uma estratégia mista não degenerada são distintas salvo relabeling diagonal; pooling e separating permanecem distintos; e nenhuma coordenada é recombinada.

**MODELING CHOICE.** A camada econômica deve apagar a identidade dos Estados fracos em cada registro realizado por

\[
(q_Z)_\#\Gamma_\theta,
\]

tratando como substantivamente equivalentes estratégias que diferem apenas pela distribuição de massa entre identidades da mesma órbita. Nessa camada, `P` e `Q` podem coincidir deliberadamente, assim como misturas `(.9,.1)` e `(.5,.5)` sobre nomes anônimos.

**COUNTEREXAMPLE.** Não recomendo redefinir a equivalência formal para incluir `Mix_G^com` ou `Mix_G^cw`: a primeira força o colapso de `P/Q` pela transitividade através do Reynolds uniforme; a segunda abandona diretamente a ação diagonal ao permitir relabelings independentes por tipo.

**MODELING CHOICE.** Não recomendo acrescentar um acoplamento `Xi` sem uma semente comum ou compromisso ex ante explicitamente presentes nas primitivas. Nas primitivas atuais, o acoplamento seria informação contrafactual arbitrária.

A decisão substantiva mais limpa é, portanto:

> **preservar na assinatura formal tudo o que é necessário para identificar exatamente a órbita diagonal; apagar no resumo econômico tudo o que um teorema downstream demonstrar ser irrelevante.**

Essa arquitetura é conservadora no sentido correto: informação pode ser descartada por um mapa posterior bem definido, mas não pode ser reconstruída depois de colapsada pelo Reynolds componentwise.
