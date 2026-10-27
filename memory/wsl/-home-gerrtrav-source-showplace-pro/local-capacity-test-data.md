---
name: local-capacity-test-data
description: The local dev DB has no ship week capacity headers or scheduled quotes; seed them by hand to browser-test capacity bugs
metadata:
  node_type: memory
  type: project
  originSessionId: ff834557-c0d1-4cf9-b6db-1f0166e2a958
  modified: 2026-10-01T14:38:36.345Z
---

As of 2026-10-01 the local showplace-pro dev database had zero `ship_week_capacity_headers` and zero `used_ship_week_capacities` rows, so no quote was scheduled and capacity couldn't be seen in the browser out of the box.

**Why:** browser-checking a capacity fix (SPPRO-4691) needed a scheduled quote in a full week.

**How to apply:** insert a future-Monday Normal Production header (`ship_week_capacity_type_id` 1, plant matching the quote's `shipping_plant`) and a `used_ship_week_capacities` row for a throwaway quote via tinker on `mysql-pro`. That alone makes the quote show as "Scheduled". Read used/total with `ShipWeekCapacityHeader::getTotalsForShipWeek($date, $plantId, null, [$state], 1)`, then delete the seeded rows afterwards. Local quotes have null `ohcabcount`; `cabinet_count` is computed from the cabinet lines. See [[local-login-superadmin]].
