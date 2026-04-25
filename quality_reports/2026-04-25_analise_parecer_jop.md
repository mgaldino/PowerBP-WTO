# Análise do Parecer JoP — 2026-04-25

Parecer original: `notes/parecer_jop_formal_model_v3.pdf`
Transcrição completa: `quality_reports/2026-04-25_parecer_jop_referee.md`

---

## Problemas estruturais (mais sérios)

| # | Issue | Severidade | Avaliação |
|---|-------|-----------|-----------|
| 3.1 | Resultado mais estreito que a promessa — intro vende "why consensus" como geral; resultado é condicional a α < α*, entrada viável, etc. | Alta | **Justo.** Reframing é necessário. O paper deve dizer que identifica condições, não que explica a preferência geral. |
| 3.2 | "Principal regime" sem condição formal no enunciado do cutoff R1 | Alta | **Justo e urgente.** Ou a condição entra no enunciado, ou se prova que α < α* a implica, ou se cobre todos os regimes. Não é aceitável dizer "empirically relevant range". |
| 3.3 | Lemma 1 — prova comprimida no caso alternativo (μ_s^{R1} < μ_s^{R2}), tie-breaking nos cutoffs | Alta | **Justo.** O caso alternativo precisa de tratamento explícito intervalo por intervalo. Tie-breaking nos cutoffs não é cosmético para enunciados ponto a ponto. |
| 3.5 | Entry game subespecificado — não diz o que acontece se só alguns W entram | Média-alta | **Justo.** A solução simples (declarar "representative weak state, all-or-nothing entry") resolve sem reescrever o modelo. |

## Problemas de framing/exposição (resolvíveis)

| # | Issue | Severidade | Avaliação |
|---|-------|-----------|-----------|
| 3.4 | Theorem 1 depende de conditional dominance, não de BP per se — desalinhamento retórico | Média | **Parcialmente justo.** BP faz trabalho real no Theorem 2 (p*), mas Theorem 1 é quase corolário do Lemma 1. Sugestão de reorganizar em Props separadas (linearidade → jump → persuasion gain → Lemma → Theorem) é boa. |
| 3.6 | Aplicação WTO ilustrativa demais — sem observable implications disciplinadas pelo modelo | Média | **Justo.** A lista de OIs sugerida pelo referee é excelente e deve ser incorporada. |
| 4.1 | Linguagem forte demais ("technology of hegemonic power") — impressão de que consenso sempre favorece H | Baixa | Fácil de calibrar. Manter a expressão, mas qualificar como condicional. |
| 4.2 | Notação pesada — muitos objetos no corpo | Baixa | Já reduzida na v3, mas pode melhorar. Mover mais álgebra para appendix. |
| 4.3 | Consensus ≠ unanimity — disclaimer aparece tarde e fraco | Baixa | **Parcialmente justo, mas a crítica ignora o setup do jogo.** No nosso jogo, a ação de cada jogador é aceitar ou rejeitar — não existe opção de abstenção ou silêncio. A distinção institucional entre consenso (abstenção = aprovação tácita) e unanimidade (aprovação explícita requerida) colapsa quando o espaço de ações é binário. Estamos abstraindo esse detalhe deliberadamente porque não é relevante para o mecanismo. A solução é explicitar isso no paper: "In our game, each player either accepts or rejects; there is no abstention option. The institutional distinction between consensus (where silence implies consent) and unanimity (where explicit approval is required) therefore does not apply. We use the terms interchangeably." Essa frase deve aparecer na definição do jogo, não em footnote tardia. |

## O que o referee NÃO questiona

- O mecanismo (screening + jump + BP) — aceita como interessante
- O exemplo motivador — elogia como "uma das melhores partes do paper"
- A arquitetura majority = linear / unanimity = jump — "potencialmente elegante"
- A correção do Theorem 1 dado o Lemma 1
- A contribuição como potencialmente publicável
