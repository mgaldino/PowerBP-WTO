# Preflight — candidato de assinatura de `A_M` em duas camadas

**Data:** 2026-08-29

**Status:** `IMPLEMENTATION PREFLIGHT PASS — FORMAL REVIEWS PENDING`

**Natureza:** checagem de escopo, tipagem, hashes e execução. Não é parecer
formal, não aprova as provas e não altera o gate.

## 1. Identidade do snapshot

- worktree: `/private/tmp/PBP-am-msb`;
- branch: `agenda-extension-am-msb`;
- HEAD pré-implementação:
  `9ff11e4c0f41b95dadc026efb77072197ce487ec`;
- candidato substantivo anteriormente revisado:
  `6b94f2f57aaf8615972e27479435be1db7d44d7f`;
- commit substantivo desta implementação:
  `e020629d5bad8fbd66d67cf108b1a2e0d8b048fd`.

Depois de `6b94f2f`, `a3f7f7f`, `0eef332`, `c5d9f49` e `9ff11e4`
acrescentaram somente pareceres, adjudicação, consultas, decisão e prompt. A
mudança substantiva seguinte é `e020629`.

## 2. Documentos governantes conferidos

| Documento | SHA-256 conferido |
|---|---|
| decisão aprovada em duas camadas | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| consulta Fable, não formal | `608b9459d26063c6e45f895ba70bd00c2f73bf12cdff3dac854a9b62746e10d7` |
| consulta ChatGPT Web, não formal | `142a39ed2124aca50743e92ef67f505192eb6d159f546b3d8b0c42a274804d0b` |
| emenda M/S/B aprovada | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| clarificação aprovada | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |

## 3. Escopo do commit substantivo

O commit `e020629` contém somente:

1. `model_redesign/agenda_extension_A_M_msb_results.md`;
2. `model_redesign/agenda_extension_A_M_msb_claim_ledger.tsv`;
3. `scripts/verify_agenda_extension_A_M_msb.R`;
4. `quality_reports/verification_outputs/2026-08-29_A_M_msb_two_layer_signature_verifier_output.txt`.

Hashes desses bytes:

| Artefato | SHA-256 |
|---|---|
| resultados | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` |
| ledger | `321cb2ed45ed1c5ebb6103a4ac567f07b735dd7a2ca8e2252925b43b8a2add9c` |
| script | `b3133ab97870cf9c5730c57da40c2c9f4d68912226bb8d8f080022653e2a8391` |
| output | `3a242732c07b3d6ed5c508ca0238d1665c42de9d4f00f857b4030fe724ce7628` |

Não houve alteração em `A_U`, `AC`, `AR`, N1–N7, manuscrito, PDF ou
interfaces congeladas. A tag anotada `v6-essential-input-2026-08-25`
continua apontando ao objeto `44e2b46c6163a7acc0f854c37bb26e63bcd3c9a2` e ao commit
`b3c8a4f3181a450e35c1a803c0134b8d96704360`.

## 4. Checagens estruturais e mecânicas

- `git diff --check`: limpo;
- ledger: 31 linhas, 16 campos em todas, IDs únicos;
- Markdown de resultados: 170 fences, balanceados;
- busca por `Sig_M`, `Sig_boundary`, `[_]_anon`, Reynolds como representante
  e a antiga linha `AMX-016`: nenhuma ocorrência obsoleta;
- `X_M`, `Omega_D`, `Omega_T`, `Z`, `P(Z)^2` e `Z/G`: carriers e estruturas
  Borel-padrão explicitados para `N` e primitivas fixos;
- verificador:

  ```text
  env LC_ALL=C LANG=C Rscript scripts/verify_agenda_extension_A_M_msb.R
  SUMMARY | 3954 PASS | 0 FAIL
  ```

As novas regressões cobrem `P/Q`, invariância de `Lambda`, invariância do
pushforward por `q_Z`, pesos `(.9,.1)` versus `(.5,.5)` e preservação da lei
do posterior. Elas não provam Borelidade, completude geral, PBE, Bayes nem
fatorização downstream.

## 5. Resultado do preflight

O candidato está coerente para empacotamento e envio a duas revisões formais
novas sobre exatamente os bytes do manifesto. Este `PASS` é apenas de
preflight de implementação. Até as revisões e a aprovação autoral terminal:

- `AMX-016a/b` não são `pass/frozen`;
- `AC/AR` não consomem `A_M`;
- `A_U` segue pendente de auditoria própria;
- não há tag, merge ou promoção ao manuscrito.
