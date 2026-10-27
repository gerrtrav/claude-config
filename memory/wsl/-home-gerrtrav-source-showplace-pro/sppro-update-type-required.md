---
name: sppro-update-type-required
description: Creating an SPPRO issue needs Update Type (customfield_10051); "Release Update" is id 10022
metadata:
  type: reference
---

SPPRO `createJiraIssue` fails with "Update Type is required" unless `additional_fields` sets `customfield_10051`. Maintenance/improvement tickets under the Q3 2026 Maintenance epic (SPPRO-4573) use `{"id": "10022"}` ("Release Update"). The Atlassian MCP connector has no project-role lookup, so the space Administrator for [[jira-default-assignee-space-admin]] can't be resolved through it; ask the user.

Bug tickets go under the "Q3 2026 Bug fixes" epic SPPRO-4560 (the user calls it "the q3 bug fixes epic"); SPPRO-5093 (Bug, 2026-10-20) was created there with Update Type 10022.

Sub-tasks reject `customfield_10051` with a 400 ("cannot be set. It is not on the appropriate screen") — set it only on Epics/Tasks/etc., never on Sub-tasks (SPPRO-5114 epic, 2026-10-22). An Epic can't be a child of another Epic in SPPRO (Epic is the top level); for "an epic under epic X" the user chose a new Epic linked to X with "Relates".

The space Administrator role CAN be resolved via REST: GET /rest/api/3/project/SPPRO/role → "Administrators" URL → actors. On 2026-10-22 it held five people (Andrew Gilbert, Mayas Knaizeh, Nathaniel Jay Lee, Shad Kaske, Travis Gerry), so ask; the user picked Travis Gerry (again on 2026-10-27 for SPPRO-5181, a Task under the "Future Maintenance Items" epic SPPRO-4905).

The SPPRO sub-task issue type name is exactly `Sub-task` (id 10013); `Subtask` is rejected with "Specify a valid issue type".

SPPRO priority names are "P1 - Critical", "P2 - High", "P3 - Medium", "P4 - Low", "P5 - Minimal"; plain "High"/"Medium"/"Low" are rejected with 400 (2026-10-27, SPPRO-5182..5188).
