# Auditoria de figuras — drafts da sessão de tooling (Tarefa C) vs. figuras do paper

**Data**: 2026-08-21
**Skill**: ggplot-dataviz (modo auditoria; gates de `references/quality-gates.md` e integridade gráfica)
**Objetos auditados**: `figures/draft/figure_c1_o_plane_n5_nu035.pdf`, `figure_c2_nu_partition_n5.pdf`, `table_c1_margin_n5.pdf` (worktree `essential-input-support`, branch `codex/essential-input-support-harness`; código em `scripts/region_plot_functions.R` + `scripts/essential_input_formulas.R`)
**Referência de comparação**: `figures/relative_package_institutional_phase_diagram_piH0.pdf` (arquitetura antiga — matemática superada, desenho correto)
**Gatilho**: impressão do autor de que os drafts são pouco informativos ("não entendi nada"), enquanto as figuras antigas, mesmo com matemática errada, "estão no caminho certo". **A impressão está correta, e o defeito é identificável e barato de corrigir.**

## Diagnóstico central

**As figuras antigas pintam regiões rotuladas pela RESPOSTA do paper; os drafts novos pintam regiões rotuladas pela MAQUINARIA da solução.** O phase diagram antigo tem eixos (prior μ, custo de entrada χ) e quatro regiões que são conclusões: "Both: H prefers unanimity", "Both: H prefers majority", "Majority only", "No institution". Um leitor que nunca viu o modelo entende o resultado em cinco segundos. Os drafts novos têm regiões rotuladas "Exclusão (E)", "Screening (S)", "Pooling (P)", "No pure-vote PBE" — classes de equilíbrio POR REGRA, isto é, os insumos intermediários da derivação, sem nenhuma comparação entre regras codificada. As duas facetas de C.1 são taxonomias separadas; nada na figura responde "comparado a quê?" (falha direta do Design Gate). O leitor não tem como extrair da figura a pergunta do paper — quem ganha o quê, e sob qual regra H prefere qual instituição.

## Findings por figura

### Figura C.1 (plano o₀ × o₁, ν fixo em 0.35, facetas por regra)

1. **[CRÍTICO — design] Regiões erradas para o propósito**: classes de equilíbrio em vez de comparação institucional/preferência de H. Sem encoding cruzando as regras, a figura não tem variável dependente substantiva.
2. **[ALTO] Plano errado para a narrativa**: fixar ν=0.35 (valor arbitrário) e variar (o₀,o₁) esconde a variável da história do paper — ν, a credibilidade da força do hegemon (é nela que vivem ν*, a zona sem PBE puro e a futura ΔRI). O painel só faria sentido como apêndice de robustez.
3. **[MÉDIO] Sliver azul enganoso**: a região de screening sob maioria em ν=0.35 é uma tira fina (o₀ ≲ 0.055) — visualmente parece artefato numérico. Verifiquei a álgebra (ν_SE(o₀) com m=4, q=3, β=0.9 cruza 0.35 em o₀≈0.055): a matemática está certa; o problema é a escolha de corte transversal que torna a região ilegível.
4. **[MÉDIO] Fronteiras rasterizadas**: regiões preenchidas por grade produzem bordas serrilhadas. Todas as fronteiras têm forma fechada (ν*, ν_SE, ν_SP, o=1/m) — devem ser desenhadas como curvas analíticas com rótulo da fórmula na própria curva, e as regiões como polígonos.
5. **[MENOR] Sem pontos de exemplo trabalhado** (checklist formal-model-presentation): marcar o ponto (o₀,o₁) do exemplo N=5 do paper ancoraria a leitura.

### Figura C.2 (duas barras 1-D em ν)

1. **[ALTO] Densidade de dados ~zero**: uma figura inteira para comunicar dois números (o cutoff de maioria e ν*). Nível Tufte: razão tinta/informação indefensável como figura de paper; como diagnóstico interno, aceitável.
2. **[MÉDIO] Legenda lista região inexistente**: "Acordo low-only (L)" (roxo) nunca aparece no gráfico — L existe só no ponto de medida nula ν=0. Legenda com categoria fantasma confunde em vez de informar; o endpoint deveria ser um marcador pontual anotado, não uma categoria de área.
3. **[MÉDIO] Cutoffs distintos visualmente indistinguíveis**: com estes parâmetros, ν_SE (maioria) ≈ 0.28 e ν* (unanimidade) ≈ 0.278 quase coincidem, e só ν* está tracejado — convida à leitura falsa de que é o mesmo corte. Ou anotar os dois, ou escolher parâmetros que os separem.
4. **[FALHA DE PROPÓSITO] Sem payoffs**: a partição em ν só ganha sentido ao lado do que cada lado paga a H — que é o que falta (ver redesenho F2).

