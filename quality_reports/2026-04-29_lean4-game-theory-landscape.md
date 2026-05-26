# Landscape Report: Formalizing Game Theory (Backward Induction, Baron-Ferejohn) in Lean 4

**Date**: 2026-04-29  
**Purpose**: Survey of existing formalizations of game theory, optimization, and bargaining models in proof assistants, with assessment of feasibility for formalizing backward induction in a Baron-Ferejohn bargaining game in Lean 4.

---

## 1. Game Theory in Lean 4 / Mathlib

### 1.1 What EXISTS

**Combinatorial Game Theory (Conway games) -- in Mathlib:**
- Mathlib has a well-developed theory of **combinatorial games** in the sense of Conway (partizan games, surreal numbers).
- Modules: `SetTheory.Game.Basic`, `SetTheory.Game.Impartial`, `SetTheory.Game.Nim`, `SetTheory.Game.Domineering`, `SetTheory.Game.Birthday`, `SetTheory.Game.Ordinal`, `SetTheory.Surreal.Basic`.
- The Sprague-Grundy theorem is proven for impartial games.
- These are NOT the same as economic game theory (Nash equilibrium, extensive-form games, etc.). They concern two-player combinatorial games with perfect information and no chance moves (like Nim, Domineering).

**MixedMatched/formalizing-game-theory (Lean 4 project on GitHub):**
- Repository: https://github.com/MixedMatched/formalizing-game-theory
- Author: Alessandra Simmons.
- Defines **Utility** (as `Rat`), **pure strategies**, **normal-form games** with arbitrary number of players.
- Formalizes **Nash Equilibrium** as a property: for each player and each alternative strategy, utility does not increase by deviating.
- Includes a worked example: **Prisoner's Dilemma** with 2 players, proving that (Defect, Defect) is a Nash equilibrium.
- Supports games with continuous action spaces and intricate utility functions.
- **Limitations**: This is a small example project, NOT a library. It covers only normal-form (strategic-form) games. No extensive-form games, no backward induction, no subgame perfect equilibrium.

**Social Choice Theory:**
- There is a small library of social choice theory in Lean (adjacent to game theory).
- Plans to formalize Arrow's impossibility theorem were discussed on Lean Zulip but status is unclear.

### 1.2 What DOES NOT EXIST in Lean 4

- **Extensive-form games**: No formalization.
- **Backward induction algorithm**: Not formalized.
- **Subgame perfect equilibrium**: Not formalized.
- **Mixed strategies / mixed Nash equilibrium**: Not formalized.
- **Existence of Nash equilibrium** (via Brouwer/Kakutani): Not in Mathlib. There are independent projects formalizing Brouwer's fixed point theorem in Lean (repos by `mlavrent` and `mmasdeu`), and there is reportedly a repo proving Nash equilibrium existence via Scarf and Brouwer, but these are not in Mathlib proper.
- **Bargaining theory (Baron-Ferejohn, Rubinstein)**: Not formalized.

---

## 2. Linear Programming and Optimization in Lean 4 / Mathlib

### 2.1 What EXISTS

**CvxLean (major project):**
- Repository: https://github.com/verified-optimization/CvxLean
- A **convex optimization modeling framework** written in Lean 4.
- Problems are stated using Mathlib definitions and can be rigorously transformed (both automatically and interactively).
- Implements **DCP (Disciplined Convex Programming)** canonization with formal proofs of equivalence.
- Can call the MOSEK solver and formally verify that the original problem is equivalent to its conic form.
- PhD thesis completed July 2024.
- Published at TACAS 2023: "Verified reductions for optimization" (Bentkamp et al.).
- Presented at ICCOPT 2025.

**Formalization of First-Order Algorithms:**
- Convergence rates of four first-order algorithms for convex optimization formalized in Lean 4 using Mathlib.
- Covers: gradient descent, subgradient method, proximal gradient method, Nesterov acceleration.
- Published in *Journal of Automated Reasoning* (2025).

**KKT Conditions:**
- Formalization of first-order optimality conditions (Karush-Kuhn-Tucker conditions) for smooth constrained optimization in Lean 4.
- ArXiv: 2503.18821 (March 2025).

