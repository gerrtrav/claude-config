---
name: tt-ticket-mirrors-sppro
description: TT ("Travis's Tasks") tickets mirror SPPRO tickets (summary ends "- SPPRO-NNNN", linked Relates); Done = transition 41
metadata:
  type: project
---

The user keeps a personal TT project ("Travis's Tasks") with a ticket mirroring each SPPRO ticket: same description, summary suffixed "- SPPRO-NNNN", linked with "Relates". Statuses: To Do (21), Next (4), Waiting on Others (3), Done (41).

On SPPRO-4988 (2026-10-15), once the SPPRO ticket went to Quality Audit, the user asked to move the linked TT ticket (TT-823) to Done; transition 41 worked directly from Next.

**Why:** TT tracks the user's own work; it's done when their part is handed to QA.
**How to apply:** After sending an SPPRO ticket to QA, offer to close its linked TT ticket (see [[jira-finish-to-qa]]).

Not every SPPRO ticket has a TT mirror: SPPRO-4333 (2026-10-19) had none (its ITHD source ticket had TT-500, already Done). Search TT first (summary ~ "SPPRO-NNNN" or linkedIssues); if none exists, say so. The user declined creating one after the fact.
