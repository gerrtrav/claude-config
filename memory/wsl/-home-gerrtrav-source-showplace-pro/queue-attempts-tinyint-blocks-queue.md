---
name: queue-attempts-tinyint-blocks-queue
description: A database-queue job released past 255 attempts blocks the whole default queue (SPPRO-5277); symptom = background globals save never finishes
metadata:
  node_type: memory
  type: project
  originSessionId: 5fce1d51-eb28-4701-b9be-291a320bea4a
  modified: 2026-11-09T15:07:14.420Z
---

Staging and prod use `QUEUE_CONNECTION=database`; `jobs.attempts` is `tinyint unsigned`. A release re-inserts the job (new id) and keeps its attempt count. When the count reaches 255, every worker fails to reserve it (`Out of range value for column 'attempts'`, logged many times a second). It's the oldest row, so it blocks every later job on that queue. On 2026-11-09 two `SendRepPersonalToBucketsJob` rows did this on staging and SaveGlobalsJob hung ("Saving your globals" forever). Fixed in code with `App\Jobs\Concerns\WaitsForFrontierOrderNumber`: 15-minute rechecks for 12 hours, then hourly, and the job fails itself at 250 attempts. Staging was unblocked by `UPDATE jobs SET attempts = 0` on the two rows, with the user's OK.

**Why:** the symptom shows up in an unrelated feature (globals save, change uploads), not in the job that causes it.

**How to apply:** if queued work stops on staging or prod, check `jobs` for high `attempts` and grep laravel.log for "Out of range value for column 'attempts'" before debugging the stuck feature. Any new self-releasing job must stay under 255 attempts. Related: [[staging-db-proxy-replica-lag]].
