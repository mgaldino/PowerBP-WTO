# Consulta técnica externa não formal — auditoria de \(A_C\): comparação exata entre maioria e unanimidade

## 1. Natureza e limite da consulta

Este documento é uma **consulta técnica externa não formal**. Não constitui parecer formal independente, não reabre nem encerra gate, não concede aprovação autoral, congelamento ou autorização de implementação, e não substitui as revisões formais anteriores.

A auditoria é estritamente condicional ao pacote fornecido. Em particular, trato como inputs verdadeiros, completos e internamente consistentes os axiomas do jogo-base e os resultados congelados de \(A_M\) e \(A_U\), inclusive as correspondências de binders, a sincronização temporal dos payoffs, os extratores Borel e a partição de payoffs de unanimidade. O objeto auditado é o transporte desses inputs para a comparação \(A_C\), não uma nova solução dos jogos-fonte.

As conclusões materiais são classificadas como **PROVED**, **COUNTEREXAMPLE**, **MODELING CHOICE**, **MECHANICAL EVIDENCE ONLY** ou **UNRESOLVED**. Na matriz de claims, uso os rótulos solicitados: **SUPPORTED**, **NOT SUPPORTED**, **UNRESOLVED** e **MECHANICAL EVIDENCE ONLY**.

## 2. Resposta curta ao autor

**PROVED.** Condicionalmente aos inputs congelados, a arquitetura central de \(A_C\) é tecnicamente sólida. O produto na mesma fibra emparelha binders completos sem recombinar coordenadas internas; como \(A_C\) não é um terceiro jogo e não há restrição cross-world no game form, a fibra comum e a atomicidade são suficientes para admissibilidade. A condição de existência é exatamente a não vacuidade simultânea das duas correspondências na mesma fibra.

**PROVED.** A passagem posterior aos resumos econômicos também é correta para as operações declaradas. Os payoffs, probabilidades de acordo e leis anônimas são recuperados por extratores Borel de cada resumo inteiro; a operação de comparação é então uma composição Borel. O lifting é setwise e não requer seletor mensurável de pré-imagens. A construção preserva o vínculo entre os dois tipos dentro de cada assessment.

**PROVED.** As definições dos contrastes, dos conjuntos de sinais e dos envelopes são corretas, desde que sejam sempre aplicadas a fibras comparáveis e que o payoff ex ante seja definido como uma coordenada derivada do vetor ligado de payoffs. As fórmulas de ínfimo e supremo permanecem válidas para conjuntos não fechados; o intervalo resultante é apenas o casco intervalar **fechado**, não o conjunto exato.

**PROVED.** T5 está correto e pode ser fortalecido quantitativamente. Para todo par comparável,

\[
V_M^\theta-V_U^\theta
\ge
\beta\left(\frac{c}{m}-\beta o_1\right).
\]

Logo, \(\beta o_1<c/m\) dá uma margem estritamente positiva uniforme para ambos os tipos e, portanto, ex ante. A condição é suficiente, não necessária. A partição exata de \(A_U\) permite certificados menos restritivos em algumas células, especialmente nas células baixas em que \(V_U^0=V_U^1=z_L\).

**COUNTEREXAMPLE.** A principal correção necessária é de formulação, não de arquitetura: a frase “não existe probabilidade conjunta entre regras” é literalmente forte demais. Dado qualquer par de leis marginais, existe ao menos o acoplamento-produto independente sob as estruturas mensuráveis usuais. O que o modelo não fornece é uma lei conjunta **induzida, identificada ou substantivamente autorizada**. Corrigida essa redação, não encontrei defeito que invalide T1–T5. Recomendo ainda pequenas precisões sobre não vacuidade em T5, definição de \(V_g^E\), recuperação Borel de \(\nu\) e a expressão “casco intervalar fechado”.

## 3. Reconstrução intuitiva

### 3.1 Por que não há apenas dois números

Com multiplicidade de equilíbrio, “o payoff sob maioria” e “o payoff sob unanimidade” não são números isolados. Cada payoff pertence a um assessment completo que liga:

- estratégias dos tipos baixo e alto;
- crenças on-path e off-path;
- seleção de continuação;
- ballot e decisões de voto;
- leis de outcomes;
- payoffs condicionais aos dois tipos.

Selecionar \(V_M^0\) de um assessment, \(V_M^1\) de outro e uma lei de outcomes de um terceiro produziria um objeto que não corresponde a equilíbrio algum. Por isso a unidade primária correta é o binder completo.

### 3.2 O objeto exato

Se \(\pi_g\) denota a projeção de um binder da instituição \(g\) sobre sua economia e sua convenção off-path, o produto fibrado global natural seria

\[
\mathscr B_M\times_{\mathscr X}\mathscr B_U
=
\{(R_M,R_U):\pi_M(R_M)=\pi_U(R_U)\}.
\]

Na fibra fixa \((d,\eta)\), esse objeto reduz ao produto cartesiano

\[
J_{AC}^{bind}(d,\eta)=B_M(d,\eta)\times B_U(d,\eta).
\]

A denominação “produto fibrado” é apropriada para enfatizar a igualdade das projeções no objeto global; na fibra já fixada, não há condição adicional escondida.

### 3.3 O que é comum e o que não é

A comparação fixa:

\[
(d,\eta)
=
(\text{mesma economia},\text{mesmo prior},\text{mesma convenção off-path}).
\]

Ela não exige a mesma proposta, a mesma coalizão nomeada, a mesma continuação selecionada ou o mesmo número aleatório nas duas instituições. Essas igualdades adicionais não aparecem como primitivas nem como restrições de equilíbrio.

