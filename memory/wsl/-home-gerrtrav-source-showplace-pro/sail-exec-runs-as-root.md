---
name: sail-exec-runs-as-root
description: "`sail exec laravel.test ...` runs as root; running tests that way leaves root-owned storage dirs that break later test runs"
metadata:
  type: feedback
---

`./vendor/bin/sail exec laravel.test php artisan test` runs as root (not the `sail` user). On 2026-10-09 (SPPRO-4621) a run used to set an env var (`sail exec -e FEATURE_...=true`) left `storage/framework/testing/disks/tmp-for-tests/livewire-tmp` owned by root, and the next normal `sail artisan test` had 24 "Permission denied" failures.

**Why:** It looks like a regression but is an environment artifact, like [[sail-container-uid-mismatch]].
**How to apply:** Add `-u sail` when using `sail exec` to run tests with extra env vars. If it already happened, remove the root-owned dirs (`sail exec laravel.test rm -rf <dir>`; `find storage bootstrap/cache -user root`).
