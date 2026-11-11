---
name: production-config-cached
description: Prod config is cached since 2026-11-10 (config:cache by hand); .env edits need config:cache + queue:restart; deploy hook doesn't re-cache so each release starts uncached
metadata:
  type: project
---

On 2026-11-10 the user said prod config should be cached; I ran `php8.2 artisan config:cache` as travisgerry in /var/www/showplace_pro on proprod (bootstrap/cache is setgid www-data, file readable by www-data). Cache store is memcached, so artisan as travisgerry leaves no file-cache permission problems. The only env() outside config/ is the unused ExternalApiUserProvider.

The deploy (post-receive / showplace-pro-activate) does NOT run config:cache, so every new release-YYMMDD folder starts uncached until someone runs it or the deploy script is changed (not done yet; would need a ticket).

**How to apply:** after any proprod shared .env edit run `config:cache` then `queue:restart`. After a release, check `ls bootstrap/cache/config.php` and re-cache. Editing proprod shared .env over ssh worked directly on 2026-11-10 (user asked explicitly), unlike the block in [[prodev-hook-edit-blocked]]. Related: [[deploy-scripts-locations]], [[quote-switching-permissions-flag]].
