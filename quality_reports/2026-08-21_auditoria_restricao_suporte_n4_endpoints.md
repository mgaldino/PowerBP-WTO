# Auditoria da restrição de suporte nos endpoints de N4

**Data:** 2026-08-21  
**Status:** auditoria concluída; candidatos permanecem `pending/unfrozen`  
**Worktree exclusiva:** `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`  
**Branch:** `codex/essential-input-solution-concept-rederive`  
**HEAD administrativo:** `a6fd6bd543e9cefd4166581b80565916509e95a6`  
**Objeto:** somente a decisão autoral posterior sobre suporte, seus efeitos
forçados nos registros de N4 e a consistência declaratória do pacote candidato  
**Fora do escopo:** nova rederivação de N3/N4, freeze, integração ao DAG, N6,
N7, comparação institucional, figuras, PDF e manuscrito

## 1. Veredicto executivo

A auditoria read-only anterior a qualquer edição encontrou uma violação real.
No candidato então vigente, o completamento `(não,não)` de `H` em

```text
nu=0,  B<=min_j x_j<A,  Y<ell
```

era sustentado por um posterior `eta_Y>0` depois do voto `sim` fora do
perfil. Isso atribuía probabilidade positiva ao tipo `H1`, embora seu prior
fosse zero. A construção exigia precisamente

```text
eta_Y >= 1-min_j(x_j)/A > 0,
```

e, portanto, era incompatível com a Opção A emendada.

O reparo pontual removeu esse completamento e fixou todas as crenças em zero
quando `nu=0` e em um quando `nu=1`. A antiga sobreposição desaparece. A
proposta `L_star`, a proposta `P_star`, seus payoffs, o accounting por tipo e
o certificado de inexistência em `0<nu<=nu_star` não mudam.

Após o reparo, nenhum dos registros candidatos atribui posterior positivo ao
tipo de prior zero. Contudo, a única rerevisão dirigida terminou com um
finding **minor** de exposição no relatório consolidado: uma contradição usada
para excluir separação inversa foi enunciada como se também valesse em
`nu=1`, quando o argumento próprio desse endpoint é `Y<h<=Y`. Os artefatos
formais separados e os resultados substantivos estão corretos, mas os bytes
rerevisados foram preservados. Assim, o veredicto agregado é:

```text
critical: 0
major:    0
minor:    1

NOT PASS
```

Esse finding não reabre a matemática econômica, mas impede declarar o pacote
integralmente aprovado ou congelá-lo.

## 2. Decisão autoral auditada

A decisão posterior estabelece:

1. se o denominador de Bayes é zero, o posterior permanece no suporte do
   prior;
2. um tipo com prior zero nunca recebe posterior positivo;
3. `nu=0` implica posterior zero em toda a árvore;
4. `nu=1` implica posterior um em toda a árvore;
5. apenas para `0<nu<1`, um desvio de `H` pode receber qualquer posterior em
   `[0,1]`, sujeito às demais regras de crença e às restrições de incentivos;
6. Opção B e Opção A literal estão descartadas.

A auditoria tratou essa decisão como uma restrição sobre assessments, não como
uma nova primitiva de payoff ou uma seleção de equilíbrio.

## 3. Objetos e notação

Considere uma proposta factível de R1 sob unanimidade. O pagamento a `H` é
`Y`; o pagamento ao respondente fraco `j` é `x_j`; e

```text
u       = min_j x_j,
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m.
```

Das primitivas, `0<B<A` e `0<ell<h`. Se o posterior na entrada de N2 é
`eta`, o valor de continuação de um fraco em unidades de R1 é

```text
W(eta) = (1-eta)A,  se eta<=nu_star;
         B,         se eta>nu_star.
```

O voto fraco é avaliado como se pivotal. Logo, depois do voto `sim` de `H`,
o fraco `j` vota `sim` se e somente se `x_j>=W(eta_Y)`. A igualdade leva a
`sim` por `T^Y`.

As estratégias puras de `H` são escritas como

```text
(ação de H0, ação de H1)
```

e pertencem a `{(sim,sim),(não,não),(sim,não),(não,sim)}`.

## 4. Método: exaustão por construção matemática

