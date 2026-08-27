# Execução e preflight — `A_M` da extensão de agenda

**Data:** 2026-08-27
**Escopo:** somente `A_M`, agenda privada sob maioria
**Status:** `DERIVED CANDIDATE — DAG STILL PENDING — FINAL PACKAGE REVIEWS PENDING`

## Preflight

- HEAD inicial e corrente antes das edições:
  `8b5ea05b355c870116d0b70d7b5fbbea81b44176`;
- worktree inicial: limpa, em detached HEAD;
- `C_M` recalculado:
  `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- hash esperado de `C_M`:
  `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- resultado: dependência íntegra e consumível sem edição;
- `CLAUDE.md`, `AGENTS.md`, o contrato simplificado, os registros de fechamento
  e auditoria do Goal 1 e o manifesto de interfaces foram lidos antes da
  derivação;
- as skills `formal-game-theory-polisci` e `solve-dynamic-games`, inclusive o
  template de dependências, foram lidas integralmente;
- nenhuma interface ou fórmula candidata do estágio seguinte foi aberta.

## Clarificação autoral aplicada

A IC fraca é avaliada ponto a ponto em cada vetor pivotal. Para `j`, somente
seu payoff próprio `x_j` no acordo e seu payoff próprio
`beta*C^I_{M,j}(kappa_M(h))` na rejeição entram na comparação. A mesma ação
pura, que não observa `v_-j`, deve satisfazer todas as histórias pivotais. Um
conflito de sinais elimina o binder candidato. Não se introduziu kernel, média
entre vetores, tremble nem invariância de `kappa_M`.

## Artefatos produzidos ou alterados

| Artefato | Ação | SHA-256 corrente |
|---|---|---|
| `model_redesign/agenda_extension_A_M_candidate_simplified.json` | criado | `c45b4420b0c1a4fe7dac2187ee90e79da5d47365eb32ebe2759aaa746ebcb976` |
| `model_redesign/agenda_extension_A_M_derivation_simplified.md` | criado | `e4bade93df0e4c42037e1e85ac69f9163a0917370d18e12c674d3a54c1d46f72` |
| `model_redesign/agenda_extension_A_M_claim_ledger_simplified.tsv` | preenchido somente para `A_M` | `9934db4a5b677bf6ac95683f495f94dee0fbd390a5574892d5c8c907294c923b` |
| `scripts/verify_agenda_extension_A_M_mechanical.R` | criado | `1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747` |

O hash deste próprio registro é calculado e reportado separadamente para
evitar autorreferência.

## Preservação de fronteira

| Artefato protegido de controle | SHA-256 corrente |
|---|---|
| ledger do estágio seguinte | `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580` |
| ledger de integração privada | `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580` |
| ledger público opcional | `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580` |
| DAG simplificado | `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0` |
| `C_M` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |

O nó `A_M` continua `pending` no DAG e não recebeu `artifact_path`,
`artifact_hash`, `dependency_hashes` ou `review_paths`. Nenhum manuscrito,
arquivo de submissão, nó congelado, ledger fora de `A_M`, verificador ou
manifesto do Goal 1 foi editado.

## Verificações

### Checker dedicado de `A_M`

```text
Rscript --vanilla scripts/verify_agenda_extension_A_M_mechanical.R
SUMMARY | 59 PASS | 0 FAIL
LIMIT | Mechanical structure and finite falsification only; not a mathematical proof.
```

Foram verificados mecanicamente: schemas mínimos, hash de `C_M`, referência da
visão completa, binder, imagem ex ante, ledger, ausência de sentinela, aplicação
única de `beta`, quotas e perfis pivotais para `N=3,...,12`, exemplos das três
regiões da resposta ponto a ponto, preservação dos outros ledgers e ausência de
campos finais no DAG.

### Runners históricos do Goal 1

```text
Rscript --vanilla scripts/verify_agenda_extension_goal1.R
SUMMARY | 30 PASS | 1 FAIL
```

A única falha é `gate0_hash_A_M_empty_ledger`: o runner histórico prende os
bytes do ledger vazio do Gate 0, enquanto a autorização corrente exige o
preenchimento legítimo desse ledger. Todas as outras 30 verificações passaram.

```text
Rscript --vanilla scripts/test_agenda_extension_goal1.R
SUMMARY | 38 PASS | 1 FAIL
```

A única falha é `repository_positive_all_checks`, que chama o verificador
histórico completo e herda exclusivamente a divergência esperada do ledger
`A_M`. Os outros 38 testes, inclusive os negativos, passaram. O verificador,
seu manifesto e seus testes não foram modificados para ocultar essa diferença.

### Higiene

```text
git diff --check
```

Terminou com código zero. Os avisos de locale do R e do `shasum` não alteraram
parsing, hashes, resultados ou códigos de saída substantivos.

## Limite epistêmico e próxima fronteira

O checker dedicado é falsificação mecânica, não prova matemática. Necessidade,
suficiência, cobertura, Bayes local, mensurabilidade e ausência de desvio de
`H` sobre todo `Y` estão demonstradas no documento de derivação e permanecem
sujeitas às duas revisões matemáticas finais do pacote privado. Esta execução
para em `A_M`; nenhum consumidor ou estágio posterior foi aberto.
