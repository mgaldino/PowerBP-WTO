# Derivação cega de `A_U` — agenda privada sob unanimidade

**Data:** 2026-08-27

**Nó:** `A_U`

**Status:** `CANDIDATO COMPLETO, NÃO REVISADO; DAG CONTINUA PENDING`

**Conceito:** correspondência completa de Perfect Bayesian Equilibrium (PBE),
com votos fracos puros as-if-pivotal, `T^Y` na indiferença e a regra local de
Bayes do contrato simplificado.

## 1. Fronteira cega, fontes e prontidão

Esta reconstrução não recebeu nem consultou fórmula, artefato, ledger, commit,
conversa ou resultado candidato de `A_M`. Ela consumiu apenas:

1. o contrato simplificado aprovado da extensão;
2. as fontes normativas presas pelo manifesto do Goal 1;
3. a visão completa congelada de `C_U`, no caminho
   `model_redesign/essential_input_solution_concept/n4_r1_unanimity_candidate.json`,
   SHA-256
   `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`.

`C_U` é topologicamente suficiente: expõe uma célula existente em `mu=0`, uma
célula `none` em `0<mu<=nu_star` e uma célula existente em
`nu_star<mu<=1`, preservando estratégias, crenças, payoffs, outcomes e data.
Nenhum byte de `C_U` foi alterado.

## 2. Primitivas e notação reduzida

Há `m=N-1>=2` Estados fracos. O tipo de `H` é `theta in {0,1}`, com prior
`nu=Pr(theta=1)`. No estágio `A`, o tipo escolhe obrigatoriamente

```text
s=(z,(x_j)_{j=1}^m) in Y,
z>=0, x_j>=0, z+sum_j x_j<=1.
```

Se a proposta passa, `H` recebe `z` e o fraco `j` recebe `x_j`, na data `A`.
O voto automático de `H` é `sim`; os `m` fracos votam simultaneamente. Se pelo
menos um fraco vota `não`, a proposta falha e entra uma continuação literal de
`C_U`, descontada uma vez por `beta`.

Da interface `C_U`, defina

```text
nu_star = (o_1-o_0)/(1-o_0),
ell     = beta*o_0,
h       = beta*o_1.
```

O conjunto de posteriores com continuação existente é

```text
E_U = {0} union (nu_star,1].
```

Uma proposta cujo posterior pertence a `(0,nu_star]` não pode integrar um
assessment: mesmo se todos os votos prescritos forem `sim`, a história factível
em que um fraco desvia para `não` exigiria uma continuação inexistente. Isso não
reduz o domínio inicial de `A_U`; restringe assessments, não priors.

## 3. Transporte de `C_U` para `A`: uma aplicação de `beta`

Antes do reconhecimento do proponente fraco dentro de `C_U`, o payoff nativo
de cada fraco é `(1-ell)/m` na célula `mu=0` e `(1-h)/m` na célula alta. O
payoff nativo de `H` é `(ell,h)` por tipo na célula baixa e `(h,h)` na célula
alta. Transportando uma única vez para `A`, defina

```text
w_0 = beta*(1-beta*o_0)/m,
w_1 = beta*(1-beta*o_1)/m,
d_0 = beta^2*o_0,
d_1 = beta^2*o_1.
```

Aqui `w_r` é a reserva, em unidades de `A`, de cada fraco quando a continuação
entra na célula `r in {0,1}`; `d_theta` é o payoff de rejeição do tipo `theta`
quando a entrada é `mu=0`. Na célula alta, os dois tipos de `H` recebem `d_1`.

Os maiores payoffs aprovados de `H` em cada célula são

```text
p_0 = 1-m*w_0 = 1-beta+beta^2*o_0,
p_1 = 1-m*w_1 = 1-beta+beta^2*o_1.
```

Logo

```text
0<w_1<w_0,
d_0<d_1,
p_0<p_1,
p_r-d_r=1-beta>0,
p_1-p_0=d_1-d_0=beta^2*(o_1-o_0).
```

Para separar as regiões, use

```text
Delta = p_0-d_1 = 1-beta-beta^2*(o_1-o_0),
u_min = max{p_0,d_1}.
```

## 4. Votação fraca sob unanimidade

Fixe a proposta `s` e um fraco `j`. Com o `sim` automático de `H`, o voto de
`j` é pivotal em exatamente um perfil relevante: todos os outros `m-1` fracos
votam `sim`. Se `j` vota `sim`, há aprovação e ele recebe `x_j`. Se vota
`não`, há rejeição e ele recebe seu próprio payoff na continuação literal
selecionada por `kappa_U`, multiplicado por `beta` uma vez.

Pagamentos de `H` e dos demais fracos não entram nessa comparação. Não há
kernel, média sobre vetores contrafactuais, tremble ou invariância artificial.
Como todos os membros literais de cada fibra existente de `C_U` têm o mesmo
payoff pré-reconhecimento para `j`, a regra é

