---
name: atlassian-mcp-timeout-writes-apply
description: Atlassian MCP write calls that report "The operation timed out" may still have applied; read the ticket back before retrying
metadata:
  type: reference
---

On 2026-10-21 (SPPRO-4861) addOrEditJiraIssueComment returned "The operation timed out." but the comment had been posted (seen on a later getJiraIssue). Reads timed out in bursts too, then recovered minutes later.

**How to apply:** after a timed-out Jira write, read the issue (status/comments) before retrying, so comments aren't duplicated; if reads also time out, stop and tell the user rather than retrying blind.

When the connector times out on every call (even getAccessibleAtlassianResources; happened all of 2026-10-22 while the site was up), fall back to the Jira REST API with the user's `$JIRA_EMAIL`/`$JIRA_API_TOKEN` env vars: `curl -u "$JIRA_EMAIL:$JIRA_API_TOKEN" https://showplacecabinetry.atlassian.net/rest/api/3/issue/<KEY>...` (comments as ADF JSON). Never print the token.
