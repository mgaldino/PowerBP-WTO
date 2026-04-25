# Auditoria Cruzada: Parecer JoP vs. formal_model_v3.Rmd

**Data**: 2026-04-25
**Status**: DOCUMENTO DE REFERÊNCIA — lista de ajustes acordados
**Fonte do parecer**: `quality_reports/parecer_jop_teoria_formal_v2.md` (avaliou a v3 apesar do nome)
**Paper auditado**: `formal_model_v3.Rmd` (1089 linhas, versão ativa para submissão)

---

## Resumo executivo

O parecer recomenda Reject com encorajamento para nova submissão. Das ~12 críticas, a maioria já está resolvida na v3. Restam **3 problemas formais** (normalização de payoffs, concavidade de Δ₁, derivação algébrica do Lemma 1) e **1 problema de framing** (escolha unilateral de R). Nenhum exige reestruturação de provas — são ajustes cirúrgicos. A crítica à frase de abertura ("Most IOs") foi avaliada e rejeitada.

## TABELA-RESUMO DE FIXES

| # | Fix | Severidade | Dificuldade | Locais afetados | Seção |
|---|-----|-----------|-------------|-----------------|-------|
| 1 | **Redefinir v como ganho líquido** | ALTA — definição formal errada; referee de teoria detecta imediatamente | MÉDIA — mesma estrutura de provas, trocar λ_M por (λ_M−α) em ~5 locais + código R + figuras | l.414, l.521, B.6, B.8, R code (4 linhas), tabela notação, captions | I |
| 2 | **Fórmula de BP: Π\* = αV_e + cav v** | ALTA — consequência direta de #1; sem ela, claim central é formalmente incorreto | BAIXA — 1 frase | l.521 | I |
| 3 | **λ_M → (λ_M−α) nas provas** | ALTA — sem isso, as provas usam o objeto errado | BAIXA — substituição mecânica, mesmos argumentos | B.6 l.1003/1006/1008, B.8 l.1039 (×2) | I |
| 4 | **Código R: subtrair αV_e** | MÉDIA — figuras mostram nível errado; comparação visual ok mas inconsistente com definição corrigida | BAIXA — 4 linhas de código | l.436, l.441, l.580, l.590 | I |
| 5 | **Concavidade de Δ₁ no ramo LOW** | MÉDIA — argumento lógico insuficiente como escrito; conclusão correta pelo motivo oposto (côncava, não convexa) | BAIXA — 2 frases | B.2 l.938 | II |
| 6 | **Derivação algébrica da decomposição D(μ)** | MÉDIA — referee pode exigir álgebra explícita; atualmente a decomposição é apresentada sem derivação dos primitivos | MÉDIA — novo sub-appendix B.5a, ~1-2 páginas de álgebra mecânica | Novo appendix antes de B.5 Step 1 | III |
| 7 | **Footnote: escolha unilateral de R** | BAIXA — ponto de framing, não afeta resultados | BAIXA — 1 footnote | l.108 ou Scope | V |
| 8 | **E_U é fechado (Thm 2 gap argument)** | BAIXA — implícito mas não declarado | BAIXA — 1 frase | B.8 l.1041 ou A.7 | VI.1 |
| 9 | **Prop 7 (K>2): rebaixar label** | BAIXA — "Proof sketch" cria expectativa de rigor que não entrega | BAIXA — trocar \begin{proof}[Proof sketch] por texto informal, ou chamar "Claim" | App C l.1070 | VI.2 |
| 10 | **Documentar model_functions.R** | BAIXA — replicabilidade do material suplementar | BAIXA — cabeçalho com descrição de funções/parâmetros | scripts/model_functions.R | VI.3 |
| 11 | **GATT/WTO: comprimir (opcional)** | MÍNIMA — framing correto, apenas longo | BAIXA — cortar ou mover 1 parágrafo | l.676-680 | VI.4 |
| 12 | **Motivating example: nota de coerência** | MÍNIMA — sem inconsistência (sem entry cost), mas coerência com nova definição | BAIXA — 1 frase | Após l.78 ou em footnote | IX |

### Legenda de severidade

- **ALTA**: Um referee de teoria formal identificaria como erro ou inconsistência. Bloqueia submissão.
- **MÉDIA**: Argumento insuficiente ou gap auditável. Pode gerar pedido de revisão.
- **BAIXA**: Melhoria de exposição ou robustez. Não bloqueia, mas fortalece.
- **MÍNIMA**: Nice-to-have. Pode ignorar sem risco.

