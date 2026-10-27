---
name: confluence-update-tech-docs-on-feature-change
description: When changing or adding a showplace-pro feature, update the matching page under "Showplace Pro Technical Documentation" in Confluence
metadata:
  type: feedback
---

Whenever a change adds, changes or removes a feature in showplace-pro, update the Showplace Pro Technical Documentation in Confluence (parent page id 681377793, cloudId 1a029e5d-adb5-44de-af2d-72c337978d83, space SHOPRO) so it matches the code. Update the child page that covers the area (e.g. Quotes and Orders, Reports, Admin, Config Area, Electronic Catalog, Authentication Users and Permissions; ids in [[confluence-tech-docs-lean-pass]]); if no page covers it, add a section or a new child page under the parent and list it on the parent page.

**Why:** On 2026-10-27, after the documentation pass began, the user asked that the technical docs be kept current as features change.

**How to apply:** Do it as part of finishing the work (alongside landing the branch and QA notes, [[jira-finish-to-qa]]), not as a separate later task. Edit only the affected sections, keep the page's "In plain language" section accurate ([[jira-ticket-plain-language-section]]), use the Atlassian MCP tools ([[no-rovo-mcp]]), and use no real dealer/customer data. If the feature is behind a Pennant flag, note the flag and that it may be off in production. Mention the doc update (page and what changed) in the final summary.
