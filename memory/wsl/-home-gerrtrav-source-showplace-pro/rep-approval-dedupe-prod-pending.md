---
name: rep-approval-dedupe-prod-pending
description: SPPRO-5267 prod release needs the rep_approvals/rep_personal duplicate cleanup script run by a person after deploy; staging done 2026-11-05
metadata:
  type: project
---

SPPRO-5267: `MainOrder::setShipWeek()` used to add an approval row on every schedule, so rescheduled display/personal quotes had duplicate `rep_approvals` / `rep_personal` rows and got stuck on the Displays "Awaiting Review" list. The code fix is 926e804a4, which reuses the existing row and keeps its decision (the user didn't choose; that's my default).

The cleanup script is attached to SPPRO-5267 (attachment 32198, with run steps in comment 53776) and also saved next to this memory as `sppro-5267-dedupe-rep-approvals.sql.txt`. It previews, deletes inside a transaction and ends in ROLLBACK; switch that to COMMIT to apply. It keeps the decided row, else the latest decision, else the lowest raid. On staging it was run with COMMIT on 2026-11-05 at the user's request: deleted 39 display + 26 personal rows, 0 duplicates left.

**Production is still pending.** On 2026-11-05 it would have deleted 71 display + 3 personal rows. It must run only AFTER the release that contains 926e804a4. Per org policy a person runs it on prod, never me; give the user the commands. Remind the user when SPPRO-5267 is released.

Separate open item: Sawyer reported some rows only leave the list after a page refresh. I couldn't reproduce it locally; QA was asked for the quote number, type and submitted state. Related: [[release-announcement-email]], [[production-read-only-unless-approved]].
