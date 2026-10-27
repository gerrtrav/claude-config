---
name: single-feature-flag-for-fixes
description: "When asked to put a fix behind a feature flag, use one all-users toggle, not the ENABLED/INTERNAL_ENABLED pair"
metadata:
  node_type: memory
  type: feedback
  originSessionId: fa933dff-696e-45aa-8e34-ca69e55897bd
  modified: 2026-10-08T19:07:33.595Z
---

When the user asks to put a change (especially a bug fix / API-failure handling) behind a feature flag, use a single all-users toggle `FEATURE_<NAME>_ENABLED` only, not the paired `_INTERNAL_ENABLED` toggle that AGENTS.md describes. Follow `App\Features\AddLineItemApiFailureHandlingFeature` (SPPRO-4850) and `QuoteSectionLoadFailureHandlingFeature` (SPPRO-4877): config default `false`, `.env.example` `=true`, docblock "Single all-users toggle".

**Why:** On SPPRO-4877 (2026-10-08) the user said "wrap this behind a single feature flag" and then "only use one feature flag" while I was reading the paired-toggle pattern.

**How to apply:** Default to one toggle for flags the user requests on fixes; ask only if the request is clearly a staged internal-first rollout. Enable it on staging per [[deploy-scripts-locations]] before QA.

On SPPRO-4594 (2026-10-13), after a Livewire state-size refactor was already merged and deployed unflagged, the user asked "add a feature flag for this one", so it got `QuoteFormSlimSnapshotsFeature` (single toggle) after the fact. For refactors that change runtime behavior on the quote form, offer a flag up front. `#[Locked]` can't follow a flag; use an `updating<TraitName>` trait hook that throws `CannotUpdateLockedPropertyException` (see `Concerns\LocksStaticStateWhileSlimmingSnapshots`).
