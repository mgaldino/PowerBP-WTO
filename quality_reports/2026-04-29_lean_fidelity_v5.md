# Relatório de Fidelidade Lean — Paper v5 (Formalização Completa)

**Data**: 2026-04-29
**Arquivos**: `formal_proofs/FormalProofs/V5/*.lean` (7 arquivos)
**Build**: PASSING (8270 jobs, 0 erros)
**Sorry**: 0

## Classificação por teorema

### V5/Prop1.lean — Majority no screening

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_prop1_majority_affine` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `v5_lambda_M_gt_alpha` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |

### V5/Prop2.lean — R1 screening cutoff

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_Delta1_at_zero_pos` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `v5_Delta1_at_one_neg` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `v5_R1_cutoff_exists` | LÓGICA ABSTRATA | `hΔ_cont`, `hΔ0`, `hΔ1` | MÉDIO |
| `v5_R1_cutoff_unique` | LÓGICA ABSTRATA | `h_sc` (single-crossing) | MÉDIO |

### V5/Prop3.lean — Screening jump

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_jump_eq_delta_R1` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `v5_prop3_jump_positive` | ÁLGEBRA COMPLETA | Nenhuma (usa `delta_R1_pos` verificado) | BAIXO |
| `v5_jump_at_one` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |

### V5/Theorem1.lean — Conditional payoff dominance

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_theorem1_iff` | ÁLGEBRA COMPLETA | Nenhuma (wrapper de `lemma1_iff`, 19 teoremas verificados) | BAIXO |
| `v5_theorem1_sufficiency` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `v5_theorem1_necessity` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |

### V5/Corollary.lean — F_U ⊆ F_M

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_weak_state_prefers_majority` | LÓGICA ABSTRATA | `h_budget_M`, `h_budget_U`, `h_dom` | MÉDIO |
| `v5_formation_set_nesting` | LÓGICA ABSTRATA | `h_VW` (V_W(M) > V_W(U)) | BAIXO (trivial dado premissa) |
| `v5_corollary_unanimity_dominates_on_FU` | LÓGICA ABSTRATA | Todas as acima | MÉDIO |

### V5/LemmaVWMax.lean — V_W global max

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `beta_alpha_lt_one` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `V_W_bar_pos` | ÁLGEBRA COMPLETA | Nenhuma | BAIXO |
| `affine_nonneg_on_unit` | ÁLGEBRA COMPLETA | Nenhuma (resultado genérico) | BAIXO |
| `v5_conservative_high_bounded` | ÁLGEBRA COMPLETA | Nenhuma (1 de 4 candidatos) | BAIXO |
| `v5_lemma_entry_at_one` | LÓGICA ABSTRATA | `h_bound` (V_W ≤ V̄_W para todo μ) | **ALTO** |

### V5/Prop4.lean — Institutional classification

| Teorema | Nível | Hipóteses assumidas | Risco |
|---------|-------|---------------------|-------|
| `v5_prop4_case_i` | LÓGICA ABSTRATA | `h_thm1` | BAIXO |
| `v5_prop4_case_ii` | ÁLGEBRA COMPLETA | Nenhuma (λ_M > α verificado) | BAIXO |
| `v5_prop4_case_iii` | ÁLGEBRA COMPLETA | Nenhuma (reflexividade) | BAIXO |
| `v5_prop4_classification` | LÓGICA ABSTRATA | `h_nesting`, `h_VHU`, `h_VHM_dom` | MÉDIO |

## Hipóteses não derivadas

### 1. Continuidade e boundary values de Δ₁ (Prop 2)

- **O que foi assumido**: `hΔ_cont : Continuous Δ`, `hΔ0 : Δ 0 = β(r-1)/N`, `hΔ1 : Δ 1 = r(β-1)`
- **Onde no paper**: Appendix A.3 (lines 803-822) — derivação por backward induction do R1
- **O que faltaria em Lean**: Definir a função Δ₁(μ) concretamente a partir dos payoffs de equilíbrio do jogo de barganha, provar que é contínua, calcular seus valores em μ=0 e μ=1
- **Risco de erro**: BAIXO — os boundary values são cálculos algébricos diretos do equilíbrio PBE

### 2. Single-crossing de Δ₁/(1-μ) (Prop 2)

- **O que foi assumido**: `h_sc : ∀ μ₁ μ₂, ... → Δ μ₂/(1-μ₂) < Δ μ₁/(1-μ₁)`
- **Onde no paper**: Appendix A.3 — quadratic convexity of Δ₁ on high branch
- **O que faltaria em Lean**: Derivar a forma quadrática de Δ₁, provar convexidade, derivar single-crossing
- **Risco de erro**: MÉDIO — depende de qual branch (high vs low R2) o cutoff cai

### 3. Budget identities (Corollary)

- **O que foi assumido**: `h_budget_M : V_H_M + (N-1)·V_W_M = V_e` (exata, maioria), `h_budget_U : V_H_U + (N-1)·V_W_U ≤ V_e` (desigualdade, unanimidade)
- **Onde no paper**: Appendix A.6 (lines 838-840)
- **O que faltaria em Lean**: Derivar continuation values de equilíbrio por backward induction, somar, verificar identidade/desigualdade
- **Risco de erro**: BAIXO para maioria (identidade standard em Baron-Ferejohn); MÉDIO para unanimidade (desigualdade depende de surplus destruction por desconto no branch agressivo)

### 4. V_W(μ,U) ≤ V̄_W para todos os 4 candidatos (LemmaVWMax)

- **O que foi assumido**: `h_bound : ∀ μ, V_W μ ≤ V_W_max` (o bound global)
- **Onde no paper**: Appendix B.7 (lines 1078-1092) — verifica 4 candidatos
- **O que faltaria em Lean**: Definir os 4 candidatos de payoff (V_W^{CH}, V_W^{AH}, V_W^{CL}, V_W^{AL}), calcular V̄_W - cada candidato nos endpoints, provar affinidade e non-negatividade. Apenas V_W^{CH} (Conservative-High) foi verificado algebricamente; os outros 3 estão assumidos.
- **Risco de erro**: **ALTO** — os candidatos Aggressive-High e Aggressive-Low envolvem cancelamentos quadráticos sutis ((1-μ)·ω(μ) terms) que o paper alega cancelarem. Se o cancelamento não for exato, o resultado pode falhar.

### 5. F_U ⊆ F_M como hipótese em Prop 4

- **O que foi assumido**: `h_nesting : entry_U → entry_M`
- **Onde no paper**: Provado no Corollary (Appendix B.6)
- **O que faltaria em Lean**: Herda os gaps do Corollary (budget identities)
- **Risco de erro**: MÉDIO (herança)

## Resumo

**O Lean garante**: A álgebra do Theorem 1 (D_base + corrections > 0 ↔ α < α*) está sólida, verificada em 19 teoremas encadeados desde as definições do GameParams. λ_M > α está verificado. A lógica da classificação institucional (3 cases) é consistente.

**O Lean NÃO garante**: Que as fórmulas de payoff do equilíbrio (derivadas por backward induction) estão corretas; que as budget identities valem no modelo específico; que V_W(μ,U) é realmente bounded por V̄_W em todos os 4 regimes de equilíbrio. Estas são derivações do modelo econômico que foram assumidas como hipóteses, não verificadas algebricamente.

**Próximos passos para fechar os gaps** (por prioridade):
1. Formalizar os 3 candidatos restantes do LemmaVWMax (ALTO risco)
2. Derivar budget identities por backward induction (MÉDIO risco)
3. Derivar Δ₁(μ) e seus boundary values (BAIXO risco, mas trabalhoso)
