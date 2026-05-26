# Redesign do modelo: agenda R1 dos weak states

**Data:** 2026-05-10  
**Motivação:** resposta completa em `quality_reports/h_proposer_response_complete.md` sobre o subgame em que `H` propõe em R1 sob unanimidade.

**Refinamento posterior:** ver `quality_reports/2026-05-10_power_architecture_piH.md`. A versão mais precisa da decisão não é apenas "weak states propõem", mas sim separar três fontes de poder: outside option, veto/pivotality e proposal power. O baseline usa `pi_H = 0`; os casos `pi_H = 1/N` e `pi_H > 1/N` entram como extensões.

## Q&A

**Qual é o problema que força o redesign?**  
Quando `H` propõe em R1 sob unanimidade, a proposta revela informação sobre o tipo de `H`. O ramo deixa de ser apenas um problema de bargaining BF e vira um jogo de sinalização. Fora da região de accepted pooling, o payoff de `H` não é uma função única: há inexistência de PBE puro em regiões relevantes e, com mixing/tie-breaking, payoffs dependem de seleção, crenças off-path e refinamentos.

**Isso mata o mecanismo central?**  
Não. O mecanismo central é que unanimidade torna `H` pivotal e força weak proposers a comprar sua aprovação sem observar `theta`. Esse mecanismo aparece quando `W` propõe. O ramo `H`-proposer é um mecanismo distinto, de signaling por informed proposer, e deve sair do modelo principal.

**Qual é a decisão de arquitetura?**  
Na próxima versão do modelo principal, introduzir `pi_H` como probabilidade de reconhecimento de `H`, mas resolver primeiro o baseline `pi_H = 0`. Nesse baseline, apenas weak states podem propor; `H` permanece como veto player informado sob unanimidade. O objetivo é isolar `informational power through pivotality` de agenda power.

**Quais fontes de poder o novo paper separa?**  
1. Outside-option power: `H` tem `d_H = alpha V(theta)`, potencialmente maior que a outside option dos demais.  
2. Veto/pivotality power: sob unanimidade, `H` precisa aceitar o acordo.  
3. Proposal power: `H` controla a agenda com probabilidade `pi_H`.

## Novo protocolo recomendado

1. Stage 0: `H` escolhe a regra institucional `R in {M,U}`.
2. Stage 1: natureza sorteia `theta`; `H` observa `theta`; weak states observam apenas a crença/prior.
3. Entry: weak states entram coletivamente/all-or-nothing se o payoff esperado cobre `c`.
4. R1 bargaining:
   - introduzir `pi_H` como probabilidade de `H` ser reconhecido;
   - no baseline principal, `pi_H = 0`, então o proposer é sorteado uniformemente entre os `N-1` weak states;
   - sob unanimidade, o weak proposer deve obter o voto de `H` e escolhe entre `A(mu)`, `C(mu)` e `R(mu)` com strict BF feasibility;
   - sob majority, o weak proposer exclui `H` e forma coalizão com outros weak states.
5. Se R1 é rejeitado, o jogo segue para R2 com regra de continuação a ser escolhida e explicitada.

## Escolha ainda aberta: R2

Há duas opções viáveis:

**Opção A — R2 weak-proposer only também.**  
Mais limpa. Remove completamente informed-proposer signaling. Mantém o foco em weak proposers comprando `H`.

**Opção B — R2 BF padrão após rejeição.**  
Mais próxima do modelo atual, mas reintroduz `H` como proposer em R2. Em R2 terminal, o problema de signaling é menos grave porque não há continuação após rejeição, mas ainda é preciso rederivar cuidadosamente os payoffs.

Recomendação inicial: começar com Opção A e `pi_H = 0` para recuperar um teorema limpo; depois tratar `pi_H = 1/N` e `pi_H > 1/N` como extensões/robustez.

## Stress test: outside option igual aos weak states

Além de separar proposal power, a nova versão deve isolar quanto do screening vem do outside option forte. No modelo atual `d_W = 0`; portanto o caso extremo em que `H` não tem outside option mais forte corresponde a `alpha = 0`. Se a normalização for reescrita com outside option comum positiva, o mesmo teste deve ser formulado como `d_H = d_W`.

Pergunta a derivar:

```text
Does unanimity still create screening rents when H is pivotal and informed but has no stronger outside option?
```

Não assumir a resposta. Esse teste decide quanto do resultado vem de veto/pivotality e quanto vem do outside option state-dependent.

## Implicação para OPEC

O redesign melhora o estudo de caso. A Arábia Saudita não precisa ser modelada como agenda setter formal. A interpretação passa a ser:

```text
H = Saudi Arabia
W = other OPEC members
theta = true Saudi spare capacity / ability to discipline the cartel
V(theta) = value of a quota agreement
alpha V(theta) = Saudi unilateral outside option
R1 proposer = non-hegemonic members, conference process, quota committee, or bargaining coalition
```

Frase substantiva recomendada:

> The relevant agenda-setters are the non-hegemonic producers trying to assemble a viable quota agreement; Saudi Arabia's power comes not from making the proposal, but from being indispensable to any agreement and privately informed about the value of its outside option.

## O que precisa ser refeito

1. Reespecificar o timing no corpo e Appendix A.
2. Introduzir `pi_H` como primitivo de agenda power.
3. Resolver primeiro o baseline `pi_H = 0`.
4. Recalcular majority R1/R2 sob agenda weak-proposer.
5. Recalcular unanimity R2 conforme a escolha A ou B acima.
6. Recalcular unanimity R1 com `A/C/R` e strict BF feasibility.
7. Derivar o stress test `alpha = 0`/`d_H = d_W`.
8. Recalcular payoffs esperados de `H` e `W`.
9. Reprovar dominância condicional, entry/nesting e classificação.
10. Refazer game tree e figuras de payoff.
11. Reescrever OPEC case removendo qualquer sugestão de que Saudi controla formalmente a agenda no baseline.

## Status

O apêndice atual de `formal_model_v5.Rmd` continua sendo o registro mais recente do modelo com BF random proposer, mas não deve ser tratado como arquitetura final. A próxima rodada deve criar a versão redesenhada antes de reescrever o corpo principal.
