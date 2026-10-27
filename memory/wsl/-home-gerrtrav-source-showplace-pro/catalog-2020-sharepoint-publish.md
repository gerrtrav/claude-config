---
name: catalog-2020-sharepoint-publish
description: SPPRO-5162 epic replaces ~/upload_catalogs.sh (scp of Bluestem 2020 catalogs) with SharePoint + in-app Publish; site TBD; publishers Beth Roush + IT
metadata:
  type: project
---

Bluestem 2020 catalog releases (6 bl##*.Zip + BL## INSTALL/UPDATES pdf, ~2.6 GB, built in-house by the catalog team) used to be copied by the user with `~/upload_catalogs.sh` (scp to proprod `public/storage/resource_documents/2020Catalogs`) plus a hand edit of `BLUESTEM_2020_DOWNLOAD_VERSION`. On 2026-10-27 the user chose to replace that with SharePoint drop folder → app pulls via the existing Graph app (Sites.Selected) → admin Publish screen → prune old versions (33 GB on prod at the time).

Jira: epic SPPRO-5162; tasks 5163 (SharePoint site + access; **site/path deliberately left TBD**), 5164 (admin screen, permission, version in DB, flag), 5165 (download/verify/switch job), 5166 (pruning + one-time prod cleanup). Sub-tasks 5167–5178. All assigned to Travis Gerry.

**Why:** the user wanted it off their PC, faster, and runnable by others.

**How to apply:** publishers are Beth Roush (Marketing role in the app, so grant her directly, not the whole role) and the IT Department, which uses the Super Administrator role (user confirmed 2026-10-27). Don't pick the SharePoint site yourself; ask.
