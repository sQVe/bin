#!/usr/bin/env bash

#  ┏┓╻┏━┓╺┳╸┏━╸
#  ┃┗┫┃ ┃ ┃ ┣╸
#  ╹ ╹┗━┛ ╹ ┗━╸

if [[ -z "$1" ]]; then
  echo "Note name/fragment missing. Exiting."
  exit
fi

notes="$(command fd --extension md . "$HOME/notes" | sed -r -e 's/\.md//' -e 's/^.+notes\///')"
choice="$(echo "$notes" | rg "$(sed -r 's/\.md$//' <<<"$1")" | head -n 1)"

if [[ -z "$choice" ]]; then
  echo "No note found matching \"$1\". Exiting."
  exit
fi

nvim-pwd "$HOME/notes/$choice.md"
