#!/usr/bin/env python3
"""Run coarse-review with longer internal agent timeouts.

The stock coarse pipeline uses several explicit ``future.result(timeout=900)``
calls. On long formal papers, section agents can hit that 15-minute limit even
when the overall attach timeout is generous. This entrypoint patches
``concurrent.futures.Future.result`` so those 900-second waits become a longer
timeout before delegating to ``coarse.cli_review.main``.
"""

from __future__ import annotations

import os
from concurrent.futures import Future


def patch_future_result() -> None:
    original_result = Future.result
    long_timeout = int(os.environ.get("COARSE_REVIEW_AGENT_TIMEOUT", "3600"))

    def result_with_longer_coarse_timeout(self, timeout=None):
        if timeout == 900:
            timeout = long_timeout
        return original_result(self, timeout=timeout)

    Future.result = result_with_longer_coarse_timeout


def main() -> int:
    patch_future_result()
    from coarse.cli_review import main as coarse_main

    return coarse_main()


if __name__ == "__main__":
    raise SystemExit(main())
