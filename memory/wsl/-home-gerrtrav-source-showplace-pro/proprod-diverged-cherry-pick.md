---
name: proprod-diverged-cherry-pick
description: Since release-261026-2 (2026-10-26) proprod master holds cherry-picks not on master; next full release must force-push +master
metadata:
  node_type: memory
  type: project
  originSessionId: b5877db2-4bdd-4eb8-b8ac-b4cc3d9e56dc
  modified: 2026-10-26T12:55:08.660Z
---

On 2026-10-26 SPPRO-5135 shipped alone as `release-261026-2`: its two commits were cherry-picked onto `release-261026` (8d1d89674) and pushed as proprod master. Our master has the same changes as different commits (904b6e110, 4fec75603), so proprod master and master have diverged.

**Why:** SPPRO-5135 could only be tested in production, and master also held unQA'd work (SPPRO-2141, 2429, 5101, 4236, 4871).

**How to apply:** the next full release must force-push: `git push --atomic proprod +master release-YYMMDD`. Safe because master contains equivalent changes. A tag and branch with the same name need full refs (`refs/heads/...`, `refs/tags/...`) in the push. See [[release-tag-naming]]. Delete this memory once a full master release has gone out.
