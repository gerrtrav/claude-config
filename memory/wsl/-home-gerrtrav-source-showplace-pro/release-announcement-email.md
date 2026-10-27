---
name: release-announcement-email
description: "After each production release (release-YYMMDD), draft an Outlook release email: what shipped + what's waiting on QA; To Sarah Kirchner & Mayas Knaizeh, CC Andrew Gilbert"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5aea40f6-1597-421d-bb7f-350739910d19
  modified: 2026-10-22T12:18:24.907Z
---

After a release-YYMMDD tag is deployed to production and verified, draft (do not send) an Outlook email with
`outlook_create_draft`:

- **To:** Sarah.Kirchner@showplacecabinetry.com, Mayas.Knaizeh@showplacecabinetry.com
- **CC:** Andrew.Gilbert@showplacecabinetry.com
- **Subject:** `ShowplacePro production update: release YYMMDD`
- **Body (HTML), plain language, each item linked to its Jira ticket:**
  1. When it went out (date and time from the release folder's timestamp) and that there was no downtime.
  2. "What changed for users": user-visible tickets, described in a sentence (check the commit for exact behavior).
  3. "Behind the scenes (nothing visible to users)": docs, dev tooling, refactors.
  4. "Waiting on QA for the next release": what's on master/staging but not in the tag, grouped as Retest (failed QA, fix
     on staging), Ready for QA, and Behind a feature flag (lower priority; can ship switched off). Re-query Jira
     statuses; "Ready For Testing" and Done count as passed ([[sppro-ready-for-testing-means-passed]]).
  5. Sign off "Thanks,<br>Travis" (no Outlook signature is added to Graph drafts).

Also create the Jira release for it: `manageJiraProjectVersion` (via `executeDestructive`) action create in SPPRO,
name = the tag (`release-YYMMDD`), released: true, releaseDate = deploy date, description "Production release deployed
YYYY-MM-DD (git tag release-YYMMDD, commit <short sha>)". Then set fixVersions on every ticket whose commits are in
the tag (`git log <previous tag>..<tag>`), keeping any existing fixVersions (e.g. an epic's feature version), and
verify with JQL `fixVersion = "release-YYMMDD"`. Parents of sub-tasks/epics are not added. First release done this
way: release-261022 (version id 10173).

**Why:** The user asked for this email after release-261022 (2026-10-22), set these recipients themselves, and asked
to remember it for the next release.

**How to apply:** Do it as part of finishing a production release, after checking the deploy (live symlink, REVISION,
site 200, no new errors, workers restarted). Give the user the draft link; they send it. Related:
[[release-tag-naming]], [[deploy-scripts-locations]].
