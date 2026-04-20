# Formalização do Modelo v2

## 1. Environment

**Definition (Institutional Design Game).** The game $\Gamma(N, p, r, \alpha, \beta, c)$ has the following primitives.

- There are $N \geq 3$ players: one hegemon $H$ and $n = N-1$ weak states $W_1, \dots, W_n$.
- Nature draws $\theta \in \{0, 1\}$ with prior $\Pr(\theta = 1) = p \in (0,1)$.
- The state determines the value of multilateral cooperation: $V(0) = 1$ and $V(1) = r > 1$.
- The hegemon observes $\theta$; the weak states do not.
- If bargaining fails (disagreement):
  - Each weak state receives $0$.
  - The hegemon receives $\alpha V(\theta)$, where $\alpha \in (0, 1/r)$, representing bilateral alternatives proportional to the value of cooperation.
- The common discount factor is $\beta \in (0,1)$.
- Each weak state pays an entry cost $c > 0$ to join the institution.

Let $V_e(\mu) \equiv 1 + \mu(r-1)$ denote the expected value of cooperation at posterior belief $\mu$.

**Remark (Normalization).** The assumption $d_W = 0$ is without loss of generality. It requires only that (i) weak states' outside options are strictly lower than the hegemon's, and (ii) outside options are symmetric across weak states. Given these conditions, we redefine the pie as the surplus above the weak states' common outside option, which normalizes their disagreement payoff to zero.

**Remark (Bilateral alternatives).** The hegemon's disagreement payoff $\alpha V(\theta)$ captures bilateral alternatives that are proportional to the value of multilateral cooperation. The same factors that make multilateral cooperation valuable (favorable trade environment, complementary economies) also improve bilateral alternatives. The parameter $\alpha < 1/r$ ensures that bilateral alternatives are strictly dominated by multilateral cooperation for all $\theta$.

## 2. Institutional Packages

**Definition (Institutional Packages).** The analysis compares two institutional packages that differ only in the voting rule. Both packages have symmetric proposal rights (random proposer with probability $1/N$ each).

- **Package M (Majority)**: decisions pass with strict majority support ($q = \lfloor N/2 \rfloor + 1$ votes).
- **Package U (Unanimity/Consensus)**: decisions require unanimous support ($q = N$ votes).

**Remark (Why not agenda control?).** By agenda control we mean here monopoly over proposal rights (exclusive proposer). Under either voting rule, if the hegemon were the exclusive proposer and $d_W = 0$, weak states' expected bargaining payoff would be zero. No weak state would pay the entry cost $c > 0$, and the institution would never form. Monopoly proposal power is therefore self-defeating. The relevant institutional choice is between voting rules, holding proposal rights symmetric. Other forms of agenda influence — such as shaping the set of feasible proposals — are discussed in the extension.

## 3. Timing

The game has three stages.

1. **Stage 0 (Institutional choice).** The hegemon chooses the voting rule $R \in \{M, U\}$.

2. **Stage 1 (Information and entry).** Nature draws $\theta$. The hegemon observes $\theta$ and commits to a public signal structure $\pi: \{0,1\} \to \Delta(S)$. Weak states observe the realized signal $s \in S$, update to posterior $\mu = \Pr(\theta = 1 \mid s)$, and simultaneously decide whether to enter (paying cost $c$).

3. **Stage 2 (Bargaining).** If at least $q$ players (including $H$) are available, members play a two-round Baron-Ferejohn bargaining game over a pie of size $V(\theta)$:
   - **Round 1**: a proposer is selected uniformly at random (probability $1/N$). The proposer offers a division. All members vote according to rule $R$. If accepted, the pie is divided as proposed. If rejected, the game proceeds to Round 2.
   - **Round 2 (terminal)**: a new proposer is selected uniformly at random. The proposer offers a division. All members vote. If accepted, the pie is divided. If rejected, each player receives their disagreement payoff ($0$ for each $W$, $\alpha V(\theta)$ for $H$).

## 4. Solution Concept

The solution concept is Perfect Bayesian Equilibrium (PBE). Strategies are sequentially rational given beliefs, and beliefs are updated by Bayes' rule on the equilibrium path. Off-path beliefs satisfy sequential rationality.

## 5. Árvore do Jogo (descrição para TikZ)

```
Stage 0: H chooses R ∈ {M, U}
│
├── R = M (Majority)
│   └── Stage 1: Nature draws θ → H observes → Signal → W's form μ → Enter/Not
│       ├── Not Enter: (0, 0, ..., 0)
│       └── Enter: Stage 2 Bargaining (majority rule)
│           └── Round 1: proposer drawn (1/N)
│               ├── H proposes: buys q-1 cheapest W votes, excludes rest
│               └── W proposes: excludes H (cheaper coalition), includes q-1 W's
│                   ├── Accept: divide V(θ), H gets αV(θ) (excluded)
│                   └── Reject → Round 2 (terminal, same structure)
│                       └── Reject → disagreement: H gets αV(θ), W's get 0
│
└── R = U (Unanimity)
    └── Stage 1: same as above
        ├── Not Enter: (0, 0, ..., 0)
        └── Enter: Stage 2 Bargaining (unanimity)
            └── Round 1: proposer drawn (1/N)
                ├── H proposes: offers 0 to all W's, keeps V(θ)
                └── W proposes: MUST include H (unanimity)
                    ├── Aggressive offer (y_H = α): θ=0 accepts, θ=1 rejects
                    └── Conservative offer (y_H = αr): both accept
                        └── Reject → Round 2 (terminal, same screening)
                            └── Reject → disagreement: H gets αV(θ), W's get 0
```

