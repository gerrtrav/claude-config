---
name: production-read-only-unless-approved
description: "Production (proprod, prod DB, showplacepro.biz) may be read freely but never changed without the user's explicit OK"
metadata:
  node_type: memory
  type: feedback
  originSessionId: babb78e5-4d63-43ca-aab7-a154b1540228
  modified: 2026-10-08T19:19:25.088Z
---

I may read from the showplace-pro production environment (ssh proprod read-only commands, the read-only prod DB login, GET requests to the live site) without asking. I must not make any change there (files, deploys, git, artisan writes, service restarts, DB writes) without explicit permission in the current conversation.

**Why:** The user said (2026-10-08): "you are also able to read from the production environment but are not allowed to make any changes without explicit permission".

**How to apply:** Read prod freely to investigate. For any prod change, stop and ask first, even when it seems routine. Staging (`prodev`) .env edits are a separate, allowed case. ~/.claude/settings.json `autoMode` has matching allow and soft_deny rules. See [[production-readonly-db]], [[production-site-url]], [[production-patch-files]] and [[deploy-scripts-locations]].
