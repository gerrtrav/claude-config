---
name: dms-backfill-lost-files-pending
description: "SPPRO-4975 parked 2026-10-14 awaiting the user's decision on restoring 88 DMS files the Webdocs backfill deleted"
metadata:
  node_type: memory
  type: project
  originSessionId: 62b004e3-be90-4a9b-9574-c9efa786f7ca
  modified: 2026-10-14T18:50:17.780Z
---

On 2026-10-13 the prod `dms:backfill-webdocs-files` run (SPPRO-4892) deleted 88 local DMS files before uploading them. Older `request_detail_files` rows share a `path_to_file`, and `deleteLocalFile()` removed the shared file after the first row was uploaded. SPPRO-4975 (Parking Lot, linked "relates" to SPPRO-4892) holds the analysis and three options: link to the sibling's Webdocs `document_id`, re-upload under the correct row, or accept the loss.

**Why:** the user wanted to decide later; nothing on prod has been changed.

**How to apply:** if the user returns to this, read SPPRO-4975 first and wait for their chosen option. Any prod DB fix must be a transaction-wrapped script for them to run. See [[production-read-only-unless-approved]] and [[production-readonly-db]].
