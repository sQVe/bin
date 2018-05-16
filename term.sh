#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

title="urxvt"

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -t | --title )
    shift;
    title="$1"
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

# Ensure absolute path if given path.
path="$(command readlink -e "$1")"

if [[ -n "$path" ]]; then
  # Get directory name if given file path.
  if [[ -f $path ]]; then
    path="$(command dirname "$path")"
  fi

  # Open directory in new terminal.
  command urxvt -cd "$path" & disown
else
  # Execute command in new terminal.
  command urxvt -title "$title" -e zsh -ic "$*;zsh" & disown
fi
