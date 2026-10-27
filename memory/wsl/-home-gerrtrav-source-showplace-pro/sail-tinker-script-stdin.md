---
name: sail-tinker-script-stdin
description: Run tinker scripts by piping them on stdin (`docker compose exec -T -u sail laravel.test php artisan tinker < file`); a host /tmp path argument hangs forever
metadata:
  type: feedback
---

`sail artisan tinker /tmp/.../script.php` hangs: the scratchpad path exists only on the WSL host, not in the container, so tinker sits waiting for interactive input. Pipe the script on stdin instead (no `<?php` opening tag): `timeout 300 docker compose exec -T -u sail laravel.test php artisan tinker < "$S/script.php"`.

**Why:** Lost several minutes on a hung background tinker during SPPRO-257 (2026-10-20).
**How to apply:** Any multi-line tinker against local/Frontier: stdin + timeout, never a host path argument.
