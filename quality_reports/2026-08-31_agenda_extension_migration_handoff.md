# Handoff da matriz de migração da extensão de agenda

**Data:** 2026-08-31

**Estado desta frente:** `COMPLETE_HANDOFF_READY`

**Branch:** `codex/agenda-extension-manuscript-integration`

**Snapshot substantivo da matriz:** commit `4d3cf852ea8fd4dfd290398e0341925d62990a56`

## 1. O que está encerrado nesta worktree

A worktree de integração contém uma matriz auditável de 34 linhas que liga os
resultados formais, as comparações adicionais, as decisões editoriais, a
apresentação final e a reconstrução racionalista de Steinberg a destinos
possíveis no manuscrito.

O pacote foi verificado mecanicamente com `224 PASS / 0 FAIL`. Esse resultado
confirma integridade de arquivos, hashes, manifests, claims e âncoras. Ele não é
aprovação matemática ou editorial da futura reescrita.

O manuscrito permaneceu intocado nesta worktree. Os hashes preservados são:

| Artefato | SHA-256 |
|---|---|
| `formal_model_v6.Rmd` | `00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6` |
| `formal_model_v6.pdf` | `3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be` |

## 2. Fontes que o implementador deve consumir

1. `quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.tsv` é
   a fonte canônica em nível de linha.
2. `quality_reports/plans/2026-08-30_agenda_extension_migration_matrix.md`
   explica a arquitetura, as travas e os gates.
3. `quality_reports/2026-08-31_seminar_and_steinberg_migration_extract.md`
   registra a triagem da apresentação e de Steinberg.
4. `quality_reports/plans/2026-08-31_agenda_extension_migration_matrix_expanded_manifest.sha256`
   fixa os bytes do pacote.
5. `quality_reports/verification_outputs/2026-08-31_agenda_extension_migration_matrix_verifier_output.txt`
   registra a validação mecânica.

## 3. Informação recebida sobre a reescrita

O autor informou que outro agente já iniciou a reescrita do paper. Neste
checkpoint, nenhuma nova branch ou commit de reescrita aparece entre os heads
locais recentes. Isso pode significar apenas que o agente ainda não fez seu
primeiro commit ou trabalha em uma worktree ainda não registrada neste host.

Esta frente não deve tentar localizar, interromper, editar ou incorporar o
trabalho em andamento. Quando a reescrita for entregue, o primeiro passo é
registrar sua worktree, branch e commit exatos antes de comparar conteúdo.

## 4. Travas que continuam valendo

- As cinco linhas `MIG-AT-*` e `MIG-SEM-03` continuam
  `BLOCKED_PENDING_AT_FREEZE`, porque \(A_T\) permanece `reviewed/unfrozen`
  neste snapshot.
- O `224 PASS / 0 FAIL` não autoriza transportar uma linha bloqueada.
- O quadro de Steinberg é uma reconstrução racionalista do autor, não um
  modelo formal atribuído a Steinberg.
- A figura pública/reversão pode ser usada como ilustração dos resultados já
  cobertos; a figura causal \(D/I/T\) depende do fechamento de \(A_T\).
- Nenhum resultado set-valued pode ser convertido em seleção única durante a
  redação.

## 5. Checklist para aceitar a reescrita do outro agente

1. identificar a branch, a worktree, o commit e o merge-base da reescrita;
2. conferir o diff do Rmd contra o snapshot congelado do v6;
3. mapear cada alteração substantiva para uma linha do TSV;
4. recusar ou isolar qualquer conteúdo oriundo de linha ainda bloqueada;
5. conferir notação, datas de payoff, domínios, correspondências e linguagem de
   condição suficiente versus necessária;
6. compilar pelo formato YAML/bookdown, conferir referências cruzadas, figuras,
   tabelas e PDF;
7. gerar hashes do novo candidato e submetê-lo a revisão independente por
   agentes que não fizeram a implementação;
8. somente após adjudicação e aprovação autoral, atualizar os status da matriz,
   criar tag ou integrar a branch.

## 6. Ações deliberadamente não realizadas

Não houve edição do paper, merge, rebase, tag, push, remoção de worktrees ou
mudança do estado formal de \(A_T\). As worktrees antigas marcadas como
`prunable` também não foram removidas: limpeza de infraestrutura é uma ação
separada e não necessária para encerrar esta frente.
