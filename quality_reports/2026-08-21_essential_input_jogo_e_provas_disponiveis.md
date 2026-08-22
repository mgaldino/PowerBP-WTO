# O jogo *essential-input* e as demonstrações disponíveis

**Data:** 21 de agosto de 2026  
**Finalidade:** registrar o jogo, a intuição dos resultados e as demonstrações matemáticas disponíveis no ponto de parada  
**Estatuto:** relatório de prova; não congela nós, não substitui pareceres e não autoriza trabalho posterior

## 1. O que este relatório permite afirmar

O projeto não parou apenas com conjecturas numéricas. Há demonstrações legíveis e verificáveis por um leitor humano:

- `N1` e `N2` têm derivações fechadas, dois pareceres independentes e interfaces congeladas;
- `N3-v5` tem uma derivação organizada em dezessete claims e foi rederivado independentemente por dois revisores, que não encontraram erro matemático;
- `N4-v4` tem uma derivação escrita, incluindo a correção condicionada ao tipo e uma prova de necessidade e suficiência para o problema dos múltiplos vetos. A maior parte da matemática de `N4-v3` foi confirmada por dois revisores; a v4 incorporou o único erro matemático localizado, mas não recebeu o ciclo final de dois pareceres.

Portanto, o estatuto correto é:

| Nó | Estatuto matemático | Estatuto administrativo |
|---|---|---|
| `N1` | demonstração fechada | `PASS/frozen` |
| `N2` | demonstração fechada | `PASS/frozen` |
| `N3` | demonstração completa disponível e duas rederivações concordantes | `pending/unfrozen`, por falha da certificação eletrônica |
| `N4` | demonstração provisória avançada; núcleo bem sustentado, correspondência completa ainda sem revisão final da v4 | `pending/unfrozen` |
| `N6` e `N7` | sem resultado válido sob dependências fechadas | `pending/unfrozen` |

O fracasso do certificador tipado não é uma refutação da matemática. Ele mostra apenas que o software não conseguiu provar, de maneira independente, que todo campo serializado reproduzia exatamente a derivação. Este relatório volta ao objeto relevante para um paper de teoria formal: proposições e demonstrações que um referee possa conferir linha a linha.

## 2. O jogo

### 2.1 Jogadores e informação

Há `N >= 3` Estados:

- um hegemon, `H`;
- `m=N-1` Estados fracos, reunidos no conjunto `W`.

A natureza sorteia o tipo do hegemon:

```text
theta em {0,1},     Pr(theta=1)=nu.
```

O tipo `theta=1` tem a opção externa maior. O hegemon observa seu tipo; os Estados fracos não o observam. A crença pública inicial de que o tipo é alto é `nu`.

### 2.2 Horizonte, reconhecimento e propostas

O jogo tem dois rounds. O segundo round é terminal. Em cada round, somente um Estado fraco é reconhecido como proponente. Cada Estado fraco tem probabilidade `1/m` de reconhecimento. O hegemon nunca propõe no baseline.

Uma proposta do Estado fraco `i` é

```text
s = (y, (x_j)_{j em W sem i}, r_i),
```

em que:

- `y` é a concessão ao hegemon;
- `x_j` é a parcela destinada ao respondente fraco `j`;
- `r_i` é o resíduo do proponente;
- `0 <= y <= y_bar`, `x_j >= 0`, `r_i >= 0`;
- `y + sum_j x_j + r_i <= 1`.

A torta institucional tem tamanho fixo igual a um. A opção externa do hegemon não é retirada dessa torta.

### 2.3 Votação

O proponente conta como voto favorável. Todos os demais jogadores votam simultaneamente `sim` ou `não`. Os votos só se tornam públicos depois de encerrado o ballot.

- sob maioria, a quota é `q=floor(N/2)+1`;
- sob unanimidade, todos os `N` votos são necessários.

Não há ação de saída. Um voto contrário de `H` é somente um voto contrário.

### 2.4 Payoffs e desconto

Os Estados fracos recebem as parcelas da proposta aprovada. Se nenhuma proposta for aprovada até o fim do segundo round, recebem zero.

O payoff de desacordo do hegemon do tipo `theta` é `o_theta`, com

```text
0 < o_0 < o_1 < 1,      o_1 <= y_bar <= 1.
```

Se uma proposta sob maioria passa apesar do voto contrário de `H`, o hegemon recebe `y+o_theta`. A opção externa é externa à torta institucional.

