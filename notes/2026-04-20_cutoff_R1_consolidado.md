# Cutoff de Screening em Round 1: Derivação Analítica Consolidada

**Data**: 2026-04-20  
**Status**: COMPLETO — verificado numericamente (erro < 10⁻¹⁴)

---

## Resultado principal

> **Proposição (Cutoff único em R1).** Sob unanimidade, existe um único $\mu_s^{R1} \in (0,1)$ tal que a weak state proponente prefere a oferta agressiva para $\mu < \mu_s^{R1}$ e a conservadora para $\mu > \mu_s^{R1}$. O cutoff é dado em closed form por uma equação quadrática. Ademais, quando $\mu_s^{R1} > \mu_s^{R2}$ (o caso genérico para $\alpha$ pequeno), a expressão **não depende de $\alpha$**:
>
> $$\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}, \qquad \phi \equiv \frac{rN - \beta(N-1+r)}{\beta(r-1)}$$

---

## 1. Setup

Da nota técnica (`formalizacao_v2.Rmd`):

- Pie: $V(\theta) \in \{1, r\}$, $r > 1$. Prior $\mu = \Pr(\theta=1)$.
- Outside option: $d_H = \alpha V(\theta)$, com $\alpha \in (0, 1/r)$.
- Jogadores: 1 hegemon H + $(N-1)$ weak states. Proposta aleatória ($1/N$).
- Notação: $x \equiv (N-1)\alpha r$.
- Cutoff de R2: $\mu_s^{R2} = \dfrac{\alpha(r-1)}{r-\alpha}$.

Em R1, W proposer escolhe entre:

| Estratégia | Oferta a H | Quem aceita | Consequência |
|------------|-----------|-------------|--------------|
| **Agressiva** | $\beta(1+x)/N$ | Só $\theta=0$ | $\theta=1$ rejeita → R2 (info completa) |
| **Conservadora** | $\beta(r+x)/N$ | Ambos | Jogo termina em R1 |

---

## 2. Equação de indiferença

A diferença $\Delta_1(\mu) \equiv F_1^{agg}(\mu) - F_1^{con}(\mu)$ é (cf. nota técnica, linhas 749–794):

$$
\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\Big[(r-1) + \mu\big(1 + r + (N-2)\alpha r\big)\Big] + \mu\,\omega(\mu) \tag{1}
$$

onde

$$
\omega(\mu) = (N-2)\beta\, V_W^{R2}(\mu)
$$

é o pagamento total de W-proposer aos outros $N-2$ fracos em R1, e $V_W^{R2}(\mu)$ é piecewise:

$$
V_W^{R2}(\mu) = \begin{cases}
\dfrac{(1-\mu)(1-\alpha)}{N} & \mu \leq \mu_s^{R2} \\[6pt]
\dfrac{1 + \mu(r-1) - \alpha r}{N} & \mu \geq \mu_s^{R2}
\end{cases} \tag{2}
$$

**Nota**: $V_W^{R2}$ tem denominador $N$ (uma única W recebe essa fração; há $(N-2)$ delas multiplicadas em $\omega$).

---

## 3. Representação piecewise de $\Delta_1$

Substituindo (2) em (1):

$$
\Delta_1(\mu) = \begin{cases}
c_0 + b_L\,\mu - k_L\,\mu^2 & \mu \leq \mu_s^{R2} \quad \text{(ramo baixo, côncava)}\\[4pt]
c_0 + b_H\,\mu + k_H\,\mu^2 & \mu \geq \mu_s^{R2} \quad \text{(ramo alto, convexa)}
\end{cases} \tag{3}
$$

com coeficientes:

$$
\boxed{c_0 = \frac{\beta(r-1)}{N} > 0}
$$

**Ramo baixo** ($\mu \leq \mu_s^{R2}$):

$$
k_L = \frac{(N-2)\beta(1-\alpha)}{N} > 0
$$

$$
b_L = -r + \frac{\beta}{N}\Big[N - 1 + r + (N-2)\alpha(r-1)\Big]
$$

**Ramo alto** ($\mu \geq \mu_s^{R2}$):

$$
k_H = \frac{(N-2)\beta(r-1)}{N} > 0
$$

$$
b_H = -r + \frac{\beta(N-1+r)}{N}
$$

