---
name: accounts-table-future-spec
description: sppro.accounts table and account_view are placeholders for a future spec; ignore them when planning against sppro.account
metadata:
  node_type: memory
  type: project
  originSessionId: f5d1daef-d414-42e1-9a76-7bb72fc77afb
  modified: 2026-10-07T15:14:19.689Z
---

`sppro.accounts` (empty in prod) and the `account_view` view over it (migrations 2025_12_04_*) are groundwork for a future spec, not in use. Nothing in Laravel or pro-api reads them; the live table is `sppro.account` (`accm*` columns).

**Why:** The user said (2026-10-07) they can be ignored when planning the sales rep (`accmsm`) → `sales_representatives` ID migration.

**How to apply:** Don't treat `account_view.accmsm` (which aliases `sales_representative_id`) as a conflict or design constraint; plan against `sppro.account`. Related: [[sales-rep-id-migration-plan]]
