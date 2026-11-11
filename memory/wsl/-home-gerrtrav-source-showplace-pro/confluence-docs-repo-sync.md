---
name: confluence-docs-repo-sync
description: "SPPRO-5291 Confluence→repo markdown sync: whole Showplace Pro space, restricted pages, publish via the user's own token first, service account requested via ITHD"
metadata:
  node_type: memory
  type: project
  originSessionId: b38b303f-e743-44e6-be8a-f6add5fb8c73
  modified: 2026-11-11T15:28:56.559Z
---

SPPRO-5291 (created 2026-11-11, Task under SPPRO-4573, assigned to the user; Done 11-11 without QA, comment 54274): copy the Technical Documentation pages into the repo as markdown; a non-Claude script publishes changes back (update/create/archive), by hand or on a schedule. Confluence pages get edit restrictions so only the publisher can edit them.

Decisions (2026-11-11): scope = only the "Showplace Pro Technical Documentation" tree (root page 681377793, 54 pages; changed from the whole space the same day); protection = restricted pages; publish with the user's own account/token while building and testing; switch to the ITHD-3703 service account before turning on the merge-triggered pipeline.

**Why:** Editing local markdown costs far fewer tokens than Confluence MCP reads and full-page writes, and doc changes get reviewed with the code.
Status 2026-11-11: built and landed and pushed to origin + prodev 2026-11-11 (7d9a998d9): artisan docs:confluence-import / docs:confluence-publish (dry run unless --apply; --archive, --restrict, --force-page, --parent + --title-prefix for scratch tests), 57 pages imported into docs/confluence (dry run = all unchanged). Space key is SHO. scratch test done 11-11 under page 714145794 (7 [Scratch] pages, then trashed by the user; archive is one page per request on our plan — no bulk archiving, fixed in 7d9a998d9). Live 11-11: user ran --apply --restrict; all 57 pages restricted to the user, sync records at current versions. Still to do: Bitbucket Pipeline on push to master touching docs/confluence/** (changed from nightly 11-11, waits for ITHD-3703); publishing runs by a person, never Claude. Pass the token into Sail with `CONFLUENCE_EMAIL="$JIRA_EMAIL" CONFLUENCE_API_TOKEN="$JIRA_API_TOKEN" ./vendor/bin/sail exec -u sail -e CONFLUENCE_EMAIL -e CONFLUENCE_API_TOKEN laravel.test php artisan ...`.
**How to apply:** Plan at docs/SPPRO-5291-plan.md. Once the sync is live, this replaces [[confluence-update-tech-docs-on-feature-change]] (edit docs/confluence/ instead of Confluence).

Second repo 2026-11-11: document-upload got the same sync under DU-118 (whole DU space, root = home page 699924609, 16 pages; config in config/services.php `services.confluence.*`; pushed to origin 11-11; published once with --apply 11-11, all 16 unchanged; deliberately NOT restricted so staff can still edit the user pages). Instructions in that repo's docs/agents/confluence-docs.md.

Third repo 2026-11-11: colorselectordering got the sync under CSO-83 (user-created CSO space, root = home page 714866892). The space was empty, so Claude wrote 13 pages from the code (home, 5 user pages, Technical + 6). Pushed to origin develop and published with --apply --archive 2026-11-11 (13 pages, templates archived, ids committed d727253, dry run all unchanged); no --restrict. .env.example + user local .env now DB2_LIB_DATABASE=CLRSLORDEV (was CLRSLORPRD).

Fourth repo 2026-11-11: kanban_ordering got the sync under EVOX-905 (KO space, root = home page 712310886, 11 pages imported, dry run unchanged). Pushed to origin main and published once with --apply (no --restrict) 2026-11-11, all 11 unchanged. EVOX-905 stuck in Parking Lot: from there the workflow only offers Won't Implement / Parking Lot / Done (EVOX-867 went Parking Lot → Backlog → In Progress, done by someone else).

Fifth repo 2026-11-11: cdc-documenation (Design Services, Laravel 10, branch master) got the sync under CDCDOCS-143 (DS space, root = home page 698056901, 17 pages imported, dry run unchanged). Pushed to origin master (cd076a6) and published once with --apply (no --restrict) 2026-11-11, all 17 unchanged; not pushed to test/prod. Needed guzzlehttp/guzzle added (composer require; its post-update ide-helper:generate rewrites _ide_helper.php and tries DB2 → revert it). Local .env needed LF endings and APP_URL without `${APP_PORT:-80}` (phpdotenv can't parse it). Empty CONFLUENCE_EMAIL=/CONFLUENCE_API_TOKEN= lines in .env override the `sail exec -e` values → leave them out. Tests made safe under CDCDOCS-137 (cd076a6, local master): phpunit.xml forces sqlite :memory: + blank DB2 login, TestCase guard refuses DB2; full `sail artisan test` is safe (15 Breeze auth tests fail on migrations until CDCDOCS-131/139). CDCDOCS-143 .env fixes fc1c798. User re-enabled DB2 user CDCDOCSTST 2026-11-11.
