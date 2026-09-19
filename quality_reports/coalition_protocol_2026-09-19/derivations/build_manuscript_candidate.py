"""Reproduce the manuscript candidate without writing canonical files.

Inputs: preserved original Rmd/BibTeX, three pure patches, and the verified
Evdokimov entry. Additional adjudicated proof patches can be registered below.
Run from any directory; outputs remain in this derivations directory.
"""

from pathlib import Path
import difflib
import hashlib
import json


HERE = Path(__file__).resolve().parent
PACKAGE = HERE.parent
ORIGINAL = PACKAGE / "snapshots" / "original"
ORIGINAL_SHA = "6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_patch(name):
    path = HERE / f"{name}_manuscript_patch.py"
    namespace = {"__name__": "candidate_patch", "__file__": str(path)}
    exec(compile(path.read_text(), str(path), "exec"), namespace)
    return namespace[f"migrate_{name}"]


def main():
    source = ORIGINAL / "formal_model_v6.Rmd"
    assert digest(source) == ORIGINAL_SHA
    original = source.read_text()
    baseline, agenda, framing = [load_patch(n) for n in ("baseline", "agenda", "framing")]
    assert agenda(baseline(original)) == baseline(agenda(original))
    candidate = framing(agenda(baseline(original)))
    proof_patch = HERE / "proof_repairs_manuscript_patch.py"
    if proof_patch.exists():
        candidate = load_patch("proof_repairs")(candidate)
    output = HERE / "combined_manuscript_preview.Rmd"
    output.write_text(candidate)
    (HERE / "combined_manuscript_preview.diff").write_text("".join(
        difflib.unified_diff(original.splitlines(True), candidate.splitlines(True),
                             fromfile="original/formal_model_v6.Rmd",
                             tofile=output.name)))
    bibliography = (ORIGINAL / "references.bib").read_text()
    assert "@article{evdokimov2023equality" not in bibliography
    bibliography += "\n" + (HERE / "evdokimov_entry.bib").read_text()
    bib_output = HERE / "combined_references_preview.bib"
    bib_output.write_text(bibliography)
    inputs = [source, ORIGINAL / "references.bib", HERE / "evdokimov_entry.bib"]
    inputs += [HERE / f"{n}_manuscript_patch.py" for n in ("baseline", "agenda", "framing")]
    if proof_patch.exists():
        inputs.append(proof_patch)
    abstract = candidate.split("abstract: |\n", 1)[1].split("\n---", 1)[0].strip()
    manifest = {
        "status": "CANDIDATE_ONLY_NOT_CANONICAL",
        "inputs": {str(p.relative_to(PACKAGE)): digest(p) for p in inputs},
        "outputs": {str(p.relative_to(PACKAGE)): digest(p) for p in (output, bib_output)},
        "abstract_word_count_whitespace": len(abstract.split()),
        "canonical_files_modified": False,
    }
    (HERE / "composition_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()
