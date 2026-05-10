# O paper sobrevive às correções? Avaliação formal

**Versão revisada após a correção da contabilidade da outside option de \(H\).**

A resposta curta é: **sim, o núcleo do paper sobrevive**, mas não exatamente na forma atual. Com a outside option de \(H\) tratada como **externa** quando \(H\) é excluído sob maioria, o mecanismo fica mais limpo:

- maioria continua sem screening;
- unanimidade continua gerando screening;
- a dominância condicional de unanimidade para o hegemon sobrevive;
- o limiar \(\alpha^*\) muda e fica mais favorável à unanimidade;
- a classificação institucional sobrevive com uma condição adicional;
- a calibração e a Figura 3 precisam ser recalculadas.

O que não sobrevive sem qualificação é a versão atual das fórmulas de maioria, a estatica comparativa em \(\alpha\), a prova de \(\mathcal F_U\subseteq \mathcal F_M\) tal como escrita, e parte da interpretação da entrada.

---

## 1. Interpretação corrigida da outside option

A correção parte da seguinte interpretação:

> Quando um weak proposer exclui \(H\) sob maioria, \(H\) recebe \(\alpha V(\theta)\) por meio de uma outside option externa. Esse payoff **não sai** do bolo institucional apropriado pela coalizão de weak states.

Logo, do ponto de vista de um proponente fraco, excluir \(H\) é gratuito. Isso salva a intuição da Proposition 1: sob maioria, weak proposers excluem \(H\), e a informação privada de \(H\) não gera screening.

Mas essa interpretação exige corrigir as fórmulas de maioria. Em particular, o payoff de continuação de R2 de um weak state sob maioria deve ser

\[
V_W^{R2}(\mu,M)=\frac{V_e(\mu)}{N},
\]

não

\[
\frac{(1-\alpha)V_e(\mu)}{N}.
\]

O termo \((1-\alpha)\) só apareceria se a outside option de \(H\) fosse retirada do bolo da coalizão fraca. Sob a interpretação externa, esse fator deve sair.

---

## 2. Proposition 1: sobrevive, mas a prova deve ser reescrita

A proposição qualitativa sobrevive:

\[
\text{majority} \Rightarrow \text{weak proposers exclude }H \Rightarrow \text{no screening}.
\]

A prova correta deve comparar exclusão com inclusão de \(H\) usando a contabilidade externa.

### 2.1 Exclusão de \(H\)

Quando um weak proposer exclui \(H\), compra \(q-1\) votos fracos, cada um ao custo de continuação

\[
\beta V_W^{R2}(\mu,M)=\beta\frac{V_e(\mu)}{N}.
\]

O payoff esperado do proponente é

\[
\Pi_E
=
V_e(\mu)-(q-1)\beta\frac{V_e(\mu)}{N}.
\]

### 2.2 Inclusão conservadora de \(H\)

Se o weak proposer inclui \(H\) e quer que ambos os tipos aceitem, deve pagar a continuação do tipo alto:

\[
\beta V_H^{R2}(\theta=1,M)
=
\beta\frac{r[1+(N-1)\alpha]}{N}.
\]

Como \(H\) substitui um voto fraco na coalizão, o proponente precisa comprar apenas \(q-2\) votos fracos adicionais. O payoff é

\[
\Pi_C
=
V_e(\mu)
-
\beta\frac{r[1+(N-1)\alpha]}{N}
-
(q-2)\beta\frac{V_e(\mu)}{N}.
\]

Logo,

\[
\Pi_C-\Pi_E
=
-rac{\beta}{N}
\left[r[1+(N-1)\alpha]-V_e(\mu)\right]<0,
\]

pois \(V_e(\mu)\le r\) e \(\alpha>0\). Portanto, a inclusão conservadora é estritamente dominada pela exclusão.

### 2.3 Inclusão agressiva de \(H\)

Se o weak proposer oferece a \(H\) apenas a continuação do tipo baixo, o tipo baixo aceita e o tipo alto rejeita. O payoff relativo à exclusão é

