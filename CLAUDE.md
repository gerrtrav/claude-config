# Global instructions

The org policy (`/etc/claude-code/CLAUDE.md`) already covers paths, branching, small commits, the Jira
connector, "In Progress" transitions, who reads Jira comments, and the Insight read-only login. This file
adds only my own preferences; details are in `~/.claude/docs/`.

- Land work by rebasing onto main and fast-forward merging into local main (don't push the branch). Check
  with `git log`/`git status` that main has the commits and the tree is clean, then delete the branch.
- Read `~/.claude/docs/jira.md` before falling back to the Jira REST API, posting a comment, or creating tickets.
- Read `~/.claude/docs/insight-database.md` before querying Insight.
- Keep this file and `~/.claude/docs/` identical in WSL (the master copy) and `C:\Users\gerrtrav\.claude\`; re-sync after any edit.
