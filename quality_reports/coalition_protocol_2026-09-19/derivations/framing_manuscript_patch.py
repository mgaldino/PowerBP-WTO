"""Scoped framing harmonization for the proposed coalition manuscript.

This is a pure transformation. It does not edit the canonical source.
The introductory qualifications follow original contract R01/R02 and
the coalition architecture approved on 2026-09-19.
"""

ABSTRACT = (
    "Why can unanimity benefit a powerful state when every member has the same veto? "
    "This paper studies a two-round bargaining game in which weak states propose "
    "coalitions and allocations, and a hegemon privately knows whether its disagreement "
    "payoff is low or high. Every invited member must consent. Majority permits an "
    "agreement that excludes the hegemon while leaving it its outside option; unanimity "
    "makes its inclusion indispensable. Relative to a public-information benchmark, "
    "unanimity pooling transfers informational rent to the low type, while majority can "
    "eliminate that rent through exclusion. Some beliefs admit no equilibrium in the "
    "maintained class of pure ballot strategies. An extension lets the hegemon propose "
    "first. Agenda power weakly benefits it under unanimity wherever both games admit "
    "equilibrium. When both rules admit equilibrium, majority nevertheless benefits "
    "both types across all equilibria if the high disagreement payoff, discounted one "
    "round, is below the share of "
    "weak states a minimal winning coalition can exclude. The model offers a rationalist "
    "account of unequal bargaining power under formally equal rules."
)


def once(text, old, new):
    assert text.count(old) == 1, old
    return text.replace(old, new, 1)


def migrate_framing(text):
    text = once(text, 'date: "2026-08-22"', 'date: "2026-09-19"')
    start = text.index("abstract: |\n") + len("abstract: |\n")
    end = text.index("\n---", start)
    text = text[:start] + "  " + ABSTRACT + text[end:]
    text = once(text, """Under majority, whenever the hegemon's vote is expensive relative to a weak
state's, proposers assemble winning coalitions entirely from uninformed states
and its informational rent is exactly zero. Under unanimity, the hegemon's""", """Under majority, proposers can assemble winning coalitions entirely from
uninformed states. The excluded hegemon receives its outside option even when
their agreement passes. Exclusion eliminates informational rent for both types
when both would also be excluded under public information. Under unanimity, the hegemon's""")
    text = once(text, """Moving first gives the hegemon the familiar agenda rent under unanimity, but
also changes the value of its private information. Majority benefits both
types when the hegemon's disagreement payoff is low relative to the share of weak
states that a winning coalition can leave out. In those cases, only the
informational rent can reverse the public-information advantage of majority.""", """Moving first gives the hegemon the familiar public-information agenda rent
under unanimity, but also changes the value of its private information.
Where both institutional games admit equilibrium, majority benefits both types
in every equilibrium if the high disagreement payoff, discounted one round,
is below the share of weak states that a minimal
winning coalition can leave out. More generally, whenever a private-information
comparison reverses a public-information advantage of majority, the difference
in informational rents must be large enough to account for that reversal.""")
    return text