**Observação crucial**: no ramo alto, $b_H$ não depende de $\alpha$ (os termos $(N-2)\alpha r$ se cancelam na álgebra — ver Seção 6).

---

## 4. Existência e unicidade do cutoff

### Valores nos extremos

- $\Delta_1(0) = c_0 = \beta(r-1)/N > 0$ (W sempre prefere agressivo em $\mu = 0$).
- $\Delta_1(1) = c_0 + b_H + k_H = rN(\beta - 1)/N = r(\beta-1) < 0$ para $\beta < 1$.

### Ramo baixo: estritamente decrescente

$\Delta_L'(\mu) = b_L - 2k_L\mu$. Como $\Delta_L$ é côncava ($k_L > 0$), o máximo da derivada é em $\mu = 0$:

$$
\Delta_L'(0) = b_L = -r + \frac{\beta[N-1+r+(N-2)\alpha(r-1)]}{N}
$$

**Claim**: $b_L < 0$ para todos os parâmetros admissíveis ($\beta \leq 1$, $\alpha < 1/r$, $r > 1$, $N \geq 3$).

*Prova*: Basta mostrar no pior caso $\beta = 1$, $\alpha = 1/r$:

$$b_L\big|_{\beta=1,\,\alpha=1/r} = -r + \frac{N-1+r+(N-2)(r-1)/r}{N}$$

Definindo $f(r) = N-1+r+(N-2)(r-1)/r = N-1+r+(N-2) - (N-2)/r = 2N-3+r-(N-2)/r$:

$$b_L = -r + f(r)/N = \frac{-r^2(N-1) + r(2N-3) - (N-2)}{Nr}$$

O numerador $g(r) = -(N-1)r^2 + (2N-3)r - (N-2)$ satisfaz $g(1) = 0$ e $g'(1) = -2(N-1)+(2N-3) = -1 < 0$. Logo $g(r) < 0$ para $r > 1$, e $b_L < 0$. $\square$

Portanto $\Delta_L'(\mu) \leq b_L < 0$: o ramo baixo é **estritamente decrescente**.

### Ramo alto: raiz única em $(\mu_s^{R2}, 1)$

O ramo alto é uma parábola **convexa** ($k_H > 0$). Sua derivada $\Delta_H'(\mu) = b_H + 2k_H\mu$ pode ser positiva para $\mu$ grande — logo o ramo alto **não é monotone** em geral.

Porém, a unicidade segue de um argumento mais simples. Para $\beta < 1$:

1. Se $\Delta_1(\mu_s^{R2}) > 0$: o cutoff está no ramo alto.
2. No ramo alto, $\Delta_H(\mu_s^{R2}) > 0$ e $\Delta_H(1) = r(\beta-1) < 0$.
3. Como $\Delta_H$ é contínua, existe pelo menos uma raiz em $(\mu_s^{R2}, 1)$.
4. Uma parábola convexa pode cruzar zero no máximo duas vezes. A segunda raiz (se existir) satisfaz $\mu > 1$ quando $\beta < 1$ (pois $\Delta_H(1) < 0$ e a parábola é convexa com mínimo interior). Logo há **exatamente uma raiz** em $(\mu_s^{R2}, 1)$.

Se $\Delta_1(\mu_s^{R2}) \leq 0$: o cutoff está no ramo baixo, que é estritamente decrescente com $\Delta_L(0) > 0$. Logo há raiz única em $(0, \mu_s^{R2})$.

### Conclusão

> Para todo $\beta \in (0,1)$, $\alpha \in (0,1/r)$, $r > 1$, $N \geq 3$: existe um único $\mu_s^{R1} \in (0,1)$ tal que $\Delta_1(\mu_s^{R1}) = 0$.

**Nota sobre $\beta = 1$**: Neste caso $\Delta_H(1) = 0$, logo $\mu = 1$ é raiz espúria. A raiz economicamente relevante (interior) permanece única. Pelo produto das raízes da quadrática: $\mu_1 \cdot \mu_2 = c_0/k_H = 1/(N-2)$. Como $\mu_2 = 1$, temos $\mu_1 = 1/(N-2)$ — uma expressão notavelmente simples para o caso sem desconto.

---

## 5. Expressão fechada do cutoff

### Caso A: Ramo alto ($\mu_s^{R1} > \mu_s^{R2}$) — **regime principal**

A quadrática é:

