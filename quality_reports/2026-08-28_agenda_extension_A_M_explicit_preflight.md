# Preflight e proveniência — solução explícita exploratória de `A_M`

**Data:** 2026-08-28  
**Worktree:** `/Users/manoelgaldino/.codex/worktrees/4678/PowerBayesianPersuasion`  
**Base Git:** `b427671efee954831901e75762988043a2df7205`  
**Ref de origem conferida:** `refs/heads/codex/agenda-extension-ac` no mesmo commit  
**Estado inicial:** limpo, `HEAD` destacado  
**Status do trabalho:** `EXPLORATORY — MAJORITY NOT APPROVED OR FROZEN`  
**Operações proibidas mantidas:** nenhum commit, push, merge ou tag; nenhum
arquivo de `A_U`, `AC`, `AR`, manuscrito ou `essential-input` foi alterado.

## Bytes efetivamente lidos

Os hashes abaixo foram recalculados nesta worktree ou diretamente na worktree
privada indicada. Eles identificam os bytes substantivos consumidos pela
derivação; os arquivos congelados foram somente lidos.

| Papel | Caminho | SHA-256 |
|---|---|---|
| instruções locais | `AGENTS.md` | `4c08314990b413fb10151063d10a38f55793f560a9125ad1718834e7fcf892c1` |
| memória legada local | `CLAUDE.md` | `754339c9344ef977c5db39d2ef5c596b170e1d3245631defdf30a5cc616bb85e` |
| contrato simplificado | `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md` | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| aprovação do contrato | `quality_reports/2026-08-27_fechamento_autoral_gate0_agenda_extension_simplified.md` | `0a8ccf93b6986b1a9d7ad552c8ae690ea4e0a7816ec1999bf8a3dc454c85d26d` |
| fechamento da infraestrutura | `quality_reports/2026-08-27_fechamento_goal1_agenda_extension.md` | `282c2f397fd8f7ecd4b6817ceda71a17ddac1fe0a5c879201c4a54864dd9461c` |
| decisão vigente de crenças e votação | `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| folha terminal de maioria | `model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json` | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| continuação completa `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| prova de `C_M` | `model_redesign/essential_input_solution_concept/n3_r1_majority_rederivation_candidate.md` | `75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3` |
| ledger de `C_M` | `model_redesign/essential_input_solution_concept/n3_claim_ledger.tsv` | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` |
| manifesto de revisão de `C_M` | `quality_reports/2026-08-21_n3_final_review_manifest.sha256` | `90d6d8bfc4f1ef18c7edf5f9e1ea08870aec0385e625573e31b1b63a5a3d2bd4` |
| revisão formal de `C_M` | `quality_reports/2026-08-21_n3_final_formal_design_review.md` | `0863f748fe6927794a7fa8cd14b99176dcfbc1092c60a8fee6f1189a30663b7c` |
| revisão game-theoretic de `C_M` | `quality_reports/2026-08-21_n3_final_game_theory_review.md` | `b90efd428c24884ffc32a1bc713d9f77f4b88efb98a903fd3606e28b1436e99f` |
| interfaces externas fixadas | `model_redesign/agenda_extension_goal1_external_interfaces.json` | `588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86` |
| decisão autoral/técnica de 28/08 | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/quality_reports/2026-08-28_decisao_autoral_e_emenda_tecnica_agenda_extension.md` | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |
| registro do reparo privado | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/quality_reports/2026-08-28_reparo_pacote_privado_agenda_extension.md` | `644ff84bfc904e7cd1e9dad43972271c809379709d7dc986d348825db6d5ec96` |
| `A_M` implícito reparado | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/model_redesign/agenda_extension_A_M_candidate_simplified.json` | `03dd083c64a8b47e811f75968b73e6470f6ac0644e59c1d8147b31d06e8af139` |
| derivação implícita reparada | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/model_redesign/agenda_extension_A_M_derivation_simplified.md` | `ff9e1ab2a0f628aab163a3295129980121ddd892e485b1ba13327e75faa82304` |
| ledger implícito reparado | `/private/tmp/PowerBayesianPersuasion-agenda-private-repair/model_redesign/agenda_extension_A_M_claim_ledger_simplified.tsv` | `836288e5320a95e41ed9fec513096f1748221a10216c341b00914aecf19bd3d5` |

## Instrução metodológica consumida

| Caminho | SHA-256 |
|---|---|
| `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md` | `25bc9deb538ad61ed890116f920ef30a5d8e0e0ceb29b750912f3494a50fa184` |
| `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md` | `683317cb9ba64726e036b36aee3f7364ca73f08c3e200656287f9186aea80211` |

## Regra de invalidação

Qualquer mudança em `C_M`, no contrato simplificado ou na decisão de 28/08
invalida toda a derivação explícita descendente. Uma mudança apenas nos novos
artefatos exploratórios invalida sua revisão independente, mas não altera os
bytes históricos acima. Este preflight não promove o candidato implícito, não
estende o aval substantivo de `A_U` e não concede status a `A_M`.
