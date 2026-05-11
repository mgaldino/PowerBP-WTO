# TODO — Informational Power, Agenda Power, and Institutional Design

## Prioridade Crítica — redesign power architecture 2026-05-10

- [x] **Decidir arquitetura do paper**: separar três fontes de poder — outside option, veto/pivotality e proposal power.
- [x] **Introduzir desenho por recognition probability**: `pi_H` representa agenda power; baseline principal usa `pi_H = 0`; extensões usam `pi_H = 1/N` e `pi_H > 1/N`.
- [x] **Diagnosticar H-proposer fora do accepted pooling**: `quality_reports/h_proposer_response_complete.md` conclui que o payoff é selection-dependent fora do pooling; não usar como ramo central.
- [x] **Registrar nota de arquitetura `pi_H`**: `quality_reports/2026-05-10_power_architecture_piH.md`.
- [x] **Criar workspace formal separado**: `model_redesign/power_architecture_derivations.Rmd`; não mexer em `formal_model_v5.Rmd` até a prova estar limpa.
- [x] **Arquivar tentativa feasibility/C-B-R**: tag `redesign-feasibility-branch-2026-05-11`; usar apenas como diagnóstico histórico.
- [x] **Reset relative-package**: documento limpo em `model_redesign/power_architecture_derivations.Rmd` com `U_H(y,theta)=y+b_H(theta)` e threshold `y_theta^*(mu')=beta C_H(theta,mu')-b_H(theta)`.
- [ ] **Formalizar custo de `y` para weak states**: normalização pretendida é custo um-para-um para a coalizão fraca; weak voters recebem continuation value e proposer fica com residual.
- [ ] **Escolher R2 do novo benchmark**: recomendação inicial é `pi_H = 0` também em R2; alternativa é BF padrão/`pi_H > 0` como robustez.
- [ ] **Derivar R2 unanimity relative-package**: pooling/high-threshold, low-only e no-agreement/continuation sob `U_H(y,theta)=y+b_H(theta)`.
- [ ] **Derivar R1 unanimity relative-package**: usar continuation values de R2; não reaproveitar branch labels `B`/C-B-R sem rederivação.
- [ ] **Recriar Appendix A sob baseline `pi_H = 0`**: timing, majority, unanimity R2 e unanimity R1 com pacotes relativos.
- [ ] **Recriar Appendix B sob o novo protocolo**: dominância condicional, entry/nesting e classificação.
- [ ] **Derivar stress test de outside option**: adaptar ao novo threshold líquido `beta C_H(theta,mu')-b_H(theta)`.
- [ ] **Analisar extensão BF neutra**: `pi_H = 1/N`, usando bounds/simulações quando o ramo H-proposer gerar payoff correspondence.
- [ ] **Analisar agenda power hegemônico**: `pi_H > 1/N`, como extensão separada do mecanismo central.
- [ ] **Criar scripts R de verificação novos**: `scripts/verify_relative_package_R2_piH0.R`, `scripts/verify_relative_package_R1_piH0.R`, `scripts/verify_relative_package_majority_piH0.R`, etc.
- [ ] **Refazer figuras/game tree**: remover qualquer ramo em que `H` propõe em R1.
- [ ] **Reescrever OPEC case**: Saudi Arabia como veto player pivotal informado, não agenda setter formal.
- [ ] **Reescrever corpo principal depois das provas**: theorem statements, figuras e claims gerais só devem ser transportados após validação no workspace separado.
- [ ] **Reauditar Appendix C**: continuous types só depois de estabilizar o modelo binário redesenhado.

## Verificações novas já concluídas

- [x] **Teorema de condições suficientes**: janela de `beta` verificada em Appendix B.5 e reproduzida por `scripts/verify_sufficient_conditions_lower_bound.R`.
- [x] **Dominância calibrada por lower bound**: OPEC `N=13`, `r=1.5`, `alpha=.19`, `beta=.9` passa em todo `mu in [0,1]`.
- [x] **Nesting calibrado**: `F_U subset F_M` para OPEC verificado por `scripts/verify_calibrated_nesting_upper_bound.R`.
- [x] **Classificação calibrada**: recuperada para OPEC; classificação geral segue pendente.
- [x] **Nota de redesign**: `quality_reports/2026-05-10_model_redesign_weak_proposer_agenda.md`.
- [x] **Nota de arquitetura de poder**: `quality_reports/2026-05-10_power_architecture_piH.md`.
- [x] **Workspace formal separado**: `model_redesign/power_architecture_derivations.Rmd` e `model_redesign/README.md`.

## Prioridade Alta (antes de submeter)

### Technical
- [x] **BP sob Package C**: Remark \ref{rem:geometric} adicionado explicitando que concavificação é geométrica, com closed-form para N=3 mas não para N geral.
- [x] **Condição para p* e ḡ**: anotado no proof sketch do Theorem 1 que g > ḡ é condição suficiente. Condição necessária e suficiente requer closed-form da concavificação — tarefa analítica para draft futuro.
- [x] **Package B**: redação ajustada para scope do que está demonstrado (two-round com d=V(θ)/N).

### Editorial
- [x] **Roadmap of proof**: adicionado no início da Seção 4 com \ref{} para seções.
- [ ] **Discussão Steinberg/Maggi-Morelli**: está funcional mas pode ser expandida depois de fechar a versão formal. Não expandir agora — o essencial está lá.
- [x] **Referências cruzadas**: padronizado com \ref{} (6 referências adicionadas a lemas, proposições e teorema).
- [x] **Labels `_rewrite`**: removido suffix de 21 labels.

## Prioridade Média (antes de circular)

- [x] **Formalização em Lean**: setup configurado, Prop1.lean compilando (affinity, existência via IVT, jump positivo verificados; unicidade 1 sorry)
- [ ] **Simulação N=5, N=7**: implementar o modelo V3 para N>3 no script R, verificar numericamente que o screening channel opera
- [x] **Citações fantasma**: resolvido. Citados no texto: Kamenica 2019, Crawford 1982, Eraslan 2019, Keohane 1984, Fearon 1995. Removidos do .bib: Davis, Fang, Gilligan, Drezner, Powell, Narlikar, Elsig.
- [x] **Schnakenberg (2017)**: adicionado na Seção 2.1 junto com Kamenica & Gentzkow e Alonso & Câmara

## Prioridade Baixa (extensões futuras)

- [ ] **Paper futuro: Erosão Endógena**: jogo repetido com aprendizado custoso dos fracos sobre V. Ver CLAUDE.md para detalhes.
- [ ] **Extensão futura: signaling quando H propõe**: tratar o ramo `H`-proposer como extensão separada com payoff correspondence/refinamentos, não no modelo principal.
- [ ] **Heterogeneidade entre fracos**: custos c_i diferentes, quebra all-or-none
- [ ] **Horizonte infinito**: verificar se screening channel sobrevive em BF estacionário
