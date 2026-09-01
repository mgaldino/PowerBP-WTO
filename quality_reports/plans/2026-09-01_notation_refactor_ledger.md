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
