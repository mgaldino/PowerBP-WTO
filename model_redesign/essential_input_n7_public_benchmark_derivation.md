# N7 — benchmark público terminal e rendas informacionais

**Data:** 2026-08-21  
**Status durante a implementação:** `pending/unfrozen`  
**Domínio autorizado:** `m=N-1>=3`, `beta in (0,1)`, `0<o_0<o_1<1`,
`o_1<=y_bar<=1`, somente PBE com ballots puros  
**Objeto terminal:** jogos de informação completa, `RI_M`, `RI_U` e
`DeltaRI`; nenhum resultado retorna a N1--N6

## 1. Escopo, autoridade e fronteira de dependência

N7 é aberto somente depois do congelamento de N6. Ele não rederiva nem edita
N1--N6. O único input privado é:

```text
N6 = sha256:a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
```

As interfaces ancestrais usadas apenas para o teste obrigatório de endpoints
são:

```text
N1 = sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5
N2 = sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2
N3 = sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d
N4 = sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b
```

N2 é lido conjuntamente com a Emenda 1a da decisão de 2026-08-21: em
`nu=0` todo posterior é zero e em `nu=1` todo posterior é um. Nenhum payoff de
N2 é alterado.

O `verify_essential_input_n3.R` histórico aponta para a interface antiga
`n3_r1_majority_candidate_v1.json`, para ordens 5/6 e para pareceres Round 3.
Ele não é o verificador do N3 corrente e permanece intacto. O N3 corrente e N4
são certificados pelo manifesto final e pelo verificador conjunto
`verify_essential_input_solution_concept_rederivation.R`.

Não foram consultados artefatos de N7 de worktrees ou branches antigas, a
worktree de suporte, calculadora de renda ou qualquer output paralelo de
tooling. A derivação pública abaixo parte das primitivas do contrato.

## 2. Ordem efetiva de solução

O jogo é finito e acíclico. Dentro de N7, a ordem executada é:

```text
M-R2-theta_0   M-R2-theta_1   U-R2-theta_0   U-R2-theta_1
       |              |              |              |
M-R1-theta_0   M-R1-theta_1   U-R1-theta_0   U-R1-theta_1
                         \\          /
                    benchmark público
                              |
                     N6 privado frozen
                              |
                   RI_M, RI_U, DeltaRI
```

Os quatro nós R2 não possuem continuação. Cada nó R1 consome somente o R2 da
mesma regra e do mesmo tipo público. `beta` não aparece dentro de R2; ele é
aplicado exatamente uma vez quando R2 entra em R1.

## 3. Contrato do jogo público e notação

Fixe o tipo publicamente conhecido `theta` e escreva `o=o_theta`. Todas as
demais primitivas permanecem as do contrato privado:

```text
m = N-1 >= 3
q = floor(N/2)+1
c = 1/m
w = beta/m
t(o) = beta*o
a_0 = (1-beta)*o_0
a_1 = (1-beta)*o_1
d = beta*(o_1-o_0) > 0
k = beta*o_1-o_0 = d-a_0
nu_star = (o_1-o_0)/(1-o_0)
```

Como `theta` é público desde `t=0`, não há crença sobre o tipo a atualizar.
Em toda história, inclusive fora do caminho, o posterior é a massa degenerada
no tipo público. A restrição de suporte impede ressuscitar o outro tipo.

Os ballots permanecem simultâneos, selados e em estratégias puras. Um weak
responder usa a comparação as-if-pivotal; na igualdade de valor esperado,
`T^Y` seleciona `sim`. `H` escolhe sua melhor resposta sequencial e também
vota `sim` na igualdade. O desempate entre propostas que dão o mesmo payoff ao
proponente minimiza o payoff de `H`.

## 4. R2 público sob maioria

Fixe qualquer proposta factível. Condicional a ser pivotal, um weak
nonproposer compara `x_j` com zero. Como `x_j>=0`, ele vota `sim`; quando
`x_j=0`, `T^Y` também seleciona `sim`. Portanto todos os `m-1` weak
nonproposers votam `sim` após toda proposta.

O proponente já conta como `sim`. Como `q<=m`, os `m` votos fracos aprovam a
proposta sem `H`. O voto de `H` é não pivotal. Votar `sim` paga `y`; votar
`não` paga `y+o`. Como `o>0`, `H` vota `não` estritamente.

O proponente maximiza `r_i` escolhendo:

```text
y=0, x_j=0 para todo j, r_i=1.
```

