# Consulta técnica externa não formal — auditoria adversarial de \(A_T\)

**Documento auditado:** `2026-08-30_A_T_msb_consulta_efeito_causal_agenda.md`  
**Data:** 30 de agosto de 2026  
**Natureza:** **consulta técnica externa não formal**

## 1. Natureza e limite da consulta

Esta é uma **consulta técnica externa não formal**. Ela não constitui parecer formal independente, não concede `PASS`, não fecha gate, não congela resultados e não autoriza implementação ou migração ao manuscrito.

A auditoria aceita como axiomas os fatos do jogo-base em AX-PAPER-1–6 e, como inputs condicionais, as correspondências congeladas em AX-EXT-1–6. O que foi refeito foi o transporte desses inputs para \(A_T\): definição do contrafactual, normalização temporal, identidades, álgebra por ramos, fronteiras, existência, multiplicidade e interpretação causal. As revisões anteriores e os resultados mecânicos informados no pacote não foram usados como evidência.

## 2. Veredito executivo

**Não encontrei defeito matemático nas proposições T1–T6, em C1–C2 nem nas fórmulas de \(Q_U\), condicionalmente aos axiomas e às correspondências congeladas fornecidas.** O desenho \(2\times2\), o fator adicional de desconto no braço sem agenda, a decomposição \(T=D+I\), as fórmulas de \(D_M\) e \(\Delta D\), a classificação de \(T_U\), a preservação da multiplicidade de \(T_M\) e a comparação institucional estão corretos.

O resultado, contudo, precisa de quatro qualificações explícitas:

1. O objeto é um **contraste causal estrutural dentro do modelo**, não um estimando empiricamente identificado. Quando há multiplicidade, ele é uma correspondência de contrastes admissíveis, e não um número único.
2. A convenção de datas é uma **escolha de modelagem coerente e substantiva**: o controle espera até \(R1\), enquanto o tratamento acrescenta uma oportunidade anterior em \(A\). Assim, o tratamento inclui conjuntamente antecipação temporal e proposta obrigatória. Se \(R1\) fosse redatado para ocorrer em \(A\) no controle, o estimando seria outro.
3. A prova de T3 omite um lema curto, necessário para ordenar os ramos: \(\tau_M>1/m\). O lema segue das primitivas, portanto a omissão não torna a proposição falsa.
4. Expressões como “a agenda beneficia mais sob unanimidade se e somente se” devem receber a qualificação **membro a membro**. Sem seleção de equilíbrio, uma comparação robusta exige que a correspondência inteira fique de um lado do limiar.

Minha recomendação consultiva é manter os resultados e fazer correções mínimas de exposição. Não há razão, com base no material reproduzido, para reabrir a solução dos jogos anteriores.

## 3. Reconstrução da pergunta causal

Fixe regra \(g\in\{M,U\}\), tipo \(\theta\), prior \(\nu\), primitivas e arquitetura M/S/B. O tratamento é a mudança do game form

\[
\text{controle: aguardar até }R1
\quad\longrightarrow\quad
\text{tratamento: proposta obrigatória anterior em }A,
\]

mantendo informação privada nos dois braços. Avaliados na data comum \(A\), os payoffs são

\[
Y_g(1,\theta)=V_g^{A,\theta},
\qquad
Y_g(0,\theta)=\beta V_g^{N,R1,\theta},
\]

e, portanto,

\[
T_g^\theta=Y_g(1,\theta)-Y_g(0,\theta)
=V_g^{A,\theta}-\beta V_g^{N,R1,\theta}.
\]

Esse é o contraste correto **para o tratamento definido no pacote**. A proposta obrigatória pode alterar crenças e continuações; essas mudanças são mecanismos do tratamento, não violações da condição de manter informação privada.

Há uma alternativa conceitualmente diferente: eliminar \(A\) e deslocar \(R1\) para a própria data \(A\). Nesse caso, o contraste seria \(V_g^{A,\theta}-V_g^{N,R1,\theta}\), sem o fator externo \(\beta\). O pacote não escolheu esse tratamento. Isso é uma escolha de modelagem, não um defeito matemático, mas deve permanecer visível porque afeta a interpretação substantiva.

