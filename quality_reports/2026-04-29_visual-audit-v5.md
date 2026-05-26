# Auditoria Visual: formal_model_v5.pdf

**Data**: 2026-04-29
**Arquivo**: `formal_model_v5.Rmd` (50 pp, compilado via `bookdown::pdf_document2`)
**Compilacao**: Limpa (0 errors, 0 citeproc warnings pos-fix)

## Impressao geral

Documento bem formatado para paper academico: Times New Roman 12pt, line spacing 1.5, margens 2.5cm. Equacoes, proposicoes e definicoes renderizam corretamente. Figuras sao relevantes e bem posicionadas. Os problemas sao pontuais mas incluem um CRITICAL (cross-reference quebrada visivel no corpo do texto).

## Nota: B+

## Page-by-page

### Page 1: Title + Abstract
- PASS: Abstract preenche a pagina adequadamente, sem overflow
- PASS: Keywords presentes
- MINOR: Data exibe `2026-04-29` (formato ISO) — para submissao RIO, considerar formato mais convencional

### Pages 2-3: Introduction
- PASS: Texto limpo, citacoes renderizam bem, spacing adequado

### Page 4: Lit Review + Section 3 start
- PASS: Footnote 1 (Bardhi & Guo) bem posicionada

### Pages 5-6: Motivating Example + Model
- PASS: Math renders corretamente, bullet lists alinhados
- PASS: Definition 1 bem formatada

### Page 7: Model cont.
- MAJOR: ~40% da pagina e whitespace entre ultimo paragrafo e footnotes 3-6. Causa: Figure 1 (game tree landscape) forcada para proxima pagina. Footnotes 3-6 sao densas e longas.
- MINOR: 4 footnotes na mesma pagina — considerar consolidar ou mover alguma para o texto

### Page 8: Game tree (landscape)
- PASS: TikZ game tree renderiza corretamente, labels legiveis
- PASS: Caption detalhada e informativa
- MINOR: Numero de pagina "8" aparece na margem esquerda (comportamento padrao de `pdflscape`, nao e erro)

### Pages 9-10: Propositions 2-3
- PASS: Equacoes numeradas corretamente, cutoff formula (1) e jump formula (3) claras

### Page 11: Figure 2 (schematic payoff) + Example 1
- PASS: Figure 2 (TikZ schematic) clara, labels "Aggressive", "Conservative", "Majority (linear)" legiveis
- PASS: Cores distinguiveis (vermelho vs azul)

### Page 12: Entry section
- PASS: Definition 2 (net gain function) bem formatada com cases

### Page 13: Theorem 1
- PASS: Theorem 1 statement claro, equacao displayed centralizada

### Page 14: Remark 1 + Formation sets
- PASS: Decomposition formula com underbrace renders bem
- PASS: Corollary 1 statement claro

### Page 15: Corollary cont + Remark 2
- PASS: Proposition 4 (institutional classification) com 3 cases alinhados

### Page 16: Proposition 4 cont + Remark 3
- CRITICAL: **Cross-reference quebrada** — texto renderiza como literal "reffig:parameter-regions" em vez de "Figure 3". Causa: `\@ref(fig:parameter-regions)` dentro de `\begin{remark}...\end{remark}` (ambiente LaTeX raw). Bookdown nao processa `\@ref()` dentro de ambientes LaTeX; Pandoc converte para `\\ref{}` (double backslash).
- **Fix**: Substituir `\@ref(fig:parameter-regions)` por `\ref{fig:parameter-regions}` dentro do remark.

### Page 17: Remark 3 cont + Remark 4 + Example 2
- PASS: Weighted voting remark bem formatado

### Page 18: Figure 3 (parameter-regions)
- PASS: Figura clara, cores distinguiveis (azul/laranja/cinza), legend legivel
- PASS: Caption adequada

### Page 19: Discussion / OPEC
- MAJOR: **Aspas quebradas** — "all Full Members.' '" em vez de "all Full Members." Causa: Pandoc smart quotes separa `''` (dois single-quotes) em dois right-single-quotes com thin space. Mesmo problema em: "theoretical' ' from effective' '" (page 20), "interests.' '" (page 21).
- **Fix**: Substituir `` ``...'' `` por `"..."` (aspas retas) no .Rmd para que Pandoc smart quotes produza aspas corretas.

