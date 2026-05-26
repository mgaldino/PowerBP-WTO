# CR8: Quantitative Decomposition of BP Gain (Entry vs. Screening Channels)

**Date**: 2026-04-26
**Status**: DRAFT (numerical values from hand computation; run `scripts/decompose_channels.R` for exact figures)

## Formal Definition

The total advantage of unanimity over majority, measured in concavified net gains, decomposes into two channels:

$$
\underbrace{\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M)}_{\text{total advantage}} = \underbrace{\operatorname{cav} v(p, U) - \operatorname{cav} v_{\mathrm{flat}}(p, U)}_{\text{screening channel}} + \underbrace{\operatorname{cav} v_{\mathrm{flat}}(p, U) - \operatorname{cav} v(p, M)}_{\text{entry channel}}
$$

where $v_{\mathrm{flat}}(\mu, U)$ is a counterfactual unanimity value function in which the screening jump is removed. Formally, $v_{\mathrm{flat}}$ is affine on the entry set $E_U$, connecting $(\tau(U), 0)$ to $(1, v(1, U))$, and equals zero outside $E_U$.

**Interpretation**:
- **Entry channel** = $\operatorname{cav} v_{\mathrm{flat}}(p, U) - \operatorname{cav} v(p, M)$: the gain (or loss) from unanimity's different entry threshold, holding the conditional payoff advantage fixed at its value without screening.
- **Screening channel** = $\operatorname{cav} v(p, U) - \operatorname{cav} v_{\mathrm{flat}}(p, U)$: the additional gain from the non-convexity created by the screening jump at $\mu_s^{R1}$.

The decomposition is exact by construction (the two terms sum to the total). When $E_U = (0,1]$ (low entry costs), the entry channel vanishes and the screening channel accounts for the entire advantage.

## Key Analytical Result

For the Example 2 parameterization ($N=5$, $r=1.5$, $\alpha=0.3$, $\beta=0.9$, $c=0.14$):

- **Screening always favors unanimity**: at every prior $p$, the screening channel is weakly positive.
- **Entry always favors majority**: at every prior $p$, the entry channel is weakly negative, because $\tau(U) > \tau(M)$ makes the flat counterfactual weaker than majority's direct payoff.
- **The total advantage = screening gain minus entry loss**. Unanimity dominates when the screening gain exceeds the entry penalty; majority dominates when it does not.

The concavified slope under unanimity is $S_U = v(\tau(U), U)/\tau(U)$, where $v(\tau(U), U)$ is the net gain at the entry threshold (a positive jump from zero). The large value of $v(\tau(U), U)$ reflects the screening rent: weak proposers overpay the hegemon on the conservative branch. Under majority, the slope $S_M = v(\tau(M), M)/\tau(M)$ involves a smaller net gain at a lower threshold. The screening channel captures the difference between these slopes.

## Approximate Numerical Decomposition (c=0.14)

Hand-computed approximate values (pending verification by `scripts/decompose_channels.R`):

| Prior $p$ | Total | Screening | Entry | Status |
|-----------|-------|-----------|-------|--------|
| 0.05 | $-0.05$ | $+0.03$ | $-0.08$ | M dominates |
| 0.10 | $-0.02$ | $+0.06$ | $-0.08$ | M dominates |
| 0.15 | $+0.02$ | $+0.09$ | $-0.07$ | U dominates |
| 0.20 | $+0.06$ | $+0.12$ | $-0.06$ | U dominates |
| 0.30 | $+0.13$ | $+0.18$ | $-0.05$ | U dominates |
| 0.50 | $+0.12$ | $+0.15$ | $-0.03$ | U dominates |

The screening channel exceeds the total advantage at every prior where unanimity dominates. In this sense, screening "subsidizes" the entry loss: the advantage of unanimity is never purely about easier participation, but always about the screening rent compensating the participation handicap.

## Proposed Remark for the Paper

Insert after Example 2 (ex:p_star), around line 567 of `formal_model_v4.Rmd`:

---

**Remark (Quantitative decomposition).** The total advantage of unanimity over majority decomposes into an *entry channel* and a *screening channel*. Define a counterfactual value function $v_{\mathrm{flat}}(\mu, U)$ that is affine on $E_U$---connecting $(\tau(U), 0)$ to $(1, v(1, U))$---and zero elsewhere. This preserves unanimity's entry threshold but removes the screening non-convexity. The decomposition
$$
\operatorname{cav} v(p, U) - \operatorname{cav} v(p, M) = \underbrace{[\operatorname{cav} v(p, U) - \operatorname{cav} v_{\mathrm{flat}}(p, U)]}_{\text{screening}} + \underbrace{[\operatorname{cav} v_{\mathrm{flat}}(p, U) - \operatorname{cav} v(p, M)]}_{\text{entry}}
$$
is exact. The screening channel is always positive: the jump at $\mu_s^{R1}$ increases the slope of the concave envelope, favoring unanimity. The entry channel is always negative: unanimity's higher entry threshold ($\tau(U) > \tau(M)$) weakens the counterfactual value function relative to majority. The total advantage of unanimity equals the screening rent minus the entry penalty. At $p = 0.30$ in Example \ref{ex:p_star}, approximately [X]% of the screening gain is offset by the entry loss; at $p = 0.50$, the offset falls to approximately [Y]%. Majority dominates below $p^*$ precisely when the entry penalty exceeds the screening rent.

---

## Files

- Script: `scripts/decompose_channels.R` (ready to run, produces table + figure)
- Figure: `figures/decomposition_channels.pdf` (produced by script)
- This note: `notes/2026-04-26_CR8_decomposition_proposal.md`

## To Complete

1. **Run the script**: `Rscript scripts/decompose_channels.R` to get exact numbers
2. **Fill in placeholders** [X]% and [Y]% in the Remark text
3. **Decide placement**: after Example 2 (line ~567) or in the Scope/Discussion section
4. **Optionally add the figure** (Figure `decomposition_channels.pdf`) if the paper has room