O argmax é único. O resultado e os payoffs, em unidades correntes de R2, são:

| Papel | Payoff |
|---|---:|
| weak proposer reconhecido | `1` |
| weak state antes do sorteio de reconhecimento | `1/m` |
| `H` | `o` |
| outcome | passagem sem `H`, probabilidade 1 |

Existe um único perfil de estratégias, outcome e payoff. Não há multiplicidade
de crenças porque o tipo é público.

## 5. R2 público sob unanimidade

Sob unanimidade, cada weak nonproposer e `H` são pivotais quando todos os
demais aprovam. Um weak responder vota `sim` se e somente se `x_j>=0`; logo
vota `sim` depois de toda proposta, com `T^Y` na igualdade. `H` compara `y`
com o desacordo terminal `o` e vota `sim` se e somente se `y>=o`.

Para aprovar, o proponente deve pagar no mínimo `o` a `H`. Como `1-o>0`, a
aprovação estritamente domina a falha, e o argmax único é:

```text
y=o, x_j=0 para todo j, r_i=1-o.
```

Os payoffs correntes de R2 são:

| Papel | Payoff |
|---|---:|
| weak proposer reconhecido | `1-o` |
| weak state antes do sorteio de reconhecimento | `(1-o)/m` |
| `H` | `o` |
| outcome | passagem com `H`, probabilidade 1 |

O perfil de estratégias, o outcome e o payoff são únicos.

## 6. R1 público sob maioria

O R2 público de maioria exporta, em sua própria data, `1/m` a cada weak state
antes do reconhecimento e `o` a `H`. Em R1, as reservas são, uma única vez:

```text
weak responder: w=beta/m
H: t(o)=beta*o.
```

Depois de qualquer proposta, um weak nonproposer vota `sim` se e somente se
`x_j>=w`. Para descrever a melhor resposta de `H`, conte os weak
nonproposers que votam `sim`:

- com pelo menos `q-1`, a proposta passa sem `H`; `H` vota `não` e recebe
  `y+o`, estritamente acima de `y`;
- com exatamente `q-2`, `H` é pivotal e vota `sim` se e somente se
  `y>=t(o)`;
- com no máximo `q-3`, a proposta falha com qualquer voto de `H`; as duas ações
  levam ao mesmo R2 público e `T^Y` seleciona `sim`.

Depois de eliminar folga e pagamentos que não mudam o outcome, restam dois
argmax candidatos:

```text
inclusão I(o): comprar q-2 weak responders por w, pagar t(o) a H,
               reter J(o)=1-(q-2)w-beta*o;

exclusão X:    comprar q-1 weak responders por w, fixar y=0,
               reter E=1-(q-1)w.
```

Rejeitar deliberadamente paga `w`. A exclusão a domina estritamente:

```text
E-w = 1-beta*q/m > 0,
```

pois `q<=m` e `beta<1`. Uma aprovação sem `H` com `y>0` é estritamente
dominada pelo hedge que fixa `y=0` e transfere a economia ao proponente.

A escolha entre inclusão e exclusão é:

```text
J(o)-E = beta*(1/m-o).
```

Logo:

```text
o<=1/m  -> inclusão;
o>1/m   -> exclusão.
```

Na igualdade `o=1/m`, os payoffs do proponente empatam. A inclusão paga
`beta*o` a `H`, enquanto a exclusão paga `o`; como `beta<1`, o desempate
anti-`H` seleciona inclusão.

Para cada proponente reconhecido `i`, seja `F_i` qualquer distribuição sobre
as coalizões rotuladas que implementam a classe selecionada. A multiplicidade
é somente de identidade das coalizões e da mistura já permitida entre
propostas empatadas:

```text
inclusão: |K_i|=q-2;
exclusão: |K_i|=q-1.
```

O payoff do weak state rotulado `l`, antes do sorteio de R1, é:

```text
C_l(F)=V/m+(w/m)*sum_{i!=l} Pr_{K~F_i}(l in K),
```

onde `V=J(o)` na inclusão e `V=E` na exclusão. A média entre os `m` weak
states é `(1-beta*o)/m` na inclusão e `1/m` na exclusão. O payoff do
proponente reconhecido, o payoff de `H` e o outcome são únicos dentro da
classe; payoffs individuais de weak states podem variar com `F`.

## 7. R1 público sob unanimidade

O R2 público de unanimidade exporta `(1-o)/m` a cada weak state e `o` a `H`.
As reservas em R1 são:

