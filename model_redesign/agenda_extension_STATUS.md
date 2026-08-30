# Status atual da extensão de agenda

**Data de referência:** 2026-08-30

**Natureza:** registro administrativo; não contém nova matemática

**Fonte estruturada:** `model_redesign/agenda_extension_status_current.json`

## Resposta curta

`A_M` e `A_U` sob M/S/B estão **`pass/frozen`** nos respectivos bytes exatos
aprovados. `A_C` foi fortalecido, reparado e recebeu dois pareceres independentes
`PASS 0/0/0`, mas segue **`pending/unfrozen`** até a aprovação autoral terminal.
A adjudicação confirmou um finding minor exclusivamente administrativo: estes
sidecars ainda apontavam para o candidato anterior. O reparo está implementado
abaixo sem alterar nenhum dos oito artefatos revisados. `A_R` continua não
autorizado. Não há autorização para migrar resultados ao manuscrito, criar tag,
fazer merge ou push.

| Nó | Status atual | Pode ser executado ou consumido agora? |
|---|---|---|
| `A_M` | `pass/frozen` | Apenas os bytes congelados podem ser citados; o status não autoriza trabalho downstream. |
| `A_U` | `pass/frozen`; revisões, adjudicação e aprovação autoral terminal concluídas | Apenas os bytes congelados podem ser citados; o status não inicia `AC`. |
| `AC` | candidato fortalecido `pending/unfrozen`; duas revisões `PASS 0/0/0`; matemática sem defeito confirmado; finding administrativo reparado | Está pronto para decisão autoral terminal nos 13 hashes do manifesto; ainda não é resultado congelado. |
| `AR` | `pending/unfrozen` | Não. Exige GO autoral separado após o pacote privado revisado. |

## Candidato atual de `A_C`

O autor autorizou o início com “A_c pode iniciar, autorizado.” e, depois da
consulta externa, autorizou também todos os resultados fortes com “do it.”. Os
dois registros exatos são:

- `quality_reports/plans/2026-08-30_autorizacao_inicio_A_C_msb.md`, SHA-256
  `ea4e2e9b9e1296aecd64760f058f0097ff4281f6a9b301373feeea2591092f95`;
- `quality_reports/plans/2026-08-30_autorizacao_fortalecimento_A_C_pos_consulta.md`,
  SHA-256
  `131e7485879ffbf1d399f91c2b838fb05e8d64644ae2c393692ffce1888fedec`.

O candidato reparado foi fixado no commit
`5410b06b1cb036e53ba2d34830e21425e65f89a0`. Seu manifesto corrente é
`quality_reports/2026-08-30_AC_msb_strengthened_round2_candidate_manifest.sha256`,
SHA-256
`ec5bbebe0490eb8a46ee5e0de1565cf52ae1838721a870df21cdc4a629058339`,
com 8/8 entradas válidas.

O núcleo preserva a arquitetura em duas camadas: primeiro forma pares de binders
completos de `A_M` e `A_U` na mesma economia e fibra `(rho,nu_off)`; somente
depois calcula resumos econômicos. Por isso, os payoffs dos dois tipos continuam
ligados pelo mesmo binder, e o contraste ex ante é a imagem afim dessa dupla,
não uma recombinação independente de marginais.

Além da comparação exata, o candidato agora registra:

```text
beta*o_1<c/m
  => V_M^theta-V_U^theta >= g_T5
  para theta=0,1 e ex ante,

g_T5=beta*(c/m-beta*o_1)>0.
```

Nas células baixas, há a condição local menos restritiva
`beta*o_0<c/m`, com margem `g_0=beta*(c/m-beta*o_0)`. No endpoint `nu=0`,
essa condição sozinha sustenta apenas a conclusão ex ante. Um exemplo com
`N=5` prova que T5 é suficiente, mas não necessária. A fração `c/m` é `1/2`
quando `N` é ímpar e `(N-2)/(2*(N-1))` quando `N` é par.

O texto sobre outcomes também foi corrigido. `A_C` declara somente o par de
leis marginais e não introduz variável conjunta ou regra geral de acoplamento.
Em geral, as marginais não determinam um acoplamento único; em casos degenerados
podem determinar, mas isso não autoriza interpretar realizações contrafactuais
como pareadas pelo jogo nem executar operações cross-world não declaradas.

O verificador retornou `1200 PASS / 0 FAIL`. Dois pareceristas independentes
cobriram os mesmos oito hashes:

- `quality_reports/2026-08-30_AC_msb_strengthened_round2_formal_review_1.md`:
  `PASS 0/0/0`, SHA-256
  `acf971e9f460f7404a4c681ca1a7a51880c5fbca20870584dc8525e3e21ce4c4`;
- `quality_reports/2026-08-30_AC_msb_strengthened_round2_formal_review_2.md`:
  `PASS 0/0/0`, SHA-256
  `99a228814a61541015622e85949f4e634a69659f0e7428c4dfa2a95cc12ebcde`.