\[
\Pi_A-
\Pi_E
=
-
\mu r
+
\frac{\beta}{N}
\left\{
-(1-\mu)[1+(N-1)\alpha]
+
[1+\mu(q-2)]V_e(\mu)
+
\mu r
\right\}.
\]

Como o termo em \(\alpha\) reduz o payoff de inclusão,

\[
\Pi_A-
\Pi_E
<
-
\mu r
+
\frac{\beta\mu}{N}
\left[
q+2r-2+\mu(q-2)(r-1)
\right].
\]

Como

\[
q+2r-2+\mu(q-2)(r-1)\le qr,
\]

temos

\[
\Pi_A-
\Pi_E
<
-
\mu r+rac{\beta\mu qr}{N}<0
\]

para \(\mu>0\), pois \(q\le N\) e \(\beta<1\). Para \(\mu=0\),

\[
\Pi_A-
\Pi_E
=
-
\frac{\beta(N-1)\alpha}{N}<0.
\]

Portanto, a inclusão agressiva também é dominada. Assim, sob maioria, weak proposers excluem \(H\) em todos os estados de crença. Não há screening.

---

## 3. Fórmulas corrigidas sob maioria

Com outside option externa, os valores de R2 sob maioria são:

\[
V_H^{R2}(\theta,M)
=
\frac{1+(N-1)\alpha}{N}V(\theta),
\]

\[
V_W^{R2}(\mu,M)
=
\frac{V_e(\mu)}{N}.
\]

O payoff esperado de R1 do hegemon sob maioria passa a ser

\[
E[V_H^{R1}(\mu,M)]
=
\lambda_M^E V_e(\mu),
\]

com

\[
\lambda_M^E
=
\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}.
\]

O sobrescrito \(E\) indica outside option externa.

A fórmula atual do paper é

\[
\lambda_M
=
\frac{N[1+(N-1)\alpha]-\beta(q-1)(1-\alpha)}{N^2}.
\]

Essa fórmula é inconsistente com a interpretação externa, porque trata a outside option de \(H\) como se reduzisse o bolo disponível para os weak states.

---

## 4. Payoff dos weak states sob maioria

O payoff de R1 de cada weak state sob maioria deve ser

\[
V_W^{R1}(\mu,M)
=
\kappa_M^E V_e(\mu),
\]

com

\[
\kappa_M^E
=
\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\]

A fórmula atual do paper tem o fator \((1-\alpha)\):

\[
\kappa_M
=
(1-\alpha)
\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
\]

Esse fator deve ser removido.

Consequência importante:

\[
V_W^{R1}(\mu,M)
\]

não depende mais de \(\alpha\). Portanto, a formação sob maioria também não depende mais de \(\alpha\). A estática comparativa em \(\alpha\) deve ser reescrita.

---

## 5. Implicação para a calibração

Na calibração do paper,

\[
N=13,\quad q=7,\quad \beta=0.9.
\]

Então

\[
\kappa_M^E
=
\frac{13\cdot 12+0.9\cdot 6}{13^2\cdot 12}
\approx 0.0796.
\]

Com \(c=0.07\), como \(V_e(p)\ge 1\), maioria sustenta entrada para todo \(p\in(0,1]\):

\[
\mathcal F_M=(0,1].
\]

Logo, o resultado reportado no paper,

\[
\mathcal F_M\approx[0.17,1],
\]

não sobrevive à correção. A Figura 3 deve ser recalculada. A região “majority dominates through entry” provavelmente se expande, porque maioria passa a formar em mais priors.

Isso não derruba o argumento central. Pelo contrário, deixa o tradeoff mais claro:

> unanimity extracts more; majority forms more easily.

---

## 6. Proposition 2: sobrevive, mas a branch da calibração deve ser corrigida

O mecanismo de cutoff sob unanimidade sobrevive. Continua havendo um cutoff \(\mu_s^{R1}\) tal que weak proposers fazem oferta agressiva abaixo dele e conservadora acima dele.

