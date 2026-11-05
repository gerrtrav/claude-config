---
name: document-upload-tests-hit-frontier
description: "document-upload's .env default connection is the real Frontier DB2 library DOCUPLDEV (shared with the test server); never run its phpunit suite unless phpunit.xml forces sqlite"
metadata:
  node_type: memory
  type: project
  originSessionId: 87f8e917-f78e-41cb-ae94-83ebe555763d
  modified: 2026-10-27T21:33:22.141Z
---

On 2026-10-27 (DU-18, Laravel 12 + easi-power driver) I ran the full phpunit suite in ~/source/document-upload. phpunit.xml did not override DB_CONNECTION, so the Breeze scaffold tests' RefreshDatabase ran `migrate:fresh` on `frontier` (192.168.127.17, schema DOCUPLDEV) and easi-power's dropAllTables() dropped every base table in DOCUPLDEV (the doc-type tables etc.; views survived). DOCUPLDEV is also the test server's library. DOCUPLPRD (production) was untouched. Earlier runs on the BWI driver only failed at connect, which hid the danger.

**Why:** A test run silently destroyed shared dev data; recovery needed a person (IBM i restore or copy from DOCUPLPRD).

**How to apply:** Before running any document-upload tests, confirm phpunit.xml has `<env name="DB_CONNECTION" value="sqlite" force="true"/>` and `DB_DATABASE=:memory:` (added on branch du-18-laravel-12). In any Laravel repo, check which connection tests will use before running a suite with RefreshDatabase. See [[production-read-only-unless-approved]].
