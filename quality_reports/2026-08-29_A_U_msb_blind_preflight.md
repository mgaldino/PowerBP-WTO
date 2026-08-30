# Preflight cego — reconstrução `A_U` sob M/S/B

**Data:** 2026-08-29  
**Resultado:** `PASS`  
**Declaração cega:** esta solução foi fechada sem acesso ao candidato antigo.

## Snapshot

```text
worktree: /private/tmp/PBP-am-msb
branch: agenda-extension-am-msb
HEAD inicial: 3da7a03afc682da2fc3d11735927da5c290f2589
árvore inicial: limpa
```

Nenhum reset, reparo, merge, tag ou push foi executado.

## Hashes de entrada

```text
fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4  quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md
8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b  quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md
6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3  quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md
f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b  model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json
cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8  quality_reports/plans/2026-08-29_decisao_assinatura_duas_camadas_A_M.md
```

O manifesto final e os dois pareceres de N4 citam o mesmo hash
`f1c823...408b` de `C_U`. A decisão de assinatura de `A_M` só foi lida depois
de a correspondência estratégica própria de `A_U` estar fechada em rascunho,
e apenas para compatibilidade downstream. Nenhuma fórmula de `A_M` foi usada.

## Protocolo cego aplicado

Antes do blind-lock, foram lidos apenas os arquivos da whitelist. Não foram
lidos, buscados, abertos, comparados ou usados artefatos históricos de `A_U`,
artefatos `AC`, auditorias do pacote privado, memória, rollouts, sessões ou
resultados matemáticos de `A_M`.

As skills `solve-dynamic-games` e `formal-game-theory-polisci`, inclusive
`solve-dynamic-games/references/templates.md`, governaram o contrato, o DAG, a
ordem reversa, os gates, o ledger de datas e a separação entre prova e teste
mecânico.
