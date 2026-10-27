# claude-config

Backup of my Claude Code settings for WSL (Ubuntu) and Windows.

| Path | What | Restored to |
|---|---|---|
| `CLAUDE.md` | Global instructions (shared) | `~/.claude/CLAUDE.md` (symlink) and `C:\Users\<me>\.claude\CLAUDE.md` (copy) |
| `wsl/` | WSL `settings.json`, `statusline.sh`, `hooks/` | `~/.claude/` (symlinks) |
| `windows/` | Windows `settings.json`, `statusline.sh`, `hooks/` | `C:\Users\<me>\.claude\` (copies) |
| `memory/wsl/<project>/` | Per-project auto-memory | `~/.claude/projects/<project>/memory` (symlinks) |
| `memory/windows/<project>/` | Per-project auto-memory | `C:\Users\<me>\.claude\projects\<project>\memory` (copies) |

Not backed up: `.credentials.json` (log in again), history, sessions, caches.

## Restore on a new machine

First set up the work GitHub SSH key: generate `~/.ssh/id_ed25519_work`, add its `.pub` to the gerrtrav
GitHub account, and add this to `~/.ssh/config`, then check with `ssh -T git@github-work`:

```
Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
  IdentitiesOnly yes
```

```sh
git clone git@github-work:gerrtrav/claude-config.git ~/source/claude-config
~/source/claude-config/install.sh
claude /login
```

Memory folders are keyed by project path, so they reattach only if the repos are cloned to the same paths
(`~/source/<project>`).

## Day to day

WSL files are symlinks into this repo, so changes Claude makes show up in `git status` here; commit and push them.

Windows files are copies. After changing them on Windows, run `./install.sh --pull-windows`, review, and commit.
After changing `CLAUDE.md` in WSL, run `./install.sh` to push it to the Windows copy.
