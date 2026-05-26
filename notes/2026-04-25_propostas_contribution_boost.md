# Propostas para fortalecer Contribution (Edmans review 7.0 -> 7.5+)

**Data**: 2026-04-25
**Status**: DRAFT v3 — aguardando aprovacao

O bottleneck e Importancia (Adequada, nao Forte). A Novidade ja e Forte. Tres propostas abaixo.

---

## Proposta 1: Worked Example numerico pos-Theorem 2 (P6)

### Objetivo
Mostrar p\* em acao: computar o threshold, mostrar magnitudes dos dois lados, e ilustrar como o single-crossing funciona numericamente. Parametros estilizados, sem pretender calibrar a um episodio historico.

### Por que NAO calibrar ao GATT 1947
A criacao do GATT nao se encaixa no modelo porque: (i) os parceiros principais eram europeus, nao "weak states" com gap informacional severo; (ii) a motivacao dos EUA era geopolitica (conter socialismo, reconstruir Europa), nao distributiva; (iii) nao se tratava de BP para extrair excedente. A aplicacao historica melhor e a WTO contemporanea com PVDs — mas essa aplicacao ja esta na Discussion. O Example deve focar na mecanica, nao na historia.

### Parametros

Usar os mesmos parametros do Example 1 (ja familiar ao leitor):
- N=5, r=1.5, alpha=0.3, beta=0.9
- Adicionar c=0.14 (entry cost)

Esses parametros geram:
- alpha\* = 0.474 (alpha < alpha\*, Lemma 1 vale)
- mu_s^R1 = 0.197 (screening cutoff)
- tau(M) ~ 0 (entry ocorre em quase todo mu sob maioria)
- tau(U) = 0.331 (entry so ocorre para mu > 0.33 sob unanimidade)
- **p\* = 0.238** (threshold do Theorem 2)

### Numeros-chave para o Example

| Prior p | Pi_H\*(U) | Pi_H\*(M) | Melhor regra | Magnitude |
|---------|-----------|-----------|--------------|-----------|
| 0.10 | 0.18 | 0.41 | M | M da 125% mais |
| 0.20 | 0.37 | 0.43 | M | M da 17% mais |
| **0.238** | — | — | **crossing** | — |
| 0.30 | 0.55 | 0.45 | U | U da 22% mais |
| 0.50 | 0.61 | 0.49 | U | U da 25% mais |

**A historia que os numeros contam:**
- Abaixo de p\*=0.238: maioria domina porque a instituicao nao se forma sob unanimidade (c alto demais para os fracos suportarem dado o surplus menor). Maioria ganha pelo canal de entry, nao por payoff condicional.
- Acima de p\*=0.238: unanimidade domina. O screening da ao hegemon 17-25% mais que maioria. BP amplifica: em p=0.30, a concavificacao de U gera Pi=0.55, bem acima do valor raw.
- A transicao ocorre **uma unica vez** (single-crossing), como o Theorem 2 garante.

### Texto proposto para o paper

Inserir como **Example 2** apos o paragrafo interpretativo do Theorem 2 (linha 559), antes de "Numerical characterization":

```latex
\begin{example}[Computing $p^*$: the full institutional comparison]\label{ex:p_star}
Continuing with the parameters from Example~\ref{ex:magnitudes}
($N=5$, $r=1.5$, $\alpha=0.3$, $\beta=0.9$), suppose entry costs
$c = 0.14$. Under majority, the institution forms at essentially all
beliefs ($\tau(M) \approx 0$). Under unanimity, the screening
mechanism reduces weak states' surplus, so the institution forms only
for $\mu > \tau(U) \approx 0.33$. Bayesian persuasion partially
closes this entry gap: the hegemon designs signals that push
posteriors above $\tau(U)$, inducing participation under unanimity at
priors below $0.33$.

The threshold is $p^* \approx 0.24$. Below it, majority dominates
because only it can induce entry---unanimity's concavified payoff
cannot overcome the participation disadvantage. Above it, unanimity
strictly dominates: at $p = 0.30$, the hegemon's payoff under
unanimity exceeds majority by $22\%$; at $p = 0.50$, by $25\%$.
The advantage of majority at pessimistic priors is entirely through
the entry channel: conditional on participation, unanimity always
gives the hegemon more (Lemma~\ref{lem:conditional}).

The transition is sharp and monotone, as Theorem~\ref{thm:crossing}
guarantees. The set of priors favoring unanimity is the upper
interval $(0.24, 1]$: once the prospects of cooperation are
promising enough that unanimity can induce entry (directly or through
persuasion), the screening advantage is decisive.
\end{example}
```

### O que muda na Discussion

O paragrafo "GATT-to-WTO transition" (linhas 680-684) fica como esta — mapeamento qualitativo, sem calibracao numerica. O Example 2 faz o trabalho numerico de forma estilizada, e a Discussion conecta qualitativamente os comparative statics (alpha sobe → consenso perde valor; assimetria informacional cresce → consenso ganha valor) ao caso historico.

---

## Proposta 2: Observable implications — estilo JoP

### Diagnostico (apos leitura de Hirsch 2023 e Hill 2022)

Estilo JoP: predictions em prosa (nao bullets/tabelas), organizadas por topico, com italicos e contraste explicito com teorias alternativas.

### Proposta (minima)
Quebrar o paragrafo denso (linhas 674-678) em 2-3 paragrafos tematicos:
- Par. 1: *Onde* o mecanismo e mais forte (complexidade regulatoria) e *quando* enfraquece (PTAs). Contraste com legitimidade.
- Par. 2: *Timing* (regimes maduros vs. novos) e *paciencia*. Contraste com self-enforcement.
- Par. 3: Variacao cross-issue como prediction distintiva.

Nao mudar formato — continuar em prosa. Usar italicos para sinalizar predictions.

---

## Proposta 3: Remark de Welfare

### O resultado (ja derivado no Appendix A.6)

- Maioria: surplus total = V_e(mu) (sem destruicao)
- Unanimidade, agressivo: surplus total = V_e(mu) - (N-1)*mu*r*(1-beta)/N (destruicao por delay)

### Texto proposto

```latex
\begin{remark}[Welfare]\label{rem:welfare}
Unanimity is not a Pareto improvement over majority. Under majority,
total surplus equals $V_e(\mu)$: the budget identity holds exactly
(Appendix~A.6). Under unanimity, total surplus is weakly lower:
when the weak proposer plays aggressively, type $\theta=1$ rejects
in R1 and delay destroys a fraction $\mu(N-1)r(1-\beta)/N$ of
expected surplus. Since the hegemon captures more
(Lemma~\ref{lem:conditional}) while weak states receive less
(Appendix~B.6), unanimity redistributes from weak states to the
hegemon while also reducing total surplus. The hegemon's preference
for unanimity is distributive, not efficiency-enhancing.
\end{remark}
```

Inserir apos linha 559 (pos-Theorem 2), antes do Example 2.

---

## Resumo

| Proposta | O que faz | Onde insere | Esforco |
|----------|-----------|-------------|---------|
| P1: Example 2 (p\*) | Mostra single-crossing com numeros | Pos-Theorem 2, antes de Numerical | Medio |
| P3: Remark welfare | Muda framing normativo | Pos-Theorem 2 | Baixo |
| P2: Observable implications | Quebra paragrafo denso, italicos | Discussion, linhas 674-678 | Baixo |

Ordem de insercao no texto: Remark welfare → Example 2 → Numerical characterization.
