#!/usr/bin/env bash

# ╻┏┳┓╻ ╻   ╻ ╻┏━┓╻
# ┃┃┃┃┃┏┛━━━┃ ┃┣┳┛┃
# ╹╹ ╹┗┛    ┗━┛╹┗╸┗━╸
# Wrapper for imv that supports URLs.

set -euo pipefail

if [[ ${1:-} =~ ^https?:// ]]; then
  curl -sL "$1" | imv -
else
  imv "$@"
fi
