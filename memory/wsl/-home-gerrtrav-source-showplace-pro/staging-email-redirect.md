---
name: staging-email-redirect
description: Anything run on staging (prodev) that would send email must redirect all recipients to gerrtrav@showplacewood.com
metadata:
  node_type: memory
  type: feedback
  originSessionId: 3dea4e36-a54c-43b7-9cfd-2cd580954a53
  modified: 2026-10-15T12:43:48.880Z
---

When running anything on staging (prodev / https://pro-staging.showplacewood.com/) that would send an email to anyone — tinker, artisan commands, queued jobs or notifications, test quotes/orders that trigger notifications, etc. — redirect every recipient to gerrtrav@showplacewood.com.

**Why:** Staging holds real dealer/user addresses; the user doesn't want test activity emailing real people.

**How to apply:** Before triggering mail on staging, make sure it goes only to gerrtrav@showplacewood.com (e.g. `Mail::alwaysTo('gerrtrav@showplacewood.com')` in the tinker/command session, or route the notification to that address). If a redirect can't be guaranteed for a given action, ask before running it. Related: [[staging-remote-prodev]], [[create-test-quotes-allowed]], [[prodev-tinker-breaks-cache-perms]].
