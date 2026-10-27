---
name: commands-for-user-in-final-message
description: "Commands the user must run themselves go in the final reply of the turn; text between tool calls didn't reach them"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d9233310-e88e-476c-9db0-148c9b4c6843
  modified: 2026-10-21T21:34:44.443Z
---

When the user has to run a command themselves (e.g. a sudo command on prodev), put it in the final message of the turn and end the turn, rather than writing it between tool calls and carrying on.

**Why:** On 2026-10-21 (SPPRO-4902) I wrote the prodev vhost sudo command mid-turn, twice, and the user said twice they couldn't see it.

**How to apply:** If the user is blocked on running something, stop and give the command as the last thing in the reply. Do any other work after they've run it, or in the same final message. See [[prodev-tinker-breaks-cache-perms]] for why sudo on prodev has to run from their own terminal.
