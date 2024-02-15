#!/usr/bin/env bash

#  ┏┓╻╻ ╻╻┏┳┓   ╺┳┓╻┏━┓
#  ┃┗┫┃┏┛┃┃┃┃    ┃┃┃┣┳┛
#  ╹ ╹┗┛ ╹╹ ╹   ╺┻┛╹╹┗╸

if [[ -d "$1" ]]; then
  (builtin cd "$1" && nvim)
else
  nvim "$@"
fi
