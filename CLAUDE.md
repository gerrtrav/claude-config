# Global instructions

## Paths

- When working inside WSL (Ubuntu-24.04), reference paths in commands and file edits using
  WSL-home-relative paths (for example, `~/source/<project>/...`) instead of UNC WSL paths like
  `\\wsl.localhost\Ubuntu-24.04\home\gerrtrav\source\<project>\...`.
- This rule applies only to WSL. When working natively on Windows, use ordinary Windows paths
  (for example, `C:\Users\gerrtrav\source\repos\<project>\...`).

## Git workflow

- Never do work on the main branch (usually `master`). Before making any code change, always create a short-lived
  local branch (for example, named after the Jira ticket, such as `sppro-1234-short-description`) and do all edits
  and commits there; no need to ask first.
- Prefer many small, focused commits over a few large ones; commit each logical step separately.
- To land a finished branch, rebase it onto the main branch and merge it into the local main branch (fast-forward)
  instead of pushing the branch. Always verify the merge completed successfully (e.g. `git log`/`git status` show the
  main branch contains the branch's commits and a clean tree), then delete the local branch.

## Jira

- Use the Atlassian MCP connector (`mcp__claude_ai_Atlassian_MCP__*`) for Jira and Confluence. The Atlassian Rovo
  connector (`mcp__claude_ai_Atlassian_Rovo__*`) no longer exists; never use its tools.
- If the Atlassian MCP connector is not responding (errors or timeouts), or can't do the job (e.g. uploading
  attachments), fall back to the Jira REST API (`https://showplacecabinetry.atlassian.net/rest/api/3/...`) with my
  personal token: `curl -u "$JIRA_EMAIL:$JIRA_API_TOKEN" ...`. Never print the token. After an MCP write times out,
  read the item back before retrying, because the write may have applied anyway.
- When starting work on a Jira ticket, always transition its status to "In Progress" as one of the first steps.
- When working on a subtask, also transition its parent work item to "In Progress" (if it isn't already).
- When posting a summary of changes as a Jira ticket comment on an ITHD- or EVOX-prefixed ticket, write it for the
  customer/reporter, not for a developer audience: no file paths, function/class names, commit hashes, or other
  implementation details. Close the comment with "This change is being QAd and will be promoted to production when
  it passes" rather than claiming the change is already tested or ready for release. Exception: if the change was
  already deployed to production in the same session, leave that closing line off. For tickets in any other
  project, write the summary developer-facing (implementation details, file references, etc. are fine).
- When creating Jira tickets, organize the work in three levels:
  - Epic = one main feature (for example, Profile Management).
  - Tasks = the main, testable parts of that feature (for example, the registration screen, the user registration
    approval screen, and the marketing tab with communication preferences). Each task must describe the expected
    behavior and what "done" looks like.
  - Subtasks = small, usually technical pieces needed to complete a task (for example, adding form validation,
    wiring up the registration API, saving the user's profile, adding database fields, handling save errors). They
    support the task's outcome and give developers a place to track implementation details.
- When I don't give you an assignee for a ticket, assign it to the person in the Administrator role under the
  space's access settings. If more than one person holds that role, ask me which one.

## Insight database

- When checking anything against the Insight database (verifying report queries, looking up columns, reading view
  or stored procedure source), connect as the read-only SQL login `claude_read_only`, never with the user's own
  Windows credentials.
- Server `swp-insightdb.showplacewood.com`, database `Insight`. The login has `db_datareader`, `db_denydatawriter`,
  `VIEW DEFINITION` and `SHOWPLAN`, but no EXECUTE: it can read procedure source but not run procedures, and
  writes are denied, so ad-hoc SELECTs are safe to run without asking.
- The password is in the `INSIGHT_DB_PASSWORD` environment variable (a Windows User env var; if `$env:` is empty in
  a stale session, read it with `[Environment]::GetEnvironmentVariable('INSIGHT_DB_PASSWORD','User')`). Never print
  it. If it isn't available, ask the user rather than falling back to Windows authentication.
- Use `sqlcmd -S swp-insightdb.showplacewood.com -d Insight -U claude_read_only -P <password> -C -W -s "|" -Q "..."`
  (`-C` trusts the server certificate). For DDL: `OBJECT_DEFINITION(OBJECT_ID('dbo.X'))` or `sys.sql_modules`
  for views/procs; `INFORMATION_SCHEMA.COLUMNS` or `sp_help` for tables.

## Keeping this file in sync

- These global instructions exist in two places and must be kept identical:
  - WSL (Ubuntu-24.04): `~/.claude/CLAUDE.md`, i.e.
    `\\wsl.localhost\Ubuntu-24.04\home\gerrtrav\.claude\CLAUDE.md` — the authoritative original.
  - Windows: `C:\Users\gerrtrav\.claude\CLAUDE.md`.
- Always keep the two up to date with each other: at the start of a session, and whenever either file
  is edited, compare them and re-sync so they match exactly. An edit made on the Windows side must be
  carried back to the WSL original as well.
