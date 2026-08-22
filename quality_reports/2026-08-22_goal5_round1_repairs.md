# Goal 5 — reparos técnicos após o primeiro ciclo independente

## Fronteira do ciclo

O primeiro candidato foi revisado no commit
`829b25f774a90398e53fb8d339e133b1b26be9ad`, com SHA-256
`848f86094fa6074fe034a3fdec97c47a0e710df8b99562b817a8224cf6b015e8`
para o R Markdown e
`133bf3238ad99493a4e74a573a2035a3756f4aa743906d8b2b0a298432835876`
para o PDF.

Os dois pareceres independentes foram `FAIL`: desenho formal `0/4/0` e
exposição/visual `0/5/0`. Não houve finding substantivo ou advisory. Todos os
nove findings tinham exatamente um reparo imposto pela matriz aprovada ou
pelas interfaces congeladas; portanto, o ciclo não exigiu resultado novo nem
decisão autoral adicional.

Os pareceres completos estão preservados em:

- `quality_reports/2026-08-22_goal5_round1_formal_design_review.md`;
- `quality_reports/2026-08-22_goal5_round1_exposition_visual_review.md`.

## Reparos executados

1. O conjunto factível agora declara `0 <= y <= y_bar`, não negatividade de
   `x_j` e `r_i`, `o_1 <= y_bar <= 1` e ausência de pagamentos laterais.
2. A lei de reconhecimento declara sorteios independentes, com reposição, e
   elegibilidade de todos os Estados fracos em R2, inclusive o proponente de
   R1.
3. Abstract, introdução e interpretação dos sinais qualificam o ganho do tipo
   baixo sob screening: positivo na célula comparável de crença alta, zero no
   endpoint e vazio na célula intermediária.
4. O empate residual é reportado como conjunto exato, com o mesmo `lambda`
   vinculando payoffs e outcomes; os envelopes exatos de `RI_M`, do contraste
   privado e de `DeltaRI` foram transportados; a simetria foi corretamente
   qualificada como invariância do vetor de payoff de H e da classe de outcome,
   não dos payoffs dos Estados fracos rotulados.
5. O diagrama de sequência foi redimensionado para a largura do texto.
6. As quatro tabelas numeradas e captionadas requeridas pela matriz foram
   inseridas: transições/payoffs, jogos públicos, correspondências privadas e
   rendas/diferença das diferenças.
7. Intuição econômica foi inserida imediatamente antes das Proposições 4.6 e
   4.7.
8. Os identificadores internos `Figure F1`--`Figure F4` foram removidos dos
   títulos e captions embutidos; permanece apenas a numeração do manuscrito.
9. A paginação foi ajustada para manter a conclusão integral em uma página.

## Validação do candidato reparado

- SHA-256 do R Markdown:
  `2a7ef9415cad5efe5c47573f67860e011b18e2f561bd46a755f8332d563790a5`.
- SHA-256 do PDF:
  `0c020de04c893c976869242307f6720d7585e0776ea3069d7f0caa08b2d12ad3`.
- Compilação: `rmarkdown::render("formal_model_v6.Rmd")`, PASS.
- PDF: 31 páginas, PDF 1.7, não criptografado.
- Inspeção visual: todas as 31 páginas, PASS; diagrama, tabelas, figuras,
  conclusão, apêndices e referências sem corte material.
- Busca negativa: nenhum uso de `opt-out`, `random proposer`, `A/C/R`,
  `C-B-R`, linguagem de versões ou identificadores internos F1--F4.
- P1/P2: somente os dois marcadores autorais aprovados.
- P3: nenhuma imagem, proposição ou cálculo ex ante no manuscrito.
- `git diff --check`: PASS; apenas avisos isolados de locale.
- Artefatos N1--N7: nenhum arquivo congelado foi editado.
- Verificadores Gate 0, N1, N2, N3/N4, N6 e N7: PASS; o texto congelado do
  verificador Gate 0 ainda registra a autorização anterior e não foi alterado.
- Readability audit: executada sem Pangram e salva integralmente em
  `quality_reports/2026-08-22_readability-audit_formal_model_v6_round2.md`.

Este candidato deve voltar aos mesmos dois papéis de revisão, de modo
independente e read-only, sobre exatamente estes hashes.
