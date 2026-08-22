# Validação bibliográfica — nota de posicionamento

**Data:** 2026-08-21

**Escopo:** nove entradas adicionadas a `references.bib` e suas citações em
`notes/2026-08-21_intro_positioning_skeleton.md`. O manuscrito protegido não foi
editado nem incluído neste cruzamento.

## Resumo

- Entradas no `.bib` depois da adição: 40.
- Novas entradas: 9.
- Chaves citadas na nova nota: 9 chaves únicas.
- Citações órfãs no escopo: 0.
- Duplicatas por obra/DOI entre as novas entradas: 0.
- Novas entradas com campo obrigatório ausente: 0.
- Sintaxe/citeproc: PASS com Pandoc.

## Comando de validação cruzada

```bash
pandoc notes/2026-08-21_intro_positioning_skeleton.md --citeproc --bibliography=references.bib --to=plain --output=/private/tmp/pbp-positioning-citations-check.txt
```

O comando terminou com exit `0`, sem chave ausente nem erro de parsing.

## Entradas verificadas

| Chave | Obra | Fonte primária de metadados |
|---|---|---|
| `miller2018heterogeneous` | Miller, Montero e Vanberg (2018) | ScienceDirect, DOI `10.1016/j.geb.2017.11.003` |
| `tsai2009evaluation` | Tsai (2009) | National Taiwan University Scholars, DOI `10.1016/j.jce.2009.01.001` |
| `tsaiYang2010majoritarian` | Tsai e Yang (2010) | Wiley, DOI `10.1111/j.1468-2354.2010.00607.x` |
| `chenEraslan2013informational` | Chen e Eraslan (2013) | Sage, DOI `10.1177/0951629813482232` |
| `chenEraslan2014rhetoric` | Chen e Eraslan (2014) | Theoretical Economics, DOI `10.3982/TE821` |
| `ma2023efficiency` | Ma (2023) | ScienceDirect, DOI `10.1016/j.jet.2023.105649` |
| `feddersenPesendorfer1998convicting` | Feddersen e Pesendorfer (1998) | Cambridge Core, DOI `10.2307/2585926` |
| `winter1996voting` | Winter (1996) | Cambridge Core, DOI `10.2307/2945844` |
| `mccarty2000proposal` | McCarty (2000) | Princeton Research, DOI `10.2307/2669261` |

## Chaves citadas e resolvidas

```text
@miller2018heterogeneous
@winter1996voting
@mccarty2000proposal
@tsai2009evaluation
@tsaiYang2010majoritarian
@chenEraslan2013informational
@chenEraslan2014rhetoric
@ma2023efficiency
@feddersenPesendorfer1998convicting
```

As 31 entradas restantes não são classificadas como “fantasma”: elas já
pertenciam à bibliografia geral do projeto, e a nota nova não pretende ser o
texto principal do paper.
