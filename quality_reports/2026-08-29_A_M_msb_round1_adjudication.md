# Adjudicação da rodada 1 — `A_M` sob M/S/B

**Data:** 2026-08-29  
**Pareceres:** revisão formal (`FAIL 0/3/3`) e revisão de contrato
(`FAIL 1/1/1`).  
**Regra:** somente reparos forçados pelo contrato; nenhuma seleção ou hipótese
econômica nova.

## Decisões

| Finding consolidado | Classificação | Decisão |
|---|---|---|
| AMX-016 não cobre endpoints | confirmado, substantivo porém reparo único | adicionar `R_boundary` com posterior constante, medidas Borel no argmax e assinatura completa |
| `chi`/kernels sem codomínio mensurável | confirmado, substantivo porém reparo único | usar literalmente o representante uniforme da Cláusula S: união Borel `E/S/P` mais a mistura residual `E/P` |
| `y_bar` omitido | confirmado, técnico | restaurar `o_1<=y_bar<=1` e provar invariância das fórmulas |
| prova diagonal incompleta de AMX-010 | confirmado, técnico | substituir pela proposta robusta que paga `beta/m` a `k` fracos |
| `s_D=nu_off=1` | confirmado, redação | separar Bayes on-path de B off-path |
| M e B como violações independentes do seletor literal | confirmado, redação | M exclui o seletor; B exclui a reconstrução via crenças |
| status `rejected` em teoremas negativos verdadeiros | confirmado, schema | mudar para `proved` e manter a natureza negativa no texto |
| hash do manifesto `97529d...` no parecer contratual | erro clerical do parecer | identidade confirmada por `shasum -c` e pelo parecer formal: `407114...` |

Nenhum finding exige `pending protocol decision`. O codomínio uniforme não é
uma seleção inventada pelo implementador: é o representante literal ordenado
pela Cláusula S e pelo prompt autoral.

## Efeito

Os bytes da rodada 1 ficam historicamente cobertos pelos dois `FAIL`. Depois
dos reparos, todos os hashes candidatos e o manifesto devem ser regenerados, e
os dois revisores devem emitir nova decisão read-only sobre a rodada 2.

