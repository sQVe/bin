#!/usr/bin/env bash

#  ┏━╸╻┏┓╻╺┳┓   ┏┓╻╻   ┏━┓┏━╸┏━┓╻  ┏━┓┏━╸┏━╸
#  ┣╸ ┃┃┗┫ ┃┃   ┃┗┫    ┣┳┛┣╸ ┣━┛┃  ┣━┫┃  ┣╸
#  ╹  ╹╹ ╹╺┻┛   ╹ ╹    ╹┗╸┗━╸╹  ┗━╸╹ ╹┗━╸┗━╸

if [[ $# -eq 0 ]]; then
  echo "No arguments given. Exiting."
  exit 0
fi

find_pattern="${1:-.}"
path="${2:-.}"

ag() {
  command ag --follow --hidden --ignore .git --silent "$@"
}

ag --stats-only "$find_pattern" "$path"

echo && echo -n "Would you like to review the matches? [Y/n] "
read -r answer

if [[ "$answer" != "N" && "$answer" != "n" ]]; then
  ag --color --heading --width 256 "$find_pattern" "$path" | less
fi

echo -n "Replace with: "
read -r replace_with

mapfile -t matching_files < <(ag -l "$find_pattern" "$path")
sed -ri "s/$find_pattern/$replace_with/g" "${matching_files[@]}"
