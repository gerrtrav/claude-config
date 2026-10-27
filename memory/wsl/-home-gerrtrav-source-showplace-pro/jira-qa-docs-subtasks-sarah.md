---
name: jira-qa-docs-subtasks-sarah
description: QA and tech-doc items for an epic go to Sarah Kirchner as Tasks under the epic (not Sub-tasks), in Triage; never add blocking links to the QA or docs tickets (the user adds them)
metadata:
  type: reference
---

Sarah Kirchner (QA department; the user may spell it "Kircher") — Jira accountId `712020:31172b86-8e10-4714-bfc9-ad05a0cd15a3`.

On SPPRO-4738 / epic SPPRO-4711 (2026-10-13) the user wanted a QA ticket and a technical-documentation ticket assigned to Sarah. Final shape they settled on:
- **Tasks directly under the epic** (parent = epic, Update Type `customfield_10051` = Release Update `{"id":"10022"}`), not Sub-tasks of the code ticket (SPPRO-4917 QA, SPPRO-4918 docs).
- **Not linked to the individual code ticket** ("don't link to 4738").
- **Status Triage.**
- **Do not create any "Blocks" links on the QA or technical-documentation tickets.** The user adds their blocking links manually (said 2026-10-14, for both tickets). Mention in the reply that the links are left for them.
- Descriptions follow [[jira-ticket-plain-language-section]] and [[qa-instructions-general-overview]].

Jira API limits hit: an SPPRO Sub-task can't be converted to a Task (Task requires Update Type, which the Sub-task screen rejects), the MCP connector has **no delete-issue and no delete-link operation** (the user must do those in the Jira UI), and Hold (status 10070) is only reachable from In Progress ("Halt Progress", 841); Hold → Triage is "Unpark" (761). Moving to In Progress auto-fills Start date.

Moving these SPPRO Tasks to **To Do**: no direct transition exists from Parking Lot or Triage (the "Hotfix" route is unavailable for them). The working route is Triage → "Request Approval" (661, to Scope Review, which auto-reassigns to the approver, Mayas Knaizeh) → approved → To Do, as on SPPRO-4803. On 2026-10-14 the user chose to move SPPRO-4917/4918 to To Do themselves rather than have Claude request approval, so ask before starting that approval route.

**Why:** On epic SPPRO-4930 (2026-10-14) Claude linked every child as blocking the QA ticket, including production release steps (go-live, pro-api release, legacy cleanup). That would have pushed QA past go-live. The connector can't delete links, so the user had to remove them in the UI, and then asked Claude to stop adding blocking links to the QA and docs tickets altogether.

**How to apply:** when creating an epic's QA and docs tickets, create them with no issue links. Don't offer to add them either; the user handles it. `createJiraIssueLink` reminder: `inwardIssue` = the blocker, `outwardIssue` = the blocked ticket.
