---
name: sail-container-uid-mismatch
description: If most tests fail with "Unable to create a directory at .../storage/app/...", the Sail app container was started without WWWUSER evaluated; recreate it via sail
metadata:
  type: project
---

`.env` sets `WWWUSER="$(id -u)"`, which only works when `./vendor/bin/sail` sources `.env`. If the app container is started some other way (plain `docker compose`), it gets the literal string, the `sail` user stays uid 1337, and it can't write to the uid-1000-owned `storage/` (tests fail with permission errors on `storage/app/icons` and `.phpunit.result.cache`). Seen 2026-10-07.

**Why:** It looks like a code regression, but it's an environment problem.
**How to apply:** Check `./vendor/bin/sail exec -u sail laravel.test id`. If it isn't uid 1000, run `docker rm -f showplace-pro-laravel.test-1` then `./vendor/bin/sail up -d`. `sail up -d --force-recreate laravel.test` hit a container-name conflict.
