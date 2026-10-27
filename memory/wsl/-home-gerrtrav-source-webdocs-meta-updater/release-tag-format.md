---
name: release-tag-format
description: "Release tags must be named release-YYYY.MM.DD, not the older v<branch-name> style seen in the repo"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 56ebade9-3d56-48c7-a18b-8eff23447699
  modified: 2026-10-19T21:09:50.217Z
---

Release tags use the format `release-YYYY.MM.DD` (annotated, on the master commit being released).

**Why:** The user corrected a `v<branch-name>` tag (copied from older tags like `vfix_dms_issues`) on 2026-10-19; the repo's history doesn't reflect the current convention.

**How to apply:** When landing work on master "with a release tag", name it `release-<date>`. The date used for WMU-6 was the day the tag was cut (2026.10.19); confirm with the user if the release/deploy date differs.
