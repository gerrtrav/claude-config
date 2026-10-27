---
name: jira-finish-to-qa
description: "When work on a showplace-pro Jira ticket is finished and merged, add QA instructions and move it to Quality Audit instead of closing it"
metadata:
  node_type: memory
  pinned: false
  originSessionId: bef6db53-cf89-49a6-8973-9d1b327ab482
  modified: 2026-10-13T14:56:23.249Z
---

When the work on a showplace-pro (SPPRO) Jira ticket is finished and merged, do not transition the parent ticket to Done, even if the user says "close" it. The user corrected this after a finished parent ticket was moved straight to Done: merged work is verified in QA before it is closed.

Instead, add a comment headed **QA instructions**, written for a tester rather than a developer, as a general overview of what to test rather than exact steps (see [[qa-instructions-general-overview]]): a short summary of what changed and what should (or should not) look different, then the areas/scenarios to cover and what to expect, plus things that should still work as before. Don't write click-by-click steps, exact data setup or long numbered check sections (that older SPPRO-4578 shape was too exact).

Before posting the QA instructions, the code must be deployed to staging: land it on `master` and `git push prodev master` (and push origin) first, since QA tests on staging (user rule, 2026-10-07). See [[staging-remote-prodev]].

Then move the ticket to the QA status, which in this Jira workflow is named "Quality Audit". From In Progress the normal path is "Submit for Review" (Code Review) and then on to Quality Audit; on SPPRO-4662 (2026-09-29) In Progress also offered a direct "Ready for QA" transition (id 491) to Quality Audit, so check the available transitions first. SPPRO-4667, SPPRO-4668 (2026-09-30), SPPRO-4689, SPPRO-4643, SPPRO-4693, SPPRO-4694 (2026-10-01), SPPRO-4680 (2026-10-02) Bug SPPRO-4690 (2026-10-05) Bug SPPRO-4774 and Bug SPPRO-4775 (2026-10-05), Bug SPPRO-4780, Bug SPPRO-4782, Bug SPPRO-4797 and Bug SPPRO-4806 (2026-10-06), Bug SPPRO-4827, Bug SPPRO-4846, Bug SPPRO-4850, Bug SPPRO-4851, Bug SPPRO-4854 and Bug SPPRO-4848 (2026-10-07), Bug SPPRO-4855, Bug SPPRO-4876, Bug SPPRO-4878, Bug SPPRO-4879, Bug SPPRO-4877 and Bug SPPRO-4882 (2026-10-08), Bug SPPRO-4885 (2026-10-09), Bug SPPRO-4901 and Bug SPPRO-4911 (2026-10-13), Bug SPPRO-4929 (2026-10-14, entered via Followed Up → Hotfix → Start Work) also offered "Ready for QA" (id 491) directly from In Progress. On SPPRO-4548 (2026-09-30) In Progress offered only "Submit for Review" (id 721) to Code Review, and from there "Passed Code Review" (id 491) to Quality Audit. Improvements SPPRO-4591, SPPRO-4777, SPPRO-4778 (2026-10-05) SPPRO-4779, SPPRO-4796, SPPRO-4800, SPPRO-4781, SPPRO-4801, SPPRO-4590, SPPRO-4589, SPPRO-4588 and SPPRO-4587 (2026-10-06), SPPRO-4586, SPPRO-4834, SPPRO-4836, SPPRO-4845, SPPRO-4856 (2026-10-07) also offered only Submit for Review (721) → Passed Code Review (491). On Task SPPRO-4760 (2026-10-05) In Progress offered no "Ready for QA"; it offered "Hotfix" (id 851) straight to Quality Audit, but the Submit for Review (721) → Passed Code Review (491) path was used instead, since "Hotfix" was only approved for leaving Parking Lot. Task SPPRO-4874 (2026-10-08, entered In Progress via "In Progress (1)" id 3) offered neither 491 nor 721 from In Progress; its only route was "Send to QA" (id 851) straight to Quality Audit, which was used. Improvement SPPRO-4585 (2026-10-08, also entered via "In Progress (1)" id 3, from Triage) likewise offered only "Send to QA" (851), which was used. Improvement SPPRO-4584 (2026-10-08, Triage → "In Progress (1)" id 3) also used "Send to QA" (851); its sub-tasks went To Do → In Progress via "Start Work" (id 5). Improvement SPPRO-4582 (2026-10-09, Triage → "In Progress (1)" id 3) also used "Send to QA" (851); its four sub-tasks went To Do → In Progress via "Start Work" (id 5) and to Done via id 3. Improvement SPPRO-3588 (2026-10-09) and Improvement SPPRO-4894 and Improvements SPPRO-4794, SPPRO-4793, SPPRO-4792, SPPRO-4791, SPPRO-4790, SPPRO-4789, SPPRO-4788, SPPRO-4787, SPPRO-4786, SPPRO-4785, SPPRO-4784 and SPPRO-4783 (2026-10-12, flag removals the user chose to send to QA), Improvement SPPRO-4900, Improvement SPPRO-4897, Improvement SPPRO-4896, Improvement SPPRO-4902 and Improvement SPPRO-4904 (2026-10-12), all Parking Lot → "In Progress (1)" id 3 directly, also used "Send to QA" (851). Improvement SPPRO-4594 (2026-10-13, Triage → "In Progress (1)" id 3) also used "Send to QA" (851); its sub-tasks SPPRO-4633/4634 went To Do → "Start Work" (5) → Done via id 3. Improvement SPPRO-4595 (2026-10-12, Triage → "In Progress (1)" id 3) also used "Send to QA" (851); its sub-tasks SPPRO-4635/4636/4637 went To Do → "Start Work" (5) → Done via id 3. Improvement SPPRO-4583 (2026-10-08, Triage → "In Progress (1)" id 3) also used "Send to QA" (851); its sub-tasks offered "Start Work" (5) at first, but once one had moved, the others offered only "Mark as Done" (id 3, straight from To Do), which closed them. List transitions with executeRead `listJiraIssueTransitions`. Sub-tasks under the parent can be moved to Done once their code is merged, since QA happens on the parent. Sub-tasks use a different workflow from parents: from In Progress the Done transition is named "Go Directly to Jail" (id 3; id 591 is rejected), the other option being "Send to Review" (id 6) (SPPRO-4615/4616/4617, 2026-10-05). A sub-task's own branch may be named after its parent (e.g. branch sppro-4581 held sub-tasks 4616/4617), and a branch named after a sub-task (sppro-4615) means the QA comment and Quality Audit move go on its parent (SPPRO-4580) once all sibling sub-tasks are merged.

