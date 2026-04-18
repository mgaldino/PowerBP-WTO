# V3 Simplified: 2-Round BF with Screening Channel Only

**Status**: DRAFT  
**Date**: 2026-04-18

---

## 0. Motivation and Design Philosophy

The V1 model (single-round redistribution with exogenous status quo V(theta)/N) generates the core trade-off between Package A and Package C, but the dominance condition reduces to a ratio of constants --- shares s_H(R), s_W(R) determined by N and q alone, with no genuine interaction between the BP signal (Stage 1) and the bargaining outcome (Stage 2). The parameter delta (pie bonus) cancels in the comparison.

The full V3 plan (2026-04-17) identified two channels: (i) signaling when H proposes, (ii) screening when W proposes. Signaling creates complexity (multiple equilibria, equilibrium selection) without clear payoff. **This simplified V3 retains ONLY the screening channel.**

### Key simplifications:

1. **Status quo d = V(theta)/N** (not d = 0). Eliminates the knife-edge V_W(A) = 0.
2. **Pooling equilibrium when H proposes under Package C.** No signaling analysis. Justified by parameter restriction (Assumption P).
3. **Screening when W proposes under Package C** is the ONLY new mechanism.
4. **Package A: H always proposes**, standard BF with status quo as disagreement.
5. **2 rounds only.** Round 2 is terminal with disagreement payoff d = V(theta)/N.

---

## 1. Model Specification

### 1.1. Players, State, Pie

- N players: H (hegemon, informed) + W_1, ..., W_n (weak, uninformed). n = N-1.
- theta in {0, 1}, Pr(theta = 1) = p (prior).
- Pie: V(0) = 1, V(1) = v > 1. Expected pie: V_e(mu) = 1 + mu(v-1).
- Discount factor: beta in (0, 1).
- Posterior: mu = Pr(theta = 1 | signal s), common knowledge among W's.

### 1.2. Disagreement Payoff

d_i(theta) = V(theta)/N for each player. This is the "status quo" --- default institutional terms if no agreement is reached.

**Key feature:** d depends on theta. H knows d(theta); W's know only E[d | mu] = V_e(mu)/N.

### 1.3. Institutional Packages

- **Package A** (majority + agenda): H proposes in both rounds. Majority rule (q = ceil((N+1)/2)).
- **Package C** (consensus): Random recognition (prob 1/N each). Unanimity (all must agree).

### 1.4. Game Tree (Stage 2)

**Round 1:** Recognition -> Proposal -> Voting -> if rejected, go to Round 2 (payoffs discounted by beta).

**Round 2 (terminal):** Recognition -> Proposal -> Voting -> if rejected, disagreement payoff V(theta)/N to all.

### 1.5. Assumption P (Pooling Condition)

v < N / ((N-1) beta).

This ensures pooling is feasible when H proposes in Round 1 under Package C. For N = 3, beta = 0.9: v < 1.667. For N = 3, beta = 0.5: v < 3.

---

## 2. Round 2 Solution (Terminal Round), Package A

H proposes. Needs q - 1 votes from n W's.

Each W_i's reservation: E[V(theta)/N | mu] = V_e(mu)/N. (Rejection at Round 2 terminal yields the status quo.)

H offers V_e(mu)/N to q - 1 chosen W's, 0 to the rest.

**Payoffs (Round 2 dollars):**

- V_H^{R2}(A, theta, mu) = V(theta) - (q-1) V_e(mu)/N
- V_{W_i}^{R2}(A, mu) = [(q-1)/n] * V_e(mu)/N  (ex ante over random coalition inclusion)

**For N = 3** (q = 2, n = 2):
- V_H^{R2}(A, theta, mu) = V(theta) - V_e(mu)/3
- V_{W_i}^{R2}(A, mu) = V_e(mu)/6

---

## 3. Round 2 Solution, Package C (N = 3)

This section is specialized to N = 3 throughout. The general-N structure is stated in Section 3.5.

### 3.1. When H is recognized (prob 1/3)

H must make both W's accept (unanimity). Each W's reservation: V_e(mu)/3.

H offers V_e(mu)/3 to each W. H keeps V(theta) - 2 V_e(mu)/3.

**Profitability check:** H proposes iff V(theta) - 2 V_e(mu)/3 >= V(theta)/3 (disagreement), iff V(theta) >= V_e(mu).

- theta = 1: v >= V_e(mu) always (since V_e(mu) <= v). **H proposes, agreement.**
- theta = 0: 1 >= V_e(mu) only if mu = 0. For mu > 0, 1 < V_e(mu). **H lets it fail, disagreement.**

W_i's expected payoff when H proposes:

h_W(mu) = mu * V_e(mu)/3 + (1 - mu) * 1/3 = **[1 + mu^2(v-1)] / 3**

