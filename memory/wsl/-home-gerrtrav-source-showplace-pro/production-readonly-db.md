---
name: production-readonly-db
description: "How to query the production DB read-only (host, user, password env var, which client to use)"
metadata:
  node_type: memory
  type: reference
  originSessionId: 9b2a9063-247e-4701-a5f7-a637494f5fd3
  modified: 2026-10-06T15:15:47.555Z
---

Production read-only DB access (set up 2026-10-06):

- Host `100.94.240.37` port 3306, user `readonly_claude`, password in `$PROD_RO_DB_PASSWORD` (from `.claude/settings.local.json` env; never print it).
- Do NOT use `100.81.111.113`: it's a ProxySQL front end that rejects this user.
- No mysql client on the WSL host; use the Sail container's client and pass the password by reference:
  `docker compose exec -T -e MYSQL_PWD="$PROD_RO_DB_PASSWORD" mariadb mariadb -h 100.94.240.37 -u readonly_claude sppro < query.sql`
- Grants: SELECT/SHOW VIEW on `sppro` (the `mysql-pro` connection: `mainorder`, `quote_audits`, `used_ship_week_capacities`, ...), `dms`, `electronic_catalog`.
- `quote_audits.quote_id` = `mainorder.moorder`; filtering by `actor_user_id` + time window reveals batches scheduled together.

Related: [[staging-dealer-login]]
