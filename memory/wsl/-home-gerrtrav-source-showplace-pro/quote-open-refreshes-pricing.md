---
name: quote-open-refreshes-pricing
description: "Opening a quote refreshes its pricing and editing job info locks it, so GlobalGroup's globalsSave re-saves are intended and must be kept"
metadata:
  node_type: memory
  pinned: false
  originSessionId: adb20ede-2420-4012-83f0-7c4fa69e93bd
  modified: 2026-09-24T12:38:32.953Z
---

In showplace-pro, opening a quote is expected to refresh its pricing. That refresh happens when `GlobalGroup::buildGlobal()` sees a complete global and calls `saveGlobals()` (the Pro API `globalsSave` endpoint). The endpoint rebuilds the order header, re-derives the price catalog from the account's current catalog year, and re-looks up the price column and upcharges. `globalsSave` also always locks the order group (`ohorderlock = 'X'`), and the user then has to click Save & Continue (`globalsExit`), which reprices the lines and unlocks. The user confirmed this is intended behavior.

Editing only the job info fields (room, purchase order, job name) is also expected to lock the quote. The `globalsJobInfoSave` endpoint does not lock by itself; the lock comes from the `globalsSave` that runs when the global is rebuilt after that edit. That rebuild's save must be kept.

Never treat these `globalsSave` re-saves as redundant writes that can simply be deleted. Changes aimed at reducing API calls must keep the on-open refresh and the lock after job-info edits. Only saves that duplicate one made immediately before (for example, `saveGlobals()` followed by a rebuild that saves again) are safe to remove. Refreshing pricing without locking would need a Pro API change, and the `resources/pro-api` submodule is a separate project that must not be edited from this repo.

While the order is locked, QuoteForm hides the line items, totals and submit block until Save & Continue unlocks it. The user confirmed on 2026-10-01 (SPPRO-4643) that this is intended: it keeps users from seeing prices that haven't been refreshed yet. Fixes should stop flicker, not show lines while the order is locked.