O fator de desconto satisfaz

```text
0 < beta < 1.
```

Os payoffs do segundo round são medidos na data do segundo round. Quando entram nos incentivos do primeiro round, recebem exatamente um fator `beta`.

### 2.5 Conceito de solução

O conceito é PBE, com:

- estratégias puras no ballot;
- votação não dominada por estágio para os respondentes fracos;
- PBE sem essa restrição adicional para `H`;
- Bayes em toda história de probabilidade positiva;
- crenças livres nas histórias de probabilidade zero, respeitada a informação do jogo;
- `T^Y`: em uma indiferença genuína, o votante escolhe `sim`;
- entre propostas que dão o mesmo payoff ao proponente, seleciona-se a que minimiza o payoff esperado de `H`.

### 2.6 Dependências dinâmicas

A indução retroativa correta é:

```text
N1: R2 maioria      -> N3: R1 maioria
N2: R2 unanimidade  -> N4: R1 unanimidade

N3 + N4             -> N6: comparação institucional
N6                  -> N7: benchmark/renda informacional
```

Somente `N1` e `N2` estão congelados. As demonstrações de `N3` e `N4` são registradas abaixo sem convertê-las em dependências consumíveis.

## Parte I — Intuição das demonstrações

## 3. Segundo round sob maioria: o hegemon é dispensável

No último round, os Estados fracos conseguem formar sozinhos a maioria. Um respondente fraco aceita qualquer parcela positiva; se recebe zero, fica genuinamente indiferente e `T^Y` também o leva a votar `sim`.

Como os votos fracos bastam para aprovar a proposta, o voto de `H` não é pivotal. `H` prefere votar `não`: assim recebe a concessão `y` e, adicionalmente, sua opção externa `o_theta`. Se votar `sim`, recebe apenas `y`.

Antecipando isso, o proponente não precisa comprar nenhum voto nem conceder nada ao hegemon. Retém toda a torta. A maioria elimina o poder de veto de `H` no último round.

## 4. Segundo round sob unanimidade: a proposta compra o tipo baixo ou os dois tipos

Sob unanimidade, `H` é indispensável. O tipo baixo aceita quando `y>=o_0`; o alto, quando `y>=o_1`.

O proponente enfrenta uma escolha simples:

1. oferecer `o_0`, obtendo acordo somente quando o tipo é baixo;
2. oferecer `o_1`, obtendo acordo com ambos os tipos.

A primeira opção rende `(1-nu)(1-o_0)` ao proponente; a segunda rende `1-o_1`. O prior determina qual é maior. No empate, a regra que minimiza o payoff de `H` escolhe a oferta menor.

Esta é a continuação que cria o problema informacional do primeiro round sob unanimidade.

## 5. Primeiro round sob maioria: exclusão, screening ou pooling

Depois de uma rejeição no primeiro round, cada Estado fraco espera receber `beta/m` no segundo round sob maioria. O proponente pode, portanto:

- comprar votos fracos suficientes para excluir `H`;
- comprar um voto fraco a menos e tornar `H` pivotal;
- quando `H` é pivotal, oferecer o valor de continuação do tipo baixo, produzindo screening;
- oferecer o valor de continuação do tipo alto, produzindo pooling.

Uma proposta deliberadamente rejeitada não é ótima: como `beta<1`, comprar a maioria fraca e concluir imediatamente dá ao proponente um valor estritamente maior que esperar.

A comparação entre exclusão, screening e pooling depende de duas forças:

- quanto custa comprar o voto de `H`, governado por `o_0` e `o_1`;
- quão provável é o tipo alto, governado por `nu`.

Quando o tipo alto é raro, pode valer a pena oferecer apenas o necessário ao tipo baixo. Quando é frequente e barato, pooling torna-se atraente. Quando a opção externa de `H` é cara, os Estados fracos o excluem.

## 6. Primeiro round sob unanimidade: multiplicidade e atraso

Sob unanimidade, todo acordo imediato precisa de todos os Estados fracos e de `H`. A rejeição no primeiro round leva ao subgame de unanimidade do segundo round, no qual a continuação depende da informação revelada pelos votos.

A primeira correção indispensável é condicionar os payoffs realizados ao tipo. Quando a continuação do segundo round oferece apenas ao tipo baixo:

- no estado baixo, o acordo passa e os Estados fracos recebem sua parcela;
- no estado alto, `H` rejeita e os Estados fracos recebem zero.

