#!/usr/bin/env bash

#  ╺┳┓┏━┓╺┳╸┏━┓
#   ┃┃┃ ┃ ┃ ┗━┓
#  ╺┻┛┗━┛ ╹ ┗━┛

files="$(fd --base-directory "$DOTFILES")"
choice="$(fzf --select-1 --query "$*" <<< "$files" || exit)"

[[ -z "$choice" ]] && exit 1

nvim "$DOTFILES/$choice" +"cd $DOTFILES"