Quando os braços têm múltiplos equilíbrios, \(T_g^\theta\) deve ser lido como a imagem de pares admissíveis de registros completos. Sem regra de seleção cross-world, não existe um “efeito individual” escalar oculto por trás dessa imagem.

## 4. Auditoria do desenho \(2\times2\) e das datas

O desenho cruza corretamente os dois fatores:

| Agenda | Informação completa | Informação privada |
|---|---:|---:|
| Sem agenda | \(\beta h_g^{N,R1}(o_\theta)\) | \(\beta V_g^{N,R1,\theta}\) |
| Com agenda | \(h_g^A(o_\theta)\) | \(V_g^{A,\theta}\) |

As quatro células usam as mesmas primitivas e são avaliadas na mesma data econômica. O \(\beta\) externo aparece exatamente nas duas células sem agenda porque seus valores nativos estão em \(R1\), uma rodada após \(A\). Não aparece nas células com agenda porque elas já são valores em \(A\).

Não há desconto duplicado. Por exemplo, \(h_U^{N,R1}(o)=\beta o\) já desconta, dentro do jogo sem agenda, o desacordo posterior a \(R1\). O fator adicional em \(\beta h_U^{N,R1}(o)=\beta^2o\) apenas transporta esse valor de \(R1\) para \(A\).

Nos endpoints \(\nu=0\) e \(\nu=1\), o regime chamado de “informação privada” é degenerado ex ante. Ainda assim, conservar o vetor dos dois tipos é coerente com AX-PAPER-3. É indispensável distinguir:

- a coordenada de um tipo fora do suporte, que permanece no vetor contrafactual;
- o efeito ex ante, que atribui peso zero a essa coordenada.

## 5. Auditoria de T1: identidade fatorial

Pelas definições,

\[
V_g^{A,\theta}=h_g^A(o_\theta)+RI_g^{A,\theta}
\]

e

\[
\beta V_g^{N,R1,\theta}
=\beta h_g^{N,R1}(o_\theta)+\beta RI_g^{N,R1,\theta}.
\]

Subtraindo a segunda igualdade da primeira,

\[
T_g^\theta
=\underbrace{h_g^A(o_\theta)-\beta h_g^{N,R1}(o_\theta)}_{D_g^\theta}
+\underbrace{RI_g^{A,\theta}-\beta RI_g^{N,R1,\theta}}_{I_g^\theta}.
\]

Logo,

\[
T_g^\theta=D_g^\theta+I_g^\theta
\]

é uma identidade algébrica, não uma hipótese comportamental. Não há dupla contagem: \(D_g\) contém a diferença entre benchmarks de informação completa; \(I_g\) contém a mudança, produzida pela agenda, na diferença privado–completo.

A identidade também é exata para correspondências. Como \(D_g^{01}\) é fixo dadas as primitivas, somá-lo a \(I_g^{01}\) apenas translada cada vetor ligado. A média ex ante preserva a identidade porque é aplicada **depois** da formação do vetor completo:

\[
(1-\nu)T_g^0+\nu T_g^1
=(1-\nu)(D_g^0+I_g^0)+\nu(D_g^1+I_g^1).
\]

Essa conclusão deixaria de ser autorizada se coordenadas de equilíbrios diferentes fossem recombinadas; o pacote proíbe corretamente essa operação.

## 6. Auditoria de T2–T3: efeitos sob informação completa

### Unanimidade

O cálculo é imediato:

\[
D_U(o)=1-\beta+\beta^2o-\beta(\beta o)=1-\beta>0.
\]

T2 está correta.

### Maioria

No ramo \(o\le 1/m\),

\[
D_M(o)
=1-\frac{k\beta(1-\beta o)}m-\beta^2o
=Z_E-\frac cm\beta^2o.
\]

