---
name: document-upload-test-deploy-hold
description: "Document Upload test site runs main (Laravel 13) since 2026-10-28; the old DU-13 hold is superseded, but DU-13's commit 4e33cfb is still not in main"
metadata:
  node_type: memory
  type: project
  originSessionId: c19e1e93-1de0-4488-a49b-31048cb24a2c
  modified: 2026-11-05T13:35:49.170Z
---

Since 2026-10-28 the Document Upload test site (swp-app-nginx-test, `test` remote, DU-16 push-to-deploy) runs `main` (Laravel 13, PHP 8.5, Vite), per the DU-16 ticket. The earlier rule "don't push main to test until DU-13 is merged" no longer applies.

As of 2026-11-05, DU-13's commit `4e33cfb` (branch `feature/DU-13-new-field-for-webdocs-document-upl`, a new Webdocs field) is **not** an ancestor of `main`. Its change may not be in main.

**Why:** found while writing the DU Confluence Deployment page; the old hold memory contradicted DU-16.
**How to apply:** check `/srv/git/documentupload.git/DEPLOYED` before pushing to test. If DU-13 comes up, check whether its field change still needs merging into main.
