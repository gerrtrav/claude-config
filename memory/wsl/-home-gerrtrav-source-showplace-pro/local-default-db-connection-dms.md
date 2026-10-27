---
name: local-default-db-connection-dms
description: Local default DB connection was dms (last DB_CONNECTION line wins) until 2026-10-15; now mysql-pro like prod, migrations table moved to sppro
metadata:
  type: project
---

`.env` files have several `DB_CONNECTION=` lines, and dotenv keeps the **last** one. The old `.env.example` ended with `dms`, so local setups defaulted to `dms` while prod uses `mysql-pro`. SPPRO-5013 fixed the example. On 2026-10-15 the user's local setup was switched as well: the 118 `dms.migrations` rows were copied into `sppro.migrations` (which had replaced its 5 stale rows), `dms.dms_faqs` was copied to `sppro.dms_faqs` (that's where prod has it), and the extra `DB_CONNECTION` lines in the local `.env` were commented out. The old `dms.migrations` and `dms.dms_faqs` were left in place as leftovers.

**Why:** Any other developer's local setup made from the old example still defaults to `dms`. Switching it without moving the migrations rows makes `migrate` try to re-run about 113 migrations. Migrations with no explicit connection (e.g. `create_dms_faqs_table`) created their tables in `dms` locally, but in `sppro` on prod.

**How to apply:** If another developer hits this, repeat the same moves: back up, copy the migrations rows and any default-connection tables that sit in `dms` locally but in `sppro` on prod, then edit `.env`. See [[production-readonly-db]].
