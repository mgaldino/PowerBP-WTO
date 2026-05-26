# Condições suficientes e nesting calibrado

**Data:** 2026-05-10  
**Objeto:** verificação da proposta em `quality_reports/bf_unanimity_rederivation_chat.md` e continuação da rederivação das provas pendentes sob majority outside option externa e strict BF feasibility.

## Q&A operacional

**A proposta em `bf_unanimity_rederivation_chat.md` passa?**  
Parcialmente. A região de pooling do H-proposer, a invalidação da fórmula global antiga e o lower bound `L_H(p)` passam. A afirmação global de inexistência de PBE puro fora do pooling ainda não deve ser promovida a resultado publicável sem uma prova exaustiva dos casos de factibilidade.

**Há um substituto seguro para o antigo teorema geral de dominância condicional?**  
Sim. Há um teorema de condições suficientes baseado no lower bound do H-proposer e no fato de que, sob uma janela de `beta`, a oferta agressiva de W é factível e domina rejeição deliberada. Se W escolhe a oferta conservadora, o payoff de H só aumenta.

**A calibração OPEC satisfaz essas condições?**  
Sim. Para `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`, `q=7`:

```text
max{0.6842105, 0.8316498} < 0.9 < 0.9193777
```

Os endpoint gaps do lower bound são positivos:

```text
D_A(0) = 0.0795739645
D_A(1) = 0.0216213018
```

**O nesting `F_U subset F_M` pode ser restaurado?**  
Como teorema geral, ainda não. Para a calibração, sim: usando um upper bound selection-free para o payoff dos weak states sob unanimidade, majority dá payoff maior aos fracos em todos os pontos relevantes.

## Resultado 1: condições suficientes para dominância condicional

Defina:

```text
m = N - 1
A0 = 1 + m alpha
A1 = 1 + m alpha r
lambda_M^E = [N A0 - beta(q-1)] / N^2
```

Uma condição suficiente para `U` dominar `M` condicionalmente para H em todo `mu in [0,1]` é:

```text
max{
  N A0 / [A0 + m A1 + q - 1],
  N m alpha / [q - 1 + N m alpha]
}
< beta <
N / [N + m alpha(r - 1)]
```

A desigualdade superior garante que a oferta agressiva de W seja factível e que rejeição deliberada não domine a opção agressiva. As duas desigualdades inferiores são exatamente as condições para os endpoints `D(0)>0` e `D(1)>0`.

Este resultado é suficiente, não necessário. Ele não resolve o payoff correspondence do H-proposer fora do pooling, mas também não depende dele.

## Resultado 2: nesting calibrado

Para `N=13`, `r=1.5`, `alpha=0.19`, `beta=0.9`, o upper bound para o payoff representativo dos fracos sob unanimidade fica abaixo do payoff corrigido dos fracos sob maioria nos ramos relevantes:

```text
A em [0, 0.031188]          : min gap = 0.0212465
C em [0.031188, 0.301717]   : min gap = 0.0238536
A em [0.301717, 1]          : min gap = 0.0254756
R tie/check                 : min gap = 0.0228679
```

Logo, para a calibração:

```text
V_W^R1(mu,M) > V_W^R1(mu,U) para todo mu in [0,1]
```

e, portanto:

```text
F_U subset F_M
```

para qualquer custo de entrada `c`.

## Implicação para a classificação institucional

Na calibração, a classificação antiga pode ser recuperada como resultado paramétrico:

1. Se `mu in F_U`, ambos os arranjos formam e unanimidade domina para H.
2. Se `mu in F_M \ F_U`, só majority forma e majority domina para H.
3. Se `mu notin F_M`, nenhum arranjo forma e H fica indiferente.

A condição auxiliar do segundo caso também passa:

```text
lambda_M^E = 0.220355 > alpha = 0.19
```

equivalentemente:

```text
alpha < 1 - beta(q-1)/N
```

## Arquivos atualizados

- `formal_model_v5.Rmd`: Appendix B.5 agora registra o teorema suficiente; B.6 registra o nesting calibrado; B.8 registra a classificação calibrada. O corpo principal não foi alterado.
- `scripts/verify_sufficient_conditions_lower_bound.R`: reproduz a janela de `beta` e os endpoint gaps.
- `scripts/verify_calibrated_nesting_upper_bound.R`: reproduz o nesting calibrado por upper bound.

## Próxima Q&A recomendada

**Queremos tentar generalizar o nesting ou aceitar uma arquitetura calibrada/paramétrica?**  
Se a prioridade é uma resposta robusta ao referee, a arquitetura calibrada/paramétrica é mais segura agora. Se a prioridade é preservar uma contribuição teórica geral, o próximo passo é caracterizar um upper bound mais apertado para os weak states no subgame H-proposer fora do accepted pooling.
