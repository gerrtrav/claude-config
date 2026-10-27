---
name: users-email-stray-spaces
description: "Some sppro users.email values have trailing spaces; MariaDB PAD SPACE matches them in SQL, so trim before keying PHP arrays by email"
metadata:
  node_type: memory
  type: project
  originSessionId: e763502d-afa0-4526-94d9-b41bfe8b42fd
  modified: 2026-10-27T11:55:49.669Z
---

Some `users.email` values (seen on staging 2026-10-27, SPPRO-4802) end in a space. MariaDB's PAD SPACE collation makes `LOWER(email) IN (...)` match them, but PHP then keys the result with the space, so lookups back into the input list fail ("Undefined array key"). SQLite tests don't pad, so they won't catch it.

**How to apply:** When matching users by email, use `LOWER(TRIM(email))` in SQL and `strtolower(trim($user->email))` for array keys. The production marketing import (`user-profiles:import-marketing-subscriptions`) has this fix as of 971ba087f.
