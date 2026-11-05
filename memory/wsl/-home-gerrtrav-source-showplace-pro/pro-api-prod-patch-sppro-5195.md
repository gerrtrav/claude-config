---
name: pro-api-prod-patch-sppro-5195
description: "SPPRO-5195 lineConfigure/rushLineConfigure read-after-write patch live on prod /var/www/pro since 2026-10-28; awaiting Jay's develop commit; jaylee-group files need sudo cp"
metadata:
  node_type: memory
  type: project
  originSessionId: 16e0b8d1-4cb2-4cfb-9ceb-16bef7820879
  modified: 2026-10-28T18:53:39.424Z
---

SPPRO-5195 (2026-10-28): the globals fix (pro-api 205b991a + cf2c41fd, loadFrontierGlobal.php) was put on prod by Jay on 10-27. The ProxySQL read-after-write workaround (new line → read mainorder by `$newLineOrderNumber` instead of the oliid subquery) went on prod as a temporary patch on 10-28 at 13:52, for both lineConfigure.php and rushLineConfigure.php. md5s were checked, and status comment 53160 was posted. It still needs Jay to commit it to pro-api develop, then `./update-pro-api --push SPPRO-5195`.

Prod pro-api file permissions vary. Some files are www-data:www-data (group-writable, so the user can `cat >` over them, see [[weathered-block-sppro-5208]]). Others are jaylee:jaylee, which the user's account can't write. For those, run `sudo cp` from a patched copy in ~ in their own terminal (sudo asks for a password); cp onto an existing file keeps its owner and mode. Run `ls -l` before giving apply steps. Read-only checks (ssh grep/md5sum) work; scp to proprod was blocked by the auto-mode classifier.

Prod's rushLineConfigure.php is out of sync with develop (`$ususer` vs `$uid` in PageError, extra `new Page(...)` line).

Jay is out until about 2026-11-04, so the permanent pro-api fix waits until he is back. Per the user (2026-10-28), this ticket stays In Progress and does not hold up the next app release, because the temporary prod patch lives in /var/www/pro, outside the app release folders.
