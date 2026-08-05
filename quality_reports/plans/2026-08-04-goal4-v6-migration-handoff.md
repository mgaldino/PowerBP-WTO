# Goal 4 Handoff — Controlled Migration to formal_model_v6.Rmd

**Date:** 2026-08-04
**Status:** BLOCKED; DO NOT USE FOR MIGRATION
**Source candidate:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`

## Decision boundary

The user adopted `T^Y` on 2026-08-05: accept at exact outside/continuation
value. Terminal R2 must be solved without `beta`, and only an R2 continuation
entering R1 is discounted. Goal 3's reviewed candidate used a different
equality treatment. Therefore this handoff is historical and cannot authorize
editing or compiling `formal_model_v6.Rmd`. Before any Goal 4, a new standalone
Gate 0 and full rederivation must close the interaction between `T^Y` and
PBE-UD. See
`quality_reports/2026-08-05_goal3_accept_at_equality_pending.md`.

## Historical governing inputs — do not use for migration

1. `model_redesign/undominated_voting_rederivation.Rmd`;
2. `quality_reports/2026-08-04_undominated_voting_impact_matrix.md`;
3. `quality_reports/2026-08-04_undominated_voting_goal3_status.md`;
4. the three final independent Goal 3 reviews;
5. protected v6 SHA-256
   `131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d`.

## Historical migration order — superseded

1. Verify a clean worktree, protected hashes, and the Goal 3 closure commit.
2. Create the pre-migration version marker without tagging a dirty state.
3. Insert the PBE-UD definition, local dominance lemmas, and coalition-pure
   baseline selection before any result is replaced.
4. Replace terminal unanimity and majority results and proofs.
5. Replace R1 unanimity and majority results, including the separate `N=3`
   correspondence and attainment conditions.
6. Replace entry, formation, `H` ranking, boundaries, endpoints, and notation.
7. Revise abstract, introduction, result preview, discussion, conclusion,
   tables, and captions only after the mathematics is integrated.
8. Compile with the YAML/bookdown format, run migration validators, and inspect
   every PDF page.
9. Obtain fresh independent formal, adversarial, and reproducibility/PDF
   reviews. The implementer must not review.

## Preserved constraints for the future rederivation

- No intraballot public or sequential voting and no order of `H`.
- Baseline outcomes are coalition-pure: minimal winning support and zero for
  weak outsiders.
- Gift proposals remain feasible deviations and must remain in proposal
  optimality checks.
- The intended bargaining convention is `T^Y`: accept at exact
  outside/continuation value. A new Gate 0 must settle how this primitive
  interacts with PBE-UD before any theorem is promoted.
- Do not transport the old unrestricted PBE-UD versus coalition-pure split
  without rederiving it under `T^Y`.
- Do not reuse the old `P/L/R`, `F_M`, No-Cheap-H, feasibility/C-B-R, delayed
  continuation, or positive-`pi_H` architecture without a new proof.
- Keep institutional comparisons conditional on common equilibrium existence.

## Superseded opening prompt — do not execute Goal 4

```text
Não execute o Goal 4. Reabra primeiro a derivação autônoma do Goal 3 sob a decisão registrada em quality_reports/2026-08-05_goal3_accept_at_equality_pending.md: adote T^Y como primitivo de aceitação na igualdade, resolva R2 em unidades correntes sem beta e use beta*C_2 apenas quando a continuação entra em R1. Preserve ballots simultâneos, ausência de ordem de H, pi_H=0, opt-out imediato, coalizão mínima e zero para outsiders. Antes de provar, o novo Gate 0 deve decidir se T^Y seleciona apenas entre ações localmente não dominadas ou substitui PBE-UD na igualdade. Não edite nem compile formal_model_v6.Rmd; não migre teoremas, matrizes ou pareceres do candidato 5bd7fbe. Encerre após documentar o novo plano, salvo GO explícito para rederivação.
```
