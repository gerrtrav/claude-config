---
name: no-parallel-tests
description: "Never run `sail artisan test --parallel` in showplace-pro; run the suite serially"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 35c8fb62-1e4b-4cf6-886a-7d0ef6d5c4d8
  modified: 2026-10-13T18:19:07.156Z
---

Never run `./vendor/bin/sail artisan test --parallel` in showplace-pro. Run the suite serially (`./vendor/bin/sail artisan test`, ~5-6 minutes for ~1500 tests, so use a background run or a long timeout).

**Why:** ParaTest (brianium/paratest) isn't installed, so `--parallel` exits with a RequirementsException and runs no tests, but still exits 0, which can look like a pass. The user told me on 2026-10-13 (SPPRO-4852) that it doesn't work with this project. The base TestCase's per-connection transactions on the shared dev databases also aren't built for parallel workers.

**How to apply:** For the full suite, always use the serial command. To narrow it down, pass a path or `--filter` instead.
