---
name: ec-sync
description: ~/bin/ec-sync syncs electronic_catalog DB + catalog-images from app to proprod/prodev (replaces the manual Friday copy scripts)
metadata:
  node_type: memory
  type: project
  originSessionId: 111607b2-71c1-4438-907f-f59db938fb94
  modified: 2026-10-02T14:03:06.290Z
---

`~/bin/ec-sync <proprod|prodev>` (written 2026-10-02) replaces the manual Friday sync (`~/copy_electronic_catalog_to_pro_*` on WSL + the dump script on app + `sudo mysql electronic_catalog < ...` on proprod).

- app (LAN) can't reach proprod (Linode/Tailscale 100.94.240.37); WSL reaches both, so images are staged in `~/source/showplace-pro/public/storage`.
- sudo needs a password on app/proprod/prodev, so the script uses an `ec_sync` MySQL user with creds in `~/.ec-sync.cnf` on each host, created by `ec-sync --setup <host> source|target` (interactive sudo).
- Target backups: `~/ec-sync-backups` on the target (last 7). Logs: `~/logs/ec-sync`.
- Setup done on app + proprod 2026-10-02; full runs to proprod on 2026-10-02 and 2026-10-09 (10-09 row counts matched app).
- User wants it nightly (Friday-only cadence isn't required). Long-term plan: Tailscale on app so proprod can pull via its own cron.

**Why:** Make the weekly catalog sync hands-off.
**How to apply:** Change sync behavior in `~/bin/ec-sync`; see [[kanban-deploy]] for the similar app-server deploy setup.
