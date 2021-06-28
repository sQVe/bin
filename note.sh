#!/usr/bin/env bash

#  ┏┓╻┏━┓╺┳╸┏━╸
#  ┃┗┫┃ ┃ ┃ ┣╸
#  ╹ ╹┗━┛ ╹ ┗━╸

files="$(fd --base-directory "$NOTES" --extension md --max-depth 1)"
choice="$(fzf --select-1 --query "$*" <<< "$files" || exit)"

[[ -z "$choice" ]] && exit 1

nvim "$NOTES/$choice" +"cd $NOTES"
