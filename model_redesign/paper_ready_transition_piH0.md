# Transição paper-ready da arquitetura fixed-pie relative-package pi_H=0

Data: 2026-05-14

Escopo: preparar o transporte da arquitetura `fixed-pie relative-package` com
`pi_H=0` para o manuscrito principal, sem editar `formal_model_v5.Rmd`.

Regra de trabalho: este documento trata `formal_model_v5.Rmd` apenas como alvo
futuro de substituição. A arquitetura antiga baseada em `V_e`, `r`, `alpha`,
state-dependent pie, proposer aleatório com `H` agenda setter, ou branch labels
da feasibility branch não deve ser transportada.

## 0. Protocolo de certificação de provas

Nenhuma prova nova deve ser marcada como aprovada apenas por derivação local ou
por checagem computacional. O protocolo correto para este projeto é:

1. Formular a prova localmente como `draft`.
2. Enviar a prova completa a dois revisores independentes:
   - um revisor matemático, focado em validade lógica, desigualdades, casos de
     borda e exaustão;
   - um revisor de teoria dos jogos, focado em estratégias, crenças,
     racionalidade sequencial, desvios, pivotalidade e consistência de PBE.
3. Promover a prova para `approved/proved` somente se os dois revisores passarem
   sem ressalvas substantivas.
4. Se qualquer revisor apontar falha substantiva, revisar a prova e repetir a
   rodada com os dois revisores. Responder ao revisor não basta; a nova versão
   precisa passar.

Status desta rodada: a tentativa de substituir `selected pure-threshold PBE` por
uma caracterização geral de `pure-strategy PBE outcomes` **não passou**. Os dois
revisores independentes apontaram a mesma falha substantiva: sob PBE padrão,
crenças após desvios off-path de weak voters não são pinadas por Bayes, e isso
impede a caracterização global sem uma restrição/refinamento adicional de
crenças e votação.

Decisão posterior: o baseline seguirá com `passive-belief pure-strategy PBE`.
Esse é o conceito de solução do modelo principal. O paper não afirmará uma
caracterização global de todos os PBEs puros sob crenças off-path arbitrárias.

## 1. Inventário do estado atual

### Primitivos adotados

| Objeto | Status | Evidência | Uso no paper |
|---|---|---|---|
| Pacotes institucionais relativos | Adotado | `model_redesign/power_architecture_derivations.Rmd` | Definição central do novo modelo |
| Excedente fraco fixo | Adotado | Excedente da coalizão fraca normalizado para `1`; custo de `y` é um-para-um | Substitui state-dependent pie |
| Threshold líquido de `H` | Recomendado para o corpo | `H` aceita se `y >= t_theta` | Define screening diretamente, sem carregar `b_theta` no texto principal |
| Equivalência com benefício direto | Apenas apêndice, se necessário | `t_theta = d_theta - b_theta` | Mostra que a versão com `U_H(y, theta) = y + b_theta` é uma reparametrização |
| Domínio de screening | Suficiente | `0 <= tau0 < tau1 <= ybar <= 1` | Garante que o tipo alto exige pacote maior |
| Agenda power | Adotado | `pi_H=0` em ambas as rodadas | Isola pivotalidade informacional de proposal power |
| Reconhecimento | Adotado | Somente weak states podem propor no baseline | `H` é pivotal sob unanimidade, mas não é agenda setter |
| Votação | Adotado | Votação simultânea pública; propositor conta como sim; votos revelados | Evita suprimir artificialmente o voto de `H` |
| Tie-breaking | Adotado | Jogadores aceitam quando indiferentes; propositor fraco, se indiferente, escolhe a opção que minimiza payoff esperado de `H` | Conservador para a tese de renda informacional |

### Resultados provados ou derivados

