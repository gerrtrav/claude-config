---
name: full-test-suite-save-output
description: Full `sail artisan test` takes ~5.5 min; run it with the Bash tool's run_in_background, save output to a file, never poll with pgrep
metadata:
  type: feedback
---

The full showplace-pro suite (~1890 tests as of 2026-10-20) takes about 8 minutes. Run it with the Bash tool's `run_in_background: true` (which notifies on completion), redirecting all output to a scratchpad log, then grep the log for `FAILED|Tests:`. Never re-run just to see what failed.

**Why:** On SPPRO-4735 (2026-10-13) output went through `tail` only, so failing names were lost and the suite was re-run; the user asked "why is this taking so long?". On SPPRO-4744 (2026-10-14) the suite was started with a shell `&` and a background `until ... ! pgrep -f "php artisan test"` watcher was added; the watcher's own command line matched the pattern, so it never finished, and the user asked "what is the shell doing and when will it be done?" 10 minutes after the tests had ended.

**How to apply:** Focused tests first; one full run in the background with output saved. Don't start tests with `&`, and never wait on a process with `pgrep -f` using text that is in the waiting command itself.

Known flake: tests that create accounts as `'OA'/'TA'/'MA'.Str::random(4)` (e.g. RequestDetailPolicyChecksTest, AdminFolderOtherUsersAuthorizationTest) sometimes hit a duplicate `accmstky`, because the local dev DB holds ~1,157 leftover OA… accounts (and 212 TA…, seen 2026-10-15) and the column is case-insensitive. A re-run of the file passes; not caused by the change under test.
