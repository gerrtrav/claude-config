---
name: livewire-flash-message-morph
description: "A flash message rendered inside a Livewire component vanishes on the next update and shifts siblings, breaking child components (\"Snapshot missing\")"
metadata:
  node_type: memory
  type: project
  originSessionId: a78769d2-07e3-417f-920e-6687b83cb99f
  modified: 2026-10-14T13:33:12.116Z
---

A `<x-session-messages/>` rendered directly inside a Livewire component appears only on the first render after a redirect with `session()->flash(...)`. It's gone on the next Livewire update, the sibling elements shift up, and Livewire morphs them into the wrong ones. Child components disappear, and the console shows "Snapshot missing on Livewire component" and Alpine "shown is not defined". Fix: always render a wrapper `<div>` around it. SPPRO-4928 (2026-10-14) fixed this only in the quote form (duplicate → redirect). Many other Livewire views still embed it bare.

**Why:** it took a long time to find, because the bug only happens on the request right after a flash and nothing is logged server-side.

**How to apply:** if a page breaks only right after a redirect that flashes a message, check this first. Reproduce with the run-showplace-pro driver by calling the action through `Livewire.all()...$wire.method()`, then `errors`.
