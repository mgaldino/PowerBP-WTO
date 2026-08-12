# Collective entry under unanimity

## Status and frozen inputs

- Node: `entry_unanimity`.
- Solution concept: Perfect Bayesian equilibrium (PBE).
- Status: candidate, pending independent read-only review.
- Repair of rejected notation/documentation candidate:
  `sha256:efa5933adba180bff9d1c8ffd6ff6c53b7dc5345de72b14f088a7dd2542553e8`.
- Validated population domain: every primitive-admissible `N>=3` case.
- Frozen Gate 0 bundle:
  `sha256:6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
- Frozen R1 batch:
  `sha256:f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a`.
- Frozen C1-U interface:
  `sha256:37aae1bfe7921c6c90aff5d05ed301f8729c2b899477991619bcf0cb6c96e8b5`.

This node applies the collective formation primitive to the complete frozen
C1-U correspondence. It does not rederive a Round-1 or Round-2 strategy,
change an assessment, select an equilibrium by a bound, or import a historical
entry formula. All bargaining payoffs already use Round-1 units, so this node
applies no further discount.

## 1. Primitive and information at entry

Write `m=N-1`. Nature draws the persistent type `theta in {0,1}` before
formation. The weak coalition does not observe `theta`. It makes one
collective, all-or-nothing formation decision before the Round-1 recognition
draw. If it forms, every weak state pays the same external sunk cost
`chi>=0`. The cost does not reduce the unit bargaining pie. If it does not
form, every weak state receives zero, type `theta` of `H` receives `o_theta`,
and the terminal outcome is nonformation.

The collective action is therefore the same in both realized types. It is not
an individual participation vote. Under an identity-asymmetric bargaining
assessment, formation can be collectively optimal even when one weak identity
or one realized type obtains a negative net payoff.

Fix the public history and primitives, including the prior `mu`. Let
`A_U(P)` denote the nonempty set of complete C1-U assessments exported by the
frozen unanimity interface. An element `alpha in A_U(P)` includes one complete
recognized-proposer PBE element for every possible Round-1 weak recognizer,
with all proposal strategies, ballot strategies, beliefs, payments,
continuation selections, type-by-player payoffs, and terminal-outcome kernels.

## 2. Dependency-safe integration

For recognized weak proposer `i`, the frozen interface first integrates over
that proposer's proposal strategy `sigma_i`. For each type and weak identity,
write the resulting coordinate as

```text
E_sigma_i[U_Wk^i(theta;alpha_i)].
```

The corresponding H payoff and terminal-outcome kernel are integrated using
the same `sigma_i` and the same assessment element. Uniform recognition is
then applied, separately by type and player identity:

```text
C1_W_alpha(theta,k)
  = (1/m) sum_i E_sigma_i[U_Wk^i(theta;alpha_i)],

C1_H_alpha(theta)
  = (1/m) sum_i E_sigma_i[U_H^i(theta;alpha_i)].
```

The type-conditional outcome kernel `D1_alpha(theta)` uses the same order and
the same selection. Equal scalar payoffs do not permit payoff coordinates and
outcome coordinates to be taken from different assessments.

Only after these type-by-identity C1 objects have been constructed define

```text
T_W_alpha(theta) = sum_k C1_W_alpha(theta,k).
```

The gross value per weak state relevant to collective formation is

```text
G_U(alpha,mu)
  = [(1-mu) T_W_alpha(0) + mu T_W_alpha(1)] / m.
```

Thus the dependency-safe order is:

```text
proposal support under sigma_i
  -> E_sigma_i by type and identity
  -> uniform recognition by type and identity
  -> T_W_alpha(theta)
  -> prior average
  -> division by m
  -> subtraction of external chi.
```

The operations happen to be linear, but retaining the intermediate objects is
essential. Collapsing identities early would lose the realized payoff vector;
splicing type or outcome coordinates could combine different alphas; and
subtracting `chi` inside bargaining would change the game.

## 3. Assessment-level entry operator

Define the net collective value

```text
Z_U(alpha,mu,chi) = G_U(alpha,mu) - chi.
```

The assessment-level action is

```text
e_U(alpha,mu,chi) = 1{G_U(alpha,mu) >= chi}.
```

Here `e_U=1` means form. Equality forms exactly as specified in Gate 0.

### Proposition 1 (entry action for a fixed assessment)

For every complete `alpha in A_U(P)`, the unique collective entry action is
formation if and only if `G_U(alpha,mu)>=chi`.

**Proof.** Conditional on formation, the collective primitive evaluates the
average expected weak payoff as `G_U`; every weak state then pays the external
cost, so the average net payoff is `G_U-chi`. Nonformation gives the weak
coalition zero. A strictly positive net value selects formation, a strictly
negative value selects nonformation, and the stated equality convention
selects formation at zero. Because the coalition does not observe `theta`,
the comparison integrates the two type rows using `mu` and produces one
action for both realized types. No bargaining strategy is changed. QED.

## 4. Realized payoffs and outcomes

If `alpha` induces formation, realized type-by-identity weak payoffs are

```text
u_entry_Wk(theta;alpha) = C1_W_alpha(theta,k) - chi,
```

and the type-conditional weak total is

```text
sum_k u_entry_Wk(theta;alpha) = T_W_alpha(theta) - m*chi.
```

The hegemon and outcome coordinates are

```text
u_entry_H(theta;alpha) = C1_H_alpha(theta),
D_entry_alpha(theta)   = D1_alpha(theta).
```

The external cost is recorded as a payoff overlay for every weak identity. It
does not change `D1_alpha`, payments, proposal feasibility, or H's payoff.

If `alpha` induces nonformation, then for both types

```text
u_entry_Wk(theta;alpha) = 0 for every k,
u_entry_H(theta;alpha)  = o_theta,
D_entry_alpha(theta)    = delta_nonformation.
```

The ex-ante outcome distribution is always formed only at the last step:

```text
(1-mu) D_entry_alpha(0) + mu D_entry_alpha(1).
```

The gross counterfactual value `G_U` and the complete `alpha` remain recorded
even when formation does not occur. They rationalize the entry action and
specify every off-path bargaining history required by PBE.

## 5. Exact set-valued entry correspondence

Define the gross-value image

```text
Gset_U(P,mu)
  = {G_U(alpha,mu) : alpha in A_U(P)}.
