---
name: onbear-tests-hit-frontier
description: "onbear's test suite runs migrate:fresh against Frontier library ONBEARTST (shared with staging) — never run its tests until fixed"
metadata:
  node_type: memory
  type: project
  originSessionId: fd78d893-8fc3-4573-b74b-8154446e45a2
  modified: 2026-11-09T14:55:08.101Z
---

In ~/source/onbear, `tests/Pest.php` applies RefreshDatabase to all tests, `.env` has `DB_CONNECTION=frontier`, and `phpunit.xml` only overrides `DB_DATABASE`. So `sail test` / `php artisan test` runs `migrate:fresh` on Frontier (IBM i 192.168.127.17), library ONBEARTST, which the onbear staging site also uses. The easi-power DB2 driver's dropAllTables drops every table in the default schema. Discovered 2026-11-09 (OBE-15) after Claude ran the suite four times.

**Why:** running the tests wipes staging's onbear data.
**How to apply:** don't run onbear tests until phpunit.xml sets `DB_CONNECTION=sqlite` (or equivalent) and that is verified; check any Laravel app's test DB connection before running its tests. Related: [[evox-jira-workflow]]
