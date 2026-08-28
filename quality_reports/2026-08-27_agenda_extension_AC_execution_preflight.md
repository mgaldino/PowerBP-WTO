# Execução e preflight — `AC` da extensão de agenda

**Data:** 2026-08-27

**Escopo:** importação byte-idêntica de `A_M` e `A_U` e integração matemática
privada em `AC`

**Status:** `CANDIDATO AC PRODUZIDO — DAG PENDING — DUAS REVISÕES MATEMÁTICAS FINAIS PENDENTES`

## 1. Preflight inicial

- worktree: nova, limpa e em detached HEAD;
- HEAD inicial confirmado:
  `8b5ea05b355c870116d0b70d7b5fbbea81b44176`;
- `CLAUDE.md`, `AGENTS.md` e
  `quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md`
  foram lidos integralmente antes da importação;
- também foram lidos os fechamentos do Gate 0 e do Goal 1, a auditoria e a
  revisão independente do Goal 1 e
  `model_redesign/agenda_extension_goal1_external_interfaces.json`;
- as skills `formal-game-theory-polisci` e `solve-dynamic-games`, inclusive o
  template de dependências desta última, foram lidas integralmente;
- não foi aberto revisor nem agente independente nesta sessão, conforme a
  autorização.

## 2. Verificação e importação dos commits autorizados

Os dois commits existem, têm o mesmo pai exato do preflight e alteram artefatos
separados:

| Fonte | Commit autorizado | Pai | Arquivos próprios |
|---|---|---|---:|
| `A_M` | `ad6cf6fd40e003b83935580acf4c3c19fe2e7fa4` | `8b5ea05b355c870116d0b70d7b5fbbea81b44176` | 5 |
| `A_U` | `08d11a4b5589beef62631c139540e9e0a5710b1e` | `8b5ea05b355c870116d0b70d7b5fbbea81b44176` | 5 |

A branch local `codex/agenda-extension-ac` foi criada. Os commits foram
importados na ordem autorizada, sem conflito:

1. `A_M` gerou o commit local
   `a5ac515186b09440b83502b2f12aded78091652b`;
2. `A_U` gerou o commit local
   `8353fdb3a9061f95d9f2cd71566e543f4a889c9a`.

Não houve push, merge ou tag.

## 3. Hashes importados, pós-importação

| Nó | Artefato | SHA-256 observado | SHA-256 autorizado | Resultado |
|---|---|---|---|---|
| `A_M` | candidato | `c45b4420b0c1a4fe7dac2187ee90e79da5d47365eb32ebe2759aaa746ebcb976` | mesmo | `MATCH` |
| `A_M` | derivação | `e4bade93df0e4c42037e1e85ac69f9163a0917370d18e12c674d3a54c1d46f72` | mesmo | `MATCH` |
| `A_M` | ledger | `9934db4a5b677bf6ac95683f495f94dee0fbd390a5574892d5c8c907294c923b` | mesmo | `MATCH` |
| `A_M` | checker | `1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747` | mesmo | `MATCH` |
| `A_U` | candidato | `d4bedcc1d579a38ca2a095ab2f1ce0256d1b4ce0af039076c2a954eeee3e47a7` | mesmo | `MATCH` |
| `A_U` | derivação | `4100baa6b3fa00ccbc5ef1c9b8d656e14d844fdc6a36026fe61eb855b378e8e5` | mesmo | `MATCH` |
| `A_U` | ledger | `fb8447d5aff10efdc600ad4753066636f86e994985d802684b19ddde2139d3dc` | mesmo | `MATCH` |
| `A_U` | checker | `c5032f7baf8748a0bff2638c1a62d8ab609a8a964503975661dcf9c5d1270e60` | mesmo | `MATCH` |

Os registros de execução importados permanecem em:

- `quality_reports/2026-08-27_agenda_extension_A_M_execution_preflight.md`,
  SHA-256 `c549b806930f2e526e9ba8f3c5aaaddab1d1b14d059e3dbc0f5587d6e6c9dfe0`;
- `quality_reports/2026-08-27_agenda_extension_A_U_execution_preflight.md`,
  SHA-256 `5dcae15ef3f32fb433e5f71e9372a7c722130ee1df6bfa1e6e38412e5f8be5e7`.

## 4. Resultado matemático integrado

`AC` usa a orientação `Delta=U-M`. A regra necessária e suficiente de
compatibilidade é o produto fibrado dos membros completos sobre a mesma tupla
de primitivas `d`: `b_M in E_M(d)` e `b_U` no family record de `A_U` cuja célula
contém `d`, com os dois binders intactos e os hashes exatos das fontes.

O objeto primário é a relação conjunta de membros, payoffs por tipo, contraste
ex ante e pares ordenados de leis de outcomes. Imagens e envelopes são derivados
somente depois. Não há produto de imagens marginais, acoplamento probabilístico
cross-world, seleção de equilíbrio ou ordenação de outcomes não autorizada.

As sete células de `AC` contêm:

- quatro famílias `exists`, correspondentes às quatro células existentes de
  `A_U`, intersectadas com `D_M_plus`;
- uma célula em que apenas `A_M` existe;
- uma célula em que apenas `A_U` existe;
- uma célula em que ambas as regras são `none`.

