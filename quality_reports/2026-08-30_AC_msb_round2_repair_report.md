# Reparo adjudicado e candidato de rodada 2 — `A_C` M/S/B

**Data:** 2026-08-30  
**Status:** `ROUND-2 CANDIDATE / UNREVIEWED / UNFROZEN`  
**Finding de origem:** `AC-R1-MIN-1`  
**Commit do reparo:** `7151b368f1e9d43de30b437ab2386c82655aa789`

## Escopo do reparo

A adjudicação em
`quality_reports/adjudication/A_C_msb/6ba078efb05f/adjudication_round1.md`
confirmou um único defeito menor: oito campos `source_record_ids` do claim ledger
apontavam para claims-fonte semanticamente errados ou incompletos.

O commit do reparo alterou somente esses oito campos. Permaneceram byte-idênticos:

- contrato;
- resultados e T1–T5;
- interface;
- verificador; e
- output mecânico.

O DAG foi atualizado apenas para substituir o hash antigo do ledger pelo novo e
registrar o lifecycle do finding. Nenhuma aresta, dependência matemática, fórmula
ou autorização downstream mudou.

## Referências corrigidas

| Claim | Disposição implementada |
|---|---|
| `AC-MSB-003` | regra direta de mesma fibra em `AUX-MSB-031` |
| `AC-MSB-006` | resumos por tipo de `A_M` e tipo-antes-do-prior `AUX-MSB-020` |
| `AC-MSB-007` | valores-fonte e transporte único de `A_U` |
| `AC-MSB-010` | células, exaustão, endpoints e regra diagonal completas de `A_U` |
| `AC-MSB-011/012` | existência/células completas das duas fontes |
| `AC-MSB-017/018` | lower bound `AMX-010` e partição completa que implica o upper bound de `A_U` |

## Verificação

O verificador foi reexecutado após o reparo:

```text
MECHANICAL RESULT: PASS | 941 PASS | 0 FAIL
```

O output permaneceu byte-idêntico, como esperado para uma correção apenas de
metadados de rastreabilidade. O ledger continua com 21 claims, 16 colunas e IDs
únicos. O checker do DAG retornou `VALID`.

## Gate seguinte

O manifesto de rodada 2 deve receber duas leituras independentes read-only. Elas
devem confirmar simultaneamente:

1. que o diff substantivo é apenas o reparo adjudicado;
2. que os novos IDs existem e sustentam semanticamente cada claim;
3. que o manifesto e o DAG repinam o novo hash; e
4. que nenhum resultado matemático ou limite de autorização mudou.

Mesmo dois `PASS` não congelam `A_C`: adjudicação final e aprovação autoral
terminal continuam separadas. `A_R`, manuscrito, tag, merge e push permanecem
não autorizados.
