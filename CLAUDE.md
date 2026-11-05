# Global instructions

Details live in `~/.claude/docs/`; read the linked file when a task touches that area.

## Paths

- In WSL (Ubuntu-24.04), use home-relative paths (`~/source/<project>/...`), never `\\wsl.localhost\...`
  UNC paths. On native Windows, use ordinary Windows paths (`C:\Users\gerrtrav\source\repos\<project>\...`).

## Git workflow

- Never work on the main branch (usually `master`). Before any code change, create a short-lived local
  branch (e.g. `sppro-1234-short-description`); no need to ask first.
- Prefer many small, focused commits; commit each logical step separately.
- Land by rebasing onto main and fast-forward merging into local main (don't push the branch). Verify with
  `git log`/`git status` that main has the commits and the tree is clean, then delete the local branch.

## Jira

- Use the Atlassian MCP connector (`mcp__claude_ai_Atlassian_MCP__*`); never the retired Rovo connector.
- When starting a ticket, transition it to "In Progress"; for a subtask, its parent too.
- Comments on ITHD/EVOX tickets are customer-facing; all others are developer-facing.
- Read `~/.claude/docs/jira.md` before: falling back to the REST API, posting a comment, or creating tickets.

## Insight database

- Only connect as the read-only SQL login `claude_read_only`, never with Windows auth. Read
  `~/.claude/docs/insight-database.md` before querying.

## Keeping in sync

- This file and `~/.claude/docs/` exist in WSL (authoritative, `~/.claude/`) and Windows
  (`C:\Users\gerrtrav\.claude\`). At session start and after any edit, compare and re-sync so they match exactly.