```text
se mu(s)=0:          j vota sim sse x_j>=w_0;
se mu(s)>nu_star:    j vota sim sse x_j>=w_1.
```

A igualdade produz `sim` por `T^Y`. Assim, a proposta passa se e somente se
todos os `m` pagamentos satisfazem o piso da célula pertinente.

## 5. Crenças e continuação literal

Para estratégias de proposta Borelianas `sigma_0` e `sigma_1`, seja

```text
M=(1-nu)*sigma_0+nu*sigma_1.
```

Em cada ponto disciplinado de `Y`, o posterior `mu(s)` é o limite local de
Bayes prescrito no contrato. O limite deve existir. Fora do suporte topológico
público, `mu(s)` é livre dentro do suporte do prior, mas deve pertencer a
`E_U`; caso contrário, alguma história rejeitada não possui continuação. Nos
endpoints, `mu` é identicamente 0 ou 1.

Depois de qualquer vetor de votos fracos, o posterior permanece `mu(s)`. Para
cada história pública rejeitada `r=(U,s,H,v,fail,mu(s))`,

```text
kappa_U(r) in C_U(mu(s))
```

é um membro literal completo: o binder de `kappa_U` mantém juntos estratégias,
crenças internas, votos, payoffs, outcomes e proveniência daquele membro.
`kappa_U` é pública, comum aos tipos compatíveis, total e Borel-mensurável.
Membros distintos podem ser escolhidos em histórias distintas, mas não há
recombinação de coordenadas. A multiplicidade interna de crenças da célula alta
de `C_U` é preservada; ela não altera os payoffs `w_1` e `d_1` usados acima.

Uma seleção Borel existe: na célula baixa usa-se o membro único; na célula alta,
o registro fonte permite, por exemplo, escolher as crenças internas livres
iguais à crença de entrada quando irrestritas e iguais a 1 quando a restrição
interna requer apenas um valor suficientemente alto. A correspondência de
`A_U` preserva todas as seleções Borel admissíveis, não apenas essa testemunha.

## 6. Jogo reduzido do proponente

Escreva `a(s)=1` quando todos os fracos aprovam pela regra da Seção 4 e
`a(s)=0` quando algum rejeita. O payoff em `A` induzido pelo mesmo assessment é

```text
g_0(s) = z,   se a(s)=1;
         d_0, se a(s)=0 e mu(s)=0;
         d_1, se a(s)=0 e mu(s)>nu_star;

g_1(s) = z,   se a(s)=1;
         d_1, se a(s)=0.
```

Defina as propostas canônicas

```text
q_0=(p_0,w_0,...,w_0),
q_1=(p_1,w_1,...,w_1).
```

`q_0` sempre passa, qualquer que seja a crença admissível, e assegura `p_0` a
qualquer tipo. Uma proposta com algum `x_j<w_1` sempre falha e assegura `d_1`
ao tipo alto. Portanto, em qualquer PBE interior,

```text
U_0>=p_0,
U_1>=max{p_0,d_1}=u_min.
```

Nenhum tipo pode receber mais de `p_1`: aprovação na célula baixa paga no
máximo `p_0`, aprovação na alta paga no máximo `p_1`, e rejeição paga no
máximo `d_1<p_1`.

## 7. Lema de equalização no interior

**Lema 1.** Se `0<nu<1`, todo PBE de `A_U` satisfaz `U_0=U_1=u`.

**Prova.** Considere uma proposta usada com probabilidade positiva no sentido
de medida por um tipo. Pela regra de Bayes, `sigma_1` não pode atribuir massa
positiva, nem densidade condicional positiva, a um conjunto cujo posterior seja
zero; portanto, `sigma_1`-quase toda proposta usada pelo tipo alto está na
célula alta. Nessa célula, uma proposta aprovada paga o mesmo `z` aos dois tipos
e uma proposta rejeitada paga `d_1` aos dois. Logo o tipo baixo pode imitar uma
melhor resposta usada pelo tipo alto e obter `U_1`, dando `U_0>=U_1`.

Na célula baixa, Bayes permite massa pública apenas do tipo baixo. Como
`U_0>=p_0`, a única proposta baixa usada com probabilidade positiva pelo tipo
baixo é `q_0`, aprovada com payoff `p_0`; o tipo alto pode imitá-la e também
obter `p_0`. Se o tipo baixo usa uma proposta alta, o tipo alto a imita; se usa
somente `q_0`, seu payoff é `p_0`. Em qualquer caso `U_1>=U_0`. As duas ICs dão
`U_0=U_1`. QED.

Consequentemente,

```text
u in [u_min,p_1].
```

## 8. Restrição de Bayes para priors baixos