Logo, o vetor realizado dos payoffs fracos é `(A,0)`, não `(A,A)`. Antes de conhecer o tipo, o voto fraco usa o valor esperado; ao avaliar um desvio do proponente, deve-se integrar o vetor realizado sob a prior verdadeira.

Três classes puras sobrevivem na derivação:

- `P`: pooling, aceito pelos dois tipos;
- `L`: oferta aceita somente pelo tipo baixo, possível apenas quando `nu=0`;
- `D`: atraso, produzido por veto de `H` ou de um ou mais Estados fracos.

O resultado `L` desaparece quando `nu>0` porque a rejeição do tipo alto revela sua identidade e melhora a continuação. O tipo baixo pode imitar essa rejeição; uma oferta abaixo da continuação resultante não o mantém aceitando.

Com pelo menos três Estados fracos, há flexibilidade para sustentar atrasos com múltiplos vetos. Com apenas dois Estados fracos, essa flexibilidade desaparece e a garantia do proponente depende de vários limites e de diferenças entre máximo e supremo.

A multiplicidade por identidade tem uma interpretação substantiva: Estados formalmente idênticos podem desempenhar papéis diferentes porque suas identidades são públicas e as expectativas podem associar a cada identidade uma conduta distinta. Isso não exige diferenças de preferências, mas exige que as estratégias e crenças formem um PBE.

## Parte II — Demonstrações disponíveis

## 7. Proposição N1 — segundo round sob maioria

### Enunciado

No segundo round sob maioria, existe uma única classe de estratégias, resultado e payoffs:

```text
y=0,   x_j=0 para todo j,   r_i=1.
```

A proposta passa sem o voto de `H`. O proponente recebe `1`, cada Estado fraco tem valor pré-reconhecimento `1/m`, e `H(theta)` recebe `o_theta`.

### Demonstração

Fixe uma proposta factível e um respondente fraco `j`.

1. Se `j` é pivotal, `sim` paga `x_j>=0` e `não` leva ao desacordo, que paga zero. Para `x_j>0`, `sim` é estritamente melhor; em `x_j=0`, `T^Y` seleciona `sim`.
2. Se `j` não é pivotal, os dois votos geram o mesmo resultado; novamente, `sim` é admissível e a igualdade é resolvida por `T^Y`.
3. Os `m` votos fracos, incluindo o proponente, atingem a quota `q`. Portanto, a proposta passa independentemente do voto de `H`.
4. Como `H` não é pivotal, `sim` paga `y`, enquanto `não` paga `y+o_theta`. Como `o_theta>0`, `H` vota `não` estritamente.
5. O proponente não precisa pagar nenhum respondente nem `H`. Qualquer `y>0` ou `x_j>0` reduz seu resíduo sem alterar a aprovação. Logo, a proposta ótima única é `y=0`, todos os `x_j=0` e `r_i=1`.

Isso prova o resultado. Não há `beta` dentro do round terminal. A única multiplicidade possível está em crenças fora do caminho sem efeito sobre estratégias ou payoffs. `QED`.

## 8. Proposição N2 — segundo round sob unanimidade

### Enunciado

Defina

```text
nu_star = (o_1-o_0)/(1-o_0).
```

Então:

- se `0<=nu<=nu_star`, o proponente oferece `y=o_0`; somente o tipo baixo aceita;
- se `nu_star<nu<=1`, o proponente oferece `y=o_1`; ambos os tipos aceitam.

Os respondentes fracos recebem zero e o proponente retém o resíduo. Na igualdade, a oferta apenas ao tipo baixo é selecionada pelo desempate.

### Demonstração

1. Sob unanimidade, cada respondente fraco é pivotal. Como seu desacordo terminal é zero, aceita todo `x_j>0`; em `x_j=0`, `T^Y` seleciona `sim`.
2. `H(theta)` é pivotal e compara `y` com `o_theta`. Portanto, aceita se, e somente se, `y>=o_theta`.
3. Dentro de qualquer conjunto de tipos que se pretende induzir a aceitar, o proponente escolhe a menor oferta compatível e atribui zero aos respondentes fracos.
4. Uma oferta abaixo de `o_0` é rejeitada pelos dois tipos e rende zero. Ofertas em `[o_0,o_1)` são aceitas somente pelo tipo baixo e são maximizadas em `y=o_0`, com payoff esperado

   ```text
   V_L=(1-nu)(1-o_0).
   ```

