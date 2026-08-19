# N7 Fase A — derivação dos benchmarks públicos

**Data:** 2026-08-19  
**Status do objeto:** candidato intermediário da Fase A; `N7` permanece
`pending` e `unfrozen`  
**Contrato:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`  
**Ordem executada:** R2 pública antes de R1 pública, separadamente por regra e
tipo público  
**Fora do escopo:** registros privados, comparação público-privado, `RI_M`,
`RI_U`, `DeltaRI`, freeze de `N7`, `beta=1` e manuscritos

## 1. Objeto e notação

Fixe uma situação pública de `H`, `theta in {0,1}`, e escreva
`o = o_theta`. Desde `t=0`, todos sabem qual é a situação. Não há, portanto,
uma crença livre sobre `theta`: depois de toda história, inclusive uma proposta
de probabilidade zero, a crença admissível permanece degenerada no tipo público.

Há `m >= 2` países fracos, `N=m+1` membros e somente países fracos são
reconhecidos para propor. Sob maioria,

```text
q = floor((m+1)/2)+1 <= m.
```

O proponente conta como voto `sim`. Todos os demais votam simultaneamente e o
ballot é puro. Mistura do proponente entre propostas payoff-equivalentes não é
mistura no ballot.

Para transportar R2 a R1, defina:

```text
a_M = beta/m                 continuação de cada país fraco sob maioria
a_U = beta*(1-o)/m           continuação de cada país fraco sob unanimidade
b   = beta*o                 continuação de H sob qualquer regra
```

Esses três objetos estão em unidades de R1. Os payoffs de R2 permanecem em
unidades nativas e não contêm `beta`.

## 2. R2 pública sob maioria

### 2.1 Respostas no ballot

R2 é terminal. Para qualquer weak nonproposer `j`, votar `sim` dá `x_j` se seu
voto for pivotal e votar `não` dá zero. Nos perfis em que seu voto não altera o
resultado, os payoffs coincidem. Assim:

- se `x_j>0`, `sim` domina fracamente `não`;
- se `x_j=0`, há indiferença genuína e `T^Y` seleciona `sim`.

Logo, todos os weak nonproposers votam `sim` depois de toda proposta. Como os
`m` votos fracos, incluindo o do proponente, já satisfazem `q<=m`, a proposta
passa qualquer que seja o voto de `H`. `H` é não pivotal e compara `y` ao votar
`sim` com `y+o` ao votar `não`; como `o>0`, vota `não` estritamente.

### 2.2 Problema do proponente e solução

O proponente maximiza `r_i` sujeito apenas à factibilidade. A única proposta
ótima é:

```text
y=0,  x_j=0 para todo j,  r_i=1.
```

A proposta passa sem `H`. O payoff reconhecido do proponente é `1`; antes do
sorteio de reconhecimento, cada identidade fraca recebe `1/m`; `H` recebe `o`.
Não há falha, atraso, multiplicidade de payoff, aleatorização de proposta nem
multiplicidade de crença. O resultado vale para `m=2` e `m>=3`.

## 3. R2 pública sob unanimidade

Todos os weak nonproposers novamente votam `sim`. Agora `H` é pivotal. Votar
`sim` implementa `y`; votar `não` termina o jogo com `o`. Portanto, `H` vota
`sim` se e somente se `y>=o`, com aceitação na igualdade.

Como `o<1`, o proponente obtém ganho estritamente positivo ao comprar a
aprovação de `H`. Sua única proposta ótima é:

```text
y=o,  x_j=0 para todo j,  r_i=1-o.
```

A proposta passa com `H`. O payoff reconhecido do proponente é `1-o`; antes do
reconhecimento, cada identidade fraca recebe `(1-o)/m`; `H` recebe `o`. A oferta
fica na fronteira de aceitação de `H`, mas não há indiferença do proponente entre
acordo e falha, pois `1-o>0`. O assessment, o outcome e os payoffs são únicos
para `m=2` e `m>=3`.

## 4. Respostas públicas em R1

As soluções de R2 acima são payoff-únicas. Como o reconhecimento é iid com
reposição, duas histórias públicas de R1 que terminam em falha induzem o mesmo
problema público de R2 sob a mesma regra e o mesmo tipo. Não se impõe uma
restrição Markov: a suficiência segue da identidade do jogo continuado.

### 4.1 Weak nonproposers

Se `j` é pivotal em R1, votar `sim` dá `x_j` e votar `não` dá a continuação
descontada `a_g`. Nos demais perfis, as duas ações induzem o mesmo payoff.
Stage-undominated voting e `T^Y` implicam a estratégia única:

```text
maioria:     j vota sim se e somente se x_j >= a_M = beta/m;
unanimidade: j vota sim se e somente se x_j >= a_U = beta*(1-o)/m.
```

### 4.2 H

Antes do ballot simultâneo, `H` observa a proposta e conhece as estratégias
puras que ela induz para os países fracos; ele não observa votos já realizados.
Se o número **prescrito** de votos fracos já faz a proposta passar sob maioria,
`H` é não pivotal e vota `não`, pois recebe `y+o` em vez de `y`. Se, dado esse
perfil prescrito, faltaria exatamente o voto de `H`, ele é pivotal e vota `sim`
se e somente se `y>=b=beta*o`. Se a quota falharia mesmo com seu `sim`, as duas
ações dão `beta*o` e `T^Y` seleciona `sim`.

Sob unanimidade, `H` é pivotal quando as estratégias de todos os weak
nonproposers prescrevem `sim` e usa o mesmo cutoff `y>=b`. Se o perfil prescrito
contém algum `não`, a proposta falha independentemente do voto de `H`, e `T^Y`
seleciona `sim`. Nenhuma dessas regras condiciona a ação de `H` ao vetor ex post,
que só se torna público depois do fechamento do ballot.

O cutoff `b` contém exatamente um fator `beta`: R2 paga `o` em `t=2`, e R1
avalia essa continuação uma única vez.

## 5. R1 pública sob maioria

Depois das respostas acima, todo acordo ótimo pertence a uma de duas famílias.
Fixe o proponente reconhecido `i`.

### 5.1 Inclusão de H

Para tornar `H` pivotal, o proponente compra `q-2` weak nonproposers e o voto de
`H`. Para algum subconjunto `C_i^I` de tamanho `q-2`:

```text
y=beta*o;
x_j=beta/m se j pertence a C_i^I, e x_j=0 caso contrário;
r_i=R_I=1-beta*o-beta*(q-2)/m.
```

Os membros de `C_i^I` e `H` aceitam na igualdade. Os demais weak
nonproposers votam `não`. A proposta recebe exatamente `q` votos e passa com
`H`.

### 5.2 Exclusão de H

O proponente pode comprar `q-1` weak nonproposers e dispensar o voto de `H`.
Para algum subconjunto `C_i^E` de tamanho `q-1`:

```text
y=0;
x_j=beta/m se j pertence a C_i^E, e x_j=0 caso contrário;
r_i=R_E=1-beta*(q-1)/m.
```

`H` vota `não` porque a proposta passa sem ele e recebe `o` na data de R1.

### 5.3 Escolha entre inclusão, exclusão e atraso

A diferença entre os dois payoffs do proponente é:

```text
R_E-R_I = beta*(o-1/m).
```

Logo:

- se `o<1/m`, inclusão é estritamente ótima;
- se `o>1/m`, exclusão é estritamente ótima;
- se `o=1/m`, os dois ramos dão o mesmo payoff ao proponente.

Na igualdade, a seleção autorizada no nível da proposta escolhe inclusão:
inclusão dá `beta*o` a `H`, enquanto exclusão dá `o`, e `beta<1`. Não sobrevive
mistura entre os dois ramos nessa fronteira.

O payoff do proponente se houver atraso é `a_M=beta/m`. A exclusão sempre o
supera estritamente:

```text
R_E-a_M = 1-beta*q/m > 0,
```

pois `q<=m` e `beta<1`. Como o ramo selecionado é pelo menos tão bom quanto a
exclusão, atraso, falha deliberada e mistura entre acordo e atraso nunca são
ótimos no domínio autorizado.

### 5.4 Multiplicidade dentro do ramo

O ramo, o outcome, o payoff do proponente e o payoff de `H` são únicos em cada
região. Pode haver, porém, várias coalizões de custo idêntico:

- em `m=2`, tanto a coalizão de inclusão quanto a de exclusão são únicas;
- em `m>=3`, inclusão admite várias coalizões de tamanho `q-2`;
- em exclusão, `m=3` exige todos os outros fracos e a coalizão é única;
- em exclusão com `m>=4`, existem várias coalizões de tamanho `q-1`.

Para cada identidade reconhecida `i`, qualquer distribuição `F_i` sobre as
coalizões ótimas do ramo selecionado é admissível. Distribuições degeneradas
são estratégias puras assimétricas na composição da coalizão; a distribuição
uniforme fornece um benchmark simétrico; distribuições não degeneradas são
aleatorizações entre propostas payoff-equivalentes **dentro do mesmo ramo**.
Nenhuma delas é uma estratégia mista entre acordo e atraso. A multiplicidade
pode alterar payoffs por identidade dos países fracos, mas não altera outcome,
payoff do proponente ou payoff de `H`.

## 6. R1 pública sob unanimidade

Para aprovação, todos os `m-1` weak nonproposers e `H` precisam aceitar. A
proposta de custo mínimo é única para cada proponente reconhecido:

```text
y=beta*o;
x_j=beta*(1-o)/m para todo j diferente de i;
r_i=R_U=1-beta*(m-1+o)/m.
```

Todos aceitam na igualdade e a proposta passa imediatamente com `H`. O payoff
de atraso do proponente é `a_U=beta*(1-o)/m`, e:

```text
R_U-a_U = 1-beta > 0.
```

Portanto, `beta<1` elimina atraso, falha deliberada e mistura entre acordo e
atraso. Todos os países fracos são tratados simetricamente; não há convenção
pura por identidade entre negociadores “cooperativos” e “difíceis” no benchmark
público. O único sorteio é o reconhecimento exógeno. Antes desse sorteio, cada
identidade fraca recebe `(1-beta*o)/m`; `H` recebe `beta*o`.

## 7. Completude

A caracterização é exaustiva porque:

1. os cutoffs dos weak nonproposers são impostos pelo stage game completo e
   eliminam qualquer voto puro diferente, salvo as igualdades já resolvidas por
   `T^Y`;
2. a melhor resposta de `H` é determinada para cada contagem possível de votos
   fracos, inclusive os perfis não pivotais;
3. em R2, qualquer pagamento acima do cutoff ou qualquer folga reduz
   estritamente `r_i`, e a falha dá zero ao proponente;
4. em R1-majoria, toda aprovação com `H` exige pelo menos `q-2` weak
   nonproposers e `y>=beta*o`, e toda aprovação sem `H` exige pelo menos `q-1`
   weak nonproposers; pagar mais eleitores ou exceder qualquer cutoff reduz
   estritamente `r_i`;
5. em R1-unanimidade, todos os cutoffs são necessários e suficientes;
6. o melhor ramo de acordo supera estritamente o atraso sob `beta<1`;
7. propostas com folga não maximizam, pois o residual pode ser aumentado sem
   alterar nenhuma resposta;
8. o tipo é público, de modo que não há crença off-path alternativa capaz de
   mudar os cutoffs.

## 8. Matriz de classificação das famílias públicas

Em todas as linhas, os ballots são puros e a crença sobre `theta` é degenerada
e única. “Misto dentro do ramo” designa apenas uma distribuição do proponente
sobre coalizões payoff-equivalentes.

| Regra/rodada | Situação pública | Domínio | Proposta pura/mista | Simetria por identidade | Outcome | Interior/fronteira | Natureza da multiplicidade |
|---|---|---|---|---|---|---|---|
| Maioria R2 | `theta=0` ou `1` | `m=2` | pura única | simétrica | acordo imediato sem `H` | `y=0` na fronteira inferior de factibilidade; sem fronteira entre ramos | nenhuma |
| Maioria R2 | `theta=0` ou `1` | `m>=3` | pura única | simétrica | acordo imediato sem `H` | `y=0` na fronteira inferior de factibilidade; sem fronteira entre ramos | nenhuma |
| Unanimidade R2 | `theta=0` ou `1` | `m=2` | pura única | simétrica | acordo imediato com `H` | `y=o` na fronteira de aceitação | nenhuma; proponente prefere acordo estritamente |
| Unanimidade R2 | `theta=0` ou `1` | `m>=3` | pura única | simétrica | acordo imediato com `H` | `y=o` na fronteira de aceitação | nenhuma; proponente prefere acordo estritamente |
| Maioria R1, inclusão | `theta=0` ou `1` | `m=2`, `o<1/2` | pura única | simétrica | acordo imediato com `H` | interior da região; cutoffs de voto vinculantes | payoff e outcome únicos |
| Maioria R1, inclusão | `theta=0` ou `1` | `m=2`, `o=1/2` | pura única | simétrica | acordo imediato com `H` | fronteira inclusão/exclusão; tie-break escolhe inclusão | sem mistura entre ramos |
| Maioria R1, exclusão | `theta=0` ou `1` | `m=2`, `o>1/2` | pura única | simétrica | acordo imediato sem `H` | interior da região; cutoffs fracos vinculantes | payoff e outcome únicos |
| Maioria R1, inclusão | `theta=0` ou `1` | `m>=3`, `o<1/m` | pura ou mista dentro do ramo | simétrica por sorteio uniforme ou assimétrica por coalizão | acordo imediato com `H` | interior da região; cutoffs vinculantes | mesmo outcome e payoffs de `H`/proponente; payoff fraco pode variar por identidade |
| Maioria R1, inclusão | `theta=0` ou `1` | `m>=3`, `o=1/m` | pura ou mista dentro do ramo | simétrica ou assimétrica | acordo imediato com `H` | fronteira inclusão/exclusão; tie-break escolhe inclusão | sem mistura entre ramos; composição pode variar |
| Maioria R1, exclusão | `theta=0` ou `1` | `m=3`, `o>1/3` | pura única | simétrica | acordo imediato sem `H` | interior da região | payoff e outcome únicos |
| Maioria R1, exclusão | `theta=0` ou `1` | `m>=4`, `o>1/m` | pura ou mista dentro do ramo | simétrica ou assimétrica por coalizão | acordo imediato sem `H` | interior da região | mesmo outcome e payoffs de `H`/proponente; payoff fraco pode variar por identidade |
| Unanimidade R1 | `theta=0` ou `1` | `m=2` | pura única | simétrica | acordo imediato com `H` | cutoffs vinculantes; longe da fronteira de atraso porque `1-beta>0` | nenhuma |
| Unanimidade R1 | `theta=0` ou `1` | `m>=3` | pura única | simétrica | acordo imediato com `H` | cutoffs vinculantes; longe da fronteira de atraso porque `1-beta>0` | nenhuma |

## 9. Relação com as distinções do gate

- Não aparece estratégia mista genuína entre acordo imediato e atraso.
- Sob maioria pode aparecer aleatorização entre propostas payoff-equivalentes
  dentro de um ramo e assimetria pura na composição da coalizão.
- Sob unanimidade pública não aparece heterogeneidade pura entre identidades de
  proponentes nos papéis de acordo e atraso.
- Não aparece multiplicidade apenas de crenças fora do caminho, pois o tipo é
  público e a continuação terminal é payoff-única.
- Impor anonimato ou simetria ainda seria uma restrição adicional: a
  correspondência de maioria preserva estratégias de coalizão assimétricas.

Esses fatos classificam somente os benchmarks públicos. Eles não selecionam
quais avaliações privadas devem ser comparadas e não autorizam qualquer
conclusão sobre renda informacional.

## 10. Ledger lógico

| Claim | Status | Conteúdo |
|---|---|---|
| `N7A-C01` | proved | o tipo público induz crença degenerada após toda história |
| `N7A-C02` | proved | R2-maioria passa sem `H` com proposta `(0,0,1)` |
| `N7A-C03` | proved | R2-unanimidade passa com `H` em `y=o` |
| `N7A-C04` | proved | as continuações de R2 entram em R1 com exatamente um `beta` |
| `N7A-C05` | proved | cutoffs fracos de R1 são `a_M` e `a_U` |
| `N7A-C06` | proved | a IC de `H` preserva os ramos pivotal, não pivotal e falha certa |
| `N7A-C07` | proved | R1-maioria reduz-se a inclusão ou exclusão de custo mínimo |
| `N7A-C08` | proved | a fronteira de ramo é `o=1/m` e o tie-break escolhe inclusão |
| `N7A-C09` | proved | exclusão supera atraso por `1-beta*q/m>0` |
| `N7A-C10` | proved | R1-unanimidade supera atraso por `1-beta>0` |
| `N7A-C11` | proved | toda mistura sobrevivente é interna a um ramo de coalizões payoff-equivalentes |
| `N7A-C12` | proved | o caso `m=2` é completo, mas o escopo substantivo principal é `m>=3` |
| `N7A-C13` | proved | o candidato não contém ligação privada nem cálculo de renda |
| `N7A-C14` | pending | escolha autoral futura das comparações substantivamente relevantes |

`N7A-C14` é deliberadamente `pending`: é o gate entre as Fases A e B, não uma
lacuna da derivação pública.
