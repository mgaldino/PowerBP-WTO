#!/usr/bin/env python3
"""Independent finite checks for v2 repairs; writes only this review's JSON.

No grid certifies the Borel-measure lemma. Its validation is analytical in the
accompanying review. Candidate scripts/outputs and all candidate notes are read
only, including the exact replay into a temporary output file.
"""

from contextlib import redirect_stdout
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import io
import json
import tempfile


ROOT = Path(__file__).resolve().parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    manifest_path = ROOT / "reviews/derivation_candidate_v2.json"
    manifest = json.loads(manifest_path.read_text())
    checks = []

    def check(name, condition, context=None):
        checks.append({"name": name, "pass": bool(condition), "context": context})

    for name, expected in manifest["files"].items():
        check("manifest_hash", sha(ROOT / name) == expected, name)
    check("bundle_hash", sha(ROOT / manifest["bundle"]["path"]) ==
          manifest["bundle"]["sha256"])

    algebra_cases = []
    for m in (3, 4, 5, 8):
        k = (m + 1) // 2
        for beta in (Q(1, 2), Q(9, 10), Q(999, 1000)):
            for o in (Q(1, 1000 * m), Q(1, 2 * m), Q(1, m)):
                # Compute via primitive pass and reject values, separately from
                # the proposed factorization/expansion.
                pass_value = 1 - k * beta * (1 - beta * o) / m
                reject_value = beta**2 * o
                difference = pass_value - reject_value
                expansion = 1 - k * beta / m - beta**2 * o * (1 - Q(k, m))
                margin = beta * (1 - Q(k, m)) * (1 - beta * o)
                old_product = (1 - beta**2 * o) * (1 - k * beta / m)
                context = {"m": m, "beta": str(beta), "o": str(o)}
                check("F001_correct_expansion", difference == expansion, context)
                check("F001_margin_identity", difference - (1 - beta) == margin, context)
                check("F001_positive_margin", margin > 0, context)
                check("F001_pass_strictly_dominates", pass_value > reject_value, context)
                check("F001_old_product_error", difference - old_product ==
                      Q(k, m) * beta**2 * o * (1 - beta), context)
                algebra_cases.append({**context, "difference": str(difference),
                                      "margin": str(margin)})

    # Endpoint witness: probability-one argmax need not contain the entire
    # topological support. Exact sample values verify the arithmetic only;
    # the uniform-law/support argument is proved separately in the review.
    m, beta, low, high = 4, Q(9, 10), Q(1, 10), Q(9, 10)
    cutoff = beta * (1 - beta * low) / m
    high_reject = beta**2 * high
    endpoint_witnesses = []
    for institution, count in (("M", 2), ("U", 4)):
        a0 = 1 - count * cutoff
        low_reject = beta**2 * low
        check("F003_high_strictly_prefers_reject", high_reject > a0, institution)
        check("F003_low_prefers_pass", a0 > low_reject, institution)
        check("F003_boundary_budget", a0 + count * cutoff == 1, institution)
        for denominator in (3, 4, 8, 16, 128):
            epsilon = cutoff / denominator
            reduced = cutoff - epsilon
            check("F003_positive_reduced_share", 0 < reduced < cutoff,
                  {"institution": institution, "epsilon": str(epsilon)})
            check("F003_deviant_budget", a0 + epsilon + reduced +
                  (count - 1) * cutoff == 1, institution)
        endpoint_witnesses.append({"institution": institution, "weak_invitees": count,
                                  "r0": str(cutoff), "a0": str(a0),
                                  "high_rejection": str(high_reject),
                                  "law": "Uniform epsilon on (0,r0/2); limit epsilon=0 passes"})

    # Exact replay of the implementer's F001 script without writing its output.
    candidate_script = ROOT / "derivations/v2/repaired_algebra_checks.py"
    source = candidate_script.read_text()
    marker = '    output = path.with_suffix(".json")'
    check("replay_output_redirect_unique", source.count(marker) == 1)
    before = {name: sha(ROOT / name) for name in manifest["files"]}
    with tempfile.TemporaryDirectory(prefix="coalition-adversarial-v2-", dir="/private/tmp") as td:
        temporary_output = Path(td) / "candidate_replay.json"
        redirected = source.replace(marker, "    output = Path(" + repr(str(temporary_output)) + ")")
        with redirect_stdout(io.StringIO()):
            try:
                exec(compile(redirected, str(candidate_script), "exec"),
                     {"__name__": "__main__", "__file__": str(candidate_script)})
            except SystemExit as exc:
                check("candidate_replay_exit", exc.code == 0, exc.code)
        frozen_output = ROOT / "derivations/v2/repaired_algebra_checks.json"
        check("candidate_replay_byte_identity", temporary_output.read_bytes() == frozen_output.read_bytes())
        replay = json.loads(temporary_output.read_text())
    after = {name: sha(ROOT / name) for name in manifest["files"]}
    check("candidate_files_unchanged", before == after)

    result = {
        "review": "coalition-derivations-v2 independent adversarial finite checks",
        "script_sha256": sha(Path(__file__)),
        "manifest_sha256": sha(manifest_path),
        "bundle_sha256": manifest["bundle"]["sha256"],
        "passed": sum(c["pass"] for c in checks),
        "failed": sum(not c["pass"] for c in checks),
        "independent_algebra_cases": len(algebra_cases),
        "candidate_replay": {k: replay[k] for k in ("parameter_cases", "passed", "failed")},
        "retained_v1_checks": {
            "script_sha256": sha(ROOT / "reviews/adversarial_checks_v1.py"),
            "output_sha256": sha(ROOT / "reviews/adversarial_checks_v1.json"),
            "executed_again": False,
            "reason": "Relevant baseline interfaces and shared 409-check inputs are byte-identical."
        },
        "limits": [
            "Finite exact arithmetic is auxiliary to the analytical proof for all parameters.",
            "No numerical claim validates the measure differentiation theorem, US-1, or all Borel laws.",
            "Endpoint sampled proposals accompany an analytical uniform-law counterexample.",
            "No candidate or manuscript file was modified; no PDF was rendered."
        ],
        "algebra_cases": algebra_cases,
        "endpoint_witnesses": endpoint_witnesses,
        "checks": checks,
    }
    Path(__file__).with_suffix(".json").write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({k: result[k] for k in
                      ("passed", "failed", "independent_algebra_cases", "candidate_replay")}))
    raise SystemExit(1 if result["failed"] else 0)


if __name__ == "__main__":
    main()
