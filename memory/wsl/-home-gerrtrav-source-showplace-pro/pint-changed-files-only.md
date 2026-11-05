---
name: pint-changed-files-only
description: "Run Pint only on the files I changed, never on a directory; dirs pull in unrelated style fixes"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d2ed1402-a266-4687-abba-9f30e65f4a79
  modified: 2026-10-30T13:55:54.320Z
---

Run `sail pint` with the exact changed file paths, never a directory. On SPPRO-5221 (2026-10-30), `sail pint app/Http/Livewire/Dms tests/Feature/Livewire/Dms` reformatted 11 unrelated DMS files, and `git add -A` committed them. I redid the commit, but discarding the leftover changes (`git checkout --`) was blocked by auto mode, so they went into a stash ("SPPRO-5221: unrelated Pint style changes", which oddly shows as "On docker-changes").

**Why:** many files in this repo aren't Pint-clean, so a directory run creates noise commits.

**How to apply:** `sail pint $(git diff --name-only -- '*.php')` plus new files. Stage files by name, not `git add -A`. Note that zsh does not word-split `$var` lists; use arrays or explicit paths.