```text
C(o)=beta*(1-o)/m
t(o)=beta*o.
```

Condicional a ser pivotal, cada weak responder vota `sim` se e somente se
`x_j>=C(o)`. Se todos os fracos aprovam, `H` vota `sim` se e somente se
`y>=t(o)`. Se algum fraco rejeita e a proposta falha qualquer que seja o voto
de `H`, `H` fica indiferente entre duas continuações públicas idênticas e
`T^Y` seleciona `sim`.

O proponente oferece exatamente as reservas:

```text
y=beta*o,
x_j=C(o) para todo weak nonproposer,
r_i=Q(o)=1-beta*o-(m-1)C(o)=C(o)+1-beta.
```

A proposta é factível e usa toda a pie. Além disso,
`Q(o)-C(o)=1-beta>0`; portanto aprovação imediata domina estritamente a
continuação. O argmax, o perfil de ballot, o outcome e os payoffs são únicos:

| Papel | Payoff de R1 |
|---|---:|
| weak proposer reconhecido | `Q(o)=C(o)+1-beta` |
| cada weak nonproposer | `C(o)` |
| weak state antes do reconhecimento | `(1-beta*o)/m` |
| `H` | `beta*o` |
| outcome | passagem com `H`, probabilidade 1 |

## 8. Teste de equivalência com os endpoints privados

Cada comparação abaixo usa a restrição de suporte. A equivalência inclui
outcome e payoffs de todos os papéis, não apenas o payoff de `H`.

| Jogo público | Endpoint privado congelado | Equivalência |
|---|---|---|
| maioria R2, `theta=0` | N1 em `nu=0` | `y=x=0`, `r_i=1`, weak yes, `H0` não, passagem sem `H`, payoffs `(1,1/m,o_0)` |
| maioria R2, `theta=1` | N1 em `nu=1` | mesma estratégia e outcome, com payoff `o_1` a `H` |
| unanimidade R2, `theta=0` | N2 `N2-EQ-LOW-TYPE-ONLY` em `nu=0` | `y=o_0`, `x=0`, `r_i=1-o_0`, passagem com `H0`, payoffs `(1-o_0,(1-o_0)/m,o_0)` |
| unanimidade R2, `theta=1` | N2 `N2-EQ-POOLING` em `nu=1` | `y=o_1`, `x=0`, `r_i=1-o_1`, passagem com `H1`, payoffs `(1-o_1,(1-o_1)/m,o_1)` |
| maioria R1, `theta=0` | N3 em `nu=0` | inclusão/S se `o_0<=1/m`; exclusão/E se `o_0>1/m`; mesmas coalizões, payoffs e outcome |
| maioria R1, `theta=1` | N3 em `nu=1` | inclusão/P se `o_1<=1/m`; exclusão/E se `o_1>1/m`; na igualdade o desempate anti-`H` escolhe inclusão em ambos |
| unanimidade R1, `theta=0` | N4 `N4-SC-EQ-L-STAR` em `nu=0` | `ell=beta*o_0`, `A=C(o_0)`, `Q_L=A+1-beta`; mesmos payoffs e passagem imediata com `H` |
| unanimidade R1, `theta=1` | N4 `N4-SC-EQ-P-STAR` em `nu=1` | `h=beta*o_1`, `B=C(o_1)`, `Q_P=B+1-beta`; mesmos payoffs e passagem imediata com `H` |

Não há discrepância. Logo nenhum finding de fonte compartilhada é aberto.

## 9. Conjuntos públicos e privados de payoff de H

Defina o payoff público de maioria por tipo:

```text
p_M(o)=beta*o, se o<=1/m;
p_M(o)=o,      se o>1/m.
```

Apesar da multiplicidade de coalizões rotuladas sob maioria, ela não muda o
payoff de `H`. Portanto:

```text
V_M^pub = {(p_M(o_0),p_M(o_1))};
V_U^pub = {(beta*o_0,beta*o_1)}.
```

Para organizar a combinação pública, há três regiões exaustivas:

```text
II: o_1<=1/m                 (os dois tipos são incluídos sob maioria pública);
IX: o_0<=1/m<o_1            (baixo incluído, alto excluído);
XX: 1/m<o_0                 (os dois tipos são excluídos).
```

O input privado frozen de maioria tem as classes:

