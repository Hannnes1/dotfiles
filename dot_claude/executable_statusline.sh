#!/usr/bin/env bash
# Claude Code statusline
# Reads the JSON payload Claude Code pipes on stdin and renders a compact,
# single-line status made of: cwd | git branch(+dirty) | model | context% | rate limits

set -euo pipefail

input=$(cat)

# --- colors (bright/normal intensity for readability on dark backgrounds) ---
c_reset=$'\033[0m'
c_sep=$'\033[38;5;245m'  # mid-gray, subtle but still legible separator
c_dir=$'\033[96m'        # bright cyan
c_git=$'\033[93m'        # bright yellow
c_git_dirty=$'\033[91m'  # bright red (dirty indicator)
c_model=$'\033[95m'      # bright magenta
c_ctx=$'\033[92m'        # bright green
c_rate=$'\033[94m'       # bright blue
sep="${c_sep} · ${c_reset}"

segments=()

# --- 1. current directory (shortened, ~-relative) ---
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
if [ -n "$cwd" ]; then
  dir_display="${cwd/#$HOME/~}"
  segments+=("${c_dir}${dir_display}${c_reset}")
fi

# --- 2. git branch + dirty status ---
if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short -q HEAD \
    || git -C "$cwd" --no-optional-locks rev-parse --short -q HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
      segments+=("${c_git_dirty}${branch}*${c_reset}")
    else
      segments+=("${c_git}${branch}${c_reset}")
    fi
  fi
fi

# --- 3. model display name ---
model=$(echo "$input" | jq -r '.model.display_name // empty')
[ -n "$model" ] && segments+=("${c_model}${model}${c_reset}")

# --- 4. context window used ---
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  segments+=("${c_ctx}$(printf '%.0f' "$used")% used${c_reset}")
fi

# --- 5. rate limit usage (5h / 7d) ---
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
rate=""
[ -n "$five" ] && rate="5h:$(printf '%.0f' "$five")%"
if [ -n "$week" ]; then
  [ -n "$rate" ] && rate="$rate "
  rate="${rate}7d:$(printf '%.0f' "$week")%"
fi
[ -n "$rate" ] && segments+=("${c_rate}${rate}${c_reset}")

# --- join segments with a subtle separator ---
out=""
for i in "${!segments[@]}"; do
  if [ "$i" -eq 0 ]; then
    out="${segments[$i]}"
  else
    out="${out}${sep}${segments[$i]}"
  fi
done

printf '%s\n' "$out"
