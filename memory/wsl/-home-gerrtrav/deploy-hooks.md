---
name: deploy-hooks
description: "Shared post-receive deploy hooks for /srv/git on test and prod live in ~/source/deploy-hooks (INFRA-119), rolled out with install.sh"
metadata:
  node_type: memory
  type: project
  originSessionId: 5af8a14f-e6e7-4f1c-bb9d-dc08bca12313
  modified: 2026-10-19T18:23:36.459Z
---

Since 2026-10-19 (INFRA-119) every `/srv/git/<app>.git/hooks/post-receive` on swp-app-nginx-test (ssh `test`) and
swp-nginx-prod (ssh `app`) is a symlink to `/srv/git/hooks/post-receive-<env>`. The source is
`~/source/deploy-hooks` (Bitbucket `showplacecabinetry/deploy_hooks`).

- Per-app settings are in `servers/<env>.conf`, and `install.sh` writes them to the bare repo's git config as `deploy.*`
  (worktree, build, branch on prod, queueRestart).
- An optional executable `hooks/post-deploy` in a bare repo runs after the build.
- `./install.sh <env>` is a dry run and drift check; `--apply` rolls it out. `tests/run.sh` must pass first.
- The old hooks remain beside the symlinks as `post-receive.pre-shared` and `post-receive.bak-20261019`.
- Never hand-edit hooks on the servers: change this repo, then run install.sh.

**Why:** Git doesn't version hooks, so there used to be about 30 hand-maintained copies.
**How to apply:** For any deploy-hook change or new app, edit the repo, run the tests, merge, then run `install.sh`
(test first). Related: [[kanban-deploy]].
