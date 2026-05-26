# Cutoff de Screening em Round 1 sob unanimidade: nota final consolidada

**Data:** 2026-04-20  
**Status:** versão consolidada final

## 1. Objetivo

Queremos caracterizar o cutoff de Round 1, \(\mu_s^{R1}\), no problema em que uma weak state proponente \(W\), sob unanimidade, escolhe entre:

- **oferta agressiva**: barata, aceita apenas por \(\theta=0\);
- **oferta conservadora**: cara, aceita por ambos os tipos.

A equação de indiferença da nota técnica é

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu\bigl(1+r+(N-2)\alpha r\bigr)\Big] + \mu\omega(\mu),
\]

onde

\[
\omega(\mu)=(N-2)\beta V_W^{R2}(\mu).
\]

O problema é que \(V_W^{R2}(\mu)\) é piecewise, com kink em

\[
\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}.
\]

A conclusão desta nota é:

1. \(\mu_s^{R1}\) tem **solução analítica fechada por casos**;
2. existe um **único** cutoff interior relevante;
3. quando \(\mu_s^{R1}>\mu_s^{R2}\), a expressão de \(\mu_s^{R1}\) é **independente de \(\alpha\)**;
4. a fronteira entre os casos pode ser escrita explicitamente como uma condição sobre \(\alpha\).

---

## 2. Continuação de R2

Da nota técnica,

\[
V_W^{R2}(\mu)=
\begin{cases}
\dfrac{(1-\mu)(1-\alpha)}{N}, & \mu\le \mu_s^{R2},\\[1em]
\dfrac{1+\mu(r-1)-\alpha r}{N}, & \mu\ge \mu_s^{R2}.
\end{cases}
\]

Logo,

\[
\omega(\mu)=
\begin{cases}
\dfrac{(N-2)\beta(1-\mu)(1-\alpha)}{N}, & \mu\le \mu_s^{R2},\\[1em]
\dfrac{(N-2)\beta\bigl[1+\mu(r-1)-\alpha r\bigr]}{N}, & \mu\ge \mu_s^{R2}.
\end{cases}
\]

---

## 3. Representação piecewise de \(\Delta_1(\mu)\)

Substituindo \(V_W^{R2}(\mu)\) na equação de \(\Delta_1\), obtemos:

\[
\Delta_1(\mu)=
\begin{cases}
 c_0+b_L\mu-k_L\mu^2, & \mu\le \mu_s^{R2},\\[0.5em]
 c_0+b_H\mu+k_H\mu^2, & \mu\ge \mu_s^{R2},
\end{cases}
\]

com

\[
\boxed{c_0=\frac{\beta(r-1)}{N}>0.}
\]

### Ramo baixo (\(\mu\le \mu_s^{R2}\))

\[
\boxed{k_L=\frac{(N-2)\beta(1-\alpha)}{N}>0,}
\]

\[
\boxed{b_L=-r+\frac{\beta}{N}\Big[N-1+r+(N-2)\alpha(r-1)\Big].}
\]

### Ramo alto (\(\mu\ge \mu_s^{R2}\))

\[
\boxed{k_H=\frac{(N-2)\beta(r-1)}{N}>0,}
\]

\[
\boxed{b_H=-r+\frac{\beta(N-1+r)}{N}.}
\]

A ausência de \(\alpha\) em \(b_H\) é o primeiro sinal do cancelamento algébrico do ramo alto.

---

## 4. Caso 1: \(\mu_s^{R1}\le \mu_s^{R2}\)

Neste caso, a raiz relevante está no ramo baixo:

\[
\Delta_L(\mu)=c_0+b_L\mu-k_L\mu^2.
\]

Igualando a zero e multiplicando por \(N\):

\[
(N-2)\beta(1-\alpha)\mu^2
+
\Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu
-\beta(r-1)=0.
\]

Portanto,

\[
\boxed{
(N-2)\beta(1-\alpha)\mu^2
+
\Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu
-\beta(r-1)=0.
}
\]

