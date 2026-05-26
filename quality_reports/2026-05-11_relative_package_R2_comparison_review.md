# Revisão comparativa independente de R2 unanimity

Data: 2026-05-11  
Agente: C, revisor comparativo independente  
Escopo de escrita: `quality_reports/2026-05-11_relative_package_R2_comparison_review.md`  
Status geral: PENDING

## Q&A

**Os dois relatórios chegam à mesma conclusão central?**  
Sim, mas só no subcaso regular. A auditoria do candidato e a derivação
clean-room concordam que a álgebra de R2 funciona quando os thresholds
relevantes são não negativos, cabem no espaço de pacotes e os empates são
tratados por uma convenção explícita. Elas também concordam que não há teorema
fechado sem ressalvas neste estágio.

**Qual é a principal divergência substantiva?**  
A derivação clean-room identifica que o objeto correto no espaço de contratos é
o threshold efetivo `a_theta = max(0, d_theta - b_theta)`, não apenas o
threshold bruto `tau_theta = d_theta - b_theta`. A auditoria do candidato está
correta no subcaso em que `0 <= tau0 < tau1`, mas não deve ser promovida como
formulação geral.

**Há algum resultado R2 que possa ser marcado como proved agora?**  
Não como teorema de R2 completo. Há objetos primitivos e identidades algébricas
que recebem PASS. O resultado agregado "R2 unanimity under relative packages"
deve ficar como `PENDING: conditional derivation`.

**O protocolo de revisão e iteração está claro?**  
Sim. O protocolo exige PASS sem ressalvas antes de avançar para R1. Como há
objetos PENDING e um uso atual de threshold bruto onde o objeto geral deveria
ser efetivo, a próxima iteração deve ajustar o Rmd e o script, depois rodar nova
verificação independente.

## Materiais comparados

- `quality_reports/2026-05-11_relative_package_R2_candidate_audit.md`
- `quality_reports/2026-05-11_relative_package_R2_cleanroom_derivation.md`
- `quality_reports/2026-05-11_relative_package_R2_review_protocol.md`
- `AGENTS.md`
- `model_redesign/README.md`
- `quality_reports/2026-05-11_relative_package_reimplementation.md`
- inspeção pontual, sem edição, de `model_redesign/power_architecture_derivations.Rmd`
- inspeção pontual, sem edição, de `scripts/verify_relative_package_R2_piH0.R`

Não usei a arquitetura feasibility/C-B-R nem os branch labels antigos.

## Convergências

1. Os dois relatórios aceitam a arquitetura relative-package: `y` é um pacote
   institucional sempre disponível no espaço declarado, não uma promessa
   fisicamente factível em um estado e infactível em outro.

2. Ambos tratam `U_H(y, theta) = y + b_H(theta)` como primitivo.

3. Ambos aceitam a normalização one-for-one para weak states: o pacote `y`
   reduz o surplus fraco em uma unidade por unidade de concessão.

4. Ambos distinguem payoff do proposer e payoff representativo: o proposer
   recebe o residual; o weak state representativo recebe o valor do proposer
   multiplicado pela probabilidade `1/m` de reconhecimento.

5. Ambos identificam dois candidatos substantivos de acordo em R2: pacote que
   compra só o tipo de limiar baixo e pacote pooling que compra os dois tipos.

6. Ambos veem no-agreement como problemático: pode ser redundante sob
   regularidade, mas não deve ser usado como ação primitiva sem declaração
   explícita de no-proposal ou de pacote que induz rejeição terminal.

7. Ambos rejeitam o status "proved" para o resultado agregado. O resultado R2
   ainda depende de decisões protocolares.

## Divergências

### 1. Threshold bruto versus threshold efetivo

A auditoria do candidato usa:

```text
tau_theta = d_theta - b_theta
```

e assume:

```text
0 <= tau0 < tau1 <= ybar
```

Dentro desse subcaso, isso é coerente.

A derivação clean-room mostra que, no modelo geral com `y >= 0`, o objeto
operacional é:

```text
a_theta = max(0, d_theta - b_theta)
```

Esse ponto é decisivo. Se `d_theta - b_theta < 0`, o tipo `theta` aceita
`y = 0`; o proposer não pode oferecer pacote negativo. Logo, diferenças nos
thresholds brutos podem desaparecer após clipping. Exemplo:

```text
tau1 > tau0, mas tau1 < 0 e tau0 < 0
então a1 = a0 = 0
resultado: não há screening operacional
```

Veredito comparativo: a formulação com `tau` recebe PASS apenas como subcaso
regular. A formulação geral deve usar `a_theta`.

### 2. Payoffs de H quando há clipping

