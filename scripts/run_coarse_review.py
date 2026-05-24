#!/usr/bin/env python3
"""Run coarse-review only after validating the OpenRouter key.

This wrapper prevents stale OPENROUTER_API_KEY values from being inherited by
coarse-review. It validates candidate keys first and passes the validated key
explicitly to the subprocess environment.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import shlex
import shutil
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path


OPENROUTER_KEY_URL = "https://openrouter.ai/api/v1/key"
COARSE_PACKAGE = "coarse-ink==1.4.1"


def fingerprint(key: str) -> str:
    return hashlib.sha256(key.encode("utf-8")).hexdigest()[:12]


def describe_key(key: str) -> str:
    if not key:
        return "empty"
    return f"{key[:10]}...{key[-4:]} sha256_12={fingerprint(key)}"


def read_dotenv(path: Path) -> str | None:
    if not path.exists():
        return None
    for line in path.read_text().splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or "=" not in stripped:
            continue
        name, value = stripped.split("=", 1)
        if name.strip() == "OPENROUTER_API_KEY":
            return value.strip().strip('"').strip("'")
    return None


def read_keychain() -> str | None:
    account = os.environ.get("USER") or os.environ.get("LOGNAME") or ""
    if not account:
        try:
            account = subprocess.check_output(["whoami"], text=True).strip()
        except subprocess.SubprocessError:
            return None
    try:
        result = subprocess.run(
            [
                "security",
                "find-generic-password",
                "-a",
                account,
                "-s",
                "OPENROUTER_API_KEY",
                "-w",
            ],
            text=True,
            capture_output=True,
            check=False,
        )
    except FileNotFoundError:
        return None
    if result.returncode != 0:
        return None
    key = result.stdout.strip()
    return key or None


def candidate_keys() -> list[tuple[str, str]]:
    candidates: list[tuple[str, str]] = []
    keychain_key = read_keychain()
    if keychain_key:
        candidates.append(("macOS Keychain", keychain_key))
    env_key = os.environ.get("OPENROUTER_API_KEY", "").strip()
    if env_key:
        candidates.append(("environment", env_key))
    dotenv_key = read_dotenv(Path(".env"))
    if dotenv_key:
        candidates.append((".env", dotenv_key))

    seen: set[str] = set()
    unique: list[tuple[str, str]] = []
    for source, key in candidates:
        digest = fingerprint(key)
        if digest not in seen:
            unique.append((source, key))
            seen.add(digest)
    return unique


def validate_openrouter_key(key: str) -> tuple[bool, str]:
    request = urllib.request.Request(
        OPENROUTER_KEY_URL,
        headers={"Authorization": f"Bearer {key}"},
    )
    try:
        with urllib.request.urlopen(request, timeout=20) as response:
            payload = response.read().decode("utf-8", errors="replace")
            return True, f"HTTP {response.status}; {payload[:500]}"
    except urllib.error.HTTPError as exc:
        body = exc.read().decode("utf-8", errors="replace")
        return False, f"HTTP {exc.code}; {body[:500]}"
    except urllib.error.URLError as exc:
        return False, f"network error: {exc.reason}"


def choose_valid_key() -> tuple[str, str]:
    candidates = candidate_keys()
    if not candidates:
        raise SystemExit(
            "No OPENROUTER_API_KEY candidate found in environment, macOS Keychain, or .env."
        )

    failures: list[str] = []
    for source, key in candidates:
        ok, detail = validate_openrouter_key(key)
        if ok:
            print(f"OpenRouter key OK from {source}: {describe_key(key)}")
            return source, key
        failures.append(f"- {source}: {describe_key(key)} -> {detail}")

    raise SystemExit(
        "No valid OpenRouter key found. Refusing to run coarse-review.\n"
        + "\n".join(failures)
    )


def maybe_extract_pdf(paper: Path, output: Path | None) -> Path | None:
    if output is not None:
        return output
    if paper.suffix.lower() != ".pdf":
        return None
    if shutil.which("pdftotext") is None:
        return None
    extracted = Path("/tmp") / f"{paper.stem}_compiled_for_coarse.md"
    subprocess.run(
        ["pdftotext", "-layout", str(paper), str(extracted)],
        check=True,
    )
    print(f"Pre-extracted PDF text: {extracted}")
    return extracted


def build_command(args: argparse.Namespace, log_file: Path, pre_extracted: Path | None) -> list[str]:
    command = [
        "uvx",
        "--python",
        "3.12",
        "--from",
        COARSE_PACKAGE,
        "coarse-review",
        "--detach",
        "--log-file",
        str(log_file),
        str(args.paper),
        "--host",
        args.host,
        "--model",
        args.model,
        "--effort",
        args.effort,
        "--output-dir",
        args.output_dir,
    ]
    if pre_extracted is not None:
        command.extend(["--pre-extracted", str(pre_extracted)])
    return command


def run(args: argparse.Namespace) -> int:
    _, key = choose_valid_key()
    if args.validate_only:
        return 0

    paper = Path(args.paper)
    if not paper.exists():
        raise SystemExit(f"Paper not found: {paper}")

    pre_extracted = maybe_extract_pdf(paper, Path(args.pre_extracted) if args.pre_extracted else None)
    timestamp = time.strftime("%Y%m%d-%H%M%S")
    log_file = Path(args.log_file) if args.log_file else Path("/tmp") / f"coarse-review-{paper.stem}-{timestamp}.log"

    env = os.environ.copy()
    env["OPENROUTER_API_KEY"] = key

    command = build_command(args, log_file, pre_extracted)
    print("Launching:")
    print(" ".join(shlex.quote(part) for part in command))
    subprocess.run(command, check=True, env=env)

    attach_command = [
        "uvx",
        "--python",
        "3.12",
        "--from",
        COARSE_PACKAGE,
        "coarse-review",
        "--attach",
        str(log_file),
        "--attach-timeout",
        str(args.attach_timeout),
    ]
    print("Attaching:")
    print(" ".join(shlex.quote(part) for part in attach_command))
    subprocess.run(attach_command, check=True, env=env)
    return 0


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate OpenRouter credentials and run coarse-review safely."
    )
    parser.add_argument("paper", nargs="?", default="formal_model_v5.pdf")
    parser.add_argument("--host", default="codex")
    parser.add_argument("--model", default="gpt-5.4")
    parser.add_argument("--effort", default="high", choices=["low", "medium", "high", "max"])
    parser.add_argument("--output-dir", default="./coarse-output/")
    parser.add_argument("--pre-extracted")
    parser.add_argument("--log-file")
    parser.add_argument("--attach-timeout", type=int, default=3600)
    parser.add_argument("--validate-only", action="store_true")
    return parser.parse_args(argv)


if __name__ == "__main__":
    raise SystemExit(run(parse_args(sys.argv[1:])))
