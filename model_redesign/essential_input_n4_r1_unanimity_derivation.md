# N4 candidate — R1 under unanimity

**Node:** `N4`  
**Status:** `pending` — implementation candidate awaiting two independent
read-only reviews  
**Normative source:** Sections 2, 4, 5, 6, 7.2, 8, 9, and 11 of
`quality_reports/plans/2026-08-12_essential_input_gate0.md`  
**Frozen dependency:** `N2`,
`sha256:c6a65dc8d15f3c8e7e5b8d475bf6925a0b6028421adf84f927da361349da85a2`  
**Interface:** `model_redesign/essential_input_n4_r1_unanimity_interface.json`  
**Claim ledger:** `model_redesign/essential_input_n4_r1_unanimity_ledger.json`  
**Verifier:** `scripts/verify_essential_input_n4.R`

This is a cold R1 derivation from the contract and the exact frozen N2
interface. It does not consume N3 or a historical proof formula. All payoffs
below are in current R1 units; every N2 continuation is multiplied by `beta`
exactly once.

## 1. Imported N2 continuation and notation

Let `nu=Pr(theta=1)` at R1 entry and let `m=N-1>=2` be the number of weak
states. Frozen N2 gives the cutoff and continuation strategies

```text
nu_2 = (o_1-o_0)/(1-o_0),
N2 low-only if nu'<=nu_2,
N2 pooling if nu'>nu_2.
```

Define the discounted weak continuation values and the useful residuals

```text
a0 = beta*(1-o_0)/m,
z  = beta*(1-o_1)/m,
d(nu) = (1-nu)*a0,
g(nu) = max{d(nu),z} = beta*C_W^2(nu,U),
p  = 1-beta*o_1-(m-1)*z,
u0 = 1-beta*o_0-(m-1)*z.
```

Here `d(nu)` is the deviating proposer's true-prior payoff when an off-path
failure is sent to the low-only N2 strategy, while `z` is its payoff under the
pooling N2 strategy. The strict primitive domain implies

```text
0<nu_2<1,  0<z<a0,  p=z+(1-beta)>z,
d(nu)>z iff nu<nu_2, and u0>p.
```

Only for `m=2`, with one weak nonproposer, also define

```text
q2 = 1-beta*o_0-a0,
k2 = max{0,1-beta*o_1-a0},
e2(nu) = min{z,(1-nu)*q2},
L2(nu) = max{k2,e2(nu)}.
```

The raw term `(1-nu)*q2` is not a belief-proof deviation bound. It is one
endpoint response to the package `(beta*o_0,a0,q2)`; a high ballot belief can
instead make both H types reject and give the proposer `z`. This is why the
correct guarantee is the truncated term `e2`, not the raw term. Also define

```text
s(nu)=(1-nu)*z.
```

This is the smallest true-prior proposer payoff attainable after failure: use
pooling N2 after the low type and low-only N2 after the high type. For `m>=3`,
the exact lower support bound is

```text
L3(nu) = s(nu).
```

## 2. Atomic assessments, true-prior deviations, and atomless support

For each recognized proposer identity `i`, an assessment contains one proposal
law `F_i`, pure ballot maps, and a complete posterior kernel. A feasible
package is

```text
s=(y,(x_j)_{j in W without i},r_i),
y+sum_j x_j+r_i<=1.
```

Bayes applies to positive-probability proposal events and to a regular
conditional version `F_i`-almost everywhere. An exact singleton under an
atomless `F_i` remains a zero-probability proposal under the contract, so its
ballot belief is an explicit unrestricted assessment component. Every pure
proposal deviation is tested pointwise. The deviating proposer evaluates the
induced type-contingent R2 strategy under the true pre-proposal prior `nu`, not
under the off-path ballot belief.

Family notation below never splices an outcome, belief, or payoff from one
assessment into another. Cross-identity heterogeneity is a Cartesian product
inside one global assessment: each identity keeps its own linked `F_i`, ballot
maps, posterior kernel, and continuation.

## 3. Dynamic ballot comparisons

For a weak nonproposer `j`, fixing the other votes gives

```text
all other voters yes:
  yes -> x_j;                         no -> beta*C_j(h^no)

at least one other voter no:
  yes -> beta*C_j(h^yes);             no -> beta*C_j(h^no).
```

The continuation after a failure can range from the pooling value `z` to the
low-posterior value `a0` in the ballot player's interim comparison. The two
complete vote vectors may have different off-path posteriors. Stage-undominated
voting applies only to weak nonproposers, and `T^Y` selects yes only at genuine
information-set equality.

For H, with all weak nonproposers voting yes,

```text
yes -> y;                             no -> beta*h_theta(h^no).
```

