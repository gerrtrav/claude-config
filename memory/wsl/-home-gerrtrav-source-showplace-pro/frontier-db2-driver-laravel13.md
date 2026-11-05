---
name: frontier-db2-driver-laravel13
description: bwicompanies/db2-driver is abandoned and really stops at Laravel 11 (crashes on 12 despite composer saying ^12); easi-power/laravel-db2 v14 is the Laravel 13 path (Print App already uses it)
metadata:
  node_type: memory
  type: project
  originSessionId: 48776b89-abce-4f46-9371-6309ee78db4c
  modified: 2026-10-27T19:27:33.566Z
---

As of 2026-10-27, `bwicompanies/db2-driver` (used by showplace-pro, kanban_ordering, cdc-documenation, buckets, colorselectordering, documentlookup, priceupdate, printapp locally, rework) is archived/abandoned. Its last release 1.4.0 declares Laravel 9–12 but does NOT work on any Laravel 12: since 12.0.0 `Illuminate\Database\Grammar::__construct(Connection)` is required and DB2Connection::getDefaultQueryGrammar() calls `new DB2QueryGrammar` with no args → ArgumentCountError on first query (found 2026-10-27, DU-18). So the BWI driver tops out at Laravel 11; Laravel 12 also needs easi-power (13.0.x). The Laravel 13 path is `easi-power/laravel-db2`: v12.x supports Laravel 10–11, 13.0.x supports 12, and v14.x supports 13 (PHP ^8.4). The connection driver changes from `'db2'` to `'db2_ibmi_odbc'`. Print App on staging (`ssh test`, /var/www/printapp) already runs Laravel 13 + easi-power v14.2.2 on PHP 8.5 (PRTAPP-98, branch `PRTAPP-98-laravel-upgrade`), so use it as the reference.

**Why:** The user chose to follow Print App's driver for the CDC Documentation Laravel 13 upgrade (CDCDOCS-38/41/44) instead of staying on the BWI driver.

**How to apply:** When planning a Laravel 13 upgrade for any of these apps, including showplace-pro, plan the switch to easi-power and copy Print App's config. Also see [[frontier-odbc-php85-ccsid]] for the PHP 8.5 NULL CHAR issue.