5. Ofertas em `[o_1,y_bar]` são aceitas pelos dois tipos e são maximizadas em `y=o_1`, com payoff

   ```text
   V_P=1-o_1.
   ```

6. `V_L>=V_P` se, e somente se,

   ```text
   (1-nu)(1-o_0) >= 1-o_1
   <=> nu <= (o_1-o_0)/(1-o_0)=nu_star.
   ```

7. Na igualdade, a oferta `o_0` dá payoff esperado menor a `H` que a oferta `o_1`, sendo selecionada pelo desempate.

Como `0<o_0<o_1<1`, vale `0<nu_star<1`. Isso completa a prova. `QED`.

## 9. Proposição provisória N3 — primeiro round sob maioria

### 9.1 Enunciado e notação

Importe `N1` e defina

```text
c       = beta/m
a_theta = beta*o_theta

E = 1-beta*(q-1)/m
L = 1-beta*o_0-beta*(q-2)/m
S(nu) = (1-nu)*L + nu*beta/m
P = 1-beta*o_1-beta*(q-2)/m
R = beta/m.
```

Os quatro valores são, respectivamente:

- `E`: exclusão de `H`;
- `S`: screening, com oferta aceita somente pelo tipo baixo;
- `P`: pooling;
- `R`: rejeição deliberada e continuação.

A correspondência de equilíbrio é obtida escolhendo o maior entre `E`, `S(nu)` e `P`; `R` é sempre estritamente inferior a `E`. Nas igualdades, aplica-se o desempate que minimiza o payoff esperado de `H`.

### 9.2 Lema: cutoff dos respondentes fracos

Um respondente fraco vota `sim` se, e somente se,

```text
x_j >= beta/m.
```

**Prova.** Se é pivotal, `sim` paga `x_j` e `não` conduz a `N1`, valendo `beta/m`. Se não é pivotal, os votos produzem o mesmo payoff. Assim, `sim` domina fracamente quando `x_j>beta/m`, `não` domina fracamente quando `x_j<beta/m`, e `T^Y` seleciona `sim` na igualdade. `QED`.

### 9.3 Lema: melhor resposta de H

Se `k` é o número de respondentes fracos que recebem pelo menos `beta/m`, então:

1. se `k>=q-1`, a proposta passa sem `H`; `H` vota `não` e recebe `y+o_theta`;
2. se `k=q-2`, `H` é pivotal e o tipo `theta` vota `sim` se, e somente se, `y>=beta*o_theta`;
3. se `k<=q-3`, a proposta falha qualquer que seja o voto de `H`; as ações são payoff-idênticas e `T^Y` seleciona `sim`.

**Prova.** Os três casos particionam todos os valores inteiros possíveis de `k`. No primeiro, o resultado não depende de `H`, e votar `não` acrescenta a opção externa. No segundo, votar `sim` implementa `y`, enquanto votar `não` entrega a continuação `beta*o_theta`. No terceiro, ambos os votos levam à mesma continuação. `QED`.

### 9.4 Lema: redução exaustiva

Para cada classe de resultado, qualquer pagamento que não altera um voto pode ser transferido ao resíduo do proponente. Consequentemente:

- exclusão ótima compra exatamente `q-1` respondentes fracos, pagando `beta/m` a cada um e `y=0`, produzindo `E`;
- screening ótimo compra exatamente `q-2` respondentes fracos e oferece `beta*o_0` a `H`, produzindo `S(nu)`;
- pooling ótimo compra exatamente `q-2` respondentes fracos e oferece `beta*o_1` a `H`, produzindo `P`;
- toda proposta rejeitada para todos os tipos produz `R`.

Essas quatro classes cobrem todas as propostas factíveis porque o número de votos fracos favoráveis determina se `H` é dispensável, pivotal ou incapaz de alterar o resultado; quando pivotal, os dois cutoffs de `H` particionam as ofertas em rejeição, aceitação apenas pelo tipo baixo e aceitação por ambos. `QED`.

### 9.5 Lema: rejeição deliberada não é ótima

Como `q<=m` e `0<beta<1`,

```text
E-R = 1-beta*q/m > 0.
```

Portanto, nenhuma proposta deliberadamente rejeitada pertence ao suporte de equilíbrio. Isso não elimina o atraso informativo: em screening, o tipo alto rejeita e o jogo segue para `N1` com probabilidade `nu`.

### 9.6 Comparações e fronteiras