A fórmula fechada independente de \(\alpha\),

\[
\mu_s^{R1}
=
\frac{\phi-\sqrt{\phi^2-4(N-2)}}{2(N-2)},
\]

só vale quando

\[
\alpha<\bar\alpha(r,\beta,N).
\]

Na calibração,

\[
N=13,\quad r=1.5,\quad \beta=0.9,
\]

tem-se aproximadamente

\[
\bar\alpha\approx 0.170.
\]

Mas o paper usa

\[
\alpha=0.19.
\]

Logo, a calibração está na branch em que o cutoff depende de \(\alpha\). O cutoff numérico muda pouco — aproximadamente de \(0.0640\) para \(0.0649\) —, mas formalmente a demonstração e as figuras devem usar a branch correta.

Esse é um erro de implementação formal, não um problema substantivo do mecanismo.

---

## 7. Proposition 3: sobrevive como resultado sobre limites laterais

A ideia do salto de payoff sobrevive. O tamanho do salto é

\[
\Delta_H
=
(1-\mu_s^{R1})
\frac{(N-1)\beta(r-1)}{N^2}.
\]

Mas, no ponto exato \(\mu_s^{R1}\), o weak proposer está indiferente entre oferta agressiva e oferta conservadora. Sem uma regra de desempate para os weak proposers, o valor do payoff de \(H\) no ponto não é único.

A formulação correta é em termos de limites laterais:

\[
\lim_{\mu\downarrow \mu_s^{R1}}V_H^U(\mu)
-
\lim_{\mu\uparrow \mu_s^{R1}}V_H^U(\mu)
=
(1-\mu_s^{R1})
\frac{(N-1)\beta(r-1)}{N^2}.
\]

Essa é uma correção de precisão, não de substância.

---

## 8. Theorem 1: sobrevive com novo \(\alpha^*\)

Este é o ponto mais importante. O Theorem 1 sobrevive, mas o limiar muda.

A fórmula atual do paper é

\[
\alpha^*
=
\frac{\beta(q-1)}
{N(N-1)-\beta(N^2-N-q+1)}.
\]

Como

\[
N^2-N-q+1=N(N-1)-(q-1),
\]

isso equivale a

\[
\alpha^*
=
\frac{\beta(q-1)}
{N(N-1)(1-\beta)+\beta(q-1)}.
\]

Com outside option externa, o limiar correto é

\[
\alpha_E^*
=
\frac{\beta(q-1)}
{N(N-1)(1-\beta)}.
\]

Se \(\alpha_E^*>1/r\), então a dominância condicional de unanimidade vale para todo \(\alpha\) admissível.

### 8.1 Decomposição corrigida para a prova

Defina

\[
B\equiv \beta(q-1),
\qquad
C\equiv N(N-1)\alpha.
\]

Com majority corrigida, a diferença de payoff condicional é

\[
D_E(\mu)
\equiv
E[V_H^{R1}(\mu,U)]-E[V_H^{R1}(\mu,M)].
\]

A decomposição análoga à do apêndice fica

\[
D_E(\mu)
=
D^E_{base}(\mu)
+
\mathbf 1\{\mu<\mu_s^{R2}\}\delta_{R2}(\mu)
+
\mathbf 1\{\mu>\mu_s^{R1}\}\delta_{R1}(\mu),
\]

onde

\[
D^E_{base}(\mu)
=
\frac{(B-C)V_e(\mu)+C\beta r}{N^2},
\]

\[
\delta_{R2}(\mu)
=
\frac{(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]}{N^2},
\]

\[
\delta_{R1}(\mu)
=
\frac{(N-1)\beta(r-1)(1-\mu)}{N^2}.
\]

Os termos de screening sob unanimidade não mudam. O que muda é o termo de majority, isto é, \(B\) deixa de carregar \((1-\alpha)\).

### 8.2 Endpoint que pinça o limiar

