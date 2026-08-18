# N3 — R1 sob maioria: derivação do candidato

**Nó:** `N3`  
**Dependência única consumida:** `N1-EQ-01`, hash `sha256:af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`  
**Data nativa dos payoffs:** R1  
**Status:** `pending` — candidato de implementação, ainda sem os dois pareceres independentes do ciclo próprio de N3  
**Fonte normativa exclusiva:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`, Seções 2, 4, 5, 6, 7.2, 8, 9 e 11

## 1. Interface congelada consumida

N3 não rederiva N1. Consome exatamente o único registro congelado de R2-majority:

```text
recognized proposer payoff in R2 = 1
pre-recognition payoff of each weak state in R2 = 1/m
H payoff in R2 = o_theta
R2 passes without H with probability 1
```

Defina os valores transportados uma única vez para R1:

```text
w       = beta/m
t_theta = beta*o_theta
t_0 < t_1
```

Se uma proposta de R1 falha, cada weak state recebe valor de continuação `w` e `H` do tipo `theta` recebe `t_theta`. Esses valores não dependem do posterior induzido pelo vetor de votos. Essa independência é propriedade da interface congelada, não uma nova restrição de crenças.

## 2. Payoffs proposta por proposta e perfil por perfil

Fixe o weak proposer reconhecido `i` e uma proposta factível

```text
s = (y, (x_j)_{j in W sem i}, r_i).
```

O proponente conta como `sim`. Para cada weak nonproposer `j`, compare seu voto mantendo fixo todo perfil `v_{-j}`.

| Perfil dos demais | `j` vota `sim` | `j` vota `não` |
|---|---:|---:|
| `j` é pivotal | `x_j` | `w` |
| a quota passa sem `j` | `x_j` | `x_j` |
| a quota falha mesmo com `j` | `w` | `w` |

Na última linha, os votos de `j` produzem histórias públicas distintas, mas a interface de N1 dá o mesmo valor `w` depois de ambas.

### Claim N3-C01 — cutoff dos weak nonproposers

- Se `x_j>w`, `sim` domina fracamente `não`.
- Se `x_j<w`, `não` domina fracamente `sim`.
- Se `x_j=w`, as duas ações dão o mesmo payoff contra todo perfil dos demais votos; `T^Y` seleciona `sim`.

Logo,

```text
v_j(s) = sim  iff  x_j >= w.
```

Defina

```text
K(s) = {j in W sem i: x_j >= w},
k(s) = |K(s)|.
```

### Claim N3-C02 — IC completa de H

As três linhas relevantes para `H` são:

1. `k>=q-1`: os weak states atingem a quota sem `H`. Se `H` vota `sim`, recebe `y`; se vota `não`, a proposta passa sem ele e recebe `y+o_theta`. Como `o_theta>0`, ambos os tipos votam `não` estritamente.
2. `k=q-2`: `H` é pivotal. `sim` implementa a proposta e paga `y`; `não` conduz a R2 e paga `t_theta=beta*o_theta` em unidades de R1. Portanto o tipo `theta` vota `sim` se e somente se `y>=t_theta`; na igualdade, `T^Y` seleciona `sim`.
3. `k<=q-3`: a proposta falha com qualquer voto de `H`. As duas ações geram histórias distintas, mas o payoff de continuação é `t_theta` em ambas. Há indiferença genuína no information set, e `T^Y` seleciona `sim`.

O primeiro ramo preserva integralmente `y`: o voto `não` de `H` paga `y+o_theta`, nunca apenas `o_theta` e nunca `y+t_theta`.

### Claim N3-C03 — payoff do proponente para toda proposta factível

Com `nu=Pr(theta=1)` na entrada de R1, o payoff esperado do proponente é

```text
v_i(s;nu) = r_i,                                      if k>=q-1;
            (1-nu)*[r_i if y>=t_0 else w]
              + nu*[r_i if y>=t_1 else w],            if k=q-2;
            w,                                         if k<=q-3.
