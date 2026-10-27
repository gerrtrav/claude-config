---
name: evox-730-db-objects-deployed
description: "EVOX-730 insightsql objects (vwWinstoreReorderPoints_SHOW, WinstoreReplenishmentMissingItemLog_SHOW) are deployed to Insight as of 2026-10-07"
metadata:
  node_type: memory
  type: project
  originSessionId: 76cd9b3c-b662-42fc-8eac-11397716f97e
  modified: 2026-10-07T12:51:02.316Z
---

As of 2026-10-07 the user deployed the EVOX-730 Insight database objects themselves, outside of Claude: `dbo.vwWinstoreReorderPoints_SHOW` and `dbo.WinstoreReplenishmentMissingItemLog_SHOW`. They came from the insightsql repo, branch `evox-730-winstore-safety-stock`. The Jira comment on EVOX-730 still says "Neither is deployed yet," which is out of date.

**Why:** The kanban_ordering app work for EVOX-730 can query these objects for real. It doesn't need to wait on a deploy.

Later the same day the user added the Winstore Laminator/Sheetstock flags to `vwWinstoreReorderPoints_SHOW`. That view now replaces `vwNeededForBatches_SHOW` as the app's item source. Missing-item logging was dropped (gap detection belongs to EVOX-736), so the app doesn't use the log table.

**How to apply:** Treat `vwWinstoreReorderPoints_SHOW` as live on `insight_mssql` and as the only source of items to replenish. `insight_mssql` stays fully read-only.
