# N4 v2 cold derivation notes — R1 unanimity

**Status:** `COLD_DERIVATION_SEALED`

**Scope:** private-information R1 unanimity only. These notes consume only the
approved Gate 0 contract and the frozen N2 interface at
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`.
No earlier N4 derivation, interface, proof, ledger, or verifier was opened before
this cold derivation was sealed.

**Lifecycle:** implementation candidate only; no review, freeze, DAG mutation,
N6/N7 work, manuscript work, or PDF generation is authorized here.

## 1. Preflight and fixed inputs

The live preflight returned:

- repository root: the current PowerBayesianPersuasion worktree;
- branch: `codex/essential-input-goal4-n7-phaseb`;
- HEAD: `5a165a56a6e7be30a43dd4c46807758f71e14d35`;
- worktree: clean before the present note;
- protected tag peel: `f53e6769624ce3dd6e64e21ad40d08230b0950a7`;
- Gate 0 verifier: `PASS`;
- N2 verifier: `PASS`, exact frozen hash above;
- N3 v2 verifier: `PASS`, candidate still pending review;
- game DAG: `VALID`, `Ready: N3, N4`, and candidate `N4` valid.

The game, actions, information, payoffs, solution concept, `T^Y`, topology, and
`equilibrium_correspondence_v1` schema remain unchanged.

## 2. Native-date continuation objects

Write

```text
ell = beta*o_0
h   = beta*o_1
a   = beta*(1-o_0)/m
b   = beta*(1-o_1)/m
nu_star = (o_1-o_0)/(1-o_0)
D(nu) = (1-nu)*a
C(nu) = max{D(nu), b}
```

The strict primitive domain implies

```text
0 < ell < h < beta < 1,
0 < b < a,
0 < nu_star < 1.
```

N2 exports two terminal continuation records. After multiplying exactly once by
`beta` on import into R1, their realized weak-state payoff vectors by type are

```text
N2 low-only continuation L: (a, 0)
N2 pooling continuation P:  (b, b).
```

The zero in the high state of `L` is realized accounting, not an expected value
evaluated at the public posterior. It is the correction authorized by
`N4-V2-ACCOUNTING-01`.

The corresponding H payoff vectors are

```text
L: (ell, h)
P: (h, h).
```

At an on-path delay history Bayes preserves `nu`, and N2 selects the weak-optimal
terminal proposal. Therefore the current weak state's R1 continuation is

```text
C(nu) = D(nu)  if 0 <= nu <= nu_star,
C(nu) = b      if nu_star < nu <= 1.
```

At `nu=nu_star`, `D=b` and the frozen N2 proposal-level tie-break selects the
low-only record, although its weak expected payoff equals the pooling value.

### Subjective successor value versus realized deviation value

A weak voter comparing `yes` and `no` uses the N2 continuation value attached
to the successor public posterior in its assessment. Every such subjective N2
value is at least `b`. Consequently `b`, not `min{b,D(nu)}`, is the exact weak
payment floor for an on-path passing proposal.

A proposer deviating to a zero-probability proposal instead evaluates the
induced realized type-contingent continuation with the true pre-proposal prior,
as required by Contract Section 5. If the deviation is sent to `L`, that value
is `D(nu)=(1-nu)a`, including the realized zero under `theta=1`. These two
calculations must not be conflated.

## 3. Exact proposer security levels

Define the full-pooling residual at the minimum passing package by

```text
P = 1 - h - (m-1)*b.
```

The strict domain gives

```text
P-b = 1-beta > 0,
```

so `P>b>0`.

### 3.1 Case m >= 3

There are at least two weak nonproposers. The exact security level is

```text
S_m(nu) = min{P, D(nu)}.
```

**Lower bound.** The proposer offers

```text
(Y,x_1,...,x_{m-1},r) = (h,b,...,b,P).
```

If it passes, the proposer obtains `P`. A rejection at `x_j=b` cannot be
sustained with a pooling continuation worth `b`: a sole veto is tied with
passing and `T^Y` selects yes, while with at least two vetoes no voter can make
`no` strictly better because `b` is the minimum subjective successor value.
Any admissible rejection therefore uses a low-only continuation strictly above
`b` for the rejecting voter and gives the deviating proposer the realized value
`D(nu)`. Hence the offer guarantees `min{P,D}`.

**Attained low-only rejection construction.** This construction is needed in
particular when the true prior is low and `D>b`. All weak responders vote no;
both H types vote yes; the on-assessment rejection history is assigned a
low-only posterior `lambda<nu_star`; and every unilateral weak switch to yes is
assigned a pooling continuation. Since the subjective low-only value at
`lambda` is strictly above `b`, every weak no is strict. H type 0 compares an
on-history low-only continuation `ell` with an H-no history also assigned
low-only, so `T^Y` selects yes. H type 1 receives `h` under either continuation,
so `T^Y` also selects yes. The deviating proposer is evaluated at the true
`nu` and receives exactly `D(nu)`. At true `nu=nu_star`, choose any
`lambda<nu_star`; `D=b` is attained. This construction never uses the invalid
pair `H0=no,H1=yes`.

**Upper bound.** If some `x_j<b`, a sole weak veto can reject to a pooling
continuation and hold the proposer to `b<P`. If all `x_j>=b` and `Y>=h`,
passage pays at most `P`, while the coordinated low-only construction pays
`D`. If `Y<h`, coordinated low-only rejection still caps the proposal at `D`.
Thus no proposal secures more than `min{P,D}`.

### 3.2 Case m = 2

There is one weak nonproposer. Define

```text
F   = 1 - h - a
R_L = 1 - ell - a
K(nu) = min{b, (1-nu)*R_L}
M(nu) = min{P, D(nu)}        # here P=1-h-b
S_2(nu) = max{F, K(nu), M(nu)}.
```

`F` may be negative. In that case the associated package is infeasible, but
the maximum remains valid because `K` and `M` are nonnegative. No claim of a
feasible negative-payoff offer is made.

The exhaustive weak-payment thresholds are as follows.

| Weak payment | Consequence | Best security in the region |
|---|---|---|
| `x<b` | Pooling rejection is available | at most `min{b,D}`, dominated by `M` |
| `b<=x<a` | Any rejection must use low-only continuation | `M`, attained at `(h,b,P)` |
| `x>=a`, `ell<=Y<h` | The sole weak voter is forced to yes; H either pools on no or passes only with low H | `K`, attained at `(ell,a,R_L)` |
| `x>=a`, `Y>=h` | The sole weak voter and both H types are forced to yes | `F`, attained at `(h,a,F)` when feasible |

For the intermediate region `b<=x<a` and `ell<=Y<h`, the best residual at the
lower thresholds is `1-ell-b`, and

```text
1-ell-b > a.
```

Therefore its security collapses to `min{b,D}` and cannot improve on `M`.
These cases establish both the lower and upper bounds for `S_2`.

The three components must remain explicit. Each can bind uniquely. Concrete
strict-domain test points are:

```text
F unique: beta=.5,  o_0=.2,       o_1=.6,       nu=.5
K unique: beta=.95, o_0=.4,       o_1=.8,       nu=.7
M unique: beta=.9,  o_0=7/15,     o_1=11/15,    nu=0
```

The last point gives `a=.24`, `b=.12`, `h=.66`, `P=.22`, `F=.10`,
`K=.12`, and `M=.22`.

## 4. Pure local branch correspondence for one recognized proposer

The proposal coordinate is denoted `Y` to distinguish it from the primitive
upper bound `y_bar`. Every passing package has weak payments `x_j>=b`. Slack is
allowed whenever the conditions below permit it; P0 does not justify imposing
budget equality as a primitive.

### 4.1 Pooling passage P

Both H types vote yes and every weak voter votes yes. The exact H condition is

```text
Y >= h.
```

Let `S` be `S_m` or `S_2` as appropriate and define

```text
U_P = 1 - (m-1)*b - S = h + P - S.
```

The minimum `Y=h` is always attained.

**If `S=P`:** the only pooling package is

```text
Y=h, x_j=b for every j, r=P,
```

with no slack. Thus the minimum and maximum both exist and equal `h`.

**If `S<P`:** the Y projection is

```text
[h,y_bar]  if y_bar < U_P,
[h,U_P)    if y_bar >= U_P.
```

Equivalently, `sup Y=min{y_bar,U_P}`. A maximum exists exactly when
`y_bar<U_P`; when `y_bar=U_P` the cap is a nonattained supremum. Feasible
packages satisfy

```text
x_j >= b,
Y + sum_j x_j + r <= 1.
```

For `m>=3` and `S=D<P`, ordinarily `r>D`. The sole additional lower-payoff
boundary is `nu=1`, `Y=h`, `r=D=0`; it is admissible because only the high type
has positive probability and both the pooling and low-only-continuation H
payoffs equal `h`.

For `m=2` and `S<P`, ordinarily `r>S`. The boundary `Y=h,r=S` is admissible
unless a binding security component forces a strictly lower expected H payoff:

```text
B_M := [S=M=D<P]
B_K := [S=K=(1-nu)*R_L < b].
```

For `nu<1`, either `B_M` or `B_K` excludes `Y=h,r=S`. At `nu=1`, the boundary
is admissible because the only possible H type receives `h` under both paths.
When `Y>h`, `r=S` is always excluded by the proposal-level H-payoff tie-break.
Equalities in which `K=b` can be implemented through the pooled-no response
with H payoff `h`; they are not silently treated as the strict `B_K` case.

Pooling H payoffs are

```text
U_H(0)=Y,
U_H(1)=Y.
```

The recognized proposer receives `r`, and a weak responder `j` receives `x_j`.
The R1 outcome is immediate passage with H.

### 4.2 Low-only passage L

This branch exists only at `nu=0`. All weak responders vote yes; H type 0 votes
yes; H type 1 votes no. The H-no history must use a low-only continuation. The
exact Y set is

```text
Y in [ell,h).
```

The minimum `ell` is attained by `T^Y`; `h` is the nonattained supremum and
there is no maximum. The branch is impossible for every `nu>0`: an on-path
high-type no fixes the continuation at posterior one, so low H would require
`Y>=h` while high H requires `Y<h`.

For `m>=3`, at `nu=0` we have `D=a` and `S=min{P,a}`:

```text
if a<P:  r>a, except that (Y=ell,r=a) is admissible;
if a>=P: r>=P.
```

For `m=2`, write `S_0=S_2(0)`. Packages satisfy `r>=S_0`, except for the
following binding-low-H case:

```text
B_L0 := [M(0)=a=S_0<P].
```

Under `B_L0`, `r=S_0` is admissible only at `Y=ell`; every `Y>ell` requires
`r>S_0`. Equivalently in primitive derived quantities, `B_L0` is
`b<F<=a`.

All low-only packages also satisfy `x_j>=b` and feasibility. Its type payoff
map, including the zero-prior high type, is

```text
U_H(0)=Y,
U_H(1)=h.
```

The recognized proposer receives `r` when the realized low type passes. At
`nu=0`, the R1 outcome is immediate passage with H.

### 4.3 Delay D

The on-path proposer payoff is exactly `C(nu)`. The H payoff vector is

```text
(ell,h) if 0<=nu<=nu_star,
(h,h)   if nu_star<nu<=1.
```

For `m>=3`, delay exists for every `nu`. For `m=2`, delay exists if and only if

```text
C(nu) >= F.
```

Equality is included: the delay path gives H no more than the forced-pooling
security offer, so the proposal-level tie-break does not exclude delay.

The delay Y projection is always the full closed set

```text
[0,y_bar].
```

Both minimum and maximum are attained. The proposed `Y` is not implemented,
and every delayed proposal gives the same proposer and H continuation payoffs;
the proposal-level tie-break therefore does not select a Y.

All pure delay ballots fall into one of the following exhaustive families.

1. **H veto.** Every weak responder votes yes and both H types vote no.
   This requires `Y<ell` when `nu<=nu_star`, and `Y<h` when
   `nu>nu_star`. Equality is excluded by `T^Y`.
2. **Exactly one weak veto.** One weak responder `j*` votes no, every other
   weak responder and both H types vote yes, and `x_{j*}<C(nu)`. This family
   exists for every `nu` and permits every `Y`.
3. **At least two weak vetoes.** This requires `m>=3` and `nu<nu_star`.
   The on-path low-only weak continuation is then strictly above `b`, while a
   unilateral switch can be sent to pooling continuation `b`. At
   `nu>=nu_star`, the on-path weak continuation is already the minimum `b`, so
   `T^Y` eliminates every such no vote.

If a weak veto makes H nonpivotal, both H types vote yes. High H is indifferent
between all continuation branches and `T^Y` selects yes. A proposed
`H0=no,H1=yes` separation cannot survive on path: Bayes sends the low-type no
history to posterior zero, where no gives only `ell`, and `T^Y` selects yes.

## 5. Candidate nonexistence certificates

The following candidate classes are empty under the maintained concept.

| Candidate | Domain | Certificate |
|---|---|---|
| high-only passage | all `nu` | high H needs `Y>=h`; low H no requires a strict payoff above its yes payoff and cannot coexist with that inequality |
| low-only passage | `nu>0` | low H can mimic the high-type no history and obtain `h`, requiring `Y>=h`, while high no requires `Y<h` |
| separating H ballot inside delay | all `nu` | high H is nonpivotal and `T^Y` selects yes; Bayes makes a low-type no history low-only and prevents strict no |
| two or more weak vetoes | `nu>=nu_star` | on-path continuation equals the minimum subjective value `b`; no cannot be strict and `T^Y` selects yes |
| delay with `m=2` | `C(nu)<F` | the feasible forced-pooling offer `(h,a,F)` is a strict profitable deviation |

The complete N4 correspondence is nevertheless nonempty in every primitive
cell because pooling passage always exists.

## 6. Proposal mixtures and pure ballots

Ballots remain pure everywhere. Proposal strategies may mix only over actions
that are tied both in proposer payoff and under the proposal-level H-payoff
tie-break.

### Within-branch mixtures

- Pooling proposals may mix over package variations only when they have the
  same `Y`, the same proposer payoff `r`, and hence the same H payoff. Weak
  payment identities, unused slack, and other payoff-irrelevant package
  variations remain in the source assessment.
- Low-only proposals obey the same restriction: a common `Y` and `r` across
  support, with package multiplicity preserved.
- Delay proposals may mix over any support in their admissible delay family,
  including different `Y`, because all support points give the same proposer
  payoff `C(nu)` and the same H continuation vector.

### Cross-branch mixtures for one recognized proposer

Exactly two cross-branch loci survive.

```text
L/D: nu=0, Y_L=ell, r_L=a.
P/D: nu>nu_star, Y_P=h, r_P=b.
```

The first also requires delay existence, which is automatic for `m>=3` and is
`F<=a` for `m=2`. The second is automatic for `m>=3` and requires `F<=b` for
`m=2`. At each locus the two branches generate the same H type payoff vector,
so every endogenous mixing probability leaves expected H payoffs invariant.

There is no L/P mix: when proposer payoffs tie, the low-only proposal gives H
strictly less. There is no P/D mix at or below `nu_star`: delay gives H an
expected continuation strictly below the minimum pooling payment `h`. No
triple-branch mix survives.

## 7. Identity-complete assessment family

Recognition is uniform over the `m` weak states, and strategies may condition on
the recognized proposer identity. A source assessment therefore specifies, for
every identity `i`, one admissible pure branch or one of the two admissible
within-proposer mixtures above, together with its complete package, ballot
strategies, beliefs, and continuation IDs.

The available pure branch alphabet is

```text
nu=0, m>=3:                 {L,P,D}
nu=0, m=2, F<=a:            {L,P,D}
nu=0, m=2, F>a:             {L,P}
nu>0, m>=3:                 {P,D}
nu>0, m=2, C(nu)>=F:        {P,D}
nu>0, m=2, C(nu)<F:         {P}.
```

Every identity map into the relevant alphabet is admissible subject to the
local package conditions. These maps are source multiplicity, not a draw over
equilibria. Permuting proposer identities remains a distinct source assessment
unless and until the H-rent quotient is formed downstream.

For a target weak identity `k`, its pre-recognition expected payoff is the
executable map

```text
U_Wk = (1/m) * sum_i E[u_k | proposer i],

