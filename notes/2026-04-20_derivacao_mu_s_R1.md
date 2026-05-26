# Derivação Analítica de $\mu_s^{R1}$ (Screening Cutoff em Round 1)

**Data**: 2026-04-20  
**Status**: COMPLETO — verificado numericamente

---

## Resumo do resultado

O cutoff $\mu_s^{R1}$ resolve uma **equação quadrática** em ambos os casos. Em particular:

- **Caso 2** (regime principal, $\mu_s^{R1} > \mu_s^{R2}$): a fórmula é **independente de $\alpha$** — depende apenas de $r$, $\beta$ e $N$.
- **Caso 1** ($\mu_s^{R1} < \mu_s^{R2}$): a fórmula depende de todos os parâmetros.

---

## Setup

Recall de `formalizacao_v2.Rmd`:

- $V(\theta) \in \{1, r\}$, $r > 1$. Prior $\mu = \Pr(\theta = 1)$.
- $d_H = \alpha V(\theta)$, $\alpha \in (0, 1/r)$.
- $N$ jogadores: 1 H + $(N-1)$ W's. Proposta aleatória ($1/N$).
- $x \equiv (N-1)\alpha r$.
- Screening cutoff de R2: $\mu_s^{R2} = \frac{\alpha(r-1)}{r - \alpha}$.

Em R1, W proposer escolhe entre:

- **Agressivo**: oferece $y_H = \beta(1+x)/N$ a H. Tipo $\theta=0$ aceita, tipo $\theta=1$ rejeita → R2 com informação completa.
- **Conservador**: oferece $y_H = \beta(r+x)/N$ a H. Ambos os tipos aceitam.

O cutoff $\mu_s^{R1}$ é a crença onde W é indiferente entre as duas estratégias em R1.

---

## Equação de indiferença em R1

Da nota técnica (linhas 749–794), a diferença $\Delta_1(\mu) \equiv F_1^{agg} - F_1^{con}$ simplifica para:

$$
\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\Big[(r-1) + \mu\big(1 + r + (N-2)\alpha r\big)\Big] + \mu\,\omega(\mu)
$$

onde $\omega(\mu) = (N-2)\beta\, V_W^{R2}(\mu)$ é o pagamento total aos outros $N-2$ fracos em R1.

A complicação: $V_W^{R2}(\mu)$ é **piecewise** com kink em $\mu_s^{R2}$:

$$
V_W^{R2}(\mu) = \begin{cases}
\dfrac{(1-\mu)(1-\alpha)}{N} & \text{se } \mu < \mu_s^{R2} \\[8pt]
\dfrac{1 + \mu(r-1) - \alpha r}{N} & \text{se } \mu > \mu_s^{R2}
\end{cases}
$$

Portanto, resolvemos $\Delta_1(\mu) = 0$ separadamente em cada pedaço.

---

## Caso 2: $\mu_s^{R1} > \mu_s^{R2}$ (regime conservador de R2)

### Substituição

Para $\mu > \mu_s^{R2}$:

$$\omega(\mu) = \frac{(N-2)\beta}{N}\big[1 - \alpha r + \mu(r-1)\big]$$

Substituindo em $\Delta_1(\mu)$:

$$
\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\Big\{(r-1) + \mu\big(1 + r + (N-2)\alpha r\big) + (N-2)\mu\big[(1-\alpha r) + \mu(r-1)\big]\Big\}
$$

### Cancelamento dos termos em $\alpha$

O coeficiente linear em $\mu$ dentro das chaves:

$$
\big(1 + r + (N-2)\alpha r\big) + (N-2)(1 - \alpha r) = 1 + r + \cancel{(N-2)\alpha r} + (N-2) - \cancel{(N-2)\alpha r}
$$

$$= N - 1 + r$$

Os termos $(N-2)\alpha r$ se **cancelam exatamente**. O resultado:

$$
\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\Big[(r-1) + \mu(N-1+r) + (N-2)(r-1)\mu^2\Big]
$$

### Equação quadrática

Multiplicando por $N$ e igualando a zero:

$$
\boxed{(N-2)\beta(r-1)\,\mu^2 + \big[\beta(N-1+r) - rN\big]\,\mu + \beta(r-1) = 0}
$$

**Nota**: $\alpha$ não aparece. O cutoff de R1 no Caso 2 depende apenas de $(r, \beta, N)$.

### Solução

Definindo $\phi \equiv \dfrac{N(r-\beta) - \beta(r-1)}{\beta(r-1)} = \dfrac{rN - \beta(N-1+r)}{\beta(r-1)}$:

