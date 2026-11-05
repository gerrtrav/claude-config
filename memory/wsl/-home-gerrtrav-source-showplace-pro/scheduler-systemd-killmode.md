---
name: scheduler-systemd-killmode
description: "Server scheduler is systemd oneshot laravel-schedule.service with KillMode=control-group, which kills runInBackground() tasks; SPPRO-5205 needs a KillMode=process drop-in"
metadata:
  node_type: memory
  type: project
  originSessionId: 5652c6de-20bb-4492-9e13-5a0fbfad6be6
  modified: 2026-10-30T14:16:09.773Z
---

Both proprod and prodev run `artisan schedule:run` from `laravel-schedule.timer` (minutely) starting `laravel-schedule.service` (Type=oneshot, no drop-ins as of 2026-10-30). With the default KillMode=control-group, systemd kills anything `runInBackground()` spawns as soon as schedule:run exits (verified locally with systemd-run: only the KillMode=process child survived). Laravel also refuses `runInBackground()` on `Schedule::call` closures.

SPPRO-5205 (pushed to prodev/origin 2026-10-30, Done; prod gets it with the next release tag) moved the long tasks into commands (`frontier:load-orders`, `frontier:load-invoices`, `quotes:submit-by-cutoff-date`, `frontier:sync-door-styles-and-finishes`, plus the existing config-codes sync) and runs them in the background only when `FEATURE_SCHEDULER_BACKGROUND_TASKS_ENABLED` is on (default off).

Live on prod since release-261030-2 (2026-11-02 08:55, Jira version 10184): at 09:00 frontier:load-orders ran in the background and the every-minute task kept running each minute.

Status 2026-10-30: the user installed the drop-in `/etc/systemd/system/laravel-schedule.service.d/keep-background-tasks.conf` on both servers, and the flag is true in both shared .env files.

**How to apply:** enable that flag on a server only after its unit has a `[Service] KillMode=process` drop-in, which needs sudo (see [[server-sudo-changes-shad]]). Any new `runInBackground()` task has the same constraint.