No ramo \(o>1/m\),

\[
D_M(o)
=\max\{Z_E,\beta o\}-\beta o
=\max\{Z_E-\beta o,0\}.
\]

Portanto a forma declarada em T3 está correta. Falta apenas inserir antes dela o lema de ordenação

\[
\tau_M-\frac1m
=\frac{m-\beta(k+1)}{m\beta}>0.
\]

Com efeito, \(m\ge k+1\) para \(N\ge4\), e \(\beta<1\); logo \(m-\beta(k+1)>0\). Isso prova que todo o primeiro ramo está abaixo de \(\tau_M\) e valida a afirmação

\[
D_M(o)>0\iff o<\tau_M
\]

no domínio admissível. No primeiro ramo, a prova do pacote é ainda mais forte:

\[
D_M(o)-(1-\beta)=\beta\frac cm(1-\beta o)>0.
\]

Também é útil registrar

\[
\tau_M-\frac cm=\frac{1-\beta}{\beta}>0.
\]

Assim, quando \(c>1\), a raiz \(c/m\) do ramo intermediário de \(\Delta D\) sempre ocorre antes de \(\tau_M\).

As fórmulas de \(\Delta D=D_U-D_M\) estão corretas. Em \(o=\tau_M\), os dois valores declarados coincidem:

\[
\beta\left(\tau_M-\frac cm\right)=1-\beta.
\]

Em \(o=1/m\), deve-se usar o primeiro ramo, como faz o pacote. Há ali uma descontinuidade induzida pela seleção congelada do benchmark. Mais precisamente,

\[
D_M(1/m)-\lim_{o\downarrow1/m,\,o>1/m}D_M(o)
=\frac\beta m\left(1-\frac{c\beta}{m}\right)>0.
\]

Consequentemente, \(\Delta D\) dá um salto para cima. Quando \(c=1\), isto é, \(N=4\), \(\Delta D(1/m)<0\), mas \(\Delta D(o)>0\) para todo \(o>1/m\) suficientemente próximo; não há uma raiz efetiva em \(o=1/m\). A observação final de C1 está correta, mas anunciar a descontinuidade tornaria o resultado mais transparente.

Por fim, \(\tau_M\) nem sempre pertence ao domínio \(o\in(0,1)\):

\[
\tau_M<1
\iff
\beta>\frac{m}{m+k}.
\]

Se \(\beta\le m/(m+k)\), então \(\tau_M\ge1\), o ramo de atraso é vazio para os valores admissíveis de \(o\), e \(D_M(o)>0\) para todo \(o\in(0,1)\). A frase “no limiar” deve ser entendida condicionalmente à existência de um limiar admissível.

## 7. Auditoria de T4: unanimidade sob informação privada

T4 transporta corretamente cada fibra de AX-EXT-4.

### Endpoint \(\nu=0\)

O tratamento fornece

\[
(z_L,\max\{z_L,d_H\}),
\]

e o controle, transportado para \(A\), fornece

\[
(\beta^2o_0,d_H).
\]

Logo,

\[
T_U^{01}
=(1-\beta,\max\{z_L-d_H,0\})
=(1-\beta,\max\{\Delta_U,0\}).
\]

Como o tipo alto tem peso zero, \(T_U^E=1-\beta\), ainda que sua coordenada contrafactual seja zero.

### Prior baixo positivo

Para \(0<\nu\le\nu^\star\), o controle privado sem agenda é `none`. A diferença não existe no conceito mantido, mesmo quando a fibra tratada existe. A propagação de `none` está correta.

### Prior alto com crença off-path zero

O controle transportado é \((d_H,d_H)\), e o tratamento é \((u,u)\), com \(u\in[u_{\min},z_H]\). Portanto,

\[
T_U^{01}
=\{(u-d_H,u-d_H):u\in[u_{\min},z_H]\},
\]

cuja imagem coordenada é

\[
[\max\{\Delta_U,0\},1-\beta].
\]

