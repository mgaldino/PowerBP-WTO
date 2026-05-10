# Notas técnicas para reescrita das demonstrações e fórmulas

**Projeto:** *Informational Power Through Pivotality*  
**Objetivo destas notas:** consolidar as correções matemáticas necessárias após fixar a convenção contábil correta: a outside option de `H`, quando `H` é excluído sob maioria, é externa ao bolo proposto por `W`. Isto é, `W` não paga `\alpha V(\theta)` quando exclui `H`.

---

## 0. Convenção contábil adotada

A interpretação correta a ser mantida no modelo deve ser:

\[
\text{se } H \text{ é excluído sob maioria, então } H \text{ recebe } \alpha V(\theta)
\]

por meio de uma outside option externa. Esse payoff **não é subtraído** do excedente multilateral que o proponente fraco divide entre a coalizão vencedora.

Consequência imediata: do ponto de vista de um proponente fraco, excluir `H` sob maioria é gratuito. Portanto, a intuição da Proposição 1 - majority eliminates screening - pode ser mantida. O problema está nas fórmulas de majority atualmente escritas no apêndice, que tratam a outside option de `H` como se reduzisse o bolo disponível aos fracos.

O que deve ser reescrito:

| Objeto | Fórmula atual | Fórmula correta sob outside option externa |
|---|---:|---:|
| `R2` weak value sob majority | `((1-alpha) V_e(mu))/N` | `V_e(mu)/N` |
| `R1` majority, coeficiente de `H` | `lambda_M = [N(1+(N-1)alpha)-beta(q-1)(1-alpha)]/N^2` | `lambda_M^ext = [N(1+(N-1)alpha)-beta(q-1)]/N^2` |
| `R1` majority, coeficiente de `W` | `(1-alpha)[N(N-1)+beta(q-1)]/[N^2(N-1)]` | `[N(N-1)+beta(q-1)]/[N^2(N-1)]` |
| threshold de dominância condicional | `alpha^* = beta(q-1)/[N(N-1)-beta(N^2-N-q+1)]` | `alpha_ext^* = beta(q-1)/[N(N-1)(1-beta)]` |

A unanimity subgame não muda por causa dessa convenção, porque sob unanimidade `H` é sempre incluído e sua outside option aparece como restrição de participação, não como payoff externo simultâneo ao acordo.

---

## 1. Majority rule com outside option externa

Use a notação:

\[
q = \lfloor N/2\rfloor+1, \qquad
V_e(\mu)=1+\mu(r-1), \qquad
A = 1+(N-1)\alpha.
\]

### 1.1 Round 2 sob majority

Se `H` propõe em `R2`, compra `q-1` votos fracos a custo zero e fica com `V(theta)`. Se um fraco propõe, compra `q-1` outros fracos a custo zero, exclui `H`, e fica com o bolo inteiro `V(theta)`. O hegemon recebe `alpha V(theta)` externamente.

Logo:

\[
V_H^{R2}(\theta,M)
= \frac{1}{N}V(\theta)+\frac{N-1}{N}\alpha V(\theta)
=\frac{1+(N-1)\alpha}{N}V(\theta).
\]

Esta fórmula coincide com a atual.

Mas o valor de continuação de um fraco é:

\[
V_W^{R2}(\mu,M)=\frac{V_e(\mu)}{N},
\]

não

\[
\frac{(1-\alpha)V_e(\mu)}{N}.
\]

O fator `(1-alpha)` deve desaparecer porque `W` não paga a outside option de `H`.

### 1.2 Por que um proponente fraco exclui `H`

A prova correta da Proposição 1 deve mostrar que incluir `H` é estritamente dominado por excluí-lo.

#### Exclusão de `H`

Se `W` exclui `H`, compra `q-1` votos fracos a custo `beta V_e(mu)/N` cada um. O payoff esperado do proponente é

\[
\Pi_E
=V_e(\mu)-(q-1)\beta\frac{V_e(\mu)}{N}.
\]

#### Inclusão conservadora de `H`

Se `W` inclui `H` e quer que ambos os tipos de `H` aceitem, precisa pagar ao tipo alto seu valor de continuação:

