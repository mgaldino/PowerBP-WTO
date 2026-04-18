# Plan: 2-Round Baron-Ferejohn with Asymmetric Information about Pie Size

**Status**: DRAFT
**Date**: 2026-04-17

---

## 0. Motivation

The current model's Stage 2 is a single-round redistribution game with exogenous status quo 1/N. This makes the continuation values V_H(R) and V_W(R) "arithmetic" --- they follow from one-shot coalition logic with no strategic depth. The comparison A(R)/tau(R) that drives the main result is a ratio of known constants, with no genuine interaction between the bargaining stage and the information structure.

This plan extends Stage 2 to a **2-round Baron-Ferejohn game where H has private information about the pie size V(theta)**. The key consequence: the bargaining stage itself becomes a game of asymmetric information, where proposals and acceptance/rejection decisions convey (or conceal) information about theta. This creates a genuine feedback loop between Stage 1 (BP signal -> posterior mu) and Stage 2 (bargaining with informed H), enriching the mechanism beyond arithmetic comparison.

### What this extension should deliver

1. **Continuation values that depend on mu**: V_H(R, mu) and V_W(R, mu) are now functions of the posterior, not constants. This makes tau(R, mu) endogenous to the signal.
2. **Signaling within bargaining**: H's proposal in Round 1 may reveal information about V(theta). This creates a signaling game nested inside the bargaining game.
3. **Belief updating through play**: Rejection of an offer may cause belief revision, affecting Round 2 payoffs.
4. **Qualitatively richer trade-off**: Under Package A (majority + agenda), H's information advantage in bargaining may be partially offset by the signaling constraint. Under Package C (consensus), the veto constraint interacts with uncertainty about V(theta) in a different way.

---

## 1. Primitives

### Players
- H (hegemon): informed player, knows theta.
- W_1, ..., W_n (weak states): uninformed, hold posterior mu after Stage 1 signal.
- N = n + 1 total players.

### State and pie
- theta in {0, 1}, with Pr(theta = 1) = p (prior).
- Pie size: V(theta = 1) = V_H, V(theta = 0) = V_L, with V_H > V_L > 0.
- Normalization convention: set V_L = 1 and V_H = v > 1 (so the "low" pie is 1, "high" pie is v). This simplifies algebra. All results can be stated in terms of v = V_H/V_L.

### Discount factor
- beta in (0, 1): common discount factor between Round 1 and Round 2.

### Information at start of Stage 2
- H knows theta (hence knows V(theta)).
- Each W_i holds posterior mu(s) = Pr(theta = 1 | s), determined by the Stage 1 BP signal.
- mu is common knowledge among the W_i (public signal), but H knows theta exactly.

### Disagreement payoff
- If Round 2 proposal is also rejected: each player receives d_i.
- **Baseline specification**: d_i = 0 for all i (complete disagreement destroys the pie). This is the standard BF assumption.
- **Alternative specification**: d_i = (1/N) * E[V(theta) | beliefs at Round 2] (proportional to expected pie under current beliefs). This is more relevant if the status quo is "keep the institution running at default terms."
- **Recommendation**: Start with d_i = 0. It is cleaner, standard, and the asymmetric-info effects are already rich enough. The d_i > 0 case can be explored as a robustness check.

---

## 2. Full Game Tree

### Stage 0: Institutional Choice
H chooses R in {A, C}.

### Stage 1: Bayesian Persuasion + Entry
1. Nature draws theta in {0, 1} with Pr(theta = 1) = p.
2. H observes theta, chooses signal structure pi(s | theta).
3. Public signal s is realized. W_i form posterior mu(s).
4. Each W_i decides to enter (a_i = 1) or stay out (a_i = 0).
5. Institution forms if entry threshold is met.

### Stage 2: 2-Round Baron-Ferejohn with Asymmetric Information

Notation: V = V(theta) is the true pie size (known to H, not to W).

#### Round 1

**Step 1.1 --- Recognition.**
- Package A: H is recognized with probability 1 (agenda control).
- Package C: Each of the N players is recognized with probability 1/N.

**Step 1.2 --- Proposal.**
- The recognized player i proposes a division x = (x_1, ..., x_N) with sum(x_j) <= V(theta).
  - If i = H: H knows V(theta) and proposes optimally. The proposal x itself may reveal information about theta (signaling).
  - If i = W_j: W_j does not know V(theta). W_j proposes based on E[V | mu], i.e., V_e(mu) = mu * V_H + (1 - mu) * V_L. The proposal may be infeasible if V_e(mu) > V(theta) (proposes more than the actual pie). **Convention**: if the total proposed exceeds V(theta), the proposal automatically fails (is treated as a rejection by nature, or equivalently, H rejects because the pie cannot cover it). Alternatively: proposals must satisfy sum(x_j) <= V_L (always feasible). See Section 6 for discussion.

**Step 1.3 --- Voting.**
- Package A (majority): proposal passes if at least q = ceil((N+1)/2) players vote yes (including the proposer).
- Package C (consensus/unanimity): proposal passes if all N players vote yes.
- Each voter votes yes iff their share x_i >= beta * CV_i^{R2}(beliefs), where CV_i^{R2}(beliefs) is their continuation value from going to Round 2 with updated beliefs.

**Step 1.4 --- Outcome.**
- If passes: game ends, payoffs are (x_1, ..., x_N).
- If rejected: go to Round 2. All payoffs discounted by beta. **Beliefs may update** (see Section 4).

#### Round 2

**Step 2.1 --- Recognition.** Same rule as Round 1 (determined by R).

**Step 2.2 --- Proposal.** Recognized player proposes division of V(theta), now with updated beliefs mu' (posterior after Round 1 play).

**Step 2.3 --- Voting.** Same voting rule as Round 1. Reservation value is now beta * d_i (= 0 under baseline).

**Step 2.4 --- Outcome.**
- If passes: payoffs are beta * (x_1, ..., x_N).
- If rejected: payoffs are beta^2 * (d_1, ..., d_N) = (0, ..., 0) under baseline.

---

## 3. Information Sets and Beliefs

### At the start of Stage 2
- H's information set: {theta, s, R}. H knows the true state.
- W_i's information set: {s, R}. W_i holds posterior mu(s) but does not know theta.

### After Round 1 proposal (on the equilibrium path)

**Case: H proposes in Round 1.**

H's proposal x is observed by all voters. The proposal is a potentially informative action:
- If H's equilibrium strategy is a **separating** function of theta (different proposals for theta = 0 vs theta = 1), then W_i can infer theta from x. After observing x, W_i updates to mu' = 0 or mu' = 1.
- If H's equilibrium strategy is **pooling** (same proposal for both theta), then mu' = mu (no update).
- If H's equilibrium strategy is **semi-separating** (randomizes for one type), then mu' is determined by Bayes' rule.

**Case: W_j proposes in Round 1.**

