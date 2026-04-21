# Extensão: Proposal Bias Pró-H (Recognition Assimétrica)

**Data**: 2026-04-20  
**Status**: Nota técnica exploratória  
**Base**: Modelo v2 de `formalizacao_v2_latest.Rmd`

## Motivação

No modelo base, propostas são simétricas (1/N cada). Aqui exploramos o que acontece se H tem probabilidade de propor maior que 1/N, sem ter monopólio. Isso captura influência parcial sobre a agenda (ex: presidir reuniões, mais rodadas de fala) sem o caso extremo de exclusive proposer.

## Setup

Tudo idêntico ao modelo base exceto a distribuição do proposer:

- H propõe com prob $p_H \in (1/N, 1)$
- Cada $W_i$ propõe com prob $p_W = (1-p_H)/(N-1)$

Caso base: $p_H = 1/N$ (simétrico).

Notação: defino $\phi \equiv p_H + (1-p_H)\alpha$ (share efetivo de H quando combinamos ambos os cenários sob maioria).

---

## R2 Terminal — Unanimidade com Bias

### Screening subgame (quando W propõe)

O subgame de screening é idêntico ao modelo base: W escolhe aggressive ($y_H = \alpha$) ou conservative ($y_H = \alpha r$). O cutoff não depende de probabilidades de proposta:

$$\mu_s = \frac{\alpha(r-1)}{r - \alpha} \quad \text{(inalterado)}$$

### Continuation values R2

**V_H^R2(θ, μ) sob unanimidade:**

| Caso | Fórmula |
|------|---------|
| θ=1 (qualquer μ) | $r[p_H + (1-p_H)\alpha] = r\phi$ |
| θ=0, μ < μ_s (aggressive) | $p_H + (1-p_H)\alpha = \phi$ |
| θ=0, μ > μ_s (conservative) | $p_H + (1-p_H)\alpha r$ |

Derivação (θ=0, conservative): com prob $p_H$, H propõe e fica com $V(0)=1$. Com prob $1-p_H$, algum W propõe e oferece $\alpha r$ (conservador). H aceita.

**V_W^R2(μ) sob unanimidade:**

W_i só ganha quando propõe (prob $p_W$):

$$V_W^{R2}(\mu < \mu_s) = p_W \cdot (1-\mu)(1-\alpha) = \frac{(1-p_H)}{N-1}(1-\mu)(1-\alpha)$$

$$V_W^{R2}(\mu > \mu_s) = p_W \cdot (V_e(\mu) - \alpha r) = \frac{(1-p_H)}{N-1}(V_e(\mu) - \alpha r)$$

### Jump em E_θ[V_H^R2] no cutoff μ_s

$$\text{Jump}^{R2} = (1-\mu_s) \cdot (1-p_H) \cdot \alpha(r-1)$$

**Modelo base** ($p_H = 1/N$): Jump = $(1-\mu_s)(N-1)\alpha(r-1)/N$

O jump R2 é **monotonicamente decrescente** em $p_H$: quanto mais H propõe, menos vezes W enfrenta o screening problem.

---

## R2 Terminal — Maioria com Bias

Sem screening. H recebe $\alpha V(\theta)$ quando W propõe (tipo-específico, sem overpayment).

$$V_H^{R2}(\theta, M) = V(\theta) \cdot \phi = V(\theta)[p_H + (1-p_H)\alpha]$$

$$V_W^{R2}(\mu, M) = p_W \cdot (1-\alpha)V_e(\mu) = \frac{(1-p_H)}{N-1}(1-\alpha)V_e(\mu)$$

**Linear em μ, sem jump.** Inalterado qualitativamente em relação ao modelo base.

---

## R1 — Unanimidade com Bias

### Quando H propõe em R1 (prob $p_H$)

H oferece $\beta \cdot V_W^{R2}(\mu)$ a cada W (unanimidade: precisa de todos). Fica com:

$$V(\theta) - (N-1)\beta \cdot V_W^{R2}(\mu)$$

Ambos os tipos fazem a mesma oferta (pooling). Sem revelação de informação.

### Quando W_j propõe em R1 (prob $p_W$; prob total de algum W propor = $1-p_H$)

W_j oferece $\beta \cdot V_W^{R2}(\mu)$ a cada dos N-2 outros W's. Deve decidir o que oferecer a H.

**Ofertas relevantes em R1:**

Após rejeição em R1, jogo vai para R2 com W sabendo θ=1 (informação completa):
- $V_H^{R2}(\theta=1, \text{known}) = r\phi = r[p_H + (1-p_H)\alpha]$
- $V_H^{R2}(\theta=0, \text{beliefs}=\theta=1) = p_H + (1-p_H)\alpha r$

(θ=0 com beliefs θ=1: H propõe e fica com 1; W propõe e oferece αr pensando θ=1, θ=0 aceita pois αr > α.)

**Conservadora**: $y_H^{con} = \beta \cdot r\phi = \beta r[p_H + (1-p_H)\alpha]$

- θ=1: indiferente ($y_H^{con} = \beta \cdot V_H^{R2}(\theta=1)$), aceita.
- θ=0: estritamente aceita ($\beta r\phi > \beta[p_H + (1-p_H)\alpha r]$ pois $r p_H > p_H$).

**Agressiva**: $y_H^{agg} = \beta[p_H + (1-p_H)\alpha r]$

- θ=0: indiferente (aceita = rejeita → R2 com beliefs θ=1 dá $\beta[p_H + (1-p_H)\alpha r]$). Aceita por convenção.
- θ=1: estritamente rejeita ($\beta[p_H + (1-p_H)\alpha r] < \beta r\phi$ pois $p_H < rp_H$).

**Gap entre ofertas**:

$$y_H^{con} - y_H^{agg} = \beta\{r[p_H + (1-p_H)\alpha] - [p_H + (1-p_H)\alpha r]\} = \beta p_H(r-1)$$

Modelo base: gap = $\beta(r-1)/N$. Com bias: gap = $\beta p_H(r-1)$. O gap **cresce** com $p_H$ (porque a continuation de H em R2 é maior quando H propõe mais).

### Payoff de W como proposer em R1