### Legenda de dificuldade

- **BAIXA**: ≤ 3 frases ou substituição mecânica. ~15 min.
- **MÉDIA**: Requer álgebra ou múltiplos locais coordenados. ~1-2h.

### Estimativa total

- Fixes 1-4 (normalização, pacote completo): ~2h
- Fix 5 (concavidade): ~15 min
- Fix 6 (derivação B.5a): ~1-2h
- Fixes 7-12 (menores): ~30 min cada = ~2h
- Recompilação + verificação: ~30 min
- **Total**: ~1 dia de trabalho focado

---

## I. NORMALIZAÇÃO DE PAYOFFS (CRÍTICA MAIS SÉRIA)

### O problema

**Localização**: l.414 (definição), l.521 (claim de BP), l.1003-1009 (prova Thm 1), l.1037-1045 (prova Thm 2), código R l.436/441/580/590.

O paper define:

```
v(μ, R) = E_θ[V_H^{R1}(θ, μ, R)]   quando entry ocorre
         = 0                            caso contrário
```

E afirma: `Π_H^*(R, p) = cav v(p, R)`.

Mas o payoff real de H quando a instituição **não** se forma é `αV_e(μ)`, não zero. Portanto:

- `v` como definido é o payoff **bruto** de barganha (não o ganho líquido)
- `v = 0` fora do entry set é inconsistente com o payoff real `αV_e(μ) > 0`
- `Π_H^* = cav(v)` está **errado como nível** (o valor absoluto de BP)

### Diagnóstico detalhado

Definindo os três objetos relevantes:

| Símbolo | Definição | Onde aparece |
|---------|-----------|-------------|
| `v_paper(μ)` | `V_H^R1(μ)` se entry, `0` caso contrário | l.414, código R |
| `v_true(μ)` | `V_H^R1(μ)` se entry, `αV_e(μ)` caso contrário | O correto |
| `w(μ)` | `V_H^R1(μ) − αV_e(μ)` se entry, `0` caso contrário | Ganho líquido |

Relações:
- `v_true = w + αV_e` (para todo μ)
- `cav(v_true) = cav(w + αV_e) = cav(w) + αV_e` (porque αV_e é affine)
- `Π_H^*(R, p) = αV_e(p) + cav w(p, R)` (fórmula correta)

A comparação institucional:
- `Π_H^*(U,p) − Π_H^*(M,p) = cav(w_U)(p) − cav(w_M)(p)` (αV_e cancela)

### Impacto nos resultados

**Theorem 1 (Dominância)**: CORRETO. A prova opera em `p ∈ E_U` onde ambas as regras têm entry. Em `p ∈ E_M`, `cav(v_paper_M)(p) = λ_M V_e(p)` coincide com `cav(w_M)(p) + αV_e(p) = (λ_M − α)V_e(p) + αV_e(p) = λ_M V_e(p)`. O Π_M^* dá o mesmo número pelas duas vias. E `Π_U^* ≥ V_H^R1(p,U) > V_H^R1(p,M) = Π_M^*`.

**Theorem 2 (Single-crossing)**: A PROPRIEDADE QUALITATIVA É CORRETA. A prova com `w` segue a mesma estrutura:
- `w_M(μ) = (λ_M − α)V_e(μ)` na região de entry: affine ✓
- `cav(w_M)(p)/p` é decrescente: ✓ (mesma razão)
- `cav(w_U)(p) = S_w · p` para `p < a`: ✓ (raio da origem, mesma estrutura)

Mas o threshold `p*` pode ser diferente. A comparação de slopes mostra:
- `S_w − S_wM ≥ S_U − S_M` (o paper é conservador — subestima a vantagem de U)
- Se o paper diz U ganha (S_U > S_M), a formulação correta também diz U ganha ✓
- Se o paper diz M ganha, a formulação correta pode discordar (U pode ganhar)

**Figuras**: Mostram `cav(v_paper)`, não `cav(w) + αV_e`. Visualmente enganosas sobre o nível (mostram 0 abaixo do entry quando o payoff real é αV_e), mas corretas sobre a comparação entre regras.

### Verificação λ_M > α

Para que o ganho líquido w_M = (λ_M − α)V_e > 0, precisamos λ_M > α. Isso vale sempre:

```
λ_M > α  ⟺  (1 − α)[N − β(q−1)] > 0
```

