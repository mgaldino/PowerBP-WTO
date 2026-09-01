# Notation refactor ledger

**Date:** 2026-09-01  
**Worktree:** `/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion-notation-refactor`  
**Branch:** `codex/notation-refactor-sectionwise`  
**Base tag:** `v6-agenda-extension-2026-08-31`  
**Scope:** expositional notation only; no change to the game, formulas, domains,
linked correspondences, empty cells, payoff dates, or the distinction between
the total agenda effect `T` and the diagonal contrast `Q`.

## Author decisions

- Write outside-option types directly as `o in {ell,h}`, with `ell<h`.
- Use `p` for the prior probability of the high outside option and `mu` for
  posteriors, including `mu^{off}` off path.
- Write public inclusion regions in words, never as `II/IX/XX` or `II/IE/EE`.
- Use `IR` for informational rent.
- Use `B` for the baseline without the earlier agenda stage and `A` for the
  agenda-stage treatment.
- Use reader-facing prose "accepts when indifferent" rather than the internal
  label `T^Y`.
- Work section by section; never use global search-and-replace.
- After the notation pass, copy the Introduction verbatim from
  `codex/essential-input`; do not edit its wording.

## Canonical crosswalk

| Old object | New object | Invariant |
|---|---|---|
| `theta in {0,1}`, `o_0,o_1` | `o in {ell,h}` | `ell` is the low terminal disagreement payoff and `h` the high one |
| `nu` | `p=Pr(o=h)` | Same prior and endpoint support |
| posterior `eta` or `p=nu_off` | `mu`, `mu^{off}` | Same Bayes and off-path domains; `rho` remains appendix-only |
| `N=m+1`, quota `q`, `k=q-1`, `c=m-k` | `m`, `k=floor((m+1)/2)`, `e=m-k` | A proposer needs `k` additional yes votes under majority |
| `s=(y,(x_j),r_i)` and `s^A=(z_H,(x_j))` | allocation vector `x=(x_H,x_1,...,x_m)` | Same feasible package and implemented payoffs |
| no-agenda superscript `N` | baseline superscript `B` | Same Round-1 control arm |
| public payoff `p_g` or `h_g` | `v_g^B` or `v_g^A` | Same public-type payoff by rule and arm |
| private payoff `V_g` | `V_g^B` or `V_g^A` | Same linked correspondence |
| `RI_g`, `Delta RI` | `IR_g`, `Delta IR` | Same private-minus-public translation |
| `a_o`, `d`, `xi` | expanded formulas | Same timing wedge and type gaps |
| `Z_E` | `v_M^{safe}` | Same safe majority-agenda payoff |
| `tau_M` | `o_M^*` | Same majority delay cutoff |
| `z_L,z_H,d_H,u_min,Delta_U` | public-value functions or expanded expressions | Same unanimity payoff fibers |
| `G_old=v_M^A-v_U^A` | `Delta v^A=v_U^A-v_M^A` | Exact sign reversal, handled in a separate audited pass |
| `D,I,T` | unchanged | `T=D+I` member by member |
| `Q` | unchanged, appendix-only | Never conflated with `T` |

## Section gates

For every section: inspect the complete diff, run `git diff --check`, search
for obsolete local symbols, compile with the YAML-defined bookdown format, and
record hashes before advancing. Existing frozen derivations and verification
scripts are read-only sources.

## Checkpoints

- Baseline model and results (through the informational-rent comparison):
  sectionwise notation migration completed and rendered successfully on
  2026-09-01. Candidate hashes at this checkpoint: Rmd
  `b707a498ef8efa31f7de5786b5236afe35c3ae26ffb6a313c6d3049307489b62`;
  PDF `52b75b1964f888ae30347edc3cdaef0a7ee7f8b50d50d87a3af352b0f6165f8d`.
  The Introduction remained untouched.
- Agenda extension and technical appendices: sectionwise notation migration
  completed and rendered successfully on 2026-09-01. Candidate hashes at this
  checkpoint: Rmd
  `821e64b32ba92e41e2a0184458068961d4272372aea0a4acc08ea089e4abaa14`;
  PDF `374d83889dab79fa6de881ba4190a4d3afbfed84292bbfb13d9f7730ee230ae6`.
  The linked fibers, `none` cells, and separate definitions of `T` and `Q`
  were retained. The Introduction remained untouched.
