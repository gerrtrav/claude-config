---
name: frontier-display-pricing-key-dd
description: Display orders are priced via a "DD" suffix on the Frontier order header pricing key OHP.OHPRKY (e.g. 466DD), not on the account's accmprky
metadata:
  type: project
---

A display order gets the display discount when Frontier's order-header pricing key `FRNDTA040.OHP.OHPRKY` contains "DD" (regular key + suffix, e.g. `466` → `466DD`). The account's `sppro.account.accmprky` (Frontier CMPRKY) never contains DD; the user corrected me when I looked there. The SPPROTST `INVOICED_DISPLAY_ORDERS` view uses the same rule on `SFPRKY LIKE '%DD%'`. The `ORDERS` view doesn't expose OHPRKY, so the app reads OHP directly (`App\Services\FrontierOrderPricingKeyService`, SPPRO-257).

**Why:** SPPRO-257's ticket says "cmprky", but it means the order's pricing key.
**How to apply:** For "is this display order processed/priced as display", check OHPRKY on the order, never accmprky.
