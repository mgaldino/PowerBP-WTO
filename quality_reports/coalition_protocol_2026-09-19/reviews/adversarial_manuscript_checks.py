#!/usr/bin/env python3
"""Read-only checks of frozen preview inputs, references and retained assets.

Only this review's sibling JSON is written. Mathematical migration is reviewed
analytically in the accompanying report; these checks do not certify proofs or
the rendered appearance of the manuscript.
"""

from collections import Counter
from pathlib import Path
import difflib
import hashlib
import json
import re


ROOT = Path(__file__).resolve().parents[1]
REPO = ROOT.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    results = []

    def check(name, condition, detail=None):
        results.append({"name": name, "pass": bool(condition), "detail": detail})

    manifest_path = ROOT / "derivations/composition_manifest.json"
    manifest = json.loads(manifest_path.read_text())
    for group in ("inputs", "outputs"):
        for name, expected in manifest[group].items():
            check("composition_" + group, sha(ROOT / name) == expected, name)

    contracts = {
        "argument_contract/derivations_v2/argument_contract.json":
        "7db1a7a72dd12178e7f5b63ce45c94ae08576e0a6a22daa8dbbbd13aab25d4ca",
        "argument_contract/manuscript_candidate/argument_contract.json":
        "a1a39f8548cfdbe285a9bd5be7cee7f28d92156e8a411b91a74bd65099d3cebc",
    }
    for name, expected in contracts.items():
        path = ROOT / name
        check("final_contract_hash", sha(path) == expected, name)
        check("contract_gate", json.loads(path.read_text())["gate"]["status"] == "PASS", name)

    preview_path = ROOT / "derivations/combined_manuscript_preview.Rmd"
    original_path = ROOT / "snapshots/original/formal_model_v6.Rmd"
    text = preview_path.read_text()
    old_lines, new_lines = original_path.read_text().splitlines(), text.splitlines()
    opcodes = difflib.SequenceMatcher(a=old_lines, b=new_lines, autojunk=False).get_opcodes()
    stats = {
        "original_lines": len(old_lines), "preview_lines": len(new_lines),
        "unchanged_lines": sum(b-a for tag,a,b,c,d in opcodes if tag == "equal"),
        "changed_old_lines": sum(b-a for tag,a,b,c,d in opcodes if tag != "equal"),
        "changed_new_lines": sum(d-c for tag,a,b,c,d in opcodes if tag != "equal"),
        "change_blocks": sum(tag != "equal" for tag,a,b,c,d in opcodes),
    }
    abstract = text.split("abstract: |\n", 1)[1].split("\n---", 1)[0].strip()
    check("abstract_word_count", len(abstract.split()) == manifest["abstract_word_count_whitespace"],
          len(abstract.split()))

    bib_path = ROOT / "derivations/combined_references_preview.bib"
    bib = bib_path.read_text()
    bib_keys = re.findall(r"(?m)^@\w+\s*\{\s*([^,]+),", bib)
    # Punctuation may occur inside a citation key, but terminal prose periods
    # are not part of the key (for example @osborneRubinstein1990.).
    citations = re.findall(r"(?<![\w])@([A-Za-z](?:[A-Za-z0-9_:.-]*[A-Za-z0-9_])?)", text)
    check("unique_bib_keys", len(bib_keys) == len(set(bib_keys)))
    check("all_citation_keys_resolve", not (set(citations) - set(bib_keys)),
          sorted(set(citations) - set(bib_keys)))
    original_bib = (ROOT / "snapshots/original/references.bib").read_text()
    old_keys = re.findall(r"(?m)^@\w+\s*\{\s*([^,]+),", original_bib)
    check("only_new_bib_key", set(bib_keys) - set(old_keys) == {"evdokimov2023equality"})
    check("old_bib_text_preserved", bib.startswith(original_bib.rstrip()))

    labels = re.findall(r"\\label\{([^}]+)\}", text) + re.findall(r"\{#([^}]+)\}", text)
    refs = re.findall(r"\\ref\{([^}]+)\}", text)
    check("unique_labels", len(labels) == len(set(labels)),
          [name for name,n in Counter(labels).items() if n > 1])
    check("all_cross_references_resolve", not (set(refs) - set(labels)),
          sorted(set(refs) - set(labels)))

    pdfs = re.findall(r"\\includegraphics(?:\[[^\]]*\])?\{([^}]*)\}", text)
    assets = {}
    for name in pdfs:
        path = REPO / name
        check("figure_asset_exists", path.is_file(), name)
        assets[name] = sha(path) if path.is_file() else None
    prior_checks = json.loads((ROOT / "reviews/adversarial_checks_v1.json").read_text())
    retained_csvs = prior_checks["figure_payload_inputs"]
    for name, record in retained_csvs.items():
        check("retained_numerical_asset_hash", sha(REPO / name) == record["sha256"], name)

    output = {
        "review_scope": "Frozen manuscript migration consistency, mechanical auxiliary checks",
        "script_sha256": sha(Path(__file__)), "passed": sum(r["pass"] for r in results),
        "failed": sum(not r["pass"] for r in results),
        "preview_sha256": sha(preview_path), "bib_sha256": sha(bib_path),
        "composition_manifest_sha256": sha(manifest_path), "contract_hashes": contracts,
        "source_diff": stats, "abstract_word_count_whitespace": len(abstract.split()),
        "bibliography": {"entries": len(bib_keys), "citation_occurrences": len(citations),
                         "distinct_cited_keys": len(set(citations)),
                         "new_key_occurrences": citations.count("evdokimov2023equality")},
        "cross_references": {"labels": len(labels), "occurrences": len(refs)},
        "figure_pdf_hashes": assets, "retained_numerical_inputs": retained_csvs,
        "limitations": ["No executable patch was run or candidate file edited.",
                        "No PDF rendering or visual inspection was performed.",
                        "Unchanged v1 numerical checks were retained by verified hashes, not rerun.",
                        "Reference resolution does not validate every cited source or historical claim."],
        "checks": results,
    }
    Path(__file__).with_suffix(".json").write_text(json.dumps(output, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({k: output[k] for k in ("passed", "failed", "source_diff", "bibliography", "cross_references")}))
    raise SystemExit(1 if output["failed"] else 0)


if __name__ == "__main__":
    main()
