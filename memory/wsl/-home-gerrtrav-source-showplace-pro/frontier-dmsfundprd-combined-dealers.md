---
name: frontier-dmsfundprd-combined-dealers
description: "Combined DMS dealers live in Frontier library DMSFUNDPRD.COMBINE_DEALERS (COMBI00001, FROM_DEALER→TO_DEALER); not in the app code"
metadata:
  type: reference
---

"Combined DMS dealers" = Frontier table `DMSFUNDPRD.COMBINE_DEALERS` (system name `COMBI00001`, columns FROM_DEALER, TO_DEALER). The SPPROPROD `SALES_BY_CUSTOMER` views join it to roll a dealer's sales into its parent for DMS accrual. Names: join `FRNDTA040.CM1P` on C1STKY (CAST CMNAME ... CCSID 1208, see [[frontier-odbc-php85-ccsid]]). Query via `sail artisan tinker` on the `frontier` connection (local .env user can read DMSFUNDPRD).

DMSFUNDPRD also has EXCLUDED_DEALERS, CUSTOMERS, BALANCES, REP_GROUPS, CUSTOMER_PERCENT_EXCEPTIONS, etc. Separate from the ShowplacePro exclusion list `sppro.dms_enrollment_excluded_dealers`.

On 2026-10-26 the user asked for "combined dms dealers" and I wrongly searched the app/MariaDB first; the user had to point to Frontier.
