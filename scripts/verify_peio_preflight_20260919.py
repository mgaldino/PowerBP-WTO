#!/usr/bin/env python3
"""Recheck the preserved candidate and reproduce its conditional R checks.

This is an integrity/reproduction check, not a proof or author adoption.
Historical outputs are read only. Re-execution occurs in a temporary directory.
Run from any directory with Python 3 and Rscript available.
"""
from pathlib import Path
import csv
import datetime as dt
import hashlib
import json
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "quality_reports/peio_2027_2026-09-19"
ARCH = ROOT / "quality_reports/architecture_2026-09-08"
SKILLS = Path("/Users/manoelgaldino/.codex/skills")


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(args, cwd=ROOT):
    p = subprocess.run(args, cwd=cwd, text=True, capture_output=True)
    return {"command": args, "cwd": str(cwd), "exit_code": p.returncode,
            "stdout": p.stdout, "stderr": p.stderr}


def main():
    OUT.mkdir(exist_ok=True)
    start = json.loads((OUT / "preflight.json").read_text())
    initial_mismatches = [f for f, h in start["files"].items()
                          if sha(ROOT / f) != h]
    manifest = json.loads((ARCH / "candidate_manifest.json").read_text())
    candidate_mismatches = [f for f, h in manifest["artifacts"].items()
                            if sha(ROOT / f) != h]
    contract = ARCH / "argument_contract/argument_contract.json"
    commands = [
        ["python3", str(SKILLS / "argument-fidelity-gate/scripts/validate_contract.py"),
         str(contract), "--artifact", str(ARCH / "architecture_note.Rmd")],
        ["python3", str(SKILLS / "adjudicate-review/scripts/validate_adjudication.py"),
         str(ARCH / "adjudication/adjudication_round1.json"), "--artifact",
         str(ARCH / "architecture_note.Rmd"), "--contract-file", str(contract)],
        ["python3", str(SKILLS / "solve-dynamic-games/scripts/check_game_dag.py"),
         str(ARCH / "game_dag.json")],
    ]
    validators = [run(args) for args in commands]
    with tempfile.TemporaryDirectory(prefix="pbp-peio-preflight-") as scratch:
        reproduction = run(["Rscript", "--vanilla",
                            str(ROOT / "scripts/verify_architecture_20260908.R")], scratch)
        generated = Path(scratch) / "quality_reports/architecture_2026-09-08/checks"
        target = OUT / "checks/architecture_reproduction"
        target.mkdir(parents=True, exist_ok=True)
        outputs = {}
        for old in sorted((ARCH / "checks").iterdir()):
            new = generated / old.name
            outputs[old.name] = {"original_sha256": sha(old),
                                 "reproduced_sha256": sha(new) if new.is_file() else None,
                                 "identical": new.is_file() and sha(old) == sha(new)}
            if new.is_file():
                shutil.copyfile(new, target / old.name)
        rows = list(csv.DictReader((target / "finite_checks.csv").open()))
    adj = json.loads((ARCH / "adjudication/adjudication_round1.json").read_text())
    review_hashes_match = all(sha(Path(r["path"])) == r["sha256"]
                             for r in adj["review_sources"])
    checks = {
        "initial_sources_unchanged": not initial_mismatches,
        "conditional_candidate_hashes_match": not candidate_mismatches,
        "review_hashes_match_adjudication": review_hashes_match,
        "validators_pass": all(c["exit_code"] == 0 for c in validators),
        "reproduction_exits_successfully": reproduction["exit_code"] == 0,
        "all_reproduced_checks_pass": bool(rows) and all(r["pass"] == "TRUE" for r in rows),
        "numerical_outputs_identical": all(v["identical"] for k, v in outputs.items()
                                            if k != "sessionInfo.txt"),
    }
    result = {"checked_at": dt.datetime.now().astimezone().isoformat(),
              "checks": checks, "initial_mismatches": initial_mismatches,
              "candidate_mismatches": candidate_mismatches,
              "candidate_artifact_count": len(manifest["artifacts"]),
              "validators": validators, "reproduction": reproduction,
              "outputs": outputs, "reproduced_check_count": len(rows),
              "reproduced_failure_count": sum(r["pass"] != "TRUE" for r in rows),
              "status": "PASS_MECHANICAL_ONLY" if all(checks.values()) else "FAIL",
              "boundary": "No proof certification, new architecture adoption, manuscript integration, or submission readiness follows from these checks."}
    (OUT / "verification.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({k: result[k] for k in ("status", "checks", "reproduced_check_count", "reproduced_failure_count")}, indent=2))
    return 0 if all(checks.values()) else 1


if __name__ == "__main__":
    raise SystemExit(main())