\[
\beta V_H^{R2}(\theta=1,M)
=\beta\frac{r[1+(N-1)\alpha]}{N}
=\beta\frac{rA}{N}.
\]

Além disso, compra apenas `q-2` votos fracos. Então

\[
\Pi_C
=V_e(\mu)-\beta\frac{rA}{N}-(q-2)\beta\frac{V_e(\mu)}{N}.
\]

Portanto,

\[
\Pi_C-\Pi_E
=\frac{\beta}{N}\big[V_e(\mu)-rA\big]<0,
\]

pois `V_e(mu) <= r` e `A=1+(N-1)alpha>1`.

#### Inclusão agressiva de `H`

Se `W` oferece apenas o valor de continuação do tipo baixo de `H`, o tipo baixo aceita e o tipo alto rejeita. A oferta mínima a `H` é

\[
\beta V_H^{R2}(\theta=0,M)=\beta\frac{A}{N}.
\]

Mesmo usando a precificação mais favorável possível para o proponente - pagando aos `q-2` fracos adicionais apenas sua continuação de baixo estado, `beta/N` -, o payoff de inclusão agressiva é no máximo

\[
\Pi_A
\le
(1-\mu)\left[1-\beta\frac{A}{N}-(q-2)\frac{\beta}{N}\right]
+\mu\frac{\beta r}{N}.
\]

Comparando com exclusão:

\[
\Pi_A-\Pi_E
\le
\frac{-\alpha\beta(N-1)(1-\mu)+\mu r(\beta q-N)}{N}<0,
\]

porque `alpha>0`, `beta<1`, e `q<N` para `N>=3`, logo `beta q<N`.

Assim, tanto a inclusão conservadora quanto a inclusão agressiva de `H` são estritamente dominadas. A coalizão ótima de um fraco sob majority exclui `H` e não há screening.

### 1.3 Payoff de `H` em `R1` sob majority

Quando `H` propõe em `R1`, compra `q-1` votos fracos pagando `beta V_W^{R2}(mu,M)` a cada um:

\[
\Pi_H^{prop}(\theta,\mu,M)
=V(\theta)-(q-1)\beta\frac{V_e(\mu)}{N}.
\]

Quando um fraco propõe, `H` é excluído e recebe `alpha V(theta)` externamente.

Logo:

\[
E_\theta[V_H^{R1}(\theta,\mu,M)]
=\lambda_M^{ext}V_e(\mu),
\]

com

\[
\boxed{
\lambda_M^{ext}
=\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}.
}
\]

A payoff function continua afim em `mu`, então a parte qualitativa da Proposição 1 permanece correta.

### 1.4 Payoff de um fraco em `R1` sob majority

O coeficiente correto do payoff de um fraco é

\[
\boxed{
\kappa_M^{ext}
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}.
}
\]

Portanto:

\[
V_W^{R1}(\mu,M)=\kappa_M^{ext}V_e(\mu).
\]

A formação sob majority passa a ser:

\[
\mathcal F_M^{ext}
=\{\mu\in(0,1]:\kappa_M^{ext}[1+\mu(r-1)]\ge c\}.
\]

Equivalente:

\[
\tau_M^{ext}
=\frac{c/\kappa_M^{ext}-1}{r-1},
\]

com truncagem usual: se `c <= kappa_M^ext`, então majority sustenta entrada para todo `mu`; se `c > r kappa_M^ext`, não sustenta entrada para nenhum `mu`.

---

## 2. Teorema 1 reescrito sob a contabilidade externa

A decomposição da payoff difference pode ser preservada, mas com novo custo de compra de votos sob majority.

Defina:

\[
B\equiv \beta(q-1),
\qquad
C\equiv N(N-1)\alpha.
\]

No apêndice atual, o termo correspondente é `beta(q-1)(1-alpha)`. Sob outside option externa, o fator `(1-alpha)` deve ser removido.

A diferença condicional deve ser escrita como

\[
D^{ext}(\mu)
\equiv
E[V_H^{R1}(\mu,U)]-E[V_H^{R1}(\mu,M)].
\]

A decomposição fica:

\[
D^{ext}(\mu)
= D_{base}^{ext}(\mu)
+\mathbf 1\{\mu<\mu_s^{R2}\}\delta_{R2}(\mu)
+\mathbf 1\{\mu>\mu_s^{R1}\}\delta_{R1}(\mu),
\]

onde

\[
D_{base}^{ext}(\mu)
=\frac{(B-C)V_e(\mu)+C\beta r}{N^2},
\]

\[
\delta_{R2}(\mu)
=\frac{(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]}{N^2},
\]

\[
\delta_{R1}(\mu)
=\frac{(N-1)\beta(r-1)(1-\mu)}{N^2}.
\]

Os termos de screening sob unanimity não mudam. Apenas o benchmark de majority muda.

### 2.1 Novo threshold de dominância condicional

Em `mu=1`, os termos de screening desaparecem. Assim,

\[
D^{ext}(1)
=\frac{r[B-C(1-\beta)]}{N^2}.
\]

Logo, unanimity domina majority condicionalmente para todo `mu in (0,1]` se e somente se

\[
B>C(1-\beta).
\]

Substituindo `B=beta(q-1)` e `C=N(N-1)alpha`, obtemos:

\[
\boxed{
\alpha_{ext}^{*}(N,\beta)
=\frac{\beta(q-1)}{N(N-1)(1-\beta)}.
}
\]

Portanto, o Teorema 1 deve ser reescrito como:

> **Theorem 1, corrected under external outside option.** Given `alpha in (0,1/r)`, unanimity gives the hegemon a strictly higher expected bargaining payoff than majority for every `mu in (0,1]` if and only if
>
> \[
> \alpha<\alpha_{ext}^{*}(N,\beta).
> \]

A prova por endpoints continua funcionando: em cada branch, `D^ext(mu)` é afim; o ponto apertado é `mu=1`; no branch de baixa crença, a condição de endpoint em `mu=0` é mais fraca do que a condição em `mu=1` porque o denominador correspondente é menor por

\[
\beta(N-1)^2(r-1)>0.
\]

### 2.2 Fronteira quando `alpha >= alpha_ext^*`

No branch conservador, isto é, quando `mu > mu_s^{R1}`, a diferença pode ser escrita como

\[
D^{ext}(\mu)=D^{ext}(1)+(1-\mu)\Gamma^{ext},
\]

com

\[
D^{ext}(1)=\frac{r[B-C(1-\beta)]}{N^2},
\]

\[
\Gamma^{ext}
=\frac{(r-1)[C-B+(N-1)\beta]}{N^2}>0.
\]

Se `alpha >= alpha_ext^*`, majority só pode dominar perto de `mu=1`, e a fronteira é

\[
\bar\mu^{ext}=1-\frac{|D^{ext}(1)|}{\Gamma^{ext}}.
\]

---

## 3. Consequências para o Exemplo 1 / Figura 3

Parâmetros:

\[
N=13,
\qquad
q=7,
\qquad
r=1.5,
\qquad
\alpha=0.19,
\qquad
\beta=0.9,
\qquad
c=0.07.
\]

### 3.1 Threshold de dominância

Threshold atualmente usado:

\[
\alpha^*_{old}\approx 0.2571.
\]

Threshold correto sob outside option externa:

\[
\alpha^*_{ext}
=\frac{0.9\cdot 6}{13\cdot 12\cdot 0.1}
\approx 0.3462.
\]

Como `alpha=0.19`, a condição continua satisfeita. A conclusão qualitativa de dominância condicional de unanimity fica mais fácil de sustentar, não mais difícil.

### 3.2 Coeficientes de majority

Coeficiente atual de `H` sob majority:

\[
\lambda_M^{old}\approx 0.22643.
\]

Coeficiente corrigido:

\[
\lambda_M^{ext}\approx 0.22036.
\]

Logo, em `mu=1`:

\[
V_H^M(1)\approx 0.33053,
\]

em vez de aproximadamente `0.33964`.

Coeficiente atual de `W` sob majority:

\[
\kappa_M^{old}\approx 0.06446.
\]

Coeficiente corrigido:

