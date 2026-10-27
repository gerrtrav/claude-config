---
name: ithd-draft-comments-only
description: "Never write to ITHD tickets directly (no comments, notes or edits); give the user the comment text and they post it themselves"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1fff82c8-5c60-4cd0-95ab-32174f5da716
  modified: 2026-10-16T13:08:13.962Z
---

When asked to update an ITHD ticket, do not call any Jira write tool on it (no comments, internal/restricted notes or field edits). Write the comment text in the reply, ready to paste, and let the user post it themselves. Reading ITHD tickets is still fine. The tone rules in [[jira-comment-tone]] still apply to the draft.

**Why:** The user set this on ITHD-3120 (2026-09-30), after a comment was posted directly to the ticket. ITHD is a customer-facing service desk, and the user wants to control what goes on it.

Exception: creating *new* ITHD tickets when the user explicitly asks for it (2026-10-15, Bitbucket SSH tickets ITHD-3368–3375) — show the draft and confirm once first, then create.

Status changes count as writes too. When the user asks to "mark it done" on an ITHD ticket, confirm first; on 2026-10-16 they approved resolving ITHD-3373 (transition 761 "Resolve this issue", fields resolution=Done) as a one-time exception. The comment was still theirs to post.

**How to apply:** For "update the ticket", "post QA steps" or anything similar on an ITHD-* key, output the text in the reply. This overrides the posting step in [[ithd-finish-internal-qa-note]].

2026-10-26: on ITHD-3479 the user approved posting directly ("you can post the list as a table", then "add this list to ithd-3479 as a table"); comments 52831, 52834. An explicit "add/post to ITHD-xxxx" is an OK to post; a vaguer "update the ticket" still means draft.