(Expansion: mu(1 + mu(v-1))/3 + (1-mu)/3 = (mu + mu^2(v-1) + 1 - mu)/3.)

### 3.2. When W_j is recognized (prob 2/3 total)

W_j must get both the other W_k and H to accept.

Other W_k's reservation: V_e(mu)/3. W_j offers exactly this.

**Effective pie for W_j + H:** R(theta, mu) = V(theta) - V_e(mu)/3.

H's reservation: V(theta)/3 (H knows theta).
- theta = 1: v/3
- theta = 0: 1/3

**W_j's screening problem:** Choose offer y_H to H.

**Conservative (high offer):** y_H = v/3. Accepted by both types.
W_j keeps: R(theta, mu) - v/3 = V(theta) - V_e(mu)/3 - v/3.
Expected: V_e(mu) - V_e(mu)/3 - v/3 = **[2V_e(mu) - v] / 3.**

**Aggressive (low offer):** y_H = 1/3. Accepted only by theta = 0 type.
- theta = 0 (prob 1-mu): passes. W_j keeps R(0, mu) - 1/3 = 1 - V_e(mu)/3 - 1/3 = **(2 - V_e(mu))/3 - 0 = [2 - 1 - mu(v-1)]/3 = [1 - mu(v-1)]/3.**
  
  Correction: R(0, mu) - 1/3 = (1 - V_e(mu)/3) - 1/3 = (3 - V_e(mu) - 1)/3 = (2 - V_e(mu))/3 = (2 - 1 - mu(v-1))/3 = (1 - mu(v-1))/3.

- theta = 1 (prob mu): H rejects. Disagreement. Everyone gets V(theta)/3 = v/3. Beliefs update to mu' = 1 (rejection reveals theta = 1), but this is terminal, so the update is irrelevant for payoffs.

W_j's aggressive expected payoff:

F^{agg}(mu) = (1 - mu) * (1 - mu(v-1))/3 + mu * v/3

**Expanding the numerator:**

(1 - mu)(1 - mu(v-1)) + mu v
= 1 - mu(v-1) - mu + mu^2(v-1) + mu v
= 1 - mu v + mu - mu + mu^2(v-1) + mu v
= **1 + mu^2(v-1)**

So: **F^{agg}(mu) = [1 + mu^2(v-1)] / 3.**

### 3.3. Screening threshold for N = 3: ALWAYS AGGRESSIVE

The difference:

F^{agg}(mu) - F^{con}(mu) = [1 + mu^2(v-1)]/3 - [2V_e(mu) - v]/3

Numerator: 1 + mu^2(v-1) - 2 - 2mu(v-1) + v = (v-1)(1 - 2mu + mu^2) = **(v-1)(1-mu)^2 >= 0.**

**For N = 3, the aggressive offer is ALWAYS (weakly) preferred**, with strict preference for mu < 1 and equality at mu = 1.