| Classe privada | `V_M^priv` |
|---|---|
| `S` screening | `(beta*o_0,beta*o_1)` |
| `P` pooling | `(beta*o_1,beta*o_1)` |
| `E` exclusão | `(o_0,o_1)` |
| empate `EP` | `lambda*(o_0,o_1)+(1-lambda)*(beta*o_1,beta*o_1)`, `lambda in [0,1]` |

O conjunto exato de classes selecionadas por N3, transportado por N6, é:

1. `o_1<1/m`: `S` se `nu<=nu_SP`; `P` se `nu>nu_SP`.
2. `o_0<1/m<o_1`: `S` se `nu<=nu_SE`; `E` se `nu>nu_SE`.
3. `1/m<o_0<o_1`: `E` para todo `nu`.
4. `o_0=1/m<o_1`: `S` em `nu=0`; `E` para todo `nu>0`.
5. `o_0<o_1=1/m`: `S` se `nu<=nu_SE`. Acima, `E` se
   `Hbar_E<Hbar_P`, `P` se `Hbar_P<Hbar_E` e o segmento `EP` se empatam,
   onde `Hbar_E=(1-nu)o_0+nu*o_1` e `Hbar_P=beta*o_1`.

As fronteiras `nu_SP` e `nu_SE` são exatamente as de N6. Na igualdade do
cutoff, a classe é `S`.

Sob unanimidade privada:

```text
nu=0:                 V_U^priv={(beta*o_0,beta*o_1)};
0<nu<=nu_star:        V_U^priv=empty;
nu_star<nu<=1:        V_U^priv={(beta*o_1,beta*o_1)}.
```

## 10. Renda informacional sob maioria

Subtraindo o singleton público de cada vetor privado, obtém-se:

| Região pública | Classe privada | `RI_M=(theta_0,theta_1)` |
|---|---|---|
| `II` | `S` | `(0,0)` |
| `II` | `P` | `(d,0)` |
| `II` | `E` | `(a_0,a_1)` |
| `II` | `EP` | `lambda*(a_0,a_1)+(1-lambda)*(d,0)` |
| `IX` | `S` | `(0,-a_1)` |
| `IX` | `E` | `(a_0,0)` |
| `XX` | `E` | `(0,0)` |

Somente classes admitidas pelo conjunto frozen de N3 aparecem em cada ponto.
Em `II` com `o_1<1/m`, apenas `S` e `P` são possíveis. `E` e `EP` em `II`
só podem aparecer na fronteira `o_1=1/m`. Em `IX`, apenas `S` e `E` são
possíveis. Em `XX`, somente `E`.

No segmento `EP`, o conjunto exato é uma linha. Seu envelope é
`theta_0 in [min(a_0,d),max(a_0,d)]` e `theta_1 in [0,a_1]`, mas o retângulo
cartesiano desses dois intervalos não é a renda: a mesma `lambda` vincula as
duas coordenadas.

## 11. Renda informacional sob unanimidade

Subtraindo `V_U^pub`:

```text
nu=0:                 RI_U={(0,0)};
0<nu<=nu_star:        RI_U=empty;
nu_star<nu<=1:        RI_U={(d,0)}.
```

Na célula intermediária, a ausência de PBE puro em N4 torna `V_U^priv` e
`RI_U` vazios. A renda de maioria permanece preenchida.

## 12. Diferença das diferenças e sinais por tipo

### 12.1 Endpoint `nu=0`

| Região pública | `DeltaRI=RI_U-RI_M` | Sinal `theta_0` | Sinal `theta_1` |
|---|---|---|---|
| `II` | `(0,0)` | zero | zero |
| `IX` | `(0,a_1)` | zero | positivo |
| `XX` | `(0,0)` | zero | zero |

O sinal positivo na coordenada alta de `IX` é contrafactual ao tipo de
probabilidade zero: o vetor privado em `nu=0` mantém o payoff off-support de
`H1`, enquanto o benchmark público combina o jogo de `H0` e o jogo público
separado de `H1`, conforme a definição da Seção 1 do contrato.

### 12.2 Região `0<nu<=nu_star`

`RI_U` e `DeltaRI` são vazios. Não existe ordenação institucional robusta. A
coleção `RI_M` continua existindo e não é apagada.

### 12.3 Região `nu_star<nu<=1`

