# Analise de Gaps: Coarse Review vs. Paper v4

**Data**: 2026-04-26
**Revisor**: Claude (gap analysis automatizado)
**Fontes**: `coarse-output/coarse_0b50af74-a025-4b52-a8b9-31f2de8895fe_coarse_review_cli_claude.md` vs. `formal_model_v4.Rmd`

---

## Resumo executivo

O coarse review (de 2026-04-22) identificou 5 preocupacoes estruturais no Overall Feedback e 10 comentarios detalhados. O paper v4 incorporou respostas substanciais a varias dessas criticas, especialmente a computacao de p*, o exemplo numerico completo, e correcoes pontuais. Porem, varias recomendacoes de alto impacto permanecem sem tratamento.

---

## 1. RECOMENDACOES JA INCORPORADAS

### 1.1 Threshold p* nunca computado (Overall #6, "Theorem 1's threshold p* is never computed")
**Status**: RESOLVIDO.
O paper v4 inclui Example 2 (ex:p_star, linhas 560-566) com N=5, r=1.5, alpha=0.3, beta=0.9, c=0.14, computando p* ~ 0.24. O exemplo traca a comparacao completa: tau(M) ~ 0, tau(U) ~ 0.33, vantagem de 22% em p=0.30 e 25% em p=0.50. Atende plenamente a critica.

### 1.2 Citacao errada de Crawford e Sobel (Comentario #1)
**Status**: RESOLVIDO.
Na Secao Scope (linha 699), a referencia a "evidence games" agora cita Glazer and Rubinstein 2004 e "verifiable disclosure" cita Milgrom 1981. Crawford and Sobel foi removido desse contexto. Correcao exata conforme pedido.

### 1.3 Parentetico "(N-1)/N^2 peaks at intermediate values" (Comentario #7)
**Status**: PARCIALMENTE RESOLVIDO.
A frase na linha 324 diz "$(N-1)/N^2$ peaks at intermediate $N$" -- a formulacao mudou ligeiramente para "moderately-sized organizations---large enough that the hegemon's vote matters, but not so large that the cost of unanimous agreement dilutes the per-member advantage". A explicacao substantiva esta melhor, mas a expressao matematica "(N-1)/N^2 peaks at intermediate N" persiste no texto. O reviewer mostrou que (N-1)/N^2 eh monotonicamente decrescente para N>2; o hump so surge na interacao com (1-mu_s^{R1}). A afirmacao matematica permanece imprecisa.

### 1.4 Direcao errada da "conservative region" (Comentario #8)
**Status**: NAO ENCONTRADA NO PAPER v4.
A frase exata citada no review ("decreases with mu_s^{R1} (larger conservative region)") nao aparece no paper v4. A descricao do jump (linhas 313-324) usa uma formulacao diferente que evita o erro. Resolvido por reescrita.

### 1.5 "Higher r is payoff dispersion, not informational asymmetry" (Comentario #9)
**Status**: RESOLVIDO.
Na linha 672, o paper v4 diz "the hegemon's private information is more consequential (higher r)" ao inves de "greater informational asymmetry". Formulacao corrigida.

---

## 2. RECOMENDACOES PENDENTES

### 2.1 Dependencia estrutural do tipo discreto (Overall #1)
**Severidade**: ALTA
O review pede que o paper ou (a) demonstre que uma nao-convexidade analoga surge sob tipos continuos (bunching, Dworczak e Martini 2019), ou (b) forneca evidencia institucional de que o espaco de tipos eh genuinamente discreto. O paper v4 na Conclusao (linhas 803-804) mantem a mesma defesa do review: "states evaluate cooperation in terms of qualitatively distinct regimes" e reconhece que tipos continuos eliminariam os jumps. Nao ha referencia a Dworczak e Martini, nenhum argumento novo sobre bunching, e a evidencia institucional eh assertiva sem suporte. A critica permanece integralmente sem resposta.

### 2.2 K>2 levanta mais preocupacoes do que resolve (Overall #2)
**Severidade**: ALTA
O review critica que (i) o Appendix D relatava parametrizacoes onde D(mu)<0, (ii) alpha_3* < alpha*, e (iii) nada impede alpha_K* de convergir para zero com K. O paper v4 reescreveu o Appendix C (antigo D), removendo a simulacao numerica, a tabela com parametrizacoes que falhavam, e o warning "Proposition D.3 is NOT confirmed." O appendix agora apenas prova linearidade de majority para K geral (Prop 6) e afirma K-1 boundaries para unanimidade, sem analisar a convergencia de alpha_K*. A conclusao (linhas 803-804) diz "the non-convexity structure becomes richer, not weaker" sem qualificar. O review pediu "frank assessment of whether the mechanism survives empirically relevant parameterizations for K>=3." Isso nao foi feito. A remocao das simulacoes pode ser lida como ocultacao do problema.

