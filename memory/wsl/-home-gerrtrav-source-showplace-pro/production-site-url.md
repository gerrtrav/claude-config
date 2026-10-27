---
name: production-site-url
description: The production Showplace Pro site is https://showplacepro.biz/ (not in the repo); use it to check live headers/cookies with curl
metadata:
  node_type: memory
  type: reference
  originSessionId: 1f2536b8-1d28-4784-8f6c-9dba6aaaf909
  modified: 2026-10-08T14:43:55.122Z
---

The production Showplace Pro site is **https://showplacepro.biz/**. The repo doesn't record it; guesses like pro.showplacewood.com don't resolve. Staging is https://pro-staging.showplacewood.com/ ([[staging-remote-prodev]]).

Public pages like `/login` can be fetched with `curl -D -` to check response headers and cookie flags without production SSH access (prod SSH reads are blocked by the auto-mode classifier). The production server's bare IP is 45.79.43.29 (`proprod`).
