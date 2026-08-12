# Pivotal-response full-chain release candidate

**Date:** 2026-08-12  
**Status:** `candidate_pending_final_read_only_reviews`  
**Migration authority:** none

## Outcome

The independently derived two-round PBE chain is analytically frozen through the nonmigrating v6 survival inventory. The integrated standalone report now consumes those frozen interfaces without reopening any equilibrium node. Its PDF and HTML renders are complete, and the full-chain verifier returns **25/25 PASS**.

This status is deliberately not the final release verdict. The exact bytes listed below must still pass two independent read-only reviews: one formal-model/integration review and one adversarial game-theory, reproducibility, and visual review.

## Locked release candidate

| Artifact | SHA-256 | Size/status |
|---|---|---:|
| `model_redesign/pivotal_response_interfaces/pivotal_response_full_chain_release_v1.json` | `d06fe49b9ae90b9f6def399b45b27aec264342a3a460722cbb38d633d373e917` | immutable candidate |
| `model_redesign/pivotal_response_rederivation.Rmd` | `de956ec7f84c37991494e87962317369d382674783d7af4de648c56be1cd0b66` | 43,325 bytes |
| `model_redesign/pivotal_response_rederivation.pdf` | `6ff930e1a3d3ba11a0b9630149a42a23bdb1ef204b71ece7e17f5ece62594126` | 293,990 bytes; 60 pages |
| `model_redesign/pivotal_response_rederivation.html` | `0867d1cde8bceebcf57bc414a8e9ddb600f1a4d3e847c2bb3b6f7a423472ad44` | 1,088,943 bytes |
| `model_redesign/pivotal_response_rederivation.tex` | `9a5b27196d956bc95d99e5645956559bd2e1e6877ada03291819f2e19604c6bd` | 253,603 bytes |
| `scripts/verify_pivotal_response_full_chain.R` | `3d4537dd9042d3237f7a315473cb1a3cef154dae8901a9978f9ed640e0a16864` | 25/25 PASS |
| `tables/pivotal_response_full_chain_checks_v1.csv` | `1b947c5049b3262f0802ef635be38f7ce6a95689207349edec8ad79e6a366da1` | 25 PASS rows |

## Frozen analytic roots

The release candidate binds exact hashes for:

1. Gate 0 bundle: `6e28cb3faf3b70bc5ed990ce35a9e39326be15f93252e93e6663d771e2b0b7c1`.
2. R2 batch review: `00f84d4221d100f0def858e8c8bf19a58f79522f217118693837edf73583316a`.
3. R1 batch freeze: `f4ac7b89f4c08d4ee461ca1431135286304abaae2589a337aeffdb38b5941c3a`.
4. Entry batch review: `8817a9c505ce9e5b79deea1b38055d88a629e740e324fbcd5bca707b108b5433`.
5. Institutional-comparison review: `0acd9648eb7e03d4dabfaa91ffd559fe3c5b6f61a96ba676d6c6ccd9d4c6bb3c`.
6. Survival-matrix review: `80c912ba35fc46bdb1859edeb91402dcb63f52079cd3ca8c4aeeb4b98b0077a7`.

The final DAG is `4b7aa1b9647791b7e2b3a62fd21c1b782982eca40d44414c8e23f88140b166c0`; the proof ledger is `23d0566aa55aeac74b43819d907c9022ed02e065210694d26dda7b13283c1750`. The `solve-dynamic-games` checker reports `VALID` and `Ready: none`.

## Mechanical validation

Command:

```bash
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 Rscript --vanilla scripts/verify_pivotal_response_full_chain.R
```

Result: **25/25 PASS**. The verifier checks:

- all six frozen analytic roots;
- the final DAG, proof ledger, and protected manifest;
- all 27 protected files, including the untouched `formal_model_v6.Rmd`;
- expected row counts and stage-sensitive states in eight recorded check tables;
- exact hashes and sizes of Rmd, PDF, HTML, and TeX;
- required and prohibited rendered-text markers;
- a clean isolated two-pass XeLaTeX compilation;
- absence of material LaTeX/reference warnings;
- successful rasterization of all 60 PDF pages.

The historical Gate 0 and R1 batch check tables contain only their exact expected stage-sensitive failures after authorized descendants were completed. Those are lifecycle guards, not substantive failures; the immutable Gate 0 and R1 freeze bundles remain the authoritative PASS records.

## Boundary

No protected manuscript or historical artifact was edited. In particular, `formal_model_v6.Rmd` remains at SHA-256 `131cc2356cd6318211fdbb9304ac8d7c8a99356837b6e71097011c36ae9c270d`. This candidate authorizes neither manuscript migration nor a claim that the old scalar theorem architecture survives.
