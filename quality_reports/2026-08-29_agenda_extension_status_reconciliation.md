# Reconciliação administrativa do status da extensão de agenda

**Data:** 2026-08-29

**Escopo autorizado:** corrigir a confusão criada por registros antigos de
acompanhamento

**Natureza:** lifecycle e documentação; nenhuma nova derivação, prova ou revisão
matemática

## 1. Resultado

Foi criada uma fonte atual única para o lifecycle da extensão de agenda:

- leitura humana: `model_redesign/agenda_extension_STATUS.md`;
- leitura por máquina: `model_redesign/agenda_extension_status_current.json`.

Ela registra `A_M` como `pass/frozen` nos hashes do fechamento terminal. Registra
`A_U`, `AC` e `AR` como `pending/unfrozen`, todos sem autorização. Também fixa
explicitamente que não há autorização para manuscrito, tag, merge ou push.

## 2. O conflito que foi resolvido

Dois DAGs antigos ainda registram `A_M=pending`:

| Fonte histórica | SHA-256 preservado | Por que não é a fonte atual |
|---|---|---|
| `model_redesign/agenda_extension_game_dag.json` | `9644151b8441ed5d09d1a870c3a2f5b94437c2376c7af6fb419c17297ebd5cd6` | Antecede M/S/B e aponta para o ledger antigo. |
| `model_redesign/agenda_extension_game_dag_simplified.json` | `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0` | É o DAG do candidato simplificado pré-M/S/B. |

O verificador histórico
`scripts/verify_agenda_extension_A_M_mechanical.R` também exige que o DAG antigo
continue dizendo `pending`; seu SHA-256 foi preservado em
`1512fe8b31b65d44ef58fcbba2c58e345e3631f767aac9a0f363f897c7d28747`.

Esses bytes não foram atualizados. Alterá-los apagaria a diferença entre o
candidato antigo e o pacote M/S/B posterior. A reconciliação, portanto, aposenta
somente sua função de **autoridade atual**, preservando sua função de
**proveniência histórica**.

O mesmo princípio vale para frases de revisão pendente dentro do ledger M/S/B:
elas pertencem aos bytes submetidos aos pareceristas. O fechamento posterior é
registrado externamente, sem reescrever o objeto revisado.

## 3. Autoridade atual e bytes preservados

O sidecar aponta para o registro terminal
`quality_reports/2026-08-29_A_M_msb_two_layer_terminal_approval_and_freeze.md`
(SHA-256
`ca109199060f3aa775f6e2f18ef46fd9cefaff522cc3f7fdeeabfe9d5f412158`)
e para o manifesto final
`quality_reports/2026-08-29_A_M_msb_two_layer_final_gate_manifest.sha256`
(SHA-256
`8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e`).

A intervenção não mudou os resultados, o ledger, o verificador M/S/B, seu
output, os dois pareceres, a adjudicação nem a dependência congelada `C_M`.

## 4. Documentação operacional

Foram adicionados avisos no topo das seções de status de `AGENTS.md` e
`CLAUDE.md`, além de um banner em `model_redesign/README.md`. Agentes futuros são
orientados a consultar o novo sidecar antes de interpretar qualquer arquivo da
extensão de agenda.

## 5. Checagem mecânica

O novo script `scripts/verify_agenda_extension_status_current.R` verifica:

- os hashes do fechamento, do candidato, das provas, dos pareceres e da
  adjudicação;
- os quatro estados atuais e seus limites de autorização;
- a preservação byte a byte dos DAGs e do verificador históricos;
- a permanência deliberada de `A_M=pending` dentro dos DAGs históricos; e
- a ausência de autorização downstream.

Resultado final versionado em
`quality_reports/verification_outputs/2026-08-29_agenda_extension_status_current_verifier_output.txt`:

```text
SUMMARY | 40 PASS | 0 FAIL
```

Durante o desenvolvimento, a primeira execução mostrou `25 PASS | 15 FAIL`
porque o parser lia a primeira linha emitida por `shasum`; no ambiente local,
avisos de locale apareciam antes da linha do hash. A função foi corrigida para
localizar a linha hexadecimal independentemente de sua posição. A repetição
produziu `40 PASS | 0 FAIL`. Isso foi um defeito do novo verificador, não uma
mudança ou falha dos artefatos congelados.

Esta checagem é mecânica e foi executada pelo implementador. Ela não pretende
ser uma nova revisão matemática independente; a validade formal de `A_M`
continua apoiada nos dois pareceres independentes e na adjudicação já congelados.

## 6. Fronteira mantida

Nenhum trabalho foi executado em `A_U`, `AC`, `AR`, N1–N7 ou
`formal_model_v6.Rmd`. Nenhuma tag, merge ou push foi criado. Um próximo passo
matemático continua exigindo autorização autoral separada.
