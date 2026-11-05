---
name: documentupload-deploy
description: documentupload (~/source/document-upload) deploys atomically on test and prod via the shared hooks; switch-over pending as of 2026-11-05
metadata:
  node_type: memory
  type: project
  originSessionId: cf90147c-ccaa-4ed1-8c32-a6da05a0cb14
  modified: 2026-11-05T19:09:50.501Z
---

Since 2026-11-05 (DU-29), the [[deploy-hooks]] config deploys documentupload atomically: test `atomic=true optimize=true`, prod also has
`branch=main php=php8.5 build=build`. The settings are applied on both servers.

- Remotes: `test` = `test:/srv/git/documentupload.git`, `prod` = `app:/srv/git/documentupload.git`. The repo-local
  `git deploy` alias (copied from [[kanban-deploy]]) tags main `release-YYYY.MM.DD` and ships to prod. Never run it to test.
- Pushes refuse to deploy until each server's sudo switch-over is done:
  `~/source/deploy-hooks/docs/DU-29-documentupload-punchlist.md`.
- Prod's first atomic release is also the first Laravel 13/PHP 8.5/Vite release. nginx moves from php8.2-fpm.sock to
  php8.5-fpm-documentupload.sock in the same window. The shared .env needs VITE_DWT_LICENSE_KEY.

**Why:** Deploys without downtime, plus instant rollback by switching the symlink.
**How to apply:** Once the switch-over is done, delete the punch-list note above and keep the remote/alias facts.