A auditoria não gerou mutações de schema. Para cada endpoint, ela:

1. fixou o posterior permitido pelo suporte depois de toda proposta, todo voto
   fraco e cada ação de `H`;
2. derivou o cutoff fraco na comparação pivotal;
3. separou as histórias com algum veto fraco das histórias em que todos os
   fracos votam `sim`;
4. enumerou os quatro perfis puros de `H`;
5. aplicou preferência estrita e `T^Y` nas fronteiras;
6. comparou a partição obtida com cada registro Markdown, JSON, ledger, matriz,
   relatório e teste dirigido.

Essa construção é exaustiva porque todo ballot puro de `H` pertence a um dos
quatro perfis e, sob unanimidade, o desfecho depende apenas de haver ou não
algum veto fraco e do voto de `H` quando todos os fracos votam `sim`.

## 5. Readback das histórias e crenças endpoint

### 5.1 Histórias comuns aos dois endpoints

| História pública | Regra de crença em `nu=0` | Regra de crença em `nu=1` |
|---|---:|---:|
| após qualquer proposta fraca, prescrita ou desviante | `0` | `1` |
| após qualquer vetor de votos fracos, prescrito ou desviante | `0` | `1` |
| após `H` votar `sim`, com probabilidade positiva | `0` por Bayes | `1` por Bayes |
| após `H` votar `não`, com probabilidade positiva | `0` por Bayes | `1` por Bayes |
| após `H` votar `sim`, com denominador zero | `0` por suporte | `1` por suporte |
| após `H` votar `não`, com denominador zero | `0` por suporte | `1` por suporte |
| após ação de tipo de `H` com prior zero | `0` | `1` |

Portanto, nenhuma proposta, voto fraco, ação prescrita ou desvio de `H` pode
tirar o posterior do singleton `{0}` ou `{1}` no endpoint correspondente.

### 5.2 Consequência para os cutoffs fracos

Em `nu=0`, `eta_Y=0` em toda história, logo

```text
W(eta_Y)=W(0)=A.
```

Em `nu=1`, `eta_Y=1` em toda história, logo

```text
W(eta_Y)=W(1)=B.
```

Assim, o voto fraco é determinado sem liberdade de crença:

| Endpoint | voto `sim` de `j` | veto de `j` |
|---|---|---|
| `nu=0` | `x_j>=A` | `x_j<A` |
| `nu=1` | `x_j>=B` | `x_j<B` |

As fronteiras `x_j=A` e `x_j=B` pertencem ao acordo por `T^Y`.

## 6. Construção exaustiva em `nu=0`

### 6.1 Algum fraco veta: `u<A`

Se `u<A`, a proposta falha qualquer que seja o voto de `H`. Cada tipo de `H`
obtém a mesma continuação ao votar `sim` ou `não`. Como o posterior permanece
zero depois de ambas as ações, `T^Y` determina `sim` para cada tipo. Portanto,

```text
u<A  =>  H=(sim,sim).
```

Esse argumento inclui toda a antiga região
`B<=u<A, Y<ell`: nela há veto fraco e não há veto de `H`.

### 6.2 Todos os fracos votam `sim`: `u>=A`

Com `u>=A`, a proposta passa se `H` votar `sim`. O posterior de continuação
continua zero se `H` votar `não`. Logo:

- `H0` compara `Y` com `ell` e vota `sim` em `Y>=ell`;
- `H1` compara `Y` com `h` e vota `sim` em `Y>=h`.

As igualdades pertencem a `sim`. Isso produz a partição completa:

| Perfil de `H` | Condição necessária e suficiente | Resultado |
|---|---|---|
| `(sim,sim)` | `u<A`, ou `u>=A` e `Y>=h` | veto fraco no primeiro ramo; acordo no segundo |
| `(não,não)` | `u>=A` e `Y<ell` | veto de `H` |
| `(sim,não)` | `u>=A` e `ell<=Y<h` | acordo somente com `H0` |
| `(não,sim)` | nunca | viola preferência estrita ou `T^Y` |

As quatro linhas são mutuamente exclusivas e exaustivas. O perfil puro, os
votos fracos e a crença são únicos proposta a proposta.

