# Adjudicação independente — `A_C` fortalecido, rodada 1

**Adjudication ID:** `a-c-msb-strengthened:509cc3540135:round1`  
**Data/hora:** `2026-08-30T13:08:53-03:00`  
**Modo:** estritamente read-only  
**Branch:** `agenda-extension-am-msb`  
**Candidato revisado:** `02d217283948fbf430a10491c0907d484dbac3b4`  
**HEAD de materialização dos pareceres:** `c21e55425e9209d40d6fd377e0b304c910483054`

## 1. Identidade da fonte

O artefato revisado é
`quality_reports/2026-08-30_AC_msb_strengthened_candidate_manifest.sha256`,
com SHA-256
`509cc3540135721011f979ffd63ff1413b364fd8065b8c7a1ae581a572605e0e`.
Suas oito entradas passaram integralmente:

| Artefato | SHA-256 |
|---|---|
| autorização de fortalecimento | `67e5b948d2746b2d2d34ec788e61682ca4fa080a521ca588e606c00567b47e93` |
| contrato | `c5cb77679a119b04466329a0774671b8121d402e2dfd517fe3dfb2e88b357346` |
| resultados | `28d779b89a1d756050874bec8b1e042a42c27bbda9b87a2878f94e1c58f083f7` |
| interface | `40b975f85b6df485e91c8f1ce551d9342e102199bf9f15697b44f7dd10f371a1` |
| ledger | `6622be30b69b242b0621712881044e75750f1ece78cb9573d3b64ad90c9fbc97` |
| verificador | `8b4e7bd1bfc08e760eac3d97bf904d2f64abf8f54e35f8d8eda81bf4d4d0bf70` |
| output mecânico | `f396c6ba14b991571b0a0ca84eac125a91a8706228a76d13b4555152f0436e1c` |
| DAG | `4d359ae788162b554c9b9a55b78f6b5f57a62802208ee725d400d2d4b2b96210` |

O commit do candidato é ancestral do HEAD de materialização; a diferença contém
somente os dois pareceres. Não existe argument-contract JSON compatível com o
validador, portanto o registro estruturado usa `contract.required=false`.

## 2. Disposição executiva

| ID | Finding | Estado | Severidade | Reparo |
|---|---|---|---|---|
| `AC-STRENGTH-R1-MIN-1` | Sidecars correntes ainda pinam o candidato anterior | `CONFIRMED` | minor | `safe` |
| `AC-STRENGTH-R2-MIN-1` | Linguagem universal sobre não identificação de acoplamento falha em casos degenerados | `PARTIAL` | minor | `safe` |
| `AC-STRENGTH-R2-MIN-2` | Autorização adicional não percorre integralmente contrato, interface, DAG e ledger | `CONFIRMED` | minor | `safe` |

Não há finding material não resolvido. O veredito é
`READY_FOR_IMPLEMENTATION`. Isso não congela `A_C`, não constitui aprovação
autoral terminal e não autoriza `A_R` ou trabalho downstream.

## 3. Pareceres adjudicados

| Parecer | SHA-256 | Resultado | Mérito matemático |
|---|---|---|---|
| R1 — `quality_reports/2026-08-30_AC_msb_strengthened_formal_review_1.md` | `4e713e987005d5720e837544fbed9a1412578b514a45d7bea0291341507622db` | `FAIL 0/0/1` | Sustenta integralmente a matemática fortalecida |
| R2 — `quality_reports/2026-08-30_AC_msb_strengthened_formal_review_2.md` | `1551d53032e56efa55df5f29401e75dcd02ae59a128c26418b91d79696f51976` | `FAIL 0/0/2` | Sustenta T5, `g_T5`, `g_0`, `D_E`, endpoint, exemplo e paridade |

## 4. Evidência e raciocínio

### `AC-STRENGTH-R1-MIN-1` — `CONFIRMED`

Os sidecars correntes ainda descrevem o pacote anterior: manifesto
`fc9788a0...`, `941 PASS / 0 FAIL`, revisões antigas e gate terminal
`68eeefe8...`. O status humano chama os 12 hashes anteriores de objeto pronto
para decisão terminal. A autorização fortalecida exige sincronizar os sidecars.

