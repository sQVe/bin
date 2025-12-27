#!/usr/bin/env bash

#  ┏┓╻╻ ╻╻┏┳┓   ╺┳┓╻┏━┓
#  ┃┗┫┃┏┛┃┃┃┃    ┃┃┃┣┳┛
#  ╹ ╹┗┛ ╹╹ ╹   ╺┻┛╹╹┗╸

set -euo pipefail

if [[ -d "${1:-}" ]]; then
  (builtin cd "$1" && nvim)
else
  nvim "$@"
fi
