#!/usr/bin/env bash
# Claude Code status line: model name + git branch + context bar + logged-in account
# No external dependencies (no jq required)

input=$(cat)

# Extract model name
model=$(echo "$input" | grep -o '"display_name" *: *"[^"]*"' | head -1 | sed 's/.*: *"//;s/"//')
[ -z "$model" ] && model="Claude"

# Git branch
branch=$(git branch --show-current 2>/dev/null)

# Logged-in account: org name from ~/.claude.json (rewritten on /login), else email.
# One file per machine, so this is the last login, not necessarily this session's.
account=""
claude_json="${CLAUDE_CONFIG_DIR:-$HOME}/.claude.json"
if [ -f "$claude_json" ]; then
  account=$(grep -o '"organizationName" *: *"[^"]*"' "$claude_json" | head -1 | sed 's/.*: *"//;s/"//')
  [ -z "$account" ] && account=$(grep -o '"emailAddress" *: *"[^"]*"' "$claude_json" | head -1 | sed 's/.*: *"//;s/"//')
fi
account_part=""
[ -n "$account" ] && account_part=" (${account})"

# Extract used_percentage and total_input_tokens (both under context_window)
used=$(echo "$input" | grep -o '"used_percentage" *: *[0-9.]*' | head -1 | sed 's/.*: *//')
tokens=$(echo "$input" | grep -o '"total_input_tokens" *: *[0-9]*' | head -1 | sed 's/.*: *//')

if [ -z "$used" ]; then
  printf "%s%b" "$model" "$account_part"
  exit 0
fi

used_int=$(printf "%.0f" "$used")

# Color thresholds
if [ "$used_int" -ge 90 ]; then
  color="\033[31m"   # red
elif [ "$used_int" -ge 70 ]; then
  color="\033[33m"   # yellow
else
  color="\033[32m"   # green
fi
reset="\033[0m"

# Build 10-block progress bar
filled=$(( used_int / 10 ))
empty=$(( 10 - filled ))
bar=""
for i in $(seq 1 $filled); do bar="${bar}█"; done
for i in $(seq 1 $empty);  do bar="${bar}░"; done

# Format token count as 49k / 1.2M
tokens_part=""
if [ -n "$tokens" ]; then
  if [ "$tokens" -ge 1000000 ]; then
    tokens_fmt=$(awk "BEGIN{printf \"%.1fM\", $tokens/1000000}")
  elif [ "$tokens" -ge 1000 ]; then
    tokens_fmt=$(awk "BEGIN{printf \"%dk\", $tokens/1000}")
  else
    tokens_fmt="$tokens"
  fi
  tokens_part=" ${tokens_fmt}"
fi

# Assemble
branch_part=""
[ -n "$branch" ] && branch_part=" \033[35m${branch}${reset} "

printf "%s%b%b ${color}context [%s] %d%%%s${reset}" "$model" "$account_part" "$branch_part" "$bar" "$used_int" "$tokens_part"
