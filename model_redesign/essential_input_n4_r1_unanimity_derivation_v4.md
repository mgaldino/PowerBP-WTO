# N4 v4 — R1 sob unanimidade

**Nó:** `N4`
**Status:** `pending/unfrozen`; candidato v4 ainda não submetido à revisão
**Contrato:** `quality_reports/plans/2026-08-12_essential_input_gate0.md`
**Dependência única:** N2 congelado,
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`
**Nota fria v4:**
`model_redesign/essential_input_n4_r1_unanimity_cold_notes_v4.md`,
`sha256:a2f44b0ba0bdc1658406489be0605ffbb626d023ed0abb478530b96cec56e4c7`

Esta versão repara exatamente os findings `N4V3-FD-01`, `N4V3-FD-02` e
`N4V3-GT-01` sobre o candidato v3. O primeiro exige um bound localizado nos
atrasos on-path por múltiplos vetos weak. Os dois últimos exigem certificação
semântica integral independente. Todos os demais resultados abaixo foram
rechecados pelos dois pareceres e são preservados sem mudança de jogo ou
seleção.

## 1. Continuação N2 e unidades

Para `m=N-1>=2`, defina

```text
nu_star = (o_1-o_0)/(1-o_0)
ell     = beta*o_0
h       = beta*o_1
A       = beta*(1-o_0)/m
B       = beta*(1-o_1)/m
D       = (1-nu)*A
C       = D, se nu<=nu_star; B, se nu>nu_star
```

N2 low-type-only fornece valor subjetivo weak `A*(1-eta)`, vetor realizado
weak `(A,0)` e vetor de H `(ell,h)`. N2 pooling fornece `B`, `(B,B)` e
`(h,h)`. Todas essas quantidades já contêm exatamente um fator `beta`. O voto
weak usa o valor subjetivo; o desvio do proponente usa o vetor realizado no
prior verdadeiro; H usa o vetor condicionado ao tipo.

## 2. Oracle do ballot

O ballot tem `m` votantes: H e `m-1` weak responders. O oracle v4 enumera os
`2^m` vetores e exige continuação em todos os `2^m-1` vetores de falha. Para
cada responder compara `yes/no` contra os `2^(m-1)` perfis dos demais,
elimina dominância fraca, impõe melhor resposta sequencial e só então aplica
`T^Y` numa igualdade genuína. H satisfaz PBE e `T^Y`, sem stage-undominance.

Em propostas on-path, o weak proposer não observa `theta`, de modo que a
crença no ballot é `nu`; todo vetor positivo satisfaz Bayes. Propostas e
vetores de probabilidade zero preservam os posteriores livres permitidos pelo
contrato. O proponente desviante sempre integra payoffs realizados de N2 sob
`nu`, nunca sob a crença arbitrária do ballot.

## 3. Classes puras exaustivas

- `P`: ambos os tipos de H e todos os weak responders dizem `yes`; existe para
  todo prior.
- `L`: H0=`yes`, H1=`no` e todos os weak responders `yes`; existe somente em
  `nu=0`.
- `D`: atraso por veto de H ou por pelo menos um veto weak.

High-type-only exigiria simultaneamente `Y<ell` e `Y>=h`, impossível porque
`ell<h`. Em prior positivo, a falha de H1 em low-only revela o tipo alto e leva
a pooling em N2; H0 pode imitar e obter `h`, incompatível com `Y<h`. Com veto
weak, H1 sempre usa `yes`; Bayes torna qualquer separação de H incompatível com
a melhor resposta de H0.

## 4. Respostas weak e correção multi-veto

P e L exigem `x_j>=B` para todo weak responder. O veto de H tem os bounds

```text
m=2, nu<nu_star:  x>=0
m=2, nu>=nu_star: x>=B
m>=3:             apenas factibilidade
```

Um veto weak único `k` exige `x_k<=C`, incluindo igualdade. Para pelo menos
dois vetos weak e `m>=3`, a condição correta é

```text
nu<nu_star:  apenas factibilidade
nu>=nu_star: x_k<=B para cada weak state que vota no
```

### Necessidade na fronteira e acima

O vetor de múltiplos vetos é on-path e não revelador, logo Bayes fixa seu valor
weak em `C=B`. Uma troca unilateral ainda deixa falha e paga pelo menos `B`.
`T^Y` eliminaria o veto numa igualdade genuína; assim, `no` precisa dominar
fracamente `yes`. A dominância simultânea de todos os vetos impõe que todo
vetor não vazio formado por subconjunto dos vetos tenha valor `B`: parte-se do
vetor on-path e aplica-se indução descendente. Na linha pivotal, portanto,
`no` paga `B` e `yes` paga `x_k`, o que exige `x_k<=B`.

### Suficiência e igualdade

Com `x_k<=B`, faça toda falha com H=`yes` pagar `B` aos weak states: no vetor
realizado, Bayes seleciona low-type-only na fronteira e pooling acima dela;
nos demais vetores, use pooling off-path. Com H=`no`, use low-type-only
exatamente quando todos os vetos designados votam `no` e nenhum outro
responder veta; use pooling nos demais vetores. Cada veto tem `no` fracamente
dominante e uma linha estrita; cada não veto tem uma linha estrita favorável a
`yes`; H0 prefere `yes` acima da fronteira e usa `T^Y=yes` na fronteira; H1
usa `T^Y=yes`. A construção inclui `x_k=B`.

Se `nu<nu_star`, o vetor on-path paga `D>B`, enquanto o desvio unilateral do
veto pode receber pooling `B`. Essa linha estrita impede dominância de `no` por
`yes`, quaisquer que sejam os `x_k`. O bound adicional desaparece.

## 5. Security para `m>=3`

Depois de proposta zero-probabilidade, prescreva todos os weak responders em
`no`, H0=`no`, H1=`yes`, pooling no vetor de H0 e low-type-only no vetor de
H1. Como Bayes não fixa esse ballot, valores off-path podem crescer de `B` a
`A` com o número de vetos e sustentar todos os votos. O proponente recebe
`(B,0)`, portanto

```text
S_3(nu)=(1-nu)*B.
```

`Y=0` garante ao menos esse vetor sob qualquer resposta, logo `S_3` é exato e
atingido. O novo bound da Seção 4 é exclusivamente on-path e não altera essa
punição.

## 6. Security e topologia para `m=2`

Defina

```text
Q_L     = 1-ell-A
Q_P     = 1-h-A
R_0     = min{D,B}
R_L     = min{(1-nu)*Q_L,B}
R_P     = max{0,Q_P}
S_2     = max{R_0,R_L,R_P}
H_L     = (1-nu)*ell+nu*h.
```

`R_0` é sempre atingido em `x=A`. `R_P>0` é somente supremo, pois passagem
forçada exige `x>A`. Para `nu<1`, `R_L` é atingido exatamente se
`(1-nu)*Q_L>B`; na igualdade ou abaixo é somente supremo. Em `nu=1`, seu zero
é atingido. O menor payoff de H entre desvios que atingem `S_2` é

```text
H_tie = H_L,     se S_2=R_0=D<B
        h,       se algum componente atingido iguala S_2 e o caso anterior falha
        +infty,  se somente componentes não atingidos alcançam S_2.
