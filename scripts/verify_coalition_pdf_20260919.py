"""Compare every rendered page of two builds of the coalition manuscript.

This verifies visual identity with an inspected PDF, not the adequacy of its
layout or mathematics. The separate visual-review record supplies inspection.
Uses Poppler only; writes its report and optional temporary page renderings.
"""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def render(pdf, directory):
    directory.mkdir(parents=True, exist_ok=True)
    subprocess.run(["pdftoppm", "-r", "120", "-png", str(pdf),
                    str(directory / "page")], check=True, capture_output=True)
    pages = sorted(directory.glob("page-*.png"))
    if not pages:
        raise RuntimeError("No pages rendered")
    return pages


def extracted_text(pdf):
    return subprocess.run(["pdftotext", "-layout", str(pdf), "-"],
                          check=True, capture_output=True).stdout


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--inspected", type=Path, required=True)
    parser.add_argument("--final", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--render-dir", type=Path)
    args = parser.parse_args()
    directory = args.render_dir or Path(tempfile.mkdtemp(prefix="peio-pdf-comparison-"))
    old, new = [render(p.resolve(), directory / name) for p, name in
                [(args.inspected, "inspected"), (args.final, "final")]]
    rows = [{"page": i + 1, "inspected_png_sha256": sha(a),
             "final_png_sha256": sha(b), "identical": a.read_bytes() == b.read_bytes()}
            for i, (a, b) in enumerate(zip(old, new))]
    same_count = len(old) == len(new)
    old_text, new_text = extracted_text(args.inspected), extracted_text(args.final)
    identical = same_count and all(r["identical"] for r in rows) and old_text == new_text
    report = {
        "status": "PASS" if identical else "DIFFERENCES_REQUIRE_INSPECTION",
        "inspected_pdf": {"path": str(args.inspected.resolve()), "sha256": sha(args.inspected)},
        "final_pdf": {"path": str(args.final.resolve()), "sha256": sha(args.final)},
        "page_counts": {"inspected": len(old), "final": len(new)},
        "all_rendered_pages_identical": same_count and all(r["identical"] for r in rows),
        "layout_text_identical": old_text == new_text,
        "unresolved_double_question_marks": new_text.count(b"??"),
        "dpi": 120, "render_directory": str(directory.resolve()), "pages": rows,
        "limit": "Pixel identity carries forward a separate visual inspection; it does not create one or certify mathematical claims.",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({k: report[k] for k in ["status", "page_counts", "all_rendered_pages_identical",
                                            "layout_text_identical", "unresolved_double_question_marks"]}))
    if not identical:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
