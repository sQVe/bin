#!/usr/bin/env bash

#  ╺┳╸┏━╸┏━┓┏┳┓
#   ┃ ┣╸ ┣┳┛┃┃┃
#   ╹ ┗━╸╹┗╸╹ ╹

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
  -i | --instance)
    shift
    instance=(--class "$1")
    ;;
  -t | --title)
    shift
    title=(--title "$1")
    ;;
  esac
  shift
done
if [[ "$1" == '--' ]]; then shift; fi

if [[ $# == "0" ]]; then
  alacritty "${instance[@]}" "${title[@]}" &>/dev/null &
else
  # Ensure absolute path if given path.
  path=$(readlink -e "$@")

  if [[ -n "$path" ]]; then
    # Get directory name if given file path.
    if [[ -f $path ]]; then
      path=$(dirname "$path")
    fi

    # Open directory in new terminal.
    alacritty --working-directory "$path" &>/dev/null &
  else
    # Execute command in new terminal.
    alacritty "${instance[@]}" "${title[@]}" -e zsh -ic "$*;zsh" &>/dev/null &
  fi
fi

disown
