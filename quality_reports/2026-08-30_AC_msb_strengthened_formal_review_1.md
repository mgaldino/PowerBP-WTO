# Parecer formal independente — candidato fortalecido de `A_C`

**Modo:** estritamente read-only  
**Branch:** `agenda-extension-am-msb`  
**Commit:** `02d217283948fbf430a10491c0907d484dbac3b4`  
**Manifesto:** `quality_reports/2026-08-30_AC_msb_strengthened_candidate_manifest.sha256`  
**SHA-256 do manifesto:** `509cc3540135721011f979ffd63ff1413b364fd8065b8c7a1ae581a572605e0e`  
**Integridade:** 8/8 hashes `OK`  
**Worktree ao final:** limpa

Não li o parecer do outro revisor nem a consulta externa. Não tratei
`1197 PASS / 0 FAIL` como prova matemática.

## Método

1. Confirmei branch, commit integral, limpeza da worktree e os oito hashes.
2. Verifiquei os manifestos finais congelados de `A_M` e `A_U`.
3. Reconstruí os resultados a partir dos limites e células das fontes congeladas.
4. Conferi contrato, resultados, interface e ledger nas partes alteradas.
5. Inspecionei o escopo institucional e os sidecars canônicos de lifecycle.

## Integridade dos oito artefatos

| Artefato | SHA-256 observado |
|---|---|
| autorização de fortalecimento | `67e5b948d2746b2d2d34ec788e61682ca4fa080a521ca588e606c00567b47e93` |
| contrato | `c5cb77679a119b04466329a0774671b8121d402e2dfd517fe3dfb2e88b357346` |
| resultados | `28d779b89a1d756050874bec8b1e042a42c27bbda9b87a2878f94e1c58f083f7` |
| interface | `40b975f85b6df485e91c8f1ce551d9342e102199bf9f15697b44f7dd10f371a1` |
| ledger | `6622be30b69b242b0621712881044e75750f1ece78cb9573d3b64ad90c9fbc97` |
| verificador | `8b4e7bd1bfc08e760eac3d97bf904d2f64abf8f54e35f8d8eda81bf4d4d0bf70` |
| output mecânico | `f396c6ba14b991571b0a0ca84eac125a91a8706228a76d13b4555152f0436e1c` |
| DAG | `4d359ae788162b554c9b9a55b78f6b5f57a62802208ee725d400d2d4b2b96210` |

A interface e o DAG são JSON válidos; o ledger conserva número uniforme de campos.

## Provas rederivadas

### 1. Lei conjunta cross-world

O texto reparado está correto. `A_C` conserva um par ordenado de leis
marginais. Acoplamentos matemáticos podem ser impostos — inclusive o produto
independente —, mas o jogo não induz, seleciona nem identifica um deles.
Portanto, o texto não confunde “ausência de acoplamento modelado” com
“impossibilidade matemática de construir um acoplamento”.

### 2. Coordenada ex ante ligada

Para cada binder completo,

```text
V_g^E=(1-nu)V_g^0+nu V_g^1.
```

Logo,

```text
delta_E
=V_U^E-V_M^E
=(1-nu)delta_0+nu delta_1.
```

Como `D_01` conserva os dois contrastes provenientes do mesmo par de binders,
sua imagem ex ante correta é

```text
D_E={(1-nu)x_0+nu x_1:(x_0,x_1) in D_01}.
```

Ela não pode, em geral, ser substituída por uma recombinação independente das
projeções `D_0` e `D_1`. Contrato, resultados, interface e ledger preservam
essa tipagem.

### 3. Margem uniforme de T5

Das fontes congeladas,

```text
V_M^theta>=Z_E=1-k*beta/m
e
V_U^theta<=z_H=1-beta+beta^2*o_1.
```

Como `c=m-k`,

```text
Z_E-z_H
=beta*(c/m-beta*o_1)
=g_T5.
```

Portanto, em toda fibra comum não vazia,

```text
V_M^theta-V_U^theta>=g_T5.
```

Se `beta*o_1<c/m`, a margem é estritamente positiva para os dois tipos. Sua
média ex ante também é pelo menos `g_T5`, pois os pesos somam um. Na fronteira
`beta*o_1=c/m`, `g_T5=0` e a conclusão correta é dominância fraca da maioria.

