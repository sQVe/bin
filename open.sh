#!/usr/bin/env bash

# ┏━┓┏━┓┏━╸┏┓╻
# ┃ ┃┣━┛┣╸ ┃┗┫
# ┗━┛╹  ┗━╸╹ ╹
# Open a file quietly in the background.

set -euo pipefail

[[ $# -eq 0 ]] && {
  echo "Usage: open <file|url>..." >&2
  exit 1
}

args=()
for arg in "$@"; do
  if [[ -e "${arg}" ]]; then
    args+=("$(realpath "${arg}" 2> /dev/null || printf '%s' "${arg}")")
  else
    args+=("${arg}")
  fi
done

mimeo --quiet "${args[@]}" &
disown
