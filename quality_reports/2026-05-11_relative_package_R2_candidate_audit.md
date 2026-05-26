# Auditoria do Candidato R2 sob Pacotes Relativos

Data: 2026-05-11  
Agente: A, auditor do candidato R2  
Escopo exclusivo: seção R2 recém-escrita em `model_redesign/power_architecture_derivations.Rmd`  
Status geral: PENDING

## Q&A

**A seção R2 pode ser tratada como prova fechada?**  
Não. Ela contém uma derivação algébrica promissora, mas depende de pelo menos duas decisões de protocolo que ainda não estão plenamente declaradas: aceitação de weak voters em caso de indiferença e seleção no empate entre pacote low-only e pacote pooling.

**A arquitetura antiga de feasibility/C-B-R foi usada nesta auditoria?**  
Não. A auditoria parte apenas dos primitivos da arquitetura de pacotes relativos: `y` é factível em todos os estados, custa um-por-um para a coalizão fraca, e o screening vem de thresholds de participação de `H`.

**Há uma versão mínima corrigida da derivação?**  
Sim, mas ela deve ser marcada como resultado condicional. A álgebra de R2 passa sob condições explícitas. O status correto é algo como: "conditional derivation; pending protocol decisions", não "proved".

**Qual é a meta de longo prazo afetada por esta auditoria?**  
Fechar R2 de modo suficientemente limpo para que R1 possa usar continuations sem importar seleção ad hoc, tie-breaking escondido ou opções estratégicas não declaradas.

## Materiais lidos

- `AGENTS.md`
- `model_redesign/README.md`
- `model_redesign/power_architecture_derivations.Rmd`
- `quality_reports/2026-05-11_relative_package_reimplementation.md`

Não auditei scripts nem editei arquivos de derivação. Este relatório não mexe em `formal_model_v5.Rmd`, `model_redesign/power_architecture_derivations.Rmd` ou `scripts/`.

## Primitivos e protocolo declarados

O candidato R2 trabalha com estes objetos:

```text
theta in {0,1}
V(0) = 1
V(1) = r, com r > 1
Ve(mu) = 1 + mu * (r - 1)
m = N - 1
pi_H = 0
y in [0, ybar]
U_H(y, theta) = y + b_H(theta)
weak coalition surplus after accepted y = V(theta) - y
```

No Round 2 terminal, o candidato define:

```text
d_theta = d_H(theta)
b_theta = b_H(theta)
tau_theta = d_theta - b_theta
```

e usa a regra:

```text
H accepts y in state theta iff y + b_theta >= d_theta
```

Logo:

```text
H accepts iff y >= tau_theta
```

O caso limpo assume:

```text
0 <= tau0 < tau1 <= ybar
tau0 <= 1
tau1 <= r
```

Essas condições são suficientes para tornar disponíveis os pacotes relevantes e evitar que no-agreement seja estritamente melhor que todo pacote aceito.

## Auditoria do timing

O timing terminal de R2 está suficientemente declarado para uma derivação condicional:

1. A natureza já sorteou `theta`.
2. `H` conhece `theta`; weak states têm crença `mu`.
3. Um weak state é reconhecido como proposer, pois `pi_H = 0`.
4. O proposer escolhe `y`.
5. Sob unanimity, `H` precisa aceitar para haver acordo.
6. Em R2, se não houver acordo, o jogo termina.
7. `H` recebe `d_H(theta)` após rejeição terminal.
8. Weak states recebem payoff terminal normalizado para zero após rejeição terminal.

O timing é coerente para R2. O problema não está no timing básico, mas em detalhes de votação e seleção.

Veredito: PASS, como protocolo terminal condicional.

## Ações disponíveis

A ação primitiva declarada é:

```text
y in [0, ybar]
```

Sob `0 <= tau0 < tau1 <= ybar`, existem três regiões de ação:

```text
y < tau0          -> ambos os tipos de H rejeitam, se tal y existir
tau0 <= y < tau1  -> low H aceita, high H rejeita
y >= tau1         -> ambos os tipos aceitam
```

Como o payoff fraco cai um-por-um em `y`, dentro de cada região o proposer escolhe o menor `y` que implementa aquela região:

```text
pooling:  y = tau1
low-only: y = tau0
both reject: qualquer y < tau0, quando disponível
```

Essa redução do menu é válida sob monotonicidade e threshold ordering. Ela não usa feasibility state-contingent.

