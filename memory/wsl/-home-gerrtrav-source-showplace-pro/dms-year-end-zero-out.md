---
name: dms-year-end-zero-out
description: SPPRO-5222 Jan 1 DMS zero-out fix live in prod (release-261030, 2026-10-30), env set both servers; 2025 run was wrong (request_details mismatch, no ticket)
metadata:
  type: project
---

SPPRO-5222 (2026-10-30): `Account::zeroOutBalances($year, $only = [])` now uses $year for starting/pending/approved, dates entries $year-12-31 23:59:59, one dms transaction per account, skips accounts already zeroed (same description) and signs with `DMS_YEAR_END_USER_EMAIL` (throws before writes if unset/missing). Landed on master 11b87d629, pushed origin + prodev, ticket Ready for QA.

10-30: user added DMS_YEAR_END_USER_EMAIL on prodev and proprod. Ran it on staging for QA (BA9120, FO8330, AM8477 zeroed; excluded AC2726 skipped; re-run 0), dealers listed on the ticket. Ticket moved to Done (no QA, user 10-30). Shipped to production in release-261030 (2026-10-30), so the 2027-01-01 run uses the fixed code.

Past data: the Jan 1 2026 run (year 2025) used 2024 starting balances. On 2026-03-13 `updateBalanceAdjustmentsFor2025` corrected 710 dms_transactions credit_amounts, but the linked request_details approved_amount/credit_amount still hold the old wrong amounts (710 of 711 differ). User chose no ticket (2026-10-30); do not raise it again unless asked.

**Why:** deadline-bound; easy to forget the server env step.
**How to apply:** if the Jan 1 2027 run is questioned, the fix is live; mention the request_details mismatch if 2025 DMS reports come up. See [[release-tag-naming]].
