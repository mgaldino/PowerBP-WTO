# Migração de B.1/B.3 para o manuscrito v6

**Status:** MIGRATION CANDIDATE — UNREVIEWED — UNFROZEN

**Branch:** `codex/exclusion-proof-b1-b3`

## Boundary pré-migração

- tag anotada: `v6-pre-b1-b3-exclusion-migration-2026-09-02`;
- commit apontado pela tag:
  `8be463f24e3012b75cd76623e167ac3ba1ed7904`;
- `formal_model_v6.Rmd` pré-migração:
  `374bbd4b381a9be797fecadeca875fcd42ba8b946191ad389bd8b7994f70ae43`;
- `formal_model_v6.pdf` pré-migração:
  `6ab0a693aea61f341ba5027c36831f23a9d3fc8edd8c8bda3038370dfee82505`;
- memorando de derivação reparado e aprovado pelos dois pareceres finais:
  `2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256`.

## Escopo implementado

Somente dois blocos de `formal_model_v6.Rmd` foram alterados:

1. a abertura de B.1, na prova da maioria terminal;
2. a abertura e a transição para os quatro candidatos em B.3.

A migração:

- substitui a regra antiga `x_H+o` pela comparação correta entre `x_H` após
  sim e `o` após não;
- demonstra que há `m-1` respondedores fracos e que `k<=m-1` para `m>=3`;
- explicita por que os votos fracos são independentes de `x_H` e da crença
  nas aplicações majoritárias;
- prova que todo `x_H>0` não pivotal é estritamente subótimo para o
  proponente;
- preserva o limiar pivotal `beta o`;
- separa dominância não pivotal de redução aos limiares `beta ell` e
  `beta h`;
- explicita o voto sim de `H` por indiferença quando `n_Y<=k-2`.

Nenhum enunciado de proposição, fórmula de payoff, cutoff, figura, tabela,
bibliografia, primitive ou outra subseção foi editado.

## Render e checks locais

O manuscrito foi compilado com:

```text
LC_ALL=pt_BR.UTF-8 LANG=pt_BR.UTF-8 Rscript --vanilla -e
"rmarkdown::render('formal_model_v6.Rmd',
output_format='bookdown::pdf_document2', clean=TRUE)"
```

Resultado: `Output created: formal_model_v6.pdf`, exit code zero.

- PDF: 67 páginas, letter, não criptografado;
- B.1: página 36;
- B.3: páginas 37–38;
- extração textual das páginas afetadas contém a nova contagem, os três casos
  de `n_Y` e a transição para os quatro candidatos;
- inspeção visual das páginas 36–38: sem texto cortado, sobreposição, fórmula
  quebrada ou problema de hierarquia/paginação;
- busca literal por `x_H+o` em `formal_model_v6.Rmd`: zero ocorrências;
- `git diff --check`: PASS.

## Bytes candidatos pós-migração

- `formal_model_v6.Rmd`:
  `7de0b2eddc20b98509f8fa37a299860f83164b7469097598532aa5cbfbd7a2a7`;
- `formal_model_v6.pdf`:
  `97ff2d5fa3878550a5b6ea77c642b99ad4543aec760e92ff7941495ea552ed00`.

## Gate

Os checks acima são mecânicos e visuais; não constituem revisão matemática ou
editorial independente. O próximo gate exige revisores que não editaram os
arquivos para verificar fidelidade ao memorando, correção game-teórica,
ausência de alteração downstream e integração visual. Este relatório não
autoriza merge, push, promoção para `main` ou tag final.
