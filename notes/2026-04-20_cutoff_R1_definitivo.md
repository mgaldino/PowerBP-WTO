# Cutoff de Screening em Round 1: Derivação Analítica Definitiva

**Data**: 2026-04-20  
**Status**: DEFINITIVO — merge de duas derivações independentes, verificado numericamente (erro < 10⁻¹⁴)

---

## Resultado principal

> **Proposição (Cutoff único em R1).** Sob unanimidade, existe um único $\mu_s^{R1} \in (0,1)$ tal que a weak state proponente prefere a oferta agressiva para $\mu < \mu_s^{R1}$ e a conservadora para $\mu > \mu_s^{R1}$. O cutoff é dado em closed form por uma equação quadrática. Ademais, quando $\mu_s^{R1} > \mu_s^{R2}$ (o que ocorre para $\alpha < \bar\alpha$, definido abaixo), a expressão **não depende de $\alpha$**:
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

Logo:

$$
\omega(\mu) = \begin{cases}
\dfrac{(N-2)\beta(1-\mu)(1-\alpha)}{N} & \mu \leq \mu_s^{R2} \\[6pt]
\dfrac{(N-2)\beta[1+\mu(r-1)-\alpha r]}{N} & \mu \geq \mu_s^{R2}
\end{cases}
$$

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

$$c_0 = \frac{\beta(r-1)}{N} > 0$$

**Ramo baixo** ($\mu \leq \mu_s^{R2}$):

$$k_L = \frac{(N-2)\beta(1-\alpha)}{N} > 0$$

$$b_L = -r + \frac{\beta}{N}\Big[N - 1 + r + (N-2)\alpha(r-1)\Big]$$

**Ramo alto** ($\mu \geq \mu_s^{R2}$):

$$k_H = \frac{(N-2)\beta(r-1)}{N} > 0$$

$$b_H = -r + \frac{\beta(N-1+r)}{N}$$

**Observação**: no ramo alto, $b_H$ não depende de $\alpha$ (cancelamento — ver Seção 6).

---

## 4. Existência e unicidade

### Valores nos extremos

- $\Delta_1(0) = c_0 = \beta(r-1)/N > 0$.
- $\Delta_1(1) = r(\beta - 1) < 0$ para $\beta < 1$.

### Ramo baixo: estritamente decrescente

$\Delta_L'(\mu) = b_L - 2k_L\mu$. Como $k_L > 0$, a derivada é maximizada em $\mu = 0$:

$$\Delta_L'(0) = b_L = -r + \frac{\beta[N-1+r+(N-2)\alpha(r-1)]}{N}$$

**Lema**: $b_L < 0$ para todo $\beta \leq 1$, $\alpha < 1/r$, $r > 1$, $N \geq 3$.

*Prova*: No pior caso $\beta = 1$, $\alpha = 1/r$:

$$b_L\big|_{\beta=1,\,\alpha=1/r} = \frac{-(N-1)r^2 + (2N-3)r - (N-2)}{Nr}$$

O numerador $g(r) = -(N-1)r^2 + (2N-3)r - (N-2)$ satisfaz $g(1) = 0$ e $g'(1) = -1 < 0$. Como o coeficiente líder é negativo, $g(r) < 0$ para todo $r > 1$. $\square$

Logo $\Delta_L'(\mu) \leq b_L < 0$: o ramo baixo é **estritamente decrescente**.

### Ramo alto: raiz única em $(\mu_s^{R2}, 1)$

O ramo alto é uma parábola **convexa** ($k_H > 0$). Sua derivada $\Delta_H'(\mu) = b_H + 2k_H\mu$ pode ser positiva para $\mu$ grande — o ramo alto **não é monotone** em geral.

A unicidade segue sem monotonicidade. Para $\beta < 1$:

1. Se $\Delta_1(\mu_s^{R2}) > 0$ (cutoff no ramo alto): temos $\Delta_H(\mu_s^{R2}) > 0$ e $\Delta_H(1) = r(\beta-1) < 0$.
2. Como $\Delta_H$ é contínua, existe pelo menos uma raiz em $(\mu_s^{R2}, 1)$.
3. Para a unicidade: $\Delta_H(\mu) = k_H\mu^2 + b_H\mu + c_0$ é convexa. O conjunto $\{\mu : \Delta_H(\mu) \leq 0\}$ é um intervalo (propriedade de funções convexas). Como $\Delta_H(\mu_s^{R2}) > 0$ (fora do conjunto) e $\Delta_H(1) < 0$ (dentro), a fronteira esquerda desse intervalo — i.e., a primeira raiz — é o único ponto em $(\mu_s^{R2}, 1)$ onde $\Delta_H$ cruza zero de cima para baixo. Logo a raiz é **única**.

Se $\Delta_1(\mu_s^{R2}) \leq 0$: o cutoff está no ramo baixo, que é estritamente decrescente com $\Delta_L(0) > 0$. Raiz única em $(0, \mu_s^{R2})$.

### Caso $\beta = 1$

Neste caso $\Delta_H(1) = 0$, e $\mu = 1$ é raiz. Pelo produto das raízes da quadrática do Caso 2: $\mu_1 \cdot \mu_2 = 1/(N-2)$. Como $\mu_2 = 1$:

$$\mu_s^{R1}\big|_{\beta=1} = \frac{1}{N-2}$$

Uma expressão notavelmente simples.

---

## 5. Expressão fechada

### Caso 2: Ramo alto ($\mu_s^{R1} > \mu_s^{R2}$) — regime principal

A quadrática é:

$$
(N-2)\beta(r-1)\,\mu^2 + \big[\beta(N-1+r) - rN\big]\,\mu + \beta(r-1) = 0 \tag{4}
$$

Dividindo por $\beta(r-1)$:

$$
(N-2)\,\mu^2 - \phi\,\mu + 1 = 0, \qquad \phi \equiv \frac{rN - \beta(N-1+r)}{\beta(r-1)}
$$

**Solução** (raiz menor):

$$
\boxed{\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}} \tag{5}
$$

**Propriedades**:
- Não depende de $\alpha$.
- Discriminante sempre positivo: $\phi \geq N/\beta - 1 \geq N - 1 > 2\sqrt{N-2}$ para $N \geq 3$.
- Para $\beta = 1$: $\mu_s^{R1} = 1/(N-2)$.

### Caso 1: Ramo baixo ($\mu_s^{R1} \leq \mu_s^{R2}$)

A quadrática é:

$$
(N-2)\beta(1-\alpha)\,\mu^2 + \big[rN - \beta(N-1+r+(N-2)\alpha(r-1))\big]\,\mu - \beta(r-1) = 0 \tag{6}
$$

Coeficientes: $a = (N-2)\beta(1-\alpha) > 0$, $c = -\beta(r-1) < 0$. Produto das raízes $= c/a < 0$: exatamente uma raiz positiva.

$$
\boxed{\mu_s^{R1} = \frac{-b_1 + \sqrt{b_1^2 + 4(N-2)\beta^2(1-\alpha)(r-1)}}{2(N-2)\beta(1-\alpha)}} \tag{7}
$$

com $b_1 \equiv rN - \beta[N-1+r+(N-2)\alpha(r-1)]$.

---

## 6. Cancelamento de $\alpha$ no Caso 2 (álgebra)

Para $\mu > \mu_s^{R2}$:

$$\mu\omega(\mu) = \frac{(N-2)\beta\mu}{N}\big[(1-\alpha r) + \mu(r-1)\big]$$

Agrupando todos os termos de (1) dentro de $\beta/N$:

$$(r-1) + \mu\big[\underbrace{1+r+(N-2)\alpha r}_{\text{de (1)}} + \underbrace{(N-2)(1-\alpha r)}_{\text{de } \mu\omega}\big] + (N-2)(r-1)\mu^2$$