que é verdadeiro porque α < 1/r < 1, N ≥ 3, β < 1, q ≤ N. ✓

### Fix recomendado (Opção A — ganho líquido)

**1. Redefinir v (l.414)**

ANTES:
```
The hegemon's reduced-form value function is v(μ, R) = E_θ[V_H^{R1}(θ, μ, R)]
when weak states enter and zero otherwise.
```

DEPOIS:
```
The hegemon's reduced-form value function captures the gain from institutional
bargaining relative to the bilateral outside option:
v(μ, R) = E_θ[V_H^{R1}(θ, μ, R)] − αV_e(μ) when weak states enter, and zero
otherwise. Since the outside option αV_e(μ) is common to both rules and affine
in beliefs, it cancels from the institutional comparison.
```

**2. Corrigir fórmula de BP (l.521)**

ANTES:
```
the hegemon's payoff under each rule is Π_H^*(R, p) = cav v(p, R)
```

DEPOIS:
```
the hegemon's payoff under each rule is Π_H^*(R, p) = αV_e(p) + cav v(p, R).
Since αV_e(p) is affine and common to both rules, the institutional choice
reduces to comparing cav v(p, U) versus cav v(p, M).
```

**3. Substituir λ_M por (λ_M − α) em 5 locais nas provas**

| Local | Antes | Depois |
|-------|-------|--------|
| B.6 l.1003 | `v(μ,M) = λ_M[1+(r−1)μ]` | `v(μ,M) = (λ_M − α)[1+(r−1)μ]` |
| B.6 l.1006 | `λ_M Σ π_s + λ_M(r−1) Σ π_s μ_s` | `(λ_M−α) Σ π_s + (λ_M−α)(r−1) Σ π_s μ_s` |
| B.6 l.1008 | `≤ λ_M + λ_M(r−1)p = λ_M[1+(r−1)p] = v(p,M)` | `≤ (λ_M−α)[1+(r−1)p] = v(p,M)` |
| B.8 l.1039 | `m(p) = λ_M V_e(p)` para `p ≥ τ(M)` | `m(p) = (λ_M−α)V_e(p)` |
| B.8 l.1039 | `S_M = λ_M V_e(τ(M))/τ(M)` | `S_M = (λ_M−α)V_e(τ(M))/τ(M)` |

A estrutura dos argumentos é idêntica. (λ_M − α) > 0 garante que todos os sinais se preservam.

**4. Atualizar tabela de notação (l.833)**

Adicionar:
```
v(μ, R)  |  Hegemon's net gain from institution  |  Sec. 6
```

**5. Corrigir código R**

Em `formal_model_v3.Rmd`:

l.436 (plot_panel, unanimity):
```r
# ANTES:
if (vw >= c_val) VH_R1_unanimity(r_val, alpha_val, m, N_val, beta_val) else 0
# DEPOIS:
if (vw >= c_val) VH_R1_unanimity(r_val, alpha_val, m, N_val, beta_val) - alpha_val * (1 + m * (r_val - 1)) else 0
```

l.441 (plot_panel, majority):
```r
# ANTES:
if (vw >= c_val) VH_R1_majority(r_val, alpha_val, m, N_val, beta_val) else 0
# DEPOIS:
if (vw >= c_val) VH_R1_majority(r_val, alpha_val, m, N_val, beta_val) - alpha_val * (1 + m * (r_val - 1)) else 0
```

l.580 (compute_preference, unanimity slope):
```r
# ANTES:
return(vh / m)
# DEPOIS:
Ve_m <- 1 + m * (r - 1)
return((vh - alpha * Ve_m) / m)
```

l.590 (compute_preference, majority slope):
```r
# ANTES:
return(vh / m)
# DEPOIS:
Ve_m <- 1 + m * (r - 1)
return((vh - alpha * Ve_m) / m)
```

**6. Ajustar label do eixo-y nas figuras**

De `v(μ, R)` para `v(μ, R)` (net gain) ou adicionar caption explicando que o eixo mostra o ganho sobre a outside option.

**7. Motivating example (l.63-78)**

Sem entry cost neste exemplo → v_paper = v_true − αV_e = w. Não há inconsistência no exemplo em si. Mas para coerência com a nova definição de v, os payoffs no exemplo podem ser reformulados como ganhos líquidos. ALTERNATIVA: manter o exemplo com payoffs absolutos e notar que, sem entry cost, a distinção é irrelevante.

---