No endpoint \(\mu=1\), os termos de screening desaparecem. A diferença é

\[
D_E(1)
=
\frac{r}{N^2}
\left[
\beta(q-1)-N(N-1)\alpha(1-\beta)
\right].
\]

Logo,

\[
D_E(1)>0
\quad\Longleftrightarrow\quad
\alpha<\alpha_E^*.
\]

Esse endpoint continua sendo o caso crítico.

### 8.3 Checagem do endpoint baixo

No ramo de baixa crença, o endpoint relevante é

\[
D_I^E(0)
=
D^E_{base}(0)+\delta_{R2}(0).
\]

Substituindo,

\[
D_I^E(0)
=
\frac{
\beta(q-1)
+
\alpha(N-1)[\beta r(N-1)-(N-\beta)]
}{N^2}.
\]

Se o termo entre colchetes for positivo, o resultado é imediato. Se for negativo, a raiz que faria \(D_I^E(0)=0\) fica acima de \(\alpha_E^*\), porque

\[
1+r(N-1)>N
\]

para \(r>1\). Portanto, \(\alpha<\alpha_E^*\) também garante positividade no endpoint baixo. Como os ramos são afins, a prova por endpoints continua funcionando.

### 8.4 Valor na calibração

Na calibração,

\[
N=13,\quad q=7,\quad \beta=0.9.
\]

Então

\[
\alpha_E^*
=
\frac{0.9\cdot 6}{13\cdot 12\cdot 0.1}
\approx 0.346.
\]

Como o paper usa

\[
\alpha=0.19,
\]

a condição continua satisfeita com folga. Portanto, o resultado de dominância condicional de unanimidade sobrevive na calibração.

---

## 9. Caso \(\alpha\ge \alpha_E^*\)

Quando \(\alpha\ge \alpha_E^*\), a dominância condicional global de unanimidade falha perto de \(\mu=1\), onde há pouca incerteza e o custo de comprar unanimidade domina.

No ramo conservador, a diferença pode ser escrita como

\[
D_E(\mu)=D_E(1)+(1-\mu)\Gamma_E,
\]

com

\[
\Gamma_E
=
\frac{(r-1)[N(N-1)\alpha-\beta(q-1)+(N-1)\beta]}{N^2}.
\]

Como

\[
N(N-1)\alpha-\beta(q-1)+(N-1)\beta
=
N(N-1)\alpha+eta(N-q)>0,
\]

\(\Gamma_E>0\). Logo, mesmo quando majority domina perto de \(\mu=1\), unanimity pode voltar a dominar para crenças mais incertas.

O threshold de crença no ramo conservador seria

\[
\bar\mu_E
=
1-
\frac{-D_E(1)}{\Gamma_E},
\]

quando \(D_E(1)<0\). A Figura 4 e o Remark 1 devem ser recalculados com essa versão corrigida.

---

## 10. Proposition 4: sobrevive com uma condição adicional

A Proposition 4 precisa de uma condição extra.

Com majority corrigida,

\[
\lambda_M^E
=
\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}.
\]

Quando only majority sustains entry, o hegemon compara majority com a outside option. Majority é melhor somente se

\[
\lambda_M^E>\alpha.
\]

Isso equivale a

\[
\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}>\alpha,
\]

isto é,

\[
N(1-
\alpha)-\beta(q-1)>0.
\]

Logo,

\[
\alpha<\bar\alpha_M^E
\equiv
1-
\frac{\beta(q-1)}{N}.
\]

A versão corrigida da Proposition 4 deve assumir

\[
\alpha<\min\{\alpha_E^*,\bar\alpha_M^E\}.
\]

Sob essa condição:

\[
U\succ M
\quad\text{se }p\in\mathcal F_U,
\]

\[
M\succ U
\quad\text{se }p\in\mathcal F_M\setminus\mathcal F_U,
\]

\[
U\sim M
\quad\text{se }p\notin\mathcal F_M.
\]

Na calibração,

