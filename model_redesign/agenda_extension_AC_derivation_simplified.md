# Derivação de `AC` — comparação privada maioria–unanimidade

**Data:** 2026-08-27

**Nó:** `AC`

**Status:** `CANDIDATO INTEGRADO — NÃO REVISADO — DAG CONTINUA PENDING`

**Orientação dos contrastes:** unanimidade menos maioria, `Delta=U-M`.

## 1. Escopo, fontes e limite da integração

Esta derivação integra somente o pacote privado já produzido por `A_M` e
`A_U`. Ela não resolve novamente nenhum dos dois jogos, não escolhe um de seus
equilíbrios, não abre `AR` e não usa benchmark de tipo público.

As fontes matemáticas são:

| Nó | Artefato candidato | SHA-256 | Family records consumidos |
|---|---|---|---|
| `A_M` | `model_redesign/agenda_extension_A_M_candidate_simplified.json` | `c45b4420b0c1a4fe7dac2187ee90e79da5d47365eb32ebe2759aaa746ebcb976` | `AGENDA-EXT-A-M-FAMILY-ALL-PBE-V1` |
| `A_U` | `model_redesign/agenda_extension_A_U_candidate_simplified.json` | `d4bedcc1d579a38ca2a095ab2f1ce0256d1b4ce0af039076c2a954eeee3e47a7` | `A-U-FAM-NU-ZERO`, `A-U-FAM-LOW-PRIOR`, `A-U-FAM-HIGH-PRIOR-INTERIOR`, `A-U-FAM-NU-ONE` |

Os hashes das derivações, ledgers e checkers importados também são registrados
no candidato de `AC`. As visões completas de `C_M` e `C_U` não são copiadas:
permanecem acessíveis por seus IDs e hashes dentro dos binders das duas fontes.

Todos os payoffs de entrada de `A_M` e `A_U` já estão expressos na data `A`.
Logo `AC` usa fator de transporte 1 e aplica `beta` zero vezes. A única aplicação
de `beta` de cada continuação `C_g` para `A_g` já ocorreu dentro da fonte
correspondente e não é repetida.

## 2. Domínio comum e notação

Fixe a mesma tupla de primitivas

```text
d=(N,m,q,k,nu,beta,o_0,o_1,Y),
m=N-1, q=floor(N/2)+1, k=q-1,
N>=3, nu in [0,1], beta in (0,1), 0<o_0<o_1<1.
```

`Y` é o mesmo simplex relativo-Borel nas duas regras. A diferença de quota não
é divergência de primitivas: `A_M` requer `k` votos fracos favoráveis e `A_U`
requer todos os `m` votos fracos favoráveis.

Denote por

```text
B_M(d)=E_M(d)
```

o conjunto exato de binders `b_M` do family record de `A_M`. Cada `b_M` contém,
sem recombinação, propostas por tipo, crenças, votos, `kappa_M`, membros
literais de `C_M`, payoffs por identidade e tipo e distribuições de outcomes.
Se `E_M(d)` é vazio, `A_M` está na célula `A-M-CELL-NONE`.

Denote por `B_U(d)` a fibra de binders do family record de `A_U` compatível com
`d`. Defina

```text
nu_star=(o_1-o_0)/(1-o_0),
w_0=beta*(1-beta*o_0)/m,
w_1=beta*(1-beta*o_1)/m,
d_1=beta^2*o_1,
p_0=1-beta+beta^2*o_0,
p_1=1-beta+beta^2*o_1,
Delta_U=p_0-d_1,
u_min=max{p_0,d_1}.
```

A fibra `B_U(d)` é:

```text
nu=0:                              A-U-FAM-NU-ZERO;
0<nu<=nu_star e Delta_U<0:         vazia;
0<nu<=nu_star e Delta_U>=0:        A-U-FAM-LOW-PRIOR;
nu_star<nu<1:                      A-U-FAM-HIGH-PRIOR-INTERIOR;
nu=1:                              A-U-FAM-NU-ONE.
```

## 3. Regra necessária e suficiente de compatibilidade

Um par `(b_M,b_U)` é compatível em `AC` se, e somente se:

1. ambos são avaliados na mesma tupla `d`, com igualdade de `N`, `m`, `nu`,
   `beta`, `o_0`, `o_1` e `Y`;
2. `b_M in B_M(d)` e conserva integralmente o binder
   `A_M_BINDER(d;b_M)` do family record
   `AGENDA-EXT-A-M-FAMILY-ALL-PBE-V1`;
3. `b_U in B_U(d)` e conserva integralmente o binder do único family record de
   `A_U` cuja célula contém `d`;
4. os IDs e hashes das duas fontes são exatamente os registrados na Seção 1;
5. nenhuma coordenada de estratégia, crença, continuação, payoff ou outcome é
   transplantada entre membros, famílias ou regras.

Não existe primitiva que imponha a mesma seleção de equilíbrio, a mesma
realização aleatória ou um acoplamento probabilístico entre os dois jogos
contrafactuais. Portanto, depois de igualar `d`, não há restrição cruzada
adicional. A relação compatível é o produto fibrado de membros completos sobre
as primitivas comuns:

```text
J_AC(d)=B_M(d) times_d B_U(d)
       ={(b_M,b_U): b_M in B_M(d), b_U in B_U(d), common primitives match}.
```

Essa construção não é o produto cartesiano das imagens marginais de payoff.
Ela é formada antes das imagens, no nível dos membros completos e de seus
binders. Só depois os payoffs e outcomes são projetados.

### Teorema 1 — necessidade e suficiência da compatibilidade

`J_AC(d)` é exatamente o conjunto de pares admissíveis para a comparação
privada em `d`.

**Necessidade.** Uma comparação entre regras exige a mesma economia primitiva.
Cada coordenada sob maioria deve pertencer a um PBE de `A_M` e cada coordenada
sob unanimidade a um PBE de `A_U`; pelas provas-fonte, isso equivale a
`b_M in B_M(d)` e `b_U in B_U(d)`. A atomicidade das fontes impede splicing.
Nenhuma seleção cruzada é primitiva do jogo.

**Suficiência.** Tome qualquer par que satisfaça os cinco itens. Cada binder já
gera um PBE completo de sua própria regra, com payoffs na mesma data `A`. Como
as regras são contrafactuais e não interagem, pareá-los sobre `d` não altera
incentivos, crenças ou continuações em nenhum jogo. Logo o par é uma comparação
admissível. QED.

## 4. Conjunto conjunto exato na data `A`

Para `b_M in B_M(d)`, escreva

```text
M_theta(b_M)=V_H^theta(b_M),
M_E(b_M)=(1-nu)M_0(b_M)+nu M_1(b_M),
Omega_M^theta(b_M)=distribuição completa de outcomes de A_M condicional ao tipo.
```

Para `b_U in B_U(d)`, defina analogamente `U_theta(b_U)`, `U_E(b_U)` e
`Omega_U^theta(b_U)`. Os contrastes, sempre em unidades de `A`, são

```text
delta_theta(b_M,b_U)=U_theta(b_U)-M_theta(b_M),
delta_E(b_M,b_U)=(1-nu)delta_0(b_M,b_U)+nu delta_1(b_M,b_U).
```

O objeto primário de `AC` é

```text
K_AC(d)={
  (b_M,b_U,
   M_0,M_1,U_0,U_1,
   delta_0,delta_1,delta_E,
   Omega_M^0,Omega_M^1,Omega_U^0,Omega_U^1):
  (b_M,b_U) in J_AC(d),
  todas as coordenadas são geradas pelos dois binders indicados
}.
```

`K_AC(d)` conserva os outcomes como um par ordenado de leis contrafactuais. Ele
não inventa uma distribuição conjunta entre regras. Uma distribuição
cross-world exigiria uma primitiva de acoplamento que o contrato não contém.

### Teorema 2 — tipo antes do prior

Para todo elemento de `K_AC(d)`,

```text
delta_E
= [(1-nu)U_0+nu U_1]-[(1-nu)M_0+nu M_1]
= (1-nu)delta_0+nu delta_1.
```

