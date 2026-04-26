# Revisao: formal_model_v3.Rmd

**Data**: 2026-04-26
**Status**: CORRIGIDO

## Resumo

Manuscrito bem escrito no geral. Issues principais corrigidos: (1) erro logico substantivo no Appendix C (overpayment description invertida), (2) 5 cross-refs erradas na tabela de notacao, (3) typo "relative do", (4) inconsistencias menores de voz, dash e footnote syntax.

## Correcoes aplicadas

| Linha | Problema | Correcao |
|-------|----------|----------|
| 47 | "relative do" (typo PT) | "relative to" |
| 47 | Trailing space + parenthetical desnecessario | Removido "meaning an ability to secure a greater share of benefits" e trailing space |
| 53 | Comma fraca antes de lista apositiva | Colon: "...two distinct modes of exercising power: agenda power and informational power" |
| 58 | Unicode em dash (—) vs LaTeX (---) | Padronizado para --- |
| 98 | "In our game" / "We use" (voz plural) | "In this game" / "I use" |
| 57, 61, 80-81 | Double blank lines | Reduzido para single blank |
| 323 | Frase de 45 palavras com triple qualification | Dividida em duas frases |
| 412 | Forward reference "as established in" | "as shown in Section 7 below" |
| 690 | Pandoc ^[] footnote | Convertido para \footnote{} |
| 827 | mu: "Sec. 4" | "Sec. 3" |
| 833 | V_e: "Sec. 4" | "Sec. 3" |
| 834 | x: "Sec. 4" | "Sec. 3" |
| 835 | q: "Sec. 5" | "Def. 1" |
| 840 | tau(R): "Sec. 7" | "Sec. 6" |
| 935 | Pandoc ^[] footnote | Convertido para \footnote{} |
| 1162 | **Overpayment logic reversed** in App C | Corrigido: high offer overpays low types, not vice versa |

## Score pos-correcao

```
Score: 100
- Nenhum issue remanescente identificado
Score final: 98/100
Status: APROVADO para submissao (>=90)
```

Deducao residual (-2): cautela por potenciais issues nao detectados em equacoes do appendix.
