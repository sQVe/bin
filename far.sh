#!/usr/bin/env bash

#  ┏━╸╻┏┓╻╺┳┓   ┏━┓┏┓╻╺┳┓   ┏━┓┏━╸┏━┓╻  ┏━┓┏━╸┏━╸
#  ┣╸ ┃┃┗┫ ┃┃   ┣━┫┃┗┫ ┃┃   ┣┳┛┣╸ ┣━┛┃  ┣━┫┃  ┣╸
#  ╹  ╹╹ ╹╺┻┛   ╹ ╹╹ ╹╺┻┛   ╹┗╸┗━╸╹  ┗━╸╹ ╹┗━╸┗━╸

if [[ $# -eq 0 ]]; then
  echo "No arguments given. Exiting."
  exit 0
fi

match="${1:-.}"
path="${2:-.}"

ag() {
  command ag --follow --hidden --ignore .git --silent "$@"
}

ag --stats-only "$match" "$path"

echo && echo -n "Would you like to review the matches? [Y/n] "
read -r answer

if [[ "$answer" != "N" && "$answer" != "n" ]]; then
  ag --color --heading --width 256 "$match" "$path" | less
fi

echo -n "Replace with: "
read -r replacement

mapfile -t matching_files < <(ag -l "$match" "$path")

sed -ri "s/${match//\//\\/}/${replacement//\//\\/}/g" "${matching_files[@]}"