### 6.3 Diagnóstico da antiga sobreposição

Antes da emenda, o completamento `(não,não)` era declarado admissível em
`u>=B,Y<ell`. Para fazer todos os fracos aceitarem quando `B<=u<A`, ele
escolhia uma crença fora do perfil `eta_Y` tal que

```text
W(eta_Y)<=u.
```

No ramo screening de `W`, isso equivale a

```text
(1-eta_Y)A<=u
eta_Y>=1-u/A.
```

Como `u<A`, o lado direito é estritamente positivo. Mas a restrição de suporte
impõe `eta_Y=0`. Portanto,

```text
W(eta_Y)=A>u,
```

algum fraco veta, `H` fica não pivotal e `T^Y` exige `(sim,sim)`. O antigo
`(não,não)` não é um assessment admissível.

## 7. Construção exaustiva em `nu=1`

### 7.1 Algum fraco veta: `u<B`

Se `u<B`, a proposta falha sob qualquer voto de `H`. O posterior permanece um
depois de cada ação e ambos os tipos registrados recebem a mesma continuação
`h`. `T^Y` determina `sim` para ambos:

```text
u<B  =>  H=(sim,sim).
```

### 7.2 Todos os fracos votam `sim`: `u>=B`

Com `u>=B`, ambos os tipos registrados comparam o pagamento `Y` com a
continuação `h`. Assim:

- se `Y>=h`, ambos votam `sim`;
- se `Y<h`, ambos votam `não`.

Em `Y=h`, `T^Y` determina `sim`. A partição completa é:

| Perfil de `H` | Condição necessária e suficiente | Resultado |
|---|---|---|
| `(sim,sim)` | `u<B`, ou `u>=B` e `Y>=h` | veto fraco no primeiro ramo; acordo no segundo |
| `(não,não)` | `u>=B` e `Y<h` | veto de `H` |
| `(sim,não)` | nunca | ambos comparam `Y` com `h` |
| `(não,sim)` | nunca | ambos comparam `Y` com `h` |

Não há crença livre, separação nem multiplicidade de estratégia no endpoint
alto. Em particular, em `P_star`, `Y=h` e `x_j=B`, de modo que todos votam
`sim`.

## 8. Evidência por registro

O manifesto pré-emenda tinha SHA-256
`4cbc5b729eb12bf8b3d3c67cd4b4169e2259aa8e90e6f966e9754436d7d69333`.
A auditoria encontrou a mesma violação representada, diretamente ou por
referência, nos seguintes objetos de N4:

| Registro pré-emenda | Evidência da incompatibilidade | Reparação forçada |
|---|---|---|
| N4 Markdown | preservava `(não,não)` em `B<=u<A,Y<ell` mediante `eta_Y>0` | fixa `eta_Y=eta_N=0`, remove o ramo e separa as tabelas endpoint |
| N4 JSON | exportava crença fora do perfil capaz de satisfazer `W(eta_Y)<=u` em `nu=0` | restringe todas as histórias a posterior zero e exige `u>=A` para `(não,não)` |
| ledger N4 | descrevia completamento/multiplicidade sob a correspondência anterior | registra unicidade endpoint e a prova específica de `nu=1` |
| matriz de sobrevivência | classificava a sobreposição como multiplicidade pura sobrevivente | marca sua remoção e restringe multiplicidade de crenças ao interior |
| relatório consolidado | reproduzia a sobreposição e a liberdade endpoint | substitui pela partição de suporte singleton |
| script R dirigido | permitia `free_eta` em ação de denominador zero no endpoint | aplica suporte antes de Bayes livre e rejeita o antigo `(não,não)` |

A inspeção do pacote também encontrou duas declarações de crença em N3 — no
Markdown e no JSON — que ainda permitiam posterior fora do suporte nos
endpoints. Como a decisão diz “em toda a árvore”, essas duas declarações foram
ajustadas sem alterar qualquer fórmula, estratégia, payoff, outcome ou claim
do ledger N3. O ledger N3 foi preservado byte a byte.

Não foram alterados N1, N2, as fontes históricas ou normativas, os pareceres
anteriores, AGENTS.md, CLAUDE.md, o DAG ou qualquer artefato downstream.

