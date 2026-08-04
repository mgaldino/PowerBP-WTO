# Independent Gate 0 extensive-form audit

**Scope:** Gate 0 only; no analytical-equilibrium claims reviewed.
**Reviewer:** independent read-only agent `/root/gate0_reviewer`.
**Editing status:** the reviewer did not edit any project file.

## Round 1

**Reviewed commit:** `3e3af6a907c6e64224df052032991ffa4f691dac`
**Verdict:** `REPAIR`

No critical issue was found in the history table, terminal payoffs, quotas, or
immediate opt-out. Three major findings prevented PASS:

1. **Missing common-knowledge and solution-concept primitives.** The contract
   did not explicitly state that its primitives and rules were common
   knowledge or adopt PBE with result-specific scope.
2. **Incomplete information-set indexing and posterior-sufficient
   continuation.** Vote distributions were conditioned on the pre-proposal
   history rather than on `(history, proposal)`, and `C_H2(theta,nu)` implicitly
   imposed a posterior-sufficient continuation. Public histories with the same
   posterior but different proposals or dissenters can support different R2
   strategies and payoffs.
3. **Incorrect R2 cutoff prose.** The stated R2 IC implies
   `EU_yes-EU_no=beta*p*(y-o_theta)`, so every `p>0`, not only `p=1`, has the
   sign of `y-o_theta`; at `p=0`, H is indifferent.

The reviewer independently approved the G01--G21 partition as exhaustive and
mutually exclusive and confirmed no double payment, reinclusion, burn of `y`,
quota recalculation, or continuation beyond R2. Editorial observations asked
that the checklist cite the correct opt-out rows and that the document state
`z in {1,...,m}` explicitly.

## Implementer response

| Finding | Response | Verification |
|---|---|---|
| Common knowledge/PBE absent | Added a common-knowledge and solution-concept section enumerating strategies, beliefs, sequential rationality, Bayes consistency, and required result scope | textual markers and rereview |
| Proposal absent from IC information set; continuation collapsed to posterior | Defined `I=(h,s_i)` and complete `h2`; conditioned vote distributions and ICs on `I`; indexed continuation by `h2` separately from `nu(h2)` | history checks, counterfactual rereview |
| R2 cutoff prose false | Derived `beta*p*(y-o_theta)`, distinguished `p>0` from `p=0`, and retained the local `p=1` threshold scope required by the Goal | positive- and zero-probability controls |
| Checklist/domain observations | Corrected row citations and stated `z in {1,...,m}` | exhaustive enumeration for `N=3,...,60` |

The implementer also split the canonical 19-column table into four keyed PDF
panels after visual inspection found the original landscape table clipped. The
versioned TSV remained the single exhaustive source.

## Round 2 rereview

**Reviewed commit:** `fff4a35d1572c08bb2098cae9ad264a2eba80b41`
**Verdict:** **PASS without substantive reservation**

The reviewer found no critical, major, or minor substantive issue. It confirmed:

- common knowledge and PBE are explicit;
- `I=(h,s_i)` includes the public proposal;
- complete `h2` includes proposal, H vote, weak vote vector, quota outcome, and
  opt-out status;
- `sigma_W` and ICs are proposal-indexed;
- `C_H2(theta,h2)` and `nu(h2)` are separate objects;
- Bayes is stated wherever its denominator is positive;
- the R2 algebra is correct for `p>0` and `p=0` and is not promoted as a global
  R1 cutoff;
- G01--G21 remain exhaustive and mutually exclusive;
- 36/36 protocol checks pass;
- HTML and the valid 12-page PDF are present with no unresolved references;
- `formal_model_v6.Rmd`, `formal_model_v6.pdf`, and `formal_model_v5.Rmd` do
  not differ from the provenance tag.

The SHA-256 of `formal_model_v6.Rmd` at rereview was
`f18a999300c88e32bdc7542f3249cd258afd19a0c251c0b29c2c387a7131dbc1`.

Administrative observation only: the reviewed candidate still displayed
`PENDING`, as required before the verdict. Recording this PASS does not alter
the audited game contract.
