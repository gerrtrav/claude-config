---
name: staging-remote-prodev
description: "\"Dev\" and \"staging\" both mean the prodev git remote; `git push prodev master` auto-deploys"
metadata:
  node_type: memory
  type: reference
  originSessionId: 032c4602-d5f2-4e00-ad6d-a376f83de5b9
  modified: 2026-10-07T14:37:17.790Z
---

In showplace-pro, "staging" and "dev" both mean the `prodev` git remote (`prodev:/srv/git/showplace_pro.git`, moved from `~travisgerry/repos/` on 2026-10-07 so all developers in the `www-data` group can push), not a branch. There is no `staging` branch anywhere. `git push prodev master` triggers a post-receive hook that deploys the pushed commit and restarts supervisord ("post-receive: deployed <sha>"). Confirmed 2026-10-05 when the user said "push to staging as well" right after pushing master to origin.

Pushing is normally the user's job (see [[git-workflow-preferences]]). Only push to origin or prodev when they ask, or when they ask to move a ticket to QA: the code must be on prodev before the QA instructions are posted (see [[jira-finish-to-qa]]).

The user confirmed on 2026-10-05 that "dev" means prodev too (they said "push to master and dev"), and asked for this to be written into AGENTS.md and `.github/copilot-instructions.md` for all agents. Ignore the stale `develop` branch on prodev (last commit Feb 2025).

The deployed dev/staging site is https://pro-staging.showplacewood.com/ (user gave this on 2026-10-05; use it as `APP_URL` when browser-testing on dev).
