#!/usr/bin/env python3
"""Run the official schema validator on the records and save every result."""
import hashlib
import json
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path('/private/tmp/pbp-architecture-clarification-2026-09-05')
OUT = ROOT / 'adjudication'
REPO = Path('/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion')
VALIDATOR = Path('/Users/manoelgaldino/.codex/skills/adjudicate-review/scripts/validate_adjudication.py')
jobs = [
    (OUT / 'adjudication_round1_global.json', REPO / 'AGENTS.md'),
    (OUT / 'adjudication_round1_agents_only.json', REPO / 'AGENTS.md'),
    (OUT / 'adjudication_readme_local.json', OUT / 'README.candidate_before_local_fix.md'),
]
def run(job):
    record, artifact = job
    command = [sys.executable, str(VALIDATOR), str(record), '--artifact', str(artifact)]
    p = subprocess.run(command, text=True, capture_output=True)
    return {'record': str(record), 'artifact': str(artifact), 'command': command,
            'returncode': p.returncode, 'stdout': p.stdout, 'stderr': p.stderr}
with ThreadPoolExecutor(max_workers=3) as pool:
    results = list(pool.map(run, jobs))
(OUT / 'validation.json').write_text(json.dumps(results, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
log = '\n\n'.join('COMMAND: ' + ' '.join(r['command']) + '\nRETURN CODE: ' + str(r['returncode']) + '\n' + r['stdout'] + r['stderr'] for r in results)
(OUT / 'validation.txt').write_text(log + '\n', encoding='utf-8')
paths = [p for p in OUT.iterdir() if p.is_file() and p.name != 'outputs_sha256.json']
manifest = {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(paths)}
(OUT / 'outputs_sha256.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
for r in results:
    print(r['stdout'].strip() or r['stderr'].strip())
raise SystemExit(0 if all(r['returncode'] == 0 for r in results) else 1)
