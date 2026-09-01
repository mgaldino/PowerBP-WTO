# Validação bibliográfica independente: proposta OMC e literatura

**Data:** 2026-08-31
**Revisor:** agente independente, somente leitura
**Escopo:** `formal_model_v6.Rmd`, proposta de introdução, proposta de seção de
literatura/aplicação OMC e `references.bib`
**Veredito:** `PASS estrutural; ajustes bibliográficos recomendados`

Nenhum arquivo foi alterado pelo revisor.

## Resumo

- Entradas no `.bib`: **42**.
- Ocorrências de citação no conjunto auditado: **47**.
- Chaves únicas citadas: **21**.
- Citações órfãs: **0**.
- Entradas não citadas: **21**.
- Chaves ou títulos duplicados: **0**.
- Entradas sem campos obrigatórios: **0**.
- Artigos sem campo `doi`: **18**, dos quais cinco são citados e têm DOI
  confirmado.
- `pandoc --citeproc`: exit `0` no manuscrito e nas propostas.

## Citações órfãs

Nenhuma. Todas as 21 chaves citadas existem em `references.bib`.

## Entradas não citadas

| Grupo | Chaves |
|---|---|
| Barganha, informação e teoria | `admati1987strategic`, `bardhi2018modes`, `cho1987signaling`, `cramton1984bargaining`, `fearon1995rationalist`, `gould2016consensus`, `gruber2000ruling`, `ikenberry2001after`, `kamenica2011bayesian`, `keohane1984after`, `kim2025persuasion` |
| Comércio/OMC | `bhagwati2008termites`, `blackhurst2000options`, `jawara2003behind`, `jones2010manoeuvring` |
| OPEP/petróleo | `alhajji2000dominant`, `fattouh2013opec`, `griffin1994oil`, `nakov2013saudi`, `simmons2005twilight`, `yergin1990prize` |

As seis entradas da OPEP já estão sem citação. Retirar a aplicação da OPEP não
criará nova quebra entre texto e bibliografia. Como o Pandoc normalmente imprime
somente obras citadas, mantê-las não afeta o PDF; antes de removê-las por higiene,
convém verificar outros documentos que possam compartilhar esse `.bib`.

## Problemas confirmados no `.bib`

| Chave | Problema | Metadado confirmado |
|---|---|---|
| `baron1989bargaining` | DOI ausente | `10.2307/1961664` |
| `kalandrakis2006proposal` | DOI ausente | `10.1111/j.1540-5907.2006.00193.x` |
| `eraslan2019legislative` | DOI ausente | `10.1146/annurev-economics-080218-025633` |
| `koremenos2001rational` | DOI ausente | `10.1162/002081801317193592` |
| `steinberg2002shadow` | DOI ausente | `10.1162/002081802320005504` |
| `yergin1990prize` | chave contém `1990`, mas `year={1991}` | alinhar chave e edição apenas se a obra for mantida |

Os outros treze artigos sem DOI não são citados no conjunto auditado. Completar
seus metadados só faz sentido depois de decidir se serão preservados.

## Cinco referências prioritárias

| Referência | Resultado |
|---|---|
| Steinberg (2002) | Autor, título, periódico, volume 56(2), páginas 339--374 e ano corretos. Falta o DOI. O PDF local confirma a retirada coordenada de Estados Unidos e Comunidade Europeia do GATT 1947, o *single undertaking* e a extração de informação. |
| Baron e Ferejohn (1989) | Metadados corretos: *American Political Science Review* 83(4), 1181--1206. Falta o DOI. |
| Kalandrakis (2006) | Metadados corretos: *American Journal of Political Science* 50(2), 441--448. Falta o DOI. O texto confirma a caracterização substantiva usada na proposta. |
| Piazolo e Vanberg (2025) | Entrada completa e correta: *Games and Economic Behavior* 153, 499--522, DOI `10.1016/j.geb.2025.07.010`. |
| Glynia, Thum e Xefteris (2026) | Entrada correta no estágio atual. O artigo permanece online-first; ausência de volume, número e páginas não é erro hoje. Reconsultar antes da submissão final. |

## Adequação substantiva

As caracterizações de Baron--Ferejohn, Kalandrakis, Piazolo--Vanberg e
Glynia--Thum--Xefteris correspondem aos textos verificados.

A aplicação à OMC é sustentada por Steinberg, com uma ressalva editorial: o
artigo atribui o fechamento da Rodada Uruguai e a retirada do GATT 1947 à ação
coordenada Estados Unidos--Comunidade Europeia, não aos Estados Unidos
isoladamente.

No manuscrito atual, a frase `the United States holds no agenda power` deveria
distinguir ausência de direito formal exclusivo de proposta de poder informal
de agenda. A introdução proposta já faz essa correção.

## Comandos reproduzíveis

```zsh
AUDIT_ROOT=/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-agenda-integration

rg -c '^@[A-Za-z]+\{' "$AUDIT_ROOT/references.bib"

rg -P -o --no-filename \
  '(?<![[:alnum:]_.+-])@[A-Za-z][A-Za-z0-9_:+-]*' \
  "$AUDIT_ROOT/formal_model_v6.Rmd" \
  "$AUDIT_ROOT/quality_reports/rewrite_formal_model_v6.Rmd.md" \
  "$AUDIT_ROOT/quality_reports/proposed_literature_and_wto_application_formal_model_v6.md" \
  | sed 's/^@//' | sort | uniq -c

pandoc "$AUDIT_ROOT/formal_model_v6.Rmd" \
  --citeproc --bibliography="$AUDIT_ROOT/references.bib" \
  -t plain -o /dev/null

pandoc \
  "$AUDIT_ROOT/quality_reports/rewrite_formal_model_v6.Rmd.md" \
  "$AUDIT_ROOT/quality_reports/proposed_literature_and_wto_application_formal_model_v6.md" \
  --citeproc --bibliography="$AUDIT_ROOT/references.bib" \
  -t plain -o /dev/null
```
