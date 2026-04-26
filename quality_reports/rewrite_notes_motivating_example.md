# Notas editoriais: Motivating Example

**Arquivo original**: formal_model_v4.Rmd, Section 2
**Data**: 2026-04-26

## Diagnóstico da versão original

The section is analytically complete and the numbers are well-chosen. Three editorial issues: (1) the opening paragraph is overloaded, mixing a methodological convention, the example setup, all parameter definitions, and the proposer selection clarification in a single dense block; (2) the bold headers (**Majority: exclusion eliminates screening.**) function as mini-titles that fragment the narrative into labeled boxes rather than letting the argument flow as prose; (3) the "Preview" paragraph at the end is generic signposting that lists what the general model adds without explaining why it matters.

## Principais mudanças

1. **Split the opening paragraph into two**: the consensus=unanimity convention stands alone as a short orienting sentence; the example setup follows as a separate paragraph with clearer parameter presentation. This reduces cognitive load.

2. **Removed bold headers**: replaced **Majority: exclusion eliminates screening.**, **Unanimity: inclusion creates screening.**, **The jump and overpayment.**, **Bayesian persuasion exploits the jump.**, and **Preview.** with narrative prose that flows from one paragraph to the next. The argument now reads as a continuous exposition rather than a labeled sequence. Each paragraph still does one job, but without the textbook-section feel.

3. **Added interpretive gloss to the screening dilemma**: "the proposing weak state faces a dilemma" and "It must decide how much to offer without knowing θ" make the weak state's problem vivid before the algebra. The original jumped directly from "H's vote is required" to the offer menu.

4. **Made the bullet points more readable**: added brief plain-language descriptions ("pays the hegemon its low-state outside option", "pays the hegemon its high-state outside option") before the algebra in each bullet, so the reader knows what each offer does before seeing the payoff expressions.

5. **Separated the jump from its source**: the original compressed the jump magnitude, the overpayment explanation, and the economic interpretation into a single paragraph. The rewrite gives the jump its own paragraph opening ("The switch in behavior creates a discrete jump...") and then explains overpayment as the source.

6. **Rewrote the Preview paragraph**: removed the generic "enriches this logic" framing. The rewrite states concretely what changes (two cutoffs, entry threshold as second channel) and what the theorems establish, without repeating what the intro already said.

7. **Moved the general-model forward reference**: "The general model (Section 3) extends this to N players..." now appears at the end of the setup paragraph rather than at the beginning, so the reader sees the example's own parameters before learning how they generalize.

## O que foi preservado

- All numerical values: V(0)=1, V(1)=2, α=0.2, cutoff 1/9, jump 8/45 ≈ 0.18 ≈ 16%
- All algebra: the indifference condition 0.8(1-μ) > 0.6(1-μ) + 1.6μ, the BP signal construction (posterior 1/9 with prob 9p, posterior 0 with prob 1-9p), the resulting payoff 0.2 + 1.8p
- The consensus=unanimity convention sentence (moved to its own paragraph)
- The proposer-selection clarification ("A proposer is selected uniformly at random; to isolate the screening mechanism, I focus on the branch where a weak state proposes")
- The final sentence about Theorems 1 and 2
- The bullet-point format for the two offers (aggressive/conservative)

## Pontos para verificação do autor

1. The rewrite drops the phrase "This is the central asymmetry" from the BP paragraph. The original used it as a concluding punch line. The rewrite lets the mathematics speak: "Unanimity creates a non-convexity that makes the hegemon's private information strategically productive; majority does not." Verify this is forceful enough.

2. The bold headers served as navigation aids. Without them, the section relies on paragraph structure alone. If the author prefers labeled subsections for readability (some JoP papers use this style in examples), the headers can be restored in a lighter form (e.g., italic rather than bold, or as run-in paragraph openers).

3. The Preview paragraph no longer mentions "a richer non-convexity structure" as a separate item. It says "two screening cutoffs (one per round) and an entry threshold that creates a second channel." Verify this adequately previews the general model's additions.

## Anti-LLM verification

- Em dashes: 0 (none used)
- Emphatic pivots (however, indeed, crucially...): 0
- Contrastive formulas ("not X, but Y"): 0
- Generic phrasing ("sheds light on", "at the heart of"): 0
- Performative paragraph endings: 0
- Artificial symmetry: 0
- All sentences are specific to this paper's content

PASS on all checks.
