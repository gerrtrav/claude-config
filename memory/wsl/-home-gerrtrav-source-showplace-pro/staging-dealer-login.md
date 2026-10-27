---
name: staging-dealer-login
description: Dealer account and password source for browser-testing on staging/dev (pro-staging.showplacewood.com)
metadata:
  type: reference
---

To test as a dealer on staging/dev (https://pro-staging.showplacewood.com/), log in as `tiffany@reposakitchens.com` (given by the user on 2026-10-05 for ITHD-3130).

The password lives in the `STAGING_APP_PASSWORD` env var, which the user sets in the `env` block of the gitignored `.claude/settings.local.json` (set up 2026-10-05). Run the driver with `APP_URL=https://pro-staging.showplacewood.com APP_PASSWORD="$STAGING_APP_PASSWORD"`. Never store the password itself in memory or the repo, and never guess it; if the var is empty, ask the user. The "Testing on staging" section of the run-showplace-pro skill has the full steps. See [[staging-remote-prodev]] and [[local-login-superadmin]].

To test admin-only behavior on staging (2026-10-14, SPPRO-4978/4980), the user had me temporarily switch this account (user id 21829, normally role "Dealer" only, no direct permissions) to "Super Administrator" via `sg www-data -c "umask 002; php artisan tinker ..."` with `syncRoles`, then switch it back to `["Dealer"]` afterwards. Approval is per test: a second switch without a fresh OK was blocked by the auto-mode classifier, so ask each time.

On 2026-10-15 (SPPRO-4684 baseline screenshots) the user asked again ("change the staging user you have to super administrator"); same syncRoles steps, switched back to ["Dealer"] right after, no stray non-www-data files.

On 2026-10-20 (SPPRO-503) the user had me move this login's only profile (user_profiles id 1884) from account RE3668 to **SH2200** (Showplace Wood Products), which has many orders and Webdocs documents for report testing (RE3668 had almost none). Done with a tinker script on prodev (`sg www-data`), plus `Cache::forget('profile_21829')`. It stays on SH2200 unless the user asks to switch it back. Open Orders sorted by Order Number desc (one click) shows recent orders that have acknowledgements.