```

Let `Entry_U(alpha,mu,chi)` be the complete record containing:

1. the unchanged assessment index and payload `alpha`;
2. `G_U`, `Z_U`, and the form/no-form status;
3. both type rows of every weak identity's realized payoff;
4. both H type payoffs; and
5. the aligned type-conditional and ex-ante outcome distributions.

The entry correspondence is

```text
E_U(P,mu,chi)
  = {Entry_U(alpha,mu,chi) : alpha in A_U(P)}.
```

Its coarse status projection is

```text
S_U(P,mu,chi)
  = {form    : some alpha has G_U(alpha,mu)>=chi}
    union
    {no_form : some alpha has G_U(alpha,mu)<chi}.
```

### Proposition 2 (exactness and alpha preservation)

`E_U` is the exact entry correspondence induced by frozen C1-U on its full
`N>=3` domain. It is nonempty. It cannot in general be replaced by its gross
value set or status projection.

**Proof.** Frozen C1-U proves existence and attainment of at least one
complete Round-1 PBE assessment for every primitive-admissible `N>=3` case.
Proposition 1 maps each such `alpha` to its unique sequentially rational
collective entry action. If formation occurs, its continuation is exactly
`alpha`; if it does not occur, `alpha` supplies the complete off-path
bargaining assessment. Conversely, any entry PBE induces a complete
counterfactual C1-U assessment and its collective action must obey Proposition
1. This establishes equality, not merely inclusion.

Different alphas can have the same `G_U` while assigning weak rents to
different identities, giving H different type payoffs, or producing different
outcome distributions. Removing `alpha` would therefore remove payoff- and
outcome-relevant equilibrium multiplicity. QED.

## 6. Infimum, supremum, and endpoint attainment

The frozen C1-U bounds imply, for every `alpha` and type,

```text
0 <= C1_W_alpha(theta,k),
0 <= T_W_alpha(theta) <= 1.
```

Consequently `Gset_U` is a nonempty bounded subset of `[0,1/m]`. Define

```text
L_U(P,mu) = inf Gset_U(P,mu),
U_U(P,mu) = sup Gset_U(P,mu).
```

Both real endpoints exist. Boundedness does not imply that either endpoint is
attained. This matters because the frozen continuation architecture contains
nonclosed value boundaries.

The general C1-U interface does not supply closed-form numerical endpoint
functions or a general upper-attainment theorem. For `N=3`, it also does not
prove a general lower-attainment theorem. These facts are recorded as pending,
not filled by the coarse interval `[0,1/m]`.

To avoid any collision with the assessment set `A_U(P)`, denote endpoint
attainment by the distinct indicators

```text
a_U^- = 1 iff some alpha has G_U(alpha,mu)=L_U,
a_U^+ = 1 iff some alpha has G_U(alpha,mu)=U_U.
```

There is one useful exact special result. Frozen C1-U contains, for every
`N>=4`, a complete assessment giving every weak identity zero in both types.
Together with nonnegativity, this proves

```text
N>=4: L_U=0 and a_U^-=1.
```

This is a property of an explicit frozen assessment, not an assumption that
the entire interval is attainable.

## 7. Selection-free formation logic

### Proposition 3 (complete endpoint logic)

For every primitive-admissible case:

```text
all_form
  iff L_U >= chi;

possible_form
  iff chi < U_U
      or [chi=U_U and a_U^+=1];

possible_no_form
  iff L_U < chi;

all_no_form
  iff U_U < chi
      or [chi=U_U and a_U^+=0].
