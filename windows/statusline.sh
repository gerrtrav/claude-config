#!/bin/sh
# Claude Code status line: user@host:cwd  <raw context tokens>
payload=$(cat)

user=$(whoami)
user=${user##*\\}   # strip DOMAIN\ prefix
user=${user##*+}    # strip DOMAIN+ prefix (Git Bash whoami)
user=${user##*/}

host=$(hostname -s 2>/dev/null || hostname)

tokens=$(printf '%s' "$payload" \
  | grep -o '"total_input_tokens":[0-9]*' \
  | head -1 \
  | grep -o '[0-9]*$')

printf "\033[01;32m%s@%s\033[00m:\033[01;34m%s\033[00m \033[02m%s tok\033[00m" \
  "$user" "$host" "$(pwd)" "${tokens:-0}"