\[
\kappa_M^{ext}\approx 0.07959.
\]

Com `c=0.07`, a entrada sob majority passa a ocorrer para todo `p in (0,1]`, pois

\[
\kappa_M^{ext}>c.
\]

Ou seja:

\[
\tau_M^{old}\approx 0.172,
\qquad
\tau_M^{ext}=0.
\]

Portanto, a Figura 3 deve ser recalculada. A região cinza de não formação sob majority encolhe, e a região em que majority domina via entrada passa a incluir também priors baixos para os quais unanimity não sustenta entrada.

A formação sob unanimity não muda por causa da correção contábil. No branch conservador, o threshold permanece aproximadamente

\[
\tau_U^{con}\approx 0.376.
\]

### 3.3 Cutoff de `R1` sob unanimity: branch errada na calibração

O cutoff fechado independente de `alpha` vale apenas quando

\[
\alpha<\bar\alpha(r,\beta,N).
\]

Com os parâmetros do exemplo:

\[
\bar\alpha\approx 0.17017.
\]

Mas o paper usa

\[
\alpha=0.19>\bar\alpha.
\]

Logo, a calibração está no branch em que o cutoff depende de `alpha`.

O cutoff independente de `alpha` reportado é

\[
\mu_{s,H}^{R1}\approx 0.06398.
\]

Mas o cutoff correto no low-`R2` branch é aproximadamente

\[
\mu_s^{R1}\approx 0.06493.
\]

A diferença numérica é pequena, mas a branch usada está formalmente errada.

Para a branch baixa, usando as fórmulas atuais de unanimity, o cutoff resolve

\[
N\Delta_L(\mu)=0,
\]

onde

\[
N\Delta_L(\mu)
= -\beta(N-2)(1-\alpha)\mu^2
+\Big[\beta\alpha(N-2)(r-1)+N(\beta-r)+\beta(r-1)\Big]\mu
+\beta(r-1).
\]

---

## 4. A prova da Corollary / Proposition 4 precisa ser reescrita

O apêndice usa budget balance sob majority:

\[
E[V_H(\mu,M)]+(N-1)V_W(\mu,M)=V_e(\mu).
\]

Essa identidade só vale se a outside option de `H` for subtraída do bolo. Sob outside option externa, a identidade correta é

\[
E[V_H(\mu,M)]+(N-1)V_W(\mu,M)
=\left[1+\frac{(N-1)\alpha}{N}\right]V_e(\mu)>V_e(\mu).
\]

Logo, a prova de que

\[
\mathcal F_U\subseteq \mathcal F_M
\]

não pode usar budget balance como está.

A boa notícia é que `V_W^{R1}(mu,M)` aumenta quando removemos o fator `(1-alpha)`. Portanto, para os parâmetros do exemplo, o nesting de formation sets continua verdadeiro. Mas a demonstração geral precisa ser refeita por comparação explícita de payoffs dos fracos, branch por branch:

\[
V_W^{R1}(\mu,M)=\kappa_M^{ext}V_e(\mu)
\]

contra as expressões de unanimity.

No branch conservador/high-`R2`, por exemplo:

\[
V_W^{R1}(\mu,U)
=\frac{(N+\beta)V_e(\mu)-\beta r(1+N\alpha)}{N^2}.
\]

A diferença é

\[
V_W^{R1}(\mu,M)-V_W^{R1}(\mu,U)
=
\frac{\beta}{N^2(N-1)}
\Big[
N(N-1)\alpha r
+(r-1)[N(1-\mu)+\mu q]
+q-r
\Big],
\]

que é positiva. As demais branches devem ser verificadas do mesmo modo.

### 4.1 Majority may fail to beat no institution when `alpha` is high

Outro ponto novo: sob a contabilidade externa, não é automaticamente verdade que majority gives `H` more than the outside option.

Temos

\[
\lambda_M^{ext}-\alpha
=\frac{N(1-\alpha)-\beta(q-1)}{N^2}.
\]

Portanto,

\[
\lambda_M^{ext}>\alpha
\quad\Longleftrightarrow\quad
\alpha<1-\frac{\beta(q-1)}{N}.
\]