### 4. Corolário da célula baixa

Na célula baixa interior existente,

```text
V_U^0=V_U^1=z_L=1-beta+beta^2*o_0.
```

Assim,

```text
V_M^theta-V_U^theta
>=Z_E-z_L
=beta*(c/m-beta*o_0)
=g_0.
```

Sob `beta*o_0<c/m`, a margem é positiva para ambos os tipos e ex ante.

No endpoint `nu=0`, a média ex ante usa somente o tipo baixo:

```text
V_M^E-V_U^E=V_M^0-z_L>=g_0.
```

O texto corretamente não promove essa condição, sozinha, a uma afirmação
sobre o tipo alto contrafactual.

### 5. Contraexemplo à necessidade

Com

```text
N=5, m=4, k=2, c=2,
beta=.9, o_0=.5, o_1=.6, y_bar=.8, nu=0,
```

temos

```text
c/m=.5,
beta*o_1=.54>.5,
```

portanto a hipótese estrita de T5 falha. Entretanto,

```text
Z_E=.55,
z_L=.505,
d_H=.486.
```

Como `Delta_U=z_L-d_H=.019>0`, o vetor endpoint de unanimidade é
`(.505,.505)`. A fibra endpoint de `A_M` existe e todo binder satisfaz
`V_M^theta>=.55`. Logo a maioria domina estritamente ambos os tipos e ex ante.
O exemplo refuta necessidade, não suficiência.

### 6. Paridade

Se `N=2h+1`, então `m=2h`, `k=h`, `c=h`, logo `c/m=1/2`.

Se `N=2h`, então `m=2h-1`, `k=h`, `c=h-1`, logo

```text
c/m=(h-1)/(2h-1)=(N-2)/(2(N-1)).
```

A fórmula e sua interpretação estão corretas.

### 7. Não vacuidade e escopo

T5 e C2 impõem explicitamente `J_AC^bind(d,eta)!=empty`. Fibras vazias recebem
`none`, sem payoff fictício. O exemplo usa endpoints cuja existência é
garantida pelas duas fontes. Nenhum resultado seleciona equilíbrio, cria
bem-estar ou estabelece acoplamento cross-world.

### 8. Dependências e downstream

Os manifestos congelados de `A_M` e `A_U` passaram integralmente. Nenhum
arquivo dessas fontes foi alterado entre o candidato anterior e `02d2172`.
`A_R`, manuscrito, tag, merge e push continuam explicitamente não autorizados.

## Finding

### `AC-STRENGTH-R1-MIN-1` — sidecars canônicos ainda descrevem o candidato anterior

**Severidade:** Minor  
**Natureza:** administrativa/lifecycle; não matemática

`model_redesign/agenda_extension_status_current.json` e
`model_redesign/agenda_extension_STATUS.md` continuam apresentando como
candidato corrente:

- o manifesto antigo `fc9788...`;
- `941 PASS / 0 FAIL`;
- as revisões e adjudicação do snapshot anterior;
- o pacote terminal anterior de 12 hashes, qualificado como pronto para decisão autoral.

Isso é falso para os novos bytes fortalecidos, que usam o manifesto `509cc...`,
registram `1197 PASS / 0 FAIL` apenas como evidência mecânica e ainda aguardam
novas revisões e adjudicação. O próprio plano autorizado determinou sincronizar
os sidecars correntes.

O erro não altera as provas, não congela `A_C` e não libera downstream, mas
pode direcionar uma futura aprovação terminal ao snapshot errado.

**Reparo determinado:** repinar os dois sidecars ao candidato fortalecido,
registrar a autorização adicional e marcar explicitamente as novas
revisões/adjudicação como pendentes ou, depois de materializadas, registrar
apenas seus hashes efetivos. Reexecutar o checker administrativo e formar novo
manifesto terminal. Nenhuma alteração matemática é necessária.

## Contagem

- Critical: 0
- Major: 0
- Minor: 1

## Veredito

A matemática fortalecida de `A_C` passa integralmente nesta reconstrução
independente. O pacote corrente, contudo, falha o gate geral por um único
defeito administrativo de lifecycle.

**FINAL_STATUS: FAIL — 0 Critical / 0 Major / 1 Minor**
