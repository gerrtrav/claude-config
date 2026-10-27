---
name: dealer-portal-sso
description: "Dealer Portal (showplacedealerportal.com, vendor-hosted WordPress) is IP-restricted; SSO role = portal-only users; SSO plan drafted 2026-10-21"
metadata:
  node_type: memory
  type: project
  originSessionId: 0826bb1b-0430-4ef2-b53a-b8908f716d68
  modified: 2026-10-21T14:19:06.046Z
---

- showplacedealerportal.com is a WordPress site on managed hosting run by an outside vendor. It has no public pages and is IP-restricted, which is why `DealerPortalController` proxies it from the ShowplacePro server. A curl from the dev machine returning 200 does NOT mean it is public.
- The `SSO` role (id 20) is meant for users who may reach the Dealer Portal but do nothing else in ShowplacePro. As of 2026-10-21 it has no permissions or enforcement.
- 2026-10-21 plan: ShowplacePro becomes the OIDC provider (Passport). Users start from Resources → Marketing & Training or from the portal. Everyone gets access. Claims are login plus role. The vendor will allow the OIDC plugin. Still open with the vendor: plugin choice, WP role mapping, staging copy.
- Vendor = Electric Pulp (Mitch Kramer, dev director; Wendy Johnson, client services; Michael Lehmkuhl). Outlook thread "Dealer Portal Access Flow - SSO Feasibility" (2025). They recommended the miniOrange WordPress SSO plugin. Epic SPPRO-5106 (tasks 5108-5112) created 2026-10-22. The vendor-questions reply-all draft was created 2026-10-22.
- Once SSO is in place, the portal's IP restriction will be removed (user, 2026-10-22). After that, `DealerPortalController` can be retired and links can point straight at the portal.

**Why:** These facts come from the user, not the code.
**How to apply:** Use them when working on the dealer-portal SSO epic or touching the dealer-portal route or the SSO role.
