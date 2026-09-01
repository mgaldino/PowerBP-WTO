# Final independent review: notation refactor candidate

**Date:** 2026-09-01  
**Candidate branch:** `codex/notation-refactor-sectionwise`  
**Reviewed commit:** `589aafed113a743e609537ae3b0ac1d34c979daa`  
**Result:** PASS — 0 P0 / 0 P1 / 0 P2

## Reviewed artifacts

- `formal_model_v6.Rmd`: SHA-256
  `a55b976f7ee217e1c9a24ddf03424494b5bd33c173154b1215c2b01e773dc642`
- `formal_model_v6.pdf`: SHA-256
  `243ad597fecac3062ea1050f43b2a650fa8fe60b2415be5476bdf37979fb8143`
- `references.bib`: SHA-256
  `71f1413b45b44a4c55a9d0ffb4fb2e1218cfac7ced547829bd0e3eae6200f755`
- Introduction block, lines 37--122: SHA-256
  `a1fa56b59519e10a2a9c80343d35c732c0111eac229d0e401cbeeb88c75b522f`

## Formal migration review

An independent read-only reviewer confirmed that the four embedded figures
and the Steinberg table use the revised notation consistently. The figures
preserve the distinction between disagreement payoffs `ell,h` and Round-1
prices `beta ell,beta h`. No old reader-facing `o_theta`, `o0`, `o1`, `nu`,
`q-1`, `RI_M`, `RI_U`, or `DeltaRI` label remains.

The reviewer also reconfirmed, by source comparison and targeted checks, the
formal invariants: 19 occurrences of `varnothing`, three `none` cells, the
linked `lambda` segments, unchanged domains and correspondences, `T=D+I`, and
the separate diagonal object `Q`. The layout-only reflow of three appendix
displays did not change mathematical content.

## PDF and bibliography review

A second independent read-only reviewer checked all 66 PDF pages. There are no
blank pages, edge violations, clipping, overlaps, or right-margin outliers.
The previously affected pages 49, 54, and 60 now stay within the normal text
boundary. The four figure assets are legible and use `ell/h`, `p`, `k`, and
`IR` consistently.

Pandoc citeproc completed with exit status zero and empty stderr. The reviewer
counted 31 citation occurrences and 24 distinct cited keys, with zero orphan
keys or duplicates. The Cairns Group and Voeten entries each appear once. The
Cairns reference renders the corporate institution continuously as “General
Agreement on Tariffs and Trade.”

The Introduction remains literally identical to the principal-branch source
at commit `462ea472c3a506d7c478acd12239e6208f71f277`; no wording was normalized or
corrected.

## Promotion boundary

This PASS validates the candidate artifacts above. It does not authorize a
merge, branch reset, new tag, push, or other promotion to the principal branch.
Promotion remains pending explicit author approval.
