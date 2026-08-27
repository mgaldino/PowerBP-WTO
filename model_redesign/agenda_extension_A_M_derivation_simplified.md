# Derivação de `A_M` — agenda privada sob maioria

**Data:** 2026-08-27
**Nó:** `A_M`
**Status:** `CANDIDATE DERIVED — IMPLEMENTER PROOF — PRIVATE-PACKAGE REVIEWS PENDING`
**DAG:** permanece `pending`; este arquivo não concede `pass` nem `freeze`.

## 1. Escopo e dependência

Esta derivação resolve somente o estágio de agenda privada sob maioria. Ela
consome a interface congelada
`model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`,
doravante `C_M`, no SHA-256
`ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`.
Nenhum resultado de outro estágio da extensão é usado.

`C_M` tem data nativa própria. Quando uma proposta de `A_M` é rejeitada, o
payoff do membro selecionado de `C_M` é multiplicado por `beta` exatamente uma
vez. Acordo imediato em `A_M` não recebe desconto.

## 2. Primitivas e forma extensiva

Há um hegemon `H` e o conjunto de Estados fracos `W={1,...,m}`, com
`m=N-1`, `N>=3` e quota de maioria

```text
q=floor(N/2)+1.
```

Como a proposta de `H` conta como seu voto favorável, são necessários

```text
k=q-1
```

votos favoráveis dos fracos. O tipo de `H` é `theta in {0,1}`, com prior
`nu=Pr(theta=1)`. Somente `H` observa o tipo.

Uma proposta é

```text
s=(z_H,(x_j)_{j in W}) in Y,
Y={s: z_H>=0, x_j>=0, z_H+sum_j x_j<=1}.
```

Depois de observar `s`, os fracos votam simultaneamente e de forma pura.
Escreva `v(s)=(v_j(s))_{j in W}` e

```text
p_b(s)=1{sum_j v_j(s)>=k}.
```

Se `p_b(s)=1`, o pacote é implementado imediatamente: `H` recebe `z_H` e o
fraco `j` recebe `x_j`. Se `p_b(s)=0`, a história pública rejeitada entra em um
membro literal completo de `C_M` escolhido por `kappa_M`.

## 3. Visão completa e seletor de continuação

Para cada posterior `mu`, denote por `C_M(mu)` o conjunto de membros literais
completos gerados pelo registro `N3-SC-EQ-COMPLETE`. Um membro `c in C_M(mu)`
mantém unidos, pelo binder `F`, estratégias, crenças, loterias de
reconhecimento, votos internos, payoffs, outcomes e data nativa.

Uma história pública rejeitada é

```text
h^R=(M,s,H,a,rejected,mu(s)),
```

onde `a in {0,1}^m` e `sum_j a_j<k`. O seletor

```text
kappa_M: H_M^R -> union_{mu in [0,1]} C_M(mu)
```

é total, unívoco, público, comum aos tipos compatíveis e Borel-mensurável, e
satisfaz

```text
kappa_M(h^R) in C_M(mu(s)).
```

Histórias diferentes podem selecionar membros diferentes. Não há compressão
por posterior, invariância imposta entre vetores, payoff escalar substituindo
um membro nem payoff sentinela.

Para `c in C_M(mu)`, escreva:

- `C^I_{M,j}(c)` para o payoff interino próprio do fraco `j`, já integrando
  `theta` sob `mu` e todas as loterias internas do membro;
- `C^theta_{M,H}(c)` para o payoff de `H` condicionado ao tipo `theta`;
- `C^theta_{M,j}(c)` para o payoff realizado do fraco `j` condicionado ao tipo,
  obtido da estratégia, do outcome e das loterias do mesmo membro;
- `Omega^theta_M(c)` para a distribuição de outcomes do mesmo membro.

Essas coordenadas nunca são combinadas entre binders distintos.

## 4. Crenças depois da proposta

As estratégias de proposta são medidas Borelianas `sigma_0` e `sigma_1` em
`Y`. Defina a medida pública

```text
q_nu=(1-nu)*sigma_0+nu*sigma_1.
```

Em `0<nu<1`, um ponto `s` é disciplinado se toda bola relativa de `Y` centrada
em `s` tem massa pública positiva. Em cada ponto disciplinado, a crença é

```text
mu(s)=lim_{delta downarrow 0}
      nu*sigma_1(B_delta^Y(s))
      / [(1-nu)*sigma_0(B_delta^Y(s))+nu*sigma_1(B_delta^Y(s))],
```

e o limite deve existir. Quando alguma vizinhança relativa tem massa pública
zero, `mu(s)` pode ser qualquer valor no suporte do prior. Nos endpoints,
`mu(s)=0` para todo `s` quando `nu=0` e `mu(s)=1` para todo `s` quando `nu=1`.
Votos fracos não alteram `mu(s)`. O sistema `mu` é Borel-mensurável.

