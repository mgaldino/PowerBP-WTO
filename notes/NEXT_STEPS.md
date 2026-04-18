# Próximos Passos — Curse of Knowledge Paper

*Atualizado: 2026-03-29, após 2 rounds de review (6 pareceristas cada)*

## Status atual

- Modelo resolvido para N genérico (P1-P3 provados)
- Horizonte infinito resolvido (equivalente a T=2)
- Nota técnica v2 em RMarkdown (compila, com abstract, exemplo, figuras)
- Literature search completa (nenhuma sobreposição encontrada)
- Bug numérico no exemplo N=3 corrigido
- **Prop 2 corrigida**: BP gain = 0 sob unanimidade (erro fundamental na v1)
- Todas as provas completas (sem proof sketches)
- Lema de separação formal com off-path beliefs
- Scores: Edmans 6/10, Formal Model 7.7/10 (pré-correção; re-avaliar)

---

## Prioridade 1 — Provas e correções formais (blocking) ✅ CONCLUÍDA

- [x] **Verificar prova da Prop 2 (BP gain sob unanimidade).** RESULTADO: Prop 2 original estava ERRADA. BP gain = 0 sob unanimidade. S sempre ganha δω/N quando R propõe (linear em μ → BP irrelevante). Nova Prop 2: "Neutralidade informacional" — E[S] = E[ω]/N sob unanimidade.
- [x] **Tratar adverse selection.** RESULTADO: Sob screening (oferta δL/N), S aceita quando ω=L, rejeita quando ω=H. Em ambos os casos S ganha δω/N. Sob pooling (oferta δH/N), infeasível para parâmetros relevantes. Adverse selection tratada explicitamente nas provas.
- [x] **Completar todas as provas.** P1 (Curse): mantida com prova completa. P2 (Neutralidade): prova nova em 4 steps. P3 (Preferência institucional): reformulada — ganho = magnitude exata do Curse. Todas as provas eliminam proof sketches.
- [x] **Provar separação de S.** Lema formal com prova: separação é estritamente dominante para ω=H, fracamente para ω=L. Off-path beliefs tratadas — separação domina sob qualquer crença.

## Prioridade 2 — Exposição (para circulação)

- [ ] **Worked example para unanimidade** (N=3, mesmos parâmetros). 3 pareceristas flagraram assimetria.
- [ ] **Tabela 2×2**: {maioria, unanimidade} × {com BP, sem BP}. Isola exclusão vs. BP vs. interação.
- [ ] **Game tree** (diagrama do jogo extensivo).
- [ ] **Figura da concavificação** v(μ) vs V(μ).
- [ ] **Eliminar repetição** intro/Seção 7.
- [ ] **Seção 6 → Remark** dentro da Seção 4 (Horizon Independence não merece seção própria).
- [ ] **Reescrever roadmap** (lógica do argumento, não lista de seções).

## Prioridade 3 — Citações e posicionamento

- [ ] **Expandir referências** (7 → ~20). Adicionar:
  - Crawford & Sobel (1982) — cheap talk
  - Banks & Duggan (2000) — BF generalizado
  - Diermeier & Feddersen (1998) — unanimidade em legislaturas
  - Feddersen & Pesendorfer (1998) — voto unânime e informação
  - Maggi & Morelli (2006) — self-enforcing voting em OIs
  - Eraslan et al. — BF com informação assimétrica
  - Schnakenberg (2017) — lobbying informacional
  - Bergemann & Morris (2016, 2019) — information design
  - Gentzkow & Kamenica (2017) — competing senders
- [ ] **Reconhecer homonímia** "Curse of Knowledge" com psicologia cognitiva (Camerer, Loewenstein, Weber 1989).
- [ ] **Discutir Maggi & Morelli (2006)** como explicação alternativa para consenso.

## Prioridade 4 — Robustez e extensões (para APSR/IO)

- [ ] Discutir (mesmo informalmente): **pie contínuo**, múltiplos Senders, cheap talk, reconhecimento assimétrico.
- [ ] **Análise de welfare/eficiência** formal.
- [ ] **Seção de limitações** antes da conclusão.
- [ ] **Case study ou vignette** (Rodada Doha ou similar).

## Prioridade 5 — Estática comparativa

- [ ] Gráficos: E[U_S] por N, por δ, por H/L, por p.
- [ ] Discutir: quando o Curse é negligível? Quando S é quase indiferente?

---

## Target journals (por ambição)

1. **JTP / GEB** — com Prioridades 1-2 resolvidas
2. **JOP / IO** — com Prioridades 1-3 resolvidas
3. **APSR / AJPS** — com Prioridades 1-4 resolvidas

## Co-autores potenciais

- **Lucas Damasceno Pereira** — para paper separado sobre observação eleitoral (BP + EOMs)
- Para este paper: a definir (expertise em BF/teoria formal ou design de OIs)
