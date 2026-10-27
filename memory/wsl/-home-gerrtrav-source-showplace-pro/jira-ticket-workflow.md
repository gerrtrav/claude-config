---
name: jira-ticket-workflow
description: "Always transition a Jira ticket to \"In Progress\" when starting work on it"
metadata: 
  node_type: memory
  pinned: true
  originSessionId: 408cd827-d769-4636-8635-f3fccfc6182f
  modified: 2026-09-24T14:01:44.746Z
---

When starting work on a Jira ticket in the showplace-pro project, always transition its status to "In Progress" as one of the first steps. If the ticket is a subtask, also transition its parent work item to "In Progress" if it isn't already.
