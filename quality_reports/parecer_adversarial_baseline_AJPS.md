# Parecer adversarial sobre a arquitetura baseline

**Modelo:** baseline com \(\pi_H=0\)  
**Objeto auditado:** arquitetura de poder informacional por pivotalidade  
**Objetivo:** revisão adversarial de derivação, payoffs, equilíbrios, restrições de domínio e calibração para submissão acadêmica.

## Veredito

A arquitetura está **algebricamente correta na calibração OPEC reportada**, e os resultados centrais — cutoff de \(R2\), viabilidade de pooling em \(R1\), cutoff \(\mu=0.7\), payoff constante de \(H\) sob unanimidade, e nesting \(F_U\subseteq F_M^{pass}\) — batem. Mas eu **não assinaria “PASS without reservations”** ainda. O pacote precisa explicitar algumas hipóteses que hoje estão implícitas e são matematicamente carregadas: domínio de \(\alpha\), impossibilidade de contratos estado-contingentes, protocolo exato de atraso sem informação, conceito de payoff fraco usado na entrada, e timing da outside option de \(H\). Sem isso, um revisor de teoria pode atacar a prova, não por erro algébrico, mas por incompletude do jogo.

Minha avaliação: **condicionalmente correto; formalmente subespecificado em pontos essenciais.**

---

# 1. Primitivos e restrições de domínio

O pacote declara

\[
N\geq 3,\qquad m=N-1,\qquad q=\lfloor N/2\rfloor+1,
\]

\[
V(0)=1,\qquad V(1)=r>1,
\]

\[
V_e(\mu)=1+\mu(r-1),
\]

\[
d_H(\theta)=\alpha V(\theta),
\]

com \(\beta\in(0,1)\).

Isso é insuficiente como domínio formal. Para as derivações reportadas serem válidas sem qualificação adicional, você precisa impor algo como

\[
\mu\in[0,1],\qquad r>1,\qquad \beta\in(0,1),\qquad \alpha\geq 0,
\]

e, mais forte, para o pooling em unanimidade de \(R2\),

\[
\alpha r\leq 1.
\]

A razão é simples: o contrato pooling em \(R2\) paga a \(H\)

\[
h=\alpha r
\]

em ambos os estados. Como esse contrato também passa no estado baixo, ele precisa ser factível quando \(V(0)=1\). Logo,

\[
\alpha r\leq 1
\]

é uma restrição de factibilidade de baixa realização. Se \(\alpha r>1\), o termo

\[
V_e(\mu)-\alpha r
\]

não pode simplesmente aparecer no máximo de \(W_2^U(\mu)\), porque o contrato pooling que o gera é infeasible no estado baixo.

Portanto, a primeira correção formal é declarar explicitamente:

\[
\boxed{\alpha\in[0,1/r].}
\]

Se você quiser permitir \(\alpha>1/r\), então o resultado de \(R2\) precisa ser reescrito com uma restrição de factibilidade e, provavelmente, com uma opção de não acordo no máximo.

Também recomendo incluir explicitamente a opção zero:

\[
W_2^U(\mu)
=
\frac{1}{m}
\max\{0,\,(1-\mu)(1-\alpha),\,V_e(\mu)-\alpha r\}.
\]

Sob \(\alpha\in[0,1/r]\), o zero é redundante. Mas incluí-lo torna o resultado robusto e evita objeção imediata.

---

# 2. Tecnologia contratual: ponto crítico

As fórmulas assumem que o pagamento a \(H\) **não pode ser contingente ao estado verdadeiro**. Isso precisa aparecer nos primitivos.

O resultado de unanimidade depende de o proposer precisar pagar

\[
\alpha r
\]

também quando o estado é baixo, para induzir aceitação pooling do tipo alto. Se contratos estado-contingentes fossem permitidos e o estado fosse verificável ex post, o proposer poderia oferecer

\[
h(0)=\alpha,\qquad h(1)=\alpha r,
\]

e o custo esperado seria

\[
\alpha V_e(\mu),
\]