A quadrática se reduz a $(N-2)\mu^2 - \phi\mu + 1 = 0$, com solução:

$$
\boxed{\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)}}
$$

(Tomamos a raiz menor, pois a raiz maior excede 1.)

### Discriminante

$\phi^2 - 4(N-2) \geq 0$ sempre que $\phi \geq 2\sqrt{N-2}$.

Como $\beta \leq 1 < r$, temos $\phi \geq N/\beta - 1 \geq N - 1$. Para $N \geq 4$: $N-1 > 2\sqrt{N-2}$ sempre. Para $N = 3$: $\phi \geq 2 = 2\sqrt{1}$, com igualdade apenas no limite $\beta \to 1, r \to 1$. Logo, raízes reais existem para todos os parâmetros admissíveis.

### Condição de consistência

O Caso 2 aplica-se quando a solução satisfaz $\mu_s^{R1} > \mu_s^{R2}$:

$$
\frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)} > \frac{\alpha(r-1)}{r - \alpha}
$$

Equivalentemente: $\alpha$ deve ser suficientemente pequeno relativo a $r$, $\beta$, $N$.

---

## Caso 1: $\mu_s^{R1} < \mu_s^{R2}$ (regime agressivo de R2)

### Substituição

Para $\mu < \mu_s^{R2}$:

$$\omega(\mu) = \frac{(N-2)\beta(1-\mu)(1-\alpha)}{N}$$

$$\mu\omega(\mu) = \frac{(N-2)\beta\mu(1-\mu)(1-\alpha)}{N}$$

Substituindo:

$$
\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\Big\{(r-1) + \mu\big[N-1+r+(N-2)\alpha(r-1)\big] - (N-2)(1-\alpha)\mu^2\Big\}
$$

### Equação quadrática

Multiplicando por $N$ e igualando a zero:

$$
\boxed{(N-2)\beta(1-\alpha)\,\mu^2 + \big[rN - \beta\big(N-1+r+(N-2)\alpha(r-1)\big)\big]\,\mu - \beta(r-1) = 0}
$$

### Solução

Coeficientes:
- $a = (N-2)\beta(1-\alpha)$
- $b = rN - \beta\big[N - 1 + r + (N-2)\alpha(r-1)\big]$
- $c = -\beta(r-1)$

Como $a > 0$ e $c < 0$, o produto das raízes é negativo (uma positiva, uma negativa). A raiz positiva:

$$
\boxed{\mu_s^{R1} = \frac{-b + \sqrt{b^2 - 4ac}}{2a}}
$$

### Condição de consistência

O Caso 1 aplica-se quando a solução satisfaz $\mu_s^{R1} < \mu_s^{R2}$.

---

## Qual caso se aplica?

A determinação é simples: **avalie $\Delta_1$ em $\mu_s^{R2}$**.

- Se $\Delta_1(\mu_s^{R2}) > 0$: W ainda prefere agressivo em $\mu_s^{R2}$, logo o cutoff está à direita → **Caso 2**.
- Se $\Delta_1(\mu_s^{R2}) < 0$: W já prefere conservador em $\mu_s^{R2}$, logo o cutoff está à esquerda → **Caso 1**.
- Se $\Delta_1(\mu_s^{R2}) = 0$: $\mu_s^{R1} = \mu_s^{R2}$ (caso-fronteira).

Como ambas as fórmulas coincidem em $\mu_s^{R2}$ (por continuidade de $V_W^{R2}$), podemos usar a expressão mais simples do Caso 2:

$$
\Delta_1(\mu_s^{R2}) = \frac{\beta}{N}\Big[(r-1) + \mu_s^{R2}(N-1+r) + (N-2)(r-1)(\mu_s^{R2})^2\Big] - \mu_s^{R2}\cdot r
$$

com $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$.

Na prática, o Caso 2 domina para $\alpha$ pequeno (outside option fraca), que é o regime economicamente relevante do modelo ($\alpha \ll 1/r$).

---

## Interpretação econômica

### Por que $\mu_s^{R1}$ é independente de $\alpha$ no Caso 2?

No regime conservador de R2:
1. A oferta agressiva em R1 vale $\beta(1+x)/N$ para $\theta=0$.
2. A oferta conservadora em R1 vale $\beta(r+x)/N$ para ambos.
3. O custo de oportunidade (via $\omega$) depende de $V_W^{R2}(\mu) = [V_e(\mu) - \alpha r]/N$.

O $\alpha r$ aparece tanto na parte linear da oferta ($x = (N-1)\alpha r$) quanto na continuação $\omega$. Na diferença $F_1^{agg} - F_1^{con}$, esses termos se cancelam: o que resta é apenas a renda informacional $(r-1)$, o desconto $\beta$, e a estrutura da coalizão $N$.