```

Essa fórmula cobre toda proposta, todo perfil de respostas derivado e os dois tipos. Não usa uma classificação de ramos como premissa.

## 3. Redução do conjunto de candidatos

Escreva

```text
c = q-2,
E = 1-(q-1)w,
L = 1-c*w-t_0,
P = 1-c*w-t_1,
S(nu) = (1-nu)L + nu*w,
D = E-w = 1-q*w >= 0.
```

A desigualdade `D>=0` decorre de `q<=m` e `beta<=1`. A igualdade `D=0` ocorre exatamente quando `beta=1` e `q=m`, isto é, `N in {3,4}`.

Para cada proponente `i`, defina as famílias puras abaixo. `K` sempre denota um subconjunto de `W sem i`.

### Exclusão `E_i(K)`

```text
|K|=q-1;
y=0;
x_j=w para j in K e x_j=0 fora de K;
r_i=E.
```

A proposta passa sem `H` para ambos os tipos.

### Screening `S_i(K)`

```text
|K|=q-2;
y=t_0;
x_j=w para j in K e x_j=0 fora de K;
r_i=L.
```

Quando factível, o tipo baixo aceita e o alto rejeita. O payoff esperado do proponente é `S(nu)`.

### Pooling `P_i(K)`

```text
|K|=q-2;
y=t_1;
x_j=w para j in K e x_j=0 fora de K;
r_i=P.
```

Quando factível, ambos os tipos aceitam.

### Rejeição on-path `R_i(nu)`

`R_i(nu)` contém toda proposta factível que falha para cada tipo com probabilidade positiva sob `nu`. Equivalentemente:

```text
k<=q-3; ou
k=q-2 e y<min{t_theta: Pr(theta|nu)>0}.
```

Essa família pode conter propostas com folga. Em `nu=1`, também pode conter propostas que o tipo baixo, de probabilidade zero, aceitaria. Em `nu=0`, não há análogo para o tipo alto: como `t_0<t_1`, a condição `y<t_0` de `R_i(0)` quando `H` é pivotal implica que ambos os tipos rejeitam.

### Claim N3-C04 — exaustividade da redução

Toda proposta aprovada sem `H` que pode maximizar reduz pagamentos redundantes, paga exatamente `w` a exatamente `q-1` weak voters, zera os demais `x_j`, zera `y` e entrega o residual ao proponente: pertence a `E_i`.

Toda proposta com `H` pivotal e probabilidade positiva de aprovação reduz os pagamentos fracos a exatamente `q-2` parcelas de `w`. Se apenas o tipo baixo aprova e `nu<1`, o proponente escolhe o menor `y` aprovável, `t_0`, e fica com todo o residual: pertence a `S_i`. Se ambos aprovam, escolhe `t_1`: pertence a `P_i`. Quando o único tipo que aprovaria tem probabilidade zero, a proposta pertence a `R_i(nu)` e o pagamento nunca é executado no caminho.

Qualquer proposta que falha para todos os tipos no suporte pertence a `R_i(nu)` e paga `w`. Portanto nenhum ótimo puro existe fora de

```text
B_i(nu) = E_i union [S_i if feasible] union [P_i if feasible] union R_i(nu).
```

## 4. P0, P1 e P1a

### Claim N3-C05 — P0

As propostas ótimas de exclusão, screening ou pooling usam integralmente a pie. Se uma delas tivesse folga, aumentar `r_i` preservaria proposta, crenças e respostas e elevaria estritamente o payoff do proponente nos estados em que a proposta passa.

Propostas com folga sobrevivem apenas se pertencem a `R_i(nu)` e a rejeição on-path é selecionada. Isso requer `D=0`, pois `E>=w` e `R_i` paga `w`. Logo, folga só pode sobreviver quando `beta=1`, `q=m` e nenhum ramo aprovado dá payoff maior que `E=w`. P0 é, portanto, provada com uma exceção endógena preservada, não assumida fora da correspondência.

### Claim N3-C06 — P1, dominância estrita do hedge

Considere qualquer proposta `s=(y,x,r_i)` com `y>0` e pelo menos `q-1` weak nonproposers pagos o suficiente para votar `sim`. A quota passa qualquer que seja o voto de `H`, e `H` vota `não` estritamente. Construa

```text
s'=(0,x,r_i+y).
```

`s'` é factível e preserva os pagamentos dos mesmos weak states. Os votos fracos são idênticos; `H` permanece não pivotal e vota `não`; ambas passam sem `H`. A crença após uma proposta fora do caminho não altera nenhuma dessas respostas, porque os cutoffs usam apenas a interface congelada de N1. O proponente recebe `r_i+y>r_i`. Assim, o hedge domina estritamente `s` ex ante, inclusive quando uma das propostas está fora do caminho.

### Claim N3-C07 — P1a

Nenhuma história on-path aprovada sem `H` pode ter `y>0`, porque toda proposta que a geraria sofre o desvio estritamente lucrativo do Claim N3-C06. A exclusão com `y=0` permanece na correspondência.

## 5. Correspondência do proponente e fronteiras

Para cada proposta candidata `s`, defina o payoff esperado de `H`, sob o prior verdadeiro:

```text
h_i(s;nu) = (1-nu)u_H(s,0) + nu*u_H(s,1),
```

com `u_H` construído diretamente das três linhas do Claim N3-C02. Em particular,

```text
h_E = (1-nu)o_0 + nu*o_1;
h_S = beta*((1-nu)o_0 + nu*o_1);
h_P = beta*o_1;
h_R = beta*((1-nu)o_0 + nu*o_1).
```

O tie-break da proposta induz o conjunto selecionado