```

`H_tie` governa apenas o tie-break entre propostas que pagam exatamente
`S_2`; não transforma um supremo não atingido em desvio fictício.

## 7. Famílias e endpoints

### Pooling P

Use `S=S_3` para `m>=3` e `S=S_2` para `m=2`:

```text
h<=Y<=y_bar
x_j>=B para todo j
r_i>=S
Y+sum_j x_j+r_i<=1.
```

Folga e vetores heterogêneos são preservados. Se `m>=3` e `r_i=S_3`, o
tie-break exige `Y=h`. Se `m=2` e `r_i=S_2`, exige `Y<=H_tie`. Defina
`U_P=1-(m-1)B-S`. O mínimo `h` é atingido. Se `y_bar<U_P`, `y_bar` é máximo
atingido com `r_i>S`. Se `y_bar>=U_P`, o endpoint orçamentário é atingido
somente em `m=2,H_tie=+infty`; nos demais casos é supremo não atingido.

### Low-type-only L

Somente em `nu=0`:

```text
ell<=Y<h
x_j>=B para todo j
r_i>=S
Y+sum_j x_j+r_i<=1.
```

`ell` é mínimo atingido e `h` supremo não atingido. No endpoint `r_i=S`, o
payoff de H é menor que o witness de security relevante e o tie-break não o
elimina. H recebe `(Y,h)`.

### Delay D

O proponente recebe `C`. H recebe `(ell,h)` em `nu<=nu_star` e `(h,h)` acima.
Para `m>=3`, `C>S_3` e delay existe para todo prior. Para `m=2`, existe se e
somente se `C>=S_2`, equivalente a `D>=R_P` na região baixa e `B>=R_P` na
alta. As implementações são H-veto, veto weak único e, para `m>=3`, conjuntos
rotulados de múltiplos vetos sujeitos à condição exata da Seção 4.

## 8. Identidades, misturas, payoffs e outcomes

Para cada proposer rotulado `i`, preserve qualquer família, pacote, ballot,
crença e continuação admissível. Se `R_i` é seu payoff reconhecido e `w_ik` o
payoff de `k` quando `i` propõe,

```text
V_Wk=(R_k+sum_{i!=k}w_ik)/m.
```

Em P/L, `w_ik=x_ik`; em D, `w_ik=C`. As únicas misturas cross-branch são L/D
em `(Y,r)=(ell,A)` quando `nu=0`, e P/D em `(Y,r)=(h,B)` quando
`nu>nu_star`, sempre condicionadas à existência de D. Todo suporte mantém o
mesmo vetor de H.

As parcelas internas ao assessment satisfazem `rho_L+rho_P+rho_D=1`. Em
`nu=0`, com médias condicionais `bar_Y_L` e `bar_Y_P`,

```text
H0 = rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell
H1 = (rho_L+rho_D)*h+rho_P*bar_Y_P.
```

Em prior positivo baixo,

```text
H0 = rho_P*bar_Y_P+rho_D*ell
H1 = rho_P*bar_Y_P+rho_D*h.
```

Na região alta, ambos recebem `rho_P*bar_Y_P+rho_D*h`. Passagem com H tem
massa `rho_L+rho_P` em `nu=0` e `rho_P` fora dali; delay tem massa `rho_D`;
passagem sem H e falha terminal em R1 têm massa zero.

## 9. P0 e P3--P7

- P0: folga pode sobreviver; preencher folga muda a proposta e suas respostas.
- P3: P/L/D são exaustivos; as famílias excluídas têm certificado.
- P4: ações weak on-path são type-independent; informação adicional pode vir
  apenas do voto público de H.
- P5: N2 terminal e reconhecimento iid tornam o posterior suficiente.
- P6: todos os vetores entram; stage-undominance antecede `T^Y`.
- P7: o voto de H integra a história pública e toda atualização relevante.

## 10. Interface preservada e certificação integral

As seis células continuam separando `m=2`/`m>=3` e
`nu=0`/`0<nu<=nu_star`/`nu_star<nu<=1`. Cada registro usa somente os campos de
`equilibrium_correspondence_v1` e preserva a estrutura pública e a forma de
representação legível da v3. O reparo não cria uma DSL normativa, um companion
necessário ao consumo nem uma mudança silenciosa da interface.

O validador independente:

1. recebe apenas os objetos já lidos pelo verifier e não lê ou executa o
   builder;
2. consome integralmente fórmulas, predicados, sentenças controladas e claims
   com gramática restrita, sem aceitar texto residual;
3. reduz a AST ou regra semântica resultante a normal form e a compara às
   condições derivadas independentemente;
4. certifica cada folha exatamente uma vez e rejeita qualquer folha sem regra;
5. rejeita autonegação, mudança algébrica e polinômio extra mesmo que ele zere
   em todo grid de fixtures;
6. valida IDs, hashes, fontes, lifecycle e topologia como estrutura, separando
   essa tarefa da álgebra;
7. reporta com precisão que o guard estático demonstra apenas ausência de
   importação/runtime I/O do builder, não independência autoral absoluta.

Pins de bytes, manifests e duas builds subprocessuais permanecem como controles
de identidade e reprodutibilidade, mas nenhum deles produz o PASS sem o normal
form semântico integral.

## 11. Fixture de fronteira

Com `m=3,beta=.9,o0=.2,o1=.6,y_bar=.8,nu=.75`, tem-se
`nu_star=.5,A=.24,B=.12`. O assessment on-path com
`(Y,x1,x2,r)=(.10,.30,.30,.30)`, H0=H1=`yes` e dois vetos weak é rejeitado
porque `.30>B`. Com `x1=x2=B`, a construção da Seção 4 é aceita. O oracle
também preserva as três fixtures v3: multi-veto off-path que paga B, o veto
weak de `m=2` em `x=A`, e a rejeição de H-veto high-prior com `x<B`.

## 12. Lifecycle e fronteira

O candidato v4 permanece `pending/unfrozen`. Nenhum resultado seleciona
equilíbrio, identidade, pacote, crença ou distribuição. N3, v3, os pareceres,
N1/N2, contrato, DAG, N6/N7, PDFs e manuscritos permanecem intocados. Um novo
hash de N4 requer exatamente dois novos pareceres independentes read-only no
mesmo hash antes de qualquer freeze ou consumo.
