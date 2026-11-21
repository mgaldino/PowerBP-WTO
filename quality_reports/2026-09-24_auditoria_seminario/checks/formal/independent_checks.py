#!/usr/bin/env python3
"""Independent rational checks of the frozen manuscript, not an equilibrium solver.

No project pipeline or historical audit is imported. All numerical arithmetic is
fractions.Fraction. Continuous-action reductions are proved in reviews/formal.md;
this finite grid only checks boundary arithmetic and the enumerated ballot cases.
"""
from fractions import Fraction as F
from itertools import product
from pathlib import Path
from collections import Counter
import hashlib
import json

HERE = Path(__file__).resolve().parent
SOURCE = HERE.parents[1] / "inputs/formal_model_v6.Rmd"
EXPECTED_SHA = "9356d86a2e893481968ee96a918c2109e726444c5d902ce88edd6f1a5d86345f"
counts = Counter()
failures = []

def check(condition, family, detail=None):
    counts[family] += 1
    if not condition:
        failures.append({"family": family, "detail": str(detail)})

def cutoff(l, h):
    return (h-l)/(1-l)

def terminal_H(mu, l, h):
    return (l if mu <= cutoff(l,h) else h, h)

def terminal_W(mu, b, l, h, m):
    return b*(1-mu)*(1-l)/m if mu <= cutoff(l,h) else b*(1-h)/m

def majority_forms(m, b, l, h, p):
    k = (m+1)//2
    w = b/m
    pi = {"E": 1-k*w, "S": (1-p)*(1-(k-1)*w-b*l)+p*w,
          "P": 1-(k-1)*w-b*h}
    hv = {"E": (l,h), "S": (b*l,b*h), "P": (b*h,b*h)}
    mx = max(pi.values())
    tied = [q for q in pi if pi[q] == mx]
    emin = min((1-p)*hv[q][0]+p*hv[q][1] for q in tied)
    return {q for q in tied if (1-p)*hv[q][0]+p*hv[q][1] == emin}, pi, hv

def claimed_forms(m, b, l, h, p):
    inv = F(1,m)
    k = (m+1)//2
    pse = b*(inv-l)/(b*(inv-l)+1-b*(k+1)/m) if l < inv else F(0)
    if h < inv:
        psp = b*(h-l)/(1-b*l-b*k/m)
        return {"S"} if p <= psp else {"P"}
    if l < inv < h:
        return {"S"} if p <= pse else {"E"}
    if inv < l:
        return {"E"}
    if l == inv:
        return {"S"} if p == 0 else {"E"}
    if p <= pse:
        return {"S"}
    he = (1-p)*l+p*h
    return {"E"} if he < b*h else {"P"} if he > b*h else {"E","P"}

def continue_M(form, m, b, l, h, p):
    # Derived from sum of realized weak shares before uniform recognition.
    if form == "E": return F(1,m), (l,h)
    if form == "P": return (1-b*h)/m, (b*h,b*h)
    return ((1-p)*(1-b*l)+p*b)/m, (b*l,b*h)

def public_M(m, b, o):
    return b*o if o <= F(1,m) else o

def agenda_public_M(m, b, o):
    k=(m+1)//2
    c=(1-b*o)/m if o <= F(1,m) else F(1,m)
    return max(1-k*b*c,b*public_M(m,b,o))

def pure_U_profiles(m,b,l,h,p,xH,xmin):
    # Weak as-if-pivotal vote uses posterior conditional on H's affirmative
    # action, also when that action has probability zero under the profile.
    ps=cutoff(l,h)
    free={p} if p in (0,1) else {F(0),ps/2,ps,(1+ps)/2,F(1),p}
    seen=set()
    for aL,aH in product((0,1),repeat=2):
        probY=(1-p)*aL+p*aH
        ys={p*aH/probY} if probY else free
        ns={p*(1-aH)/(1-probY)} if probY != 1 else free
        for muY,muN in product(ys,ns):
            weak_yes=xmin >= terminal_W(muY,b,l,h,m)
            y=[xH,xH] if weak_yes else [b*z for z in terminal_H(muY,l,h)]
            n=[b*z for z in terminal_H(muN,l,h)]
            best=tuple(int(y[t]>=n[t]) for t in (0,1))
            if best == (aL,aH): seen.add(best)
    return seen