## II. CONCAVIDADE DE Δ₁ NO RAMO LOW (UNICIDADE DO CUTOFF)

### O problema

**Localização**: B.2 l.938, A.5 l.900.

O paper diz (B.2):
> "Below μ_s^{R2}, Δ₁ is positive (since Δ₁(0) > 0 and Δ₁(μ_s^{R2}) > 0 with Δ₁ quadratic on this interval), so no additional roots exist."

O parecerista objeta: uma quadrática com endpoints positivos pode ter interior negativo (se for convexa / abrir pra cima com vértice entre os endpoints). Correto.

### Diagnóstico

Derivação do coeficiente de μ² em cada ramo:

| Ramo | V_W^{R2}(μ) | Coef. de μ² em Δ₁ | Curvatura |
|------|-------------|-------------------|-----------|
| HIGH (μ > μ_s^{R2}) | [V_e(μ) − αr]/N | +(N−2)β(r−1) > 0 | **Convexa** |
| LOW (μ < μ_s^{R2}) | (1−μ)(1−α)/N | −(N−2)β(1−α)/N < 0 | **Côncava** |

No ramo LOW, Δ₁ é **côncava** (abre pra baixo). Portanto:

- Côncava + Δ₁(0) > 0 + Δ₁(μ_s^{R2}) > 0 → Δ₁(μ) ≥ min{Δ₁(0), Δ₁(μ_s^{R2})} > 0 para todo μ no intervalo
- (Formalmente: f côncava ⟹ f(λa + (1−λ)b) ≥ λf(a) + (1−λ)f(b) > 0)

A conclusão (sem raízes adicionais no ramo LOW) é CORRETA, mas a justificativa no texto é insuficiente.

### Verificação dos outros subcasos

**Caso α ≥ ᾱ, ramo LOW** (onde o cutoff vive): Δ₁ côncava, Δ₁(0) > 0, Δ₁(μ_s^{R2}) ≤ 0. Côncava com endpoints de sinais opostos → exatamente uma raiz (a função sobe, tem máximo, e desce; cruza zero uma vez). ✓

**Caso α ≥ ᾱ, ramo HIGH**: Δ₁ convexa, Δ₁(μ_s^{R2}) ≤ 0, Δ₁(1) < 0. Convexa abaixo de zero nos endpoints → f ≤ chord ≤ 0 em todo o intervalo. ✓

### Fix recomendado

Substituir l.938 (B.2):

ANTES:
```
Below μ_s^{R2}, Δ₁ is positive (since Δ₁(0) > 0 and Δ₁(μ_s^{R2}) > 0
with Δ₁ quadratic on this interval), so no additional roots exist.
```

DEPOIS:
```
Below μ_s^{R2}, Δ₁ is a concave quadratic in μ: the coefficient of μ² is
−(N−2)β(1−α)/N < 0, which arises from the product (1−μ)·ω(μ) in
F₁^{agg} where ω(μ) = (N−2)β(1−μ)(1−α)/N is itself linear in μ.
Since Δ₁(0) = β(r−1)/N > 0 and Δ₁(μ_s^{R2}) > 0, and a concave
function that is positive at both endpoints of an interval is positive
throughout, Δ₁(μ) > 0 for all μ ∈ [0, μ_s^{R2}]. No additional roots exist.
```

Também verificar A.5 l.900 para consistência: a frase "On the high branch, Δ₁ is a convex quadratic" está correta (coeficiente +(N−2)β(r−1) > 0). Manter.

---

## III. DECOMPOSIÇÃO DO LEMMA 1: DERIVAÇÃO ALGÉBRICA FALTANTE

### Avaliação calibrada

A v3 avançou substancialmente em relação ao que o parecer descreve. B.5 agora contém:
- Fórmulas explícitas para D_base, δ_{R2}, δ_{R1} (Step 1)
- Verificação de endpoints ramo por ramo (Step 2)
- Assembly em dois casos — standard (μ_s^{R2} ≤ μ_s^{R1}) e alternativo (μ_s^{R1} < μ_s^{R2}) — com 3 branches cada (Step 3)
- Prova de necessidade (Step 4)

Portanto **não é mais correto dizer que o Lemma 1 está apenas "afirmado"**. A crítica original do parecer é excessiva para a v3. Mas resta um gap pontual: a decomposição

```
D(μ) = D_base(μ) + 1{μ < μ_s^{R2}} · δ_{R2}(μ) + 1{μ > μ_s^{R1}} · δ_{R1}(μ)
```