## 5. Lema da resposta pivotal ponto a ponto

Para cada fraco `j`, o conjunto dos vetores dos demais nos quais `j` seria
decisivo é

```text
P_j={a_{-j} in {0,1}^{m-1}: sum_{l!=j} a_l=q-2}.
```

Esse conjunto é finito e não vazio para todo `N>=3`. Para cada proposta `s` e
`a_{-j} in P_j`, defina a história rejeitada única

```text
h^R_j(s,a_{-j})=(M,s,H,(v_j=0,a_{-j}),rejected,mu(s))
```

e o valor próprio de rejeição, transportado para a data de `A_M`,

```text
r_{j,a}(s;b)=beta*C^I_{M,j}(kappa_M(h^R_j(s,a_{-j}))).
```

Somente o payoff de `j` entra nessa comparação. Não há média nem kernel sobre
vetores pivotais. As expectativas sobre `theta` e reconhecimento já estão
dentro do membro literal de `C_M`.

Como `j` não observa `a_{-j}`, a mesma ação pura deve satisfazer todas as
comparações. Defina

```text
r_lower_j(s;b)=min_{a_{-j} in P_j} r_{j,a}(s;b),
r_upper_j(s;b)=max_{a_{-j} in P_j} r_{j,a}(s;b).
```

### Lema 1 — compatibilidade pivotal pura

Uma ação pura de `j` em `s` é admissível sob as-if-pivotal e aceitação na
indiferença se, e somente se,

```text
v_j(s)=1  e  x_j>=r_upper_j(s;b),
```

ou

```text
v_j(s)=0  e  x_j<r_lower_j(s;b).
```

Se

```text
r_lower_j(s;b)<=x_j<r_upper_j(s;b),
```

nenhuma ação pura é admissível: ao menos uma história pivotal exige `sim` e ao
menos outra exige `não`.

**Prova.** Em cada história pivotal, `sim` implementa `x_j` e `não` produz
`r_{j,a}`. A regra de igualdade prescreve `sim`. Portanto `sim` satisfaz todas
as comparações exatamente quando `x_j` é pelo menos o máximo dos valores de
rejeição; `não` satisfaz todas exatamente quando `x_j` é estritamente menor
que o mínimo. No intervalo restante as prescrições história por história são
incompatíveis. QED.

Esse lema não restringe o membro completo escolhido por `kappa_M`; ele apenas
testa, separadamente, a coordenada de payoff próprio de `j` em cada membro.

## 6. Payoff de desvio de `H` sobre todo `Y`

Um binder candidato é

```text
b=(sigma_0,sigma_1,mu,v,kappa_M).
```

Ele é admissível para votos somente se o Lema 1 define uma ação pura para todo
`s in Y` e todo `j in W`. Para uma proposta rejeitada pelo vetor efetivamente
prescrito, defina

```text
c_b(s)=kappa_M(M,s,H,v(s),rejected,mu(s)).
```

O payoff de `H` do tipo `theta` ao escolher qualquer `s in Y` é

```text
g_theta(s;b)=
  p_b(s)*z_H
  +(1-p_b(s))*beta*C^theta_{M,H}(c_b(s)).
```

O primeiro termo é contemporâneo. O segundo contém exatamente uma aplicação
de `beta` ao payoff nativo de `C_M`.

Defina a correspondência de melhores propostas

```text
BR_theta(b)=argmax_{s in Y} g_theta(s;b).
```

O binder é admissível para `H` se `BR_theta(b)` é não vazio e

```text
sigma_theta(BR_theta(b))=1
```

para cada tipo. Essa condição testa literalmente todo `Y`, inclusive pooling,
separação, semi-pooling, misturas, acordo imediato e propostas rejeitadas. Uma
proposta rejeitada é apenas uma proposta em `Y`; não existe ação primitiva de
espera.

## 7. Gerador exato da correspondência

Para um vetor de primitivas `d`, denote por `E_M(d)` o conjunto de todos os
binders `b` que satisfazem simultaneamente:

1. `sigma_0` e `sigma_1` são probabilidades Borelianas em `Y`;
2. `mu` obedece à regra local de Bayes, à mensurabilidade e ao suporte do prior;
3. `kappa_M` é um seletor total Borel de membros literais completos de `C_M`;
4. o Lema 1 fornece uma ação pura compatível para todo par `(s,j)`;
5. cada `sigma_theta` tem suporte em `BR_theta(b)`.

Toda estratégia, crença, voto, continuação, payoff e outcome derivado de um
mesmo `b` recebe o mesmo binder atômico. Medidas contínuas ou mistas permanecem
representadas simbolicamente por `b`; não são discretizadas.

### Teorema 1 — necessidade, suficiência e cobertura

