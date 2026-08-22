# Parecer final independente de desenho formal — ciclo exclusivo de N4

**reviewer_role:** `formal_design`  
**reviewer_id:** `codex-formal-design-n4-final-exclusive-20260821`  
**data:** 2026-08-21  
**nó revisado:** `N4` — R1 sob unanimidade  
**interface_hash:** `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`  
**manifest_hash:** `sha256:5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`  
**finding_counts:** `critical=0; major=0; minor=0`  
**verdict:** `PASS`

## 1. Veredicto

**PASS estrito — 0 findings críticos, 0 major e 0 minor.**

O candidato de N4 reconstrói corretamente R1 sob unanimidade a partir da
interface congelada de N2, lida conjuntamente com a Emenda 1a. A
correspondência exportada é:

| Célula do prior | Existência sob ballots puros | Resultado on-path |
|---|---|---|
| `nu=0` | existe | `L_star`, acordo imediato apenas com `H0` |
| `0<nu<=nu_star` | não existe PBE | certificado por `s_dagger` |
| `nu_star<nu<=1` | existe | `P_star`, acordo pooling imediato |

Nas células de existência, a proposta, o outcome e o payoff on-path são
únicos. No interior alto, pode haver multiplicidade de crenças fora do perfil,
mas apenas dentro das restrições de incentivo registradas. Nos endpoints, a
restrição de suporte fixa a crença e deixa um único perfil puro de ballot após
cada proposta factível. Não há mistura on-path.

Este parecer não reabre, rerevisa nem emite veredicto sobre N3. As passagens de
N3 em artefatos compartilhados foram lidas apenas para controlar a fronteira de
escopo; nenhum resultado de N3 é certificado aqui.

## 2. Independência, escopo e método

O revisor não implementou nem alterou os oito artefatos submetidos, a decisão,
o contrato, o manifesto, o script, o DAG ou qualquer candidato. A única escrita
deste ciclo é este parecer.

Foram lidos integralmente:

1. `AGENTS.md`;
2. `quality_reports/plans/2026-08-12_essential_input_gate0.md`;
3. `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md`;
4. os oito arquivos enumerados no manifesto N4;
5. `quality_reports/2026-08-21_reparo_fd_sup_min_01.md`.

A revisão seguiu reconstrução manual desde as primitivas e N2, inspeção de
consistência entre Markdown, JSON, ledger, matriz e relatório, e somente checks
algébricos e enumerações finitas dirigidas. Não houve mutação exaustiva por
folha, fuzzing de schema ou tentativa de fazer o verificador certificar sua
própria correção.

## 3. Integridade dos bytes submetidos

O SHA-256 do próprio manifesto é exatamente
`5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`.
`shasum -a 256 -c` confirmou os oito itens:

| Artefato | SHA-256 confirmado |
|---|---|
| interface congelada N2 | `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` |
| decisão/Emenda 1a | `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69` |
| derivação Markdown N4 | `4cc246d1fadaeb18b90ae9956fa08e96d576f6e0821b521493a3ba47074dab1e` |
| interface JSON N4 | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| ledger N4 | `13964b436efa5983dcc39fe8dee09d298a1e1421cc7ee383a7b37fbda100067b` |
| matriz de sobrevivência | `90e2a467d38453a9cad5942da90d95e3cba9e064761b85adf44d0a3759c0577c` |
| relatório consolidado | `1b324c0eb0e03e8c42aa9494dcfbbc1e3c69947a2dfa92d3a92f33783ba4eba8` |
| verificador dirigido | `90c30f217e9c87251905ddd213a2d6ddb5207dd591692ac745c5563e4dce590c` |

O hash pedido para a interface N4, portanto, também confere exatamente.

## 4. Hierarquia normativa reconstruída

A fonte substantiva é o contrato Gate 0, alterado apenas no conceito de
solução pela decisão autoral de 2026-08-21 e pela Emenda 1a. N4 consome somente
N2; não consome N3.