No exemplo calibrado, essa condição é satisfeita. Mas ela não é garantida apenas por `alpha<1/r`. Assim, na Proposition 4, o caso

\[
p\in\mathcal F_M\setminus\mathcal F_U
\]

só implica `M \succ U` se majority formation dá ao hegemon mais do que sua outside option. Caso contrário, se unanimity não forma e majority forma mas gera payoff menor que `alpha V_e(p)`, o hegemon preferiria escolher uma regra que induza não formação, ou o modelo deve excluir explicitamente a opção de não formar.

Isto exige uma das seguintes correções:

1. adicionar a hipótese `lambda_M^{ext}>alpha`; ou
2. permitir explicitamente uma outside option institucional/no-institution no estágio de escolha da regra; ou
3. restringir parâmetros de modo que majority formation seja sempre benéfica para `H`.

---

## 5. Viabilidade ex post das ofertas sob unanimity

Este problema é independente da correção da majority rule.

O modelo diz que o proponente oferece uma divisão de `V(theta)`. Então, em cada estado, as transferências prometidas em uma proposta aceita devem somar no máximo `V(theta)`. O apêndice verifica orçamento em expectativa, mas isso não garante viabilidade estado a estado.

### 5.1 `W` propõe em `R1` sob unanimity, oferta conservadora

A oferta conservadora de um fraco a `H` é

\[
\beta\frac{r+x}{N},
\qquad
x=(N-1)\alpha r.
\]

Além disso, cada um dos `N-2` fracos não proponentes recebe, nas fórmulas atuais,

\[
\beta V_W^{R2}(\mu,U).
\]

Para que a proposta seja factível no estado baixo, é necessário:

\[
\boxed{
\beta\frac{r+(N-1)\alpha r}{N}
+(N-2)\beta V_W^{R2}(\mu,U)
\le 1.
}
\]

No branch high-`R2`, isto é,

\[
V_W^{R2}(\mu,U)=\frac{V_e(\mu)-\alpha r}{N},
\]

os parâmetros do exemplo dão:

\[
0.3406+0.7615(0.715+0.5\mu)\le 1,
\]

ou aproximadamente

\[
\mu\lesssim 0.302.
\]

Mas a região de unanimity formation no exemplo começa perto de `p≈0.376`. Logo, parte importante da região azul da Figura 3 depende de ofertas conservadoras que não são factíveis no estado baixo, salvo se o modelo permitir transferências externas, crédito, ou propostas que não precisam ser factíveis estado a estado.

### 5.2 `H` propõe em `R1` sob unanimity, tipo baixo

Quando o hegemon baixo propõe, ele precisa pagar aos `N-1` fracos:

\[
(N-1)\beta V_W^{R2}(\mu,U).
\]

A viabilidade no estado baixo exige:

\[
\boxed{
(N-1)\beta V_W^{R2}(\mu,U)
\le 1.
}
\]

Com os parâmetros do exemplo, no branch high-`R2`, essa condição falha para crenças muito altas:

\[
\mu\gtrsim 0.977.
\]

Este problema é menos severo que o anterior, mas mostra que a formulação precisa de uma restrição de feasibility ou de uma justificativa explícita para transferências não limitadas pelo estado baixo.

---

## 6. Timing e restrições de participação dos fracos não proponentes

Há um problema formal adicional na derivação de `F_agg` em `R1` sob unanimity.

Nas fórmulas atuais, quando um fraco propõe agressivamente, os fracos não proponentes recebem `beta V_W^{R2}(mu,U)`. Isso é suficiente para fazê-los aceitar, mas pode não ser o pagamento mínimo dependendo do protocolo de votação e da informação revelada pela rejeição de `H`.

Em um jogo de votação padrão, se `H` rejeita a oferta agressiva no tipo alto, os demais jogadores chegam a `R2` com posterior atualizado. Assim, a aceitação de um fraco não proponente deve comparar:

- aceitar e receber a transferência apenas se `H` aceitar; mas, se `H` rejeitar, ir a `R2` com posterior revelado;
- rejeitar e ir a `R2` com o posterior determinado pelo que é observado no histórico de votos.

