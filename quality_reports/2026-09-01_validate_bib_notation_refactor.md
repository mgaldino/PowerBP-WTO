# Bibliographic validation of the notation-refactor candidate

## Summary

- Main file: `formal_model_v6.Rmd`.
- Bibliography: `references.bib`.
- Distinct citation keys in the manuscript: 22.
- Entries in the bibliography: 44.
- Orphan citations after repair: 0.
- Bibliography entries not cited in the manuscript: 22.
- Duplicate keys: 0.
- Required-field failures detected: 0.
- Final render: PASS, with no citeproc or LaTeX citation warning.

## Orphan citations repaired

| Key | Manuscript location | Repair and verification |
|---|---|---|
| `voeten2019making` | Introduction | Added Erik Voeten, "Making Sense of the Design of International Institutions," *Annual Review of Political Science* 22 (2019): 147--163, DOI `10.1146/annurev-polisci-041916-021108`. Metadata checked against the journal record reproduced by SSRN. |
| `cairnsgroup1987proposal` | Introduction | Added the Cairns Group proposal to the GATT Uruguay Round Negotiating Group on Agriculture, document `MTN.GNG/NG5/W/21`, 26 October 1987. Metadata and document number checked against the official WTO-hosted GATT document. |

Sources accessed 2026-09-01:

- https://doi.org/10.1146/annurev-polisci-041916-021108
- https://www.wto.org/gatt_docs/English/SULPDF/92030054.pdf

## Entries not cited in the current manuscript

`admati1987strategic`, `alhajji2000dominant`, `bardhi2018modes`,
`bhagwati2008termites`, `blackhurst2000options`,
`chenEraslan2013informational`, `cho1987signaling`,
`cramton1984bargaining`, `fattouh2013opec`, `gould2016consensus`,
`griffin1994oil`, `gruber2000ruling`, `ikenberry2001after`,
`jawara2003behind`, `jones2010manoeuvring`, `kamenica2011bayesian`,
`keohane1984after`, `kim2025persuasion`, `ma2023efficiency`,
`nakov2013saudi`, `simmons2005twilight`, and `yergin1990prize`.

These entries are retained because removing uncited bibliography records was
outside the authorized manuscript migration and would discard potentially
useful project references.

## Quality checks

- All 44 entries were accepted by Pandoc/citeproc during the final render.
- A field audit found no entry lacking `title`, `year`, and `author` or
  `editor`; article, book, in-collection, and technical-report entries also
  contained their type-specific journal, publisher, book title, or institution
  field.
- The two new entries use stable identifiers: a DOI for Voeten and an official
  GATT document number plus WTO-hosted PDF for the Cairns Group proposal.
- No wording in the approved Introduction was changed during the repair.
