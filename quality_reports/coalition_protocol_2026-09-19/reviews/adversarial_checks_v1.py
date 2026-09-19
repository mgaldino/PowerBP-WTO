#!/usr/bin/env python3
"""Independent, finite adversarial controls; not a proof of continuous/Borel claims."""
from fractions import Fraction as F
from itertools import combinations, product
from pathlib import Path
from hashlib import sha256
import contextlib
import csv
import io
import json
import tempfile

BASE = Path(__file__).resolve().parents[1]
ROOT = BASE.parents[1]
records = []
comparisons = 0

def check(name, ok, detail=None):
    records.append({'name': name, 'pass': bool(ok), 'detail': detail})
    if not ok:
        raise AssertionError((name, detail))

def serial(x):
    if isinstance(x, F): return str(x)
    if isinstance(x, dict): return {k: serial(v) for k,v in x.items()}
    if isinstance(x, set): return [serial(v) for v in sorted(x, key=repr)]
    if isinstance(x, (list,tuple)): return [serial(v) for v in x]
    return x

def majority_candidates(m,b,l,h,mu):
    k=(m+1)//2; w=b/m
    data={
        'E': (1-k*w, (l,h)),
        'S': ((1-mu)*(1-(k-1)*w-b*l)+mu*w, (b*l,b*h)),
        'P': (1-(k-1)*w-b*h, (b*h,b*h))}
    ranks={key:(pay,-((1-mu)*v[0]+mu*v[1])) for key,(pay,v) in data.items()}
    best=max(ranks.values())
    return best,{key for key,v in ranks.items() if v==best}

def declared_majority_selection(m,b,l,h,mu):
    c=F(1,m); k=(m+1)//2; w=b/m
    if h<c:
        t=b*(h-l)/(1-b*l-k*w)
        return {'S'} if mu<=t else {'P'}
    if h==c:
        t=b*(c-l)/(1-b*l-k*w)
        if mu<=t: return {'S'}
        a=(1-mu)*l+mu*h
        return {'E'} if a<b*h else {'P'} if a>b*h else {'E','P'}
    if l<c:
        t=b*(c-l)/(b*(c-l)+1-b*F(k+1,m))
        return {'S'} if mu<=t else {'E'}
    if l==c and mu==0: return {'S'}
    return {'E'}

# Full coalition inventory, asymmetric weak offers, slack, underpayment,
# off-threshold H offers, endpoints, all selection boundaries and tie points.
majority_states = 0
majority_proposals = 0
for m,b in product((3,4),(F(1,2),F(9,10))):
    k=(m+1)//2; q=k+1; w=b/m; c=F(1,m); i=1
    cases=((c/2,3*c/4),(c/2,3*c/2),(5*c/4,7*c/4),
           (c,3*c/2),(c/2,c))
    for l,h in cases:
        priors={F(0),F(1,2),F(1)}
        den=1-b*l-k*w
        cuts=[]
        if den>0:
            cuts.extend((b*(h-l)/den,b*(c-l)/den))
        if h==c: cuts.append((b*h-l)/(h-l))
        for t in cuts:
            if 0<=t<=1:
                priors.add(t)
                for z in (t-F(1,100),t+F(1,100)):
                    if 0<=z<=1: priors.add(z)
        candidates=[]
        for size in range(q,m+2):
            for rest in combinations([j for j in range(m+1) if j!=i],size-1):
                C=(i,)+rest
                weak=[j for j in C if j not in (0,i)]
                h_offers=(F(0),b*l/2,b*l,b*(l+h)/2,b*h,(1+b*h)/2) if 0 in C else (F(0),)
                for amounts in product((F(0),w/2,w,w+F(1,50)),repeat=len(weak)):
                    weak_yes=all(x>=w for x in amounts)
                    for t,slack in product(h_offers,(F(0),F(1,50))):
                        xi=1-t-sum(amounts)-slack
                        if xi<0: continue
                        passes=(weak_yes and (0 not in C or t>=l*b),
                                weak_yes and (0 not in C or t>=h*b))
                        hp=tuple((t if 0 in C else o) if passed else b*o
                                 for o,passed in zip((l,h),passes))
                        wp=tuple(xi if passed else w for passed in passes)
                        candidates.append((C,xi,t,amounts,slack,hp,wp))
        majority_proposals+=len(candidates)
        for mu in sorted(priors):
            best,labels=majority_candidates(m,b,l,h,mu)
            check('M-selection-table',labels==declared_majority_selection(m,b,l,h,mu),
                  {'m':m,'beta':b,'ell':l,'h':h,'mu':mu,'labels':labels})
            observed=None
            for C,xi,t,amounts,slack,hp,wp in candidates:
                rank=((1-mu)*wp[0]+mu*wp[1],-((1-mu)*hp[0]+mu*hp[1]))
                comparisons+=1
                if observed is None or rank>observed: observed=rank
                if rank>best:
                    check('M-no-better-full-proposal',False,
                          {'m':m,'beta':b,'ell':l,'h':h,'mu':mu,'C':C,'xi':xi,'xH':t,'weak':amounts,'slack':slack,'rank':rank,'expected':best})
            check('M-no-better-full-proposal',observed==best,
                  {'m':m,'beta':b,'ell':l,'h':h,'mu':mu,'proposals':len(candidates)})
            majority_states+=1

