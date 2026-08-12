# Collective entry under majority

## Scope and frozen input

This node lifts the frozen majority Round-1 correspondence into the collective
entry decision. It consumes the exact artifacts

```text
Gate 0 bundle   sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1
R1 batch        sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a
C1 majority     sha256:21c3a9dd2d6c9d25450978c2f7d9925af02e478b9c03d421d2a7b0f9aa2c77c9
```

No R1 or C2 object is rederived, repaired, or scalarized. The admissible
population is `N=m+1>=3`. Every C1 payoff is already in Round-1 units, so this
node applies no further discount.

The weak states face one collective, all-or-nothing formation decision before
they observe `theta`. If they form, every weak identity pays the external sunk
cost `chi>=0`. If they do not form, every weak state receives zero and H type
`theta` receives `o_theta`. Equality selects formation. This is a collective
formation device evaluated by the average weak payoff, not a set of unilateral
identity-level participation decisions.

## 1. The assessment-level value operator

Fix a complete admissible C1-M assessment

```text
alpha=(alpha_1,...,alpha_m) in A_M(h1).
```

The coordinate `alpha_i` is the complete assessment conditional on weak
identity `i` being recognized. It includes `sigma_i`, proposal-contingent
beliefs, all ballot actions and completions, posteriors, action-specific C2
selections, type-by-identity payoffs, gifts, inclusion and opt-out status, full
histories, and outcome distributions.

For each `i`, first integrate every player and type coordinate over
`sigma_i`. Then average over uniform recognition:

```text
C1_M,k^alpha(theta|h1)=(1/m) sum_i U_k^{i,theta}(alpha_i).       (1)
```

For each named weak identity `j`, integrate the true type distribution:

```text
C1_M,Wj^alpha(mu|h1)
  =(1-mu) C1_M,Wj^alpha(0|h1)
   +mu C1_M,Wj^alpha(1|h1).                                    (2)
```

Finally average across the `m` weak identities:

```text
V_W^M(alpha,mu)
  =(1/m) sum_j C1_M,Wj^alpha(mu|h1).                            (3)
```

Equivalently, define the type-specific aggregate

```text
T_W^M(alpha,theta)=sum_j C1_M,Wj^alpha(theta|h1).
```

Then

```text
V_W^M(alpha,mu)
  =[(1-mu)T_W^M(alpha,0)+mu T_W^M(alpha,1)]/m.                  (4)
```

Equations (3) and (4) coincide by finite-sum linearity. The canonical
computational order is `E_sigma -> recognition -> type -> cross-weak`. This
order preserves every named identity through all upstream expectations. It
never averages across distinct assessments.

## 2. Exact entry lift

For the fixed complete assessment `alpha`, define

```text
N_W^M(alpha,mu,chi)=V_W^M(alpha,mu)-chi.
```

The collective rule is

```text
form(alpha) iff V_W^M(alpha,mu)>=chi.                            (ENTRY-M)
```

At equality the institution forms. Conditional on formation, every named
weak identity and H receive

```text
E_M,Wj^alpha(theta)=C1_M,Wj^alpha(theta|h1)-chi,
E_M,H^alpha(theta) =C1_M,H^alpha(theta|h1).                      (5)
```

The complete type-conditional C1 outcome distribution is inherited without
change and receives only two new coordinates: `entry_status=formed` and an
external cost ledger recording `chi` for each weak identity. The cost does not
reduce the institutional pie, alter a gift, transfer to H, enter a ballot IC,
or receive `beta`. Because the decision criterion is collective, a particular
identity's net payoff in (5) may be negative; it is retained rather than
truncated or converted into an unstated individual veto.

Conditional on nonformation,

```text
E_M,Wj(theta)=0 for every j,
E_M,H(theta)=o_theta.                                           (6)
```

No proposal, ballot, R1 continuation, or R2 continuation is realized.

### Proposition 1 (exact entry correspondence)

Let `A_M(h1)` be the full frozen C1-M assessment correspondence. The entry
correspondence consists exactly of one object for every whole
`alpha in A_M(h1)`: retain `alpha`, calculate (1)--(4), apply (ENTRY-M), and
attach the payoffs and outcomes in (5) or (6).

**Proof.** Any PBE of the entry-augmented game specifies a complete C1-M
continuation assessment following formation, including when formation is off
path. Sequential rationality of the collective decision requires formation
exactly when its average continuation payoff net of `chi` is nonnegative,
with formation at equality. This proves necessity. Conversely, any frozen
C1-M assessment is sequentially rational in its continuation game. Pairing it
with the action prescribed by (ENTRY-M) makes the collective entry action
optimal, and (5)--(6) are the primitive payoff map. This proves sufficiency.
QED.

The proposition does not select an assessment by its bound, proposer payoff,
or entry status. It preserves the entire `alpha` on both sides of the entry
comparison.

