# Readability audit — formal_model_v6.Rmd

**Date:** 2026-08-22
**Field benchmark:** International Relations
**Pangram:** **not run**, as required by the authorial authorization.
**Input:** the Goal-5 migrated R Markdown candidate before independent review.
**Tool:** local readability_audit.py; no network service was called.

## 1. Summary

The manuscript contains 5,610 words as parsed from the R Markdown source.
Aggregate sentence-level readability is favorable relative to the descriptive
pre-ChatGPT IR benchmark: Flesch Reading Ease is above the median, while
Flesch-Kincaid grade, Gunning Fog, and SMOG are near the benchmark's lower,
more readable quartile. Hedging is also low.

Two surface metrics are high. The passive-voice detector places the manuscript
just above the benchmark's 90th percentile, and the nominalization detector
does the same. These results merit attention but are partly construct-driven:
the passive count is concentrated in the formal protocol and payoff
definitions, while the suffix-based nominalization count repeatedly treats the
paper's unavoidable core terms---*information*, *institution*, *comparison*,
and *proposition*---as stylistic nominalizations.

| Metric | Candidate | IR p10 | IR p25 | IR median | IR p75 | IR p90 | Approximate position | Direction |
|---|---:|---:|---:|---:|---:|---:|---|---|
| Flesch Reading Ease | 32.3 | -101.67 | -71.62 | 13.15 | 34.05 | 37.29 | p50--p75 | Higher is easier |
| Flesch-Kincaid grade | 12.5 | 12.11 | 12.72 | 16.55 | 26.77 | 30.84 | p10--p25 | Lower is easier |
| Gunning Fog | 14.8 | 14.80 | 15.10 | 16.25 | 17.60 | 18.69 | about p10 | Lower is easier |
| SMOG | 13.8 | 13.40 | 14.03 | 14.45 | 15.45 | 15.99 | p10--p25 | Lower is easier |
| Passive voice (%) | 11.1 | 2.31 | 2.82 | 5.50 | 8.55 | 10.89 | above p90 | Lower is usually easier |
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
| Introduction | 653 | 21.4 | 14.4 | 17.0 | 15.3 | 15.4 | 8.3 | 0.6 |
| A working numerical illustration | 122 | 67.7 | 5.9 | 8.4 | 9.0 | 5.0 | 5.7 | 0.0 |
| Players, information, and proposals | 137 | 52.7 | 8.9 | 13.0 | 12.1 | 16.7 | 5.1 | 1.5 |
| Ballots, timing, and payoffs | 353 | 39.9 | 12.2 | 13.9 | 13.5 | 25.0 | 2.8 | 0.0 |
| Solution concept | 269 | 28.8 | 13.8 | 16.2 | 15.3 | 13.3 | 4.8 | 0.7 |
| Results opening | 47 | 45.1 | 10.9 | 13.1 | 13.0 | 0.0 | 6.4 | 0.0 |
| Complete-information benchmark | 182 | 48.1 | 9.7 | 12.3 | 11.8 | 7.1 | 4.4 | 0.0 |
| Private information in the terminal round | 154 | 42.2 | 11.1 | 12.4 | 12.0 | 9.1 | 3.9 | 0.0 |
| Private majority in Round 1 | 258 | 36.4 | 11.6 | 13.9 | 13.0 | 16.7 | 4.7 | 0.0 |
| Private unanimity in Round 1 | 272 | 21.1 | 14.7 | 16.3 | 15.0 | 11.8 | 5.9 | 0.0 |
| Comparing the private games | 206 | 11.4 | 15.0 | 15.6 | 13.8 | 17.6 | 8.3 | 0.0 |
| Informational rents and the difference of differences | 380 | 14.5 | 15.2 | 16.1 | 14.5 | 20.0 | 6.1 | 0.3 |
| Pivotality, substitutes, and contested strength | 265 | 27.9 | 12.8 | 14.2 | 13.4 | 4.8 | 8.3 | 0.0 |
| OPEC, the WTO, and observable implications | 199 | 8.6 | 16.5 | 18.1 | 15.9 | 9.1 | 7.5 | 1.0 |
| Limits | 123 | 37.2 | 11.9 | 14.9 | 13.8 | 12.5 | 5.7 | 0.8 |
| Conclusion | 126 | 10.3 | 17.0 | 19.8 | 17.3 | 0.0 | 10.3 | 0.0 |
| A.1 Complete transition and payoff rules | 139 | 56.4 | 8.8 | 11.6 | 11.8 | 20.0 | 2.9 | 0.0 |
| A.2 Beliefs and ballot restrictions | 100 | 30.0 | 12.2 | 14.6 | 13.2 | 0.0 | 7.0 | 2.0 |
| B.1 Public-benchmark proof | 179 | 38.4 | 11.1 | 14.5 | 13.3 | 6.7 | 10.6 | 0.0 |
| B.2 Terminal-games proof | 99 | 46.3 | 9.8 | 13.5 | 12.4 | 33.3 | 8.1 | 0.0 |
| B.3 Private-majority proof | 258 | 42.7 | 11.0 | 15.9 | 14.2 | 5.6 | 5.0 | 0.4 |
| B.4 Private-unanimity proof | 472 | 42.0 | 11.1 | 13.9 | 13.4 | 6.2 | 5.1 | 0.0 |
| B.5 Private-comparison proof | 63 | 36.0 | 12.0 | 15.9 | 14.2 | 0.0 | 9.5 | 0.0 |
| B.6 Rent and difference-of-differences proofs | 125 | 45.4 | 10.7 | 13.0 | 12.4 | 0.0 | 6.4 | 0.0 |
| C.1 Endpoint equivalence | 76 | 32.2 | 12.5 | 16.1 | 14.3 | 0.0 | 7.9 | 0.0 |
| C.2 Exact correspondence and envelopes | 86 | 31.1 | 12.0 | 13.8 | 13.0 | 14.3 | 9.3 | 2.3 |
| C.3 Worked values | 74 | 54.9 | 7.7 | 9.4 | 9.5 | 0.0 | 6.8 | 0.0 |
| Appendix D: Notation | 192 | -115.4 | 66.1 | 68.4 | 36.4 | 0.0 | 6.8 | 0.0 |

