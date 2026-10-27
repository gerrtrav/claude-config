---
name: jira-default-assignee-space-admin
description: "When the user gives no assignee for a Jira ticket, assign it to the person in the Administrator role under the space's (project's) access settings"
metadata:
  node_type: memory
  type: feedback
  originSessionId: a8dc6949-983b-4602-8024-f883c16dc9a0
  modified: 2026-10-19T14:20:22.110Z
---

When creating or handling a Jira ticket and the user hasn't named an assignee, don't leave it unassigned or guess. Look up who holds the **Administrator** role under the space's access settings (Jira space/project settings → Access / People) and assign the ticket to them.

**Why:** The user stated (2026-10-19) that when they don't give an assignee, the space Administrator role is how to decide who gets the ticket.

**How to apply:** Before creating/assigning, query the project's role membership for "Administrator" (e.g. via the Atlassian MCP `discover` → project role/actor lookup) and set `assignee` to that accountId. If several people hold the role, ask the user which one. An explicit assignee from the user, or a specific rule like [[jira-qa-docs-subtasks-sarah]] or [[server-sudo-changes-shad]], takes precedence.