A igualdade de \(\eta\) é uma **MODELING CHOICE** de comparação institucional. Ela produz uma diagonal disciplinada de crenças off-path. Não é consequência endógena do conceito de PBE, mas é internamente coerente e está implementada sem contradição.

### 3.4 Por que os resumos entram depois

Primeiro forma-se o par de binders completos. Depois aplica-se a cada binder seu resumo econômico inteiro. Como os extratores recuperam exatamente as coordenadas usadas por \(A_C\), a comparação econômica pode ser fatorada pelos resumos. A ordem conceitual importa: o produto de resumos é legítimo porque foi demonstrado que ele é a imagem do produto exato, e não porque se resolveu construir diretamente um produto de projeções marginais.

## 4. Matriz claim por claim

| ID | Avaliação | Fundamentação |
|---|---|---|
| **AC-T1** | **SUPPORTED** | Condicional à definição autoral de comparação na diagonal \((d,\eta)\), igualdade da fibra e atomicidade são necessárias. São suficientes porque cada coordenada já é um PBE completo e não há restrição cross-world no objeto comparativo. |
| **AC-T2** | **SUPPORTED** | A identidade ex ante é distributividade aplicada aos quatro payoffs ligados. AX-EXT-3 fixa todos os valores na data A, de modo que qualquer novo fator de \(\beta\) seria erro. |
| **AC-T3** | **SUPPORTED** | Os extratores Borel de payoff, acordo e leis, combinados por operações finitas Borel, geram \(\bar C_{econ}\). Convém explicitar a projeção Borel de \(\nu\), ou declarar a aplicação como fiberwise. |
| **AC-C1** | **SUPPORTED** | A igualdade é setwise. Para cada par de resumos há pré-imagens, e qualquer par de pré-imagens na mesma fibra é admissível por T1. Não é necessário escolher pré-imagens de forma mensurável em todo o domínio. |
| **AC-AU-PART** | **SUPPORTED** | Como transporte condicional de AX-AU-2, a partição é completa: endpoints; região baixa com \(p=0\); região alta com \(p=0\), \(0<p\le\nu^\star\) e \(p>\nu^\star\). As fronteiras são tratadas inclusivamente conforme declarado. |
| **AC-T4** | **SUPPORTED** | É a identidade elementar de não vacuidade do produto. Nos endpoints, a existência “em alguma fibra” de \(A_M\) implica existência na única fibra após o quociente de \(\rho\). |
| **AC-SIGN** | **SUPPORTED** | Em fibras não vazias, os conjuntos de sinais caracterizam exatamente ordem estrita, ordem fraca, empate e dependência de seleção. Em células none, o conjunto matemático seria vazio, mas não deve ser interpretado como sinal institucional. |
| **AC-ENV** | **SUPPORTED** | Para conjuntos escalares não vazios, \(\inf(U-M)=\inf U-\sup M\) e \(\sup(U-M)=\sup U-\inf M\), sem hipótese de fechamento. Recomenda-se definir \(V_g^E\) e chamar \([\inf,\sup]\) de casco intervalar fechado. |
| **AC-U-BOUND** | **SUPPORTED** | Todas as células existentes de \(A_U\) têm payoff menor ou igual a \(z_H\); nas células none não há payoff comparável. |
| **AC-T5** | **SUPPORTED** | O bound inferior de maioria e o teto de unanimidade implicam uma margem uniforme \(\beta(c/m-\beta o_1)\). A conclusão de dominância deve ser expressamente condicionada a \(J_{AC}^{bind}\ne\varnothing\) para evitar leitura vacuamente verdadeira. |
| **AC-OUTCOME** | **NOT SUPPORTED** como literalmente redigido | É correto preservar um par ordenado de leis e negar uma lei conjunta **model-implied**. É falso dizer, sem qualificação, que nenhuma lei conjunta existe: o produto independente é um acoplamento, e outros acoplamentos podem compartilhar as mesmas marginais. |
| **AC-SCOPE** | **SUPPORTED** | T5 ordena apenas o payoff de \(H\), não a probabilidade de acordo, o bem-estar dos fracos nem as regiões em que os bounds não ordenam. |

## 5. Auditoria de T1 e T4

### 5.1 Necessidade da fibra comum

**PROVED.** No objeto autoral declarado, uma comparação admissível mantém fixos \(d\) e \(\eta\). Portanto um par com \(d_M\ne d_U\) ou \(\eta_M\ne\eta_U\) não pertence a \(J_{AC}^{bind}(d,\eta)\).

Para \(0<\nu<1\),

\[
p=b_\rho(\nu)=\frac{\nu\rho}{1-\nu+\nu\rho}
\]

é estritamente crescente em \(\rho\), pois

\[
\frac{\partial b_\rho(\nu)}{\partial\rho}
=
\frac{\nu(1-\nu)}{(1-\nu+\nu\rho)^2}>0.
\]

Logo, na região interior, igualdade de \(p\) já implica igualdade de \(\rho\); registrar ambos torna a convenção explícita, embora haja redundância matemática.

Nos endpoints, o pacote corretamente abandona a parametrização por likelihood ratio e usa \(\eta=(*,\nu)\). Isso evita expressões indeterminadas como o caso \(\nu=1,\rho=0\) na fórmula fracionária e impede que diferentes rótulos de \(\rho\) criem fibras artificiais quando o tipo oposto tem probabilidade zero.

### 5.2 Necessidade da atomicidade

**PROVED.** Se \(R_M\in B_M(d,\eta)\), o vetor

\[
(V_M^0(R_M),V_M^1(R_M))
\]

é uma coordenada ligada de um único assessment. A expressão

\[
(V_M^0(R_M^a),V_M^1(R_M^b)),\qquad R_M^a\ne R_M^b,
\]