If the user explicitly asks for Done after the ticket is already in Quality Audit, do it: on SPPRO-4697 (2026-10-01) they asked to push master and move the ticket to Done right after it went to QA (transition "Done", id 591, applied with no extra fields). Same on SPPRO-4796 (2026-10-06, a feature-flag removal): "No need for QA. move it to done." Done left the ticket assigned to the QA tester that Quality Audit had auto-assigned; the user wanted it reassigned to themselves afterwards, so when skipping QA, reassign to the user after moving to Done. SPPRO-4795 (2026-10-06, also a flag rollout, even though it changed dealer login behavior) was likewise sent straight to Done from In Progress (id 591) with a short developer-facing comment listing the changes and post-deploy steps (pennant:purge, remove env lines). For these feature-flag rollout tickets, still ask QA vs Done rather than assuming. Bug SPPRO-4833 (2026-10-07, a scheduler-only change moving a Frontier sync out of the 11pm-4am maintenance window) also skipped QA at the user's request: short developer-facing comment, then Done (591) straight from In Progress; it stayed assigned to the user. Moving to Quality Audit auto-reassigned the ticket to the QA tester.

If part of the ticket is still unfinished (for example waiting on production data), the user prefers to move the unfinished part to a new follow-up SPPRO ticket (same parent epic, linked with "Relates") and send the parent to Quality Audit with QA instructions covering only what's merged, rather than holding the ticket or adding sub-tasks (chosen on SPPRO-4654 → SPPRO-4666, 2026-09-30). Creating an SPPRO issue requires the "Update Type" field (`customfield_10051`, e.g. `{"id": "10022"}` for Release Update); copy the value from the original ticket (e.g. `{"id": "10137"}` for Hotfix, used for SPPRO-4746/4747 on 2026-10-02).

That split isn't automatic: on SPPRO-4548 (2026-10-01), with QA's slowness report still open, the user chose to send the ticket to Quality Audit with QA instructions covering only the merged loading-screen fix, and no follow-up ticket. When part of the work is unfinished, ask which they want.

