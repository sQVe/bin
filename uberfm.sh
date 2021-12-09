#!/usr/bin/env bash

# ╻ ╻┏┓ ┏━╸┏━┓┏━╸┏┳┓
# ┃ ┃┣┻┓┣╸ ┣┳┛┣╸ ┃┃┃
# ┗━┛┗━┛┗━╸╹┗╸╹  ╹ ╹

# test -z "$(which ueberzug)" \
#   && exec vifm --choose-dir - "$@" && exit

# test -z "$DISPLAY" \
#   && exec vifm --choose-dir - "$@" && exit

if [ -z "$(command -v vifm)" ]; then
  printf "vifm isn't installed on your system!\n"
  exit 1
elif [ -z "$(command -v ueberzug)" ]; then
  exec vifm --choose-dir - "$@"
else
  cleanup() {
    exec 3>&-
    rm "$FIFO_UEBERZUG"
  }
  [ ! -d "$HOME/.cache/vifm" ] && mkdir -p "$HOME/.cache/vifm"
  export FIFO_UEBERZUG="$HOME/.cache/vifm/ueberzug-${$}"
  mkfifo "$FIFO_UEBERZUG"
  ueberzug layer -s -p json < "$FIFO_UEBERZUG" &
  exec 3> "$FIFO_UEBERZUG"
  trap cleanup EXIT
  vifm --choose-dir - "$@" 3>&-
  "$SCRIPTS"/vifm/vifmimg.sh clear
fi
