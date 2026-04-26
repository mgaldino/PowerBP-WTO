# Thomson Prose Audit: B.5a and B.5

**Date**: 2026-04-26
**Reviewer**: Senior theorist (Thomson 1999 standard)
**Sections reviewed**: B.5a (Derivation of the payoff decomposition) and B.5 (Proof of Lemma 1)
**Reference**: Thomson (1999) "The Young Person's Guide to Writing Economic Theory", Section 5 (52--63.5% natural language in top-journal proofs)

---

## Grade: A

---

## Item-by-item assessment

### Section B.5a: Derivation of the payoff decomposition

**Sentence 1 (line 970, opening sentence):**
> "This appendix derives the decomposition $D(\mu) = D_{\text{base}}(\mu) + \mathbf{1}\{\mu < \mu_s^{R2}\}\cdot\delta_{R2}(\mu) + \mathbf{1}\{\mu > \mu_s^{R1}\}\cdot\delta_{R1}(\mu)$ from the primitive payoff formulas in Appendices A.1--A.3."

- Accurate: **Yes** -- correctly states what the section does.
- Helpful: **Yes** -- tells the reader exactly what will be proved and where the inputs come from.
- Concise: **Yes** -- one sentence.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 2 (Step 0, first paragraph):**
> "The first task is to write down the hegemon's R1 payoff from its primitive components. Because proposals are random, the payoff splits naturally by proposer identity, and this separation will prove essential: each component turns out to depend on a different screening regime, which is ultimately why the two corrections are additive."

- Accurate: **Yes** -- this is exactly what Step 4 (Additivity) later confirms: $\delta_{R2}$ operates through $\Pi_H^{\text{prop}}$ and $\delta_{R1}$ through $\Pi_H^{W}$.
- Helpful: **Yes** -- previews the structural logic so the reader knows *why* the decomposition by proposer identity matters.
- Concise: **Yes** -- two sentences, no padding.
- Avoids restating algebra: **Yes** -- explains the reason, not the mechanics.
- English/style: **PASS**.

**Sentence 3 (Step 0, second paragraph):**
> "The hegemon's expected R1 payoff $E[V_H^{R1}(\mu, U)]$ has two components, corresponding to the identity of the R1 proposer."

- Accurate: **Yes**.
- Helpful: **Yes** -- transitions cleanly into the two sub-cases.
- Concise: **Yes**.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 4 (Step 0, italic "H proposes" paragraph):**
> "The hegemon offers each weak state $\beta V_W^{R2}(\mu)$ (its discounted R2 continuation) and keeps the remainder."

- Accurate: **Yes** -- standard take-it-or-leave-it logic.
- Helpful: **Yes** -- reminds the reader of the proposer's strategy.
- Concise: **Yes**.
- Avoids restating algebra: **Yes** -- the equation follows, this sentence explains the logic.
- English/style: **PASS**.

**Sentence 5 (Step 0, italic "W proposes" paragraph):**
> "The proposing weak state makes an offer to $H$ that depends on the R1 screening regime. Under an aggressive R1 offer ($\mu < \mu_s^{R1}$), only $\theta = 0$ accepts; $\theta = 1$ rejects and the game proceeds to R2 with posterior $\mu' = 1$. The R1 offer to $H$ is $\beta V_H^{R2}(\theta{=}0, \mu'{=}1)$, and $\theta = 1$'s payoff from rejection is $\beta V_H^{R2}(\theta{=}1, \mu'{=}1)$. Since $\mu' = 1 > \mu_s^{R2}$, both R2 values are evaluated in the conservative R2 regime..."

- Accurate: **Yes** -- the off-path posterior $\mu'=1$ is correct (after $\theta=1$ rejects, W infers $\theta=1$), and $1 > \mu_s^{R2}$ places both in the conservative regime.
- Helpful: **Yes** -- this is a crucial logical step that makes the subsequent equations interpretable.
- Concise: **MINOR ISSUE** -- four sentences for one sub-case. Slightly longer than the ideal 1-2 sentence guideline, but justified because it explains a non-trivial equilibrium inference (off-path updating). Acceptable.
- Avoids restating algebra: **Yes** -- explains the *game-theoretic reasoning*, not the algebra.
- English/style: **PASS**.

**Sentence 6 (Step 0, conservative R1 description):**
> "Under a conservative R1 offer ($\mu > \mu_s^{R1}$), both types accept. The offer is set at $\beta V_H^{R2}(\theta{=}1, \mu'{=}1) = \beta(r+x)/N$ to satisfy the high type's participation constraint."

