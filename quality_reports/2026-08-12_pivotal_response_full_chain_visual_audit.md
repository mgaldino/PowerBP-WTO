# Visual audit: pivotal-response rederivation

**Date:** 2026-08-12  
**Audited PDF:** `model_redesign/pivotal_response_rederivation.pdf`  
**SHA-256:** `6ff930e1a3d3ba11a0b9630149a42a23bdb1ef204b71ece7e17f5ece62594126`  
**Pages:** 60  
**Status:** PASS by implementer inspection; pending independent read-only confirmation

## Protocol

The PDF was rasterized in full and every page was inspected. The audit emphasized the title and contents, the Gate 0 contract and registry tables, every R2/R1/entry node transition, the proof ledger, institutional comparison, the survival inventory, and the consolidated conclusion. The corresponding HTML was also checked structurally and for the complete set of required sections.

Mechanical corroboration came from `scripts/verify_pivotal_response_full_chain.R`:

- `pdfinfo` opens the artifact and reports 60 letter-size pages;
- `pdftotext` recovers all six required high-level sections;
- no stale stop/review marker, `PBE-UD`, as-if-pivotal language, or roll-call protocol appears in the rendered text;
- all 60 pages rasterize to nonempty PNG files;
- the kept TeX compiles twice in an isolated directory;
- the final LaTeX log contains no overfull horizontal box, undefined reference, duplicate-label, emergency-stop, or fatal-error marker.

## Inspection result

No clipped text, overlapping table cells, missing glyphs, broken formulas, unreadable registry, truncated hash, stale candidate status, or unresolved cross-reference remained in the exact audited PDF. A first final-review attempt identified adjacent survival headings on page 57; a presentation-only transition sentence was inserted and the corrected page was rerendered and inspected at full resolution. Long registries and proof-history material are rendered as readable selected-column tables or nested lists; the authoritative full CSV/JSON artifacts remain outside the body. Page breaks around the R2, R1, entry, comparison, survival, and final-synthesis sections are coherent.

## Scope

This audit concerns presentation and internal consistency of the standalone rederivation only. It does not authorize migration to `formal_model_v6.Rmd` and does not substitute for the two required independent read-only reviews of the exact release candidate.
