# Revisão independente read-only — fidelidade M/S/B, rodada 2

**Data:** 2026-08-29  
**Revisor:** agente Codex independente, adversarial/contrato  
**Edição de arquivos pelo revisor:** nenhuma  
**Manifesto:** SHA-256
`0cb55a703a172b5fb94e0bc35543049494fe0e7a86c6ca3dc3206b40d0185778`;
14 entradas verificadas.  
**Verificador:** `2890 PASS / 0 FAIL`, apenas mecânico.

## Veredicto

```text
FAIL — 0 critical / 1 important / 1 minor
```

## Findings

1. **Important:** o domínio escrito admitia `o_1=1`, fora da célula congelada
   de `C_M`. Reparo: `0<o_0<o_1<1` e `o_1<=y_bar<=1` no resultado, ledger e
   relatório, com teste negativo de fronteira.
2. **Minor:** o relatório ainda fundia os papéis de M e B. Reparo: M exclui o
   seletor literal; B exclui sua reconstrução via crenças não disciplinadas.

## Resultados confirmados

O parecer confirmou `R_boundary`, `Sig_boundary`, `X_M`, kernels, Bayes/B,
AMX-010 e AMX-014–016, atomicidade, rota regional de existência, finding de
não fechamento, semipooling, certificado histórico e ausência de consumo de
outros nós, condicionados aos dois reparos acima.

