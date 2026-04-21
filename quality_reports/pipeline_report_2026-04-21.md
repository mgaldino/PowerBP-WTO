# Pipeline Report — 2026-04-21 (Round 2)

**Manuscript**: `formal_model_v2.Rmd`

---

## Estágio 1: Revisão de Código
- Rounds: 5/5
- Score inicial: 0 → Score final: **98/100**
- Issues corrigidas:
  - 3 bugs críticos nas funções de maioria (coalition size q-1 vs N-1, H payoff alpha*Ve vs beta*VH_R2, budget identity)
  - Bug no concavify() (lower hull → gift-wrapping algorithm)
  - Bug em VW_R1_unanimity (non-proposer payoff na branch agressiva)
  - Texto linha 172 (beta*alpha*V(theta) → alpha*V(theta))
  - Budget identity text corrigida (Appendix A.6 + Section 8.2)
  - Prova do Lemma 1 reescrita com fórmulas corretas de maioria
  - Lemma 1 + Theorem 1: condição alpha < alpha*(N, beta) adicionada
  - Figura 2: alpha range restringido a alpha < alpha*
- Issues remanescentes: 2 minor (inline comments, code duplication)
- Reports: `stage1_code_review_round2.md` through `round5.md`

## Estágio 2: Devil's Advocate
- Rounds: 3/5
- Score inicial: 45 → Score final: **85/100**
- Vulnerabilidades resolvidas:
  - Lemma 1 prova analítica completa (D_base + δ_R2 + δ_R1 decomposition)
  - Theorem 1 reescrito: 4 cases (a)-(d), single-crossing property, closed-form p*
  - alpha* restrictiveness discutida para N grande
  - BP commitment expandido (reputation, transparency, upper-bound)
  - Entry cost c interpretado para IOs
  - Missing literature (Feddersen & Pesendorfer, Diermeier & Myerson, Bardhi & Guo)
  - GATT/WTO com observable implication discriminante
  - Worked Example com magnitudes concretas
  - Introdução reescrita enfatizando single-crossing
  - K-type claim enfraquecida para conjectura
  - Dynamic claims com caveat explícito
  - τ(U) explicação piecewise
  - Extension Remark → Proposition formal
- Vulnerabilidades remanescentes: nenhuma blocking
- Reports: `stage2_devils_advocate_round2.md`, `round3.md`

## Estágio 3: Proofread
- Rounds: 2
- Score inicial: 77 → Score final: **100/100**
- Correções aplicadas: 8 de 8
  - 2 broken cross-references (\ref → \@ref)
  - 5 bare \mu_s → \mu_s^{R2} ou \mu_s^{R1}
  - 1 grammar (subjunctive tense)
  - 1 person inconsistency ("we" → "I")
- Reports: `stage3_proofread_round3.md`, `round4.md`

---

## Score Final Consolidado

| Estágio | Score | Threshold | Status |
|---------|-------|-----------|--------|
| Code Review | 98/100 | ≥80 | EXCELLENT |
| Devil's Advocate | 85/100 | ≥80 | PASS |
| Proofread | 100/100 | ≥90 | EXCELLENT |

**Média ponderada**: 94/100

## Status: EXCELENTE (≥90)
## Recomendação: Pronto para circular e apresentar em seminário.
