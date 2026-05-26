# Theorem 1 --- Proof Corrections Guide

**Date**: 2026-04-19
**Status**: IMPLEMENTED (2026-04-19)
**Priority**: Applied --- corrections are now in `formal_model.Rmd`
**Adversarial check**: `quality_reports/2026-04-19_adversarial-check-theorem1.md`

---

## Executive Summary

Theorem 1 ("When informational power substitutes for agenda power") is correct. Its proof contains three presentation issues: a false but unused display inequality, an ambiguous use of "unique," and an unjustified extension claim. An adversarial checker scored severity at 3/10. All fixes are cosmetic and can be done at any time before submission.

---

## Criticality

These are problems of **presentation**, not of **result**. The theorem statement is correct (modulo a trivial boundary fix at $p = 0$). The proof's logical chain --- slope comparison, divergence, IVT --- is intact. The issues are:

1. A dead line (a displayed inequality that is mathematically false but never used in the argument).
2. An ambiguous word ("unique") that admits a charitable reading but could confuse a rigorous referee.
3. An extension claim to $[\tau(C), \tau(A))$ that is neither justified nor needed.
4. A missing boundary condition at $p = 0$.

A referee who reads carefully would flag (1) and possibly (3). None of these affect the result. Priority is LOW.

---

## Corrections

### Correction 1: Boundary at $p = 0$ in the Theorem statement

**Classification**: MINOR

**What is wrong**: The theorem says "For $p < p^*$, the hegemon strictly prefers Package C." At $p = 0$, both concavified values equal zero, so strict preference fails.

**Why it is wrong**: $\operatorname{cav} v(0, C) = \operatorname{cav} v(0, A) = 0$. The prior $p = 0$ means no cooperation occurs under either package.

**Where**: Theorem statement, item (1) (line ~447 of `formal_model.Rmd`).

**Current text**:
```latex
\item For $p<p^*$, the hegemon strictly prefers Package C.
```

**Corrected text**:
```latex
\item For $0 < p<p^*$, the hegemon strictly prefers Package C.
```

---

### Correction 2: "unique $\bar{g}$" replaced by infimum definition

**Classification**: MINOR

**What is wrong**: Step 3 says "there exists a **unique** $\bar{g} \ge 0$ such that $S_C(g) > S_A(g)$ for all $g > \bar{g}$." The word "unique" is ambiguous. A convex function $f = S_C - S_A$ that diverges to $+\infty$ can have zero, one, or two zeros. If two zeros exist, the threshold $\bar{g}$ above which $f > 0$ is still well-defined (it is the larger zero), but calling it "unique" suggests a unique crossing, which is not guaranteed.

**Why it is wrong**: Convexity + divergence imply eventual positivity, not a unique zero. The threshold is unique when defined as an infimum; the word "unique" without this definition is sloppy.

**Where**: Step 3, second-to-last sentence (line ~494 of `formal_model.Rmd`).

**Current text**:
```latex
there exists a unique $\bar g \ge 0$ such that $S_C(g)>S_A(g)$ for all $g>\bar g$.
```

**Corrected text**:
```latex
the set $\{g_0 \ge 0 : S_C(g) > S_A(g) \text{ for all } g > g_0\}$ is non-empty; define $\bar g$ as its infimum.
```

---

### Correction 3: Remove the false display in Step 3

**Classification**: MAJOR (in presentation; not load-bearing)

**What is wrong**: Step 3 opens with the claim that for any $\mu \ge \tau(C)$:
$$\frac{g + \mathbb{E}[V_H(C,\mu)]}{\mu} \ge \frac{g + \mathbb{E}[V_H(C,\tau(C))]}{\tau(C)}.$$
This is mathematically false. There is no reason why the ratio $[g + \mathbb{E}[V_H(C,\mu)]]/\mu$ should be non-decreasing in $\mu$ for all $\mu$. For large $\mu$, the numerator grows slower than $\mu$ itself.

**Why it is wrong**: Fix $g > 0$. As $\mu$ increases above $\tau(C)$, the denominator grows linearly while $\mathbb{E}[V_H(C,\mu)]$ grows at most linearly (and has a jump at $\mu_s$). The ratio can decrease. Concretely, at $\mu = \tau(A)$, Lemma 5 (pointwise dominance) shows that $\mathbb{E}[V_H(C,\tau(A))] < V_H(A, \tau(A))$, which makes the claimed monotonicity fail for large enough $\mu$.

**Why it does not matter**: The proof never uses this inequality. The very next line evaluates at $\mu = \tau(C)$ and obtains $S_C(g) \ge [g + \mathbb{E}[V_H(C,\tau(C))]]/\tau(C)$, which follows directly from the definition of $S_C$ as a supremum (since $\mu = \tau(C)$ is a feasible point). The argument proceeds from this feasibility bound alone.