### 2.2 What DOES NOT EXIST

- **Linear programming as a standalone theory**: No dedicated LP formalization in Mathlib.
- **LP duality theorem**: Not formalized in Mathlib (though CvxLean handles some duality concepts for conic programs).
- **Simplex algorithm**: Not formalized.
- **Strong duality for LP**: Not formalized.

However, the CvxLean framework and the KKT formalization provide substantial infrastructure that could support LP formalization in the future.

---

## 3. Backward Induction Formalization in ANY Proof Assistant

### 3.1 Agda -- The Most Developed Work

**Higher-Order Games with Dependent Types (Escardo, Oliva et al.):**
- Published in *Theoretical Computer Science* (2023).
- ALL definitions, constructions, theorems, lemmas, proofs, and examples are **computer-verified in Agda**.
- Uses dependent type theory to formalize sequential games.
- Extends backward induction to **unbounded games** using techniques from higher-type computability theory and proof theory.
- Provides a **closed formula** for calculating strategy profiles in Nash equilibrium and subgame perfect equilibrium.
- Backward induction is understood as a **product of selection functions** (the J-sequence construction).
- Practical example: Tic-Tac-Toe implemented.
- This is the most complete formalization of backward induction in any proof assistant.

### 3.2 Rocq (Coq) -- Bloomberg's Game Trees

**bloomberg/game-trees:**
- Repository: https://github.com/bloomberg/game-trees
- Published as a **proof pearl** at CPP 2026: "A Rose Tree Is Blooming" (Joomy Korkut).
- Implements **game trees as rose trees** in Rocq (formerly Coq).
- Formalizes the **minimax algorithm** with proofs of correctness.
- Includes a **proven-complete game tree** for Tic-Tac-Toe with an unbeatable AI.
- Relevant to backward induction since minimax on perfect-information game trees IS backward induction.

### 3.3 Coq/Isabelle -- Nash Equilibrium Existence

**Le Roux, Martin-Dorel, Smaus (2017):**
- Paper: "An Existence Theorem of Nash Equilibrium in Coq and Isabelle" (GandALF 2017).
- ArXiv: 1709.02096.
- Formalizes a specific existence theorem for NE: for games with finitely many outcomes, deriving win/lose games and showing one player has a winning strategy implies NE existence.
- Also implies existence of **secure equilibrium** (stronger than NE).
- Coq version is more general (dependent types allow arbitrary players/strategy spaces).
- **Does NOT formalize backward induction or extensive-form games directly.**

### 3.4 Coq -- Bel-Games (Incomplete Information)

**Pomeret-Coquot, Fargier, Martin-Dorel (ITP 2023):**
- Paper: "Bel-Games: A Formal Theory of Games of Incomplete Information Based on Belief Functions in the Coq Proof Assistant."
- Repository: https://github.com/pPomCo/belgames
- Formalizes belief functions and extends Bayesian games to "Bel games."
- Proves extended Howson-Rosenthal theorem (three different proofs).
- Focus is on **normal-form games with incomplete information**, not extensive-form/backward induction.

### 3.5 Summary Table

| Concept | Lean 4 | Coq/Rocq | Isabelle | Agda |
|---|---|---|---|---|
| Normal-form games | Partial (MixedMatched) | Yes (multiple) | Yes (Le Roux) | Yes |
| Nash equilibrium (definition) | Yes (MixedMatched) | Yes | Yes | Yes |
| Nash equilibrium (existence) | No | Yes (Le Roux) | Yes (Le Roux) | Partial |
| Extensive-form games | **No** | Partial (bloomberg) | No | **Yes** |
| Backward induction | **No** | Partial (minimax) | No | **Yes** |
| Subgame perfect equilibrium | **No** | No | No | **Yes** |
| Mixed strategies | No | Yes (Bel-Games) | Partial | Partial |
| Combinatorial games (Conway) | Yes (Mathlib) | No | No | No |
| Game trees (data structure) | No | Yes (bloomberg) | No | Yes |

