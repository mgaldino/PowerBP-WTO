# Fechamento autoral do Goal 4 — N7

**Data:** 2026-08-21

**Natureza:** registro administrativo posterior ao congelamento; não altera
nenhum artefato matemático ou parecer revisado.

## 1. Decisão do autor

Depois de receber o resultado final, os hashes, os dois pareceres independentes
e a confirmação de congelamento, o autor declarou literalmente:

> Aprovo N7 congelado, encerro o Goal 4 e autorizo sua consolidação
> administrativa, sem abrir o Goal 5.

Essa decisão satisfaz o aval autoral posterior exigido pela Seção 11 do
contrato. O Goal 4 está encerrado. Goal 5 continua não autorizado.

## 2. Objeto aprovado

- commit local de congelamento N7:
  `8ef5fa980976febb8fdf1f0dfc0cb25702ece63e`;
- interface N7 `complete_information_benchmark_v1`, SHA-256:
  `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45`;
- parecer `formal_design`: `PASS 0/0/0`, SHA-256
  `eca9697269589688a0bb568be96deeaa446326e2a40b8b9c3c0c919159857aad`;
- parecer `game_theory`: `PASS 0/0/0`, SHA-256
  `42604ed0770923c1fa94e3a4314376a1fd3bb05f3fb024750b77fa7e9da4ae0d`;
- registro final de integração N7, SHA-256:
  `bd4136ae84084d089905344a41edf24d6bcd91bf6e095f7b58ccb0d04a296bfc`.

No estado aprovado, N1, N2, N3, N4, N6 e N7 estão `pass/frozen`; N7 é terminal
e o checker do DAG retorna `Ready: none`.

## 3. Consolidação autorizada

A consolidação administrativa incorpora o commit N7 à branch local
`codex/essential-input-post-n6-consolidation`, que já preserva:

- o checkpoint congelado de N6;
- a documentação autoral da checkout principal;
- a infraestrutura paralela de apoio, que não foi consumida na derivação N7.

A consolidação não pode editar os bytes congelados de N1--N7, seus pareceres,
o contrato ou os manuscritos. Deve reexecutar os manifestos e verificadores
canônicos e terminar em commit local limpo, sem push, tag ou migração.

## 4. Fronteira seguinte

O alvo potencial seguinte é o Goal 5, migração dos resultados congelados para
`formal_model_v6.Rmd`. Este registro não o abre. Qualquer trabalho no manuscrito
exige nova autorização explícita do autor e uma worktree própria.
