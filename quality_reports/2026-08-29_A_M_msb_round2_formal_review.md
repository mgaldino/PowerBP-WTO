# Revisão independente read-only — `A_M` M/S/B, rodada 2

**Data:** 2026-08-29  
**Revisor:** agente Codex independente, formal/game-theoretic  
**Edição de arquivos pelo revisor:** nenhuma  
**Manifesto:** SHA-256
`0cb55a703a172b5fb94e0bc35543049494fe0e7a86c6ca3dc3206b40d0185778`;
14 entradas verificadas.  
**Verificador:** `2890 PASS / 0 FAIL`, apenas mecânico.

## Veredicto

```text
FAIL — 0 critical / 1 important / 3 minor
```

## Finding importante

O domínio escrito `0<o_0<o_1<=y_bar<=1` admitia indevidamente
`o_1=y_bar=1`, embora a fonte congelada exija simultaneamente
`0<o_0<o_1<1` e `o_1<=y_bar<=1`. O reparo é restaurar literalmente as duas
restrições em todos os artefatos e adicionar uma regressão para `o_1=1`.

## Findings menores

1. Em `X_M`, `c_S(mu)` não é constante no rótulo `S`; os mapas devem ser
   definidos conjuntamente em `(mu,chi)` e são afins/Borel.
2. O relatório ainda dizia genericamente que M/B tornavam o seletor antigo
   inadmissível, embora a derivação já distinguisse M literal de B como barreira
   à reconstrução via crenças.
3. A região `T<=o_0` exige escrever `o_0>=T>1/m`, incluindo a fronteira.

## Resultados confirmados

Com esses reparos locais, o parecer confirmou membership, `y_bar`, `X_M`,
AMX-015, os objetos endpoint, AMX-016, classificação pura, existência,
transporte único de `beta`, AMX-010, semipooling, não fechamento global e o
certificado histórico.