não \(\alpha r\). Nesse caso, boa parte da “renda” pooling desapareceria.

Logo, a arquitetura precisa dizer algo como:

\[
\text{Transfers are non-state-contingent because } \theta \text{ is privately observed by } H \text{ and not contractible.}
\]

Sem essa frase, um revisor pode dizer que o mecanismo é um artefato de uma restrição contratual não declarada.

---

# 3. Majority pass branch

O resultado reportado é:

\[
\mathcal{P}_M^F
=
\left\{
\mu:
\frac{\beta(q-1)V_e(\mu)}{m}\leq 1
\right\},
\]

\[
V_H^M(\mu)=\alpha V_e(\mu),
\qquad
V_W^M(\mu)=\frac{V_e(\mu)}{m}.
\]

Esse resultado está correto no ramo em que a proposta majoritária passa.

Sob maioria, um weak proposer pode excluir \(H\). Ele precisa comprar apenas \(q-1\) weak voters. Cada weak voter selecionado exige sua continuação descontada,

\[
\frac{\beta V_e(\mu)}{m}.
\]

Logo, o custo total mínimo de coalizão é

\[
(q-1)\frac{\beta V_e(\mu)}{m}.
\]

Como a proposta precisa ser factível no estado baixo, a restrição correta é

\[
(q-1)\frac{\beta V_e(\mu)}{m}\leq 1.
\]

Portanto,

\[
\mathcal{P}_M^F
=
\left\{
\mu:
\frac{\beta(q-1)V_e(\mu)}{m}\leq 1
\right\}
\]

está correta.

O payoff médio dos weak states também está correto. A soma dos payoffs institucionais dos weak states é o excedente esperado

\[
V_e(\mu),
\]

e, ex ante, por simetria entre os \(m\) weak states,

\[
V_W^M(\mu)=\frac{V_e(\mu)}{m}.
\]

O payoff de \(H\) também está correto **desde que** a outside option seja realmente externa ao pie institucional:

\[
V_H^M(\mu)=\alpha V_e(\mu).
\]

Isso deve ser enfatizado. Se algum leitor interpretar \(d_H\) como parte do mesmo pie, então haveria double counting: os weak states recebem \(V_e(\mu)\) e \(H\) recebe adicionalmente \(\alpha V_e(\mu)\). O pacote diz que a outside option é externa, então não há erro, mas isso precisa ser mantido de forma explícita no paper.

Uma condição útil para generalizar a calibração é:

\[
\mathcal{P}_M^F=[0,1]
\iff
\frac{\beta(q-1)r}{m}\leq 1.
\]

Na calibração OPEC,

\[
N=13,\quad m=12,\quad q=7,\quad r=1.5,\quad \beta=0.9,
\]

então

\[
\frac{\beta(q-1)r}{m}
=
\frac{0.9\cdot 6\cdot 1.5}{12}
=
0.675<1.
\]

Logo, a majority pass branch é global na calibração OPEC. Esse ponto está correto.

---

# 4. Unanimity Round 2

O pacote afirma:

\[
W_2^U(\mu)
=
\frac{1}{m}
\max\{(1-\mu)(1-\alpha),\,V_e(\mu)-\alpha r\}.
\]

A derivação está correta sob \(\alpha\in[0,1/r]\).

Há duas propostas relevantes em \(R2\).

## Proposta low-only

Oferecer

\[
h=\alpha
\]

a \(H\). O tipo baixo aceita; o tipo alto rejeita. O payoff esperado do weak proposer é

\[
(1-\mu)(1-\alpha).
\]

## Proposta pooling

Oferecer

\[
h=\alpha r.
\]

Ambos os tipos aceitam. O payoff esperado do weak proposer é

\[
V_e(\mu)-\alpha r.
\]

Como o proposer de \(R2\) é um weak state sorteado simetricamente entre \(m\), o payoff representativo de um weak state é

\[
\frac{1}{m}
\max\{(1-\mu)(1-\alpha),\,V_e(\mu)-\alpha r\}.
\]

O cutoff é obtido por