### 8.1 Limite de proveniência: texto congelado de N2

A checagem da fronteira de dependência encontrou uma ressalva que deve ficar
explícita. A interface, a derivação e o ledger **congelados** de N2 ainda dizem
que, depois de proposta de probabilidade zero, “qualquer crença em `[0,1]`” é
admissível. Lida literalmente nos endpoints, essa frase histórica é mais ampla
que a decisão autoral posterior.

Esses arquivos não são registros candidatos de N4 e não foram editados, porque
N2 está congelado e a autorização desta auditoria é para N4. N4 consome os
valores e as estratégias terminais de N2, que são invariantes à crença, e
restringe o completamento efetivamente usado ao subconjunto admissível:

```text
nu=0: somente eta=0;
nu=1: somente eta=1.
```

Logo, nenhum assessment selecionado ou exportado pelo candidato N4 usa o
posterior proibido, e a matemática terminal importada não muda. Mas não se deve
afirmar que **todo texto upstream** já foi retroativamente harmonizado: fazê-lo
exigiria uma errata própria nos bytes congelados de N2, novo hash da interface
e propagação explícita da dependência. Isso está fora do escopo autorizado e
permanece como nota de proveniência, não como reparo silencioso.

## 9. Hashes antes e depois

| Artefato candidato | SHA-256 pré-emenda | SHA-256 pós-reparo |
|---|---|---|
| N3 Markdown | `d1efa9a18b170c45e0ad6a0525e3edca36f8bb58d91e7d66f12b4094953d0bed` | `75931253fd04303420b2d17552f60d9ee6fc2bf108f8b7ff03ada2eeed9201d3` |
| N3 JSON | `5c3caa60f419246f5923721ad1c38f195b7b86aea12de4ec6ab32c90f869a865` | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| N3 ledger | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` | `70e42a39cd4ac7f66820647933e6da8669a14b036b591e04d3dba3381b1c4a67` |
| N4 Markdown | `23eb5de8003e097323daf13bad1cf9370e5220b8daf72ce2ce9c0c88df16ff23` | `0aa31123f1bb2b785e8fbb25001b70275d91f1984c913022f0aef085b02f7b34` |
| N4 JSON | `c5347c1298ed1cd1c18540813131a3003afe6b857a3eb741f34587840362665e` | `a99b6c44463e7e347703c70c5d831f4e7b6e08eeb1cab40b00ef3e7e3def5c82` |
| N4 ledger | `3d236377a87af1cf5dd69d57eb46d8a2a505999f81429588799edf8f6f6fa05f` | `13964b436efa5983dcc39fe8dee09d298a1e1421cc7ee383a7b37fbda100067b` |
| matriz de sobrevivência | `d00c7678362b5d10d03ebcd40c954d76dcb6461fd117bc30a0091b92f52ae662` | `90e2a467d38453a9cad5942da90d95e3cba9e064761b85adf44d0a3759c0577c` |
| relatório consolidado | `f18c32fa33b950cbcd8262407c77b4cd8ac7d18d00963591c1bf47b347acfd6b` | `ffeac731021db83906da0b9b2bedc08e694c4a581a6b30ce6ce5d5ae51bcd207` |
| script R | `8c5e2800d0210245c150560bc505519b6d0605f9cd57d63b953cf42346b70dd0` | `90c30f217e9c87251905ddd213a2d6ddb5207dd591692ac745c5563e4dce590c` |

Oito dos nove candidatos mudaram. O N3 ledger não era afetado e preservou o
hash. O manifesto pós-reparo tem SHA-256:

```text
d0a5a98ee7fdb9f28e778b71de5ea98657af81c849fb942dba7bce5fa548eec4
```

## 10. Verificações dirigidas

### 10.1 Prova e modelo

- enumeração humana dos quatro perfis de `H` nos dois endpoints;
- partições mutuamente exclusivas e exaustivas para `nu=0` e `nu=1`;
- checagem separada das histórias com veto fraco e com todos os fracos em
  `sim`;
- verificação das quatro fronteiras `x_j=A`, `x_j=B`, `Y=ell` e `Y=h`;
- confirmação de que nenhum posterior endpoint sai do suporte;
- confirmação de que `L_star`, `P_star` e `s_dagger` permanecem matematicamente
  inalterados.

### 10.2 Cálculos algébricos dirigidos

O script pequeno verificou apenas identidades, fronteiras e enumeração finita.
Ele passou com:

```text
MODEL_PROOF_DIRECTED: PASS
ALGEBRA_IDENTITIES: PASS
FINITE_ENUMERATION: PASS
```

Os checks endpoint incluem representantes de cada célula das duas partições e
um teste negativo explícito que rejeita `(não,não)` na antiga região de
sobreposição.

### 10.3 Integridade simples

- os nove hashes do manifesto pós-reparo conferem;
- os dois JSON passam no parser;
- CSV e TSV preservam shape e IDs únicos;
- `git diff --check` passa;
- as interfaces N1 e N2 permanecem nos hashes congelados consumidos;
- nenhum arquivo de DAG, N6, N7, comparação, figura, PDF ou manuscrito foi
  alterado.

Não houve fuzzing, mutação em massa, verifier-of-verifier nem endurecimento de
serialização.

## 11. Única rerevisão dirigida

Os mesmos dois papéis independentes fizeram exatamente uma rerevisão
read-only dos nove bytes vinculados ao manifesto pós-reparo.

| Papel | Veredicto | Findings | Resultado |
|---|---|---:|---|
| `game_theory` | PASS | `0/0/0` | confirmou as duas partições endpoint, remoção da sobreposição, `L_star`, `P_star`, inexistência e invariância de N3 |
| `formal_design` | NOT PASS | `0/0/1` | encontrou apenas `FD-SUP-MIN-01` na prova resumida do relatório consolidado |

Hashes dos pareceres:

```text
6dbc7442dc3a6ce145a8e195c3402b17de834b42e0f80aa921c8790f6664b330  formal_design
4bbd0ed6fefbfcf1247d1cb40594e5ebf9a879e8315b5d6c8f1ec390e5190d87  game_theory
```

### Finding residual `FD-SUP-MIN-01`

Na seção 6.3 do relatório consolidado, a frase sobre separação inversa diz,
sem restringir o domínio, que ela exigiria

```text
Y<ell<h<=Y.
```

Esse argumento vale no interior `0<nu<1`. Em `nu=1`, o suporte fixa posterior
um também depois da ação do tipo de prior zero; ambos os tipos comparam `Y`
com `h`, e a contradição correta é

```text
Y<h<=Y.
```

O N4 Markdown separado, o JSON, o ledger, a matriz e o script já apresentam o
argumento endpoint correto. O finding não muda correspondência, payoff,
existência ou accounting. Como o único ciclo de rerevisão autorizado já foi
consumido, os bytes rerevisados não foram editados novamente.

## 12. Impacto e stop condition

### O que mudou

- crenças endpoint agora respeitam o suporte em todas as histórias;
- o cutoff em `nu=0` é sempre `A`, inclusive depois de ação de `H` com
  denominador zero;
- o cutoff em `nu=1` é sempre `B`;
- a antiga multiplicidade pura em `B<=u<A,Y<ell` foi removida;
- a multiplicidade de crenças permanece somente no interior `0<nu<1`, sujeita
  às restrições de incentivos.

### O que não mudou

- N3 econômico;
- as interfaces congeladas N1 e N2;
- `L_star` e `P_star`;
- payoffs e accounting por tipo;
- a inexistência de PBE puro em `0<nu<=nu_star`;
- ausência de mistura on-path, caso `m=2` e fronteiras abertas de veto;
- status `pending/unfrozen`.

### Estado final desta auditoria

A violação de suporte foi localizada e reparada. Nenhum registro candidato
remanescente atribui posterior positivo ao tipo de prior zero. Ainda assim, o
pacote não recebe PASS agregado por causa de uma qualificação menor na síntese
consolidada. Corrigi-la e obter nova rerevisão exigem autorização separada.

N3 e N4 foram deixados `pending/unfrozen`. Não houve freeze, integração ao
DAG, abertura de N6/N7 ou alteração de manuscrito.
