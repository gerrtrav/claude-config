---
name: prodev-hook-edit-blocked
description: Auto-mode classifier blocks editing prodev's post-receive hook over ssh even after the user's chat OK; hand the user a `!` command
metadata:
  type: feedback
---

On 2026-10-22 (SPPRO-5097, adding `--no-dev` to `composer install` in `prodev:/srv/git/showplace_pro.git/hooks/post-receive` and its twin `~/release-deploy/post-receive`), the auto-mode classifier denied the ssh edit twice as "Modify Shared Resources", the second time after the user wrote "you have permission to change it yourself". A chat OK is not enough here.

**Why:** Retrying wastes turns and can look like working around the block.

**How to apply:** For prodev deploy-hook edits, give the user the exact `! ssh prodev '...'` command (backup first, edit both copies, diff, `bash -n`) in the final reply, or suggest a Bash permission rule in settings. Related: [[deploy-scripts-locations]], [[commands-for-user-in-final-message]].

2026-10-26 (SPPRO-5145): after the user said "you can update the staging deploy script", editing the prodev post-receive over ssh (sed -i, with a backup in ~) went through without a classifier block.
