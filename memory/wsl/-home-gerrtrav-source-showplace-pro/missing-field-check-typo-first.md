---
name: missing-field-check-typo-first
description: "When code reads a field that doesn't exist on the model, look for the real column it was meant to be before calling it dead code"
metadata:
  node_type: memory
  type: feedback
  originSessionId: e31a9cdb-fb87-4e4f-ab38-938b644667a8
  modified: 2026-10-06T14:40:42.935Z
---

When code compares a field that isn't a column or accessor (e.g. `$row->orders_status == 'QT'` on `Order`), first check whether it's a typo for a real column (`order_status`) and fix the name. Don't remove the check as dead code, and don't invent a new rule (e.g. "use quote_amount if non-zero").

**Why:** On SPPRO-4797 (2026-10-06) I removed the `orders_status` check as dead code and proposed a new non-zero rule in SPPRO-4799. The user corrected me: the column was meant to be `order_status`. That meant extra commits, a rewritten ticket and updated QA instructions.

**How to apply:** Grep the model's columns and scopes for a similarly named field (e.g. `scopeHasStatuses` filters on `order_status` with values such as `QT`). If one matches, fix the reference. Ask the user if the intent is unclear.
