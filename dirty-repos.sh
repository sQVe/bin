#!/usr/bin/env bash

#  ╺┳┓╻┏━┓╺┳╸╻ ╻   ┏━┓┏━╸┏━┓┏━┓┏━┓
#   ┃┃┃┣┳┛ ┃ ┗┳┛   ┣┳┛┣╸ ┣━┛┃ ┃┗━┓
#  ╺┻┛╹╹┗╸ ╹  ╹    ╹┗╸┗━╸╹  ┗━┛┗━┛

repositories="$(fd --hidden --exclude ".{builds,local}" --type directory '^.git$' . | sed -r 's/\/.git$//')"

if [[ -z "$repositories" ]]; then
  echo "No repositories found. Exiting."
  exit
else
  echo "Found $(echo "$repositories" | wc -l) repositories. Checking status..."
fi

dirtyRepositories=()
for repo in $repositories; do
  if [[ -n "$(git -C "$repo" status --short)" ]]; then
    dirtyRepositories+=("$repo")
  fi
done
dirtyRepositoriesList=$(printf '  %s\n' "${dirtyRepositories[@]}")

if [[ -z "$dirtyRepositoriesList" ]]; then
  echo "No dirty repositories found."
else
  echo "Found $(echo "$dirtyRepositoriesList" | wc -l) dirty repositories:"
  echo "$dirtyRepositoriesList"
fi
