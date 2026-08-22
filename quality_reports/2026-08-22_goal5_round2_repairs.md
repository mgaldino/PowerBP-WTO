# Goal 5 — reparos técnicos após o segundo ciclo independente

## Fronteira do ciclo

O segundo candidato foi revisado no commit
`5539815ff840fc36d06f592de5fbbe2f09a16b71`, com SHA-256
`2a7ef9415cad5efe5c47573f67860e011b18e2f561bd46a755f8332d563790a5`
para o R Markdown e
`0c020de04c893c976869242307f6720d7585e0776ea3069d7f0caa08b2d12ad3`
para o PDF.

O parecer de exposição/visual foi `PASS 0/0/0`. O parecer de desenho formal foi
`FAIL 0/2/0`. Não houve finding substantivo ou advisory. Os dois findings eram
erros locais de redação formal; as proposições, provas e interfaces congeladas
já continham as expressões corretas.

Os pareceres completos estão preservados em:

- `quality_reports/2026-08-22_goal5_round2_formal_design_review.md`;
- `quality_reports/2026-08-22_goal5_round2_exposition_visual_review.md`.

## Reparos executados

1. Na tabela de protocolo, a continuação após falha em R1 passou a ser
   indexada pelo histórico público: `beta C_H(h^Y)` após voto sim de `H` e
   `beta C_H(h^N)` após voto não. O texto define os dois históricos e deixa
   explícito que os valores podem divergir porque o voto público pode alterar
   crenças antes de R2.
2. O preço do voto fraco em R1 foi separado por regra: `beta/m` sob maioria e
   `beta(1-o)/m` sob unanimidade com tipo público de disagreement payoff `o`.

## Validação do novo candidato

- SHA-256 do R Markdown:
  `34ad6d5481b42736646bc89d2e4fd39debe2766dcb9aa9cecd739000f0d50ec6`.
- SHA-256 do PDF:
  `76ad164c50942fc5d6b8bd4d4aa3cec866eba0ab139163746b3a31f770799fe3`.
- Compilação exclusiva por `rmarkdown::render("formal_model_v6.Rmd")`: PASS.
- PDF: 31 páginas; inspeção visual integral sobre imagens renderizadas do hash
  final, PASS.
- Busca negativa, marcadores P1/P2 e ausência de P3: PASS.
- Verificadores Gate 0, N1, N2, N3/N4, N6 e N7: PASS; apenas avisos isolados de
  locale.
- Artefatos congelados N1–N7: nenhum arquivo editado.
- `git diff --check`: PASS.
- Readability audit final: executada sem Pangram; relatório completo atualizado
  em `quality_reports/2026-08-22_readability-audit_formal_model_v6_round2.md`.

Qualquer commit que fixe este candidato deve preservar os dois hashes acima e
voltar aos dois revisores independentes, read-only, para o gate final.
