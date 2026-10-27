---
name: no-rovo-mcp
description: The Atlassian Rovo MCP server no longer exists; use only the Atlassian MCP tools for Jira/Confluence
metadata:
  type: feedback
---

Never call any `mcp__claude_ai_Atlassian_Rovo__*` tool, even if it still shows up in the deferred tool list. Use the `mcp__claude_ai_Atlassian_MCP__*` tools (getJiraIssue, transitionJiraIssue, addOrEditJiraIssueComment, discover/executeRead/executeWrite, etc.) for all Jira and Confluence work.

**Why:** The user said (2026-10-08) "Rovo does not exist anymore. Stop trying to use it."

**How to apply:** For any Jira/Confluence step in [[jira-ticket-workflow]], [[jira-finish-to-qa]] or [[jira-parking-lot-to-in-progress]], pick the Atlassian MCP equivalent; if one isn't a primary tool, find it with `discover`.
