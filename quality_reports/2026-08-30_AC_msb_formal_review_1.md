# Parecer formal independente 1 — candidato `A_C` sob M/S/B

**Data:** 30 de agosto de 2026  
**Papel:** parecerista formal independente, read-only  
**Objeto:** integração privada `A_C` entre as correspondências congeladas `A_M` e `A_U`  
**Branch:** `agenda-extension-am-msb`  
**Commit empacotado revisado:** `886c440c4ea882cca42472975e6316c927c86a6e`  
**Orientação dos contrastes:** unanimidade menos maioria, `U-M`

## 1. Independência, identidade e escopo

O parecerista reconstruiu o argumento a partir dos bytes do commit empacotado,
sem consultar o outro parecer, sem editar arquivos e sem tratar o verificador
como prova formal. O `HEAD` posterior era `996abd3`, mas os seis artefatos
governados eram byte-idênticos aos blobs de `886c440`.

O manifesto tinha SHA-256 externo
`6ba078efb05f7aea628f73644e26a05e26dd6de592237a239855a365e6389d9a`.
As 6/6 entradas passaram em `shasum -a 256 -c`:

| Artefato | SHA-256 |
|---|---|
| Contrato | `d09958a447cc440586c000f92c10982ae1f786a94845c602d714c6ff284a8b14` |
| Resultados | `479c0089a1ed6a08dc9ffd8061933d248505c9b753a036f812f5b163586d8e77` |
| Interface | `103b564bd15af69dbb45c6b57cd16a0228d3c60a24b758ad779f6b75e7fe2cdf` |
| Claim ledger | `f753140181d6ac51cd9edcb54ba449b207c1315288225e36f14ca90db5deb7d1` |
| Verificador R | `bf69fb434cc05cc53ecab97080989cf2526979c903f17cf0e33c768acb945e51` |
| Output mecânico | `7d039c00e8ab092b8a3402771062ff83c01d1669e75ab8230b5897b8f530965a` |

Os manifestos finais congelados de `A_M` e `A_U` também passaram integralmente.

## 2. Reconstrução formal

### 2.1 Domínio e fibra

O domínio comum inclui corretamente

```text
d=(N,m,q,k,beta,o_0,o_1,y_bar,Y,nu),
m=N-1,
q=floor(N/2)+1,
k=q-1.
```

`y_bar` é mantido como primitiva de `A_M` e não é confundido com a proposta
`y_H` de `A_U`. No interior,

```text
eta=(rho,nu_off),
nu_off=nu*rho/(1-nu+nu*rho),
```

e nos endpoints a fibra é `eta=(*,nu)`.

### 2.2 T1 — produto fibrado

O objeto

```text
J_AC^bind(d,eta)=B_M(d,eta) times_(d,eta) B_U(d,eta)
```

é necessário porque uma comparação institucional mantém fixas economia e fibra,
e cada coordenada deve ser um PBE completo de sua instituição. É suficiente
porque `A_C` não cria ação, informação, crença ou incentivo. O emparelhamento
contrafactual não exige que propostas, suportes, continuações ou sorteios
coincidam; o game form não contém acoplamento cross-world.

### 2.3 T2 — tipo antes do prior

Para cada par admissível,

```text
delta_theta=V_U^theta-V_M^theta,
delta_E=(1-nu)delta_0+nu delta_1.
```

A identidade com a diferença dos valores ex ante é distributiva. Os tipos de
probabilidade zero permanecem nos binders dos endpoints. Ambas as fontes já
entregam valores na data `A`; `A_C` aplica zero fatores novos de `beta`.

### 2.4 T3 e C1 — fatorização e lifting

Os resumos-fonte preservam a fibra e as duas leis anônimas condicionadas ao tipo.
Payoffs, probabilidades de acordo/atraso, posteriors e outcomes anônimos são
projeções ou integrais de funções Borel invariantes. Projeções, produtos finitos,
subtrações e médias afins preservam Borelidade, estabelecendo `C_bar_econ`.

O lifting setwise é válido sem seletor Borel de pré-imagens: cada resumo inteiro
possui ao menos um binder completo como pré-imagem, e a única condição cruzada é
a fibra comum. O candidato não recombina `V^0`, `V^1`, posteriors ou outcomes de
binders distintos e não estende a fatorização a operações off-path ou nomeadas.

### 2.5 Partição de `A_U` e T4

Com

```text
nu_star=(o_1-o_0)/(1-o_0),
z_L=1-beta+beta^2 o_0,
d_H=beta^2 o_1,
z_H=1-beta+beta^2 o_1,
Delta_U=z_L-d_H,
```

a partição importada é correta:

