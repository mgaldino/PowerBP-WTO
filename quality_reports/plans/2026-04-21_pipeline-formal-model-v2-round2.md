# Plano: Research Pipeline — formal_model_v2.Rmd (Round 2)

**Status**: APPROVED
**Data**: 2026-04-21

## Objetivo
Pipeline completo de revisão de qualidade: Code Review → Devil's Advocate → Proofread.
Arquivo: `formal_model_v2.Rmd` (1120 linhas). Última pipeline: 98/85/100.

## Abordagem
3 estágios sequenciais com agentes separados (reviewer ≠ implementador).
Scoring via quality-gates.md. Threshold: 80 (code/DA), 90 (proofread).

## Estágios
- [ ] Stage 1: Code Review — avaliar chunks R (funções, simulações, figuras)
- [ ] Stage 2: Devil's Advocate — estressar argumento do manuscrito
- [ ] Stage 3: Proofread — gramática, typos, consistência, cross-refs

## Verificação
- [ ] Cada review salvo em quality_reports/stageN_*_roundM.md
- [ ] Relatório final em quality_reports/pipeline_report_2026-04-21_r2.md