não é garantidamente a imagem de binder algum. O mesmo vale para crenças, leis de outcome e continuações. A definição de \(J_{AC}^{bind}\) impede exatamente essa recombinação.

### 5.3 Suficiência

**PROVED.** Tome \(R_M\in B_M(d,\eta)\) e \(R_U\in B_U(d,\eta)\). Cada binder satisfaz, em seu próprio game form, racionalidade sequencial, consistência de crenças e completude. \(A_C\) não acrescenta movimento, informação, payoff, restrição de incentivo ou mecanismo de sorteio. Portanto emparelhar os binders não altera nenhum requisito interno.

Uma condição adicional só seria necessária se alguma primitiva comum exigisse, por exemplo:

- a mesma realização de um choque comum;
- uma restrição de monotonicidade entre estratégias cross-world;
- uma seleção conjunta de equilíbrio;
- uma função que vinculasse propostas ou coalizões entre instituições.

Nenhuma dessas primitivas consta do pacote. Acrescentá-las seria redesenhar o objeto comparativo, não reparar uma falha de T1.

### 5.4 A diagonal de crenças

**MODELING CHOICE.** T1 não demonstra que PBEs de maioria e unanimidade “devem” usar o mesmo \(\rho\). Ele demonstra que, uma vez definida como admissível a comparação na diagonal, todo par de binders na mesma fibra e somente esses pares pertencem ao objeto.

A diagonal tem uma justificativa clara de ceteris paribus: impede que o ranking institucional seja produzido por crenças off-path diferentes escolhidas de modo oportunista. O custo substantivo é que duas instituições podem possuir equilíbrios para a mesma economia, mas apenas em fibras distintas, caso em que \(A_C\) declara none. Isso é incomparabilidade sob a regra escolhida, não inexistência global de equilíbrios.

### 5.5 T4 e as células de existência

**PROVED.** Para quaisquer conjuntos \(B_M,B_U\),

\[
B_M\times B_U\ne\varnothing
\quad\Longleftrightarrow\quad
B_M\ne\varnothing\text{ e }B_U\ne\varnothing.
\]

Aplicada à fibra fixa, essa identidade prova T4.

A partição resultante é:

| Região | Existência de \(A_C\) |
|---|---|
| \(\nu=0\) | Existe: \(A_U\) existe e a existência de \(A_M\) em alguma fibra cai na única fibra quocientada \((*,0)\). |
| \(0<\nu\le\nu^\star\), \(p=0\), \(\Delta_U\ge0\) | Existe se e somente se \(B_M(d,(0,0))\ne\varnothing\). |
| \(0<\nu\le\nu^\star\), \(\Delta_U<0\) ou \(p>0\) | none, porque \(B_U\) é vazio. |
| \(\nu^\star<\nu<1\), \(p=0\) | Existe se e somente se a fibra correspondente de \(A_M\) existe. |
| \(\nu^\star<\nu<1\), \(0<p\le\nu^\star\) | none. A fronteira \(p=\nu^\star\) pertence corretamente à célula vazia. |
| \(\nu^\star<\nu<1\), \(p>\nu^\star\) | Existe se e somente se a fibra correspondente de \(A_M\) existe; \(p=1\), equivalente a \(\rho=\infty\), está incluído. |
| \(\nu=1\) | Existe pela mesma razão de unicidade da fibra quocientada \((*,1)\). |

**PROVED.** A fronteira \(\Delta_U=0\) é incluída na célula existente, como requer o desempate inclusivo congelado. Não há lacuna na partição.

**PROVED.** Em uma célula none, \(J_{AC}^{bind}=\varnothing\). Logo não há par, payoff de comparação, sinal ou envelope econômico. Embora a teoria de conjuntos permita escrever \(\mathcal D_r=\varnothing\), convenções como \(\inf\varnothing=+\infty\) não devem ser usadas para fabricar um ranking. O tratamento sem sentinela numérico está correto.

## 6. Auditoria de T2, T3 e C1

### 6.1 Tipo antes do prior

**PROVED.** Para cada par ligado,

\[
\begin{aligned}
\delta_E
&=\big[(1-\nu)V_U^0+\nu V_U^1\big]
  -\big[(1-\nu)V_M^0+\nu V_M^1\big]\\
&=(1-\nu)(V_U^0-V_M^0)+\nu(V_U^1-V_M^1)\\
&=(1-\nu)\delta_0+\nu\delta_1.
\end{aligned}
\]

A operação é feita depois de importar os quatro payoffs do mesmo par de binders. Portanto não há recombinação entre tipos.

Nos endpoints:

\[
\nu=0\implies\delta_E=\delta_0,
\qquad
\nu=1\implies\delta_E=\delta_1.
\]

O payoff do tipo de massa zero permanece no vetor para comparações contrafactuais por tipo, mas não entra na média. Nenhuma divisão por \(\nu\) ou \(1-\nu\) é necessária.

### 6.2 Data econômica

**PROVED.** AX-EXT-3 afirma que \(V_M^\theta\) e \(V_U^\theta\) chegam à mesma data A e que cada fonte já fez sua transformação temporal. Assim, \(A_C\) aplica multiplicador um. Um novo fator de \(\beta\) não seria uma normalização inocente; mudaria a data de uma das grandezas ou de ambas e invalidaria a interpretação do contraste.

### 6.3 Construção Borel explícita

Escreva, para cada resumo \(s_g\),

\[
h_{g\theta}=H_{g\theta}(s_g),\qquad
 a_{g\theta}=P_{g\theta}(s_g),\qquad
 \gamma_{g\theta}=L_{g\theta}(s_g).
\]

Então \(\bar C_{econ}\) pode ser definida explicitamente como a tupla que contém

