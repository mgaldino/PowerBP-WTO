# Nota corrigida sobre o cutoff de R1 sob unanimidade

**Data:** 2026-04-20  
**Status:** substitui as versões anteriores

## 1. Objetivo

Queremos caracterizar o cutoff de Round 1, denotado \(\mu_s^{R1}\), no problema em que um proposer fraco \(W\) sob unanimidade escolhe entre:

- **oferta agressiva:** barata, aceita apenas por \(\theta=0\);
- **oferta conservadora:** cara, aceita por ambos os tipos.

A equação de indiferença vinda da nota técnica é

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu\bigl(1+r+(N-2)\alpha r\bigr)\Big] + \mu\omega(\mu),
\]

onde

\[
\omega(\mu)=(N-2)\beta V_W^{R2}(\mu).
\]

O ponto crítico é que \(V_W^{R2}(\mu)\) é piecewise, com kink em

\[
\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}.
\]

A conclusão desta nota é simples:

1. \(\mu_s^{R1}\) tem **solução analítica fechada por casos**;
2. no **Caso 2** (raiz à direita do kink), a fórmula é **independente de \(\alpha\)**;
3. a seleção entre os dois casos pode ser feita pelo sinal de \(\Delta_1(\mu_s^{R2})\), ou equivalentemente por uma condição explícita sobre \(\alpha\).

---

## 2. Continuação de R2

Da nota técnica,

\[
V_W^{R2}(\mu)=
\begin{cases}
\dfrac{(1-\mu)(1-\alpha)}{N}, & \mu<\mu_s^{R2},\\[1em]
\dfrac{1+\mu(r-1)-\alpha r}{N}, & \mu>\mu_s^{R2}.
\end{cases}
\]

Logo,

\[
\omega(\mu)=
\begin{cases}
\dfrac{(N-2)\beta(1-\mu)(1-\alpha)}{N}, & \mu<\mu_s^{R2},\\[1em]
\dfrac{(N-2)\beta\bigl[1+\mu(r-1)-\alpha r\bigr]}{N}, & \mu>\mu_s^{R2}.
\end{cases}
\]

---

## 3. Caso 1: \(\mu_s^{R1}<\mu_s^{R2}\)

Neste caso, o valor relevante de R2 está no ramo baixo:

\[
\omega(\mu)=\frac{(N-2)\beta(1-\mu)(1-\alpha)}{N}.
\]

Substituindo em \(\Delta_1(\mu)\):

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu\bigl(1+r+(N-2)\alpha r\bigr)\Big]
+ \frac{(N-2)\beta\mu(1-\mu)(1-\alpha)}{N}.
\]

Reorganizando,

\[
\Delta_1(\mu)
=
\frac{\beta(r-1)}{N}
+ \mu\left[\frac{\beta}{N}\Big(N-1+r+(N-2)\alpha(r-1)\Big)-r\right]
- \frac{(N-2)\beta(1-\alpha)}{N}\mu^2.
\]

Igualando a zero e multiplicando por \(N\):

\[
(N-2)\beta(1-\alpha)\mu^2
+
\Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu
-\beta(r-1)=0.
\]

Portanto, no Caso 1,

\[
\boxed{
(N-2)\beta(1-\alpha)\mu^2
+
\Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu
-\beta(r-1)=0.
}
\]

Como o coeficiente de \(\mu^2\) é positivo e o termo constante é negativo, existe exatamente uma raiz positiva. A raiz economicamente relevante é

\[
\boxed{
\mu_{L}^{*}
=
\frac{-b_L+\sqrt{b_L^2+4(N-2)\beta^2(1-\alpha)(r-1)}}{2(N-2)\beta(1-\alpha)}
}
\]

com

\[
b_L \equiv rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr).
\]

Essa fórmula vale quando a raiz satisfaz \(\mu_L^*<\mu_s^{R2}\).

---

## 4. Caso 2: \(\mu_s^{R1}>\mu_s^{R2}\)

Agora o valor relevante de R2 está no ramo alto:

\[
\omega(\mu)=\frac{(N-2)\beta\bigl[1+\mu(r-1)-\alpha r\bigr]}{N}.
\]

Substituindo em \(\Delta_1(\mu)\):

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu\bigl(1+r+(N-2)\alpha r\bigr)\Big]
+ \frac{(N-2)\beta\mu\bigl[1+\mu(r-1)-\alpha r\bigr]}{N}.
\]

Reunindo termos,

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu\bigl(1+r+(N-2)\alpha r\bigr)+(N-2)\mu(1-\alpha r)+(N-2)(r-1)\mu^2\Big].
\]

O coeficiente linear em \(\mu\) simplifica para

\[
1+r+(N-2)\alpha r + (N-2)(1-\alpha r)=N-1+r.
\]