Problema residual: se `tau0 = 0`, não existe `y < tau0` dentro de `[0, ybar]`. Então no-agreement precisa ser uma ação separada se for usado explicitamente. No caso regular, isso não altera o payoff máximo porque low-only gera payoff não negativo, mas altera a interpretação da terceira opção.

Veredito: PASS para a redução a `tau0` e `tau1`; PENDING para no-agreement como ação separada.

## Payoff terminal de H

O candidato define corretamente:

```text
tau_theta = d_theta - b_theta
```

e:

```text
H accepts y iff y >= tau_theta
```

Com `y = tau1`, ambos os tipos aceitam. High H recebe exatamente:

```text
tau1 + b1 = d1
```

Low H recebe:

```text
tau1 + b0 = d0 + (tau1 - tau0)
```

Com `y = tau0`, low H aceita e recebe:

```text
tau0 + b0 = d0
```

High H rejeita e recebe:

```text
d1
```

Logo, fora dos empates de seleção do proposer, high H sempre recebe `d1`, e low H recebe `d0` no low-only e `d0 + tau1 - tau0` no pooling.

Veredito: PASS, condicionado à regra declarada de que H aceita no empate.

## Custo de y para weak states

O candidato usa o primitivo:

```text
weak coalition surplus = V(theta) - y
```

Esse primitivo está declarado no documento e é coerente com a arquitetura de pacotes relativos. Ele deve ser tratado como normalização reduzida, não como resultado derivado de microfundamento de quotas.

Veredito: PASS como primitivo adotado; não é uma prova independente.

## Proposer versus representative weak state

Em R2, o candidato toma o payoff de continuação dos weak voters como zero. Assim, se o pacote é aceito, o recognized proposer recebe:

```text
V(theta) - y
```

e os non-proposing weak voters recebem:

```text
0
```

Como cada weak state é reconhecido com probabilidade `1/m`, o valor de um weak state representativo é:

```text
W2_U(mu) = proposer_value(mu) / m
```

Isso está correto se duas condições forem explicitadas:

1. weak voters aceitam ofertas iguais ao valor de continuação;
2. o proposer maximiza payoff esperado dado `mu`.

A segunda condição é padrão e está praticamente implícita no uso de `Ve(mu)`. A primeira é uma regra de votação/tie-breaking. Ela não deve ficar implícita.

Se weak voters exigem melhora estrita, as fórmulas exatas viram supremos: o proposer paga `epsilon` aos weak voters e o payoff se aproxima dos valores escritos, mas pode não atingir o máximo. Para manter as fórmulas como máximos, o protocolo precisa declarar aceitação fraca em caso de indiferença.

Veredito: PENDING até declarar a regra de aceitação dos weak voters em empate.

## Opção de não-proposta ou rejeição

O candidato inclui:

```text
R2(mu) = 0
```

como payoff de no-agreement.

Sob as condições:

```text
0 <= tau0 <= 1
tau1 <= r
```

essa opção não é estritamente necessária para o valor de weak states, porque:

```text
low-only payoff = (1 - mu) * (1 - tau0) >= 0
pooling payoff = Ve(mu) - tau1, que é >= 0 em mu = 1 e pode ser negativo em mu baixo
```

Assim, pelo menos low-only garante payoff não negativo para todo `mu`, e no-agreement nunca é estritamente melhor do que todas as opções aceitas.

Mas a opção de no-agreement não está completamente limpa como ação. Se `tau0 > 0`, qualquer `y < tau0` induz rejeição de ambos os tipos. Se `tau0 = 0`, não há pacote `y < tau0`, então no-agreement só existe se o protocolo permitir "não propor" ou uma ação equivalente.

Conclusão: incluir `0` no max é inofensivo para o payoff no caso regular, mas não deve ser usado para provar resultados em fronteiras ou fora da regularidade sem declarar a ação de no-proposal.

Veredito: PENDING como ação primitiva; PASS como termo inofensivo no max sob regularidade.

## Atualização de crenças

Em R2 terminal, atualizações após aceitação ou rejeição não afetam payoffs futuros, porque não há próxima rodada. Logo, o cálculo do payoff esperado do proposer usa apenas a crença anterior `mu`.

Isso é suficiente para R2.

Para R1, porém, o objeto relevante será `C_H(theta, mu')`, onde `mu'` é o posterior após rejeição em R1. A seção candidata não deriva o processo de geração de `mu'`; ela apenas prepara o continuation value de R2 como função de uma crença. Isso é aceitável, mas R1 não pode usar um posterior específico sem uma derivação bayesiana posterior.