\[
(1-\mu)(1-\alpha)=V_e(\mu)-\alpha r.
\]

Substituindo \(V_e(\mu)=1+\mu(r-1)\):

\[
(1-\mu)(1-\alpha)
=
1+\mu(r-1)-\alpha r.
\]

Rearranjando:

\[
\alpha(r-1)=\mu(r-\alpha).
\]

Logo,

\[
\boxed{
\mu_2^*=\frac{\alpha(r-1)}{r-\alpha}.
}
\]

Correto.

A frase “below the cutoff, the low type binds; above the cutoff, the high type binds” está aceitável, mas eu escreveria de forma mais precisa:

\[
\mu<\mu_2^*:
\text{ low-only offer is optimal;}
\]

\[
\mu>\mu_2^*:
\text{ pooling offer is optimal.}
\]

No cutoff, o proposer é indiferente. Se o payoff de \(H\) em \(R2\) for usado em algum lugar no cutoff, você precisa especificar a seleção no empate. Para \(g(\mu)\), isso não importa; para o payoff de \(H\), pode importar em algumas versões gerais.

---

# 5. Unanimity Round 1

O pacote define

\[
g(\mu)=
\max\{(1-\mu)(1-\alpha),\,V_e(\mu)-\alpha r\}.
\]

Então o payoff representativo de continuação de cada weak state em \(R2\) é

\[
\frac{g(\mu)}{m}.
\]

Logo, em \(R1\), cada weak voter exige

\[
y_P=\frac{\beta g(\mu)}{m}.
\]

O tipo alto de \(H\) exige sua continuação descontada,

\[
h_P=\beta\alpha r.
\]

A proposta pooling em \(R1\) paga

\[
h_P=\beta\alpha r
\]

a \(H\), e

\[
y_P=\frac{\beta g(\mu)}{m}
\]

a cada um dos \(m-1\) weak voters.

A restrição de factibilidade no estado baixo é, portanto,

\[
\boxed{
\beta\alpha r
+
\frac{(m-1)\beta g(\mu)}{m}
\leq 1.
}
\]

Essa é exatamente a restrição \((U1\text{-}F)\). Correta.

O payoff esperado do weak proposer sob pooling é

\[
P(\mu)
=
V_e(\mu)
-
\beta\alpha r
-
\frac{(m-1)\beta g(\mu)}{m}.
\]

O payoff de atraso sem informação é

\[
R(\mu)=\frac{\beta g(\mu)}{m}.
\]

Portanto, pooling é escolhido quando é factível e

\[
P(\mu)\geq R(\mu).
\]

Isto equivale a

\[
V_e(\mu)
-
\beta\alpha r
-
\frac{(m-1)\beta g(\mu)}{m}
\geq
\frac{\beta g(\mu)}{m},
\]

ou seja,

\[
\boxed{
V_e(\mu)-\beta\alpha r\geq \beta g(\mu).
}
\]

Correto.

---

# 6. Colapso do ramo low-accepted/high-rejected

O pacote afirma que, com \(\pi_H=0\) também em \(R2\), o ramo estrito em que o tipo baixo aceita e o tipo alto rejeita colapsa em empate sob tie-breaking de aceitação.

Essa afirmação está correta, mas a prova precisa ser escrita cuidadosamente.

Considere uma proposta de \(R1\) com pagamento \(h\) a \(H\), pretendendo induzir:

\[
L \text{ aceita},\qquad H \text{ rejeita}.
\]

Se o tipo alto rejeita em equilíbrio, então a rejeição de \(H\) revela o tipo alto por Bayes, para \(\mu\in(0,1)\). Em \(R2\), com posterior degenerado no tipo alto, o weak proposer precisa pagar

\[
\alpha r
\]

a \(H\). Logo, o tipo alto recebe ao rejeitar em \(R1\):

\[
\beta\alpha r.
\]

Para o tipo alto rejeitar estritamente, seria necessário

\[
h<\beta\alpha r.
\]