On SPPRO-4694 (2026-10-01) the ticket also reported an unrelated scheduling error (ship-week dropdown missing on first try) that the fix didn't cover; the user chose QA only, no follow-up ticket, with a one-line "Not covered here" note at the end of the QA instructions. Still ask each time.

Improvement SPPRO-4593 (2026-10-13, migrations adding DB indexes only, no behavior change): after it was sent to Quality Audit, the user said "This ticket does not need to go to QA. mark it done." From Quality Audit, "Done" (591) worked; then reassigned to the user. For pure index/performance-only migrations, ask QA vs Done before sending to QA.

Exception for tickets with no code change (pure data/ops requests, e.g. resetting staging passwords on SPPRO-4776, 2026-10-05): the user chose to skip Quality Audit, post a short developer-facing comment saying what was done, and move straight to Done (transition "Done", id 591, from In Progress, no extra fields). Don't put requested passwords in the comment.

Improvement SPPRO-4592 (2026-10-13, a timeout-default change; most of the ticket was already done by earlier tickets): after I asked QA vs Done, the user said "No need for QA, move it to done and close the subtasks." Parent went In Progress → Done (591) with a developer-facing comment; sub-tasks went To Do → "Start Work" (5) → Done (id 3), with a note on the sub-task explaining why the remaining work wasn't needed. master was not pushed, because the user didn't ask for it.

New Feature SPPRO-4318 (2026-10-14, Parking Lot → "In Progress (1)" id 3) also used "Send to QA" (851); it stayed assigned to Nathaniel Lee (no auto-reassign to the QA tester).

Bug SPPRO-4976 (2026-10-14, entered via 651 → 721 → 181) also used "Ready for QA" (491) from In Progress. Its prodev push was first rejected because a teammate had pushed SPPRO-4812; fetch, rebase master onto origin/master, rerun the affected tests, then push.

Bug SPPRO-4977 (2026-10-14, entered via 651 → 721 → 181) also used "Ready for QA" (491) from In Progress; it stayed unassigned (no auto-reassign to the QA tester).

Bug SPPRO-4978 (2026-10-14, entered via 651 → 721 → 181) also used "Ready for QA" (491) from In Progress.

Bug SPPRO-4980 (2026-10-14, entered via 651 → 721 → 181) also used "Ready for QA" (491) from In Progress; it stayed unassigned.

Bug SPPRO-4797 (2026-10-14, QA bounced it back to status "Problem"; "In Progress" by name was rejected, used "Start Work" id 181) then "Ready for QA" (491) after the fix was pushed.

Task SPPRO-4987 (2026-10-15, Parking Lot → id 3 directly) also used "Send to QA" (851) from In Progress.

Task SPPRO-4987 (2026-10-15, PHP 8.5 config deprecation fix): after it went to Quality Audit (auto-assigned to the QA tester), the user said "move sppro-4987 to done"; Done (591) from Quality Audit, then reassigned to the user. Config-only/no-behavior-change fixes like this one may not need QA; consider asking QA vs Done first.

Task SPPRO-4988 (2026-10-15, Parking Lot → id 3 "Fast-track") also used "Send to QA" (851) from In Progress; it stayed unassigned.

Story SPPRO-4684 (2026-10-15, Parking Lot → id 3) used "Send to QA" (851) from In Progress; the target status is now named "Ready for QA" (id 10074), not "Quality Audit". It stayed unassigned. No TT ticket mirrored it.

