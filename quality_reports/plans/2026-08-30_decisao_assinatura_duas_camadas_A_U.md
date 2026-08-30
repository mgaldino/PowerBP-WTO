# Decisão autoral — arquitetura de assinatura em duas camadas para `A_U`

**Data:** 2026-08-30

**Status:** `APPROVED`

**Aprovação autoral:** concedida pela instrução “estenda a arquitetura em duas
camadas a \(A_U\)”.

**Objeto:** resolver o finding adjudicado `R2-I-1` sem alterar a correspondência
estratégica de `A_U` já reconstruída sob M/S/B.

## 1. Insumos e precedência

Esta decisão lê conjuntamente:

| Objeto | SHA-256 |
|---|---|
| clarificação geral de assinatura/anonimato | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| decisão em duas camadas de `A_M` | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| candidato estratégico de `A_U` adjudicado | `fefe77fe0dcd86941ed41ed5cd13ff22323ffb2e12221db5e2d91604de7774fc` |
| adjudicação da rodada 1 | `460780c0f694969f2f1566cbc913d797d8c25e6e2e48f47a047c89fddceb749b` |

Esta decisão é específica para `A_U`. Ela estende a solução arquitetural de
`A_M`, mas exige definições e provas próprias para unanimidade. Não reabre
thresholds, payoffs, Bayes, famílias de PBE, endpoints ou existência/exaustão
no nível dos assessments.

## 2. Decisão 1 — camada formal exata

Para cada binder completo `R` de `A_U`, construa, por tipo, a lei conjunta do
registro realizado enriquecido:

```text
Gamma_theta^{U,R}=Law_theta(y,mu(y),pass/reject,xi_U,omega_T),
```

onde `xi_U` registra a célula literal de `C_U` (`L` ou `P`) e `omega_T`
registra a alocação imediata ou o outcome terminal literal da continuação. O
binder completo — estratégias, crenças, votos e seleção markoviana — continua
a ser a fonte que gera essa lei e não pode ser recombinado em marginais.

Com `G=S_m` agindo por uma única permutação comum dos Estados fracos e

```text
x_U(R)=(Gamma_0^{U,R},Gamma_1^{U,R}),
Lambda_x=|G|^{-1} sum_g delta_(g.x),
```

a assinatura formal exata será

```text
Sig_ex_U(R)=(rho(R),nu_off(R),Lambda_(x_U(R)))
```

no prior interior. `rho` é apenas a coordenada equivalente a `nu_off` sob o
homeomorfismo já usado em `A_M`; não acrescenta uma nova crença. Nos endpoints,
`rho` é substituído por `*` e `nu_off=nu`.

O implementador deve provar para o espaço próprio de `A_U` que `Lambda` é
Borel, invariante e completo para a órbita diagonal. Igualdade de
`Sig_ex_U` significa uma única permutação comum aplicada ao par inteiro de
leis realizadas. Misturas com pesos diferentes sobre relabelings podem ser
distintas nesta camada.

“Exata” qualifica a identidade da assinatura enriquecida aprovada, não uma
alegação de que a lei realizada codifique toda função off-path do assessment.
As funções off-path permanecem no binder subjacente e são consumidas sempre que
a operação futura depender delas.

## 3. Decisão 2 — resumo econômico anônimo

Seja `q_U:Z_U -> Z_U/G` o quociente registro a registro. O resumo será

```text
Sum_econ_U(R)
 =(rho(R),nu_off(R),(q_U)#Gamma_0^{U,R},(q_U)#Gamma_1^{U,R}).
```

Esse resumo apaga nomes dentro de cada registro realizado e é
deliberadamente muitos-para-um. Ele preserva, por tipo, as estatísticas Borel
invariantes necessárias à comparação econômica: payoff de `H`, acordo/atraso,
lei do posterior, célula e outcome anônimos da continuação, alocação terminal
anônima e multiconjunto/lei dos payoffs fracos.

Misturas que apenas redistribuem massa entre relabelings e não alteram Bayes ou
o outcome anônimo podem ter o mesmo `Sum_econ_U` e `Sig_ex_U` distintos. Se a
mistura altera razões de verossimilhança e posteriores, muda também o resumo.

## 4. Decisão 3 — Reynolds e representante

O operador de Reynolds componentwise fica rebaixado a estatística marginal. Ele
não é invariante completo da órbita diagonal, não preserva necessariamente a
relação entre os planos dos tipos, pode não ser a imagem de um assessment e
jamais é chamado de representante de PBE.

Quando a exposição exigir um representante formal, usar um membro real da
órbita escolhido por mínimo Borel numa órbita finita, com a órbita registrada
por `Lambda`. Não impor simetria comportamental à proposta corrente de `H`.

## 5. Decisão 4 — consumo downstream

`AC` deve primeiro combinar `A_M` e `A_U` na mesma fibra de prior e
`(rho,nu_off)`, usando as camadas exatas. Uma operação futura só pode substituir
`Sig_ex` por `Sum_econ` depois de provar constância nas fibras do resumo e sua
própria fatorização mensurável; para correspondências, a prova precisa ser
setwise e não pode recombinar coordenadas de assessments diferentes.

Suportes estratégicos, coincidência de mensagens, mapa público de posterior,
Bayes, crenças, relação entre planos dos tipos, contagem de classes e qualquer
operação sensível a funções off-path usam a camada exata e, quando necessário,
o binder completo subjacente.

Esta decisão não autoriza iniciar `AC`, `AR`, alterar o manuscrito, criar tag,
fazer merge ou push.

## 6. Processo e gate

1. Implementar a arquitetura em novos bytes, preservando a matemática
   estratégica do candidato adjudicado.
2. Atualizar contrato, resultados, interface, ledger, verificador, manifesto e
   status administrativo de forma coerente.
3. Obter dois pareceres formais independentes sobre os mesmos hashes.
4. Adjudicar os pareceres.
5. Somente depois de dois passes e aprovação autoral terminal, congelar `A_U`.

Qualquer mudança nos resultados estratégicos durante a implementação reabre a
revisão completa; não pode ser tratada como consequência automática desta
decisão de interface.