Mas se o tipo baixo desvia e rejeita, a história observada também é uma rejeição de \(H\). Dado que, no suposto equilíbrio separador, rejeição é atribuída ao tipo alto, o tipo baixo também obtém em \(R2\) uma oferta de

\[
\alpha r,
\]

e portanto recebe

\[
\beta\alpha r.
\]

Para o tipo baixo aceitar, seria necessário

\[
h\geq \beta\alpha r.
\]

As duas restrições são incompatíveis:

\[
h\geq\beta\alpha r
\quad\text{and}\quad
h<\beta\alpha r.
\]

No ponto

\[
h=\beta\alpha r,
\]

o tipo alto fica indiferente. Como a regra mantida é aceitação na indiferença, o tipo alto aceita. Portanto, o ramo separador estrito desaparece.

Esse argumento é bom. Mas ele depende de uma coisa: **a rejeição de \(H\) precisa ser observada**. Se a proposta falha antes do voto de \(H\), por rejeição de um weak voter, então a ação de \(H\) não revela tipo. Esse é exatamente o ponto que o pacote lista como questão externa. Para o paper, você precisa fixar o protocolo.

---

# 7. O problema do atraso sem informação

Este é o ponto mais vulnerável como PBE.

O pacote usa

\[
R(\mu)=\frac{\beta g(\mu)}{m}
\]

como payoff de atraso sem informação. Para isso ser um payoff de equilíbrio, a história que leva de \(R1\) a \(R2\) precisa preservar o posterior

\[
\mu.
\]

Há três maneiras limpas de fazer isso.

Primeira: permitir explicitamente uma ação de agenda setter “no proposal” ou “delay”. Então não há voto de \(H\), não há sinal, e o posterior permanece \(\mu\).

Segunda: fixar uma ordem de votação em que algum weak voter vota antes de \(H\), e o proposer pode fazer uma proposta que esse weak voter rejeita com probabilidade 1. Como a história termina antes da ação de \(H\), não há informação sobre \(\theta\).

Terceira: permitir uma proposta que ambos os tipos de \(H\) rejeitam ou aceitam da mesma maneira, de modo que a ação de \(H\) não revele tipo. Mas essa opção é mais frágil, porque precisa ser checada contra desvios.

A versão mais limpa para o paper é a primeira: inclua no jogo uma ação formal de atraso. Algo como:

\[
a_t\in\{\text{propose }x,\ \text{delay}\}.
\]

Se o proposer escolhe delay em \(R1\), o jogo segue para \(R2\) com o mesmo posterior \(\mu\), e todos os payoffs são descontados por \(\beta\).

Sem isso, um revisor pode perguntar: “Qual história de falha gera exatamente \(R(\mu)\)? Quais crenças são impostas por Bayes? A ação de \(H\) foi observada?” Essa objeção é séria.

---

# 8. Payoff de \(H\) e timing da outside option

O pagamento

\[
h_P=\beta\alpha r
\]

em \(R1\) pressupõe que, se \(H\) rejeita em \(R1\), ele não recebe imediatamente sua outside option \(\alpha V(\theta)\). Em vez disso, ele vai para \(R2\), e sua continuação é descontada.

Isso precisa estar explícito.

Se a outside option de \(H\) fosse uma exit option imediatamente disponível após qualquer rejeição, o tipo alto exigiria

\[
\alpha r,
\]

não

\[
\beta\alpha r.
\]

Nesse caso, o pagamento pooling de \(R1\) seria maior, e várias condições mudariam.

Portanto, a timing assumption correta é:

\[
\text{Rejection in } R1 \text{ leads to } R2; outside payoffs are terminal, not immediate at } R1.
\]

Ou, se a outside option é disponível imediatamente, então o modelo atual está errado. Pelo pacote, parece claro que você pretende a primeira interpretação, mas ela precisa ser escrita nos primitivos.

---

# 9. Hegemonic rent / payoff premium

O pacote afirma que, sob pooling aceito em unanimidade,

\[
V_H^{U,P}(\mu)=\beta\alpha r.
\]

Relativo à outside option esperada,