O coeficiente linear:

$$1+r+(N-2)\alpha r + (N-2) - (N-2)\alpha r = N - 1 + r$$

Os termos $(N-2)\alpha r$ se **cancelam exatamente**, eliminando $\alpha$ da equação.

**Interpretação econômica**: No ramo conservador de R2, a outside option $\alpha$ afeta tanto o custo da oferta agressiva (via $x = (N-1)\alpha r$) quanto o valor de continuação $\omega$ (via $V_W^{R2}$) de forma simétrica. Na diferença entre agressivo e conservador, esses efeitos se anulam. A decisão de screening em R1 depende apenas da renda informacional $(r-1)$, da paciência $\beta$, e da estrutura da coalizão $N$.

---

## 7. Seleção entre casos

### Método A: sinal no kink

Avalie $\Delta_1(\mu_s^{R2})$:

- $\Delta_1(\mu_s^{R2}) > 0$ → **Caso 2** (raiz à direita do kink).
- $\Delta_1(\mu_s^{R2}) \leq 0$ → **Caso 1** (raiz à esquerda do kink).

### Método B: fronteira explícita em $\alpha$

Compute $\mu_H^*$ pela equação (5). A condição $\mu_H^* > \mu_s^{R2}$ equivale a:

$$
\alpha < \bar\alpha(r,\beta,N) \equiv \frac{r\,\mu_H^*}{r - 1 + \mu_H^*} \tag{8}
$$

Portanto:
- $\alpha < \bar\alpha$: **Caso 2** (α-independente).
- $\alpha > \bar\alpha$: **Caso 1**.
- $\alpha = \bar\alpha$: fronteira, $\mu_s^{R1} = \mu_s^{R2}$.

O Caso 2 domina para os parâmetros economicamente relevantes do modelo ($\alpha$ pequeno).

---

## 8. Estática comparativa (Caso 2)

### Derivadas analíticas

$$
\frac{\partial\phi}{\partial\beta} = -\frac{rN}{\beta^2(r-1)} < 0, \qquad
\frac{\partial\phi}{\partial r} = \frac{N(\beta-1)}{\beta(r-1)^2} < 0, \qquad
\frac{\partial\phi}{\partial N} = \frac{r-\beta}{\beta(r-1)} > 0
$$

Como $\mu_H^*$ é decrescente em $\phi$:

$$
\frac{\partial\mu_H^*}{\partial\phi} = \frac{1 - \phi/\sqrt{\phi^2-4(N-2)}}{2(N-2)} < 0
$$

Compondo:

$$
\boxed{
\frac{\partial\mu_s^{R1}}{\partial\beta} > 0, \qquad
\frac{\partial\mu_s^{R1}}{\partial r} > 0, \qquad
\frac{\partial\mu_s^{R1}}{\partial N} < 0
}
$$

### Interpretação

| Parâmetro | Efeito em $\mu_s^{R1}$ | Intuição |
|-----------|------------------------|----------|
| $\beta \uparrow$ | $\uparrow$ | Rejeição em R1 fica menos custosa (R2 vale mais) → W tolera crenças mais altas antes de pooling |
| $r \uparrow$ | $\uparrow$ | Gap entre tipos maior → screening rende mais → W mais disposta a arriscar |
| $N \uparrow$ | $\downarrow$ | Ganho marginal do proposer dilui → screening menos atraente |
| $\alpha$ | Nenhum | Outside option afeta ambas as ofertas simetricamente no Caso 2 |

### Verificação numérica (r=1.5, N=5)

| $\beta$ | $\mu_s^{R1}$ |
|---------|--------------|
| 0.70 | 0.099 |
| 0.80 | 0.136 |
| 0.90 | 0.197 |
| 0.95 | 0.247 |

