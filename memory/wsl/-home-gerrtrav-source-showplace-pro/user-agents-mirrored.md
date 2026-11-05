---
name: user-agents-mirrored
description: User-level agent definitions (~/.claude/agents) are kept in both WSL and Windows; code-search (haiku) created 2026-11-03
metadata:
  type: reference
---

User-level Claude Code agents live in `~/.claude/agents/` (WSL) and are copied to `C:\Users\gerrtrav\.claude\agents\` (Windows); the user asked for the copy on 2026-11-03. The only one so far is `code-search.md` (read-only search/lookups, `model: haiku`), created to cut subagent cost after a /usage review. When editing or adding an agent, update both copies. Same idea as the global CLAUDE.md sync rule.