- Introduction transfer: copied verbatim from commit
  `462ea472c3a506d7c478acd12239e6208f71f277` on `codex/essential-input`.
  The extracted source and destination blocks have the same SHA-256,
  `a1fa56b59519e10a2a9c80343d35c732c0111eac229d0e401cbeeb88c75b522f`.
  No wording was corrected or completed.
- Bibliography gate: the two source-Introduction orphans were repaired in
  `references.bib` and the candidate rendered without citation warnings. See
  `quality_reports/2026-09-01_validate_bib_notation_refactor.md`.
- Post-transfer candidate hashes: Rmd
  `ce6b791a06dc2d253bfc856af3cf9dc94e1ee34dc9e521bef360f44dabe5b2cf`;
  PDF `09be930e6ffcb804647849940015b46c7f4e8669caa152e53468c5fb4b9cdc14`;
  bibliography
  `7f758b42c7a21871afe89e0deca7564f0246bc4479e5ed225149d44831037e80`.
- First independent post-transfer review: the formal text passed all formula,
  domain, correspondence, date, empty-cell, sign-orientation, and `T`/`Q`
  checks. The candidate failed the artifact gate because the four embedded
  figures still displayed the old notation; a separate PDF review also found
  three elements extending past the normal text margin. No reviewer edited
  the candidate.
- Artifact repair: updated only reader-facing labels in
  `scripts/essential_input_manuscript_figure_functions.R`, regenerated all
  four PDF/PNG figure bundles, and changed the F3 data labels from `RI` to
  `IR`. The generator retained the frozen N6/N7 hash checks, and all plotted
  numeric values and geometries remained unchanged. The three overmargin
  elements were reflowed without changing their mathematical content.
- Post-repair checks: YAML-defined rendering succeeded; all 66 pages are
  nonempty; PDF text contains none of `o_theta`, `o0`, `o1`, `nu_SE`, `nu*`,
  `RI_M`, `RI_U`, or `DeltaRI`; and the bounding-box scan found no text past
  the normal right boundary. Candidate hashes: Rmd
  `a55b976f7ee217e1c9a24ddf03424494b5bd33c173154b1215c2b01e773dc642`;
  PDF `c06d7d55e735a0acd65924e2606fa3d4c7aa0aac3d38bd02de72b6da1dd34c63`;
  bibliography
  `7f758b42c7a21871afe89e0deca7564f0246bc4479e5ed225149d44831037e80`.
  The Introduction remains byte-identical to the principal-branch block, SHA-256
  `a1fa56b59519e10a2a9c80343d35c732c0111eac229d0e401cbeeb88c75b522f`.
- Final bibliography repair: the Cairns entry now double-braces the corporate
  institution so citeproc renders “General Agreement on Tariffs and Trade” as
  one continuous name. The candidate was rendered again. Final artifact hashes
  before independent re-review: Rmd
  `a55b976f7ee217e1c9a24ddf03424494b5bd33c173154b1215c2b01e773dc642`;
  PDF `243ad597fecac3062ea1050f43b2a650fa8fe60b2415be5476bdf37979fb8143`;
  bibliography
  `71f1413b45b44a4c55a9d0ffb4fb2e1218cfac7ced547829bd0e3eae6200f755`.
- Author-approved terminology clarification: in the main text, replaced the
  loose expression “common off-path fiber” with “same off-path specification.”
  The text now identifies `rho` as the likelihood-ratio coordinate and
  `mu^{off}` as its implied posterior, and states directly that institutional
  comparisons never combine components from different equilibrium records.
  Technical uses of “fiber” and “fiber product” remain in the appendix. The
  YAML-defined render passed, with Rmd SHA-256
  `ec9f281efb5e28c4e0b3c1c0c2756a2684aa85f0670e5ce42544ec886c3f0a97`
  and PDF SHA-256
  `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`.
  The Introduction block remains byte-identical to the principal branch.
