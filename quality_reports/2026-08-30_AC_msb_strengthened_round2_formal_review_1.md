# Parecer formal independente — `A_C` fortalecido, rodada 2

**Modo:** estritamente read-only  
**Branch:** `agenda-extension-am-msb`  
**Commit:** `5410b06b1cb036e53ba2d34830e21425e65f89a0`  
**Manifesto:** `quality_reports/2026-08-30_AC_msb_strengthened_round2_candidate_manifest.sha256`  
**SHA-256 do manifesto:** `ec5bbebe0490eb8a46ee5e0de1565cf52ae1838721a870df21cdc4a629058339`  
**Worktree ao final:** limpa

O parecerista não consultou o outro parecer. `1200 PASS / 0 FAIL` foi tratado
somente como evidência mecânica, não como prova matemática.

## Escopo e integridade

Os oito artefatos do manifesto passaram a verificação de hash:

| Artefato | SHA-256 |
|---|---|
| autorização de fortalecimento | `131e7485879ffbf1d399f91c2b838fb05e8d64644ae2c393692ffce1888fedec` |
| contrato | `abd9b27be4cf1490501e07d0d95ca53a27ae62b492354cb6feb8a633cf021a66` |
| resultados | `8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a` |
| interface | `ea869c023ce7426dae3b92ffad344b4c79f1f0ce220b8fffaceb011904a85249` |
| ledger | `ed49e1f78a77481135b001599c263aeb41bbea106d439cf2f2a660c5c0d1edb1` |
| verificador | `340c5b793b4f509df7e83fc1f9326bbf1b8b9c7d5f17a41056103a32e029b904` |
| output mecânico | `0be70231be14e346b252147c51c64714170141b1e7ebf6ae89ddec6c596978e5` |
| DAG | `83245ae3e33b0fd8a29898627aaae40226c9317402e79e1b1375b34aa88a4262` |

A interface e o DAG são JSON válidos. O ledger contém 24 claims, todos com o
schema uniforme de 16 campos. Os manifestos finais congelados de `A_M` e `A_U`
também passaram integralmente; nenhum byte dessas fontes foi alterado.

## Reconstrução formal

### `D_E` e a ligação entre tipos

Para cada binder completo,

```text
V_g^E=(1-nu)V_g^0+nu V_g^1.
```

Consequentemente,

```text
delta_E=V_U^E-V_M^E=(1-nu)delta_0+nu delta_1.
```

O conjunto vetorial `D_01=V_U^01-V_M^01` é formado com vetores de tipos
provenientes de binders completos. Sua imagem ex ante correta é

```text
D_E={(1-nu)x_0+nu x_1:(x_0,x_1) in D_01}.
```

Não há recombinação independente das projeções marginais. Contrato, resultados,
interface e ledger preservam essa tipagem.

### T5 e a margem `g_T5`

Das fontes congeladas,

```text
V_M^theta >= Z_E=1-k*beta/m,
V_U^theta <= z_H=1-beta+beta^2*o_1.
```

Como `c=m-k`,

```text
Z_E-z_H=beta*(c/m-beta*o_1)=g_T5.
```

Logo, em toda fibra comum não vazia,

```text
V_M^theta-V_U^theta>=g_T5.
```

Se `beta*o_1<c/m`, a margem é positiva para ambos os tipos. A combinação ex
ante também preserva a mesma margem. Na fronteira `beta*o_1=c/m`, `g_T5=0` e a
conclusão correta é dominância fraca da maioria. Não houve regressão.

### C2 e a margem `g_0`

Na célula baixa interior existente,

```text
V_U^0=V_U^1=z_L=1-beta+beta^2*o_0.
```

Portanto,

```text
V_M^theta-V_U^theta
 >= Z_E-z_L
 = beta*(c/m-beta*o_0)
 = g_0.
```

Sob `beta*o_0<c/m`, há vantagem estrita da maioria para ambos os tipos e ex
ante. No endpoint `nu=0`,

```text
V_M^E-V_U^E=V_M^0-z_L>=g_0.
```

O texto corretamente limita essa conclusão ao payoff ex ante, sem promover
automaticamente o resultado ao tipo alto contrafactual.

### E1

Para

```text
N=5, m=4, k=2, c=2, beta=.9,
o_0=.5, o_1=.6, y_bar=.8, nu=0,
```

temos `c/m=.5` e `beta*o_1=.54>.5`; T5 não se aplica. Porém,

```text
Z_E=.55, z_L=.505, d_H=.486.
```

Como `z_L>d_H`, o vetor de unanimidade no endpoint é `(.505,.505)`, enquanto
todo binder de maioria entrega pelo menos `.55` aos dois tipos. O exemplo refuta
necessidade, não suficiência, de T5.

### C3

Se `N=2h+1`, então `m=2h`, `k=h`, `c=h` e `c/m=1/2`. Se `N=2h`, então
`m=2h-1`, `k=h`, `c=h-1` e

```text
c/m=(h-1)/(2h-1)=(N-2)/(2*(N-1)).
```

A fórmula e a interpretação de paridade estão corretas.

## Acoplamento cross-world, inclusive caso degenerado

A linguagem reparada agora distingue corretamente três objetos:

1. `A_C` declara apenas o par ordenado de leis marginais.
2. Em geral, essas marginais admitem vários acoplamentos e não identificam um
   único.
3. Se uma marginal é degenerada, o conjunto de acoplamentos compatíveis pode
   ser unitário.

Mesmo no terceiro caso, `A_C` não introduz uma variável aleatória conjunta como
primitiva nem autoriza operações cross-world não declaradas. Assim, a correção
elimina tanto a antiga afirmação absoluta de inexistência quanto o possível erro
oposto de transformar unicidade matemática degenerada em autorização
substantiva.

## Propagação da autorização

A autorização fortalecida, no hash `131e748...`, está corretamente propagada:

- no contrato, como autoridade expressa;
- na interface, com caminho, hash e escopo;
- no ledger, em todos os claims alterados ou acrescentados;
- no DAG, como nó e dependência direta do contrato e do candidato; e
- no verificador e no manifesto.

O escopo continua restrito a `A_C`. A interface mantém `false` para `A_R`,
migração ao manuscrito, tag, merge e push. O DAG deixa `A_R` `pending`,
`unfrozen` e `not authorized`.

## Findings estruturados

Nenhum finding.

- Critical: 0
- Major: 0
- Minor: 0

## Limites do parecer

O parecer cobre os oito hashes do manifesto indicado. Não promove o output
mecânico a prova, não revisa novamente a completude interna das correspondências
congeladas de `A_M` e `A_U`, não autoriza downstream e não substitui adjudicação
nem aprovação autoral terminal.

## Veredito

**FINAL_STATUS: PASS — 0 Critical / 0 Major / 0 Minor**
