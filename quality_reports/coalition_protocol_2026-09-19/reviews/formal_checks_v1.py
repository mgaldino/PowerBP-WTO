#!/usr/bin/env python3
"""Independent finite checks of coalition-derivations-v1; not a proof.

Enumerates every feasible named coalition/allocation on the specified grid.
Ballot responses are evaluated from the primitive continuation payoffs. The
result is compared with the full named E/S/P argmax correspondence, including
the secondary proposer tie-break. Candidate scripts are never imported.
"""
from fractions import Fraction as F
from itertools import combinations
from pathlib import Path
import hashlib
import json

D = 20
H_UNITS = 60
BETA = F(3, 5)
ROOT = Path(__file__).resolve().parent


def allocations(n, remaining):
    if n == 1:
        for z in range(remaining + 1):
            yield (z,)
    else:
        for z in range(remaining + 1):
            for rest in allocations(n - 1, remaining - z):
                yield (z,) + rest


def exact_int(value):
    assert value.denominator == 1, value
    return int(value)


def proposals(m):
    k, proposer = (m + 1) // 2, 1
    wi = exact_int(D * BETA / m)
    other = [j for j in range(m + 1) if j != proposer]
    result = []
    for size in range(k + 1, m + 2):
        for partners in combinations(other, size - 1):
            coalition = tuple(sorted((proposer,) + partners))
            for amounts in allocations(size, D):
                x = [0] * (m + 1)
                for j, amount in zip(coalition, amounts):
                    x[j] = amount
                veto = any(x[j] < wi for j in coalition if j not in (0, proposer))
                result.append((coalition, tuple(x), veto, 0 in coalition))
    return result


def canonical(m, ell, high):
    k, proposer = (m + 1) // 2, 1
    wi = exact_int(D * BETA / m)
    weak_others = [j for j in range(1, m + 1) if j != proposer]
    result = []
    for label, invited_h, count, transfer in (
        ("E", False, k, F(0)),
        ("S", True, k - 1, BETA * ell),
        ("P", True, k - 1, BETA * high),
    ):
        for partners in combinations(weak_others, count):
            coalition = tuple(sorted((proposer,) + partners + ((0,) if invited_h else ())))
            x = [0] * (m + 1)
            x[0] = exact_int(D * transfer)
            for j in partners:
                x[j] = wi
            x[proposer] = D - sum(x)
            if x[proposer] >= 0:
                result.append((label, coalition, tuple(x)))
    return result


def state_priors(m, ell, high):
    k = (m + 1) // 2
    priors = {F(0), F(1, 2), F(1)}
    threshold = None
    if high < F(1, m):
        threshold = BETA * (high - ell) / (1 - BETA * ell - BETA * k / m)
    elif ell < F(1, m) <= high:
        threshold = BETA * (F(1, m) - ell) / (
            BETA * (F(1, m) - ell) + 1 - BETA * (k + 1) / m
        )
    if threshold is not None and 0 < threshold < 1:
        priors.update(t for t in (threshold - F(1, 100), threshold, threshold + F(1, 100))
                      if 0 <= t <= 1)
    if high == F(1, m):
        secondary_tie = (BETA * high - ell) / (high - ell)
        if 0 <= secondary_tie <= 1:
            priors.add(secondary_tie)
    return sorted(priors)


def evaluate_rank(proposal, m, mu, outside, discounted):
    coalition, x, veto, invited_h = proposal
    wi = exact_int(D * BETA / m)
    weights = (mu.denominator - mu.numerator, mu.numerator)
    proposer_values, h_values = [], []
    for t in (0, 1):
        # If another invited weak responder vetoes, H's prescribed vote is Y
        # by T^Y and failure occurs anyway. Otherwise H accepts at beta * o.
        passed = not veto and (not invited_h or 3 * x[0] >= discounted[t])
        proposer_values.append(x[1] if passed else wi)
        h_values.append((3 * x[0] if invited_h else outside[t]) if passed else discounted[t])
    return (sum(a * b for a, b in zip(weights, proposer_values)),
            -sum(a * b for a, b in zip(weights, h_values)))


states = []
failures = []
proposal_counts = {}
comparisons = 0
for m in (3, 4):
    ps = proposals(m)
    proposal_counts[m] = len(ps)
    wi = exact_int(D * BETA / m)
    for ell, high in ((F(1, 12), F(1, 6)), (F(1, 12), F(1, 2)),
                      (F(1, 2), F(3, 4)), (F(1, m), F(3, 4)), (F(1, 12), F(1, m))):
        outside = tuple(exact_int(H_UNITS * o) for o in (ell, high))
        discounted = tuple(exact_int(H_UNITS * BETA * o) for o in (ell, high))
        candidates = canonical(m, ell, high)
        for mu in state_priors(m, ell, high):
            best, maximizers = None, set()
            for proposal in ps:
                rank = evaluate_rank(proposal, m, mu, outside, discounted)
                named = proposal[:2]
                if best is None or rank > best:
                    best, maximizers = rank, {named}
                elif rank == best:
                    maximizers.add(named)
            comparisons += len(ps)
            weights = (mu.denominator - mu.numerator, mu.numerator)
            expected, predicted = None, set()
            for label, coalition, x in candidates:
                pv = (x[1], wi) if label == "S" else (x[1], x[1])
                hv = outside if label == "E" else discounted if label == "S" else (discounted[1], discounted[1])
                rank = (sum(a * b for a, b in zip(weights, pv)),
                        -sum(a * b for a, b in zip(weights, hv)))
                if expected is None or rank > expected:
                    expected, predicted = rank, {(coalition, x)}
                elif rank == expected:
                    predicted.add((coalition, x))
            row = {"m": m, "ell": str(ell), "h": str(high), "mu": str(mu),
                   "value_match": best == expected, "argmax_match": maximizers == predicted,
                   "number_of_maximizers": len(maximizers)}
            states.append(row)
            if not row["value_match"] or not row["argmax_match"]:
                failures.append(row)

result = {
    "candidate": "coalition-derivations-v1",
    "reviewer": "/root/baseline_source_read",
    "scope": "Finite exact R1_M grid: all named coalitions and all grid allocations, including slack and oversized coalitions; not a continuum proof, R1_U test, or Borel-law enumeration.",
    "grid_denominator": D,
    "h_payoff_denominator": H_UNITS,
    "beta": str(BETA),
    "states": len(states),
    "assertions": 2 * len(states),
    "proposal_state_comparisons": comparisons,
    "proposal_counts": proposal_counts,
    "failures": len(failures),
    "state_results": states,
    "failure_details": failures,
    "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
}
output = ROOT / "formal_checks_v1.json"
output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({k: result[k] for k in ("grid_denominator", "beta", "states", "assertions", "proposal_state_comparisons", "proposal_counts", "failures")}))
raise SystemExit(bool(failures))