As regras efetivas usadas na reconstrução são:

- ballots simultâneos, selados e puros; o proponente fraco conta como `sim`;
- unanimidade exige `sim` de `H` e de todos os fracos;
- desvios de proposta ou voto de fraco não atualizam `theta`;
- ação prescrita de `H` atualiza estruturalmente por Bayes;
- desvio de `H` no interior admite posterior em `[0,1]`;
- em `nu=0`, todo posterior é `0`; em `nu=1`, todo posterior é `1`;
- fracos votam as-if-pivotal e `T^Y` seleciona `sim` na igualdade esperada;
- `H` satisfaz racionalidade sequencial e o mesmo `T^Y` na igualdade;
- R2 está em unidades correntes; uma continuação de R2 recebe exatamente um
  fator `beta` quando comparada em R1.

Não foi introduzida seleção, crença, ação ou transição adicional.

## 5. Reconstrução matemática independente

### 5.1 Continuação N2 e desconto

Defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m.
```

Das primitivas, `0<nu_star<1`, `0<B<A` e `0<ell<h`. A interface N2 dá:

- screening para posterior `eta<=nu_star`: valor fraco transportado
  `(1-eta)A` e payoffs de `H` iguais a `(ell,h)`;
- pooling para `eta>nu_star`: valor fraco `B` e payoffs de `H` iguais a
  `(h,h)`.

A identidade de junção é `(1-nu_star)A=B`. O valor corrente de um fraco é
`C=(1-nu)A` abaixo ou na fronteira e `C=B` acima dela. O vetor realizado no
screening é `(A,0)`, e não `(A,A)`. Cada um de `ell`, `h`, `A` e `B` contém o
único fator `beta`; nenhuma fórmula de N4 o reaplica.

### 5.2 Crenças, no-signaling e voto fraco

Se `eta_Y` é o posterior após o `sim` de `H`, a comparação pivotal de cada
respondente fraco é

```text
sim  iff  x_j >= W(eta_Y),
W(eta) = (1-eta)A  se eta<=nu_star;
         B         se eta>nu_star.