def baseline_majority_deviations(m,b,l,h,p):
    # Enumerates all coalition sizes and the only payoff-maximizing threshold
    # offers left by the continuous dominance argument in the written report.
    k=(m+1)//2; w=b/m
    candidates=[]
    for n in range(k,m):
        if n*w <= 1: candidates.append((1-n*w,(1-p)*l+p*h,"E",n))
    for n in range(k-1,m):
        for xH in (F(0),b*l,b*h):
            if n*w+xH > 1: continue
            aL=xH >= b*l; aH=xH >= b*h
            a=(1-p)*aL+p*aH
            payoff=a*(1-n*w-xH)+(1-a)*w
            heg=(1-p)*(xH if aL else b*l)+p*(xH if aH else b*h)
            form="P" if aL and aH else "S" if aL else "D"
            candidates.append((payoff,heg,form,n))
    candidates.append((w,b*((1-p)*l+p*h),"D",0))
    v=max(x[0] for x in candidates)
    eh=min(x[1] for x in candidates if x[0]==v)
    opt=[x for x in candidates if x[0]==v and x[1]==eh]
    claimed,pi,hv=majority_forms(m,b,l,h,p)
    check({x[2] for x in opt}==claimed,"majority_all_sizes",(m,b,l,h,p,opt,claimed))
    for x in opt:
        check(x[3]==(k if x[2]=="E" else k-1),"majority_minimality",x)

