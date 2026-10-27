---
name: settings-backup
description: "Where the user's dotfiles and Claude Code settings are backed up (3 GitHub repos) and how edits flow back"
metadata:
  node_type: memory
  type: project
  originSessionId: dcdcfa86-333a-4db8-98f2-2f7a3545d248
  modified: 2026-10-27T20:12:27.010Z
---

Settings are backed up in three private GitHub repos (set up 2026-10-27):

- `ultrinn/dotfiles`: WSL dotfiles managed by yadm (`yadm add/commit/push`); `~/.config/yadm/bootstrap` installs oh-my-zsh, starship, fzf, nvm, Claude Code.
- `gerrtrav/claude-config` at `~/source/claude-config` (remote `git@github-work:...`, uses `~/.ssh/id_ed25519_work`): CLAUDE.md, WSL/Windows Claude settings, memories, `ec-sync`, `~/.ssh/config`. WSL files are symlinks into it, so commit changes there; `./install.sh` copies to Windows, `./install.sh --pull-windows` copies back.
- `ultrinn/dotfiles-windows` at `C:\Users\gerrtrav\source\repos\dotfiles-windows`: Windows `.gitconfig` and Windows Terminal settings. The PC can't create symlinks (no admin or Developer Mode), so files are copies; run `install.ps1 -Pull` after Windows-side edits.

**Why:** the user wants a new machine set up from these repos. Company material (Showplace hosts, memories) goes in the work account, personal config in ultrinn.

**How to apply:** when the user changes settings, remind them to commit in the right repo. Auto mode blocks Claude from pushing these repos and from copying out of `~/.ssh`, so hand those commands to the user with `!`. Related: [[ec-sync]].
