# Re-revisão matemática independente — `A_T`, rodada 2

**Snapshot:** `93b42091b946db0e3b795d157c99070d27465d5e`  
**Manifesto revisado, preservado em:** `quality_reports/2026-08-30_AT_msb_round2_reviewed_manifest.sha256`  
**SHA-256:** `a192082154171608703683a7327ba58e41f19584f133c146517256b3fb3300a9`  
**Integridade:** `11/11 OK`  
**Verificador fresco:** `49 PASS / 0 FAIL`  
**FINAL_STATUS:** `FAIL — Critical 0 / Major 0 / Minor 1`

O leitor reconstruiu e aprovou os três reparos substantivos da rodada 1:

- a célula high-none agora implica `T_U=none` e `DeltaT=none`, sem eliminar
  `Q_U`;
- o endpoint `nu=0` inclui corretamente o zero da coordenada contrafactual alta
  quando `Delta_U<=0`;
- o domínio ligado `u in [max{z_L,d_H},z_H]` está preservado.

Também foram aprovados o tratamento obrigatório, o desenho `2 x 2`, a aplicação
única de `beta`, as fórmulas de `D_U`, `D_M`, `DeltaD` e `Q_U`, as identidades
fatoriais e a preservação de conjuntos/tuplas completas.

## Minor 1 — ID de fonte inexistente

O claim `AT-MSB-011` citava `AR-U-HIGH-NONE`, mas o ID literal da fonte em
`agenda_extension_AR_msb_interface.json` é `AR-RI-U-HIGH-NONE`. O hash e a
conclusão matemática estavam corretos; o defeito era exclusivamente de
proveniência. O verificador não resolvia o ID contra a interface congelada.