### 2.3 BP commitment precisa de defesa institucional seria (Overall #3)
**Severidade**: ALTA
O review pede que o paper mostre que a comparacao qualitativa (unanimidade gera screening, maioria nao) sobrevive sob cheap talk ou verifiable disclosure. O paper v4 (linhas 697-699) mantem as mesmas tres defesas: reputacao, regras de transparencia da OMC, e interpretacao de upper bound. Nao ha nenhuma analise formal ou mesmo informal de cheap talk/verifiable disclosure. A defesa permanece identica a versao revisada.

### 2.4 Comparative statics de p* para predicoes testaveis (Overall #4)
**Severidade**: MEDIA
O review pede que o paper compute como p* responde a alpha, r, N, c e gere pelo menos uma predicao que distinga esta teoria de alternativas. O paper v4 computa p* para um conjunto de parametros (Example 2) e apresenta Figure 5 com regioes de parametros. Porem, nao ha comparative statics explicitas de p* (e.g., dp*/dalpha, dp*/dr). A discussao GATT/WTO (linhas 687-689) gera predicoes qualitativas que o review considerou genericas ("could follow from many theories"). A calibracao sugerida (GATT rounds iniciais vs. Doha) nao foi realizada. Progresso parcial, mas a critica central (predicoes que distingam a teoria) permanece.

### 2.5 Diferenciacao de Bardhi e Guo (2018) e Kim, Kim, e Van Weelden (2025) (Overall #5)
**Severidade**: MEDIA
O review pede 2-3 paragrafos explicando quais features do setup produzem resultados ausentes nesses papers. O paper v4 (linha 55) mantem a mesma frase condensada: "neither offers the institutional comparison between voting rules that is central here." A discussao nao se expandiu. Continua insuficiente para JoP/AJPS.

### 2.6 Dois rounds podem moldar features atribuidas a voting rule (Overall #6, "Two-round bargaining")
**Severidade**: MEDIA
O review pede analise de como o jump varia com T, ou uma simulacao com T=3. O paper v4 inclui um paragrafo novo sobre a justificativa dos 2 rounds (linhas 100-101), argumentando robustez, off-path beliefs, e alpha-independencia. Porem, nao analisa como o jump magnitude varia com T, nao simula T=3, e nao discute se o mecanismo sobreviveria em horizonte infinito. A justificativa eh qualitativa, nao analitica.

### 2.7 W's payoff sob a instituicao otima de H nao examinado (Overall #7)
**Severidade**: MEDIA
O review pede que se compute o payoff ex ante de W sob BP otimo de H, e discuta o que sustenta unanimidade da perspectiva de W. O paper v4 (linhas 520-521) menciona que V_W(mu,U) < V_W(mu,M) e que entry eh mais dificil sob unanimidade, mas nao computa o payoff ex ante de W sob o sinal otimo. Nao ha discussao de side payments, status quo bias, ou package deals. A lacuna permanece.

### 2.8 Decomposicao da magnitude relativa dos canais entry vs. screening (Overall #8, "No decomposition")
**Severidade**: MEDIA
O review pede que se compute, para parametros dados, quanto do ganho de BP vem do canal de screening vs. do canal de entry. O paper v4 nao inclui essa decomposicao. A afirmacao de "dual exploitation" (Proposition 4) permanece qualitativa.

### 2.9 Abstract e conclusao afirmam existencia de threshold incondicionalmente (Comentario #2)
**Severidade**: BAIXA
O review nota que os 4 cases do Theorem incluem casos onde unanimidade domina globalmente (sem threshold). O abstract (linha 36) diz "once cooperation is promising enough that weaker states are willing to participate under unanimity, the hegemon strictly prefers it" -- o que eh uma formulacao melhor que a criticada. A conclusao (linha 800) diz "The institutional comparison reduces to a single threshold: above it, unanimity dominates; below it, majority can dominate through easier entry. The ranking never oscillates." Isso ainda sugere que um threshold sempre existe. O Corollary 1 (linhas 540-542) trata o caso E_U = (0,1] explicitamente. A conclusao deveria refletir isso.

