---
name: sudo-needs-own-terminal
description: sudo on test/app/proprod needs a password; `!` commands have no TTY, so have the user run sudo steps in their own terminal
metadata:
  type: feedback
---

sudo on the servers (test, app, proprod, prodev) needs a password, so Claude can't run it. Commands run with the `!` prefix have no TTY, so `! ssh -t host 'sudo ...'` fails with "a terminal is required to read the password". Hand the user the plain command to run in a separate terminal, not a `!` command.

**Why:** A suggested `! ssh -t test 'sudo rm ...'` failed on 2026-10-28.
**How to apply:** For root-owned changes (e.g. /etc/nginx on test), give a ready-to-paste command for the user's own terminal, then verify afterwards over ssh.