```text
V_star(nu) = max_{s in B_i(nu)} v_i(s;nu),
H_star(nu) = min{h_i(s;nu): s in B_i(nu), v_i(s;nu)=V_star(nu)},
A_i_star(nu) = {s in B_i(nu): v_i(s;nu)=V_star(nu), h_i(s;nu)=H_star(nu)}.
```

Para preservar toda multiplicidade de identidade e de proposta, a estratégia de cada proponente reconhecido `i` é uma distribuição própria `F_i` com suporte em `A_i_star(nu)`. Não se impõe `F_i=F_j`. Todo perfil `(F_i)_{i in W}` desse tipo é preservado.

### Claim N3-C08 — fronteiras regulares

As diferenças relevantes são

```text
P-E = beta*(1/m-o_1),
S-E = (1-nu)*beta*(1/m-o_0) - nu*D.
```

1. Se `o_1<1/m`, exclusão e rejeição são estritamente inferiores a pooling. Screening é selecionado para

```text
nu <= nu_SP = beta*(o_1-o_0)/(L-w),
```

e pooling para `nu>nu_SP`. Na igualdade, screening minimiza estritamente o payoff de `H`.
2. Se `o_0<1/m<o_1` e `D>0`, pooling é inferior a exclusão e

```text
nu_SE = beta*(1/m-o_0)/[beta*(1/m-o_0)+D].
```

Screening vence para `nu<nu_SE`; exclusão vence para `nu>nu_SE`. Na igualdade, screening é selecionado se `beta<1`; se `beta=1`, screening e exclusão permanecem.
3. Se `o_0>1/m` e `D>0`, exclusão é estritamente ótima.

Essas três regiões abertas são não vazias quando suas desigualdades primitivas são satisfeitas.

### Claim N3-C09 — fronteiras de igualdade

1. Se `o_0=1/m<o_1` e `D>0`, exclusão vence para `nu>0`. Em `nu=0`, screening e exclusão empatam no payoff do proponente; screening é selecionado se `beta<1`, e ambos permanecem se `beta=1`.
2. Se `o_0<o_1=1/m` e `D>0`, compare screening com `E=P` usando `nu_SE`. Abaixo de `nu_SE`, screening vence. Na igualdade, screening é selecionado se `beta<1`; se `beta=1`, screening e exclusão permanecem, enquanto pooling é eliminado pelo tie-break. Acima de `nu_SE`, exclusão e pooling empatam para o proponente; seleciona-se exclusão se `h_E<h_P`, pooling se `h_P<h_E`, e ambos se `h_E=h_P`. A fronteira equivalente é

```text
nu_HP = (beta/m-o_0)/(1/m-o_0),
```

sem truncá-la artificialmente quando cair fora de `[0,1]`.

### Claim N3-C10 — rejeição, delay e o corner `D=0`

`R_i(nu)` só pode ser selecionado se `E=w`, isto é, `D=0`. Nesse corner, `beta=1`, logo rejeição, screening e exclusão dão a `H` o mesmo payoff esperado sempre que empatam para o proponente. A família de rejeição é selecionada exatamente quando

```text
D=0,
o_1>=1/m,
e [nu=1 ou o_0>=1/m].
```

Nessa região, `A_i_star` preserva `R_i(nu)`, `E_i` e qualquer outro candidato empatado após o tie-break. Isso inclui propostas com folga e gera delay em equilíbrio. Se `o_1<1/m`, pooling domina `E=w`, e a rejeição não sobrevive.

Os Claims N3-C08--N3-C10, conjuntamente, cobrem todas as ordens estritas e igualdades possíveis entre `o_0`, `o_1` e `1/m`, os dois estados `D>0` e `D=0` e todo `nu in [0,1]`.

## 6. Crenças e vetor público de votos

### Claim N3-C11 — crença no ballot

O weak proposer não observa `theta`. Para qualquer proposta que seja um átomo positivo de `F_i`, Bayes preserva `nu` no ballot. Após toda proposta individual de probabilidade zero, a crença `kappa_i(s)` é componente livre do assessment, inclusive quando `s` pertence ao suporte topológico de uma distribuição atomless. Nenhuma crença off-path é escolhida para obter os cutoffs: as respostas derivadas são independentes dela.

Nos endpoints `nu=0` e `nu=1`, as estratégias no ballot e os payoffs e outcomes
condicionais continuam especificados para ambos os tipos. Bayes restringe apenas
histórias com probabilidade positiva; a estratégia do tipo de prior zero não é
apagada da avaliação.

### Claim N3-C12 — P7 após publicação dos votos

Os votos fracos são funções determinísticas de `x_j` e não do tipo. Quando um vetor `(s,v)` tem probabilidade positiva, o posterior após sua publicação segue Bayes:

```text
nu'(s,v) = nu*1{v_H=a_H(s,1)} /
  [(1-nu)*1{v_H=a_H(s,0)} + nu*1{v_H=a_H(s,1)}].
```

