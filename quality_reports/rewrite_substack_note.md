# Reescrita: Substack post — Why Would a Hegemon Accept Consensus?

**Arquivo original**: `substack_note.Rmd`
**Data**: 2026-05-01

---

```
---
title: "Why Would a Hegemon Accept Consensus?"
subtitle: "Informational Power, Screening, and Institutional Design"
author: "Manoel Galdino"
date: "`r Sys.Date()`"
output:
  html_document:
    theme: readable
    fig_width: 10
    fig_height: 5
bibliography: references.bib
link-citations: true
---
```

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)
```

In December 1985, Saudi Arabia abandoned its role as OPEC's swing producer and opened the taps. Within months, oil prices collapsed from \$28 to under \$9 per barrel. By mid-1986, OPEC members who had been cheating on their quotas were desperate to negotiate. Saudi Arabia came back to the table and secured a production share nearly double what it had before the crisis.

OPEC operates by unanimity. Every member, no matter how small, can block a decision. Saudi Arabia has no formal veto that others lack, no weighted vote, no privileged agenda-setting role. Why would the most powerful producer in the cartel accept a decision rule that gives Nigeria the same blocking power as Saudi Arabia?

The same pattern appears elsewhere. The WTO operates by consensus. So do parts of the UN system. Most international organizations give powerful states fewer formal advantages than their material power would predict [@gould2016consensus]. In legislative bargaining models [@baron1989bargaining], a powerful player benefits from majority rule: it assembles a minimum winning coalition, excludes the rest, and captures most of the surplus. Under consensus, everyone has a veto, and coalition-based extraction disappears.

## The argument

My paper ["Informational Power Through Pivotality"](https://osf.io/preprints/socarxiv/ca8vj_v3) develops a formal model of institutional design in which a hegemon chooses between majority and unanimity. Two kinds of power are at work, and they interact with voting rules in opposite ways.

Agenda power is the ability to propose allocations and form coalitions. Under majority rule, a proposer can exclude rivals and keep the surplus [@baron1989bargaining; @kalandrakis2006proposal]. Informational power is the bargaining advantage that comes from knowing something others don't. In many international settings, the hegemon has superior information about the value of cooperation: analytical capacity, intelligence infrastructure, expertise about the quality of proposed agreements. The question is whether that private information translates into concrete bargaining advantage, and the answer depends on the voting rule.

Under unanimity, every agreement requires the hegemon's approval, and that requirement forces weaker states to make offers under uncertainty. Unanimity activates informational power. Majority rule eliminates it.

## How screening works

When a weaker state proposes terms under unanimity, it must decide how much to offer the hegemon without knowing how valuable cooperation really is.

Take the OPEC case. Saudi Arabia knows its true spare production capacity, meaning how much additional oil it can bring to market within 90 days. This determines the value of the cartel agreement for everyone, because it governs the credibility and costliness of the punishment that follows a breakdown. Other OPEC members cannot independently verify Saudi claims, and expert estimates diverge by 40 to 80 percent [@fattouh2013opec].

A proposing weak state has two strategies. It can make an aggressive offer, paying the hegemon only what its outside option is worth in the low state. If cooperation is genuinely valuable (the high state), the hegemon rejects, because its outside option exceeds the offer. If cooperation is less valuable (the low state), the hegemon accepts. Alternatively, the weak state can make a conservative offer, paying the hegemon enough to guarantee acceptance regardless of the true state. The conservative offer is safe but costly: in the low state, the hegemon receives more than its outside option is actually worth.

The proposer's choice depends on its beliefs. When it is pessimistic enough about the value of cooperation, it plays aggressively. When it is optimistic enough, it switches to the conservative offer. The belief threshold at which the proposer switches from aggressive to conservative treatment is the screening cutoff.

The switch creates a discrete jump in the hegemon's expected payoff. On the conservative branch, the low-type hegemon gets paid as if it might be the high type. The weak state cannot avoid this cost because it must secure the hegemon's vote without knowing the type. This overpayment is the screening rent.

## Why majority eliminates the rent

Under majority rule, weak states can form winning coalitions without including the hegemon. When a weak state proposes, it assembles a majority from other weak states. The hegemon, excluded from the coalition, captures its bilateral alternative regardless of what anyone believes about the state of the world.

Without inclusion, there is no screening problem. Without a screening problem, there is no informational rent. Majority rule turns bargaining into coalition arithmetic: the proposer buys the cheapest votes, and the hegemon collects its outside option. The hegemon's payoff under majority is a smooth, linear function of beliefs, with no discontinuity anywhere.

## The entry trade-off

Screening benefits the hegemon at the expense of weak states. The same mechanism that raises the hegemon's payoff under unanimity lowers weak states' payoff. Weak states therefore need more favorable conditions to participate under unanimity than under majority. Some cooperation prospects sustain entry under majority but not under unanimity.

This generates a clean institutional classification. When cooperation is promising enough that weak states are willing to participate under unanimity, the hegemon strictly prefers it. When only majority can sustain entry, majority dominates through wider institutional viability, not through better bargaining terms. When neither rule can induce entry, the voting rule is irrelevant.

The paper's main theorem provides a sharp condition: when the hegemon's bilateral outside option is not too valuable relative to multilateral cooperation, unanimity gives the hegemon a strictly higher expected payoff than majority at every level of uncertainty.

## Back to OPEC

Saudi Arabia is the hegemon, with the largest spare capacity and extraction costs of approximately \$3 per barrel, the lowest in the world. The remaining OPEC members depend on Saudi restraint to sustain cartel rents. The cooperation surplus is the monopoly rent from collectively restricting supply. The state of the world is Saudi Arabia's true spare capacity, closely guarded since 1982, when Oil Minister Yamani discontinued field-by-field production reporting.

After the 1985-86 price war demonstrated the cost of non-cooperation, Saudi Arabia came back to the table under OPEC's unanimity rule and secured a guaranteed quota share of approximately 25 percent. Members did not know how long Saudi Arabia could sustain low prices or how costly renewed confrontation would be. When weaker members must decide how much to concede in quota negotiations, they do not know how painful a Saudi-led price war would actually be. That uncertainty is the source of Saudi Arabia's screening rent.

Recent events are consistent with this account. Angola left OPEC in January 2024 after its quota was cut. The UAE exited in April 2026, citing a persistent gap between its production capacity and its assigned quota. As a member's outside option improves, unanimity ceases to be individually rational. OPEC's response, commissioning independent capacity audits for member states, is a direct attempt to reduce the informational asymmetry that sustains screening rents.

## Implications

The paper identifies conditions under which unanimity is a rational choice for a hegemon: informational asymmetry about the value of cooperation, valuable outside options, and costly entry. Consensus, under these conditions, is an institutional arrangement that makes informational advantage productive for the privately informed actor.

Formal equality under consensus can coexist with asymmetric bargaining power. In organizations where the value of cooperation is difficult to assess, consensus may protect participation while also increasing the rents of actors with superior information. Reforms that improve transparency, independent technical assessment, and the analytical capacity of weaker members should weaken this informational advantage more directly than changing the voting rule alone.

The preprint is available on SocArXiv: [osf.io/preprints/socarxiv/ca8vj_v3](https://osf.io/preprints/socarxiv/ca8vj_v3).

# References
