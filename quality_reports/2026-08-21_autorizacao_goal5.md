# Autorização autoral do Goal 5

**Data:** 2026-08-21
**Status:** `APPROVED`
**Escopo imediato:** abrir o Goal 5, criar a fronteira de versão e produzir a
matriz de migração `DRAFT`; nenhuma edição de `formal_model_v6.Rmd` antes da
aprovação explícita dessa matriz.
**Snapshot autorizado:** `e0ff1aceb3d8b9ebeeea56feb65c019dafd32854`
**SHA-256 do texto autoral recebido:**
`d4061cbf7b30230a4a641509660c59d8ae30f914bc2e51afb8a95edca2b22fab`

## Texto autoral literal

> Autorizo formalmente o Goal 5 — migração dos resultados congelados para
> formal_model_v6.Rmd — nos termos abaixo. Pré-condições verificadas em
> 2026-08-21: N1–N4, N6 e N7 pass/frozen com dois PASS 0/0/0 cada; Goal 4
> encerrado com meu aval literal; consolidação em e0ff1ac com árvore limpa.
>
> VERSIONAMENTO. Manter formal_model_v6.Rmd como alvo. Criar a tag local
> pre-goal5-essential-input-2026-08-21 em e0ff1ac; não mover nenhuma tag
> histórica. Worktree própria a partir desse commit. Incorporar à worktree o
> branch codex/essential-input-figures-narrative após o round 4 de retoques.
> formal_model_v5.Rmd, a pasta "RIO submission files/" e todos os artefatos
> congelados permanecem intocados.
>
> MATRIZ DE MIGRAÇÃO ANTES DE EDITAR. Produzir
> quality_reports/plans/2026-08-XX_goal5_migration_matrix.md (status DRAFT)
> mapeando cada seção, proposição, lema, prova, figura e tabela do v6 atual para
> uma de quatro ações — permanece, reescrito, removido, substituído — com, para
> cada resultado migrado, o nó e o hash da interface congelada de origem.
> Marcar explicitamente as passagens que dependem das decisões autorais
> pendentes P1 (timing de o_θ), P2 (b_θ = 0) e P3 (janela ex ante). A matriz só
> vira APPROVED com minha aprovação explícita; nenhuma edição do .Rmd antes
> disso.
>
> ESCOPO MATEMÁTICO. Migrar somente resultados congelados: PBE em estratégias
> puras, m ≥ 3, sem equilíbrios mistos, exemplo motivador em N=5 a partir de N2
> congelado. A região 0 < ν ≤ ν* entra como proposição de inexistência de PBE
> puro, com a intuição do ciclo; a descontinuidade em ν=0⁺ entra como resultado;
> a leitura de instabilidade sob declínio contestado entra só na Discussion,
> com os guardrails registrados (qualitativa, análoga a ciclos de Edgeworth,
> nunca teorema). A convenção de timing de o_θ e b_θ = 0 devem ser DECLARADAS
> explicitamente como primitivas do modelo (são o que está congelado); as frases
> que as interpretam substantivamente ficam marcadas [AUTHOR: P1]/[AUTHOR: P2]
> no rascunho; a janela ex ante migra como remark e figura, não como proposição,
> até decisão sobre P3. Os termos (1−β)·o_θ das tabelas de renda devem ser
> apresentados como cunha de timing, separados de d e k.
>
> CORPO E APÊNDICE. Corpo: intuição ANTES de cada proposição, resultados
> centrais, limites paramétricos, figuras. Apêndice: provas, correspondências
> completas, multiplicidade, envelopes e regiões sem PBE puro. Modelo em ~1
> página (padrão Hirsch–Shotts); cortar a árvore trivial dos estágios 0–1 e
> manter só a não trivial; implicações de policy na conclusão.
>
> CONCEITO DE SOLUÇÃO E CITAÇÃO. Seção de conceito com o pacote decidido
> (no-signaling + consistência estrutural; as-if-pivotal; T^Y por valor esperado)
> e a formulação bibliograficamente segura da restrição de suporte registrada
> em quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md — sem
> números de condição de Fudenberg–Tirole, sem "segue de Kreps–Wilson", NDOC
> como análogo mais forte de Osborne–Rubinstein. Parágrafo comparando o pacote
> com o de Piazolo–Vanberg (D1 + mistura + proposer-preferred) e explicando a
> região de inexistência.
>
> INTRODUÇÃO E LITERATURA. Arquitetura benchmark-primeiro conforme
> quality_reports/2026-08-21_honest_assessment_contribuicao_vs_literatura.md
> (v2 + adendo v3): informação completa = poder puro (Miller et al. 2018 e veto
> rights); mecânica de preços/sinalização creditada integralmente a
> Piazolo–Vanberg (GEB 2025) e Glynia–Thum–Xefteris (Public Choice 2026);
> novidade = substitutos não informados que desligam o canal informacional sob
> maioria, decomposição ΔRI, configuração hegemônica com opção externa fora da
> torta e π_H = 0, e a regra "unanimidade acrescenta renda ao tipo fraco exceto
> onde a maioria já faz pooling". Preempção de Feddersen–Pesendorfer em um
> parágrafo. Confirmar que as entradas de bibliografia da Tarefa D estão no .bib.
>
> FIGURAS. As figuras permanentes são a narrativa aprovada: F1 (mapa
> institucional com faceta ex ante; versão recolorida pelo sinal de ΔRI usando
> N7), F2 (preços e anatomia da coalizão), F3 (decomposição poder vs. informação,
> agora com os dados reais de N7 — remover o carimbo de placeholder), F4
> (estática do declínio), mais a figura de sequência do jogo. Nenhuma figura com
> rótulos de maquinaria (classes E/S/P, nomes de nós) como categoria principal.
> Captions completos em inglês. Calibração OPEC da arquitetura antiga: remover
> ou regenerar com as primitivas o_θ, com linguagem de "working numerical
> illustration".
>
> REGRAS DE TEXTO. Inglês; documento atemporal (nunca
> "now/previously/revised", nunca referência a versões); N genérico; sem rótulos
> legados A/C/R, C-B-R, random proposer ou opt-out; Lean não aparece; nenhum
> overclaim metodológico.
>
> FECHAMENTO. Compilar com rmarkdown::render("formal_model_v6.Rmd") sem
> sobrescrever output_format; inspecionar o PDF. Dois revisores independentes e
> read-only sobre o mesmo snapshot: fidelidade matemática às interfaces
> congeladas + desenho formal, e exposição + qualidade visual; pareceres
> completos em quality_reports/. Readability audit sem Pangram (Pangram só com
> minha dupla autorização explícita). Qualquer necessidade de resultado novo ou
> escolha substantiva pausa a migração e volta para mim. A tag final da versão
> migrada só após os dois PASS e meu aval, pelo workflow paper-version.

## Limite operacional corrente

Este registro autoriza a matriz `DRAFT`. A migração textual e a compilação
permanecem fechadas até a aprovação explícita da matriz pelo autor.
