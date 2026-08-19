# N4 Round 6 — classificação dos findings antes do reparo

**Interface revisada:** `sha256:b9c28789fc2e69b8cbea696a5d743908907bb8d15dc34549ce8264481400941d`  
**Revisor:** `formal_design`, `review-n4-formal-2026-08-19-r6`  
**Veredicto:** FAIL; `critical=0`, `major=1`, `minor=1`

## Finding 1 — texto original

> Major — `L2` e `L3` não são bounds exatos: falta uma resposta admissível após proposta nula na qual `H` separa quando já é não pivotal. O reparo específico da Round 5 funciona: em `m=2, beta=.9, o0=.2, o1=.6, nu=.8`, ambos os pacotes indicados têm `x<a0=.36`, e a rejeição fraca com continuação baixa paga `d=.072<=L2=.10`. Entretanto, no pacote-limiar, fixe crença de ballot `rho in (0,1)`, weak rejector(es) em `não`, `H0` em `não` e `H1` em `sim`; atribua posterior alto ao vetor de `H0`, posterior baixo ao vetor de `H1` e posterior alto após desvio unilateral do weak rejector. Então o weak obtém `(1-rho)z+rho*a0>z` votando não e `z` votando sim; `H0` obtém `beta*o1>beta*o0` votando não; e `H1` vota sim por `T^Y`. As ações fracas são stage-undominated, e o proponente recebe, sob o prior verdadeiro, apenas `(1-nu)z`.
>
> Para `m=2, beta=.9, o0=.2, o1=.6, nu=.2`, isso dá `.8*.18=.144<b2=.28=L2`. Um pooling omitido usa `(y,x,r)=(.54,.18,.20)`. As respostas já descritas cobrem propostas nulas com payoff máximo `.18`; no subcaso `y>=.54` e `.18<=x<.36`, a resposta acima paga `.144`, enquanto `x>=.36` força no máximo `.10`. Logo `.20` é estritamente ótimo, sem empate de proposta, mas a interface exige `R>=L2=.28`.
>
> Para `m=3` nos mesmos parâmetros, `a0=.24`, `z=.12`, `d=L3=.192` e `p=.22`. Com dois weak rejectors, a mesma construção é válida após qualquer proposta nula e paga `(1-nu)z=.096`. Assim, `(y,x1,x2,r)=(.54,.12,.12,.15)` é pooling estritamente ótimo, mas é excluído pela exigência `R>d=.192`. Portanto, as seis células qualitativas podem permanecer, porém as faixas de suporte, fronteiras e correspondência exaustiva estão incompletas. O verificador não enumera essa separação off-path de `H`.

### Classificação

**Técnico, pelo teste de reparo único.** O contrato já fixa que todo vetor
completo após proposta de probabilidade zero pode ter crença explícita sem
restrição de Bayes, e já fixa payoffs, ações, informação e `T^Y`. A resposta do
finding atinge o mínimo tipo a tipo permitido pela interface N2: `z` para o
tipo baixo e zero para o tipo alto. Portanto existe um único reparo:

```text
m=2: L2=max{k2,min{z,(1-nu)q2}];
m>=3: L3=(1-nu)z;
```

As faixas aceitas devem ser ampliadas exatamente para esses bounds, e o kernel
off-path deve registrar a separação não pivotal. Não há escolha de primitiva,
crença on-path ou seleção adicional.

## Finding 2 — texto original

> Minor — a derivação afirma que, no ramo low-N2 de atraso por rejeição de `H` com `m=2`, o voto weak `sim` não exige bound em `x`. Isso é falso em `nu=nu2`, embora a interface trate corretamente a igualdade. Com `beta=.9, o0=.2, o1=.6, nu=nu2=.5`, tem-se `d=g=z=.18`. Se `x=.10`, contra `H=sim`, votar não dá continuação de pelo menos `.18` enquanto sim paga `.10`; contra `H=não`, não dá pelo menos `.18` e sim dá exatamente `.18` on-path. Portanto não fracamente domina sim, violando stage-undominance. Na igualdade é necessário `x>=z`.

### Classificação

**Técnico.** A interface já continha a fronteira correta; o único reparo é
trocar na derivação `nu>nu_2`/“low region” por `nu>=nu_2` e `nu<nu_2`,
respectivamente. Nenhum resultado ou ação muda.
