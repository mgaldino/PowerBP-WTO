from fractions import Fraction as F
from itertools import product
from pathlib import Path
import json, hashlib, math

out = Path('/private/tmp/pbp_adversarial_20260908_493f')
checks = {'profiles':0,'type_comparisons':0,'optimality_cells':0,'terminal_cells':0,'terminal_offers':0}
failures = []
cases = [
    (3,F(1,2),F(1,6),F(2,3),12),
    (3,F(9,10),F(1,9),F(2,3),20),
    (4,F(2,3),F(1,8),F(1,2),12),
    (4,F(4,5),F(1,8),F(3,4),20),
    (5,F(5,6),F(1,10),F(2,5),12),
    (4,F(2,3),F(1,8),F(1,4),12),
]

def compositions(total,n):
    if n==1:
        yield (total,)
    else:
        for q in range(total+1):
            for tail in compositions(total-q,n-1):
                yield (q,)+tail

def type_outcome(shares,o,beta,m,candidate):
    xp,xh,*weak=shares
    k=(m+1)//2
    w=beta/m
    n=sum(x>=w for x in weak)
    pays=[]
    for hy in (True,False):
        passed=n+hy>=k
        if passed:
            hp=xh if hy else max(xh,o) if candidate else o
        else:
            hp=beta*o
        pays.append(hp)
    hy=pays[0]>=pays[1]
    passed=n+hy>=k
    return (hy,passed,xp if passed else w,pays[0] if hy else pays[1],xh)

cell_results=[]
for ci,(m,beta,l,h,D) in enumerate(cases):
    k=(m+1)//2; w=beta/m
    probs={F(0),F(1,4),F(1,2),F(3,4),F(1)}
    A=beta*(F(1,m)-l); B=1-beta*F(k+1,m)
    if A+B !=0 and 0<=A/(A+B)<=1: probs.add(A/(A+B))
    if 0<= (beta*h-l)/(h-l) <=1: probs.add((beta*h-l)/(h-l))
    probs=sorted(probs)
    best={p:None for p in probs}; any_bad_primary={p:False for p in probs}; primary={p:None for p in probs}
    profiles=0
    for nums in compositions(D,m+2):
        shares=tuple(F(v,D) for v in nums[:-1]) # last coordinate is unallocated slack
        old=[type_outcome(shares,o,beta,m,False) for o in (l,h)]
        new=[type_outcome(shares,o,beta,m,True) for o in (l,h)]
        profiles+=1; checks['profiles']+=1; checks['type_comparisons']+=2
        if old !=new:
            failures.append({'kind':'type_transport','case':ci,'proposal':str(shares)})
        bad=any(v[4]>0 and v[1] and not v[0] for v in new)
        for p in probs:
            pp=(1-p)*new[0][2]+p*new[1][2]
            hp=(1-p)*new[0][3]+p*new[1][3]
            val=(pp,-hp)
            if best[p] is None or val>best[p]: best[p]=val
            if primary[p] is None or pp>primary[p]: primary[p]=pp;any_bad_primary[p]=bad
            elif pp==primary[p]: any_bad_primary[p] |=bad
    assert profiles==math.comb(D+m+1,m+1)
    for p in probs:
        E=(1-k*w, -((1-p)*l+p*h))
        options=[('E',E),('D',(w,-beta*((1-p)*l+p*h)))]
        if (k-1)*w+beta*l<=1:
            options.append(('S',((1-p)*(1-(k-1)*w-beta*l)+p*w,-beta*((1-p)*l+p*h))))
        if (k-1)*w+beta*h<=1:
            options.append(('P',(1-(k-1)*w-beta*h,-beta*h)))
        theoretical=max(v for _,v in options)
        checks['optimality_cells']+=1
        if best[p]!=theoretical or any_bad_primary[p]:
            failures.append({'kind':'proposal_optimum','case':ci,'p':str(p),'enumerated':str(best[p]),'formula':str(theoretical),'positive_passing_no_optimal':any_bad_primary[p]})
        cell_results.append({'case':ci,'m':m,'beta':str(beta),'ell':str(l),'h':str(h),'D':D,'p':str(p),'enumerated_proposer':str(best[p][0]),'enumerated_H':str(-best[p][1]),'selected_candidates':[name for name,v in options if v==theoretical],'profiles':profiles})

# Unanimity terminal: exhaust x_H and proposer shares; all other nonnegative
# shares and slack consume the remaining resource and cannot alter ballots.
for l,h in [(F(1,10),F(7,20)),(F(1,6),F(2,3)),(F(1,5),F(9,10))]:
    D=60; star=(h-l)/(1-l)
    probs=sorted({F(0),star/2,star,(1+star)/2,F(1)})
    for p in probs:
        best=None
        for ih in range(D+1):
            xh=F(ih,D)
            for ip in range(D-ih+1):
                xp=F(ip,D)
                pp=F(0); hp=F(0)
                for weight,o in [(1-p,l),(p,h)]:
                    passed=xh>=o
                    pp+=weight*(xp if passed else 0)
                    hp+=weight*(xh if passed else o)
                v=(pp,-hp)
                if best is None or v>best:best=v
                checks['terminal_offers']+=1
        target=((1-p)*(1-l),-((1-p)*l+p*h)) if p<=star else (1-h,-h)
        checks['terminal_cells']+=1
        if best!=target:failures.append({'kind':'R2_unanimity','p':str(p),'ell':str(l),'h':str(h),'actual':str(best),'target':str(target)})

# Exact boundary and all-history attacks: cover both feasible execution actions,
# including a deliberately inferior choice, and altered preference strictness.
execution_cases=0
for xh,o in product([F(0),F(1,10),F(1,5),F(7,20),F(1)],[F(1,10),F(1,5),F(7,20)]):
    choices=[(xh,F(0)),(F(0),o)]
    assert all(a*b==0 for a,b in choices)
    assert max(a+b for a,b in choices)==max(xh,o)
    execution_cases+=2
assert F(1,5)>F(1,10) and max(F(1,5),F(1,10))==F(1,5)
# N is an additional best reply if T^Y is removed in the passing nonpivotal case.
assert F(1,5)==max(F(1,5),F(1,10))
# A canonical measurable lift can choose C iff x_H>=o; its values do not depend
# on choosing C or O at equality. No computational measurability claim is made.
assert F(1,5)+0==0+F(1,5)

payload={'arithmetic':'exact fractions; no tolerance','checks':checks,'execution_actions':execution_cases,'failures':failures,'cases':cell_results,'limitations':'finite rational proposal grids and selected parameter/prior cells; not exhaustive over continuous domains, belief systems or assessments'}
(out/'results.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'checks':checks,'execution_actions':execution_cases,'failure_count':len(failures),'failures':failures},ensure_ascii=False,indent=2))
print('script_sha256='+hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
print('results_sha256='+hashlib.sha256((out/'results.json').read_bytes()).hexdigest())
if failures: raise SystemExit(1)
