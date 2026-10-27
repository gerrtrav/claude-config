---
name: frontier-odbc-php85-ccsid
description: Under PHP 8.5 (staging) the IBM i ODBC driver returns NULL for Frontier CHAR values with chars like NBSP; CAST(... CCSID 1208) fixes it
metadata:
  type: project
---

On prodev (PHP 8.5.11) `pdo_odbc` reading Frontier returns NULL for CHAR values containing characters such as a non-breaking space (EBCDIC 0x41), e.g. 24 `FRNDTA040.CFP.CFCNFG` GLOBAL codes. PHP 8.2 (production, local Sail) returns them fine. Fix: select `CAST(col AS VARCHAR(n) CCSID 1208)` so the IBM i converts to UTF-8; it was byte-identical under 8.2 (SPPRO-5091, 2026-10-20).

**Why:** found when the configuration code sync failed only on staging with "Column cannot be null".

**How to apply:** any Frontier read of free-text CHAR columns that must work on staging (or on production after it moves to PHP 8.5) should cast to CCSID 1208, and code must not assume a NULL from Frontier means the value is empty. See [[deploy-scripts-locations]].
