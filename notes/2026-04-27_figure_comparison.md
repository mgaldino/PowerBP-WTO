# Comparacao de figuras: heatmap vs. barras de classificacao

**Data**: 2026-04-27
**Contexto**: Substituicao da Figura 4 (parameter-regions) no v5 apos remocao de BP.

---

## Figura A: Heatmap de tau(U) (design atual)

![Heatmap tau(U)](../figures/compare_figA_heatmap.pdf)

**Caption proposta para o paper:**

> Unanimity entry threshold tau(U) across parameters. Lower values (blue) mean unanimity is viable for a wider range of priors; higher values (red) mean the set of priors at which unanimity can sustain entry is narrower. White regions indicate alpha >= 1/r (outside the model domain). Dashed horizontal line: alpha*, below which Theorem 1 guarantees conditional dominance at every belief. Left: r vs alpha plane with beta=0.9, N=5, c=0.1. Right: beta vs r plane with alpha=0.3, N=5, c=0.1.

**Pontos fortes:**
- Mostra comparative statics em duas dimensoes de parametros
- Continuidade do heatmap sugere gradualidade
- Complementa o heatmap (alpha, mu) da Scope section

**Pontos fracos:**
- Vermelho sugere "maioria vence" mas na verdade significa "unanimidade vence onde forma, mas forma pouco"
- Conflates duas perguntas: quao boa e unanimidade (Theorem 1) vs. com que frequencia forma (tau)
- Leitor de JoP precisa de esforco cognitivo para interpretar

---

## Figura B: Barras de classificacao 1D (design proposto)

![Barras de classificacao](../figures/compare_figB_bars.pdf)

**Caption proposta para o paper:**

> Institutional classification across prior beliefs for varying entry costs (N=5, r=1.5, alpha=0.3, beta=0.9). Blue: unanimity dominates (p in E_U). Orange: majority dominates through wider entry (p in E_M \ E_U). Gray: neither rule sustains entry. As entry costs rise, the unanimity entry threshold tau(U) increases, expanding majority's scope advantage. But this advantage is entirely through the entry channel: conditional on participation, unanimity strictly dominates at every belief (Theorem 1).

**Pontos fortes:**
- Correspondencia 1:1 com os 3 cases da Proposition
- Leitura em 10 segundos: 3 cores = 3 regimes
- Sem ambiguidade sobre o que cada cor significa
- Percentuais mostram escopo diretamente
- Mostra comparative statics em c (o parametro que controla o entry gap)

**Pontos fracos:**
- So varia c (parametros fixos); nao mostra sensibilidade a r, alpha, beta
- Menos "sofisticado" visualmente que um heatmap
- Pode parecer "simples demais" para referee quantitativo

---

## Decisao pendente

Qual figura usar no v5? Ou nenhuma (confiar no texto + Figure 5 heatmap-alpha-mu)?