A reexecução do checker central contra os bytes atuais produziu
`90 PASS / 7 FAIL`: os sete failures correspondem ao DAG e aos seis artefatos
de `A_C` ainda comparados aos hashes anteriores. O output central versionado
continua registrando `97 PASS / 0 FAIL`, logo já não reproduz a execução
corrente.

O defeito é administrativo, mas pode direcionar uma decisão terminal ao
snapshot errado. O reparo seguro é repinar os dois sidecars às fontes,
pareceres e adjudicação fortalecidos; atualizar checker e output; formar novo
manifesto terminal. Nenhum blob matemático deve ser alterado por esse reparo.

### `AC-STRENGTH-R2-MIN-1` — `PARTIAL`

Contrato, resultados e `AC-MSB-019` afirmam universalmente que `A_C` não
identifica uma lei conjunta e que qualquer acoplamento acrescentaria convenção.
Se uma marginal é `delta_x`, porém, toda conjunta com marginais `delta_x` e
`mu_U` é `delta_x times mu_U`; o par de marginais determina matematicamente um
único acoplamento.

A extensão substantiva da crítica é refutada: a interface mantém
`joint_probability_between_rules: not_defined`; o game form não introduz choque
comum nem dispositivo de correlação; eventual unicidade matemática não dá
interpretação causal ou substantiva a realizações pareadas; e nenhuma operação
de bem-estar foi autorizada.

O reparo seguro é dizer que, em geral, as marginais não identificam um
acoplamento único e que eventual unicidade degenerada não autoriza
interpretações substantivas de pares de realizações. Deve-se preservar
`not_defined` e não introduzir acoplamento no modelo.

### `AC-STRENGTH-R2-MIN-2` — `CONFIRMED`

A autorização adicional está corretamente preservada no manifesto e no campo
superior `strengthening_authorization` do DAG, mas:

- contrato e interface pinam somente a autorização inicial `ea4e2e9b...`;
- não há nó da autorização adicional no DAG;
- `A_C_contract` depende apenas de `A_C_authorization` e `A_C_candidate` apenas
  de `A_C_contract`;
- `AC-MSB-024` atribui a paridade à autorização inicial, não ao documento
  adicional `67e5b948...`.

O reparo seguro é pinar a autorização adicional no contrato e na interface;
representá-la como nó e dependência efetiva no DAG; corrigir as autoridades dos
claims novos; atualizar hashes, verificador, output e manifesto sem mudar as
provas.

## 5. Stress-test matemático

A adjudicação voltou aos resultados e às fontes congeladas:

- `A_M` fornece `V_M^theta>=Z_E`, com `Z_E=1-k*beta/m`;
- `A_U` fornece `V_U^theta<=z_H=1-beta+beta^2*o_1`;
- `Z_E-z_H=beta*(c/m-beta*o_1)=g_T5`;
- nas células baixas,
  `Z_E-z_L=beta*(c/m-beta*o_0)=g_0`;
- o endpoint `nu=0` está corretamente limitado à conclusão ex ante;
- o exemplo `N=5` reproduz `Z_E=.55`, `z_L=.505` e `d_H=.486`, embora
  `beta*o_1=.54>.5`;
- a paridade segue de `m=N-1`, `k=floor(N/2)` e `c=m-k`;
- `D_E` é imagem afim do vetor ligado `D_01`.

O verificador reproduziu `1197 PASS / 0 FAIL` e o SHA-256 versionado
`f396c6ba14b991571b0a0ca84eac125a91a8706228a76d13b4555152f0436e1c`.
Isso é evidência mecânica, não prova formal. Nenhum finding matemático adicional
foi encontrado.

## 6. Limites

Não há correção `unsafe`, `needs_design` ou `owner_decision`. Os reparos não
autorizam introduzir lei conjunta, selecionar equilíbrio, modificar T1–T5,
`g_T5`, `g_0`, o exemplo, a paridade ou os pacotes congelados de `A_M`/`A_U`.

`A_C` continua `pending/unfrozen`. `A_R`, manuscrito, tag, merge e push seguem
sem autorização.

## 7. Veredito

ADJUDICATION_VERDICT: READY_FOR_IMPLEMENTATION  
COUNTS: TOTAL 3 | CONFIRMED 2 | PARTIAL 1 | REFUTED 0 | UNRESOLVED 0 | HELD_DECISIONS 0