No subcaso regular, em que `a_theta = tau_theta`, um tipo que aceita exatamente
seu threshold recebe seu payoff de rejeição:

```text
a_theta + b_theta = d_theta
```

Mas isso falha quando o threshold bruto é negativo e o threshold efetivo vira
zero:

```text
a_theta = 0
payoff aceitando = b_theta
se b_theta > d_theta, então b_theta != d_theta
```

Assim, as fórmulas do candidato para continuation values de H são corretas no
caso regular, mas não na formulação geral. O Rmd deve distinguir esses dois
níveis.

### 3. No-agreement

A auditoria do candidato diz que `0` no máximo é redundante sob:

```text
0 <= tau0 <= 1
tau1 <= r
```

A derivação clean-room deixa mais claro que `0` só entra como payoff de escolha
se o protocolo declarar rejeição terminal em R2, no-proposal, ou uma ação
admissível que ambos os tipos rejeitam. Se `a0 = 0`, não há `y < a0` no espaço
`[0, ybar]`; nesse caso, no-agreement exige uma ação separada.

Veredito comparativo: no-agreement é PENDING como ação. Pode ser mantido como
termo redundante apenas se o texto declarar que o caso regular não depende dele.

### 4. Empates

Há três empates distintos:

1. `H` indiferente no threshold: `y + b_theta = d_theta`.
2. Weak voters indiferentes quando recebem exatamente a continuation value.
3. Proposer indiferente entre pacote baixo e pooling no cutoff.

Os dois relatórios identificam que os empates não podem ficar implícitos. Sem
regra de aceitação em indiferença, as fórmulas exatas viram supremos ou
correspondências. Sem regra de seleção no cutoff, o continuation value de H para
R1 não é valor único.

Veredito comparativo: PENDING.

## Ledger de objetos mínimos

| Objeto | Veredito | Justificativa |
|---|---|---|
| 1. Espaço de pacotes `y in [0, ybar]` | PASS | É primitivo declarado e não usa feasibility por estado. |
| 2. Custo de `y` para weak states | PASS como primitivo | A normalização `S_W(theta,y) = Vtheta - y` é adotada. Não é derivada de microfundamento de quotas. |
| 3. Payoff de H ao aceitar | PASS | `U_H(y,theta) = y + b_H(theta)` é primitivo declarado. |
| 4. Payoff terminal de H após rejeição em R2 | PASS condicional | Passa se R2 for terminal e rejeição entregar `d_H(theta)`. O texto geral de timing deve deixar claro que essa convenção é específica de R2. |
| 5. Threshold bruto `tau_theta = d_theta - b_theta` | PASS como objeto latente | É o ponto de indiferença bruto de H. Não é sempre o pacote mínimo admissível. |
| 6. Threshold efetivo `a_theta = max(0, d_theta - b_theta)` | PASS | É o objeto correto no espaço de contratos com `y >= 0`. Deve substituir `tau` na formulação geral. |
| 7. Screening operacional | PASS condicional | O screening relevante é `a1 > a0`, com candidatos factíveis no espaço de pacotes. `tau1 > tau0` não basta fora do subcaso regular. |
| 8. Estratégia ótima de H por tipo | PENDING | Passa fora dos pontos de igualdade. No threshold exato, aceitar ou rejeitar são sequencialmente racionais, então falta regra de desempate ou uso explícito de supremos. |
| 9. Weak voters recebendo continuation value | PENDING | O payoff residual exato exige que weak voters aceitem ofertas exatamente iguais à continuation value. Sem isso, a fórmula é supremo com epsilon. |
| 10. Payoff do weak proposer | PENDING | A forma corrigida é `P2_U(mu) = max{G_low, G_pool}` no caso regular sem precisar de no-agreement, ou `max{0, G_low, G_pool}` se no-agreement for ação declarada. Depende dos itens 8 e 9. |
| 11. Payoff representativo de weak state | PASS condicional | A divisão por `m` está correta sob reconhecimento uniforme e payoff zero dos non-proposers. Depende da validade do payoff do proposer. |
| 12. No-agreement no problema de maximização | PENDING | Redundante sob regularidade; não é ação primitiva geral sem no-proposal ou pacote rejeitado por ambos os tipos. |
| 13. Cutoff entre pacote baixo e pooling | PASS na versão corrigida | Com thresholds efetivos: `mu_star = (a1 - a0) / (V1 - a0)`, quando `V1 > a0` e os dois candidatos são factíveis. No caso `V0=1`, `V1=r`, vira `mu_star = (a1 - a0) / (r - a0)`. |
| 14. Fórmula atual com `tau`: `mu_star = (tau1 - tau0)/(r - tau0)` | PASS apenas no subcaso regular | Correta se `a0=tau0` e `a1=tau1`. Não deve ser apresentada como fórmula geral. |
| 15. Choice regions em torno do cutoff | PASS condicional | Low-only antes do cutoff e pooling depois do cutoff, quando no-agreement não domina e os candidatos são factíveis. No cutoff, há empate. |
| 16. Valor de continuação de H para R1 | PENDING | Deve ser correspondência baseada no conjunto de pacotes ótimos. Valores únicos só existem fora de empates e sob seleção declarada. |
| 17. `C_H2_U(1,mu)=d1` | PASS no subcaso de screening regular | Se `a1 > a0`, então `a1 > 0` e o high type recebe `d1` no pooling ou rejeita e recebe `d1`. Fora desse subcaso, calcular por `y+b1` ou `d1`. |
| 18. `C_H2_U(0,mu)=d0` antes do cutoff | PASS apenas se `a0=tau0` | Na formulação geral, o low type no pacote baixo recebe `a0 + b0`, que pode ser maior que `d0` se o threshold bruto for negativo. |
| 19. Renda informacional do low type no pooling | PASS na forma corrigida | A diferença entre pooling e pacote baixo para o low type é `a1 - a0`. A base é `a0 + b0`, não necessariamente `d0`. |
| 20. Uso de R2 para derivar R1 | PENDING | R1 ainda precisa derivar o posterior `mu'`, a seleção em R2 e os thresholds dinâmicos. |
| 21. Status de reprodutibilidade via script R | PENDING | O script verifica o subcaso regular com thresholds brutos. Ainda não verifica a formulação geral com `a_theta`, nem separa no-agreement como escolha protocolar. |
| 22. Resultado R2 completo sem ressalvas | FAIL neste estágio | Seria transformar opções protocolares pendentes em teorema. |

