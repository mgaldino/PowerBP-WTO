# Prompt para próxima sessão: Extensão Heterogeneidade + V Endógeno

## Contexto

Estou desenvolvendo uma extensão (paper futuro) do modelo v3 de Bayesian Persuasion + Baron-Ferejohn. A nota técnica principal está em `notes/2026-04-22_heterogeneidade_V_endogeno.md`. O spec está em `quality_reports/plans/2026-04-22_heterogeneidade-V-endogeno-spec.md`.

## O que já foi feito

1. **Modelo especificado**: N jogadores, cada um com α_i privado (contribuição + outside option). V(S) = M·(1 - e^{-λA(S)}) com A(S) = Σ α_i^γ, γ ∈ (1,2). Exponencial saturante. M = m·N (pie escala com N).

2. **Screening + BP derivados** (tipos binários, W's simétricos): cutoff μ_s = Δα/(Δα + Π), value function com jump, concavificação, BP gain = p·Π·(N-1)/N. Tudo correto (verificado por agente revisor).

3. **Exclusão sob maioria**: derivada a condição de exclusão. Mecanismo: discriminação estatística (W exclui H porque adverse selection é custosa).

4. **Problema do free look identificado e RESOLVIDO**: nas derivações TITL, a offer agressiva sob maioria dá "free look". Com BF 2 rounds e δ < 1, o free look desaparece. Seção 10 da nota contém a análise completa.

5. **BF 2 rounds com δ — COMPLETO (Seção 10)**:
   - R2 (terminal) sob unanimidade: continuation values v_h, v_L, v_L^{con}, V_W^{R2,U} derivados
   - R2 (terminal) sob maioria: exclusão no regime de saturação, V_H^{R2,M}, V_W^{R2,M} derivados
   - R1 sob unanimidade: backward induction, offers δv_h (conservative) e δv_L^{dev} (aggressive), cutoff μ_s^{R1}(δ) implícito
   - R1 sob maioria: decomposição B/C, μ_{excl}(δ) = B/(B+C), demonstração de que δ resolve o free look
   - Worked example: N=100, q=51, δ=0.8, λ=20 → μ_{excl}=0.024, exclusão para p=0.10
   - Value function e BP: jump em μ_s^{R1} gera não-concavidade, BP opera sob unanimidade, não sob maioria
   - Review aplicado: V_W^{R2,M} corrigido para [V_{\H}^q + (N-q)α_W]/N, números recalculados

6. **Também testada e descartada**: power function V = C·A^σ (sem saturação). Não gera exclusão. Documentado na Seção 8.4 da nota.

## O que falta fazer

1. **Resolver μ_s^{R1}(δ) numericamente**: o cutoff de screening em R1 é dado por equação implícita. Implementar em R ou Python e computar para os parâmetros do worked example. Verificar BP gain completo (R1 + R2, não só R2 benchmark).

2. **Worked example com saturação parcial**: usar λ menor (e.g., λ=5) onde exclusão NÃO ocorre para todo δ. Mapear a fronteira (λ, δ) onde exclusão emerge. Isso mostra que δ é necessário (não só saturação).

3. **Verificação matemática final**: chamar agente revisor na Seção 10 completa após correções.

4. **Estática comparativa de δ e BP gain**: como δ afeta o BP gain? Predição: δ baixo → mais exclusão sob maioria → mais valor de unanimidade para H. Mas δ baixo também reduz o jump sob unanimidade (multiplicado por δ). Qual efeito domina?

5. **Exclusão vs. conservadora em R1**: o review notou que a comparação explícita está ausente. Derivar Π_1^{excl} > Π_1^{cons}(μ) para completar.

## Decisões de design já tomadas (não reabrir)

- V(S) = M·(1 - e^{-λA(S)}) com A = Σ α_i^γ — exponencial saturante
- M = m·N — pie escala com N
- γ ∈ (1,2) — grandes α_i contribuem mais que proporcionalmente
- d_i = α_i — outside option = tipo (dual role)
- Tipos binários para benchmark: α_H ∈ {α_L, α_h}, W's com α_W conhecido
- Mecanismo de exclusão via discriminação estatística
- Power function descartada (não gera exclusão)
- Logística com massa crítica (κ > 0) descartada (complicação desnecessária)
- **BF 2 rounds com δ**: resolve o free look, é o modelo correto

## Arquivos relevantes

- `notes/2026-04-22_heterogeneidade_V_endogeno.md` — nota técnica (DRAFT v4)
- `quality_reports/plans/2026-04-22_heterogeneidade-V-endogeno-spec.md` — spec
- `CLAUDE.md` — seção "Paper Futuro: Heterogeneidade e Potências Médias" atualizada
- `quality_reports/plans/2026-04-18_heterogeneous-W-plan.md` — plano antigo (DESCARTADO, erros)
