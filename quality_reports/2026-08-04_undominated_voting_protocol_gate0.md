# Gate 0 — PBE com votação fracamente não dominada em ballot simultâneo

**Data:** 2026-08-04

**Status:** PASS após stress test terminal, reparo e rerevisão independente

**Escopo:** baseline limpo `pi_H=0`; nenhum resultado do v6 é presumido

## 1. Decisão de protocolo

Cada ballot é simultâneo e selado até o fechamento. O proponente fraco é
contado como voto sim. Todos os demais jogadores ativos escolhem
simultaneamente `Y` ou `N` depois de observar a história pública e a proposta,
mas antes de observar qualquer voto daquele ballot. O vetor completo e o
resultado tornam-se públicos apenas depois do fechamento.

Não existe ordem de votação, posição de `H` na ordem, observação intraballot ou
votação roll-call. Logo, nenhuma análise varia uma ordem de `H` inexistente.

## 2. Primitivos mantidos

Há `N>=3` estados, um hegemon `H` e `m=N-1` estados fracos. Natureza sorteia
`theta in {0,1}` antes de R1; apenas `H` observa seu tipo. O prior é
`mu=Pr(theta=1)`. O domínio primitivo completo é

```text
mu in [0,1], beta in (0,1],
0<=o_0<o_1<=bar_y<=1.
```

O domínio interior regular, tratado primeiro na rederivação, restringe
`mu in (0,1)`, `beta in (0,1)` e `0<o_0<o_1<1`. Os demais loci são fronteiras
ou limites unilaterais e serão rotulados separadamente.

Existem exatamente duas rodadas. Em cada rodada alcançada, um fraco é
reconhecido uniformemente e `pi_H=0`. O bolo institucional dos fracos é um e
independe do tipo. A opção externa de `H` é externa ao bolo. Weak outside
payoffs são zero.

Enquanto `H` está ativo, a proposta do fraco `i` é

```text
s_i=(y,(x_j)_{j != i}),
y in [0,bar_y], x_j>=0,
x_i^H=1-y-sum_{j != i}x_j>=0.
```

Se `H` participa e a proposta passa, `H` recebe `y`; cada fraco nomeado recebe
`x_j`; o proponente recebe o residual. Se `H` vota não e uma maioria fraca
aprova, `y` é reabsorvido pelo proponente e o orçamento fraco continua igual a
um. Ofertas nomeadas são pagas quando a proposta passa mesmo que o destinatário
tenha votado não.

As quotas originais são

```text
Q_U=N,
Q_M=q=floor(N/2)+1.
```

Depois do opt-out, `q` não é recalculado. Unanimidade torna-se impossível;
maioria pode continuar entre os `m` fracos.

## 3. Histórias e payoffs induzidos

Seja `I=(h,s_i)` um conjunto de informação de ballot e seja `z` o número de
votos fracos sim, incluindo o voto automático do proponente.

### 3.1 `H` ativo, unanimidade

- `H=Y` e `z=m`: acordo corrente inclui `H`.
- `H=Y` e `z<m`: em R1 segue R2 com `H` ativo; em R2 há falha terminal.
- `H=N`: opt-out imediato e irreversível; a quota torna-se impossível e o
  ramo termina.

### 3.2 `H` ativo, maioria

- `H=Y` e `z+1>=q`: acordo corrente inclui `H`.
- `H=Y` e `z+1<q`: em R1 segue R2 com `H` ativo; em R2 há falha terminal.
- `H=N` e `z>=q`: acordo corrente weak-only passa e `y` é reabsorvido.
- `H=N` e `z<q`: em R1 segue R2 weak-only; em R2 há falha terminal.

### 3.3 R2 com `H` já ausente, maioria

Esse ballot só pode ocorrer em R2, depois de um opt-out durante o ballot de R1.
Não existe nova proposta de R1 com `H` previamente ausente. Toda proposta fixa
`y=0`:

- `z>=q`: acordo weak-only passa;
- `z<q`: há falha terminal.

### 3.4 Payoffs de `H`

Em R1, para todo vetor fraco `v_W`,

```text
u_H(N,v_W;theta,I)=o_theta.

u_H(Y,v_W;theta,I)=
  y                                      se o acordo corrente inclui H,
  beta*C_H2^R(theta,h_2(Y,v_W))         se fracos causam falha.
```

Em R2, na unidade de R1,

```text
u_H(N,v_W;theta,I_2)=beta*o_theta,

u_H(Y,v_W;theta,I_2)=
  beta*y        se o acordo corrente inclui H,
  beta*o_theta  se o ballot falha.
```

O voto não de `H` nunca entrega `beta*C_H2` em R1.

### 3.5 Payoffs dos fracos