```

Logo `W(eta)` percorre exatamente `[B,A]`. A igualdade pertence ao acordo e o
veto exige desigualdade estrita. A oferta `A` força `sim` sob toda crença
admissível. O resultado vale identidade por identidade: com `m>=3`, cada
possível membro de um conjunto de vetantes obedece ao mesmo cutoff; com `m=2`,
o único respondente obedece à mesma regra, sem fórmula especial.

### 5.3 Classes de outcome e estratégias de `H`

Sob unanimidade, os outcomes puros possíveis são pooling `P`, passagem apenas
com o tipo baixo `L`, ou falha/delay `D`. Passagem apenas com o tipo alto não
satisfaz as ICs.

Pooling exige `Y>=h` e os cutoffs fracos correspondentes. Separação `H0=sim,
H1=não` é impossível para todo prior positivo: no interior, `H0` imita o
`não` revelador de `H1` e obtém `h`, enquanto `H1` só rejeita se `Y<h`; em
`nu=1`, o suporte singleton faz ambos os tipos compararem com `h`. A classe
`L` sobrevive somente em `nu=0`, com `ell<=Y<h` e `x_j>=A`.

Se algum fraco veta, o resultado falha independentemente do voto de `H`.
`T^Y` força `H1` a `sim`; a IC ou a restrição de suporte força também `H0` a
`sim`. Portanto o único perfil de `H` nesse ramo é `(sim,sim)`, o posterior
realizado permanece `nu` e cada fraco veta exatamente quando `x_j<C`.

Se todos os fracos votam `sim`, um veto pooling de `H` é localmente sustentável
nas fronteiras estritas registradas:

```text
nu=0:               u>=A e Y<ell;
0<nu<=nu_star:      u>=B e Y<ell;
nu_star<nu<=1:      u>=B e Y<h,
```

onde `u=min_j x_j`. Todo delay realizado preserva o posterior corrente e paga
`C` ao proponente.

### 5.4 Completamento após toda proposta factível

Nos dois domínios de existência, a variável `r_i` não afeta o ballot e a
partição por `(u,Y)` cobre toda proposta factível.

Em `nu=0`:

- `u<A`: `(sim,sim)`, com cada fraco votando `sim` iff `x_j>=A`;
- `u>=A` e `Y<ell`: `(não,não)`;
- `u>=A` e `ell<=Y<h`: `(sim,não)`;
- `u>=A` e `Y>=h`: `(sim,sim)`.

Todo posterior é zero. As regiões são disjuntas e exaustivas. Em particular,
`B<=u<A, Y<ell` contém veto fraco e somente `(sim,sim)`: o antigo perfil
`(não,não)` dependia de ressuscitar o tipo fora do suporte.

Em `nu_star<nu<1`:

- `u<B`: `(sim,sim)`, com veto de ao menos um fraco;
- `u>=B` e `Y<h`: `(não,não)` e todos os fracos em `sim`;
- `u>=B` e `Y>=h`: `(sim,sim)` e aprovação.

No ramo `(não,não)`, a crença após o `sim` fora do perfil deve satisfazer
`W(eta_Y)<=u`. Para `B<=u<A`, isso equivale a
`eta_Y>=1-u/A`; para `u>=A`, qualquer crença serve. No ramo `(sim,sim)`, a
crença após `não` pode variar em `[0,1]`. Assim, o perfil puro é único proposta
a proposta, mas a multiplicidade admissível de crenças não é apagada nem
exportada como irrestrita quando violaria as ICs.

Em `nu=1`, a mesma partição estratégica alta vale, mas `eta_Y=eta_N=1` em toda
a árvore. Não há multiplicidade de crenças nem perfil separating adicional.

### 5.5 Certificado de inexistência em `0<nu<=nu_star`

A proposta

```text
s_dagger = (Y=ell, x_j=A para todo j,
            r_i=Q_L=1-ell-(m-1)A)