## 3. Diagnostic by section

### Introduction

The opening has acceptable academic readability but high passive and
nominalization rates. Some of this is structural language ("is publicly
known", "is conditional") and repeated field vocabulary. A later prose pass
could shorten the long results-preview paragraph and replace a few abstract
nouns with actors and verbs. This is not a mathematical finding.

### Model and payoff protocol

Passive voice peaks in "Ballots, timing, and payoffs" because the section must
state who receives what after mechanically defined events ("is implemented",
"are multiplied"). Rewriting every sentence actively would make the protocol
less compact and could obscure the identity of the rule rather than a player as
the causal subject. The metric is therefore a warning, not a reason to alter
the frozen transition system.

### Private comparison and rents

These sections combine set-valued estimands, institutional comparisons, and
several qualified parameter cells. Their Flesch values are low and passive
rates high, but Fog and SMOG remain around the benchmark median or better.
The most useful editorial response is already present: intuition precedes each
formal statement, type components stay separate, and the empty correspondence
is never filled.

### OPEC/WTO discussion

This is the weakest substantive prose section by Fog and Flesch. A later
authorial pass could divide the longer sentences and replace clusters such as
"institutional concessions that arise because partners cannot confidently
price" with shorter actor-verb sentences. No such revision is needed to assess
the correctness of the current migration.

### Conclusion

The conclusion is short but dense: it compresses the benchmark, the rent
decomposition, three sign cases, and the empty cell into two paragraphs. The
high Fog, SMOG, and nominalization scores support a future light rewrite after
the author confirms which interpretive language should survive P1 and P2.

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
