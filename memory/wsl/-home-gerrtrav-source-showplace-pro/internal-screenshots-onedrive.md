---
name: internal-screenshots-onedrive
description: Screenshots/artifacts showing staging dealer data go in the user's OneDrive 1.Documentation/QA folder, not Jira attachments
metadata:
  type: reference
---

Staging screenshots taken as a Super Administrator show dealer names, addresses and account lists. On 2026-10-15 (SPPRO-4684) the auto-mode classifier blocked attaching them to Jira ("Excess Sensitive Detail"), and the user chose "keep them internal".

They went to the user's synced OneDrive at `/mnt/c/Users/gerrtrav/OneDrive - Showplace Wood Products/1.Documentation/QA/<TICKET> <short name>/` (written directly from WSL; it syncs, and stays private until the user shares it). The Microsoft 365 connector's `sharepoint_upload_file` caps files at 1 MB, so it can't take zips or full CSS builds. Then mention the folder (not the files) in the Jira comment. See [[staging-dealer-login]].
