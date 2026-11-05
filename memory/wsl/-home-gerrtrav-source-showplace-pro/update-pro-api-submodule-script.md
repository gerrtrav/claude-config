---
name: update-pro-api-submodule-script
description: "When asked to update the pro-api submodule, run ./update-pro-api (merges develop into docker-changes, keeps Sail DB changes, commits pointer)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6b26dc96-666e-44f8-bfdf-34297f83bb7c
  modified: 2026-10-28T12:25:39.431Z
---

When the user asks to update the pro-api submodule, run `./update-pro-api --push <JIRA-KEY>` from the showplace-pro root instead of `git submodule update --remote` (which detaches HEAD and drops the local Sail database changes).

The script (added 2026-10-28, SPPRO-5195) switches `resources/pro-api` to its `docker-changes` branch (pro-api DB connections pointed at the Sail containers), merges `origin/develop` (pro-api's active branch; `master` is stale), lists newly added connection strings to check, pushes `docker-changes` to pro-api origin with `--push` (needed so other clones can fetch the recorded commit), and commits only the submodule pointer in showplace-pro.

**Why:** The user asked on 2026-10-28 that a submodule update always go through this script.

**How to apply:** Commit on a branch per [[git-workflow-preferences]] (the script commits on the current branch), then land as usual. If it stops on a merge conflict, keep the Sail connection settings, finish the merge in the submodule, and rerun. Report any connection lines it flags. Running the script is the one sanctioned change to the submodule; otherwise still don't edit pro-api files (AGENTS.md).
