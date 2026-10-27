---
name: confluence-tech-docs-lean-pass
description: "Multi-day lean pass documenting showplace-pro in Confluence (SHOPRO); parent page id, done/remaining days, ~10%/day budget"
metadata:
  node_type: memory
  type: project
  originSessionId: 3bdc5363-056a-485d-adb9-2aef797e167b
  modified: 2026-10-27T16:01:57.049Z
---

Started 2026-10-27: a lean (~25 page) developer-facing documentation pass of showplace-pro in the Showplace PRO Confluence space ([[confluence-showplace-pro-folder]]), split into ~5 daily sessions so each uses about 10% of the user's weekly Claude allowance.

- cloudId 1a029e5d-adb5-44de-af2d-72c337978d83, spaceId 2195458 (URL key SHOPRO, CQL key SHO), no space instructions.
- Parent page: "Showplace Pro Technical Documentation" id 681377793. Children go under it. Its "Coming next" list should be updated as sections land.
- Day 1 (done 2026-10-27): Architecture Overview 681410561, Tech Stack 681181186, Local Development Setup 681443329, Repository Layout 681476097.
- Days 2+3 (done 2026-10-27, one session, 4 Sonnet Explore agents): Quotes and Orders 681771009, Authentication Users and Permissions 680984578, Reports 681803777, Admin 681246732, Config Area 681836545, Electronic Catalog 681869313. Parent page lists them.
- Remaining — Day 4: integrations (Frontier, change upload, Webdocs, DocuSign, MS Graph mail). Day 5: operations (link existing deploy pages 667549699 / 641073153 rather than duplicate), feature flags, data model overview from the schema export below (existing "Database Layout" 99385353 is from Apr 2025).

Calibration: day 1 (5 pages, incl. a re-publish of 3 pages) used only ~1% of the weekly allowance, so 10% covers far more than one day's chunk; several remaining days can be combined. Days 2+3 (6 pages, 4 agents) plus creating 7 Jira tickets (SPPRO-5182..5188 for problems found) used about 10%.

Production schema export (for the Day 5 data model page): `~/schema-export` (WSL home), exported 2026-10-27 from production with the read-only login ([[production-readonly-db]]) and verified identical to a fresh prod export (and different from local). Files: `sppro.sql` (409 tables, 11 views), `electronic_catalog.sql` (63/5), `dms.sql` (9/2) = `mariadb-dump --no-data --routines --triggers --single-transaction --skip-comments --skip-dump-date` with `AUTO_INCREMENT=` stripped; `columns.tsv` (information_schema.COLUMNS, 3,554 columns); `foreign_keys.tsv` (KEY_COLUMN_USAGE with REFERENCED_TABLE_NAME, only 61 FK columns, so most relationships must come from the Eloquent models). Use these instead of re-querying prod; re-export only if migrations have shipped since (shell is zsh: pass dump options as an array, not a string).

Server drivers checked 2026-10-27: prod cache=memcached, sessions=database, queue=database; staging cache=file, sessions=file, queue=database (staging .env still has dead CACHE_DRIVER).

**Why:** The user's weekly limit was 28% used when this started; they asked for about 10% per day.

**How to apply:** Start each day fresh, read only the area's code (Sonnet sub-agents for bulk reading is fine), verify claims against code before publishing (day 1 had to correct cache/session/queue = database driver per .env.example, not Redis). Every page gets an "In plain language" section ([[jira-ticket-plain-language-section]]). No real dealer/customer data in pages.

Lessons: write cross-links only after sibling page ids exist (placeholder links to the parent had to be fixed). Reading a page in full to get data-local-id for `edits` costs more than it saves on big pages; for small fixes prefer knowing links up front.