| Resultado | Status | Conteúdo | Restrição |
|---|---|---|---|
| R2 unanimity | Provado | Propositor fraco escolhe low-only para `mu <= mu2_star` e pooling para `mu > mu2_star`, com `mu2_star = (tau1 - tau0)/(1 - tau0)` | Domínio `0 <= tau0 < tau1 <= ybar <= 1` |
| R1 unanimity | Provado sob passive-belief PBE | Candidatos puros relevantes são pooling, low-only e rejection/continuation dentro da avaliação de votação e crenças passivas adotada | Não é uma caracterização de todo PBE padrão irrestrito |
| Ballots rejeitados informativos | Payoff upper bound aprovado localmente, não caracterização global | Rejeições informativas não adicionam payoff estritamente melhor que continuation sem informação quando os ICs de `H` são impostos | Pode haver outcomes informativos payoff-equivalentes em fronteiras; não elimina patologias de votação off-path |
| Majority no-screening | Derivado | Majority tem caminho uniforme sem `H`, sem screening, se, e somente se, `a0_M >= beta/m` no domínio de limiares | Se `a0_M < beta/m`, `H` pode ser parceiro barato e majority-screening vira extensão separada |
| Entry/nesting fraco | Provado sob passive-belief PBE | Sob no-cheap-`H`, `W_U(mu) <= W_M(mu) = 1/m`; logo `F_U(chi) subset F_M(chi)` | Usa o valor de R1 unanimity sob passive beliefs, não uma correspondência global de PBE padrão |
| Comparação condicional para `H` | Provado como comparação de sinal | Em beliefs onde ambas as regras formam, `H` prefere unanimidade se o gap `H_U(mu) - H_M(mu)` é positivo, maioria se negativo, indiferença se zero | Não é uma dominância global de unanimidade |
| Classificação institucional | Provada | Cinco categorias exaustivas: nenhuma regra forma; só majority forma; ambas formam e `H` prefere unanimity; ambas formam e `H` é indiferente; ambas formam e `H` prefere majority | Depende de nesting e da comparação de sinal |

### Verificação por scripts

Todos os scripts abaixo foram rodados nesta sessão e passaram. Os avisos
observados foram apenas de locale do R na inicialização.

| Script | O que verifica | Resultado relevante |
|---|---|---|
| `scripts/verify_relative_package_R2_piH0.R` | R2 unanimity | `mu2_star = 0.117283950617` no caso de trabalho |
| `scripts/verify_relative_package_R1_piH0.R` | R1 unanimity, ICs, valores candidatos, tie-break | Caso de trabalho seleciona pooling em todo `mu`; casos diagnósticos incluem rejection e low-only |
| `scripts/verify_relative_package_majority_piH0.R` | Majority no-screening | No caso de trabalho, `a0_M = 0.171 >= c_M = 0.075`; pacote sem `H` selecionado para todo `mu` |
| `scripts/verify_relative_package_entry_nesting_piH0.R` | Entry/nesting e gap de `H` | No caso de trabalho, `W_M = 0.0833333`, `W_U = 0.0619583`, gap mínimo `0.021375` |
| `scripts/verify_relative_package_classification_piH0.R` | Classificação completa e ties | Todas as categorias batem com as definições; ties de entry e de preferência de `H` são separados |

Importante: esses scripts verificam identidades, condições de domínio,
comparações de candidatos e classificações sob o protocolo já especificado.
Eles não certificam, por si só, uma caracterização global de todos os PBEs puros
sob crenças off-path arbitrárias.

### Resultado calibrado de trabalho

Calibração de trabalho:

```text
N = 13
m = 12
beta = 0.9
d0 = 0.19
d1 = 0.285
b0 = 0
b1 = 0
ybar = 1
```

Na redação paper-ready, esses valores devem aparecer como thresholds líquidos:

```text
t0 = d0 - b0 = 0.19
t1 = d1 - b1 = 0.285
```

Como `b0=b1=0` na calibração atual, retirar `b_theta` do corpo principal não
altera nenhum número nem resultado.

Valores-chave:

```text
tau0 = 0.19
tau1 = 0.285
mu2_star = 0.117283950617
a0_high_posterior = 0.2565
a1 = 0.2565
c_M = 0.075
a0_M = 0.171
```

Classificação calibrada:

| Entrada por weak state `chi` | Resultado |
|---|---|
| `chi <= 0.0619583` | Ambas as regras formam. `H` prefere unanimity para `mu < 0.7`, é indiferente em `mu = 0.7`, e prefere majority para `mu > 0.7`. |
| `0.0619583 < chi <= 0.0833333` | Apenas majority forma. |
| `chi > 0.0833333` | Nenhuma regra forma. |

Este resultado calibrado substitui a antiga afirmação de que unanimity domina
sempre que consegue sustentar entry. Na nova arquitetura, a comparação de `H`
é uma comparação de sinal, com regiões de unanimity e majority mesmo quando
ambas as regras formam.

### Resultado de delay

O arquivo `model_redesign/r1_weak_delay_numeric_example.md` mostra um exemplo
completo de backward induction em que rejection/continuation é selecionado em
R1. Esse resultado deve entrar, no máximo, como remark, corolário ou proposição
auxiliar. Ele não deve ser apresentado como exemplo calibrado.

Uso recomendado:

- Corpo do paper: remark curto após a caracterização de R1 unanimity.
- Apêndice: exemplo numérico não calibrado, se for útil para mostrar que delay
  não é artefato de protocolo.
- Literatura: uma nota de rodapé ou parágrafo conectando o mecanismo a
  bargaining com informação privada e delay. A contribuição deve continuar
  institucional: unanimity cria o problema de screening ao tornar `H` pivotal;
  majority pode removê-lo ao permitir exclusão.

### Resultados suficientes

As condições suficientes que sustentam a arquitetura paper-ready, no sentido
selecionado/refinado já implementado, são:

```text
0 <= tau0 < tau1 <= ybar <= 1
0 <= a0_high_posterior <= a1 <= ybar
beta <= 1
a0_M >= beta/m
```

Interpretação:

- As duas primeiras condições mantêm a ordem de thresholds e a classe de
  screening do baseline.
- `a0_M >= beta/m` é a condição no-cheap-`H`: impede que majority inclua `H`
  como parceiro de coalizão mais barato que um weak voter.
- Com essas condições, majority é o benchmark sem screening; unanimity gera o
  problema de participação privada; entry under unanimity é nested em majority.
- Para uma caracterização geral de PBE puro padrão, essas condições não bastam.
  É necessário acrescentar uma restrição/refinamento de crenças e votação, ou
  manter o claim como resultado selecionado.

### Pendências

| Pendência | Importância | Decisão para o paper agora |
|---|---|---|
| Caracterização geral de PBE puro padrão | Alta | Não afirmar; falhou na revisão independente por causa de crenças off-path e votação weak |
| Unicidade global fora da classe selected/refined pure-threshold | Alta para claims fortes de equilíbrio único | Não afirmar unicidade global |
| Refinamento de crenças e votação | Resolvida como decisão de baseline | Adotar `passive-belief pure-strategy PBE`; defender crenças passivas após desvios de weak voters e weak acceptance no Model/Appendix |
| Equilíbrios mistos ou semi-pooling fora da seleção | Média | Fora do escopo; não é preciso provar inexistência, mas o texto deve dizer que o paper assume estratégias puras |
| Tie-breaking alternativo do propositor | Média | Documentar em appendix; baseline conservador minimiza payoff de `H`; sem tie-break, o resultado vira correspondência de candidatos empatados |
| Extensão `pi_H > 0` | Alta, mas separada | Não misturar no baseline; tratar como extensão futura |
| Caso `a0_M < beta/m` | Alta para escopo | Tratar como majority-screening extension, não baseline |
| Continuous types | Média | Remover ou marcar pending até rederivar sob fixed-pie |
| Figuras antigas | Alta | Recomputar; não reaproveitar figuras com `V_e`, `r`, `alpha` |
| Bibliografia de delay | Média | Converter notas para BibTeX antes de migrar |
| Auditoria externa final | Alta | Rodar verificação independente antes de editar `formal_model_v5.Rmd` |

## 2. Rodada atual de revisão dos lemas de R1 unanimity

Objetivo da rodada: testar se seria possível substituir `selected
pure-threshold PBE` por uma caracterização mais geral de outcomes em estratégias
puras. A resposta desta rodada é **não, não sob PBE padrão sem refinamento
adicional**.

### Resultado dos revisores independentes