O segmento é diagonal, não o quadrado cartesiano correspondente.

### Demais células altas

Com crença baixa positiva, a fibra tratada é `none`, portanto \(T_U\) é `none`. Com crença alta ou em \(\nu=1\), a subtração de \((d_H,d_H)\) de \((z_H,z_H)\) produz \((1-\beta,1-\beta)\). Tudo está correto.

### Auditoria dos zeros

O membro \(u=d_H\) pertence ao intervalo admissível exatamente quando

\[
d_H\in[\max\{z_L,d_H\},z_H].
\]

A desigualdade \(d_H<z_H\) é automática, pois \(z_H-d_H=1-\beta>0\). A desigualdade inferior vale se e somente se \(d_H\ge z_L\), isto é,

\[
\Delta_U=z_L-d_H\le0.
\]

Logo a condição indicada no pacote é correta. Nos objetos existentes, zero aparece exatamente em:

1. a coordenada alta fora do suporte em \(\nu=0\), quando \(\Delta_U\le0\);
2. o membro diagonal \(u=d_H\) da fibra \(\rho=0\), quando \(\Delta_U\le0\).

Não há outro zero, pois \(1-\beta>0\). Na segunda família, como as duas coordenadas são iguais, o efeito ex ante também é zero. Isso contrasta com \(\nu=0\), onde apenas uma coordenada de peso zero se anula.

## 8. Auditoria de T5: maioria sob informação privada

A representação

\[
T_M^{01}=D_M^{01}+I_M^{01}
\]

é exata porque \(D_M^{01}\) é um vetor fixo e \(I_M^{01}\) já foi definido sobre produtos de registros completos. A soma preserva todas as ligações entre tipos, posteriores, outcomes e equilíbrios. Ela não introduz uma seleção adicional.

Membro a membro,

\[
\operatorname{sgn}T_M^\theta
=\operatorname{sgn}\bigl(D_M(o_\theta)+I_M^\theta\bigr),
\]

de onde seguem exatamente as três equivalências de T5. Quando \(o_\theta\ge\tau_M\), o componente direto é zero e \(T_M^\theta=I_M^\theta\).

Não é possível extrair um sinal incondicional adicional dos inputs reproduzidos. O pacote não fornece a imagem explícita de \(I_M\), apenas afirma que ela é exata, set-valued e sem sinal geral congelado. Qualquer conclusão mais forte exigiria reabrir essa correspondência ou impor seleção de equilíbrio, ambas fora do mandato.

O máximo que segue sem informação nova é relacional:

\[
T_M^\theta-I_M^\theta=D_M(o_\theta)\ge0,
\]

com desigualdade estrita se \(o_\theta<\tau_M\) e igualdade se \(o_\theta\ge\tau_M\). Isso não determina o sinal absoluto de \(T_M^\theta\).

## 9. Auditoria de T6: comparação institucional

Para qualquer tupla institucional admissível,

\[
\begin{aligned}
\Delta T^\theta
&=T_U^\theta-T_M^\theta\\
&=(D_U^\theta-D_M^\theta)+(I_U^\theta-I_M^\theta)\\
&=\Delta D^\theta+\Delta I^\theta.
\end{aligned}
\]

T6 está correta, assim como a equivalência membro a membro

\[
T_U^\theta>T_M^\theta
\iff
\Delta I^\theta>-\Delta D^\theta.
\]

O cuidado importante é linguístico. Se \(\Delta I^\theta\) é uma correspondência, a frase sem qualificação pode parecer um ranking institucional único. As versões selection-free são:

- unanimidade produz efeito maior em **todo** membro admissível se e somente se
  
  \[
  \Delta\mathcal I^\theta\subset(-\Delta D^\theta,\infty);
  \]
- unanimidade produz efeito maior em **algum** membro admissível se e somente se
  
  \[
  \Delta\mathcal I^\theta\cap(-\Delta D^\theta,\infty)\ne\varnothing.
  \]

