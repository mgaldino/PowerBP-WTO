# Relatório de implementação de `A_C` sob M/S/B

**Data:** 2026-08-30  
**Status:** `IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Commit substantivo:** `efeee02`

## 1. Escopo autorizado

O autor autorizou o início de `A_C` com a frase literal “A_c pode iniciar,
autorizado.” A autorização foi fixada em
`quality_reports/plans/2026-08-30_autorizacao_inicio_A_C_msb.md`, SHA-256
`ea4e2e9b9e1296aecd64760f058f0097ff4281f6a9b301373feeea2591092f95`.

O trabalho consome `A_M` e `A_U` somente nos respectivos manifestos finais
congelados. Não reabre nenhum dos dois jogos. `A_R`, manuscrito, tag, merge e
push permanecem fora do escopo.

## 2. O que foi implementado

1. Um domínio comum que inclui `y_bar`, omitido na comparação histórica.
2. A fibra diagonal comum `eta=(rho,nu_off)`, com
   `nu_off=b_rho(nu)` no interior e `eta=(*,nu)` nos endpoints.
3. O produto primário de binders completos
   `J_AC^bind=B_M times_(d,eta) B_U`, antes de qualquer resumo ou envelope.
4. Contrastes por tipo na orientação `U-M`, seguidos do contraste ex ante, sem
   novo fator de desconto.
5. Uma prova específica de que payoffs, acordo/atraso e leis anônimas declaradas
   fatoram mensuravelmente pelo par ordenado de resumos econômicos congelados.
6. A partição explícita das fibras de `A_U` e a regra de existência de `A_C`:
   ambas as fontes precisam ser não vazias na mesma fibra.
7. Conjuntos exatos de sinais e, somente depois, os envelopes escalares.
8. Um certificado suficiente uniforme de vantagem da maioria para `H`:

```text
beta*o_1<c/m  =>  V_M^theta>V_U^theta para theta=0,1
```

   Na igualdade, a dominância é fraca. O resultado é suficiente, não necessário.

## 3. Correções em relação à tentativa histórica

- `y_bar` permanece no tipo do problema;
- as duas regras usam a mesma dupla `(rho,nu_off)`;
- o payoff contrafactual do tipo de probabilidade zero continua tipado por tipo,
  em vez de ser substituído por um payoff interim;
- as leis econômicas vivem em um codomínio mensurável explícito;
- vetores de payoff dos dois tipos permanecem ligados ao mesmo binder;
- células vazias recebem `none`, nunca um payoff-sentinela.

Os arquivos `agenda_extension_AC_*_simplified` não foram alterados e continuam
apenas como proveniência diagnóstica.

## 4. Evidência mecânica

O verificador versionado
`scripts/verify_agenda_extension_AC_msb.R` retornou:

```text
MECHANICAL RESULT: PASS | 941 PASS | 0 FAIL
```

Ele conferiu hashes e manifestos congelados, schemas JSON/TSV, aritmética da
fibra diagonal, partição das células de `A_U`, identidade tipo-antes-do-prior,
zero aplicações novas de `beta`, envelopes finitos e a identidade do
certificado uniforme.

Ele não prova completude das correspondências de PBE, fatorização Borel
abstrata, lifting setwise geral, atingimento de extremos ou qualquer ranking de
bem-estar. Esses pontos permanecem para leitura formal independente.

## 5. Artefatos substantivos

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_AC_msb_contract.md` | `d09958a447cc440586c000f92c10982ae1f786a94845c602d714c6ff284a8b14` |
| `model_redesign/agenda_extension_AC_msb_results.md` | `479c0089a1ed6a08dc9ffd8061933d248505c9b753a036f812f5b163586d8e77` |
| `model_redesign/agenda_extension_AC_msb_interface.json` | `103b564bd15af69dbb45c6b57cd16a0228d3c60a24b758ad779f6b75e7fe2cdf` |
| `model_redesign/agenda_extension_AC_msb_claim_ledger.tsv` | `f753140181d6ac51cd9edcb54ba449b207c1315288225e36f14ca90db5deb7d1` |
| `scripts/verify_agenda_extension_AC_msb.R` | `bf69fb434cc05cc53ecab97080989cf2526979c903f17cf0e33c768acb945e51` |
| `quality_reports/verification_outputs/2026-08-30_AC_msb_verifier_output.txt` | `7d039c00e8ab092b8a3402771062ff83c01d1669e75ab8230b5897b8f530965a` |

## 6. Gate seguinte

O próximo gate é enviar exatamente um manifesto de candidato a dois
pareceristas independentes, ambos read-only. Findings devem ser adjudicados
antes de qualquer reparo. Mesmo um duplo `PASS` não congela `A_C`: a aprovação
autoral terminal continua separada.
