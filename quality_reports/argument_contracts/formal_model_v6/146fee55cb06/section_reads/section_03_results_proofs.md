# Section read 03 — baseline results and proofs

## Reader record

- `reader_id`: `reader-results`
- Mode: read-only, descriptive argument extraction; no quality assessment and no manuscript edits.
- Contract profile: `formal`.
- Primary artifact: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.pdf`
- Primary artifact SHA-256: `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`
- Auxiliary editable source: `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion/formal_model_v6.Rmd`
- Auxiliary source SHA-256: `ec9f281efb5e28c4e0b3c1c0c2756a2684aa85f0670e5ce42544ec886c3f0a97`
- Assigned coverage:
  - S05, “Results,” PDF pp. 11–23;
  - S12, “Appendix B: Proofs,” PDF pp. 36–40;
  - S13, “Appendix C: Endpoints, exact sets, and illustration,” PDF pp. 40–42.
- Cross-reference coverage: the complete 66-page PDF was read to resolve definitions, scope restrictions, notation, and forward/backward references. Claims reported below remain exclusive to S05, S12, and S13.
- Visual verification: assigned PDF pages were rendered and inspected in addition to full-document text extraction. Equations and boundary conventions were cross-checked against the hash-matched Rmd.

## Section thesis

In the no-agenda baseline, denoted by superscript (B), the public-type games isolate the payoff value of making the hegemon's approval necessary when its disagreement payoff is known. The private games then add screening, pooling, and exclusion. Majority can replace the hegemon with weak-state votes; unanimity cannot. The paper therefore separates: (i) public pivotality effects; (ii) private-game institutional payoff contrasts; and (iii) type-contingent informational rents obtained by subtracting each rule's public benchmark from its private correspondence. Every comparison preserves the low/high-type vector, equilibrium multiplicity, endpoint support, and empty pure-strategy cells.

This thesis is stated at PDF pp. 11, 17–23 and proved at pp. 36–40; Rmd lines 442–448, 676–731, and 1513–1549.

## Governing domain inherited from the model

All propositions below inherit the baseline domain unless a narrower cell is stated:

- one hegemon (H) and (m\ge 3) weak states;
- two rounds; only weak states propose, uniformly and with replacement;
- type (o\in\{\ell,h\}), with (0<\ell<h<1), observed only by (H) in the private games;
- prior (p=\Pr(o=h)\in[0,1]);
- discount factor (\beta\in(0,1));
- fixed unit pie, nonnegative allocations, no intrinsic agreement benefit for (H);
- majority or unanimity with simultaneous public ballots;
- perfect Bayesian equilibrium with pure ballot strategies and the declared belief, as-if-pivotal voting, indifference-to-yes, and proposal tie-break disciplines.

Primary definition locator: PDF pp. 8–11, especially Table 3 at p. 11. These definitions are outside the assigned reporting unit but are necessary conditions for every S05 claim.

## Separation of the four result layers

| Layer | Formal object | What it asks | Assigned locator |
|---|---|---|---|
| Public benchmark | (v_g^B(o)) | What does a known type receive under rule (g\in\{M,U\})? | Proposition 5.1, PDF pp. 12–13; proof p. 36 |
| Private games | (V_g^B=(V_g^B(\ell),V_g^B(h))) | What linked type-payoff vector/correspondence arises when only (H) knows its type? | Propositions 5.2–5.4, PDF pp. 13–16; proofs pp. 36–39 |
| Private institutional contrast | (V_U^B-V_M^B) | At the same parameter point, what is unanimity minus majority when both private games exist? | Proposition 5.5, PDF pp. 17–19; proof pp. 39–40 |
| Informational rents and their institutional contrast | (IR_g^B=V_g^B-v_g^B); (\Delta IR^B=IR_U^B-IR_M^B) | What does private information add within each rule, and how does that increment differ across rules? | Propositions 5.6–5.7, PDF pp. 19–23; proof p. 40 |

The paper does not treat these as interchangeable objects. In particular, a private payoff advantage is not automatically an informational-rent advantage, and (\Delta IR^B) is a difference of differences rather than the direct institutional contrast.

## Proposition-by-proposition extraction

### Proposition 5.1 — Public-type benchmark

**Claim.** Fix a public disagreement payoff (o).

- Terminal majority passes without (H), sets (x_H=0), pays responding weak states zero, gives the weak proposer the unit pie, and leaves (H) with (o).
- Terminal unanimity passes with (x_H=o), leaving the weak proposer (1-o).
- Round-1 unanimity passes immediately with (x_H=\beta o).
- Round-1 majority includes (H) when (o\le 1/m) and excludes it when (o>1/m). Inclusion is selected at (o=1/m).
- Hence
  \[
  v_M^B(o)=
  \begin{cases}
  \beta o,&o\le 1/m,\\
  o,&o>1/m,
  \end{cases}
  \qquad
  v_U^B(o)=\beta o.
  \]

**Conditions and domain.** Public type; baseline domain above. The equality case uses (\beta<1) and the proposer tie-break minimizing (H)'s expected payoff.

**Type and force.** Exact complete-information equilibrium outcome/payoff characterization, with an explicit boundary selection.

**Proof/evidence.** Terminal majority can pass with nonnegative zero payments to (k\le m) weak votes; a nonpivotal (H) strictly chooses no, and any positive (x_H) can be shifted to the proposer. Terminal unanimity must pay (H)'s threshold (o). In Round 1, a weak vote costs (w=\beta/m); inclusion costs ((k-1)w+\beta o), exclusion costs (kw), so inclusion is weakly cheaper iff (o\le1/m). At equality, inclusion pays (H) (\beta o<o), so the proposal tie-break selects it.

**Mechanism.** Public pivotality/substitution: majority prices one substitute weak-state vote against (H)'s vote; unanimity has no substitute.

**Comparative-static content explicitly supported.** The public majority outcome switches discretely at (o=1/m). No derivative comparative statics in (m) or (\beta) are asserted in S05/S12.

**Localizers.** Proposition and Table 4: PDF pp. 12–13; proof B.1: p. 36. Rmd lines 450–505 and 1351–1374.

### Proposition 5.2 — Private terminal games

**Claim.** Let
\[
p^*=\frac{h-\ell}{1-\ell}.
\]

- Under terminal majority, the unique equilibrium outcome is exclusion of (H): (x_H=0), no responding weak-state payments, full pie to the proposer, (H) receives (o), and a weak state receives (1/m) before recognition. The prior does not enter the proposer's choice.
- Under terminal unanimity, the proposer offers (x_H=\ell) for (p\le p^*). The low type accepts and the high type rejects, so passage occurs with probability (1-p).
- For (p>p^*), the proposer offers (x_H=h) and both types accept.
- At (p=p^*), the low offer is selected.

**Conditions and domain.** Private type, terminal round, baseline domain. Because this is terminal, no (\beta) appears in the cutoff.

**Type and force.** Exact terminal equilibrium-outcome characterization; uniqueness is claimed for the majority outcome, and the unanimity offer is selected by the proposal tie-break.

**Proof/evidence.** Under unanimity, any accepted offer can be reduced to the minimum threshold for its acceptance set. The only nonempty acceptance sets are low type only ((x_H=\ell)) and both types ((x_H=h)). The proposer compares ((1-p)(1-\ell)) with (1-h); equality gives (p=p^*), and the low offer minimizes (H)'s expected payoff at the tie.

**Mechanism.** Terminal screening versus pooling when approval is indispensable; belief irrelevance when majority can bypass (H).

**Comparative-static content explicitly supported.** As (p) crosses (p^*), terminal unanimity switches from a low offer/screening outcome to a high offer/pooling outcome. The manuscript states the cutoff formula but does not state derivative comparative statics of (p^*) with respect to (h) or (\ell).

**Endpoints.** (p=0) lies in the low-offer cell; (p=1) lies in the pooling cell. Appendix C later establishes that endpoints are literal complete-information games rather than limits.

**Localizers.** Proposition 5.2: PDF pp. 13–14; proof B.2: p. 36. Rmd lines 507–532 and 1376–1391.

### Proposition 5.3 — Private majority correspondence in Round 1

**Primitive payoff classes.** With (w=\beta/m):
\[
\Pi_E=1-kw,
\quad
\Pi_S(p)=(1-p)[1-(k-1)w-\beta\ell]+pw,
\quad
\Pi_P=1-(k-1)w-\beta h.
\]

- Exclusion (E): buy (k) weak responders at (w), set (x_H=0).
- Screening (S): buy (k-1) weak responders and offer (\beta\ell); low accepts, high delays.
- Pooling (P): buy (k-1) weak responders and offer (\beta h); both types accept.
- Deliberate delay is never selected because exclusion beats it by (1-\beta(k+1)/m>0).

**Exact claim.** For (m\ge3):

1. If (h<1/m), screening is selected for (p\le p_{S=P}), pooling above it, where
   \[
   p_{S=P}=\frac{\beta(h-\ell)}{1-\beta\ell-\beta k/m}.
   \]
2. If (\ell<1/m<h), screening is selected for (p\le p_{S=E}), exclusion above it, where
   \[
   p_{S=E}=\frac{\beta(1/m-\ell)}{\beta(1/m-\ell)+1-\beta(k+1)/m}.
   \]
3. If (1/m<\ell<h), exclusion is selected for every (p).
4. If (\ell=1/m<h), screening is selected at (p=0), exclusion for (p>0).
5. If (\ell<h=1/m), screening is selected through (p_{S=E}). Above it:
   - exclusion is selected if ((1-p)\ell+ph<\beta h);
   - pooling is selected if the inequality is reversed;
   - if equality holds, the entire proposal segment connecting exclusion and pooling survives.

At every cutoff involving screening, screening is selected.

**Conditions and domain.** Private type, Round 1 under majority, (m\ge3), baseline domain. Each cutoff is defined only under its stated outside-option condition.

**Type and force.** Exact equilibrium outcome-class correspondence, not uniqueness of named strategies. It includes explicit tie-breaking and multiplicity.

**Proof/evidence.** A weak responder accepts iff (x_j\ge w). With (n_Y\ge k), (H) is bypassed; with (n_Y=k-1), (H) is pivotal and accepts iff (x_H\ge\beta o); with (n_Y\le k-2), the proposal fails regardless of (H). Cost minimization reduces all candidates to (E,S,P), plus dominated delay. The decisive differences are
\[
\Pi_P-\Pi_E=\beta(1/m-h)
\]
and
\[
\Pi_S(p)-\Pi_E=(1-p)\beta(1/m-\ell)-p[1-\beta(k+1)/m].
\]
Their signs and the (S)-versus-(P) comparison generate the five parameter cases.

**Mechanism.** Majority caps (H)'s price by allowing the proposer to buy a substitute weak-state vote. Private information matters only when buying (H) through screening/pooling competes with exclusion.

**Correspondence and multiplicity.**

- Permuting identically paid weak responders creates additional equilibria without changing (H)'s payoff vector or the outcome class.
- Label-specific weak-state payoffs may be permuted.
- At the residual (h=1/m) equality, the proposal family is genuinely set-valued. A common proposal weight (\lambda) binds every payoff and outcome component; marginal extrema cannot be freely recombined.
- Majority has no empty cell in this baseline classification.

**Comparative-static content explicitly supported.** The proposition supplies threshold/cell changes in (p) and in the positions of (\ell,h) relative to (1/m). It does not assert smooth monotonic effects of (m), (\beta), (\ell), or (h) beyond these exact formulas and sign comparisons.

**Localizers.** Proposition 5.3 and discussion: PDF pp. 14–16; proof B.3: pp. 37–38. Rmd lines 534–592 and 1393–1433.

### Proposition 5.4 — Private unanimity correspondence in Round 1

Define
\[
w_\ell^U=\frac{\beta(1-\ell)}m,
\qquad
w_h^U=\frac{\beta(1-h)}m.
\]

**Exact claim.** Under unanimity:

- (p=0): immediate low-type agreement with (x_H=\beta\ell), each responding weak state paid (w_\ell^U), and proposer residual (w_\ell^U+1-\beta). The linked payoff vector for (H), ordered low/high, is ((\beta\ell,\beta h)).
- (0<p\le p^*): no PBE in pure ballot strategies.
- (p^*<p\le1): immediate pooling agreement with (x_H=\beta h), each responding weak state paid (w_h^U), and proposer residual (w_h^U+1-\beta). The linked payoff vector is ((\beta h,\beta h)).

**Conditions and domain.** Private type, Round 1 under unanimity, baseline domain, pure ballot strategies and declared belief/voting disciplines. The empty cell includes the boundary (p=p^*), while (p=0) is a separate support-preserving endpoint.

**Type and force.** Exact equilibrium correspondence on the maintained pure-ballot domain, including an exact nonexistence result in the middle cell. It is not a claim about mixed ballot strategies.

**Existence proof/evidence.** The continuation payoff of a weak state at posterior (\mu) is
\[
W(\mu)=
\begin{cases}
(1-\mu)w_\ell^U,&\mu\le p^*,\\
w_h^U,&\mu>p^*.
\end{cases}
\]
Thus (x_j=w_\ell^U) forces every weak responder to accept under any admissible posterior. At (p=0), support preservation fixes posterior zero; at (p>p^*), the continuation pools. In both existence regions, the stated proposal beats delay by (1-\beta). Appendix B enumerates response completions after arbitrary proposals to establish sequential rationality throughout those domains.

**Nonexistence proof/evidence.** For (0<p\le p^*), consider the feasible proposal (s^\dagger) paying (H) (\beta\ell) and every weak responder (w_\ell^U). All weak responders must vote yes. None of the four pure low/high voting profiles for (H) survives:

1. ((Y,Y)): high type deviates to no and obtains (\beta h>\beta\ell).
2. ((N,N)): low type is indifferent under no, so indifference-to-yes requires yes.
3. ((Y,N)): low type imitates high type's no and obtains the high-type continuation (\beta h).
4. ((N,Y)): high type can imitate low type's no and obtain (\beta h); strict no for the low type cannot be supported against yes at the offer.

A PBE must specify a valid pure response after every feasible proposal, so failure at (s^\dagger) implies no pure-ballot PBE in the cell.

**Mechanism.** Unanimity makes every weak vote and (H)'s approval necessary. The continuation induced by (H)'s observed ballot interacts with support-preserving beliefs and indifference-to-yes; in the intermediate prior cell this defeats every pure type-contingent voting profile.

**Endpoints and emptiness.** The discontinuity between (p=0) and any positive (p\le p^*) is attributed to support preservation: the impossible high type cannot be resurrected at (p=0), while both types are possible for every (p>0). Empty means no maintained pure-ballot PBE, not zero payoff.

**Explicit non-claim.** The paper does not derive, characterize, select, or compare mixed-ballot equilibria and makes no existence claim for them.

**Localizers.** Proposition 5.4, remark, and Table 5: PDF pp. 15–16; proof B.4: pp. 38–39. Rmd lines 594–664 and 1435–1511.

### Proposition 5.5 — Private institutional payoff contrast

**Object.** (V_U^B-V_M^B), ordered low type/high type, evaluated at the same parameter point and only where both private games have a maintained pure-strategy equilibrium.

**Exact claim.**

- At (p=0): ((0,0)) if majority screens; ((-(1-\beta)\ell,-(1-\beta)h)) if majority excludes.
- For (0<p\le p^*): the contrast is empty because private unanimity is empty.
- For (p>p^*):
  - majority screens: ((\beta(h-\ell),0));
  - majority pools: ((0,0));
  - majority excludes: ((\beta h-\ell,-(1-\beta)h)).
- On the residual exclusion–pooling segment at (h=1/m), the exact attainable set is
  \[
  \{\lambda(\beta h-\ell,-(1-\beta)h):\lambda\in[0,1]\},
  \]
  restricted to proposal weights that survive the tie-break; the same (\lambda) binds payoffs and outcomes.

**Conditions and domain.** Shared primitives and same parameter point; source correspondences must both be nonempty. The vector is type-contingent and is not prior-weighted.

**Type and force.** Exact institutional payoff contrast, set-valued on the residual segment and empty when a source is empty. It is explicitly not a universal ranking.

**Proof/evidence.** Subtract the majority vectors
\[
V_M^{B,S}=(\beta\ell,\beta h),\quad
V_M^{B,P}=(\beta h,\beta h),\quad
V_M^{B,E}=(\ell,h)
\]
from the unanimity vectors ((\beta\ell,\beta h)) at (p=0), (\varnothing) for (0<p\le p^*), and ((\beta h,\beta h)) for (p>p^*). Affine subtraction preserves the common proposal weight on a segment.

**Mechanism/sign content.** Timing wedges ((1-\beta)\ell) and ((1-\beta)h) compare current disagreement under exclusion with discounted inclusion thresholds. The low-type exclusion comparison depends on the cross-date term (\beta h-\ell). The proposition says unanimity has no unconditional payoff effect.

**Localizers.** Proposition 5.5 and Figure 3: PDF pp. 17–19; proof B.5: pp. 39–40. Rmd lines 676–715 and 1513–1525.

### Proposition 5.6 — Informational rents by voting rule

**Object.** For each (g\in\{M,U\}),
\[
IR_g^B=V_g^B-v_g^B,
\]
where the public benchmark is evaluated at the same type and same remaining parameters.

The public regions are:

- both types included if (h\le1/m);
- low included and high excluded if (\ell\le1/m<h);
- both types excluded if (1/m<\ell).

**Exact unanimity claim.**
\[
IR_U^B=
\begin{cases}
\{(0,0)\},&p=0,\\
\varnothing,&0<p\le p^*,\\
\{(\beta(h-\ell),0)\},&p>p^*.
\end{cases}
\]

**Exact majority claim.**

| Public region | Private class | (IR_M^B), low/high |
|---|---|---|
| Both types included | Screening | ((0,0)) |
| Both types included | Pooling | ((\beta(h-\ell),0)) |
| Both types included | Exclusion | (((1-\beta)\ell,(1-\beta)h)) |
| Low included, high excluded | Screening | ((0,-(1-\beta)h)) |
| Low included, high excluded | Exclusion | (((1-\beta)\ell,0)) |
| Both types excluded | Exclusion | ((0,0)) |

At (h=1/m), the residual exclusion–pooling set is
\[
\left\{
\lambda((1-\beta)\ell,(1-\beta)h)
+(1-\lambda)(\beta(h-\ell),0):\lambda\in[0,1]
\right\},
\]
restricted to the surviving proposal segment.

**Conditions and domain.** The private and public games are compared type by type under the same rule and primitives. Empty source correspondences propagate emptiness.

**Type and force.** Exact type-contingent informational-rent correspondences. Negative, zero, and positive components are all possible under majority; under high-prior unanimity, only the low type receives the pooling increment.

**Proof/evidence.** Componentwise subtraction of Proposition 5.1's public vectors from the private vectors in Propositions 5.3–5.4. The unanimity high-prior result follows because private pooling pays both types (\beta h), while the public vector is ((\beta\ell,\beta h)).

**Mechanism.** Informational rent is not the price of a necessary vote itself. It is the private-minus-public increment. Under unanimity, pooling gives the low type the high threshold. Under majority, rent appears only when the private class changes public inclusion or changes a type's price.

**Localizers.** Definition and Proposition 5.6: PDF pp. 19–21; proof B.6: p. 40. Rmd lines 717–770 and 1527–1537.

### Proposition 5.7 — Institutional informational-rent contrast

**Object.**
\[
\Delta IR^B=IR_U^B-IR_M^B,
\]
always oriented unanimity minus majority and preserving the low/high vector.

**Exact endpoint claim at (p=0).**

- Both types publicly included: ((0,0)).
- Low publicly included, high excluded: ((0,(1-\beta)h)); the high-type coordinate is off support but retained.
- Both types publicly excluded: ((0,0)).

**Exact empty-cell claim.** For (0<p\le p^*), (\Delta IR^B=\varnothing).

**Exact high-prior claim for (p>p^*).**

| Public region | Private majority class | (\Delta IR^B), low/high |
|---|---|---|
| Both types included | Screening | ((\beta(h-\ell),0)) |
| Both types included | Pooling | ((0,0)) |
| Both types included | Exclusion | ((\beta h-\ell,-(1-\beta)h)) |
| Low included, high excluded | Screening | ((\beta(h-\ell),(1-\beta)h)) |
| Low included, high excluded | Exclusion | ((\beta h-\ell,0)) |
| Both types excluded | Exclusion | ((\beta(h-\ell),0)) |

On the residual segment, the exact attainable set is
\[
\{\lambda(\beta h-\ell,-(1-\beta)h):\lambda\in[0,1]\}
\]
over the surviving proposal weights.

**Conditions and domain.** Both rent sources must exist. All comparisons use the same primitives and type coordinate. The off-support endpoint coordinate is retained as part of the linked type-contingent vector.

**Type and force.** Exact difference-of-differences correspondence, not a scalar average and not a universal institutional ranking.

**Proof/evidence.** Subtract the exact (IR_M^B) cells from (IR_U^B). Empty remains empty. Affine subtraction on the residual family yields a one-dimensional linked segment rather than a Cartesian product.

**Explicit sign classification.**

- Above (p^*), if majority screens, the low-type component is (\beta(h-\ell)>0), because unanimity pools.
- If majority excludes, the low-type component (\beta h-\ell) is positive, zero, or negative according as (\beta h\) is above, equal to, or below (\ell).
- The high type gains ((1-\beta)h) only when private majority screens while public majority excludes it.
- The high type loses ((1-\beta)h) when public majority includes it but private majority excludes it.
- When both private rules pool, (\Delta IR^B=(0,0)).

**Localizers.** Proposition 5.7, Table 6, sign discussion, and Figure 4: PDF pp. 20–23; proof B.6: p. 40. Rmd lines 772–865 and 1539–1549.

## Claims specific to Appendix C

### C.1 Endpoint equivalence

**Claim.** At (p=0), posterior support is the singleton low type; at (p=1), it is the singleton high type. Private unanimity coincides with the corresponding public-type game at each endpoint. Applying the relevant private majority class likewise reproduces public inclusion or exclusion, including the (o=1/m) tie-break. Endpoints are literal complete-information games, not one-sided limits.

**Type and force.** Exact endpoint interpretation that governs all proposition vectors and off-support coordinates.

**Localizers.** PDF pp. 40–41; Rmd lines 1553–1562.

### C.2 Exact segments, envelopes, and empty cells

**Claim.** Most cells are singleton payoff vectors. At (h=1/m), exact exclusion–pooling indifference can yield a proposal segment. If (\lambda) is the exclusion weight, the same (\lambda) indexes every reported coordinate. Componentwise lower/upper envelopes summarize marginal ranges only; their Cartesian product is not attainable.

For the majority informational-rent segment:
\[
IR_M^B(\ell)\in
[\min\{(1-\beta)\ell,\beta(h-\ell)\},
 \max\{(1-\beta)\ell,\beta(h-\ell)\}],
\]
\[
IR_M^B(h)\in[0,(1-\beta)h].
\]

For both (V_U^B-V_M^B) and (\Delta IR^B):
\[
\text{low type}\in[\min\{0,\beta h-\ell\},\max\{0,\beta h-\ell\}],
\qquad
\text{high type}\in[-(1-\beta)h,0].
\]

These intervals are marginal envelopes of one line segment.

For (0<p\le p^*), (V_U^B), (IR_U^B), and (\Delta IR^B) are empty. No payoff, sign, institutional ranking, or interpolation is assigned.

**Type and force.** Exact set-geometry and missing-source propagation rules.

**Localizers.** PDF p. 41; Rmd lines 1564–1592.

### C.3 Worked numerical values

**Claim.** For (m=4), (k=2), (\beta=0.9), (\ell=0.10), (h=0.35):

- (p^*=0.2778);
- (p_{S=E}=0.2935);
- at (p=0.80), majority excludes and unanimity pools;
- public payoff vectors: (v_M^B=(0.09,0.35)), (v_U^B=(0.09,0.315));
- private payoff vectors: (V_M^B=(0.10,0.35)), (V_U^B=(0.315,0.315));
- rents: (IR_M^B=(0.01,0)), (IR_U^B=(0.225,0)), (\Delta IR^B=(0.215,0)).

**Type and force.** Worked theoretical illustration of one exact parameter point. It is explicitly not an empirical calibration, parameter average, or estimate of a real institution.

**Localizers.** PDF pp. 41–42; Rmd lines 1594–1621. Figure 4 at PDF p. 23 displays the same decomposition.

## Mechanism map

| Mechanism | Formal operation | Result supported in assigned sections |
|---|---|---|
| Substitute coalition under majority | Compare the price of (H)'s vote with one additional weak vote | Public threshold (o=1/m); private (E/S/P) correspondence |
| Essential input under unanimity | Every approval is required; (H)'s threshold cannot be bypassed | Terminal screening/pooling cutoff (p^*); Round-1 pooling or empty pure-strategy cell |
| Dynamic continuation | Round-2 values are multiplied by (\beta) in Round-1 units | Inclusion prices (\beta o); timing wedges ((1-\beta)o) |
| Support-preserving endpoint beliefs | A zero-prior type cannot receive posterior mass | (p=0) is an isolated complete-information endpoint rather than the limit of the middle cell |
| Pure-vote response failure | The feasible (s^\dagger) forces weak yes votes, then defeats all four pure type profiles for (H) | No pure-ballot PBE for (0<p\le p^*) under unanimity |
| Informational rent | Subtract same-rule, same-type public payoff from private payoff | (IR_g^B=V_g^B-v_g^B) |
| Institutional informational-rent contrast | Subtract majority rent from unanimity rent | (\Delta IR^B=IR_U^B-IR_M^B), with type-specific signs and empty cells |

## Comparative statics and sign statements actually made

1. Terminal unanimity changes from screening to pooling as (p) passes (p^*); the low offer is selected at equality.
2. Round-1 majority changes among screening, pooling, and exclusion as (p) passes (p_{S=P}) or (p_{S=E}), conditional on the location of (\ell,h) relative to (1/m).
3. Round-1 unanimity has immediate low-type agreement only at (p=0), no pure-ballot PBE for (0<p\le p^*), and pooling for (p>p^*).
4. The low-type high-prior (\Delta IR^B) under majority exclusion changes sign with (\beta h-\ell).
5. High-type (\Delta IR^B) changes only when private and public majority treatment differ, as classified in Proposition 5.7.
6. Both-private-pooling produces zero institutional informational-rent contrast.
7. No continuous derivative comparative statics beyond these cutoff/sign classifications are explicitly asserted in S05/S12/S13; in particular, I did not find explicit derivative claims for (p^*), (p_{S=P}), or (p_{S=E}).

## Correspondences, multiplicity, endpoints, and empty cells

### Linked objects

- Every payoff vector is ordered low type/high type.
- Prior-weighted ex ante averaging is not performed in S05's central comparisons.
- A proposal segment is one linked object. The same (\lambda) binds type payoffs, weak-state payoffs where relevant, and outcomes.
- Marginal envelopes are descriptive projections; they do not authorize coordinate splicing.

### Multiplicity

- Majority permits identity multiplicity from permuting which symmetric weak responders are paid.
- (H)'s payoff vector and outcome class are invariant to those permutations.
- At (h=1/m), exact exclusion–pooling indifference can create genuine proposal-family multiplicity.
- The formulas displaying (\lambda\in[0,1]) remain restricted by the proposal tie-break; the full segment survives only in the exact equality cell stated in Proposition 5.3.

### Endpoints and boundaries

- (o=1/m): public Round-1 majority includes (H).
- (p=p^*): terminal unanimity selects the low offer; Round-1 private unanimity nevertheless belongs to the empty cell.
- Screening is selected at every majority cutoff involving screening.
- (p=0) and (p=1) are literal complete-information endpoint games, not limiting values from adjacent interior cells.
- Off-support type coordinates remain in the type-contingent vector when reported, most explicitly in Proposition 5.7 at (p=0).

### Empty cells

- Private Round-1 unanimity: empty for (0<p\le p^*) within pure ballot strategies.
- Consequently, (V_U^B-V_M^B), (IR_U^B), and (\Delta IR^B) are empty there.
- Empty does not mean zero, `NA`, an interpolated payoff, or a statement about mixed-strategy equilibria.

## Explicit non-claims and boundaries

1. The results do not establish a single unconditional payoff advantage of unanimity over majority.
2. They do not claim that private information always benefits the hegemon or either type.
3. They do not average low- and high-type components before comparison.
4. They do not fill the unanimity middle cell by interpolation or assign it a sign/ranking.
5. They do not derive, characterize, select, or compare mixed-ballot equilibria.
6. They do not claim existence or nonexistence under mixed ballot strategies.
7. They do not convert marginal envelopes into an attainable rectangle.
8. They do not select a member of the residual correspondence beyond the declared tie-break.
9. They do not treat the worked numbers as empirical calibration or estimation.
10. They do not establish agenda-power results; those belong to S06 and Appendices E–F and must remain separate from the baseline superscript-(B) claims here.
11. They do not identify a causal effect in observed institutions; the results are equilibrium comparisons inside the specified model.
12. They do not extend to (m<3), (\beta=1), more than two types, or more than two rounds.

## Terminology that must remain consistent

- `public-type benchmark` / complete-information benchmark: (v_g^B(o)).
- `private correspondence`: (V_g^B), preserving linked low/high coordinates.
- `screening`: low type accepts and high type delays/rejects at the relevant stage.
- `pooling`: both types accept the high-threshold offer.
- `exclusion`: majority passes without (H), with equilibrium (x_H=0).
- `deliberate delay`: a proposal chosen to fail; it is dominated in baseline private Round-1 majority.
- `informational rent`: (IR_g^B=V_g^B-v_g^B), same rule and same type.
- `institutional informational-rent contrast`: (\Delta IR^B=IR_U^B-IR_M^B), unanimity minus majority.
- `private institutional payoff contrast`: (V_U^B-V_M^B); it is not (\Delta IR^B).
- `essential input`: an approval with no substitute under unanimity.
- `substitute coalition`: the weak-state coalition that permits majority to bypass (H).
- `pure ballot strategies`: the maintained strategy domain for the nonexistence result.
- `support preservation`: endpoint posteriors cannot resurrect a zero-prior type.
- `indifference-to-yes`: the ballot convention used in all boundary arguments.
- `proposal tie-break`: among proposer payoff ties, select the proposal minimizing (H)'s expected payoff.
- `linked segment` / `common proposal weight`: the same (\lambda) indexes all components.
- `empty correspondence`: absence of a maintained pure-PBE source, never zero.
- `marginal envelope`: coordinate projection of a linked segment, not an attainable Cartesian product.
- Preserve the common contrast orientation `unanimity minus majority`.

## Ambiguities

### Remaining real ambiguities

Não encontrei ambiguidade interpretativa não resolvida em S05, S12 ou S13 depois de ler as referências cruzadas no PDF completo.

### Phrases that require careful macro encoding but are resolved by the text

1. (V_g^B), (IR_g^B), and (\Delta IR^B) are sometimes displayed as vectors and elsewhere described as correspondences. This is resolved by treating singleton vectors as singleton sets and preserving the residual segment/empty cells.
2. The (p=0) low/high vector contains an off-support high-type coordinate. Proposition 5.7 and Appendix C resolve this: retain the coordinate, while recognizing that the endpoint's realized support is the low type only.
3. Displays write (\lambda\in[0,1]) and then restrict to weights surviving the proposal tie-break. Proposition 5.3 resolves the domain: the entire segment survives only at the exact exclusion–pooling equality; otherwise the tie-break selects the relevant endpoint/class.
4. `Unique equilibrium outcome` in Proposition 5.2 is an outcome claim, not a blanket claim of unique complete strategies at every off-path history.

## Questions for the macro reader

1. Will the formal contract encode every vector-valued baseline object as a correspondence with explicit singleton, linked-segment, and empty-set cases, rather than as an ordinary scalar/vector function?
2. Will the contract preserve the distinction between (V_U^B-V_M^B) and (\Delta IR^B), including their different economic meanings despite coinciding formulas in some cells?
3. Will the JSON schema keep public outside-option regions (`both types included`, `low included/high excluded`, `both types excluded`) separate from private outcome classes (`screening`, `pooling`, `exclusion`)? Both indices are required to reconstruct Propositions 5.6–5.7.
4. Will the endpoint representation retain off-support type coordinates while marking (p=0) and (p=1) as literal support-preserving complete-information games?
5. Will the residual (h=1/m) family be represented with one common (\lambda) and its tie-break domain, preventing the low/high envelopes from being combined independently?
6. Will every downstream institutional comparison be marked undefined/empty for (0<p\le p^*), rather than zero or missing-at-random?
7. Will the contract keep the no-agenda superscript-(B) results here separate from the agenda-stage superscript-(A) extension, especially when later defining direct and informational effects?
8. Will the nonexistence claim be quoted with its full scope: PBE in pure ballot strategies under the declared belief and voting disciplines, with no claim about mixed ballot strategies?

## Compact claim/evidence index

| Claim ID | Claim | Scope/hedge | Evidence | Locator |
|---|---|---|---|---|
| R-5.1 | Public benchmark and (o=1/m) inclusion threshold | Public type; baseline | Backward induction and cost comparison | PDF pp. 12–13, 36; Rmd 461–505, 1351–1374 |
| R-5.2 | Terminal majority exclusion; unanimity screening/pooling cutoff (p^*) | Private terminal game | Acceptance-set payoff comparison | PDF pp. 13–14, 36; Rmd 518–532, 1376–1391 |
| R-5.3 | Five-cell private-majority correspondence | (m\ge3); private Round 1 | Exhaustion of (E,S,P), delay dominance, pairwise payoff differences | PDF pp. 14–16, 37–38; Rmd 565–592, 1393–1433 |
| R-5.4 | Unanimity exists at (p=0) and (p>p^*), empty for (0<p\le p^*) | Pure ballot PBE only | Response completions plus four-profile failure after (s^\dagger) | PDF pp. 15–16, 38–39; Rmd 615–638, 1435–1511 |
| R-5.5 | Exact private institutional payoff contrast | Same parameters; both sources exist | Componentwise affine subtraction | PDF pp. 17–19, 39–40; Rmd 685–715, 1513–1525 |
| R-5.6 | Exact rule-specific informational rents | Same-rule public/private comparison | Subtract public vector from each private class | PDF pp. 19–21, 40; Rmd 743–770, 1527–1537 |
| R-5.7 | Exact institutional informational-rent contrast | Both rent sources exist | Difference of rent correspondences | PDF pp. 20–23, 40; Rmd 778–865, 1539–1549 |
| R-C.1 | Endpoints are literal complete-information games | (p\in\{0,1\}) | Support-preserving equivalence | PDF pp. 40–41; Rmd 1553–1562 |
| R-C.2 | Segments are linked; envelopes are not rectangles; emptiness propagates | (h=1/m) segment; (0<p\le p^*) empty cell | Common-(\lambda) set geometry | PDF p. 41; Rmd 1564–1592 |
| R-C.3 | Worked numerical decomposition | One theoretical parameter point | Direct substitution into exact formulas | PDF pp. 41–42; Rmd 1594–1621 |

## Coverage conclusion

S05, S12, and S13 are fully covered proposition by proposition. I found every Proposition 5.1–5.7 statement, its Appendix B proof, and the Appendix C endpoint/set/illustration qualifications. I did not find any additional proposition in the assigned units. No manuscript file was edited.
