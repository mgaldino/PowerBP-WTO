# Adjudicação da rodada 2 — `A_M` sob M/S/B

**Data:** 2026-08-29  
**Pareceres:** formal `FAIL 0/1/3`; contrato `FAIL 0/1/1`.

| Finding | Classificação | Reparo aplicado |
|---|---|---|
| domínio permitia `o_1=1` | confirmado, técnico e único | restaurar `0<o_0<o_1<1` e `o_1<=y_bar<=1` em resultado/ledger/relatório; teste negativo em R |
| `c_S` descrito como constante no rótulo | confirmado, redação matemática | definir mapas Borel conjuntamente em `(mu,chi)` |
| região alta usava `o_0>T` | confirmado, fronteira | escrever `o_0>=T>1/m` |
| relatório fundia M/B | confirmado, redação | M exclui o seletor literal; B exclui reconstrução via crenças |

Todos os reparos são forçados pelos documentos existentes. Nenhum finding
exige protocolo autoral novo. Os bytes da rodada 2 ficam cobertos pelos dois
`FAIL`; a rodada 3 precisa revisar novos hashes.

