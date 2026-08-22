# Parecer final independente de N4 — teoria dos jogos

**reviewer_role:** `game_theory`  
**reviewer_id:** `codex-game-theory-n4-final-20260821`  
**independência:** revisor read-only; não implementou nem editou os candidatos submetidos  
**escopo:** ciclo exclusivo de `N4`; `N3` não foi reavaliado neste parecer  
**manifesto revisado:** `sha256:5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`  
**interface N4 revisada:** `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`  
**dependência N2 consumida:** `sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`, lida com a errata `sha256:94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69`  
**veredicto:** `PASS`  
**finding_counts:** `critical=0; major=0; minor=0`

## 1. Snapshot, integridade e escopo

Revisei a worktree
`/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`, na
branch `codex/essential-input-solution-concept-rederive` e no `HEAD`
`a6fd6bd543e9cefd4166581b80565916509e95a6`.

Antes da auditoria matemática, confirmei:

- o SHA-256 do manifesto exclusivo de N4:
  `5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`;
- o SHA-256 da interface N4:
  `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`;
- todas as oito entradas do manifesto por `shasum -a 256 -c`, sem
  divergência.

Os bytes manifestados foram:

| Objeto | SHA-256 |
|---|---|
| interface N2 congelada | `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2` |
| decisão e errata de conceito de solução | `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69` |
| derivação N4 em Markdown | `4cc246d1fadaeb18b90ae9956fa08e96d576f6e0821b521493a3ba47074dab1e` |
| interface N4 em JSON | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| ledger N4 | `13964b436efa5983dcc39fe8dee09d298a1e1421cc7ee383a7b37fbda100067b` |
| matriz de sobrevivência | `90e2a467d38453a9cad5942da90d95e3cba9e064761b85adf44d0a3759c0577c` |
| relatório consolidado | `1b324c0eb0e03e8c42aa9494dcfbbc1e3c69947a2dfa92d3a92f33783ba4eba8` |
| verificador dirigido | `90c30f217e9c87251905ddd213a2d6ddb5207dd591692ac745c5563e4dce590c` |

Li integralmente `AGENTS.md`, o contrato Gate 0, a decisão/errata de
2026-08-21, o manifesto e cada um dos seus oito arquivos. Li também o registro
de reparo `FD-SUP-MIN-01`. A reconstrução abaixo usa somente as primitivas, N2
mais a errata e o conceito de solução autoral. Nenhum resultado de N3 serve de
premissa ou evidência neste parecer.

## 2. Jogo auditado e transporte de N2

O objeto é um jogo bayesiano dinâmico de bargaining com proposta por um weak
state, ballot unanimista simultâneo e selado, tipo privado de `H` e uma única
continuação terminal N2. O proponente conta como `sim`; todos os `m-1`
respondentes fracos e `H` votam simultaneamente. Sob unanimidade, a proposta só
passa se todos eles votarem `sim`.

Defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m.
```

Como `0<o_0<o_1<1` e `beta` pertence a `(0,1)`, vale

```text
0<nu_star<1,   0<B<A,   0<ell<h,
(1-nu_star)A=B.
```

N2 está em unidades correntes de R2. Seu registro low-type-only dá a cada weak
state, antes do novo reconhecimento e condicionado ao tipo, o vetor de
continuação `(A,0)` em unidades de R1 e a `H` o vetor `(ell,h)`; seu registro
pooling dá `(B,B)` aos fracos e `(h,h)` a `H`. Portanto o valor esperado
corrente de continuação de qualquer weak state é

```text
D(nu) = (1-nu)A,
C(nu) = D(nu), se nu<=nu_star;
        B,     se nu>nu_star.
