# TODO — Informational Power, Agenda Power, and Institutional Design

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
- [ ] **Signaling quando H propõe sob C**: relaxar Assumption P, analisar equilíbrios separating/semi-separating
- [ ] **Heterogeneidade entre fracos**: custos c_i diferentes, quebra all-or-none
- [ ] **Horizonte infinito**: verificar se screening channel sobrevive em BF estacionário