| Revisor | Foco | Veredito | Razão substantiva |
|---|---|---|---|
| Revisor matemático | Exaustão, desigualdades, fronteiras, payoffs | Fail | Os lemas de pooling e low-only dependem de crenças off-path após desvios de weak voters; PBE padrão não fixa essas crenças |
| Revisor de teoria dos jogos | Estratégias, crenças, desvios, votação, PBE | Fail | A correspondência global de PBE puro é quebrada por crenças off-path e por equilíbrios de rejeição weak em histories fora do caminho |

Conclusão: os lemas podem sustentar um resultado selecionado/refinado de
threshold puro, mas ainda não sustentam uma caracterização de todos os PBEs
puros.

### Status dos quatro lemas

| Lema | Status após revisão | Conteúdo aprovado | O que falta ou limita o resultado |
|---|---|---|---|
| Minimal pooling | Aprovado sob passive beliefs | Pooling aceito por ambos é payoff-equivalente a pagar `a1` a `H` e `c(mu)` aos weak voters | Não é claim sob PBE padrão com crenças off-path arbitrárias |
| Minimal low-only | Aprovado sob passive beliefs | Low-only usa `a0_high` e `c(0)`; low-only estrito exige `a0_high < a1`; em `mu=1`, a oferta é canônica/payoff-equivalente | Exige feasibility `a0_high + (m-1)c(0) <= 1` |
| No high-only | Aprovado | Sob a ordem de thresholds, não existe `y` que seja aceito pelo tipo alto e rejeitado pelo tipo baixo | Vale para pacote escalar e ordem de thresholds |
| Failed-ballot payoff bound | Aprovado sob passive beliefs | Ballots falhados não dão payoff estritamente acima de `c(mu)`; informative failures de fronteira são payoff-equivalentes a `R` | É um bound de payoff, não eliminação de todo outcome payoff-equivalente |

### Enunciado máximo aprovado nesta rodada

O enunciado defensável é:

```text
Under the fixed-pie relative-package pi_H=0 primitives, the R1 threshold-order
domain, weak acceptance at indifference, and the stated passive-belief voting
assessment, the selected/refined pure-threshold R1 outcomes are payoff-equivalent
to admissible candidates P, L, or R. The selected value is the maximum admissible
candidate payoff. Without the conservative proposer tie-break, payoff ties
generate multiple selected/refined pure-threshold outcomes.
```

O enunciado que **não** passou é:

```text
Every pure-strategy R1 PBE outcome under standard PBE is payoff-equivalent to P,
L, or R.
```

Para tentar esse enunciado forte em uma nova rodada, seria preciso acrescentar e
defender explicitamente uma solução refinada, por exemplo:

- crenças passivas após desvios de weak voters, pois weak voters não têm
  informação privada sobre `theta`;
- posterior determinado apenas pelo voto de `H` quando o voto de `H` é
  informativo;
- uma restrição de votação responsiva ou fracamente não dominada que evite
  equilíbrios off-path sustentados apenas por rejeições weak não-pivotais.

Essa solução refinada pode ser defensável, mas deve ser vendida como refinamento
institucional do protocolo de votação, não como consequência de PBE padrão.

Decisão adotada: seguir com essa solução refinada no baseline. O conceito deve
ser nomeado no corpo como `passive-belief pure-strategy PBE`. A justificativa
substantiva é que weak states não têm informação privada sobre `theta`; por
isso, desvios de weak voters não devem ser interpretados como sinais sobre o
tipo de `H`.

### Rodada de certificação após adoção de passive beliefs

Depois da decisão de adotar `passive-belief pure-strategy PBE`, a versão
revisada foi reenviada a dois revisores independentes. Ambos passaram sem
ressalvas substantivas.

| Revisor | Foco | Veredito | Implicação |
|---|---|---|---|
| Revisor matemático | Exaustão, desigualdades, fronteiras, payoffs | Pass | Os quatro lemas são aceitáveis quando o claim fica escopado a passive-belief pure-threshold outcomes |
| Revisor de teoria dos jogos | Estratégias, crenças, desvios, votação, PBE | Pass | A estratégia, as crenças passivas e os ICs sustentam o theorem refinado; o texto evita o overclaim sobre todo PBE padrão |