Sem uma dessas qualificações, ou sem seleção, não existe ranking escalar. A regra de que uma fonte `none` torna \(\Delta T\) `none` está correta.

## 10. Auditoria do contraste diagonal \(Q\)

Por definição,

\[
Q_g^\theta
=h_g^A(o_\theta)-\beta V_g^{N,R1,\theta}
=D_g^\theta-\beta RI_g^{N,R1,\theta}.
\]

Esse objeto muda simultaneamente agenda e regime informacional. É um contraste entre dois pacotes fatoriais, não o efeito isolado de agenda, de informação ou da interação.

Para unanimidade:

- em \(\nu=0\), \(RI_U^{N,R1,01}=(0,0)\), logo \(Q_U^{01}=(1-\beta,1-\beta)\);
- em \(0<\nu\le\nu^\star\), o braço privado sem agenda é `none`;
- em \(\nu^\star<\nu\le1\),
  
  \[
  \beta RI_U^{N,R1,01}
  =(\beta^2(o_1-o_0),0),
  \]
  
  e, portanto,
  
  \[
  Q_U^{01}=(\Delta_U,1-\beta).
  \]

A média ex ante declarada,

\[
Q_U^E=1-\beta-(1-\nu)\beta^2(o_1-o_0),
\]

também está correta. \(Q_U\) pode existir quando \(T_U\) é `none`, pois não utiliza a célula de agenda sob informação privada. Essa diferença de domínio é substantiva e foi corretamente assinalada.

Quando todas as células necessárias existem, vale ainda a identidade útil

\[
Q_g^\theta=T_g^\theta-RI_g^{A,\theta}.
\]

Ela deixa claro por que \(Q_g\) geralmente difere do efeito total \(T_g\).

## 11. Existência, multiplicidade e células `none`

As regras operacionais estão corretas:

1. diferenças são formadas somente entre registros completos nas mesmas primitivas;
2. coordenadas de tipos não são recombinadas;
3. médias ex ante são aplicadas ao vetor já ligado;
4. não se presume seleção ou sorteio comum entre mundos contrafactuais;
5. a diferença que requer uma correspondência vazia também é vazia.

Há duas famílias de `none` em \(T_U\):

- \(0<\nu\le\nu^\star\): o controle sem agenda é necessariamente `none`; dependendo da fibra, o tratamento pode existir ou também ser `none`;
- \(\nu^\star<\nu<1\) e \(\nu_{off}\in(0,\nu^\star]\): o controle existe, mas o tratamento é `none`.

A expressão “com braços ausentes diferentes” deve ser lida nesse sentido assimétrico; na primeira família não é verdade que apenas o controle esteja sempre ausente.

Por precisão de exposição, eu substituiria “ausência do efeito” por:

> `none` denota correspondência vazia do contraste no conceito mantido de PBE puro e sob a arquitetura M/S/B.

Isso evita sugerir que o efeito econômico seja zero, que não exista sob outro conceito de solução ou que tenha sido provada inexistência de qualquer equilíbrio misto.

## 12. Tabela claim-by-claim C-1–C-15