é apresentada como fato, sem ser derivada dos payoffs primitivos. O texto diz que as correções são aditivas "because they affect independent components of H's payoff" (l.965) — boa intuição, mas não substitui verificação algébrica. Um referee de teoria pode legitimamente exigir ver a álgebra.

### O gap específico

**Localização**: B.5 l.956-967 (Step 1).

Falta um subapêndice que:
1. Escreva E[V_H^{R1}(μ, U)] no benchmark conservador-R1/conservador-R2
2. Mostre a alteração quando R2 usa oferta agressiva (gera δ_{R2})
3. Mostre a alteração quando R1 usa oferta agressiva (gera δ_{R1})
4. Verifique que as duas alterações entram aditivamente
5. Subtraia E[V_H^{R1}(μ, M)] = λ_M V_e(μ)

### Fix recomendado

Adicionar Appendix B.5a (antes do Step 1 atual), com a derivação explícita:

```
B.5a Derivation of the payoff decomposition

We build E[V_H^{R1}(μ, U)] from primitives, working from the benchmark
case (conservative R1, conservative R2) and then introducing corrections.

**Benchmark: conservative R1, conservative R2 (μ > μ_s^{R1}, μ > μ_s^{R2}).**

When H proposes (prob 1/N): H offers β V_W^{R2}(μ) to each W and keeps
the remainder. Under conservative R2:
  V_W^{R2,H}(μ) = [V_e(μ) − αr]/N
so:
  V_H^{H-prop}(θ) = [V(θ) − (N−1)β V_W^{R2,H}(μ)] / N

When W proposes (prob (N−1)/N), conservative R1 means W offers β·αr to H
(the conservative reservation), both types accept:
  H gets β(r + x)/N² from each W-proposer

Taking expectations over θ:
  E[V_H^{R1}(μ, U)]_{benchmark} = [explicit formula]

**R2 correction (δ_{R2}): switching to aggressive R2 when μ < μ_s^{R2}.**

When μ < μ_s^{R2}, V_W^{R2} changes from [V_e − αr]/N to (1−μ)(1−α)/N.
This affects ONLY the H-proposer branch (where H's offer depends on
V_W^{R2}). The W-proposer branch uses R1 offers that depend on the R1
regime, not on V_W^{R2} directly.

  δ_{R2}(μ) = (N−1)β[V_W^{R2,H}(μ) − V_W^{R2,L}(μ)] / N
            = (N−1)β[μ(r − α) − α(r − 1)] / N²

Note δ_{R2}(μ_s^{R2}) = 0 (continuity at the R2 cutoff).

**R1 correction (δ_{R1}): switching to aggressive R1 when μ < μ_s^{R1}.**

Under aggressive R1, θ=0 accepts (H gets β(1+x)/N²) while θ=1 rejects
and R2 is reached (H gets β(r+x)/N²). Under conservative R1, both types
lead to H getting β(r+x)/N². The difference affects ONLY the θ=0 component
of the W-proposer payoff:

  Correction per W-proposer = (1−μ)[β(1+x)/N − β(r+x)/N] = −(1−μ)β(r−1)/N

Since this is negative, switching FROM conservative TO aggressive REDUCES
H's payoff. Equivalently, being on the conservative branch (μ > μ_s^{R1})
ADDS δ_{R1}(μ) = (N−1)β(r−1)(1−μ)/N² ≥ 0.

**Additivity.** The two corrections operate on disjoint components:
  - δ_{R2} acts through H's proposal (which depends on V_W^{R2})
  - δ_{R1} acts through W's R1 offer to H (which depends on the R1 regime)
  
Neither feeds back into the other because the R1 offer level under the
aggressive branch (β V_H^{R2}(θ=0)) does not depend on V_W^{R2}(μ), and
conversely V_W^{R2}(μ) does not depend on the R1 offer. This decoupling
yields the additive decomposition.

**Subtracting majority.** Under majority:
  E[V_H^{R1}(μ, M)] = λ_M V_e(μ)

Defining D(μ) = E[V_H^{R1}(μ, U)] − λ_M V_e(μ) and collecting terms
yields:
  D(μ) = D_base(μ) + 1{μ < μ_s^{R2}} · δ_{R2}(μ) + 1{μ > μ_s^{R1}} · δ_{R1}(μ)

where D_base(μ) = [(C_buy − C_out)V_e(μ) + C_out · βr] / N².
```

