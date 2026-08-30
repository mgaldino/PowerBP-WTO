# Parecer matemático independente — `A_T`, rodada 1

**Snapshot:** `422a3e61d61c26d090ad1fc8f324636fe0bf421e`  
**Manifesto revisado, preservado em:** `quality_reports/2026-08-30_AT_msb_round1_reviewed_manifest.sha256`  
**SHA-256 do manifesto:** `1e454bb6d4ed7e2489ed9fcd23c7e25967baa7af2361da494b1a7966e5cbe728`  
**Integridade:** `11/11 OK`  
**Verificador fresco:** `45 PASS / 0 FAIL`  
**FINAL_STATUS:** `FAIL — Critical 0 / Major 2 / Minor 1`

O leitor foi independente e read-only; a worktree permaneceu limpa.

## Major 1 — célula `none` alta omitida

A fonte congelada registra que, para

```text
nu_star<nu<1,
nu_off in (0,nu_star],
```

o braço privado com agenda sob unanimidade é `none`, enquanto o controle sem
agenda existe. Logo `T_U=none` e qualquer `DeltaT` que o exija também é `none`.
O candidato não materializava essa célula nos resultados, na interface, nos
registros completos ou no ledger, apesar de reivindicar classificação completa.

## Major 2 — classificação falsa dos casos de efeito zero

No endpoint `nu=0`, a própria fórmula candidata é

```text
T_U^{01}=(1-beta,max{Delta_U,0}).
```

Portanto, se `Delta_U<=0`, a coordenada contrafactual do tipo alto é zero.
Isso contradizia a afirmação de que zero somente ocorreria na família alta
`rho=0`. A não negatividade e o efeito ex ante `1-beta` permanecem corretos.

## Minor 1 — domínio ausente no registro completo

O conjunto correto da família `rho=0` é

```text
{(u-d_H,u-d_H):u in [max{z_L,d_H},z_H]}.
```

O arquivo `complete_records` trazia apenas `{(u-d_H,u-d_H)}`, sem quantificar
`u`, e por isso não representava sozinho o conjunto ligado exato.

## Resultados que resistiram à reconstrução

- O desenho `2 x 2` e a data dos quatro braços estão corretos; `beta` aparece
  exatamente uma vez no braço sem agenda.
- As fórmulas de `D_U`, `D_M` e `DeltaD`, inclusive as fronteiras, estão
  corretas.
- As identidades `T=D+I` e `DeltaT=DeltaD+DeltaI` estão corretas.
- `T_M`, `DeltaT` e `Q_M` preservam os registros completos e não impõem
  seleção cross-world.
- O contraste diagonal `Q` está corretamente rotulado como mudança de dois
  fatores, não como efeito causal isolado.

O `45 PASS / 0 FAIL` era reproduzível, mas não testava a célula alta omitida,
a exclusividade falsa de zero nem o domínio semântico de `u`.
