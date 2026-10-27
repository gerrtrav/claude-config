---
name: server-sudo-changes-shad
description: Server changes needing sudo on prodev/proprod (e.g. Apache modules) are handed to Shad Kaske via the Jira ticket
metadata:
  type: project
---

When a ticket needs a manual server change with sudo on prodev/proprod (e.g. `a2enmod headers` for SPPRO-4903, 2026-10-13), the user lands and pushes the code, then assigns the ticket to Shad Kaske (accountId 712020:82c6055e-e237-4619-8f21-63001737e031) with a comment listing the exact commands, verification `curl` checks and rollback. The ticket stays In Progress (not sent to QA).

**Why:** the user/Claude don't run sudo on the servers; Shad does.
**How to apply:** don't run the server commands yourself; write them up on the ticket. Ask before reassigning to Shad: on SPPRO-4980 (2026-10-14, new supervisor worker) the user said "don't assign it to Shad. I'll handle it", so the commands went on the ticket and the assignment was left alone. See [[staging-remote-prodev]], [[jira-finish-to-qa]].