\[
(h_{M0},h_{M1},h_{U0},h_{U1}),
\]

\[
(h_{U0}-h_{M0},h_{U1}-h_{M1}),
\]

\[
(1-\nu)(h_{U0}-h_{M0})+\nu(h_{U1}-h_{M1}),
\]

\[
(a_{U0}-a_{M0},a_{U1}-a_{M1}),
\]

suas diferenças de atraso por mudança de sinal, e

\[
(\gamma_{M0},\gamma_{M1},\gamma_{U0},\gamma_{U1}).
\]

**PROVED.** Como os extratores são Borel por input, e empacotamento finito, projeção, soma, subtração e combinação afim preservam Borelidade, a aplicação resultante é Borel.

Há apenas uma precisão útil:

- se o teorema é **fiberwise**, \(\nu\) é constante e deve-se escrever \(\bar C_{econ}^{d,\eta}\);
- se o teorema é **global**, deve-se explicitar que a coordenada \(\nu\) é recuperada por uma projeção Borel do resumo ou incluir \((d,\eta)\) como argumento de \(\bar C_{econ}\).

O texto “o resumo preserva a fibra” parece destinado a fornecer exatamente essa coordenada. Portanto não há contraexemplo a T3, mas a versão formal final deve tornar a alternativa escolhida inequívoca.

### 6.4 Por que o lifting é setwise

Defina

\[
\mathcal S_g^{econ}(d,\eta)
=
\operatorname{Sum}_g^{econ}\big(B_g(d,\eta)\big).
\]

Para mostrar a inclusão recíproca de C1, fixe um par particular \((s_M,s_U)\). Pela definição de imagem, existem \(R_M\) e \(R_U\) tais que

\[
\operatorname{Sum}_M^{econ}(R_M)=s_M,
\qquad
\operatorname{Sum}_U^{econ}(R_U)=s_U.
\]

Como ambos pertencem à mesma fibra e não existe compatibilidade cruzada adicional, \((R_M,R_U)\in J_{AC}^{bind}\).

**PROVED.** Esse argumento usa apenas quantificadores existenciais para cada par fixado. Não constrói uma função

\[
s_g\longmapsto R_g(s_g)
\]

em todo o espaço e, portanto, não precisa de seletor Borel global. A Borelidade de \(\bar C_{econ}\) vem dos extratores diretamente definidos nos resumos, não de uma escolha de pré-imagens.

### 6.5 A imagem ex ante correta

Uma identidade útil, implícita em T2 e recomendável como corolário explícito, é

\[
\mathcal D_E(d,\eta)
=
\left\{(1-\nu)x_0+\nu x_1:
(x_0,x_1)\in\mathcal D_{01}(d,\eta)\right\}.
\]

**PROVED.** Essa é a imagem afim do conjunto de vetores ligados. Em geral, não se pode substituir o lado direito por uma soma de Minkowski das projeções marginais \((1-\nu)\mathcal D_0+\nu\mathcal D_1\), porque essa operação permitiria escolher \(\delta_0\) e \(\delta_1\) de pares diferentes.

## 7. Contrastes, sinais e envelopes

### 7.1 Vetores ligados

**PROVED.** Como todo par \((R_M,R_U)\) na fibra é admissível,

\[
\mathcal D_{01}
=
\{(V_U^0-V_M^0,V_U^1-V_M^1):(R_M,R_U)\in J_{AC}^{bind}\}
=
\mathcal V_U^{01}-\mathcal V_M^{01}.
\]

A diferença de Minkowski é aplicada a conjuntos de vetores completos, não ao produto das projeções de cada coordenada.

**COUNTEREXAMPLE ao atalho proibido.** Suponha abstratamente

\[
\mathcal D_{01}=\{(0,1),(1,0)\}
\]

com \(\nu=1/2\). Então

\[
\mathcal D_E=\{1/2\}.
\]

As projeções são \(\mathcal D_0=\mathcal D_1=\{0,1\}\). Recombiná-las livremente sugeriria valores ex ante \(0,1/2,1\), incluindo \(0\) e \(1\), que nenhum par ligado gera. O pacote atual evita corretamente esse erro porque define \(\delta_E\) no nível do par de binders.

### 7.2 Classificação por sinais

Em fibra não vazia:

- \(\mathcal S_r=\{+1\}\) equivale a \(V_U^r>V_M^r\) para todo par;
- \(\mathcal S_r=\{-1\}\) equivale a \(V_M^r>V_U^r\) para todo par;
- \(\mathcal S_r=\{0\}\) equivale a empate para todo par;
- \(\mathcal S_r\subseteq\{0,+1\}\) equivale a unanimidade nunca ser pior;
- \(\mathcal S_r\subseteq\{-1,0\}\) equivale a maioria nunca ser pior.

**PROVED.** As equivalências são imediatas da definição da função sinal. Os casos \(\{0,+1\}\) e \(\{-1,0\}\) indicam que a presença de estriteza depende da seleção. Conjuntos contendo \(-1\) e \(+1\) indicam que a própria direção depende da seleção.

Em célula none, \(\mathcal S_r\) não deve ser usado como classificação. O conjunto vazio não significa empate, dominância ou ambiguidade; significa ausência de pares comparáveis.

### 7.3 Multiplicidade de unanimidade

Na célula alta com \(p=0\),

\[
(V_U^0,V_U^1)=(u,u),
\qquad
u_{\min}=\max\{z_L,d_H\}
\le u\le z_H.
\]

Além disso,

\[
z_H-z_L=\beta^2(o_1-o_0)>0,
\qquad
z_H-d_H=1-\beta>0.
\]

Logo, \(z_H>u_{\min}\) e o intervalo é não degenerado.

