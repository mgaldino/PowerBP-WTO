# Item 13 proof-transport manifest

Date: 2026-09-02  
Status: **PASS — candidate version fixed locally**  
Authorization: the author explicitly authorized transport of the proofs and
the associated technical-presentation repairs.

## Scope and result

This pass transports the proof support for review item 13 into the manuscript
itself. Appendices B.7--B.9 now prove the private-majority correspondence, the
private-unanimity correspondence, and the exact/economic representations.
Appendices E.2--E.3 construct the rule-specific realized-law spaces, and F.1
uses the resulting typed factorization interfaces. F.3 points to the internal
proofs rather than treating external manifests as substitutes for proofs.

The pass also closes the notation and technical-presentation interfaces exposed
by that transport: scalar passage indicators are distinguished from ballot
vectors; continuation-cell spaces are rule-specific; probability laws are
distinguished from their evaluations on events; binder dependence is retained;
the ex ante payoff coordinate and nonempty-fiber envelope are explicit; and all
new symbols are defined before use.

## Frozen sources

- `model_redesign/agenda_extension_A_M_msb_results.md`  
  SHA-256: `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3`
- `model_redesign/agenda_extension_A_U_msb_results.md`  
  SHA-256: `e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11`
- `model_redesign/agenda_extension_AC_msb_results.md`  
  SHA-256: `8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a`
- A_M final-gate manifest  
  SHA-256: `8eb870d5595a4373994e8f47a25a3dd137b00ac8c32fc09b947444498a32775e`
- A_U final-gate manifest  
  SHA-256: `b85741b2176c4480f5f3632c4464a93cebabb5dd4f71636626917b9227030180`

## Version-control boundary

- Working branch: `codex/item13-proof-transport`
- Pre-transport annotated tag: `pre-item13-proof-transport-2026-09-02`
- Pre-transport commit: `c64328365f368099f432450a816cd873311f5e40`
- Exact reviewed paper commit: `95a0d3fc2c9e22ea331e9ab1ff51b8e7e5521ba5`
- Candidate tag: `v6-item13-proof-transport-candidate-2026-09-02`
- `main` remained at `32ac8b426cc488e2254dd3987ac44b569664f737`.
- No push, merge, or main-branch mutation was performed.

Transport commit chain:

1. `7b762e9` — transport agenda-extension proofs;
2. `d5d3b0a` — repair proof-transport pagination;
3. `30b847c` — close the first item-13 transport candidate;
4. `93079de` — repair proof-transport interfaces;
5. `2f504c2` — type the unanimity realized law;
6. `fcf50f6` — define factorization interfaces;
7. `95a0d3f` — close payoff-envelope notation and bibliography pagination.

The intermediate review results are superseded by the three reviews of the
exact final paper commit `95a0d3f`.

## Exact paper artifacts

- `formal_model_v6.Rmd`  
  SHA-256: `20fb9837918e4e91bbe9da3b8b1ff90e45d42188444e50b05bb27a41dd233a71`
- `formal_model_v6.pdf`  
  SHA-256: `a5961902ef55f5e183010ba8614a7dc9a1ccaeb094494369bc8732b656ea8acf`
- PDF length: 74 pages.

## Validation evidence

Render command:

```sh
Rscript --vanilla -e 'rmarkdown::render("formal_model_v6.Rmd")'
```

Result: successful PDF render.

Mechanical falsification harnesses:

- A_M: `3954 PASS | 0 FAIL`
- A_U: `1110 PASS | 0 FAIL`

These harnesses test their declared algebraic and constructive domains; they do
not by themselves prove PBE completeness. The manuscript proofs and interfaces
were therefore reviewed independently as a separate gate.

Independent read-only review of exact commit `95a0d3f`:

- mathematical fidelity and invariance: `PASS 0/0/0`;
- technical presentation and notation: `PASS 0/0/0`;
- exposition and full 74-page visual inspection: `PASS 0/0/0`.

The visual review found no overflow, clipping, missing glyphs, undefined
references, problematic widows/orphans, or split bibliography entries.

## Concurrent-edit audit

After the author raised a possible concurrent-edit concern, the current
worktree and index were checked against `HEAD`. The manuscript and PDF matched
their committed blobs exactly, the reflog contained only this task's commits,
`main` was unchanged, and no later commit existed on another local branch. The
only Git lock found was an empty Codex lock created before this transport branch;
there was no evidence that Claude or another process overwrote this work.

## Non-destructive recovery

To recover the exact pre-transport state without moving or deleting the current
branch:

```sh
git switch -c recovery/item13-pre-transport pre-item13-proof-transport-2026-09-02
```

To inspect the fixed candidate after the candidate tag is created:

```sh
git switch --detach v6-item13-proof-transport-candidate-2026-09-02
```

Both operations preserve the present branch and its history.
