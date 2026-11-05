---
name: worktree-test-setup
description: "Running tests in a .claude/worktrees/<name> checkout: a plain vendor symlink silently tests the MAIN checkout's app code; build a vendor dir with its own composer autoloader"
metadata:
  node_type: memory
  type: reference
  originSessionId: 873a533b-1ae5-4407-9726-bb9c75134f54
  modified: 2026-11-02T19:10:28.544Z
---

Claude worktrees (`.claude/worktrees/<name>`) have no `vendor`, `.env` or `node_modules`, and there's no `./vendor/bin/sail`. The Sail container mounts the main checkout at `/var/www/html`, so the worktree is reachable at `/var/www/html/.claude/worktrees/<name>`. Run commands with `docker exec -u sail -w /var/www/html/.claude/worktrees/<name> showplace-pro-laravel.test-1 php artisan ...`.

Trap (found 2026-10-20, SPPRO-5070): symlinking `vendor -> ../../../vendor` makes Composer's autoloader resolve `App\` to the **main checkout's** `app/` (its `__DIR__` is the real path). Tests then run master's code with the worktree's test files, so new tests "fail" for no reason, or pass without the change. Working setup:
- `mkdir vendor`, symlink each entry of the main `vendor/` (`../../../../vendor/<pkg>`) except `composer`, `autoload.php` and `phpunit`, which are **copied** (phpunit's script finds `../../autoload.php` from its real path).
- `ln -s ../../../.env .env`; `mkdir -p storage/framework/{cache/data,sessions,views,testing} storage/logs bootstrap/cache`. All are gitignored.
- Always `docker exec -u sail`. Running as root (the default, e.g. a first tinker call) leaves `storage/logs/laravel.log` root-owned, which caused 236 failures in the suite. Fix with `docker exec showplace-pro-laravel.test-1 chown -R sail:sail <worktree>/storage <worktree>/bootstrap/cache`. See [[sail-exec-runs-as-root]].
- Icons (found 2026-11-02, SPPRO-4318): a worktree only has the ~34 git-tracked `storage/app/icons` files, while the main checkout has a fuller untracked unicon cache. Tests that render missing icons fail with `UnknownIconException`, and unicon leaves **0-byte** cache files behind when downloads fail, so `cp -n` skips them. Copy `../../../storage/app/icons/.` into the worktree and then replace any `find storage/app/icons -type f -empty` files with the main copies.
- `core.autocrlf=true`, so working files are CRLF and `pint --test` flags `line_ending` (and spurious rules) on every file. Check LF copies (`tr -d '\r'`) under `storage/framework/testing/` instead.

Landing from a worktree: `master` is checked out in the main checkout, so it can't be fast-forwarded from here. Rebase onto `origin/master` and push `HEAD:master` to prodev and origin; the main checkout then needs `git pull --ff-only`. The worktree guard also blocks `git -C <main>` and docker commands that expand env vars (e.g. `$PROD_RO_DB_PASSWORD`), so prod read-only queries aren't possible from a worktree session.