| Região pública | Classe privada M | `DeltaRI` | `theta_0` | `theta_1` |
|---|---|---|---|---|
| `II` | `S` | `(d,0)` | positivo | zero |
| `II` | `P` | `(0,0)` | zero | zero |
| `II` | `E` | `(k,-a_1)` | sinal de `k` | negativo |
| `II` | `EP` | `lambda*(k,-a_1)`, `lambda in [0,1]` | zero em `lambda=0`; para `lambda>0`, sinal de `k` | zero em `lambda=0`; negativo para `lambda>0` |
| `IX` | `S` | `(d,a_1)` | positivo | positivo |
| `IX` | `E` | `(k,0)` | positivo/zero/negativo conforme `beta*o_1` seja maior/igual/menor que `o_0` | zero |
| `XX` | `E` | `(d,0)` | positivo | zero |

Em `EP`, a presença de `lambda=0` impede uma conclusão estrita robusta em
qualquer coordenada, mesmo quando os demais pontos do segmento têm sinal
único. Não se substitui esse segmento pelo produto de seus envelopes.

## 13. Imagens ex ante, envelopes e robustez

Para qualquer conjunto de vetores `A`, sua imagem ex ante usa o mesmo prior de
entrada, `mu=nu`:

```text
Phi_mu(A)={(1-mu)z_0+mu*z_1 : (z_0,z_1) in A}.
```

Para `RI_U`, a imagem é `{0}` em `nu=0`, vazia na célula intermediária e
`{(1-mu)d}` na célula alta. Na célula alta ela é positiva se `mu<1` e zero em
`mu=1`.

Para `RI_M`, as imagens dos vetores da Seção 10 são obtidas pela mesma função.
No segmento `EP`, a imagem é o intervalo entre
`(1-mu)d` e `(1-mu)a_0+mu*a_1`; esse intervalo é imagem do próprio segmento,
não preenchimento de uma lacuna.

As imagens de `DeltaRI` são:

| Célula | Classe | Imagem ex ante |
|---|---|---|
| `nu=0`, `II/XX` | única | `0` |
| `nu=0`, `IX` | única | `mu*a_1=0` |
| alta `II` | `S` | `(1-mu)d` |
| alta `II` | `P` | `0` |
| alta `II` | `E` | `(1-mu)k-mu*a_1` |
| alta `II` | `EP` | `{lambda*((1-mu)k-mu*a_1): lambda in [0,1]}` |
| alta `IX` | `S` | `(1-mu)d+mu*a_1>0` |
| alta `IX` | `E` | `(1-mu)k` |
| alta `XX` | `E` | `(1-mu)d` |

Na fronteira `mu=1`, toda diferença que existe apenas na coordenada baixa tem
imagem ex ante zero. No segmento `EP`, zero pertence sempre à imagem, de modo
que nunca há ordenação ex ante estrita robusta. Fora do segmento, o sinal
robusto é o sinal da expressão escalar exibida.

Todo envelope reportado pela interface é apenas mínimo e máximo coordenado do
conjunto exato no mesmo ponto paramétrico. Ele não autoriza recombinação de
coordenadas, seleção de equilíbrio nem convexificação adicional.

## 14. Cobertura da interface terminal

As coleções públicas são cobertas assim:

- maioria R2: uma célula para cada tipo;
- unanimidade R2: uma célula para cada tipo;
- unanimidade R1: uma célula para cada tipo;
- maioria R1: duas células por tipo, `o_theta<=1/m` e `o_theta>1/m`.

As rendas de maioria têm três células públicas mutuamente exclusivas e
exaustivas: `II`, `IX` e `XX`. As rendas de unanimidade têm as três células de
N6: `nu=0`, `0<nu<=nu_star` e `nu_star<nu<=1`.

O contraste é o refinamento comum, com nove células: cada uma das três regiões
públicas cruzada com cada uma das três regiões de `nu`. As três células
intermediárias são `none` com certificado; as seis restantes contêm um registro
completo. Não existe registro sentinela ou parcialmente preenchido.

## 15. Invalidação e parada

Qualquer mudança no hash de N6 invalida integralmente a interface, o ledger, o
verificador e os pareceres de N7. Uma mudança confinada ao resultado público de
N7 não retroage sobre N1--N6. Uma discrepância de endpoint demonstraria erro em
fonte compartilhada e exigiria escalação; nenhuma discrepância foi encontrada.

N7 permanece `pending/unfrozen` durante implementação e revisão. Somente dois
pareceres independentes read-only, `formal_design` e `game_theory`, ambos
`PASS 0/0/0` no mesmo hash, permitem o freeze administrativo. Mesmo depois do
freeze, o Goal 4 não fecha sem aval explícito posterior do autor. Goal 5,
manuscrito, push, merge e tag permanecem fora do escopo.