With a weak no already present, both H actions lead to R2, but the complete
vote vector can affect beliefs. H obeys sequential rationality and `T^Y`, not
stage-undominance.

## 4. P4: weak actions are uninformative on path

The recognized weak proposer does not observe `theta`, so its proposal law is
the same for every H type still possible. Every weak nonproposer uses a pure
function of the same public proposal and history and also cannot condition on
`theta`. Conditional on the public history, every positive-probability weak
action therefore has the same distribution under all remaining H types.
Bayes implies that weak proposals and votes add no information about `theta`.
Only H's vote can add an update.

This is the derived on-path weak-vote-passive lemma required by P4. It imposes
no restriction on zero-probability proposals or vote vectors.

## 5. P3 and P7: exhaustion of pure H ballots

At `0<nu<1`, pure separation cannot survive on a positive-probability
proposal.

1. With every weak nonproposer voting yes, low yes/high no makes the observed
   H no reveal type one. Both types then obtain `beta*o_1` from no. Low yes
   requires `y>=beta*o_1`, while high no requires `y<beta*o_1`; equality is
   assigned to yes by `T^Y`.
2. Low no/high yes is impossible because high yes requires
   `y>=beta*o_1`, while low no cannot be optimal at that offer.
3. If a weak no already blocks passage, low yes/high no fails because type one
   is continuation-indifferent and `T^Y` selects yes. Low no/high yes fails
   because low no reveals posterior zero while imitating high yes reaches a
   weakly higher continuation. H therefore pools on yes after weak rejection.

The Bayes steps in this argument do not apply after an exact zero-probability
proposal. At such a proposal, complete vote vectors may have distinct
unrestricted posteriors. In particular, when a weak no already blocks passage,
an off-path response may prescribe low H no and high H yes, assign a high
posterior after the low-type vector and a low posterior after the high-type
vector, and make both actions sequentially rational. Section 6 uses this
nonpivotal off-path separation; it is not an on-path equilibrium branch.

Consequently every positive-prior on-path proposal either pools in current
passage or deliberately fails and continues to N2. At `nu=0`, one additional
accepted branch survives:

```text
beta*o_0<=y<beta*o_1,
```

with low H voting yes and the zero-prior high type voting no. There is no
high-only analogue at `nu=1`.

## 6. Exact off-path guarantee when `m=2`

There is one weak nonproposer. The key response available whenever `x<a0` is
off-path nonpivotal H separation. Fix any ballot belief `rho in (0,1)`, prescribe
weak no, low H no, and high H yes. Give the low-H no vector a high posterior,
the high-H yes vector a low posterior, and a weak unilateral-yes vector a high
posterior. The weak voter's interim comparison is

```text
no:  (1-rho)*z + rho*a0,
yes: (1-rho)*z + rho*x.
```

Thus no is strict and stage-undominated for every `x<a0`. Low H obtains
`beta*o_1` from no rather than `beta*o_0` from yes; high H is indifferent and
`T^Y` selects yes. Under the true prior, the proposer obtains `z` after the low
type and zero after the high type, hence `s(nu)=(1-nu)z`. This construction is
valid even at true-prior endpoints because the ballot belief belongs to a
zero-probability proposal.

### 6.1 Endpoint package

At

```text
(y,x,r)=(beta*o_0,a0,q2),
```

the weak voter cannot reject when H votes yes. An endpoint belief can support
low passage/high rejection and gives the true-prior proposer
`(1-nu)*q2`. A high ballot belief instead supports rejection by both H types
and gives the proposer `z`. Thus the package guarantees exactly

```text
e2(nu)=min{z,(1-nu)*q2}.
```

This construction also shows why the untruncated raw endpoint payoff is not a
valid forcing claim.

### 6.2 Fully forced passage

If `x>=a0` and `y>=beta*o_1`, a weak no is incompatible with `T^Y` once H's
type-one strategy is taken into account, and H must vote yes. Feasibility then
bounds the residual by `1-beta*o_1-a0`. The effective guarantee is

```text
k2=max{0,1-beta*o_1-a0}.
```

### 6.3 Sufficiency of the bound

Every null proposal can be assigned a response giving the proposer at most
`L2=max{k2,e2}`:

- if `x<a0`, use the nonpivotal H-separating weak rejection above. It gives
  `s(nu)<=e2(nu)` because `q2>z`;
- if `x>=a0` and `beta*o_0<=y<beta*o_1`, choose the lower of the endpoint
  response `(1-nu)*r` and high-belief rejection `z`. Since `r<=q2`, this is at
  most `e2`;
- if `x>=a0` and `y<beta*o_0`, choose low- or high-belief H rejection. The
  result `min{d,z}` is weakly below `e2` because
  `(1-nu)*a0<=(1-nu)*q2`;