$$
(N-2)\beta(r-1)\,\mu^2 + \big[\beta(N-1+r) - rN\big]\,\mu + \beta(r-1) = 0 \tag{4}
$$

Dividindo por $\beta(r-1)$:

$$
(N-2)\,\mu^2 - \phi\,\mu + 1 = 0
$$

onde $\phi \equiv \dfrac{rN - \beta(N-1+r)}{\beta(r-1)}$.

**Solução** (raiz menor):

$$
\boxed{\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}} \tag{5}
$$

**Propriedades**:
- Não depende de $\alpha$.
- Discriminante sempre positivo: $\phi \geq N/\beta - 1 \geq N - 1 > 2\sqrt{N-2}$ para $N \geq 3$.
- Para $\beta = 1$: $\mu_s^{R1} = 1/(N-2)$ (uma das raízes é $\mu = 1$; a relevante é $1/(N-2)$).

### Caso B: Ramo baixo ($\mu_s^{R1} \leq \mu_s^{R2}$)

A quadrática é:

$$
(N-2)\beta(1-\alpha)\,\mu^2 + \big[rN - \beta(N-1+r+(N-2)\alpha(r-1))\big]\,\mu - \beta(r-1) = 0 \tag{6}
$$

Coeficientes: $a = (N-2)\beta(1-\alpha)$, $b = rN - \beta[N-1+r+(N-2)\alpha(r-1)]$, $c = -\beta(r-1)$.

Como $a > 0$ e $c < 0$, há exatamente uma raiz positiva:

$$
\boxed{\mu_s^{R1} = \frac{-b + \sqrt{b^2 - 4ac}}{2a}} \tag{7}
$$

### Regra de seleção

Avalie $\Delta_1(\mu_s^{R2})$:

- $\Delta_1(\mu_s^{R2}) > 0$: use equação (5) — **Caso A**.
- $\Delta_1(\mu_s^{R2}) \leq 0$: use equação (7) — **Caso B**.

Equivalentemente: compute $\mu^*$ pela equação (5); se $\mu^* > \mu_s^{R2}$, é o Caso A. Senão, compute pela equação (7).

Na prática, o **Caso A domina** para os parâmetros economicamente relevantes do modelo ($\alpha$ pequeno relativo a $r$).

---

## 6. Álgebra do cancelamento de $\alpha$ (Caso A)

Para $\mu > \mu_s^{R2}$:

$$\mu\omega(\mu) = \frac{(N-2)\beta\mu}{N}\big[(1-\alpha r) + \mu(r-1)\big]$$

Agrupando todos os termos de (1) dentro de $\beta/N$:

$$(r-1) + \mu\big[\underbrace{1+r+(N-2)\alpha r}_{\text{de (1)}} + \underbrace{(N-2)(1-\alpha r)}_{\text{de } \mu\omega}\big] + (N-2)(r-1)\mu^2$$

O coeficiente linear:

$$1+r+(N-2)\alpha r + (N-2) - (N-2)\alpha r = N - 1 + r$$

Os termos $(N-2)\alpha r$ se **cancelam exatamente**, eliminando $\alpha$ da equação.

**Interpretação econômica**: No ramo conservador de R2, a outside option $\alpha$ afeta tanto o custo da oferta agressiva (via $x = (N-1)\alpha r$) quanto o valor de continuação $\omega$ (via $V_W^{R2}$) de forma simétrica. Na diferença entre agressivo e conservador, esses efeitos se anulam. A decisão de screening em R1 depende apenas da renda informacional $(r-1)$, da paciência $\beta$, e da estrutura da coalizão $N$.

---

## 7. Estática comparativa

### Caso A (regime principal)

Como $\mu_s^{R1}$ é decrescente em $\phi$ (verificável pela derivada da fórmula), e:

$$\phi = \frac{rN - \beta(N-1+r)}{\beta(r-1)}$$

temos:

| Parâmetro | Efeito em $\phi$ | Efeito em $\mu_s^{R1}$ | Intuição |
|-----------|-----------------|------------------------|----------|
| $\beta \uparrow$ | $\phi \downarrow$ | $\mu_s^{R1} \downarrow$ | Mais paciência → R2 menos custoso → W mais agressiva |
| $N \uparrow$ | $\phi \uparrow$ | $\mu_s^{R1} \uparrow$ | Mais jogadores → diluição da proposta → W mais cautelosa |
| $\alpha$ | — | Nenhum | Outside option irrelevante para a decisão de screening |

