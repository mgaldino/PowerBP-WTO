# Arquitetura de poder com recognition probability `pi_H`

**Data:** 2026-05-10  
**Status:** nota de arquitetura para a próxima versão do paper. Não altera o corpo principal ainda.

**Workspace formal:** `model_redesign/power_architecture_derivations.Rmd`. As provas novas devem ser desenvolvidas nesse arquivo separado, não em `formal_model_v5.Rmd`.

## Q&A de escopo

**Qual é o puzzle substantivo em uma frase?**  
Por que uma potência hegemônica escolheria unanimidade/consenso se essa regra parece restringir seu poder formal?

**Qual mecanismo o paper quer isolar?**  
Unanimidade pode beneficiar `H` porque transforma sua posição de veto e sua informação privada sobre `theta`/outside option em uma restrição de screening enfrentada pelos weak states.

**Quais fontes de poder precisam ser separadas?**  
Três fontes distintas:

1. **Outside-option power:** `H` tem uma alternativa externa maior ou mais valiosa que a dos demais, representada por `d_H = alpha V(theta)` no modelo atual.
2. **Veto/pivotality power:** sob unanimidade, qualquer acordo precisa da aceitação de `H`.
3. **Proposal power:** `H` pode ou não controlar a agenda, representado pela probabilidade de reconhecimento `pi_H`.

**Qual é a tese mais limpa?**  
O mecanismo central exige principalmente outside option e veto/pivotality, não agenda-setting power. Portanto, o baseline deve retirar agenda power de `H` e perguntar se unanimidade ainda o favorece.

## Nova família de modelos

Introduzir uma probabilidade de reconhecimento:

```text
pi_H in [0,1]
pi_W = 1 - pi_H
Pr(each weak state is proposer) = (1 - pi_H)/(N-1)
Pr(each weak state is proposer | some weak state is proposer) = 1/(N-1)
```

Essa parametrização permite separar três casos.

## Caso 1: baseline de screening, `pi_H = 0`

Este é o modelo principal recomendado para a próxima versão.

```text
pi_H = 0
pi_W = 1
```

Interpretação: weak states, coalizões não-hegemônicas, comitês ou o processo institucional de negociação fazem propostas. `H` não controla a agenda; sua força vem da outside option e do veto sob unanimidade.

Resultado substantivo que o paper deve tentar provar em fórmula fechada:

```text
Unanimity can favor a powerful privately informed actor not because it gives him more agenda power, but because it transforms his veto/acceptance behavior into an informational constraint on weaker states.
```

Essa versão deve ser o novo Appendix A/B principal.

## Stress test: outside option igual à dos weak states

O paper também deve isolar quanto do screening vem do outside option forte. No modelo atual, `d_W = 0` é uma normalização; portanto, o caso extremo de outside option igual à dos weak states corresponde a:

```text
alpha = 0
```

Se a próxima versão permitir uma outside option comum positiva, o stress test deve ser escrito como `d_H = d_W` antes da normalização.

Pergunta substantiva:

```text
Does veto power plus private information still create screening rents when H does not have a stronger outside option?
```

Hipótese de trabalho: no terminal round, se `alpha = 0` e não houver outro continuation value type-dependent, a pressão de screening deve enfraquecer ou desaparecer. Isso precisa ser derivado, não assumido.

## Caso 2: agenda neutra BF, `pi_H = 1/N`

Este é o caso canônico de recognition probability simétrica:

```text
pi_H = 1/N
Pr(each weak state is proposer) = 1/N
```

Esse caso reintroduz o ramo em que `H` propõe. Como `H` é informado, esse ramo vira um jogo de sinalização. A resposta em `quality_reports/h_proposer_response_complete.md` indica que fora da região de accepted pooling o payoff não é uma função única; ele depende de seleção, mixing, tie-breaking e crenças off-path.

Recomendação: tratar esse caso como extensão curta. Usar lower bounds, upper bounds selection-free e simulações calibradas, sem fazer dele o resultado central.

## Caso 3: hegemonic agenda power, `pi_H > 1/N`

Este caso representa agenda power substantivo de `H`.

Ele deve ser conceitualmente separado do mecanismo principal:

```text
outside option + veto + private information  !=  proposal power
```

O objetivo da extensão não é resolver completamente todo o informed-proposer signaling game, mas mostrar como aumentar `pi_H` adiciona uma segunda fonte de poder. Quando o ramo `H`-proposer gerar correspondência de payoffs, apresentar bounds e resultados calibrados.

## Defesa contra a crítica de irrealismo

Formulação recomendada:

> The weak-agenda benchmark isolates the screening mechanism. Allowing the hegemon to propose adds an informed-proposer signaling problem. Because this branch generally yields a payoff correspondence rather than a unique payoff function, the extension is analyzed using selection-free bounds and, where useful, calibrated sufficient conditions.

Essa defesa é mais forte do que dizer que `H` nunca tem agenda power. O argumento é que agenda power é real, mas é uma fonte distinta de poder e deve ser adicionada depois de identificar o mecanismo de screening.

## Implicação para OPEC

O caso OPEC deve ser reescrito assim:

```text
H = Saudi Arabia
W = other OPEC members
theta = Saudi spare capacity / ability to discipline the cartel
V(theta) = value of a quota agreement
d_H(theta) = alpha V(theta)
pi_H = probability Saudi controls the proposal/agenda
```

No baseline, `pi_H = 0` não quer dizer que Saudi Arabia é politicamente irrelevante. Quer dizer que o paper está isolando o poder que vem de ser indispensável e informado, não o poder que vem de redigir a proposta.

Frase recomendada:

> Saudi Arabia's power in the benchmark comes from being indispensable to any credible quota agreement and privately informed about its outside option, not from being assumed to control the formal agenda.

## Próximos passos analíticos

1. Reespecificar Appendix A no workspace `model_redesign/power_architecture_derivations.Rmd`, com `pi_H` como primitivo, mas resolver primeiro o baseline `pi_H = 0`.
2. Derivar majority sob `pi_H = 0`: weak proposers excluem `H`; `H` recebe outside option externa.
3. Derivar unanimity sob `pi_H = 0`: weak proposers enfrentam o problema `A/C/R` com strict BF feasibility.
4. Derivar o stress test `alpha = 0` ou `d_H = d_W`.
5. Provar dominância condicional e nesting no baseline.
6. Só depois tratar `pi_H = 1/N` e `pi_H > 1/N` como extensões com bounds/simulações.

## Regra de transporte para o paper

Não editar `formal_model_v5.Rmd` durante a rederivação. Transportar resultados para o paper apenas quando:

1. as primitivas e o timing estiverem estáveis;
2. as fórmulas de majority e unanimity estiverem derivadas no documento separado;
3. os scripts R reproduzirem os checks numéricos/calibrados;
4. as provas principais estiverem auditadas sem reservas centrais.
