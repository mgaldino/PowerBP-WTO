# Auditoria visual — figuras da narrativa (round 3, reparos + faceta ex ante)

**Data**: 2026-08-21
**Skill**: ggplot-dataviz (modo auditoria); régua das quatro frases
**Worktree**: `/private/tmp/PowerBayesianPersuasion-figures-narrative`, commit `509aa8d` "Repair narrative figures and add ex ante comparison" (base round 2 preservada em `e7ea88c`)
**Relatório do implementador**: `quality_reports/2026-08-21_figuras_narrativa_round3.md` (na worktree) — completo, em português corrente, com justificativa do painel de delay, verificação mecânica (2.612 pontos na imagem ex ante), hash da interface N6 consumida (`a9cfd593...5a92`) e confirmação de que manuscrito e artefatos protegidos ficaram sem diff.
**Auditadas**: F1 normalizada (kappa=0.286, três facetas), F2, F4; F3 inalterada (placeholder); variantes raw/kappa e C1 não reauditadas.

## Veredito: APROVADAS como candidatas à integração (Goal 5), com retoques cosméticos

Todos os reparos ALTO/MÉDIO do round 2 foram executados e conferidos: fórmulas saíram dos painéis para o caption; legenda sem jargão; colisão da costura de facetas em F2 eliminada; tipo forte visível sob unanimidade ("both types receive h", tracejada sobre sólida); marcadores da opção externa junto à barra de maioria com chave explícita; F4 com campo leve + faixa escura entre ℓ e h. Processo: commit feito, relatório salvo, N6 lido com verificação de hash — as três lacunas de processo do round 2 fechadas.

## Faceta ex ante (F1) — conferida
- Fronteira ν_XA = (β−κ)/(1−κ) no ramo de exclusão coincide com a fórmula independente da auditoria round 2 (ν̂ = (β·o₁−o₀)/[(β·o₁−o₀)+(1−β)·o₁] com o₀ = κ·o₁ reduz a (β−κ)/(1−κ)); no exemplo, 0.86. Números do implementador no exemplo (maioria ex ante 0.1875; unanimidade 0.315) conferem.
- A figura mostra a janela: acima do limiar m·o₁ = 1, azul (unanimidade ex ante) entre ν* e ν_XA, laranja (maioria) acima de 0.86. Frase entregue: "consenso remunera o hegemon mais fraco do que parece; o forte preferiria exclusão; ex ante, unanimidade vence enquanto a força não é quase certa".
- **[MENOR, caption] A verticalidade de ν_XA é artefato da fatia κ** (o₀ proporcional a o₁ faz o₁ cancelar). Com o₀ fixo, a fronteira dependeria de o₁. O caption deve dizer isso para evitar a leitura "o corte ex ante independe do poder hegemônico" como propriedade geral.

## Retoques restantes (todos cosméticos)
1. **F1 — rótulos nas curvas em ASCII** ("nu*", "nu_SE", "nu_SP", "nu_XA"): usar `expression()` para ν*, ν_SE etc. na versão de manuscrito.
2. **F1 — linha ν_SE atravessa a zona "no comparison"** no painel do tipo forte: clipar fronteiras aos trechos que separam polígonos coloridos, ou deixar e explicar no caption que é fronteira da regra de maioria isolada.
3. **F1 — layout**: três facetas lado a lado ficam pequenas em coluna de journal; para o corpo, considerar ex ante como painel principal em cima e tipos em baixo (2 linhas), ou figura de largura total em landscape.
4. **F1 — caption deve incorporar a resposta do autor (P2)**: acrescentar uma frase do tipo "With no direct membership benefit (b_θ = 0 by construction), the strong type's only reason to be inside is the transfer; its preference for exclusion is a feature of the baseline's isolation of informational power, not a substantive prediction" — alinhado à resposta "há algo que ele perde ao ficar de fora" (registro pendente P2).
5. **F2 painel A — marcador do tipo forte em ν=0** sob unanimidade: em ν=0 o tipo forte tem prior zero (Emenda 1a); desenhar seu payoff no endpoint é fantasma conceitual. Remover o triângulo em ν=0 ou anotar "prescribed payoff of a zero-probability type".
6. **F2 painel B — rótulo "H excluded: collects o_theta outside the pie"** encosta na borda da barra de maioria; deslocar ou dar fundo branco.
7. **F4** — nada a reparar; a caixa "common-knowledge weakness" continua sobre a hachura mas legível.

## Painel de delay — omissão aceita, com um registro substantivo
Justificativa do implementador é sólida: no exemplo, o contraste de atraso entre regras é não nulo apenas em ν* < ν ≤ ν_SE = (0.278, 0.293] — uma faixa estreita (maioria faz screening e atrasa com probabilidade ν; unanimidade pooling sem atraso); acima de ν_SE ambas encerram em R1; em (0, ν*] não há comparação. **Registro para o autor**: isto é uma resposta parcial à pergunta 1 do contrato Gate 0 ("existe atraso em equilíbrio e ele depende da regra?") — no exemplo, sim, mas numa faixa estreita. A resposta geral deve vir das células de N6, não do exemplo; se atraso virar afirmação do manuscrito, a forma certa é um inset ampliando (ν*, ν_SE], como o implementador propôs.

## Estado da régua das quatro frases
- F1: entregue, agora com a versão ex ante que fecha a pergunta de desenho institucional (condicionada a P1/P3 pendentes para virar texto).
- F2: entregue. F3: esqueleto, aguarda N7. F4: entregue.

## Ações
- [ ] CODEX (retoques 1–6, uma rodada curta); depois integrar ao Goal 5 quando aberto.
- [ ] AUTOR: P1–P3 seguem pendentes; a caption de F1 deve refletir a decisão sobre P2 quando promovida.
- [ ] Pós-N7: F3 com dados reais; F1 recolorida por ΔRI.
