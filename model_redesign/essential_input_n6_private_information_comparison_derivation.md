# N6 <e2><80><94> private-information comparison

**Status:** `pending_independent_review` (implementation candidate).

## Administrative transition

Goal 2 fechado; Goal 3 autorizado pelo autor exclusivamente para N6.

## Frozen inputs and scope

- N3 majority interface: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`.
- N4 unanimity interface: `sha256:ee61ce6f854d4393f51048592a5221a9999a8f3f7daca1e749e7f19a88927f2d`.
- The comparison is private-information only and uses the source-native R1 payoff units.
- N7/public benchmarks, RI_M, RI_U, DeltaRI, formation, beta=1, and manuscript files are outside this node.

## Construction

1. Copy every source coverage cell and its existence certificate into the corresponding private-rule collection.
2. Copy each source equilibrium record once, retaining its source cell ID, equilibrium ID, interface hash, payoff vector, outcome distribution, selection status, and checks.
3. Form every pair of a majority source cell and an unanimity source cell. The pair is an intersection cell of the common refinement.
4. If both cells exist, form the complete Cartesian product of their source records. If either is `none`, retain an empty comparison cell with its certificate and do not remove the surviving rule collection.
5. Store type-specific payoff contrasts and all four outcome contrasts symbolically. No branch, identity product, or equilibrium is selected.

## Private comparison finding

The candidate contains 7 private source records and 6 admissible comparison records across 6 common-refinement cells; `0` comparison cells are `none` in the current frozen inputs.

The formal domain retains both m=2 and m>=3 for completeness. The main substantive interpretation emphasizes m>=3 (at least three weak states, hence four or more total members); the m=2 cells are reported but are secondary and do not redefine the contract.
In the m>=3 N4 cells, delay equilibria exist universally in the source correspondence, but delay is not forced: pooling also exists. The comparison is set-valued because the source interfaces preserve complete equilibrium correspondences. The majority correspondence retains exclusion, while unanimity source cells retain zero passage without H. Delay is carried as the exact source expression and branch condition, so N6 does not impose a scalar delay ranking or select a branch.

## Audit ledger

Claims are in `essential_input_n6_private_information_comparison_ledger.json`. The statuses are limited to the contract vocabulary; the structural transport and coverage claims are proved by the executable construction and verifier, while no public-rent or formation claim is made.

## Invalidation

A change to either frozen predecessor hash invalidates N6 and requires rebuilding this interface and repeating both independent reviews. A change to N6 after review creates a new hash and returns the node to pending. N7 remains unopened.

Candidate interface hash: `sha256:e5a71e29720598f829beb4f720bc966a64d2b04569ded0ba404cdd03b81b3f2a`.