Portanto, os termos em \(\alpha\) cancelam exatamente, e obtemos

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu(N-1+r)+(N-2)(r-1)\mu^2\Big].
\]

Igualando a zero e multiplicando por \(N\):

\[
(N-2)\beta(r-1)\mu^2 + \big[\beta(N-1+r)-rN\big]\mu + \beta(r-1)=0.
\]

Então, no Caso 2,

\[
\boxed{
(N-2)\beta(r-1)\mu^2 + \big[\beta(N-1+r)-rN\big]\mu + \beta(r-1)=0.
}
\]

Definindo

\[
\phi \equiv \frac{rN-\beta(N-1+r)}{\beta(r-1)},
\]

a equação fica

\[
(N-2)\mu^2-\phi\mu+1=0.
\]

Logo,

\[
\boxed{
\mu_H^* = \frac{\phi-\sqrt{\phi^2-4(N-2)}}{2(N-2)}
}
\]

é a raiz relevante em \((0,1)\). Essa expressão depende apenas de \((r,\beta,N)\) e **não depende de \(\alpha\)**.

---

## 5. Discriminante e admissibilidade do Caso 2

O discriminante do Caso 2 é

\[
\phi^2-4(N-2).
\]

Como

\[
\phi = \frac{rN-\beta(N-1+r)}{\beta(r-1)},
\]

e \(r>1\), \(\beta\in(0,1)\), tem-se \(\phi>0\). Em particular, para os parâmetros admissíveis do modelo, a raiz menor é a economicamente relevante.

Uma forma mais útil de organizar a admissibilidade do Caso 2 é a seguinte. Como

\[
\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha},
\]

a condição \(\mu_H^*>\mu_s^{R2}\) equivale a

\[
\alpha < \bar\alpha(r,\beta,N)
\equiv
\frac{r\mu_H^*}{r-1+\mu_H^*}.
\]

Portanto:

- se \(\alpha<\bar\alpha(r,\beta,N)\), vale o **Caso 2**;
- se \(\alpha>\bar\alpha(r,\beta,N)\), vale o **Caso 1**;
- se \(\alpha=\bar\alpha(r,\beta,N)\), estamos na fronteira \(\mu_s^{R1}=\mu_s^{R2}\).

Essa formulação é melhor do que dizer apenas “\(\alpha\) suficientemente pequeno”: aqui a fronteira fica explícita.

---

## 6. Como selecionar o caso na prática

Há dois procedimentos equivalentes.

### Método A: avaliar no kink

Calcule

\[
\Delta_1(\mu_s^{R2}).
\]

- Se \(\Delta_1(\mu_s^{R2})>0\), então \(W\) ainda prefere a oferta agressiva no kink, então a raiz está à direita: **Caso 2**.
- Se \(\Delta_1(\mu_s^{R2})<0\), então \(W\) já prefere a oferta conservadora no kink, então a raiz está à esquerda: **Caso 1**.
- Se \(\Delta_1(\mu_s^{R2})=0\), então \(\mu_s^{R1}=\mu_s^{R2}\).

### Método B: usar a fronteira em \(\alpha\)

1. Calcule \(\mu_H^*\) pela fórmula do Caso 2.
2. Calcule
   \[
   \bar\alpha=\frac{r\mu_H^*}{r-1+\mu_H^*}.
   \]
3. Compare \(\alpha\) com \(\bar\alpha\).

Esse segundo método é especialmente útil para estática comparativa e para exposição teórica.

---

## 7. Unicidade da solução relevante

Não é necessário provar que \(\Delta_1(\mu)\) é monotônica em todo o domínio. Basta observar o seguinte.

### Caso 1

No Caso 1, a equação relevante é uma quadrática com coeficiente líder positivo e termo constante negativo. Portanto, o produto das raízes é negativo: existe exatamente uma raiz positiva. Essa é a única candidata economicamente admissível no ramo esquerdo.

### Caso 2

No Caso 2, a equação relevante também é uma quadrática, agora com

\[
\Delta_H(0)=\frac{\beta(r-1)}{N}>0,
\qquad
\Delta_H(1)=r(\beta-1)<0.
\]

Como a função do Caso 2 é convexa, o conjunto \(\{\mu:\Delta_H(\mu)\le 0\}\) é um intervalo. Como \(0\) está fora e \(1\) está dentro desse conjunto, há exatamente uma travessia em \((0,1)\). Logo, a raiz \(\mu_H^*\) é única no intervalo relevante.

### Conclusão

A seleção entre os dois casos é unívoca, e portanto o cutoff global \(\mu_s^{R1}\) está bem definido.

---

## 8. Estática comparativa no Caso 2

No Caso 2, o cutoff é

\[
\mu_H^* = \frac{\phi-\sqrt{\phi^2-4(N-2)}}{2(N-2)},
\qquad
\phi=\frac{rN-\beta(N-1+r)}{\beta(r-1)}.
\]

