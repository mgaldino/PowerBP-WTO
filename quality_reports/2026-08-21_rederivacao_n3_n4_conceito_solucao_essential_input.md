# Rederivação proof-first de N3 e N4 sob o conceito de solução fixado em 2026-08-21

**Data:** 21 de agosto de 2026  
**Status:** candidatos `pending/unfrozen`; sem integração ao DAG  
**Emenda autoral posterior aplicada:** posterior de denominador zero restrito
ao suporte do prior nos endpoints.  
**Worktree:** `/private/tmp/PowerBayesianPersuasion-essential-input-solution-concept`  
**Commit administrativo de proveniência:** `a6fd6bd543e9cefd4166581b80565916509e95a6`

## 1. Resultado em linguagem corrente

Sob maioria, a correção do conceito de solução não muda o resultado econômico.
Os Estados fracos podem substituir `H`; a continuação terminal é independente
da crença; e N3 continua dividido entre exclusão, screening e pooling. A prova
agora explicita as regiões de factibilidade, o domínio correto da fronteira
screening-pooling, as crenças no-signaling e a data em que `o_theta` é pago.

Sob unanimidade, a mudança é estrutural. A nova combinação de crenças,
votação pivotal e aceitação na igualdade transforma ofertas de reserva em
ofertas que forçam acordo. Como esperar desconta todos os payoffs por
`beta<1`, o acordo fechado dá ao proponente exatamente `1-beta` a mais
que a continuação.

A correspondência N4 candidata é:

1. em `nu=0`, acordo imediato apenas com o tipo baixo;
2. em `0<nu<=nu_star`, inexistência de PBE com ballots puros;
3. em `nu_star<nu<=1`, pooling imediato.

Não há atraso on-path nas células em que existe PBE. O caso `m=2` segue a
mesma lógica; as misturas antigas entre acordo e atraso desaparecem.

## 2. Jogo, informação e relógio

Há `N>=3` jogadores: um hegemon `H` e `m=N-1` Estados fracos. A
natureza sorteia `theta in {0,1}`, observado apenas por `H`, com
`nu=Pr(theta=1)`. Em cada uma das duas rodadas, um fraco é reconhecido
uniformemente como proponente. A segunda rodada, R2, é terminal.

Uma proposta de um fraco `i` é

```text
s = (y, (x_j)_{j in W sem i}, r_i),
y + sum_j x_j + r_i <= 1.
```

`y` é destinado a `H`, `x_j` ao respondente fraco `j` e `r_i`
ao proponente. O proponente conta como `sim`; todos os demais votam
simultaneamente e o vetor só se torna público após o ballot.

Sob maioria, `q=floor(N/2)+1`; sob unanimidade, `q=N`. Não há saída.
Se nada passa, o payoff de desacordo de `H(theta)` é `o_theta`, com
`0<o_0<o_1<1`; os fracos recebem zero.

R2 é resolvida em unidades correntes. Ao entrar numa comparação de R1, todo
valor de R2 recebe exatamente um fator `beta in (0,1)`.

## 3. As três definições que governam esta rodada

### 3.1 No-signaling com consistência estrutural

Propostas e votos de fracos, inclusive desvios, não mudam a crença sobre
`theta`. Ações prescritas de `H` atualizam por Bayes, inclusive depois de
um desvio fraco anterior. Uma ação de `H` fora do perfil prescrito deixa a
crença livre em `[0,1]` somente quando `0<nu<1`. Pela decisão autoral
posterior de restrição de suporte, `nu=0` fixa posterior zero em toda a
árvore e `nu=1` fixa posterior um em toda a árvore, inclusive quando o
denominador bayesiano é zero.

### 3.2 Voto fraco como se pivotal

Cada respondente fraco compara `sim` e `não` condicionalmente ao evento em
que seu próprio voto muda o resultado. Uma preferência estrita determina o
voto.

### 3.3 Aceitação na igualdade esperada

Quando os valores esperados na comparação pivotal são iguais — integrando o
tipo e a loteria de reconhecimento — `T^Y` determina `sim`. A identidade
contingência por contingência continua suficiente nos nós terminais, mas não é
necessária em R1.

## 4. Dependências e unidades

| Nó rederivado | Única interface consumida | SHA-256 | Conversão temporal |
|---|---|---|---|
| N3, R1 maioria | N1, R2 maioria | `1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5` | multiplica N1 por `beta` uma vez |
| N4, R1 unanimidade | N2 congelado + Emenda 1a/errata | N2 `c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`; errata `94062c0803d9ed455fbec3b9508fabd2eb4cb86018fbe036b618671f452f7a69` | multiplica os valores invariantes de N2 por `beta` uma vez |

