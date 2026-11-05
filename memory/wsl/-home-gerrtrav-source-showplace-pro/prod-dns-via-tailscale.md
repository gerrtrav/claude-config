---
name: prod-dns-via-tailscale
description: "Hosts fix live 2026-11-03. proprod resolves ALL DNS through Tailscale (on-prem DCs via DERP-relayed swp-tailscale); ~20s stalls cause \"Resolving timed out\" errors; SPPRO-5212"
metadata:
  node_type: memory
  type: project
  originSessionId: 2a4ad773-ff2a-4790-a970-c89e98952e9d
  modified: 2026-10-28T18:23:53.581Z
---

Found 2026-10-28 (Nightwatch #501/#500): proprod's resolver is systemd-resolved with Tailscale DNS on `~.`; `showplacewood.com` splits to on-prem DCs 192.168.127.61/.65 through subnet router `swp-tailscale`, which proprod reaches only via DERP relay (ord). Short stalls on that path break DNS and all on-prem TCP (Frontier .17, buckets .85). 52 "Resolving timed out" errors 10-22..10-28, 48 for `proapi.showplacepro.biz` (= prod's own IP 45.79.43.29); likely behind Nightwatch #474/#475/#482.

SPPRO-5212: Shad added /etc/hosts entries on proprod 2026-11-03 07:06 CST (45.79.43.29 showplacepro.biz proapi.showplacepro.biz; 192.168.127.10 webdocs), ticket Done; verified same day (dns ~0.0005s, no new Resolving timed out). If proprod's public IP or webdocs IP changes, update /etc/hosts. The root cause (no direct Tailscale connection, e.g. UDP 41641 blocked on-prem) is not ticketed yet.

**How to apply:** for prod "Resolving timed out"/connection-timeout errors to internal hosts, check `journalctl -u tailscaled` for `open-conn-track: timeout` first (journal times are CDT). See [[server-sudo-changes-shad]].
