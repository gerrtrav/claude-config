---
name: legacy-site-retirement
description: SPPRO-5144 epic retiring legacy.showplacepro.biz: where legacy files/pages live on prod, and the user's decisions (files via app w/ login, images public, warranty rebuilt, newUser → password reset)
metadata:
  type: project
---

SPPRO-5144 (Epic, created 2026-10-26 after ITHD-3513 when the legacy vhost was down): turn off the legacy PHP site but keep its URLs working.

Facts (prod `pro-linode-single-prod`, same box as the app and pro-api):
- `legacy.conf` and `proapi.conf` Apache vhosts BOTH use DocumentRoot `/var/www/pro` — change only the legacy vhost.
- `/var/www/pro/orderFiles` and `/p3ordfiles` symlink to `/mnt/pro-server-media-store/pro/media/...`; pro-api writes uploads there. `/var/www/pro/images` = 61 shared files. Staging has real dirs at `/var/www/pro/{orderFiles,p3ordfiles,images}`.
- `/2020/newUser` writes the old `sppro.user` table (not `users`), effectively dead. `/warranty` form broken since 2021-05-19 (mysql_* on PHP 8), table `sppro.consumerwarranty`.

User decisions: serve order files from the app, login required, access = MainOrderPolicy@view (order's account + any-account permission holders); `/images` stays public; rebuild warranty as public form emailing korsscot@ (config); `/2020/newUser` → forgot-password redirect, drop dead SendKey view.

Tasks: 5145 order files (subtasks 5150-5152), 5146 images, 5147 warranty (5153-5154), 5148 newUser, 5149 legacy vhost → 301 to showplacepro.biz (assigned Shad; wait until 5145/5146 flag on in prod).

Related: [[server-sudo-changes-shad]], [[single-feature-flag-for-fixes]]

Found 2026-10-26: BOTH post-receive hooks (prodev line 67, proprod line 86) run `ln -s /var/www/pro/p3ordfiles "$RELEASE/public/p3ordfiles"`, so Apache serves /p3ordfiles/<file> publicly and bypasses OrderFileController. Removing that line (and the link in the live release) is required before 5145's login check is real; Staging hook line removed by me 2026-10-26 with the user's OK (backup prodev:~/post-receive.bak-SPPRO-5145); prod step left as a comment on SPPRO-5149 (do before prod flag-on). SPPRO-5145, 5146, 5147 and 5148 → Ready for QA 2026-10-26 (5147 flag on in staging, backup ~/env.bak-SPPRO-5147; subtasks 5153/5154 Done; only 5149 (Shad, prod server) left) (5148 flag FEATURE_LEGACY_NEW_USER_REDIRECT_ENABLED on in staging, backup ~/env.bak-SPPRO-5148) (staging flag on, backup ~/env.bak-SPPRO-5145); subtasks 5150-5152 Done. Legacy images = 845 files (doorimages/, metaldoors/); metal door configurator images come from proapi (API_IMAGES_PATH), not legacy. Staging also runs legacy.pro-staging.showplacewood.com (vhost legacy.pro-staging.conf, docroot /var/www/pro).

2026-10-26: staging legacy vhost (legacy.pro-staging.conf) switched to 301 → pro-staging.showplacewood.com, no PHP (backup /root/legacy.pro-staging.conf.bak-SPPRO-5149; staged copy prodev:~/legacy.pro-staging.conf.new). /etc/apache2 is root-only and prodev sudo needs a password; the `!` prompt can't feed sudo a password ("a terminal is required"), so the user ran it in their own terminal. Staging cert renews via dns-dnsmadeeasy. Recorded on SPPRO-5149.

SPPRO-5147 warranty form uses Turnstile; proprod .env has NO TURNSTILE_SITE_KEY/SECRET_KEY (staging does). Prereq comment on SPPRO-5147: add prod keys (hostname showplacepro.biz allowed in Cloudflare) before FEATURE_WARRANTY_REGISTRATION_ENABLED goes on in prod. consumerwarranty is latin1: form rejects non-Latin-1 text with a validation message.

2026-10-26 later: user changed SPPRO-5147 to upload to Webdocs Customer Service Documents instead of email (subtasks 5157 upload, 5158 optional order number lookup; both Done; 5147 back to Ready for QA). Webdocs CS index fields: 1 = account, 2 = (Frontier) order number, 13 = Pro quote number; title "Warranty Registration". Settings: WEBDOCS_CS_UPLOAD_DOCUMENT_TYPE (kept separate from WEBDOCS_CS_DOCUMENT_TYPE, which order-document searches use — setting that to a test type emptied staging lookups), WEBDOCS_CS_FOLDER_ID (prod default F7B6363F-E1A5-46CF-8BB7-1991A7C770E6). Staging: upload type 991A79FB-9100-424C-834E-77E943D17B23 (test), folder 80478CB5 (testing). The Webdocs API login can't list folders/doc types (401). Staging test registration 2316 → Webdocs doc 8EFD87E5-909A-4419-9237-94AC76C42FB7.

2026-10-27 SPPRO-5160 (Done, no staging QA per user): the "dealer locator" outside systems depend on is the legacy POST feed /2020/tech/extDealerList.php (authKey/authPass, CSV of Frontier DL dealers), pulled daily by 64.225.6.183 (2x) and 24.220.114.202. Rebuilt in app at the same path behind FEATURE_LEGACY_DEALER_FEED_ENABLED + LEGACY_DEALER_FEED_AUTH_KEY/PASS (user: don't copy the creds to staging; prod values come from the legacy file). /dealerLocator → 301 to showplacecabinetry.com/dealer-locator/. SPPRO-5149 comment: legacy vhost must 308 that path (a 301 turns POST into GET) and prod .env needs flag + creds first. Legacy admin pages viewLocatorInfo/editorDealerLocator: unused, not rebuilt.
2026-10-27: with the user's OK, LEGACY_DEALER_FEED_AUTH_KEY/PASS added to proprod shared/.env (lines 226-227, copied server-side from the legacy file; backup ~/env.bak-SPPRO-5160, chmod 600). Then FEATURE_LEGACY_DEALER_FEED_ENABLED=false added (line 226; creds now 227-228); sed -i made travisgerry the .env owner (group www-data kept). SPPRO-5149 comment 52973: Shad only does the vhost 308 (after the flag is on). The USER turns FEATURE_LEGACY_DEALER_FEED_ENABLED on in prod themselves when the release with SPPRO-5160 is pushed; remind them at release time.
