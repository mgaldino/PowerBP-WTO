"""Check source references/resources and resolve citations with Pandoc.

These are source-integrity checks; they do not certify the model or PDF layout.
"""

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import subprocess


ROOT = Path(__file__).resolve().parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def pandoc(source, source_format, destination):
    return json.loads(subprocess.run(
        ["pandoc", "-f", source_format, "-t", destination],
        input=source, text=True, encoding="utf-8", capture_output=True, check=True,
    ).stdout)


def citation_ids(node):
    result = []
    if isinstance(node, dict):
        if node.get("t") == "Cite":
            result.extend(c["citationId"] for c in node["c"][0])
        for value in node.values():
            result.extend(citation_ids(value))
    elif isinstance(node, list):
        for value in node:
            result.extend(citation_ids(value))
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", type=Path, default=ROOT / "formal_model_v6.Rmd")
    parser.add_argument("--bib", type=Path, default=ROOT / "references.bib")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    text = args.source.read_text()
    bibliography = pandoc(args.bib.read_text(), "bibtex", "csljson")
    citations = citation_ids(pandoc(text, "markdown", "json"))
    keys = [entry["id"] for entry in bibliography]
    labels = [a or b for a, b in re.findall(r"\\label\{([^}]+)\}|\{#([^}]+)\}", text)]
    references = re.findall(r"\\(?:eqref|ref)\{([^}]+)\}", text)
    figures = re.findall(r"\\includegraphics(?:\[[^]]*\])?\{([^}]+)\}", text)
    abstract = text.split("abstract: |\n", 1)[1].split("\n---", 1)[0].strip()
    duplicate = lambda values: sorted(x for x, count in Counter(values).items() if count > 1)
    problems = {
        "duplicate_labels": duplicate(labels),
        "undefined_references": sorted(set(references) - set(labels)),
        "duplicate_bibliographic_keys": duplicate(keys),
        "unresolved_citations": sorted(set(citations) - set(keys)),
        "missing_figures": [p for p in figures if not (ROOT / p).is_file()],
    }
    environments_match = Counter(re.findall(r"\\begin\{([^}]+)\}", text)) == Counter(
        re.findall(r"\\end\{([^}]+)\}", text))
    # Exclude optional spacing after a LaTeX row break, e.g. \\[3pt].
    math_count = lambda delimiter: len(re.findall(r"(?<!\\)" + re.escape(delimiter), text))
    math_delimiters_match = all(math_count(a) == math_count(b)
                                for a, b in [(r"\(", r"\)"), (r"\[", r"\]")])
    success = not any(problems.values()) and environments_match and math_delimiters_match and len(abstract.split()) <= 250
    report = {
        "status": "PASS" if success else "FAIL",
        "source": {"path": str(args.source.resolve()), "sha256": sha(args.source)},
        "bibliography": {"path": str(args.bib.resolve()), "sha256": sha(args.bib), "entries": len(keys)},
        "counts": {"labels": len(labels), "references": len(references),
                   "citation_occurrences": len(citations), "distinct_cited_keys": len(set(citations)),
                   "included_figures": len(figures), "abstract_words_whitespace": len(abstract.split())},
        "problems": problems,
        "latex_environments_balanced": environments_match,
        "math_delimiters_balanced": math_delimiters_match,
        "figure_sha256": {p: sha(ROOT / p) for p in figures if (ROOT / p).is_file()},
        "limits": "Source integrity only; not mathematical review, factual validation of all references, or visual PDF inspection.",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"status": report["status"], "counts": report["counts"], "problems": problems}, indent=2))
    if not success:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
