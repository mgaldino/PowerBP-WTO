# Prompt: Provar Lemma X analiticamente

## Sua tarefa

Provar o Lemma X abaixo. A prova deve ser puramente analítica (sem verificação numérica como argumento). Ao final, rode o script de verificação `scripts/test_supEU_lt_1.R` e `scripts/test_VW_monotonicity.R` para confirmar que a prova é consistente com os resultados numéricos.

Salve a prova completa em `notes/2026-04-25_prova_lemmaX.md`.

---

## Modelo (aceitar como dado)

Barganha Baron-Ferejohn com 2 rounds, N jogadores (1 hegemon H + N-1 weak states W), desconto β ∈ (0,1), proposer aleatório (prob 1/N cada). Pie V(θ) ∈ {1, r} com r > 1. H observa θ, W's não. Prior: μ = Pr(θ=1). Outside option de H: αV(θ), com α ∈ (0, 1/r). W's: outside option 0. Voting rule: unanimidade.

V_e(μ) ≡ E[V(θ) | μ] = 1 + μ(r−1).

## Screening

Em R2, W proposer escolhe oferta agressiva (θ=0 aceita, θ=1 rejeita) ou conservadora (ambos aceitam). Cutoff R2:

$$\mu_s^{R2} = \frac{\alpha(r-1)}{r-\alpha}$$

Em R1, mesmo trade-off. Cutoff R1: μ_s^{R1} (raiz de uma quadrática, ver A.3 do paper). Quando α < ᾱ(r,β,N), temos μ_s^{R2} < μ_s^{R1}, e o cutoff R1 é independente de α.

## Valores de continuação de W em R2

$$V_W^{R2}(\mu < \mu_s^{R2}) = \frac{(1-\mu)(1-\alpha)}{N}, \qquad V_W^{R2}(\mu > \mu_s^{R2}) = \frac{V_e(\mu) - \alpha r}{N}$$

Contínuo em μ_s^{R2}.

## V_W^{R1} sob unanimidade — fórmulas fechadas

**Regime conservador** (μ > μ_s^{R1}, todos aceitam em R1):

$$V_W^{R1}(\mu, U) = \frac{(N+\beta)\,V_e(\mu) - \beta r(1+N\alpha)}{N^2}$$

Affine em μ, slope = (N+β)(r−1)/N² > 0.

Em μ = 1:

$$V_W^{R1}(1, U) = \frac{r(1-\beta\alpha)}{N}$$

**Regime agressivo** (μ < μ_s^{R1}, θ=1 rejeita em R1 → R2 com desconto):

V_W^{R1} é computado em `scripts/model_functions.R`, função `VW_R1_unanimity`. A fórmula envolve:
- ω(μ) = (N−2)β V_W^{R2}(μ)
- x = (N−1)αr
- Proposer surplus: F₁^{agg} = (1−μ)[1 − β(1+x)/N − ω] + μβr(1−α)/N
- Non-proposer payoff quando W propõe agressivamente
- VW = F₁^{agg}/N + non-proposer values

A expressão exata é piecewise affine em μ (affine em cada sub-regime R2).

## Budget identity (já provado no paper, A.6)

- Conservador: $V_H(\mu, U) + (N-1)V_W(\mu, U) = V_e(\mu)$
- Agressivo: $V_H(\mu, U) + (N-1)V_W(\mu, U) = V_e(\mu) - \frac{(N-1)\mu r(1-\beta)}{N}$

O termo $(N-1)\mu r(1-\beta)/N$ é a perda de surplus quando θ=1 (prob μ) rejeita a oferta de W (prob (N-1)/N) e vai para R2 com desconto β.

## V_H — decomposição (já provada no paper, B.5)

O excedente de H sob unanimidade vs maioria se decompõe em:

$$V_H(\mu, U) = \lambda_M V_e(\mu) + D(\mu)$$

onde $\lambda_M = [N(1+(N-1)\alpha) - \beta(q-1)(1-\alpha)] / N^2$ e:

$$D(\mu) = D_{\text{base}}(\mu) + \mathbf{1}\{\mu < \mu_s^{R2}\}\cdot\delta_{R2}(\mu) + \mathbf{1}\{\mu > \mu_s^{R1}\}\cdot\delta_{R1}(\mu)$$

com:

$$D_{\text{base}}(\mu) = \frac{(C_{\text{buy}}-C_{\text{out}})V_e(\mu) + C_{\text{out}}\beta r}{N^2}$$

$$\delta_{R2}(\mu) = \frac{(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]}{N^2}$$

$$\delta_{R1}(\mu) = \frac{(N-1)\beta(r-1)(1-\mu)}{N^2}$$

onde $C_{\text{buy}} = \beta(q-1)(1-\alpha)$, $C_{\text{out}} = N(N-1)\alpha$, $q = \lfloor N/2 \rfloor + 1$.

Cada componente é affine em μ. δ_R2(μ_s^{R2}) = 0. δ_R1(1) = 0. δ_R1(μ) ≥ 0 para μ ≤ 1.

