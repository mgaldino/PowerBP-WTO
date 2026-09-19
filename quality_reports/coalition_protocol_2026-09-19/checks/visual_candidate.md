# QA visual integral do PDF candidato — 2026-09-19

**Resultado:** 83 de 83 páginas efetivamente inspecionadas. Nenhum defeito bloqueante de layout foi observado. Este registro cobre a apresentação visual do artefato identificado abaixo; não é parecer científico, revisão matemática nem autorização de submissão.

## Artefato e proveniência

- Rmd inspecionado na compilação: `9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f`.
- PDF inspecionado: `a65cea77402d1e73a402ae49bbb4a6839298816f14703a2693309534bc5a61e5`, 83 páginas US Letter.
- Cópia durável do PDF: [inspected_candidate.pdf](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/snapshots/inspected_candidate.pdf).
- Fonte temporária: `/var/folders/_7/m0js68194rsd8xswh57rn_kh0000gn/T/peio-coalition-layout-tsthv819/formal_model_v6.Rmd`.
- PDF temporário: `/var/folders/_7/m0js68194rsd8xswh57rn_kh0000gn/T/peio-coalition-layout-tsthv819/formal_model_v6.pdf`.
- A compilação com saída zero foi informada pelo coordenador. Nesta tarefa, os hashes foram conferidos antes da renderização e novamente após a inspeção.
- Nem o Rmd, nem o PDF, nem figuras-fonte foram alterados por esta tarefa.

## Método e cobertura

Todas as páginas foram renderizadas por Poppler a 120 dpi, produzindo PNGs de 1020 × 1320 pixels. Foram exibidas e inspecionadas as 42 folhas de contato: páginas consecutivas em pares de 1–2 até 81–82, mais a página 83. A conferência visual abrangeu margens, cortes, sobreposições, hierarquia de títulos, tabelas, fórmulas, diagramas, figuras, captions e referências. A existência dos PNGs, sozinha, não foi usada como evidência de inspeção.

As páginas 11, 18, 20, 24, 51, 52, 67, 68 e 73 receberam uma segunda inspeção a 200 dpi. A página 24 também foi renderizada e inspecionada com Quartz para resolver uma diferença de fonte do renderizador local.

Os PNGs completos e contatos estão em `/var/folders/_7/m0js68194rsd8xswh57rn_kh0000gn/T/peio-coalition-layout-tsthv819/visual_candidate`. O manifesto de renderização tem SHA256 `bd3115f7f48f176fde6a32e7bc38a2dafe946d5ab6eea871379c7010cdfaed5d`. O JSON que acompanha este relatório preserva os hashes de todas as 83 imagens, a cobertura por página e os hashes das ampliações.