N3 não usa N2 nem N4. N4 não usa N1 nem N3. N6, N7 e o DAG não são
consumidos.

## 5. N3 — prova passo a passo

### 5.1 Continuação importada

N1 dá a cada fraco valor pré-reconhecimento `1/m` e a `H(theta)` valor
`o_theta`. Em R1, defina

```text
w       = beta/m,
t_theta = beta*o_theta.
```

### 5.2 Votos

Um fraco pivotal compara `x_j` com `w`, logo vota `sim` se, e somente
se, `x_j>=w`. Seja `k` o número de respondentes fracos que votam
`sim`.

- se `k>=q-1`, a proposta passa sem `H`; `H` vota `não` e recebe
  `y+o_theta`;
- se `k=q-2`, `H` é pivotal e o tipo `theta` aceita se
  `y>=t_theta`;
- se `k<=q-3`, a proposta falha qualquer que seja o voto de `H`.

Essa tabela cobre toda proposta factível antes de aplicar qualquer rótulo.

### 5.3 Candidatos

Defina

```text
E       = 1-beta*(q-1)/m,
L       = 1-beta*o_0-beta*(q-2)/m,
S(nu)   = (1-nu)L+nu*beta/m,
P       = 1-beta*o_1-beta*(q-2)/m,
R       = beta/m.
```

`E` é exclusão; `S` é screening; `P` é pooling; `R` é rejeição
deliberada. Como `q<=m` e `beta<1`,

```text
E-R = 1-beta*q/m > 0.
```

Logo rejeição deliberada nunca é on-path.

### 5.4 Factibilidade e uso da pie

Exclusão é sempre factível. Se screening alcança `E`, então
`o_0<=1/m` e seu custo é menor que um. Se pooling alcança `E`, então
`o_1<=1/m` e também é factível. Assim, `max{E,S,P}` não seleciona um
pacote impossível.

Toda proposta selecionada usa a pie inteira. Uma aprovação sem `H` com
`y>0` sofre um desvio estritamente lucrativo que fixa `y=0` e transfere
`y` ao resíduo do proponente.

### 5.5 Fronteiras

As duas comparações centrais são

```text
P-E = beta*(1/m-o_1),

S-E = (1-nu)*beta*(1/m-o_0)
      -nu*(1-beta*q/m).
```

Quando `o_0<1/m`,

```text
nu_SE =
  beta*(1/m-o_0)
  / [beta*(1/m-o_0)+1-beta*q/m].
```

Quando `o_1<1/m`, e somente nesse domínio em que pooling pode superar
exclusão,

```text
nu_SP =
  beta*(o_1-o_0)
  / [1-beta*o_0-beta*(q-1)/m].
```

O denominador é positivo e `nu_SP in (0,1)`. Screening fica com as
igualdades porque reduz estritamente o payoff esperado de `H`. Na fronteira
`o_1=1/m`, exclusão e pooling podem permanecer empatados; a multiplicidade
residual e as identidades das coalizões são preservadas.

### 5.6 O que a nova decisão muda em N3

O resultado econômico sobrevive. O sistema de crenças não: a crença já não é
livre depois de desvio fraco. Ela permanece `nu`, e apenas o voto de `H`
pode atualizá-la. Como N1 é independente do posterior, essa correção restringe
assessments sem alterar cutoffs, payoffs ou outcomes.

## 6. N4 — prova passo a passo

### 6.1 Continuação importada

Defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1,
A       = beta*(1-o_0)/m,
B       = beta*(1-o_1)/m,
D       = (1-nu)A,
C       = D se nu<=nu_star; B se nu>nu_star.
```

N2 screening realiza `(A,0)` para cada fraco e paga `(ell,h)` a `H`.
N2 pooling realiza `(B,B)` e paga `(h,h)`. Vale
`(1-nu_star)A=B`.

### 6.2 Piso de acordo e fronteira de veto

Num acordo pooling, `H` vota `sim` nos dois tipos. Um desvio fraco para
`não` não muda a crença; por isso o piso é o valor corrente `C`, não
`B` uniforme:

```text
acordo: x_j>=C;
veto:   x_j<C.
```

A igualdade pertence ao acordo. Para `m>=3`, a regra vale identidade por
identidade em qualquer conjunto de múltiplos vetos. Para `m=2`, vale para o
único respondente.

### 6.3 Por que `H` não separa com prior positivo

Se `H0` vota `sim` e `H1` vota `não`, o voto contrário revela o tipo
alto. O baixo pode imitá-lo e obter pooling, isto é, `h`. Sua aceitação
exigiria `Y>=h`, mas o veto do alto exige `Y<h`. Para `0<nu<1`, a
separação inversa também é impossível porque exigiria
`Y<ell<h<=Y`. No endpoint `nu=1`, o suporte fixa posterior um após
ambos os votos; os dois tipos comparam `Y` com `h`, de modo que a
separação inversa exigiria `Y<h<=Y` e é eliminada por preferência
estrita ou por `T^Y` na igualdade.

Com qualquer veto fraco, a proposta falha independentemente de `H`. O tipo
alto, indiferente entre continuações de valor `h`, vota `sim` por
`T^Y`. No interior, o baixo também vota `sim` porque um voto separador
`não` daria `ell` e imitar o alto daria `h`. Nos endpoints, ambos os
votos preservam o posterior fixado pelo suporte e dão a mesma continuação;
`T^Y` novamente determina `sim`.

### 6.4 Inexistência no intervalo baixo positivo

Para `0<nu<=nu_star`, considere

```text
s_dagger:
  Y=ell,
  x_j=A para todo j,
  r_i=Q_L=1-ell-(m-1)A.
