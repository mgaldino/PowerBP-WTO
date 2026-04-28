# Bibliography Validation Report

**Paper**: `formal_model_v5.Rmd` (Informational Power Through Pivotality: When a Hegemon May Choose Consensus)  
**Bib file**: `references.bib`  
**Date**: 2026-04-27  
**Validator**: Claude Opus 4.6 (automated + web verification)

---

## 1. Cross-reference summary

| Metric | Count |
|--------|-------|
| Citation keys used in `.Rmd` | 18 |
| Entries defined in `.bib` | 18 |
| Orphan citations (cited but missing from .bib) | 0 |
| Phantom entries (in .bib but never cited) | 0 |
| Suspicious keys (possible typos) | 0 |

**All 18 citation keys match exactly between the paper and the bib file. No orphans, no phantoms.**

---

## 2. Citation keys used in the paper

| # | Key | Lines (approx.) |
|---|-----|-----------------|
| 1 | `gould2016consensus` | Intro, Lit Review, Discussion |
| 2 | `baron1989bargaining` | Intro, Lit Review |
| 3 | `kalandrakis2006proposal` | Intro, Lit Review |
| 4 | `eraslan2019legislative` | Intro, Lit Review |
| 5 | `steinberg2002shadow` | Intro, Lit Review, Discussion |
| 6 | `koremenos2001rational` | Intro, Lit Review |
| 7 | `keohane1984after` | Intro, Lit Review |
| 8 | `ikenberry2001after` | Intro, Lit Review |
| 9 | `stone2011controlling` | Intro, Lit Review |
| 10 | `gruber2000ruling` | Intro, Lit Review |
| 11 | `bardhi2018modes` | Lit Review |
| 12 | `kim2025persuasion` | Lit Review |
| 13 | `kamenica2011bayesian` | Remark 3 (Information design) |
| 14 | `jawara2003behind` | Discussion (GATT/WTO) |
| 15 | `jones2010manoeuvring` | Discussion (GATT/WTO) |
| 16 | `blackhurst2000options` | Discussion (GATT/WTO) |
| 17 | `bhagwati2008termites` | Discussion |
| 18 | `fearon1995rationalist` | Discussion |

---

## 3. Entry-level field completeness

All 18 entries have the required fields for their entry type. Details below.

| # | Key | Type | Author | Title | Year | Journal/Publisher | Volume | Pages | Status |
|---|-----|------|--------|-------|------|-------------------|--------|-------|--------|
| 1 | `kamenica2011bayesian` | article | OK | OK | 2011 | American Economic Review | 101(6) | 2590--2615 | PASS |
| 2 | `baron1989bargaining` | article | OK | OK | 1989 | American Political Science Review | 83(4) | 1181--1206 | PASS |
| 3 | `kalandrakis2006proposal` | article | OK | OK | 2006 | American Journal of Political Science | 50(2) | 441--448 | PASS |
| 4 | `eraslan2019legislative` | article | OK | OK | 2019 | Annual Review of Economics | 11 | 443--472 | PASS |
| 5 | `gould2016consensus` | unpublished | OK | OK | 2016 | N/A (working paper) | N/A | N/A | PASS (see note) |
| 6 | `koremenos2001rational` | article | OK | OK | 2001 | International Organization | 55(4) | 761--799 | PASS |
| 7 | `steinberg2002shadow` | article | OK | OK | 2002 | International Organization | 56(2) | 339--374 | PASS |
| 8 | `keohane1984after` | book | OK | OK | 1984 | Princeton University Press | N/A | N/A | PASS |
| 9 | `ikenberry2001after` | book | OK | OK | 2001 | Princeton University Press | N/A | N/A | PASS |
| 10 | `stone2011controlling` | book | OK | OK | 2011 | Cambridge University Press | N/A | N/A | PASS |
| 11 | `gruber2000ruling` | book | OK | OK | 2000 | Princeton University Press | N/A | N/A | PASS |
| 12 | `bardhi2018modes` | article | OK | OK | 2018 | American Economic Review | 108(7) | 1877--1907 | **FAIL** |
| 13 | `kim2025persuasion` | article | OK | OK | 2025 | American Journal of Political Science | 69(3) | 1115--1127 | PASS |
| 14 | `fearon1995rationalist` | article | OK | OK | 1995 | International Organization | 49(3) | 379--414 | PASS |
| 15 | `jawara2003behind` | book | OK | OK | 2003 | Zed Books | N/A | N/A | PASS |
| 16 | `jones2010manoeuvring` | book | OK | OK | 2010 | Commonwealth Secretariat | N/A | N/A | PASS |
| 17 | `blackhurst2000options` | article | OK | OK | 2000 | The World Economy | 23(4) | 491--510 | PASS |
| 18 | `bhagwati2008termites` | book | OK | OK | 2008 | Oxford University Press | N/A | N/A | PASS |

---

## 4. Duplicate check

No duplicate entries found. All 18 keys are unique.

---

## 5. Web verification of bibliographic details

### FAIL: `bardhi2018modes` -- WRONG JOURNAL, VOLUME, ISSUE, AND PAGES

**This is the most serious error in the bibliography.**

| Field | In `.bib` | Correct value |
|-------|-----------|---------------|
| journal | American Economic Review | **Theoretical Economics** |
| volume | 108 | **13** |
| number | 7 | **3** |
| pages | 1877--1907 | **1111--1149** |
| year | 2018 | 2018 (correct) |

