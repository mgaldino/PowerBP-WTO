#!/usr/bin/env python3
"""Cold R2 finite check extracted from cold_r2_from_primitives.md.

The enumeration and assertions reproduce the previously executed check.
Only stdout serialization changes from a Python dict literal to JSON.
This finite rational grid is not a proof of the continuous game.
Run: python3 quality_reports/coalition_protocol_2026-09-19/reviews/cold_r2_check.py
"""
import json

from fractions import Fraction as F
from itertools import combinations
from math import comb

def allocations(c, budget):
    if c == 1:
        for z in range(budget + 1):
            yield (z,)
    else:
        for z in range(budget + 1):
            for rest in allocations(c - 1, budget - z):
                yield (z,) + rest

D = 20
proposals = {}
for m in (3, 4):
    n, q, i = m + 1, (m + 1) // 2 + 1, 1
    arr = []
    for c in range(q, n + 1):
        for rest in combinations([j for j in range(n) if j != i], c - 1):
            C = (i,) + rest
            for amounts in allocations(c, D):
                x = [0] * n
                for j, a in zip(C, amounts):
                    x[j] = a
                arr.append((C, tuple(x)))
    proposals[m] = arr

checks = comparisons = states = 0
for m in (3, 4):
    n, q, i = m + 1, (m + 1) // 2 + 1, 1
    for ell, h in [(F(1, 10), F(7, 20)), (F(1, 5), F(4, 5))]:
        cut = (h - ell) / (1 - ell)
        for mu in (F(0), cut - F(1, 100), cut, cut + F(1, 100), F(1)):
            for rule in ('M', 'U'):
                best, maximizers = None, []
                for C, xn in proposals[m]:
                    if rule == 'U' and len(C) != n:
                        continue
                    x = tuple(F(v, D) for v in xn)
                    if 0 not in C:
                        pass_l = pass_h = True
                        H_l, H_h = ell, h
                    else:
                        pass_l, pass_h = x[0] >= ell, x[0] >= h
                        H_l = x[0] if pass_l else ell
                        H_h = x[0] if pass_h else h
                    prop = ((1-mu)*int(pass_l) + mu*int(pass_h))*x[i]
                    EH = (1-mu)*H_l + mu*H_h
                    rank = (prop, -EH)
                    comparisons += 1
                    if best is None or rank > best:
                        best, maximizers = rank, [(C, x)]
                    elif rank == best:
                        maximizers.append((C, x))
                if rule == 'M':
                    assert best == (F(1), -((1-mu)*ell + mu*h))
                    count = sum(comb(m-1, r-1) for r in range(q, m+1))
                    assert len(maximizers) == count
                    assert all(0 not in C and x[i] == 1 and
                               all(x[j] == 0 for j in range(n) if j != i)
                               for C, x in maximizers)
                else:
                    t = ell if mu <= cut else h
                    rate = 1-mu if t == ell else F(1)
                    EH = (1-mu)*ell + mu*h if t == ell else h
                    assert best == (rate*(1-t), -EH)
                    assert len(maximizers) == 1
                    C, x = maximizers[0]
                    assert (len(C) == n and x[0] == t and x[i] == 1-t and
                            all(x[j] == 0 for j in range(n) if j not in (0, i)))
                checks += 3
                states += 1
print(json.dumps(dict(grid_denominator=D, states=states, assertions=checks,
           proposal_state_comparisons=comparisons, failures=0,
           m3_feasible_proposals=len(proposals[3]),
           m4_feasible_proposals=len(proposals[4])), indent=2))
