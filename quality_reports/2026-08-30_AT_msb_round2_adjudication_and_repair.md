# Adjudicação e reparo — `A_T`, rodada 2

**Snapshot examinado:** `93b42091b946db0e3b795d157c99070d27465d5e`  
**Veredito:** `1 CONFIRMED / 0 PARTIAL / 0 REFUTED / 0 UNRESOLVED`  
**Severidade:** `Critical 0 / Major 0 / Minor 1`

Os dois leitores encontraram independentemente o mesmo ID-fonte inexistente no
ledger. O finding foi confirmado por busca literal na interface congelada:

```text
de: AR-U-HIGH-NONE
para: AR-RI-U-HIGH-NONE
```

O reparo único foi aplicado ao claim `AT-MSB-011`. O verificador passou a exigir
o ID exato, elevando a bateria de `49` para `50` testes. Nenhuma fórmula,
correspondência, condição de existência, fonte congelada ou arquivo do
manuscrito foi alterado. O novo snapshot requer confirmação independente final
e permanece `unreviewed/unfrozen` até essa confirmação.