**Lema 2.** Se um PBE interior tem `u>p_0`, então `nu>nu_star`.

**Prova.** Uma proposta com posterior 0 paga ao tipo baixo no máximo `p_0`.
Logo, quando `u>p_0`, nenhuma proposta de posterior 0 recebe massa pública no
caminho. Toda proposta no suporte público tem posterior estritamente maior que
`nu_star`. Pela plausibilidade de Bayes,

```text
nu = integral mu(s) dM(s) > nu_star.
```

QED.

Se `0<nu<=nu_star`, o único payoff interior possível é, portanto, `u=p_0`.
Isso exige `p_0>=d_1`, isto é, `Delta>=0`.

## 9. Gerador necessário e suficiente dos membros interiores

Para `0<nu<1`, um binder

```text
b=(nu,u,sigma_0,sigma_1,mu,kappa_U)
```

gera um PBE se e somente se satisfaz as condições abaixo.

1. `u in [u_min,p_1]`; além disso, se `nu<=nu_star`, então
   `Delta>=0` e `u=p_0`.
2. `sigma_0` e `sigma_1` são probabilidades Borelianas em `Y`; o limite local
   de Bayes existe em todo ponto disciplinado e produz `mu(s) in E_U`.
3. Fora do suporte público, `mu(s) in E_U` respeita o suporte do prior.
4. Em toda proposta com `mu(s)>nu_star` que seria aprovada, `z<=u`. Esta é a
   condição global que elimina desvios lucrativos para demandas altas fora do
   caminho.
5. Cada `sigma_theta` atribui probabilidade um à união dos seguintes conjuntos
   de melhor resposta (isto é, fica concentrada neles quase certamente; não se
   exige que o suporte topológico exclua pontos-limite de medida zero):

   ```text
   L_0      = {q_0 com mu(q_0)=0}, permitido somente se u=p_0 e somente ao tipo 0;
   H_A(u)   = {mu(s)>nu_star, todos x_j>=w_1 e z=u};
   H_R      = {mu(s)>nu_star e algum x_j<w_1}, permitido somente se u=d_1.
   ```

6. `kappa_U` satisfaz a Seção 5, e os votos fracos satisfazem a Seção 4 em
   toda proposta factível.

**Necessidade.** Os limites de payoff e os Lemas 1–2 dão as condições 1. A
totalidade de `kappa_U` exclui posteriores intermediários. Bayes e a decisão
de no-signaling dão 2–3. Uma proposta alta aprovada com `z>u` seria desvio
lucrativo, dando 4. No suporte, uma proposta baixa só pode entregar `u` quando
é `q_0` e `u=p_0`; uma proposta alta entrega `u` se aprovada com `z=u`, ou se
rejeitada quando `u=d_1`. Isso dá 5. A racionalidade sequencial dos fracos e a
continuação completa dão 6.

**Suficiência.** Sob 2–3 e 6, crenças, votos e continuações são sequencialmente
racionais e consistentes. Para uma proposta baixa, aprovação paga no máximo
`p_0<=u` e rejeição paga no máximo `d_1<=u`. Para uma proposta alta, rejeição
paga `d_1<=u` e, por 4, aprovação paga no máximo `u`. Assim nenhum tipo possui
desvio lucrativo em todo `Y`. Pela condição 5, todo ponto usado por cada tipo
entrega exatamente `u`, logo misturas são ótimas. As estratégias, crenças,
continuações e outcomes amarrados pelo mesmo binder formam PBE. QED.

Esse gerador inclui pooling, separating, semi-pooling, medidas contínuas e
misturas, desde que a regra local de Bayes exista em todo ponto disciplinado.
Não há enumeração artificial de uma linha por membro.

## 10. Existência por célula e testemunhas

### 10.1 Endpoint `nu=0`

O suporte do prior força `mu(s)=0` em todo `Y`. O tipo baixo usa unicamente
`q_0`. O tipo alto, embora tenha peso zero, deve ser racional:

```text
Delta>0: sigma_1=delta_{q_0};
Delta=0: sigma_1 é qualquer probabilidade Borel em {q_0} union R_0;
Delta<0: sigma_1 é qualquer probabilidade Borel em R_0;
R_0={s: algum x_j<w_0}.
```

O vetor de payoff por tipo é

```text
(U_0,U_1)=(p_0,max{p_0,d_1}).
```

O valor ex ante é `p_0`.

### 10.2 `0<nu<=nu_star`

- Se `Delta<0`, não existe PBE. Pelo Lema 1, `u>=d_1>p_0`; pelo Lema 2 isso
  exigiria `nu>nu_star`, contradição.
