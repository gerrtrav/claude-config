---
name: livewire-nested-array-payload
description: Swapping a big Eloquent collection for arrays of arrays in Livewire state can bloat the snapshot; measure it first
metadata:
  type: project
---

Livewire dehydrates an Eloquent collection to just its keys, but an array of arrays adds a `{"s":"arr"}` wrapper per item. On SPPRO-4625 (2026-10-08), holding QuoteForm's ~8,300 accounts as `[id, label]` arrays grew a Super Admin's quote-form snapshot from 79 KB to 599 KB (sent both ways on every request). The fix was a `#[Computed(persist: true)]` option list, so the accounts never sit in state (snapshot about 4 KB).

**Why:** the "replace model collections with scalar arrays" perf pattern only pays off for small or capped lists.

**How to apply:** before converting a public collection to arrays, check its size. Measure the live snapshot with the run-showplace-pro driver: `eval Livewire.all().map(c => JSON.stringify(c.snapshot).length)`. Large lists belong in a persisted/cached computed, not in public state.