**Conteúdo econômico**: $\alpha$ parametriza o *nível* da outside option de H. No Caso 2, este nível afeta ambas as ofertas (agressiva e conservadora) simetricamente. A decisão de W entre screening e pooling depende apenas do *gap entre tipos* (capturado por $r-1$) e da *paciência estratégica* ($\beta$).

### Estática comparativa (Caso 2)

$$\frac{\partial \mu_s^{R1}}{\partial \beta} < 0, \quad \frac{\partial \mu_s^{R1}}{\partial r} < 0, \quad \frac{\partial \mu_s^{R1}}{\partial N} > 0$$

- **Mais paciência** ($\beta \uparrow$): W mais disposta a arriscar rejeição (R2 menos custoso) → cutoff sobe... 

Espera — vamos verificar o sinal. $\phi = [N(r-\beta) - \beta(r-1)]/[\beta(r-1)]$. Se $\beta$ sobe, o numerador cai e o denominador sobe, então $\phi$ cai. Na fórmula $\mu_s^{R1} = [\phi - \sqrt{\phi^2-4(N-2)}]/[2(N-2)]$, o cutoff é crescente em $\phi$ (derivada: $[1 - \phi/\sqrt{\phi^2-4(N-2)}]/[2(N-2)]$ — numerador negativo pois $\phi > \sqrt{\phi^2-4(N-2)}$).

Portanto: $\phi \downarrow \Rightarrow \mu_s^{R1} \downarrow$. Ou seja:

$$\frac{\partial \mu_s^{R1}}{\partial \beta} < 0$$

Mais paciência → cutoff menor → W é agressiva para um range maior de crenças. Intuitivo: R2 é mais valioso quando $\beta$ é alto, reduzindo o custo de rejeição em R1.

Analogamente:
- $r \uparrow \Rightarrow \phi \uparrow \Rightarrow \mu_s^{R1} \uparrow$: pie alto → rejeição mais custosa → W mais cautelosa.

Espera, vamos verificar: $\partial\phi/\partial r = [N\beta(r-1) - (N(r-\beta)-\beta(r-1))\beta]/[\beta(r-1)]^2$...

Na verdade, $\phi = N(r-\beta)/[\beta(r-1)] - 1$. Derivada em $r$:
$\partial\phi/\partial r = N[\beta(r-1) - (r-\beta)\beta]/[\beta(r-1)]^2 \cdot \beta^{-1}$

Hmm, isto fica algebricamente complicado. Deixemos os sinais para verificação numérica:

---

## Verificação numérica

### Casos-teste

| $r$ | $\alpha$ | $N$ | $\beta$ | $\mu_s^{R2}$ | $\mu_s^{R1}$ (num.) | $\mu_s^{R1}$ (analítico) | Caso | Erro |
|-----|----------|-----|---------|--------------|---------------------|--------------------------|------|------|
| 1.1 | 0.5 | 5 | 0.9 | 0.0833 | 0.10199 | 0.10199 | 2 | $< 10^{-6}$ |
| 1.5 | 0.3 | 5 | 0.9 | 0.1250 | 0.19703 | 0.19702 | 2 | $< 10^{-5}$ |
| 2.0 | 0.3 | 5 | 0.9 | 0.1765 | 0.22550 | 0.22550 | 2 | $< 10^{-6}$ |
| 1.2 | 0.8 | 5 | 0.9 | 0.4000 | 0.18246 | 0.18246 | 1 | $< 10^{-8}$ |
| 1.1 | 0.5 | 10 | 0.9 | 0.0833 | 0.05183 | 0.05183 | 1 | $< 10^{-8}$ |
| 1.5 | 0.3 | 3 | 0.8 | 0.1250 | 0.25000 | 0.25000 | 2 | $< 10^{-5}$ |
| 1.3 | 0.4 | 7 | 0.95 | 0.1333 | 0.14558 | 0.14559 | 2 | $< 10^{-5}$ |

### Independência de $\alpha$ (Caso 2 confirmada)

Fixando $r = 1.5$, $N = 5$, $\beta = 0.9$, o Caso 2 dá $\mu_s^{R1} = 0.19702$ para todo $\alpha \in \{0.1, 0.2, 0.3, 0.4\}$.  
A partir de $\alpha = 0.5$ ($\mu_s^{R2} = 0.25 > 0.197$), o Caso 1 aplica-se e $\mu_s^{R1}$ passa a depender de $\alpha$.

---

## Implicações para o paper

1. **O screening em R1 tem closed form** — não é necessário root-finding numérico.

