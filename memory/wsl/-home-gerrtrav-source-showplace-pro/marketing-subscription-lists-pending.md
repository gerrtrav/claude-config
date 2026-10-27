---
name: marketing-subscription-lists-pending
description: "Pending as of 2026-10-07 - attach Justin's marketing CSVs (listExport.csv, Opted_Out_List.csv) to SPPRO-4802/4803 once Justin confirms the opt-out date column"
metadata:
  node_type: memory
  type: project
  originSessionId: 74ffb810-b655-4a27-9d81-29804a91491e
  modified: 2026-10-07T19:04:55.467Z
---

On 2026-10-07 the user asked to attach Justin Ehrman's two CSVs from the Outlook thread "PRO Marketing Email Subscriptions: How to handle existing users?" to Jira. The CSVs are `listExport.csv` (dealers currently emailed, with scores) and `Opted_Out_List.csv` (people who unsubscribed). The likely ticket is SPPRO-4802 (Upload List of Subscribed Users from Justin); SPPRO-4803 (default to unsubscribed) is related.

The user chose to wait until Justin hears back from the Salesforce rep about which column in the opted-out list holds the true opt-out date ("First Assigned" vs "Updated Date"). After that, the user will provide a personal Jira API token (via env var) so the files can be uploaded through the Jira REST API, because the Atlassian MCP connector cannot upload attachments.

**Why:** The data may change after Justin's answer, and the connector has no attachment upload.
**How to apply:** When this comes back up, search Outlook for Justin's newer replies in the thread, re-download the latest CSVs, ask the user which ticket(s) get the opted-out list, then upload using the token. Don't use the app's own Jira credentials.
