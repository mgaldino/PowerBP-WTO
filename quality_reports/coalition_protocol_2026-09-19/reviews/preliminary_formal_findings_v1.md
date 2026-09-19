# Preliminary formal findings received from independent reviewer

Reviewer: /root/baseline_source_read. Candidate: coalition-derivations-v1, bundle b62a7c8e023568bf408c1b8929b5909b4e7af21c3271c95955970237801b799f. These are early findings communicated during the full review; this record does not replace the eventual complete report.

## F-001

In agenda_transport A-C5 / bundle 615–619, the asserted factorization 1−kβ(1−βo)/m−β²o = (1−β²o)(1−kβ/m) is false. At m=4, β=.9, o=.1 the two sides are .5095 and .50545. The correct expression is 1−kβ/m−β²o(1−k/m)>1−β>0. The public benchmark remains unchanged.

## F-002

Original B.8, Rmd lines 1889–1893 and 1938–1943, invokes x^h as an off-support deviation without covering a zero-mass point x^h in supp(barσ). No counterexample to the result was found. A repair is available: if V<z_H, choose a sufficiently small ball around x^h with x_H>V throughout. A used zero-posterior proposal in that ball can neither pass (giving more than V) nor reject (giving low type β²ℓ<d≤V). Hence μ>p* almost everywhere in every such ball. Bayes makes the local mass ratio at least p*. If x^h is supported, its admissible local posterior is consequently above p*, and it passes for z_H>V. If unsupported and μ_off>p*, it also passes. Therefore V=z_H, and the proposal laws concentrate at x^h. This also rules out a low-posterior family with a high off-support posterior.