Um fraco `j` recebe `x_j` se a proposta corrente passa, independentemente de
seu voto. Em uma falha de R1, seu payoff no estado verdadeiro `theta` é
`beta*C_Wj2^R(theta,h_2;kappa)`; em uma falha terminal recebe zero. O valor
interim na história é definido separadamente por

```text
bar_C_Wj2^R(h_2;kappa)
  =sum_theta nu(theta|h_2)*C_Wj2^R(theta,h_2;kappa).
```

A continuação pode depender da proposta, do estado verdadeiro por meio do
outcome induzido e do vetor público completo, não apenas do posterior. Essa
indexação evita integrar duas vezes um valor que já seja interim.

## 4. Crenças

A weak-vote-passive assessment permanece uma disciplina de crenças: um desvio
de voto de um fraco desinformado não é tratado como sinal direto de `theta`.
Uma ação separadora de `H` pode atualizar crenças quando `H` continua ativo.
Bayes é aplicado sempre que possível.

Essa assessment não elimina estratégias dominadas e não é chamada de
refinamento. O posterior e o payoff de continuação são objetos distintos.

## 5. Jogo local de votação

Fixe uma única assessment candidata e denote por `kappa` sua restrição às
continuações pós-ballot. A mesma `kappa` é mantida ao comparar `Y` e `N` contra
todos os perfis factíveis: não se escolhe uma continuação diferente para cada
ação. Suas estratégias posteriores também devem satisfazer PBE-UD. O jogo
local em `I` usa os payoffs completos induzidos por essa `kappa`; ele não
substitui continuações distintas por um escalar. Como a admissibilidade pode
mudar com a seleção de continuação, escreve-se explicitamente
`UD_i(I,kappa)`.

Os perfis contrafactuais do teste de dominância não alteram silenciosamente a
assessment ou recalculam suas crenças. A consistência bayesiana é verificada
para a assessment candidata completa; payoffs em cada história fora do caminho
usam a crença e a continuação que essa mesma assessment declara.

### 5.1 Fraco desinformado

Para um fraco não proponente `j`, seja `Omega_-j(I)` o conjunto de perfis puros
factíveis dos demais votantes. Um elemento inclui:

- um voto para cada outro fraco não proponente, sem condicionamento em
  `theta`;
- quando `H` está ativo, um plano de voto de `H` que pode depender de
  `theta`;
- somente ações disponíveis antes do fechamento do ballot.

O conjunto inclui ações que poderão ser eliminadas para outros jogadores. Isso
faz desta uma eliminação **não iterada**; não se restringe `Omega_-j(I)` a um
conjunto já reduzido.

Perfis puros bastam porque os payoffs esperados são afins em misturas. O voto
automático do proponente é fixo pela regra do jogo e, portanto, não é um
componente omitido de `Omega_-j(I)`.

Se `nu_I(theta)` é a crença do fraco em `I`, defina a diferença interim

```text
Delta_j(omega_-j | I,kappa)
  = sum_theta nu_I(theta) *
      [u_j(Y,omega_-j,theta | I,kappa)
       - u_j(N,omega_-j,theta | I,kappa)].
```

Quando `H` já saiu, a soma sobre tipos desaparece.

As correspondências de admissibilidade são:

```text
Y é dominado por N
  iff Delta_j<=0 para todo omega_-j e Delta_j<0 para algum omega_-j;

N é dominado por Y
  iff Delta_j>=0 para todo omega_-j e Delta_j>0 para algum omega_-j;

UD_j(I,kappa)={Y,N} menos as ações dominadas.
```

Essa é dominância bayesiana interim no conjunto de informação do fraco. A
condição statewise, que exige o mesmo sinal para cada tipo separadamente, será
usada apenas como condição suficiente robusta e será identificada como tal. A
estriteza statewise só implica estriteza interim se ocorrer para algum tipo com
probabilidade positiva em `nu_I`.

### 5.2 `H` informado

Para cada tipo `theta`, `H` compara suas ações contra todo vetor fraco factível.
Defina

```text
Delta_H(theta,v_W | I,kappa)
  =u_H(Y,v_W;theta,I,kappa)-o_theta          em R1,
```

com a normalização temporal correspondente em R2. Então

```text
Y é dominado por N iff Delta_H<=0 para todo v_W e <0 para algum;
N é dominado por Y iff Delta_H>=0 para todo v_W e >0 para algum.
```

A IC de `H` não é copiada da IC dos fracos e não usa uma probabilidade de
pivotalidade. O vetor `v_W` é uma contingência contrafactual quantificada no
teste; não é informação observada por `H` antes de votar.

### 5.3 Estratégias mistas

