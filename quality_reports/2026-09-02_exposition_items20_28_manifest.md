# Manifesto dos itens de exposição 20--28

**Data:** 2026-09-02

**Status:** **PASS — candidato fixado localmente**

**Manuscrito:** `formal_model_v6.Rmd`

**PDF:** `formal_model_v6.pdf`

## Escopo autorizado e resultado

O autor autorizou os itens 20, 21, 22, 23, 25, 26, 27 e 28 do rol
consolidado a partir de `quality_reports/2026-09-02_review-formal-model.md`.
Eles foram implementados assim:

20. remoção, do texto e das figuras visíveis, do jargão interno de revisão e
    proveniência;
21. substituição de formulações defensivas por regras positivas e termos
    definidos para o leitor;
22. apresentação de \(T=D+I\) como identidade contábil, sem enquadramento
    causal ou pseudofatorial;
23. remoção de pseudofiguras e duplicações, com gráfico real do gap público,
    tabela de reversão e mapa da existência no jogo de agenda;
25. walkthrough da Figura 3 (`fig:privatecompare`), preservando a leitura por
    tipo e a célula vazia;
26. promoção da contraprova com \(m=4\), mostrando que a condição suficiente
    de vantagem da maioria não é necessária;
27. inclusão da intuição econômica para a incidência das rendas nos tipos
    baixo e alto;
28. correções locais de voz, prosa, terminologia, captions e paginação.

A apresentação técnica foi revisada no mesmo passe. Em particular, payoff
escalar, vetor ligado e imagem set-valued agora são objetos distintos:
\(V_{g,o}^A(R_g)\), \(\mathbf V_g^A(R_g)\) e \(\mathcal V_g^A\). As imagens
\(\mathcal V_U^A\) e \(\mathcal{IR}_U^A\) usam conjuntos unitários nos ramos
singleton. A variável \(u\) deixou de acumular três funções incompatíveis;
\(x_{\min}\), \(z\), \(\mathbf z_U\) e \(\mathbf z_M\) separam os objetos. A
notação \(\mathcal J_A^{\mathrm{cmp}}\) e o mapa posterior
\(\widehat\mu\) são usados de modo consistente e definidos antes do uso.

As provas transportadas para o item 13 permanecem no próprio manuscrito em
B.7--B.9. A auditoria final não encontrou regressão do item 16.

## Fronteira de versão

- Branch de trabalho: `codex/exposition-items20-28`.
- Tag anotada anterior às mudanças:
  `pre-exposition-items20-28-2026-09-02`.
- Commit anterior às mudanças:
  `7829dfe18b1d048c94b3c491d09890e5616c547d`.
- Commit exato do manuscrito e PDF aprovados pelos três revisores:
  `68ed3d8724004d359f39baf2ea39fb469960ec4f`.
- `main` permaneceu em `32ac8b426cc488e2254dd3987ac44b569664f737`.
- Nenhum push, merge ou alteração de `main` foi realizado.

Checkpoints do passe:

1. `0a98087` — implementação inicial dos itens 20--28;
2. `44e735e` — correção das bordas do mapa, paginação e primeira rodada de
   resíduos notacionais;
3. `68ed3d8` — tipagem uniforme das imagens set-valued e eliminação do último
   overflow.

Os pareceres intermediários reprovados não cobrem o candidato final. Os três
PASS abaixo se vinculam exclusivamente ao commit `68ed3d8` e aos hashes
registrados neste manifesto.

## Bytes aprovados

