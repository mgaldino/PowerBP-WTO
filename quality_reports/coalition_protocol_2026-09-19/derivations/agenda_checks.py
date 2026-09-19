#!/usr/bin/env python3
"""Exact finite checks for the coalition-agenda derivation; not a proof substitute."""
from fractions import Fraction as Q
from itertools import combinations
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parent
checks = []

def record(name, condition, details):
    checks.append({"name": name, "pass": bool(condition), "details": details})

def serial(value):
    if isinstance(value, Q):
        return str(value)
    if isinstance(value, dict):
        return {k: serial(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [serial(v) for v in value]
    return value

def coalitions(m, k):
    return [frozenset((0,) + group) for s in range(k, m + 1)
            for group in combinations(range(1, m + 1), s)]

def feasible(C, x):
    return 0 in C and sum(x) <= 1 and min(x) >= 0 and all(
        x[j] == 0 for j in range(len(x)) if j not in C)

def passes(C, x, r):
    return feasible(C, x) and all(x[j] >= r for j in C if j != 0)

# Grid checks of the conditional E/S/P interface and strict oversized bound.
for m in range(3, 13):
    k = (m + 1) // 2
    for beta in (Q(1, 10), Q(1, 2), Q(9, 10), Q(99, 100)):
        w = beta / m
        floor = (1 - w) / m
        safe = 1 - k * w
        record(f"oversized-m{m}-b{beta}", 1 - (k + 1) * beta * floor < safe,
               {"margin": safe - (1 - (k + 1) * beta * floor)})
        for ell in (Q(1, 10) / m, Q(1, 2) / m, Q(99, 100) / m):
            t = beta * ell
            p_se = (w - t) / (1 - k * w - t)
            for mu in (Q(0), p_se / 2, p_se):
                pi_e = 1 - k * w
                pi_s = (1 - mu) * (1 - (k - 1) * w - t) + mu * w
                c_s = ((1 - mu) * (1 - t) + mu * beta) / m
                identity = m * c_s - (1 - w) == (pi_s - pi_e) + mu * (beta - k * w)
                record(f"screen-floor-m{m}-b{beta}-l{ell}-mu{mu}",
                       identity and c_s >= floor and pi_s >= pi_e,
                       {"identity": identity, "c_s": c_s, "floor": floor})

# Coalition alone is a signal: same vector passes for low C and fails for high C.
m, k, beta, ell, high = 4, 2, Q(9, 10), Q(1, 10), Q(9, 10)
w = beta / m
safe = 1 - k * w
r0 = beta * (1 - beta * ell) / m
r1 = w
x = (safe, w, w, Q(0), Q(0))
cl, ch = frozenset((0, 1, 2)), frozenset((0, 1, 2, 3))
record("coalition-only-signal-feasibility", feasible(cl, x) and feasible(ch, x), {"x": x})
record("coalition-only-signal-outcomes", passes(cl, x, r0) and not passes(ch, x, r1),
       {"r0": r0, "r1": r1})
vl, vh = safe, beta * high
off_l, off_h = max(safe, beta * ell), max(safe, beta * high)
record("coalition-only-signal-IC", vl >= beta * ell and vh >= vl and vl >= off_l and vh >= off_h,
       {"values": (vl, vh), "off": (off_l, off_h)})

# A passing old allocation with a small gift cannot pass under any feasible C.
mu, high = Q(1, 10), Q(3, 5)
c_s = ((1 - mu) * (1 - beta * ell) + mu * beta) / m
r = beta * c_s
old_x = (Q(14, 25), r, r, Q(1, 100), Q(0))
old_pass = sum(z >= r for z in old_x[1:]) >= k
record("old-gift-is-passing", old_pass and sum(old_x) <= 1, {"x": old_x, "r": r})
record("old-gift-pooling-IC", old_x[0] >= max(safe, beta * high),
       {"value": old_x[0], "off_high": max(safe, beta * high)})
record("old-gift-no-new-passing-preimage", not any(passes(C, old_x, r) for C in coalitions(m, k)),
       {"feasible_coalitions": sum(feasible(C, old_x) for C in coalitions(m, k))})

# Existing worked reversal has a concrete new-coalition witness on common rho=0.
p, high = Q(19, 20), Q(9, 10)
a0 = 1 - k * r0
z_u = beta * beta * high
r_u_high = beta * (1 - beta * high) / m
xm_low = (a0, r0, r0, Q(0), Q(0))
xm_high = (Q(1), Q(0), Q(0), Q(0), Q(0))
xu = (z_u,) + ((1 - z_u) / m,) * m
v_m_high = beta * high
record("reversal-majority-IC",
       passes(cl, xm_low, r0) and not passes(cl, xm_high, w)
       and a0 >= max(a0, beta * beta * ell) and a0 >= beta * ell
       and v_m_high >= max(a0, beta * beta * high),
       {"majority_values": (a0, v_m_high)})
z_l = 1 - beta + beta * beta * ell
z_h = 1 - beta + beta * beta * high
p_star = (high - ell) / (1 - ell)
record("reversal-unanimity-IC", p > p_star and passes(frozenset(range(m + 1)), xu, r_u_high)
       and z_u >= max(z_l, beta * beta * high) and z_u <= z_h,
       {"unanimity_value": z_u, "p_star": p_star})
delta_public = z_l - a0
delta_private = z_u - a0
delta_ir = delta_private - delta_public
record("reversal-table-values", (a0, z_l, z_u, delta_public, delta_private, delta_ir) ==
       (Q(1181, 2000), Q(181, 1000), Q(729, 1000), -Q(819, 2000), Q(277, 2000), Q(137, 250)),
       {"majority_low": a0, "unanimity_public_low": z_l, "unanimity_private_low": z_u,
        "delta_public": delta_public, "delta_private": delta_private, "delta_ir": delta_ir})

result = {"scope": "exact finite arithmetic checks conditional on the stated E/S/P baseline interface; not global proof or independent review",
          "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          "pass": sum(c["pass"] for c in checks), "fail": sum(not c["pass"] for c in checks),
          "checks": serial(checks)}
(ROOT / "agenda_checks.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"pass": result["pass"], "fail": result["fail"], "output": str(ROOT / "agenda_checks.json")}))
raise SystemExit(1 if result["fail"] else 0)
