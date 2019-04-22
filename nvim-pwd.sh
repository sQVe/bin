#!/usr/bin/env bash

#  ┏┓╻╻ ╻╻┏┳┓   ┏━┓╻ ╻╺┳┓
#  ┃┗┫┃┏┛┃┃┃┃   ┣━┛┃╻┃ ┃┃
#  ╹ ╹┗┛ ╹╹ ╹   ╹  ┗┻┛╺┻┛

if [[ -d "$1" ]]; then
  (cd "$1" && nvim +Ranger)
elif [[ -f "$1" ]]; then
  dirname="$(dirname "$1")/"
  (cd "$dirname" && nvim "${1/$dirname/}")
else
  if [[ -z "$1" ]]; then
    nvim
  else
    nvim "$1"
  fi
fi