## 3. Selection-free envelope and exact cost regions

Define the nonempty value set and its endpoints

```text
S_M(mu) ={V_W^M(alpha,mu): alpha in A_M(h1)},
v_M^-   =inf S_M(mu),
v_M^+   =sup S_M(mu).
```

Let `a_M^-` and `a_M^+` indicate whether some complete assessment attains the
respective endpoint. Attainment is recorded only when proved; it is not
inferred from the existence of a supremum.

### Proposition 2 (resource envelope)

For every admissible primitive vector,

```text
0<=v_M^-<=v_M^+<=1/m.                                          (7)
```

For every `N>=4`,

```text
v_M^+=1/m and a_M^+=true.                                      (8)
```

No universal exact lower endpoint or lower-attainment claim follows from the
frozen C1-M interface. At `N=3`, neither endpoint may be read from the
recognized-proposer projection.

**Proof.** On PR04, aggregate weak gross payoff is `1-y`; on PR06 it is one.
On PR05 and PR07, the selected C2 allocation has aggregate weak payoff between
zero and one in native R2 units and is multiplied by `beta<=1` exactly once.
Thus every realized R1 branch has aggregate weak gross payoff in `[0,1]`.
Proposal mixing, ballot integration, uniform recognition, and type integration
preserve the interval. Division by `m` proves (7). For `N>=4`, the frozen C1-M
value-one construction gives the recognized proposer one, every other weak
state zero, and current passage in every type. Its aggregate weak payoff is
one before and after recognition, so it attains `1/m`. Combined with (7), this
proves (8). QED.

The exact assessment-level classification is

| Region | Necessary and sufficient condition |
|---|---|
| all assessments form | `chi<=v_M^-` |
| formation is possible | `chi<v_M^+`, or `chi=v_M^+` and `a_M^+=true` |
| nonformation is possible | `chi>v_M^-` |
| all assessments choose no | `chi>v_M^+`, or `chi=v_M^+` and `a_M^+=false` |

At `chi=v_M^-`, all assessments form regardless of lower-endpoint attainment:
every element of the set is at least its infimum and equality forms. At
`chi=v_M^+`, by contrast, formation requires actual upper-endpoint attainment.
This is the only nonattainment-sensitive boundary in the four classifications.

Immediate selection-free implications are:

- `chi=0`: every assessment forms;
- `chi>1/m`: every assessment chooses no;
- `N>=4, chi=1/m`: formation is possible through the attained value-one
  assessment.

No stronger common assessment selection is supplied here.

## 4. Why proposer projections cannot classify entry

The scalar results frozen in C1-M concern the recognized proposer's payoff,
not (3). The distinction survives every proposer and H tie-break.

Consider the frozen counterexample

```text
N=3, beta=.5, o_0=0, o_1=.8, mu=.9.
```

The recognized-proposer projection is `[.325,.75]`. At its lower endpoint,
the two separating proposals

```text
(y,x)=(0,0),     with the other weak state voting no;
(y,x)=(0,.675),  with the other weak state voting yes
```

both give the proposer `.325` and H `.72`, so the frozen tie-break retains
both and permits their mixture. Under the first signature, type 0 yields a
current agreement with aggregate weak payoff one, while type 1 reaches the
weak-only continuation with discounted aggregate weak payoff `.5`. Therefore

```text
T_W ex ante=.1(1)+.9(.5)=.55,  V_W=.55/2=.275.
```

Under the second signature, current passage allocates the full institutional
pie to weak states in both types, so `V_W=1/2`. Mixing the double-tied
signatures preserves proposer payoff `.325` and H payoff `.72` while spanning
collective values `[.275,.5]`. Hence even a fixed proposer payoff plus the H
tie-break does not identify entry.

The same accounting explains why the proved `[0,1]` proposer projections do
not yield `[0,1/m]` collective-value projections. Their displayed construction
sets `y=0`, gives gifts totaling `1-V`, and passes currently. The proposer and
the other weak states jointly receive one for every `V`, so every member of
that proposer-payoff continuum maps to the same collective value `1/m`.

## 5. Status and invalidation

This artifact is a candidate pending independent read-only review. Its R
verifier checks the exact frozen bytes and transitive components, but does not
require the historical R1-batch readiness snapshot to remain unchanged after
the entry nodes have legitimately started. It also checks asymmetric identity
and proposal-mixing fixtures, operation order, equality, external costs,
nonformation, endpoint logic including an unattained supremum, the resource
envelope, the `N>=4` upper endpoint, and the `N=3` negative shortcut.

Any byte change to Gate 0, the R1 batch, C1-M, or a frozen transitive component
invalidates this node and every descendant. Reviewers must audit the exact
candidate hash and remain read-only.
