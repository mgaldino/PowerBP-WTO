# Consolidated Formal-Model Review — Goal 3

**Date:** 2026-08-04
**Reviewed candidate:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`
**Artifact:** `model_redesign/undominated_voting_rederivation.Rmd`

## Editorial decision

**PASS — no substantive reservation after repair and full rereview.**

The autonomous derivation now gives a coherent PBE-UD treatment of a
simultaneous sealed ballot. It does not import a roll-call protocol or make a
voter condition on ballots not yet observed. The distinction between local
weak dominance, sequential rationality, beliefs, and proposer optimality is
explicit throughout.

| Dimension | Assessment | Verdict |
|---|---:|---|
| Model design | 8/10 | PASS |
| Technical presentation | 9/10 | PASS after repair |
| Exposition | 8/10 | PASS |
| Reproducibility and visual presentation | 9/10 | PASS |

The key conceptual repair is the two-layer reporting demanded by the economic
interpretation of a distributed pie:

1. unrestricted PBE-UD retains every feasible proposal and deviation;
2. the coalition-pure baseline retains only inclusion-minimal winning support,
   gives weak outsiders zero, and protects each necessary supporter at its
   continuation value.

This is transparent selection, not an unsupported claim that weak PBE alone
forces a minimum coalition. It also avoids making an inefficient gift disappear
from the proposer optimality condition.

Initial reviewers found genuine omissions involving terminal attainment,
partial weak passage, `N=3` gifts, and the general cap residual. Each issue was
repaired by the implementer. Three fresh final passes—BF/formal, adversarial
game theory, and R/reproducibility/PDF—then reviewed the same exact commit and
returned PASS without substantive reservation.

Optional exposition improvements belong to Goal 4: compress the unrestricted
pathologies in the main text, place the coalition-pure interpretation before
the first equilibrium result, and reserve the full gift diagnostics for the
appendix. They are not blockers on the autonomous derivation.
