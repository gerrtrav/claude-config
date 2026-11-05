---
name: nightwatch-comment-waf-block
description: "Nightwatch add_issue_comment is blocked by Cloudflare (\"Sorry, you have been blocked\") when the text has system paths like /etc/hosts"
metadata:
  node_type: memory
  type: reference
  originSessionId: 2a4ad773-ff2a-4790-a970-c89e98952e9d
  modified: 2026-10-28T18:23:53.386Z
---

On 2026-10-28 a Nightwatch comment containing `/etc/hosts`, IPs and backticked hostnames came back as a Cloudflare "Sorry, you have been blocked" HTML page. Rewording to plain prose ("static host entries on the production server") went through.

**How to apply:** keep Nightwatch comments free of system file paths (`/etc/...`) and shell-like text; put those details on the Jira ticket and link it.