**Estimativa**: 1-2 páginas de álgebra. Sem conceito novo. Apenas torna auditável o que o texto já afirma.

---

## IV. ~~"MOST INTERNATIONAL ORGANIZATIONS OPERATE BY CONSENSUS"~~ — SEM AÇÃO

O parecerista critica a frase de abertura (l.47): "Most international organizations operate by consensus." A crítica está **errada** — a afirmação é sustentada pela literatura (Gould 2022 entre outros) e não precisa ser qualificada. Manter como está.

---

## V. ESCOLHA UNILATERAL DE R PELO HEGEMON

### O problema

**Localização**: l.108 (Timing, Stage 0).

O paper diz: "The hegemon chooses the voting rule R ∈ {M, U}." Sem qualificação. O parecerista argumenta que em IOs reais, regras constitucionais são negociadas.

### Status na v3

Não há qualificação como forma reduzida. A Scope section (l.682-688) discute proposal rights mas não discute a escolha de R.

### Fix recomendado

Adicionar footnote em l.108:

```
The hegemon's unilateral choice of $R$ is a modeling simplification that
captures the disproportionate influence of powerful states at the founding
stage of international institutions. The relevant question is not whether
the hegemon literally dictates the rule, but which rule it would prefer and
advocate given its bargaining leverage.
```

Alternativa mais forte: adicionar uma frase na Scope (l.682) dizendo que o resultado principal é uma preferência condicional (H prefere U sob certas condições), não uma previsão de implementação unilateral.

---

## VI. ITEMS MENORES

### VI.1 E_U fechado (Theorem 2 proof gap)

**Localização**: B.8 l.1041.

O argumento "p lies in a gap (b,d) of E_U with b,d ∈ E_U" requer que E_U seja fechado. Isso é verdade (V_W^{R1} é piecewise affine, logo contínua por partes; {μ : V_W ≥ c} é uma união finita de intervalos fechados). Mas o paper não diz isso.

**Fix**: Adicionar uma frase em B.8 ou A.7:
```
Since V_W^{R1}(μ, U) is piecewise affine (and hence continuous on each
branch), the entry set E_U = {μ : V_W^{R1}(μ, U) ≥ c} is a finite union
of closed intervals.
```

### VI.2 Appendix C — Proposition 7 com "Proof sketch"

**Localização**: l.1070.

O parecer sugere rebaixar a "discussion of extension" ou completar a prova. Atualmente tem o label "Proof sketch", que dá aparência de rigor que não entrega.

**Fix**: Mudar de `\begin{proof}[Proof sketch]` para uma observação informal, ou rebaixar Proposition 7 a "Claim" / "Observation".

### VI.3 Script model_functions.R — documentação

**Localização**: `scripts/model_functions.R` (100 linhas).

O parecer nota que `source("scripts/model_functions.R")` sem documentação enfraquece a replicabilidade.

**Fix**: Adicionar cabeçalho com descrição das funções, parâmetros, e valores de retorno. Incluir como material suplementar.

### VI.4 GATT/WTO — comprimir

**Localização**: l.664-681 (Section 8.1).

A seção é ~700 palavras com a transição GATT→WTO. O framing está correto ("The model does not claim..."), mas o comprimento vai além de "motivating illustration".

**Fix sugerido (não obrigatório)**: Cortar o parágrafo "GATT-to-WTO transition" (l.676-680) ou mover para footnote. Economiza ~150 palavras.

---

## VII. ITEMS JÁ RESOLVIDOS NA V3 (sem ação necessária)

| Crítica do parecer | Status |
|---------------------|--------|
| §3.1 Unicidade do cutoff no ramo HIGH (α < ᾱ) | Correto: convexa + sinais opostos → 1 raiz ✓ |
| §3.1 Unicidade no caso α ≥ ᾱ | Correto: côncava + sinais opostos → 1 raiz ✓ |
| §3.3 Theorem 1 depende da normalização | RESOLVIDO CONDICIONALMENTE — ver nota abaixo |
| §3.4 Theorem 2 — E_U desconexo | Tratado: Lemma B.7 + gap argument ✓ |
| §3.4 Theorem 2 — casos degenerados | Cobertos implicitamente ✓ |
| §4.1 Excesso de "See Appendix" | By design (estilo JoP) ✓ |
| §5.1 GATT/WTO como evidência | Framing correto ("does not claim...") ✓ |
| §5.2 "Most IOs operate by consensus" | Parecerista errado; frase sustentada pela literatura ✓ |