**Interpretation:** With only 3 players (1 other W besides the proposer), the cost of the conservative strategy (paying H's high reservation v/3 instead of 1/3) is large relative to the risk of rejection. W always gambles.

### 3.4. Round 2 Continuation Values (Package C, N = 3)

Since W always plays aggressive:

**W_i's payoff by proposer identity:**

1. H proposes (1/3): W_i gets h_W(mu) = [1 + mu^2(v-1)]/3.
2. W_i proposes (1/3): W_i gets F^{agg}(mu) = [1 + mu^2(v-1)]/3.
3. Other W proposes (1/3): 
   - theta = 0 (1-mu): passes, W_i gets V_e(mu)/3.
   - theta = 1 (mu): fails, W_i gets v/3.
   - Expected: [(1-mu)V_e(mu) + mu v]/3 = [1 + (v-1)mu(2-mu)]/3.

Full expected payoff:

**V_W^{R2}(C, mu) = {2[1 + mu^2(v-1)] + 1 + (v-1)mu(2-mu)} / 9**

Simplifying the numerator: 2 + 2mu^2(v-1) + 1 + 2mu(v-1) - mu^2(v-1) = 3 + (v-1)(mu^2 + 2mu).

$$\boxed{V_W^{R2}(C, \mu) = \frac{3 + (v-1)(\mu^2 + 2\mu)}{9}}$$

**Verification:** mu = 0 gives 3/9 = 1/3. mu = 1 gives (3 + 3(v-1))/9 = v/3. Correct.

**Convexity:** d^2/dmu^2 [V_W^{R2}] = 2(v-1)/9 > 0. **Convex in mu.** The non-linearity from Round 2 alone is convex, meaning BP applied to Round 2 alone cannot help the Sender. The kink must come from Round 1.

**H's Round 2 continuation (conditional on theta):**

V_H^{R2}(C, theta=1, mu) = (1/3)[v - 2V_e(mu)/3] + (2/3)(v/3) = **[5v - 2 - 2mu(v-1)] / 9**

V_H^{R2}(C, theta=0, mu) = (1/3)(1/3) + (2/3)(1/3) = **1/3**

(Under theta = 0: H lets proposal fail when recognized; W's aggressive offers are accepted by H. In both cases H gets 1/3.)

### 3.5. General N: Screening threshold

For general N >= 3, the screening problem in Round 2 yields:

F^{agg}(mu) - F^{con}(mu) = (v-1)(N-2)(mu - 1)(mu - 1/(N-2)) / N

**Screening threshold:** mu_s^{R2} = 1/(N-2).

- N = 3: mu_s = 1 (always aggressive). 
- N = 4: mu_s = 1/2.
- N = 5: mu_s = 1/3.
- Large N: mu_s -> 0 (almost always conservative).

**This threshold is independent of v and beta.** It depends only on N.

---

## 4. Round 1 Solution, Package A (N = 3)

H proposes. Needs 1 W to accept.

W_i's reservation: beta * V_{W_i}^{R2}(A, mu) = beta * V_e(mu)/6.

(Beliefs don't update on rejection under Package A: H proposes the same way in both rounds, and W's have no new information.)

H offers beta V_e(mu)/6 to one W. Proposal passes.

**Payoffs:**

V_H(A, theta, mu) = V(theta) - beta V_e(mu)/6

V_W(A, mu) = (1/2) * beta V_e(mu)/6 = **beta V_e(mu) / 12**

Taking expectation over theta:

E[V_H(A, mu)] = V_e(mu) - beta V_e(mu)/6 = **V_e(mu)(6 - beta) / 6**

**Both V_H and V_W are LINEAR in mu under Package A.** No kink. No non-linearity. This is the baseline for comparison.

---

## 5. Round 1 Solution, Package C (N = 3): THE KEY SECTION

### 5.1. When H is recognized (prob 1/3): Pooling

Under Assumption P (v < 3/(2 beta)), H can afford to make the same offer to both W's regardless of theta.

Each W's reservation: beta * V_W^{R2}(C, mu). Define:

**Omega(mu) := V_W^{R2}(C, mu) = [3 + (v-1)(mu^2 + 2mu)] / 9**

H offers beta * Omega(mu) to each W. Both accept. H keeps V(theta) - 2 beta Omega(mu).

**Pooling feasibility (binding for theta = 0):** 1 >= 2 beta Omega(mu). At mu = 1: 1 >= 2 beta v/3, i.e., v <= 3/(2 beta). This is Assumption P.

Under pooling, rejection reveals nothing (mu' = mu). W's payoff when H proposes: beta Omega(mu).

### 5.2. When W_j proposes (prob 2/3 total): Screening

W_j offers beta Omega(mu) to the other W_k (reservation). Remaining effective pie:

**R(theta, mu) = V(theta) - beta Omega(mu)**

H's reservation (from going to Round 2, knowing theta):

- theta = 1: beta * Psi(mu), where **Psi(mu) := V_H^{R2}(C, 1, mu) = [5v - 2 - 2mu(v-1)] / 9**
- theta = 0: beta * (1/3)

W_j chooses offer y_H to H:

**Conservative:** y_H = beta Psi(mu). Accepted by both types (Psi(mu) >= 1/3 always since 5v - 2 - 2mu(v-1) >= 3 iff 5v >= 5 + 2mu(v-1), which holds for v >= 1).

W_j's payoff: R(theta, mu) - beta Psi(mu) = V(theta) - beta [Omega(mu) + Psi(mu)].
Expected: V_e(mu) - beta [Omega(mu) + Psi(mu)].

**Aggressive:** y_H = beta/3. Accepted only by theta = 0 type.

- theta = 0 (prob 1-mu): passes. W_j keeps R(0, mu) - beta/3 = 1 - beta Omega(mu) - beta/3.
- theta = 1 (prob mu): H rejects. Round 2 with mu' = 1 (H's rejection reveals theta = 1). 
  In Round 2 at mu' = 1: everyone gets v/3 (standard BF with known pie).
  W_j's Round 2 payoff: beta * v/3.

Expected aggressive payoff:

F_1^{agg}(mu) = (1-mu)[1 - beta Omega(mu) - beta/3] + mu * beta * v/3

Expected conservative payoff:

F_1^{con}(mu) = V_e(mu) - beta [Omega(mu) + Psi(mu)]

### 5.3. The Screening Threshold mu_s

Define Delta_1(mu) := F_1^{agg}(mu) - F_1^{con}(mu). W_j prefers aggressive iff Delta_1 > 0.

**Computing Omega(mu) + Psi(mu):**

Omega + Psi = [3 + (v-1)(mu^2 + 2mu) + 5v - 2 - 2mu(v-1)] / 9
= [1 + 5v + (v-1)mu^2] / 9

(The 2mu(v-1) terms cancel.)

So F_1^{con}(mu) = V_e(mu) - beta [1 + 5v + (v-1) mu^2] / 9.

And the "cost" of the aggressive strategy's offer portion: beta Omega(mu) + beta/3 = beta [3 + (v-1)(mu^2 + 2mu) + 3] / 9 = beta [6 + (v-1)(mu^2 + 2mu)] / 9.

**Computing Delta_1:**

Delta_1 = (1-mu) - (1-mu) beta [6 + (v-1)(mu^2 + 2mu)]/9 + mu beta v/3
         - 1 - mu(v-1) + beta [1 + 5v + (v-1) mu^2]/9

After collecting terms (multiply through by 9):

9 Delta_1 = 9(1-mu) - (1-mu) beta [6 + (v-1)(mu^2 + 2mu)] + 3 mu beta v
            - 9 - 9 mu(v-1) + beta [1 + 5v + (v-1) mu^2]

= -9 mu - 9 mu(v-1) + beta { [1 + 5v + (v-1) mu^2] - (1-mu)[6 + (v-1)(mu^2 + 2mu)] + 3 mu v }

The term in braces:

B = 1 + 5v + (v-1) mu^2 
  - 6 - (v-1) mu^2 - 2mu(v-1) + 6mu + (v-1) mu^3 + 2mu^2(v-1)
  + 3 mu v

= (5v - 5) + 6mu - 2mu(v-1) + 3mu v + 2(v-1) mu^2 + (v-1) mu^3

= 5(v-1) + mu[6 - 2v + 2 + 3v] + (v-1) mu^2(2 + mu)

= 5(v-1) + mu(8 + v) + (v-1) mu^2(2 + mu)

So:

**9 Delta_1 = -9 mu v + beta [5(v-1) + mu(8 + v) + (v-1) mu^2(2 + mu)]**

Setting Delta_1 = 0:

beta [5(v-1) + mu(8 + v) + (v-1) mu^2(2 + mu)] = 9 mu v

This is a **cubic equation** in mu (from the mu^3 term in (v-1) mu^2(2+mu) = (v-1)(2mu^2 + mu^3)):

**beta(v-1) mu^3 + 2 beta(v-1) mu^2 + beta(8+v) mu + 5 beta(v-1) - 9 mu v = 0**

Rearranging:

**beta(v-1) mu^3 + 2 beta(v-1) mu^2 + [beta(8+v) - 9v] mu + 5 beta(v-1) = 0**

### 5.4. Properties of the screening threshold

**At mu = 0:** Delta_1(0) = beta * 5(v-1) / 9 > 0. Aggressive is preferred.

**At mu = 1:** 
9 Delta_1(1) = -9v + beta[5(v-1) + (8+v) + 3(v-1)] = -9v + beta[5v - 5 + 8 + v + 3v - 3] = -9v + beta[9v] = 9v(beta - 1) < 0. Conservative is preferred.

Since Delta_1(0) > 0 and Delta_1(1) < 0, by continuity there exists at least one root mu_s in (0, 1).

**The screening threshold mu_s exists and is interior.** For mu < mu_s, W proposes aggressively (low offer to H). For mu > mu_s, W proposes conservatively (high offer to H).

### 5.5. Numerical example

For v = 1.5, beta = 0.5: the cubic reduces to mu^3 + 2mu^2 - 35mu + 5 = 0.

Delta_1(0) > 0. Delta_1(0.143) approx 0. Delta_1(0.15) < 0.

**mu_s ≈ 0.144.**

For v = 1.5, beta = 0.9: beta(v-1) = 0.45, beta(8+v) = 0.9*9.5 = 8.55, 9v = 13.5.

Cubic: 0.45 mu^3 + 0.9 mu^2 + (8.55 - 13.5) mu + 2.25 = 0
=> 0.45 mu^3 + 0.9 mu^2 - 4.95 mu + 2.25 = 0
=> mu^3 + 2 mu^2 - 11 mu + 5 = 0

Testing mu = 0.5: 0.125 + 0.5 - 5.5 + 5 = 0.125. Close.
Testing mu = 0.48: 0.1106 + 0.4608 - 5.28 + 5 = 0.291. Hmm.
Testing mu = 0.55: 0.166 + 0.605 - 6.05 + 5 = -0.279.

Root around mu_s ≈ 0.51.

**Key observation:** mu_s depends on both v and beta. It is NOT a simple function of N alone (unlike the Round 2 threshold 1/(N-2)). This is the source of the genuine interaction between BP and BF.

---

## 6. Continuation Values and the Kink (N = 3)

### 6.1. H's expected payoff under Package C

V_H(C, theta, mu) = (1/3) [V(theta) - 2 beta Omega(mu)]   [H proposes, pooling]
                   + (2/3) w_H(theta, mu)                   [W proposes]

where w_H depends on the screening regime:

**For mu < mu_s (aggressive):**
- theta = 0: W's offer y_H = beta/3. H accepts. H gets beta/3.
- theta = 1: W's offer y_H = beta/3. H rejects. Disagreement then Round 2 at mu' = 1. H gets beta * v/3.

So w_H(theta, mu) = beta V(theta)/3.  (H gets beta V(theta)/3 regardless.)

**For mu > mu_s (conservative):**
- Both types: W's offer y_H = beta Psi(mu). H accepts. H gets beta Psi(mu).

So w_H(theta, mu) = beta Psi(mu). (Independent of theta.)

### 6.2. Expected V_H(C, mu) over theta

**For mu < mu_s:**

E[V_H(C, mu)] = (1/3)[V_e(mu) - 2 beta Omega(mu)] + (2/3) beta V_e(mu)/3
= V_e(mu)/3 + 2 beta V_e(mu)/9 - 2 beta Omega(mu)/3
= **V_e(mu)(3 + 2beta)/9 - 2 beta Omega(mu)/3**

**For mu > mu_s:**

E[V_H(C, mu)] = (1/3)[V_e(mu) - 2 beta Omega(mu)] + (2/3) beta Psi(mu)
= **V_e(mu)/3 - 2 beta Omega(mu)/3 + 2 beta Psi(mu)/3**

### 6.3. The slope change at mu_s

Both expressions are smooth (quadratic) in mu on their respective domains. At mu = mu_s, continuity holds (by definition, since mu_s is the indifference point and both strategies give the same outcome to H at the boundary... actually this needs checking).

**Actually, continuity of V_H at mu_s:** At mu_s, W_j is indifferent between aggressive and conservative. But H's payoff differs:

Left (aggressive): (2/3) w_H = (2/3) beta V(theta)/3 = 2 beta V(theta)/9.
Right (conservative): (2/3) w_H = (2/3) beta Psi(mu_s).

These must be compared. E_theta of left: 2 beta V_e(mu)/9. Right: 2 beta Psi(mu_s)/3.

At mu_s, V_e(mu_s)(1/9) vs Psi(mu_s)/3. In general these are NOT equal, so **V_H has a JUMP at mu_s, not just a kink.**

Wait, but W_j is randomizing at mu_s (indifferent). For a single W_j, the strategy is deterministic on each side of mu_s and mixed at mu_s. H's payoff is determined by W_j's strategy choice. At mu_s exactly, W_j can play either strategy.

**The value function V_H(C, mu) has a DISCONTINUITY at mu_s** (from H's perspective, H gets different payoffs depending on whether W plays aggressive or conservative, even though W is indifferent).

More precisely: the expected value E[V_H(C, mu)] jumps at mu_s because H gets beta V(theta)/3 under aggressive vs beta Psi(mu) under conservative, and these differ.

Under aggressive (mu < mu_s): E[w_H] = beta V_e(mu)/3.
Under conservative (mu > mu_s): E[w_H] = beta Psi(mu).

At mu = mu_s:
Left: beta V_e(mu_s)/3 = beta [1 + mu_s(v-1)]/3.
Right: beta Psi(mu_s) = beta [5v - 2 - 2mu_s(v-1)]/9.

Difference (right - left): beta {[5v - 2 - 2mu_s(v-1)]/9 - [1 + mu_s(v-1)]/3}
= beta {[5v - 2 - 2mu_s(v-1) - 3 - 3mu_s(v-1)] / 9}
= beta {[5v - 5 - 5mu_s(v-1)] / 9}
= **5 beta (v-1)(1 - mu_s) / 9 > 0.**

So the right limit EXCEEDS the left limit: **V_H jumps UP at mu_s.**

**This is important:** When W switches from aggressive to conservative, H is BETTER OFF (H gets a higher offer from the conservative W). The jump in V_H at mu_s is upward, of magnitude:

**Jump = (2/3) * 5 beta(v-1)(1-mu_s) / 9 = 10 beta(v-1)(1-mu_s) / 27.**

(The 2/3 factor is the probability that a W proposes.)

### 6.4. Shape of E[V_H(C, mu)]

- For mu in [0, mu_s): E[V_H] = V_e(mu)(3 + 2beta)/9 - 2 beta Omega(mu)/3. This is quadratic in mu (from the mu^2 term in Omega). The function is increasing (higher mu -> higher expected pie).

- At mu = mu_s: upward jump of 10 beta(v-1)(1-mu_s)/27.

- For mu in (mu_s, 1]: E[V_H] = V_e(mu)/3 + 2 beta [Psi(mu) - Omega(mu)]/3. Also quadratic.

**The upward jump creates a DISCONTINUITY in the value function, not just a kink.** This is even better than a kink for the concavification argument: a jump discontinuity means the concave closure must "bridge" the gap, creating a region where BP adds value.

### 6.5. V_W(C, mu)

**For mu < mu_s (aggressive):**

V_W(C, mu) = (1/3) beta Omega(mu) + (1/3) F_1^{agg}(mu) + (1/3) [(1-mu) beta Omega(mu) + mu beta v/3]

**For mu > mu_s (conservative):**

V_W(C, mu) = (1/3) beta Omega(mu) + (1/3) F_1^{con}(mu) + (1/3) beta Omega(mu)
= (2/3) beta Omega(mu) + (1/3) F_1^{con}(mu)

The details follow from substituting the formulas in Section 5. The key property is that V_W is also piecewise smooth with a potential discontinuity at mu_s.

---

## 7. The BP Problem

### 7.1. Entry condition

W enters iff:

mu + V_W(R, mu) >= c

(Using the V1 specification where theta contributes directly to W's payoff via E[theta | s] = mu.)

**Package A:** tau(A) defined by mu + beta V_e(mu)/12 = c.

tau(A) = (12c - beta) / (12 + beta(v-1)).  **Constant (independent of mu).**

**Package C:** tau(C) defined by mu + V_W(C, mu) = c. Since V_W(C, mu) is piecewise, tau(C) is the root of a piecewise equation. If tau(C) < mu_s, it's in the aggressive regime; if tau(C) > mu_s, in the conservative regime.

### 7.2. H's value function

v(mu, R) = 1{mu >= tau(R)} * [g + E[V_H(R, mu)]]

**Package A:** v(mu, A) = 1{mu >= tau(A)} * [g + V_e(mu)(6-beta)/6]. Zero below threshold, linear above. Standard concavification: line from origin tangent to the function.

**Package C:** v(mu, C) has:
- Zero below tau(C).
- A jump at mu_s (from Section 6.3).
- Quadratic pieces above tau(C).

If tau(C) < mu_s: the value function is zero, then rises (aggressive regime), then JUMPS UP at mu_s, then continues (conservative regime). The concavification must account for the jump.

If tau(C) > mu_s: the jump is below the threshold (irrelevant for entry). The value function is zero, then rises smoothly. Less interesting.

**The interesting case is tau(C) < mu_s < 1:** the screening threshold is ABOVE the entry threshold. BP can manipulate beliefs into the region where the jump matters.

### 7.3. Concavification with the jump

The concave closure of a function with an upward jump is straightforward: draw the line from (0, 0) tangent to the value function at or above the jump point. The jump creates a "free lift" --- the same posterior mu gives a higher payoff above mu_s than below it.

The concavification of v(mu, C) may look like:
- A line from (0, 0) to some point on the post-jump curve.
- Then follow the curve.

This means the optimal BP signal sends beliefs to a distribution concentrated on {0, some point above mu_s}, creating a "persuade to the conservative regime" effect. The value of this strategy depends on:

1. The height of the jump (10 beta(v-1)(1-mu_s)/27).
2. The position of mu_s relative to tau(C).
3. The slope of the value function above mu_s.

### 7.4. Dominance condition

U_H*(A) = concavification of v(mu, A) at p.
U_H*(C) = concavification of v(mu, C) at p.

C dominates iff U_H*(C) > U_H*(A).

Under Package A: U_H*(A) = [g + V_e(tau(A))(6-beta)/6] * p / tau(A).  (Standard.)

Under Package C: U_H*(C) depends on the jump at mu_s. If p < mu_s, the optimal signal pushes some mass above mu_s, capturing the jump. The exact formula depends on the concavification, which involves mu_s.

**Since mu_s depends on v and beta (through the cubic in Section 5.3), the dominance condition U_H*(C) > U_H*(A) depends non-trivially on v and beta.** These parameters enter through mu_s in a way that has no counterpart under Package A (where everything is linear). **This is why v and beta do NOT cancel.**

---

## 8. Why v and beta Don't Cancel

In V1, the dominance condition is:

[g + (1 + tau(C) delta) s_H(C)] / tau(C)  vs  [g + (1 + tau(A) delta) s_H(A)] / tau(A)

Both tau(R) = (c/s_W(R) - 1)/delta. Substituting, delta appears in both numerator and denominator in the same way, allowing cancellation.

In V3, the Package C side involves the jump at mu_s. The concavification has the form:

U_H*(C) approx [g + V_H^{post-jump}(mu_s)] * p / mu_s   (if the tangent line hits at mu_s)

or more generally involves mu_s as a characteristic point. Since:

**mu_s is a root of: beta(v-1) mu^3 + 2 beta(v-1) mu^2 + [beta(8+v) - 9v] mu + 5 beta(v-1) = 0**

mu_s is an algebraic function of (v, beta) that does NOT simplify. It enters the dominance condition in a way that is structurally different from how v enters under Package A.

**Concretely:** Under Package A, the ratio [g + V_H(A, tau(A))] / tau(A) can be simplified because V_H(A, mu) = V_e(mu)(6-beta)/6 is linear in mu, and tau(A) is a linear function of v. Under Package C, V_H(C, mu) has a jump at mu_s, and the concavification depends on the jump height and position --- both functions of v and beta through the cubic.

The ratio v(mu_s, C) / mu_s involves mu_s^2 and mu_s^3 terms (from Omega and the quadratic payoffs), which do not simplify against the linear v terms. **The non-linearity is genuine and structural.**

---

## 9. Closed-Form Feasibility Assessment (N = 3)

### What is closed-form:

1. **Round 2 payoffs:** Fully closed-form. V_W^{R2} and V_H^{R2} are quadratic in mu.
2. **H's Round 1 pooling offer:** Closed-form (function of Omega(mu)).
3. **Conservative and aggressive payoffs:** Closed-form (quadratic in mu).
4. **Jump magnitude:** 10 beta(v-1)(1-mu_s)/27. Closed-form given mu_s.
5. **tau(A):** Closed-form (linear expression).
6. **tau(C):** Root of a quadratic on the relevant piece. Closed-form.
7. **Concavification:** Piecewise linear (tangent lines). Closed-form given the characteristic points.

### What requires numerical solution:

1. **mu_s:** Root of a cubic. Cardano's formula gives an explicit (but messy) expression. Better computed numerically.

### Assessment:

**The N = 3 model is analytically tractable.** The cubic for mu_s is the only non-trivial equation. All other quantities are elementary. The dominance condition can be expressed as a comparison of explicit functions of mu_s, with mu_s implicitly defined by the cubic.

**For general N >= 4:** The Round 2 screening threshold 1/(N-2) creates an additional kink IN Round 2 (Section 3.5). This kink feeds into Round 1 through the continuation values, creating a richer (but more complex) structure. The Round 1 screening threshold becomes harder to characterize. Recommend: solve N = 3 first, then extend numerically.

---

## 10. Implementation Roadmap

### Phase 1: Round 2 (0.5 day)
- [ ] Implement Omega(mu), Psi(mu) for N = 3.
- [ ] Verify boundary conditions (mu = 0, mu = 1).
- [ ] Plot V_W^{R2}(C, mu) and V_H^{R2}(C, theta, mu).

### Phase 2: Round 1 Screening (1 day)
- [ ] Implement F_1^{agg}(mu), F_1^{con}(mu).
- [ ] Find mu_s numerically (root of cubic).
- [ ] Verify Delta_1(0) > 0, Delta_1(1) < 0.
- [ ] Plot Delta_1(mu) for several (v, beta) pairs.
- [ ] Compute and verify the jump magnitude at mu_s.

### Phase 3: Continuation Values (1 day)
- [ ] Implement E[V_H(C, mu)] on both pieces.
- [ ] Implement V_W(C, mu) on both pieces.
- [ ] Verify the upward jump at mu_s.
- [ ] Plot V_H(C, mu) and V_W(C, mu) showing the discontinuity.
- [ ] Implement V_H(A, mu) and V_W(A, mu) for comparison.

### Phase 4: BP Problem (1-2 days)
- [ ] Compute tau(A) and tau(C) for a parameter grid.
- [ ] Construct value functions v(mu, A) and v(mu, C).
- [ ] Compute concavifications numerically.
- [ ] Compare U_H*(A) vs U_H*(C) across (v, beta, c, g).
- [ ] Identify dominance region.
- [ ] Verify that dominance condition depends on v and beta (non-cancellation).

### Phase 5: Formal Results (2-3 days)
- [ ] State propositions for N = 3.
- [ ] Prove existence of screening threshold (intermediate value theorem on cubic).
- [ ] Characterize the jump and its dependence on (v, beta).
- [ ] Derive sufficient conditions for C to dominate A.
- [ ] Comparative statics: d mu_s / d beta, d mu_s / d v.
- [ ] Connection to OMC narrative.

---

## Appendix A: Key Formulas Summary (N = 3)

| Symbol | Formula |
|--------|---------|
| V_e(mu) | 1 + mu(v-1) |
| Omega(mu) = V_W^{R2}(C, mu) | [3 + (v-1)(mu^2 + 2mu)] / 9 |
| Psi(mu) = V_H^{R2}(C, 1, mu) | [5v - 2 - 2mu(v-1)] / 9 |
| Omega + Psi | [1 + 5v + (v-1) mu^2] / 9 |
| V_W^{R2}(A, mu) | V_e(mu) / 6 |
| V_H^{R2}(A, theta, mu) | V(theta) - V_e(mu)/3 |
| V_W(A, mu) | beta V_e(mu) / 12 |
| V_H(A, mu) | V_e(mu)(6 - beta) / 6 |
| tau(A) | (12c - beta) / (12 + beta(v-1)) |
| mu_s | Root of beta(v-1)mu^3 + 2beta(v-1)mu^2 + [beta(8+v)-9v]mu + 5beta(v-1) = 0 |
| Jump at mu_s | 10 beta(v-1)(1 - mu_s) / 27 |
| Assumption P | v < 3 / (2 beta) |

## Appendix B: Scratch Work for the Cubic

For N = 3, the screening indifference condition 9 Delta_1(mu) = 0 gives:

-9 mu v + beta [5(v-1) + mu(8+v) + (v-1)(2mu^2 + mu^3)] = 0

Rearranging:

beta(v-1) mu^3 + 2 beta(v-1) mu^2 + [beta(8+v) - 9v] mu + 5 beta(v-1) = 0

**Dividing by beta(v-1)** (valid since v > 1, beta > 0):

mu^3 + 2 mu^2 + [(8+v)/( v-1) - 9v/(beta(v-1))] mu + 5 = 0

Define k := 9v / [beta(v-1)] - (8+v)/(v-1) = [9v - beta(8+v)] / [beta(v-1)].

The cubic becomes: **mu^3 + 2 mu^2 - k mu + 5 = 0.**

For v = 1.5, beta = 0.5: k = [13.5 - 0.5*9.5] / [0.5*0.5] = [13.5 - 4.75] / 0.25 = 8.75/0.25 = 35.
Cubic: mu^3 + 2 mu^2 - 35 mu + 5 = 0. Root ≈ 0.144.

For v = 1.5, beta = 0.9: k = [13.5 - 0.9*9.5] / [0.9*0.5] = [13.5 - 8.55] / 0.45 = 4.95/0.45 = 11.
Cubic: mu^3 + 2 mu^2 - 11 mu + 5 = 0. Root ≈ 0.51.

**Comparative static:** Higher beta -> lower k -> higher mu_s. As beta increases, the screening threshold moves up. Intuition: higher patience makes Round 2 more valuable, raising H's reservation, making the conservative offer more expensive, so W sticks with aggressive for a wider range of beliefs.

**Comparative static in v:** Numerator of k is 9v - beta(8+v) = v(9-beta) - 8 beta. Increasing v increases k, which DECREASES mu_s. Higher pie ratio makes the aggressive gamble more attractive (the payoff from theta = 1 is larger), so W plays aggressive for a wider range.

---

## Appendix C: Why N = 3 Has No Round 2 Screening Threshold

For N = 3, the Round 2 screening threshold is mu_s^{R2} = 1/(N-2) = 1. This means W ALWAYS plays aggressive in Round 2.

The reason: in the Round 2 terminal game, the aggressive offer risks only the disagreement payoff V(theta)/N. With N = 3, there is only one other W besides the proposer. The "cost" of conservative (offering H v/3 instead of 1/3) is (v-1)/3, which is the certain cost. The "benefit" of conservative over aggressive is avoiding disagreement when theta = 1, which gives W_j v/3 from disagreement vs v/3 from the conservative offer --- the SAME payoff. So conservative offers no benefit over aggressive when theta = 1, but costs more when theta = 0. Hence aggressive always dominates.

This is why the non-linearity must come from Round 1, where going to Round 2 (with updated beliefs) is the "punishment" for H's rejection, and the Round 2 continuation value creates a wedge between types.

---

## Appendix D: The Discontinuity vs Kink Distinction

In Section 6.3, we showed that E[V_H(C, mu)] has an upward JUMP (discontinuity) at mu_s, not merely a kink. This is because:

1. At mu just below mu_s, W plays aggressive. H gets beta V(theta)/3 from W's proposal.
2. At mu just above mu_s, W plays conservative. H gets beta Psi(mu_s) from W's proposal.
3. These payoffs differ at mu_s: beta Psi(mu_s) > beta V_e(mu_s)/3 (by the computation in Section 6.3).

The jump magnitude is 10 beta(v-1)(1-mu_s)/27 > 0.

**However**, in practice, W's strategy at mu_s is a mixed strategy (W is indifferent). If W randomizes continuously at mu_s, the expected payoff function is continuous. The jump appears only in the "deterministic" version where W plays pure aggressive below and pure conservative above.

**For the concavification argument, the jump is the right object to work with.** The concave closure of a function with a jump picks up the upper envelope. If we smooth the jump with mixing, the kink (slope change) replaces the jump but the qualitative effect on concavification is the same: the function is locally convex near mu_s, and BP can exploit this.

**Formally:** Whether we model the screening threshold as a sharp jump (pure strategies) or a kink (mixed strategies), the concavification benefits from the non-linearity. The sharp jump is a conservative (lower bound) on the effect --- the actual continuous version with mixing gives an even richer concavification.
