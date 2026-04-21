# Plano: Research Pipeline — formal_model_v2.Rmd

**Status**: COMPLETED
**Data**: 2026-04-20

## Objetivo
Executar pipeline completo de qualidade no manuscrito `formal_model_v2.Rmd` (paper para RIO).

## Arquivos
- Manuscrito: `formal_model_v2.Rmd`
- Código: R chunks embutidos no Rmd (figuras de concavificação e regiões paramétricas)
- Bib: `references.bib`

## Estágios
- [x] Stage 1: Code Review (R chunks) — Score 86/100. PASS.
- [x] Stage 2: Devil's Advocate — Score 45/100. BLOCKED. 3 blocking issues identified.
- [ ] Stage 2 fixes (partial): Lemma 1 cut, Appendix C added, Appendix E ref fixed.
- [ ] Stage 2 fix (user): Theorem 1 Step 2 proof — user will resolve.
- [ ] Stage 3: Proofread — deferred until Stage 2 blocking issues resolved.

## Modo
Standard (com aprovação do usuário no proofread).

## Fixes applied (2026-04-20)
1. **Lemma 1 cut** — vacuous entry comparison lemma removed.
2. **Appendix C added** — full derivation of partial agenda influence extension (R2+R1 under unanimity and majority with bias, jump formula, non-monotonic effects, entry thresholds).
3. **Broken reference fixed** — "Appendix E" → "Appendix C" in Section 9.

## Remaining blocking issues
- **Theorem 1 Step 2**: proof that majority dominates at high priors. User will resolve.
- **Alternative explanations**: paragraph needed (legitimacy, self-enforcement, issue linkage).
- **Missing literature**: Feddersen & Pesendorfer, Austen-Smith & Banks.
- **WLOG convention discussion**: needs explicit acknowledgment.
- **BP commitment assumption**: discuss in model section.
