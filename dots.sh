#!/usr/bin/env bash

#  ╺┳┓┏━┓╺┳╸┏━┓
#   ┃┃┃ ┃ ┃ ┗━┓
#  ╺┻┛┗━┛ ╹ ┗━┛

files="$(fd --type f --base-directory "$DOTFILES")"
choice="$(fzf --select-1 --query "$*" <<< "$files" || exit)"

[[ -z "$choice" ]] && exit 1

nvim "$DOTFILES/$choice" +"Rooter"