### Tabela C.1 (margens das fronteiras)

**OK como ferramenta interna** — margin tables estão no checklist de apresentação como verificação, não como material de manuscrito. Nenhum reparo necessário além de mantê-la fora do paper. Coluna "Status" com termos mistos ("abaixo/acima" vs "estritamente satisfeita") merece uniformização.

### Nota de justiça com o agente de tooling

Parte da falha é herdada da especificação (minha): o prompt da Tarefa C mandou usar exclusivamente fórmulas dos nós congelados N1–N4 e proibiu consumir N6 — que ainda não estava congelado quando o prompt foi escrito. Sem N6, as únicas regiões desenháveis eram mesmo as classes de equilíbrio. **N6 agora está congelado**, o que destrava o redesenho abaixo. O módulo `essential_input_formulas.R` com fonte única de verdade e os CSVs de dados ao lado dos PDFs estão bem construídos — a infraestrutura serve; o que muda é o que se desenha com ela.

## Especificação de redesenho (três figuras candidatas ao paper)

**F1 — Mapa institucional (headline; sucessora do phase diagram antigo).** Eixos: ν (horizontal) × o₁ (vertical), com linha horizontal em o₁ = 1/m (limiar de hegemonia) e o₀ fixado em fração de o₁ (varrer em painéis de robustez). Regiões coloridas pela COMPARAÇÃO, agora computável com N6 congelado: "H prefere unanimidade", "indiferente", "H prefere maioria", por tipo ou ex ante — e, quando N7 congelar, recolorir por ΔRI (positiva / nula / vazia) com a célula "sem comparação: sem PBE puro" hachurada como está hoje. Fronteiras analíticas rotuladas (ν*, o₁=1/m). Esta figura responde a pergunta do paper.

**F2 — Preços e renda (a mecânica).** Payoff de H por tipo como função de ν, um painel por regra (ou tipos como linhas, regras como painéis): o plateau de pooling em h=βo₁, o nível de exclusão o_θ, o teto do substituto sob maioria, cutoffs verticais anotados, zona sem PBE puro sombreada. Depois de N7: adicionar as linhas tracejadas do benchmark público e sombrear a faixa entre privado e público — a faixa É a renda informacional, visível a olho. Esta figura explica o mecanismo (teto vs. sem teto).

**F3 — A estática do declínio (a narrativa OMC).** Corte em ν decrescente com (o₀,o₁,m) fixos: pooling com renda → zona de instabilidade (hachura) → ponto ν=0 (informação completa, H comprado barato), com anotações verbais curtas em cada regime. Versão anotada e com payoffs do que C.2 tentou ser. Candidata à Discussion.

**Descartar/rebaixar**: C.1 vira apêndice de robustez (com fronteiras analíticas); C.2 morre absorvida por F3; Tabela C.1 permanece interna.

## Gates (resumo)

| Gate | C.1 | C.2 | Tabela C.1 |
|---|---|---|---|
| Data | PASS (fórmulas dos nós congelados; CSVs ao lado) | PASS | PASS |
| Design | **FAIL** (sem "compared to what?"; plano errado; bordas serrilhadas) | **FAIL** (densidade ~0; legenda fantasma) | PASS (uso interno) |
| Statistical | n/a (modelo determinístico) | n/a | PASS |
| Output | PASS (PDF vetorial, texto legível, captions presentes) | PASS | PASS |

## Entrega (delivery note do skill)

- Código: `scripts/region_plot_functions.R`, `scripts/essential_input_formulas.R` (worktree `essential-input-support`).
- Figuras: `figures/draft/*.pdf` na mesma worktree (+ cópia em `post-n6-consolidation`).
- Checagens: leitura visual dos 3 PDFs; verificação de sanidade das fronteiras ν_SE e ν* nos parâmetros exibidos; comparação com o phase diagram antigo; gates acima.
- Não testado: execução dos scripts; consistência CSV↔PDF; os demais entregáveis da sessão paralela (harness A, calculadora B, bib D) — auditoria separada se o autor quiser.