## Formulação corrigida recomendada para R2

Use `V0 = 1` e `V1 = r` no benchmark, mas escreva a derivação de modo que a
estrutura geral fique visível.

Defina:

```text
raw_tau_theta = d_theta - b_theta
a_theta = max(0, raw_tau_theta)
```

O mecanismo de screening exige:

```text
a1 > a0
a1 <= ybar
```

Os candidatos aceitos pelo proposer são:

```text
G_low(mu) = (1 - mu) * (V0 - a0)
G_pool(mu) = Ve(mu) - a1
Ve(mu) = (1 - mu) * V0 + mu * V1
```

Se no-agreement for ação declarada:

```text
P2_U(mu) = max{0, G_low(mu), G_pool(mu)}
```

Se o texto permanecer no caso regular em que no-agreement é redundante:

```text
P2_U(mu) = max{G_low(mu), G_pool(mu)}
```

O valor representativo é:

```text
W2_U(mu) = P2_U(mu) / m
```

O cutoff entre pacote baixo e pooling, quando existe, é:

```text
mu_star = (a1 - a0) / (V1 - a0)
```

No benchmark `V1 = r`:

```text
mu_star = (a1 - a0) / (r - a0)
```

Os valores de H devem ser calculados diretamente por pacote:

```text
Se tipo theta aceita pacote y: H recebe y + b_theta
Se tipo theta rejeita pacote y: H recebe d_theta
```

Para o low type, fora do cutoff:

```text
se low-only é escolhido: C_H2_low = a0 + b0
se pooling é escolhido:  C_H2_low = a1 + b0
```

No cutoff:

```text
C_H2_low é uma correspondência entre a0 + b0 e a1 + b0
```

No subcaso regular `a0=tau0` e `a1=tau1`, isso reduz à fórmula do candidato:

```text
low-only: d0
pooling: d0 + tau1 - tau0
```

## Recomendações para o Rmd

1. Rebaixar a linha de status de R2. Trocar "proved for the terminal Round-2
   relative-package game" por:

```text
Status: conditional derivation. Core algebra passes in the regular subcase;
full proof remains pending protocol decisions on threshold equality, weak-voter
indifference, no-agreement/no-proposal, and cutoff selection.
```

2. Introduzir `raw_tau_theta` e `a_theta = max(0, raw_tau_theta)`. Usar `a0` e
   `a1` na formulação geral. Manter `tau` apenas como subcaso regular:

```text
If 0 <= raw_tau0 < raw_tau1, then a_theta = tau_theta and the simpler formulas
apply.
```

3. Trocar o screening operacional de `tau1 > tau0` para `a1 > a0`. Acrescentar
   que `raw_tau1 > raw_tau0` não basta quando ambos os thresholds brutos são
   negativos ou quando o espaço de pacotes corta algum candidato.

4. Ajustar os continuation values de H. Não escrever `C_H2_low = d0` como
   fórmula geral. Escrever primeiro em termos de `a0 + b0` e `a1 + b0`; depois
   mostrar a simplificação para `d0` e `d0 + tau1 - tau0` no subcaso regular.