As comparações relevantes são

```text
P-E = beta*(1/m-o_1),

S-E = (1-nu)*beta*(1/m-o_0)
      -nu*(1-beta*q/m).
```

Defina

```text
nu_SP = beta*(o_1-o_0)
        / [1-beta*o_0-beta*(q-1)/m],

nu_SE = beta*(1/m-o_0)
        / [beta*(1/m-o_0)+1-beta*q/m].
```

As onze células resultantes são:

| Opções externas | Prior | Resultado |
|---|---|---|
| `o_1<1/m` | `0<=nu<=nu_SP` | screening |
| `o_1<1/m` | `nu_SP<nu<=1` | pooling |
| `o_0<1/m<o_1` | `0<=nu<=nu_SE` | screening |
| `o_0<1/m<o_1` | `nu_SE<nu<=1` | exclusão |
| `1/m<o_0<o_1` | todo `nu` | exclusão |
| `o_0=1/m<o_1` | `nu=0` | screening |
| `o_0=1/m<o_1` | `nu>0` | exclusão |
| `o_0<o_1=1/m` | `nu<=nu_SE` | screening |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_E<h_P` | exclusão |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_P<h_E` | pooling |
| `o_0<o_1=1/m` | `nu>nu_SE` e `h_E=h_P` | exclusão, pooling e misturas |

Nas três últimas linhas,

```text
h_E=(1-nu)*o_0+nu/m,
h_P=beta/m.
```

**Prova da partição.**

1. O sinal de `P-E` depende apenas de `o_1` em relação a `1/m`.
2. Quando `o_0<1/m`, `S-E` é decrescente em `nu` e cruza zero em `nu_SE`.
3. Quando pooling pode superar exclusão, a comparação `S=P` produz `nu_SP`.
4. Se `o_0>1/m`, screening já é inferior à exclusão em `nu=0` e permanece inferior para priors maiores.
5. As igualdades `S=P` e `S=E` pertencem a screening pelo desempate.
6. No knife-edge `o_1=1/m`, `E=P`; acima da região de screening, o desempate compara o payoff esperado de `H` em exclusão e pooling. Se também empata, nenhum dos dois ramos pode ser eliminado, e todas as misturas permanecem.

Esses casos são mutuamente exclusivos e cobrem `0<o_0<o_1<1` e `nu` em `[0,1]`. `QED`.

### 9.7 Payoffs e multiplicidade

- screening: `H` recebe `(beta*o_0,beta*o_1)`; acordo imediato com o tipo baixo e atraso com o alto;
- pooling: `H` recebe `(beta*o_1,beta*o_1)`; acordo imediato para ambos;
- exclusão: `H` recebe `(o_0,o_1)`; a proposta passa sem seu voto;
- no knife-edge residual, misturas entre pooling e exclusão preservam-se, inclusive com probabilidades dependentes da identidade do proponente.

### 9.8 Estatuto desta prova

A derivação acima foi reconstruída por dois revisores independentes a partir das primitivas e de `N1`. Ambos confirmaram as fórmulas, os endpoints, as onze células, os payoffs e a multiplicidade. O `FAIL` administrativo de `N3-v5` decorreu da incapacidade do verificador eletrônico de garantir equivalência semântica de cada campo, não de um contraexemplo ao equilíbrio.

Portanto, esta é uma demonstração matemática forte, mas `N3` continua formalmente `pending/unfrozen`.

## 10. Caracterização provisória N4 — primeiro round sob unanimidade

### 10.1 Notação e continuação condicionada ao tipo

Defina

```text
nu_star = (o_1-o_0)/(1-o_0)
ell     = beta*o_0
h       = beta*o_1
A       = beta*(1-o_0)/m
B       = beta*(1-o_1)/m
D       = (1-nu)*A
C       = D, se nu<=nu_star; B, se nu>nu_star.
```

Quando `N2` escolhe a oferta aceita apenas pelo tipo baixo:

- o valor subjetivo de um Estado fraco sob posterior `eta` é `A*(1-eta)`;
- seu vetor de payoff realizado por tipo é `(A,0)`;
- o vetor de continuação de `H` é `(ell,h)`.

Quando `N2` escolhe pooling:

- o payoff fraco é `B` nos dois estados, vetor `(B,B)`;
- `H` recebe `(h,h)`.

