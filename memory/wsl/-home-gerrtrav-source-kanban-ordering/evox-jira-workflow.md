---
name: evox-jira-workflow
description: "EVOX Jira project quirks — required create fields, Done needs a Component and Assignee, new tickets land in Parking Lot and the user can't move them to In Progress"
metadata:
  node_type: memory
  type: reference
  originSessionId: a551c86f-5f79-459d-9542-40a1b85d08c8
  modified: 2026-10-01T19:27:04.320Z
---

EVOX Jira project (showplacecabinetry.atlassian.net, cloudId 1a029e5d-adb5-44de-af2d-72c337978d83):

- Creating a Task requires `duedate` and Estimate Effort `customfield_10491` (XS 10623, S 10624, M 10625, L 10626, XL 10627) — ask the user for both.
- New tickets land in **Parking Lot**. From there only Won't Implement / Done / Done - Backfill are available to the user; "Approve" → Backlog is conditional and unavailable to them, so the "transition to In Progress" rule can't be followed. Say so rather than retrying (seen on EVOX-713/714, 2026-10-01).
- Moving to Done (transition id 30 "Move to Done") requires a Component and an Assignee. They can't be passed on the transition ("not on the appropriate screen"), so set them with an edit first. Kanban-ordering app tickets: EVOX-713 used Inventory Management (10292), the user's choice; epic siblings EVOX-509/510 use MES Platform & IT Foundation (10289). Ask if unsure.
- Steve Schiller (accountId 712020:0bfc4f03-2919-4ecc-bcab-f8aef78681d4) is the Manufacturing contact/reporter for the Winstore Kanban epic EVOX-506.
