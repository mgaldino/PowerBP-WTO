# Auditoria visual — figuras da narrativa (round 2, entrega do Codex)

**Data**: 2026-08-21
**Skill**: ggplot-dataviz (modo auditoria), régua das "quatro frases" da narrativa aprovada pelo autor
**Worktree**: `/private/tmp/PowerBayesianPersuasion-figures-narrative` (branch `codex/essential-input-figures-narrative`); scripts novos (não commitados): `scripts/essential_input_manuscript_figure_functions.R`, `scripts/generate_essential_input_manuscript_figures.R`; saídas em `figures/draft/` (PDF+PNG+CSV por figura, manifesto `essential_input_manuscript_figure_manifest.csv`)
**Auditadas**: F1 (kappa=0.286, variantes raw e normalizada), F2, F3 (placeholder raw), F4. Não reauditadas: C1 apêndice, variantes kappa 0.25/0.50/0.75 de F1, F3 normalizada.
**Veredito geral**: APROVADAS COM REPAROS. Os defeitos estruturais do round 1 (regiões rotuladas por maquinaria; plano errado; grade serrilhada; legenda fantasma) foram corrigidos. Restam reparos de legibilidade e UMA questão substantiva que a F1 trouxe à tona e que é decisão do autor, não defeito de figura.

## A descoberta substantiva (prioridade máxima — decisão do autor)

A F1 mostra, acima do limiar de hegemonia (o₁ > 1/m) e com força crível (ν > ν*): **o tipo fraco prefere unanimidade (azul), mas o tipo forte prefere MAIORIA (laranja)**. A aritmética, conferida: sob unanimidade o tipo forte recebe o preço de pooling h = β·o₁ no round 1 (o proponente paga exatamente a reserva dele, que é o valor descontado de vetar e levar o₁ no round 2); sob maioria o tipo forte é excluído e recebe o₁ **sem desconto**, porque o jogo termina no round 1 com acordo sem ele e o_θ é pago na data em que o jogo termina. Como o₁ > β·o₁, o forte prefere ser excluído.

Consequências a endossar ou rejeitar:
1. **A convenção de timing de o_θ é load-bearing** (era o item M6 da auditoria das provas: "assimetria que deve ser explícita"). Sob a convenção alternativa — o_θ sempre recebido na data final do horizonte (round 2), independentemente de como o jogo termina — a exclusão valeria β·o₁ visto do round 1, o tipo forte ficaria indiferente entre as regras e a região laranja desapareceria. A convenção congelada (payoff pago quando o jogo acaba; exclusão em R1 paga o_θ em R1) é consistente com o texto do contrato ("recebido ao fim do jogo"), mas o autor precisa endossar conscientemente que é ESTA a economia pretendida: sob unanimidade, o proponente explora a impaciência do hegemon (paga hoje o valor descontado de esperar); sob maioria, o hegemon forte sai e embolsa a opção externa imediatamente.
2. **A frase da F1 muda.** Não é "consenso paga para o hegemon aqui"; é "consenso paga para o hegemon QUE É MAIS FRACO DO QUE PARECE; o hegemon forte preferiria ser excluído". A renda informacional é do tipo fraco (pooling paga a ele o preço do forte). Isso é mais provocador e mais interessante para RI — mas muda a pergunta "por que um hegemon constrói instituições por consenso?": com o tipo conhecido por H no momento da escolha, só o bluffador quer consenso.
3. **A comparação ex ante (antes de H conhecer o próprio tipo) vira essencial e está ausente.** É a comparação relevante para desenho institucional (regra escolhida sob incerteza sobre a própria força futura) e é computável HOJE a partir das células por tipo de N6 com o prior ν — é exatamente a "imagem ex ante" da Seção 1 do contrato. Conta de padeiro: H prefere unanimidade ex ante sse (1−ν)(β·o₁ − o₀) > ν(1−β)·o₁; com β perto de 1 a perda do forte é pequena e a unanimidade vence ex ante exceto em ν muito alto. REPARO: adicionar à F1 uma terceira faceta "Ex ante (before H learns its type)".

## Findings por figura

### F1 — Institutional map (raw e normalizada)
- **[PASS design]** Regiões rotuladas pela resposta; fronteiras analíticas como curvas; célula vazia neutra+hachura; ponto do exemplo marcado; segmentos de endpoint em ν=0 presentes. Matemática das regiões conferida por amostragem (cunha azul abaixo de 1/m = maioria ainda faz screening enquanto unanimidade já faz pooling; indiferença abaixo de 1/m com ambos em pooling; laranja acima de 1/m = exclusão paga o₁ > β·o₁).
- **[MÉDIO] Poluição por fórmulas dentro do gráfico**: as caixas com as fórmulas completas de ν_SP e ν_SE colidem com fronteiras e com o ponto do exemplo. Reparo: rótulos curtos nas curvas ("ν*", "ν_SE", "ν_SP") e fórmulas só no caption.
- **[MÉDIO] Falta a faceta ex ante** (ver acima). Reparo obrigatório antes do manuscrito.
- **[MENOR] Legenda "Private-rule comparison"** é jargão interno; usar "H's payoff comparison (private information)".
- **[MENOR] Segmentos de endpoint em ν=0** quase invisíveis (lascas na borda esquerda); aceitável desde que o caption os explique (já explica) — alternativa: marcador pontual em ν=0 como na F4.
- **Escolha de variante**: recomendo a NORMALIZADA (m·o₁, limiar universal em 1) para o corpo do paper, por valer visualmente para qualquer N; a raw vai para apêndice.

