---
name: upload-size-tracking-waiting
description: SPPRO-4871 finished 2026-10-27 (resource-document 1 GB, tracking code removed); only the drop of sppro.upload_size_logs remains, in a later release
metadata:
  type: project
---

SPPRO-4871 went to Ready for QA on 2026-10-27. Resource-document limit 2 GB → 1 GB (27f0860c6), sized from the files on prod (`/var/www/showplace_pro/storage/app/public/resource_documents`, 1,128 files, max 713 MB zip, catalogs ~645–670 MB), and the tracking middleware/model/toggle were removed (a1cc7460b). Earlier, on 2026-10-22, quote-import was cut to 100 MB. None of these were in production as of 2026-10-27.

**Why:** the table `sppro.upload_size_logs` was NOT dropped, because migrations run while the previous release (which still writes to it) serves requests.

**How to apply:** once a release containing a1cc7460b is live on proprod, add a migration dropping `upload_size_logs` (mysql-pro) in a later release. Tracked as SPPRO-5179 (created 2026-10-27, assigned to the user, Parking Lot, linked Relates). See [[production-readonly-db]].