Temos

\[
\frac{\partial \phi}{\partial \beta} = -\frac{Nr}{\beta^2(r-1)}<0,
\qquad
\frac{\partial \phi}{\partial r} = \frac{N(\beta-1)}{\beta(r-1)^2}<0,
\qquad
\frac{\partial \phi}{\partial N} = \frac{r-\beta}{\beta(r-1)}>0.
\]

Além disso,

\[
\frac{\partial \mu_H^*}{\partial \phi}
=
\frac{1-\phi/\sqrt{\phi^2-4(N-2)}}{2(N-2)}<0.
\]

Logo,

\[
\boxed{
\frac{\partial \mu_H^*}{\partial \beta}>0,
\qquad
\frac{\partial \mu_H^*}{\partial r}>0,
\qquad
\frac{\partial \mu_H^*}{\partial N}<0.
}
\]

Interpretação:

- **\(\beta\uparrow\)**: rejeição em R1 fica menos custosa, então \(W\) tolera crenças mais altas antes de passar para pooling; o cutoff sobe.
- **\(r\uparrow\)**: o gap entre tipos aumenta, então screening rende mais; o cutoff sobe.
- **\(N\uparrow\)**: o ganho marginal privado do proposer dilui, então screening fica relativamente menos atraente; o cutoff cai.

Esses sinais valem apenas no Caso 2. No Caso 1, as derivadas existem, mas a expressão é mais suja e eu não as usaria no texto principal sem necessidade.

---

## 9. Formulação final do resultado

Uma forma limpa de apresentar isso no paper é:

> **Proposição (cutoff de R1).** Sob unanimidade, o cutoff de Round 1, \(\mu_s^{R1}\), é dado por uma solução analítica por casos. Se \(\mu_s^{R1}<\mu_s^{R2}\), então \(\mu_s^{R1}\) é a única raiz positiva de
> \[
> (N-2)\beta(1-\alpha)\mu^2 + \Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu - \beta(r-1)=0.
> \]
> Se \(\mu_s^{R1}>\mu_s^{R2}\), então \(\mu_s^{R1}\) é a única raiz em \((0,1)\) de
> \[
> (N-2)\beta(r-1)\mu^2 + \big[\beta(N-1+r)-rN\big]\mu + \beta(r-1)=0.
> \]
> Neste segundo caso, \(\mu_s^{R1}\) independe de \(\alpha\).

Se você quiser uma frase interpretativa logo depois da proposição, eu colocaria algo como:

> O fato central é que, quando o cutoff de R1 cai à direita do kink de R2, o nível da outside option do hegemon desaparece da condição marginal do proposer fraco. Nesse regime, a decisão entre screening e pooling depende apenas do gap entre tipos, da paciência estratégica e do tamanho da instituição.

---

## 10. Código R

```r
cutoff_R1 <- function(alpha, r, beta, N) {
  stopifnot(r > 1, beta > 0, beta < 1, N >= 3, alpha > 0, alpha < 1/r)

  mu_R2 <- alpha * (r - 1) / (r - alpha)

  # Caso 2 candidate
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  mu_H <- (phi - sqrt(phi^2 - 4 * (N - 2))) / (2 * (N - 2))

  # fronteira em alpha equivalente a mu_H > mu_R2
  alpha_bar <- r * mu_H / (r - 1 + mu_H)

  if (alpha < alpha_bar) {
    return(list(case = 2, mu_R1 = mu_H, mu_R2 = mu_R2,
                alpha_bar = alpha_bar))
  }

  # Caso 1 candidate
  bL <- r * N - beta * (N - 1 + r + (N - 2) * alpha * (r - 1))
  discL <- bL^2 + 4 * (N - 2) * beta^2 * (1 - alpha) * (r - 1)
  mu_L <- (-bL + sqrt(discL)) / (2 * (N - 2) * beta * (1 - alpha))

  list(case = 1, mu_R1 = mu_L, mu_R2 = mu_R2,
       alpha_bar = alpha_bar)
}
```

---

## 11. Recomendação de uso no paper

Eu faria assim:

- **texto principal:** apenas a proposição por casos, destacando a independência de \(\alpha\) no Caso 2;
- **apêndice:** a derivação algébrica detalhada e a condição \(\alpha<\bar\alpha\);
- **figura ou tabela:** mostrar a fronteira entre Caso 1 e Caso 2 em função de \((r,\beta,N)\), se isso ajudar a leitura substantiva.

O ponto com maior valor teórico, para mim, é este: **no regime relevante em que o cutoff de R1 está à direita do kink de R2, o screening cutoff de R1 é robusto ao nível da outside option do hegemon**. Isso é bem mais interessante do que apenas dizer que “há solução fechada”.