## Slopes de V_H em cada regime

Do paper, computei:

- **Conservative** (μ > μ_s^{R1}): $\frac{dV_H}{d\mu} = \frac{(r-1)(N-(N-1)\beta)}{N^2}$

- **Aggressive, R2-high sub-branch** (μ_s^{R2} < μ < μ_s^{R1}): $\frac{dV_H}{d\mu} = \frac{(r-1)}{N}$

- **Aggressive, R2-low sub-branch** (μ < μ_s^{R2}): $\frac{dV_H}{d\mu} = \frac{N(r-1) + (N-1)\beta(r-\alpha)}{N^2}$

V_H é contínuo em μ_s^{R2} e tem salto para cima em μ_s^{R1} de magnitude $(1-\mu_s^{R1})(N-1)\beta(r-1)/N^2$.

## Statement do Lemma X

**Lemma X**: Para todo μ ∈ (0, 1], $V_W^{R1}(\mu, U) \leq V_W^{R1}(1, U) = r(1-\beta\alpha)/N$.

**Corolário**: Se E_U ≡ {μ : V_W^{R1}(μ, U) ≥ c} ≠ ∅, então 1 ∈ E_U.

## Esqueleto da prova (verificar e completar)

Defina g(μ) = V_W(1, U) − V_W(μ, U). Mostre g(μ) ≥ 0 para todo μ ∈ (0, 1], com igualdade só em μ = 1.

**Estrutura de g**: g é piecewise affine em μ com kinks em ��_s^{R2} e μ_s^{R1}:
- [0, μ_s^{R2}]: affine (aggressive R1, aggressive R2)
- [μ_s^{R2}, μ_s^{R1}]: affine (aggressive R1, conservative R2)
- [μ_s^{R1}, 1]: affine (conservative R1)
- g é contínuo em μ_s^{R2} (V_W contínuo) e tem salto POSITIVO em μ_s^{R1} (V_W cai → g sobe)

**Estratégia**: como g é piecewise affine e contínuo nos dois primeiros segmentos, basta verificar g > 0 nos 4 vértices: μ = 0, μ_s^{R2}, μ_s^{R1}⁻, e μ_s^{R1}⁺. No segmento conservador, verificar g(μ_s^{R1}⁺) > 0 (g(1) = 0 é o ponto de igualdade).

### Vértice μ = 0

Usando budget identity (agressivo) e L(0) = 0:

$$(N-1)g(0) = (r - V_H(1)) - (1 - 0 - V_H(0)) = (r-1) - (V_H(1) - V_H(0))$$

Para computar V_H(1) − V_H(0), somar os slopes ao longo do caminho 0 → μ_s^{R2} → μ_s^{R1} → 1, incluindo o jump:

$$V_H(1) - V_H(0) = \underbrace{\mu_s^{R2} \cdot \frac{N(r-1)+(N-1)\beta(r-\alpha)}{N^2}}_{\text{sub-branch 1}} + \underbrace{(\mu_s^{R1}-\mu_s^{R2}) \cdot \frac{r-1}{N}}_{\text{sub-branch 2}} + \underbrace{(1-\mu_s^{R1})\frac{(N-1)\beta(r-1)}{N^2}}_{\text{jump}} + \underbrace{(1-\mu_s^{R1})\frac{(N-(N-1)\beta)(r-1)}{N^2}}_{\text{conservative}}$$

Os dois últimos termos (jump + conservative) combinam:

$$(1-\mu_s^{R1})\frac{(r-1)[(N-1)\beta + N - (N-1)\beta]}{N^2} = \frac{(1-\mu_s^{R1})(r-1)}{N}$$

E o sub-branch 2 contribui $(\mu_s^{R1}-\mu_s^{R2})(r-1)/N$. Somando:

$$\text{jump + con + sub2} = \frac{(1-\mu_s^{R2})(r-1)}{N}$$

Portanto:

$$V_H(1) - V_H(0) = \frac{(1-\mu_s^{R2})(r-1)}{N} + \mu_s^{R2} \cdot \frac{N(r-1)+(N-1)\beta(r-\alpha)}{N^2}$$

$$= \frac{(r-1)}{N} + \mu_s^{R2}\left[\frac{N(r-1)+(N-1)\beta(r-\alpha)}{N^2} - \frac{r-1}{N}\right]$$

$$= \frac{r-1}{N} + \frac{\mu_s^{R2}(N-1)\beta(r-\alpha)}{N^2}$$

Substituindo $\mu_s^{R2} = \alpha(r-1)/(r-\alpha)$:

$$V_H(1) - V_H(0) = \frac{r-1}{N} + \frac{\alpha\beta(r-1)(N-1)}{N^2}$$

Logo:

$$g(0) = \frac{(r-1) - (r-1)/N - \alpha\beta(r-1)(N-1)/N^2}{N-1} = \frac{(r-1)[(N-1)/N - \alpha\beta(N-1)/N^2]}{N-1} = \frac{(r-1)(N-\alpha\beta)}{N^2}$$