Status promovido: sob `passive-belief pure-strategy PBE`, a caracterização de
R1 unanimity por `P`, `L` e `R` está aprovada para transporte ao paper. A
caracterização global de todos os PBEs padrão continua fora do claim.

### No-cheap-H como condição de escopo

A condição `a0_M >= beta/m` deve ser apresentada como condição substantiva de
escopo:

```text
Majority removes screening only when H is not a cheaper coalition partner than
a weak voter.
```

Interpretação: em majority, o propositor fraco precisa comprar `q-1` votos
adicionais. Se comprar o tipo baixo de `H` custa menos que comprar um weak voter
em continuação, isto é, se `a0_M < beta/m`, então `H` pode ser substituto barato
para um weak voter. Nesse caso, majority não remove necessariamente o problema
de screening; ela pode recriá-lo.

Proposição de escopo para o corpo:

```text
Under 0 <= a0_M < a1_M <= ybar, the no-H majority path weakly dominates all
H-including majority proposals for every belief if and only if a0_M >= beta/m.
```

Remark/extensão para o caso fora do baseline:

```text
If a0_M < beta/m, majority may also screen H. For sufficiently low beliefs that
H is high type, a weak proposer strictly prefers buying low H as a cheap
coalition partner and letting the proposal fail when H is high. The cutoff is
mu_M_H = (beta/m - a0_M) / (1 - a0_M - (q-1)beta/m), whenever the denominator is
positive.
```

Essa extensão deve ficar fora do baseline. Ela não enfraquece o mecanismo
principal; ela delimita quando majority realmente desliga a pivotalidade
informacional de `H`.

## 3. Arquitetura condicional de transporte ao paper

### Mensagem central revisada

Texto central a transportar:

```text
Unanimity can favor a powerful privately informed actor not because it gives
him agenda power, but because it transforms his approval into an informational
constraint on weaker states.
```

Qualificação necessária:

```text
The fixed-pie pi_H=0 baseline does not prove global dominance of unanimity for
H at every belief. Under the stated refined voting and belief protocol, it gives
an exact institutional classification. Unanimity benefits H where the
pivotality-screening rent exceeds the payoff from being excluded under majority.
```

### Corpo principal

Recomendação: colocar no corpo apenas os resultados que um leitor de IR precisa
para entender o mecanismo. Provas completas e derivações de cases ficam no
apêndice.

| Parte do corpo | Conteúdo novo | Formal objects |
|---|---|---|
| Introduction | Puzzle, contribuição e claim `pi_H=0`: sem agenda power para `H`, unanimity ainda pode criar renda informacional via pivotalidade | Sem fórmulas longas |
| Literature/theory | Posicionar contra self-binding e informal power; usar delay literature apenas como suporte secundário | Sem resultado formal |
| Motivating example | Refazer como fixed-pie package example, sem `r`, `alpha`, state-dependent pie ou proposer aleatório | Um exemplo simples, não calibrado |
| Model | Definir `N`, `m`, tipos de `H`, threshold líquido `t_theta`, `y`, `ybar`, fixed weak surplus `1`, `pi_H=0`, entry coletiva, votação simultânea pública | Definition 1 |
| Majority benchmark | Mostrar que majority pode excluir `H`; no-screening requer no-cheap-`H` | Proposition 1 |
| Unanimity analysis | Definir `passive-belief pure-strategy PBE`; mostrar R2 threshold e R1 candidatos pooling, low-only e rejection sob crenças passivas | Lemma 1 e Theorem 1 |
| Entry and institutional choice | Nesting fraco, comparação de sinal para `H`, classificação de regras | Propositions 2-3, Corollary 1 |
| Calibration/illustration | Working calibration com cutoff de preferência de `H` em `mu=0.7` e entry regions | Corollary 2 ou Example 1 |
| Scope | `pi_H>0`, majority-screening when `a0_M < beta/m`, tie-breaking alternativo, delay | Remarks e texto |

### Apêndice