**Where**: Step 3, first two lines after the header (lines ~482--485 of `formal_model.Rmd`).

**Fix**: Delete the false display and replace the opening with the direct feasibility bound. See the complete corrected Step 3 below.

---

### Correction 4: Remove the extension to $[\tau(C), \tau(A))$

**Classification**: MINOR--MAJOR

**What is wrong**: The last two sentences of Step 3 claim: "For priors in $[\tau(C), \tau(A))$, Package C yields $v(p,C) = g + \mathbb{E}[V_H(C,p)] > 0$ while $\operatorname{cav} v(p,A) = S_A(g) \cdot p$; for $g > \bar{g}$ the same slope comparison implies $\operatorname{cav} v(p,C) \ge v(p,C) > \operatorname{cav} v(p,A)$."

**Why it is wrong**: The claim that $v(p, C) > S_A(g) \cdot p$ on $[\tau(C), \tau(A))$ is not justified and in fact fails near $p = \tau(A)$ (where pointwise dominance of Package A kicks in). The argument conflates $\operatorname{cav} v(p,C) \ge v(p,C)$ (which is true by definition of concavification) with $v(p,C) > \operatorname{cav} v(p,A)$ (which requires a separate argument that is not provided).

**Why it does not matter**: The theorem does not need dominance on the entire interval $(0, \tau(A))$. It only needs:
- $\Delta(p) > 0$ for some $p > 0$ (established on $(0, \tau(C))$ by the slope comparison).
- $\Delta(p) < 0$ for some $p$ (established for $p > \tau(A)$ by Step 4).
- Continuity of $\Delta$ (concave functions on an open interval are continuous).

The IVT then gives a crossover $p^*$. The crossover may lie anywhere in $(0, \tau(A))$, possibly inside $[\tau(C), \tau(A))$.

**Where**: Step 3, last two sentences (line ~498 of `formal_model.Rmd`).

**Fix**: Delete these sentences entirely. See the complete corrected Step 3 below.

---

## Complete Corrected Text

### (a) Theorem statement (replaces lines ~443--451)

```latex
\begin{theorem}[When informational power substitutes for agenda power]\label{thm:main}
For $N=3$, there exists a threshold $\bar g(r,\beta,c) \ge 0$ such that, for $g>\bar g(r,\beta,c)$, there is at least one crossover prior $p^* \in (0,\tau(A))$ with the following properties:

\begin{enumerate}
\item For $0 < p<p^*$, the hegemon strictly prefers Package C.
\item For $p>\tau(A)$, the hegemon strictly prefers Package A.
\item The crossover depends on $(r,\beta,c,g)$ through both the entry threshold and the screening cutoff $\mu_s$.
\end{enumerate}
\end{theorem}
```

Changes from current text:
- Added "at least one" before "crossover prior" (does not claim uniqueness of $p^*$).
- Changed "For $p < p^*$" to "For $0 < p < p^*$" in item (1).

---

### (b) Step 3 (replaces lines ~480--498)

```latex
\medskip
\noindent\textit{Step 3: For large $g$, the consensus slope dominates.}
Since $\mu=\tau(C)$ is feasible in the supremum that defines $S_C$,
\[
S_C(g)\ge \frac{g+\mathbb{E}[V_H(C,\tau(C))]}{\tau(C)}=\frac{g}{\tau(C)}+\frac{\mathbb{E}[V_H(C,\tau(C))]}{\tau(C)}.
\]
Therefore
\[
S_C(g)-S_A(g)\ge g\left(\frac{1}{\tau(C)}-\frac{1}{\tau(A)}\right)+\left[\frac{\mathbb{E}[V_H(C,\tau(C))]}{\tau(C)}-\frac{V_e(\tau(A))\frac{6-\beta}{6}}{\tau(A)}\right].
\]
Since $\tau(C)<\tau(A)$ (Lemma~\ref{lem:entry}), the coefficient of $g$ is strictly positive. Hence $S_C(g)-S_A(g)\to +\infty$ as $g\to\infty$. Since $S_C-S_A$ is convex (convex minus affine) and diverges, the set $\{g_0 \ge 0 : S_C(g)>S_A(g) \text{ for all } g>g_0\}$ is non-empty; define $\bar g$ as its infimum. For $g>\bar g$ and $p \in (0,\tau(C))$:
\[
\operatorname{cav} v(p,C)\ge S_C(g)\cdot p > S_A(g)\cdot p = \operatorname{cav} v(p,A).
\]
This establishes $\Delta(p)>0$ for all $p \in (0,\tau(C))$ when $g>\bar g$.
```