**Prova.** No primeiro caso, a proposta terminal passa no estado baixo e é rejeitada no estado alto. Logo, o payoff realizado fraco é positivo no primeiro estado e zero no segundo. O valor subjetivo é a esperança desse vetor. No pooling, a proposta passa em ambos os estados. Todos os valores já contêm exatamente um fator `beta`. `QED`.

### 10.2 Lema: classes puras exaustivas

As classes puras candidatas são:

- `P`: os dois tipos de `H` e todos os respondentes fracos votam `sim`;
- `L`: `H0` vota `sim`, `H1` vota `não` e todos os fracos votam `sim`;
- `D`: a proposta falha no primeiro round por veto de `H`, de um fraco ou de múltiplos fracos.

Não existe classe aceita apenas pelo tipo alto: isso exigiria simultaneamente `Y<ell` para o tipo baixo rejeitar e `Y>=h` para o alto aceitar, impossível porque `ell<h`.

A classe `L` só pode existir em `nu=0`. Se `nu>0`, a rejeição de `H1` ocorre com probabilidade positiva, revela o tipo alto e conduz à continuação pooling de `N2`, que paga `h` a `H`. O tipo baixo pode imitar a rejeição e também obter `h`; portanto, não aceita uma oferta `Y<h`, condição necessária para separar os tipos.

Com veto fraco, o tipo alto de `H` vota `sim`; as restrições de Bayes e melhor resposta do tipo baixo novamente impedem separação adicional pelo voto de `H`. Assim, `P`, `L` em `nu=0` e `D` esgotam as classes puras sustentadas pela derivação. `QED`.

### 10.3 Lema: pagamentos mínimos em acordo

Nas classes `P` e `L`, cada respondente fraco precisa receber

```text
x_j >= B.
```

Esse é o menor valor de continuação que precisa ser coberto para que `sim` sobreviva às comparações relevantes do ballot, com igualdade resolvida por `T^Y`.

Para um único veto fraco de identidade `k`, a condição é

```text
x_k <= C,
```

incluindo a igualdade.

### 10.4 Lema dos múltiplos vetos

Considere `m>=3` e pelo menos dois respondentes fracos votando `não` on path.

O perfil é sustentável sob as seguintes condições:

```text
nu<nu_star:  nenhuma restrição além da factibilidade;
nu>=nu_star: x_k<=B para todo Estado fraco k que veta.
```

#### Necessidade quando `nu>=nu_star`

O vetor de múltiplos vetos ocorre on path e não revela o tipo, de modo que Bayes fixa a continuação fraca em `C=B`. Se um dos vetantes troca unilateralmente `não` por `sim`, ainda resta ao menos outro veto e a proposta continua falhando. Esse desvio paga ao menos `B`.

Se `não` pagasse menos que `sim`, não seria melhor resposta. Se ambos fossem idênticos em todas as contingências, `T^Y` selecionaria `sim`. Para sustentar `não`, é preciso que ele domine fracamente `sim` e seja estrito em alguma contingência.

Aplicando o mesmo argumento sucessivamente aos subconjuntos do conjunto de vetos, todos os vetores não vazios relevantes precisam entregar `B`. Na linha em que `k` se torna pivotal, `não` paga `B` e `sim` paga `x_k`. Portanto, necessariamente `x_k<=B`.

#### Suficiência

Suponha `x_k<=B` para todos os vetantes. Prescreva pooling nas continuações fora do caminho relevantes, pagando `B` aos fracos. No vetor realizado, Bayes seleciona a continuação de `N2` correspondente. Construa os demais vetores de maneira que:

- cada vetante tenha `não` fracamente dominante e alguma linha estrita;
- cada não vetante tenha alguma linha estrita favorável a `sim`;
- `H0` e `H1` sigam suas melhores respostas, com `T^Y` na igualdade.

Como `x_k<=B`, nenhum vetante ganha ao se tornar pivotal e votar `sim`. A construção inclui `x_k=B`; logo a fronteira é fechada.

#### Região `nu<nu_star`

Nessa região, o vetor on path paga `D>B`, enquanto o desvio unilateral pode ser associado à continuação pooling, que paga `B`. A desigualdade estrita impede que `sim` domine `não`, independentemente de `x_k`; por isso não surge limite adicional.

Isso prova a condição corrigida. `QED`.

### 10.5 Proposição provisória: segurança para `m>=3`

Para `m>=3`, o valor de segurança do proponente é

```text
S_3(nu)=(1-nu)*B.
```

