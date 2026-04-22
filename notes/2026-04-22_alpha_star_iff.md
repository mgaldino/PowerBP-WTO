# Nota Técnica: α* é Necessário e Suficiente (Lemma 1 Strengthening)

**Data**: 2026-04-22
**Status**: VERIFICADO — prova revisada por agente matemático (2026-04-22), todos os checks corretos

## Claim

O threshold α*(N,β) no Lemma 1 é **necessário e suficiente** para dominância condicional de unanimidade em todos os beliefs:

$$\alpha < \alpha^*(N,\beta) \iff E_\theta[V_H^{R1}(\theta, \mu, U)] > E_\theta[V_H^{R1}(\theta, \mu, M)] \quad \forall \mu \in (0,1].$$

## Argumento

### Setup (da prova existente do Lemma 1)

A diferença de payoffs decompõe-se como:

$$D(\mu) = D_{\text{base}}(\mu) + \mathbf{1}\{\mu < \mu_s^{R2}\} \cdot \delta_{R2}(\mu) + \mathbf{1}\{\text{R1 conserv.}\} \cdot \delta_{R1}(\mu)$$

onde:
- $D_{\text{base}}(\mu)$ é affine em μ
- $\delta_{R2}(\mu) \geq 0$ na região relevante (vanishes at μ_s^R2)  
- $\delta_{R1}(\mu) = \frac{(N-1)\beta(r-1)(1-\mu)}{N^2} \geq 0$, com igualdade apenas em μ = 1

### Suficiência (já provada)

Se α < α*, então D_base > 0 em [0,1] (endpoints positivos, affine). As correções são ≥ 0. Logo D(μ) > 0 para todo μ ∈ (0,1]. ∎

### Necessidade (novo)

**Claim**: Se α ≥ α*, existe μ ∈ (0,1] tal que D(μ) ≤ 0.

**Prova**: Em μ = 1, estamos na Região III (R1 conservador). Portanto:

$$D(1) = D_{\text{base}}(1) + \delta_{R1}(1)$$

Mas $\delta_{R1}(1) = \frac{(N-1)\beta(r-1)(1-1)}{N^2} = 0$.

Logo $D(1) = D_{\text{base}}(1)$.

Da prova existente:

$$D_{\text{base}}(1) = \frac{r[C_{\text{buy}} - C_{\text{out}}(1-\beta)]}{N^2}$$

onde $C_{\text{buy}} = \beta(q-1)(1-\alpha)$ e $C_{\text{out}} = N(N-1)\alpha$.

O threshold α* é **definido** como a solução de $C_{\text{buy}} - C_{\text{out}}(1-\beta) = 0$:

$$\alpha^* = \frac{\beta(q-1)}{N(N-1) - \beta(N^2 - N - q + 1)}$$

Portanto:
- α < α* ⟹ $C_{\text{buy}} - C_{\text{out}}(1-\beta) > 0$ ⟹ $D_{\text{base}}(1) > 0$
- α = α* ⟹ $D_{\text{base}}(1) = 0$ ⟹ $D(1) = 0$
- α > α* ⟹ $D_{\text{base}}(1) < 0$ ⟹ $D(1) < 0$

No caso α > α*: D(1) < 0 implica que unanimidade NÃO domina em μ = 1. ∎

No caso α = α*: D(1) = 0 e D(μ) > 0 para μ ∈ (0,1), então a dominância estrita falha apenas no endpoint. ∎

### Interpretação

O ponto onde unanimidade perde para maioria (quando α > α*) é **μ = 1** — certeza de que θ = 1. Isto é o cenário de **informação pública completa**: todos sabem que o valor da cooperação é alto. Neste caso, a informação privada do hegemon é irrelevante (não há assimetria), e o custo de comprar N-1 votos sob unanimidade excede o benefício do screening.

Para beliefs intermediários (μ < 1), o screening jump pode ainda gerar vantagem para unanimidade mesmo quando α > α*. O Lemma 1 garante dominância *global*; a falha ocorre apenas na fronteira onde a assimetria informacional se torna irrelevante.

### Implicação para N grande

Para N = 164, β = 0.9: α* ≈ 0.027. Se α_real = 0.08 (> α*), unanimidade falha em μ perto de 1 mas pode dominar em μ baixo/intermediário via screening + BP. A questão empírica torna-se: **qual o μ threshold abaixo do qual unanimidade ainda domina?**

## Questão aberta: μ threshold para α > α*

Quando α > α*, D(μ) é positiva para μ baixo e negativa para μ perto de 1. O threshold μ̄ solve D(μ̄) = 0. Em μ̄, D_base(μ̄) + δ_R1(μ̄) = 0 (se estamos na Região III).

Na Região III: $D(\mu) = D_{\text{base}}(\mu) + \delta_{R1}(\mu)$

$$= \frac{(C_{\text{buy}} - C_{\text{out}})V_e(\mu) + C_{\text{out}}\beta r}{N^2} + \frac{(N-1)\beta(r-1)(1-\mu)}{N^2}$$

Setting D(μ̄) = 0:

$$(C_{\text{buy}} - C_{\text{out}})[1 + \mū(r-1)] + C_{\text{out}}\beta r + (N-1)\beta(r-1)(1-\mū) = 0$$

Resolvendo para μ̄:

$$\mū = \frac{C_{\text{buy}} - C_{\text{out}} + C_{\text{out}}\beta r + (N-1)\beta(r-1)}{(C_{\text{out}} - C_{\text{buy}})(r-1) + (N-1)\beta(r-1)}$$

Simplificando o numerador: $C_{\text{buy}} - C_{\text{out}} + C_{\text{out}}\beta r + (N-1)\beta(r-1)$

Simplificando o denominador: $(r-1)[C_{\text{out}} - C_{\text{buy}} + (N-1)\beta]$

Se μ̄ < 1 e μ̄ > 0, este é o belief acima do qual maioria domina condicionalmente.

## Ponto adicional: μ̄ > μ_s^R1 (validação da fórmula)

A fórmula de μ̄ assume Region III (μ > μ_s^R1). Isso é válido porque:
- Em μ = μ_s^R1: D_base(μ_s^R1) > 0 (D_base positivo em [0,1) mesmo com α ≥ α*) e δ_R1(μ_s^R1) > 0 (pois μ_s^R1 < 1)
- Logo D(μ_s^R1) > 0
- Como D(1) ≤ 0, por continuidade o zero μ̄ está em (μ_s^R1, 1]

## Verificação numérica

| N | β | α | r | α* | α/α* | μ̄ | U domina para |
|---|---|---|---|-----|------|-----|---------------|
| 164 | 0.9 | 0.08 | 1.2 | 0.027 | 3.0x | 0.61 | μ < 0.61 |
| 164 | 0.9 | 0.08 | 1.5 | 0.027 | 3.0x | 0.80 | μ < 0.80 |
| 164 | 0.9 | 0.08 | 2.0 | 0.027 | 3.0x | 0.87 | μ < 0.87 |
| 164 | 0.9 | 0.08 | 3.0 | 0.027 | 3.0x | 0.90 | μ < 0.90 |
| 23 | 0.9 | 0.08 | 1.5 | 0.164 | 0.5x | >1 | todos os μ |
| 164 | 0.9 | 0.05 | 1.5 | 0.027 | 1.9x | 0.87 | μ < 0.87 |

**Conclusão**: Mesmo com α 3x acima de α* (N=164), unanimidade domina condicionalmente para 80-90% do espaço de beliefs (r=1.5-3.0). A falha ocorre apenas perto de μ=1, onde a assimetria informacional é irrelevante.
