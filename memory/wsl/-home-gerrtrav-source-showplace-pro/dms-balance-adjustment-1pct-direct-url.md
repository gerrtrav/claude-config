---
name: dms-balance-adjustment-1pct-direct-url
description: 1% (program 2) dealers have no Submit Request button; balance adjustments for them are made via /dms/create/{account} directly
metadata:
  type: project
---

The DMS page only shows "Submit Request" for 2% (program 1) dealers (`resources/views/livewire/dms/transaction-list.blade.php`, `@if($program == 1)`). For 1% dealers the request form, and so the Balance Adjustment line (media type 10001, shown only to Super Administrator / Marketing roles in `AddLineItemForm::mediaTypes()`), is reached only by typing `/dms/create/{account}`. Route access is `AccountPolicy::createDmsRequest` (Create Dms Request/Voucher For Any Account etc.).

**Why:** On 2026-10-27 QA (Sawyer DeWitt) blocked SPPRO-3005 thinking only the user could make 1% balance adjustments; Sawyer already had Super Administrator on staging and just lacked the button.

**How to apply:** When someone "can't" make a 1% balance adjustment, check for the missing button before changing roles/permissions.