**PROVED.** Fixado um binder de maioria, aumentar \(u\) altera ambos os contrastes por tipo na mesma magnitude. O valor depende da seleção de \(A_U\), mas o sinal pode permanecer invariável se todo o intervalo de contrastes estiver estritamente de um lado de zero.

### 7.4 Envelopes escalares

Para tornar a notação completa, recomenda-se definir

\[
V_g^E(R_g)
=(1-\nu)V_g^0(R_g)+\nu V_g^1(R_g)
\]

antes de declarar, para \(r\in\{0,1,E\}\),

\[
M_r=\{V_M^r(R_M):R_M\in B_M(d,\eta)\},
\qquad
U_r=\{V_U^r(R_U):R_U\in B_U(d,\eta)\}.
\]

Em fibra comparável,

\[
\mathcal D_r=U_r-M_r.
\]

**PROVED.** Para conjuntos não vazios de números reais,

\[
\inf(U-M)=\inf U-\sup M,
\qquad
\sup(U-M)=\sup U-\inf M.
\]

A prova não exige fechamento nem atingimento dos extremos. Escolhem-se sequências \(u_n\downarrow\inf U\) e \(m_n\uparrow\sup M\) para aproximar o ínfimo da diferença; o argumento do supremo é simétrico.

**MECHANICAL EVIDENCE ONLY.** Tome \(U=M=(0,1)\). Então

\[
U-M=(-1,1),
\]

mas

\[
\inf(U-M)=-1=0-1,
\qquad
\sup(U-M)=1=1-0.
\]

Os extremos não são atingidos, e ainda assim as fórmulas são exatas.

### 7.5 Conjunto exato versus casco intervalar

O intervalo

\[
[\inf\mathcal D_r,\sup\mathcal D_r]
\]

é o menor **intervalo fechado** que contém \(\mathcal D_r\), sob a hipótese usual de valores reais limitados. Ele pode adicionar extremos não atingidos e preencher lacunas internas.

**COUNTEREXAMPLE à identificação conjunto = envelope.** Se

\[
U=\{0,2\},\qquad M=\{0\},
\]

então

\[
\mathcal D=\{0,2\},
\qquad
[\inf\mathcal D,\sup\mathcal D]=[0,2].
\]

O valor \(1\) pertence ao casco, mas não ao conjunto exato.

Há ainda uma cautela relevante para dominância estrita: se \(\mathcal D=(0,1)\), então \(\mathcal S=\{+1\}\), embora o casco fechado seja \([0,1]\) e contenha zero. Portanto um endpoint igual a zero no envelope não prova que exista empate; para isso é necessário saber se zero pertence ao conjunto exato.

## 8. Auditoria de T5

### 8.1 Teto de unanimidade

Defina

\[
z_L=1-\beta+\beta^2o_0,
\qquad
d_H=\beta^2o_1,
\qquad
z_H=1-\beta+\beta^2o_1.
\]

Temos

\[
z_H-z_L=\beta^2(o_1-o_0)>0
\]

e

\[
z_H-d_H=1-\beta>0.
\]

Portanto:

- no endpoint baixo, \(\max\{z_L,d_H\}<z_H\);
- na célula baixa existente, \(V_U^\theta=z_L<z_H\);
- na célula alta com \(p=0\), \(V_U^\theta=u\le z_H\);
- na célula alta com \(p>\nu^\star\), \(V_U^\theta=z_H\);
- no endpoint alto, \(V_U^\theta=z_H\).

**PROVED.** Em toda fibra comparável e para ambos os tipos,

\[
V_U^\theta\le z_H.
\]

### 8.2 Identidade central

Como

\[
Z_E=1-\frac{k\beta}{m}
\]

e \(c=m-k\),

\[
\begin{aligned}
Z_E-z_H
&=1-\frac{k\beta}{m}-\left(1-\beta+\beta^2o_1\right)\\
&=\beta\left(1-\frac{k}{m}-\beta o_1\right)\\
&=\beta\left(\frac{c}{m}-\beta o_1\right).
\end{aligned}
\]

**PROVED.** A identidade algébrica está correta.

### 8.3 Margem quantitativa uniforme

AX-AM-2 fornece

\[
V_M^\theta\ge Z_E,
\]

e o lema fornece

\[
V_U^\theta\le z_H.
\]

Consequentemente, para todo par comparável,

\[
V_M^\theta-V_U^\theta
\ge
Z_E-z_H
=
\beta\left(\frac{c}{m}-\beta o_1\right).
\]

Equivalentemente,

\[
\delta_\theta
\le
-\beta\left(\frac{c}{m}-\beta o_1\right).
\]

Como os pesos ex ante são não negativos e somam um,

\[
\delta_E
\le
-\beta\left(\frac{c}{m}-\beta o_1\right).
\]

**PROVED.** T5 pode, portanto, ser enunciado com uma margem uniforme, e não apenas com um sinal.

### 8.4 Região estrita e fronteira

Se

\[
\beta o_1<\frac{c}{m},
\]

então a margem é positiva e

\[
V_M^\theta>V_U^\theta
\]

para ambos os tipos e todo par comparável. A média ex ante também é estritamente maior sob maioria, inclusive nos endpoints: em \(\nu=0\), ela coincide com o contraste do tipo baixo; em \(\nu=1\), com o do tipo alto.

Se

\[
\beta o_1=\frac{c}{m},
\]

então

\[
V_M^\theta\ge V_U^\theta
\]

para todo par comparável. Isso não implica empate: os bounds podem ser frouxos, e em várias células o teto efetivo de \(A_U\) é estritamente menor que \(z_H\).