| Páginas | Cobertura | Observação visual |
| --- | --- | --- |
| 1–2 | Inspecionadas | Title/abstract, introduction, page numbers and text margins legible; no clipping or overlap. |
| 3–4 | Inspecionadas | Introduction and section/subsection transitions legible; no overflow. |
| 5–6 | Inspecionadas | Table 1 and surrounding literature text readable; columns remain distinct, rules and caption intact. |
| 7–8 | Inspecionadas | Literature, numerical illustration, inline/display mathematics and start of model legible. |
| 9–10 | Inspecionadas | Coalition-space display and Table 2 fit the margins; mathematical symbols and payoff columns readable. |
| 11–12 | Inspecionadas | Figure 1 labels, arrows and Any refusal branch are separated; caption and Table 3 readable without overlap. |
| 13–14 | Inspecionadas | Public benchmark formulas and Table 4 legible; table rows and column boundaries intact. |
| 15–16 | Inspecionadas | Cutoff fractions, numbered proposition cases and unanimity display fit and are legible. |
| 17–18 | Inspecionadas | Table 5 is readable and intact. Figure 2 panels and caption fit; its smaller internal labels were also inspected at 200 dpi. |
| 19–20 | Inspecionadas | Proposition 5.5 is readable. Figure 3 panels, external caption and margins are intact; its internal legend was also inspected at 200 dpi. |
| 21–22 | Inspecionadas | Multi-case informational-rent displays readable and uncut; continuation across pages intact. |
| 23–24 | Inspecionadas | Explanatory paragraphs and Figure 4 fit; its internal labels were inspected at 200 dpi and page 24 also by Quartz. Agenda section opens without collision. |
| 25–26 | Inspecionadas | Agenda formulas, off-path fraction and public piecewise benchmarks are legible and within the margins. |
| 27–28 | Inspecionadas | Figure 5 curve and axes, Table 6 columns and its note are readable and intact. |
| 29–30 | Inspecionadas | Six-case display and Figure 6 fit without clipping. Page 30 contains a short continuation paragraph followed by substantial whitespace; no clipped content was observed. |
| 31–32 | Inspecionadas | Institutional-product formulas, inequalities and the boxed accounting identity are legible without collisions. |
| 33–34 | Inspecionadas | Agenda decomposition box, public piecewise effects and start of discussion fit without clipping. |
| 35–36 | Inspecionadas | Discussion and limits sections have legible body text, mathematical symbols and subsection headings. |
| 37–38 | Inspecionadas | Conclusion and Appendix A transitions are clear; protocol and belief notation remains legible. |
| 39–40 | Inspecionadas | Appendix B headings, terminal-round derivations and displayed inequalities fit within margins. |
| 41–42 | Inspecionadas | Majority comparison displays and unanimity continuation cases fit within margins; long inline formulas remain legible. |
| 43–44 | Inspecionadas | Numbered four-case argument, proof endings and Appendix B.7 heading are clearly separated and readable. |
| 45–46 | Inspecionadas | Agenda payoff and coalition formulas are readable; page 46 leaves whitespace after an intact display, without clipping. |
| 47–48 | Inspecionadas | Measure integrals, supremum definition and three-line membership criterion are intact and legible; no collision in long formulas. |
| 49–50 | Inspecionadas | Majority lower-bound displays and beginning of Appendix B.8 are intact; superscripts and cutoff vectors remain readable. |
| 51–52 | Inspecionadas | New support-point lemma, integral identity and local-Bayes fraction are legible; text flows across the page break without clipping or overlap. |
| 53–54 | Inspecionadas | Pooling display, unanimity bound, orbit-law definitions and Appendix B.9 heading are readable and within the page. |
| 55–56 | Inspecionadas | Factorization integrals and Appendix C headings are clear. Wide envelope formulas fit the available line width. |
| 57–58 | Inspecionadas | Table 7 notation spans pages with repeated column headers; symbols, descriptions and wrapped entries remain aligned and readable. |
| 59–60 | Inspecionadas | Notation table conclusion and Appendix E.1 formulas are intact; the long appendix heading wraps across two lines, without overlap. |
| 61–62 | Inspecionadas | Table 8 spans two pages with repeated headers and intact mathematical cells; numerical witness and assessment tuple are readable. |
| 63–64 | Inspecionadas | Three-line conditions, kernels, joint-law integral and signatures fit within margins; all mathematical elements are readable. |
| 65–66 | Inspecionadas | Unanimity primitives, assessment tuple and numbered low-posterior conditions are legible without overlap. |
| 67–68 | Inspecionadas | Compact endpoint-law conditions and six-case payoff image fit within margins. Superscripts, braces and explanatory paragraph are intact. |
| 69–70 | Inspecionadas | Signature formulas, comparison-product display and majority-advantage bounds are readable and unclipped. |
| 71–72 | Inspecionadas | Public-majority and unanimity formulas, piecewise effects and subsection headings are readable and distinctly separated. |
| 73–74 | Inspecionadas | Table 9 fits on the page; its small mathematical cells were also inspected at 200 dpi. Decomposition formulas and numerical identities are intact. |
| 75–76 | Inspecionadas | Accounting array, piecewise public effects and six-case total-difference display are legible and within margins. |
| 77–78 | Inspecionadas | Sign conditions, diagonal contrast and Appendix F transition are clear; signature displays fit. |
| 79–80 | Inspecionadas | Outcome-law tuple, envelope identities and interaction cases are intact; compact condition text remains readable and headings do not collide. |
| 81–82 | Inspecionadas | Final scope section, existence bullets and beginning of references are legible. Bibliographic entries, hanging indents and URLs remain within margins. |
| 83 | Inspecionadas | Final reference page is intact, with readable bibliographic text, URL wrapping and page number. |

## Ampliações

