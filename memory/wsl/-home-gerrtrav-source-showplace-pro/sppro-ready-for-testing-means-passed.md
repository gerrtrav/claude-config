---
name: sppro-ready-for-testing-means-passed
description: "SPPRO \"Ready For Testing\" status means the ticket has PASSED QA (despite its Jira description); \"Ready for QA\" means waiting on QA"
metadata:
  node_type: memory
  type: project
  originSessionId: 5aea40f6-1597-421d-bb7f-350739910d19
  modified: 2026-10-22T12:02:02.958Z
---

In SPPRO, the "Ready For Testing" status (id 10055, Done category) means QA has passed, even though its Jira
description says "ready for testing but cannot be tested yet". "Ready for QA" (id 10074) is the status that still
needs QA. "Problem" (id 10069) = failed QA; a sub-task in Problem can only transition to Done, while a story in
Problem has "QA Test Again" (id 801) → Ready for QA.

**Why:** The user corrected me on 2026-10-22 after I listed Ready For Testing tickets as unpassed when checking
whether production could be released.

**How to apply:** When deciding what blocks a release-YYMMDD tag, treat Ready For Testing and Done as passed; only
Ready for QA, Problem and earlier statuses block. See [[jira-finish-to-qa]], [[release-tag-naming]].
