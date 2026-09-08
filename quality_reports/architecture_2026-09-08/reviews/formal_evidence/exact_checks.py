#!/usr/bin/env python3
"""Independent exact-arithmetic checks for the formal review, not a PBE enumerator.

No imports from the candidate's verification script. Writes only the sibling
exact_checks.json. The proofs, not this finite grid, cover the continuous domain.
"""
from collections import Counter
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import hashlib
import json

BASE = Path(__file__).resolve().parents[2]
NOTE_SHA = "493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3"
CONTRACT_SHA = "1d1c46c001c7e71a9fabb4b2ca7f1e7d592cc21dd179f64fdd05352407b8cdd0"
assert hashlib.sha256((BASE / "architecture_note.Rmd").read_bytes()).hexdigest() == NOTE_SHA
assert hashlib.sha256((BASE / "argument_contract/argument_contract.json").read_bytes()).hexdigest() == CONTRACT_SHA
counts = Counter()


def check(category, condition):
    counts[category] += 1
    if not condition:
        raise AssertionError(f"Failed exact check: {category}")


def execution(y, o):
    # Enumerate feasible uses before optimizing; no max{x_H,o} input formula.
    return {"C": (y, F(0)), "O": (F(0), o)}


def value(game, vote, passed, y, o, continuation):
    if not passed:
        return continuation
    if vote == "Y":
        return y
    if game == "historical":
        return o
    return max(sum(receipts) for receipts in execution(y, o).values())


def ballot(game, n, quota, y, o, cy, cn):
    uy = value(game, "Y", n + 1 >= quota, y, o, cy)
    un = value(game, "N", n >= quota, y, o, cn)
    chosen = "Y" if uy >= un else "N"
    return chosen, uy if chosen == "Y" else un, uy, un


# Every feasible execution use, including a dominated one, has disjoint receipts.
for y, o in product([F(0), F(1,10), F(1,5), F(7,20), F(1)], [F(1,10), F(1,5), F(7,20)]):
    choices = execution(y, o)
    for rc, ro in choices.values():
        check("execution_all_uses", not (rc > 0 and ro > 0))
    maximizers = {a for a, r in choices.items() if sum(r) == max(map(sum, choices.values()))}
    check("execution_best_reply", maximizers == ({"C"} if y > o else {"O"} if y < o else {"C", "O"}))

# Pure H best replies from full value comparisons, at exact thresholds and both sides.
eps = F(1,10000)
for m, beta, o, rnd in product(range(3,9), [F(1,3),F(7,10),F(99,100)], [F(1,10),F(1,3),F(7,10)], [1,2]):
    k = (m + 1) // 2
    cont = o if rnd == 2 else beta * o
    values = {F(0),F(1),o-eps,o,o+eps,cont-eps,cont,cont+eps}
    for n, y in product(range(m), sorted(v for v in values if 0 <= v <= 1)):
        old = ballot("historical",n,k,y,o,cont,cont)
        new = ballot("candidate",n,k,y,o,cont,cont)
        check("majority_exact_ballots", old[:2] == new[:2])
        check("majority_best_reply", new[1] == max(new[2:]))
        threshold_vote = ("Y" if y >= o else "N") if n >= k else (("Y" if y >= cont else "N") if n == k-1 else "Y")
        check("majority_count_rule", new[0] == threshold_vote)

# Feasible complete allocation patterns in R1; original weak votes are fixed when
# evaluating unilateral weak deviations, as required by simultaneity.
l, h = F(1,10), F(7,20)
feasible_proposals = 0
for m, beta in product(range(3,6), [F(1,3),F(9,10)]):
    k = (m + 1) // 2
    w = beta / m
    weak_grid = (F(0),w-eps,w,w+eps)
    y_grid = sorted({F(0),beta*l,beta*h,l,h,h+eps})
    for weak, y in product(product(weak_grid,repeat=m-1),y_grid):
        xi = 1-y-sum(weak)
        if xi < 0:
            continue
        feasible_proposals += 1
        prescribed = [x >= w for x in weak]
        n = sum(prescribed)
        type_values = {"historical":[],"candidate":[]}
        for o in (l,h):
            old = ballot("historical",n,k,y,o,beta*o,beta*o)
            new = ballot("candidate",n,k,y,o,beta*o,beta*o)
            check("feasible_proposal_ballots",old[:2] == new[:2])
            for game, result in (("historical",old),("candidate",new)):
                passed = n + (result[0] == "Y") >= k
                type_values[game].append((xi if passed else w,result[1]))
            for j,xj in enumerate(weak):
                other_weak = n - prescribed[j]
                # H's choice is not recomputed after this unobserved weak deviation.
                for vj in (False,True):
                    old_pass = other_weak + vj + (old[0] == "Y") >= k
                    new_pass = other_weak + vj + (new[0] == "Y") >= k
                    check("unilateral_weak_deviations",(xj if old_pass else w) == (xj if new_pass else w))
            if n >= k and y > 0:
                alt = ballot("candidate",n,k,F(0),o,beta*o,beta*o)
                check("strict_proposal_dominance",n+(alt[0]=="Y")>=k and xi+y>xi and xi+y+sum(weak)==1)
        for mu in (F(0),F(1,5),F(1,2),F(1)):
            old_avg = tuple((1-mu)*type_values["historical"][0][j]+mu*type_values["historical"][1][j] for j in (0,1))
            new_avg = tuple((1-mu)*type_values["candidate"][0][j]+mu*type_values["candidate"][1][j] for j in (0,1))
            check("proposer_and_H_expectations",old_avg==new_avg)