| ID | Classificação | Avaliação adversarial |
|---|---|---|
| C-1 | `MODELING CHOICE` | A fórmula mantém informação privada nos dois braços e implementa coerentemente o tratamento definido. Chamá-la de efeito causal estrutural depende da convenção temporal e da interpretação de correspondências. |
| C-2 | `PROVED` | O \(\beta\) externo aparece uma única vez no braço em \(R1\); os descontos internos já contidos em \(h^N,V^N\) não são duplicados. |
| C-3 | `PROVED` | É identidade algébrica obtida por somar e subtrair os benchmarks completos. |
| C-4 | `PROVED` | \(D_U=1-\beta>0\). |
| C-5 | `PROVED` | Verdadeira; a prova deve explicitar \(\tau_M>1/m\). Se \(\tau_M\ge1\), o ramo zero é vazio no domínio admissível. |
| C-6 | `PROVED` | \(\Delta D<0\) no primeiro ramo e pode ser positivo no intermediário/final; o mapa exato de sinais é dado abaixo. |
| C-7 | `PROVED` | Todas as imagens existentes de T4 estão em \([0,1-\beta]\). |
| C-8 | `PROVED` | Há exatamente os dois lugares declarados, ambos sob \(\Delta_U\le0\), condicionalmente à completude de AX-EXT-4. |
| C-9 | `PROVED` | As duas famílias são corretas; na primeira, o controle é sempre ausente e o tratamento pode ou não ser ausente. |
| C-10 | `PROVED` | A alegação de não identificação do sinal segue dos inputs; o sinal substantivo de \(T_M\) permanece `UNRESOLVED FROM GIVEN INPUTS`. |
| C-11 | `PROVED` | Segue de \(T_M^\theta=D_M(o_\theta)+I_M^\theta\), membro a membro. |
| C-12 | `PROVED` | A identidade vale dentro de tuplas ligadas; diferenças entre marginais recombinadas não são autorizadas. |
| C-13 | `PROVED` | \(Q_g\) altera dois fatores simultaneamente. |
| C-14 | `PROVED` | Não existe ação de não propor; portanto a justificativa genérica por valor de opção não está disponível. A não negatividade de \(T_U\) vem das correspondências dadas. |
| C-15 | `PROVED` | `none` não é zero. Recomenda-se descrevê-lo como correspondência vazia no conceito mantido. |

Nenhuma alegação recebeu `MATHEMATICAL DEFECT`.

## 13. Testes adversariais e contraexemplos

### 13.1 Verificação numérica independente das fórmulas por ramos

Foram comparadas diretamente as definições primitivas

\[
h_M^A(o)-\beta h_M^{N,R1}(o)
\]

com a forma fechada de \(D_M\), e \((1-\beta)-D_M\) com a forma fechada de \(\Delta D\), em 194.000 combinações aleatórias, cobrindo \(N=4,\ldots,100\). O maior erro absoluto foi \(2{,}22\times10^{-16}\), compatível com arredondamento de ponto flutuante. Nenhum caso violou \(\tau_M>1/m\). Essa verificação corrobora, mas não substitui, a prova algébrica.

### 13.2 Caso-limite \(N=4\): salto sobre zero

Com \(N=4\), \(m=3\), \(k=2\), \(c=1\) e \(\beta=0{,}9\),

\[
\frac1m=\frac cm=\frac13,
\qquad
\tau_M=\frac49.
\]

No ponto \(o=1/3\),

\[
D_M=0{,}31,
\qquad
\Delta D=-0{,}21.
\]

O limite pela direita é \(D_M=0{,}10\), de modo que o limite pela direita de \(\Delta D\) é zero e, para todo \(o>1/3\) próximo, \(\Delta D>0\). Isso confirma que \(o=c/m\) não é raiz efetiva quando \(c=1\).

### 13.3 Limiar fora do domínio

Com \(N=5\) e \(\beta=0{,}2\), obtém-se \(\tau_M=4{,}5\). Como \(o<1\), nenhum tipo alcança o ramo de atraso e \(D_M(o)>0\) para todo payoff admissível. Portanto seria incorreto interpretar T3 como afirmação de que sempre existe um tipo com \(D_M=0\); o teorema não faz essa afirmação, mas a exposição pode preveni-la.

### 13.4 Contraexemplo à positividade estrita de \(T_U\)

Com \(\beta=0{,}9\), \(o_0=0{,}1\) e \(o_1=0{,}9\),

\[
\Delta_U=-0{,}548.
\]

Em \(\nu=0\), \(T_U^{01}=(0{,}1,0)\). Na região alta com \(\rho=0\), a imagem é

\[
\{(t,t):t\in[0,0{,}1]\}.
\]

Logo a afirmação correta é não negatividade, não positividade estrita.

### 13.5 Contraexemplo à identificação de um escalar sob multiplicidade

