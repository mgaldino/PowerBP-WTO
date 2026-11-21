#!/usr/bin/env python3
"""Independent finite falsification checks, using Fraction and no author code.

Run from any directory. Reads the frozen source only to verify its SHA256;
writes check_results.json beside this script. Finite checks are not proofs of
the continuous correspondence. The report supplies the mathematical arguments.
"""
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
SOURCE = HERE.parents[1] / 'inputs' / 'formal_model_v6.Rmd'
EXPECTED_HASH = '9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f'
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == EXPECTED_HASH
COUNTS = {}
ERRORS = []


def check(name, condition, context=None):
    COUNTS[name] = COUNTS.get(name, 0) + 1
    if not condition:
        ERRORS.append({'check': name, 'context': repr(context)})


def majority_branches(m, b, lo, hi, p):
    k, w = (m+1)//2, b/m
    proposer = {'E': 1-k*w,
                'S': (1-p)*(1-(k-1)*w-b*lo)+p*w,
                'P': 1-(k-1)*w-b*hi}
    hegemon = {'E': (1-p)*lo+p*hi,
               'S': b*((1-p)*lo+p*hi), 'P': b*hi}
    best = max(proposer.values())
    candidates = [s for s in proposer if proposer[s] == best]
    lowest_H = min(hegemon[s] for s in candidates)
    return set(s for s in candidates if hegemon[s] == lowest_H)


def claimed_branches(m, b, lo, hi, p):
    t, k = F(1,m), (m+1)//2
    if hi < t:
        q = b*(hi-lo)/(1-b*lo-b*k/m)
        return {'S'} if p <= q else {'P'}
    if lo > t:
        return {'E'}
    if lo == t:
        return {'S'} if p == 0 else {'E'}
    q = b*(t-lo)/(b*(t-lo)+1-b*F(k+1,m))
    if p <= q:
        return {'S'}
    if hi > t:
        return {'E'}
    comparison = (1-p)*lo+p*hi-b*hi
    return {'E'} if comparison < 0 else {'P'} if comparison > 0 else {'E','P'}


def ballot_profiles(m, b, lo, hi, p, xH, xmin):
    """Solve response fixed points independently from B.4's case table.

    Each free posterior can use 0, pstar, or 1. These representatives span
    both terminal H-payoff cells and the minimum possible weak price in
    each cell; they suffice to test existence of a completion at xmin.
    """
    pstar = (hi-lo)/(1-lo)
    free = (p,) if p in (0,1) else (F(0),pstar,F(1))
    def cw(mu):
        return b*(1-mu)*(1-lo)/m if mu <= pstar else b*(1-hi)/m
    def uh(typ, mu):
        return b*(hi if typ == hi or mu > pstar else lo)
    output = set()
    for profile in product((0,1), repeat=2):
        denY = (1-p)*profile[0]+p*profile[1]
        denN = 1-denY
        musY = (p*profile[1]/denY,) if denY else free
        musN = (p*(1-profile[1])/denN,) if denN else free
        for muY, muN in product(musY, musN):
            weak_yes = xmin >= cw(muY)
            prescribed = []
            for typ in (lo,hi):
                yes = xH if weak_yes else uh(typ, muY)
                no = uh(typ, muN)
                prescribed.append(int(yes >= no))
            if tuple(prescribed) == profile:
                output.add(profile)
    return output


