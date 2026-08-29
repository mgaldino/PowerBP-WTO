# Revisão matemática independente — resultados explícitos de `A_M`

**Data:** 2026-08-28  
**Revisor:** agente independente, estritamente somente leitura  
**Separação de papéis:** o revisor não criou nem editou arquivos  
**Veredicto dos bytes examinados:** `PASS 0/0/0`  
**Limite:** este veredicto não declara `A_M` aprovada, congelada ou completa.

## 1. Contagens

| Severidade | Findings |
|---|---:|
| critical | 0 |
| important | 0 |
| minor | 0 |

## 2. Identidade dos bytes revisados

O revisor recalculou com sucesso o manifesto
`quality_reports/2026-08-28_agenda_extension_A_M_explicit_review_manifest.sha256`:

| Artefato | SHA-256 |
|---|---|
| `model_redesign/agenda_extension_A_M_explicit_majority_results.md` | `19881e9aa680784c93251f8b1c09921f28152ed36941661a6d351697e9dc6885` |
| `model_redesign/agenda_extension_A_M_explicit_majority_claim_ledger.tsv` | `857bfcd609313cfd54475286377496c58d1fb588d0952d0255ba205e88e3dec8` |
| `scripts/verify_agenda_extension_A_M_explicit.R` | `2679d8cf8f8c97b374a9bba2f5f4be053cf171f8f84fcc17606004fdca2a9879` |
| `quality_reports/2026-08-28_agenda_extension_A_M_explicit_preflight.md` | `39f0f65e17db7ea7df9b2ccdba122e641cf40b1b80bda09e1f475b24e318fa76` |

Fontes centrais também recalculadas e conferidas:

