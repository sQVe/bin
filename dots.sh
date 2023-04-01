#!/usr/bin/env bash

#  ╺┳┓┏━┓╺┳╸┏━┓
#   ┃┃┃ ┃ ┃ ┗━┓
#  ╺┻┛┗━┛ ╹ ┗━┛

files="$(fd --absolute-path --base-directory "${DOTFILES}" --type 'file')"
choice="$(fzf --preview 'bat --color=always {} 2> /dev/null' --preview-window 'down:50%' --select-1 --query "$*" <<< "${files}" || exit)"

[[ -z "${choice}" ]] && exit 1

nvim "${choice}" +"cd ${DOTFILES}"
