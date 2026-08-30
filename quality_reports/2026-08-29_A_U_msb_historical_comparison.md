# Comparação histórica claim a claim — `A_U` antigo versus reconstrução M/S/B

**Data:** 2026-08-29  
**Blind-lock anterior à leitura histórica:** commit `c193f3b`  
**Papel:** implementação/comparação; não é parecer independente  
**Status:** comparação completa; uma precisão de interface reaberta; nenhum
arquivo histórico alterado

## 1. Sequência e fontes

O blind-lock foi commitado antes de qualquer acesso ao material abaixo. Só
depois desse commit foram lidos:

```text
d4bedcc1d579a38ca2a095ab2f1ce0256d1b4ce0af039076c2a954eeee3e47a7  model_redesign/agenda_extension_A_U_candidate_simplified.json
4100baa6b3fa00ccbc5ef1c9b8d656e14d844fdc6a36026fe61eb855b378e8e5  model_redesign/agenda_extension_A_U_derivation_simplified.md
fb8447d5aff10efdc600ad4753066636f86e994985d802684b19ddde2139d3dc  model_redesign/agenda_extension_A_U_claim_ledger_simplified.tsv
e8579785d0a0277601e2468951bf387853cd89b3f9a49386d2af5f8f31c1cba0  model_redesign/agenda_extension_A_U_claim_ledger.tsv
c5032f7baf8748a0bff2638c1a62d8ab609a8a964503975661dcf9c5d1270e60  scripts/verify_agenda_extension_A_U_mechanical.R
5dcae15ef3f32fb433e5f71e9372a7c722130ee1df6bfa1e6e38412e5f8be5e7  quality_reports/2026-08-27_agenda_extension_A_U_execution_preflight.md
```

Não foi localizado parecer matemático independente específico sobre os bytes
históricos de `A_U`: o preflight os descreve como candidato completo não
revisado, e o próprio JSON registra `review_status=Not yet independently
reviewed`. O ledger sem sufixo contém apenas o cabeçalho histórico vazio; o
ledger `simplified` contém os 16 claims comparados.

## 2. Resultado claim a claim

| Claim antigo | Classificação pós-M/S/B | Razão e destino |
|---|---|---|
| `A-U-CLM-001` | correto e preservado | O transporte `w_0,w_1,d_0,d_1` e a aplicação única de `beta` coincidem com `a,b,d_0,d` novos. |
| `A-U-CLM-002` | correto e preservado | A regra de voto unanimista, as-if-pivotal e `T^Y` é idêntica. |
| `A-U-CLM-003` | correto e preservado | Todo posterior precisa pertencer a `{0} union (nu_star,1]`; a célula `none` segue inadmissível. |
| `A-U-CLM-004` | correto e preservado | Os máximos aceitos `p_0,p_1` são `z_L,z_H`; rejeições preservadas. |
| `A-U-CLM-005` | correto e preservado | Imitação iguala payoffs interiores e dá o mesmo intervalo global. |
| `A-U-CLM-006` | correto e preservado | A não existência em prior baixo com `Delta<0` sobrevive M/S/B. |
| `A-U-CLM-007` | correto mas incompleto; superado por M/S/B na família | Existência e payoff `p_0` sobrevivem. O gerador antigo não tipava `nu_off`, permitia crenças livres por ponto e `kappa_U` por história; o novo exige `nu_off=0`, átomo `q_0` e `kappa_U` markoviana. |
| `A-U-CLM-008` | correto mas incompleto; superado por M/S/B na família | A imagem `[max{p_0,d_1},p_1]` sobrevive. M/S/B separa high-only com `nu_off=0`, pooling eficiente com `nu_off` alto e a família adicional com massa em posterior zero quando `Delta>=0`. |
| `A-U-CLM-009` | correto e preservado | A correspondência de melhor resposta do tipo de prior zero depende do sinal de `Delta`. |
| `A-U-CLM-010` | correto e preservado | No endpoint um, ambos escolhem unicamente `q_1=y_H`. |
| `A-U-CLM-011` | superado por M/S/B | O gerador de seis condições era necessário/suficiente para o contrato anterior, mas viola as novas cláusulas M e B ao permitir `kappa_U` por história e crença off-path ponto a ponto. Não é gerador do contrato corrente. |
| `A-U-CLM-012` | correto e preservado | Atraso só entra quando o payoff comum é `d_1`; outcomes permanecem conjuntos no binder. |
| `A-U-CLM-013` | parcialmente errado e não tipado | A atomicidade é correta, mas a fórmula antiga usa `w(0)=w_0` para qualquer `theta`. O membro literal `C_U(0)` fixa o payoff fraco contrafactual em `theta=1` como zero. `w_0` é o preço de voto esperado sob posterior zero, não o payoff realizado desse tipo impossível. A interface nova agora expõe explicitamente `theta=1,mu=0 -> 0`. |
| `A-U-CLM-014` | correto e preservado | A imagem ex ante de `H` coincide célula a célula. |
| `A-U-CLM-015` | correto no particionamento de payoffs, mas superado por M/S/B na cobertura de membros | As cinco regiões de existência/imagem sobrevivem; os family records antigos não cobrem exatamente as novas restrições M/S/B. |
| `A-U-CLM-016` | correto como evidência mecânica histórica; incompleto para o contrato corrente | `14 PASS / 0 FAIL` testava o schema anterior. O novo harness testa M/S/B, endpoints, `y_bar`, quota e a coordenada fraca contrafactual, sem converter teste em prova. |

## 3. Síntese por categoria

```text
correto e preservado: 10 claims (001-006, 009-010, 012, 014)
correto mas incompleto/superado na família: 3 claims (007, 008, 015)
superado por M/S/B como gerador corrente: 1 claim (011)
parcialmente errado/não tipado: 1 claim (013)
correto apenas como teste histórico: 1 claim (016)
```

As fórmulas centrais de payoff de `H` não foram copiadas: foram derivadas e
commitadas em `c193f3b` antes da leitura e só então cotejadas. A comparação
confirma os limiares, o intervalo de payoff e os endpoints, mas substitui as
liberdades de crença/continuação pelo contrato M/S/B.

## 4. Reabertura e reparo

A comparação não encontrou defeito na classificação estratégica do blind-lock.
Encontrou uma **omissão de exposição** na interface JSON nova: embora o arquivo
de resultados já registrasse corretamente o payoff zero do fraco em
`theta=1,mu=0`, o JSON não apresentava essa coordenada explicitamente. A
interface foi reaberta para acrescentar a regra de payoff por tipo e identidade;
o ledger recebeu `AUX-MSB-028`; o harness passou a verificar a coordenada no
`C_U` literal. Essa precisão impede que um consumidor repita o erro de
`A-U-CLM-013`.

Nenhum arquivo histórico foi editado. `AC` não foi aberto como derivação nem
executado. A decisão de assinatura de duas camadas de `A_M` não foi imposta a
`A_U`: a interface preserva a órbita diagonal exata e deixa qualquer claim de
suficiência do resumo para prova futura em `AC`.
