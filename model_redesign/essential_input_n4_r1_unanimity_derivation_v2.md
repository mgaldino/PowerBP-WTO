# N4 v2 candidate — R1 under unanimity

**Node:** `N4`

**Status:** `pending` — implementation candidate awaiting independent review

**Normative source:** approved
`quality_reports/plans/2026-08-12_essential_input_gate0.md`

**Frozen dependency:** `N2`,
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`

**Cold source:**
`model_redesign/essential_input_n4_r1_unanimity_cold_notes_v2.md`

**Interface:**
`model_redesign/essential_input_interfaces/n4_r1_unanimity_candidate_v2.json`

**Ledger:** `model_redesign/essential_input_n4_claim_ledger_v2.json`

This is a cold reconstruction from the governing contract and frozen N2. It
does not consume N3, N6, N7, or an earlier N4 result. Payoffs are in current R1
units and every N2 continuation is multiplied by `beta` exactly once.

## 1. Frozen continuation and notation

Let `nu=Pr(theta=1)` and `m=N-1>=2`. Define

```text
ell = beta*o_0
h   = beta*o_1
a   = beta*(1-o_0)/m
b   = beta*(1-o_1)/m
nu_star = (o_1-o_0)/(1-o_0)
D = (1-nu)*a
C = max{D,b}
P = 1-h-(m-1)*b.
```

Strict primitives imply `0<ell<h`, `0<b<a`, `0<nu_star<1`, and

```text
P-b=1-beta>0.
```

Frozen N2 has two realized, R1-discounted weak payoff vectors:

```text
low-only L: (a,0)
pooling  P: (b,b).
```

The authorized accounting correction is the second coordinate zero in `L`.
The H vectors are `(ell,h)` under `L` and `(h,h)` under pooling.

An on-path delay preserves posterior `nu`, so N2 gives each weak state

```text
C=D  for 0<=nu<=nu_star,
C=b  for nu_star<nu<=1.
```

At `nu_star`, `D=b` and the frozen N2 tie-break selects low-only.

The ballot voter and a zero-probability proposer deviation use different but
compatible objects. A weak voter's successor continuation is the subjective N2
value at the successor posterior and is always at least `b`. A deviating
proposer is evaluated at the true pre-proposal prior, so low-only continuation
pays it `D`, including zero in the realized high state. The on-path weak-payment
floor is therefore the constant `b`.

## 2. Exact proposer security

### 2.1 At least two weak responders: m>=3

The exact security level is

```text
S_m=min{P,D}.
```

The package `(h,b,...,b,P)` proves the lower bound. Passage pays `P`.
Rejection cannot use pooling value `b`: at the minimum subjective continuation,
a sole veto is tied and `T^Y` selects yes, while two vetoes cannot be strict.
Any admissible rejection must use a low-only continuation strictly above `b`
for the voter and pays the proposer `D` under the true prior.

For the matching low-only rejection construction, at least two weak responders
vote no and both H types vote yes. The current failure history uses a posterior
strictly below `nu_star`; each unilateral weak yes is sent to pooling. Every no
is strict, low H's yes is selected by `T^Y` against another low-only history,
and high H's yes is selected by `T^Y` because its continuation is always `h`.
This construction attains `D`, including `D=b` at true `nu_star` by using a
strictly lower off-path ballot posterior. It never uses reverse H separation.

For the upper bound, an offer paying some weak voter less than `b` can be vetoed
to pooling. If every weak voter receives at least `b` and `Y>=h`, passage pays
at most `P` and coordinated low-only rejection pays `D`. If `Y<h`, low-only
rejection still caps the offer at `D`.

### 2.2 One weak responder: m=2

Define

```text
F   = 1-h-a
R_L = 1-ell-a
K   = min{b,(1-nu)*R_L}
M   = min{P,D}, where P=1-h-b
S_2 = max{F,K,M}.
```

The three terms are indispensable.

- `(h,a,F)` forces both voters to yes and yields `F` when feasible.
- `(ell,a,R_L)` forces the weak voter to yes; H either pools on no and
  gives the proposer `b`, or passes only with low H and gives
  `(1-nu)R_L`. It guarantees `K`.
- `(h,b,P)` either passes for `P` or can only be rejected through low-only
  continuation worth `D`. It guarantees `M`.

If `F<0`, that package is infeasible, but `K,M>=0`, so retaining `F` inside the
maximum is algebraically correct and does not assert a feasible negative offer.

Exhaustion follows from the payment regions `x<b`, `b<=x<a`, and `x>=a`.
The first is capped by pooling rejection; in the middle, any rejection is
low-only and the best `Y>=h` offer is `M`; at `x>=a`, the middle-H interval
gives `K` and `Y>=h` gives `F`. The residual `1-ell-b` exceeds `a`, so the
remaining middle-payment/middle-H subcase collapses to `min{b,D}` and cannot
improve the maximum.

## 3. Local pure branches

### 3.1 Pooling passage

All voters say yes. The exact floors are

```text
Y>=h,
x_j>=b for every weak responder.
```

Let `S=S_m` or `S_2` and define

```text
U_P=1-(m-1)*b-S=h+P-S.
```

If `S=P`, the unique pooling package is `(h,b,...,b,P)`. If `S<P`,

```text
Y in [h,y_bar]  when y_bar<U_P,
Y in [h,U_P)    when y_bar>=U_P.
```

Thus `h` is always an attained minimum. A maximum exists iff `S=P` or
`S<P,y_bar<U_P`; equality `y_bar=U_P` is a nonattained supremum.

For `m>=3,S=D<P`, packages ordinarily require `r>D`; the sole extra boundary is
`nu=1,Y=h,r=D=0`. If `D>=P`, pooling is the unique package stated above.

For `m=2,S<P`, packages ordinarily require `r>S`. At `Y=h,r=S`, define

```text
B_M = [S=M=D<P]
B_K = [S=K=(1-nu)*R_L<b].
```

For `nu<1`, a binding `B_M` or `B_K` forces an alternative with lower expected
H payoff and excludes the equality. At `nu=1`, it is retained. Every
`Y>h,r=S` is excluded. If `S=P`, the unique pooling package applies.

Slack and heterogeneous weak payments survive whenever feasibility and these
payoff inequalities permit them. Pooling H payoffs are `(Y,Y)`.

### 3.2 Low-only passage

This branch exists only at `nu=0`:

```text
Y in [ell,h),
x_j>=b.
```

The minimum is attained; `h` is a nonattained supremum. H payoffs, including
the zero-prior high type, are `(Y,h)`.

For `m>=3`, `D=a` at `nu=0`:

```text
a<P  -> r>a, except (Y=ell,r=a);
a>=P -> r>=P.
```

For `m=2`, let `S_0=S_2(0)` and

```text
B_L0=[M(0)=a=S_0<P].
```

Normally `r>=S_0`. Under `B_L0`, equality is retained only at `Y=ell`; every
larger Y requires `r>S_0`. Equivalently, `B_L0` is `b<F<=a`.

Low-only passage is impossible at every `nu>0`: low H can mimic the high-type
no history and obtain `h`, so low yes needs `Y>=h` while high no needs `Y<h`.
High-only passage is impossible for all priors.

### 3.3 Delay

Delay pays the proposer `C` and gives H

```text
(ell,h) for nu<=nu_star,
(h,h)   for nu>nu_star.
```

It exists for every prior when `m>=3`. When `m=2`, it exists iff `C>=F`, with
equality retained by the proposal tie-break. Its Y projection is the full
closed interval `[0,y_bar]`; both endpoints are attained because Y is not
implemented.

Every pure delay ballot is one of:

1. all weak responders yes and both H types no, requiring `Y<ell` in the low
   N2 region and `Y<h` in the high region;
2. exactly one weak veto, both H types yes, and its payment `x_j<C`;
3. at least two weak vetoes, possible only for `m>=3` and `nu<nu_star`.

At `nu>=nu_star`, multiple weak vetoes cannot be strict because `b` is already
the minimum subjective continuation and `T^Y` selects yes. When a weak veto
makes H nonpivotal, both H types say yes; reverse H separation cannot survive
Bayes and `T^Y` on path.

## 4. Mixtures and identity closure

Ballot actions remain pure. Within pooling or low-only support, proposal mixing
may vary package details only at common `(Y,r)`; the proposal-level tie-break
rules out different H payoffs in one support. Delay may mix over any admissible
delay proposals because all give the same proposer and H payoffs.

The only within-proposer cross-branch mixtures are

```text
L/D at nu=0,       Y_L=ell, r_L=a;
P/D at nu>nu_star, Y_P=h,   r_P=b.
```

The first requires `F<=a` when `m=2`; the second requires `F<=b` when `m=2`.
Both are unconditional for `m>=3`. H payoffs are invariant over either valid
support. No L/P, low-region P/D, or triple mixture survives.

Strategies may condition on recognized proposer identity. Every identity map
into the locally available branch alphabet is retained, with its linked
packages, ballots, beliefs, and continuation. Identity permutations are source
multiplicity. They may be collapsed only by the downstream H-rent quotient,
which must preserve all source IDs and hashes.

For weak identity `k`, the exact pre-recognition payoff is

```text
U_Wk=(1/m)*sum_i E[u_k|proposer i],

