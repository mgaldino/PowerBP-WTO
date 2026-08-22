# N6 — comparação dos jogos com informação privada

**Data:** 2026-08-21
**Status durante a implementação:** `pending/unfrozen`
**Domínio autorizado:** `m >= 3`, `nu in [0,1]`, somente PBE com ballots puros
**Regra de contraste:** sempre `unanimidade - maioria`

## 1. Escopo e fontes congeladas

N6 não resolve novamente nenhum ballot. Ele transporta e compara somente estes
dois objetos congelados:

- N3, R1 sob maioria: `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- N4, R1 sob unanimidade: `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`.

A autorização de N6 é
`quality_reports/2026-08-21_autorizacao_goal3_n6.md`, no hash
`sha256:4c18e9bfd244b8024f2d707f714d3ce57f7b635d603def1577430899bf3951cd`.
O contrato é o Gate 0 de 2026-08-12. Não há benchmark público,
contrafactual, renda informacional, `beta=1`, formação, extensão, estratégia
mista em ballot ou migração para manuscrito.

O filtro `m>=3` é aplicado em N6. As interfaces de origem cobrem também
`m=2`, mas nenhum registro de N6 o transporta.

## 2. Notação transportada

Use `N=m+1`, `q=floor(N/2)+1` e:

```text
w     = beta/m
ell   = beta*o_0
h     = beta*o_1
A     = beta*(1-o_0)/m
B     = beta*(1-o_1)/m
nu_*  = (o_1-o_0)/(1-o_0)

E     = 1-(q-1)w
L     = 1-(q-2)w-ell
S(nu) = (1-nu)L+nu*w
P     = 1-(q-2)w-h
```

As três classes econômicas que podem pertencer ao argmax lexicográfico de N3
são:

| Classe N3 | Vetor de payoff de H `(theta_0,theta_1)` | Outcome `(com H, sem H, falha, delay)` |
|---|---|---|
| `E`, exclusão | `(o_0,o_1)` | `(0,1,0,0)` |
| `S`, screening baixo | `(ell,h)` | `(1-nu,0,0,nu)` |
| `P`, pooling | `(h,h)` | `(1,0,0,0)` |

Para cada classe `c`, denote por `v_c` o payoff do proponente e por
`Hbar_c(nu)` o payoff ex ante de H:

```text
v_E=E,       Hbar_E=(1-nu)o_0+nu*o_1
v_S=S(nu),   Hbar_S=beta*((1-nu)o_0+nu*o_1)
v_P=P,       Hbar_P=beta*o_1
```

O conjunto exato de classes selecionadas por N3 é:

```text
A_M(nu) = argmin Hbar_c(nu)
          entre as classes c que maximizam v_c no conjunto factível.
```

Esse operador reproduz literalmente a seleção de N3: primeiro maximiza o
payoff do proponente; depois minimiza o payoff esperado de H. Qualquer
distribuição sobre propostas do argmax é preservada pela família
`F=(F_i)_{i in W}` da interface N3.

## 3. Partição comum

N3 tem uma célula de cobertura para todo `nu in [0,1]`. N4 tem três células.
Logo, depois de aplicar `m>=3`, o refinamento comum possui exatamente estas
três células:

| Célula N6 | Domínio | Maioria | Unanimidade | Comparação |
|---|---|---|---|---|
| `N6-CMP-NU-ZERO` | `nu=0` | existe | existe, `L_*` | existe |
| `N6-CMP-NO-PURE-PBE` | `0<nu<=nu_*` | existe | `none` | `none` |
| `N6-CMP-HIGH-PRIOR` | `nu_*<nu<=1` | existe | existe, `P_*` | existe |

As fronteiras são deliberadas: zero pertence apenas à primeira célula;
`nu_*` pertence à célula `none`; e a célula alta é aberta em `nu_*` e fechada
em um. Como `0<nu_*<1`, as células são disjuntas e exaustivas.

Essas são as três células de cobertura exigidas pelo schema: N3 possui um
único registro familiar e cada combinação de IDs de origem deve aparecer uma
única vez. Dentro dos dois registros comparáveis, a partição econômica exata
tem sete classes disjuntas: `C0-S`, `C0-E`, `C-NONE`, `CH-S`, `CH-P`, `CH-E`
e `CH-EP`. As seis classes comparáveis são reportadas dentro do mesmo registro
de origem N3, sem duplicá-lo; `C-NONE` é a célula de cobertura intermediária.

As coleções por regra permanecem separadas. A inexistência sob unanimidade na
célula intermediária não apaga o registro de maioria.

## 4. Certificado técnico da célula `none`

N6 transporta o certificado frozen `N4-C08`. Para
`0<nu<=nu_*`, N4 contém a proposta factível:

```text
s_dagger = (Y=ell, x_j=A para todo weak responder,
            r_i=Q_L=1-ell-(m-1)A).
