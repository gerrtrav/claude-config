---
name: du-finish-to-qa
description: "Finishing a Document Upload (DU) ticket = land on main, push origin + test (\"staging\"), QA comment, assign Sarah Kirchner, move to \"In Review\" (DU has no QA status)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1c78913a-2f5a-4cb6-838d-0b153d7a10d7
  modified: 2026-11-10T16:24:59.991Z
---

For Document Upload (`~/source/document-upload`, Jira DU), "push to staging" means `git push test main`. The `test` remote's post-receive hook deploys whichever branch is pushed and runs `yarn build`. Push `origin main` as well.

DU workflow statuses: To Do, In Progress, In Review, Done, Won't Implement. There is no QA status. When work goes to QA, post a general-overview QA comment (see [[qa-instructions-general-overview]]), assign it to Sarah Kirchner, and transition it to **In Review** (transition id 31).

**Why:** On DU-115 (2026-11-10) the user asked for land, push to origin and staging, QA comments, assign to Sarah, then set it to In Review.

**How to apply:** Use this DU counterpart to [[jira-finish-to-qa]] (which is SPPRO-only). The DU Sail ports (8088/5188/1088/8028/11212) don't clash with showplace-pro, so both stacks can run at once.
