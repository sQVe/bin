#!/usr/bin/env bash

#  ┏┓╻┏━┓╺┳╸┏━╸
#  ┃┗┫┃ ┃ ┃ ┣╸
#  ╹ ╹┗━┛ ╹ ┗━╸

files="$(fd --base-directory "$NOTEBOX" --extension md --max-depth 3)"
choice="$(fzf --select-1 --query "$*" <<< "$files" || exit)"

[[ -z "$choice" ]] && exit 1

nvim "$NOTEBOX/$choice" +"cd $NOTEBOX"