Bug SPPRO-5005 (2026-10-15, entered via 651 → 721 → 181): "Ready for QA" (491) from In Progress now lands in a status named **"Ready for QA"** (id 10074), not Quality Audit. From there the only onward transitions are "Start QA" (7, the tester's step → QA In Progress), Done (591) and Parking Lot (4), so Ready for QA is the correct hand-off; leave it there.

Improvement SPPRO-5060 (2026-10-15, Parking Lot → id 3 directly) used "Send to QA" (851) → "Ready for QA"; stayed unassigned. QA comment included a "Production deploy step (developer)" section for the one-off artisan command.

Bug SPPRO-5006 (2026-10-15, entered via 651 → 721 → 181): "Ready for QA" (491) → status Ready for QA; stayed unassigned. Priority "P2 - High" (id 10001) set via editJiraIssue fields {"priority":{"name":"P2 - High"}}.

Bug SPPRO-2141 (2026-10-15, came back from Problem via 4 → 651 → 721 → 181): "Send to QA" (491) from In Progress → Ready for QA; stayed assigned to the user.

Bug SPPRO-3807 (2026-10-15, came back from Problem via 4 → 651 → 721 → 181): "Ready for QA" (491) from In Progress → Ready for QA; stayed assigned to the user.

Bug SPPRO-3463 (2026-10-15, Parking Lot → 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user (assigned via editJiraIssue fields {"assignee":{"accountId":...}} before).

Bug SPPRO-5062 (2026-10-19, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Bug SPPRO-4333 (2026-10-19, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5064 (2026-10-19, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Improvement SPPRO-5069 (2026-10-19, Parking Lot → id 3 directly): "Send to QA" (851) → Ready for QA; stayed assigned to the user. No TT mirror.

Task SPPRO-1930 (2026-10-20, Parking Lot → id 3 directly): "Send to QA" (851) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5089 (2026-10-20, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5090 (2026-10-20, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5091 (2026-10-20, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user. Before pushing, origin had 2 new teammate commits: rebased master onto origin/master (hashes in earlier ticket comments changed), reran affected tests, then pushed prodev + origin.

Bug SPPRO-5070 (2026-10-20, second round after QA found the cabcount field hidden; ticket was In Progress): "Send to QA" (491) → Ready for QA; stayed assigned to the user. Pushed from a worktree (rebased onto origin/master, pushed HEAD:master) because master is checked out in the main checkout.

New Feature SPPRO-3471 (2026-10-20, Triage → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user. No TT mirror.

New Feature SPPRO-4518 (2026-10-20, Parking Lot → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user. No TT mirror.

When landing after a rebase that picked up a teammate migration, run `sail artisan migrate` before rerunning tests (else every DB test fails with "pending migrations"). Never chain `artisan test | tail && git push`: the pipe hides the test exit code, so the push runs even when tests fail (happened on SPPRO-4518; the failure was only the unrun migration).

Improvement SPPRO-288 (2026-10-20, Parking Lot → id 3 "Fast-track"): In Progress offered "Send to QA" (851), which now lands in a status named "Ready for QA" (id 10074), not "Quality Audit"; ticket stayed assigned to the user.

Story SPPRO-503 (2026-10-20, Triage → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user.

New Feature SPPRO-257 (2026-10-20, Parking Lot → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user. User wanted the new report off in production: prod .env has no toggle and the flag defaults off, so no prod change was needed; staging got FEATURE_..._ENABLED=true.

New Feature SPPRO-960 (2026-10-20, Parking Lot → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5093 (2026-10-20, id 3 rejected from Parking Lot; entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.

Improvement SPPRO-2095 (2026-10-20, Parking Lot → id 3): "Send to QA" (851) → Ready for QA; stayed assigned to the user.

Bug SPPRO-5094 (2026-10-21, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user. Its data-side follow-up (why the API sent no choices) went to Task SPPRO-5095 for Nathaniel Lee (accountId 5aeb1c31d5c9632c3013ceaf), linked Relates, at the user's request.

Task SPPRO-4861 (2026-10-21, Parking Lot → id 3): "Send to QA" (851) → Ready for QA (the call timed out but applied; user confirmed); stayed assigned to the user.

Task SPPRO-4392 (2026-10-22, Parking Lot → id 3; the first MCP call timed out without applying): "Send to QA" (851) → Ready for QA, done over REST after MCP timeouts; stayed assigned to the user. No TT mirror. Permission-only seeder change: after the prodev push, `sg www-data -c "... artisan db:seed --class=RolesPermissionsSeeder --force"` worked; `permission:cache-reset` still printed "Unable to flush cache", but tinker showed the role already had the new permission (syncPermissions resets the Spatie cache).

Improvement SPPRO-4490 (2026-10-22, Problem → "In Progress (1)" id 3) used "Send to QA" (851); the MCP call timed out but applied, and the ticket landed in status "Ready for QA" (still assigned to the user).

Bug SPPRO-5133 (2026-10-22, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user. Rebased onto a teammate commit with a migration first (migrated, reran affected tests).

Bug SPPRO-5070 (2026-10-22, third round from Problem via 4 → 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user. QA comment @mentioned Sawyer via HTML.

Bug SPPRO-5101 (2026-10-22, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user. The fix is production-only (chat button renders only under @production), so the user still chose Ready for QA, with QA instructions to check on production after the next release.

Bug SPPRO-5135 (2026-10-22, entered via 651 → 721 → 181): "Ready for QA" (491) → Ready for QA; stayed assigned to the user.