### Pages 20-21: OPEC cont + Scope
- MAJOR: Aspas separadas (ver page 19 acima) — 3 ocorrencias no total
- PASS: Math renders corretamente ($\alpha^*_{\text{cont}} \geq \alpha^*$ agora OK)

### Page 22: Scope cont
- PASS: Cross-reference Figure 4 funciona (usa `\@ref` corretamente fora de ambiente LaTeX)

### Pages 23-24: Figure 4 (heatmap)
- MAJOR: **Whitespace excessivo** — page 23 tem apenas 5 linhas de texto + ~75% whitespace. Figure 4 (4 panels) nao cabe na mesma pagina. Inevitavel com `fig.width=10, fig.height=8`, mas reduzir para `fig.height=7` poderia permitir que coubesse.

### Pages 25-26: Conclusion
- PASS: Texto limpo, math correta
- MAJOR: **Page 26 quase vazia** — Conclusion termina com 5 linhas no topo, ~85% whitespace antes do Appendix na page 27. Considerar `\clearpage` antes do Appendix para evitar a pagina fantasma, ou permitir que o Appendix comece na mesma pagina.

### Page 27: Notation table
- MINOR: Overfull hbox (22.6pt) — tabela ligeiramente mais larga que text area. Considerar `\small` ou `\footnotesize` na tabela, ou `tabularx`.

### Pages 28-30: Appendix A (Derivations)
- PASS: Equacoes numeradas, derivacoes claras
- MINOR: Overfull hbox (7pt) na proof de B.1 (line 803-805) — overflow menor em expressao math inline

### Pages 31-43: Appendix B (Proofs)
- PASS: Proofs bem estruturados com Steps numerados
- PASS: QED symbols ($\square$) corretos
- MINOR: Underfull hbox em 3 linhas (badness 1600-3100) — spacing ligeiramente irregular em paragrafos com muita math inline

### Pages 44-49: Appendix C (Continuous Types)
- MAJOR: Overfull hbox (42pt) em equacao na line ~1091 do .tex — equacao transborda significativamente. Checar se e displayed equation que precisa de `\small` ou quebra em 2 linhas.
- PASS: Proposicao 5 e derivacoes claras

### Pages 49-50: References
- PASS: Formatacao consistente, todos os entries renderizam

## Problemas recorrentes

1. **Aspas LaTeX-style (`\`\`` e `''`) vs Pandoc smart quotes**: Dentro de Pandoc markdown, `''` e processado como dois single-quotes separados, nao como closing double-quote. Afeta 3 citacoes diretas no Discussion.

2. **`\@ref()` dentro de ambientes LaTeX raw**: Bookdown so processa `\@ref()` em markdown puro. Dentro de `\begin{...}\end{...}`, usar `\ref{}` diretamente.

3. **Whitespace por figure placement**: Figuras grandes (4-panel heatmap, game tree) forçam page breaks com whitespace significativo.

## Top 3 melhorias de maior impacto

1. **Corrigir cross-reference em Remark 3** (CRITICAL): `\@ref(fig:parameter-regions)` → `\ref{fig:parameter-regions}` na line 406. Visivel como texto quebrado no corpo do paper.

2. **Corrigir aspas separadas no OPEC/Scope** (MAJOR): Substituir `\`\`...\`\`` e `''` por `"..."` (aspas retas) nas lines 509, 511, 517. Renderizam como .' ' em vez de ."

3. **Reduzir whitespace pages 23 e 26** (MAJOR): Ajustar `fig.height` do heatmap e/ou permitir Conclusion+Appendix na mesma pagina.

## LaTeX warnings

| Warning | Location | Severity |
|---------|----------|----------|
| Overfull hbox 22.6pt | Notation table (p.27) | MINOR |
| Overfull vbox 20.2pt | Appendix pages 27-34 | MINOR |
| Overfull hbox 7.0pt | Proof B.1 (p.33) | MINOR |
| Underfull hbox x3 | Proofs B.5/B.5a | MINOR |
| Overfull hbox 41.9pt | Appendix C eq. | MAJOR |
