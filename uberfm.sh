#!/usr/bin/env bash

# ╻ ╻┏┓ ┏━╸┏━┓┏━╸┏┳┓
# ┃ ┃┣┻┓┣╸ ┣┳┛┣╸ ┃┃┃
# ┗━┛┗━┛┗━╸╹┗╸╹  ╹ ╹

if [ -z "$(whereis ueberzug | awk '{print $2}')" ]; then
  exec vifm --choose-dir - "$@" && exit
elif [ -z "$DISPLAY" ]; then
  exec vifm --choose-dir - "$@" && exit
else
  cleanup() {
    rm "$FIFO_UEBERZUG"
    pkill -P $$ > /dev/null
  }
  [ ! -d "$HOME/.cache/vifm" ] && mkdir --parents "$HOME/.cache/vifm"
  export FIFO_UEBERZUG="$HOME/.cache/vifm/ueberzug-${PPID}"
  mkfifo "$FIFO_UEBERZUG"
  tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash 2>&1 > /dev/null &
  trap cleanup EXIT
  vifm --choose-dir - "$@"
fi
