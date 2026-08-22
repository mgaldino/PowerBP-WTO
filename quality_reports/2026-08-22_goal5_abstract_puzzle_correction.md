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
  `32b49f7503caac34cdf225f73d7e76ab60d1340937b095e3e611f009030f8744`.
- SHA-256 de `formal_model_v6.pdf`:
  `85d24122008af9ad484a6df53679c3f455f75fb94fffc70aa9ccbd8ffb62fe17`.
- Compilação exclusiva por `rmarkdown::render("formal_model_v6.Rmd")`: PASS.
- PDF: 31 páginas; inspeção visual integral: PASS.
- Verificadores Gate 0, N1, N2, N3/N4, N6 e N7: PASS.
- Busca negativa e disciplina P1/P2/P3: PASS.
- Readability audit sem Pangram: atualizada.
- Anotação de abstract:
  `quality_reports/abstract_annotation_formal_model_v6.md`.
- Reflow tipográfico: a página inicial da introdução foi ampliada em uma linha,
  sem mudança textual, para eliminar duas linhas viúvas nas páginas 3 e 4.

Como o Rmd e o PDF receberam novos hashes, o candidato deve retornar aos dois
revisores independentes antes de novo registro de prontidão para aval autoral.
