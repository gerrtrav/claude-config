---
name: local-login-superadmin
description: "To log in to the local showplace-pro app (e.g. for browser testing), use superadmin@showplacewood.com with the seeded factory password via the normal Laravel login form"
metadata:
  node_type: memory
  pinned: false
  originSessionId: 3f1ebf40-2433-45fa-9e27-db842f389dbc
  modified: 2026-09-24T16:24:10.524Z
---

When logging in to the local showplace-pro app (for example, driving it with a headless browser to reproduce a bug), use the standard Laravel login form at `/login` with `superadmin@showplacewood.com` (created in `database/seeders/UserSeeder.php`, role Super Administrator). The password is the one set in `database/factories/UserFactory.php` (the `Hash::make(...)` value), which all seeded users share.

The user corrected me: login uses the built-in Laravel process, not an external auth service, so don't assume credentials are validated externally and don't forge sessions via tinker. Also don't pick a random seeded user such as the dealer account; use the superadmin one.
