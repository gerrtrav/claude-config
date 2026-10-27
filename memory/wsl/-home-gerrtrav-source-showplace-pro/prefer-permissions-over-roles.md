---
name: prefer-permissions-over-roles
description: "When implementing authorization/access-control logic, gate on a Spatie permission rather than a hard-coded role name, and reuse an existing permission before creating a new one"
metadata: 
  node_type: memory
  pinned: false
  originSessionId: 629bed56-60f3-45c5-b771-fec96c4ff67b
  modified: 2026-09-21T18:48:59.917Z
---

When adding or fixing authorization checks in showplace-pro, prefer gating access on a permission (`$user->can('...')` / `$user->canAny([...])`) rather than a hard-coded role name (`$user->hasRole('...')` / `$user->hasAnyRole([...])`). The user explicitly corrected an implementation that checked roles directly (e.g. `hasAnyRole(['Super Administrator', 'Marketing', ...])`) and asked for permission-based checks instead.

When a suitable permission already exists in `database/seeders/PermissionsSeeder.php` (e.g. `View Any User`, `View Any User For My Account`, `View Any User For My Rep Accounts`), reuse it rather than defining a new, feature-specific permission. The user explicitly corrected a follow-up where new permissions were created to avoid coupling with an existing permission's other uses elsewhere in the app; the user's preference is to reuse what's already there. Only add a new permission when no existing one already conveys the needed meaning. If the existing permission isn't granted to all the roles the new feature needs, add the missing grants to it in `database/seeders/RolesPermissionsSeeder.php` rather than introducing a parallel permission.
