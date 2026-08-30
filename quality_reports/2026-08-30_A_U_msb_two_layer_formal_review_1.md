# Parecer formal independente 1 — arquitetura em duas camadas de `A_U`

**Data:** 2026-08-30

**Papel:** parecerista formal independente 1, read-only

**Snapshot:** `be482e329e34e6690211089363358c2399706e52`

**Manifesto:** `quality_reports/2026-08-30_A_U_msb_two_layer_candidate_manifest.sha256`

**SHA-256 do manifesto:**
`3cf2c047ad2da35665c21b47f94ca117482d7e7f537d9caa4e0ddce29ae7b369`

**Veredito:** `PASS — 0 critical / 0 important / 0 minor`

## 1. Independência e preflight

Reconstruí o argumento a frio e em modo estritamente read-only. Não usei
memória, web, parecer do outro revisor nem pareceres históricos de `A_U`. A
adjudicação anterior foi consultada apenas para fixar o conteúdo de `R2-I-1`.
Não editei, criei, apaguei ou commitei arquivos.

Confirmei worktree `/private/tmp/PBP-am-msb`, branch
`agenda-extension-am-msb`, `HEAD` acima e árvore limpa. O hash externo do
manifesto coincidiu e suas 16/16 entradas retornaram `OK`. O commit substantivo
`b56085c436eb629c335764eb982d174e5cc2d392` e o snapshot adjudicado anterior
são ancestrais do `HEAD`.

## 2. Reconstrução estratégica

Para `m=N-1`,

```text
nu_star=(o_1-o_0)/(1-o_0),
ell=beta o_0, h=beta o_1,
d_0=beta^2 o_0, d=beta^2 o_1,
a=beta(1-beta o_0)/m, b=beta(1-beta o_1)/m,
z_L=1-beta+d_0, z_H=1-beta+d,
Delta=z_L-d.
```

O domínio consumível da continuação congelada é
`D_C={0} union (nu_star,1]`; a célula positiva baixa é `none` e não pode
receber payoff fictício. A importação de `C_U` aplica exatamente um fator
externo `beta`.

O voto as-if-pivotal e `T^Y` implicam `x_j>=a` em posterior zero e `x_j>=b`
em posterior alto. Os máximos aceitos de `H` são unicamente
`y_L=(z_L,a,...,a)` e `y_H=(z_H,b,...,b)`, ambos no simplex primitivo.

No prior interior, imitação bilateral iguala `V_0=V_1=V`. Se a massa pública
em posterior zero é positiva, ela força `nu_off=0`, `V=z_L`, `Delta>=0` e
`y_L` como único sinal zero usado; surge `AU-MSB-L`. Se a massa em zero é
nula, Bayes plausibility força `nu>nu_star`. Com `nu_off=0`, obtém-se
`AU-MSB-H0` e `V in [max(z_L,d),z_H]`; com `nu_off>nu_star`, o desvio `y_H`
força pooling eficiente único `AU-MSB-HB`. Rejeição entra no suporte somente
quando `V=d`.

Nos endpoints, `nu=0` fixa `H0` em `y_L` e preserva a correspondência
contrafactual de `H1` segundo o sinal de `Delta`; `nu=1` fixa ambos os tipos em
`y_H`. O payoff fraco contrafactual em uma rejeição com `mu=0,theta=1` é zero,
e não o preço esperado `a`.

O diff contra o candidato adjudicado confirmou que thresholds, payoffs,
famílias `L/H0/HB`, endpoints, atraso, Bayes e exaustão permaneceram
inalterados. A mudança substantiva é somente a interface em duas camadas.

## 3. Espaços e ação de nomes

Para primitivas e `m` fixos, `Y` é simplex compacto polonês. O suporte dos
registros terminais literais dos membros `L/P` é finito em identidades,
alocações canônicas, votos, resultados e payoffs; portanto `Omega_D^U` é
compacto polonês com topologia discreta. A soma topológica

```text
Omega_T^U=({A} x Y) union_disjunta ({D} x Omega_D^U)
```

e o produto

```text
Z_U=Y x [0,1] x {0,1} x {L,P} x Omega_T^U
```

são compactos poloneses. Assim, `P(Z_U)^2` é polonês. A lei
`Gamma_theta^{U,R}` é o pushforward Borel da medida de proposta e do kernel
terminal literal. Funções off-path não realizadas continuam no binder
subjacente e não são fingidas como coordenadas recuperáveis da lei.

`G=S_m` age por uma única permutação comum em todas as coordenadas fracas,
fixando posterior, timing e célula `L/P`. Cada ação é homeomorfismo. O
relabeling preserva factibilidade, payoff, votos, desvios, limite local de
Bayes e continuação anônima; portanto leva PBE a PBE sem impor simetria
comportamental.

## 4. Camada formal exata

