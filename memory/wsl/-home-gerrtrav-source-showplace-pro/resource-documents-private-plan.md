---
name: resource-documents-private-plan
description: "SPPRO-5249 plan posted 2026-11-04 (comment 53607), not started; keep Linode volume, new private disk root on the same volume, quarantine orphans"
metadata:
  node_type: memory
  type: project
  originSessionId: f5472b6d-65e9-4a20-8f83-8132a7a6847d
  modified: 2026-11-04T13:45:25.800Z
---

SPPRO-5249 (resource documents → private storage): plan posted as comment 53607 on 2026-11-04. The user said "don't start", so the ticket stays in Parking Lot. Don't transition it or begin code until the user says go.

User decisions: keep the Linode block storage volume (prod `/mnt/pro-server-media-store`, where `storage/app/public/resource_documents` is a symlink to `showplace_pro/media/resource_documents`); quarantine orphan files (prod has about 640 files for 154 rows) in `_orphans/`, never delete them; the edit form deletes the file it replaces; the user checks access logs and the legacy docroot themselves; the user runs the sudo steps on the servers themselves (give them the exact commands). Making the 2020 catalogs private is follow-up SPPRO-5264 (Bug under SPPRO-4560, assigned to Travis, Parking Lot, linked Relates to 5249; any logged-in user may download the catalogs, auth middleware only).

Plan in short: a `resource_documents` disk whose root comes from `RESOURCE_DOCUMENTS_ROOT` (prod: `/mnt/pro-server-media-store/showplace_pro/private/resource_documents`, which needs sudo to create); downloads read both disks by the `public/` prefix; a rename-based idempotent move command with `--dry-run`/`--orphans`; `2020Catalogs` stays public (SPPRO-5162 writes there).

**Why:** the user wants the plan agreed before any work.

**How to apply:** when the user says start, follow comment 53607. No open questions remain. Related: [[catalog-2020-sharepoint-publish]], [[server-sudo-changes-shad]].