- if `x>=a0` and `y>=beta*o_1`, passage is forced and its residual is at most
  `k2`.

These cases exhaust the proposal space. The endpoint and forced-passage
packages prove the matching lower guarantees `e2` and `k2`. Hence `L2` is
exact. Algebra gives

```text
k2<p, e2<=z<p, and therefore L2<p.
```

Pooling is consequently never eliminated by the `m=2` deviation test.

## 7. Exact off-path guarantee when `m>=3`

There are at least two weak nonproposers. After any null proposal, prescribe no
to two of them and use the nonpivotal H separation from Section 6. Give the
prescribed two-no vectors the H-action-contingent high/low posteriors above and
give either rejector's unilateral-yes vector a high posterior. Each no yields
strictly more than the pooling continuation `z`, remains stage-undominated,
and the true-prior proposer obtains exactly

```text
L3(nu)=s(nu)=(1-nu)*z.
```

No failure continuation can pay the proposer less: under frozen N2, its payoff
conditional on the true low type is at least `z`, while its payoff conditional
on the true high type is at least zero. A proposal with `y=0` cannot pass and
therefore guarantees `(1-nu)z`. The lower bound is exact.

This two-no/H-separating construction is an off-path punishment. On path, a distinct
exactly-one-weak-rejector delay family survives at every prior: choose one
weak voter `j` to vote no, all other voters including H to vote yes, and
`x_j<g(nu)`. Switching to yes would pass and pay `x_j`, so no is strict and
undominated.

## 8. Local accepted branches and proposal-level tie-breaking

### 8.1 Accepted packages

Pooling support satisfies

```text
y>=beta*o_1, every x_j>=z, and r_i<=p.
```

At `nu=0`, low-only support satisfies

```text
beta*o_0<=y<beta*o_1, every x_j>=z, and r_i<=u0.
```

Within each proposer identity and each accepted branch, every package in
`F_i` support has a common proposer payoff `R_i` and a common expected-H
payoff, equivalently a common offer `Y_i`. This is required by the proposal-
level tie-break: accepted maximizers with a larger `y` cannot share support
with an accepted maximizer with a smaller `y`. Other weak allocations and
budget slack may vary while preserving `R_i` and `Y_i`.

For `m=2`, accepted pooling requires `R_i>=L2`. At an equality boundary:

- if `nu<1`, equality is excluded when
  `L2=(1-nu)*q2<z`, because the endpoint deviation must use the low-H endpoint
  response;
- every retained equality requires `Y_i=beta*o_1`.

For `m=2,nu=0`, low-only support requires `L2(0)<=R_i<=u0`; every accepted
support still has a common `Y_i`, but no additional lower-bound equality rule
is needed because the binding off-path responses give H `beta*o_1`.

For `m>=3`, pooling support is

```text
s(nu)<=R_i<=p,
with Y_i=beta*o_1 at R_i=s(nu).
```

At `nu=0`, low-only support has `z=L3(0)<=R_i<=u0`, with a common accepted
offer `Y_i` but no additional equality restriction.

### 8.2 Delay packages

Every on-path delay gives the recognized proposer `g(nu)`. The complete pure
ballot support is the union of:

1. **H rejection:** all weak voters say yes and both H types say no. This
   requires `y<beta*o_0` when `nu<=nu_2`, and `y<beta*o_1` when
   `nu>nu_2`. For `m=2` at `nu>=nu_2`, the sole weak voter's yes also requires
   `x>=z`; at `nu<nu_2` no coordinate bound is needed. For
   `m>=3`, counterfactual multiple-no vectors keep weak yes undominated for any
   nonnegative coordinates.
2. **Weak rejection:** H and every nonrejecting weak voter say yes. With exactly
   one weak rejector `j`, the necessary and sufficient package restriction is
   `x_j<g(nu)`; this family exists at every prior and every `m>=2`. With two or
   more weak rejectors, delay is admissible exactly when `nu<nu_2`, because a
   unilateral yes must yield the strictly lower continuation `z<d(nu)`.

All omitted counterfactual vote vectors retain explicit beliefs that make the
prescribed weak actions sequentially rational, stage-undominated, and
consistent with `T^Y`.

Delay exists for `m=2` if and only if

```text
k2<=g(nu).
```

The endpoint component of `L2` is always weakly below `g`. Delay exists for
every prior when `m>=3`, because `L3=(1-nu)z<=g`.

## 9. Within-identity mixing and identity-product closure

The proposal-level tie-break permits only two cross-branch mixtures within a
single proposer identity.

1. At `nu=0`, low-only passage can mix with delay at
   `R_i=a0` and `Y_i=beta*o_0`. For `m=2`, this requires `k2<=a0`; for
   `m>=3` it always exists.