Uma fibra ausente não recebe payoff-sentinela e não apaga a regra sobrevivente.

## 5. Artefatos de `AC` e hashes

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_AC_candidate_simplified.json` | `b53f43418c79e83d01e58f5754d36cbb556546b2b5df6e9bd545434af61aaa96` |
| `model_redesign/agenda_extension_AC_derivation_simplified.md` | `35cd38c2936709b1a1bc9bb53b493d59357480c65619f73f6d0bceee6da1ad21` |
| `model_redesign/agenda_extension_AC_claim_ledger_simplified.tsv` | `949232b4735d4459cdc186f336aece05b52e2a8c6eaf795e9296874919d91430` |
| `scripts/verify_agenda_extension_AC_mechanical.R` | `f18b387ea48aa2a4f31757053cc08f591ac508105cb40f00641dae953f718f96` |

O hash deste próprio registro é calculado externamente para evitar
autorreferência.

## 6. Checkers específicos

### `AC`

```text
Rscript --vanilla scripts/verify_agenda_extension_AC_mechanical.R
SUMMARY | 18 PASS | 0 FAIL
```

O checker limita-se a hashes, JSON/TSV, IDs, schemas, binders, células,
ausência de sentinela, aplicação zero adicional de `beta`, identidades e casos
finitos de fronteira. Não prova PBE, completude, mensurabilidade, extremos de
`A_M`, invariância em famílias contínuas nem ranking institucional.

### `A_U`

```text
Rscript --vanilla scripts/verify_agenda_extension_A_U_mechanical.R
SUMMARY | 14 PASS | 0 FAIL
```

### `A_M`

No snapshot isolado imediatamente posterior à importação de `A_M`, commit local
`a5ac515186b09440b83502b2f12aded78091652b`:

```text
SUMMARY | 59 PASS | 0 FAIL
```

No checkout combinado, depois da importação autorizada de `A_U` e do
preenchimento de `AC`:

```text
SUMMARY | 58 PASS | 1 FAIL
```

A única falha é a guarda `all out-of-scope simplified ledgers remain
byte-identical`. Ela foi escrita para a sessão isolada de `A_M` e exige que os
ledgers de `A_U` e `AC` ainda tenham o hash vazio do Gate 0. A falha é a
consequência esperada da sequência autorizada, não falha de identidade, schema,
hash-fonte, quota, fronteira ou `beta`. O checker importado não foi modificado.

## 7. Runners históricos do Goal 1

O verificador e o manifesto históricos foram preservados. Como previsto, eles
fixam os ledgers vazios do Gate 0:

```text
Rscript --vanilla scripts/verify_agenda_extension_goal1.R
SUMMARY | 28 PASS | 3 FAIL
```

As três falhas são exclusivamente:

- `gate0_hash_A_M_empty_ledger`;
- `gate0_hash_A_U_empty_ledger`;
- `gate0_hash_AC_empty_ledger`.

```text
Rscript --vanilla scripts/test_agenda_extension_goal1.R
SUMMARY | 38 PASS | 1 FAIL
```

A única falha é `repository_positive_all_checks`, que apenas agrega as três
divergências de ledger acima. Todos os outros testes positivos e negativos
passam. Nenhum verificador ou manifesto histórico foi alterado para ocultar a
mudança legítima de ciclo de vida.

## 8. Preservação de escopo

| Controle protegido | SHA-256 final observado |
|---|---|
| `formal_model_v6.Rmd` | `00bbaa3a5768348fede3f6584bab915b7c1dbf1fd1cccbf723bb64a90188e4a6` |
| `formal_model_v6.pdf` | `3602b0753a8a61ddcb2450f7181ba2f8fc53b9f73ad16cdfbb46e337019182be` |
| `formal_model_v5.Rmd` | `1b0e420155b58e4b069f04b210736b3fab60cf060f87a6ca30ce5019676620af` |
| DAG simplificado | `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0` |
| ledger opcional de `AR` | `3bd87820cd88b1ffe25f562c4e7952d91a028813a610c8ab728389eed1e6e580` |
| manifesto do Goal 1 | `588e7da2ec7df2f208ccaf082d3bc30834ea12625484b04b25d3eae7fce20a86` |
| `C_M` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| `C_U` | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| DAG `essential-input` | `36155405a635bf6842c09dcde127907ec1f6fe61bb86ec06d932d7e472abf9ab` |

O diff contra o HEAD inicial não contém `formal_model_v6.Rmd`,
`formal_model_v6.pdf`, `formal_model_v5.Rmd`, `RIO submission files/`, artefato
de `essential-input`, DAG ou ledger de `AR`. Nenhum arquivo protegido foi
editado. Os quatro nós permanecem `pending`; `AC` não foi marcado como `pass`.

Avisos de locale do macOS ocorreram na inicialização de R e `shasum`, sem mudar
parsing, hashes, resultados ou códigos de saída substantivos.

## 9. Próxima fronteira não aberta

O pacote privado ainda depende de duas revisões matemáticas finais independentes
sobre os hashes finais. Esta sessão não solicita revisores, não abre `AR`, não
edita manuscrito, não faz push e não faz merge para outra branch.