```

Como `A` é o máximo do valor de continuação pivotal de um weak responder,
todos os fracos votam `sim` após `s_dagger` para cada perfil puro de H. A
dependência circular é então fechada pela enumeração dos quatro perfis de H:

```text
(sim,sim): H1 prefere não e a continuação h>ell;
(não,não): H0 empata em ell e T^Y exige sim;
(sim,não): H0 imita o não de H1, que induz posterior 1, e obtém h>ell;
(não,sim): H1 imita o não de H0 e obtém h>ell.
```

Assim, o voto informativo de H determina o posterior usado no cálculo
as-if-pivotal dos fracos, enquanto os votos fracos determinam a pivotalidade
que entra na melhor resposta de H. Nenhum dos quatro perfis fecha esse ponto
fixo em estratégias puras. Como PBE exige completamento sequencial também
depois da proposta factível fora do caminho, N4 não possui PBE puro nessa
célula. N6 registra `existence_status=none`, sem payoff e sem comparação.

Este é apenas um certificado técnico do jogo; não recebe interpretação de
manuscrito e não abre análise de estratégias mistas.

## 5. Conjuntos exatos e vínculo atômico

Para cada ponto paramétrico comparável, deixe `lambda` ser a massa agregada das
famílias `F_i` de N3 sobre as classes de `A_M(nu)`. A mesma `lambda` deve ser
usada simultaneamente em payoff e outcome. O conjunto conjunto exato de
maioria é:

```text
J_M(nu) = {
  (sum_c lambda_c H_c, sum_c lambda_c O_c):
  lambda_c>=0, sum_c lambda_c=1, support(lambda) subset A_M(nu)
}.
```

Essa representação não adiciona mistura: distribuições sobre o argmax já são
parte expressa da interface frozen N3. Fora de um empate preservado por N3,
`A_M(nu)` é singleton e `J_M(nu)` também é singleton. Payoffs e outcomes não
são projetados separadamente nem recombinados.

Sob unanimidade, o conjunto é singleton nas células comparáveis:

```text
J_U(0)             = {((ell,h),(1,0,0,0))};
J_U(nu), nu>nu_*   = {((h,h),(1,0,0,0))}.
```

O conjunto conjunto exato de contrastes é:

```text
J_Delta(nu) = {
  (H_U-sum_c lambda_c H_c, O_U-sum_c lambda_c O_c):
  lambda_c>=0, sum_c lambda_c=1, support(lambda) subset A_M(nu)
}.
```

O mesmo `lambda` nos dois componentes é a condição de atomicidade. Um vetor de
payoff de uma seleção não pode ser combinado com o outcome de outra.

## 6. Célula `nu=0`

Em `nu=0`, pooling é estritamente pior que screening porque `o_1>o_0`. A
seleção de N3 é:

```text
A_M(0)={S}, se o_0<=1/m;
A_M(0)={E}, se o_0>1/m.
```

Na igualdade `o_0=1/m`, `S=E` em payoff do proponente, mas screening deixa
`beta*o_0<o_0` a H e vence pelo desempate autorizado. Portanto a multiplicidade
por identidades fracas não altera o contraste:

| Classe de maioria | Contraste de payoff de H `U-M` | Contraste de outcome `U-M` |
|---|---|---|
| `S`, se `o_0<=1/m` | `(0,0)` | `(0,0,0,0)` |
| `E`, se `o_0>1/m` | `(-(1-beta)o_0, -(1-beta)o_1)` | `(1,-1,0,0)` |

Logo a unanimidade coincide com a maioria quando a maioria seleciona screening
no endpoint. Quando a maioria exclui H, a unanimidade reduz estritamente o
payoff de ambos os tipos de H e troca passagem sem H por passagem com H.

## 7. Célula `nu_*<nu<=1`

N4 seleciona `P_*`, com payoff de H `(h,h)` e passagem imediata com H. Para
cada classe selecionada por N3, o contraste é:

| Classe de maioria | Contraste de payoff de H `U-M` | Contraste de outcome `U-M` |
|---|---|---|
| `E` | `(beta*o_1-o_0, -(1-beta)o_1)` | `(1,-1,0,0)` |
| `S` | `(beta*(o_1-o_0), 0)` | `(nu,0,0,-nu)` |
| `P` | `(0,0)` | `(0,0,0,0)` |

A partição exata de N3, a ser intersectada com `nu_*<nu<=1`, é:

1. Se `o_1<1/m`, `A_M={S}` para `nu<=nu_SP` e `A_M={P}` para
   `nu>nu_SP`, onde
   `nu_SP=beta*(o_1-o_0)/[1-beta*o_0-beta*(q-1)/m]`.
2. Se `o_0<1/m<o_1`, `A_M={S}` para `nu<=nu_SE` e `A_M={E}` para
   `nu>nu_SE`, onde
   `nu_SE=beta*(1/m-o_0)/[beta*(1/m-o_0)+1-beta*q/m]`.
3. Se `1/m<o_0<o_1`, `A_M={E}` para todo `nu`.
4. Se `o_0=1/m<o_1`, `A_M={E}` para todo `nu>0`.
5. Se `o_0<o_1=1/m`, `A_M={S}` para `nu<=nu_SE`. Para
   `nu>nu_SE`, o payoff do proponente empata entre `E` e `P`; o desempate dá
   `A_M={E}` se `Hbar_E<Hbar_P`, `A_M={P}` se `Hbar_P<Hbar_E` e
   `A_M={E,P}` na igualdade.

Somente no último empate, quando as duas etapas da seleção empatam, a
distribuição preservada por N3 gera um segmento conjunto efetivo entre os
contrastes de `E` e `P`. Isso é parte do conjunto exato, não preenchimento por
um envelope.

Mais explicitamente, em `CH-EP`, seja
`lambda=(1/m)*sum_i lambda_i` a massa agregada de exclusão nas famílias `F_i`.
Então:

```text
H_M(lambda)     = lambda*(o_0,o_1)+(1-lambda)*(h,h)
O_M(lambda)     = (1-lambda,lambda,0,0)
DeltaH(lambda)  = lambda*(h-o_0,h-o_1)
DeltaO(lambda)  = (lambda,-lambda,0,0),  lambda in [0,1].
```

O mesmo `lambda` aparece nas quatro linhas. Esse vínculo impede recombinação
entre payoff e outcome.

Três conclusões são uniformes dentro da célula comparável alta:

- para `theta_1`, unanimidade nunca melhora o payoff de H: o contraste é zero
  sob `S` ou `P` e estritamente negativo sob `E`;
- para `theta_0`, o contraste é positivo sob `S`, zero sob `P` e tem sinal
  dependente de `beta*o_1-o_0` sob `E`;
- unanimidade elimina o delay que aparece sob screening de maioria; não há
  falha em nenhuma célula comparável.

## 8. Envelopes derivados sem preenchimento

Para uma coordenada `k` de payoff ou outcome, o envelope reportado é somente:

```text
lower_k(nu) = min_{c in A_M(nu)} Delta_k(c);
upper_k(nu) = max_{c in A_M(nu)} Delta_k(c).
```

O envelope não substitui `J_Delta`, não forma produto cartesiano entre
coordenadas e não cria valores que N3 não admite. Na igualdade residual
`A_M={E,P}`, valores internos aparecem no conjunto exato apenas porque a
própria interface N3 admite distribuições sobre essas duas propostas.

## 9. Permutações de identidades fracas

Fixe uma identidade proponente `i`. Uma proposta de exclusão escolhe
`q-1` entre os `m-1` responders; screening ou pooling escolhe `q-2`. Assim,
antes do quociente há, para cada `i`:

```text
exclusão:  choose(m-1,q-1) coalizões rotuladas;
screening: choose(m-1,q-2) coalizões rotuladas;
pooling:   choose(m-1,q-2) coalizões rotuladas.
```

Uma permutação de identidades fracas preserva a quota, a soma dos pagamentos,
a lei uniforme de reconhecimento, a classe `E/S/P`, o vetor de payoff de H e o
outcome. Logo cada conjunto de coalizões do mesmo tamanho é uma órbita para as
coordenadas comparadas em N6. O relatório pode mostrar um representante por
classe.

O quociente não apaga a multiplicidade: a interface mantém o
`source_equilibrium_id`, a família indexada `F=(F_i)_i`, a massa entre classes
e os IDs de cada registro comparado. Permutações que alteram apenas rótulos são
quocientadas; distribuições que alteram a massa entre `E` e `P` no empate não
são.

## 10. Invalidação e parada

N6 depende exatamente dos hashes frozen de N3 e N4. Qualquer mudança em um
deles invalida integralmente esta derivação, a interface, o ledger, o verifier,
os pareceres e o freeze de N6. N7 permanece `pending/null`; este documento não
fornece nenhum input público nem calcula renda informacional.