A redação recomendada deve começar com “suponha \(J_{AC}^{bind}(d,\eta)\ne\varnothing\)” quando a conclusão for chamada de dominância institucional. Sem essa hipótese, a frase universal “para todo par em \(J\)” é formalmente verdadeira em uma fibra vazia, mas não produz comparação econômica.

### 8.5 Suficiência, não necessidade

Quando

\[
\beta o_1>\frac{c}{m},
\]

os dois bounds globais se cruzam. Isso elimina o certificado uniforme baseado apenas em \(Z_E\) e \(z_H\), mas não inverte o ranking.

**PROVED.** O pacote está correto ao não inferir vantagem de unanimidade nessa região.

A partição de \(A_U\) permite um resultado adicional mais forte em células baixas. Se

\[
0<\nu\le\nu^\star,
\qquad p=0,
\qquad \Delta_U\ge0,
\]

então

\[
V_U^0=V_U^1=z_L.
\]

Assim, em toda fibra comparável dessa célula,

\[
V_M^\theta-V_U^\theta
\ge
Z_E-z_L
=
\beta\left(\frac{c}{m}-\beta o_0\right).
\]

Logo,

\[
\beta o_0<\frac{c}{m}
\]

é suficiente para maioria dominar estritamente ambos os tipos nessa célula. Como \(o_0<o_1\), essa condição é estritamente menos exigente que T5.

No endpoint \(\nu=0\), o payoff ex ante de unanimidade é \(z_L\), de modo que a mesma condição \(\beta o_0<c/m\) garante vantagem ex ante estrita de maioria, independentemente do payoff contrafactual do tipo alto.

### 8.6 Contraexemplo verificável à necessidade de T5

**COUNTEREXAMPLE à necessidade, não à suficiência.** Tome

\[
N=5,\quad m=4,\quad k=2,\quad c=2,
\]

\[
\beta=0.9,\quad o_0=0.5,\quad o_1=0.6,\quad \bar y=0.8,
\quad \nu=0.
\]

Então

\[
\frac{c}{m}=0.5,
\qquad
\beta o_1=0.54>0.5,
\]

portanto T5 não se aplica. Mas

\[
Z_E=0.55,
\]

\[
z_L=1-0.9+0.9^2(0.5)=0.505,
\]

\[
d_H=0.9^2(0.6)=0.486.
\]

No endpoint baixo,

\[
(V_U^0,V_U^1)=(z_L,\max\{z_L,d_H\})=(0.505,0.505).
\]

A fibra de \(A_M\) existe porque, no endpoint, \(\rho\) foi quocientado e a existência em alguma fibra recai na única fibra. Para todo binder de maioria,

\[
V_M^\theta\ge Z_E=0.55>0.505=V_U^\theta.
\]

Logo maioria domina estritamente ambos os tipos e ex ante, embora \(\beta o_1<c/m\) falhe. Isso confirma de modo construtivo que T5 não é necessário.

### 8.7 Interpretação de \(c/m\) e efeito de paridade

Como \(k=\lfloor N/2\rfloor\),

\[
\frac{c}{m}
=
\begin{cases}
\frac12, & N\text{ ímpar},\\[4pt]
\frac{N-2}{2(N-1)}, & N\text{ par}.
\end{cases}
\]

**PROVED.** Para número ímpar de Estados, T5 reduz a

\[
\beta o_1<\frac12.
\]

Para número par, o limiar é estritamente inferior a \(1/2\), embora converja a \(1/2\) à medida que \(N\) cresce. Esse efeito de paridade é substantivamente interpretável: ele vem da fração de Estados fracos que o hegemon pode excluir ao formar uma coalizão mínima sob a quota definida.

O certificado fica mais fácil de satisfazer quando o hegemon é mais impaciente, quando seu payoff de desacordo alto é menor ou quando a regra de maioria permite excluir uma fração maior dos Estados fracos.

## 9. Testes adversariais e contraexemplos

