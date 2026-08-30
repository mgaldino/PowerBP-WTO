# Parecer matemático independente — terceira rodada de `A_R`

**Data:** 2026-08-30  
**Modo:** estritamente read-only  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Commit auditado:** `8016dacb79c382d085f23f836a1fdbf8d9b05292`  
**Manifesto:** `quality_reports/2026-08-30_AR_msb_candidate_manifest.sha256`  
**SHA-256 do manifesto:** `b1b483f3c31d58c3cd94807e9b55fd303e795510210914634e29faaee322a6d0`  
**Entradas:** `22/22 OK`

## Veredito

```text
FINAL_STATUS: PASS
CRITICAL: 0
MAJOR: 0
MINOR: 0
```

## Integridade e ausência de regressão

A comparação com o pai `8215c9f36910a94e251fea4ed8a3be273780a409`
mostra que contrato, resultados formais, ledger, DAG canônico, `A_C` e `N7`
permanecem byte-idênticos. A mudança substantiva no export completo limitou-se
a substituir o placeholder de `AR-DINT-UM` pelo mapa explícito das nove células
de contraste de `N7`. A interface apenas atualiza o hash desse export; o
verificador, a saída, o relatório e o manifesto registram o reparo.

Permanecem intactas e corretas:

```text
h_U(o)=1-beta+beta^2*o,

h_M(o)=1-k*beta*(1-beta*o)/m,                 se o<=1/m,
h_M(o)=max{1-k*beta/m,beta*o},                se o>1/m,

RI_g^{A,01}=V_g^{01}-(h_g(o_0),h_g(o_1)),
DeltaRI_A^theta=delta_theta+G(o_theta),
DeltaI^{01}=DeltaRI_A^{01}-beta*DeltaRI_N^{R1,01}.
```

Nenhuma correspondência, seleção, fronteira de empate, fórmula de payoff ou
regra de existência foi modificada.

## Resolução de `AR-DINT-UM`

O mapa foi confrontado diretamente com
`informational_rent_contrast_cells` do JSON congelado de `N7`:

| Região | Célula | Status | Fonte resolvida |
|---|---|---|---|
| II | `N7-DRI-CELL-II-NU-ZERO` | `exists` | `N7-DRI-II-NU-ZERO` |
| II | `N7-DRI-CELL-II-NONE` | `none` | certificado da própria célula |
| II | `N7-DRI-CELL-II-HIGH` | `exists` | `N7-DRI-II-HIGH` |
| IX | `N7-DRI-CELL-IX-NU-ZERO` | `exists` | `N7-DRI-IX-NU-ZERO` |
| IX | `N7-DRI-CELL-IX-NONE` | `none` | certificado da própria célula |
| IX | `N7-DRI-CELL-IX-HIGH` | `exists` | `N7-DRI-IX-HIGH` |
| XX | `N7-DRI-CELL-XX-NU-ZERO` | `exists` | `N7-DRI-XX-NU-ZERO` |
| XX | `N7-DRI-CELL-XX-NONE` | `none` | certificado da própria célula |
| XX | `N7-DRI-CELL-XX-HIGH` | `exists` | `N7-DRI-XX-HIGH` |

Há exatamente nove IDs únicos, seis células `exists` com o único record ID
correto e três células `none`, sem record espúrio e com referência ao
certificado correspondente. Não há ID desconhecido, duplicado ou trocado entre
regiões.

O reparo resolve proveniência sem mudar a fórmula ou as datas: o contraste de
agenda já está em `A`; o contraste de `N7` é nativo de `R1` e recebe exatamente
um fator `beta`. Se qualquer contraste-fonte é `none`, a interação é `none`.

## Evidência mecânica

O verificador foi reexecutado sem persistir nova saída e reproduziu:

```text
SUMMARY | 4372 PASS / 0 FAIL
LIMIT | Mechanical evidence only; independent formal review remains required.
```

Os cinco checks novos cobrem o inventário `9/6/3`, a resolução integral do
mapa e a rejeição de três mutações: ID inexistente, record em célula `none` e
certificado ausente. A evidência mecânica foi tratada apenas como complemento à
revisão formal.

Nenhum arquivo foi criado ou alterado pelo parecerista; a worktree permaneceu
limpa.
