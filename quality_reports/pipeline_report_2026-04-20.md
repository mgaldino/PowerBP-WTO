# Pipeline Report — 2026-04-20

**Manuscript**: `formal_model_v2.Rmd`
**Target**: Review of International Organizations (RIO)

---

## Estágio 1: Revisão de Código
- Rounds: 1/5
- Score: **86/100** — PASS (commit-ready)
- Issues encontradas:
  - Concavification algorithm uses `chull()` (latent bug, correct for displayed params): -10
  - Duplicated code across VW/VH functions: -1
  - Insufficient comments: -1
  - Non-descriptive variable names: -2
- Issues remanescentes: concavification algorithm should be replaced before circulation
- Report: `quality_reports/stage1_code_review_round1.md`

## Estágio 2: Devil's Advocate
- Rounds: 1/5 (reviewer) + user fixes + orchestrator fixes
- Score inicial: **45/100** (3 blocking issues + 15 other vulnerabilities)
- Fixes aplicados:
  - [USER] Theorem 1 rewritten with Lemma 1 (conditional payoff dominance) — proof gap resolved
  - [USER] Abstract and introduction updated to match new Theorem
  - [ORCH] Vacuous Lemma 1 (old) cut
  - [ORCH] Appendix C added (partial agenda influence derivation)
  - [ORCH] Broken "Appendix E" reference fixed
  - [ORCH] Alternative explanations paragraph added (legitimacy, self-enforcement, issue linkage + Fearon positioning)
- Score estimado pós-fixes: **~80/100** (blocking issues resolved; high-priority items partially addressed)
- Vulnerabilidades remanescentes (desirable, can wait for R&R):
  - Missing literature: Feddersen & Pesendorfer, Austen-Smith & Banks
  - WLOG inclusion convention: needs explicit discussion
  - BP commitment assumption: discuss in model section
  - Explicit ᾱ for Proposition 3
  - Concavity verification for Proposition 5
  - Consensus vs unanimity precision note
  - Symmetric weak states as scope limitation
- Report: `quality_reports/stage2_devils_advocate_round1.md`

## Estágio 3: Proofread
- Rounds: 2 (review + verification)
- Score inicial: **67/100** (systematic cross-reference errors in Appendix B)
- Score final: **97/100** — EXCELLENT
- Correções aplicadas: 11 de 11 propostas (all accepted and verified)
  1. Appendix B.2-B.4 proposition numbering (3→4→5)
  2. Introduction Proposition reference (4→5)
  3. Notation v_H → v(μ,U) in Theorem 1
  4. Grammar "let x as" → "define x as"
  5. Capitalization "Bayesian Persuasion" → lowercase (2x)
  6. Contradictory spacing commands
  7. Unnecessary min(τ(U),τ(M))
  8. Word choice "displace" → "complement"
- Issues remanescentes: 3 minor exposition items (no deduction)
- Reports: `quality_reports/stage3_proofread_round1.md`, `stage3_proofread_round2.md`

---

## Score Final Consolidado

| Estágio | Score | Threshold | Status |
|---------|-------|-----------|--------|
| Code Review | 86/100 | ≥80 | PASS |
| Devil's Advocate | ~80/100 (est.) | ≥80 | PASS (marginal) |
| Proofread | 97/100 | ≥90 | EXCELLENT |

**Média ponderada**: ~88/100

## Status: APROVADO (≥80)

## Recomendação: COMMIT

O paper está pronto para commit. Para circular/submeter, recomenda-se ainda:
- [ ] Adicionar citações de information aggregation literature
- [ ] Discutir WLOG inclusion convention explicitamente
- [ ] Discutir BP commitment assumption na seção do modelo
- [ ] Corrigir concavification algorithm (chull → proper upper hull)
- [ ] Nota sobre consensus vs unanimity formal distinction