| Teste | Resultado | Classificação |
|---|---|---|
| Primitivas iguais, mas \(\rho_M\ne\rho_U\), com \(0<\nu<1\) | Excluído porque \(\eta_M\ne\eta_U\); como \(b_\rho(\nu)\) é injetiva, também \(p_M\ne p_U\). | **PROVED** |
| Dois rótulos de \(\rho\) em \(\nu=0\) ou \(\nu=1\) | Não criam fibras diferentes: \(\rho\) é quocientado e \(\eta=(*,\nu)\). | **PROVED** |
| Usar \(V_M^0\) e \(V_M^1\) de binders diferentes | Não pertence a \(\mathcal V_M^{01}\); atomicidade exclui o splice. | **PROVED** |
| Formar \(\delta_E\) a partir de \(\delta_0\) e \(\delta_1\) escolhidos separadamente | Pode criar valores inexistentes; o exemplo \(\{(0,1),(1,0)\}\) demonstra. O pacote evita o erro ao operar no par ligado. | **COUNTEREXAMPLE** ao atalho |
| Construir lei conjunta a partir de duas marginais | O produto independente sempre fornece uma sob hipóteses usuais. As marginais não identificam qual acoplamento é substantivamente correto. | **COUNTEREXAMPLE** à frase “não existe” |
| \(\nu=0\) e \(\nu=1\) | T2 funciona sem divisão; o tipo de massa zero permanece no vetor, mas some da média. | **PROVED** |
| \(\rho=0\) | Para prior interior, \(p=0\). A partição usa corretamente essa fibra. | **PROVED** |
| \(\rho=\infty\) | Para prior interior, \(p=1\). Na região alta pertence à célula \(p>\nu^\star\); na baixa, à célula none. | **PROVED** |
| \(p=\nu^\star\) | Na região alta pertence ao intervalo vazio \((0,\nu^\star]\), não à célula alta estrita. | **PROVED** |
| \(\Delta_U=0\) | Incluído na célula baixa existente com \(p=0\). | **PROVED** |
| Célula none | Produto, contrastes e sinais são vazios; não se deve aplicar envelope ou sentinela numérico. | **PROVED** |
| Conjuntos de sinais \(\{+1\}\), \(\{0,+1\}\), \(\{-1,0\}\), \(\{-1,+1\}\), \(\{-1,0,+1\}\) | As interpretações fornecidas seguem exatamente da função sinal. | **PROVED** |
| Conjuntos abertos nos envelopes | \(U=M=(0,1)\) produz \(D=(-1,1)\), confirmando as fórmulas sem atingimento. | **MECHANICAL EVIDENCE ONLY** |
| Teto \(V_U^\theta\le z_H\) | Verificado célula por célula; não há caso omitido na partição. | **PROVED** |
| Identidade de T5 | Simplificação simbólica independente resulta identicamente em zero para a diferença entre os dois lados. | **MECHANICAL EVIDENCE ONLY**, além da prova algébrica |
| Exemplos 1–4 do pacote | Os valores numéricos reproduzem \(0.126\), a fronteira \(Z_E=z_H=0.55\), o silêncio dos bounds fora da região e o intervalo \([0.486,0.586]\). | **MECHANICAL EVIDENCE ONLY** |
| Amostragem numérica admissível | Cem mil sorteios de \(N,\beta,o_0,o_1\) não produziram violação da identidade de T5 nem do teto enumerado de unanimidade. | **MECHANICAL EVIDENCE ONLY** |
| Inverter os bounds quando \(Z_E<z_H\) | Inválido: lower bound de \(M\) abaixo de upper bound de \(U\) é compatível com qualquer ranking dos valores efetivos. | **PROVED** |
| Aplicar novo fator de \(\beta\) em \(A_C\) | Contradiz AX-EXT-3 e muda a data econômica. | **PROVED** |
| Tratar a diagonal de \(\rho\) como requisito de PBE | Incorreto; é regra autoral de comparação, não condição endógena de equilíbrio. | **MODELING CHOICE** |

### 9.1 Acoplamentos com as mesmas marginais

Para tornar precisa a objeção sobre leis conjuntas, suponha que os outcomes nas duas regras sejam binários e que ambas as marginais sejam Bernoulli\((1/2)\). Há, entre outros, três acoplamentos:

1. correlação positiva perfeita:
   \[
   \Pr(0,0)=\Pr(1,1)=1/2;
   \]
2. correlação negativa perfeita:
   \[
   \Pr(0,1)=\Pr(1,0)=1/2;
   \]
3. independência:
   \[
   \Pr(i,j)=1/4\quad\text{para todo }i,j\in\{0,1\}.
   \]

Todos têm as mesmas duas marginais. Portanto o par ordenado de leis não identifica correlação, probabilidade de coincidência, lei da diferença individual ou qualquer evento genuinamente cross-world.

Esse exemplo também mostra por que a correção não exige mudar \(\mathcal O_{AC}\): preservar apenas as marginais ordenadas é exatamente a escolha correta. O que deve mudar é somente a afirmação existencial sobre acoplamentos.

## 10. Escolhas de modelagem versus defeitos

### 10.1 Diagonal de \(\rho\)

**MODELING CHOICE.** Exigir \(\eta_M=\eta_U\) controla a crença off-path na comparação e evita seleção assimétrica entre instituições. É uma escolha defensável de ceteris paribus.

Ela não é a única escolha possível. Um estudo de robustez poderia, separadamente, comparar:

- a união das comparações diagonais sobre todas as fibras;
- todos os pares cross-fiber;
- rankings robustos a qualquer fibra admissível.

Nada disso é necessário para a correção de \(A_C\). Seriam objetos adicionais com interpretação distinta.

### 10.2 Ausência de acoplamento cross-world

**MODELING CHOICE.** O game form não contém um choque comum nem uma regra que alinhe realizações aleatórias entre as instituições. Por isso \(A_C\) não deve impor igualdade de sorteios ou de outcomes.

**COUNTEREXAMPLE.** A ausência de uma regra endógena não implica inexistência matemática de acoplamentos. Implica não identificação e falta de autorização substantiva para escolher um deles; o defeito é de redação, não da construção de \(\mathcal O_{AC}\).

### 10.3 Bem-estar dos Estados fracos

**MODELING CHOICE.** Sem função de bem-estar, pesos distributivos ou ordem sobre as leis anônimas, não há base para transformar o par de distribuições em ranking social. Ainda assim, algumas comparações marginais poderiam ser definidas se fossem autorizadas, como probabilidade de acordo ou dominância estocástica de uma estatística específica. O pacote corretamente não as introduz silenciosamente.

### 10.4 Condicionalidade às fontes

**UNRESOLVED fora do escopo, resolvido condicionalmente dentro dele.** T1–T5 dependem da validade de AX-AM-1/2, AX-AU-1/2, AX-SUM-1 e AX-EXT-3. Esta consulta não reabre esses resultados. Portanto a conclusão é: \(A_C\) transporta corretamente os inputs declarados; ela não constitui prova independente desses inputs.

### 10.5 Alcance substantivo

**PROVED.** T5 é um resultado forte porque é uniforme em tipo, prior, fibra, seleção de equilíbrio e célula comparável. Ao mesmo tempo, ele é deliberadamente parcial:

- não garante que uma fibra comparável exista;
- não classifica regiões em que a condição falha;
- não ordena acordo, atraso ou bem-estar;
- não converte células none em evidência favorável a uma instituição.

Esse é o limite correto do resultado, não uma fraqueza lógica.