Uma estratégia comportamental de ballot é admissível somente se seu suporte
estiver contido em `UD_i(I,kappa)`. Se ambas as ações forem não dominadas,
qualquer mistura é admissível pela disciplina de dominância; a PBE ainda deve
impor racionalidade sequencial contra a distribuição efetiva de equilíbrio.

## 6. Novo objeto de solução

Uma **PBE-UD** é uma assessment que satisfaz simultaneamente:

1. racionalidade sequencial de PBE em todos os conjuntos de informação;
2. consistência bayesiana sempre que possível;
3. weak-vote-passive assessment no escopo declarado;
4. suporte das estratégias de ballot contido na correspondência `UD_i` em
   todo conjunto de informação, inclusive fora do caminho;
5. proposta ótima dada a estratégia completa de votação e continuação.

Admissibilidade não substitui racionalidade sequencial. Uma ação pode ser uma
melhor resposta fraca no perfil de equilíbrio e, ainda assim, ser excluída por
dominância em uma contingência factível fora desse perfil.

## 7. Lemas locais

### Lema G0.1 — Ballot terminal de um fraco (`proved`)

Em qualquer ballot terminal alcançável, se `x_j>0`, votar não é fracamente
dominado por votar sim. Se `x_j=0`, sim e não são payoff-equivalentes em todas
as contingências e ambos permanecem admissíveis.

**Prova.** Quando o voto de `j` não muda a aprovação, ambas as ações entregam o
mesmo payoff. Quando é pivotal, sim entrega `x_j` e não entrega zero. Existe um
perfil factível pivotal sob cada quota alcançável. Portanto, `x_j>0` gera
igualdade nos perfis não pivotais e vantagem estrita de sim em pelo menos um;
em `x_j=0`, a diferença é zero em todos os perfis. QED.

### Lema G0.2 — `H` em R2 (`proved`)

Com `H` ativo em R2, existe um vetor fraco factível no qual a participação de
`H` é implementada. Logo:

```text
y<o_theta  => somente N é admissível para o tipo theta;
y>o_theta  => somente Y é admissível;
y=o_theta  => Y e N são admissíveis.
```

**Prova.** Nos vetores que não implementam com `H=Y`, ambas as ações pagam o
outside payoff terminal. Nos vetores que implementam, a diferença é
`beta*(y-o_theta)`. QED.

### Lema G0.3 — Redução escalar de um fraco em R1 (`proved`, condicional)

Suponha que, para todo perfil factível dos demais votantes: (i) perfis em que o
voto de `j` não muda o outcome dão o mesmo payoff sob `Y` e `N`; (ii) em todo
perfil pivotal, `Y` implementa `x_j` e `N` produz a mesma continuação `c_j`; e
(iii) existe pelo menos um perfil cuja probabilidade interim de pivotalidade é
positiva. Escrevendo

```text
p_j(omega)=sum_theta nu_I(theta)*1{j é pivotal em (omega,theta)},
```

temos `Delta_j(omega)=p_j(omega)*(x_j-c_j)`. Portanto,

```text
x_j<c_j  => somente N é admissível;
x_j>c_j  => somente Y é admissível;
x_j=c_j  => Y e N são admissíveis.
```

Sem (i)–(iii), nenhuma redução a `c_j` é válida. Em particular, se o voto nunca
é pivotal, as ações permanecem payoff-equivalentes mesmo quando `x_j!=c_j`.

### Lema G0.4 — Teste min–max para `H` em R1 (`proved`)

Seja

```text
V_theta(v_W)=
  y                                      quando H=Y implementa,
  beta*C_H2^R(theta,h_2(Y,v_W))         quando fracos causam falha.
```

Então:

```text
Y é dominado por N
 iff max_v V_theta(v)<=o_theta e min_v V_theta(v)<o_theta;

N é dominado por Y
 iff min_v V_theta(v)>=o_theta e max_v V_theta(v)>o_theta.
```

Nos demais casos ambas as ações permanecem não dominadas, sujeito ainda à IC
esperada de PBE.

### Corolário G0.4a — Teste condicional do threshold exato (`proved`)

Suponha conjuntamente que: (i) `y=o_theta`; (ii) para todo vetor fraco que
produz falha depois de `H=Y`, vale `beta*C_H2<=o_theta`; e (iii) existe pelo
menos um vetor factível no qual essa desigualdade é estrita. Então `H`-yes é
fracamente dominado por opt-out, mesmo que a estratégia fraca de equilíbrio
faça a implementação corrente ocorrer com probabilidade um.

As condições (ii)–(iii) não decorrem apenas de `y=o_theta`. Por exemplo, sob
unanimidade uma continuação pooling pode dar ao tipo baixo `C_H2=o_1`, de modo
que `beta*o_1>o_0`. Consequentemente, cada pooling ou low-only em threshold
exato deve calcular as continuações de todos os vetores factíveis antes de
classificar a ação de `H`; não existe uma eliminação universal por threshold.

