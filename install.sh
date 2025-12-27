#!/usr/bin/env bash

#  ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻
#  ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃
#  ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸

set -euo pipefail

readonly user_home="/home/${SUDO_USER:-$USER}"
readonly bin_dir="${user_home}/.bin"
readonly local_bin="/usr/local/bin"

if [[ ! -w "$local_bin" ]]; then
  echo "Error: Cannot write to $local_bin. Run with sudo." >&2
  exit 1
fi

declare -A bins=(
  [ghc]="ghc.sh"
  [mount-shishigami]="mount-shishigami.sh"
  [nvim-dir]="nvim-dir.sh"
  [open]="open.sh"
  [repos-behind]="repos-behind.sh"
  [repos-dirty]="repos-dirty.sh"
  [root]="root.sh"
  [state]="state.sh"
  [term]="term.sh"
  [xrandr]="xrandr.sh"
)

for cmd in "${!bins[@]}"; do
  src="${bin_dir}/${bins[$cmd]}"
  if [[ ! -f "$src" ]]; then
    echo "Warning: $src not found, skipping" >&2
    continue
  fi
  ln -sf "$src" "${local_bin}/${cmd}"
done