### Nota sobre §3.3 — Theorem 1 e normalização

**Status: RESOLVIDO CONDICIONALMENTE À REDEFINIÇÃO DE v COMO GANHO LÍQUIDO (Seção I).**

A prova do Theorem 1 em B.6 opera em p ∈ E_U e mostra E_U ⊆ E_M, de modo que a comparação ponto a ponto ocorre em beliefs onde ambas as regras induzem entry. Nesse domínio, o outside option αV_e(μ) é comum e affine, e não ameaça substantivamente o resultado.

No entanto, a prova **ainda depende da definição correta do objeto concavificado**. Três razões:

1. **A concavificação é definida sobre todo o domínio.** `cav v(p, R)` pode usar posteriors fora de E_U ou de E_M. O valor de v fora da região de entrada importa para o problema de persuasão, mesmo quando p está dentro da região de entrada.

2. **A prova de B.6 mostra `cav v(p, M) = v(p, M)` para p ∈ E_M.** Esse passo usa explicitamente v(μ_s, M) = 0 para μ_s ∉ E_M (l.1006-1008). Se v fosse definido como payoff bruto, o valor fora de E_M seria αV_e(μ_s) > 0, e a cota superior mudaria. Com v definido como ganho líquido, v = 0 fora de E_M é correto e a cota se preserva.

3. **A afirmação "payoff de não entrada nunca entra na prova" é imprecisa.** O payoff de não entrada entra via a concavificação (que considera todo o espaço de posteriors). A defesa funciona somente quando o valor fora do entry set é interpretado como ganho líquido zero — não como payoff absoluto zero.

**Conclusão**: Uma vez feita a redefinição de v como ganho líquido (Seção I), a prova do Theorem 1 está correta sem alterações adicionais. A dependência é puramente definitional: a normalização da Seção I deve preceder o Theorem 1 no texto. Nenhuma reestruturação da prova é necessária.

---

## VIII. ORDEM DE IMPLEMENTAÇÃO RECOMENDADA

1. **Normalização de payoffs** (I) — é a mudança mais profunda, afeta definição + provas + código + figuras. Resolve também §3.3 (Theorem 1).
2. **Concavidade de Δ₁** (II) — cirúrgico, 2 frases
3. **Derivação algébrica Lemma 1** (III) — novo appendix B.5a, ~1-2 páginas
5. **Escolha unilateral de R** (V) — 1 footnote
6. **Items menores** (VI) — E_U fechado, Prop 7, script, GATT comprimir

Depois de implementar: recompilar, verificar figuras, rodar `review-formal-model` para validar.

---

## IX. NOTA SOBRE O MOTIVATING EXAMPLE

O motivating example (Section 2, l.63-78) **não tem entry cost**, portanto v_paper = V_H^R1 (= v_true, porque a instituição sempre se forma). Não há inconsistência no exemplo.

Após redefinir v como ganho líquido no modelo geral, o exemplo pode manter payoffs absolutos com uma nota: "Since there is no entry cost in this example, the institution always forms and the net-gain and absolute-payoff representations coincide."

---

## X. CHECKLIST DE VERIFICAÇÃO PÓS-IMPLEMENTAÇÃO

- [ ] Definição de v(μ,R) é ganho líquido em l.414
- [ ] Π_H^* = αV_e(p) + cav v(p,R) em l.521
- [ ] λ_M → (λ_M − α) em B.6 (5 ocorrências)
- [ ] S_M usa (λ_M − α) em B.8
- [ ] Tabela de notação atualizada
- [ ] Código R: v_U e v_M subtraem αV_e na região de entry
- [ ] Código R: slopes usam (vh − α·Ve)/μ
- [ ] Figuras recompiladas com eixo-y correto
- [ ] B.2 l.938: "concave quadratic" com justificativa
- [ ] B.5a: derivação algébrica da decomposição
- [x] ~~l.47: "Many prominent" em vez de "Most"~~ — NÃO FAZER, parecerista errado
- [ ] l.108: footnote sobre escolha reduzida de R
- [ ] B.8: frase sobre E_U fechado
- [ ] App C Prop 7: rebaixar label ou completar prova
- [ ] Motivating example: nota de coerência (se necessário)
- [ ] Recompilar PDF e verificar todas as figuras
- [ ] Rodar /review-formal-model para validação
