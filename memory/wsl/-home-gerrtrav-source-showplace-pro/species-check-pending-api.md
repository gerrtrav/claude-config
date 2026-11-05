---
name: species-check-pending-api
description: "SPPRO-5193 species check is merged and on staging but flag-off, waiting on Jay's pro-api skuValidate (SPPRO-5191); Confluence tech docs update deferred to go-live"
metadata:
  node_type: memory
  type: project
  originSessionId: 58497b83-e38e-4bae-a421-38cd790f9e90
  modified: 2026-11-02T22:22:23.305Z
---

SPPRO-5193 (epic SPPRO-5189, species exceptions for moldings and accessories; go-live 2026-11-30) was merged on 2026-11-02 (2e8f23f14..804a44f31) and pushed to origin and prodev. On staging, `FEATURE_SPECIES_CHECK_ENABLED` and `FEATURE_SPECIES_CHECK_INTERNAL_ENABLED` were appended to the shared .env as false (backup `prodev:~/env.bak-SPPRO-5193`). SPPRO-5193 stays In Progress, and its mirror TT-858 is in Waiting on Others. The API contract (`data[partsku]`, success/message) is in a comment on SPPRO-5191 for Jay. On 2026-11-04, at Jay's request, the element was renamed from `speciesCheck` to the generic `skuValidate` (af8c49fdb, on staging); class/flag names stayed SpeciesCheck*.

**Why:** the pro-api endpoint (SPPRO-5191) and the exception table (SPPRO-5190) didn't exist yet. The user chose to build against the contract behind a flag, and to block parts only when they're added, not in search results.

**How to apply:** when SPPRO-5191 lands on staging, check it against the contract, turn on the internal switch on staging, browser-test, then send SPPRO-5193 to QA (see [[jira-finish-to-qa]]). The user said to wait until go-live before updating the Confluence technical docs page ([[confluence-update-tech-docs-on-feature-change]]); do it then.
