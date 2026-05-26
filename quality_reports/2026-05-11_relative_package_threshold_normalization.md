# Decisão de normalização dos thresholds em R2

Data: 2026-05-11

Status: decisão de desenho para a arquitetura relative-package.

## Decisão

O modelo não deve carregar uma distinção entre threshold bruto e threshold
efetivo. Essa distinção apareceu na derivação clean-room porque ela permitiu
valores em que `d_theta - b_theta < 0`. Para o modelo principal, esse domínio
não é substantivamente útil: se `H` aceitaria o acordo mesmo com `y = 0`, não
há screening operacional nesse tipo.

Daqui em diante, a arquitetura define diretamente o domínio admissível dos
thresholds:

```text
tau_theta = d_theta - b_theta
0 <= tau0 < tau1 <= ybar
```

Assim, o threshold que aparece na participação de `H` já é o pacote mínimo
admissível. Não há objeto separado chamado threshold efetivo.

## Interpretação substantiva

`tau_theta` mede a concessão institucional mínima necessária para que `H` aceite
participar, líquida do benefício direto do acordo. A restrição `tau_theta >= 0`
diz que `H` não recebe um benefício direto tão alto que aceitaria qualquer
pacote, inclusive `y = 0`.

A restrição `tau1 > tau0` é o primitive de screening: o tipo alto exige uma
concessão institucional maior.

## Implicação para os relatórios de agentes

Os relatórios de auditoria continuam úteis como diagnóstico, mas a recomendação
de introduzir `a_theta = max(0, d_theta - b_theta)` não será incorporada ao
modelo principal. Em vez disso, o domínio de primitivas será restringido para
que `tau_theta` já esteja dentro do espaço de pacotes.

## Implicação para o ledger

R2 continua pendente como teorema fechado por causa de decisões protocolares:

1. aceitação de `H` em igualdade ao threshold;
2. aceitação dos weak voters quando recebem exatamente o valor de continuação;
3. existência de no-proposal/no-agreement quando isso for payoff-relevante;
4. seleção no cutoff entre pacote baixo e pooling.

Mas a distinção bruto/efetivo não é uma pendência do modelo. Ela foi eliminada
por restrição de domínio.