- Se `Delta>=0`, existe e todo PBE tem payoff `(p_0,p_0)`. Uma testemunha
  separating é: tipo baixo propõe `q_0`, tipo alto propõe
  `q_H=(p_0,w_1,...,w_1)`, Bayes dá posteriores 0 e 1, e toda proposta fora do
  caminho recebe posterior 0. `q_H` é factível porque deixa folga
  `p_1-p_0`; ambos os tipos recebem `p_0`, e `d_1<=p_0` elimina o desvio por
  rejeição.

### 10.3 `nu_star<nu<1`

Existe PBE para todo

```text
u in [max{p_0,d_1},p_1].
```

Uma testemunha para cada `u` faz pooling atômico na proposta

```text
q(u)=(u,w_1,...,w_1).
```

Ela é factível porque `u<=p_1`, recebe posterior `nu>nu_star` e passa. Toda
proposta fora do caminho recebe posterior 0. Um desvio aprovado paga no máximo
`p_0<=u`; um desvio rejeitado paga no máximo `d_1<=u`.

### 10.4 Endpoint `nu=1`

O suporte do prior força `mu(s)=1` em todo `Y`. Ambos os tipos têm a melhor
resposta única `q_1`, pois `p_1>d_1`. O vetor de payoff é `(p_1,p_1)` e o
valor ex ante é `p_1`.

## 11. Atraso endógeno e multiplicidade de outcomes

Em prior interior, rejeição no caminho só pode ocorrer em `H_R`, logo somente
quando

```text
u=d_1>=p_0  (Delta<=0).
```

Quando a desigualdade é estrita, isso requer `nu>nu_star`. Na igualdade
`Delta=0`, também pode ocorrer na célula de prior baixo que existe. O gerador
preserva qualquer mistura admissível entre propostas altas aprovadas com
`z=d_1` e propostas altas rejeitadas. Portanto, payoff igual não implica
outcome único: a probabilidade de atraso é coordenada do mesmo binder, nunca um
envelope recombinado.

## 12. Payoffs fracos, outcomes e imagem ex ante

Para um membro de binder `b`, escreva `a_b(s)` para o indicador de aprovação e
`v_b(s)` para o vetor puro de votos. Para cada tipo `theta` e identidade fraca
`j`, o payoff em unidades de `A` é

```text
U_j(theta;b)
 = integral [a_b(s)*x_j
             +(1-a_b(s))*w(mu_b(s))] d sigma_theta(s),
```

onde `w(0)=w_0` e `w(mu)=w_1` para `mu>nu_star`. Não entra pagamento alheio.
O payoff de `H` é a integral de `g_theta`, igual ao valor registrado nas
Seções 9–10.

A distribuição completa de outcomes é o pushforward conjunto de
`theta`, `sigma_theta`, do indicador `a_b` e, após rejeição, do membro literal
`kappa_U(r)`. Assim ela registra separadamente aprovação imediata em `A`,
rejeição/entrada em `C_U` e os outcomes internos do mesmo membro fonte. Essa
definição preserva outcomes condicionais mesmo quando o resumo de uma célula de
`C_U` dá peso zero a um tipo no endpoint.

A imagem ex ante exata de `H` é

```text
nu=0:                         {p_0};
0<nu<=nu_star, Delta<0:       emptyset;
0<nu<=nu_star, Delta>=0:      {p_0};
nu_star<nu<1:                 [max{p_0,d_1},p_1];
nu=1:                         {p_1}.
```

No interior, a expectativa `(1-nu)U_0+nu*U_1` é igual ao payoff comum `u`.
Nos endpoints, os tipos de peso zero permanecem no registro por tipo, mas não
alteram a imagem ex ante.

## 13. Cobertura, necessidade, suficiência e invalidação

As cinco células da Seção 12 são mutuamente exclusivas e exaustivas porque
`nu_star in (0,1)` e `Delta` tem exatamente um dos sinais `negative` ou
`nonnegative` na região baixa. O gerador da Seção 9 é necessário e suficiente
para todos os membros interiores; as Seções 10.1 e 10.4 cobrem separadamente os
endpoints degenerados do prior. Não há payoff-sentinela na célula vazia.

A prova matemática, não o script, sustenta: completude de PBE; ausência de
desvio lucrativo em todo `Y`; otimalidade das misturas; consistência local de
Bayes; totalidade e mensurabilidade declaradas de `kappa_U`; e cobertura das
famílias. O script `scripts/verify_agenda_extension_A_U_mechanical.R` verifica
somente schema, hashes, identidades algébricas e exemplos finitos de
testemunhas; ele não é prova matemática.

Qualquer mudança no hash de `C_U`, no contrato, na regra local de Bayes, na
regra pivotal ou no transporte temporal invalida este candidato inteiro.
Qualquer mudança neste artefato invalida seu ledger e o futuro consumidor
`AC`. O DAG permanece `pending`; passagem depende de `AC` e das duas revisões
matemáticas finais do pacote privado.
