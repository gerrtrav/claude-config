---
name: rework-tests-hit-frontier
description: "rework's phpunit uses RefreshDatabase with .env DB_CONNECTION=frontier; never run php artisan test locally as-is"
metadata:
  node_type: memory
  type: project
  originSessionId: db6e54f7-453b-41d9-8493-f58072677904
  modified: 2026-11-09T16:11:01.225Z
---

rework (~/source/rework) Feature tests use RefreshDatabase and phpunit.xml doesn't override DB_CONNECTION, so `php artisan test` would migrate:fresh against Frontier (.env DB_CONNECTION=frontier). Same trap as [[onbear-tests-hit-frontier]].

**Why:** found 2026-11-09 while validating rework on PHP 8.5 (RA-143).
**How to apply:** only run rework tests in a container with `--network none` and a scratch .env with DB_CONNECTION=sqlite, DB_DATABASE=:memory: (and no cached bootstrap/cache/config.php). 12 Breeze auth tests fail regardless: they reference a nonexistent App\Models\User (auth uses App\Ldap\User).
