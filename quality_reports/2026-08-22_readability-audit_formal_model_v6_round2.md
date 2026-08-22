# Readability audit — formal_model_v6.Rmd (final repaired candidate)

**Date:** 2026-08-22
**Field benchmark:** International Relations
**Pangram:** **not run**, as required by the authorial authorization.
**Input:** final repaired Goal-5 R Markdown candidate after the second independent review cycle.
**Tool:** local `readability_audit.py`; no network service was called.

## 1. Summary

The repaired manuscript contains 6,512 words as parsed from the R Markdown
source. The increase from the first candidate comes mostly from the four
numbered tables required by the migration matrix and from the exact multiplicity
and envelope statements requested by formal review. The final increment defines
history-indexed continuation values and distinguishes weak-vote prices under
majority and unanimity.

Aggregate sentence-level readability remains favorable relative to the
descriptive pre-ChatGPT IR benchmark. Flesch Reading Ease lies between the
median and the 75th percentile. Flesch--Kincaid grade, Gunning Fog, and SMOG
lie between the 25th percentile and the median, where lower values are easier.
Hedging remains low.

Two surface metrics remain high. The passive-voice detector is approximately at
the 90th percentile and the nominalization detector is above it. These results
are partly construct-driven: the passive count is concentrated in formal
protocol and payoff definitions, while the suffix-based nominalization count
repeatedly treats unavoidable terms such as *information*, *institution*,
*comparison*, and *proposition* as stylistic nominalizations.

| Metric | Candidate | IR p10 | IR p25 | IR median | IR p75 | IR p90 | Approximate position | Direction |
|---|---:|---:|---:|---:|---:|---:|---|---|
| Flesch Reading Ease | 31.3 | -101.67 | -71.62 | 13.15 | 34.05 | 37.29 | p50--p75 | Higher is easier |
| Flesch-Kincaid grade | 12.9 | 12.11 | 12.72 | 16.55 | 26.77 | 30.84 | p25--p50 | Lower is easier |
| Gunning Fog | 15.1 | 14.80 | 15.10 | 16.25 | 17.60 | 18.69 | p25--p50 | Lower is easier |
| SMOG | 14.1 | 13.40 | 14.03 | 14.45 | 15.45 | 15.99 | p25--p50 | Lower is easier |
| Passive voice (%) | 10.8 | 2.31 | 2.82 | 5.50 | 8.55 | 10.89 | p75--p90 | Lower is usually easier |
| Nominalizations (%) | 6.3 | 3.12 | 3.98 | 4.45 | 5.30 | 5.97 | above p90 | Lower is usually easier |
| Hedging (%) | 0.3 | 0.11 | 0.43 | 0.60 | 0.78 | 1.17 | p10--p25 | Lower is more direct |

## 2. Complete section-level metrics

The one-word parser preamble and the notation table are retained for
completeness but should not be interpreted as prose. In particular, the
notation table's extreme readability scores are an artifact of applying
sentence formulas to symbol definitions.

