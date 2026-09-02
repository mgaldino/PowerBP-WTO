# Manifesto da revisão de exposição, apresentação técnica e notação

**Data:** 2026-09-02  
**Status:** candidato com PASS independente no escopo autorizado  
**Manuscrito:** `formal_model_v6.Rmd`  
**PDF:** `formal_model_v6.pdf`

## Escopo autorizado

Foram implementados os itens 1--10 e 16 consolidados a partir de
`quality_reports/2026-09-02_review-formal-model.md`:

1. abstract em linguagem acessível e sem notação;
2. segunda contribuição em linguagem natural;
3. intuição da renda do tipo de outside option baixo;
4. divulgação exata da célula vazia, incluindo o cutoff;
5. antecipação do mecanismo e dos resultados principais;
6. condensação da discussão bibliográfica duplicada;
7. promoção do exemplo numérico completo para o corpo;
8. explicação das mudanças deliberadas de parâmetros;
9. remoção da tabela de rendas e do crosswalk redundantes;
10. numeração dos quatro resultados principais da extensão de agenda;
16. eliminação das colisões fortes de notação, com auditoria de resíduos.

O item 13 não foi implementado. As provas de `A_M` e `A_U` existem nos
artefatos formais e têm status `pass/frozen`, mas ainda não foram transportadas
para o manuscrito. Os demais itens do parecer permanecem fora deste escopo.

## Fronteira de versão

- Commit-base em `main`: `32ac8b4`.
- Tag anotada anterior às mudanças:
  `pre-exposition-technical-notation-revision-2026-09-02`.
- Branch de trabalho: `codex/exposition-technical-notation-revision`.
- Commit exato do manuscrito e do PDF auditados: `cce9c2fd0832c369f70cc9014c8bbf92aefa5901`.
- Nenhum push foi realizado.

Checkpoints:

1. `fc517d1` — exposição e exemplo completo;
2. `84472a6` — remoção de redundâncias;
3. `2a3deb2` — numeração dos resultados da extensão;
4. `cb627dc` — refatoração das colisões fortes de notação;
5. `a84c7f6` — primeira renderização sincronizada;
6. `e903f15` — correção de dois resíduos encontrados pela revisão técnica;
7. `cce9c2f` — correção exata da fronteira da célula vazia e renderização final.

## Bytes auditados

```text
4890a43e977f269e2893860054f73ee40528a3426bd6cde7fb0947b0bba1776d  formal_model_v6.Rmd
d91fb9a78514b6b4c080d28c3a582ab485e1454f544e29f3f7259134d4fccae8  formal_model_v6.pdf
```

O PDF final tem 63 páginas.

## Validação

- `Rscript --vanilla -e 'rmarkdown::render("formal_model_v6.Rmd")'`: PASS.
- `git diff --check`: PASS.
- Busca por símbolos antigos do item 16: PASS, zero resíduos.
- Referências indefinidas `??` no PDF: zero.
- Inspeção visual das 63 páginas e ampliação das páginas alteradas: PASS para
  recorte, sobreposição, glifos, margens e legibilidade.
- Revisão independente de exposição e visual: PASS no escopo dos itens 1--10.
- Revisão independente de apresentação técnica e notação: PASS no item 16.
- Auditoria matemática independente: PASS 0/0/0; fórmulas, domínios,
  correspondências, rankings e exemplos permaneceram invariantes.

Os PASS são delimitados aos bytes acima e ao escopo autorizado. Eles não
estendem retroativamente as certificações históricas do projeto e não cobrem
os problemas do parecer que ainda não foram autorizados.

## Reversão segura

A forma mais simples de abandonar integralmente este candidato é voltar para a
branch principal, que permaneceu em `32ac8b4`:

```bash
git switch main
```

Para restaurar apenas o manuscrito e o PDF anteriores dentro da branch de
revisão, sem apagar o histórico, usar:

```bash
git restore --source pre-exposition-technical-notation-revision-2026-09-02 -- formal_model_v6.Rmd formal_model_v6.pdf
git commit -m "revert: restore pre-exposition manuscript snapshot"
```

