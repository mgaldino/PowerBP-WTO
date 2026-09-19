"""Pure B.8 and E.3 repairs for adjudicated F-002/F-003; no file I/O.

The proof is documented in v2/unanimity_support_lemma.md. This prepares a
candidate for independent review; it neither applies nor certifies migration.
F-001 concerns the external agenda derivation and has no replacement here.
F-003 clarifies probability-one concentration at E.3 endpoints, as already
required by the v1 contract QI-05; it adds no support-containment refinement.
"""


SUPPORT_LEMMA = r"""\emph{Lemma (the high-price proposal at support points).} If
\(\mu^{\mathrm{off}}>p^*\), then \(V=z_H\) and
\(\sigma_\ell=\sigma_h=\delta_{x^h}\), even if \(x^h\) is initially
a possible zero-mass support point.

To prove the lemma, first note that \(d\leq V\leq z_H\): the high type
can force rejection for \(d\), every passing proposal leaves at most
\(z_H\), and every rejection pays at most \(d<z_H\). The local Bayes
posterior equals the Radon--Nikodym derivative
\(d(p\sigma_h)/d\bar\sigma\), \(\bar\sigma\)-almost everywhere.
Indeed, the differentiation theorem for finite Borel measures on the
Euclidean simplex applies to the same relative balls as the maintained
local likelihood ratio. Consequently, for every Borel set \(E\),
\[
p\sigma_h(E)=\int_E\mu(x)\,\bar\sigma(dx).
\]

Suppose \(V<z_H\). If \(x^h\) is unsupported, its posterior is
\(\mu^{\mathrm{off}}>p^*\), so it passes for \(z_H>V\), a profitable
deviation. If \(x^h\) belongs to the support, continuity gives a relative
ball \(B_{\mathcal X}(x^h,\varepsilon_0)\) on which \(x_H>V\).
The zero-posterior subset of this ball has no high-type mass by the
Bayes identity. It has no low-type mass either: passage would give more
than \(V\), whereas rejection would give \(\beta^2\ell<d\leq V\),
contrary to equality with the type's value almost surely. Thus
\(\mu>p^*\), \(\bar\sigma\)-almost everywhere in every smaller ball.
Each such ball has positive mass because \(x^h\) is supported, and
\[
\frac{p\sigma_h(B_{\mathcal X}(x^h,\varepsilon))}
     {\bar\sigma(B_{\mathcal X}(x^h,\varepsilon))}
=\frac{\int_{B_{\mathcal X}(x^h,\varepsilon)}\mu\,d\bar\sigma}
       {\bar\sigma(B_{\mathcal X}(x^h,\varepsilon))}
>p^*,\qquad 0<\varepsilon\leq\varepsilon_0.
\]
The local limit therefore gives \(\mu(x^h)\geq p^*\). Since
\(p^*>0\) and admissibility excludes \(p^*\) itself, this means
\(\mu(x^h)>p^*\). The proposal then passes for \(z_H>V\), contradicting
the pointwise deviation condition at that support point. Hence \(V=z_H\).
Rejection gives strictly less, and feasibility makes \(x^h\) the only
passing proposal with \(H\)'s share \(z_H\); both laws must therefore
concentrate at \(x^h\). This proves the lemma.

"""


def _once(text: str, old: str, new: str) -> str:
    count = text.count(old)
    if count != 1:
        raise ValueError(f"Expected one repair anchor, found {count}: {old[:90]!r}")
    return text.replace(old, new, 1)


def migrate_proof_repairs(text: str) -> str:
    """Return only the F-002 B.8 and F-003 E.3 repairs.

    This function accepts the original source or coordinated patches that
    preserve the original proof anchors. Reapplication is deliberately rejected.
    """
    if not isinstance(text, str):
        raise TypeError("text must be str")
    start = "## B.8 Proof of the private-unanimity agenda correspondence {-}"
    end = "## B.9 Proof of the exact and economic representations {-}"
    if text.count(start) != 1 or text.count(end) != 1:
        raise ValueError("B.8 and B.9 boundaries must be unique")
    lo, hi = text.index(start), text.index(end)
    if hi <= lo:
        raise ValueError("B.8 must precede B.9")
    block = text[lo:hi]
    insertion = "Next let\n"
    block = _once(block, insertion, SUPPORT_LEMMA + insertion)
    block = _once(block, r"""An off-support high
posterior would permit the deviation \(x^h\), which yields
\(z_H>z_L\); hence \(\mu^{\mathrm{off}}=0\).""", r"""If
\(\mu^{\mathrm{off}}>p^*\), the preceding lemma gives
\(V=z_H>z_L\), contradicting this bound even when \(x^h\) is a
zero-mass support point. Admissibility therefore forces
\(\mu^{\mathrm{off}}=0\).""")
    block = _once(block, r"""If \(\mu^{\mathrm{off}}>p^*\), the off-support proposal \(x^h\) guarantees
\(z_H\). Feasibility also bounds the common payoff by \(z_H\); hence
\(V=z_H\). The only passing proposal that leaves this share is \(x^h\), so
both proposal laws are \(\delta_{x^h}\).""", r"""If \(\mu^{\mathrm{off}}>p^*\), the lemma gives \(V=z_H\) and
\(\sigma_\ell=\sigma_h=\delta_{x^h}\), covering supported and unsupported
\(x^h\) alike.""")
    text = text[:lo] + block + text[hi:]
    start = "## E.3 Complete private-unanimity correspondence {-}"
    end = "## E.4 Exact institutional comparison at a fixed specification {-}"
    if text.count(start) != 1 or text.count(end) != 1:
        raise ValueError("E.3 and E.4 boundaries must be unique")
    lo, hi = text.index(start), text.index(end)
    if hi <= lo:
        raise ValueError("E.3 must precede E.4")
    block = text[lo:hi]
    block = _once(block, "and the counterfactual high-type law is",
                  "and the counterfactual high-type law satisfies")
    block = _once(block, r"\delta_{x^\ell},&v_U^A(\ell)>\beta^2h,",
                  r"\sigma_h=\delta_{x^\ell},&v_U^A(\ell)>\beta^2h,")
    block = _once(block,
                  r"\text{any Borel law supported on }\{x^\ell\}\cup\mathcal R_L,",
                  r"\sigma_h(\{x^\ell\}\cup\mathcal R_L)=1,")
    block = _once(block,
                  r"\text{any Borel law supported on }\mathcal R_L,",
                  r"\sigma_h(\mathcal R_L)=1,")
    block = _once(block, r"""\mathcal R_L=\{x\in\mathcal X:\min_jx_j<r_U(\ell)\}.
\]
The linked payoff is""", r"""\mathcal R_L=\{x\in\mathcal X:\min_jx_j<r_U(\ell)\}.
\]
Any Borel law satisfying the indicated probability-one condition is allowed.
At a zero-mass support point, the pointwise condition is absence of a
profitable deviation. Equality with the type's equilibrium value is
required only \(\sigma_o\)-almost surely; the topological support need
not be contained in the indicated best-response set.
The linked payoff is""")
    return text[:lo] + block + text[hi:]
