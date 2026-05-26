#!/usr/bin/env python3
"""Validate OpenRouter and run coarse-review with selectable run modes.

The default mode follows the stock coarse-review detach/attach workflow because
it is the most resilient choice for long Codex sessions. Use ``--foreground``
when the run specifically needs the local monkey-patch that extends coarse's
internal ``future.result(timeout=900)`` waits.
"""

from __future__ import annotations

import argparse
import os
import shlex
import subprocess
import sys
import time
from pathlib import Path

import run_coarse_review as safe


def add_common_review_args(
    command: list[str],
    args: argparse.Namespace,
    pre_extracted: Path | None,
) -> list[str]:
    command.extend(
        [
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
    )
    if pre_extracted is not None:
        command.extend(["--pre-extracted", str(pre_extracted)])
    if args.no_qa:
        command.append("--no-qa")
    return command


def build_foreground_command(
    args: argparse.Namespace,
    pre_extracted: Path | None,
) -> list[str]:
    command = [
        "uvx",
        "--python",
        "3.12",
        "--from",
        safe.COARSE_PACKAGE,
        "python",
        "scripts/coarse_review_long_timeout.py",
    ]
    return add_common_review_args(command, args, pre_extracted)


def build_detach_command(
    args: argparse.Namespace,
    log_file: Path,
    pre_extracted: Path | None,
) -> list[str]:
    command = [
        "uvx",
        "--python",
        "3.12",
        "--from",
        safe.COARSE_PACKAGE,
        "coarse-review",
        "--detach",
        "--log-file",
        str(log_file),
    ]
    return add_common_review_args(command, args, pre_extracted)


def build_attach_command(args: argparse.Namespace, log_file: Path) -> list[str]:
    return [
        "uvx",
        "--python",
        "3.12",
        "--from",
        safe.COARSE_PACKAGE,
        "coarse-review",
        "--attach",
        str(log_file),
        "--attach-timeout",
        str(args.attach_timeout),
    ]


def default_log_file(args: argparse.Namespace, paper: Path) -> Path:
    if args.log_file:
        return Path(args.log_file)
    timestamp = time.strftime("%Y%m%d-%H%M%S")
    return Path("/tmp") / f"coarse-review-{paper.stem}-{timestamp}.log"


def print_command(label: str, command: list[str]) -> None:
    print(label)
    print(" ".join(shlex.quote(part) for part in command))


def run_detach(
    args: argparse.Namespace,
    pre_extracted: Path | None,
    env: dict[str, str],
    paper: Path,
) -> int:
    log_file = default_log_file(args, paper)
    print(
        "WARNING: defaulting to stock detach/attach mode. This is safer against "
        "Codex session timeouts, but it does not apply the foreground-only patch "
        f"that changes coarse's internal 900s agent timeout to {args.agent_timeout}s. "
        "Use --foreground when section-agent timeouts are the main concern."
    )
    launch_command = build_detach_command(args, log_file, pre_extracted)
    print_command("Launching detached coarse-review:", launch_command)
    subprocess.run(launch_command, check=True, env=env)

    attach_command = build_attach_command(args, log_file)
    print_command("Attaching:", attach_command)
    subprocess.run(attach_command, check=True, env=env)
    return 0


def run_foreground(
    args: argparse.Namespace,
    pre_extracted: Path | None,
    env: dict[str, str],
) -> int:
    env["COARSE_REVIEW_AGENT_TIMEOUT"] = str(args.agent_timeout)
    print(
        "WARNING: foreground mode applies the internal coarse future-timeout "
        "patch, but the process depends on the caller keeping this shell session "
        "alive for the full review."
    )
    command = build_foreground_command(args, pre_extracted)
    print_command("Launching foreground long-timeout coarse-review:", command)
    print(f"Internal coarse future timeout: {args.agent_timeout}s")
    return subprocess.run(command, check=True, env=env).returncode


def run(args: argparse.Namespace) -> int:
    _, key = safe.choose_valid_key()
    if args.validate_only:
        return 0

    paper = Path(args.paper)
    if not paper.exists():
        raise SystemExit(f"Paper not found: {paper}")

    pre_extracted = safe.maybe_extract_pdf(
        paper,
        Path(args.pre_extracted) if args.pre_extracted else None,
    )

    env = os.environ.copy()
    env["OPENROUTER_API_KEY"] = key

    if args.foreground:
        return run_foreground(args, pre_extracted, env)
    return run_detach(args, pre_extracted, env, paper)


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Run coarse-review safely. Defaults to stock detach/attach; "
            "use --foreground to apply the patched internal section-agent timeout."
        )
    )
    parser.add_argument("paper", nargs="?", default="formal_model_v5.pdf")
    parser.add_argument("--host", default="codex")
    parser.add_argument("--model", default="gpt-5.4")
    parser.add_argument("--effort", default="high", choices=["low", "medium", "high", "max"])
    parser.add_argument("--output-dir", default="./coarse-output/")
    parser.add_argument("--pre-extracted")
    parser.add_argument("--agent-timeout", type=int, default=3600)
    parser.add_argument("--attach-timeout", type=int, default=3600)
    parser.add_argument("--log-file")
    parser.add_argument("--foreground", action="store_true")
    parser.add_argument("--no-qa", action="store_true")
    parser.add_argument("--validate-only", action="store_true")
    return parser.parse_args(argv)


if __name__ == "__main__":
    raise SystemExit(run(parse_args(sys.argv[1:])))
