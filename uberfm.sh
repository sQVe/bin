#!/usr/bin/env bash

# ╻ ╻┏┓ ┏━╸┏━┓┏━╸┏┳┓
# ┃ ┃┣┻┓┣╸ ┣┳┛┣╸ ┃┃┃
# ┗━┛┗━┛┗━╸╹┗╸╹  ╹ ╹

test -z "$(which ueberzug)" \
  && exec vifm --choose-dir - "$@" && exit

test -z "$DISPLAY" \
  && exec vifm --choose-dir - "$@" && exit

cleanup() {
  rm "$FIFO_UEBERZUG"
  pkill -P $$ > /dev/null
}

! test -d "$HOME/.cache/vifm" && mkdir -p "$HOME/.cache/vifm"
export FIFO_UEBERZUG="$HOME/.cache/vifm/ueberzug-${PPID}"
mkfifo "$FIFO_UEBERZUG"
tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash > /dev/null 2>&1 &
trap cleanup EXIT
vifm --choose-dir - "$@"
