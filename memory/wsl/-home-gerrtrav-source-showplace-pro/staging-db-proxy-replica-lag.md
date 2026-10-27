---
name: staging-db-proxy-replica-lag
description: Staging DB host 192.168.124.113 is a proxy splitting reads between master and a lagging replica; read-after-redirect can be stale (SPPRO-2141/5104)
metadata:
  node_type: memory
  type: project
  originSessionId: 323ec38a-d59d-49d2-8b66-1aa78b1089f0
  modified: 2026-10-22T12:57:30.383Z
---

Staging (`prodev`) `DB_HOST`/`PRO_DB_HOST` = `192.168.124.113:3306` is a proxy that load-balances reads between `pro-staging-mariadb-master` (server_id 1) and `pro-staging-mariadb-replica` (server_id 2, `read_only` OFF). A page that reads rows written by the previous request can get stale data. On 2026-10-22, 1 of 2 quote duplicates showed the wrong acknowledgement count although the rows existed. Local dev has a single DB, so this never reproduces locally.

**Why:** Explains "works locally, intermittent on staging" bugs where data was written just before a redirect or page load.

**How to apply:** For intermittent stale-read bugs on staging, check the write vs read timing (`quote_audits.occurred_at`, row `created_at`) and suspect replica lag before the code. Staging DB can be read via `ssh prodev`, sourcing `/var/www/showplace_pro_deploy/shared/.env` into `MYSQL_PWD` (never print it) and using `mysql -h "$DB_HOST" -u "$DB_USERNAME" sppro`. Server-side fix is tracked in SPPRO-5104 (unassigned, created 2026-10-22). Prod `100.81.111.113` is also ProxySQL; whether it splits reads is unconfirmed. **App-side workaround (verified 2026-10-26):** reads inside a transaction always go to the master (12/12 vs 6/12 for plain reads on new connections). SPPRO-2141 reads the ack email count via `DB::connection('mysql-pro')->transaction(...)` (`QuoteAcknowledgementEmails::readFromPrimary`); reuse that for other read-after-write bugs. Related: [[production-readonly-db]], [[staging-remote-prodev]].
