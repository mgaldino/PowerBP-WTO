# Eliminação completa de Assumption 1 do Theorem 2

**Data**: 2026-04-25  
**Status**: PROVA COMPLETA — todas as peças analiticamente verificadas (A+)  
**Reviews**:
- Theorem 2 (gap interpolation + monotonicidade): A+ (`quality_reports/2026-04-25_review-eliminate-assumption1.md`)
- Lemma X (V_W(1) = max global): A+ (`quality_reports/2026-04-25_referee-report-lemmaX.md`)

---

## Resultado

**Assumption 1 é eliminada por completo.** O Theorem 2 (single-crossing) vale sob apenas:
- α < α*(N, β)
- E_U ≠ ∅ (i.e., c ≤ r(1−βα)/N)
- a ≡ min E_U > 0

Nenhuma hipótese sobre a estrutura (conectividade) de E_U é necessária.

### Por que funciona

| Condição de Assumption 1 | Como é eliminada |
|---|---|
| E_U é conectado | Gap interpolation (Passo 1 da prova) |
| 1 ∈ E_U | Lemma X: V_W(1,U) = max global → E_U ≠ ∅ ⟹ 1 ∈ E_U |

---

## Lemma X: V_W^{R1}(1, U) é o máximo global

**Statement**: Para todo μ ∈ (0, 1]:

$$V_W^{R1}(\mu, U) \leq V_W^{R1}(1, U) = \frac{r(1-\beta\alpha)}{N}$$

com desigualdade estrita para μ < 1.

**Corolário**: E_U ≠ ∅ ⟹ 1 ∈ E_U.

**Prova**: `notes/2026-04-25_prova_lemmaX_AJPS_ready.md`

**Estratégia**: Limitar cada um dos quatro candidatos de payoff ({agressivo, conservador} × {R2 baixo, R2 alto}) por V̄_W, sem usar o cutoff μ_s^{R1}. Closed forms para cada gap:

| Candidato | Domínio | V̄_W − V_W^{XX}(μ) |
|---|---|---|
| Conservador, R2 alto | μ ≥ μ₂ | (N+β)(r−1)(1−μ)/N² |
| Agressivo, R2 alto | μ ≥ μ₂ | [(1−μ)(r−1) + μr(1−β)]/N |
| Conservador, R2 baixo | μ ≤ μ₂ | Affine, positivo em μ=0 e μ=μ₂ |
| Agressivo, R2 baixo | μ ≤ μ₂ | Affine, positivo em μ=0 e μ=μ₂ |

Todos estritamente positivos para μ < 1. Igualdade apenas no caso conservador/alto em μ = 1. □

**Grade**: A+ (reviewer independente, padrão JoP/AJPS).

---

## Prova do Theorem 2 (versão final)

Notação: $u(p) \equiv \operatorname{cav} v(p, U)$, $m(p) \equiv \operatorname{cav} v(p, M)$, $D(p) = u(p) - m(p)$.

### Statement

**Theorem 2** (Single-crossing). *Suponha $\alpha < \alpha^*(N, \beta)$, $E_U \neq \varnothing$, e $a \equiv \min E_U > 0$. Seja $S_U \equiv \max_{\mu \in E_U} v(\mu, U)/\mu$. A comparação institucional tem a propriedade de single-crossing: unanimidade domina para todos os priors suficientemente altos, e o ranking muda no máximo uma vez. Especificamente:*

*(a) Se $\tau(M) = 0$: existe um único $p^* = \lambda_M/[S_U - \lambda_M(r-1)] \in (0, a)$ tal que maioria domina para $p < p^*$ e unanimidade domina para $p > p^*$.*

*(b) Se $\tau(M) > 0$: sejam $S_M \equiv v(\tau(M), M)/\tau(M)$.*
- *Se $S_U > S_M$: unanimidade domina estritamente para todo $p \in (0, 1]$.*
- *Se $S_U = S_M$: unanimidade domina fracamente para todo $p \in (0, 1]$ (empate para $p \leq \tau(M)$, unanimidade estrita para $p > \tau(M)$).*
- *Se $S_U < S_M$: existe um único $p^* \in (\tau(M), a)$ tal que maioria domina para $p < p^*$ e unanimidade domina para $p > p^*$.*

