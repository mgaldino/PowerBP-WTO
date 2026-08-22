# Figuras da narrativa — Round 4 cosmético

- **Data**: 2026-08-21
- **Worktree**: `/private/tmp/PowerBayesianPersuasion-figures-narrative`
- **Branch**: `codex/essential-input-figures-narrative`
- **Base**: commit `509aa8d`
- **Auditoria de entrada**: `quality_reports/2026-08-21_visual_audit_figuras_narrativa_round3.md`, no repositório principal

## Escopo

Esta rodada executou apenas os seis retoques cosméticos solicitados. Não mudou payoffs, regiões, estimandos, parâmetros, conteúdo de N6/N7 ou o manuscrito. A interface N6, as fórmulas congeladas, a Tabela C1 e `formal_model_v6.Rmd` permaneceram sem diff.

## Seis retoques executados

1. **F1 — notação**: os rótulos de fronteira e sua legenda agora usam notação matemática por `expression()` (`nu*`, `nu_SP`, `nu_SE` e `nu_XA`) em vez de texto ASCII literal.
2. **F1 — recorte de `nu_SE`**: a curva termina no ponto em que encontra `nu*`; ela não atravessa mais a região neutra de ausência de comparação.
3. **F1 — layout**: foi adotada a alternativa de figura de largura total/landscape, preservando as três facetas lado a lado sem comprimi-las em uma coluna de periódico.
4. **F1 — caption**: foram acrescentadas duas cautelas. A primeira explicita que `b_theta = 0` por construção e que a preferência do tipo forte pela exclusão decorre da forma como o baseline isola poder informacional, não de uma previsão substantiva geral. A segunda explica que a verticalidade de `nu_XA` é específica da fatia `o0 = kappa o1`, na qual `o1` cancela; com `o0` fixo, a fronteira variaria com `o1`.
5. **F2, Painel A — endpoint**: foi removido o triângulo do tipo forte em `nu=0`, pois esse tipo tem probabilidade zero pela Emenda 1a. Permanece somente o círculo do tipo baixo, que está no suporte.
6. **F2, Painel B — rótulo externo**: a chave “H excluded: collects o_theta outside the pie” foi ligeiramente deslocada e recebeu fundo branco, eliminando o contato visual com a barra de maioria.

A remoção do endpoint do tipo forte inicialmente separou as legendas de linha e ponto. O ponto do tipo baixo foi então retirado da legenda, mantendo uma única legenda de tipos baseada nas linhas e evitando qualquer triângulo fantasma.

## Verificação

- O gerador reproduziu os 13 bundles PDF–PNG–CSV e manteve as 2.612 verificações da imagem ex ante.
- Os 13 PDFs têm uma página, são vetoriais e tiveram os bounding boxes de texto conferidos dentro da página.
- F1 e F2 foram inspecionadas em cores e em escala de cinza.
- Gate 0 e N6 passaram novamente; o hash N6 permanece `a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92`.
- `git diff --check` não encontrou problemas.

Estas são verificações mecânicas e visuais do implementador. A auditoria independente continua sendo o próximo gate antes da integração ao manuscrito.