```

A proposta é factível e usa a pie inteira. Como todo valor fraco possível após
o voto `sim` de `H` está entre `B` e `A`, todos os fracos votam
`sim` sob qualquer estratégia pura de `H`.

Restam quatro perfis:

- `(sim,sim)`: o alto desvia para `não` e recebe `h>ell`;
- `(não,não)`: o baixo empata em `ell` e `T^Y` determina `sim`;
- `(sim,não)`: o baixo imita o `não` do alto e recebe `h>ell`;
- `(não,sim)`: o alto imita o `não` do baixo e recebe `h>ell`.

Nenhum sobrevive. Como PBE exige racionalidade sequencial também após
propostas fora do caminho, não existe PBE com ballots puros nessa célula.

### 6.5 Os dois registros existentes

Em `nu=0`,

```text
L_star:
  Y=ell,
  x_j=A,
  r_i=Q_L=A+1-beta.
```

O baixo aceita e o alto, de probabilidade zero, rejeita. Atraso paga `A`;
logo acordo supera atraso por `1-beta`.

Em `nu>nu_star`,

```text
P_star:
  Y=h,
  x_j=B,
  r_i=Q_P=B+1-beta.
```

Os dois tipos aceitam. Atraso paga `B`; novamente acordo supera atraso por
`1-beta`.

Essas propostas são únicas on-path: todo acordo da mesma classe precisa pagar
ao menos os mesmos pisos, e toda outra classe dá payoff menor.

A existência global usa a correspondência completa após toda proposta. Seja
`u=min_j x_j`. Em `nu=0`, `(sim,sim)` é admissível quando `u<A` ou
quando `u>=A,Y>=h`; `(não,não)` quando `u>=A,Y<ell`; e
`(sim,não)` quando `u>=A,ell<=Y<h`. Se
`B<=u<A,Y<ell`, o posterior zero fixa o cutoff em `A`, há veto fraco e
somente `(sim,sim)` sobrevive: a antiga sobreposição exigia posterior
positivo para o tipo de prior zero e foi removida. Para
`nu_star<nu<1`, `(sim,sim)` vale quando `u<B` ou
`u>=B,Y>=h`, e `(não,não)` quando `u>=B,Y<h`; crenças fora do perfil
permanecem livres apenas se satisfazem as ICs. Em `nu=1`, as mesmas
condições estratégicas valem, mas todo posterior é um; `T^Y` elimina os
perfis separadores e não resta multiplicidade de crenças.

A contabilidade por tipo também permanece explícita. Em `nu=0`, o vetor dos
fracos é `(Q_L,A,...,A)` no tipo baixo e o vetor zero no tipo alto, que leva
a N2 screening; antes de R1 reconhecer o proponente, o valor representativo
é `(1-ell)/m` no tipo baixo e zero no alto. Em `nu>nu_star`, o vetor é
`(Q_P,B,...,B)` nos dois tipos, e o valor pré-reconhecimento é
`(1-h)/m`.

### 6.6 Segurança, `m=2` e misturas

O valor antigo `S_3=(1-nu)B` não é exato. Nas células com existência, a
garantia é a própria oferta que força acordo. Na célula intermediária não há
valor escalar de PBE puro.

O antigo `S_2` é removido: `m=2` usa a mesma comparação `x<C`.
Também desaparecem as misturas `L/D` e `P/D`: não há empate, pois
`1-beta>0`, e `T^Y` impede veto na igualdade.

## 7. Correspondências candidatas

### N3

N3 existe para todo o domínio. Cada identidade de proponente pode escolher
qualquer distribuição sobre suas propostas lexicograficamente ótimas; não se
impõe simetria. O arquivo JSON preserva coalizões, empate residual e vetores de
payoff no mesmo registro. Indicadores de passagem com `H`, passagem sem `H` e
atraso vinculam estratégia, payoffs de cada identidade, payoffs de `H` e
outcomes à mesma família `F=(F_i)_i`; projeções marginais não podem ser
recombinadas.

### N4

| Célula | Existência | Resultado | Payoff do proponente | Payoff de `H` |
|---|---|---|---:|---|
| `nu=0` | existe | `L_star` | `A+1-beta` | `(ell,h)` |
| `0<nu<=nu_star` | não existe PBE puro | — | — | — |
| `nu_star<nu<=1` | existe | `P_star` | `B+1-beta` | `(h,h)` |

N4 não tem atraso com probabilidade positiva, aprovação sem `H` nem mistura
nas células com existência. A estratégia pura é única proposta a proposta nos
dois endpoints; a multiplicidade de crenças off-path, sempre condicionada às
ICs, permanece apenas quando `0<nu<1`.

## 8. Matriz de sobrevivência

A matriz completa está em
`quality_reports/2026-08-21_matriz_sobrevivencia_n3_n4_conceito_solucao.csv`.
Os movimentos centrais são:

| Resultado anterior | Classificação | Resultado corrente |
|---|---|---|
| núcleo de N3 | sobrevive | mesma correspondência econômica |
| crenças livres após desvio fraco em N3 | corrigido | no-signaling; payoffs invariantes |
| piso `B` em N4 | corrigido | piso corrente `C` |
| fronteira fechada de veto | removido | veto somente em `x<C` |
| `S_3=(1-nu)B` | removido | acordo forçado ou inexistência |
| delay geral para `m>=3` | removido | nenhum delay onde há PBE |
| fórmula especial `m=2` | removido | mesma regra `C` |
| existência pura universal | novo finding | célula vazia em `0<nu<=nu_star` |

## 9. Verificação separada por objeto

### (a) Prova e modelo

- Demonstrações humanas completas nos artefatos separados de N3 e N4.
- Enumeração explícita das quatro estratégias puras de `H`.
- Certificado de inexistência ligado ao claim `N4-C08`.
- Correspondências preservam atomicidade, multiplicidade e células vazias.
- Pareceres independentes são registrados separadamente e não editam arquivos.

O pacote incorpora em uma única reparação dirigida os findings do primeiro
ciclo: atomicidade de `F` em N3; crenças condicionadas às ICs e a sobreposição
de dois perfis off-path em N4; e a prova separada do endpoint `nu=1`. A
decisão autoral posterior de restrição de suporte remove essa sobreposição:
posterior zero torna `(não,não)` inviável quando `B<=min x<A,Y<ell`.
No endpoint `nu=1`, posterior um substitui a antiga classe de crenças livres,
sem alterar o resultado estratégico.

### (b) Cálculos algébricos dirigidos

O script
`scripts/verify_essential_input_solution_concept_rederivation.R` verifica:

- `E-R>0`, factibilidade dos candidatos competitivos e domínio de
  `nu_SP`;
- `(1-nu_star)A=B`;
- `Q_L-A=Q_P-B=1-beta`;
- a enumeração finita dos quatro perfis de `H`;
- dois negativos representativos contra `S_3` e o antigo limiar `A` de
  `m=2`.

Não há mutação exaustiva, fuzzing de schema ou verifier-of-verifier.

### (c) Integridade simples

- JSON é validado por parser;
- CSV é validado por número constante de campos;
- `git diff --check` verifica whitespace;
- SHA-256 identifica os bytes candidatos;
- o verificador Gate 0 é usado apenas para confirmar que a infraestrutura
  protegida não foi alterada.

## 10. Artefatos

- `model_redesign/essential_input_solution_concept/n3_r1_majority_rederivation_candidate.md`
- `model_redesign/essential_input_solution_concept/n3_r1_majority_candidate.json`
- `model_redesign/essential_input_solution_concept/n3_claim_ledger.tsv`
- `model_redesign/essential_input_solution_concept/n4_r1_unanimity_rederivation_candidate.md`
- `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json`
- `model_redesign/essential_input_solution_concept/n4_claim_ledger.tsv`
- `quality_reports/2026-08-21_matriz_sobrevivencia_n3_n4_conceito_solucao.csv`
- `scripts/verify_essential_input_solution_concept_rederivation.R`

## 11. Stop condition

Esta rodada termina depois de candidatos, verificações dirigidas e exatamente
dois pareceres independentes read-only. N3 e N4 permanecem
`pending/unfrozen`. Nenhum hash é integrado ao DAG; N6, N7, comparação
institucional, figuras, PDF e manuscrito permanecem fora do escopo. Qualquer
freeze ou consumo posterior exige autorização separada do autor.