---

## 4. Baron-Ferejohn / Rubinstein Bargaining in Formal Verification

### Finding: NOTHING EXISTS

No formalization of Baron-Ferejohn (1989), Rubinstein (1982), or any legislative bargaining model has been found in ANY proof assistant (Lean, Coq, Isabelle, Agda, or any other).

The search covered academic databases, GitHub, proof assistant community archives, and general web searches. The result is consistently negative. These models have been studied computationally (e.g., algorithms for computing equilibrium values in Baron-Ferejohn by Eraslan & McLennan), but never formally verified in a proof assistant.

---

## 5. Relevant Data Structures in Mathlib for Game Trees

### What Mathlib offers:

- **`Mathlib.Data.Tree.Basic`**: Binary tree storage with O(lg n) retrieval. Too restrictive for game trees (need variable branching).
- **`Mathlib.Data.W.Basic`**: **W-types (well-founded trees)** -- finitely branching trees where nodes labeled by `alpha` have children indexed by `beta alpha`. This is the most promising primitive for game trees. W-types are encodable when alpha is an encodable fintype.
- **`Mathlib.SetTheory.Descriptive.Tree`**: Trees of depth omega (descriptive set theory). Not directly useful.
- **`Mathlib.Data.Finset.Basic`**: Finite sets, useful for representing finite action spaces.
- **`Mathlib.Data.Finite.Defs`**: Finite type class.

### Assessment for Game Trees:

W-types (`WType`) are a natural fit for representing extensive-form game trees:
- Nodes can be labeled with player identities.
- Children can be indexed by available actions.
- The well-founded structure guarantees termination of backward induction.