\[
\bar\alpha_M^E
=
1-
\frac{0.9\cdot 6}{13}
\approx 0.585.
\]

Como \(\alpha=0.19\), essa condição também é satisfeita.

---

## 11. A inclusão \(\mathcal F_U\subseteq\mathcal F_M\) ainda sobrevive

A prova atual do paper usa budget balance sob maioria. Com outside option externa, essa identidade orçamentária não vale mais, porque \(H\) recebe um payoff externo quando é excluído. Portanto, a prova deve ser substituída.

A nova prova é simples.

Sob unanimidade,

\[
E[V_H^U(\mu)]+(N-1)V_W^U(\mu)\le V_e(\mu),
\]

com desigualdade no ramo agressivo por causa da destruição de surplus via atraso.

Pelo Theorem 1 corrigido,

\[
E[V_H^U(\mu)]>E[V_H^M(\mu)]=\lambda_M^E V_e(\mu).
\]

Logo,

\[
V_W^U(\mu)
<
\frac{(1-
\lambda_M^E)V_e(\mu)}{N-1}.
\]

Mas

\[
\frac{1-
\lambda_M^E}{N-1}
=
\frac{N(N-1)(1-
\alpha)+\beta(q-1)}{N^2(N-1)}
<
\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}
=
\kappa_M^E.
\]

Portanto,

\[
V_W^U(\mu)<V_W^M(\mu),
\]

sob as condições do Theorem 1 corrigido. Assim,

\[
\mathcal F_U\subseteq\mathcal F_M.
\]

A conclusão sobre a inclusão dos formation sets sobrevive, mas a prova deve ser refeita.

---

## 12. A Figura 3 muda, mas a mensagem central não

Com as correções:

\[
\mathcal F_U\subseteq\mathcal F_M
\]

continua valendo, sob as condições acima.

Unanimity continua dando mais ao hegemon quando ambos os regimes formam. Majority continua tendo vantagem no canal de entrada.

Mas a geometria muda. Como \(\mathcal F_M\) aumenta sob a correção, a região “majority dominates through entry” deve se expandir.

Na calibração com \(c=0.07\), o resultado provável é:

\[
\mathcal F_M=(0,1],
\]

enquanto \(\mathcal F_U\) permanece uma região acima de algum threshold, possivelmente com a descontinuidade já discutida ao redor de \(\mu_s^{R1}\).

Assim, majority domina para priors baixos porque unanimity não forma; unanimity domina para priors altos porque forma e dá maior payoff ao hegemon.

---

## 13. Estática comparativa: o que sobrevive e o que muda

### 13.1 \(\beta\)

A estática em \(\beta\) sobrevive e fica ainda mais transparente:

\[
\alpha_E^*
=
\frac{\beta(q-1)}{N(N-1)(1-\beta)}
\]

é crescente em \(\beta\). Quanto mais pacientes os atores, maior a região de parâmetros em que unanimity domina condicionalmente.

### 13.2 \(N\)

Para maioria simples, \(q-1\approx N/2\). Logo,

\[
\alpha_E^*
\approx
\frac{\beta}{2(1-\beta)N}.
\]

Assim, a dominância condicional global de unanimity fica mais difícil em organizações maiores. O salto de screening também tem o fator

\[
\frac{N-1}{N^2},
\]

que cai com \(N\) para \(N\ge 2\).

### 13.3 \(c\)

Aumentar \(c\) contrai os formation sets. Como unanimity deixa menos surplus para os weak states, \(\mathcal F_U\) é o conjunto mais vulnerável. Majority mantém a vantagem de viabilidade.

### 13.4 \(\alpha\)

Esta é a principal mudança.

Sob a correção externa,

\[
V_W^{R1}(\mu,M)=\kappa_M^E V_e(\mu)
\]

não depende de \(\alpha\). Portanto, \(\mathcal F_M\) não se contrai quando \(\alpha\) aumenta.

Já sob unanimity, os weak states precisam pagar mais a \(H\), então \(\mathcal F_U\) se contrai com \(\alpha\).

