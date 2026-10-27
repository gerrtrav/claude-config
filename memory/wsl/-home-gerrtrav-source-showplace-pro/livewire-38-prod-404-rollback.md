---
name: livewire-38-prod-404-rollback
description: 2026-10-26 prod Livewire 404s = release-261026-2 shipped Livewire 3.8 without the SPPRO-3471 mod-key fix; release-261026-3 fixes it; partial releases must carry companion fixes
metadata:
  node_type: memory
  type: project
  originSessionId: f54991fb-29be-4f07-8294-c99a22762ce3
  modified: 2026-10-26T21:24:14.726Z
---

release-261026-2 (a partial release: release-261022-2 + cherry-picks) shipped Livewire 3.8.10 (SPPRO-4861) but not 5a228d572 (SPPRO-3471), which hashes mod details in the mod row wire:key. Without it, a quote with a mod that has details corrupts the line-items snapshot ("Invalid Livewire snapshot structure" → 404 with APP_DEBUG off), and every later request on that page fails. 83 404s on 2026-10-26 (SPPRO-5139–5142); 419s were pre-deploy tabs (3.8 release token). Prod was rolled back to release-261022-2 ~10:50.

Fix: release-261026-3 = release-261026-2 + 5a228d572 + temporary `LogRejectedLivewireUpdates` middleware (SPPRO-5142, toggle LOG_REJECTED_LIVEWIRE_UPDATES). The auto-mode classifier blocks pushing to proprod; the user runs the push.

Second miss (SPPRO-5156): the DMS page's child keys "orders-table-{{ now() }} }}" had a stray " }}" that master fixed in 8cd41444d (SPPRO-5100) but no partial release carried; the broken_snapshot logging (release-261026-4) showed it the same day; release-261026-5 adds the fix. The grep `git log --cherry-pick --right-only -i -E --grep='livewire 3\.8|SPPRO-4861|snapshot|wire:key|first "\}"' <release>...origin/master` finds such companions.

**Why:** Staging/local run master, which had the companion fix, so they couldn't reproduce it, and wasted hours chasing PHP 8.2 (ruled out; local Sail is PHP 8.2.30, not 8.5).

**How to apply:** When cherry-picking a dependency upgrade into a partial release, also take every later commit that mentions it (`git log --grep` for the ticket and the package name). When prod fails and staging doesn't, diff the deployed release against master first. Remove the temporary logging middleware once it has served its purpose. Related: [[release-tag-naming]], [[proprod-diverged-cherry-pick]].
