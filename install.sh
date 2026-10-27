#!/bin/bash
# Restore Claude Code settings from this repo.
#
#   ./install.sh                WSL: symlink ~/.claude files to this repo; Windows: copy files into %USERPROFILE%\.claude
#   ./install.sh --pull-windows Copy the Windows-side files back into this repo (after editing them on Windows)
#
# WSL files are symlinked, so edits Claude makes (CLAUDE.md, memories, settings) land in the repo
# and only need a commit. Windows can't follow symlinks into WSL, so it gets copies.
set -euo pipefail

repo=$(cd "$(dirname "$0")" && pwd)
claude="$HOME/.claude"
win_user=$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r' || true)
win="/mnt/c/Users/${win_user:-$USER}/.claude"

# link <repo path> <target>: replace target with a symlink, backing up any real file/dir first
link() {
    local src="$repo/$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.bak-$(date +%Y%m%d%H%M%S)"
        echo "backed up $dst"
    fi
    ln -sfn "$src" "$dst"
    echo "linked $dst"
}

if [ "${1:-}" = "--pull-windows" ]; then
    cp "$win/CLAUDE.md" "$repo/CLAUDE.md"
    cp "$win/settings.json" "$win/statusline.sh" "$repo/windows/"
    cp "$win/hooks/notify-windows.ps1" "$repo/windows/hooks/"
    for d in "$win"/projects/*/memory; do
        [ -d "$d" ] && rsync -a "$d/" "$repo/memory/windows/$(basename "$(dirname "$d")")/"
    done
    echo "Pulled Windows files into $repo; review with git diff and commit."
    exit 0
fi

# WSL
link CLAUDE.md "$claude/CLAUDE.md"
link wsl/settings.json "$claude/settings.json"
link wsl/statusline.sh "$claude/statusline.sh"
link wsl/hooks "$claude/hooks"
for d in "$repo"/memory/wsl/*/; do
    p=$(basename "$d")
    link "memory/wsl/$p" "$claude/projects/$p/memory"
done

# Work shell scripts and SSH host aliases (keys themselves are not in this repo)
link extras/bin/ec-sync "$HOME/bin/ec-sync"
if [ -f "$repo/extras/ssh/config" ]; then
    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    link extras/ssh/config "$HOME/.ssh/config"
fi

# Windows (only when running under WSL with the Windows drive mounted)
if [ -d "/mnt/c/Users/${win_user:-$USER}" ]; then
    mkdir -p "$win/hooks"
    cp "$repo/CLAUDE.md" "$win/CLAUDE.md"
    cp "$repo/windows/settings.json" "$repo/windows/statusline.sh" "$win/"
    cp "$repo/windows/hooks/notify-windows.ps1" "$win/hooks/"
    for d in "$repo"/memory/windows/*/; do
        p=$(basename "$d")
        mkdir -p "$win/projects/$p/memory"
        cp -r "$d." "$win/projects/$p/memory/"
    done
    echo "copied Windows files to $win"
fi

echo "Done. Log in to Claude Code (claude /login) on the new machine; credentials are not backed up."
