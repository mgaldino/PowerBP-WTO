# Derivação: τ(U) closed-form (Entry Threshold sob Unanimidade)

**Data**: 2026-04-22
**Status**: REVIEWED — PASS WITH CORRECTIONS (corrections applied below)

## Objetivo

Derivar expressão explícita para τ(U), o entry threshold sob unanimidade, definido como:
$$\tau(U) = \max\{0, \inf\{\mu \in [0,1] : V_W^{R1}(\mu, U) \geq c\}\}$$

## Setup

### V_W^{R2} sob unanimidade (do Appendix A.2)

$$V_W^{R2}(\mu) = \begin{cases} \frac{(1-\mu)(1-\alpha)}{N} & \mu < \mu_s^{R2} \\[6pt] \frac{V_e(\mu) - \alpha r}{N} & \mu > \mu_s^{R2} \end{cases}$$

onde $V_e(\mu) = 1 + \mu(r-1)$ e $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$.

### V_W^{R1} sob unanimidade

Quando W propõe (prob $(N-1)/N$), o payoff de W é o melhor entre aggressive e conservative:

$$F_1^{con}(\mu) = V_e(\mu) - \frac{\beta(r+x)}{N} - \omega(\mu)$$
$$F_1^{agg}(\mu) = (1-\mu)\left[1 - \frac{\beta(1+x)}{N} - \omega(\mu)\right] + \frac{\mu\beta r(1-\alpha)}{N}$$

onde $x = (N-1)\alpha r$ e $\omega(\mu) = (N-2)\beta V_W^{R2}(\mu)$.

