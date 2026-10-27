---
name: ithd-finish-internal-qa-note
description: "When an ITHD ticket's work is merged, leave it In Progress and post the QA instructions as an internal note the customer cannot see"
metadata:
  node_type: memory
  pinned: false
  originSessionId: 56771dc0-c249-48ea-9e64-097e62075d0a
  modified: 2026-09-28T15:22:47.976Z
---

The ITHD (IT Helpdesk) Jira Service Management workflow has no "Quality Audit" status, so the SPPRO finish-to-QA flow (move to Quality Audit) does not apply there. When the user asks to "move an ITHD ticket to QA" after its work is merged, leave the ticket's status as In Progress and do not transition it to Resolved or Pending. Resolved means "awaiting verification by the reporter" and notifies the customer before QA has passed.

Do not post the QA instructions yourself: give the user the text to post (see [[ithd-draft-comments-only]], 2026-09-30). The note should be internal, one the reporter/customer cannot see, because ITHD comments are public to the customer by default. The Atlassian comment tool cannot set the JSM "internal" flag, so remind the user to post it as an Internal note. The user set this preference on ITHD-3106 (2026-09-28).