```

Esse transporte aplica `beta` exatamente uma vez. Não encontrei `beta`
interno em N2, segundo desconto em N4 nem uso sem desconto de uma continuação
de R2. Pagamentos de acordo em R1, inclusive `Y`, permanecem em unidades
correntes de R1.

## 3. Crenças e cutoff fraco

O assessment respeita integralmente o pacote decidido:

- proposta ou voto de weak state não move a crença, inclusive fora do caminho;
- uma ação prescrita de `H` atualiza por Bayes sempre que seu denominador é
  positivo;
- com prior interior, uma ação de `H` fora do perfil permite posterior livre
  em `[0,1]`, sujeito às ICs do próprio assessment;
- em `nu=0`, todo posterior permanece zero; em `nu=1`, todo posterior permanece
  um, inclusive em histórias `0/0`.

Se o voto do weak responder `j` é pivotal sob unanimidade, todos os demais
votam `sim`, inclusive `H`. Seja `eta_Y` o posterior associado ao `sim` de
`H`. O payoff de `j` ao aprovar é `x_j`; ao vetar é sua continuação N2:

```text
W(eta_Y) = (1-eta_Y)A, se eta_Y<=nu_star;
           B,          se eta_Y>nu_star.
```

Logo

```text
j vota sim  iff  x_j>=W(eta_Y).
```

`T^Y` fecha a igualdade em `sim`. Como `W(eta)` percorre o intervalo fechado
`[B,A]`, `x_j=A` força `sim` sob toda crença admissível. Quando há veto fraco
realizado, a única estratégia racional de `H` é `(sim,sim)`, o posterior depois
de `sim` é o corrente e o cutoff reduz exatamente a `C`: cada identidade veta
se e somente se `x_j<C`. Isso permanece verdadeiro com vários vetos e no caso
`m=2`, em que há um único weak responder.

Esse passo satisfaz P4 e a versão vigente de P6: a não informatividade das ações
fracas é demonstrada, a comparação é as-if-pivotal e a fronteira de veto é
aberta. Nenhum veto em `x_j=C` foi mantido.

## 4. Perfis puros de `H` após uma proposta arbitrária

Escreva `u=min_j x_j` e ordene o perfil como `(ação de H0, ação de H1)`.
Reconstituí os quatro perfis sem supor o outcome.

### 4.1 Com algum veto fraco

A proposta falha qualquer que seja o voto de `H`. O tipo alto recebe `h` em
toda continuação e, em igualdade, vota `sim` por `T^Y`. No interior, se o baixo
votasse `não` e o alto `sim`, o `não` revelaria o baixo e daria `ell`, enquanto
imitar o `sim` do alto daria `h`; portanto o baixo também vota `sim`. Nos
endpoints, ambos os votos preservam o posterior singleton e `T^Y` novamente
determina `sim`. Assim, o único perfil é `(sim,sim)`.

### 4.2 Endpoint `nu=0`

A restrição de suporte fixa `eta_Y=eta_N=0`. A partição necessária e
suficiente depois de toda proposta factível é:

| Região | Único perfil de `H` | Resultado |
|---|---|---|
| `u<A` | `(sim,sim)` | algum fraco veta; segue N2 |
| `u>=A` e `Y<ell` | `(não,não)` | todos os fracos aprovam; `H` veta |
| `u>=A` e `ell<=Y<h` | `(sim,não)` | acordo apenas com o tipo baixo |
| `u>=A` e `Y>=h` | `(sim,sim)` | acordo pooling |

As igualdades estão do lado correto: `H0` aceita em `Y=ell` e `H1` aceita em
`Y=h`. A antiga tentativa de sustentar `(não,não)` com `B<=u<A` exigiria
posterior positivo no tipo de prior zero. Com posterior necessariamente zero,
o cutoff é `A`, há veto fraco e apenas `(sim,sim)` sobrevive.

### 4.3 Interior alto `nu_star<nu<1`

Bayes e as ICs dão:

| Região | Único perfil de `H` | Restrição de crença fora do perfil |
|---|---|---|
| `u<B` | `(sim,sim)` | `eta_N` pode ser qualquer valor em `[0,1]` |
| `u>=B` e `Y<h` | `(não,não)` | requer `W(eta_Y)<=u` |
| `u>=B` e `Y>=h` | `(sim,sim)` | `eta_N` pode ser qualquer valor em `[0,1]` |

Quando `B<=u<A`, a restrição do ramo `(não,não)` equivale a
`eta_Y>=1-u/A`; quando `u>=A`, qualquer `eta_Y` serve. Os perfis separadores
falham por imitação. Não há sobreposição de estratégias puras proposta a
proposta; a multiplicidade restante é somente de crenças IC-compatíveis.

### 4.4 Endpoint `nu=1`

Todo posterior é um e o cutoff fraco é `B`:

| Região | Único perfil de `H` |
|---|---|
| `u<B` | `(sim,sim)` |
| `u>=B` e `Y<h` | `(não,não)` |
| `u>=B` e `Y>=h` | `(sim,sim)` |

Em particular, na separação inversa ambos os tipos comparam `Y` com `h`: o
baixo votar `não` exigiria `Y<h`, enquanto o alto votar `sim` exigiria
`h<=Y`. Preferência estrita ou `T^Y` elimina a igualdade. Não há posterior
positivo no tipo baixo impossível, nem multiplicidade de crenças no endpoint.

As três tabelas cobrem toda proposta factível nos dois domínios de existência,
incluindo propostas fora do caminho. Elas respeitam o ballot simultâneo: `H`
não observa votos antes de agir e não recebe segunda decisão.

## 5. Certificado de inexistência em `0<nu<=nu_star`

Considere

```text
s_dagger:
  Y   = ell,
  x_j = A para todo respondente,
  r_i = Q_L = 1-ell-(m-1)A.
