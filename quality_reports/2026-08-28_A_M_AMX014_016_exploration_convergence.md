# Convergência das explorações independentes sobre AMX-014--016

**Data:** 2026-08-28  
**Natureza:** registro exploratório, somente leitura; não é parecer nem
adjudicação. Nenhum dos três exploradores editou arquivos e nenhum resultado
abaixo recebe estatuto de `PASS` ou `freeze`.

## Escopo e bytes observados

Os três exploradores trabalharam sob o mesmo contrato e a mesma decisão
econômica. Os hashes governantes confirmados foram:

| Artefato | SHA-256 |
|---|---|
| contrato simplificado | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| `C_M` congelado | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| decisão do conceito de solução | `9189299798a65cad1408e68888e60907474e96bb66c700d8ca3b3329aa326f4f` |
| emenda autoral/técnica de 28/08 | `e841b9d3e56864fec29742a79ebfd1b963519ef65ddfa3882508a802fa94a935` |

O snapshot da derivação e do ledger consultado antes deste registro tinha,
respectivamente, os hashes `6ec9a1d3d1b2c43613fda77773ea6f7b00105682e73c9e9035d53643658d0f97`
e `7a1ce1af8ef25ecabc6ade5bfa139aea46c8f237da75f9e18127b4b73bbe0119`. Os
exploradores também tinham ciência da revisão fria histórica
`e6c24e06a73e70f87167606fb7383de3e7d474131dff4dbd22cebae9a09e6063`, mas não a
usaram como atalho e não estenderam sua cobertura aos bytes novos.

## Relatos independentes

### `pure_correspondence` (Poincaré)

O explorador derivou a redução local com

```text
rho_j^+(s)=max_{a_-j pivotal} beta*C^I_{M,j}(kappa(s,(0,a_-j),mu(s)))
rho_j^-(s)=min_{a_-j pivotal} beta*C^I_{M,j}(kappa(s,(0,a_-j),mu(s))).
```

Voto `sim` é admissível quando a oferta cobre `rho_j^+`; voto `não` é
admissível quando fica abaixo de `rho_j^-`; no intervalo intermediário não há
voto puro. Para uma seleção pura, o objetivo de `H` é `g_theta(s)`, com
acordo igual a `z_H` e rejeição igual a uma continuação de `C_M` descontada.
Uma medida é melhor resposta somente se estiver concentrada no `argmax` de
`g_theta`.

Foi reconstruído um seletor Borel que alterna membros literais de `C_M` e
produz uma sequência de propostas cujo supremo de payoff é aproximado, mas não
atingido. A mesma análise mostrou que conjuntos Borel arbitrários podem
codificar pooling e misturas atômicas ou não atômicas, e que os invariantes
`V_H^1>=V_H^0` e “acordo do alto com probabilidade positiva implica payoff
diagonal” sobrevivem. A recomendação foi manter AMX-014--016 bloqueados.

### `fixed_point_obstacle` (Kuhn)

O explorador explicitou dois membros literais `A^ell` e `A^h_b`, provenientes
de loterias sobre coalizões válidas, com matrizes de incidência `F^ell` e
`F_b^h`. Para qualquer Borel `A\subseteq Y`, o seletor pode usar `A^ell` em
`A` e `A^h_b` fora de `A`, com completamento literal dos perfis não pivotais.
Portanto a liberdade de `kappa_M` já permite codificar qualquer conjunto Borel
sem impor simetria.

Na instância

```text
N=5, m=4, k=2, beta=.9, o_0=.30, o_1=.40,
```

somente `E` existe. Para
`A_seq={s_n:n>=1}`, com
`s_n=(51/100-1/(100*n),6/25,6/25,0,0)`, a construção diagonal fornece
`g_theta(s)<=193/400` fora de `A_seq` e `g_theta(s_n)<51/100` com
`g_theta(s_n)->51/100`; o ponto-limite não pertence a `A_seq`. As rejeições em `E` dão
`27/100` e `36/100` aos tipos baixo e alto. Assim o objetivo Borel não é USC e
não tem máximo. Para qualquer probabilidade `sigma`,
`integral g_theta d sigma <51/100`, e algum `s_n` melhora a média; não há
melhor resposta pura ou mista para esse seletor admissível.

O explorador também registrou razões de Bayes locais que podem oscilar sem
limite e famílias de pooling/semipooling indexadas por Borel arbitrário. A
conclusão foi um certificado de falha de existência para um seletor admissível,
não uma afirmação de inexistência do jogo inteiro.

### `mixed_correspondence` (Euler)

O explorador parametrizou misturas por

```text
lambda=(1-nu)*sigma_0+nu*sigma_1,
sigma_1(ds)=pi(s)/nu d lambda(s),
sigma_0(ds)=(1-pi(s))/(1-nu) d lambda(s),
integral pi d lambda=nu,
```

e destacou que a igualdade integral não substitui a regra local de Bayes em
cada ponto disciplinado. A parametrização inclui átomos, medidas singulares e
partes não atômicas; nos endpoints o suporte do prior fixa `pi` em `0` ou `1`.

Foi dado o exemplo atomless `N=5,m=4,k=2,beta=.9,o_0=.7,o_1=.8,nu=.5`, com
continuação `E` cíclica, `lambda` uniforme e `pi(t)=.25+.5t`. As densidades
`sigma_1(dt)=(.5+t)dt` e `sigma_0(dt)=(1.5-t)dt` satisfazem Bayes local e
produzem um PBE semipooling atomless com payoffs `.63` e `.72`; a checagem
numérica independente retornou `PASS` para essa identidade, sem pretensão de
provar a classificação geral.

O mesmo explorador confirmou o contraexemplo de não atingimento: compactação
de `Y` e Borelidade de `kappa_M` não asseguram semicontinuidade ou existência de
`argmax`.

## Conclusão confrontada

Os três caminhos chegaram independentemente aos mesmos pontos:

1. a redução indexada por `kappa_M`, seleção pivotal, Bayes local e medidas é
   necessária e suficiente apenas condicionalmente a esses objetos;
2. essa redução é funcional e não constitui a enumeração informativa exigida
   para AMX-014--016;
3. um seletor Borel admissível pode eliminar melhor resposta pura e mista,
   portanto não há existência uniforme sobre todos os seletores permitidos;
4. misturas e semipooling podem variar sobre dados Borel, átomos e partes não
   atômicas, impedindo uma lista finita de casos;
5. o conjunto conjunto de payoffs pode depender de seletores descontínuos, não
   ser fechado e não ter envelope atingível.

**Estatuto recomendado:** AMX-014, AMX-015 e AMX-016 permanecem
`BLOCKED — NO INFORMATIVE COMPLETION UNDER CURRENT CONTRACT`. O certificado
negativo deve ser preservado junto à derivação, sem escolher uma hipótese nova.
Fechar a classificação exigiria decisão autoral para restringir
`kappa_M`/seleção, impor regularidade suficiente para atingir máximos,
restringir suportes ou aceitar `epsilon`-equilíbrios. Nenhuma dessas
alternativas foi escolhida.