Dependendo de se os votos são simultâneos, sequenciais, públicos, ou se a rejeição de um fraco impede observar o voto de `H`, o pagamento mínimo aos fracos não proponentes pode ser diferente de `beta V_W^{R2}(mu,U)`.

Isto pode alterar:

\[
F_{agg}^{R1}(\mu),
\]

portanto também:

\[
\mu_s^{R1},
\qquad
V_W^{R1}(\mu,U),
\qquad
\mathcal F_U.
\]

Se a intenção é manter as fórmulas atuais, o modelo deve impor explicitamente uma convenção reduzida, por exemplo:

> Non-proposing weak states must be paid their current-belief discounted continuation value `beta V_W^{R2}(mu,U)` whenever their vote is required, regardless of the information that may be revealed by `H`'s subsequent rejection.

Sem essa convenção, as restrições de participação dos fracos não proponentes devem ser rederivadas.

---

## 7. Salto no cutoff: formular por limites laterais ou fixar desempate

Na Proposição 3, o paper afirma que o payoff esperado de `H` tem um salto em `mu_s^{R1}`.

No ponto exato do cutoff, porém, o proponente fraco está indiferente entre a oferta agressiva e a conservadora. Sem uma regra de desempate, o payoff no ponto não é único.

A formulação rigorosa é:

\[
\lim_{\mu\downarrow\mu_s^{R1}}V_H^U(\mu)
-
\lim_{\mu\uparrow\mu_s^{R1}}V_H^U(\mu)
=
(1-\mu_s^{R1})\frac{(N-1)\beta(r-1)}{N^2}>0.
\]

Ou então deve-se declarar um tie-breaking rule para o fraco no cutoff.

---

## 8. Entrada: multiplicidade de equilíbrios

A etapa de entrada é simultânea e all-or-nothing: a instituição só se forma se todos os fracos entram.

Mesmo quando

\[
V_W^{R1}(p,R)\ge c,
\]

há tipicamente um equilíbrio em que nenhum fraco entra, pois entrar sozinho gera custo e não forma a instituição.

Portanto, `F_R` não é literalmente o conjunto em que a instituição se forma em todos os PBE. É o conjunto em que existe um equilíbrio de entrada plena, ou em que entrada plena é selecionada.

A Proposition 4 precisa de uma hipótese de seleção, por exemplo:

- seleção payoff-dominante;
- comunicação prévia entre fracos;
- tremble-hand/refinement;
- mecanismo de entrada coordenada;
- ou uma formulação em que a decisão de entrada é coletiva, não individual simultânea.

Sem isso, a classificação institucional não é uma implicação única de PBE.

---

## 9. Appendix C: continuous types também precisa ser atualizado

A correção de majority afeta diretamente o apêndice contínuo.

Sob outside option externa, em majority:

\[
V_W^{R2}(\theta,M)=\frac{\theta}{N},
\]

não

\[
\frac{(1-\alpha)\theta}{N}.
\]

Logo, quando `H` propõe em `R1` sob majority, o custo de comprar `q-1` votos é

\[
(q-1)\beta\frac{E[\theta]}{N},
\]

não

\[
(q-1)\beta\frac{(1-\alpha)E[\theta]}{N}.
\]

Para `theta ~ Uniform[1,r]`, com

\[
m=E[\theta]=\frac{1+r}{2},
\]

o payoff de majority corrigido é

\[
E[V_H^{R1}(M)]
=\lambda_M^{ext}m
=
\frac{m[N(1+(N-1)\alpha)-\beta(q-1)]}{N^2}.
\]

As fórmulas de unanimity permanecem iguais. O payoff difference contínuo corrigido fica:

\[
D_{cont}^{ext}
=\frac{1}{2N^2}
\left[
(N-1)\beta\frac{(\theta_1^*-1)^2}{r-1}
+(1+r)\beta(q-1)
-N(N-1)\alpha(1+r-2\beta r)
\right].
\]

Quando

\[
1+r-2\beta r>0,
\]

o threshold contínuo corrigido é

