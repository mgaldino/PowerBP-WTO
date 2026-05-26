# Como gerar os arquivos de submissão RIO

## Pré-requisitos

- `formal_model_v5.Rmd` compilando sem erros (`rmarkdown::render()`)
- R com pacotes `tidyverse`, `knitr`, `bookdown`
- XeLaTeX instalado (TinyTeX ou TeX Live)
- Python 3 (para o script de split)

## Passo 1: Renderizar o .tex

```bash
cd /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion
Rscript -e 'rmarkdown::render("formal_model_v5.Rmd", output_options=list(keep_tex=TRUE))'
```

Isso gera `formal_model_v5.tex` e as figuras R em `formal_model_v5_files/figure-latex/`.

## Passo 2: Separar main + appendix e anonimizar

```bash
python3 scripts/split_for_submission.py
```

O script (ver abaixo) lê `formal_model_v5.tex` e gera na pasta `RIO submission files/`:

- `01_manuscript.tex` — body até Conclusion + References, anonimizado (sem autor)
- `02_supplementary_appendix.tex` — Appendices A-C + References, standalone

Ambos com `%!TEX TS-program = xelatex` na primeira linha.

## Passo 3: Copiar figuras

```bash
DIR="RIO submission files"
# Figuras TikZ (já existem, geradas manualmente uma vez)
# fig1_gametree.pdf — compilar fig1_gametree.tex se necessário
# fig2_screening_schematic.pdf — compilar fig2_screening_schematic.tex se necessário

# Figuras R (geradas pelo render)
cp formal_model_v5_files/figure-latex/parameter-regions-1.pdf "$DIR/fig3_parameter_regions.pdf"
cp formal_model_v5_files/figure-latex/heatmap-alpha-mu-1.pdf "$DIR/fig4_heatmap_alpha_mu.pdf"
```

## Passo 4: Compilar e verificar

```bash
cd "RIO submission files"
xelatex 01_manuscript.tex
xelatex 02_supplementary_appendix.tex
```

Verificar: 0 erros, ~27pp main, ~26pp appendix.

## Passo 5: Limpar

```bash
rm -f *.aux *.log *.toc *.out
```

## Estrutura final para upload

| Arquivo | Tipo no Springer | Notas |
|---|---|---|
| `title_page_RIO.tex` | Title Page | Não-anônimo (autor, afiliação) |
| `01_manuscript.tex` | Manuscript | Primeiro item, anônimo |
| `fig1_gametree.pdf` | Figure | |
| `fig2_screening_schematic.pdf` | Figure | |
| `fig3_parameter_regions.pdf` | Figure | |
| `fig4_heatmap_alpha_mu.pdf` | Figure | |
| `references.bib` | LaTeX Supporting File | |
| `02_supplementary_appendix.tex` | Supplementary Material | Online Appendix |
| `01_manuscript.pdf` | Supplementary (ref) | PDF compilado para referência |
| `02_supplementary_appendix.pdf` | Supplementary (ref) | PDF compilado para referência |

## Regras Springer/RIO

- Todos os arquivos no mesmo nível (sem subpastas)
- Main .tex deve ser o primeiro item
- XeLaTeX: primeira linha `%!TEX TS-program = xelatex`
- Figuras como arquivos separados (PDF/EPS/PNG)
- `.bib` e outros .tex auxiliares como "LaTeX Supporting File(s)"

---

## Script: `scripts/split_for_submission.py`

Gera `01_manuscript.tex` e `02_supplementary_appendix.tex` a partir de `formal_model_v5.tex`.

Lógica:
1. Lê o .tex completo
2. Identifica 4 marcadores: `\begin{document}`, `\appendix`, `\section*{References}`, `\end{CSLReferences}`
3. Main = preamble (sem autor) + body até `\appendix` + References + `\end{document}`
4. Appendix = preamble (título "Online Appendix") + `\appendix` até References + References + `\end{document}`
5. Substitui paths de figuras para nomes flat (`fig3_parameter_regions.pdf`, etc.)
