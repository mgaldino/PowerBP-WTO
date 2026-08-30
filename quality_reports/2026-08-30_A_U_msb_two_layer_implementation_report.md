# Relatório de implementação — arquitetura em duas camadas de `A_U`

**Data:** 2026-08-30

**Status:** `IMPLEMENTER CANDIDATE COMPLETE — TWO NEW FORMAL REVIEWS PENDING`

**Natureza:** registro de implementação e rastreabilidade. Não é parecer formal,
não aprova os novos bytes e não substitui as duas revisões independentes.

## 1. Resultado

A instrução autoral “estenda a arquitetura em duas camadas a \(A_U\)” foi
registrada em decisão específica e implementada no commit substantivo
`b56085c436eb629c335764eb982d174e5cc2d392`.

O finding adjudicado `R2-I-1` foi enfrentado sem mudar a solução estratégica de
`A_U`. Permanecem iguais o consumo de `C_U`, a aplicação única de `beta`, o
domínio de crenças, os preços de voto, os argumentos de imitação, as famílias
`AU-MSB-L/H0/HB`, os endpoints, os payoffs e as condições de existência e
exaustão. Mudaram apenas identidade formal e regra de consumo downstream.

## 2. As duas camadas

Para o par de leis enriquecidas realizadas por tipo,
`x_U=(Gamma_0^U,Gamma_1^U)`, a camada formal é

```text
Sig_ex_U=(rho,nu_off,Lambda_x),
Lambda_x=|S_m|^{-1} sum_g delta_(g.x).
```

`Lambda_x` é Borel, invariante e completo para a órbita diagonal: duas
assinaturas formais são iguais exatamente quando uma única permutação comum
dos Estados fracos transforma o par inteiro de leis. Um representante
expositivo é um membro real da órbita escolhido por mínimo Borel; não é uma
média.

A camada econômica é

```text
Sum_econ_U=(rho,nu_off,(q_U)#Gamma_0^U,(q_U)#Gamma_1^U).
```

Ela apaga nomes dentro de cada registro realizado e preserva estatísticas
anônimas: payoff de `H`, acordo/atraso, lei do posterior, célula e outcome
terminal anônimos, e a distribuição anônima dos payoffs fracos. Ela não guarda
propostas ou payoffs nomeados, suporte estratégico, o mapa público pointwise,
coincidência de mensagens, relação entre planos contrafactuais ou funções
off-path.

## 3. Fechamento do finding `R2-I-1`

O exemplo `P/Q` da adjudicação foi incorporado como teste permanente. No
fixture `N=3`, `beta=.9`, `o_0=.2`, `o_1=.5`, `nu=.6`, `V=.45`, pooling comum
em

```text
P=(.45,.3025,.2475),
Q=(.45,.2475,.3025)
```

e qualquer mistura comum dos dois são PBEs. Pesos `(.9,.1)` e `(.5,.5)` não
estão na mesma órbita diagonal, mas têm o mesmo resumo econômico porque
`q_U(P)=q_U(Q)` e Bayes continua em `.6`. Assim, “classe formal” e “mesma
consequência econômica anônima” deixam de ser confundidas.

Quando os tipos usam pesos diferentes sobre mensagens comuns, as razões de
verossimilhança e os posteriores mudam. A lei do posterior permanece dentro do
resumo; por isso a camada econômica também distingue experiências com conteúdo
informacional diferente.

## 4. Reynolds

O operador componentwise de Reynolds foi rebaixado a estatística marginal. Ele
não é completo para a órbita diagonal, pode apagar a relação entre os planos
dos tipos, pode não ser gerado por um único assessment e nunca é representante
de PBE.

O certificado de não realizabilidade usa o mesmo `P/Q`, prior `.9` e pesos por
tipo `(.9,.1)` e `(.1,.9)`. Bayes dá posteriores `.5` e `81/82`, ambos na
célula alta. Reynolds leva os dois rótulos de posterior à mesma proposta
física; nenhum mapa público determinístico pode fazer isso.

## 5. Binder e consumo futuro

“Exata” descreve a assinatura enriquecida aprovada, não recuperação de toda
função off-path. O binder completo continua sendo a fonte indivisível do
assessment e permanece obrigatório quando uma operação depender de comportamento
fora do caminho.

`AC` deve primeiro combinar `A_M` e `A_U` na mesma fibra de prior e
`(rho,nu_off)`, usando as camadas exatas. Só pode substituir uma camada exata
pelo resumo depois de provar constância na fibra e fatorização mensurável para
a operação específica; no caso de correspondências, a prova deve ser setwise.
Este passe não inicia nem autoriza `AC`, `AR`, manuscrito, tag, merge ou push.

## 6. Evidência mecânica e limite

O verificador retornou:

```text
MECHANICAL RESULT: PASS | 1110 PASS | 0 FAIL
```

As novas regressões checam a aritmética `P/Q`, a distinção entre pesos de
órbita, a identidade do resumo, os dois posteriores do certificado de Reynolds
e a presença dos gates na interface. O código não prova completude de PBE,
ausência de todos os desvios contínuos, Bayes local pointwise geral,
Borelidade/completude abstratas nem fatorização downstream.

## 7. Próximo gate

O candidato permanece `pending/unfrozen`. Dois pareceristas independentes devem
reconstruir as provas sobre exatamente os bytes do manifesto do candidato;
depois, os pareceres serão adjudicados. Mesmo se ambos passarem, o congelamento
exige aprovação autoral terminal dos bytes revisados.