**Prova.** Os quatro valores condicionais são importados primeiro dos binders
de `A_M` e `A_U`. A identidade segue por distributividade. Nenhum payoff ex
ante substitui uma coordenada de tipo e nenhum desconto entra em `AC`. QED.

## 5. Fórmulas exatas por célula existente de `A_U`

Em todas as linhas abaixo, `b_M in B_M(d)` e `b_U` permanece no family record
completo indicado; as fórmulas de payoff não eliminam multiplicidade de outcome.

### 5.1 `nu=0`

Fonte `A-U-FAM-NU-ZERO`:

```text
(U_0,U_1)=(p_0,max{p_0,d_1}),
delta_0=p_0-M_0(b_M),
delta_1=max{p_0,d_1}-M_1(b_M),
delta_E=delta_0=p_0-M_0(b_M).
```

O tipo de peso zero continua no conjunto conjunto por tipo. Sua estratégia e
seu outcome não são descartados.

### 5.2 `0<nu<=nu_star` e `Delta_U>=0`

Fonte `A-U-FAM-LOW-PRIOR`:

```text
(U_0,U_1)=(p_0,p_0),
delta_theta=p_0-M_theta(b_M),
delta_E=p_0-M_E(b_M).
```

### 5.3 `nu_star<nu<1`

Fonte `A-U-FAM-HIGH-PRIOR-INTERIOR`:

```text
(U_0,U_1)=(u,u),
u in [u_min,p_1],
delta_theta=u-M_theta(b_M),
delta_E=u-M_E(b_M).
```

Cada `u` no intervalo é atingido por ao menos um binder completo de `A_U`; o
mesmo `u` pode estar associado a outcomes diferentes quando o gerador permite
mistura ou atraso. A comparação conserva ambos.

### 5.4 `nu=1`

Fonte `A-U-FAM-NU-ONE`:

```text
(U_0,U_1)=(p_1,p_1),
delta_theta=p_1-M_theta(b_M),
delta_E=delta_1=p_1-M_1(b_M).
```

## 6. Células `none` e regra sobrevivente

Como `J_AC(d)` exige um membro de cada regra,

```text
J_AC(d) é não vazio sse B_M(d) e B_U(d) são ambos não vazios.
```

Há três classes sem comparação:

1. `B_M(d)` vazia e `B_U(d)` não vazia: `A_U` sobrevive separadamente, mas
   `AC` é `none`;
2. `B_M(d)` não vazia e `B_U(d)` vazia: isso ocorre na célula explícita
   `0<nu<=nu_star`, `Delta_U<0`; `A_M` sobrevive separadamente, mas `AC` é
   `none`;
3. ambas vazias: nenhuma regra fornece membro comparável.

Nenhuma dessas células recebe zero, `NA`, infinito ou outro payoff-sentinela.
A ausência de uma regra não apaga o registro da regra sobrevivente e não produz
comparação fictícia.

## 7. Invariância e dependência de seleção

Para `c in {0,1,E}`, defina a projeção exata, depois de `K_AC(d)`,

```text
D_c(d)={delta_c(b_M,b_U):(b_M,b_U) in J_AC(d)}.
```

Quando `J_AC(d)` é vazio, `D_c(d)` também é vazio e não recebe classificação de
dominância. Quando é não vazio, o conjunto de sinais

```text
S_c(d)={sign(delta): delta in D_c(d)}
```

fornece a classificação necessária e suficiente:

- unanimidade vence estritamente em todos os pares sse `S_c(d)={+1}`;
- maioria vence estritamente em todos os pares sse `S_c(d)={-1}`;
- todos os pares empatam sse `S_c(d)={0}`;
- o sinal estrito depende da seleção sse `S_c(d)` contém mais de um sinal;
- unanimidade é fracamente superior em todos os pares sse
  `S_c(d) subset {0,+1}`; maioria é fracamente superior sse
  `S_c(d) subset {-1,0}`.

Essa é uma classificação exata por membros, não por extremos recombinados.

As conclusões que as fontes permitem sem seleção adicional são:

1. **Invariantes em todo par admissível:** a identidade de expectativa do
   Teorema 2; a orientação `U-M`; a existência da comparação somente quando as
   duas fibras existem; e a preservação dos binders e outcomes por regra.
