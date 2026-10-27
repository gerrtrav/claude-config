---
name: frontier-entered-date-pricing
description: Frontier OHP entered date (OHENTM/OHENTY) drives order pricing and auto-reprices when changed; use SWPSYS040.DATES to encode it
metadata:
  node_type: memory
  type: project
  originSessionId: 64bd74f8-1d94-40ec-9d06-9bc316d928b6
  modified: 2026-10-01T14:55:01.979Z
---

Frontier prices an order from its entered date in FRNDTA040.OHP (OHENTM = MONTH_DAY, OHENTY = SHORT_YEAR; there is no entered-time field). Changing those fields makes Frontier reprice the order on its own, so no separate reprice step is needed. Encode dates through SWPSYS040.DATES. It has the same rows and encoding as the SWPSYS033.DATES that older code joins. The app's DB2 user can UPDATE FRNDTA040.OHP.

**Why:** Confirmed by the user on 2026-10-01 while planning a sync that sets the entered date to used_ship_week_capacities.created_at (skip opextension orders, newer booking wins on re-book, no backfill).

**How to apply:** Any work that touches OHENTM/OHENTY affects pricing. Log old and new values, and convert UTC timestamps to America/Chicago before deriving the date.
