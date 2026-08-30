# Status atual da extensão de agenda

**Data de referência:** 2026-08-29

**Natureza:** registro administrativo; não contém nova matemática

**Fonte estruturada:** `model_redesign/agenda_extension_status_current.json`

## Resposta curta

`A_M` sob M/S/B está **`pass/frozen`** nos bytes exatos aprovados. `A_U`,
`AC` e `AR` continuam **`pending/unfrozen`** e não estão autorizados. Não há
autorização para migrar resultados ao manuscrito, criar tag, fazer merge ou
push.

| Nó | Status atual | Pode ser executado ou consumido agora? |
|---|---|---|
| `A_M` | `pass/frozen` | Apenas os bytes congelados podem ser citados; o status não autoriza trabalho downstream. |
| `A_U` | `pending/unfrozen` | Não. Requer auditoria própria e cega sob M/S/B. |
| `AC` | `pending/unfrozen` | Não. Depende de `A_U` e de provas de suficiência ou fatoração específicas da operação. |
| `AR` | `pending/unfrozen` | Não. Exige GO autoral separado após o pacote privado revisado. |

## Autoridade do status de `A_M`

O registro terminal
`quality_reports/2026-08-29_A_M_msb_two_layer_terminal_approval_and_freeze.md`
(SHA-256
`ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158`)
documenta:

- dois pareceres independentes `PASS 0/0/0` sobre o mesmo candidato;
- adjudicação `NO_CONFIRMED_DEFECTS`, sem defeitos confirmados, parciais ou
  não resolvidos;
- aprovação autoral terminal; e
- congelamento apenas dos hashes listados no manifesto final
  `quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256`
  (SHA-256
  `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e`).

Os quatro bytes matemáticos centrais permanecem:

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_M_msb_results.md` | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` |
| `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv` | `321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c` |
| `scripts/verify_agenda_extension_A_M_msb.R` | `b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391` |
| `quality_reports/verification_outputs/2026-08-29_A_M_msb_two_layer_signature_verifier_output.txt` | `3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628` |

## Por que alguns arquivos ainda dizem “pendente”

Os arquivos abaixo foram produzidos antes da emenda M/S/B e descrevem outros
schemas, ledgers e candidatos:

- `model_redesign/agenda_extension_game_dag.json`;
- `model_redesign/agenda_extension_game_dag_simplified.json`;
- `scripts/verify_agenda_extension_A_M_mechanical.R`; e
- relatórios e candidatos datados anteriores ao fechamento M/S/B.

Eles continuam corretos **como registro histórico do estado que existia quando
foram escritos**. Seus campos de lifecycle não descrevem o pacote M/S/B
posterior. Por isso, esses arquivos não foram reescritos: editar sua proveniência
criaria a falsa impressão de que o candidato antigo foi o candidato aprovado.

Há uma segunda aparente inconsistência deliberada: o ledger M/S/B congelado
ainda contém frases como “independent review pending”. Elas registravam o estado
do candidato quando seus bytes foram submetidos à revisão. Atualizá-las agora
mudaria o próprio objeto revisado e invalidaria a identidade por hash. O status
posterior deve ser lido neste documento e no registro terminal.

## Regra para o futuro

Para saber **o status atual**, leia primeiro este arquivo e o JSON estruturado.
Para saber **o que foi provado e em quais bytes**, siga o registro terminal e o
manifesto final. Use os DAGs antigos apenas para reconstruir a história dos
contratos anteriores.

Uma futura mudança de lifecycle deve atualizar este sidecar e produzir um novo
registro administrativo. Ela não deve modificar retrospectivamente os
artefatos matemáticos congelados nem os DAGs históricos.
