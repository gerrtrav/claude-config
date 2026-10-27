---
name: confluence-showplace-pro-folder
description: "Confluence documents for this project go in the \"Showplace Pro\" space, at the space level (no folder)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: de3f6562-7488-456a-b906-d6a12e3e75a8
  modified: 2026-10-20T14:47:34.688Z
---

When creating Confluence documents for the showplace-pro project, put them in the **Showplace Pro** space, directly in the space with no parent folder.

**Why:** On 2026-10-20 the user first said "Showplace space, Showplace Pro folder", then corrected it to just the Showplace Pro space and no folder.

**How to apply:** Use the Atlassian MCP tools ([[no-rovo-mcp]]). Look up the Showplace Pro space's id/key before creating a page, and don't set a parent folder. If the space can't be found, ask the user.
