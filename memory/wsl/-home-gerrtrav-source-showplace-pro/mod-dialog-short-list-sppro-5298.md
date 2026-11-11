---
name: mod-dialog-short-list-sppro-5298
description: Empty Add Modification dialog = modSearchList returned <=50 mods (Longview MODLV25 = 33 distinct); dialog only renders search; SPPRO-5298 flag ModSearchForShortModListsFeature
metadata:
  type: project
---

SPPRO-5298 (2026-11-11): Longview quotes showed an empty Add Modification dialog (heading + "Done adding modifications" only), from the mod icon and when adding a line with mods.

pro-api `modSearchList` ignores the parent SKU: it lists `orderlists` rows for `'MOD'.substr(ohmaincat,-4)` (PCABPRICELV25 → MODLV25). MODLV25 has 318 rows but only 33 distinct items (one row per price column); OV/IN/FA have 700–1000. At <=50, `AddModificationForm::addMod()` filled `$products` instead of setting `mustSearch`, and the view stopped rendering `$products` in ee10ddf37 (Dec 2025 NewSearchFeature purge). Unexplained: quote 690604 (also PCABPRICELV25) added mods via the dialog on 2026-10-15, so MODLV25 probably shrank in an early-November load (pro-api admin side, Jay).

Fix: `ModSearchForShortModListsFeature` (single toggle) always sets mustSearch; Typesense catalogs 4/5 have 135 LV mods incl. the new LV.FTB*.

**Why:** if another catalog's mod list gets trimmed, the same empty dialog will appear.
**How to apply:** for an empty mod dialog, count distinct `olitem` for the quote's MOD catalog on prod first.