| Página | DPI | Conferência |
| --- | --- | --- |
| 11 | 200 | Figure 1: every box, arrowhead and branch label including Any refusal is separated and intact. |
| 18 | 200 | Figure 2: panel labels, legends, payoff lines, markers and internal notes are readable when enlarged; no clipping or overlap. |
| 20 | 200 | Figure 3: region boundaries, hatching, legends and internal note are readable when enlarged; no clipping or overlap. |
| 24 | 200 | Figure 4 panels, legends and note are legible when enlarged. Poppler omits the Delta glyph from the third horizontal label; the independent Quartz render displays Delta IR^B correctly. This is a local-renderer limitation, not an incorrect PDF label. |
| 51 | 200 | Support-point lemma title, statement, prose and Bayes integral are intact and legible. |
| 52 | 200 | Local-Bayes fraction, inequalities and witness display are intact and legible. |
| 67 | 200 | Compact three-case endpoint-law display fits; braces, masses and conditions are intact. |
| 68 | 200 | Six-case payoff image is fully visible, aligned, and legible; no overflow. |
| 73 | 200 | Table 9 mathematical cells and wrapped expressions remain readable and separated. |

## Observação do renderizador: VQA-OBS-01

Na Figura 4, página 24, Poppler omitiu o glifo Δ do terceiro rótulo horizontal, exibindo apenas `IR^B`. A extração de texto do mesmo PDF preserva `∆IRB`; a fonte do gráfico pede `expression(IR[M]^B, IR[U]^B, Delta*IR^B)`. O diagnóstico de fontes mostra Helvetica, Helvetica-Bold e Symbol padrão não embutidas nessa figura, e Poppler emitiu aviso de cache Fontconfig não gravável. A causa exata da substituição local não foi isolada.

A renderização independente pelo Quartz mostra **ΔIRᵇ corretamente**. O coordenador também inspecionou esse PNG e adjudicou a hipótese de defeito do rótulo/artefato como **REFUTED**. Trata-se, portanto, de uma limitação observada no renderizador local, resolvida para esta inspeção pela evidência visual alternativa. Nenhum reparo do conteúdo ou do PDF foi feito.

Evidências duráveis:

| Evidência | SHA256 |
| --- | --- |
| [poppler-24-third-label.png](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/visual_evidence/poppler-24-third-label.png) | `bd878f3ae3323b68a6bc6c216c5c6f638a4fa292cd6e906edf5d260b64bc83c8` |
| [poppler-24.png](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/visual_evidence/poppler-24.png) | `7523eba082f40b93469d70088ab0d0426c57446056d3b2c95a9ad1b0bbb90426` |
| [quartz-24.png](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/visual_evidence/quartz-24.png) | `500cc5905ea118f3026fe953f753a275a59c72663e8dae4eddcc572b62b5c7eb` |
| [render_quartz_page.swift](/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/quality_reports/coalition_protocol_2026-09-19/checks/visual_evidence/render_quartz_page.swift) | `a2e0efdc6e516d2e5b436f3ac6b505f215d2cc39e0f9f146b2e307613a191f58` |

O script Quartz foi executado contra a cópia durável do PDF. Seu PNG é byte a byte idêntico ao PNG Quartz efetivamente exibido nesta inspeção. O cache Swift permanece apenas no diretório temporário e não foi copiado para o repositório.

Para reproduzir a página 24, a partir da raiz do repositório em macOS:

```sh
swift -module-cache-path /private/tmp/peio-visual-quartz-module-cache quality_reports/coalition_protocol_2026-09-19/checks/visual_evidence/render_quartz_page.swift quality_reports/coalition_protocol_2026-09-19/snapshots/inspected_candidate.pdf 24 /private/tmp/peio-visual-quartz-24.png 200
```

A renderização Poppler integral utilizou `pdftoppm -r 120 -png INPUT.pdf visual_candidate/page`; as ampliações utilizaram `-f PAGE -l PAGE -r 200 -singlefile`.

## Limites

A inspeção confirma somente o resultado visual observado neste PDF exato. As fórmulas foram examinadas quanto à legibilidade e ao layout, sem reavaliar sua validade matemática. Textos internos pequenos das Figuras 2–4 e da Tabela 9 foram conferidos por ampliação; não houve inspeção de uma impressão física.

A inspeção não se transfere automaticamente ao PDF canônico recompilado. A comparação de hashes ou imagens das 83 páginas e, se necessário, a reprodução Quartz da página 24 serão registradas separadamente pelo coordenador.

