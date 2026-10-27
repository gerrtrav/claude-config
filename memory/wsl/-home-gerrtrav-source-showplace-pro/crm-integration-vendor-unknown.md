---
name: crm-integration-vendor-unknown
description: "Outside-CRM data import plan — \"KBS\" is KBS New England (a Showplace rep firm), CRM vendor unknown as of 2026-10-19; a BisTrack dealer is the newer candidate (2026-10-26); Andrew Gilbert is skeptical"
metadata:
  node_type: memory
  type: project
  originSessionId: 2ce7e0e3-708d-4e5b-9f62-2d13ebd27a13
  modified: 2026-10-19T18:28:00.900Z
---

The outside-CRM integration plan (`docs/crm-integration-plan.md`, `docs/crm-integration-sow.md`, branch `crm-integration-plan`, 2026-10-19) came from a request by Ben Loomes of **KBS New England, Inc., a manufacturers' rep firm** for Showplace. He forwarded it to Andrew Gilbert on 2026-09-23, and Andrew forwarded it to the user on 2026-10-16 (subject "CRM connection to Pro and Salesforce ?").
- "KBS CRM" means whatever CRM KBS New England uses. The software vendor is unknown. It is not kbs-services.com and not KABS.
- Ben currently downloads the open-order CSVs by hand and wants that automated, with Salesforce also mentioned.
- Ben also asked for a DMS CSV download and CSV upload for sales aid orders. Those are separate requests that go to the steering committee.
- Andrew doubts that connecting outside CRMs to Pro and Salesforce is a road Showplace wants to go down.

- 2026-10-26: a second requester appeared: an outside **dealer** (name not given) that runs **Epicor BisTrack** (lumber/building-material ERP) and wants the orders it submits to Showplace to appear in BisTrack. One-way, Showplace → dealer. Whether they have the BisTrack API license, and cloud vs. on-prem, are unknown. BisTrack's API is licensed separately with no public specs; BisTrack takes data in (API push, Automation Studio/Workato, eBusiness FTP import), so someone must push our data into it. Added to the plan docs on the branch. Dealer contact: Daniel Stock (dstock@hgpage.com, H.G. Page); met on Teams; questions email drafted in Outlook. Saberis (saberis.com) added to the plan as an optional route: Saberis XML download or partner push → SaberisConnect → BisTrack eBusiness (no BisTrack API license needed; dealer pays Saberis).

**Why:** The first requester is a rep, not a dealer. API connections would need to be scoped to a rep's accounts (`forRep`, `Account::accounts`), not only to a single dealer.

**How to apply:** Don't create Jira tickets (epic/tasks) for the CRM plan yet; the user said on 2026-10-22 to wait until the vendor is known. Keep the core vendor-neutral and defer vendor adapters. Before vendor-specific work, ask whether the vendor is now known and whether management has approved the project.
