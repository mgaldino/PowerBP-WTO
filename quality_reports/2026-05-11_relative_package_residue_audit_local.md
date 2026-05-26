# Auditoria local de resíduos da arquitetura antiga

Data: 2026-05-11

Status: auditoria local, antes da correção dos arquivos. Não é uma prova.

## Veredito curto

Há resíduo crítico da arquitetura antiga no redesign: o documento de derivação
e o script de R2 ainda deixam a crença sobre o tipo de `H` alterar o tamanho do
bolo disponível para weak states. Isso aparece como `r`, `V(theta)`, `V_e(mu)`,
`V0` e `V1`.

Na arquitetura relative-package que queremos agora, o bolo institucional em R2
deve ser fixo e conhecido. A informação privada deve entrar pelo threshold de
participação de `H`, não pelo tamanho do surplus fraco.

## Achados críticos

### CRITICAL 1: `r` e `V_e(mu)` ainda determinam o payoff de W em R2

Arquivos:

- `model_redesign/power_architecture_derivations.Rmd:111`
- `model_redesign/power_architecture_derivations.Rmd:117`
- `model_redesign/power_architecture_derivations.Rmd:353`
- `model_redesign/power_architecture_derivations.Rmd:369`
- `model_redesign/power_architecture_derivations.Rmd:394`
- `model_redesign/power_architecture_derivations.Rmd:402`
- `model_redesign/power_architecture_derivations.Rmd:512`

Problema:

O texto ainda define:

```text
V(0) = 1
V(1) = r
V_e(mu) = 1 + mu * (r - 1)
```

e usa:

```text
pooling payoff = V_e(mu) - tau1
mu2_star = (tau1 - tau0) / (r - tau0)
```

Isso é incompatível com a leitura nova: em R2 o bolo é fixo e conhecido. O tipo
privado de `H` afeta apenas o threshold `tau_theta`.

Correção recomendada:

Normalizar o bolo fixo como:

```text
B = 1
```

Então:

```text
pooling payoff = 1 - tau1
low-only payoff = (1 - mu) * (1 - tau0)
mu2_star = (tau1 - tau0) / (1 - tau0)
```

com domínio:

```text
0 <= tau0 < tau1 <= 1
```

Se o texto quiser manter um bolo fixo não normalizado:

```text
B > 0
pooling payoff = B - tau1
low-only payoff = (1 - mu) * (B - tau0)
mu2_star = (tau1 - tau0) / (B - tau0)
```

Depois normaliza `B = 1`.

### CRITICAL 2: weak-state payoff ainda usa `V(theta) - y`

Arquivos:

- `model_redesign/power_architecture_derivations.Rmd:229`
- `model_redesign/power_architecture_derivations.Rmd:245`
- `model_redesign/power_architecture_derivations.Rmd:253`

Problema:

O payoff fraco ainda está escrito como:

```text
weak coalition surplus after accepted package y = V(theta) - y
u_i(y, theta; c_W) = V(theta) - y - (m - 1)c_W
```

Isso reintroduz variação do bolo por estado. Sob a nova arquitetura, deve ser:

```text
weak coalition surplus after accepted package y = 1 - y
u_i(y; c_W) = 1 - y - (m - 1)c_W
```

ou, antes da normalização:

```text
B - y
```

### CRITICAL 3: script R2 verifica o modelo errado

Arquivo:

- `scripts/verify_relative_package_R2_piH0.R`

Linhas relevantes:

- `17`: exige `r > 1`
- `25-29`: define `V0 = 1`, `V1 = r`, `Ve(mu)`
- `31`: usa `pooling_payoff = Ve(mu) - tau1`
- `48`: usa `mu2_star = (tau1 - tau0) / (V1 - tau0)`
- `148-153`: calibração usa `r = 1.5`, `d1 = 0.19 * 1.5`, `ybar = 1.5`

Problema:

Esse script ainda testa a arquitetura com bolo state-dependent. Ele não testa o
modelo de bolo fixo.

Correção recomendada:

Trocar o argumento `r` por `B = 1`, ou remover o argumento se a normalização for
fixa. O script deve verificar:

```text
pooling_payoff = 1 - tau1
low_only_payoff = (1 - mu) * (1 - tau0)
mu2_star = (tau1 - tau0) / (1 - tau0)
```

e exigir:

```text
0 <= tau0 < tau1 <= ybar
tau1 <= 1
```

### CRITICAL 4: status "proved" ficou prematuro porque prova o objeto errado

Arquivos:

- `model_redesign/power_architecture_derivations.Rmd:452`
- `model_redesign/power_architecture_derivations.Rmd:512`

Problema:

O Rmd marca R2 como provado sob o baseline, mas esse resultado foi provado para
um payoff fraco com bolo state-dependent. Depois da correção para bolo fixo, a
prova e o script precisam ser reexecutados.

Correção recomendada:

Rebaixar temporariamente R2 para:

```text
Pending correction: old state-dependent surplus residue removed; fixed-pie R2
needs rewritten proof and verification.
```

Depois de corrigir e rodar o script, promover novamente se passar.

## Achados maiores

### MAJOR 1: relatórios de agentes recentes agora estão parcialmente superados

Arquivos:

- `quality_reports/2026-05-11_relative_package_R2_candidate_audit.md`
- `quality_reports/2026-05-11_relative_package_R2_cleanroom_derivation.md`
- `quality_reports/2026-05-11_relative_package_R2_comparison_review.md`

Problema:

Esses relatórios ainda auditam uma formulação que permitia `V0`, `V1`, `r` ou
`V_e(mu)` no payoff fraco. Eles são úteis como histórico, mas não devem ser
tratados como validação do novo fixed-pie R2.

Correção recomendada:

Criar uma nova rodada de auditoria depois da correção fixed-pie, ou marcar
esses relatórios como superseded for fixed-pie R2.

### MAJOR 2: arquivos antigos em `scripts/verify_baseline_*` e C-B-R continuam perigosos

Arquivos:

- `scripts/verify_baseline_unanimity_R2_piH0.R`
- `scripts/verify_baseline_unanimity_R1_piH0.R`
- `scripts/verify_baseline_majority_piH0.R`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R`
- `scripts/verify_unanimity_R1_C_or_R_piH0.R`
- vários scripts `verify_baseline_*`

Problema:

Esses scripts ainda usam `r`, `alpha`, `Ve(mu)`, feasibility e, em alguns
casos, C-B-R. Eles são histórico, mas o nome `baseline` pode induzir reuso
acidental.

Correção recomendada:

Não apagar agora, mas criar uma nota no Rmd e README dizendo que somente scripts
`verify_relative_package_*` são válidos para a arquitetura atual. Idealmente,
mover scripts antigos para uma pasta `scripts/archive/` em etapa separada, se o
usuário aprovar.

### MAJOR 3: `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md`
também precisa revisão fixed-pie

Problema:

O relatório de fechamento de protocolo está correto sobre tie-breaking, mas foi
escrito antes da correção do bolo fixo. Ele deve ser complementado com:

```text
R2 fixed-pie correction: no r, no V_e(mu), no state-dependent weak surplus.
```

## Achados menores

### MINOR 1: linguagem "state affects payoffs" pode ficar ambígua

Arquivo:

- `quality_reports/2026-05-11_relative_package_reimplementation.md:55`

Problema:

O texto diz que o estado afeta payoffs, não physical feasibility. Isso é
verdadeiro para `H`, mas agora pode ser lido como se afetasse também o bolo de
W.

Correção recomendada:

Precisar:

```text
The state affects H's participation threshold, not the size of the fixed weak
coalition surplus in the baseline R2 model.
```

## Correção mínima recomendada

1. Reescrever os primitivos no Rmd:

```text
Fixed institutional surplus B = 1.
theta affects H's threshold tau_theta, not the weak coalition pie.
```

2. Reescrever weak payoff:

```text
weak coalition surplus = 1 - y
```

3. Reescrever R2:

```text
low-only: (1 - mu) * (1 - tau0)
pooling: 1 - tau1
mu2_star = (tau1 - tau0) / (1 - tau0)
```

4. Reescrever o script `verify_relative_package_R2_piH0.R`.

5. Rodar script e renderizar Rmd.

6. Só depois restaurar status "proved" para R2.

## Próxima auditoria necessária

Depois de corrigir R2 para fixed-pie, auditar R1 do zero. A principal pergunta
será: se R1 rejection gera R2 com posterior atualizado, como a estratégia de
R1 determina o posterior sem impor crença off-path?