```text
6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411  formal_model_v6.Rmd
55c4a70af928ead805949efd3d6bc6ff6125c01787cec09b8b26b058e57a0382  formal_model_v6.pdf
97f18ecf1f786aee5481011620d200d0495f7f8243a0f222eca8ae53ed8a5a09  scripts/generate_agenda_extension_figures.R
54849bd55cd04d256458724920b6bd7ba72b2ac437939e05050a863e9a54774d  scripts/essential_input_manuscript_figure_functions.R
0064c782c999ec85cc0efe2a3d34bb10f38536f43a1df730db0bd5e4d11ffac5  figures/agenda_extension/figure_agenda_public_gap.pdf
f2d091da9e587da71f56ea7f7fd3c9a3aaac61c684357ac8641ee6c657f3a976  figures/agenda_extension/figure_agenda_unanimity_existence.pdf
fa010d98324fcf2a8951ec5039bd720b132142d14ced9b262155d1790dc434cc  figures/agenda_extension/figure_agenda_unanimity_existence.png
dd51052dea67a00dee03134e56ed7f92c1b7697256d2b5a6473c873bcc8eb07d  figures/agenda_extension/figure_agenda_unanimity_existence_data.csv
19c9a265d11cdbc4604dbc819a65cb70d1f407d76be10234054edcd9b0fc5c06  figures/essential_input/figure_f1_private_comparison.pdf
214910676bf3a5552c83e2e13053577654106cb9bcbb0040323fe35684f26f5f  figures/essential_input/figure_f2_prices_coalitions.pdf
736f389047a459ee2ac210115a8a1890a7fa2eebe45c3d4ae9a50e3101e4a79b  figures/essential_input/figure_f3_power_information.pdf
f3872b714b51e9e67937ffbb764caea671c5ac9a90c27deb0a71c5ebc83316b2  figures/essential_input/figure_f4_hegemonic_decline.pdf
```

O PDF aprovado tem 78 páginas.

## Evidência de validação

Renderização:

```sh
Rscript --vanilla -e \
  'rmarkdown::render("formal_model_v6.Rmd", output_file="formal_model_v6.pdf", quiet=TRUE)'
```

Resultado: PASS. `pdfinfo` não registrou arquivo suspeito; a extração de texto
não encontrou `??` nem remissões indefinidas. Os avisos de locale do R são do
ambiente e não impediram a renderização.

Verificadores mecânicos:

- maioria com agenda: `3954 PASS | 0 FAIL`;
- unanimidade com agenda: `1110 PASS | 0 FAIL`.

Esses verificadores cobrem seus domínios algébricos e construtivos declarados;
não substituem as provas de completude de PBE nem a revisão independente.

Checagem dos artefatos gráficos: PASS para os dois PDFs da extensão de agenda
e para os quatro PDFs do bloco `essential_input`. O mapa registra exatamente

\[
\{(0,0),(1,1)\}\cup((p^*,1)\times\{0\})
\cup((p^*,1)\times(p^*,1]),
\]

com inclusão e exclusão das bordas também codificadas no CSV.

Revisão independente e somente leitura do commit `68ed3d8`:

- invariância matemática: `PASS 0/0/0`;
- apresentação técnica e consistência notacional: `PASS 0/0/0`;
- exposição e inspeção visual das 78 páginas: `PASS 0/0/0`.

A inspeção visual confirmou ausência de overflow, cortes, glifos defeituosos,
viúvas problemáticas e referências quebradas. Confirmou também que o jargão
interno não aparece no PDF.

## Auditoria de edição concorrente

O working tree e o índice foram conferidos repetidamente contra `HEAD`. O
reflog contém apenas os commits desta tarefa; `main` e as demais branches
locais não avançaram; não havia `index.lock`; e os revisores encerraram com o
working tree limpo. Não foi encontrada evidência de que Claude ou outro
processo tenha sobrescrito o manuscrito, o PDF, os scripts ou as figuras deste
candidato.

## Recuperação não destrutiva

Para abrir a versão anterior às mudanças sem mover ou apagar esta branch:

```sh
git switch -c recovery/exposition-pre-items20-28 \
  pre-exposition-items20-28-2026-09-02
```

Depois da criação do tag do candidato, ele poderá ser inspecionado assim:

```sh
git switch --detach v6-exposition-items20-28-candidate-2026-09-02
```

Ambos os comandos preservam integralmente a branch de trabalho e seu histórico.
