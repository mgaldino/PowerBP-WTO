# Auditoria clean-room de resíduos da arquitetura antiga

Data: 2026-05-11

Escopo: auditoria conceitual, notacional e algébrica do redesign `relative-package`.
Não editei o manuscrito, o Rmd de derivação, scripts, nem relatórios existentes.
Este relatório é o único arquivo escrito nesta tarefa.

## Q&A inicial

**Qual é o objetivo imediato?**  
Identificar resíduos da arquitetura antiga que ainda contaminam a derivação
`relative-package`, especialmente em R2.

**Qual é a decisão substantiva que orienta esta auditoria?**  
No redesign atual, o bolo disponível para weak states deve ser fixo e conhecido.
A informação privada deve afetar o threshold de participação de `H`, não o
tamanho do bolo, salvo declaração explícita em contrário.

**Qual é o veredito geral?**  
R2 não deve permanecer marcado como provado. A derivação ativa ainda carrega
`r`, `V(theta)`, `V_e(mu)`, `V0` e `V1` no payoff de W e no cutoff. Isso é o
principal resíduo da arquitetura antiga.

## Achados

### CRITICAL 1: `r`, `V(theta)` e `V_e(mu)` ainda determinam o payoff de W em R2

Local:

- `model_redesign/power_architecture_derivations.Rmd:108-118`
- `model_redesign/power_architecture_derivations.Rmd:225-230`
- `model_redesign/power_architecture_derivations.Rmd:330-334`
- `model_redesign/power_architecture_derivations.Rmd:350-357`
- `model_redesign/power_architecture_derivations.Rmd:363-372`
- `model_redesign/power_architecture_derivations.Rmd:391-403`
- `model_redesign/power_architecture_derivations.Rmd:512`

Problema:

O documento ainda define:

```text
V(0) = 1
V(1) = r
V_e(mu) = 1 + mu * (r - 1)
```

e usa:

```text
weak coalition surplus = V(theta) - y
pooling payoff = V_e(mu) - tau1
low-only payoff = (1 - mu) * (1 - tau0)
mu2_star = (tau1 - tau0) / (r - tau0)
```

Isso reintroduz a lógica antiga em que a incerteza sobre o tipo de `H` também
move o tamanho do bolo. No redesign atual, a incerteza deve operar pelo
threshold de participação de `H`: `tau1 > tau0`. Se o bolo é fixo e conhecido,
`r` não deve entrar no payoff de W nem no cutoff de R2.

Correção recomendada:

Definir um bolo fixo conhecido para weak states, por exemplo:

```text
S = 1
weak coalition surplus after accepted package y = S - y
```

Então, em R2:

```text
pooling payoff = S - tau1
low-only payoff = (1 - mu) * (S - tau0)
mu2_star = (tau1 - tau0) / (S - tau0)
```

Com a normalização `S = 1`:

```text
pooling payoff = 1 - tau1
low-only payoff = (1 - mu) * (1 - tau0)
mu2_star = (tau1 - tau0) / (1 - tau0)
```

Manter `mu` é correto: ele mede a probabilidade de o pacote low-only ser
rejeitado pelo tipo alto. O que deve sair é `mu` como componente do tamanho
esperado do bolo.

### CRITICAL 2: o script ativo de R2 verifica a arquitetura errada

Local:

- `scripts/verify_relative_package_R2_piH0.R:12-32`
- `scripts/verify_relative_package_R2_piH0.R:48-50`
- `scripts/verify_relative_package_R2_piH0.R:57`
- `scripts/verify_relative_package_R2_piH0.R:68-70`
- `scripts/verify_relative_package_R2_piH0.R:146-158`
- `scripts/verify_relative_package_R2_piH0.R:168`

Problema:

O script `verify_relative_package_R2_piH0.R` ainda recebe `r`, impõe `r > 1`,
define `V0 <- 1`, `V1 <- r`, constrói `Ve(mu)`, e calcula:

```text
pooling_payoff = Ve(mu) - tau1
low_only_payoff = (1 - mu) * (V0 - tau0)
mu2_star = (tau1 - tau0) / (V1 - tau0)
```

Esse script está verificando a versão em que o bolo depende do estado. Portanto,
o fato de ele passar não valida a arquitetura fixed-pie.

Correção recomendada:

Substituir os argumentos `r`, `V0`, `V1` e `Ve` por um único parâmetro de bolo
fixo conhecido, por exemplo `S = 1`. O script deve testar:

```text
0 <= tau0 < tau1 <= min(ybar, S)
pooling_payoff = S - tau1
low_only_payoff = (1 - mu) * (S - tau0)
mu2_star = (tau1 - tau0) / (S - tau0)
```

O output também deve remover a coluna `V_e`.

### CRITICAL 3: status `proved` de R2 é prematuro

Local:

- `model_redesign/power_architecture_derivations.Rmd:452-455`
- `model_redesign/power_architecture_derivations.Rmd:503-517`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:52-56`

Problema:

O Rmd marca R2 como:

```text
Status: proved for terminal Round 2...
```

e o ledger registra R2 como:

```text
Proved under stated baseline protocol; checked numerically
```

Mas a prova usa payoff de W dependente de `V(theta)` e `V_e(mu)`. Se o bolo deve
ser fixo e conhecido, a prova atual resolve outro modelo. O relatório de
fechamento também afirma que "R2 is now closed", o que fica incorreto depois da
correção do primitivo.

Correção recomendada:

Rebaixar R2 para:

```text
PENDING: core protocol decisions adopted, but R2 must be rederived under fixed known weak-state surplus.
```

Só promover para `proved` depois de substituir a álgebra e rodar um script
fixed-pie.

### MAJOR 1: o ledger está inconsistente entre documentos

Local:

- `quality_reports/2026-05-11_relative_package_reimplementation.md:5`
- `quality_reports/2026-05-11_relative_package_threshold_normalization.md:43-53`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:5`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:52-56`
- `model_redesign/power_architecture_derivations.Rmd:512-513`

Problema:

O relatório de reimplementação diz que as derivações estão pendentes. O relatório
de normalização ainda lista R2 como pendente por decisões protocolares. Depois,
o relatório de closure e o Rmd promovem R2 para fechado/provado. Após a decisão
de fixed-pie, essa promoção deve ser revertida.

Correção recomendada:

Atualizar o ledger canônico no Rmd para separar:

```text
Protocol decisions for R2: adopted.
R2 algebra under state-dependent pie: rejected/superseded.
R2 algebra under fixed known pie: pending.
```

### MAJOR 2: regularidade `tau1 <= r` é resíduo de bolo estado-dependente

Local:

- `model_redesign/power_architecture_derivations.Rmd:330-340`
- `model_redesign/power_architecture_derivations.Rmd:406`
- `scripts/verify_relative_package_R2_piH0.R:69-70`

Problema:

A condição:

```text
tau0 <= 1
tau1 <= r
```

faz sentido quando o payoff residual de W é `V(theta) - y`, com `V(1) = r`.
No modelo fixed-pie, a condição relevante não pode depender de `r`.

Correção recomendada:

Usar:

```text
0 <= tau0 < tau1 <= ybar
tau1 <= S
```

ou, de forma mais compacta:

```text
0 <= tau0 < tau1 <= min(ybar, S)
```

Se `S = 1`, isso vira:

```text
0 <= tau0 < tau1 <= min(ybar, 1)
```

### MAJOR 3: linguagem de R1 usa R2 antes de corrigir os primitivos

Local:

- `model_redesign/power_architecture_derivations.Rmd:436-450`
- `model_redesign/power_architecture_derivations.Rmd:463-473`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:52-56`

Problema:

O Rmd diz que os thresholds de R1 "to be used in the next proof pass" já foram
produzidos por R2, e a seção R1 começa com "Using the R2 continuation values".
Isso cria risco de transportar para R1 uma continuação derivada com o payoff
errado de W.

Correção recomendada:

Bloquear R1 até R2 ser rederivado sob fixed-pie. Substituir a linguagem por:

```text
R1 is blocked until terminal R2 is rederived under fixed known weak-state surplus.
Do not use the state-dependent-pie R2 continuation values.
```

### MAJOR 4: no-agreement/no-proposal ainda aparece como candidato sem primitivo completo

Local:

- `quality_reports/2026-05-11_relative_package_reimplementation.md:180-185`
- `model_redesign/power_architecture_derivations.Rmd:384-389`
- `model_redesign/power_architecture_derivations.Rmd:468-471`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:19-22`
- `quality_reports/2026-05-11_relative_package_threshold_normalization.md:45-50`

Problema:

Há duas coisas diferentes sendo misturadas:

1. ausência de proposta como ação primitiva do proposer;
2. proposta deliberadamente rejeitada que induz continuação ou desacordo.

Em R2, a opção pode ser redundante se `tau1 <= S`, pois low-only e pooling dão
payoffs não negativos relevantes. Em R1, porém, "no-information rejection or
continuation" aparece como candidato sem protocolo completo. Isso pode virar uma
forma disfarçada de impor delay/rejection path.

Correção recomendada:

No baseline, declarar:

```text
There is no primitive no-proposal action.
Continuation occurs only after an actual proposal is rejected.
Any deliberate rejection branch must specify the proposal, voting behavior, and Bayesian posterior.
```

Se a opção de não proposta for desejada, ela deve ser adicionada como primitivo
explícito antes da prova, não dentro da derivação.

### MAJOR 5: scripts antigos continuam perigosos porque parecem "baseline" ou "current"

Local:

- `scripts/verify_baseline_unanimity_R2_piH0.R:3-24`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R:3-5`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R:13-30`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R:203-238`
- `scripts/verify_sufficient_conditions_lower_bound.R:3-22`
- `scripts/verify_calibrated_nesting_upper_bound.R:3-24`

Problema:

Esses scripts ainda verificam a arquitetura antiga: `alpha * r`, `Ve(mu)`,
strict BF feasibility, C-B-R, branch `B`, e/ou bolo estado-dependente. Isso é
aceitável como histórico, mas perigoso em `scripts/` com nomes como
`baseline`, `current characterization` ou sem prefixo de arquivo arquivado.

Correção recomendada:

Não usar esses scripts para o redesign. Em uma rodada posterior, adicionar
cabeçalhos muito explícitos, por exemplo:

```text
ARCHIVED / DO NOT USE FOR RELATIVE-PACKAGE REDESIGN
```

ou mover para uma pasta de arquivo. Para a arquitetura nova, usar apenas scripts
com prefixo `verify_relative_package_*` depois que forem corrigidos para
fixed-pie.

### MAJOR 6: resíduos de feasibility/C-B-R existem nos scripts, mas não são a fonte principal do erro atual

Local:

- `model_redesign/README.md:38-40`
- `quality_reports/2026-05-11_relative_package_reimplementation.md:9-20`
- `quality_reports/2026-05-11_relative_package_reimplementation.md:188-196`
- `model_redesign/power_architecture_derivations.Rmd:491`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R:3-5`
- `scripts/verify_unanimity_R1_C_B_R_piH0.R:99-125`

Problema:

O Rmd ativo não parece reaproveitar diretamente os rótulos C-B-R como teorema
atual, o que é bom. Porém os scripts C-B-R continuam vivos e alguns relatórios
ainda falam que a álgebra C-B-R é "useful as diagnostic history". O risco é
menor que o erro `r/Ve`, mas ainda real: a branch `B` e a lógica de feasibility
high-state-only podem voltar por atalho computacional.

Correção recomendada:

Manter C-B-R apenas como histórico. No ledger do redesign, registrar:

```text
C-B-R / branch B: rejected for current architecture; diagnostic only.
```

e impedir que qualquer resultado `relative-package` cite esses scripts.

### MAJOR 7: resíduos de H-proposer/random-proposer estão fora do Rmd ativo, mas ainda no ambiente de trabalho

Local:

- `AGENTS.md:23-24`
- `AGENTS.md:27-43`
- `AGENTS.md:284-287`
- `scripts/generate_h_proposer_appendix_packet.R:7-10`
- `scripts/generate_h_proposer_appendix_packet.R:93-108`
- `quality_reports/2026-05-10_power_architecture_piH.md:76-85`

Problema:

O Rmd ativo está correto ao declarar `pi_H = 0` em ambos os rounds
(`model_redesign/power_architecture_derivations.Rmd:74-76` e
`model_redesign/power_architecture_derivations.Rmd:259-267`). Entretanto, o repo
ainda contém scripts e relatórios que extraem ou analisam o ramo H-proposer do
manuscrito antigo. Isso é histórico útil, mas não deve alimentar o baseline
relative-package.

Correção recomendada:

No redesign, manter:

```text
H proposer / random proposer: extension only, not baseline.
```

Qualquer script que leia `formal_model_v5.Rmd` para gerar pacote H-proposer deve
ser tratado como ferramenta histórica, não como verificação do modelo novo.

### MAJOR 8: `model_redesign/verified_baseline_piH0_external_packet.md` parece material corrente, mas é arquitetura antiga

Local:

- `model_redesign/verified_baseline_piH0_external_packet.md:47`
- `model_redesign/verified_baseline_piH0_external_packet.md:53`
- `model_redesign/verified_baseline_piH0_external_packet.md:113`
- `model_redesign/verified_baseline_piH0_external_packet.md:144`

Problema:

Mesmo dentro de `model_redesign/`, há um arquivo chamado `verified_baseline`
com `V(0)=1`, `V(1)=r`, `V_e(mu)`, `alpha r` e resultados da arquitetura
anterior. O nome sugere que ele pode ser atual, mas o conteúdo é incompatível
com fixed-pie relative-package.

Correção recomendada:

Em rodada posterior, renomear ou marcar como arquivado. No relatório atual de
redesign, não citar esse arquivo como fonte de prova.

### MINOR 1: notação `P_2` pode confundir pooling com proposer value

Local:

- `model_redesign/power_architecture_derivations.Rmd:350-372`

Problema:

O texto usa `P_2(mu)` para o payoff do pacote pooling e depois
`P_{2,prop}^U(mu)` para valor do proposer. A notação é auditável, mas propensa
a erro porque `P` pode significar "pooling" ou "proposer".

Correção recomendada:

Usar nomes textuais no Rmd e no script:

```text
payoff_pooling(mu)
payoff_low_only(mu)
proposer_value_R2(mu)
```

### MINOR 2: o texto ainda fala em "regular domain" de modo que lembra restrição de factibilidade antiga

Local:

- `model_redesign/power_architecture_derivations.Rmd:330-340`
- `model_redesign/power_architecture_derivations.Rmd:384-389`
- `quality_reports/2026-05-11_relative_package_R2_protocol_closure.md:19-22`

Problema:

"Regular domain" é defensável, mas no contexto deste projeto pode ser lido como
nova versão da restrição de factibilidade por estado. O problema não é o termo
em si; é a combinação com `tau1 <= r`.

Correção recomendada:

Trocar por:

```text
fixed-surplus nonnegative-residual domain
```

e definir tudo com `S`, não com `r`.

## Correção clean-room mínima sugerida para R2

Para recomeçar sem resíduos:

```text
S = fixed known surplus available to the weak coalition, normalized to 1.
tau_theta = d_theta - b_theta.
0 <= tau0 < tau1 <= min(ybar, S).
H accepts y iff y >= tau_theta.
Weak voters accept continuation-value offers by BF convention.
If W is indifferent across payoff-maximizing proposals, W chooses the proposal
that minimizes H's expected payoff.
```

R2:

```text
payoff_pooling(mu) = S - tau1
payoff_low_only(mu) = (1 - mu) * (S - tau0)
mu2_star = (tau1 - tau0) / (S - tau0)
```

Equilibrium choice:

```text
if mu <= mu2_star: low-only
if mu > mu2_star: pooling
```

H continuation:

```text
C_H2_high(mu) = d1
C_H2_low(mu) = d0                    if mu <= mu2_star
C_H2_low(mu) = d0 + tau1 - tau0      if mu > mu2_star
```

Com `S = 1`, basta substituir `S` por `1`. Nenhum desses objetos requer `r`,
`V(theta)`, `V_e(mu)`, `V0` ou `V1`.

## Prioridade de correção

1. Rebaixar R2 de `proved` para `pending fixed-pie rederivation`.
2. Remover `V(theta)`, `V_e(mu)` e `r` dos primitivos de payoff fraco no Rmd.
3. Corrigir `scripts/verify_relative_package_R2_piH0.R` para usar `S`.
4. Só depois retomar R1.
5. Quarentenar scripts antigos para impedir reuso acidental.

## Veredito final

O redesign relative-package está conceitualmente na direção correta, mas a
derivação ativa de R2 ainda resolve uma versão híbrida: pacote relativo com
thresholds de `H`, mas payoff de W herdado do modelo antigo de bolo
estado-dependente. Esse híbrido deve ser tratado como rejeitado/superseded, não
como prova condicional.
