# Plano: Research Pipeline — formal_model_v5.Rmd

**Status**: APPROVED
**Data**: 2026-04-27

## Objetivo
Rodar pipeline completo de qualidade (3 estágios) no paper v5.

## Arquivos alvo
- Manuscrito: `formal_model_v5.Rmd` (1070 linhas)
- Código R: `scripts/model_functions.R` + chunks inline no Rmd (linhas 484-678)
- Bibliografia: `references.bib`

## Pipeline

### Estágio 1: Code Review
- Avaliar `scripts/model_functions.R` + R chunks no Rmd
- Rubrica: quality-gates.md (R scripts + RMarkdown)
- Gate: Score ≥ 80

### Estágio 2: Devil's Advocate
- Estressar argumento do manuscrito
- Rubrica: quality-gates.md (manuscritos acadêmicos)
- Gate: Score ≥ 80

### Estágio 3: Proofread
- Gramática, typos, consistência, cross-refs, equações
- Rubrica: quality-gates.md (RMarkdown)
- Gate: Score ≥ 90

## Verificação
- [ ] Stage 1 score ≥ 80
- [ ] Stage 2 score ≥ 80
- [ ] Stage 3 score ≥ 90
- [ ] Pipeline report salvo em quality_reports/pipeline_report_2026-04-27.md
