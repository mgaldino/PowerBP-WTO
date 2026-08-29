# Preflight corrente — candidato exploratório bloqueado de `A_M`

**Data:** 2026-08-28  
**Worktree:** `/Users/manoelgaldino/.codex/worktrees/4678/PowerBayesianPersuasion`  
**Base Git:** `b427671efee954831901e75762988043a2df7205`  
**Estado:** `EXPLORATORY CANDIDATE — LOCAL REPAIRS IMPLEMENTED — AMX-014–016 BLOCKED BY CURRENT PRIMITIVES — REVIEW PENDING`

## Escopo

Foram atualizados somente a derivação exploratória de `A_M`, seu ledger, o
script R, o pacote textual para auditoria externa, o PDF correspondente e os
registros exploratórios/preflight. `A_U`, `AC`, `AR`, o manuscrito, o contrato,
`C_M`, os artefatos congelados e o pacote privado não foram alterados. Não
houve commit, push, merge ou tag.

Os reparos locais autorizados restringem as construções gerais AMX-003 e
AMX-007 a `0<nu<1`, remetem endpoints exclusivamente a AMX-005 e localizam a
prova de AMX-011 na Section 5.4, com o bound de AMX-010. O certificado novo não
seleciona hipótese econômica e mantém AMX-014–016 bloqueados.

## Bytes governantes consumidos

| Papel | Caminho | SHA-256 |
|---|---|---|
| contrato simplificado | `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md` | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| `C_M` congelado | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| decisão do conceito de solução | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| emenda autoral/técnica de 28/08 | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/quality_reports/2026-08-28_decisao_autoral_e_emenda_tecnica_agenda_extension.md` | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |
| parecer externo preservado | `quality_reports/external_reviews/2026-08-28_auditoria_equilibrios_AM_original.md` | `d8b5654f1ab9c8a78ecc6efe071d7e7537c61c39fb648e64ed3103e6e009c70c` |
| PDF originalmente auditado | `quality_reports/external_reviews/2026-08-28_agenda_extension_A_M_equilibria_chatgpt_pro_packet_audited_original.pdf` | `a4794a258c20ad028d31908ae2e59fe10ab847cd3a7f203ee08ca6fb91fe7394` |

## Snapshot corrente e registros

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_M_explicit_majority_results.md` | `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f` |
| `model_redesign/agenda_extension_A_M_explicit_majority_claim_ledger.tsv` | `d2d81d3b0cf65d59e4e5846f599a5f67677507c51c9c3677e39e75907a0e4274` |
| `scripts/verify_agenda_extension_A_M_explicit.R` | `e277d1ab845391b8ae01a61ce7fc9a64225dca1591783102b3916ccc07bf6177` |
| `reports/chatgpt_pro_packets/2026-08-28_A_M_explicit_equilibria_review_packet.md` | `3c961923f598973ac845e6b92b10b8606c288fac57c14bf5b4f24bbf90b74e04` |
| `output/pdf/agenda_extension_A_M_equilibria_chatgpt_pro_packet.pdf` | `9e3f9ec4a055ca7bfa5630d53b77fbce16605030797e1d68cedf4760a7e1eb75` |
| `quality_reports/2026-08-28_A_M_AMX014_016_exploration_convergence.md` | `7aec87cda1f752a244cd92258250bb59b4de408af6b7a37535bd103f42bd9add` |

Os pareceres/adjudicações históricos dos snapshots anteriores permanecem
inalterados e não cobrem estes bytes correntes. Nenhum novo `PASS` ou
`freeze` foi produzido.

## Verificações

- `Rscript --vanilla scripts/verify_agenda_extension_A_M_explicit.R`:
  **571 PASS / 0 FAIL**. O script cobre identidades, exemplos, endpoints e o
  contraexemplo `17/25` versus `13/25`; é evidência mecânica, não prova do
  teorema negativo ou de completude.
- O PDF corrente foi recompilado com Pandoc/XeLaTeX usando
  `markdown+tex_math_dollars+tex_math_single_backslash`; `pdfinfo` reportou 22
  páginas. Páginas de abertura, exemplos, contraexemplo, certificado
  negativo, mapa de claims e proveniência foram renderizadas por Poppler e
  inspecionadas; não foram observados cortes, sobreposições ou glifos
  ilegíveis.
- Os três exploradores independentes foram somente leitores. A convergência,
  os hashes que receberam e a conclusão negativa estão em
  `quality_reports/2026-08-28_A_M_AMX014_016_exploration_convergence.md`.

## Regra de invalidação

Qualquer mudança no contrato, na decisão de solução, em `C_M` ou nos bytes
correntes invalida este preflight. A eventual revisão futura deverá cobrir
exatamente o novo snapshot; as revisões históricas não são estendidas. O
estatuto permanece exploratório: AMX-014–016 estão bloqueados porque um
seletor Borel admissível pode eliminar o `argmax` puro e misto, e nenhuma
restrição adicional foi escolhida.
