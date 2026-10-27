---
name: production-single-web-server
description: Production showplace-pro runs on one web server, so files a queue worker writes to storage/app are readable by web requests
metadata:
  type: project
---

Production has only one web server (user, 2026-10-14, SPPRO-4977). Files a queued job writes under `storage/app` (e.g. background report exports) can be served by a later web request without shared storage.

**Why:** I flagged "do web and workers share storage?" as an open risk for the queued Open Orders export; the user said there is only one production web server.

**How to apply:** Don't raise multi-server/shared-storage concerns for queue-written files. If that ever changes (a second web server is added), revisit jobs that write files for later download. See [[deploy-scripts-locations]].