```

Essa proposta satisfaz todas as restrições, usa a pie inteira e tem residual
estritamente positivo. De fato,

```text
Q_L-A = 1-ell-mA = 1-beta > 0.
```

Também `ell<o_0<o_1<=y_bar`, portanto o pagamento a `H` pertence ao espaço
factível. Como `A=max_eta W(eta)`, todos os weak responders votam `sim` sob
qualquer uma das quatro estratégias puras de `H` e sob toda crença admissível.

Resta a enumeração completa:

| Perfil de `H` | Desvio lucrativo ou desempate que o elimina |
|---|---|
| `(sim,sim)` | `H1` troca para `não`: recebe `h>ell` |
| `(não,não)` | `H0` recebe `ell` com ambos os votos; `T^Y` exige `sim` |
| `(sim,não)` | `H0` imita o `não` de `H1`, induz posterior um e recebe `h>ell` |
| `(não,sim)` | `H1` imita o `não` de `H0` e recebe `h>ell` |

O argumento inclui `nu=nu_star`: N2 seleciona o registro low-type-only nessa
fronteira, de modo que o `não` pooling de `(não,não)` ainda dá `ell` a `H0` e
o empate ainda é fechado em `sim`. Inclui também `m=2`: há um único respondente
fraco, mas ele recebe `A`, vota `sim`, e `Q_L-A=1-beta>0` preserva a
factibilidade.

Não existe quinto perfil puro. Como o conceito exige estratégias puras em todo
ballot e racionalidade sequencial também depois de propostas de probabilidade
zero, a ausência de resposta pura depois de uma única proposta factível impede
qualquer PBE do jogo completo nessa célula. O certificado demonstra
inexistência apenas dentro do conceito declarado de ballots puros; não afirma
inexistência de equilíbrio se misturas de voto fossem autorizadas.

## 6. Existência e optimalidade nas duas células restantes

### 6.1 `nu=0`: `L_star`

O único ótimo é

```text
Y=ell,   x_j=A para todo j,   r_i=Q_L=A+1-beta.
```

O perfil é `(sim,não)`: o tipo baixo aprova e o alto, de probabilidade zero,
rejeita. Todo acordo low-type-only paga ao menos `ell` a `H` e `A` a cada
fraco, logo não pode deixar mais que `Q_L` ao proponente. Pooling custa ainda
`h-ell>0`. Toda forma de atraso paga o valor corrente `C=A`, enquanto
`Q_L-A=1-beta>0`. Assim, `L_star` é estritamente melhor que atraso e
estritamente melhor que pooling; seus componentes mínimos e o uso integral da
pie tornam a proposta única.

### 6.2 `nu_star<nu<=1`: `P_star`

O único ótimo é

```text
Y=h,   x_j=B para todo j,   r_i=Q_P=B+1-beta.
```

Todo pooling paga ao menos `h` a `H` e `B` a cada fraco. Separação é impossível
para prior positivo. Atraso paga `C=B`, mas

```text
Q_P-B = 1-h-mB = 1-beta > 0.
```

Logo `P_star` força pooling e é o único ótimo, inclusive em `nu=1`. Em
`Y=h` e `x_j=B`, as igualdades são aceitas por `T^Y`; nenhuma mistura pode ser
sustentada por veto na fronteira.

### 6.3 P0, fronteiras e ausência de mistura on-path

As duas propostas usam exatamente a pie. Isso é resultado, não primitiva:
qualquer folga em uma proposta de acordo poderia ser adicionada a `r_i` sem
mudar pagamentos, crenças nem respostas; propostas de atraso são estritamente
inferiores por `1-beta`.

As fronteiras de acordo são fechadas e as de veto são abertas. Não há mistura
de propostas entre acordo e atraso porque o payoff do acordo é estritamente
maior, nem mistura entre propostas distintas porque `L_star` e `P_star` são
únicas. Misturas no ballot são excluídas pelo conceito de solução; o candidato
não as elimina por uma falsa prova de não existência.

## 7. Payoffs, outcomes e atomicidade

No endpoint baixo, o mesmo registro vincula:

- estratégia on-path `L_star` e completamento após toda proposta;
- crença zero em toda a árvore;
- payoff de `H` por tipo `(ell,h)`;
- vetor fraco `(Q_L,A,...,A)` no tipo baixo e vetor zero no tipo alto;
- valor pré-reconhecimento `(1-ell)/m` sob o prior `nu=0`;
- passagem com `H` de probabilidade um ex ante e delay/falha de probabilidade
  zero.

O ramo condicional do tipo alto não foi apagado: ele rejeita, chega ao registro
N2 low-type-only e dá zero aos fracos, mas tem probabilidade ex ante zero. Por
isso `outcome_distribution.delay=0` é consistente com o vetor condicional
mantido no mesmo registro.

Na célula alta, o mesmo registro vincula `P_star`, as crenças admissíveis, o
vetor `(h,h)` de `H`, o vetor fraco `(Q_P,B,...,B)` em ambos os tipos, o valor
pré-reconhecimento `(1-h)/m` e passagem imediata com `H` de probabilidade um.

Não encontrei recombinação de estratégia, crença, payoff ou outcome entre
registros. Os identificadores e hashes de N2 e da errata são explícitos. A
célula intermediária contém `existence_status=none`, lista vazia de registros e
certificado ligado ao claim `N4-C08`; nenhum equilíbrio-sentinela foi criado.

## 8. Tentativas dirigidas de contraexemplo

Não usei mutação exaustiva de folhas, fuzzing de schema nem força bruta. Os
ataques foram matemáticos e representativos.

| Ataque tentado | Resultado |
|---|---|
| Sustentar veto em `x_j=C` | `T^Y` força `sim`; veto exige `x_j<C` |
| Usar voto fraco para mudar o posterior | proibido por no-signaling e não usado nas provas |
| Ressuscitar o tipo impossível em `nu=0` ou `nu=1` | todos os campos endpoint fixam posterior zero ou um, respectivamente |
| Sustentar `(não,não)` em `nu=0` com `B<=u<A` | cutoff fixo `A` gera veto fraco; `H` fica indiferente e `T^Y` seleciona `(sim,sim)` |
| Sustentar separação inversa em `nu=1` | exigiria `Y<h<=Y` |
| Fazer o certificado falhar em `nu=nu_star` | o tie-break N2 escolhe screening; o empate de `H0` continua e `T^Y` elimina `(não,não)` |
| Fazer `s_dagger` infactível com `m=2` | `Q_L-A=1-beta>0` e há exatamente um weak responder |
| Produzir outro perfil no interior alto | as duas separações falham por imitação; `YY` e `NN` particionam as regiões por `u` e `Y` |
| Fazer atraso empatar com acordo | ambos os gaps são exatamente `1-beta>0` |
| Introduzir segundo fator de desconto | `ell`, `h`, `A` e `B` já são a única conversão de N2 para R1 |
| Ocultar o ramo de probabilidade zero em `nu=0` | payoff de `H` e vetor fraco condicionados ao tipo permanecem explícitos |

Como verificação numérica independente, usei dois conjuntos representativos.
No caso mínimo `m=2`, `beta=0.73`, `o_0=0.20`, `o_1=0.80`, obtive

```text
nu_star=0.75, A=0.292, B=0.073,
Q_L-A=Q_P-B=0.27=1-beta,
h-ell=0.438.
```

Em um caso com `m=7`, `beta=0.93`, `o_0=0.07`, `o_1=0.64`, obtive
`Q_L-A=Q_P-B=0.07`, as duas propostas somando exatamente um e ganho estrito
`h-ell=0.5301` nos desvios que eliminam os perfis separadores de
`s_dagger`.

Um segundo agente adversarial read-only, usado apenas como stress test interno
e não como parecer adicional do protocolo, repetiu os ataques aos quatro
perfis, aos endpoints, a `m=2`, às fronteiras e à atomicidade e não encontrou
contraexemplo. Essa convergência é evidência suplementar; o veredicto abaixo se
apoia na reconstrução detalhada deste parecer.

## 9. Consistência executável e documental

- O JSON parseia como UTF-8 válido e contém exatamente três células mutuamente
  exclusivas e exaustivas: `exists`, `none`, `exists`.
- A célula `none` tem zero registros e certificado não vazio; as células
  existentes têm um registro cada e certificado nulo.
- O ledger tem 15 claims, sete campos por linha e nenhum registro malformado.
- Markdown, JSON, ledger, matriz e relatório consolidado concordam sobre
  `nu_star`, `ell`, `h`, `A`, `B`, `C`, `Q_L`, `Q_P`, fronteiras, suporte,
  payoffs, outcomes e datas.
- O verificador dirigido retornou `MODEL_PROOF_DIRECTED: PASS` com 60 avaliações
  de fronteira de N4, `ALGEBRA_IDENTITIES: PASS` e
  `FINITE_ENUMERATION: PASS`. A parcela N3 impressa pelo mesmo script não foi
  usada neste parecer.
- O verificador canônico Gate 0 retornou `PASS`; isso atesta apenas a
  infraestrutura e não congela N4 nem concede autorização downstream.
- Os avisos isolados de locale do R não afetam os cálculos e não constituem
  finding substantivo.

## 10. Fechamento de FD-SUP-MIN-01

O reparo está correto e presente no relatório consolidado no hash manifestado.
A contradição `Y<ell<h<=Y` foi limitada ao interior `0<nu<1`. O endpoint
`nu=1` recebeu argumento próprio: suporte fixa posterior um depois dos dois
votos; ambos os tipos usam continuação `h`; separação inversa exigiria
`Y<h<=Y`, com `T^Y` eliminando a igualdade.

Nenhuma construção do candidato principal usa posterior positivo no tipo de
prior zero em qualquer história endpoint. O mesmo vale para as tabelas de
completamento fora do caminho. Portanto a checagem obrigatória da Emenda 1a é
satisfeita, e `FD-SUP-MIN-01` está fechado sem mudança na interface N4.

## 11. Findings e veredicto estrito

| Severidade | Quantidade | Findings |
|---|---:|---|
| critical | 0 | nenhum |
| major | 0 | nenhum |
| minor | 0 | nenhum |

**VEREDICT: PASS — critical=0, major=0, minor=0.**

Este PASS vale exclusivamente para a interface N4
`f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`
sob o manifesto
`5c252aca20ee980a6f3faef7f97570f0bc9590c86b7b216a615afede31dbd93c`.
O parecer não reavalia N3, não congela sozinho N4, não altera o DAG e não
autoriza N6, N7, figuras ou manuscrito. Até o registro administrativo dos dois
pareceres exclusivos no mesmo hash, N4 permanece `pending/unfrozen`.
