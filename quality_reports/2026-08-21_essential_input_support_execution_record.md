# Registro de execução — infraestrutura de apoio essential-input (A–D)

**Data:** 2026-08-21

**Worktree:** `/private/tmp/PowerBayesianPersuasion-essential-input-support`

**Branch:** `codex/essential-input-support-harness`

**Base imutável:** `8813303ac37be6d5ac9f3da822c0855d34e9e349`

## Escopo e estado preservado

- N1–N4 e N6 permaneceram `pass/frozen`; nenhum artefato congelado foi editado.
- N5 não integra o DAG.
- N7 permaneceu `pending/null` e não foi aberto, derivado ou preenchido.
- `formal_model_v6.Rmd` não foi editado nem compilado.
- Nenhum merge, cherry-pick ou cópia de `e29a519` foi feito.
- A branch contém apenas A–D, seus testes/pareceres e as linhas atuais de status.

## Tarefa A — harness numérico N1–N4

Os nomes canônicos `scripts/verify_essential_input_n1.R`,
`scripts/verify_essential_input_n2.R` e `scripts/verify_essential_input_n3.R`
já eram verificadores congelados/históricos. Para não sobrescrevê-los, o novo
harness usa o sufixo `_numeric.R`, acompanhado de runner e verificador dedicado
de fronteiras.

O módulo de fórmulas verifica, antes da execução, os SHA-256 exatos das nove
fontes congeladas/decididas que consome. O grid final contém 2.061 linhas por
nó (`N` em `{5,7}`, `beta` em `{0.5,0.9,0.99}`, onze famílias de pares
`o_0<o_1`, endpoints e vizinhanças até `1e-14` de cutoffs). Resultado:

```text
N1  PASS  2061/2061
N2  PASS  2061/2061
N3  PASS  2061/2061; onze células cobertas
N4  PASS  2061/2061; três células cobertas
Total     8244/8244
Strict-boundary regression checks: PASS
```

A busca de N4 enumera os quatro perfis puros de voto de `H` no ballot
problemático. O CSV e o `sessionInfo()` foram preservados em `quality_reports/`.

### Finding técnico e reparo revisado

O primeiro parecer independente detectou que `ei_tolerance=1e-10` participava
da classificação de células e poderia tratar um prior positivo muito pequeno
como `nu=0`. O problema era exclusivamente do harness, não da matemática
congelada. A correção unívoca foi: comparações estruturais exatas; tolerância
somente para assertions; Bayes sempre que a ação tem probabilidade estritamente
positiva; probes sub-tolerância explícitos. A rerevisão independente retornou
PASS 0/0/0.

## Tarefa B — calculadora sintética de `RI_g` e `DeltaRI`

O módulo implementa produto cartesiano de diferenças componente a componente,
sem convexificação; vazios absorventes por regra e no contraste; envelopes;
imagem ex ante; e robustez coordenada a coordenada. Nenhum payoff N6/N7 é
importado.

```text
RI_ESTIMAND_SYNTHETIC_TESTS: PASS
10 blocos; 33 expectations
```

O primeiro parecer independente detectou dois problemas genéricos: tolerância
implícita podia mudar o sinal de valores estritamente positivos muito pequenos,
e listas malformadas podiam sofrer reciclagem de `rbind`. A API agora usa sinal
estrito (`tolerance=0`) por default, propaga qualquer tolerância aproximativa
explicitamente e valida duas coordenadas antes de combinar vetores. Os testes
de regressão cobrem `1e-13`, tolerância inválida e lista malformada. A
rerevisão independente retornou PASS 0/0/0.

## Tarefa C — figuras de rascunho

Foram gerados três PDFs de uma página e seus CSVs em `figures/draft/`:

- plano `(o_0,o_1)` para `N=5`, com facetas N3/N4;
- partição em `nu` para `N=5`;
- tabela de margens.

