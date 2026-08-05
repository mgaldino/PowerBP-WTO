# Goal 4 Handoff — Controlled Migration to formal_model_v6.Rmd

**Date:** 2026-08-04
**Status:** prepared, not authorized
**Source candidate:** `5bd7fbe47f63f6b94ca4085852596f1d4ad9901c`

## Decision boundary

Goal 3 is closed. This handoff does not authorize editing or compiling
`formal_model_v6.Rmd`. Goal 4 starts only after explicit user authorization and
a fresh paper-version gate.

## Governing inputs

1. `model_redesign/undominated_voting_rederivation.Rmd`;
2. `quality_reports/2026-08-04_undominated_voting_impact_matrix.md`;
3. `quality_reports/2026-08-04_undominated_voting_goal3_status.md`;
4. the three final independent Goal 3 reviews;
5. protected v6 SHA-256
   `131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d`.

## Migration order

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

## Nonnegotiable migration rules

- No intraballot public or sequential voting and no order of `H`.
- Baseline outcomes are coalition-pure: minimal winning support and zero for
  weak outsiders.
- Gift proposals remain feasible deviations and must remain in proposal
  optimality checks.
- Equality at continuation is a correspondence, not an automatic yes vote.
- Report unrestricted PBE-UD separately wherever it diverges from the
  coalition-pure baseline.
- Do not reuse the old `P/L/R`, `F_M`, No-Cheap-H, feasibility/C-B-R, delayed
  continuation, or positive-`pi_H` architecture without a new proof.
- Keep institutional comparisons conditional on common equilibrium existence.

## Copy-ready opening prompt

```text
Estamos no repositório /Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion. Execute o Goal 4: migração controlada da derivação PBE-UD fechada no commit 5bd7fbe47f63f6b94ca4085852596f1d4ad9901c para formal_model_v6.Rmd. Antes de editar, leia AGENTS.md, model_redesign/undominated_voting_rederivation.Rmd, quality_reports/2026-08-04_undominated_voting_goal3_status.md, quality_reports/2026-08-04_undominated_voting_impact_matrix.md e quality_reports/plans/2026-08-04-goal4-v6-migration-handoff.md; verifique worktree, HEAD e o hash protegido de v6; use paper-version sem criar tag enganosa em estado sujo. Preserve ballots simultâneos e selados, sem votação pública dentro do ballot e sem ordem de H. No baseline, use a seleção coalition-pure: suporte vencedor mínimo, zero para weak outsiders e apoiadores necessários protegidos pelo valor de continuação; mantenha ofertas com gifts como desvios factíveis na checagem de optimalidade e reporte a correspondência PBE-UD irrestrita separadamente quando divergir. Trate igualdade como correspondência, não como voto sim imposto. Migre primeiro definições e provas, depois entry/fronteiras e somente por último abstract, introdução, captions e conclusão. Compile no formato YAML/bookdown, valide o PDF inteiro e obtenha três pareceres independentes, somente leitura, no mesmo commit final. Quem implementa não revisa. Não faça push.
```