5. Separar claramente proposer value e representative weak value:

```text
P2_U(mu) = valor do weak proposer reconhecido
W2_U(mu) = P2_U(mu) / m
```

6. Não usar no-agreement como terceiro candidato geral sem declarar a ação. No
   caso regular, o texto pode dizer que `0` é redundante e por isso a derivação
   não depende de no-proposal.

7. Marcar como PENDING as três decisões de empate: aceitação de H em igualdade,
   aceitação dos weak voters em igualdade e seleção no cutoff.

8. Não promover os thresholds de R1 como objeto fechado. Escrever que R1 ainda
   precisa derivar o posterior `mu'` e lidar com a correspondência de R2.

9. Atualizar o proof ledger: R2 deve ser `PENDING`, com nota de que a álgebra
   regular foi checada condicionalmente.

## Recomendações para o script R

1. Substituir o uso exclusivo de:

```text
tau0 = d0 - b0
tau1 = d1 - b1
```

por:

```text
raw_tau0 = d0 - b0
raw_tau1 = d1 - b1
a0 = max(0, raw_tau0)
a1 = max(0, raw_tau1)
```

2. Calcular payoffs com `a0` e `a1`:

```text
pooling_payoff = Ve(mu) - a1
low_only_payoff = (1 - mu) * (V0 - a0)
```

3. Parametrizar `V0` e `V1`, ou ao menos deixar explícito que o script fixa
   `V0 = 1` e `V1 = r`.

4. Não incluir `no_agreement` como alternativa ativa por padrão. Criar um
   argumento como:

```text
allow_no_agreement = FALSE
```

Se `allow_no_agreement = TRUE`, o script deve registrar que está assumindo
no-proposal ou rejeição terminal implementável.

5. Se o script continuar reivindicando o caso regular, `assert_check()` deve
   exigir as condições regulares relevantes, incluindo:

```text
raw_tau0 >= 0
raw_tau1 >= raw_tau0
a1 <= ybar
a0 <= V0
a1 <= V1
```

6. Calcular continuation values de H por pacote, não por atalho fixo:

```text
H_accept(theta, y) = y + btheta
H_reject(theta) = dtheta
```

7. Representar empates como empates. Quando `pooling` e `low_only` empatam, o
   script deve retornar intervalo ou conjunto para `C_H_low`, não um valor único.

8. Separar no output:

```text
proposer_value
representative_weak_value
selected_package_set
protocol_flags
```

9. O script pode continuar servindo como smoke test da calibração OPEC, mas não
   deve ser descrito como verificador geral de R2 até incorporar os thresholds
   efetivos e os flags protocolares.

## Decisão para integração

**Mudar agora no Rmd:**

- Rebaixar R2 de `proved` para `PENDING: conditional derivation`.
- Introduzir `raw_tau_theta` e `a_theta = max(0, d_theta - b_theta)`.
- Usar `a0` e `a1` nas fórmulas gerais de payoff, cutoff e continuation values.
- Escrever a fórmula com `tau` apenas como subcaso regular.
- Trocar os continuation values de low H para `a0 + b0` e `a1 + b0`, com
  correspondência no cutoff.
- Remover qualquer linguagem que faça R1 parecer pronto para usar R2 como valor
  único.

**Manter:**

- `pi_H = 0` no baseline.
- Pacotes `y` sempre factíveis em todos os estados.
- Custo one-for-one para weak states como primitivo reduzido.
- Distinção entre recognized-proposer value e representative weak value.
- Proibição de importar feasibility/C-B-R ou branch labels antigos.

**Marcar como pending protocol decision:**

- H aceitar ou rejeitar quando indiferente no threshold.
- Weak voters aceitarem ofertas exatamente iguais à continuation value.
- Existência de no-proposal/no-agreement como ação primitiva quando ela for
  payoff-relevante.
- Seleção entre low-only e pooling no cutoff.
- Uso de `C_H2_U(theta, mu')` como valor único em R1.

**Mudar no script:**

- Computar thresholds efetivos `a0` e `a1`.
- Tornar no-agreement opcional e protocolado.
- Calcular payoffs de H diretamente por pacote.
- Reportar conjuntos/correspondências em empates.
- Fazer `assert_check()` distinguir "subcaso regular testado" de "teorema geral".

## Veredito principal

Não existe PASS sem ressalvas para R2 unanimity como teorema completo. O núcleo
algébrico passa condicionalmente no subcaso regular, mas a formulação geral deve
usar thresholds efetivos e o resultado agregado deve permanecer PENDING até que
as decisões de protocolo sejam declaradas e uma nova verificação passe sem
ressalvas.
