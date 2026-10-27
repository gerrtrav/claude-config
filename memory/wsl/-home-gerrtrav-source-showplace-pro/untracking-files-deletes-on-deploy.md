---
name: untracking-files-deletes-on-deploy
description: A commit that untracks files (git rm --cached + .gitignore) deletes them on prodev/proprod, whose deploys use git reset --hard / pull
metadata:
  type: project
---

Untracking a file in a commit (`git rm --cached` plus a `.gitignore` entry) does not keep the copy on the servers. When `git reset --hard` or `pull` moves from a commit that tracks the file to one that doesn't, git deletes it from the working tree. Both deploys work this way (see [[deploy-scripts-locations]]).

On 2026-10-12 the ITHD-3287 stopgap (db17a2961, untracking public/assets/images/Home_Page.jpg and Bluestem_Home_Page.jpg) deleted both images on prodev on its first deploy. I restored them over ssh from git. Proprod had not been deployed yet, and SPPRO-4894's QA comment notes the step to copy the images into storage/app/public/marketing/home-page before the next prod update.

**How to apply:** when a change untracks runtime/user files, warn that the first deploy will delete them, and plan a backup/copy step on each server before it goes out.

Same thing happens locally: SPPRO-4897 (118d26db7, 2026-10-12) untracked `public/mix-manifest.json`, and fast-forwarding a local master past it deleted the local manifest. `mix()` then throws, so every page 500s and ~76 feature tests fail with "Mix manifest not found". Fix: `./vendor/bin/sail yarn run dev`. Any developer pulling master past that commit hits this once.
