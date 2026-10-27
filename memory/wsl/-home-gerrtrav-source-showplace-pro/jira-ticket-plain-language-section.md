---
name: jira-ticket-plain-language-section
description: "When creating Jira tickets, include a plain-language section for non-programmers alongside the technical/developer section"
metadata:
  node_type: memory
  type: feedback
  originSessionId: bc3b5e3f-e19e-4e92-84f4-c93aedc008a6
  modified: 2026-10-07T20:24:26.263Z
---

When creating a Jira ticket, don't write only the programmer-facing description. Also include an easy-to-read section for non-programmers: what the problem or change is, who it affects, and what will be different for them, with no file paths, class names, or other code details. Put the plain-language section first, then the technical details for developers.

**Why:** The user said tickets with only the programmer part are hard for non-programmers (business stakeholders, QA, reporters) to follow.

**How to apply:** Applies to every ticket Claude creates, in any project. This is separate from comment tone rules ([[jira-comment-tone]]), which cover comments, not new tickets. ITHD tickets are still never written to ([[ithd-draft-comments-only]]).
