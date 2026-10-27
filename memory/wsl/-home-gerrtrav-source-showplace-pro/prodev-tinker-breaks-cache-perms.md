---
name: prodev-tinker-breaks-cache-perms
description: "Running php artisan tinker/artisan on prodev as travisgerry writes cache/view files www-data can't write into, which 500s staging"
metadata:
  node_type: memory
  type: project
  originSessionId: 1444a5d3-d04c-4f4b-af64-ce821de20c30
  modified: 2026-10-07T20:07:56.344Z
---

On prodev (staging), running `php artisan tinker` (or any artisan command that touches the cache) as `travisgerry` creates `storage/framework/cache/data/xx/yy` dirs and compiled views owned `travisgerry:travisgerry` (umask 002, group not www-data). The app runs as www-data with CACHE_STORE=file, so any later cache write into those dirs fails with `file_put_contents(... storage/framework/cache/data/...): Failed to open stream` → 500 on pages like /quotes/edit. Happened 2026-10-07 during SPPRO-4854 testing.

**Why:** the deploy hook only chowns the work tree back to www-data at deploy time; files created afterwards keep my user/group.

**How to apply:** Avoid running app code via artisan on prodev; prefer read-only DB queries or the browser driver. If unavoidable, run it with the www-data group (`sg www-data -c "umask 002; php artisan ..."`) and afterwards check `find storage bootstrap/cache -user travisgerry -not -group www-data`; fix with `chgrp www-data` + `chmod g+w` (needs the user's OK; the auto-mode classifier blocks remote writes). A `git push prodev master` deploy also re-chowns everything. See [[deploy-scripts-locations]].

Spatie permission cache on prodev (SPPRO-5005, 2026-10-15): after `sg www-data -c "php artisan db:seed --class=RolesPermissionsSeeder"`, the cache file `storage/framework/cache/data/85/5f/855f…` (key `spatie.permission.cache`) had been rebuilt by www-data with the OLD role mappings, and `permission:cache-reset` printed "Unable to flush cache": the cache dirs are www-data 755, so the sg group trick doesn't allow deleting them. Sudo on prodev needs the user's password. Run seeders/cache resets as `sudo -u www-data php artisan ...` by asking the user to run `ssh -t prodev 'cd /var/www/showplace_pro && sudo -u www-data php artisan ...'` in their own terminal: the `!` prefix has no TTY, so sudo cannot prompt for the password (tried 2026-10-15).

Worked cleanly on 2026-10-20 (SPPRO-5091): `ssh prodev 'cd /var/www/showplace_pro && sg www-data -c "umask 002; /usr/bin/php8.5 artisan <command>"'`, and for ad-hoc tinker scripts scp the script to /tmp and pipe it in (`artisan tinker < /tmp/x.php`; `tinker /tmp/x.php` only includes files with a `<?php` tag and otherwise just echoes them). The `find storage bootstrap/cache -user "$(id -un)" -not -group www-data` check came back empty every time.
