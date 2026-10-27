---
name: production-patch-files
description: RETIRED 2026-10-21 - production now deploys release-YYMMDD tags (SPPRO-5071); patch-file history kept for context
metadata:
  type: project
---

**Retired 2026-10-21:** production cut over to release-folder deploys (epic SPPRO-5071). Production fixes now go out as `release-YYMMDD` tags pushed to `proprod` ([[deploy-scripts-locations]], [[release-tag-naming]]), not patch files; `/var/www/showplace_pro` on proprod is a symlink into read-only release folders, so never apply patches there. The notes below are history.

The user may ask for "a patch file to add to production" for a landed ticket: run `git format-patch --stdout <base>..<tip>` over the ticket's commits (first done for SPPRO-4855, 2026-10-08), name it `SPPRO-NNNN.patch`, and attach it to the ticket (Atlassian MCP `uploadAttachmentToJiraIssue`, which has two phases: run the curl it returns, then call it again with the fileId).

Update 2026-10-20: prod HEAD is now a real origin/master commit (`aad233130`, branch master tracking origin/master, only stray changes are `app.js.LICENSE.txt` and the pro-api submodule), so the local-commit drift below is historical; a release-tag deploy script was drafted that day (not yet installed).

Previously, production (`proprod`, /var/www/showplace_pro) ran local commits whose hashes aren't in our repo (on 2026-10-08 prod HEAD was `ecaed0074`, which has the same message as master's `b36176fc9`), so match prod's `git log --oneline -1` message to a master commit and run `git apply --check` against a worktree there. The auto-mode classifier blocked copying the patch to prod for a `git apply --check` there, so leave the prod dry run to the user. When the user asks to "copy it to production", `scp` it to `proprod:~/SPPRO-NNNN.patch` (home dir, not the app dir) and grep prod's copy of the changed lines to confirm they match (worked for SPPRO-4872, 2026-10-08); applying it stays with the user.

A patch that is gated on a feature flag also needs that flag's env line on prod. See [[deploy-scripts-locations]].

After the user applies a patch on prod, they may ask to "update the ticket with the status of the patch": verify read-only with `git apply --check -R ~/SPPRO-NNNN.patch` on proprod (passes only if every hunk is in place) plus `git status --short`, then post a short developer-facing "Production patch status: applied" comment (done for SPPRO-4883, 2026-10-08). Prod keeps applied patches as uncommitted working-tree changes on top of its HEAD commit.

Permission cache on prod (SPPRO-5005, 2026-10-15): prod has no `CACHE_STORE`, so Laravel 11 uses the **database** store; the `CACHE_DRIVER=memcached` line is dead (memcached on proprod holds 0 items) and `storage/framework/cache` files there are 2024 leftovers. The Spatie cache is the `showplace_pro_cache_spatie.permission.cache` row in `sppro.cache` (readable with the readonly_claude login; value is a serialized array: `permissions[].b` = name, `.r` = role ids). Staging (prodev) instead uses `CACHE_STORE=file`. After running a seeder on prod, verify with that row's expiration (rebuild time + 24h) and decode it.
