---
name: shared-checkout-check-branch
description: Other sessions share the main showplace-pro checkout and may switch branches mid-task; check the current branch before rebase/merge
metadata:
  type: feedback
---

On 2026-10-26 (SPPRO-5146), while my full test suite ran (~8 min), another session created and checked out `sppro-5156-dms-livewire-404` in the same checkout. My land step (`git rebase master && git checkout master && git merge --ff-only <mine>`) rebased THEIR branch (a no-op) and switched the checkout out from under them. Nothing was lost (their branch had no commits or uncommitted changes), but they were silently left on master.

**Why:** several Claude sessions work in /home/gerrtrav/source/showplace-pro at once.

**How to apply:** before landing, run `git branch --show-current` and `git status` and stop if it isn't my branch; rebase by name (`git rebase master <my-branch>`). For long-running work, consider a worktree ([[worktree-test-setup]]). If I do switch someone's checkout, tell the user right away.

Same day (SPPRO-5148): I pushed prodev first, then origin was rejected because the SPPRO-5156 session had pushed origin (not prodev) meanwhile. Rebasing onto origin/master then needed a force push to prodev, which the auto-mode classifier blocks ([Git Destructive]); the user had to run it. **Fetch origin and rebase BEFORE pushing prodev**, and push origin first, so prodev never gets commits that origin will reject.
