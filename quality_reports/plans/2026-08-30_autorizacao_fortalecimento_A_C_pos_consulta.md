# Autorização autoral — fortalecimento de `A_C` após consulta externa

**Data:** 2026-08-30  
**Status:** `APPROVED`  
**Nó:** `A_C` sob a arquitetura M/S/B em duas camadas  
**Branch:** `agenda-extension-am-msb`

## 1. Origem da decisão

O autor recebeu a consulta técnica externa não formal preservada em
`quality_reports/external_reviews/2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AC_msb.md`.
A adjudicação local está em
`quality_reports/adjudication/A_C_msb_external_chatgpt/c7e2e39850e2/adjudication_round1.md`
e separou reparos determinados de resultados novos opcionais.

Após receber a explicação de por que os resultados adicionais não haviam sido
incluídos automaticamente, o autor respondeu literalmente: **“do it.”** Essa
resposta autoriza a implementação conjunta do reparo mínimo e dos resultados
mais fortes discutidos imediatamente antes.

## 2. Escopo autorizado

1. Qualificar a linguagem sobre leis conjuntas cross-world: o game form e
   `A_C` não induzem, selecionam nem identificam uma lei conjunta, embora seja
   possível impor acoplamentos como convenções externas.
2. Definir explicitamente
   `V_g^E=(1-nu)V_g^0+nu V_g^1` a partir do mesmo binder e registrar `D_E` como
   imagem afim do vetor ligado `D_01`.
3. Fortalecer T5 com a margem uniforme
   `g_T5=beta*(c/m-beta*o_1)`.
4. Acrescentar o certificado local das células baixas com
   `g_0=beta*(c/m-beta*o_0)`, preservando no endpoint `nu=0` apenas a conclusão
   ex ante que não requer promover o tipo contrafactual alto.
5. Acrescentar o exemplo numérico que prova que T5 não é necessário.
6. Acrescentar a forma fechada de `c/m` conforme a paridade de `N` e sua
   interpretação econômica.
7. Sincronizar contrato, resultados, interface, ledger, verificador, output,
   DAG, manifesto e sidecars correntes de lifecycle.

## 3. Limites preservados

- A autorização não modifica os pacotes congelados de `A_M` ou `A_U`.
- Não autoriza acoplamento cross-world, seleção de equilíbrio ou novo ranking
  de bem-estar.
- Não autoriza `A_R`, migração ao manuscrito, tag, merge ou push.
- Os novos bytes de `A_C` permanecem `pending/unfrozen` até novo manifesto,
  verificações mecânicas, revisões formais independentes, adjudicação e decisão
  autoral terminal.

## 4. Invalidação

Os pareceres formais anteriores permanecem válidos apenas para os snapshots que
revisaram. Eles não cobrem retroativamente os novos bytes. Todo consumo
downstream deve aguardar o novo gate terminal de `A_C`.