```

é factível, usa toda a pie e satisfaz `Q_L-A=1-beta>0`. Como `A` é o máximo de
`W`, todos os fracos votam `sim` em qualquer perfil puro de `H`. A enumeração é
completa:

- `(sim,sim)`: `H1` prefere desviar para `não`, obtendo `h>ell`;
- `(não,não)`: `H0` empata em `ell` e `T^Y` exige `sim`;
- `(sim,não)`: `H0` imita o `não` de `H1` e obtém `h>ell`;
- `(não,sim)`: `H1` imita o `não` de `H0` e obtém `h>ell`.

Logo esse ballot não possui resposta pura sequencialmente racional. Como PBE
deve completar também propostas fora do caminho, a inexistência é do jogo
completo em `0<nu<=nu_star`, inclusive na igualdade e inclusive para `m=2`.

### 5.6 Existência, otimalidade e unicidade on-path

Em `nu=0`,

```text
L_star: Y=ell, x_j=A, r_i=Q_L=A+1-beta.
```

Os fracos aceitam na fronteira, `H0` aceita na fronteira e `H1` rejeita. Todo
outro `L` custa pelo menos o mesmo; pooling custa adicionalmente `h-ell`; delay
paga `A`. Como `Q_L-A=1-beta>0`, `L_star` é o único ótimo on-path.

Em `nu_star<nu<=1`,

```text
P_star: Y=h, x_j=B, r_i=Q_P=B+1-beta.
```

Os fracos e `H1` aceitam na fronteira e `H0` aceita. Separação não sobrevive.
Todo pooling custa pelo menos `h+(m-1)B`, enquanto delay paga `B`. Como
`Q_P-B=1-beta>0`, `P_star` é o único ótimo on-path.

As duas propostas usam integralmente a pie. Qualquer proposta aprovada com
folga pode aumentar `r_i` sem alterar o ballot, e por isso não é ótima. A
diferença estrita `1-beta` exclui mistura on-path entre acordo e delay.

### 5.7 Contabilidade por tipo e identidade

Em `nu=0`, o vetor fraco condicional a `theta=0` é
`(Q_L,A,...,A)`; condicional ao tipo alto contrafactual, R1 falha e N2 screening
gera o vetor zero. Antes do reconhecimento, uma identidade fraca recebe
`(1-ell)/m` no tipo baixo e zero no alto. `H` recebe `(ell,h)`.

Na célula alta, o vetor fraco é `(Q_P,B,...,B)` nos dois tipos; antes do
reconhecimento, cada identidade recebe `(1-h)/m`. `H` recebe `(h,h)`. Não há
aprovação sem `H`, atraso ou falha com probabilidade positiva on-path nas
células de existência.

## 6. Coerência entre Markdown, JSON, ledger e matriz

- O JSON contém exatamente as três células, incluindo a célula vazia com o
  certificado `N4-C08`.
- Os registros existentes mantêm estratégia, crenças, fontes N2, payoffs por
  tipo, outcome e data dentro do mesmo objeto.
- A multiplicidade off-path alta é restringida pelas ICs; os endpoints não
  exportam crenças fora do suporte.
- O ledger contém 15 claims com número constante de campos e os liga às
  demonstrações correspondentes.
- A matriz classifica corretamente como corrigidos ou removidos o piso `B`
  uniforme, o veto fechado, `S_3`, a fórmula especial de `m=2`, o delay geral e
  as misturas; registra como novo o intervalo sem PBE puro.
- O relatório consolidado coincide com a derivação N4 nas células, fronteiras,
  contabilidade e estatuto. Suas passagens sobre N3 não recebem veredicto neste
  ciclo.

## 7. Fechamento de `FD-SUP-MIN-01`

O finding anterior dizia, em essência, que a contradição
`Y<ell<h<=Y` havia sido estendida indevidamente ao endpoint `nu=1`; ali a
restrição de suporte fixa posterior um e a contradição correta é `Y<h<=Y`.

O reparo está fechado:

- o relatório consolidado agora restringe `Y<ell<h<=Y` a `0<nu<1`;
- apresenta separadamente `nu=1`, onde ambos os tipos comparam `Y` com `h` e
  `T^Y` elimina a separação na igualdade;
- a derivação N4 e o JSON já contêm o tratamento endpoint compatível;
- nenhum posterior positivo para o tipo de prior zero é usado em `nu=0`, e
  nenhum posterior menor que um é usado em `nu=1`.

Assim, `FD-SUP-MIN-01` não reaparece como finding deste ciclo.

## 8. Checks dirigidos executados

O script congelado retornou, na parte pertinente a N4:

```text
MODEL_PROOF_DIRECTED: PASS — N4 60 avaliações de fronteira.
ALGEBRA_IDENTITIES: PASS — factibilidade, cutoffs, Q_L-A e Q_P-B.
FINITE_ENUMERATION: PASS — quatro perfis puros de H, suporte nos endpoints,
ausência de overlap e negativos representativos.
```

A saída referente a N3 do mesmo script foi ignorada para fins de veredicto.
Adicionalmente, o JSON foi parseado com três células, o ledger passou o teste de
15 linhas com número constante de campos, e os hashes do manifesto, interface e
relatório reparado foram reconfirmados. Esses checks são evidência auxiliar; o
PASS decorre da reconstrução humana acima.

## 9. Findings transcritos e contagens

Nenhum finding novo foi identificado.

```text
critical = 0
major    = 0
minor    = 0
```

**VEREDICT: PASS — critical=0, major=0, minor=0.**

O PASS incide somente sobre a interface N4 de hash
`f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`
no manifesto de hash
`5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`.
Não congela o nó por si só, não integra o DAG, não autoriza N6 e não contém
revisão substantiva de N3 ou N4 público.