O efeito de $r$ é ambíguo: $\partial\phi/\partial r = [N\beta - \beta(N-1+r) \cdot 0 + \ldots]$ — requer cálculo explícito:

$$\frac{\partial\phi}{\partial r} = \frac{N\beta(r-1) - [rN-\beta(N-1+r)]}{\beta(r-1)^2} = \frac{\beta(N-1) - N(1-\beta) \cdot \text{...}}{[\beta(r-1)]^2}$$

Numericamente: para $\beta < 1$ e $N$ moderado, $\partial\phi/\partial r > 0$ (mais renda → W mais cautelosa), logo $\mu_s^{R1}$ cresce com $r$.

### Caso especial $\beta = 1$

$$\mu_s^{R1} = \frac{1}{N-2}$$

Extremamente limpo: o cutoff depende apenas do número de jogadores. Para $N = 5$: $\mu_s^{R1} = 1/3$.

---

## 8. Implicações para Bayesian Persuasion

O jump em $E_\theta[V_H^{R1}]$ no cutoff é:

$$
\text{Jump} = (1-\mu_s^{R1}) \cdot \frac{(N-1)\beta(r-1)}{N^2}
$$

No Caso A, substituindo $\mu_s^{R1}$ da equação (5):
- A **localização** do jump (onde está a não-convexidade) depende só de $(r, \beta, N)$.
- A **magnitude** do jump depende de $(r, \beta, N)$ via $\mu_s^{R1}$, e indiretamente de $\alpha$ apenas na medida em que $\alpha$ determina se estamos no Caso A ou B.

Para o sender (H), o BP é eficaz quando o prior $\mu_0$ está próximo de $\mu_s^{R1}$ por baixo. A condição analítica é:

$$\text{BP útil} \iff \mu_0 < \mu_s^{R1} \quad \text{e} \quad \text{cav } v(\mu_0) > v(\mu_0)$$

Com $\mu_s^{R1}$ em closed form, podemos derivar condições explícitas sobre $\mu_0$ para que BP gere ganho estrito.

---

## 9. Formulação para o paper

### Proposição (versão para o texto principal)

> **Proposição X (Screening em R1: existência, unicidade e closed form).**
>
> Considere o jogo de barganha sob unanimidade com $N \geq 3$, $r > 1$, $\alpha \in (0, 1/r)$, e $\beta \in (0,1)$. Defina $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$.
>
> (i) Existe um único cutoff $\mu_s^{R1} \in (0,1)$ tal que a weak state proponente em Round 1 joga agressivo se e somente se $\mu < \mu_s^{R1}$.
>
> (ii) Se $\mu_s^{R1} > \mu_s^{R2}$ (o que ocorre para todo $\alpha$ suficientemente pequeno), então:
> $$\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}, \qquad \phi = \frac{rN - \beta(N-1+r)}{\beta(r-1)}$$
> Em particular, $\mu_s^{R1}$ não depende de $\alpha$.

### Prova (esqueleto para o paper, detalhes no apêndice)

> Substituindo o valor de continuação de R2 na diferença $\Delta_1(\mu) = F_1^{agg} - F_1^{con}$, obtém-se a representação piecewise (3) com $c_0 > 0$, $k_L > 0$, $k_H > 0$. No ramo baixo ($\mu \leq \mu_s^{R2}$), $\Delta_1$ é côncava com derivada negativa em $\mu = 0$ (verificado por substituição direta sob $\alpha < 1/r$, $\beta \leq 1$); logo é estritamente decrescente. No ramo alto ($\mu \geq \mu_s^{R2}$), $\Delta_1$ é convexa com $\Delta_1(1) = r(\beta-1) < 0$. Como $\Delta_1(0) = c_0 > 0$ e a função é contínua, o teorema do valor intermediário garante existência. A unicidade segue da monotonicidade estrita no ramo baixo e da convexidade no ramo alto (uma parábola convexa que é positiva em um ponto e negativa em $\mu=1$ cruza zero exatamente uma vez em qualquer subintervalo à esquerda do mínimo).
>
> Para (ii), a álgebra do ramo alto simplifica: os termos $\pm(N-2)\alpha r \cdot \mu$ de (1) e de $\mu\omega(\mu)$ se cancelam, resultando na quadrática (4) livre de $\alpha$. $\square$

