---
name: cso-production-server
description: "Color Select Ordering prod = ssh alias `app` (swp-nginx-prod), /var/www/colorselectordering, nginx colorselect.conf, manual git pull"
metadata:
  node_type: memory
  type: reference
  originSessionId: ff6b1162-7a55-4c35-9aa5-15e712fcd18e
  modified: 2026-10-15T15:33:18.896Z
---

Color Select Ordering (repo ~/source/colorselectordering, Jira CSO) runs in production on ssh alias `app`
(swp-nginx-prod, 192.168.127.85, user travisgerry with sudo). App at /var/www/colorselectordering (code owned
by lanesmit; git needs `-c safe.directory=...`), site colorselectordering.app.showplacewood.com via
/etc/nginx/sites-enabled/colorselect.conf on the shared php8.2-fpm.sock. Deployed by manual git pull of
`master`. CSO deploys follow the showplace_pro prodev hook pattern (user preference): sudo chown the tree to the deploying user, run git/composer/yarn/artisan as that user (their own Bitbucket key), trap + final chown -R www-data:www-data. Do not give www-data its own key. The server hosts many other internal apps under /var/www. The PHP 8.5 runbook is on CSO-15.