Sob o contrato aprovado e a clarificação autoral ponto a ponto, a
correspondência completa de PBE de `A_M` é exatamente

```text
PBE(A_M;d)={assessment(b): b in E_M(d)}.
```

**Necessidade.** Extraia de qualquer PBE as medidas de proposta por tipo, o
sistema de crenças, o perfil puro de votos e o seletor de continuação. A
consistência de crenças fornece a condição 2. A continuação literal e pública
fornece a condição 3. A racionalidade as-if-pivotal história por história e a
regra de igualdade fornecem, pelo Lema 1, a condição 4. A ausência de desvio
lucrativo de cada tipo de `H` sobre todo o conjunto factível fornece a condição
5. Logo o assessment é gerado por algum `b in E_M(d)`.

**Suficiência.** Tome `b in E_M(d)`. A condição 2 torna as crenças consistentes
em todo ponto disciplinado e admissíveis nos demais. A condição 3 fornece uma
continuação existente, completa, pública e comum aos tipos em toda rejeição. O
Lema 1 garante a ação pura prescrita em toda comparação pivotal relevante. A
condição 5 garante que nenhuma proposta pura em `Y` melhora o payoff de
qualquer tipo de `H`; por linearidade, nenhuma distribuição mista sobre `Y`
melhora esse payoff. Todas as transições terminam em acordo imediato ou em um
membro existente de `C_M`. Portanto o assessment é PBE sob o conceito fixado.

**Cobertura.** Necessidade mostra que nenhum PBE fica fora do gerador;
suficiência mostra que o gerador não adiciona assessments espúrios. A
caracterização preserva toda multiplicidade de propostas, crenças permitidas,
seletores e membros de continuação. QED.

Os domínios

```text
D_M^+={d: E_M(d) is nonempty},
D_M^0={d: E_M(d) is empty}
```

são disjuntos e cobrem o domínio primitivo. A primeira célula contém a família
simbólica acima; a segunda é uma célula `none`, sem payoff convencional. A
caracterização é exata e implícita: ela não cria uma seleção ou uma fronteira
paramétrica que o jogo não forneceu.

## 8. Payoffs por tipo, imagem ex ante e outcomes

Para `b in E_M(d)`, o payoff de `H` por tipo é

```text
V_H^theta(b)=integral_Y g_theta(s;b) d sigma_theta(s)
            =max_{s in Y} g_theta(s;b).
```

O conjunto conjunto exato de payoffs por tipo é

```text
P_H^M(d)={(V_H^0(b),V_H^1(b)): b in E_M(d)}.
```

A imagem ex ante para o prior `nu` é

```text
V_H,exante^M(d)=
  {(1-nu)*V_H^0(b)+nu*V_H^1(b): b in E_M(d)}.
```

Ela é a imagem do mesmo binder, não o produto de envelopes marginais. Se
`E_M(d)` é vazio, os dois conjuntos são vazios; nenhum valor fictício é
atribuído.

O payoff do fraco `j`, condicionado ao tipo, é

```text
V_j^theta(b)=integral_Y [
  p_b(s)*x_j
  +(1-p_b(s))*beta*C^theta_{M,j}(c_b(s))
] d sigma_theta(s).
```

A distribuição de outcomes condicionada ao tipo é

```text
Omega_b^theta=
  integral_Y [
    p_b(s)*delta_{immediate_agreement_at_s}
    +(1-p_b(s))*Omega_M^theta(c_b(s))
  ] d sigma_theta(s).
```

A distribuição ex ante usa os pesos `(1-nu,nu)` somente depois de construir as
duas distribuições condicionadas ao tipo.

## 9. Auditoria da prova

```text
GAME CLASS: signaling/bargaining stage with simultaneous pure majority ballot
SOLUTION CONCEPT: PBE under pointwise as-if-pivotal voting and yes at equality
CONTRACT STATUS: approved; author clarification closes the pivotal-vector rule
GRAPH STATUS: acyclic; A_M consumes only frozen C_M
TERMINAL STATES CLOSED: literal members of C_M at the pinned hash
MULTIPLICITY/SELECTION STATUS: full symbolic correspondence; no selection added
NATIVE-TIME AND DISCOUNT CHECK: beta applied exactly once from C_M to A_M
BELIEF CHECK: local Bayes, prior support, weak votes non-signaling
DOWNSTREAM INVALIDATION: a byte change in C_M invalidates this artifact and AC
OVERALL STATUS: implementer proof complete; final package reviews still pending
```

O script mecânico associado testa schemas, hashes, contagem de perfis pivotais,
as desigualdades do Lema 1 em exemplos finitos e a aplicação única de `beta`.
Ele não é prova de existência, completude, mensurabilidade nem otimalidade em
todo `Y`; essas propriedades são sustentadas pelo argumento matemático acima e
permanecem sujeitas às revisões independentes finais do pacote privado.
