---
name: staging-debugbar-disabled
description: Staging runs APP_DEBUG=true; Debugbar was turned off there (DEBUGBAR_ENABLED=false) on 2026-10-22 because its JS froze big Livewire pages
metadata:
  type: project
---

Staging (`prodev`) runs with `APP_DEBUG=true`, which also turned on Laravel Debugbar. On 2026-10-22 (SPPRO-5097), QA reported "Page Unresponsive" in Other Dealers at 50/All per page. Profiling showed Debugbar's JS (`Sfdump` / `addDataSet`) caused 2.4–4.9 s browser long tasks on each Livewire update; with Debugbar blocked there were none. With the user's OK I appended `DEBUGBAR_ENABLED=false` to `/var/www/showplace_pro_deploy/shared/.env` (backup `~/env.bak-SPPRO-5097`). APP_DEBUG stays true. Production has no Debugbar.

**Why:** "Slow/unresponsive only on staging" reports can be Debugbar, not app code.

**How to apply:** If staging feels slower than prod, first check whether Debugbar is back (`curl -s https://pro-staging.showplacewood.com/login | grep -ci debugbar`). Local dev still has Debugbar on, so block `**/_debugbar/**` in the browser driver when measuring frontend performance. Related: [[deploy-scripts-locations]], [[staging-remote-prodev]].