**Demonstração disponível.** Depois de uma proposta de probabilidade zero, prescreva todos os respondentes fracos em `não`, `H0` em `não` e `H1` em `sim`. Use pooling no vetor associado a `H0` e a continuação aceita apenas pelo tipo baixo no vetor associado a `H1`. Como a proposta está fora do caminho, Bayes não fixa esses posteriores. As continuações podem ser escolhidas dentro do conjunto permitido para sustentar os votos. O proponente recebe `(B,0)`, cujo valor esperado é `(1-nu)B`.

Por outro lado, uma proposta com `Y=0` garante ao proponente pelo menos esse vetor contra qualquer resposta admissível. Portanto, o limite inferior é também superior: `S_3` é exato e atingido.

A correção dos múltiplos vetos não altera essa construção, pois ela restringe vetos on path; a punição que define a segurança está fora do caminho. `QED`, sujeito à revisão final integral de N4-v4.

### 10.6 Caracterização provisória para `m=2`

Com somente dois Estados fracos, defina

```text
Q_L = 1-ell-A
Q_P = 1-h-A
R_0 = min{D,B}
R_L = min{(1-nu)*Q_L,B}
R_P = max{0,Q_P}
S_2 = max{R_0,R_L,R_P}
H_L = (1-nu)*ell+nu*h.
```

A demonstração disponível decompõe todos os desvios do proponente em três canais, cujos supremos são `R_0`, `R_L` e `R_P`. Assim, sua segurança é o máximo entre eles.

Os detalhes topológicos são:

- `R_0` é atingido em `x=A`;
- `R_P>0` é apenas supremo no subproblema de passagem forçada, pois requer `x>A`;
- para `nu<1`, `R_L` é atingido quando `(1-nu)Q_L>B`; na igualdade ou abaixo, é apenas supremo;
- em `nu=1`, o valor zero é atingido.

O menor payoff de `H` entre desvios que efetivamente atingem `S_2` é

```text
H_tie = H_L,    se S_2=R_0=D<B;
        h,      se algum componente atingido iguala S_2 e o caso anterior falha;
        +infty, se apenas componentes não atingidos alcançam S_2 como supremo.
```

Esse objeto governa o desempate no endpoint; não transforma um supremo não atingido em uma ação disponível.

Esta é a parte menos consolidada da derivação. Ela foi confirmada na revisão de N4-v3, mas a correspondência N4-v4 completa não passou por um novo ciclo independente. Deve ser tratada como prova provisória, não como resultado fechado.

### 10.7 Famílias de equilíbrio provisórias

Use `S=S_3` quando `m>=3` e `S=S_2` quando `m=2`.

#### Pooling `P`

```text
h <= Y <= y_bar,
x_j >= B para todo j,
r_i >= S,
Y+sum_j x_j+r_i <= 1.
```

Se `m>=3` e `r_i=S_3`, o desempate exige `Y=h`. Para `m=2` e `r_i=S_2`, exige `Y<=H_tie`.

#### Oferta aceita somente pelo tipo baixo `L`

Somente em `nu=0`:

```text
ell <= Y < h,
x_j >= B para todo j,
r_i >= S,
Y+sum_j x_j+r_i <= 1.
```

O mínimo `Y=ell` é atingido; `Y=h` é somente supremo, pois em `h` o tipo alto também aceita.

#### Atraso `D`

O proponente recebe `C`. Para `m>=3`, `C>S_3`, e a derivação sustenta atraso para todo prior. Para `m=2`, atraso existe se, e somente se,

```text
C>=S_2.
```

As implementações incluem veto de `H`, veto fraco único e, quando `m>=3`, conjuntos identificados de múltiplos vetos sujeitos ao lema anterior.

### 10.8 Misturas e identidades

Não se impõe simetria entre Estados fracos identificados publicamente. A derivação preserva:

- diferentes identidades de vetantes;
- diferentes pacotes dentro de cada família;
- mistura `L/D` em `(Y,r_i)=(ell,A)` quando `nu=0`;
- mistura `P/D` em `(Y,r_i)=(h,B)` quando `nu>nu_star`, se `D` existir.

Cada suporte dessas misturas dá o mesmo vetor de payoff a `H`. A aleatorização altera a frequência de acordo imediato e atraso, mas não a renda de `H` dentro desses suportes específicos.

### 10.9 Estatuto desta prova

Dois revisores independentes de `N4-v3` confirmaram:

- a contabilidade condicionada ao tipo;
- as classes `P/L/D`;
- a segurança `S_3` e a fórmula `S_2`;
- endpoints, misturas e payoffs por identidade.

Um deles encontrou um erro matemático real: a v3 incluía indevidamente alguns perfis on path com múltiplos vetos quando `nu>=nu_star`. O parecer forneceu uma contraprova e a condição correta. A v4 incorporou essa condição e apresenta a prova reproduzida na Seção 10.4.

O que falta é uma revisão fria integral da v4 já corrigida. Assim:

- o núcleo de `N4`, especialmente para `m>=3`, tem sustentação matemática relevante;
- a correspondência completa permanece provisória;
- a parte `m=2`, além de substantivamente periférica para a aplicação pretendida, é a mais delicada matematicamente.

## 11. O que pode ser verificado hoje

Um leitor pode verificar as demonstrações sem utilizar a infraestrutura de certificação interrompida:

1. conferir as primitivas e o timing do jogo;
2. verificar `N1` e `N2` diretamente por indução retroativa terminal;
3. em `N3`, conferir os cutoffs, os três casos de pivotalidade de `H`, a redução a `E/S/P/R` e os sinais que produzem as onze células;
4. em `N4`, verificar o vetor realizado `(A,0)`, a exaustividade de `P/L/D`, o argumento contra separação com prior positivo e a necessidade/suficiência do limite multi-veto;
5. conferir separadamente a construção de segurança para `m>=3`;
6. tratar `m=2`, endpoints e mistura como a parte que exige maior cautela.

Não é necessário aceitar buscas por tokens, hashes internos ou centenas de milhares de adulterações de schema como prova da teoria.

## 12. Lacunas remanescentes

Este relatório não resolve:

- a revisão final de `N4-v4` por dois leitores independentes;
- a transformação das demonstrações em proposições e apêndice do manuscrito;
- a comparação institucional `N6`;
- a renda informacional e o benchmark `N7`;
- uma formalização em assistente de provas;
- seleção entre equilíbrios de `N4` além do que já decorre das primitivas e do desempate declarado.

Não há autorização implícita para preencher essas lacunas.

## 13. Proveniência

Fontes matemáticas preservadas na linha de trabalho interrompida:

| Objeto | Caminho no repositório | Hash/estatuto |
|---|---|---|
| N1 | `model_redesign/essential_input_interfaces/n1_r2_majority_candidate_v1.json` | `1a171791...981b5`, frozen |
| N2 | `model_redesign/essential_input_n2_r2_unanimity_interface.json` | `c6a65dc8...a85a2`, frozen |
| N3-v5 | `model_redesign/essential_input_n3_r1_majority_derivation_v5.md` | candidato `b30c63ac...405cb`, não frozen |
| revisão N3 game theory | `quality_reports/2026-08-20_n3_v5_game_theory_review_round3.md` | matemática confirmada; certificador reprovado |
| revisão N3 formal design | `quality_reports/2026-08-20_n3_v5_formal_design_review_round3.md` | matemática confirmada; finding epistemológico do certificador |
| N4-v4 | `model_redesign/essential_input_n4_r1_unanimity_derivation_v4.md` | intermediário `84570652...e8c3f6b` |
| nota fria N4-v4 | `model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md` | intermediário `a2f44b0b...e4c7` |
| revisão N4 formal design | `quality_reports/2026-08-20_n4_v3_formal_design_review_round1.md` | correção multi-veto demonstrada |
| revisão N4 game theory | `quality_reports/2026-08-20_n4_v3_game_theory_review_round1.md` | restante da matemática confirmado; certificador reprovado |

O snapshot anterior, com o estado administrativo completo, está registrado no commit `94367dff7b71ce34dbfe9503b57b8592e29fdc77` da worktree interrompida.

## 14. Conclusão

Há provas matemáticas verificáveis. `N3` está próximo de uma proposição fechada do ponto de vista substantivo; seu bloqueio foi de certificação eletrônica. `N4` contém uma estrutura demonstrada e uma correção explícita do único erro matemático encontrado, mas sua correspondência completa ainda merece o rótulo provisório.

O estado correto do conhecimento não é “não sabemos se há equilíbrio correto”, nem “tudo está provado”. É:

> `N1/N2` estão fechados; `N3` tem prova substantiva forte; `N4` tem uma prova avançada, com núcleo bem sustentado e fronteiras ainda sujeitas a revisão final.

