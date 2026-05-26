# Derivação clean-room de R2 unanimity sob relative packages

Data: 2026-05-11  
Agente: B, derivador clean-room R2  
Escopo de leitura: `AGENTS.md`, `model_redesign/README.md`,
`quality_reports/2026-05-11_relative_package_reimplementation.md`  
Escopo de escrita: este relatório  
Observação clean-room: não consultei a seção candidata de R2 em
`model_redesign/power_architecture_derivations.Rmd`.

## Q&A de escopo

1. Qual é o puzzle substantivo?

   Mostrar como unanimity pode dar poder informacional a `H` porque `H` é
   pivotal e tem tipo privado, mesmo quando `H` não controla a agenda.

2. Quem são os atores estratégicos?

   Um hegemon `H` e `m = N - 1` weak states. Em R2, sob o baseline `pi_H = 0`,
   apenas weak states podem ser proposers. `H` é votante indispensável sob
   unanimity.

3. A interação é simultânea ou sequencial?

   Sequencial. Nature escolhe o tipo de `H`; um weak proposer é reconhecido;
   ele propõe um pacote `y`; os voters aceitam ou rejeitam segundo o protocolo
   de unanimity.

4. A informação é completa?

   Não. `H` conhece `theta`; weak states têm crença `mu = Pr(theta = 1)`.
   Todos observam o pacote proposto `y`.

5. Qual instituição estrutura os incentivos?

   Unanimity: o pacote só passa se todos os votantes necessários aceitarem. O ponto
   central é que `H` é pivotal.

6. Quais variáveis exógenas importam?

   `N`, `m`, `mu`, `V0`, `V1`, `ybar`, `b0`, `b1`, `d0`, `d1`. Aqui `Vtheta`
   é o surplus institucional bruto disponível para os weak states no estado
   `theta`; `btheta` é o benefício direto de acordo para `H`; `dtheta` é a
   outside option terminal de `H` se não houver acordo em R2.

## Follow-up Q&A

1. Há compromisso crível ou enforcement?

   O pacote votado é tratado como implementável se aceito. Não introduzo
   renegociação depois da votação.

2. Existem tipos privados?

   Sim. `theta in {0,1}` é privado de `H`. O tipo 1 é o tipo de limiar mais
   alto quando o mecanismo de screening está ativo.

3. Qual é o horizonte?

   Este relatório trata R2 como rodada final. Se R2 não for terminal, a
   derivação precisa ser reaberta.

4. O objetivo é explicação teórica ou teste empírico?

   Derivação formal.

5. Foco em derivação ou interpretação?

   Derivação, com interpretação mínima para defender a normalização do custo
   de `y`.

## Primitivos usados

- `pi_H = 0`: `H` nunca é proposer em R2.
- Um weak state é reconhecido como proposer. Como há `m` weak states
  simétricos, cada um tem probabilidade `1/m` de ser proposer.
- O proposer escolhe `y in [0, ybar]`.
- O pacote `y` é sempre factível em todos os estados. Isso significa que a
  implementação física do pacote não depende de `theta`; não significa que o
  pacote é sem custo para os weak states.
- Payoff de `H` se aceita:

  `U_H(y, theta) = y + b_H(theta)`.

- Outside option terminal de `H` em R2:

  `d_H(theta)`.

- Crença dos weak states:

  `mu = Pr(theta = 1)`.

- Surplus bruto dos weak states antes da concessão:

  `V0 = V(theta = 0)` e `V1 = V(theta = 1)`.

- Custo de `y` para os weak states:

  `S_W(theta, y) = Vtheta - y`.

  Esta é uma normalização one-for-one. A unidade de `y` é escolhida para medir
  quanto surplus relativo é deslocado da coalizão weak para `H`. Isso é
  compatível com a arquitetura relative-package: `y` não é uma transferência
  fisicamente limitada pela pie; é um índice de termos institucionais mais
  favoráveis a `H`, com custo de oportunidade para a coalizão weak.

## Pontos de protocolo não declarados

Dois objetos são necessários para transformar a derivação em teorema fechado:

1. Rejeição em R2.

   Para resolver R2, é preciso que rejeição leve a um payoff terminal. Neste
   relatório uso a convenção condicional: rejeição em R2 gera no agreement,
   `H` recebe `d_H(theta)` e weak states recebem outside option normalizada
   zero. Se o protocolo de R2 tiver continuação não terminal, tudo abaixo vira
   pending.

2. Empate no threshold de `H`.

   Quando `y + b_H(theta) = d_H(theta)`, `H` é indiferente. Fórmulas com pacote
   exatamente no threshold exigem uma regra de desempate em favor da aceitação.
   Sem essa regra, os mesmos valores devem ser lidos como supremos obtidos por
   `y = threshold + epsilon`, ou como correspondências no ponto de empate.

## Estratégia de H

Para cada tipo `theta`, defina o threshold bruto:

`raw_tau_theta = d_H(theta) - b_H(theta)`.

Como o proposer só pode escolher `y >= 0`, o menor pacote admissível que pode
induzir aceitação do tipo `theta` é:

`a_theta = max(0, raw_tau_theta)`.

Esse pacote é implementável apenas se:

`a_theta <= ybar`.

A estratégia sequencialmente racional de `H` é:

- aceitar se `y > raw_tau_theta`;
- rejeitar se `y < raw_tau_theta`;
- se `y = raw_tau_theta`, aceitar e rejeitar são ambos racionais.

Usando `a_theta`, a condição de screening efetiva no espaço de contratos é:

`a_1 > a_0`.

Essa condição é mais forte do que `raw_tau_1 > raw_tau_0` quando algum
threshold bruto é negativo ou quando `ybar` corta o espaço de contratos. Se
`raw_tau_1 > raw_tau_0`, mas `a_1 = a_0 = 0`, ambos os tipos aceitam `y = 0` e
não há screening operacional.

## Weak voters e payoff do proposer

Em unanimity, os weak voters também precisam aceitar. Para fechar R2 sem
introduzir outro instrumento, uso a normalização indicada nos guardrails:
weak voters recebem suas outside options; o proposer fica com o residual.

Com outside option weak normalizada em zero:

- cada non-proposer weak voter recebe `0`;
- aceita fracamente;
- o weak proposer recebe `Vtheta - y` se o acordo passa no estado `theta`;
- se o acordo é rejeitado, todos os weak states recebem `0`.

Se o paper quiser weak voters com outside option positiva, ou se quiser exigir
shares estritamente positivos para non-proposers, a fórmula deve ser ajustada.
Esse ajuste é uma pending protocol decision, não uma consequência dos
primitivos atuais.

## Problema do weak proposer em R2

Assuma, nesta seção, que `a_1 > a_0`, isto é, que o tipo 1 de `H` requer um
pacote mais favorável.

### Pacote aceito apenas pelo tipo de limiar baixo

O menor pacote que induz aceitação do tipo 0 é `y = a_0`. Sob `a_1 > a_0`, o
tipo 1 rejeita esse pacote.

Esse candidato é factível se `a_0 <= ybar`.

Payoff esperado do proposer:

`G_low(mu) = (1 - mu) * (V0 - a_0)`.

Se `V0 < a_0`, esse candidato tem payoff negativo para `mu < 1`; nesse caso,
um proposer que possa induzir no agreement prefere não fechar acordo.

### Pacote pooling aceito pelos dois tipos

O menor pacote que induz aceitação dos dois tipos é `y = a_1`.

Esse candidato é factível se `a_1 <= ybar`.

Defina:

`Ve(mu) = (1 - mu) * V0 + mu * V1`.

Payoff esperado do proposer:

`G_pool(mu) = Ve(mu) - a_1`.

Esse pacote dá uma renda informacional ao tipo 0 de `H`, porque o tipo 0
recebe mais do que precisava para aceitar.

### No agreement

No agreement entra como candidato se, e somente se, o protocolo de R2 permite
que uma proposta rejeitada encerre a rodada com outside options terminais, ou
se houver uma ação explícita de não propor. Sob a convenção condicional deste
relatório:

`G_no = 0`.

No agreement é escolhido quando todos os candidatos aceitos e factíveis dão
payoff fraco menor ou igual a zero:

`max{G_low(mu), G_pool(mu)} <= 0`,

removendo do máximo qualquer candidato que viole `a_theta <= ybar`.

Sem protocolo terminal de rejeição ou ação explícita de não propor, `G_no` é
pending protocol decision.

## Valor de R2 para o weak proposer

Sob os pontos condicionais acima, o valor do proposer em R2 é:

`P2_U(mu) = max{0, G_low(mu), G_pool(mu)}`,

com candidatos infeasible removidos.

Em forma expandida, sob `a_1 > a_0`:

`P2_U(mu) = max{0, (1 - mu) * (V0 - a_0), Ve(mu) - a_1}`.

Essa fórmula é válida quando:

- rejeição em R2 gera outside option terminal;
- weak outside option é zero;
- weak voters podem receber sua outside option e o proposer pode ficar com o
  residual;
- os thresholds relevantes cabem no contract space, ou candidatos infeasible
  são removidos;
- empates de `H` são resolvidos por aceitação, ou a fórmula é lida como
  supremo/correspondência.

## Valor representativo de um weak state

Antes do reconhecimento do proposer, cada weak state tem probabilidade `1/m`
de ser proposer e probabilidade `(m - 1)/m` de ser non-proposer. Como
non-proposers recebem zero sob a normalização atual:

`W2_U(mu) = P2_U(mu) / m`.

Depois do reconhecimento:

- weak proposer recebe `P2_U(mu)`;
- cada non-proposer weak voter recebe `0`.

Se weak voters tiverem outside option positiva, `W2_U(mu)` muda. Isso deve ser
decidido como protocolo, não inferido.

## Cutoff entre pacote baixo e pooling

Quando os dois candidatos são factíveis e `V1 > a_0`, o pacote pooling domina
fracamente o pacote aceito apenas pelo tipo baixo se:

`mu >= (a_1 - a_0) / (V1 - a_0)`.

Chame esse valor de:

`mu_pool_low = (a_1 - a_0) / (V1 - a_0)`.

Esse cutoff só é útil se estiver em `[0,1]` e se no agreement não dominar
ambos os candidatos. Se `V1 <= a_0`, não há cutoff interior desse tipo sob
`a_1 > a_0`.

## Valores de continuação de H

A estratégia de `H` é threshold-based. Para um pacote `y`, o valor de `H` no
estado `theta` é:

`H2(theta, y) = y + btheta`, se `y` é aceito pelo tipo `theta`;

`H2(theta, y) = dtheta`, se `y` é rejeitado pelo tipo `theta`.

Se o weak proposer escolhe o pacote de limiar baixo `y = a_0`:

- tipo 0 recebe `a_0 + b0`, que é igual a `d0` quando `a_0 = raw_tau_0`;
- tipo 1 rejeita e recebe `d1`.

Se o weak proposer escolhe o pacote pooling `y = a_1`:

- tipo 1 recebe `a_1 + b1`, que é igual a `d1` quando `a_1 = raw_tau_1`;
- tipo 0 recebe `a_1 + b0`, uma renda acima de sua outside option se
  `a_1 + b0 > d0`.

Se no agreement é escolhido:

- tipo `theta` recebe `dtheta`.

Como o weak proposer pode estar indiferente entre pacotes em alguns valores de
`mu`, o valor de continuação de `H` deve ser tratado como correspondência:

`C_H2_U(theta, mu) = {H2(theta, y): y in Y_star(mu)}`,

onde `Y_star(mu)` é o conjunto de pacotes ótimos para o weak proposer. Para
transformar isso em valor único, o paper precisa declarar uma regra de seleção
entre pacotes empatados.

## Casos fora do mecanismo de screening

Se `a_1 <= a_0`, a arquitetura não gera o screening pretendido. Há dois casos:

1. `a_1 = a_0`: os dois tipos aceitam o mesmo pacote mínimo; não há separação.
2. `a_1 < a_0`: o tipo 1 aceita com pacote menor do que o tipo 0. Isso é o
   oposto da condição substantiva pretendida. Pode haver um pacote aceito
   apenas pelo tipo 1, mas esse não é o mecanismo de pivotal informational
   power que o redesign quer usar.

Não atribuo rótulos estratégicos a esses casos para evitar reaproveitar a
arquitetura antiga.

## Principais implicações

1. R2 unanimity pode ser resolvido de forma limpa se o protocolo terminal for
   declarado.

2. O objeto central não é factibilidade por estado. O objeto central é o limiar
   efetivo de participação de `H`:

   `a_theta = max(0, d_H(theta) - b_H(theta))`.

3. Screening operacional exige:

   `a_1 > a_0`.

4. O valor do weak proposer é o máximo entre três consequências: aceitar só
   com o tipo de limiar baixo, oferecer o pacote pooling, ou terminar sem
   acordo.

5. A renda informacional aparece no pacote pooling: para obter aceitação do
   tipo de limiar alto, o proposer paga `a_1`; o tipo de limiar baixo teria
   aceitado por `a_0`.

## Ledger de status

- `pi_H = 0` e `H` nunca proposer em R2: PASS.
- Pacote `y in [0,ybar]` sempre factível em todos os estados: PASS.
- Payoff de `H`, `U_H(y,theta) = y + b_H(theta)`: PASS.
- Custo one-for-one de `y` para weak states, `S_W(theta,y) = Vtheta - y`:
  PASS como normalização reduzida; precisa ser declarado no paper.
- Estratégia threshold de `H`: PASS fora dos pontos de igualdade.
- Empate no threshold de `H`: PENDING protocol decision se o paper quiser
  valores exatos; caso contrário, usar supremos/correspondências.
- Rejeição terminal em R2/no agreement: PENDING protocol decision. As fórmulas
  deste relatório são condicionais a essa decisão.
- Weak voters recebendo outside option zero e proposer mantendo residual:
  PASS sob a normalização atual; PENDING se weak voters tiverem outside option
  positiva ou direito a shares.
- Valor do weak proposer:
  `P2_U(mu) = max{0, (1 - mu) * (V0 - a_0), Ve(mu) - a_1}`:
  PASS condicional aos pontos de protocolo acima.
- Valor representativo de weak state:
  `W2_U(mu) = P2_U(mu) / m`: PASS condicional à simetria de reconhecimento e
  weak outside option zero.
- Valor de continuação de `H`: PASS como correspondência; PENDING se o paper
  precisar de seleção única entre pacotes empatados.
- Screening por relative package: PASS se `a_1 > a_0`; FAIL se a diferença
  existe só nos thresholds brutos, mas desaparece após clipping por `y >= 0` ou
  pelo contract space.
- Teorema fechado e incondicional de R2 unanimity: FAIL neste estágio, porque
  ainda faltam decisões explícitas sobre rejeição terminal e desempate nos
  thresholds.
