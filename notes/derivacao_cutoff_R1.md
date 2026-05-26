# Derivação do cutoff de R1 sob unanimidade

## Objetivo

Queremos resolver o cutoff de Round 1, isto é, o valor de 
\(\mu_s^{R1}\) tal que a weak state proponente fica indiferente entre:

- **oferta agressiva**: barata, aceita apenas por \(\theta=0\);
- **oferta conservadora**: cara, aceita por ambos os tipos.

A equação de indiferença dada na nota é

\[
\Delta_1(\mu)
= -\mu r
+ \frac{\beta}{N}\left[(r-1) + \mu\bigl(1+r+(N-2)\alpha r\bigr)\right]
+ \mu\,\omega(\mu),
\]

com

\[
\omega(\mu)=(N-2)\beta V_W^{R2}(\mu).
\]

O ponto-chave é que \(V_W^{R2}(\mu)\) é **piecewise**, com kink em

\[
\mu_2 \equiv \mu_s^{R2} = \frac{\alpha(r-1)}{r-\alpha}.
\]

A boa notícia é que, uma vez substituído o valor de \(V_W^{R2}(\mu)\), o problema de R1 cai em **duas quadráticas explícitas**. Mais do que isso: dá para mostrar que \(\Delta_1(\mu)\) é **estritamente decrescente em todo o domínio**, o que entrega existência e unicidade do cutoff em \((0,1)\).

---

## 1. Continuação de R2

Da sua nota,

\[
V_W^{R2}(\mu)=
\begin{cases}
\dfrac{(1-\mu)(1-\alpha)}{N}, & \mu \le \mu_2,\\[1em]
\dfrac{1+\mu(r-1)-\alpha r}{N}, & \mu \ge \mu_2.
\end{cases}
\]

Logo,

\[
\omega(\mu)=
\begin{cases}
\dfrac{(N-2)\beta(1-\mu)(1-\alpha)}{N}, & \text{multiplicando }V_W^{R2}(\mu),\\
\end{cases}
\]

mas como na equação de \(\Delta_1\) o termo entra como \(\mu\omega(\mu)\), é mais conveniente já escrever tudo na forma final:

\[
\mu\omega(\mu)=
\begin{cases}
\dfrac{(N-2)\beta\mu(1-\mu)(1-\alpha)}{N^2}, & \mu \le \mu_2,\\[1em]
\dfrac{(N-2)\beta\mu\bigl(1+\mu(r-1)-\alpha r\bigr)}{N^2}, & \mu \ge \mu_2.
\end{cases}
\]

---

## 2. A equação de R1 por partes

Defina

\[
c_0 \equiv \frac{\beta(r-1)}{N} >0.
\]

### Região baixa: \(\mu\le \mu_2\)

Substituindo o ramo baixo de \(V_W^{R2}(\mu)\) em \(\Delta_1(\mu)\), obtemos

\[
\Delta_1(\mu)= c_0 + b_L\mu - k_L\mu^2,
\qquad \mu\le \mu_2,
\]

onde

\[
k_L \equiv \frac{\beta(N-2)(1-\alpha)}{N^2} >0,
\]

\[
b_L \equiv
-r
+ \frac{\beta}{N}\Bigl(1+r+(N-2)\alpha r\Bigr)
+ \frac{\beta(N-2)(1-\alpha)}{N^2}.
\]

Portanto, no ramo baixo, \(\Delta_1\) é uma **quadrática côncava**.

### Região alta: \(\mu\ge \mu_2\)

Substituindo o ramo alto de \(V_W^{R2}(\mu)\), obtemos

\[
\Delta_1(\mu)= c_0 + b_H\mu + k_H\mu^2,
\qquad \mu\ge \mu_2,
\]

onde

\[
k_H \equiv \frac{\beta(N-2)(r-1)}{N^2} >0,
\]

\[
b_H \equiv
-r
+ \frac{\beta}{N}\Bigl(1+r+(N-2)\alpha r\Bigr)
+ \frac{\beta(N-2)(1-\alpha r)}{N^2}.
\]

No ramo alto, \(\Delta_1\) é uma **quadrática convexa**.

---

## 3. Continuidade no kink

Como \(V_W^{R2}(\mu)\) é contínua em \(\mu_2\), \(\Delta_1(\mu)\) também é contínua em \(\mu_2\). Em particular,

\[
\Delta_L(\mu_2)=\Delta_H(\mu_2).
\]

Assim, o único problema é descobrir em qual lado do kink está a raiz.

---

## 4. Resultado principal: \(\Delta_1(\mu)\) é estritamente decrescente

Esse é o passo que realmente limpa a prova.

### Derivada no ramo baixo

\[
\Delta_L'(\mu)= b_L - 2k_L\mu.
\]

