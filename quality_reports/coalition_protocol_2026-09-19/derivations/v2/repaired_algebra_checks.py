#!/usr/bin/env python3
"""Exact finite arithmetic checks for F-001; no equilibrium review or v1 writes."""

from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json


def check_case(m: int, beta: Q, o: Q) -> dict:
    k = (m + 1) // 2
    original_difference = 1 - k * beta * (1 - beta * o) / m - beta**2 * o
    corrected = 1 - k * beta / m - beta**2 * o * (1 - Q(k, m))
    strict_margin = beta * (1 - Q(k, m)) * (1 - beta * o)
    old_product = (1 - beta**2 * o) * (1 - k * beta / m)
    old_error = Q(k, m) * beta**2 * o * (1 - beta)
    tests = {
        "corrected_identity": original_difference == corrected,
        "margin_identity": corrected - (1 - beta) == strict_margin,
        "strict_bound": corrected > 1 - beta > 0,
        "old_product_error_identity": original_difference - old_product == old_error,
        "old_product_is_unequal": original_difference != old_product,
    }
    return {
        "m": m,
        "k": k,
        "beta": str(beta),
        "o": str(o),
        "in_public_inclusion_branch": o <= Q(1, m),
        "difference": str(original_difference),
        "corrected": str(corrected),
        "one_minus_beta": str(1 - beta),
        "strict_margin": str(strict_margin),
        "old_product": str(old_product),
        "old_product_error": str(old_error),
        "checks": tests,
    }


def main() -> None:
    grid = (Q(1, 1000), Q(1, 10), Q(1, 2), Q(9, 10), Q(999, 1000))
    cases = []
    for m in range(3, 25):
        payoffs = sorted(set(grid + (Q(1, 1000 * m), Q(1, 2 * m), Q(1, m))))
        for beta in grid:
            for o in payoffs:
                cases.append(check_case(m, beta, o))
    witness = check_case(4, Q(9, 10), Q(1, 10))
    witness_checks = {
        "reported_lhs": witness["difference"] == "1019/2000",
        "reported_old_rhs": witness["old_product"] == "10109/20000",
        "reported_discrepancy": witness["old_product_error"] == "81/20000",
    }
    results = [value for case in cases for value in case["checks"].values()]
    results.extend(witness_checks.values())
    path = Path(__file__).resolve()
    result = {
        "status": "arithmetic_checks_completed",
        "scope": "F-001 only: exact rational identities and strict inequality on a finite grid",
        "independent_review": "pending; these checks do not establish a candidate PASS",
        "excluded_scope": "No numerical claim about the measure-theoretic F-002 lemma; no v1 rerun or write",
        "script_sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
        "parameter_cases": len(cases),
        "passed": sum(results),
        "failed": len(results) - sum(results),
        "reported_counterexample": witness,
        "reported_counterexample_checks": witness_checks,
        "cases": cases,
    }
    output = path.with_suffix(".json")
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key: result[key] for key in
                      ("status", "parameter_cases", "passed", "failed", "independent_review")}))
    raise SystemExit(1 if result["failed"] else 0)


if __name__ == "__main__":
    main()
