# N1 — R2 sob maioria: derivação do candidato

**Nó:** `N1`  
**Regra:** maioria, `q = floor(N/2)+1`  
**Data nativa dos payoffs:** R2  
**Status:** `pending` — candidato de implementação, ainda sem os dois pareceres independentes exigidos para `pass/frozen`  
**Fonte normativa exclusiva:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`, especialmente Seções 2, 4, 5, 6, 7.2, 8, 9 e 11

## 1. Escopo e estado suficiente

N1 é o último problema de decisão do jogo. Não consome interface de continuação. O estado de entrada pode ser representado por

```text
(regra = maioria, rodada = R2, crença de entrada = nu, proponente reconhecido = i),
```

com `nu in [0,1]`. A identidade de `i` apenas relabela weak states simétricos. Como o reconhecimento é iid, uniforme e com reposição, nenhuma outra parte da história pública altera ações factíveis, payoffs, reconhecimento ou informação em R2. A prova formal da suficiência de `nu` aparece no Claim N1-C08.

O proponente weak `i` escolhe uma alocação factível

```text
s = (y, (x_j)_{j in W sem i}, r_i),
0 <= y <= y_bar,
x_j >= 0,
r_i >= 0,
y + sum_j x_j + r_i <= 1.
```

As opções externas satisfazem o domínio estrito corrente

```text
0 < o_0 < o_1 < 1,
o_1 <= y_bar <= 1,
0 < beta < 1.
```

O proponente conta como voto `sim`. Os `m-1` weak nonproposers e `H` votam simultaneamente e em segredo. Os votos só se tornam públicos depois do fechamento do ballot. Não há continuação depois de R2.

## 2. Weak nonproposers no ballot terminal

Fixe uma proposta factível `s`, um weak nonproposer `j` e qualquer perfil dos demais votos. A comparação terminal é:

| Perfil dos demais | `j` vota `sim` | `j` vota `não` |
|---|---:|---:|
| `j` é pivotal | `x_j` | `0` |
| a quota passa sem `j` | `x_j` | `x_j` |
| a quota falha mesmo com `j` | `0` | `0` |

### Claim N1-C01 — dominância quando `x_j > 0`

Se `x_j > 0`, votar `sim` dá payoff pelo menos tão alto contra todo perfil dos demais votos e payoff estritamente maior quando `j` é pivotal. Logo, `não` é fracamente dominado por `sim` e é eliminado pelo stage-undominated voting.

### Claim N1-C02 — igualdade genuína quando `x_j = 0`

Se `x_j = 0`, as duas ações dão payoff zero contra todo perfil dos demais votos. A indiferença ocorre no information set inteiro, não apenas em uma linha local. Depois da restrição de stage-undominance, `T^Y` seleciona `sim`.

Portanto, em toda proposta factível, inclusive fora do caminho,

```text
v_j(s) = sim para todo weak nonproposer j.
```

Esse resultado não usa crenças sobre `theta`.

## 3. A quota de maioria sem o voto de H

O proponente fornece um voto `sim` e os `m-1` weak nonproposers também votam `sim`. Assim, o total de votos fracos favoráveis é

```text
1 + (m-1) = m = N-1.
```

Para `N >= 3`,

```text
N-1 >= floor(N/2)+1 = q,
```

pois `N-2 >= floor(N/2)`. Logo, os weak states sozinhos atingem a quota em toda proposta factível. `H` é não pivotal em todo information set de ballot de R2 sob as estratégias admissíveis dos weak nonproposers.

### Claim N1-C03 — melhor resposta estrita de H

Fixe `theta` e uma proposta com coordenada `y`. Como a proposta passa qualquer que seja o voto de `H`, a execução integral da alocação e a Tabela 1 do contrato dão:

```text
H vota sim: recebe y;
H vota não: recebe y + o_theta.
```

Como `o_theta > 0`, votar `não` é estritamente melhor para os dois tipos. Stage-undominated voting não é aplicado a `H`, e `T^Y` não é acionado porque não há indiferença. Assim,

```text
v_H(s, theta) = não para theta in {0,1} e toda proposta factível s.
```

O termo `y` é executado nos dois ramos. O voto `não` acrescenta `o_theta` porque a proposta aprovada exclui `H`; ele não destrói nem realoca `y`.

## 4. Problema do proponente

Pelos Claims N1-C01--N1-C03, toda proposta factível é aprovada sem `H`, independentemente da crença de ballot. O payoff do proponente reconhecido é, portanto, `r_i`.

Da factibilidade,

```text
r_i <= 1 - y - sum_j x_j <= 1.
```

O valor `1` é atingido pela proposta

```text
s_N1 = (y=0, x_j=0 para todo j, r_i=1).
```

### Claim N1-C04 — unicidade da proposta ótima e P0

Qualquer proposta com folga orçamentária permite elevar `r_i` mantendo `y` e todos os `x_j`, sem alterar nenhuma resposta no ballot, e portanto não maximiza o payoff do proponente. Para atingir `r_i=1`, a não negatividade força simultaneamente `y=0` e `x_j=0` para todo `j`. Logo, `s_N1` é a única proposta ótima e usa integralmente a pie.

O tie-break no nível da proposta não seleciona entre propostas distintas: o argmax já é singleton.

## 5. Crenças, PBE e correspondência completa

O weak proposer não observa `theta`. A proposta on-path `s_N1` é feita com probabilidade um para ambos os tipos, então Bayes preserva a crença de entrada:

```text
Pr(theta=1 | s_N1) = nu.
```

Em propostas de probabilidade zero, a crença de ballot pode ser qualquer função `kappa(s) in [0,1]`, conforme a Seção 5. Isso gera multiplicidade de assessments apenas nas crenças off-path. Não gera estratégia, outcome ou payoff adicional, porque os votos derivados acima são independentes dessas crenças em toda proposta factível.

### Claim N1-C05 — existência e extensão a todas as propostas

As estratégias

```text
proponente: propõe s_N1;
weak nonproposer j: vota sim após toda proposta factível;
H, cada tipo: vota não após toda proposta factível
```

junto de Bayes no caminho e qualquer `kappa(s)` fora do caminho formam PBE com estratégias puras no ballot e satisfazem a restrição de stage-undominance e `T^Y`.

### Claim N1-C06 — exaustividade e multiplicidade preservada

Todo assessment admissível deve prescrever `sim` a cada weak nonproposer em toda proposta: para `x_j>0`, por stage-undominance; para `x_j=0`, por `T^Y`. Isso torna `H` não pivotal, força seu `não` estrito em toda proposta e reduz o problema do proponente ao argmax único do Claim N1-C04. Portanto, a correspondência contém uma única classe de estratégia, outcome e payoff, parametrizada somente por crenças off-path arbitrárias e payoff-irrelevantes. Nenhuma seleção ad hoc é aplicada.

## 6. Interface de continuação

Condicional ao reconhecimento de `i`:

```text
payoff do proponente reconhecido = 1;
payoff realizado de cada weak nonproposer = 0;
payoff de H do tipo theta = o_theta;
outcome = aprovação sem H com probabilidade 1.
```

Antes do reconhecimento de R2, cada weak state é reconhecido com probabilidade `1/m`. Como recebe `1` se reconhecido e `0` caso contrário,

```text
valor esperado pré-reconhecimento de cada weak state = 1/m.
```

### Claim N1-C07 — datas e ausência de desconto interno

Todos esses payoffs são pagos na data terminal de R2. Nenhum valor contém desconto interno. Um predecessor de R1 deverá aplicar o desconto exatamente uma vez ao consumir a futura interface congelada de N1.

### Claim N1-C08 — P5, suficiência do posterior

Considere duas histórias públicas que entram em R2 com a mesma regra e o mesmo posterior `nu`. R2 é terminal; o conjunto factível, a quota, a função de implementação e os payoffs são os mesmos. O novo reconhecimento é iid, uniforme e com reposição, de modo que a identidade ou o resultado do reconhecimento anterior não altera elegibilidade nem probabilidades. As estratégias e o argmax acima também não dependem de outro componente da história e, de fato, nem do valor de `nu`. Assim, histórias com o mesmo posterior induzem o mesmo problema de maximização e a mesma correspondência, sem impor estratégias Markov.

### Claim N1-C09 — P6, efeito on-path do refinamento

O refinamento elimina `não` para todo weak nonproposer quando `x_j>0`. Quando `x_j=0`, nenhuma ação é eliminada por dominância, mas `T^Y` seleciona `sim` porque há indiferença genuína em todo o information set. Como a proposta ótima fixa `x_j=0`, a passagem on-path depende de `T^Y`, não de uma aplicação indevida da dominância estrita. Para `H`, o voto `não` decorre de preferência estrita e não do refinamento.

## 7. Invariância à restrição estrita `o_1 < 1`

### Claim N1-C10 — o domínio menor não altera a solução de N1

A rederivação acima usa apenas `o_theta>0` na comparação de `H`: quando os
weak states já satisfazem a quota, `não` paga `y+o_theta`, estritamente mais que
o payoff `y` de `sim`. O limite superior de `o_theta` não entra nessa IC. As
ações dos weak nonproposers dependem somente de `x_j`; a quota depende somente
de `N`; e o problema do proponente, depois dessas respostas, é maximizar `r_i`
na pie unitária. Logo, nenhum passo usa a fronteira anteriormente admissível
`o_1=1` nem uma desigualdade fraca `o_1<=1`.

Restringir o domínio de `0<o_0<o_1<=y_bar<=1` para
`0<o_0<o_1<1` e `o_1<=y_bar<=1` apenas remove primitivas da cobertura. Em todo
ponto remanescente, a proposta, os votos, as crenças admissíveis, os payoffs, o
outcome e a multiplicidade de assessments continuam exatamente os derivados
nas Seções 2--6 acima. Esta é invariância por restrição de domínio, não
transporte do candidato anterior.

## 8. Invariância ao domínio estrito `beta < 1`

### Claim N1-C11 — `beta` não entra no R2 terminal

A rederivação das Seções 2--6 usa somente payoffs terminais na data corrente de
R2. Não existe sucessor de R2 cujo valor pudesse ser descontado. Em particular,
as comparações dos weak nonproposers são `x_j` contra zero, a comparação de `H`
é `y+o_theta` contra `y`, e o problema do proponente é maximizar `r_i` sujeito à
factibilidade corrente. Nenhuma dessas expressões contém `beta`.

Logo, restringir a primitiva de `beta in (0,1]` para `beta in (0,1)` elimina
apenas o ponto paramétrico `beta=1`; em todo ponto remanescente, a estratégia,
a classe de crenças, os payoffs, o outcome e a multiplicidade da correspondência
de N1 são idênticos. Esta conclusão foi obtida da data terminal de R2, sem
importar o candidato anterior e sem inserir desconto interno.

## 9. Célula de cobertura e invalidação

A interface `equilibrium_correspondence_v1` usa uma única célula `exists`, válida para todo `nu in [0,1]` e para todas as primitivas admissíveis do contrato. A célula representa integralmente a classe de assessments descrita acima; não há célula `none`.

O candidato permanece `pending`. Se primitivas, quota, execução de `y`, gatilho de `o_theta`, conceito de solução, `T^Y`, horizonte, reconhecimento, schema ou qualquer claim usado aqui mudar, a interface deve ser rederivada e receber novo hash e dois novos pareceres independentes.
