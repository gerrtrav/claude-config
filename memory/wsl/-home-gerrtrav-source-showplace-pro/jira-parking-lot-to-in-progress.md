---
name: jira-parking-lot-to-in-progress
description: "How to move an SPPRO Jira ticket from Parking Lot to In Progress; the user approved using the \"Hotfix\" transition on the way"
metadata:
  node_type: memory
  pinned: false
  originSessionId: 42ad6e62-7db0-462f-a59f-6aa309ce1072
  modified: 2026-09-29T19:22:57.624Z
---

In the SPPRO Jira workflow, some Parking Lot tickets offer a direct "In Progress (1)" transition (id 3, seen on SPPRO-4580 on 2026-10-01 and SPPRO-4801 on 2026-10-06, SPPRO-4845 and Improvement SPPRO-4856 on 2026-10-07, Improvement SPPRO-3588 on 2026-10-09; Bugs SPPRO-4846, SPPRO-4850, SPPRO-4851 SPPRO-4854 and SPPRO-4848 on 2026-10-07, SPPRO-4855, SPPRO-4876, SPPRO-4877, SPPRO-4878, SPPRO-4879, SPPRO-4882 and SPPRO-4883 on 2026-10-08, SPPRO-4885 on 2026-10-09, SPPRO-4892 on 2026-10-12, Bug SPPRO-4901 and Bug SPPRO-4911 on 2026-10-13 (id 3 rejected with a 400, also from Triage), did not offer it (id 3 also rejected with a 400 on SPPRO-4882) (on SPPRO-4883 id 3 was rejected with a 400 from Triage) and went the Followed Up → Hotfix → Start Work path); use it when available. Otherwise there is no direct transition to "In Progress". The path is: "Followed Up" (Parking Lot → Triage), then "Hotfix" (Triage → To Do), then "Start Work" (To Do → In Progress). The user explicitly approved using the "Hotfix" transition for this even though its name suggests a hotfix, so do not stop to ask about it when starting work on a Parking Lot ticket. Transition IDs seen so far: Followed Up 651, Hotfix 721, Start Work 181, but check the available transitions each time rather than assuming.

A ticket QA sent back is in status "Problem"; Improvement SPPRO-3588 (2026-10-09) offered no "Start Work" from Problem, only "In Progress (1)" (id 3), which worked, then "Send to QA" (851) back. Other tickets in Problem offer "Start Work" (id 181) straight to In Progress (SPPRO-4806, 2026-10-07; SPPRO-4848, 2026-10-08), and from there "Ready for QA" (491) back to Quality Audit.

Task SPPRO-4735 and Epic SPPRO-4711 (2026-10-13) went Parking Lot → "In Progress (1)" (id 3) directly; SPPRO-4735 then went In Progress → "Done" (591).

A ticket already in Triage can offer "In Progress (1)" (id 3) directly (Improvement SPPRO-4585, 2026-10-08).

On Bug SPPRO-4886 (2026-10-09) Followed Up (651) → Hotfix (721) reported "To Do", but by the time work was finished the ticket no longer offered "Start Work"; it offered In Progress transitions ("Ready for QA" 491, "Not Ready" 741), and "Ready for QA" went straight to Quality Audit. So after Hotfix, check transitions right away and call "Start Work" before coding, rather than at the end.

On 2026-10-14 (SPPRO-4940/4941) transition 651 (Parking Lot → Triage) was named "Scope" instead of "Followed Up"; call it by id 651, not by name.

Bug SPPRO-4929 (2026-10-14): id 3 rejected with 400 from Parking Lot; 651 → 721 → 181 (Start Work, called right after Hotfix) worked.

New Feature SPPRO-4318 (2026-10-14): Parking Lot → "In Progress (1)" (id 3) worked directly.

Bug SPPRO-4976 (2026-10-14): id 3 rejected with 400 from Parking Lot; 651 → 721 → 181 worked.

Bug SPPRO-4977 (2026-10-14): id 3 rejected with 400 from Parking Lot; 651 → 721 → 181 worked.

Bug SPPRO-4978 (2026-10-14): id 3 not tried; 651 → 721 → 181 worked.

Bug SPPRO-4980 (2026-10-14): 651 → 721 → 181 worked.

Task SPPRO-4987 (2026-10-15): Parking Lot → id 3 (named "Fast-track" from In Progress) worked directly.