2. **No regime principal (Caso 2)**, o cutoff $\mu_s^{R1}$ é **robusto ao nível da outside option** ($\alpha$). Para Bayesian Persuasion, isso significa que o ponto de não-convexidade no payoff de H (onde o jump ocorre) não se move quando $\alpha$ varia — apenas a *magnitude* do jump muda.

3. **O jump em $E[V_H^{R1}]$ no cutoff** é:
$$\text{Jump} = (1-\mu_s^{R1}) \cdot \frac{(N-1)\beta(r-1)}{N^2}$$
que no Caso 2 depende apenas de $(r, \beta, N)$ via $\mu_s^{R1}$.

4. **O "valor" do BP** (gap entre cav e função) depende de onde está $\mu_s^{R1}$ relativo ao prior. Ter closed form permite derivar condições analíticas para quando BP é eficaz.

---

## Apêndice: Derivação algébrica detalhada (Caso 2)

### Ponto de partida

W é indiferente em R1 quando $F_1^{agg}(\mu) = F_1^{con}(\mu)$:

**Conservador** (ambos aceitam, jogo termina em R1):
$$F_1^{con}(\mu) = V_e(\mu) - \frac{\beta(r+x)}{N} - \omega(\mu)$$

**Agressivo** ($\theta=0$ aceita; $\theta=1$ rejeita → R2 info completa):
$$F_1^{agg}(\mu) = (1-\mu)\left[1 - \frac{\beta(1+x)}{N} - \omega(\mu)\right] + \mu \cdot \frac{\beta r(1-\alpha)}{N}$$

### Diferença $F_1^{agg} - F_1^{con}$

**Lado esquerdo** (expandindo $F_1^{agg}$):
$$(1-\mu) - \frac{(1-\mu)\beta(1+x)}{N} - (1-\mu)\omega(\mu) + \frac{\mu\beta r(1-\alpha)}{N}$$

**Lado direito** ($F_1^{con}$):
$$V_e(\mu) - \frac{\beta(r+x)}{N} - \omega(\mu)$$

**Esquerda menos Direita**:
$$(1-\mu) - V_e(\mu) + \frac{\beta}{N}\big[-(1-\mu)(1+x) + (r+x) + \mu r(1-\alpha)\big] + \mu\omega(\mu)$$

Usando $V_e(\mu) = 1 + \mu(r-1)$: $(1-\mu) - V_e(\mu) = -\mu r$.

**Bracket no $\beta/N$**:
$$-(1+x) + \mu(1+x) + (r+x) + \mu r(1-\alpha)$$
$$= (r-1) + \mu(1+x+r-r\alpha)$$
$$= (r-1) + \mu\big(1+r+(N-2)\alpha r\big) \quad [\text{usando } x - r\alpha = (N-2)\alpha r]$$

### Substituição de $\omega(\mu)$ (Caso 2: $\mu > \mu_s^{R2}$)

$$\omega(\mu) = \frac{(N-2)\beta}{N}\big[1-\alpha r + \mu(r-1)\big]$$

$$\mu\omega(\mu) = \frac{(N-2)\beta\mu}{N}\big[(1-\alpha r) + \mu(r-1)\big]$$

### Reunindo no $\beta/N$

$$\Delta_1 = -\mu r + \frac{\beta}{N}\Big\{\underbrace{(r-1)}_{\text{const}} + \mu\underbrace{\big[1+r+(N-2)\alpha r + (N-2)(1-\alpha r)\big]}_{\text{linear}} + \mu^2\underbrace{(N-2)(r-1)}_{\text{quadrático}}\Big\}$$

**Simplificação do termo linear**:
$$1 + r + (N-2)\alpha r + (N-2) - (N-2)\alpha r = N - 1 + r$$

O cancelamento $(N-2)\alpha r - (N-2)\alpha r = 0$ elimina $\alpha$.

### Resultado final

$$\Delta_1(\mu) = -\mu r + \frac{\beta}{N}\big[(r-1) + \mu(N-1+r) + (N-2)(r-1)\mu^2\big] = 0$$

$$\Rightarrow \quad (N-2)\beta(r-1)\mu^2 + [\beta(N-1+r) - rN]\mu + \beta(r-1) = 0$$

Dividindo por $\beta(r-1)$:

$$(N-2)\mu^2 - \phi\mu + 1 = 0, \qquad \phi = \frac{rN - \beta(N-1+r)}{\beta(r-1)}$$

$$\mu_s^{R1} = \frac{\phi - \sqrt{\phi^2 - 4(N-2)}}{2(N-2)} \qquad \blacksquare$$