i=k:  P or L -> r_i; D -> C,
i!=k: P or L -> x_ik; D -> C.
```

This is an identity-indexed map, not a representative-agent scalar.

## 5. nu=0 reporting coordinates

For every assessment define

```text
rho_c=(1/m)*sum_i Pr_i(c), c in {L,P,D},
rho_L+rho_P+rho_D=1.
```

Pure identity conventions enumerate every admissible integer triple
`(k_L,k_P,k_D)` summing to `m`, with `rho_c=k_c/m`. In the `m=2,F>a` cell,
`k_D=0`. If L/D mixing is available, its behavioral probability generates the
additional continuous slices; these are strategy probabilities, never a
distribution over equilibria.

Let `bar_Y_L` and `bar_Y_P` be the recognition- and strategy-weighted
conditional means inside each branch. An empty category is represented by

```text
{status:"not_applicable",reason:"category_empty"},
```

never by a numeric sentinel. H payoffs are

```text
U_H(0)=rho_L*bar_Y_L+rho_P*bar_Y_P+rho_D*ell,
U_H(1)=(rho_L+rho_D)*h+rho_P*bar_Y_P.
```

The R1-event distribution is

```text
pass_with_hegemon=rho_L+rho_P,
pass_without_hegemon=0,
failure=0,
delay=rho_D.
```

At other priors, remove L and average the P and D type maps over recognition
and endogenous proposal mixing. `failure` remains zero: N4 delay is the R1
event, while eventual N2 outcomes are already inside the continuation payoff.

## 6. P0, P3--P7, and beliefs

P0 is refuted as a universal full-pie claim. Filling slack changes the exact
proposal and may trigger a different zero-probability belief and response;
accepted and delayed slack packages survive except at the explicitly unique
full-pie boundary.

P3 eliminates all positive-prior separation but preserves low-only at zero
prior. P4 holds on path because neither weak proposals nor weak ballots can
condition on theta; Bayes makes them uninformative. Off-path beliefs remain
explicit and unrestricted. P5 is inherited from frozen N2 and iid recognition.
P6 generates the constant weak floor, the veto restrictions, and all `T^Y`
endpoints. P7 is explicit in every H-vote posterior construction.

## 7. Coverage and status

The six exhaustive parameter cells are

```text
m=2:  nu=0; 0<nu<=nu_star; nu_star<nu<=1;
m>=3: nu=0; 0<nu<=nu_star; nu_star<nu<=1.
```

Every cell has a nonempty equilibrium correspondence because pooling always
exists. Candidate branch families that are empty receive typed nonexistence
certificates in the interface and ledger; no equilibrium sentinel is used.

The result is a set-valued correspondence over packages, proposal laws, delay
constructors, beliefs, identity assignments, and the two valid mixed loci. No
distribution or equilibrium selection is added. N4 remains pending until the
same candidate hash receives two independent read-only PASS `0/0/0` reviews;
this implementation does not mutate DAG lifecycle fields.

## 8. Provenance boundary

The obsolete N4 artifact was opened only after the cold derivation was sealed.
Its security formulas and the endpoints built from them are not transported.
The structural invariants listed above survived independent rederivation. Any
change to the governing contract or frozen N2 hash invalidates this candidate.