for m in range(3,9):
    k, e = (m+1)//2, m-(m+1)//2
    for b in (F(1,10),F(1,2),F(9,10),F(99,100)):
        vals = sorted({F(1,100),F(1,2*m),F(1,m),F(1,m)+F(1,100),F(1,2),F(9,10),F(99,100)})
        for lo, hi in product(vals, repeat=2):
            if not 0 < lo < hi < 1:
                continue
            pstar = (hi-lo)/(1-lo)
            priors = {F(0),F(1,100),F(1,4),F(1,2),F(3,4),F(99,100),F(1),pstar}
            if lo < F(1,m):
                priors.add(b*(F(1,m)-lo)/(b*(F(1,m)-lo)+1-b*F(k+1,m)))
            if hi < F(1,m):
                priors.add(b*(hi-lo)/(1-b*lo-b*k/m))
            if hi == F(1,m) and b*hi >= lo:
                priors.add((b*hi-lo)/(hi-lo))
            for p in priors:
                check('majority_classification_and_ties',
                      majority_branches(m,b,lo,hi,p) == claimed_branches(m,b,lo,hi,p),
                      (m,b,lo,hi,p, majority_branches(m,b,lo,hi,p), claimed_branches(m,b,lo,hi,p)))
                for branch in majority_branches(m,b,lo,hi,p):
                    c = {'E': F(1,m), 'S': ((1-p)*(1-b*lo)+p*b)/m,
                         'P': (1-b*hi)/m}[branch]
                    check('majority_continuation_price_bounds', (1-b/m)/m <= c <= F(1,m),
                          (m,b,lo,hi,p,branch,c))
            check('oversized_agenda_strict_loss',
                  1-(k+1)*(b/m)*(1-b/m) < 1-k*b/m, (m,b))
            safe = 1-k*b/m
            zl, zh, d = 1-b+b*b*lo, 1-b+b*b*hi, b*b*hi
            check('agenda_uniform_bound_identity', safe-zh == b*(F(e,m)-b*hi))
            check('agenda_unanimity_interval_nonempty', max(zl,d) < zh)
            for z in {max(zl,d), (max(zl,d)+zh)/2, zh}:
                check('agenda_U_incidence', z-zl >= 0 and z-zh <= 0 and z-zl > z-zh)
                check('agenda_U_total_nonnegative', 0 <= z-d <= 1-b)
                check('agenda_U_interaction_nonpositive', z-zh <= 0)
            # Independent four-profile check at the nonexistence witness.
            sd = ballot_profiles(m,b,lo,hi,pstar,b*lo,b*(1-lo)/m)
            check('unanimity_nonexistence_at_cutoff', not sd, (m,b,lo,hi,sd))
            for p in (F(0),pstar/2,(pstar+1)/2,F(1)):
                wh, wl = b*(1-hi)/m,b*(1-lo)/m
                xhs = {F(0),b*lo/2,b*lo,(b*lo+b*hi)/2,b*hi,(1+b*hi)/2}
                xmins = {F(0),wh/2,wh,(wh+wl)/2,wl}
                for xH,xmin in product(xhs,xmins):
                    if xH+(m-1)*xmin > 1:
                        continue
                    actual = ballot_profiles(m,b,lo,hi,p,xH,xmin)
                    if p == 0:
                        predicted = {(1,1)} if xmin < wl else ({(0,0)} if xH < b*lo else ({(1,0)} if xH < b*hi else {(1,1)}))
                    elif p > pstar:
                        predicted = {(1,1)} if xmin < wh or xH >= b*hi else {(0,0)}
                    else:
                        continue
                    check('unanimity_offpath_completion', actual == predicted,
                          (m,b,lo,hi,p,xH,xmin,actual,predicted))
            for o in vals:
                vmB = b*o if o <= F(1,m) else o
                vuB = b*o
                vmA = 1-k*b*(1-b*o)/m if o <= F(1,m) else max(safe,b*o)
                vuA = 1-b+b*b*o
                if o <= F(1,m):
                    gap = -b*F(e,m)*(1-b*o)
                    direct = safe-F(e,m)*b*b*o
                elif b*o <= safe:
                    gap = b*(b*o-F(e,m))
                    direct = safe-b*o
                else:
                    gap = (1-b)*(1-b*o)
                    direct = F(0)
                check('public_agenda_gap', vuA-vmA == gap)
                check('public_agenda_direct', vmA-b*vmB == direct and direct >= 0)
                check('public_U_direct', vuA-b*vuB == 1-b)

# Worked illustrations, exact rational arithmetic.
m,b,lo,hi,p = 4,F(9,10),F(1,10),F(7,20),F(4,5)
q = b*(F(1,m)-lo)/(b*(F(1,m)-lo)+1-b*F(3,m))
examples = {'baseline_pstar': str((hi-lo)/(1-lo)), 'baseline_pSE': str(q)}
check('worked_baseline_screening_exclusion_cutoff', q == F(27,92))
check('worked_baseline_form', majority_branches(m,b,lo,hi,p) == {'E'})
hi = F(9,10)
Mlo, Ulo, VU = 1-2*b*(1-b*lo)/m, 1-b+b*b*lo, b*b*hi
check('worked_agenda_reversal', (Mlo,Ulo,VU,VU-Ulo,Ulo-Mlo,VU-Mlo) ==
      (F(5905,10000),F(181,1000),F(729,1000),F(548,1000),-F(4095,10000),F(1385,10000)))
examples['agenda_reversal'] = list(map(str,(Mlo,Ulo,VU,VU-Ulo,Ulo-Mlo,VU-Mlo)))

# A zero/positive (not negative/positive) sign variation in T_M at fixed data.
m,b,lo,hi,p = 4,F(9,10),F(1,10),F(73,100),F(1,4)
a0 = 1-2*b*(1-b*lo)/m
ap = 1-2*b*((1-p)*(1-b*lo)+p*b)/m
d = b*b*hi
check('auxiliary_TM_zero_positive', majority_branches(m,b,lo,hi,p) == {'S'} and
      a0 < d < ap and (a0,d,ap,ap-d) ==
      (F(5905,10000),F(5913,10000),F(591625,1000000),F(325,1000000)))
examples['auxiliary_TM_zero_positive'] = list(map(str,(a0,d,ap,ap-d)))

result = {'source_sha256': EXPECTED_HASH, 'method': 'Python stdlib Fraction; no author code imported',
          'counts': COUNTS, 'total_checks': sum(COUNTS.values()), 'errors': ERRORS,
          'examples': examples,
          'limitations': ['Finite parameter grid, not a continuous proof.',
                         'No empirical, bibliographic, rendering or Lean validation.',
                         'Measure-theoretic results checked analytically in the report.']}
(HERE/'check_results.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'total_checks': result['total_checks'], 'counts': COUNTS, 'errors': ERRORS[:10]},ensure_ascii=False,indent=2))
raise SystemExit(bool(ERRORS))
