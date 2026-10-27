---
name: create-test-quotes-allowed
description: "Claude may create new quotes/orders (incl. Sales Aids) on staging and local for testing without asking; existing quotes still need the user's OK"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1444a5d3-d04c-4f4b-af64-ce821de20c30
  modified: 2026-10-07T20:05:19.351Z
---

Creating new quotes and orders (including Sales Aids orders) for testing is allowed on both staging (https://pro-staging.showplacewood.com/) and the local app, without asking first. Name them so they read as tests (e.g. job name starting with "Claude test"). Changing *existing* quotes still needs the user's say-so.

**Why:** On SPPRO-4854 (2026-10-07) I skipped an end-to-end browser check on staging because no Sales Aids order existed and I thought creating one needed permission; the user said "You can create quotes on staging and local."

**How to apply:** When a browser check needs a quote/order that doesn't exist, create one (staging dealer login: [[staging-dealer-login]]; local: [[local-login-superadmin]]). Also recorded in `.claude/skills/run-showplace-pro/SKILL.md`.