Definindo

\[
B_L \equiv rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr),
\]

a raiz positiva é

\[
\boxed{
\mu_L^*=
\frac{-B_L+\sqrt{B_L^2+4(N-2)\beta^2(1-\alpha)(r-1)}}{2(N-2)\beta(1-\alpha)}.
}
\]

Essa expressão vale quando \(\mu_L^*\le \mu_s^{R2}\).

---

## 5. Caso 2: \(\mu_s^{R1}>\mu_s^{R2}\)

Agora a raiz relevante está no ramo alto:

\[
\Delta_H(\mu)=c_0+b_H\mu+k_H\mu^2.
\]

Substituindo explicitamente o ramo alto de \(\omega(\mu)\):

\[
\Delta_1(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu(1+r+(N-2)\alpha r)\Big]
+ \frac{(N-2)\beta\mu\bigl[1+\mu(r-1)-\alpha r\bigr]}{N}.
\]

Agrupando os termos lineares em \(\mu\):

\[
1+r+(N-2)\alpha r+(N-2)(1-\alpha r)=N-1+r.
\]

Os termos em \(\alpha\) se cancelam exatamente. Assim,

\[
\Delta_H(\mu)
= -\mu r + \frac{\beta}{N}\Big[(r-1)+\mu(N-1+r)+(N-2)(r-1)\mu^2\Big].
\]

Igualando a zero e multiplicando por \(N\):

\[
(N-2)\beta(r-1)\mu^2 + \big[\beta(N-1+r)-rN\big]\mu + \beta(r-1)=0.
\]

Portanto,

\[
\boxed{
(N-2)\beta(r-1)\mu^2 + \big[\beta(N-1+r)-rN\big]\mu + \beta(r-1)=0.
}
\]

Defina

\[
\phi \equiv \frac{rN-\beta(N-1+r)}{\beta(r-1)}.
\]

Então a equação se reduz a

\[
(N-2)\mu^2-\phi\mu+1=0,
\]

e a raiz interior relevante é

\[
\boxed{
\mu_H^*=rac{\phi-\sqrt{\phi^2-4(N-2)}}{2(N-2)}.
}
\]

Essa fórmula depende apenas de \((r,\beta,N)\) e **não depende de \(\alpha\)**.

---

## 6. Existência e unicidade

### 6.1. Valores nos extremos

Temos sempre

\[
\Delta_1(0)=\frac{\beta(r-1)}{N}>0.
\]

No ramo alto,

\[
\Delta_H(1)=r(\beta-1)<0
\qquad \text{para } \beta<1.
\]

Portanto, existe ao menos uma raiz interior relevante.

### 6.2. O ramo baixo é estritamente decrescente

A derivada no ramo baixo é

\[
\Delta_L'(\mu)=b_L-2k_L\mu.
\]

Como \(k_L>0\), o valor máximo da derivada ocorre em \(\mu=0\). Basta então mostrar que \(b_L<0\).

Como \(b_L\) é crescente em \(\beta\) e em \(\alpha\), o pior caso é \(\beta=1\) e \(\alpha=1/r\). Nesse caso,

\[
b_L\big|_{\beta=1,\,\alpha=1/r}
= -r+\frac{N-1+r+(N-2)(r-1)/r}{N}.
\]

Colocando tudo sobre o mesmo denominador,

\[
 b_L\big|_{\beta=1,\,\alpha=1/r}
 = \frac{-(N-1)r^2+(2N-3)r-(N-2)}{Nr}.
\]

Defina

\[
g(r)=-(N-1)r^2+(2N-3)r-(N-2).
\]

Temos

\[
g(1)=0,
\qquad
 g'(1)=-2(N-1)+(2N-3)=-1<0.
\]

Logo, para todo \(r>1\), vale \(g(r)<0\), e portanto

\[
b_L<0.
\]

Concluímos que

\[
\Delta_L'(\mu)\le b_L<0,
\]

