---
name: release-tag-naming
description: "Production release tags are named release-YYMMDD (e.g. release-261020), not the release-YYYY.MM.DD shown in the shared prod hook's comment"
metadata:
  node_type: memory
  type: feedback
  originSessionId: e2f43950-a8a4-4360-87a0-416b5d3e3afc
  modified: 2026-10-20T20:08:36.524Z
---

Name production release tags `release-YYMMDD` (e.g. `release-261020` for 2026-10-20). The shared prod post-receive hook on `app` (swp-nginx-prod, `/srv/git/hooks/post-receive-prod`) only deploys when a `release-*` tag is pushed together with the branch: `git push prod main release-YYMMDD`. Pushing the branch alone updates the bare repo but deploys nothing. Also push the tag to origin.

**Why:** the user stated this convention when releasing kanban_ordering EVOX-730 on 2026-10-20; the hook's own comment shows `release-2026.10.19`, which is not the convention.

**How to apply:** for apps deployed via the shared prod hook (e.g. kanban_ordering), annotated tag on the branch tip, push branch + tag to prod, then the tag to origin. If two releases happen on the same day, suffix the later tag `-2` (then `-3`): the user chose `release-261022-2` for showplace-pro's second release on 2026-10-22. For a partial showplace-pro release, push the tag commit as proprod's master (`git push --atomic proprod <sha>:refs/heads/master release-YYMMDD-N`) so proprod master stays equal to what is live.