| Fonte | SHA-256 |
|---|---|
| `C_M` congelado | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| derivação congelada de `C_M` | `75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3` |
| interface `N1` | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` |
| derivação integral de `N1` | `44ef92fcd8bb76af65b937b37ff509fcb9b179bc3fa3d06a3331c346e20a761a` |
| Gate 0 simplificado | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| decisão autoral/técnica de 28/08 | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |

O script terminou com `559 PASS / 0 FAIL`. Os avisos de locale foram
operacionais e não alteraram os resultados. O revisor tratou o script apenas
como checagem mecânica, nunca como prova.

## 3. Auditoria matemática

### 3.1 Construção cíclica e fórmulas

A regra cíclica tem grau de linha e coluna `r=k` em `E` e `r=k-1` em `S/P`.
Ela reproduz exatamente

```text
c_E=1/m,
c_S(mu)=[(1-mu)(1-beta*o_0)+mu*beta]/m,
c_P=(1-beta*o_1)/m.
```

Os payoffs de `H` vêm do mesmo membro literal: `(o_0,o_1)` em `E`,
`beta*(o_0,o_1)` em `S` e `(beta*o_1,beta*o_1)` em `P`. Não há recombinação
marginal.

### 3.2 Existência global e `D_M^0`

Com `k=q-1`, `Z_E=1-k*beta/m` e `T=Z_E/beta`, vale

```text
T-1/m = 1/beta-q/m > 0.
```

As regiões `o_1<=T`, `o_0<=T<=o_1` e `T<=o_0` cobrem todo o domínio.
Pooling-acordo, baixo-acordo/alto-atraso e pooling-atraso fornecem,
respectivamente, testemunhas globais. Todo desvio aprovado e rejeitado foi
comparado. Assim, a conclusão de existência e `D_M^0` vazio está sustentada,
sem alegar completude da correspondência.

### 3.3 Crenças e Bayes local

As medidas de proposta construídas têm suporte finito. Nos átomos, os
posteriors usados são exatamente os de Bayes; fora deles, cada ponto possui uma
vizinhança relativa de massa pública zero. As escolhas constantes ou por
singletons são Borel. Em `nu=0,1`, as crenças permanecem no suporte degenerado.
Nenhum tipo de prior zero é ressuscitado.

### 3.4 Semipooling e mistura

A fórmula

```text
mu_A=nu*lambda/[(1-nu)+nu*lambda]
```

está correta. Sob `beta*o_1>=Z_E` e capacidade de acordo pelo menos
`beta*o_1`, o tipo alto fica indiferente entre acordo e continuação `E`; o
baixo prefere estritamente o acordo. Desvios fora do caminho enfrentam `E`, e
nenhuma hipótese de exaustão da pie é acrescentada. As misturas em `o_1=T` e
`o_0=T` também sobrevivem.

### 3.5 `A_min`, `M_B` e `kappa_M` dependente do vetor

Para uma matriz de incidência com soma total `m*r` e grau de coluna máximo
`m-1`, a soma dos `k` menores graus satisfaz

```text
sum_k d_(j) >= max{0,m*r-(m-k)*(m-1)},
```

expressão equivalente à fórmula apresentada para `A_min(r)` nos dois valores
relevantes de `r`. As construções atingem o limite.

Para qualquer conjunto-alvo de `k` votantes, existe um único vetor rejeitado
com esses `k` agentes simultaneamente pivotais: basta colocar `k-1` votos
favoráveis no complemento, possível porque `m-k>=k-1`. Isso valida
`K_kappa>=beta*M_B` sem média sobre vetores nem recombinação de membros. Os
limites superiores `beta*k*U_B` também são atingíveis por seletores literais
distintos em histórias distintas.

### 3.6 Família plana `E`

Quando `o_0>1/m`, `E` é a única continuação em todo posterior. A incidência
regular produz `Z_E`, a incidência mínima produz `Zbar_E`, e convexificações
internas do mesmo binder cobrem o intervalo. Para cada `A` nele, o par

```text
(max{A,beta*o_0},max{A,beta*o_1})
```

é sustentado pelo mesmo seletor, sem cruzar coordenadas.

### 3.7 Limites globais

O limite

```text
C_bar=[1+beta*(m-k)/m]/m
```

domina todo payoff interino próprio de um fraco em `C_M`. Oferecer
`beta*C_bar` a `k` fracos garante acordo e

```text
A_g=1-k*beta*C_bar >= (1-k/m)^2 >= 1/9.
```

A proposta `(1,0,...,0)` é necessariamente rejeitada e garante pelo menos
`beta^2*o_theta`. Para qualquer proposta fixa, a diferença entre utilidades
dos tipos pertence a `[0,beta*(o_1-o_0)]`; maximizar sobre o mesmo espaço
preserva

```text
0<=V_H^1-V_H^0<=beta*(o_1-o_0).
```

Se o tipo alto usa acordo com probabilidade positiva, o tipo baixo pode
imitá-lo, produzindo igualdade dos payoffs.

### 3.8 Certificados de impossibilidade

Os quatro certificados globais estão corretos:

1. pooling não pode gerar destinos distintos;
2. separating com dois acordos requer parcelas iguais;
3. baixo-atraso/alto-acordo viola `D_0>=z_1>=D_1`;
4. dois atrasos separating exigem `o_0>1/m`.

A quinta impossibilidade está corretamente limitada à família cíclica
constante.

### 3.9 Datas e desconto

`N1` é terminal em R2 e não contém `beta` interno. `C_M` transporta `N1` uma
vez, gerando `w=beta/m` e `t_theta=beta*o_theta`. `A_M` transporta o payoff
nativo de `C_M` uma vez adicional. Assim:

```text
E rejeitado em A_M: beta*o_theta;
S rejeitado em A_M: beta^2*o_theta;
P rejeitado em A_M: beta^2*o_1.
```

Não há desconto duplicado.

## 4. Casos de fronteira

- `N=3`: `m=2`, `k=1`; `S/P` têm `r=0`, exatamente como tratado nas
  fórmulas especiais. A família plana `E` degenera corretamente num singleton.
- `nu=0,1`: crenças constantes respeitam o suporte; o tipo de probabilidade
  zero não altera Bayes e recebe estratégia sequencialmente ótima.
- `o_0=1/m`: `B(0)=S`, enquanto posteriors positivos usam `E`, como no `C_M`
  congelado.
- `o_1=1/m`: `B(1)=P`; no empate residual `E/P`, o mesmo peso conjunto governa
  as duas coordenadas.
- `o_theta=T`: as igualdades produzem indiferença real e sustentam as misturas
  declaradas; nenhuma região fica descoberta.

## 5. Limitações declaradas, não findings

Continuam abertas a classificação completa de PBEs puros com `kappa_M`
arbitrário, a classificação de todas as medidas Borel mistas e a
correspondência conjunta completa de payoffs. Os bytes não alegam tê-las
resolvido; por isso essas lacunas não contam como defeitos desta derivação
exploratória.

O script usa `z=.59` como testemunha numérica adicional no exemplo separating,
enquanto a tabela exibe a construção canônica com `z=Z_E=.55`; ambas satisfazem
as mesmas restrições de incentivo. O revisor recalculou diretamente a linha
`.55`, portanto não há contradição matemática.

## 6. Veredicto

```text
CRITICAL:  0
IMPORTANT: 0
MINOR:     0
VERDICT:   PASS 0/0/0
```

O veredicto é somente sobre os hashes listados. Não concede aprovação autoral,
status congelado ou completude a `A_M`.