- Accurate: **Yes**.
- Helpful: **Yes**.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 7 (Two observations paragraph, line 994):**
> "Two features are important. First, the R1 offers to $H$ in \eqref{eq:R1offer_agg}--\eqref{eq:R1offer_con_type1} are evaluated at the off-path posterior $\mu' = 1$ and therefore do not depend on $V_W^{R2}(\mu)$. Second, $H$'s proposal payoff \eqref{eq:H_prop_component} depends on $V_W^{R2}(\mu)$ but is the same regardless of the R1 regime. These two observations establish that the R1 and R2 corrections are independent."

- Accurate: **Yes** -- this is the key structural insight; equations confirm each claim.
- Helpful: **Yes** -- crystallizes the independence argument before the algebra proves it.
- Concise: **Yes** -- four sentences, but they summarize two distinct observations plus the conclusion. Tight.
- Avoids restating algebra: **Yes** -- summarizes the *implication* of the functional forms.
- English/style: **PASS**.

**Sentence 8 (Step 1, opening):**
> "I now compute the hegemon's total payoff in a benchmark regime---aggressive R1 screening and conservative R2 screening---which serves as the reference point against which the two corrections will be measured. The choice of benchmark is not arbitrary: under this regime, both components of the payoff take their simplest form, and the corrections for each alternative regime can then be isolated one at a time."

- Accurate: **Yes**.
- Helpful: **Yes** -- explains the proof strategy.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 9 (Step 2, opening):**
> "The next step is to compute the payoff change when the R1 regime switches from aggressive to conservative. Because this switch affects only the R1 offers that $W$ makes to $H$---and not $H$'s own proposal, which depends on $V_W^{R2}$---the correction will appear exclusively in $\Pi_H^{W}$, confirming that it can be treated independently of the R2 regime."

- Accurate: **Yes** -- exactly what the algebra confirms.
- Helpful: **Yes** -- tells the reader which component to watch.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes** -- explains *why*, not *how*.
- English/style: **PASS**.

**Sentence 10 (Step 2, closing):**
> "This is non-negative for all $\mu \leq 1$, with equality only at $\mu = 1$. The correction reflects the overpayment that the low type receives under conservative R1 offers."

- Accurate: **Yes** -- $(r-1)(1-\mu) \geq 0$ with equality iff $\mu=1$.
- Helpful: **Yes** -- gives economic interpretation.
- Concise: **Yes**.
- Avoids restating algebra: **Yes** -- the second sentence is pure interpretation.
- English/style: **PASS**.

**Sentence 11 (Step 3, opening):**
> "I now derive the payoff change when the R2 regime switches from conservative to aggressive. By an argument symmetric to Step 2, this switch affects only $H$'s proposal payoff $\Pi_H^{\text{prop}}$---the R1 offers to $H$ are pinned at the off-path posterior $\mu' = 1$, which always lies in the conservative R2 regime regardless of the on-path belief $\mu$."

- Accurate: **Yes**.
- Helpful: **Yes** -- leverages the symmetric structure.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 12 (Step 3, continuity check):**
> "...so $\delta_{R2}(\mu) = (N-1)\beta[\mu(r-\alpha) - \alpha(r-1)]/N^2$, which matches the formula in Appendix B.5. At $\mu = \mu_s^{R2} = \alpha(r-1)/(r-\alpha)$, direct substitution gives $\delta_{R2}(\mu_s^{R2}) = 0$, confirming continuity at the R2 cutoff."

- Accurate: **Yes** -- substituting $\mu_s^{R2}$ into $\mu(r-\alpha) - \alpha(r-1)$ gives $\alpha(r-1)(r-\alpha)/(r-\alpha) - \alpha(r-1) = 0$.
- Helpful: **Yes** -- the continuity check is reassuring and standard.
- Concise: **Yes**.
- Avoids restating algebra: **PASS** -- the "direct substitution" phrase is borderline but acceptable since it explains *what* was verified.
- English/style: **PASS**.

**Sentence 13 (Step 4, opening):**
> "With both corrections in hand, I can now establish that they combine additively. This is the key structural result: it means the full payoff on any branch of the belief space can be written as the benchmark plus whichever corrections are active, without interaction terms."

- Accurate: **Yes**.
- Helpful: **Yes** -- frames the significance.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 14 (Step 4, bullet points):**
> "The two corrections are independent because they affect disjoint components of $H$'s payoff: [two bullets]"