No mesmo exemplo, para uma única combinação de primitivas e uma fibra alta \(\rho=0\), o efeito pode ser qualquer vetor diagonal entre \((0,0)\) e \((0{,}1,0{,}1)\). Não há um escalar causal único sem seleção adicional.

### 13.6 Contraexemplo à equiparação de \(Q_U\) e \(T_U\)

Na região alta do mesmo exemplo,

\[
Q_U^0=\Delta_U=-0{,}548,
\]

enquanto, sob crença off-path alta,

\[
T_U^0=1-\beta=0{,}1.
\]

O forte contraste de sinais confirma que \(Q_U\) não pode ser descrito como o efeito causal de agenda.

### 13.7 Ranking institucional muda com \(o\)

No exemplo do pacote com \(N=13\) e \(\beta=0{,}9\), \(\Delta D(0{,}20)=-0{,}27\), enquanto \(\Delta D(0{,}55)=0{,}045\). Portanto nem mesmo no benchmark de informação completa existe dominância global de uma regra.

## 14. Resultados mais fortes que realmente seguem

### R1. Ordenação completa dos limiares

Sempre vale

\[
\frac1m<\tau_M
\qquad\text{e}\qquad
\frac cm<\tau_M.
\]

A primeira desigualdade foi provada na seção 6. A segunda segue de

\[
\tau_M-\frac cm=\frac{1-\beta}{\beta}>0.
\]

Além disso, o ramo \(o\ge\tau_M\) é não vazio no domínio se e somente se \(\beta>m/(m+k)\).

### R2. Classificação exata do sinal de \(\Delta D\)

Se \(c>1\), então

\[
\Delta D(o)
\begin{cases}
<0,&0<o<c/m,\\
=0,&o=c/m,\\
>0,&c/m<o<1.
\end{cases}
\]

Essa classificação respeita a descontinuidade em \(1/m\), mas o sinal não muda ali porque \(1/m<c/m\).

Se \(c=1\), então

\[
\Delta D(o)<0\quad\text{para }o\le1/m,
\qquad
\Delta D(o)>0\quad\text{para }o>1/m,
\]

sem ponto de igualdade. A prova segue diretamente dos três ramos e de \(c/m<\tau_M\).

### R3. Condição necessária e suficiente para positividade uniforme de \(T_U\)

Sobre todas as células não vazias, todos os membros e as duas coordenadas de tipo,

\[
T_U^\theta>0\text{ uniformemente}
\iff
\Delta_U>0
\iff
1-\beta>\beta^2(o_1-o_0).
\]

Se \(\Delta_U>0\), o menor efeito possível é \(\Delta_U\). Se \(\Delta_U\le0\), o endpoint \(\nu=0\) já contém uma coordenada alta igual a zero, e as fibras altas \(\rho=0\) contêm o membro \((0,0)\). Isso prova a necessidade e a suficiência sem selecionar equilíbrio.

### R4. Imagem ex ante completa de \(T_U\)

Aplicando o prior somente aos vetores ligados,

\[
T_U^E=
\begin{cases}
1-\beta,&\nu=0,\\
\texttt{none},&0<\nu\le\nu^\star,\\
[\max\{\Delta_U,0\},1-\beta],
  &\nu^\star<\nu<1,\ \rho=0,\\
\texttt{none},
  &\nu^\star<\nu<1,\ \nu_{off}\in(0,\nu^\star],\\
1-\beta,
  &\nu^\star<\nu<1,\ \nu_{off}\in(\nu^\star,1],\\
1-\beta,&\nu=1.
\end{cases}
\]

Na fibra diagonal \((t,t)\), a média ex ante é o próprio \(t\), razão pela qual o intervalo não depende de \(\nu\) dentro da região alta.

### R5. Condições robustas sem seleção

Para qualquer correspondência não vazia \(\mathcal I_M^\theta\):

\[
T_M^\theta\ge0\text{ em todo membro}
\iff
\mathcal I_M^\theta\subset[-D_M(o_\theta),\infty).
\]

Analogamente,

