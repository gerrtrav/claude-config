---
name: confluence-update-tech-docs-on-feature-change
description: When changing/adding a showplace-pro feature, update the matching markdown in docs/confluence/ (the Technical Documentation tree, published to Confluence); never edit those pages in Confluence
metadata:
  type: feedback
---

Whenever a change adds, changes or removes a feature in showplace-pro, update the matching file under `docs/confluence/` in the same branch (rules in `docs/agents/confluence-docs.md`). Since 2026-11-11 (SPPRO-5291) these files are the source of the Confluence "Showplace Pro Technical Documentation" tree (root page 681377793, space key SHO); the Confluence pages are edit-restricted to the user and refreshed by `docs:confluence-publish`.

**Why:** On 2026-10-27 the user asked that the technical docs be kept current as features change; on 2026-11-11 they moved the docs into the repo to save tokens and review docs with code ([[confluence-docs-repo-sync]]).

**How to apply:** Edit only the affected sections, keep the "In plain language" section accurate ([[jira-ticket-plain-language-section]]), no real dealer/customer data, note Pennant flags. Never edit these pages through the Atlassian MCP/REST API and never run `docs:confluence-publish --apply`/`--archive`/`--restrict` — a person or the pipeline publishes; a dry run is fine. Mention the doc update in the final summary. Other Confluence pages (user guide, plans) are still edited in Confluence.