| $N$ | $\mu_s^{R1}$ |
|-----|--------------|
| 3 | 0.382 |
| 5 | 0.197 |
| 10 | 0.086 |
| 20 | 0.040 |

---

## 9. Implicações para Bayesian Persuasion

O jump em $E_\theta[V_H^{R1}]$ no cutoff é:

$$
\text{Jump} = (1-\mu_s^{R1}) \cdot \frac{(N-1)\beta(r-1)}{N^2}
$$

No Caso 2:
- A **localização** do jump depende só de $(r, \beta, N)$.
- A **magnitude** do jump depende de $(r, \beta, N)$ via $\mu_s^{R1}$, e de $\alpha$ apenas indiretamente (determina se estamos no Caso 2 ou não).

O BP é eficaz quando o prior $\mu_0 < \mu_s^{R1}$ e a concavificação supera o valor da função:

$$\text{Ganho de BP} > 0 \iff \text{cav}\,v(\mu_0) > v(\mu_0)$$

Com $\mu_s^{R1}$ em closed form, a condição sobre $\mu_0$ é derivável analiticamente.

---

## 10. Formulação para o paper

### Proposição (texto principal)

> **Proposição X (Screening em R1).** Considere o jogo de barganha sob unanimidade com $N \geq 3$, $r > 1$, $\alpha \in (0, 1/r)$, e $\beta \in (0,1)$. Defina $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$.
>
> (i) Existe um único cutoff $\mu_s^{R1} \in (0,1)$ tal que W proposer em Round 1 joga agressivo se e somente se $\mu < \mu_s^{R1}$.
>
> (ii) Se $\alpha < \bar\alpha \equiv r\mu_H^*/(r-1+\mu_H^*)$, com $\mu_H^*$ definido em (5), então:
> $$\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}, \qquad \phi = \frac{rN - \beta(N-1+r)}{\beta(r-1)}$$
> Em particular, $\mu_s^{R1}$ não depende de $\alpha$.
>
> (iii) No regime do item (ii), isto é, quando $\alpha < \bar\alpha$, $\mu_s^{R1}$ é crescente em $\beta$ e $r$, decrescente em $N$.

### Prova (esqueleto)

> Substituindo $V_W^{R2}$ na diferença $\Delta_1 = F_1^{agg} - F_1^{con}$, obtém-se a representação piecewise (3). No ramo baixo, $\Delta_1$ é côncava com derivada negativa em $\mu=0$ (lema: $b_L < 0$ para $\alpha < 1/r$, $\beta \leq 1$); logo é estritamente decrescente. No ramo alto, $\Delta_1$ é convexa com $\Delta_1(\mu_s^{R2}) > 0$ e $\Delta_1(1) = r(\beta-1) < 0$. Convexidade implica que $\{\mu : \Delta_1(\mu) \leq 0\}$ é um intervalo; como o ponto à esquerda ($\mu_s^{R2}$) está fora e o ponto à direita ($1$) está dentro, há exatamente uma travessia. Para (ii), no ramo alto os termos $\pm(N-2)\alpha r\mu$ se cancelam, resultando em (4). Para (iii), aplicar regra da cadeia via $\partial\mu_H^*/\partial\phi < 0$. $\square$

### Frase interpretativa (sugestão para colocar após a proposição)

> O fato central é que, quando o cutoff de R1 cai à direita do kink de R2, o nível da outside option do hegemon desaparece da condição marginal do proposer fraco. Nesse regime, a decisão entre screening e pooling depende apenas do gap entre tipos, da paciência estratégica e do tamanho da instituição.

---

## 11. Código R