isto é, o ramo baixo é **estritamente decrescente**.

### 6.3. Unicidade no ramo alto

No ramo alto, \(\Delta_H\) é convexa. Não precisamos provar monotonicidade global. Basta notar:

- se \(\Delta_1(\mu_s^{R2})\le 0\), então a raiz relevante está no ramo baixo, e a monotonicidade estrita do ramo baixo garante unicidade;
- se \(\Delta_1(\mu_s^{R2})>0\), então a raiz relevante está no ramo alto.

Neste segundo caso, como \(\Delta_H(\mu_s^{R2})>0\) e \(\Delta_H(1)<0\), existe uma raiz em \((\mu_s^{R2},1)\). Como \(\Delta_H\) é uma parábola convexa, essa raiz em \((\mu_s^{R2},1)\) é única. A eventual segunda raiz, quando existe, está fora do intervalo relevante.

### 6.4. Conclusão

> **Proposição.** Para todo \(N\ge 3\), \(r>1\), \(\alpha\in(0,1/r)\) e \(\beta\in(0,1)\), existe um único cutoff interior relevante \(\mu_s^{R1}\in(0,1)\) tal que \(W\) prefere a oferta agressiva para \(\mu<\mu_s^{R1}\) e a conservadora para \(\mu>\mu_s^{R1}\).

---

## 7. Regra de seleção e fronteira explícita em \(\alpha\)

### Método 1: avaliação no kink

Avalie \(\Delta_1(\mu_s^{R2})\):

- se \(\Delta_1(\mu_s^{R2})>0\), a raiz está à direita do kink: use \(\mu_H^*\);
- se \(\Delta_1(\mu_s^{R2})\le 0\), a raiz está à esquerda do kink: use \(\mu_L^*\).

### Método 2: condição explícita sobre \(\alpha\)

Como no Caso 2 a raiz \(\mu_H^*\) independe de \(\alpha\), a condição de consistência

\[
\mu_H^*>\mu_s^{R2}=\frac{\alpha(r-1)}{r-\alpha}
\]

equivale a

\[
\boxed{
\alpha<\bar\alpha(r,\beta,N)
\equiv
\frac{r\mu_H^*}{r-1+\mu_H^*}.
}
\]

Portanto:

- se \(\alpha<\bar\alpha(r,\beta,N)\), vale o **Caso 2**;
- se \(\alpha>\bar\alpha(r,\beta,N)\), vale o **Caso 1**;
- se \(\alpha=\bar\alpha(r,\beta,N)\), estamos na fronteira \(\mu_s^{R1}=\mu_s^{R2}\).

Essa formulação é preferível a dizer apenas “\(\alpha\) pequeno”.

---

## 8. Estática comparativa no Caso 2

No Caso 2,

\[
\mu_H^*=rac{\phi-\sqrt{\phi^2-4(N-2)}}{2(N-2)},
\qquad
\phi=\frac{rN-\beta(N-1+r)}{\beta(r-1)}.
\]

Temos