### F2 — Prices and coalition anatomy
- **[PASS conceito]** Painel A mostra o teto sob maioria (linhas planas em β·o_θ e depois o_θ) vs. plateau de pooling sob unanimidade com a faixa de renda h−ℓ anotada; Painel B realiza a "anatomia da coalizão" exatamente como especificado (valores conferidos: substitutos 2×β/4 = 0.45; pisos 3×B = 0.439; concessão h = 0.315; resíduos batem).
- **[ALTO] Colisão de eixo na costura das facetas**: os rótulos "1.0" (maioria) e "0.0" (unanimidade) se sobrepõem e viram "100". Reparo: `panel.spacing` maior ou suprimir o rótulo duplicado.
- **[ALTO] Tipo forte invisível sob unanimidade**: a linha tracejada do tipo forte coincide com a sólida do tipo fraco em h e desaparece por baixo. Reparo: dodge vertical mínimo ou anotação explícita "both types receive h".
- **[MÉDIO] Marcadores da opção externa no Painel B** estão soltos à esquerda; como é na MAIORIA (excluído) que H coleta o_θ por fora, os marcadores devem ficar adjacentes à barra de maioria, com chave "H excluded: collects o_θ outside the pie".
- **[MENOR] Painel A não marca o endpoint ν=0** sob unanimidade (a F4 marca); adicionar o ponto para coerência.
- **Painel C (delay)**: ausente. A especificação permitia omitir se a interface de N6 não reportasse acordo/atraso de forma comparável — mas a justificativa precisa constar no relatório do Codex (ver "Lacunas de processo").

### F3 — Power vs. information decomposition (placeholder)
- **[PASS]** Marca d'água "PLACEHOLDER — awaiting N7" nos dois painéis; valores sintéticos sem interpretação; estrutura DiD (quatro pontos por tipo, chaves RI_M/RI_U, ΔRI) e painel de descontinuidade em o₁=1/m conforme especificação; função aceita dados reais por argumento.
- **[MENOR]** No DiD, usar público=vazio/privado=cheio com seta do público ao privado deixaria a leitura "renda = deslocamento vertical" ainda mais imediata. Opcional.

### F4 — Hegemonic decline
- **[PASS]** Leitura direita→esquerda sinalizada; pooling com renda anotada; zona (0,ν*] hachurada "no stable pure voting pattern (instability)"; ν=0 como marcador pontual anotado ("common-knowledge weakness: H bought at reservation"), sem categoria de legenda fantasma; caption com o guardrail de Edgeworth ("not a theorem that the game cycles").
- **[MÉDIO] Preenchimento laranja de altura total é decorativo** — a informação está na linha h; o campo cheio reduz a razão tinta/informação. Reparo: fundo leve (alpha baixo) ou faixa apenas entre ℓ e h.
- **[MENOR]** Caixa "common-knowledge weakness" sobrepõe a hachura; deslocar para fora da região hachurada com linha-guia ao ponto.

## Lacunas de processo
1. **Relatório final do Codex não encontrado em arquivo** — nenhum `.md` novo na worktree; o prompt exigia relatório em português corrente (o que cada figura mostra, decisões de desenho, pendências, justificativa do Painel C). Pela regra do projeto, entregável que fica só na sessão é perdido: o Codex deve salvar em `quality_reports/` ou `notes/`.
2. Scripts e figuras não commitados na worktree (`??` em `git status`); commitar antes de qualquer retrabalho para preservar o round 2 como base.
3. Variantes kappa 0.25/0.50/0.75 e C1 apêndice não auditadas nesta rodada.

## Régua das quatro frases — estado
- F1: frase ENTREGUE, mas diferente da planejada — "consensus pays the hegemon who is weaker than it looks; the strong type would rather be excluded" — e requer a faceta ex ante para fechar a pergunta de desenho institucional.
- F2: frase entregue ("majority caps H's price by buying substitutes; unanimity pays the hegemon") — com dois reparos de legibilidade.
- F3: esqueleto correto; frase só com N7.
- F4: frase entregue ("institutions work while strength is credible; contested decline destabilizes; consensual weakness makes H cheap").

## Ações
- [ ] AUTOR: endossar ou rejeitar a convenção de timing de o_θ à luz da região laranja (decisão de desenho; registrar no formato padrão com alternativa descartada).
- [ ] CODEX: faceta ex ante na F1; reparos ALTO/MÉDIO de F2; fórmulas para o caption na F1; fundo leve na F4; relatório final em arquivo; commit da worktree.
- [ ] Depois de N7: dados reais em F3; recolorir F1 por ΔRI.
