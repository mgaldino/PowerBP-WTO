# Reparo técnico adjudicado — DAG de `A_U` em duas camadas

**Data:** 2026-08-30

**Finding:** `R2-M-1`

**Adjudicação:** `CONFIRMED`, `minor`, reparo `safe`,
`READY_FOR_IMPLEMENTATION`

**Commit do reparo:** `2e5bc83ca23772cca4628708d33033b8c21bd763`

## Escopo

Somente `model_redesign/agenda_extension_A_U_msb_game_dag.json` mudou. Não
foram alterados contrato, resultados, interface, ledger, verificador R, output
mecânico, decisão autoral ou fórmula estratégica.

## Mudanças

1. `artifact_path` passou a ser relativo ao diretório do próprio DAG;
2. cada nó iniciado passou a congelar os hashes de todas e somente suas
   dependências diretas;
3. os dois hashes transitivos não declarados foram removidos do candidato;
4. a ordem e as dependências substantivas permaneceram as mesmas.

## Verificação

```text
python3 /Users/manoelgaldino/.codex/skills/solve-dynamic-games/scripts/check_game_dag.py \
  model_redesign/agenda_extension_A_U_msb_game_dag.json \
  --require-execution-order
```

Resultado:

```text
VALID
Dependency batches: [C_U_frozen] -> [A_U_blind_candidate_historical] -> [A_U_two_layer_author_decision] -> [A_U_two_layer_contract] -> [A_U_two_layer_candidate] -> [AC]
Ready: AC
```

O modo JSON retornou `"valid": true` e `"errors": []`. `Ready: AC` é apenas
prontidão topológica; `AC` continua explicitamente não autorizado.

O novo SHA-256 do DAG é
`1baa17353f07452133f20d20bc16a43ccd91cfb7c6f8113cf78324a20ad08120`.

O candidato permanece `pending/unfrozen`. O novo manifesto deve ser submetido
aos dois pareceristas antes de qualquer gate terminal.