W_j's proposal conveys no information about theta (W_j does not know theta). However:
- **H's vote (accept/reject) is informative.** Under unanimity (Package C), if H rejects W_j's proposal, this may signal that the pie is low (H cannot afford the proposed shares) or that H is holding out for a better deal. Under majority, H's vote may be pivotal or not.
- **Other W's votes**: uninformative about theta (they also don't know).

### After Round 1 rejection

**Beliefs entering Round 2 (mu'):**

The critical belief-updating question. Let sigma_H(theta) denote H's Round 1 strategy (proposal if H proposes, or accept/reject if W proposes). Then:

mu'(history) = Pr(theta = 1 | s, Round 1 history)

This is computed by Bayes' rule given the equilibrium strategy profile.

**Key subtlety**: the belief update depends on the **equilibrium being played**. The plan must solve for equilibrium strategies and beliefs simultaneously.

---

## 4. Equilibrium Concept

**Perfect Bayesian Equilibrium (PBE)** with the following refinements:

1. **Sequential rationality**: At every information set, each player's strategy maximizes expected payoff given beliefs.
2. **Bayesian consistency**: Beliefs are derived from strategies via Bayes' rule on the equilibrium path.
3. **Off-path beliefs**: For proposals that are never made in equilibrium, beliefs are unrestricted (but we will specify a reasonable off-path belief --- e.g., passive beliefs mu' = mu, or the D1 criterion if multiplicity is a problem).
4. **Stationarity** (within the 2-round game): players do not condition on payoff-irrelevant history beyond what affects beliefs.

**Simplification**: Because the game has only 2 rounds, backward induction is well-defined. Solve Round 2 first (as a function of beliefs mu'), then solve Round 1 given the continuation values from Round 2.

---

## 5. Solution: Round 2 (Terminal Round)

Round 2 is a single-round bargaining game with:
- Pie size V(theta) (known to H, not to W).
- Beliefs mu' (posterior entering Round 2, after Round 1 play).
- Disagreement payoff d_i = 0 (baseline).
- Recognition and voting rule determined by R.

### 5.1. Round 2 under Package A (Majority, H always proposes)

H proposes division x = (x_H, x_{W_1}, ..., x_{W_n}) with sum = V(theta).

**H's problem**: minimize total offered to W's, subject to getting q - 1 votes.

Each W_i votes yes iff x_{W_i} >= beta^2 * d_i = 0 (since rejection leads to zero). So **any positive offer is accepted**. H offers epsilon to q - 1 cheapest W's, zero to the rest, keeps V(theta) - (q-1) * epsilon.

**In the limit (standard BF)**: H offers 0 to each included W (their reservation is 0 since d = 0 and this is the last round). H keeps the entire pie.

Wait --- this is the standard ultimatum result in the final round. With d_i = 0:
- H offers x_{W_i} = 0 to all (or epsilon to q - 1 of them), W's accept (indifferent, assume accept when indifferent).
- **V_H^{R2}(A, theta) = V(theta)**.
- **V_{W_i}^{R2}(A, theta) = 0** for all i.

**Information revelation**: H's Round 2 proposal reveals nothing because H takes everything regardless of theta. W's payoff is 0 either way, so they don't care about theta in Round 2 under Package A.

**Expected Round 2 payoffs (from W's perspective, before theta is realized)**:
- E[V_H^{R2}(A) | mu'] = mu' * V_H + (1 - mu') * V_L = V_e(mu')
- E[V_{W_i}^{R2}(A) | mu'] = 0

### 5.2. Round 2 under Package C (Unanimity, random recognition)

**Case (a): H is recognized (prob 1/N).**

H proposes x = (x_H, x_{W_1}, ..., x_{W_n}) with sum = V(theta). All must accept.

Each W_i's reservation from rejection is 0 (final round, d = 0). So W_i accepts iff x_{W_i} >= 0. H offers x_{W_i} = 0 to all, keeps V(theta).

But wait: under unanimity, each W has a veto. The reservation is 0 (disagreement payoff), so W accepts any non-negative share. H takes everything.

- V_H^{R2}(C, H proposes, theta) = V(theta).
- V_{W_i}^{R2}(C, H proposes, theta) = 0.

**Case (b): W_j is recognized (prob 1/N each, total prob n/N).**

W_j proposes x = (x_H, x_{W_j}, x_{-j}) with sum <= V(theta). All must accept, including H.

**H's acceptance decision**: H votes yes iff x_H >= 0 (reservation is 0). So H accepts any non-negative share. But H **knows V(theta)** --- if W_j proposes sum(x) > V(theta), the proposal is infeasible.

**Key issue**: W_j does not know V(theta). What does W_j propose?

**Sub-case (b.i): W_j proposes conservatively, sum(x) <= V_L.**
This is always feasible. W_j offers x_H = 0, x_{W_k} = 0 for k != j, and x_{W_j} = V_L. But wait, W_j doesn't know V(theta). If W_j proposes to take V_L for herself and give 0 to everyone, this is feasible under both states. H accepts (gets 0, same as disagreement). Other W's accept (get 0, same as disagreement).

Actually, under unanimity, W_j must get all others to accept. They accept x >= 0. So W_j can propose: x_{W_j} = V_L, x_{everyone else} = 0. This is feasible under both states (since V_L <= V(theta) always). All others accept (get 0 = reservation). W_j gets V_L.

But W_j could propose x_{W_j} = V_H > V_L. This is feasible only if theta = 1. If theta = 0, sum(x) > V(theta) = V_L, and the proposal is infeasible.

**How to handle infeasible proposals**: Two approaches:
- (i) **Nature kills infeasible proposals**: if sum(x) > V(theta), proposal is automatically rejected (equivalent to "discovered to be infeasible"). Then game goes to... but this is Round 2, so disagreement payoff 0.
- (ii) **H rejects infeasible proposals**: H knows V(theta). If sum(x) > V(theta), H votes no. Under unanimity, H has veto.

Under approach (ii), H's rejection of an "aggressive" proposal does not reveal information because this is the terminal round (no further play). Under approach (i), the result is the same.

**W_j's optimal proposal in Round 2**:

W_j maximizes E[x_{W_j} * 1{proposal passes}].

- **Conservative**: propose x_{W_j} = V_L. Always passes. Payoff = V_L.
- **Aggressive**: propose x_{W_j} = V_H. Passes only if theta = 1 (prob mu'). Payoff = mu' * V_H.

W_j prefers aggressive iff mu' * V_H > V_L, i.e., **mu' > V_L / V_H = 1/v**.

Define **mu_bar = V_L / V_H = 1/v**: the screening threshold.

**W_j's optimal Round 2 proposal**:
- If mu' > mu_bar: propose aggressively, x_{W_j} = V_H. Gets V_H with prob mu', 0 with prob 1 - mu'. Expected payoff = mu' * V_H.
- If mu' < mu_bar: propose conservatively, x_{W_j} = V_L. Gets V_L for sure.
- If mu' = mu_bar: indifferent. (Assume conservative for concreteness, or randomize.)

**H's payoff when W_j proposes in Round 2**:
- Conservative (mu' < mu_bar): H gets 0 (W_j takes V_L, rest get 0).
- Aggressive (mu' > mu_bar): H gets 0 if theta = 1 (pie = V_H, W_j takes V_H), and "proposal fails" if theta = 0 (pie = V_L < V_H), so H gets 0 from disagreement. Either way, H gets 0.

Wait: if W_j proposes aggressively and theta = 0, the proposal fails (H rejects or infeasible). Then disagreement payoff = 0. If theta = 1, proposal passes, H gets x_H = 0. So H gets 0 regardless.

**Summary of Round 2 expected payoffs under Package C** (from perspective before recognition):

With prob 1/N, H proposes and gets V(theta).
With prob n/N, some W_j proposes and H gets 0.

**H's expected Round 2 payoff (conditional on theta)**:
- V_H^{R2}(C, theta) = (1/N) * V(theta) + (n/N) * 0 = V(theta) / N.

**W_i's expected Round 2 payoff**:
With prob 1/N, W_i proposes and gets:
  - V_L if mu' < mu_bar
  - mu' * V_H if mu' > mu_bar
With prob 1/N, H proposes and W_i gets 0.
With prob (n-1)/N, another W_j proposes and W_i gets 0.

So:
- V_{W_i}^{R2}(C, mu') = (1/N) * [V_L * 1{mu' < mu_bar} + mu' * V_H * 1{mu' >= mu_bar}]

Define:
$$\phi(mu') = V_L \cdot \mathbf{1}\{\mu' < \bar{\mu}\} + \mu' V_H \cdot \mathbf{1}\{\mu' \geq \bar{\mu}\}$$

Then V_{W_i}^{R2}(C, mu') = phi(mu') / N.

**Important**: phi(mu') has a **discontinuity** at mu_bar. For mu' just below mu_bar: phi = V_L. For mu' just above: phi = mu_bar * V_H = V_L. So phi is actually **continuous at mu_bar** (both sides equal V_L). But the derivative jumps: for mu' < mu_bar, phi is flat; for mu' > mu_bar, phi = mu' * V_H is increasing with slope V_H. So phi is continuous but has a **kink** at mu_bar.

Correction: phi(mu_bar) = mu_bar * V_H = (V_L/V_H) * V_H = V_L. So phi is continuous. Good.

For mu' > mu_bar: phi(mu') = mu' * V_H, which is linear in mu'.
For mu' < mu_bar: phi(mu') = V_L, which is constant.

So phi is convex (constant then linear with positive slope). This means V_{W_i}^{R2}(C, mu') = phi(mu')/N is convex in mu'.

### 5.3. Summary of Round 2 Continuation Values

**Package A (majority, H proposes, d = 0):**

| Player | CV^{R2}(A, theta) | E[CV^{R2}(A) \| mu'] |
|--------|--------------------|-----------------------|
| H | V(theta) | V_e(mu') = mu' V_H + (1-mu') V_L |
| W_i | 0 | 0 |

**Package C (unanimity, random recognition, d = 0):**

| Player | E[CV^{R2}(C) \| mu'] |
|--------|-----------------------|
| H | V_e(mu') / N |
| W_i | phi(mu') / N |

where phi(mu') = V_L if mu' < 1/v, and mu' * V_H if mu' >= 1/v.

---

## 6. Solution: Round 1

### 6.1. Round 1 under Package A (Majority, H always proposes)

H proposes in Round 1. H knows V(theta).

**W_i's acceptance condition**: W_i votes yes iff:

x_{W_i} >= beta * E[CV_{W_i}^{R2}(A) | mu'(rejection)]

Under Package A, E[CV_{W_i}^{R2}(A) | mu'] = 0 (from Section 5.1). So W_i accepts iff x_{W_i} >= 0.

**Result**: Under Package A with d = 0, W's accept any non-negative offer in Round 1 (because their Round 2 continuation value is 0). H takes the entire pie in Round 1.

- V_H^{R1}(A, theta) = V(theta).
- V_{W_i}^{R1}(A, theta) = 0.

**This is a knife-edge result.** With d = 0, the 2-round BF under majority with H as permanent proposer gives H all the surplus. This is too extreme.

**Resolution**: Use d_i = (1/N) * V_e(mu) (proportional expected pie at status quo). Or, more naturally, use the **standard BF resolution**: the continuation value for responders comes from the probability of being recognized in Round 2. But under Package A, H is always recognized, so W's continuation value is always 0 from recognition.

**Better resolution**: Let the Round 2 proposer be random even under Package A, but with H having probability p_H > 1/N. Or, adopt the **standard BF with recognition probabilities**: under Package A, H is recognized with probability 1 in Round 1, but Round 2 recognition is random (or H again). If H is always recognized, W's continuation value is 0 and we get the knife-edge.

**Recommended specification for Package A**: H is always the proposer (both rounds). W's Round 2 reservation is d_i = 0. Under majority, H needs q - 1 votes. W accepts any x >= 0.

This means: under Package A, V_H = V(theta) and V_W = 0. The entire pie goes to H. This is actually consistent with the "extreme agenda power" interpretation, but it makes the trade-off with Package C sharper.

Alternatively --- and this may be more interesting --- adopt **d_i = delta_0 / N for some delta_0 > 0** (exogenous disagreement value). Then Round 2 continuation values are non-trivial. But this introduces a free parameter. 

**My recommendation for tractability**: proceed with d = 0 as baseline. The knife-edge under Package A (H gets everything) is actually a feature: it makes Package A maximally strong in terms of extraction, so the result "H sometimes prefers Package C anyway" is more striking.

But we need to check: if V_W(A) = 0, then tau(A) = c - 0 = c. And A(A) = g(n) + V_e(mu) (since H gets the whole pie in expectation). The entry threshold is very high (tau = c), making entry very hard. This creates space for Package C to dominate.

### 6.2. Round 1 under Package C (Unanimity, random recognition)

This is the complex case. Three sub-cases by who is recognized.

#### Sub-case (i): H is recognized (prob 1/N)

H proposes x = (x_H, x_{W_1}, ..., x_{W_n}). Unanimity required. H knows V(theta).

**W_i's acceptance condition**: W_i votes yes iff:

x_{W_i} >= beta * E[CV_{W_i}^{R2}(C) | mu'(rejection)]

The critical question: **what are W's beliefs mu' if they reject H's offer?**

**Signaling problem**: H's offer x is a function of theta. If H offers more (to secure acceptance), W may infer V is high. If H offers less, W may infer V is low. This is a classic signaling game.

**Equilibrium types**:

**(a) Pooling equilibrium**: H offers the same x* regardless of theta.
- mu'(rejection of x*) = mu (no update, since offer is uninformative).
- W accepts iff x_{W_i} >= beta * phi(mu) / N.
- H's optimal pooling offer: x_{W_i} = beta * phi(mu) / N for n included W's (under unanimity, all must accept, so include all).
- Total offered to W's: n * beta * phi(mu) / N = (n/N) * beta * phi(mu).
- H keeps: V(theta) - (n/N) * beta * phi(mu).
- Pooling is feasible iff V_L >= (n/N) * beta * phi(mu). (Even the low-type can afford the offer.)

**(b) Separating equilibrium**: H offers different amounts for theta = 0 and theta = 1.
- If fully separating: W infers theta from the offer. mu' in {0, 1}.
- Under theta = 1: H offers x_{W_i} = beta * phi(1) / N = beta * V_H / N.
  - phi(1) = 1 * V_H = V_H (since mu' = 1 > mu_bar).
  - Total to W: n * beta * V_H / N = (n/N) * beta * V_H.
  - H keeps: V_H - (n/N) * beta * V_H = V_H * (1 - n*beta/N) = V_H * (N - n*beta)/N.
  - Since n = N - 1: H keeps V_H * (N - (N-1)*beta) / N = V_H * (1 + (1 - beta)(N-1))/N. Hmm, let me redo:
    V_H * (N - (N-1)*beta) / N.

- Under theta = 0: H offers x_{W_i} = beta * phi(0) / N = beta * V_L / N.
  - phi(0) = V_L (since mu' = 0 < mu_bar).
  - Total to W: n * beta * V_L / N.
  - H keeps: V_L - (n/N) * beta * V_L = V_L * (N - n*beta)/N.

- Separation requires that theta = 0 type does not want to mimic theta = 1 type (and vice versa):
  - theta = 0 type mimicking theta = 1: offers x_{W_i} = beta * V_H / N. Total to W = n * beta * V_H / N. H keeps V_L - n * beta * V_H / N. This is negative if V_L < n * beta * V_H / N, i.e., if the low-type pie cannot cover the high-type offer. This is likely for large enough v = V_H/V_L.
  - If V_L < n * beta * V_H / N, the low type **cannot** mimic the high type (budget constraint). Separation is automatic (forced by feasibility).
  - Condition: V_L / V_H < n * beta / N = (N-1) * beta / N. I.e., 1/v < (N-1)*beta/N, i.e., **v > N / ((N-1)*beta)**.

For N = 3, beta = 0.9: v > 3 / (2 * 0.9) = 1.667. So if V_H > 1.667 * V_L, separation is forced by budget constraints.

For N = 3, beta = 0.5: v > 3 / (2 * 0.5) = 3. So V_H must be 3x V_L for forced separation.

**(c) Semi-separating equilibrium**: One type randomizes. This is the generic case when the pooling condition binds.

**The general analysis proceeds as follows**:

Define the **pooling offer**: x_P = beta * phi(mu) / N per weak state.

**Pooling is sustainable iff both types prefer pooling to deviating**:
- theta = 1 type: pooling payoff = V_H - n * x_P. Deviation (to, say, a lower offer that gets rejected, going to Round 2): beta * V_H / N. Prefers pooling iff V_H - n * x_P >= beta * V_H / N.
- theta = 0 type: pooling payoff = V_L - n * x_P. Must have V_L >= n * x_P (feasibility). Deviation: beta * V_L / N. Prefers pooling iff V_L - n * x_P >= beta * V_L / N.

The binding constraint is the **low type's feasibility**: V_L >= n * x_P = (n/N) * beta * phi(mu).

If mu < mu_bar: phi(mu) = V_L. So condition is V_L >= (n/N) * beta * V_L, i.e., 1 >= n*beta/N. Since n = N - 1: 1 >= (N-1)*beta/N, i.e., N >= (N-1)*beta, i.e., beta <= N/(N-1). Always true for beta < 1 and N >= 2. So **pooling is always feasible when mu < mu_bar**.

If mu > mu_bar: phi(mu) = mu * V_H. So condition is V_L >= (n/N) * beta * mu * V_H. I.e., 1/v >= (n/N) * beta * mu. I.e., **mu <= N / (n * beta * v)**. This may or may not hold depending on mu.

Define **mu_pool = N / (n * beta * v)**: the maximum belief at which pooling is feasible for the low type.

- If mu <= min(mu_bar, mu_pool): pooling feasible, phi(mu) = V_L.
- If mu_bar < mu <= mu_pool: pooling feasible, phi(mu) = mu * V_H.
- If mu > mu_pool: pooling infeasible for low type. **Forced separation or semi-separation**.

#### Summary of H's Round 1 payoff under Package C (when H proposes)

For the **pooling equilibrium** (when feasible):

V_H^{R1, pool}(C, theta) = V(theta) - n * beta * phi(mu) / N

H's expected payoff (over theta, given mu at entry):
E[V_H^{R1, pool}(C)] = V_e(mu) - (n/N) * beta * phi(mu)

For the **separating equilibrium** (when forced):

V_H^{R1, sep}(C, theta) = V(theta) - n * beta * phi(1{theta=1}) / N
= V(theta) * (N - n*beta) / N   [since phi(0) = V_L, phi(1) = V_H, and the offer tracks the type]

Hmm, not quite. Under separation:
- theta = 1: offer beta * V_H / N per W. H keeps V_H - n * beta * V_H / N = V_H(N - n*beta)/N.
- theta = 0: offer beta * V_L / N per W. H keeps V_L(N - n*beta)/N.

So V_H^{R1, sep}(C, theta) = V(theta) * (N - n*beta) / N = V(theta) * (1 + (1-beta)(N-1))/N.

Hmm, let me verify: N - n*beta = N - (N-1)*beta.

For beta -> 1: V(theta) * (N - N + 1)/N = V(theta)/N. (H gets 1/N of the pie, same as standard unanimity BF.)
For beta -> 0: V(theta). (H gets everything because rejection has no continuation value.)

This makes sense: as beta -> 1, the last-round reservation is almost as valuable as the current round, so H must offer close to the continuation value, which under random recognition and unanimity converges to V(theta)/N.

#### Sub-case (ii): W_j is recognized (prob (N-1)/N under Package C)

W_j proposes, not knowing V(theta). W_j must get all players to accept, including H.

**H's acceptance condition**: H accepts iff x_H >= beta * E_theta[V_H^{R2}(C, theta)] = beta * V_e(mu') / N (where mu' is the posterior after H's rejection --- but if H accepts, there's no update).

Wait, H knows theta. H accepts iff x_H >= beta * V(theta) / N (H's Round 2 continuation value conditional on the true theta).

This is the key: H's acceptance threshold depends on theta. If W_j offers x_H:
- H accepts under theta = 1 iff x_H >= beta * V_H / N.
- H accepts under theta = 0 iff x_H >= beta * V_L / N.

Since V_H > V_L: it's harder to satisfy H when theta = 1.

**W_j's problem (screening H)**:

W_j chooses x_H to offer H. Two options:
- **High offer**: x_H = beta * V_H / N. H accepts for sure (both types). W_j keeps V(theta) - x_H - (other shares). But W_j doesn't know V(theta)!
  
Actually, W_j must also satisfy other W's. Under unanimity, all must accept. Other W's accept x_{W_k} >= 0. So W_j can offer 0 to all other W's.

W_j's proposal: (x_H, 0, ..., 0, x_{W_j}, 0, ..., 0) with x_H + x_{W_j} <= V(theta).

**Conservative offer**: x_H = beta * V_H / N. Accepted by H regardless of theta. W_j gets V(theta) - beta * V_H / N.
- Under theta = 1: V_H - beta * V_H / N = V_H(1 - beta/N). Positive.
- Under theta = 0: V_L - beta * V_H / N. Positive iff V_L > beta * V_H / N, i.e., v < N/beta. This is likely to hold for moderate v.
- If V_L < beta * V_H / N: the conservative offer is infeasible under theta = 0 (W_j would need to offer more than the pie). Then W_j cannot guarantee H's acceptance under both states.

**Aggressive offer**: x_H = beta * V_L / N. Accepted by H only if theta = 0 (x_H >= beta * V_L / N trivially) or if theta = 1 (x_H = beta * V_L / N < beta * V_H / N --- H rejects!).

Wait: under theta = 1, H's reservation is beta * V_H / N. The offer of beta * V_L / N < beta * V_H / N. So H rejects. Under theta = 0, H's reservation is beta * V_L / N. The offer equals it. H accepts (indifferent, assume accepts).

So aggressive offer: passes iff theta = 0 (prob 1 - mu'). W_j gets V_L - beta * V_L / N = V_L(1 - beta/N) when it passes, 0 otherwise (goes to Round 2).

Expected payoff from aggressive offer: (1 - mu') * V_L * (1 - beta/N) + mu' * beta * phi(mu'')/N, where mu'' is the updated belief after H's rejection (which reveals theta = 1, so mu'' = 1).

Actually, if H rejects the aggressive offer, it's because theta = 1. W_j (and all players) learn theta = 1. In Round 2, mu' = 1. This matters.

After H rejects: mu'' = 1 (fully revealed). Round 2 with mu'' = 1:
- If W_j is recognized in R2 (prob 1/N): proposes aggressively (mu'' = 1 > mu_bar), gets V_H (takes whole pie since it's feasible). Expected: V_H.
- phi(1) = V_H. So W_j's R2 expected payoff = phi(1)/N = V_H/N.

So **aggressive offer** expected payoff for W_j:
= (1 - mu') * V_L(1 - beta/N) + mu' * beta * V_H / N

**Conservative offer** expected payoff for W_j:
= E_theta[V(theta) - beta * V_H / N] = V_e(mu') - beta * V_H / N
= mu' * V_H + (1 - mu') * V_L - beta * V_H / N
[This assumes conservative is feasible under both states, i.e., V_L >= beta * V_H / N.]

W_j prefers aggressive iff:
(1 - mu') * V_L(1 - beta/N) + mu' * beta * V_H / N > mu' * V_H + (1 - mu') * V_L - beta * V_H / N

Simplify:
(1 - mu') * V_L * (1 - beta/N) + mu' * beta * V_H / N > mu' * V_H + (1 - mu') * V_L - beta * V_H / N

Rearrange:
mu' * beta * V_H / N - mu' * V_H + beta * V_H / N > (1 - mu') * V_L * [1 - (1 - beta/N)]
= (1 - mu') * V_L * beta/N

Left side: beta * V_H / N * (mu' + 1) - mu' * V_H... let me redo this more carefully.

LHS - RHS of the inequality:
(1-mu')V_L(1-beta/N) + mu' beta V_H/N - mu'V_H - (1-mu')V_L + beta V_H/N

= (1-mu')V_L[(1-beta/N) - 1] + mu'[beta V_H/N - V_H] + beta V_H/N

= -(1-mu')V_L beta/N - mu' V_H(1 - beta/N) + beta V_H/N

= -(1-mu')V_L beta/N - mu' V_H + mu' beta V_H/N + beta V_H/N

= -(1-mu') V_L beta/N + (mu' + 1) beta V_H/N - mu' V_H

Hmm, this is getting algebraically messy. Let me define **shorthand**: let b = beta/N and write V_H = v, V_L = 1 (under our normalization).

Aggressive payoff: (1-mu')(1 - b) + mu' * b * v
Conservative payoff: mu' * v + (1 - mu') - b * v = mu' v + 1 - mu' - bv

Aggressive preferred iff:
(1-mu')(1-b) + mu' bv > mu'v + 1 - mu' - bv

LHS: 1 - mu' - b + mu'b + mu'bv
RHS: mu'v + 1 - mu' - bv

LHS - RHS: -b + mu'b + mu'bv - mu'v + bv
= -b + mu'b(1 + v) - mu'v + bv
= b(v - 1) + mu'[b(1+v) - v]
= b(v-1) + mu'[bv + b - v]
= b(v-1) - mu'[v - b(1+v)]
= b(v-1) - mu'[v(1-b) - b]

Set to zero:
mu'_screen = b(v-1) / [v(1-b) - b]

Denominator: v(1-b) - b = v - b(v+1) = v - (beta/N)(v+1).
For this to be positive (so that there's an interior threshold): v > (beta/N)(v+1), i.e., v(1 - beta/N) > beta/N, i.e., v > beta/(N - beta). Since v > 1 and beta < N (always), this holds for all reasonable parameters.

So: **W_j prefers aggressive iff mu' < mu'_screen**, where:

$$\mu'_{\text{screen}} = \frac{\frac{\beta}{N}(v-1)}{v\left(1 - \frac{\beta}{N}\right) - \frac{\beta}{N}} = \frac{\beta(v-1)}{Nv - \beta(v+1)} = \frac{\beta(v-1)}{v(N-\beta) - \beta}$$

This is the **screening threshold**: below it, W_j makes a low offer to H (risking rejection when theta = 1); above it, W_j makes a high offer (ensuring H's acceptance).

**Key structural feature**: the screening threshold mu'_screen creates a **discontinuity** in W_j's strategy as a function of beliefs. This is the source of non-linearity that makes BP valuable, exactly as in the outside-option model (Section 4 of `novo_caminho_outside_option.md`).

### 6.3. Overall Round 1 Continuation Values under Package C

Combining sub-cases (H proposes with prob 1/N, W_j proposes with prob (N-1)/N):

**H's expected Round 1 payoff under Package C** (assuming pooling when H proposes, and accounting for W_j's screening behavior):

This requires combining:
- Prob 1/N: H proposes. Payoff = V(theta) - n * beta * phi(mu) / N (pooling).
- Prob n/N: some W_j proposes. H's payoff depends on W_j's offer:
  - If mu < mu'_screen: W_j offers low (x_H = beta * V_L / N). H accepts if theta = 0 (gets beta V_L / N). H rejects if theta = 1 (goes to R2, gets beta * V_H / N).
    - So H gets beta * V(theta) / N regardless! (Under theta = 0: accepts, gets beta V_L / N from accepted proposal --- wait, actually H gets x_H = beta V_L/N from the proposal, not beta V_L / N from Round 2.)
    
Let me re-examine. If W_j offers aggressively (low to H): x_H = beta * V_L / N.
- theta = 0: H's reservation = beta * V_L / N. Offer = beta * V_L / N. H accepts. H gets beta * V_L / N. Payoff for this round (not discounted): beta * V_L / N.
  
Wait --- the offer and acceptance happen in Round 1. The payoff is x_H (not discounted by beta --- beta discounts Round 2). So if H accepts W_j's Round 1 proposal with x_H = beta V_L / N, H gets beta V_L / N in Round 1. If H rejects and goes to Round 2, H gets beta * V(theta)/N (Round 2 value, discounted by beta because it happens one period later).

Under theta = 0: accepting gives beta V_L / N; rejecting gives beta * V_L / N (since V(theta=0) = V_L). Indifferent. Assume accept.
Under theta = 1: accepting gives beta V_L / N; rejecting gives beta * V_H / N > beta * V_L / N. H rejects.

So when W_j offers aggressively:
- theta = 0: H accepts, gets beta V_L / N.
- theta = 1: H rejects, gets beta V_H / N (from Round 2).

H's payoff = beta V(theta) / N in both cases. Interesting.

If W_j offers conservatively (high to H): x_H = beta * V_H / N.
- Both types of H accept.
- H gets beta V_H / N regardless of theta.

So from H's perspective when W_j proposes:
- Aggressive offer: H gets beta * V(theta) / N.
- Conservative offer: H gets beta * V_H / N.

H prefers the conservative offer (gets more when theta = 0). But H doesn't choose the offer --- W_j does.

**H's Round 1 expected payoff under Package C** (full formula):

$$V_H^{R1}(C, \theta, \mu) = \frac{1}{N}\left[V(\theta) - \frac{n \beta \phi(\mu)}{N}\right] + \frac{n}{N} \cdot h_H(\theta, \mu)$$

where h_H(theta, mu) is H's expected payoff when a W proposes:
- If mu < mu'_screen: h_H(theta, mu) = beta V(theta) / N.
- If mu >= mu'_screen: h_H(theta, mu) = beta V_H / N.

---

## 7. Feeding into Stage 1: The BP Problem

### 7.1. Entry Threshold

W_i enters iff the expected payoff from participation (Stage 1 + Stage 2) exceeds the entry cost c:

E[V_{W_i}^{Stage 2}(R, mu) | mu] >= c

Under the current model, V_W is a constant (determined by R). With the 2-round BF extension, V_W depends on mu.

**Under Package A**: V_{W_i} = 0 (H takes everything). Threshold: 0 >= c. Never satisfied for c > 0. 

This is problematic: if W gets nothing under Package A, no one enters! We need to reconsider.

**Resolution**: The entry payoff has two components (as in the current model): theta (deal quality) + V_W(R, mu) (bargaining payoff) - c. The deal quality theta in {0, 1} is the primary benefit. So:

W enters iff: theta + V_W(R, mu) - c >= 0 in expectation, i.e., E[theta | s] + V_W(R, mu(s)) >= c.

Under Package A with V_W = 0: tau(A) = c. (Same as before but with V_W = 0 instead of the current model's V_W(M) = (q-1)/(N(N-1)).)

Under Package C: tau(C, mu) = c - V_W(C, mu). Since V_W depends on mu, the threshold itself depends on the signal. This creates a fixed-point problem: the signal determines mu, which determines tau, which determines whether entry occurs, which is what H is optimizing over.

### 7.2. H's BP Problem (Package C)

H chooses signal pi(s | theta) to maximize:

$$\mathbb{E}_s\left[\mathbf{1}\{\mu(s) \geq \tau(C, \mu(s))\} \cdot A(C, \mu(s))\right]$$

where:
- A(C, mu) = g(n) + V_H(C, mu): H's total benefit if institution forms with posterior mu.
- tau(C, mu) = c - V_W(C, mu): entry threshold at posterior mu.
- V_H(C, mu) and V_W(C, mu) come from the Round 1 equilibrium of the 2-round BF.

**Key difference from baseline**: both the "prize" A(C, mu) and the "threshold" tau(C, mu) now depend on mu, not just the threshold alone. The value function v(mu) = A(C, mu) * 1{mu >= tau(C, mu)} is no longer a simple step function.

### 7.3. H's BP Problem (Package A)

Under Package A (with V_W = 0 and V_H = V_e(mu)):

$$v_A(\mu) = [g(n) + V_e(\mu)] \cdot \mathbf{1}\{\mu \geq c\}$$

This is a step function in mu (jumps at mu = c) but the height also depends on mu (through V_e(mu)). The concavification is slightly different from the baseline.

Actually, V_e(mu) = mu V_H + (1-mu) V_L is linear in mu. So A(A, mu) = g(n) + mu V_H + (1-mu) V_L = g(n) + V_L + mu(V_H - V_L). This is affine in mu. The step function with affine height still has a concavification that can be computed in closed form.

### 7.4. Value Function Shape under Package C

V_W(C, mu) involves phi(mu), which has a kink at mu_bar = 1/v. And the screening threshold mu'_screen creates another potential kink. The value function v_C(mu) will have a more complex shape:

- For mu < mu_bar: phi(mu) = V_L. V_W is flat. tau(C) = c - V_L/N (constant). v_C(mu) = A(C, mu) * 1{mu >= c - V_L/N}.
- For mu >= mu_bar: phi(mu) = mu V_H. V_W = mu V_H / N. tau(C, mu) = c - mu V_H / N (decreasing in mu). v_C(mu) = A(C, mu) * 1{mu >= c - mu V_H / N}.

The entry condition mu >= c - mu V_H / N becomes mu(1 + V_H/N) >= c, i.e., mu >= c N / (N + V_H).

So for mu >= mu_bar, the threshold is mu >= c N / (N + V_H), which is a constant! The decreasing tau exactly offsets through the moving threshold.

This means the step-function structure is preserved, just with different thresholds in different regions:
- Region mu < mu_bar: threshold = c - V_L/N.
- Region mu >= mu_bar: threshold = cN/(N + V_H).

And A(C, mu) is piecewise-linear (with a kink at mu_bar from V_W's contribution).

The concavification of this function is analytically tractable for each region.

---

## 8. Closed-Form Feasibility Assessment

### N = 3, theta binary, d = 0

The model parameters are: V_L (normalized to 1), V_H = v > 1, beta in (0,1), p, c, lambda, alpha.

**Package A**: Closed form. V_H(A) = V_e(mu), V_W(A) = 0. Step function at mu = c.

**Package C**: Requires solving the Round 1 equilibrium with signaling (when H proposes) and screening (when W proposes). For N = 3:
- 1/3 chance H proposes. Pooling vs. separating depends on parameters.
- 2/3 chance a W proposes. Screening threshold mu'_screen is a known formula.

The Round 1 equilibrium under Package C involves:
1. W_j's screening threshold (closed form).
2. H's signaling equilibrium (pooling region characterized by a feasibility condition; separating when forced).
3. Combining these to get V_H(C, mu) and V_W(C, mu).

Each piece is closed form, but the overall V_W(C, mu) and V_H(C, mu) will be piecewise-defined functions with 2--3 regions. The concavification of the value function will have a small number of linear pieces.

**Assessment**: Closed-form solution is feasible for N = 3 with binary theta and d = 0. It will be piecewise-linear with a manageable number of cases. For general N, the structure is the same but with more complex recognition probabilities.

**Recommendation**: Derive closed-form for N = 3, then verify numerically. Extend to N = 5 numerically. General N should be characterizable qualitatively (comparative statics in N).

---

## 9. Expected Qualitative Results

### 9.1. What changes from the baseline

1. **Continuation values depend on mu under Package C.** This is the main structural change. V_W(C, mu) has a kink at mu_bar, creating a non-trivial interaction between the BP signal and the bargaining outcome.

2. **The value function v_C(mu) is no longer a simple step function.** It has a step (at the entry threshold) combined with a piecewise-linear payoff that depends on mu. The concavification is richer.

3. **Under Package A, H extracts the entire pie.** This sharpens the trade-off: Package A is maximal extraction but maximal skepticism (tau = c). Package C is moderate extraction but lower skepticism.

4. **Signaling in Round 1 under Package C.** When H proposes, H's offer reveals information about V(theta). Under pooling, H offers the same to both types, preserving the Stage 1 information structure. Under separating, the bargaining stage undoes the BP signal.

### 9.2. Main result: does the core trade-off survive?

**Yes, and it is strengthened.** The logic:

- Under Package A: H gets V(theta) (whole pie), but W gets 0, so tau(A) = c (very high). BP must overcome a high threshold. H's payoff: [g(n) + V_e(p/tau)] * p/c when p < c.

- Under Package C: H gets less from bargaining, but W gets V_W(C, mu) > 0, so tau(C) < c. The threshold is lower, BP is more effective. Additionally, W's payoff itself depends on mu through the screening mechanism, creating extra value from persuasion.

The **screening channel** under Package C is new: by manipulating mu upward, H not only induces entry but also softens W's bargaining stance (at higher mu, W proposers make conservative offers, giving H more). This is a second channel through which BP benefits H under consensus, absent under majority.

### 9.3. New results unique to this extension

1. **Screening channel**: BP under Package C has value not only through the entry margin but also through the bargaining margin. Higher mu makes W proposers less aggressive, benefiting H.

2. **Signaling constraint**: Under Package C when H proposes, there may be a tension between H's Stage 1 signal (manipulating mu upward) and H's Round 1 bargaining (where separation may occur, revealing theta). If separation undoes the BP signal, this limits the value of information design.

3. **Interaction between BP and BF**: The model generates genuine strategic interaction between information design (Stage 1) and bargaining (Stage 2). The optimal signal must account for how the posterior mu affects bargaining behavior, not just the entry decision.

---

## 10. Technical Challenges

### Challenge 1: Signaling in Round 1

When H proposes in Round 1 of Package C, H's proposal is a signal about V(theta). The equilibrium of this signaling game depends on beliefs (mu), and the beliefs come from Stage 1. This creates a double layer of information design.

**How to handle**: Solve for the set of pooling and separating equilibria as a function of mu. Characterize which equilibrium type prevails in each region of mu. The BP problem in Stage 1 then optimizes over the distribution of posteriors, taking the Round 1 equilibrium as given.

**Technical note**: There may be multiple PBE in the Round 1 signaling game. Use the D1 criterion (Cho & Kreps 1987) or the Intuitive Criterion to select. If the pooling equilibrium exists and is Pareto-dominant (both H-types prefer it), it is a natural selection.

### Challenge 2: Belief updating after rejection

If H rejects W_j's aggressive offer in Round 1, this reveals theta = 1. The Round 2 belief becomes mu'' = 1, which affects Round 2 play. This is already incorporated in the analysis above.

If H's Round 1 proposal is rejected (under Package C), the rejection might be informative. Under unanimity, any single player can reject. If a W rejects H's offer, this doesn't reveal theta (W doesn't know theta). So mu' = mu after W's rejection of H's offer.

### Challenge 3: Fixed-point in mu

The entry threshold tau(C, mu) depends on mu, and mu is the object of BP optimization. This creates a fixed-point structure: H chooses a distribution of posteriors, and each posterior mu affects both the entry decision and the bargaining payoff.

**How to handle**: The BP problem is still a concavification problem, but the value function v(mu) is more complex. Compute v(mu) = A(C, mu) * 1{mu >= tau(C, mu)} in closed form (piecewise). Then concavify. The concavification of a piecewise-linear function with a step is still analytically tractable.

### Challenge 4: Multiple equilibria in Round 1

The Round 1 bargaining game may have multiple equilibria (pooling vs. separating). Different equilibria give different continuation values, hence different value functions for the BP problem.

**How to handle**: Characterize the full set of equilibria. The qualitative result (Package C dominates for low p and high g) should hold across equilibrium selections. If not, report the result for each selection.

### Challenge 5: W's proposal feasibility

When W proposes in Round 1 and does not know V(theta), W may propose an infeasible allocation. The model needs a clean convention for what happens.

**Recommended convention**: W can only propose allocations that are feasible under V_L (the worst case). This is equivalent to assuming W knows a lower bound on V(theta). Under this convention, W's proposals are always feasible, and the screening problem is about how much to offer H (not about feasibility). This avoids the complication of infeasible proposals.

**Alternative**: W can propose any allocation. If sum(x) > V(theta), the proposal fails automatically. This is equivalent to the screening analysis above. Both conventions give the same equilibrium behavior.

---

## 11. Implementation Roadmap

### Phase 1: Round 2 Analysis (1 day)

1. Derive Round 2 continuation values for Package A and Package C as functions of mu'. Closed form.
2. Verify: at beta -> 0, Round 2 becomes irrelevant (single-round game). At beta -> 1, converges to standard BF.
3. Implement in R: function `compute_R2_cv(mu, N, v, beta, rule)` returning (V_H_R2, V_W_R2).

### Phase 2: Round 1 Equilibrium (2--3 days)

1. **Package A**: Trivial (H takes everything, W gets 0). Verify.
2. **Package C, W proposes**: Derive screening threshold mu'_screen. Derive W_j's optimal proposal as function of mu. Derive H's payoff. Closed form for N = 3.
3. **Package C, H proposes**: Characterize pooling equilibrium region. Derive pooling payoffs. Characterize separating/semi-separating region. Derive payoffs. Closed form for N = 3.
4. **Combine**: V_H(C, mu) and V_W(C, mu) as piecewise functions. Implement in R.
5. **Verify numerically**: Plot V_H, V_W as functions of mu for various (v, beta, N).

### Phase 3: BP Problem (1--2 days)

1. Compute value function v_A(mu) and v_C(mu) for the full model (entry + bargaining).
2. Concavify each. Closed form for N = 3 (piecewise linear, finite number of cases).
3. Compute optimal signal and H's payoff under each package.
4. Compare U_H*(A) vs U_H*(C) as function of p, v, beta, lambda, c.

### Phase 4: Results and Comparative Statics (1--2 days)

1. Derive condition for Package C to dominate. Closed form for N = 3.
2. Comparative statics in beta: how does the discount factor affect the trade-off?
3. Comparative statics in v = V_H / V_L: how does pie uncertainty affect the trade-off?
4. Numerical analysis for N = 5, 7.
5. Plots: (lambda, c) region, crossover prior p*, payoff comparison.

### Phase 5: Write-Up (2--3 days)

1. Formal definitions, lemmas, propositions.
2. Proofs (for N = 3, closed form; for general N, characterization).
3. Figures and numerical illustrations.
4. Connection to OMC narrative.

---

## 12. Key Modeling Decisions (to be confirmed by author)

1. **Disagreement payoff d = 0 vs d > 0.** Recommendation: d = 0 as baseline. If results are too extreme (H gets everything under A), consider d = E[V]/N.

2. **Package A proposer in Round 2.** If H is always proposer (both rounds), W gets 0. If Round 2 proposer is random, W has a chance. Recommendation: H always proposes (consistent with "agenda control" interpretation).

3. **Feasibility of W's proposals.** Convention: W proposes allocations that are feasible under V_L. Recommendation: adopt this for simplicity.

4. **Equilibrium selection in signaling game (Round 1, H proposes under Package C).** Recommendation: focus on pooling equilibrium when it exists (Pareto-dominant, natural focal point). Report separating/semi-separating when pooling fails.

5. **Number of rounds.** This plan uses 2 rounds. If 2 rounds with d = 0 gives knife-edge results under Package A, consider 3 rounds or infinite horizon. Recommendation: start with 2, check if results are interesting. The 2-round structure is already rich enough to generate the screening mechanism.

6. **Normalization.** V_L = 1, V_H = v > 1. Alternative: V_L = 0, V_H = 1 (but then theta = 0 means no pie, which is too extreme). Recommendation: V_L = 1 for cleaner algebra.

---

## 13. Comparison with Current Model

| Dimension | Current (single-round, known pie) | Extension (2-round BF, uncertain pie) |
|-----------|-----------------------------------|---------------------------------------|
| Stage 2 | Single-round, exogenous 1/N status quo | 2-round BF with beta discounting |
| H's info advantage in Stage 2 | None (pie size is common knowledge) | H knows V(theta), W has posterior mu |
| V_W(A) | (q-1)/(N(N-1)) > 0 | 0 (H takes everything) |
| V_W(C) | 1/N (constant) | phi(mu)/N (depends on mu) |
| tau(R) | Constant | Constant (A), piecewise function of mu (C) |
| BP value function | Step function | Step with piecewise-linear height |
| Screening channel | Absent | Present under Package C |
| Signaling in bargaining | Absent | Present when H proposes under C |
| Belief updating in play | Absent | H's accept/reject reveals theta |
| Number of parameters | {p, c, lambda, alpha, N} | + {v, beta} |
| Closed-form tractability | Full | Yes for N = 3, piecewise |
| Source of non-linearity | Exogenous (step at tau) | Endogenous (screening + entry) |

---

## 14. Risk Assessment

**High risk**: The signaling game in Round 1 (when H proposes under Package C) could generate multiplicity that makes the model intractable. **Mitigation**: If the signaling game is too complex, restrict to the pooling equilibrium (which is the natural case when v is not too large).

**Medium risk**: V_W(A) = 0 under Package A makes the entry threshold tau(A) = c, which may be too extreme. If p < c always, the institution never forms under A (without BP) and the comparison reduces to "anything is better than nothing." **Mitigation**: Use the current model's V_W(A) > 0 as a robustness check (interpret as "W gets some small benefit from majority inclusion"). Or introduce d > 0.

**Low risk**: The algebra for N = 3 could be messier than expected. **Mitigation**: Start with simulation to verify intuition, then do algebra.

**No risk**: The core trade-off (consensus lowers threshold, majority raises extraction) is structural and will survive any reasonable extension. The question is whether the new channels (screening, signaling) add genuine insight or just complexity.

---

## Appendix A: Notation Summary

| Symbol | Meaning |
|--------|---------|
| N | Total number of players |
| n = N - 1 | Number of weak states |
| theta in {0, 1} | State of the world (deal quality) |
| V_L, V_H | Pie size in state 0, 1 (V_L = 1, V_H = v) |
| v = V_H / V_L | Pie ratio (v > 1) |
| beta | Discount factor between rounds |
| mu | Posterior Pr(theta = 1 \| s) |
| mu_bar = 1/v | Screening threshold in Round 2 (W's aggressive vs conservative) |
| mu'_screen | Screening threshold in Round 1 (W's aggressive vs conservative) |
| mu_pool | Maximum mu at which H can pool in Round 1 |
| phi(mu) | W's Round 2 payoff function (V_L if mu < mu_bar, mu V_H if mu >= mu_bar) |
| q | Voting threshold (majority: ceil((N+1)/2), unanimity: N) |
| R in {A, C} | Package (A = majority + agenda, C = consensus) |
| tau(R, mu) | Entry threshold for W under package R at posterior mu |
| A(R, mu) | H's total benefit if institution forms |
| g(n) = lambda n^alpha | Complementarity value |
| p | Prior Pr(theta = 1) |
| c | Entry cost for weak states |
| d_i | Disagreement payoff (baseline: 0) |

## Appendix B: Literature on BF with Asymmetric Information

The extension connects to several literatures:

1. **Bargaining with incomplete information**: Fudenberg & Tirole (1983), Sobel & Takahashi (1983), Cramton (1984). These study bilateral bargaining where one side has private information. The 2-round BF generalizes to N players with one informed party.

2. **Legislative bargaining with private information**: Tsai & Yang (2003) study BF where legislators have private valuations. Eraslan & Merlo (2017) survey. Our model differs: the private information is about the pie size (common value), not individual valuations.

3. **Signaling in bargaining**: Admati & Perry (1987), Ausubel & Deneckere (1989). Delay in bargaining can signal private information. In our 2-round model, rejection is the only source of delay, and it reveals information when H rejects W's aggressive offer.

4. **Bayesian persuasion in bargaining**: Salamanca (2021), Lipnowski & Ravid (2020). These study information design when the designer is also a party to the bargaining. Our model adds the institutional design (choice of voting rule) layer.

5. **Veto bargaining with persuasion**: Kim, Kim & Van Weelden (2025, AJPS). Persuasion in the presence of veto players. Directly relevant to our Package C.
