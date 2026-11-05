---
name: dealer-portal-sso
description: "Dealer Portal SSO epic SPPRO-5106: vendor Electric Pulp, miniOrange Premium, single log-out, showplacedealerportal.com for now; the portal is IP-restricted until cut-over"
metadata:
  node_type: memory
  type: project
  originSessionId: 0826bb1b-0430-4ef2-b53a-b8908f716d68
  modified: 2026-11-02T21:00:01.709Z
---

- showplacedealerportal.com is a WordPress site on managed hosting run by an outside vendor. It has no public pages and is IP-restricted, which is why `DealerPortalController` proxies it from the ShowplacePro server. A curl from the dev machine returning 200 does NOT mean it is public.
- The `SSO` role (id 20) is meant for users who may reach the Dealer Portal but do nothing else in ShowplacePro. As of 2026-10-21 it has no permissions or enforcement.
- 2026-10-21 plan: ShowplacePro becomes the OIDC provider (Passport). Users start from Resources → Marketing & Training or from the portal. Everyone gets access. Claims are login plus role. The vendor will allow the OIDC plugin. Still open with the vendor: plugin choice, WP role mapping, staging copy.
- Vendor = Electric Pulp (Mitch Kramer, dev director; Wendy Johnson, client services; Michael Lehmkuhl). Outlook thread "Dealer Portal Access Flow - SSO Feasibility" (2025). They recommended the miniOrange WordPress SSO plugin. Epic SPPRO-5106 (tasks 5108-5112) created 2026-10-22. The vendor-questions reply-all draft was created 2026-10-22.
- Once SSO is in place, the portal's IP restriction will be removed (user, 2026-10-22). After that, `DealerPortalController` can be retired and links can point straight at the portal.

**Why:** These facts come from the user, not the code.
**How to apply:** Use them when working on the dealer-portal SSO epic or touching the dealer-portal route or the SSO role.

**Electric Pulp answers (Mitch, 2026-10-29, same thread):**
- miniOrange plugin confirmed. Showplace buys the license and gives EP the keys and updates. Either team can configure it. The edition for OIDC was not stated; Premium is required for single log-out (SLO), and SLO also needs support on our IdP side.
- The portal's URL and callback URLs are not final. The portal moves to EP's main multisite server (IP 64.225.6.183) in November 2026, which is also where its outgoing token calls will come from. Course link path: /course/<slug>/.
- The portal has only 3-4 admin users (showplacecabinetry.com emails) and does not use roles today. Users are matched by email; new users are created as WP "Subscriber". Admins get a separate URL that bypasses SSO. EP needs no claims beyond email.
- EP will build a staging copy of the portal. Removing the IP restriction is quick, but they want as much lead time as possible to plan the cutover.
- Contacts: Mitch or Michael Lehmkuhl. Always keep Wendy Johnson cc'd.

**User decisions (2026-10-30), recorded on SPPRO-5106/5108/5109/5111/5112:** buy miniOrange **Premium**. **Single log-out: yes**, so signing out of either site signs out of both. **Keep showplacedealerportal.com for now**; the user is checking with the Marketing Director whether the address should change.

**miniOrange support (Devendra Dantal, xecurify.com, 2026-11-02, thread "Query for Product Questions"):** OIDC logout is in the **Enterprise** edition only, NOT Premium. That contradicts EP's answer, so on 2026-11-02 the user chose **ENTERPRISE** (keeping SLO). The plugin supports both logout directions. IdP-initiated logout is **back-channel only**. miniOrange is checking Laravel Passport compatibility and asked for our implementation docs. On 11-02 we drafted replies (not yet sent): to miniOrange describing the planned Passport+OIDC design, and to EP about the Enterprise switch, asking for their back-channel logout URL. This is recorded on 5106 (comment + description), 5108, 5109 and 5111.

**miniOrange answers (Divya Tambe, 2026-11-04, same thread):** design compatible. Claims: email enough; ID token needs `sub` + `sid`. Client auth basic or post. Back-channel URL `https://<wp-domain>/backchannel_logout`, matches by sub or sid. NO discovery for custom providers: endpoints/JWKS/issuer entered by hand. Support plans are a separate yearly add-on ($149–$999). On 11-04 we recorded this on 5106/5108/5109/5111 and drafted a reply-all (not sent) asking: are updates included with the license and for how long, are support plans separate or needed for updates, is setup help free, does the plugin fetch JWKS at runtime.