A frase correta é:

> Increasing \(\alpha\) expands the majority-only region by shrinking unanimity formation, not by shrinking majority formation.

### 13.5 \(r\)

A intuição de que maior dispersão de tipos aumenta a renda informacional sobrevive. O salto contém o termo

\[
(r-1),
\]

mas também depende de \(\mu_s^{R1}\). Portanto, a frase forte “o salto é globalmente crescente em \(r\)” deve ser demonstrada formalmente, não apenas inferida da fórmula. Uma formulação segura é:

> Holding the cutoff fixed, the screening jump increases with \(r\); globally, the comparative static in \(r\) should be verified using the cutoff expression.

---

## 14. A ameaça mais séria: viabilidade ex post das ofertas

A maior questão remanescente não é majority; é a viabilidade das ofertas sob unanimity.

Se o modelo exige que toda proposta seja uma divisão factível do payoff realizado \(V(\theta)\) em cada estado, então algumas ofertas conservadoras sob unanimity podem não ser factíveis no estado baixo.

Para uma oferta conservadora de \(W\) em R1, a condição de factibilidade no estado baixo é

\[
\frac{\beta[r+(N-1)\alpha r]}{N}
+
(N-2)\beta V_W^{R2}(\mu,U)
\le 1.
\]

Na calibração do paper,

\[
N=13,\quad r=1.5,\quad \alpha=0.19,\quad \beta=0.9,
\]

no ramo alto de R2, essa condição vira aproximadamente

\[
0.3406+0.7615(0.715+0.5\mu)\le 1,
\]

isto é,

\[
\mu\lesssim 0.30.
\]

Mas a região de interesse da Figura 3 usa priors bem acima disso. Portanto, se propostas precisam ser factíveis estado a estado, o modelo deve ser refeito com restrições de factibilidade.

Há duas rotas:

1. **Interpretar ofertas como transferências monetárias, claims ou compromissos enforceable não limitados pelo realized low-state pie.** Nesse caso, a matemática do screening pode ser preservada, mas o texto deve parar de sugerir que toda oferta é literalmente uma divisão de \(V(\theta)\) em cada estado.
2. **Manter a interpretação literal de divisão do realized pie.** Nesse caso, os cutoffs e as provas precisam ser re-solvidos com restrições de factibilidade. O mecanismo deve sobreviver, mas os resultados fechados e a calibração atual podem não sobreviver globalmente.

Minha recomendação, se o objetivo é preservar o paper, é escolher explicitamente a primeira rota.

---

## 15. Entrada: multiplicidade e seleção de equilíbrio

Como a entrada dos weak states é simultânea e all-or-nothing, há multiplicidade.

Mesmo quando

\[
V_W^{R1}(p,R)\ge c,
\]

o perfil “ninguém entra” pode ser equilíbrio: se um weak state entra sozinho, paga custo e a instituição não se forma.

Logo, \(\mathcal F_R\) não deve ser chamado simplesmente de “the set where the institution forms” sem uma hipótese de seleção.

A formulação correta é uma das seguintes:

\[
\mathcal F_R
=
\text{set of priors where full-entry equilibrium exists},
\]

ou então o paper deve assumir uma regra de seleção, como:

- payoff-dominant equilibrium selection;
- coordinated entry;
- pre-play communication;
- institutional invitation with collective acceptance.

Isso não mata a Proposition 4, mas muda sua interpretação.

---

## 16. Appendix C: o mecanismo sobrevive, mas as fórmulas de majority mudam

O resultado qualitativo de tipos contínuos sobrevive:

- sob unanimity, weak proposers enfrentam um problema de screening;
- sob majority, weak proposers excluem \(H\);
- a renda de screening é positiva sob unanimity e zero sob majority.

Mas todas as fórmulas de majority no Appendix C devem ser corrigidas.

Em particular, sob outside option externa,

\[
V_W^{R2}(\theta,M)=\frac{\theta}{N},
\]

não

