#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

instance="Alacritty"
title="Alacritty"

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -i | --instance )
    shift;
    instance="$1"
    ;;
  -t | --title )
    shift;
    title="$1"
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

# Ensure absolute path if given path.
path="$(readlink -e "$1")"

if [[ -n "$path" ]]; then
  # Get directory name if given file path.
  if [[ -f $path ]]; then
    path="$(dirname "$path")"
  fi

  # Open directory in new terminal.
  alacritty --working-directory "$path" &> /dev/null & disown
else
  # Execute command in new terminal.
  alacritty --class "$instance" --title "$title" -e zsh -ic "$*;zsh" &> /dev/null & disown
fi