- Accurate: **Yes** -- correctly identifies which equation each correction acts through.
- Helpful: **Yes** -- compact summary of the independence argument.
- Concise: **Yes**.
- Avoids restating algebra: **Yes** -- references equations rather than repeating them.
- English/style: **PASS**.

**Sentence 15 (Step 5, opening):**
> "The final step subtracts the majority payoff from the unanimity benchmark to obtain $D_{\text{base}}$. This completes the decomposition: the payoff difference $D(\mu)$ on any branch equals $D_{\text{base}}$ plus the active corrections, and all three components are affine in $\mu$."

- Accurate: **Yes**.
- Helpful: **Yes** -- wraps up the proof strategy.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 16 (Step 5, intermediate identity):**
> "...where the third line uses $N(1+(N-1)\alpha) = N + C_{\text{out}}$ and $(N-1)\beta N\alpha r = C_{\text{out}}\beta r$."

- Accurate: **Yes** -- $C_{\text{out}} = N(N-1)\alpha$, so $N + C_{\text{out}} = N + N(N-1)\alpha = N(1+(N-1)\alpha)$; and $(N-1)\beta N\alpha r = N(N-1)\alpha \cdot \beta r = C_{\text{out}}\beta r$.
- Helpful: **Yes** -- makes the algebraic simplification traceable.
- Concise: **Yes**.
- Avoids restating algebra: **MINOR ISSUE** -- this does "explain what the algebra says," but for algebraic identity steps in a derivation appendix, signposting intermediate substitutions is standard practice (Thomson himself endorses it). Acceptable.
- English/style: **PASS**.


### Section B.5: Proof of Lemma 1

**Sentence 17 (Opening paragraph, line 1062):**
> "The payoff difference $D(\mu)$ decomposes into a baseline affine term plus two correction terms, each itself affine. Positivity therefore reduces to checking endpoints. The decomposition is derived in Appendix B.5a."

- Accurate: **Yes** -- this is the core proof strategy.
- Helpful: **Yes** -- tells the reader the entire logical plan in three sentences.
- Concise: **Yes**.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 18 (Step 1, opening):**
> "The proof strategy is to decompose $D(\mu)$ into piecewise-affine components and verify positivity by checking endpoints on each branch. Because affine functions are determined by their boundary values, this reduces a continuum of inequalities to a finite number of endpoint conditions."

- Accurate: **Yes**.
- Helpful: **Yes** -- tells the reader *why* the endpoint strategy works.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **ISSUE (minor)** -- this partially repeats the opening paragraph (lines 1062--1063). The opening says "Positivity therefore reduces to checking endpoints"; Step 1 says "this reduces a continuum of inequalities to a finite number of endpoint conditions." The redundancy is mild but noticeable. See fix suggestion below.

**Sentence 19 (Step 1, additivity explanation):**
> "The two corrections are additive because they affect independent components of $H$'s payoff: $\delta_{R2}$ captures the change in $V_W^{R2}(\mu)$ (which enters through $H$'s proposal offer), while $\delta_{R1}$ captures the change in the R1 offer $H$ receives when $W$ proposes (which depends on the R1 regime but not on $V_W^{R2}$)."

- Accurate: **Yes** -- matches B.5a's Step 4.
- Helpful: **Yes** -- reminds the reader of the independence result without requiring them to re-read B.5a.
- Concise: **Yes** -- one sentence.
- Avoids restating algebra: **Yes** -- references the economic channel, not formulas.
- English/style: **PASS**.

**Sentence 20 (Step 1, properties paragraph):**
> "$D_{\text{base}}$ is the difference under aggressive R1 and conservative R2. The R2 correction vanishes at the screening cutoff: $\delta_{R2}(\mu_s^{R2}) = 0$, ensuring continuity at $\mu_s^{R2}$. The R1 correction satisfies $\delta_{R1}(\mu) \geq 0$ for all $\mu \leq 1$, with equality only at $\mu = 1$."

- Accurate: **Yes**.
- Helpful: **Yes** -- collects the key properties needed for assembly.
- Concise: **Yes**.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 21 (Step 2, opening):**
> "Since $D_{\text{base}}$ is affine in $\mu$---it depends on $\mu$ only through $V_e(\mu) = 1 + \mu(r-1)$, which is itself affine---checking positivity at the two endpoints $\mu = 0$ and $\mu = 1$ is both necessary and sufficient."