# Direct Bayesian ballot response enumeration in R1_U, with H's four profiles
# and local zero-denominator beliefs. Current priors are initial at R1.
def U_profiles(m,b,l,h,mu,u,t):
    cut=(h-l)/(1-l); A=b*(1-l)/m; B=b*(1-h)/m
    grid={F(0),cut/2,cut,(1+cut)/2,mu,F(1)}
    if mu==0: grid={F(0)}
    if mu==1: grid={F(1)}
    def W(eta): return (1-eta)*A if eta<=cut else B
    def H(o,eta): return b*(l if o==l and eta<=cut else h)
    found=set()
    for al,ah in product((0,1),repeat=2):
        dy=(1-mu)*al+mu*ah; dn=1-dy
        yes=[mu*ah/dy] if dy else grid
        no=[mu*(1-ah)/dn] if dn else grid
        for ey,en in product(yes,no):
            all_weak_yes=u>=W(ey)
            action=[]
            for o in (l,h):
                vy=t if all_weak_yes else H(o,ey)
                vn=H(o,en)
                action.append(int(vy>=vn))
            if tuple(action)==(al,ah): found.add((al,ah))
    return found

unanimity_states=0
for m,b,l,h in product((3,4),(F(1,2),F(9,10)),(F(1,10),),(F(7,20),F(9,10))):
    cut=(h-l)/(1-l); A=b*(1-l)/m; B=b*(1-h)/m
    for mu in (F(0),(1+cut)/2,F(1)):
        for u,t in product((F(0),B/2,B,(A+B)/2,A,A+F(1,100)),
                           (F(0),b*l/2,b*l,b*(l+h)/2,b*h,b*h+F(1,100))):
            if (m-1)*u+t>1: continue
            found=U_profiles(m,b,l,h,mu,u,t)
            if mu==0:
                expected={(1,1)} if u<A or t>=b*h else {(0,0)} if t<b*l else {(1,0)}
            else:
                expected={(1,1)} if u<B or t>=b*h else {(0,0)}
            check('U-ballot-completion',found==expected,
                  {'m':m,'beta':b,'ell':l,'h':h,'mu':mu,'min_weak':u,'xH':t,'found':sorted(found),'expected':sorted(expected)})
            unanimity_states+=1
    for mu in (cut/2,cut):
        found=U_profiles(m,b,l,h,mu,A,b*l)
        check('U-empty-cell-witness',not found,{'m':m,'beta':b,'ell':l,'h':h,'mu':mu,'found':sorted(found)})

# Explicit atomless M assessment: a zero-mass support point is not an argmax.
m=4; b=F(9,10); l=F(1,10); h=F(1,5); k=2
cut=b*(h-l)/(1-b*l-b*F(k,m)); length=F(1,100)
p=cut+length/2; z=F(3,5)
rP=b*(1-b*h)/m; rS0=b*(1-b*l)/m
O=max(1-k*rS0,b*b*h)
check('atomless-density-normalization', (cut+length/2)/p==1 and (1-cut-length/2)/(1-p)==1)
check('atomless-offsupport-protection',z>O,{'z':z,'O_high':O})
atomless=[]
for s in (F(0),length/100,length/2,length):
    mu=cut+s
    labels=declared_majority_selection(m,b,l,h,mu)
    r=(b*((1-mu)*(1-b*l)+mu*b)/m) if labels=={'S'} else rP
    x=(z,F(19,100)+s,F(19,100),F(0),F(0))
    passed=min(x[1:3])>=r
    hp=(z,z) if passed else (b*b*l,b*b*h)
    check('atomless-support-point',sum(x)<=1 and (passed==(s>0)) and all(v<=z for v in hp),
          {'s':s,'mu':mu,'r':r,'x':x,'passage':passed,'payoffs':hp})
    atomless.append({'s':s,'mu':mu,'r':r,'x':x,'passage':passed,'payoffs':hp})

# QI-05 endpoint: probability one on the argmax, closure contains nonargmax.
h=F(9,10); r0=b*(1-b*l)/m; a0=1-k*r0; d=b*b*h
check('endpoint-open-argmax',d>a0 and r0>0,{'passing_boundary':a0,'rejection_argmax_high':d,'r0':r0})
for eps in (r0/100,r0/2):
    x=(a0+eps,r0-eps,r0,F(0),F(0))
    check('endpoint-argmax-sequence',sum(x)==1 and min(x)>=0 and x[1]<r0,
          {'epsilon':eps,'x':x,'high_value':d})

