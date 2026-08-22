# Goal 5 — correção autoral do puzzle no abstract

## Finding autoral

O abstract revisado anteriormente abria perguntando por que hegemons constroem
organizações internacionais que decidem por consenso. Essa pergunta excedia o
que o modelo explica: o jogo mantém a regra de votação fixa e não contém uma
etapa de criação, escolha ou adoção institucional.

## Correção

O abstract agora abre com a comparação que o modelo efetivamente resolve:

> When can unanimity advantage a hegemon over majority rule despite equal votes
> and weak-state agenda control? When is that advantage informational rather
> than merely due to veto power?

A introdução preserva a pergunta de escolha institucional como motivação de
fundo, mas declara imediatamente a fronteira: o modelo mantém a regra fixa e
resolve o puzzle mais estreito sobre vantagem comparativa e sua decomposição
entre veto e informação.

Essa mudança não altera mecanismo, proposição, prova, figura, tabela ou
resultado congelado. O abstract final tem exatamente 200 palavras.

## Validação

- SHA-256 de `formal_model_v6.Rmd`:
  `61c309c5a24bd93c72b42136d5ea637c56a714b91393b04cfaf21c6831abceb1`.
- SHA-256 de `formal_model_v6.pdf`:
  `5a29b0de02249ce80911555cd377ceae9d96afcdd4fe9371847a0d4b09f193b4`.
- Compilação exclusiva por `rmarkdown::render("formal_model_v6.Rmd")`: PASS.
- PDF: 31 páginas; inspeção visual integral: PASS.
- Verificadores Gate 0, N1, N2, N3/N4, N6 e N7: PASS.
- Busca negativa e disciplina P1/P2/P3: PASS.
- Readability audit sem Pangram: atualizada.
- Anotação de abstract:
  `quality_reports/abstract_annotation_formal_model_v6.md`.

Como o Rmd e o PDF receberam novos hashes, o candidato deve retornar aos dois
revisores independentes antes de novo registro de prontidão para aval autoral.
