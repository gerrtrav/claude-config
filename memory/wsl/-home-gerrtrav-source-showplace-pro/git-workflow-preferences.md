---
name: git-workflow-preferences
description: Make many small commits; land branches by rebasing onto master and merging locally (no push), verify, then delete the local branch
metadata:
  node_type: memory
  pinned: false
  originSessionId: 32a98a20-801d-4e60-b4f6-f2182905c648
  modified: 2026-10-07T14:37:17.928Z
---

Prefer creating many small, focused commits, one per logical step, over a few large ones.

To land a finished branch, rebase it onto `master` and merge it into the local `master` (fast-forward) rather than pushing the branch to a remote. After merging, always verify the merge completed successfully (for example, `git log` shows the branch's commits on `master` and `git status` is clean), and only then delete the local branch. The user asked for this workflow on 2026-09-23. It replaces an earlier preference that the user did all merging themselves.

The project uses trunk-based development with `master` as the trunk (user clarified on 2026-09-24). This means branches should be short-lived and landed on `master` quickly, and unfinished work should be hidden behind Pennant feature flags rather than kept on a branch. It does not mean committing directly to `master`: the global rule against changing `master` without explicit permission still applies.

Pushing to remotes remains the user's job. Do not offer to push or open a pull request. Exception: when moving a ticket to QA, push `master` to prodev (and origin) before posting the QA instructions (see [[jira-finish-to-qa]]).

Always create a local branch before making any code change, without asking, and never do work on `master` (user rule, 2026-10-07; replaces an earlier "only branch when asked" preference). Name it after the ticket, e.g. `sppro-4827-dashboard-group-capacity`.
