# Parecer adversarial independente — `A_T`, rodada 1

**Snapshot:** `422a3e61d61c26d090ad1fc8f324636fe0bf421e`  
**Manifesto revisado, preservado em:** `quality_reports/2026-08-30_AT_msb_round1_reviewed_manifest.sha256`  
**Integridade:** `11/11 OK`  
**FINAL_STATUS:** `FAIL — Critical 0 / Major 2 / Minor 1`

O leitor foi independente e read-only; nenhum arquivo foi criado ou alterado.

## Major 1 — casos de `T_U=0`

O candidato excluía incorretamente o endpoint `nu=0`. Por exemplo, com
`beta=0.9`, `o_0=0.05` e `o_1=0.95`, temos `Delta_U=-0.629` e

```text
T_U^{01}=(0.1,0).
```

A coordenada contrafactual alta pode, portanto, ser zero no endpoint. A
não negatividade geral sobre células existentes não foi refutada.

## Major 2 — célula `none` de prior alto

Na fibra `nu_star<nu<1` e `nu_off in (0,nu_star]`, o braço com agenda é vazio
e o controle existe. Assim, `T_U=none` e `DeltaT=none`, enquanto `Q_U` continua
existindo porque não usa o braço privado com agenda. A regra genérica de
propagação de `none` não substitui a enumeração dessa célula numa interface que
reivindica completude.

## Minor 1 — definição literal do tratamento

O game form contém proposta obrigatória, sem ação nula, renúncia ou passagem.
O estimando deve ser descrito como

```text
inserir uma etapa anterior e obrigatória de proposta - iniciar diretamente em R1,
```

e não como o valor de uma opção facultativa. Sob informação privada, a proposta
obrigatória também pode alterar crenças e continuações.

## Pontos aprovados no stress test

- A distinção entre `T_g` e o contraste diagonal `Q_g` está correta.
- O transporte temporal usa exatamente um `beta`.
- A multiplicidade e as tuplas institucionais ligadas são preservadas.
- Não há sinal geral indevido para `T_M`, `DeltaT` ou `Q_M`.
- As identidades fatoriais e as fórmulas públicas estão corretas.

Os findings são reparáveis sem reabrir `A_R` ou `N7`, mas o snapshot desta
rodada não pode ser aprovado ou congelado.