# Replay the submitted finite arithmetic script, redirecting only its output
# directory in memory. __file__ stays original so its recorded script hash is
# unchanged. No candidate artifact is written by this replay.
original=BASE/'derivations/agenda_checks.py'
expected=BASE/'derivations/agenda_checks.json'
source=original.read_text()
with tempfile.TemporaryDirectory(prefix='coalition-adversarial-') as temp:
    line='ROOT = Path(__file__).resolve().parent'
    assert source.count(line)==1
    redirected=source.replace(line,f'ROOT = Path({temp!r})')
    env={'__name__':'__main__','__file__':str(original)}
    with contextlib.redirect_stdout(io.StringIO()):
        try: exec(compile(redirected,str(original),'exec'),env)
        except SystemExit as e:
            check('candidate-arithmetic-replay-exit',e.code==0,{'exit_code':e.code})
    fresh=Path(temp)/'agenda_checks.json'
    check('candidate-arithmetic-replay-byte-identity',fresh.read_bytes()==expected.read_bytes(),
          {'sha256':sha256(fresh.read_bytes()).hexdigest()})
    replay=json.loads(fresh.read_text())

# Read-only comparison of economic figure payloads to the rederived formulas.
# This checks exported numbers, not polygon geometry, captions or rendering.
figure_inputs={}
def csv_rows(relative):
    path=ROOT/relative
    with path.open() as handle: rows=list(csv.DictReader(handle))
    figure_inputs[relative]={'rows':len(rows),'sha256':sha256(path.read_bytes()).hexdigest()}
    return rows
def near(a,b): return abs(float(a)-float(b))<1e-12

gap_rows=csv_rows('figures/agenda_extension/figure_agenda_public_gap_data.csv')
for row in gap_rows:
    o=F(row['o']); beta=F(9,10); e_over_m=F(1,2)
    value={'H included under majority':-beta*e_over_m*(1-beta*o),
           'H excluded; majority agreement':beta*(beta*o-e_over_m),
           'Majority delay':(1-beta)*(1-beta*o)}[row['branch']]
    check('figure-agenda-public-gap',near(row['gap'],value))

existence_rows=csv_rows('figures/agenda_extension/figure_agenda_unanimity_existence_data.csv')
check('figure-U-existence-parameters',all(near(r['p_star'],F(5,18)) and
      r['low_family_payoff_condition']=='FALSE' for r in existence_rows))
expected_conditions=['p = 0 and mu_off = 0','p_star < p < 1 and mu_off = 0',
                     'p_star < p < 1 and p_star < mu_off <= 1',
                     'p = 1 and mu_off = 1','all remaining admissible pairs']
check('figure-U-existence-cells',[r['condition'] for r in existence_rows]==expected_conditions)

f2=csv_rows('figures/essential_input/figure_f2_prices_coalitions_data.csv')
for row in f2:
    expected={('Majority','screening','Low type'):F(9,100),
              ('Majority','screening','High type'):F(63,200),
              ('Majority','exclusion','Low type'):F(1,10),
              ('Majority','exclusion','High type'):F(7,20),
              ('Unanimity','pooling','Low type'):F(63,200),
              ('Unanimity','pooling','High type'):F(63,200),
              ('Unanimity','endpoint','Low type'):F(9,100)}
    if row['dataset'] in ('panel_a_payoff','panel_a_endpoint'):
        check('figure-baseline-type-payoffs',near(row['payoff'],expected[(row['rule'],row['segment'],row['type'])]))

f3=csv_rows('figures/essential_input/figure_f3_power_information_data.csv')
for row in f3:
    islow=row['type']=='Low type'
    if row['record_type']=='public_private_payoff':
        expected={('Majority','Public'):(F(9,100),F(7,20)),
                  ('Majority','Private'):(F(1,10),F(7,20)),
                  ('Unanimity','Public'):(F(9,100),F(63,200)),
                  ('Unanimity','Private'):(F(63,200),F(63,200))}[(row['rule'],row['information'])][0 if islow else 1]
    else:
        expected={'IR_M^B':F(1,100),'IR_U^B':F(9,40),'Delta IR^B':F(43,200)}[row['information']] if islow else F(0)
    check('figure-baseline-rents',near(row['payoff'],expected))

result={
    'scope':'Finite controls for R1 ballots/proposals and exact witnesses; not a continuous/Borel proof or independent certification of every strategy.',
    'script_sha256':sha256(Path(__file__).read_bytes()).hexdigest(),
    'pass':sum(r['pass'] for r in records),'fail':sum(not r['pass'] for r in records),
    'majority_states':majority_states,'majority_generated_proposals_total_across_parameter_cases':majority_proposals,
    'majority_proposal_state_comparisons':comparisons,'unanimity_ballot_states':unanimity_states,
    'atomless_example':{'m':4,'beta':b,'ell':l,'high':F(1,5),'posterior_cutoff':cut,'prior':p,'length':length,'value':z,'sampled_points':atomless},
    'candidate_arithmetic_replay':{'pass':replay['pass'],'fail':replay['fail'],'byte_identical':True,'script_sha256':replay['script_sha256']},
    'figure_payload_inputs':figure_inputs,
    'checks':records}
output=Path(__file__).with_suffix('.json')
output.write_text(json.dumps(serial(result),ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('checks','atomless_example')},default=str,indent=2))
