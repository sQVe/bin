#!/usr/bin/env bash

# Ensure absolute path.
path=$(readlink -e "$1")

if [[ -n "$path" ]]; then
  # Get directory name if given file path.
  if [[ -f $path ]]; then
    path=$(dirname "$path")
  fi

  # Open directory in new terminal.
  urxvt -cd "$path" & disown
else
  # Execute command in new terminal.
  urxvt -e zsh -ic "$*;zsh" & disown
fi