\[
\boxed{
\alpha_{cont,ext}^*
=
\frac{(N-1)\beta(\theta_1^*-1)^2/(r-1)+(1+r)\beta(q-1)}
{N(N-1)(1+r-2\beta r)}.
}
\]

Quando

\[
1+r-2\beta r\le 0,
\]

a diferença é não decrescente em `alpha` e unanimity domina para todo `alpha` admissível, desde que o termo constante seja positivo.

No limite `r -> 1`, o threshold contínuo corrigido converge para o threshold binário corrigido:

\[
\alpha_{cont,ext}^*\to
\frac{\beta(q-1)}{N(N-1)(1-\beta)}
=\alpha_{ext}^*.
\]

A afirmação atual de que `alpha_cont^* >= alpha^*` deve ser refeita usando o novo `alpha_ext^*`. A evidência por grid search também deve ser repetida.

---

## 10. Lista prática de mudanças no manuscrito e no apêndice

### Main text

1. **Section 5 / Proposition 1:** manter a conclusão qualitativa, mas substituir a prova por uma prova de exclusão de `H` baseada na outside option externa.
2. **Section 7 / entry:** substituir `kappa_M` por `kappa_M^ext`.
3. **Theorem 1:** substituir `alpha^*` por `alpha_ext^*`.
4. **Remark 1:** substituir `C_buy=beta(q-1)(1-alpha)` por `C_buy=beta(q-1)`.
5. **Corollary 1 / Proposition 4:** reescrever a prova de `F_U subset F_M`; não usar budget balance sob majority.
6. **Example 2 / Figure 3:** recalcular majority entry. Com os parâmetros atuais e `c=0.07`, majority sustenta entrada para todo `p`.
7. **Proposition 3:** formular o salto por limites laterais ou declarar desempate.
8. **Model section:** explicitar se propostas precisam ser factíveis estado a estado. Se sim, impor as restrições de feasibility e re-solver os cutoffs.
9. **Entry stage:** adicionar seleção de equilíbrio para entrada plena.

### Appendix A

1. **A.1:** substituir `V_W^{R2}(mu,M)` por `V_e(mu)/N`.
2. **A.6:** remover budget identity sob majority; substituir pela identidade com outside option externa.
3. **A.7:** substituir `kappa_M` por `kappa_M^ext`.
4. **A.3/A.5:** corrigir a branch do cutoff no exemplo calibrado.

### Appendix B

1. **B.1:** reescrever a prova de maioria sem subtrair `alpha V(theta)` do bolo de `W`.
2. **B.5a/B.5:** substituir `C_buy` e refazer o threshold.
3. **B.6:** reescrever a prova do nesting de formation sets.
4. **B.8:** adicionar a condição `lambda_M^ext > alpha`, ou permitir explicitamente a opção de não formação.

### Appendix C

1. Atualizar majority values sob continuous types.
2. Recalcular o payoff difference e o threshold contínuo.
3. Repetir a comparação entre threshold binário e contínuo.

---

## 11. Versão curta para orientar a reescrita

A correção central é simples:

\[
\boxed{
\text{fora de unanimity, } H \text{ recebe } \alpha V(\theta) \text{ externamente; } W \text{ não paga isso.}
}
\]

Então:

\[
\boxed{
V_W^{R2}(\mu,M)=\frac{V_e(\mu)}{N}
}
\]

\[
\boxed{
\lambda_M^{ext}
=\frac{N[1+(N-1)\alpha]-\beta(q-1)}{N^2}
}
\]

\[
\boxed{
\kappa_M^{ext}
=\frac{N(N-1)+\beta(q-1)}{N^2(N-1)}
}
\]

\[
\boxed{
\alpha_{ext}^{*}
=\frac{\beta(q-1)}{N(N-1)(1-\beta)}
}
\]

A Proposição 1 sobre ausência de screening sob majority continua defensável. O Teorema 1 também pode ser preservado, mas com o novo threshold. A Figura 3 e os resultados de entrada precisam ser recalculados. Além disso, há problemas independentes de viabilidade ex post, tie-breaking no cutoff, multiplicidade de entrada e timing das restrições de participação dos fracos não proponentes.

