---
name: frontier-config-sync-production-only
description: configuration_codes / configuration_segments Frontier sync stays production-only; never propose scheduling it on staging/local
metadata:
  node_type: memory
  type: feedback
  originSessionId: 612ecc16-fd4c-45d8-851b-ef7f9fe7d83c
  modified: 2026-10-20T14:28:21.600Z
---

The nightly Frontier load of `configuration_codes` and `configuration_segments` (in the 4:00 "Submit Quotes by Cutoff Date" closure, `app.env == production`) is production-only on purpose. Staging and local are reloaded by hand (`ConfigurationCode::loadFromFrontierChunk()` via tinker) when needed.

**Why:** On 2026-10-20 (SPPRO-5091) the user said they don't want local and staging to reload these automatically.

**How to apply:** If a stale local/staging copy explains a bug, reload it by hand on request; don't propose moving the sync onto a staging/local schedule.