O denominador é condicionado também à proposta e aos votos fracos observados; seus fatores comuns cancelam porque os weak states não observam `theta`. No screening interior, uma falha causada pelo `não` do tipo alto revela `theta=1`. Quando ambos os tipos votam igual, o vetor não atualiza além da proposta. Para toda proposta ou vetor de votos de probabilidade zero, o posterior de entrada em R2 é uma crença explícita e irrestrita `eta_i(s,v)`. Qualquer que seja esse posterior, N1 entrega os mesmos valores usados acima.

### Claim N3-C13 — P6 em R1

Stage-undominated voting elimina `não` quando `x_j>w` e elimina `sim` quando `x_j<w`. Em `x_j=w`, há igualdade contra todo perfil e `T^Y` seleciona `sim`. Para `H`, o ramo não pivotal de passagem seleciona `não` estritamente; o ramo pivotal usa os cutoffs `t_theta`; e a falha inevitável seleciona `sim` por `T^Y`. Não se aplica stage-undominance a `H`.

## 7. Payoffs, outcomes e atomicidade

Para um perfil de distribuições condicionais por identidade `(F_i)`, defina `I_H(s,theta)`, `I_X(s,theta)` e `I_D(s,theta)` como os indicadores de passagem em R1 com `H`, passagem em R1 sem `H` e delay, respectivamente. Eles somam um. A interface exporta:

```text
recognized proposer payoff = V_star(nu);

C_l = (1/m)V_star(nu)
      + (1/m) sum_{i != l} E_{s~F_i,theta~nu}
          [x_l(s)*(I_H+I_X) + w*I_D]
      para cada weak state l;

C_H(theta) = (1/m) sum_i E_{s~F_i}
          [y*I_H + (y+o_theta)*I_X + t_theta*I_D].
```

O campo weak da interface contém o mapa indexado por identidade `l`; não se impõe simetria que o jogo não contém. As distribuições de outcomes usam a mesma média sobre reconhecimento, tipo e `F_i`. Como N1 passa com probabilidade um depois de todo delay, a probabilidade de falha terminal é zero; `delay` registra a probabilidade de falha em R1.

### Claim N3-C14 — desconto exatamente uma vez

Payoffs de aprovação em R1 são correntes. Somente `w=beta/m` e `t_theta=beta*o_theta` transportam N1 para R1, uma vez. Não existe outro fator de desconto na interface.

### Claim N3-C15 — existência, completude e multiplicidade

`E_i` é sempre factível e `E>=w`, portanto existe equilíbrio para toda primitiva admissível e todo `nu`. O conjunto `A_i_star` aplica exatamente o tie-break autorizado, e todo `(F_i)` nele apoiado gera um PBE com estratégias puras no ballot. Reciprocamente, os Claims N3-C01--N3-C10 mostram que todo PBE admissível deve usar propostas nesse conjunto.

Não há célula de inexistência. Em geral há multiplicidade de identidade da coalizão; empates preservam misturas adicionais. Quando `R_i(nu)` é selecionada, podem existir propostas com folga, delay e multiplicidade de payoffs do tipo de probabilidade zero. Tudo permanece ligado ao mesmo `(F_i)` no registro atômico; nenhuma projeção marginal é recombinada.

### Claim N3-C16 — invariância no domínio estrito `o_1<1`

A nova interface de N1 restringe as primitivas a

```text
0 < o_0 < o_1 < 1,
o_1 <= y_bar <= 1.
```

Todos os passos de N3 usam `o_theta` apenas nos limiares
`t_theta=beta*o_theta`, nos payoffs correntes `y+o_theta` quando a proposta
passa sem `H` e nas comparações de `o_0`, `o_1` com `1/m`. Nenhum passo usa
`o_1=1`, e a restrição estrita preserva `t_0<t_1`. Logo, a correspondência,
suas fronteiras internas, as crenças, os payoffs e os outcomes acima são a
restrição do mesmo objeto ao novo domínio; a face excluída `o_1=1` não é
usada para provar nenhum regime.

Em particular, o corner de multiplicidade não desaparece. `D=0` equivale a
`beta=1` e `q=m`, condições compatíveis com `o_1<1`. Portanto delay, propostas
com folga e distribuições `F_i` indexadas por identidade continuam na
correspondência exatamente nas condições do Claim N3-C10.

## 8. Invalidação

N3 depende exclusivamente do objeto N1 no hash `sha256:af128d9053ce1320a8ba9b033b40468d2f9e457be83330ee940b02b2e73534fd`. Qualquer mudança nesse hash, nas primitivas, na função de implementação, no conceito de solução, no tie-break, no timing ou no schema invalida este candidato. O arquivo permanece `pending` até dois revisores independentes darem PASS `0/0/0` no mesmo hash.