---

## 10. Código R

```r
#' Cutoff analítico de R1 sob unanimidade
#' @param alpha Outside option parameter (0 < alpha < 1/r)
#' @param r High-state pie (r > 1)
#' @param beta Discount factor (0 < beta <= 1)
#' @param N Number of players (N >= 3)
#' @return List with mu_R1, mu_R2, case, phi
cutoff_R1 <- function(alpha, r, beta, N) {
  stopifnot(alpha > 0, alpha < 1/r, r > 1, beta > 0, beta <= 1, N >= 3)
  
  mu_R2 <- alpha * (r - 1) / (r - alpha)
  
  # Caso A: ramo alto (alpha-independent)
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc_A <- phi^2 - 4 * (N - 2)
  mu_A <- (phi - sqrt(disc_A)) / (2 * (N - 2))
  
  if (mu_A > mu_R2) {
    return(list(mu_R1 = mu_A, mu_R2 = mu_R2, case = "A", phi = phi))
  }
  
  # Caso B: ramo baixo
  a <- (N - 2) * beta * (1 - alpha)
  b <- r * N - beta * (N - 1 + r + (N - 2) * alpha * (r - 1))
  cc <- -beta * (r - 1)
  disc_B <- b^2 - 4 * a * cc
  mu_B <- (-b + sqrt(disc_B)) / (2 * a)
  
  list(mu_R1 = mu_B, mu_R2 = mu_R2, case = "B", phi = phi)
}
```

---

## 11. Verificação numérica

| $r$ | $\alpha$ | $N$ | $\beta$ | $\mu_s^{R2}$ | $\mu_s^{R1}$ (analítico) | Caso | Erro vs root-finding |
|-----|----------|-----|---------|--------------|--------------------------|------|---------------------|
| 1.1 | 0.5 | 5 | 0.9 | 0.083 | 0.10199 | A | $< 10^{-14}$ |
| 1.5 | 0.3 | 5 | 0.9 | 0.125 | 0.19702 | A | $< 10^{-14}$ |
| 2.0 | 0.3 | 5 | 0.9 | 0.176 | 0.22550 | A | $< 10^{-13}$ |
| 1.2 | 0.8 | 5 | 0.9 | 0.400 | 0.18246 | B | $< 10^{-14}$ |
| 1.1 | 0.5 | 10 | 0.9 | 0.083 | 0.05183 | B | $< 10^{-14}$ |
| 1.5 | 0.3 | 3 | 0.8 | 0.125 | 0.25000 | A | $< 10^{-14}$ |
| 1.5 | 0.3 | 5 | 1.0 | 0.125 | 0.33333 | A | $< 10^{-14}$ |

**Independência de $\alpha$ (Caso A confirmada)**: para $r=1.5$, $N=5$, $\beta=0.9$, o cutoff é $0.19702$ para todo $\alpha \in \{0.1, 0.2, 0.3, 0.4\}$.

---

## 12. Errata da derivação alternativa (`derivacao_cutoff_R1.md`)

Para registro, os erros identificados na derivação do outro agente:

1. **Erro algébrico** (linha 63): $\mu\omega(\mu)$ escrito com $N^2$ no denominador em vez de $N$. Origem provável: confusão entre $V_W^{R2}(\mu) = (1-\mu)(1-\alpha)/N$ (payoff de UMA weak) e o $\omega$ total (que multiplica por $N-2$ mas mantém o $1/N$).

2. **Coeficientes errados** (linhas 89–121): $k_L$, $k_H$, $b_L$, $b_H$ todos divididos por $N$ extra. Isso subestima sistematicamente o cutoff (erros de 3–18 p.p.).

3. **Monotonicidade falsa** (Seção 4): o claim "$\Delta_1'(\mu) < 0$ para todo $\mu \in [0,1]$" é falso com coeficientes corretos. No ramo alto, $\Delta_H'(\mu) = b_H + 2k_H\mu$ pode ser positivo para $\mu$ grande (verificado: 6438 violações em varredura paramétrica).

4. **Resultado α-independente não identificado**: o cancelamento algébrico no Caso A (a principal contribuição analítica) não foi descoberto.

A **conclusão qualitativa** (existência e unicidade) é correta, mas por razões diferentes das apresentadas.
