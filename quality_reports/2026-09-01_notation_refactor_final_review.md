# Final independent review: notation refactor candidate

**Date:** 2026-09-01  
**Candidate branch:** `codex/notation-refactor-sectionwise`  
**Reviewed commit:** `1b5aebaf6981bf55fb17de29bfdf98b5862d6e44`  
**Result:** PASS — 0 P0 / 0 P1 / 0 P2

## Reviewed artifacts

- `formal_model_v6.Rmd`: SHA-256
  `ec9f281efb5e28c4e0b3c1c0c2756a2684aa85f0670e5ce42544ec886c3f0a97`
- `formal_model_v6.pdf`: SHA-256
  `146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4`
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

## Author-approved terminology clarification

After the first final PASS, the author approved replacing “common off-path
fiber” in the main text with “same off-path specification.” Two independent
read-only incremental reviews passed with 0 P0 / 0 P1 / 0 P2. They confirmed
that the revised paragraph correctly identifies `rho` as the likelihood-ratio
coordinate and `mu^{off}` as its implied posterior, preserves the interior
formula and endpoint convention, and retains the same-record/no-splicing
restriction. Technical uses of “fiber” and “fiber product” remain in the
appendix. The recompiled 66-page PDF has no new margin, clipping, overlap, or
page-content defect.

## Promotion boundary

This PASS validates the candidate artifacts above. It does not authorize a
merge, branch reset, new tag, push, or other promotion to the principal branch.
Promotion remains pending explicit author approval.