# Unanimity: each H action has equal values, even with unequal Y/N continuations.
for m,y,o,cy,cn in product(range(3,7),[F(0),F(1,10),F(7,20),F(1)],[l,h],[F(9,100),F(63,200)],[F(9,100),F(63,200)]):
    for n in range(m):
        old=ballot("historical",n,m,y,o,cy,cn)
        new=ballot("candidate",n,m,y,o,cy,cn)
        check("unanimity_action_identity",old==new)

# Exact terminal screening cutoff and the separate min-H proposal tie-break.
for l,h in ((F(1,10),F(7,20)),(F(1,3),F(2,3)),(F(1,100),F(99,100))):
    star=(h-l)/(1-l)
    for mu in (F(0),star/2,star,(1+star)/2,F(1)):
        weak_low=(1-mu)*(1-l)
        weak_pool=1-h
        chosen="low" if weak_low>=weak_pool else "pool"
        check("terminal_unanimity_cutoff",chosen==("low" if mu<=star else "pool"))
        if mu==star:
            check("terminal_proposer_tie",(1-mu)*l+mu*h < h)

# Algebraic comparisons including feasibility and public tie at o=1/m.
for m,beta,l,h,mu in product(range(3,9),[F(1,3),F(9,10)], [F(1,10),F(1,3)],[F(7,20),F(4,5)],[F(0),F(1,2),F(1)]):
    if l>=h:
        continue
    k=(m+1)//2; w=beta/m
    e=1-k*w; s=(1-mu)*(1-(k-1)*w-beta*l)+mu*w; p=1-(k-1)*w-beta*h
    check("R1_algebra",e-w==1-beta*(k+1)/m and e-w>0)
    check("R1_algebra",p-e==beta*(F(1,m)-h))
    check("R1_algebra",s-e==(1-mu)*beta*(F(1,m)-l)-mu*(1-beta*(k+1)/m))
    if (k-1)*w+beta*l>1:
        check("infeasible_inclusion",s<e)
    if (k-1)*w+beta*h>1:
        check("infeasible_inclusion",p<e)
    o=F(1,m)
    check("public_proposer_tie",(k-1)*w+beta*o==k*w and beta*o<o)

# Witnesses separating equal prescribed behavior from different off-path payoffs.
y,o=F(1,5),F(1,10)
old=ballot("historical",2,2,y,o,beta*o,beta*o)
new=ballot("candidate",2,2,y,o,beta*o,beta*o)
check("scope_witnesses",old[0]==new[0]=="Y" and old[2]>old[3] and new[2]==new[3])
check("scope_witnesses",old[3]!=new[3])
check("scope_witnesses",F(1,2)*y>0 and F(1,2)*y>0 and F(1,2)*y+F(1,2)*y==y)
# Counterfactual with revocable Y: zero approved offer permits outside execution;
# rejection terminal also pays o, so vote tie selects Y.
check("scope_witnesses",max(F(0),o)==o)

record={"reviewer":"/root/cold_terminal_review","note_sha256":NOTE_SHA,"argument_contract_sha256":CONTRACT_SHA,"arithmetic":"fractions.Fraction, exact comparisons, no floating tolerance","passed":sum(counts.values()),"failed":0,"by_category":dict(sorted(counts.items())),"feasible_R1_proposals":feasible_proposals,"boundary":"Finite independent verification. Not enumeration of complete PBE, continuous proposals, arbitrary belief systems or agenda assessments; no legacy B4 recertification."}
out=Path(__file__).with_name("exact_checks.json")
out.write_text(json.dumps(record,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
print(json.dumps(record,ensure_ascii=False,indent=2))