Veredito: PASS para R2 terminal; PENDING para uso em R1.

## Derivação algébrica clean-room

Sob os primitivos e condições acima, os dois pacotes aceitos relevantes têm payoffs de proposer:

```text
Pooling:
P2(mu) = (1 - mu) * (1 - tau1) + mu * (r - tau1)
       = Ve(mu) - tau1

Low-only:
L2(mu) = (1 - mu) * (1 - tau0) + mu * 0
       = (1 - mu) * (1 - tau0)
```

Se no-agreement está disponível:

```text
Z2(mu) = 0
```

Então o valor de proposer é:

```text
Prop2_U(mu) = max{P2(mu), L2(mu), Z2(mu)}
```

e o valor representativo é:

```text
W2_U(mu) = Prop2_U(mu) / m
```

Sob `0 <= tau0 <= 1` e `tau1 <= r`, o termo `Z2(mu)` nunca é estritamente maior que os dois pacotes aceitos em conjunto. Portanto, no caso regular:

```text
W2_U(mu) = (1/m) * max{Ve(mu) - tau1, (1 - mu) * (1 - tau0)}
```

com a ressalva de que manter `max{..., 0}` é aceitável apenas se ele for entendido como notação redundante no caso regular, não como prova de que no-proposal é uma ação declarada.

O cutoff entre pooling e low-only é obtido de:

```text
Ve(mu) - tau1 = (1 - mu) * (1 - tau0)
```

Logo:

```text
mu2_star = (tau1 - tau0) / (r - tau0)
```

Como `0 <= tau0 < tau1 <= r`, temos:

```text
0 < mu2_star <= 1
```

Se `tau1 < r`, então `mu2_star < 1`. Se `tau1 = r`, então `mu2_star = 1`.

A direção da escolha é:

```text
mu < mu2_star  -> low-only é estritamente melhor que pooling
mu > mu2_star  -> pooling é estritamente melhor que low-only
mu = mu2_star  -> proposer é indiferente
```

Essa álgebra passa.

Veredito: PASS para a álgebra condicional.

## Continuation values de H

Com seleção única fora do cutoff:

```text
C_H2_U(1, mu) = d1
```

para todo `mu`, porque high H recebe `d1` tanto quando aceita o pacote pooling quanto quando rejeita o pacote low-only.

Para low H:

```text
if mu < mu2_star:
  C_H2_U(0, mu) = d0

if mu > mu2_star:
  C_H2_U(0, mu) = d0 + tau1 - tau0
```

No ponto:

```text
mu = mu2_star
```

o proposer está indiferente entre pooling e low-only. Sem uma regra de seleção, o continuation value de low H é uma correspondência:

```text
C_H2_U(0, mu2_star) in [d0, d0 + tau1 - tau0]
```

Isso está corretamente reconhecido pelo candidato. O problema é que, apesar de reconhecer a correspondência, a seção ainda promove o resultado como "proved". O status correto permanece pendente para qualquer objeto de R1 que precise de valor único nesse ponto.

Veredito: PASS fora do cutoff; PENDING no cutoff e para uso em R1.

## Pontos que devem ser rebaixados para pending protocol decision

1. **Aceitação dos weak voters no empate.**  
   A derivação paga exatamente o continuation value aos non-proposing weak voters. Isso exige uma regra de aceitação fraca. Sem ela, os valores são supremos ou exigem pagamentos epsilon.

2. **No-proposal/no-agreement como ação.**  
   No caso regular, no-agreement não é necessário para o payoff máximo. Mas se o termo `0` for usado fora do caso regular, ou se `tau0 = 0`, o protocolo precisa declarar se o proposer pode não propor ou induzir rejeição de ambos.

3. **Seleção em `mu2_star`.**  
   A correspondência de low H é correta, mas qualquer teorema de R1 que precise de threshold único deve evitar o ponto ou declarar uma seleção.

4. **Status de prova.**  
   A linha "proved for the terminal Round-2 relative-package game" deve ser rebaixada. O resultado é uma derivação condicional com lacunas protocolares identificadas.

5. **Uso dos continuation values em R1.**  
   R1 ainda precisa derivar quais posteriors `mu'` são gerados após rejeição e como a seleção de R2 afeta thresholds. Nada disso deve ser importado automaticamente.

## Versão corrigida mínima

Uma versão mínima defensável da seção R2 seria:

```text
Candidate R2 result, conditional on protocol:

Assume:
1. pi_H = 0 in Round 2.
2. A weak proposer chooses y in [0, ybar].
3. H accepts iff y + b_theta >= d_theta.
4. tau_theta = d_theta - b_theta.
5. 0 <= tau0 < tau1 <= ybar.
6. tau0 <= 1 and tau1 <= r.
7. Weak voters accept offers equal to their terminal continuation value 0.
8. The proposer maximizes expected payoff under belief mu.

Then:
P2(mu) = Ve(mu) - tau1
L2(mu) = (1 - mu) * (1 - tau0)
W2_U(mu) = (1/m) * max{P2(mu), L2(mu)}

The cutoff is:
mu2_star = (tau1 - tau0) / (r - tau0)

Low-only is optimal for mu < mu2_star.
Pooling is optimal for mu > mu2_star.
At mu = mu2_star, both are optimal.

H continuation values:
C_H2_U(1, mu) = d1 for all mu.
C_H2_U(0, mu) = d0 for mu < mu2_star.
C_H2_U(0, mu) = d0 + tau1 - tau0 for mu > mu2_star.
C_H2_U(0, mu2_star) is set-valued between those two values.
```

If the protocol does not declare weak-voter acceptance at equality, replace exact payoff maxima with supremum statements or add epsilon payments to weak voters. If no-agreement is needed outside the regular case, declare no-proposal or verify that some `y` induces rejection by both types.

## Object-by-object verdict

| Object | Verdict | Reason |
|---|---|---|
| Relative-package action `y in [0, ybar]` | PASS | Declared primitive; no state-contingent feasibility used. |
| `U_H(y, theta) = y + b_H(theta)` | PASS | Declared primitive. |
| Terminal H disagreement payoff `d_H(theta)` | PASS | Declared for R2. |
| Threshold `tau_theta = d_theta - b_theta` | PASS | Follows directly from H acceptance rule. |
| Screening condition `tau0 < tau1` | PASS as assumption | It is assumed, not derived. |
| Availability of pooling package `y = tau1` | PASS | Requires `tau1 <= ybar`, which is assumed. |
| Availability of low-only package `y = tau0` | PASS | Requires `tau0 in [0, ybar]`, implied by assumptions. |
| Reduction to pooling and low-only packages | PASS | Follows from one-for-one cost and threshold monotonicity. |
| Weak coalition cost `V(theta) - y` | PASS as primitive | Adopted normalization, not independently proved. |
| Weak proposer residual payoff in R2 | PENDING | Exact value requires weak voters to accept continuation-value offers. |
| Representative weak value equals proposer value divided by `m` | PASS conditional | Valid if non-proposers receive zero and weak recognition is uniform. |
| No-agreement option `R2(mu) = 0` | PENDING | In regular case it is payoff-redundant, but as an action it is not fully declared. |
| `P2(mu) = Ve(mu) - tau1` | PASS | Correct algebra. |
| `L2(mu) = (1 - mu) * (1 - tau0)` | PASS | Correct algebra. |
| `W2_U(mu) = (1/m) * max{P2, L2, 0}` | PENDING | Correct under added protocol; should be written without relying on `0` in the regular case unless no-agreement is declared. |
| Cutoff `mu2_star = (tau1 - tau0)/(r - tau0)` | PASS | Correct algebra under assumptions. |
| Choice regions around `mu2_star` | PASS | Direction is correct. |
| `C_H2_U(1, mu) = d1` | PASS conditional | Holds for both low-only rejection and pooling acceptance. |
| `C_H2_U(0, mu)` off the cutoff | PASS conditional | Correct given proposer selection off the cutoff. |
| `C_H2_U(0, mu2_star)` as interval | PASS | Correctly treats selection at the cutoff as set-valued. |
| Unique low-type continuation at the cutoff | FAIL | Not available without a selection/tie-breaking primitive. |
| R1 thresholds using R2 continuation values | PENDING | R1 posterior and R2 selection are not yet closed. |
| Status line "proved" in the R2 section | FAIL | Should be downgraded to conditional derivation pending protocol decisions. |

## Bottom line

The R2 candidate is not wrong in its core algebra. The clean-room derivation confirms the payoff formulas, cutoff, and off-cutoff continuation values under the stated threshold ordering and regularity conditions. But it is not yet a closed proof. The missing pieces are protocol-level, not algebraic: weak-voter acceptance at equality, no-agreement as an action when used, and selection at `mu2_star`.

Recommended ledger status:

```text
R2 unanimity under relative packages:
PENDING.
Core algebra passes conditionally, but proof status requires explicit weak-voter tie-breaking and treatment of the cutoff selection.
```