**What happened**: The journal, volume, number, and pages in the bib file are entirely fabricated. Bardhi & Guo (2018) "Modes of Persuasion Toward Unanimous Consent" was published in *Theoretical Economics*, Vol. 13, No. 3, pp. 1111--1149. It was never published in the *American Economic Review*. The volume/pages listed (AER 108(7): 1877--1907) do not correspond to this paper in the AER either.

**Severity**: CRITICAL. This is exactly the type of hallucinated bibliographic metadata that constitutes a serious scholarly error. A referee or editor who checks this reference will immediately flag it.

**Recommended fix**:
```bibtex
@article{bardhi2018modes,
  title={Modes of Persuasion Toward Unanimous Consent},
  author={Bardhi, Arjada and Guo, Yingni},
  journal={Theoretical Economics},
  volume={13},
  number={3},
  pages={1111--1149},
  year={2018}
}
```

---

### PASS with notes: all other entries

| # | Key | Verification result |
|---|-----|---------------------|
| 1 | `kamenica2011bayesian` | **VERIFIED.** AER 101(6): 2590--2615, 2011. Confirmed via AEA website. |
| 2 | `baron1989bargaining` | **VERIFIED.** APSR 83(4): 1181--1206, 1989. Confirmed via Cambridge Core. |
| 3 | `kalandrakis2006proposal` | **VERIFIED.** AJPS 50(2): 441--448, 2006. Confirmed via IDEAS/RePEc and Rochester faculty page. |
| 4 | `eraslan2019legislative` | **VERIFIED.** Annual Review of Economics 11: 443--472, 2019. Confirmed via Annual Reviews and IDEAS/RePEc. |
| 5 | `gould2016consensus` | **VERIFIED as working paper.** Presented at PEIO Conference 2016. Still unpublished as of April 2026. The `@unpublished` type is appropriate. Note: CLAUDE.md mentions "Gould (2022)" but the bib correctly uses 2016, which matches the PEIO conference date. The paper text also uses 2016. No inconsistency in the paper itself. |
| 6 | `koremenos2001rational` | **VERIFIED.** IO 55(4): 761--799, 2001. Confirmed via Cambridge Core and EconPapers. |
| 7 | `steinberg2002shadow` | **VERIFIED.** IO 56(2): 339--374, 2002. Confirmed via Cambridge Core. |
| 8 | `keohane1984after` | **VERIFIED.** Princeton University Press, 1984. Full title confirmed. |
| 9 | `ikenberry2001after` | **VERIFIED.** Princeton University Press, 2001. Full title confirmed. |
| 10 | `stone2011controlling` | **VERIFIED.** Cambridge University Press, 2011. Confirmed via CUP website. |
| 11 | `gruber2000ruling` | **VERIFIED.** Princeton University Press, 2000. Confirmed via PUP website. |
| 12 | `kim2025persuasion` | **VERIFIED.** AJPS 69(3): 1115--1127, 2025. Confirmed via Wiley Online Library. |
| 13 | `fearon1995rationalist` | **VERIFIED.** IO 49(3): 379--414, 1995. Confirmed via Cambridge Core. |
| 14 | `jawara2003behind` | **VERIFIED.** Zed Books, London, 2003. Confirmed via multiple book databases. |
| 15 | `jones2010manoeuvring` | **VERIFIED.** Commonwealth Secretariat, London, 2010. Confirmed via Commonwealth iLibrary and Academia.edu. |
| 16 | `blackhurst2000options` | **VERIFIED.** The World Economy 23(4): 491--510, 2000. Confirmed via citation databases. |
| 17 | `bhagwati2008termites` | **VERIFIED.** Oxford University Press, New York, 2008. Confirmed via OUP website. |

---

## 6. Summary of issues

### Critical (must fix before submission)

1. **`bardhi2018modes`: Wrong journal, volume, number, and pages.** The entry lists "American Economic Review, 108(7), 1877--1907" but the correct publication is *Theoretical Economics*, 13(3), 1111--1149. This is a fabricated/hallucinated citation that must be corrected immediately.

### Advisory (no action required, for awareness)

2. **`gould2016consensus`**: Remains an unpublished working paper. If the paper has been published since the last check (or has a more recent version), consider updating. The PEIO 2016 version is the latest publicly available. For RIO submission, citing an unpublished paper is acceptable but an editor may ask whether a published version exists.

3. **`kalandrakis2006proposal`**: The page range 441--448 is correct but unusually short for an AJPS article (8 pages). This is accurate -- it is a short article / note. No action needed.

---

## 7. Overall assessment

| Category | Result |
|----------|--------|
| Cross-reference integrity | PASS (18/18 match) |
| Required fields | PASS (all entries complete) |
| Duplicates | PASS (none) |
| Bibliographic accuracy | **FAIL** (1 critical error: `bardhi2018modes`) |

**Bottom line**: The bibliography has one critical error that must be fixed before submission. The Bardhi & Guo (2018) entry has entirely wrong journal metadata -- it was published in *Theoretical Economics*, not the *American Economic Review*. All other 17 entries are verified correct against web sources. Once this single entry is corrected, the bibliography is clean and ready for submission.
