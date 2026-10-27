#!/usr/bin/env bash
#
# Claude Code status line:
#   user@host:~/path (branch*↑1↓2) SPPRO-1234 [Model] ctx:NN% (used/size) 5h:NN% wk:NN% +120/-34
#
# - Branch is red with ⚠ on master/main (no code changes there without permission).
# - * = uncommitted changes, ↑/↓ = commits ahead of/behind upstream.
# - Jira key (SPPRO-, EC-, ITHD-, ...) is pulled from the branch name.

input=$(cat)
printf '%s' "$input" > "$HOME/.claude/statusline-last.json" 2>/dev/null

IFS=$'\t' read -r cwd model used tokens size five week added removed < <(
    jq -r '[
        (.workspace.current_dir // .cwd // ""),
        (.model.display_name // ""),
        (.context_window.used_percentage // ""),
        (.context_window.total_input_tokens // ""),
        (.context_window.context_window_size // ""),
        (.rate_limits.five_hour.used_percentage // ""),
        (.rate_limits.seven_day.used_percentage // ""),
        (.cost.total_lines_added // ""),
        (.cost.total_lines_removed // "")
    ] | map(tostring) | join("\t")' <<< "$input"
)

human() {
    awk -v n="$1" 'BEGIN {
        if (n >= 1000000) { v = n / 1000000; u = "M" } else if (n >= 1000) { v = n / 1000; u = "k" } else { print n; exit }
        v = sprintf("%.1f", v); sub(/\.0$/, "", v); print v u
    }'
}

printf '\033[01;32m%s@%s\033[00m:\033[01;34m%s\033[00m' "$(whoami)" "$(hostname -s)" "${cwd/#$HOME/\~}"

# One git call gives branch, upstream ahead/behind and dirty state.
if [[ -n $cwd ]] && git_status=$(git -C "$cwd" --no-optional-locks status --porcelain=v2 --branch 2>/dev/null); then
    branch= oid= ahead=0 behind=0 dirty=
    while IFS= read -r line; do
        case $line in
            '# branch.head '*) branch=${line#'# branch.head '} ;;
            '# branch.oid '*) oid=${line#'# branch.oid '} ;;
            '# branch.ab '*) read -r _ _ a b <<< "$line"; ahead=${a#+}; behind=${b#-} ;;
            '#'*) ;;
            *) dirty='*' ;;
        esac
    done <<< "$git_status"
    [[ $branch == '(detached)' ]] && branch=${oid:0:7}

    marks=$dirty
    ((ahead > 0)) && marks+="↑$ahead"
    ((behind > 0)) && marks+="↓$behind"

    if [[ $branch == master || $branch == main ]]; then
        printf ' \033[01;31m(⚠ %s%s)\033[0m' "$branch" "$marks"
    else
        printf ' \033[32m(%s\033[33m%s\033[32m)\033[0m' "$branch" "$marks"
    fi

    jira=$(grep -oE '[A-Z][A-Z0-9]+-[0-9]+' <<< "$branch" | head -n 1)
    [[ -n $jira ]] && printf ' \033[01;36m%s\033[0m' "$jira"
fi

[[ -n $model ]] && printf ' [%s]' "$model"
[[ -n $used ]] && printf ' ctx:%.0f%%' "$used"
[[ -n $tokens && -n $size ]] && printf ' (%s/%s)' "$(human "$tokens")" "$(human "$size")"
[[ -n $five ]] && printf ' 5h:%.0f%%' "$five"
[[ -n $week ]] && printf ' wk:%.0f%%' "$week"
[[ -n $added || -n $removed ]] && printf ' \033[32m+%s\033[0m/\033[31m-%s\033[0m' "${added:-0}" "${removed:-0}"
printf '\n'
