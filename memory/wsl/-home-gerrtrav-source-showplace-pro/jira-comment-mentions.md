---
name: jira-comment-mentions
description: "To @mention someone in a Jira comment via the Atlassian MCP, use HTML contentFormat with a span data-type=\"mention\" data-user-id"
metadata:
  node_type: memory
  type: reference
  originSessionId: ab8f325f-014d-4914-92f4-d2af5a1b6866
  modified: 2026-10-22T11:32:15.683Z
---

To @mention a user in a Jira comment through `addOrEditJiraIssueComment`, pass `contentFormat: "html"` and use
`<span data-type="mention" data-user-id="<accountId>">@Name</span>`. The `<custom data-type="mention" data-id=...>`
shape that `getJiraIssue` returns when reading comments is NOT accepted on write; it gets stored as literal escaped text
(seen on SPPRO-4318, 2026-10-14; fixed by editing the comment). Markdown comments can't carry mentions.

Known account IDs: Nathaniel Jay Lee = 5aeb1c31d5c9632c3013ceaf; Mayas Knaizeh = 712020:d129d533-657d-488f-8b51-cc650565a92e; Sawyer DeWitt (QA) = 712020:70cf691d-8a4b-40d5-9aa7-1fe0ad33a41f.