2. **Células de payoff-U fixo:** em `nu=0`, na célula baixa existente e em
   `nu=1`, os valores de `U` exibidos nas Seções 5.1, 5.2 e 5.4 são invariantes
   em todos os binders de `A_U`. O valor do contraste depende de seleção apenas
   pela coordenada correspondente de `A_M`; outcomes podem continuar múltiplos.
3. **Célula alta interior:** `p_1>u_min`, pois `p_1>p_0` e
   `p_1-d_1=1-beta>0`. Fixado qualquer `b_M`, escolher binders `A_U` nos dois
   extremos produz valores distintos de `delta_0`, `delta_1` e `delta_E`.
   Portanto o valor de cada contraste é necessariamente selection-dependent
   nessa célula. O sinal, contudo, pode ser robusto se todo `D_c(d)` ficar do
   mesmo lado de zero.
4. **Ranking institucional:** `A_M` entrega uma família simbólica exata, mas não
   um payoff único nem fronteiras fechadas de seus extremos. Assim nenhuma
   afirmação não condicional de que maioria ou unanimidade sempre vence pode ser
   acrescentada. O ranking exato é o teste de sinais acima; escolher um membro
   de `A_M` para obter sinal determinado seria seleção não autorizada.

## 8. Envelopes e outras projeções, somente depois do conjunto conjunto

Defina

```text
M_c(d)={M_c(b_M):b_M in B_M(d)},
U_c(d)={U_c(b_U):b_U in B_U(d)}.
```

Esses conjuntos são projeções de `K_AC(d)`. O casco intervalar de `D_c(d)` é

```text
[inf D_c(d), sup D_c(d)].
```

Nas células de payoff-U fixo em `t_c(d)`, seus extremos satisfazem

```text
inf D_c=t_c-sup M_c,
sup D_c=t_c-inf M_c.
```

Na célula alta interior,

```text
inf D_c=u_min-sup M_c,
sup D_c=p_1-inf M_c.
```

Esses intervalos são envelopes/cascos. Eles não substituem `D_c(d)` e seus
pontos internos não são declarados atingíveis sem prova. Em particular, `AC`
jamais forma primeiro intervalos marginais e depois seu produto cartesiano.

## 9. Outcomes e ausência de ordenação não autorizada

O conjunto exato de outcomes é

```text
O_AC(d)={
 ((Omega_M^0(b_M),Omega_M^1(b_M)),
  (Omega_U^0(b_U),Omega_U^1(b_U))):
 (b_M,b_U) in J_AC(d)
}.
```

Não existe no contrato uma função de bem-estar, uma métrica de atraso ou uma
ordem sobre distribuições que permita transformar `O_AC(d)` em um ranking
escalar. `AC` registra agreement/delay e as leis completas por referência aos
binders; não inventa uma comparação de outcomes além dos payoffs de `H`
explicitamente autorizados.

## 10. Auditoria temporal, cobertura e invalidação

| Valor importado | Data nativa em `AC` | Fator em `AC` | Aplicações adicionais de `beta` |
|---|---|---:|---:|
| `M_theta(b_M)` e `M_E(b_M)` | `A` | 1 | 0 |
| `U_theta(b_U)` e `U_E(b_U)` | `A` | 1 | 0 |
| `Omega_M^theta(b_M)` | `A` | 1 | 0 |
| `Omega_U^theta(b_U)` | `A` | 1 | 0 |

A partição de sete células do candidato é disjunta e exaustiva: quatro células
em que `A_M` e `A_U` existem, uma em que apenas `A_M` existe, uma em que apenas
`A_U` existe e uma em que ambas são `none`.

O checker associado testa apenas JSON/TSV, hashes, IDs, schemas, partição de
fronteiras, identidades e contagem de `beta`. Não prova completude de PBE,
mensurabilidade, extremos de `A_M` ou invariância sobre famílias contínuas.

Qualquer mudança de bytes em `A_M` ou `A_U` invalida `AC`. Este candidato não
marca nenhum nó como `pass`: as duas revisões matemáticas finais independentes
do pacote privado continuam pendentes.