- Accurate: **Yes**.
- Helpful: **Yes** -- justifies the endpoint method.
- Concise: **Yes** -- one sentence.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 22 (Step 2, $D_I(0)$ paragraph):**
> "We check $D_I(0)$ rather than $D_{\text{base}}(0)$ directly, because $\delta_{R2}(0) < 0$---so $D_I(0)$ is the tighter endpoint condition."

- Accurate: **Yes** -- $\delta_{R2}(0) = (N-1)\beta[0 - \alpha(r-1)]/N^2 < 0$, so $D_I(0) = D_{\text{base}}(0) + \delta_{R2}(0) < D_{\text{base}}(0)$.
- Helpful: **Yes** -- explains why the proof attacks the harder case.
- Concise: **Yes** -- one sentence.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 23 (Step 2, conclusion):**
> "$D_{\text{base}}$ is affine with positive values at both endpoints, hence $D_{\text{base}}(\mu) > 0$ for all $\mu \in [0,1]$."

- Accurate: **Yes**.
- Helpful: **Yes** -- clean summary.
- Concise: **Yes**.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 24 (Step 3, opening):**
> "The strategy is to partition the belief space $(0,1]$ by the two screening cutoffs and verify $D > 0$ on each branch, using the endpoint results from Steps 1--2. On every branch, $D$ is a sum of affine functions and is therefore itself affine, so positivity at branch endpoints implies positivity throughout."

- Accurate: **Yes**.
- Helpful: **Yes** -- roadmap for the assembly.
- Concise: **Yes** -- two sentences.
- Avoids restating algebra: **Yes**.
- English/style: **ISSUE (minor)** -- "Steps 1--2" should probably be "Steps 1 and 2" for clarity, since there is no Step 1.5. However, the dash-range notation is standard in mathematical writing and not incorrect. Nitpick only.

**Sentence 25 (Step 3, branch explanations):**
> "At the left endpoint, $D_I(0) > 0$ (Step 2). At the right endpoint, $\delta_{R2}(\mu_s^{R2}) = 0$, so $D(\mu_s^{R2}) = D_{\text{base}}(\mu_s^{R2}) > 0$ (Step 2). Affine with positive endpoints implies $D > 0$ throughout."

- Accurate: **Yes**.
- Helpful: **Yes** -- clean, mechanical, exactly right for assembly.
- Concise: **Yes**.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

**Sentence 26 (Alternative case, independence justification):**
> "The decomposition [...] remains valid because $\delta_{R2}$ and $\delta_{R1}$ affect independent components of the payoff: $\delta_{R2}$ operates through the R2 continuation value $V_W^{R2}(\mu)$ in the hegemon's proposal, while $\delta_{R1}$ operates through which R1 offer $H$ receives when $W$ proposes. Neither depends on the other."

- Accurate: **Yes**.
- Helpful: **Yes** -- essential for the reader to accept that the same decomposition applies.
- Concise: **Yes** -- two sentences plus the short "Neither depends on the other."
- Avoids restating algebra: **Yes**.
- English/style: **ISSUE (minor)** -- this is the third time the independence argument appears (B.5a Step 4, B.5 Step 1, and now here). Each instance serves a different purpose (derivation, summary, application to the alternative case), so the repetition is defensible. However, the third occurrence could be shortened to a cross-reference: "The decomposition remains valid by the independence argument in Step 1." See fix suggestion below.

**Sentence 27 (Step 4, Necessity):**
> "To establish that $\alpha < \alpha^*$ is not merely sufficient but also necessary, I show that the inequality $D(\mu) > 0$ fails at $\mu = 1$ whenever $\alpha \geq \alpha^*$."

- Accurate: **Yes** -- exactly what follows.
- Helpful: **Yes** -- previews the one-line argument.
- Concise: **Yes** -- one sentence.
- Avoids restating algebra: **Yes**.
- English/style: **PASS**.

---

## Equations check: Were any equations accidentally modified?

I compared the key formulas against their definitions in the paper body and appendix A. All checked:

- Eq. \eqref{eq:H_prop_component}: $\Pi_H^{\text{prop}} = [V_e(\mu) - (N-1)\beta V_W^{R2}(\mu)]/N$ -- **correct**.
- Eqs. \eqref{eq:R1offer_agg}--\eqref{eq:R1offer_con_type1}: R1 offers at $\mu'=1$ -- **correct**.
- Eq. \eqref{eq:W_prop_component}: piecewise $\Pi_H^W$ -- **correct**.
- Eq. \eqref{eq:E_bench}: benchmark sum with identity $\alpha r + x = N\alpha r$ -- **correct** ($x = (N-1)\alpha r$).
- Eq. \eqref{eq:delta_R1_derived}: $(N-1)\beta(r-1)(1-\mu)/N^2$ -- **correct**.
- Eq. \eqref{eq:delta_R2_derived}: $(N-1)\beta[\mu(r-\alpha)-\alpha(r-1)]/N^2$ -- **correct**.
- Eq. \eqref{eq:Dbase_derived}: $(C_{\text{buy}}-C_{\text{out}})V_e(\mu) + C_{\text{out}}\beta r)/N^2$ -- **correct**.
- Decomposition formula (two appearances) -- **consistent**.
- $D_{\text{base}}(1)$ formula and link to $\alpha^*$ -- **correct**.
- $D_I(0)$ argument and $\bar\alpha_0 > \alpha^*$ claim -- **correct** (uses $d_* - d_0 = \beta(N-1)^2(r-1) > 0$).

**No equations were accidentally modified.**

---

## Overall flow assessment

Both sections read naturally. The prose additions follow a consistent pattern: each Step begins with 1-2 sentences explaining *what* will be computed and *why*, then the algebra follows, then a brief interpretive wrap-up. This matches the Thomson (1999) prescription precisely. The additions do not feel bolted on; they create a rhythm of "orient-compute-interpret" that carries the reader through what would otherwise be a dense algebraic derivation.

The voice is appropriately first-person singular ("I now compute...", "I now derive..."), consistent with the rest of the paper ("I develop a formal model..."). The sentences are grammatically clean, the terminology is stable (no variation between "correction" and "adjustment" or similar), and cross-references are used effectively.

## Natural language ratio estimate

B.5a: ~55-60% natural language (generous prose in Steps 0 and 4, moderate in Steps 1-3, 5).
B.5: ~50-55% natural language (more compact, as befits a proof rather than a derivation).

Both are within or very close to the Thomson range (52-63.5%). B.5 is at the lower end, but proofs of this type (endpoint verification on branches) are inherently algebraic. The ratio is appropriate.

---

## Overall assessment

Both sections are well-written. The prose additions are accurate, helpful, concise, and stylistically consistent with the paper. They follow the Thomson prescription of interleaving natural language with algebra at roughly the right ratio. The only issues are minor: (1) a small redundancy between the opening paragraph of B.5 and its Step 1, and (2) a third repetition of the independence argument in the Alternative case of B.5 that could be replaced by a cross-reference. Neither issue is serious enough to downgrade from A.

---

## Specific fixes needed (if any)

### Fix 1 (minor -- B.5 Step 1 redundancy)

The opening paragraph of B.5 (line 1062) already says "Positivity therefore reduces to checking endpoints." Step 1 then says "this reduces a continuum of inequalities to a finite number of endpoint conditions." This is a mild redundancy.

**Old text** (Step 1 opening, line 1066):
> "The proof strategy is to decompose $D(\mu)$ into piecewise-affine components and verify positivity by checking endpoints on each branch. Because affine functions are determined by their boundary values, this reduces a continuum of inequalities to a finite number of endpoint conditions."

**Suggested replacement:**
> "The decomposition has three components, each affine in $\mu$. Because an affine function that is positive at both endpoints of an interval is positive throughout, it suffices to check a finite number of boundary values."

This eliminates the overlap with the opening paragraph and adds the specific fact (affine + positive endpoints => positive throughout) that the Step actually uses.

### Fix 2 (minor -- B.5 Alternative case independence repetition)

**Old text** (line 1101):
> "The decomposition $D = D_{\text{base}} + \mathbf{1}\{\mu < \mu_s^{R2}\}\cdot\delta_{R2} + \mathbf{1}\{\mu > \mu_s^{R1}\}\cdot\delta_{R1}$ remains valid because $\delta_{R2}$ and $\delta_{R1}$ affect independent components of the payoff: $\delta_{R2}$ operates through the R2 continuation value $V_W^{R2}(\mu)$ in the hegemon's proposal, while $\delta_{R1}$ operates through which R1 offer $H$ receives when $W$ proposes. Neither depends on the other."

**Suggested replacement:**
> "The additive decomposition remains valid because the two corrections affect independent components of $H$'s payoff (Step 1)."

This replaces the third statement of the independence argument with a back-reference, trusting the reader to recall the explanation from six paragraphs earlier.

### No other fixes needed.
