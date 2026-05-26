# Fixes pendentes: arquivos de submissão RIO

**Data**: 2026-04-30

## 1. Referências cruzadas quebradas no appendix (13 ocorrências)

O split separou main + appendix em dois .tex independentes. Referências do appendix a labels do main body viraram `??`.

### Mapeamento label → número (do 01_manuscript.aux)

| Label | Tipo | Número |
|---|---|---|
| `eq:alpha_star` | Equation | (4) |
| `eq:cutoff_R1` | Equation | (1) |
| `eq:jump_R1` | Equation | (3) |
| `eq:alpha_bar` | Equation | (2) |
| `thm:conditional` | Theorem | 1 |
| `prop:jump` | Proposition | 3 |
| `prop:majority` | Proposition | 1 |
| `cor:dominance` | Corollary | 1 |

### Linhas afetadas em `02_supplementary_appendix.tex`

| Linha | Referência | Substituir por |
|---|---|---|
| 173 | `\eqref{eq:alpha_star}` | `(4) in the main text` |
| 241 | `\eqref{eq:cutoff_R1}` | `(1) in the main text` |
| 246 | `\eqref{eq:jump_R1}` | `(3) in the main text` |
| 255 | `\eqref{eq:alpha_bar}` | `(2) in the main text` |
| 257 | `\ref{thm:conditional}` | `Theorem 1 in the main text` |
| 333 | `\eqref{eq:cutoff_R1}` | `(1) in the main text` |
| 444 | `\ref{prop:jump}` | `Proposition 3 in the main text` |
| 504 | `\ref{thm:conditional}` | `Theorem 1 in the main text` |
| 506 | `\ref{thm:conditional}` | `Theorem 1 in the main text` |
| 536 | `\ref{cor:dominance}` | `Corollary 1 in the main text` |
| 538 | `\ref{prop:majority}` | `Proposition 1 in the main text` |
| 659 | `\ref{thm:conditional}` | `Theorem 1 in the main text` |

**Nota**: verificar contexto de cada linha para decidir formato exato (e.g., "equation (4) in the main text" vs "Theorem~1").

## 2. Referência fantasma "Appendix B.5a"

No `formal_model_v5.Rmd` (linha ~930):
> "The decomposition is derived in Appendix B.5a."

Essa frase precisa ser removida (ou reescrita). Provavelmente o appendix B.5 já contém a derivação inline — a referência a "B.5a" como sub-seção separada parece vestigial.

**Arquivos a editar**:
- `formal_model_v5.Rmd` (~linha 930)
- `RIO submission files/01_manuscript.tex` (procurar mesma frase)
- `RIO submission files/02_supplementary_appendix.tex` (procurar mesma frase)

## 3. Recompilação

Após fixes, recompilar ambos os .tex **duas vezes** cada (para resolver cross-refs internas):
```bash
cd "RIO submission files"
xelatex 01_manuscript.tex && xelatex 01_manuscript.tex
xelatex 02_supplementary_appendix.tex && xelatex 02_supplementary_appendix.tex
rm -f *.aux *.log *.toc *.out
```