## 11. Correções mínimas

### 11.1 Redação sobre leis conjuntas — necessária

Substituir o trecho substantivo por:

> **O game form e o objeto \(A_C\) não induzem nem identificam uma lei conjunta entre as duas regras. \(\mathcal O_{AC}\) preserva, portanto, um par ordenado de leis marginais, não uma distribuição model-implied sobre pares de realizações. Embora seja matematicamente possível impor um acoplamento — por exemplo, o produto independente — qualquer escolha desse tipo acrescentaria uma convenção cross-world ausente das primitivas. Sem essa convenção, não são identificadas correlações, probabilidades de eventos conjuntos ou leis de diferenças realização a realização.**

Essa redação preserva integralmente a arquitetura pretendida e elimina a afirmação existencial falsa.

### 11.2 Não vacuidade em T5 — precisão lógica

Redação recomendada:

> **Suponha \(J_{AC}^{bind}(d,\eta)\ne\varnothing\). Se \(\beta o_1<c/m\), então, para todo \((R_M,R_U)\in J_{AC}^{bind}(d,\eta)\) e ambos os tipos,**
> \[
> V_M^\theta-V_U^\theta
> \ge
> \beta\left(\frac{c}{m}-\beta o_1\right)>0.
> \]
> **Consequentemente, \(\delta_\theta<0\) e \(\delta_E<0\).**

A hipótese não é necessária para a validade formal da quantificação universal, mas é necessária para chamar a conclusão de dominância numa fibra.

### 11.3 Definição explícita da coordenada ex ante

Inserir antes dos envelopes:

\[
V_g^E(R_g)
:=(1-\nu)V_g^0(R_g)+\nu V_g^1(R_g),
\qquad g\in\{M,U\}.
\]

Em seguida, especificar \(r\in\{0,1,E\}\).

Também é recomendável inserir:

\[
\mathcal D_E
=
\{(1-\nu)x_0+\nu x_1:(x_0,x_1)\in\mathcal D_{01}\},
\]

com a observação de que, em geral,

\[
\mathcal D_E
\ne
(1-\nu)\mathcal D_0+\nu\mathcal D_1.
\]

### 11.4 Borelidade da coordenada do prior

Escolher uma das duas formulações:

1. **fiberwise:** escrever \(\bar C_{econ}^{d,\eta}\), tratando \(\nu\) como constante na fibra; ou
2. **global:** acrescentar que os resumos incluem uma projeção Borel da fibra \((d,\eta)\), em particular de \(\nu\), e definir \(\bar C_{econ}\) no produto dos espaços globais de resumos.

### 11.5 Envelopes

Substituir “casco intervalar” por “casco intervalar fechado” e explicitar uma das opções:

> **Como os payoffs são reais e limitados no domínio do modelo, \(M_r\), \(U_r\) e \(\mathcal D_r\) são limitados.**

ou, se se preferir máxima generalidade:

> **As identidades de ínfimo e supremo são entendidas nos reais estendidos; nas aplicações do modelo, os payoffs são limitados e os endpoints são finitos.**

### 11.6 Corolário quantitativo recomendado

Acrescentar após T5:

> **Corolário. Sob as hipóteses de T5, a vantagem de maioria possui margem uniforme mínima**
> \[
> g=\beta\left(\frac{c}{m}-\beta o_1\right)>0,
> \]
> **tanto por tipo quanto ex ante.**

### 11.7 Corolário de célula baixa recomendado

Acrescentar, sem substituir T5:

> **Em qualquer fibra comparável com \(0<\nu\le\nu^\star\), \(p=0\) e \(\Delta_U\ge0\), a condição \(\beta o_0<c/m\) é suficiente para maioria dominar estritamente ambos os tipos e ex ante. No endpoint \(\nu=0\), ela é suficiente para a vantagem ex ante.**

Esse corolário explora informação já presente na partição exata e torna concreto por que T5 não é necessário.

## 12. Recomendação consultiva final

**PROVED.** Condicionalmente aos resultados congelados de \(A_M\) e \(A_U\), o objeto exato de comparação, a existência fibra a fibra, a fatorização econômica, o lifting setwise, os contrastes ligados, as classificações por sinais, os envelopes e o certificado T5 são matematicamente corretos.

**COUNTEREXAMPLE.** A única afirmação que não se sustenta em sua leitura literal é que “não existe” lei conjunta cross-world. Leis conjuntas existem matematicamente; o que não existe nas primitivas é uma lei conjunta selecionada, induzida ou identificada. A substituição textual proposta resolve o problema sem alterar qualquer definição, prova ou resultado econômico.

**PROVED.** T5 é mais forte do que seu enunciado atual deixa evidente, pois entrega uma margem uniforme. A partição de unanimidade também permite resultados locais mais fortes, notadamente o certificado \(\beta o_0<c/m\) nas células baixas e no payoff ex ante do endpoint baixo. O efeito de paridade em \(c/m\) é uma implicação substantiva transparente que merece ser mencionada ao interpretar o teorema.

**MODELING CHOICE.** A diagonal de crenças e a ausência de acoplamento model-implied são escolhas coerentes. Devem ser apresentadas como condições da comparação, não como consequências necessárias de PBE. Células none representam incomparabilidade na diagonal, não evidência de superioridade institucional.

Minha recomendação consultiva é que os resultados sejam aceitos pelo autor como uma comparação correta **condicional às fontes congeladas**, depois da correção da redação sobre leis conjuntas e das pequenas precisões formais indicadas. Não permanece questão matemática genuinamente não resolvida dentro do escopo de \(A_C\); permanecem apenas a condicionalidade aos resultados-fonte e as escolhas substantivas explicitamente assumidas pelo desenho comparativo.
