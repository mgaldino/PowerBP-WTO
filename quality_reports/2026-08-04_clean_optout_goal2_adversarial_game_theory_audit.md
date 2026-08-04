# Independent Adversarial Game-Theory Audit — Goal 2

**Date:** 2026-08-04
**Reviewed commit:** 1b8bda6fb6906391c65fb6425b781c123d5948be
**Review mode:** independent and read-only
**Rmd SHA-256:** 131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d
**PDF SHA-256:** a7d36d5a1fb2d15ba0e40509ad846fbf001b5960232fcbf011d5b32bec298bdf

## Verdict

**PASS — no substantive reservation.**

No critical, medium, or minor substantive issue survived adversarial testing.
The timing, simultaneous-ballot incentives, terminal subgames, off-path
completion, regular unanimity theorem, majority correspondence, boundaries,
endpoint limits, and conditional institutional comparison are internally
coherent under the stated weak-PBE solution concept.

## Adversarial checklist

| Test | Verdict | Main conclusion |
|---|---:|---|
| Timing and information sets | PASS | Immediate H-no opt-out is distinct from H-yes followed by weak-caused failure. |
| Simultaneous-ballot incentive constraints | PASS | R1 incentives integrate over simultaneous votes; no voter conditions on an unrevealed ballot. |
| Terminal subgames | PASS | Unanimity and majority values use the correct weak approval and terminal outside payoffs. |
| Off-path completion and guarantees | PASS | Upper-bound completion and reverse guarantees survive one-rejector, multiple-rejector, and mixed-ballot stress tests. |
| Regular unanimity theorem | PASS | `beta*o1 >= o0` and `G_P > G_L` have the stated necessity and sufficiency roles; equality fails under the stated proposer tie-break. |
| Majority security value | PASS | Exclusion, low-only, and pooling guarantees imply `F_M=max{E,B_M,P}`. |
| Majority group sizes | PASS | The `N=3`, `N=4`, and `N>=5` distinctions follow from quota geometry. |
| Boundary propositions | PASS | `o0=0`, `o1=1`, and `beta=1` are separate; majority boundary expressions remain bounds. |
| Endpoint limits | PASS | One-sided cluster correspondences are not misdescribed as degenerate-prior PBEs. |
| Entry and hegemon bounds | PASS | Entry nesting is selection-free on common existence; H remains between expected outside payoff and `o1`. |
| Equilibrium scope | PASS | Weak PBE is distinguished from sequential equilibrium; there is no unrestricted-PBE uniqueness claim. |
| Legacy leakage | PASS | No old threshold, delayed opt-out, global P/L/R, C-B-R, positive `pi_H`, or endogenous-rule architecture enters a baseline theorem. |
| Final layout delta | PASS | The page-16 TSV-path repair changes no mathematical object. |

## Key stress tests

The reviewer reconstructed the Round-1 hegemon and weak-voter incentive
constraints from the simultaneous ballot rather than using an ex post pivotal
cutoff. For rejected histories, the reviewer attacked both directions of the
completion lemma with one weak rejection, multiple weak rejections, and
ballot mixing. The same exercise was repeated against the `N=3`, `N=4`, and
`N>=5` majority cases, including the `N=4` unattainability region and the
large-group payoff interval.

The review also checked the regular/boundary separation and the one-sided
prior limits. It found no hidden continuation after an H-no, no endogenous
rule choice, no recognition probability for H, and no claim that the selected
assessment characterizes every PBE.

## Deliberate limitation

The completion construction uses the off-path belief freedom available under
weak PBE. The manuscript correctly does not claim sequential-equilibrium
robustness. Majority boundary formulas are correctly presented as bounds,
not as complete boundary equilibrium correspondences. These are disclosed
scope limits, not reservations on the baseline result.
