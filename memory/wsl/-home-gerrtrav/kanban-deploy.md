---
name: kanban-deploy
description: How kanban_ordering is deployed to test and production (push to /srv/git/kanban.git; shared deploy hook)
metadata:
  node_type: memory
  type: project
  originSessionId: 5af8a14f-e6e7-4f1c-bb9d-dc08bca12313
  modified: 2026-10-19T18:23:31.169Z
---

kanban_ordering (`~/source/kanban_ordering`) deploys by push to bare repos that use the shared hook from [[deploy-hooks]]:

- Remote `test` = `test:/srv/git/kanban.git`: any pushed branch deploys to `/var/www/kanban` on swp-app-nginx-test (last push wins).
- Remote `prod` = `app:/srv/git/kanban.git`: deploys only when a `release-*` tag on `main` is pushed with it,
  e.g. `git tag release-2026.10.20 main && git push prod main release-2026.10.20`.
- Repo-local alias `git deploy` (updated 2026-10-19): tags `main` as `release-YYYY.MM.DD` (adds `.2`, `.3`... if that tag
  exists locally or on prod), pushes main + tag to origin, then to prod. It ships to production; never run it to test.
  Prod kanban had never been deployed through `/srv/git` before this (no index in the bare repo), so the first run
  overwrites `/var/www/kanban` with main.
- The old `~/repos/kanban_ordering.git` hook, `~/kb_post-receive` and `~/kb_update` are superseded.

**Why:** Deploy hooks were consolidated under INFRA-119 (2026-10-19).
**How to apply:** Ship kanban with `git deploy` (or a release tag pushed to `prod`); change deploy steps in the deploy-hooks repo, not on the server.
