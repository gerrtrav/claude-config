---
name: qa-instructions-general-overview
description: QA instructions on Jira tickets should be a general overview of what to test, not exact step-by-step scripts
metadata:
  type: feedback
---

When writing QA instructions for a Jira ticket, keep them high-level: a general overview of what changed and which areas/scenarios to test, with the expected outcome, rather than exact click-by-click steps, specific data setup or long numbered check lists.

**Why:** The user said (2026-10-07, SPPRO-4848): "when you write qa instructions, they should be less exact. The instructions should be a general overview of what to test." Earlier QA comments were too prescriptive.

**How to apply:** Short summary of the change, then a brief list of what to test (scenarios, including what should still work as before) and what to expect. Let the tester decide the exact steps and data. Applies to the QA comment in [[jira-finish-to-qa]].
