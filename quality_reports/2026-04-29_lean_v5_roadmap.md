# Lean v5 — Roadmap de Próximos Passos

**Data**: 2026-04-29
**Contexto**: Formalização v5 criada em `FormalProofs/V5/` com 7 arquivos, build passando, 0 sorry. Relatório de fidelidade em `quality_reports/2026-04-29_lean_fidelity_v5.md` identificou gaps entre "0 sorry" e "prova do paper verificada".

## O que já está verificado (ÁLGEBRA COMPLETA)

Estes resultados têm cadeia algébrica fechada desde GameParams até a conclusão:

- **Theorem 1** (conditional dominance iff): 19 teoremas encadeados, decomposição D = D_base + corrections
- **Prop 1** (majority affine + λ_M > α)
- **Prop 3** (screening jump > 0)
- **Props auxiliares**: d_star > 0, alpha_star > 0, V_e properties, endpoint evaluations

## O que é factível na próxima sessão

### Gap 1: Definir payoffs de equilíbrio e verificar budget identities

**O que fazer**: Definir as fórmulas de continuation value como definições Lean (não como hipóteses abstratas), e verificar algebricamente que somam V_e(μ).

```lean
-- Definir R2 continuation values sob maioria
def V_H_R2_majority (p : GameParams) (θ : ℝ) : ℝ :=
  V_theta p θ * (1 + ((p.N : ℝ) - 1) * p.α) / (p.N : ℝ)

def V_W_R2_majority (p : GameParams) (μ : ℝ) : ℝ :=
  (1 - p.α) * V_e p μ / (p.N : ℝ)

-- Verificar budget identity: E[V_H] + (N-1)·V_W = V_e
theorem budget_majority_R2 : ...
```

**Estimativa**: ~100 linhas Lean, 1-2 horas. Principalmente `unfold; ring`.

**Impacto**: Fecha os gaps do Corollary (F_U ⊆ F_M) e Prop 4. Transforma as budget identities de LÓGICA ABSTRATA → ÁLGEBRA COMPLETA.

### Gap 2: Definir os 4 candidatos de V_W e verificar bounds (LemmaVWMax)

**O que fazer**: Definir V_W^{CH}, V_W^{AH}, V_W^{CL}, V_W^{AL} como funções Lean e provar V̄_W - candidato ≥ 0 nos endpoints para cada um.

O candidato Conservative-High já está verificado ((N+β)(r-1)(1-μ) ≥ 0).

Faltam:
- **Aggressive-High**: V̄_W - V_W^{AH}(μ) = [(1-μ)(r-1) + μr(1-β)]/N > 0
- **Conservative-Low**: V̄_W - V_W^{CL}(μ) affine, checar endpoints
- **Aggressive-Low**: V̄_W - V_W^{AL}(μ) affine, checar endpoints

**Estimativa**: ~200 linhas Lean, 2-3 horas. A parte mais delicada é o "cancelamento quadrático" nos candidatos Aggressive (termos (1-μ)·ω(μ) que o paper alega cancelarem).

**Impacto**: Fecha o gap de maior risco. Transforma LemmaVWMax de ALTO risco → BAIXO risco.

### Gap 3: Boundary values de Δ₁ e single-crossing (Prop 2)

**O que fazer**: Definir Δ₁(μ) concretamente (diferença entre payoff agressivo e conservador no R1), calcular Δ₁(0) e Δ₁(1) algebricamente.

**Estimativa**: ~80 linhas Lean, 1 hora.

**Impacto**: Transforma Prop 2 de LÓGICA ABSTRATA → ÁLGEBRA COMPLETA (pelo menos para existência; unicidade exige provar que Δ₁/(1-μ) é decrescente, o que requer a forma quadrática).

## O que fica FORA do Lean (e por quê)

### 1. Backward induction / existência de equilíbrio PBE

**O que é**: A derivação de que as fórmulas de payoff realmente descrevem o equilíbrio do jogo (sequential rationality, belief consistency, optimal offers).

**Por que fica fora**: Nenhum proof assistant no mundo tem uma formalização de jogos de barganha legislativa (Baron-Ferejohn). Formalizar o game tree + backward induction + PBE requer:
- Tipos indutivos para game trees com chance nodes e information sets
- Conexão entre probability theory (Mathlib) e payoffs esperados
- Definição formal de PBE (beliefs + sequential rationality)

Estimativa: 2-4 meses de trabalho focado, seria contribuição acadêmica nova.

**Mitigação**: As fórmulas de equilíbrio são derivadas no paper por backward induction standard (Baron-Ferejohn é modelo textbook). O risco de erro está na *álgebra* entre as fórmulas, não na *lógica* do equilíbrio. A álgebra está (ou será) verificada em Lean.

### 2. Programação linear / otimização

**O que é**: LP, simplex, otimalidade de offers no bargaining.

**Por que fica fora**: Mathlib não tem LP formalizado. Existe CvxLean para otimização convexa, mas não cobre LP standard. A otimalidade das offers no Baron-Ferejohn é trivial (comprar os mais baratos), não requer LP formal.

### 3. Concavificação / Bayesian Persuasion

**O que é**: O envelope côncavo de v(μ, R) e a construção ótima de sinais.

**Por que fica fora**: No paper v5, Bayesian Persuasion foi relegada a Remark (não é resultado principal). A concavificação requer análise convexa (Fenchel, suporte de hiperplanos) que existe parcialmente no Mathlib mas seria trabalho substancial para formalizar no contexto do modelo.

### 4. Tipos contínuos (Appendix C)

**O que é**: Extensão para θ ~ F[1, r] com distribuição contínua.

**Por que fica fora**: Requer measure theory + integration (disponível no Mathlib) aplicada a payoffs de equilíbrio. A Prop 5 (screening rent contínuo) depende de integrais que seriam trabalhosas de formalizar. Prioridade BAIXA (resultado de appendix, não central).

## Ordem recomendada para próxima sessão

1. **Gap 1** (budget identities) — maior impacto, fecha Corollary + Prop 4
2. **Gap 2** (4 candidatos V_W) — fecha o gap de maior risco
3. **Gap 3** (Δ₁ boundary values) — complementar

**Estimativa total**: ~400 linhas Lean, 4-6 horas de trabalho iterativo.

## Arquivos de referência

- Formalização v5: `formal_proofs/FormalProofs/V5/`
- Relatório de fidelidade: `quality_reports/2026-04-29_lean_fidelity_v5.md`
- Definições algébricas (reusáveis): `FormalProofs/Lemma1/Definitions.lean`
- Pesquisa game theory em Lean: `quality_reports/2026-04-29_lean4-game-theory-landscape.md`
- Skills: `/lean-proofs` (atualizada com Relatório de Fidelidade obrigatório), `/lean-tactic` (nova, loop iterativo)
