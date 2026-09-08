#!/usr/bin/env python3
"""Validate the review package and preserve the pre-existing checkout.

Run from the repository root after verification and rendering. This performs
identity, finite-output, and PDF text/bounds checks; it is not a proof checker.
"""
from pathlib import Path
import csv
import datetime as dt
import hashlib
import json
import subprocess
import xml.etree.ElementTree as ET


ROOT = Path.cwd()
BASE = ROOT / "quality_reports/architecture_2026-09-08"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


preflight = json.loads((BASE / "sources/preflight.json").read_text())
changed = [p for p, digest in preflight["tracked_sha256"].items()
           if not (ROOT / p).is_file() or sha(ROOT / p) != digest]
candidate = json.loads((BASE / "candidate_manifest.json").read_text())
mismatches = [p for p, digest in candidate["artifacts"].items()
              if not (ROOT / p).is_file() or sha(ROOT / p) != digest]
with (BASE / "checks/finite_checks.csv").open() as stream:
    rows = list(csv.DictReader(stream))
failures = [r["id"] for r in rows if r["pass"] != "TRUE"]
duplicate_ids = len(rows) - len({r["id"] for r in rows})
pdf = BASE / "architecture_note.pdf"
pdftext = subprocess.check_output(["pdftotext", "-layout", str(pdf), "-"]).decode()
bbox = subprocess.check_output(["pdftotext", "-bbox", str(pdf), "-"]).decode()
doc = ET.fromstring(bbox)
pages = doc.findall(".//{*}page")
outside = []
for number, page in enumerate(pages, 1):
    width, height = float(page.attrib["width"]), float(page.attrib["height"])
    for word in page.findall("{*}word"):
        b = {k: float(word.attrib[k]) for k in ("xMin", "xMax", "yMin", "yMax")}
        if b["xMin"] < 0 or b["xMax"] > width + 1 or b["yMin"] < 0 or b["yMax"] > height + 1:
            outside.append({"page": number, "word": word.text, "box": b})
checks = {
    "preexisting_tracked_files_unchanged": not changed,
    "candidate_hashes_match": not mismatches,
    "finite_checks_pass": bool(rows) and not failures and duplicate_ids == 0,
    "pdf_no_undefined_references_or_replacement_glyphs": "??" not in pdftext and "\ufffd" not in pdftext,
    "pdf_has_four_numbered_tables": all(f"Tabela {i}:" in pdftext for i in range(1, 5)),
    "pdf_words_within_page": not outside,
}
record = {
    "checked_at": dt.datetime.now().astimezone().isoformat(),
    "checks": checks,
    "tracked_files_checked": len(preflight["tracked_sha256"]),
    "changed_preexisting_files": changed,
    "candidate_mismatches": mismatches,
    "finite_check_count": len(rows),
    "finite_failures": failures,
    "duplicate_check_ids": duplicate_ids,
    "pdf_pages": len(pages),
    "pdf_words_outside_page": outside,
    "boundary": "These are mechanical checks, not a mathematical review, a new empirical result, or author adoption.",
    "overall": "PASS" if all(checks.values()) else "FAIL",
}
(BASE / "delivery_checks.json").write_text(json.dumps(record, ensure_ascii=False, indent=2) + "\n")
print(json.dumps(record, ensure_ascii=False, indent=2))
raise SystemExit(0 if all(checks.values()) else 1)
