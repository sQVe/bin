#!/usr/bin/env bash

#  ╻ ╻┏━┓┏━┓┏┓╻╺┳┓┏━┓
#  ┏╋┛┣┳┛┣━┫┃┗┫ ┃┃┣┳┛
#  ╹ ╹╹┗╸╹ ╹╹ ╹╺┻┛╹┗╸

# Wrapper for xrandr that exits silently on Wayland.
# Prevents tccd (Tuxedo Control Center) from spamming errors
# when it polls xrandr without valid X11 display variables.

set -euo pipefail

[[ -z "${DISPLAY:-}" || -z "${XAUTHORITY:-}" ]] && exit 0

exec /usr/bin/xrandr "$@"
