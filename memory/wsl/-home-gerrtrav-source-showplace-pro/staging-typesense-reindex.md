---
name: staging-typesense-reindex
description: "Staging catalog search \"not responding\" with a missing `embedding` field = stale Typesense collections; rebuild parts/mods via scout:delete-index + scout:import as www-data (~18 min)"
metadata:
  node_type: memory
  type: project
  originSessionId: 5078472a-a4df-4dd2-88a2-344e357d2166
  modified: 2026-11-09T21:10:34.811Z
---

SPPRO-5281 (2026-11-09): after the staging Typesense VM (192.168.125.26:8108, v28.0) lost and regained its network, Build Order search failed with "Malformed vector query string: could not find a field named `embedding`". Staging's `parts`/`mods` collections dated from May 2026 and had no `embedding` field; production's do (prod Typesense 100.90.88.58, also 28.0). The actual error is in the staging laravel.log as "Catalog search failed". A 2000 ms connection timeout in that log means the VM is down (Shad's job), not stale collections.

**Fix that worked:** on prodev, run `sg www-data -c "umask 002; ..."` with env `TYPESENSE_CONNECTION_TIMEOUT_SECONDS=600 TYPESENSE_NUM_RETRIES=1 CACHE_STORE=array`, then for `App\Models\Mod` and then `App\Models\Part`: `php8.5 artisan scout:delete-index <Model>` followed by `scout:import <Model> --chunk=100`, under nohup with a log in ~. Staging has no config cache, so the env overrides take effect. Mods took ~2 min and parts ~16 min (~16 docs/s while Typesense computes the embeddings). Staging search is down during the rebuild, so ask the user before starting.

**How to apply:** check the Typesense collections' fields (`curl /collections` with the .env key) before blaming the network. See [[prodev-tinker-breaks-cache-perms]] for running artisan on prodev.
