---
name: staging-db-proxy-replica-lag
description: Staging DB host 192.168.124.113 is a proxy splitting reads between master and a lagging replica; read-after-redirect can be stale (SPPRO-2141/5104)
metadata:
  node_type: memory
  type: project
  originSessionId: 323ec38a-d59d-49d2-8b66-1aa78b1089f0
  modified: 2026-10-22T12:57:30.383Z
---

Staging (`prodev`) `DB_HOST`/`PRO_DB_HOST` = `192.168.124.113:3306` is a proxy that load-balances reads between `pro-staging-mariadb-master` (server_id 1) and `pro-staging-mariadb-replica` (server_id 2). A page that reads rows written by the previous request can get stale data. On 2026-10-22, 1 of 2 quote duplicates showed the wrong acknowledgement count although the rows existed. Local dev has a single DB, so this never reproduces locally.

**Why:** Explains "works locally, intermittent on staging" bugs where data was written just before a redirect or page load.

**How to apply:** For intermittent stale-read bugs on staging, check the write vs read timing (`quote_audits.occurred_at`, row `created_at`) and suspect replica lag before the code. Staging DB can be read via `ssh prodev`, sourcing `/var/www/showplace_pro_deploy/shared/.env` into `MYSQL_PWD` (never print it) and using `mysql -h "$DB_HOST" -u "$DB_USERNAME" sppro`. Server-side fix is SPPRO-5104 (Shad Kaske). **Staging fixed 2026-10-28:** ProxySQL rule 2 (`^SELECT`→HG 1) deactivated; only `tableau_bridge`/`airflow` SELECTs go to the replica, so app/pro-api reads on staging now hit the master. Prod still splits reads until Phase 2 (after staging QA soak + master headroom check). Replica `read_only` is actually ON (the 10-22 OFF reading came from the master). Prod `100.81.111.113` is also ProxySQL and splits reads the same way (user confirmed 2026-10-28), so read-after-write bugs hit prod too. pro-api (`2020/includes/includes.php` `$sppro`) connects through the proxy as well: lineConfigure reads back the line it just inserted to find moprodtype, so warranty fields can be skipped (SPPRO-5195 / ITHD-3533). **App-side workaround (verified 2026-10-26):** reads inside a transaction always go to the master (12/12 vs 6/12 for plain reads on new connections). SPPRO-2141 reads the ack email count via `DB::connection('mysql-pro')->transaction(...)` (`QuoteAcknowledgementEmails::readFromPrimary`); reuse that for other read-after-write bugs. Related: [[production-readonly-db]], [[staging-remote-prodev]].