```r
#' Cutoff analítico de R1 sob unanimidade
#' @param alpha Outside option parameter (0 < alpha < 1/r)
#' @param r High-state pie (r > 1)
#' @param beta Discount factor (0 < beta < 1)
#' @param N Number of players (N >= 3)
#' @return List with mu_R1, mu_R2, case, phi, alpha_bar
cutoff_R1 <- function(alpha, r, beta, N) {
  stopifnot(alpha > 0, alpha < 1/r, r > 1, beta > 0, beta <= 1, N >= 3)

  mu_R2 <- alpha * (r - 1) / (r - alpha)

  # Caso 2 (ramo alto, alpha-independent)
  phi <- (r * N - beta * (N - 1 + r)) / (beta * (r - 1))
  disc <- phi^2 - 4 * (N - 2)
  mu_H <- (phi - sqrt(disc)) / (2 * (N - 2))

  # Fronteira explicita
  alpha_bar <- r * mu_H / (r - 1 + mu_H)

  if (alpha < alpha_bar) {
    return(list(mu_R1 = mu_H, mu_R2 = mu_R2,
                case = 2, phi = phi, alpha_bar = alpha_bar))
  }

  # Caso 1 (ramo baixo)
  b1 <- r * N - beta * (N - 1 + r + (N - 2) * alpha * (r - 1))
  disc1 <- b1^2 + 4 * (N - 2) * beta^2 * (1 - alpha) * (r - 1)
  mu_L <- (-b1 + sqrt(disc1)) / (2 * (N - 2) * beta * (1 - alpha))

  list(mu_R1 = mu_L, mu_R2 = mu_R2,
       case = 1, phi = phi, alpha_bar = alpha_bar)
}
```

---

## 12. Verificação numérica

| $r$ | $\alpha$ | $N$ | $\beta$ | $\mu_s^{R2}$ | $\mu_s^{R1}$ (analítico) | Caso | Erro vs root-finding |
|-----|----------|-----|---------|--------------|--------------------------|------|---------------------|
| 1.1 | 0.5 | 5 | 0.9 | 0.083 | 0.10199 | 2 | $< 10^{-14}$ |
| 1.5 | 0.3 | 5 | 0.9 | 0.125 | 0.19702 | 2 | $< 10^{-14}$ |
| 2.0 | 0.3 | 5 | 0.9 | 0.176 | 0.22550 | 2 | $< 10^{-13}$ |
| 1.2 | 0.8 | 5 | 0.9 | 0.400 | 0.18246 | 1 | $< 10^{-14}$ |
| 1.1 | 0.5 | 10 | 0.9 | 0.083 | 0.05183 | 1 | $< 10^{-14}$ |
| 1.5 | 0.3 | 3 | 0.8 | 0.125 | 0.25000 | 2 | $< 10^{-14}$ |
| 1.5 | 0.3 | 5 | 1.0 | 0.125 | 0.33333 | 2 | $< 10^{-14}$ |

**Independência de $\alpha$ confirmada** ($r=1.5$, $N=5$, $\beta=0.9$):

| $\alpha$ | $\mu_s^{R2}$ | $\mu_s^{R1}$ | Caso |
|----------|-------------|-------------|------|
| 0.1 | 0.036 | 0.197 | 2 |
| 0.2 | 0.077 | 0.197 | 2 |
| 0.3 | 0.125 | 0.197 | 2 |
| 0.4 | 0.182 | 0.197 | 2 |
| 0.5 | 0.250 | 0.209 | 1 (← troca) |
| 0.6 | 0.333 | 0.227 | 1 |

---

## 13. Recomendação de uso no paper

- **Texto principal**: Proposição X (Seção 10) com items (i)–(iii).
- **Apêndice**: álgebra detalhada (Seções 3–6), prova de $b_L < 0$, condição $\bar\alpha$.
- **Figura sugerida**: gráfico de $\mu_s^{R1}$ vs $\beta$ para diferentes $N$, mostrando a monotonicidade e a convergência a $1/(N-2)$ quando $\beta \to 1$.

O ponto com maior valor teórico: **no regime relevante, o screening cutoff de R1 é robusto ao nível da outside option do hegemon**. Isso fortalece o argumento de que o mecanismo institucional (unanimidade gerando screening) opera independentemente do poder de barganha individual de H.