def main():
    check(hashlib.sha256(SOURCE.read_bytes()).hexdigest()==EXPECTED_SHA,"source_hash")
    for m,b in product(range(3,11),(F(1,5),F(1,2),F(4,5),F(9,10),F(99,100))):
        k=(m+1)//2; e=m-k; w=b/m; safe=1-k*w
        check(k+1<=m and (k+1)*w<1 and safe>w,"quota_discount")
        vals=sorted({F(1,20),F(1,10),F(1,m),F(1,m)/2,F(3,10),F(1,2),F(4,5),F(19,20)})
        for l,h in ((l,h) for l in vals for h in vals if l<h):
            ps=cutoff(l,h)
            priors={F(0),F(1),F(1,10),F(1,2),F(9,10),ps,ps/2,(1+ps)/2}
            if l<F(1,m):
                pse=b*(F(1,m)-l)/(b*(F(1,m)-l)+1-b*(k+1)/m)
                priors|={pse,pse/2,(1+pse)/2}
            if h<F(1,m):
                psp=b*(h-l)/(1-b*l-b*k/m)
                priors|={psp,psp/2,(1+psp)/2}
            if h==F(1,m) and l<=b*h:
                priors.add((b*h-l)/(h-l))
            for p in priors:
                forms,pi,hv=majority_forms(m,b,l,h,p)
                check(forms==claimed_forms(m,b,l,h,p),"majority_cells_ties",(m,b,l,h,p,forms))
                baseline_majority_deviations(m,b,l,h,p)
                terminal_pi=[(1-p)*(1-l),1-h]
                check((terminal_pi[0]>=terminal_pi[1])==(p<=ps),"terminal_unanimity_cutoff")
                if p==ps:
                    check((1-p)*l+p*h<h,"terminal_tie_H")
                for q in forms:
                    c,ho=continue_M(q,m,b,l,h,p)
                    check((1-w)/m<=c<=F(1,m),"continuation_M_bounds",(m,b,l,h,p,q,c))
                    check(1-(k+1)*b*c<safe,"oversized_agenda_M_bound",(m,b,l,h,p,q))
                    check(min(ho[t]-b*o for t,o in enumerate((l,h)))>=0,"rejection_M_lower_bound")
                # Every one of the four H profiles is tested at the decisive
                # no-existence proposal, with all threshold posterior classes.
                actual=pure_U_profiles(m,b,l,h,p,b*l,b*(1-l)/m)
                check(bool(actual)==(p==0 or p>ps),"unanimity_obstruction",(m,b,l,h,p,actual))
            # Complete response classification, including budget boundaries.
            for p in (F(0),(1+ps)/2,F(1)):
                wl=b*(1-l)/m; wh=b*(1-h)/m
                for xH,xmin in product((F(0),b*l/2,b*l,(b*l+b*h)/2,b*h),
                                      (F(0),wh/2,wh,(wh+wl)/2,wl)):
                    if xH+(m-1)*xmin>1: continue
                    actual=pure_U_profiles(m,b,l,h,p,xH,xmin)
                    threshold=wl if p==0 else wh
                    if xmin<threshold: expected={(1,1)}
                    elif p==0:
                        expected={(0,0)} if xH<b*l else {(1,0)} if xH<b*h else {(1,1)}
                    else: expected={(0,0)} if xH<b*h else {(1,1)}
                    check(actual==expected,"unanimity_response_completion",(m,b,l,h,p,xH,xmin,actual,expected))
            zL=1-b+b*b*l; zH=1-b+b*b*h; d=b*b*h
            rL=b*(1-b*l)/m; rH=b*(1-b*h)/m
            check(zL+m*rL==1 and zH+m*rH==1,"agenda_U_budget")
            check(zH-d==1-b and zH-zL==b*b*(h-l),"agenda_U_values")
            if zL>=d:
                check(zL+m*rH<1 and zL>=d and zL>=b*b*l,"agenda_U_low_witness")
            for z in (max(zL,d),(max(zL,d)+zH)/2,zH):
                check((1-z)/m>=rH and z>=zL and z>=d,"agenda_U_high_witness")
                ir=(z-zL,z-zH)
                check(ir[0]>=0 and ir[1]<=0 and ir!=(0,0),"agenda_U_rent_incidence")
                T=(z-d,z-d); I=(z-zH,z-zH)
                check(T==tuple(1-b+v for v in I) and min(T)>=0,"agenda_U_T_I_identity")
            check(safe-zH==b*(F(e,m)-b*h),"uniform_majority_gap_identity")
        for o in vals:
            vM=agenda_public_M(m,b,o); vU=1-b+b*b*o
            c=(1-b*o)/m if o<=F(1,m) else F(1,m)
            brute=max([1-n*b*c for n in range(k,m+1) if n*b*c<=1]+[b*public_M(m,b,o)])
            check(vM==brute,"agenda_public_all_sizes")
            gap=vU-vM
            formula=(-b*F(e,m)*(1-b*o) if o<=F(1,m) else
                     b*(b*o-F(e,m)) if b*o<=safe else (1-b)*(1-b*o))
            check(gap==formula,"agenda_public_gap")
            D=vM-b*public_M(m,b,o)
            dformula=safe-F(e,m)*b*b*o if o<=F(1,m) else max(F(0),safe-b*o)
            check(D==dformula and D>=0,"agenda_public_D")
            if o>F(1,m): check((gap>0)-(gap<0)==(b*o>F(e,m))-(b*o<F(e,m)),"agenda_public_gap_sign")
    # Worked examples, independently recomputed.
    m=4;b=F(9,10);l=F(1,10);h=F(9,10);p=F(19,20)
    lowpass=agenda_public_M(m,b,l);highdelay=b*h;z=b*b*h
    check(lowpass==F(5905,10000) and highdelay==F(81,100),"worked_reversal_M")
    zL=1-b+b*b*l;zH=1-b+b*b*h
    check(p>cutoff(l,h) and zL<z<=zH,"worked_reversal_U")
    check(z-lowpass==F(1385,10000) and zL-lowpass==F(-4095,10000) and z-zL==F(548,1000),"worked_reversal_decomposition")
    m=4;b=F(9,10);l=F(1,10);h=F(35,100);p=F(4,5)
    forms,_,hv=majority_forms(m,b,l,h,p)
    check(forms=={"E"} and cutoff(l,h)==F(5,18),"working_baseline_example")
    vm=(public_M(m,b,l),public_M(m,b,h));VU=(b*h,b*h)
    check(tuple(hv['E'][t]-vm[t] for t in (0,1))==(F(1,100),F(0)),"working_baseline_rents")
    check((VU[0]-b*l)-(hv['E'][0]-vm[0])==F(215,1000),"working_baseline_deltair")
    result={"source_sha256":EXPECTED_SHA,"script_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "arithmetic":"exact rational fractions", "checks_by_family":dict(counts),
            "total_checks":sum(counts.values()),"failures":failures,
            "scope_limit":"Finite exact grid and threshold enumerations; continuous deviations and Borel laws assessed analytically in formal.md. No empirical or Lean validation."}
    (HERE/'independent_checks.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({"total_checks":result['total_checks'],"failure_count":len(failures),"checks_by_family":dict(counts)},indent=2))
    raise SystemExit(bool(failures))

if __name__=='__main__': main()
