---
name: proprod-tinker-psysh-blocked
description: On proprod, `sudo -u www-data php artisan tinker` dies (psysh can't write /var/www/.config); use a standalone PHP script that bootstraps the app
metadata:
  type: reference
---

On proprod (2026-11-05, SPPRO-5162), `sudo -u www-data /usr/bin/php8.2 artisan tinker` fails: www-data's home is root-owned `/var/www`, so psysh can't create `/var/www/.config/psysh`. Piping a script on stdin over `ssh -t` printed only the notice and ran nothing; `tinker --execute` turned it into a fatal "Writing to directory /var/www/.config/psysh is not allowed" (ConfigPaths.php line 456).

**How to apply:** for ad-hoc data changes on prod, write a standalone script that starts with `require '/var/www/showplace_pro/vendor/autoload.php'; $app = require '/var/www/showplace_pro/bootstrap/app.php'; $app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();`. The user scp's it to proprod:/tmp and runs `ssh -t proprod 'cd /var/www/showplace_pro && sudo -u www-data /usr/bin/php8.2 /tmp/x.php && sudo -u www-data /usr/bin/php8.2 artisan permission:cache-reset'` in their own terminal (sudo needs a password). Verify afterwards with [[production-readonly-db]]. Prod workers and CLI use php8.2.

Prod permissions lag the seeders (newest was 2026-09-22 before 5162). RolesPermissionsSeeder `syncPermissions` every role, so don't run it on prod blindly; create single permissions with firstOrCreate + givePermissionTo instead. Related: [[prodev-tinker-breaks-cache-perms]].
