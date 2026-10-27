---
name: jira-attachments-via-rest
description: "How to attach files to Jira tickets — the Atlassian MCP can't, so use REST with the user's JIRA_EMAIL/JIRA_API_TOKEN env vars"
metadata:
  node_type: memory
  type: reference
  originSessionId: 2acab231-f9aa-40d8-afc3-65dd90ff7a20
  modified: 2026-10-07T19:27:11.075Z
---

The Atlassian Rovo MCP has no attachment upload. To attach a file to a Jira ticket, POST to
`https://showplacecabinetry.atlassian.net/rest/api/3/issue/<KEY>/attachments` with header
`X-Atlassian-Token: no-check`, multipart field `file`, and Basic auth `JIRA_EMAIL:JIRA_API_TOKEN`.

The user set both as Windows **User** environment variables (2026-10-07) and authorized using them.
If `$env:JIRA_API_TOKEN` is empty in the session (stale parent terminal), read it with
`[Environment]::GetEnvironmentVariable('JIRA_API_TOKEN','User')`. Never print the token.
JIRA_EMAIL is gerrtrav@showplacewood.com (the Jira account email, not the showplacecabinetry one).

**How to apply:** when asked to attach a file to a ticket, upload it directly rather than asking the user to drag it in.
