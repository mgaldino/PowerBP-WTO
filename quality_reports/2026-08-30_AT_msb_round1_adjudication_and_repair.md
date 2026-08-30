# Adjudicação e reparo — `A_T`, rodada 1

**Snapshot examinado:** `422a3e61d61c26d090ad1fc8f324636fe0bf421e`  
**Veredito:** `3 CONFIRMED / 0 PARTIAL / 0 REFUTED / 0 UNRESOLVED`

Os dois pareceres reconstruíram as mesmas fontes congeladas e convergiram em
dois defeitos major. O terceiro finding, sobre o domínio do conjunto ligado,
foi adicionalmente identificado pelo parecer matemático. A observação
adversarial sobre o nome do tratamento também foi aceita como reparo de escopo.

## Mapa de reparos

| finding | decisão | reparo |
|---|---|---|
| célula alta `none` ausente | confirmado, major | materializada em resultados, interface, registros completos, ledger e verificador; `DeltaT=none`, mas `Q_U` continua definido |
| exclusividade falsa de efeito zero | confirmado, major | `T4`, ledger e resumo agora incluem o endpoint `nu=0` quando `Delta_U<=0`, preservando `T_U^E=1-beta` |
| domínio de `u` ausente | confirmado, minor | `complete_records` agora retém `u in [max{z_L,d_H},z_H]` |
| linguagem de opção de agenda | confirmado como precisão de escopo | tratamento redefinido literalmente como etapa anterior e obrigatória de proposta, sem ação de passagem |

O verificador foi ampliado de `45` para `49` testes, incluindo cobertura da
célula alta `none`, as duas famílias de efeito zero, o domínio ligado de `u` e
a natureza obrigatória do tratamento. A revisão de rodada 1 permanece válida
somente como diagnóstico do snapshot antigo; o candidato reparado exige nova
revisão independente e não está congelado.
