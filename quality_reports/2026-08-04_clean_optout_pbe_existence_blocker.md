# Clean immediate-opt-out PBE existence audit

**Date:** 2026-08-04

**Final analytical status:** the initial global nonexistence claim was
`REPAIR`. The corrected result is a set of endogenous PBE-existence
conditions, not a global blocker and not a protocol change.

**Editing separation:** the root implementer records this report. Three
read-only derivation agents independently rederived and challenged the result:
`/root/unanimity_deriver`, `/root/majority_deriver`, and
`/root/comparison_deriver`.

## Initial finding

The first audit considered the off-path R1-unanimity proposal

```text
y = o1
x_j = 0 for every non-proposing weak voter
```

and treated a low-type H-yes vote followed by failure as necessarily revealing
the low type. That would make its continuation payoff `beta*o0<o0` and leave
the ballot without a sequentially rational response.

## Substantive repair

The proposal is globally off path. Under the weak PBE specified by the Goal,
Bayes is mandatory on path, while a zero-probability continuation posterior is
a declared component of the assessment. Weak-vote-passive prevents a weak vote
from becoming a direct signal; it does not impose sequential-equilibrium
consistency after every globally off-path proposal.

If `beta*o1>=o0`, an off-path posterior that selects R2 pooling gives low-type
H continuation `o1`. Exactly one underpaid weak voter can then reject, low H
votes yes, high H opts out, and the rejector strictly values the positive R2
continuation. The original proof therefore did not establish nonexistence on
the whole regular domain.

## Corrected unanimity theorem

For

```text
mu in (0,1)
beta in (0,1)
0 < o0 < o1 < 1
```

define

```text
m     = N - 1
P     = 1 - o1
delta = beta*(m - 1)/m
a     = 1 - delta
D_U   = 1 - o0 - delta*P
G_P   = a*P
G_L   = (1 - mu)*D_U
```

A global unanimity PBE exists if and only if

```text
beta*o1 >= o0
and
G_P > G_L
```

The strict inequality is essential. When it holds, the on-path outcome is
pooling and the weak total is `P`. When it fails, an off-path low-inclusion
proposal gives the proposer a security payoff that cannot be attained after
the same proposal becomes on path and Bayes raises the weak approval price.
This payment-shaving discontinuity destroys the fixed point. Thus regular
low-only is not a PBE.

The case `o1=1` with `o0>0`, `beta<1`, and an interior prior also has no PBE.
The loci `o0=0` and `beta=1` instead restore existence and create
multiplicity; they are separate boundary propositions.

## Corrected majority theorem

Let

```text
q   = floor(N/2) + 1
k   = q - 1
c   = beta/m
E   = 1 - k*c
B_M = (1 - mu)*(1 - o0) + mu*c
P   = 1 - o1
F_M = max(E, B_M, P)
```

The exact regular security value is `F_M`.

- For `N=3`, PBE always exists and the proposer receives `F_M`.
- For `N=4`, PBE exists iff `E>=B_M` or `P>B_M`. It does not exist when
  `B_M>E` and `B_M>=P`, including `B_M=P>E`.
- For `N>=5`, PBE always exists and proposer payoffs span `[F_M,1]`.
  Exclusion, separating current passage, and canonical pooling can each occur
  under their stated payoff conditions.

The historical No-Cheap-H condition `o0>=beta/m` is not the uniform
weak-PBE condition. Uniform exclusion against the off-path guarantee requires
`o0>=(q-1)*beta/m`. Even that stronger condition does not eliminate
separating current passage for `N>=5`.

## Consequence for the operational Goal

No protocol decision was made inside a proof. The literal game is preserved.
The clean baseline is reported with:

- explicit nonexistence regions;
- a derived common PBE domain for institutional comparison;
- boundary multiplicity separated from the regular theorem;
- no claim of global PBE existence, historical P/L/R reduction, or majority
  no-screening.

On the common regular domain, unanimity pools and gives weak total `P`.
Every majority PBE gives weak total at least `F_M>=P`, so collective formation
nesting survives selection-free. H receives `o1` under unanimity and an
expected payoff between its outside payoff and `o1` under majority. These are
conditional results, not global dominance statements.

The superseded global blocker was not promoted. Its correction is incorporated
in `model_redesign/power_architecture_derivations.Rmd` and is subject to the
final independent formal and adversarial reviews.