u_k | i=k:
  P or L -> r_i
  D      -> C(nu)

u_k | i!=k:
  P or L -> x_ik
  D      -> C(nu).
```

Behavioral proposal mixtures use their strategy probabilities inside the same
expectation. This preserves weak identity asymmetry rather than replacing it by
a representative-agent scalar.

For a pure P/D identity assignment at general `nu`, H payoffs are

```text
U_H(theta) = (1/m) * sum_i U_H(theta | branch_i).
```

Branch maps are exactly those in Sections 4.1 and 4.3. Outcome probabilities
are the corresponding uniform-recognition averages of the mutually exclusive
R1 events:

```text
pass_with_hegemon = (1/m)*sum_i Pr_i(P)
                    + 1{nu=0}*(1/m)*sum_i Pr_i(L),
pass_without_hegemon = 0,
failure = 0,
delay = (1/m)*sum_i Pr_i(D).
```

Thus the four coordinates partition the R1 event. `delay` records R1 rejection
followed by N2; `failure` is reserved for terminal failure at the node's own
date and is zero in N4. The eventual N2 outcome is already incorporated in the
discounted payoff map and must not be counted a second time in
`outcome_distribution`. No passage without H occurs under unanimity.

## 8. nu=0 reporting coordinates

For every source assessment at `nu=0`, define endogenous strategy coordinates

```text
rho_L = (1/m) * sum_i Pr_i(L)
rho_P = (1/m) * sum_i Pr_i(P)
rho_D = (1/m) * sum_i Pr_i(D)
```

with

```text
rho_L>=0, rho_P>=0, rho_D>=0,
rho_L+rho_P+rho_D=1.
```

These are recognition-weighted branch probabilities implied by the assessment,
not empirical frequencies, external weights, or probabilities over equilibria.

For pure identity conventions, enumerate every integer triple

```text
(k_L,k_P,k_D), k_c>=0, k_L+k_P+k_D=m,
(rho_L,rho_P,rho_D)=(k_L/m,k_P/m,k_D/m),
```

subject to `k_D=0` in the `m=2,F>a` no-delay cell. If L/D mixing is available,
identities not assigned pure P may also use their endogenous L/D probability;
this enumerates the continuous slices generated by valid strategies without
putting a distribution on their points.

Conditional concession means are

```text
bar_Y_L = sum_i Pr_i(L)*E_i[Y|L] / sum_i Pr_i(L),
bar_Y_P = sum_i Pr_i(P)*E_i[Y|P] / sum_i Pr_i(P).
```

If the denominator of a category is zero, the coordinate is represented by the
typed object

```text
{status: "not_applicable", reason: "category_empty"}
```

and never by zero, `NA`, an empty string, or another numeric sentinel.

The H payoff map is

```text
U_H(0) = rho_L*bar_Y_L + rho_P*bar_Y_P + rho_D*ell,
U_H(1) = (rho_L+rho_D)*h + rho_P*bar_Y_P,
```

with absent-category products omitted through the typed representation rather
than numerically fabricated. The R1 outcome map is

```text
pass_with_hegemon = rho_L + rho_P,
delay             = rho_D,
pass_without_hegemon = 0,
failure              = 0.
```

Only the downstream H-rent projection may collapse identity permutations with
the same H payoff vector. Every projected point must retain the IDs and hashes
of all source assessments that generate it.

## 9. Beliefs, P4, P5, P6, and payoff dates

On every positive-probability proposal, the proposer is uninformed, so its
proposal distribution is identical across H types still possible. Every weak
ballot action is also selected without observing the type and has the same
distribution across those types. Bayes therefore implies that weak actions add
no information about `theta` beyond the public proposal and history. Only an H
vote could update the posterior. All surviving positive-probability pooling and
delay branches have pooled H actions; the only low-only passage is at
`nu=0`. This proves the on-path weak-vote-passive lemma without imposing it as
an extra assessment restriction.

Zero-probability proposals and vote vectors retain explicit unrestricted belief
components. The constructions above state which side of `nu_star` is required;
they do not impose a new belief refinement or punishment convention.

N2 posterior sufficiency is consumed unchanged. IID recognition with replacement
means no rejected-history identity variable enters the R2 maximization beyond
the posterior. All N4 payoffs are in `R1_current_units`; every N2 payoff above
has been multiplied by `beta` exactly once.

## 10. Executable boundary and negative-test obligations

The v2 build and verification scripts must test at least:

1. exact primitive inequalities and `nu_star` location;
2. `P-b=1-beta>0`;
3. all three unique m=2 security binders `F`, `K`, and `M`;
4. rejection of any m=2 formula omitting one binder;
5. the `m>=3,D>b` low-prior case where a purported pooling-`b` rejection is
   invalid and the exact security is `min(P,D)`;
6. rejection of the incorrect on-path weak floor `min{b,D}` in place of `b`;
7. `S=P` unique-pooling cells and `S<P` open-cap cells;
8. `y_bar<U_P`, `y_bar=U_P`, and `y_bar>U_P` attainment;
9. every proposal-tie boundary in Sections 4.1 and 4.2;
10. delay existence and nonexistence for `m=2` around `C=F`;
11. `nu=0`, `nu=nu_star`, `nu>nu_star`, and `nu=1`;
12. exact L/D and P/D mixture loci and rejection immediately off those loci;
13. all pure `nu=0` identity count triples in the admissible alphabet;
14. typed non-applicability for empty L or P categories;
15. H payoff and outcome invariance under valid cross mixtures;
16. weak identity payoff maps and non-collapse of source identity permutations;
17. exact N2 hash, exactly-one discount, schema field completeness, and no free
    symbols required by N6/N7;
18. canonical JSON stability and UTF-8 encoding;
19. rejection of mutations to each interface, ledger, derivation, and source
    formula family.

## 11. Invalidation and stop rule

These results depend only on the approved contract and the exact frozen N2
interface hash. Any change to either invalidates the complete note. Any new
divergence, missing definition, schema/topology/game/protocol change, or repair
with multiple reasonable choices requires a Section 11.1 STOP before candidate
implementation.

## 12. Post-seal provenance cross-check

Only after Sections 1--11 had been recorded, the obsolete N4 derivation,
interface, ledger, and verifier were opened for provenance comparison. The
comparison found no new ambiguity and did not supply any v2 formula.

The following cold-derived invariants match the obsolete provenance: six
`m`/prior coverage cells; low-only passage only at `nu=0`; universal pooling;
the same delay-existence condition after rewriting `max{0,F}<=C` as `F<=C`;
universal delay for `m>=3`; the delay-veto families; the L/D and high-region
P/D mixture loci; Cartesian identity closure; P4; slack survival; exact N2
consumption; and exactly-one discount.

The following obsolete claims do not survive and will not be transported:

```text
old m>=3 support: (1-nu)*b
old m=2 support:  max{max(0,F), min[b,(1-nu)*R_L]}
old pooling/low-only endpoints derived from those supports
old outcome overlay that counted later N2 failure inside N4's R1 partition.
```

They are replaced, respectively, by `S_m=min{P,D}`, by
`S_2=max{F,K,M}`, by the endpoint tables in Section 4, and by the R1-event
partition in Section 7. This is the authorized `N4-V2-ACCOUNTING-01`
reconstruction, not a repair of the obsolete files.