| Section | Words | Flesch | FK grade | Fog | SMOG | Passive % | Nominalization % | Hedging % |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Preamble | 1 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 | 0.0 |
| Introduction | 661 | 21.7 | 14.4 | 17.0 | 15.4 | 15.4 | 8.2 | 0.8 |
| A working numerical illustration | 122 | 67.7 | 5.9 | 8.4 | 9.0 | 5.0 | 5.7 | 0.0 |
| Players, information, and proposals | 180 | 49.4 | 9.5 | 13.0 | 12.3 | 13.3 | 5.0 | 1.1 |
| Ballots, timing, and payoffs | 467 | 37.4 | 12.8 | 14.1 | 13.6 | 18.5 | 2.6 | 0.0 |
| Solution concept | 269 | 28.8 | 13.8 | 16.2 | 15.3 | 13.3 | 4.8 | 0.7 |
| Results opening | 47 | 45.1 | 10.9 | 13.1 | 13.0 | 0.0 | 6.4 | 0.0 |
| Complete-information benchmark | 305 | 33.0 | 12.9 | 15.2 | 14.0 | 5.0 | 5.9 | 0.0 |
| Private information in the terminal round | 154 | 42.2 | 11.1 | 12.4 | 12.0 | 9.1 | 3.9 | 0.0 |
| Private majority in Round 1 | 281 | 36.1 | 11.8 | 14.1 | 13.3 | 21.1 | 4.3 | 0.0 |
| Private unanimity in Round 1 | 413 | 11.8 | 17.3 | 18.9 | 17.0 | 9.5 | 8.0 | 0.0 |
| Comparing the private games | 236 | 15.3 | 14.5 | 15.4 | 13.7 | 15.8 | 7.6 | 0.0 |
| Informational rents and the difference of differences | 726 | 22.3 | 15.3 | 16.4 | 15.1 | 19.4 | 5.9 | 0.1 |
| Pivotality, substitutes, and contested strength | 265 | 27.9 | 12.8 | 14.2 | 13.4 | 4.8 | 8.3 | 0.0 |
| OPEC, the WTO, and observable implications | 199 | 8.6 | 16.5 | 18.1 | 15.9 | 9.1 | 7.5 | 1.0 |
| Limits | 123 | 37.2 | 11.9 | 14.9 | 13.8 | 12.5 | 5.7 | 0.8 |
| Conclusion | 127 | 7.5 | 17.5 | 20.1 | 17.5 | 0.0 | 10.2 | 0.0 |
| A.1 Complete transition and payoff rules | 139 | 56.4 | 8.8 | 11.6 | 11.8 | 20.0 | 2.9 | 0.0 |
| A.2 Beliefs and ballot restrictions | 100 | 30.0 | 12.2 | 14.6 | 13.2 | 0.0 | 7.0 | 2.0 |
| B.1 Public-benchmark proof | 179 | 38.4 | 11.1 | 14.5 | 13.3 | 6.7 | 10.6 | 0.0 |
| B.2 Terminal-games proof | 99 | 46.3 | 9.8 | 13.5 | 12.4 | 33.3 | 8.1 | 0.0 |
| B.3 Private-majority proof | 258 | 42.7 | 11.0 | 15.9 | 14.2 | 5.6 | 5.0 | 0.4 |
| B.4 Private-unanimity proof | 472 | 42.0 | 11.1 | 13.9 | 13.4 | 6.2 | 5.1 | 0.0 |
| B.5 Private-comparison proof | 63 | 36.0 | 12.0 | 15.9 | 14.2 | 0.0 | 9.5 | 0.0 |
| B.6 Rent and difference-of-differences proofs | 125 | 45.4 | 10.7 | 13.0 | 12.4 | 0.0 | 6.4 | 0.0 |
| C.1 Endpoint equivalence | 76 | 32.2 | 12.5 | 16.1 | 14.3 | 0.0 | 7.9 | 0.0 |
| C.2 Exact correspondence and envelopes | 149 | 32.4 | 12.0 | 14.4 | 13.3 | 9.1 | 6.0 | 1.3 |
| C.3 Worked values | 74 | 54.9 | 7.7 | 9.4 | 9.5 | 0.0 | 6.8 | 0.0 |
| Appendix D: Notation | 202 | -125.6 | 69.5 | 72.1 | 38.3 | 0.0 | 6.9 | 0.0 |

## 3. Diagnostic by section

### Introduction

The opening has acceptable academic readability but high passive and
nominalization rates. Some of this is structural language ("is publicly
known", "is conditional") and repeated field vocabulary. A later prose pass
could shorten the long results-preview paragraph and replace a few abstract
nouns with actors and verbs. This is not a mathematical finding.

### Model and payoff protocol

Passive voice is high in "Ballots, timing, and payoffs" because the section
must state who receives what after mechanically defined events. Rewriting every
sentence actively could obscure the rule itself as the causal subject. The
metric is a warning, not a reason to alter the frozen transition system.

### Private unanimity and rents

The two densest results sections now contain exact correspondences, empty cells,
segments, and the numbered tables required by the migration matrix. Their
Flesch, Fog, and SMOG scores deteriorated relative to the first candidate
because the parser treats compact table entries and formulas as prose. The
editorial safeguards remain: intuition precedes each formal statement, type
components stay separate, and the empty correspondence is never filled.

### OPEC/WTO discussion

This remains the weakest substantive prose section by Fog and Flesch. A later
authorial pass could divide the longer sentences and replace clusters such as
"institutional concessions that arise because partners cannot confidently
price" with shorter actor--verb sentences. No such revision is needed to
assess the correctness of the current migration.

### Conclusion

The conclusion is short but dense: it compresses the benchmark, the rent
decomposition, three sign cases, and the empty cell into two paragraphs. The
high Fog, SMOG, and nominalization scores support a future light rewrite after
the author decides which interpretive language should survive P1 and P2.

### Proofs and notation

The high passive rate in the 99-word terminal proof is unstable because a few
sentences change the percentage sharply. The notation table is not prose and
its sentence-level scores are invalid. Neither result warrants mathematical
changes.

## 4. Caveats and operational boundary

- These benchmarks are descriptive, not prescriptive. Formal theory normally
  requires denser notation and more qualified prose than many empirical
  articles.
- The suffix detector overcounts nominalization in a paper whose subject
  requires the words *information* and *institution*.
- The passive detector is a regular-expression approximation, not a syntactic
  parser.
- Pangram was not run. There is no AI-origin score in this audit.
- The skill's incremental CSV lies in another project. It was not modified
  because the Goal-5 authorization permits writes only inside this repository.