\[
\frac{(1-\alpha)\theta}{N}.
\]

E, quando \(H\) propõe sob majority no caso uniforme,

\[
E[V_H^{R1}(H\text{-prop},M)]
=
\frac{1+r}{2}
\left[1-
\frac{\beta(q-1)}{N}
\right],
\]

não a versão com \((1-\alpha)\) no custo de comprar votos.

O payoff combinado sob majority contínuo passa a ser

\[
E[V_H^{R1}(M)]
=
\frac{(1+r)[N+N(N-1)\alpha-\beta(q-1)]}{2N^2}.
\]

Mantendo as fórmulas de unanimity do apêndice, a diferença no caso uniforme fica

\[
2N^2D_E
=
(N-1)\beta\frac{(\theta_1^*-1)^2}{r-1}
+
(1+r)\beta(q-1)
-
N(N-1)\alpha(1+r-2\beta r).
\]

Portanto, o threshold contínuo também deve ser recalculado. Além disso, a afirmação geral de que

\[
\alpha^*_{cont}\ge \alpha^*
\]

não deve ser apresentada como teorema se estiver baseada apenas em grid search. Pode ficar como resultado numérico ou conjectura.

---

## 17. Veredito

Eu diria que o paper sobrevive, mas deve ser reescrito como uma versão corrigida do modelo.

O pacote formal defensável é:

\[
\text{Proposition 1 survives}
\]

com majority payoff corrigido;

\[
\text{Proposition 2 survives}
\]

com a branch correta do cutoff na calibração;

\[
\text{Proposition 3 survives}
\]

como resultado sobre limites laterais;

\[
\text{Theorem 1 survives}
\]

com

\[
\alpha_E^*
=
\frac{\beta(q-1)}
{N(N-1)(1-\beta)};
\]

\[
\text{Proposition 4 survives}
\]

sob

\[
\alpha<\min\{\alpha_E^*,\bar\alpha_M^E\},
\qquad
\bar\alpha_M^E=1-
\frac{\beta(q-1)}{N},
\]

com hipótese explícita de seleção de entrada.

O achado principal também sobrevive:

> Unanimity is better for the hegemon wherever it can sustain entry; majority’s advantage is broader viability.

A versão mais precisa é:

> Majority’s broader viability becomes stronger once \(H\)’s outside option is treated as external, because weak states under majority no longer lose \((1-\alpha)\) of the pie. At the same time, conditional payoff dominance of unanimity becomes easier, because \(H\)’s majority payoff falls when weak states’ continuation values rise.

Essa tensão é boa para o paper. Ela deixa o tradeoff mais claro:

\[
\boxed{\text{unanimity extracts more; majority forms more easily}.}
\]

---

## 18. Checklist de reescrita

1. Declarar explicitamente que, quando \(H\) é excluído sob majority, \(\alpha V(\theta)\) é uma outside option externa e não sai do bolo institucional.
2. Corrigir \(V_W^{R2}(\mu,M)\), \(\lambda_M\), \(\kappa_M\), \(\mathcal F_M\), e todas as fórmulas de majority no apêndice.
3. Reescrever a prova da Proposition 1 mostrando que inclusão conservadora e agressiva de \(H\) são dominadas pela exclusão.
4. Reescrever o Theorem 1 com \(\alpha_E^*\).
5. Reescrever a prova de \(\mathcal F_U\subseteq \mathcal F_M\), pois a identidade orçamentária sob majority deixa de valer.
6. Adicionar a condição \(\alpha<\bar\alpha_M^E\) à Proposition 4.
7. Corrigir a branch do cutoff \(\mu_s^{R1}\) na calibração.
8. Reformular Proposition 3 em termos de limites laterais ou especificar desempate.
9. Recalcular Example 2, Figure 3 e Figure 4.
10. Decidir explicitamente como tratar viabilidade ex post das ofertas.
11. Adicionar hipótese de seleção no jogo de entrada.
12. Recalcular o Appendix C sob majority externa.