\[
\alpha V_e(\mu)=\alpha[1+\mu(r-1)],
\]

o prêmio é

\[
\Delta_H^P(\mu)
=
\beta\alpha r-\alpha V_e(\mu).
\]

Logo,

\[
\Delta_H^P(\mu)
=
\alpha\{\beta r-1-\mu(r-1)\}.
\]

Correto.

Para \(\alpha>0\), o prêmio é positivo quando

\[
\beta r-1-\mu(r-1)>0,
\]

isto é,

\[
\boxed{
\mu<\frac{\beta r-1}{r-1}.
}
\]

Isso só é não-vazio se

\[
\beta r>1.
\]

Como \(\beta<1\), o cutoff é sempre menor ou igual a 1:

\[
\frac{\beta r-1}{r-1}\leq 1
\iff
\beta r-1\leq r-1
\iff
\beta\leq 1.
\]

Portanto, a condição está correta.

Mas eu evitaria chamar isso simplesmente de “informational rent”. O termo mais defensável é:

\[
\textit{ex ante pooling premium relative to H's expected outside option.}
\]

Se quiser usar “rent”, use algo mais estreito:

> “an ex ante pooling premium induced by unanimity and type-dependent outside options.”

Isso evita a crítica de que informação privada sozinha não gera renda no seu próprio stress test \(\alpha=0\).

---

# 10. Stress test \(\alpha=0\)

Com

\[
\alpha=0,
\]

temos

\[
d_H(0)=d_H(1)=0.
\]

Em \(R2\),

\[
g(\mu)=\max\{1-\mu,V_e(\mu)\}.
\]

Como

\[
V_e(\mu)=1+\mu(r-1)\geq 1\geq 1-\mu,
\]

segue que

\[
g(\mu)=V_e(\mu).
\]

O pagamento pooling a \(H\) é

\[
h_P=\beta\alpha r=0.
\]

Logo,

\[
\Delta_H(\theta,\mu)=0.
\]

Esse stress test está correto.

Mas a interpretação deve ser calibrada:

> In this baseline, with weak agenda control and acceptance in indifference, pivotality plus private information does not force a positive hegemonic rent when \(H\)'s outside option is not type-dependent.

Eu não diria “pivotality and private information alone do not generate rent” sem a cláusula “in this baseline”, porque isso soa como uma proposição geral demais.

---

# 11. Entry and nesting

O pacote afirma que, no ramo majority-pass,

\[
V_W^U(\mu)\leq V_W^M(\mu),
\]

e portanto

\[
F_U\cap\mathcal{P}_M^F\subseteq F_M^{pass}.
\]

A desigualdade está correta, mas você precisa definir \(V_W^U(\mu)\) explicitamente como payoff weak representativo ex ante.

Sob pooling em \(R1\), a soma dos payoffs dos weak states é

\[
V_e(\mu)-\beta\alpha r.
\]

Logo, o payoff weak representativo é

\[
V_W^{U,P}(\mu)
=
\frac{V_e(\mu)-\beta\alpha r}{m}.
\]

Então

\[
V_W^M(\mu)-V_W^{U,P}(\mu)
=
\frac{V_e(\mu)}{m}
-
\frac{V_e(\mu)-\beta\alpha r}{m}
=
\frac{\beta\alpha r}{m}
\geq 0.
\]

Sob atraso,

\[
V_W^{U,D}(\mu)=\frac{\beta g(\mu)}{m}.
\]

Como, sob \(\alpha\geq0\),

\[
g(\mu)\leq V_e(\mu),
\]

temos

\[
V_W^{U,D}(\mu)
=
\frac{\beta g(\mu)}{m}
\leq
\frac{\beta V_e(\mu)}{m}
<
\frac{V_e(\mu)}{m}
=
V_W^M(\mu).
\]

Logo, o nesting está correto.

Mas há uma ressalva institucional importante: isso vale para uma noção de entrada coletiva ou ex ante, antes da realização da posição de proposer/voter. Se a entrada exigir participação individual ex post, a maioria é problemática, porque weak states não selecionados na coalizão vencedora recebem zero. Então a formação set \(F_M^{pass}\) pode mudar.

Você já lista essa preocupação no pacote; eu a transformaria em hipótese formal, não em caveat.

Escreva algo como:

\[
\text{Entry is collective and evaluated by the ex ante representative weak-state payoff.}
\]

Se a entrada for individual e interim, será outro modelo.

---

# 12. Calibração OPEC

Parâmetros:

\[
N=13,\qquad m=12,\qquad q=7,
\]

\[
r=1.5,\qquad \alpha=0.19,\qquad \beta=0.9.
\]

## Cutoff de \(R2\)

\[
\mu_2^*
=
\frac{\alpha(r-1)}{r-\alpha}
=
\frac{0.19(0.5)}{1.5-0.19}
=
\frac{0.095}{1.31}
=
0.072519.
\]

Correto.

## Majority pass global

\[
\frac{\beta(q-1)r}{m}
=
\frac{0.9\cdot6\cdot1.5}{12}
=
0.675<1.
\]

Logo,

\[
\mathcal{P}_M^F=[0,1].
\]

Correto.

## Feasibilidade de pooling em \(R1\)

Primeiro,

\[
\beta\alpha r
=
0.9\cdot0.19\cdot1.5
=
0.2565.
\]

No ramo alto de \(R2\),

\[
g(\mu)
=
V_e(\mu)-\alpha r
=
1+0.5\mu-0.285
=
0.715+0.5\mu.
\]

A restrição \((U1\text{-}F)\) vira

\[
0.2565+\frac{11}{12}0.9(0.715+0.5\mu)\leq1.
\]

Isto é,

\[
0.846375+0.4125\mu\leq1.
\]

Logo,

\[
\mu\leq
\frac{1-0.846375}{0.4125}
=
0.372424.
\]

Correto.

No ramo baixo,

\[
g(\mu)=0.81(1-\mu),
\]

e a restrição é mais frouxa; em \(\mu=0\),

\[
0.2565+\frac{11}{12}0.9(0.81)
=
0.92475<1.
\]

Logo, não há problema de factibilidade antes de \(\mu_2^*\).

## Condição de escolha de pooling

A condição é

\[
V_e(\mu)-\beta\alpha r\geq \beta g(\mu).
\]

No ramo baixo:

\[
V_e(\mu)-\beta\alpha r-\beta g(\mu)
=
1+0.5\mu-0.2565-0.9\cdot0.81(1-\mu)
\]

\[
=
0.0145+1.229\mu>0.
\]

No ramo alto:

\[
V_e(\mu)-\beta\alpha r-\beta[V_e(\mu)-\alpha r]
=
(1-\beta)V_e(\mu)
=
0.1V_e(\mu)>0.
\]

Logo, pooling é escolhido sempre que é factível. Correto.

## Payoff de \(H\) sob unanimidade

Para

\[
\mu\leq0.372424,
\]

há pooling aceito em \(R1\), então

\[
V_H^U(\mu)=\beta\alpha r=0.2565.
\]

Para

\[
\mu>0.372424,
\]

há atraso. Como

\[
0.372424>\mu_2^*=0.072519,
\]

o jogo de \(R2\) está no ramo pooling, e \(H\) recebe novamente

\[
\beta\alpha r=0.2565.
\]

Logo,

\[
\boxed{
V_H^U(\mu)=0.2565
\quad\forall\mu\in[0,1].
}
\]

Correto.

## Comparação com maioria

Sob maioria,

\[
V_H^M(\mu)=\alpha V_e(\mu)
=
0.19(1+0.5\mu).
\]

Então

\[
D_H(\mu)
=
0.2565-0.19(1+0.5\mu).
\]

Unanimidade é estritamente melhor para \(H\) quando

\[
0.2565>0.19+0.095\mu.
\]

Logo,

\[
0.0665>0.095\mu,
\]

\[
\mu<0.7.
\]

Correto.

No ponto

\[
\mu=0.7,
\]

\(H\) é indiferente. Para

\[
\mu>0.7,
\]

maioria é estritamente melhor.

## Gap mínimo de nesting

No ramo pooling,

\[
V_W^M(\mu)-V_W^{U,P}(\mu)
=
\frac{\beta\alpha r}{m}
=
\frac{0.2565}{12}
=
0.021375.
\]

Esse é o gap mínimo reportado. Correto.

---

# 13. Classificação institucional

A classificação substantiva precisa ser mantida estreita.

Para a calibração OPEC, como

\[
\mathcal{P}_M^F=[0,1],
\]

a comparação majority/unanimity pode ser feita em todo o intervalo \([0,1]\), mas apenas condicionalmente às instituições relevantes formarem.

A classificação correta é:

\[
\mu\in F_U,\ \mu<0.7
\Rightarrow
H \text{ prefere unanimidade};
\]

\[
\mu\in F_U,\ \mu=0.7
\Rightarrow
H \text{ é indiferente};
\]

\[
\mu\in F_U,\ \mu>0.7
\Rightarrow
H \text{ prefere maioria};
\]

\[
\mu\in F_M^{pass}\setminus F_U
\Rightarrow
\text{unanimidade não forma; maioria pode formar; }H
\text{ recebe sua outside option sob maioria.}
\]

A última linha precisa ser escrita com cuidado. Não é exatamente que \(H\) “chooses majority” por preferência substantiva; é que unanimidade não é disponível, e maioria não reduz o payoff de \(H\) relativamente a ficar fora, porque

\[
V_H^M(\mu)=\alpha V_e(\mu).
\]

Então a frase “payoff indifferent absent a formation tie-break” está correta.

---

# 14. Pontos que eu exigiria antes de submeter

Eu faria cinco mudanças formais antes de enviar a versão AJPS.

Primeiro, declarar domínio:

\[
\alpha\in[0,1/r].
\]

Ou então rederivar \(R2\) para \(\alpha r>1\).

Segundo, declarar que contratos não são estado-contingentes:

\[
h \text{ is not contractible on } \theta.
\]

Terceiro, formalizar o atraso sem informação como ação primitiva do proposer:

\[
a_t\in\{\text{propose},\text{delay}\}.
\]

Quarto, declarar o timing da outside option:

\[
R1 \text{ rejection leads to discounted continuation; }H
\text{ does not take }d_H(\theta)\text{ immediately in }R1.
\]

Quinto, definir \(V_W^U\) e \(V_W^M\) como payoffs representativos ex ante usados para entrada coletiva. Caso contrário, a nesting proposition é vulnerável.

---

# 15. Linguagem recomendada para o paper

Eu evitaria:

> “Unanimity gives the hegemon an informational rent.”

Eu usaria:

> “Under unanimity, pivotality forces weak proposers to pool on the high-type continuation payment. This generates an ex ante payoff premium for the hegemon relative to its expected outside option when \(\mu<(\beta r-1)/(r-1)\). The premium depends on the type-dependent outside option; private information alone does not generate a positive premium in the \(\alpha=0\) stress test.”

Essa formulação é muito mais defensável.

---

## Conclusão

A matemática interna da baseline está majoritariamente correta. A calibração OPEC confere. O resultado substantivo também é mais forte do que parece: mesmo com agenda totalmente empilhada contra \(H\), unanimidade pode beneficiar \(H\) por causa da combinação entre pivotalidade, pooling e outside option tipo-dependente.

Mas eu não chamaria a arquitetura de “verified without reservations”. A versão atual ainda depende de hipóteses implícitas. Para um paper na AJPS, eu transformaria essas hipóteses em primitivas formais e reescreveria os resultados como proposições condicionais ao domínio:

\[
\mu\in[0,1],\quad r>1,\quad \beta\in(0,1),\quad \alpha\in[0,1/r],
\]

com contratos não estado-contingentes, atraso sem informação bem definido, e entrada coletiva ex ante. Nesse domínio, os resultados do pacote passam. Fora dele, algumas proposições não estão demonstradas ou são falsas.
