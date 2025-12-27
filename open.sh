#!/usr/bin/env bash

# ┏━┓┏━┓┏━╸┏┓╻
# ┃ ┃┣━┛┣╸ ┃┗┫
# ┗━┛╹  ┗━╸╹ ╹
# Open a file quietly in the background.

set -euo pipefail

mimeo --quiet "$@" &
disown