However, one would need to build additional structure on top:
- Information sets (for imperfect information games).
- Player assignment functions.
- Utility/payoff at terminal nodes.
- Probability distributions (for chance moves / Baron-Ferejohn's random proposer).

---

## 6. Feasibility Assessment: Backward Induction for Baron-Ferejohn in Lean 4

### What Would Need to Be Built

1. **Extensive-form game tree** (inductive type):
   - Nodes: proposer (chosen randomly), responders (vote).
   - Terminal nodes: agreement (allocation accepted) or continuation (new round with discounting).
   - Must handle infinite horizon (or truncated finite horizon).

2. **Strategy profiles**:
   - Proposer strategy: mapping from recognition to proposed allocation.
   - Responder strategy: accept/reject threshold.

3. **Backward induction**:
   - For finite-horizon version: standard recursive algorithm on game tree.
   - For infinite-horizon (stationary equilibrium): need to formalize value functions, fixed-point characterization.

4. **Subgame perfect equilibrium**:
   - Definition: Nash equilibrium in every subgame.
   - Proof that backward induction yields SPE.

5. **Baron-Ferejohn specific results**:
   - Existence and characterization of stationary SPE.
   - Proposer advantage.
   - Minimum winning coalition formation.

### Difficulty Assessment

| Component | Difficulty | Reason |
|---|---|---|
| Finite game tree type | Medium | W-types exist; need to add game-theoretic structure |
| Backward induction (finite) | Medium | Well-founded recursion is well-supported in Lean 4 |
| Subgame perfect equilibrium (def) | Medium | Straightforward definition once games are set up |
| Backward induction yields SPE | Hard | Inductive proof requiring careful formalization |
| Infinite-horizon extension | Very Hard | Requires limits, discounting, fixed-point theorems |
| Baron-Ferejohn stationary SPE | Very Hard | Needs probability theory, expectations, fixed-point characterization |
| Uniqueness of stationary SPE | Very Hard | Requires substantial analysis machinery |

### Key Challenges

1. **No existing game-theory library**: Everything must be built from scratch in Lean 4. The MixedMatched project covers only normal-form games and is too limited.

2. **Infinite horizon**: Baron-Ferejohn is fundamentally an infinite-horizon game. The finite-horizon version is tractable, but the interesting results (stationary equilibrium, proposer advantage) require infinite horizon with discounting.

3. **Probability**: Random proposer recognition requires probability theory. Mathlib has probability/measure theory (`MeasureTheory`), but connecting it to game-theoretic expectations would require substantial work.

4. **Fixed-point arguments**: The stationary equilibrium characterization uses a fixed-point argument (continuation values solve a system of equations). This is different from Brouwer/Kakutani and is more algebraic in nature (for the symmetric case, it reduces to solving a system of linear equations).

5. **Real analysis**: Utility involves real numbers, discounting involves geometric series, and the equilibrium characterization involves inequalities and equalities over reals. Mathlib has strong real analysis, but the formalization overhead is significant.

### Recommended Approach

**Start with a finite-horizon, finite-player version:**
- 3 players (minimal interesting case for majority rule).
- T rounds (finite horizon).
- Discrete allocation space (divide N units).
- Backward induction as a recursive function on game tree depth.
- Prove: the backward induction outcome is an SPE.

This would be a **novel contribution** -- no one has formalized backward induction for a legislative bargaining game in any proof assistant.

**Estimated effort**: 2-4 months of dedicated Lean 4 work by someone with Mathlib experience. The Agda work by Escardo/Oliva provides conceptual guidance (especially the dependent-type approach to sequential games), and the bloomberg/game-trees Rocq project provides practical patterns for game tree manipulation.

---

## 7. Key References and Resources

### Lean 4 / Mathlib
- MixedMatched/formalizing-game-theory: https://github.com/MixedMatched/formalizing-game-theory
- CvxLean (convex optimization): https://github.com/verified-optimization/CvxLean
- Mathlib4 W-types: https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/W/Basic.html
- Mathlib4 Surreal/Game: https://leanprover-community.github.io/mathlib4_docs/Mathlib/SetTheory/Surreal/Basic.html
- Lean Zulip discussion on Game Theory: https://leanprover-community.github.io/archive/stream/113489-new-members/topic/Game.20Theory.html

### Coq/Rocq
- bloomberg/game-trees (rose trees + minimax): https://github.com/bloomberg/game-trees
- Bel-Games (incomplete information): https://github.com/pPomCo/belgames
- Le Roux et al., "An Existence Theorem of Nash Equilibrium in Coq and Isabelle" (2017): https://arxiv.org/abs/1709.02096

### Agda
- Escardo, Oliva et al., "Higher-order Games with Dependent Types" (TCS 2023): https://www.sciencedirect.com/science/article/pii/S0304397523004243

### Optimization in Lean 4
- CvxLean: https://github.com/verified-optimization/CvxLean
- Verified reductions (TACAS 2023): https://link.springer.com/chapter/10.1007/978-3-031-30820-8_8
- KKT conditions formalization: https://arxiv.org/abs/2503.18821
- First-order algorithms convergence (JAR 2025): https://link.springer.com/article/10.1007/s10817-025-09741-w

### Brouwer Fixed Point in Lean
- mlavrent/brouwer-fp-formalization: https://github.com/mlavrent/brouwer-fp-formalization
- mmasdeu/brouwerfixedpoint: https://github.com/mmasdeu/brouwerfixedpoint

---

## 8. Bottom Line

**Game theory in Lean 4 is in its infancy for economic/strategic game theory.** Mathlib has strong combinatorial game theory (Conway games), but nothing on Nash equilibrium, extensive-form games, backward induction, or bargaining. A small GitHub project (MixedMatched) covers normal-form games with NE definitions but is far from library quality.

**Optimization in Lean 4 is more developed**, with CvxLean providing a serious convex optimization framework, and recent papers formalizing KKT conditions and convergence rates of first-order methods. However, LP duality and simplex are not yet formalized.

**Backward induction has been formalized** most thoroughly in Agda (Escardo/Oliva) and partially in Rocq (Bloomberg's game-trees with minimax). Neither targets economic bargaining games.

**Baron-Ferejohn has never been formalized** in any proof assistant. A formalization would be a genuinely novel contribution. The recommended path is to start with a finite-horizon, discrete version and use Lean 4's well-founded recursion machinery with W-type game trees. This is feasible but requires 2-4 months of focused work.
