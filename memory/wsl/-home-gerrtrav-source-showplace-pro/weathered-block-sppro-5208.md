---
name: weathered-block-sppro-5208
description: "SPPRO-5208 Weathered offered on all doors = pro-api 4783f554 dropped the Weathered fallback block; temp prod patch includes Sarah's list changes"
metadata:
  node_type: memory
  type: project
  originSessionId: d000b388-d351-4c55-adae-249504141ee7
  modified: 2026-10-28T14:37:29.752Z
---

SPPRO-5208 (2026-10-28): Weathered showed on every door style. Cause: pro-api commit 4783f554 (2026-05-29, "Removed block on Weathered for Pendleton SP 275") deleted `elseif($special['special'] == 'Weathered') { $skipSp = true; ... }` from the multi-row loop of 2020/jsonBase/orderEntry/globals.php. It also removed Pendleton SP 275 from the allowed list, which is the opposite of what the message says. The ITHD-1535 mitered change was not the cause.

The user asked for a temporary patch to apply in prod (/var/www/pro on proprod, which matched pro-api origin/develop). Patch: scratchpad SPPRO-5208-pro-api-weathered.patch. Sarah answered (comment 53125): add Pendleton SP 275 and Vienna D RWO; remove Pendleton SPW (discontinued) and Vienna D Walnut; Longview offers no Weathered (pro-api already skips specialty finishes for Longview). The patch was updated to include the list changes.

App copy (OrderGlobalsResolver::specialtyFinishField, print path) fixed in 36c28baca, pushed to prodev + origin 2026-10-28. The user applied the prod pro-api patch; Sarah is testing it. Permanent pro-api fix handed to Jay (Nathaniel) in comment 53147. Prod patch: patch can't write in /var/www/pro dirs (owned by jaylee); patch a copy in ~ and `cat >` it over the file (group www-data writable). Sarah confirmed the prod fix (comment 53156). Ticket assigned to Jay (still In Progress) for the pro-api develop commit; QA hand-off is his or the user's call. Test gotcha: Aspen is dsmitered=Y, so use Pendleton SP as the non-whitelisted door.

Jay is out until about 2026-11-04, so the permanent pro-api fix waits until he is back. Per the user (2026-10-28), this ticket stays In Progress and does not hold up the next app release, because the temporary prod patch lives in /var/www/pro, outside the app release folders.
The app-side commit 36c28baca (print globals) is safe to release because quote printing is behind a flag that is off in production (user, 2026-10-28).