**Exceção geométrica.** Sob maioria com `N=3`, temos `q=2`: o voto automático
do proponente mais `H=Y` já aprova a proposta. Não existe vetor fraco capaz de
causar falha depois de `H=Y`, de modo que o componente estrito do corolário
falha. Nesse caso, `y=o_theta` deixa as duas ações de `H` admissíveis e deve ser
tratado separadamente.

## 8. Indiferença e seleções

O objeto primário mantém a correspondência completa quando `UD_i={Y,N}`. A
disciplina de voto não seleciona sim silenciosamente.

Depois da correspondência, serão reportados separadamente:

- seleção `T^Y`: sim na indiferença;
- seleção `T^N`: não na indiferença;
- seleção `T^p`: mistura na indiferença, com probabilidades explícitas.

Para o proponente serão separados:

- correspondência sem seleção;
- tie-break legado que minimiza o payoff esperado de `H`;
- tie-break que maximiza o payoff esperado de `H`.

Nenhuma seleção será introduzida para salvar existência. Se ofertas estritas
gerarem apenas um supremo não atingido, a classe de equilíbrio vazia será
declarada como tal.

## 9. Fronteira de aplicação de BF

O artigo BF pode sustentar a motivação para excluir votos fracamente dominados
e documentar a função da convenção sim na indiferença. Não sustenta por si só:

- este protocolo simultâneo;
- a definição bayesiana acima;
- a dependência da continuação no vetor público ex post;
- os resultados de unanimidade ou maioria deste modelo;
- coalizão mínima ou dominância-solvabilidade deste ballot.

Esses objetos exigem prova própria.

A eliminação local, bayesiana e não iterada definida aqui é uma restrição
própria deste modelo. Baron–Ferejohn e Moulin (1979) não estabelecem essa
construção. A nota 8 de BF apenas remete a Moulin; não fornece uma adaptação
bayesiana ao ballot simultâneo.

Referências de paginação: Baron e Ferejohn (1989, pp. 1186–1187; notas 8–9 na
p. 1205); Moulin (1979), “Dominance Solvable Voting Schemes”, *Econometrica*
47:1337–1351.

## 10. Gate de promoção

Nenhuma fórmula de equilíbrio será marcada como sobrevivente antes de uma
auditoria independente confirmar:

- coerência da definição interim;
- inclusão correta de planos tipo-contingentes de `H`;
- não iteração e uso de todos os perfis factíveis;
- separação entre dominância e PBE;
- tratamento específico de `H`;
- ausência de roll-call e de ordem de `H`;
- validade dos Lemas G0.1–G0.4a.

## 11. Ledger de auditoria independente

### Auditoria formal de dominância/PBE

O primeiro passe identificou quatro reparos: indexação state-specific da
continuação dos fracos, manutenção explícita de uma única `kappa`, hipótese de
pivotalidade interim positiva no Lema G0.3 e remoção do ramo impossível de R1
com `H` previamente ausente. Também pediu a restauração do domínio primitivo
completo. Depois dos reparos, a rerevisão deu **PASS sem reservas
substantivas** para a definição interim, não iteração, recursão PBE-UD e Lemas
G0.1–G0.4a. O auditor permaneceu somente leitura.

### Auditoria BF e protocolo

O primeiro passe pediu que a deleção local, bayesiana e não iterada fosse
explicitamente identificada como construção própria. Depois desse reparo, a
rerevisão deu **PASS sem reservas** para paginação, escopo da fonte, distinção
entre dominância e sim na indiferença, ballot simultâneo e ausência de ordem de
`H`. O auditor permaneceu somente leitura.

### Stress test terminal posterior

A primeira enumeração de R2 detectou que a redação original do Corolário G0.4a
tratava `beta*C_H2<=o_theta` como se decorresse do threshold exato. O
contraexemplo é unanimidade com continuação pooling e
`beta*o_1>o_0`: o tipo baixo pode preferir permanecer ativo depois de uma falha
fraca. O corolário foi reescrito como implicação que exige explicitamente as
condições sobre todas as continuações. Nenhuma conclusão de R1 é promovida até
a rerevisão deste reparo.

O revisor terminal confirmou em passe somente leitura que a nova implicação
decorre do Lema G0.4, que o contraexemplo pooling ficou corretamente excluído
da conclusão automática e que a exceção `M,N=3` está correta.

**Gate 0 final:** **PASS** após rerevisão. Os pareceres anteriores e o stress
test permanecem registrados como trilha de reparo; nenhum deles substitui os
três pareceres finais sobre a versão candidata completa.