A região sem PBE puro está hachurada e diretamente rotulada; `o_1=1/m` está
destacada; todos os PDFs têm título, legenda/caption e fonte. A revisão visual
independente deu PASS para rascunho (A−), sem findings P0/P1/P2 e com três
sugestões P3 para eventual versão de manuscrito: marcar melhor o endpoint
`nu=0`, limitar/clarificar a linha `nu_star` na faixa N3 e aumentar redundância
além de cor nas demais classes.

## Tarefa D — bibliografia e notas

Nove entradas com metadados/DOI verificados foram acrescentadas a
`references.bib`. O cruzamento com a nota nova passou no Pandoc/citeproc sem
chaves órfãs nem duplicatas no escopo.

A nota de posicionamento registra explicitamente sua fonte histórica:
`quality_reports/2026-08-21_honest_assessment_contribuicao_vs_literatura.md`
foi lida em `e29a519`, blob Git
`d42fae0a57012dda14a20ec6b5ab69304fc380a1`, SHA-256
`2c1c3acae17b419838082b7682a1609ca5a491cbf1887982bff82a8497710cef`.
Esse arquivo não foi copiado nem reconstruído na branch. Os dois PDFs locais
usados para localizar a bibliografia também estão identificados por SHA-256 na
nota. `DeltaRI` e `o_1=1/m` são tratados como estimando/projeção, não como
resultado antes de N7.

O exemplo `N=5` usa apenas N2 congelado e sua errata: `o_0=0.10`, `o_1=0.35`,
`nu_star=5/18`; ele não usa linguagem de opt-out.

## Verificadores canônicos e checagens auxiliares

Passaram:

```text
Rscript --vanilla scripts/verify_essential_input_gate0.R
Rscript --vanilla scripts/verify_essential_input_n1.R
Rscript --vanilla scripts/verify_essential_input_n2.R
Rscript --vanilla scripts/verify_essential_input_solution_concept_rederivation.R
Rscript --vanilla scripts/verify_essential_input_n6.R
```

O comando histórico `scripts/verify_essential_input_n3.R` continua obsoleto:
ele fixa o antigo caminho de artefato e `passed_order=6`, enquanto o N3 final
está no workspace `essential_input_solution_concept` com ordem 7. Esse FAIL
histórico foi inspecionado como stale verifier, não como divergência matemática;
o arquivo não foi editado.

## Desvios e incidentes procedimentais sem impacto material

1. Antes da criação da worktree, houve um único probe `Rscript -e` para
   disponibilidade de pacotes. Ele não alterou artefatos ou resultados, foi
   reportado à coordenação e não foi repetido.
2. A primeira execução do harness parou na antiga linha N3-105 porque dois
   payoffs matematicamente iguais diferiam por `1.11e-16`; o diagnóstico salvo
   confirmou empate de ponto flutuante e ausência de finding contra N3.
3. Uma chamada de validação usou por engano o nome inexistente
   `scripts/verify_essential_input_solution_concept_n3_n4.R`; ela falhou antes
   de executar. O nome correto,
   `scripts/verify_essential_input_solution_concept_rederivation.R`, passou.
4. O R emite avisos ambientais de locale `C.UTF-8` no startup. Scripts e
   relatórios usam UTF-8, e os avisos não alteraram outputs.
5. A limpeza final de `tmp/pdfs/` alcançou também renders rastreados que já
   existiam no commit-base. O `git status` detectou a remoção antes do staging,
   e `tmp/pdfs/pivotal_response_render` foi restaurado byte a byte do `HEAD`
   `8813303`. O status final não contém deleções ou modificações nesse diretório.

## Conclusão

Não houve finding numérico contra N1–N4 nem conflito substantivo com N6. Os
findings de implementação do primeiro review-r foram corrigidos e receberam
rerevisão independente PASS 0/0/0. N1–N6 permanecem congelados no sentido da
cadeia corrente (N5 removido), e N7 permanece `pending/null`, não iniciado.
