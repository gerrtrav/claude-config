---
name: production-log-rotation
description: "Production log rotation is handled by system-level logrotate, so do not switch Laravel logging to the daily channel"
metadata:
  node_type: memory
  pinned: false
  originSessionId: 0e3eea03-3d70-4250-bc16-2af1dfcc0168
  modified: 2026-09-23T13:57:48.761Z
---

The showplace-pro production server rotates `storage/logs/laravel.log` with a system-level logrotate configuration. Because of that, do not recommend or implement switching Laravel's log stack to the `daily` channel (`LOG_STACK=daily`) or adding `LOG_DAILY_DAYS`, even when a Jira ticket suggests it as a way to rotate logs. The user corrected this while working on a ticket about excessive debug logging. Log-volume problems should instead be addressed by lowering `LOG_LEVEL` and by trimming what the code logs.

Exception (SPPRO-4874, 2026-10-08): for the fail2ban `storage/logs/auth.log`, the user asked for Laravel to handle rotation with a sensible retention. It is rotated in place by the scheduled `logs:rotate-auth` command (keeps `LOG_AUTH_DAYS`, default 14), not the `daily` driver, because fail2ban needs a fixed file name. laravel.log is still left to system logrotate.