Como N ≥ 3 e αβ < α < 1/r ≤ 1 < N: **g(0) > 0**. ✓

### Vértice μ_s^{R2}

$$(N-1)g(\mu_s^{R2}) = (r - V_H(1)) - (V_e(\mu_s^{R2}) - L(\mu_s^{R2}) - V_H(\mu_s^{R2}))$$

$$= (1-\mu_s^{R2})(r-1) + L(\mu_s^{R2}) - (V_H(1) - V_H(\mu_s^{R2}))$$

V_H(1) − V_H(μ_s^{R2}): do caminho μ_s^{R2} → 1 (sub-branch 2 + jump + conservative):

$$V_H(1) - V_H(\mu_s^{R2}) = \frac{(1-\mu_s^{R2})(r-1)}{N}$$

L(μ_s^{R2}) = (N-1)μ_s^{R2} r(1-β)/N.

$$(N-1)g(\mu_s^{R2}) = (1-\mu_s^{R2})(r-1)\left(1 - \frac{1}{N}\right) + \frac{(N-1)\mu_s^{R2} r(1-\beta)}{N}$$

$$= \frac{(N-1)[(1-\mu_s^{R2})(r-1) + \mu_s^{R2} r(1-\beta)]}{N}$$

$$g(\mu_s^{R2}) = \frac{(1-\mu_s^{R2})(r-1) + \mu_s^{R2} r(1-\beta)}{N}$$

Ambos os termos são positivos (r>1 e β<1): **g(μ_s^{R2}) > 0**. ✓

### Vértice μ_s^{R1}⁻ (lado agressivo)

Mesmo cálculo com μ_s^{R1} no lugar de μ_s^{R2}:

$$V_H(1) - V_H(\mu_s^{R1,-}) = \frac{(1-\mu_s^{R1})(r-1)}{N}$$

(aqui usamos: jump + conservative = (1−μ_s)(r−1)/N, e o sub-branch 2 contribution = 0 pois estamos em μ_s^{R1}).

$$g(\mu_s^{R1,-}) = \frac{(1-\mu_s^{R1})(r-1) + \mu_s^{R1} r(1-\beta)}{N} > 0 \quad \checkmark$$

### Vértice μ_s^{R1}⁺ (lado conservador)

$$(N-1)g(\mu_s^{R1,+}) = (r - V_H(1)) - (V_e(\mu_s^{R1}) - V_H(\mu_s^{R1,+}))$$

$$= (1-\mu_s^{R1})(r-1) - (1-\mu_s^{R1})\frac{(N-(N-1)\beta)(r-1)}{N^2}$$

$$= (1-\mu_s^{R1})(r-1)\frac{(N-1)(N+\beta)}{N^2}$$

$$g(\mu_s^{R1,+}) = \frac{(1-\mu_s^{R1})(r-1)(N+\beta)}{N^2} > 0 \quad \checkmark$$

### Conclusão

g é piecewise affine, contínuo em [0, μ_s^{R2}] e [μ_s^{R2}, μ_s^{R1}), e positivo nos endpoints de cada segmento affine. Portanto g > 0 em todo [0, μ_s^{R1}).

Em [μ_s^{R1}, 1], g é affine com g(μ_s^{R1}⁺) > 0 e g(1) = 0. Portanto g ≥ 0 em [μ_s^{R1}, 1], com igualdade só em μ = 1.

Logo V_W(μ, U) ≤ V_W(1, U) para todo μ ∈ (0, 1]. □

---

## O que fazer

1. **Verificar** cada cálculo algébrico do esqueleto acima. Em particular:
   - A fórmula V_H(1) − V_H(0) = (r−1)/N + αβ(r−1)(N−1)/N².
   - A simplificação V_H(1) − V_H(μ_s^{R2}) = (1−μ_s^{R2})(r−1)/N.
   - Que o slope de V_H no sub-branch 2 (aggressive R1, conservative R2) é (r−1)/N.
   - Que o jump + conservative slopes combinam para dar (1−μ_s)(r−1)/N.

2. **Formalizar** a prova em notação limpa, pronta para inserir em appendix. Formato LaTeX.

3. **Checar o caso α ≥ ᾱ** (μ_s^{R1} ≤ μ_s^{R2}): neste caso, todo o regime agressivo está no sub-branch 1 (aggressive R2). A prova simplifica (só 2 vértices: 0 e μ_s^{R1}). Verificar que os mesmos argumentos se aplicam.

4. **Rodar** `scripts/test_supEU_lt_1.R` e `scripts/test_VW_monotonicity.R` para confirmar consistência.

5. **Salvar** a prova em `notes/2026-04-25_prova_lemmaX.md`.

## Arquivos relevantes

- `formal_model_v3.Rmd` — paper (A.6 budget, A.7 entry thresholds, B.5 decomposição de V_H)
- `scripts/model_functions.R` — funções R do modelo
- `scripts/test_supEU_lt_1.R` — teste numérico (espera 0 violações)
- `scripts/test_VW_monotonicity.R` — teste numérico (espera 0 violações, ratio = 1.0)