| Apêndice | Conteúdo | Observação |
|---|---|---|
| Appendix A. Fixed-pie relative-package derivations | R2 unanimity, R1 unanimity refinada, majority benchmark, entry/nesting, classification | Deve espelhar a ordem dos resultados do corpo |
| Appendix B. Protocol and equilibrium refinements | Votação simultânea pública, public vote vector, crenças passivas, tie-breaking, informative rejected ballots | Isolar decisões de protocolo |
| Appendix C. Computation and calibration | Parâmetros, scripts, checks, tabelas de gaps, classificação por entry cost | Incluir reproducibility ledger |
| Appendix D. Delay and private-information bargaining | Delay como remark/corolário auxiliar e nota de literatura | Não chamar de calibração OPEC |
| Appendix E. Extensions not yet promoted | `pi_H > 0`, `a0_M < beta/m`, continuous types | Entrar apenas como pending ou future work se ainda não provado |

## 4. Ordem proposta de resultados formais

### Ordem no corpo

1. **Definition 1 - Fixed-pie relative-package institutional design game.**
   Define players, timing, `pi_H=0`, package `y`, fixed surplus `1`, payoffs,
   entry and voting protocol.

2. **Proposition 1 - Majority no-screening benchmark.**
   Under the threshold domain and `a0_M >= beta/m`, a weak proposer forms a
   no-`H` majority coalition for every belief. `H` is observed voting, but its
   vote is not pivotal and no screening rent is paid.

3. **Lemma 1 - Terminal unanimity threshold.**
   In R2 unanimity, the weak proposer compares low-only and pooling packages.
   The cutoff is `mu2_star = (tau1 - tau0)/(1 - tau0)`.

4. **Theorem 1 - R1 passive-belief pure-threshold unanimity outcome.**
   Under the R1 threshold-order domain and the stated passive-belief voting
   assessment, the admissible refined candidates are pooling, low-only, and
   no-information rejection. The selected candidate maximizes the weak
   proposer's payoff. Without the conservative tie-break against `H`, payoff
   ties remain a correspondence of candidate outcomes.

5. **Remark 1 - Delay is endogenous, not imposed.**
   Rejection/continuation remains in the candidate set. It can be selected by
   incentives. The paper should not remove it by assumption. The non-calibrated
   delay example can be moved to Appendix D.

6. **Proposition 2 - Weak-state entry nesting.**
   Under the no-cheap-`H` majority benchmark, the representative weak-state
   entry payoff under unanimity is weakly below that under majority for every
   belief, so `F_U(chi) subset F_M(chi)`.

7. **Proposition 3 - Conditional comparison for the hegemon.**
   On beliefs where both rules form, `H`'s institutional ranking is determined
   by the sign of `Delta_H(mu) = H_U(mu) - H_M(mu)`.

8. **Corollary 1 - Complete refined-equilibrium institutional classification.**
   The five categories partition beliefs and entry costs: no rule forms; only
   majority forms; both form and `H` prefers unanimity; both form and `H` is
   indifferent; both form and `H` prefers majority.

9. **Corollary 2 or Example 1 - Working calibration.**
   For the current working calibration, unanimity forms only when
   `chi <= 0.0619583`; majority forms when `chi <= 0.0833333`; when both form,
   `H` prefers unanimity for `mu < 0.7`, is indifferent at `mu = 0.7`, and
   prefers majority for `mu > 0.7`.

### Ordem no apêndice

1. Proof of Proposition 1: majority benchmark and no-cheap-`H`.
2. Proof of Lemma 1: terminal unanimity.
3. Proof of Theorem 1: R1 unanimity candidates, passive-belief voting
   assessments, ICs, informative rejected ballots, selected/refined value.
4. Proof of Proposition 2: weak-state entry payoff and nesting.
5. Proof of Proposition 3: conditional comparison for `H`.
6. Proof of Corollary 1: five-way classification and tie handling.
7. Calibration appendix: closed-form values and script outputs.
8. Delay appendix: non-calibrated backward-induction example and literature
   positioning.

### Decisão KISS sobre `b_theta`

O transporte ao paper deve usar `t_theta` como primitivo principal:

```text
H accepts y iff y >= t_theta.
Assume 0 <= t0 < t1 <= ybar <= 1.
```

A versão com `U_H(y, theta) = y + b_theta` não altera os resultados quando os
objetos relevantes são os thresholds líquidos. Ela apenas decompõe o threshold
em outside option menos benefício direto de acordo. Essa decomposição pode ser
útil para uma nota de apêndice, mas complica o corpo do paper sem comprar um
resultado novo. A recomendação editorial é retirar `b_theta` do modelo
principal e, se necessário, registrar em apêndice:

```text
t_theta = d_theta - b_theta.
```

## 5. Partes de `formal_model_v5.Rmd` que precisam substituição futura

Não editei `formal_model_v5.Rmd`. O mapa abaixo indica os blocos a substituir
depois de confirmação explícita.

| Linhas aproximadas | Bloco atual | Ação futura |
|---|---|---|
| 37 | Abstract | Reescrever completamente. Remove percentuais antigos, `r/alpha` e claim de dominância global. |
| 48-59 | Introduction | Atualizar claim: `pi_H=0`, sem agenda power, pivotalidade informacional; qualificar comparação por regiões. |
| 61-69 | Literature | Manter contribuição institucional, mas trocar "proposal rights symmetric" por "weak-state agenda baseline"; adicionar delay literature com cuidado. |
| 71-90 | Motivating Example | Substituir por exemplo fixed-pie package, sem state-dependent pie nem proposer aleatório. |
| 92-115 | The Model | Substituir definição antiga `Gamma(N,p,r,alpha,beta,c)`, `V(theta)`, outside option proporcional e reconhecimento uniforme. |
| 115-197 | Figura/game tree antiga | Recriar como timing diagram fixed-pie `pi_H=0`. Remover ramo `H proposes`. |
| 202-214 | Majority Rule | Substituir por majority no-screening com no-cheap-`H`; manter ponto de exclusão de `H` apenas sob nova condição. |
| 217-309 | Consensus/Screening | Substituir cutoff/jump antigo por R2 threshold, R1 selected candidates e delay remark. |
| 310-326 | Entry and viability | Reescrever entry com `chi`, `W_U`, `W_M=1/m`, nesting e fixed surplus. |
| 328-420 | Institutional Choice | Remover theorem antigo de alpha-star global; inserir comparação de sinal, classificação cinco-way e working calibration. |
| 421-503 | Numerical characterization code/figure | Recomputar figuras sob scripts relative-package; remover heatmap antigo se baseado em `alpha/r`. |
| 505-626 | Discussion/OPEC | Reescrever OPEC: Saudi Arabia como pivotal/private-informed participant, não agenda setter; recalibrar com thresholds líquidos `t0,t1`; deixar `d_theta-b_theta` só como microfundamento opcional. |
| 628-638 | Conclusion | Ajustar para "when and why", não dominância global. |
| 641-959 | Appendix A | Substituir por derivações fixed-pie relative-package. |
| 960-1518 | Appendix B | Substituir/remover provas antigas e blocos duplicados; manter apenas o que for rederivado. |
| 1520-1649 | Appendix C continuous types | Marcar como pending ou mover para future work até rederivar sob nova arquitetura. |

Resíduos a eliminar na etapa de edição:

```text
V_e
r as state-dependent pie parameter
alpha as proportional outside option
state-dependent feasibility
aggressive/conservative branch labels from the old architecture
uniform random proposer / each player recognized with probability 1/N
H-proposer branch in the baseline
old alpha-star theorem
old OPEC percent claims
```

## 6. Checklist de edição e verificação para a próxima etapa

### Antes de editar o manuscrito

- [ ] Confirmar que o transporte para `formal_model_v5.Rmd` está autorizado.
- [ ] Criar um snapshot git ou branch de trabalho antes da substituição.
- [ ] Rodar novamente os cinco scripts `verify_relative_package_*_piH0.R`.
- [ ] Fazer nova revisão independente do theorem de R1 com dois agentes:
  matemática e teoria dos jogos. Só promover se ambos passarem sem ressalvas
  substantivas.