### 2.10 Conclusao sobre K>2 simultaneamente subestima e superestima (Comentario #3)
**Severidade**: BAIXA
A conclusao (linhas 803-804) diz "unanimity generates K-1 screening boundaries while majority remains linear---the non-convexity structure becomes richer, not weaker." O appendix C foi simplificado e ja nao diz "robust" explicitamente, mas a conclusao preserva o tom. Nao distingue o que esta provado (K=2) do que eh conjectura (K geral). Melhoria marginal.

### 2.11 Footnote e main text predizem efeitos opostos de complexidade (Comentario #4)
**Severidade**: BAIXA
O texto principal (linha 687) diz que consensus matters mais em areas complexas (servicos, PI); o footnote (antigo Footnote 6, agora na linha 687 como footnote no fim do paragrafo) diz que mais dimensoes apertam alpha_3*. A tensao persiste e nao eh resolvida. Porem, o appendix C foi reduzido e o footnote eh agora mais breve (apenas "more issue dimensions increase the number of screening regions but also make the screening problem harder"), o que reduz a saliencia da contradicao sem resolve-la.

### 2.12 K mapeado para issue dimensions subestima a ameaca (Comentario #5)
**Severidade**: BAIXA
A conclusao (linhas 803-804) nao discute law-of-large-numbers/aproximacao de continuidade. O argumento de que bundling gera K discreto maior ao inves de aproximar continuidade nao eh feito. Permanece sem resposta, mas a saliencia eh menor dado que o appendix C foi simplificado.

---

## 3. RECOMENDACOES NAO MAIS APLICAVEIS

### 3.1 Figura avaliada em um unico prior extremo (Comentario #6)
**Status**: PARCIALMENTE NAO APLICAVEL.
O paper v4 mantem Figure 5 a p=0.05, mas agora inclui o heatmap (alpha, mu) com 4 paineis (Figure heatmap-alpha-mu, linhas 711-791) que mapeia a regiao de dominancia em todo o espaco (alpha, mu) para N=30 e N=164 com r=1.5 e r=2.0. Isso complementa substancialmente a Figure 5. Porem, a critica especifica de que p=0.05 nao eh justificado como benchmark continua valida para Figure 5 em si.

### 3.2 Doha conflata preferencia institucional com outcomes (Comentario #10)
**Status**: PARCIALMENTE ENDEREACADO.
O paragrafo GATT/WTO (linhas 679-689) foi reescrito com linguagem mais cuidadosa: "consistent with" e "predicts" em vez de afirmacoes diretas. Porem, a formulacao nao adota a sugestao especifica do review de reformular como "the model predicts a strong hegemonic preference for consensus" vs. "the predicted advantage shrinks."

---

## 4. PRIORIZACAO PARA PROXIMA REVISAO

| # | Recomendacao | Severidade | Esforco | Impacto |
|---|-------------|-----------|---------|---------|
| 2.1 | Tipo discreto: argumento substantivo ou referencia a Dworczak-Martini | ALTA | MEDIO | Defende o motor central |
| 2.2 | K>2: assessment honesto, nao remover evidencia desfavoravel | ALTA | MEDIO | Credibilidade |
| 2.3 | BP commitment: cheap talk / verifiable disclosure, ao menos analise informal | ALTA | ALTO | Solidifica a comparacao institucional |
| 2.5 | Diferenciacao Bardhi-Guo, Kim et al.: 2-3 paragrafos | MEDIA | BAIXO | Previne rejeicao por falta de posicionamento |
| 2.4 | Comparative statics de p* | MEDIA | MEDIO | Predicoes testaveis |
| 2.7 | Payoff de W sob BP otimo | MEDIA | BAIXO | Completa a analise distributiva |
| 2.8 | Decomposicao entry vs. screening | MEDIA | BAIXO | Quantifica a novidade |
| 2.6 | T>2 rounds: ao menos discussao analitica | MEDIA | ALTO | Robustez |
| 2.9 | Conclusao: threshold nao existe em todos os cases | BAIXA | MINIMO | Precisao |
| 2.10 | K>2 na conclusao: distinguir provado de conjectura | BAIXA | MINIMO | Precisao |
| 1.3 | (N-1)/N^2 monotonicamente decrescente, nao peaks | BAIXA | MINIMO | Correcao factual |

---

## 5. NOTA METODOLOGICA

Esta analise compara o coarse review de 2026-04-22 contra o estado atual do paper (formal_model_v4.Rmd, sessao 2026-04-26). O coarse review foi produzido sobre uma versao anterior do paper (provavelmente v2 ou v3 inicial). Varias criticas ja foram parcialmente endereacadas nas revisoes intermediarias. A analise acima reflete o gap residual.