Changes from current text:
- Removed the false display "$[g + \mathbb{E}[V_H(C,\mu)]]/\mu \ge [g + \mathbb{E}[V_H(C,\tau(C))]]/\tau(C)$" for "any $\mu \ge \tau(C)$."
- Replaced "Evaluating at $\mu = \tau(C)$" with direct feasibility bound: "$\mu = \tau(C)$ is feasible in the supremum."
- Replaced "there exists a unique $\bar{g}$" with the infimum definition.
- Removed the extension to $[\tau(C), \tau(A))$ (last two sentences of the original).
- Concludes with the precise claim: $\Delta(p) > 0$ on $(0, \tau(C))$.

---

### (c) Step 5 (replaces lines ~518--526)

```latex
\medskip
\noindent\textit{Step 5: Existence of the crossover.}
Define $\Delta(p)\equiv \operatorname{cav} v(p,C)-\operatorname{cav} v(p,A)$. Steps 3 and 4 establish:
\begin{itemize}
\item $\Delta(p)>0$ for all $p \in (0,\tau(C))$ when $g>\bar g$,
\item $\Delta(p)<0$ for all $p>\tau(A)$.
\end{itemize}
Since both concavified value functions are concave (and hence continuous on $(0,1)$), $\Delta$ is continuous. By the intermediate value theorem, $\Delta$ has at least one zero in $(\tau(C),\tau(A))$. Define
\[
p^*\equiv \inf\{p>0:\Delta(p)\le 0\}.
\]
Then $p^*\ge \tau(C)>0$ (since $\Delta>0$ on $(0,\tau(C))$) and $p^*\le \tau(A)$ (since $\Delta<0$ for $p>\tau(A)$), so $p^* \in (0,\tau(A))$. By continuity, $\Delta(p^*)=0$ and $\Delta(p)>0$ for all $p \in (0,p^*)$. This proves parts~(1) and~(3).
```

Changes from current text:
- Made the domain of positivity explicit: "for all $p \in (0, \tau(C))$" instead of "for $p$ sufficiently small."
- Justified continuity via concavity (concave functions on an open interval are continuous).
- Defined $p^*$ explicitly as the infimum of the set where $\Delta \le 0$.
- Showed $p^* \in (0, \tau(A))$ and that $\Delta > 0$ on $(0, p^*)$ by the infimum construction.
- Does not claim uniqueness of $p^*$ as a zero of $\Delta$.

---

### (d) Remark 3 (Explicit bound for $\bar{g}$)

No changes needed. The remark already says "conservative bound" and correctly hedges that $\bar{g}$ provides a sufficient condition. The infimum definition of $\bar{g}$ in the corrected Step 3 is compatible with the explicit formula in the remark (which computes an upper bound on $\bar{g}$ under a specific tangent-point assumption).

---

## Implementation Instructions

### Files to edit

Only one file: `formal_model.Rmd`.

### Order of edits

1. **Theorem statement** (lines ~443--451): Apply correction (a).
2. **Step 3** (lines ~480--498): Replace with correction (b).
3. **Step 5** (lines ~518--526): Replace with correction (c).

### What NOT to change

- Lemmas 1--5 (all verified correct by the adversarial checker).
- Steps 1 and 2 of the proof (verified correct).
- Step 4 of the proof (verified correct; logically independent of Steps 1--3).
- Remark 2 (Dependence on $r$ and $\beta$) --- unaffected.
- Remark 3 (Explicit bound for $\bar{g}$) --- already properly hedged.
- Examples 1 and 2 (numerical illustrations) --- unaffected.
- The decomposition remark (Remark 4) --- unaffected.

### Post-edit verification

1. Compile `formal_model.Rmd` to PDF and confirm no LaTeX errors.
2. Verify that the theorem statement, Step 3, and Step 5 render correctly.
3. Confirm that cross-references (`\ref{thm:main}`, `\ref{lem:entry}`) still resolve.

---

## What Was NOT Corrected (and Why)

The adversarial checker (`2026-04-19_adversarial-check-theorem1.md`) verified the following and found no issues:

- **Step 1** (concavification under Package A): Correct.
- **Step 2** (concavification under Package C): Correct. $S_C$ as a supremum is well-defined.
- **Step 4** (Package A dominates for $p > \tau(A)$): Correct. Uses Lemma 5 (pointwise dominance) and concavification upper bound. Logically independent of Steps 1--3.
- **Lemma 1** (bargaining under Package A): Correct.
- **Lemma 2** (bargaining under Package C): Correct.
- **Lemma 3** (screening cutoff and jump): Correct.
- **Lemma 4** (entry thresholds): Correct.
- **Lemma 5** (pointwise dominance of Package A): Correct. Algebra verified under Assumption (P).
- **Convexity of $S_C$ in $g$**: Correct (supremum of affine functions).
- **Continuity of $\Delta$**: Correct (concave functions on an open interval are continuous).
- **Examples 1 and 2**: Numerical values confirmed.

No further corrections are necessary.
