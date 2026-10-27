---
name: jira-comment-tone
description: "Jira ticket comment tone depends on the project: customer-facing for ITHD, developer-facing otherwise"
metadata: 
  node_type: memory
  pinned: false
  originSessionId: 6ce3effb-92d4-414a-af1c-e5118c0b4dd0
  modified: 2026-09-22T15:40:07.278Z
---

When posting a summary of changes as a comment on a Jira ticket (e.g. via `addCommentToJiraIssue`), the tone depends on the ticket's project key:

- **ITHD-prefixed tickets**: write for the customer/reporter, not for a developer audience. Avoid file paths, function/class names, commit hashes, and internal implementation details (e.g. "derived from `FrontierDate::is_cancelled`"). Describe the change in plain terms: what behavior changed, why, and what the user will now see or experience. This matters because ITHD (IT Helpdesk) is a service-desk project where ticket comments are visible to the reporter (`jsdPublic: true`). Close the comment with "This change is being QAd and will be promoted to production when it passes" rather than claiming the change has already been tested or is ready for release — QA has to verify it first.
- **All other projects**: write developer-facing summaries — file paths, function/class names, commit hashes, and implementation details are appropriate.

This convention is also documented in the repo's `AGENTS.md` (source of truth, symlinked as `CLAUDE.md`) and `.github/copilot-instructions.md`.
