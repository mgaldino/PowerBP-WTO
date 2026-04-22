# Plano: Next Steps v3 — Prioridades pós-review

**Status**: APPROVED
**Data**: 2026-04-22

## Prioridade 1: Fortalecer Lemma 1 para iff

- Lemma 1 atual: α < α* ⟹ dominância condicional para todo μ
- Novo: α < α* ⟺ dominância condicional para todo μ ∈ (0,1]
- Prova de necessidade: D(1) = D_base(1), α* zera D_base(1), δ_R1(1) = 0
- **Verificado matematicamente** (nota: `notes/2026-04-22_alpha_star_iff.md`)

## Prioridade 2: Remark sobre μ̄ quando α > α*

- Novo Remark após Lemma 1: quando α > α*, unanimidade domina para μ < μ̄
- μ̄ closed-form derivado na nota técnica
- Tabela numérica: N=164, α=0.08 (3x acima de α*), r=1.5 → μ̄ = 0.80
- Interpretação: falha de dominância apenas perto de μ=1 (informação quase pública)

## Prioridade 3: Tabela numérica no Scope

- Mostrar μ̄ para vários N e α, demonstrando que o mecanismo opera na vasta maioria do espaço de beliefs mesmo quando α > α*
- Responde diretamente à preocupação dos reviewers sobre α* restritivo para N grande

## Prioridade 4: τ(U) closed-form no appendix

- Adicionar expressão explícita de τ(U) por branch no Appendix A
- Reviewer flagou como opaco — é piecewise mas tem closed-form em cada branch

## Prioridade 5: Proof sketch para Proposition 5

- Agenda influence extension: única proposição sem prova
- Derivação curta: ρ_H(1-ρ_H) peaks at 1/2

## Prioridade 6: Worked example após Theorem 1

- Computar p* para parâmetros específicos
- Mostrar payoffs sob cada regra acima e abaixo de p*
- Ambos reviewers sugeriram

## Prioridade 7: Ajustes menores de exposição

- Harmonizar "screening rent" / "informational rent" → escolher um
- Comprimir Discussion 9.2 (GATT/WTO) em ~30%
- Cortar parágrafo 7 da introdução (repetitivo)
- Considerar magnitudes no abstract (16% surplus do motivating example)