*Em todos os casos, qualquer vantagem de maioria opera exclusivamente pela margem de entrada.*

### Prova

Seja $a = \min E_U$. O conjunto $E_U$ é compacto: $V_W^{R1}$ é contínua em cada regime (agressivo e conservador) com salto para baixo em $\mu_s^{R1}$, logo $E_U = \{\mu : V_W \geq c\}$ é união finita de intervalos fechados.

Pelo Lemma X, $V_W^{R1}(1, U) = \max_\mu V_W^{R1}(\mu, U)$. Como $E_U \neq \varnothing$, existe $\mu'$ com $V_W(\mu') \geq c$, logo $V_W(1) \geq V_W(\mu') \geq c$, i.e., $1 \in E_U$. Portanto toda componente conexa de $[a, 1] \setminus E_U$ é um intervalo aberto limitado $(b, d)$ com $b, d \in E_U$.

**Passo 1: $u(p) > m(p)$ para todo $p \in [a, 1]$.**

*Caso $p \in E_U$*: Theorem 1 dá $u(p) \geq v(p, U) > v(p, M) = m(p)$.

*Caso $p \notin E_U$, $p \in [a, 1]$*: Então $p$ está num gap $(b, d)$ com $b, d \in E_U$. Defina $w_b = (d-p)/(d-b)$, $w_d = (p-b)/(d-b)$. Pela concavidade de $u$:

$$u(p) \geq w_b\, u(b) + w_d\, u(d)$$

Pelo Theorem 1: $u(b) > m(b)$ e $u(d) > m(d)$. Como $E_U \subseteq E_M = [\tau(M), 1]$ (B.6) e $E_M$ é intervalo contendo $b$ e $d$, temos $p \in E_M$, logo $m$ é affine em $[b, d]$ (pois $m(\mu) = \lambda_M V_e(\mu)$ para $\mu \in E_M$, provado em B.6). Portanto $w_b\, m(b) + w_d\, m(d) = m(p)$.

Combinando: $u(p) > m(p)$ para todo $p \in [a, 1]$. □

**Passo 2: Single-crossing abaixo de $a$.**

Para $p < a$: $v(\mu, U) = 0$ para $\mu \notin E_U$. Como $v(\mu, U) \leq S_U \cdot \mu$ para todo $\mu \in [0,1]$ (por definição de $S_U$ em $E_U$; trivialmente fora de $E_U$ onde $v = 0$), qualquer experimento Bayes-plausível com prior $p$ dá payoff $\leq S_U p$. A cota é atingida pelo experimento $\{0, \mu^*\}$ com $\mu^* = \arg\max_{\mu \in E_U} v(\mu)/\mu$ (existe pela compacidade de $E_U$). Logo $u(p) = S_U \cdot p$.

Portanto:

$$D(p) = u(p) - m(p) = p\!\left(S_U - \frac{m(p)}{p}\right)$$

Como $m$ é concave com $m(0) = 0$ (pois o único experimento com prior $0$ é $\delta_0$, que dá $v(0, M) = 0$), a função $m(p)/p$ é não-crescente: para $0 < p_1 < p_2$, concavidade dá $m(p_1) \geq (p_1/p_2)\,m(p_2)$, logo $m(p_1)/p_1 \geq m(p_2)/p_2$.

Portanto $D(p)/p = S_U - m(p)/p$ é não-decrescente, e muda de sinal no máximo uma vez (de negativo para positivo).

Combinando com $D(p) > 0$ para todo $p \in [a, 1]$ (Passo 1), o conjunto $\{p \in (0, 1] : D(p) > 0\}$ é um upper interval. □

**Sub-casos.**

*(a) $\tau(M) = 0$*: $m(p) = \lambda_M V_e(p)$ para todo $p$. Logo $D(p) = S_U p - \lambda_M[1 + (r-1)p]$ para $p < a$, affine com $D(0) = -\lambda_M < 0$ e $D(a) > 0$ (Passo 1). Único zero: $p^* = \lambda_M/[S_U - \lambda_M(r-1)]$.

*(b) $\tau(M) > 0$*: Para $p < \tau(M)$: $m(p) = S_M p$, logo $D(p)/p = S_U - S_M$ (constante).
- $S_U > S_M$: $D > 0$ para todo $p \in (0, 1]$. Unanimidade domina globalmente.
- $S_U = S_M$: $D = 0$ para $p \leq \tau(M)$, $D > 0$ para $p > \tau(M)$ (Passo 1). Unanimidade domina fracamente.
- $S_U < S_M$: $D < 0$ para $p < \tau(M)$. Para $p \in [\tau(M), a)$: $D(p) = S_U p - \lambda_M V_e(p)$, affine com $D(\tau(M)) = (S_U - S_M)\tau(M) < 0$ e $D(a) > 0$ (Passo 1). Único zero $p^* \in (\tau(M), a)$.

Em todos os casos, qualquer vantagem de maioria opera exclusivamente pela margem de entrada (priors abaixo de $a = \min E_U$). □

---

## O que muda no paper

1. **Assumption 1**: eliminada por completo
2. **Lemma X** (novo, appendix): V_W(μ, U) ≤ V_W(1, U) = r(1−βα)/N. Prova: ~1 página, quatro bounds fechados. (`notes/2026-04-25_prova_lemmaX_AJPS_ready.md`)
3. **Theorem 2 statement**: remover "Assumption 1 holds"; substituir τ(U) por a ≡ min(E_U); sub-casos mantidos com a no lugar de τ(U)
4. **Prova B.7**: substituir pela prova acima (gap interpolation + monotonicidade de m(p)/p + sub-casos). Mais curta e mais limpa que a atual
5. **Parágrafo pós-Assumption 1** (linhas 541–547): substituir por observação de que E_U pode ser desconectado (quando V_W tem salto para baixo em μ_s^{R1}), mas o resultado vale sem restrição sobre a estrutura de E_U, graças ao Lemma X e ao gap interpolation
6. **Corollary (E_U ≠ ∅ ⟹ 1 ∈ E_U)**: pode ser mencionado no texto para dar interpretação econômica: quando entry é viável para alguma crença, é viável sob informação completa

## Verificação numérica

| Teste | Casos | Violações |
|---|---|---|
| Single-crossing (total) | 7.480 | 0 |
| Single-crossing (E_U desconectado) | 398 | 0 |
| D(p) > 0 nos gaps | 398 | 0 |
| V_W(1) = r(1−βα)/N | 168 | 0 (erro < 2e-12) |
| V_W(1) = max global de V_W | 18.000 | 0 |
| V_W(μ) ≤ V̄_W (4 candidatos) | 6.050 cada | 0 |
| V_W crescente no conservador | 168 | 0 |

Scripts: `scripts/verify_single_crossing_no_assumption1.R`, verificações dos agentes revisores.

## Dependências lógicas (todas provadas analiticamente)

1. **Theorem 1** (B.6): u(p) > m(p) para p ∈ E_U ✓
2. **E_U ⊆ E_M** (B.6): budget identity + Lemma 1 ✓
3. **cav v(p, M) = v(p, M) para p ∈ E_M** (B.6): majority affine ✓
4. **V_e affine**: definição do modelo ✓
5. **Lemma X**: V_W(1, U) = max global → 1 ∈ E_U quando E_U ≠ ∅ ✓ (prova analítica, A+)
6. **E_U compacto**: união finita de intervalos fechados ✓
7. **m concava com m(0) = 0**: definição de concavificação ✓

Nenhuma dependência numérica. Tudo analítico.