Com `x=(Gamma_0,Gamma_1)`, defina

```text
Lambda_x=|G|^{-1} sum_g delta_(g.x).
```

O mapa é Borel — de fato contínuo — porque é média finita de pushforwards por
ações contínuas. A translação `g -> gh` apenas reordena a soma, provando
invariância. Se `Lambda_x=Lambda_x'`, o singleton Borel `{x'}` recebe sob
`Lambda_x'` massa `|Stab_G(x')|/|G|>0`; portanto também recebe massa sob
`Lambda_x`, o que exige `x'=g.x` para algum `g`. A recíproca é imediata.
Logo `Lambda` é completo para a órbita diagonal, inclusive com
estabilizadores.

O mínimo de uma órbita finita sob um isomorfismo Borel é Borel, pertence
realmente à órbita e, pelo fechamento, vem de um PBE relabelado. Não é uma
média de Reynolds nem um seletor no espaço bruto de funções off-path.

Para `0<nu<1`,

```text
nu_off=nu rho/(1-nu+nu rho)
```

é homeomorfismo de `[0,infinity]` em `[0,1]`; `rho` é apenas reparametrização.
Nos endpoints ele é substituído por `*`, sem divisão por prior nulo.

## 5. Resumo econômico e fatorização

O mínimo de cada órbita finita em `Z_U` define uma transversal Borel e o mapa
`q_U:Z_U->Z_U/G`. Para toda `f` Borel e `G`-invariante, definir `f_bar` no
representante mínimo produz a única fatorização Borel
`f=f_bar compose q_U`; a identidade de integrais segue da definição de
pushforward.

Por isso,

```text
Sum_econ_U=(rho,nu_off,(q_U)#Gamma_0,(q_U)#Gamma_1)
```

recupera, por tipo, payoff de `H`, acordo/atraso, lei do posterior, célula
`L/P`, proposta e outcome terminal anônimos, multiconjunto ordenado de payoffs
fracos e payoff de uma identidade fraca sorteada uniformemente. Não recupera
proposta ou payoff nomeado, suporte nomeado, mapa público pointwise,
coincidência de mensagens, relação entre planos contrafactuais ou funções
off-path. O texto declara corretamente esses limites.

## 6. Stress-test `P/Q` e Reynolds

Com `N=3`, `beta=.9`, `o_0=.2`, `o_1=.5`, refiz:

```text
nu_star=.375, a=.369, b=.2475, d=.405,
z_L=.262, z_H=.505, Delta=-.143.
```

Para `V=.45`,

```text
P=(.45,.3025,.2475),
Q=(.45,.2475,.3025)
```

somam 1, passam e pertencem a `H0`. Com prior `.6`, qualquer mistura comum
pelos dois tipos mantém posterior `.6`; fora do suporte, `nu_off=0` dá no
máximo `.405`, inferior a `.45`. Logo são PBEs. Sob `S_2`, o peso `p` é
identificado apenas com `1-p`: `.9` e `.5` têm órbitas exatas distintas, mas
`q_U(P)=q_U(Q)` dá o mesmo resumo econômico. Isso repara `R2-I-1`.

Com prior `.9`, `sigma_0=(.9,.1)` e `sigma_1=(.1,.9)`, Bayes dá
`mu(P)=1/2` e `mu(Q)=81/82`, ambos acima de `.375`. Reynolds leva à mesma
proposta física registros com os dois posteriores; nenhum mapa público
determinístico pode gerar essa lei. Portanto Reynolds não é completo, apaga
relações entre planos, pode não ser assessment e nunca é representante.

## 7. Downstream e evidência mecânica

`A_M` e `A_U` devem ser combinados primeiro na mesma fibra de prior e
`(rho,nu_off)` usando camadas exatas. Substituição pelo resumo exige prova
específica de constância na fibra e fatorização mensurável; correspondências
exigem prova setwise. Operações off-path também usam o binder. Nada aqui
autoriza `AC`, `AR`, manuscrito, tag, merge ou push.

Reexecutei o verificador em modo read-only. O output foi byte a byte idêntico
ao versionado:

```text
MECHANICAL RESULT: PASS | 1110 PASS | 0 FAIL
```

Isso não prova completude de PBE, todo desvio contínuo, Bayes local geral,
provas Borel abstratas, todos os seletores literais ou fatorização downstream.
Esses itens foram auditados textualmente, não inferidos do teste.

## 8. Findings e veredito

Não identifiquei finding critical, important ou minor. Os 31 claims do ledger
foram sustentados em seus escopos; `AUX-MSB-027` permanece corretamente
`pending` por ser gate administrativo.

Este PASS cobre somente os 16 bytes governados pelo manifesto e não congela
`A_U` nem substitui o segundo parecer, a adjudicação ou a aprovação autoral
terminal.

FINAL_STATUS: PASS

COUNTS: 0/0/0