## 6. Análise de Equilíbrio (a desenvolver)

### 6.1 Terminal Round (R2) sob Unanimidade

**Quando H propõe** (prob 1/N): oferece 0 a cada W (d_W = 0), todos aceitam. H fica com V(θ).

**Quando W_j propõe** (prob 1/N): oferece 0 aos outros W's. Enfrenta screening problem para H:

- **Oferta agressiva**: $y_H = \alpha$ (= $\alpha V(0)$). Tipo θ=0 aceita ($\alpha \geq \alpha$). Tipo θ=1 rejeita ($\alpha < \alpha r$), recebe $\alpha V(1) = \alpha r$.
- **Oferta conservadora**: $y_H = \alpha r$ (= $\alpha V(1)$). Ambos aceitam.

Payoff esperado de W como proposer:
- Agressivo: $(1-\mu)(V(0) - \alpha) = (1-\mu)(1-\alpha)$
- Conservador: $(1-\mu)(V(0) - \alpha r) + \mu(V(1) - \alpha r) = (1-\mu)(1-\alpha r) + \mu r(1-\alpha) = V_e(\mu) - \alpha r$

**Screening cutoff**: W prefere agressivo quando $(1-\mu)(1-\alpha) > V_e(\mu) - \alpha r$:

$$\mu_s = \frac{\alpha(r-1)}{r - \alpha}$$

Closed form. W joga agressivo se $\mu < \mu_s$, conservador se $\mu > \mu_s$.

**Continuation values R2:**

$V_W^{R2}(\mu)$:
- $\mu < \mu_s$: $(1-\mu)(1-\alpha)/N$
- $\mu > \mu_s$: $[V_e(\mu) - \alpha r]/N$
- Contínuo em $\mu_s$ [verificar].

$V_H^{R2}(\theta, \mu)$:
- $\theta = 1$: $V(1)[1 + (N-1)\alpha]/N = r[1+(N-1)\alpha]/N$ (constante em $\mu$)
- $\theta = 0, \mu < \mu_s$: $[1 + (N-1)\alpha]/N$
- $\theta = 0, \mu > \mu_s$: $[1 + (N-1)\alpha r]/N$ (overpaid)

**Jump em $E[V_H^{R2}(\mu)]$ no cutoff $\mu_s$:**
$$\text{Jump} = \frac{(N-1)\alpha(r-1)(1-\mu_s)}{N} > 0$$

### 6.2 Terminal Round (R2) sob Maioria

**Quando H propõe** (prob 1/N): compra $q-1$ votos (oferece 0 a cada, d_W = 0). Fica com V(θ).

**Quando W propõe** ((N-1)/N): exclui H (mais caro), forma coalizão com $q-1$ outros W's (oferece 0). Fica com $V(\theta)$. H recebe $\alpha V(\theta)$ (alternativa bilateral, excluído do acordo).

$V_H^{R2}(\theta, \text{maioria}) = V(\theta)[1 + (N-1)\alpha]/N$ — **linear em $\mu$, sem screening**.

$V_W^{R2}(\mu, \text{maioria}) = V_e(\mu)/N$ [verificar: apenas quando é proposer, prob 1/N, gets V(θ)].

### 6.3 Round 1 (R1) — a derivar

**Sob unanimidade**: screening funciona em R1 porque V(θ) cria gap estrutural $(r-1)/N$ entre tipos quando H propõe. θ=0 não consegue replicar payoff de θ=1 blefando.

IC constraints em R1:
- θ=0 aceitar: $y_H \geq \beta[1+(N-1)\alpha r]/N$
- θ=1 rejeitar: $y_H < \beta \cdot r[1+(N-1)\alpha]/N$
- Gap: $\beta(r-1)/N > 0$ ✓

**Sob maioria**: sem screening (W exclui H). Linear.

### 6.4 Entry — a derivar

### 6.5 Bayesian Persuasion — a derivar

### 6.6 Comparação Institucional — a derivar

## 7. Pontos abertos

1. **Direção de entrada sem direct benefit**: sob unanimidade (branch agressivo), V_W é decrescente em μ — entrada mais fácil a μ baixo. Sob maioria, V_W é crescente — entrada mais fácil a μ alto. Direções opostas. Derivar consequências para BP.

2. **Feasibility de ofertas absolutas**: W propõe montantes sem saber V(θ). Oferta conservadora y_H = αr: feasível quando θ=0 (αr < 1 pois α < 1/r)? Sim: αr < r × 1/r = 1. ✓

3. **V_W sob maioria**: quando W propõe e exclui H, W fica com V(θ) mas não sabe V(θ). Como modelar? W propõe montantes e recebe o residual V(θ) - ofertas. O residual depende de θ (risco para W).

4. **Continuidade de V_W^{R2} em μ_s**: verificar algebricamente.

5. **Condição para H preferir unanimidade**: quando screening channel + extração superior supera desvantagem de entrada?