- [ ] Converter as referências da nota de delay para BibTeX e validar
  `references.bib`.
- [ ] Decidir se o resultado de delay entra como remark no corpo ou somente no
  apêndice.

### Durante a edição

- [ ] Atualizar abstract e introduction primeiro, para alinhar claim e escopo.
- [ ] Trocar o motivating example antes de trocar os resultados formais.
- [ ] Reescrever o Model com os primitivos fixed-pie, `pi_H=0` e threshold
  líquido `t_theta`.
- [ ] Inserir uma figura nova de timing, não uma árvore antiga com `H` proposer.
- [ ] Transportar resultados na ordem: majority benchmark, R2 unanimity, R1
  unanimity, delay remark, entry/nesting, conditional comparison, classification.
- [ ] Substituir appendices antigos por provas espelhadas na ordem do corpo.
- [ ] Recriar figuras e tabelas a partir dos scripts relative-package.
- [ ] Manter computação em scripts separados sob `scripts/`.

### Depois da edição

- [ ] Rodar `rmarkdown::render("formal_model_v5.Rmd")` sem forçar output format.
- [ ] Rodar os cinco scripts relative-package novamente.
- [ ] Rodar busca de resíduos proibidos no manuscrito:

```text
- raw use of b_theta in the body
U_H(y, theta) = y + b_theta
V_e
alpha
r=1.5
C-B-R
state-dependent
aggressive
conservative
uniformly random
H proposes
```

- [ ] Conferir que toda tabela e figura tem número e caption.
- [ ] Conferir que todo resultado no corpo tem prova correspondente no apêndice.
- [ ] Conferir que nenhum resultado chama o theorem de R1 de caracterização
  global de PBE puro padrão, a menos que uma nova rodada de revisão aprove o
  refinamento necessário.
- [ ] Conferir que delay não é descrito como calibração.
- [ ] Conferir que OPEC não apresenta Saudi Arabia como agenda setter formal.
- [ ] Conferir que `pi_H>0` aparece somente como extensão ou escopo.
- [ ] Fazer audit de reprodutibilidade dos números citados no texto contra os
  outputs dos scripts.

## 7. Decisão editorial recomendada

A versão paper-ready deve abandonar a promessa antiga de dominância global de
unanimity. O ganho do novo design é mais limpo e defensável:

```text
The baseline stacks the agenda against H. Even with pi_H=0, unanimity can give
H informational power because weak proposers must satisfy a privately known
participation threshold. Majority can switch off that constraint when weak
states can form without H. The paper's result is therefore a classification of
when pivotality-based informational power beats exclusion under majority.
```

Essa formulação é menos grandiosa, mas mais robusta. Ela também responde melhor
ao problema que motivou o redesign: separar outside-option power,
veto/pivotality power e proposal power antes de reconstruir extensões com
`pi_H>0`.

### Avaliação para submissão tipo JOP

Status atual: **a arquitetura pode seguir para transporte paper-ready somente
pela rota passive-belief/refined PBE**. Ela ainda não está pronta para submissão
JOP se o paper insistir em afirmar uma caracterização geral de todos os PBEs
puros em R1 unanimity. A tentativa de provar esse resultado forte falhou na
revisão independente por uma razão substantiva, não cosmética: PBE padrão deixa
graus de liberdade em crenças off-path e em equilíbrios de votação weak que os
lemas atuais não fecham.

O material é potencialmente suficiente para uma versão JOP se o paper assumir
explicitamente a rota escolhida:

1. **Rota escolhida.** Manter o resultado como `selected/refined
   pure-threshold PBE`, com crenças passivas e votação weak-acceptance
   declaradas como parte do protocolo. O paper deve vender o resultado como uma
   caracterização limpa sob um protocolo institucional natural, não como
   unicidade global de PBE.

Minha recomendação editorial é transportar essa rota escolhida: ela preserva o
mecanismo central, evita uma briga técnica sobre off-path beliefs, e é mais
honesta para um leitor de teoria formal em ciência política. A caracterização
global de PBE padrão pode virar nota metodológica ou extensão, mas não deve ser
usada como base do corpo do paper.