Como \(k_L>0\), a derivada é decrescente no ramo baixo, então seu valor máximo ocorre em \(\mu=0\):

\[
\Delta_L'(\mu) \le \Delta_L'(0).
\]

Além disso, \(\Delta_L'(0)\) é crescente em \(\alpha\) e em \(\beta\). Logo, um upper bound é obtido em \(\beta=1\) e \(\alpha=1/r\) (limite superior admissível):

\[
\Delta_L'(0)
<
-\frac{(r-1)(N^2r-Nr-N+2)}{N^2r}
<0.
\]

Portanto,

\[
\Delta_L'(\mu)<0 \quad \text{para todo } \mu\le \mu_2.
\]

### Derivada no ramo alto

\[
\Delta_H'(\mu)= b_H + 2k_H\mu.
\]

Como \(k_H>0\), a derivada é crescente no ramo alto, então seu valor máximo ocorre em \(\mu=1\):

\[
\Delta_H'(\mu) \le \Delta_H'(1).
\]

Novamente, \(\Delta_H'(1)\) é crescente em \(\alpha\) e em \(\beta\), então um upper bound é obtido em \(\beta=1\) e \(\alpha=1/r\):

\[
\Delta_H'(1)
<
-\frac{(r-1)(N^2-3N+4)}{N^2}
<0.
\]

Logo,

\[
\Delta_H'(\mu)<0 \quad \text{para todo } \mu\ge \mu_2.
\]

### Conclusão

Juntando os dois ramos,

\[
\Delta_1'(\mu)<0 \quad \text{para todo } \mu\in[0,1].
\]

Ou seja: **apesar do kink, a função inteira é estritamente decrescente**.

---

## 5. Existência e unicidade do cutoff de R1

Agora basta checar os extremos.

### Em \(\mu=0\)

\[
\Delta_1(0)=\frac{\beta(r-1)}{N}>0.
\]

### Em \(\mu=1\)

Usando o ramo alto,

\[
\Delta_1(1)
=
\frac{r\Bigl(N^2\alpha\beta-N^2-3N\alpha\beta+3N\beta+2\alpha\beta-2\beta\Bigr)}{N^2}.
\]

Esse valor é crescente em \(\alpha\) e em \(\beta\), então novamente um upper bound é obtido em \(\beta=1\) e \(\alpha=1/r\):

\[
\Delta_1(1)
<
-\frac{(N-2)(N-1)(r-1)}{N^2}
<0.
\]

Como \(\Delta_1\) é contínua e estritamente decrescente, segue imediatamente:

> **Proposição.** Existe um único cutoff \(\mu_s^{R1}\in(0,1)\) tal que
> \[
> \Delta_1(\mu_s^{R1})=0.
> \]
> Para \(\mu<\mu_s^{R1}\), a weak state prefere a oferta agressiva; para \(\mu>\mu_s^{R1}\), prefere a oferta conservadora.

Esse é exatamente o resultado que você quer para o paper: **existência e unicidade** não dependem de root-finding numérico.

---

## 6. Expressão fechada do cutoff

Como a equação é piecewise, a forma fechada também é piecewise.

### Caso A: a raiz está no ramo baixo (\(\mu_s^{R1}\le \mu_2\))

Resolve-se

\[
c_0 + b_L\mu - k_L\mu^2 = 0.
\]

A raiz economicamente relevante é

\[
\mu_L^*
=
\frac{b_L + \sqrt{b_L^2 + 4k_Lc_0}}{2k_L}.
\]

### Caso B: a raiz está no ramo alto (\(\mu_s^{R1}\ge \mu_2\))

Resolve-se

\[
c_0 + b_H\mu + k_H\mu^2 = 0.
\]

A raiz admissível é

\[
\mu_H^*
=
\frac{-b_H - \sqrt{b_H^2 - 4k_Hc_0}}{2k_H}.
\]

### Regra de seleção

Como \(\Delta_1\) é contínua e estritamente decrescente, basta olhar o sinal no kink:

- se \(\Delta_1(\mu_2)\le 0\), então a raiz está no ramo baixo e \(\mu_s^{R1}=\mu_L^*\);
- se \(\Delta_1(\mu_2)\ge 0\), então a raiz está no ramo alto e \(\mu_s^{R1}=\mu_H^*\).

Equivalentemente,

\[
\mu_s^{R1}=
\begin{cases}
\mu_L^*, & \text{se } \mu_L^*\le \mu_2,\\[0.5em]
\mu_H^*, & \text{se } \mu_L^*>\mu_2.
\end{cases}
\]

Então há, sim, uma **expressão analítica fechada**. Ela só não é um único racional simples como em R2; é uma solução por partes de uma quadrática em cada lado do kink.

---

## 7. Interpretação

O resultado econômico é limpo.

1. **R2 determina o kink** por meio de \(\mu_2\), porque é em R2 que aparece a mudança entre screening e pooling na continuação.
2. **R1 herda esse kink**, mas a diferença entre agressivo e conservador continua obedecendo uma função estritamente decrescente de \(\mu\).
3. Logo, a lógica qualitativa do modelo permanece a mesma:
   - crenças baixas sobre \(\theta=1\) favorecem screening via oferta agressiva;
   - crenças altas favorecem pooling via oferta conservadora.
4. A vantagem analítica é que agora isso pode ser enunciado como **teorema**, e não apenas como evidência numérica.

---

## 8. Formulação pronta para o paper

Você pode transformar isso em algo próximo do seguinte.

### Proposição

> **Proposição X (cutoff único em R1).** Sob unanimidade, defina
> \[
> \mu_2 \equiv \frac{\alpha(r-1)}{r-\alpha}.
> \]
> A diferença entre o payoff esperado da weak state proponente sob a oferta agressiva e sob a oferta conservadora em Round 1, \(\Delta_1(\mu)\), é contínua e estritamente decrescente em \(\mu\in[0,1]\). Portanto, existe um único cutoff \(\mu_s^{R1}\in(0,1)\) tal que \(\Delta_1(\mu_s^{R1})=0\). A weak state escolhe a oferta agressiva para \(\mu<\mu_s^{R1}\) e a oferta conservadora para \(\mu>\mu_s^{R1}\).

### Prova (esqueleto compacto)

> Substituindo o valor de continuação de R2 na expressão de \(\Delta_1(\mu)\), obtém-se uma representação por partes:
> \[
> \Delta_1(\mu)=
> \begin{cases}
> c_0+b_L\mu-k_L\mu^2, & \mu\le \mu_2,\\
> c_0+b_H\mu+k_H\mu^2, & \mu\ge \mu_2,
> \end{cases}
> \]
> com \(c_0=\beta(r-1)/N>0\), \(k_L=\beta(N-2)(1-\alpha)/N^2>0\) e \(k_H=\beta(N-2)(r-1)/N^2>0\). A função é contínua em \(\mu_2\). No ramo baixo, \(\Delta_1'(\mu)=b_L-2k_L\mu\), cujo máximo ocorre em \(\mu=0\); usando \(\beta<1\) e \(\alpha<1/r\), obtém-se \(\Delta_1'(0)<0\). No ramo alto, \(\Delta_1'(\mu)=b_H+2k_H\mu\), cujo máximo ocorre em \(\mu=1\); novamente, \(\Delta_1'(1)<0\). Portanto, \(\Delta_1'(\mu)<0\) em todo o domínio. Ademais, \(\Delta_1(0)=\beta(r-1)/N>0\) e \(\Delta_1(1)<0\). Pelo teorema do valor intermediário e monotonicidade estrita, existe um único \(\mu_s^{R1}\in(0,1)\) tal que \(\Delta_1(\mu_s^{R1})=0\). \(\square\)

---

## 9. Código R para implementar a solução analítica

```r
cutoff_R1 <- function(alpha, r, beta, N) {
  mu2 <- alpha * (r - 1) / (r - alpha)

  c0 <- beta * (r - 1) / N

  bL <- -r + beta / N * (1 + r + (N - 2) * alpha * r) +
    beta * (N - 2) * (1 - alpha) / N^2
  kL <- beta * (N - 2) * (1 - alpha) / N^2

  bH <- -r + beta / N * (1 + r + (N - 2) * alpha * r) +
    beta * (N - 2) * (1 - alpha * r) / N^2
  kH <- beta * (N - 2) * (r - 1) / N^2

  delta_kink <- c0 + bL * mu2 - kL * mu2^2  # igual ao ramo alto por continuidade

  muL <- (bL + sqrt(bL^2 + 4 * kL * c0)) / (2 * kL)
  muH <- (-bH - sqrt(bH^2 - 4 * kH * c0)) / (2 * kH)

  mu1 <- if (delta_kink <= 0) muL else muH

  list(mu_R2 = mu2, mu_R1 = mu1, delta_at_kink = delta_kink,
       root_low = muL, root_high = muH)
}
```

---

## 10. O que eu recomendaria no paper

Eu não venderia isso como “uma expressão fechada simples”. Eu venderia assim:

- **há uma solução analítica fechada por partes**;
- **o cutoff existe e é único**;
- **o root-finding numérico deixa de ser necessário para a teoria**;
- o numérico pode ficar apenas para figuras e estáticas comparativas.

Isso é suficientemente forte para a parte formal. Na prática, eu colocaria no texto principal a proposição de existência/unicidade e a forma piecewise de \(\Delta_1(\mu)\), e deixaria a álgebra detalhada e as expressões das raízes no apêndice.