A adjudicação independente, em
`quality_reports/adjudication/A_C_msb_strengthened/ec5bbebe0490/adjudication_round2.md`,
confirmou a matemática e os reparos substantivos. Seu único finding foi
`ADJ-AC-STRENGTH-R2-MIN-1`: os sidecars ainda pinavam o candidato anterior. O
finding não atingiu nenhum resultado; este trecho e o JSON estruturado são seu
reparo administrativo determinado.

O novo manifesto terminal
`quality_reports/2026-08-30_AC_msb_strengthened_terminal_gate_candidate_manifest.sha256`,
SHA-256
`17279db1f853e5bc0bb3b7b1ef2411053e1beb6929e56c15b766e0ee847ef5d2`,
fixa 13/13 entradas: os oito artefatos do candidato, seu manifesto, os dois
pareceres e os dois registros da adjudicação. Esse é o objeto exato pronto para
decisão autoral. Ele permanece `pending/unfrozen` até essa decisão.

## Status próprio de `A_U`

A reconstrução cega foi fixada no commit
`c193f3bdd99c6b127e76e595d851051fa005e247`; o candidato posteriormente
adjudicado, em `b59ce1bf5b5ee7b57707684de92c38d4fa325b30`. A decisão específica de
duas camadas está em
`quality_reports/plans/2026-08-30_decisao_assinatura_duas_camadas_A_U.md`; sua
implementação substantiva, no commit
`b56085c436eb629c335764eb982d174e5cc2d392`. Depois do reparo estritamente
administrativo do DAG, o snapshot final revisado ficou no commit
`8e86bab8ea10f75e6fd5aeeb230a9e260479483a`. O manifesto da rodada 2 é
`quality_reports/2026-08-30_A_U_msb_two_layer_round2_candidate_manifest.sha256`
(SHA-256
`1c4720e99a1d72ec1533578a141e476679650eded2a333ac3a95f87e7d441b2b`).
O verificador retornou `1110 PASS / 0 FAIL`; essa evidência é mecânica e não
substitui as provas.

Os pareceres de 2026-08-29 cobriram apenas os bytes anteriores à decisão:

- parecer 1: `PASS 0/0/0`, SHA-256
  `36e1e092ff2135e5610b2d942a81b7955ed899702ae266986ca2c712659f380d`;
- parecer 2: `FAIL 0/1/0`, SHA-256
  `79a335f6557b4274786256011cc850fbf8dd81e606b43ef7f2d04d951aa4ea57`.

A adjudicação histórica em
`quality_reports/adjudication/A_U_msb/b59ce1bf5b5/adjudication_round1.md`
confirmou `R2-I-1` e encerrou aquela rodada como `BLOCKED`. O finding não atinge
thresholds, payoffs, Bayes, famílias de PBE, endpoints ou a exaustão no nível
de assessments. Ele atinge apenas a escolha da relação de equivalência e o
formato da interface downstream: a clarificação geral colapsa misturas sobre
relabelings, enquanto a arquitetura que separa camada formal exata e resumo
econômico havia sido aprovada posteriormente apenas para `A_M`.

Essa lacuna normativa foi fechada pela instrução autoral de 2026-08-30. O novo
candidato define `Sig_ex_U` para identidade formal por órbita diagonal e
`Sum_econ_U` para equivalência econômica anônima, preservando o binder completo
para operações sensíveis a funções off-path.

Dois pareceristas independentes cobriram exatamente o manifesto da rodada 2:

- parecer 1: `PASS 0/0/0`, SHA-256
  `6432708aabe1694603c99eb8df4e8b1ecda196ef8df8244128fd1b8f20c5be75`;
- parecer 2: `PASS 0/0/0`, SHA-256
  `3ae8bcf4e858f10784a25d548526a88f8d66469428c7c7ab0195704659458b84`.

A adjudicação independente final, em
`quality_reports/adjudication/A_U_msb_two_layer/1c4720e99a1d/adjudication_round2.md`,
deu `NO_CONFIRMED_DEFECTS`, com zero findings confirmados, parciais ou não
resolvidos. Ela também confirmou que os seis artefatos matemáticos são byte a
byte idênticos aos da rodada anterior e que o reparo alterou apenas o DAG.

O autor aprovou terminalmente `A_U` em 2026-08-30. O registro
`quality_reports/2026-08-30_A_U_msb_two_layer_terminal_approval_and_freeze.md`
(SHA-256
`e330a1956a7c071dc72c2556eda68cf32d2b81473d700100bbf7e1f6e195111b`)
e o manifesto final
`quality_reports/2026-08-30_A_U_msb_two_layer_final_gate_manifest.sha256`
(SHA-256
`b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180`)
fixam os bytes aprovados. A pergunta subsequente do autor sobre `AC` não o havia
autorizado naquele momento; a autorização separada posterior está registrada na
seção anterior. `A_C` agora é um candidato `pending/unfrozen`, não um resultado
terminalmente aprovado.

Os pareceres históricos de 2026-08-29 permanecem como proveniência da lacuna
que motivou a arquitetura em duas camadas; não governam os bytes agora
congelados.

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