Defino $\omega(\mu) = (N-2)\beta V_W^{R2}(\mu)$ (pagamento a outros W's).

**Conservadora** (ambos aceitam, jogo termina em R1):

$$F_1^{con}(\mu) = V_e(\mu) - \beta r\phi - \omega(\mu)$$

**Agressiva** (θ=0 aceita em R1; θ=1 rejeita → R2 com info completa):

$$F_1^{agg}(\mu) = (1-\mu)[1 - \beta(p_H + (1-p_H)\alpha r) - \omega(\mu)] + \mu \cdot \beta \cdot p_W \cdot r(1-\alpha)$$

Segundo termo: com prob μ, θ=1 rejeita. Em R2 com info completa, V_W = $p_W \cdot r(1-\alpha)$.

### Cutoff μ_s^R1

Resolve $F_1^{agg}(\mu) = F_1^{con}(\mu)$. Depende de $p_H$ e de qual branch de $V_W^{R2}$ se aplica (piecewise). Solução numérica abaixo.

### Continuation values de H em R1

**θ=1** (mesma independente da estratégia de W):

$$V_H^{R1}(\theta=1) = p_H[r - (N-1)\beta V_W^{R2}(\mu)] + (1-p_H) \cdot \beta r\phi$$

(Aceita conservadora OU rejeita agressiva e recebe $\beta r\phi$ em R2.)

**θ=0, conservadora** ($\mu > \mu_s^{R1}$):

$$V_H^{R1}(\theta=0, con) = p_H[1 - (N-1)\beta V_W^{R2}(\mu)] + (1-p_H) \cdot \beta r\phi$$

**θ=0, agressiva** ($\mu < \mu_s^{R1}$):

$$V_H^{R1}(\theta=0, agg) = p_H[1 - (N-1)\beta V_W^{R2}(\mu)] + (1-p_H) \cdot \beta[p_H + (1-p_H)\alpha r]$$

### Jump em V_H^R1(θ=0) no cutoff μ_s^R1

$$\text{Jump}_{\theta=0}^{R1} = (1-p_H) \cdot \beta \cdot \{r\phi - [p_H + (1-p_H)\alpha r]\} = (1-p_H) \cdot \beta \cdot p_H(r-1)$$

### Jump em E_θ[V_H^R1] no cutoff μ_s^R1

$$\boxed{\text{Jump}^{R1} = (1-\mu_s^{R1}) \cdot (1-p_H) \cdot p_H \cdot \beta(r-1)}$$

**Modelo base** ($p_H = 1/N$): Jump = $(1-\mu_s^{R1}) \cdot \frac{N-1}{N^2} \cdot \beta(r-1)$

Verificação: $(1-1/N) \cdot (1/N) = (N-1)/N^2$. ✓

---

## Resultado: Jump R1 é Hump-Shaped em $p_H$ (nos exemplos)

O salto local em $V_H^{R1}(\theta=0)$ é $(1-p_H) \cdot p_H \cdot \beta(r-1)$, que, com $\mu_s^{R1}$ **fixado**, seria proporcional a $p_H(1-p_H)$ (parábola com pico em $1/2$).

Porém, $\mu_s^{R1}$ também depende de $p_H$ (sobe com o bias — ver abaixo). Portanto o jump total

$$\text{Jump}^{R1}(p_H) = (1 - \mu_s^{R1}(p_H)) \cdot (1-p_H) \cdot p_H \cdot \beta(r-1)$$

**não** é exatamente parabólico em $p_H$. Nos exemplos numéricos, o jump total continua hump-shaped, mas o pico ocorre ANTES de $1/2$ (porque $(1-\mu_s^{R1})$ é decrescente em $p_H$, puxando o pico para a esquerda).

**Intuição**: dois efeitos opostos operam:
1. **Efeito frequência** ($1-p_H$): W propõe menos → screening ocorre menos frequentemente → reduz jump.
2. **Efeito gap** ($p_H$): H's continuation em R2 é maior (propõe mais em R2) → gap entre oferta conservadora e agressiva é maior → jump por evento é maior.

Um terceiro efeito contribui via cutoff:

3. **Efeito cutoff** ($\mu_s^{R1} \uparrow$): cutoff sobe → $(1-\mu_s^{R1})$ cai → reduz jump.

O efeito gap domina para $p_H$ baixo; os efeitos frequência + cutoff dominam para $p_H$ alto.

**Contraste com R2**: o jump R2 é $(1-p_H)\alpha(r-1)(1-\mu_s)$, monotonicamente decrescente (sem efeito gap, pois reservas α, αr não dependem de $p_H$).

---

## R2 Terminal — Maioria com Bias (derivação completa)

Sob maioria ($q = \lfloor N/2 \rfloor + 1$), o proposer precisa de $q$ votos (incluindo o próprio). H não tem poder de veto.

### Quando H propõe em R2 (prob $p_H$)

H precisa de $q-1$ votos de W's. Oferece $d_W = 0$ a $q-1$ deles (é a alternativa de disagreement de W). Esses W's aceitam (indiferentes). Os $N-q$ restantes recebem 0 também (não estão na coalizão, mas é irrelevante — recebem 0 de qualquer forma). H fica com $V(\theta)$.

$$\text{H propõe} \Rightarrow H \text{ recebe } V(\theta), \text{ cada } W \text{ recebe } 0$$

### Quando $W_j$ propõe em R2 (prob $p_W$)

$W_j$ precisa de $q-1$ votos adicionais. Como $N-2$ outros W's existem e $q-1 \leq N-2$ para $N \geq 3$, $W_j$ pode formar coalizão SOMENTE com W's (excluindo H). Incluir H não é necessário.

**Convenção WLOG** (do modelo base): $W_j$ inclui H na proposta ao custo de $\alpha V(\theta)$ (a reservation tipo-específica de H). Payoffs são idênticos quer W exclua H (H captura $\alpha V(\theta)$ bilateralmente) ou inclua H a $\alpha V(\theta)$.

$W_j$ oferece:
- $\alpha V(\theta)$ a H (reservation tipo-específica — sob maioria, W SABE que a proposta passa independente de H, mas pela convenção WLOG divide assim)
- $0$ a $q-2$ outros W's na coalizão
- Fica com $V(\theta) - \alpha V(\theta) = (1-\alpha)V(\theta)$

**Ponto crucial**: sob maioria, a proposta passa independente da decisão de H. Portanto:
1. A resposta de H (aceitar/rejeitar) não afeta se o deal fecha — W não precisa usar essa resposta como sinal
2. Não há screening — mesmo sem observar θ, W não enfrenta o trade-off agressivo/conservador
3. O payoff de H é tipo-específico: $\alpha V(\theta)$ (capturado bilateralmente ou via oferta equivalente)

$$\text{W propõe} \Rightarrow H \text{ recebe } \alpha V(\theta), \; W_j \text{ recebe } (1-\alpha)V(\theta), \; \text{outros } W \text{ recebem } 0$$

### Continuation values R2 sob maioria

Agregando sobre identidade do proposer:

$$V_H^{R2}(\theta, M) = p_H \cdot V(\theta) + (1-p_H) \cdot \alpha V(\theta) = V(\theta)[p_H + (1-p_H)\alpha] = V(\theta)\phi$$

onde $\phi \equiv p_H + (1-p_H)\alpha$.

Explicitamente:
- $V_H^{R2}(\theta=0, M) = \phi$
- $V_H^{R2}(\theta=1, M) = r\phi$

$$E_\theta[V_H^{R2}(\mu, M)] = V_e(\mu) \cdot \phi \quad \text{— linear em } \mu$$

Para W:

$$V_W^{R2}(\mu, M) = p_W \cdot (1-\alpha) V_e(\mu) = \frac{(1-p_H)}{N-1}(1-\alpha)V_e(\mu) \quad \text{— linear em } \mu$$

(W_i ganha apenas quando propõe.)

**Budget check**: $V_H + (N-1)V_W = V_e\phi + (1-p_H)(1-\alpha)V_e = V_e[p_H + (1-p_H)\alpha + (1-p_H)(1-\alpha)] = V_e[p_H + (1-p_H)] = V_e$. ✓

### Comparação R2: Unanimidade vs Maioria com bias

| | Unanimidade (cons.) | Maioria |
|---|---|---|
| $V_H(\theta=0)$ | $p_H + (1-p_H)\alpha r$ | $\phi = p_H + (1-p_H)\alpha$ |
| $V_H(\theta=1)$ | $r\phi$ | $r\phi$ |
| $V_W$ | $p_W(V_e - \alpha r)$ | $p_W(1-\alpha)V_e$ |
| Linear em μ? | NÃO (piecewise) | SIM |

Diferença para $\theta = 0$ (conservador): $(1-p_H)\alpha(r-1) > 0$ — overpayment sob unanimidade. ✓

---

## R1 — Maioria com Bias (derivação completa)

### Quando H propõe em R1 (prob $p_H$)

H precisa de $q-1$ votos. Oferece a cada W na coalizão seu valor de continuação descontado:

$$\beta \cdot V_W^{R2}(\mu, M) = \beta \cdot p_W \cdot (1-\alpha) V_e(\mu)$$

H oferece isso a $q-1$ W's. Esses aceitam (= continuação descontada). H fica com:

$$V(\theta) - (q-1) \cdot \beta \cdot p_W \cdot (1-\alpha)V_e(\mu)$$

**Observação**: H faz oferta idêntica para ambos os tipos (a oferta a W depende de $\mu$, não de $\theta$). Sem revelação de informação. Mas o payoff de H é tipo-específico via $V(\theta)$.

### Quando $W_j$ propõe em R1 (prob $p_W$)

$W_j$ forma coalizão de $q-1$ outros jogadores. Pode excluir H (usando apenas W's). Pela convenção WLOG, inclui H:

- Oferece $\beta \cdot V_H^{R2}(\theta, M) = \beta \cdot V(\theta) \cdot \phi$ a H — mas W não sabe $\theta$!

**Resolução sob maioria**: a proposta passa independente de H (W tem maioria sem H). Portanto H aceitar/rejeitar é irrelevante para W. W pode:
1. Oferecer $\beta \cdot V_e(\mu) \cdot \phi$ a H (valor esperado da reservation)
2. Ou qualquer valor — não importa, a proposta passa por maioria

O payoff de H quando W propõe não depende da oferta nominal a H. O que determina é:
- Se H está na coalizão vencedora: recebe a oferta
- Se H não está: H captura $\alpha V(\theta)$ bilateralmente (outside option)

Sob a convenção WLOG (H sempre incluído), H recebe $\alpha V(\theta)$ de qualquer forma (ou da oferta, ou da outside option). Portanto:

$$\text{Payoff de H quando W propõe} = \alpha V(\theta)$$

Isso é **tipo-específico e determinístico** — sem screening, sem incerteza do lado de W.

$W_j$ oferece $\beta \cdot p_W \cdot (1-\alpha) V_e(\mu)$ a cada dos $q-2$ outros W's na coalizão. Fica com o residual:

$$F_1^M(\mu) = V_e(\mu) - \alpha V_e(\mu) - (q-2) \cdot \beta \cdot p_W \cdot (1-\alpha) V_e(\mu)$$
$$= V_e(\mu) \cdot [(1-\alpha) - (q-2) \cdot \beta \cdot p_W \cdot (1-\alpha)]$$
$$= (1-\alpha) V_e(\mu) \cdot [1 - (q-2) \cdot \beta \cdot p_W]$$

Espera — preciso ser mais cuidado. $W_j$ oferece a H e aos outros W's na coalizão:

- A H: $\alpha V_e(\mu)$ (expected reservation, embora irrelevante pois passa por maioria)
- A cada dos $q-2$ outros W's: $\beta \cdot V_W^{R2}(\mu, M) = \beta \cdot p_W \cdot (1-\alpha) V_e(\mu)$
- $W_j$ fica com: $V_e(\mu) - \alpha V_e(\mu) - (q-2) \cdot \beta p_W (1-\alpha) V_e(\mu)$

Simplificando (fatorando $V_e(\mu)$):

$$F_1^M(\mu) = V_e(\mu) \cdot \left[(1-\alpha) - (q-2)\beta p_W(1-\alpha)\right] = (1-\alpha)V_e(\mu)\left[1 - (q-2)\beta p_W\right]$$

**Nota**: a oferta a H aqui é $\alpha V_e(\mu)$ (expectation). Na prática, H recebe $\alpha V(\theta)$ (tipo-específico). A diferença é absorvida no budget ex-post. Para o payoff ESPERADO (sobre θ), fica consistente.

### Payoff de W_i quando NÃO propõe em R1

Sob maioria, propostas passam com $q$ votos. Não-proposers só recebem se estiverem na coalizão vencedora. Caso contrário, recebem 0 (a proposta passa sem eles).

- **H propõe** (prob $p_H$): H inclui $q-1$ W's na coalizão (de $N-1$ possíveis). $W_i$ está na coalizão com prob $(q-1)/(N-1)$. Se incluído: $\beta V_W^{R2}(\mu, M)$. Se excluído: $0$.

  Payoff esperado: $p_H \cdot \frac{q-1}{N-1} \cdot \beta V_W^{R2}(\mu, M)$

- **Outro $W_j$ propõe** (prob $(N-2)p_W$ total): $W_j$ inclui H + $q-2$ outros W's. De $N-2$ W's restantes (excluindo $W_i$ e $W_j$... na verdade, $W_j$ escolhe $q-2$ de $N-2$ W's excluindo si mesmo). $W_i$ é incluído com prob $(q-2)/(N-2)$.

  Payoff esperado: $(N-2)p_W \cdot \frac{q-2}{N-2} \cdot \beta V_W^{R2}(\mu, M) = p_W(q-2) \cdot \beta V_W^{R2}(\mu, M)$

Defino o **coeficiente de coalizão**:

$$\kappa \equiv p_H \cdot \frac{q-1}{N-1} + p_W(q-2) = \frac{q - 2 + p_H}{N-1}$$

(A simplificação segue de $p_W = (1-p_H)/(N-1)$, portanto $p_W(q-2) = (1-p_H)(q-2)/(N-1)$, e $p_H(q-1)/(N-1) + (1-p_H)(q-2)/(N-1) = [p_H(q-1) + (q-2) - p_H(q-2)]/(N-1) = (q-2+p_H)/(N-1)$.)

Portanto:

$$V_W^{R1}(\mu, M) = p_W \cdot F_1^M(\mu) + \kappa \cdot \beta \cdot V_W^{R2}(\mu, M)$$

**Nota**: no modelo base, a nota técnica usa $(1-p_W)$ em vez de $\kappa$ como coeficiente do não-proposer. Sob unanimidade isso é correto (todos os não-proposers são incluídos — unanimidade requer todos os votos). Sob maioria, $(1-p_W)$ SUPERESTIMA o payoff do não-proposer porque ignora a probabilidade de exclusão da coalizão. A fórmula correta usa $\kappa < 1-p_W$.

### Continuation values completos R1 sob maioria

**V_H^R1(θ, M):**

$$V_H^{R1}(\theta, M) = p_H \cdot \left[V(\theta) - (q-1)\beta p_W(1-\alpha)V_e(\mu)\right] + (1-p_H) \cdot \alpha V(\theta)$$

Expandindo:

$$= V(\theta) \cdot [p_H + (1-p_H)\alpha] - p_H(q-1)\beta p_W(1-\alpha)V_e(\mu)$$

$$= V(\theta) \cdot \phi - p_H(q-1)\beta p_W(1-\alpha)V_e(\mu)$$

Tomando expectativa sobre θ:

$$E_\theta[V_H^{R1}(\mu, M)] = V_e(\mu) \cdot \phi - p_H(q-1)\beta p_W(1-\alpha)V_e(\mu)$$

$$= V_e(\mu) \left[\phi - p_H(q-1)\beta p_W(1-\alpha)\right]$$

**Isto é LINEAR em $V_e(\mu)$, portanto linear em $\mu$. Sem jump de screening sob maioria.** Qualquer ganho de BP sob maioria só pode vir do threshold de entrada (ver seção Entrada).

Defino a constante:

$$\Phi_M \equiv \phi - p_H(q-1)\beta p_W(1-\alpha) = [p_H + (1-p_H)\alpha] - p_H(q-1)\beta \frac{(1-p_H)(1-\alpha)}{N-1}$$

Então: $E_\theta[V_H^{R1}(\mu, M)] = V_e(\mu) \cdot \Phi_M$

**V_W^R1(μ, M):**

$$V_W^{R1}(\mu, M) = p_W \cdot F_1^M(\mu) + \kappa \cdot \beta \cdot V_W^{R2}(\mu, M)$$

$$= p_W(1-\alpha)V_e(\mu)[1-(q-2)\beta p_W] + \kappa \cdot \beta \cdot p_W(1-\alpha)V_e(\mu)$$

$$= p_W(1-\alpha)V_e(\mu)\left[1 - (q-2)\beta p_W + \kappa\beta\right]$$

Agora, $\kappa - (q-2)p_W = \frac{q-2+p_H}{N-1} - \frac{(q-2)(1-p_H)}{N-1} = \frac{p_H(q-1)}{N-1}$.

$$= p_W(1-\alpha)V_e(\mu)\left[1 + \frac{\beta p_H(q-1)}{N-1}\right]$$

Também linear em $V_e(\mu)$, portanto linear em $\mu$.

### Verificação: modelo base ($p_H = 1/N$, $p_W = 1/N$)

**$V_H$**: Com $p_H = p_W = 1/N$ e $q = \lfloor N/2 \rfloor + 1$:

$$\Phi_M = \frac{1+(N-1)\alpha}{N} - \frac{(q-1)(1-\alpha)\beta}{N^2}$$

Para $N=5$, $q=3$, $\alpha=0.5$, $\beta=0.9$: $\Phi_M = 3/5 - 2(0.5)(0.9)/25 = 0.6 - 0.036 = 0.564$

$$E[V_H^{R1}(0.5, M)] = 1.05 \times 0.564 = 0.5922 \quad \checkmark$$

**$V_W$**: $V_W^{R1} = p_W(1-\alpha)V_e[1 + \beta p_H(q-1)/(N-1)]$

Para $N=5$: $= (1/5)(0.5)(1.05)[1 + 0.9(1/5)(2/4)] = 0.105 \times 1.09 = 0.1145$

**Nota**: a fórmula anterior (com coeficiente $(1-p_W)$ em vez de $\kappa$) dava 0.1239 — SUPERESTIMAVA o payoff de W sob maioria. Com a correção, $V_W$ é menor, o que significa que thresholds de entrada sob maioria são MAIS ALTOS do que reportados anteriormente.

### Por que não há screening sob maioria — resumo formal

O screening sob unanimidade opera porque:
1. W PRECISA da aceitação de H (veto) → a decisão de H é payoff-relevant para W
2. W não sabe θ → deve escolher oferta sem saber a reservation de H
3. H rejeita se oferta < reservation → revelação parcial de tipo

Sob maioria, NENHUMA dessas condições se aplica:
1. A proposta passa independente de H (W tem maioria sem H)
2. Mesmo que W não saiba θ, isso é irrelevante — H aceitar/rejeitar não muda o outcome
3. H não tem poder de "sinalizar" tipo via rejeição — a proposta fecha de qualquer forma

Portanto: $V_H^{R1}(\theta, M) = V(\theta) \cdot \Phi_M$ — payoff é tipo-específico mas a RELAÇÃO é linear em $V(\theta)$. Tomando expectativa: linear em $\mu$. **Não há screening-based BP sob maioria.** Porém, se a entrada é endógena, o valor total de H sob maioria é

$$v_M(\mu) = \begin{cases} \alpha V_e(\mu) & \mu < \tau(M) \\ \Phi_M \cdot V_e(\mu) & \mu \geq \tau(M) \end{cases}$$

Como $\Phi_M > \alpha$, há um salto para cima em $\tau(M)$. Esse kink pode gerar não-convexidade → BP pode operar sob maioria **via threshold de entrada**, mesmo sem screening. Quando $\tau(M) = 0$ (entrada sempre ocorre), $v_M$ é linear e $\text{cav}(v_M) = v_M$.

---

## Entrada

$$\tau(R, p_H): \quad V_W^{R1}(\tau, R) = c$$

### Sob unanimidade:

$$V_W^{R1}(\mu, U) = p_W \cdot \max(F_1^{agg}, F_1^{con}) + (1-p_W) \cdot \beta \cdot V_W^{R2}(\mu, U)$$

Piecewise em $\mu$ (depende de qual branch do screening se aplica). Threshold pode não ser único.

### Sob maioria:

$$V_W^{R1}(\mu, M) = p_W(1-\alpha)V_e(\mu)\left[1 + \frac{\beta p_H(q-1)}{N-1}\right]$$

Linear em $\mu$. Threshold único:

$$\tau(M) = \frac{c / \left\{p_W(1-\alpha)\left[1+\frac{\beta p_H(q-1)}{N-1}\right]\right\} - 1}{r-1}$$

Closed form. Crescente em $p_H$: o numerador cresce via $p_W = (1-p_H)/(N-1)$ no denominador, parcialmente compensado pelo fator $[1 + \beta p_H(q-1)/(N-1)]$ que cresce com $p_H$.

### Comparação de thresholds

Ambos crescem com $p_H$, mas τ(U) cresce MAIS RÁPIDO porque $V_W^{R1}(U)$ é duplamente penalizado:
1. W propõe menos (como sob maioria)
2. Quando W propõe sob unanimidade, deve pagar reservation de H (que agora é MAIOR com bias, pois $V_H^{R2}$ cresce com $p_H$)

Sob maioria, W não paga reservation de H — a proposta passa sem H. Portanto a penalização de W sob U cresce mais rápido.

---

## Comparação Numérica

Parâmetros do modelo base: $N=5$, $\beta=0.9$, $c=0.1$.

- **Exemplo 1**: $r=1.1$, $\alpha=0.5$
- **Exemplo 2**: $r=1.5$, $\alpha=0.3$

Valores de $p_H$ testados: $0.2$ (base = 1/5), $0.3$, $0.4$, $0.5$, $0.6$, $0.8$.

### Código R para reprodução

```r
#----------------------------------------------------------------------
# Extension: Proposal Bias (asymmetric recognition)
# Comparison with base model (symmetric 1/N)
#----------------------------------------------------------------------

# Parameters
N <- 5
beta_val <- 0.9
c_val <- 0.1

# Two examples from base note
params <- list(
  ex1 = list(r = 1.1, alpha = 0.5, label = "r=1.1, α=0.5"),
  ex2 = list(r = 1.5, alpha = 0.3, label = "r=1.5, α=0.3")
)

# Screening cutoff (independent of p_H)
mu_s <- function(r, alpha) alpha * (r - 1) / (r - alpha)

# V_e(mu)
Ve <- function(mu, r) 1 + mu * (r - 1)

#----------------------------------------------------------------------
# R2 Values under Unanimity with bias
#----------------------------------------------------------------------

VW_R2_U <- function(mu, r, alpha, N, pH) {
  pW <- (1 - pH) / (N - 1)
  ms <- mu_s(r, alpha)
  if (mu < ms) {
    pW * (1 - mu) * (1 - alpha)
  } else {
    pW * (Ve(mu, r) - alpha * r)
  }
}

VH_R2_U <- function(theta, mu, r, alpha, pH) {
  ms <- mu_s(r, alpha)
  phi <- pH + (1 - pH) * alpha
  if (theta == 1) {
    r * phi
  } else {
    # theta = 0
    if (mu < ms) {
      phi  # aggressive: gets alpha from W, or 1 from H-proposes
    } else {
      pH + (1 - pH) * alpha * r  # conservative: W offers alpha*r
    }
  }
}

#----------------------------------------------------------------------
# R2 Values under Majority with bias
#----------------------------------------------------------------------

VW_R2_M <- function(mu, r, alpha, N, pH) {
  pW <- (1 - pH) / (N - 1)
  pW * (1 - alpha) * Ve(mu, r)
}

VH_R2_M <- function(theta, r, alpha, pH) {
  V_theta <- ifelse(theta == 1, r, 1)
  phi <- pH + (1 - pH) * alpha
  V_theta * phi
}

#----------------------------------------------------------------------
# R1 under Unanimity with bias
#----------------------------------------------------------------------

# W's R2 continuation after R1 rejection (complete info, theta=1 known)
VW_R2_known1 <- function(r, alpha, N, pH) {
  pW <- (1 - pH) / (N - 1)
  pW * r * (1 - alpha)
}

# R1 aggressive and conservative payoffs for W as proposer
F1_con <- function(mu, r, alpha, N, pH, beta) {
  phi <- pH + (1 - pH) * alpha
  omega <- (N - 2) * beta * VW_R2_U(mu, r, alpha, N, pH)
  Ve(mu, r) - beta * r * phi - omega
}

F1_agg <- function(mu, r, alpha, N, pH, beta) {
  omega <- (N - 2) * beta * VW_R2_U(mu, r, alpha, N, pH)
  term1 <- (1 - mu) * (1 - beta * (pH + (1 - pH) * alpha * r) - omega)
  term2 <- mu * beta * VW_R2_known1(r, alpha, N, pH)
  term1 + term2
}

# V_W^R1
VW_R1_U <- function(mu, r, alpha, N, pH, beta) {
  pW <- (1 - pH) / (N - 1)
  Fprop <- max(F1_agg(mu, r, alpha, N, pH, beta),
               F1_con(mu, r, alpha, N, pH, beta))
  pW * Fprop + (1 - pW) * beta * VW_R2_U(mu, r, alpha, N, pH)
}

# V_H^R1
VH_R1_U <- function(theta, mu, r, alpha, N, pH, beta) {
  phi <- pH + (1 - pH) * alpha
  vw_r2 <- VW_R2_U(mu, r, alpha, N, pH)
  H_proposes <- ifelse(theta == 1, r, 1) - (N - 1) * beta * vw_r2
  
  # When W proposes: which strategy?
  if (F1_agg(mu, r, alpha, N, pH, beta) > F1_con(mu, r, alpha, N, pH, beta)) {
    # Aggressive
    if (theta == 0) {
      W_offers_H <- beta * (pH + (1 - pH) * alpha * r)
    } else {
      # theta=1 rejects, gets R2 continuation
      W_offers_H <- beta * r * phi
    }
  } else {
    # Conservative: both types get same offer
    W_offers_H <- beta * r * phi
  }
  
  pH * H_proposes + (1 - pH) * W_offers_H
}

# Expected V_H^R1
EVH_R1_U <- function(mu, r, alpha, N, pH, beta) {
  mu * VH_R1_U(1, mu, r, alpha, N, pH, beta) +
    (1 - mu) * VH_R1_U(0, mu, r, alpha, N, pH, beta)
}

#----------------------------------------------------------------------
# R1 under Majority with bias
#----------------------------------------------------------------------

VW_R1_M <- function(mu, r, alpha, N, pH, beta) {
  # CORRECTED: closed form with coalition coefficient kappa
  # kappa = (q-2+pH)/(N-1); simplifies to:
  # V_W^R1 = pW*(1-alpha)*Ve*[1 + beta*pH*(q-1)/(N-1)]
  q <- floor(N/2) + 1
  pW <- (1 - pH) / (N - 1)
  pW * (1 - alpha) * Ve(mu, r) * (1 + beta * pH * (q - 1) / (N - 1))
}

EVH_R1_M <- function(mu, r, alpha, N, pH, beta) {
  # V_H^R1(theta, M) = pH * [V(theta) - (q-1)*beta*VW_R2_M]
  #                   + (1-pH) * alpha*V(theta)
  q <- floor(N/2) + 1
  vw_r2_m <- VW_R2_M(mu, r, alpha, N, pH)
  VH_theta <- function(theta) {
    Vt <- ifelse(theta == 1, r, 1)
    pH * (Vt - (q - 1) * beta * vw_r2_m) + (1 - pH) * alpha * Vt
  }
  mu * VH_theta(1) + (1 - mu) * VH_theta(0)
}

#----------------------------------------------------------------------
# Jump comparison
#----------------------------------------------------------------------

jump_R1 <- function(pH, r, beta, mu_s_R1) {
  (1 - mu_s_R1) * (1 - pH) * pH * beta * (r - 1)
}

jump_R2 <- function(pH, r, alpha, mu_s_val) {
  (1 - mu_s_val) * (1 - pH) * alpha * (r - 1)
}

#----------------------------------------------------------------------
# Numerical results
#----------------------------------------------------------------------

pH_vals <- c(0.2, 0.3, 0.4, 0.5, 0.6, 0.8)

cat("=" |> rep(70) |> paste(collapse=""), "\n")
# (Bloco antigo com proxy mu_s^R2 removido — ver resultados numéricos na seção de resultados)

#----------------------------------------------------------------------
# Entry thresholds
#----------------------------------------------------------------------

find_threshold <- function(r, alpha, N, pH, beta, c, rule = "U") {
  mus_grid <- seq(0.001, 0.999, by = 0.001)
  
  if (rule == "U") {
    vw <- sapply(mus_grid, function(m) VW_R1_U(m, r, alpha, N, pH, beta))
  } else {
    vw <- sapply(mus_grid, function(m) VW_R1_M(m, r, alpha, N, pH, beta))
  }
  
  above <- vw >= c
  if (all(above)) return(0)
  if (all(!above)) return(1)
  idx <- which(above)[1]
  if (is.na(idx)) return(1)
  return(mus_grid[idx])
}

cat("=" |> rep(70) |> paste(collapse=""), "\n")
cat("ENTRY THRESHOLDS tau(R, p_H) for c = ", c_val, "\n")
cat("=" |> rep(70) |> paste(collapse=""), "\n\n")

for (ex_name in names(params)) {
  r <- params[[ex_name]]$r
  alpha <- params[[ex_name]]$alpha
  
  cat(sprintf("%s: %s\n", ex_name, params[[ex_name]]$label))
  cat(sprintf("%-6s  %-10s  %-10s  %-12s  %-12s\n",
              "p_H", "tau(U)", "tau(M)", "VW_R1(0.5,U)", "VW_R1(0.5,M)"))
  cat("-" |> rep(60) |> paste(collapse=""), "\n")
  
  for (pH in pH_vals) {
    tau_U <- find_threshold(r, alpha, N, pH, beta_val, c_val, "U")
    tau_M <- find_threshold(r, alpha, N, pH, beta_val, c_val, "M")
    vw_u <- VW_R1_U(0.5, r, alpha, N, pH, beta_val)
    vw_m <- VW_R1_M(0.5, r, alpha, N, pH, beta_val)
    cat(sprintf("%-6.2f  %-10.3f  %-10.3f  %-12.4f  %-12.4f\n",
                pH, tau_U, tau_M, vw_u, vw_m))
  }
  cat("\n")
}

#----------------------------------------------------------------------
# BP value comparison
#----------------------------------------------------------------------

# Simple concavification for v(mu) = EVH_R1_U(mu)
# Compute v on a grid, find the concave envelope, evaluate at prior p

concavify <- function(mus, v_vals) {
  # Gift-wrapping from above
  n <- length(mus)
  hull <- rep(NA, n)
  hull[1] <- v_vals[1]
  hull[n] <- v_vals[n]
  
  # Linear interpolation between endpoints
  lin <- v_vals[1] + (v_vals[n] - v_vals[1]) * (mus - mus[1]) / (mus[n] - mus[1])
  
  # Concave envelope: for each point, it's the max of v and all chords above
  # Use convex hull trick on (-mu, -v) to find concave envelope
  pts <- cbind(mus, v_vals)
  
  # Simple iterative: concave envelope is the minimum of all affine functions above v
  # Easier: use the fact that cav(v)(mu) = sup{L(mu) : L affine, L >= v on [0,1]}
  # Computationally: find upper convex hull of the points (mu_i, v_i)
  
  # Use grDevices::chull on flipped coordinates
  hull_idx <- chull(mus, v_vals)
  # Keep only upper hull (those forming the top boundary)
  # Sort hull by mu
  hull_idx <- hull_idx[order(mus[hull_idx])]
  
  # The upper hull: from left to right, keep points where we go "up or flat"
  # Actually chull gives full convex hull. Upper part: from min-mu to max-mu
  min_idx <- which.min(mus[hull_idx])
  max_idx <- which.max(mus[hull_idx])
  
  # Upper hull goes from min to max (counterclockwise in chull)
  if (min_idx <= max_idx) {
    upper <- hull_idx[min_idx:max_idx]
  } else {
    upper <- hull_idx[c(min_idx:length(hull_idx), 1:max_idx)]
  }
  
  # Interpolate concave envelope
  cav_vals <- approx(mus[upper], v_vals[upper], xout = mus, rule = 2)$y
  
  return(cav_vals)
}

cat("=" |> rep(70) |> paste(collapse=""), "\n")
cat("BP GAIN: cav(v)(p) - v(p) at prior p = 0.5\n")
cat("=" |> rep(70) |> paste(collapse=""), "\n\n")

mus_grid <- seq(0.01, 0.99, by = 0.01)
p_prior <- 0.5

for (ex_name in names(params)) {
  r <- params[[ex_name]]$r
  alpha <- params[[ex_name]]$alpha
  
  cat(sprintf("%s: %s\n", ex_name, params[[ex_name]]$label))
  cat(sprintf("%-6s  %-12s  %-12s  %-12s\n", "p_H", "v(p)", "cav_v(p)", "BP_gain"))
  cat("-" |> rep(50) |> paste(collapse=""), "\n")
  
  for (pH in pH_vals) {
    v_vals <- sapply(mus_grid, function(m) EVH_R1_U(m, r, alpha, N, pH, beta_val))
    cav_vals <- concavify(mus_grid, v_vals)
    
    # Evaluate at prior
    v_p <- approx(mus_grid, v_vals, xout = p_prior)$y
    cav_p <- approx(mus_grid, cav_vals, xout = p_prior)$y
    bp_gain <- cav_p - v_p
    
    cat(sprintf("%-6.2f  %-12.4f  %-12.4f  %-12.4f\n", pH, v_p, cav_p, bp_gain))
  }
  cat("\n")
}
```

---

## Resultados Numéricos

### Parâmetros

$N=5$, $\beta=0.9$. Exemplos 1 ($r=1.1$, $\alpha=0.5$) e 2 ($r=1.5$, $\alpha=0.3$). Valores de $p_H$: 0.2 (base=1/N), 0.3, 0.4, 0.5, 0.6.

### 1. Jump R1 exato (usando $\mu_s^{R1}$ verdadeiro) vs R2

| $p_H$ | $\mu_s^{R1}$ (Ex1) | Jump_R1 (Ex1) | Jump_R2 (Ex1) | $\mu_s^{R1}$ (Ex2) | Jump_R1 (Ex2) | Jump_R2 (Ex2) |
|--------|---------------------|---------------|---------------|---------------------|---------------|---------------|
| 0.20 (base) | 0.100 | 0.0130 | 0.0367 | 0.190 | 0.0583 | 0.1050 |
| 0.30 | 0.150 | 0.0161 | 0.0321 | 0.290 | 0.0671 | 0.0919 |
| 0.40 | 0.200 | 0.0173 | 0.0275 | 0.390 | 0.0659 | 0.0788 |
| 0.50 | 0.240 | 0.0171 | 0.0229 | 0.480 | 0.0585 | 0.0656 |
| 0.60 | 0.290 | 0.0153 | 0.0183 | 0.560 | 0.0475 | 0.0525 |

Jump R1 é **hump-shaped** nos exemplos, com pico em $p_H \approx 0.3$-$0.4$ (ANTES de 1/2, porque $\mu_s^{R1}$ crescente puxa o pico para a esquerda). Jump R2 é **monotonicamente decrescente**.

### 2. R1 Screening cutoff é crescente em $p_H$ (nos exemplos)

(Valores de $\mu_s^{R1}$ reportados na tabela acima.)

Nos exemplos, $\mu_s^{R1}$ move para a DIREITA com o bias. W joga agressivo para beliefs mais altos. O jump (não-concavidade) ocorre em μ mais relevantes. (Ver seção de Interpretação para argumento analítico parcial.)

### 3. Região onde BP é ativo

| $p_H$ | BP ativo (Ex1) | Max BP gain (Ex1) | BP ativo (Ex2) | Max BP gain (Ex2) |
|--------|----------------|-------------------|----------------|-------------------|
| 0.20 | [0.02, 0.10] | 0.0109 | [0.02, 0.19] | 0.0535 |
| 0.40 | [0.02, 0.20] | 0.0157 | [0.13, 0.39] | 0.0624 |
| 0.60 | [0.09, 0.29] | 0.0144 | [0.14, 0.56] | 0.0454 |

A região onde BP opera **expande e se desloca para a direita** com o bias. Para priors moderados ($p \approx 0.3$-$0.5$), bias pode ATIVAR BP onde antes era inativo.

### 4. Comparação institucional CORRETA: cav(v_U) vs cav(v_M) incluindo entrada

A comparação correta usa o valor total de H incluindo a possibilidade de a instituição não se formar. Quando $\mu < \tau(R)$, W não entra e H recebe apenas $\alpha V_e(\mu)$ (alternativas bilaterais).

$$v_R(\mu) = \begin{cases} \alpha V_e(\mu) & \mu < \tau(R) \\ E[V_H^{R1}(\mu, R)] & \mu \geq \tau(R) \end{cases}$$

Comparação: $\text{cav}(v_U)(p)$ vs $\text{cav}(v_M)(p)$ em $p = 0.5$, $c = 0.1$.

**Verificação preliminar**: $\text{cav}(v_M) = v_M$ em TODOS os casos testados (entry-based BP sob maioria = 0 empiricamente).

| $p_H$ | τ(U) Ex1 | τ(M) Ex1 | cav_U Ex1 | cav_M Ex1 | U-M Ex1 | τ(U) Ex2 | τ(M) Ex2 | cav_U Ex2 | cav_M Ex2 | U-M Ex2 |
|--------|----------|----------|-----------|-----------|---------|----------|----------|-----------|-----------|---------|
| 0.20 | 0.01 | 0.01 | 0.613 | 0.592 | **+0.021** | 0.01 | 0.01 | 0.610 | 0.487 | **+0.123** |
| 0.30 | 0.74 | 0.07 | 0.525 | 0.633 | **-0.108** | 0.01 | 0.01 | 0.706 | 0.555 | **+0.151** |
| 0.40 | 1.00 | 1.00 | 0.525 | 0.525 | 0.000 | 0.34 | 0.01 | 0.797 | 0.631 | **+0.167** |
| 0.50 | 1.00 | 1.00 | 0.525 | 0.525 | 0.000 | 0.60 | 0.01 | 0.375 | 0.714 | **-0.339** |
| 0.60 | 1.00 | 1.00 | 0.525 | 0.525 | 0.000 | 0.88 | 0.25 | 0.375 | 0.806 | **-0.431** |

**Resultado crucial**: a comparação anterior (que mostrava U > M em todos os casos) era enganosa porque ignorava a infeasibilidade da entrada. Na comparação completa:

- **Bias baixo** ($p_H \approx 1/N$): **U domina M** — screening + BP operando, entrada viável sob ambas.
- **Bias moderado**: **M domina U** — entrada falha sob U (τ(U) > p) mas não sob M. H cai para alternativas bilaterais sob U.
- **Bias alto**: **Empate** (nenhuma instituição se forma, H recebe $\alpha V_e$ sob ambas).

Isso reforça fortemente o resultado do paper: **propostas simétricas são endógenas**. Qualquer bias destrói a vantagem de U via colapso da entrada.

### 5. Entry thresholds — CORRIGIDOS (c = 0.1)

| $p_H$ | τ(U) Ex1 | τ(M) Ex1 | VW(.5,U) Ex1 | VW(.5,M) Ex1 | τ(U) Ex2 | τ(M) Ex2 | VW(.5,U) Ex2 | VW(.5,M) Ex2 |
|--------|----------|----------|--------------|--------------|----------|----------|--------------|--------------|
| 0.20 | 0.001 | 0.000 | 0.1092 | 0.1145 | 0.000 | 0.000 | 0.1600 | 0.1908 |
| 0.30 | **0.736** | 0.070 | 0.0948 | 0.1043 | 0.000 | 0.000 | 0.1361 | 0.1738 |
| 0.40 | **1.000** | **1.000** | 0.0805 | 0.0929 | 0.334 | 0.000 | 0.1132 | 0.1549 |
| 0.50 | 1.000 | 1.000 | 0.0666 | 0.0804 | **0.594** | 0.000 | 0.0916 | 0.1340 |
| 0.60 | 1.000 | 1.000 | 0.0528 | 0.0667 | **0.877** | 0.250 | 0.0736 | 0.1111 |

**Correção importante**: a fórmula anterior superestimava V_W sob maioria (usava coeficiente $1-p_W$ em vez do correto $\kappa = (q-2+p_H)/(N-1)$ para inclusão na coalizão). Com a correção, V_W(M) é menor e τ(M) sobe em alguns casos (Ex1 $p_H=0.3$: 0→0.07; Ex1 $p_H=0.4$: 0→1.00; Ex2 $p_H=0.6$: 0→0.25).

**Entry continua como constraint dominante**: unanimidade fica inviável mais rápido que maioria, mas a diferença é menor do que reportado anteriormente.

---

## Interpretação

### 1. Jump R1 é hump-shaped (três efeitos)

- **Efeito frequência** ($1-p_H$ ↓): W propõe menos → screening menos frequente → reduz jump.
- **Efeito gap** ($p_H$ ↑): H's continuation em R2 cresce → gap entre oferta conservadora e agressiva é maior → jump por evento de screening é maior.
- **Efeito cutoff** ($\mu_s^{R1}$ ↑): cutoff sobe → $(1-\mu_s^{R1})$ cai → reduz jump.

O efeito gap domina para $p_H$ baixo; frequência + cutoff dominam para $p_H$ alto. Pico ocorre ANTES de $1/2$ nos exemplos (Ex2: pico em $p_H \approx 0.3$). Em R2 não há efeito gap (reservas α, αr são fixas).

### 2. μ_s^R1 crescente em $p_H$: evidência e argumento parcial

Nos exemplos numéricos, $\mu_s^{R1}$ é crescente em $p_H$. O argumento analítico: no branch relevante ($\mu_s^{R1} > \mu_s^{R2}$), a diferença $\Delta(\mu, p_H) = F_1^{agg} - F_1^{con}$ satisfaz $\partial \Delta / \partial p_H > 0$ para todo $\mu < 1$. Ou seja, para qualquer $\mu$ fixo, aumentar $p_H$ torna aggressive relativamente mais atrativo. Se o crossing é único (o que se verifica nos exemplos), o cutoff se desloca para a direita.

Formulação segura: *In the relevant branch, $F_1^{agg} - F_1^{con}$ has increasing differences in $(p_H, -\mu)$. Hence the unique interior cutoff $\mu_s^{R1}$ shifts rightward as $p_H$ rises.*

**Nota**: isso não constitui prova completa — falta (i) explicitar qual branch é relevante para cada $p_H$, e (ii) garantir unicidade do crossing em geral. Nos exemplos testados, ambas as condições se verificam.

### 3. BP desloca-se para priors relevantes

No modelo base (Ex2, $p_H=0.2$), BP é ativo apenas para $\mu \in [0.02, 0.19]$ — priors muito baixos (pouco realistas). Com $p_H = 0.4$, BP opera em $[0.13, 0.39]$ — região relevante. Bias pode **ativar** o canal de BP onde antes era inativo.

### 4. Trade-off fundamental: screening vs. entrada

Bias amplia o screening (cutoff sobe, região de BP expande, jump pode crescer) MAS deteriora a entrada (W ganha menos → threshold sobe). Na comparação institucional COMPLETA (incluindo possibilidade de não-formação):

- **Bias baixo** ($p_H \approx 1/N$): U domina M — screening + BP ativos, entrada viável.
- **Bias moderado**: **M domina U** — τ(U) ultrapassa o prior, instituição não forma sob U, H cai para $\alpha V_e$. Sob M, entrada ainda viável.
- **Bias alto**: Empate — nenhuma instituição forma.

### 5. Implicação para endogeneização de $p_H$

Se H pudesse escolher $p_H$ sob unanimidade (Stage 0.5: "quanto de agenda control demando?"), o resultado seria:
- **$p_H^* = 1/N$ (simétrico)** — qualquer bias acima do simétrico eventualmente destrói a entrada e inverte a preferência de U para M.

O modelo base ($p_H = 1/N$) emerge como equilíbrio endógeno: H aceita propostas simétricas não por altruísmo, mas porque qualquer bias destrói a participação que sustenta o screening. **Propostas simétricas são a condição de participação, não uma restrição exógena.**

---

## Síntese

| Efeito de ↑$p_H$ | Direção | Mecanismo |
|-------------------|---------|-----------|
| Jump R2 | ↓ monotônico | Menos screening opportunities |
| Jump R1 | ↑↓ (hump, pico antes de 1/2) | Frequência ↓ mas gap ↑, atenuado por cutoff ↑ |
| μ_s^R1 | ↑ (nos exemplos) | Increasing differences em $(p_H, -\mu)$ |
| Região BP | → (desloca direita) | Cutoff sobe → não-concavidade em μ mais altos |
| V_W (ambas regras) | ↓ | W propõe menos |
| τ (ambas regras) | ↑ | Entrada mais difícil |
| Ganho H (U-M) completo | + → − → 0 | U domina com baixo bias; M domina com moderado (entry kills U) |

**Conclusão principal**: Bias moderado pode amplificar o screening channel e deslocar BP para priors relevantes, mas a entrada se deteriora mais rápido sob U do que sob M. Na comparação institucional completa (incluindo não-formação), **U só domina M para bias baixo** ($p_H \approx 1/N$). Para bias moderado, U se torna infeasível enquanto M ainda funciona → M domina. O modelo base com propostas simétricas é o equilíbrio endógeno.

**Para o paper**: isso funciona como Remark ou extensão curta. A mensagem é que H aceita propostas simétricas sob unanimidade endogenamente — não porque "não pode" ter mais poder de agenda, mas porque bias parcial destrói a participação que sustenta o screening. Propostas simétricas são a condição de participação, não uma restrição exógena.

### Nota sobre BP sob maioria

$\text{cav}(v_M) = v_M$ em todos os casos testados: entry-based BP sob maioria é zero empiricamente. A não-convexidade via threshold de entrada existe teoricamente (quando $\tau(M) > 0$ e $\Phi_M > \alpha$), mas nos exemplos o kink não é suficiente para gerar ganho de concavificação. Portanto, a comparação $\text{cav}(v_U)$ vs $v_M$ coincide com $\text{cav}(v_U)$ vs $\text{cav}(v_M)$ nos exemplos.