\[
T_U^\theta>T_M^\theta\text{ em todo membro institucional}
\iff
\Delta\mathcal I^\theta\subset(-\Delta D^\theta,\infty).
\]

São critérios de robustez da correspondência; não são seleções disfarçadas.

### R6. Relação entre o diagonal e o efeito total

Sempre que os dois braços privados necessários existem, isto é, quando
\(V_g^{A,\theta}\) e \(V_g^{N,R1,\theta}\) estão ambos definidos,

\[
Q_g^\theta=T_g^\theta-RI_g^{A,\theta}.
\]

Prova:

\[
T_g^\theta-RI_g^{A,\theta}
=V_g^{A,\theta}-\beta V_g^{N,R1,\theta}
-(V_g^{A,\theta}-h_g^A(o_\theta))
=Q_g^\theta.
\]

## 15. Correções mínimas recomendadas

### Correção matemática necessária

Nenhuma fórmula precisa ser alterada. Para tornar a prova de T3 formalmente autocontida, acrescente o lema

\[
\tau_M>1/m
\]

com a demonstração dada na seção 6. Trata-se de completar a prova, não de corrigir o resultado.

### Melhoria de exposição

1. Diga explicitamente que \(\tau_M\) pode estar fora de \((0,1)\); nesse caso não há ramo admissível com \(D_M=0\).
2. Torne os ramos de \(\Delta D\) disjuntos na apresentação, por exemplo usando \(1/m<o<\tau_M\) no segundo e tratando \(o=\tau_M\) em frase separada.
3. Anuncie a descontinuidade em \(o=1/m\) produzida pela regra congelada de igualdade.
4. No resumo intuitivo e em T6, acrescente “para cada membro/tupla admissível” ao `iff` institucional e apresente separadamente a versão robusta para toda a correspondência.
5. Use notação caligráfica, como \(\mathcal T_M\), quando o objeto for set-valued, reservando \(T_M\) para um membro se isso for compatível com a notação do paper.
6. Defina `none` como correspondência vazia no conceito mantido de PBE puro, e não simplesmente como “ausência do efeito”.
7. Em C-9, esclareça que na família de prior baixo o controle é sempre ausente, mas o tratamento pode também ser ausente.

### Escolha de modelagem opcional

Pode-se acrescentar uma frase contrastando o estimando atual com o contrafactual alternativo que redataria \(R1\) para \(A\). Não é necessário calcular esse objeto; a finalidade é deixar claro que o efeito atual inclui a vantagem de uma oportunidade anterior.

### Extensão que exigiria nova autorização e nova derivação

Exigiriam trabalho além deste pacote:

- selecionar equilíbrios para produzir efeitos escalares;
- derivar bounds numéricos adicionais para \(T_M\) ou \(\Delta T\) a partir da correspondência completa de maioria;
- preencher células `none` com PBE misto ou outro conceito de solução;
- impor distribuição conjunta ou dispositivo de seleção cross-world;
- converter o contraste estrutural em alegação causal empírica;
- acrescentar bem-estar dos Estados fracos.

Nenhuma dessas extensões é necessária para validar \(A_T\) tal como definido.

## 16. Recomendação consultiva final

Condicionalmente às barreiras axiomáticas do pacote, \(A_T\) está matematicamente correto e responde à pergunta proposta: ele isola, dentro do desenho estrutural escolhido, o efeito de inserir uma etapa anterior e obrigatória de agenda mantendo informação privada nos dois braços; decompõe esse efeito sem dupla contagem; caracteriza completamente unanimidade; preserva corretamente a não unicidade sob maioria; e evita confundir o contraste diagonal \(Q\) com o efeito de agenda.

A conclusão adversarial é, portanto, favorável, mas precisa: **nenhum defeito matemático foi encontrado; há um pequeno lema omitido e algumas qualificações de exposição importantes sobre tempo, multiplicidade, robustez e `none`.** Recomendo incorporar essas qualificações antes da decisão autoral terminal, sem reabrir os resultados congelados.
