---
name: webdocs-dms-folders
description: Webdocs folder 80478CB5-… is the testing folder (staging/.env.example); prod DMS files belong in E5044028-3B0F-4C27-8C5D-BE57276C1883
metadata:
  node_type: memory
  type: reference
  originSessionId: dafb3085-4a0e-48b7-9934-59c50f997414
  modified: 2026-10-12T13:55:24.729Z
---

DMS request files are uploaded to the Webdocs folder in `WEBDOCS_FOLDER_ID`. Staging and production talk to the same Webdocs server (`https://webdocs.showplacewood.com/api/`).

- `80478CB5-943F-4B66-BC03-CEA80FBB0429` is a **testing folder**. Staging (`prodev`) and `.env.example` use it, and the user wants staging left on it (2026-10-12). QA checks staging uploads there.
- `E5044028-3B0F-4C27-8C5D-BE57276C1883` is the real production DMS folder. On 2026-10-12, prod was wrongly set to the testing folder; fixing that is part of the SPPRO-4892 release.

**How to apply:** don't "fix" staging's folder ID, and don't treat the testing folder as wrong outside production. Related: [[staging-remote-prodev]], [[deploy-scripts-locations]].
