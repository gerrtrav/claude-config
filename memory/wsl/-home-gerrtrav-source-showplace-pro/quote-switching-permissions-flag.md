---
name: quote-switching-permissions-flag
description: SPPRO-5186 quote account/user switching by permission is behind FEATURE_QUOTE_SWITCHING_PERMISSIONS_ENABLED (on staging, off prod); prod needs seeders before flipping
metadata:
  type: project
---

SPPRO-5186 (2026-11-03): canChangeAccount/canChangeUser (User model) and the Selection Center order form switch from a role-name list to permissions when `QuoteSwitchingPermissionsFeature` is on (single toggle `FEATURE_QUOTE_SWITCHING_PERMISSIONS_ENABLED`, default off). New permission "Change Account On Any Quote" granted to Marketing and Customer Service Administrator. With the flag on, Credit gains both switches (user approved).

Staging: seeders run and flag on (backup ~/env.bak-SPPRO-5186) on 2026-11-03; the app's Spatie cache file needed a sudo `permission:cache-reset` (or expiry ~10:07 on 11-04) before Marketing/CSA see the new grant.

**Why:** The user wanted it flagged so the release isn't blocked on seeding production.

**How to apply:** Before turning the flag on in production: run PermissionsSeeder then RolesPermissionsSeeder and `permission:cache-reset` as www-data on proprod, then add the env line. Otherwise Marketing and Customer Service Administrator users without Customer Service lose account switching. Related: [[prefer-permissions-over-roles]], [[single-feature-flag-for-fixes]], [[prodev-tinker-breaks-cache-perms]].