Quando W não propõe (prob $(N-1)/N$ total: $1/N$ para H e $(N-2)/N$ para os outros $N-2$ W's), W recebe payoff de non-proposer.

O payoff total de W em R1 é:
$$V_W^{R1}(\mu) = \frac{1}{N} \max\{F_1^{agg}, F_1^{con}\} + \text{nonprop}(\mu)$$

### Dois regimes em R1

**Regime conservador** ($\mu > \mu_s^{R1}$): todos os deals passam em R1.

- W propõe (prob $1/N$): payoff $F_1^{con}/N$
- W não propõe (prob $(N-1)/N$): recebe $\beta V_W^{R2}$ como non-proposer

$$V_W^{R1}(\mu, \text{con}) = \frac{F_1^{con}(\mu)}{N} + \frac{(N-1)\beta V_W^{R2}(\mu)}{N}$$

**Regime agressivo** ($\mu < \mu_s^{R1}$): θ=1 rejeita em R1, vai para R2.

- W propõe (prob $1/N$): payoff $F_1^{agg}/N$
- H propõe (prob $1/N$): W recebe $\beta V_W^{R2}(\mu)$
- Outro W propõe (prob $(N-2)/N$): se θ=0 (prob $1-\mu$), deal passa e W recebe $\beta V_W^{R2}(\mu)$; se θ=1 (prob $\mu$), deal rejeitado, vai para R2 com $\mu=1$, W recebe $\beta V_W^{R2}(1) = \beta r(1-\alpha)/N$

$$V_W^{R1}(\mu, \text{agg}) = \frac{F_1^{agg}(\mu)}{N} + \frac{\beta V_W^{R2}(\mu)}{N} + \frac{(N-2)}{N}\left[(1-\mu)\beta V_W^{R2}(\mu) + \mu\beta \frac{r(1-\alpha)}{N}\right]$$

## Derivação analítica: Regime conservador (μ > μ_s^{R1})

Neste regime, μ > μ_s^{R1} > μ_s^{R2} (na principal configuração de parâmetros), então estamos no branch alto de V_W^{R2}:

$$V_W^{R2}(\mu) = \frac{V_e(\mu) - \alpha r}{N}$$

$$\omega(\mu) = \frac{(N-2)\beta[V_e(\mu) - \alpha r]}{N}$$

Substituindo em $F_1^{con}$:
$$F_1^{con} = V_e(\mu) - \frac{\beta(r + x)}{N} - \frac{(N-2)\beta[V_e(\mu) - \alpha r]}{N}$$

$$= V_e(\mu)\left[1 - \frac{(N-2)\beta}{N}\right] - \frac{\beta[r + x - (N-2)\alpha r]}{N}$$

$$= V_e(\mu)\cdot\frac{N - (N-2)\beta}{N} - \frac{\beta[r + (N-1)\alpha r - (N-2)\alpha r]}{N}$$

$$= V_e(\mu)\cdot\frac{N - (N-2)\beta}{N} - \frac{\beta r(1 + \alpha)}{N}$$

Portanto:
$$V_W^{R1}(\mu, \text{con}) = \frac{F_1^{con}}{N} + \frac{(N-1)\beta[V_e(\mu) - \alpha r]}{N^2}$$

$$= \frac{V_e(\mu)[N - (N-2)\beta] - \beta r(1+\alpha)}{N^2} + \frac{(N-1)\beta[V_e(\mu) - \alpha r]}{N^2}$$

$$= \frac{V_e(\mu)[N - (N-2)\beta + (N-1)\beta] - \beta r(1+\alpha) - (N-1)\beta\alpha r}{N^2}$$

$$= \frac{V_e(\mu)[N + \beta] - \beta r[1 + \alpha + (N-1)\alpha]}{N^2}$$

$$= \frac{V_e(\mu)(N + \beta) - \beta r(1 + N\alpha)}{N^2}$$

Definindo:
$$\kappa_U^{con} \equiv \frac{N + \beta}{N^2}, \qquad \gamma_U^{con} \equiv \frac{\beta r(1 + N\alpha)}{N^2}$$

temos:
$$V_W^{R1}(\mu, \text{con}) = \kappa_U^{con} \cdot V_e(\mu) - \gamma_U^{con}$$

que é **affine em μ** (como esperado).

### Entry threshold no regime conservador

$V_W^{R1}(\mu, \text{con}) = c$ implica:

$$\kappa_U^{con}[1 + \mu(r-1)] = c + \gamma_U^{con}$$

$$\mu = \frac{c + \gamma_U^{con} - \kappa_U^{con}}{\kappa_U^{con}(r-1)}$$

Portanto, se o entry threshold cai no regime conservador:

$$\boxed{\tau_U^{con} = \max\left\{0,\; \frac{c + \gamma_U^{con} - \kappa_U^{con}}{\kappa_U^{con}(r-1)}\right\} = \max\left\{0,\; \frac{c - \frac{N + \beta - \beta r(1+N\alpha)}{N^2}}{\frac{(N+\beta)(r-1)}{N^2}}\right\}}$$

Simplificando numerador e denominador:

$$\tau_U^{con} = \max\left\{0,\; \frac{cN^2 - [N + \beta - \beta r(1 + N\alpha)]}{(N+\beta)(r-1)}\right\}$$

## Derivação analítica: Regime agressivo (μ < μ_s^{R1})

Aqui precisamos considerar dois sub-cases: μ < μ_s^{R2} (branch baixo de V_W^{R2}) e μ_s^{R2} < μ < μ_s^{R1} (branch alto).

### Sub-case A: μ < μ_s^{R2} (ambos R2 e R1 agressivos)

$$V_W^{R2}(\mu) = \frac{(1-\mu)(1-\alpha)}{N}$$

$$\omega(\mu) = \frac{(N-2)\beta(1-\mu)(1-\alpha)}{N}$$

$$F_1^{agg} = (1-\mu)\left[1 - \frac{\beta(1+x)}{N} - \frac{(N-2)\beta(1-\mu)(1-\alpha)}{N}\right] + \frac{\mu\beta r(1-\alpha)}{N}$$

Non-proposer payoff:
$$\text{nonprop} = \frac{\beta(1-\mu)(1-\alpha)}{N^2} + \frac{(N-2)}{N}\left[(1-\mu)\frac{\beta(1-\mu)(1-\alpha)}{N} + \mu\frac{\beta r(1-\alpha)}{N}\right]$$

$$= \frac{\beta(1-\alpha)}{N^2}\left[(1-\mu) + (N-2)(1-\mu)^2 + (N-2)\mu r\right]$$

This becomes quadratic in μ. Let me collect terms.

$$V_W^{R1}(\mu, \text{agg, low}) = \frac{F_1^{agg}}{N} + \text{nonprop}$$

Esta expressão é **quadrática em μ** (por causa dos termos $(1-\mu)\omega(\mu)$ e $(1-\mu)^2$ no nonprop). A inversão V_W = c produz uma equação quadrática com closed-form.

### Sub-case B: μ_s^{R2} < μ < μ_s^{R1} (R2 conservador, R1 agressivo)

$$V_W^{R2}(\mu) = \frac{V_e(\mu) - \alpha r}{N}$$

$$\omega(\mu) = \frac{(N-2)\beta[V_e(\mu) - \alpha r]}{N}$$

$$F_1^{agg} = (1-\mu)\left[1 - \frac{\beta(1+x)}{N} - \frac{(N-2)\beta[V_e(\mu)-\alpha r]}{N}\right] + \frac{\mu\beta r(1-\alpha)}{N}$$

Non-proposer payoff:
$$\text{nonprop} = \frac{\beta[V_e(\mu)-\alpha r]}{N^2} + \frac{(N-2)}{N}\left[(1-\mu)\frac{\beta[V_e(\mu)-\alpha r]}{N} + \mu\frac{\beta r(1-\alpha)}{N}\right]$$

Neste sub-case, $\omega$ é affine em μ, mas $(1-\mu)\omega(\mu)$ é quadrática. Novamente, V_W é quadrática em μ com closed-form.

## Resumo

$$\tau(U) = \max\{0,\; \mu^* \text{ tal que } V_W^{R1}(\mu^*, U) = c\}$$

onde:

1. Se τ(U) > μ_s^{R1}: **affine inversion** (regime conservador)
$$\tau(U) = \frac{cN^2 - [N + \beta - \beta r(1+N\alpha)]}{(N+\beta)(r-1)}$$

2. Se μ_s^{R2} < τ(U) < μ_s^{R1}: **raiz de quadrática** (regime B)

3. Se τ(U) < μ_s^{R2}: **raiz de quadrática** (regime A)

O caso empiricamente relevante (e o que o reviewer flagou) é o **caso 1** (conservador), pois para c não muito grande o entry threshold tipicamente cai acima de μ_s^{R1}. Os outros dois casos são edge cases que ocorrem para c muito pequeno.

## Verificação numérica pendente

Comparar τ_U^{con} analítico vs. a busca numérica usada no código R (scripts/model_functions.R) para os parâmetros do paper: N=5, r=1.5, α=0.3, β=0.9, c=0.1.

### Cálculo manual: N=5, r=1.5, α=0.3, β=0.9, c=0.1

$$\kappa_U^{con} = \frac{5 + 0.9}{25} = \frac{5.9}{25} = 0.236$$

$$\gamma_U^{con} = \frac{0.9 \times 1.5 \times (1 + 5 \times 0.3)}{25} = \frac{0.9 \times 1.5 \times 2.5}{25} = \frac{3.375}{25} = 0.135$$

$$\tau_U^{con} = \frac{0.1 + 0.135 - 0.236}{0.236 \times 0.5} = \frac{-0.001}{0.118} = -0.0085$$

Portanto τ(U) = max{0, ≈ −0.0085} = 0. Entry ocorre para todo μ ≥ 0 nestes parâmetros.

Isso é consistente com o paper: na Figure 3 (bp_illustration), panel (a) com esses parâmetros, não há gap de entry sob unanimidade.

## Condição de validade e entry set desconectado

**IMPORTANTE** (flagged na revisão matemática): $V_W^{R1}(\mu)$ tem um **salto para baixo** em $\mu_s^{R1}$ (oposto ao salto para cima de $V_H$). Isso pode criar um **entry set desconectado** para valores intermediários de c:

$$\{\mu : V_W^{R1}(\mu) \geq c\} = [0, \mu_1] \cup [\mu_2, 1]$$

onde $\mu_1 < \mu_s^{R1} < \mu_2$, com um gap ao redor do screening cutoff.

**Exemplo numérico** (N=5, r=1.5, α=0.3, β=0.9):
- c = 0.126: entry set = [0.001, 0.197] ∪ [0.212, 0.999] (desconectado)
- c = 0.134: entry set = [0.280, 0.999] (conectado, só regime conservador)

### Condição de auto-consistência

A fórmula $\tau_U^{con}$ é o entry threshold correto **quando**:
1. $\tau_U^{con} > \mu_s^{R1}$, **E**
2. $\max_{\mu \leq \mu_s^{R1}} V_W^{R1}(\mu, \text{agg}) < c$ (nenhuma entry no regime agressivo).

Quando (2) falha, o verdadeiro $\tau(U) = 0$ (ou um valor no regime agressivo), e $\tau_U^{con}$ dá o ponto de re-entry, não o ínfimo.

**Para o paper**: o código de concavificação avalia payoffs pontualmente e lida com qualquer forma do entry set. A fórmula analítica no appendix deve carregar uma nota sobre esta condição de auto-consistência.