```

**Proof.** All assessments form exactly when every element `g` of `Gset_U`
satisfies `g>=chi`, which is equivalent to `inf Gset_U>=chi`. Some assessment
does not form exactly when some `g<chi`, equivalent to `inf Gset_U<chi`.

If `chi<U_U`, the definition of supremum guarantees an element strictly above
`chi`, hence formation is possible. If `chi>U_U`, no element reaches `chi`.
At `chi=U_U`, formation is possible exactly when the supremum belongs to the
set. Negating that statement gives the all-no condition. QED.

Two equality cases deserve emphasis.

- At `chi=L_U`, every assessment forms, whether or not the infimum is
  attained. Every value is at least its infimum, and equality forms.
- At `chi=U_U`, some assessment forms if and only if the supremum is attained.
  If it is not attained, every value is strictly below the cost and every
  assessment chooses nonformation.

If `L_U=U_U=chi`, nonemptiness implies that the value set is the attained
singleton `{chi}`. Every assessment forms and no assessment chooses
nonformation.

## 8. Direct selection-free bounds and cost regions

The type-specific total bound yields directly

```text
0 <= G_U(alpha,mu) <= 1/m,
-chi <= G_U(alpha,mu)-chi <= 1/m-chi.
```

When formation occurs, each weak identity and the total weak coalition obey

```text
-chi <= C1_W_alpha(theta,k)-chi <= 1-chi,
-m*chi <= T_W_alpha(theta)-m*chi <= 1-m*chi.
```

These are payoff bounds, not an assertion that their endpoints are feasible.
They give the following selection-free conclusions:

1. `chi=0`: every assessment forms, including any zero-value assessment by
   equality.
2. `chi>1/m`: every assessment chooses nonformation.
3. `chi=1/m`: formation is possible only if a complete alpha attains the
   bound `G_U=1/m`; otherwise every assessment chooses nonformation.
4. `0<chi<1/m`: the coarse bounds alone do not classify the correspondence.
5. For `N>=4` and every `chi>0`, the attained zero-value assessment chooses
   nonformation. Thus nonformation is possible and all-form is false. Whether
   formation is also possible depends on the upper endpoint and its attainment.

No zero-value assessment is asserted for general `N=3` primitives. A consumer
must use the exact C1 image or a separately proved sharper result.

## 9. Primitive boundaries and domain

The operator uses the full common C1-U existence domain:

```text
integer N>=3,
mu in [0,1],
0<=o_0<o_1<=y_bar<=1,
beta in (0,1],
chi>=0.
```

It includes `N=3`, degenerate priors, `o_0=0`, `o_1=y_bar`, `y_bar=1`,
`beta=1`, `chi=0`, `chi=1/m`, and costs above `1/m`. Degenerate priors retain
both type coordinates because the complete assessment and counterfactual
payoffs remain part of the interface. The entry operator does not add a new
use of `beta`; it consumes C1 in native Round-1 units.

## 10. Sufficiency boundary

The frozen C1-U payload is sufficient for:

- the exact alpha-preserving entry correspondence;
- every assessment-level entry decision;
- realized type-by-identity weak and H payoffs;
- aligned outcome distributions;
- exact endpoint-conditional formation logic; and
- the general bounds and `N>=4` zero lower endpoint proved above.

It is not sufficient for a general closed-form formula for `L_U`, `U_U`, or
upper attainment. This does not block the exact set-valued entry operator.
Any later claim of numeric endpoint functions, an attained interval
`[0,1/m]`, or a bound-selected alpha would require reopening or further solving
C1-U. None is claimed here.

## 11. Mechanical validation executed

The companion R verifier completed with **37/37 PASS**. It generated 72
full-assessment fixture rows, 48 realized type-by-identity payoff rows, and
seven endpoint-logic cases; exercised three dependency mutation guards; and
confirmed all 27 protected hashes. Specifically, it checked:

- all three exact dependency hashes and mutation failures for C1-U and the R1
  batch freeze;
- every protected file in the 27-file manifest;
- synthetic full-vector alphas with all recognizers, both types, every weak
  identity, proposal-support mixing, H coordinates, and outcome kernels;
- `E_sigma`, recognition, type, and weak-average integration against manually
  computed values;
- identity asymmetry and two distinct alphas with equal gross value;
- external-cost accounting, equality formation, nonformation payoffs, and
  aligned H/outcome coordinates;
- exact finite-correspondence preservation;
- symbolic attained and unattained endpoint cases;
- `N>=3` and every listed primitive boundary; and
- negative mutations that scalarize identities, change averaging, put cost in
  the pie, default endpoint attainment, or rediscout C1.

Numerical fixtures check the operator. They do not replace Propositions 1--3.

## 12. Claim ledger

| Claim | Status |
|---|---|
| Assessment-level formation operator | proved |
| Type-by-identity realized payoff and outcome map | proved |
| Exact alpha-preserving entry correspondence | proved |
| Complete infimum/supremum boundary logic | proved |
| General gross bound `[0,1/m]` | proved from frozen C1-U |
| `N>=4` lower endpoint zero and attained | proved from frozen C1-U |
| General `N=3` endpoint values/attainment | pending; not claimed |
| General upper endpoint value/attainment | pending; not claimed |
| Closed-form entry regions | pending; not claimed |
| Historical entry formulas as inputs | rejected |
| Mechanical fixture audit | checked numerically: 37/37 PASS |
| Independent formal acceptance | pending |

Any byte change to Gate 0, the R1 batch, or C1-U invalidates this candidate.
This implementer does not mark the node PASS.
