# Insight database

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