Task SPPRO-4988 (2026-10-15): Parking Lot → id 3 worked directly.

Story SPPRO-4684 (2026-10-15): Parking Lot → id 3 worked directly. Its Epic SPPRO-4683 (Parking Lot) rejected id 3 and 651 with a 400; listJiraIssueTransitions (includeUnavailableTransitions) showed only 651 "Start triage" with isAvailable false, so the user has to move that epic.

Bug SPPRO-5006 (2026-10-15): id 3 rejected with 400 from Parking Lot; 651 → 721 → 181 worked.

Bug SPPRO-2141 (2026-10-15) in "Problem" offered only Parking Lot (4), Done (591), QA Test Again (11), Re-test (12); 181 and 3 were rejected with a 400. Path that worked: 4 (→ Parking Lot) → 651 → 721 → 181 (id 3 also rejected from Parking Lot).

Bug SPPRO-3807 (2026-10-15) in "Problem": 181 and 3 rejected with a 400; 4 (→ Parking Lot) → 651 → 721 → 181 worked, same as SPPRO-2141. For a Problem ticket, try that path first.

Bug SPPRO-4909 (2026-10-15): Parking Lot → "Done" (591) worked directly, for closing a ticket whose work was already finished.

Bug SPPRO-3545 (2026-10-15): closed as Won't Do from Parking Lot with "Done" (591) plus fields {"resolution": {"name": "Won't Do"}}; the resolution was applied.

Bug SPPRO-5062 (2026-10-19): id 3 not tried; 651 → 721 → 181 worked.

Bug SPPRO-4333 (2026-10-19): id 3 not tried; 651 → 721 → 181 worked.

Bug SPPRO-5064 (2026-10-19): id 3 not tried; 651 → 721 → 181 worked.
Improvement SPPRO-5069 (2026-10-19): Parking Lot → id 3 worked directly.

Task SPPRO-1930 (2026-10-20): Parking Lot → id 3 worked directly.

Bug SPPRO-5089 (2026-10-20): id 3 not tried; 651 → 721 → 181 worked.

Bug SPPRO-5090 (2026-10-20): id 3 not tried; 651 → 721 → 181 worked.

Bug SPPRO-5070 (2026-10-20) in "Problem": 181 rejected with 400; 4 → 651 → 721 → 181 worked.

SPPRO-5091 (2026-10-20): Bug SPPRO-5091 entered via 651 → 721 → 181.

New Feature SPPRO-3471 (2026-10-20): Triage → "In Progress (1)" (id 3) worked directly.

New Feature SPPRO-4518 (2026-10-20): Parking Lot → id 3 worked directly. Its Epic SPPRO-4390 (Parking Lot) rejected id 3 with a 400; left for the user.

Improvement SPPRO-288 (2026-10-20): Parking Lot → id 3 worked directly.

Story SPPRO-503 (2026-10-20): Triage → id 3 worked directly.

New Feature SPPRO-257 (2026-10-20): Parking Lot → id 3 worked directly.

New Feature SPPRO-960 (2026-10-20): Parking Lot → id 3 worked directly.

Improvement SPPRO-2095 (2026-10-20): Parking Lot → id 3 worked directly.

Bug SPPRO-5094 (2026-10-21): id 3 not tried; 651 → 721 → 181 worked.

Task SPPRO-4861 (2026-10-21): Parking Lot → id 3 worked directly.

Improvement SPPRO-4902 (2026-10-21) in "Problem": id 3 (named "Fast-track") worked directly to In Progress.

Improvement SPPRO-4490 (2026-10-22) in "Problem": id 3 worked directly to In Progress (MCP call took ~2 min but applied).

Bug SPPRO-5133 (2026-10-22): 651 → 721 → 181 worked.

Bug SPPRO-5097 (2026-10-22) in "Problem": 4 → 651 → 721 → 181 worked; then "Ready for QA" (491) landed in status "Ready for QA" (10074), not Quality Audit.

Bug SPPRO-5101 (2026-10-22): 651 → 721 → 181 worked.

Bug SPPRO-5135 (2026-10-22): 651 → 721 → 181 worked.

Epic SPPRO-5144 (2026-10-26, Parking Lot): id 3 rejected with a 400, same as earlier epics; left for the user to move.