\[
\frac{\partial \phi}{\partial \beta}=-\frac{Nr}{\beta^2(r-1)}<0,
\qquad
\frac{\partial \phi}{\partial r}=\frac{N(\beta-1)}{\beta(r-1)^2}<0,
\qquad
\frac{\partial \phi}{\partial N}=\frac{r-\beta}{\beta(r-1)}>0.
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

- **\(\beta\uparrow\)**: rejeição em R1 fica menos custosa, então \(W\) tolera crenças mais altas antes de abandonar screening; o cutoff sobe;
- **\(r\uparrow\)**: o ganho informacional de distinguir tipos cresce; o cutoff sobe;
- **\(N\uparrow\)**: o ganho privado do proposer se dilui; o cutoff cai.

Esses sinais valem no Caso 2. No Caso 1, a expressão existe, mas a estática comparativa é mais suja e não merece entrar no texto principal salvo necessidade substantiva forte.

---

## 9. Caso especial \(\beta=1\)

Embora o paper trabalhe com \(\beta\in(0,1)\), vale registrar o limite sem desconto.

No Caso 2, a equação vira

\[
(N-2)\mu^2-(N-1)\mu+1=0.
\]

Uma raiz é \(\mu=1\); a raiz interior relevante é

\[
\boxed{\mu_s^{R1}=\frac{1}{N-2}.}
\]

Esse caso-limite é útil como check algébrico.

---

## 10. Formulação pronta para o paper

### Proposição

> **Proposição X (cutoff de screening em R1).** Sob unanimidade, existe um único cutoff interior relevante \(\mu_s^{R1}\in(0,1)\) tal que a weak state proponente em Round 1 joga agressivo se, e somente se, \(\mu<\mu_s^{R1}\). Se \(\mu_s^{R1}\le \mu_s^{R2}\), então \(\mu_s^{R1}\) é a única raiz positiva de
> \[
> (N-2)\beta(1-\alpha)\mu^2+
> \Big[rN-\beta\bigl(N-1+r+(N-2)\alpha(r-1)\bigr)\Big]\mu
> -\beta(r-1)=0.
> \]
> Se \(\mu_s^{R1}>\mu_s^{R2}\), então \(\mu_s^{R1}\) é a única raiz em \((0,1)\) de
> \[
> (N-2)\beta(r-1)\mu^2+\big[\beta(N-1+r)-rN\big]\mu+\beta(r-1)=0.
> \]
> Neste segundo caso, \(\mu_s^{R1}\) independe de \(\alpha\).

### Frase interpretativa sugerida

> O ponto central é que, quando o cutoff de R1 cai à direita do kink de R2, o nível da outside option do hegemon desaparece da condição marginal do proposer fraco. Nesse regime, a decisão entre screening e pooling depende apenas do gap entre tipos, da paciência estratégica e do tamanho da instituição.

---

## 11. Código R

```r
cutoff_R1 <- function(alpha, r, beta, N) {
  stopifnot(alpha > 0, alpha < 1/r, r > 1, beta > 0, beta <= 1, N >= 3)

  mu_R2 <- alpha * (r - 1) / (r - alpha)

  # Caso 2 candidate
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc_H <- phi^2 - 4 * (N - 2)
  mu_H <- (phi - sqrt(disc_H)) / (2 * (N - 2))

  # fronteira explícita em alpha
  alpha_bar <- r * mu_H / (r - 1 + mu_H)

  if (alpha < alpha_bar) {
    return(list(case = 2,
                mu_R1 = mu_H,
                mu_R2 = mu_R2,
                alpha_bar = alpha_bar,
                phi = phi))
  }

  # Caso 1
  B_L <- r * N - beta * (N - 1 + r + (N - 2) * alpha * (r - 1))
  disc_L <- B_L^2 + 4 * (N - 2) * beta^2 * (1 - alpha) * (r - 1)
  mu_L <- (-B_L + sqrt(disc_L)) / (2 * (N - 2) * beta * (1 - alpha))

  list(case = 1,
       mu_R1 = mu_L,
       mu_R2 = mu_R2,
       alpha_bar = alpha_bar,
       phi = phi)
}
```

---

## 12. Recomendação para o paper

Eu usaria a estrutura abaixo:

- **corpo principal:** proposição + interpretação do cancelamento de \(\alpha\) no Caso 2;
- **apêndice:** derivação piecewise, prova de \(b_L<0\), e condição \(\alpha<\bar\alpha(r,\beta,N)\);
- **figura opcional:** mapa da fronteira entre Caso 1 e Caso 2 em função de \((r,\beta,N)\).

O ponto substantivo realmente interessante não é apenas “há closed form”. É este:

> **No regime relevante em que \(\mu_s^{R1}>\mu_s^{R2}\), o cutoff de screening em R1 é robusto ao nível da outside option do hegemon.**

Esse é o resultado que vale a pena vender.
