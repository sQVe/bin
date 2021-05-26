#!/usr/bin/env bash

#  ┏┓╻┏━┓╺┳╸┏━╸
#  ┃┗┫┃ ┃ ┃ ┣╸
#  ╹ ╹┗━┛ ╹ ┗━╸

notes="$(fd --base-directory $NOTES --extension md --max-depth 1)"
choice="$(fzf --select-1 --query "$*" <<< "$notes" || exit)"

[[ -z "$choice" ]] && exit 1

nvim "$NOTES/$choice" +"Rooter"
