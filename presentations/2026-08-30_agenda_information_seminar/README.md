# Seminário — agenda, informação e consenso

Entregáveis principais:

- `seminario_agenda_informacao.Rmd`: fonte Markdown/Beamer;
- `seminario_agenda_informacao.pdf`: apresentação principal renderizada;
- `seminario_agenda_informacao.pptx`: versão editável complementar;
- `roteiro_de_fala.md`: texto para apresentação oral de aproximadamente 30 minutos;
- `relatorio_calibracao_audiencias.md` e `.pdf`: testes de audiência, decisões de calibração e adaptações;
- `figures/`: cinco figuras numeradas em PNG e PDF;
- `scripts/01_generate_figures.R`: reprodução dos gráficos;
- `scripts/02_build_pptx.mjs`: reprodução do PowerPoint com `@oai/artifact-tool`;
- `scripts/03_render_slides.R`: reprodução do PDF Beamer.

## Reprodução

A partir da raiz do repositório:

```bash
LC_ALL=pt_BR.UTF-8 LANG=pt_BR.UTF-8 Rscript --vanilla presentations/2026-08-30_agenda_information_seminar/scripts/01_generate_figures.R
LC_ALL=pt_BR.UTF-8 LANG=pt_BR.UTF-8 Rscript --vanilla presentations/2026-08-30_agenda_information_seminar/scripts/03_render_slides.R
NODE_PATH=/Users/manoelgaldino/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules /Users/manoelgaldino/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node presentations/2026-08-30_agenda_information_seminar/scripts/02_build_pptx.mjs
pandoc presentations/2026-08-30_agenda_information_seminar/relatorio_calibracao_audiencias.md --from markdown+tex_math_dollars --pdf-engine=pdflatex --output presentations/2026-08-30_agenda_information_seminar/relatorio_calibracao_audiencias.pdf
```

## Fontes canônicas próximas

- `references/modelo_similar_geb.pdf` — Piazolo e Vanberg (2025), versão publicada na *Games and Economic Behavior*;
- `references/modelo_similar_public_choice.pdf` — Glynia, Thum e Xefteris (2026), *Public Choice*.

SHA-256 no snapshot consultado:

```text
c4558ecddec75a11f94f7dd61d22e6cccb8cfdc29eeaf9da4710a6eaa84968a6  references/modelo_similar_geb.pdf
f265b0d43303dfe6b827ac36cfda3b31c099c9531d11593196d9f8c64641c636  references/modelo_similar_public_choice.pdf
```

O arquivo `sources/piazolo_vanberg_2025_preprint.pdf` foi preservado apenas como proveniência da busca inicial; não foi usado como fonte canônica. A cópia baixada de Public Choice coincide byte a byte com a versão em `references/`.

## Limites formais do snapshot

- Repositório-base: `codex/essential-input`, commit `43307074d3f13e3457be3925b651f6f4557b58cb`.
- Extensão: `codex/agenda-total-effect`, commit `b3d299a0011be5d2bdb005639fd320a4ea13890a`.
- Verificador corrente da extensão: `121 PASS / 0 FAIL`.
- A_M, A_U, A_C e A_R: `pass/frozen`, com aprovação autoral.
- A_T: duas revisões independentes `PASS 0/0/0`, sem defeito confirmado, mas ainda `reviewed/unfrozen` e sem aprovação terminal no snapshot usado.

Assim, os slides apresentam A_T como resultado revisado, não como resultado congelado. A apresentação não altera nem migra o manuscrito formal.