2. At `nu>nu_2`, pooling can mix with delay at
   `R_i=z` and `Y_i=beta*o_1`. For `m=2`, this requires `k2<=z`; for
   `m>=3` it always exists.

There is no within-identity low-only/pooling mixture: at a proposer-payoff tie,
low-only passage gives H strictly less. There is no pooling/delay mixture in
the low N2 region because delay gives H the low-only continuation and therefore
strictly less than current pooling passage.

Different proposer identities may nevertheless select different local
branches because their null-proposal response maps are identity-indexed. The
global correspondence is the full Cartesian product of the admissible local
sets, including the two legitimate within-identity mixtures. This is one
atomic assessment, not ex-post recombination of records.

For each identity let `lambda_i^L`, `lambda_i^P`, and `lambda_i^D` be its
proposal-law masses on low-only passage, pooling passage, and delay. They sum to
one; impossible local components have zero mass. Define aggregate masses

```text
L=(1/m)*sum_i lambda_i^L,
P=(1/m)*sum_i lambda_i^P,
D=(1/m)*sum_i lambda_i^D.
```

These coordinates compactly export every pure, hybrid, and cross-identity
outcome in one complete record per parameter cell.

## 10. Payoffs and outcome distributions

For weak identity `k`, let `V_k` be its expected payoff conditional on being
recognized, and let `X_ki` be its expected current allocation when another
identity `i` proposes an accepted package. Then

```text
V_k = lambda_k^L*R_k^L + lambda_k^P*R_k^P + lambda_k^D*g(nu),

W_k = [V_k + sum_{i!=k}{X_ki + lambda_i^D*g(nu)}]/m,
```

where `X_ki` already weights the accepted low-only and pooling components of
`F_i`. This preserves asymmetric packages and recognition identities.

At `nu=0`, final passage with H has probability one and delay has probability
`D`. Conditional H payoffs are

```text
H_0=(1/m)*sum_i[
  lambda_i^L*E(y_i|L)+lambda_i^P*E(y_i|P)+lambda_i^D*beta*o_0],

H_1=(1/m)*sum_i[
  lambda_i^L*beta*o_1+lambda_i^P*E(y_i|P)+lambda_i^D*beta*o_1].
```

For `0<nu<=nu_2`, low-only is unavailable in R1. A delayed proposal enters the
low-only N2 record, so

```text
pass_with_H = 1-D*nu,
failure     = D*nu,
delay       = D,

H_0=(1/m)*sum_i[lambda_i^P*E(y_i|P)+lambda_i^D*beta*o_0],
H_1=(1/m)*sum_i[lambda_i^P*E(y_i|P)+lambda_i^D*beta*o_1].
```

For `nu>nu_2`, delayed proposals enter pooling N2. Final passage with H has
probability one, failure is zero, delay is `D`, and both H types receive

```text
(1/m)*sum_i[lambda_i^P*E(y_i|P)+lambda_i^D*beta*o_1].
```

Unanimity never passes without H.

## 11. P0, coverage, and substantive result

P0 is refuted as universal. Because every exact null proposal may induce a
different ballot belief and pure response map, assigning apparent slack to the
proposer changes the proposal and can trigger a punishment. Accepted and delay
maximizers with `y+sum_j x_j+r_i<1` therefore survive in the correspondence.
The forced boundary packages use the full pie, but full use is not universal.

The six exhaustive cells are

```text
m=2,   nu=0
m=2,   0<nu<=nu_2
m=2,   nu_2<nu<=1
m>=3,  nu=0
m>=3,  0<nu<=nu_2
m>=3,  nu_2<nu<=1.
```

Every cell has a nonempty correspondence. Pooling exists in every cell. Delay
exists conditionally on `k2<=g(nu)` for `m=2` and universally for `m>=3`.
Low-only R1 passage exists only at `nu=0`. No pure separating R1 branch exists
at positive prior. The correspondence is set-valued over packages, proposal
laws, constructive ballot subfamilies, off-path beliefs, within-identity ties,
and cross-identity products.

The paper's strongest universal interpretation does not follow: unanimity does
not force delay, screening, or a unique informational rent in every parameter
cell. It instead generates a large assessment-dependent equilibrium
correspondence. This conclusion is preserved rather than repaired by an
additional weak-vote-passive assumption.

## 12. Review status and invalidation

This candidate remains `pending`. It consumes only the exact frozen N2 hash.
Any change to that hash, the governing contract, the ballot solution concept,
the pointwise zero-probability proposal rule, or the proposal-level tie-break
invalidates the candidate. N4 may become `pass/frozen` only after the same
interface hash receives independent `formal_design` and `game_theory` PASS
verdicts with `0/0/0` findings.