| Região | Valores/fibra de `A_U` |
|---|---|
| `nu=0` | `(z_L,max{z_L,d_H})` |
| `0<nu<=nu_star`, `Delta_U>=0`, `p=0` | `(z_L,z_L)` |
| `0<nu<=nu_star`, `Delta_U<0` ou `p>0` | `none` |
| `nu_star<nu<1`, `p=0` | `(u,u)`, `u in [max{z_L,d_H},z_H]` |
| `nu_star<nu<1`, `p in (0,nu_star]` | `none` |
| `nu_star<nu<1`, `p in (nu_star,1]` | `(z_H,z_H)` |
| `nu=1` | `(z_H,z_H)` |

`A_C` é não vazio se e somente se ambas as fontes são não vazias na mesma
fibra. A existência de `A_M` para algum `rho` não é promovida a existência para
todo `rho`; células vazias não recebem payoff-sentinela.

### 2.6 Contrastes, envelopes e seleção

`D_01` usa os vetores dos dois tipos ainda acoplados dentro do mesmo binder. Os
conjuntos de sinais são formados antes dos envelopes. Como todo binder de uma
fonte pode ser pareado com todo binder da outra na fibra fixa,

```text
inf D_r=inf U_r-sup M_r,
sup D_r=sup U_r-inf M_r.
```

Isso não presume atingimento; o intervalo é apenas o casco de `D_r`. Na célula
alta com `p=0`, `z_H>max{z_L,d_H}`, de modo que o payoff de unanimidade é
selection-dependent, ainda que seu sinal possa ser robusto.

### 2.7 T5 — certificado uniforme

As fontes dão

```text
V_M^theta>=Z_E=1-k*beta/m,
V_U^theta<=z_H=1-beta+beta^2 o_1.
```

Com `c=m-k`, vale

```text
Z_E-z_H=beta*(c/m-beta*o_1).
```

Logo `beta*o_1<c/m` implica vantagem estrita da maioria para os dois tipos e ex
ante em todo par comparável; igualdade implica dominância fraca. A condição é
suficiente, não necessária. O teorema está correto.

## 3. Verificação mecânica

O verificador foi reexecutado read-only:

```text
MECHANICAL RESULT: PASS | 941 PASS | 0 FAIL
```

O output reproduzido teve o mesmo SHA-256 do output governado. Isso não prova
completude das correspondências, fatorização Borel abstrata, ausência universal
de splicing nem validade semântica dos IDs do ledger.

## 4. Finding

### `AC-R1-MIN-1` — Minor — referências-fonte semanticamente desalinhadas ou incompletas

**Localização:** `model_redesign/agenda_extension_AC_msb_claim_ledger.tsv`,
especialmente os claims `AC-MSB-003`, `006`, `007`, `010`, `011`, `012`, `017`
e `018`.

**Evidência:**

- `AC-MSB-003` cita `AUX-MSB-025`, sobre atomicidade, quando a regra direta de
  mesma fibra está em `AUX-MSB-031`.
- `AC-MSB-006` cita `AMX-012`, sobre impossibilidades puras, e `AUX-MSB-021`,
  sobre o endpoint `nu=0`; o registro geral tipo-antes-do-prior de `A_U` é
  `AUX-MSB-020`.
- `AC-MSB-007` volta a citar `AMX-012`, que não prova data de payoff ou desconto.
- `AC-MSB-010` omite a exaustão interior `AUX-MSB-015` e os endpoints
  `AUX-MSB-021/022`, citando impropriamente `AUX-MSB-020`.
- `AC-MSB-011/012` usam `AUX-MSB-020` como fonte de existência/none, embora ele
  trate de tipo antes do prior.
- `AC-MSB-017/018` usam `AUX-MSB-020` como fonte do teto de unanimidade, que
  decorre da partição de payoffs.

Os hashes e proof paths estão corretos e as provas formais são válidas. O
defeito é de rastreabilidade semântica do ledger. O reparo mínimo é corrigir
somente os `source_record_ids`, recalcular o hash do ledger, reexecutar o
verificador e emitir novo manifesto. Nenhuma fórmula, interface, célula, bound
ou regra de seleção deve mudar.

## 5. Limites

O parecer não reabre integralmente as provas de membership de PBE das fontes,
não afirma compactação ou atingimento de extremos de `A_M`, não seleciona um
equilíbrio, não cria lei conjunta entre regras, não define bem-estar dos fracos
e não autoriza `A_R`, manuscrito, tag, merge ou push.

## 6. Veredito

T1–T5 estão matematicamente corretos. O ledger governado, porém, contém um
defeito menor e determinístico de rastreabilidade.

**Veredito:** `FAIL`  
**Contagem:** Critical 0 / Major 0 / Minor 1

FINAL_STATUS: FAIL  
COUNTS: 0/0/1
